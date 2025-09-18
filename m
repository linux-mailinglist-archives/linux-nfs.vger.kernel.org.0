Return-Path: <linux-nfs+bounces-14582-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25743B86C8C
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Sep 2025 21:55:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3BBA1CC3EF5
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Sep 2025 19:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BA7F25B301;
	Thu, 18 Sep 2025 19:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mgc86lo9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="L9tPzsqZ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F3323D7E9
	for <linux-nfs@vger.kernel.org>; Thu, 18 Sep 2025 19:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758225346; cv=fail; b=sFm1h+H02as5U8uLAiCs+YzqZ+l4V8Sv+3I5/y+f1QsfbiaoZMSuJ0tefpKAbdtKzPrwoqucgpTQTH96nVJzsXY9V9K5Hn0NrjV6Ep/u4L+v2TCPTZSU4zuOZcntokeyfhxunCL4DUBwjsQeLr8v8rextOkTO0n8Pu4/Xvs4gpA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758225346; c=relaxed/simple;
	bh=9cRdHbO8zp1EgfRdr2as/OuBwjeo5mYxF/VJo1T+McE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UWbnWQnBPhRYVWPRnsEDc0bCqDGhk9CSujmYynOovRQm/94J7vlV4adx93Cmb/1CCzexjfJ9cRk4+Oigvck6FozS3/DwfaNgeBWL1B8qnL6R8ERVUzIBoDzBVFkIfJLAFcvhxAanTqRq07+SFVlqMRLQluC7V9KodkSfXnR2I+k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mgc86lo9; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=L9tPzsqZ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58IG1mj1007031;
	Thu, 18 Sep 2025 19:55:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=dTkEmgWQT7Y1v+yvDsw6QQa3NedfjrPuOY4WFVhuAMk=; b=
	mgc86lo9wRALFI8gRrdkuqslKKKDL653yAcixXUzr04HxIWVeOmZnbARipgo+JzI
	JvEpjnWCzndTOl0B6jrnqsVPajrBURsH9C/dQaeOKX2pAHbDI5RLCuPcAG3bC5Dc
	mXveWa6yP9tb6DQR24nMs8dKGNF5j5N8/lrX8gV2NPZVj4YQ3T2ySWFOqX19wnlx
	toeWrS1eBUj3xvLQi0Z9iysxoPx7RupKrW0THPgE/13b9E+VvxFPgSnxpPrn24iv
	GP1it8HlfhGp9hMIsDOAa0x13YvPh4aYzxJgKMi7s9bO/0o8htbzdtjSLNfdeDRm
	mQS0jPcM6yc9CYRX1zzpYQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 497g0kcb97-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Sep 2025 19:55:38 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58IJpNHU036955;
	Thu, 18 Sep 2025 19:55:37 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011070.outbound.protection.outlook.com [52.101.52.70])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 494y2fnhx4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Sep 2025 19:55:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dz9v75UL1JBUQB9mMMcZN/967Sfmy99LktBqFF2Zk3cBy6cH9K4RX6QfwZa/FWWd5TxTEv1Wkmqwp2XfsHZF/ACUwQFBqj4vgxTqMhIiqsuOvSs8yrSutSa/ymkZ0HgHMSD/Puf3ZHmz8FQ28HMDOhDMzG5zMmly/opjUSFKmn7j+PFWk3YpeztA8YhmD8bhqvNbqFHVq73VNG18QEqPcvxzsLr4ZZasRhaKkbdDu/GUIS98ZDRiFgj69eaIMvIg+OsrU+dLbDxVORAWHzYQlZy3S6FbXJ5OHT2S2y81vPrcAxeUDWNhahix2XmGAzAPOmrKi9uVAOMKmilaRPqcrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dTkEmgWQT7Y1v+yvDsw6QQa3NedfjrPuOY4WFVhuAMk=;
 b=kMI8EtJIC8xk91358p/fH7aniySiMLUI+e4QR11Upl0Qw2HkAd/gi/HG22QTMaRznl6/hVvvw2IlbHTkQusg51c0sh2JdG6DJU/Ujh+YifYkFSlbynIcOluawjUL5y/yCRVvVmbfwArTr/2PCUw6JYRKYGEHbv+gAGr4h65QECIGhAAgbaTakj5IuFa9qw0l5VMDQZVL/+n/GtRFdc3dmj5XSbH6iobXaobNP/u/j1gHgZWeTvUZlQsXO7zBz+8hBbMqaBH7tQeQbQCBDU1ltAnaGuhhlpselXY03RrPMbV9kCDoi74dHcRh+ZxCQ+1C2DxyQHzDb8x8AhRVGWne7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dTkEmgWQT7Y1v+yvDsw6QQa3NedfjrPuOY4WFVhuAMk=;
 b=L9tPzsqZiNGD2+XdtJ9+r8U4p9ct5SFcZzHkLRe/sc01N6vywF3lwNrYsSRezOPEyNoo5PMJNbZa/UapXgw51isZHYn7Z0jvNWSuSDzqxpdGFC99xmUrDOovaNeT6ztAdsKDAdQSLR6p7HRZor6R4lfgVbMfeH3nYsvK/gaNyko=
Received: from BY5PR10MB4290.namprd10.prod.outlook.com (2603:10b6:a03:203::15)
 by SJ0PR10MB4494.namprd10.prod.outlook.com (2603:10b6:a03:2d4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Thu, 18 Sep
 2025 19:55:33 +0000
Received: from BY5PR10MB4290.namprd10.prod.outlook.com
 ([fe80::c86a:40f1:7833:ef3c]) by BY5PR10MB4290.namprd10.prod.outlook.com
 ([fe80::c86a:40f1:7833:ef3c%3]) with mapi id 15.20.9137.012; Thu, 18 Sep 2025
 19:55:33 +0000
Message-ID: <34a15201-e8bd-4269-9f18-e74394c63dba@oracle.com>
Date: Thu, 18 Sep 2025 15:55:32 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 6/7] nfs/localio: add tracepoints for misaligned DIO
 READ and WRITE support
To: Mike Snitzer <snitzer@kernel.org>
Cc: Anna Schumaker <anna@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        linux-nfs@vger.kernel.org
References: <20250917181843.33865-1-snitzer@kernel.org>
 <20250917181843.33865-7-snitzer@kernel.org>
 <23118649-3dc6-443b-beb7-9360199e93e3@oracle.com>
 <aMxFhX-jHnfv1F24@kernel.org>
 <9d8fb1e9-d40c-4c00-a555-e37ac0d4f290@oracle.com>
 <aMxbtqugI2dhwsF6@kernel.org>
Content-Language: en-US
From: Anna Schumaker <anna.schumaker@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <aMxbtqugI2dhwsF6@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR05CA0046.namprd05.prod.outlook.com
 (2603:10b6:610:38::23) To BY5PR10MB4290.namprd10.prod.outlook.com
 (2603:10b6:a03:203::15)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4290:EE_|SJ0PR10MB4494:EE_
X-MS-Office365-Filtering-Correlation-Id: 42ac34cc-714c-4925-7233-08ddf6ed542a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dDdWb1FLclcxZTlCV3ZIak1OQTZRKzFIUzJWRVUvZU5XNldxNVZtMTdBQk82?=
 =?utf-8?B?K1dOVm96UXV4am1zNHlBOGJ1VDQ2Y2tKUEhnNHdMWTZQQWRMc1RQTzh4djBa?=
 =?utf-8?B?QlBzeStHaTR1djVDQURhNFBSeGs4RDVsdFVXZ1ZiZEptNTJ0dlMybU9ia1A0?=
 =?utf-8?B?bThrYjRtcFVDdmhqbk1QOHdjM0lGWktMaXRVbmNmV1lyaC9zQTlDWXhNajk2?=
 =?utf-8?B?citVYmhWUi9JMG1tb3VtVDhIMmpZZGRaZWxaVGdSL1QrUHBabCtpcUFmM09G?=
 =?utf-8?B?ZW9lN1p1V3ptL29ESzlkc0VNZjZVQkpISHJOMjNYa0RlVUp2amo0RmMxSWpM?=
 =?utf-8?B?QUJzN1F5WEtITVR1cWY4SnVxSEV5KzJTeXViaGhZWisrVTdWQzNJanREc2E0?=
 =?utf-8?B?L05RcFVadEMwSld1VmpBSldRbTdBY2Q4VjBvREF4L3R5L05pZ25RRnpKVFVz?=
 =?utf-8?B?dld6Q0lpVlB2QStjZWhRWXNiNVFWSHR3VHAyTnZEWXJhemxTYVRrTkZxSWdx?=
 =?utf-8?B?MEliNVlEQmxUbGYyNURTNFhYbjhIZUJGVGphd0V3TVlTSkJaeE5Uelhyc1pH?=
 =?utf-8?B?WERyQk9kRWtQU1lWaS9Qa2YzT25QdFU4dU5RWm1keDQ1RlZzNTRodU1vcWo1?=
 =?utf-8?B?d2M1bFhIMVVtZnhBWnZGMm92K0ExY0tGNjZYdUFuNWtXU09GV25ta2R3U3c1?=
 =?utf-8?B?aVlDUXJ0TG01MEZYbER4OVBwc3hhVlJzN0loSjB0MWdUWHlPL2Z1SEEwdmVT?=
 =?utf-8?B?dlE0VUdXU2xoYllEVTNzSUx5UFY1VWJxUlg3ajBxa28za3BRWTZMdUY0MDFG?=
 =?utf-8?B?TUpGN0FoUHBCdkhzajBsNVoyb25IZTRMdkVWSUlOUzFlVUVrYjVaY0I3MnBZ?=
 =?utf-8?B?SXFPRENlSlB5cTBmcnV1L0Z6REY4Ly9MNnZzU1JNM2IzbWM3TDF1QmI4SFpF?=
 =?utf-8?B?VzZSKzA4R1ZSNUo1OGlFMkdicVBaYTNSOHpzZmlWZDR6Tkt4MWtuSnZNSEJr?=
 =?utf-8?B?OXo5V0tpODRPUUdPUENCcUdtMzU2SkNKcG1kNnVHWGlZMXBUeXVuUUFSN1dR?=
 =?utf-8?B?MEpUU2pHa1JIcjJ1Z0xVa1NhTlVzcWZCODM3bjRjOC9OWDdDTXpsOVBLTmg4?=
 =?utf-8?B?VHA0VHRQNXZRTVVIaVk0RnBkOHYzQjBQWS85K2lFUkd4RVp1SHJCbXdFL2VG?=
 =?utf-8?B?eWNsbWFUQUUzVmV6S1pONjFocjViTW1SNEIvTW5WaDVGRzVUUVUrQmJocWxL?=
 =?utf-8?B?dzNKZUcrWGw0bXdLUnNJeTNRcFdTRkZEaTlDOVErQ1pRbWg3SVlPMDduZHhs?=
 =?utf-8?B?WisvNk44dEpDZmdoMlZsVnRiTmlKdVlsZWFOZGkreS9HTDlnbHV1dENPQnlv?=
 =?utf-8?B?QmZCeHJYZUxTd1lHZDl2UWpzb2pOdWs4VFdIL01xSERlSjVpamJiUlUvTk9t?=
 =?utf-8?B?OEVtWkE3WnlxSW13MHAvNXY0OExJcWxyVkhDMW9DS2J1NFhSeXFFcWI2aVFs?=
 =?utf-8?B?cjNKckFRMjRqVDVDSFZOTDN6NzYyd0NpY1J1VVozV1J4emlZSmxJVUw4Sk0x?=
 =?utf-8?B?S2FJUXVQQ2R2Y1dLZUtLWjhnYXY3Z1RnL0FOYk5ZbkZQSnFGQlluc3hTUVlB?=
 =?utf-8?B?Q2g1aHNRVmtSb2dMbEhoWDdOQ1JuWnFMZmNQU0hzejgrdGhzYWtpbDdmNEtX?=
 =?utf-8?B?cmRjM1M5d1hHeWU1blJINDYrWks1NG5ib2sxZW5memJwV2NvRTdRRGh3MGli?=
 =?utf-8?B?bTRjK3Z0QllXSFFia0NtaW5PT2tpdnN1OTRlYW5IcDVVb0pkTFZwK1hOQmhT?=
 =?utf-8?Q?mDExCXF/nHNCDR7VW0a8C1YKicGpdLg5o0YiM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VVZMRll4WEY4Z2wwdUtWbG9LNzkxTEN0QmZFKzArVExxajZmK0VjQzJVSTha?=
 =?utf-8?B?ZHlZQWwxemF0aHhrNlZGSzJBVndpNmc4YTJDQW1HZUx1dUJWSmw4NXhHVHBG?=
 =?utf-8?B?amZ3RFVlRk1YL1IyNGhhODlzNXdKN0IrRUx2RG9ZT01YZ203SEQ0VElJQkdm?=
 =?utf-8?B?a0kvdEhLTFlWYkJ6MERFK09idlB4cm9UWWJqeFQzWk42blNSQjVMeXoxVTV5?=
 =?utf-8?B?aU5VY1dlTWJ4RnVoNmZTTVIwa1hHc2hjOVByTjU2eWxtNTZUTUc2RHU1Q0Yy?=
 =?utf-8?B?d2ZWRTB0OUNONjNuRTFaSUdFd0czRXNxK0I0TksxbjAxNWpJT1dLVS9HRE0r?=
 =?utf-8?B?Rmd5TlpBTTBaOVJHa1VrMVdEblVGeVJtdlI4WDlKL2F0Y3lVZlYwZDZBOGNa?=
 =?utf-8?B?WCs2NXEvRDNuUkxIcUE0U00rQzhOdDduU2VBWDMzV0t4SFJmWlVhTGdHS2hS?=
 =?utf-8?B?MGx1QlZLYzd4R1BJRkFvQjd2YVY2V3gvOCt5T0txMjV5cE1IV3RvcGxHWHBp?=
 =?utf-8?B?VUhnZEVnd1lqUHZ0RytwdXVJSW1tb0JWMjkvRjJaRGZLdFE4NlM2YWlpbXdH?=
 =?utf-8?B?VkJURlhoNHFaUDkwV0JVa1hIMHJWL2hBdGhtR3NkMzlkOGFkZEx5Z1VPdjBS?=
 =?utf-8?B?RkxzbHZkb3F1RmJBcy91T3dqQ0JUaE8wWjdJZWFhWFpzMG9mZWp4YjF4RTNV?=
 =?utf-8?B?QXE1SU5KR3AzVVJDMGlLVTFSMlpzYnVDR1FRZU9CYjJkVmFkV1d4NmxGa1ZH?=
 =?utf-8?B?MG9tKzJ0S1BkcUNiYmphRmVVQWZVMW5BZlNqeHBTR2NadFJNNytQQUNvZ3dH?=
 =?utf-8?B?K0dnWjJ5MHZseTNKaUdxbmNTM09qbmUrbWdNV1NQckxRYjhrQmQ5OGs4dHZl?=
 =?utf-8?B?MWJEYjdmaDRJb3J3aGZoaDArZ05RS2UwdDhqbGxnVFJIbWtZaU1xQU0vWUxX?=
 =?utf-8?B?R00rRDh4bVlzMU9iOFBaNmQvQlAvQzd0dFV5Q2Y1NTBVaFNTM1RxbEFSMWZQ?=
 =?utf-8?B?NWREd3FtUE5DWnhRRXI3YUEvbkJ3NTlqM3QyMVZGUWczNi81STNocVFteWlW?=
 =?utf-8?B?cWpkaGR1QVJ3S1l4YWs4T3czM080Wmp6YnQvU3FycXU5YUE2OVF0Vzcyc2pz?=
 =?utf-8?B?dldxNWszQUNvSW9DSmIvVEdWZEJub2k4czBkM0ZRaG9XR2NHOFFsbGFDQmI0?=
 =?utf-8?B?ZWV6NTRVRU9kOXNXeWlkSGg3Z3pxL1dINkRPNE1OSFA2VDNXQ0prb2h5UU41?=
 =?utf-8?B?RzNSUlRXcDdoRDdSTTdIQTVQL1FaYkdWbVhlZXRqVm0wOGduNUYxNlRqb2pz?=
 =?utf-8?B?MEw5U2ZOWnJITlo1L0lEOHBtZlZ2STh2eS9FOHJZK1J6ZFhDZnMwZWpNRjVu?=
 =?utf-8?B?MEZGa1dSbjNYdDhBdUVyNjhqU1BTa1NSaUlHcUM0ajZCbkhqMHpaMWNMSTVS?=
 =?utf-8?B?QkFvNEdVRkZZbWxFNWFramorNWpFRDlMc0YzNERwU3gxdEtnOGRISkduVmxK?=
 =?utf-8?B?UExwdkZoamN6MVpsQnVzd25zR09IMDg1V2NDcERERkxSTVduc05kYVNmc0lW?=
 =?utf-8?B?UFVKbzRncFA5dTdOa1R1bEE5ZlRpUS80M2xjblpFSThkUXBUckV3NWlQTDVV?=
 =?utf-8?B?aU9WWDlXUEtubVU4Rlo0S1BCMkNCWFloT1FPOUZ5MkxFL3ZGb25RZlBweVI3?=
 =?utf-8?B?VWMzQ2pLMEJaVGV1cW1kQWg4Tnl0VWQ3eXdHdUVjY1o2amdha1NyaUJJRW83?=
 =?utf-8?B?eDgwaG5vT01WaThDVnV2cXg1ejdNOCs1cVlTcWgvS3htbExqNzlIL1RtL0V1?=
 =?utf-8?B?OWVvbWJTTjRaSExFSkR3WXpoNmUvcEE3aXRGY1V4REs0V3B4UWZVK1BKdlB4?=
 =?utf-8?B?dUIxOGVHV1pCa0orMlB5NHl1RDEyOHNLbXVud1lRWk95Yy81Q0tUSkxobEYz?=
 =?utf-8?B?QnFNL2pGSENtN0JETDY4TUlGRHFVdit4ajFkSSttRzk5MURUYVUxYThJQjlP?=
 =?utf-8?B?OUxxaUJGdXVHK2FWeTlmN1l2Q1pZQUt0Mmc0d3AwZXdZSUhsbXVpb1lNZFdx?=
 =?utf-8?B?NzNjY095clBWR1R2b0xodHJXU2xmYklhVGJWR01LYzRrLzhGZEZkUTREdS9Y?=
 =?utf-8?B?UE5uRVJiQXRUeGdnQWo1cDc3R2lPYVJpc0NiVncwV1JMSkJyYlJFNEpHNEsx?=
 =?utf-8?B?V1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	YqRcgAuY/e7m0VbZk1CqCjD5nJtLv3BQgmoGCDPc0j0bY2m2y023QYpxgCXy+/hDE7hp5OCtU21+JIQC7/9DJJR3P3VGP/7Hz6QorhzaoJeH8yOSrNa7W5V8p7L/A7ohV4lp27vOxPTDYPkV+Z7R39E66tA4Np84llpxIuGGLFAZqjNDfzei4OJ1ty2w1KU/G9GuFdA7CvgmqAm0MxinxrAuJPF7i4vdFXcObEYfSlfDjYM3Gb5MIPaVmld2Ua54aRwEvTxSBB2Sh5mfGGbhYfU7yAmk5wD8zCjqg80yyeGcgG4y+v+soSPJYfofMvjhJ4vaaY2OQrTF8dSc+qcjN4GJnZNZJ6Y+t60UbzhxQr13fVHU3pIPnx/o+RaJ6Oq0mWt9zh5fSlSLdl7Ru7jqnNxE0NE3ZrZ8j6J+/7wZxaP61MbXpN+v0y8yKij/PnoPiFRErpNITaUI1gsVCESA55uI6QIwGru83WTKj3XWxpb7xtOq44drio9/0ddUUfSDKTc4Iv2tCEkyCfylpmiq0BhTMg+8fPXFGi+TgX6UYSmcbUTMjCzNzyAuRkudady2+E0ZDNY23RoQeWU2uF/6f/L9WDfrpyi80rgUAJEDCLQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42ac34cc-714c-4925-7233-08ddf6ed542a
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 19:55:33.7601
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vjFEW2jGU+IEJKcFAHfHxQ8anMfb51y0gY16wBgIXwbmjlrfFOsbK2uoLhKnWFREnGpsNaPILkFx4Mycqwux/bdYc0gXBB+94kByfc0NhkQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4494
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-18_02,2025-09-18_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 adultscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509180177
X-Authority-Analysis: v=2.4 cv=b9Oy4sGx c=1 sm=1 tr=0 ts=68cc63bb b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=P6JkxrBpAAAA:8
 a=3Jn4PyFFCUNXaInUsR0A:9 a=QEXdDO2ut3YA:10 a=dwOG0T2NmQ8MtARghG3a:22 cc=ntf
 awl=host:12084
X-Proofpoint-GUID: 3_LkJsanrcIHeX-gJlKoE7-ArTTzgjoH
X-Proofpoint-ORIG-GUID: 3_LkJsanrcIHeX-gJlKoE7-ArTTzgjoH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMyBTYWx0ZWRfX+HIkT0OKOpq0
 ag3enw1fzot+rDJ5sKr++LA0TwxV5HF89V1EITljYrCfXja5AbMN46hRfhwWGaVsZZm3aBpdLBJ
 eN5H//uqiBuwtQLrdaF4Cn99oEskkWBRZNaT8qxVfq/gb6IYAcCz1IsnsXGKwDzH3pNOgbhxQ3y
 Ly1J6iQV6+TRkdIOAwjwE+amnCazmi3+Y21HEQsch8KtSRGneUv+MQRF/hEVCq0CYYpZFHztc08
 R0dgX3rUfTlCEFISk9DPiVBejwoma6L+e7oUFJhZJvq95ZbDLLNQODowSlj2q3omRS5F/UD9R/h
 iTZE7gQ30HFKfPus47WjD3ozkHpwhO7VRMr+8pCaAo24ouSsDmMz8z7bG6THHTV6QVKrn8lvzR7
 pHYh+MxRD+9BzLzV2N1iVwYSTcd99A==



On 9/18/25 3:21 PM, Mike Snitzer wrote:
> On Thu, Sep 18, 2025 at 01:55:03PM -0400, Anna Schumaker wrote:
>>
>>
>> On 9/18/25 1:46 PM, Mike Snitzer wrote:
>>> On Thu, Sep 18, 2025 at 01:33:30PM -0400, Anna Schumaker wrote:
>>>> Hi Mike,
>>>>
>>>> On 9/17/25 2:18 PM, Mike Snitzer wrote:
>>>>> Add nfs_local_dio_class and use it to create nfs_local_dio_read,
>>>>> nfs_local_dio_write and nfs_local_dio_misaligned trace events.
>>>>>
>>>>> These trace events show how NFS LOCALIO splits a given misaligned
>>>>> IO into a mix of misaligned head and/or tail extents and a DIO-aligned
>>>>> middle extent.  The misaligned head and/or tail extents are issued
>>>>> using buffered IO and the DIO-aligned middle is issued using O_DIRECT.
>>>>>
>>>>> This combination of trace events is useful for LOCALIO DIO READs:
>>>>>
>>>>>   echo 1 > /sys/kernel/tracing/events/nfs/nfs_local_dio_read/enable
>>>>>   echo 1 > /sys/kernel/tracing/events/nfs/nfs_local_dio_misaligned/enable
>>>>>   echo 1 > /sys/kernel/tracing/events/nfs/nfs_initiate_read/enable
>>>>>   echo 1 > /sys/kernel/tracing/events/nfs/nfs_readpage_done/enable
>>>>>   echo 1 > /sys/kernel/tracing/events/xfs/xfs_file_direct_read/enable
>>>>>
>>>>> This combination of trace events is useful for LOCALIO DIO WRITEs:
>>>>>
>>>>>   echo 1 > /sys/kernel/tracing/events/nfs/nfs_local_dio_write/enable
>>>>>   echo 1 > /sys/kernel/tracing/events/nfs/nfs_local_dio_misaligned/enable
>>>>>   echo 1 > /sys/kernel/tracing/events/nfs/nfs_initiate_write/enable
>>>>>   echo 1 > /sys/kernel/tracing/events/nfs/nfs_writeback_done/enable
>>>>>   echo 1 > /sys/kernel/tracing/events/xfs/xfs_file_direct_write/enable
>>>>
>>>> I'm having a lot of trouble compiling this patch. I'm seeing errors like this:
>>>>
>>>>
>>>> fs/nfs/nfstrace.h:1800:1: error: declaration of 'struct nfs_local_dio' will not be visible outside of this function [-Werror,-Wvisibility]
>>>>  1800 | DEFINE_NFS_LOCAL_DIO_EVENT(write);
>>>>       | ^
>>>> fs/nfs/nfstrace.h:1796:17: note: expanded from macro 'DEFINE_NFS_LOCAL_DIO_EVENT'
>>>>  1796 |                  const struct nfs_local_dio *local_dio),\
>>>>       |                               ^
>>>> fs/nfs/nfstrace.h:1800:1: error: declaration of 'struct nfs_local_dio' will not be visible outside of this function [-Werror,-Wvisibility]
>>>> fs/nfs/nfstrace.h:1796:17: note: expanded from macro 'DEFINE_NFS_LOCAL_DIO_EVENT'
>>>>  1796 |                  const struct nfs_local_dio *local_dio),\
>>>>       |                               ^
>>>> fs/nfs/nfstrace.h:1800:1: error: declaration of 'struct nfs_local_dio' will not be visible outside of this function [-Werror,-Wvisibility]
>>>> fs/nfs/nfstrace.h:1796:17: note: expanded from macro 'DEFINE_NFS_LOCAL_DIO_EVENT'
>>>>  1796 |                  const struct nfs_local_dio *local_dio),\
>>>>       |                               ^
>>>> fs/nfs/nfstrace.h:1800:1: error: declaration of 'struct nfs_local_dio' will not be visible outside of this function [-Werror,-Wvisibility]
>>>> fs/nfs/nfstrace.h:1796:17: note: expanded from macro 'DEFINE_NFS_LOCAL_DIO_EVENT'
>>>>  1796 |                  const struct nfs_local_dio *local_dio),\
>>>>       |                               ^
>>>> fs/nfs/nfstrace.h:1800:1: error: declaration of 'struct nfs_local_dio' will not be visible outside of this function [-Werror,-Wvisibility]
>>>> fs/nfs/nfstrace.h:1796:17: note: expanded from macro 'DEFINE_NFS_LOCAL_DIO_EVENT'
>>>>  1796 |                  const struct nfs_local_dio *local_dio),\
>>>>       |                               ^
>>>> fs/nfs/nfstrace.h:1800:1: error: declaration of 'struct nfs_local_dio' will not be visible outside of this function [-Werror,-Wvisibility]
>>>> fs/nfs/nfstrace.h:1796:17: note: expanded from macro 'DEFINE_NFS_LOCAL_DIO_EVENT'
>>>>  1796 |                  const struct nfs_local_dio *local_dio),\
>>>>       |                               ^
>>>> fs/nfs/nfstrace.h:1800:1: error: declaration of 'struct nfs_local_dio' will not be visible outside of this function [-Werror,-Wvisibility]
>>>> fs/nfs/nfstrace.h:1796:17: note: expanded from macro 'DEFINE_NFS_LOCAL_DIO_EVENT'
>>>>  1796 |                  const struct nfs_local_dio *local_dio),\
>>>>       |                               ^
>>>> fs/nfs/nfstrace.h:1800:1: error: incompatible pointer types passing 'const struct nfs_local_dio *' to parameter of type 'const struct nfs_local_dio *' [-Werror,-Wincompatible-pointer-types]
>>>>  1800 | DEFINE_NFS_LOCAL_DIO_EVENT(write);
>>>>
>>>>
>>>> Am I missing a patch somewhere along the line?
>>>>
>>>> Thanks,
>>>> Anna
>>>>
>>>>>
>>>>> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
>>>>> ---
>>>>>  fs/nfs/internal.h | 10 +++++++
>>>>>  fs/nfs/localio.c  | 19 ++++++-------
>>>>>  fs/nfs/nfs3xdr.c  |  2 +-
>>>>>  fs/nfs/nfstrace.h | 70 +++++++++++++++++++++++++++++++++++++++++++++++
>>>>>  4 files changed, 89 insertions(+), 12 deletions(-)
>>>>>
>>>>> diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
>>>>> index d44233cfd7949..3d380c45b5ef3 100644
>>>>> --- a/fs/nfs/internal.h
>>>>> +++ b/fs/nfs/internal.h
>>>>> @@ -456,6 +456,16 @@ extern int nfs_wait_bit_killable(struct wait_bit_key *key, int mode);
>>>>>  
>>>>>  #if IS_ENABLED(CONFIG_NFS_LOCALIO)
>>>>>  /* localio.c */
>>>>> +struct nfs_local_dio {
>>>>> +	u32 mem_align;
>>>>> +	u32 offset_align;
>>>>> +	loff_t middle_offset;
>>>>> +	loff_t end_offset;
>>>>> +	ssize_t	start_len;	/* Length for misaligned first extent */
>>>>> +	ssize_t	middle_len;	/* Length for DIO-aligned middle extent */
>>>>> +	ssize_t	end_len;	/* Length for misaligned last extent */
>>>>> +};
>>>>> +
>>>>>  extern void nfs_local_probe_async(struct nfs_client *);
>>>>>  extern void nfs_local_probe_async_work(struct work_struct *);
>>>>>  extern struct nfsd_file *nfs_local_open_fh(struct nfs_client *,
>>>>> diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
>>>>> index 768af570183af..cf1533759646e 100644
>>>>> --- a/fs/nfs/localio.c
>>>>> +++ b/fs/nfs/localio.c
>>>>> @@ -322,16 +322,6 @@ nfs_local_iocb_alloc(struct nfs_pgio_header *hdr,
>>>>>  	return iocb;
>>>>>  }
>>>>>  
>>>>> -struct nfs_local_dio {
>>>>> -	u32 mem_align;
>>>>> -	u32 offset_align;
>>>>> -	loff_t middle_offset;
>>>>> -	loff_t end_offset;
>>>>> -	ssize_t	start_len;	/* Length for misaligned first extent */
>>>>> -	ssize_t	middle_len;	/* Length for DIO-aligned middle extent */
>>>>> -	ssize_t	end_len;	/* Length for misaligned last extent */
>>>>> -};
>>>>> -
>>>>>  static bool
>>>>>  nfs_is_local_dio_possible(struct nfs_local_kiocb *iocb, int rw,
>>>>>  			  size_t len, struct nfs_local_dio *local_dio)
>>>>> @@ -367,6 +357,10 @@ nfs_is_local_dio_possible(struct nfs_local_kiocb *iocb, int rw,
>>>>>  	local_dio->middle_len = middle_end - start_end;
>>>>>  	local_dio->end_len = orig_end - middle_end;
>>>>>  
>>>>> +	if (rw == ITER_DEST)
>>>>> +		trace_nfs_local_dio_read(hdr->inode, offset, len, local_dio);
>>>>> +	else
>>>>> +		trace_nfs_local_dio_write(hdr->inode, offset, len, local_dio);
>>>>>  	return true;
>>>>>  }
>>>>>  
>>>>> @@ -446,8 +440,11 @@ nfs_local_iters_setup_dio(struct nfs_local_kiocb *iocb, int rw,
>>>>>  		nfs_iov_iter_aligned_bvec(&iters[n_iters],
>>>>>  			local_dio->mem_align-1, local_dio->offset_align-1);
>>>>>  
>>>>> -	if (unlikely(!iocb->iter_is_dio_aligned[n_iters]))
>>>>> +	if (unlikely(!iocb->iter_is_dio_aligned[n_iters])) {
>>>>> +		trace_nfs_local_dio_misaligned(iocb->hdr->inode,
>>>>> +			iocb->hdr->args.offset, len, local_dio);
>>>>>  		return 0; /* no DIO-aligned IO possible */
>>>>> +	}
>>>>>  	++n_iters;
>>>>>  
>>>>>  	iocb->n_iters = n_iters;
>>>>> diff --git a/fs/nfs/nfs3xdr.c b/fs/nfs/nfs3xdr.c
>>>>> index 4ae01c10b7e28..e17d729084125 100644
>>>>> --- a/fs/nfs/nfs3xdr.c
>>>>> +++ b/fs/nfs/nfs3xdr.c
>>>>> @@ -23,8 +23,8 @@
>>>>>  #include <linux/nfsacl.h>
>>>>>  #include <linux/nfs_common.h>
>>>>>  
>>>>> -#include "nfstrace.h"
>>>>>  #include "internal.h"
>>>>> +#include "nfstrace.h"
>>>>>  
>>>>>  #define NFSDBG_FACILITY		NFSDBG_XDR
>>>>>  
>>>
>>> This change ^ was critical for fixing unknown type issues for 'struct
>>> nfs_local_dio' issues on my build. But I haven't seen the issue you've
>>> reported above. I'll try applying my changes on very latest upstream
>>> tree.
>>>
>>> Which tree/branch are you using for your baseline?  Also, which
>>> version of gcc (which distro even) are you using?
>>
>> I'm using my linux-next branch from: git.linux-nfs.org/projects/anna/linux-nfs.git.
>> It's v6.17-rc6 plus the patches I'm planning for the next merge window.
> 
> Like I mentioned in another reply in this thread, I've pushed a tree
> that is based on your linux-next branch here:
> https://git.kernel.org/pub/scm/linux/kernel/git/snitzer/linux.git/log/?h=anna-linux-next-6.18
> 
> I've verified that this builds fine for me when using either:
> EL8.10 with gcc 11.2.1-9
> EL9.5 with 11.5.0-5
> 
> Which distro and gcc version are you using?

This is with Archlinux and clang v 20.1.8, although I do
see similar errors with gcc 15.2.1.

Anna

> 
> Thanks,
> Mike


