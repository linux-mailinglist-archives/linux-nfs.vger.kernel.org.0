Return-Path: <linux-nfs+bounces-8810-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62CCC9FD7E1
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Dec 2024 22:32:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC2E6161B9B
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Dec 2024 21:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE48A155725;
	Fri, 27 Dec 2024 21:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="F1iznSCJ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jHua5Nk1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0822F13D518
	for <linux-nfs@vger.kernel.org>; Fri, 27 Dec 2024 21:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735335141; cv=fail; b=oM3KF1GNQiw7UeKUOw8buIx/+Gj/17gCCug3cri0NAg6nWwtRxFhpZ91T6pQuaz97oJdKCxdRb1h5uQ1PA7+ToddOrruEBs9TG6Ola5EwiLTq2kC/dtcsj85Cm4IJ2SbJqmrROqPJlamM56h/c7UuOtD3wz0TiM5rcVULjU+X9k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735335141; c=relaxed/simple;
	bh=sS9NWc1BD0fdxGFucslDlMen7L8wiGcmKJVmc21+DBE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=f7upu1EjJ1Xb2CdMDGWx+u40S3O78qjQ7mucfSI7ZdISaLRABdMieRHCnr3R3H8kDKQFpkwGm7ywlEa5mUisttJtM3HId6YI8gqf7VQD8ZmsoO4kDKaKsgJB6Za3Nl2ZRNANmWerhEUg0wyNlCmED03a5Z2LN+ihsM+SPExeR9Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=F1iznSCJ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=jHua5Nk1; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BRDuIp9002826;
	Fri, 27 Dec 2024 21:31:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=aHXHcugEP6chWLkI4QBEI7MVusI/gdfzGBa14q0tBxY=; b=
	F1iznSCJi4A2DgYel6M8n4dfBV8YOL9AgGZfxWP3ixxbCtfU8H5FWc/MN4BHV8VM
	RXQc+Hb/4A4DDUi3BCmsabhu+W+FdKcDsTj+FnplzTW3UXPD4CzNKhc7H8nMB9kj
	8vS94T7Svv9Asfha570zRMlMe5C/Xzn/N3ng/uo/zSGAJ9tr258In4fN7pL5G8FE
	WtItbvXQEMYJwXJvMIfKNILgu6K4sYfuhuWl58aGj7LiFaGAAYFKWNAgugDmByx2
	12RQDER/FAfTI/LeJJaZi5R1s0HZy0fUtvigmIN1DZhEJYA4jt2r8Ko3fjj19Epn
	JwqxqNmBDp4Q3WrOqmdnQA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43nq7c7pvf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Dec 2024 21:31:58 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BRKsKWK004545;
	Fri, 27 Dec 2024 21:31:57 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2047.outbound.protection.outlook.com [104.47.58.47])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43nsdk5cr4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Dec 2024 21:31:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=epU3wibFDbPe06g6/HZrZOJpdnWpUWpqfO57BydOC3m5RuNiA+gL141ncOoeDUqQ+0A7rhlSG/dxg6YzfAnIqMzasNH0XtJdolQ5aAO3GDrlHNgmgpMVrp/7lhAF+kfcA7NbXxAnfVg56C8kaBcqf2JizqLG6hEPUEhzlUJDPcuTLhUsAaYXMXXH6rNQGxFeTrWygUADLKC75USLM3ZGWJy8iZNUrYDvZh8rWLAlRRNYyiurcHFvu2OQLd/W6MCc8Lh7xKFuIBmIG27iLF9K9CL4KeCYCJiSph/JLuExjw/GZK46NLE0sFoi8n92pHdV1NoKcuBx+J7RLtYTaDqzgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aHXHcugEP6chWLkI4QBEI7MVusI/gdfzGBa14q0tBxY=;
 b=mmgGu5tonSBXO8psoMliuPllIJwIG6IzE1wnrBGesK3u+/c+7MYzHsqNxXY2A40tS2v1tk68vr9xY1/aVvKJ5WMRUXtw9Mwf5cPiW4heI+YZ6zjdSLg3zGmQ7W5b6PGakdG88HVV8gnHyPM7mLMdqJZ5TkvES0A/wEhi5KNk4ZOdIYEPeD9f/b7m/3Ym6EHuU/jxT6ob1Q2AlP1zpeH9M7yE1bCFMhSkU7lfI13BcOYlYcJESOpPjjCIVUylxzbfWi9r4BXmP2LZpD6EIVo6xE7u879y9JT2HEkbW5hL5EkA78ebHdCam1zNHnFOO3BEwL2RyjqTY6ERAXQgae6k6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aHXHcugEP6chWLkI4QBEI7MVusI/gdfzGBa14q0tBxY=;
 b=jHua5Nk1KRM18J2ZKt253ilHA1nNIDGGo60Lt/wNaxRy69QeZwkhCbQ1QfTHMQmvpZob7w0vBXKUSfTFtck/y8AYG108lpZa1KUbog5KiGFerXFA21FGF99VgP7/kYEVauDrtkK37bTCTvLnyOHdFxmQM8WYdWAWeOXCb1hO+ks=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH7PR10MB6578.namprd10.prod.outlook.com (2603:10b6:510:205::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.14; Fri, 27 Dec
 2024 21:31:46 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%3]) with mapi id 15.20.8293.000; Fri, 27 Dec 2024
 21:31:46 +0000
Message-ID: <9e988cfa-5a27-4139-b922-b5c416ae0c72@oracle.com>
Date: Fri, 27 Dec 2024 16:31:44 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: kernel BUG at fs/nfsd/nfs4recover.c:534 Oops: invalid opcode:
 0000
To: Salvatore Bonaccorso <carnil@debian.org>,
        Scott Mayhew <smayhew@redhat.com>
Cc: Jur van der Burg via Bugspray Bot <bugbot@kernel.org>, anna@kernel.org,
        trondmy@kernel.org, jlayton@kernel.org, linux-nfs@vger.kernel.org,
        cel@kernel.org, 1091439@bugs.debian.org,
        1091439-submitter@bugs.debian.org, 1087900@bugs.debian.org,
        1087900-submitter@bugs.debian.org
References: <20241209-b219580c0-d09195e1d9e8@bugzilla.kernel.org>
 <20241209-b219580c2-2def6494caed@bugzilla.kernel.org>
 <Z22DIiV98XBSfPVr@eldamar.lan>
 <7c76ca67-8552-4cfa-b579-75a33caa3ed2@oracle.com>
 <Z22r2RBlGT8PUHHb@eldamar.lan> <Z25LCAz9-qDVAop9@eldamar.lan>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <Z25LCAz9-qDVAop9@eldamar.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR13CA0014.namprd13.prod.outlook.com
 (2603:10b6:610:b1::19) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH7PR10MB6578:EE_
X-MS-Office365-Filtering-Correlation-Id: d0ec75e2-73e1-4c93-4d76-08dd26bddd48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?alMwazdlNEFiSjNIWEtHdTVRSHVGRGttcXdnUXJzK2owSnhvSGNFN1ZCTG1p?=
 =?utf-8?B?SDZ2WFp1bUNYU3dnd3krb25OUzZuNWxKOXRycmlwK1VJTnpRSzlyVXJ2UHF2?=
 =?utf-8?B?dlBBUGpuUktLUmRDZzdBa29MWDYwMFVMbmthMTlDeHplVFRlUzVjdVdqM0ZG?=
 =?utf-8?B?WEc3R3RiejZ3ajNLTDYxUVRlMEZCTzhDY24zVjRxT3dRclQ1a2dyYmZWQ2N5?=
 =?utf-8?B?bVJXakFOMWtnQVVLblpLaWxLNXZvM2JlMEZldUYzMFV5THBscndCcWJkbGdx?=
 =?utf-8?B?Wk9NOVA5eUMySFdGMzEyTkhHeFVtRDhJbWIrZHVNTFVYMzVvWGFnUCsvcGZv?=
 =?utf-8?B?eTRpNm9ZcHFZVFJjaFJ3ZW0xbCswaTY1UUt1NUh2M3ZSVkJiOGRSakdqdVNT?=
 =?utf-8?B?M3ZKejhSSjRGRnl1dXFjS3d1eUE0a09YU2hNaVlXQ2ZMNzNTanh5V0RNVGcr?=
 =?utf-8?B?eitObkNDN2NHY1gwS1pwMjVOODB4Mm5HbXAvRVUxVmJhZFlFY0JEbkM3ZDQ5?=
 =?utf-8?B?OEozUWtKWkpTWkphTkF6TDM1Ym5VdEVVMHVGa0Z0MnRNREJrQWtCRjdCY1lk?=
 =?utf-8?B?cWEyQlFVemlzajdwOEp5bjVscEtaNDFwU0hsakk0Z0srbi9raUhhWlBQOFBB?=
 =?utf-8?B?RFBnYk5qZXRFQXFDMS9lNG11d2JkeU9DeFhoRHVLNlRvMlZMeDVqSTYraFND?=
 =?utf-8?B?c0g4WmZYTzVVbi82ak4xWWRVWVZOQWJYdW9SQlpJNXNpcGQrSjNUendFMHFM?=
 =?utf-8?B?Szh6dEpjOWNsQlZvaXp4a21scW5iNnY4Mk5vWlhPYjNiUTlyaUZFeHd0cHhL?=
 =?utf-8?B?dEkza0YzWTliWkxyRzFoWnRRYk5MNjhQNFFWbFFoVytXYTF5YnFmcnlUb0Fj?=
 =?utf-8?B?TjBhblRWYlRsaWRHSjFGV09NZjlLc1RHRnp4cFVodU8yU3BFaTMzVDJuYUVx?=
 =?utf-8?B?VlNHYmJMNlM4OG9zUXVURmZIK3B1TWs0cFl2ZzFyS1hUY0pIS0JlMWRIZDJZ?=
 =?utf-8?B?RGVXY2cxd1h0Tkp5MW9oYUx4dG9uUE1RRWlUWGt0c1ozeHZNUTEvZ1QrSURv?=
 =?utf-8?B?VUc0YzNoekE3djdselJmR2o1Y0dNWHlwRzlFMnVMY21wVjFqVCtPQzB5WEZC?=
 =?utf-8?B?YmI1ckxtVnkxMEJQYnZRVXRPb3REWWlyTHlGRnYyS1VuZlNtWWVzMXdodkNn?=
 =?utf-8?B?OW11ZUtqVkpKRjRiRVEwKzVjSjAvalp2T2hIUExqVWhMUGRhS1JmcTJrV0Zy?=
 =?utf-8?B?ZFIwNnVDakpaZjcydmo4eENWcjkvUmtyS0NaWU95MThJNkpIZUt1OWw3OFRL?=
 =?utf-8?B?VEdlK1M2Vk5jM2o5ZHc1ZFB2bXFidVBYY2dxYW4zdEpwTFJhdU45bFltWmxH?=
 =?utf-8?B?Si9FSnUvWGhVYlJTQ3pOV1lqNWlvSGdsSGdISUlSYjZVODcwRDQzQkdsOEU3?=
 =?utf-8?B?L1RSUWlPRG9FclpUb3pyZ2tJOCtQVGQ4d09rUkRteWVZejV5dlp5VytJYXlW?=
 =?utf-8?B?ZmJOM3BvTjd6T1VuMnVxNzk5dmwrTng3akVNdFJISlJtTStGU2M3TkJoWWNr?=
 =?utf-8?B?bi8xK3pRRGliRVh4YVVOV0VqeHRybisyVXJNbEk0THdKaDRCV2VyOXNpejBv?=
 =?utf-8?B?LzZFZDNWN1IxQW1MMnpjdXZRWWd0ZjdpRkxrSWtPU2JhZTBLa0JBMGhvekxG?=
 =?utf-8?B?UU1FdFdaZUlEcDk5RzVpRFM5aUhuVzgyRG1oYVZRZG5FcnR6d3hwbFRLZDVD?=
 =?utf-8?B?a3h1Z0JmeWNsN1k3YXdFK3hWQjlxc09UTjlYQXZxcUthUEk5bUFFMzVjRjYy?=
 =?utf-8?B?cGhzdHRNZ0NTbThmdUYrZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bGx3c3dYRVRGREVYQmFtYThNaTNEeWxOOEhYNVRJUGpBVjhKMDRTdkliYUYw?=
 =?utf-8?B?bFZwMDNNR0dhRW1EYWlKY3RqMWVLYXp3ZklBMEd4SU92VElaNzg4VVJRSzlw?=
 =?utf-8?B?NDJvd3JCYkhyZVpLSTNlN3N1S0ZiVk85NlhNYjhzVFRXWVBIVE0xdkNGVjh4?=
 =?utf-8?B?VW8zNmIwZEdHUUxDcjR2ZzlxZFhXMzVwMUZVa2dpd0hMcWN3ejl4aFVOS2Zh?=
 =?utf-8?B?K1lYbjFBVWpEYjRrQnBnRkVkRWVRWE94NEY5M3d1aVE4SlY0VXV2WGh5M1p3?=
 =?utf-8?B?Y2RjS25Vall0MFZDeVFZb2ZhWStVN0JTVmpjWmxWb0hkVm14TVMxeGxYNjFH?=
 =?utf-8?B?bklkMGpvOFZMdjdCUElCMFlKQUxpZEwvaVJ4eWR5OTZWeEtHeW5PZThGWWFi?=
 =?utf-8?B?czlsTUpic1RIU2FLK1dFNmpCOERqZjFMbWxpZVFMUEFzWjVMemM1aTUxcTZO?=
 =?utf-8?B?ZkxpNVFIQlV3ZWh5Q3VIM0taTG83QmM0OGllM0UrM0IvdklaeFdMeE5Canlw?=
 =?utf-8?B?MEJucjZnL01HOVpLUVRSV1o2QU9HQjNDekVPdlp1V2tvYldtSFYrS1ZZYzI0?=
 =?utf-8?B?bkdZWnloclM0a1BRV0dsQTRyS0FrdGptVlpHWFVobnZwTnJEcFF2VW51UGVj?=
 =?utf-8?B?WjBZTnp6bzdycmREbGRFeFNtOGRJNkhqZ29VVG53MnIwQ3ZoMG01VXVNcEJK?=
 =?utf-8?B?TkFJQ2U1OHpqOWw1TkZzNmcyQ0p6eFNOSmpKOUhHNTcrZlZGaEFwQnFyY25B?=
 =?utf-8?B?dk00MHQxVFFOQ051dFpRUjRlVzYvS2hobTVFa29DeUtmdTlOTWNrV3JUTkpC?=
 =?utf-8?B?ZmlWVFliYm5mSVd0QWkwaVBXUUllUkl1MDVLb3dNcEhwU1F3S2lCdzFwVDUw?=
 =?utf-8?B?NUZ3cHNSdkFVeHlKZ0xpMXlRazhHWDdCemlZd0VXb2dVUFZ4eUQ2ZWN0V0l3?=
 =?utf-8?B?cnRpaklOR3Nwd1A4WGtGZkd1dG85alBWTTVERkp1TFNibkwzdmlkUzN5NDFC?=
 =?utf-8?B?NXlPQTdxOWlocjI0YkdKbTlnb2IrTmJLMFhqZ0NXZTlnSFJuVUJDMkxHVEFT?=
 =?utf-8?B?Z1NyTFBiRFdaTGxnZ1ZzK3NtQVRZT0pWR1E4QndqcnNadmtvYzg3RGZCSThx?=
 =?utf-8?B?aDM5OVBPMzdYbG53bjVNRkZvcytvRHdMSFpwTXlRcnZVMTZObkQzU1dhdG1i?=
 =?utf-8?B?LytDdFZvdFdQb3pKeUg1RzROK0hwV2tmQ3cxUGJud1ZHeFBZd1V4MWk5WEhI?=
 =?utf-8?B?MmxXRm9oVy9pNGpNNlp0d1FjQmxyNVN0ZEJhVVBQY3owK2paQ092RDVFTDhG?=
 =?utf-8?B?bC9GV3cwTFh0Vm02U0thZWxBMjZVNS9ZN0NES3lXTU9QaElZMkxCSzUydUNa?=
 =?utf-8?B?Q3oweVpJZG5QUVlsU3FXanFCa2lLWVErTmtqVHBTS1VheTJ1UC9VeTkvU2g0?=
 =?utf-8?B?MW1Ua3pNZDJpbXJ3bW9HQlkvTmZhVGp0RmVndkxsVmpZUlFhSEJ0SEFUMGts?=
 =?utf-8?B?L3lKK01FMWxYSERYT3EzSXkxMktDcms1Q0NlZEdQREVTV1JSSS85MndZRlJC?=
 =?utf-8?B?RUNmU0RJeDk4cjRHT3hLRnJPTlNpQjhYMFFWcTRDZE1ZUVB0aWU4THpoc0Uv?=
 =?utf-8?B?UE1lb1h4dHpaS1FvNmRFQzBjNWJaeDRBMUc4L084ckxvUmhPaFVZeFd0R3VO?=
 =?utf-8?B?TFdUZXd6Q3hZeXhVdVJwN1dwakk1OThHeGh4aFJlMFFsem5KaW1TNkduQk5v?=
 =?utf-8?B?Zys0SlNVdEJJUkpFR1I1SzJCVWhZUnNZQVBnb25xWThiSWNtWmF0RU1pNUIy?=
 =?utf-8?B?cUdZNis4MUJ0czgveXNhQWpLMHV1bWRRZ1U1N0RmWCtPVWt6QnpoOSt2a05l?=
 =?utf-8?B?bmgvd2IvQzdZOXBSKytyTXBJYk1XMGlpN1lMVk9EUkxicENwTTNLRHNyWmpS?=
 =?utf-8?B?NUpDV0ZCaFIxM2tMWU1sdjdaQ3NibWNSbVhoa3pkVFR5aCtsaWdWQ1orRWh2?=
 =?utf-8?B?U0pEd1FmMDZsQnFGY0dZNis3TzEzZDNnNmpKT2FLZytCLzNqWDZGb0lYdGth?=
 =?utf-8?B?Q1BYZjlwTE1Ra1cxbVowdmNUaWNqd2krWENjSVQvS1FreDBaV1BPeHFpMXJN?=
 =?utf-8?Q?6AFE7vRF7rSlMg/9rWl/fdHEN?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	8L7wU6WDVLfJQbu9kFX753kVaCRQQPVbUTqcQEEv2voj92uQqKVaWyVTh2HwcWdgr20i9wKOBODJJ9wA2zMNhgzSLEGWBtRrj4Gmolg4MeW/LUQMFZdp/5kTTzu2AVUMoDsNeuVh642K4+9U14mqOlHcTnswWOQ8zOtkrXrBdhF5QojCCPqgptBARx9TtPrUCabdnuk5vHs+nc8OS7QlMUvULBBW+gNe/88J9ImH0A++IvrteMAjG3lD4c2K3vKy8zQnRM1W5f6ePkhFg4aynnD9x8UpwSCCT8gEBt0U+oR/XrGmEynQB3xKJKSFzD4yeh805pRLj2y1+MHM/LPH6Gkibx6uJ7iLaEQEGVdw5884K0Fh4NGvSF3PUEAPdAqM0BV15Y5nGRfPbJLFNWUrXu/bE1+vHyZ7OmzaTnr+4NEOkN+0Sy8H2mMZq7uamR/2qThHeDmtUpELpKtkb3bIarAbcAilYJFbSryusLiZ9yrwGvp/4CoZUC9kDOMBcMNL88wxUA+Vco+mgW8vm1dURgzuqJUvxSqk70FqXlkswomDdQh/KK/mbDQqe0YfdvmazUSyj9vID4d+FwV4KLkS5iAoLAMXEACeL1TtHrN3IYc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0ec75e2-73e1-4c93-4d76-08dd26bddd48
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Dec 2024 21:31:46.2062
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ml6lhMJ8RQhLoo0GDhmGTP6/U/cO24gL4usYPio2aG9pTvihGGVJGEsIgvt03+4X0bNasPRi/uw6rmoMhfHJBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6578
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-27_09,2024-12-24_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 suspectscore=0 bulkscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2412270183
X-Proofpoint-GUID: EBTm7HR18ypgA7sMx2C1vWA0cTKQ-Hrx
X-Proofpoint-ORIG-GUID: EBTm7HR18ypgA7sMx2C1vWA0cTKQ-Hrx

On 12/27/24 1:36 AM, Salvatore Bonaccorso wrote:
> Hi,
> 
> On Thu, Dec 26, 2024 at 08:17:45PM +0100, Salvatore Bonaccorso wrote:
>> Hi Chuck, hi all,
>>
>> On Thu, Dec 26, 2024 at 11:33:01AM -0500, Chuck Lever wrote:
>>> On 12/26/24 11:24 AM, Salvatore Bonaccorso wrote:
>>>> Hi Jur,
>>>>
>>>> On Mon, Dec 09, 2024 at 04:50:05PM +0000, Jur van der Burg via Bugspray Bot wrote:
>>>>> Jur van der Burg writes via Kernel.org Bugzilla:
>>>>>
>>>>> I tried kernel 6.10.1 and that one is ok. In the mean time I
>>>>> upgraded nfs-utils from 2.5.1 to 2.8.1 which seems to fix the issue.
>>>>> Sorry for the noise, case closed.
>>>>>
>>>>> View: https://bugzilla.kernel.org/show_bug.cgi?id=219580#c2
>>>>> You can reply to this message to join the discussion.
>>>>
>>>> Are you sure this is solved? I got hit by this today after trying to
>>>> check the report from another Debian user:
>>>>
>>>> https://bugs.debian.org/1091439
>>>> the earlier report was
>>>> https://bugs.debian.org/1087900
>>>>
>>>> Surprisingly I managed to hit this, after:
>>>>
>>>> Doing a fresh Debian installation with Debian unstable, rebooting
>>>> after installation. The running kernel is 6.12.6-1 (but now believe it
>>>> might be hit in any sufficient earlier version):
>>>>
>>>> Notably, in kernel-log I see as well
>>>>
>>>> [   50.295209] RPC: Registered tcp NFSv4.1 backchannel transport module.
>>>> [   52.158301] NFSD: Using /var/lib/nfs/v4recovery as the NFSv4 state recovery directory
>>>> [   52.158333] NFSD: Using legacy client tracking operations.
>>>
>>> Hi Salvatore,
>>>
>>> If you no longer provision nfsdcltrack in user space, then you want to
>>> set CONFIG_NFSD_LEGACY_CLIENT_TRACKING to 'N' in your kernel config.
>>
>> Right, while this might not be possible right now in the distribution,
>> to confirm, setting CONFIG_NFSD_LEGACY_CLIENT_TRACKING would resolve
>> the problem. In the distribution I think we would not yet be able to
>> do a hard cut for planned next stable release.
>>
>> Remember, that in Debian we only with the current stable release got
>> again somehow on "track" with nfs-utils code.
>>
>>> Otherwise, Scott Mayhew is the area expert (cc'd).
>>
>> Thanks!
>>
>> I will try to get more narrow down to the versions to see where the
>> problem might be introduced, but if you already have a clue, and know
>> what we might try (e.g. commit revert on top, or patch) I'm happy to
>> test this as well (since now reliably able to trigger it).
> 
> Okay so this was maybe obvious for you already but bisecting leads to
> the first bad commit beeing:
> 
> 74fd48739d04 ("nfsd: new Kconfig option for legacy client tracking")
> 
> The Problem is not present in v6.7 and it is triggerable with
> 74fd48739d04 ("nfsd: new Kconfig option for legacy client tracking")
> 
> Most importantly as the switch to defaulting to y was only in later
> versions, explicitly setting CONFIG_NFSD_LEGACY_CLIENT_TRACKING=y.

Hi Salvatore -

I see that Scott recently sent a fix for a similar crash to linux-nfs@ :

https://lore.kernel.org/linux-nfs/032ff3ad487ce63656f95c6cdf3db8543fb0d061.camel@kernel.org/T/#t


-- 
Chuck Lever

