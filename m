Return-Path: <linux-nfs+bounces-9578-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B39C1A1B7E7
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Jan 2025 15:32:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C87F3AD7BF
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Jan 2025 14:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E5A83597D;
	Fri, 24 Jan 2025 14:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SoDK+5n0";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="aDq4Fk1v"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8346134B0;
	Fri, 24 Jan 2025 14:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737729159; cv=fail; b=gP9fTBTBLZmeEAec7pES9zzx73R2Niv8eANhaBJYBhUrV1qSY4hoiW2OC0bDWMX6p3vIolLdjIoTd8i7jVK88fJrUGOuzYSEPaG9MTHXTT4AuzH5CFOe1dHPZZvtKy7XHnkEIA9ukz4OWTbSgUnOnwpAxjWD+4hXPqjhh+o7JT4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737729159; c=relaxed/simple;
	bh=tyhS3v73z9I8ONARtOnfpIUL7sdt3GAKgedQ/f9j0E4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MI1/40exK8qZ8vVjrDzVZifGgpX1Lp05+6TS6KmN5jqan/GtnBHzrmcnRp2rWL57LeZOPtpDEx8VFm9QKdyaHKpB4cA765OBmOhNhLTXBGcV8JlEp//6bJiAL9s3Zl4iX44onFurCrWgWyAxHUc+3oPgimlHOdr7wIYQKpDO+IA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SoDK+5n0; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=aDq4Fk1v; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50O8gMKv019328;
	Fri, 24 Jan 2025 14:32:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=XWXMdQV5Vd28vEIqxbiOhR5VbhMYtakKkTG3XvzQ2lw=; b=
	SoDK+5n0xv+m45MDAMG7yH+b4XfULoBFcGy2sK1fx6Vny3DfCCoYMJvIsjyV9+7U
	1I+JXfg5vu5bwTG7qHhBYsaTLewI7pkKP1Ls/B7vuMMbOGw0nxYI077IDfhSuztD
	JLjYaPwBz7grILkNOuUUjQTAUx/tobNco84Cv4BZno+l6CKOFIj/sf5I5PO2yH7L
	+Ax9wSYVqHnMA82laak2xd9P7YVE950yE4Vwe9LK8q0VaxOjKJVSQjomIvcuk7a+
	PGZI34O3/u2DuGQCRxKAqMruZkaDu+p1MZVMGjIZOFfpUYo64LLQz1x36one78TJ
	kD/KHEp+YEgB4O2On0mlGw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4485qav501-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jan 2025 14:32:22 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50OCi3tW036659;
	Fri, 24 Jan 2025 14:32:21 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2043.outbound.protection.outlook.com [104.47.70.43])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44917thxrw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jan 2025 14:32:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WCnUfvpcbbScnfykHeBi6lb0VEuiLDc56aD0VtBxgpUPtlp35KJ+eXLhlOOJYtTpfxyo3fpxprGtMSVtpXcuxhfUzufSG/mo3KgeUj1tc7kA+JUIgVTf5phzfqBwKVmmB1BV6DrrB36K+tiYbtw8efxwgr029S+jmlNQbbTFBtgX9I/7bvlUegpzCLao2YwdbXCTybArdW+d8ncgtt7N7wyBGj2ox9KJxvgpRRBFKxIsmKEdto1PpIynARussLMDfN79UTQdN9dZLmM0hvKQj/gnLMhW8WFa5jJmrrJby5iBvWoHU0QjCjTycx4Qh0YPWWROnm/IHampnxqVVhbwmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XWXMdQV5Vd28vEIqxbiOhR5VbhMYtakKkTG3XvzQ2lw=;
 b=mQ37HHEo4fSsKL1qBOT8YwTUf8cH0MnICbUaiWy5vVJIxj3ontb1GQ55VhvjswETZ9KW4mbvsnBE00no1aL1uaC++hcU1j8/yb9VtP75CQeVwo9+sLhNcYKjAwWSSvAwVj4yDN5SbbQwN5p5deO2S+n0ZN1Ihiq+5ieVJqY1x3hRKwXuaLVWnb92uMp+kUFCMpGHqgxjkOR0Wlca+dclC8HvKwZ+YVNlr1ny3Kh378Fte8kHTpmhlpCWLW5iLD+DMHjJFacBHznrtFUKO9Wt07l4HCnuYJhlS3wrv2Ufmb3VWkQDtKvM76Ue7Si4gR/MDeAS5kJoWNoCayiJYRM3QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XWXMdQV5Vd28vEIqxbiOhR5VbhMYtakKkTG3XvzQ2lw=;
 b=aDq4Fk1vM14Xa2K+rdPsJxmLv0qT1WuLzy7sGCL3gyEs/jxegUn6nc1ZznvGPw4ic8hCO7GbKeb28KQHTghNDDRA61QLCDUGpXfMnZCsvOXSDJlqep+qIXkL+m25xXPZEOfwpj5SL9hAVENvyIPtAUwUS9HppEru0uXWUKD08Z4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM6PR10MB4137.namprd10.prod.outlook.com (2603:10b6:5:217::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.20; Fri, 24 Jan
 2025 14:32:19 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.8377.009; Fri, 24 Jan 2025
 14:32:19 +0000
Message-ID: <c87e5353-d933-47fa-a4e2-9153d243d61c@oracle.com>
Date: Fri, 24 Jan 2025 09:32:16 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] nfsd: fix CB_SEQUENCE error handling of
 NFS4ERR_{BADSLOT,BADSESSION,SEQ_MISORDERED}
To: Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, "J. Bruce Fields" <bfields@fieldses.org>,
        Kinglong Mee <kinglongmee@gmail.com>,
        Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
References: <20250123-nfsd-6-14-v1-0-c1137a4fa2ae@kernel.org>
 <20250123-nfsd-6-14-v1-2-c1137a4fa2ae@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20250123-nfsd-6-14-v1-2-c1137a4fa2ae@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5P220CA0003.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:1ef::21) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DM6PR10MB4137:EE_
X-MS-Office365-Filtering-Correlation-Id: b105009c-4860-4dfa-d4c5-08dd3c83e813
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?enRlSldCSERWUGhQdzd3K1hXempncXU0WHRtOTFxNGM1OUtMaUoyU0VrUWdT?=
 =?utf-8?B?ZWJjSC9uRXRWeEVHNk9obkpnUjN1WVQrajhxbk9sQmVpbVlFWVlXNGM2Ukt6?=
 =?utf-8?B?U2ZzNjFNSFdzVStGSnZmMEtzQmxFK2FpazB0dXprSUpjWHlhZG5LY05DTjgv?=
 =?utf-8?B?TjZZWUZ0MXFWUDJaSjc0QTBZb09mK3ZCM3dEa2ZUaXdtTnNNUi9wdjAvU3ho?=
 =?utf-8?B?QnF0ZUplSFVqTVpkNGgyTnFkZVNHWmxQTi8yUDhHMHZFb0NQNmtnak54cE5w?=
 =?utf-8?B?cHpxL3cyMkl6REVHNEx6TTV6NTUvR0RGZnpsdlNNNXJVeFdhTk9kM3BwUmN4?=
 =?utf-8?B?Nm1Rb1dvU21JbE5SZHpQVXlNYjNsOUlXVDNqVCtqdSs5VDF5dExCMDU5amVB?=
 =?utf-8?B?UHNmaFVocHpBSHdDc2RkVXAwbWdKSnQxbGdQckFFNGY0S2VEQWU3NVpydGUw?=
 =?utf-8?B?VzFuQ2l2NEhjbkxObjZGTHdDblloN3p1enpVWjluSzR0aERZbGJUT3d1dDMr?=
 =?utf-8?B?YVVzRjg5NGtFWm5TUHZQVjhGSStqWGJLdWV2aXN1ZFdFUklYaThZcEpUcEl6?=
 =?utf-8?B?eXBrcWpXZGJqVVphQk9rY0dVVlRlbDczMEMveXFuOTBVdm96cUd1Z0ZKV1pu?=
 =?utf-8?B?RTVXVTNrajArRVRYQ2NOYTRZQ3VXUnEzN0NHbWFPYTJNclhib093RjRUNHo4?=
 =?utf-8?B?cklaT2d5NHlMRXJkbElVcVZiSTdmMUhJRE4wZ1dUZmpqMXJoSFpxTitXaWsx?=
 =?utf-8?B?cjR4TENkS2h0WjZDOTNFaUxGVGc4Znllc3lGQWwxYWpXU2p5MitnV3ByZDlt?=
 =?utf-8?B?UzVmZVNwMUpCZlhtOHNFTmtaOVlndVBKUVRwWHR2cThqa2ZOYnJzbGtrc1JK?=
 =?utf-8?B?REFtUUd2NGJHWEJPTGRiZCtoSXV2SGlZQWlYNmNUaVJadEV2YXNjMWFYSkl5?=
 =?utf-8?B?YUYycGdscldFeGt4d2JyV0JuR1NubzlqNmhXbytQNDR1SVdBREVJR0NNcnlL?=
 =?utf-8?B?ell1KytxM2MvWkVybnphMWJZZmtacHl1Y2pXL09yWnF0cU5rZnY2ekI2STYw?=
 =?utf-8?B?eEZKb3JTK1I0WDZpKzhBQ040bkE2VXhqcW1hbWRrZVgxNHYxMTJVK1dLL1hk?=
 =?utf-8?B?cGFCa1JjT2hxZS82NmFRZ3Y2cTJRU3U3WHlmRVVrdEJRRnp0elFaWG9JYnFy?=
 =?utf-8?B?MFpHNmhUZnRvdGFpcEx2OUVWeVNlQXhlbmczMVBUVzBFbVgzTDM3YURHUXJF?=
 =?utf-8?B?ZWRwdGNCZzJ2U0ZWS0pLclNEUUc4RDJvSFJqeEVIVlk2aGlDcG4zRUVtalQ2?=
 =?utf-8?B?cGd6WTJuOGF2bisvR0Flekc2OVYwUjI2a2o0VW9Ua2QvakpaLzZ5emlQcDgy?=
 =?utf-8?B?SzNDdTUrb2dDTk9hcXNuc0Exb2RnSzBCVHduSlVHV2NqWkhueG44aVRhRjF1?=
 =?utf-8?B?Y1NNOGs0dzZ4WGVrVWxpNkVzamFMcExza1B0cUpNaVdncytSdTBQcXU2d2Y0?=
 =?utf-8?B?WFkvcXN1Z3NrSWtIaHdBaGdVWXZyT3AvS2VtOE0zejVENjhDeVh4ck9pMHNV?=
 =?utf-8?B?a0tsUEV1ZVJCOGlOK2RNSk4yaDBtb3I1NWMxK0h3WUtoV2wwWHp3QkJUMzhC?=
 =?utf-8?B?YjY2K0RnVkVadk1Wb2FGMWJmdFF6dCt2dFhVRVkvYlV2R1ZtQWZVVjZka0dx?=
 =?utf-8?B?RXBBRERoYUk3TzhLU1BINFdwT3V2dEpVUEZjeTZaMFRaY1pVM1JhZUxqNDlQ?=
 =?utf-8?B?dmZORzVFVUhLVmpyd1ZSWFFJMWZramprOTRLWG03UlVmaklPVzFHWTZEV20w?=
 =?utf-8?B?R3dwS0ZRNGFLemp5d2hUS2JiVEcrRis1QlVjWTJXS3Eyd3BQNzlCakVUMHUy?=
 =?utf-8?B?cUVVYTlFTEh1MUlBdFdxUEhZQWhLRjk4eU82REVyc3pkNDB3SXBkOVMrTHU3?=
 =?utf-8?Q?dW77J02b/NY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cDFnWVAzekY3b1NVdmlrNWhxSk1FRzhMOFB5UmEzU2dDN3ZzOVZmTUVsa3Jv?=
 =?utf-8?B?akZ6eXlwY0NWTTZXTnhnL3BTWUk0cFd3YTRJL0o4VlFEMlo2NGtRK2tlc29p?=
 =?utf-8?B?d3g5NUtPOGczVWpGdXZ1eWR3MVg3K0NLbGdEZE15QXBQRVNLV1lvTm82UlF4?=
 =?utf-8?B?U1grTmczMU1GSkZrU2ZGb3F6Z1VrM2U0aFBERnFlZEpjR3VsZjZwaG9lTVFj?=
 =?utf-8?B?bi9NSXM2L3MrbUtnSTA2eEpMK0hvN1JZYThNVWt6emVCUXpnZytDT2pxcmZp?=
 =?utf-8?B?SEZ2UkEzdEJEa1luL2ZUTzhORWkweXhydkRqWmlXSENLVWU4SUxhY3lvcDNq?=
 =?utf-8?B?Q1MrUWNlUTlCZ2IwRVNvcnNjbnVWOGhkQ3F6cTNoRWFHeXpRSWtMSmJIV2Rh?=
 =?utf-8?B?UFVhVkhYa3YvcXc4dWhZMjdBWUZESnV6ZVMvZ0NhQTJxM2d2SXBNaEpQTDdq?=
 =?utf-8?B?UEtzenZwWkhqa0licFhDRm4za1dKckdqQkV3Unh1TGcxNnR6QUZ0N0M5ejBi?=
 =?utf-8?B?MERtSEJreXYrbU05eDhaMnI1cFlSNi9PdzZRR25Cb256MElHVEE2NFVva2Zl?=
 =?utf-8?B?RnZ3TEVZenk3Y2NyaFpiNlZaRlJ1QVpZR3BmNkREdVM1RXYrMlpQazArbUF2?=
 =?utf-8?B?NFh3SEhxcW5BYlcwMDdvMWErTVdYb24vbmRGaUxkendHTXhYTGE3a2szNWpG?=
 =?utf-8?B?M1F5V3dnajQ5RVFqbkdkTjRTWmhqeW5RclJKSHFheE1jd1NvOFFWUGo5MHhL?=
 =?utf-8?B?SDZrRGlKNnJxeWRlKzJjZEF5WisxWEdOWnpOVEFrMmxaQW16QmJUSXNraktR?=
 =?utf-8?B?a0ZEaTREYjBzM2k4ckJITzJMcVowaXgyZHBZZDZ0aExtVjM4UVNnTmJFdy9Z?=
 =?utf-8?B?UUp5ZjZpUW94c0RIWlZGRlFKMG1sbnZTeDhIaU80SnRRbUYrS25lRHFIbFBp?=
 =?utf-8?B?bVVkaThIaGZTcldRenpNSktoZ21tcHBPU08yZlhwb2Y3bElwTHdmQktTY2Fn?=
 =?utf-8?B?c216RCtZNTlsOVBLY1dQY1d5dkZNM24yYmpOYkdDNFZ4c2RyMmRvdHowZDFS?=
 =?utf-8?B?V1NBSExZVUNPY1R1S1JKSmI2VHNwSjNPY05ocU94NzE2ZUFUdzFaWmhOWTFK?=
 =?utf-8?B?OXVPVHIzQWlGWCtvcWVqMTdIQ0pOTCs3YWM2TmFGUU9jNXl5V2NMaWFxN1ho?=
 =?utf-8?B?cnhvR2VXYzF4TDdSaEQrdzkyV00yOUZnNkVsQlYrM3lCMFdlbkdhTXAyMHdh?=
 =?utf-8?B?eGRXaVBIOE1ESXFnZk9waHk2Vk15dXovQjJVYXI1cTFSYWlGanhjMVQ2TytK?=
 =?utf-8?B?UlNHK0piQ2l0OXZPc05nSmRWWjl6YXc0WDRaT0dQNCtTeEdpSWllQzlFOVVx?=
 =?utf-8?B?azRwV3ZaMHlTenVxMU4yZVZ6RnNJTW1RakNzVDFlWGtHdjh0enF0SnA1Yk9k?=
 =?utf-8?B?TGxlWTZFT094RURRUEJ2cG5xSVUwa1YwZldtWWwyWmFxdGlXWGs4ZlRuOWpV?=
 =?utf-8?B?N0JCNzUwWUk4cVQzK3UrNytQcU1IbCt0NFFTSEpVb0RYQ0sya3JTUGMxc1hj?=
 =?utf-8?B?MytuNHFvcjJ5VmNUWEFXN1BvdjhhTU5oZjRtN2JoVEQzbi9xQXlTbXRDcGl5?=
 =?utf-8?B?LzF0V2dDOE4wYWpQaDRVMTgxYkh2ekdtZkpkV1l1NFc3NEFyL2xaa1NLalFW?=
 =?utf-8?B?V3RMWEZtMENHSEpURjZDTjJUc2NNZnNqYklscE03eWZ6WGN6S2srR2NsTjhU?=
 =?utf-8?B?MXZWeDlGenVJSG9qNDAwK21Pa1NWenFSQzVPODZPNWRKL2psdmxXUXRMaDFR?=
 =?utf-8?B?bnMwT3UzU1g2ZEtIeG0xNTBVTHlDN2xNMmJoY3A2TG5TdzY2K0FETFFjQWNG?=
 =?utf-8?B?S0lmRjJFVkFFd1VQaGxvUy9hck56NDdMdENrMS9PSC9PVlRGc3JUZFNsbmhs?=
 =?utf-8?B?RnlidlBHRW5yNEUvVHBYblEzZmFKbDgrV2tWY3lJOTdCc0RBL2wwcDZ5Lytq?=
 =?utf-8?B?djF5UExtQ0M1SGlVR2FSK0NOME5Fa21VNXF1VU0yeVhnOEs1OXp2anpRVi9r?=
 =?utf-8?B?NWNmWGRwOEpIMU5Zcm1UODhVL3dENk1JL1lEdUtvUEt5NnJaR242YjZhYXZS?=
 =?utf-8?B?SmlmRmpHTGZpcGN6ZHFWS1N4ZVpSWW84M2pvQkRRWGhid3F1c0YwanMrTC9U?=
 =?utf-8?B?K2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	xfV0xHuJBFVzUWCgfqkDVkUr7nUzlUwgFtJbT9ttNiih6XZMOL0iEHuZiLc7EyMxiPc3TVcK8pFM7pm9Ct0dPYXWAuuhFY8SdJLeMP6JVZkYJdLw03KZJCA+N5Va6rbpcOh/UNtpUb1iMsuAQytd8Y56UlfCfOAEKUVnzlnao5BfRcw8sE9Ok6xI/Bm5mRJWkha/L2FbdJIn6g+HoAevq1tn9cSrmT5VEulaEvHPaB8HN5ZAzXBA1NATdxZ+L7pRanOLnmRMEP+httPbR9CVOKLAhn6vjdRU4QQPjnsO7I0TVUZ+CphKy8kAYaHcSpi9b6SH05r4k+GTJ82u3LHrfcR5BcFOaB/3UojeDC4psr/zHG8R5DTLR5bK91aYNa/NqDubiZ5LzHh4zeUZaubAO5h8bgIivBPMU1PTb78S0M20mHe6S2X1rqzmEIkjXkEzJl/jvAX891Tje3vRDwejGid8XEUI9UjcG5LVLAnT6fQU4y29gb8OnniQdv58yqQn+zLo4IXb8bNYp3uVuQUbNWHX15Jg0QC6Vmh7pwMWe5xw43AZ+H8ADErF7SIw3CvctuNQNalZbJ4AW4tO3lms7EbfZ7DRncLSKrAmhz+mKq4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b105009c-4860-4dfa-d4c5-08dd3c83e813
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2025 14:32:18.9920
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aX/hjYP5fj0AWUhoz3luBuH8lKJbpFJfyvZhv3GyYDBg2k/2xm2EFcjILDUdKiCfLShiqU1P1Qdym+8B4xlp/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4137
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-24_06,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501240104
X-Proofpoint-GUID: m_QpD9q2jooqNON-F5RJrBuQdgWNtLED
X-Proofpoint-ORIG-GUID: m_QpD9q2jooqNON-F5RJrBuQdgWNtLED

On 1/23/25 3:25 PM, Jeff Layton wrote:
> The current error handling has some problems:
> 
> BADSLOT and BADSESSION: don't release the slot before retrying the call
> 
> SEQ_MISORDERED: does some sketchy resetting of the seqid? I can't find any
> recommendation about doing that in the spec, and it seems wrong.

Random thought: You might use the Linux NFS client's forechannel session
implementation as a code reference.


> Handle all three errors the same way: release the slot, but then handle
> it just like we would as if we hadn't gotten a reply; mark the session
> as faulty, and retry the call.

Some questions:

Why does it matter whether NFSD keeps the slot if both sides plan to
destroy the session?

Also, AFAICT marking CB_FAULT does not destroy the session, it simply
tries to recreate backchannel's rpc_clnt. Perhaps NFSD's callback code
should actively destroy the session and let the client drive a fresh
CREATE_SESSION to recover?


> Fixes: 7ba6cad6c88f ("nfsd: New helper nfsd4_cb_sequence_done() for processing more cb errors")
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>   fs/nfsd/nfs4callback.c | 27 +++++++++++----------------
>   1 file changed, 11 insertions(+), 16 deletions(-)
> 
> diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
> index e12205ef16ca932ffbcc86d67b0817aec2436c89..bfc9de1fcb67b4f05ed2f7a28038cd8290809c17 100644
> --- a/fs/nfsd/nfs4callback.c
> +++ b/fs/nfsd/nfs4callback.c
> @@ -1371,17 +1371,24 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
>   		nfsd4_mark_cb_fault(cb->cb_clp);
>   		ret = false;
>   		break;
> +	case -NFS4ERR_BADSESSION:
> +	case -NFS4ERR_BADSLOT:
> +	case -NFS4ERR_SEQ_MISORDERED:
> +		/*
> +		 * These errors indicate that something has gone wrong
> +		 * with the server and client's synchronization. Release
> +		 * the slot, but handle it as if we hadn't gotten a reply.
> +		 */
> +		nfsd41_cb_release_slot(cb);
> +		fallthrough;
>   	case 1:
>   		/*
>   		 * cb_seq_status remains 1 if an RPC Reply was never
>   		 * received. NFSD can't know if the client processed
>   		 * the CB_SEQUENCE operation. Ask the client to send a
> -		 * DESTROY_SESSION to recover.
> +		 * DESTROY_SESSION to recover, but keep the slot.
>   		 */
> -		fallthrough;
> -	case -NFS4ERR_BADSESSION:
>   		nfsd4_mark_cb_fault(cb->cb_clp);
> -		ret = false;
>   		goto need_restart;
>   	case -NFS4ERR_DELAY:
>   		cb->cb_seq_status = 1;
> @@ -1390,14 +1397,6 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
>   
>   		rpc_delay(task, 2 * HZ);
>   		return false;
> -	case -NFS4ERR_BADSLOT:
> -		goto retry_nowait;
> -	case -NFS4ERR_SEQ_MISORDERED:
> -		if (session->se_cb_seq_nr[cb->cb_held_slot] != 1) {
> -			session->se_cb_seq_nr[cb->cb_held_slot] = 1;
> -			goto retry_nowait;
> -		}
> -		break;
>   	default:
>   		nfsd4_mark_cb_fault(cb->cb_clp);
>   	}
> @@ -1405,10 +1404,6 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
>   	nfsd41_cb_release_slot(cb);
>   out:
>   	return ret;
> -retry_nowait:
> -	if (rpc_restart_call_prepare(task))
> -		ret = false;
> -	goto out;
>   need_restart:
>   	if (!test_bit(NFSD4_CLIENT_CB_KILL, &clp->cl_flags)) {
>   		trace_nfsd_cb_restart(clp, cb);
> 


-- 
Chuck Lever

