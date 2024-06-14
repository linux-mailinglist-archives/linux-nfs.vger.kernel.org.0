Return-Path: <linux-nfs+bounces-3837-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87468908E4B
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Jun 2024 17:12:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E6DBB2B00E
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Jun 2024 15:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CFD7376F1;
	Fri, 14 Jun 2024 15:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Qg7iquXt";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="RMWAO7Qd"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08E714B97F;
	Fri, 14 Jun 2024 15:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718377604; cv=fail; b=UVl6nDDdGAx7XQVQqX7O35j7iFBe418l+Vc1jw/3BIVVZQ9DsY7PvqtoKDIYfDkaCjueQmkBfbXCCihaOxaYzizlbIk7VQvhL1jO8GZwYSvaTLOdXESr1iN8N4uQ329Zsa6T4nuCYWQvwRVJ3smvTbWeiITV7Ku+vDZ7zTGOh3c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718377604; c=relaxed/simple;
	bh=srsM6W26DPUlIYoEb0ui4up9vulEKR92L65rEV50K/Q=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=hUZ6HlHY9+1stOc/6Ent779aJaB8nl8+GPyKrvGjB6gw4FTFASEWttjVWmvW7boNvWDpJDFbL3MS4ZEu2caWa5qMgqha7rxudN+YvaLUkZktWraJqNzOWg46PHDzz2qwzyBZavHgBgV+/N2yKYt1vDdEa0vkngCNVtJweysvdUg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Qg7iquXt; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=RMWAO7Qd; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45EDHMBd030142;
	Fri, 14 Jun 2024 15:06:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:content-type:content-id
	:content-transfer-encoding:mime-version; s=corp-2023-11-20; bh=s
	rsM6W26DPUlIYoEb0ui4up9vulEKR92L65rEV50K/Q=; b=Qg7iquXt6OMu3YQ0z
	pSJyyKKZHXV7ZMB1F7rwpfwlLiDrlpMCpqzgjdGrzivMZddhWGke2ZjJnOCjKhyB
	WUyWFcortiGSf3SxZDChkplkg3fysQamKdHBMt9T24bsnd4EERbrK9ViwSDAhmXm
	SibZM8HFnQQY0zzJWmw8/VfSZ1KNHP+MCkB01cSPzOY4cCtjH3DADPpQ7dRhgnZV
	2Qflxshuol2DAtmGJQWzwdin0O2FvvLs3Y/fQpdz3iVNOHtB2AazsKTFAKQ4h8tt
	crGqqZq2xJpqm+dHBoP7I8baLMtYJhuRkCtFzJQfAHXOG+PzjszYxat60XVAyTrs
	FQLBQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ymh3pbthc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Jun 2024 15:06:41 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45EDUe42020460;
	Fri, 14 Jun 2024 15:06:40 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3yncb02ed8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Jun 2024 15:06:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cmFyhiGYGwokfT0QJuHNgaUXEQY5K72mOFrrYHryQXEu021eILEtywcvdxSXxYkR8VlFEw5afjQ/R0lkULzxldIyKlZ6SuvefbHLfpc+P+NKQCqBXp8g+6qQ/XL+Evd0Anx8FZbjjDvT7Qc3uBHbM5mXLhu5ewHxj+QcFoGmVmVJsKx2kqDxnIqzN7OVXg3jzElvLOTRkCcQRi0e6QvZvrwN+e4untZ3Tk9/5X3SVmOZOTNTLzCQZRfzgnZF0mGF8H4o+2GDBj8PYwAQI4W+Jk+xi8pVAllgiZX3NLl2CtULX9KPcgndJCoSixstIipzJUfLEZiGBTEgwdnMvIbItg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=srsM6W26DPUlIYoEb0ui4up9vulEKR92L65rEV50K/Q=;
 b=CGpJwMcz1FsIWHO558Dmgewp5RNXbTZNemXRW01YnFu8CPKIrcC895FpU/DYpRp8QCyC1mIP7NvRIGBx/mNDQIPpUnSoYHHxHvsH+B7FftsRjUMxbVETWbvLP34US2SIyro2mC44ujSQnDUF+DFiJTHBmwydE1tW3gPSrUH4l5yXFdY01goTiepIuHgxByYNjZW9cWCo8GZLbhSi/sJjuGSogKr2jnkZtedCMrR56uVow6Ks5/9JE5CHGfscBq2T97nxWcr28GqvSNSynozIA19/j9f9Wg2+ymiS4PJ9IqWWBdO437XKlLwXorIpnZNGKu/HqgvIiXX2syMvseCViw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=srsM6W26DPUlIYoEb0ui4up9vulEKR92L65rEV50K/Q=;
 b=RMWAO7QdfpOqR73XmRgsRgiRfmVyx2luyAlk3Es1RlgmwiyQ02cXDJbLdw+bqZOLUeHGOT+J5CfMM+5ifn5LVWwLwZJjFVwoDJ91aewWgmdIQUWTHZqLcEgB7oZkDdW9TNyxRtUFpI6SDr0sn03XgTMaXe70G11XfCeprWuWcwQ=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BY5PR10MB4259.namprd10.prod.outlook.com (2603:10b6:a03:212::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.25; Fri, 14 Jun
 2024 15:06:38 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.7677.024; Fri, 14 Jun 2024
 15:06:38 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: kernel-tls-handshake <kernel-tls-handshake@lists.linux.dev>
CC: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: [ANNOUNCE] ktls-utils 0.11
Thread-Topic: [ANNOUNCE] ktls-utils 0.11
Thread-Index: AQHavmx0L9lMV0cujEmOGpqj4ECfPw==
Date: Fri, 14 Jun 2024 15:06:38 +0000
Message-ID: <3CB50C48-A197-4A07-9637-665E3F5C9FDD@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.600.62)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|BY5PR10MB4259:EE_
x-ms-office365-filtering-correlation-id: 02b2a4cb-a06f-4f88-0e46-08dc8c83972b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|366013|376011|1800799021|38070700015;
x-microsoft-antispam-message-info: 
 =?utf-8?B?OG03TG1rNWlDeDJPM1pRbWtaUC9oK0poTUR4S2pBaVFOejF4NzFoT1cwUDBu?=
 =?utf-8?B?bzJHQ2pqbDFoSkRRRG5jekZzUVhtSXhkbHEveVdLQ3ZsR0paWkhIYWVUclY0?=
 =?utf-8?B?bW9OVkM3RjZJQmxSdVlrdlAvSjJ3VC84WjA0TDYrcUZVcGtSYzVBMEwxbzRk?=
 =?utf-8?B?OG1GdDFuS3dVQ0duSjZRckluNjVKSERXYXJqMVlNalROYzByTGJkKzdIcHhB?=
 =?utf-8?B?d1ZWdmNCVktFR1BNanQ3Q3N4cDNackNaMHBucjZrelVGaUJjNmRvZDJJdDIv?=
 =?utf-8?B?UHZxTzg1Tlc4Z0RZNmk2Z0VRbXFsakdpQmt5UE1zYjJHQnRkb3haZnhLazVD?=
 =?utf-8?B?VWNnQzhSL3Q5WTE5cTViN2F2b3cxN0hBbUhXQmdpQW5BRXNkWUpaWTNMVjNq?=
 =?utf-8?B?cGxWTWVnWk8ydU5DT1M5MmY1UlVNM2toSHRTVWxKR3M3VFJCSUNVUHZndW9x?=
 =?utf-8?B?UWNUR1IyZ1RKK3d0d0VSVURMaGdab3llcXBUWDZDZ1BWSXgrY2ozR2FIVUJt?=
 =?utf-8?B?NlNXMGZXSHpDYmNDUEp5VGVxMkJyV3NQUWdhckdGMnkyYWg4Ym9NazROa3Iw?=
 =?utf-8?B?bjFPOFVraWlIbTc3ekNCVEtaeE5ZMW1iMkU1Y080cE90b1ZJM3RQZ3VEMlVm?=
 =?utf-8?B?UFJ0NXFGeHV1cjZDdlE2M0pjVy9Zc1poQnEreDZEM200SWpzbVNlY1JzY003?=
 =?utf-8?B?RmZRVThnZjZ1bS9nNTZLNUkwNnM2U0s0ZUxTYWZBOFRiRmJoamdBQlhTMnkv?=
 =?utf-8?B?V3Y5RzJCb091Q3ZlNW0yUWdyTXEvem81bFZhZUJWL0kzbTFUYXdwOWpTb2RN?=
 =?utf-8?B?TjNic2ZJaTNESmRHZlZ3SW15RkRpOUp4cXprQmpSRXlYSmxQKzc1eFRGM1FJ?=
 =?utf-8?B?ZmlUU09rNEpqbUEzY25yOFN4WEFWbGkwSVhqTlo4YkovcGtoNDhZS0RPaTdZ?=
 =?utf-8?B?Z1FRVGx1RTZMUlBXZ0hiMFpjNytrMEROeTl0dDh1VUNHSG1zdjZNYUI5N3M3?=
 =?utf-8?B?RXRPa2xWS1ZoTlZxb2p4TGZjZHRrb083RTZtUGpOTGg3SXpLN0RINUlrVHY3?=
 =?utf-8?B?SVhJeGl5Nm5YNWY1Q00rRllSbGdXNjM3dzJNalJsQWthZzI5emN2Yk1FbjFk?=
 =?utf-8?B?dFlUUUdYd2R2dFJDYkJ1bWNvSEZCOVU1M3VRNWFLdUF1a3F4cnNkR0wxZVpY?=
 =?utf-8?B?elh4VnF4N1h4TEtWNWxJQmwyK0YwSWdtd2VDWXF3YkNCclV3bytFdWRrZGlh?=
 =?utf-8?B?d1R3cVJvemt2YmZHUkRPWlgyUE1wdDNNNVFjdmgrNHdoNXBEOGN2TTY0b3Ax?=
 =?utf-8?B?SUdoaDR0UWdMdS9rZk54S3V5TFNJaHdnQ083eHViYkJHOGlvK3ZhRUJ3MGtY?=
 =?utf-8?B?K1R0OW1MOTd5NWE1TXhzK0ZncUhaL0VWbjR1TzdpS3RaQk1BVnhhRGp5Mlgy?=
 =?utf-8?B?N3RKSzZ3VGdhOEVZTVd1cWtVNFhYTnV5VGM2clROZCthRUpnWGwrdHVVSHY1?=
 =?utf-8?B?M3pPdUdIMUgxWEI0Y01zU1RWU3g4ZmFwTUl2RWxqRWo3Zi84cGhjTUVKY0pl?=
 =?utf-8?B?aVlVSy91ZXo2c3ZDVnJGOVpLU0E0ckZNc1FZbnpnY1RMNzZ5eTEzZVNRajV4?=
 =?utf-8?B?UHFFNjVIUWdURXVzSzUwS082R0JNUUFYNUFIb3RXdGVNdTJ6aWpsQTFlMTc1?=
 =?utf-8?B?TENxdnhxbVlKU3E5blFsTEhsV2wzRGZaL1FOSGZ5UlQydTNPY3F2N2JUd25t?=
 =?utf-8?B?YjJuZE1KbDVZWXJwSFpOR3J0R0RhRzh3RGp4dnVhYnorMFBwYU1yMXZWZDgv?=
 =?utf-8?Q?jPoEPDn5oNDH+8/69IaEswbXUl9M0Sr3pXklo=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?YWNkOUIxcmN3Ymd5aTZySTZjbEhBdTVWekdlRXdBaThIMnFOTitUMlIxaEJh?=
 =?utf-8?B?KzBhbU5pbndybFpqZG15amhna2lWQ29SNHcvR1pqYXpocFRBT3JiVXF3V2Z1?=
 =?utf-8?B?SnhRQ3B5L3J5dXFSZ3IvZHVWQWhLUGZXWllZSWsyM3dMK0xockRRbmQwaEFB?=
 =?utf-8?B?T1dIR1RSemxJTDk3K3lVUWlkWVUzb09oN2doSWR5OUFPZFRoczI0bjZMZDA5?=
 =?utf-8?B?L1R1WnByRUU2OGlUZFgvZld6b2ZlaStHc2FWN05nd3lSZlBEU0xtblRYSERo?=
 =?utf-8?B?dzZPRVBiZDMzVS9sTTNhRW80SGRXMmdEanljVWluUWl1OTBtZUNZV1dZTlcr?=
 =?utf-8?B?a0NwdTdLbkY3ck03aEIreDJIK3FCek43NmV1K1UwSkVDdDQ5aitBaTlCZU9h?=
 =?utf-8?B?S3ZoL01VSnFMUHd1OGEvQmNEQU93cmJZNitVb3BCM3hoWXdPM3V1VWE5OGZl?=
 =?utf-8?B?d3p4c082U21kQVJwOGs5Nk00aGhOa2JscTJiZktUNHUxcTZiL28vSEk1QXhF?=
 =?utf-8?B?TS9oVDIwTTV0S2Vtd1RmMlUvZGF0STNKQzZZTXM5T25RR0M5U0IyUXJOV0tl?=
 =?utf-8?B?VTh5S3gxeUVZQzZjRjRpVlo5ZTlBS1MwM0QvbDE5Z2VzRmZNSkVGaURNaERL?=
 =?utf-8?B?ZFltc0pJZGluc2RJT0pOcEJvaDUrLzAybHByOVMzaFc1ekxObEJObm16YnNm?=
 =?utf-8?B?RGtGWGxrTzh6bTFKVHlIenNiazh0emFZQlJGaXhaL1RTMzNKbTVNeUlsMndp?=
 =?utf-8?B?L0xabXlFa0tORmdORHBSUlJqTFp0NjF0Q2ExSWZ4YkxmU0dHMFNxU1g5OU51?=
 =?utf-8?B?dkt2TlhFOWl5clNnNjF4T2RQMnNVdVlDamZzM1hvQ2szTkM5MHdUMkJCVmRN?=
 =?utf-8?B?VTFtV3ZXWG5XOW8wbmd3Z3RnWTE4K2gzVFFtcWhHQTl2K0VldDJBUi9lNnVH?=
 =?utf-8?B?Nm1nUzUzREtzRFEzbmtBeUNocWhjbjMyZTB2UnBYYzlFakNkdzJzKzQ3TGd2?=
 =?utf-8?B?MWJZYVpTeG5MdktZWXkvSDJuS1F2Qll4bFduSVBuL2grMk5WbGdyOXVQUDFl?=
 =?utf-8?B?bERhMXZJbC9ZazlRZGhKSnNFRWxCb1BCbGxVZHZiakhFSUs2d1R4UmQ5ZFM2?=
 =?utf-8?B?bnk3Y0pjdW90dVMvNW1iUzVkMmdNOGM3WFowaVB1d1VMUWpHSEdZT1p2ZUlk?=
 =?utf-8?B?WGFPbWY1RldkR1N3NGl3OVVleGVuaE9YMUVXZkMrZnFKemROTEg5ZEl5aXpO?=
 =?utf-8?B?RDJNL0prVjd2Rzh1QW5HNlN4dnhuaGViUjg1VXBqVUtnTXpCZzNvaE9tRUFI?=
 =?utf-8?B?ZlJoSnJFUEpOOEJnUmJ6TGVmTzExWEFsRGRzbjA5QmsrazBzaUFNVjJDUFlY?=
 =?utf-8?B?TWNvbHEyUzd3ME44WnBRMkJZWWw5VU5sVE5XenEwZXlzSmZhTHJZNmJlVlE4?=
 =?utf-8?B?MnNZTEdWdkd5NDA3VngyZ052RTBVZXdDaktvck04NW1zZWczNGJadHRoTDZS?=
 =?utf-8?B?RzE4NFVRRmF5bGs1ZldiK1NubDVTSmhuU1dkL1FuNzBFWGlaRGJjaC9xVkd5?=
 =?utf-8?B?Sk5mVGlna0IzUlZuWDNlMXUwTitjcWRHZVdpL1p5aTkyL25leFRCbmJiRGpo?=
 =?utf-8?B?ZDJhd2dnU3lkMEJVUGNFL0M3RFZ0SXRIS1poRWZlUHdkWlFLRHpuRTI5K0dC?=
 =?utf-8?B?ZXhTdlZSNWNpNElxZkxBL1E2VjdaR0U5Q2RKM0FNS2RLdDhCekVFVkYzK0h2?=
 =?utf-8?B?QVlvR3RFVEd1MnlOa2N2M1BFUWJxdXBIaFVXT1l2N1JhYjk5ODJtanBnaEVG?=
 =?utf-8?B?TlBXMXA1Y2VNWEVmWXBWVVRnRENpc2xFZkNNdElES2hWZ0hEZXBXUy9KWUpR?=
 =?utf-8?B?endDSTBHNm1vWCtEWjd0dDBKWWxPc1VSaTJOL0t1Y2krbmxjQ3p3cUFtWFpy?=
 =?utf-8?B?NEt2ZVVyb0szZS94ZmU1K1lEM1MwRHRlUS9tbXp2TmdnUHR3bUNtaU9PQ2tz?=
 =?utf-8?B?WmE3MStRaFBiaVRsU0tKWGJwbERQQnJyaERnVGtKeU4xZEVaZWRBQ2JOMEVN?=
 =?utf-8?B?M1ZFc1c5dkdDU3VnZG1QUm9ROUNDMEZZZ0dCVjhKbWZBUUI2S2xrd3U5RXZD?=
 =?utf-8?B?NUR6OW1VYTNQN0pzMFllTUs4ekxoQ2xEOXdZVThiaE1lc2hDdFZxUVg1N1Z2?=
 =?utf-8?B?TUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6170E04CEE6D9A478A8BACC7E1A7C3CE@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	R7KrQpLHuxqel7qugpPo+9tyg80giWppFLKOXUPV/IRp07HbS8vibTW6L3elkLXRwoqLk4vVN1BmY1MU/vFfqJcY/wZ09AeW/IkhBxRBcWg6BUKveYAsG21vQQZaKrInatyKNnXNti8IxQR11/U9hFbTLdSJQGlE2g+r9H79arVZbKz9TOjDS6cogqjgfrsjSUEEy1VuTKkRlyFsuwrpBYAgXWuv9wF9ZRjbqJR1nUoZhe42uQMt9nZxkM4UcqFfJZUBviIT5TiJn82UsNmmKjFgZvLN4Jym/j2gJ6+hcZSLWIR0DvAYwos80qvXQXeSBQmDbQHjgmrMhTKlANFvPtqUKp8SWi6KXqv4vuLtS38vHyxGHxN6NG08HXKSxFjSnt2cbFc0r+H821f44R8oNFEfN7TdppfGr4D0f2jGZdzFItjUimZjsZhn0AwcY4AcULtjaR4cQtflLMEpP/HBldN8uF6nXAsSdNi7W3jkpGxqsX8mM68QZAZaxd8zo19cCEXZ5kNnTy/ddF93DdHRbptandCwzVcnRUwKPS9sWy29ZSNoe1miaCcicJbIGvH50besAnelsdqe0iGKsv+GRAVWlfboEsNgKpxkVwrz+Ms=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02b2a4cb-a06f-4f88-0e46-08dc8c83972b
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2024 15:06:38.4234
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zlOi+OxVI16XT0j5MpAxYiLVOBsjyBAHaft5S2HMjdyVz0FSr9+nUXr9rocbdqwujCSlYPW+3ohhwWNKUfQ0SA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4259
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-14_13,2024-06-14_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 malwarescore=0 spamscore=0 mlxscore=0 phishscore=0 mlxlogscore=959
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406140101
X-Proofpoint-GUID: eOhIRzSlrJtcEx465sgDDx8JgT-e9HFG
X-Proofpoint-ORIG-GUID: eOhIRzSlrJtcEx465sgDDx8JgT-e9HFG

QSBuZXcgcmVsZWFzZSBvZiBrdGxzLXV0aWxzIGlzIGF2YWlsYWJsZSBhdCBodHRwczovL2dpdGh1
Yi5jb20vb3JhY2xlL2t0bHMtdXRpbHMNCg0Ka3Rscy11dGlscyAwLjExIC0gMjAyNC0wNi0wNQ0K
ICAgIOKAoiBBZGQgc3VwcG9ydCBmb3IgY2hhaW5lZCBjZXJ0cw0KICAgIOKAoiBNb3ZlIHRvLWRv
IGl0ZW1zIHRvIHRoZSBHaXRIdWIgaXNzdWUgdHJhY2tlcg0KICAgIOKAoiBGaXggbWlub3IgYnVn
cw0KDQotLQ0KQ2h1Y2sgTGV2ZXINCg0KDQo=

