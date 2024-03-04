Return-Path: <linux-nfs+bounces-2157-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C94E86F9FD
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Mar 2024 07:20:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B04131C20C7E
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Mar 2024 06:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE233DDB1;
	Mon,  4 Mar 2024 06:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="aGaAM7Uh"
X-Original-To: linux-nfs@vger.kernel.org
Received: from esa17.fujitsucc.c3s2.iphmx.com (esa17.fujitsucc.c3s2.iphmx.com [216.71.158.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB15DDBB
	for <linux-nfs@vger.kernel.org>; Mon,  4 Mar 2024 06:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.158.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709533250; cv=fail; b=A1URSqbAHWqV9RTn0xObJkBqcLc6PI6WdQbawI9FUJsM4y704qhoFDGYJyxFarDOJ84PimiyeHptQj9056lo2sD/dUYcoML6y50bUy4hHHZ5x57jhXTtZuW2TBGYvoGhItcUt5hWLea+FD9VKzAsWtU++k8MFYLbiIKKuXD1E3k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709533250; c=relaxed/simple;
	bh=YgIhJ3CaWJPfxLEIm6bxBgbaWxgCoHuNZsdSNeavNW8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YDi+5VVCWBTMfFYKQ441PlpZ85BVk4zQvVGM/a8y28XNn7vCBYzATIJytjukWfFemJLJdgj9v6ZIeHjhLXE8v4XQzEnTPFs7DZo+K7i/lyuM/y3iHOeNrwM9NEiOXlSv8/hnHyMcB6mdsZFZVIIY84t3SuYT5yKusyBJ/zkXyTM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=aGaAM7Uh; arc=fail smtp.client-ip=216.71.158.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1709533249; x=1741069249;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YgIhJ3CaWJPfxLEIm6bxBgbaWxgCoHuNZsdSNeavNW8=;
  b=aGaAM7UhPuE/3K3DpO4HSvnTp8EdzQYcDPebqDld/DVg7SzZeGXnBv82
   SQ2KW6YukTrDP2X30b9T5zizsyIahCOduYn+WiYflAGlE3xaAyvzI4ibQ
   IG7+ZQMDh0/0ZF7PFOQ5v2hGH2wLlOn72atkX4xsFLLZlYKiwp57YsXTr
   ktzUY6J1MIvL4ggRK94FiuPqP+m8jTkRyWndwLlmbLtoE3q7DFhJo9LRO
   Fx6makLxQ4nZ7iQTCqyS8iU3wbE3UJWkYrxQqd4avKSYWhr7JU/mC02pj
   WgT3wC747iewVBLI+6nau//fPm0B+DG5I5tH7w9hj0+wlSP61bfoIaNO7
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11002"; a="112826983"
X-IronPort-AV: E=Sophos;i="6.06,203,1705330800"; 
   d="scan'208";a="112826983"
Received: from mail-os0jpn01lp2104.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.104])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 15:20:33 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AWAW+Wo/yvcEOn3nhqxdPSXGUMPWp4H38AwdXjkEuHT0dwd7wWloP3aPDMB0FJt5+UD7kM7L3ZPng8cERZdfao1AEPuTnOpIvrHtNONBZ2cf9orjShWyWi6BOMkbj7cT5L9xIH+7klfb2mNGOJcNfiU4pM7fG5//Z5HxPR+mZLgPCO1dLzMPPq1NgLyCQeZC3vQcmmBFhTH4CcA1M9d5/9G8j4UnD5J//sOZXrwEch36tl9M14ofd75B9eqsRRVVrGXZ6BCOlsC/h4ZBxZ8OuVVjw9OMiNMMTHF142KN8giVMlvJdNw6awqT9tIQ6knDiQOm+a6BRVaHn7OiF4R+Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YgIhJ3CaWJPfxLEIm6bxBgbaWxgCoHuNZsdSNeavNW8=;
 b=lZexdhVIWqoK50I9ZOWQD3IGOEV5jU7PXcjj3NtpPuUsUlkSeA8lGfwmpOBPygS9xqtFChFkr6OAnW2QrKEDCGrOH/j4X2uyR3qnb7IVNyWzO/HGVR7sAIocBhwLAA1LAVnxmKgG6vBv/r0wQz5su1+5zmfBj/1Cslr5UeQI7Q1Nw47Hgw9y5SZ1wHlJ3wSPR+u8zBBwHVmBkRAJKLfIbBEJ6wdESIUxD/EOGnDb1QRklVChAMvub6p8L09fFrTVTr4wTgpZCkpX6OhX0FTclY8rQPdxFyvDPFwWEL+f0IedR3UDGoqjrdhO2cgMVRfkWLd8QbnFzVAPSL8kf8okeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYWPR01MB12085.jpnprd01.prod.outlook.com (2603:1096:400:447::5)
 by TY3PR01MB11056.jpnprd01.prod.outlook.com (2603:1096:400:3b4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Mon, 4 Mar
 2024 06:20:25 +0000
Received: from TYWPR01MB12085.jpnprd01.prod.outlook.com
 ([fe80::d966:f2b7:cccb:3485]) by TYWPR01MB12085.jpnprd01.prod.outlook.com
 ([fe80::d966:f2b7:cccb:3485%5]) with mapi id 15.20.7339.035; Mon, 4 Mar 2024
 06:20:25 +0000
From: "Hanxiao Chen (Fujitsu)" <chenhx.fnst@fujitsu.com>
To: Dai Ngo <dai.ngo@oracle.com>, "chuck.lever@oracle.com"
	<chuck.lever@oracle.com>, "jlayton@kernel.org" <jlayton@kernel.org>
CC: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject:
 =?gb2312?B?u9i4tDogW1BBVENIIHYyIDEvMV0gTkZTRDogc2VuZCBPUF9DQl9SRUNBTExf?=
 =?gb2312?B?QU5ZIHRvIGNsaWVudHMgd2hlbiBudW1iZXIgb2YgZGVsZWdhdGlvbnMgcmVh?=
 =?gb2312?Q?ches_its_limit?=
Thread-Topic: [PATCH v2 1/1] NFSD: send OP_CB_RECALL_ANY to clients when
 number of delegations reaches its limit
Thread-Index: AQHabbltWnxrEJh6q0yMjcZAJXAwU7EnHHaA
Date: Mon, 4 Mar 2024 06:20:25 +0000
Message-ID:
 <TYWPR01MB1208549B48EDF775F2C976AF9E6232@TYWPR01MB12085.jpnprd01.prod.outlook.com>
References: <1709504582-8311-1-git-send-email-dai.ngo@oracle.com>
In-Reply-To: <1709504582-8311-1-git-send-email-dai.ngo@oracle.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ActionId=8f9646be-6cec-47ac-80db-7eefdec32434;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ContentBits=0;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Enabled=true;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Method=Privileged;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Name=FUJITSU-PUBLIC?;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SetDate=2024-03-04T06:19:52Z;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB12085:EE_|TY3PR01MB11056:EE_
x-ms-office365-filtering-correlation-id: 42d665d5-078c-4164-b5a6-08dc3c132e3f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 nDLIhKeDL2cUmWxCym9ifSYy820yh3ohYAoiUzv+6cBGctjo/SKxS4fEkgMdhzZ70hj2n73CT7LFadsPW01dJIyR3btWkD1OcFFZ6MypHFQnYCCBnYvydkwCVw+hP3ZWotYlbr+23kVetPUp+TFhtpSicmzq0AXOLje7IDodPN5+nWarmMCR1dQYslcy6yPGnnFYzgQFEpTwPpO0OkNHg8kodEkjhG8wUOFZKB6o/+Yzh+hff/P+1fob2yNQUClhcyXXDbWC3r2k9/86+Qv5UAycDkfFyqyrkH3mb17sCDT4Htf+je/+OoHuh8EtkB6OXt1XeXqqqBLZ0g8bJmKDthhBkKviitLqwj6y/K+9ck3O8b9nvAPx3AiP9Od3f4YQfzn/DjyUg75ASRgVbOovmR42Glv7Y68iYjBXWmIJl9Epc7t/uVbtOnOj7dL3fw/cO9fDFNv37smcoDEAu00TAGjvOBUQZYgAd0B53xBJ9xj14Bw8Rq1opIwSUgfT/KKRRPAr3P3q9jnPzko7ubHeRa8OPUM3GXcCvbdrBpjRmetIJGhG5rvC7l+KsMESNVelgWPfplCMe52w66iN6u7uISTQkjNcxm4s5VM9I3s2VeyBH3GRpyRSXnQcrK4pyQwnqXHF6nBmsAxh+TkzTZv/HCJpTuRDSJoaw8+zbGxmreWb13pbADpKswfE6LcxYQ292G92KSHG4jkm//yG0ubrr0Zy067AytHxxtjNQ9W2PCb7Ua8FCurTHqdzLXkxa3zi
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB12085.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1580799018)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?Zk93NEFwS2VjaVdZOTNOSzRzYzIxNlJyL3phMCtycDdsUFcvVC9pZGVNdE0r?=
 =?gb2312?B?cldzQ013U1JvVDMzbjBKNXJIWEVjZDYvVlhjbUlBdWJIY0NTTE1lMk9vZkJH?=
 =?gb2312?B?MmxVLzZiZHlFaEMzRE1zcjJKdHBoYTVhL0xrUk94QVF1NEdMS0wxTUxueDRv?=
 =?gb2312?B?ZFJuVUlCTG16S0tRNU1ScXV0SlBLa01wSjBiM1JaK1pYUGxIWEc1aGFTTUxM?=
 =?gb2312?B?OW1jL3Q0bHdDV01GRUFqOW1MVVlSaVJ4R3E0ZEZEbjF2MnZMalhucGRadFda?=
 =?gb2312?B?amJwMExZNmZNdXNiV2N3blUvc1FSNzhQTWRDa2N0RnJUQVVqdmh2ZDc5eklL?=
 =?gb2312?B?N3ZtalNMSUxKblRmWjM0TWhMekoxdFZkd3F4NkptZ1NhNVdMalhaT3RrWExa?=
 =?gb2312?B?bUNJc0VBdUZzc2FYcjNoMWlIUXR4bjFXVE0xN3ljSFNHNEhOUE1Za3NaeFEx?=
 =?gb2312?B?Ylp1YXVDT1ZOSGlDN1BYZncvZ2hRalE3YkRoazZqeExwdGRHRnlwOGV5c0k0?=
 =?gb2312?B?a3VteFN0dWx3QU1rWWdLcGFCZDJxMFZodkdIS1dZYkpSbk9jTTk0WWxZaURi?=
 =?gb2312?B?R1V1K0hlSjBGeEZ4aTNZTG1sWnVLRjVjbXBoaWJ2dnZYVHVqaGpOL3BQbFJE?=
 =?gb2312?B?a0lwc2ZNbDRyYU1VSFplUDVwenlWMGovSURTS0N4SHNsdlRYbFFmQlpQT1JW?=
 =?gb2312?B?MGFjNHRUbU50aVpYUHFkZWpVaHpsK3JDWHB5UldGNXlWSjMwYnNsMGsxcnB4?=
 =?gb2312?B?N0RaSit6c1BacVowVU5jNHlUcmNvaW12Vkw0ck1QLzFJUDY2NG9PN1BvdVVL?=
 =?gb2312?B?YkxsR2pCZHQzU1QzdFB0TTJScVZqczk2akp1MU82YmFUS0lZaUhzaG1NbDlw?=
 =?gb2312?B?TzdmVzlocHZETmdIM2lvZ0VRcEtZRm1sczVyTlJhNnFudzY5T1d4Rm1iVDMw?=
 =?gb2312?B?dXRkN24vWjlzR0VsQlZxYU40UStEd2ZOTU9QTW5ieW1FTElxNnFGSUp3ZFJU?=
 =?gb2312?B?RHh6ODBoU0RRdk1ORG1IWjF3dzkyaG1Dd2RJTkUrcnl2SGZUMVhwWVBMcTNW?=
 =?gb2312?B?TUhmWUJxM2Z5bVJhYXhLbXQ5Z0kwMnR3dzJDbXRtM3VOdGpOVVN0cGZBTC9X?=
 =?gb2312?B?dEVKQ3BEY1pTWnJnakRqSjFaL3o1eXE5K2pBdVdseE1landBMVN3MVdSL1Rp?=
 =?gb2312?B?V2VwMGdZc1Ivdy9vcmRhUjRicE1oQnhab3l2VnJHWDZZb2RxTHlJZ2dEVDZt?=
 =?gb2312?B?Mm1CY3ZYTVZhTzI5bGJjb0FselNQUzdHVjI3Rm9mUDYzU2N6SDVlaXEvNmp5?=
 =?gb2312?B?eXVSOEg5RUJVVkxEOCtOdTF4bThiMGp4dVR2eWRGV2ZoVllHNk5HR2VDWnpl?=
 =?gb2312?B?SkYzYzJLQU5jbjBWK0diekJjSzZVbFpGRXFFczVaVXBlb3JyUk92OEx3dktH?=
 =?gb2312?B?cW8vK2diREV0Z1lmVVpldUZpRU5nczZiRGs3WmI2QTR4ZDdhZENXQXBNTEZ6?=
 =?gb2312?B?cCt1bGl5NWFzcUlWTUNZdkpKUnlndGVpSVBSS3FxWFp5MmxMb2YyOVZCUXll?=
 =?gb2312?B?MHovS0xsbGNoV0gyZkpLKzFXZklPT3RJbHUvalIxUE5Qd1N2L0lDYkNqQWZs?=
 =?gb2312?B?Wm9nWjVPaXU0bjFiVmFMNXlpSFRrdW5hVWRlOC95aUtKYVNYc3l3QmtpV01M?=
 =?gb2312?B?MytrcGphU0c3UHY4UnM4WW9FSytIdVRxMGJWY2NaUUhmdUtsSWhmNU92YmxH?=
 =?gb2312?B?R3I1aHc2d25JV1VLRHZMZXlhZURKL295Z0RUZXBMUlQrUFRmVlQxUU03YjU3?=
 =?gb2312?B?VFBPcTJ4OU9BUDdZWndQMlJzYmVYREtOU0dHV29kc0p3MkJqbW1XaDZRaisw?=
 =?gb2312?B?Mnh3Mk1ITEcrKzJxeDBZU2pqcThrSXJtMk1TK1k3N0RvSG5rSUNYV2ZETDk4?=
 =?gb2312?B?SG94UGtWczdWaG8wT0pwb0hSWWJJajRDczE1RkxSa2NQK0NHQWJnb3h5Z2t4?=
 =?gb2312?B?RUhrcXVvb3VvS21sOWIrMGlSUnFSdEl6VlBXcDNCQXlLVDNMNmdlOHRTZTB4?=
 =?gb2312?B?NkhNazEwVUdMQmt3SUxEYlkwWGdnZUM5SVE2eUVtR2owTU5Ea3ZBZk1oVEFl?=
 =?gb2312?Q?osObLFSXpIGBdBZ/yMfWTMHcd?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	FBUztPzfchyXd3BDer/noY//tnQf2cNs1+kNNKYHGkEbHNKp9Bd9QtjTHdQa3dWUPDWbQa7S7I04CgOTnXI+kwlW1kK4xZUs24Cz8v2RQCS0BrEsum3zE5n6zFQBnqrU4HG8m2R1NqV8cbi0PpxiBWm36oGNBRPCjLiEPuZhy2kq/rBH5LX1lXc+4XoO3YXh2taIStfHyaKLLzxV3rlbaE2qpkeIUinmxac2x9Tiu1cr8/5ju0MnjTtETVRU+3patwo+ohVKM1+CT9G1gbLf9RKbuQxwtnuwMP6IbBuwkXlB8RigEC+iYMkKWhnnPkX55+XXhflXDDqzZRL9Q6yk8hdO4yWlWSoZ3AbFZqzQ85eH3IiJ/q0YMKBe/LSjRrmlT6NDLLZT5YZt34z+/zwiP/DAjuQwss/31+ZfLS0JiprSpWx4Q6Z+SFgkFY2BP/ODuJg+b/MYyh0oYaX5I/ZQjay5Zq18qf8uVH8RxsVIlQjpUAp5i0ni9LEx9z5pA5cCGf25QnOi3dt0NgiwRwbraflFnyQxh4+bES3Is8bbk5z7SjHKE7+fpxxMhE1YqXTxTpsJv0jV+/yjfV767ZM0plPwZLJLeCWVblUcezUo6SHH8rRHq3aNXSSi7aPRJJH7
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB12085.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42d665d5-078c-4164-b5a6-08dc3c132e3f
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2024 06:20:25.7196
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A0XErxe29KF0pGdyTRpPAIqqJAP8mzMV66v0+/Ba+SKYyfgndbQFPleCZKzrx/y9gVKsWxYVvqfCbTuYMCYW+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB11056

DQoNCj4gLS0tLS3Tyrz+1K28/i0tLS0tDQo+ILeivP7IyzogRGFpIE5nbyA8ZGFpLm5nb0BvcmFj
bGUuY29tPg0KPiC3osvNyrG85DogMjAyNMTqM9TCNMjVIDY6MjMNCj4gytW8/sjLOiBjaHVjay5s
ZXZlckBvcmFjbGUuY29tOyBqbGF5dG9uQGtlcm5lbC5vcmcNCj4gs63LzTogbGludXgtbmZzQHZn
ZXIua2VybmVsLm9yZw0KPiDW98ziOiBbUEFUQ0ggdjIgMS8xXSBORlNEOiBzZW5kIE9QX0NCX1JF
Q0FMTF9BTlkgdG8gY2xpZW50cyB3aGVuIG51bWJlcg0KPiBvZiBkZWxlZ2F0aW9ucyByZWFjaGVz
IGl0cyBsaW1pdA0KPiANCj4gVGhlIE5GUyBzZXJ2ZXIgc2hvdWxkIGFzayBjbGllbnRzIHRvIHZv
bHVudGFyaWx5IHJldHVybiB1bnVzZWQNCj4gZGVsZWdhdGlvbnMgd2hlbiB0aGUgbnVtYmVyIG9m
IGdyYW50ZWQgZGVsZWdhdGlvbnMgcmVhY2hlcyB0aGUNCj4gbWF4X2RlbGVnYXRpb25zLiBUaGlz
IGlzIHNvIHRoYXQgdGhlIHNlcnZlciBjYW4gY29udGludWUgdG8NCj4gZ3JhbnQgZGVsZWdhdGlv
bnMgZm9yIG5ldyByZXF1ZXN0cy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IERhaSBOZ28gPGRhaS5u
Z29Ab3JhY2xlLmNvbT4NCj4gLS0tDQo+DQpUZXN0ZWQtYnk6IENoZW4gSGFueGlhbyA8Y2hlbmh4
LmZuc3RAZnVqaXRzdS5jb20+DQoNClJlZ2FyZHMsDQotIENoZW4NCg==

