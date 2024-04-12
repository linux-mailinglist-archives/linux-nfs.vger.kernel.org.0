Return-Path: <linux-nfs+bounces-2791-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C74658A36BA
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Apr 2024 22:07:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E10B284AC8
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Apr 2024 20:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE0DF150997;
	Fri, 12 Apr 2024 20:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="P4opqvyk";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="z/jVqVd3"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53A014F9D6;
	Fri, 12 Apr 2024 20:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712952456; cv=fail; b=pqFFK2XKihiB4UG8zaC/+JhuUR7ksUDDOa4Pgn/1Fnuxh/e0LBaN2mSNvdOtQ9Xi4RhlsWCveKUICFQay3QR2Cgy+WA6jqJ7gqYau+0ROybH8uhumJ95Kl5KD0o30zJ7nyrtzNUw7hIA4yjcIuJYTgcgEAPDOiMheiJvOajsNtI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712952456; c=relaxed/simple;
	bh=VfRW+bfs6hIDE0ho3/xLKyHD6fboDSoujAIX0UldAP8=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nMB4LXDq3rAbvHxkzOCfwG7l4Pj3cqEhuMN+/RD6B/6qzu2rjpgOPXW+/jx7Hj9BaoLUhca/zEbuvvLx+VlgAwbVahY82bCfhM+zGnX9dGP6O6ChAS/dXOT3jVRisDoI2osbLiCYoh/RZa5KSAfCheov/rmK3QDegffORokNteE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=P4opqvyk; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=z/jVqVd3; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43CHVKxx008118;
	Fri, 12 Apr 2024 20:07:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 cc : subject : to : references : from : in-reply-to : content-type :
 mime-version; s=corp-2023-11-20;
 bh=W/AbXZJNiCxLy82E2lollIFvxa9hY0A5pMGrM8mWvR8=;
 b=P4opqvykIH46qlMNHGFjOm3sbr2ydXPtIZWB4cLOhz6eoQ+QWodg+5ZnhUQDlX90mY/t
 1Ae5kvgiNd0V0gmQH8iQxDsaqFMpXWPNJDqGAwYJNJL15YNbtdMwqykE90cVipJKCDig
 VgD0KwqMH8hlf7lnhPc7cpv7YEnOgGIVfoFCchirdPpr7Ribqay0CwVO8C54+z4rLO8r
 rna3Xnqhnrp2lTixNI7mJQxAF24bCpUzO869PhhPk9qhY9RRTePchhFIln1PU1pRAGV5
 bJnsTHW5z3tGOmi+AYtUWDKoGk1lRSLOsssGtmFrVzN8yxHm+IJrHrO3oE8gIW/Vkui8 Rw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xaxedvrce-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Apr 2024 20:07:04 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43CK28tm010595;
	Fri, 12 Apr 2024 20:07:03 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xavubemu5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Apr 2024 20:07:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FremHpvLUfeWQ/f4s3tk5S8QKC+r5LN0yiUk1lRZpv2pAhzM+e8gNGRBJZuMFwaGp37vthk5kcnHcXDe6CA5Njcxdlgjndfl/sDRUCCQhQYUAyVjLGiKO/utabH2b73cb4+4nV8u0StqJ+XDqJEYYahlMZohiSm86lU338COsOMPkZgCOb5aWBnmFpixgmlT/OKXSw1ylF8st+u2NpMAndYm+pW7Wg9ZnP8euU75+GpV0AUPbmpTeMI1ZXxGMDi8lpG2gs/C3DkrmVSfLmQIFcF3YL2LPZZ14yqSvf1gwlfwdW/JGS1H8CXzfTk78IqfI28oEvwrUciffrD4CIha0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W/AbXZJNiCxLy82E2lollIFvxa9hY0A5pMGrM8mWvR8=;
 b=R5EGJxxWKq0Uf0/PffksJlAmBh90dqn5H8/mCDFE6SAjzd1C5kFMKa8dUxUhOallDh+Y3f3HLWce+ajNK3ERbuNDgODITInvxDd7UcbdOHwthC0xUJvu79GUpz0f946UorPn27okwaYI1C354A+qzWAXANNDLXQsx8W5PJMqXAhfm49dZ/sjffKJSkR9rehWP7n7+DZmYFwoHVOQY9fIJ6x7fMS5YA6g/iAVK4jJpjGyeMNKYpJUT2wfWocO/MIJE4P33iORKx0N1HwZgPsdLNFgGWBGRZ/6VLoMr1duiNEMSsa7pZBcIkhkCHZXeCM6fEXbC31cKk3CYNuyN3M6Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W/AbXZJNiCxLy82E2lollIFvxa9hY0A5pMGrM8mWvR8=;
 b=z/jVqVd3yI0Pt2zufpeATJlvQR7L6j76VU3XERo5kB/YcduzzagGauhvVmTW1x05ggClu3MmWNhNDXE6xSFD1chEXJrk7ii0CbXTZr1BKVBxKlR6NF2+qzhV2U8jKmAPIYkjecJcni1f1A5e7DzGjS6AvMA7rL85QZkGKBx/nPE=
Received: from BLAPR10MB5138.namprd10.prod.outlook.com (2603:10b6:208:322::8)
 by PH7PR10MB6967.namprd10.prod.outlook.com (2603:10b6:510:271::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Fri, 12 Apr
 2024 20:06:33 +0000
Received: from BLAPR10MB5138.namprd10.prod.outlook.com
 ([fe80::c6b9:8141:e426:b08a]) by BLAPR10MB5138.namprd10.prod.outlook.com
 ([fe80::c6b9:8141:e426:b08a%3]) with mapi id 15.20.7409.053; Fri, 12 Apr 2024
 20:06:33 +0000
Message-ID: <8b125c1d-c7de-4df1-b8fc-5e2ae2279f32@oracle.com>
Date: Fri, 12 Apr 2024 21:06:19 +0100
User-Agent: Thunderbird Daily
Cc: Calum Mackay <calum.mackay@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-stable <stable@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck
 <linux@roeck-us.net>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "patches@kernelci.org" <patches@kernelci.org>,
        "lkft-triage@lists.linaro.org" <lkft-triage@lists.linaro.org>,
        "pavel@denx.de" <pavel@denx.de>,
        "jonathanh@nvidia.com"
 <jonathanh@nvidia.com>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "sudipm.mukherjee@gmail.com" <sudipm.mukherjee@gmail.com>,
        "srw@sladewatkins.net" <srw@sladewatkins.net>,
        "rwarsow@gmx.de" <rwarsow@gmx.de>,
        "conor@kernel.org" <conor@kernel.org>,
        "allen.lkml@gmail.com" <allen.lkml@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Darren Kenny <darren.kenny@oracle.com>,
        Ramanan Govindarajan <ramanan.govindarajan@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 5.15 00/57] 5.15.155-rc1 review
To: Chuck Lever III <chuck.lever@oracle.com>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
References: <20240411095407.982258070@linuxfoundation.org>
 <2c2362c7-ace7-4a79-861e-fa435e46ac85@oracle.com>
 <27E1E4C4-86C3-4D78-AF85-50C1612675E0@oracle.com>
Content-Language: en-GB
From: Calum Mackay <calum.mackay@oracle.com>
Autocrypt: addr=calum.mackay@oracle.com; keydata=
 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
 smRifw1wGg==
Organization: Oracle
In-Reply-To: <27E1E4C4-86C3-4D78-AF85-50C1612675E0@oracle.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------bvtmbK4lY0foW2TuE3ZgtcwH"
X-ClientProxiedBy: LO3P265CA0030.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:387::12) To BLAPR10MB5138.namprd10.prod.outlook.com
 (2603:10b6:208:322::8)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5138:EE_|PH7PR10MB6967:EE_
X-MS-Office365-Filtering-Correlation-Id: 04730c20-efa0-4ce3-5f3a-08dc5b2c0c76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	sK/6zQPYJpa3uQT86nYfnR9bA19/YmeaPfMkGUI2ZEI+2vSRoe+x+sZrNOCQeY/n/y+mQinhdJshAY2K76czvsjEJc9lgXaMGCi++w7lx4Cce7pkkdYWitQAlPEUyZvJtYpltHKPYAlx47ZeWE5QHoQDDKSsJ+oDuZpQXAhhYNaksAmv5KtQaUjTafs49EcUmhrX7JLOYMizeZTcXTIiYD/0TlpLAw9aJoU4Ro5PtADurSaOwxisIVEFsqGUjcYx02yWlu6HFUXU/J0HIqvVXvJdrcilv6qLwa1mGk+LDcXwEozytlYWEPrzEh1T/wwVxUIKdWfaIjCc1CILz8MmDGjfzLad0JvLgcAWThlGzmLHbRH6GuYRH31zsGUwd8mjNLxX/K+gqpF5GxxMlvO/uxDj+I29mGu+IZf5Lr7xzuGPb4mlpE9qPonZeyDBC5cPR9LOsykYbHeU1Ahc1w2HmeDPTMn4qRYmTKkaMt1DwFUGf8PzuIcEQXjOrSnaB8xvmyzLFe08ekKAq/ynYj2GWixmW+0dcZHRvyrKFGlEfW71XPVusWEzLA1B1BlwGBLDXJ61uXjb8Ld4yM4FID666HaDJpxaJpm87VdcVdHrEAm3Dr+LBs2pFHe2FjGeb+juI9LR6RI+uxKWa3c2a0hauunYAvSvZUnk0HAtiel1fxs=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5138.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?cUI4ZjE2Mlk3SWdTQ1NPeit2dlRlWDBTMm15YS9aaE5vZ1hKbU5odDByTW5l?=
 =?utf-8?B?U21JWnJ1MWJKUU5DMmllUnNyOGsrMlg3SjVxRDJjdnE0VHJiQ2xXT2d4SFRP?=
 =?utf-8?B?YTl1N1pIOVhrNkRSdWJTSVZkTGN0blVzT2xqeDdTQ1VFQmZKbFJQdDJVeWZK?=
 =?utf-8?B?K0lFRzcwOXNveXhxV3ZDRTE0V25aLzZNVUU2RS8zL2w3L3Y4V003eW9ObzBU?=
 =?utf-8?B?c1BGY2hqbFhldGJUSWZlOXZhN1hiYitkcDNOYmlZODJzYVY4U01lZnp2cDFC?=
 =?utf-8?B?alQvZDExcmNKZmpiR1RQbTA4YlpadjlibFN6b0YvMFZib3hEZndpS2R2cCto?=
 =?utf-8?B?ekJiUWYyenlmWTE5YW90UENKdUhRTTdOS3FRdEtydFhyOWlHajN2a1NON3c2?=
 =?utf-8?B?N0JRQWJmdHkvRDRSQWJrWmNIc0lOQmJlUEJ5RG14SWFMdTFYcnR6T3JZSkFP?=
 =?utf-8?B?UmRRNW5xRCtjd1NkQk1hREZOUzhWOGFvWHJkMGIxYzE0WThQTXJDc1VQRkxU?=
 =?utf-8?B?b3AwTXliN1BNaCtpZjhzU0Q2bVJKL2JULzFaajhncGpUWlpRbmxlQ3NRaHBW?=
 =?utf-8?B?Ti9LSVNhTkhnWDY2MzVTR21ZUWFTSnpRTlZJLzl3cjQrMnBoR2pjZWxwelZs?=
 =?utf-8?B?em5MNlllYW9aekMwd2hZM1RsVWIxK1FiYk1TeXkwaXk4cGdIb2NzUElUbUc4?=
 =?utf-8?B?NnIxMjdxSW1peVBVMFRpdmNid1kxQ1JXeUhDaXRrWVFUUG5ZSTZ0TGlhSE1r?=
 =?utf-8?B?QVhxaGoxWC8rSEhDbktab3kwWXQ2czJXRHAwUld0Mno5dkZ0YjJCZzIyNysv?=
 =?utf-8?B?M1FEZFlJS3cxZjhnMEZZS243OUdkbndnRnJUMzUvRVFtUVF2Ni9RWUhRRUV6?=
 =?utf-8?B?ZzYyeXJPNUdkbHlPSlhGVGVZRi9ybjB2bFZESGpNOUpiK3BmUVNhWFdrWjdF?=
 =?utf-8?B?MStEVUJ1Z0RqN3IxRlU3NjZlWXJ4cDNZZnB5azRoTi94M29sUHN0ZUdJekxa?=
 =?utf-8?B?SGZZWGtPanArSVloRUJKUXdHL0xmS01tbWl3N1ZqZlRHMmxPek1hQ3pSR0N0?=
 =?utf-8?B?SElUemczblVYSVpFSllXUUVjbk1VVjJxL0twbDREeWVvN1FGUEdWb0NGaFNp?=
 =?utf-8?B?QjN3UTQ0Mmo0cWhpaTBTeldsRzYyZnZYN0xuRWdRakMxeXFnR05TRTdRdTF2?=
 =?utf-8?B?Q3UyNTNObjBmZ0xDQnJwR28vTG9RbjRrV1BsNDl4bktyMVBjaXo5anBMaDZv?=
 =?utf-8?B?UkU2akdCNUhoRUlhRWNobU52UzVGckhCeVd0bE4xNW9FVUZPYjVhakJoeTNt?=
 =?utf-8?B?aWlwZDFJRzc0NXFiQmd6dmY4N3RFZENwWEZjVmloWUh1cGFKWk1qOWN3MUFJ?=
 =?utf-8?B?YjhlTTMxRVJiY1J2VW4vc3BPUmwwK096bjIvejIwbWZ5T2xsTmx3ckVuWThm?=
 =?utf-8?B?TmR1dFNqYzR3ZXZoZWJVMUx6S3JmbWk3OFR0emJKem54T28yTHhvOGhNamhm?=
 =?utf-8?B?N3V3M2lJS1JZL1cxWGpXZmZmZkhqdkdDR3o0L2cyUlR6NWd1bGx5TEtiRzJU?=
 =?utf-8?B?dWR2U0VHcGV2WklONXd5WTB6bjdVcDlYb1pFT0Jtc2kwMnpuL1o3bkhBdFBL?=
 =?utf-8?B?dW9yMVVyV3RleWtiQ0d0eEVuQjBFSHVCb1BQTVc2b0lBMy9VZnA2Nm50eDF2?=
 =?utf-8?B?VkhIQWJFNm9HYkRLM0xRbEVRV3JLWUpXaFAzYkxpejdsWUF6SlhIdkFaajNn?=
 =?utf-8?B?cVlPMzVKK0I2NzBkV3JVL0pUbjh5YVdXMG5PTlBJT3VZQzN6VVZuMlhNZEJO?=
 =?utf-8?B?Y3NqbWVJandxa2tTNEF1UVBlaFVrbXFtdVh3a0JPdzRLWUNqK2xCMmwwYnB3?=
 =?utf-8?B?cWNxZklFZzZQQ3pNYzNlSmR3d2JXYjdTSzltSlVDdVZScDBFS1Nta2RzdHNO?=
 =?utf-8?B?SkI4ZEpYSWJTZmhUOG1zMVk0dndFT0ZyeUJPZUx5OUVleFdVYUFrMnpRcml6?=
 =?utf-8?B?SmJsdU9saWpJNVh6em96QWRUZUdMMVRldkx6em5PT0N5R2l0bEtpVnVMelhq?=
 =?utf-8?B?a3A2eUpSZ2JDWnF3L3E3K2RtQndXSVNSV3hyTEkrSWpjOHNaUU8vRjhxU2hC?=
 =?utf-8?B?TFFhZnBsMm5RODJRN3dlUmRPaWp4d0tnVzdJZnJtSmhoZWFYb1JyVTJvNXB1?=
 =?utf-8?B?TGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	kWv4EdLJ1nnoSSC/hCbbJCHbb6yN9/i1pnz2PTuSc73M64vVf8qHGyvTb8Z6sNazdSm0ix9T+R7glj6l+jDi1VEnHxRZV9zZn5NI7+Wc/Oj5iG56BuLwXp0Iz2ZuH487PYjnFnvG+Shwl429L1olslQuew+/j/16Yb9T7sbt5RQyIo9sp/B9jmAmGSjLoOOXcuUcbtxJU1ZTCVeIN2AUUiC/5zEi74vRzAWw/YtMRRa6gNtG0fngQmNZCYIjEMIOxEPdcfFRaKXQf/2kkyMTv/6dSVQ5IUM+0Gst+rpUd8rXbmSMp8KpqhSYXI8l+HF5qUNTh18jiaUlDs1fzwQe0Dy/SqxT5y8cPJsf+cEm2/sj5g0NT7sLpJ8aUub90XxZsfuU6HTQONQ9CDuJ6oBbyVXPHnUpL9t3bMixsB9/Pqx4SFYiVprD2nGqBkE09m99A3QKVzmrozpTUhMSP1vsY8pOJHRKCefB/yJGSU2r1j/cANz3IsqwDvvoPKnkUyOYiUl+6iACg1BgQa6a88BFEg8gm3xRQZkqr3gQcps9Lk74D7dIEBcZonWqcXHI7guzUN4DcK2rQqoyEOz0rSw59FuN+etkWgQNip3uWAyvwWo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04730c20-efa0-4ce3-5f3a-08dc5b2c0c76
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5138.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 20:06:32.9182
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gSs2Dp69B0eDm0SoqWo+m1IhnckzjntHGEdFDfE1G4Lu6Sq/SL0sZTAf1jWu0HSzk5KKz8+jqsF495c0cWpVug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6967
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-12_16,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 spamscore=0 mlxscore=0 bulkscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404120147
X-Proofpoint-GUID: 1v-9ekv_T4mIuZAuUkF2SA6c-9a3zzF5
X-Proofpoint-ORIG-GUID: 1v-9ekv_T4mIuZAuUkF2SA6c-9a3zzF5

--------------bvtmbK4lY0foW2TuE3ZgtcwH
Content-Type: multipart/mixed; boundary="------------SWH3kMSHEHZEGIZ147iNW4vH";
 protected-headers="v1"
From: Calum Mackay <calum.mackay@oracle.com>
To: Chuck Lever III <chuck.lever@oracle.com>,
 Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: Calum Mackay <calum.mackay@oracle.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-stable <stable@vger.kernel.org>,
 "patches@lists.linux.dev" <patches@lists.linux.dev>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Andrew Morton <akpm@linux-foundation.org>, Guenter Roeck
 <linux@roeck-us.net>, "shuah@kernel.org" <shuah@kernel.org>,
 "patches@kernelci.org" <patches@kernelci.org>,
 "lkft-triage@lists.linaro.org" <lkft-triage@lists.linaro.org>,
 "pavel@denx.de" <pavel@denx.de>, "jonathanh@nvidia.com"
 <jonathanh@nvidia.com>, "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
 "sudipm.mukherjee@gmail.com" <sudipm.mukherjee@gmail.com>,
 "srw@sladewatkins.net" <srw@sladewatkins.net>,
 "rwarsow@gmx.de" <rwarsow@gmx.de>, "conor@kernel.org" <conor@kernel.org>,
 "allen.lkml@gmail.com" <allen.lkml@gmail.com>,
 "broonie@kernel.org" <broonie@kernel.org>,
 Vegard Nossum <vegard.nossum@oracle.com>,
 Darren Kenny <darren.kenny@oracle.com>,
 Ramanan Govindarajan <ramanan.govindarajan@oracle.com>,
 Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Message-ID: <8b125c1d-c7de-4df1-b8fc-5e2ae2279f32@oracle.com>
Subject: Re: [PATCH 5.15 00/57] 5.15.155-rc1 review
References: <20240411095407.982258070@linuxfoundation.org>
 <2c2362c7-ace7-4a79-861e-fa435e46ac85@oracle.com>
 <27E1E4C4-86C3-4D78-AF85-50C1612675E0@oracle.com>
In-Reply-To: <27E1E4C4-86C3-4D78-AF85-50C1612675E0@oracle.com>

--------------SWH3kMSHEHZEGIZ147iNW4vH
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/04/2024 4:57 pm, Chuck Lever III wrote:
> 
> 
>> On Apr 12, 2024, at 6:25 AM, Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com> wrote:
>>
>> Hi Greg,
>>
>>
>> On 11/04/24 15:27, Greg Kroah-Hartman wrote:
>>> This is the start of the stable review cycle for the 5.15.155 release.
>>> There are 57 patches in this series, all will be posted as a response
>>> to this one.  If anyone has any issues with these being applied, please
>>> let me know.
>>> Responses should be made by Sat, 13 Apr 2024 09:53:55 +0000.
>>> Anything received after that time might be too late.
>>
>> I have noticed a regression in lts test case with nfsv4 and this was overlooked in the previous cycle(5.15.154). So the regression is from 153-->154 update. And I think that is due to nfs backports we had in 5.15.154.
>>
>> # ./runltp -d /tmpdir -s fcntl17
>>
>> <<<test_start>>>
>> tag=fcntl17 stime=1712915065
>> cmdline="fcntl17"
>> contacts=""
>> analysis=exit
>> <<<test_output>>>
>> fcntl17     0  TINFO  :  Enter preparation phase
>> fcntl17     0  TINFO  :  Exit preparation phase
>> fcntl17     0  TINFO  :  Enter block 1
>> fcntl17     0  TINFO  :  child 1 starting
>> fcntl17     0  TINFO  :  child 1 pid 22904 locked
>> fcntl17     0  TINFO  :  child 2 starting
>> fcntl17     0  TINFO  :  child 2 pid 22905 locked
>> fcntl17     0  TINFO  :  child 3 starting
>> fcntl17     0  TINFO  :  child 3 pid 22906 locked
>> fcntl17     0  TINFO  :  child 2 resuming
>> fcntl17     0  TINFO  :  child 3 resuming
>> fcntl17     0  TINFO  :  child 1 resuming
>> fcntl17     0  TINFO  :  child 3 lockw err 35
>> fcntl17     0  TINFO  :  child 3 exiting
>> fcntl17     0  TINFO  :  child 1 unlocked
>> fcntl17     0  TINFO  :  child 1 exiting
>> fcntl17     1  TFAIL  :  fcntl17.c:429: Alarm expired, deadlock not detected
>> fcntl17     0  TWARN  :  fcntl17.c:430: You may need to kill child processes by hand
>> fcntl17     2  TPASS  :  Block 1 PASSED
>> fcntl17     0  TINFO  :  Exit block 1
>> fcntl17     0  TWARN  :  tst_tmpdir.c:342: tst_rmdir: rmobj(/tmpdir/ltp-jRFBtBQhhx/LTP_fcnp7lqPn) failed: unlink(/tmpdir/ltp-jRFBtBQhhx/LTP_fcnp7lqPn) failed; errno=2: ENOENT
>> <<<execution_status>>>
>> initiation_status="ok"
>> duration=10 termination_type=exited termination_id=5 corefile=no
>> cutime=0 cstime=0
>> <<<test_end>>>
>> <<<test_start>>>
>> tag=fcntl17_64 stime=1712915075
>> cmdline="fcntl17_64"
>> contacts=""
>> analysis=exit
>> <<<test_output>>>
>> incrementing stop
>> fcntl17     0  TINFO  :  Enter preparation phase
>> fcntl17     0  TINFO  :  Exit preparation phase
>> fcntl17     0  TINFO  :  Enter block 1
>> fcntl17     0  TINFO  :  child 1 starting
>> fcntl17     0  TINFO  :  child 1 pid 22909 locked
>> fcntl17     0  TINFO  :  child 2 starting
>> fcntl17     0  TINFO  :  child 2 pid 22910 locked
>> fcntl17     0  TINFO  :  child 3 starting
>> fcntl17     0  TINFO  :  child 3 pid 22911 locked
>> fcntl17     0  TINFO  :  child 2 resuming
>> fcntl17     0  TINFO  :  child 3 resuming
>> fcntl17     0  TINFO  :  child 1 resuming
>> fcntl17     0  TINFO  :  child 3 lockw err 35
>> fcntl17     0  TINFO  :  child 3 exiting
>> fcntl17     0  TINFO  :  child 1 unlocked
>> fcntl17     0  TINFO  :  child 1 exiting
>> fcntl17     1  TFAIL  :  fcntl17.c:429: Alarm expired, deadlock not detected
>> fcntl17     0  TWARN  :  fcntl17.c:430: You may need to kill child processes by hand
>> fcntl17     2  TPASS  :  Block 1 PASSED
>> fcntl17     0  TINFO  :  Exit block 1
>> fcntl17     0  TWARN  :  tst_tmpdir.c:342: tst_rmdir: rmobj(/tmpdir/ltp-jRFBtBQhhx/LTP_fcn9Xy4hM) failed: unlink(/tmpdir/ltp-jRFBtBQhhx/LTP_fcn9Xy4hM) failed; errno=2: ENOENT
>> <<<execution_status>>>
>> initiation_status="ok"
>> duration=10 termination_type=exited termination_id=5 corefile=no
>> cutime=0 cstime=0
>> <<<test_end>>>
>> INFO: ltp-pan reported some tests FAIL
>> LTP Version: 20240129-167-gb592cdd0d
>>
>>
>> Steps used after installing latest ltp:
>>
>> $ mkdir /tmpdir
>> $ yum install nfs-utils  -y
>> $ echo "/media *(rw,no_root_squash,sync)" >/etc/exports
>> $ systemctl start nfs-server.service
>> $ mount -o rw,nfsvers=3 127.0.0.1:/media /tmpdir
>> $ cd /opt/ltp
>> $ ./runltp -d /tmpdir -s fcntl17
>>
>>
>>
>> This does not happen in 5.15.153 tag.
>>
>> Adding nfs people to the CC list
> 
> The reproducer uses NFSv3, but the bug report says NFSv4
> at the top.
> 
> I was able to reproduce this on my nfsd-5.15.y branch
> with NFSv3.
> 
> A bisect would be most helpful.

Interestingly, this same LTP fcntl17 test failure was reported to me 
internally some time back, in late 2022; at the time it was bisected to:

6930bcbfb6ce lockd: detect and reject lock arguments that overflow
	mainline v6.0-rc1
	stable v5.15.61

However, the failure was intermittent, and seemed very dependent on test 
system configuration; eventually it disappeared, so I put it down to 
test issues.


Harshit will continue to bisect this new case.

cheers,
calum.

> 
> 
>> Thanks,
>> Harshit
>>
>>
>>
>>
>>
>>> The whole patch series can be found in one patch at:
>>> https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.155-rc1.gz
>>> or in the git tree and branch at:
>>> git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
>>> and the diffstat can be found below.
>>> thanks,
>>> greg k-h
> 
> --
> Chuck Lever
> 
> 



--------------SWH3kMSHEHZEGIZ147iNW4vH--

--------------bvtmbK4lY0foW2TuE3ZgtcwH
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEE1GBbrQYgx8o9Vdw+hSPvAG3BU+IFAmYZlDsFAwAAAAAACgkQhSPvAG3BU+Ii
lw//Z6Chl3Pt4ias3zocqbWlYPgeunQCLtimeaafI65e16/TBEsqozzMPh0eFMlqq1ptchIa3bY+
4/oJSK4pyaqGJPdaKImeXGSdVCzC86+EYQ10OnfJRWS/MepeDa/7ekQ6C6ffHP3XUTs1HQ2cKnwQ
rNeHN9o7UTQHDApvo+OkIRqW8qfGN/VT0MCHIyCKr2x3w59GAL7pAP+5lJMx4pTCWOjCwuAAz7Jw
W7qJcXrwbqWAPCQ9dEOF+0bet2KLlr0JkNzbiG0riPAJYR7n5zfTy9cnhoAwLPKpHDhOGEM1KnUh
4k/ADpRu0UNdsW3zZKPIFezzU2xRDzGfHE90/o3lIjsm9iGyOwIsCOH+t4srw6koCT8MYSOOt2kW
jBIdkG3jezNCGCB5x2KbEpFbQjhp2eOzMnry7UZqL0TnDwTTvlR68/Zx4aY8v3VRLIomegm8Z2k6
Me1UTKtRt+ZsVbi5ufoOMbsjCWVA4G3jqXav0asgS34UoGc75frF6nmBqH9UWdi6YXUq7yOkgbnu
qcZ9+UyPpt2fDNX5oUu1f5XqyXs+GjQvU+L6nqxkFim+7vzEAUfr4bcKT2LExGvrImR9RvYe0x97
yRJjK/ssNJOixKSak4jhuTBjaI84cKUxjf5jkLtn89V3WOF8wo9RcEQdeEroKgj3BIsPiF0ZnwQ0
fNk=
=bqhp
-----END PGP SIGNATURE-----

--------------bvtmbK4lY0foW2TuE3ZgtcwH--

