Return-Path: <linux-nfs+bounces-9031-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6047BA07DA2
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Jan 2025 17:33:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CF38188C9F7
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Jan 2025 16:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24B3D21C176;
	Thu,  9 Jan 2025 16:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WceXqUFK";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zcfBt+2e"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88A7221D9F
	for <linux-nfs@vger.kernel.org>; Thu,  9 Jan 2025 16:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736440390; cv=fail; b=Qb4/EcoDRN566uRw7Knx89X3lnpIRFuQB6HsgDru8NfQqXomvwChBunVYNTgcRIogbnRjFv1XVnxWIs1EzG/MGkhGcV0jXCkW1XRAw4IgEc1eyfRXKk9fQiBghD11UihVZQRzN0MchsosuZTu4n4jIsTx7BSK1KsJy5keHjFCLI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736440390; c=relaxed/simple;
	bh=ivfF9LGjjU1JB8ovjv7EVwZQkrhYONavazBPWw7C/G4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=g4qq7y8ZhT51o0Etq3YuP4jTTa1Gixu/ZsnAo8v9H4NG6HpNQg0AZIm80TOo4C+EUawUQbc2kdEVKB3jbPFqBLInLf4xKMbzIDaNQiHRdboPdpGDGykh61IEyfRwN4oBnOwJT1j+AhO24QvsOjgCM3BvdgG2YumKgaXeOn2FxFw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WceXqUFK; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zcfBt+2e; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 509GU34T030067;
	Thu, 9 Jan 2025 16:32:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=44M/d9eAXO44oxHSDjuLUvvNLMBs3aNsDLoLnKpw5NM=; b=
	WceXqUFKzbU4PWtkJ+HsTX+O6FFpT4I06N9xOytGdYxIz/if5618MaXx/pewDZdS
	KmjB4GhKvYzZHw6TU66JewAMouJdoWO7htceeG3foh63aPAqZWW/O+B/OonLS3rR
	IpuPoDnrZALt+jVxyvoTSxTsuAacComE/1dfYjOngiIRtu35lIiV/ho9lYg/Hx7D
	eIxhi4CUhA8x8bIwgMD1l+cl6hyRWIi+d/LZU41wQS3N8dGF8ZPh9E2NiD2ntfyX
	TotlG8xxR9YpQPIp4qdgxdRB0YbSWzEVVJEmdowXV9xYxoV5a5nbgf/BJ+3WT4DH
	f4NxdihoNZe+G9r+YWMRoQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43xudc9gde-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 09 Jan 2025 16:32:51 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 509F0CAn008547;
	Thu, 9 Jan 2025 16:32:50 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2048.outbound.protection.outlook.com [104.47.58.48])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43xueb4v2n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 09 Jan 2025 16:32:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sIs43W6wSfLQDVATadAY2UWtfO0xrVFLWHy6WUHLyX/ooQ/wKl2bgZJd2bbXCAfOL3dQ74gEPBGXjim8vuPiigNF5qQQFCbihCA24BfZNauIRAkra19LcbZMIiYS5wHiHXW4UI/L6Dj2YoUeCX2hgsvVJ1WfAahhABHnQ584g/uP5vER6/u9VtOazUhBc9LdDV5MLVNxttlGLM7Qlg5H0YtsanIAqE1HmY3pAdwCU3eUGYDc7G8d9uGvaSKGZfqlUGT5b/+w73LDE+yzb5AZzND/NbZ8sUtoXciuT+NOCC3NA2WIuOXoTN94qghLeZgujvROKIX4xAuUxjPH2tQ4lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=44M/d9eAXO44oxHSDjuLUvvNLMBs3aNsDLoLnKpw5NM=;
 b=Hc9weTiKW8fakd+thUE6hC5es20d0wOTaPyqWBVFXIlyETTSa6b9INC5CJJXsNkbKJ2NVq/TjQLl6a0688ggrmZIVwXnQMW1Ua59IXCsn6GqNoLh1HqQbXnzyU6DY7bjlgIOHLQ66J714+0xzXnmiS6Wz1ysYtJu2jSMhHd+IIXE42rhpawhUboScbGHFrDgl6upAiyXYhbfKC5rfiBHRmu23k4hhYVavJxuhetvTIfEdkSbFFHO/FYf5kvWveEHf+RtylRzq8Yu219f7lGwkzinSzEXop0Lgibg1nIxUwwCCVrmzCbGZG7vltMMDErnYfwWR3cL6von0npRoK5TPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=44M/d9eAXO44oxHSDjuLUvvNLMBs3aNsDLoLnKpw5NM=;
 b=zcfBt+2eflajOJe43gVduClV8u2/owvsrYpF/HZ2y6U4y23lXTSKJuad0vy6wZudBkTidR7AGsxHvVP4/aPLaiyeoGGd218CCmLZLNtk4CRwPmrsmg+nkJjRWihrs3lBXROOZ5WqbGo5pbYOEn4kHlw2By2NIhxpPhkZbyJ15HU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS0PR10MB6725.namprd10.prod.outlook.com (2603:10b6:8:132::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.12; Thu, 9 Jan
 2025 16:32:43 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%3]) with mapi id 15.20.8335.011; Thu, 9 Jan 2025
 16:32:43 +0000
Message-ID: <a4a3aca4-3e53-4537-a6f5-a46dc2258708@oracle.com>
Date: Thu, 9 Jan 2025 11:32:41 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: nfsd blocks indefinitely in nfsd4_destroy_session
To: Jeff Layton <jlayton@kernel.org>
Cc: Salvatore Bonaccorso <carnil@debian.org>,
        Benjamin Coddington <bcodding@redhat.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Harald Dunkel <harald.dunkel@aixigo.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Martin Svec <martin.svec@zoner.cz>,
        Michael Gernoth <debian@zerfleddert.de>,
        Pellegrin Baptiste <Baptiste.Pellegrin@ac-grenoble.fr>,
        Christian Herzog <herzog@phys.ethz.ch>
References: <4c3080af-eec7-4af5-8b0d-c35ac98ec074@aixigo.com>
 <C1CE3A96-599C-4D73-BCC0-3587EC68FCB0@oracle.com>
 <Z2vNQ6HXfG_LqBQc@eldamar.lan>
 <ecdae86c-2954-4aca-bf1c-f95408ad0ad4@oracle.com>
 <Z32ZzQiKfEeVoyfU@eldamar.lan>
 <3cdcf2ee-46b3-463d-bc14-0f44062c0bd0@oracle.com>
 <Z36RshcsxU1xFj_X@phys.ethz.ch>
 <7fb711b1-c557-48de-bf91-d522bdbcc575@oracle.com>
 <Z3-5fOEXTSZvmM8F@phys.ethz.ch>
 <36f4892e1332e2322ab46e1343316eb187d78025.camel@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <36f4892e1332e2322ab46e1343316eb187d78025.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0388.namprd03.prod.outlook.com
 (2603:10b6:610:119::30) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS0PR10MB6725:EE_
X-MS-Office365-Filtering-Correlation-Id: 38a66dd7-3383-46c7-cf52-08dd30cb3dba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S3QxOHlSazlMK1REMEJRT2tOMG5ySkdZK2pUVmVYTjFaMnFMeW5SL0JUeDVV?=
 =?utf-8?B?MU1Jank4c1ByakIzWXlNakdKd1lhaGpTSHBoUEVFanRoak1IVU5hL3hYZ3RF?=
 =?utf-8?B?UUpnZGE3bEhFMEtCQzlQNmRseGVDdHFnM3AvRGRvS29Sb3oxL3ZaQWU0aWJX?=
 =?utf-8?B?SWdHWWw0TlNKa2o1Yjh0eVI2NWhHOGMwZjYwelFOMllzdUR1djVadkJ0d0c3?=
 =?utf-8?B?NDBvaHI0a1NUa0xxem1icVJUV2xPUU13MlZJU2pOREJPY2E5elJQeDVzSnNz?=
 =?utf-8?B?a2dYczVmRXBXMWFzTlJvRndBWWovZHEyb1lqaDZhZE5OVDE4QjNiUEU1SFFX?=
 =?utf-8?B?b3FVRmxrRXdZUHhLS0hYaUczbkNTU0NBTndJNkkrUENlL0x5cFpqdW1lRnhY?=
 =?utf-8?B?bDJsZUg1QzdBM2ltUWV2Mi9xSHNkWWZiaEZxMU5jMks0MnpzVEQ1V0gzMXJz?=
 =?utf-8?B?akN5eDA0azYyeGlLVFlSZThORXVkNDhiNUltWVJGVTk3ZHdvL3JZK21WVVFF?=
 =?utf-8?B?eVFGSzdDampmRWZjVVVLYWlMVjlYTTlhbytrclBzSEVYTzZVWndSeUdsT2k5?=
 =?utf-8?B?dWlhcFJRZU0xbUE2US9yY2RWRjVaa1p4OEpnbXR1eU9OWnRoL3dMNzYwelFX?=
 =?utf-8?B?bW9yMktXdHh0blpRMitSclo2eVprUm43bVJZYnUzZDVDY09RRGQvTklRTVhQ?=
 =?utf-8?B?MW1MbXp5VWx6S1hLeVFhTGRSbjdZQUlKRDE4RUs2Q0RkVE4wNDVnMWVGd0Vo?=
 =?utf-8?B?ejFBY01tVkFIdGhWWW1LNEZTRFAyck5wT1ZtcXFtZWcybTNrWUxIZXkrQjdS?=
 =?utf-8?B?T01oZnd5T1AweDlxb2dUSFFIS1dINWMzTkRjMVFLMjFzWUhFMDNPR1RYZVpH?=
 =?utf-8?B?dGFiM1lRdkU5WHNOaWptYlNTQ1dBcTdCRE9JZWFqWUlWTk5OVXdiS0djTldz?=
 =?utf-8?B?eFRDQ0ZicEdmQjBJOFpIekdpOU4zZ3B0cTZiSnh4KzZKUTgyRTNSMUNqUCtW?=
 =?utf-8?B?RU9hTDdCRlRTUk1TZDVmL1BWTlhSdlBUOU9GeWFFME5RRnF1MmZnSk52SUVE?=
 =?utf-8?B?UURieFZNTEhTTVN6dDdvT1lsL0gvcG9VMjlRYmxJU3hBZnVNTDMvaGVHUkcv?=
 =?utf-8?B?MkswYTNPNUVudEpoWERPb1Q4OG1FckIrV3lkWHZlZUNnK3dJdjRMVStXTTE0?=
 =?utf-8?B?VzZjNXI5THh0VXJvaHllcmNjT2F5Y0FMTTdKZkJLUVdVdUs2VWg4OVRWMlJV?=
 =?utf-8?B?aDEwWlNPWmJ4cVpYbitZVGNtMWZ3VmtYOGRURlN1eTRsUlB2UzFyQVhRMGZo?=
 =?utf-8?B?bytUR3AzcUsrYVQ0VFVDYjNmQkk4RFp3NlNuZEFMZ0tlZi9zbzBMY2ZUUTFj?=
 =?utf-8?B?d29CK0pOUVRtUEZwZHUvYjBNd2ZwbVFMK3RJT2c4M2FYTE5PeTJaMWpnM0p6?=
 =?utf-8?B?bXZ5ZHdVZE5MMlNjZkRMS0w5N2dqL1pFRGZ6MFZXS093Wjhma0JVMm9Dcncy?=
 =?utf-8?B?bytEM29iRTN5eFpuV2pkcXJCdVdwNjFUWkRIY3NEaGx5MG0rTmRSRnJpQ0lv?=
 =?utf-8?B?S2FESmNPdXIvd1l2ZVlLTGhsSWszNXFKeVlNeFpKSDVxZDh4TTExQ3lVWXBo?=
 =?utf-8?B?MUUreW1mbjQ4b1p0ZVNPc1UvNldrRkNEWm9UR0c1V3ZOK3JkVEROVHZuRWVO?=
 =?utf-8?B?bE5tendvTDdtZzJmcWduSmtyT1FkSzYrdkdXT2p4RFBXZEo3bVUzd0J0VW9O?=
 =?utf-8?B?VEMrcWJjZVJEeFJRVTdNaHNtc1lNOHNzZU5EYkRqaU4vS3ZiZXBXTkxlQkhK?=
 =?utf-8?B?ZlVHcFo4VWszUmF4akhtQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SmwyQTRPd0hGak91cXBoQVdIVS9lZUlKM2oxZVRJb2doUEF4S05OOStKNEF2?=
 =?utf-8?B?bUxuRnk0OHl1a0wzTHdqUW1lS1FMb2NodHRrS3M5U0JONlEvOXBoUjFubjFP?=
 =?utf-8?B?bVA4R1hycDIyZHBiamhyVTBIUzQ5TmRuYUEwbGtic05mbXduWFhoRTlTV1lW?=
 =?utf-8?B?UEVDR3ljR2FWejhwRUtraGNQWTVSQndyMjRIck5uVTNUNmZqRHVsNStRTlpH?=
 =?utf-8?B?ZkljcEZyUjRjalk1VEx2ck9qVDZLZVVtcDdwQUVpa1FrWlByVGpueGFEYU5v?=
 =?utf-8?B?akp2OE85NW1DVnBVNUlWNnJaeVBjdG9TWkMxWVQ5djNuN1NzcEpxT2ZrRWNM?=
 =?utf-8?B?YVZXSTJaNWp2bURMSUVGTkw4eW9DaGZLbVJGK3JDQzZqU0xsWEg3SUhCUXFX?=
 =?utf-8?B?T1RJUEVTUEYvdEdNKzhKbCtkNXpvd2dXYXlrczdSZjBER1c1c3M1SkdjbW1r?=
 =?utf-8?B?U2VCRE1aWFRtekk1SEEzWDlmVVRoZ2VaUnlyQnlaR2RXZG5LM3EvSUxwYjc5?=
 =?utf-8?B?aEJkMHB4dHdLTzlTaVZMUnFLcGYvbGhmc0FyWU4vb0twaGJaSGVtVjRKNmxY?=
 =?utf-8?B?b0ZaOC9iL3ZIdG9ZVVVhenJ0TmZoREczdXFjR21jbVEybTFHTXpYaGZ6ekdx?=
 =?utf-8?B?cmNab0RxMWVEeVllcUJFelJka3FFTFhKcGJFQ1lkT2xRL1kxM2tGVVlIN25t?=
 =?utf-8?B?ZXJ2b3crRnlmOEdoNUJGTDQ0NGpCaXdNSCtlRjFrc2llOGlpanB4N1N3K2RX?=
 =?utf-8?B?R2djZ1pTNFdveWx5V0tPcmJackxaYUZDbk5WdHBkZjY4aC9tRnRXNGVUYWVP?=
 =?utf-8?B?a3o2K1V4aDlmTEdRT3NCbWI0dmdmQnRkUGllUFlSUkIrb3pNYml5REFuQVBN?=
 =?utf-8?B?UGEybkhxUmxtYVErWXFxS1F2KzRaY01qdzNrTndhQjRBcmxzczNwaFZHUTBE?=
 =?utf-8?B?Y0ZodUc0UlMvYjBRODNKdk1ZeWJBVHdEeFV6N2NpLzJvOHU5NHNUWU1LdmRi?=
 =?utf-8?B?VWJsSVlDWEdaQWlkc1VKOHV2RXRaTE56TFdmWHRrMGJLN3pvRHNjVDg4SXE4?=
 =?utf-8?B?WWNDOUFLc2h3V2tUZmdqS0JBQVdOM3hVVUVrN2k0Q0h2NldaK3UyQ1NNNTFu?=
 =?utf-8?B?d1JlNUR4Nm5qTUNNTEp1QVRhcm1jbXVCeVJrWnJSN3psMjJudmlyRUlGQXV0?=
 =?utf-8?B?L3VucnVQTGhRSmlnWGNlUFQ1V2lJWGNLcDBreThNdTdFL09lajBiWlk1b3dz?=
 =?utf-8?B?ZUVMRk81SEFjYk5TZGVtNlF1dHJKMG1jclBkKzFyUVNTam8wVmRjaEFDM2Mz?=
 =?utf-8?B?MzNBYXM4MVo4TEt3d3o2bE1mb05uVWlPaklnbmxMM0h5NXdjR3Jpd1dwWkVL?=
 =?utf-8?B?bHEvOW5lMGNYRmJlTmVXTkIvZlJXRnlqdnFDYVpuZzNDVkxaRWV5dXcvaFdS?=
 =?utf-8?B?aCt5L2NTVGVuSnBqMm5SeC8vRzBBU1VNK2NwWWw5M2d4R2E4L0R3cHI3Ykxx?=
 =?utf-8?B?emVhNzBBUWh1VDVvNGpJWmU0V3RFOFR2dmd4TlluanZYQ0c5SngvZlJLMWxv?=
 =?utf-8?B?QXgvYWtGQVZuOXdLbUpRQ293Wk5UaU02MkYwVDRDUkIzTEVmOG1pYWJtUlor?=
 =?utf-8?B?NFJKK080STU3bGU5T21JOCtYbk9aeXV0KzJHQllRNEI4QXQvRXNid2VXM3Jr?=
 =?utf-8?B?dk5OYWxuREkzbmVaYVg5dWdKbzdrTFFyTnBrUFhxWFV1ZXVXNEFHNG9xTFNp?=
 =?utf-8?B?TzY4bEFaQ3JFZXVZTW9WcW1kOW9jSlNKMjBUMmNQM1U1czd1VndlT2dyTExn?=
 =?utf-8?B?NTgrMGpqSTh5eTRubXFvNWRMdjUzemNKSkRPMlRqTU9XWDlNd1RUYUhkV0ly?=
 =?utf-8?B?aTRWRS9jOXZzd0JJb1dzazdBL3psc2tqdEFaODEvc0ZRMFdtRUhpaEZvaGRk?=
 =?utf-8?B?eVp6NkVGdXp2WkZrMktVdlhUa3dxd01hOXBZdC91V1NDS3dEUkxOUjllQXNJ?=
 =?utf-8?B?UEtmMnErVk0yQzdsTmZTNVpPMnpBcmVONXNhREFWL0t3WkFNRXpQYTRxZXVq?=
 =?utf-8?B?UHF5cktoZ09IZmlINHpkTndIdkM2bXY5NCtSWFg3RWh6S0JHdzZLZThZanBT?=
 =?utf-8?B?Z29DbXF6VHZGSTNQTVVDSTZNeEU4WjJWUk1xdFZneUMxM3c2VGdkVG8rTHBi?=
 =?utf-8?B?alE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	t+rNgxNNrnaFmO+qB6xCXuAvVoMpA55M842AFSm9JIz8im72fO9WkcQs8PWcpxHN8XpGVkc6p5fpfhGvxn/xw8Iol7L/uPUAsxuTC4814QP4gxyPT1ZUZEkTjrAH2TkSxoj9Ow445yq7FnfFKKRd30K0p26/Lx/PCcGQfD5YDrRleL34ms2B4fMCxrjGpdxzCiy1gLERHrrvTRLPrdy1uIGis+gtkRzlAo32aXueYp0nwH3rz+mi1BvCky8nrvBqVI2yXIMn8JpkvvZsViatM7HInWf/wBmnGOk6/KRGpEBZAFiGKJsCKgAXA1Vj0MjAG8t0RN6GZRJzMC4exe6LYfRGcgUTS5C29qU2lXXldHgQs1e+fja7jJ2Xye52raoqbbM2nDWVjQcr6Hh3yDLPh3igI3OyJGCl2oDLiuIeB3xDN4T5OWOFkyPPGEi2WBQ2Xq5KEpQYDgINb9WssoPcVp4wyir5jKvmhfgZdHrg8TJw1JIqMnFxKudEUNrDI98i4fMEq3Ur9Gh/cr+DZezhuVhfRbubHIpdmTi3l2GEcinKJrxli1TjDXWEedmySNZlngT1G5lvkl0MsPgEy/WhPjPVlAgltbFiT8ap2ycOMk4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38a66dd7-3383-46c7-cf52-08dd30cb3dba
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2025 16:32:43.0362
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ObjTo8vjKJsvrFne6vtkfRBPT5kawLlwtU57PXsMG7MRNt7Tory1sye/s45mhnml82yJ12QXvuL8DyIGs84Inw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6725
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-09_07,2025-01-09_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 mlxscore=0 phishscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501090132
X-Proofpoint-ORIG-GUID: oFZZZD199U1MANeFR0lwakL0UO_unvQn
X-Proofpoint-GUID: oFZZZD199U1MANeFR0lwakL0UO_unvQn

On 1/9/25 7:42 AM, Jeff Layton wrote:
> On Thu, 2025-01-09 at 12:56 +0100, Christian Herzog wrote:
>> Dear Chuck,
>>
>> On Wed, Jan 08, 2025 at 10:07:49AM -0500, Chuck Lever wrote:
>>> On 1/8/25 9:54 AM, Christian Herzog wrote:
>>>> Dear Chuck,
>>>>
>>>> On Wed, Jan 08, 2025 at 08:33:23AM -0500, Chuck Lever wrote:
>>>>> On 1/7/25 4:17 PM, Salvatore Bonaccorso wrote:
>>>>>> Hi Chuck,
>>>>>>
>>>>>> Thanks for your time on this, much appreciated.
>>>>>>
>>>>>> On Wed, Jan 01, 2025 at 02:24:50PM -0500, Chuck Lever wrote:
>>>>>>> On 12/25/24 4:15 AM, Salvatore Bonaccorso wrote:
>>>>>>>> Hi Chuck, hi all,
>>>>>>>>
>>>>>>>> [it was not ideal to pick one of the message for this followup, let me
>>>>>>>> know if you want a complete new thread, adding as well Benjamin and
>>>>>>>> Trond as they are involved in one mentioned patch]
>>>>>>>>
>>>>>>>> On Mon, Jun 17, 2024 at 02:31:54PM +0000, Chuck Lever III wrote:
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>> On Jun 17, 2024, at 2:55 AM, Harald Dunkel <harald.dunkel@aixigo.com> wrote:
>>>>>>>>>>
>>>>>>>>>> Hi folks,
>>>>>>>>>>
>>>>>>>>>> what would be the reason for nfsd getting stuck somehow and becoming
>>>>>>>>>> an unkillable process? See
>>>>>>>>>>
>>>>>>>>>> - https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1071562
>>>>>>>>>> - https://bugs.launchpad.net/ubuntu/+source/nfs-utils/+bug/2062568
>>>>>>>>>>
>>>>>>>>>> Doesn't this mean that something inside the kernel gets stuck as
>>>>>>>>>> well? Seems odd to me.
>>>>>>>>>
>>>>>>>>> I'm not familiar with the Debian or Ubuntu kernel packages. Can
>>>>>>>>> the kernel release numbers be translated to LTS kernel releases
>>>>>>>>> please? Need both "last known working" and "first broken" releases.
>>>>>>>>>
>>>>>>>>> This:
>>>>>>>>>
>>>>>>>>> [ 6596.911785] RPC: Could not send backchannel reply error: -110
>>>>>>>>> [ 6596.972490] RPC: Could not send backchannel reply error: -110
>>>>>>>>> [ 6837.281307] RPC: Could not send backchannel reply error: -110
>>>>>>>>>
>>>>>>>>> is a known set of client backchannel bugs. Knowing the LTS kernel
>>>>>>>>> releases (see above) will help us figure out what needs to be
>>>>>>>>> backported to the LTS kernels kernels in question.
>>>>>>>>>
>>>>>>>>> This:
>>>>>>>>>
>>>>>>>>> [11183.290619] wait_for_completion+0x88/0x150
>>>>>>>>> [11183.290623] __flush_workqueue+0x140/0x3e0
>>>>>>>>> [11183.290629] nfsd4_probe_callback_sync+0x1a/0x30 [nfsd]
>>>>>>>>> [11183.290689] nfsd4_destroy_session+0x186/0x260 [nfsd]
>>>>>>>>>
>>>>>>>>> is probably related to the backchannel errors on the client, but
>>>>>>>>> client bugs shouldn't cause the server to hang like this. We
>>>>>>>>> might be able to say more if you can provide the kernel release
>>>>>>>>> translations (see above).
>>>>>>>>
>>>>>>>> In Debian we hstill have the bug #1071562 open and one person notified
>>>>>>>> mye offlist that it appears that the issue get more frequent since
>>>>>>>> they updated on NFS client side from Ubuntu 20.04 to Debian bookworm
>>>>>>>> with a 6.1.y based kernel).
>>>>>>>>
>>>>>>>> Some people around those issues, seem to claim that the change
>>>>>>>> mentioned in
>>>>>>>> https://lists.proxmox.com/pipermail/pve-devel/2024-July/064614.html
>>>>>>>> would fix the issue, which is as well backchannel related.
>>>>>>>>
>>>>>>>> This is upstream: 6ddc9deacc13 ("SUNRPC: Fix backchannel reply,
>>>>>>>> again"). While this commit fixes 57331a59ac0d ("NFSv4.1: Use the
>>>>>>>> nfs_client's rpc timeouts for backchannel") this is not something
>>>>>>>> which goes back to 6.1.y, could it be possible that hte backchannel
>>>>>>>> refactoring and this final fix indeeds fixes the issue?
>>>>>>>>
>>>>>>>> As people report it is not easily reproducible, so this makes it
>>>>>>>> harder to identify fixes correctly.
>>>>>>>>
>>>>>>>> I gave a (short) stance on trying to backport commits up to
>>>>>>>> 6ddc9deacc13 ("SUNRPC: Fix backchannel reply, again") but this quickly
>>>>>>>> seems to indicate it is probably still not the right thing for
>>>>>>>> backporting to the older stable series.
>>>>>>>>
>>>>>>>> As at least pre-requisites:
>>>>>>>>
>>>>>>>> 2009e32997ed568a305cf9bc7bf27d22e0f6ccda
>>>>>>>> 4119bd0306652776cb0b7caa3aea5b2a93aecb89
>>>>>>>> 163cdfca341b76c958567ae0966bd3575c5c6192
>>>>>>>> f4afc8fead386c81fda2593ad6162271d26667f8
>>>>>>>> 6ed8cdf967f7e9fc96cd1c129719ef99db2f9afc
>>>>>>>> 57331a59ac0d680f606403eb24edd3c35aecba31
>>>>>>>>
>>>>>>>> and still there would be conflicting codepaths (and does not seem
>>>>>>>> right).
>>>>>>>>
>>>>>>>> Chuck, Benjamin, Trond, is there anything we can provive on reporters
>>>>>>>> side that we can try to tackle this issue better?
>>>>>>>
>>>>>>> As I've indicated before, NFSD should not block no matter what the
>>>>>>> client may or may not be doing. I'd like to focus on the server first.
>>>>>>>
>>>>>>> What is the result of:
>>>>>>>
>>>>>>> $ cd <Bookworm's v6.1.90 kernel source >
>>>>>>> $ unset KBUILD_OUTPUT
>>>>>>> $ make -j `nproc`
>>>>>>> $ scripts/faddr2line \
>>>>>>> 	fs/nfsd/nfs4state.o \
>>>>>>> 	nfsd4_destroy_session+0x16d
>>>>>>>
>>>>>>> Since this issue appeared after v6.1.1, is it possible to bisect
>>>>>>> between v6.1.1 and v6.1.90 ?
>>>>>>
>>>>>> First please note, at least speaking of triggering the issue in
>>>>>> Debian, Debian has moved to 6.1.119 based kernel already (and soon in
>>>>>> the weekends point release move to 6.1.123).
>>>>>>
>>>>>> That said, one of the users which regularly seems to be hit by the
>>>>>> issue was able to provide the above requested information, based for
>>>>>> 6.1.119:
>>>>>>
>>>>>> ~/kernel/linux-source-6.1# make kernelversion
>>>>>> 6.1.119
>>>>>> ~/kernel/linux-source-6.1# scripts/faddr2line fs/nfsd/nfs4state.o nfsd4_destroy_session+0x16d
>>>>>> nfsd4_destroy_session+0x16d/0x250:
>>>>>> __list_del_entry at /root/kernel/linux-source-6.1/./include/linux/list.h:134
>>>>>> (inlined by) list_del at /root/kernel/linux-source-6.1/./include/linux/list.h:148
>>>>>> (inlined by) unhash_session at /root/kernel/linux-source-6.1/fs/nfsd/nfs4state.c:2062
>>>>>> (inlined by) nfsd4_destroy_session at /root/kernel/linux-source-6.1/fs/nfsd/nfs4state.c:3856
>>>>>>
>>>>>> They could provide as well a decode_stacktrace output for the recent
>>>>>> hit (if that is helpful for you):
>>>>>>
>>>>>> [Mon Jan 6 13:25:28 2025] INFO: task nfsd:55306 blocked for more than 6883 seconds.
>>>>>> [Mon Jan 6 13:25:28 2025]       Not tainted 6.1.0-28-amd64 #1 Debian 6.1.119-1
>>>>>> [Mon Jan 6 13:25:28 2025] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>>>>>> [Mon Jan 6 13:25:28 2025] task:nfsd            state:D stack:0     pid:55306 ppid:2      flags:0x00004000
>>>>>> [Mon Jan 6 13:25:28 2025] Call Trace:
>>>>>> [Mon Jan 6 13:25:28 2025]  <TASK>
>>>>>> [Mon Jan 6 13:25:28 2025] __schedule+0x34d/0x9e0
>>>>>> [Mon Jan 6 13:25:28 2025] schedule+0x5a/0xd0
>>>>>> [Mon Jan 6 13:25:28 2025] schedule_timeout+0x118/0x150
>>>>>> [Mon Jan 6 13:25:28 2025] wait_for_completion+0x86/0x160
>>>>>> [Mon Jan 6 13:25:28 2025] __flush_workqueue+0x152/0x420
>>>>>> [Mon Jan 6 13:25:28 2025] nfsd4_destroy_session (debian/build/build_amd64_none_amd64/include/linux/spinlock.h:351 debian/build/build_amd64_none_amd64/fs/nfsd/nfs4state.c:3861) nfsd
>>>>>> [Mon Jan 6 13:25:28 2025] nfsd4_proc_compound (debian/build/build_amd64_none_amd64/fs/nfsd/nfs4proc.c:2680) nfsd
>>>>>> [Mon Jan 6 13:25:28 2025] nfsd_dispatch (debian/build/build_amd64_none_amd64/fs/nfsd/nfssvc.c:1022) nfsd
>>>>>> [Mon Jan 6 13:25:28 2025] svc_process_common (debian/build/build_amd64_none_amd64/net/sunrpc/svc.c:1344) sunrpc
>>>>>> [Mon Jan 6 13:25:28 2025] ? svc_recv (debian/build/build_amd64_none_amd64/net/sunrpc/svc_xprt.c:897) sunrpc
>>>>>> [Mon Jan 6 13:25:28 2025] ? nfsd_svc (debian/build/build_amd64_none_amd64/fs/nfsd/nfssvc.c:983) nfsd
>>>>>> [Mon Jan 6 13:25:28 2025] ? nfsd_inet6addr_event (debian/build/build_amd64_none_amd64/fs/nfsd/nfssvc.c:922) nfsd
>>>>>> [Mon Jan 6 13:25:28 2025] svc_process (debian/build/build_amd64_none_amd64/net/sunrpc/svc.c:1474) sunrpc
>>>>>> [Mon Jan 6 13:25:28 2025] nfsd (debian/build/build_amd64_none_amd64/fs/nfsd/nfssvc.c:960) nfsd
>>>>>> [Mon Jan 6 13:25:28 2025] kthread+0xd7/0x100
>>>>>> [Mon Jan 6 13:25:28 2025] ? kthread_complete_and_exit+0x20/0x20
>>>>>> [Mon Jan 6 13:25:28 2025] ret_from_fork+0x1f/0x30
>>>>>> [Mon Jan  6 13:25:28 2025]  </TASK>
>>>>>>
>>>>>> The question about bisection is actually harder, those are production
>>>>>> systems and I understand it's not possible to do bisect there, while
>>>>>> unfortunately not reprodcing the issue on "lab conditions".
>>>>>>
>>>>>> Does the above give us still a clue on what you were looking for?
>>>>>
>>>>> Thanks for the update.
>>>>>
>>>>> It's possible that 38f080f3cd19 ("NFSD: Move callback_wq into struct
>>>>> nfs4_client"), while not a specific fix for this issue, might offer some
>>>>> relief by preventing the DESTROY_SESSION hang from affecting all other
>>>>> clients of the degraded server.
>>>>>
>>>>> Not having a reproducer or the ability to bisect puts a damper on
>>>>> things. The next step, then, is to enable tracing on servers where this
>>>>> issue can come up, and wait for the hang to occur. The following command
>>>>> captures information only about callback operation, so it should not
>>>>> generate much data or impact server performance.
>>>>>
>>>>>     # trace-cmd record -e nfsd:nfsd_cb\*
>>>>>
>>>>> Let that run until the problem occurs, then ^C, compress the resulting
>>>>> trace.dat file, and either attach it to 1071562 or email it to me
>>>>> privately.
>>>> thanks for the follow-up.
>>>>
>>>> I am the "customer" with two affected file servers. We have since moved those
>>>> servers to the backports kernel (6.11.10) in the hope of forward fixing the
>>>> issue. If this kernel is stable, I'm afraid I can't go back to the 'bad'
>>>> kernel (700+ researchers affected..), and we're also not able to trigger the
>>>> issue on our test environment.
>>>
>>> Hello Dr. Herzog -
>>>
>>> If the problem recurs on 6.11, the trace-cmd I suggest above works
>>> there as well.
>> the bad news is: it just happened again with the bpo kernel.
>>
>> We then immediately started trace-cmd since usually there are several call
>> traces in a row and we did get a trace.dat:
>> http://people.phys.ethz.ch/~daduke/trace.dat
>>
>> we did notice however that the stack trace looked a bit different this time:
>>
>>      INFO: task nfsd:2566 blocked for more than 5799 seconds.
>>      Tainted: G        W          6.11.10+bpo-amd64 #1 Debia>
>>      "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables t>
>>      task:nfsd            state:D stack:0     pid:2566  tgid:2566 >
>>      Call Trace:
>>      <TASK>
>>      __schedule+0x400/0xad0
>>      schedule+0x27/0xf0
>>      nfsd4_shutdown_callback+0xfe/0x140 [nfsd]
>>      ? __pfx_var_wake_function+0x10/0x10
>>      __destroy_client+0x1f0/0x290 [nfsd]
>>      nfsd4_destroy_clientid+0xf1/0x1e0 [nfsd]
>>      ? svcauth_unix_set_client+0x586/0x5f0 [sunrpc]
>>      nfsd4_proc_compound+0x34d/0x670 [nfsd]
>>      nfsd_dispatch+0xfd/0x220 [nfsd]
>>      svc_process_common+0x2f7/0x700 [sunrpc]
>>      ? __pfx_nfsd_dispatch+0x10/0x10 [nfsd]
>>      svc_process+0x131/0x180 [sunrpc]
>>      svc_recv+0x830/0xa10 [sunrpc]
>>      ? __pfx_nfsd+0x10/0x10 [nfsd]
>>      nfsd+0x87/0xf0 [nfsd]
>>      kthread+0xcf/0x100
>>      ? __pfx_kthread+0x10/0x10
>>      ret_from_fork+0x31/0x50
>>      ? __pfx_kthread+0x10/0x10
>>      ret_from_fork_asm+0x1a/0x30
>>      </TASK>
>>
>> and also the state of the offending client in `/proc/fs/nfsd/clients/*/info`
>> used to be callback state: UNKNOWN while now it is DOWN or FAULT. No idea
>> what it means, but I thought it was worth mentioning.
>>
> 
> Looks like this is hung in nfsd41_cb_inflight_wait_complete() ? That
> probably means that the cl_cb_inflight counter is stuck at >0. I'm
> guessing that means that there is some callback that it's expecting to
> complete that isn't. From nfsd4_shutdown_callback():
> 
>          /*
>           * Note this won't actually result in a null callback;
>           * instead, nfsd4_run_cb_null() will detect the killed
>           * client, destroy the rpc client, and stop:
>           */
>          nfsd4_run_cb(&clp->cl_cb_null);
>          flush_workqueue(clp->cl_callback_wq);
>          nfsd41_cb_inflight_wait_complete(clp);
> 
> ...it sounds like that isn't happening properly though.
> 
> It might be interesting to see if you can track down the callback
> client in /sys/kernel/debug/sunrpc and see what it's doing.

Here's a possible scenario:

The trace.dat shows the server is sending a lot of CB_RECALL_ANY
operations.

Normally a callback occurs only due to some particular client request.
Such requests would be completed before a client unmounts.

CB_RECALL_ANY is an operation which does not occur due to a particular
client operation and can occur at any time. I believe this is the
first operation of this type we've added to NFSD.

My guess is that the server's laundromat has sent some CB_RECALL_ANY
operations while the client is umounting -- DESTROY_SESSION is
racing with those callback operations.

deleg_reaper() was backported to 6.1.y in 6.1.81, which lines up
more or less with when the issues started to show up.

A quick way to test this theory would be to make deleg_reaper() a
no-op. If this helps, then we know that shutting down the server's
callback client needs to be more careful about cleaning up outstanding
callbacks.


-- 
Chuck Lever

