Return-Path: <linux-nfs+bounces-8859-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 322069FF31E
	for <lists+linux-nfs@lfdr.de>; Wed,  1 Jan 2025 07:31:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBF2A1614FD
	for <lists+linux-nfs@lfdr.de>; Wed,  1 Jan 2025 06:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A7D3101F2;
	Wed,  1 Jan 2025 06:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="jSU8PH4N"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00154904.pphosted.com (mx0b-00154904.pphosted.com [148.163.137.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC90A10F1
	for <linux-nfs@vger.kernel.org>; Wed,  1 Jan 2025 06:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.137.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735713060; cv=fail; b=JVdnJRVacb31s1AgrjzCwFWRusJfn3ewr26ZjXWaDdkvekYMvUaGJru75SzdxS11JN/uD/u5ElA8sxb/JGC9mOMs9ovlHQx1OEjNCDZ9q9qvCaS8CRMg5hzPmk1LaUhzF9gmjjznYHaWliHmhcaT+XuWwU0eRrNr4+ZDM44o58c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735713060; c=relaxed/simple;
	bh=Wq384ln/vn9qh/XbkA73nJtjWWiYvN7bCYdwulowB/0=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=NWFP3Jqguj19HuSdNFxgtDHmfXshanbuhPwEXsi81CxZwZbrvS3uqsBxjPbHZpkenl2+8xWUV9C9mFYDhxoe76XcL6aMNKwPXv9rvAZtrMpWyRU9QnnPglLsUz7ATu37UdJj8LkxE48dVBt5dlqtog8jMi0wy2YnLlj5IKYgUpk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dell.com; spf=pass smtp.mailfrom=dell.com; dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b=jSU8PH4N; arc=fail smtp.client-ip=148.163.137.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dell.com
Received: from pps.filterd (m0170396.ppops.net [127.0.0.1])
	by mx0b-00154904.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5013hEYg019362;
	Wed, 1 Jan 2025 01:30:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=smtpout1; bh=Wq384ln/vn9qh/XbkA73nJt
	jWWiYvN7bCYdwulowB/0=; b=jSU8PH4N9tIx4T/3tqoYXrSveevDOaHVZeaUB9C
	cMyWiF+Zgen2duv8LzbKDUTUUDPjQuJMvxbu5q1VyLURBbhe0xGz19qYEZZuVUxp
	Le4ubs4xyNHDNaQ2BviXxpp04+znUX3PKJ50IBBMBqD8TMleR+1Os3lZ5bNdAPIl
	WypZciVlj7PM9F+qqtW8m0fY6ePhabeFbYg8LNb7lz0wr4RRoRG/FL9jcoxlWqxO
	2aoCCRKoD88DLbNJmfliy38bn5oIhx801L96ETKi5SVQPUPZISQQqZ5Cdf/EutYA
	bj1VMiNcTVxtgW4+xbjnnZipQ8IFzQXVq8eOGrl/Dc6e4Bg==
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
	by mx0b-00154904.pphosted.com (PPS) with ESMTPS id 43vjuqjq8b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jan 2025 01:30:57 -0500 (EST)
Received: from pps.filterd (m0090351.ppops.net [127.0.0.1])
	by mx0b-00154901.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50164r0U006854;
	Wed, 1 Jan 2025 01:30:56 -0500
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
	by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 43w04b86pt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 01 Jan 2025 01:30:56 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sbovaJIKvdZQPz2fYNJuWmUoY9+m+vX8jBGDfv8CgBLv5mKLA9LLAgHnV/2mwM9SCpzkJANnsDaBqFg/lsG1wNrXt4UFDSTfAxj0iyZCz9SfHY8p3bbt88hcL1RQC3e1TzqnPZLpysdEnefW1hz07eamntIFW/znSizXJwjLO8c2NZmoRNTBCUNKMxvt1bfunMWfVAdcVOjoFwiYffUeu+VbOcziFQqUawqeH3oAS4exQvot85nJ8H89kU1cuRET51YVYFkhT0vDRkoZm9rbcZ0CsQoSWUOCWUtt1/nPEb/RF5sM4YYdn3lS6aOkFHGqu3fOyeFY5dw1goQkYlVJlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wq384ln/vn9qh/XbkA73nJtjWWiYvN7bCYdwulowB/0=;
 b=TXnAtSOn5eQDGI91ecc4/vShAbngsCHxDdgrMobjjGZZfAvEPBAOQ0E9RkBKSUFUpezc7fvr5U2oQgklygdCLWUdRqjO2FMJ3KePvY8KzNF+kUUi0xokgAAp/c+blmHfoyCGLw9ObOPIp8zff0VNaKAl7DeCpokILMcsJliXEsi9OSt/J4l3pVBjGZ6i28SnQqo0Iwz4+NcmCaVkDyLeO/R8jP36Hx04JVIIkGJpeRFaK85CKRlU8F7QMaHgZMe/L5wgiinxsRUom7dWO3lfhRomUkvujUyTfwIGxnbLGjd6QjTIE/42VMnCdCI1z9ipMfkt2lnSoK83RoHiwTm17Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from MW4PR19MB7103.namprd19.prod.outlook.com (2603:10b6:303:22c::20)
 by MW4PR19MB7031.namprd19.prod.outlook.com (2603:10b6:303:228::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.19; Wed, 1 Jan
 2025 06:30:24 +0000
Received: from MW4PR19MB7103.namprd19.prod.outlook.com
 ([fe80::7ef:eec8:9bce:990d]) by MW4PR19MB7103.namprd19.prod.outlook.com
 ([fe80::7ef:eec8:9bce:990d%4]) with mapi id 15.20.8314.012; Wed, 1 Jan 2025
 06:30:23 +0000
From: "Gaikwad, Shubham" <Shubham.Gaikwad1@dell.com>
To: "bfields@fieldses.org" <bfields@fieldses.org>
CC: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "Godbole, Ajey"
	<Ajey.Godbole@dell.com>
Subject: Recall: Clarification on PyNFS Test Case Behavior for
 st_lookupp.testLink in Versions 4.0 and 4.1
Thread-Topic: Clarification on PyNFS Test Case Behavior for
 st_lookupp.testLink in Versions 4.0 and 4.1
Thread-Index: AQHbXBajypFJCOJzHUG4W6/aQc5j/g==
X-CallingTelephoneNumber: IPM.Note
X-VoiceMessageDuration: 1
X-FaxNumberOfPages: 0
Date: Wed, 1 Jan 2025 06:30:23 +0000
Message-ID:
 <MW4PR19MB71034046640E1CB10D338AA1C40B2@MW4PR19MB7103.namprd19.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-traffictypediagnostic:
 MW4PR19MB7103:EE_|MW4PR19MB7031:EE_LegacyOutlookRecall
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3f9b5ad2-8a67-49ed-f523-08dd2a2dc5f4
x-ms-exchange-recallreportgenerated: true
x-ms-exchange-recallreportcfmgenerated: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?13e7c4ta9iMbLT0+kiz0ABIac7+fCmCP1/Mj8D6rSMILZS7Uo+74IcjgdjCe?=
 =?us-ascii?Q?FrI1gqrg4dKDQfT2yu2a/aGNOPYKSglCx+Ur1mFJioSUahJc5R+caWqfv/c2?=
 =?us-ascii?Q?fq2VUf5tHpK1xOx/iWnOkHN8F2ikI34VJWy0afKji9duccn/PCDp4VIBBgJv?=
 =?us-ascii?Q?cZYWptieOPUe152aG0w1+O65a/prCmtN9+GHJ7nn3mPlIeEEHkT61yjlalYB?=
 =?us-ascii?Q?Yg2pPv8tjexTRQt+U58QLzba/etZaHV7EsowhPDwHVzgwhtk/j+bUCVu/Nv1?=
 =?us-ascii?Q?81JRssNuml5+2sArhpLKfyH6ep5IIPlfagwLM9EUutogqlILOzzzq3McpJRT?=
 =?us-ascii?Q?n7rQ7iHYlQdjXWwuBXWoQj58A+0PGMa+ZrT2PbDwiAQZYp/yABb6Wi+Zid8w?=
 =?us-ascii?Q?SX2zEHV9h8Rd8AAKcgvxcdbp+rvbOJNjeOCoD8dytENLl6W6SHub0xY5mQUe?=
 =?us-ascii?Q?jNiLbbMklWfHNm4gUAlLS1GmNrw8aTROUqHYBoYGNDKQAvogLjyr6eJji6ye?=
 =?us-ascii?Q?R1BBgucP6WBxGAYrxaR7yjWNUeKdi1+b+Sg4H5iTHAkfPfNqByiB/rtX595L?=
 =?us-ascii?Q?z9K4gKw+4jGTZIpC3LPh6fR6hl6vIXuwk5eJikuX4XLV8lBBIn4f3WHt8Nns?=
 =?us-ascii?Q?h29gWnZTOu12Gfm3DsmTRbpOCw2EbuiKt6zD/+H3BbrhMtwSI4CB0qwylfqE?=
 =?us-ascii?Q?N4jy+6shknP0NdcN/An4hwd3dtnis5iRvo+BmPyRSI9NUBEZ2/mI1mUbFb2n?=
 =?us-ascii?Q?zTUAomP7mB5oF43VAOi0WkhAWOSaXsUW8ZJcVy2xhMggxqdzFUE5qv7U6cBA?=
 =?us-ascii?Q?+QHxmShPIk0FiLsy25Sk46kphu2o0k8OLoz2gaVaZjIMYGdOHxWniBsQb6sC?=
 =?us-ascii?Q?Ah7BnSPOFtpHlMcF01my7PWal4z0Cref8KFnsxhsbcZ4Z5pcIBg+igPqW4ly?=
 =?us-ascii?Q?jQdLjkJ30CCq9Tj/uuu9JzMJHHmOmmFTalnXhlL7iatGxQiZtI4ox8No6VgE?=
 =?us-ascii?Q?4PTMbc84oQFbWnO22GjWb1GlgzTPtWd298J77AHwIpqDLZLEYBUIdAzd3sxH?=
 =?us-ascii?Q?TZwQiI4UjLxOvIRNOjFtclzd8wooljGgjc/WWUzNN2rkHdDYEIGtn4P99gWw?=
 =?us-ascii?Q?e5DQ3c4MoeyvCqQHc6J23wGEfzztEbM6F1eFALo4VuBEWYTgBVKACs4flbbM?=
 =?us-ascii?Q?8EY19OfgCzLcxybi/dd98G8ZFELu04JsOhkj8RmEufrDOX3zlhJ2CtuDEzm/?=
 =?us-ascii?Q?yeUMamkxb1fwZGqlKRO6NlQ6YkRIgUa65Wpa10nr+FB38VlRnw41SxNZu41O?=
 =?us-ascii?Q?6KDx90yKJ3PLVsAlG8drnGJvYZjhQ4lV0b0LgBAVSHqMs46PdG+ei7NbPiMb?=
 =?us-ascii?Q?ulaG0HQuW6X34vp7u1fuDbUE68oVCv4fetJ2OgQj1RUPWf+eRaHAd5oFwGuN?=
 =?us-ascii?Q?MyeZAxjJi3GGX/bbC+uUKn8nKToyvy3V?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR19MB7103.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?iS9a4aP+RwGT8C0bBsHz9B/VRrr5K1z9CWAc8n//5vX7uTYrIs5OqJNXZCWA?=
 =?us-ascii?Q?4GPGbdg8Lmi/bO73GVt9aQo/kx2BjDtxz5cfAGuhPROlTxcp8uMcBBsPC8DH?=
 =?us-ascii?Q?pZozM6u75LbusZSP2sII8yvNXibeoz3Ay/6g/aX/9WQ0K7tOzNvXXrsv42ty?=
 =?us-ascii?Q?J2Y17DPpAxtwKA9Hr9Ut3u53AzwTWk7uToczFOzNn2+k2NJ+kvXiEXSewVC3?=
 =?us-ascii?Q?UB0lblyxyndsX+F3CGd3sBvW0l4bGIhrNNMVCe2NIcWpfGrWmj8H3iKbQ0RV?=
 =?us-ascii?Q?V+QlvongYjP1ZDkHjJ2qH2kZnS2THxo/iI6QpdIAOioXzzoZ1xX1rxD+2AYg?=
 =?us-ascii?Q?YvAOf7lXYQBG744tcGPXEla3u+lSKSFk5XYsexMl8VjAepnLktJpAfkJur1n?=
 =?us-ascii?Q?7qQDqhlUEs9KvlsV7Q8gXVN1tG7F6DVElx1LcaKc1uyMMgjXp+UJ5vjB6xU4?=
 =?us-ascii?Q?cL7wV/TWilmbMtpm7XQdbety4V5V1C5iEiRjRSKRZF5PVHw4RdsGTfE8jPCh?=
 =?us-ascii?Q?BKUNKeQOy3VkYSeisWOwI3zCQfGw3QKZhf3wV8BwRTeZs5VZ7o8c/Q4bhp+P?=
 =?us-ascii?Q?xSxlZvl2JiWTRufgNyCoCjcAjOkq913c5rwH5VdnGgrE2TaEl79cj7tITQxH?=
 =?us-ascii?Q?oiOCZmzspqO0FjhXYiHP0Vz8FZVm+7mBcxPf0OmC8bma0cbeS8iRx3ntXwFM?=
 =?us-ascii?Q?Bz2utgqPUYxsoaTJ0RYMfqQEkz7zzDIu4/9MrpGKMrhU1IzUGk139cDmBhr3?=
 =?us-ascii?Q?U2WSqfk1vbY8U82q9EimGCZOikV1Aq/D/BUcw/t0bb2vaBFamnqFFvw3Aaew?=
 =?us-ascii?Q?Lwv0yezUQUagXSDXzJA8xa+T9K65HcDd1ODayLTDKBEUTd4D3vx+wguT1xxP?=
 =?us-ascii?Q?GFdkBJMCJYIcAkr89jP3RD+aeMuua7OQotVqH+U8SowUYA8CKLOlftCpqsMx?=
 =?us-ascii?Q?lMFxXMWKs5Q2mTWxb4jAzPRshH7JKb88RGxFaovE6MceeRxlio31jC1eMRIM?=
 =?us-ascii?Q?hqKc9v8uYDzJMq/xmU3aTX16odOJKXZ1VNP6zxZIEc7FBn+N/RaHBb9cxYwj?=
 =?us-ascii?Q?+NKW6QMu1MZXJJFU/Tik4b1WwqWv+ULBLpLBSBWu0SaokrK6YZjThZ47Zq/R?=
 =?us-ascii?Q?PRN3SEAElBebDOIag8jH7mIMlC8Eh2PChE9Gxdf0xvgshiaDAZqLVVod0IVy?=
 =?us-ascii?Q?mEK0emVR6H2Nkb5sXl0vfOd3jbNiYi54wqhG4fn/cCvUPAtKv/DPP0Y0n/S7?=
 =?us-ascii?Q?xpurzQ/lzbWu/uBRrUJfjc2urtI0QBUZU38LDI2aD7vM/eww6PTr29utT6Gf?=
 =?us-ascii?Q?3YP43hudNu6GhRFz2IXnbWA432XouvBwJ/DEh/E0fc+ZgRCLbj9IB7RGZ1Wd?=
 =?us-ascii?Q?QUxNNmGfsBkLtyq4iCLPyUJdjD/BoKUX3rTCLUwIzFxI8710h6kmZOYsYv8X?=
 =?us-ascii?Q?zI6toFJoJPddGQ7ALd2clTHUav7U8GMMnYd0KPLPGfwqxcf1QKI7Z4hslHk7?=
 =?us-ascii?Q?VsuitHYVdblrupRezxbWFI31JSzstwjjHTbwjHVhL3TTts1F/RhluYexCbjq?=
 =?us-ascii?Q?HgyZEaywH9Z7luMhMfN9ajgeTBt9uNDysp5zjsM2?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR19MB7103.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f9b5ad2-8a67-49ed-f523-08dd2a2dc5f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jan 2025 06:30:23.9130
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H15VLRSGHaqFn4jZSQ+NwgoCONrRdYwtkuEU5sGtT3VtjNsib2LzwDhKBGBTmySFnXY4H2ICtZ7ChmC40uTv3VD20S4DRpV68JmDlsxy6x4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR19MB7031
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-27_01,2024-09-26_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 impostorscore=0 bulkscore=0 mlxlogscore=774 mlxscore=0
 suspectscore=0 malwarescore=0 adultscore=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501010054
X-Proofpoint-ORIG-GUID: Zs21oL7gx2pTyEkbPwgU1aQdqNaSYiDB
X-Proofpoint-GUID: Zs21oL7gx2pTyEkbPwgU1aQdqNaSYiDB
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=733
 adultscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015
 spamscore=0 bulkscore=0 malwarescore=0 phishscore=0 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501010054

Gaikwad, Shubham would like to recall the message, "Clarification on PyNFS =
Test Case Behavior for st_lookupp.testLink in Versions 4.0 and 4.1".=

