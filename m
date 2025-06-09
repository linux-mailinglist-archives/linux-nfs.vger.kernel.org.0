Return-Path: <linux-nfs+bounces-12221-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD8E3AD2795
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Jun 2025 22:35:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD5583B1DE4
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Jun 2025 20:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 865C021D3EE;
	Mon,  9 Jun 2025 20:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WwTx7zQc";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Novrgwx7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23E11CF7AF
	for <linux-nfs@vger.kernel.org>; Mon,  9 Jun 2025 20:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749501312; cv=fail; b=RPNiAEn/Uvr+opfCqdbE7uCMUwDGDZz35tUr87dslBFfckVLjkLerPpgtYmnBhE6WpPuS8scR59f8QBRhVGPp+S5DvAoG1/vxaEM5TeFixEUDMgnpTYx5PW1X1sCGNLA98dMLQ+/7RltCtNGZDZ34+XKTeiLb5RYxuyhCCDYGJw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749501312; c=relaxed/simple;
	bh=SXtrenMt5AXZuVNAjis9g7FDB4Z4WDqrGtYTZRY2hRU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EQTOdZlhIHRavo5g1pSfzXKHP/SpU36ASCMiUNLtBi4usgEOETlmOOKEmoGTerns68870lMWfXJuN3/LgrIG9a0Ecqij4texVykHeoyQu7b0US6P2tkA2CUqQvR8EdqzWnWPjOHAbibAQ/xCctPhPSkXkaIuUTKSyOMc/X78lFs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WwTx7zQc; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Novrgwx7; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 559FUkaZ011098;
	Mon, 9 Jun 2025 20:35:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=P0gmUAuwDYI/8xUnKnoIg9W//oeNCE9P43cRyB/ViaM=; b=
	WwTx7zQco2R9Zfr9lIVClamARe1m/FhiDl3bfzXzOKPzOB94Ym3ROEfl0H0qnP6f
	XM2M8Vq8ORB2sMEPiSbFyMez8mSpt9kxotNSVtNQoEU6h+V5sCR8zYuMQSImu8Jt
	+n5YRmlam4hjw1d8hHTRuD6aD99sSPmQcj5t94YP63rLrUgcpityCks4P+T1YGUY
	LQQAQkUbUg7DWXHEq2dszQ5GXxKQ3yj69u5qHYyd/T06McfJ1HeWpSS8sHmXZJaF
	+TZ3oGOsRgrrFPWCjAFJJRCn8vWHhrZCF4+s2liAE8EfsAPfjyg8O21S5DjoKJWY
	o/Cn1LARKsvkdbDPvxxUJA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 474cbeaxt6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Jun 2025 20:35:08 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 559KV8VE021333;
	Mon, 9 Jun 2025 20:35:07 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2085.outbound.protection.outlook.com [40.107.93.85])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 474bv8m6sy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Jun 2025 20:35:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ymQ3kcjg5c7CTHtOLXmot+WG0i4m4OlWl7WLmGo5a1T8dWhdB6ZvMxv/9Hsc4qS2qKEifMZILWg9+y3hTFyZNwtZ97wUAYaEHXfgUAEAEzBLXviYgKy+6QdBKt6kPA+nhKQlxZbaMX+eOrpnzzi0cDl9gnkAwkZRvw1ivVRIhpnxAclrw/jLu15SjuNh//Nb9UUOM1ODUYt7XM+1EshEkT3wLyiiZIWUjmnIuc0UVF0pLLXAb/gDbm782Bi68aKDOA+iHvxsTtGJfcGxG8AqPFh9HsYANYknj45RxS6E6iWgUX4+fsROqbv2xxLwWpBuoByLXWgWnBoozSkj+nSxgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P0gmUAuwDYI/8xUnKnoIg9W//oeNCE9P43cRyB/ViaM=;
 b=faJaprTweQzTi68GGISQu8KKI6DFvob7mIlNsxIK2GrBKkKN20VqTNTiHTWNPYAuJ/BTr4zr7FqKX/SKtgdriW1fe7sr9XrJ4GTZfMjiNj6aCnuD2ZWDcq08sCEGv4qV+LBhxToNCi9whtSmGHL/E2MkydFSRq1LcCvM6Lenav1d0autXCDrU5H3ixQl+6CA0o/hJBvOaPY1Nl35QEX03naJvUBjRTSfLCIRSNSmMNj9Ds2NJOARHV5K57sXRPuHBybOiD8QhuPLIxcSmKZyRurd9bPNL24Fim3lwIuxCFsqhiE2GmzlWZcr/juCaDwghz3x2utMzEKKmSZHxw6YdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P0gmUAuwDYI/8xUnKnoIg9W//oeNCE9P43cRyB/ViaM=;
 b=Novrgwx7OWjOUwno6ei+hL2D5Onyp7y5GjwxeZ+eqNb4K7lx8FZMjQP95LwzpbNmZAfy8THpycCN67ZqdOR3wHC2jqhC6a3ND+fmjuqMGl3jsql65Lkjt9F8F0+k9tVDPB3r/H+Ntkdh4LT31uPrWWXdH9l9ciEFulbT2vUi5mA=
Received: from MW6PR10MB7639.namprd10.prod.outlook.com (2603:10b6:303:244::14)
 by BLAPR10MB5139.namprd10.prod.outlook.com (2603:10b6:208:307::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.25; Mon, 9 Jun
 2025 20:34:59 +0000
Received: from MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6]) by MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6%5]) with mapi id 15.20.8813.024; Mon, 9 Jun 2025
 20:34:58 +0000
Message-ID: <8268a648-81d4-48b3-a534-b65d7189ba0d@oracle.com>
Date: Mon, 9 Jun 2025 13:34:56 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: Questions Regarding Delegation Claim Behavior
To: Petro Pavlov <petro.pavlov@vastdata.com>,
        Chuck Lever <chuck.lever@oracle.com>
Cc: Roi Azarzar <roi.azarzar@vastdata.com>, linux-nfs@vger.kernel.org
References: <CAN5pLa6EU6nKe=qt+QijK1OMyt8JjHBC2VCk=NMMSA4SJmS4rg@mail.gmail.com>
 <2529724b-ad96-4b02-9d8e-647ef21eab03@oracle.com>
 <CAN5pLa4z-v9MSwZCxbW6oMy1Fa=b9GFEwmVxdDTnguO6_9-f_g@mail.gmail.com>
Content-Language: en-US
From: Dai Ngo <dai.ngo@oracle.com>
In-Reply-To: <CAN5pLa4z-v9MSwZCxbW6oMy1Fa=b9GFEwmVxdDTnguO6_9-f_g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0050.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::25) To MW6PR10MB7639.namprd10.prod.outlook.com
 (2603:10b6:303:244::14)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7639:EE_|BLAPR10MB5139:EE_
X-MS-Office365-Filtering-Correlation-Id: 392c93d5-64ea-46bf-5f1a-08dda79519b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NlI0djJ3WU5Hc3F1Zm9zRlFVY2Fuc2VnZjJMMWxlVzJsWEZpaXJZeS85WGxB?=
 =?utf-8?B?alRzOWtXZnVwU0hKbDFqMlFmZ0pldndYdnNleDMzQTZkZlF4TTRGRE04eG10?=
 =?utf-8?B?dU05Zys2cnY4cjg4Y1RkV3FjeGZ4UGhJRDRRVkxJVkVtVmhvNVgyRkhHMldE?=
 =?utf-8?B?bHNMVjlSa1pjemtIYWljbzZQRi9SQ2plZTBMWmRpR2pTRDZkWEdpZFF1WmFV?=
 =?utf-8?B?bEI5TU1lay8rQzhQVW9ySDNFNURPTkRodE40ajQwT0hEU0pmbHo1RWgvWFRx?=
 =?utf-8?B?cE1ld01HNVVCRE9lbjVOamhyK3EwNzYyTEFHU3MvblNUSytxZjY2dUVvUXdU?=
 =?utf-8?B?U09ObU5DSVM5N0ora3dhcmVmU0tKVGM1aGcrNkkrOUtxeTk5alVMQ2ZLUGtn?=
 =?utf-8?B?bC8zSzl5REFaMlhRY2RRaktqZCtMeDJocnRURWJaYjRqTUNNcEY2R2tIWXI4?=
 =?utf-8?B?ZXBaejFmTDcwMVY3K0pOQUpsanZnbW9hYUh2MEc4aGFaWnZZUzRFcWtSeWpm?=
 =?utf-8?B?NG5zSHBLaHg0WkVEUXNEN1JEWGorRG9FT3o5bEYvbXZJbFd1U3FkWXRxRzlS?=
 =?utf-8?B?cHcybXVMcWM5OHhreUtNN0xlNVVuZDJBRVpQaUxJZW41eWI1RW1FRUhpUjhV?=
 =?utf-8?B?OE5IRjFzVHNSS0s5VHVBRzBZMGc5SEJ1ajJRN2tnczh0S3UwVEhpd1hNQzg2?=
 =?utf-8?B?d3hIbW5lWXUvbUFXSFdjTDg2aUY5R2kvcXVjSDhlQm9tOW9TZ09wYXNKNnY0?=
 =?utf-8?B?OE1ZQ2hjeTVXdG0yWHlDWXlPQjRFYkFGMHphZCtjVm9CTC8zT2NZTzh1ZktW?=
 =?utf-8?B?YkJ3UHN2MHNVU2YxajltTkhNVWdoRWJrY090eC96T3haWHVNTUtVMmVMcEhy?=
 =?utf-8?B?MFlFOWhZUkpGL3F4ZjhzcjBEZ000ZTRabGVVRWtKQ2ZIUmlFSzJRN1Jma0lj?=
 =?utf-8?B?ei9YWjhyZWVidk42VUwxNFdnNUg1V3l6c2pncTZvcmQ3eGptRXZjaklVLzlX?=
 =?utf-8?B?MksxOVFUdUFhWml3cEVpYTh1cWxqaXhHVjY4ZU5MMXJ4SFlCclRuU2MzL0V6?=
 =?utf-8?B?N1hoT0JRTkZldlhweGFUdG51cnd0TXpoUk5BYVF3cVFlVVpmczZPK3NoSi9x?=
 =?utf-8?B?ZUdaQkhJS04zeUMxblpvSTNLWHJ2NkdjWFpsV3Z4ZnBMOUlFSDN6NjVrTFc5?=
 =?utf-8?B?aVhmRCtIditiWFBsUTZkWEZSb3ZjNGlYZkkwOHFnNlNoVnhpUkp1eEV0NnRm?=
 =?utf-8?B?anJZWXpVOGNCYkkzL1pvcU9ZTHJaOWVETDZjNHZlOUlvVzJKaWhUZGk2Vmhn?=
 =?utf-8?B?MGJOYis0eGgwOTNsZVVaL3BNWEhxRzR5ZzNhMDErS3V4dnNYaDVGU1VXd2xl?=
 =?utf-8?B?bmkvN0lDeDJ6SXJQdHpHSm5OaHlBMEQwT0lMVS9vVEptbDlnR2Z5aUxjMm11?=
 =?utf-8?B?eElvVGtKYlBMdmQrT0M5aFlaMlVmK3FHaXBZV2JlM3ppSkZyYTBwOUtYd1JU?=
 =?utf-8?B?RXpYSGRCVTB1UitDa0pGM3hiZzcraCtHK3A1YWg3am5jem1oNEFWL2xoVFg0?=
 =?utf-8?B?ZzdXZWFocUppaE5vWlFieGhVMWdDYzFZRWRTVVdRYWVrd2hFd3QvMW1UWTU5?=
 =?utf-8?B?ZDBSZ1kxSU55ejZSTFBiT2lCaW8wY3MyUnVhUFF5b3FxWGNXWnh0eXlqcmls?=
 =?utf-8?B?Y2xXdkhvZkxLb3ZMYzhNVzlZeDZVVmxOaVlQamh4MVNQaG15cTJRbEtrM3RE?=
 =?utf-8?B?dWpYekxtcDNKNXFSc3c1eVJmRTVjOGNpd2dKMTFxZEorZ1c5dURGWlpyYml5?=
 =?utf-8?B?ZmpvZmJVcitYR1o4SWpnR2JLdkhRR1YzZE0wSVdEYkRJcXdnMSs5VGNkS1lI?=
 =?utf-8?B?emI3d0lyZG5uN1JhNmxYU05wMEZBMlNzUnlhS0JrbC9rc1QxcWMrcUxSaWIr?=
 =?utf-8?Q?j3teEY9tIeA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7639.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b0xKOUcwWjVPd0pHL1FVRHhPZU95dit6bFhQMytRRzBrOEF1aWNVdXNrZlk4?=
 =?utf-8?B?b0JuZ2VBWjRtN3NUT3g3aFZRbHNocFc4Q0NRRUJxRHNSbEpWcjNkemdlc1RH?=
 =?utf-8?B?aHJZMGNLOVZXeGRGVTlPYVZNN3F0VFJMazNJZi8yZ0hUWEJCKzFrajQySGhY?=
 =?utf-8?B?dG1sRUhYMHZJTm5zMERLVGk3dWp4S1hoOXJ1aGFNQW5ZcEpNTGJtRjBSeEpR?=
 =?utf-8?B?bUtwTGNPeWVZM0Q1a1BOeUo1OElFTlo0Vno3YlpHOXFHdU5CZEMxLzljRXBP?=
 =?utf-8?B?OGNsTEtob3RELy9ZU3kxZms1dWhKTGFDOVBMMmErd2FtMmlCVTBrTXBRU3F0?=
 =?utf-8?B?bnNDZUxEU2d4WHRBVWVOUnA4WkI3RWw1YWpLaHJISmxqUktmeTFrVkFSZXJS?=
 =?utf-8?B?M0hDQjJtdy9CTGdzQUVwMWg3TlBuTlQ5N2ExczdjalBDNklDS0wrZm5pOWlZ?=
 =?utf-8?B?cDg3dXNCRlJUMEx1UXFlQlZMMVJpYkhpZzNqcStDQVhLQTlvQ25zUkZIWkxj?=
 =?utf-8?B?QnAyWTFvTFJFQWY4bTB6L2FYR3kxYU0raVFvd0dsV0E1QThsRlBkQVlveDFv?=
 =?utf-8?B?dUg5dVV6YVV0RUlzemlTaUEySnZhWHhxOGJhOW0zNXhnVHMraWNJZ21KcnZV?=
 =?utf-8?B?dVZjYk5tOG12WnFFQ0FPTHpnWXR6Q2gvVFdsV0l0aVg1dVcvbGpqTElBa04r?=
 =?utf-8?B?T3ZRT1ZxYkQxbXVpcEtkVllrZ0Z5NjJRMThaNTdkd3ZxNkdVQW93ZDVjMlpq?=
 =?utf-8?B?Z2ZEcWVHU2hTem11NjA4VGtISFRYb1hXUzJLL2RwT1hkZ2ViODRkWDIydU40?=
 =?utf-8?B?NGdGOTJQS0g1Ymk0a2ZTV05SVXZXS1pxQVU5UFlCRHNWRGMxWWNFVDFVTHgr?=
 =?utf-8?B?UjZjb1pjV3h5WkJ1VXBJQll0bFVzbW1mZ3NRVEc2UnBEWDdoVExQYnZSdlpr?=
 =?utf-8?B?QnBiTDN2Nzcza2VvcnJiTGkyNlQ4dUhsRjVkSnZKSERNd2E2SDZ1a09mb0U3?=
 =?utf-8?B?ZEk5RjhWVGt3RUlJb0JZOXBrZlI3cEphdlJ3a2FVL1VZZlloaVZjU2NYTmla?=
 =?utf-8?B?SFFJN3lYc2ZEQ0lNVVRSVitaTmlBTmQvSnhId1VvVHpqak5UelB1RzRJU1Qx?=
 =?utf-8?B?UmpMZExyZTBoL3ZLQmVBb2s0Zk5nWnZ3cW15WUQyQVFaVVlzTWIrclVlclNh?=
 =?utf-8?B?TG43SnZXTXN0YkR6Y2tkYjhBdVI3eUk0b0ZrQWNTTmp1Y1drRlZFNXBSZllB?=
 =?utf-8?B?Q1UyWC9SbW95R2U0bWEvZkp1bTdzSWJBTjYyYzZCNDdMdkFnVGRkd0RtbHpx?=
 =?utf-8?B?ZG92WTN4WVVzeXd2bFk2MkNPR3owK0ttRnE0cXo4K1paZjhHNmRCK1MwbkhX?=
 =?utf-8?B?QnZ1Rll0ZVR6RktxcmNROG9SQ2x0RVNQenJzdEJ0bi9paEwzZ3Q4Q0x5TUlO?=
 =?utf-8?B?UkpMLzQzay9PbkJBVjNPZmU4dzNCQ0VrT3hCZEFPYmtHbVU2YW5hTExFNjN2?=
 =?utf-8?B?cVpaNG9ER3M2RVpvN1IrMGp1eEwwZG00STZLdUg5RmQvK3dJeGMzSDhRcHFt?=
 =?utf-8?B?WVVCdHVIb1BGRDJGbEQ0RElUeGNReHdUSVFmVjZGM0pFcWM0UUR6NERQY0o1?=
 =?utf-8?B?VldINW5FWjdyZlpqUW92YTVleTFlODVJUTUvWm1YeStNQkQyTGdNb3htaHFa?=
 =?utf-8?B?OXdwdjZCeDlOZWwzMTJHNkNOZVhuODVURTZ5RnZxS0RTdnNIWGN1UFZVRklq?=
 =?utf-8?B?Z0lVU3BsVnRVK3BEeUZrYXNQUHlYSi8vUlExVHE5N1dRdi95Uk1wN3BYNUh6?=
 =?utf-8?B?bmt3UFRxUW40SDNoWGUrNm1WeHpTcU9oRFJUOXR6YzNzYmVUbksyOUh2cmFT?=
 =?utf-8?B?cXJhOVZuTTZtRkF3bUs0QjBjQXdjWHFPNllZTS9KenhFVmJoa0RVT1JNZVZq?=
 =?utf-8?B?VmYzdzRGVkJxS0xPa2ZmYUhwQmphWS9zZE9OUTNTcDQ5RGpFU1Mvb1RMKzdJ?=
 =?utf-8?B?QU9SMnhDVVoxV3RzSGJhMFBBaDJ3YXQ1dTIwalNMZjNRUkdURjVaWHd6Rk9o?=
 =?utf-8?B?ZHBJTTlUaDRPTUsvdjYwRWlTbkZ5TlpjbW9LVlNmK0p4cHVxNWVtenVkYnZ2?=
 =?utf-8?Q?dFxkFIhxMS+uhHWJsDnc+bOHG?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	dDlA7x5lQmeqs7JnI8Fu31LIlB3adUyjzXOizDM803GGyI+Zowz47qtyH3mT3Y2f5SJpU874xQcAtlu27Jp5OPyQeZN9GbtM7OyZFgwfkrHQtpu82fgD8p9LTzsByXgOq253MGqkZRGu3iex+F7f0U2q44ZQbFuYwrgZBEizPPhtykdvWYfj+FbuIBWPEQrtKPm+QRIVKnFgfC7DaHAf2WrPB+SGB/jmKz+FbSa68N6IN7w/C8HGEuiaVt598ndhRQPb2usgGiFYFVyeyB7EoQ0RvkgSzH+CStigtGAgM7KOiLxLxbeTnUt/rbvRtEOYFtww66eZuyiicoHvwbMFOIN1eilld/ppz3SH5JgEB5XVcUkB9LasrpQJaTxPLVxqmJiN0nqtnzLBiB3puHbEUTAHudgLVQ6dV4VDHapXRPvLIx10Alj9PuIYVWRZdmqYeQ8wlLzeFMQmCHPTTKhV6oQ90qzGZs7KEcLKPx+kRwM+2t9vkQeOSoH/vgd6D96PehzjszzYFrmG/Emp1lh2orsCY4BoFrCk6zDA72EmBNHpjXcGRKrqk/fpPisS+z817ajkixkfsuJKpuADTXYCbqxpzWDa+6u7pidaq8A+IRY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 392c93d5-64ea-46bf-5f1a-08dda79519b7
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7639.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 20:34:58.1987
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9G4YqwMTfG3GjN8+DENxMPRWn34lec2ph2zoPOUtW+jOD5Hhqs+HutNvd1IGShHZjcERskCFQV5Gm1IwBYWPJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5139
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-09_08,2025-06-09_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 malwarescore=0 suspectscore=0 spamscore=0 phishscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506090157
X-Proofpoint-GUID: gmvhhb_FiViDaGiDkWNdCtRf9SGot49U
X-Authority-Analysis: v=2.4 cv=BffY0qt2 c=1 sm=1 tr=0 ts=6847457c b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=Rwk37Bbg8_We0JvQVcYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13206
X-Proofpoint-ORIG-GUID: gmvhhb_FiViDaGiDkWNdCtRf9SGot49U
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA5MDE1NyBTYWx0ZWRfXybGPD6mqFiDM +Wwo4un4hJ1qqSXvGzvctdBFt3i18Q6YNPbyWqiIpc/agEXKKIMZEklcib9uCZ2BfRzFJrV60tu djeFnbLo29B3Al9gN/GIuP2XWtvrrpV/IpneqWcynW+FnLHWZL+gYVBa2QpRtnC0KUzH9JCVyjQ
 Iq5N62oK1MenmRRtYxE/12yvbBc9m+dtGK9UL29THuxsVqmw982rKqQrWM91g1Ij3xCsKE0LxUP tupEJriuqrq/66RtqPsKafZsMonKTBKY9Wgf6k4bslMbQo9t4hQydZloSp3cfyTDA3FJQ53p+zV hnASz1PvZh6lEHozC9Ds8SUEInhc7a69RQZB2HZPQWTyvlt0cmTQEkwKbWMWsbj7kcUsycjAfiw
 zndX+rH10Pj8lsQFG+nLskSkO0FqYLur7CfAfSUQnChOKdCO8UgCt7nRKULZydvafJg7LVkC


On 5/26/25 4:10 AM, Petro Pavlov wrote:
>
> Hello Chuck,
>
> Thank you for your response, and apologies for the confusion regarding 
> the kernel version — the correct version is 6.15.0-rc3+ (I believe 
> it's from the branch you gave us). Regarding the client, I'm using 
> hand-written tests based on pynfs.
>
> I believe the following section of the RFC may be relevant to the use 
> of a delegation |stateid| in relation to the file being accessed:
>
>     If the stateid type is not valid for the context in which the
>     stateid appears, return NFS4ERR_BAD_STATEID. Note that a stateid
>     may be valid in general, as would be reported by the TEST_STATEID
>     operation, but be invalid for a particular operation, as, for
>     example, when a stateid that doesn't represent byte-range locks is
>     passed to the non-from_open case of LOCK or to LOCKU, or when a
>     stateid that does not represent an open is passed to CLOSE or
>     OPEN_DOWNGRADE. In such cases, the server MUST return
>     NFS4ERR_BAD_STATEID.
>
>
> I did some further investigation and identified another scenario that 
> seems problematic:
>
> 1.
>
>     *Client1* creates |file1| without a delegation, with read-write
>     access. It writes some data, changes the file mode to |444|, and
>     then closes the file.
>
> 2.
>
>     *Client2* opens |file1| with read access, receives a read
>     delegation (|deleg1|), and closes the file without returning the
>     delegation.
>
> 3.
>
>     *Client2* then creates |file2| with read-write access, receives a
>     write delegation (|deleg2|), and leaves the file open (delegation
>     is not returned).
>
> 4.
>
>     *Client2* tries to open |file1| with write access and receives an
>     |ACCESS_DENIED| error (expected).
>
> 5.
>
>     Next, *Client2* attempts to open |file1|  with *write *access
>     using CLAIM_DELEGATE_CUR, providing the stateid from deleg2 
>     (which was issued for |file2|) — unexpectedly, the operation succeeds.
>
I think the server should detect that the delegation stateid and the file
component do not belong to the same file and returns NFS4ERR_BAD_STATEID.

This will also prevent the subsequent access check problem.

-Dai

> 1.
>
>
> 2.
>
>     *Client2* proceeds to write to |file1|, and it also succeeds —
>     despite the file being set to |444|, where no write access should
>     be allowed.
>
> This behavior seems incorrect, as I would expect the write operation 
> to fail due to file permissions.
>
> Please see the attached PCAP file for reference.
>
> Best regards,
> Petro Pavlov
>
>
> On Fri, May 23, 2025 at 5:41 PM Chuck Lever <chuck.lever@oracle.com> 
> wrote:
>
>     On 5/22/25 11:51 AM, Petro Pavlov wrote:
>     > Hello,
>     >
>     > My name is Petro Pavlov, I'm a developer at VAST.
>     >
>     > I have a few questions about the delegation claim behavior
>     observed in
>     > the Linux kernel version 3.10.0-1160.118.1.el7.x86_64.
>     >
>     > I’ve written the following test case:
>     >
>     >  1. Client1 opens *file1* with a write delegation; the server grants
>     >     both the open and delegation (*delegation1*).
>
>     Since you mention a write delegation, I'll assume you are using Linux
>     as an NFS client, and the server is not Linux, since that kernel
>     version
>     does not implement server-side write delegation.
>
>
>     >  2. Client1 closes the open but does not return the delegation.
>     >  3. Client2 opens *file2* and also receives a write delegation
>     >     (*delegation2*).
>     >  4. Client1 then issues an open request with CLAIM_DELEGATE_CUR,
>     >     providing the filename from step 3 *(file2*), but using the
>     >     delegation stateid from step 1 (*delegation1*).
>
>     Would that be a client bug?
>
>
>     >  5. The server begins a recall of *delegation2*, treating the
>     request in
>     >     step 4 as a normal open rather than returning a BAD_STATEID
>     error.
>
>     That seems OK to me. The server has correctly noticed that the
>     client is opening file2, and delegation2 is associated with a
>     previous open of file2.
>
>     A better place to seek an authoritative answer might be RFC 8881.
>
>     The server returns BAD_STATEID if the stateid doesn't pass various
>     checks as outlined in Section 8.2. I don't see any text requiring the
>     server to report BAD_STATEID if delegate_stateid does not match the
>     component4 on a DELEGATE_CUR OPEN -- in fact, Table 19 says that
>     DELEGATE_CUR considers only the current file handle (the parent
>     directory) and the component4 argument.
>
>
>     > My understanding is that the server should have verified whether the
>     > delegation stateid provided actually belongs to the file being
>     opened.
>     > Since it does not, I expected the server to return a BAD_STATEID
>     error
>     > instead of proceeding with a standard open.
>     >
>     > From additional tests, it seems the server only checks whether the
>     > delegation stateid is valid (i.e., whether it was ever granted), but
>     > does not verify that it is associated with the correct file or
>     client.
>     > Please see the attached PCAP for reference.
>     >
>     > Questions:
>     >
>     > Is this behavior considered a bug?
>     >
>     > Are there any known plans to address or fix this issue in future
>     kernel
>     > versions?
>
>     AFAICT at the moment, NOTABUG
>
>
>     -- 
>     Chuck Lever
>

