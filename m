Return-Path: <linux-nfs+bounces-2060-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 960DD861405
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Feb 2024 15:33:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D58C1F21CE2
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Feb 2024 14:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65F3D4A2F;
	Fri, 23 Feb 2024 14:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ICTO96At";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="KQl1jT3E"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858144687;
	Fri, 23 Feb 2024 14:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708698824; cv=fail; b=lyCI+1cl/puKJbGrJTaJTbcIOJE1v+aPitRLVI85M0Hq1Ty1qgQTSYYk3THMYM+IggUl/MKLi8cg8ONuB6cBD9IB8CLG/h4hbsGqn1ioyuGZI5MuYyCYsWeo2hrGzDP0V1sDXVHV7iTCtSy5irN3T/94fXZCce0oSloZjRAyEsY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708698824; c=relaxed/simple;
	bh=UoK45S9ybtceE9DBqVC3D+w0x5rsS4GEBACLqVwGW0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ns7Zo/R8FlXRSd77ZJuTv8xc2TXg3pAlJscdgNeEE8+dLdOBLN06HWweLTMnGc8Z8LXWV9FhyArAFeqzXdVvQm9xdu8vOH+iyLa+ZCX6RuVhWXqRf/SjPNOxt0ip7Z9WvDc6PQKdD6QfYIhEBxqWhMvGY4wK7nKVJjQXhE2HDDo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ICTO96At; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=KQl1jT3E; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41NEKMpD006098;
	Fri, 23 Feb 2024 14:33:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-11-20;
 bh=ZzpXcKNyrg4Q/XwOspjss2VsmmFhxVs9X/o6Svf0rQQ=;
 b=ICTO96AtspCDk8R1Xn85C1M7V6HPKgBcynMcySocH0EFxLVyT5YarsygYxKFATR6O7M1
 2IN0sUO6qxjVKosAfh789yh+J9JKYzxNNU5uqBThbUQHe9ITGt4etlirLVcp/q0wGttP
 vVBnxVRsUWgS2uWTMyQnRYKRaYB8htJ/cIkc/6tqmHodZv9bHxlNb9326reITkl+uZMd
 h0Ce3KiWBC5whfq9Ojxz8lZlfiX39lakSvIe+GRcxAsJayrAm+jIAj8dCfQ5TKfTBWHD
 9ZfIHTNME1sZdrdXxCyZSANQlF+Ez47EWcGMig8HP5vpcQaQTNjjgMFELCLn+pvJBFxX 7A== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wamdu7nvr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Feb 2024 14:33:29 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41NE5n8B027619;
	Fri, 23 Feb 2024 14:33:29 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wak8c79xf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Feb 2024 14:33:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mDn/hOQluEYbKvUelDIuXgDyIUVQ/Jz2dbg8SsCCicgn7Q454nvGILb4rDpEuFm+X4Gto/2RYm3mu9lF9UjwBMnRHRvREmW8wnmDjHB/3Y30o/STNb4DrGCMKtqkHdJpMX+u1RTNuSUMajzIr1gNq2hNZE8csbgbWsoi7V1Ct5rMLIhW2FminQzKEVlSekIwcxpDXSlfy2gPiXnodiP1coh2+blkaFZCspZACE/HkyZoK7FLK3mtiPmDXNrgAIcEJivsPsNPfGIWuG4MYult7GMY9b7vjs67LmbnWtDyI9Sb1GVou2tt7fByFAP4+IUpQT2UjbbS5nYZRh/tpUmQQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZzpXcKNyrg4Q/XwOspjss2VsmmFhxVs9X/o6Svf0rQQ=;
 b=O4KBjeGUCFYu0AmhWQzskj4uLVWU6msLqIZIx+k0yQycb8Lowl/GBR2B5JrhiPBxuOnxxx+WYsjNkeS+8jcXM3EFVZUWaKxxXDQpXvQwLLVG+wi/HljhzYlKJz3AvQ1uU0skCVCtzuMevzuac/H32M7t1M6nv+nlOGrXjT3gve4Q+H6DGGBn1Xx1KqkvVFxhe47w11IW2JBnMtIzuISqGueP3WpehSsgavpqRU+I+JKDxZc/7+sd/vMiNW8UJUS+1jeTnL6XTmJxTWecDPk2UBvopoTay+JcJxKbGYFL7SA2RkS4YHMF5WXzW+7j+XcALcaI7zKQhHrb8284OVWBvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZzpXcKNyrg4Q/XwOspjss2VsmmFhxVs9X/o6Svf0rQQ=;
 b=KQl1jT3EirNnRLH/iKl4HhK6Yvyvl6WN1BPG315v3KbNbDgM+KWM9D+2pUzom7hgtDptrhs0jdBO90QJ5B4DK3H7WrJ9iRydI6EbXflZQRIdQmirWRKUCgh83Io9rHLenKbpKFkytu5AL83ho8XgP5FGyuHFq2QKPSYTjGxXya8=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MW4PR10MB6347.namprd10.prod.outlook.com (2603:10b6:303:1eb::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.24; Fri, 23 Feb
 2024 14:33:26 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b%4]) with mapi id 15.20.7316.018; Fri, 23 Feb 2024
 14:33:26 +0000
Date: Fri, 23 Feb 2024 09:33:22 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: Christian Theune <ct@flyingcircus.io>
Cc: linux-nfs@vger.kernel.org, jlayton@kernel.org,
        linux-kernel@vger.kernel.org,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        trondmy@hammerspace.com, anna@kernel.org
Subject: Re: nfs4_schedule_state_manager stuck in tight loop
Message-ID: <ZdisssP88_9o0BXn@manet.1015granger.net>
References: <8B04DA70-ABEF-44A4-BBA7-60968E6CFA10@flyingcircus.io>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8B04DA70-ABEF-44A4-BBA7-60968E6CFA10@flyingcircus.io>
X-ClientProxiedBy: CH2PR18CA0054.namprd18.prod.outlook.com
 (2603:10b6:610:55::34) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|MW4PR10MB6347:EE_
X-MS-Office365-Filtering-Correlation-Id: 02285ac9-0c87-4628-42c7-08dc347c64fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	rUYYg+cbUTpOQA+tfxNKC3zWSWBc2pHXuessHwvEkml+GI8XHT6G4ITKkVz2RWwBZKKpJxK/llQOsVKpjlNnItSW1o+7wWreNKIZUZrjLMxwXd6rfuF7Hit5sf8KBG9rUeyqHC1esEl6xWpVxHFlpGOECnkH3WEz/qtbeli17anKAjRMv34MvaWvVTt4ftBKXYW0p+2Kbbkjt321eRtC3GH6MOgFeyHrsI2wIPu8E/79nG3JArek3nYMpzdRgTbUD2KsBMzWCp8BG1WcfHNoGGJGVmSOAnvGrUDCyhaESAfvDst+Hy/YKOZXRChBBsSdp90aS4hPjbzMAuc30vUDUN0DWX3zuTs2ZH/bOcsL6KjGNHrcBfy0/GLMRY/zDwx0fA4AmHvcd5HZWXokJqZu41IUkrbOB4lPxWSwJOTGV42u/lagW5TohcK190GCcaAf0DTyTDh5n8sp+wqg9uV4vD5PSF81vbRA4TV0hdzvKYQZlJ6hpp4UFTZ7Sem4CDqIFKqqOlC2nsIPx8TGlcBoaQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WDlZMjlsZFhRYWRBeVk3OFVBdnFFaWFoS1lKcklpQldHcVAxTkUrVVltREpw?=
 =?utf-8?B?YTlFUklCak9EQi9FMnE3SkQ2a2RVV3FpcmxPcTFsQ0k4a2JwT29id2hRcmFB?=
 =?utf-8?B?Q0FFdk42Q1BSNGROalNkZ3NKWExOSzFQVTg2Mmt0R0RNdjVUYnFIT3lsOG1V?=
 =?utf-8?B?TDNubkhCNCtZc2N6WUk3RXI0Vks4V1NvcTgvbkZ0eFVKQlpIcG9mWFcrKy94?=
 =?utf-8?B?M25FMFR2NXAvNWZWTTF0R3BUZDBaNWZlakRjY3c5d21HZFYyZVRiVHJWMW82?=
 =?utf-8?B?OFdQRk9pRnFlREpmMzNtaG1BN01jNFdvUXFXYkNDdG44OVc1OUpIV1pSRVF6?=
 =?utf-8?B?aVRMOWVEeUlKWTkvK1d3cDBhaTcwTGZuS0NTVDFURjdadTJqTW0vYjZ1YkhU?=
 =?utf-8?B?R0VVcHg2TnZFeTl4Q3FIK0xobzBIcUNmdmRJUFl3YnlpNHNiakczZ1crZEo5?=
 =?utf-8?B?TjBCa1M3VThjYmJiZ1NrZzdpaC93TEhCS0JsUlVlVTIzZW1EckozWUFFM0l5?=
 =?utf-8?B?UXdSRTN4OUJhVUJRUFJqS3RHK0o3bVBRWkNoZCtzTnFESnJrU1JRaThDMFhm?=
 =?utf-8?B?V055VHZPRzNIZ1BsZWl2ekl4NlhCcU5hcndrL2kweEN4NFpmR1R3a094Zlh4?=
 =?utf-8?B?UW8wY1N4b3ZVYnNNVE9QaUFVb0lQUTBQZ25MRDZxUUVmN04wM24raklHWmRC?=
 =?utf-8?B?UjA0R0lHZDRxRDdwVW5nQkV6UjVId0dEaGpmRHAxdnh0a0pXYnJINlJXTElq?=
 =?utf-8?B?S0FnK1NMem9XSis1UWY0RjQyR0VBODFoK3V2NUlNNUFMdWgzdnFmbENsVzd5?=
 =?utf-8?B?VUJSc2FiTFlJdmtlWXJyUXN4dU5DazdkN3RjMFUxZmZiZW5TNnpaV1psMjJW?=
 =?utf-8?B?djNVdHdLaTZqRTVYYlRMM3huUGZVWTZGUmhzZ3dZL0Ryc1hXd0piZUJLYlJO?=
 =?utf-8?B?WE41dUFmWTVKRFlGdC9McSttVmtSZU51UjhQWmJtekdoSVBLZXJIM3VlQzhp?=
 =?utf-8?B?T2xHUmszcEQxWGVHSEU0d01tREJKTWZ4SWVmdng4NUpZSXZjSVJleTBYaXFW?=
 =?utf-8?B?Tm5HRWhEaVUrYitwQ09qQ1NwVExIbWhveGdSVlpmTUJ0YVhTTXBueklSYkFJ?=
 =?utf-8?B?ZUhrcStvZkszK1VQSmliTG5HSGpGSFBxdFdRTTU5Tk9kTHRUS3I2elFKVFdX?=
 =?utf-8?B?SlZ0c1JHY3p4MFVSZEszNUZ0UVFKQlRsdmFVUjJJUUVkbFlVL3lXbDlQMW1r?=
 =?utf-8?B?SThhbk1wK1g3V2N1RGxFUGFaRnZwU2VRbU9qd2crazRlV0VScllhUEdYLzh5?=
 =?utf-8?B?NDRvdTdxTWY5NUZpcHk4ME8rbDZUcGxhUmljNTVCMUl1YnFWYmNzby8vcVJQ?=
 =?utf-8?B?bGhVWThLaGdLWFgvSjhuT1ZYSUc3QU04WFBpTGxZcXlRTGs5WFlJb040dFRw?=
 =?utf-8?B?eUhYczFQMWlVRGZKMm1FempHRVFBaWpPMFlZNGxrdXBkR1ZGaFlCZHlYS1dB?=
 =?utf-8?B?a3FOWi9CZGVuaC9WN3Q4Z0R5RHkwZ3diOHNHcGhHMFR6NDNadklIdmsvMWFY?=
 =?utf-8?B?b3REQ3REYm4rM1RRcTBWaWprdUZJeDhuaVYzM3F2dTUyK1hWM1VINVRyV095?=
 =?utf-8?B?UVR5UG10STJJR1FtbkNYT2MxaTBYRHN6a2VQTGduOVYwZDdXQ1dZb2FuTSsw?=
 =?utf-8?B?bTdQZEd0STBQYy9CODMyaU16cGZqUUJ5M3hGOU8yeGR5UkhxOVVoWUViSEgy?=
 =?utf-8?B?aHIzc0lIaGpUb0dVWFd6QWRtTmZ3UVU3bGRiNHhGeU81RzlUQUdBYU8zRW40?=
 =?utf-8?B?bzIrYUU5U0FJYUJkRzh5TWt1R2RsQVZ1VHhWODA0QU5scGN0R09IU3dvbm40?=
 =?utf-8?B?T3p0dDlrTnB4eEpDYXNURFhDbjZ3aUR0eCt5ZjBGVGR3MVBPTWNFYitJK1Nw?=
 =?utf-8?B?QXh5ZTh5WHEyNWVqWXJEbmlheVhQK3UyeGM5U3Qwdm5ENlgxMVh5RUNveThq?=
 =?utf-8?B?WDhKT2dXcFhMQ3pVK2JQVGt3eDlKNDlRditlRVRzTFp4OG5OMDFVK2IvNFVQ?=
 =?utf-8?B?Z3Viak9PUGxyM1ByQktwZ0N4OGgvZHEwS0pEOWVNb0pEUG9lVHM3bFZRNUgr?=
 =?utf-8?B?K0hHWG1JUE5BRHQzdEgrcm9RZjJ2L3M4U1JNU3FaVjRnNEZNSVdGZ1pDSFE2?=
 =?utf-8?B?YXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	B6sKt1bqBR7I6JRdDrHojMeBOLUC4FW19jijjbJaMqMA3uu2vhJPb3RxFI4Rea9zMolD2VJNhJy+KsyaBU6eeoev9X6LWI57r6cQDwBR05jdIjX3XPOLYqoVBOKtZTcMoNyRYet/FGgtaT6zqb+l4ugHWIov713fu3rm5fOK+mxSPPTQP+pNEIzpFmDMS3tx9rDqK6DyGur2BbyD5e7sLL4hN8P03Hklmterj+dHuBxsfJWOo6BunMrk5nq0pwHEHX9JUjl0fxj16Utm6yBcxa/z5Ou6StFOSJNnu4R4mVUOSqfCkONYFA7ty/qbDSRuNQSCIX6XURyaWru9/EuBR+g5zuS812L8AIqIlvBZ/NybYoTMNeU/PkFFL0P4KA0vhacHqIGVOpjlwPoanPsNyVpjT9I9rpyFh9OuB2fmK4QqhYnaB5oM+RVIg8H1ZpKXvssR9/qcaDSZRUsSJScCNxHoLXWtVnNGTIUnVJo8Ro0AwECRBvlcmU8XqYqNZh1AeA9RVRObuWWjSyr9gYT1KdAA/PlGM3Lt5bs69yzI4aWuoMv/C5wABaPPqQY5g2DnsoG8ogwq+7AWH9eoGtGWvHENLPXqDyk6EIcWi1RApLI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02285ac9-0c87-4628-42c7-08dc347c64fa
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 14:33:25.7752
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JNJzBw9X2h5YN/E/7YJfJeDHXmYKYLxO5fMKTOo/oJooidkwqhZSKo9F0Lj1FzgyRfG0MzBhA/aGowohOuAdZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6347
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_15,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402230106
X-Proofpoint-GUID: jiKPwA5ZVC1d3-lP_1_CYleA4S-AAVQH
X-Proofpoint-ORIG-GUID: jiKPwA5ZVC1d3-lP_1_CYleA4S-AAVQH

On Fri, Feb 23, 2024 at 02:59:49PM +0100, Christian Theune wrote:
> Hi,
> 
> unfortunately I’m a bit light on details, but willing to provide better diagnostics as this moves along.
> 
> We’ve had two instances of NFS clients getting stuck with a kernel thread spinning around `nfs4_schedule_state_manager` AFAICT:
> 
> The first instance of this was last September on a Qemu VM running a 6.1.45 guest:
> 
> root 315344 44.5 0.0 0 0 ? D Sep05 781:38 \_ [172.22.56.83-manager]
> 
> It happened a second time in last December on another VM that was likely running 5.15.139. (We downgraded our fleet due to other stability issues from 6.1 to 5.15 in between those two incidents.)
> 
> My colleagues told me that no issues were visible in the logs at that time, the systems were generally usable but interacting with anything on NFS was (obviously) stuck. So apparently no (soft-) lock ups and no stalls were recorded, but I’ll ask my colleagues to either alert me or provide all of the logging they can get the next time this happens.
> 
> Cheers,
> Christian
> 
> PS: I’ve also recorded this in https://bugzilla.kernel.org/show_bug.cgi?id=217877 but switching to mail-based workflow now.

nfs4_schedule_state_manager() is part of the Linux NFS client, so
Cc'ing the client maintainers.

-- 
Chuck Lever

