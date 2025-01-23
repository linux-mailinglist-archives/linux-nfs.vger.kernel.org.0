Return-Path: <linux-nfs+bounces-9564-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62768A1ABCB
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Jan 2025 22:18:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 204663A8CF5
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Jan 2025 21:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF9681C3BE0;
	Thu, 23 Jan 2025 21:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UjB9njOP";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="OHLz8oXe"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F293DBB6
	for <linux-nfs@vger.kernel.org>; Thu, 23 Jan 2025 21:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737667081; cv=fail; b=elRyRlIiZdiePS45TV8G9vQ0f/3uMtbpBd7NkuP/OxMkadTTY11mYwpeTTgnDUxK3HW+hrvJ2OPbVk74wfUy4Vr2iysR0Gti1kVmtinX9aCZL6AoM8NDDiwyWaonKtRWZvet9amEv2iGrf4O4+hBipRCB6Fl1rbK/ipMQSh1hVw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737667081; c=relaxed/simple;
	bh=J5mTksyn+UCoc1ek/dtx+31pcx0ztBP96jCJ766c4m0=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=P5gDpyo/l9hj7e98VHQ5CnZbMIjHp6KL9/m6FG9Ojw+/dKdsoY6vf+GRAkkytcB9K62SJqlkJuGytgJJngaH/TPhmedgs4kbplLySuV9qP18V5MiFvMZhxx2YW8Z/mer/tbIFMbW83IZaMr2/m/RUit1KFxro4CFwKPld0wohYs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UjB9njOP; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=OHLz8oXe; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50NKsctA006900;
	Thu, 23 Jan 2025 21:17:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=ab/bCHgiVeaEP+JFZYQomdLjSBCtf11p88RdVWAmQgo=; b=
	UjB9njOPsdwGJSBCrnZm2oJEtDjX1nj1HcSsvkPiH0SvO3TdeGtgSGidRNcJWQet
	HfiPtHc+bKN3KJ7RA7EBX5C8vPOy0G8+PP3neWCwgj95ahzXBUWCJ8q69jazUNyO
	TUgkcFU2bhIwD5Hc2FvyJqVXs8/bqn+Ej5L1BXzWwEgJ4cULgrCO/RW5cV00lgaP
	xU9r8LFcajNBHGMR8CGrI52sntBoCNSPBszGgOLrlZ+vGoakPIxhkZa50Tk+W94X
	NDfIqCeSXd2deHDSACweagto5poEKIMjAnvhNFRT3Q1Cx3Jk0q7agUc0iY6nNduS
	ycXZiRz4+sma0QkcI0zHTw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4485qatx5b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jan 2025 21:17:56 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50NLBmTp038154;
	Thu, 23 Jan 2025 21:17:55 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4491a37kkp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jan 2025 21:17:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IzTXR0dNlLfcc44TC+rU53Q5KYPf+SroBFQAV6vGvzXBANdxGRtzJNajaSSmLqsWN6555tNKGqhoxanz+2AKL6gryFRhEzrrgKQXHHeT8U6vV+xOMlae3bp9oOxVzW/gyI6gM/eMyH2iisvcLuMfnB9es/1+ltubYlAizN/6dymdtI18sZkBCVIbjXz0K+C0cnUvEa0BlvABNnjrf5taXFW90acZqhjjCFhzNZjafm07P1RW1+BaULbW1bwRu/+GBuytQkG6P4R6/dSFbYiv90JC9RKeDNuRMcW+39wHNS8NHnK2dZNskTsgkyV+kuEptlxVZp0UT1BFTp0dVTXHkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ab/bCHgiVeaEP+JFZYQomdLjSBCtf11p88RdVWAmQgo=;
 b=rqxYJ5r3pfjPNl2ZZe8hBLhpHGEX1tdZUMlk6DHqQSMsCqXUkQxWCi84GCS85KU0M6PF3wDdo9sMLo9B7xXT3wPsrqcRzlx9t/HLInmWksJRUwxq0XyIJT4cYQs28Sw4tA4+NGhN7Kj7epbuTy3vkRmhs0GiddofxFPGQh9qH09i/MkNSeA/YpZmzB3a0Fu87W44d3cWLSXAzAEacLwZny2wMVy7s6ajWvDG/0oqzucs7OhTHrmhlKV6yNpc/bmkX+cQjM76fcR2xnBO5XOs6iOagExFMuKM8gbKddFugrUGIbwfIyKQ0aNNBlV5Fj7C3XOd9W3k+9yWPI4kBnetCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ab/bCHgiVeaEP+JFZYQomdLjSBCtf11p88RdVWAmQgo=;
 b=OHLz8oXeWTT5OO4M+C+eopZrH4E0XlzCXfVoUYSPWSeYq86+ot/mM84Sv9W7N37o6+Ok21ifNgd1ZtTDLlvAqyszV5F3mFnNXL0+eAH/xfc5qCuVoLloMc8BJjP9VylmU5rmX5DP2RtdEXpgpTem0btU1/kCO7eFKkx67ekqB10=
Received: from BN0PR10MB5143.namprd10.prod.outlook.com (2603:10b6:408:12c::7)
 by CH0PR10MB7462.namprd10.prod.outlook.com (2603:10b6:610:188::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.22; Thu, 23 Jan
 2025 21:17:53 +0000
Received: from BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::783:503f:ea07:74c7]) by BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::783:503f:ea07:74c7%5]) with mapi id 15.20.8377.009; Thu, 23 Jan 2025
 21:17:53 +0000
Message-ID: <5bcfaa2a-95e3-449e-9633-e167e662f1cb@oracle.com>
Date: Thu, 23 Jan 2025 21:17:51 +0000
User-Agent: Thunderbird Daily
Cc: Calum Mackay <calum.mackay@oracle.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH pynfs] Move to xdrlib3
To: Jeff Layton <jlayton@kernel.org>
References: <20250122-master-v1-1-3c6c66a66fe5@kernel.org>
 <020c8945-51e3-4783-b852-c89bc7917b67@oracle.com>
 <d409eae2976c25f0121b1011bb2d1aff181aa4fa.camel@kernel.org>
Content-Language: en-GB
From: Calum Mackay <calum.mackay@oracle.com>
Autocrypt: addr=calum.mackay@oracle.com; keydata=
 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
 smRifw1wGg==
Organization: Oracle
In-Reply-To: <d409eae2976c25f0121b1011bb2d1aff181aa4fa.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0361.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18e::6) To BN0PR10MB5143.namprd10.prod.outlook.com
 (2603:10b6:408:12c::7)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5143:EE_|CH0PR10MB7462:EE_
X-MS-Office365-Filtering-Correlation-Id: 745caa94-23cd-4bae-649b-08dd3bf365cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eWU1VDM4ZmlSQlVUVTh2YStrWCtsOVp6T0lnOEYxL1p5UHQvSFFsUTgvcGo3?=
 =?utf-8?B?cUNnYlRPTWdTNTUvbC9kTDI2aVhrYmZxQ0o5ZDZ3eVVYbnFxdkpHSFJINnlo?=
 =?utf-8?B?cmIxbWIwak1rNFBDamJaV243VnMwR21WY2FtMmVUS21uK1RLZW1CcXFVbUtG?=
 =?utf-8?B?VDYwOTZvK0padThiWTJSVCs0WHFQWThJYm5UMC9udkx4anUyZHNTSmtVMlJ6?=
 =?utf-8?B?N1pMODB1aTRYMkpLUlh4aURjNE9kaFZlMUZ4Nzh3dC9sS1FMSTA3SGVhZnA2?=
 =?utf-8?B?Zkhlc3pxK2ovRkZVam9EV2xSSEFWb2VUSU83THJ0QUVjTGpHTVk4Wkd0WHJT?=
 =?utf-8?B?N2Mxdm9sdzgwaG5pM2VYT2QwRnBYbXFLcTZMdFd3R3RDQkpSY0ZoWFZCZXVJ?=
 =?utf-8?B?T1Myanh2N2N3b24zSUh3eVJLc3IwWndFR3ZKQnR6UzAvckwzaGxJeEFLSGRW?=
 =?utf-8?B?aVBTck56dnlyK2pVSlY2OG0xenhaQm9PZ1BwRi9EOG5CNFJSQ3cyK3o1NHhH?=
 =?utf-8?B?U3NTMGFYeEo1NUZ4dU5jZWVZU3c5cjBRamhKSUdXdmNKR1pndm8wckVJNVNo?=
 =?utf-8?B?TTBab2pPaDR1Rk1HYlA5UlR5TE9CNnZuczlEKzNpWVFlajR3cjJTSXFaQU15?=
 =?utf-8?B?clZoeDdhdFVBc1NnODFpRnJrb1UxUVBuclRPcTkycFh6eEhuS1FvSk1WNldw?=
 =?utf-8?B?cXR4UmpycFZla3VqUm83a3gxZzlFUXdDYnRGWmU0MnhZMy9qMXVuZFpnMXdV?=
 =?utf-8?B?UEZBQ2dHTW8yTTh1Q21VL3pEd2puQUNOTFFPVTBOTHhHemZQbFdiZlpLaG1Z?=
 =?utf-8?B?UWJWZjBmZ1loQTlqSnB5VFBSNWFwd1R5bVM5b3ErSkpuc1p4ZUpSa0V6cWNl?=
 =?utf-8?B?SERaZFR0SXppMjdoZnRhcFZuckw2aWJpT2Y3ajgzTXU2UUplbGs4dHhJNUlC?=
 =?utf-8?B?QTJkTWY0VlUrTFVBdDNMNUZNVDFkdGQrYi9VcmV1WXhVWVJ1SkxtWW1RYmpK?=
 =?utf-8?B?WjJDdWV4QmpNaVZsdzlTMHlXVlNDMlhlcFpMaG1OWUxsczJUYVRiV1pITWI1?=
 =?utf-8?B?RFpnZFQyS2RYL2tEdGVkMEdCUTlIUWdBb293Z0I0Mm5pY0lWWFVLMmF2Z0NL?=
 =?utf-8?B?Tk9xekhXWloxaTllMFpaZ1FWdTgrUVhiSlBrQW5uSUlGV045RlNQSk82OGRQ?=
 =?utf-8?B?MVAwNVpkd2hCOFFBd2RBRnJxUzVaWHdic2dTRTZDb2pBMDB6V0Q5V1VzeTRq?=
 =?utf-8?B?enZDeTFyelBCQ1c2bnVoanFUS1luNFVXcGRXZ0xHR3FKRUFEKyszVmlQSzU4?=
 =?utf-8?B?SkhzTEcvNG9hMkpORG5hTUNxN2o0eEJDYlNzUUxya0szaXFpNVdlNzlyaDYy?=
 =?utf-8?B?b3hWdTV0RFJ5RzhjbU9qNmVOOHJ1ZUJHa2hwVHJXRDlJZGFrQk5OWEwvMGpM?=
 =?utf-8?B?bmRJUUY3d0lQa1JnWG9vZi8xYlAvYTJjUnpncmo1UE56eWRieVd3MzlkQytK?=
 =?utf-8?B?Nm5vRUwwellQdGFubUhqckRmMlg2Q1FWMWx5MzV2L2pHTFdlQkgrTGJsa09i?=
 =?utf-8?B?cEI5QjZrTW14M1RXeXlxUkY1NjhFOTZPOUpyRFNkdi9RaHpLSS9hNWo1ODd2?=
 =?utf-8?B?UHJvbFlFSm11VEFvMVZDb2tRNVR4YkFNTVJEcjhUeXJwRzh3YWZnaTZWMDR2?=
 =?utf-8?B?UUFUdEVnYUo2NWN2bVZ3U05pSFNZNWtWdmFEM05mSzdYQVVTekxrc3JKSXJP?=
 =?utf-8?B?d0dCdmZ2VlJFUmVhQmtydWlOV29SU3VDVW5VYUQ3M2V6K0krUUtPeXQ3Zm1V?=
 =?utf-8?B?eVpLS1FTL1B2UE9IVDhQdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5143.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M3Ixb1F0cUo2WDczQzRBTGFaS0lDQ29RY01CQjU5NnhUVjBFeTlZVld4YzI1?=
 =?utf-8?B?bUp2V3F0VXQ1d0RScG00eHFmK0pBc2ZMY1dpT29YQnd3VzQvOHd2dFdqZEhj?=
 =?utf-8?B?WEJJaW9KV0hNYlZiUkJCc0dXeEhXcTlGVUgvZnQrTGgwbjFNVEluRHBjdHVX?=
 =?utf-8?B?ZUo4VUNWLzJOWHZLUFNhbXZtaytxWlVOZGhtQ0xXRXBhb1p4eEhMVklVVUlN?=
 =?utf-8?B?VnhlSENLVWoxcEJDcTVmamJaRVBmT1ZpM1NRd0hIZnZPYXQrT0RITndKQkJ1?=
 =?utf-8?B?TUNJQkR1aWJlaWNMaUFCeWpKbmZQcEMrQ241ekw1dEM4bjYycUxJbURhQnZk?=
 =?utf-8?B?QVpKdVNEcHk0VGVXZVlRN2JVcEFTSC8rU0c1M3haSURXNGh2Z0I1d0RTbFVu?=
 =?utf-8?B?M2hvaGM5ZmgrN1U3eWo0UHg1K3ArM1lVN05YU0xrUmJtckRMTGNvU0N2WGRx?=
 =?utf-8?B?bW5pN3JxaDNQVUxIbUk5Yk5VZzNNVnhNcms5bFlGeHZMZjNEUkpNdzNvd090?=
 =?utf-8?B?WmdBWXE0aXE4VGFxbUVCWlVWd3BFeWllTGpaSVpmVWJkbklZNWtKSWgrUTlu?=
 =?utf-8?B?bnRFbjZkUGU1a1lucUg0VXE5VGlJZnZ2QmRJRmJEK2xKREJoenVWaEJtaGFH?=
 =?utf-8?B?a2JyaTRtVmxleGNkMC8rTzhCMHkxNWdvNEZ1UU5VdUQyL2JDOHVYcFlxWTVY?=
 =?utf-8?B?Q2M3anV3UkJMbUFwYXh3KzVrL3krdzNxV1R1K2NIVm5WazBTa2ttNTRuT3lI?=
 =?utf-8?B?TUROWFk2ZVl6dnVBUGJIQW11cDZKeW1pWGgxYjQzejNuVmoxUkhVRjk4d1lt?=
 =?utf-8?B?VFR5RitaN2trS0M0Q0NBeGZveTM3ZEwxVHRleXg0RlBOcjJtV2JoanpGbG9w?=
 =?utf-8?B?UkIzbEgxYXg2TWZrOW9PdisvTFNxTGx0WjNTdDAwT1FtUGVnNG0yT2xiUWRG?=
 =?utf-8?B?NHNmaC9WeWRjandtc2dmRVRyVGttZlJTWi9SMVhYV3hoaUQ4Q1VPcm96L1dl?=
 =?utf-8?B?WkxHdnVwWG9kRXQ3S1JYSFk2L2xyV2pMZk5NeVpxTWs1ekc3OHRFUXgrWkNO?=
 =?utf-8?B?ZmJsVm1UempvMTViV3pNSXlRYWV3dW9HbzhBQkMxWlJ3Q3MySkJBNmp0dUl5?=
 =?utf-8?B?bkdpOE5FUzFXcldRbE1nbmtKNXhjR2lXeWZldERNNkZ3cmh5RFU1ODdGWE5F?=
 =?utf-8?B?cDhCWmlRSzgvMCs3UXQzWnBVRmVXUDV1VjdkMlZLUHJEU1AyY3VKWis3NTh3?=
 =?utf-8?B?cGxmcGRVVEJXRHhmaUVSWDVWRjRLczZRdDZURG9uZ0Jzb25TaHE5dktsdmFM?=
 =?utf-8?B?bUR2THBNYkdZSXlKUG9Fbk1Oa1NvVjdGR0FMS3BNVHN6elp6b1JCenBvN3hG?=
 =?utf-8?B?NTFQNHVzVDY5dlNKNXJyRXZZclA4M2NUMDJEcUJiQVlaNjZEbU9uVFVaY1ZN?=
 =?utf-8?B?ZkJQY3h5Si8zTXM5KzhLbCtvdkZZWnJaU09TZW9PVE4xa3Q0VE93UGxjRGEy?=
 =?utf-8?B?OEtQN2JGMjI3Y0xmeHhXMmg3VXVrU3drRmd6ZkpzYU5xR3lmRE1SeHcrMWlE?=
 =?utf-8?B?U1l4bjhFaVBmMVZMdnhGQTREYXI4dTJHS2ZwaGdtZkpMRS9Wd2JMNGhHcWdC?=
 =?utf-8?B?blFUYzNCT3ZBL0NKbFl1My9rT2hQTHRPU1NkYTVBT1lvZ241VHJTL3J3OWlu?=
 =?utf-8?B?L3pqVHc5dmpWWFFBckJmUVRlUVhQWWhML1BlM01Xa3pCbTdLT1N5NEE2TGdv?=
 =?utf-8?B?S3dUWVdsMHE0S3BtNUFBSkdKN3hYYUszWS93bW5MUUdJM1hINVFsSCszL0g0?=
 =?utf-8?B?WFZsREhKbXl5ZDhwWjNoZy96MjJQSEZ0Z05scHc3NXo4OGNWYTBSWjFsQ2pT?=
 =?utf-8?B?bHJCSDBkZVhvai81b0p5UEVDMUJOT20yaFJCb1gzUmpKZXdISi9uM284ZEtw?=
 =?utf-8?B?WXBtUDFUNGpHdVRlQ2FudGMyelAvRldVcDJXTEgyeGtEblpIbExYMXFhRVlK?=
 =?utf-8?B?OXZXVmZlN0Q4V2ZFV3R6QkR4Q2xmRVZyaExJZGNxMFVvZi9TWkZCY3p6SXpR?=
 =?utf-8?B?MEdIVmV0VnVOdlZtdVNpRHd0M0tHNUFTU2Y4blRQaFlKdmxESDFTSjNTMVVZ?=
 =?utf-8?B?aHVkTVRXdGlXMzNmakVtbi9oV3ZyS2xqR0JhTzR6WFk2c1lWTnF1ZkwyVEp6?=
 =?utf-8?B?dWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	gXgj+a7YTmOHW6jiS/nZtr0gW4kOvcfL401KuMrtDq8233qs6iXQHCVXmp8MMuSj6gzX7X1DRBskNRHb+GC4rujDfN6e8x0X04ztyeugHNVo8mNrjhZm++Bp1AnR9tHsRn2nkCelE3qYKR44NZePDq7XEq64Bm/Gp0VuS5fwAKZ9R6pW0ExqLPT2958r2JYcZ6SG/OWEptinwqkuwisrsw40GUnQ6nAZGiIgnCie8aJ7litJFgy6aOetkyFai0YCEUwUTQ0Tu+w3k0JEQW99k04aLBg7oC9FBsP6xFtlQm5paOEMF7UVMBbD9OmY5QL+KSIpLH/wPQoXC2MAUCQwEohVV5PcXCubdda3PAmiB3WCP5S72rck1L9vN3QAIpSdvO+EHeSQ65zJC+fjQW2H0VTtjqHDbJ8HiROe70S3QNZBphkpuj1kCRUrZqL0I7f5eIIQQVYygtKqDr/vmErRMmFqKjayucUFtwSgGB+0Xxb0ysEzj6O/EiUTcy59y4iLZZfruBZkUX37MH5VpxslKnIbr9/2HAo58nu0YcVm1UrbeLTXdpzt42aSxIMckhiEftx+2RAotvb9Ve+xBGlTnYmCYVrR7PDFYvImSBgF+XY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 745caa94-23cd-4bae-649b-08dd3bf365cd
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5143.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2025 21:17:52.9753
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dhon6SfHWtn+JlcCbrFrp5zR+/IT9vlr5/AkF0W1zEdWeCoA3xAXKvHSfCclWoLHpawYoWA7VKXpTsDDjphiRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB7462
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-23_09,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 bulkscore=0 mlxscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2501230153
X-Proofpoint-GUID: S3IGGIZa_p2f1BIH5YKux4ELC8ZvGfFl
X-Proofpoint-ORIG-GUID: S3IGGIZa_p2f1BIH5YKux4ELC8ZvGfFl

On 23/01/2025 8:50 pm, Jeff Layton wrote:
> On Thu, 2025-01-23 at 19:36 +0000, Calum Mackay wrote:
>> On 22/01/2025 5:13 pm, Jeff Layton wrote:
>>> As of python 3.13, the xdrlib module is no longer included. Fortunately
>>> there is an xdrlib3 module, which is a fork of the bundled module:
>>>
>>>       https://pypi.org/project/xdrlib3/
>>>
>>> Change pynfs to use that instead and revise the documentation to include
>>> a step to install that module.
>>>
>>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
>>> ---
>>>    README                                | 8 +++++++-
>>>    nfs4.0/lib/rpc/rpc.py                 | 2 +-
>>>    nfs4.0/lib/rpc/rpcsec/sec_auth_sys.py | 2 +-
>>>    nfs4.0/nfs4lib.py                     | 2 +-
>>>    nfs4.0/nfs4server.py                  | 2 +-
>>>    rpc/security.py                       | 2 +-
>>>    xdr/xdrgen.py                         | 4 ++--
>>>    7 files changed, 14 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/README b/README
>>> index b8b4e775f7766086f870f2dda4a60b3e9f9bac6f..efdc23807e8107b8fcd575e8a4c80b9c73e3cd07 100644
>>> --- a/README
>>> +++ b/README
>>> @@ -14,8 +14,14 @@ Install dependent modules:
>>>    * openSUSE
>>>    	zypper install krb5-devel python3-devel swig python3-gssapi python3-ply
>>>    
>>> -You can prepare both for use with
>>> +Install the xdrlib3 module:
>>> +
>>> +	pip install xdrlib3
>>
>> Thanks Jeff,
>>
>> I see that Debian's unstable & testing suites have a pkg
>> (python3-standard-xdrlib) to provide this post-removal from standard
>> Python. Of course, that's not in general release, yet, but then neither
>> is 3.13 itself. Not sure if we should mention it?
>>
>> e.g: your distro may provide xdrlib3 via a pkg (details…), or you may
>> install it via pip…
>> or similar?
>>
>> cheers,
>> c.
>>
>>
> 
> Sure, I'm fine with phrasing it that way. Mind fixing it up when you
> merge it?

Yes, of course! Thanks again,

cheers,
c.


> 
> I'm on Fedora 41 which ships with python 3.13, so I think it is in
> general release now. Fedora doesn't have xdrlib3 packaged however, so I
> just used pip.
> 
>>
>>> +
>>> +You can prepare both versions for use with
>>> +
>>>    	./setup.py build
>>> +
>>>    which will create auto-generated files and compile any shared libraries
>>>    in place.
>>>    
>>> diff --git a/nfs4.0/lib/rpc/rpc.py b/nfs4.0/lib/rpc/rpc.py
>>> index 243ef9e31aa83eb6be18800065b63cf78d99f833..475179042530a8d602a51e7bad1af7958ff5dd56 100644
>>> --- a/nfs4.0/lib/rpc/rpc.py
>>> +++ b/nfs4.0/lib/rpc/rpc.py
>>> @@ -9,7 +9,7 @@
>>>    
>>>    from __future__ import absolute_import
>>>    import struct
>>> -import xdrlib
>>> +import xdrlib3 as xdrlib
>>>    import socket
>>>    import select
>>>    import threading
>>> diff --git a/nfs4.0/lib/rpc/rpcsec/sec_auth_sys.py b/nfs4.0/lib/rpc/rpcsec/sec_auth_sys.py
>>> index 1e990a369e6588f24dff75e9569c104d775ff710..2581a1e1dca22f637dc32144a05c88c66c57665e 100644
>>> --- a/nfs4.0/lib/rpc/rpcsec/sec_auth_sys.py
>>> +++ b/nfs4.0/lib/rpc/rpcsec/sec_auth_sys.py
>>> @@ -1,7 +1,7 @@
>>>    from .base import SecFlavor, SecError
>>>    from rpc.rpc_const import AUTH_SYS
>>>    from rpc.rpc_type import opaque_auth
>>> -from xdrlib import Packer, Error
>>> +from xdrlib3 import Packer, Error
>>>    
>>>    class SecAuthSys(SecFlavor):
>>>        # XXX need better defaults
>>> diff --git a/nfs4.0/nfs4lib.py b/nfs4.0/nfs4lib.py
>>> index eddcd862bc2fe2061414fb4de61e52aed93495ae..2337d8cd190de90e4d158b3ef9e3dfd6a61027c5 100644
>>> --- a/nfs4.0/nfs4lib.py
>>> +++ b/nfs4.0/nfs4lib.py
>>> @@ -41,7 +41,7 @@ import xdrdef.nfs4_const as nfs4_const
>>>    from  xdrdef.nfs4_const import *
>>>    import xdrdef.nfs4_type as nfs4_type
>>>    from xdrdef.nfs4_type import *
>>> -from xdrlib import Error as XDRError
>>> +from xdrlib3 import Error as XDRError
>>>    import xdrdef.nfs4_pack as nfs4_pack
>>>    
>>>    import nfs_ops
>>> diff --git a/nfs4.0/nfs4server.py b/nfs4.0/nfs4server.py
>>> index 2dbad3046709ea57c1503a36649d85c25e6301a8..10bf28ee5794684912fa8e6d19406e06bf88b742 100755
>>> --- a/nfs4.0/nfs4server.py
>>> +++ b/nfs4.0/nfs4server.py
>>> @@ -34,7 +34,7 @@ import time, StringIO, random, traceback, codecs
>>>    import StringIO
>>>    import nfs4state
>>>    from nfs4state import NFS4Error, printverf
>>> -from xdrlib import Error as XDRError
>>> +from xdrlib3 import Error as XDRError
>>>    
>>>    unacceptable_names = [ "", ".", ".." ]
>>>    unacceptable_characters = [ "/", "~", "#", ]
>>> diff --git a/rpc/security.py b/rpc/security.py
>>> index 0682f438cd6237334c59e7cb280c8b192e7c8a76..789280c5d7328a928b2f6c1af95397d17180eff9 100644
>>> --- a/rpc/security.py
>>> +++ b/rpc/security.py
>>> @@ -3,7 +3,7 @@ from .rpc_const import AUTH_NONE, AUTH_SYS, RPCSEC_GSS, SUCCESS, CALL, \
>>>    from .rpc_type import opaque_auth, authsys_parms
>>>    from .rpc_pack import RPCPacker, RPCUnpacker
>>>    from .gss_pack import GSSPacker, GSSUnpacker
>>> -from xdrlib import Packer, Unpacker
>>> +from xdrlib3 import Packer, Unpacker
>>>    from . import rpclib
>>>    from .gss_const import *
>>>    from . import gss_type
>>> diff --git a/xdr/xdrgen.py b/xdr/xdrgen.py
>>> index b472e50676799915ea3b6a14f6686a5973484fb2..f802ba80045e79716a71fa7a64d72f1b8831128d 100755
>>> --- a/xdr/xdrgen.py
>>> +++ b/xdr/xdrgen.py
>>> @@ -1357,8 +1357,8 @@ pack_header = """\
>>>    import sys,os
>>>    from . import %s as const
>>>    from . import %s as types
>>> -import xdrlib
>>> -from xdrlib import Error as XDRError
>>> +import xdrlib3 as xdrlib
>>> +from xdrlib3 import Error as XDRError
>>>    
>>>    class nullclass(object):
>>>        pass
>>>
>>> ---
>>> base-commit: d042a1f6421985b7c9d17edf8eb0d59bcf7f5908
>>> change-id: 20250122-master-68414e8f6d5f
>>>
>>> Best regards,
>>
>>
> 



