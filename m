Return-Path: <linux-nfs+bounces-15237-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE74BD9BF9
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Oct 2025 15:36:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 437E61884A1D
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Oct 2025 13:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58A0E313E2F;
	Tue, 14 Oct 2025 13:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eJSCWgNs";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="z9EorTly"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743B530C356
	for <linux-nfs@vger.kernel.org>; Tue, 14 Oct 2025 13:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760448649; cv=fail; b=S9b84ECvAoOu0oYK8dM3kNNFcYhnTgYNybAG3waulHDHsLL1YDe/modAlPEjVa3BY5s+LjP1Um6o8Y7im1uDNlP8kMrq5zS6dgPxXp38egGyFDeKPKkYVC+S75JalGqkQyvDQ7Uk3TpEnGOGbZuU4/ITETrtJsTaR0z1PFWtMks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760448649; c=relaxed/simple;
	bh=kpd0QFCxS61nmojZP8STWCx3H6BDbAahpJM4XNrcdxk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AZW8b5lEATTBjeUiKjce4lHG5AFP74I7ZxiKUdHI2L+FChOkSWDY6cBycie6ZgufaBqfPt9gn7w+LV0bharp3i0GhiWHWXax5Zttwa6ucSVXWnsWRh2BnAdYOKUl95SD3RN7z3KmMNXseGwnfic6cA24OAO3xOFluNZv8ETiw1U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eJSCWgNs; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=z9EorTly; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59ECu90O013232;
	Tue, 14 Oct 2025 13:30:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=D6JIJ7w8t4reulPa0uv/Omem1j0piS1BJHGItRohgPg=; b=
	eJSCWgNsVafFMxOrFDCnFyCRAa0dJ3C8g2iVO2xpZ7LFwoZUiYLzwcsbtiU50PSd
	ObWhqyQ4fs6Ae/DJvayTHX19nlLj+2LvSblJa0gryNffR8iROQ206LnRwNOUNnQU
	ZaHimtfT6hFd/a6rZRQHA0+VVeqdHWdvSvNZC9OPtBSarfPlGd1lPpeGWUjQbo/J
	cUxsZTsk/x3kDTtsk+yb4+h1x+g5toZVnP2wakWyTIQL5pVlAEa0CpT9BpuA0gz8
	eVsN/kbBNPbUSCRi1zbTJPNdclHS9nXrE0FIdbwC6rzeI/bBYrhaOstPMG6BTRXg
	w6tO/cdwQLTi5l333HUrKQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49qf9bvced-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Oct 2025 13:30:36 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59ECxSA6017196;
	Tue, 14 Oct 2025 13:30:36 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010003.outbound.protection.outlook.com [52.101.85.3])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49qdp8wnrm-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Oct 2025 13:30:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TWXBH7I70qwPngtOWHjgWxpRiRdh0+VISDMacWOssMWLBNuya/r8Pq8JTGxkT1WR8ADCm8hhvqCJ6Uf1GQmidJV4c1hNoJzF1GhnsNU/fThU8l3109BhRUEOAWAKyI9Rui1UrNu3re6BUj3yf0t492L2vnuX5+nXGo1dDrWYS/JcQ8DsEh4ua4YeSAe5hbecdw18YaA3lkplisA3i+CAVHfMVVdsoQGPKg7d49ieIJnLSNrparPtE5E6OAhkocV/cEhCL0YuYIheNFxRtb4lc270+KC5LI9hIkXMRor0RsCC2MBGUc5Q2CRdNT3cKYbqsUFAr3aeWuvkH4NXBH/rlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D6JIJ7w8t4reulPa0uv/Omem1j0piS1BJHGItRohgPg=;
 b=QKAFawlVbrCsftOLwekWoZqaolpxcTwI5Hyk9MtLJzNKQDqXBDJfDK0IvnCCmpeHX/VbNx00hY5ZfXFDthLJYlXXKtceviNUr0pAf+anVz3QoMJIABHWteLkVXjbsvDRiFhAky27mIpUeJELJSxbzv74lD7Cc1x+zyqTZWGd+aH3AOUtqpgWgxIYG93LOLcG4odo8p0KJFo8uCSkmxoy22eoXSJk3riGbe17JpZl9LeOuqWrNISq8qo/cIpqKDvtnUXobCR63WcfwRipsW/T26U9Yns7Y2IFUt/dB5y9vAlETulkabARGIOe8OBh2ADmVdx5/bJkTgLYbGzSlaDOhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D6JIJ7w8t4reulPa0uv/Omem1j0piS1BJHGItRohgPg=;
 b=z9EorTlyrw5vLDl4B6SuVoFNYMsT7/qnm1B9SAO4lBGz/BRK7tkPR5Izg1yfzj0ft79zujrFjH44sqGH1B32BtS0CRGpe3FKmd6dpXCiwcHULp05VU5EW4JPD2aPQHM6LdMWZG4jy9HP87OlQLM8bxVOFkosKi5luksGYovPr7w=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH3PR10MB7907.namprd10.prod.outlook.com (2603:10b6:610:1ca::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Tue, 14 Oct
 2025 13:30:31 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.9228.009; Tue, 14 Oct 2025
 13:30:31 +0000
Message-ID: <54a9829b-3e4e-46f5-b35a-96bd130b3604@oracle.com>
Date: Tue, 14 Oct 2025 09:30:29 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/1] nfsd: fix setting seq->maxslots for replay
 operations
To: Neil Brown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>
Cc: linux-nfs@vger.kernel.org, Dai.Ngo@oracle.com, tom@talpey.com,
        jlayton@kernel.org
References: <20251010194449.10281-1-okorniev@redhat.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20251010194449.10281-1-okorniev@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5PR05CA0024.namprd05.prod.outlook.com
 (2603:10b6:610:1f0::29) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH3PR10MB7907:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c7a04ae-026f-468c-ed0e-08de0b25d8f3
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?bmFMZW5qaG5zU2lXQ3I1TGRJQzhJNE5DU2laeVlOeGRmUVNjOE9nanptZlEw?=
 =?utf-8?B?VWVnMlQ4NUZXY3V1OWJoNmRaaExQMHJDNWs0OVdJclFYVjZIQVIyeFE2ZEQx?=
 =?utf-8?B?ZUZOUXNVdW5MMUNwVm1ZT0xDT1NYUzMwUVhSNU4xOXBXQlcxTFVyRjU1dTlT?=
 =?utf-8?B?NDNBNVlQb09mRkhjTWs1MDZqbjRNZjZlK0hlZVBRai9rcmRKNkVZTy93cHJw?=
 =?utf-8?B?SmJHdUx5T0dSZWZoRkhWc3l1bVIvWjhrYmxlYkh0ZVNuRzRRSG9ydWp6Sk4z?=
 =?utf-8?B?Si9nMXJhdTQ1dFR3WDJiTjVqTm1ycW1tSUNCMEFRWjFLTm5OdGpMZ2JnRlFU?=
 =?utf-8?B?dW91NzcvTHlPQmYydG9BWmNGaERCV3JyLzBXOHpDQm9kWFE0TXYxZTVobFlu?=
 =?utf-8?B?czJiS1BhL1kxdERrMlF6U3U5bFc2WGNJcnI5R1lWRXNDWjhqdEhzUFBOTW9U?=
 =?utf-8?B?OTFZa21vTUd0SC96dHRpNnpMZVF6THg4SzJVQXNVTkN0ajliMzUrZGVhN1cy?=
 =?utf-8?B?Nzl4ZlFzaTN3dmtkUG96RXYyZ3NXUU9tZUJCOUVKS2FJRUkwbXA5T3VScmdz?=
 =?utf-8?B?VVp3N25uRktuaXhIVTVUVTYySDhsYVByMDdVUS9CaUNsOGFRYXBXNmhkVnh5?=
 =?utf-8?B?dzF6bXJDcXdSVCswOExsL21ZNmNRSnVNeTVNSy92NnN0N1dxS0h5S0RTUWhF?=
 =?utf-8?B?N29sZDdob3dLZjhKVnlSMUpIY05KZjN0ZlRTVHdaK3UzdDFJYXVsNTlpM3Jk?=
 =?utf-8?B?Vk1KaHkxaVZqZjZ6ZjFFWncxb3Y3a0xPQWxMSnpSSE5HTDFKSjM3eSt0UFJM?=
 =?utf-8?B?OURLc3FScjdQZzFrakhndGlzTkJxc204TDBQUmR3WXpWSzBhNHVuWXM4Nm9h?=
 =?utf-8?B?SjcrNDNYZm0rcEMyOUFLVWl5eThZYnR6dkc4QzR4QzdHdkQ5d1RlMnYwUmFO?=
 =?utf-8?B?MlNsYlFxT2RVQWIxQXpTdU1hNktTVElvV2FNSDB3c0x6eTlyZFlFQ0RQZGZQ?=
 =?utf-8?B?cEF0SFF3LzBYODNQNUxNcFlWM3BnQ1hsS1RqeUpCTHhyN2lVb0llQzdTaHVR?=
 =?utf-8?B?NXBMZnd3UWMvSnEreTgyeTJ6NkJUNVBHY3hrQ2JlL1hIVXFBckhTVW5DMDRO?=
 =?utf-8?B?VUZ6S21mbVp3ODlGWWZSQjhqWlBLeDdnQ1loNWhWRW9ZZU9XZFh0Uzlhdy9Z?=
 =?utf-8?B?aE51dUxBZ2MxK2JOdi8xRU5ocS9KazBrNTAwbk5CbTZLS2ttR2VPeGFJRlln?=
 =?utf-8?B?bENlaU43VmZVUFNabFNHVitCa0x3REFuZW9wWXRVUHVHYXNCRHZJS0x5WE01?=
 =?utf-8?B?b3YvdEkyT25IOHh0UGFTNFFrL1d0K1BwSVdRaklKbGVmZWhQOEtlVlRBZkxC?=
 =?utf-8?B?dG1ia2YzMklCejFKOXdzREcxWWMwWVdVN21zVm9pbDh2OGNFMnlYY29zM1VL?=
 =?utf-8?B?MUFxV2xYM09vWVBEa2tXR3o2K1F3ZStKMmdoTGhBbGJMWWNXUjVPQnIrcmQy?=
 =?utf-8?B?aVF4N1Q0L0cwVDNpUTdLamtwWU80ZFErZFgxaFBvS3BSZXFaZDhkSDVuM2Yy?=
 =?utf-8?B?UWgzS0RBODF0aDkwK1NwL1F1UnJJRDF2M1RjRmRPeklHN1p0YytOSkpBVjF5?=
 =?utf-8?B?dkljRVd5ZDcrS08vNWpudDhnUFNVbVBjTDhpWDhSSTRPRVY3bk9uSlBpOHBE?=
 =?utf-8?B?dDVSZEJsQkp4eERhcnVmbFFCU0c4clZZZnk3WmtlRmVaYXY2ZUM3amt2S3V3?=
 =?utf-8?B?WVZwOTJnV0xudkt3a2NxWDRWMm51RXUxL0hkUGl6UUY0TWcyOGJiN25VYnF4?=
 =?utf-8?B?R0VoV0hOQUFjbXhzdDlJU0NtK1RQQlE1LzN2S3plVWduVjdVSGJvaVVzMVdR?=
 =?utf-8?B?b3Q5VVo5RnVVNEltNk8yNjRCajR1WWtQNkluVFF1SVlYQ1hLaXZ6OGVYMW9o?=
 =?utf-8?Q?6xUHb93S2yKJBfdu0VEZqPLlHDXqRi5D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?emRsMkNwUWhPeG1hVDhOK3l2QWNEbjlzbXpuMlQ2M0hUTDF3Y1FBMGdSbTVv?=
 =?utf-8?B?TitobE5idll3TTNUT0VFNWNSZkRHcGZIeTJkWllFNDZ3ZzdnL0YwR2p5bjZP?=
 =?utf-8?B?S0M3TTAvSHd6MkZDQk1vREdOYmttZEdUcVI5a2JoYTZLYnk4WTlKRFBlZVV4?=
 =?utf-8?B?YTdBbDZ4Zkt2dk16WGRtTWwwR3YrTVBOUENWNmsxRGx0cG1XTGtjak9ycHlP?=
 =?utf-8?B?azBZUW4yV0FocjlJb2YwZHY3VkoyWGtBRU1QbUtVVHdTTzFjWTkwTTRmbGRW?=
 =?utf-8?B?bGw4TVZIYmVOVnFoci9sa3NPZ1BMVS9jZ1lZL09QbXYrMVNJeElNNVorUUZU?=
 =?utf-8?B?NnJxcThGTnF6Z3hCd3ZpcTJUVlQ3eUw0djlSeEFGZk1FbnB2SVk2NXZzQWNn?=
 =?utf-8?B?bFM0VWZ5b2ZaZWxuaTZvS0gyMFhzODh3cFJIaTFhaXFLUnRjZktHcEF5NllJ?=
 =?utf-8?B?RjdOejNjNU9VcytWMHdYc2ZMcmplZHhPMks1bVVxUTFGUEtVcDFKMGEydW15?=
 =?utf-8?B?amJsWXVQOWpaaTF2a1B5bG5taW9SOVI3S1FRWDV0TDVmc1h6NnpMRFF3czBz?=
 =?utf-8?B?bjlFb2J3Tm8yMG5xY1ZmVlRmZG5FdWF5UEhpY2dJWG9EN256dlNTUGprbExK?=
 =?utf-8?B?eDZHS1hzWEtNZDdRcHNGZDlYK1Vqb0RTK3pvcG9ZVVROTmQ5RzY5b0RERGxo?=
 =?utf-8?B?Q0NhckZEUTRCY3l3aFVKL1NPYmdZR2hsb3h6cmI2TUJ3YmVnRXQ3Y1grM1hT?=
 =?utf-8?B?SlRSb1pPQks3aS8rRkIvS25NYmZmdjBFZFJ4dVk2S3N4UXljbDlzZGFheGg0?=
 =?utf-8?B?bTJ3QTJRVG05V3J3dFI2MmI0V0dFajJDNXNFNjViaTd2bWZneEtRY2xnMm5T?=
 =?utf-8?B?R01DRWQ4SHp5eFQzdXQzSXVDbDJKbnlobEFzOE1sV3prcnZteC9qYmdpV09y?=
 =?utf-8?B?WlJMQWpqa3RkUjdyQkVic280T1M1MlhxSnVrOVBxcnhmdmNOZTFtb25ISFVj?=
 =?utf-8?B?RWRxV1ZOcFBKcjFacFJmSFk3VkN2dkRKNVIwanBhdVdBd0J5d2pTVmxTbmZw?=
 =?utf-8?B?WTducnN3ZWR4TVBxOHJKRk1KVVJDTEJEQU5pL3BoZVcrMjdKVHlHKzB5OXRR?=
 =?utf-8?B?Q0FjcDFuYmh1RFhrUUE0MWRzMnNxUXFtMyt1dUdHek5kQlpQa1ozdmpkMEtC?=
 =?utf-8?B?R3pEbjdhQTdlTXR3c1A0bmFULzZPMWxpL2tHcm93UWtJMzdRcGFFZldnOWRR?=
 =?utf-8?B?YkZDVlRoUjdhVXRObnhPWXdGT1hNZzRDWmVidFRBbjgvYjY2YkZDanhNbnJS?=
 =?utf-8?B?MkJqTDNjb1dIK0tpV2dqaW82WlBDVUlyRHRZVzBJZUppTVdWT1JYTzNOZThx?=
 =?utf-8?B?Y1h4dERydVAvZEtmQWpEUTJienNQVnk5V2I1SmxNYnF2SUp2R2NNRWdKQ3ow?=
 =?utf-8?B?QTZQVEhqN1I3NUhEeXczMHQvSVFLRGtZb2Vud3VnZU9qZGtCWUh6NlVzMFA4?=
 =?utf-8?B?dnZ2RWpFTDdjQjdFNlRRSWJHMHpKa1lzS3V6anFRTXQzREpRai9EaHU2VSt1?=
 =?utf-8?B?QjhidFpBOXc3QXdRbjlaL0dFR09TMjhUVDQ2QnRWNWtaeTkvYUs1dGZuSjNF?=
 =?utf-8?B?OGplRXhvaHpnTDFSb3lBSVhDZStZUUFWVzNqNXdGZHlDTFprL2MyaDRVRVdt?=
 =?utf-8?B?eUtvVU5rYVU5TWFUVnM2ZUZxclhoZGVlaHROSlBKblM5LzlpRVJQQ2F4TnZq?=
 =?utf-8?B?dzkxMll0SkxtT1FMb2FRVWVEM05KNVJSN2RYa1UraU1xbDNwT2crKzFxS0xs?=
 =?utf-8?B?Z1MzM3BRSWczTkp2ZE5lcm1tdmtNeUgxZ00vMFZtSGg4S2R6MnJ1UTlzUG1m?=
 =?utf-8?B?TWhkMmRtaDg2dGRVWjFiaWZlZWlKQlN1RCtNRkx1YU0yUCtueTJ1dndKQ0ZN?=
 =?utf-8?B?YzZISE4raWFWSmpMRUh3ZVNVOXovVTJZVXlZNDJCenBLcnRJRXZWajdHTlNm?=
 =?utf-8?B?WGpxRmJ4bGtMQXdQdHhXZFNiZ0JKa08wZy9NRTFkYmhKRmhEVnA4V0xpQUZE?=
 =?utf-8?B?bm1Mcm0ycXg0c2V4SjlYL2dhZFlQRzI3ZG1MdldRd1dOaUx2Uk1ieFVlNUwr?=
 =?utf-8?Q?J6EYCd1G3njK9g2O2rk0nVWLp?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	oiKZ3IrnPyyxHCyQt1XM1Lfr9ZdoMG/ZuUDNvr/kvamvn/Kzo1dCiMblnm2inXtnAArUkBojGUpGUYB7iDam5/uXV2vkSUlxJg+/LPZVmgtvs8Qlf7suY7fe1LH/e/tDM482nuJlWogKcYtZJH7CfcjTcA53lhhr1XzYvdn2FErIsn3ed/cJWC/EvpMc3E4BzqshGrbDl6DrXF7p5tPzF49cA9WIKxEE1FncaTLDonBTuaThxa8be50FrVBdig0ckS6P8420EV71a9mMYGAj376vryeZXvuXlvjFVzzUlX4jN6C7udmXwQmRV2lQeSLNPqcltvjTHtFq3OrsdeLThwmNJlji3PPQ19a3Lsmmh1QOAlF0dQpmk9giVBMi+cV9vzypZTzscZ70olrdaLsz4+vmvgD66OItS/aJgDOn4wNbpKa/s+oqMqYnYcnayDf6eDhMzAnAgmPS/iq5+P92MFOTHfLviP9K7R4nt9OCMXBmV5ScYvqddHB1BBCM/nWUwvKYYGBsEORY+VkQKyC9YvzvyU2KdVWECPl1Z8zTf4KGHV5zZBbVqRZy9bByfWTZH1rVQyedOg0WqDo9zmEM4ewJ5HAJCXA1mr51577t0s0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c7a04ae-026f-468c-ed0e-08de0b25d8f3
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 13:30:31.7316
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3ynXGK/ZkxbYnzt/KYdZMAFgwoJjBPqyB34EFxRtl9JzyuYQayyifa6Wa/iSYR6zFgkUveIRB6/PanUfVY1fow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7907
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-14_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510140102
X-Proofpoint-GUID: 1A4pt28a8Mpn7KMRoeBLjGjalXChqE18
X-Proofpoint-ORIG-GUID: 1A4pt28a8Mpn7KMRoeBLjGjalXChqE18
X-Authority-Analysis: v=2.4 cv=QfNrf8bv c=1 sm=1 tr=0 ts=68ee507c b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=20KFwNOVAAAA:8 a=7WmofvNS1lTRNMnv12cA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxNyBTYWx0ZWRfX0x4ZprIzsAcx
 3lrgxasZgdUCvoIip3dnyrKNBRZjybScnc7AtmPv6wxSx7JXHNb0i/IsTqsa8t7jFC7wk4nhYBZ
 2mFfya4Sd5ppSLdsVJQJI2EMpDzhr3SFSULmbnGpepioKgSrC26qJuoCs+65SDvPYor8/q4lBZr
 sN6d/amD/PyHWEozJVdlRemHgon8cMkBLnIxahNJf/9qIecK1+ZjIL/GRYfKIKyzld/+xpFw9aH
 fvbGL+hF1QRGsvkp2QP+Xto2Z3VshjMXqkCKXBs4BsthVTkbSyfjdRTe7tWJZqQ7ZAnDbxB/qJI
 fQGTYPMy4+B30DHsv3FUObwC+VgRvO989SjpMfFeOj+VVMtCTQosBj6iS3ufk2OImTBW52DAjNT
 7JK/L0UFTtsxM0Qaai+nDIrkbhScGw==

On 10/10/25 3:44 PM, Olga Kornievskaia wrote:
> Here's the problem this patch attempts the solve. Client has an
> established session and used no more one slot at some point but
> currently is only using slot 0. Thus it's sending compount requests
> with sa_highest_slotid=0. Now say the client sent an op (eg OPEN),
> the server processed it, reply to OPEN is cached in the reply cache,
> and connection gets reset. Upon reconnection the client resends OPEN
> again with same sequence slotid, seqid, sa_highest_slotid=0.
> Server replies out of the replay cache. But it sends the reply with
> sr_highest_slotid=0. As the result, the client throws away any
> slots it had above slot 0. Then when it needs to use more than
> one slot, a compound is sent with a "new" slot seqid=1. Server replied
> with NFS4ERR_SEQ_MISORDERED (because it never realized to told the
> client to shrink its slot table).
> 
> The problem lies in how the server's seq->maxslots is managed. Normally,
> in nfsd4_decode_sequence() seq->maxslots get set to whatever the
> client sent in sa_highest_slotid+1. But then in nfsd4_sequence()
> processing of the sequence when everything is checked and processed
> (ie., it's not a replay operation), then seq->maxslots gets
> reassessed again and gets set to max of session->se_target_maxslots
> and seq->maxslots). Once nfsd4_sequence() is done only then later
> it gets encoded and nfsd4_encode_sequence() put the value of
> seq->maxslots into sr_highest_slotid reply.
> 
> Now, when the compound is a replay, then encoding is done within
> the nfsd4_sequence() itself and seq->maxslots is set to whatever it
> decodes from the call (ie., client sent sa_highest_slot=0 so it's 0+1).
> Thus, the encoding function puts value of 0 into sr_highest_slotid.
> nfsd4_sequence() would later reset the seq->maxslot but it's useless
> as the encoding (of the wrong value) is done by then.
> 
> The proposed fix is to explicitly set the seq->maxslots and
> seq->target_maxslots as it's done for normal sequence processing
> prior to calling encoding of replay cache info.
> 
> ---comment it probably needs a Fixes but I'm not sure what that
> should be. As I think this is day0 behaviour.
> 
> Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
> ---
>  fs/nfsd/nfs4state.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index fa073353f30b..4b4d067f20d0 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -4413,6 +4413,8 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>  		cstate->slot = slot;
>  		cstate->session = session;
>  		cstate->clp = clp;
> +		seq->maxslots = max(session->se_target_maxslots, seq->maxslots);
> +		seq->target_maxslots = session->se_target_maxslots;
>  		/* Return the cached reply status and set cstate->status
>  		 * for nfsd4_proc_compound processing */
>  		status = nfsd4_replay_cache_entry(resp, seq);

Replaced Neil's defunct Suse address with his current email address.


-- 
Chuck Lever

