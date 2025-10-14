Return-Path: <linux-nfs+bounces-15244-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89FB4BD9FC1
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Oct 2025 16:25:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43C3F541F84
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Oct 2025 14:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B3227B32B;
	Tue, 14 Oct 2025 14:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AtaoSly7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="AqOJMrhG"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A604628000B
	for <linux-nfs@vger.kernel.org>; Tue, 14 Oct 2025 14:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760451952; cv=fail; b=Lu1Bsy2IlHh3YLLiL2le4SFLvg43ovOgVRdoe+jn7ZI6xMxzvs5XrahjRZHqGgdT1qP61h0hn199QzHcwikpN4OAhFe7orl0GVRKUYkur3SmllcsvYdV9xlA8yoqNP+CHDj8ARVC76Shi+GeL+9bPcURh9aY0+NefbsG95Ev8ZA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760451952; c=relaxed/simple;
	bh=5VDpo3qWPpb/F5HywGTx4YauD9Mb1fH2ns2UpZPBp74=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QL+Y0wrIFnYWR7vvsrJcG2BVUFl2SZkruSwKEGA3gI+hGqc9XL7LZ2K+Z+HipzAGjYczl67Oi789dNKsbBOfCUL+awwihFuQD77vqZUJg4YZNqJF7kvGiZPy3eHvQ1NqCvIs4TjpfUT6UfYMo8LyK74KJTBCACw08opkQUSjAWY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AtaoSly7; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=AqOJMrhG; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59ECu79f032085;
	Tue, 14 Oct 2025 14:25:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=JDmBkm/x9P0+u6vT/x9elhWOwYyoYhwCJdD7v0/sN7E=; b=
	AtaoSly7VfWGdiUfl77xwxWeTcp1wU9zuODAsJVHf1CPfBYhTgz5rTn8e0FupEv2
	TxxnSfoXTFv5+QaXaL8fEKg/lYsZFw+j2Pvu2At8rXQMyT6x3HgfS/DZIemX8OQW
	GZOo0uJoZrWXLEen7m7tc1mR4usOoM7/iWbc/v0sWzoyxP//1g1dZ6YiixSUF6KX
	nht0YD/6WzcIGM6TN+4+HuhYyH5Cj3B/T/+We5oVPvqyorzMQtZdV6OizDFLWIxH
	PiDveID/F8Sqq2Nla0OhHyrLxu70kdeYH9TfM36RN9oKU8Oy4183LgpheVZIh/Sg
	UCxINOnbmtG8C93BO4850Q==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49qe59cgc2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Oct 2025 14:25:44 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59EDXOxd018002;
	Tue, 14 Oct 2025 14:25:43 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010070.outbound.protection.outlook.com [52.101.85.70])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49qdp8ry6k-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Oct 2025 14:25:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vW12bPywVjQ32HW7/gmoPfio2fFa9Ki/yiCIgR3qac/G+iu3M8O3mxF5+zfDg8vQMdQZmlmBr4kZmw9GApa0g7Gv9gaP09ItLX72izXUDKBYgu9WArSQyqfqBP/Eiuu4ZaC7QA2NzMcIMsyYKaZcwJdnWytT0ptQQeF9+Krk5oktUZI9mjROi/wZL3KWf5oaG7UH/fWxpX03e3SGgrfFof2IImZp+u+z1tEHN9jgpI6ZVYHHeLgVS737dRIYb6K6RMpjmibHZARxHI4xNnXJxUdmT2lbhYavfEAO200hzcdp2F0NVDB1FaZgQFeyXulilXbeEJ3EZcyftHcnmvDK9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JDmBkm/x9P0+u6vT/x9elhWOwYyoYhwCJdD7v0/sN7E=;
 b=WKa9h2e1Q/iC/RUU+evPpKU3oycjA1Nc7Ug350zWIVbVzEJSeyn++IDT+oTxAh69HVLdwk5594hxaa0ywEQucR5DV7p8kF1XJuS7DVuM2zixWfzvNIcoDFyDwnVmDf7jFjdwtrvgPazLlFVWTn27NAOWfpbdYMAS+E7ASVwCCWH7ZbgjWWGOFEnu0N8apdBseqyv5wQVi+0GLBlg95q5+YqSZLia3e8b7a6XodfhW8cPij5w4gVLYhLOg3GJ4aqYsHKOxe47sH6rHGXlv2/LYdKdWkRaOONt15Mr8CuxciA5S8iGUe6KKeQ6dsPGXlCYdSA5nsvKyAXV7+8Kl0ATUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JDmBkm/x9P0+u6vT/x9elhWOwYyoYhwCJdD7v0/sN7E=;
 b=AqOJMrhGHDOrqv/7C05MFXnZJFnV1N6UkmZYj05/Qmo8TEw8WNePYgJOgDkFZ//5sZR45OF7jyAbs59jcVw/Sdz+rzjWN1c/58y1LZm/2IFxe7PadW5Eo4CtWTSWiBPDtQsPRnuHCpM0XEx1JFnT2bSBhBxI9Q9vXztYGFCrDxw=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MN2PR10MB4317.namprd10.prod.outlook.com (2603:10b6:208:199::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Tue, 14 Oct
 2025 14:25:40 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.9228.009; Tue, 14 Oct 2025
 14:25:40 +0000
Message-ID: <b147f00f-c9f1-4e59-a735-afaf39c3f847@oracle.com>
Date: Tue, 14 Oct 2025 10:25:39 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] nfsd: stop pretending that we cache the SEQUENCE
 reply.
To: NeilBrown <neil@brown.name>
Cc: Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org,
        Jeff Layton <jlayton@kernel.org>
References: <20251014000544.1567520-1-neilb@ownmail.net>
 <20251014000544.1567520-3-neilb@ownmail.net>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20251014000544.1567520-3-neilb@ownmail.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5PR02CA0007.namprd02.prod.outlook.com
 (2603:10b6:610:1ed::29) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|MN2PR10MB4317:EE_
X-MS-Office365-Filtering-Correlation-Id: e22cef50-1ead-4584-ccab-08de0b2d8d59
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?OEhSMEZ3ZnptTDEwREVDaDNoZ3lhQkQyU3pGa2d4d3J2eFVnUWZoVHl4UlU1?=
 =?utf-8?B?UC9ORkIwRmtmSlU5b3N6cXJXTVJFYkRaNmJ5U0RYWUw1d2QyemJyT2pKQzZ0?=
 =?utf-8?B?MUtFSFpVVXBqWkxLbEh1bmJkc3RlaUFYT1dTbWl3R3FkNk5sa05oTEZHbnlP?=
 =?utf-8?B?bkEzM3JkWUhzaCtNdW9qMndoUlB0Tm50TTB5WFZHU2t5Z1VFZVhBYWNWT294?=
 =?utf-8?B?c1MraXozZDFtU1BnU09BM1pDb2lqcFVMendDNkRYWFVuSW51NERtYjBYa3Iz?=
 =?utf-8?B?MjZQcXBNdWh2NG84RDRsUnNUa09lZG81eFNVaVFNL3ZDN09QNHZqWkc1SFN0?=
 =?utf-8?B?TmpRcy92UUpPYVdMK2FTLyszazZlcTZncFJpdHRaVStBNmdUeHhBZzF1Vmcz?=
 =?utf-8?B?ak5FRm1wZ1RWdUtSUTRYWno1cHdOSTRESWlVR0ovVytUaXdmUU02bnBUdVIr?=
 =?utf-8?B?WnVaaUNLNlZhL3RjYmt3aGV6MTBIYi9vRWFaRnJmYzhUcEdURkltWERKSHZp?=
 =?utf-8?B?U21rZkJwT0FMSGRhOVBIbUhZQnFLYWtIeTFZNUxtNXYyK0ttT3lKL055Y1p5?=
 =?utf-8?B?Y1J1OWVqM25OdGdCWDVrU1VhTTZ3YURkYUpROS8yRjdYSk5Ta1dLckszZ3Fy?=
 =?utf-8?B?eG0vNFYvME0wRkpjUlRhbmIvRmZKSUNRMzdwQk42WUdUbm9hYVJuYWQvRGpp?=
 =?utf-8?B?T2NDZE9ZSnZuS3dDbWRYd29mdDRMWmg1V1JUS0lpM3VoTnYvNmNuTlE2RFJO?=
 =?utf-8?B?c0VVeFp3VkRnN3FJVHgzWXR3VXN5SE43clQ4RzR2R2s2N2UwZWxQdFgvZ1Fk?=
 =?utf-8?B?dnFoWWhBcmZwa2I5dDZIYk0rNFVBT0t6V2ozZUVCaHRvWHd1TmNPZytRa3pS?=
 =?utf-8?B?V0ltTyt1a2RRMWc5a0MwVU9ZWllDSFF0SU4wQkRKVzJJT2c2VUU4bG5VWnht?=
 =?utf-8?B?R08yM1lKTjdGR0RIdHBpOU5HUXVVTy9kNUM0WE5BeWNtU3R0d3JHblJzejlK?=
 =?utf-8?B?aWRVa2FVL3BrNUtCS09VLzQzWU52eGtLMzR1MEpoY0NuVm5vWHF0S21IYWpq?=
 =?utf-8?B?YXdKZGZ5NHZ3enQ0bDY2NXdqZ1VBMFQwNzQ5TzY0VVg3Z2tiN1FHUEkzVWly?=
 =?utf-8?B?TWRzU1Iwbm5IOXlENTVCQzBlOGZIU291ZnVndU5TM1hiZzlaVVJ2dHNPR2pJ?=
 =?utf-8?B?TkczaGFRdUpXOVVNZGFjTjVmTUpmem5YdEJWcFdacWwzeXQ5cjV4azUyZURV?=
 =?utf-8?B?LzdkV3dBVEJiYlcvWlRMaTRFbE9pK2RXazlVZnJpdlZzOXNCb0xGeDkzYk50?=
 =?utf-8?B?R3o0cktlTWxvMEtXaVVTdHhCdmNRNnFheEdLNDdubTFXVnJMT2RLOXdxYXBu?=
 =?utf-8?B?VXhxZ29lV0ZLeHhHWjdqa3NSUXltUGpoaHQ2eCtONUtXelVHWGF6cVV5ZEth?=
 =?utf-8?B?OGN1OTNtRktUYnk1RnZsVzhydzlkUTRpeEpWUEIzeFRoOTB6OE53dFZtQWxo?=
 =?utf-8?B?Q1Zzb1pubVRnODFYcGV6UXRXQ3dUS3k0ZGpPeVczdDNmUTFVdmE0SjNUL2NZ?=
 =?utf-8?B?MDBIZFZrZW04WkY2VHhNY1FoYWtCVHJLRHVaaE4zSnRzZ0Y3QXE3ZzVVeXdl?=
 =?utf-8?B?Yyt6M0VydnZhNVdWc2lxUmRTaC9Za2RWRExENVZoS1BtZGZYMGNPUDlJNkVa?=
 =?utf-8?B?cnJOK2puTWJwWkZCMnNkcUFyZFVkNnN1eFE1SFMrLzZaTnRkVUFyd0pmeWlP?=
 =?utf-8?B?ZGphaXZ4N0NYRUR0THlLWjlDU2o3dU1qa1M4aFlvT3FMNHdLeVJVZTc1Yy90?=
 =?utf-8?B?VHg3ZlRpSHJBMU1vNXlVclE0NERsTkFHWm55cmZ0R0Ira1h4QjBIOE1DQzRH?=
 =?utf-8?B?Q0JxNnpRV3gzb2ZBMm4veTczU0RMTlhzazJpQVFGeXA1VC96TmljcElLazRE?=
 =?utf-8?Q?ITgplvdv1Sj+50ZRD+0gcBiC8WKnFgKw?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?Y3VPWU1wVnRoNGVuVHIzY1FjNkJwV082bWFsYSt5bnhPMWhjNDhiVlBsMmZr?=
 =?utf-8?B?cTVOU2ZwOGR4L0JaVXo5OHVGVjBNUTFWczFYSVZBVjdKYWJBOXZPSUEwQjVt?=
 =?utf-8?B?MUQ4MThtUkJHZkxIV0hVdmtHbDI1aENEWlVFNTh0TmR3aUpjVnRhNTVsWnJV?=
 =?utf-8?B?QkxUaHFNa2phaE5qTzgweHRsTWpFSXQza2dwTm5wMm5VMm1qKzE3TmpYTFdn?=
 =?utf-8?B?NnR6bENkSTBuYk5VOThCKzNPbmk2LzRTYVM0SWNlaCtKa0dKbzFMYndCZTZN?=
 =?utf-8?B?anlFYnZUYklIYlI1OXFDQUdRNTZLT0RXVVF0bjVYTkhkYzQwdXM2Z2NFd0d5?=
 =?utf-8?B?djlkWDcvUDdxcjZHamxYL2t6cEE3dlJ0WFlEOVVtNUFVK0kydWxtbWExWDFE?=
 =?utf-8?B?cjBsRXMvZjdmYWlzWXQwYUZoQm9GSHQ4WHA5ZFk4Q0dzWDM4T3FKcWE3VC9N?=
 =?utf-8?B?cjVFVG5VdUQxTE4xUjFlRDh1R2RQUlgrL2I0aUt2eGxrTW0yMTBSSC9sdmY4?=
 =?utf-8?B?MVdHTWg0dTZIQ2ZNZ0N5THpXTXhHQ1hLcWd4enhJQUdzb292REVseVRDTXZX?=
 =?utf-8?B?VDFob1A1dTUybGpKRHZsVWtMMTcwdXNJd1gwdGlHakwxWTJDL2MydHdabEph?=
 =?utf-8?B?NHNXcXdSTUg2V2ROZnpMSE0vQTdCZ3V4ODhHNHA3NGM5Ui9GN0lFRmlYZHU5?=
 =?utf-8?B?d3pEenlSVjNRT0NnOXdZc3Y5c0tWL3BnTWh4S0tSNDAwQjJUY0owdDlNL0VT?=
 =?utf-8?B?K21yMFp4TXRHWXlPbmdoYmJEaWQvMDFwVGJIaDB6c2QyamNGRDFFTnZEQnFU?=
 =?utf-8?B?VmZSMHMrSTdjSnI2NCthSVBxbTZHekRuUWxJQ3VyOVJ5Y2tpZWxqUHJXZ1kz?=
 =?utf-8?B?T0M2eWdYbUpMUnVpeHkrR0xZcTFZVTFSNEVLQUVxUEUzTzlSQTRBTmMwOTVV?=
 =?utf-8?B?ZVowRnZmMGFMNXc4QVcvS1BNOEduWW9zaEhUSGNYUDcxK1dVdEtpVVpsOVpt?=
 =?utf-8?B?QlZXSk16WFVuQTAybVFtTm15d0ZIa1VlU29odkM0NHRzZmdCY0dTMm9vc1Jk?=
 =?utf-8?B?VXVsR2pLMEdFYzVrYmRyMytNRjI3V0JRc1ZoMGIwOEo5cUFSR2JLZWpqWjZv?=
 =?utf-8?B?SEpPZXhhbGJrUDdLcGFRcG1iTVc5WXlsZFZpOFZnVHNSSjRYOU5meDVWZlJt?=
 =?utf-8?B?S1M3ek45MXN4TC9vQjJaQ2IrbndkVnpsQ3NkZnVTbVdWUGsybWhZeUJJTTVk?=
 =?utf-8?B?K2ZtSFhJNjM0ZU9TajROMjdWUHZ3M3FhVHA5NXBRZ1ptUzFEelp6NWsyTExk?=
 =?utf-8?B?bTMrR1JhZGY5dmtaOU53UGR0WjY4bE1MTjRabmtHd3FUMzA0R2xySWg3STJx?=
 =?utf-8?B?NDYwMkk0aThSMjlqVDF5K2tuUDJlSVpoM1lVRW8rUWMyYndaVWZ2ZlZEOGs3?=
 =?utf-8?B?OVFpTFJ3S281WGVoQStqdkxJbkZLWU5NRGt0YlZzTUpSQXR5VDhvbkxuR0FK?=
 =?utf-8?B?UEJZelIwVjE3NE9UREdJTEFoblpINnllWGh3dC9mVWRGM0RhYUkweHFiUmlq?=
 =?utf-8?B?aVY3RjNJdVRTc0VPQmsrWWloT3E3K3YxZlF1aDBtaDlxY0I1QnMySHhKNWph?=
 =?utf-8?B?SGwwTTBlZ080YUV3TVgrUkNiK0k2cXNnL2p3bUFZSDkvaEwwRFdldnErc0Nn?=
 =?utf-8?B?eUcvVGwvQm1INk5uU1pwZEJ0Y2wwN09CS0lDdTlxMlNPNDdRV0haaVNpZ0Jm?=
 =?utf-8?B?aUdKMnc3UUg5T2pQSUZGcTZ4N3c2d2FJeTZ1WHdwSVc0R0R3Tjdib3RNbjBE?=
 =?utf-8?B?YnBPWDhmaVRaeWxJeGVVZlVZT0R2OVlrSyt3VUNja3EvZC9JWkJBV1pUMDIz?=
 =?utf-8?B?dHJLY2xCV1p6RUtvWi80NDRrZTU5RGllZ3NCem5LZWltY3pOV0JzbkhyZWZy?=
 =?utf-8?B?aHJFZ0pvQUw0VUpFR0piRFVReFZWT3BkcGxlSVQ2YUQyZklFTGk5ZU9ZN3Jt?=
 =?utf-8?B?a0YwN2FzbVJhZHNEbVl2UWpPNjAxajhYNml4RUJMbkJUaGYvUTgxZ1VWQWp1?=
 =?utf-8?B?TnlIbHJvc2RZRUJtMm81NjlzZDRnbXBidy8zditpTlprTHJJK0UvUkhybU01?=
 =?utf-8?Q?+KqUMAvsWYudCnfQVEhQgtO2O?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	bFKVH/Qg5UXcQIVMQKjSApTLPu9Du5iNNuypU12aGLYuxP0x/0MOnhzCAMXHXeWuTO0pIAvqsW+VfwE59IMjgoRBDn+3WQa23FbG5QuWSEuZkuYl2NC4mjbP6hA3FwaolADEHTsoNJ65wDW73QFyJGvEiae+jpExzL94l3OfwERewNByJpDH1Pilm5nRteYBMFqA+bxDosrUTQsm/pGVHvR2M55Q92lpvIwuIjtbSH1YLjW02hv90Ss7rUgESIraB5HUaty+rRpYppt/Dc0SMSnxcs8JtrLNOWyL912LQx9rM1V7oG18+nPGq1xlv+WxXL/6qxrHsMsanZo+bsbz/+tJVfeuc5vqAY4STwD21wKob7nPb6YOiqxsct1ly1JoCxoPRQLk3zf8FjeisBxKatJhF0N6wJH6bS4mDMuwI0YPMC/pT048xd/BTsxAcvo+rZjheMbunhGA5aLd1X6p/S+pEddy12aIAPrDi3/D/vkcwhnANnAvKJj5Lo2xaavQ1kqbMidnTvSKB0ugyj1XYFudS/EMwaMWGNn1yM2C2Y1vRVe2ET75ux0QuLSb7qTLBWC6ejgbjOl/d8mspYdb7BDRxOdKrDKorqcHnN0WCeM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e22cef50-1ead-4584-ccab-08de0b2d8d59
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 14:25:40.8103
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BuZMztrCqwXP5JxzGKUoDCyRse9DMp4SZcQ3uAKARJIX8MMGzWn5tbV/7G1xriRt21wRaVnJ0R5bJyDFjwj99w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4317
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-14_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 spamscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510140109
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxMCBTYWx0ZWRfX/eoOmU05QA4x
 mEPWo/B/1JcCVvA3gO4lbBlWP9utzNNB6GKqwg+ngTq+ieHAJEFURpDSVhi53UPmnXHD8dmJAT4
 PzLsVLdWdppSYGi+pCWpYoGwud9SlywSu+ZFtto3O4q0ESEwP/+JJWbZzMDlQuadxg8D2W6wV/4
 Dq6pTEzpAj130LbH3wpFA2WYzuq7A0AaUbWRxyCkSwq6XFo1js7vtBMb4asSppoucDZ6xLngIbV
 R2TP4GBTF2Gkyre7LmxTiyWJiePtbMEMb0Y/Wiwmgm7j2Bx7r2iC6HT8qfE9q6bh3lFOGXTryeD
 ikrUPCgAJhtvvyqfXdtTkcSA/cODnwgYo5FIDfR1EYw7UVKfdaBPlwcpgYmKdCK8j5ItmVRuWZr
 LnGqOQss65WcohWKVdTIEtMYqoVf4g==
X-Authority-Analysis: v=2.4 cv=V7JwEOni c=1 sm=1 tr=0 ts=68ee5d68 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KQyc5FCLDsPk-APC1_oA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: a8En-luejFyMUPGGrDHzYAk6M0ruaBU9
X-Proofpoint-GUID: a8En-luejFyMUPGGrDHzYAk6M0ruaBU9

On 10/13/25 8:04 PM, NeilBrown wrote:
> From: NeilBrown <neil@brown.name>
> 
> nfsd does not cache the reply to a SEQUENCE.  When replayed, the
> SEQUENCE op itself is replay.


s/replay./replayed./


> So removing the code and comments which seem to imply that we do, and


s/removing/remove/


> detect the case of a SOLO sequence to avoid looking a the cache.


s/looking a the cache./looking at the slot replay cache./


> Signed-off-by: NeilBrown <neil@brown.name>
> ---
>  fs/nfsd/nfs4state.c |  7 ++-----
>  fs/nfsd/xdr4.h      | 20 ++++++--------------
>  2 files changed, 8 insertions(+), 19 deletions(-)
> 
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 1c01836e8507..b51a37ad70aa 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -3530,11 +3530,8 @@ nfsd4_enc_sequence_replay(struct nfsd4_compoundargs *args,


The function's comments (including its documenting comment) seem
repetitive. Let's remove the function's documenting comment, and
then disperse those remarks inside the function like so:

-       /* Encode the replayed sequence operation */
+	/* Encode the replayed SEQUENCE response from current slot values. */


>  		return op->status;
>  	if (args->opcnt == 1) {
>  		/*
> -		 * The original operation wasn't a solo sequence--we
> -		 * always cache those--so this retry must not match the
> -		 * original:
> +		 * We will simply replay the SEQUENCE.
>  		 */


The now empty set of braces here with just a comment is perhaps
confusing.


> -		op->status = nfserr_seq_false_retry;
>  	} else {


From above, add:

+		/*
+		 * Encode the uncached_rep error on the next
+		 * operation, and set resp->p and increment
+		 * resp->opcnt for nfs4svc_encode_compoundres.
+		 */


>  		op = &args->ops[resp->opcnt++];
>  		op->status = nfserr_retry_uncached_rep;
> @@ -3559,7 +3556,7 @@ nfsd4_replay_cache_entry(struct nfsd4_compoundres *resp,
>  	dprintk("--> %s slot %p\n", __func__, slot);
>  
>  	status = nfsd4_enc_sequence_replay(resp->rqstp->rq_argp, resp);
> -	if (status)
> +	if (status || !slot->sl_datalen)


This seems subtle. Maybe a comment could explain what this check
is trying to detect. I assume it is either the solo sequence case,
or the case where there is no replay cache?


>  		return status;
>  
>  	p = xdr_reserve_space(xdr, slot->sl_datalen);
> diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
> index ee0570cbdd9e..390bfb0ba13f 100644
> --- a/fs/nfsd/xdr4.h
> +++ b/fs/nfsd/xdr4.h
> @@ -923,25 +923,17 @@ struct nfsd4_compoundres {
>  	struct nfsd4_compound_state	cstate;
>  };
>  
> -static inline bool nfsd4_is_solo_sequence(struct nfsd4_compoundres *resp)
> -{
> -	struct nfsd4_compoundargs *args = resp->rqstp->rq_argp;
> -	return resp->opcnt == 1 && args->ops[0].opnum == OP_SEQUENCE;
> -}
> -
>  /*
>   * The session reply cache only needs to cache replies that the client
> - * actually asked us to.  But it's almost free for us to cache compounds
> - * consisting of only a SEQUENCE op, so we may as well cache those too.
> - * Also, the protocol doesn't give us a convenient response in the case
> - * of a replay of a solo SEQUENCE op that wasn't cached
> - * (RETRY_UNCACHED_REP can only be returned in the second op of a
> - * compound).
> + * actually asked us to.
> + * This doesn't apply to SEQUENCE.  We must always record in the slot
> + * that we have received a SEQUENCE, and must always respond
> + * successfully to a replayed successful SEQUENCE - that is handled
> + * separately from the sl_data cache.

Once is_solo_sequence is gone, I'm not convinced this is the right spot
for your new explanation. (ie, the comment seems sensible, but maybe it
belongs somewhere else).

The only thing this helper is doing is looking at how the client
set sa_cachethis in the original request, and that's already
obvious from the code -- no comment is needed. And maybe even this
helper could be removed, and the now smaller "if" statement can be
relocated to its only call site.


>   */
>  static inline bool nfsd4_cache_this(struct nfsd4_compoundres *resp)
>  {
> -	return (resp->cstate.slot->sl_flags & NFSD4_SLOT_CACHETHIS)
> -		|| nfsd4_is_solo_sequence(resp);
> +	return resp->cstate.slot->sl_flags & NFSD4_SLOT_CACHETHIS;
>  }
>  
>  static inline bool nfsd4_last_compound_op(struct svc_rqst *rqstp)


-- 
Chuck Lever

