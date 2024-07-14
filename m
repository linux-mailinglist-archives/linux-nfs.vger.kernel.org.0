Return-Path: <linux-nfs+bounces-4886-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D565D930ABE
	for <lists+linux-nfs@lfdr.de>; Sun, 14 Jul 2024 18:20:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E3B1281695
	for <lists+linux-nfs@lfdr.de>; Sun, 14 Jul 2024 16:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9476213A879;
	Sun, 14 Jul 2024 16:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="L1PcduPh";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ZQrvVgvJ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78037F;
	Sun, 14 Jul 2024 16:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720974004; cv=fail; b=tiZ2A9ik7D+ZpzumkTnnMbl8T/kjH/QpOquzXtlJwromf4++2rQDWvEDZBF48aNxBjuL5KK6eTL06m/YQyZiiiTWjz/+37maucK4FCWPN6ZYHx7IfVg4XpSdIFeTNAr0Z9eM/bYFOzTxJG2i9JJU7QuOL1FIhyV/qjseqYe3vgs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720974004; c=relaxed/simple;
	bh=VMMpi+Wy8sUCnif/V28/oQvsGaGG3eLml2nn4rnOTGw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TfgGpdzqPfVrGS1PCGdHWQ7UG1/6eVMZbGfvQEt6elArGVgfdeYEcfTIUXoUk/5YLM5/cyjEJSQ8QRIcetZvzcJiGJRUEyRJA3e6YCKLEBQ+Y08b/zKg7k6+kFOUYLNO2tThJfcznHbkn2I/wl0clBcExhEarCPHGaU5Bw59+dA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=L1PcduPh; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ZQrvVgvJ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46E6UiDG009139;
	Sun, 14 Jul 2024 16:19:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=VMMpi+Wy8sUCnif/V28/oQvsGaGG3eLml2nn4rnOT
	Gw=; b=L1PcduPhMZv3rmyMaTnQvjstUcyrh0DgaqxOoaSF0RjXpy7O15cmZkcNV
	o+aMKTyAjf8w0wlLAjZp5jgbx9VDduJJocH1ckzwzdmj/LKX/fpLmqt41V5psmEF
	BJdP+tngQkp1tTxxJLYWQtWIMr/9FiCedATymuudU61xYQMFy732gD7WHd/7L8pd
	i4QYln9LFSDW4WouvLNeGW2SRqq4TaL3ouFNs/KALLi5BgZSdPfr1D3+8KhrrlRJ
	fmFOCCr3YGH4y+pCamA3iVI3L5r0rXKeZyB02qwYq2ujzUe1AB+KZ3xWrPT/4Wqv
	Lnt1rnF8RVIBh0eTWhfP9E83wT8NQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40bhmchm6v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 14 Jul 2024 16:19:30 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46EDtAIg020328;
	Sun, 14 Jul 2024 16:19:29 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40bg1bx5u1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 14 Jul 2024 16:19:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AUPFgZCNHGO8JcnRJ1SRX5jSIleR09Zs3wrdRyokJJaIxCdICvdZW65MFw32wQHFRPcb3ebG64dtHpK6Uw1tXoQ2zpYiXKfIWx3HxEE9oQNv4emcnz5VqpP/XzF24CrLmzZfLzUH2vxl0wJAXqHfP8tszj6QRg2QPBCJeKOoAOthhLi/3b5nScRHI5fYGx0F1msVSk3o2DNDeFiaIfpz3nQIBIMjcp5a20TIF3pIW2OXaRIR/8h0XlcOk66zgO3B+avxkkUXuX8XIkY1nho70AtdZUSDXaubmhkHaaC9twg0NUcmqkO+xsz/CcOJnXvfIsPy1WNC0VHxLNK/rCrY2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VMMpi+Wy8sUCnif/V28/oQvsGaGG3eLml2nn4rnOTGw=;
 b=QkFP86rtWk2oc672FeJCraKgMFXYr91nlp4SomlLGHCe8Y5+FmfXw+7WFEzvaKwOzPPgI0+T1r/z8hWRwRo4LEhAlek7gRnmkpxK2nBrz9z97V12xsfdrRL/RxyEptdgw132aupeOsedNCebPrKZ0A5QTWksa47inLf77bHab0lr8siWJs9iiogJUQhIvQxR3gsEkdABWZvzeDj9ntY9rvWITj+2TDNvuU5igSErmVC67n1xYUyLgoG5W27JcCAGP5VQHLDjbDs4DnEq5JevZ/KQ/I0JEgPKaREb1gZsN6lDoD3G2T8MiwZ6WaOKprdb4bo1DDdpa8C+uk55MI6rkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VMMpi+Wy8sUCnif/V28/oQvsGaGG3eLml2nn4rnOTGw=;
 b=ZQrvVgvJsIy2nL9dk2FdcbBvis2zJNDkotU5uELXgfNo7+IQ9wajmvbNKFblqelV4BIdt6qC6yR4A6UfaoAHHiSFzfEFpqW579W0KK6SzcdGIZlJ7yEKGqFiN7ayA5vfyYBej/SkZdDdQ4wfaJL4usu6a3m2uMDCJba3uzVoG6Y=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MN2PR10MB4336.namprd10.prod.outlook.com (2603:10b6:208:15f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Sun, 14 Jul
 2024 16:18:38 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7762.027; Sun, 14 Jul 2024
 16:18:37 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Neil Brown <neilb@suse.de>
CC: Gaosheng Cui <cuigaosheng1@huawei.com>,
        Trond Myklebust
	<trondmy@kernel.org>,
        Anna Schumaker <anna@kernel.org>, Jeff Layton
	<jlayton@kernel.org>,
        Olga Kornievskaia <kolga@netapp.com>, Dai Ngo
	<dai.ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH -next,v2] gss_krb5: refactor code to return correct
 PTR_ERR in krb5_DK
Thread-Topic: [PATCH -next,v2] gss_krb5: refactor code to return correct
 PTR_ERR in krb5_DK
Thread-Index: AQHa1CyLbOf4xub5RESSjWEB1T/BxLHzGWQAgAAN1ACAAn3iAIAAxXeA
Date: Sun, 14 Jul 2024 16:18:37 +0000
Message-ID: <8A935EDD-1959-474E-BB5B-92E0F8C2CF2A@oracle.com>
References: <ZpE9luTCrUnh8RBH@tissot.1015granger.net>
 <172093150291.15471.15426043640692195014@noble.neil.brown.name>
In-Reply-To: <172093150291.15471.15426043640692195014@noble.neil.brown.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.600.62)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|MN2PR10MB4336:EE_
x-ms-office365-filtering-correlation-id: 866fa920-75a0-47e3-ea48-08dca4209df3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|376014|366016|7416014|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?eTNmN2V0K20yMGZNaGx5enN2MTBnb0lLYW1jeHVMbW02MDNNUW9vL0ZWbm1D?=
 =?utf-8?B?MldrMWl1cmFvM2NHdEI4U3dBdGlzWE5YZUYwTTBIYnBFSkVBOSt2QTVyUUNo?=
 =?utf-8?B?SUtKZm5mcnhBT1RsUGRhRlNxS2s2SU1KbGdvT3ZBYUZtY3pBSFpxcFhpZTgx?=
 =?utf-8?B?QUMzanlFSENwQ0ZXSngzYlpPNHh3UHBaTjhrZW52VVhxL1VwZ0Q2azJzY3J0?=
 =?utf-8?B?NWRYemlzWlFMMHBUdngvQUlmbHRQdFRjOHJrU2pvWmhrb0MraDNJRC9HV1ht?=
 =?utf-8?B?U1AzUjM5K2Q4Wm13aGxqMkJ0cTlybU80UVdPM2dXZkZjOWVoaFZTYUsrZXRV?=
 =?utf-8?B?M1lxOWtBbzJ3MExOVnBDVVVyT0YwakVQOUJuZFYwZ2EvaUsxZHl3NjBqZHVI?=
 =?utf-8?B?dDJPVXRjSzlES20yZDhDa2lLQ2JRK0kzcXQwWEFaVDgxSWUzRWkxVCt0TXlJ?=
 =?utf-8?B?NlZmcUlINHJDV3JqczBUUWxhclVjdmlpa05iVGd0VmtoYlExODcwa3hRQ0Er?=
 =?utf-8?B?dVkzMWZRYnFRUjNtaW1wTVdiQ2l3VTlHV0VPTUxoNG1GR3BTVnV3ZUQrTGln?=
 =?utf-8?B?cktsb21uVFVWYzFFekVHM1VzN3h0ZDc3WGxOb1lVNUtXUnVJck1pM0Y4Z3JE?=
 =?utf-8?B?NDYrWnkxSEhvY0piTThWSjJEZ1ZSUFhOdHYzbnR3TS9NWnc5b0dtVGxIdGgz?=
 =?utf-8?B?YTZrazdvbkhDNUJwYlVRMVVnQ0l4S2VpbCtCd3VDY1ZIWmNwcnZ6VmNOVFB4?=
 =?utf-8?B?dHh3VERDVUxNTTAwSCs5YWRTRHJGaUZITktxM0R3Y3I0dlJRcFlEMDNxR3dZ?=
 =?utf-8?B?ckQ5S2xqeG1ZdnNnZTRLOTEwWkR0bTBHQW80RVNSQjd2cEVtdm53ZGpiRlg3?=
 =?utf-8?B?R3VYMVNUYUJab2Irc0NLVVF0VldtRFFTUW0vZ2JiT1IzdnZweHp1ZGJZQ09N?=
 =?utf-8?B?VWRTUEhDTXRkR2Nwdk9YODRiMERjVEJnTTVtMmMzMWo2VGZrRnp4bEpVUHlZ?=
 =?utf-8?B?UDNQQTFHamlNZUthNVVoN2JOQUVzTE9qZGIzczhtVmR0WVpSclVjM1FBK3NF?=
 =?utf-8?B?WWNOZ0lBUVdaS3d3ZWx0dHpkT1lWemJ1R0lrQnFLTFdpS3VIUkZIQk4yVGhr?=
 =?utf-8?B?RWN5L2VWNGM4dG5idWx4NytMUEFyZ1plZXovMHZWT2tRY1pQUUUvaDNzSmd2?=
 =?utf-8?B?L3B4bWw3cXgwdVFnZlBRdytPdWd6OXpGVG56YWtBdTc2czEzcGFPUjl5ckw0?=
 =?utf-8?B?NFFhdXA0emtHTUQvcDRZQXZGTFZzWEJlb09lY2ZyY3c3UTE4eXhmSDJoU2ZP?=
 =?utf-8?B?QTBSL2R1TVJ5TXVFcE1FYmJOZ2IwckoyMkZxd0R2ZGd1Zm56NkgxSzBHMXJ2?=
 =?utf-8?B?eUY4Wkorc0ZCQXNUaTNnZFF4NzB4ekhYL1pFM1FTMk1wYWlYcDRpYlRoOU4v?=
 =?utf-8?B?Y3NtN0R4Tm9sVXNwUzF6U3hjNmxKM1c2OTdsZ00reElxdC9Ob0JJT0hGOE91?=
 =?utf-8?B?cy9Vd29Ld3RsWEtzbXBXcXFrVnpCRm1QWVFYQWNwU0FUSkVXdlNXRTl5c3hF?=
 =?utf-8?B?SlN3QnRINXJYQ2Q1SlJaUnVvMDgvTmgxUGxGWm1RYzg4bThZZDVOKyszSStt?=
 =?utf-8?B?Y0huY0h4Z3FtNnBncWZabW84M0FVRnQxcyttKzJ1Y1FMOTVoL2RXN3lFRlc4?=
 =?utf-8?B?OW5EWkZpTHdjQjgreXUrQmRFUHZlWVdOOVdFSWQ0Qy8zOGR3eWdrL05ndjV5?=
 =?utf-8?B?NkxJbTRLck9FcE1LKzNCd0RBN2puMDI0eTZlSWNUMnh1dGgwMU53ZitwcnpQ?=
 =?utf-8?B?TkkrTXlYb0Z5VDJ2Zmcvem90UHZxc1ZFTnRCSklTb1p4K3lGc0RRU0hwYUZK?=
 =?utf-8?B?WURKMCs5RnM2b250TU1jNDV2RkJ3RHlJck96RW1CaVNIekE9PQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?SXVLaDg4R3I3UEZBMDhsRy9ObjRpNnBjR1RqbkJJZWp2ZnJrWWtuU1hKMVJi?=
 =?utf-8?B?WGhxcjhmbUwvTE5KZXBTRmlhenRzeEpPRk1ZTW9rRldsRmdHZEQ4d2EyOG1V?=
 =?utf-8?B?VVZlNXA4TEJkMUpxeDhWU3A2bndKVGxsOGJzZFlvN2pKNk1xVnIwRGhrcUNB?=
 =?utf-8?B?bmRkZ3hBOWI1dEN5Si9kKzBOZG5yeHJiS2xHMXRnMDhWVEdKbkRQekhxUGhM?=
 =?utf-8?B?dXBJMmVmR1hqMGpyb0J3dXJPY05zSVhxVVVFc01vT0Zxd25NZFAwdlVOSGFZ?=
 =?utf-8?B?cGxHb0ZRL29xS2ZVSE9VeXFNd3hNQmZiMHRoKytRbkJRM3hRRUVWZTUvUDJo?=
 =?utf-8?B?MDZ6S3lRRTRnUXBpUFRXMTUvTm1VRnVMdUhVTGF6MDNOQ0I1eWRwVnV3eWVF?=
 =?utf-8?B?Vmw0NDBrQmxGNGpSbkoxMzVmSVlXMlRscUdpaVM1bmVDZUJKZkRUbjhBaTUv?=
 =?utf-8?B?a3J2L1h5bytwOGN2VUZIeVgxYlhoUW52NkF1RU9OVmJMYUhKRlpZUGxpOXpJ?=
 =?utf-8?B?MTlBc08wSC9OdkliQjI3Z1NmK0FRT2Y5UXZxOVh5UnNIM081dHJ2MkVkdG9M?=
 =?utf-8?B?dkNaRHlKZXl0dHhrUVM3Q01hSDVLdEd4dmJGQU5QZU9LdmUwOXNGUGY2SDFu?=
 =?utf-8?B?aU5vUmhNQnMwWC9KeklPbW9pR01GTDZuS3BCbEdNWllQU1c1OVNWc3VZRmYx?=
 =?utf-8?B?UW5wL3FBb1J1Z3htMjBBamM2cjlSaVBsSFZCNEh4ekdtbG0wWHNraEhOYjR3?=
 =?utf-8?B?cEpzbW5tVS9lZWRueWRJbVdlUkhGenBsZGdNU3hqV1FhQnd5Wm5RdTArbTk4?=
 =?utf-8?B?MnFLQzB6QUF3emRGYzlwMEpBL3c1anVpc2d4eml3ay94aVZqMmJVN09OWWRL?=
 =?utf-8?B?SlRiUUtERkpEMFZYUm5pT09iVTUwM2FFbWVaRVE2MHpLUWROb3lnS1lycDht?=
 =?utf-8?B?S0JuZ1dxU1JCYXJVRDZNNlhGWFowaU1EaDRFTmFuUldETFcvbWNqTG13WlBi?=
 =?utf-8?B?SWVZaG5SZG96bWpGMFplN01iMUxRdHBjUlRsT0VqQlFVK3hrdkkrWHdYV214?=
 =?utf-8?B?ZVVxZ0pDaGcxc0RIbzNUR21tZG53b1pZS0NDVFBJeEhGNzRGR3BYNzc5aGUz?=
 =?utf-8?B?UmhsZyswMHRqZEE4OFVvcWFnbzVpSDBQbDJRaUEzSUJ2Yzc1NDc5ZnVzS0No?=
 =?utf-8?B?U1RoWWJMMWZRUEMwMkdmU3FNRThtZkEvTi9tTkNGVjVzWW9qcTlaTWkzMmpW?=
 =?utf-8?B?UHBNcTBwNCtTRldrbVoxckFyTmkySTM1bW5TR2k0ajQyOUpYdGJqRUtVYk1p?=
 =?utf-8?B?VytsaEVIWkFhYVZ5N0tVbDBxL3NKbzlydXVNcjZnVnhjdDB4Q01FQWMzZVA2?=
 =?utf-8?B?OFYxczJZcDBLYXBXcGk5SEZkWko3RmpMYUtqN21sOHAybEZhdkRiUjNYWkda?=
 =?utf-8?B?V01wRWd1WW50Vi9XMzF4ZEc5ZVZoNWpQTDhuRzlETlpyUnkwQUhiaUNGbzdx?=
 =?utf-8?B?ZXpGcXU3bERnRUN0MGFFOW9NOWN4N0JrVWNQWmVLbW84SE9GL3RGemlQVEhr?=
 =?utf-8?B?ZXVMV1d5UzNkWEtYcExSUEx0RDdrY1A1SlVQaEE1TzlvVmF1OVliQzV2dGx2?=
 =?utf-8?B?WjZPeWp0MU5za1I3SnV3SHM5RElteDZTQjk4WXZMQ2Vhb3FPbjR2WVAzbDhx?=
 =?utf-8?B?VFUzTGhqa2NBSUNWUFlEUDIwajVNeTZKNXhSVFhFU2c5R08xaW1DN2lGRzVa?=
 =?utf-8?B?RjI4QlEyd3BHcitRbzQ5MWx0SlZ6WWpPSmdjY096eExPTjZXTkx2dGZIVnNj?=
 =?utf-8?B?dWkrQk1laW5jNnBaWVpGN3ozMStmMXFIUTZBaG9jbHFSZnNLRWtYY2p5cGUx?=
 =?utf-8?B?MmFxWHBiT2J1ZWRNZTNSK0NwdnVMUDZVUUVLUHJkRlhqK1Y2cW4wd0RzOXU0?=
 =?utf-8?B?OTFON3l2TmFmVHZhS01ZcEM5QVNlKzQ4UDJNdkFWZTcycDczUXV0SDdOM1Jt?=
 =?utf-8?B?eUVNaGhKRXh2bU5VemppRmZrTjZaNDFuOW96Y2lvMHFKUWpGL0s1bnB6bEx2?=
 =?utf-8?B?QUlOSXVWS1k5UkxDdmhpbEFjYkR4YTJNM1M1Mm9ndVE3dmhqT0ozWFJ2elNP?=
 =?utf-8?B?MGNZWDVPTTdCR29MTVNPSnpSWUFIOERNblM2UHhXKzVmL0Z1czEzRkF3RXcv?=
 =?utf-8?B?Znc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <84E939513298C64987BFA42484C8A343@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	pHXAGnmKeG+DYzGbikYvrtsURW8uL2i0myHjgXKWpGzZDWyLpvLJDorZiMnvUqIAsyN2xwsnV+XoIG6PhZfmIMzIAWy8yAfQJPtYMbH5STfaDr+VY0oN90OlijxYbErRdjqSY9a/ry0sOA3JSmowKwI3mboZmJT3jLqQWZq/j/en23CwuoZa37GOCBq2uLlZIDICjPacrX4L0DTczzgc2SHPdtXSGRHd2EltK+FDx1QL15TIBC3sfNOS13ohcjd6S6xUZu6X3NSdZD9DmZRsxrnLS1Q2v92CQVups2+aLL2KC70ur5V0qXy9+ydaoIHVxQvcj2F5UDZjARTXNkTRk/oLprKfwMiNmQXTz7mvoYeslSO0ImixjuBPA9hlOqdyR0SbShtFKHj2SRYHJjkkpCUVmMEmQ2eeg+garLE98J1vglFJIguwSGTC1ZW6Ug8njFSEpqC9eD3DzeWK0e4PVupkfJDJOzCyeoLKBlzwwePpAguEFXsBb2STWY6yy+qmg/uBOI1rscxe++F4KZZZ3E6rk+tYMnDUrJqv5XsO4uDCNPACatLW3DwilHdWql7VmcFnhk9dGsV6qCU55GYKW2CmdFJCR6WBn+IQx0bS7O0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 866fa920-75a0-47e3-ea48-08dca4209df3
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2024 16:18:37.5376
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4NEab/48P+sOoN4u6hvlMqlg2bIVijIxhrt1JGNO4Qn/6lrnoFjpLigfbKvDhRUUQDxvIveP4VN313MnzNbUVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4336
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-14_11,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 mlxscore=0 phishscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407140129
X-Proofpoint-GUID: xvLOtxoGJEIf9vQclgq8Zl6oWfjvG3_-
X-Proofpoint-ORIG-GUID: xvLOtxoGJEIf9vQclgq8Zl6oWfjvG3_-

DQoNCj4gT24gSnVsIDE0LCAyMDI0LCBhdCAxMjozMeKAr0FNLCBOZWlsQnJvd24gPG5laWxiQHN1
c2UuZGU+IHdyb3RlOg0KPiANCj4gT24gU2F0LCAxMyBKdWwgMjAyNCwgQ2h1Y2sgTGV2ZXIgd3Jv
dGU6DQo+PiBPbiBGcmksIEp1bCAxMiwgMjAyNCBhdCAwOTozOTowOEFNIC0wNDAwLCBDaHVjayBM
ZXZlciB3cm90ZToNCj4+PiBPbiBGcmksIEp1bCAxMiwgMjAyNCBhdCAwMzoyNDoyM1BNICswODAw
LCBHYW9zaGVuZyBDdWkgd3JvdGU6DQo+Pj4+IFJlZmFjdG9yIHRoZSBjb2RlIGluIGtyYjVfREsg
dG8gcmV0dXJuIFBUUl9FUlIgd2hlbiBhbiBlcnJvciBvY2N1cnMuDQo+Pj4gDQo+Pj4gTXkgdW5k
ZXJzdGFuZGluZyBvZiB0aGUgY3VycmVudCBjb2RlIGlzIHRoYXQgaWYgZWl0aGVyDQo+Pj4gY3J5
cHRvX2FsbG9jX3N5bmNfc2tjaXBoZXIoKSBvciBjcnlwdG9fc3luY19za2NpcGhlcl9ibG9ja3Np
emUoKQ0KPj4+IGZhaWxzLCB0aGVuIGtyYjVfREsoKSByZXR1cm5zIC1FSU5WQUwuIEF0IHRoZSBv
bmx5IGNhbGwgc2l0ZSBmb3INCj4+PiBrcmI1X0RLKCksIHRoYXQgcmV0dXJuIGNvZGUgaXMgdW5j
b25kaXRpb25hbGx5IGRpc2NhcmRlZC4gVGh1cyBJDQo+Pj4gZG9uJ3Qgc2VlIHRoYXQgdGhlIHBy
b3Bvc2VkIGNoYW5nZSBpcyBuZWNlc3Nhcnkgb3IgaW1wcm92ZXMNCj4+PiBhbnl0aGluZy4NCj4+
IA0KPj4gTXkgdW5kZXJzdGFuZGluZyBpcyB3cm9uZyAgOy0pDQo+IA0KPiBUcnVlLCBidXQgSSB0
aGluayB5b3VyIGNvbmNsdXNpb24gd2FzIGNvcnJlY3QuDQo+IA0KPiBrcmI1X0RLKCkgcmV0dXJu
cyB6ZXJvIG9yIC1FSU5WQUwuDQo+IEl0IGlzIG9ubHkgdXNlZCBieSBrcmI1X2Rlcml2ZV9rZXlf
djIoKSwgd2hpY2ggcmV0dXJucyB6ZXJvIG9yIC1FSU5WQUwsDQo+IG9yIC1FTk9NRU0uDQoNClRo
ZXNlIGFyZSByZWFsbHkgdGhlIG9ubHkgdGhyZWUgaW50ZXJlc3RpbmcgcmV0dXJuIGNvZGVzLg0K
TGVha2luZyBvdGhlciBlcnJvciBjb2RlcyB0byBjYWxsZXJzIGlzIG5vdCBkZXNpcmFibGUsIElN
Ty4NCg0KQnV0IGxvb2tpbmcgYXQgdGhlIGN1cnJlbnQgaW1wbGVtZW50YXRpb24gb2YNCmNyeXB0
b19hbGxvY19zeW5jX3NrY2lwaGVyKCksIGl0IHJldHVybnMgZWl0aGVyDQpFUlJfUFRSKC1FSU5W
QUwpIG9yIGEgdmFsaWQgcG9pbnRlcjsgaXQgZG9lc24ndCByZXR1cm4gYW55DQpvdGhlciBlcnJv
ciB2YWx1ZS4gU2luY2UgaXQgbmV2ZXIgcmV0dXJucyAtRU5PTUVNLCB0aGVyZQ0Kc3RpbGwgZG9l
c24ndCBzZWVtIHRvIGJlIGEgdGVjaG5pY2FsIHJlYXNvbiBmb3IgbW9kaWZ5aW5nDQprcmI1X0RL
KCkgdG8gcGFzcyBlcnJvcnMgdGhyb3VnaC4NCg0KDQo+IGtyYjRfZGVyaXZlX2tleV92MigpIGlz
IG9ubHkgdXNlZCBhcyBhIC0+ZGVyaXZlX2tleSgpIG1ldGhvZC4NCj4gVGhpcyBpcyBjYWxsZWQg
ZnJvbSBrcmI1X2Rlcml2ZV9rZXkoKSwgYW5kIHZhcmlvdXMgdW5pdCB0ZXN0cyBpbg0KPiBnc3Nf
a3JiNV90ZXN0cy5jDQo+IA0KPiBrcmI1X2Rlcml2ZV9rZXkoKSBpcyBvbmx5IGNhbGxlZCBpbiBn
c3Nfa3JiNV9tZWNoLmMsIGFuZCBlYWNoIGNhbGwgc2l0ZQ0KPiBpcyBvZiB0aGUgZm9ybToNCj4g
IGlmIChrcmI1X2Rlcml2ZV9rZXkoLi4uKSkgZ290byBvdXQ7DQo+IHNvIGl0IGRvZXNuJ3QgbWF0
dGVyIHdoYXQgZXJyb3IgaXMgcmV0dXJuZWQuDQo+IA0KPiBUaGUgdW5pdCB0ZXN0IGNhbGxzIGFy
ZSBhbGwgZm9sbG93ZWQgYnkNCj4gS1VOSVRfQVNTRVJUX0VRKHRlc3QsIGVyciwgMCk7DQo+IHNv
IHRoZSBvbmx5IHBsYWNlIHRoZSBlcnIgaXMgdXNlZCBpcyAocHJlc3VtYWJseSkgaW4gZmFpbHVy
ZSByZXBvcnRzDQo+IGZyb20gdGhlIHVuaXQgdGVzdHMuDQo+IA0KPiBTbyB0aGUgcHJvcG9zZWQg
Y2hhbmdlIHNlZW1zIHVubmVjZXNzYXJ5IGZyb20gYSBwcmFjdGljYWwgcGVyc3BlY3RpdmUuDQo+
IA0KPiBNYXliZSBpdCBpcyBqdXN0aWZpZWQgZnJvbSBhbiBhZXN0aGV0aWMgcGVyc3BlY3RpdmUs
IGJ1dCBJIHRoaW5rIHRoYXQNCj4gc2hvdWxkIGJlIGNsZWFybHkgc3RhdGVkIGluIHRoZSBjb21t
aXQgbWVzc2FnZS4gIGUuZy4NCj4gDQo+ICBUaGlzIGNoYW5nZSBoYXMgbm8gcHJhY3RpY2FsIGVm
ZmVjdCBhcyBhbGwgbm9uLXplcm8gZXJyb3Igc3RhdHVzZXMNCj4gIGFyZSB0cmVhdGVkIGVxdWFs
bHksIGhvd2V2ZXIgdGhlIGRpc3RpbmN0aW9uIGJldHdlZW4gRUlOVkFMIGFuZCBFTk9NRU0NCj4g
IG1heSBiZSByZWxldmFudCBhdCBzb21lIGZ1dHVyZSB0aW1lIGFuZCBpdCBzZWVtcyBjbGVhbmVy
IHRvIG1haW50YWluDQo+ICB0aGUgZGlzdGluY3Rpb24uDQo+IA0KPiBOZWlsQnJvd24NCj4gDQo+
IA0KPj4gDQo+PiBUaGUgcmV0dXJuIGNvZGUgaXNuJ3QgZGlzY2FyZGVkLiBBIG5vbi16ZXJvIHJl
dHVybiBjb2RlIGZyb20NCj4+IGtyYjVfREsoKSBpcyBjYXJyaWVkIGJhY2sgdXAgdGhlIGNhbGwg
c3RhY2suIFRoZSBsb2dpYyBpbg0KPj4ga3JiNV9kZXJpdmVfa2V5X3YyKCkgZG9lcyBub3QgdXNl
IHRoZSBrZXJuZWwncyB1c3VhbCBlcnJvciBmbG93DQo+PiBmb3JtLCBzbyBJIG1pc3NlZCB0aGlz
Lg0KPj4gDQo+PiBIb3dldmVyLCBpdCBzdGlsbCBpc24ndCBjbGVhciB0byBtZSB3aHkgdGhlIGVy
cm9yIGJlaGF2aW9yIGhlcmUNCj4+IG5lZWRzIHRvIGNoYW5nZS4gSXQncyBwb3NzaWJsZSwgZm9y
IGV4YW1wbGUsIHRoYXQgLUVJTlZBTCBpcw0KPj4gcGVyZmVjdGx5IGFkZXF1YXRlIHRvIGluZGlj
YXRlIHdoZW4gc3luY19za2NpcGhlcigpIGNhbid0IGZpbmQgdGhlDQo+PiBzcGVjaWZpZWQgZW5j
cnlwdGlvbiBhbGdvcml0aG0gKGdrNWUtPmVuY3J5cHRfbmFtZSkuDQo+PiANCj4+IFNwZWNpZnlp
bmcgdGhlIHdyb25nIGVuY3J5cHRpb24gdHlwZTogLUVJTlZBTC4gVGhhdCBtYWtlcyBzZW5zZS4N
Cj4+IA0KPj4gDQo+Pj4+IFNpZ25lZC1vZmYtYnk6IEdhb3NoZW5nIEN1aSA8Y3VpZ2Fvc2hlbmcx
QGh1YXdlaS5jb20+DQo+Pj4+IC0tLQ0KPj4+PiB2MjogVXBkYXRlIElTX0VSUiB0byBQVFJfRVJS
LCB0aGFua3MgdmVyeSBtdWNoIQ0KPj4+PiBuZXQvc3VucnBjL2F1dGhfZ3NzL2dzc19rcmI1X2tl
eXMuYyB8IDggKysrKysrLS0NCj4+Pj4gMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwg
MiBkZWxldGlvbnMoLSkNCj4+Pj4gDQo+Pj4+IGRpZmYgLS1naXQgYS9uZXQvc3VucnBjL2F1dGhf
Z3NzL2dzc19rcmI1X2tleXMuYyBiL25ldC9zdW5ycGMvYXV0aF9nc3MvZ3NzX2tyYjVfa2V5cy5j
DQo+Pj4+IGluZGV4IDRlYjE5YzNhNTRjNy4uNWFjOGQwNmFiMmMwIDEwMDY0NA0KPj4+PiAtLS0g
YS9uZXQvc3VucnBjL2F1dGhfZ3NzL2dzc19rcmI1X2tleXMuYw0KPj4+PiArKysgYi9uZXQvc3Vu
cnBjL2F1dGhfZ3NzL2dzc19rcmI1X2tleXMuYw0KPj4+PiBAQCAtMTY0LDEwICsxNjQsMTQgQEAg
c3RhdGljIGludCBrcmI1X0RLKGNvbnN0IHN0cnVjdCBnc3Nfa3JiNV9lbmN0eXBlICpnazVlLA0K
Pj4+PiBnb3RvIGVycl9yZXR1cm47DQo+Pj4+IA0KPj4+PiBjaXBoZXIgPSBjcnlwdG9fYWxsb2Nf
c3luY19za2NpcGhlcihnazVlLT5lbmNyeXB0X25hbWUsIDAsIDApOw0KPj4+PiAtIGlmIChJU19F
UlIoY2lwaGVyKSkNCj4+Pj4gKyBpZiAoSVNfRVJSKGNpcGhlcikpIHsNCj4+Pj4gKyByZXQgPSBQ
VFJfRVJSKGNpcGhlcik7DQo+Pj4+IGdvdG8gZXJyX3JldHVybjsNCj4+Pj4gKyB9DQo+Pj4+ICsN
Cj4+Pj4gYmxvY2tzaXplID0gY3J5cHRvX3N5bmNfc2tjaXBoZXJfYmxvY2tzaXplKGNpcGhlcik7
DQo+Pj4+IC0gaWYgKGNyeXB0b19zeW5jX3NrY2lwaGVyX3NldGtleShjaXBoZXIsIGlua2V5LT5k
YXRhLCBpbmtleS0+bGVuKSkNCj4+Pj4gKyByZXQgPSBjcnlwdG9fc3luY19za2NpcGhlcl9zZXRr
ZXkoY2lwaGVyLCBpbmtleS0+ZGF0YSwgaW5rZXktPmxlbik7DQo+Pj4+ICsgaWYgKHJldCkNCj4+
Pj4gZ290byBlcnJfZnJlZV9jaXBoZXI7DQo+Pj4+IA0KPj4+PiByZXQgPSAtRU5PTUVNOw0KPj4+
PiAtLSANCj4+Pj4gMi4yNS4xDQo+Pj4+IA0KPj4+IA0KPj4+IC0tIA0KPj4+IENodWNrIExldmVy
DQo+Pj4gDQo+PiANCj4+IC0tIA0KPj4gQ2h1Y2sgTGV2ZXINCj4+IA0KPiANCg0KLS0NCkNodWNr
IExldmVyDQoNCg0K

