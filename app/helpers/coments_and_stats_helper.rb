module ComentsAndStatsHelper
  def nr_participanti(eval_id)
    asoc = Asociere.find_by_id eval_id
    EvalCompletata.where(curs_id: asoc.curs_id, semestru: asoc.semestru, an: asoc.an).count
  end

  def voturi(eval_id, qindex, no)
    asoc = Asociere.find_by_id eval_id
    squery = []
    (1..no).each do |rindex|
      squery << "(select count(id) from eval_completate where (continut -> '#{qindex}') = '#{rindex}' and curs_id = #{asoc.curs_id} and semestru = #{asoc.semestru} and an = #{asoc.an}) as r#{rindex}"
    end
    query = "SELECT #{squery.join(', ')}"

    resp = EvalCompletata.connection.execute query
    resp.first.values
  end
end
