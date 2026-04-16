Return-Path: <linux-nfs+bounces-20855-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sITIG/KN4GnNjgAAu9opvQ
	(envelope-from <linux-nfs+bounces-20855-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 09:21:22 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DB5940AF82
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 09:21:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ED6CD3093898
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 07:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F94A3890F9;
	Thu, 16 Apr 2026 07:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lenovo.com header.i=@lenovo.com header.b="53W5yrcr"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00823401.pphosted.com (mx0b-00823401.pphosted.com [148.163.152.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3DA5CDF1;
	Thu, 16 Apr 2026 07:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.152.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776323949; cv=fail; b=jP0YzkiBX/k6wJo/NDfzf+2at9SYw8/BXZS1Bpxv9MRXYYRvDMEfgmyafLeHnW9Q4kAoq0fd885Cw5+CGkUZ2QEgozpaNDgXfmSYv9rOcvbuqtRFBO8l0iGTIVE5URAggYCKbuv3XRVgLV1nywlkXiE7ZPzmCHci6No6u6XpuNE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776323949; c=relaxed/simple;
	bh=arLvYOgCTn6q9Fn4+hYL3/CZamR6UWviPcQhO9uqYhw=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=QlNmcuP+ijb3irW7zbQp4gA2rZ3j0X2VfR3f10acm7Bst/WpaNWJKWzT+c4ugfgFD8AbFD17qEzu3MzfcnxWDMqaX6Q5BsJIh1MydpmxWF0URUMw2w8AhnwzENPxRfy8TFGozCLZZoltIE0Hv198DS5mrdGcGeIctw0K7IyymBs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lenovo.com; spf=pass smtp.mailfrom=lenovo.com; dkim=pass (2048-bit key) header.d=lenovo.com header.i=@lenovo.com header.b=53W5yrcr; arc=fail smtp.client-ip=148.163.152.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lenovo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lenovo.com
Received: from pps.filterd (m0355092.ppops.net [127.0.0.1])
	by mx0b-00823401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63G5DX6i3277226;
	Thu, 16 Apr 2026 07:18:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lenovo.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM202306; bh=c16yGZRZLVplkSA81eMpU
	tx92BpabFrIEX5EqzDSpi8=; b=53W5yrcr1O8bvMC88uM+LcqukMCQpiMuEmj6+
	UArpQ/KNaXAr2KZFCF+7qu/07o8k2l+h/A8sZCTsuuak6xEAOIQI1ereAH39d2rX
	5DItPW830TFi9tIHLd1QypfZnkzU2Z1wKUANTfSwTh7nCD8N2dhVqKTX2YLKR28r
	yrA+PPvQb/Dij9MCNFOAZcR8HY9RQCmVp0Zq87a4YuGwiwEl/xE42vXSiYcI/LxO
	FEEHEIAquBjyfdKL+ueSA3FV/xsXtlD7DvOiyJcpe3cRPxrKkr5OX65cdIH6t1G1
	P5uyEQOh2TXSG/gA6tMH4/1PtLTK+EQm7HVAsim64N3hieE2w==
Received: from seypr02cu001.outbound.protection.outlook.com (mail-koreacentralazon11013056.outbound.protection.outlook.com [40.107.44.56])
	by mx0b-00823401.pphosted.com (PPS) with ESMTPS id 4dh856ej6y-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 16 Apr 2026 07:18:52 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Oo7l7TGtocBkMbI1cPe/8gYuuT7WbCWwMluukFnVacNxx+CxbIAfdbtI/M23Lo5tqKqvLEk6s0SAnpn/NcFahyGF7/Wzf04WfX+lcNASVWJVLwmmcNPlmdmiyy5zUh+UdJHy+igQIBvLOn7JJMMhPf39mHP7Z52cViAYAX32Kd9GfCM4fAMDPQQL+RN9QK5N3To+FNj1T4ngvFZPPl6e+M3TXV4Ff8pnXi4jKEhpSMU9qqDhTxwpxd+WyrWJiAX0klP27cYSGiQH5tpjgt8n6dg3fwHaoT5pJXfrDya7wuJB/JonhOLsi0oFD/lpvonXScVRyWdUeaINDA4qtFGS7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c16yGZRZLVplkSA81eMpUtx92BpabFrIEX5EqzDSpi8=;
 b=AhSN/Ko/OiQDX1LVqYOfbWhr1XZxuZ5TDessTuijWlWl9hMAYwADaFP4wu9Cw7rQLgY9PSielbeigzhME4oF7q8I/dUlHgvxvX9FAI2l4Mwt4UOCYBRugnCANx5ho3IuNAJcCiG0Cn4ZY8i1awS2W4ApD5EdfUa4LF6zBlDMUZOZrRmvgGLeOTuEKtAsh4EIHD2qzk8KqCwdufjdUCsFLkT6eTgRkvapOO95RUGtkn8G5ADox9uWMDaNcgJuRCeulFjanyHgVaHZdrDSRWKy7mkg3qnFznfzlEkOyyb/mZ6UH+3nkt7cZpRflyQMej0oLABDkNRTLwOGTrEEv/JPJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=lenovo.com; dmarc=pass action=none header.from=lenovo.com;
 dkim=pass header.d=lenovo.com; arc=none
Received: from PUZPR03MB5990.apcprd03.prod.outlook.com (2603:1096:301:b5::10)
 by KUZPR03MB9759.apcprd03.prod.outlook.com (2603:1096:d10:64::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.21; Thu, 16 Apr
 2026 07:18:49 +0000
Received: from PUZPR03MB5990.apcprd03.prod.outlook.com
 ([fe80::15b1:fccd:e3ae:f89f]) by PUZPR03MB5990.apcprd03.prod.outlook.com
 ([fe80::15b1:fccd:e3ae:f89f%4]) with mapi id 15.20.9818.017; Thu, 16 Apr 2026
 07:18:49 +0000
From: Lei Lei2 Yin <yinlei2@lenovo.com>
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>
CC: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/1] NFS: pnfs: cache data server entries for a short grace
 period
Thread-Topic: [PATCH 1/1] NFS: pnfs: cache data server entries for a short
 grace period
Thread-Index: AdzNcRvOIa3JpI7jRJqdIQH1+3UHEw==
Date: Thu, 16 Apr 2026 07:18:49 +0000
Message-ID:
 <PUZPR03MB5990F21107A5F9CA14EA6D1288232@PUZPR03MB5990.apcprd03.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR03MB5990:EE_|KUZPR03MB9759:EE_
x-ms-office365-filtering-correlation-id: b4e5e832-f189-46a4-e74d-08de9b8867ad
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|38070700021|56012099003|18002099003;
x-microsoft-antispam-message-info:
 2qBH+7sOdmVl2HKqYsJZWWhNttdYr2N5ubRcXV/YGWyKJuy6lnNu7c4T7bnjzq08cgq9gvnw+Q0wagR//Cu2agHDFKh8uktIbmfojggZLjFQCvb9/2I9NA5agsag2wtL52BpRdY27vBUZ/0WXlN1htVhtR9tof4VVLMz6aKAunAhV2ddUloYUG8RFdhdtx7HG4RDIjDVvI2n9aEZJvZLi7Zg09McKOWu5nHb3eTvmyahDh3+y+0rvpMOrgHH9M2gIMGjHSPXu5722Bnr/yTIAoeZt2oxQdxvsVJO9nbUrCZbA+3EesGQUB3mqJL+B0R48cOezzy390j5wsjFwgtCWCfXvr1hwpFz7I/93vKvFh8hQXxv8kEanhpSTM6BMvqocy7eMi/SKXte8ODD/XWgltd7n8EHZ8AzHzd0lMZLHSZ/cZ05kcKt5x9KF3VUnkjlkC+v0QodIrf9dTytGcPRWFahcB9RrHoOXRcsASsecYXZaNuzknNXR0VIm8H2cfFXi8fJ62k1ETyM1P4njtbqrKA/7G+9bvE19TreZj+6Z1kfKUUNsNUreRC4Zn6/bZFWR+gXfI2/U47TwrTO21c+sioxPs+FlL3Q6JKVcIx2Vkm+Wzt0h6nEq4IIMuO9tsvfBaZVA1pIOcPP8fy2wuBa9qp+WK7RJIav/TFa0kvxnCLhQxsMbJVMGcwYhpqEGJTN0IpTVk5A7rWnq5vISTo/CwvKhQ/UxfMBnB/0BZ8PpZcvNC2ZLi610Zb0jMO0j/qwQl2icgr+p0ELhxJpgy71B9h9QMtlfyqxHrpCSyu0yec=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR03MB5990.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?lZZdZT/OOqR+fL7BRZMGsfu4rhyUiqP4XDwiAT2MDyFL3cpjz06vqFMp/l4d?=
 =?us-ascii?Q?vyC81/Dy8teREfa/marnrw9aFFPfzm0KXhx0GErsoI8QrQKQEWuu8nvlvJV6?=
 =?us-ascii?Q?3dmjsIarAnZYa8O75Wb/FvBM8qQM7HTdQyF6xs2fCtS9r2yIFhfYtD3mYmbv?=
 =?us-ascii?Q?cxm8qqNtQs2e2i3Vs57hHL2ojyaoN3Mbg5DPGoOoOZ6uYxTN6XbB3TcMyahb?=
 =?us-ascii?Q?lNOCj0Nbq739+PBeCzlYmcvOe2Ub6undzbPNKqkX1I5Zx+P05arVRwGF8X7H?=
 =?us-ascii?Q?rhLoS030p9UtziONUvZM8rc3awKCvgCroUnHkcHQkyJyMj87xVzUI8x8aCUA?=
 =?us-ascii?Q?HnwzAfNW+Lr91pxg4kzIhnDUNriVXN5+8YIqom0gGPDUl/IzgXbS7+3DDG3K?=
 =?us-ascii?Q?PphQDwkKhpuvsKhNjB6DckD2+UAv19vlp75C8HJ0qjxUtVdB+KrIz1pMWuxh?=
 =?us-ascii?Q?XgqJljQXzhmb7hkk9/qD5HmcF/hN+E2tvjXzrLC8Rs8uv57FVKG4nY1oC3I+?=
 =?us-ascii?Q?6RxcG6rSVVqqJ9keo9YORvmmvopg8ZXFogI15wpfjpc772Zy6KvDMa15fFps?=
 =?us-ascii?Q?KEqFQiWmXQ7+LmxrdHi9z38cmiUtHo39OCCzbILEUkusRm7rlvWad44ZHTKh?=
 =?us-ascii?Q?xMggJv+0qsCOfl4UIoebSAKqHvK7ar0msF9lDsObdlkSYa/7wt7kkg25+zQK?=
 =?us-ascii?Q?B6SVZaoH7ktjxlMDGkvQjMtG9QmpuMiyModIW5beFhjfKm1U6VyGpTU6VHYl?=
 =?us-ascii?Q?ghxPiaqVWVnCaZOMXQEMz4IX1NHo6lZmQPP9r3JXCdd9JGGT2a2zA4ZPcxkZ?=
 =?us-ascii?Q?4TRq4I4T5INvPPwLSCVVE6dViK6usWp0NlS2NOfUqmWDWBRv/Smgxyy6xXKl?=
 =?us-ascii?Q?9K96hzy1p5xi9v3Mtt9W4ENhlVzM9qUWwS6uQD7X2bxjRdBkqLQGp0S6Uozd?=
 =?us-ascii?Q?vx81lQ8TxYwgF5yIijSeuAkU8PDvFKr5jhn/3LZ2VqBxYNu2cK2kR7HCTdNz?=
 =?us-ascii?Q?zHBB9UBjp7RmAYNFUy9xGpGJxO46M402OZyGBZjHQ2GWXc5ufVEg8+NfLcol?=
 =?us-ascii?Q?jfqCGXLqDnde430L4o5W7WHxpcfSH5Z9ecryLMjCyWJfTrHU8x33qvft5G1Q?=
 =?us-ascii?Q?KRH/eVolAkXiuja9yhBJ6JJEIqT1niuaeuyX4sFXXjRm6A7juRGKpXvT+8uE?=
 =?us-ascii?Q?Nbt3FuoGAwAxOCmJ9ikWcmyudCbcYEHUuckq3E6fgPkaQqGqei5fHRhS4b70?=
 =?us-ascii?Q?wnsV9LVPeAmnIY+7O0zLxE6RrNABOhN5rr9Mz9YUdNebOOFJTfFfbt1DVJq9?=
 =?us-ascii?Q?S3Xk8K0IFAxUqilWQtFR39pheQf4qkUgPlVHiyVG2pme/7tOF0dYwbrK/kiz?=
 =?us-ascii?Q?YZ9RGbQsmvMofgQdbwr7swirL9ifdyvHzDz7ytMC1v8bbCGCf95nfAh5tM8R?=
 =?us-ascii?Q?02CdZBtLAwAqQzwE/qlqwnBlcdMSXaoKrwU7zlLCCQ7cqL2X7BSMb/YEe+c5?=
 =?us-ascii?Q?mvfBxV0i8xWM4uaXOEF4RBikiuFac8CMAE0s6nzfYyUad0g+Z7fe/PDUKxrb?=
 =?us-ascii?Q?ejoTAgyY/B4IVMtbZJ8tbCGL4jZXljtv5KJRHYfbo1WVIV+/Cu8kxKFxlX2k?=
 =?us-ascii?Q?uve+Tdz/lPdWCGpfs7XhX5dh2w6cLNccpZvg//2Xl6dzOSdvjIqUKKO3L95R?=
 =?us-ascii?Q?1hodcAr4bKgnoXLIJYu8sK5zwHUbTfL7DIEecqiLpUG8/b/9?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	bD7ppPxuepIHa9FzWFqUTymGZwGDRdowsqMK6ZboMLhJYZQsd8dZlwBBgzFVuXGsr4dTFdZMAEbL5Fz6mC8/E0rfQr5Ra6U6DyR0dUfBjLBQ9tYIY9hH3gc2asW+T9WfXhd8/ZISKmLMYmgVXhQOwDFHoAmRIfjyGzG820/wcynO9sjLXY6PnBM+jxoIiRh/ZPExHUrFnHR92bK9vRERVO88SfPQsJUMu3d2jT0gXhXDAV5Y/uEsooczbyqMz57QPK7LeAhvDoYdeVaN8belPNZNTQQzVP2bH8LXUI6VHRNewbQL8EUT/bvYx/KMpFznHTTqUUBtTQ6sS/1Dj3lK4w==
X-OriginatorOrg: lenovo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR03MB5990.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4e5e832-f189-46a4-e74d-08de9b8867ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2026 07:18:49.0330
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5c7d0b28-bdf8-410c-aa93-4df372b16203
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yO1dtJ6yMocmH9ywQkjXqI14febwxs/rLb6RNKP2Q3DK0AEKmUKtLf1KHysVdMw5ah5i+7ZkNlhfzzdvJx/SmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUZPR03MB9759
X-Proofpoint-ORIG-GUID: Ce3MkF8lSIkl2Dx5uPUcoO1ECfMf09Wj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDA2NyBTYWx0ZWRfX3yiMUzoCX7gm
 S0VwQhwCZSCBIMeyuVZ1xfRRC3DZT9WGxkw0cLx0xFbf/tLQkGT/YoEMq52DfyAVAX92TJ6InUk
 JwhpFHFGzhvYQw3hbdGlbwBpFrxOuVLiVCnYzWUrL2h7nfPCIivm9YSVQ76QusM04fn/h28Buh7
 19hn7PqpSgwxDHNxASCbG1ZKN22mPOoS0Ykk32hVWXjYXVcfImqCgk6HK0LwgV5AMDSvgqtjlYE
 0paAuWPvejgdWCzT5ogJm7P9kVmsRRFKbY8lnuwWosgOrFXFWTadH9n4g3fg9K/ASxv+8VD7vKw
 +G8ve5qQ6BDUOdpwJJnoF2xZGIOFMQ8jnXC9KTovkRSCRiLL7uQ2d/rQj/5DgzJTC3LK/9BrbQz
 D83xk3WyRkNxVoJu/y23r8yP6xhl9s/9MSlvNXnYmj8Zl6BAEbcx7GMcUc55p+I74LQ9LJS7pzJ
 PIRA0mAoYiNvurzrdOQ==
X-Proofpoint-GUID: Ce3MkF8lSIkl2Dx5uPUcoO1ECfMf09Wj
X-Authority-Analysis: v=2.4 cv=aelRWxot c=1 sm=1 tr=0 ts=69e08d5c cx=c_pps
 a=kREF/9fVw4pIOCO+4zMS5w==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=2RTuljz969oO5usasWGy:22
 a=rq6KeYSQr_4CDViOXtGD:22 a=8k6WQxmsAAAA:8 a=gABwnJUQ6V6-jUjrbaAA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_02,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=-20
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604160067
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[lenovo.com,reject];
	R_DKIM_ALLOW(-0.20)[lenovo.com:s=DKIM202306];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20855-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,PUZPR03MB5990.apcprd03.prod.outlook.com:mid];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	ASN_FAIL(0.00)[10.253.234.172.asn.rspamd.com:server fail];
	DKIM_TRACE(0.00)[lenovo.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yinlei2@lenovo.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 3DB5940AF82
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From c0ce7c997fdd383964b729c3398770a9aaaaa178 Mon Sep 17 00:00:00 2001
From: Lei Yin <yinlei2@lenovo.com>
Date: Thu, 16 Apr 2026 06:42:50 +0000
Subject: [PATCH 1/1] NFS: pnfs: cache data server entries for a short grace=
 period

pNFS data server cache entries are currently destroyed as soon as the
last reference is dropped. Workloads that repeatedly open and close the
same files can end up tearing down and rebuilding the same data server
cache entries over and over, even when the reuse interval is very short.

Keep a data server cache entry alive for a short grace period after the
last put by deferring destruction to delayed work. If the same data
server is looked up again before the timeout expires, cancel the pending
destroy and reuse the existing cache entry.

This avoids repeated cache churn in open/close-heavy test workloads and
helps reduce the extra read/write latency that comes from repeatedly
recreating data server state on short reuse intervals.

Because destruction is now deferred, reap scheduled destroy work during
netns teardown before checking that the data server cache is empty. This
prevents pending destroy work from outliving the netns exit path.

Signed-off-by: Lei Yin <yinlei2@lenovo.com>
---
 fs/nfs/client.c   |  1 +
 fs/nfs/pnfs.h     |  3 +++
 fs/nfs/pnfs_nfs.c | 57 +++++++++++++++++++++++++++++++++++++++++++----
 3 files changed, 57 insertions(+), 4 deletions(-)

diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index be02bb227741..65ab219ea206 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -1287,6 +1287,7 @@ void nfs_clients_exit(struct net *net)
        WARN_ON_ONCE(!list_empty(&nn->nfs_client_list));
        WARN_ON_ONCE(!list_empty(&nn->nfs_volume_list));
 #if IS_ENABLED(CONFIG_NFS_V4)
+       nfs4_pnfs_ds_client_exit(net);
        WARN_ON_ONCE(!list_empty(&nn->nfs4_data_server_cache));
 #endif /* CONFIG_NFS_V4 */
 }
diff --git a/fs/nfs/pnfs.h b/fs/nfs/pnfs.h
index eb39859c216c..8c198d577465 100644
--- a/fs/nfs/pnfs.h
+++ b/fs/nfs/pnfs.h
@@ -64,7 +64,9 @@ struct nfs4_pnfs_ds {
        struct nfs_client       *ds_clp;
        refcount_t              ds_count;
        unsigned long           ds_state;
+       struct delayed_work     ds_destroy_work;
 #define NFS4DS_CONNECTING      0       /* ds is establishing connection */
+#define NFS4DS_DESTROY_SCHED   1       /* delayed destroy has been schedul=
ed */
 };
=20
 struct pnfs_layout_segment {
@@ -415,6 +417,7 @@ int pnfs_generic_commit_pagelist(struct inode *inode,
 int pnfs_generic_scan_commit_lists(struct nfs_commit_info *cinfo, int max)=
;
 void pnfs_generic_write_commit_done(struct rpc_task *task, void *data);
 void nfs4_pnfs_ds_put(struct nfs4_pnfs_ds *ds);
+void nfs4_pnfs_ds_client_exit(struct net *net);
 struct nfs4_pnfs_ds *nfs4_pnfs_ds_add(const struct net *net,
                                      struct list_head *dsaddrs,
                                      gfp_t gfp_flags);
diff --git a/fs/nfs/pnfs_nfs.c b/fs/nfs/pnfs_nfs.c
index 12632a706da8..79a96e5264b8 100644
--- a/fs/nfs/pnfs_nfs.c
+++ b/fs/nfs/pnfs_nfs.c
@@ -653,18 +653,65 @@ static void destroy_ds(struct nfs4_pnfs_ds *ds)
        kfree(ds);
 }
=20
+static void nfs4_pnfs_ds_destroy_workfn(struct work_struct *work)
+{
+       struct nfs4_pnfs_ds *ds =3D container_of(to_delayed_work(work),
+                                              struct nfs4_pnfs_ds,
+                                              ds_destroy_work);
+       struct nfs_net *nn =3D net_generic(ds->ds_net, nfs_net_id);
+       bool destroy =3D false;
+
+       spin_lock(&nn->nfs4_data_server_lock);
+       if (test_bit(NFS4DS_DESTROY_SCHED, &ds->ds_state) &&
+           refcount_read(&ds->ds_count) =3D=3D 1) {
+               clear_bit(NFS4DS_DESTROY_SCHED, &ds->ds_state);
+               list_del_init(&ds->ds_node);
+               destroy =3D true;
+       }
+       spin_unlock(&nn->nfs4_data_server_lock);
+
+       if (destroy)
+               destroy_ds(ds);
+}
+
 void nfs4_pnfs_ds_put(struct nfs4_pnfs_ds *ds)
 {
        struct nfs_net *nn =3D net_generic(ds->ds_net, nfs_net_id);
=20
        if (refcount_dec_and_lock(&ds->ds_count, &nn->nfs4_data_server_lock=
)) {
-               list_del_init(&ds->ds_node);
+               /* Hold one temporary reference during the destroy grace wi=
ndow. */
+               refcount_set(&ds->ds_count, 1);
+               set_bit(NFS4DS_DESTROY_SCHED, &ds->ds_state);
+               mod_delayed_work(system_wq, &ds->ds_destroy_work, 10 * HZ);
                spin_unlock(&nn->nfs4_data_server_lock);
-               destroy_ds(ds);
        }
 }
 EXPORT_SYMBOL_GPL(nfs4_pnfs_ds_put);
=20
+void nfs4_pnfs_ds_client_exit(struct net *net)
+{
+       struct nfs_net *nn =3D net_generic(net, nfs_net_id);
+       struct nfs4_pnfs_ds *ds, *tmp;
+       LIST_HEAD(reap);
+
+       spin_lock(&nn->nfs4_data_server_lock);
+       list_for_each_entry_safe(ds, tmp, &nn->nfs4_data_server_cache, ds_n=
ode) {
+               if (!test_bit(NFS4DS_DESTROY_SCHED, &ds->ds_state) ||
+                   refcount_read(&ds->ds_count) !=3D 1)
+                       continue;
+               clear_bit(NFS4DS_DESTROY_SCHED, &ds->ds_state);
+               list_move(&ds->ds_node, &reap);
+       }
+       spin_unlock(&nn->nfs4_data_server_lock);
+
+       list_for_each_entry_safe(ds, tmp, &reap, ds_node) {
+               cancel_delayed_work_sync(&ds->ds_destroy_work);
+               list_del_init(&ds->ds_node);
+               destroy_ds(ds);
+       }
+}
+EXPORT_SYMBOL_GPL(nfs4_pnfs_ds_client_exit);
+
 /*
  * Create a string with a human readable address and port to avoid
  * complicated setup around many dprinks.
@@ -745,6 +792,7 @@ nfs4_pnfs_ds_add(const struct net *net, struct list_hea=
d *dsaddrs, gfp_t gfp_fla
                ds->ds_remotestr =3D remotestr;
                refcount_set(&ds->ds_count, 1);
                INIT_LIST_HEAD(&ds->ds_node);
+               INIT_DELAYED_WORK(&ds->ds_destroy_work, nfs4_pnfs_ds_destro=
y_workfn);
                ds->ds_net =3D net;
                ds->ds_clp =3D NULL;
                list_add(&ds->ds_node, &nn->nfs4_data_server_cache);
@@ -753,8 +801,9 @@ nfs4_pnfs_ds_add(const struct net *net, struct list_hea=
d *dsaddrs, gfp_t gfp_fla
        } else {
                kfree(remotestr);
                kfree(ds);
-               refcount_inc(&tmp_ds->ds_count);
-               dprintk("%s data server %s found, inc'ed ds_count to %d\n",
+               if (!test_and_clear_bit(NFS4DS_DESTROY_SCHED, &tmp_ds->ds_s=
tate))
+                       refcount_inc(&tmp_ds->ds_count);
+               dprintk("%s data server %s found, ds_count now %d\n",
                        __func__, tmp_ds->ds_remotestr,
                        refcount_read(&tmp_ds->ds_count));
                ds =3D tmp_ds;
--=20
2.43.0

