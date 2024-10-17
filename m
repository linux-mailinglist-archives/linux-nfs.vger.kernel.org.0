Return-Path: <linux-nfs+bounces-7251-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F98F9A2D95
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Oct 2024 21:17:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C86B6287835
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Oct 2024 19:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5DBB21D189;
	Thu, 17 Oct 2024 19:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Z30XctTO";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="z5ZrOEs+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1B621D657
	for <linux-nfs@vger.kernel.org>; Thu, 17 Oct 2024 19:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729192606; cv=fail; b=AHu6EdMe3wygeX5OCl3Ypo97QLzMZUif3mZHzgiCKSLgd+C+5YUt8vC5Mtrjp/O2CyKVC6Mmm9InenrEUxQMZb9V+1LPjlDoyGn7eqB+eLt+ason93m9ygYrWk42IadU52m3k25xZv6NnA5d9sQK60JOMfWrCMMkpzrDzJIIFjs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729192606; c=relaxed/simple;
	bh=aVwybqjOxvJiG0kNWYtD6zNa8h65QfEEai9TkXmYYgY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QQi+RGi4KA0H/1A8z9uEM/mzkx2/MLLSq/c2gKr7BlddGqcU/a6ep8SlOMYGhmLThVCujJd3vczRuwMRTqnhI+M0VtZiU5zWe7LDkRVp6IXLMGUKqr2Vw/4k3X04tda6cAMHE7X0K3U7cSsdGKHoTx0H0ELeM0O/ggE2qbG0H+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Z30XctTO; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=z5ZrOEs+; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49HFBpFu002249;
	Thu, 17 Oct 2024 19:16:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=aVwybqjOxvJiG0kNWYtD6zNa8h65QfEEai9TkXmYYgY=; b=
	Z30XctTOE5tUsF4UAOoGsf3QDA2a613Hn4NucMV92hXnQAx1myipmg33HAfaoVbz
	6kNgRJsIzbV5+fKMB1TyiujEfz8xu04ACRay3CviF7Y1MDGiwMomGVL8mXROKpCU
	vPaCM/GMhKHqFtxyXXibO+3/lGtbEjjBLXFYN0dvfhwc2bdgCNlhYJ/izUwU3Xdr
	PKQG+u5hxnywS9cM7sDBjaD1wb1nWkKnzNZhdTChGlep43PW3vO4fWnsawq6+otG
	6yiqiIJSReRQi0CKXg3Y+4ANGBk+DSw8u01HkT7PdxeRJu+iSYbQJbNW639k3mpU
	iOonvwDR5Ft8lCWl7aWAXg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427fw2qbwf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 19:16:36 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49HI2MA8036018;
	Thu, 17 Oct 2024 19:16:36 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2047.outbound.protection.outlook.com [104.47.55.47])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 427fjh5x6e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 19:16:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k8D/CxkW+p5mbGCGPvXu36EIf61gmbPRgTIVai15XQj1i94JyqNpRmy11vd56D5etM2Tu5OWuvVvHBNqBNSQOr//OWUPBSfRnONM+QR7E81/8KMt0zhbXsAzZ/OU6YblS3bVLG762peyY0mKuQgbiWp3DefZjvJ++mAvI8LkBtFRZSqI/awAq2P2sYWg1QJUeaMOrQLXfctifREZ4ZE41f5jHis1mVknBLjEmDFc2YeRFZlXAzwIEEMXdXqsghCxwilCCASHBFY5VAIxGQLZNgVi48earwe7MXodOqAeH9S3KMzGDgHAEE3Q3GGeM6p3AhrN8HI3DQuFZdnW9EnI/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aVwybqjOxvJiG0kNWYtD6zNa8h65QfEEai9TkXmYYgY=;
 b=DI+bMtgEfciQzij19D/u5pvoBo1/LOv3Zik2pRiUFg5tQM5tWMMP2oEHSsMfI8wiZkatEwjIun5tuJFDv2n6k59Oo3D+Qdy9bI1jAVsXqAB/A0Y5G6OlM9wvfZQ7tgZ/tqFcS2N+ttdA/3yueNL1aGlmR53AX7bpNI6hzRpqGEY1lnUPthlMiBSt8czU63+GHayYCbkGaQwy5hxI/zcn8Z6VGnP3+5i4pIMKhvB6UgaSl8h1VsYlGVmVDflaI/FgUg1542c//ld6O5IMzuUYEKGk0LDUH7RNUfqypCSj4kpQq9azW4+KOXEfI9BE1WOt7UBUwVDXQCNqrfgh/dc5CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aVwybqjOxvJiG0kNWYtD6zNa8h65QfEEai9TkXmYYgY=;
 b=z5ZrOEs+E/+ge7WQslhTDam+hYqWmUlucGQEvBhPqzy+FVFPK9rp0c5rVYD4M0TjBQ267oK4OIbAdd1PFBlt3AOYWlBmdU5sMkYrdknnJqkiPlKegJGQjsl8iY8efeQUp6LsfCfH9yFgZ2zBLDcIthp+jwXue05T9xXLWw69V14=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by LV3PR10MB8105.namprd10.prod.outlook.com (2603:10b6:408:28d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Thu, 17 Oct
 2024 19:16:33 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 19:16:33 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Jeff Layton <jlayton@kernel.org>
CC: Chuck Lever <cel@kernel.org>, Neil Brown <neilb@suse.de>,
        Olga
 Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>,
        Tom Talpey
	<tom@talpey.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 5/5] lockd: Remove unneeded initialization of
 file_lock::c.flc_flags
Thread-Topic: [PATCH 5/5] lockd: Remove unneeded initialization of
 file_lock::c.flc_flags
Thread-Index: AQHbIJmgFZQRt8REd0elZCQMjwW03LKLUAkAgAAA3gA=
Date: Thu, 17 Oct 2024 19:16:33 +0000
Message-ID: <396ABDBD-E05E-44F7-8297-CE421EB44319@oracle.com>
References: <20241017133631.213274-1-cel@kernel.org>
 <20241017133631.213274-6-cel@kernel.org>
 <830d2ed641c0a789c0c3d51633f138c0f9f0e81b.camel@kernel.org>
In-Reply-To: <830d2ed641c0a789c0c3d51633f138c0f9f0e81b.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|LV3PR10MB8105:EE_
x-ms-office365-filtering-correlation-id: 8c06da15-333c-4208-ac33-08dceee03653
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?dU1ERFl4ZjJhZGRueVhyYXZQTzQ5SG94K09NMkxFKzJZTzBzM0toaUQrcVF0?=
 =?utf-8?B?enZXVzRVMFMrN2wxb2hmRkNVU3RJbkdBTVI2am5EYmFsV216U1hzQWplNWZS?=
 =?utf-8?B?RXVDWktsempMWDNjTVFNWGdNUEIzNWJFR1YrVGdWc1NlZnRKSVIyOFVaLzZs?=
 =?utf-8?B?YUZSYUlKUDA1MmxnSnZlMFc2RUF3aTBBRFhzZ2tOQi9rakdhdkQrUm9XNWdW?=
 =?utf-8?B?TGUvaUs0VkZCbDBSb2p6clU4TWdNdVNabjY1UE9kbjRCcVZhTDIvQ3VuSmFE?=
 =?utf-8?B?UmJFdGgyZmpCZWtWYm9tRjNFZDMzUVRnanh5YTFEVElpZURydWhFT1JPY24y?=
 =?utf-8?B?aWdIaytQTEZvT2EwSUZueURNNDdQNDJibmQrdGRtanBvc2xBMTZPMmsrOUNQ?=
 =?utf-8?B?NWFyT2N1S3JkRkJHNnJ6NzFuRVhWQU9aVEdscE04T3N1S1ZWVnVOS1d5Ull2?=
 =?utf-8?B?eUhNZTlPcEc0UjRtbHZ1cTdlOHdMbXNxc0Q4dkhVdWpic1ZSeUxmbm40OUFl?=
 =?utf-8?B?Z2lMTkxlQURkM0xGZGVHTHE3NmVYSXV0SGRudnNta2dLRDhWMlg2M0k1S1My?=
 =?utf-8?B?ZkltSG9MeUNaclVjVThPOGkrM2NuVENiYyttQ1B4Y1NOc0R4VlRCYVdRc3Bn?=
 =?utf-8?B?dkkzbXpwSDZHcmVJRytzbkdlUTFFSmhoSHAvZ0IyVXlTTFFXOTIrS0FGZ1VY?=
 =?utf-8?B?dS9QWldvZWdOVTRWTzZiamNlZjJDako4bzl6ODAraEhkWUVyTjhYSmVWNkhq?=
 =?utf-8?B?WWxLZzZRMk9YRXF5aEtBRjI5bWxhRHdFLyt0VGpTd1JwRGw2bUY2MS9yeTFH?=
 =?utf-8?B?ajNmMXVMSVoxNnlDVnBycjhER3VPNTlDM0g2bHk1NGN2TzNUVERNd0YrR2F0?=
 =?utf-8?B?ZEVQZFF3NVJXUmZQUXVDS21HeHpuODMyQm81dWV1NGN0ZldWTUxmdk9mTWdL?=
 =?utf-8?B?NVl4OHd3bCs0d0RzdkhFcUJYalN5MVF2MTJkR2ZRd3FQa3pGRDNKMnhSRTZM?=
 =?utf-8?B?dXNBekY1RERmSHNDR2dlQjhNRFFEejhxOXoxSDBJMC9NWFArWjlZaFpBZlpY?=
 =?utf-8?B?OEFBUldvYzZaYmU1NTR3dDg1R2c5ZThidE5sTHhNeGZsNWV5YStreXl6aTlO?=
 =?utf-8?B?QzBnUWp3UXFNdHFwK0tVays0QWN2c0lENU5wTFRjQnlXU0E4MGl4UXdGYlA0?=
 =?utf-8?B?RkVXakY2ME1nMElCaUN3Z0RYSXNpbS96TnVRQ3duQ2w5SHJsc2VadUpJVTQy?=
 =?utf-8?B?UWh1a2FTby9BbHpBYlJlOWkrNmNUSDduVkp3bGVnbkVNcTFwUytKbXNmNTMv?=
 =?utf-8?B?V3JrQ0ZCeTMrZDhqSXRVcDdpYTAzWFArc3NHbTRiaFROeFBFMEtHVEhnMVNj?=
 =?utf-8?B?OUpQNUVkVThYZDlIeHlDdEJKSjNWWUpvZ2pyWHgraDdQd0ZkaTNLNE9RQXVk?=
 =?utf-8?B?bEJ2VHVJSWozUWovazRGVU1QM0swemNzcHZLckVrUHpGSk55U3BnNERBWU9E?=
 =?utf-8?B?UWN3ZitHTTI0cFREOEtmOW0vTEgvQ2N2S2dtSitoVU0xQm1QR3NSazVJSFlR?=
 =?utf-8?B?eTJIWWFxcVBmT0dlWmM1QmtOb0pxeEljTkpjTTNERTJ3cGtXY1lVenNxQkZz?=
 =?utf-8?B?cUFYcXR1UWpsMXBWTnIwNGxkVFVHQXVOcC9DRXhuSGgxMm5xaXBWS25yRVFa?=
 =?utf-8?B?VzB5aWxwTElmMzFDdVFvVmhGVk9jZk1QT29UOUdTTWZ5byt4aHFQMU1MS2Ns?=
 =?utf-8?Q?Xw/4+lQueDzy4bGI1wnoLQUFokCEwloFYlUd8Vh?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QjQxb0VGTlAxeTJ6empBbGFiSUczV1krZ1BEZTFsSkU2Um5PWk5Mdkc5SHVy?=
 =?utf-8?B?allTRDBnT2J4Z1FkbE5GU084WlhoanM2VkdicjlwNkE0bjRjMGZDNTlxYmVL?=
 =?utf-8?B?cVZ0dkxCZWpzcnIrcE5OMVF5WThhanJFZWkwWldaYzNnTGhFcE1TQ0pQWEw5?=
 =?utf-8?B?UGJVZkR1OUVONHVqOVE0TGdTMXNLbWY5eHVaQmZnVWtHT3pKR2RxTkd5K25E?=
 =?utf-8?B?bUJmbHJESktyVW5xamFRQW4rVzJGR28zYXNWanc3eGZ6QzFnK0RXaW0xbmpn?=
 =?utf-8?B?OUdIZmJTbWtvUHpFeTcwUEVmTHVqMWowYTZWdHBZY1VZUGoxWmRDYzlrTGdH?=
 =?utf-8?B?d05lU0lUS1BCb1g1TVlub29UejcxTHdvT21aU1p6cGYwSjJZcDhzOE43TlhM?=
 =?utf-8?B?c0dRcnM5K2JkVS9qTG1vMFV3WVVzSlRRVFFUVnNIOWU4ckRWK2pQemFzZmVa?=
 =?utf-8?B?YW5hT1BIUTNnZXN5VWpnM0s3emRmRGp1R3VkbzFxeTI5NEFsS1AvQmtTS2x5?=
 =?utf-8?B?Mi9KMWNvQ1IwK05uS0xCSjRDZnJTY2RKbUFPR1lhRnFzZTNRKzhXQkgxc0tJ?=
 =?utf-8?B?dk5WeS9ibnJuM2hlRkUxWVlCQ1dub2xiWWJMdkVQWG5xQk9IdWZkbDhpd0Yy?=
 =?utf-8?B?RCtBVnJ1c0EyWFJiOWNpVjMzRm5ybXIrN0MzWVVpdXN5K0VCaWliWklHQ0xT?=
 =?utf-8?B?YUN0Q2NtdjlIOUtlVVNDQjRWVGpjbWlwZTdVRktiZlJuaVRMa1FwZEtKU29s?=
 =?utf-8?B?MWJkREdqZkhqRnhYVndnYlRJbE9EZmJlTlNXbnkxSjVzZE1zUE5pcUFHZVZT?=
 =?utf-8?B?SjlaQzYrbGJseWhET01QWFp4UVQwaVQ0S0xXdDJsYlBSSWUydDY4RGlsVGRO?=
 =?utf-8?B?VkFYc0crN0x0bC9SWEQ4OFBjbUhPLy9QSEdMOW5FZUIrU2ZtUWdtOVNRbVZY?=
 =?utf-8?B?NVg5cDB5bUloZWR5cndkZWt1RzY4VUJjOXdwb29TNVBuVGpnd3pLY0NVZzJy?=
 =?utf-8?B?dGlaWVJoZkxuUnZUNkhvVStDZzRCVmJaVi9pektHcDdjb3FXT1lTNjhacXFK?=
 =?utf-8?B?Ky90eWNDdm94R0pqNVpBNmo3R1I2aDI3cGlNOENObU41Y3ZMa0NUWFJ4Z2NZ?=
 =?utf-8?B?cnFGam9FUkdPamljcVpSNFJzYVhjak0vbkk3S3phaEhpVGxRSDhtU3g5Q3ho?=
 =?utf-8?B?SytPK2RiSkdrRS80MG9yWTBOaHhyby9lUi95cDhWWHhBTC9pSUU5ek1NbHhu?=
 =?utf-8?B?bm5nR0xNYkVtTng0K2s4cTRkMFhHL3J3VzhsK1MzeEpaOVI1VlA4K3l3YzBO?=
 =?utf-8?B?bGtXR2ZrOFBCZ1NrSEpDcTg3UkxSYUJCcXB1YlBZbm92aXMxTUY4T1R5TFZw?=
 =?utf-8?B?cXV0ZWZNcDVzeTU1UHVmV0ZMcnpJdkovL2lManpZMlpUVHlGWEk5d3ZiWG1q?=
 =?utf-8?B?d3ZpWHExd1dRQU5ReUhuSkdrcTJyZXBmdVFaM2VlZXY1NVNLUzdCWnd3YjNy?=
 =?utf-8?B?ZDlQeEpwcU5VUjV4SjZ2ZWxobjNZM0g0ejNDOFMxV3ZXaE9XM2VUWlBhdWZY?=
 =?utf-8?B?a3FYUXgzNjhTNTdTVU1qakNxc0Q4K1dRalo3VXJYSnArVlBnZVJUZ01mUjY4?=
 =?utf-8?B?N1pMNVYySGg5K08zUkpXYzNPY1Y3YXlCY0VNai9tVkIvY0VpRzYzbEx0RVhp?=
 =?utf-8?B?R1MwTVgxcVRSQUo0MERLTmwrSnI4NHRkWUhScXFWN1k3ZEhBVmhMU0ZYWFl6?=
 =?utf-8?B?SnRSSkVoUldQakh1NlFSbmpOT05TOEVsYytrbzB1WERmaVU5S1lqcldISUll?=
 =?utf-8?B?ME1JSzNKcHVlUTBGSVRXdm5BdERnM0FxS3Qzam03V3BZM1hFdUVrZmlJcm1Y?=
 =?utf-8?B?U0ZGNEZoMU85NXI0VWE4dCtEcmRhYlAzNVcxK2UvZHNZQ0FSTG5OaUk3RXhm?=
 =?utf-8?B?eDAvaGZ2ZGpTUGhjRENEU0UrMGkxS1JCSytyUEdyZmRkazZsTWlqbnNDWHNM?=
 =?utf-8?B?WENqYjU1K253cTlWN20zaGlZRW55OVp6NUJuM0JzdWtNN2gxWTFlcERxQlJ0?=
 =?utf-8?B?Unp0RUE4bXNhWkNBZ2R1VDVvcEttR1JPWnB4UTd4S3VDWjdNb0U0ZWdlaHNo?=
 =?utf-8?B?MVhnUEZNRVRsY2NlbmoweFpnMWxNTnNsTGtGQlh5NnprK29mN1NRNW5IMGVE?=
 =?utf-8?B?OUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C61F5053FD1B434492F7D2F416F9E5A8@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	eDuvRjVA6TaG9dtQbrYQ8hjPHOmb266H3rGKCYHc2LO0RZMHIQXrAuzsM/TV26K9uLXMl//mLg6sP895GcmL60WJIAKNCmU2Dy3kepQZV9ZIoxPDBrUUTEyeYPJ8CgLtJ+b6c/IvXLhxXsyQlMNALmw6s05WA3Gjcu4WLK1n+uL2Gc95UYzKfsAnBFV/Ob6OKhMOMtKFE565fbA2LQD2oUGDlxVwLeA1j8wbWuEGqXKETHkBSzBhQ7EalNisyiQSyKoncpURSuZ9GSGMsL0YfRCptZfjjg1tRlbJTg+Rl6oAoMIWvdmWl9TvQRAPd0IUTPJeLIzpk7UKU64AbqbOGzYG8QAoWp9mV9OI/8TQmG0QwrvElPnBvH18193DxkqBAaMnczneP5fm/GiTMdFcrIarkCFyn0InfKY+7yzaNzaoF5mYG/zBG5/swQpERJ7ux+8dejaR7jVzb/NiVtyS7Z1T6bBISh9EUbqIM253EscK3voOOKkFE9H/VqEgJqT3sls1Vw6dlccXxkkJDWUunL3uPU180b3nqCzj9QLSyQZri03zbGSO/SRxA63L9JROxZ/0qaSrPuzuxJ628hPBknNMs1ozGPHfsHTs69e9AkA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c06da15-333c-4208-ac33-08dceee03653
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2024 19:16:33.1041
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JBTssDCIp0EsEOWfYx0OlTbLE6oHgC3MOIfK/Ar05h93clFpynSG6IvxNEND1T1ExmF15El1e5BVTA81wWNdHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB8105
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-17_21,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 bulkscore=0
 spamscore=0 phishscore=0 malwarescore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410170129
X-Proofpoint-GUID: xpNQ2z32bxozB853Zm8E43nCY0WKtCRh
X-Proofpoint-ORIG-GUID: xpNQ2z32bxozB853Zm8E43nCY0WKtCRh

DQoNCj4gT24gT2N0IDE3LCAyMDI0LCBhdCAzOjEz4oCvUE0sIEplZmYgTGF5dG9uIDxqbGF5dG9u
QGtlcm5lbC5vcmc+IHdyb3RlOg0KPiANCj4gT24gVGh1LCAyMDI0LTEwLTE3IGF0IDA5OjM2IC0w
NDAwLCBjZWxAa2VybmVsLm9yZyB3cm90ZToNCj4+IEZyb206IENodWNrIExldmVyIDxjaHVjay5s
ZXZlckBvcmFjbGUuY29tPg0KPj4gDQo+PiBTaW5jZSBjb21taXQgNzVjNzk0MGQyYTg2ICgibG9j
a2Q6IHNldCBtaXNzaW5nIGZsX2ZsYWdzIGZpZWxkIHdoZW4NCj4+IHJldHJpZXZpbmcgYXJncyIp
LCBubG1zdmNfcmV0cmlldmVfYXJncygpIGluaXRpYWxpemVzIHRoZSBmbGNfZmxhZ3MNCj4+IGZp
ZWxkLiBzdmN4ZHJfZGVjb2RlX2xvY2soKSBubyBsb25nZXIgbmVlZHMgdG8gZG8gdGhpcy4NCj4+
IA0KPj4gVGhpcyBjbGVhbiB1cCByZW1vdmVzIG9uZSBkZXBlbmRlbmN5IG9uIHRoZSBubG1fbG9j
azpmbCBmaWVsZC4gTm8NCj4+IGJlaGF2aW9yIGNoYW5nZSBpcyBleHBlY3RlZC4NCj4+IA0KPj4g
QW5hbHlzaXM6DQo+PiANCj4+IHN2Y3hkcl9kZWNvZGVfbG9jaygpIGlzIGNhbGxlZCBieToNCj4+
IA0KPj4gbmxtNHN2Y19kZWNvZGVfdGVzdGFyZ3MoKQ0KPj4gbmxtNHN2Y19kZWNvZGVfbG9ja2Fy
Z3MoKQ0KPj4gbmxtNHN2Y19kZWNvZGVfY2FuY2FyZ3MoKQ0KPj4gbmxtNHN2Y19kZWNvZGVfdW5s
b2NrYXJncygpDQo+PiANCj4+IG5sbTRzdmNfZGVjb2RlX3Rlc3RhcmdzKCkgaXMgdXNlZCBieToN
Cj4+IC0gTkxNUFJPQzRfVEVTVCBhbmQgTkxNUFJPQzRfVEVTVF9NU0csIHdoaWNoIGNhbGwgbmxt
c3ZjX3JldHJpZXZlX2FyZ3MoKQ0KPj4gLSBOTE1QUk9DNF9HUkFOVEVEIGFuZCBOTE1QUk9DNF9H
UkFOVEVEX01TRywgd2hpY2ggZG9uJ3QgcGFzcyB0aGUNCj4+ICBsb2NrJ3MgZmlsZV9sb2NrIHRv
IHRoZSBnZW5lcmljIGxvY2sgQVBJDQo+PiANCj4+IG5sbTRzdmNfZGVjb2RlX2xvY2thcmdzKCkg
aXMgdXNlZCBieToNCj4+IC0gTkxNUFJPQzRfTE9DSyBhbmQgTkxNNFBST0M0X0xPQ0tfTVNHLCB3
aGljaCBjYWxsIG5sbXN2Y19yZXRyaWV2ZV9hcmdzKCkNCj4+IC0gTkxNUFJPQzRfVU5MT0NLIGFu
ZCBOTE00UFJPQzRfVU5MT0NLX01TRywgd2hpY2ggY2FsbCBubG1zdmNfcmV0cmlldmVfYXJncygp
DQo+PiAtIE5MTVBST0M0X05NX0xPQ0ssIHdoaWNoIGNhbGxzIG5sbXN2Y19yZXRyaWV2ZV9hcmdz
KCkNCj4+IA0KPj4gbmxtNHN2Y19kZWNvZGVfY2FuY2FyZ3MoKSBpcyB1c2VkIGJ5Og0KPj4gLSBO
TE1QUk9DNF9DQU5DRUwgYW5kIE5MTVBST0M0X0NBTkNFTF9NU0csIHdoaWNoIGNhbGwgbmxtc3Zj
X3JldHJpZXZlX2FyZ3MoKQ0KPj4gDQo+PiBubG00c3ZjX2RlY29kZV91bmxvY2thcmdzKCkgaXMg
dXNlZCBieToNCj4+IC0gTkxNUFJPQzRfVU5MT0NLIGFuZCBOTE1QUk9DNF9VTkxPQ0tfTVNHLCB3
aGljaCBjYWxsIG5sbXN2Y19yZXRyaWV2ZV9hcmdzKCkNCj4+IA0KPj4gQWxsIGNhbGxlcnMgZXhj
ZXB0IEdSQU5URUQvR1JBTlRFRF9NU0cgZXZlbnR1YWxseSBjYWxsDQo+PiBubG1zdmNfcmV0cmll
dmVfYXJncygpIGJlZm9yZSB1c2luZyBubG1fbG9jazo6ZmwuYy5mbGNfZmxhZ3MuIFRodXMNCj4+
IHRoaXMgY2hhbmdlIGlzIHNhZmUuDQo+PiANCj4+IFNpZ25lZC1vZmYtYnk6IENodWNrIExldmVy
IDxjaHVjay5sZXZlckBvcmFjbGUuY29tPg0KPj4gLS0tDQo+PiBmcy9sb2NrZC9zdmM0cHJvYy5j
IHwgNSArKystLQ0KPj4gZnMvbG9ja2QveGRyNC5jICAgICB8IDEgLQ0KPj4gMiBmaWxlcyBjaGFu
Z2VkLCAzIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+PiANCj4+IGRpZmYgLS1naXQg
YS9mcy9sb2NrZC9zdmM0cHJvYy5jIGIvZnMvbG9ja2Qvc3ZjNHByb2MuYw0KPj4gaW5kZXggMmNi
NjAzMDEzMTExLi4xMDllNWNhYWU4YzcgMTAwNjQ0DQo+PiAtLS0gYS9mcy9sb2NrZC9zdmM0cHJv
Yy5jDQo+PiArKysgYi9mcy9sb2NrZC9zdmM0cHJvYy5jDQo+PiBAQCAtNDYsMTQgKzQ2LDE1IEBA
IG5sbTRzdmNfcmV0cmlldmVfYXJncyhzdHJ1Y3Qgc3ZjX3Jxc3QgKnJxc3RwLCBzdHJ1Y3Qgbmxt
X2FyZ3MgKmFyZ3AsDQo+PiBpZiAoZmlscCAhPSBOVUxMKSB7DQo+PiBpbnQgbW9kZSA9IGxvY2tf
dG9fb3Blbm1vZGUoJmxvY2stPmZsKTsNCj4+IA0KPj4gKyBsb2NrLT5mbC5jLmZsY19mbGFncyA9
IEZMX1BPU0lYOw0KPj4gKw0KPj4gZXJyb3IgPSBubG1fbG9va3VwX2ZpbGUocnFzdHAsICZmaWxl
LCBsb2NrKTsNCj4+IGlmIChlcnJvcikNCj4+IGdvdG8gbm9fbG9ja3M7DQo+PiAqZmlscCA9IGZp
bGU7DQo+PiANCj4+IC8qIFNldCB1cCB0aGUgbWlzc2luZyBwYXJ0cyBvZiB0aGUgZmlsZV9sb2Nr
IHN0cnVjdHVyZSAqLw0KPj4gLSBsb2NrLT5mbC5jLmZsY19mbGFncyA9IEZMX1BPU0lYOw0KPj4g
LSBsb2NrLT5mbC5jLmZsY19maWxlICA9IGZpbGUtPmZfZmlsZVttb2RlXTsNCj4+ICsgbG9jay0+
ZmwuYy5mbGNfZmlsZSA9IGZpbGUtPmZfZmlsZVttb2RlXTsNCj4+IGxvY2stPmZsLmMuZmxjX3Bp
ZCA9IGN1cnJlbnQtPnRnaWQ7DQo+PiBsb2NrLT5mbC5mbF9zdGFydCA9IChsb2ZmX3QpbG9jay0+
bG9ja19zdGFydDsNCj4+IGxvY2stPmZsLmZsX2VuZCA9IGxvY2stPmxvY2tfbGVuID8NCj4+IGRp
ZmYgLS1naXQgYS9mcy9sb2NrZC94ZHI0LmMgYi9mcy9sb2NrZC94ZHI0LmMNCj4+IGluZGV4IDYw
NDY2YjhiYWM1OC4uZTM0M2M4MjAzMDFmIDEwMDY0NA0KPj4gLS0tIGEvZnMvbG9ja2QveGRyNC5j
DQo+PiArKysgYi9mcy9sb2NrZC94ZHI0LmMNCj4+IEBAIC04OSw3ICs4OSw2IEBAIHN2Y3hkcl9k
ZWNvZGVfbG9jayhzdHJ1Y3QgeGRyX3N0cmVhbSAqeGRyLCBzdHJ1Y3QgbmxtX2xvY2sgKmxvY2sp
DQo+PiByZXR1cm4gZmFsc2U7DQo+PiANCj4+IGxvY2tzX2luaXRfbG9jayhmbCk7DQo+PiAtIGZs
LT5jLmZsY19mbGFncyA9IEZMX1BPU0lYOw0KPj4gZmwtPmMuZmxjX3R5cGUgID0gRl9SRExDSzsN
Cj4+IG5sbTRzdmNfc2V0X2ZpbGVfbG9ja19yYW5nZShmbCwgbG9jay0+bG9ja19zdGFydCwgbG9j
ay0+bG9ja19sZW4pOw0KPj4gcmV0dXJuIHRydWU7DQo+IA0KPiAxLTQgbG9vayBmaW5lLiBZb3Ug
Y2FuIGFkZCBteSBSLWIgdG8gdGhvc2UuDQoNClRoYW5rcyENCg0KDQo+IEZvciB0aGlzIG9uZSwg
SSB0aGluayBJJ2QgcmF0aGVyIHNlZSB0aGlzIGdvIHRoZSBvdGhlciB3YXksIGFuZCBqdXN0DQo+
IGVsaW1pbmF0ZSB0aGUgc2V0dGluZyBvZiBmbGNfZmxhZ3MgaW4gbmxtNHN2Y19yZXRyaWV2ZV9h
cmdzLiBXZSBvbmx5DQo+IGRlYWwgd2l0aCBGTF9QT1NJWCBsb2NrcyBpbiBzdmMgbG9ja2QsIGFu
ZCB0aGF0IGRvZXMgaXQgcmlnaHQgYWZ0ZXINCj4gbG9ja3NfaW5pdF9sb2NrLCBzbyBJIHRoaW5r
IHRoYXQgbWVhbnMgaXQnbGwgYmUgZG9uZSBlYXJsaWVyLCBubz8NCg0KSGF2ZSBhIGxvb2sgYXQg
dGhlIG5sbTQgYnJhbmNoIGluIG15IGtlcm5lbC5vcmcgPGh0dHA6Ly9rZXJuZWwub3JnLz4gcmVw
byB0byBzZWUgd2hlcmUNCnRoaXMgaXMgaGVhZGVkLg0KDQoNCj4gQWxzbywgSSB0aGluayB0aGUg
c2FtZSBkdXBsaWNhdGlvbiBpcyBpbiBubG1zdmNfcmV0cmlldmVfYXJncyBhbmQgdGhlDQo+IG5s
bXYzIHZlcnNpb24gb2Ygc3ZjeGRyX2RlY29kZV9sb2NrLg0KDQpXaGljaCBpcyBnb2luZyBhd2F5
IHdoZW4gTkZTdjIgaXMgcmVtb3ZlZC4gSSdtIG5vdCB0b28gY29uY2VybmVkDQphYm91dCB0aGF0
IGR1cGxpY2F0aW9uLg0KDQoNCi0tDQpDaHVjayBMZXZlcg0KDQoNCg==

