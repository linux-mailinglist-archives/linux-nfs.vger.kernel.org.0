Return-Path: <linux-nfs+bounces-11783-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7403AABA4C3
	for <lists+linux-nfs@lfdr.de>; Fri, 16 May 2025 22:38:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD3139E26E2
	for <lists+linux-nfs@lfdr.de>; Fri, 16 May 2025 20:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 904A927FD4E;
	Fri, 16 May 2025 20:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="et/GjDEQ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2115.outbound.protection.outlook.com [40.107.94.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1383227D776;
	Fri, 16 May 2025 20:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747427913; cv=fail; b=NK0xejPoGx5lfoQJiXee5g0AqDAaBbwVfcgfmU8iVsbU5A3lgqtlM/a2BOFtmj6CHNVhzZRB3GKJXEFNOI4qNyMNQObYOHpOuiGsiRH6xJ9JHU1bRs7Fax2/Zt/fyJcMQcOUH63x2GzYNf1gbYLrsYdhNM39X7I3R/lse8DjgEA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747427913; c=relaxed/simple;
	bh=y2W80HkuKnM47oRrPsjctnV2rsjwDXYRRCXKFLovVHU=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=sp77lX0fHqdGFcukaSn7IAarJ7gsNmdFNp17d/s7QpCpiW3TgsycMccJOAEpGZqQfvzoEp/S9lCQTfWS/yd0KYZ8mdxkN/jwMoO3AyJ18GwA5OsQgMPBkhwQtdj/V/+D+mn3rq474I9/5k7DfrGgbBX4cQd/dX7atxSZ1ranaJM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=et/GjDEQ; arc=fail smtp.client-ip=40.107.94.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p2JEz05xQYSCkIQC3IUWTqBTnGYhvkgTejfF71Qrn/U/hDgQh+u0+gUpmOKjZMUU94HecewNgnZumcvuadeZ4auX7yc6GRpInFWEG/R1h4TnQ+WwrCNVxWHOPw2Z7wLsjDPdK08J/JswB+bLelyRtYfV41LlZzimqWFMOyVRP90hcVT0oCCXmhxkIBYy9pd2/YCrDsb/RUMx93UpcbNd5Ib3JwihaEEqkPNzV5QCJWYWEYpV3N99BqL1hrWi+o8716txBChZlwZ4tBT6UNTNIegh9wYf7cWPCI881tN+PuhI8tk9qjJOsoe6RtQ5xQpfFJQTbag1OzefwZ3hX688TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y2W80HkuKnM47oRrPsjctnV2rsjwDXYRRCXKFLovVHU=;
 b=Y3m8IWwV9CncDKKYqGHDIZZi79Q8Mg7fD3OUba9PpjZugzfRj1dG0Pa5qoM9rjTd22aQXXiPmq93Y4OQnfa4hV7CGpRDIi0zRwKpfZuZtB6Qn9tpsOW09CBnIyP60LgsYD+4U06TQkvEjEBsFppwbmUp10d+Ym1Y1R/KXcdShZTJyKygVAWTOTDZiFlGMgUtr1miTu5tP99voYoZ31z6S+f/Kfl5lgZrimHbj6Cg6NpxcVqFp2+pKgfJURlQ9ZgsqH3umzpIMhqsoIpf59fDKzHoKhEGt7vg260ABDsmorMXwS0tFIXKt/r8Y+q4lVz1m63wCljxpOHRWPLYBJ7fYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y2W80HkuKnM47oRrPsjctnV2rsjwDXYRRCXKFLovVHU=;
 b=et/GjDEQPTamtpRr5jECge0+0wBvx4dndO+JiAcAigQiug/Q/9dRorxyIQUca/bs9kX13/duuLd9b6cy6mMkZbLmjxlVQvJIgW18yZnFXumX1/J33M1Sr603sdgASRseBcZ7PBpNxofePgZPa/vJW4fsQAaR0iyVYNF4CF8d97k=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by SA1PR13MB5040.namprd13.prod.outlook.com (2603:10b6:806:1a1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.32; Fri, 16 May
 2025 20:38:27 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb%7]) with mapi id 15.20.8722.027; Fri, 16 May 2025
 20:38:27 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>
CC: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] Please pull NFS client bugfixes for 6.15
Thread-Topic: [GIT PULL] Please pull NFS client bugfixes for 6.15
Thread-Index: AQHbxqJ66SjRwuicd0WgkTKoeJu06Q==
Date: Fri, 16 May 2025 20:38:27 +0000
Message-ID: <983483fc86a4059a33e11968387f2faca29413ab.camel@hammerspace.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|SA1PR13MB5040:EE_
x-ms-office365-filtering-correlation-id: 81b4ddc2-4f38-43bb-a1f8-08dd94b99cb6
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NXFheW8xQ2ZpZ055TmpJT1ZIckxDZXlDZzltNkxWYTg3RnRLQWFLUVFXN0l3?=
 =?utf-8?B?aWh1Z1QrVEx1M1dsZEtCNjhxWldEcEx2U2haOGZ3bEtnTHBuY1FXK1FLVVZp?=
 =?utf-8?B?TUdTYzdIZVIrREQrY3d5VE1hNnZmTHVSbkNQUXgydzhEejdORWRHc3pyVHVN?=
 =?utf-8?B?VXJmR3ZrQ0JhaTZkWld0cmhpQkxWVUk3bjQwNGtweHRzejAwNlFmSGVxQThC?=
 =?utf-8?B?eG13S3hOQXR2aTJBTnZVYWgxNElheEYzL0xFYXFmNC83RW9OMFY4ZFF4R1dj?=
 =?utf-8?B?bHYxdkZKL0t5NnVBU0sxRVRrQkYvRnEwaWhnbVdyck44YjhJNlRTWTZrQmZk?=
 =?utf-8?B?VE9HUkNXYlB3bnlHQTRSUjRHcm1ZNE9HRFJtYzhSaVpGZ09EWFl4d2xwdS9k?=
 =?utf-8?B?NGRQYmFJeno4a2hMRjFkdGNFakY4RmlpR2RVZE9DdWxUNU1WQ2s5VFJ1TnMw?=
 =?utf-8?B?VWlSS3NkV3NTcFROS3RLUmNYTnhodXEwRDdFTGVJTW9IdUpSYllicnNjZ3R0?=
 =?utf-8?B?SzYvVmR2Ulk3aE5BZVk3VnJ5VFoxQWNiM2Q3NlkzeWMvQVpRcS82ZHlodCtC?=
 =?utf-8?B?TWdiMjl6QnJEQThlNENVT1gxVkZZUisxa0h5TFgwdEVPZENsNUl5SndvcHFY?=
 =?utf-8?B?UnpQZ3YxeTJySkc4ZFNMZk14TjRvUDRQVXh0UG03UU9iUmJoamFicG94eU51?=
 =?utf-8?B?bFVFNTVuQzIzR3VMSUhZcUtjMHZ3cFFzdEdtanJ5cmVZVDNxV2NjRTRSakxh?=
 =?utf-8?B?L04xZVowQUhzZm42cWxKTE9CbEE0RHlNTlhoNHIzNmFPU1ZhV3BSVFMvVGpn?=
 =?utf-8?B?clNsdStZSUw1U25KdzBBQ3pwWTNLNlhSUDJ4d1M4YlZtS3dEbHp3OE1uR1A4?=
 =?utf-8?B?L2liTi9ic0pRZTd5LzljbVN2eGQ0V1VSeXdyc00ydTBRdlNENkFJVENWeFlM?=
 =?utf-8?B?ZVlUY3BNbE04cFVobzE3eGdDV0dEL0phZUpLeERTT2RuMHhlMFBoN0dsOFFx?=
 =?utf-8?B?ck1hMU1ZWXQ1L3NobWxGemRyTGFRQ1F2QzUrQXlpNUJ3WHNRMmNzZFJqWk9J?=
 =?utf-8?B?MUVQRllIcnpPTEdONC91RG55QS9pbWpWclorSjFlM1dYQ1B0c2Uyc0pTWDNF?=
 =?utf-8?B?SHBiV29FMXQwem5nblBLWFVwa1A4YmM3NTY0cHBqODdyNFVpMG0vbDJ3T20z?=
 =?utf-8?B?eHIvSWJnWDJ5SWErWlZMRlJqcTdWL1dCekxsU2p2djN6d2FsMnM0K1J2RVlF?=
 =?utf-8?B?REk2dm5YSHFkRGp6ZmJxRVY5a0VEUnBzclZuTFIyc3c5WE1BLzRDNkg2UXBC?=
 =?utf-8?B?Mit4NWxwMkgvdEtHeHBpZmdDRVN3M0RxSi9lemZ1TE1iYjNRTkR3TkdSYnlE?=
 =?utf-8?B?aWRSN01IUW5EQW0xUE9rYVc3anhJOG9zejJ0eEVxeWU4K0h6d1BtYWxrZXY1?=
 =?utf-8?B?TGpIV0Q1THV0cENVd2FQSmROeDRxMlRRUHg2QjhRN3VRU3lGaVJYaGFTR3dP?=
 =?utf-8?B?NUN6Mnh6OVEzVTBRMXNPT0tBc1BUblhNdEgyazN2OHc2akhzNDdONzIrdW9G?=
 =?utf-8?B?cVNIMjF0ZU03QUcxRklpR0RmREdYR25LbjBXVFp6d05LQ3NpcVNuaC9lREp1?=
 =?utf-8?B?ZEMxMW9sMTBJeFJ4cmViT1AxVUFZMk1KWTJGTmFuT2pJb3pnRnFML3FuTUdE?=
 =?utf-8?B?OVJ5MGJlTkxlMzVZU21mSXBFMGU0ZzJaMWFtVjl4M1pVbVhCcjhhRWwwWWo4?=
 =?utf-8?B?R2toTGVYN2NUZnpqZm1EQk8vU0g4UWk0NHFMeFRyZHJFN0xkekVNSWpPTFBO?=
 =?utf-8?B?VCtPRUxpbS9zYUh3MkpyZVVSZ1g1d2o4LzdvckpIczhmaEswa2NhT2Z2UkE0?=
 =?utf-8?B?VUtLTnFVYjc1MmNzczF2aGN6Y21yZmxrK3RtajFrQng4dFgzVFVzZEZUQVY3?=
 =?utf-8?B?SXE1VjVoaE9KOFJKWWthbm9BUHU5ZXpVUVdzZDN1QllUU2xuRDRscGp0U1N2?=
 =?utf-8?B?MXZDdEZZKzZBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eUVVbTBiTVZBa25mZmNHdkUyL0RDc2VRNGJYVDNLQ3VFdUdSU2R0Sk9vTS9z?=
 =?utf-8?B?Q3FLbGJReG54Ny9mY3M3UklYN09pWXNjY2pzTUNsaGxPdnA5cTNGM2p5QzUr?=
 =?utf-8?B?YnprSVJIZzIvNUp2cG5PUnZOcE1CSFo1MzFUdWpWdjBGaGV2bjZwWjFHUUli?=
 =?utf-8?B?SytOc1NKVzhnRndRcmNaemYrQ1FLNWNIb2piT3U5a0lOUHB0VitsSWI1clF3?=
 =?utf-8?B?NEVLZnVnTlU3NzJlN24yUjMxaXJyVldIeDlVeDFRd2lQeEJLalJzZUZoVXZF?=
 =?utf-8?B?UkJDTmZ5ODltb3F0UWczZ0JHYWl5allvUmxyNGNuZENQRTBNakE4ZndFek5j?=
 =?utf-8?B?aDR3c2FsUFFDaHpqQi84VjFPTDdnTDI3K0F3MmZZcUFqQXhCNVc0R2pGWUxu?=
 =?utf-8?B?MUZCaE02cjN1K3d4TGFCSklnNHJOYU5PdlowcWUzWVNDMktqdHdjeW84eFVx?=
 =?utf-8?B?NEIxaDlTT2xyM3kzTGRneC80SjZQcVZTT1l2bHRER1lZaWNwMTdzUzNndnJR?=
 =?utf-8?B?Mk8vc0V3ZUJWWFlaeS9qYzFZTUtvVk5zY0VUZHArUEJsS0dkQUJQUEwzS1hQ?=
 =?utf-8?B?SXg3V3VSQnlTRlpSdDlWTkRGeTJWa0I3QitZVmhEZ2dodFhiaEh1YjdaYlZN?=
 =?utf-8?B?Vk9vd1Z3MlhjM0lXcW5OVG1EUVVKaVhSZmlpTXpIN1pjQXhZanpNNFF2WE0r?=
 =?utf-8?B?cExZUGdDemg2YWJnQ2hEd3h1MmxNdmc4TTI5UzBTLy9IbFFiYlRraVcvdlkz?=
 =?utf-8?B?WlRUakgyMktoWEVOR3NKcUlhbkR3cU8vVGYwaGFzeDhiQ29zYkJ0ejRVc21a?=
 =?utf-8?B?YzRHSUU5WDBPT3RnbEEyUCtqeGRGeEJCUWtDZUhMOGZCL3RFeUtqUTZqOGpO?=
 =?utf-8?B?c1N2WUEvTXBYVWpjZlJ4eHNCaW04NFR4enFjOGRTZkIwcUx5ZEp0OXJrNnFZ?=
 =?utf-8?B?WHF6NzNYME12cURxd2ttNmlMN3JyVmdERmtzcEhJS3VGenljQWJtVVdIbUMz?=
 =?utf-8?B?b2lIRzJIOXljTnR6ZVpUTThhdHVpY05MVDE0VFM0MVp1ZS9KaEtMYzRhWXdr?=
 =?utf-8?B?YjNnNFE5TjRoby9Wc0U4Qk11cEJzZGtnbG5nZUFVQTRtS0dadmJIc3YwK00w?=
 =?utf-8?B?SlFNalRteXFiUlpBb2djOW83UmErUUFSdnpldjQ2OWxhSUU2cVdhaDZqYkVV?=
 =?utf-8?B?WnV0MFd4WnJQVUJ5L25BV1NhQTFsZ25NL051U3RRL2c0Vm82bUhrL2FnVzJG?=
 =?utf-8?B?VjR6cTV4QmxmY2pTYmJFYWlkYnpZd1QxWUJaYUw4bFBnRE9UV0w5VlNKb1pv?=
 =?utf-8?B?M0JBYU1RVURZRjU1NHN5dlA4V0lHMkxZOFBsTGdhWWdBSUt4U3lYTzFtNHdx?=
 =?utf-8?B?ZkhMWEliNjQyZnlLN1ROYUpqZFNqNUhseXFDSlpxYlhMblVjSGRvY2xjSUZw?=
 =?utf-8?B?aHUxZTlWQVRjTjB0UGgxNUFWVXVzb0RwSkk2K05jd3o1Qjl3WHlhUHFrbVoy?=
 =?utf-8?B?WHc0Y05zeHVXaFk1Z0Rrak8wcDFWTzFRcjRwcE9FcjI0cTJQS1RJZVdINnlv?=
 =?utf-8?B?RjQxdUxrc1ppbGh2eUo0enJvakRrb2lTNnN1TFc3UjJkR0xnQy9RYTNIMHI1?=
 =?utf-8?B?NWJwa0RkSlRDdVpraG1kMVlWK0hqMEdkK0QwbWxLT3pPOCtabG96YjBxTDNW?=
 =?utf-8?B?eVZLek1DZzZsYmVJUUpVaW5UcTVqTVBFdDBQU2Jodjhib1dFZUNob3dmSGZn?=
 =?utf-8?B?TFFZTnU5ZHcxdGY5OHFRQWk5VkJ3bkRJTFVvaGtueWhESG1MTFpxL0hoakps?=
 =?utf-8?B?TDBwMmRFcHFtODV4c0x6OGxNdkIrZ1FIUGR1S1RwejJjVUl4ME8zS2NOempa?=
 =?utf-8?B?dXhhYi8rS3RtZXN0UnRTSE5OVlZBZUZDUDhpTmFuNStXakRzUlZZTGYyYXJ6?=
 =?utf-8?B?K1ZWekhMODNDdDFES3ZiM2pQL1liTmwxYm14aStXZTc3ZjVoSlpSa0p1Ujhq?=
 =?utf-8?B?U0JhMTNvQXVodzd4U1VLZVBvQnRtSEZkVU8vQ244ZUpOb1dnVGRQbTh0bG1y?=
 =?utf-8?B?ck4ra3FveUlkUk5hL0M1SlY2UnpScERwYkNwK1Nla0YyckNwWWxJMWYxQ285?=
 =?utf-8?B?T0RSL0FnNDZQMnB4Q3JxZ08wd2pOZjIxRitWczhLMG1POVRnQmFPNTFHR1RV?=
 =?utf-8?B?U2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BC2D34FE561F874196DBE6B4712C838A@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81b4ddc2-4f38-43bb-a1f8-08dd94b99cb6
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2025 20:38:27.5237
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +Lua+Pq9xD+Gva71FpTx/bovv/w5ajwnHkZoSs24uI676qmzlq9pNcE4AC+UOCs87Ohn0TYK/0ZgQ+bGn6opOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR13MB5040

SGkgTGludXMsDQpUaGUgZm9sbG93aW5nIGNoYW5nZXMgc2luY2UgY29tbWl0IGI0NDMyNjU2YjM2
ZTVjYzFkNTBhMWYyZGMxNTM1NzU0M2FkZDUzMGU6DQoNCiAgTGludXggNi4xNS1yYzQgKDIwMjUt
MDQtMjcgMTU6MTk6MjMgLTA3MDApDQoNCmFyZSBhdmFpbGFibGUgaW4gdGhlIEdpdCByZXBvc2l0
b3J5IGF0Og0KDQogIGdpdDovL2dpdC5saW51eC1uZnMub3JnL3Byb2plY3RzL3Ryb25kbXkvbGlu
dXgtbmZzLmdpdCB0YWdzL25mcy1mb3ItNi4xNS0yDQoNCmZvciB5b3UgdG8gZmV0Y2ggY2hhbmdl
cyB1cCB0byBkY2QyMWI2MDlkNGFiYzczMDNmODY4M2JjZTRmMzVkNzhkN2Q2ODMwOg0KDQogIE5G
UzogQXZvaWQgZmx1c2hpbmcgZGF0YSB3aGlsZSBob2xkaW5nIGRpcmVjdG9yeSBsb2NrcyBpbiBu
ZnNfcmVuYW1lKCkgKDIwMjUtMDUtMTYgMjI6MzE6MzUgKzAyMDApDQoNCi0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCk5GUyBj
bGllbnQgYnVnZml4ZXMgZm9yIExpbnV4IDYuMTUNCg0KQnVnZml4ZXM6DQotIE5GUzogRml4IGEg
Y291cGxlIG9mIG1pc3NlZCBoYW5kbGVycyBmb3IgdGhlIEVORVRET1dOIGFuZCBFTkVUVU5SRUFD
SA0KICB0cmFuc3BvcnQgZXJyb3JzLg0KLSBORlM6IEhhbmRsZSBPb3BzYWJsZSBmYWlsdXJlIG9m
IG5mc19nZXRfbG9ja19jb250ZXh0IGluIHRoZSB1bmxvY2sNCiAgcGF0aC4NCi0gTkZTdjQ6IEZp
eCBhIHJhY2UgaW4gbmZzX2xvY2FsX29wZW5fZmgoKS4NCi0gTkZTdjQvcE5GUzogRml4IGEgY291
cGxlIG9mIGxheW91dCBzZWdtZW50IGxlYWtzIGluIGxheW91dHJldHVybi4NCi0gTkZTdjQvcE5G
UyBBdm9pZCBzaGFyaW5nIHBORlMgRFMgY29ubmVjdGlvbnMgYmV0d2VlbiBuZXQgbmFtZXNwYWNl
cw0KICBzaW5jZSBJUCBhZGRyZXNzZXMgYXJlIG5vdCBndWFyYW50ZWVkIHRvIHJlZmVyIHRvIHRo
ZSBzYW1lIG5vZGVzLg0KLSBORlM6IERvbid0IGZsdXNoIGZpbGUgZGF0YSB3aGlsZSBob2xkaW5n
IG11bHRpcGxlIGRpcmVjdG9yeSBsb2NrcyBpbg0KICBuZnNfcmVuYW1lKCkuDQoNCi0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0N
CkplZmYgTGF5dG9uICgyKToNCiAgICAgIG5mczogZG9uJ3Qgc2hhcmUgcE5GUyBEUyBjb25uZWN0
aW9ucyBiZXR3ZWVuIG5ldCBuYW1lc3BhY2VzDQogICAgICBuZnM6IG1vdmUgdGhlIG5mczRfZGF0
YV9zZXJ2ZXJfY2FjaGUgaW50byBzdHJ1Y3QgbmZzX25ldA0KDQpMaSBMaW5nZmVuZyAoMSk6DQog
ICAgICBuZnM6IGhhbmRsZSBmYWlsdXJlIG9mIG5mc19nZXRfbG9ja19jb250ZXh0IGluIHVubG9j
ayBwYXRoDQoNClNlcmdleSBTaHR5bHlvdiAoMik6DQogICAgICBuZnM6IGRpcmVjdDogZHJvcCB1
c2VsZXNzIGluaXRpYWxpemVyIGluIG5mc19kaXJlY3Rfd3JpdGVfY29tcGxldGlvbigpDQogICAg
ICBuZnM6IG5mczNhY2w6IGRyb3AgdXNlbGVzcyBhc3NpZ25tZW50IGluIG5mczNfZ2V0X2FjbCgp
DQoNClRyb25kIE15a2xlYnVzdCAoNyk6DQogICAgICBORlN2NDogSGFuZGxlIGZhdGFsIEVORVRE
T1dOIGFuZCBFTkVUVU5SRUFDSCBlcnJvcnMNCiAgICAgIE5GU3Y0L3BuZnM6IExheW91dHJldHVy
biBvbiBjbG9zZSBtdXN0IGhhbmRsZSBmYXRhbCBuZXR3b3JraW5nIGVycm9ycw0KICAgICAgcE5G
Uy9mbGV4ZmlsZXM6IFJlY29yZCB0aGUgUlBDIGVycm9ycyBpbiB0aGUgSS9PIHRyYWNlcG9pbnRz
DQogICAgICBORlMvbG9jYWxpbzogRml4IGEgcmFjZSBpbiBuZnNfbG9jYWxfb3Blbl9maCgpDQog
ICAgICBORlN2NC9wbmZzOiBSZXNldCB0aGUgbGF5b3V0IHN0YXRlIGFmdGVyIGEgbGF5b3V0cmV0
dXJuDQogICAgICBORlMvcG5mczogRml4IHRoZSBlcnJvciBwYXRoIGluIHBuZnNfbGF5b3V0cmV0
dXJuX3JldHJ5X2xhdGVyX2xvY2tlZCgpDQogICAgICBORlM6IEF2b2lkIGZsdXNoaW5nIGRhdGEg
d2hpbGUgaG9sZGluZyBkaXJlY3RvcnkgbG9ja3MgaW4gbmZzX3JlbmFtZSgpDQoNCiBmcy9uZnMv
Y2xpZW50LmMgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICA5ICsrKysrKw0KIGZzL25mcy9k
aXIuYyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgMTUgKysrKysrKystDQogZnMvbmZz
L2RpcmVjdC5jICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgMiArLQ0KIGZzL25mcy9maWxl
bGF5b3V0L2ZpbGVsYXlvdXRkZXYuYyAgICAgICAgIHwgIDYgKystLQ0KIGZzL25mcy9mbGV4Zmls
ZWxheW91dC9mbGV4ZmlsZWxheW91dC5jICAgIHwgIDYgKystLQ0KIGZzL25mcy9mbGV4ZmlsZWxh
eW91dC9mbGV4ZmlsZWxheW91dGRldi5jIHwgIDYgKystLQ0KIGZzL25mcy9sb2NhbGlvLmMgICAg
ICAgICAgICAgICAgICAgICAgICAgIHwgIDIgKy0NCiBmcy9uZnMvbmV0bnMuaCAgICAgICAgICAg
ICAgICAgICAgICAgICAgICB8ICA2ICsrKy0NCiBmcy9uZnMvbmZzM2FjbC5jICAgICAgICAgICAg
ICAgICAgICAgICAgICB8ICAyICstDQogZnMvbmZzL25mczRwcm9jLmMgICAgICAgICAgICAgICAg
ICAgICAgICAgfCAxOCArKysrKysrKysrLQ0KIGZzL25mcy9uZnM0dHJhY2UuaCAgICAgICAgICAg
ICAgICAgICAgICAgIHwgMzQgKysrKysrKysrKysrKy0tLS0tLS0tDQogZnMvbmZzL3BuZnMuYyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgfCA1MSArKysrKysrKysrKysrKysrKysrKy0tLS0t
LS0tLS0tDQogZnMvbmZzL3BuZnMuaCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgNCAr
Ky0NCiBmcy9uZnMvcG5mc19uZnMuYyAgICAgICAgICAgICAgICAgICAgICAgICB8IDMyICsrKysr
KysrKystLS0tLS0tLS0NCiBpbmNsdWRlL2xpbnV4L25mc19mc19zYi5oICAgICAgICAgICAgICAg
ICB8IDEyICsrKysrKy0tDQogMTUgZmlsZXMgY2hhbmdlZCwgMTQzIGluc2VydGlvbnMoKyksIDYy
IGRlbGV0aW9ucygtKQ0KDQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50
IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29t
DQo=

