extension NumToChinese on num{


  String toChinese() {
    final List<String> _chineseNums = [
      '零', '一', '二', '三', '四', '五', '六', '七', '八', '九'
    ];
    return toString()
        .split('')
        .reversed
        .toList()
        .map((c) => _chineseNums[int.parse(c)])
        .join();
  }
}