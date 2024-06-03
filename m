Return-Path: <linux-nfs+bounces-3534-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2F288D86CD
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Jun 2024 17:59:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5C271C21FD7
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Jun 2024 15:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECAAA134407;
	Mon,  3 Jun 2024 15:59:39 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01267132804;
	Mon,  3 Jun 2024 15:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717430379; cv=fail; b=pth+Z0Hf+bxjrK2omJEdLnYdSv/C7BwerrarEZj0P3tDgYcuOqfLg0UteEHe/Wm5NJHHoTaV/UBZ39W+nSXDYv6j5ZZyaXfDJbuvGkwLALqkK7P+M+qMXdlOdIgqr4OccBjhT0YSU4kGAEkTcYKKKIzwmaSil+Sv+mm3sDsY+P8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717430379; c=relaxed/simple;
	bh=zWkfQ0c1DaHXIwsyryrFNuIcHI3dXClx7DmPh4oosPM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HU+SVSJbs1RiSjBIypq3pJnnE0VH2OG8Dh0e0XVmPKam4esbCr/tInd9cHFve8vUfVzPJeE5Rj+alLLqK9PICNlKnZ4+WwdDWf7PVaPbEsgXkgMg57hoHNpPboq63fA3lvP8TtjxeFk4CTW8VG8L8M/rHkafDqLnCxcZdSDaP9I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 453CR8Fk015865;
	Mon, 3 Jun 2024 15:59:36 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-id:content-transfer-encoding:content-type:date:fr?=
 =?UTF-8?Q?om:in-reply-to:message-id:mime-version:references:subject:to;_s?=
 =?UTF-8?Q?=3Dcorp-2023-11-20;_bh=3DzWkfQ0c1DaHXIwsyryrFNuIcHI3dXClx7DmPh4?=
 =?UTF-8?Q?oosPM=3D;_b=3DDpqS8OVpBS66WuS0ZIovLxFrWICOMnruF2suPN62Qfs/rtgyj?=
 =?UTF-8?Q?f8KjF8+icizh7wlvuZs_hvylh7TQZ/tAW/tZhDMKIlV1PUSzBePCRNUiEqUWIQ9?=
 =?UTF-8?Q?OslAtGzVQ34F7ls7Z19HV2q6P_yJ0GHBUrZePjdTqziAYIyl0wW+0A11nUdKI7u?=
 =?UTF-8?Q?Lk2YBeX8Pwi1e0/9suepG6F3tNuyR3O_DxowdoXFW+EJDC8AFlt5ZTnVDgOElzE?=
 =?UTF-8?Q?LFDdNMbeyefEcRQLgsKMmGjDs3oO4aDMFKX2q_RtK6V0WJzez843XDvcksURQDC?=
 =?UTF-8?Q?s9Lwzuz4xY/KPoIvfPElbmZtRVG5cYGU95i6943EBzl_cQ=3D=3D_?=
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yfv05b6y3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Jun 2024 15:59:35 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 453FPAcJ025177;
	Mon, 3 Jun 2024 15:59:35 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ygrt7cqqu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Jun 2024 15:59:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YObvIuLaZUKZGOEx3/1dqUeAjSIMsWjg1zRvWhbOJ+52z9+bJuCUBIPXQzdnnJwjk7E/af1NbJ38BB7IFhfYEgKmcso2BJihegpMP6OUv6aP8aUrgbXKWYkzZOGE9Z1u/nKF/NayrUmD3ntrUPcARioDJfqfFuSEjllkG2PJnohXl8D5M7am7888vQnFT3OQJvEptijc3H4YWg+xa+efqXuhC96O2IellVtsGqP4ESKd1wEh/IzUxG6XE2b7OW4Jth/nMvRwE4Jc7WfDFv4huwINepcbjJg4pljPJ8Wgim1+3j03+DfqA8Ghjmt5Qa5H8KPXQiRkHJLeoscuJJglRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zWkfQ0c1DaHXIwsyryrFNuIcHI3dXClx7DmPh4oosPM=;
 b=CUUNDvYjHbM1xtOc6ibMAAsfugprkNAaaHrXbQxU/N/k01j3+MWnXc5T19+xTgu4NyMSacKXy6TgNbpzgfVk03h8GEGyS2T+Yj1li9DkT5ZC/3OgbIgyxfj3qa9OesSGtLoMcRH9RAluJWGFePH5zUBdum/aVvg1tSQRNHRTEwKyMV6SbzfbRGbA+rPu+g0tyG/oX0bF2D5HXDBMKEU2wVv5qThqzQEA5bgzi3me3YfrXCtoLfG5DzhWSZE/X+kz5FktXSGmJa2zm0o5V44dTSIpW4Vnb24mP9BETZxnRLhnO+zBbRLqlqGpV8cd4VZfCQ3ACRa+dpsgaWOWwfOF+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zWkfQ0c1DaHXIwsyryrFNuIcHI3dXClx7DmPh4oosPM=;
 b=LHPHCpCZPkRks/5RzZ9ICf2FVxTr0wsANf++R5PzjijDEJ/iofN75YhMvD92N4+7jyeY8nBsHL89HcoF+1xvHeBqdoqrz2Zs0BRGg+MAOwlKipSDRHhjQ2Re7JmL7TYr9q7eyTxnllJPiF0yzZmdRDAkPz+t6dmT6X5FnSFeS0M=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CY8PR10MB6804.namprd10.prod.outlook.com (2603:10b6:930:9b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Mon, 3 Jun
 2024 15:59:33 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.7633.021; Mon, 3 Jun 2024
 15:59:32 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Zhu Yanjun <zyjzyj2000@gmail.com>
CC: Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "kdevops@lists.linux.dev" <kdevops@lists.linux.dev>
Subject: Re: [RFC PATCH 0/4] NFS: Fix another 'check_flush_dependency' splat
Thread-Topic: [RFC PATCH 0/4] NFS: Fix another 'check_flush_dependency' splat
Thread-Index: 
 AQHamkmDfBfBFsNf5kaeN/1BZO1Wh7GAavwAgABo5ICAAAR7gIAABDQAgAAI6gCAM+xcgIAAKu+AgAFsqAA=
Date: Mon, 3 Jun 2024 15:59:32 +0000
Message-ID: <953940CF-98DE-4727-8E32-066CC4B3E8B2@oracle.com>
References: <20240429152537.212958-6-cel@kernel.org>
 <efc4f895-3a45-4b44-a47d-532896526458@linux.dev>
 <90F6A893-5315-4E53-B54E-1CF8D7D4AC4D@oracle.com>
 <f49907ea-cedc-44b7-9ffc-30c265731f3e@linux.dev>
 <675A3584-6086-45D4-9B31-F7F572394144@oracle.com>
 <6d483d75-5866-4c4e-8d86-c89a2b27f5e7@linux.dev>
 <F2726F77-06F9-4DB4-B2A8-97F21B045A6F@oracle.com>
 <CAD=hENdL3v6gMpU7SBdkLjcyuEhzCvTRxt3+N+8m6ybuVKGHwA@mail.gmail.com>
In-Reply-To: 
 <CAD=hENdL3v6gMpU7SBdkLjcyuEhzCvTRxt3+N+8m6ybuVKGHwA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.600.62)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CY8PR10MB6804:EE_
x-ms-office365-filtering-correlation-id: ee53771d-5226-4f78-1d2d-08dc83e628c2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-8?B?bVJzZWNYNG9PSEFrdXJhdERJc0Jvd1hCaFRONDNKdFVrT2JiU1B2WHZOWG5I?=
 =?utf-8?B?Nk93K01TN0psYlNGcXdndnBHSFJvczMyc3NSZmwzcUozMm1uYjdRaVNaSUZx?=
 =?utf-8?B?d2V6NXVYeFNjczhkRktLL1NodzJZVytTbDIwc1RzZDhQNVlCNGQzeHRjQVU0?=
 =?utf-8?B?UFdMSkNOK0NXUitWek0wVkZTclpJaWZlNU1vbDB4YTRITXFxRnB5UmtRWTZ6?=
 =?utf-8?B?bmN6dEhBY1FTeXR1aW54bmhQRFFWK1hYaE44UnNjQ1ErOVZRUGZheEFWUFVG?=
 =?utf-8?B?N2taVldIankzTG1lTEdmTGJCbnBHKzhNSkNGRXdIN2hKZjRSdGE1U1VmUm15?=
 =?utf-8?B?S29wRHpwd0tRNk9jYUpBQzNBWFYvdzUrRXRWdU9Sa0t6aFMrdG14RmZoN3hh?=
 =?utf-8?B?UERDV0EwTzV4ZHFjSGRqbzd6SkJ6UCtEcWYzSi9saFVxdnJYVWtRWnNSeTZ5?=
 =?utf-8?B?TjgrMFE2T0FqYVlCNlErQXRYQ0RQRkswSHBqeUZqNk9LSm0yeG9tV2hrS0Fs?=
 =?utf-8?B?ZFJUVTJYL0M4V2FoOTZVN08xWWU5NmxpSUxqODBpd2RrRitqOEs5VGNUWW0r?=
 =?utf-8?B?UFdNdTM0c2toYXU3RFZpRVo3YUkzSFVaN0VaeGpsM1lKWGhGekR5ZitpTStC?=
 =?utf-8?B?OWJpOEd1SUNFYVFBTSs2ZWc5akNCQzZHZ0hZeWkzQVRCY202T2dlTEg0NTIr?=
 =?utf-8?B?Ymd3aWxRcUZmZVJUQ0JsdDQvOFRQMkVWWk1ZdDRCbHE5S0pNdDVXN3RIZHNl?=
 =?utf-8?B?cGxvNk1Hc1ZFWks3aW1zc01ZS2VzVUgzMVlXVDVwODVHc3ExR2Jnb3J1SURq?=
 =?utf-8?B?UmkxM25RYUVEQnJ5dzI0N2luRm5mK2R3SFlzNlVpa1c5dVlaMEdnWGdER09y?=
 =?utf-8?B?Sm9La1l1T3NpQkZZMWR5UEFLM2RiRkM2QWVGdnhQTkd5cXU3RjdLUVlqRjZj?=
 =?utf-8?B?U3pHWENEdmt1OGV6ZE9pMVE3NHh3bnIzOWtqTCtSTWwwL2s0Z2NhTXVFMHh6?=
 =?utf-8?B?b0tielFybzIvQVFlWDVwTkFrU0JIaDEyejA4ei9YK0JOdktUVjYvdDV0eGdz?=
 =?utf-8?B?REJsTFRHbjZxTXNoeEpmaElSdXJtdTc2VEY1YUtCNDY2eHN5VXQ4dmV0WXB3?=
 =?utf-8?B?dFBncjhRVXVPNGZiT3Vnb09hL1NvSHl1YS9RcXVmM3VtQmxoN0ZSZGVFOFht?=
 =?utf-8?B?Z1BlM2t3UTk5aUw4clVwYnJBTHc4TXlTYTVmaHlUVEk4VWNuVEU0TkZyU0Qr?=
 =?utf-8?B?Y2VFMHVNUlhiU1JPZGltWXhmbkoyaC9USkRlb0xRcmxmTGZnYnFkR1ZtQjJT?=
 =?utf-8?B?L2N4SG8xODVuYUV2Uy92Q3VBeWl0Y2lRR0JOVk4rQUVZOXcxYTNsNllqNm01?=
 =?utf-8?B?Q1hGSjkzN2V0cUROdGFZWEtKeHJNbEJSUFlubDNudXFPL040dm9PbkpLNFZH?=
 =?utf-8?B?djVzeFRpaTBEWUVCVm5qc3lNVVVzczFpa0hvV0RiQVFCOU5JV0NwT3BCY0hV?=
 =?utf-8?B?ZFQ1WXcyRWY2SzljTXhiVlZSaU0wU1hyc2xJOHpUb0hJdDdOdjNVekIxb2RP?=
 =?utf-8?B?VXI1bCtLeWZ3M1pMdFE0VWgzamRZWjBIZXFrOWZjbmEwQTRTSzZwdmU1TElO?=
 =?utf-8?B?NzBMWFQxbVNwRWZBMklzTC9GcEl4M2hTMkg4NURFOU5HZFhjNzZzcDJwSkRJ?=
 =?utf-8?B?a2IzWmhXcHhHRmNzYVAvaWZuOTJ0ekljazFNVVNPd2hpL3lDbHJqNkJSYklu?=
 =?utf-8?B?K0ZpN1VuOGNOYzYrSFR5MncxNTZuR1hjRWxab0FxRFhGYVpmNWdiNFNmclh1?=
 =?utf-8?B?d2s2U2IxdHAybEpKSDl1dz09?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?cElLSmtBajJnK21jZkdqTW93a3g2NW1PZTBKUzB4VEJKZDBqQWVBbnp6dWpF?=
 =?utf-8?B?WmYrVk0wL2JwQmxzdjY4dWZkcDlla1lLVjNDRTNtVmMxSktQQXFsWS9hRjlX?=
 =?utf-8?B?M3ZVZTRwdVBjSDMxYURLK2szVzFwc0ZPdnZUZlJ4OEJpcGw0ekNBTDk1ZGNE?=
 =?utf-8?B?cExyWVpsZ1JINDhlMk1XemNFcFh5Y0ZvZU1PbTM3WXRBZEQ3TmVocVlmdFdw?=
 =?utf-8?B?cFN4cmZyUVNhSmlZNCsrZ0h5WmRjZnRkK09KOTJEU2tCbVhCUnR5YmpIbm1m?=
 =?utf-8?B?NHRiSno2c0tEOGYwQzFvekNiVkZEdXppOTBQc0xRT0IvNUg3R1pzYytZdlkv?=
 =?utf-8?B?MTRqU1B6eUpRT1lrVUN0blJpRXJVanhldGpBRkxJdW84encxZ0FxcnNUYmRa?=
 =?utf-8?B?cExFZERiNHNhejFFanBvSFpGeHpTbVo0WG9rNmlrWll4K1cyZ3NNajlqZTl2?=
 =?utf-8?B?eXNwMEt5bjgyK0hoZk9HMW5NeDRBM0ZsWkVhM0k0VjFURk43d1RsNE1LT3hp?=
 =?utf-8?B?ZGRRbGgybUN4VzBTVTlVZkFqcjBkZWo4OENTdnJSeElVRUVsVzI1SmxJdk5J?=
 =?utf-8?B?SkliRzc2STQwZFJkMlA5M2pSdnNTMVQrOEFrdjNHWnMxUnpkZi9KbkF1dHIw?=
 =?utf-8?B?ViszT0RYMUtTNkdJWkR3a3NRdEk0VHVDR0hmWWtzZGRZYkhVUGFFR0VFVUth?=
 =?utf-8?B?L3Z0NktmV2VLZzN0TnZhbkhqMkJBTWt4TEpoZG5ONDF5RjZITVQ1SW1TZGtv?=
 =?utf-8?B?dDFEcWVjc2NBVHFKaUV6bVk5RFFZQ0N1WTQ4MXZPTUhQZkdGbVY2Z0Y2ZEl6?=
 =?utf-8?B?WVN5ajhVSFJXdlJUMHlPckpkd054NXE4VlhWQm9sM1hQZGxOcmFHZThwZFVM?=
 =?utf-8?B?Q0Y4TVlQZnBSdTN6RUlmZVduSUJKN0p6ekJuRktYSkpNeXVJMkxQaWZqNGdj?=
 =?utf-8?B?MmF2ZkxXcDdjZExUOHVrWGdzMTRQb0pDUzRQdnUzMFZSaG9FRXdUVitQV3BL?=
 =?utf-8?B?L0s0c0Q0Q290RVFSL3lOaXZ0UFphNjN3dmEzVE84eHpIckI1Q0NXMEQyY1Zk?=
 =?utf-8?B?MXNLKzlLdWtOd3lHdmJYYnZVNXdMcVZGRVRGM25WVWhzLzJaNDJISGlQbW1W?=
 =?utf-8?B?RHJFSEIrdURTR2RvamRZZUhtZFZaYmR1WG13RHVGaXdhcVo4NFp5dktoSW1h?=
 =?utf-8?B?WDZyamtQRVVvcHpjVWVFOXpnTXRQdjFwVThIYTExQnZzR3gzczVQYkhmQXJp?=
 =?utf-8?B?bzhuN1IyRXFuZ3c0cDVNQ1d4ZGNtSU9YYytHbGJ4ckk4UDFyYmd3L0ZUVk5w?=
 =?utf-8?B?ZnExVXE1UmJheWptc1Q5UmsrTlBoOENsMkRpN0Uzbk1QWnlzcGhYTkh3N2hR?=
 =?utf-8?B?anFuM1g3VWNyZVBNaFk2OWRzb3paTUM4Q0YwcjhmY0Iwa2trVjRPc0NWazY2?=
 =?utf-8?B?V00zYndDdDFod0JjN3NTbTlqemlEVWd0MXlManlpZ1RCZmJqb0ZmNDZSNC9S?=
 =?utf-8?B?V0RGODFXNUNYY2U4QnEydmNSTWRpenVpWXduME9tR1NaQWlYYWwyWGVqeWRM?=
 =?utf-8?B?YkV1MXhVVXNLNk1MMS9HcGhUWHpyVG1DZ0Y1cGRvcWJNVVhkRERZU2VIV2ow?=
 =?utf-8?B?TUhZbUJScEVVN3FwK3Q3TnRheVN6NThOSWxVZUFJWmticWplcVNsV0NjV0xn?=
 =?utf-8?B?cjY1SHk5MEtqM1NNeVl2M0FEdFRGNTFaVHBtSndQWTA0N2F3TjltVWpKSlZE?=
 =?utf-8?B?WlRLWWsvdGRxUllma1pZb1JtRVVEK1NScDkxVE1Kd3UvRE51Y3R4WVZiQnBU?=
 =?utf-8?B?R0w2MEtaeFRyLzJPTlU4aUQ2QUcrdHBadUJIRGFBcURVMGlTVEgwbWlpSCs3?=
 =?utf-8?B?ZmZCcU1KQmp1NllFL0RpNk9WZWtJUUFuc3lsN0ZXWS9ublVIeFFlMWYwMlVR?=
 =?utf-8?B?SU1HNUJEeWUrbklqaXJPUXNSMVkrZWRjQjNBb080UFBPS2k0dkJ2S3FFcHJS?=
 =?utf-8?B?R3F3bWEvYXh4MHJ1ZnFsalY0d3E1STQ1TlhWOUNZTUI3MXozYllMcVFhN2xL?=
 =?utf-8?B?bi9oS3lIL3J6N2Q3NjVJY0JXbnBqMkxHYUUrRTZXUmNZVUoyOUdhRGdmWHlm?=
 =?utf-8?B?eTU2Nzg4N1FzUTd1SU9GS1ZlbTJKUmNHc0dCdmZlblFBQ1Vhd3JaZ3MzUkZL?=
 =?utf-8?B?cXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3EC9164B8594744F8312A70E4E8CAD23@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	uSbelO0oEj9CeoC2BL6SBRpo9GHlm9U5NZ2RGEYFPjsdRLFTR7cRD4QpBVBn8mo+Sm1Sy90w3MwRb9fK24qB7JL9y16le6irTsMDKAhg0cftTvhUTWjbbHWcJpA9HEBvTZP+Q1zCkYGXD15Q8DrVFHbsbtLfgrlwlJYxN4Zp+vQsqZfSZYAh1DHQu80Rv/P913xQFNbXa1B4kWd4l6T3X8QTHC3xOGBAQgPBAIITTBWKrxmVCI2btnqjQV6Tvd1roT0FHWWA8pHqLIcjGKMLy8rJCVM6Tw83BXndvrVncCugHJLi99/YUqscSb7rSeH8o8GyuGplU6osfyKmJ+uYy8Djxi+FmEZoHV19BXiO/iMmi3BX5B7nR2SiKxxZ9sM1CJm23AvRj4MQTwmk42+XwFbeGQoVPweafue+ygYOqMVIU19JAjqfcGEy6hMrbr8MVjqfpc6yZHPTg8EKF7+zS1h3DXpKqItfWD0Pg/fyhIIjP2AxY4iQfj9PzGGwkNQW9U9A4Fpq27hFgWFYrwxhNK9VFTOwL4ZN4qd2L7y5aH4ItMaJk3ULFkJtRZ4oKGjbhrq2+GjqDeFogiZuR4Fq4xt38/qnwX/ZVwx4ZkU8ltU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee53771d-5226-4f78-1d2d-08dc83e628c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2024 15:59:32.9266
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UWNcHguztaZDg5+KAX5Mh2gr4lQ7WVVsuEb38IzBltOuaUFIuNY9FxMbAxwK1xGBHwFttQZ3FJWbsXn/4xnkLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6804
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-06-03_13,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 adultscore=0 suspectscore=0 malwarescore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406030132
X-Proofpoint-GUID: CcoGPC7Hz1yiX15P8TeowmoVWnfuINh9
X-Proofpoint-ORIG-GUID: CcoGPC7Hz1yiX15P8TeowmoVWnfuINh9

DQoNCj4gT24gSnVuIDIsIDIwMjQsIGF0IDI6MTTigK9QTSwgWmh1IFlhbmp1biA8enlqenlqMjAw
MEBnbWFpbC5jb20+IHdyb3RlOg0KPiANCj4gT24gU3VuLCBKdW4gMiwgMjAyNCBhdCA1OjQw4oCv
UE0gQ2h1Y2sgTGV2ZXIgSUlJIDxjaHVjay5sZXZlckBvcmFjbGUuY29tPiB3cm90ZToNCj4+IA0K
Pj4gDQo+Pj4gT24gQXByIDMwLCAyMDI0LCBhdCAxMDo0NeKAr0FNLCBaaHUgWWFuanVuIDx6eWp6
eWoyMDAwQGdtYWlsLmNvbT4gd3JvdGU6DQo+Pj4gDQo+Pj4gT24gMzAuMDQuMjQgMTY6MTMsIENo
dWNrIExldmVyIElJSSB3cm90ZToNCj4+Pj4gSXQgaXMgcG9zc2libGUgdG8gYWRkIHJ4ZSBhcyBh
IHNlY29uZCBvcHRpb24gaW4ga2Rldm9wcywNCj4+Pj4gYnV0IHNpdyBoYXMgd29ya2VkIGZvciBv
dXIgcHVycG9zZXMgc28gZmFyLCBhbmQgdGhlIE5GUw0KPj4+PiB0ZXN0IG1hdHJpeCBpcyBhbHJl
YWR5IGVub3Jtb3VzLg0KPj4+IA0KPj4+IFRoYW5rcy4gSWYgcnhlIGNhbiBiZSBhcyBhIHNlY29u
ZCBvcHRpb24gaW4ga2Rldm9wcywgSSB3aWxsIG1ha2UgdGVzdHMgd2l0aCBrZGV2b3BzIHRvIGNo
ZWNrIHJ4ZSB3b3JrIHdlbGwgb3Igbm90IGluIHRoZSBmdXR1cmUga2VybmVsIHZlcnNpb24uDQo+
PiANCj4+IEFzIHBlciBvdXIgcmVjZW50IGRpc2N1c3Npb24sIEkgaGF2ZSBhZGRlZCByeGUgYXMg
YSBzZWNvbmQNCj4+IHNvZnR3YXJlIFJETUEgb3B0aW9uIGluIGtkZXZvcHMuIFByb29mIG9mIGNv
bmNlcHQ6DQo+IA0KPiBUaGFua3MgYSBsb3QuIEkgYW0gdmVyeSBnbGFkIHRvIGtub3cgdGhhdCBy
eGUgaXMgdHJlYXRlZCBhcyBhIHNlY29uZA0KPiBzb2Z0d2FyZSBSRE1BIG9wdGlvbiBpbiBrZGVv
cHMuDQo+IEFuZCBJIGFsc28gY2hlY2tlZCB0aGUgY29tbWl0IHJlbGF0ZWQgd2l0aCB0aGlzIGZl
YXR1cmUuIEl0IGlzIHZlcnkNCj4gY29tcGxpY2F0ZWQgYW5kIGh1Z2UuDQoNCkkgc3BsaXQgdGhp
cyBpbnRvIGZvdXIgc21hbGxlciBwYXRjaGVzLCBIVEguDQoNCg0KPiBJIGhvcGUgcnhlIGNhbiB3
b3JrIHdlbGwgaW4ga2Rlb3BzLg0KPiBTbyBJIGNhbiBhbHNvIHVzZSBrZGVvcHMgdG8gdmVyaWZ5
IHJ4ZSBhbmQgcmRtYSBzdWJzeXN0ZW1zLiAgVGhhbmtzIGENCj4gbG90IHlvdXIgZWZmb3J0cy4N
Cj4gDQo+PiANCj4+ICBodHRwczovL2dpdGh1Yi5jb20vY2h1Y2tsZXZlci9rZGV2b3BzL3RyZWUv
YWRkLXJ4ZS1zdXBwb3J0DQo+PiANCj4+IEJ1dCBiYXNpYyBycGluZyB0ZXN0aW5nIGlzIG5vdCB3
b3JraW5nICh3aXRoIDYuMTAtcmMxIGtlcm5lbHMpDQo+PiBpbiB0aGlzIHNldC11cC4gSXQncyBt
aXNzaW5nIHNvbWV0aGluZy4uLg0KPiANCj4gSnVzdCBub3cgSSBtYWRlIHRlc3RzIHdpdGggdGhl
IGxhdGVzdCByZG1hLWNvcmUgKHJwaW5nIGlzIGluY2x1ZGVkIGluDQo+IHJkbWEtY29yZSkgYW5k
IDYuMTAtcmMxIGtlcm5lbHMuIHJwaW5nIGNhbiB3b3JrIHdlbGwuDQo+IA0KPiBOb3JtYWxseSBy
cGluZyB3b3JrcyBhcyBhIGJhc2ljIHRvb2wgdG8gdmVyaWZ5IGlmIHJ4ZSB3b3JrcyB3ZWxsIG9y
DQo+IG5vdC4gIElmIHJwaW5nIGNhbiBub3Qgd29yayB3ZWxsLCBub3JtYWxseSBJIHdpbGwgZG8g
dGhlIGZvbGxvd2luZ3M6DQo+IDEuIHJwaW5nIC1zIC1hIDEyNy4wLjAuMQ0KPiAgICBycGluZyAt
YyAtYSAxMjcuMC4wLjEgLUMgMyAtZCAtdg0KPiAgICBUaGlzIHdpbGwgdmVyaWZ5IHdoZXRoZXIg
cnhlIGlzIGNvbmZpZ3VyZWQgY29ycmVjdGx5IG9yIG5vdC4NCg0KSSBkb24ndCBoYXZlIHJ4ZSBz
ZXQgdXAgb24gbG9vcGJhY2ssIHNvIEkgc3Vic3RpdHV0ZWQgdGhlIGhvc3Qncw0KY29uZmlndXJl
ZCBFdGhlcm5ldCBJUC4NCg0KVGhlIHRlc3RzIHdvcmtzIG9uIHRoZSBORlMgc2VydmVyLCBidXQg
dGhlIHJwaW5nIGNsaWVudCBoYW5ncw0Kb24gdGhlIE5GUyBjbGllbnQgKGJvdGggcnVubmluZyB2
Ni4xMC1yYzEpLg0KDQpJIHJlYm9vdGVkIGluIHRvIHRoZSBGZWRvcmEgMzkgc3RvY2sga2VybmVs
LCBhbmQgdGhlIHJwaW5nIHRlc3RzDQpwYXNzLg0KDQpIb3dldmVyLCB3aGVuIEkgdHJ5IHRvIHJ1
biBmc3Rlc3RzIHdpdGggTkZTL1JETUEgdXNpbmcgcnhlLCB0aGUNCmNsaWVudCBrZXJuZWwgcmVw
b3J0cyBhIHNvZnQgQ1BVIGxvY2stdXAsIGFuZCB0b3Agc2hvd3MgdGhpczoNCg0KICAgIDExNSBy
b290ICAgICAgMjAgICAwICAgICAgIDAgICAgICAwICAgICAgMCBSICA5OS4zICAgMC4wICAgMTow
My41MCBrd29ya2VyL3U4OjUrcnhlX3dxDQoNClNvIEkgdGhpbmsgdGhpcyBpcyBlbm91Z2ggdG8g
c2hvdyB0aGF0IHRoZSBBbnNpYmxlIHBhcnRzIG9mIHRoaXMNCmNoYW5nZSBhcmUgd29ya2luZyBh
cyBleHBlY3RlZC4gSSBjYW4gcHVzaCB0aGlzIHRvIGtkZXZvcHMgbm93DQppZiB0aGVyZSBhcmUg
bm8gb2JqZWN0aW9ucywgYW5kIHNvbWVvbmUgKG1heWJlIHlvdSwgbWF5YmUgbWUpIGNhbg0Kc29y
dCBvdXQgdGhlIHJ4ZSBzcGVjaWZpYyBpc3N1ZXMgbGF0ZXIuDQoNCg0KPiAyLiBwaW5nIC1jIDMg
c2VydmVyX2lwIG9uIGNsaWVudCBob3N0Lg0KPiAgICBUaGlzIHdpbGwgdmVyaWZ5IHdoZXRoZXIg
dGhlIGNsaWVudCBob3N0IGNhbiBjb25uZWN0IHRvIHRoZSBzZXJ2ZXINCj4gaG9zdCBvciBub3Qu
DQo+IDMuIHJwaW5nIC1zIC1hIHNlcnZlcl9pcA0KPiAgICBycGluZyAtYyAtYSBzZXJ2ZXJfaXAg
LUMgMyAtZCAtdg0KPiAgICAxKSBzaHV0ZG93biBmaXJld2FsbA0KPiAgICAyKSB0Y3BkdW1wIC1u
aSB4eHh4IHRvIGNhcHR1cmUgdWRwIHBhY2tldHMNCj4gTm9ybWFsbHkgdGhlIGFib3ZlIHN0ZXBz
IGNhbiBmaW5kIG91dCB0aGUgZXJyb3JzIGluIHJ4ZSBjbGllbnQvc2VydmVyLg0KPiBIb3BlIHRo
ZSBhYm92ZSBjYW4gaGVscCB0byBmaW5kIG91dCB0aGUgZXJyb3JzLg0KPiANCj4gWmh1IFlhbmp1
bg0KPiANCj4+IA0KPj4gLS0NCj4+IENodWNrIExldmVyDQo+PiANCj4+IA0KDQotLQ0KQ2h1Y2sg
TGV2ZXINCg0KDQo=

