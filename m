Return-Path: <linux-nfs+bounces-3246-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 192578C3B58
	for <lists+linux-nfs@lfdr.de>; Mon, 13 May 2024 08:31:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 249E01C20EE0
	for <lists+linux-nfs@lfdr.de>; Mon, 13 May 2024 06:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A100C14295;
	Mon, 13 May 2024 06:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="U/ZdHFDZ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2115.outbound.protection.outlook.com [40.107.94.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDC88468
	for <linux-nfs@vger.kernel.org>; Mon, 13 May 2024 06:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715581883; cv=fail; b=N/7v+S+Nqri1JyqY4hHjXPSkiTkRAqopPLPzOZlOckNlwyNHpGLUlTFY0SwnonPuPyjPxhUw3wzirvBR+pTuXAlsNhnUwSmcCHGGnXIEunv073/TUiMMxzToWjIOe0gDhFzc3HYQ+h8J24etM2wgjSEmtp/KEQzgpMDNVr/5NGs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715581883; c=relaxed/simple;
	bh=IJD6oosUIF5h9nL+rj9qedoPeof8PELX6l1rF7mbTZc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tZNmeud2umFW41IQCf+rSKVyiM9p7is6TmSIdILvo7POBog6r4dfcdHp4US275BhcQfBDGMPbVxvnvW/Ppr8QX46iXqPhsE30NmndCpVndDaw4ytita/JSdKORRV+ekI5XSASGuEK2TwRUU8V9XYWyb9LNYA6ufONRPUw+XOgtY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=U/ZdHFDZ; arc=fail smtp.client-ip=40.107.94.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WCK0WN55EidpoBEKIOV6EuCmFMcl3B7vC4hqFGLfjPpg4pbIQN6r4gZvv7zJy8TtunndJyK3lfgiydpLwJAC0rFfLYKLzNgABvLV6xX4S2Eslcvf7fNWNu+Zf1TXUjttoD7M/rMcJQGr161XpH7inFX6RnMuBMnAoGZt8carX84y7maFAdUALXtq9fGiW1gKxUzP8R0xSibSOPW8zHRbpn3wHGHlWV86Gq6vP0FkFQHethnjHn54cVoomqwcLRucbu/1pD8AVJPRB1pkoJdd7icToAMn4GmYupt1xLH+S9cAYV9fv03qSA6ceTUVWGks82vefjEwh/w3mcC11UvJgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IJD6oosUIF5h9nL+rj9qedoPeof8PELX6l1rF7mbTZc=;
 b=e5E8ixIRXCQKcSM+JFMj/NtGDdusOFrO78m/Cnwp1bxeUkxraaSqwGtp6qSwF/5Wiu2+fNEOfyWHsdZos5cIlb/zdePZWR+tG6syYQc/773MdFa3tUKsTfgg+C9ySYGUa3qUCeDNdp5VWps3Sh5ZLxlwcFnBrfoPDwNVIe87MRL/TILtsHSe09H4mEq2pCeGF6teZyr1KCSLrgZdpbZ24E4KFcZggqdF0gTVlhELs2QhkRlKgtZSouw84rh8oRY4lE1MG2O36mnzJFyJq05YCyjiyHsct3pl7fL/XuGzeAFzM1+OqG2Kx9psiLB+TlNVhxM/GD5Kbw1WuQZoeyONuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IJD6oosUIF5h9nL+rj9qedoPeof8PELX6l1rF7mbTZc=;
 b=U/ZdHFDZCV4mFiTPYxO4czD/yrsDKSWa21ekNvLMO4O0u0GiqC3YD2co74vzD+qRunZASyqRv2zI0iCEw81ijvTZZ5GgenpIwaXXHYvwCacyJ56tw8deewbL2wfrY3x5Vo3InaBTBfN6SCIJUK8AXx8a7YkKGRMsrPT7glD86eg=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by DM4PR13MB5884.namprd13.prod.outlook.com (2603:10b6:8:4f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.22; Mon, 13 May
 2024 06:31:18 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb%5]) with mapi id 15.20.7587.021; Mon, 13 May 2024
 06:31:18 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "tom@talpey.com" <tom@talpey.com>, "kolga@netapp.com" <kolga@netapp.com>,
	"Dai.Ngo@oracle.com" <Dai.Ngo@oracle.com>, "jlayton@kernel.org"
	<jlayton@kernel.org>, "neilb@suse.de" <neilb@suse.de>,
	"chuck.lever@oracle.com" <chuck.lever@oracle.com>
CC: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	"stephen.smalley.work@gmail.com" <stephen.smalley.work@gmail.com>
Subject: Re: [PATCH] nfsd: change nfsd_create_setattr() to call nfsd_setattr()
 unconditionally
Thread-Topic: [PATCH] nfsd: change nfsd_create_setattr() to call
 nfsd_setattr() unconditionally
Thread-Index: AQHapPhurPJZuWgfO0CVLV8p2n10WLGUtF8A
Date: Mon, 13 May 2024 06:31:17 +0000
Message-ID: <524c5483b996e0cc4879f348f3c8a5aa77390821.camel@hammerspace.com>
References: <171557896893.4857.2572536847924540881@noble.neil.brown.name>
In-Reply-To: <171557896893.4857.2572536847924540881@noble.neil.brown.name>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|DM4PR13MB5884:EE_
x-ms-office365-filtering-correlation-id: 87a0bf97-e3f1-4bde-b1bf-08dc73164bdd
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?WkFFd3hacVloa29ZZTFraWRaelB6SzZ5QkVkRllhWE9ueW5BTEc1VHZObkdk?=
 =?utf-8?B?QXhGTjRjTDRhN0Z4RWtKbEErOXdXMGZpbG1RTDdkYU9EYkNGWjQ0bytuTkZU?=
 =?utf-8?B?TW9ZNWFZUjlWdGdwTmpXQnJ3SXZmbUpZSWJIcFdUQU55TzlZWkNZZDkwMmNL?=
 =?utf-8?B?MkdnVDhVbVh2aWs1SFUxalNqaHpOa3NEMlo1aU40bWlxcjU1Z2pseGdvVi8v?=
 =?utf-8?B?ZXFvY3lWSVFOTFRTdEdKck8zZnoxQ1o5eXlmaDBlOTZyM0pUTHZsS3NGMldC?=
 =?utf-8?B?NmNqelVqMU5vQStsSmlQcVE1b3I1VTgrbmdGOGMxd3Y0YmJxYjFqMmlqYXRC?=
 =?utf-8?B?aEZwL1MraEo5ckhDT21oV1RIVmsrNUlwc1BHLzhOM3ZWVzhwbSs3MDQyTVRm?=
 =?utf-8?B?em5WWE10UjE1czNrSnExRkxucWRaVUxGVVNobHVVdHNtaTJyYjUxK01ZM1g1?=
 =?utf-8?B?UzhqRVI1MkZ4S3NmbjIvU0RZM0pWSXQ1cGNEOTlWL1Y4ZkhLdFU3aS9pSlBV?=
 =?utf-8?B?N3pHUmliUUFiYmVIU3NaOWc4UFMyREZ0bFlUSGJ3dmtHVHE0U2V5Vk9vYWtC?=
 =?utf-8?B?K0RwczJkdkx1dzBFMXNwOUJJV0VxSHh2WEc2bkFGNVRSSklacyt4SjRSeVJL?=
 =?utf-8?B?Q05FVEZPc3NZY3pNNWMwelJjM2YxSTd6dGRtYlE2REkrYi9HS1dKa0JOcElG?=
 =?utf-8?B?ZlhXRDk3UTJVQ0xDeklGdFp1MzY0ZzUxWGUyYk5PWVFzUS9BTW5mTTN6QUJP?=
 =?utf-8?B?enppQUlhcS9nYm53bU5BT2hBWW5ZSGR6RjJHZnA3REdSWXlMbzBsbUVsTk9V?=
 =?utf-8?B?ejQrY3h5Zkh6Y3lVaFdhNFhvNGFQU1lJZk9RRndJR0JZQi9NQ2NsWkNxVjBv?=
 =?utf-8?B?U29FNzlUa2ZpbUJ5elpOMUpvc1NHWEsveWZvSWNvUEltYkdQc2ZkalhvY3hX?=
 =?utf-8?B?bmxVZk1xa3VNZWVxaEsySzBGK3FlSjgvYlhrSU9uYllOMDRIUVQ5RzYvNEdB?=
 =?utf-8?B?VEE1ekFMR3BwSjNhNmdCRGk4Mmo0R3FCWnlwcmttMkxZSUxyTWtJR0x0M3Ny?=
 =?utf-8?B?UHg2cFM2aGo4STIxSTVXaGJlOUpsSjNTUUJPNU1hUDA2ZkJpbjdXRjJRa3VU?=
 =?utf-8?B?dlUvVVpBY0cvd3ZMb1NVL3RBMG1zcTNGT0kxVnhMU0pMd3E1MFRFOVczRVFi?=
 =?utf-8?B?WS9tYUFPdnpZanVxWFlHdXpYRjdQaXo5MmlWYTdhenlVTllrcnNoZzFMVkRE?=
 =?utf-8?B?RGFOdmUvTCs5Sk8zSklvc1k1bldIRDFacmlJKzZIMUxOa2FXRVpYbXV3ckxv?=
 =?utf-8?B?VERycDhXUC9HSkQ1Y1BDaGkwbE1CT1RzZ2xMS2Yrd3M2VFU2NnRtQVNBMmcz?=
 =?utf-8?B?aXlPUnBkaFRlTlE0Y1lqcXBraCtiK3AxUkhxMEpQc2pjMGw1UWxkNW81bUxC?=
 =?utf-8?B?VisrRzZaSDNTdWRXb2ZGTzBpWVB6WWRuVHQ4bHdaZWhCNm5CL2hlRDk4Z0cv?=
 =?utf-8?B?dnN3SVpKd24zZUYveWtNUjZoRVNJcUhBRmJZbjhwWmR6aEFrT1ZJUDEvYVMv?=
 =?utf-8?B?OHVsd2VudlM3ekhPOXpmNkhONlFqS1p4TDRNK080YnZyUkpnZm9UcEV0UnFM?=
 =?utf-8?B?ajByYWZXbG5kdUNNQXpIUDdBSSt5L1N5OXUvdUllWkVoTm1Xd1EydC9rUVN1?=
 =?utf-8?B?aXRPamNnR3NDWFB0ajJSUHd3bFRFb1ZyK2o2Y09UanV6MkIxS2FVa1pTWldQ?=
 =?utf-8?B?OGZFRXQ5U0RiNDNacFNEUmZjMW01WVVyYSsrRm10dVF1SUlrMG5zZGdndHZ3?=
 =?utf-8?B?akNwY0MySHVORFdoYVluQT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MmpIbnFyRHNxZk1CZ040ZFdMN3pmNVRmc3NrQVFmLzRZVlRYRXp4SEszd2tV?=
 =?utf-8?B?Zkc3VkIzU0RXbjB3T2FJVU1ZTWxta29SUWZHaE9xeTdNZDcrUnc2ZGZHUUxZ?=
 =?utf-8?B?alo2SHIrZVNjQ2ZIQzczRmltTXoxY0xHUUt5TC9aVWhPazQwQ3AyQ3RpU01N?=
 =?utf-8?B?c2RlTVpuQW9RZ3ZhYk5IajN6cENtNWxiVFh6eitUMUUzdnFIbGg2MkdOUnA1?=
 =?utf-8?B?QnpUSWN3NlRpbkMrUVd4eXp1S0psVFozVTM4RmVBb3d5Zi9iWXZCOUV2eFFm?=
 =?utf-8?B?b21BbCsyN3VHandPMk42b3MrVjNFdkJpRElNcG1tMjFqbjd6SFlsSDJTSEpu?=
 =?utf-8?B?aXRuTTRaT1JGMUcrTjFZSDhBbXNXWVFQMjZCYWx3cHBocTdaOFdyeG1yK212?=
 =?utf-8?B?VVNrM3M0MUpzUm9Ud0NDNlJZMXpFMzlEUVY5Qk5ZT0IwWEpsSlh5Nys0Y2hL?=
 =?utf-8?B?UkRFeVBpRUg5TXdabmF5UWJOSGJxdjVjUWdtaE5BQVVSNVZnN3JNNklPbk40?=
 =?utf-8?B?L3ozOS9URzJuQnlhQ2ZRRHJoN1BJYk1tMWNKZWFlK3lHVkNFeVZ5QmwwOU02?=
 =?utf-8?B?dWd0NDUwTm1FLzlvd2pLcDFRVG4xNGswckxQSkhrNE9CY005QlRTbEhLWlRy?=
 =?utf-8?B?a08wZCs3NFgyM0labTd4VkdsZmNFYVVBZlBhM0c2WWpvTmJBUmMway9neFhr?=
 =?utf-8?B?ZWZaZEE1MVk2cEpEdGQ4V01UZnQvRjRNc0NHSEwxa0RWY3pWYjBPYlRscktB?=
 =?utf-8?B?alEwcjdQN2ZiR1pHT0xITFlUZDdtbUJRanAzbXhTdncyWndEWGtnSFNLMXF1?=
 =?utf-8?B?RkxDRENKbEpvMHdsV1k4ZHIrR2pYclVZWXQzZHBHM2xmTFI0UHU1M2FQd24x?=
 =?utf-8?B?K2p3NGx5STRIa3hScW5xV1daTUNJNGt1ZmYydVFhY1VRRU40dkwzMGRxZnhr?=
 =?utf-8?B?UnhZSFlNcWhGdXkxY3REWklwN2hsWmU2VmVHU29JY0V2MnF5UG1VTTBuaXFw?=
 =?utf-8?B?Z3IvMVo5WU9mcnVsb0ZuS1RPVlNlZ0FNS3hoaXN1VUFtYWd2MXlBdUVMSzJG?=
 =?utf-8?B?aXNYMXlxRmZ3OFROcklBaU5UVHVOODFkVktYN0lmYStaN3ZRTHlKanBkM1dG?=
 =?utf-8?B?WnF3c1o3TU03YUdhKzFQR2U2RmVFcjNjS0lYYzBMcnpkbWQ1TVQ4Q05lRE5N?=
 =?utf-8?B?T2tCeitIeTFWN0J6dXpWcWlEL1dlbnE5cFFrZnpsZDZzTnJnNEZVRFF1N2tT?=
 =?utf-8?B?SHMyL2R2a0x0ZkFWLzVpUmQvWjN2QU4rWWNjem0yZ1Z1TWNkU3RaU0dvNTU3?=
 =?utf-8?B?bzNEUThRSnQ0TU1OMnpvR2JIVzhqZkd3WHNVSVVtZFQrcDkraERjZVc3UVN2?=
 =?utf-8?B?b2sxS3ZzQ2ozNldIVlVJMUZBWHQ5V1k3WVhnNmMxOVNERDcvQnlRUTdQRVB6?=
 =?utf-8?B?d1BNWW8zUUZRUUhrY3hvczluLzVZd0t2a3VVUUlnMkZjU3lFNVVNSmx0ckpG?=
 =?utf-8?B?NzV3ZS91eHBVdEpBd1NVMVhncVNSMlB0TER1L3kycTRPQ1RZSCtCSlphNXM2?=
 =?utf-8?B?MVNocCtVUlhoamxONC9NNDhlOEs1M080cjZmbUcrWkRYQWQybkFuTVByWkFn?=
 =?utf-8?B?blJjVVZHeUZ5cm0rL2FKcS9sdWFxKzBmVTE3YklKZmd0d2RKRXBQd3Q1UGRY?=
 =?utf-8?B?TmZvNlNCRTJJLzJnSnNhMENjVWJ6Ri9GaFhuS3cwakFUYnZoTGhTSDZ6bi9C?=
 =?utf-8?B?MXNDWE1rMGtVK0l2UndGSXF1V2JTeEhDTE15RWFSK2pyK1k4T3B4VmxqVk1H?=
 =?utf-8?B?WjZ4NGZ3WlMvWU5IZXkxVm5JRXBxa09MdVBsMXFheDVhUXlidnpabnhoSlhE?=
 =?utf-8?B?anpxeEgvZXp6dk1NZFR4Yzg0K202QjJsSmNtaVhmRitlMXBDUFp6amZkVzY3?=
 =?utf-8?B?RElnTVJocFkrSHFjUHNNUmNrdURBbUN5VXExdlh2UzlEV2NJR1Y4WWJwYWtr?=
 =?utf-8?B?U2FjZDE3OEU2S2h4MzVpYys4UmVXVGhLWmJ2Q0JSNmVuOWRUMFByTkw1aUpT?=
 =?utf-8?B?eE9PeTl2bEhjRU1aOGs2YTI1K0J0TVR1OStpeFp2RDFxWkR0eGFrSHFSVDlx?=
 =?utf-8?B?UVF1NVVjMVlOdjM0YzA0ck1qL2dBVWYzekFMamJvNllDbWpXd0VPMmxMeStR?=
 =?utf-8?B?N0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1CAE59C2730C1645A87DDCABBCFE988D@namprd13.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 87a0bf97-e3f1-4bde-b1bf-08dc73164bdd
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2024 06:31:17.8777
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: APfXv4cMX4SbsPA/4m5EX1hevSIqWsrizTkfzq/vPDFPphrMZcrIsp4M9+5aAapNVky2YZy26djSwVQI+aSSsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR13MB5884

T24gTW9uLCAyMDI0LTA1LTEzIGF0IDE1OjQyICsxMDAwLCBOZWlsQnJvd24gd3JvdGU6DQo+IA0K
PiBBIHJlY2VudCBjaGFuZ2UgaW1wcm92ZWQgdGhlIGd1YXJkIG9uIGNhbGxpbmcgbmZzZF9zZXRh
dHRyKCkgZnJvbQ0KPiBuZnNkX2NyZWF0ZV9zZXRhdHRyKCkgc28gdGhhdCBpdCBjb3VsZCBiZSBj
YWxsZWQgZXZlbiBpZiBpYV92YWxpZCB3YXMNCj4gemVybyAtIGlmIHRoZXJlIHdhcyBhIHNlY3Vy
aXR5IGxhYmVsIHRoYXQgbmVlZGVkIHRvIGJlIHNldC4NCj4gDQo+IFVuZm9ydHVuYXRlbHkgdGhp
cyBpcyBub3Qgc3VmZmljaWVudCBhcyB0aGVyZSBjb3VsZCBiZSBhbiBBQ0wgdGhhdA0KPiBuZWVk
cw0KPiB0byBiZSBzZXQuwqAgTW9zdCBsaWtlbHkgaW4gdGhpcyBjYXNlIHRoZXJlIHdvdWxkIGFs
c28gYmUgbW9kZSBiaXRzIHNvDQo+IC0+aWFfdmFsaWQgd291bGQgbm90IGJlIHplcm8sIGJ1dCBp
dCBpc24ndCBzYWZlIHRvIGRlcGVuZCBvbiB0aGF0Lg0KPiANCj4gUmF0aGVyIHRoYW4gbWFraW5n
IG5mc2RfYXR0cnNfdmFsaWQoKSBtb3JlIGNvbXBsZXRlLCB0aGlzIHBhdGNoDQo+IHJlbW92ZXMN
Cj4gaXQgYW5kIHBsYWNlcyB0aGUgY29kZSBpbi1saW5lIGF0IHRoZSB0b3Agb2YgbmZzZF9zZXRh
dHRyKCkuwqAgSWYNCj4gdGhlcmUNCj4gaXMgbm90aGluZyB0byBiZSBzZXQsIHRoYXQgZnVuY3Rp
b24gbm93IHNob3J0LWNpcmN1aXRzIHRvIHRoZSBlbmQNCj4gd2hlcmUNCj4gY29tbWl0X21ldGFk
YXRhKCkgaXMgY2FsbGVkLg0KPiANCj4gV2l0aCB0aGlzIGNoYW5nZSBpdCBpcyBhcHByb3ByaWF0
ZSB0byBjYWxsIG5mc2Rfc2V0YXR0cigpDQo+IHVuY29uZGl0aW9uYWxseS4NCj4gDQo+IFJlcG9y
dGVkLWJ5OiBTdGVwaGVuIFNtYWxsZXkgPHN0ZXBoZW4uc21hbGxleS53b3JrQGdtYWlsLmNvbT4N
Cj4gU2lnbmVkLW9mZi1ieTogTmVpbEJyb3duIDxuZWlsYkBzdXNlLmRlPg0KPiAtLS0NCj4gwqBm
cy9uZnNkL3Zmcy5jIHwgMTcgKysrKysrKysrLS0tLS0tLS0NCj4gwqBmcy9uZnNkL3Zmcy5oIHzC
oCA4IC0tLS0tLS0tDQo+IMKgMiBmaWxlcyBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKyksIDE2IGRl
bGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2ZzL25mc2QvdmZzLmMgYi9mcy9uZnNkL3Zm
cy5jDQo+IGluZGV4IDI5YjFmMzYxMzgwMC4uZTYzZjg3MDY5NmFkIDEwMDY0NA0KPiAtLS0gYS9m
cy9uZnNkL3Zmcy5jDQo+ICsrKyBiL2ZzL25mc2QvdmZzLmMNCj4gQEAgLTQ5OSw2ICs0OTksMTQg
QEAgbmZzZF9zZXRhdHRyKHN0cnVjdCBzdmNfcnFzdCAqcnFzdHAsIHN0cnVjdA0KPiBzdmNfZmgg
KmZocCwNCj4gwqAJYm9vbAkJc2l6ZV9jaGFuZ2UgPSAoaWFwLT5pYV92YWxpZCAmIEFUVFJfU0la
RSk7DQo+IMKgCWludAkJcmV0cmllczsNCj4gwqANCj4gKwlpZiAoIShpYXAtPmlhX3ZhbGlkIHx8
DQo+ICsJwqDCoMKgwqDCoCAoYXR0ci0+bmFfc2VjbGFiZWwgJiYgYXR0ci0+bmFfc2VjbGFiZWwt
PmxlbikgfHwNCj4gKwnCoMKgwqDCoMKgIChJU19FTkFCTEVEKENPTkZJR19GU19QT1NJWF9BQ0wp
ICYmIGF0dHItPm5hX3BhY2wpIHx8DQo+ICsJwqDCoMKgwqDCoCAoSVNfRU5BQkxFRChDT05GSUdf
RlNfUE9TSVhfQUNMKSAmJg0KPiArCcKgwqDCoMKgwqDCoCAhYXR0ci0+bmFfYWNsZXJyICYmIGF0
dHItPm5hX2RwYWNsICYmIFNfSVNESVIoaW5vZGUtDQo+ID5pX21vZGUpKSkpDQo+ICsJCS8qIERv
bid0IGJvdGhlciB3aXRoIGlub2RlX2xvY2soKSAqLw0KPiArCQlnb3RvIG91dDsNCg0KSG1tLi4u
IFdpdGggTkZTdjQgYmVpbmcgb25lIG9mIHRoZSBmaWxlc3lzdGVtcyB0aGF0IGNhbiBub3cgYmUg
cmUtDQpleHBvcnRlZCBieSBrbmZzZCwgSSBmZWVsIHNvbWV3aGF0IHF1ZWFzeSB3aGVuIEkgc2Vl
IFBPU0lYIGFjbC1zcGVjaWZpYw0KY29kZSBiZWluZyBhZGRlZCB0byBhIGdlbmVyaWMgZnVuY3Rp
b24uIFdlJ2xsIHdhbnQgdG8gcHVzaCBpdCBkb3duDQpjbG9zZXIgdG8gdGhlIGZpbGVzeXN0ZW0t
c3BlY2lmaWMgY29kZSB3aGVuIHdlIGZpeCByZS1leHBvcnRpbmcuDQoNClNvIGNhbiB3ZSBwbGVh
c2UgcHV0IHRoYXQsIGF0IGxlYXN0LCBpbiBpdHMgb3duIGZ1bmN0aW9uPw0KDQo+ICsNCj4gwqAJ
aWYgKGlhcC0+aWFfdmFsaWQgJiBBVFRSX1NJWkUpIHsNCj4gwqAJCWFjY21vZGUgfD0gTkZTRF9N
QVlfV1JJVEV8TkZTRF9NQVlfT1dORVJfT1ZFUlJJREU7DQo+IMKgCQlmdHlwZSA9IFNfSUZSRUc7
DQo+IEBAIC0xNDE4LDE0ICsxNDI2LDcgQEAgbmZzZF9jcmVhdGVfc2V0YXR0cihzdHJ1Y3Qgc3Zj
X3Jxc3QgKnJxc3RwLA0KPiBzdHJ1Y3Qgc3ZjX2ZoICpmaHAsDQo+IMKgCWlmICghdWlkX2VxKGN1
cnJlbnRfZnN1aWQoKSwgR0xPQkFMX1JPT1RfVUlEKSkNCj4gwqAJCWlhcC0+aWFfdmFsaWQgJj0g
fihBVFRSX1VJRHxBVFRSX0dJRCk7DQo+IMKgDQo+IC0JLyoNCj4gLQkgKiBDYWxsZXJzIGV4cGVj
dCBuZXcgZmlsZSBtZXRhZGF0YSB0byBiZSBjb21taXR0ZWQgZXZlbg0KPiAtCSAqIGlmIHRoZSBh
dHRyaWJ1dGVzIGhhdmUgbm90IGNoYW5nZWQuDQo+IC0JICovDQo+IC0JaWYgKG5mc2RfYXR0cnNf
dmFsaWQoYXR0cnMpKQ0KPiAtCQlzdGF0dXMgPSBuZnNkX3NldGF0dHIocnFzdHAsIHJlc2ZocCwg
YXR0cnMsIE5VTEwpOw0KPiAtCWVsc2UNCj4gLQkJc3RhdHVzID0gbmZzZXJybm8oY29tbWl0X21l
dGFkYXRhKHJlc2ZocCkpOw0KPiArCXN0YXR1cyA9IG5mc2Rfc2V0YXR0cihycXN0cCwgcmVzZmhw
LCBhdHRycywgTlVMTCk7DQo+IMKgDQo+IMKgCS8qDQo+IMKgCSAqIFRyYW5zYWN0aW9uYWwgZmls
ZXN5c3RlbXMgaGFkIGEgY2hhbmNlIHRvIGNvbW1pdCBjaGFuZ2VzDQo+IGRpZmYgLS1naXQgYS9m
cy9uZnNkL3Zmcy5oIGIvZnMvbmZzZC92ZnMuaA0KPiBpbmRleCA1N2NkNzAwNjIwNDguLmM2MGZk
YjYyMDBmZCAxMDA2NDQNCj4gLS0tIGEvZnMvbmZzZC92ZnMuaA0KPiArKysgYi9mcy9uZnNkL3Zm
cy5oDQo+IEBAIC02MCwxNCArNjAsNiBAQCBzdGF0aWMgaW5saW5lIHZvaWQgbmZzZF9hdHRyc19m
cmVlKHN0cnVjdA0KPiBuZnNkX2F0dHJzICphdHRycykNCj4gwqAJcG9zaXhfYWNsX3JlbGVhc2Uo
YXR0cnMtPm5hX2RwYWNsKTsNCj4gwqB9DQo+IMKgDQo+IC1zdGF0aWMgaW5saW5lIGJvb2wgbmZz
ZF9hdHRyc192YWxpZChzdHJ1Y3QgbmZzZF9hdHRycyAqYXR0cnMpDQo+IC17DQo+IC0Jc3RydWN0
IGlhdHRyICppYXAgPSBhdHRycy0+bmFfaWF0dHI7DQo+IC0NCj4gLQlyZXR1cm4gKGlhcC0+aWFf
dmFsaWQgfHwgKGF0dHJzLT5uYV9zZWNsYWJlbCAmJg0KPiAtCQlhdHRycy0+bmFfc2VjbGFiZWwt
PmxlbikpOw0KPiAtfQ0KPiAtDQo+IMKgX19iZTMyCQluZnNlcnJubyAoaW50IGVycm5vKTsNCj4g
wqBpbnQJCW5mc2RfY3Jvc3NfbW50KHN0cnVjdCBzdmNfcnFzdCAqcnFzdHAsIHN0cnVjdCBkZW50
cnkNCj4gKipkcHAsDQo+IMKgCQnCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3RydWN0
IHN2Y19leHBvcnQgKipleHBwKTsNCg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBj
bGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFj
ZS5jb20NCg0KDQo=

