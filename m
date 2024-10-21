Return-Path: <linux-nfs+bounces-7336-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A6F69A6C76
	for <lists+linux-nfs@lfdr.de>; Mon, 21 Oct 2024 16:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA073282412
	for <lists+linux-nfs@lfdr.de>; Mon, 21 Oct 2024 14:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D7931B59A;
	Mon, 21 Oct 2024 14:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jCkF8tXo";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="BgwOK+mI"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053B433F7
	for <linux-nfs@vger.kernel.org>; Mon, 21 Oct 2024 14:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729521949; cv=fail; b=GKcILnHpTxOpJ5NRhCGMhGvcAw0x4aInSbFpDuRMVtVYfOMAXVLdb1qblArPj6X2Tm8Xb2u3avmvTULu/CTIDvmIALar0FFCw/jfrGWXygWNwV/TLUiW7aWROuFwEJwndWnXBijvmr2xNE9IWYTzVE2SefOA+OIypJQYaYPvzpw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729521949; c=relaxed/simple;
	bh=TiuCWSctJS7LPXQNQLTcqV6OeAzJMY9wBotAlC+hfto=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nsdiGvzDygg3d8PI700crwR7TGfGLeAjtH7WJ1GKG60lmTeGFgl1reSRujOM6Ryn9eXFoSJBs4awOTg8DNF7/Wl7P076m9kX0yKYx+OC1TlG4EPaiLPth00WfAUI8bw3ZM03+zJAp3nK0e688YAQf0LqPztZSAHJgTLI/8EwCDI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jCkF8tXo; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=BgwOK+mI; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49L96dwO026537;
	Mon, 21 Oct 2024 14:45:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=TiuCWSctJS7LPXQNQLTcqV6OeAzJMY9wBotAlC+hfto=; b=
	jCkF8tXoQUkSLNcwmUoc4tkA2Kl4PhTNKBmg0wd72PXEhtZCgJEc2d9UYWnqccjk
	Kizmd0Gqn7DvUScshwcFb5SwhPyzknNFnCAoWaoh+aOHEAQQOUt/DPkRQyGdUafy
	hJ/bpj+kT6THk7+58vF/uHnpJnjXgXZO9WPQGI08f+vdHeWdv6Z9JDzsZPMhwPXT
	ATLWdoxGJWxt8Pl+kqYXParsisWz5Yo3NYEkAeEGH0e9yc4T5AJ1rU2dn6vRuDkh
	uRAAVWdHrdAmEboBjfby5UiUycOJUMHBDfiM/XxA/mPmnQvWYLYRVGTe32ts5Nxy
	TU8lYuds4gJlyUpaPx+2Sw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c55eb8x9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Oct 2024 14:45:42 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49LEclZh019639;
	Mon, 21 Oct 2024 14:45:40 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2044.outbound.protection.outlook.com [104.47.58.44])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42c37cja48-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Oct 2024 14:45:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yzHNH+z20WHaFvynpx2JdrMmRNbf//Vx0rThbIq26OT5K3LK6oIvBzfzG9ahbgafA1z30wg9Os9tOhPxAd1i4HE/vgSvntWzWj0Acd/KgK8sz946H2dlcvoMPuL+GM1ID/NJ15QuWDZc/VBjW2CdoEAyBp5Oju9qLz45+V03yWCoq/wTrD6/6CW0kng37gAkny/tFWDipAd2qH8VEM6suTvP/mHggyfYyUh9FO2OAcBreZ89AYYju73RpBy2CbXp0MRbOHWm57e26Tc/49kFkdJokbW3AIkECB5fQg8yDhh1EXxtxdolzcZD9JHbEAB8Tzl1UkSYEXUvx5M73sVomQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TiuCWSctJS7LPXQNQLTcqV6OeAzJMY9wBotAlC+hfto=;
 b=bA/a3DcQZ0XOkrYWOXi0Yb5UWqN5nMuUUibV3sV6BlOQ356N7SeuhQgYiqnW+8rev2ihSkIt8YJ5C5wGgpD9BmrDqoUDxWlgYpG45v7wb0TslXGraMHwlirt4cKwk29OsL0sufujeA+PHfOxNtKQG9bTMQJb0kvSMrsBMWpql7C4UYoC1YFpPouSMNvSa1l/SnMAySs/hJEe2grcKhztvnZmN26vcZ/bFBgUTFCp278viCDvmJFRRIrjTt0xS+YopIhwb/ffpB8Yh3Xm+OHMtIT+QOaRh/4+twPZ1hiaD50VjzTXHOfIdCeYRX80dTYRENW7k9Orcq9PgmeNYB+bKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TiuCWSctJS7LPXQNQLTcqV6OeAzJMY9wBotAlC+hfto=;
 b=BgwOK+mIuRv0AHjQ6mzO+CQW1xoQICsiR4k/nXPuwgwOO6iQw+4ZrBiTwD/0sqxmw46ut7MdMDgBh07Jvh6n0XsW8y/Wlb4OupML6ycdpiPEt4uznqu/9R91rqF6aPZDvNxX7uIdUByXirQ76Gwpn0hqmzQjGGHhjSTV5EX6xQc=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MN2PR10MB4240.namprd10.prod.outlook.com (2603:10b6:208:1d9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29; Mon, 21 Oct
 2024 14:45:36 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.8069.027; Mon, 21 Oct 2024
 14:45:36 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Rick Macklem <rick.macklem@gmail.com>
CC: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: RFC: Dealing with large POSIX draft ACLs for NFSv4.2
Thread-Topic: RFC: Dealing with large POSIX draft ACLs for NFSv4.2
Thread-Index: AQHbI0UuNnIPLptcXEqPvS3UQPcZ+rKRSTAA
Date: Mon, 21 Oct 2024 14:45:36 +0000
Message-ID: <0A2D2441-712D-4EE5-BFDB-E77108BB1A1F@oracle.com>
References:
 <CAM5tNy4S0O28CcDGV43BWXegSZSPVEYgFKpaLxLSNSgjti_L5Q@mail.gmail.com>
In-Reply-To:
 <CAM5tNy4S0O28CcDGV43BWXegSZSPVEYgFKpaLxLSNSgjti_L5Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|MN2PR10MB4240:EE_
x-ms-office365-filtering-correlation-id: a71a4bf0-d15a-43b0-91e8-08dcf1df064b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?MGZCOWpNR2hRbjZyNkVPalhHLzh2dFdvT3FFeVJVaGVRbU1nM1hOdzVNVmts?=
 =?utf-8?B?Z1J6bVdNckpMYlZ1RmxTK2ZHQ2p2UDJqNkoyaFd5VVpxU3NhNDYyTGhtZUE4?=
 =?utf-8?B?TEtrQU1vVXJ0bmhzcms5VkFrMUZhc05UbSs0QXd5dU9xdXVZRFBuc0ZpZ1RV?=
 =?utf-8?B?VUx3V0R3MkF6WU85US9uMFd4REMxTm5KcHJLS295akVnVnh6ZzlVME91MTgx?=
 =?utf-8?B?MXdqWWZTeGlWODNBZkFpYTVsb1hRUWo0d2UrN2IyNTRMM0d2eldQeGd0NXNP?=
 =?utf-8?B?empIVHRkMWtPYmVKOHN5Q1BScnFRY2s3UGxXQkZ3ZVZOOFFBSFJHMW9waFls?=
 =?utf-8?B?N3FkUDlyNjJuOVZvcS9YV1F5cGhGL24vcS81TjQ3dDlDVnM1U1VDZFQ1NGFz?=
 =?utf-8?B?VmIra2pFRHBjd05IUkZlSTRMRytMaTUzQWtMNGFpWm5sL3pvZTZabjMwcDBL?=
 =?utf-8?B?L2ZqMkFvbjNvazdLaXlNOWtPekY5MVZ1NFZzUG5LenRaTUNVRmpvZWJnY3ky?=
 =?utf-8?B?NmdETjFBNGU3NVNtMk8vSFNXbXhsdFVpMDFCK0tSdHhXd2orbjJCUFBkVktN?=
 =?utf-8?B?TFBGczJLTVJzSjdoUUcvcHV5TmxLdVBsV0VaUVhnUW5STEdTSlhaMGg3OWJQ?=
 =?utf-8?B?M3Avam42ZmdLdnA5UnFkcDFWNVhsTWw4VThWb2ZpYk9ha1JPOFVQM3VpTDE5?=
 =?utf-8?B?aHJnSThEM0dZajZZSWowME50azR3cmtnYUJyQmM1WkZmdEs0eHFiSDRXVkoz?=
 =?utf-8?B?WFRpQmpreGtpRXlIcFhadWFMYVVlUjJLdFZNOEx2cEpDQk5hWm1YNUNXZ21Z?=
 =?utf-8?B?WXZmd0luWWlzUUZWTEFIYjRyb01HVzlNbGNnWWRpZnMyQ2FaYWFhTHQrRVN6?=
 =?utf-8?B?cDlnUTgvVEdWM3crd29TdHU1dFU1YXgwQVpaVGxIVTJTYzBPQmVCcjhlZUNp?=
 =?utf-8?B?Vm12bVl1SDBGdGVGRFpNR2k3SDlzSkdFeG1RV09ucnpXaFRpZFlFbW5IcVdo?=
 =?utf-8?B?aEN1ZTNhb1R0SUt6SlZSTkJ0a2ZsWnJudzNmaTJLcXprRkpmUmJZREJGdTBV?=
 =?utf-8?B?RUJpV2U5U0NhOGh1aTNWd052Sk9rWWQ3L3ZxSnRhZ1k1Q2NwcUM1TjYrRTk0?=
 =?utf-8?B?OWVZdnBtdiswYldJTFM1UnhOczBUR0xyOTE1cU5yY3YwOU50ZTNkN09vbVQr?=
 =?utf-8?B?aVB2TVJrbjhERUVlSm1BeTg5RjZ3cnUxZHhRTVpicUJPbHplbjh3L0hzaWov?=
 =?utf-8?B?akxRdFZ2Zmd0S3kxcWdhdXphYXFPNXd2dzY1YzkwVkl4THhZUndqRmliK2hU?=
 =?utf-8?B?K1FvQUVZRURDM2dOOXBtemdiczVLZU1QQTNmWTdPUE5yQmpDUVdQZ1V6a05a?=
 =?utf-8?B?dzVjWVpXRmZ4TUlrdUZzUEErYXZxWXR1elgrcW1tdGFGN2JTNlVnU0NuWkFV?=
 =?utf-8?B?L2QxSXByeFdDWlRqWWFqRkRTRVgyeXJhVW5xaWlsdU5vbDZhVDR5OXVsSDc5?=
 =?utf-8?B?ZFFWQ1JNMExId1JyN1liTkY3SUdDWXMwdjI0LzVtdGY2N0diYnl2eHE1R0lt?=
 =?utf-8?B?cmd6NTh0VmNQSXBWSEYwbDBNTHpmWUhhazgrWFVhTWpLYnVhZlZRS0dUWUZI?=
 =?utf-8?B?eGVvaFNDZjZuYkJoTzd1OFVxQnJ5S0lEWWFCcXhHRVNFVmJBR0JvaVFtbGEz?=
 =?utf-8?B?NWZZSVFyVHE1bURGSUJFTlVZNWc2NVE4V29NWEw5UC9SYUt5ZGEydC9uYWRJ?=
 =?utf-8?B?VlFId2REN2hWVDdkbUNIS0pjZ1B5TExRZWRzSTZRcXJKL21IVEdrUlNUY3lm?=
 =?utf-8?B?NXB3QzNBdWdtdUsybmplaUVQcnUvUUF5bXRlV1U3RWpyRnY5Q2x0Zit4T2VM?=
 =?utf-8?Q?gA83KY39yGm7j?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OWxLMmRBWXVYZDNaRlBITHo5MWlubUlhaGlWMktFa1RLWEZnZjZqLzBLZUxQ?=
 =?utf-8?B?ZDNtbld1YjNYQisxck10SVNmbWpqcW8yaG5VUXFZckZzSWY2U3A3dUNXQ3hO?=
 =?utf-8?B?Nkt4Wm1na1RCRmVROUkrWEMxd25RQU5KWS9NTlQycVkrQVZBNWRFN3NwMFdO?=
 =?utf-8?B?Lzk2MXNVN3dTVms0WjF6TG0rL3dLM1ZsUEJoV1BiOWVMS0k0U3BvSnl4OUNn?=
 =?utf-8?B?L0JjS2c3TkRuR2hwc1lvTzRobUNUWFlXckVkMUNBeWpWUEVCNkMrZ2VwRVlm?=
 =?utf-8?B?VEhwc0J5WVNkQmlMcVZBclh6eC9GaFhRZVlua2VzR09CYlNud3BNejlwelAv?=
 =?utf-8?B?OHpHN29WZVlKdGtvc2VOdGJ0UDlyR1NoZWhHd2N2NitoU3NpdTBndDVDV1BP?=
 =?utf-8?B?bnRlSkZIWUJVVHZwN2hSZ05GcGE3SHptSVBqMDlsbzdSRmNQSXZVNEZsMGNR?=
 =?utf-8?B?Um5XSXU3ZzdCSlNvdlh2a2dFSFhaTkVkRVdTb2lydE1aM3VwN0tyNEFoYjVD?=
 =?utf-8?B?M1FVeVBuMUhLUzZkck1lbStHNmFROHdCRVMyc1Z6bkVhTzlWUy85MnVENS85?=
 =?utf-8?B?eHpiOG1iR05JOFhlaFdlUmNCck8rTWRrYVV1bHF3TVF6OXVUbUFscTJYS2hS?=
 =?utf-8?B?Sm1pV2pNNjM0aURQTXVLbmM2bVVQL3llY01mdkt0MVR1UmVqa0VxTEZvTU9O?=
 =?utf-8?B?N3BWZzNiOFJJQSt1WkY5N0o5TmN3Z21KazYrQTd1R1duOXZFZ0xPalN3Q0hG?=
 =?utf-8?B?cGV5dDdqV1ZGcVBNbnhBeGNsM2pIVkZDZXVrTk5zaCtPT2NJVGg4bFMxWk9E?=
 =?utf-8?B?c21CcUNKZ0pJS08yem1YWmt0OVFpMlk5NDhyVUNKMVVQcGpsYng5NnFnc05X?=
 =?utf-8?B?L1JLTTdYK3BFZEd4Q0lXRklPYlNmWHdVaExXcVBYeEdIZmhqSGEzVTYzM0FY?=
 =?utf-8?B?RExaZ0VVdk5kYlZuMnpwb1dDNzhuTDg2Q2tRNGlUQWY2WGw5K2dMUlpyWW9W?=
 =?utf-8?B?bVd4NzlKZXhiT1p1WjZQUHlUZDRrQzJLRlQzMGV2UlBMNnZXZEsxdnAydGxX?=
 =?utf-8?B?Nml5cGxkendIT21xanQ1YzVEcHdRVC9EdG1JeGN6M3QzZStNRisvTG5kN2Z1?=
 =?utf-8?B?bUtQY2R1NTVPL3RZYUNkQkRTUmV4RWhQdHViMEZyOVV4eGpCZngrM3ZKUkF3?=
 =?utf-8?B?clRmLzZSdU1LNGlZS0oyYmVjOWpMZGs4cVo5N3B1M2FLaVUycEk2b2E1ZUdx?=
 =?utf-8?B?d3psM3ZwVWFuNTY3WDh6UG92bDhsaXZEdkZ2RFEzYVNMbkVraUNZYlk1eFd3?=
 =?utf-8?B?cXBrSGhtWStBVVFsdno2ZmVDQVA5RjlCZndDNlljbkJrdkRXR0Z3elpRY3g4?=
 =?utf-8?B?eVdQLy9TN3VZY0p5ZUdZMG92SWduYjRNVFZiK1NyTGRpS0Fzb3NGM2ZRWUdm?=
 =?utf-8?B?K3pWYXVSUEdPVkc5dzd4aVV4bEVMcS9XR0tXcDBUT3h3MXBmZWpXcnEvUzlR?=
 =?utf-8?B?S1dWM2tXdC84QUxGN0tpVjJ0cGtDZjJpOEYwWUcwT21rQWgya29RUG5OZVJ6?=
 =?utf-8?B?L1JRNkpjVEFSY1dLaWEzdkI4akVRb0g0K0w3QnRaUE1EZVF6OHlvZmNKT1Ix?=
 =?utf-8?B?cEJTTVhoMEVqVW9uRHB0THdoVE55K1grZHE5MEUvNHdGOVFrMkloZU1CWEMw?=
 =?utf-8?B?YTlkM1V0dDdnK3pZRm96aVh6Z0FBZXoyaFFmdENsQWRtRlFWZkc1SXFQT2tu?=
 =?utf-8?B?S3JQcUlPV0ZxSUw1K25QVXhNRjJxdUI4akZXZ0NQOU1VMWVGZGl4T0tjemor?=
 =?utf-8?B?OFl4L2E5Q2xtM2h6cHkzWUpPRmd3MFJtUlRxczBaYTBGSEJnU25JZFhTd2tB?=
 =?utf-8?B?WTJLVk05TFQwNkJGaUFjZ2x4elFEWFF2UGpudXFTckdSeDBXWDBWU0MxMytB?=
 =?utf-8?B?cVRxeTRKS2pndjRMV0dmRFl6V1RrUDNudGtCS0YrdXpXZVpRdWRENzFPczJK?=
 =?utf-8?B?UExNTFlIYjhiVVZCOVViU3oyOEJaTE9ER29iOUUzQkR1VUxlVDA3YXU1WEdo?=
 =?utf-8?B?QnhxczJQYTQzci9mdnNOQytRMjc0c1B0bG5jTjJjdUZHV01sZms2cFFVelRU?=
 =?utf-8?B?R1BCUVVBVjZVY3hLdXdDT2VTUGFwTUQzMGJxYy9QSkM2U1ppN0NYS2MyY2xp?=
 =?utf-8?B?NEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A778A8BFA8997440B85F12E950E11C3C@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	FVHTLfX89jJtVxqyf3rYLXbDXFXQIjLqPDCwI6Ptg/N8KMt3hOLx1kswxaC2eqhDUWeJSpsFborc4B3CAD5A/OLlRloIMM2BrAfN2v4/X1RE1dlfJHtCo/6PWX7YWpeHhrC7ETKs7qa1LQxgK0yyrLcT92SAB/lMQvt55QgcIuJiLFlIsS5RlECm94sdAIwg9JXefN7izPVILAGBwKh8kTTu5wbzjkZgTxbS8skzwGJpoidkRM7Grv75FQuwydCm928QklE7CywWr76hftNKmV5WJ6NKOEojkNTPQsr+69qrGfbZhuZAV5CiWnNe4uRColpF3BULlL+sjdiI61R3fqjoFJudjECv0t8Qs2uRpfBvmjBLeTxqiZ5dT/lme+Nva7WIVfr7ZAzTG/Z0/vcUV7kydgiXskZnwpumGjZ5lENg9BpI5liFN1CQk6o5JeJrxsZsLDnMeh1/xSSln3541qnwmYQGpIwovlG0kVp8xUiRO6PdeiBvTzDZ+XbcyIEJQrgIIV6KZzbB+MWYCjQuNwItKD/gRlwnP7bEQAi4t9qVF/K60y7CikYEr8b5HEhrprcN219ZT4VsQb5y8Gi0WetJE66Ej2tqEmkYPLTHzCw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a71a4bf0-d15a-43b0-91e8-08dcf1df064b
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2024 14:45:36.5292
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wy9kXf8O80TWOuwYam7h8Yuso7lda9vJjEkem4ujZ93dWXZ65qpzRkbErM311VB/p7XQ7SVv8iwIbJJohe+1Jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4240
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-21_12,2024-10-21_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 malwarescore=0 mlxscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410210105
X-Proofpoint-ORIG-GUID: cqVlECcQSHKFa_jjOVQsxmYHrB_GsFJj
X-Proofpoint-GUID: cqVlECcQSHKFa_jjOVQsxmYHrB_GsFJj

DQoNCj4gT24gT2N0IDIwLCAyMDI0LCBhdCA3OjA54oCvUE0sIFJpY2sgTWFja2xlbSA8cmljay5t
YWNrbGVtQGdtYWlsLmNvbT4gd3JvdGU6DQo+IA0KPiBIaSwNCj4gDQo+IEFzIHNvbWUgb2YgeW91
IHdpbGwgYWxyZWFkeSBrbm93LCBJIGhhdmUgYmVlbiB3b3JraW5nIG9uIHBhdGNoZXMNCj4gdGhh
dCBhZGQgc3VwcG9ydCBmb3IgUE9TSVggZHJhZnQgQUNMcyB0byBORlN2NC4yLg0KPiBUaGUgaW50
ZXJuZXQgZHJhZnQgY2FuIGJlIGZvdW5kIGhlcmUsIGlmIHlvdSBhcmUgaW50ZXJlc3RlZC4NCj4g
aHR0cHM6Ly9kYXRhdHJhY2tlci5pZXRmLm9yZy9kb2MvZHJhZnQtcm1hY2tsZW0tbmZzdjQtcG9z
aXgtYWNscy8NCj4gDQo+IFRoZSBwYXRjaGVzIG5vdyBiYXNpY2FsbHkgd29yaywgYnV0IGhhbmRs
aW5nIG9mIGxhcmdlIFBPU0lYDQo+IGRyYWZ0IEFDTHMgZm9yIHRoZSBzZXJ2ZXIgc2lkZSBpcyBu
b3QgZG9uZSB5ZXQuDQo+IA0KPiBBIFBPU0lYIGRyYWZ0IEFDTCBjYW4gaGF2ZSAxMDI0IGFjZXMg
YW5kIHNpbmNlIGEgIndobyIgZmllbGQNCj4gY2FuIGJlIDEyOCBieXRlcywgYSBQT1NJWCBkcmFm
dCBBQ0wgY2FuIGVuZCB1cCBiZWluZyBhYm91dCAxNDBLYnl0ZXMNCj4gb2YgWERSLiBEbyBib3Ro
IHRoZSBkZWZhdWx0IGFuZCBhY2Nlc3MgQUNMcyBmb3IgYSBkaXJlY3RvcnkgYW5kIGl0DQo+IGNv
dWxkIGJlIDI4MEtieXRlcy4gKE9mIGNvdXJzZSwgdGhleSB1c3VhbGx5IGVuZCB1cCBtdWNoIHNt
YWxsZXIuKQ0KPiANCj4gRm9yIHRoZSBjbGllbnQgc2lkZSwgdG8gaGFuZGxlIGxhcmdlIEFDTHMg
Zm9yIFNFVEFUVFIgKHdoaWNoIG5ldmVyDQo+IHNldHMgb3RoZXIgYXR0cmlidXRlcyBpbiB0aGUg
c2FtZSBTRVRBVFRSKSwgSSBjYW1lIHVwIHdpdGggc29tZQ0KPiBzaW1wbGUgZnVuY3Rpb25zIChj
YWxsZWQgbmZzX3hkcl9wdXRwYWdlX2J5dGVzKCksIG5mc194ZHJfcHV0cGFnZV93b3JkKCkNCj4g
YW5kIG5mc194ZHJfcHV0cGFnZV9jbGVhbnVwKCkgaW4gdGhlIGN1cnJlbnQgY2xpZW50LnBhdGNo
KSB3aGljaA0KPiBmaWxsIHRoZSBsYXJnZSBBQ0wgaW50byBwYWdlcy4gVGhlbiB4ZHJfd3JpdGVf
cGFnZXMoKSBpcyBjYWxsZWQgdG8NCj4gcHV0IHRoZW0gaW4gdGhlIHhkciBzdHJlYW0uDQo+IC0t
PiBXaGV0aGVyIHRoaXMgaXMgdGhlIHJpZ2h0IGFwcHJvYWNoIGlzIGEgZ29vZCBxdWVzdGlvbiwg
YnV0IGF0DQo+ICAgICAgbGVhc3QgaXQgc2VlbXMgdG8gd29yay4NCj4gDQo+IEZvciB0aGUgc2Vy
dmVyLCB0aGUgcHJvYmxlbSBpcyBtb3JlIGRpZmZpY3VsdCwgc2luY2UgYSBHRVRBVFRSIHJlcGx5
DQo+IG1pZ2h0IGluY2x1ZGUgZW5jb2RpbmdzIG9mIG90aGVyIGF0dHJpYnV0ZXMuIChBdCB0aGlz
IHRpbWUsIHRoZSBwcm9wb3NlZA0KPiBQT1NJWCBkcmFmdCBBQ0wgYXR0cmlidXRlcyBhcmUgYXQg
dGhlIGVuZCwgc2luY2UgdGhleSBoYXZlIHRoZSBoaWdoZXN0DQo+IGF0dHJpYnV0ZSAjcywgYnV0
IHRoYXQgd2lsbCBub3QgbGFzdCBsb25nLikNCj4gDQo+IFRoZSBzYW1lIHRlY2huaXF1ZSBhcyBm
b3IgdGhlIGNsaWVudCBjb3VsZCBiZSB1c2VkLCBidXQgb25seSBpZiB0aGVyZQ0KPiBhcmUgbm8g
YXR0cmlidXRlcyB0aGF0IGNvbWUgYWZ0ZXIgdGhlIFBPU0lYIGRyYWZ0IEFDTCBvbmVzIGluIHRo
ZSBYRFINCj4gZm9yIEdFVEFUVFIncyByZXBseS4NCj4gDQo+IFRoaXMgYnJpbmdzIG1lIHRvIG9u
ZSBxdWVzdGlvbi4uLg0KPiAtIFdoYXQgZG8gb3RoZXJzIHRoaW5rIHcuci50LiByZXN0cmljdGlu
ZyB0aGUgUE9TSVggZHJhZnQgQUNMcyB0byBvbmx5DQo+ICBHRVRBVFRSIChhbmQgbm90IGEgUkVB
RERJUiByZXBseSkgYW5kIG9ubHkgd2l0aCBhIGxpbWl0ZWQgc2V0DQo+ICBvZiBvdGhlciBhdHRy
aWJ1dGVzLCB3aGljaCB3aWxsIGFsbCBiZSBsb3dlciAjcywgc28gdGhleSBjb21lIGJlZm9yZQ0K
PiAgUE9TSVggZHJhZnQgQUNMIG9uZXM/DQo+ICAtLT4gU2luY2UgaXQgaXMgb25seSBhIHBlcnNv
bmFsIGRyYWZ0IGF0IHRoaXMgdGltZSwgdGhpcyByZXF1aXJlbWVudA0KPiAgICAgICAgY291bGQg
ZWFzaWx5IGJlIGFkZGVkIGFuZCBtYXkgbWFrZSBzZW5zZSB0byBsaW1pdCB0aGUgc2l6ZQ0KPiAg
ICAgICAgIG9mIG1vc3QgR0VUQVRUUnMuDQo+IFRoaXMgcmVzdHJpY3Rpb24gc2hvdWxkIGJlIG9r
IGZvciBib3RoIHRoZSBMSW51eCBhbmQgRnJlZUJTRCBjbGllbnRzLA0KPiBzaW5jZSB0aGV5IG9u
bHkgYXNrIGZvciBhY2wgYXR0cmlidXRlcyB3aGVuIGEgZ2V0ZmFjbCgxKSBjb21tYW5kIGlzDQo+
IGRvbmUgYW5kIGRvIG5vdCBuZWVkIGEgbG90IG9mIG90aGVyIGF0dHJpYnV0ZXMgZm9yIHRoZSBH
RVRBVFRSLg0KDQpHZW5lcmFsbHksIEkgZG9uJ3QgaW1tZWRpYXRlbHkgc2VlIHdoeSBQT1NJWCBB
Q0xzIG5lZWQgYSByZXN0cmljdGlvbg0KdGhhdCB0aGUgcHJvdG9jb2wgZG9lc24ndCBhbHJlYWR5
IGhhdmUgZm9yIE5GU3Y0IEFDTHMuDQoNCg0KPiBBbHRlcm5hdGVseSwgdGhlcmUgbmVlZHMgdG8g
YmUgYSB3YXkgdG8gYnVpbGQgMjgwS2J5dGVzIG9yIG1vcmUNCj4gb2YgWERSIGZvciBhbiBhcmJp
dHJhcnkgR0VUQVRUUi9SRUFERElSIHJlcGx5Lg0KDQpJSVVDLCBORlNEIGFscmVhZHkgaGFuZGxl
cyB0aGlzIGZvciBib3RoIFJFQURESVIgYW5kIE5GU3Y0IEFDTHMNCihhbmQgcGVyaGFwcyBhbHNv
IEdFVFhBVFRSIC8gTElTVFhBVFRSKS4NCg0KU28gSSdsbCBoYXZlIHRvIGhhdmUgYSBsb29rIGF0
IHlvdXIgc3BlY2lmaWMgaW1wbGVtZW50YXRpb24sDQptYXliZSBzb21ldGltZSB0aGlzIHdlZWsu
IEkgY2FuJ3QgdGhpbmsgb2YgYSByZWFzb24gdGhhdCBvdXINCmN1cnJlbnQgWERSIGFuZCBORlNE
IGltcGxlbWVudGF0aW9uIHdvdWxkbid0IGhhbmRsZSB0aGlzLCBidXQNCmhhdmVuJ3QgdGhvdWdo
dCBkZWVwbHkgYWJvdXQgaXQuDQoNCkl0IG1pZ2h0IG5vdCBiZSBlZmZpY2llbnQgZm9yIGxhcmdl
IEFDTHMsIGJ1dCBkb2VzIGl0IG5lZWQNCnRvIGJlPw0KDQoNCj4gQnR3LCBJIGhhdmUgbm90IHRl
c3RlZCB0byBzZWUgd2hhdCBoYXBwZW5zIGlmIGEgbGFyZ2UgUE9TSVggZHJhZnQNCj4gQUNMIGlz
IHNldCBmb3IgYSBmaWxlIChsb2NhbGx5IG9uIHRoZSBzZXJ2ZXIsIGZvciBleGFtcGxlKSBhbmQg
dGhlbg0KPiBhIGNsaWVudCBkb2VzIGEgR0VUQVRUUiBvZiB0aGUgYWNsIGF0dHJpYnV0ZSAod2hp
Y2ggcmVwbGllcyB3aXRoDQo+IGEgTkZTdjQgQUNMIGNyZWF0ZWQgYnkgbWFwcGluZyBmcm9tIHRo
ZSBQT1NJWCBkcmFmdCBBQ0wpLg0KPiAtLT4gSSBoYXZlIGEgaHVuY2ggaXQgd2lsbCBmYWlsLCBi
dXQgSSBuZWVkIHRvIHRlc3QgdG8gYmUgc3VyZT8NCj4gDQo+IFRoYW5rcyBpbiBhZHZhbmNlIGZv
ciBhbnkgY29tbWVudHMgdy5yLnQuIHRoaXMgaXNzdWUsIHJpY2sNCj4gcHM7IEluIHBhcnRpY3Vs
YXIsIEknZCBsaWtlIHRvIGtub3cgd2hhdCBvdGhlcnMgdGhpbmsgYWJvdXQgYWRkaW5nDQo+ICAg
ICAgdGhlIHJlc3RyaWN0aW9uIG9uIGFjcXVpc2l0aW9uIG9mIHRoZSBQT1NJWCBkcmFmdCBBQ0xz
IGJ5IEdFVEFUVFIuDQoNCg0KDQoNCi0tDQpDaHVjayBMZXZlcg0KDQoNCg==

