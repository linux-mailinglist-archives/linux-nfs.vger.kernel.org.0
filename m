Return-Path: <linux-nfs+bounces-13467-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C61F6B1C970
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Aug 2025 17:59:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEE771754A1
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Aug 2025 15:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC73298255;
	Wed,  6 Aug 2025 15:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="d/fAGcRK";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ckwB7PlX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ACC2296141
	for <linux-nfs@vger.kernel.org>; Wed,  6 Aug 2025 15:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754495929; cv=fail; b=cT21knBbDKE4t0nXkbOqfvjrzRvYHFGm/gwOoMRgptNwbaRMMSwEbTWcvgvRTlsEbXyc3nQtLoCF4zoefX4bTqlnZMr710OpENwQFaqdVTSr5HHXa0UtLKHvlGwzkf7MpkoYwGWe+HZpdRH9MueArYMlbPm7ulfvbBVS4yyLYOc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754495929; c=relaxed/simple;
	bh=isTAitl8xqTiPKCDpQCapMTWU5EZIoUOoYeALIl34M0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ELuQlp/LQA9YT+5ZdN8rinGThfYFOh7nprOhXfoNSif5sRVt6juUagZW5VulPAKmyNHlGcbm/NLz/RCPNz73a5iqQpdvEsukOXp92DzJJInnpHclxYxTHttyt5hl0MwI3J3dqMGrJ4vDCqPGpmkHrU9IkfKwKnqNfMistHfAEzE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=d/fAGcRK; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ckwB7PlX; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 576CRQPk006862;
	Wed, 6 Aug 2025 15:58:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=W5nLteO/mPx/1DOU3p7HFPuZWlSXbA5aiZ2Hc3GMhD0=; b=
	d/fAGcRKWhC1aGaWOXon5XVTmqzls0Rhq2JnAptlaKKskej6a9uDxGDCGE17gNll
	ix9iBPmOBCtmKFZFIiwUVO8b+gX0s3WdL+05sLf7zgEKQqhY1paKF8fMd2KTwm45
	YCziU1wnU/yvgqe7v/2qaBOgfFwchjc1toYEcXOM1yJzUYGVb2hTFhpRhb9Xfdyw
	abKgcgp/b0KBpH7IP18QaBz9NIBq6zLeIU+YfGgjdrkAtuYH5Nz+bOvoQvKj58v4
	vRyv/mjUqT3cDW8iSJiGbawMLN5mRYko7Hdwzv5lxD4UWmfE0E3Ru0Aoz0fT69JV
	kGQa1/BFItDMv2gibB429A==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48bpxy2537-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 06 Aug 2025 15:58:36 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 576Fm7TD018462;
	Wed, 6 Aug 2025 15:58:35 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2057.outbound.protection.outlook.com [40.107.220.57])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48bpwr7rt5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 06 Aug 2025 15:58:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VbtYv7ISqJBdjjmKCpq0De6Y1hpAP193cbBYfyyhM8S46EvBGEOVjWhMcaK5XqchT9t2PtLXlJhzBv+glD/YKFAsJ/9UnVGwmMcC2WRcqZFUaa/6IFetLO93CuIFjIN7NINgEwBTbZldwLrq1co16crwDAyLMxzxX8E7qiCpiVvyQJu30Ns1KXsXLEJ4aNm2sGyIAxbuXei65r5wj0Fwc4C8DP+kEds7/YjXJ6v3QvjDOdzFV8g+FrXrVHWo4b8Ibvn9n9DdLEJOYBgsNM42JKBfImsmZAZ9Lwc0e9Qhl8GgR8NP7dMOjgnOO+Rm+LnNfyRNv4ZdDxUd+2HUuAgPFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W5nLteO/mPx/1DOU3p7HFPuZWlSXbA5aiZ2Hc3GMhD0=;
 b=IZtcQh1fKSggbxhcdsaWHEdwikrrFPrKz+ZAGeqop2+SCTixZRdzrGniSoZ6Nd7nOPRgKXN3oKLE45Uwmsy399ELwEsWhS6Ni/IdmnaAejTW79bZJeIgZSQlSJfP/94EbWTbJ1/Gtx9NdYfFFCL9GAu8bm6NSRxb2qEIcac/XOO1/b6G+lMrHzPQgi5ZsN1f26arcN4SBzGLDINdvE9obBwGC/HGLQJBn72OxSuBzppX6usC/19SMM864f7qiJLZjxzTkDfiUi5EU33uT0CExpxA+BP86ICq+lsyMpipl+FPAAeQw2rBNI4ehvT/mPxix5i1Y2C04nI5V3VpR89l2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W5nLteO/mPx/1DOU3p7HFPuZWlSXbA5aiZ2Hc3GMhD0=;
 b=ckwB7PlXSmriEMqSyNRIvgjREoxUyp1jJislk6e/MQkCyaGJnwDi66Ult8BPCvRFy2c0nC3hxVg7ppJJnqUqfx6bAC9qm4XecxR7HgiVMpu/DUiLEG4m9LNm0gOqSm9EYIOlhbyh6wJQkvZ13SF0PaSlG6UOxiRIR7GApqiiHg8=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CY8PR10MB6753.namprd10.prod.outlook.com (2603:10b6:930:94::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Wed, 6 Aug
 2025 15:58:32 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.8989.017; Wed, 6 Aug 2025
 15:58:32 +0000
Message-ID: <c0ec551c-bcfa-481f-aec3-08288326b41e@oracle.com>
Date: Wed, 6 Aug 2025 11:58:31 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/4] NFSD: avoid using iov_iter_is_aligned() in
 nfsd_iter_read()
To: Mike Snitzer <snitzer@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org
References: <20250805184428.5848-1-snitzer@kernel.org>
 <20250805184428.5848-2-snitzer@kernel.org>
 <d3249463-411d-4e0d-aa20-6489cd52c787@oracle.com>
 <aJN7dr37mo1LXkQx@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <aJN7dr37mo1LXkQx@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0071.namprd03.prod.outlook.com
 (2603:10b6:610:cc::16) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CY8PR10MB6753:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a2ac07e-5bca-40c0-0de4-08ddd50217f0
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?Z21CTzJzVzBITWdvWEg1RG1aNEtJRHNLa3lUeEJJMzJmb3p0S3k0dGF0cG1x?=
 =?utf-8?B?djhHRVRhaE9lT1o4NHRNNTA5NjR1Nlo1TGs1RnpOSTE3ajJEUVlZOGVtd042?=
 =?utf-8?B?cWY0SDBHbGdTck5pNmdaTG1BSG9ubytGMjd4d1dnL2xTb3o3ZmVLUDc1Rity?=
 =?utf-8?B?VHZuMkgwZlAzY3Y4ZTY5Wk50K3JXbkwvdUoydWhid3FUcXZ0Q242NGhJNm1J?=
 =?utf-8?B?MGZWR3RmcFcyYnAvbk1PR1Ezek5LN21JSkRkU0JPQlB1S2R0R2RpWGxraW5Y?=
 =?utf-8?B?YWJnbnlZOTNVN0M4WjM4MkNQVGJOejYyZ1FJaHVCYWtPeStvT2JMYVc5Yjhq?=
 =?utf-8?B?dS9LQmpkL3lUNXhDclF1N1hmdjZDcXlaR0krSEc0SlFrSkVLMzNySVFoU3pS?=
 =?utf-8?B?ZDJhWGErbmVHMVQ5d0tSdWdHU2dCS1kwaUkvazlFWFJDNFFSRUdObmkrV3NH?=
 =?utf-8?B?T29yZ2p6VXF5bkhnUEVwRExXYTB2Snp1VlZYWm12OVdGNmgrYm42c1BreFk4?=
 =?utf-8?B?Q1c4S216NWUzNnhTMHdJYTBpMHdGV29IU284SHJWWHdlcUo0VFNkWVZNSzFw?=
 =?utf-8?B?UnZjM0IrUzdlaUtiYnhNZzFWanB3WGRiRFlWTVhNcnJ3Qk4yRVNudTNjaEp2?=
 =?utf-8?B?ZkR6aEtZb3BZWjVSM3AycGVVZ3llODluNEFyR0ZQUXhDM3ErTC9WaXlmTytX?=
 =?utf-8?B?SVh6M2owdGcrdzdmQTRpZ2lHV2c0Qk1MS0RYeGkzbytoVzFoN0FiSnErWTVn?=
 =?utf-8?B?MGMxQjJCYWZTZHRwaWp0RktDNzB4WEU1d1pzckNibUxpSHRyclk4MC9IdVBE?=
 =?utf-8?B?aTh4RVpxTU8vRFFzYitMNnBTTDBkYzU3VzlqQU9oV3VIa0h6YzA4WWgzeXdP?=
 =?utf-8?B?cGlkQ2FnWW1QektFWnNHTGJ0LzZVbTBWQ2taQ2xhajdmMVk4UlJSZENnVWM5?=
 =?utf-8?B?cTJGRmtlQ1JmSW5NbXdBMjZ6aTlCeGlwcFFnbUV5dnJpRkNTa0xWY0Nha2lD?=
 =?utf-8?B?NlBaVDJKanJmNitWQ0pvTHhRcHIvNURCU1dGalNIZGU5bklLb3hvRGh4VHk4?=
 =?utf-8?B?Vk56Q0k2VE84T0Nkbkl0WVZKck5nR2ZCVm4xclVYU0txTEZtUXBnMS9yTFFz?=
 =?utf-8?B?aDZ6Ujd0WmFUSSsxb0hudi9DRy9XMUZvdC9jRUJMVWVNWWVCdjhzZ0pNSC9K?=
 =?utf-8?B?M245b2VNSTdqVTdnQ3FKUWVXNjlQRGUwZG9qaTg4d2RBbmdqZHpZNlVZeDQ0?=
 =?utf-8?B?cmI2T2ZueVlqaVZ5amxUam52NzJxWmZyNHcrOUJra0lyTEVVL05hNzBjUWpN?=
 =?utf-8?B?emU3OTYrWkJyWHJaRjdia3VENXBjb0FuRm4rNzg1M0pRUXdJeEtjU2lSQ0ZK?=
 =?utf-8?B?bEJYMWVPZmxNVlZoRUtwZW9SOFNLb3RtYXJNQ2lEdm1kSW0yRWFLbmwxcVho?=
 =?utf-8?B?bVB0MThsU0ZzSVlEbkRFZUV1K0NJR3p5ZlJiK1BlYS9hcENnWmVVaW53OW81?=
 =?utf-8?B?NDFYM2lrVWhjbTMrSjNBTVh0UFRNUjQxaXV4RVM4b0t4RE05bG95Q3Y1M3BS?=
 =?utf-8?B?K0h1VWU1cDR4S29ERFh3a0R4OU1hd3k0RDM2dDNkczBlamVaR3ZxY2c1My9w?=
 =?utf-8?B?WTBoeDRrYUZkOHBrNjVIQTM2OTY0QitBaUkvaVNpeW5BYWI4ZERmamxEcTZh?=
 =?utf-8?B?VHA1K3VscklnajBZR0tXR2JEZ1ZUODdjRWlLbG1sRm1IaWFsd2UvaHY2L2NZ?=
 =?utf-8?B?VDV5ZXUyam5SR3dBVzNlMjE4OERVbkNFcmdPZFd0ZkRwaktRUHFWTUMweDU5?=
 =?utf-8?B?bWZZUGk2cEZHMlRaellxMytFOXA3L2xyeFdBMDJHODVaajd6aTBzaW5VdE83?=
 =?utf-8?B?WUJVdVNGVmFCRWlSSUdnV2JHYWcwdDRZVUk0NHVwajUxQ2c9PQ==?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?QU90L2l5RkpKUFFMQzNHRWxrZzQwZjMrNTVicy9XM0YxWUtmQkJsVThNQ0Uz?=
 =?utf-8?B?NCtYMUJ3UmZ1VUVmM3lKWW5uUHZ0WEkzalAzNHZNS1NDRG1lMXhtSTlQajEw?=
 =?utf-8?B?cFNxNnpTTlZnUkFMWXVmUU5yb3F3RzJVUlZGNyt0SXlWVjQ0SGt5RzRVNXBm?=
 =?utf-8?B?em5uK0c5NUdQRlhwVTRtb0FaWnVUc1FjUitWVFJmZmJ6OEt6UXJEWUVpVjlj?=
 =?utf-8?B?VW9zeGpVUDB4Y0lpdnUxT1lVUTRIMDhrVCt5RHV5c3Y3Y3BCYUhXNFByK0tr?=
 =?utf-8?B?aW1FSVRjNk9hNlU2eGYyUGkwM0ttdmRJa2huOGhGanl5TUdqUTdEQzRKaUZB?=
 =?utf-8?B?SnhnU01BUkJnNXp4Y2pYTDB5aWI2YlJodFdnWW5UUTE5WGpOVzFVVVFEakIv?=
 =?utf-8?B?WWlpSTBHcVcvMnZBdWNGdFIzbll3M2pVTTRIcXg3NkdWb01zSHRiZndMcFVz?=
 =?utf-8?B?dXo5TmlQbGw5ZXpzaUwxZXBDZlNESDd6TGY5NE5GVmNpRGxuWEpSelVhSVFJ?=
 =?utf-8?B?alNoMDFQdk5obzNwNXFYY0MvZDk4SjUrVVRvV1h0VWtTaklmWGRyOWJ3anhk?=
 =?utf-8?B?ZzF2WUh3NmFTZVpyeXVZMzNWai8rbnVFTWhrY2RqSklaek5sd0RZaC9sV1I5?=
 =?utf-8?B?YTIreUFLRWhheUtnVmdZbDNLTGRKY0duWE8zeThldE5pdDhRMW15ekJ2NHp5?=
 =?utf-8?B?Q0o5WlhIN3JRa1lDK1d4ZkVYM2o1ZnF3cVkwUk1obnNzSVlXQmc5bldOcysw?=
 =?utf-8?B?MHErNU5iZWh1bGFNMWdoTEJuWnZZQWpBZEZDUkQxT0xKUWw5MkNjRy9RTjBO?=
 =?utf-8?B?N0hoanBydkpXSlIyRGwwRVIxR2VwekN0WFBjQ0dMZWR0Ukk3THJuWHQ5eFBz?=
 =?utf-8?B?MGU5MExNUHdqRklUTEsvVXNWUVdIenFXNW9yNTFIQXk4VHpvdUc5dk5NUkRt?=
 =?utf-8?B?dEhSY3lPcGhEY1lvV0lrV2NrZDErZHlSNm5FZlE5TlNlUkxSUU41TDRuUXVN?=
 =?utf-8?B?U1BPQmsramF6aDdabmdWNS9vVkpwd3hpVnBkc2srV2tIQlRyNkUxbUJmYXVj?=
 =?utf-8?B?QmhMMDdWa243RFRzQ2Q2YjFpU3AxNUZaR2pSMGwyajhxOGhXNldsTVNNZFZW?=
 =?utf-8?B?VUg3ZEVxY2owd2JkOTlrQ2NhdTJVSVVXOVlaMU90cmFaMERNZjBoNUVTeXAx?=
 =?utf-8?B?b0VEZGg1cC9kdHZVQytiR3BDNFpYQmhNRGlLRW5xUm5MYWZ0cU02eFE4Rk0x?=
 =?utf-8?B?YjhKd1krNis5cGVocVhneTFHck5UdDF2M29TZkk1dGx4TFJzK3FldjVVYzJQ?=
 =?utf-8?B?cmhEazFGWXFOMHY2VWlNb1d6Q012TVo0SzdhY25Uc3E3bVUydEFYdHdZTzlv?=
 =?utf-8?B?eGFYOWFYSFF3ck5QSjdBU2JYYzdZbXQxL25mei9OYU0rNVdtL0x1MWdJaTRU?=
 =?utf-8?B?aDFFTFhYVHlyU1pQdWFGVXR5SURLYXpRTEVYZVRQbzFKR00xTE1GODFYdVZq?=
 =?utf-8?B?NzdJZG1TcWlqOTJUS2dPeWVtWHkrL0xJTGgwaVo5NnRKa3ZRN1hlODU0aEFK?=
 =?utf-8?B?SFIwZkVqOUV1VVhaUWxMWGtkUDlRbitmc21GOTBIMjFPNTErbENDZGJqeTlH?=
 =?utf-8?B?TlIybWgweUE0cUhrWVRaZFlRYkxKeGpHNUk5TTVxQ2ZDUkFVWnNuMTJzaWlT?=
 =?utf-8?B?OWVoWkdKMEh3S2lxY2MxVTVBbkU5VTJQc1c4eFBBWUJQTG9SZk81R2VReFp2?=
 =?utf-8?B?bXJxWjJSd2pFSktqMy9WT2RRdnNyNEhaSjJLdWtUQm0rVnkzTDBUTGVqSXIr?=
 =?utf-8?B?Qkgyc09HWTRiVVRnWmZQejZJeFJLbWNMNzk3b3BJWGpoUkg4VTNxK2hqdkFI?=
 =?utf-8?B?MEJyK2VCOXRvMFNzckhwZTRkd0xMMDF4OXhwRzZPbmFlV2VJejBUOUh0em5K?=
 =?utf-8?B?V204ZE11ZFJEMjlIL2c3Q2dSbU9LdGFPejlENWE1eWVnamhuRFk2djJSSFRG?=
 =?utf-8?B?UEhid2Z6cXdtMCsxa2ZhaEFPUk83VFB4NXUyMUVLcW1abTB5K3pYb1ViZEFr?=
 =?utf-8?B?SWRwSDNYdytSQ0pYLzI4VDUxMjE2ZDVyK0dxUXNhME55aUIwS1ZGSTIxOThX?=
 =?utf-8?Q?0w1sZmRDSr30X77ruDemKkh79?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	bEWP1cHp7hiPPYV2IBTtM69/s62LWRdiy7IXJdwUV5blHVASrh1ex3/t25lPguV9duM1s/VGYNb5r4GKHot5Wq0qnCRmLhsz8CMmVTOnhIKz6QeM0I08a7yrljPXedt/Bccs/SeurW5pfTqVlAlWrV2Cf+/nLHUcl/HSJSRdq0p5/F5pMqdS0+WTyYORhLB8DS4Qcd+WDmkqOBUsm20EyKOSTL9hL8z9Xbm+n8JqdKfcfBePudU8/uvRLMUg2vPdq1uziPKzpw3qapymObcA4/idFpxb1DGWPIDDoTzvu61e9sMitGxKuFHpFVZFD0gSGkOldStAGoiDsVU5tYS0jhsjPzQBBfWfW/AZdHWFF2Wv4hLtkBWuuFCYIVZ7DT+FCqCYGBj4bZWtrzZvxdSIo/9KDa32T2hTin1QecfOQJqPbVjgoUi5TSp5Qhs3TkkqqG4xm6sq/LpuqKjQbNM7xy/0jFpF1N+MVVR6C7W9rF1ng1mKofbk7JrFaBZT1FWJ5eUsIJajedj7azCYgenlwj1pA/3AEaBXs0r+LTnLunHEttJyeZnbTvqVBNOg1rYq75Mh4p8Bw/YihrYB8qaGQ4OXoxCnTnXor004V01a8IQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a2ac07e-5bca-40c0-0de4-08ddd50217f0
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 15:58:32.5635
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M3LWKikvAMu9mJBaD5n1wnScyLWzl+2rlw9kYCxw+SKmw0xt7w2SCyKv4HhwGqAtwHLlco8D4avpfGlYa8/Q5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6753
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-06_04,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2507300000
 definitions=main-2508060100
X-Proofpoint-GUID: CoMG5VzcNYWv5O3PZF9LRHzBJ4xoY0s3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDEwMCBTYWx0ZWRfX3ivYs9B7U9ON
 Wq0OdBkIXMPYzHB3XKtwb/X/6UXC9yoBWF3FZ4V8pNecNNMpvXm3iblyrNAtLsv5rUtjsMJ5eWF
 EhqfKFR4Hx40Jst0RJkYWP6ZHY0l267k9muYvvBxZmvJCir9NxYul7BtbfdUhyDBqTMOgmEWqlZ
 Qjr6sg1P3mJ9iGoqWqr6vpa5yVHaXTNzXXTw/KZwl3EFG9MQWZ0KfvKl+ihz11Rq/imiPZ0iMrE
 +cm7ZYUq0V3adoC808i4FNZYJomAv/nUzV/V1GYnW7/Xe+POXpgIq877K9g+4Utwl4/gWamld4M
 xFl1bQIivBt/BUCxI7B4Bdmp+VhOXHQ+8/AxwtWCwthIDDJ9DmIhNFjqNLHB1LHCi1nDc1if20p
 7WY9r8qBZfL6M0xvkPZBfRkrTXsYplHaRKNuP8NNGARabkuVzd0gYt/nno0l7gfNW71jiH8j
X-Authority-Analysis: v=2.4 cv=Y9/4sgeN c=1 sm=1 tr=0 ts=68937bac b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=SEtKQCMJAAAA:8 a=p_AUCiraIvS0dPgTecIA:9
 a=QEXdDO2ut3YA:10 a=kyTSok1ft720jgMXX5-3:22 cc=ntf awl=host:12070
X-Proofpoint-ORIG-GUID: CoMG5VzcNYWv5O3PZF9LRHzBJ4xoY0s3

On 8/6/25 11:57 AM, Mike Snitzer wrote:
> On Wed, Aug 06, 2025 at 09:18:51AM -0400, Chuck Lever wrote:
>> On 8/5/25 2:44 PM, Mike Snitzer wrote:
>>> From: Mike Snitzer <snitzer@hammerspace.com>
>>>
>>> Check the bvec is DIO-aligned while creating it, saves CPU cycles by
>>> avoiding iterating the bvec elements a second time using
>>> iov_iter_is_aligned().
>>>
>>> This prepares for Keith Busch's near-term removal of the
>>> iov_iter_is_aligned() interface.  This fixes cel/nfsd-testing commit
>>> 5d78ac1e674b4 ("NFSD: issue READs using O_DIRECT even if IO is
>>> misaligned") and it should be folded into that commit so that NFSD
>>> doesn't require iov_iter_is_aligned() while it is being removed
>>> upstream in parallel.
>>>
>>> Fixes: cel/nfsd-testing 5d78ac1e674b4 ("NFSD: issue READs using O_DIRECT even if IO is misaligned")
>>> Signed-off-by: Mike Snitzer <snitzer@hammerspace.com>
>>> ---
>>>  fs/nfsd/vfs.c | 29 +++++++++++++++--------------
>>>  1 file changed, 15 insertions(+), 14 deletions(-)
>>>
>>> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
>>> index 46189020172fb..e1751d3715264 100644
>>> --- a/fs/nfsd/vfs.c
>>> +++ b/fs/nfsd/vfs.c
>>> @@ -1226,7 +1226,10 @@ __be32 nfsd_iter_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
>>>  			 */
>>>  			offset = read_dio.start;
>>>  			in_count = read_dio.end - offset;
>>> -			kiocb.ki_flags = IOCB_DIRECT;
>>> +			/* Verify ondisk DIO alignment, memory addrs checked below */
>>> +			if (likely(((offset | in_count) &
>>> +				    (nf->nf_dio_read_offset_align - 1)) == 0))
>>> +				kiocb.ki_flags = IOCB_DIRECT;
>>>  		}
>>>  	} else if (nfsd_io_cache_read == NFSD_IO_DONTCACHE)
>>>  		kiocb.ki_flags = IOCB_DONTCACHE;
>>> @@ -1236,16 +1239,24 @@ __be32 nfsd_iter_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
>>>  	v = 0;
>>>  	total = in_count;
>>>  	if (read_dio.start_extra) {
>>> -		bvec_set_page(&rqstp->rq_bvec[v++], read_dio.start_extra_page,
>>> +		bvec_set_page(&rqstp->rq_bvec[v], read_dio.start_extra_page,
>>>  			      read_dio.start_extra, PAGE_SIZE - read_dio.start_extra);
>>> +		if (unlikely((kiocb.ki_flags & IOCB_DIRECT) &&
>>> +			     rqstp->rq_bvec[v].bv_offset & (nf->nf_dio_mem_align - 1)))
>>> +			kiocb.ki_flags &= ~IOCB_DIRECT;
>>>  		total -= read_dio.start_extra;
>>> +		v++;
>>>  	}
>>>  	while (total) {
>>>  		len = min_t(size_t, total, PAGE_SIZE - base);
>>> -		bvec_set_page(&rqstp->rq_bvec[v++], *(rqstp->rq_next_page++),
>>> -			      len, base);
>>> +		bvec_set_page(&rqstp->rq_bvec[v], *(rqstp->rq_next_page++), len, base);
>>> +		/* No need to verify memory is DIO-aligned since bv_offset is 0 */
>>> +		if (unlikely((kiocb.ki_flags & IOCB_DIRECT) && base &&
>>> +			     (base & (nf->nf_dio_mem_align - 1))))
>>> +			kiocb.ki_flags &= ~IOCB_DIRECT;
>>>  		total -= len;
>>>  		base = 0;
>>> +		v++;
>>>  	}
>>>  	if (WARN_ONCE(v > rqstp->rq_maxpages,
>>>  		      "%s: v=%lu exceeds rqstp->rq_maxpages=%lu\n", __func__,
>>> @@ -1256,16 +1267,6 @@ __be32 nfsd_iter_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
>>>  	if (!host_err) {
>>>  		trace_nfsd_read_vector(rqstp, fhp, offset, in_count);
>>>  		iov_iter_bvec(&iter, ITER_DEST, rqstp->rq_bvec, v, in_count);
>>> -
>>> -		/* Double check nfsd_analyze_read_dio's DIO-aligned result */
>>> -		if (unlikely((kiocb.ki_flags & IOCB_DIRECT) &&
>>> -			     !iov_iter_is_aligned(&iter,
>>> -				nf->nf_dio_mem_align - 1,
>>> -				nf->nf_dio_read_offset_align - 1))) {
>>> -			/* Fallback to buffered IO */
>>> -			kiocb.ki_flags &= ~IOCB_DIRECT;
>>> -		}
>>> -
>>>  		host_err = vfs_iocb_iter_read(file, &kiocb, &iter);
>>>  	}
>>>  
>>
>> Hi Mike,
>>
>> In cases where the SQUASHME patch is this large, I usually drop the
>> patch (or series) in nfsd-testing and ask the contributor to rebase and
>> repost. This gets the new version of the patch properly archived on
>> lore, for one thing.
> 
> Yeah, make sense, I missed that iov_iter_is_aligned() was used early
> on in the series too, so I'll fixup further back.
>  
>> Before reposting, please do run checkpatch.pl on the series.
> 
> Will do, will also ensure bisect safe and that sparse is happy.

Thanks for the changes, sounds like the right path forward.


-- 
Chuck Lever

