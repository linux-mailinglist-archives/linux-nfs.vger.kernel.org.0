Return-Path: <linux-nfs+bounces-10720-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57AE8A6AC16
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Mar 2025 18:33:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6203817F656
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Mar 2025 17:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 111A2223336;
	Thu, 20 Mar 2025 17:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HeuyULTI";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="br5rS+1p"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F1A224236
	for <linux-nfs@vger.kernel.org>; Thu, 20 Mar 2025 17:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742491985; cv=fail; b=kNtCs6GdGScJD38Z49WvRhYdGTF45BJueb9qM61HYngUVbM3ryveByncnhjZvX+6iCKK+YeUpWcsESwFTEmf2Kc/u/rkO5uj7zwQ6yRipvODHUIhOLLWwUJ6CIaqkStBc/i2i/w/qQUSh+wG+kIuy9Zr0qmreGa72uMbxFSIgZQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742491985; c=relaxed/simple;
	bh=ODqwhKWFmLvxFuZtzjXCGQGAp6tP3ZgfouI9OxUDFuk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=o3XZuipA2wIQZttjDsYKQSJ7MnZu+DKxoczoKYwto2IasDlv0LR+NQtSeVszoNR/MRl54lua4Z3Y4jGoh2RWnTIJfGWCLzHUj5NwAJnAdzSwmiORLog1ma8FT1RRij3WeFRirgN0O5aIOQf6RiKtz+5av05Q9f8qCSaC5cvxOaM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HeuyULTI; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=br5rS+1p; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52KGiuT1012246;
	Thu, 20 Mar 2025 17:32:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=f6qclbW7EbbmG2lhP3T2ylixHLs8B8wBBbAZb7AwY9s=; b=
	HeuyULTIHXdrzcAa/ZkNEsNxOSoKTWmqbDsEjeEYDdp8Ba8/e73SisA9ulQOh8i7
	RE9riVHHdOH5uiq49+TUBgAoqP2/Zvq2vtP/BIz9QBaY+fcun1uOysDUASewmFR6
	CevU9lN+KrlIL+FiGePoaECQdItMMzrWOQFjoFcgdmcG1hwxNXIePVidip1eF8Ss
	uOP9ixPqhTW675uqHite/Lox2dYC3Y0HA2BwKHcO/mV6FnZwihXDsOgW6LchgOvM
	BVQHga4K2ShXXx0TPukMWEiV4lP6O6yzAtW0zbfZnpTaJKIz/mKw+4cujd6d//vj
	w6NPTq4Pmpxeo8Lu8gq8/g==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45d1ka74h1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Mar 2025 17:32:43 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52KGZuQ6023051;
	Thu, 20 Mar 2025 17:32:43 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45dxejnvur-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Mar 2025 17:32:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eUfSd2JBgKk+ntOdj48ImR4LhaP04vU5m/DuV8Gcqa/gjHczxfRFSUqp5/DgBVTOVqROjPKzu5jC9v32GtyZF926useKJMPM0gnO7pruvxFhYc7RYWkpzutqN1h+x5McCQoZWgI71ZD8/Y7h4x3L4uAsMx1Iuv6fE9jolsBTBDIjOxL11Q6D/ng9nMT2pqJQthYsDKLt/pNiTb/PeX5maODc5oykQ3P/2JnWn3Y2z1A2NmXFgfJy+0pXeFMdfKjJTzqxNDxs8ifl4eZjiGtT/+rsZOo7kiOx9eGefIc231XDdcea29xeYloI2YhRBHDMmHedC0UqC4e/XLeKlhr/TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f6qclbW7EbbmG2lhP3T2ylixHLs8B8wBBbAZb7AwY9s=;
 b=Pt8RxKXnZuO6BkmypTyZtip7nc7KInrX50v1RcEFytSiTVcpX4hhGO222TVgbILC0K/EVLByXH+ZlBjhcaJrIdXP16SUZzECNOuiry+qYRcPo8IZoDLFXAUAhFQgIyat4edo9g+ioSIP9zfIRszlcS0AnAODxY620n7O/j12aUzQ5A+jCapsn8MmwtxzWO42ilu/5tjUME8isJfUhNvoPCcDnN7sh1VPaZfl0bgRvqsjchvy7MdBPMKRYUMuAmHCvIRplF4oaPqBdLqRVOS+xFAP5alcsOnu8KNrAk71aox4a7GEZKlQc/+/1civKNPwHy21FQKu+AKpxTKiuY7gDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f6qclbW7EbbmG2lhP3T2ylixHLs8B8wBBbAZb7AwY9s=;
 b=br5rS+1peBJolg5xAdKn1i/9vjAosOJCklT9ggaBOPdPXC6aG7h493ZfJWZJfWh1Qm303lS0PEPyh3cD4O5NUw/6U2e9SseSS2CfaSmnkR6lUSj6fq47IoEK8jd3SXSRThKXTGdLpBNnfw6b5gDgJWnVBpjXQoMJx8ftJUAMesw=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ5PPFD9B14F409.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::7d4) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Thu, 20 Mar
 2025 17:32:40 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8534.036; Thu, 20 Mar 2025
 17:32:40 +0000
Message-ID: <801ded98-5661-4e6b-b39f-2b3b7ad0981b@oracle.com>
Date: Thu, 20 Mar 2025 13:32:38 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] nfsd: fix NLM access checking
To: Olga Kornievskaia <aglo@umich.edu>
Cc: Olga Kornievskaia <okorniev@redhat.com>, linux-nfs@vger.kernel.org,
        neilb@suse.de, Dai.Ngo@oracle.com, tom@talpey.com, jlayton@kernel.org
References: <20250319214641.27699-1-okorniev@redhat.com>
 <c8262248-2dcc-463e-b76c-7beee2786171@oracle.com>
 <CAN-5tyHgjfGDnaJkKaPFmU4M1WJiGnUh0LRFJ3GT2bvXNMdM_A@mail.gmail.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <CAN-5tyHgjfGDnaJkKaPFmU4M1WJiGnUh0LRFJ3GT2bvXNMdM_A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH3P220CA0027.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:1e8::25) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SJ5PPFD9B14F409:EE_
X-MS-Office365-Filtering-Correlation-Id: c90b6815-7e10-449a-ea0f-08dd67d536b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UFloZkpRZEh5WHprNFd6aVptTDRCd1A1ZDFlbkpISElIdmNsZG9uNW4ycGp0?=
 =?utf-8?B?c3VmK1Q4Mmo4cE05cWJVVDJFeHpXbk1IdWtLbzZIazQyZitrWXArYXNpdy9y?=
 =?utf-8?B?akhyZ0p6U0ZlL1RGeEk5WURTK1hSd0lEZHdqR2YrNThRWWl2OUJEa3Z0V2Rh?=
 =?utf-8?B?clVMV0hHR0hXWFdDTkRnekl0VGhhcTRuMEoydnRuVXlWMmNvREJvZ3BKaDdp?=
 =?utf-8?B?a0E2OFhVUVA3dWhEYVEzZ0NSNzRqQWZEU2lOUWRCQTMrMmJPWEYyV2dIUVZr?=
 =?utf-8?B?QjNLdU84MEJtMW5Ed2tMTW92SlU3bkRQRzFmaTcyQTJDSWVBZDRDOEdFbWZM?=
 =?utf-8?B?TUdpNEpiZFVxL1NWK0MxQ1dLSGgvZVUwdWlyNExuRjU3eXNaRXdHcFdOR2lB?=
 =?utf-8?B?SXhXaXpkLzJWZ1luSTRBSjdMa2tCNnkzQi9EVHByelRlRlpFTXFIdDVqUS9r?=
 =?utf-8?B?QVEyTWZIYWRGd0hHUnlHVnEwTjBvRldYQSswc2hmZFE2OWl3NHVxd1M3V09h?=
 =?utf-8?B?WXAxL0hGVEw0YW1Zb0N3c25zclRqaUIxbjV0eS9nTWh3R0dlYk1WV2JCd3E3?=
 =?utf-8?B?bGJhZk56aUU1djhkM3gvQXhZL3RLWC9OWVdHRHBBR3c2L3lqSFF0VFZtK2pu?=
 =?utf-8?B?Ri9MTmlzWkJyL08ra0pPd3BaKzg1Y0FQWFhKSVVpbE1vTWJBaTZubHlteFNU?=
 =?utf-8?B?V2hkVkZaMDY4U0FBeGRSSFdhbFZMKzdUQUhnSjkweE5RV2lJaTJtOU5WTjZ4?=
 =?utf-8?B?bmNRdTg5bit6L3hCcmx2dzVsQ3NDZUdhUU85ekhHaEdtaXlYMkNNa09pK2JR?=
 =?utf-8?B?WHRVRXJJOU52ODluSDdjanVUZFNrV2tORmRZQjFvQlpmWTd5N0dOR0JTZ2ZE?=
 =?utf-8?B?M1dQM201MFNjOEc1clVNb3lYYitZb28vMGNIN0RHd0VUb1BmVkFoS1l3TFlS?=
 =?utf-8?B?OWRCTVE3V29KMGVtb2pxelJZNUhSaWc4U2d6cTl2OFNINjN1dERINW14Rk92?=
 =?utf-8?B?Z2xMckpHLzhSQnFZSTg4ZFZEK1ltS1FqNUtoY2wreGNlN3g3UlJJRitsRktu?=
 =?utf-8?B?a0Ixdm9RN2x6NnZsZkdQOXZXT3JOVW9RcHJ4NStyUTBwanIzbVZVd1I2QUsv?=
 =?utf-8?B?c0pjaFpFbHZEcG9iM3hJTW90U2dtbWpXcWRiN2ZzL1RsdEFkOE9HcklkMlcz?=
 =?utf-8?B?czdUdkVJZytIcHJaUVdwN08wTG9vbk5FSSszT2p0aVFNNUZHLy9lTVp4T1Qy?=
 =?utf-8?B?eTNraVYzbHUrb2xnNSt6d2IwcTJ5SEdKalQxbk9zRExzdmJRZFlwdWcyU2lw?=
 =?utf-8?B?NW5FZ2haY2U0RTZVOUZhczZNd3hjV3J6ZUVVVG5yYlcrMmhkYnpsSXpOeGtp?=
 =?utf-8?B?c0VyYXJrOGlDTkpwSk9RNzhjcHk0Ui8wZ2N1VVNpRFM0TXI1d3FvWnJENFR1?=
 =?utf-8?B?NzJGT3k4T0ZOVlBhZnhDcERKOXhqZXRxNXQ5Tzk4eVBxN2NRM2pxeU8xOEJ0?=
 =?utf-8?B?TGRJZFZYamxMQlU4ODhVZWtmbjBobE9iY1Zkd2tHaEhkUVB0ZU5mckFDK3Z6?=
 =?utf-8?B?b3lkTENZN0VXamtFaVNoWjlibFQxRzlpNlVoMHJEcFhNekFVMDQ2WlhVWjQy?=
 =?utf-8?B?N08xdGNpMnV4dEdUSDNYa1NmUXZEdElTVytMd2dhQmRsaHdDZk4zNjMweVBW?=
 =?utf-8?B?N0E3TkVhQ2Ywak03Mk90b3lUQWp5TkVadm9GRFFUM2FmZGVZSXpJdlVzWjB5?=
 =?utf-8?B?UW1UQitTbHZRU2FjNy8zSHowbmYwTmpJK2o0Sm4yblgyN3FIRWs5R21xNHM5?=
 =?utf-8?B?Y0NqQUQ5ZHFVTXI4VjRuaUNJZHd0a3JhU25FUVEwSXp1dm5hNndhMVYxcVp1?=
 =?utf-8?Q?tSeiTtyvirw6b?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N0lQS1NMcVRhbENLSDNheUZhNEFyMDZzbHZWSmhId1dsVHE4SzBVS2sxeEkz?=
 =?utf-8?B?dlBkbk5OUXRBZENrQlN0NUJUeG5pbkUzNk0ybUM2V0d5aVRqbnpnWXVwWVFJ?=
 =?utf-8?B?dHhBWStzb2t2MWFQUURFbGV1L3J4Vm0zTC9oVjlIOXdOV0xndXdjdEJ4bXc5?=
 =?utf-8?B?ZFZISVljQUxNQ1JQU0ZCUy9GRFYvYzFCMnU5b0pkWjVSQno2aUJQS09nM3JQ?=
 =?utf-8?B?cFJSV0JvTFJpUitPUlE2NlpWT2FtRnYwREdSV3VPbkhZWlQyeFFsRURSUG93?=
 =?utf-8?B?ajc3U2FJK2NjR25TTTI2Y0xWQW9kaStPOTFNZldTRDdvem5wYmpORk9MYmpq?=
 =?utf-8?B?akZVQklaTDRTSWNpSFFIV2txTWJwdTFlRSt6V3JBT2tNMFY3NFdabGRNQ1Bu?=
 =?utf-8?B?VXpZZzBBdHBFUEU1KzlCWlI4Q2xVMmZMRUN6a0ZZZCsva2xjOSsvSlo0VUdM?=
 =?utf-8?B?YytWWUNrUGdrOEVwbUZya0NCMXR1YXR2Qi9MN0xPcnprYlovdUhoVHU4aXhN?=
 =?utf-8?B?Z1h3dXR5akdIYVJlMFNHZjJoM0FoS3ZaUGIvTzNLbmJSeUVRdWE2T3Bnd3JS?=
 =?utf-8?B?RFEzMEJFek8yNDh0Tld2Zk1PZUw1ZjcwdEdLdTBESUV3eFZ2V01HRDBqaGMv?=
 =?utf-8?B?UVUyVjBoazN2Uk5lNHZpV2NQMW1OVnlIUEM3NHdmK1VlV0hla096R09oRFRh?=
 =?utf-8?B?Q3F2eEJBSnN6YjlBN3R1UWZJVTlsL0NuV0xsZXdtUUdKb0lRdnZlQndMald3?=
 =?utf-8?B?MEFRRmgrcDN0NWJNWVkrS0VwZllXNHN4UXRVemROenNoMmZIUDlYRHlZUDUv?=
 =?utf-8?B?K0ZzZUtFY2RmZmtiaFlDVHpNSnFNMkFTVE1NTjB2ZjJ4RThKa2ZkUitPdnRo?=
 =?utf-8?B?Qmd0QUVCYXFQbW9MYUxSVUpQdEFJZlVWNmRBQTRSclFhWVJkZndkZGpPOXll?=
 =?utf-8?B?Uk5rVi9RY0pGOTJMYmF5U2dRT1M3WXpTdTAzU21NMUhZK0VrMzBNT3BpUE1J?=
 =?utf-8?B?Q1BNakNweUNqT09NY25idFRqRzd2OFB1MlQvUGoxbUJKR2JUYWRVZ2c1Umhl?=
 =?utf-8?B?Y2JFeTkxQmU5UExjSkJxYVYyNkp4M2oyZC9FSVdha2RNTS9xRmQ3QWk4ZSs5?=
 =?utf-8?B?MitEbzBzcldGNEpxN1FEOG9ROVhGYWdLWHVoeXp4a1hvYkxjTXoxUkxzSmY4?=
 =?utf-8?B?d3BDbmV5clVuUnBzTGhQSlN5c1pmbzJTUjZPbWcvT3BWa3gzMVBIaGVXWjZR?=
 =?utf-8?B?TGFQV0w4b0lPUUovMERYTmM4Um9kdTI2SHVZbHppZkpMMHRFK2JSWWRScnh3?=
 =?utf-8?B?dnBqYkJQbE1jSEVQSzU5ZTU0Q0lENERQa3NqK1RGUHBZVVNNcUpWVVFCcDdK?=
 =?utf-8?B?SXJ0R0xUTi8xUjNmVWx4cjVHdjlzbkVmRG5qQkdtYmNkalU5MGQ0MkYvbUcw?=
 =?utf-8?B?clhKbEt4YVZTQVcwWGNJN2FRdC9hUkJGcGVRWWNKWEY0NFBtWU1xZFFkNEhw?=
 =?utf-8?B?OVpEelhOSmhHeGVTcnZzUzdFWWVMcVcvbmxHQVhnaDdEY3RqZ2VodkoyQkh1?=
 =?utf-8?B?bHduMjBtcHowYW5TSVcrTkZJVHltaWNVRUR1Q3FwakkvUzZWOXA0V3cxWU9n?=
 =?utf-8?B?UkdvMnBDLytQU2haNGo4L0NOSXhwM0FrTTdSK25RWDNSQ3VGdmxwa1dwdHMx?=
 =?utf-8?B?QmRHRlpRdHlMcEh6ckpJVDQvYnYrdkM2SFp2SVJzWEQvYklNWU5rWmJudGV4?=
 =?utf-8?B?ODBteVpMaCt1amQ2MDBDRjZlS01pL0pMcWlYMUxkakp6NnArR1lTTzRhSVY0?=
 =?utf-8?B?THJFV0JLRzQvSnhHUm5NSUJxc2piOVNKWEsrZC9PQjNPdTNDVXV5UFd1WXln?=
 =?utf-8?B?ZHFxdWFCeStZcVRwQVU4OWxFaU1qdlZsKzcwKzFRVjE3Y0VDYWVDZEpmMUhF?=
 =?utf-8?B?MXlXTkV0dC95dG1UZkJJMW5QelBuWHBVTk9Fa3pCOWM1WlE4eVM1YkhiWGRq?=
 =?utf-8?B?Qnh4TEtnYVV2QitvWUltTVJaL1ZWb2pUMGVKSVk5Z2tCREZJSUw0NjQvRUYv?=
 =?utf-8?B?NWFKMGFFSlhqUTRteEJKbytIdVlYeHNGVHFESlRMVVJ1QllhTHBZeTRQdHlm?=
 =?utf-8?Q?ReXM8IcZFCjM90mS//mr5pxxv?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	hbEdbqJSzs2IFU/Iv7tcSqLzGaxib5q+SrUWTmqKzdeRh6O004QRoqtHh9YLvnKOCemu4LP2CPolTbxjUmfURfn31Nztwmk/N0R2TNb2Z167jTwSni75hXfZxXoi3QaDWE6FK/z9l59S5Rgt4s+N7wVfGoj7dG03rU0FYs5XyNwtLugiP6FzdqYgVWQOxxDO4OVnRe8EeXDzkf37zo0udpduemdmfea06SEK2Hvwxg8FW99LEEm4n9k89iWw3yOQ6C4Q3laPnVzMKihSpXvAYMk5/WTUwtDDqlvlWAtbnF7pWe3dYy+PoAeo923bL1JnXao3CqtEPlVd9RLbpnUTPsNWJXi9H5amnI1YlSOnt631/OAqKlcTTpe73ft1X792d5Q8bCIhScaubWJEbY65bM0zQyAqOW8n1iTS6n89H28jv7nguY7mOlFla+BK/y4vE1iKhcXCubs70zdNkU0XDGm5V8vcfu6jGxEU3q8oMlo35n/DMm5Of7Q5ah8CYxbAkUT4eAjo2oY044DEOjEdZ1aCGcRxj8/EvGz8eHK6Sk42JXji+7XdpI11/VJlyZ7qAog0txE7l7p/invScy/5b52UYLVh6Al1BQtlEYCtdjM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c90b6815-7e10-449a-ea0f-08dd67d536b0
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 17:32:40.1220
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GX/scIxlfoJ0wJUcZdOHWTIULcPKuRTgidH3ALKkQ1GBQGySR8g4BBFUGKb+/JCkzJMbn0u7QbOkprxyEfXwoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFD9B14F409
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-20_05,2025-03-20_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 mlxscore=0
 adultscore=0 mlxlogscore=999 spamscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503200111
X-Proofpoint-GUID: ghCIHdJ-bCPOTY56h6L1H7pOpLwJg8Ek
X-Proofpoint-ORIG-GUID: ghCIHdJ-bCPOTY56h6L1H7pOpLwJg8Ek

On 3/20/25 12:29 PM, Olga Kornievskaia wrote:
> On Thu, Mar 20, 2025 at 9:58 AM Chuck Lever <chuck.lever@oracle.com> wrote:
>>
>> Hi Olga -
>>
>> Thanks for taking a stab at this. Comments below.
>>
>>
>> On 3/19/25 5:46 PM, Olga Kornievskaia wrote:
>>> Since commit 4cc9b9f2bf4df ("nfsd: refine and rename NFSD_MAY_LOCK")
>>> for export policies with "sec=krb5:..." or "xprtsec=tls:.." NLM
>>> locking calls on v3 mounts fail. And for "sec=krb5" NLM calls it
>>> also leads to out-of-bounds reference while in check_nfsd_access().
>>>
>>> This patch does 3 fixes.
>>
>> That suggests to me this should ideally be three patches. That's a nit,
>> really, but 3 patches might be better for subsequent bisection.
> 
> I can break it into 3 patches but all would have "Fixes" for the same
> patch, right?

Yes.


>>> 2 problems are related to sec=krb5.
>>> First is fixing what "access" content is being passed into
>>> the inode_permission(). Prior to 4cc9b9f2bf4df, the code would
>>> explicitly set access to be read/ownership. And after is passes
>>> access that's set in nlm_fopen but it's lacking read access.
>>> Second is because previously for NLM check_nfsd_access() was
>>> never called and thus nfsd4_spo_must_allow() function wasn't
>>> called. After the patch, this lead to NLM call which has no
>>> compound state structure created trying to dereference it.
>>> This patch instead moves the call to after may_bypass_gss
>>> check which implies NLM and would return there and would
>>> never get to calling nfsd4_spo_must_allow().
>>>
>>> The last problem is related to TLS export policy. NLM dont
>>> come over TLS and thus dont pass the TLS checks in
>>> check_nfsd_access() leading to access being denied. Instead
>>> rely on may_bypass_gss to indicate NLM and allow access
>>> checking to continue.
>>
>> NFSD doesn't check that NLM is TLS protected because:
>>
>> a. the current Linux NFS client doesn't use TLS, and
>> b. NFSD doesn't support NLM over krb5, IIRC.
>>
>> But that doesn't mean NLM will /never/ be protected by TLS.
> 
> But if the future NFSD would support NLM with TLS wouldn't it be a new
> feature with possible new controls. We'd still need existing code to
> all interoperability with clients that don't support it (and thus
> having a configuration that would allow NLM without TLS when xprtsec
> is TLS-enabled?
> 
>> I'm thinking aloud about whether the reorganization here might make
>> adding TLS for NLM easier or more difficult. No conclusions yet.
> 
> Do we need that complexity now vs if and when such support is added?

The question is would we need to revert some or all of your patch
to make that work in the future in order to support NLM with TLS.
But perhaps that is an unanswerable question today.


>>> Fixes: 4cc9b9f2bf4df ("nfsd: refine and rename NFSD_MAY_LOCK")
>>> Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
>>>
>>> ---
>>>  fs/nfsd/export.c | 23 +++++++++++++----------
>>>  fs/nfsd/vfs.c    |  4 ++++
>>>  2 files changed, 17 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
>>> index 0363720280d4..4cbf617efa7c 100644
>>> --- a/fs/nfsd/export.c
>>> +++ b/fs/nfsd/export.c
>>> @@ -1124,7 +1124,8 @@ __be32 check_nfsd_access(struct svc_export *exp, struct svc_rqst *rqstp,
>>>                   test_bit(XPT_PEER_AUTH, &xprt->xpt_flags))
>>>                       goto ok;
>>>       }
>>> -     goto denied;
>>> +     if (!may_bypass_gss)
>>> +             goto denied;
>>>
>>>  ok:
>>>       /* legacy gss-only clients are always OK: */
>>> @@ -1142,15 +1143,6 @@ __be32 check_nfsd_access(struct svc_export *exp, struct svc_rqst *rqstp,
>>>                       return nfs_ok;
>>>       }
>>>
>>> -     /* If the compound op contains a spo_must_allowed op,
>>> -      * it will be sent with integrity/protection which
>>> -      * will have to be expressly allowed on mounts that
>>> -      * don't support it
>>> -      */
>>> -
>>> -     if (nfsd4_spo_must_allow(rqstp))
>>> -             return nfs_ok;
>>> -
>>>       /* Some calls may be processed without authentication
>>>        * on GSS exports. For example NFS2/3 calls on root
>>>        * directory, see section 2.3.2 of rfc 2623.
>>> @@ -1168,6 +1160,17 @@ __be32 check_nfsd_access(struct svc_export *exp, struct svc_rqst *rqstp,
>>>               }
>>>       }
>>>
>>> +     /* If the compound op contains a spo_must_allowed op,
>>> +      * it will be sent with integrity/protection which
>>> +      * will have to be expressly allowed on mounts that
>>> +      * don't support it
>>> +      */
>>> +     /* This call must be done after the may_bypass_gss check.
>>> +      * may_bypass_gss implies NLM(/MOUNT) and not 4.1
>>> +      */
>>> +     if (nfsd4_spo_must_allow(rqstp))
>>> +             return nfs_ok;
>>> +
>>
>> Comment about future work: This is technical debt (that's the 21st
>> century term for spaghetti), logic that has accrued over time and is
>> now therefore difficult to reason about. Would be nice to break
>> check_nfsd_access() apart into "for NLM", "for NFS-legacy", and "for NFS
>> with COMPOUND". For another day, perhaps.
>>
>>
>>>  denied:
>>>       return nfserr_wrongsec;
>>>  }
>>> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
>>> index 4021b047eb18..95d973136079 100644
>>> --- a/fs/nfsd/vfs.c
>>> +++ b/fs/nfsd/vfs.c
>>> @@ -2600,6 +2600,10 @@ nfsd_permission(struct svc_cred *cred, struct svc_export *exp,
>>
>> More context shows there is an NFSD_MAY_OWNER_OVERRIDE check just
>> before the new logic added by this patch:
>>
>>         if ((acc & NFSD_MAY_OWNER_OVERRIDE) &&
>>
>>>           uid_eq(inode->i_uid, current_fsuid()))
>>>               return 0;
>>>
>>> +     /* If this is NLM, require read or ownership permissions */
>>> +     if (acc & NFSD_MAY_NLM)
>>> +             acc = NFSD_MAY_READ | NFSD_MAY_OWNER_OVERRIDE;
>>> +
>>
>> So I'm wondering if this new test needs to come /before/ the existing
>> MAY_OWNER_OVERRIDE check here? If not, the comment you add here might
>> explain why it is correct to place the new logic afterwards.
> 
> Why would you think this check should go before?

Because this code is confusing.

So, for NLM, MAY_OWNER_OVERRIDE is already set for the uid_eq check.
The order of the new code is not consequential. But it still catches
the eye.


> NFS_MAY_OWNER_OVERRIDE is actually already set by nlm_fopen() when it
> arrives in check_nfsd_access() .

This code is /clearing/ the other flags too. That's a little subtle.

The new comment should explain why only these two flags are needed for
the subsequent code. That is, explain not only why NFSD_MAY_READ is
getting set, but also why NFSD_MAY_NLM and NFSD_MAY_BYPASS_GSS are
getting cleared.

Or, if clearing those flags was unintentional, make the code read:

	acc |= NFSD_MAY_READ;

I don't understand this code well enough to figure out why nlm_fopen()
shouldn't just set NFSD_MAY_READ. Therefore: better code comment needed.


> Prior to the 4cc9b9f2bf4df inode_permission() would get NFSD_MAY_READ
> | NFSD_MAY_OWNER_OVERRIDE in access argument. After, it gets
> NFSD_MAY_WRITE | NFSD_MAY_NLM | NFSD_MAY_OWNER_OVERRIDE |
> NFSD_MAY_BYPASS_GSS. It made inode_permission() fail the call. Isn't
> NLM asking for write permissions on the file for locking?
> 
> My attempt was to return the code to previous functionality which
> worked (and was only explicitly asking for read permissions on the
> file).

So the patch is reverting part of 4cc9b9f2bf4df; perhaps that should be
called out in the patch description (up to you). However, the proposed
fix doesn't make this code easier to understand, and that's probably my
main quibble.


> Unless you think more is needed here: I would resubmit with 3 patches
> for each of the chunks and corresponding problems.

Agreed, and I don't think I have any substantial change requests for the
first two fixes.


>>>       /* This assumes  NFSD_MAY_{READ,WRITE,EXEC} == MAY_{READ,WRITE,EXEC} */
>>>       err = inode_permission(&nop_mnt_idmap, inode,
>>>                              acc & (MAY_READ | MAY_WRITE | MAY_EXEC));
>>
>>
>> --
>> Chuck Lever
>>


-- 
Chuck Lever

