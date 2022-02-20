package com.hoge.vo.other;

import lombok.Data;

@Data
public class Amount {
	private Integer total, tax_free, vat, point, discount;
}
