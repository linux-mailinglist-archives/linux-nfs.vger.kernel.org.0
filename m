Return-Path: <linux-nfs+bounces-2608-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11CBF8962D6
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Apr 2024 05:15:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B6A31F234BA
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Apr 2024 03:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7871D1BC59;
	Wed,  3 Apr 2024 03:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="yKNsxmG8"
X-Original-To: linux-nfs@vger.kernel.org
Received: from esa15.fujitsucc.c3s2.iphmx.com (esa15.fujitsucc.c3s2.iphmx.com [68.232.156.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D033D76
	for <linux-nfs@vger.kernel.org>; Wed,  3 Apr 2024 03:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.156.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712114108; cv=fail; b=GTHDGuIejw0xz8c8N8pHPbUPJJKyz4pxQLKqkvuEta1Fxkz0/YTlJmDD2ryglHteB54ntQtcOuo188i/+Ih7MO5FXJg8jg7nCOiFNX8HoJIT3Aav0Yd/KjdqYa67y4Lj57S5FhZFSvkIzf5PXQx6Ko1wNiOtWFiMQHodvRayeDk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712114108; c=relaxed/simple;
	bh=ZJZWajq4ZvOU8fu8Pk6zx+H/db+D0zzHSshg4vcHaH0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jJz8Z9tsO049FzN6CHJgsX/crcFzlV8JF8XUqwORaxkiC47U54NeBe4YDWQxYCEop9zqbZw6ccoUeCK3lotKawGE7H9cL+LUjFjaLIoRnpj+OZNr6MkB1p/gx1flpZnhzSeBH1S/iK4gzlVryuIlnaTTCMzR6+cB1t1BlOpIyjk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=yKNsxmG8; arc=fail smtp.client-ip=68.232.156.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1712114106; x=1743650106;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZJZWajq4ZvOU8fu8Pk6zx+H/db+D0zzHSshg4vcHaH0=;
  b=yKNsxmG8p8EJ845h73V83nvSWV3sThUFhdPXWdlJSrOTPKfJ580Tkn0A
   FbHHQkXjIawCszPhaaBpdpMVIKw7n7uvJ5oxd1xDJE8fQThmMlUbYoCW4
   dPiv6WKyKHT6uFsDkBDkR4BU0uT4xoAxE5GGqutrzkuDa+eehoaT8uvkz
   hCsCXLH2JiNv8wZMURTfsz6vPaO+tNFwZSZjN/m9/xugsrYK8jx8vs6hI
   pY7mfXo2hvt9iL1eBLweXbOF/Tkjhf/LAQDKECyFNT9SnprKExbIJYfC0
   D82s+JcwRFZJSW73AlBirlwAaQZnU6D8Bg4+tgroo4McEXzhXHRNUc1sJ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="116043701"
X-IronPort-AV: E=Sophos;i="6.07,176,1708354800"; 
   d="scan'208";a="116043701"
Received: from mail-os0jpn01lp2105.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.105])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 12:13:53 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S4l+YqTBKeARM1Wg7mk4qlZQ4rJaRJ/WmJHemPFLbolvkVusRFprf+iSIjw3Zlj4JYIIe44zRax0RKWdvdISTxYpSxf6qdGEpiCOxk8cqRDwNn0fUlK13fCYBDch+hnI4qoUYTK9jeT4jQRQQYEOEIB9nGHgtpka29PJkSCh0S1aDLmbvN1jl9nRmgwMkuW8G2Jp466zw+0nvua2TrzxEMpBLxD+P0iy6jl3rFsZ+MSWghLPafNZG/6YjbolAtOPZznDZpz8jcT4ERYUGUW9LZmjn8B708+BWc5NFCifcR93hsW+CgK5qEyvlBBOJHDQ4y+5gJKeyGyFRxoeLxGB2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZJZWajq4ZvOU8fu8Pk6zx+H/db+D0zzHSshg4vcHaH0=;
 b=ADu7fh9GXoaelFuX06OyqqSyZ4lbta4y4oe9gLRiMhRQuOLfD5QjfhQyIyVYAJas8t2vtreeuVuxFRiJytp+O5mVAGeuk7bkGToc9oBZKPNYzZ3+Y+fV9CpxEveyDoee33xhIKoJlLfkVbpSclV+66G41qKsWBTIxwAqeCGc4vAkqKO+i5R7erazY+FlwCPlob04yCG+7JqDDRJZ82BMUbzcEVrKxkc2ZJ46q16DyPQzA/0pvjMan1Lp1RWbQkhWc94Nlgac5nzlFyjul3CNqnttrtH1EmZPrY4e/Yu2SoySKUKJHjRI82QAGriOUKizf3LkxSlsi7h24sFc72UghQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYWPR01MB12085.jpnprd01.prod.outlook.com (2603:1096:400:447::5)
 by TYCPR01MB7750.jpnprd01.prod.outlook.com (2603:1096:400:17b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 3 Apr
 2024 03:13:49 +0000
Received: from TYWPR01MB12085.jpnprd01.prod.outlook.com
 ([fe80::d966:f2b7:cccb:3485]) by TYWPR01MB12085.jpnprd01.prod.outlook.com
 ([fe80::d966:f2b7:cccb:3485%5]) with mapi id 15.20.7409.042; Wed, 3 Apr 2024
 03:13:49 +0000
From: "Hanxiao Chen (Fujitsu)" <chenhx.fnst@fujitsu.com>
To: Steve Dickson <steved@redhat.com>
CC: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [nfs-utils PATCH] mount: reject "namlen=" option for a NFSv4
 mount
Thread-Topic: [nfs-utils PATCH] mount: reject "namlen=" option for a NFSv4
 mount
Thread-Index: AQHafETsonzA6nncy0qGzkJuljtQv7FVOtyAgAC2fEA=
Date: Wed, 3 Apr 2024 03:13:49 +0000
Message-ID:
 <TYWPR01MB120851462E62327212E483FBBE63D2@TYWPR01MB12085.jpnprd01.prod.outlook.com>
References: <20240322103618.1270-1-chenhx.fnst@fujitsu.com>
 <ac34a186-68d2-41c6-b350-2f0d425eb156@redhat.com>
In-Reply-To: <ac34a186-68d2-41c6-b350-2f0d425eb156@redhat.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 =?utf-8?B?TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5Njgw?=
 =?utf-8?B?MmZfQWN0aW9uSWQ9NTU2YjQyZDAtYjEyYy00MTNmLWEwMTAtZjFlNGQxY2Zk?=
 =?utf-8?B?MDIxO01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMz?=
 =?utf-8?B?OTY4MDJmX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQx?=
 =?utf-8?B?LTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMzOTY4MDJmX01ldGhv?=
 =?utf-8?B?ZD1Qcml2aWxlZ2VkO01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFk?=
 =?utf-8?B?NTUtNDZkZTMzOTY4MDJmX05hbWU9RlVKSVRTVS1QVUJMSUPigIs7TVNJUF9M?=
 =?utf-8?B?YWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfU2V0?=
 =?utf-8?B?RGF0ZT0yMDI0LTA0LTAzVDAxOjM3OjEzWjtNU0lQX0xhYmVsXzFlOTJlZjcz?=
 =?utf-8?B?LTBhZDEtNDBjNS1hZDU1LTQ2ZGUzMzk2ODAyZl9TaXRlSWQ9YTE5ZjEyMWQt?=
 =?utf-8?Q?81e1-4858-a9d8-736e267fd4c7;?=
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB12085:EE_|TYCPR01MB7750:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 rnFJKk3N5VpByMTUBPzZ7YqHXMeHWs1MCy8YFNmExWO9FDbYd5g0g1/PEL3fh3441YUc+MBpLN2In/orPiepG1cNjN/mqU0YuyIchyGaoXU7VJSvXS3ZCutl5ElSi02U3WmV2ZHCqdpzoeF1QMmhixJJHXhbxaDw+IDOQPf9CQer/5Mtot4O9umRQXC9FBwZ3dkBENDvTtVJZ3gZQjvYQ2NyOL9W0ptz6QpV9J+sFFFcwsbRjvkmObqq4iNP4xEalEN9EoyTxU8LmJWz/Wv3GmneGzK9yKLfoTVN7zVm4ZjI9UghVgAmPV3ibl4b3RhXhxIIqH8e6xrQk2/alAyMOR8QB2LhxfkmQw/2yYWBn9UbXczI9l09u4Tc/3GL1m3QbxaYfUn9jHn4rNm1OMI/D+uNDeYvNccnu62lMOuqptWf3qpKEwespbxpOXkpDjGvwu1QZY6+iJtv38SDIrN8ISjbz3GxS+/sZxQnmJmhAB2DSQzMIEUM5TiXB7GLuorqrr2DGsO5dwhxbVD6B14gFbXjqGwKUqtHw5ZWGbRSGcPAmtQuwzaLfL8GQip2faGZqGkpYJvw4QyEZNbzVS1dG8HyittHAkly5NVgp6SXH/ViZr/JJt6SBJQOXhCj7sQcQpur9FaGj/H1qGwclol6TsCw3KwQ8+8q5ThGi/AKmciYsX1AMi2EjaqkMXzuVxaCVmsO2V4qZUEauXIxvcXzRQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB12085.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(1580799018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aXJBRFVZcGxDUGlIK3p0VVgzMG5RZ2VkRWdNaXVOT2tPMWtLVzk5RS8xWWVF?=
 =?utf-8?B?M1A3Y3MyS3piWW5BZTEvNmpMQzZHUHM0RHQ3VlVIT051dkNsdlhMRHEzakNj?=
 =?utf-8?B?cXV0b2hmdjE3THhSeERjdGM4bG1DeFdTbU5vWHcyb2hYZ2RQK3FzNVNyZmVv?=
 =?utf-8?B?VTVSOW1Fdm1PL2VZTDNSMU4yMlZndHFuK0VqNkVmbi93MVpOTkorMHFPM1NT?=
 =?utf-8?B?US9tNitDcExzK3ZCcTRZa0JUNU1xMkxSQXU4aDZFVTVoZmFVUlYrZHpaTE80?=
 =?utf-8?B?L3dsYURFNmN3dGV4YmpNZlQyZ0hhV0hCbXlCV3VmU2h3NXMwWkc3dy9CUW8y?=
 =?utf-8?B?eW5GNGhBVDVsTlJtSnovVk9LQ0NvVFk4d01FM2VxbExTcGFDTXZ0VHVIdUNQ?=
 =?utf-8?B?TmtvWFdLcEFBNUJHU2xNaGlYcmhQRG14bTQwYnNFNWUwRWhKUVNQQk55NHdz?=
 =?utf-8?B?ZW5JaEhpTnh4bWF1YkMxTHBHVjF4Ulc2a3VkMWZyelpBcWI2aVBWbU5KbXQ3?=
 =?utf-8?B?amlUZDJiOEtpa0dENHc1L0U5MGZiTDlzR2N1YTZ6OFlZSFI2Zmx2S2w0bFRQ?=
 =?utf-8?B?enVlVWcxQjY5eVBpYjcrTWtDSjVrNDRWc3B4QjBOUGlCSVpQYnArWEhVYUMy?=
 =?utf-8?B?MjVqc20yTzdIMHFmdU5td3JlVDc2bXBCSEpzVmtwRnV4clR1VHZtRDIyYVho?=
 =?utf-8?B?WTBjU095M3RYbHNiUFBndlJSZDVkZjRQbFlZSE5UVS9vNXJnTnRJVFpaL3dV?=
 =?utf-8?B?WUw5RVZwREZ2MHFiTksyNnp3OG9wcXZPQWdKVG1XSDBaMzlNVytPZXg2c0xL?=
 =?utf-8?B?VHhBMHdlVU8xcjFqSUJDL083dktPZG1tc2s5dnZHYXJITzl3c3V5MHNISVQz?=
 =?utf-8?B?U3pEdWt2THNLVW4xV1Q2ZWc4YlpZcDBhRUVaSTBLNWlFYmJzTE1oK2FlMTFl?=
 =?utf-8?B?OTQwc2VaeFlYSDhQenkyWmFSOWp1bFlXRDVuUDJhOTIxZnZsUzN4Um5jeU5m?=
 =?utf-8?B?MXJBQ3h2eDJFWnpySlRtbGdjVGdWcjVGc1g1cklpK3lGd1FtM0pnODZJR09r?=
 =?utf-8?B?d0dxMVhCaHFaODlCbjNreXFTdDlaVmFoY2NSQ0o4ckZjV1JMcUpzazBreUxI?=
 =?utf-8?B?TUdZc0dEaXBmTjR1bDU5UERxSDZwc3VQQnRjdWhBenNGN2s1TW5DZUkveDRW?=
 =?utf-8?B?cW5SMlEzcXBTbUk1MzZvRjZ6by9oY052Q2pjMHpZdzVmNzQ2ZTVxRmM3ZHdF?=
 =?utf-8?B?b1lLc3VtSTJ4ZTBKMW8vMHdmYXFpcTI0OUFWZXQwa09WckhqenZOZS9WUDFM?=
 =?utf-8?B?bUZWTGt3TkJobHdOeGFRZzRxV1UyK3VxZTczYTU1bXFpODZnay9FYmgwb1cw?=
 =?utf-8?B?MFY4QU1DMk8veWtGLzBrYmZtRFZDN3llMU5naFNCaW1uaU9BdEwrZWxiSHh6?=
 =?utf-8?B?ZVRwZUJZOXU0RWtKNmpWNEszRlJNT1JJeWJJNTVsbVNEaE9BVmd2Vi8zd01i?=
 =?utf-8?B?eXVvVCtTWDU3ZjB6UnM1ZXpjM0wrTS94Um8yYmpuT3VHYmR5RmdMZzJxZ1Zl?=
 =?utf-8?B?TjI5Ti9uQ1RUSmtyV1NSc0hyN0I5bVRlU3l6b1NQWFE2QU9OTHR5QldaN050?=
 =?utf-8?B?RkxIb2hIblN2R2RHWStaNDE4ZVowOFNjT2RMV3l2ZlYzWk9YRnlFMnhQb2tU?=
 =?utf-8?B?dHhTd0JIME01blBobWFCQTRQTzRmSkNUUkFEUnVkb2g3VkNRMDJnVHhpMUVJ?=
 =?utf-8?B?cW9BSS9mQXU4Sy9lQlUvVjhwRTdhaGZJYWlEeTdlT3VuVXdoUUhZenR6bW5i?=
 =?utf-8?B?OXpCdTJnMytWdS9sSXQzN1o1WUE2SDFERUNQV1BOQnVmKysrM21CSlNUOWxy?=
 =?utf-8?B?QktCWjZnOWpkaUV2U2pZOW1vRDdIS2FrRGlCWlhvNCtjYTFyd3RqMCs4Qmc5?=
 =?utf-8?B?TStyT2p5WWlOdCtkaE9pQkhZVFFaL2YvQXdmc1h6a2pnZk5RSUxVdWJ3dDU0?=
 =?utf-8?B?eTd5aDE5RE1nNnFiZEhJWDdMcHl4WGFBVzFuWDlma1p5V1l4K1JCOFpJU29x?=
 =?utf-8?B?SkFNREJQcGpoME1VekZuSGtIeGZtSHVzUHUreXhHbTN2OFZYaFU3N1hSRjkr?=
 =?utf-8?Q?NzeHNt2ODSrDZk188EXoEiEXR?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	3Mz+aSnZfeD9/Mf9ASvMu5H2dLqgOIc40PYUNAPioaON9D/C9c7wnQDbD/nQB8eWn72djdTk9Bv/fX97CaP6o5UyaTYELKa404tZpAbPFr5DQksbCFA2a5D1lh9nypaRSajIr2wpJs5lf6FVFvG/5xB5lFa8Vc+TTjkZG120KzAP5JQaDAeBTXn8w14y1/UFOitMOTvZNlL2QltpW1REctC7wZLc4WUdvJDElZgMwF5MBYOY7BOuT8oWzUF1iNLeUZ1Jix77p7Lm1WyBMiEsfSDxP72R3gJ0LjG5XVQ9wjvl1j7oc/9keELFSOYflaLk0Hg4K3S/dxEyyvzAKeQ0AsXKeNl166dUqRxT60FokhogcXF5Fus5yo4+6trn/dyYRXTqtdWFANuXwkxbeXssAYugVqbVOKB0x3AoNE4EtLMR4qDuvMXU+yCZ3HE6Pc32AHPTE2QIHoe9iiDwQRLdsYzDphE/moXceIjBwGKxGJtsNogGV0anzxfdOaKjs50X6B6krxtiaYkNJkYTN5wnnMbgEJl9eFjEX1Eiesfd+3iYvSF97rYeitpFoS9Eh1/z0qu3gP6vG72ka9YQkfrWYdc+qMmVgYEMNxA4ZpZURhEzbO+CLvzlQXNT6bj4KOXz
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB12085.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87872602-b996-4ba0-4e8d-08dc538c14ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2024 03:13:49.0915
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qZhTw0a2zXewjCRmpxy9VwteBiYM+v+Xd5aNVjDw+ScXALdwSKzbQ+eldOYDuL9+DpZxKfW/fKrdUJZMqsBzQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB7750

DQoNCj4gLS0tLS3pgq7ku7bljp/ku7YtLS0tLQ0KPiDlj5Hku7bkuro6IFN0ZXZlIERpY2tzb24g
PHN0ZXZlZEByZWRoYXQuY29tPg0KPiDlj5HpgIHml7bpl7Q6IDIwMjTlubQ05pyIM+aXpSAwOjIx
DQo+IOaUtuS7tuS6ujogQ2hlbiwgSGFueGlhbyA8Y2hlbmh4LmZuc3RAZnVqaXRzdS5jb20+DQo+
IOaKhOmAgTogbGludXgtbmZzQHZnZXIua2VybmVsLm9yZw0KPiDkuLvpopg6IFJlOiBbbmZzLXV0
aWxzIFBBVENIXSBtb3VudDogcmVqZWN0ICJuYW1sZW49IiBvcHRpb24gZm9yIGEgTkZTdjQgbW91
bnQNCj4gDQo+IEhlbGxvLA0KPiANCj4gT24gMy8yMi8yNCA2OjM2IEFNLCBDaGVuIEhhbnhpYW8g
d3JvdGU6DQo+ID4gbmFtbGVuIGlzIG5vdCBhIHZhbGlkIG9wdGlvbiBmb3IgTkZTdjQNCj4gPiBD
dXJyZW50bHksIHdlIGNvdWxkIHBhc3MgYSBuYW1sZW49eHh4IGluIGEgTkZTdjQgbW91bnQsDQo+
ID4gdGhlIG1vdW50IGNvbW1hbmQgc3VjY2VlZCBhbmQgbmFtbGVuIGlzIGlnbm9yZWQgc2lsZW50
bHkNCj4gSSdtIG5vdCBzdXJlIGl0IG1ha2VzIHNlbnNlcyB0byBmYWlsIGEgbW91bnQgZm9yDQo+
IGEgcGFyYW1ldGVyICB0aGF0IGlzIGlnbm9yZWQuIE1heWJlIHRocm93IGEgd2FybmluZw0KPiB0
aGF0IHRoZSBwYXIgaXMgYmVpbmcgaWdub3JlZC4uLg0KPiANCj4gV2hhdCBwcm9ibGVtIGRpZCB0
aGlzIHBhdGNoIHNvbHZlIGZvciB5b3U/DQo+IA0KDQpXaGVuIEkgZG8gbW91bnQgdGVzdHMgd2l0
aCBuYW1lbGVuLCBJJ20gY29uZnVzZWQgYWJvdXQgdGhlIHJlc3VsdHMgdGhlIHRlc3Q6DQoJUGFy
YW1ldGVyIG5hbWxlbj0gd2FzIGlnbm9yZWQgc2lsZW50bHkgd2l0aG91dCBzbG9wcHkgb3B0aW9u
Lg0KDQpXaGVuIGRpZ2dpbmcgaW50byBrZXJuZWwgc291cmNlLCBJIGZvdW5kIHRoYXQgd2UgZG9u
J3QgbmVlZCBuYW1sZW4gZm9yIE5GU3Y0IGF0IGFsbC4NClNvLCBJIHRoaW5rIHdlJ2QgYmV0dGVy
IGdpdmUgdXNlciBzb21lIGZlZWQgYmFjay4NCg0KVGhyb3cgYSB3YXJuaW5nIGlzIG11Y2ggYmV0
dGVyIHRoYW4gZmFpbGluZyBhIG1vdW50Lg0KDQpUaGFua3MgZm9yIHlvdXIgYWR2aWNlLg0KDQpS
ZWdhcmRzLA0KLSBDaGVuDQo=

