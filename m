Return-Path: <linux-nfs+bounces-16573-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E1089C70BD7
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Nov 2025 20:11:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5D12434379C
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Nov 2025 19:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48B88364E96;
	Wed, 19 Nov 2025 19:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gA+8/z59";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="z6TCp2vF"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51532F6919
	for <linux-nfs@vger.kernel.org>; Wed, 19 Nov 2025 19:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763579500; cv=fail; b=MaRDVvubqF2YcY1k4C3W1eScEvLc8Vi9lmuamhQUEH3hGRYAZXZCMtWPxLUrnYKlDz8yr6yCKjRSS9J6ha1OK0Ww/Va3IH4+LJupgr8CjhlIO+BKQYSiHIiMkB5xLvrpZKkI56XwrAh26Gmd/aYPRZ6fp8OGhCc9DGf2B+Xz2QY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763579500; c=relaxed/simple;
	bh=KlfmOo4P3WUCFXGp5HqX1lo7gfMd2aFYRtt7lb31hzc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DF3cSLKMnKg0kU6wvej85o/EnDzKict5lPyGkDL7IwHQRusVQZGtGZoG/hVZQSRWveG86adIYLOd3LBzLxtmZtGPFq3cKZQh8UwtrVH0Ay/57rjwkc/aE3qNzmtdCAP2l/khY7mu3SEqx/PybQAdnAkedu4x+GRlGxz8nrDh750=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gA+8/z59; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=z6TCp2vF; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AJJ7MaU029947;
	Wed, 19 Nov 2025 19:11:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=hbSbT/mBrYePfrmEQtbWFphgqgnr5BoyMTbbZMVf9uU=; b=
	gA+8/z59MAPb8lXn4kLp7tZ2zB5erOoDjXIHkb4K+tmO4Nfc0WgCfHCtzXMWRsW8
	oLWjoiLkQ1gAikogGe9tSB1PIvpX9VxmxwdwL4MssuXw2/kR/9WUoQNFUoGoYOhR
	c5QIr4D0oQTEtkWybNWp1XzmRxjVDemogXZhA5EbIza+JmFtNb0CG94aYrjNLbfG
	iCYtivyswGisFBcMjhXEeOZP7Kg2d8ylf8aJ9WoCJnYLP/gmBiYycHWhvaj3Kblc
	retvCC6zFlEUpVFDxMuuZKyIjVc47Qyu5khxf+VtPHAqHMSvvwrUsFAtWqkgSQJq
	Gawsi+0Q4RsCBizl+OIHRQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aejbuqkfc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Nov 2025 19:11:13 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AJILcmS035934;
	Wed, 19 Nov 2025 19:11:12 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013002.outbound.protection.outlook.com [40.93.201.2])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4aefyna2ea-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Nov 2025 19:11:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cAV56JSyNnF3JSsE2E/sEdfZH1D0twvDar8lyKhsFX+spGSU5y3fmOWRXRLYeIG9CXfm7oumKXvo4HaBlYXI+kxPRSHtNk+CBu86ao+QqUCU5u+h/YJQDZ0aa8ORPjGjU06wwek5Hvk32qO7BrahnfuXbVFefzp/3yEedY+gHV7IHTR7+5ZX713Zt1s0so+yaPYvLsy2DFtPfvtQh6zMm65/+uUhbek2GeNz2wN90Bxqy1CFKSqWfBCxvpQsFO/wYOeB57q3+OVIQ/qsPAXnMB5Aed1kIN0GsvWSm0/16QNrK0hI3/NDTLWxl5YwkFPJ4uPy2fiBccTjTEgy1Tk73Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hbSbT/mBrYePfrmEQtbWFphgqgnr5BoyMTbbZMVf9uU=;
 b=mBX85smHGbd1/Rrz/Ck03BydrY7xdR43Zos/PpwbCDGAT8rew63TNSn2wG+0bXlNbmGMHG4inOjD7sjQuRBI8foqvYQxhfyamgBSFCqKqzP6J0kNGvC2+YalvGzfQFE1b5vU0WKlQ+cJRR9eIiDOg6pbyeycfLJsbBpUjfwVIAFNSppQ4bb80wK7+R5TH28zMUBT+zMuK5k7Bn0Eo6Dsa6Ws/LrgkVmXIIfKuMwdXhb28nyLjAG5MMhxb+deMWPXGJ+Ag3xSSKQB8zpvaNwzSENGpaI/lSCLaaizAlrRoUS3t1OGrXjqu0/21EdmgPkPmSHKD2TghxVMVyakI99K/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hbSbT/mBrYePfrmEQtbWFphgqgnr5BoyMTbbZMVf9uU=;
 b=z6TCp2vFNDOtGdTDa4XkotGvmYrGQ8pxje9muHguNGZ8LmVbmPg7iVgGXerXpxci7BV0NbkGQfS7HF+aUZecTg53zhKeGTFbm/ChevV44qSVYKEBVks6MMeoWJqwjc9EDJRz1QAvE7KYBNXq4g1IMlcBYtK7A66QOXfNbsQRBm0=
Received: from DS7PR10MB5134.namprd10.prod.outlook.com (2603:10b6:5:3a1::23)
 by CH3PR10MB7762.namprd10.prod.outlook.com (2603:10b6:610:1ae::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 19:11:08 +0000
Received: from DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::39b2:9b47:123b:fc63]) by DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::39b2:9b47:123b:fc63%4]) with mapi id 15.20.9343.009; Wed, 19 Nov 2025
 19:11:08 +0000
Message-ID: <ff63feb5-9442-47b9-9ddc-4e3e2847e352@oracle.com>
Date: Wed, 19 Nov 2025 14:11:06 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 05/11] nfsd: drop explicit tests for special stateids
 which would be invalid.
To: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org
References: <20251119033204.360415-1-neilb@ownmail.net>
 <20251119033204.360415-6-neilb@ownmail.net>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20251119033204.360415-6-neilb@ownmail.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR04CA0040.namprd04.prod.outlook.com
 (2603:10b6:610:77::15) To DS7PR10MB5134.namprd10.prod.outlook.com
 (2603:10b6:5:3a1::23)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5134:EE_|CH3PR10MB7762:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c3d9b3d-fa21-4289-2ee5-08de279f64c6
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?VzhmYWJsc3J3di9ZTW9tL2NscVJrMjVTVXEvRGNiRnJ1OHJKcTFJTjNMYysx?=
 =?utf-8?B?UG1rQTRwYmJCanRKNkZsUkoreUdocjIrV1E1MDJpQjhXVWREdXdvT1p0V0g4?=
 =?utf-8?B?MVN0ZURJMjdTOWtrUHZHR1hJTXFBanYvM3l1QnNHQU43RmNpMWFUd2NJQ1hs?=
 =?utf-8?B?YWw4M04zNk1INU5zRWd6RWgyYWF6ZEoyQTQ3SU85ZDg3MmdrZlVEWDRPelI5?=
 =?utf-8?B?MnlibExJdWpsN1BoOEdQN3d2QmtLRTdBenFmV2JrQzgweEp6NGgwMXBXZWF3?=
 =?utf-8?B?ajA2dHFjbUczL0UvV1cwalgxNFdvVDlXOHk3Q3JpUjlQNW5Fd3BxaTNCOTVj?=
 =?utf-8?B?dStKcktxaGtudTlEakU1ZHdHTjVhdVRwOGxySk1DeGVPTGlsbVBxdzhvR2xG?=
 =?utf-8?B?LzRVVml3dGZhNFNocTdad09TREtoVG5BSmtYOXlqMDV0U2VMTGpSSVM0Tlhi?=
 =?utf-8?B?cklwemdTdXNreDlmNXlzY01oY2FVdGQza01jalVxTHFQbG95WDBPWEdwVDM4?=
 =?utf-8?B?YmdiblZkYVN5SjhYLzBZRFNhRTlQbVZHWlR0RkY0SUFzMFJiZVFDNENzZ2Rw?=
 =?utf-8?B?MCs3V3JZU29GdjFpRG81L3MxcDRVb2w5cGVrTmpjSG5FTmEyTVRJQjNhemFX?=
 =?utf-8?B?NVRLTjlOQ1orR2d3dStMNWZWMmdyeFFrNUdwUUoyeVFRdmxQWWNGTGt0SGlm?=
 =?utf-8?B?NEVlbU14dW0yU2szNkxXR1lLbC9CWWVpS1hqRkora21RckJwc3VMNWo1dFVk?=
 =?utf-8?B?ZVEyaFphcm9VOVJobTd1NDFLSEhoMFVDa2hEeDhxNHJjbzFzWHk3Wm5GYm9O?=
 =?utf-8?B?dGZFdVZZeUxDVHMzL1VaazFrK2YwckxGWm9tY0dnRXpWbm8vODJBWEFRY2NY?=
 =?utf-8?B?NEtCTWtLLy8reDVJMnlFQllGd2FUb0JMaGlWa2xEcHBCRkpTKzcvMjNDaWtN?=
 =?utf-8?B?NjVDbkdGOW1INFpGQVRRenBBZmNTZG4wa0RBZ0Rkbk1vRk5wZlkwZGhiWG9C?=
 =?utf-8?B?STFqSXlMTHVHd0pzMVczdjZhODVMV2plK1piZ3daSkxyQ21Sd2I2eVQrV25C?=
 =?utf-8?B?TFFDSFRCNFJ1c0F0d1JxVktLWFB0d0JYZDJVVkdiMzVOdUtRWWhBTDE2RDVk?=
 =?utf-8?B?V0ZKeTF4emZhUm1HRTlXVXdmYkhqdzdZQ0lHRGp6SUx0cW1rOVZOeTdxRDNz?=
 =?utf-8?B?RFhEV2Iyb25JM0ZSY2hZT0EyU2V4L3NIQVZSMkt1U1VSWTh5VS9TRkgzR0lH?=
 =?utf-8?B?M3FSb1VZdHJZbmNUMVI5cWcydzl4Q3NOajRjZFJEa1FSdnVLV2FGcSt2dWd0?=
 =?utf-8?B?WitoaUdRSWMxVS9GTEpBdFBsdHBLeExnOHB0MTZKcHBSbU0wbFFtUTkrYVJu?=
 =?utf-8?B?bjVESmYrUVZ1MUhTaTBpNWdwcWN2akgvVUtPeDZ6QitTbFNwUDZrL3FkM0wx?=
 =?utf-8?B?L1JsZytBY0ZlS2VoRll5SDBLbVFkL20rZnd5am9ZNHdVZFh1OGpUS0VCWGpj?=
 =?utf-8?B?aVBSa2Z3eE12MURuaWJHVU9ML2tBazdLakQ0UHdtODltczJMSllOWVFlTElq?=
 =?utf-8?B?cFNraEo5TFBxVkhMN3NQMUM3ZktRVGdUbVUxbk84VDN4Z2RiNk54UnREOE5y?=
 =?utf-8?B?bzBidFJCaDk3anZjbmwxVXE3aTIxelRVUnFRVS9IQ1Jadi9WbWowZW5IdDlq?=
 =?utf-8?B?ME0vVDlUamtEbWFZZ3hReTA4SzZFdmM4dmF6S1dDLzJCR2hsZkdubitrejh4?=
 =?utf-8?B?b0tCMks0U2hrOUpSTlBibUYxYVhkOEFOOWlFdDFyTEdyRXE4VWw2Z2JFQS9Y?=
 =?utf-8?B?b0JMMldwZklJWmx2UEFJbUxHcmJHMUJnRnQwSU9BSG92amphcTlpc09WZGt3?=
 =?utf-8?B?YU5OZmIxNDJvVDVyM3l1MDJPc29QR0pDRzEvaWx3ZlA0MWRlajZCUHo2OWJh?=
 =?utf-8?Q?Jg/SEJX/JhQP2Li7BHKDzi866wBtV8zC?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5134.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?MDFUZzhQaDZHYmNRVm1vbzJrT2F5bkpVMHBUb3lZRTZVVDVYenlFL0RiOCsx?=
 =?utf-8?B?blAzMDY3aldoUktKOEk4enY4SzNYdHhXMlJnZHBkZnk1eDU0eTgrbXdEcWxH?=
 =?utf-8?B?L005NVUxZHJqbXRjZGZ4WEV4YU5aZEFPL2VwelhQRlppaUdrL2o2VTFPVzNm?=
 =?utf-8?B?dEJNbjgvWUtEazhxZEtkUkJNV1dnR25MU3l1anV1S0Y5YVhYcWpyTEhuVE0x?=
 =?utf-8?B?dEMrM3V6OWFFNE9pTlp4MmUzcmlxK3cvYThYekJQL0NTYUZZdnhOVUZUcWVN?=
 =?utf-8?B?SWc3L2lrdmVpaDdkWTNtV0poSXlNSTdNN3d1THFGUWh2TXVCdDBFdS9oajFN?=
 =?utf-8?B?VzNYekpjamYyVFVIT0dvdFlKMWljOWZFVUZ4Vm11ZVBjR1NOZWVQMm52Q0Q3?=
 =?utf-8?B?QUpLTFZiVjdOZmpWZWI4c1ZyV0tnMi8xN1lXU0JxQXcydUZsY1I1MnZBcG1P?=
 =?utf-8?B?b1dBTHI4MzFBOUtheXZRU2dFaWhmQm9kaDJHcmZKQmlUTWIweFJDck5jNTl4?=
 =?utf-8?B?NmJPK2VvODlhQmhVUmRoV3h1emtkZWZSUWJjNkp1S2ZKMmVIbU1DOE40QXQw?=
 =?utf-8?B?RDN2c0UzdUlKVkc0WmtuRUJCKytJTEUwcVI0dFUvbHNiSlVjdHlJTS85SFAx?=
 =?utf-8?B?RFc5SDNicWZXakZWMVc4UW1YRS9Kd0JrTGtJSzZ3T1E1S3hYaHY3aVpESzdH?=
 =?utf-8?B?ZzBaYlB3WUd2UzQrcHN3MUt4Yyszbkk2ek1OQnd1RHRsRWVxYnYrcUNLRlZa?=
 =?utf-8?B?T0N5eE05UHg2ZVI0VXNrME9hZEdueGIxelBJdG42WXZhbUQ5dmI4RXNCQVZY?=
 =?utf-8?B?VWhPWW1vZEcrSWNibE5RYTIzV1doQzcxUGJZeFdSZVlDYkpHdGJzQkpNUlJ0?=
 =?utf-8?B?OGlGMVE0ODRjRkRCazlGNFd6Q0wyZ3RCZU9kWU5Palg4dFNNS0R3YWk1cEJM?=
 =?utf-8?B?ajJuQm9sY0hVbklLMjd1d3F1UnljdWw0Z1hYVWQrUVRaTXBHWWhyZ2thbWky?=
 =?utf-8?B?TEhUTWNhQVl1M1lhV05PcERlaEdmSGtsdjExU0Zwd0w0akpmWElpS2FySTFy?=
 =?utf-8?B?Q0o3MVNaa0dNSkxUc1kvS2xTUHA5STA1UHZnbGRDV05ITTJSb1h0OXZUNVk3?=
 =?utf-8?B?MVJQUHBrcHhqMHVOazdOazE3YWgveWdMY3B5ckVlbEZlaEdEb3lNSEp6S3VE?=
 =?utf-8?B?d3hLUm1wYVZDMFdnSFgxcXZqemt1Q05LV0lyRzYzUkxWOUFpNjhic1kxUEhH?=
 =?utf-8?B?RDFGTXdqOWQ2ZEVlUmp6ei9OTkdXblZuMGNLcnB0dUk1d0dybmk5cm82dklp?=
 =?utf-8?B?QURFejR2clNrYm1xbCtqam9aTjdDMkNKN2dEUTFNQXhUTFZFSmJvVzRXd00y?=
 =?utf-8?B?cnMvTkx5WXB3cm9HVXlTUlBMUHVvTTZUKzY0QkkxZ1RqOFFMNmpXZ2pwelpw?=
 =?utf-8?B?WWtzczc4ckhUWW91Vmswb29scWFZYjMwNkphVVo2M0E4OER1UmdScWJ2YmZQ?=
 =?utf-8?B?ZDdNZkVGVlZUV3d6Sy85SFdJejVNYzQ4N1BpL0RwWjdBdWR3S3Z4WGROdGxp?=
 =?utf-8?B?bjYxTFIrd3B3YkZoRGdXb0RsbzVDUTZrY2tSTnFseTVEak5WeWM2VEt1Rkd4?=
 =?utf-8?B?ejVyVXRVRDVWZU9iRDZaNURVczJpUVdtUUpqdkNwWHVQY3VSSnFsQTFjR0Yy?=
 =?utf-8?B?eFRWM3ZhVkJMMXVSanJYazdXV21qY3laTFlwcDBNOXJmd29hRU0xRnkrTmV2?=
 =?utf-8?B?VzFad1grUkZ2K2xlMEh5Z1RDSTV1RzhENFc4R1JDNWI5M3I1NFVFZ2tQaHNx?=
 =?utf-8?B?UldXdjRsVXdYeVgwc0xWRm0wbnQvN0xraFU3UDZLanIyRWcvdjV0YkdKaE1x?=
 =?utf-8?B?NGVJQkRJUlArcnhCTUZIbUFITjhFc0hHZmZVQ3V1UmhXa2Y1TzVqRUdrWUV1?=
 =?utf-8?B?VUpxckh4U3YxMWlxc2xIVWpPaWcxQ2QzdWJTOEFiTzdWYVpGdURzdjRpN0c2?=
 =?utf-8?B?Sm5UUXRkcnV6L3FBWE10d3Z6Y2NlSVBWY0NVZ21NNVdkK1UxRFRaNndtSlIy?=
 =?utf-8?B?U0Z0Z29mZmhtNjRPMFBLa054YTJYbFo2Szl2SEp5RkM3SHhEYzBKdW91YVU4?=
 =?utf-8?B?eTZ5d01MTGEyb2d1ditPY29qM1J2RzJ6VjB4SnNaYmppNzdadktPZFZ1ZzBB?=
 =?utf-8?B?ZHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	yu177jzMIUvhHAphtaaB/RmsbNctShEDseSDbzYEsZnUN7AwI0/aOo0nwkMpoFO9NxEhj+ozIGZxXfgxGIdRmO9RMj+6GGvGbpBHPa1Gx8SdsUT0pe5dBr65TW+aV9XrjugxrdRb6Z6/wBhiQ85vi3wfWPFPYMMDGaOQg3fGiBm2z3sBEXsF6XDK5IAZNsBsJkfj8mG5Lezr/eHBJcRYeNxQWavWMBQb/TXX/zSYfgoAOrmlAhk7CwiaI072CyZ2+VOepB5BCj0S2WeDGmTcfx0aV5WC6YOkg4RKjnHWTOmSYpIltCgd40oYIFzDBbqX88Uhq7y0XRIO1HdgD28QYldglGa5RovtZdkMr7i36t2gXDcCpNPd6YakijhF3t/nMlGLMh2ponWmtoFIkp6Xs+pPXeI9opfkGzbb216r1xuZJulGEPs6ih0X0YSWPkeNUwseMGjzb4YzyUzzc5p8yB8cnOrMBZIeiwDmWznBMbF+xUd4vua0mrqWeIqvdDNCE8/lz9lOSLV3/+w4kyFSQFZVW5WcM+RbrANNlZm926VxsowgoNEerx7JQt/ks55lwC76IvELA+M6N09tW6v9hFb62/njL6nxE3DaQdzeQe8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c3d9b3d-fa21-4289-2ee5-08de279f64c6
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5134.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 19:11:07.9017
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CDvj3Ig6cnOMjpc1cpZ7udBgy8vI+XIYtXDoueMpltuSbvTGDHygOVA+i5ylZ/CZwn2omRoK2AvoI1ZBoekqXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7762
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-19_05,2025-11-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 bulkscore=0
 mlxlogscore=982 phishscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511190150
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMiBTYWx0ZWRfX3kDxIlThBhgt
 LDLaa8LBTM94f9aM8lnCKx630IPVoR6C+JGqPMuPZWk32Z/kJUOPntkK3l08Nfanaau0mdEX0Qs
 ACqRTk96ofQeCoT2zHaaUc8d5odN1t7OasteiB3wb5oUtPiU29CvO0N0clXWdqplehkqH1tAjZw
 jFvGkXvZsh+lD5FVrN8qJ+jKQMMi2kisj8vFJM7SjRieMAMCl45U6xqm4MCGMTWB1KDydQVKdIL
 RjiBankgBERBnpSLVzPXGXjaa7LLiJUzbrKEgwoBerVU5/kNmeoPsjss4zAf0kW964NeXDhngip
 mqda5yBzOhIHWJAAJFkRlMDNMz/hQOMl771RvdNB6ORdmioxUxgLLR91qW5fgnKon6LX42BbxRH
 VHV4Wf94FeocyMah32map5mxcqM7k/rOAF4/Hhapqul/MGWF1fE=
X-Proofpoint-GUID: fESVldiP-86772qS5TSHbLHk4-WENGr6
X-Proofpoint-ORIG-GUID: fESVldiP-86772qS5TSHbLHk4-WENGr6
X-Authority-Analysis: v=2.4 cv=Rdydyltv c=1 sm=1 tr=0 ts=691e1652 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=mC81rkR8tQZh7ZdYLxoA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12098

On 11/18/25 10:28 PM, NeilBrown wrote:
> From: NeilBrown <neil@brown.name>
> 
> In two places nfsd has code to test for special stateids and to report
> nfserr_bad_stateid if they are found.
> One is for handling TEST_STATEID ops which always forbid these stateids,
> and one is for all other places that a stateid is used, and the code is
> *after* any checks for special stateids which might be permitted.
> 
> These tests add no value.  In each case there is a subsequent lookup for
> the stateid which will return the same error code if the stateid is not
> found, and special stateids never will be found.
> 
> Special stateids have a si.opaque.so_id which is either 0 or UINT_MAX.
> Stateids stored in the idr only have so_id ranging from 1 or INT_MAX.
> So there is no possibility of a special stateid being found.
> 
> Having the explicit test optimises the unexpected case where a special
> stateid is incorrectly given, and adds unnecessary comparisons to the
> common case of a non-special stateid being given.
> 
> In nfsd4_lookup_stateid(), simply removing the test would mean that
> a special stateid could result in the incorrect nfserr_stale_stateid
> error, as the validity of so_clid is checked before so_id.  So we
> add extra checks to only return nfserr_stale_stateid if the stateid
> looks like it might have been locally generated - so_id not
> all zeroes or all ones.
> 
> Signed-off-by: NeilBrown <neil@brown.name>
> ---
>  fs/nfsd/nfs4state.c | 33 ++++++++++++++++++++++++---------
>  1 file changed, 24 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 35004568d43e..ea931e606f40 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -74,6 +74,23 @@ static const stateid_t close_stateid = {
>  	.si_generation = 0xffffffffU,
>  };
>  
> +/*
> + * In NFSv4.0 there is a case were we should return NFS4ERR_STALE_STATEID

s/were/where

Nit: Throughout, when referring to the implementation, instead of "we" I
like "NFSD" a little better. Using "we" to refer to developers or the
community interest is OK.


> + * if the stateid looks like one we might have created previously, and
> + * NFS4ERR_BAD_STATEID if it looks like it was never valid.
> + * There is not a lot of redundancy in the stateid that can be used to make
> + * this distinction, but it would be useful to differentiate special
> + * stateids from locally generated stateid.
> + * Special stateids have si.opaque.so_id being either all zeros or all 1s,
> + * so 0 or (u32)-1. Locally generated stateids have si.opaque.so_id as
> + * a number from 1 to INT_MAX (as generated by idr_alloc_cyclic()).
> + * We can test for the later range with some simple arithmetic.
> + */
> +static inline bool stateid_well_formed(stateid_t *stid)
> +{
> +	return (stid->si_opaque.so_id - 1) < INT_MAX;
> +}
> +
>  static u64 current_sessionid = 1;
>  
>  #define ZERO_STATEID(stateid) (!memcmp((stateid), &zero_stateid, sizeof(stateid_t)))
> @@ -7129,9 +7146,6 @@ static __be32 nfsd4_validate_stateid(struct nfs4_client *cl, stateid_t *stateid)
>  	struct nfs4_stid *s;
>  	__be32 status = nfserr_bad_stateid;
>  
> -	if (ZERO_STATEID(stateid) || ONE_STATEID(stateid) ||
> -		CLOSE_STATEID(stateid))
> -		return status;
>  	spin_lock(&cl->cl_lock);
>  	s = find_stateid_locked(cl, stateid);
>  	if (!s)
> @@ -7186,14 +7200,15 @@ nfsd4_lookup_stateid(struct nfsd4_compound_state *cstate,
>  
>  	statusmask |= SC_STATUS_ADMIN_REVOKED | SC_STATUS_FREEABLE;
>  
> -	if (ZERO_STATEID(stateid) || ONE_STATEID(stateid) ||
> -		CLOSE_STATEID(stateid))
> -		return nfserr_bad_stateid;
>  	status = set_client(&stateid->si_opaque.so_clid, cstate, nn);
>  	if (status == nfserr_stale_clientid) {
> -		if (cstate->session)
> -			return nfserr_bad_stateid;
> -		return nfserr_stale_stateid;
> +		if (!cstate->session && stateid_well_formed(stateid))
> +			/*
> +			 * Might be from earlier instance - v4.0 likes
> +			 * to know
> +			 */
> +			return nfserr_stale_stateid;
> +		return nfserr_bad_stateid;
>  	}
>  	if (status)
>  		return status;


-- 
Chuck Lever

