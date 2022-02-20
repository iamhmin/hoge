package com.hoge.vo.other;

import java.sql.Date;

import lombok.Data;

@Data
public class KakaoPayApprovalVO {
	private String aid, tid, cid, sid;
    private String partner_order_id, partner_user_id, payment_method_type;
    private Amount amount;
    private CardInfo card_info;
    private String item_name, item_code, payload;
    private Integer quantity;
    private Date created_at, approved_at;
}
