Return-Path: <linux-nfs+bounces-9111-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EDEEA09993
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Jan 2025 19:40:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2685A188DAE2
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Jan 2025 18:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 083E42080CF;
	Fri, 10 Jan 2025 18:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="H18sMOFA"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2108.outbound.protection.outlook.com [40.107.93.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB322212B17
	for <linux-nfs@vger.kernel.org>; Fri, 10 Jan 2025 18:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736534439; cv=fail; b=B7BPiVqNPhIR19GA3TjGwnUBovYXc9WGEkH6F2R79L1AB5K5FfIX+fDixs7owEWBbBr572X0aL+VAAvDGbjs8N7pGgwkMoaT3+B/zfbk3qv9XYoY12LxNrSZfnuTWr6RGei/ewbL6L3FIzsevyO6ZcjQbM7NW73/63IGHleQ7Ng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736534439; c=relaxed/simple;
	bh=/WU0A8lEaSb/PUK6PBE6ujLW26MHDPWprAjBYU+QtBc=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=R28zw2jklWdj+V34NKMNvULmkU65YBD0L/gn2oIJSxVaVeiLQh2FE5GViinzq87qKJ0mJcpirdBl3elcfhOt+rT2C986r3WaXpxQpxmd4Hfv3GjbIaLIg/Lu6k+VsFfFv2R4dcsfE3MobTDZWPIu4HdXZudGh3n2aWzHd0JjcDE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=H18sMOFA; arc=fail smtp.client-ip=40.107.93.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H4YOaxgwQTFE+wiJcq0XRZAspQ3H4en0Hk8GFJ8pNsg4NcevssHoic/mAtgY5mZsx/5HdijAh5qrkQTXs5avc2zpoHddBTtFxNIAs91z5oQNYAV6sGbANgqBDq1xd6HwGgI1sK8m1Nys654SIFN0AORaSKUrpmst8agEryV5v+kKU9x6M0lU7xS/kLAnBhLMUcSZhTl2i+DZQlOeD7GsiLShhnJQzFe2NabYVPPjI9kM2qg1PW4qtxI90ndxItDUBhV5te4Bd++eWtUUao5AdiEt1lO7NUbXTbXhTveGOSDAH7JI08WAXXLj0sITYXQsYwJkWdrkRxzybgc6Wuat2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/WU0A8lEaSb/PUK6PBE6ujLW26MHDPWprAjBYU+QtBc=;
 b=rckeO3j4cRPxUA25w334H2ZHHG2YdpdfN/AaVJHW4pHIqIZ1yeXLNGiKKMppb3SRKwCM5Rzp5U70Z2vZbYPLOPFmCh/hkkgnhYsRjv5cD5IwKmcAA4KVymhDbxx6XG8b7XbwAX0YsOg6k8mcOKO9q+8cRd4o3iqelzAMXXHHa3AAS3IOx/exH8w5eAB1OSq6iop7uSxJCDNAb3ywD4SoF45i3srpj1rOcLiAVQyaByVlj6THxYNPp+ooFrWwaWhoT3NeCsU1yVZKTu3Wis4BAed9hZMXvtkkRMsFOI9+ChkdnXOuzW6eUz2cK/rzpjaqCzH6F9Et/YsCEU3zOF+Nww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/WU0A8lEaSb/PUK6PBE6ujLW26MHDPWprAjBYU+QtBc=;
 b=H18sMOFAIPKNDvOVMJYobJtLQsE5gU4sV9oX6vbsBe+e4ckoD0k3TyiuDoIV1qxTKZQ+HDe2Xppu6e+SScFd5nrRlKlMG//v92cy9HcB7VRYBQ/3F5G3HCW6fbslJo0XrxF+a3ANadnHxl3Td+YZbAlGmB04QIdPIXwlV2sj2WA=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by MWHPR13MB6983.namprd13.prod.outlook.com (2603:10b6:303:289::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Fri, 10 Jan
 2025 18:40:34 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb%4]) with mapi id 15.20.8335.011; Fri, 10 Jan 2025
 18:40:34 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	"takeshi.nishimura.linux@gmail.com" <takeshi.nishimura.linux@gmail.com>
Subject: Re: Needed: ADB (WRITE_SAME) support in Linux nfsd
Thread-Topic: Needed: ADB (WRITE_SAME) support in Linux nfsd
Thread-Index:
 AQHbYJaq3MygkbCfP0CN7hucB1iK17MLa3AAgAAHR4CAABYkgIADrQeAgABF2gCAAOFZgA==
Date: Fri, 10 Jan 2025 18:40:34 +0000
Message-ID: <d9b75fd6bc96b0155d8d06300e2426168e1e1648.camel@hammerspace.com>
References:
 <CALWcw=Gg33HWRLCrj9QLXMPME=pnuZx_tE4+Pw8gwutQM4M=vw@mail.gmail.com>
	 <e3d4839b-0aa0-42f5-b3d1-4fd2d150da75@oracle.com>
	 <CALWcw=G-TV19UPmL=oy-HE9wc0q-VpHBVyuYcVQ8b9OQq-8Lqg@mail.gmail.com>
	 <5c928bae-38e4-490a-a9e7-f52b27a462c9@oracle.com>
	 <978d12deaa44ee896d0f1cf42f6745c2b9c9ee6e.camel@hammerspace.com>
	 <CALWcw=F5GncgXSK9q3uTPmCVTJOUuP7E6uUVPpzz2dnKFLt9pg@mail.gmail.com>
In-Reply-To:
 <CALWcw=F5GncgXSK9q3uTPmCVTJOUuP7E6uUVPpzz2dnKFLt9pg@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|MWHPR13MB6983:EE_
x-ms-office365-filtering-correlation-id: 8bcab045-bb9b-4b2a-a8f1-08dd31a644d8
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UXMvR3FyazJVVFZuUUJIbmFVelRsSHhqRklLU1RMN21rcjVBUlhKck40SVVL?=
 =?utf-8?B?K1p2UFFlaDQraVBTREtQeDREYUlSR0VMZnUzNUdMTnNQeHg0b1N5R1NhMnQy?=
 =?utf-8?B?VzJLZEJqU1FkR3JJdkY4RENnM3g3UHlyRHlkaUJQQ3FYVWRoa1laUjVINUxE?=
 =?utf-8?B?bVZJRCtqMHlSK00zalFaa3R2K0lDN2RyVkFvMXdpMTh2dVN2YUkwcHBOQ3Na?=
 =?utf-8?B?OERQQW43Zm9SR3REWHpNZEE0UEk1bm9Zb3BnR2RiTStyeVdGek1OVVRRby91?=
 =?utf-8?B?cXFmcE5EbFpQYzJ3S3A2V1lDb3N3MVhuSjBZT1lVbENzQmErMnVxM0UvL2Y1?=
 =?utf-8?B?ZHJ3OTBhQkQ0Q1lJSkJUSytlbStLOEhJQUdLa3lUV3NnWXRCT0xKYTRoSTFv?=
 =?utf-8?B?NEhadVN0eURJc0hqWlFuTk1FeU1kNTJVYzJVUExramFXR1hTN2tpVFRBZ1NH?=
 =?utf-8?B?d1pVY3M0ZGRCdGlUT0U0QThMVXp1WFo5bWRsVWpYR25JUjVaTzM2ZjdlNFI3?=
 =?utf-8?B?dGQzVWlYdU5IUSthazhSSnZhWlRTTHI0K0JKNUx1ZUkwbUFFZldKeUJqNm9p?=
 =?utf-8?B?Zm5YLzQyeG05WkhxTmtaV0JiazFiZnRKUmRsMkdMZXhrRWtzTCs3dENPcWFj?=
 =?utf-8?B?T0xKRmtkTmF2WkJHQkNZSjdSVEJmckdaT2tXMmRJOXptdFpVSTRjRjNDSlUy?=
 =?utf-8?B?TW54OUlueUg4MG5xaUVMRDFpSCs5aUZHWG1XZEQ5WG5EWGZ0cGN5Y2MrSHRQ?=
 =?utf-8?B?d01RVHgvaTIrQ3pJNGlpTmllRWpmeTlXOElsUVVKTys3amFybnBMNnEzNDQv?=
 =?utf-8?B?dzFPeWtaY0lnL3dIVVBIZTRnYzBibFV5aGFSVzJjcmFOcHBuTzNBUklpVlRa?=
 =?utf-8?B?cXJRL1IrTkx0czFKWHhXcVJMTjF3ZEtoeXAwdDhvd2I2L2JFbHcrbnhmN3FU?=
 =?utf-8?B?ZW1ZbU9mSXhsckdLSE9GNkxabDRXaE4rUmpZZ3JuaUU2TUtidWNqdlJGUXJ2?=
 =?utf-8?B?U3dHNFhOam9iTXVZKzVtN21wMXVpZUFLWXdEdnI1dE1DZXdoU2Z6U3l6cFR1?=
 =?utf-8?B?VmVYT2xIOHlKaVV6NVNvcHhaVWZ6YUlWUU9hK1JtM0ovZ0hSbW5jeVA2WnZa?=
 =?utf-8?B?K1hia0NFT0l3bGt1OGE2UVNIVW9USnpFTGZKMC9vcTA4N1puOEJaU0FwejNW?=
 =?utf-8?B?dkhNamVEOVE2dGdHMG4vL2p2c2d4aWp4cVpudEViVXZwbDFsS1NDdGFvdWx6?=
 =?utf-8?B?Y0ZDemVpT3UxL2txYWNEL0hneGNqZmc4TGZCdHdhNU15aDduYjF6NkVPYVRo?=
 =?utf-8?B?U3JsTlFCakFOUnk1elgxTUplZVRDNkliQ3lzMGRkQ2VvLzJKdFVOcllFL2lS?=
 =?utf-8?B?bVhQQSsvMkplMmxjK1BEZ294eEI2dldoaTB6YlZhKzRZMkd4blFoZDd6U3dt?=
 =?utf-8?B?cTAzdG1BU1BOdStTVkh3bjlEclVkeGtpNkFGQ05iVTBMclhJdjI4T0F6REVY?=
 =?utf-8?B?TjFiRW5LV1RBSVZIbExwVUR1N3FWUElLSkwrVFlWSFZwZ2x2Y09GMW4vZGlt?=
 =?utf-8?B?MzdLbnVzeU14Um13Z2Vnb2Y2UWpDblhGU3BpZTJVZXBlNDZqd2h0Z2hGb3o2?=
 =?utf-8?B?WkZtOEtObUo1Nk1kOUlEb3hlYmZxVnMwdzBCUDZFM0thN3J6RXNhaDdtYk4r?=
 =?utf-8?B?ZU85OHdtaVJRV21KcllnVWlzNjY5VmI5MWw5SHhoNUN0cmMrOGNMZnJCbGRs?=
 =?utf-8?B?Q21mOUtiL1JvNzJ6Q2xFN3YzOEdoOERBTDZNSWtGREN1OXVXNUhNSWZIQ2lU?=
 =?utf-8?B?Z3pIUUhmRHlrM3hScnVscXFtWHRZUFFYcjdnYkRacHV3NUpJNG91WCs1RnVi?=
 =?utf-8?B?YWtsTmhVTUJnUXFuajl0ZTgvSGxFMFZWRlJ0N2VWS0llcS9aS2c4TkpheXcw?=
 =?utf-8?Q?jYpP1hMbFCx4Mvzo3wTKkvgkSlbEc7sQ?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(10070799003)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bjIyN3BvaUtrR1BGMloyWWY1Yng5RmFwTDMyTmdvNUlVbnAxNTNSL3EzVExr?=
 =?utf-8?B?N042Mm1WTTVXNzIwb0lSblRRVVRwNUpibmxNUzI5UmhqR2ZJTTU4cFBwTHJT?=
 =?utf-8?B?UmZYak1zNW5Fc3NnbElhaWZyeU1SbGdGd05uZlBNL05pS1J1L1ZYVVdMY3h6?=
 =?utf-8?B?TE1rOXRKTkNuSGp2ZEo1MWNhMXAzQ1V5ZzZwWVQ2QjJNRHdBOHVJbFBidCtD?=
 =?utf-8?B?TkRiVDM2d3VsS1N5NVpkR2tZbG12T3JlQ1hxWlhDdW5OaUtNL0tVb3p0MTJ3?=
 =?utf-8?B?ZzRwTkNtRnlpaTI0TFd2dUhObENUeGozQ0tBUXhhK1Z4bzlnZzdDVWszS2Yw?=
 =?utf-8?B?ZGx1S05mTUFGTmZXazF0UHA1ZkVxS3ZKdFNkZG1Ncnk5bFJYTUNvNlNuVElS?=
 =?utf-8?B?OERKR2taand0REk3YVZFL0YyQ05IbmZUbjdtS3g0d0E5T0RUZTFnMU92aXZ0?=
 =?utf-8?B?ZHEzYWpUSUlWb2pwVU1ScWNKTVNXT0ZORmlTQllvckpYUjhNRWVQTEc2TGNC?=
 =?utf-8?B?MGN3cGkzNXo4b3l5NjFKMGZHN0xyd1N2d3F0c005QkFaTmFncEFpV3JVVjBV?=
 =?utf-8?B?RXhSeE4wdWQ3K2NCS0U3WW5MNDBJbkZtdFpIK3ZrallsQndYQS9ycTBhSHFE?=
 =?utf-8?B?cDJsUEhCbGpzTUJSWlB3WktZRExadk9LZi9uUW16ck5lOEVWTCtjQjJsdGlz?=
 =?utf-8?B?dFFuVUFacUo1OWR4RFdaS2hRS01DUC9KcG1EUWVRSkRmVFQyY1B0d3NXVGVW?=
 =?utf-8?B?MDRqNHR4dkE4VFRIcC9qaEhTNUxWVFBCU2ZaeUpzZW1EckoreUhjMUlCTzNG?=
 =?utf-8?B?TWFKQVY0dk9BOGZ1VzBuNDFvanN5Y1ExN2UwQ1AvUitMb2txbXpyNmFwbnVC?=
 =?utf-8?B?YUdiKzVHeVAyamk5L05SdkpSK2ZFVEtneGc2RHZWMk1IRnJOSUVUTnNwMzFC?=
 =?utf-8?B?eW1rMmRtVmxjb0lZTC9iRGQrTVNOTWF6azJNQmJoNnFzQTFKajYrV05QS3Mz?=
 =?utf-8?B?TkJraUFjL29RR1BtTi9aYWNScFJwZmh1L0c5SkFmV3hRQmFTOEFEN1lWQ1Va?=
 =?utf-8?B?STdHcmtUZVYxTTZld0hRaGcvM0JubnBqOFdPbGd0M2NYQmc0aFNpWDk0eXQy?=
 =?utf-8?B?TlhrL0hkeGNBaHNrMkdDYytYZ2J5ZEs1bGlSblB1WHJ3WUtHY0tLMUtSY1Rm?=
 =?utf-8?B?a3FWQTlkZ1Q4WjhpUUxKVjg1SURuV1FlVk1jNjhSS0did2JSc21SVjRWRm5F?=
 =?utf-8?B?d2YvbFVZQ0x0WEs1RzkySGtXOTJObFZYZEUyb3RvZEpBblRISlFQTGMvMnN1?=
 =?utf-8?B?VlhuMnM4QUZheTExMzM2V0kwUklDdE9BanpxRERBVmI0Q1lCNXRVQU9hMWI0?=
 =?utf-8?B?akZoM2R1VU1XV0hiYUc2WmU4dDFDUmx2Mkc4M2xNb3RadEJIdW85YzE1ZVJV?=
 =?utf-8?B?bWJVcFg3dmI4L3NDQUFCalEzajFwT29IQ3ZDNnNPbnJMUGNEakF0ekJUZDR4?=
 =?utf-8?B?dFBKNnNyRmVrRG5Qai9oVzNYaGh3RldGMTRVNlQzYTJ0TGpSQkJyNXk5TGdh?=
 =?utf-8?B?a1JJam9MRzhERXl3TlZySHRGaFhOc0tuUVBBeXNQa1c2akcvRjRVRTIxaDdE?=
 =?utf-8?B?WnpHWlNhRnkrdWVmdmpCYm9hNWhtcDFzNVRnM3JyOHI4WHRUWEZJT1NkejRG?=
 =?utf-8?B?ZElsRVpwcEZRdjZTdnpQdTIxRUtWKy9UTllmQ1FrbUtXODBCczhDbE9xTTFt?=
 =?utf-8?B?c1BDNlB4WWlTN1hPay9JU0F2cnpEbTJTQXcvQ2g5SndSbkoyNU43czg4VWlz?=
 =?utf-8?B?UHNiUnE2S3ZjRmFjUUpFTFVZTGFYR3VHbEN4QUg4UlVoMVBUL3JHLzAwSCsr?=
 =?utf-8?B?ZDR2MmZIS3NiRGRNck9RcWxJZVpyZ2svbkJFMGpZOWVWK3loeEV0MHhkTGRF?=
 =?utf-8?B?dVJlc2ZIYkJDdUVrY0RyM2ZpTmV6cnBJSnF2b3RpeEtlWU5sWkxZaExkMksy?=
 =?utf-8?B?eHlqeWI4QmMxVUJVOW9hVnhIUTdUeWtVOElMbGZBcm1SM21Db3VhMXd1a1Vn?=
 =?utf-8?B?WXVwRlh1NzdxUDlSQlhDcjFhU3p4b2JlVGFCZHpSQ1hORG1veFl0RDc0REdY?=
 =?utf-8?B?bndpaHFBODh5bml3ajBIQ24yL3VnSGdVTHVmVEtZaE1DMHcrVU1DN2lKbEVJ?=
 =?utf-8?B?V2VMdjB5Rk5GRU04eENkZEdUdSsxRFVQK2xZWjljQ21KeWs0SDF1MXJYSEg1?=
 =?utf-8?B?QmVodlZra0E1ZGpqazV3SEVibnhBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CDCD63D29492E34BB42C77E8B7FBC925@namprd13.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bcab045-bb9b-4b2a-a8f1-08dd31a644d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2025 18:40:34.5289
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GLJFZzbbKFsEvygkVrwrR2kDuVp/2Kx7FhU9mimM5kht/oSCq7u1Vygm1PEX1wtwV1LriLEB3ryPKoTve0G3LA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR13MB6983

T24gRnJpLCAyMDI1LTAxLTEwIGF0IDA2OjE0ICswMTAwLCBUYWtlc2hpIE5pc2hpbXVyYSB3cm90
ZToNCj4gT24gRnJpLCBKYW4gMTAsIDIwMjUgYXQgMjowNOKAr0FNIFRyb25kIE15a2xlYnVzdA0K
PiA8dHJvbmRteUBoYW1tZXJzcGFjZS5jb20+IHdyb3RlOg0KPiA+IA0KPiA+IE9uIFR1ZSwgMjAy
NS0wMS0wNyBhdCAxMTo1NSAtMDUwMCwgQ2h1Y2sgTGV2ZXIgd3JvdGU6DQo+ID4gPiBPbiAxLzcv
MjUgMTA6MzYgQU0sIFRha2VzaGkgTmlzaGltdXJhIHdyb3RlOg0KPiA+ID4gPiBPbiBUdWUsIEph
biA3LCAyMDI1IGF0IDQ6MTDigK9QTSBBbm5hIFNjaHVtYWtlcg0KPiA+ID4gPiA8YW5uYS5zY2h1
bWFrZXJAb3JhY2xlLmNvbT4gd3JvdGU6DQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gSGkgVGFrZXNo
aSwNCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBPbiAxLzYvMjUgNjo1NiBQTSwgVGFrZXNoaSBOaXNo
aW11cmEgd3JvdGU6DQo+ID4gPiA+ID4gPiBEZWFyIGxpc3QsDQo+ID4gPiA+ID4gPiANCj4gPiA+
ID4gPiA+IGhvdyBjYW4gd2UgZ2V0IEFEQiAoV1JJVEVfU0FNRSkgc3VwcG9ydCBpbiAoRGViaWFu
KSBMaW51eA0KPiA+ID4gPiA+ID4gbmZzZCwNCj4gPiA+ID4gPiA+IGFuZCBhbg0KPiA+ID4gPiA+
ID4gaW9jdCgpIGluIExpbnV4IG5mc2QgY2xpZW50IHRvIHVzZSBpdD8NCj4gPiA+ID4gPiANCj4g
PiA+ID4gPiBUaGFua3MgZm9yIHRoZSByZXF1ZXN0ISBKdXN0IHNvIHlvdSdyZSBhd2FyZSBvZiB0
aGUgcHJvY2VzcywNCj4gPiA+ID4gPiB0aGlzDQo+ID4gPiA+ID4gZW1haWwgbGlzdCBpcyBmb3Ig
dXBzdHJlYW0gTGludXgga2VybmVsIGRldmVsb3BtZW50LiBJZiB3ZQ0KPiA+ID4gPiA+IGRlY2lk
ZQ0KPiA+ID4gPiA+IHRvIGdvIGFoZWFkIHdpdGggYWRkaW5nIFdSSVRFX1NBTUUgc3VwcG9ydCBp
dCdsbCBiZSB1cCB0bw0KPiA+ID4gPiA+IERlYmlhbg0KPiA+ID4gPiA+IGxhdGVyIHRvIGVuYWJs
ZSBpdCAodGhhdCBwYXJ0IGlzIG91dCBvZiBvdXIgaGFuZHMsIGFuZCBpc24ndA0KPiA+ID4gPiA+
IHVwDQo+ID4gPiA+ID4gdG8gdXMpLg0KPiA+ID4gPiANCj4gPiA+ID4gSSBhc3N1bWUgV1JJVEVf
U0FNRSB3aWxsIG5vdCBoYXZlIGEgc2VwYXJhdGUgYnVpbGQgZmxhZywgcmlnaHQ/DQo+ID4gPiA+
IA0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiBXZSBoYXZlIGEgc2V0IG9m
IGN1c3RvbSAiYmlnIGRhdGEiIGFwcGxpY2F0aW9ucyB3aGljaCBjb3VsZA0KPiA+ID4gPiA+ID4g
Z3JlYXRseQ0KPiA+ID4gPiA+ID4gYmVuZWZpdCBmcm9tIHN1Y2ggYW4gYWNjZWxlcmF0aW9uIEFC
SSwgYm90aCBmb3INCj4gPiA+ID4gPiA+IGltcGxlbWVudGluZw0KPiA+ID4gPiA+ID4gInplcm8N
Cj4gPiA+ID4gPiA+IGRhdGEiIChmaWxsIGJsb2NrcyB3aXRoIDAgYnl0ZXMpLCBhbmQgZmlsbCBi
bG9ja3Mgd2l0aA0KPiA+ID4gPiA+ID4gaWRlbnRpY2FsIGRhdGENCj4gPiA+ID4gPiA+IHBhdHRl
cm5zLCB3aXRob3V0IHNlbmRpbmcgdGhlIHNhbWUgcGF0dGVybiBvdmVyIGFuZCBvdmVyDQo+ID4g
PiA+ID4gPiBhZ2Fpbg0KPiA+ID4gPiA+ID4gb3Zlcg0KPiA+ID4gPiA+ID4gdGhlIG5ldHdvcmsg
d2lyZS4NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBIYXZpbmcgc2FpZCB0aGF0LCBJJ20gbm90IG9w
cG9zZWQgdG8gaW1wbGVtZW50aW5nIFdSSVRFX1NBTUUuDQo+ID4gPiA+ID4gSQ0KPiA+ID4gPiA+
IHdvbmRlciBpZiB3ZSBjb3VsZCBzb21laG93IHVzZSBpdCB0byBidWlsZCBzdXBwb3J0IGZvcg0K
PiA+ID4gPiA+IGZhbGxvY2F0ZSdzIEZBTExPQ19GTF9aRVJPX1JBTkdFIGZsYWcgYXQgdGhlIHNh
bWUgdGltZS4NCj4gPiA+ID4gDQo+ID4gPiA+IE5vLCBJIGFtIGFza2luZyByZWFsbHkgZm9yIFdS
SVRFX1NBTUUgc3VwcG9ydCB0byB3cml0ZQ0KPiA+ID4gPiBpZGVudGljYWwNCj4gPiA+ID4gZGF0
YQ0KPiA+ID4gPiB0byBtdWx0aXBsZSBsb2NhdGlvbnMuIExpa2UNCj4gPiA+ID4gaHR0cHM6Ly9s
aW51eC5kaWUubmV0L21hbi84L3NnX3dyaXRlX3NhbWUNCj4gPiA+ID4gV3JpdGluZyB6ZXJvIGJ5
dGVzIGlzIGp1c3QgYSBzdWJzZXQsIGFuZCBub3Qgd2hhdCB3ZSBuZWVkLg0KPiA+ID4gPiBXUklU
RV9TQU1FDQo+ID4gPiA+IGlzIGludGVuZGVkIGFzICJiaWcgZGF0YSIgYW5kIGRhdGFiYXNlIGFj
Y2VsZXJhdG9yIGZ1bmN0aW9uLg0KPiA+ID4gPiANCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBJJ20g
YWxzbyB3b25kZXJpbmcgaWYgdGhlcmUgd291bGQgYmUgYW55IGFkdmFudGFnZSB0byBsb2NhbA0K
PiA+ID4gPiA+IGZpbGVzeXN0ZW1zIGlmIHRoaXMgd2VyZSB0byBiZSBpbXBsZW1lbnRlZCBhcyBh
IGdlbmVyaWMNCj4gPiA+ID4gPiBzeXN0ZW0NCj4gPiA+ID4gPiBjYWxsLCByYXRoZXIgdGhhbiBh
cyBhbiBORlMtc3BlY2lmaWMgaW9jdGwoKSwgc2luY2Ugc29tZQ0KPiA+ID4gPiA+IHN0b3JhZ2UN
Cj4gPiA+ID4gPiBkZXZpY2VzIGhhdmUgYSBXUklURV9TQU1FIG9wZXJhdGlvbiB0aGF0IGNvdWxk
IGJlIHVzZWQgZm9yDQo+ID4gPiA+ID4gYWNjZWxlcmF0aW9uLiBCdXQgSSBoYXZlbid0IGNvbnZp
bmNlZCBteXNlbGYgZWl0aGVyIHdheSB5ZXQuDQo+ID4gPiA+IA0KPiA+ID4gPiBHZXR0aW5nIGEg
bmV3LCBnZW5lcmljIHN5c2NhbGwgaW4gTGludXggdGFrZXMgMy01IHllYXJzIG9uDQo+ID4gPiA+
IGF2ZXJhZ2UuDQo+ID4gPiA+IEJ5DQo+ID4gPiA+IHRoZW4gb3VyIHByb2plY3Qgd2lsbCBiZSBm
aW5pc2hlZCwgb3IgcmVuZXdlZCB3aXRoIG5ldyBmdW5kaW5nLA0KPiA+ID4gPiBidXQNCj4gPiA+
ID4gYWxsIHdpdGhvdXQgZ2V0dGluZyBhIGJvb3N0IGZyb20gV1JJVEVfU0FNRSBzdXBwb3J0IGlu
IE5GUy0NCj4gPiA+IA0KPiA+ID4gRm9yIGNvbXBhcmlzb246DQo+ID4gPiANCj4gPiA+IEFkZGlu
ZyBXUklURV9TQU1FIHRvIHRoZSBMaW51eCBORlMgY2xpZW50IGFuZCBzZXJ2ZXINCj4gPiA+IGlt
cGxlbWVudGF0aW9uDQo+ID4gPiBpcw0KPiA+ID4gb24gdGhlIHNhbWUgb3JkZXIgb2YgdGltZSAt
LSBhIHllYXIgKG9yIHBlcmhhcHMgbGVzcyksIHRoZW4NCj4gPiA+IGdldHRpbmcNCj4gPiA+IGl0
DQo+ID4gPiBpbnRvIERlYmlhbiBzdGFibGUgd2lsbCBiZSBtb3JlIHRoYW4gMSB5ZWFyLCBwcm9i
YWJseSAyIG9yIDMgKGF0DQo+ID4gPiBhDQo+ID4gPiBndWVzcykuDQo+ID4gPiANCj4gPiA+IEEg
YmV0dGVyIGFwcHJvYWNoIHdvdWxkIGJlIGZvciB5b3VyIHRlYW0gdG8gaW1wbGVtZW50IHdoYXQg
dGhleQ0KPiA+ID4gbmVlZCwNCj4gPiA+IHVzZSBpdCBmb3IgeW91ciBwcm9qZWN0IChpZSwgY3Vz
dG9tIGJ1aWxkIHlvdXIga2VybmVscyksIHRoZW4NCj4gPiA+IGNvbnRyaWJ1dGUNCj4gPiA+IGl0
IHRvIHVwc3RyZWFtIHNvIG90aGVycyBjYW4gdXNlIGl0IHRvby4gVGhhdCB3b3VsZCBkZW1vbnN0
cmF0ZQ0KPiA+ID4gdGhlcmUNCj4gPiA+IGlzDQo+ID4gPiByZWFsIHVzZXIgZGVtYW5kIGZvciB0
aGlzIGZhY2lsaXR5LCBhbmQgeW91ciBjb2RlIHdpbGwgaGF2ZQ0KPiA+ID4gZ2FpbmVkDQo+ID4g
PiBzb21lDQo+ID4gPiBtaWxlcyBpbiBwcm9kdWN0aW9uLg0KPiA+ID4gDQo+ID4gPiBZb3UgY291
bGQgaGlyZSBhIGNvbnN1bHRhbnQgdG8gaW1wbGVtZW50IGl0IGZvciB5b3Ugb24gYSB0aW1lDQo+
ID4gPiBmcmFtZQ0KPiA+ID4gdGhhdA0KPiA+ID4gaXMgeW91ciBjaG9vc2luZy4NCj4gPiA+IA0K
PiA+ID4gVXBzdHJlYW0gcHJpb3JpdGl6ZXMgZWNvbm9teSBvZiBtYWludGVuYW5jZSBvdmVyIGNv
ZGUgdmVsb2NpdHk7DQo+ID4gPiBtZWFuaW5nLA0KPiA+ID4gaG93IHF1aWNrbHkgYSBmZWF0dXJl
IGNhbiBiZSBwcm90b3R5cGVkIGFuZCBwcm9kdWN0aXplZCBpcyBsZXNzDQo+ID4gPiBpbXBvcnRh
bnQgdG8gdXMgdGhhbiBob3cgbXVjaCB0aGUgZmVhdHVyZSB3aWxsIGNvc3QgdXMgdG8NCj4gPiA+
IG1haW50YWluIGluDQo+ID4gPiB0aGUgbG9uZyBydW4uDQo+ID4gPiANCj4gPiA+IFdpdGggbXkg
TkZTRCBjby1tYWludGFpbmVyIGhhdCBvbjogSSB3b3VsZCBhY2NlcHQgYSBXUklURV9TQU1FDQo+
ID4gPiBpbXBsZW1lbnRhdGlvbiwgYnV0IGl0IHdvdWxkIGhhdmUgdG8gY29tZSB3aXRoIHRlc3Rz
IC0tIHB5bmZzIGFuZA0KPiA+ID4geGZzdGVzdHMgYXJlIHRoZSB1c3VhbCB0ZXN0IGhhcm5lc3Nl
cyB0aGF0IGNhbiBhY2NvbW1vZGF0ZSB0aG9zZS4NCj4gPiA+IA0KPiA+ID4gSW4gYWRkaXRpb24s
IE5GU0QgaXMgcmVzcG9uc2libGUgb25seSBmb3IgdGhlIG5ldHdvcmsgcHJvdG9jb2wuDQo+ID4g
PiBUaGUNCj4gPiA+IGxvY2FsIGZpbGUgc3lzdGVtIGltcGxlbWVudGF0aW9ucyBoYXZlIHRvIGhh
bmRsZSB0aGUgaGVhdnkNCj4gPiA+IGxpZnRpbmcuDQo+ID4gPiBJdCdzIG5vdCBjbGVhciB0byBt
ZSB3aGF0IGluZnJhc3RydWN0dXJlIGlzIGFscmVhZHkgYXZhaWxhYmxlIGluDQo+ID4gPiBMaW51
eA0KPiA+ID4gZmlsZSBzeXN0ZW1zOyB0aGF0IHdpbGwgdGFrZSBzb21lIHJlc2VhcmNoLiAoSSB0
aGluayB0aGF0IGlzIHdoYXQNCj4gPiA+IEFubmEgd2FzIGhpbnRpbmcgYXQpLg0KPiA+ID4gDQo+
ID4gDQo+ID4gVGhpcyBmdW5jdGlvbmFsaXR5IHNob3VsZCBiZSBwb3NzaWJsZSB0byBpbXBsZW1l
bnQgdXNpbmcgdGhlDQo+ID4gY2xvbmVfcmFuZ2UgaW9jdGwoKSBvbiB0aGUgc2VydmVyIG9yIG9u
IHRoZSBjbGllbnQgZm9yIHRoYXQgbWF0dGVyLg0KPiA+IA0KPiA+IFllcywgeW91J2xsIGhhdmUg
dG8gdXNlIG11bHRpcGxlIGNsb25lX3JhbmdlIGNhbGxzLCBidXQgeW91IGNhbiB1c2UNCj4gPiBh
DQo+ID4gZ2VvbWV0cmljIHNlcmllcyB0byBkbyBpdCBlZmZpY2llbnRseSAoaS5lLiB3cml0ZSBw
YXR0ZXJuLCBjbG9uZQ0KPiA+IHBhdHRlcm4sIGNsb25lIDIqcGF0dGVybiwgY2xvbmUgNCpwYXR0
ZXJuLCBldGMuLi4uKS4NCj4gPiANCj4gPiBJdCdzIG5vdCBoYXJkIHRvIGRvLCBhbmQgdGhlIGFk
dmFudGFnZSBpcyB0aGF0IGl0IGNhbiB3b3JrIGZvciBhbGwNCj4gPiBmaWxlc3lzdGVtcyB0aGF0
IGltcGxlbWVudCBjbG9uZV9yYW5nZS4gWW91J2Qgbm90IGJlIGxpbWl0ZWQgdG8NCj4gPiBqdXN0
DQo+ID4gdXNpbmcgTkZTIHdpdGggYSBzcGVjaWFsIFdSSVRFX1NBTUUgaW9jdGwuIEZ1cnRoZXJt
b3JlLCBkb2luZyBpdA0KPiA+IHRoaXMNCj4gPiB3YXkgaXMgc3BhY2UtZWZmaWNlbnQgb24gbW9z
dCBmaWxlc3lzdGVtcy4NCj4gPiANCj4gDQo+IFdoYXQgd2lsbCBoYXBwZW4gaWYgc29tZW9uZSBl
bHNlIHdyaXRlcyBpbnRvIHRoZSBzYW1lIGxvY2F0aW9uIHdoaWxlDQo+IHRoZSBnZW9tZXRyaWMg
c2VyaWVzIGlzIHJ1bm5pbmc/DQo+IFNob3VsZCBXUklURV9TQU1FIG5vdCBiZSBhdG9taWMsIG9y
IGF0IGxlYXN0IHByb3RlY3QgYWdhaW5zdCBvdGhlcg0KPiB3cml0ZXMgZGVzdHJveWluZyB0aGUg
ZGF0YT8NCg0KTm8uIFRoZXJlIGlzIG5vIHJlcXVpcmVtZW50IG9yIHByb21pc2Ugb2YgYXRvbWlj
aXR5IGZvciBXUklURV9TQU1FIGluDQpSRkM3ODYyLCBub3IgaXMgdGhlcmUgYW55IHJlcXVpcmVt
ZW50IHRoYXQgdGhlIHNlcnZlciB3aWxsIGxvY2sgb3IgZGVueQ0Kb3RoZXIgd3JpdGVzLg0KDQpJ
biBmYWN0IGluIHNlY3Rpb24gMTUuMTIuMy4gdGhlIHNwZWMgc3RhdGVzIGV4cGxpY2l0bHkgdGhh
dCB0aGF0DQpwYXJ0aWFsIGNvbXBsZXRpb24gbWF5IG9jY3VyLCBqdXN0IGxpa2UgZm9yIG9yZGlu
YXJ5IFdSSVRFLiBJdCBhbHNvDQpzdGF0ZXMgdGhhdCB0aGUgTkZTIGNsaWVudCBzaG91bGQgdXNl
IGxvY2tpbmcgaWYgaXQgcmVxdWlyZXMNCnNlcmlhbGlzYXRpb24gdy5yLnQgb3RoZXIgSS9PIG9w
ZXJhdGlvbnMuIEZpbmFsbHkgaXQgZGVzY3JpYmVzIHRoZQ0KYXN5bmNocm9ub3VzIGJlaGF2aW91
ciwgYW5kIGhvdyB0aGUgY2xpZW50IGNhbiB0cmFjayBwcm9ncmVzcyBpbiB0aGUNCmNhc2Ugb2Yg
bGFyZ2UgV1JJVEVfU0FNRSByZXF1ZXN0cyB0aGF0IGNhbm5vdCBiZSBoYW5kbGVkIHF1aWNrbHkg
ZW5vdWdoDQp0byBiZSBzeW5jaHJvbm91cy4NCg0KU28gaWYgeW91IHJlcXVpcmUgYXRvbWljaXR5
LCB0aGVuIHlvdSBuZWVkIHRvIGxvb2sgc29tZXdoZXJlIGVsc2UuDQoNCi0tIA0KVHJvbmQgTXlr
bGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5t
eWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K

