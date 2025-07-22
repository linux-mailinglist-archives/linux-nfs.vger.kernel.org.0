Return-Path: <linux-nfs+bounces-13182-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5C7CB0DD7D
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Jul 2025 16:15:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8178582F82
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Jul 2025 14:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C41E42EE298;
	Tue, 22 Jul 2025 14:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RuR4gZ7v";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="K+10BxwX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7062EE271;
	Tue, 22 Jul 2025 14:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753193244; cv=fail; b=iEzcVqv7zOWon4vJEW0wzZQwOZcoi24XLYVqRJwxlgGEDPX3GaoEkgZ1t1nOALqlt8k/3Vy8STWZDfO/022FXCnQXkdOFEfecvHM3oMGIOXgr/kGxAdEZ73lIQAGYNnMe16O38sh9mKqmuLV/z/lcTOB66pXGnWaf/wQTSGje64=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753193244; c=relaxed/simple;
	bh=/13VljsNFdmuJeirfnZblSPAtgdUHXplhtzyU83q9xc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iHPLhnn/2u+bsK+B7sRh+zOqDAAXMuAX9r1lc+IO0wGASZLYUuGA/Bp2819O2zJXsj2srimzX1WIkDHx4dR6YFD64G/UBL8VyeelQ3XVYjRLqbfZDT2JRV+0I4sJU3B5F8r8OEfPNPEKL/LdaCCMdvdObAeGcOu/FH/VTdjw2zA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RuR4gZ7v; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=K+10BxwX; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56MDhwMn029278;
	Tue, 22 Jul 2025 14:07:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Tm+CAL1eHq+CrGzYVIigIgmi5A+1OWVmmnTvpY6XLKQ=; b=
	RuR4gZ7vYG5cjGkrhxlZp23zTK6uVGN6qf5k3uuLzKiJqgrlrBZAlgwGw4QA8p7R
	vo0u7gzlg3ks09clllg7y3HmUY0ljkwOdFKE2ROY+awLXlLjwhom9rCZ56214Jz+
	cu2O49zUDmMkg6+vK5P+m2BMhErPMmoHHXgsBXTTRSX0I00cG5r1iajvUvm5BrMR
	vXImgW2wcotgk3EytELxIICsnPlAoNsJPl4kIgngvcMJrkXw/VLHd/oyR49g4sVV
	zimPB+WVTeJhk6OsqaX4Fr1xgoB3G9lQq0BYg5T1wB4Jvc/m1KZHT9OmDGFBLcZU
	/hDeAZLoTLuQKreVXv2+GQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4805gpnegn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Jul 2025 14:07:13 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56MDVwtR037661;
	Tue, 22 Jul 2025 14:07:12 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12on2084.outbound.protection.outlook.com [40.107.237.84])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4801t9crb0-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Jul 2025 14:07:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iF45UXx6yIJzFAeJCCmEiw8FjnbKWQuVqwQJRHSm7mrcJg7P/M8HWaww2BvhEFPwkwhIHNpT4wy/fniUwdjWdpKx9ZNBYylhA+n08iCUOI67hWLrt3EmwcGLPhfrnZwapyV+uj+P4Js/1+uilI7fn5oxyNDh+V/MZsHx9ipSbt8NQM5WjIIwAQRLDsoqi6pFSGty2ZZr+Zv2St9GvnXfL0Q2bFvuRjYuDJ07uTVLDgzhEg86NgxZff7hJiTvOFl5VYif+bcZvJ4k0uoaKye89XuMP3+IDVk0farxBHbMP6ZmreFQ4XZ534mRbfN1yAKMz2PptWP+C6A2H9+OZmoukg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tm+CAL1eHq+CrGzYVIigIgmi5A+1OWVmmnTvpY6XLKQ=;
 b=MlUWuwBc7tHkbuH1PNts7s5wJDcr3lnutaiCd2tjKRyIhJE0WZxPnFnEgfOGCfxIEFROm3kXSFna1O1YNWbhS95n1aFFWSYtFTmlJAz9VfE0Wsaz6S3JphM0bsa0H9RFl51FqtR/FUSLvYMgqKJRvDJ7chcD02wJAcKMbGaG9hQjftm77hknw0lBwg1ofq5XEhxWjcQ6ZXh26nqJAAJvFzGDHiaestoVVH2M0dEHIWQs+HjX3iQNLwx7k+yHeq7eAVbZkulqqyR6D6I8NeV6t2F2lJo/9F4L0c/VII5AixlBdBUAj8XskEDDWTvkDGFLs+vNDomrFpLEzXzIgOtq8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tm+CAL1eHq+CrGzYVIigIgmi5A+1OWVmmnTvpY6XLKQ=;
 b=K+10BxwXThFNuqbUdIQNM1ZBsprXmgyV5wwRrTsQHyTI9XzLBpgPxgb3EeaohlAGO+xYuVbayD1mTdkYjPmIx1U81N777cHYvChKalcSikwLAoYGPqGBO9E0y+T/5+rAnLrjFNCp0OxEjqnX/giFoLtkKmd4vGuBlg/YUlfxiz0=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BLAPR10MB4915.namprd10.prod.outlook.com (2603:10b6:208:330::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.29; Tue, 22 Jul
 2025 14:07:08 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.8964.019; Tue, 22 Jul 2025
 14:07:08 +0000
Message-ID: <05e851b2-a569-4311-b95b-e1ac94d4db5c@oracle.com>
Date: Tue, 22 Jul 2025 10:07:06 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] NFSD: Rework encoding and decoding of nfsd4_deviceid
To: Christoph Hellwig <hch@infradead.org>,
        Sergey Bashirov <sergeybashirov@gmail.com>
Cc: Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250721145215.132666-1-sergeybashirov@gmail.com>
 <aH8jeNFJFuxCugKZ@infradead.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <aH8jeNFJFuxCugKZ@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR20CA0008.namprd20.prod.outlook.com
 (2603:10b6:610:58::18) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|BLAPR10MB4915:EE_
X-MS-Office365-Filtering-Correlation-Id: 190f2470-5ad8-422a-4939-08ddc9290bc3
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?QnA0NjJxcEErc3hqM0h3ZlFlZVYvV0NTREtkcG1FL0o5VVQ4d2ZwRitDTkIy?=
 =?utf-8?B?Ykx2cWZOamprS2N5bU1jUTBVb0lDMjRjU3V0S2ZrWUxEN2hodkMrWFVvdUN5?=
 =?utf-8?B?bkR4RjZoU0lxUlVpdzZIcXl6NHlNV1lhcUxVMDN5c0w3Vncyc1R3ZW51WXQ3?=
 =?utf-8?B?NExwTEZPYVF5RUxKVWIzMVFLaFdjS2lHZHUyS2plcnN1RnRnM2NRWWxKY0ww?=
 =?utf-8?B?YUhZUkp6NlFSR2FxYkhWMXh5RDdPK0NraVdSZmpJbDNLck9UeWxJVmYya0xG?=
 =?utf-8?B?Ynd6NS9VRXFlbi85cnZCSlhrUWF1KzZJQXI0SktUazlDaGxGTnpWUGJ5Wmpx?=
 =?utf-8?B?K3diR3lRZlIrS1lGQlF6bXhWUlg1Uys2K2hpL09aMUxqeFhkYklzSEcvcmFJ?=
 =?utf-8?B?WjJDdE9xQnZYRTBoQ0lqRk9lbG8zRXcwZEMrcmtWTUE2KzRXRmRXanBmNE9t?=
 =?utf-8?B?M1EwMHBIa2Jqam5HQXovTmh6VVZFblZwQ2JBb1MyNmRHbzlpODg1T2szNWZx?=
 =?utf-8?B?ekZDS0RiSGM1bTFuVSsyWVhPa2Yxbkk3Sm53NUdIYXpwT3R5Q3JRRjRlb2l6?=
 =?utf-8?B?THFOamJMNG8zODYzRC9tTEpkWE9FWmR6YXBtR1lGdlFpUlc4QjZwMG5SYnNq?=
 =?utf-8?B?UTB0emZHUHBLMEVrNWsvTjVRbVN5UDZRK2RQb0FJK2F6MVpTdkNjUTJmd05x?=
 =?utf-8?B?cmxjVHltdVJkOGxtTWF6ZXJjcmNvdGZEenRhMmdieGYrSWEvTEkvNXpQT3NP?=
 =?utf-8?B?NWo5Q0VQcFY1b204bzFibXc1WFBEUUhkZDRsQXdBRUVZOEltWGFvR2VnYVRz?=
 =?utf-8?B?OFVFRWxsSm5EM0p1emFJSmRpZm96MWNrUVdIeVdNQjc0YlBHK0RVYmJwT0RB?=
 =?utf-8?B?cGIvOGk1MWpKb3Q1aEttVHNNQ0srb2p6YVlORlk5c1cvc0tKcUlZOFlqMTEz?=
 =?utf-8?B?RzhCVUp0dWN0UFc1N0pkVEt0amJhUEYwYzBWWFVEMXdqNWtnZ1I0OFJ5b3hq?=
 =?utf-8?B?M1grNjRhdjlmeStYZzh5OUEzcEtZMkY0MXhSMk8zQUphL2hPdFE1dTF0L3BH?=
 =?utf-8?B?Um1PQnZaeGpjaDRuWUZQbjJSWDh3Y25RdUJzeFVMZ1YzTzlMUjJZSk9Ia2V6?=
 =?utf-8?B?ZDNaUVJkV2VOQTNsNTQvVW9PMmNETlBZRUJKaFl6dllGQ2JLbTFSNEpncWVj?=
 =?utf-8?B?QWUzcjBJcUM3bTNrSUllN09uS3BTNE9zMXRYKzE5cm1JSTFKVUFDSzZtVVcx?=
 =?utf-8?B?eS9LRjR2ZTNYMTlHRkViWGVySXdyZitLNjJkV2RGenpvWHZMbktSS283LzFm?=
 =?utf-8?B?ejdycnZlZFVSdVRoQjYrRG5jTTFHSjZQSlRlWVl4S1IwOVFvKzNKK3RWSXFX?=
 =?utf-8?B?VjEwRmZNVks0cFp4clZCY0RJQm53ZDhObHdWUVE4ZDlEcjRLNzJ4VDB4bkNp?=
 =?utf-8?B?dWIreC9QSytWcUVteWZWdUhoa2R0QkxiV3FSY0tBWkc5ZVNrKzc1akpaT2lz?=
 =?utf-8?B?ZTZ5cEdKa29xcDNSYWF1cG5uUVV4VGg2ZmtSMlpEU1ZNRFYzV1RqbXNWQ0Jl?=
 =?utf-8?B?Wnlwejc0YUVaUmxxWGRBWHJVY3B2aEJHeWNOdjhJaUtBVjBvbytGS0V5dGU5?=
 =?utf-8?B?UjdtcEN5eDZXVEFLLzJrdGxWd2hmS1cwb25JSnNrdHVXbHIyNFZCQWNMV1BT?=
 =?utf-8?B?eDF0Rzk2Y041RDBoT1E3NXl3aEQzUGtZNExZZkFGd2pQN0ltTG5vL29UTDR6?=
 =?utf-8?B?ZVVKUlV1Ylg1dkU1d3ZQTDFTUVhpREJDNUxuSkg4K1hUSnFoU1BJT3NHL1FR?=
 =?utf-8?B?d2pkbDZYZ0NRTkgyejlQQ3FxWWxWUTFCMDkxWlIwTXZSMERZQk1ZTjNDSy9B?=
 =?utf-8?B?ZkE3YWZxdXd0Q0NReWlaTGJHWUVzNVVGY0lxRzIweFE4bTM4aUM4RlRObzhV?=
 =?utf-8?Q?uNrTP68iWhA=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?eUlSQWRHTDZvdzl4eUY4STRXeHVneHRJeExzTEZYM1JXOHhwdzdsSXNIRitP?=
 =?utf-8?B?LytNQmxGamE2UjEyTzBaMFUzUzE2SG9qR1Y4eVh2bXdoT0czNVdKUnVUdm9H?=
 =?utf-8?B?NFg4bEl1dG1tQjhlM0pFb1BqRDJPaWVRdlJleWcvbnBnU051eTdFaGNoNUwz?=
 =?utf-8?B?aWNOK2R2bi9KZHFMRFJTTzlkWlhMNTlWNFZ6RytVSGFhVTdwSDRpMW1EMS9P?=
 =?utf-8?B?TGtWQmxsazNCR0Fib1BxeGxPZG5YRG1Hck5oYlNEWm14ck1CRkVYRzUvazhB?=
 =?utf-8?B?WHVmSlk1WmFSSkhpQkh4Zy90RzZSTU1yS2V5TlZtVkVYYVVlOU1WVGR6cTBr?=
 =?utf-8?B?SlpjdVhDK0xIdDVqZUFUTVl6RVhGYVBGdTlJdHMzQmJwLyt6RWRid2VOVzFm?=
 =?utf-8?B?RTJicXhXYkJEQ0piR0o0b0FmNi83VzJkTVh0Y0RBTERmaXZUQW5jMEQ1bWQz?=
 =?utf-8?B?SitPdjl4Q0NxTzhVcDEyenhUTGFRcERieGVCNHlSWkJ6NW5xbWVzM1dqVEpP?=
 =?utf-8?B?TllleWw5TmtrbXNSQlVxWFJ2ZGFJcGczODFDNlZMQVdqOXVYTmlIbDJFbHpW?=
 =?utf-8?B?cHhiaHJPYkQ3amhPKzF1a1hkVkhody9ySXV2TVV0VjUvZm9HeGVRclZxRHl3?=
 =?utf-8?B?M1FBTkI5K3JHTmFXT1Y4c1pDTTlLdEprWkl4eVpNMnpDRHJmQ2hjbEJvR1dK?=
 =?utf-8?B?UlFkaEZjdU5GWjkvbjlZOWpBMFFQZXFPd3FKRUlRSE5SaC8rcit1cU43VlJu?=
 =?utf-8?B?aXJ4b0pldmY0Z3FTSVB0S0JvUmpucm1JVENja0hUc29zVFU5MXFsNW5LRVNa?=
 =?utf-8?B?YWNiMEEzZFFILzZLdm5mY1hEVjF5KzM3RkE0c084Sk82ampZTytlLzU4TFo3?=
 =?utf-8?B?MGV3MExwTDRDcExIUU8xdmZ5YlBJRlUvdzNFU0l4ZmZNUEVXdVdPZzEvU3JQ?=
 =?utf-8?B?bEtIY2tUZTcvQTFzUnp4UkRKdC94RHhJeGMrRmNBVDRNL3BnSjljMWpiRFBJ?=
 =?utf-8?B?QndNNDk5cVpKR3J4MEpxd1UyREZoeFYwaDdXS016cld2L0tVWDZRQ2FGZGxC?=
 =?utf-8?B?WE8raUptZFY1b2Z4OVlmY0lRYmNVdnVFb0ZaWXJybEd0aHEyeHhwUTRlRG00?=
 =?utf-8?B?dzBjRUFyOXo0Ri8rOW94YXZ0NHVlRUoxd2taN1d0Y1RXbTFwZnBVNFNaUzNG?=
 =?utf-8?B?bDZoZ1pWZE9nY0dCVnpOb2d3d0drUXdacXBubWpPUS81N3Jqc3ZqZ1Z2cXBP?=
 =?utf-8?B?OWo4eDhCdEhVaWpPY09XN1E5ODd3ajlhWjBQcnRQeEgrZS9wbjIvK1FoNWsv?=
 =?utf-8?B?OXh3SkwvVVFmL2pmSFJqbXVlSHpUb1hYVnZVZ2pidFZyV0Y2SjZBTVlPUU1B?=
 =?utf-8?B?S1JremM3UUFWT0NxcXB5eXhzaW8ydFRPaGdtVElGbFR1YU00N05zRHRZdjJh?=
 =?utf-8?B?Umhkem5DZHpzTndJV2Q3d2hiTmpMMjZ4ZlZCeUpVUzZqWXdNc2JXa1MzYWho?=
 =?utf-8?B?dDJQa04rQVN0cnVwTzYzTFlKK1h5ZnlPSG5qSmNUTEFlc0YrWE1xT28renZU?=
 =?utf-8?B?TnhMZjVhaVpkN3VIeUk4dUdVMzZPWmlFZHVSdzgybUZwY0RSRU9XT2ZEVTEx?=
 =?utf-8?B?ZEZJS252T1BjMmV2eUpLQ3dkKzFtSnFwVXNxc2JmdzczRC85cUpINUtoK0Jw?=
 =?utf-8?B?cGM5Z2ZCSXNNand4RDVYcUJMYWdnTnRWSkJ5YnJRYmRPTUFxWFkwWFZGUUtV?=
 =?utf-8?B?d21aSWtwWjdySDl5bGtvUHZ1ai9HV251aHZSeHJXa0NPSkxWT3c1VXZXTkIv?=
 =?utf-8?B?aG1IcXRZNXhxMURsR2laR3NnWnpjV3FrbTVsWG85d0VqTEJDMUZPdXVlajRS?=
 =?utf-8?B?YzY3WlkrVUc3VTlEcFlQMWxPZkpmcmx4a0hRbExCcXpTajM5N0pVS2IvaUdp?=
 =?utf-8?B?dXlqWWl2VzFEdDhNWFYxSit5dnRJTWoxZHJybS82RUxrR0tXTDdEWEJnQUlk?=
 =?utf-8?B?dlVYZFRGNGlmcWdFU1RGNVhLYTdZQzNXY3RqaFVIMDd1dm8yQ1lCQmQxN0JO?=
 =?utf-8?B?dEU3dE9OZStrSUlvdHNvL3ZmcVJESnFZeTZJcWJCZWRkT0VBeDZUbjFZQzVO?=
 =?utf-8?Q?EBtHfmdYFppQV61wEkBzJgSSj?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ZZvpjYGDBhiksMT8d67ZMWCzaVQnfINilZ7ZV3kWqbdNcRUgwTDO2j0i417Y49rx+Sg70KBfNqjxadxacztMgOfDHy+nrOraYBYoF8018IitE3e5WTcLXKD2AZOjtpXLbgU5MjJQ6vvb7TBCgOKPcudHGYFNFzORHSNS2txnXl8Qo21ueSEqR6XPiw1aEahBnC2aYFNoZAWrjCMl3VxcYQoJfcuQpKuO4QmQAX3CuOwaCMjyKgmXF+VxxzDRi0TQJW6b4TSB+ne3o8zQLljJvBH0x+X5NngsAJtj9W/C2rkdDale426blvNxzBjL6AnQt3ovh/616cOvAQ3IQBebNZmYv84KlMFwRdrnXpsEqAjH+H+AWzjL35QmUJIGRxEHJsugg1z445h9V5MKMx/wpG7CU8upGuJYHXr2tZVXJathrT4u0erP2HmL75Ji1itJp0qjWizKX11Y4d+A0ZRj9aCybQdjmX8mxgMgXtPs/Kn7l4cuspizYonmldTCQycWG/eai814vJw4LxVQDspfX3rKXli3cNkN2jsz33WlVpdz0oaYucOJOpamrbsILdJELS51zl2B2VjcYNAb6XNrWGwbx9RSAD8LtiFo+OW3tnY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 190f2470-5ad8-422a-4939-08ddc9290bc3
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 14:07:08.6079
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vS62RxRFUgIr+WDzfzrC7Lu1coLuQ/Pg6q7q44IKolDEkaCTux5oJ5EHVShvSKB7Hl1guYQzbZPg4zxadC07Kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4915
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-22_02,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=532
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507220116
X-Authority-Analysis: v=2.4 cv=TfGWtQQh c=1 sm=1 tr=0 ts=687f9b11 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10
 a=AP58vB9fiuX1oI9D7dkA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12062
X-Proofpoint-GUID: zG03l133Db5-RAGYjjn8ObqFceN579Ue
X-Proofpoint-ORIG-GUID: zG03l133Db5-RAGYjjn8ObqFceN579Ue
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIyMDExNiBTYWx0ZWRfX0c4lhAVWkLU5
 PYOhitEpgFsmrdKvsFJvKqRtY6BEE9xWyy+cPa77BQK/E1VsF9fqyuhkRNrio5fhT/dUdof86WM
 F96MOLebmzBQQQuK5eFtAZh9lbOld6iyq04VvmaukLM1KjrK9oUMOFce5RHmTP/hozCdnPzioVT
 jjWC3Ll2Uz0+g4ETuQeigvR6hAz3Zza/DzOoyJ17/AcXmxzK2YVsfVKlLYg3onuPKQXSeX71op2
 c5Ep1Cm91wX9EPHhMoGmtZ0QJ+H7x4CAokwKdw5mT5k09OYbRy6WubDaQqPQiL4No79Cvs7J7Zt
 Q60U7egHzQIOlf4h8poXKK4025VMnrEicE7PA1fu0mpVIPnVdQTIMMIagchTtdeo4RUvkU/ospW
 8ptc+e7Jzab7WyWyfnUEBwe6fxDafgWZtOnIDijaYYJc+96wWwj+h2byz72DArnO/6dQysTL

On 7/22/25 1:36 AM, Christoph Hellwig wrote:
> On Mon, Jul 21, 2025 at 05:48:55PM +0300, Sergey Bashirov wrote:
>> Compilers may optimize the layout of C structures,
> 
> By interpreting the standard in the most hostile way: yes.
> In practice: no.

Earnest question: Is NFSD/XDR properly insulated against the "randomize
structure layout" option?


> Just about every file system on-disk format and every network wire
> protocol depends on the compiler not "optimizing" properly padded
> C structures.
It's an intrinsic assumption that is not documented in the code or
anywhere else. IMO that is a latent banana peel.

While not urgent, this is a defensive change and it improves code
portability amongst compilers and languages (eg, Rust).


-- 
Chuck Lever

