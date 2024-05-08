Return-Path: <linux-nfs+bounces-3204-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44BC88BFF2F
	for <lists+linux-nfs@lfdr.de>; Wed,  8 May 2024 15:46:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5CF91F281B0
	for <lists+linux-nfs@lfdr.de>; Wed,  8 May 2024 13:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1811884E16;
	Wed,  8 May 2024 13:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gY3PMlPF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="VRr3FYNb"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE70626A0
	for <linux-nfs@vger.kernel.org>; Wed,  8 May 2024 13:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715175829; cv=fail; b=mjMt4WWOKVZqQDCEWI65iMo8rUgJ8f/NCqbRlZuKdeEo/nJT8eDs/WrfJ9BFOJYPtM3rA00rdBVBcH+qQTQ2nozQJrynGXafeRdKvU4+rorvYjIGVCuqTsBtZi5Tk1TsQQM8UtlRka9A3cdX5DLmpMaOIPnH+xofhr67h2RbtOg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715175829; c=relaxed/simple;
	bh=gubnQhFObJBpCjfuuN0Xk5ygS/d+DFsVmvI/cw/9zc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bQJo7GrxAVd+5DkW+zKrU6fNTvBkQqGBoCW8v139f1C9MLNm2eekuBqzw2eRMYPPYzVcQwQVPHXEP8hgCTuLCXFTf2FQ/9zk800ddDmB7HS3ZBGlH4rZC+s2y1khuKUuRhBiq1baGz96Tjr0kBwmb+5AWtWzaGoyWBmuEJE6huc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gY3PMlPF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=VRr3FYNb; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 448CO6rq024540;
	Wed, 8 May 2024 13:43:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-11-20;
 bh=k7MPX8ULcwEAOl9fDnfqxvkRz9mt06bu+2d7XNB6+X8=;
 b=gY3PMlPFuRaQHi4KNGeHbyvFAeVk3ModqNHqCnFlgwLTe3bdVILsIgM95WM1akKOSdVr
 BuJVBAoQy3DB5LNtBGdlzFe6UeQmSSNNa92xaS2kV3WZZxMeVfBawa9JVJm1Rxs/zw0X
 5OEcbUm+EV5ASiRnQE1I+VDgvxDbMWfUT+M2xtq45i+8Aw9pDOO1fndFEB4eM+TeDs2/
 Hr1ExirhzmP9al25Y+GuuNut9/FcBMMeYuMb33zlmHcyoIV2B4ClnU0Oq+VcOw1EOEJT
 8B72UfPpULgWzsD2x/uFRb5pF+WO4XzbqML+WjEP97hjnmsCwtd3UElVYmecQR9JObH7 1A== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xysfu9tjs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 May 2024 13:43:46 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 448CLQHE019801;
	Wed, 8 May 2024 13:43:45 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xysfkmt2e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 May 2024 13:43:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MycHfZdDnLZ4BKZjkHQzLWpsnelaB2DHhpnDB/D/opZUBy8bOmQ8vTQEweVr3/G34Yi8orcgaWWBuEzXmwt/Jo8TwCpog7s8FXSt9cneviXmjci217aVdL1ATbTHhNpNZvNuWVaIJv+S+yhddMXQodL8CPjyvCuIPEryU71LlnrKvPNR1akb8i2m5BesbTB2vYftB5f4nqYqvmh516JgvgI/jCNFMobsyL6H4UAqoMpEMvHUHiX/sOrtUYZ1O8s9ZhsiTh3p8VUgH4zBkibvK2JwcI5zieVUboypwHg7OqSyqfi6oUmmvDBU3xuGAZdk02x6IA/6WFLD1bOHxSgzgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k7MPX8ULcwEAOl9fDnfqxvkRz9mt06bu+2d7XNB6+X8=;
 b=BSeog1VOEugB6vhH4cP1eR50gbY2DlQGRdb2fXmpTAwlrwcjw9f28uR0CXT76eegJZgln5HM6HUkzWsBOcprIcWWfD6BrP80AlIlJIcXclpjG6sNu4pgz0VnYbeLs9UqXFXdIUxK0qi9NmmlGnXxN4s7SzVLl0kB0QHFw847PrhYC88gerswS3JZsq35SC+sYzHMBlU4l9HQMk16qnYAWq3zXKV27AEw1+HrrMw5q5hdf5rf5kwbGx/R7K0aSde8vw7riaYmEXnBJHAd1U8Duz+JWvEAsA0b5b5KNcerF4VkefF9DfKI5yvPI2imKRlYJ6nSofZpI5Wpx+7NUk5cgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k7MPX8ULcwEAOl9fDnfqxvkRz9mt06bu+2d7XNB6+X8=;
 b=VRr3FYNb7MgEEQdTRUz5sjeJAQtw8p528+grO996Lr89dUK6+RY1hLpkoLPr1DjpfITFDiwoc1L4GAQu2BrPau8UpxxddbcqS9PyYd1tfKFXGLXsK06ROMXhcLXrEzZvaKeCAkujn4ipN7a47R6AYiJm7dTn/3Zox5bLC0YREbM=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH3PR10MB7433.namprd10.prod.outlook.com (2603:10b6:610:157::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.46; Wed, 8 May
 2024 13:43:43 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7544.045; Wed, 8 May 2024
 13:43:43 +0000
Date: Wed, 8 May 2024 09:43:40 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Amir Goldstein <amir73il@gmail.com>
Cc: linux-nfs@vger.kernel.org
Subject: Re: long-term stable backports of NFSD patches
Message-ID: <ZjuBjMsY/ZpRjPk1@tissot.1015granger.net>
References: <ZjjaD4O6FYDrCz8o@tissot.1015granger.net>
 <CAOQ4uxjNK95-PgHoZ+HzBGE4F7BhZiC4sSPcJAR8e+gYmyN_dg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxjNK95-PgHoZ+HzBGE4F7BhZiC4sSPcJAR8e+gYmyN_dg@mail.gmail.com>
X-ClientProxiedBy: CH2PR18CA0020.namprd18.prod.outlook.com
 (2603:10b6:610:4f::30) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH3PR10MB7433:EE_
X-MS-Office365-Filtering-Correlation-Id: 6273bf5d-09db-46f0-ea61-08dc6f64e05e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?VWYxR3ExV2NVUUhSc3pOM1hyQUZKdkd0Z1NpZXVvemhJZmNPZ281N1NZRVdu?=
 =?utf-8?B?WjRCR2dMOWlxd0lsRndyamxOUnQ2NWRtamxaL3ZmMGU2VE9KUWtPYkp3bDF2?=
 =?utf-8?B?OWF2UnREd3RrQlBJUWw0RmI0VSs3NGkyVVJOemFKQzFmZ3JiWVpWMlBsL050?=
 =?utf-8?B?cFYrNU95OHlCeERqaGw1Y2x0Qmd5bzhJQUNJYlJUWlVrelk5S0g1WW9aclVl?=
 =?utf-8?B?Q3dtVUV0RUdWTStlMytyNkpYSksxd1ZVVGVRVmdFOU4wS1ZFOWd6dFhMSEdH?=
 =?utf-8?B?R1JHZmxaV2puSVpPdU1TLzJrYnFOVW1ldElTcEhmTS9ZdVlLeWFucGl1ckJK?=
 =?utf-8?B?eTBWSElsRTZJQncxcU5CbFM4bTRPQ05wMDFzOVFKcEFDalh6aE5UeVE1L01w?=
 =?utf-8?B?U1BzSVNldU1YckhMVEtpQklOVWVFVTA3VmFWYmpPRWhoSnlNYVBjOFpRR1lG?=
 =?utf-8?B?eE1pcjVWMlVvVk8zSXRJSzN3MTRXK2VWcEp1NUQ1U01Pb1k5NkRsVkVyQ096?=
 =?utf-8?B?T2VTRVJKdm9UR21EUFQ3UXhCdVVtTjJ0aDBOQmpLb1NiWjlNZWt0Vk0xczQv?=
 =?utf-8?B?ZW11VHY4N25JVnhBdDluQmZpRnEzUEJHeHZvMUxoeThLSEtJaHVheFhjcytu?=
 =?utf-8?B?TGNTbjE4eXc5b3o0cFpMV25VWHloVGxSMTNFaXZHd3Aycm12dUJmcjV3d1hj?=
 =?utf-8?B?a1d1Smc2K2lPeUwrNVZ4Qnp1UnJYdzlrMHZjSWJuVDhiMStzQlplQW9JKzVk?=
 =?utf-8?B?NmU0cmNBdlp2RkRzVWNXSVFUM1V0QndyWGMydzZBeDkzRTFNV3gyWlQzSTZR?=
 =?utf-8?B?Rm03UmMwUEx2MGF6QTBDd2NUc1lmZ1haNTAzWGhoS0FHL1dlWnh4TnlTaEtD?=
 =?utf-8?B?SFNSdVNPcDRWUG9PaS9KeERXTXQ3d05MYTRYb0tiVEJsQmxhMUhUZXFmWnZs?=
 =?utf-8?B?L2NzRXRKRlloSHZXcXA0akhGZVIzQWhRSlVNVlY0RUx4Z3hBbEVCeE9zNktP?=
 =?utf-8?B?elFaM1pkanZqZmlrN1plMjBVNWt4b1VrWWladEhjNmE2T3k3YmxSV3RjNHBB?=
 =?utf-8?B?NmR4M0ttbEt1T2FnOXllM3h1RHlwcktLaTYwTUpqWVNkbEdSSFdKTjU1V1M5?=
 =?utf-8?B?eGN3L2FON2xaQ2QzQUQvRjY3WEJudWk2UUFrazRseFRETGtqZHlXWDBxSm9x?=
 =?utf-8?B?NldjUUxpZFArMnZra1RjRWlJRlhNUjJhS2RaVUNFamlzSCtaa0pRTC95VktF?=
 =?utf-8?B?UWFEVmlIc2dMVzRiUkVXRDRLZkhaY1RzU1RZQnZhdTdkeldGYTJJYThNUFJC?=
 =?utf-8?B?ZlBzRWl2TEk5MkZVdHhWMUtzdld5R1VJa1hzWXJLR0w4UzZvWmo5alFRQnBh?=
 =?utf-8?B?bWxBRzFGY0w4Q242YXlJeUxzVHF3QW1LTktXT3dkcWxBczZOUFFrTWE1OFdO?=
 =?utf-8?B?VFcwbEJ1UEZIWVAyNmViY3ZZWjNBczRYdlB5dGJrWjI4dUExMUo5elc0Rkpm?=
 =?utf-8?B?bXVoMTV6K3lFazQwU3NWUEpOaENKWVNZNzdHOU9ST0RXdUJvbU1IRjB1dDVm?=
 =?utf-8?B?QndTOUo0cnNtV3YwaWM5d2Q4U1dBMXp0S1JTMVpTRm1lU2J4b1NsK1AwRnFr?=
 =?utf-8?B?SUNwUjZWbVE3cU5Edzk3QVlkTnFubEdobkMrUnZBYkFSOWFzSEl2RkFNQnp5?=
 =?utf-8?B?L0cxSTRUWHN3RmNOUEN5TWVtczVhWTZ6UTVzUUpDcGVVZEZqMngzbVZBPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SHpVeUFnMEduQnlNaHorNFl2Z2dpMFZXdldaRDhUbVR0WEViQWNVL3RPd1I1?=
 =?utf-8?B?Vk80K0Z1QzJiaVNBdGNscXNBazBZOURYU1F0VWdUL2RBS2NQNm1YU3cwN1dh?=
 =?utf-8?B?WUVrQ0dyMTExeWpGZjZkaTRDU0dyQWcxTzFmaG9zOGxSd2xLYk5QLzZSTkF1?=
 =?utf-8?B?TGNGRSt6dm9CQmV4NFBzekZmMXk3akJEK3RHYXBQVE5aUS9OOWU4NXNFWXlZ?=
 =?utf-8?B?VTlxd1RJUURqSkZEZ1hqekFKdElGWU5aand3V3RXUjZNZ0dwMUhsZ3BxU3ZF?=
 =?utf-8?B?Y1FhZk4zcm1HU3NrZGdJejF1dWl5UWd4b3REN3lVL2I2bkRHb2NDQ241U3FV?=
 =?utf-8?B?cW1ESUhDOVA3VFFsUjVYcnVVMnFNNGJ5Q0RYVzFQbjhNYWJCb3RIeGJqb1dy?=
 =?utf-8?B?d0lUTzRNby9JYjkzSGpRYUJWQmwraEtaVC9zb1A3N1o5NDhKWXA2VHFITVpu?=
 =?utf-8?B?U0dOdHk0TEJReDc1MW4zaHg0MG1EbFVZR0pub2Y0dWJvL3NhMVFJdE4rZzE5?=
 =?utf-8?B?a0ZlWmtnRjlEUUhGNk9VMVByWHErbk4xTE1mZUptemcxWTNYUmplMitYVGFF?=
 =?utf-8?B?Q05zM0NjYjB6N2txRXIxSm9YUkVGSU1YemNudWZvQVFQSHJrUi9XbWNSdTNs?=
 =?utf-8?B?MWlabk9rSzJDY2ppUUpDSElMTmpuT3J6MnFkM1JUTk5jc2NyTFM0clFraEdP?=
 =?utf-8?B?NWUxU0pUNU1GazdmTTMzUEFmY0xCSzZrWkRQZ1JYY3NVZ2JEdXBRTFVwaldL?=
 =?utf-8?B?aTdPSnp3aWxGQlhMSk1xQ2N3c0Q0LzVtaTNkVnM5ZlBuVDVTUVl5NlZ3NHNQ?=
 =?utf-8?B?MnA4dnp1LzhpdTY2N05CYjhyeTZqMDd0dDdWSVhOVDV0TS9PTHl1S3R0Q3ZN?=
 =?utf-8?B?WnFnYjN5S285ME14NHM3YklqT3JRbnM1WGtWQnRZWDNRM1Z4N2xiQm5HeCsz?=
 =?utf-8?B?cVNDZUNwQnROUE1yMG0xNmNwVEdUajZ2N2lVRXFJQTZLVEFJRjEwZ2ZMQUZ3?=
 =?utf-8?B?ZGxXZDdGOWZrMCtUK2dJT2RHQXo5a2h4aXBUSHhncy9abDFTMHlneVpURDJZ?=
 =?utf-8?B?RTVvYXV1clo3cE9sYitSQjh4MDFtaE1jcm9OcWduOTNJUGxBZjkvUXdXT29V?=
 =?utf-8?B?U3R1QkxQTWh4M3VBbW5SbEJ2RVNJOWlRRlVuVG5XZEkydlFsczRRUWdKeUND?=
 =?utf-8?B?VlZvUmtyTkpVOGRKOHhUWDdFQVg1VldNUlR2Q2JLcGxMTEZTOHIxK0hjSmda?=
 =?utf-8?B?TUNlY0JDaFd1QWtqSnBIajVSL0NHVEtGWGNjenVjd1RiekZrTHhmbGgyVmpU?=
 =?utf-8?B?b0JCTjI4MStWZ2FWOWg2dEJ2cFdUZ2FITHlOYnlhV2NkTWhqWnhqc3RCZEdy?=
 =?utf-8?B?N1o1U1AvRXluS0JtMUZXU3Yxb0tCL0Q3RmF4cURWUk8zYmtTK1FnZ1FPT3hZ?=
 =?utf-8?B?Z29sVDdrNFBnZldPcEhnVnFaVXkvL0wxaHFnRDcyMEVGR2FJYVFRUitQZnhv?=
 =?utf-8?B?UU0veE41cFB2bXNTVVFNbTBGWG9YN2tCanltcjVGbkRTbW40ZEdmdnh1cW1E?=
 =?utf-8?B?QjZaSW9FV0Fnc2IzeldWQkZIdG9QMHE1R2o4M1FNYmtIS1dxUmdDamNLTmNV?=
 =?utf-8?B?Y2J3cHoyS1VFWjE0eXBvWjJFTFU4YmJpQVV6QlBFZ1NhWk5YSU45bC9KaGdM?=
 =?utf-8?B?a1ZPRnNMb3lpd3VFajYrTWVrU1RndjJGMDQ2UW15cUpMbk1YOUhVcThONkVz?=
 =?utf-8?B?MmhxdTUxaXdsV3JxMFRvQXZheUZSS0RpV2lPOFhlaGQ0aWZadVhhVHlpL1Zy?=
 =?utf-8?B?RGpvbWp6T0R6bGd4K2VsTWphTUo1aXE1THBPMEZLN1RKTUNOTEhPdElCT2Zj?=
 =?utf-8?B?azhYdHdCV0Z3dTFzSjRRTkxIVFR0ODBQelYwc2JOSEJncjVHY2NTSkxUa3lm?=
 =?utf-8?B?Nlp5UFNqdHQwcmxiSGh5RnBCNkZWY2FYS1dVaHJDM29ZTG1xdlpIQWVoc0oz?=
 =?utf-8?B?SjgxLzRwLzFaUExWeHdVOGxFVmJsakhmRmZlcnZDR1paZjIrbHJ4VE5LNzNx?=
 =?utf-8?B?WmoyZWlVZjNxUUtLV0VueFROWE9VVlBoeGRBcmRmQ085MkJDWnNzYXpzWFhu?=
 =?utf-8?B?NzZiUDcxVW5SUzEzY2lvc2hWdmx5QXM5ZWMxSGVpZkdvNk5pcGVZVXZLanpR?=
 =?utf-8?B?dFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	cHdXukuhyFrHl/ZKrYtlmzzlKWDXgUFsI9B3OEgODnlBwxZ1/zgzfuTQpM4Ouf2hV2QfbEbR8h/hLduIjI8JJvy/RfoAlsb4oF8OpnIJMu+0enPwTqa1rgosvWhxGr27ewdWS7BLdOFxTMgp4AUq0Q1GuDvFbveXxccKezhqVorzBTDoMUHPS2zHAJvpw/gm19ZNiDhoUhmD0HbJzzczCaQestiFqY+hFpRgl8w3Vh9UVk0W1ax6bvscAs4cTFrjP8x/t/LowRFp4UkWAkyOIDOM8C13n/ioxad6VcvGr/8j8ZE2CMYXrdvzj4rYnkKmYhkdjVUNGxJjyUpBZVzRAswEdSYAgHygL7+5NXqggpmWCJ96a2vFnzMjrTfhn/2ZO2If4HeD48G3LrvAZ9CJWV+OZw+33isH7aOgWAErsKNddJJ9fXt4rvsrE1Efu+rMEzWWLx5fmL6TpobFxR6FjUHi/Q58XQzo3FoVcVxefDRWGiHECxBjt5hzQAkGFJJHhclDNwqk7oZ/CvmGpjO5hm4Me2oW95Xi5w9rDdeNhyH0JMQf+UmSa+hW4zGHORpKFvmGiqKBhIgBIqHr6YlRXRst3UceZFGfSdzLS3ob5jI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6273bf5d-09db-46f0-ea61-08dc6f64e05e
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 13:43:43.2639
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 50JGrItFlK1UArEm5CwaYkoetXIy8mZ+qDR43QDkasCOvZyrfkS5DBGT8w9kuh5JtFrQRl+JII5PcDIJDpQKwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7433
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-08_09,2024-05-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 suspectscore=0 spamscore=0 malwarescore=0 mlxlogscore=631 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405080097
X-Proofpoint-ORIG-GUID: EXfTuabBJl8Z1_Pq2V2dT6g7LAvhPmph
X-Proofpoint-GUID: EXfTuabBJl8Z1_Pq2V2dT6g7LAvhPmph

On Wed, May 08, 2024 at 02:29:05PM +0300, Amir Goldstein wrote:
> On Mon, May 6, 2024 at 4:25 PM Chuck Lever <chuck.lever@oracle.com> wrote:
> >
> > It's apparent that a number of distributions and their customers
> > remain on long-term stable kernels. We are aware of the scalability
> > problems and other bugs in NFSD in kernels between v5.4 and v6.1.
> >
> 
> Chuck,
> 
> Are you able to share a partial list of scalability problems that were
> fixed by this backport series?
> 
> Specifically, my interest is in the list of improvements to 5.15.y.

In broad strokes:

- The garbage collection mechanism was rewritten to keep the LRU
  list short, and to keep sweeps productive. This was the main issue
  as the LRU used to have hundreds of thousands of files on it and
  one sweep would take so much CPU it was reported as a soft lockup.
- NFSv4 OPEN files are no longer garbage collected so that an NFSv4
  CLOSE means local accessors have immediate access to a file.
- The filecache hash table is converted to an rhltable so that it
  can efficiently manage many more open files.
- Various fixes prevent writeback of garbage-collected files from
  bogging down.

There are a handful of important bugfixes before this commit, but
starting with commit 0369b53886ec ("NFSD: Report filecache LRU
size"), have a look at the commits that touch fs/nfsd/filecache.c.

-- 
Chuck Lever

