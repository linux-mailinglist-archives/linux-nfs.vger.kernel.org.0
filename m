Return-Path: <linux-nfs+bounces-13266-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E0C2B13017
	for <lists+linux-nfs@lfdr.de>; Sun, 27 Jul 2025 17:39:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3B9F3AF305
	for <lists+linux-nfs@lfdr.de>; Sun, 27 Jul 2025 15:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5D802AD2F;
	Sun, 27 Jul 2025 15:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jWdrfNlV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="PTf5Gse4"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD1B7E9
	for <linux-nfs@vger.kernel.org>; Sun, 27 Jul 2025 15:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753630771; cv=fail; b=td9GY8z2qrq7+IEnW2kMvcZcKHFGEvmQfIZzR/JwDsiZCtWFy29pzXS5ZAnzlFOEC12JHxz+S9rWnLUqxXC6sR0XS83uWjzso+bja5DmU1AAsroWpnk3cNRIcsmzZQkLasm/kjFUR9dRJtgMwrQnDpdZBpOQXCkUdI1+Gj3tKdU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753630771; c=relaxed/simple;
	bh=+EgojCJFK3Jzp6oQRRcBpltaGF0khfE8k2dk0QS97EE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NcPyejAhdBrNLU0PcD5CkOKzFG0dEptbe2R5Egocqu8G1Yq8KaXdlusBhgVmJhZ1hfo9GBnq7vZAUbG4yj9tSw2lOjXlB8GaSKk9GqiBEhsBSgATWK3Ho5SvZSnV+L/W4Rwd02qVCD7HK9cC+nmoDKGVfxRyDrZOI/UML6o+lgo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jWdrfNlV; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=PTf5Gse4; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56R8BrI2017533;
	Sun, 27 Jul 2025 15:39:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Uk8diW4FCDZy+ONLROfmr06ffNG7JYDUNFRQh9XINnI=; b=
	jWdrfNlVDtZ41y7B/l5wOGKjqmVkiupQFl4y9oIxZDm1GYK/lY1pjnJOOQPO5gWS
	kcz9o79zWHSu0cFR646pV5rkTpA/tdvYHR+UhqfBtxv8D+kErdmKCoR62J1xPE1T
	6HzzR2Lzs+3uBVIrZs6wERSsfu6vc5fnuTGWZXxBOOSnufoZM9Vp1mzYz3vKfEhI
	D155+e6UrDw5JZVgx8mWx008T5E/n/qmyuW82eaYSQavfkm06mIUcOUJnLpuqAze
	3WXPDhOcPv+NSX5XvmAkFZq0U2y4paqF2v99MI1aFhSRR5eExU2n2Mai38VwHYcY
	Xqb3AyY5hqgF6ZVxnEPA0g==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 484q72stcc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 27 Jul 2025 15:39:24 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56RE599i038709;
	Sun, 27 Jul 2025 15:39:23 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010063.outbound.protection.outlook.com [52.101.61.63])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 484nf7e8r4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 27 Jul 2025 15:39:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mnD4ZVHP6ccGOy+izRCTkln/xhqArYexZ7rqb4HcqYBl9qXk29b4UtJDchwOoIwD2xumrsVWIfw0gFMIbnhInTSY1/WoafOFhm4KocGn9gppmlwv5OA1hy8Ef27hxP7NR63fs4VjXdm2sxthZfGs+QA7MWSI0MwTgJPAAnmcft16km8QunIklcwa65VK2jMFgDNpmIZ1CmrvHWIqwsFshcU7gRYX/9fUqlyxhEfgjkpy/h5PHotTWPZGRBYE4PYlFUG3uABo4yjoh7cMelFfZZ8Gw1b4+nY7V6xGrY4wQbqh+cFhkN7V86BAm4XXkYJwvfliAszrpZTME6hOFnk3bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uk8diW4FCDZy+ONLROfmr06ffNG7JYDUNFRQh9XINnI=;
 b=uXfPvo7qjeMtgmIBMOAjn74rOObxxk8WMJI0rF+zOev/8u8y+XH0/UOgczLjX6vF7qlR2fUB4kQIxtO4u2VEJDGx1kjyu0nJ6UgH6+TNT+kGqHDFmEHFxV5rkyGW0DKBuxjNbFbWoyj5okkLW1cogFee0EtVMbh/Z7bNQb63fvCug932Qrp/AjUK3rJaIoMLMwIqQLhnumrVZsFJvnSbib+y6Vv9oKiswR+REgSE7YOQE6EbnGXtzFwL40qMijTm9Qj+S8ahX6IIC15u4DSI4ABkTI3G3P06YLFDr1jyb9kFa+ceZi+ilThz5xcve8KaHQLldiQaBxNGKA7qLldhDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uk8diW4FCDZy+ONLROfmr06ffNG7JYDUNFRQh9XINnI=;
 b=PTf5Gse4KpPfbEnInpxjlOLxXBsryleOwzRxEn3J3eDJ8YndxIOiMgKEhl650KtgZk+YajRqPg59tDBGes+GcwVQILnUM7ATsClL7axhycASGw/kx2jo2NzSntfM8UEA+NbGtu30aeP0AUbPo660L/r88pafs+pUgA0xZ0GkCD4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH3PR10MB6692.namprd10.prod.outlook.com (2603:10b6:610:148::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.24; Sun, 27 Jul
 2025 15:39:21 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.8964.025; Sun, 27 Jul 2025
 15:39:20 +0000
Message-ID: <4db9d3dc-a2a3-4907-83bc-8bc07e38b265@oracle.com>
Date: Sun, 27 Jul 2025 11:39:18 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/13] NFSD DIRECT and NFS DIRECT
To: Mike Snitzer <snitzer@kernel.org>, Jeff Layton <jlayton@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@oracle.com>
Cc: linux-nfs@vger.kernel.org
References: <20250724193102.65111-1-snitzer@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20250724193102.65111-1-snitzer@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR18CA0006.namprd18.prod.outlook.com
 (2603:10b6:610:4f::16) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH3PR10MB6692:EE_
X-MS-Office365-Filtering-Correlation-Id: 591a6055-08c7-4e3b-864f-08ddcd23c140
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?V0VtNXdSVHk1UmJScTRYOVhWWEVOZWdLeFhCODhxMVdDUmFHYS91dVU1emJG?=
 =?utf-8?B?bHdZd3gxZCtHWjRiRGZ2QlMwQnFZcDNkS1dNUUh4aVhpd2hUb1JzbCs3aUli?=
 =?utf-8?B?ZGdMYkY1NVRoSnNZQ2MrU24yT3BieDYvanJrYUhZMWJNeVR6SGlwaVBaUDBF?=
 =?utf-8?B?WkRwdTI4UGhVN2phSytQNkYwUUhnVmE2Z2pkUXpLWTZJWmtOZHRYcFRqdGRS?=
 =?utf-8?B?S0dGbHN0ZFBIUlRJajlKUmpVdTQxQnQ2NmlZNFJTeG85clZFOGZUTUlSNUVD?=
 =?utf-8?B?VXAvRlArSENjNGx4cHcxQXdrU2FvdWkvVHVFbFpwN2hYS3R4WG82VmxkWkxX?=
 =?utf-8?B?QnhyU0VWcTV1RGx0SHlKK1JObVpxYUJYY2N4clhHbVIyT29WZmZzSjZXTnBT?=
 =?utf-8?B?RXR6SlloelZGVEREeUI1QVB0UkhZVlg4aTNKenR4RFJUOGEralVBQURCcjl2?=
 =?utf-8?B?aE9kMmZndmJNMFY2aFl5SThxbVplVTFIMG1xZjFjTXVHMWlSbjV1bTZUUVVM?=
 =?utf-8?B?NXRoVDJCeEtyenlTcUhnSEVhdko4N0hsaGxaR0o1UlNFMWlLZzNOYjNXTnFU?=
 =?utf-8?B?Q0pOYWFjUEd0MWpBa0tPK05UbWdYUWxld0RHdXVoSzgwbUxrTjNRcGJmSm8x?=
 =?utf-8?B?dkNFUEVTaEs0eklDU0VWSm1GUU9UakhBY0tWbU1IUm5xSy92ZTM3L3JrbFZ3?=
 =?utf-8?B?QUU0ZmtLSnRqbDd5d0JTUVlwWiszdGFraWxwd2NmR2xwVE5GeWFpOTZpVURB?=
 =?utf-8?B?ZjYzZnRxU2hONjRENHlqZEFsSDJOTE9HQWkrdWdUbjJzN2VGZytxNHNJT0hT?=
 =?utf-8?B?ZGpmdzRsT2VsanR6dDdta2lwQk9zMVJGZVM1WkJpOU8yUTNaaEhtYlErMUdE?=
 =?utf-8?B?dXhNZUJPY1FaeEcxYnNzNkNLblY1Sm1YY01sL3RQNUVKUTVzVWNNeFZ1ODYy?=
 =?utf-8?B?L2tnWGxRZXlkRXBpOFZ3MTNZM29kTlk5S0pCRzFoVzdVbWdTdkFlNk8xb2FT?=
 =?utf-8?B?YUt2dGFmZUhFeUw5bWwzalA5UmFwM1lKWmlxRE1LOXVyN1BFYWxVRjhnZGZu?=
 =?utf-8?B?bTNwUW1IV1Zyd25xYXdTMlZaRVZQTG1EUTdkbG1IOVI2Mll6M0JiLzJ1WTEy?=
 =?utf-8?B?K3VGRVFzOWsyTEU5NGpQaHBNT0xYOEhuem1NbkswZ1dlcmE1N2hOUmF6Y2lo?=
 =?utf-8?B?V2VtaU9walBrc3c2UHlUWlFNc3VjMXEyY1FBL2IvV1haZDRrWVc2aFZpaWE5?=
 =?utf-8?B?bklBMWpDUzBlVEt0VHBWOHJCenF0dDIvc053YnRqWU0yVnF6emQ1L05wSDQ1?=
 =?utf-8?B?QjhLUzJUYVJ1VVRROWtTMjIxcWNrRzZ2QlhyV21maEZPWHhOZm1kSnhvbzlU?=
 =?utf-8?B?NkNKSFlrQ2hFZFh0TVFwZTJrZ040clBrQmU3WkUrUTdYTUc0VUNscUYzUmNi?=
 =?utf-8?B?SktPSUdIdkZuNWdyY1lnVDdjbHN5UXdmTjlnNnhkenhYQmNzdkkvVGVQVDNZ?=
 =?utf-8?B?YmFNc0ZkbFdRVEQrOGliTFppRXVoVmpNd1hMWDB3NWcybytqV0FVUHVjV2w0?=
 =?utf-8?B?N3IzOFVsVDdxVTZTa2pGTTQwWmd1ZFMweE9wZlp2UzFTTFZSNk5BMnpMbFcx?=
 =?utf-8?B?Tk9CTTEzVE1UL3oyYzByRkdEaUdVMU5rRUJieC8xa0laRGNaeTN2dmtBNzhl?=
 =?utf-8?B?S3VEaERuVEQvVGRCYUhSVVVXYjNiMitBdENOOHc4SjhuTmo5dFFlQ1Rpdndx?=
 =?utf-8?B?Zlk3emZPVmFxMHhGZUxzdTc2eUU0RmVUanE4VWJkQVhJbkp3MUVPU3hPN1Ey?=
 =?utf-8?B?VmVidXRZSVNqaTRkeTc1WVFnUDQ1MnVDdTNyTTY3MHNidm9FUm1ESTFmUFcw?=
 =?utf-8?Q?Efv5KkZrpP3eJ?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?Y2hkdi9ndHlNUEMzaHJIS1JOQW05V2pQbWlUc21hWGR5aE9oL1oxSno3ZHJV?=
 =?utf-8?B?cXo3QkJBRE9PamticEJkVWtIUEIrYVpmVmtBUkltdGtvT21GYTFtdi9pRDlp?=
 =?utf-8?B?R3h3ZmtkWllXc2M1Rko5bTdEbEtsYlVrVVdLZHBndW54V2d6ZnJCdkpWczNu?=
 =?utf-8?B?RGtRMGthdlZXMWYwSGlJb3Y4WHVaZWxDU3hiZUpkcjZmbGlXd0hMOEFnMDlJ?=
 =?utf-8?B?RDVGWnBiaUpHdUJHRWlnNGNsR1QzS3dHL1BXNDFOWEUrVEFLaHlrWlk2Z0Qr?=
 =?utf-8?B?bGZPdHZ1ZGhnMEhYUFJVSDZMbksveXdscWFIbUJxR3M5UVVkQjdYRnkyY1d1?=
 =?utf-8?B?bjVpc2dyT3JId1JTZHlHZFgrOERaWkxHVkNkZXZ5TkFnWnd4bDc3N0EvUGVW?=
 =?utf-8?B?NmJFd3JQRGlXQ3ZpTy84UDh2aWEwek9zUzNKaUdGT1ZTOXo1VXRPV253cGJi?=
 =?utf-8?B?Y0pGekhXa3duZ2x5MlJFelBjUlNwQnBOdHorTXROcHdCcnBCWjBtT2h4WFhz?=
 =?utf-8?B?RWs0bnlYUTcxVUFhVXkyRldCdDVlVWU0STlSTWtodDNhaGduVCtlWWRlaG9B?=
 =?utf-8?B?bWhrSFdkd2VzcEViQ3hJaVlSbTNsVEJianBkOVFLVUZmUmg2bDBUb2VwcDVN?=
 =?utf-8?B?SnJJS1Vpa1g3cHdYeWkreVd0bnF3Q2RwZ0RKTGZ5Z0dqdFNyVEZEYTNpaXNZ?=
 =?utf-8?B?WkdHNHNSS1pNc1ZvY2ExNlcxL2tTbndKRHg0K2VjK000L3NhYkxRQi9wbmVa?=
 =?utf-8?B?TitaNHZzc05EVmtjVXFsZm93enZUazFReVdLOS8yd0JkZldGUkNsQXdJcXA1?=
 =?utf-8?B?cm1tbERVVjgwcEkzSWNhcU1uazQwSXo1OHZlUUNKWE0vNStoaE1FMElJd3hV?=
 =?utf-8?B?OVk4a3U1TXMxYjZ1M2gwdGFPNGRHNTZmR2xsV2VnS0VLdTdHU2Jnb2xGYkZw?=
 =?utf-8?B?eC9zRnhPd2ozZkE0UjIwZktDejAweXZLVm8wZzBsV3JCMlp2VFQ0a2E5MGpm?=
 =?utf-8?B?Yy9HeFM3aEtKV0ZqVGtiYzBvd2lSd3Q3SitXMUtLc0V3elVZdTBQaXFFQU1x?=
 =?utf-8?B?YkpLTWVONEJWb2cxOFRXU0k1NHhqUUpoY0JadmpVL2dWNVNXMEJCOU9URXRK?=
 =?utf-8?B?bndwME9LRG5wYjBMMXkzQTZnZCtpU2VLRm9GLzE0YkNjVXVkSHdQRmlua1Rp?=
 =?utf-8?B?aXo3cm9lTmh4ZHJuSURZbjFoMlNzeEo2Y0NuU1ZITE9OaGNnejNWYnZBc0RJ?=
 =?utf-8?B?ODJpN0JLL0ZXMVo0VEdDcjBITy9ldXZmdGh3YWVJdWdoRDAyVzVtemdqekdp?=
 =?utf-8?B?a09GaEFQdXZtdXpqZ1B0UDBsdzVOSHpRSnc1SXk4STViUGk1aVFST1RUZkZH?=
 =?utf-8?B?OU9QWDU4Q2x0WmtjdlBoZkNDWjBiZWk4M3YxRG9Rc0JCK3ZacS9FaVdWL3Z6?=
 =?utf-8?B?OEtya3pHdDFSNnRsbTF6emxtbEF1NFFnS2dFd3dXTGNCWGFoakdxU0l2dllq?=
 =?utf-8?B?Qy9wOGtaQ1MxUktvWUxLeWxxMW8yK3E1aXAzS0k3a3pMQUNKUDdDL3hVOFhk?=
 =?utf-8?B?SkdZa1RSQmxDWk5YMmZIVGhXU1VIZG5zTjBDbmpNV2xnNUpicXI2SnQyMlNn?=
 =?utf-8?B?aCs0S2tIck1MRWZtQUhPT2FuUVpac0RqeFIxZ21UYzltY3h2TXRaVUJPdzBN?=
 =?utf-8?B?QU43bGg5MXlNUm9WbmVabmhpRzVyc1dEcUNaMzFrVmtwbnRrR0dCdDFvRUxo?=
 =?utf-8?B?T1ovVkMzeWJCWlpaemtjTnVNNGlZR1VtVTRhNzE4Y1ZLSlNrTlcyeXVCaFc0?=
 =?utf-8?B?cStrWXVnUzYvNzNIbXp1c2pMSk5KODNBckl0aVl3Ukk5N3hKeDc1T0hLb3do?=
 =?utf-8?B?M1g4RW81TkF4dWxPemRYaERrMURWS09xTERhaXIyWTNhY2x1empvRUc1b29E?=
 =?utf-8?B?bVgwOCttTVdPRkJMZHR6RHRMbjZuSTBUSVhBZXlsUzFlQjdXK0wrVDJEVVZE?=
 =?utf-8?B?V3pQWDZxM3owLzBVejNUY01naHNlL05OcEd1bHZCYXNLRXhMVkFGdTJqY1ZZ?=
 =?utf-8?B?V0ZWRmh0S3JldkRWQzMzeHQwSzVHeUx0eENuNDR2NlVtKzFYNWVnSmwzb2pB?=
 =?utf-8?Q?dhBvgppTbH5sx1c4kpdVpAnhm?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	hrOTs76w06l/TXjaO1LlQ/GK7LEldENieYB/zvgcv2PaX/W+10BGkZalAPd3/GzsTrRbGdw0oL2aHiT+uETCc5rXfRnlD/weGDZlqRL0mZTrJ4ebbCbEH94JSWvKxskktXsQ1qjchIiEXH71Klf9tYCavoiPLMxrBW+SQ8HHcJ1j6JY6Zz+62xqRAU20j3wcv4RMTig3Jo4+S0wGSPOl1dWnaTKl0AgXhw5O/iaQW4zGMiz66STmDgWk3Gqdmnta9YVL/XrtbA9rDfgMoOKUN2RbqB7bc0a2bRnGs9aWdN2Tw7Rddt04VjFbYQBWYUN1gQxIpqD/1gu13BwDKJU9GG3pp/H+bTmXGRfa5bvvcCPtHkdt5R0/V9iTIOPfocLstYl9jpa++Vx7F/zoRz7i1O2fdoFFIqX4AXTXwf3+nPzf/mY+sZXecgdk0Ah/8CnLkdCwaBxqf/N44HIx31MlEfPofXoqxQAKhy+LPg9EBxofhncHZi6hQsoKR/oergZRdgTFnifA9VBgggXwhi7mvJcKMAxXPf1laMlDvfjg2k3Y5nDHEqBS5sov477hoi0tF+sZQc836iZ4pN0k38w0SzDvL8Ve5YJvHGNYRi7fdLI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 591a6055-08c7-4e3b-864f-08ddcd23c140
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2025 15:39:20.8316
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yg1EK21BRrpNfN8Vy/53pthw4qiRmNqGszS4L/kfWEgAcdPLgLUPtEX03EGK3uqEDl62/dgnrwMUpb30asSxJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6692
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-27_05,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 spamscore=0 mlxlogscore=804 phishscore=0 bulkscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507270139
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI3MDEzOSBTYWx0ZWRfX+N/X356oxVrw
 SE3LxUfMwsHnx4plXQOtUTpbMcsibHJ0RqAzadsMHNj9RwViw2H5mK8Ti/MVxQ2hjq73C1axbWO
 pGC7qH1DTDYbm7UJ3OCz1DyXAo42y6/m8I1K5Z88XTIuqhFXygMHtC66Yo9gPNPYBYBDOT/4yqx
 I+IKt+d1DHwR+jBQuScbRY9C26/aKIP4NJtndIdr8td6Y9tLhrzU7wpYI2NcJxcc4jVTXnwrCu7
 kwb8Dr4AAswN3bPZCQJvF7xgEK6FO61VTR4xcMncyIH5GdEkUKQoDgstxD/W9j8z7g2Sz8Wczzl
 AJc7ZgoSajTqxwP7WntYv966kI5ja/r8+gAKqZeedcAs6ZgCwGGqnrfQvqntHQef9SPxwk1CNin
 CUTkc/O2cjjmF9kLyVbcUl2YHmJjz6PFTkO/v3RV51jPYHrBuLqIsTmJTr3n6UdFvsYJxfcE
X-Authority-Analysis: v=2.4 cv=ZO3XmW7b c=1 sm=1 tr=0 ts=6886482c cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10
 a=VwQbUJbxAAAA:8 a=WLGaNtMBAAAA:8 a=pI2baHw7ixXgycOlR6cA:9 a=QEXdDO2ut3YA:10
 a=gcKz3hfdHlw52KqWNJGX:22
X-Proofpoint-GUID: X9OWvPdvqtj1J4EnAtKAmISQNHWmv-S-
X-Proofpoint-ORIG-GUID: X9OWvPdvqtj1J4EnAtKAmISQNHWmv-S-

On 7/24/25 3:30 PM, Mike Snitzer wrote:
> Hi,
> 
> Some workloads benefit from NFSD avoiding the page cache, particularly
> those with a working set that is significantly larger than available
> system memory.  This patchset introduces _optional_ support to
> configure the use of O_DIRECT or DONTCACHE for NFSD's READ and WRITE
> support.  The NFSD default to use page cache is left unchanged.
> 
> The performance win associated with using NFSD DIRECT was previously
> summarized here:
> https://lore.kernel.org/linux-nfs/aEslwqa9iMeZjjlV@kernel.org/
> This picture offers a nice summary of performance gains:
> https://original.art/NFSD_direct_vs_buffered_IO.jpg
> 
> Similarly, NFS and LOCALIO in particular also benefit from avoiding
> the page cache for workloads that have a working set that is
> significantly larger than available system memory. Enter: NFS DIRECT,
> which makes it possible to always enable LOCALIO to use O_DIRECT even
> if the IO is not DIO-aligned.
> 
> For this v5 I've combined the NFSD and NFSD patchsets because the NFS
> changes do depend on the the NFSD changes.  In addition, I think it
> makes sense to review/test these changes together.

I'm ready to pull the six NFSD patches in this series into nfsd-testing.
IMO we want regression and performance testing of NFSD, outside of the
LOCALIO paths, before claiming merge readiness.


> I'm sharing these again now, soon after posting the NFSD and NFS
> updates, to hopefully make it clear where the code stands. Thanks to
> Chuck's feedback I have kept the patch "NFSD: issue READs using
> O_DIRECT even if IO is misaligned" (and will now finish NFSD's
> misaligned WRITE handling, splitting IO to misaligned head and/or tail
> and DIO-aligned middle, and will include in the next version of this
> patchset -- probably mid next week).
> 
> New changes in this v5:
> - Combine NFSD DIRECT and NFS DIRECT patches into single patchset.
> - Fix a "nsfd" typo in a variable of the NFSD io_cache_read patch that
>   was masked because the later " NFSD: issue READs using O_DIRECT even
>   if IO is misaligned" patch fixed it.
> - Properly include the "NFSD: filecache: only get DIO alignment
>   attrs if NFSD_IO_DIRECT enabled" in the patch series.
> - Optimize NFS DIRECT's misaligned READ and WRITE support to return
>   early if IO irreparably misaligned or already DIO-aligned.  
> 
> Thanks,
> Mike
> 
> Mike Snitzer (13):
>   NFSD: filecache: add STATX_DIOALIGN and STATX_DIO_READ_ALIGN support
>   NFSD: pass nfsd_file to nfsd_iter_read()
>   NFSD: add io_cache_read controls to debugfs interface
>   NFSD: add io_cache_write controls to debugfs interface
>   NFSD: filecache: only get DIO alignment attrs if NFSD_IO_DIRECT enabled
>   NFSD: issue READs using O_DIRECT even if IO is misaligned
>   nfs/localio: avoid bouncing LOCALIO if nfs_client_is_local()
>   nfs/localio: make trace_nfs_local_open_fh more useful
>   nfs/localio: add nfsd_file_dio_alignment
>   nfs/localio: refactor iocb initialization
>   nfs/localio: fallback to NFSD for misaligned O_DIRECT READs
>   nfs/direct: add misaligned READ handling
>   nfs/direct: add misaligned WRITE handling
> 
>  fs/nfs/direct.c                        | 262 +++++++++++++++++++++++--
>  fs/nfs/flexfilelayout/flexfilelayout.c |   1 +
>  fs/nfs/internal.h                      |  17 +-
>  fs/nfs/localio.c                       | 231 ++++++++++++++--------
>  fs/nfs/nfstrace.h                      |  47 ++++-
>  fs/nfs/pagelist.c                      |  22 ++-
>  fs/nfsd/debugfs.c                      | 102 ++++++++++
>  fs/nfsd/filecache.c                    |  36 ++++
>  fs/nfsd/filecache.h                    |   4 +
>  fs/nfsd/localio.c                      |  11 ++
>  fs/nfsd/nfs4xdr.c                      |   8 +-
>  fs/nfsd/nfsd.h                         |  10 +
>  fs/nfsd/nfsfh.c                        |   4 +
>  fs/nfsd/trace.h                        |  37 ++++
>  fs/nfsd/vfs.c                          | 200 +++++++++++++++++--
>  fs/nfsd/vfs.h                          |   2 +-
>  include/linux/nfs_page.h               |   1 +
>  include/linux/nfslocalio.h             |   2 +
>  include/linux/sunrpc/svc.h             |   5 +-
>  19 files changed, 875 insertions(+), 127 deletions(-)
> 


-- 
Chuck Lever

