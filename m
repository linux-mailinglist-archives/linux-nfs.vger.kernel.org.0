Return-Path: <linux-nfs+bounces-5093-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 257D693E0A4
	for <lists+linux-nfs@lfdr.de>; Sat, 27 Jul 2024 20:55:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7022DB20EBA
	for <lists+linux-nfs@lfdr.de>; Sat, 27 Jul 2024 18:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52467605BA;
	Sat, 27 Jul 2024 18:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kQkRKclR";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="T9gacZCG"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF4F179A3
	for <linux-nfs@vger.kernel.org>; Sat, 27 Jul 2024 18:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722106529; cv=fail; b=VmX5DPWDl07YtAc67di/GVXXPzYmo/RDrhUNT8FYZSi0E7dX51qA34TMvj5M4pevq/GPauo7fQz16WC65PC6bcXlv9Hcvogfgkt+0wIID6WhywM83qy3HLgaHl/ft+97H7oHG2jinQRhFvTn8c6GlHYroxKoQSlz1/wV35yluBc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722106529; c=relaxed/simple;
	bh=lnOHPc40clwSgTDolkJ207awUXI+RHddSGKPr+lQ9lc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=d87FcBAVM9W7XKdOhi/TSNUVOadV1DIDURLOSp6Kdh1l5OQmu74b1RTMQ+osyI3I1MEnAgJI1OJZ5CCOsNEjtTdrlekfRJJBFTAw3uN3WNiXsvv04w9mmbGmOz8Uy0Qc50/E1UE8VyEONJZYm9ZOu7UqDdGc/H0JihCALezGJw4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kQkRKclR; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=T9gacZCG; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46RIgBW8027274;
	Sat, 27 Jul 2024 18:55:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=sE5+W8ZjiMqMnqyg6iy5l4FR3eilB90C72Sd9IIqg34=; b=
	kQkRKclRRujngMXCpGr0JqHyk38lhEKnvjvMMkcOgx8+DtZFCIqL7wTOo4TIdN/Q
	nDGKtLU6OaMSiiX5/0ZdzlL6+LNT1GBDsHSBe25voY3jKca1lj8osIIYj53AHNw5
	r1VjuY9w8AOB4h1KCsPeDMkXwhUxxQVOiZA3oDauVC2rGoUevurj4ulKHBE4UqSA
	IdLAujNqLwhpSfaynJzc1FGMNtr64VzG14ETB5uiP+McHFNW+CacjvvUpWZf3Bgi
	q41NfD5G4wl/70kxrira8sH3Ezn39YYOTejGtuT1HxYa/yARNv9IWpfDdu4T1n9T
	znEi3cDV9VChc5rT9OJgpw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40msesgfxb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 27 Jul 2024 18:55:12 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46RG5Dwn021069;
	Sat, 27 Jul 2024 18:55:11 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2041.outbound.protection.outlook.com [104.47.51.41])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40mqb6xx6k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 27 Jul 2024 18:55:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PfA9vFa7RE73K3EtgX3NsftqgFCzVfZsg7UrE2g3rmdpo+A/U1rGYXHNqbbSUQqnnoPioeh28HCtpjHfdSCFpZldVY5nIpyWc6kxdNglbkqTG6X8eA5QHUVj1Vnj5zZ1hPMVkhxilK8aR4mkD3+966zuOnhN4dFzLRXcklovi3Sy0gUsltdzQR/Dd5km4DDRLREfAhn7aZSrmfAfakJ/+7CSKe1rGYAbjD4Xyd+MdlFNH/f9TziFwsq2thUlHOO+tl3Wq/iPlRfSCvHKZl1dO5xe2Qnq0+c2Yf211X5hjrIw7sL9V8JJUN1XhieV82f8Yc0/bTFwbXjLgtHAK8tfSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sE5+W8ZjiMqMnqyg6iy5l4FR3eilB90C72Sd9IIqg34=;
 b=pPrYD3WDI5M2kBuXuXlNAuFAuKu43ITwrXQWz90l7yGax/N7g+iosUAmLgDfUmcPOAjoGa6z+D0CPqpaWURfNYlCBwO9AYQdBc/M7upl+8fF87ogDJ2JgXFiRTqaX+zwOgM/KwGq512VxvZ9qLCsUL1DaLgAeTajsGk2H+dy9dlOkswlfhGiEzLGwRcm4fh63zcD7Ej/m66zWpMbwd93PTs4vJjER79yQ9N+oiupCQSFuRi0IVZ+Nq9ISBWU+FJ6o1WZW+QdA4LZiTj/npG9WWLGsTzZ5DLSQSFsb4kvX+nbJp+zmt8TRBMATMfoo8GoFIXzb3b+ugc/B6+PsgJ6Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sE5+W8ZjiMqMnqyg6iy5l4FR3eilB90C72Sd9IIqg34=;
 b=T9gacZCGPnhjtdN4jOjmMszoom+z2Bird/49E0/QeYlKoL3e5diNmJQXR9z7pwa0Pk+CjyEa7HsC/cWfMu2tKtwE6iAiwHxuY2sardAJC3Ww/IU1Db+A/eEq/kyYNKBd3cZCzYRCYhzBC/SHpAkaag0JAk7ZV1oPLkO1+Tm3ZN0=
Received: from MW6PR10MB7639.namprd10.prod.outlook.com (2603:10b6:303:244::14)
 by DM3PR10MB7912.namprd10.prod.outlook.com (2603:10b6:0:43::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.19; Sat, 27 Jul
 2024 18:55:07 +0000
Received: from MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6]) by MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6%4]) with mapi id 15.20.7784.029; Sat, 27 Jul 2024
 18:55:07 +0000
Message-ID: <c1463e37-ae0e-47d8-93d6-9787ff35c989@oracle.com>
Date: Sat, 27 Jul 2024 11:55:02 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rfc 2/2] NFSD: allow client to use write delegation
 stateid for READ
To: Chuck Lever <chuck.lever@oracle.com>, Sagi Grimberg <sagi@grimberg.me>
Cc: Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org
References: <20240724170138.1942307-1-sagi@grimberg.me>
 <20240724170138.1942307-2-sagi@grimberg.me>
 <df15b4f4-e325-4ed0-bc94-957113a64915@oracle.com>
 <ZqUl0EyyJYJhsItg@tissot.1015granger.net>
Content-Language: en-US
From: Dai Ngo <dai.ngo@oracle.com>
In-Reply-To: <ZqUl0EyyJYJhsItg@tissot.1015granger.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR14CA0013.namprd14.prod.outlook.com
 (2603:10b6:208:23e::18) To MW6PR10MB7639.namprd10.prod.outlook.com
 (2603:10b6:303:244::14)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7639:EE_|DM3PR10MB7912:EE_
X-MS-Office365-Filtering-Correlation-Id: c277848e-d7c0-46e0-0966-08dcae6da1c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NmJ0OWljZmRmSHZKcnhPVjBsRFRtQUM3amNBTUp6MUZ5OTNPQyt3SkZDdnRw?=
 =?utf-8?B?azlLVGliWnA4NEp2TlZMUTRCWlV4bWxFblBtbnp6bUdxL0RjdmNWM3V1WFFk?=
 =?utf-8?B?QXRHUktpTTUrS3dvRld5dDAzc3NHeHBJWVFTRjYxVTFTNUdmRHlaS0x3MGNj?=
 =?utf-8?B?Ly9qVzRJWUlvN3dhenlFcmxhZ0REaEhLQnVTTzl1c0RkZ0ZTSHl5OFBKdTJS?=
 =?utf-8?B?Vm9XdElrRzR0cVhvVFc5VzROTWVLV1k0ZjdkY3FOdkVOaTZ1MXZzbDRBVm1H?=
 =?utf-8?B?TEJtTmxYdWJCanpYS01aOTh1N2xHYmZYQlZULzlqS2hrRi92N2lzV2dEMTlG?=
 =?utf-8?B?WHkvNElDSzlTbzdmNDRXYXNETGZWRTczOHdpdVdUK3prT3JaUU9GSmdTWlE1?=
 =?utf-8?B?SkRsWmtsTFZaRmh3YzYwZ2R5M09wTjF0WUtWUU1RN3BwZWhBY3RtOGVZYm1x?=
 =?utf-8?B?bWZWSDNvczhEVUVRN3hpa3A0TW56QVNSYzhFRlIwSFM1WlNKblp2ZzRJN3F2?=
 =?utf-8?B?WlA5anJaNlRYQ2dHb3lyU3BYZXpsT2hyckZMbnU4bDVScnFFVmNIQi9MUUNt?=
 =?utf-8?B?NGppdEl4VjJieTJlQXM2YitjeE1oLzY1NldIL3VEMFh5L09BcmdxUVBEWVJp?=
 =?utf-8?B?TXp1UjNpS09ORGdRWEdqZGxtVktibFYyWXAvbWx3eTNDMmppdnJ0RkdaNkdj?=
 =?utf-8?B?WWV1QTBGNTVEcU8yZlk5V092d0ZYZnkveDJKRnNuQ0EvNktib0JneVc4VGtD?=
 =?utf-8?B?R3pzQVlKQTNSNC9XaHlpVDg3TWIvTGlRclpheTF2QUFzTTJHcUcxWjBLODUr?=
 =?utf-8?B?M0U0YVFCcFFITko4cnd6ZDduUGgvTDJDMGVzWXlBcE13WHpiWi95cVRXSXRI?=
 =?utf-8?B?REN1cFRjaFJmK2c4U1QzQ1F1Y1JSWW15amc1R0lPNkF6NE10SGJIVzhrT1pJ?=
 =?utf-8?B?Z2FLeUJBS3c0bWZlTDlpL0duYWNNTVNGZElTZXlIeVVqRGFsZUUzRmRoTCtw?=
 =?utf-8?B?NDJ5SXZXMC9tV2c5L045ck1ZUGlkZHBSQ25ORERpbTVkN256SzUyNDlPQkFR?=
 =?utf-8?B?a2hIM055Nk9rZE9zb2VQK3NBN25UMldyKzFjQTdTeTg1SVU4d2tUV1hoOWlG?=
 =?utf-8?B?SUxlVHgrQkZveGFMejMrdENESEFMK2tjblhaMGF1NnptM2hiZ0tOTzlnZlJB?=
 =?utf-8?B?SlVuSXI3QzlRNzlSbmJVSkVNajR3dHZ5dmY3ampQL1NRNzlBRjRzaDlkYWRm?=
 =?utf-8?B?Mm9RYVZud1dhRUxhZWxXM1VEZFVhUk1NWGpML1oxdzFiVmRma0Jxd1Z6THcx?=
 =?utf-8?B?VDlQSXl4M1VlbUp5aWZTUVJZbVE4RHlIbU5EUk1xaG9WUDNoYjBZSndVd3l2?=
 =?utf-8?B?Ni81MVNxQ2RpM05rWTlVeWNyTTZKVGlsZVcyMUtpdEZoR2llUXgyeEF4dGNO?=
 =?utf-8?B?UkNzUTFuellnZmdtblM4bVZoT04xU1o3S1E0dGFrN2JkUWhjYnVvd0dRdlJS?=
 =?utf-8?B?eFJrYmFnL0hKcFpEclUxYldhSDBDZ1laT3ZuN3NKTUNWMG9xNEMwTENwcEJy?=
 =?utf-8?B?M0pNRlJMcU1uTThVSk1ZRDhkYWdVQmdxYWFJS2xMaW13QVFrTW9rMHBIVnBU?=
 =?utf-8?B?cGw1R3BhWXd0OVdSN0lINVduYTh2Nm9DVUF6RmQzTHArRnFrNUtmSDZYVGI5?=
 =?utf-8?B?bzBCN0M5bkQzZkROdnU3QTlSdDM0bWNWeUR0emtWM0NXVW1sdzNWMFdIaDVI?=
 =?utf-8?B?eHBKYVFUeklEcmQyNE5kdXBHWlFSWERPd3p5YVp6V2pRMnJ4YWlEcGhIOGxN?=
 =?utf-8?B?UUtVbjRkQ1NDUnE0citLQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7639.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MW84anZtWFVOZVkyQWs2bmlic0ZRcHY2MVFSK3hIRjVReU1rZ1diUGltdTQ2?=
 =?utf-8?B?Z1dxOGovTGo4bVB4cFl6eUZtaVR3Wld6dkgzN1VkenMvSWNabVVDdnc5cVBa?=
 =?utf-8?B?U3FsNVBrVnd5d3B6aVozMUxqMjQrZ2syZGhDd2VQcEFmT2x2bGRLaW5JUS9s?=
 =?utf-8?B?QnpDM2NyYitpa2E5RFlrYm4zSis5SFM2dnZvNGVNNm9mcUdacG42Z2hoOW9m?=
 =?utf-8?B?L0tUZWRHUXJVL1UyRU1sajEzcHFycDhRWVFsMGpFekNHRDFyM1JiS0lFNzBC?=
 =?utf-8?B?UE1IWkl2aitUOXkvRnRGUUZZUXBhZTVDbW5Gak95NTE4OU1Pd1FJTzRhNTZk?=
 =?utf-8?B?di9TOU4rUWZ5cTJPUXlWOW9JQ3lZYWJaeXhyTnRYbHJwSVpWV0pSRll3b2lX?=
 =?utf-8?B?ckZyRHhLaURGUU91eU1zY2xHUnRCdDg5TURiWDMzZFJwS3NFcGFIY1dsZGtp?=
 =?utf-8?B?SSthKzc0eXI3a21JWU1MWEtIaitXSEJHQmUzVWtvclVhTkRWdkkraDdjTnJ2?=
 =?utf-8?B?VHB1cEdYOS9MLzlFNEZ3ZHVDYUl1bVBnNnUyWE9IRStRa2lUenpLUlVpVkx1?=
 =?utf-8?B?Qm1vbkI5MHU0My9ZbCtrU3NZeG92T1kvdmJCdFMwdEZqMzB6KzdpK1JNQyt1?=
 =?utf-8?B?ZzcvWG81aDM1UTBSVVVKVUdSVGJnajZKTDFrTFZmRU9zR2JHdzhqN010MldV?=
 =?utf-8?B?UDBrU0s5c2huS3dFOC9JbjR3L2VUOENuVDhKQjZJREFWcUJ3TVlRY0FRN2Jr?=
 =?utf-8?B?TmFoQ2JXUXo4TTMxSTFjcW5CalVEb2RnelBvWG5UYUR0eEtpVHFaZDlwdlA5?=
 =?utf-8?B?MUY4WUZ1aGo4eWlzOVBzSXptTHBHc29NY0NYbUp4YklVYlQ3a0dBckZDSU5B?=
 =?utf-8?B?Ykg1b080azJIUGIwaEJVSXFkQ3luNGd2Y2t4RjJ1Qll2TWVTZ051ZWJSczBF?=
 =?utf-8?B?SHZEZDY0ZVNScEVLbFczd1IzQjNWbmpZRGZIYWRvSjYrWnd0aU5ha3hkOE43?=
 =?utf-8?B?VVlVU3V5Zm53MEo1cXlmbmVsb3FWUjRwMUUvQzBtL0Yra1NKc1lZeVFsMXlK?=
 =?utf-8?B?MnBlYnFKR2FXSkxEOXNEb0dtb0x4MDZMRnRudnQ1ckZrOTJUMkRIMTNFbUdQ?=
 =?utf-8?B?QTBRazQwWnMxUytsZlBtUStib0l2ejF5NXFSSDhVMmZGQzU3OGNSZFVualVa?=
 =?utf-8?B?V2dIZ1VwbWZ6MU5ETXg3OFJWRWlWbzVLelE0d2o5eWZEem40aXNEemgva012?=
 =?utf-8?B?K2kzYWI2OTJyeGlTeHpMc3FwT2Mrd2xqcFhVMDREUDhYU3B2bnFTcUpDeDNh?=
 =?utf-8?B?ZGc5cmdUTXN1bGRGUzFxTUNXbnVjWVcxa0lza0VZMXBLbGZQZEF2d1pmdFVw?=
 =?utf-8?B?L0Z1NkltbVZNUEVvOTF6dmJEek9jKzhNbmY1MmI0WFlIUWxXcEo4dEw5clV2?=
 =?utf-8?B?NjRYNFJpTzJXN0FzUlBheDFmQ1RJRGR0dWFJZjllUHp4a0F2V1lwTm44WXN4?=
 =?utf-8?B?aG51UXovM2lObU1jNUkwMzlYdnc3NDJTWGVkRHFTRExGUGk0UlZIUzNhM2lQ?=
 =?utf-8?B?TFhzSE1UVDdwQzl0VkI4Y2paRGFOOENrcHMzeTdxV0NKNktrWW1qbFUyeFdU?=
 =?utf-8?B?VWJESDNPRFdwM2thYUM3NDRZVmRubDJlaFhBd1pJdHZZeVBkbW1DTlBaRmlW?=
 =?utf-8?B?eDlMc1ZHMno5UDFpTzd4VXphMzJxS3JlekhVMzgrNzdpaWhrVzg4SUNZS3Rl?=
 =?utf-8?B?eGFtWHo5UnpxV0pnMGNQWndlMEw0VzFGaFU0cHI1djJSK0JFejkzcU1pYXpz?=
 =?utf-8?B?T21XVHVvZXZnQk5GbDh2VmxkM2ZSWklPYUNjZzQ3ZVhYZUdIbUphVTdiMjJn?=
 =?utf-8?B?R2JNUzRXVEFxSzNrNXlJMVExdkJycitzbVJVKzU2cHVmRCtKOTVDbVRKbnZP?=
 =?utf-8?B?aHphYlVmK2tFeXI3a1RlaUdyY1pSc09aTzNseHNGQ3BPTk0rbUJkT3JNNWs4?=
 =?utf-8?B?SmxwRDJFNjRiSStVK09Vbkp3L2lvb0VsZGx6WWNUVXJJc2NBRlhxYlZlQzRa?=
 =?utf-8?B?SlFrd1ZpdldMS3dSK2lCaUZSY1AybHBjODJNVTdUUVRpWURiUFBOT1FJQXlC?=
 =?utf-8?B?Qm9iM1VwZWcvRFNaaWFDaVFFaThoOGNKYUd4UUJjRExhUXhKdVBZcERZVEQ3?=
 =?utf-8?B?OWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2mAT2yfwGmwoQ3CDmvnfVyFS2d5H9I8Lm3dpPSga3bjVi+SPpHyABhDx9YxtkDZ7ecKZSL3VuCGBqFDTtoatBw/B7RnyugrDQklp8Uot1qQnc2lLCaAH6gkwD5jvJj63fGr36uu9DQ4gqizkvtWP+Qe8gykHU8dWNwi6Ti/Dnxgk72q+IXFVBb33ijHW8Esxju1ZANscoPSDRD6bHRvclSM3+Ei4LyBEs2S2EEjE23Z0qYd3U8G9GnszjHKBdYtOx0CJ5NalYzeXFFAQj9HF4sSBUQaFwDTeQXF5KjmKSRjvgMRgvekrRK//gi9aZROAZOOiuQcpg4Jv+U/O95efRh+jJZW/xWKTVwfGVQe/waQt+a0j/KET1YRWgSULUKszK9ZRxgNm3r5t4LwHeOB8c2IHlfuRgKsrIvhkuQVcUL2FT3LVayIPrHjDp+wDAOlp+S+7dsJFDOsGIS84v6Jn69DYC8uZxCwyO35FczxVBHAOcXmlc/FwjQflQs6KM2vZZdP3hyLjPO6qJmGYuaQV1YJWCVyVTdl1WO1JUbvtlD6xHKE+gGqFVx67f9kEswj/hucqAUq+CdKuMqB9RJ4xxfAJ5D8C9e8/4cb0CB1oqvo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c277848e-d7c0-46e0-0966-08dcae6da1c8
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7639.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2024 18:55:07.0083
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v72w1H8GYd4gk7B0OXQFp40i2pwxQGTB5brqniMr+2SeVR3oOqd7E8TRGyexg+ra8su8y9yzLUHHWS1vCNYPvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR10MB7912
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-27_13,2024-07-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 phishscore=0
 mlxscore=0 bulkscore=0 adultscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407270130
X-Proofpoint-ORIG-GUID: 7WWvKmDzI0JBwCwva612fJSo4nz97Dk5
X-Proofpoint-GUID: 7WWvKmDzI0JBwCwva612fJSo4nz97Dk5


On 7/27/24 9:52 AM, Chuck Lever wrote:
> On Sat, Jul 27, 2024 at 09:46:34AM -0700, Dai Ngo wrote:
>> On 7/24/24 10:01 AM, Sagi Grimberg wrote:
>>> Based on a patch fom Dai Ngo, allow NFSv4 client to use write delegation
>>> stateid for READ operation. Per RFC 8881 section 9.1.2. Use of the
>>> Stateid and Locking.
>>>
>>> In addition, for anonymous stateids, check for pending delegations by
>>> the filehandle and client_id, and if a conflict found, recall the delegation
>>> before allowing the read to take place.
>>>
>>> Suggested-by: Dai Ngo <dai.ngo@oracle.com>
>>> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
>>> ---
>>>    fs/nfsd/nfs4proc.c  | 22 +++++++++++++++++++--
>>>    fs/nfsd/nfs4state.c | 47 +++++++++++++++++++++++++++++++++++++++++++++
>>>    fs/nfsd/nfs4xdr.c   |  9 +++++++++
>>>    fs/nfsd/state.h     |  2 ++
>>>    fs/nfsd/xdr4.h      |  2 ++
>>>    5 files changed, 80 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
>>> index 7b70309ad8fb..324984ec70c6 100644
>>> --- a/fs/nfsd/nfs4proc.c
>>> +++ b/fs/nfsd/nfs4proc.c
>>> @@ -979,8 +979,24 @@ nfsd4_read(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>>>    	/* check stateid */
>>>    	status = nfs4_preprocess_stateid_op(rqstp, cstate, &cstate->current_fh,
>>>    					&read->rd_stateid, RD_STATE,
>>> -					&read->rd_nf, NULL);
>>> -
>>> +					&read->rd_nf, &read->rd_wd_stid);
>>> +	/*
>>> +	 * rd_wd_stid is needed for nfsd4_encode_read to allow write
>>> +	 * delegation stateid used for read. Its refcount is decremented
>>> +	 * by nfsd4_read_release when read is done.
>>> +	 */
>>> +	if (!status) {
>>> +		if (!read->rd_wd_stid) {
>>> +			/* special stateid? */
>>> +			status = nfsd4_deleg_read_conflict(rqstp, cstate->clp,
>>> +				&cstate->current_fh);
>>> +		} else if (read->rd_wd_stid->sc_type != SC_TYPE_DELEG ||
>>> +			   delegstateid(read->rd_wd_stid)->dl_type !=
>>> +						NFS4_OPEN_DELEGATE_WRITE) {
>>> +			nfs4_put_stid(read->rd_wd_stid);
>>> +			read->rd_wd_stid = NULL;
>>> +		}
>>> +	}
>>>    	read->rd_rqstp = rqstp;
>>>    	read->rd_fhp = &cstate->current_fh;
>>>    	return status;
>>> @@ -990,6 +1006,8 @@ nfsd4_read(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>>>    static void
>>>    nfsd4_read_release(union nfsd4_op_u *u)
>>>    {
>>> +	if (u->read.rd_wd_stid)
>>> +		nfs4_put_stid(u->read.rd_wd_stid);
>>>    	if (u->read.rd_nf)
>>>    		nfsd_file_put(u->read.rd_nf);
>>>    	trace_nfsd_read_done(u->read.rd_rqstp, u->read.rd_fhp,
>>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>>> index dc61a8adfcd4..7e6b9fb31a4c 100644
>>> --- a/fs/nfsd/nfs4state.c
>>> +++ b/fs/nfsd/nfs4state.c
>>> @@ -8805,6 +8805,53 @@ nfsd4_get_writestateid(struct nfsd4_compound_state *cstate,
>>>    	get_stateid(cstate, &u->write.wr_stateid);
>>>    }
>>> +/**
>>> + * nfsd4_deleg_read_conflict - Recall if read causes conflict
>>> + * @rqstp: RPC transaction context
>>> + * @clp: nfs client
>>> + * @fhp: nfs file handle
>>> + * @inode: file to be checked for a conflict
>>> + * @modified: return true if file was modified
>>> + * @size: new size of file if modified is true
>>> + *
>>> + * This function is called when there is a conflict between a write
>>> + * delegation and a read that is using a special stateid where the
>>> + * we cannot derive the client stateid exsistence. The server
>>> + * must recall a conflicting delegation before allowing the read
>>> + * to continue.
>>> + *
>>> + * Returns 0 if there is no conflict; otherwise an nfs_stat
>>> + * code is returned.
>>> + */
>>> +__be32 nfsd4_deleg_read_conflict(struct svc_rqst *rqstp,
>>> +		struct nfs4_client *clp, struct svc_fh *fhp)
>>> +{
>>> +	struct nfs4_file *fp;
>>> +	__be32 status = 0;
>>> +
>>> +	fp = nfsd4_file_hash_lookup(fhp);
>>> +	if (!fp)
>>> +		return nfs_ok;
>>> +
>>> +	spin_lock(&state_lock);
>>> +	spin_lock(&fp->fi_lock);
>>> +	if (!list_empty(&fp->fi_delegations) &&
>>> +	    !nfs4_delegation_exists(clp, fp)) {
>>> +		/* conflict, recall deleg */
>> I don't see how we can have a delegation conflict here. If a client
>> has a write delegation then there should not be any delegations from
>> other clients.
> A delegation conflict is possible if the client is using an
> anonymous stateid to perform the READ.

Then we should not detect any delegation conflict from this
function.

>
> One thing we could perhaps do is add support for the use of
> anonymous stateids as a separate patch.

This would be a separate issue from allowing write delegation
stateid to read. This would be to detect the scenario where a
client using special stateid to read while another client has
a write delegation on the file.

-Dai

>   Sagi, how necessary is
> support for "READ with anonymous stateid" for supporting WR_ONLY
> write delegation?
>
>
>>> +		status = nfserrno(nfsd_open_break_lease(fp->fi_inode,
>>> +					NFSD_MAY_READ));
>>> +		if (status)
>>> +			goto out;
>>> +		if (!nfsd_wait_for_delegreturn(rqstp, fp->fi_inode))
>>> +			status = nfserr_jukebox;
>>> +	}
>>> +out:
>>> +	spin_unlock(&fp->fi_lock);
>>> +	spin_unlock(&state_lock);
>>> +	return status;
>>> +}
>>> +
>>> +
>>>    /**
>>>     * nfsd4_deleg_getattr_conflict - Recall if GETATTR causes conflict
>>>     * @rqstp: RPC transaction context
>>> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
>>> index c7bfd2180e3f..f0fe526fac3c 100644
>>> --- a/fs/nfsd/nfs4xdr.c
>>> +++ b/fs/nfsd/nfs4xdr.c
>>> @@ -4418,6 +4418,7 @@ nfsd4_encode_read(struct nfsd4_compoundres *resp, __be32 nfserr,
>>>    	unsigned long maxcount;
>>>    	struct file *file;
>>>    	__be32 *p;
>>> +	fmode_t o_fmode = 0;
>>>    	if (nfserr)
>>>    		return nfserr;
>>> @@ -4437,10 +4438,18 @@ nfsd4_encode_read(struct nfsd4_compoundres *resp, __be32 nfserr,
>>>    	maxcount = min_t(unsigned long, read->rd_length,
>>>    			 (xdr->buf->buflen - xdr->buf->len));
>>> +	if (read->rd_wd_stid) {
>>> +		/* allow READ using write delegation stateid */
>>> +		o_fmode = file->f_mode;
>>> +		file->f_mode |= FMODE_READ;
>>> +	}
>>>    	if (file->f_op->splice_read && splice_ok)
>>>    		nfserr = nfsd4_encode_splice_read(resp, read, file, maxcount);
>>>    	else
>>>    		nfserr = nfsd4_encode_readv(resp, read, file, maxcount);
>>> +	if (o_fmode)
>>> +		file->f_mode = o_fmode;
>>> +
>>>    	if (nfserr) {
>>>    		xdr_truncate_encode(xdr, starting_len);
>>>    		return nfserr;
>>> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
>>> index ffc217099d19..c1f13b5877c6 100644
>>> --- a/fs/nfsd/state.h
>>> +++ b/fs/nfsd/state.h
>>> @@ -780,6 +780,8 @@ static inline bool try_to_expire_client(struct nfs4_client *clp)
>>>    	return clp->cl_state == NFSD4_EXPIRABLE;
>>>    }
>>> +extern __be32 nfsd4_deleg_read_conflict(struct svc_rqst *rqstp,
>>> +		struct nfs4_client *clp, struct svc_fh *fhp);
>>>    extern __be32 nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp,
>>>    		struct inode *inode, bool *file_modified, u64 *size);
>>>    #endif   /* NFSD4_STATE_H */
>>> diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
>>> index fbdd42cde1fa..434973a6a8b1 100644
>>> --- a/fs/nfsd/xdr4.h
>>> +++ b/fs/nfsd/xdr4.h
>>> @@ -426,6 +426,8 @@ struct nfsd4_read {
>>>    	struct svc_rqst		*rd_rqstp;          /* response */
>>>    	struct svc_fh		*rd_fhp;            /* response */
>>>    	u32			rd_eof;             /* response */
>>> +
>>> +	struct nfs4_stid	*rd_wd_stid;		/* internal */
>>>    };
>>>    struct nfsd4_readdir {

