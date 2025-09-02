Return-Path: <linux-nfs+bounces-13990-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C01D7B40F2D
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Sep 2025 23:16:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 333E11B2134C
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Sep 2025 21:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9D9326AF3;
	Tue,  2 Sep 2025 21:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="atCq9rf2";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="K+cqTG3g"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E88B21FF38
	for <linux-nfs@vger.kernel.org>; Tue,  2 Sep 2025 21:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756847781; cv=fail; b=uxxkNxmzgkiT2Fq0W0h433+ZvkDE5UN0XBgBO5qgUD01f55Du5zhSDGPn65IeDy4AfQ+IrPmC3e2s4b6jc22VORaP07legCOXVPTj4YaOCe2DWr9o+4ZOVBHYEH33tmW4ND+zU/fBA5k5MD7Wnl3Zi/U2WeqC37iS+P31efttNA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756847781; c=relaxed/simple;
	bh=izMtXyPGKYT/sgHFhkSizeVVjLWYXtE4u+OR8lUt8W0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=k0sGPcIDmW1ydkVRUmHx5Pd2hukQ6r4q7R3cXVQ6pmF6eEElACNU7KzZOrExhhxP+R6C5eIekfHxFhemEUcms5gNq5k6KgzAD7/Dk0WbUiAAcy7yTFHh6X0C54MESkOsGRxpLhZWEhG9o5GKRlFVHLy+CyABA7aLmuxb8ZnuuLM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=atCq9rf2; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=K+cqTG3g; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 582Ki5U4030552;
	Tue, 2 Sep 2025 21:16:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=6WS6qknksZoF0Xm3Dc9r+XGYwUYjx6ocguita2qhbZo=; b=
	atCq9rf2sCm7v/iY2/Zl7JTG2qzdTA5b9V2OdUUU6uePLI3T2uTBBq1D3ITemmJV
	BHZ22MejwfRxTWI2ystjwTde9MmM+XmHEs3iuWM4MaEM9wnxF+R49wZJ/SWrgaCd
	m4zZuJ0F5j7g5d5OEhkh0qTSgthZUc8mKcv6VrA/oXdSGAN0XkhadSIdxwpKLqGz
	2teQ7c6dn/ToEx7AxNUnF5KCWiHpwJ4GzSoQYVUNPSWX4hSp2SypvX/d7GPemt3M
	JiPIM40h0Ld174Krf9kdsDYIw14OU5JBG/LN9a3FTn/m6ydEyYI03+kZjX5eCCM5
	6psLOmYKjdqIWclvlvaheA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48ussymww1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Sep 2025 21:16:16 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 582KSZwR036186;
	Tue, 2 Sep 2025 21:16:15 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2040.outbound.protection.outlook.com [40.107.243.40])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48uqr9kuyx-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Sep 2025 21:16:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fSfSVbGHrQIebiVghv/V3eQua4uhNkB685jUmU6IEG0PxPmNYrWPaBItE1GdmUozyoHaOoA7X08DDgTJN3/6Ycln9Rex83BbetO6fXQRP2gGybg3hMDX+0X5nVAaMyYR1Nej0u3eRNdhrBxMRmkpnXMLgGt8UjH1fKI5kfGX3vj7i3M2GthDh2yZXal62wN37VxdbhRLR9JD9xkhxj3aFHA3+T+HvPreGVHo/w+IvnohfEgXT3CtPdfdBLGqWSAGXd6oNptvm84zsGgY5rMKDwbxbRxl6Pe5SHm2Y7B7aPau6j53Z6cV9VKo33QFe7RLpijfCEV4XDsa8gweKgL9og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6WS6qknksZoF0Xm3Dc9r+XGYwUYjx6ocguita2qhbZo=;
 b=vwv2hy0yA4SGkRlMpol0juo2eaxY6NujodVk2mnZDAwmS2u4MEroSZ1/uw45zChHlWMQ4TclKLIN2l3BD5nLAivKHxKshlLd4pAZKodIwybb8yxxU/vIR9yE2k+D2qavhAW1ZG1Wn5uoXRRDJT5OcQ+0HpQUewWG0nRCx3DhAKtqELJs3ToMftOnh0jXqyph1txRigb9NioUXfgSRDCJq+3u0vfomJZLXEPAhknTWB5jaBeewNtnbJgaj5A+VcTTSXC7Z2B3/WHM2fTatAt0MnaFFhAJc1jbKExTFKKYSytKuF/+CWmjEJwpYUk8XOeQWpkUJCQxFUnp79R8FLAoZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6WS6qknksZoF0Xm3Dc9r+XGYwUYjx6ocguita2qhbZo=;
 b=K+cqTG3gF2Yps1VE803MHGl6aBSoMVPMu8XC8tY6w9ZmbcljAsJt2TotqulDt/uIQyr+UKe+15bEHjUDCNPi0TuFE8rhb6i2Sl/CVbk6xGjbOziaCm7MIuvUIgyTS+Yf8aj+D5gNydiCaHB/YcIpXHd3ZNpsmpotCfZOazfcE/4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ0PR10MB4687.namprd10.prod.outlook.com (2603:10b6:a03:2d8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 21:16:11 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%3]) with mapi id 15.20.9073.026; Tue, 2 Sep 2025
 21:16:11 +0000
Message-ID: <18b20826-3c9f-4763-b0ac-c7f1dc2be4d4@oracle.com>
Date: Tue, 2 Sep 2025 17:16:10 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2] NFSD: fix misaligned DIO READ to not use a
 start_extra_page, exposes rpcrdma bug?
To: Mike Snitzer <snitzer@kernel.org>
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
References: <aLClcl08x4JJ1UJu@kernel.org>
 <20250830173852.26953-1-snitzer@kernel.org>
 <20250830173852.26953-2-snitzer@kernel.org>
 <2559f795-bdc9-4d39-aa03-e6a6d89e9f84@oracle.com>
 <92908105-9261-42f9-a0fd-ebfaf3e2f564@oracle.com>
 <aLdcbnELMGHB-B_E@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <aLdcbnELMGHB-B_E@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR07CA0009.namprd07.prod.outlook.com
 (2603:10b6:610:32::14) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SJ0PR10MB4687:EE_
X-MS-Office365-Filtering-Correlation-Id: 266cae47-331b-4a4a-ddc5-08ddea65f128
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?eHdONStUOGFaM0ZBTU0xb0s4VURrZ3VrYk5URGxza2RndDlZZVRpTDJnY1BJ?=
 =?utf-8?B?OGpTblpJSk1kUVFySHJycVVTOGd3RDFHMCtXTGhvQUFGRzB1V2l4MlpRMWZW?=
 =?utf-8?B?NmdTd2hNOXRwNkdwRmxqSWN4aFBTcHl6RzM0cVpwaFlMQU1iT0lSOTBWTXRD?=
 =?utf-8?B?Z2hkTThocE9XM3dKenA3dzJVRUNaZG9zN3JyTEs5QUlLQ2VLZ0pXVDMvUlk1?=
 =?utf-8?B?ejRyTGJ6cUFpLzhNVy9sWVg3QlpzTXpteElVUjBmVGdXQ2NEZVFDaFQ3OTZn?=
 =?utf-8?B?RElHejVmMlhuQzZIWGM1UnkvWmdzWkNSV2c5R2VoZGkrUXIvQWxEYTdSN2xY?=
 =?utf-8?B?U3BGMUFrZmY1dFNVKy8xbHFVVFRGcHk2U01YOHRwR2dlWGY3UTlBcmoxaDJK?=
 =?utf-8?B?Qnc0STBod01qSGxUdkZEWVNsL1RENU1kT1NBd1hpZTVoZkdkK1J2UEJGN1d0?=
 =?utf-8?B?VEc0VHJDT0kvMGQ3T1ZGVm42UkRjayttMlQ4b3J1TGFjdGlGR25XRFRRcFhF?=
 =?utf-8?B?b3hKU2hzV1NhRnk3bjZBNTRoS2R5WHYzclV4Ty95dkdIQmx6WUpwVGkxZjl4?=
 =?utf-8?B?R3hvSWVJbUZYc0s3MVBycklXZTJ3R1puWFM4aFhqSFFINGVYYmhvcThIRUx0?=
 =?utf-8?B?VitaQ0NjYmJISEJGWUFCcENyalp6bjVXK3hiUkIxdCtBdTdIZ2lNb0lwMnVN?=
 =?utf-8?B?RGdMWitKSTJ4L2JhMnRBZXVjOHNaL3BxNktIdXhzaThFTUI2RHdyUGx5Wmhk?=
 =?utf-8?B?aHY1K1ZFRmUxbnZuWGczME50SDhjUHBLcm9pcXNlY0xiMTVNSUZDcVZ4cXFz?=
 =?utf-8?B?aUJnNXl2cStNUVZvSmhsSTk5MnZCdWFTRkRRRkdMbytGMlBLbnlBM2hkams3?=
 =?utf-8?B?OGlKUVZ2SUFqNTBFWFAzQUNzWUt3ejltTVR5cU0zQkhBbUNQUkkzMEoxZy9J?=
 =?utf-8?B?cmx0WXNSU2dFNEZyaEpWRWZLNlBicm1GSGxVeWEvb2VaR2YvRlc3SjZVUnpP?=
 =?utf-8?B?NGV6dnZkTEhtcWVYcnYwSmFjVjAzMG5pclVDckJTQmxsdS9OaStqbGdiZE1M?=
 =?utf-8?B?ZEFKRk9VbDFIUkR4aU1TV2dMc01Nd3JyTk5oQk0waDg2ZVFVbXhTMEE3cWVJ?=
 =?utf-8?B?MUZ5L25DWjJweGxYNndRUUFuMlYrM2xaZTAwa290SjRZbTNrTVNrRHFmUlRQ?=
 =?utf-8?B?RnJwbFI2RW42RTNlY3BZUEFkalFOaEsvM3pIZ3o2UW0ycmNDQi8rOFF0eFRr?=
 =?utf-8?B?MXZYTEVMaGNUZmxsT0g3czg1OXp0QTRBZjNNcUlkZUlvdyt4MnRQQ3FsK2hX?=
 =?utf-8?B?T1IrS0xwSmIrYU8rdzNxeXBvSDB2bnBNTmRmeGNRSnl2SGRISFJZQW1uZlZK?=
 =?utf-8?B?MitKNTRZUnR2d2V3dUE2ZjI3b3dPc2o5ejk1VXJQb0tuK0srRm5sdXhGZzUw?=
 =?utf-8?B?aWNPN1VNb2VNbGVkT1N2U1VBVTY1c2s0U0lMU0FLbVQ3WWdaWFAySUhGWVhG?=
 =?utf-8?B?eEtyUGFOUHB0VkpTSzd0RkhQZ1JFMGtiQ2N1b0xjMlhWNE1hd291VDNPYWdr?=
 =?utf-8?B?aSt0SFVmZ2x3RDc2aXc1OWlpcHpqMStGY2hjMThScFpjRUUrYkhVc0YxcWRr?=
 =?utf-8?B?UXJ1VzQyajFyNXFydW1IbzBiTVVYYUdFOGZQa2xFeGtwNkpLU1NDUzh5RW16?=
 =?utf-8?B?c1FSclNqbE9qbU45aUtZemV3Zm5sVmIwSDBuMFdjWjVDU1JpYXJtME5YYmht?=
 =?utf-8?B?Tmp3YTFCRldJWDRKWEZ2ZmN2RU5mRThwa0Fzc1JoT2JRb1YyU2NkMlFNbnlt?=
 =?utf-8?B?QnBGK3FYMFl5RkJFNm9zN1hqTFVZNmVuS3Z2Qm9oby9PMkdNTEpQNjRrWmU4?=
 =?utf-8?B?NlM5YnMrVXFJenh4dXZHeGpsRUdZSEUrQWlPeEZmbk1aSHc9PQ==?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?VGEzdmV1UXZpMnlNSUlNSlorbDcxaUJYNnhhbEpjRXlDaTRSU3JjV1ZBWUVU?=
 =?utf-8?B?cmRWdkNWS0czZVpXYkViR0RLQitlQ0dHQ1RWZ2d1elllb210Mlk0R1RTbnZl?=
 =?utf-8?B?aFZNemg1OWVhSDAxZ0VGOFFnT21zdVRWSXdOb1pFNHJSNWRVSFlYTlNTQTJp?=
 =?utf-8?B?ZzZXTTNESFJjN3NwOU91eUlVSGNJNks5SGJ2a05ha3BaNWZ3L2N6QXBaNEU0?=
 =?utf-8?B?d1Joei92TkhsYkEyVy84NU1KZUhkcWp5Q1gyQmJ4VW9tL2hFWW9qZkpkaDVj?=
 =?utf-8?B?czZ6czdUSXZSZldKSzBLaVlURlZkT1pYYkRPVFBzWU5YNUZicmpEMEFJRHpv?=
 =?utf-8?B?TjljN1E0TnFWVzhrYmZQVlZCMmIrT1RtQ0tteTJTampHUzFYR2RvMW5TTDFP?=
 =?utf-8?B?UmJEV1J5SUJKYjA0TUVYSVNZYzBkN0JQTVhpNW1yeFEyY3VjOGdrS05nMVYz?=
 =?utf-8?B?ZmJBRzdEbkRqNUJ2NGtYb05DcmZhMnQ1ZHNBR3Q3RXlKMFlPV1VTeEJZL0Js?=
 =?utf-8?B?WHNRWjJPZGJaSDcrb1lzM2NFeGs1N0s4VmlocGRKbjF1blFoK3lDMzBncjhk?=
 =?utf-8?B?blgwRmFxaHN4RjYreWJOTlpaR1R5YlJuOU9PeDFJb0JIYTlHaGU1UytTMGlB?=
 =?utf-8?B?MzVwbFg0a0Ivcm4xRG1YNVFHRmE1T3J2UlI5aWtwTENWZ084cHJwNENNaVFM?=
 =?utf-8?B?ZHFsdzVKQTRMRG5FVjhsSEdIRVhwelQ4WHMrK2REOXpCbysxUDlTYStCWXJu?=
 =?utf-8?B?YzBMMldSS1Q5Y25wY2ZmbHYzZzdDVXh1bENFSE5IS2E2aEk5eEhnWGF6Y0FJ?=
 =?utf-8?B?YytSczlFRE5TamI2eEVVSlpjeUZFWHkzNmNVODRjeGhHbWV0UjRnK0JuUnRJ?=
 =?utf-8?B?bk1hdW9uTE9UTGJuYVE4QXBOQ1dITHo3cC9rY0NRZGxpaURwYzJ4ckR0TGtD?=
 =?utf-8?B?NjdkZktyV3RaYjlzSml6ajdVRisyVlJlSS9acnFGem5aNXphd3lpYkZoTTBE?=
 =?utf-8?B?eGd0NS9ML1JzN2dXbFdka2dueUpYb0VzdnBsYWpjL2JnbWsvTURTZ1dnaTBk?=
 =?utf-8?B?a2ZsTUQ5RkNkaGlxdnpxRVZNRldXLzBBWGUrY3JtWEhnMld0c1BxWkZyeVZ0?=
 =?utf-8?B?V09oUGJ2clFhYVlrdVMzaWJGRWR1NitET0dYL0c3bTAzZ3QvZUc4bCtNZHkv?=
 =?utf-8?B?UXhrYzYxaDBoM21pMWxETFNKUEpDY3FoNnM0ZWN0QjlVeUNTYWlaQVMvTGRx?=
 =?utf-8?B?OEV3UjFpZWF0OVNJelpvOVQrZ28zcDFZTVErcTI5YWY1b2ZQSnAvdE9yOGhm?=
 =?utf-8?B?K2s1cDkzb2tVeG1yVEIyaHlablNiUDFCMlBOME5QcnZ0QVBteFA3UUhwY3l5?=
 =?utf-8?B?NFV4UG52THBVU1FWKzIxZ3hxYVl2cGlpLy85Ny9PU0htSHlHTkx3YWs0UktF?=
 =?utf-8?B?WXQwQ1V1SlNCNWJRRHhwZFZSZGJydUpyckpUSkN4STZxazM4WXIzcld3SXl3?=
 =?utf-8?B?S0tQb0l3dGxERFNaQkNtUUROaDJIV0JwOVBVejgwejZMWiszN2syVVBQdjNi?=
 =?utf-8?B?UGYxOUZzR201aHhPV201ajJOZEl3OGJ4MkRvMDhzd1AwSVIxbGozQmlBVEZs?=
 =?utf-8?B?a0tqR2c2NUt3NzI5MUtHeGhpSFMwTmJONDRIYTN1N0k1SVFER3JvWnRRR01P?=
 =?utf-8?B?dlJSNmcvOFNYdk1tK1NHeCtFeUtZUjlZcmRBVjlrNlZvZHFqMlFmNG4wcmNp?=
 =?utf-8?B?ZUg0dUFSWCt6VllJWnNVTENFSElRTHo4NXZYTVZpR0NRL1hlOEJMa2xBaU5i?=
 =?utf-8?B?NXBIOWQvdjlRLzdleExxTHVNWjJPQlRlNmpxOTgvSGpNeGV1STJqZHhrT2V6?=
 =?utf-8?B?V2RocFUvQ0E1YXVxUjNDQUF5UlQ4dzQvUlEwMGYxV0V3THlmV2VoVE5zN2dB?=
 =?utf-8?B?OWVldWh4VWZpVzZUanJ2V2hTaU13bVpRK0ZKbFgvSW0yTUEweGF0Z1BORVBo?=
 =?utf-8?B?ajFxei9VdWYvbWNOT2hLMnRmZjdybEhzMjFmOVd5NlkvZ0FQU25KeUtZamRN?=
 =?utf-8?B?MTVadzlmS05yTUNkRkxGTXgwd0dsajJJem9vZzEvNktmL1I3M2loNW04ZURw?=
 =?utf-8?Q?UEHSco/kBp+qM/6VIscgR53jE?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0YR04YMD/eWqtvKYBNqv6v/W6EzwO8L8d4KxNyX0H/UWP0BDP/g3uvw9dfzJb6N9X4YvYmmqrRGV5H0ceh1k57VclgiYyDnf1xMpeSN0H1XXpTtKCQxUgVuO5mXZTvVxVG+CHQeyqAnBP/oecGu5TdDaL/TEYyHPqigDUgXorwy6Ul6GPdpH3qmILa/5SnUy1Si5/O7hYvdzdr6mPudGVYm1ThV+ex3kLkF8cJby2A399jXtD9N7n8cCi08dwsTKLI/CN7rb3zon7dkISiBiAHQd1ZxbwxRs/hgA5XTsVDUX44QK+4/IhkBEI9INsP8HxQ6V3ulEUJn63j5NFJ49+rz/H0jhuJCozPUHOwAWmx6hgw4xTGyrhLQIPLJ6qRNVCJZtBP+gvg9LOtKUb+vcquv3h7RdFnbqoVJgJYqd02bKdgmfS35B4SX/AiX+1thConAy6V78ivmw+jnGF+K3cT8KDq+ah4YxuS33itIFzzYzkYoSwuuvE+cesrcTPAKv0XxqpTZueojStGUGHZMPxPNFYjkpviTrhsmvKJWpVT81jiiKLTeYAVL6e7yRknBAfa5pN2X0rp7FVLvWHSkOF4FcLP50EFJdrvaj+cjwjng=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 266cae47-331b-4a4a-ddc5-08ddea65f128
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 21:16:11.7433
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: snRzRdCj/QFfn/TKmVDpwrcO2SLvVdNrDPt7usD87J77215pSLFTBl2RQrUb5BUwpQFrStPAmvKMF/IkpNxM6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4687
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_08,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 spamscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509020210
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzNCBTYWx0ZWRfX9pd0ruPYy4uB
 hCDmqXRVimSmruFie2BUeUQtOln9g2NuGT/ytmjqJY2dImpq3NOCxy78QZm9B0HhVHNn4sze3FC
 HiPcH3a+UWvUw1rIPdRhPRmdhurDCJ4+3Oo8ZYk6Xj8f8Mk+j599yaFDhTR21OQcVTZzyUX9Hde
 RiaV5Fasd42kMsQAXWDNcBpc4u2Kf+ssOE7H/+y1B6PNGv2Ky2FJA3M8yCX5fukRhDQ0FbMl6vZ
 VZqxDf3uFyvj9dn+ig0h27xpkwWpRpuGuyDiY0OueUMUrtxT5TdoG19PYGZxKY/cgSXVd1KA0A6
 +5emGdBZj2wSdkXjSfIoEIfi6dqrKJ7p5XVWALXsuQyo6iuY8otIHqFI/+86lPPc755SKmql5JV
 vSU783jt
X-Authority-Analysis: v=2.4 cv=X/9SKHTe c=1 sm=1 tr=0 ts=68b75ea0 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=Lb1rMZzfAAAA:8 a=krotFYTiGwUVuCK2LwoA:9
 a=QEXdDO2ut3YA:10 a=8TJlWAxZIw_9ZYUv8NPp:22
X-Proofpoint-ORIG-GUID: Jxlcibj6cjkRAIEMcpn42apoZAD6a55_
X-Proofpoint-GUID: Jxlcibj6cjkRAIEMcpn42apoZAD6a55_

On 9/2/25 5:06 PM, Mike Snitzer wrote:
> On Tue, Sep 02, 2025 at 01:59:12PM -0400, Chuck Lever wrote:
>> On 9/2/25 11:56 AM, Chuck Lever wrote:
>>> On 8/30/25 1:38 PM, Mike Snitzer wrote:
>>
>>>> dt (j:1 t:1): File System Information:
>>>> dt (j:1 t:1):            Mounted from device: 192.168.0.105:/hs_test
>>>> dt (j:1 t:1):           Mounted on directory: /mnt/hs_test
>>>> dt (j:1 t:1):                Filesystem type: nfs4
>>>> dt (j:1 t:1):             Filesystem options: rw,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,hard,fatal_neterrors=none,proto=tcp,nconnect=16,port=20491,timeo=600,retrans=2,sec=sys,clientaddr=192.168.0.106,local_lock=none,addr=192.168.0.105
>>>
>>> I haven't been able to reproduce a similar failure in my lab with
>>> NFSv4.2 over RDMA with FDR InfiniBand. I've run dt 6-7 times, all
>>> successful. Also, for shit giggles, I tried the fsx-based subtests in
>>> fstests, no new failures there either. The export is xfs on an NVMe
>>> add-on card; server uses direct I/O for READ and page cache for WRITE.
>>>
>>> Notice the mount options for your test run: "proto=tcp" and
>>> "nconnect=16". Even if your network fabric is RoCE, "proto=tcp" will
>>> not use RDMA at all; it will use bog standard TCP/IP on your ultra
>>> fast Ethernet network.
>>>
>>> What should I try next? I can apply 2/2 or add "nconnect" or move the
>>> testing to my RoCE fabric after lunch and keep poking at it.
> 
> Hmm, I'll have to check with the Hammerspace performance team to
> understand how RDMA used if the client mount has proto=tcp.
> 
> Certainly surprising, thanks for noticing/reporting this aspect.
> 
> I also cannot reproduce on a normal tcp mount and testbed.  This
> frankenbeast of a fast "RDMA" network that is misconfigured to use
> proto=tcp is the only testbed where I've seen this dt data mismatch.
> 
>>> Or, I could switch to TCP. Suggestions welcome.
>>
>> The client is not sending any READ procedures/operations to the server.
>> The following is NFSv3 for clarity, but NFSv4.x results are similar:
>>
>>             nfsd-1669  [003]  1466.634816: svc_process:
>> addr=192.168.2.67 xid=0x7b2a6274 service=nfsd vers=3 proc=NULL
>>             nfsd-1669  [003]  1466.635389: svc_process:
>> addr=192.168.2.67 xid=0x7d2a6274 service=nfsd vers=3 proc=FSINFO
>>             nfsd-1669  [003]  1466.635420: svc_process:
>> addr=192.168.2.67 xid=0x7e2a6274 service=nfsd vers=3 proc=PATHCONF
>>             nfsd-1669  [003]  1466.635451: svc_process:
>> addr=192.168.2.67 xid=0x7f2a6274 service=nfsd vers=3 proc=GETATTR
>>             nfsd-1669  [003]  1466.635486: svc_process:
>> addr=192.168.2.67 xid=0x802a6274 service=nfsacl vers=3 proc=NULL
>>             nfsd-1669  [003]  1466.635558: svc_process:
>> addr=192.168.2.67 xid=0x812a6274 service=nfsd vers=3 proc=FSINFO
>>             nfsd-1669  [003]  1466.635585: svc_process:
>> addr=192.168.2.67 xid=0x822a6274 service=nfsd vers=3 proc=GETATTR
>>             nfsd-1669  [003]  1470.029208: svc_process:
>> addr=192.168.2.67 xid=0x832a6274 service=nfsd vers=3 proc=ACCESS
>>             nfsd-1669  [003]  1470.029255: svc_process:
>> addr=192.168.2.67 xid=0x842a6274 service=nfsd vers=3 proc=LOOKUP
>>             nfsd-1669  [003]  1470.029296: svc_process:
>> addr=192.168.2.67 xid=0x852a6274 service=nfsd vers=3 proc=FSSTAT
>>             nfsd-1669  [003]  1470.039715: svc_process:
>> addr=192.168.2.67 xid=0x862a6274 service=nfsacl vers=3 proc=GETACL
>>             nfsd-1669  [003]  1470.039758: svc_process:
>> addr=192.168.2.67 xid=0x872a6274 service=nfsd vers=3 proc=CREATE
>>             nfsd-1669  [003]  1470.040091: svc_process:
>> addr=192.168.2.67 xid=0x882a6274 service=nfsd vers=3 proc=WRITE
>>             nfsd-1669  [003]  1470.040469: svc_process:
>> addr=192.168.2.67 xid=0x892a6274 service=nfsd vers=3 proc=GETATTR
>>             nfsd-1669  [003]  1470.040503: svc_process:
>> addr=192.168.2.67 xid=0x8a2a6274 service=nfsd vers=3 proc=ACCESS
>>             nfsd-1669  [003]  1470.041867: svc_process:
>> addr=192.168.2.67 xid=0x8b2a6274 service=nfsd vers=3 proc=FSSTAT
>>             nfsd-1669  [003]  1470.042109: svc_process:
>> addr=192.168.2.67 xid=0x8c2a6274 service=nfsd vers=3 proc=REMOVE
>>
>> So I'm probably missing some setting on the reproducer/client.
>>
>> /mnt from klimt.ib.1015granger.net:/export/fast
>>  Flags:	rw,relatime,vers=3,rsize=1048576,wsize=1048576,namlen=255,hard,
>>   fatal_neterrors=none,proto=rdma,port=20049,timeo=600,retrans=2,
>>   sec=sys,mountaddr=192.168.2.55,mountvers=3,mountproto=tcp,
>>   local_lock=none,addr=192.168.2.55
>>
>> Linux morisot.1015granger.net 6.15.10-100.fc41.x86_64 #1 SMP
>>  PREEMPT_DYNAMIC Fri Aug 15 14:55:12 UTC 2025 x86_64 GNU/Linux
> 
> If you're using LOCALIO (client on server) that'd explain your not
> seeing any READs coming over the wire to NFSD.
> 
> I've made sure to disable LOCALIO on my client, with:
> echo N > /sys/module/nfs/parameters/localio_enabled

I am testing with a physically separate client and server, so I believe
that LOCALIO is not in play. I do see WRITEs. And other workloads (in
particular "fsx -Z <fname>") show READ traffic and I'm getting the
new trace point to fire quite a bit, and it is showing misaligned
READ requests. So it has something to do with dt.

If I understand your two patches correctly, they are still pulling a
page from the end of rq_pages to do the initial pad page. That, I
think, is a working implementation, not the failing one.

EOD -- will continue tomorrow.


-- 
Chuck Lever

