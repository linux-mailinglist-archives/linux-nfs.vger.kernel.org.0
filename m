Return-Path: <linux-nfs+bounces-4221-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E70912C7E
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Jun 2024 19:39:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AC4F1C23ACB
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Jun 2024 17:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D48FE15EFB3;
	Fri, 21 Jun 2024 17:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ihVuDxBX";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ep8FwRPI"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0597E1C14
	for <linux-nfs@vger.kernel.org>; Fri, 21 Jun 2024 17:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718991571; cv=fail; b=m3K4mmSAyxFodQTiRzhQos1z3puQSvj9ie12ujOHBcHu/gER/z56Lc0t7tdbc0wza2A8Y/aGTRfxT5LaCe520Zs0/B45nUbzePxQADZAlyzKwZOrZvrkNQ26DEK/0ITW+FfEfo90f1l3cB+UiiI2aYIvcbPFpcBNp/RIiumNI8M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718991571; c=relaxed/simple;
	bh=sKdmpJohYwZXfQog4a9bKVTUl/muCg8HpIRTjkrLtAU=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gJygNMLj09bEQ+wu+QX99sdqrNY1udPaktJDwcYT0fOyPdw4EgjZ4gVODGAO2mJE0UsmB/DQYpfqIsna2rPDRQRDYicKkuvuTbelYsPT+CLRNxbeR4Zmd9ocA8D0bnt+cBXBKF3zwHrEPeiDBt+v8J0xvQt0pOXO/W/DcALNFIs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ihVuDxBX; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ep8FwRPI; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45LEXQwB007623;
	Fri, 21 Jun 2024 17:39:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:cc:subject:to:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=WGxlo7DxfohJcOZpHeInyyWU7YgdPNdvJKxjQ+jEHSE=; b=
	ihVuDxBXoIP4y08YpAOQ9CJY9JPdOips1AuRQKwfQOxZIi0tRjE1YRG9OlU4Zv3i
	OioP2P+QnLd0yRs9qL0hZ+5SmS3hDk/VerH+joQepFJn5XhL6MbXuceTsuHPeX1R
	gYdjkrW48SgOiiEby+vyerEqkJytdcohENDD30OCImgXL9t+EsAR4IAdq/zipTeG
	FBdV6vUreysSQ2GJYMWGj4Vd3MfjrXGzLZb+SJRYfQ45rwbOkiqOzVuCxuLoOy7G
	qW1nPVg9fqpb5muRIXNeI/Sb+/o0YYqlpdDCqsV9pOfuvhTtmrooCwAUFPtxqfEY
	kJV5/q5gu0+wEnNBs3lkoA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yvrkd276c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Jun 2024 17:39:23 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45LHV3B6012800;
	Fri, 21 Jun 2024 17:39:23 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3yvrn4y7e8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Jun 2024 17:39:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RssEvXN5wMXSz2OxDiAWlMBdCjQlYJLiieheGWMXti0e/j5skJ1Jrzwcl0ztK4c3ZXqgj5mBHjWrI1SVAMYyBc2sGkrrCPJd7nEnz2yWzoFOBR4CdCiqG4aOjunqcmiOsCjUH0pgmQXGY1IFWGEpyvNap9J38NcqxH79t3Q5cgoI6cXdIdWeqYV4Cvfy4uxEQCpC+N7zAEB1DGFtSI7wfC0vXc45wp9ukUFftetVL/Me85zBn+JsT77ArK3OoxLEOpJkaHliGIyz5pBXuVJPTcpkFjWIifdpeLHXPc0qXx8B6kGsr0QY3Aag6k6wUbghB+3UaDJG21E3W/0qutfr+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WGxlo7DxfohJcOZpHeInyyWU7YgdPNdvJKxjQ+jEHSE=;
 b=G+WPvyMZ1Y/8EoJNZ3IQ+Z/2ztke3NPUjHJGWwcWry2R7eU+vX+xvDyU0eV46hSLRQfEeXwVtGud533Zfl+T52WO1y2AArNr0KgtJh11a7kUK0uwXDO/L5DxsymiDMwgsOJhI1kfxqQa4CGWa0kObWsKepBTfxEDww29AaRMgQepa0wxOI40RMPaUqPgvN+F1i0K3B9OvExmE9/g341vnKaV1vPEYuA3rYJq47pKbH7+PgtopKV+ODmsK+FrLPtIZnolz/+G9dtmH7Zd7NxKRsuzDpKg2gevIAnEJ6nz2tXzmMxbIaF96+1mf7cSu04iVmg4hSKsACbfN89c8HqRKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WGxlo7DxfohJcOZpHeInyyWU7YgdPNdvJKxjQ+jEHSE=;
 b=ep8FwRPIqmTHm1erZYEWO3jb8DUb1+sKLXaV6Hm2nEKcfdUKpkS/LVpToHMc3DnYMhL8SrQ4iEzrttNZkwfuEzEDKPqTB5zFu85+rj4BuvbcRvlqfX1kdDXNlt0ZtzD8uxUcp7TWVSbguzD/HAqvOafI10yiOTwGbIyU9xNSWJI=
Received: from BN0PR10MB5143.namprd10.prod.outlook.com (2603:10b6:408:12c::7)
 by CY5PR10MB6021.namprd10.prod.outlook.com (2603:10b6:930:3f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Fri, 21 Jun
 2024 17:39:20 +0000
Received: from BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::783:503f:ea07:74c7]) by BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::783:503f:ea07:74c7%4]) with mapi id 15.20.7698.020; Fri, 21 Jun 2024
 17:39:20 +0000
Message-ID: <2f5cb9b7-3d8e-4ec6-a357-557c484431c4@oracle.com>
Date: Fri, 21 Jun 2024 18:39:14 +0100
User-Agent: Thunderbird Daily
Cc: Calum Mackay <calum.mackay@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>
Subject: Re: ktls-utils: question about certificate verification
To: Olga Kornievskaia <aglo@umich.edu>
References: <d489e2d7-d4ed-424b-8994-6abf36a01e06@oracle.com>
 <CAN-5tyFQpEdSnco8SZWY_nsZVdYhAg+x_EAMmbWW5uYutyDA9g@mail.gmail.com>
Content-Language: en-GB
From: Calum Mackay <calum.mackay@oracle.com>
Autocrypt: addr=calum.mackay@oracle.com; keydata=
 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
 smRifw1wGg==
Organization: Oracle
In-Reply-To: <CAN-5tyFQpEdSnco8SZWY_nsZVdYhAg+x_EAMmbWW5uYutyDA9g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0150.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:188::11) To BN0PR10MB5143.namprd10.prod.outlook.com
 (2603:10b6:408:12c::7)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5143:EE_|CY5PR10MB6021:EE_
X-MS-Office365-Filtering-Correlation-Id: f0eb41b3-1183-4533-8972-08dc921914d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|1800799021;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?bHQzTWIzVTZtb1JpWFdBUXV2TlEwU2FFYjhOUERvR0lzNWdNTUtDNGZNQngr?=
 =?utf-8?B?cG5LaFI5N3pEeVo3U3UwQnNTWkhzR2g0R3pEWjU2UVRUakFhWjhHMWNhZzRt?=
 =?utf-8?B?ZGd1OW5Ea3JJazY3dWRDTlB3cXZPcDZremdicER2WjlmWVhsNFpKSU03aWhz?=
 =?utf-8?B?a3VKd3RBY3A1RWtxUmxYU1N6bk5lWS9QakRZSFVxWnE2bzlXSTdZUUxQVHVl?=
 =?utf-8?B?MGl0VzgyN2VSMzNLeXZpSXhOM3owTzhRVTJlSDZvbVZXVlJlRGs1aXdVazEy?=
 =?utf-8?B?VllQc01QL2xtZzByS2RuZmRFLytzOVNvaWRvaE8ybVJMS0hhbkFaTmQyNzk1?=
 =?utf-8?B?bUFRVS9YMTFZTGw0N2VtRUhCV2EreGNFMExocGEwanFrTm03elNkQkNKQ1lP?=
 =?utf-8?B?V0dpcHM4NlRWNi9pRWpycGs3b0RsZ29GeGQ3Q2tQTmJLeGl6Uk1wcDN6RnFv?=
 =?utf-8?B?VnRSaTIzbTFHaWlQRE9TQnJXSnhzMHkrTWg2M2tMazZiU2h0SHJucC96K0FC?=
 =?utf-8?B?dVl1QUpwWFNERXFzZjRxbCtRM1o3dlYwSmJwWDJlUjAxd3I1NjFVN1FmMTJI?=
 =?utf-8?B?TDFCQlArUDh4NFE2aGIrdmd4NjV2SzRpMUhEVEg5L2l1aWdHdFJqMHVOZHdN?=
 =?utf-8?B?bTU4YU1wZHJ0RVIwV2R0dVl2VFVqNnEzZXUxU3NTUStVeHN6WlhGWGEwWFFi?=
 =?utf-8?B?Nm9OL1FVUFdFSWkwcGhwRzE3cjB4cTJCVXFqbEY0ZUlpTEplTFhHV3VuUzZn?=
 =?utf-8?B?RmVrUGFHczVOYWtIMklrajZSc3dKeVpXakhBYkI0MzA4bWttWlhwc1JnY1dX?=
 =?utf-8?B?NE9LUllaQlE2OGlzTG9NZFlWbmdhVUg0MEJuYmhKZENPUHdCcng3eEk4UzE2?=
 =?utf-8?B?NWJlWTNPNWE4RFY2U01CS1BvZEM4WHhoYTJEeDZCOWNweWpBK29GSnhRR04z?=
 =?utf-8?B?Y2hNbEczc3ZuNVJ6bVM3VFlEYVd2cWxiUXRaL3Bsa2YrTm5oMXVuZUN4V25C?=
 =?utf-8?B?ZjROaVBmRVVYcVBIdzBET1llUjg0S2l2ckNVaThWdHNleThWVlV3TGNNcHJ0?=
 =?utf-8?B?M1NXMzFoQnVNZFZKQVdEditPUXJySWtHL1RyUzIzZFc4cmx4dFpGYXkrMHVt?=
 =?utf-8?B?c0thZ3oxY0pLSGNXN2RqcXBFTXgzUDA0czVXcjFzcllMZDV1V0FJakROK0JT?=
 =?utf-8?B?ZFZWSnF2S2x4RHVxYU50djU2blpyNkhqTUlPVEVwK3RvVnFVSmlzZjhlUHpX?=
 =?utf-8?B?dmZmUEx5VmVRUXhzM2hIR1VHR205TTE0eVdHNEM2dCtmbXQ2bGlSbGpqelk3?=
 =?utf-8?B?U3ZsaGZydWJQT3c4c0VDQmNFVHQreUVRenpuTU1sQjFKMTNsLzVHbVVkb2U5?=
 =?utf-8?B?TmY1ZDZxdmxNN2ZSbkkwMU93aXdzN2NuNFFNSEZ2QXZHak1RMEJmMmcyRkV6?=
 =?utf-8?B?NzlkbzNCeDVXS09ZbjhpYVZtVTZ3RE5zQ2JxT0dRMURSZkZ5Rm91M2ViN0Iy?=
 =?utf-8?B?d3VjaGJ6RnhlUWZ4Nk1RMjltTnZLWUYxT3RyVGZsNjVkMU96S1BsNDBrV01F?=
 =?utf-8?B?N2MyTmdFU3FFZnNhSjVwQ2NYWEhBcFA2RUxlb3F3SWlGNkcyT09LS0V4dWl1?=
 =?utf-8?B?Q1drQ244WmVqVVNBcHJiL2xXQ0tNeGpXVkYzS1ZWdEhYeGM0WEYrQ3g3V1k3?=
 =?utf-8?B?NVh6Sm9yM1lGcUd3VjdWK21keWF6eEJGL1lLWVBPUElLWHNLeFdhZDZIUkRV?=
 =?utf-8?Q?v7j95cjm8FZGWn8tttmM3mjt58JVpMv16U8Z73j?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5143.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?a1hoWm9DbU5aVTRHNDJVNURTMVZXU2QwNEVrUWUwdUxjcXRtbmJ2d3pSOHQw?=
 =?utf-8?B?V2pCYU1YZk52U1VwUzFKVlQzL0QyMDJjT0R4WWdESGl0TFJ4UFdwTjdXSW4r?=
 =?utf-8?B?QXFYcTlXbzdlOUlEczdKSUhSeW9uT0VQZHdzNmFqSzFLWHc0Qk5TWk9Ba1Ba?=
 =?utf-8?B?RnZ5OTNicnE4djVpdWlnYWtkUTFFa3JXL2NlQktvSnQyMDNEQUtPSTBUYlpm?=
 =?utf-8?B?anM1R2lUb2NESUFVay81K2Yzd0xGQTRKeVpaUjVBeVo3RlllUllFT0I2SS9U?=
 =?utf-8?B?ZmtOdmhzNUJDbWZSUlJGdjRvamJKZXdGZ0QybWFqa2tlUXVGTkFKYjgrSVly?=
 =?utf-8?B?THdDMDNJMVlsVld3b08wMGEzTTdwU0RSYkc4Zit5VVpBVG1nM3ZvU2pVTi9j?=
 =?utf-8?B?UzNMOXdXOElqVTg1dXdrQmlsbUNDdENlbmdzRXhRdzRkVW1HVEEwWnFyWW1L?=
 =?utf-8?B?dWd2ZWZYd2ZhVTFOSzNsSTVGWXZWN1hOd1IrS1lrRmhNM2FhRm9JazZYSURV?=
 =?utf-8?B?cUkrNmIxNnR4RldBUWhKSVZZWG00S1JmNjBiMXRtZ1FqUlZSZ2VldUdQd21K?=
 =?utf-8?B?TEdONklWU1VFQ1Zvdmx2UkRWTUtaMW1RaS9NTVhjOENqdjdkb3VVaGpkbnpn?=
 =?utf-8?B?bi9FOUhidEVpQkUwUE9tTXBLbzNzNkQwUVRBYzJrSGlId2k4WE0zYzFaQXZk?=
 =?utf-8?B?UWs3bFZNMkozSGlhb21Yek1EQllFc2xMRTFUb0xVclZuYTAvd1ZaOXAxU2JI?=
 =?utf-8?B?TVBXZ1l0YnI1bWsvV25vVjB4N0duMFI2MU1aWXBtL3oyY3hVS2NjU1ArZW9l?=
 =?utf-8?B?SFNQb3kreG9ReFErOXBUSVMvTVpjQzVLVVMwaXIvM2szd1RkWkppR1MxcDZN?=
 =?utf-8?B?Wnl6WmVBekU0dndBV29CU3h4aXk3YVdNUEsvN0tHdlljZU1pL2VVT0pWWTI3?=
 =?utf-8?B?L0lIMkRLeVR5NUtBSXZadEhZMDhobzl1VCtJVndEdzJSSWZFNWxOUURlM012?=
 =?utf-8?B?ZEw4THREdDdlbDg4T2IwKzNmVmtiaXorcStSNTdpNFZUVmQ4ekVpbFFKaW9Y?=
 =?utf-8?B?Tm1KMWVoK2xBOWJzbjNaemtLbFMxWjNXZHJwVlBjQitrbUV1UTcxVSswdjIy?=
 =?utf-8?B?c0RtcG1INHJ1d28zTW1IMEtadWEvRllPMXdkREg4S1hUZWRNa1h1QzM2NGV3?=
 =?utf-8?B?WHBlRmNGVjdwVFhNUlZoQUFPVkNIajZTL1FXUURLWHZWWlNBYi9OKy9JMTRi?=
 =?utf-8?B?ZU93Sk1RUzFwdjNydy9MTG5WNmlubTdWcTd6LzV5SnR4T0tqSi9ZYnV2UzVk?=
 =?utf-8?B?NGJkeWM2N3RxYXh4NzZkNVE2QytmSGduUVVKcmJPSG82MmRLbXpPcWxueE44?=
 =?utf-8?B?MVRxWHI0VDZldnBLR0VtcWZCNS9NYUVGZ0pLenlqK09UZFhSNFdmTTBNTXc0?=
 =?utf-8?B?dlRRNml6bngrcDcyUlp6MXphSUNuVjcxSlZTSCtYS3BzTkI5SHY3NmNSam5X?=
 =?utf-8?B?dzNIOW5OUXozd3RacThLSjNRRGtuRVdHUWVOYzZhVTkwUWdVTE9uUnhQbE9u?=
 =?utf-8?B?SEFuOFUySTNWN01mRExDQlpXYjlDb0hlenl0eWVPRzFqN2dZamJXaEhUM29k?=
 =?utf-8?B?dmR0ejZtRGlMbnhsc2VoSXVGQjhyRk12akRiSWUrcE9vY1lzTjduaVBURmxz?=
 =?utf-8?B?WDUwSytGZXBQK1NtTit5WTltaGxxTzI0Z0VWd1pNVUJENk1VWEU3M1hFbWQw?=
 =?utf-8?B?RER6Sm5UNnJaMGdhb1ptcEpGdHN6aTNweFNaNWJqNmY1Z095TFFYSXJRdHQr?=
 =?utf-8?B?SHQrWjhFN0xmRmk2dzNWRUUwNEZxd2ViM3VjZFpyT3VrVGtoRTVxNElJb1Az?=
 =?utf-8?B?cG5jNkljdkgrQkRTMnA2dldtYnlvMXdERWNIUUswQ3NNbDBualZYUHVIQzRO?=
 =?utf-8?B?RHZTQlhIUDlEVjFvTVVGeEN2eGczUXc4VVZuQjRIREptS2l1UGtvRFNsSkly?=
 =?utf-8?B?ZGowOVp0dEJRU25wbUlBZjRiZjhqYUZZVjgxTlAyRHBqMy9VRXkvcmNRQ2pJ?=
 =?utf-8?B?ZzgyZnh6eThEeUVIRHRoSGdWSzVMSS9RL05vYWVGdFM3czZENlhpR3MzZ2lR?=
 =?utf-8?B?bXQ3RktrT3FBWXFET0srRTQrRi85TVFac3B3TEwyTjJFYURWeFhMSU9xcDNh?=
 =?utf-8?B?T2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	4IB8lkrJBev5XLvE3qZlUUdFkym5Ipe19IcpNkzPJLRFMREWRyLkKkrvXp6HMld2BsbSMpHquORQtT5DhQ/Sm1PRJjGBjYl9aA3W/Q071sEJyIYQDfQjjSiYZsh+qe5kuU50zx6sJqPtxScnX3Cvf0ZmcW1tv/HyH5S9TmwfEcyPjY5vEqaHdvYJik90tpKsav8VxNyz40Y0FN734URzZQeoes32AI44VMeYtuts0J8JjdvlO7x/0Uz2+ysKDL+tAVWVvv12rQY14pyP2PHnefRUJrw1sHMyNCjbx4KGQtLTh6zwLAm41Fr//icdr7ByRkipQ1nBZrkW7ep9LOcZ88KXCUQDrxKJKO9Dvz+w2omOEwL8LjB5CrQV+QooJeWqmIqQjUVOSCMF8fJnPriSxXAQkrYn9+8ceCgatPgHAZqDwKAKGtaN8NWhxmZz2Td9w6WedRBzjPg/gSGQzinicx2tcdKIZQGNocYNku/SQnECdOBC8TZwxXmpoK+X+GWxvsZc/4HmqfKaiDPFliYLlOW/0qWzy9wckxM6rKnVDtWSWucvAuJGrsXEtYXcWdodmjgrpysAeqtc2Gvi/i/5wYZGPok58UV3TCvvPQfUH7M=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0eb41b3-1183-4533-8972-08dc921914d2
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5143.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 17:39:20.3110
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J1C7Vw1lkz45VHwVX5Kp0Vzf42wyYAeqC4xDADWVmxPOwdfX4A8QqC4fcY3Cvkh0wnyTMenfLl3jxwlt9jMG0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6021
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-21_09,2024-06-21_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=979
 suspectscore=0 spamscore=0 phishscore=0 adultscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2406210128
X-Proofpoint-GUID: SDAaGwySKM_SdORWGy5kIXUDZEZE17AD
X-Proofpoint-ORIG-GUID: SDAaGwySKM_SdORWGy5kIXUDZEZE17AD

On 21/06/2024 4:33 pm, Olga Kornievskaia wrote:
> Hi Calum,
> 
> My surprise was to find that having the DNS name in CN was not
> sufficient when a SAN (with IP) is present. Apparently it's the old
> way of automatically putting the DNS name in CN and these days it's
> preferred to have it in the SAN.
> 
> If the infrastructure doesn't require pnfs (ie mounting by IP) then it
> doesn't matter where the DNS name is put in the certificate whether it
> is in CN or the SAN. However, I found out that for pnfs server like
> ONTAP, the certificate must contain SAN with ipAddress and dnsName

Noted, thanks very much Olga, that's useful.

> extensions regardless of having DNS in CN. I have not tried doing
> wildcards (in SAN for the DNS name) but I assumed gnuTLS would accept
> them. I should try it.

Wildcard didn't seem to work for me in CN, but I may not have tried it 
in SAN; I'll do that too.

thanks again,
calum.


