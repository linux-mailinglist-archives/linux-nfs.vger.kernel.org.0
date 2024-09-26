Return-Path: <linux-nfs+bounces-6667-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E31EF9879F2
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Sep 2024 22:02:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9660F285566
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Sep 2024 20:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12F7615CD6E;
	Thu, 26 Sep 2024 20:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="HGYwMGn1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2119.outbound.protection.outlook.com [40.107.223.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA12156F20;
	Thu, 26 Sep 2024 20:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727380931; cv=fail; b=WM7dCnwm+7u/zmYVAzLfklhWd2aKWH4uPYePZg5i+x1M8wEVPbBxE+XLtGvWF8gHtakg5spxn+vlVejmhEPN3K1OSpqwsdhEAuXkL3GoSRx2VD0lYwMrBBE0LBNKdagkiPHOyw2sKQDITBR6KH8vd8wZxNV6eFkdYVPxK3SgfCM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727380931; c=relaxed/simple;
	bh=IYozdBPMeSzDK8FKeWxHgk2BwAitneaHfP36T9y0PcU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HyjbBmZpB9BwTzhltGmQF4Xm9w6xQhzJQ2Y/W/QtgLtpfkQKY3Kc7TKoM9MDLspOIFyQgJom3jqJ67vI1EHkon+0Xqu9RLgqeHNBBBFLxay6hMrmafoHtvvx78nvf7GBf3phy5C5zpOAWRTzu3TQmiuSoA1mAW+LuMfH6ZJdlVY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=HGYwMGn1; arc=fail smtp.client-ip=40.107.223.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kwiuObAQRI4Lfl9APSspSAYR7Qi2QgD/PYmM3RVLi4fb3QtZR0+q4TBbIxnkOCDfY3aWHLeFuEW5c7YH8p9af8lvGQPwlYQOLa7XVEcHnp2EfuP+MPzGm+uX4alw+1ObdGoMnfLMUyRW53ecGT+THaPZezvdem87qBHE61DkGdw5C0BzwaPmYtHoCNM1mJB/4R1Nb9p4by1XK4L337lV44kEbIDUKL9f65J3Z2UU/yoLGiZ0kTEy8aPxqobtF1e3I4mF/HkI+FWut6PbiZ/JMJQUaEgkfVu7ysTNEoDNFGd/z/iiTafbUu77IJppiUbdSiQ6Z+zjcCOJFG8oZ78YGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IYozdBPMeSzDK8FKeWxHgk2BwAitneaHfP36T9y0PcU=;
 b=T1v9JsJCFAKoxftuPZ0n4nDxBZplZGqEMzgeGrajE5mI+sIq4w8ALQJ52gdlLN8ihx4N5mK/WAuRg7KwRcCsbvOZKgDrds3Fh9TH7OanMCbyomoaMO7yPd1NDkNmU2p+xWGAM1zyyvvgfbhU9gx9hQd7syUgJR0BJ1elspTibEVQGggoFt+gEC1b2EV5bXt5zkCiqUfBd3qoJZ6ZDATHyUdx3HRgzJ7kvORL/gwLUzY70AL3x9QjZlW+8dfwqAnG2XnuM3dwGrEIsu3Rlts11PiZJ0BTBkPaJ4TtRt/D/MMI/5Fws6wMoVOSSQgnKqBiuoVp8ulKw8rs8i57KxSXIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IYozdBPMeSzDK8FKeWxHgk2BwAitneaHfP36T9y0PcU=;
 b=HGYwMGn1amm0B3i+05TXunYx2/tT8HxS+gu1jSFm+ppquyMuf7L19QhL/jn9OY8SYxjjW1igNLCJhpqEKnVJNzKzXJBmdiVQn6K2w3EoFhbkFj1sphsX6mkqcXag+V2CiOFvKYOpv70fmwCWOF6IntJRN99ksHVH3SCD94oY02k=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by BL3PR13MB5178.namprd13.prod.outlook.com (2603:10b6:208:341::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.22; Thu, 26 Sep
 2024 20:02:05 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb%4]) with mapi id 15.20.7982.022; Thu, 26 Sep 2024
 20:02:04 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "ovt@google.com" <ovt@google.com>
CC: "anna@kernel.org" <anna@kernel.org>, "jbongio@google.com"
	<jbongio@google.com>, "linux-nfs@vger.kernel.org"
	<linux-nfs@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: Re: [PATCH] NFSv4: fix a mount deadlock in NFS v4.1 client
Thread-Topic: [PATCH] NFSv4: fix a mount deadlock in NFS v4.1 client
Thread-Index: AQHbAwztQJsv5RBnrky+aAqWUODlvbJQKQsAgAFcAYCAFF92gIAEs0IA
Date: Thu, 26 Sep 2024 20:02:04 +0000
Message-ID: <b34ad21a057198601a82edd0b7f24baf2700a1d7.camel@hammerspace.com>
References: <8f2e20f2fc894398da371517c6c8111aba072fb1.camel@kernel.org>
	 <20240909163610.2148932-1-ovt@google.com>
	 <84f2415b4d5bb42dc7e26518983f53a997647130.camel@hammerspace.com>
	 <CACGj0ChtssX4hCCEnD9hah+-ioxmAB8SzFjJR3Uk1FEWMizv-A@mail.gmail.com>
	 <8d95e5334c664d10a751e5791c8291959217524e.camel@hammerspace.com>
	 <CACGj0CgobBUv9CgpAhw+XWFwJY7+A0MryOTyukXz8Jsoc9hdQw@mail.gmail.com>
	 <CACGj0ChbuJ=p6WT62rYWarB=E6Uf3Cs_rz7icDPo5uH3GgVpmQ@mail.gmail.com>
In-Reply-To:
 <CACGj0ChbuJ=p6WT62rYWarB=E6Uf3Cs_rz7icDPo5uH3GgVpmQ@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|BL3PR13MB5178:EE_
x-ms-office365-filtering-correlation-id: 9de3a4ed-8bd4-42f9-a45c-08dcde6617c2
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|10070799003|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?b0QvUCtMY0JZQ1pMcFQwMXFhUGhTR3RzdTdzbzhncFFodW5qc0V2VTk1VS92?=
 =?utf-8?B?bFZKRU5weDhpMjMxem5pL0sxaEQ1OUZrc2NZR1g3aGhndUl2RWtpN2ZYdUNr?=
 =?utf-8?B?cW1PMjh2NGlZcjdSbVVsL0lrTjhlRXNoU0JIS0RDb0tCSEtLRlNMc1k1TGNq?=
 =?utf-8?B?ZG92YmNVcFFmdW14NXFoV1VlTENka0h3ZGgveXZtS05NOGlUMXkvQlhZTEdB?=
 =?utf-8?B?bHBVYUw0RmFYWjl4NEh4NDRjblh2Q0VxWGtuRUE3RDZvMWp1NHJNSHpFbFdv?=
 =?utf-8?B?WmFLclBOUUpwWkRqNncvOUFTdkpORXF0aWZUS0NWWUtqaXlkc2FyUFpMdEtL?=
 =?utf-8?B?cHVnckJsZ0lhS3VRbXBSeGd1VWlEcWtGRituSldERSswejEvM0pWU01jM1N1?=
 =?utf-8?B?ZUl3cFBxWGhwMlh6Vll3R3JaMUM5MnNMMGk2Tmt4WmpYdXkrNEkzR2NFZHdM?=
 =?utf-8?B?MndpNVoyLzY2bExRSUt1NGlkN21Ub2lwSGtmSmh4QWFEelJHT3hPOFlvcXps?=
 =?utf-8?B?OFJqWDlsSWNBZ3VYdjh3aC9tR2hwLzZkalMreWJJZFhDN3FabHpQZDNBQnRz?=
 =?utf-8?B?SUVpSDd0SjRLNzVrWURCWmczTThNOGJhZDhOalRUQ1FIeC9ocHBtTHNucVh4?=
 =?utf-8?B?bHcrUG1maHFoSFFoc2dxZ01sbU1vaXNRT09KZ21oZ200c0VLUjVLOG8vMDVm?=
 =?utf-8?B?NUMxUVZINS9ReHROU014Vlh0YWYzZVBaN0RpLzAyTzNobGQrYVVYQkxMQlpp?=
 =?utf-8?B?MEpDYVpLTTlLSjM1eHdyaFhOMExwWXI5UGFzR0htdEVKd1Vkd3U1WFVHS29E?=
 =?utf-8?B?Y1daU0VVQlZDRW5YNDhXRzZsSVhaM2RhS01iQmk4ZUJQVE5xSHpESDFEY00r?=
 =?utf-8?B?djJURTRXZk90a0ZUQ3R2M2JtZjVGL1BKeXRlUkJYRzVldzgzRGV1RDBFdVYr?=
 =?utf-8?B?WFEzTWNaR1VYRlJ1THExd2tXZWZ1UGVXZU9iaHlpKyt6OFdsR0VkYzRIczRS?=
 =?utf-8?B?elhBdlFvV1JrYUVqeitWRzYyTFJXbEVGR3IzbFMrUTd3TVVYMUxHTThqUG9z?=
 =?utf-8?B?WndWeU5pa29YUDI2bHlsUkVwK3N5OFZKU0lJclBCam4ySGc4aVIyTStuaU5w?=
 =?utf-8?B?b093YjgrRXZuYm5jcklzYjFiQmFrN3ZYNkdZa2hlVGMrWm5aNURxWmJ0L2Zl?=
 =?utf-8?B?cTBPTVVBR1pnSTZNc05jV1dOTW5WVEdWaEx6ZWx3Vm9TaWZ6dTB6OHlub0dS?=
 =?utf-8?B?ak5DQlJWSWd0TEs4bS9jRE1OZGhNN0VnQTkvU0FZVkdQOHJaM09wdDByNDRo?=
 =?utf-8?B?VWZ4UHRlZ040RDRqSDZta053eitpVk5LK3NFM1VmNVh5K0xzT20yZ2I3cCt2?=
 =?utf-8?B?OEhDbjQ1anlwMVhMdUpNd1RDT1E5ODF0UWtneHlqQmoyV2ZjMW1PblRRa2FR?=
 =?utf-8?B?N3o0WGNNMjAvaGNSUFNvMjVIV0xqWWxhWUNyVzZqS3RBUUVqUkxkVlhOTlNI?=
 =?utf-8?B?RUV6OTFvV281NDRUOGQvK3BZMEQ1UjhiNjhrODZMYUJJSEw1dDYzY3Y1VVVB?=
 =?utf-8?B?YlhwV2JmUnBrMURNM2JuWkUvQWtqTmZYWjJwYXowUTVSdjlxMzR3SVQ2dTc4?=
 =?utf-8?B?T0JQQzA3RmlJOEloTEpPbjJXbFdBQWEycGFUZXRTNXBVaFJGVDY5WHFNMEQ0?=
 =?utf-8?B?dWpGdFBmdFp6YjBtTHVlb2x2dGxjTS8rQW8yRnVJb3hRRkNTSk9NRXRLVGFk?=
 =?utf-8?B?ZkRIOFRSbnFNWWYrczJnWnl4cm5uRGZtQkJYSkREM1JWd0hOdVROQmpNejg1?=
 =?utf-8?B?Z01CMFRaNUJSaDNVYVRBUT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SzNJWDN1QmVnTy9sd3AvZ2hHUHJHUmZMb2pNejdyRmw2bk5PQTF3ZU5JQ1B1?=
 =?utf-8?B?YmVVTnRackZzZ0pUamgrUzR2cE1NbEVBS1dYUzVSTjBLMDI4K0ZEMjhWOWpp?=
 =?utf-8?B?U2gvWmRoK01yRjQrUVAvLzc5akJqN253a3c2NHJqR2FxWk1VNnhEWnMvOFU3?=
 =?utf-8?B?Z3dMbHpuWldyY0M1MjBRTW9KOUR4MkRLOGdIZXZacXNZaFF2YXQ0ZTJ4Sk1U?=
 =?utf-8?B?Y1JpdWtpTkt5bWp5Z25FK1NZQ2Y4Q1hVQ0hFN01WeENhQUJyamNicHNVUElw?=
 =?utf-8?B?am5jV1duN0J0cEk4MUlDZDVHZXRySnpZdmJISVA0TkFCQm9HN3FCaStSVlNJ?=
 =?utf-8?B?cmhrY3RTTlkzeEtPMXA0b1BIVHZpNU0zSXpUcXJUMElIcStEMlI4QzQxcHFE?=
 =?utf-8?B?QnQyWnNHOSswNmpSL2dNNmRLNkNYa3orbDg0N1o5cnRObTdjQzZCY3NBVU91?=
 =?utf-8?B?UnBWVm8rNVdBVERYR0FXSWdTVTlQN083NFNaQVBUbjdoZDhYTXBhQ3VDM2Rt?=
 =?utf-8?B?N1RVZGRrM0E2bHBXUURnQ1IvekgxSkxlRGFXSTBJZHErM1d2aXQ2VU5Ic0Qy?=
 =?utf-8?B?RzUrbkFPMDgvSGtnaWpkTTFGcnRCbTJMU3pUelArb1EybGN6ZnJNRUdOK2FK?=
 =?utf-8?B?OEp2a3JRV3dadTk3UDBUVHdJekdmNUtQdUNtUnVLY0k3dllGODZhMnJQVHg4?=
 =?utf-8?B?OGRNMmdHQnJCNFRZdHhYUVdBaVY3Ylc3ZCtJS2xPVUw1SjZld2xkWjlseHVX?=
 =?utf-8?B?THZxeGE3MGZwdVROMnZUWEh3YlpkVXhnZUhVVlcxVDRFT01peGI3YmJETWY5?=
 =?utf-8?B?LzBqSGJWdFY1MmRoYUh2OXJ6TEl0b0Q0RUtzZ2V3bFg0SGFsMEpOQU56cVl5?=
 =?utf-8?B?S2U4WWxYdHU5UE5aRXpvM2dTQTR5TjExbWZoSEVuaVYxazg0d01iWXI4ZXpp?=
 =?utf-8?B?bEJOc3VLUlNucktIY3UxUEdCTmFuVW8zb0FIUXozME9WTVlaWmI0M3JPeFpG?=
 =?utf-8?B?NDA4VThjR2p2TGZCL3BkVjFrNHlFc2ZnWGtjd0NzT014Y2U5Z29TU2JTbjZF?=
 =?utf-8?B?T1ZxWGN0VjUzdGpJbTZyeEt0NTZSbU9BdUplZGxDakgxWis3VTNsY2VVM040?=
 =?utf-8?B?b0x0czZaSDRnVnQ5L2lBcUxtOGdaUGZrZFBDR1NWOEsvalpwOW42dWRPZnpz?=
 =?utf-8?B?TXNERXdFdkdMdkUzeHo3dWIzMUZzM0JjSlpNN2VPQkJmUWh4TldqUEdqYnRT?=
 =?utf-8?B?dnpkL2hSbU5MSU1FSUx4ck9GT1c5MTJiSVV4VnZYT3FrM0VEWkZoL0VxSmF3?=
 =?utf-8?B?bFJIOFpTUVBqWmFDci93S2dVdHZZMDZLNnhTMkppMVRFZ2RtZUZVVWtmSHAx?=
 =?utf-8?B?NmpaQ0Y5aWlKYU1EcFEyT2EzMWNlUmRYVVU1Y0xybk9abzBhNmFZTXlaV09i?=
 =?utf-8?B?cjNBdnI4UzllbWY3K2RCN3JJbmhQWHY2b1REbnYybEpkc0RTdEZYZUF4VVdF?=
 =?utf-8?B?VHlzK3czc29YRnFyWVFwOXlMclJ1ZEtBbHhqQjJLR3VFOFYrUldYODJTVE5I?=
 =?utf-8?B?Y0R1VU9MN1dmVEtTSzdQdlA2bXdWMzhQOGZpWXZyUENOWFkvMmQzU0tvb1Q5?=
 =?utf-8?B?d2VZY0RYelo4NGhsMkpUZVFqUCtPVisrTkVObjlGT3Rna2dyV3VONVE3L0hT?=
 =?utf-8?B?WE9iakRBQzgyV3dQMlJtTUk4R2lQMnpUZjFZQWdQQTBVaVlXcGtZcmJ1bkxw?=
 =?utf-8?B?OWZ6clN0MWliQkQrd3hxT1RXdDNJNFpRS2tWaGFvam53c3dqSVRySjVUSHdV?=
 =?utf-8?B?amNXQ1VDZmY5aktCdDdoNkUra1huT0tIc0JVSjBGU2tDRlVxQktQZlAwekti?=
 =?utf-8?B?V1ErUGxCOVRpUkJwRnhnVGJ5dlVPSGV0WlQyby9RaENnRmZiUTk2TW9vaW1Y?=
 =?utf-8?B?VWtPaUNHVXM1OWJpdEhzVnVWM0FaOWF6c29hc3AzWDZseXdRWnVOeW8wSjFm?=
 =?utf-8?B?SW1kMDVqZWs4M0dSQ0djRmR1TTZZSnpaYk8wSXh4MC80YkR5Wm1XT29yZUJa?=
 =?utf-8?B?cjlzYWRDY3RSUnREakt2M1pnZlNUZUxheWJ1dmpQUng5WFU4T1grSnNIWWNv?=
 =?utf-8?B?dzd2bklraTVkNzlKblF6S2dWZU45SWxHRFJxaldYT3E5OHVmSFdUM2hMcWJY?=
 =?utf-8?B?bTlrWGFtcFhHTTFwU29OdjcyM0o0cDlJT0hSVXBrZ09FZENmWHJOTkNCQTNE?=
 =?utf-8?B?NkpyWWpVZlVnSTVjYTdNTEpSVXV3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9B0E6E5CA257314482F29259ABF1154B@namprd13.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9de3a4ed-8bd4-42f9-a45c-08dcde6617c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2024 20:02:04.6128
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: STA+TeNe30tkHGRP2p+9HPAqlbm2wa7z5mXd8pnfqO9z/4ZSEYCD/P2hDnzaUPwoBZOF1Q5grcaJu/beECM7+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR13MB5178

SGkgT2xla3NhbmRyDQoNCk9uIE1vbiwgMjAyNC0wOS0yMyBhdCAxMzoxNSAtMDcwMCwgT2xla3Nh
bmRyIFR5bW9zaGVua28gd3JvdGU6DQo+IEhpIFRyb25kLA0KPiANCj4gRm9sbG93aW5nIHVwIG9u
IHRoaXM6IGRvIHlvdSBoYXZlIHBsYW5zIHRvIHN1Ym1pdCB0aGUgcGF0Y2ggeW91DQo+IHByb3Bv
c2VkDQo+IG9yIGRvIHlvdSB3YW50IG1lIHRvIHJld29yayBteSBzdWJtaXNzaW9uIGFsb25nIHRo
ZSBsaW5lcyB5b3UNCj4gcHJvcG9zZWQ/DQoNCkxldCdzIGp1c3QgbWVyZ2UgdGhlIHBhdGNoIEkg
cHJvcG9zZWQuIEkndmUgc2VudCBhICJjbGVhbiIgY29weSB0byBBbm5hDQp0byBzZW5kIHVwc3Ry
ZWFtIGluIHRoZSBuZXh0IGJ1Z2ZpeCBwdWxsLg0KDQpUaGFua3MhDQogIFRyb25kDQoNCg0KDQot
LSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJz
cGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==

