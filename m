Return-Path: <linux-nfs+bounces-5524-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9330995A18A
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Aug 2024 17:38:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3781B284B11
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Aug 2024 15:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88C0813BAFA;
	Wed, 21 Aug 2024 15:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="FvSSvfFw"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2125.outbound.protection.outlook.com [40.107.212.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32A314F9CD;
	Wed, 21 Aug 2024 15:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724254664; cv=fail; b=t6zwK6s08j59qss+A3r8wu3A5M3Il+Rcsze8iGPG2w2R6Nfh5rh/Pnj7YTZX4XI8DylgllXLpPu/H1Gj8BlZWObRMM5WakLKlgKCQnEgeT86PZyYL5TngngEvKbrHVdHSU0tzfbMygdJXjaNW/FF6XnAoLM+OKAu1hyXceOunfI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724254664; c=relaxed/simple;
	bh=WXHRQUS/VeOOn4qmJiclm5DNsHq6UksIK/HaHeK8QPM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AEMPlMLi78HwBiSK6idlGpQc477i5YPZW+4z5CRejaeEl0K+y5V5+YndIgkGvFl7fRqpSPGvsjAXjyCd9gvLmz9MwBWSYRRH2VpSx9OzCCvtky0Qj6iOekTJGoh0olgfjERSJWTYusWjja7Q8won9YzYGs7Pb4OWZZNgSdjACmY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=FvSSvfFw; arc=fail smtp.client-ip=40.107.212.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a2L/dqzSq/YL7tT8a6pSHVSBAG5lZueiZLdmtFy9hIXDJwX7sXeHo2EHpGLrl6xw/CfYS4+QiwqM4a/IHQAAq7ycm19mSTsfdxM8eIuKa3AsE2iQZXH+aVDqrmSKlUYsobSR6sqvLRPs9OSrGXUhy++iDID9vaaeH7pL7HIC2lxspWxmJiYj3L4Fg3lNmQ1iDu62PrB8jN794qFjVcYCVopsPNlMPmsUC2nTatlgFPqvnOpemjG42MHmQrfDoSja5znqcczAO8NUVIxt+FxMw6PifkOSRjTn1dYtV7UNiuue2h4SVigxdwzLJ7zDkamkFqnN/0PddLm+84cKQgSi5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WXHRQUS/VeOOn4qmJiclm5DNsHq6UksIK/HaHeK8QPM=;
 b=Te460f67NcXB7oymhZb5dmSz6ok8HOE5dEcwUMqGvbwARCSEQ0lf1PL/T7+OB2JMSFo/kWeHCuVA3KBgX+M+xBenmC8IhmbZqP3pYj5gEeasaPZPOJ9QyQ7zo77D05PfP5yj4Pwsx7t44e2j/O8JOihSR/Ud5yo4w1+DPHyYbOR2eusAJ2aZoj8U8zDSrFOIuxD57Jbz0UEW5NzNw2vfqj/fq4T+0nD12nwxfafo0/3jdl+ZdlliC4ZItEKxfzCq7O85i3TMm6Bl/mNeubGmgzCJv14BqVrwa3/7Ty9uOoJZJjMGVLOfskRm2IrDN09wrQP1zISJDPnNBhYtlwYGNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WXHRQUS/VeOOn4qmJiclm5DNsHq6UksIK/HaHeK8QPM=;
 b=FvSSvfFwt6VPlHFi8Y0Hb/bynCFj3p6ED8lAAwfJWVvpkZdfbIyo5Fn5WRnH8qYwuzHf69uOXxdaAMevnI0ppdVTslPtjpA0NF0YbThjwybwcZks9LQAXPxYJV6rRSYd1cq+AV6eLFBP99oWYdz99AjGefMOysrjux3+fQQgT34=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by MW4PR13MB5410.namprd13.prod.outlook.com (2603:10b6:303:180::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.18; Wed, 21 Aug
 2024 15:37:39 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb%4]) with mapi id 15.20.7875.019; Wed, 21 Aug 2024
 15:37:39 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "anna@kernel.org" <anna@kernel.org>, Lance Shelton
	<Lance.Shelton@hammerspace.com>, "jlayton@kernel.org" <jlayton@kernel.org>
CC: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nfs: fix bitmap decoder to handle a 3rd word
Thread-Topic: [PATCH] nfs: fix bitmap decoder to handle a 3rd word
Thread-Index: AQHa88P+hf0nGPltEEmWAsZYKG8Xi7IxzaoAgAAA4YCAAAoHAA==
Date: Wed, 21 Aug 2024 15:37:39 +0000
Message-ID: <0935dab532078c17847f7d6e26ec76074a39a2ca.camel@hammerspace.com>
References: <20240821-nfs-6-11-v1-1-ce61f5fc7587@kernel.org>
	 <963d3249b9c9bdc842a835e5c38d00638a6037eb.camel@hammerspace.com>
	 <c1d69b024d2a60d2a10e4211c2cbe565ca0e23fb.camel@kernel.org>
In-Reply-To: <c1d69b024d2a60d2a10e4211c2cbe565ca0e23fb.camel@kernel.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|MW4PR13MB5410:EE_
x-ms-office365-filtering-correlation-id: e767cddb-2f2e-4988-279e-08dcc1f7304d
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?d1FQZjRqNGEweUxJZjRGQTlXMjRPTGZGdmJpOHNZWFdGeURnZDJhb09Sb1Jp?=
 =?utf-8?B?Yll5SnRTRG0wRC9DM1g0S0RseEt1TUtIcDVlb052eVZYNkdvQ2N3cGdjWmVx?=
 =?utf-8?B?ejJ1M2xYVzFINldnZkkvNHI5RXIxc3V6cUJVTy8zY0R0Y2FqVnpHZVpGTkEr?=
 =?utf-8?B?aW9QL29QSDNQUzRtekMvd2F1dFdnWDlJbEpyZXAxMFJRaHZWZWhCY2M0UTAx?=
 =?utf-8?B?b0JDQS8vRVVWZXp2UHdXV3ZLSTk4RXV2RW9Hcys4QXNhYmU4d3NyV0JCcHgx?=
 =?utf-8?B?VTQ2dCsxb2JFUWwzOWdRbnZ3MSt4Q3F0Y21GUjFDQkRHWE1nczZCM2RKTklo?=
 =?utf-8?B?bFplREhieFB6dDREeW1qNFh4NTNsbnl4ck9SSFRlYmdHUFpBbDkxMDZkVWUz?=
 =?utf-8?B?WHg2RlNZbWl4aWxzYmJ3NVJPMUNTNlBlRnozaktQV3Zidjh0cDdqY0hnaTZh?=
 =?utf-8?B?SXVKUUI1Z0ZIRHJMUTg1SXJuZkhlcFFxV1dncVczdzlVVUpWeDUxaTdxQm9R?=
 =?utf-8?B?VlJGQXBoQVJkWUFRd2pHck1SOVBLWDYxS3VxMWNlMUQydi9hN0EraENXSHVh?=
 =?utf-8?B?NnNlSEFvL2FGL2s2Mm1RVkZlTXBMREYxajcvT1ZnN1JmbWNpRk5rd3BqT1dv?=
 =?utf-8?B?TDlsTlBhRk5yUm5FcGZ2VnpVNmV2aEkxQWlkYWd2NThTZ0pYTlpQSFE5ejFY?=
 =?utf-8?B?WmtuODNkOFZVSU9XWlgrblFpdllYNFEwMlo0bVlZTGR4SUNITDhZa0poK0hv?=
 =?utf-8?B?RjBEaGFVU3FmbzVGRGJvSjFZbDNqTTBJa25rNUNLVGlHWDVWSjlINHgwbkJT?=
 =?utf-8?B?VFM2TnAxbVZSSU9RR2k0MWRMNm8vUXpPYVlYZGtZdmdzeHd4c0NoMDBadXBk?=
 =?utf-8?B?WTErREJodnhDWldndFQ0dHVVTXdNYkFyVndmdnlZQmttcWFvZmhJdHpPanRq?=
 =?utf-8?B?UmZkSDl4MnBiUDk4NHJSUERHYXptdi9XTFJZajVtaHYxWXB0Q24vNVowQlVo?=
 =?utf-8?B?cmQzZjBDa2xHelJYTzFyNXpCOXZnWmNTa1RmeURMRnJCTHZYaWxkRGhOeDc0?=
 =?utf-8?B?WmJxbUJMQnY2ZmJhK2JQQzRqVkpHbkc4UVErbHFjMi9UY2lmLzNUa3FJT21Y?=
 =?utf-8?B?dXlaMGVRRFpIRXBWazJMN2JJOERBa09Jd1RxUWNVWGJHQllTZ1VzV2NOUGFw?=
 =?utf-8?B?L1dHS2hoQXB6RnZiUWlnbHJndGtTdHpQV2tjZVovQUpRYjZVc1NkdXRpMng1?=
 =?utf-8?B?Z3I1V2RmUzhraWZEWEV0cU90RTM0YVFGWHRxQ2lkblVUSlhrWWlvblAxZ1VT?=
 =?utf-8?B?Z0NobU1QMWI4cll2ZFFGT1ZnVXFFS0RNUlVRSU9kMmxieXpiOWZzRVI0UWRw?=
 =?utf-8?B?SmhET3RCZUNYbXRiajJEZm5lUkZ4VHpGTllBeHZQUHpiVHNpZUZkbWhjMjJZ?=
 =?utf-8?B?QjZiM003SElYVGQyNHRvemFrVEtVQXlldVV1U0FFMEtYOCtmUlZ0aG1tT1I3?=
 =?utf-8?B?b0NkK0RiY0l2WkZuOGdkZ0llNmRIeTJWSlBOb245Ni9aWUMwMjRyM0hySDZN?=
 =?utf-8?B?WHBybU85QUJyVlFMNFJPZ0g0UWlRMVhxODF1NGFxa2pOMjBaTzA2ck9wdEhM?=
 =?utf-8?B?Y3BraGNkQmpVbm5Qa1RPQjZhRFlnRFJwSFIvTHIwbTZOaVhZSjB2N25RQytT?=
 =?utf-8?B?d1MrcXZrSXV3WmExOTN0eDdibWQwQ3BmdWJNNVBVT3A1cmNFbmNUMVpqUEgy?=
 =?utf-8?B?dlNBNEdTUGJjNm55eE1kSUNMaUNpSnhQaGlYMzNDL3g4N2U1UGZNSHA4K1V1?=
 =?utf-8?B?M21BOWpyYkVORmhqMnhTaEZyRXozeTVoVThOdmgyZmVxVWhtdzNSTkZWYjgw?=
 =?utf-8?B?RnU1NE5BZ3JGZUJUc1ZaSzJySjRCRDFVanNvVmowUHo1RXc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MlNncXJ6WlRCNjBLMDBzOXVyM0Q5a3g5WkVQMGpwdzUvOWFMREUxaXBRNUxq?=
 =?utf-8?B?OHZlUlV3Z1JQcVBYVVFIdFVaSlVpR0VPek8wMkx6YXhPRmdLVS9uOEhneFVJ?=
 =?utf-8?B?dzNXdGhBNWYvKzV0dHpwT0F1SzRPUnhWMGU1dnNSSE93Tk5hZnJCZXdndndF?=
 =?utf-8?B?akJ3Y0pIY1IreGRWK29CcDFEdndwMkVOMHZPcEdKbmR0b24xNVZ3RmIrdEJn?=
 =?utf-8?B?YXIrZkdmMGduUUs5dTVYQi9aaFBNK21QTEwzWFBtK0hrdmRBZU1ObXBOcnVh?=
 =?utf-8?B?RVozODByYm5XOVBmZk9Ta2VMUDRvK3NwdWR5ZWo1T2JyTHVQc0ZSem9PM1B0?=
 =?utf-8?B?bEhJaUtlQ1FxWHZTVCtjU1ZyWFhxVHdoOXdMUUo5NWZ0c29rM3ZBRkJzWDZq?=
 =?utf-8?B?aUNheFNYZ1lUelpCQk9jdzBVV3hYSWNRZE1oZ3Bwc3pnVGNDZmQxMjZ5QXhr?=
 =?utf-8?B?UTVnQjZDTEZGa2tqUW03V1JwL2JaSmZHcHBJN2t5Tk9ZZVIvaFA1V3djV2I0?=
 =?utf-8?B?SDByNWJ4eTZCdVlrbnZVU2VYUzh6bVppcU5mQzBtVFZhMDkrM1lpZUV4WGRK?=
 =?utf-8?B?ZTFsY3c4NmlnY2EyMXplckprdWdraHlFM0hUcmg0TWhXMUErc1V4bmIxendS?=
 =?utf-8?B?SEgrU3c0aTdEOXZHeGVQeTdwUmhZQWs4QzhLV0FLN09XU1RnUGhuaDR6NXJp?=
 =?utf-8?B?UXJzTVRRUDhDcjdQV0lyRWplZDBTK0tBRnlsUml6dTNzc0h4Z2haSEwwTHdZ?=
 =?utf-8?B?U3BMQ0U4YVRLbFA3V3dNeGVKNHpQbjE5eGJwWmRlTy9yWEVqR3Y0MG9TN3FY?=
 =?utf-8?B?MStoTEpiaTgvVmhGU0pGWTc5L01BKy9yWDNhd1RVaTFvUEVYRVVlWnlaU2tt?=
 =?utf-8?B?U3YvOUFBanNmamI4OEp0elQ1aUlWQ0ZtVHNndU0xeTZQbUYvSlNTeGJaUjVj?=
 =?utf-8?B?WklWTGxXTVpRcms5dml4d2MvVWpwQXY5Qldlenp1N2g4dG5JeFFVeGxSbEdi?=
 =?utf-8?B?bC9nUTJLRFFVdWY1eWpwVnhRTC9Rai9odXlqSW9QZXdSQldSRk42QmZvUzNZ?=
 =?utf-8?B?V0VaZ3Q2SjZLSVltMWw3OWx5WEtjTGVTZXN0WHd5b1UvTjVhOWZNdWc5TExJ?=
 =?utf-8?B?QTcxN2liWVluTlE4WmJ1SHlyZ3oxbkk3WHpsbGk3dU9neTVJRTREVGt6TFAw?=
 =?utf-8?B?S0ZwYXYxZC9LY01IMWxPWE1va0UwQ2hSVzNUci9zNmNCN01aeUdmZ3NmSnlm?=
 =?utf-8?B?QS9pT3BzWkc2MGNIcm50eTZOWkZ6emVGbWptTFlpQlpDMXVrRHRlbFhrdW5V?=
 =?utf-8?B?NjNZT21OaW5LaVBTd0l3ektIQzZiL3NnaUV4ZS9Ra3ZWd0J4MTU3WmdkMzlF?=
 =?utf-8?B?OVoxc1l3WlRhYmQ0dnlKMEZqTW80anlMeE0wQUlCQURwTU9DcTM2NkMwNm5l?=
 =?utf-8?B?c3RSNUc4TDFCeTJhUVY3UjlzaXI4VmExWGdnWkNZTGJveTFGUkhud0RlR0xk?=
 =?utf-8?B?ZWVjbGFSa01seUxrc2MvMVJPL1ZTVWs5Mlg0VzBBQ0xpak01UnA0ckNNb2Nm?=
 =?utf-8?B?OVJRbG1BUU5KYmdWeGNEZHY4M0x3bU5rc3pOQ3lEYWxFTDkvUkNBa2kvcjVB?=
 =?utf-8?B?ZGZzYU9Hd3lzQXpialI2Zjg5azg0c1hiUG01OGdFMkVlNnNuMWgxQldqTjd2?=
 =?utf-8?B?blpRTGM4S3ZCQmk5a0FyWWlmdzZsdVI2bXRBb0lnVHhhVXN1R001aVpQM3dw?=
 =?utf-8?B?a2NkM2Zyb1ZxZEZ4OVI0VmdXMk1hQlNSd1Fzem5RSnY1YlFONGZlK1ovVUtV?=
 =?utf-8?B?Y2I4cTFZS0NrU1VDTHhWR0pPY2d3NWkyc2FGR0RrZ2d3Y1RyNTdBS0x5QmMv?=
 =?utf-8?B?Q2xtVzZVUElrY2ZuTkREL0N1UThVekZOUXR4cEFmN29Fb1JSS2ZpSnNubmJ0?=
 =?utf-8?B?dDJBRTJZRHFXaDVraHJiWjVlbE5Wd1hWSERwNFoxaC9vNFk0RkMxSmZHQ2pW?=
 =?utf-8?B?U3BRNXBtcDlPKzhkTmNhR0VkMUZEdWFzd0lNUmRDM1NkUVRIMnMxU3FGZXdL?=
 =?utf-8?B?cDUrakozdExTL3hGN200TFc2Z3Jwalg3S21YeUdWcUovZURKU0dLbnowVW5K?=
 =?utf-8?B?cU52S0JZeEEzaGFtL0NQWlprTGVvYmJuMGwrcm9XRE9lMlRRd3g4dEdpcWxw?=
 =?utf-8?B?eXVCVHZHUE9iQzlvNHlFaS9YMWdGSnZFNDFDSWNkUU9tUzdQaDB5OHpDNjRr?=
 =?utf-8?B?Q0RXa2t4OUJFMm9uUThrN3c4LzNnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CFDA6FD4277348478E72E2B43F55957E@namprd13.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e767cddb-2f2e-4988-279e-08dcc1f7304d
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2024 15:37:39.1038
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SOrJaBHkJS+eYXF6xJoABnccqRk3GhxHx+Gb+dVBmmOE0ei143nqbVVk5Q3QA8iNnX+Ol430cFWgsH/ObnQI+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR13MB5410

T24gV2VkLCAyMDI0LTA4LTIxIGF0IDExOjAxIC0wNDAwLCBKZWZmIExheXRvbiB3cm90ZToNCj4g
T24gV2VkLCAyMDI0LTA4LTIxIGF0IDE0OjU4ICswMDAwLCBUcm9uZCBNeWtsZWJ1c3Qgd3JvdGU6
DQo+ID4gT24gV2VkLCAyMDI0LTA4LTIxIGF0IDA4OjE2IC0wNDAwLCBKZWZmIExheXRvbiB3cm90
ZToNCj4gPiA+IEl0IG9ubHkgZGVjb2RlcyB0aGUgZmlyc3QgdHdvIHdvcmRzIGF0IHRoaXMgcG9p
bnQuIEhhdmUgaXQgZGVjb2RlDQo+ID4gPiB0aGUNCj4gPiA+IHRoaXJkIHdvcmQgYXMgd2VsbC4g
V2l0aG91dCB0aGlzLCB0aGUgY2xpZW50IGRvZXNuJ3Qgc2VuZA0KPiA+ID4gZGVsZWdhdGVkDQo+
ID4gPiB0aW1lc3RhbXBzIGluIHRoZSBDQl9HRVRBVFRSIHJlc3BvbnNlLg0KPiA+ID4gDQo+ID4g
PiBGaXhlczogNDNkZjcxMTBmNGE5ICgiTkZTdjQ6IEFkZCBDQl9HRVRBVFRSIHN1cHBvcnQgZm9y
IGRlbGVnYXRlZA0KPiA+ID4gYXR0cmlidXRlcyIpDQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBKZWZm
IExheXRvbiA8amxheXRvbkBrZXJuZWwub3JnPg0KPiA+ID4gLS0tDQo+ID4gPiBGb3VuZCB0aGlz
IHdoaWxlIHdvcmtpbmcgb24gdGhlIGRlbHN0aWQgcGF0Y2hlcyBmb3IgbmZzZC4NCj4gPiA+IC0t
LQ0KPiA+ID4gwqBmcy9uZnMvY2FsbGJhY2tfeGRyLmMgfCA0ICsrKy0NCj4gPiA+IMKgMSBmaWxl
IGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+ID4gDQo+ID4gPiBk
aWZmIC0tZ2l0IGEvZnMvbmZzL2NhbGxiYWNrX3hkci5jIGIvZnMvbmZzL2NhbGxiYWNrX3hkci5j
DQo+ID4gPiBpbmRleCAyOWM0OWE3ZTVmZTEuLjI0NjQ3MDMwNjE3MiAxMDA2NDQNCj4gPiA+IC0t
LSBhL2ZzL25mcy9jYWxsYmFja194ZHIuYw0KPiA+ID4gKysrIGIvZnMvbmZzL2NhbGxiYWNrX3hk
ci5jDQo+ID4gPiBAQCAtMTE4LDcgKzExOCw5IEBAIHN0YXRpYyBfX2JlMzIgZGVjb2RlX2JpdG1h
cChzdHJ1Y3QgeGRyX3N0cmVhbQ0KPiA+ID4gKnhkciwgdWludDMyX3QgKmJpdG1hcCkNCj4gPiA+
IMKgCWlmIChsaWtlbHkoYXR0cmxlbiA+IDApKQ0KPiA+ID4gwqAJCWJpdG1hcFswXSA9IG50b2hs
KCpwKyspOw0KPiA+ID4gwqAJaWYgKGF0dHJsZW4gPiAxKQ0KPiA+ID4gLQkJYml0bWFwWzFdID0g
bnRvaGwoKnApOw0KPiA+ID4gKwkJYml0bWFwWzFdID0gbnRvaGwoKnArKyk7DQo+ID4gPiArCWlm
IChhdHRybGVuID4gMikNCj4gPiA+ICsJCWJpdG1hcFsyXSA9IG50b2hsKCpwKTsNCj4gPiA+IMKg
CXJldHVybiAwOw0KPiA+ID4gwqB9DQo+ID4gPiDCoA0KPiA+ID4gDQo+ID4gPiAtLS0NCj4gPiA+
IGJhc2UtY29tbWl0OiBiMzExYzFiNDk3ZTUxYTYyOGFhODllN2NiOTU0NDgxZTVmOWRjZWQyDQo+
ID4gPiBjaGFuZ2UtaWQ6IDIwMjQwODIxLW5mcy02LTExLTE4OGJiNGUxZjFkZA0KPiA+ID4gDQo+
ID4gPiBCZXN0IHJlZ2FyZHMsDQo+ID4gDQo+ID4gV2h5IGRvIHdlIG5lZWQgdGhpcz8gSSdtIG5v
dCByZWFsbHkgdW5kZXJzdGFuZGluZyB3aGljaCBjYWxsYmFjaw0KPiA+IGF0dHJpYnV0ZXMgd2Un
ZCB3YW50IHRvIHJldHVybiBpbiB0aGF0IHJhbmdlLg0KPiA+IA0KPiANCj4gKG5vdGUgdGhhdCB0
aGVyZSBpcyBhIHYyIHRoYXQgZml4ZXMgYSBwb3RlbnRpYWwgYnVmZmVyIG92ZXJydW4gd2l0aA0K
PiB0aGlzIGNoYW5nZS4gV2UnbGwgd2FudCB0aGF0IG9uZSkNCj4gDQo+IEZBVFRSNF9XT1JEMl9U
SU1FX0RFTEVHX0FDQ0VTUyBhbmQgRkFUVFI0X1dPUkQyX1RJTUVfREVMRUdfTU9ESUZZLsKgDQo+
IDQzZGY3MTEwZjRhOTAgYWRkZWQgc3VwcG9ydCBmb3IgdGhvc2UsIGJ1dCB0aGUgY2xpZW50IGRv
ZXNuJ3Qgc2VlIHRoZQ0KPiBzZXJ2ZXIncyByZXF1ZXN0IGZvciB0aGVtIHdpdGhvdXQgdGhpcyBj
aGFuZ2UuDQo+IA0KDQpEJ29oISBBY2tlZC4uLg0KDQotLSANClRyb25kIE15a2xlYnVzdA0KTGlu
dXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhh
bW1lcnNwYWNlLmNvbQ0KDQoNCg==

