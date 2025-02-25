Return-Path: <linux-nfs+bounces-10323-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E7FA4324C
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Feb 2025 02:11:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F41143A8B0B
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Feb 2025 01:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED495610D;
	Tue, 25 Feb 2025 01:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TH3IADXX";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jjxLBxE9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027D217BA9
	for <linux-nfs@vger.kernel.org>; Tue, 25 Feb 2025 01:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740445888; cv=fail; b=dChYFtkfN4JnIJc7Z0lSJgny6qpeeiuVl813yti2iDa+C8HVszebbE8LHjcH8+gCbYo4ROLb8f5QlyPcIHyQ6tRDGfngVvGOMZSL6VRm14h8q8Ia9eku11t8IKR1DTiWNJW4UB764cIqHhNGrZVUeR5MWNJVuSKTskG5qZzeqOU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740445888; c=relaxed/simple;
	bh=64NgNa410aAMNvPIsAq8/RVc5YL01qxvsyuOvfBoFjk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AEwP9LR+XTUxHLWjmQs/1iIHhjMYYev3hShfp1IH3cM7o1nyLmUE+ig8jAEw0CMQnqM0rStj1jr8HurNZdUPlYlN+3i9SaNWRpfuUx23uThdhgQpEgBb0tXUf40tcv9BTPxQwM7SWPdDsYYl4nws3uF8cF4mzHLYEPkf9kC1VuA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TH3IADXX; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=jjxLBxE9; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51OMK3WH014468;
	Tue, 25 Feb 2025 01:11:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=zY7+n9DQe2MHjlQi0l4cCG7Mu4N6o9YW88V8NZkDzgE=; b=
	TH3IADXXJr70dxyZutHHF1dQyQ8exZ2k8SAb7QUixVrObYkcK4R6LngnEWjlekbk
	MNd7ySSvdI8aU+oyqUvopzQWmrXpiM0fehzvHUldu+FunVzSBAWsfjXXK7RoQvVT
	AhdEZXZ+wPfEb421OHL7ymuYOVAfS9KBM7g38iLDWUM56FiI3rSPJSfRtVONbhaP
	mqKJynKJxCBMXSiRNR/+o0PJylP81fIRz0DUMjaZKxskBwmygmjuQpptAu1GoqzI
	4hFbR7+rBh8E8z58df8R0kYcgzn5GFcQYEKYCA+eun8qlOxJH9GPiGgxtubeogF9
	haOKbjtXUx5Xw9ilYqbQdg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44y5c2byv0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Feb 2025 01:11:08 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51P09st8002792;
	Tue, 25 Feb 2025 01:11:07 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44y518rhu4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Feb 2025 01:11:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ojRNWdyBiAk1z6UefcrURU6ogCjqKas4J0Zqng7yLi6YVt1e5fZGFey5WSYL3YZCqn+x74/y44bY/Z5GX/a9sw0KhrUd3r/jpMcrNzAX7DmNqkGxl1z97m1z/VwSoVZdUTylqEirIPEJtHi9zK2Cg2mvrBYxSLZMxZh+93xWU/ysou4lhcZljWb3ZODvf9OKpSh1QVHepFQemOuAGvcXJ1rIH1ao5/iHIHvGMy3Ntfb2OVw0xiFmSLUgKJk7JLDVGSA0deKAeRZ/ChugfLt3n8raoZ/M6y0/bQ46bDVa1q0Np9FWpSmiepP/MiwfdMEvz1v/hhP2jo//ZcqPTc4Msg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zY7+n9DQe2MHjlQi0l4cCG7Mu4N6o9YW88V8NZkDzgE=;
 b=aTOAlOY7goyWscHQ+0O8Yul37kIX+JQ22cKOd1Fsn5JePRRQre9ypRLyF+y48EKK3G1VPDcFNLdPdRjTMs0ousu6AX4kGWGpxGVRdvZAXum1yG+iurAnT/NFz9DoXPal3oBkEGUm/h/bfDjzk6w8SLsj2fFIDFe8DOpj5PChOUTmYI+WyQG+MZbg35WFvFLj/H2aapIxaiaOWu45PdqCvvNsoDc1RYDEJmQZzqFU2qwWoBsgqZ4252UfxVAz8SxqVWgl60Cp1crsAjOvzgwSBoCYKC7qsn9VK/Pc545lOhlz7Tw9AI89ZHR8UWlsJ1YGu7Rfsu+qWf+cfZJlltGFZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zY7+n9DQe2MHjlQi0l4cCG7Mu4N6o9YW88V8NZkDzgE=;
 b=jjxLBxE915msIcT+PZtwicOzTfpQT09YBe9lD+Knrh8lq3oqJQPpZ1jG4u9S/vy+PXvzW/aTeO667b4JciHaxiYtimYmKMftnWKGa4EUpOGh7UjEwMk/VdABa/73lYSCiiqaGmqqi9QTjVXrRGNMBAijQ59zuZednBeAxg/7Pm0=
Received: from MW6PR10MB7639.namprd10.prod.outlook.com (2603:10b6:303:244::14)
 by IA1PR10MB6050.namprd10.prod.outlook.com (2603:10b6:208:38a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Tue, 25 Feb
 2025 01:11:00 +0000
Received: from MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6]) by MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6%5]) with mapi id 15.20.8466.020; Tue, 25 Feb 2025
 01:11:00 +0000
Message-ID: <5d54e75f-7c98-4181-a738-dd1844461b6d@oracle.com>
Date: Mon, 24 Feb 2025 17:10:58 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 2/2] NFSD: allow client to use write delegation stateid
 for READ
To: Jeff Layton <jlayton@kernel.org>, chuck.lever@oracle.com, neilb@suse.de,
        okorniev@redhat.com, tom@talpey.com
Cc: linux-nfs@vger.kernel.org, sagi@grimberg.me
References: <1740181340-14562-1-git-send-email-dai.ngo@oracle.com>
 <1740181340-14562-3-git-send-email-dai.ngo@oracle.com>
 <dba0a1c365e0e3276639f7682bf07b3d3e593456.camel@kernel.org>
Content-Language: en-US
From: Dai Ngo <dai.ngo@oracle.com>
In-Reply-To: <dba0a1c365e0e3276639f7682bf07b3d3e593456.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0121.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::6) To MW6PR10MB7639.namprd10.prod.outlook.com
 (2603:10b6:303:244::14)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7639:EE_|IA1PR10MB6050:EE_
X-MS-Office365-Filtering-Correlation-Id: 44c1182f-da38-4238-f460-08dd55394422
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VldteSsvd3NwYis5Rm9rYmV1M3RKKzROazV0UHdzNG9GczRBYlFkVWl4L3hL?=
 =?utf-8?B?dEpNTFFqaXpqbUd5MWVOVUlOckJ6c3JmdU01SUZYSVZET3BKRTZmSjI5VFAx?=
 =?utf-8?B?WHdZeTJTelFDMW96MktBZ3VJYUhVYzFiaUtQVWNTc01KZ2Y2ZHRDdGdVM3Bs?=
 =?utf-8?B?TVA5ZSt2L3J1VTRBSXBRM0NRYmRUdjZQZTF1Zzl6c25xSlZTT3pZeEk5QTJz?=
 =?utf-8?B?ME1SQ0xZZ0ZBdXYvNU9hRlB4TXNlQS9TaGJpZmVPMFZMSkZvR1B4Z3hnL1Nj?=
 =?utf-8?B?cytqRVZjRndES3hnQUswZlhSTDA5bmt0eDc5a1UvMXBXNW4xTi9xdURDdmlm?=
 =?utf-8?B?U1h4UnBONEFvZU1EUkx4SE92aTlwVEpuY1Baa3FGYTh5aUIwNzlvNmhodHh6?=
 =?utf-8?B?RDZYRWRRL1NMSEh1akg4S2kwM1BVMTVmK3lwR1pLaGpwKzEycmdCTHBJY29K?=
 =?utf-8?B?ZG5yWTZ4Qk40MFNtTGVIWCtpckxJL1BoRXNoNExKd0RaSmxiOCtjdXN4ZHZr?=
 =?utf-8?B?WFBzNFFpSjRwQzJUTkIyQWQ1OHFHcTRUaUZpSGJNWW9NakRVWDRUeTZ5WHl5?=
 =?utf-8?B?N28vd1FOaU5QS215cGQ3bUZGaElweXVCQXJicStuRDc2MDV4dUVWeFB3ZTgv?=
 =?utf-8?B?dFBINjFqTTVvcmRZdXJQM1BnSUhMbWxVVmkvUVg1WVN6bFFkUTU5aE8xRTRB?=
 =?utf-8?B?SUl2QlY3cnh0bE9HbjJjbmpCc0h3UHBna1hncjVnc0ZETkNTVHh3OWprSStv?=
 =?utf-8?B?UG1jS0JPRDlCRUNyRHVXbWxQaXJMOUtocmRDbE00VXJOU1pnVFQ2UmlQT1Zj?=
 =?utf-8?B?UGo2R1dYRXBqRWlScDJOSCtaU2xucEIxOVFmcU4rZlRKclQ4bXJEQmxQUXlx?=
 =?utf-8?B?Q1JHRGhGS1E0bTBiRzE5WGNBbEVibkFXMWdSbDM1OFdsOE90RklQNEJVR09l?=
 =?utf-8?B?c2FlUE1kZUlCc2ZPNVhSK2pWWHhPMHBiMmRUOGF6ajEyU2ZxcGdwTkplT1Vs?=
 =?utf-8?B?WGZYRzBuVFJoaFJlUmtqaXh6VEkwNmNaMVFpSFNyVkdmcUpLa1BRM1F2WEhN?=
 =?utf-8?B?VWJqelRRQVhwR2pNYVN2RDV1Vy9SRmd2V25RVzcyQ0lMR3NvRVVub1duZ05E?=
 =?utf-8?B?QmlKak5CenIrOGR2VlR4TVI0c29VV09rTUVMWE1MZ2tXc0lSZWRmcWJhMVBj?=
 =?utf-8?B?VG5RMHRPUGlHWHl6SHcvVGhSZlV1Z0VQekZFM0VuTi9GVEMvV1BpU1pHK09L?=
 =?utf-8?B?V1NuVkxCc3Q1bU4yckZhbml3LzYvVlFnQVpmYnZrTnBzbGN5Q1FhUHBkUDFu?=
 =?utf-8?B?amxuM0xJSlJyV01IUDRlbUxjcTJtWEsyVDJidlNBaURjaVpxVWhBRU9rOXU0?=
 =?utf-8?B?b3NxWHVxOTVEMlVENDFGczVDZEtSNC9oZkpoTU9oZmIxVGpNREpGTkRUbzhp?=
 =?utf-8?B?dTNxQ3B5bUVuYTd2WnlqVlQ1enlFa0pKOTh6RG5sdC9QWkRERDdrQ0pYem5r?=
 =?utf-8?B?dDBGU1c5cHdaOFdYVHRNTzhrdzJhRXo4WXUvNHBJQWJvcjh5TzFGaFRUZG5a?=
 =?utf-8?B?ck05WTY4cTI0S0lnVWMyb1FBZjMzMXM5R3RSMUw0RjRsdkZkVTVwU0NzUURX?=
 =?utf-8?B?Tlg2blhhNjNjNEZ3bTJUVUY5b3daekxvWEsxaTgwRHhnZW9MWHY3dTFDMDU2?=
 =?utf-8?B?eFNqZ0h1a2JOaEJpSHlmRmdNSlRyZCs0OFFDSitEZ0R0Vkk2NmtETDNRN1Jl?=
 =?utf-8?B?UVAvQjRZRTRqdUk4ZWNhTEV5MFpzQkErMllrcHJlUmRkMEIwMDgzWlVjMng5?=
 =?utf-8?B?WG90QVpJWlIwaE9rRHpwYWZoSWw3MFRaWlE0MlpudFlWbExwSjVEUHFMVGty?=
 =?utf-8?Q?FL2/OsDsu6jiF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7639.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eXVyWkhjMmtaYVliM3kzVHJOQk0zL1I3SHU4T1IxS3Z0ay9jWXRIdnpWQ24y?=
 =?utf-8?B?UUY5NUpkYnBGWVVjcTRlaFNWMUFJWDBJdW9pRHQzMUJxRnlqT2N4Y1ZrVkIy?=
 =?utf-8?B?UU53ZE5ORmx6QlRiSDloZWExRHhPYTVZWHNQT04zSmxIeHFFVWNlL0l6WVhh?=
 =?utf-8?B?cnc4dmNPbkJyb3loZU9yVENGODQzRnZuSWR6cDE3MmthYmpSMnpWTWNPWUdm?=
 =?utf-8?B?Y0o2YWtPQWI1ZW5TaEtuWGh4SFNxcmoxMk1iV1VhRjNMamNXckMwTmNnS2Iz?=
 =?utf-8?B?d2grTVhWVGZScEhSdUF1S1k3RjNGTTd0SW9FSytnd0pUTk1wVE92YmJpd3ph?=
 =?utf-8?B?MWsyN1RLZ0NNUURVbnNObWNLNi81bWwyQ1R1S1NtVmdUMGRERVJEQnhxZ1pu?=
 =?utf-8?B?Wkp0dDNTWUJjbFo4T1hDL2lOLzczbmNSTHVRRmxkblp3VWxYeStrbnRmTEll?=
 =?utf-8?B?VzAxSm4vd0xyeHhBYm9Rb2Q5dHFkb2FQeUtXa3ZoRDR3aWtoaXM2RWNHV1J0?=
 =?utf-8?B?eDZmbFRpZzZSRFBIQ2kxdGUzeTNVYVhzczU2K0xGUm1oRUFCVjF2dExCS3NJ?=
 =?utf-8?B?c3BZWHI5cWtXNFZnc2Zmc3BNMVhTb0dvdmN4MERORGErMHVXc05HTEtaRXZT?=
 =?utf-8?B?OFJuck5GYzVHNmN0M2xkNnhuUTBJamJ2dXRaNVBNQnVFVjFwUFduZnVzM0k3?=
 =?utf-8?B?bGREMGRsWU14Y0VuMFl1ZVJmTHlNa3BwcXhnRWw2YnB3SzhiUzJGaXEvaXN4?=
 =?utf-8?B?S1h2TjJta2FTVmxUaUxNWGtvcmkyWnlBRTlzbVRFTExUdCtSN1pkS0I2Mm1H?=
 =?utf-8?B?cnNSUFR3SzJwV0xYemV1WUhmaGlaeFdHNlU3bjJPMnY1Q0syYUd2NmUzU1F2?=
 =?utf-8?B?eDZrT0o1ZThybWJLM1BIT2x4TE11MkNYNjNOMDZMc1NIUFRlQkNEUGJIN2F5?=
 =?utf-8?B?WnJGOTE1M2lUV3YvcmpiSjZVbzVNZ2NFUTBvWW1xQ0hCN2VJNm5LOW1rTjNT?=
 =?utf-8?B?ZjVZK0JrYWhuejBtcnNEcHdUSElEL0s0cmdRQ0ZNSm04aDg1VktTcGRwLys2?=
 =?utf-8?B?eXBkYXNlY2gvUGJPTTQ4YjlvVk4vQzhCUFpVQVNaVEx3dDZocXFpU2MzSG1D?=
 =?utf-8?B?azA5S044S1ZEc29VNmt4QmlHNndPNEY0b3pmZDkwb0prMGYra0ltbWtoVk10?=
 =?utf-8?B?b3pVb1huUGxsdEtnNjRHOGFsRG1DVDdTd2xDdS8zTmJ0Z05STHVCMjU1clJk?=
 =?utf-8?B?TnFyUUtVL0Fkc3VWcDZHNS9Gb1BYaE01eDI5M2RaZnhVWlA0TXl2R001TDIz?=
 =?utf-8?B?RmtnTnI3VTF1YzU0RklFVnBmbWo2ZTRqRnR0cnhVUUVrdm53WFZNU0lYWFNh?=
 =?utf-8?B?VzJ5Y3IrcGdHa2NTVGhzcS9qTEFjSGNDNnAwbk5GamlycU9UbVBhbGRrNDJl?=
 =?utf-8?B?YVp2d1lQKzlPaWgyVTBoZVRDYVhYS0ZSbE1uZE1qNTN4UEdjRGtpNU9DRHdF?=
 =?utf-8?B?aU5TUFNrT3pzTDUzN0RZdE9aL24veXFEbDdRKzVBNnE5dDZMTWRkRk93MXo1?=
 =?utf-8?B?Yy9hem90RmFJTmlJR2JBVGh5ZU5ndmNONzlvZEVFdFJlWUlCdER5TmhyN3o2?=
 =?utf-8?B?TVl3b2UzdEh5dDV0YlMyaDNEbTNoYW9hcmZjN3I1TFk5MXZIV1NQLythcFYv?=
 =?utf-8?B?S3FVWGtWV2xtUWwrOWk5TE1pYXRMcTFQbFJaeGI5clhrck9CUUNMbW5DbVFa?=
 =?utf-8?B?bnZyUHc1aGlKN09GSjVTVC9TNVZCeXdQelQrclo4K0thc2d3SjJzeVk0SFFn?=
 =?utf-8?B?TS93QzVNQkxmTHp1RzVna1BBc2NWQlpLZitwcWhCOFZlamx0dEVCM0dHcTZt?=
 =?utf-8?B?VXN2NUIra29uTkVmbnpGZng0K3l1VWI1dWs1cVYyUjR5TWtpNGlvcTQrTmRB?=
 =?utf-8?B?a2Fodjl0QW0xRU00eW9kNmhvMmNyTndtSDJNdFZKQ09oaVc5WnZrZEVqSXdR?=
 =?utf-8?B?KzRTSk8zUHl3MDZsWi9NYnpEWWNPNmc3WEZhMUdSYm5mWU9RWTllcXlvMmoz?=
 =?utf-8?B?MFFubUxKRlA3UUtDeFJyYkRndlkvWDVBNDl2SjlYN2g0b3VpQ01RdmRKMXgz?=
 =?utf-8?Q?Lo3J6N3xAPykPG6UDg75qrFb5?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	fcd+bD+VahUpx9pRZddjcvoXQJorTC0hw7dNnJg+7xop+mkgij1G5kwGDaAk+X3UfSbkJOpoHvCXrr61UbYeDpoVy+cGQDd/BBaZh3t7CR9zHE3k0xJe8AjaDy4By00uE+ozT4j1bnjwOwEfO2qoliiX/gadybq7F2gkOygiHUP16PBJuiHXmSeQYxkMOp7CaKLwQqjNk9CvuV1e7hD4KaiE57Nl2nDFFQ77C4+2VKcuFCVMfNWai7Rhlb0Ixpsx7za8nsATrU+pbXg06FEgOScwWtzYyXZ8NDzzsz4xaKJtOcTYArZSYC2NaJ43LdX/RRLYPpjbdNdT6wg/pGJyHq+5VII1/cwHtRajOGFFaza33FzvMMK37DQg1dFr0zfLb6J1A6f6LnoLpcrsKtKjDhe6evtNVOuJNCE/Xph8r/YIJ79//Sf19kR75Nx1jPeYq6P8wdU32Dwm0/dLELTQFZQO3XUkMpO9yfGEzq8H7FnDYrWDtvUtU03oGLtJwX3Wqs2lMsNbmTyA/3H4dNLrhBTeGHNBpsw31Mf6KQwpWpV6Qc4C1ifutAXCBCGLFbvtpElbkkPns2RaKJz66mB/i3xPMiReIs3uMq3Dn/iWjZY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44c1182f-da38-4238-f460-08dd55394422
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7639.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 01:11:00.2489
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6MhYwzJuJHMPMW38HZIvBf0H1w0c3nr2cjOvElBjtwYYG3PUm6Qaa58iP+ZmVOlSg1AVH0mtyNco5hvA2Wu3Dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6050
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-24_12,2025-02-24_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxscore=0 adultscore=0 bulkscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502250005
X-Proofpoint-ORIG-GUID: FGWomszC9LvyiXO7MYhMz9rWkt33ulM2
X-Proofpoint-GUID: FGWomszC9LvyiXO7MYhMz9rWkt33ulM2

On 2/24/25 7:48 AM, Jeff Layton wrote:
> On Fri, 2025-02-21 at 15:42 -0800, Dai Ngo wrote:
>> Allow READ using write delegation stateid granted on OPENs with
>> OPEN4_SHARE_ACCESS_WRITE only, to accommodate clients whose WRITE
>> implementation may unavoidably do (e.g., due to buffer cache
>> constraints).
>>
>> When the server offers a write delegation for an OPEN with
>> OPEN4_SHARE_ACCESS_WRITE, the file access mode, the nfs4_file
>> and nfs4_ol_stateid are upgraded as if the OPEN was sent with
>> OPEN4_SHARE_ACCESS_BOTH.
>>
>> When this delegation is returned or revoked, the corresponding open
>> stateid is looked up and if it's found then the file access mode,
>> the nfs4_file and nfs4_ol_stateid are downgraded to remove the read
>> access.
>>
>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>> ---
>>   fs/nfsd/nfs4state.c | 62 +++++++++++++++++++++++++++++++++++++++++++++
>>   fs/nfsd/state.h     |  2 ++
>>   2 files changed, 64 insertions(+)
>>
>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>> index b533225e57cf..0c14f902c54c 100644
>> --- a/fs/nfsd/nfs4state.c
>> +++ b/fs/nfsd/nfs4state.c
>> @@ -6126,6 +6126,51 @@ nfs4_delegation_stat(struct nfs4_delegation *dp, struct svc_fh *currentfh,
>>   	return rc == 0;
>>   }
>>   
>> +/*
>> + * Upgrade file access mode to include FMODE_READ. This is called only when
>> + * a write delegation is granted for an OPEN with OPEN4_SHARE_ACCESS_WRITE.
>> + */
>> +static void
>> +nfs4_upgrade_rdwr_file_access(struct nfs4_ol_stateid *stp)
>> +{
>> +	struct nfs4_file *fp = stp->st_stid.sc_file;
>> +	struct nfsd_file *nflp;
>> +	struct file *file;
>> +
>> +	spin_lock(&fp->fi_lock);
>> +	nflp = fp->fi_fds[O_WRONLY];
>> +	file = nflp->nf_file;
>> +	file->f_mode |= FMODE_READ;
> You can't just do this. Open upgrade/downgrade doesn't exist at the VFS
> layer currently. It might work with most local filesystems, but more
> complex filesystems have significant context attached to a file. Just
> because you've changed it here, doesn't mean that you will _actually_
> be able to do reads using it.

I think allowing read using a write delegation from a OPEN with
WRONLY is an optional feature and is not a requirement from the
spec. So if there are filesystems that do not allow this feature
to work then it is ok; we did not introduce any new problems with
this feature.

>
> This might even be actively unsafe, as you're bypassing permissions
> checks here. You never checked whether the file is readable. What if
> it's write only? Same clients will do an ACCESS check before allowing
> it, but a hostile actor might be able to exploit this.

Apparently the NFS server relies on the NFS client to do permission
check at time the file is opened. Once the permission check passes and
the OPEN is successful, then there is no permission check on READ/WRITE.

I wrote this pynfs test to verify:

def testReadOnWrOnlyFile(t, env):
     """Test read using open stateid with OPEN4_SHARE_ACCESS_WRITE
        on file with permission 0222

     FLAGS: writedelegations deleg
     CODE: DELEG28
     """

     # create a file with write-only mode (0222)
     sess = env.c1.new_client_session(b"%s_2" % env.testname(t))
     filename = env.testname(t)
     res = open_create_file(sess, filename, open_create=OPEN4_CREATE,
             attrs={FATTR4_MODE: 0o222}, access=OPEN4_SHARE_ACCESS_WRITE, want_deleg=False)
     check(res)

     # write file content
     fh = res.resarray[-1].object
     stateid = res.resarray[-2].stateid
     data = b"write test data"
     res = write_file(sess, fh, data, 0, stateid)
     check(res)

     # close the file
     res = close_file(sess, fh, stateid)
     check(res)

     # OPEN file with OPEN4_SHARE_ACCESS_WRITE
     access = OPEN4_SHARE_ACCESS_WRITE|OPEN4_SHARE_ACCESS_WANT_NO_DELEG
     res = open_file(sess, filename, access = access, want_deleg = True)
     check(res)

     # READ file using open stateid
     # Linux NFS server allows READ using open stateid from OPEN4_SHARE_ACCESS_WRITE.
     # However, the file permission mode 0222 then the READ should fail!
     stateid = res.resarray[-2].stateid
     res = sess.compound([op.putfh(fh), op.read(stateid, 0, 10)])
     check(res, NFS4ERR_ACCESS)
     res = close_file(sess, fh, stateid)
     check(res)

and the test failed with:
      "OP_READ should return NFS4ERR_ACCESS, instead got NFS4_OK"

Am i missing something?

-Dai

>
> I think you need to acquire a R/W open from the get-go instead when you
> intend to grant a delegation, and just fall back to doing a O_WRONLY
> open if that fails (and don't grant one).
>
>> +	swap(fp->fi_fds[O_RDWR], fp->fi_fds[O_WRONLY]);
>> +	clear_access(NFS4_SHARE_ACCESS_WRITE, stp);
>> +	set_access(NFS4_SHARE_ACCESS_BOTH, stp);
>> +	__nfs4_file_get_access(fp, NFS4_SHARE_ACCESS_READ);	/* incr fi_access[O_RDONLY] */
>> +	spin_unlock(&fp->fi_lock);
>> +}
>> +
>> +/*
>> + * Downgrade file access mode to remove FMODE_READ. This is called when
>> + * a write delegation, granted for an OPEN with OPEN4_SHARE_ACCESS_WRITE,
>> + * is returned.
>> + */
>> +static void
>> +nfs4_downgrade_wronly_file_access(struct nfs4_ol_stateid *stp)
>> +{
>> +	struct nfs4_file *fp = stp->st_stid.sc_file;
>> +	struct nfsd_file *nflp;
>> +	struct file *file;
>> +
>> +	spin_lock(&fp->fi_lock);
>> +	nflp = fp->fi_fds[O_RDWR];
>> +	file = nflp->nf_file;
>> +	file->f_mode &= ~FMODE_READ;
>> +	swap(fp->fi_fds[O_WRONLY], fp->fi_fds[O_RDWR]);
>> +	clear_access(NFS4_SHARE_ACCESS_BOTH, stp);
>> +	set_access(NFS4_SHARE_ACCESS_WRITE, stp);
>> +	spin_unlock(&fp->fi_lock);
>> +	nfs4_file_put_access(fp, NFS4_SHARE_ACCESS_READ);	/* decr. fi_access[O_RDONLY] */
>> +}
>> +
>>   /*
>>    * The Linux NFS server does not offer write delegations to NFSv4.0
>>    * clients in order to avoid conflicts between write delegations and
>> @@ -6207,6 +6252,11 @@ nfs4_open_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
>>   		dp->dl_cb_fattr.ncf_cur_fsize = stat.size;
>>   		dp->dl_cb_fattr.ncf_initial_cinfo = nfsd4_change_attribute(&stat);
>>   		trace_nfsd_deleg_write(&dp->dl_stid.sc_stateid);
>> +
>> +		if ((open->op_share_access & NFS4_SHARE_ACCESS_BOTH) == NFS4_SHARE_ACCESS_WRITE) {
>> +			dp->dl_stateid = stp->st_stid.sc_stateid;
>> +			nfs4_upgrade_rdwr_file_access(stp);
>> +		}
>>   	} else {
>>   		open->op_delegate_type = deleg_ts ? OPEN_DELEGATE_READ_ATTRS_DELEG :
>>   						    OPEN_DELEGATE_READ;
>> @@ -7710,6 +7760,8 @@ nfsd4_delegreturn(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>>   	struct nfs4_stid *s;
>>   	__be32 status;
>>   	struct nfsd_net *nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
>> +	struct nfs4_ol_stateid *stp;
>> +	struct nfs4_stid *stid;
>>   
>>   	if ((status = fh_verify(rqstp, &cstate->current_fh, S_IFREG, 0)))
>>   		return status;
>> @@ -7724,6 +7776,16 @@ nfsd4_delegreturn(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>>   
>>   	trace_nfsd_deleg_return(stateid);
>>   	destroy_delegation(dp);
>> +
>> +	if (dp->dl_stateid.si_generation && dp->dl_stateid.si_opaque.so_id) {
>> +		if (!nfsd4_lookup_stateid(cstate, &dp->dl_stateid,
>> +				SC_TYPE_OPEN, 0, &stid, nn)) {
>> +			stp = openlockstateid(stid);
>> +			nfs4_downgrade_wronly_file_access(stp);
>> +			nfs4_put_stid(stid);
>> +		}
>> +	}
>> +
>>   	smp_mb__after_atomic();
>>   	wake_up_var(d_inode(cstate->current_fh.fh_dentry));
>>   put_stateid:
>> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
>> index 74d2d7b42676..3f2f1b92db66 100644
>> --- a/fs/nfsd/state.h
>> +++ b/fs/nfsd/state.h
>> @@ -207,6 +207,8 @@ struct nfs4_delegation {
>>   
>>   	/* for CB_GETATTR */
>>   	struct nfs4_cb_fattr    dl_cb_fattr;
>> +
>> +	stateid_t		dl_stateid;  /* open stateid */
>>   };
>>   
>>   static inline bool deleg_is_read(u32 dl_type)

