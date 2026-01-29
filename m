Return-Path: <linux-nfs+bounces-18599-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YHtWFKcfe2lPBgIAu9opvQ
	(envelope-from <linux-nfs+bounces-18599-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Jan 2026 09:51:51 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C1670ADC11
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Jan 2026 09:51:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D0DE130215BE
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Jan 2026 08:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 824A337E2F0;
	Thu, 29 Jan 2026 08:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="Fg9OYxDf"
X-Original-To: linux-nfs@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010060.outbound.protection.outlook.com [52.101.229.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCEEB2EB5A6
	for <linux-nfs@vger.kernel.org>; Thu, 29 Jan 2026 08:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769676687; cv=fail; b=SIJ/jQVnwuVuLcblEDSZ6E1kbbjE58eUxeXli6sqgdS3s63ya2cfpjjq+vvDqOBe3m05PovFIop4h4LlAvXg9gosFeWcyBhhrVWjQDVdZtpWEqyYs0/JO/Y9hAuqYGRs0oGVZ8kq2xAXk3JKzP76B1JdXa3ltNASIhCpsyDKRmI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769676687; c=relaxed/simple;
	bh=tSifSJHHBnOt14AvvwLvxUiJXCLn+JU4iz2xEjSldBc=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=f7lNDfyIxOJgJUuF3knf4ideFLmQtIFIGV1c6OO8wG7tlH3UowrIjGO5VfEYv13otUEVoqfJYpAjbE2fqi5BEqnzuAq3FUicG6BH+W5LzKExDf6t1f/M8ECbcCe25F8QPpaMw+Nwh1wz6H5lYjDkf4pzqME8+WYePcCyShXsxA8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=Fg9OYxDf; arc=fail smtp.client-ip=52.101.229.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UaYpq48N5Ka4qlGkL0puCjpYgv1XibQKgM6bCR02Xq1jmy8tk5fKw+yfjIBNKRV761k4B7NGGYe0zjLjQjtKokXan4xnYpFaIA7J9l+YOszyq6640WP/Up4FeDFGRSHiI856JL5cYjYn9M/NGs+9pICjp6uP6Hn4lL0xK0TuCap0Vl2IcSJaG4O7EX172Uy7VG0JWWtp8QvG08KLaPAdbdz64380LzlRTloG5LWncd7HYO4YEgHGc9jS+HXQZyn9qeAbXWR16tZ5CSrD+kLTYSQpi/FMMqY0Bqk9vNcWykbqFagoxFx1w/VTFoit9tQ8ETyH9pkeXcYSwKXUJ4RB4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tSifSJHHBnOt14AvvwLvxUiJXCLn+JU4iz2xEjSldBc=;
 b=xafYYcurk2DJ55it2xoTTluDx4neXFSW/D61qicCOItcW8ERZh1ffcKBFTb4+D0BlFqDfTiCC753GADxuE9Dd7EydnBiWwMK5AG0wBmZARNjGgxqv3Dc4pw+808FDXL9ck7i0x8fJgOANJahjQGsxdAe3P/LOYOWg+/+y3W/cMs3Qwmaa+DA3uz5xOLbqbseOmO0M8sfsHYZ8YbWJm78fxOrXn8mm+H1Evvct91W+Rgn+3DZQEtwKkUQSb/Cl9jHl/Tw9viq5Tal08h0izUSaWrDqUyUYVXLOSF9gDy+Q83n3zFa4EfqKPoWuGyHW/XEvuQX2F9DqoFlFLHm7s31sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tSifSJHHBnOt14AvvwLvxUiJXCLn+JU4iz2xEjSldBc=;
 b=Fg9OYxDfziOnFel4vjfkf2+VekDcNq6QNf8HrmfvpcH8j1eePnlXlLyzydDqDuFGaqxokK4xvhfWvjWy2ADh4yIm0DFptN1zJeljjC7apjl9LJzJS7lpRga3s8YTREq6EKVhugK7RUj6Y3va19DXka++6v1w3E1WGEUUoFL9Ym8unVlbuECJ5wuXk1Ci+t9JnWZehJ1sFxPbocK0VEwsnIC+gUthbD0KOzifpX3Sg+zQICfsM1o3Cb9rJNDa3o7DZ4mKbReGUQTS96NSYxjrzKoZWdL09Lpimg61sp9/CqnpDJ8LVlPNyA7R22F6gaGSG0uYV0jpx7tGXAmJVHksgA==
Received: from OSZPR01MB7772.jpnprd01.prod.outlook.com (2603:1096:604:1b4::7)
 by TYYPR01MB15165.jpnprd01.prod.outlook.com (2603:1096:405:1a0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Thu, 29 Jan
 2026 08:51:12 +0000
Received: from OSZPR01MB7772.jpnprd01.prod.outlook.com
 ([fe80::5956:959c:6018:183a]) by OSZPR01MB7772.jpnprd01.prod.outlook.com
 ([fe80::5956:959c:6018:183a%6]) with mapi id 15.20.9564.006; Thu, 29 Jan 2026
 08:51:12 +0000
From: "Seiichi Ikarashi (Fujitsu)" <s.ikarashi@fujitsu.com>
To: "'linux-nfs@vger.kernel.org'" <linux-nfs@vger.kernel.org>
Subject: [nfs-utils PATCH 08/10] mountd: fix a typo in man page
Thread-Topic: [nfs-utils PATCH 08/10] mountd: fix a typo in man page
Thread-Index: AdyQ+tHXFoDEzeFTS1OxJntRLyA7Zg==
Date: Thu, 29 Jan 2026 08:51:12 +0000
Message-ID:
 <OSZPR01MB77728D1012A50962587D425B889EA@OSZPR01MB7772.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ActionId=fe1e745b-92a0-42c8-8c4e-d6703fe31549;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=true;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED?;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2026-01-29T08:34:03Z;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB7772:EE_|TYYPR01MB15165:EE_
x-ms-office365-filtering-correlation-id: e85b9556-d145-4ec8-0263-08de5f138e26
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|1580799027|38070700021;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?RUxCdkY5MTJ2K2tQcUMvZzMxTWFYajVBY0ZBWEJVYTI4N2dqVDRhL1M0?=
 =?iso-2022-jp?B?ZnBOSnh1Mk1zWTZCaEtvTjdKbGRnNzh1empiZFpGTmIzNXB6Yk5rUnZl?=
 =?iso-2022-jp?B?alB0T2ZJTWNsTm5NbXN6dUx2QytmV25pMVFhYk5qbE5TdU9UM1daSWxo?=
 =?iso-2022-jp?B?aUJRMVU2Z0szYWd1T3B1c0FEMWVvbmxwR1F5NHoxU0Z0ZVVxNWlDQ1Zk?=
 =?iso-2022-jp?B?QWpacUZ2ZktTSTZCNHAwNVFSVkpxdFpsc2RzMjVoUmNOcnpST3RLQzFY?=
 =?iso-2022-jp?B?WlpTYlR4MEhGMjlIMEpVUDRQbGZMcnNJbzAvU1UxbHVSdjd3eE93Mk81?=
 =?iso-2022-jp?B?YVVGMjk1Q1lFMFBNMmNmZkhuRUVYQjF5UDh1Ymt3UDRrSlhVd2NIdDhQ?=
 =?iso-2022-jp?B?UUoxMEY2a2E0TTdRWEY4dzhjOU01ZWdHZk84NmZEdFpmcjErUXhIQ1h5?=
 =?iso-2022-jp?B?UVZqVEVTWG9zUEhic3FicTNyOHF4WldVRVdTakpHTkJ1MlFhWFVRYitt?=
 =?iso-2022-jp?B?RktaOXZ5RlBmRm5jMHp4OVFDeU8wYm9sSDdob1lnMVZsWU9VMTFSOUht?=
 =?iso-2022-jp?B?QUNJMjRFWW84SzJlM1grQ3hYM0s1d0dqd2JxUnlyeENNUS9XMXN1M1VH?=
 =?iso-2022-jp?B?Ynp2emhrblA3ZUt3UFMvcWxKVTIraG5ZL2RDeEZ5Sk15VDhQaGJESW9l?=
 =?iso-2022-jp?B?VmhwOWN2MmtrRlZaa0VFSHJXckhVaUl0MEsxV0dPMHQraHF2TWxUZUlJ?=
 =?iso-2022-jp?B?OHdIdTdCSkFDd2FBd1VxcFJIVndYdW8raHRkNEhBSE56K3N0YTJMaDQ4?=
 =?iso-2022-jp?B?QTEwL3VWVjk3OFM1cDdkUzh0bWNYcW9JZHlJWjU1dGY4UW5mVHZiQ3pK?=
 =?iso-2022-jp?B?OW9lV21MeXhmUjNBTEhrNlBaa0RSYUkwMmw1WW1UcUxlRnF4Q1hyaWtK?=
 =?iso-2022-jp?B?Q0pla2Z3VjBRNm51UGFaSTB1Q0pyYVZIYk1HVWMremVCK0VqSmFpcS8x?=
 =?iso-2022-jp?B?NUJ5ZE9YZ1J2VnRHSzRxZTE3WXZjbldQc2Jab0VwL3dLOHNlMXpySWlm?=
 =?iso-2022-jp?B?bFVSK1BBRCtML1RyTFlDcnIraVJHNzlWdCtkdUZWSlZabnljaGY3bFJD?=
 =?iso-2022-jp?B?ajMyVUY3S3pPWnRXZXM3akYzSXVDUEJ2REwxSXh3ZHhCUUQ5MitvNkxr?=
 =?iso-2022-jp?B?UWNaSWNManoxak5IQ3llM3RSeU9BckFnQzlPWjl4Nzd3ek1iUjRQUklV?=
 =?iso-2022-jp?B?MEFUSG9ZMzZPbkJ2Wm1vdlRzaGtSNDdDU1VOTG5lVWFpY1FmekZUUEZG?=
 =?iso-2022-jp?B?eUlDZ1lMaERoclhvSnVjVU5oTjVWU2R1cUw1RitwU1owdHlvNDlTY0hD?=
 =?iso-2022-jp?B?Zmpmci9KUStDZGVuN0VoZ2tyZmZlT0h6YlhUT2xObmdQWGVUTGlZc1pk?=
 =?iso-2022-jp?B?dlI1QUp3bFlvWlBGZ2RQUTNWWkhHcW44eHdhcWlsYUxmUVE0dlk5K1ZM?=
 =?iso-2022-jp?B?MmNWaE1OdnNIbnhPL2pXYXIvS2UwWGxTTTdoNU5vQTI3Z3dUNDFIU1B3?=
 =?iso-2022-jp?B?M3NLZGYzNXk1R3NnTkF3Z3IvdmpzeVdLVkhhS3BvbWdEUzQxMTFLTWpy?=
 =?iso-2022-jp?B?WjVJdmlNd2o0YlpYM1RKR1ZtNW9WQ0hYSUFnc1pOOFYrWkRZZE90VC81?=
 =?iso-2022-jp?B?OFYrYlNpTGJSaDVSN2E5R0RFM0tXeGJlejdwSG5jRFhGM2FLMkxUa0ZU?=
 =?iso-2022-jp?B?UXpmSWJIbFpHaS9tUE9ua2ZrVXZERTFRRlBsSEhqdzkwUWl2VHlhelk3?=
 =?iso-2022-jp?B?cVNCaVMxdE1YcGVQdmRjQ1pzbWg1SlpYODhuWXUvb3JCc0QrcWdIc09F?=
 =?iso-2022-jp?B?aUgyMGx2MElCTDNSa28wU01xaUJXbjdkRmF3Mkc2VjlWUERPd0hUM3hB?=
 =?iso-2022-jp?B?U2U3KzIwVWt3QUlHMXJsRkVXRndiMUN6SDB5N1VuYU1kUzlJdmFaU2RD?=
 =?iso-2022-jp?B?eTYvSEY0U0ZWaVlFazg1TjdKWEhSbXg1eEJXZU0rMWJXbU84eFFtVDdP?=
 =?iso-2022-jp?B?akRXcGFEbCt6QVl4dlNjSjMzSGRuR1FEWnlkTHZCdUo0OStKRnFvVnNH?=
 =?iso-2022-jp?B?bi90UTBxTXh1UEI5aEs0UCtzS2tlVmRNV1htVVhqK0Y4YmZtVGtZYUpM?=
 =?iso-2022-jp?B?K0lXMFR3dVk4RmdLcFAzcGZLajJ1eVo3Q2xFWFBaeWNXYzRYMWhBUlkw?=
 =?iso-2022-jp?B?Z0JIa0N6OTlSbjNqUHNIT0IyT21mMlhTTFNvdGN5cFZQMXNhd3RmUlRU?=
 =?iso-2022-jp?B?dmtVUkRpbjYrSDBtcWtyWk51ajBRRWN1M2M3YkxwT1FRTWlkWXpsYzhj?=
 =?iso-2022-jp?B?SGZqZkg1QUdyTzl5TUI2UnFVM05JekJYNFo=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7772.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(1580799027)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?dmhQRXVJNDRKRCt4d0F6ZjNscDBYcDlkTkZNNWpoSnhzY2pZdDJXRndz?=
 =?iso-2022-jp?B?eHBSaHgyNVl4TzhtaVUyckl2OFJ5ZFVHd0xYMFlXVDFlUFFnYTBlSCtB?=
 =?iso-2022-jp?B?cEZqTFpNYnIwZy81cWJFRzBwU2U3VHpaek1YOVlSMnYxdG9WMGcySDhI?=
 =?iso-2022-jp?B?Lzg2TndNQzMxcE1JeElmNTRnejJ6cWxCMGZkT1lyNU83bEhISWtpVHFV?=
 =?iso-2022-jp?B?U0NHclc1WHZzUE0ySTZTdnZrQkNjUSt1YThEcWRvZDdsbnVxSlJodW1a?=
 =?iso-2022-jp?B?YUF2UWN0SlJoaE5BT0UvT2NEZ2E5RmFvbDdaKzl5MFZiSHpzRmE1Lyt3?=
 =?iso-2022-jp?B?dGowaDVXUnN2bjlCZ2txZklmZnFDZmsvSXJaYStnK25KL1ArT0cxMDdT?=
 =?iso-2022-jp?B?dGlFVnQ3TzJhcFovaGkyeUhXK2dRSTdhU0JRNzhLWU85WjZFdTJwb0RS?=
 =?iso-2022-jp?B?bnJHZzYvSW41QUg2S1NpV250ZmhrK0FMV0xDZExoaG0zWGwxS2JmeWRD?=
 =?iso-2022-jp?B?S1NRMlBFTzdQb2YxcnFGU2pBck10SFNNUFFwWGxOL1FYZkNHald3aTYr?=
 =?iso-2022-jp?B?MzJxT2grUGMwY0txL2VBYXE1Y1NIOThGaFkwU3hHenFqaTRycTJLTlJ3?=
 =?iso-2022-jp?B?ai9EYUdZanBhcGg1d0Q1Z29XaGRFeFdrS0kvY0pnWlZIcDBZcUpoaE5D?=
 =?iso-2022-jp?B?SndzeGFFQWNTNFkzTnRxUHJTL0Z5WVZkTi9oWjFnZmlJNHZGYTdNTndS?=
 =?iso-2022-jp?B?Y0wya0oxMkVtNkpIc0NLbVJGOUZuemtoVzZ4K2JrTTFiaUdwb0JiUTI5?=
 =?iso-2022-jp?B?UmJTOXNzRVc5N1A5TXpPbUVhT3lpRVJ4eEg4b0FBYlMvVnprendjdnEw?=
 =?iso-2022-jp?B?YnRmT0JFVis0eE5oUmM2QWswOGJVQzk0bGFuSGxTUXBmRWkvc09ZOTIv?=
 =?iso-2022-jp?B?cmk0aWxvY0ZTcklmelhXbmtGSWxQVDRZRFA4Vy9tSG9BNGVNS09mTE9I?=
 =?iso-2022-jp?B?Rnd4WnNPeE9mZUI3RStrTm5yOEhvY3VVcXFvRjBkY3d1OFhYVUFVTVZH?=
 =?iso-2022-jp?B?ZHc2TVN6ZkRsaG5uYW5KakErczVmd1A5SVJLaFEva1Z6dHBrUEtWQjVu?=
 =?iso-2022-jp?B?NlZlOFdHa3lOS21GVDdXUytaeHR6bFhYZmRSLzNxbUNMcHdVTmQzazVo?=
 =?iso-2022-jp?B?MnlGMFFYbWhlTEp1YkZxbU1HaFg5ZlRSNmZRZm9DQ2RKSlBZcEF1OXBD?=
 =?iso-2022-jp?B?T09FTTVwU3VXbTJBcUJ3bzcwUVRvK2RXeGJqWUthVHh3M3VDRE1mVlJR?=
 =?iso-2022-jp?B?clp3RkZId2VoYVNzTDA2ejNhVlN4dFlaVlBWTTd1aVNZT0RKcklYQnNn?=
 =?iso-2022-jp?B?WUIwelR4MXZiOHVYRDFpcVM3ODg0L2s4SFNqRDIxa0RPU2J6TWNBMjEz?=
 =?iso-2022-jp?B?em9ZTlJrNmtxWTBtNUkyMTNVTTR5cnRYOHphNkFWNjU2VWt2MGxKNkRC?=
 =?iso-2022-jp?B?WGFLeWZMZFNKcUFRbVFWSnhiQTBLT0EzOHFVd3lET0dNWXpGeEZqVjV2?=
 =?iso-2022-jp?B?VUVIdlFTNUFIL3NTcWlhbmR6emR2ZHQ3Zm1EeDJrbnl0Vi90VWROWUdZ?=
 =?iso-2022-jp?B?YTAvSlJ3OGNuZXdldVlrUU5kSzZ0NS9pcmRBaU94QUk2QTNVdjA1bVBM?=
 =?iso-2022-jp?B?MjQ1dkx0di9maWp4S2k0Ny85ck9vUTR1M3l5dVhiY3Z0K003Tml6M2Zo?=
 =?iso-2022-jp?B?MzdTUEJoa0JNamFPWlBMU1IxR2hQZWUrbVdWWVBDUVh0a242dUdqU2cv?=
 =?iso-2022-jp?B?YW5ubTliNHdxVjlKeHNXT0pnYi83dlhHdzNJaHRSZEFxNjRQdWhkM2cy?=
 =?iso-2022-jp?B?anNRS0lZMU0zNVBoRUtNMURSWG9pallsV05hK25aSDZhK0hRTzRSOTlh?=
 =?iso-2022-jp?B?b0wwdjVobkpMdytHTytKS3ExVXMxRWM2TnBuV2NLVlVkL1pzV2VaY040?=
 =?iso-2022-jp?B?V2tLSlgrZmpQd3ErTlVkZDR2T2FYSWl6S21vaUpkUVJ3Q29mRC94MEFo?=
 =?iso-2022-jp?B?ajZ4a2JWUzJWZFU4aWJpNXE0b2lOUzREaFpKL0R2bDRjeHJtS01PWnFh?=
 =?iso-2022-jp?B?TCtMMHJWUFV2UnV5VHNieUhMcktab3VUMGZOV29GUFppejlneG9UZndv?=
 =?iso-2022-jp?B?SlNobUs1SnZ5Q0JBemovVFFpR1psaTh1S21TMUVlMUhxa1ZWd3d4Sy9H?=
 =?iso-2022-jp?B?M2d0NlhOTzg4SDJJWlBYZjhGVWlUV0Z5M3RUc1I2UlZ2M2FMOHpvdytu?=
 =?iso-2022-jp?B?c25FM1dxayt6M3BjS0JMSFVoY2VsdVZ3UHlMdjVvaGFVUHNkVm1IM3ZP?=
 =?iso-2022-jp?B?MUpodEFOR1ZiS0swSGh2R3hPZ0s2RExEM1U0QWUyc2tCZWN0QjE4b3pz?=
 =?iso-2022-jp?B?N2s5U0RuN082cHRYYXNlWllCK0NRTW5sZzN5c09BNHBSUzc5T1JTbmpq?=
 =?iso-2022-jp?B?ek4wUDVpcnY2YUovYitHN3NJNFEvck9qK1FaUT09?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7772.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e85b9556-d145-4ec8-0263-08de5f138e26
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2026 08:51:12.6532
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fXqiWkbLCwc2KyCUZKG/FW6I/DB88N163n7Vy5vgx28EHgfnbtfSHNgyvWxd/YSDQoCscnB6dipYhIlb3XC/QEOdHcWIPWrOI0x2AIwqBEo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB15165
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[fujitsu.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[fujitsu.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18599-lists,linux-nfs=lfdr.de];
	TO_DN_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	DKIM_TRACE(0.00)[fujitsu.com:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[s.ikarashi@fujitsu.com,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-nfs];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C1670ADC11
X-Rspamd-Action: no action

Signed-off-by: Seiichi Ikarashi <s.ikarashi@fujitsu.com>
---
 utils/mountd/mountd.man | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/utils/mountd/mountd.man b/utils/mountd/mountd.man
index a206a3e2..d14c7697 100644
--- a/utils/mountd/mountd.man
+++ b/utils/mountd/mountd.man
@@ -55,7 +55,7 @@ The
 daemon registers every successful MNT request by adding an entry to the
 .I /var/lib/nfs/rmtab
 file.
-When receivng a UMNT request from an NFS client,
+When receiving a UMNT request from an NFS client,
 .B rpc.mountd
 simply removes the matching entry from
 .IR /var/lib/nfs/rmtab ,
--=20
2.47.3


