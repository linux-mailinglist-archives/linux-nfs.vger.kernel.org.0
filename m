Return-Path: <linux-nfs+bounces-6348-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8FC8971D59
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Sep 2024 17:00:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10E3F1C23574
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Sep 2024 15:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 624731BBBF0;
	Mon,  9 Sep 2024 14:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="KmKJqQ0e"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2107.outbound.protection.outlook.com [40.107.95.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6041D1BC067
	for <linux-nfs@vger.kernel.org>; Mon,  9 Sep 2024 14:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725893998; cv=fail; b=s4Bo63ekjiGepGhG3q/0aN6u2uBIbISj2XdWJD2XqNoHT8PhawZ2PkykiN3FD7ccQagczQdKnpuO9i0gvDw6hMkn2FdCsbmNi3zLXlwNETvOrdDidwLMOh5y+KRAyOYdweujS9gWlFETQP5KRw8C6KkedWDiwNl+GF20yO+GfIk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725893998; c=relaxed/simple;
	bh=xi1FQxhmNiIE8oAcfRqXhWQQdDZ/FhrPGFe1AH4Gp9w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CAgj7Q8IN2DsqTADj3gU9+NsqeHfIH0jSvp3l29HlXCYW73PTWfirKRJNKLZJq8iJOjG+C5bHb/F3V99sOM4bVbetlVJZnly6zZEhsJs0oc1ds/L0xDGfHbcmZ9gl13gPNRKAbMYCiFJA8iUNsn1nz6TJt6FqeIflrPDznMZ29E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=KmKJqQ0e; arc=fail smtp.client-ip=40.107.95.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V8NopzqdvGTMw6z7zYT42UOU20XzPuqabtMUsHfhXk2vaeRq1bXdJdYinQdO7WToLastnDNIJ4wVNxWTkEOwnaDezxdHbpZhW8gr1djuQ82Ydmz+Hkz+IrE2qoRTVQkJMFmFazlbiiWqsEJdNxrI2a84TF3b3vvlasKppbAB0r1siRlCuz9V9KmRblCSoGADnIzytc+zz2MYSimrs/SI5zeTK7SREqrgqnd+SYOfKnt4r3RZQHKlPt8+S8ZV9ASA2o1bdfoAXZGKXBnotM6vq4spWtMmv3JzYxeQOMhpPd/9vlIvRlJ8hcP/mJKQ4R2Gh1p+xS1XDgywLCin8ClkCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xi1FQxhmNiIE8oAcfRqXhWQQdDZ/FhrPGFe1AH4Gp9w=;
 b=qrA+RJsNX1lSUyW3HzvyfVJYGSP8umZrpQG88hGYlgxDCyWcr0zThfkCDPyuZPyBE9sYXrlOGkd7ScFVnb9ujjJTm/dUwQW7DMLJiPWtO89XK0g0IG7nDJFoSkdArIFAfi8SsZG8GjtGX88F2jG4aR/st+KmeMtTqIJ7+d22FjZnwomXR2s+b4K/08nrnpgvbUzpGzOXqsiXHjUl4ZUqcUUo38EfR14C8yE0VC+oMvvNsOliNEQiMh+I69LAPxVFl2C3qOyY8X/q8GAv5juJF3uibZ0nkX+R7496MGCdwzjSDUJdHABNwFN9R4vCQy4RTU9WEI83Gv6WAmQsuDmzqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xi1FQxhmNiIE8oAcfRqXhWQQdDZ/FhrPGFe1AH4Gp9w=;
 b=KmKJqQ0etGPH/2uxyvoCXkesThFxi4oA/O5WLnixh6Vlhkk2Mi46PF4EMH3G9YgGbJUSZJMaUGTds+6juS9utIWzc045dhZQ1DqB9fuRiO7+GMFf2ZvNK9+pWDLpPB1X1woh8nH38OJKcjdtGDtl4TTrEu+rHk0alFc+JtQrpuY=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by SA1PR13MB5514.namprd13.prod.outlook.com (2603:10b6:806:231::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Mon, 9 Sep
 2024 14:59:46 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb%4]) with mapi id 15.20.7939.017; Mon, 9 Sep 2024
 14:59:44 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "roi.azarzar@vastdata.com" <roi.azarzar@vastdata.com>
CC: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	"jlayton@kernel.org" <jlayton@kernel.org>
Subject: Re: Suggested patch for fixing NFS_CAP_DELEGTIME capability
 indication in the client side
Thread-Topic: Suggested patch for fixing NFS_CAP_DELEGTIME capability
 indication in the client side
Thread-Index: AQHbAfxLVovO4sMjPk+vVXAfhmiAmbJOG/CAgADcgICAAJVlgA==
Date: Mon, 9 Sep 2024 14:59:44 +0000
Message-ID: <e21ab3096705683b7481876e651d08b53a366cef.camel@hammerspace.com>
References:
 <CAF3mN6VbfgBV-o5yiSRn=PHAMO1be7G5H5wYRSsasYJ0Pvwv9w@mail.gmail.com>
	 <48295036a03cf9806eb5a42f890af2e43d9980a6.camel@hammerspace.com>
	 <CAF3mN6WsrQioFW09MSxjgdGsG_VG87JhW=1Y5geErfEHWW+CZQ@mail.gmail.com>
In-Reply-To:
 <CAF3mN6WsrQioFW09MSxjgdGsG_VG87JhW=1Y5geErfEHWW+CZQ@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|SA1PR13MB5514:EE_
x-ms-office365-filtering-correlation-id: ab8cc2b4-8e1a-4c44-157f-08dcd0e00a33
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?SDNqL3B4b3pKS1BZUTlPY3k4S3BoWnJkTm1HdDE3b1MrckVwSUlNOUxlYlVN?=
 =?utf-8?B?Qk9mTmxiU2VtTHNBc0dXc3Y2YnZLV2twa2NMeURVcXBIajVwRlVscGs2WFNW?=
 =?utf-8?B?bDZnQVRST2NvVHNtdlFONGZPVVpwUkVYRzBmcnNEOC93V2ROQVRoNE1QNzQ2?=
 =?utf-8?B?aEdreEhUQzFNT1hlakkvT2xYNG5ndlFVQjQydzdtVG1BY3FYNmltOFpqMFpt?=
 =?utf-8?B?OGxDeWVXMFdBeWRZbEtiNkVCUlZWQTlXcHBLcUhVVWVxamQzeEhWTis3anh2?=
 =?utf-8?B?ZE1TRk8ydUJaOHFlWG90aVd1blhOMXc5aU9PeGFLQXdHLzdWcVU3akRlNDVG?=
 =?utf-8?B?ZW9Jem45RGdKdWJnaU50NDZmR1AvY3pBcVIyTFpVeldMVVN0UmJveUQ5bmdI?=
 =?utf-8?B?ampFQ0hud25mejRmVFJkZ1QyUVdkRGVrMzhMWXZoeGMzVndrT1E2M29WVWRk?=
 =?utf-8?B?dVpqVHNsdUV1TlZubjE1VkFuczFOY0RsWEZCMHhkdDV1MUZSUFp3WTNiamhK?=
 =?utf-8?B?ay9TOTV4L3p0NkxHdlkvemlUdzRCRnMxNVV5aEl2aC9TME9JOUpYTU5GOGlE?=
 =?utf-8?B?REdYb0pneWpXV0FkdytKU3hKYW1ma2NXYUY5VTZkVThOUE40Uzg4YVk0NVNv?=
 =?utf-8?B?YitMOHlZTE8xemVzK3U0anM4a3BQeHlBUWQ0Y1ErRWpCRlRaMnhTMnZpWmFY?=
 =?utf-8?B?a1JXS0RtOTRKYXZkZGU4czdBeS9MT1ZpOGJFUGxrSW1Oak5UdHpaV0EwTjVq?=
 =?utf-8?B?bmR2U3BlSnRwaUZ4NG4vZFd4cVhJVWdhWWRRZjNoYyt1Q2RjYjZVOEdaUVlY?=
 =?utf-8?B?d0xPUDdYeHg4VXJRYkMyOHpzUG5UdTAxUktrS3dwTzhBSXhtQWt6NkFPeXdF?=
 =?utf-8?B?em8yOTVxWmE5U3ZYY3hrWm53NlQ0SG9mUGpweTB0a3pxVGhqSm5rQ2ZGTzJR?=
 =?utf-8?B?aUhieDNyY3F5SGc2TTlJZTQ2Nms4emhzWlBsbWk3Wlh2bExVRlV0T2w5TkdW?=
 =?utf-8?B?UDBBSEdoa0tMTjNMSW5Xd0s1SFdGY3dlbG83Zko3ZE1PN0pER1VKTXpzY3Yy?=
 =?utf-8?B?bkRoN1B4cDlZamVsck9DMDlmVGlHclhHSmdJdlA3Qkxvd0dReDZKZVhHYzcz?=
 =?utf-8?B?UTJpVnhidGhiaUM5MFVaOWlycjB6VmFKYUlzQ25aOTMxeGpQcGkxWXZUcmpP?=
 =?utf-8?B?eU1pTnZYNTdjdE90OUVscXNaS0syRmJ6Y0xhYzAxYUpKdlRVSHQ4dUFYNk9t?=
 =?utf-8?B?ZVBXZW9nYndCMEF6L0htYVpYYzc3VnpTdHpBQmcycE5DbGFkWHRGc1BCTG9p?=
 =?utf-8?B?cDBWWGc1Mk5rOFRyVS9ZVVk0cmVDdlQzTVdsNkRPT2o3SDYwN1cyZFBvYmlV?=
 =?utf-8?B?aVZjOFc2T3lkTy9hRHpHOUF6NXcvSmpwV0NhRnZ0YnBMK0c2WlRCVWU2dlBq?=
 =?utf-8?B?ZXNwbWFKbHdhOElNc1lIYUkxQUExMk9DT2duSS9KTjYzZ3RYYmNwVFduZVlx?=
 =?utf-8?B?ZFliZkVrZm1GWjB1dDRkWU9hQ3BmaTRVdFFjZkRabTA3QUMvQzNsc1haQTN1?=
 =?utf-8?B?SjJYUERJak8vT3Vacmc3SVA5V1RUdUpNSnBmS243Vm5XLzBiTTVES0Y2SHJy?=
 =?utf-8?B?aHR6enBhdG8wbTNUSFA1a3dES21kb1hqaXdYSUhUcUNlcC9obWdWZGJmR0xR?=
 =?utf-8?B?WCtrTjRlUDgraTRZWFgyUk95bHBVRmliQWtlbUwxRlBWdDlBMEM4dnIwR1BL?=
 =?utf-8?B?S1JuSEd4N2hTcjY5YlYwQVFCeTJrWjgwZENQRkdTYmNNWDRVcjVIM2NkS2M4?=
 =?utf-8?B?SnVLeVhBUXJCaVlSaWtDMGIwNThxK2hTcFN0RWRXOFBkZFEydnVCRTlaeVYz?=
 =?utf-8?B?TG1KRU4rTU1MbFVWcytMUnJ0SVlJWi9yem9ZUUd4ZFdkMmc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VVZ6ZG1ZemNiWS9IeTdsaE1pUjd0WCtRYVRtZmg2VnUxS0xWUXhZVGZiWGtz?=
 =?utf-8?B?d2c0dDc0RXZMVlIzWDBPK2FFaFhWWVdWczZiVjY0OWw5dERsZFUwU0RCeUlN?=
 =?utf-8?B?cjlMTXhqcDdtb0V4OVk1YXU2Si9aY0trcWxOaDhMbFV2b0kydHN2Wjhwc2l2?=
 =?utf-8?B?UGNIYVc3bFF2ZnhjclRnL085SVFuZzlmQ0E2Um5seDJvTE9zMTBwSWtKeitW?=
 =?utf-8?B?RklZbjJpYVltTHFxcEs3Y3g2LzBVN0p3VkN3Q1B1bzZISXpXeDlTKy94VkV2?=
 =?utf-8?B?MExwRDUrZkpkU2o2WXRlSXFMdlNJeDBBVHpBL2w1MG5meGFwZ2UxSFpGQXg3?=
 =?utf-8?B?by9ybms5Yit2cHZVVDdZeG9zejAvclRQb3VVa2h2UGdKWWFkQzdENU1XVVhK?=
 =?utf-8?B?RUpRaXorQi9WbUhwV1I4ZlZaMXFkMno5R0VFVGdRL01IMDA1SDF6UmhZWWRK?=
 =?utf-8?B?cXU0VXFleXpyRFBZMzZheXcwVGRjd2t1NkNVV3U3S0g4WklvU0ZjalVOc3RX?=
 =?utf-8?B?VGhWMmw3d1pPUG0vUEZ2TXpSVDlqK3pFeHRWNXU3bzlIV1N3ZHlTOUh6VnZC?=
 =?utf-8?B?WHc5NmtYQURJVEdma0FIVFNuODhMcmcvNVdIWmtjZGx2RVIxakFkU2x1MUVr?=
 =?utf-8?B?V3hDNkhmUmFhemdwcmxUMWtHam5Hb1ViWmRQWGxjNk42c0pwWU1hVjAvSVJi?=
 =?utf-8?B?d04zTGpPUExoSUR5Y09lbjlUMTR6MGNEV1RacjQ1Z2IyT3V6dS9hMUgwK1Vm?=
 =?utf-8?B?TXNQenhFUVpEMjA0RVVVWTN1RllxWjh6Sjd4Y2VQYit2TVRSaVpydTZVZlBZ?=
 =?utf-8?B?cm4weXNLUm50QjFtU256ZXdxb0JEUWhJLzBJbGtuQ3phbUlsZjRSUTNTUktP?=
 =?utf-8?B?RWszZkFqWFRXM25kdk0yWHg2ekxYVHJGRVRIQlFobWRVK2J2ZzBUNFpRSm81?=
 =?utf-8?B?WVZvRk8yT2VDaCtVQ1BRQXQwSVFsek03M1Vack10U1IwWmhLS1djbldqOUxk?=
 =?utf-8?B?ZUNXMHllZGJwS2ZhNit1V1dTV0RrK1J1ODB1QU5KWlFvM3dWOTVLdUJaZ0pM?=
 =?utf-8?B?SFJTdkNFdE1nTmR2cjBUcjBHZXBZN3kxZzJsSk5NKzBWUEdkdTlQZDNhbVVL?=
 =?utf-8?B?WXlkUTJhWHdBTjVnMTZDR1pVUklORFR6SGxtODhYRkVudTVxTHVRby9WOTlj?=
 =?utf-8?B?QVBXanpJTGRqODFob1FBcjBiUis4UVRRUm55TFJRVDVBSWxiQzR2bnZkMFJ4?=
 =?utf-8?B?ZmJ5T0VpVUIzVnYrSjNCM2ZVV3NSelF0QWRyb200djRiYUVnZlZrdGVmeUxn?=
 =?utf-8?B?NlRpY3pDN3FHZU0rd3QwYkU1Yy9OQlNqZlA5QUN6RDA2UTFGMHp1anFGYm5w?=
 =?utf-8?B?MVpRNUFoMENSd1VZUmducmlBRzAxajdSS3BEeTdsellUV3QyUWFUbDlCclho?=
 =?utf-8?B?cnk0YVFXR0pCNkZnc3NjUHR2YVRrc3V4aUVIcmg3aGlrT2NtSlNoWlhtbUQ4?=
 =?utf-8?B?bFdGekM3ZG42YWRIcjNhd2hjZjI1R1Zrbmk5QjFpaGVEQjhjZ2lJZTFVZDZN?=
 =?utf-8?B?Z1padDR0WGJjOE5UWlJGWkxjOFNJb2ZqQ0R4UXhMN2lHWXdMRGJ1amx5VmN6?=
 =?utf-8?B?RnU4SkJSVTBuYVJpSjZxSXF2YUppajY1Q25Ha1ZmWkZoMUE0dUtJdlhDYldP?=
 =?utf-8?B?NEpwbTZpR21GZVVJOFJoNmthSTNOaHB2QUx2eGltNnhNNTR4ZFAvRCt1S052?=
 =?utf-8?B?TG1FSXpNRVJaMVVUL3Q4ZklVL3BmMkRrVVpKTWR2Ums4U2ljUFR4cDZ4bjhW?=
 =?utf-8?B?UllINzE5bkd5cC81WllsMnFzL1hOSkJ6NVcvZGFVK2UyVldhTzQwODZIRkZO?=
 =?utf-8?B?M21RTjRIVDE5dDJaUHBIYjZzZlhmTWRMSTVlUDBUTXpISkMyeEtObnZkdVlk?=
 =?utf-8?B?MHh6eTR2Q2M0S1pLSUV2ckNxeVhkcEZvd0twWlRENHZxUWd5OGxZN2dzQXJk?=
 =?utf-8?B?VmZ1aXQxbHNOZm0zcUI5ektkTmNFTjdzTnYrUkgyQnJDS04wanhZY1VFcnEr?=
 =?utf-8?B?bEN0eDlpUDA4N3ZtR3RZS2dIV1V0ZWM5djRPRW5rTk9Gb0ZUaWZ1R0lMSnNq?=
 =?utf-8?B?ckZ2RU42R0NpcDladWlzZ243UXZJOGxqUlRzei9wMDd0WTlRalgrU1BZV281?=
 =?utf-8?B?TDViZFdrdm9rWkx0d1VIZkZFRHNVZzJUdThwWWZzV2luWjM5dEIxcjJXWFdX?=
 =?utf-8?B?eW9KOFltV2lrNDR4KytmOVRSS2JRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A01744BAB50EF348B1B5D8B5C6F55A4C@namprd13.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ab8cc2b4-8e1a-4c44-157f-08dcd0e00a33
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2024 14:59:44.1554
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QIFOxCM3w4IcjjQtrEdy3/aO2aelhjuUNDgQwkdDUvlat12u1O+D//wjy9K/4f9yT4i2m7hhugHzOI6QH+/gNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR13MB5514

T24gTW9uLCAyMDI0LTA5LTA5IGF0IDA5OjA1ICswMzAwLCBSb2kgQXphcnphciB3cm90ZToNCj4g
SXNuJ3QgdGhlIGZvbGxvd2luZyBjbGVhcmVyPw0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIGlmICgocmVzLmF0dHJfYml0bWFza1syXSAmDQo+IEZBVFRSNF9XT1JEMl9USU1FX0RFTEVH
X01PRElGWSkgJiYNCj4gKHJlcy5vcGVuX2NhcHMub2Ffc2hhcmVfYWNjZXNzX3dhbnRbMF0gJg0K
PiBORlM0X1NIQVJFX1dBTlRfREVMRUdfVElNRVNUQU1QUykpDQo+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzZXJ2ZXItPmNhcHMgfD0gTkZTX0NBUF9ERUxFR1RJ
TUU7DQo+IA0KPiBXaGF0IGFib3V0IFRJTUVfREVMRUdfQUNDRVNTPyBzaG91bGRuJ3Qgd2UgYWRk
IGl0IHRvIHRoZSBhYm92ZQ0KPiBjb25kaXRpb24gaW4gdGhlIHNhbWUgbWFubmVyID8NCg0KU3Vy
ZS4gSW4gYW55IGNhc2UgeW91IGFyZSB0YWxraW5nIGFib3V0IHN1cHBvcnQgZm9yIGEgY29tcGxl
dGVseSBzdHVwaWQNCnNlcnZlciBpbXBsZW1lbnRhdGlvbiBoZXJlLCBiZWNhdXNlIGl0IG1ha2Vz
IHplcm8gc2Vuc2UgZm9yIGEgc2VydmVyIHRvDQpzdXBwb3J0IFRJTUVfREVMRUdfTU9ESUZZIG9y
IFRJTUVfREVMRUdfQUNDRVNTIHdpdGhvdXQgYWxzbyBzdXBwb3J0aW5nDQp0aGUgV0FOVF9ERUxF
R19USU1FU1RBTVBTIGZsYWcuIEhvd2V2ZXIgaWYgd2UncmUgZ29pbmcgdG8gYmUgcGVkYW50aWMs
DQp0aGVuIGxldCdzIGRvIGl0IHByb3Blcmx5Lg0KDQo+IA0KPiBPbiBTdW4sIFNlcCA4LCAyMDI0
IGF0IDc6NTXigK9QTSBUcm9uZCBNeWtsZWJ1c3QNCj4gPHRyb25kbXlAaGFtbWVyc3BhY2UuY29t
PiB3cm90ZToNCj4gPiANCj4gPiBPbiBTdW4sIDIwMjQtMDktMDggYXQgMTc6MzQgKzAzMDAsIFJv
aSBBemFyemFyIHdyb3RlOg0KPiA+ID4gSGksDQo+ID4gPiANCj4gPiA+IGFzIGRpc2N1c3NlZCB3
aXRoIEBKZWZmIExheXRvbiBzZW5kaW5nIGEgc3VnZ2VzdGVkIHBhdGNoIHRoYXQNCj4gPiA+IGFp
bXMgdG8NCj4gPiA+IGZpeCBORlNfQ0FQX0RFTEVHVElNRSBjYXBhYmlsaXR5IGluZGljYXRpb24g
aW4gdGhlIGNsaWVudCBzaWRlIGJ5DQo+ID4gPiBzZXR0aW5nIGl0IGFjY29yZGluZyB0byBGQVRU
UjRfT1BFTl9BUkdVTUVOVFMgcmVzcG9uc2UgKGFuZCBub3QNCj4gPiA+IGFjY29yZGluZyB0byBU
SU1FX0RFTEVHX01PRElGWSkgc3VwcG9ydCBhcyBkcmFmdC1pZXRmLW5mc3Y0LQ0KPiA+ID4gZGVs
c3RpZC0NCj4gPiA+IDAyDQo+ID4gPiDCoHN1Z2dlc3RlZC4NCj4gPiA+IA0KPiA+IA0KPiA+IE5B
Q0suIEkgYWdyZWUgdGhhdCB3ZSBzaG91bGQgdHVybiBvZmYgTkZTX0NBUF9ERUxFR1RJTUUgaWYg
dGhlIG9wZW4NCj4gPiBhcmd1bWVudHMgZG9uJ3Qgc3VwcG9ydCBpdCwgYnV0IHdlIHNob3VsZCBu
b3QgdHVybiBpdCBvbiB1bmxlc3MgdGhlDQo+ID4gc2VydmVyIGhhcyBpbmRpY2F0ZWQgdGhhdCBp
dCBzdXBwb3J0cyB0aGUgYXR0cmlidXRlLg0KPiA+IA0KPiA+IGkuZS4gdGhlIGNvcnJlY3QgY2hh
bmdlIGhlcmUgaXMNCj4gPiANCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAo
IShyZXMub3Blbl9jYXBzLm9hX3NoYXJlX2FjY2Vzc193YW50WzBdICYNCj4gPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBORlM0X1NIQVJFX1dBTlRfREVMRUdfVElN
RVNUQU1QUykpDQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHNlcnZlci0+Y2FwcyAmPSB+TkZTX0NBUF9ERUxFR1RJTUU7DQo+ID4gDQo+ID4gLS0NCj4g
PiBUcm9uZCBNeWtsZWJ1c3QNCj4gPiBMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1l
cnNwYWNlDQo+ID4gdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KPiA+IA0KPiA+IA0K
PiANCg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwg
SGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=

