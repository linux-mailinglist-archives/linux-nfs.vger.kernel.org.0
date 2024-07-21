Return-Path: <linux-nfs+bounces-4999-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 996B7938588
	for <lists+linux-nfs@lfdr.de>; Sun, 21 Jul 2024 18:41:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1994A1F211A3
	for <lists+linux-nfs@lfdr.de>; Sun, 21 Jul 2024 16:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFA4F1649CC;
	Sun, 21 Jul 2024 16:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="bWXEVm/7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2128.outbound.protection.outlook.com [40.107.243.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40B91662FD
	for <linux-nfs@vger.kernel.org>; Sun, 21 Jul 2024 16:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721580057; cv=fail; b=Vaf0PNIYjyTjlsUXLntsdG7a6QW9aOBqNsSBkrdlqbk4PXEa8l/nZO0ubLfSutafi1xgUo/Ju8aWdw7+DuR8dljANu9hzTwlnABryyGPZtgx54WZDlG9wdgvIiFCOPFzFopqAgISQEwzHNmvahgs/N8PHFwtAtWKlR9JQ+TdgN4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721580057; c=relaxed/simple;
	bh=yug3i8HJNDmObcyzOPKBM8EbcNPwsD1R9hBaJX6ZwJU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DI3rFkYIqc0B+K4AB4QiEtGN8VrHtymqFYzE/K7vAlflhV7h6ktq4y2/x5v4qkA0Hd2pTMR6XKN9IuG+2FpOFvy4hTqraP8+TXp4OshstQgR4kvUEnPj39tiJBbmbXFvJbwwT3hefPw6griJyDebylzuB37yUtloP98m5kMcXOs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=bWXEVm/7; arc=fail smtp.client-ip=40.107.243.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mFWzkjh9pmgE/WUQsV5mhININRp8lK+YCwj26Bb0YsIomzf+ZP8xo8L/0VKX4BtDYtzlU9pmOhjnqfbCT1cgJWzwjFPImDjKDwdCIBO8hos4CD11BHvUhfyno0Z4yWZHi8FwJvKOss4Zh2LVwseWp5p8ZmVhj8hr9Bfv/yjU7kaYVY5cEVs9lvFozBCDMVjHtY6ObnRlR+Tnqd+/92Wz+92I3OAFxiTLQt3E33dGTZBkXzeWum3aQ70Nzv95CyBesurggKrnOTmEOHQY1zp0X24jakfLwApzRz51BLOWt/XhFI48AQlvrj8cOPpc8+BjoCWw668p6a+rq3PkTEtKvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yug3i8HJNDmObcyzOPKBM8EbcNPwsD1R9hBaJX6ZwJU=;
 b=Cekdo3+1t247kQSsMMizvuYczo7QWriR/pOKDxF3Kbt2G5dCT3I12siTM7eL0hdU0WO2T3oywvPseeUZaP1SEc/7uWr06I0z9O+qAUPyUiXjdAF/6voKauSlIJhNOZbQUoWIw1SEFJX+3XryXLWODEBQuBGKVASCDHJy3GKquQgfbZiml7bkgzCClHKkNP1yM0uKJ5krRuCd0C8DnGe+yvaeB9AyNcQVj26zwItVTEqRkBummdOSNpyzYGbex0elSdioBBB/IRH9MMEmZn0R/hByw1Ut1B0osa+58xDdSVIYVdV0qPYuU0g1t25jdIoz9e6jlWMjZryBZ5ZQtym1lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yug3i8HJNDmObcyzOPKBM8EbcNPwsD1R9hBaJX6ZwJU=;
 b=bWXEVm/7ZxTtFk3ApRqy72qEjxGS/wglzey9Kuk2+GQp6oP+seuwYtdQlANd+1LahhoadvHMNPi+cWnS9gCH/oa2LjoAC6RgYj5/i8p0pS0ldaviYv8A90Xdbt0pIeejh6YGYEv8G1kkEZAasv3WV1LSp3pSvKLxrtV9u+57N7c=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by MN2PR13MB4120.namprd13.prod.outlook.com (2603:10b6:208:26b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20; Sun, 21 Jul
 2024 16:40:52 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb%6]) with mapi id 15.20.7784.017; Sun, 21 Jul 2024
 16:40:52 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "dan.aloni@vastdata.com" <dan.aloni@vastdata.com>
CC: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>, "blokos@free.fr"
	<blokos@free.fr>
Subject: Re: kernel 6.10
Thread-Topic: kernel 6.10
Thread-Index: AQHa1uRgrsAgQ2eJa0qLuYQQmTl24rH5h2cAgAeGIYCAAF4sAA==
Date: Sun, 21 Jul 2024 16:40:52 +0000
Message-ID: <3bd0bfc1fced855902c8963d03e8041f4452b291.camel@hammerspace.com>
References: <b78c88db-8b3a-4008-94cb-82ae08f0e37b@free.fr>
	 <3feb741cb32edd8c48a458be53d6e3915e6c18ed.camel@hammerspace.com>
	 <zyclq4jtvvtz6vamljvfiw6cgnr763yvycl3ibydybducivhqh@lj2hgweowpsa>
In-Reply-To: <zyclq4jtvvtz6vamljvfiw6cgnr763yvycl3ibydybducivhqh@lj2hgweowpsa>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|MN2PR13MB4120:EE_
x-ms-office365-filtering-correlation-id: 4adf743f-07b8-41e3-97ea-08dca9a3e25a
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|38070700018|41080700001;
x-microsoft-antispam-message-info:
 =?utf-8?B?ekZuZEErZldXT0F3d09qT3dUSjRzSkRIZ0l3RE1oQmR5ZG51UXY1bkZCdFRT?=
 =?utf-8?B?L2RXMFFLZVFNU0g4dENwcTFaUmFDNHAzQTNqeTdZaXZPd09tUzF4b003VnB5?=
 =?utf-8?B?bVRRNmVTL1lRam9HUWdzajQyYjhLaGV6K2R1UDdyMm5FdXBFa01LTERNWUQ4?=
 =?utf-8?B?NTBTZEQyRHh1QkhhTmYyNVBRRlc4VW1DYUY4MWhtNHlXWkxEZlNoamhzK0Zi?=
 =?utf-8?B?RGU0SXlqMGRBeWRzbTY4Rk4zTS9YMWwrKzc0MnhQWng5K1Z2UWZuUFQ5OXUz?=
 =?utf-8?B?Vm93RXlyUkVSTGdDWmw2RHNnbTZaZFFOc005VjB6bDhrTlordHFDWEhwbHNN?=
 =?utf-8?B?Ujl4UVYwVUdJN3NEYlBYNkVlMCtqcG13Zm9hak5nVWdseU5iVFVOY2J5QU14?=
 =?utf-8?B?amZaQTJCRFR0ck42YVEzNTh0U1NqUWx4b3ovR3Zuemx5bkJxMzBmZjc0SVpw?=
 =?utf-8?B?dGNJdUxENk1YMTNYL2ZCamVQdlZqTHVuOS9OMEMvMUQ4eEZLczk2eWtsZFZK?=
 =?utf-8?B?RjVpb0grcU5yMTVOUDl3L1dCd0JoaHdETHVhQVJadUdKK1RFaStob0dvZTg4?=
 =?utf-8?B?aUllYU9oSGp3RDVOdFFXaVJjdjNWcHkycjIxRGoxYXpnclhOcDBOMzBVNm1a?=
 =?utf-8?B?TnVvQXlxVDNEMjh3NnFjcW5tSUk3c3lheTlKdGlzVnU5ZVpabGJMTm1heStK?=
 =?utf-8?B?c1V2cXBPbFhPaU95Y2tCQjBNZ2RIQnM0MnA2N2ZXMUZSVXJScWNuN2QxMFFi?=
 =?utf-8?B?UHE4Mkg2bkNKb3RyK0MrQjB1R2xtYkJsY0RFRitoMHArTzBJSnRCOXhibFBD?=
 =?utf-8?B?Zkp4RXdmQzFVaU1zTHpOYk9ZRk41R1RMSWRCcmZidjdWM1lnOUliRVFvbG8z?=
 =?utf-8?B?OGdGY1VhbkFjcFNwcnRla2UyWXhMRHlCZUlvL1dWbTE3cDhGYW5TZU16d3hm?=
 =?utf-8?B?SzVqaFRnS2YzcXpCQkJXaVJocC9WNzg3ejk3SzhmQ3AvWmRRK3gvSWdESHQ0?=
 =?utf-8?B?eDdwWDQ0OVVrM2xTdFFkLzJiQkUxb3U0QmJHSnlUUVdNTFo2dUFGUEp6Q0xJ?=
 =?utf-8?B?b3NHRjFZS2lWdGhieVZZY0t0WmJWMm1ENWFWNkVnck9oZTQvR2IzL20wZ24v?=
 =?utf-8?B?d0VMSmo3NW5EUXgwWi9TS1N5ZmlMdlEySkZ2bDhKQ29nQ0pqWWNVajFDMEx0?=
 =?utf-8?B?NTVjK3A1cXJIWndLdUkzYWRmcmJHc3FId3htOHJ2WkJFdGN6Ti9XZWtrcUlv?=
 =?utf-8?B?cTBFeGVlOE9mdFBuTXFzaFVQejdtTWFBMXFUOHRNMEJEbkZoa3BCRlN2eThZ?=
 =?utf-8?B?VG9lR01tM2MxNEY4Z01tR1dxMG9HcHVYWHh3QXM5TkIzcGg5TTJ0QzVCVmdJ?=
 =?utf-8?B?UzBwbVRQVjJkT1BMNWp6ZlEwZHVWOWlJcXBLVWJQRHEveTRyMGQ1dFhHQjVG?=
 =?utf-8?B?OG9CVjAyOEhmZk1kNFZZMXJpMWRWTThUcEpmNE8yQjJodUJ2dktVQ0x3a0Zo?=
 =?utf-8?B?U0diT3NhcU9ldDhEYThsdVBsYXJlS0RNVHViak9sYWZHbnVlaXhTMVl2WXVL?=
 =?utf-8?B?QVg4aytQM2FEcy9ocHhOQmU1Q2VYcTQvS1NIMzZLTFN4cWdKaldaNWFnOW1M?=
 =?utf-8?B?RjB1NXhZZkhqNGJLc2RFcTJpakVIYXpncHZ5eS8wU3FaODU1ek9PMmFSYkVP?=
 =?utf-8?B?RTN3ZGwwRmx0ZjVBWC9BVjc5ZS9XZGhRUnJ0RDFrS0cwVFVjS1VhSG4rS2w3?=
 =?utf-8?B?NWNsdXJuczFKYjhrTzB6bmdlUzNCRk5UZGM1dXhFc2djTG5GdlQ1SVZFVktB?=
 =?utf-8?B?Z1BmK1FQb0ErcTFtVGwwaS80NmZUL1cyelpveXljRWxiT0RIWnNTQ0kvSG01?=
 =?utf-8?B?eUVmdWowQlU4dlkxOFNGeDhTRG5MS210VzlPbUR2Uk41NVRWUklMU1lzV2Jx?=
 =?utf-8?Q?vLjtyT7Lt/21aZph8esmBFfzkj+FGiZ6?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(41080700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bERPYk53YzVkOFJVenRpSDhNZ3R4YWRhbVlLRWNJNlpLWnlpOVF4enYvdzNp?=
 =?utf-8?B?UUlwcmxnVjQ3TmJ4ZjBxb2lSTjRnTHhNYWtIT2tIeWpQL0VOUUpjRDgrTWFo?=
 =?utf-8?B?eC9QQ1BXdURxUHJHRk1Udy9NVlg1YXZzeSttSG9aYXh4Sm9aWlFZQkdmdWhs?=
 =?utf-8?B?eDB6YTI4cmRKZ1llbVdKRkRqd1MyY1VTeDdhUERrWkxjaDllSjk2ODRhc0hV?=
 =?utf-8?B?b0RRNndlMlZQdUVrajczT1hZU2hIZkhiYU1wc0w4ejhBUjBsb3hhSFpFRjNo?=
 =?utf-8?B?MktoenhiT0tWOWtWWmJvS0xoaTRTTlhlQ2NocTRmNXJQVkJYV2tMQWFtbjQz?=
 =?utf-8?B?d0kwWGdBQitSWVRvTTRUM0tnUnhSdDJQdm5uYVZWbjVuMHhyZWZTL2RpeVE1?=
 =?utf-8?B?em93MTc0cjZMRk5hSGRxbXl2QzhNdFRSTFYvWlpmTnVOOUt3SEExWWxFTnBs?=
 =?utf-8?B?OEhiUXhZVUZkWUVVdnVWYXg3ODVHWG9kcThTNTNWeTlTQUhVRjhmRnBWRnRH?=
 =?utf-8?B?ck1OeDV3RkljUEpXcFhpV0p6amVBY3J2Y2JxRnhVbzN5ZjRzb1FkcTJ0UExi?=
 =?utf-8?B?a3kxa0FMUnZ3aFdZUFBDYllxWlc5enNIL3V6eWwwVW5IejJieUFhRStsYUZ1?=
 =?utf-8?B?Y2hrOWZoc24yUUxCVEswM2lYeGs1N2o0L2xnR0ZQVUc3NzluZWZZd2t1S3dC?=
 =?utf-8?B?ZUZKNEp6RmNxd1FaOW1heXJQM2hwWnE2RHoxYVdteDFtN0dtT1lOdG9ON2hT?=
 =?utf-8?B?djVKZnl4YjVIWStlUkVQVlFHWnN4VU1SeWQ3Rm45SXdjVE12ODVsbHRuMEU3?=
 =?utf-8?B?NWxBdVVuRHJuV0NNMDVtVHNUVW10UTQwbTFNZ20vb2lmMHliWFEvZHZRNktJ?=
 =?utf-8?B?U2hLb1VqMVdLV3ZPUnI3dWxiVjJPeHA4a2s1VTIweW82cTJuakZ2VE4zY3B4?=
 =?utf-8?B?cjhCRWd6YUF3VWdpaHljR0o4RzFNQ0JSVEdBSjlVWlNYZ3c4MmpZZHB6UlBy?=
 =?utf-8?B?UDRERmdwR2x2UEtyM2l2aG51b0d1VmlxOHk4ME03cTR4MG85QVJIWWpDMm8r?=
 =?utf-8?B?ZXE5ZTBZdE85bncxU1J1aTNVSWYzcTA2WnExMlhVRmZubnhwRnBtd0MxWjk4?=
 =?utf-8?B?cDhaeUhVNFhTRm80Y2lTbHRhK3R4Tm5peDcya25ISk00Q08zQ1pieHk5VGtv?=
 =?utf-8?B?SWl0M2pqWEY3SmVLdGpudzBpeUcrNlN0cmxtY2ZvOCt5bzdCWlZqNGlzV1BI?=
 =?utf-8?B?cGIxTHlwM0ZlYUY1TlRFaVQySW5vbmxHaUxuaWFXUDZmenNaODF1VnBPeEI3?=
 =?utf-8?B?Y1BMT2JmUlltZXQzSm9OWXNnYmpDdTVHYUZWUjUxc0ZFUElveDd4Tm5oZFRz?=
 =?utf-8?B?L3lrT3pZQ0V5Y3JuSGpmV0dhRGw5SGt0VEJ1dC84UGtwcXhiUlRRbW5KOHZu?=
 =?utf-8?B?b2p5dWZWRk93M2x2M2p1U2Vmck04TGJ4RlE5T2F6TlRtZWxKbmoyY2VaTENQ?=
 =?utf-8?B?RHNUZ3lYT0wya2l3VEVmTVZOZldiMktsZVBScGFxY29yTmJSQVNvd2I4REU4?=
 =?utf-8?B?WVVuMjZRQmttbHMxbWtIMzRxa0o5WmU4d3dLSU5oWlp1b3BuQ1dlS2FVODBW?=
 =?utf-8?B?QThOemh0N2hia1F5LzExS2FCVG9JdTQxN3Rhb05YUTJJbS9HTy90bzg2NjMz?=
 =?utf-8?B?eE4yUVpROGQvLzFvQ3I1SHlqSi9maWxUUFZNY0N4MGZuRzd6NTRZZEIrUkow?=
 =?utf-8?B?eE1CeFZxMGowdUpSMkJCSDgrbnNMa21YajllYmEzeGJYanRyMTJEQmcwcEIy?=
 =?utf-8?B?aUlqRWgwMVdJaGY2ekgzTGd1YVRlRWZpUER3R3JaRWlHWHdLL3p2cEsyV3ZG?=
 =?utf-8?B?aE1iejdIWHFqVjE1RlBKWk03VGZKbFBVNjBkMmo0endtcm96QnBPWUM4Y0x5?=
 =?utf-8?B?OWNGMkVuTjc4VTdNcnh3emZhVFEvYk9LNG02UUprTzUxaDNIbnV6VDhvMERX?=
 =?utf-8?B?V2paYTRYc0dpOUgzaDRyNlVHbFVpSUFSSzVKbmZtbmdyM1VVTVBvVGFXRm9q?=
 =?utf-8?B?QzAvcDl3Z1pjS0tqZlFKclltRUdTT2NpUHhKS0c1U2J2WFJod0JCMUl3cng4?=
 =?utf-8?B?ZzZhRGxqeFRGVy96UGQzazNqTC9mYlF1UXJ4WUI4OWk1VysveUtDekhkdTdx?=
 =?utf-8?B?Wnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <276E1F8D5EF4284C8543EE54E9CBEBC9@namprd13.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4adf743f-07b8-41e3-97ea-08dca9a3e25a
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2024 16:40:52.1814
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bdaVwHh8Sq5DLphprAsZh0ALs0jXEyOjCoJCuKqo2DIHMweMpfEtDSP9VvRO/nMVQ8r6kLdtXWLSB6CQajVNzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB4120

T24gU3VuLCAyMDI0LTA3LTIxIGF0IDE0OjAzICswMzAwLCBEYW4gQWxvbmkgd3JvdGU6DQo+IE9u
IDIwMjQtMDctMTYgMTY6MDk6NTQsIFRyb25kIE15a2xlYnVzdCB3cm90ZToNCj4gPiBbLi5dDQo+
ID4gCWdkYiAtYmF0Y2ggLXF1aWV0IC1leCAnbGlzdA0KPiA+ICoobmZzX2ZvbGlvX2ZpbmRfcHJp
dmF0ZV9yZXF1ZXN0KzB4M2MpJyAtZXggcXVpdCBuZnMua28NCj4gPiANCj4gPiANCj4gPiBJIHN1
c3BlY3QgdGhpcyB3aWxsIHNob3cgdGhhdCB0aGUgcHJvYmxlbSBpcyBvY2N1cnJpbmcgaW5zaWRl
IHRoZQ0KPiA+IGZ1bmN0aW9uIGZvbGlvX2dldF9wcml2YXRlKCksIGJ1dCBJJ2QgbGlrZSB0byBi
ZSBzdXJlIHRoYXQgaXMgdGhlDQo+ID4gY2FzZS4NCj4gDQo+IEkgd291bGQgc3VzcGVjdCB0aGF0
IGAtPnByaXZhdGVfZGF0YWAgZ2V0cyBjb3JydXB0ZWQgc29tZWhvdy4gTWF5YmUNCj4gdGhlIGZv
bGlvX3Rlc3RfcHJpdmF0ZSgpIGNhbGwgbmVlZHMgdG8gYmUgcHJvdGVjdGVkIGJ5IGVpdGhlciB0
aGUNCj4gJm1hcHBpbmctPmlfcHJpdmF0ZV9sb2NrLCBvciBmb2xpbyBsb2NrPw0KPiANCg0KSWYg
dGhlIHByb2JsZW0gaXMgaW5kZWVkIGhhcHBlbmluZyBpbiAiZm9saW9fZ2V0X3ByaXZhdGUoKSIs
IHRoZW4gdGhlDQpkZXJlZmVyZW5jZWQgYWRkcmVzcyB2YWx1ZSBvZiAwMDAwMDAwMDAwMDAwM2E2
IHdvdWxkIHNlZW0gdG8gaW5kaWNhdGUNCnRoYXQgdGhlIHBvaW50ZXIgdmFsdWUgb2YgJ2ZvbGlv
JyBpdHNlbGYgaXMgc2NyZXdlZCB1cCwgZG9lc24ndCBpdD8NCg0KU2luY2UgdGhlIHZhbHVlIG9m
ICdmb2xpbycgaXMgYmVpbmcgcGFzc2VkIGRpcmVjdGx5IGZyb20NCndyaXRlX2NhY2hlX3BhZ2Vz
KCkgYXMgYW4gYXJndW1lbnQgdG8gYWxsIHRoZSBzdWJzZXF1ZW50IGZ1bmN0aW9ucyBpbg0KdGhl
IHN0YWNrIHRyYWNlLCB0aGVuIEknbSBzb21ld2hhdCBjb25mdXNlZC4NCg0KLS0gDQpUcm9uZCBN
eWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25k
Lm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=

