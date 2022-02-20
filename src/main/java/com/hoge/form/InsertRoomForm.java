package com.hoge.form;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class InsertRoomForm {
	
	private int accommoNo;
	private String name;
	private long weekdaysPrice;
	private long weekendPrice;
	private long peakSeasonPrice;
	private int standardNumber;
	private int maximumNumber;
	private long pricePerPerson;
	private String amenity;
	private String feature;
	private List<MultipartFile> roomImages;
	
	private int hostNo;			// 리다이렉트에 필요한 값 히든으로 받아옴
	private int hostingType;	// 리다이렉트에 필요한 값 히든으로 받아옴

}
