Return-Path: <linux-nfs+bounces-16345-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6102C57FDC
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Nov 2025 15:40:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 638233BC076
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Nov 2025 14:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FDD12BEC43;
	Thu, 13 Nov 2025 14:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="h9e9xat4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HExaocyK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8671F26C3AE;
	Thu, 13 Nov 2025 14:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763044264; cv=fail; b=laTuqYF2ywKZI1mWcZyqY4F32uxDTSY4cHpY4tHKQBdkZTqOkezaLTELh2WUAoUc0qAWHB0tJUxysOO91sFLlgiZ/wcuPTzJlcX1ffZmJkLYVS3dqLF1zk3wCMInOgpfLeZ4Rs8UnQlLF0zK8MDbSF1SBaEN0tPVKSXnrzY767E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763044264; c=relaxed/simple;
	bh=rPRFa56su7Zo6RLykzTsUJNl3iaY4p31Gr64nzGJD7A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kAJ4yHpFlHaRIvXHiPagkWp8HfuL3/sssOaHTmotTTwvzlubIv5ldWqz/UcRRMKaboLlnZWC9P3UlpYpPyNVSK7JcitiVmrK6I3MOkth5p2yFbJ0WDAhaQxJJ2g2Jo8jLkKjJiZdoiIoUIcTPm+5qP15g6K+83vm1P2/LtUq9lA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=h9e9xat4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HExaocyK; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ADE9uhe023920;
	Thu, 13 Nov 2025 14:30:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=flO/N/I7KjyZLrXDGIzq4yGDuL99IO01Xl3rk30MvDk=; b=
	h9e9xat4EkmuHB9144/VAkxjTuqvQxcneJ49yib0dl6IjaLRPGmOBZZ0UtoqwT7Y
	zWtjRaW++cePxA7eqQHC7Lc+uqfZLvR6M6XEPfY6M8YAwmfDLK3pEHfmrDpo67RF
	msbOlE3xSCzl2zOt2xAB9vWnJh201KIJsaR1GOwBgg9wxiH64R5Vm0Tp51h7nPtx
	RZv2ApEECGH2amww0G0jKsbr6vyZp/Vkq22YBesVpmSdt+kf4jxJmMgLxe8bNpuR
	7dTIKBX5zv+jO36Hr1Y5wncE+KxWI+faEIObvriKBsjFbKpLLwg1OP+2VMrhambs
	eJf97hp7T/zW/znMcBcmOQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4acvsstb82-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 14:30:30 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5ADEB7ul027739;
	Thu, 13 Nov 2025 14:30:29 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011037.outbound.protection.outlook.com [40.107.208.37])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vag8fp0-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 14:30:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kUO+hbdDyzKxkOZjkupEzp6O8T/A8FSoMkJYUtfo/TclvwsedZWKMtwnfKKDU+Z8pwYEjX2R28hQc2XijKKuOih7sNKuzFdjPvnEViMqpWkFM1is3qg6bWsjglMgw4KtgOU/OfFa7qjHm5zn1KGNnodBvv+xKCRegHWLCnhQ4JCh0xBrv36vWbiSF6BsS9UC1w7oCeJ83SjLz4boadSzgi+msibpIbvrrl6AtL89u/ZMYvIugWd480Kk0/4Jh4oEiDuBB4tTVOzkbQM46+bI7kf9p4Ii7MuXs+14lD92NH4xlSpvg1gwsHzxmMTKUzfh+/tt4l/x25jyEl3qW5gRyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=flO/N/I7KjyZLrXDGIzq4yGDuL99IO01Xl3rk30MvDk=;
 b=JE1jwZ7KgOQ6gMjf6H1nVxoLEcYoFkweoKIptz37u1K+tz6Q+P7nqyR4KtTECeF8iTxf3vV4gscaar5DjhkDJuBvJRGve+8l6hn7KVZ+jb/VJF4SsX3Dp71bKhO2T8TTaJfiOYkxQHekeCkluOosudfR/3JzUc728YKSwxkIATv6XH8fXjSd4p28prS7gQlscqHAUPBtTk8uaY1+JS6O6ul116gdOxzm8HgVUi4Uic6m55lEQLdjI8qiHczScexJ05s1lc0VwuaQJPPjq0X8Yp2f995yHvkJz1kW5qT+gmuh8WZ7Jqxgd2XXptHzw/H7Ml2YkFwLZOW/Q8ecJtDppQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=flO/N/I7KjyZLrXDGIzq4yGDuL99IO01Xl3rk30MvDk=;
 b=HExaocyKZ+b+IU+LDnWeifztdeOKkf29LFIQS8pi+bw9uZRv2Vo3zn7gwElehXgaO0EZSkbhNbkssTUK2HmsKBsHIbOcpDsSr5Xo8gPHJ2PhUAvZbn9cXZkN8IDKk1lcYNesI2g8pD++nLClwO6JAt3dTpREFOKxA+NNu0xPcXU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH3PPF18C4487EB.namprd10.prod.outlook.com (2603:10b6:518:1::78b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Thu, 13 Nov
 2025 14:30:22 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.9298.010; Thu, 13 Nov 2025
 14:30:22 +0000
Message-ID: <8d873978-2df6-4b79-891d-f0fd78485551@oracle.com>
Date: Thu, 13 Nov 2025 09:30:20 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: ls input/output error ("NFS: readdir(/) returns -5") on krb5
 NFSv4 client using SHA2
To: Salvatore Bonaccorso <carnil@debian.org>,
        "Tyler W. Ross" <twr+debbugs@tylerwross.com>, 1120598@bugs.debian.org,
        Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
        Scott Mayhew <smayhew@redhat.com>, Steve Dickson <steved@redhat.com>
Cc: Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>,
        Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <176298368872.955.14091113173156448257.reportbug@nfsclient-sid.ipa.twrlab.net>
 <aRVl8yGqTkyaWxPM@eldamar.lan>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <aRVl8yGqTkyaWxPM@eldamar.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH3P221CA0005.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:1e7::29) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH3PPF18C4487EB:EE_
X-MS-Office365-Filtering-Correlation-Id: ee42bd4b-eaef-449e-4581-08de22c12dbb
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|159843002;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?dHU4VGovTjU0bEQ0Vlh6Sm1ZS2FiM0k4em54cTlab1pSVUtQbVliK0labmNQ?=
 =?utf-8?B?REoxT2hWbnR1VERObFNVaGZNRmZLUDA2Nlh4MHFwMDVtdng3cWJxV0FjMzBR?=
 =?utf-8?B?YWhxL2R6V3B3aHcwYUxZeG9RcHF5TE5kWmk3Y3c3MnhnR3pBNGRpbnpkYmYw?=
 =?utf-8?B?aGtPR3VjU1I0U0RkY1djclRrNVQ5VkhpRGErV24wYlNQQXNmRWM3YmE0V0JB?=
 =?utf-8?B?OVdqYW5ZdkJIL01xc3F1NUtVaDNBOTQraWhxVzFEQThLcFg0TVYyZDkvdi9I?=
 =?utf-8?B?T2VraUpCVTlxTDl0WmIwOXRXR05yblJXbjNYNmZ4OVQzSHUrdEtYM2xQNWVi?=
 =?utf-8?B?TUh6YmwrNVBEYXM0ZHRPR1VrWkMyNTZ4RFJ4OWpWQi9iU0wvQiszRVNLZkJn?=
 =?utf-8?B?bDRyV0Yyd2pEU2ZEdjNTZmovbVBsRkdoZFpGNmNpU0Q3U0VEclhtbGc5NEFj?=
 =?utf-8?B?RlJ3a2pOUVlkM3FoTGU4dGxlcm1OVjFhOWdYcTM3dWNNZVpDbUhXSHpIdFQ0?=
 =?utf-8?B?ZFJsRUV0SWdxSUVrOTBaRXU4dVVtaXAxTlkrWmZuU0RHS3l6YUVNNXVXTTNT?=
 =?utf-8?B?ZU14OHhOY0VXcmdxbkJhc0ZNWFArbXlTZFNXcEliZGY1SkI2dEdHLzlLV2lX?=
 =?utf-8?B?Q2NlTWdJK0ZvRExibHZNNnUyVnNSRlgwMEQ3Z3RIK0lHWFVGcUVIQW1IdFJW?=
 =?utf-8?B?RGpmOXN1M21IdkZQR0Y4TitWMkhjWHlwRE1RRm01VjlvYUV5ZjdOeGswOWVH?=
 =?utf-8?B?bHN5VDhHUmEwanNCelZRRFladU5sbVFjQ2ZtSWpJOUVPenNoak96eGZhRjF1?=
 =?utf-8?B?RWJmdlRjcjBldURhS3JpQThaSjRiMFNJMllpNHYwRjZoNmFFZTB6TkNaWS9w?=
 =?utf-8?B?dW1nYk5rVU9NanBydUtqZlRHSXIxTUR1eHAvSzYxRE14S2MrTFZHbHdjaElW?=
 =?utf-8?B?SGxWTHNBNk0zWTRTOHRPeHFyR0tvanVDTldoY01CSmEwNVpsUjNqUXZhRWUz?=
 =?utf-8?B?TjQ0NWhkRUN4cUtFMXpRWlpnR0ppckduUmhtcmRKVHlDVXh3Z2NXUmZ6TFBN?=
 =?utf-8?B?ZytBTllTRXk2VnMyQ2QwNkF5YnNLYTdRQTh4TFo0djcwdXFZSkgrekpPTmVn?=
 =?utf-8?B?UFpRVCtaVmFuOTl0WjlCOS9tcWFXZ29ydVkybW5vUllJLzBLNGNXdGMxK0hx?=
 =?utf-8?B?ak5aSDJKcTJPM3NUVFAvdWk1eTkvbk5tZUdBMEVCd2YzMnl0emZLSDZ4aU1y?=
 =?utf-8?B?VjNhZEE1NDNRYnVCeENCU3Q5M2ZHNEkwb3REeFlweTl3OWdYM3Y5bHM1RzE5?=
 =?utf-8?B?VnpFemRhbmxnYlpyWkN1Q2M5dW1IU3R3Z3N6Q29KUGI5bFZSb1pPOHlSejhw?=
 =?utf-8?B?YTQ0Wm14cHdXcXpuUXlwZURQU240WjJ6SmorbVVZblpGdE5yRU5jNGU1V0Nr?=
 =?utf-8?B?NW9tcUxac3h2d1pOTjJ0c1BQc2g0M0pQYkVOeWk0WVRsTTFmVEJybW1yMS9U?=
 =?utf-8?B?dHgyTktkWHg0V0M5UzZ3UlhJNGkxZkdGMnpvdFZrZjg5bzFud2U2ZGhTMzFI?=
 =?utf-8?B?SWxWREpPZXdGYjFRWE1oaFdxNTR2SnFNdGZ3cmRVNWxyZmoxdzNBak5uVXQ2?=
 =?utf-8?B?VHFXQmZBc2p3U2dTS2xEVys3dWNLK0RPYitscmpidTZOTkN2c0paU3dRaWtD?=
 =?utf-8?B?NVU5QnZrbjJMRmkxTXhrN1l5SzhXUCtXeFBXSUcxVUxpNUlDMjcwZUhZL21N?=
 =?utf-8?B?MWRQUzI1ODlwdmFtcUh4bm82N3RHR2Q5MEVwZE1GZSs5UkYrdHFpdWpid0k1?=
 =?utf-8?B?aEE5Q0tKKzBPK2x3Y1lMZG1VZVVDR2pKcUNRZVFUdlJ2ZGlZWEM1M2NWOWtx?=
 =?utf-8?B?a1RKcUZaWVQ1WEppT2hzRklXaFhkWXhKa0tZYVp1OFFLMDZvNEtaNUVQQkh3?=
 =?utf-8?B?eVdqRXVXanZmelpRaFBpcnVJTUthdDNIbGdQS0RHZWFrQWNwYTZUbUtTSUxS?=
 =?utf-8?B?YlhEMmRHSEZVOVA2K0p3T2VlbE01aVE3NDYvdXJ0T01XNHlHMHIzWU1FTkFE?=
 =?utf-8?Q?60rmih?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(159843002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?SWpSaDR5TkwrRVVqOFVrR2RVTkIzcUNKQ0VWWEVZaHZ3ZTJFeEptSWc1Rm9t?=
 =?utf-8?B?eW1HS3dmeHNHTkM1b08vL3ZHeFV2UnVzQzAzTlpGc3F5aWVXbkEzL0J0dFd2?=
 =?utf-8?B?d24vMkVvYjZiZm9wMWVPYUU2UFJ2aTVZWmtQUXVQVW14Y1FzeEV1ZHY3dG91?=
 =?utf-8?B?WkxsSU9zVGZVZURDTnFyYkE3T051c2JOQXNUOGVsUXdodjJ1SkJhR1FSbEUz?=
 =?utf-8?B?djZnZmFqbXhQNVNqc1czeWwyQlVIeFR3RTRIcC9pVzZlN2JLNEV5OUwvU0VI?=
 =?utf-8?B?UnVzWXcwOVFoNzZwekd0dW1QNlM2VWpYRUhLS01GU29lL2dhK2I3aFUxUXR6?=
 =?utf-8?B?MzBuZk9YSVhQMSsyenBmSmhCTkJoamYxVzQyZ2RSYXZDVzlqUE5peVovUXVo?=
 =?utf-8?B?Ynk4S3U3NThUbzNBd3ZIQ1pvdno0cHFIb014YVRvWWlkd0FEejk2VW95Z0NX?=
 =?utf-8?B?cGtoT0t3aFBSaWV5WjBML3BZNG82U3RaTmE4N2JaeklYck40RndDdlVQaTV2?=
 =?utf-8?B?N25Ld3lUVGo0aEc0ZmlWZnIxeEE5YTlLZ1JpQ2E2cnFjOXdaQlJzMEI3TmZa?=
 =?utf-8?B?d012bS9NM1FNYmxlWjJrckpPL0ROcUt5VSs0RDJFTjVCNjVreG1LN1pzUklo?=
 =?utf-8?B?dERTU2dsY084cTIrODhGOEtmWkxHRFc3cEVHWnVVL1h4SHN3c1pKd1pzaExx?=
 =?utf-8?B?aU5iYnNJSVg1cUZIZFgvMDhKN294VUxoRUpsZDIzd1RQaFovS0J5Y29PNHZK?=
 =?utf-8?B?OFo3cWsxT2l0UXFJdktVMHIzeWNScVUzOUFsM1BKdytvNnI3dGZJN3lQNDg0?=
 =?utf-8?B?QlgvMnJrS2w0RUxDazJZRXhReXVCNmcrN3RHNjdXMHY5Z3pSNmU1THZ0dzI5?=
 =?utf-8?B?Rm9WZDZqb2c2MjJHcEJQa09BN2JKNTd6dmtseTZReFlVM2R5T1NKd3hIbk9J?=
 =?utf-8?B?Y2tWM3ZCVE1YV3Z2UzhWeWZZQVFaY2RhbmRJbEM2NFhQanRwZHpRVVNZVFp3?=
 =?utf-8?B?VGZYQ2tHa0x6V1FiTWdhYzYrUmplamxFZStvTDUrT3hJSk9hWDVNTmZLaVJr?=
 =?utf-8?B?Z0F6QjdTZHZuMXh6ZEpZQkpjYzJRWWllRjRxVmJUUm1haVkvWXJra3VPdk11?=
 =?utf-8?B?ODZXUlp4cEE4ajZmb2RhSnJ5YmFKUW8rZ1BISk1YdnRPKzUwZkNiK0lpRGVG?=
 =?utf-8?B?bXAxZHF4ZytMMjJsZXBCQ2dOSXhXQndzU3FxZi9YMXl1eGFtd0gxKzU5TnZP?=
 =?utf-8?B?dVVFQTdGdGZjL1Y1T3V0SlJVaE4zN3dORkxsb1ErVXZFUWw5MFVpYmpKcmJm?=
 =?utf-8?B?Tk5Jc0xmTUN6S2FJV0FTV2p5aHZEK09LUmNOYURaYVRvNTRQZXdwbmd6UW9I?=
 =?utf-8?B?QytXVWJ5cVFxa3lvd0d1QTFpbGZHamE0NEdxU3BKRy92eHFXYmFmbm1yYXV3?=
 =?utf-8?B?TFNHdnZDM0ZGeE1HNzlQMWxJV0pLcFpnY2JuQTEyMkdEQkhYdWxGYmFKQ29k?=
 =?utf-8?B?VzlkS3plNUh2OEtLTTR0d1BveXBEd0x0V3RGOHdVU3hSYk9zTGNpNTM5VytK?=
 =?utf-8?B?cU9rejQxdTZ4cjJtaUVaTTlmK0dFKzVWamRHZDZlSTk4Z2lXdFNNWlVZUlNt?=
 =?utf-8?B?N0ltMGk2Qkc5SThnZWYyT0RZTHBsRXBPYmVsTzVFSUNNQ3V5bFArS1k2aXVJ?=
 =?utf-8?B?UVkxemVVQk9HVmp4VG4xQWc5TnF6b09XSm05Q2pKWnU3Ym1kUW5hWG42K1hC?=
 =?utf-8?B?Q3VoRWtIS0ZmODJ5YkZ2OE9PR2hnTlZhMWR6T1BXRk9Xcnp4YjNtTkxUL0tn?=
 =?utf-8?B?a0NTd0ZmS01NLzdNR0ZSMGNPQnh1L0h5UmNTdlVIZGZxeTlZMm93NzlPaUpk?=
 =?utf-8?B?N0ovMHVwam54V0hEbDh1dzZ6NmVCR1gzSDhzQlM5QlRNNzBDK0hOTU1tQUZR?=
 =?utf-8?B?NTZFM1NYN0NOVllwZys5RmM0ejRQYmRvN3Zic0prYkJiU1l2OHlUTisvQUZF?=
 =?utf-8?B?OWtuWk1rbXpneHBKUlpONS9zV3pkZkhIN0h1dzNCYzlqcm4vS1pMcndNTEpQ?=
 =?utf-8?B?SFRoNzNDMlY0NFZoeDlTM010NUp1VFVvbzkzNHl4ZzNleGZzSm5QcFdnVlZK?=
 =?utf-8?B?VDJzZ0YvSnJSdXpKL1R3QTdPQmVoa2RnRW9tQnFpeWhMTFl3ekFpdmd4Vnhj?=
 =?utf-8?B?bnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	90O5O86SsEMbSFZGlNiL1/WaVA+stZircuVd6Q6RyyTY+77v4q0SoxrOJfBw6r81lF98l+Vnk2WG7+zPj4S7msVjOZo09GBFhzcKHT+Mk7AOxXCiswFO2pQuxuraNQME7Y9PsMVmlQZX3k2ySSO4nAcypkIEvL5NGQLb8MC/XiO4C2PqOpeUiJkawBjpv4rMUdBtfBFYifCHTrwlt+odiiwYobl96Ln9xphDyuiNxmYd+4FNrLa7wZveDCjzUD9zh3uuRMjunxDZEiYRRuzJTWuXmUGT367b/cWP0yFcZtbTKPugeZmwCIxe09dwI4ndEUnm8iTus70kbLzaOm7Ya+e+ZExcdtQUVzENyTtgTVqsR2G3HR4gMVGefcs/sZgcuQGq1+iJn7Q07BAaoY1+wchdtCWPcHP5ToHmsmnEhh9K5joMe8VX41i46bivLh2ElEhbLWl+6lOvz+awYKIUwG+DBJvroObJnnnZ3FqSHRMaYvq2CfExH5v1VFSGqD+e4yHgqBy7lXwWBBvg/EUpeuSPq0sgj6s58+TLKWu9KyTcALmh770JFOzPT5b+URiOFzUunETedb3eUDXxfjPijj2fW1q4B1dRlDvF5cosFEY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee42bd4b-eaef-449e-4581-08de22c12dbb
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 14:30:22.6447
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GX9n3eLoxEvcRxnz93RjbKHQaF2ml6V9Kvj8pN9zqs0urz+xiwmhNRPEAlkukXR8SI0cDu6wTuBoAyinBEVrDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF18C4487EB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_02,2025-11-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511130111
X-Authority-Analysis: v=2.4 cv=bJUb4f+Z c=1 sm=1 tr=0 ts=6915eb86 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=JMndbMz8j2dp9c8Az_sA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13634
X-Proofpoint-GUID: pqoiS2CHhRC3yH2igSLgifV2gnqikBZA
X-Proofpoint-ORIG-GUID: pqoiS2CHhRC3yH2igSLgifV2gnqikBZA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDEyMyBTYWx0ZWRfXwuRGMnaY8b9t
 t/68+0305Hq3RgpL1X/8kEba8LKxkKU+xhKwCWZaRJos5u8unjuaChYXmJiLzU5zrE7VCfC8iha
 KWsE9pA7Jorm9DceyOWILbvmtpCfODjWeYsThzhpwCCuaNVRODEJiapK3QT3spCiPs6/D+1d/1J
 WMvR/56d6LCO4y0qQFrc5EoR444cDpiYzwH+gMmCS7Bd7WW4xLAijj24gb5U282XxBhWd19u8uR
 k8UeXQMCOCDn3Ls5cWnWG394QNvGbIXUFD9KJSZoW5sxYUl+f/S5yWcefY3VBqetBxKo/Kf6viO
 ryHEMPd62khTVOHl0LvbeJjdnA/8MxW/7vJOJp7Vd8b4frk3/O/5Lvj0M02f/WDNyqGpJ5Ry+CW
 KvUaP3wLWVhOPkB9W2EgMhlv34OQd/UT7+vPWcQrc96PDK9kYH0=

On 11/13/25 12:00 AM, Salvatore Bonaccorso wrote:
> [332376.824087] NFS: readdir(/) starting at cookie 0
> [332376.824641] _nfs4_proc_readdir: dentry = /, cookie = 0
> [332376.825229] --> nfs41_call_sync_prepare data->seq_server 00000000e22b1bd9
> [332376.825967] --> nfs4_alloc_slot used_slots=0000 highest_used=4294967295 max_slots=64
> [332376.826814] <-- nfs4_alloc_slot used_slots=0001 highest_used=0 slotid=0
> [332376.827616] RPC:       gss_krb5_get_mic_v2
> [332376.828114] encode_sequence: sessionid=1762048597:1479457708:22:0 seqid=28 slotid=0 max_slotid=0 cache_this=0
> [332376.829146] encode_readdir: cookie = 0, verifier = 00000000:00000000, bitmap = 0018091a:00b4a23a:00000000
> [332376.830144] RPC:       gss_krb5_get_mic_v2
> [332376.830720] RPC:       xs_tcp_send_request(284) = 0
> [332376.831431] RPC:       gss_krb5_verify_mic_v2
> [332376.831967] RPC:       gss_krb5_verify_mic_v2
> [332376.832498] --> nfs4_alloc_slot used_slots=0001 highest_used=0 max_slots=64
> [332376.833254] <-- nfs4_alloc_slot used_slots=0003 highest_used=1 slotid=1
> [332376.833994] nfs4_free_slot: slotid 1 highest_used_slotid 0
> [332376.834695] nfs41_sequence_process: Error 0 free the slot 
> [332376.835318] nfs4_free_slot: slotid 0 highest_used_slotid 4294967295
> [332376.836016] _nfs4_proc_readdir: returns -5
> [332376.836519] NFS: readdir(/) returns -5

That looks like the client can't understand the server's READDIR
response.

Trace points might give a little more indication of the problem. On the
client, start the tracing command:

 # trace-cmd record -e nfs -e nfs4 -e sunrpc -e rpcgss

In another window, run your reproducer. When it's finished, ^C the
trace-cmd, then:

 # trace-cmd report | less

There are also Kunit tests for the SunRPC Kerberos module to confirm
there isn't some kind of basic problem there.


-- 
Chuck Lever

