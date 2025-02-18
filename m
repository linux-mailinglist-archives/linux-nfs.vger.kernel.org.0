Return-Path: <linux-nfs+bounces-10167-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65FFAA3A0C7
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Feb 2025 16:07:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FCD21627F7
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Feb 2025 15:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D89D6269AF4;
	Tue, 18 Feb 2025 15:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eJ/mwqZT";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="S6Gzq3bG"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8E8238D3B;
	Tue, 18 Feb 2025 15:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739891275; cv=fail; b=R9Tg8afbcEdxxnVpaZ8nUxLmDWEsrbUWkKnVy19o4nqA73J0R//DDzfk2SXaBSVUc+izDAbZXfxqjxMy9bIIBGqwekHn4LEm0Fo88KWt1+vPZGrwnVVGfDca1OGgTzP/iN00LsLAzbTbP3oRowyzmqbSyHfhA108pVIcoRLjBFk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739891275; c=relaxed/simple;
	bh=o+7Pt5Y6W6UG5yhEyWXzrjsl+jJyQyiigCKA7PuGNgs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=P6uaQoKd9omzHLs/aT92kr57VyASjTwmG7RaLzh0TXQ2BFDJz9k/27fY3Tw2+aAmaa3+Hy2zMZcOJqDz0X8NvUE+JZTGC2ISapSHXsDVceY+D0kqNbt7M0gxhan6MmLZXnOjfSksVOwruXKwKXEuc8D3/d27HB8K+9jly74aih0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eJ/mwqZT; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=S6Gzq3bG; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51IEHnX7010799;
	Tue, 18 Feb 2025 15:02:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=U7qiiaalgZBLYvQTqrRUzBwq4E+NjMUigH3B8yjmPAU=; b=
	eJ/mwqZTMSdOKi4exVJjo17hekttq104B7vbRs22gr1CNbFELmfoVwWmeepwJ/lB
	7THIpnRQl6SjaLsFsL2+80/C3wcjUTLIq/1qxTcGjst7pgYvtDyvycYPXM+N2tvw
	YMjUODqHBNoDwfL/0sRaZ5ziua0DZg0TjFNHDV1VJ3T43rB7T0M/t4k6A+Ffx0Qf
	PD+KAPE0AcmVoyAvuKmXw11xGjseS8wrkmC6eXe1V59jz1sjHneDP3LdF6tTBLd/
	7kGVPJPnZZ4/V+hI9mTywn8ha8jhs465KYEkLKvztuV06+D44eNubiDIZZ/d58IK
	44w21Ntk/+swbGbwCn9ySA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44tjyby0q5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Feb 2025 15:02:25 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51IDsHPu038701;
	Tue, 18 Feb 2025 15:02:24 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44thc94ycr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Feb 2025 15:02:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F/gm42vM27yEEWKnlUw/AluOcnenSam2TAK5bjgatNunh2YYASULb42m6hTHTxBCHv2NXI6YQbqqEx8BrRaKgNEiEvFQ5IzKkCXAMqwPWE9P+g4MdMuyzpZPQx9JmkyPgSObVUnFfpNy+5hWc6cnsUX+V+m22FXiZ9pnK1vt0gQ3aRclG+SNGuwbkgmZmV73QocRRtkDgp9uqsyZWwBvxmqyECWNxc/zNsoCGZoLMiGsu7xotH1UOajovR3m6ymuJC3IYx9hDWKjgHmYRaqWeFAyYMrs1Gra9Gwwx+7LmGc2pQWFuQkRKM/CtfkCCU5/+f+AaSRa5yTKAs1fHtzhwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U7qiiaalgZBLYvQTqrRUzBwq4E+NjMUigH3B8yjmPAU=;
 b=I3FKhFCNI61WjqZ814JlUi7NNG4mmTcG8KJb2via8X7ylX4Kd3sZfLxhgSMdUfFFwvfHdzteiCLbFuvUDYA1cGEV1wLQZUAtQUQEaXs6RKqQDDiL91AXnpvcVcSeiSAt6E2aBqn127sBoBCmX8MYGKPM2XJwGFVlyQKSdfnpAr/5Rqe5dM4oc5A24lXJJ4kf2iR4m5Mh/2T4tj7dFcumeT5aluYnJatgEXK7p1N85+x9bYLGDcaQeHCPOWOiH9nHs9r2uFqTHnu+YegBki/DLo15+lQYStqqNjF7beRVogAxB6yH+E6L/CXWTB4soAxOmNaHM1/mnZRgpU+XPEj5qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U7qiiaalgZBLYvQTqrRUzBwq4E+NjMUigH3B8yjmPAU=;
 b=S6Gzq3bGBXOQfb525Tij7/ymrBeimoO95OjiLj/YvQXajDM4dNUsKFZHYyl0qMkpp9AtdXbmk91CHfjNQ5Mur0OqqDLaT/eTRFNB4VcyObxnV9GuWdD+qQY+m5mD6WZkLHXB24kSiGdMXy7ExpaD9Valije7+BrAwOMGh1YMmq4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH2PR10MB4328.namprd10.prod.outlook.com (2603:10b6:610:7e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Tue, 18 Feb
 2025 15:02:21 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.8445.017; Tue, 18 Feb 2025
 15:02:21 +0000
Message-ID: <7bbc3bf5-f364-47bb-8a3a-5b4e38fec910@oracle.com>
Date: Tue, 18 Feb 2025 10:02:19 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nfsd: decrease cl_cb_inflight if fail to queue cb_work
To: Jeff Layton <jlayton@kernel.org>, Li Lingfeng <lilingfeng3@huawei.com>,
        neilb@suse.de, okorniev@redhat.com, Dai.Ngo@oracle.com, tom@talpey.com,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: yukuai1@huaweicloud.com, houtao1@huawei.com, yi.zhang@huawei.com,
        yangerkun@huawei.com, lilingfeng@huaweicloud.com
References: <20250218135423.1487309-1-lilingfeng3@huawei.com>
 <0ae8a05272c2eb8a503102788341e1d9c49109dd.camel@kernel.org>
 <04ed0c70b85a1e8b66c25b9ad4d0aa4c2fb91198.camel@kernel.org>
 <9cea3133-d17c-48c5-8eb9-265fbfc5708b@oracle.com>
 <8afc09d0728c4b71397d6b055dc86ab12310c297.camel@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <8afc09d0728c4b71397d6b055dc86ab12310c297.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0215.namprd03.prod.outlook.com
 (2603:10b6:610:e7::10) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH2PR10MB4328:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d74b6d7-2e7a-4dfa-0b33-08dd502d3e81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?czZYQkRDZnYxb3NQSEJCdG1PQm5lanlLK29ZeDBTOWl1V1drNkROazBURmU0?=
 =?utf-8?B?QllQbVRMbUFBRXF0V1ptNWlJcTUyOHRoTjZKVEpXYXIrQjRPOUxONXdyNGsx?=
 =?utf-8?B?QmZ3UlpaQ0xobUcwdjgzUk1EdGgwRXNjSitlU09oYWdSZFpKTkZBS09jTFc5?=
 =?utf-8?B?c1lGY05oTkZxaTEwdGJudk01VUo0RXZCSDd5bHRCbVhYZW4yUFVHaklzYUl3?=
 =?utf-8?B?WXJtS25oaDIwM0R3NWIrQklOcUdZQ0hueXk3a1pya3VpRTkvKytuWmkwTVN6?=
 =?utf-8?B?ZGkzOEtlbWo5bkd2MWR0MVI4SFVIOGYrVkhMc3VkN2hIN08yWFFGc2FtMzRa?=
 =?utf-8?B?MnJjSG0wRGhham1ta056Mm1LZjBVRVA3ditYNFJ5QzFVR0ZkcHVFUjUraEkw?=
 =?utf-8?B?Tzlkc2JJOU5BbzhPQ3kwNEIwRVgxbHFpdkhwZ3JrTjNpTk50UzJjQ1RkUnI4?=
 =?utf-8?B?S1RuaFlFaGNudmpZUkZzM2xha1NYYkRpdmpwZ0pNQkViN3AvUXNhdGFoWm5L?=
 =?utf-8?B?TW53MnBhUXZLRm5KZmEzWDlrMVhaWENCVU5qc25sLzZ3UWl3c05pUzVqZXkr?=
 =?utf-8?B?eGsraUlJYXJOSmltckRxdDFLUUw3NnYxZUcvbXpBQ2cvNDBJT0RNYUcvS3Aw?=
 =?utf-8?B?Rm5NdjVwOUJUTWtaRHpOdUxvUzJBc2tWWlZwQmRFeEg2SUtmL3YwUHRGQW5B?=
 =?utf-8?B?Z25BSjAralZYMHR0WkpySUVlMUVzZEg4cFhHNmFYOHVWUFJWMlg4NVlJSHhj?=
 =?utf-8?B?N0g1U2trazhoSk5OcVZlcmNmRHBSTzg4WjdvRWhJWE1zSGJFblhJeXltdjVl?=
 =?utf-8?B?TXJlZ3R5aCtoSzZpcjdYMlpwN2J3UEFobXZBZVY3TVdUanhvSXpyaHVvQ1hi?=
 =?utf-8?B?TFZKdTZOejdFbmorWjRyNEE3WHozYUsyalF2RzAvcFdzZStSeFhWazFDQ1VM?=
 =?utf-8?B?MEZUTE94cUlBdm5PcnF2TVpzV1htRXo2QmYvbEkxQXUxNUZ1TVgzbWh2WXh4?=
 =?utf-8?B?MzAwUmpqb1A4ODR4U253TWJodnFtTzY1ZnZIamFYYjRpSzFVNkZNckVUeXpU?=
 =?utf-8?B?U1hlanJRMHlCcjRveGVZZVNiMHlSNUhsbEdwUHU0bHgrR1k5SjhNWTVOUE1D?=
 =?utf-8?B?MWc2cCt2T09zdU1GVUIyRUVpd3E3aVdzajU0aXZaNWhTZVE4clBBRHhZUURs?=
 =?utf-8?B?YmV5M09TRkRUamVUZG9COUNnSkN6L0c5S0NudG9ONkFtWCs4SjFDaWpkbjRo?=
 =?utf-8?B?UHpLTXZWY0cxZlAwVlMrb3d5OFVKZ05DSThEd01ROG5udjczVUQrN1ZQaUZN?=
 =?utf-8?B?Z1NmOUdlZ1V6UEU0WnpaTFhJMlNSNUgxazNsTitKYWp3aG1xU0V2OWg3NE4w?=
 =?utf-8?B?ZmZyNUJSNkxLUUhvQk9vM2lsR3h1OHlPdktPZUg0MWtQRFlER1NqbkloajRv?=
 =?utf-8?B?bCt6WW1UdjdMVEdrL0RqR055UmlRWER4TjBFRGJxYzJ2aEFvK1RqQXNZS0tM?=
 =?utf-8?B?WEV2OVg0MHFVN09ISGJIZW5ub21hVG95ZjU3dzJuWmREaWk5U0Z3UVZ5WGIw?=
 =?utf-8?B?cXFqb1AxT3ZoNmJvYVd0K29QM0dWUUVGdC9lV05PN0l6K2V6ek11MkNEUmlp?=
 =?utf-8?B?OEl5ZmxRYWNLT1QyS0VDaE5DeXZxVU4wZDRjTkRHUktPYnBMUm8vb2wwOFlo?=
 =?utf-8?B?WGJEbnJVNXdINXgrWGlhNzd0Ni8xT3RmRTJiVlU1cjBpeWkrTXZNQUpmTXIr?=
 =?utf-8?B?YVBBOG1wUE1HMlgvTy9yMjM1Q1hnYnM2bEpvc2MwR0VMandGUlVLbzRPQVMw?=
 =?utf-8?B?MFVGNE80elZSQUNVY09xTW5ONGdmMlJVMC9qTUxyUTJycW1iRUY5YjRVSjlM?=
 =?utf-8?Q?K6DUe0tuCsfaE?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cm9XWnpDM2s1TmV5aTlOcVJCdnRBZVBkV3FtZUV6YkFyVC9hNGZPVWJiN0dn?=
 =?utf-8?B?S01pS1hvNjFwM1NWb2pSRnp1d0tES1lveXptRDBESzFRQm12NkF2eksxcHIr?=
 =?utf-8?B?UnlWNFdoN1YzZkZHZ2QrQnB1NXBvTUZERjZsTVRzSlBqUGlHSnhaSk9SSEZF?=
 =?utf-8?B?T2pKL2xSQjR3Szh2TW00ODZ2MXp2R1k5ZVNsMEVtK1N0bnFuaVFWVTBJci80?=
 =?utf-8?B?dU0wMmZSbFdKQ1RxaEpuTHYyd3FNV3FzaWRzMjVZY0c2dWk1STZrZnM1d1JH?=
 =?utf-8?B?MFNvQ0pJckNHMEl5bEdjNVVyM1hWcG83VnRwQStkVHVlT1hnd3EyRFFiUXZX?=
 =?utf-8?B?ekJoUUFSbGxoTmx2TU0zU1EzRmhyRSsxYVBUWDlBUEVqNXNpdk9ydUl5R0Y0?=
 =?utf-8?B?ekVBeEdCSEZGQXpoVncwa1B3dmV2T0dBT1VmKzdFbm1JRzdPOW5Iald5UjhM?=
 =?utf-8?B?eUV4RU0xbU5UNDN3WXFBWjBPS3hYeUVRd3BXbFg3RG84NE9MUURSMVUxOXZ1?=
 =?utf-8?B?b1hhbmxYaDllMERmdHhLekRuSC8wK011bTNZbTJ4eHhhRjhIVFFya0VTYysr?=
 =?utf-8?B?NTlZWWt1eW4rTGdQUFRaNThVanhSZ2RZbllIZTFnNDdrTm1kZE54VzJuNlpq?=
 =?utf-8?B?SUxqdDNBMEltd2Q1cXEwOEovbTdWd3FJRHZLK212bHU5YkNteURiWkp3TE5T?=
 =?utf-8?B?YXB3eWR6Y1ZKRzhBWmVwbzN2UWZrMWY0ZGR3TkpuT3ZkWFNKS0kybFgrKzdZ?=
 =?utf-8?B?SFNZZ0tZQm0vZUNrYk5nN200Y2JwdWpFcDdOc1N4MVJianR6Q21obUE0Sml0?=
 =?utf-8?B?cWZabGJDRFNEei9WME5TdnYxMWVpZ01mTWVKQTRJcGxLVis0Uk9YSFNXck5K?=
 =?utf-8?B?dXlsMWszV2FXZnczWXJEZmN3TVpIV25QYTBwVDJlWXE0VS8wSU9mNGRTTkww?=
 =?utf-8?B?bnRrMThZcHl6OGNjQVVEY3AxR0dyRmgyOXNYdVl6WGtRc1RSSVBMNXI5QTdW?=
 =?utf-8?B?QmkxME8zYW1wQkRsc25BdGxudjdnOG5uMFllV05PNUwyeXVGY3NjcUk3cHNJ?=
 =?utf-8?B?cEUzZHhYLzd0NGJ0WmNWNG1Xb0xoeXFIR3dEM2FtSEx4N0k1MnQzL01vb3FM?=
 =?utf-8?B?VFhidy9hc0dXTnhONzN6WFBVZzdwek55Zk1vbkgzOEUxcnl1UThOOWx2SS9s?=
 =?utf-8?B?UjNvc0pNK3R1T2wwcmx3WWFqZE01SlkxaCtYVjJCRGY0SmRDeGJIYzNiemlv?=
 =?utf-8?B?bHRSUW5VM2tNM1FyV0FTS29ONFZMOTBna2c5SHlLT1l1UjNCeUVNQmVwOTRx?=
 =?utf-8?B?alFta3c1LytpRDVrK0ZhVFd6QkxZZ2ZMdU41MjBlU0RLeGN0eUM3U1pxMXhE?=
 =?utf-8?B?TTNnMTFvZUJVSEkwMEJZR2tmTm1sQ042K25PTk5xNGMxakFkdVlGbTNCcWZP?=
 =?utf-8?B?WkFYaXlxdzRZbWpSZjI0elpLTmhjTG50UXF5MlROR3p5cmlyT2tMNTVEUHVa?=
 =?utf-8?B?Z04wcUYvYUVHVjR2VUk0bEkwUnNrMzdpclJIRzBhTUVyVTBKNUpza1Q1bWdS?=
 =?utf-8?B?MWtMUjk4QzN2NW5ML0x2UFZESEQ5dHpOMmE1VTlMdUpXK3BFV05ySWQ2ZXhH?=
 =?utf-8?B?MnJNbHhWZVJKQUdycEozNTRicDVjSkJtblVyZUVxN2xwL3FiYmYwWkJLN3Nm?=
 =?utf-8?B?dTVlcHYzczFZTXczb1ZoNG5LOFErNnRCZUNMV1piM0c4aGdnYzlNZ0E3RnQ1?=
 =?utf-8?B?TnFqSU0rUUVuNGhia2NPVzRFOThTeE41U1NGLzdGcjc4dzZVVTFxRy9OeUlP?=
 =?utf-8?B?dmxVaDBsVnJrcmwzVWU4V1liVWVENlhaM3VVQkNrT3E0ZS96aVUzeCsrbThO?=
 =?utf-8?B?ZTRNcGdXR3ZTNTBOKzNEdnA5KzM0c05MLzlObFBudlhZNE11dkZkMDQ3ZkZK?=
 =?utf-8?B?TVJzQmJrTG5ocmlsazRBbjJwbTVJSHg3SjgwMVRYVmM1K3lyYWpPZmdqdUdi?=
 =?utf-8?B?N2hLZTBWdVNFWWlhY1JxVzBFWDNNc3dmVGo5MHB5a2hycGdzL0FQcmVadXpQ?=
 =?utf-8?B?L2h0VTZhOXpwMk1Lb2laWmhrclBmM1lGcURRcnBLZEVaR3RaaUxjNWEwVUcx?=
 =?utf-8?Q?ohbZMBu3ElIiwobSGX7b00odk?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ObhSTwrUON554tRrPsSAisS8vKGxUXIbHCogrdHEWQLCL/D+dwyL7jLLZpLkNcYYTDYxfZ1HpA3XGQ9hL78kYnlZphKaWziDm+DX8XKoLxmiNe+FZw0eIx69v3HwU9IwzU9mupSayvXMuK2EqxEOrg+2F2bvBOMKtiDFHd9uTHCdIkai7Hl8wF3W9ut9kCuckKFzm0j7dJJQlLirsbKpWjAdXpFcDFQOCVAwpOa7CdpSc1p+ncv+WksIw6Yp25GkeCa8HL3hQhsNVt306IEld2Ncaf0R9tuwqt1malkUsK3j4iBqmUTm1knwY0ZIgWC2+/fLXM6XqZ9uIeh6vt61V4Uw6lZ3m+Wy3Isu1fw7pj6H5t3UU1iFh5SyXTKtYEsND5nGJHrO0TvnpLFzZL66X0D++FfRSNX33pKVbD4FmwSuH1j2qSHEMfz4z7NI9ONjfjvY5MATMzOn5ZHb5rhuw5F2+1UUVxjIFf2RQkDh554j9p4QXQxdK0AtiflFde7AjW5G+fQT4JDe4L5VLEW1rHmuHvFzK66dwVApxXdyPu2/0xwOpmb+A9DMel3BvFHoDanEUduBNuxn+t7oP8VsMCDTx39xySv5A49XiwW44mU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d74b6d7-2e7a-4dfa-0b33-08dd502d3e81
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 15:02:21.0795
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C1KB19wQfEC+by7XMSorq8fxluwn6QUHvma2pgKosseFUZ29zdM4Vl60KdtS0poKzWffX/mO9ZCsqjFVwyjkAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4328
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-18_07,2025-02-18_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 adultscore=0
 spamscore=0 mlxlogscore=999 phishscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2502180111
X-Proofpoint-GUID: nv-4Zb1PiJwL-nmOfGTx1s0FTOnwzK4Q
X-Proofpoint-ORIG-GUID: nv-4Zb1PiJwL-nmOfGTx1s0FTOnwzK4Q

On 2/18/25 9:40 AM, Jeff Layton wrote:
> On Tue, 2025-02-18 at 09:31 -0500, Chuck Lever wrote:
>> On 2/18/25 9:29 AM, Jeff Layton wrote:
>>> On Tue, 2025-02-18 at 08:58 -0500, Jeff Layton wrote:
>>>> On Tue, 2025-02-18 at 21:54 +0800, Li Lingfeng wrote:
>>>>> In nfsd4_run_cb, cl_cb_inflight is increased before attempting to queue
>>>>> cb_work to callback_wq. This count can be decreased in three situations:
>>>>> 1) If queuing fails in nfsd4_run_cb, the count will be decremented
>>>>> accordingly.
>>>>> 2) After cb_work is running, the count is decreased in the exception
>>>>> branch of nfsd4_run_cb_work via nfsd41_destroy_cb.
>>>>> 3) The count is decreased in the release callback of rpc_task — either
>>>>> directly calling nfsd41_cb_inflight_end in nfsd4_cb_probe_release, or
>>>>> calling nfsd41_destroy_cb in 	.
>>>>>
>>>>> However, in nfsd4_cb_release, if the current cb_work needs to restart, the
>>>>> count will not be decreased, with the expectation that it will be reduced
>>>>> once cb_work is running.
>>>>> If queuing fails here, then the count will leak, ultimately causing the
>>>>> nfsd service to be unable to exit as shown below:
>>>>> [root@nfs_test2 ~]# cat /proc/2271/stack
>>>>> [<0>] nfsd4_shutdown_callback+0x22b/0x290
>>>>> [<0>] __destroy_client+0x3cd/0x5c0
>>>>> [<0>] nfs4_state_destroy_net+0xd2/0x330
>>>>> [<0>] nfs4_state_shutdown_net+0x2ad/0x410
>>>>> [<0>] nfsd_shutdown_net+0xb7/0x250
>>>>> [<0>] nfsd_last_thread+0x15f/0x2a0
>>>>> [<0>] nfsd_svc+0x388/0x3f0
>>>>> [<0>] write_threads+0x17e/0x2b0
>>>>> [<0>] nfsctl_transaction_write+0x91/0xf0
>>>>> [<0>] vfs_write+0x1c4/0x750
>>>>> [<0>] ksys_write+0xcb/0x170
>>>>> [<0>] do_syscall_64+0x70/0x120
>>>>> [<0>] entry_SYSCALL_64_after_hwframe+0x78/0xe2
>>>>> [root@nfs_test2 ~]#
>>>>>
>>>>> Fix this by decreasing cl_cb_inflight if the restart fails.
>>>>>
>>>>> Fixes: cba5f62b1830 ("nfsd: fix callback restarts")
>>>>> Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
>>>>> ---
>>>>>  fs/nfsd/nfs4callback.c | 10 +++++++---
>>>>>  1 file changed, 7 insertions(+), 3 deletions(-)
>>>>>
>>>>> diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
>>>>> index 484077200c5d..8a7d24efdd08 100644
>>>>> --- a/fs/nfsd/nfs4callback.c
>>>>> +++ b/fs/nfsd/nfs4callback.c
>>>>> @@ -1459,12 +1459,16 @@ static void nfsd4_cb_done(struct rpc_task *task, void *calldata)
>>>>>  static void nfsd4_cb_release(void *calldata)
>>>>>  {
>>>>>  	struct nfsd4_callback *cb = calldata;
>>>>> +	struct nfs4_client *clp = cb->cb_clp;
>>>>> +	int queued;
>>>>>  
>>>>>  	trace_nfsd_cb_rpc_release(cb->cb_clp);
>>>>>  
>>>>> -	if (cb->cb_need_restart)
>>>>> -		nfsd4_queue_cb(cb);
>>>>> -	else
>>>>> +	if (cb->cb_need_restart) {
>>>>> +		queued = nfsd4_queue_cb(cb);
>>>>> +		if (!queued)
>>>>> +			nfsd41_cb_inflight_end(clp);
>>>>> +	} else
>>>>>  		nfsd41_destroy_cb(cb);
>>>>>  
>>>>>  }
>>>>
>>>> Good catch!
>>>>
>>>> Reviewed-by: Jeff Layton <jlayton@kernel.org>
>>>>
>>>
>>> Actually, I think this is not quite right. It's a bit more subtle than
>>> it first appears. The problem of course is that the callback workqueue
>>> jobs run in a different task than the RPC workqueue jobs, so they can
>>> race.
>>>
>>> cl_cb_inflight gets bumped when the callback is first queued, and only
>>> gets released in nfsd41_destroy_cb(). If it fails to be queued, it's
>>> because something else has queued the workqueue job in the meantime.
>>>
>>> There are two places that can occur: nfsd4_cb_release() and
>>> nfsd4_run_cb(). Since this is occurring in nfsd4_cb_release(), the only
>>> other option is that something raced in and queued it via
>>> nfsd4_run_cb().
>>
>> What would be the "something" that raced in?
>>
> 
> I think we may be able to get there via multiple __break_lease() calls
> on the same layout or delegation. That could mean multiple calls to the
> ->lm_break operation on the same object.

Makes sense.

Out of curiosity, what would be the complexity/performance cost of
serializing the lm_break calls, or having each lm_break call register
an interest in the CB_RECALL callback? Maybe not worth it.


>>> That will have incremented cl_cb_inflight() an extra
>>> time and so your patch will make sense for that.
>>>
>>> Unfortunately, the slot may leak in that case if nothing released it
>>> earlier. I think this probably needs to call nfsd41_destroy_cb() if the
>>> job can't be queued. That might, however, race with the callback
>>> workqueue job running.
>>>
>>> I think we might need to consider adding some sort of "this callback is
>>> running" atomic flag: do a test_and_set on the flag in nfsd4_run_cb()
>>> and only queue the workqueue job if that comes back false. Then, we can
>>> clear the bit in nfsd41_destroy_cb().
>>>
>>> That should ensure that you never fail to queue the workqueue job from
>>> nfsd4_cb_release().
>>>
>>> Thoughts?
>>
>>
> 


-- 
Chuck Lever

