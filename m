Return-Path: <linux-nfs+bounces-12321-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FE56AD5B48
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Jun 2025 17:59:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C565817B499
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Jun 2025 15:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 384D71DED6D;
	Wed, 11 Jun 2025 15:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EQrJOSjd";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="EIf4lG/h"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75DF31A8F82;
	Wed, 11 Jun 2025 15:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749657563; cv=fail; b=mVGYKbrRaG8nPEb3L63vTHNRMAymqxoUXFNEQc/KUCxStcEBwxC0M1vDQFak/XCqt9fn95lD2Hn0ZBo2owf/EvJQfM3o3tCCGDgJV6OLbssV5cVFkxo9a4KY8Lj7AbeD4lX6BT2OGj3KPLVVj31F+zhVTe59XRn8k+SQ5iUduqs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749657563; c=relaxed/simple;
	bh=jTW/o+3CdEgVeBpaCQBvncg+K2u/Z8pOPvGLg30eNAg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AtdNARbgvTxYfKCww54LGjBP6k4Ugi2ozMT8tq5btKuOp0lZFxdf4yNACWJUS4SdVA4iZrPJcj98oB7NwMC/Vsk8shNghaOZ1A58ljo0ySgnNgj5b5gIrZS3gOSNPexsaUuS/qKTIN1OokeP5irL6907UCA3QwsjaHqtnHY817M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EQrJOSjd; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=EIf4lG/h; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55BFIfFZ004594;
	Wed, 11 Jun 2025 15:59:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=kwcm830PcVlxc5BIWQ3eDFhdrh274yLn6wqfJ/76ly8=; b=
	EQrJOSjds0jw64OuNgZRxBhy1rcdt0GsYgzc52H1tZBYsuNPU2Q0E3OcP53Ni/eN
	3Y3Z+8th5CvQj/cx+vmaDd1c70+SkegPbmlWdgVVL02mdkl/31ePR7IpgYDFX/v3
	auWcELY/bbzVMyMYxhZNtY06jPmIKm1h3wB0pAPT/cAv/VcWHG+iIqjzPJ2mUaR7
	yYKw4hvmS3AMbGEymj4mxXxZ0acwW0h0v4Lqw2duzKiMVs39sqaYWKzBKB5lm+Ap
	YXkesCDJY6GH31Rt+H0Wdo9QIa8preT6KkMaz4aa8aSIEsi1qns1ulq5oNv58uuB
	4o/tmR1RhnpLxw+H1a282w==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 474dyx00ww-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Jun 2025 15:59:11 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55BEwD5v012027;
	Wed, 11 Jun 2025 15:59:10 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12on2081.outbound.protection.outlook.com [40.107.244.81])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 474bvbcfwe-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Jun 2025 15:59:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MQkdXF2niVClY/tPMW4blBD3NAsdgt63LbYuvQSwAkPt7SVDy6GgnDeVnHyJmfHXktRA/pRGUQMSkIsLrEBI/szxUmXi3iCI3cUWXk9VUUDuWowFDfZJ3AVfns02fMcXBGDDcuvkIOKGbbT0NFmw3Mubp8/c6/2dDJZ3VI6mKBKU5kx8NS2PkBy2ZyXFL2/HccyUjgq8amNPV9vOeUe9dgrChviEn8jcqflC5mrm3SkMKmJouwBwVGah/Ygbz8fqUsIQHiD7yp+O+eabHEwTqrLmzBkFrJeKynlxgkMBjYnhzYbmSsi1G297BjS+YJlVCxkTN4oxAjNoZ+RAcL8XjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kwcm830PcVlxc5BIWQ3eDFhdrh274yLn6wqfJ/76ly8=;
 b=IYlFrUnfh1EP3iGgx7DzHqJuK/R1ahqziqb35VsXIBU4qGaGbGkWJj9ABTyEXW/4pdMT8CbG80aIIVyg2OKZA/sYpXo54mRcvXDJWqsUtypVpWrA3KsOSwAaZ8Z1WwkoEhNp8IaJ8MiO2zWrxZJH9I+JFnyK//yw8ho8ibyUba4ju0zpy6rpjJFMCwNZpPXR8GpK7MnmmXxhnO3p/IslijnYum2mOOw2VvfwbhC4Fp4nkXOfczpH36M1nECeX8ZVStnBveKiTs5U81eSQhtVTmd8BxE6j+gIyuf9L6yT1gbYabBNvzGdO9NsEcn7gVFe/lnw4XkiW4uxSr8t23fpQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kwcm830PcVlxc5BIWQ3eDFhdrh274yLn6wqfJ/76ly8=;
 b=EIf4lG/hX3+lWqUl9rz+kZjGYE67HRp+ggvNo+wa8ODxWX7Gq5Eyow4+DItGmiJ+lXTriUEzLGfuJ+79pZCl8eM0VB1vEKLaXjSHp+D6rM8UTa7i3rD39r31jBv4Z+16s8iAJCW5LXE/u30UTn7h2SAGNFLsqzfK45XwOZelGs0=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA1PR10MB5824.namprd10.prod.outlook.com (2603:10b6:806:236::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.18; Wed, 11 Jun
 2025 15:58:47 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8813.024; Wed, 11 Jun 2025
 15:58:46 +0000
Message-ID: <5c8c207c-0844-492f-99e0-48b874b5404a@oracle.com>
Date: Wed, 11 Jun 2025 11:58:44 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nfsd: Use correct error code when decoding extents
To: Sergey Bashirov <sergeybashirov@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konstantin Evtushenko <koevtushenko@yandex.com>
References: <20250611154445.12214-1-sergeybashirov@gmail.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20250611154445.12214-1-sergeybashirov@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0278.namprd03.prod.outlook.com
 (2603:10b6:610:e6::13) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SA1PR10MB5824:EE_
X-MS-Office365-Filtering-Correlation-Id: 39a2226d-6b25-41f1-8903-08dda900d952
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?RS9hV09FeHdYcFU0QklVeTVoODZJS0pMbTV2Yk5rczBIWWpmSkZoWEgxRkEx?=
 =?utf-8?B?S1FoNUc2Z3F3TXpGVDVQTVJna01nWm14bmwzOWRhQlBxMTR2RFppSCswVGxF?=
 =?utf-8?B?MlowamtSSXFJUUtGT29KSHRFQmFkMFlBWXArKzZBdUptUW9ZL0dqRTErTGpt?=
 =?utf-8?B?L1YwcVBVcG5KWDBKeFhWOGxaQzByQ1FRMEFmYzFZaFlNWVhlVks5N2FGWVFT?=
 =?utf-8?B?a3FpR05rNVdibVJBY3JROEtwWk1QcDA1bEJFYXRuemRBemFRMTRTb0xPeFE1?=
 =?utf-8?B?UmhaVUdJMGNMRU1IMFdhOTh3eVkvcHJzK1J5c2hMN2d3dXdBMWcwcjZ0UjBK?=
 =?utf-8?B?Q0phdGVXK0dkYk14aDdqcFhwWm5QcWd3MkpuUjFHQWNKdlF6Z1hmYTA2TUFI?=
 =?utf-8?B?eUJrbE1Lbk5MVi9IREFTL0VjUXFsMWRpL0o5OFVFbzU3K04xTWR4d1VFL0Jh?=
 =?utf-8?B?VXB1Qm83cGxNbVRRWkduL2prSC9lSU5PcDJRa2cwc2xWeXRiQ1NZdlVMWTZo?=
 =?utf-8?B?T1QwZVVBZG1rRU1KcWhORnJNU25JQzQzMUdyQm1UaGMva3RHY3c0eHlWTnJr?=
 =?utf-8?B?K05VWnNlS1poNzJGa0VTVENSbUQ2UDE4VUVXL0p2QmlZZWtZY1RZT0VFalNz?=
 =?utf-8?B?alRFNWVpTDZpTmJ1OC9wSXpCdEk0TkVpTlJWWjF5YnQ3TlI3cmVXQlBLeGUy?=
 =?utf-8?B?UjFFRXZXU2Zpa0Q1b1dSYnVDZGVtNG14Rml0cFlaa1NSK2FjOThObk5mMmY1?=
 =?utf-8?B?cWRrcE94d2gyUyttMkN5MTVaRjJla28xK2JEUHhsOXFKMUtuZGRNbmlpUHNs?=
 =?utf-8?B?S0gvcWQ5OHo0SkxaZXNtVDdGQ2F6VHdUZFZ1QkF4R1lWV0hNY1duVWQ3eGhh?=
 =?utf-8?B?dXVKaWlVQldmd1A1bDd5NGhwZ0RIanplZG5zRXdNSUFJYW9pbXVaaUk1SmUw?=
 =?utf-8?B?bDdTejRDTzkvZ2V6aERDdDg1OGwzUVNQV0I2TGlBRnc3ejJCNHZyVEo0MmE2?=
 =?utf-8?B?YmJiWmZHbU80aHNiUDV5SUNOdzlGRW1lT3R1Nzk3Yk5BR0s3ZGd2dmI4ZHRG?=
 =?utf-8?B?cVpIZnBIem9WUm9IREFYbWVWRTcxNTR5eHFKaWs0QitwRk04WWlXTnFQVXdy?=
 =?utf-8?B?dWJqWTVzWHZNdDN4TFhNRXRDM0Zhc0xEVG0razZrRjI2TkdkTEdQc0RoOGda?=
 =?utf-8?B?cVRFMGo5b0RNSDRaVzBaWXdHSWNyNGo3SFZEcHo4WXU5MitLSXRmeUlCdGhk?=
 =?utf-8?B?UWFyYVp2Sm5Ob0VGK00vcFFTY2IvVjF4K3luanlIeXFlbXdFTk1TT3hXdEpZ?=
 =?utf-8?B?R2plRUlYMEtxNHNheVBKUk5ZSExoQnB5QytJbFZmUWhCMGpiUDFXclAvejF1?=
 =?utf-8?B?d2hnK2NnajExQmZCYVZyb3Z1eDBEdExHMFhraTYvZzZWajFsWUxTbVpIVm5l?=
 =?utf-8?B?N0pISkE4anhGb1RQbTF0UytTL2d6SlpwNjZNVjd3VWlVaWRZVzB5RHRqa200?=
 =?utf-8?B?QUw5NmpuOUl0Y2FtSEgrZW1INUI5bDdnK0hqNnlsYVVwdkgwSld0VTVFdEli?=
 =?utf-8?B?WlRNYTJaUSs0d0tHMDNVTjkrcXRtdFFYTFd6RlV6TzRLdEdzZ3F4Mnk1Z0s1?=
 =?utf-8?B?S2NwTmpNWmwzUy9TaGlZcnlDb09lZWhNVEZmS2lERmd3dnNiQUhLUjMydVdB?=
 =?utf-8?B?dDRvV0tQbSs1a3BvMEVuOTBSemVTWXVFSGlGZGtGSW85TXcrN2JoTlp5NG03?=
 =?utf-8?B?SmlLaGFFc1NKSWhLaCsyeExWYWUyaGR4Q25iOHYxS3lJZFd6TEhHeDhKeWxs?=
 =?utf-8?B?VXl4b1o3elVMM2RXNmRWenoydjFUbFErMUlKZldhOEpoeFlVSTNSRzRVTmdS?=
 =?utf-8?B?TWdhMm5TcGlTZ2NDYklkUys0UEtvU3l5WDB0WVN2Ukozb3UwcGpCaDZxL0pr?=
 =?utf-8?Q?c/HW7VMMvt0=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?T0l3N2xQdWZYdDNycGZNQ0U4OWhvTTRJcXFiY1dCYTA1QmlHUTlHOXBoaUhx?=
 =?utf-8?B?cHloQmxrY2tUNWN0bjdKWmNLSkJibnFFSGp1Zk8vRk5pUmQ1aUVrRXMwSHRs?=
 =?utf-8?B?MFZnNHgxSjZCVTByakhQaVIwTS9pYnc5LzU0VWhjSDY5M25KNko5MDdEOXd6?=
 =?utf-8?B?OFFBbmxWVUtiS0YyKzBERDVjZnZYWXdyYTRITU1TN21LMU1ZQ0ZSZjh3eDBu?=
 =?utf-8?B?NE1pckF5Z3l3Q0hzSWRBd2Z1VSs4eCtzeEkxS2VlR2xRVHl3Vm8zem9pUWVo?=
 =?utf-8?B?RDVwR25SZVYwZE4zV0FTRm5XSWk4c2FhMVdFNU1WRjZlekZVNW5IRlpwN1JJ?=
 =?utf-8?B?TlRZbkVsanBNa1U2clVabEJaUjB1MUZsQ3lRNzBqck1nWmRSN2R0cFhySzlR?=
 =?utf-8?B?aHJFSldtYjBBTlNJZWpTMUxJWm1ueWNUVXdQVWpsKzlVdHdHSFhyODVGQndM?=
 =?utf-8?B?SjFuakVMTERydk5xdjJBSWVCckVDS2FlMmFoM3Z6ZTB1ZW8yQmYvSWpWZjlp?=
 =?utf-8?B?dGIzWmlqenNtUm5GSGJ1K3MrME5Xb1BJQ2lsdU44bytzQklxV3Q3cVZKemJN?=
 =?utf-8?B?aHM4Y2RDbVhvc29XWEtFWXEwdnhsQkdVNTR1Qlg3WExMRTJYc21tc3JSNDdX?=
 =?utf-8?B?N0o0QUZ0OU1MQkczV2VEM2M4Wk5jLzk3SDBBYjJFNlRhakQ5djJJK0hobGsw?=
 =?utf-8?B?dXhnSFZFbktpS3djOGtyb2o1SU9wL2plT002dWVCcjhmSXN4VDBQbTJmWG8w?=
 =?utf-8?B?R0xaYm9YL2VmazJmY1g1dkdOeXFabElPenVFTVhGalRDNGJPMEJ0dVJuZGNx?=
 =?utf-8?B?LytOUWp4YUlnUDBtaU1scFNqR29ySFZZN0ZzSTRiWHUrM09pSGxZMnU5UTAz?=
 =?utf-8?B?MUxZL2g5S0lINHhtbitLTlQ2bDJMeFRYeUdnK2JPRVRwS0o4K3RDbWZsSVhW?=
 =?utf-8?B?c2VrdTNlMXBUTWcvN0VlQzdlZ0hIdHkzNjJpcXZkcStvWmlKeTJIYVJmOENz?=
 =?utf-8?B?TTFhOVIzbnRSeldSNmVvK1huTGNPUnhhZnpob2VZMlBqRU9LMFVPbDJIMHda?=
 =?utf-8?B?ZFNVWTE1QXhFaFBxV3ZVWEdwZlRwNlkwV1hPVTRqM0xIemp3U1RDdUNSdUtJ?=
 =?utf-8?B?TU1reDA3eWhzQlVuc3BQa3hxcWZYR3hoUEdLZnprT3RHbHc0SHYzL1lJb2Rk?=
 =?utf-8?B?STZOMjljTXcyaCtIQ1BWWlhHWTRQb3h5eVVEOUNqZVBYMGJqbHhEekxGYUV4?=
 =?utf-8?B?M1BiVTNKbVhwTytodzgrOHR3b05DQUQyU0dubzRyRlBpT1NTRXptT1hnZHBH?=
 =?utf-8?B?RUV6alNPTlB1T3NQR293U3lXQmNUdEFwcGIyaG85UEtBb0F5amR3RitRZTVy?=
 =?utf-8?B?RVhvS0M2ZVpDQnJuZEx2SjdqNE5CRjd4Mm4vZlJGSGJudUMxU2NYRDM5NkFj?=
 =?utf-8?B?QS9UQmw2di9hWEJPcjdYK3ZwVUJXbnE0WldpT0ZrYWh4SWo3b3FzMHVqNnJR?=
 =?utf-8?B?eUliSVYzZUpJVTh2ak42NlZqUTgrclFBelI5bDRxa0xobzlqcW9zZk1GQWd0?=
 =?utf-8?B?YTNiOE9INERMTXZ5ckd1a2hGb1pBMEZ2bkVBeHZ0WlJqMU45T29vM2JIajBs?=
 =?utf-8?B?V3JkVXNaWW9zS1hoMStwa1hYMzBEQzY2S1NTU3NCVTBsdWM0SjRWY0EvWHh0?=
 =?utf-8?B?VVZmOFJhOTZBQTdEMzNvdFREWlcwanBTdUJOdThmbDRrMCtEd2ZvQkZ0Q1lG?=
 =?utf-8?B?Sm9aTTF0ZDFYejJwaUFJOW9kanFlTTZLZHp5ZzJPWGdvRnlQczNydDZvTHVv?=
 =?utf-8?B?bkpMbVA2T2lrZlRJMk5NYTBOY1UvWG9FQ0NvNWJBRnVRUGNxZThmMnZoeWdu?=
 =?utf-8?B?VUszemU1ZmV5MWdjMGNFeGF5UFI0T2Y0cjQvL0s0L3l0WDNabVhOOEorL2tL?=
 =?utf-8?B?OVM0ZjY2bFJlUm8zS1RzUmxFeGVUKzBKSDljdm1pSHVWVkhTZkQ5b3VuQVNa?=
 =?utf-8?B?MFJxVTFTazk3OU5ucDM5QlRSTHdYOXhyZjA5bnozdEFlanlkYVozN1BoTGJz?=
 =?utf-8?B?SmFzWEk4eUw0bFVEQk1xajRIS0duZlNwajhGM0NEWjlheHV4c3MzSkFudjBE?=
 =?utf-8?B?VnNnQmgrZjZYeElmaVk5U2Nad1g1aVdOVWdBampDYVhYUjlyYVo2MUxDSDBU?=
 =?utf-8?B?Wmc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	rzL/SEMmoQ8m4amkq4b72ldWaFYXSTzgcV1bmFT5tooV3DuZKXTl1Dl9+Z3tA91d3ndJLms8upBbvY+5YBfaEb70asyVMMdr0G88KKLawgQOUYfM7gE3QsuSPvy2PRiMkFigsANb3P0cwPQm87UgyGUcfsXM2/rAjhK74jATgBH8B0bH9Y107S1LTf/lP9RM56SF9xNWkkoEA6vXMOX7nHxZbpZKThrtHNsHJKP4aNZZ51ueKQmA5F5Chf7E9B8VX2rPh65gJ+pQU3+5dwxfYUBwFzwNTJJKbXhHIRu6eoPnm+k98jKOEcc9SkIamKPPjcKsNztFsy0+P88S5R+9HkMqnAgvdgpBSCr7TzTjksct5AfKZRMPBjrzKf09mGNCwUWIZjfqpVTVzyuaD2ENmfZTsdGf7EU0Gw0RZeWSwbPP5ho3xaGLULEsARUJFpPNRdcwHKXsg1u/xw7Bibj7DcLL3vePep/YdkWOoe6OCrAim8H+cmP6xtfOauoP2PimgDjCA8R7bgl9cmu9QZr4wgszU3VgYf8ybybJFU8k77hVUmjE3/BOkdKpoBusS01xqLLw3+N3Xf2yvHAYUrAOsfgIn0RJBZAUEzcDzksIyTI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39a2226d-6b25-41f1-8903-08dda900d952
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2025 15:58:46.9325
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6qOih+RMhItppuA9Y4VnGp0cU4LKYEm9erg/EUpYdtbp/hI3pKSA3HfaTy1phYa7Yx168jwf3J02Urhu5+kI7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5824
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-11_07,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 malwarescore=0
 mlxlogscore=825 bulkscore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506110134
X-Authority-Analysis: v=2.4 cv=fdaty1QF c=1 sm=1 tr=0 ts=6849a7cf b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=pGLkceISAAAA:8 a=UyQCMIU3FegACkntYa4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 4WQav51N8ImICl17iw5hhwUFbDm0XyPA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjExMDEzNCBTYWx0ZWRfX4B1Ha+NPRIpt +ML+tLjCJtFznFrv9sirYxK78B8zskh8BAyGwq7ljeJFEeUFlNle1ZXcopYuanowQISpnvJJw0N nGY+whahCWN7Pa2rL28vaZ2XfC8d2QKvBcVJkvWMzHt8ZCJRrdE82sbeycVcN20o1mbUxKoEaWs
 6UvUfCaxuEPYpUgLSSuah4O5uT2wt3iEHEsUFM0L3Yo0Yr7oQ35mIJqa87wRzuVAfa9YnZHuz+Q XaGYheGTYzUNXHD87x69rCDXra5cUySRX08xTgBzQSYUrq2tA8QDBMRK6K7VuN4DhD2yIcjlsZ7 bO4yq+8bvdt0mIZPfaoLQHUwG1bSvnMXww6YTJpeSyJMo9N05iWnTNjbNzhYTFQM8trno+i4N7r
 6BSz+Rcz7OHoFpu99RGZsjBhZRIdvPmUILVxStv0tptOy037/uy9tm9TA+hU/YhnVqYsNzva
X-Proofpoint-GUID: 4WQav51N8ImICl17iw5hhwUFbDm0XyPA

On 6/11/25 11:44 AM, Sergey Bashirov wrote:
> Update error codes in the block layout driver decoding functions to match
> the core nfsd code. NFS4ERR_EINVAL means that the server was able to decode
> the request, but the decoded values are invalid. Use NFS4ERR_BADXDR instead
> to indicate a decoding error.
> 
> Signed-off-by: Sergey Bashirov <sergeybashirov@gmail.com>
> ---
>  fs/nfsd/blocklayoutxdr.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/nfsd/blocklayoutxdr.c b/fs/nfsd/blocklayoutxdr.c
> index ce78f74715ee..66f75ee70db3 100644
> --- a/fs/nfsd/blocklayoutxdr.c
> +++ b/fs/nfsd/blocklayoutxdr.c
> @@ -121,19 +121,19 @@ nfsd4_block_decode_layoutupdate(__be32 *p, u32 len, struct iomap **iomapp,
>  
>  	if (len < sizeof(u32)) {
>  		dprintk("%s: extent array too small: %u\n", __func__, len);
> -		return -EINVAL;
> +		return -NFS4ERR_BADXDR;
>  	}
>  	len -= sizeof(u32);
>  	if (len % PNFS_BLOCK_EXTENT_SIZE) {
>  		dprintk("%s: extent array invalid: %u\n", __func__, len);
> -		return -EINVAL;
> +		return -NFS4ERR_BADXDR;
>  	}
>  
>  	nr_iomaps = be32_to_cpup(p++);
>  	if (nr_iomaps != len / PNFS_BLOCK_EXTENT_SIZE) {
>  		dprintk("%s: extent array size mismatch: %u/%u\n",
>  			__func__, len, nr_iomaps);
> -		return -EINVAL;
> +		return -NFS4ERR_BADXDR;
>  	}
>  
>  	iomaps = kcalloc(nr_iomaps, sizeof(*iomaps), GFP_KERNEL);
> @@ -181,7 +181,7 @@ nfsd4_block_decode_layoutupdate(__be32 *p, u32 len, struct iomap **iomapp,
>  	return nr_iomaps;
>  fail:
>  	kfree(iomaps);
> -	return -EINVAL;
> +	return -NFS4ERR_BADXDR;
>  }
>  
>  int
> @@ -193,7 +193,7 @@ nfsd4_scsi_decode_layoutupdate(__be32 *p, u32 len, struct iomap **iomapp,
>  
>  	if (len < sizeof(u32)) {
>  		dprintk("%s: extent array too small: %u\n", __func__, len);
> -		return -EINVAL;
> +		return -NFS4ERR_BADXDR;
>  	}
>  
>  	nr_iomaps = be32_to_cpup(p++);
> @@ -201,7 +201,7 @@ nfsd4_scsi_decode_layoutupdate(__be32 *p, u32 len, struct iomap **iomapp,
>  	if (len != expected) {
>  		dprintk("%s: extent array size mismatch: %u/%u\n",
>  			__func__, len, expected);
> -		return -EINVAL;
> +		return -NFS4ERR_BADXDR;
>  	}
>  
>  	iomaps = kcalloc(nr_iomaps, sizeof(*iomaps), GFP_KERNEL);
> @@ -232,5 +232,5 @@ nfsd4_scsi_decode_layoutupdate(__be32 *p, u32 len, struct iomap **iomapp,
>  	return nr_iomaps;
>  fail:
>  	kfree(iomaps);
> -	return -EINVAL;
> +	return -NFS4ERR_BADXDR;
>  }

nfsd4_block_decode_layoutupdate()'s only caller is
nfsd4_block_proc_layoutcommit(), which takes an error return and passes
it directly to nfserrno(). If nfserrno() gets a negative NFS4ERR status
value, it will bark. Changing only the return values is not enough.

Instead, nfsd4_block_decode_layoutupdate() needs to return /only/ a
positive or zero I/O map count or a negative NFS4ERR status code. Then,
if nfsd4_block_proc_layoutcommit() sees a negative return value, it
converts it to an nfserr by calling cpu_to_be32() on it.

(The -ENOMEM can be converted to -NFS4ERR_DELAY).

It would also help to get a nice kdoc comment added in front of
nfsd4_block_decode_layoutupdate() that explains the return value
convention.

I see that nfsd4_scsi_decode_layoutupdate() needs the same treatment.


-- 
Chuck Lever

