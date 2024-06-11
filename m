Return-Path: <linux-nfs+bounces-3641-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DB2D902DB7
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Jun 2024 02:34:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7F0D1C20F32
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Jun 2024 00:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9D69F9CB;
	Tue, 11 Jun 2024 00:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="LecqW/If"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2106.outbound.protection.outlook.com [40.107.102.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A45EAC6
	for <linux-nfs@vger.kernel.org>; Tue, 11 Jun 2024 00:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718066064; cv=fail; b=Fq5ubiZZTVEe84tjIPhNrcwPzagEMFMyqjwzy0DVuWoHKl13sjef345FhHIlGAHp3klj+kJEJm29FN2+g/+M4XYHi6owjrWFwLADKVYVKpqxtwcJw/X7ZHCDAYb2H9NljWp7bP9OtOIB4Ve2OVdPA7Iu6V9NKMrGgnQN9FFiYo0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718066064; c=relaxed/simple;
	bh=p3VTNOlewSY0ERZugcWiAQn7PxwUb3NCY52CZxxbvk0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TbHCKwxymcFsVhpVeCesitxRCmTvDQVDU4dCN579CmYDYpig0zSQuzHuU1RxzFkn3uXuaL4kZvZXsLGoVYgPCS8TXFbv3iS2lKyE5beuN/hpxyiJaOKTJPtJM1027REbyZWgAwRM3ap+KkhkM77FCWUigJAy6Rzmw51dEewWF4c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=LecqW/If; arc=fail smtp.client-ip=40.107.102.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L3uFWb40xW3Wu50U9/qzY21LUgRqfNmsv3qo7M5QBewqsaMVprFb/AQH3iGtxTzSQsfG7siOUHDnT2QezUKFBLX5Gk+6MhyNBi13qWUscdHv3Kpfr+SOuoQhNC4gVHNnLvZ+L0THUKn20AAsl6aeGvv7B4Upxr4Mz54wiZezg37f+hk1NxtwUPTRBynDkV2/RoeeXc5nmnejAJotSPJ3EE30Mr3xlEbF68NtTeb67/uU+blsYUW3Ky8Pyj4DD73xu/N/rnFyrbyLtzDoIuVCbG/rnLwzJvFWjBuTzAVFoG2Q2iumi+vXMKBTWwQzcL1UmjSyRdfYRgxjejVqdlMcKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p3VTNOlewSY0ERZugcWiAQn7PxwUb3NCY52CZxxbvk0=;
 b=CwnN76yaVKPLrQoBajToLyCQQaPLfQyFO6xlTv2z89poDNy2KCls5d/rcVe2AzSg52MFWVny2HEQ5Dd6KZXoLwo1eGPp6GLmhIvXSEtA/i4LkR18a0ph7tPlEZnvt7AWtj1e5g/xCiXhKMGz+jT8xz5xc8YIzGe6v7WUyTV4UAFGqknDq9U1epzNPe55IdaPRYiRpGn5OMT5Tft/jrUMihwfC64ebdHwVQVP56GooJjhgTjo/cjhqqwVa+tc0JW17lvVPujPh6F3GcP+wQNniLpsaRh+3kC4hvuX+QbOfUL3vYxV439vvXRkBTc0NEadghuSSAmYtMU29AglD7MiLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p3VTNOlewSY0ERZugcWiAQn7PxwUb3NCY52CZxxbvk0=;
 b=LecqW/IfvVzlETNmjFYYrdfPbsMnbO7YaHm8BrnuVdhY6ZnAzo5O/73M3Dqvd4mNO8VZ0bvPvAtOHvQF/lBgL4mar3qalAH2jQwhNW1r+W3tbDWOwsZ88pIIEnSgIoBScNhNN+rU6fMPRIYsBAH9zc4DVvKAA3trUjoyXz0IV/0=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by SJ0PR13MB5692.namprd13.prod.outlook.com (2603:10b6:a03:407::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.17; Tue, 11 Jun
 2024 00:34:19 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb%6]) with mapi id 15.20.7677.014; Tue, 11 Jun 2024
 00:34:19 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "chuck.lever@oracle.com" <chuck.lever@oracle.com>
CC: "hch@lst.de" <hch@lst.de>, "cel@kernel.org" <cel@kernel.org>,
	"tom@talpey.com" <tom@talpey.com>, "kolga@netapp.com" <kolga@netapp.com>,
	"dai.ngo@oracle.com" <dai.ngo@oracle.com>, "linux-nfs@vger.kernel.org"
	<linux-nfs@vger.kernel.org>, "neilb@suse.de" <neilb@suse.de>,
	"jlayton@kernel.org" <jlayton@kernel.org>
Subject: Re: [RFC PATCH] NFSD: Support write delegations for pNFS LAYOUT
 operations
Thread-Topic: [RFC PATCH] NFSD: Support write delegations for pNFS LAYOUT
 operations
Thread-Index: AQHau0eXWuSoQ4zLOEupu2fJidW957HBLfMAgAAW+ACAAGedgIAACxkA
Date: Tue, 11 Jun 2024 00:34:19 +0000
Message-ID: <c8dc18e08dab441b695cc74b231d94bfec9c1288.camel@hammerspace.com>
References: <20240610150448.2377-2-cel@kernel.org>
	 <30924327aaee17182a83e18bc86e6a27a19d88ab.camel@hammerspace.com>
	 <Zmc7UOSMmeGcqkBa@tissot.1015granger.net>
	 <0f25c54fde0089aa642de9e34fed0814dac8da17.camel@hammerspace.com>
In-Reply-To: <0f25c54fde0089aa642de9e34fed0814dac8da17.camel@hammerspace.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|SJ0PR13MB5692:EE_
x-ms-office365-filtering-correlation-id: adba8c36-efbb-44ef-9f06-08dc89ae3b7d
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?V25wLzFFU2pyL0VMTFUyUzQzdFAwOEI0Ny9Rb0lRRjZoTkNTTytFblRlR1U5?=
 =?utf-8?B?bElhNk5wZHBpTHFuNEJyUzFnZ3dmVDcvd21zUWtKckNVVjNPbUVBcE5pUkhw?=
 =?utf-8?B?QmgvOHQraXlaVERNV1IwZ25URk5hVW5vWmIzNjlLVDgwVnpXZmU5cXdQQ25n?=
 =?utf-8?B?RkdNMlgxdUoxM3l4bEgwWnRsVVVWUEw5VE8rL0hJcEhVNlRGT0FrSGxXbmNH?=
 =?utf-8?B?MXBnSnJTVmd5bXB4aGEzSURrUTU4MW5NaktWUU5rODVwNmlrUSt1NnpoNTVD?=
 =?utf-8?B?eEQxcHNTcGNybDZtTTg4cldhVXVERmQ1bnZBbm1WZjhqcythdEllTlFYckIv?=
 =?utf-8?B?Y29DNmc4bUpmWHdzUWdhQWZZTHVNM1RPZVZGRGVyWjgzRGVlUFZXaFhUM0o0?=
 =?utf-8?B?U0dyYUhkaldFN09jVnUrMDU5MVB3WjdTQldqbTNVdDJQNnhOdlQrWHlQa0Uz?=
 =?utf-8?B?ek9Hc3RWVTNZc01nZm4reG9aeEFlZ2lRRDBTeDlIZmt3N0RmbWNha25wTm41?=
 =?utf-8?B?ZWxXeHRPbnVOcEVHNjVBcUhtZDJnSXF4cGFrNHd0YmJEZ00vV1I0aGpQR1ND?=
 =?utf-8?B?RkJzOHNYTDU5YVpCcklTVXYvOXlPL0hYelpkdS9TdFp0MVJJdlJ5VzB5MEwz?=
 =?utf-8?B?dm1ES1RmcktONzJKcGFha3JhRHZWQkJzbHRsclZFT3NldEhjUlU0L1BJaUxk?=
 =?utf-8?B?Ym1HY1Axa2RNK3RuNVdJRmFwNjRzVVBKRVRjMWJPaGV3TXJ1ejhiRUxjaUQw?=
 =?utf-8?B?MFRLa2x0KzNqNGhTSndmVG9VSEtwbzg1M3FidW1hSU1MZnVOZDhnYzZBblVH?=
 =?utf-8?B?VGc0UytPNCtNSnFHcXZnOUFkUTBhN210dlpQc2YxUG81YjZQMGdJeXcrQjBH?=
 =?utf-8?B?UHNTQ3JWYjJwdXU1SG1pL2QxQjYyaVYyeEEybWd1eTZlbTZTRzZqWDJ0RWxE?=
 =?utf-8?B?eHpMcS91bUVONVNUQnlweUl4Y1ZIQllQOWtOMUQ5d1JqUS83YjM2dXdSRFRE?=
 =?utf-8?B?bFg5MVNOZlVWMm5DRVA5TGdHWHRaRVdjSjFKR1ZaSkkyblkwL01PbkY3V2l0?=
 =?utf-8?B?c09iSXc0ZVA1WmNKeXM4R2VVcFgyZGw3UG9vYStFTVR2d1JLaU9KZHdkTUg3?=
 =?utf-8?B?c2ZiSTN5OTdtaWJzVmluVnZpQmgvVTd2N2tPOGtrSVo2cmozSm84U1ljWFJx?=
 =?utf-8?B?M0lrL2dmc0V3NUFKYy9leEV5S2wvWDRuTWIrUFdaRVplV3JQTlY5cmVIQndX?=
 =?utf-8?B?YlFPNUtnRmoyUVk3cXg1akZXK1RsKzZEakF0YVEya3d4YTNTUE5OMTRiRkt5?=
 =?utf-8?B?ZmZqUEVpVlI0T25tTTNqZTFJSXJJUThicklwOGd3dmhqZ01sb1I2SnE5UDlX?=
 =?utf-8?B?VFo5b28rYTlSb2xSdERLeEcyd2RBYmJ4MnNqdGNIWXdNc2J4cXVPZlRlbysx?=
 =?utf-8?B?UnFEQ0Eva3dtVXVST3VTYk5oRkFaZEZIZUU1cFBjaHh6Wk1qaWU0bW05N3JG?=
 =?utf-8?B?WGFjSVA5YVJ4ZHd0WkZQRDVYRnZHdkovNlZZMjJlMkZOVTBIbUNISDdSMUwx?=
 =?utf-8?B?amhScEZvcERMVFdNWDR5OEJqSGlQVUh2bEpkR2p2RUdJMjdyYWllV3ZuaU8w?=
 =?utf-8?B?Q2c0ZHpzRFF2MG41SStRVXNwcEVUT0hZWEdYRENvU1V1K051MTlSQm9HaXJW?=
 =?utf-8?B?YzVlTnloaDZsUnZ3UVgxcTl5aUJ2OHNZQTgyaUJlbkhnZVlzRjlhRy9vS3J5?=
 =?utf-8?B?WlFhUVRDK1kvZTY0dy9mSDdNazd5RTdOYXBjQm0rMkZ0Z3FvanNqVEJyamNY?=
 =?utf-8?Q?ejqL/HkO1ae8XPlzIpP1nJtTZKeW+6T5WvJdA=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MWZ5a2VqZVNUUXoxQ3BOa3UrR2hSTlJIZGF4QkxOWkxzK3dMandKcythWTF2?=
 =?utf-8?B?UytMdmpZcHgzK3BhZGRJUHFKOFBkUXN1c1VWdUxUelNwTm83QUlYQXZodmZp?=
 =?utf-8?B?eUFYMU85d09BcXp6U1FuZzFaa3VMbWVmS3pETktIOFFZOFRHTlZYR1BOUnUw?=
 =?utf-8?B?L0dDUDVMMWx2SGhNRjRmVWhSUlQwclBRSEE1bHlSSzZjcy9ZN0phRWZreXFS?=
 =?utf-8?B?MUVsUUdibjMya0llVnhWSy80QTlzYi9CRDRLR1QzZWl4TFpUOHdJQlpBcVJz?=
 =?utf-8?B?TDVrcmtKMHZFM2NZalcwckR6dUE5dmRyK2MvRlZuNTJ2UVM1TEkrTXZNelhY?=
 =?utf-8?B?V1N5VXZWekdQQWkvRC9wV1JzLzhPK2JIOG1Idjg3MU1mdGk2c3A1aG94bDJO?=
 =?utf-8?B?MEt4T0hoN1JzL0tQZjc4NktiNWdrVG9LSGtHaEJLQVhWVUErSmFUKzBITUFO?=
 =?utf-8?B?UUN5QlQ5SHVNbUJZQ2xMVnhQcUVMUzY4WXB1WWhMQXBxYVFucUFNQWlyN3pw?=
 =?utf-8?B?N1ZFVGR4enZic3VLNGEzZnZybk05UzhRQllaeFM2UlJMam93dWVPSEJwbTBl?=
 =?utf-8?B?OTV4eXJ1V1NqM242U1hONHNFbUs1cy9TVnBCcTB3M1VxU1hON29EWlQyQXBl?=
 =?utf-8?B?UjlRK01VcHNaaG9vSWpRUnR2YVA0Si9nUTA2YTFNTmZIMkRrK2FBd055SmUz?=
 =?utf-8?B?VG9aeUdQcUc2cTcwK21LWUo4TVRFSE0wWU9qczZxSVFXNEdBUEVCTWcyZC9r?=
 =?utf-8?B?K3JaNjg1Y0tTVy9BZ0dHUytnejdCSEVLaG12V0I5djhkRXJPQVpuZmFJSjV4?=
 =?utf-8?B?OEhnQlk0NUhNdk5FZEZDS0dtcm9LbHVpWk5UbWJrTnY4ZXZjNy9JUUcyMjZw?=
 =?utf-8?B?QTE2SEZxdWJ2Mm9hay9WVnNIUzZ5OEo2Zmh1cStMK0x0WWhuME9qUlJaRkw0?=
 =?utf-8?B?QWd3dkxhd1BwY1RuU3RkQzkrRm9RNkVhbktjZGxUYzYxRkMyN3JTUWIyOUEv?=
 =?utf-8?B?bGgyU0dua1R5M0RyS2dKZTZIbHZlSWd4d2pmVnhpR3ZhNjJ4NXB5Q1M3S3hF?=
 =?utf-8?B?cUd2MW5rRUJvb0EvOFpoQmh2YjhWTnBpbGE0dU1hTlhubXFiQW5Ga1lNR3pH?=
 =?utf-8?B?M2pxem1paUo2MDZBVkZyK1llbHBRT0xmbW51ZmorWUhBblBHVVIvcllzOE9N?=
 =?utf-8?B?TWd4djM2OG5La1Z1bFZlL3B2TW5Kc0dleHhtTU5oYzM3U2ZmdVB0Um02cTZ4?=
 =?utf-8?B?bVd5NGJjRVFLT09LWkV3ZTQ5dXZVamtEZGF2eFFZZi80MjJWTzNBRzdpcmgx?=
 =?utf-8?B?Y3cySjNxYXZtYjBYWDJ1YmhXTEhtSVFNSE8yRG1kWVc0cFJrUTkxdDNZSEFR?=
 =?utf-8?B?Y3k0blNxUnZudHJBWDRVSzhOcjY1VXZZd3JXdHBKMzZjYkw0N2l4dTBXUW8y?=
 =?utf-8?B?dGtidzlzYXpQek5WL1BmRVJ2bFpTL1BQOEYvVDduaEc0aHFZTnZZNEFvemQr?=
 =?utf-8?B?UFdOdVdBWTV2M05ZN0RiQ3ZOeStCZGM4QTJyek1lc0ZRRlg5WitmVHJFRVdU?=
 =?utf-8?B?RXRHaG1pdFFiTndsZ0orc0t6OGJxODhFNXhTUDFFL2pTN3BmN0tybUNDMnIz?=
 =?utf-8?B?WnhkN2FuVTlMOGxLTVc3SnpudWR0cmFNZ05HcTdUMDQxOW1QVGZ1dmJScjZO?=
 =?utf-8?B?cFBNU2YvTmFHL3Z1ZS9lRHUzQmRpN0JLb3lNWkJ2NEd0NDJ0b0JTaVNjN3Aw?=
 =?utf-8?B?bllVY1QxSmpLQVE3ZzZqTFN5RFFqYWFxM1MxbDQ5UFRpOVcwdm9NSjVTeEdD?=
 =?utf-8?B?QTJLbFB4K1ZUUHpXZnRzczAxRm90UEJKMk8xTVRMek5FMWhSY0t0SVRHcG5F?=
 =?utf-8?B?MUZteU9qVWFOOEkxN0w1T0RnVWhENHI0VXJJUEUyNXR6VnltSmI5MEFYZWdP?=
 =?utf-8?B?aEVtbHRmR1BaRTFvUGNJM0NQZkQyL2piNlV5MUNUTzRiUlpNT25XdFVNS0gy?=
 =?utf-8?B?WlFtY2ZiMk5HeU9kdXVVUTdKaU92dmkxQ05HSnlnVm1vTHNpV0orY3VuUk1O?=
 =?utf-8?B?VUtRcms1UWc3RXRNd2FaTmgzb2gvbGVJaG55TGhic25qdHJaRlZmNkdud1hL?=
 =?utf-8?B?bHphcFNPSEdhUW4vK05iNXRLWGhUN2d3Z09haGs0cDRpZjRuTHhuejVYR3pV?=
 =?utf-8?B?dVJmbEVhMnJ0VzF5R29ESkNNa0FEQjFFN2IyV3I1SDFGK1hjcHdzUS92cjUz?=
 =?utf-8?B?ekREN2lCOXo3Zm02RXhmZ1FBSHdRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <792298972479A44B807DFCE3D6A6A4CD@namprd13.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: adba8c36-efbb-44ef-9f06-08dc89ae3b7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2024 00:34:19.4835
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZsKa44EhSACF+KBTQaoMuEgRdHxk99ZsSNcipR6PYnf6TvVKTswg+GpaXVgTGEvgBGePDIhW70rZ1+CF/QyNUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR13MB5692

T24gTW9uLCAyMDI0LTA2LTEwIGF0IDIzOjU0ICswMDAwLCBUcm9uZCBNeWtsZWJ1c3Qgd3JvdGU6
DQo+IE9uIE1vbiwgMjAyNC0wNi0xMCBhdCAxMzo0MyAtMDQwMCwgQ2h1Y2sgTGV2ZXIgd3JvdGU6
DQo+ID4gT24gTW9uLCBKdW4gMTAsIDIwMjQgYXQgMDQ6MjE6MzNQTSArMDAwMCwgVHJvbmQgTXlr
bGVidXN0IHdyb3RlOg0KPiA+ID4gT24gTW9uLCAyMDI0LTA2LTEwIGF0IDExOjA0IC0wNDAwLCBj
ZWxAa2VybmVsLm9yZ8Kgd3JvdGU6DQo+ID4gPiA+IEZyb206IENodWNrIExldmVyIDxjaHVjay5s
ZXZlckBvcmFjbGUuY29tPg0KPiA+ID4gPiANCj4gPiA+ID4gSSBub3RpY2VkIExBWU9VVEdFVChM
QVlPVVRJT01PREU0X1JXKSByZXR1cm5pbmcgTkZTNEVSUl9BQ0NFU1MNCj4gPiA+ID4gdW5leHBl
Y3RlZGx5LiBUaGUgTkZTIGNsaWVudCBoYWQgY3JlYXRlZCBhIGZpbGUgd2l0aCBtb2RlIDA0NDQs
DQo+ID4gPiA+IGFuZA0KPiA+ID4gPiB0aGUgc2VydmVyIGhhZCByZXR1cm5lZCBhIHdyaXRlIGRl
bGVnYXRpb24gb24gdGhlIE9QRU4oQ1JFQVRFKS4NCj4gPiA+ID4gVGhlDQo+ID4gPiA+IGNsaWVu
dCB3YXMgcmVxdWVzdGluZyBhIFJXIGxheW91dCB1c2luZyB0aGUgd3JpdGUgZGVsZWdhdGlvbg0K
PiA+ID4gPiBzdGF0ZWlkDQo+ID4gPiA+IHNvIHRoYXQgaXQgY291bGQgZmx1c2ggZmlsZSBtb2Rp
ZmljYXRpb25zLg0KPiA+ID4gPiANCj4gPiA+ID4gVGhpcyBjbGllbnQgYmVoYXZpb3Igd2FzIHBl
cm1pdHRlZCBmb3IgTkZTdjQuMSB3aXRob3V0IHBORlMsIHNvDQo+ID4gPiA+IEkNCj4gPiA+ID4g
YmVnYW4gbG9va2luZyBhdCBORlNEJ3MgaW1wbGVtZW50YXRpb24gb2YgTEFZT1VUR0VULg0KPiA+
ID4gPiANCj4gPiA+ID4gVGhlIGZhaWx1cmUgd2FzIGJlY2F1c2UgZmhfdmVyaWZ5KCkgd2FzIGRv
aW5nIGEgcGVybWlzc2lvbg0KPiA+ID4gPiBjaGVjaw0KPiA+ID4gPiBhcw0KPiA+ID4gPiBwYXJ0
IG9mIHZlcmlmeWluZyB0aGUgRkguIEl0IHVzZXMgdGhlIGxvZ2FfaW9tb2RlIHZhbHVlIHRvDQo+
ID4gPiA+IHNwZWNpZnkNCj4gPiA+ID4gdGhlIEBhY2Ntb2RlIGFyZ3VtZW50LiBmaF92ZXJpZnko
TUFZX1dSSVRFKSBvbiBhIGZpbGUgd2hvc2UNCj4gPiA+ID4gbW9kZQ0KPiA+ID4gPiBpcw0KPiA+
ID4gPiAwNDQ0IGZhaWxzIHdpdGggLUVBQ0NFUy4NCj4gPiA+ID4gDQo+ID4gPiA+IFJGQyA4ODgx
IFNlY3Rpb24gMTguNDMuMyBzdGF0ZXM6DQo+ID4gPiA+ID4gVGhlIHVzZSBvZiB0aGUgbG9nYV9p
b21vZGUgZmllbGQgZGVwZW5kcyB1cG9uIHRoZSBsYXlvdXQNCj4gPiA+ID4gPiB0eXBlLA0KPiA+
ID4gPiA+IGJ1dA0KPiA+ID4gPiA+IHNob3VsZCByZWZsZWN0IHRoZSBjbGllbnQncyBkYXRhIGFj
Y2VzcyBpbnRlbnQuDQo+ID4gPiA+IA0KPiA+ID4gPiBGdXJ0aGVyIGRpc2N1c3Npb24gb2YgaW9t
b2RlIHZhbHVlcyBmb2N1c2VzIG9uIGhvdyB0aGUgc2VydmVyDQo+ID4gPiA+IGlzDQo+ID4gPiA+
IHBlcm1pdHRlZCB0byBjaGFuZ2UgcmV0dXJuZWQgdGhlIGlvbW9kZSB3aGVuIGNvYWxlc2NpbmcN
Cj4gPiA+ID4gbGF5b3V0cy4NCj4gPiA+ID4gSXQgc2F5cyBub3RoaW5nIGFib3V0IG1hbmRhdGlu
ZyB0aGUgZGVuaWFsIG9mIExBWU9VVEdFVA0KPiA+ID4gPiByZXF1ZXN0cw0KPiA+ID4gPiBkdWUg
dG8gZmlsZSBwZXJtaXNzaW9uIHNldHRpbmdzLg0KPiA+ID4gPiANCj4gPiA+ID4gQXBwcm9wcmlh
dGUgcGVybWlzc2lvbiBjaGVja2luZyBpcyBkb25lIHdoZW4gdGhlIGNsaWVudA0KPiA+ID4gPiBh
Y3F1aXJlcw0KPiA+ID4gPiB0aGUNCj4gPiA+ID4gc3RhdGVpZCB1c2VkIGluIHRoZSBMQVlPVVRH
RVQgb3BlcmF0aW9uLCBzbyByZW1vdmUgdGhlDQo+ID4gPiA+IHBlcm1pc3Npb24NCj4gPiA+ID4g
Y2hlY2sgZnJvbSBMQVlPVVRHRVQgYW5kIExBWU9VVENPTU1JVCwgYW5kIHJlbHkgb24gbGF5b3V0
DQo+ID4gPiA+IHN0YXRlaWQNCj4gPiA+ID4gY2hlY2tpbmcgaW5zdGVhZC4NCj4gPiA+IA0KPiA+
ID4gSG1tLi4uIEknbSBub3Qgc2VlaW5nIGFueSBjaGVja2luZyBvciBlbmZvcmNlbWVudCBvZiB0
aGUNCj4gPiA+IEVYQ0hHSUQ0X0ZMQUdfQklORF9QUklOQ19TVEFURUlEIGZsYWcgaW4ga25mc2Qu
DQo+ID4gDQo+ID4gSSBhcHByZWNpYXRlIHlvdXIgcmV2aWV3IQ0KPiA+IA0KPiA+IEkgc2VlIHRo
YXQgQklORF9QUklOQ19TVEFURUlEIGlzIG5vdCBzZXQgYnkgTkZTRC4gUkZDIDg4ODEgU2VjdGlv
bg0KPiA+IDE4LjE2LjQgc2F5czoNCj4gPiA+IE5vdGUgdGhhdCBpZiB0aGUgY2xpZW50IElEIHdh
cyBub3QgY3JlYXRlZCB3aXRoIHRoZQ0KPiA+ID4gRVhDSEdJRDRfRkxBR19CSU5EX1BSSU5DX1NU
QVRFSUQgY2FwYWJpbGl0eSBzZXQgaW4gdGhlIHJlcGx5IHRvDQo+ID4gPiBFWENIQU5HRV9JRCwg
dGhlbiB0aGUgc2VydmVyIE1VU1QgTk9UIGltcG9zZSBhbnkgcmVxdWlyZW1lbnQgdGhhdA0KPiA+
ID4gUkVBRHMgYW5kIFdSSVRFcyBzZW50IGZvciBhbiBvcGVuIGZpbGUgaGF2ZSB0aGUgc2FtZSBj
cmVkZW50aWFscw0KPiA+ID4gYXMgdGhlIE9QRU4gaXRzZWxmLCBhbmQgdGhlIHNlcnZlciBpcyBS
RVFVSVJFRCB0byBwZXJmb3JtIGFjY2Vzcw0KPiA+ID4gY2hlY2tpbmcgb24gdGhlIFJFQURzIGFu
ZCBXUklURXMgdGhlbXNlbHZlcy4NCj4gPiANCj4gPiANCj4gPiBUcm9uZDoNCj4gPiA+IERvZXNu
J3QgdGhhdCBtZWFuIHRoYXQNCj4gPiA+IFJFQUQgYW5kIFdSSVRFIGFyZSByZXF1aXJlZCB0byBj
aGVjayBhY2Nlc3MgcGVybWlzc2lvbnMsIGFzIHBlcg0KPiA+ID4gUkZDODg4MSwgc2VjdGlvbiAx
My45LjIuMz8NCj4gPiANCj4gPiBFdmVyeSBORlN2NCBSRUFEIGFuZCBXUklURSBjYWxscyBuZnM0
X3ByZXByb2Nlc3Nfc3RhdGVpZF9vcCgpLCBhbmQNCj4gPiBuZnM0X3ByZXByb2Nlc3Nfc3RhdGVp
ZF9vcCgpIGNhbGxzIG5mc2RfcGVybWlzc2lvbigpIChpbg0KPiA+IG5mczRfY2hlY2tfZmlsZSgp
KS4gU2VlbXMgbGlrZSB3ZSdyZSBjb3ZlcmVkLg0KPiA+IA0KPiA+IA0KPiA+IFRyb25kOg0KPiA+
ID4gSSdtIG5vdCBzYXlpbmcgdGhhdCB0aGUgcmV0dXJuIG9mIGFuIEFDQ0VTUyBlcnJvciBpcyBj
b3JyZWN0DQo+ID4gPiBoZXJlLA0KPiA+ID4gc2luY2UgdGhlIGZpbGUgd2FzIGNyZWF0ZWQgdXNp
bmcgdGhpcyBjcmVkZW50aWFsLCBhbmQgc28gdGhlDQo+ID4gPiBjYWxsZXINCj4gPiA+IHNob3Vs
ZCBiZW5lZml0IGZyb20gaGF2aW5nIG93bmVyIHByaXZpbGVnZXMuDQo+ID4gDQo+ID4gVGhlIGFs
dGVybmF0aXZlIGlzIHRvIHByZXNlcnZlIHRoZSBhY2Ntb2RlIGxvZ2ljIGJ1dCBpbnN0ZWFkIGFk
ZA0KPiA+IHRoZQ0KPiA+IE5GU0RfTUFZX09XTkVSX09WRVJSSURFIGZsYWcsIG1lIHRoaW5rcywg
d2hpY2ggaXMgbm90DQo+ID4gb2JqZWN0aW9uYWJsZS4NCj4gPiANCj4gPiANCj4gPiBUcm9uZDoN
Cj4gPiA+IEhvd2V2ZXIgdGhlIGlzc3VlIGlzIHRoYXQga25mc2Qgc2hvdWxkIGJlIGVpdGhlciBj
aGVja2luZyB0aGF0DQo+ID4gPiB0aGUNCj4gPiA+IGNyZWRlbnRpYWwgaXMgY29ycmVjdCB3LnIu
dC4gdGhlIHN0YXRlaWQgKGlmDQo+ID4gPiBFWENIR0lENF9GTEFHX0JJTkRfUFJJTkNfU1RBVEVJ
RCBpcyBzZXQgYW5kIHRoZSBzdGF0ZWlkIGlzIG5vdCBhDQo+ID4gPiBzcGVjaWFsIHN0YXRlaWQp
IG9yIHRoYXQgaXQgaXMgY29ycmVjdCB3LnIudC4gdGhlIGZpbGUNCj4gPiA+IHBlcm1pc3Npb25z
DQo+ID4gPiAoaWYNCj4gPiA+IEVYQ0hHSUQ0X0ZMQUdfQklORF9QUklOQ19TVEFURUlEIGlzIG5v
dCBzZXQgb3IgdGhlIHN0YXRlaWQgaXMgYQ0KPiA+ID4gc3BlY2lhbA0KPiA+ID4gc3RhdGVpZCku
DQo+ID4gDQo+ID4gQnV0IExBWU9VVEdFVCBpcyBub3QgYSBSRUFEIG9yIFdSSVRFLiBJIGRvbid0
IHNlZSBsYW5ndWFnZSB0aGF0DQo+ID4gcmVxdWlyZXMgc3RhdGVpZCAvIGNyZWRlbnRpYWwgY2hl
Y2tpbmcgZm9yIGl0LCBidXQgaXQncyBhbHdheXMNCj4gPiBwb3NzaWJsZSBJIG1pZ2h0IGhhdmUg
bWlzc2VkIHNvbWV0aGluZy4NCj4gPiANCj4gPiBBbHNvLCBSRkMgNTY2MyBoYXMgbm90aGluZyB0
byBzYXkgYWJvdXQgQklORF9QUklOQ19TVEFURUlELg0KPiA+IEZ1cnRoZXIsDQo+ID4gSSdtIG5v
dCBzdXJlIGhvdyBhIFNDU0kgUkVBRCBvciBXUklURSBjYW4gY2hlY2sgY3JlZGVudGlhbHMgYXMg
TkZTDQo+ID4gc3RhdGVpZHMgYXJlIG5vdCBwcmVzZW50ZWQgdG8gU0NTSS9pU0NTSSB0YXJnZXRz
Lg0KPiA+IA0KPiA+IExpa2V3aXNlLCBob3cgd291bGQgdGhpcyBpbXBhY3QgYSBmbGV4ZmlsZSBs
YXlvdXQgdGhhdCB0YXJnZXRzDQo+ID4gYW4gTkZTdjMgRFM/DQo+ID4gDQo+ID4gSSB0aGluayBO
RlNEIGlzIGNoZWNraW5nIHN0YXRlaWRzIHVzZWQgZm9yIE5GU3Y0IFJFQUQgYW5kIFdSSVRFIGFz
DQo+ID4gbmVlZGVkLCBidXQgaGVscCBtZSB1bmRlcnN0YW5kIGhvdyBCSU5EX1BSSU5DX1NUQVRF
SUQgaXMgYXBwbGljYWJsZQ0KPiA+IHRvIHBORlMgYmxvY2sgbGF5b3V0cy4uLj8NCj4gPiANCj4g
PiANCj4gDQo+IElmIHlvdSBsb29rIGF0IFNlY3Rpb24gMTUuMiwgdGhlbiBORlM0RVJSX0FDQ0VT
UyBpcyBkZWZpbml0ZWx5IGxpc3RlZA0KPiBhcyBhIHZhbGlkIGVycm9yIGZvciBMQVlPVVRHRVQg
KGluIGZhY3QsIHRoZSB2ZXJ5IGZpcnN0IGluIHRoZSBsaXN0KS4NCj4gDQo+IEZ1cnRoZXJtb3Jl
LCBwbGVhc2Ugc2VlIHRoZSBmb2xsb3dpbmcgYmxhbmtldCBzdGF0ZW1lbnQgaW4gUkZDODg4MSwN
Cj4gc2VjdGlvbiAxMi41LjEuOg0KPiANCj4gwqDCoCAiTGF5b3V0cyBhcmUgcHJvdmlkZWQgdG8g
TkZTdjQuMSBjbGllbnRzLCBhbmQgdXNlciBhY2Nlc3Mgc3RpbGwNCj4gwqDCoCBmb2xsb3dzIHRo
ZSBydWxlcyBvZiB0aGUgcHJvdG9jb2wgYXMgaWYgdGhleSBkaWQgbm90IGV4aXN0LiINCj4gDQo+
IFdoaWxlIHlvdSBjYW4gYXJndWUgdGhhdCB0aGUgYWJvdmUgbGFuZ3VhZ2UgaXMgbm90IG5vcm1h
dGl2ZSwgYmVjYXVzZQ0KPiBpdCBkb2Vzbid0IHVzZSB0aGUgb2ZmaWNpYWwgSUVURiAiTVVTVCIg
LyAiTVVTVCBOT1QiIC8uLi4sIGl0IGNsZWFybHkNCj4gZG9lcyBkZWNsYXJlIGFuIGludGVudGlv
biB0byBlbnN1cmUgdGhhdCBwTkZTIG5vdCBiZSBhbGxvd2VkIHRvDQo+IHdlYWtlbg0KPiB0aGUg
cHJvdG9jb2wuDQo+IA0KPiBTbyBteSBwb2ludCB3b3VsZCBiZSB0aGF0IGlmIExBWU9VVEdFVCBp
cyB0aGUgb25seSB0aW1lIHdoZXJlIGENCj4gcHJvcGVyDQo+IGNyZWRlbnRpYWwgY2hlY2sgY2Fu
IG9jY3VyLCB0aGVuIGl0IG5lZWRzIHRvIGhhcHBlbiB0aGVyZS4gT3RoZXJ3aXNlLA0KPiB5b3Vy
IGltcGxlbWVudGF0aW9uIGlzIHJlc3BvbnNpYmxlIGZvciBlbnN1cmluZyB0aGF0IGl0IGhhcHBl
bnMgYXQNCj4gc29tZQ0KPiBvdGhlciB0aW1lLCBpbiBvcmRlciB0byBlbnN1cmUgdGhhdCB1c2Vy
IGFjY2VzcyBmb2xsb3dzIHRoZSBydWxlcyBvZg0KPiB0aGUgcHJvdG9jb2wuDQo+IA0KDQpQdXQg
ZGlmZmVyZW50bHk6IHVubGVzcyB5b3UgaGF2ZSBhbiBhbHRlcm5hdGl2ZSBtZWNoYW5pc20gZm9y
IGVuc3VyaW5nDQp0aGF0IHRoZSBORlN2NC4xIHJ1bGVzIGFyZSBmb2xsb3dlZCwgdGhlbg0KDQog
KiBJZiBFWENIR0lENF9GTEFHX0JJTkRfUFJJTkNfU1RBVEVJRCBpcyBub3Qgc2V0LCB0aGVuIExB
WU9VVEdFVCBuZWVkcw0KICAgdG8gY2hlY2sgdGhlIHN1cHBsaWVkIGNyZWRlbnRpYWwgYWdhaW5z
dCB0aGUgZmlsZSBwZXJtaXNzaW9ucywgYW5kIGENCiAgIGZpbGUgcGVybWlzc2lvbnMgY2hhbmdl
IHdoaWxlIGEgbGF5b3V0IGlzIG91dHN0YW5kaW5nIHNob3VsZCBhbG1vc3QNCiAgIGNlcnRhaW5s
eSB0cmlnZ2VyIGEgbGF5b3V0IHJlY2FsbC4NCiAqIElmIEVYQ0hHSUQ0X0ZMQUdfQklORF9QUklO
Q19TVEFURUlEIGlzIHNldCwgdGhlbiBMQVlPVVRHRVQgbmVlZHMgdG8NCiAgIGNoZWNrIHRoZSBj
cmVkZW50aWFsIGFnYWluc3QgdGhlIG9uZSB0aGF0IHdhcyB1c2VkIHRvIGNyZWF0ZSB0aGUNCiAg
IHN0YXRlaWQsIGhvd2V2ZXIgaXQgc2hvdWxkIHByZXN1bWFibHkgbm90IGJlIG5lY2Vzc2FyeSB0
byBwZXJmb3JtDQogICB0aGUgbGF5b3V0IHJlY2FsbCBkdXJpbmcgYSBmaWxlIHBlcm1pc3Npb25z
IGNoYW5nZS4NCg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QgTGludXggTkZTIGNsaWVudCBtYWludGFp
bmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0K

