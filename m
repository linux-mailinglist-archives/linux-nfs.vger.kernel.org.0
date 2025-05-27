Return-Path: <linux-nfs+bounces-11930-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60252AC5C2C
	for <lists+linux-nfs@lfdr.de>; Tue, 27 May 2025 23:27:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21CD64A119E
	for <lists+linux-nfs@lfdr.de>; Tue, 27 May 2025 21:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C55BC1ACEAC;
	Tue, 27 May 2025 21:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iDMshJpR";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Fo06Sz9c"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D8D20A5DD
	for <linux-nfs@vger.kernel.org>; Tue, 27 May 2025 21:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748381251; cv=fail; b=mx4gSb4/mC0Knxd9PjOcRpm0ZISIxxSvgMoVSJ34qeSif0RMYgdRnFtL/ZIPYYldhME7PrHjI+j/TagMLsZgRpj0F8zQDstjRPuskKQsbdsJmUGsYBda0WSJ6DCv5/dq+Kx7rBM+6XRKxpWSGcRiz+Tz6BXDfr/Vs6rPPBEk2wA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748381251; c=relaxed/simple;
	bh=lZvaA1QPl1cpurQ0byVxyC1nrjKstnTsdUuQXnea4rk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aASES+bdTBshxALDMlUEZnQVjLih2iSaf4pCfxZAHupfkhUEV8n7ppD4MWLV7J8R7XaRs2b4HIX5SK27sNV0rI4gKCIkJNa/3KQefhDgIpBKtAhHjDons3LKa6/IskmnnxsgFArQk9KlTtDo9JEmTuU6MI7QTRhybAbCchpCUwE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=iDMshJpR; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Fo06Sz9c; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54RLNt3U025240;
	Tue, 27 May 2025 21:27:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=wLjt0r5SKSUDjg4cv6Bjs0+dwZgVCM6bkb+V0O8lic0=; b=
	iDMshJpRPSuJQzxTSacOKX9sC8ZR0mv19gyOzO0vFWe0ytlwNfBhfahu1E6iCjwB
	SQovn79gkxdEULKJHNBGMOXDihCjA3wS8223xWI7ArLhQLv3NKgYaAN1EDDtCVaG
	BVZr9/HkEIpsvhJzHGZ0r/8BK+tCHD2kMI1Ako7JZxQaZHFyKPxLpxq+Hfda8Ma4
	KspdeE0uxei4eBzjwNR22cTadhwhUGfd2g0Ck35dPTBgQNv0ADvRSGQrxy0TJvrp
	rIgjVq3l4o9q94YPnqYc9YnV3SHM3yhkHB68Z9xReCdwf7WOD7CzT4MWA78MoedY
	pZ5ynUr2GjgS+LynENUJTQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46v3pd4b2x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 May 2025 21:27:22 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54RKgb7t023847;
	Tue, 27 May 2025 21:27:21 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46u4j9j9n7-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 May 2025 21:27:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q2PFTFZ9BP1UEh8GmM9m3rHSsgyOL6Mo6TehWhdDLGOrrp0n1Cr42Ar0OMEB63AL5xY50+GStoet5SbrVVkbyXMgdyuRyUIoYK4Non9AOGbtIF2ufpyaF5sfN6lE7EAgnWdjmfntoU56vAX56DILTfmZ5g96r1fxy803iu0SxbL8HUwI1DItCeJGyv5Nw7yDK8dmxi/kNAvDlFr7Ma43kyBGdfW7pXOYqHMr9EBiDliICDYANObCheTpoKFW+PwrwAu7UTrQV4xCO1vvPQRzku0s/qxCiQX5UgbObo4qcEv8ZRJh3tFxNCOpSnbAaxFW3NRDcz2H6eKmtCK3OpXo1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wLjt0r5SKSUDjg4cv6Bjs0+dwZgVCM6bkb+V0O8lic0=;
 b=T9oMCzS3iEKJ/kenEfBZo/oetdBB8J/a0GGjwDnEzoDwouBqT4/90o/5Y0+oa5KFGxubkXxPQPUxTAd4U3x3+2tXmUARhrVHgiTDK4A1mjAabooWE5DoSm09ZbGlrS2cUOr05w+DypQK0SI2fdOKDcuWl29laXAcMeZtiSIEGTnl5j/1cPVBmUw62USJTj53J+SaVKD12toEagFwedBifGdXxrnpmxpKIYhMnPNt2SN+fFK1q3dts+/ZXecuugVaFD2kvJU4omutas7y5WUSkXRV+rdVcRYE7yFirteAwDWh2bfYFs0iv22V0fPFPphgfJ51cFAbzn3RBZ9FZVnddg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wLjt0r5SKSUDjg4cv6Bjs0+dwZgVCM6bkb+V0O8lic0=;
 b=Fo06Sz9cfjGQIglNGnXX+FVFKE9MA44hnnoyDYeN5M9D7MfTgq5OkPWA2uK5K5unzCtzNK9Ad8WILdxI4gqOKEfecnOAdRn4mqaeYyshCY/qSPoChDht5ApBvDfr2o+BbtyzziNLZEBPo9/cNJgWInf/X3PimG63Xfue8xFSmyg=
Received: from BY5PR10MB4290.namprd10.prod.outlook.com (2603:10b6:a03:203::15)
 by PH0PR10MB4422.namprd10.prod.outlook.com (2603:10b6:510:38::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.31; Tue, 27 May
 2025 21:26:50 +0000
Received: from BY5PR10MB4290.namprd10.prod.outlook.com
 ([fe80::8c24:37e7:b737:8ba5]) by BY5PR10MB4290.namprd10.prod.outlook.com
 ([fe80::8c24:37e7:b737:8ba5%6]) with mapi id 15.20.8746.035; Tue, 27 May 2025
 21:26:50 +0000
Message-ID: <2bbd09ca-5423-4cb3-8497-f3a45915f321@oracle.com>
Date: Tue, 27 May 2025 17:26:48 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/3] Expand the type of nfs_fattr->valid
To: Benjamin Coddington <bcodding@redhat.com>,
        Jeff Layton <jlayton@kernel.org>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
        linux-nfs@vger.kernel.org,
        Lance Shelton <lance.shelton@hammerspace.com>
References: <cover.1747318805.git.bcodding@redhat.com>
 <725abd9afbe268c50b99a1b2ded6c2339a5e79c0.1747318805.git.bcodding@redhat.com>
 <480b2ed5ded21d186f4b4e64a8aebc226d4c3468.camel@kernel.org>
 <98FC701F-40B8-4C5F-8B45-0ECE3F145C44@redhat.com>
Content-Language: en-US
From: Anna Schumaker <anna.schumaker@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <98FC701F-40B8-4C5F-8B45-0ECE3F145C44@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5PR02CA0001.namprd02.prod.outlook.com
 (2603:10b6:610:1ed::17) To BY5PR10MB4290.namprd10.prod.outlook.com
 (2603:10b6:a03:203::15)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4290:EE_|PH0PR10MB4422:EE_
X-MS-Office365-Filtering-Correlation-Id: dee920a9-9d6c-4130-ff6a-08dd9d65319f
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|10070799003|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?YTcxWXRoOTRkcUVmalNxa3gvdm5HbXhlaEM0NFo1S2prUFFVSFhMSFRwSitx?=
 =?utf-8?B?TnhpcUFtQ2FNZU8yWXdJVUIxSCtnbFdjWjFlek5IbWdQZUluWVlNeTEwTjBT?=
 =?utf-8?B?dHRqamd1cGZmci9GaVpESktEMUU3eDBCa2c0ZUhiYjdjQVBSSjhmazBrSzZw?=
 =?utf-8?B?TC8rTllGUXY0cS93Y0NpZW5TMWd5OE1LYUg5amNtVGJLaFFOVzNsaEk5a2sz?=
 =?utf-8?B?elR2eXJHb3VVRFhyeVJZWFVubGVSdU5KTlF1TmZxSmtrWFpDVm5XeTRya01O?=
 =?utf-8?B?b3hsOFdrdGI4cEhmektBRUM3LzdsQXhUcDBreXgxM25EWFNTZFZNTnhRajVF?=
 =?utf-8?B?LzFRUkI1NkQ2QnNuTjc2eFNpbFZRRmJoWVRMVXNtS2lxZUZMaS9rcUNKMUZt?=
 =?utf-8?B?Yk1hRWxGWFVVdmdUdDM4akJCT0JIZ1ZmR1lOMW4rSDlnWFE0NHB3UFpsL3hj?=
 =?utf-8?B?cmRWdTRBTFh6aVlBME5PNWQyaGYzL1g1N0V2UGYzVk94ZGhXY0N1MlRETEg2?=
 =?utf-8?B?Ym5JbGJzdGlVK3hKbzR4RzMvV2hkOWNCcnNiLzkxZmhCeTFTNVBZRXpCcml2?=
 =?utf-8?B?a3RiMGRUZ2M3S1loVGdBVmNGMlg1ekZOeCtHSDArV0JyMUZmZ3hwS3ZvNEdS?=
 =?utf-8?B?cDBXTHdieTA3ME9pWGc2SlhGRDhNQzBFSnY4VENwWlV4eU1GcEpzb2R3RFhU?=
 =?utf-8?B?TFJwNzRjT2loOGlYUlYvcy9BSGVyQ1ZTQ2NQNmNWYjYxMTlBeWtyalFhV1oz?=
 =?utf-8?B?dG9nZjRVcWtkWWFzMTIyMTJGTENwMFJJWDh6UVBMTVFNR2RNZTVyVkpIeFdv?=
 =?utf-8?B?RVc4WW5ZdWtlalJMNlV0Z0R0eG8wcWQ3K1hWY2gwMnJFV1dHTllYWUdiRWlT?=
 =?utf-8?B?VUpFenBGSkJWeE5jM0hGcDJuaU41ZmN1WGJ1NFlWMUlobmlFUDREVHNHNnhK?=
 =?utf-8?B?TEJST0tmU3ZFSkNRbTBuYlpUSUdrejhiSk01Q3Nkc2s3dXBSc3ovNGdOYUtY?=
 =?utf-8?B?N1U4TThBUnQ0UldiVFRxV2JmMHZHeUl5cHFEdUF3dGZlNnh4MElSTTk0aCtB?=
 =?utf-8?B?WG44L0dKL2U0S0ozL1NGV1hVZWZFcURXNGUrSHJ2UjltVXdweURFaThxREdu?=
 =?utf-8?B?RHY2SDRrSURQN2x1a2RzQStQSDFCa0Y4SmMwOXJTOXk1LzFVZTBkVS9WQ003?=
 =?utf-8?B?VHgrdng1NUN3V0pjVStRSG9hSkVFcFpOdXEzeE1kMFVtbVEyblpBQzRvY2d0?=
 =?utf-8?B?bXN0cnh2Nm1nbkd2d1hXNFZScVpOY2RuSHpiVjRVbVJ4VzVGZVY3VTBDWHhB?=
 =?utf-8?B?ZEpEcThpNmVEb2twOVdmVk93bEdkT0JBbFRYNjZPYnZkQkE4bmowMTRzVEV1?=
 =?utf-8?B?LzVMd2JxSEJjNDFTUkQ0c212WDNqcThzYmJaeWRmdW9EUjYwbHdPQ2pHNDhP?=
 =?utf-8?B?MEk1WlgwdDlmMEs2SU42Sk9ETzNkQ2IvcFhRdTdRSVo3V0pYUVBuSkxRVDRU?=
 =?utf-8?B?REUxVjJORWpCUTM2R2ZzQTBlL3daQTVVNFRJSTJHWlUxZUEvWVQ3ckZ6SDlN?=
 =?utf-8?B?dm9ncTd5OXpnVXdkTWcrWWlnaWRMK2RrdXpSRkw2K0xDTStOSnZSZ2pDbzVm?=
 =?utf-8?B?cnMrK3phcStZR2dtV2YydWlMRFBIWDNzOWdNRUhKZ3UvUmZ5di9ydUcyWlN3?=
 =?utf-8?B?SWZyV2VEd29pWXZqNUo4WHBCNVQzbk5IQkRHZkdQTms0RFpHZnJDL293ZFpY?=
 =?utf-8?B?SFl0WkNXZVV1K200eS9lZlRnOGFVeFIydi9vWDI5WTdVNEFrdmJsNE9BT05r?=
 =?utf-8?B?bXArVkttUjZiR0pTOGZCZEZoRXRHYjNNdlRzcTdhSGgvOVNxOW5talJKWjVn?=
 =?utf-8?B?dS96cndCbjh2eDk3L3R4WjVESWtFTDUyRGxGTGNiVzJEQmNETTBOUzlEbWRs?=
 =?utf-8?Q?slucTan7wQg=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(10070799003)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?RGptcW5sV0dzVjBRYmlEL05PMjJya0JTT3Z2SXdsUDdMc2NvOU9KZGxvMVlm?=
 =?utf-8?B?b09mVkdkeWgwT3YydjVhcHdjYm1LRVRreHRNblFRcmFnMjlIQ1hnU29jRDJC?=
 =?utf-8?B?a0lmUnNRM1JEdTZFOVNESU45TnprbkpncmdHRFgvWW1qNjNiZDNFSjVKV2Z6?=
 =?utf-8?B?RUxEYndSSW0xa3NTb3hZdWEwcjdiZU81cFY5dDQyZ2RRRGRCYkcvOGQyZUoz?=
 =?utf-8?B?dEtvMDd4VDFKZjZ2bFNpbkdYNXUxb21Ka0hpVHRhdzkyb0ZyQVNhY1loVG1j?=
 =?utf-8?B?ZDhjN083MG8vRjdPSTZWTlEwUWNTdHBmOFZBMGR0MWRvemdwVENueGh1dnJH?=
 =?utf-8?B?U2VHVGswY3RETEVBK0RWQ1dQMEgxL2R1SnZHa3h5aWRKVlNXNGVvS0l0OFFh?=
 =?utf-8?B?bDZhY25ZdGZuYk5uWWFoZFBPdU5FZVQzYzhxK3dxQnRFUlBTK2JKY0dMSmVk?=
 =?utf-8?B?NEJFOXNRVEo2eEYrbTM2Q2FUS0I3Qks2OExIY0VXYytEVzRSSk93YUV0aWRz?=
 =?utf-8?B?NjFCdW9kYU4xdzFQUVZHdThLa2gvWVV5L1RpTDEzOXRURUQwK3RKWlpjVEhY?=
 =?utf-8?B?YjdrVVgxbUNvYStQd0JhOE11a3ZPWG5Wb1p1dThnQW81NGRJbkdDaVp0Q0Er?=
 =?utf-8?B?cVVscDd5TnZ4Q2xhS2ljS2NiL2tvZEFXTTdSc3hlU25RZlN6WlAvOXhGbk9V?=
 =?utf-8?B?RFFQUzlKSlBXMVNSMStiamswcU5KNk1LVG1LcDk5MWRDSEV2T2FNUnRZTnRh?=
 =?utf-8?B?SUJlUEFPeHNOb3RmNHI3R0hNY2F3U2s5OUVCaXJyRmdCelBMMFZVQ1V4V1ln?=
 =?utf-8?B?VENPa0I0WW1QMmE1WHdMK1BvUjhZUnhaNVpwS1g0S0hzR0hRYkVVdFppeWR6?=
 =?utf-8?B?SkxQcjNVQUczVFhqT2ZmbFNMQThFNmViWENDTmhtdVE5OFJ0ZWlyTnBucCtL?=
 =?utf-8?B?Zk1qcmxBVC94cVpZKy93aktRczAwVWszVmRlU25EemxJNVYrbUdvWjRsd2VV?=
 =?utf-8?B?T3JYV2ZpVnprVHFTVFlTcEN3MmxGT25qemtKVEg0cTIvQTVlL2taSFMxNjZW?=
 =?utf-8?B?ai9pSmZwMkVvODZ5bHB5SlQwSE93UXVaN2lPakRpbDBaV0pqUzVmc1NDWWxr?=
 =?utf-8?B?bXhrYXdBeDRRZUcvb0ZrdTNCaTNuY3VGYlQ3dWlKT1AzL2FWcUdUbG9GZUYw?=
 =?utf-8?B?N252cnFTaTh4aGdpdDhWNWZrYkZZWnB4V3VneVZ1Z3ZzQjFGTWI3TjBZa3Br?=
 =?utf-8?B?UHZhdFlyNUkwWVFueGNsWkZxYzZ4bklSVVJoZ2JWT0lrL3BlcmFweW5SZFlz?=
 =?utf-8?B?UnpTSlJwWE9scGtQRmVFWXh2YlhpTmQ1SERWZTB0OGlZYWVjcmZ6VG1McTRR?=
 =?utf-8?B?cHdGdTRueGczb1Zub1FSdmtpemtJazZqSTBFSEFzb3d2SEU2TXhMQTBhbkVs?=
 =?utf-8?B?aDJGamhRMi9nWlhNUU9lRWxCbTBid1RVd2RWV0RYaFcxWGtPd3crVStiMmJn?=
 =?utf-8?B?SHJJSmJNczlkKzZpS3R4S2tYNVNDUjN6MVFQUzh5d0twWnNCMllLY1hiQWxQ?=
 =?utf-8?B?dHpGeWN2TXVIR2RyU01IVVVhKzRQelZsdVd5OXF2TmtnUURGUVF0VXZxSE9M?=
 =?utf-8?B?WnUxcE45ZElhKzk0WGlhWlZ4YXdWcDFRWG9adTE2Zy84a3Yza25GR1NNZjVQ?=
 =?utf-8?B?cXlYV2ZxQ2JYS3pmTVpUcFAyK0JYRE9sR1QrSk9MaThrQUNPdGdQSmU4cTIz?=
 =?utf-8?B?Q3pJWVNDR3V4b3lWQTZ4ei9hSWUzZkVaVXhmRlRzYkxJQzdIU2dTOHMyRTU5?=
 =?utf-8?B?NVBjcUtGL1dCZHRPNUhaeW9hQjVlOVZhUytsK25OaU5mU2hPWVF6TGJGOEkr?=
 =?utf-8?B?SWpqRnVkSFdBWktUbTlKc3dNS0xnVGlob3pRZTFRNVRGaW9yMStYeUFMUjZu?=
 =?utf-8?B?UGpWUEswWGZZUzNFelZYcWNKWm1PcGxEYTdSeGFpNE9kSCsvRjVVVWc2M3Zm?=
 =?utf-8?B?OHA4K0VtZUxvREQ3ZHJZNG1pY2dQa2R1U2VSMDI5YldwaGp2UmRRWStsTlJa?=
 =?utf-8?B?ZlF4VnducEt4VXUwR0pJR01tSEsyN0o1N2NvSlV6V1J5cDFxNlhQS1JiYUtT?=
 =?utf-8?B?NmVBSkR4cG1zVEZNU2JDZElCTmxzUXpvTU8xekpLZ1dZenFMdXlUS3hKOFBQ?=
 =?utf-8?B?N1dHRE1mU0hqZEp3Z05HT2p5eGE1bHpsWTg1cUVaM3c4aHVLVXF2Zm8vUG1U?=
 =?utf-8?B?a0JNRlZTRFNOMzVrNHRMdzUya1hBPT0=?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	TGJnI6YPhk5nrbj0ZuG20wbep5d6ffYZvmMDlvxc3PmCqpObcoNBXsfw4nE7kYdzOyVsbThO47qRhwwmf2xKmmQ+9bk6KgNYqFeS514E9q+Dn/yGqs+MinIIOVrrB4YO2d/euzmRJ9jBX/Jofe5G267X39NgR85kgsBckj3fMz6/ehnzmPbR8Lq9Uec6XoYuHIl08FEtTEGE72OETQ+yqvWAup5vaKgjz05klnUdyxKPilrx0HMXbYev1rznLo3hzqDBIxZ5z7O4IAVLpUB34a4hQdgPGS5fNTEHY8lltQYtba7Ujv7MKdfztobJ13mcD1sLaCngbTeLTLZjXX8I2usrZjuZ9Z3ovjyU4rzjmZLiUFXOP2DHEscj9tRFieizFQRfbDH+WIiRh5yONtQXcTQjGF2Fe72afchQ0pVk5ELc7NO+rVmWWoaojhW76pwFp/MOjwaQzlJqLLgEXAhjrgykw6FeTmaKJvoH1harb89VAHm6MmpceNhZR6OM3WFU85uQv+e5nllHYYT9Z7arW5EjAZuKyX027QJICX6Qc4kQaw7v0rOwCllpgAtdx4CjMYJlBHqF7SFPQi3mjkvXXSxglXfsI3eMuxCQtvbuiJs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dee920a9-9d6c-4130-ff6a-08dd9d65319f
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2025 21:26:50.8464
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AvVDtkh9ziiTtiOsiFfuObWI6lvHfQWjbGKh92i4r1uejvIoUywTw3cgw5YBl+0YMjnAeISDkHQotVFCXDk0jv6AU4/NoTe0c93qx5bJol4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4422
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-27_10,2025-05-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 mlxlogscore=999
 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2505270181
X-Proofpoint-ORIG-GUID: RNpMO7_xc9Oin8X9xQbR7sZkuJwGMCVl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI3MDE4MSBTYWx0ZWRfXym2luq3YgNOa Gz92igm5wY+5CyvBX4aBrJS7zPr5dVPbLskVx63bTVlPQwkFTq0r/ZSZeeakeHk8TM74cm7Ep4F pGfP8UXPSwR5dozGS3Urim0Gj/rK76bizgkOKIYyMd0SFQWeA4zbKE//8t2h8x1ZehlZLm/GlQZ
 W77QbkByPb9jg9eIJ8253sWShjY609IpNRPSzT/u5V8pea3fxgYsXWpWV3l1jCRzuBQpmR1P/FX +dlm0xEkVFah/uQgf1WcWYHBRsGPpZ0EcgiV6t74oJVkbNofVGvCj/8dDhKcgqbEBpYF/xHZZu2 b957KcNz2vYGen5oc8rud/EF7WvzFtCetkQxIv4WKSkZpA4hfE4oQV73kbqsrhgojmXGWAw7kxq
 72ovaWDhDo/BSvPiPlUA2b/ucIwTJA3nVgnKIOPHpeSNKqWLoYu4Yn/LG1SQH+CgRK49s8SO
X-Authority-Analysis: v=2.4 cv=UZNRSLSN c=1 sm=1 tr=0 ts=68362e3a b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=VZJtwKKvAAAA:8 a=SEtKQCMJAAAA:8 a=20KFwNOVAAAA:8 a=Kot2JkMYtvJRiaWoYEIA:9 a=QEXdDO2ut3YA:10 a=vzdIw8kzLcqZOxdJCU6L:22 a=kyTSok1ft720jgMXX5-3:22
 cc=ntf awl=host:14714
X-Proofpoint-GUID: RNpMO7_xc9Oin8X9xQbR7sZkuJwGMCVl

Hi Ben,

On 5/16/25 11:31 AM, Benjamin Coddington wrote:
> On 16 May 2025, at 11:05, Jeff Layton wrote:
> 
>> On Thu, 2025-05-15 at 10:40 -0400, Benjamin Coddington wrote:
>>> From: Trond Myklebust <trond.myklebust@primarydata.com>
>>>
>>> We need to be able to track more than 32 attributes per inode.
>>>
>>> Signed-off-by: Trond Myklebust <trond.myklebust@primarydata.com>
>>> Signed-off-by: Lance Shelton <lance.shelton@hammerspace.com>
>>> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
>>> Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
>>> ---
>>>  fs/nfs/inode.c            |  5 ++--
>>>  include/linux/nfs_fs_sb.h |  2 +-
>>>  include/linux/nfs_xdr.h   | 54 +++++++++++++++++++--------------------
>>>  3 files changed, 31 insertions(+), 30 deletions(-)
>>>
>>> diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
>>> index 1aa67fca69b2..d4e449fa076e 100644
>>> --- a/fs/nfs/inode.c
>>> +++ b/fs/nfs/inode.c
>>> @@ -2164,10 +2164,11 @@ static int nfs_update_inode(struct inode *inode, struct nfs_fattr *fattr)
>>>  	bool attr_changed = false;
>>>  	bool have_delegation;
>>>
>>> -	dfprintk(VFS, "NFS: %s(%s/%lu fh_crc=0x%08x ct=%d info=0x%x)\n",
>>> +	dfprintk(VFS, "NFS: %s(%s/%lu fh_crc=0x%08x ct=%d info=0x%lx)\n",
>>>  			__func__, inode->i_sb->s_id, inode->i_ino,
>>>  			nfs_display_fhandle_hash(NFS_FH(inode)),
>>> -			atomic_read(&inode->i_count), fattr->valid);
>>> +			atomic_read(&inode->i_count),
>>> +			(unsigned long)fattr->valid);
>>
>> Why the cast? You could just set the format to %llx and pass fattr-
>>> valid as-is?
> 
> Yes of course, the cast will be removed.

I'm not seeing any objections to adding btime. I was wondering if you're planning
a v2 of these patches, or should I fix up the casting in my tree?

Anna

> 
> Ben
> 


