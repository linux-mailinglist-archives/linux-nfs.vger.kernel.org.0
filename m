Return-Path: <linux-nfs+bounces-9908-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0C2FA2B14A
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Feb 2025 19:37:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F915163897
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Feb 2025 18:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BC8619E971;
	Thu,  6 Feb 2025 18:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Vf4e4o7I";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YGfviPaN"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B951194A6B;
	Thu,  6 Feb 2025 18:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738866829; cv=fail; b=rY8hQYccvmWimovOMyhpMHF9BGhgXlWveu865ea+U9xaABimeYTXKMuqRES0jnZJtrEW1QjPfb7j5690Llf++CZws0f/T7Z2uuibhBVUnseRJF/3S0ZAcmcDVL0yUtAa5qs8K6hqEsG91RnsdN0H3rrg9SYfviWOBgEhyp7oXI0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738866829; c=relaxed/simple;
	bh=eKEzO1Dd1sHRow+bR+XRp9duRinHz2mfuAVB9qEx0qQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=exB0Pz8smC1b9kEr6QViWWR1hmQtkj40YAOF0qkhOC3j0nKKGgJCOskdvKehKLiW5obd1jb5wUKvm5RYla8plpM+6jV5M45OWaV5kUKKNEvFg/LnzyxCSbpa1kk6S3F8HxArb564lEGIWpcBr0aAcTaS6t/Jp6+cBG5k6D58BeU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Vf4e4o7I; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YGfviPaN; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 516EB1gb028568;
	Thu, 6 Feb 2025 18:33:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=b0fenm+ZC6gPGm4GYDvoF8x6TsznJW8ObQVK8ttxWpk=; b=
	Vf4e4o7IY10d814l2c6JcszJu+YGYUvpIHRg+nZFPtuJOmuQvCKO69HMC/b14kf/
	HXpnffv7qk/M/kYhzdSE6IOpeEejAjS3AjjWgrmfeqOrP9Tjp2UYy8LSRVREAZ9x
	ZSph0sJhjB2T7QeQDwsl0zLEfH2RHLhg99gHuma6gdM4dmosQdU0cHU3Tlbe+fnr
	FqWG6zJLqlHe4djS1JQn3pOUIwOhhQCUZPapzsVF04E3KBxlGXQPHuSV/XbF0TsQ
	PEttuMq22Bth1kmgiYQCEdGiNv10/0i9LgYgNr4pesm95IE3rqqWoK+PWWy9r1/F
	Z/eiQS511uyJQk+9pDwCoA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44kku4w6sx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Feb 2025 18:33:37 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 516HUOCY027958;
	Thu, 6 Feb 2025 18:33:36 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2045.outbound.protection.outlook.com [104.47.57.45])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44j8dqgmck-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Feb 2025 18:33:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zhd/zi0XRUaLQAaZiEKl6GgrRTNAVTUT4XmEEV9vkciXm+Nr/zZZUl9g7I+gD4FuZ7UeLDNtgsew7olohqXPxQG3UdJmkwYZfUfyjuTwoybax1G1tUQWnKbwyxUsHeadoYcA7Ad3fMYFcor3MQiScXWOALxbFDESG7l2sKoXZ0HfRRbjEc4/3zykH5/ucfBbLqssOKnL8ihZX5bDhtpSRVrq5UE5W8oJtx6EZLbZtpMpMStl9VgJPA8Y4kMr+H6ntxN72tr9nxpIO1rnkg0Zzh70QYDdaETD7Vj7pAOU2jIU/hzmno8iY4GzdCEAr0kejBBZpXsllE0+i0lr/BVpAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b0fenm+ZC6gPGm4GYDvoF8x6TsznJW8ObQVK8ttxWpk=;
 b=qU7Cy7bSRvUO7n+p5Ae5Vpt9BCbSi/X2FSrRG/ldwvTpd66sPKZ9Dia6Rg3E6K/vKGEHE58x/oBpYsXc7HvuXuRI6bHkeqhoCmDMPPykWzlpOCWwbR5+x02f1tfv0G0LIy5ly++Pc+VG3IfjnQ6in6axmF7503ZaAYgD99pUIhL2pQbW/LEFOaErPBtxi+nUBHcZ13JLW96K6PMF97qr2cMp1Mn1cLXtGmdR8n2KOGMWV0mp6fDCAk4rHNo+d5hq8Of3l+sQlGbXWik3SsfRYUSuBcSgdOjyWQeR+jpdI8uLVPxFA7IOhSebwVK9IRHwtaEyeQGPN2eKW5EDmCll3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b0fenm+ZC6gPGm4GYDvoF8x6TsznJW8ObQVK8ttxWpk=;
 b=YGfviPaN7yD15YECM9SlcHE2drN+ZB85r8R3IObSGgEwV6FGstEokUouGDb99Do5IbeyDdPpkBJQHc+AsWzIMTZLywoc1c6PUSOH2AH+qtxc7e6jL876bhhxBNjiaIz3koCgzKVx7jm4m2nghvlEo61B2WMpHuFBruYQPPqoUHI=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH2PR10MB4232.namprd10.prod.outlook.com (2603:10b6:610:a4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Thu, 6 Feb
 2025 18:33:12 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.8422.010; Thu, 6 Feb 2025
 18:33:12 +0000
Message-ID: <b3abd065-ec91-4c1c-bbfb-6a9b5e44d9d4@oracle.com>
Date: Thu, 6 Feb 2025 13:33:10 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nfsd: don't ignore the return code of svc_proc_register()
To: Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, Josef Bacik <josef@toxicpanda.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzbot+e34ad04f27991521104c@syzkaller.appspotmail.com
References: <20250206-nfsd-fixes-v1-1-c6647b92ca6f@kernel.org>
 <d6ecad5f-b2a5-435c-9209-d784a23b013c@oracle.com>
 <232559042f0d52a858d02273a047a52282597d6b.camel@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <232559042f0d52a858d02273a047a52282597d6b.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR07CA0043.namprd07.prod.outlook.com
 (2603:10b6:610:5b::17) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH2PR10MB4232:EE_
X-MS-Office365-Filtering-Correlation-Id: f7053ff1-de43-4a2c-ac25-08dd46dcb641
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bnhsNVkwZHArRWdMZDJPd3MrVGpIaFN1S2FQN3dHN1ZxbEJRamZOM2NuTlhv?=
 =?utf-8?B?RUZ6d3dCR0RpNFo5b2ZrQjJRQzJpWHA5ZjZNamIzYkdYS3lpU21oalRqREF5?=
 =?utf-8?B?TmlEMG42MFpwVWhMRnorUkt3T2tiY1pFbWhIbTdTTU9ITzhOaXRCc3Y5eGtL?=
 =?utf-8?B?NVR2MFloK1JHTzM3YThQMDJMdDViYVRFNjhVZnM5RXBRTkUzeVdUWEl4NEJ4?=
 =?utf-8?B?VUVTR2Q0alVOSjVzaVY1MHhWbXJ2K0JxL3JFYUZodUxSSGZ5dDU3TVc0enR2?=
 =?utf-8?B?L3hhSjNENzFvM2ZtK0dpV2FOL3ZlY2lHNmZoOFRSdkFyQkRXK3BqQWhNdTNv?=
 =?utf-8?B?N0k0eWIvc1l5a0V6dDlhaDNncCtrelVKT1IrdFNaaStxNm9lTWlTZkxhS1pi?=
 =?utf-8?B?Vk9leGU0WUVaTDlrSWRKUXNEWStkQjRSSGJOa2lCakVJQW5xUmw5NUVUUDlK?=
 =?utf-8?B?T1V2cWJMRFMxSktoM2Q5UkNSMWl3UUQrME94Um5mUjRSaHdRZm1rcXF6dWlP?=
 =?utf-8?B?cnI3NCtydENHeC9TRUozV2pHZHJURjRYVWZQdjBjbWRhRjNrSW1ieXh1YzlH?=
 =?utf-8?B?ZHhFa0d2eXdhNGoyeDlwSzk1ZzZ3RGhza3VHK1dnWTE3b1F5QjFZemQ2YjBN?=
 =?utf-8?B?VmNQakpyYUpEcWNzMmtXSUxhOGZqaU85di9XUk5Fa2FRd2xmL3ArVlFsODVp?=
 =?utf-8?B?dHRSSHhEbWpsc3YzU2xjMHg3aCthanJrTlFiNUhHQWVHQ1ozUFc4RHErWk5F?=
 =?utf-8?B?MmVqVVVwZEtzVUZCQXloVUI2M1FKZkVXdGFnVFllanBpaE5nV0VqMllrU2hr?=
 =?utf-8?B?TnJQNENWa0xsdXRlZzVIbWMycWdlMFg2djZyTkFZR3RwMS9ROFlxVW9IWkc5?=
 =?utf-8?B?dlBLLzFlTlljR2pOenE0UUtTWVBIMU9CaWhGbFV5aGJqRjA4L0JTSjhBTldL?=
 =?utf-8?B?R3N5VFNVZEhnbFNnMXp1SnN2TkowVy9xNTZJTTBDZk1YMks5TkZDbDVENnZQ?=
 =?utf-8?B?RUF0TVFFbFQ3UTZzTWdXU2xLb0dKb2FTU25NWVFPQk44MHpZQURnMy9ORDBz?=
 =?utf-8?B?SmpBMlIzRUFHRVBsR1VneDhYaG00Um9MUE9DK1dIRC9zaGlOQ1c3VnYzeGJk?=
 =?utf-8?B?YzNEYWY1dTJFSWlrNk03b0dIOXNmK3Q4QjNVQW5RenZzTHd5NTN6SWpITUFR?=
 =?utf-8?B?bUMwY05VanRNY3YwUE5SeUk3OGdCelNhOHQ4aysyelFQRmFpYUpOY0MwRjVi?=
 =?utf-8?B?cEpZT2MvN2F3eWFBRjJWM3VZNGdhRzhVWGpaeEZ4OThIcFduMVRQcnU3M2JW?=
 =?utf-8?B?c2RzSGNBWkZrWXg0RFpkV3loYm9QTEJheWp6UDlWRysxSkRvWm1TNk9UdFJZ?=
 =?utf-8?B?L0h5Y3FHMzJoK0VmcW9vSWdraW81K1l0cmNCRVd0TU9ISEVNbEJ3aXFWSnhQ?=
 =?utf-8?B?Qzg2blUyRHo3V1REZ3VqVlJIUjRTMUVxOEFaYU1ERWR1a0o2cHpxa05oNjQw?=
 =?utf-8?B?QVEvTDA3S092aDJQM2RqZWhZcHhwbFlTTjJsMVIwUFpYVlRSTFlpTnllT3ox?=
 =?utf-8?B?WS9rRmVVQi9qTHV1RlFrN3Q0SmVuSGpzZXZ2V1AwdEprS1oxcmlPNTlVTVpK?=
 =?utf-8?B?RmxHTXJIb0tmYkl6VWg1VXVOUThtbkM4NHgzRFVWRzJ0L29uaDd3cS9KN09r?=
 =?utf-8?B?TFY0azl4OWJYWEQ0cnN2bHg3VmVNT1lMczhKamU3T0lEcXF4dE9uVmxIUlpx?=
 =?utf-8?B?YXFCc0lRc04wWnc0bFdWM0lSa2pDdTFPNjJLUlhmK2FhWHNMTTNuejY4cnl1?=
 =?utf-8?B?dHl0cjg5VFFydkNTdnVtdXBITGZXeGJwUnFSZ1F3N2xQMHhGeUZpei91eCtR?=
 =?utf-8?Q?4pU/ngUVWkUX5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ckpJQ3doSmZCbjZybnQwVUhNQThFcklxQVZaVXZnN01kcTAremdDTkxDVm84?=
 =?utf-8?B?YXJFY3Q4R2g2N1o2am95TEgyeFRaVWZFNXdRK0JiNVZWYkh3L2FhdDk4RHZy?=
 =?utf-8?B?N2pwU3hkdFVSQ2VXQ3BrbDVLczIwZEY2Y0s1cE9KMDQ2cHU2enNabmNoWGo3?=
 =?utf-8?B?a2hacEFYUlRPZFdPTm00b1FYRjR5cUNJWHJFeXptM3c2WXRkZTk4TEhEZHIy?=
 =?utf-8?B?V0djYUVRbUY0U0VRZUdUdEI1b0tBY3orZnhvR3Q5THYzamlpYkdTUHlHelNy?=
 =?utf-8?B?UlRqL2FXQjVIK3F4YmR1TUd2U3F3Wk1VQ3MvSWNYL25aaGxMR3VYbzN3bE85?=
 =?utf-8?B?Z3ljZ1ZLV3hlTW5DVDk5VVBKWlNBNmdNR1YwaHNIVGhGVTdGOGswaVpvSG5X?=
 =?utf-8?B?MUhFTC84VGI2VFFmOThEM0JyYXMwczR2dUJJV3Q4cjN2K3RXQ2JHQ1ZLdmtB?=
 =?utf-8?B?b2w3NEkrcWZqQjE0Z3p4K0NEUm8zcGhJdmpnQXF5bHRKbXFLdGhSMTdnUlhn?=
 =?utf-8?B?UEtRMzFCN2I2aFcxeUtLZ2pEVFFIeDY2NUNqZkxDOWIxY0xJZk0vM2hOTGtX?=
 =?utf-8?B?ZnpZeWsxNmhjVTlPRExrS3Y2aFpiVFl3T2FxUnp3UENVek8rR1NweDgyanYr?=
 =?utf-8?B?N2lLUkZNUmQrdFNBRmYrNEI1TVNNNVY1bEIxeS83enVUUmsyVkdyRk9XQVBk?=
 =?utf-8?B?VUgyWWdVamkzUmttdk8rVXR2RmtPTU9ML3RrdCs1UEZCWEV5SVE2VjVYcnN0?=
 =?utf-8?B?WlBDaENhTHBIeXdncGxSMktocU1zMHpFMTlhSlJOVjE1R25yWnU1Rmt5ZUxk?=
 =?utf-8?B?NGZtRnUwOHRtY0VSVjRyaUs2RXNtNU51cFZPUHlabUNNY2YreGtodWROZ0Np?=
 =?utf-8?B?T1pRcURlOXdsdEVuMWloT2VWb0t4OVBNZGNyWm1IR2NFNDJCVmczVEMzaUE2?=
 =?utf-8?B?YWcwLzJiV0thMUJUTWRSSEJjYUl0a2srVXhPYm1NcktuV2NzT3BDc0tWUTJY?=
 =?utf-8?B?MDBGY1BYTlc3NGVCYlFpVVJOUkFmNzRnTVRjQUUwQ05VQk45c21xYU5OaGs3?=
 =?utf-8?B?NzRHME4raXUrTkZHa1VLT3dWKzVWY2VjbE9qRmx3L1VnZk1DMEFpUmlwSlFO?=
 =?utf-8?B?ZG55VW9peEp6eTNBTmxNWUJCeDY4aDh5VG45V20zUzJIbmZlZ2ZtaExrZWQr?=
 =?utf-8?B?QUE5dk15NDZDS0pGcWJRbnltam4wK2FZazA4dVZTYVBRUGtsbWxxa2dlVjdM?=
 =?utf-8?B?Q0JHUWQ1M0ttWWxadDNJSWU2TnlwbVg0RjVmS2hubkRnTWVnUTZyTFk0VUpR?=
 =?utf-8?B?QzRhVGRSZnpCT1B4aTZ4WEtYMWFldWlZdlNvajlaYktpYUhIMUhNSTI2emR6?=
 =?utf-8?B?ZWZkT2RiUmZGSlRNSTgwVUlKdTdwVm9ScVBSQ1orQkNoR1NYdWJiSVBFNUxy?=
 =?utf-8?B?S1Vua2ZlL0NoVDV0VXFwb2QwLzBEMWZIaFc2cnh4dVI3YXVIc0F4bVhUdjBk?=
 =?utf-8?B?cXhVU1hXNXZCd1pYZDJrSG50Ly84bCsvWk1QeUYzOWZnQjYvRXEzbS9aWmJt?=
 =?utf-8?B?Qk5sVnArRW5CZVh2ZHZvaXZmUGFDbURjc05CYnNISDZOaFhJRXB3clVPaWxB?=
 =?utf-8?B?RWdaSjNGQTdZTGxBZDdaWDNhNGxTYjJlWlBSMTN5TXNqZ1ByZW51YTlqeXNt?=
 =?utf-8?B?YklyUDNndG5ZZ1VJT0dYTDdVMnZQVXpiRTQ3ZFJ0NFpsbENha1lJWFBwLzYy?=
 =?utf-8?B?ZjcwZ0xweFJteTBlQzhYeWNZaGNSWUtCQnlrUUNnUlM1cGNTQytJcEh4M0pm?=
 =?utf-8?B?UDZ4ZmxaUzBtVHFRNEg5cHQ0QVcxR1h5OVFNZ00zdlFiN1RYVmVDT2E3Skkr?=
 =?utf-8?B?TklDaklHQUJMMVNQTGYwcllBNXgyZVhpdDY1MnZxK1NJTXBUclNYd0l0OFNu?=
 =?utf-8?B?dXhJTjkyQ3EvWHJWeXJ2eHBBVjhsYlY1RTJjcW1URCtDVmlVdmlBTmxEZ2Zw?=
 =?utf-8?B?VTZRQXNnazk2V0hyWERqZmJ4ODA2R3FTM3JsRUhvbTcyTFhhN0svUDA5R2lX?=
 =?utf-8?B?MU5sbzF6cHplYTlmSDRNTDVYelFUa0FXdUNaaTA4bUFHWUEwb2lQVTM4S0lD?=
 =?utf-8?B?WktEQlI0REdVL0x2YzRDdXdPSndtSm40Zk4yRk1JMFg5TDFpdGRUMG1YODY4?=
 =?utf-8?B?Mmc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	7BMecqJQncbdSVFmhUcDNF+829Z5IQzZiCGI4L+2p0n9rpD5GmiuBdHmmlbiJlLMwS6Bfh/Q6cY2B6Bij2UIoUTMUiLRdHBcn2ko/eXOZTnt5g+vlsHJke1jEULZlDhTQNylZFVWE9fOwnFFQQ7LNfGwjZET27FNvxVbWg0NR/rV3iDexw79Ie9gShG1r/e+WSRA8dO8IRP00PJsrPyBNxGnwvKjzZE2e66i84zERqDUDgoxHrNKY6QN75C1mJNEdXx1QMo5dPRsjsjwCLSTuebldpE1JgPUFmCqJOsaxE+pkXet3wG33/q7iiU0c75PEKX/6ROYbcB21lY2Ig7A0NroGUh54b0iwivJnjPfdjcAVsR4HAldPDTYbY5xlfCokYqcg2UMn+/D+Xba/DaO46LlNzcRieQHaNoWVBh1KeuL1rjLQTkIQbobl9G/iLmovyTaXX1snmVHoxuccO/Zdzot1EzmsfS0mo/3PEKqr93z8o5Cv5BAHICZe3+avJjRBe5wwLzo5eVzcY+OOlQuCFrSct88Z9AAqgKHlF/rBEpmXRvba0/KBTSFN1flOhLc/7AAi88hmSujR9BPI2vxF6EOd1SKuBnskb65vekxdg0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7053ff1-de43-4a2c-ac25-08dd46dcb641
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 18:33:12.2338
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2ty2j85uorg1uoC109gUwBsAt3LrLdzOOXTWbMsaWE5YHMQ/AdhlbemYGasEr0QMGoXe2bnIV/ov+QAZOIGyfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4232
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-06_05,2025-02-05_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2502060149
X-Proofpoint-GUID: rdbumQeFQgT9EEX3ew9Psv9CZXS5K-EM
X-Proofpoint-ORIG-GUID: rdbumQeFQgT9EEX3ew9Psv9CZXS5K-EM

On 2/6/25 1:29 PM, Jeff Layton wrote:
> On Thu, 2025-02-06 at 13:17 -0500, Chuck Lever wrote:
>> On 2/6/25 1:12 PM, Jeff Layton wrote:
>>> Currently, nfsd_proc_stat_init() ignores the return value of
>>> svc_proc_register(). If the procfile creation fails, then the kernel
>>> will WARN when it tries to remove the entry later.
>>>
>>> Fix nfsd_proc_stat_init() to return the same type of pointer as
>>> svc_proc_register(), and fix up nfsd_net_init() to check that and fail
>>> the nfsd_net construction if it occurs.
>>>
>>> svc_proc_register() can fail if the dentry can't be allocated, or if an
>>> identical dentry already exists. The second case is pretty unlikely in
>>> the nfsd_net construction codepath, so if this happens, return -ENOMEM.
>>>
>>> Fixes: 93483ac5fec6 ("nfsd: expose /proc/net/sunrpc/nfsd in net namespaces")
>>> Reported-by: syzbot+e34ad04f27991521104c@syzkaller.appspotmail.com
>>> Closes: https://lore.kernel.org/linux-nfs/67a47501.050a0220.19061f.05f9.GAE@google.com/
>>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
>>> ---
>>> I looked at the console log from the report, and syzkaller is doing
>>> fault injection on allocations. You can see the stack where the "nfsd"
>>> directory under /proc failed to be created due to one. This is a pretty
>>> unlikely bug under normal circumstances, but it's simple to fix. The
>>> problem predates the patch in Fixes:, but it's not worth the effort to
>>> backport this to anything earlier.
>>
>> I'd prefer to document this by labeling the actual commit that
>> introduced the problem in the Fixes: tag, then using
>>
>> "Cc: stable # vN.M"
>>
>> to block automatic backporting to LTS kernels where this patch won't
>> apply cleanly. I can derive the values of N and M from the commit you
>> mention above, but do you happen to know the actual culprit commit?
>>
>>
> 
> Unfortunately this bug goes back to the initial 2.6.12 import into git.
> I didn't look earlier. Note that nfsd is not alone here. Ignoring the
> result of proc_create_data() is very common.
> 
> If you want to drop the Fixes: tag, and add the Cc: stable instead,
> then that's fine with me. Whatever works best.

OK. If we don't know the culprit, then a lone "Cc: stable" should be
sufficient.


>>> ---
>>>  fs/nfsd/nfsctl.c | 9 ++++++++-
>>>  fs/nfsd/stats.c  | 4 ++--
>>>  fs/nfsd/stats.h  | 2 +-
>>>  3 files changed, 11 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
>>> index 95ea4393305bd38493b640fbaba2e8f57f5a501d..583eda0df54dca394de4bbe8d148be2892df39cb 100644
>>> --- a/fs/nfsd/nfsctl.c
>>> +++ b/fs/nfsd/nfsctl.c
>>> @@ -2204,8 +2204,14 @@ static __net_init int nfsd_net_init(struct net *net)
>>>  					  NFSD_STATS_COUNTERS_NUM);
>>>  	if (retval)
>>>  		goto out_repcache_error;
>>> +
>>>  	memset(&nn->nfsd_svcstats, 0, sizeof(nn->nfsd_svcstats));
>>>  	nn->nfsd_svcstats.program = &nfsd_programs[0];
>>> +	if (!nfsd_proc_stat_init(net)) {
>>> +		retval = -ENOMEM;
>>> +		goto out_proc_error;
>>> +	}
>>> +
>>>  	for (i = 0; i < sizeof(nn->nfsd_versions); i++)
>>>  		nn->nfsd_versions[i] = nfsd_support_version(i);
>>>  	for (i = 0; i < sizeof(nn->nfsd4_minorversions); i++)
>>> @@ -2215,12 +2221,13 @@ static __net_init int nfsd_net_init(struct net *net)
>>>  	nfsd4_init_leases_net(nn);
>>>  	get_random_bytes(&nn->siphash_key, sizeof(nn->siphash_key));
>>>  	seqlock_init(&nn->writeverf_lock);
>>> -	nfsd_proc_stat_init(net);
>>>  #if IS_ENABLED(CONFIG_NFS_LOCALIO)
>>>  	INIT_LIST_HEAD(&nn->local_clients);
>>>  #endif
>>>  	return 0;
>>>  
>>> +out_proc_error:
>>> +	percpu_counter_destroy_many(nn->counter, NFSD_STATS_COUNTERS_NUM);
>>>  out_repcache_error:
>>>  	nfsd_idmap_shutdown(net);
>>>  out_idmap_error:
>>> diff --git a/fs/nfsd/stats.c b/fs/nfsd/stats.c
>>> index bb22893f1157e4c159e123b6d8e25b8eab52e187..f7eaf95e20fc8758566f469c6c2de79119fea070 100644
>>> --- a/fs/nfsd/stats.c
>>> +++ b/fs/nfsd/stats.c
>>> @@ -73,11 +73,11 @@ static int nfsd_show(struct seq_file *seq, void *v)
>>>  
>>>  DEFINE_PROC_SHOW_ATTRIBUTE(nfsd);
>>>  
>>> -void nfsd_proc_stat_init(struct net *net)
>>> +struct proc_dir_entry *nfsd_proc_stat_init(struct net *net)
>>>  {
>>>  	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
>>>  
>>> -	svc_proc_register(net, &nn->nfsd_svcstats, &nfsd_proc_ops);
>>> +	return svc_proc_register(net, &nn->nfsd_svcstats, &nfsd_proc_ops);
>>>  }
>>>  
>>>  void nfsd_proc_stat_shutdown(struct net *net)
>>> diff --git a/fs/nfsd/stats.h b/fs/nfsd/stats.h
>>> index 04aacb6c36e2576ba231ee481e3a3e9e9f255a61..e4efb0e4e56d467c13eaa5a1dd312c85dadeb4b8 100644
>>> --- a/fs/nfsd/stats.h
>>> +++ b/fs/nfsd/stats.h
>>> @@ -10,7 +10,7 @@
>>>  #include <uapi/linux/nfsd/stats.h>
>>>  #include <linux/percpu_counter.h>
>>>  
>>> -void nfsd_proc_stat_init(struct net *net);
>>> +struct proc_dir_entry *nfsd_proc_stat_init(struct net *net);
>>>  void nfsd_proc_stat_shutdown(struct net *net);
>>>  
>>>  static inline void nfsd_stats_rc_hits_inc(struct nfsd_net *nn)
>>>
>>> ---
>>> base-commit: ebbdc9429c39336a406b191cfe84bca2c12c2f73
>>> change-id: 20250206-nfsd-fixes-8e61bdf66347
>>>
>>> Best regards,
>>
>>
> 


-- 
Chuck Lever

