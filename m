Return-Path: <linux-nfs+bounces-20284-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gJtKOi9LvGknwgIAu9opvQ
	(envelope-from <linux-nfs+bounces-20284-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Mar 2026 20:14:55 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B32C2D199E
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Mar 2026 20:14:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B1B3D3006B6B
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Mar 2026 19:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5DDE3CF68D;
	Thu, 19 Mar 2026 19:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CP12HC2t";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="IG2cIu4i"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5423939CC;
	Thu, 19 Mar 2026 19:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773947689; cv=fail; b=YaYZ3pHTQT4BsbMw1bCVBXgtRCEpfCJKLcWUFshL8DzmndrrP0MSjiw7pjTwQ3l8GO9B7PR5/Ul7ma8ivDQZ1oAE6Zy6c+DRTvwoZm6+XnplSkmgOIF1GRbmAarY9YxnF1Jt8+dUJN6TmsE8Ilbiv4GEgB8EL1//lhsZNAaFoJQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773947689; c=relaxed/simple;
	bh=FaddKCm7pPrdFXCJ3GYCDCGXsJwOLklipDnOAW8M5N4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rabOA7MU1hm3IL9bG3Rhe55MyCeXqDmvgcLSx0XSJMRjvhDYyNysOnmeJjczp48nHm36QK63hTrPyU9K4fGNqqLPE5T9RZgZJ/0T8ktA8Noez+ywRy5WNQXx75hGYi6TUYQ8pd5g1BSLdDCm1saUtDejvzQDZJLR2wVXBWvwP4E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CP12HC2t; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=IG2cIu4i; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62JFsmlY1777892;
	Thu, 19 Mar 2026 19:14:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=z55IEmhWjgT7iHdnoHEZ9otYghHR55HqfkQGT/NqXlw=; b=
	CP12HC2thDyxQSPkZ/bYMVfp9Of7X/hA6tK3vmpLqzx7RIE1e9q1uPLflE5Dd6ro
	US9ePCD+5T7Bc5rlHEWWyP7JOhksXBi6HDTlhvVnTicqF3K9l1s292YLNiGZctsU
	0i6h83nPzRTC3CyxwcbwszzoM3EkqidWond+T+RFoNe/38EBQBJj0DEB8xAUlVdf
	7OgJX5OtonRBoQ73RRcAhC9DbMPbR8pmccUNjUjdUnWM0brQIKbQ5nqcsGIf3aWv
	V2NOHOwJRejq7u5GyLbk8WGiK+4x0GRhUkaQu0T3ERJ1y/Bv4GwfHr8YG3UwyKF4
	9ubRVXRp3WcMhf6245+OOQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cvxk8gmmu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Mar 2026 19:14:33 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62JIWifw003108;
	Thu, 19 Mar 2026 19:14:31 GMT
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010056.outbound.protection.outlook.com [52.101.201.56])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4cvx4qk7p9-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Mar 2026 19:14:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mvFMaoKNW4TV77Bg3RblfggHW+qGXeBDceN73LOFiiWn2ZHsNUluBLxbOlQ3yvDzlxn7das6e/vPb1tWKySKc6yM+AlOOOnDpfTCtPZISjxnMROZH2HlXbjlMvC2suLbiLSnfKjW+UVtpRTbr5vcWpJcs4NSF2ZY8KzWXUL0XVizcTq1mpPGOykeU5CiZlBzJUfWyL/lHP/c6rDiPjrsAqLZ6YpWwSXmQSwLPr5ZXK0zqHXEK/zF25TWbj4Jpsf50uuyt86Y2fHYbm4sCMBFGSnv43IT6pphCRaDcra9lc98IeMOZuKNMCeDhNOwpTxiOOrCRliQ1wU34A1X+HjJhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z55IEmhWjgT7iHdnoHEZ9otYghHR55HqfkQGT/NqXlw=;
 b=pgPGLiFY97xdbCjoznt+nFQ2t3MTVg5L7sb9yzEmrnWyhAacOKOnUYfqcild7OchsCUmdl2Qq75kfADzKukXiETgqr/RMTJH42lR8/C9Rk9PwtjnCOHPTvFA7Fctoy6xo3Q48GfbSI0vaSGvtpjo+BbxeUC411TqHeE9FC5wU2BepRlvarRL/DW2fU8MtjjwoKDlLpPELGZdGlTWRbJeEvrLnEDqCurIARimvGdP2XSX6E4WeBu/vmvo2oX3kjsGc1449+WniFJCXJwQ4ShWEIYt8r30e0pSRbx2D4fbUFIwlPFkHaac4k5dg3GGzd6gP/bOfOEfMKLR2Ol0zjy2Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z55IEmhWjgT7iHdnoHEZ9otYghHR55HqfkQGT/NqXlw=;
 b=IG2cIu4iBx0aIgGzN3FIFX7GOODyOn5Q/i0lIfhsV0uOKl5HRX8lEuJudP7ABY4T5vxIoopXz4C2UUrWAtHBjkwhQDJjGaBnlz5e1ZCyJlECu0+G8O8sFDUHDuOuTeYDe+bgpQ9M00C8lEmDZSchgf+XBC3KzrHYpNqFx2f8pp4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH0PR10MB5099.namprd10.prod.outlook.com (2603:10b6:610:ca::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.20; Thu, 19 Mar
 2026 19:14:28 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::4083:91ab:47a4:f244]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::4083:91ab:47a4:f244%4]) with mapi id 15.20.9723.019; Thu, 19 Mar 2026
 19:14:27 +0000
Message-ID: <0fb26335-058a-464f-ab9f-c109658d4358@oracle.com>
Date: Thu, 19 Mar 2026 15:14:25 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/14] sunrpc: add a generic netlink family for cache
 upcalls
To: Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260316-exportd-netlink-v1-0-6125dc62b955@kernel.org>
 <20260316-exportd-netlink-v1-7-6125dc62b955@kernel.org>
From: Chuck Lever <chuck.lever@oracle.com>
Content-Language: en-US
In-Reply-To: <20260316-exportd-netlink-v1-7-6125dc62b955@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR02CA0025.namprd02.prod.outlook.com
 (2603:10b6:610:4e::35) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH0PR10MB5099:EE_
X-MS-Office365-Filtering-Correlation-Id: be2d7470-9b85-49bc-b1c2-08de85ebbd80
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
 bjs4dHSj8DzTMjwZmUL6ziV1QNbFko3WNguWuaIn9fI+4FGI3JXQtRLTw+0ya0VO1p0TUYByJJxX4cQMP+tY4826YIcPWAqFxCYuWL5z28Ha/Ol9B5trHKacCOREECsLTbZ5yfZX5NH/vryxpA0lRscgp16MBQuEF6RhQzE3AGbE7BY/VAXSKhGsuqZrDKvK4cZt2te2vaYQUGHYS2ksPXCNGiLhkjqP4hkQw+OBdNZ9e9bNhOe8veDfvjV11f53iyPR9n+Cd3MiNHaguoZPddhBMIrjK45pSTDiGK7M/GkjDCk1HUxytAg9x4zacBrfwXKf9+TQvxaMCriyCigm92nnBVLKWouYjQM+/Cej7HNawETNGDI3+HagbGge1kEao5uyFYu2dUkfZsLvjlrZ9jQ2hqH1QdIG8EZXsxgfkgX5VtrCYmfrnDRxN7TfAmUUtLr3dX0CIzYzI+akPbbGEaTdrFwUpdm7PDZ6dwPbcyoQ0YTrgI+UwAcLod9QfqOTIOzY0IX3kU3Ou+umTomKTEZVdNPD7YPUzSrOaSsu2CeVpoCNd83Dt7cNU3JV1gYDfyHym9FwvPQLPXB15VsBCys2gi/jdAStDMGMTTY8DK88BrBKLOUjRQAVzGzzYnl3oymavMgpQXEQOXmEYOnQn9V5JljeoxBDdvfTlT3mD5HNwlD8AAOXS8PHmqTHwD0lphOwbX6Ms1abKwd7xBkuswUT/5sWh8IXkL5ZS+F7Ahg=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?d3EreThNdnplVXg3cWgvc0Z1QWpXazRGdzhyNDFvTkVBc280d0dhL2lIS296?=
 =?utf-8?B?Mk5zQXNENy9IRnZXRXBZeXN4WGsvTEhtS09ic1JReVZPaFFHQW1MU3BlcTBM?=
 =?utf-8?B?OG9NQ3BGeWl3ZWJ5VGQ2OHlPaTRBNllkMlQ1RGUyb1FyV0tMdTVuT2hPY0da?=
 =?utf-8?B?WDlmL01EczFuTzk2L1BubVZCUm43UWVUZ2hwUXlweGVVMVkvQ0g2Lyt2Tnp1?=
 =?utf-8?B?SlJTYkI4eGxsL1ZCdWJZbTRZc1hVbnAyQm9qMGZYek1OcDVYYmdTZFd1M0xJ?=
 =?utf-8?B?OFBOd0EybFpvejkra3YrRHdzUEhvaHJhYjF3OEo1VmlpdHkxa202QlRyVUow?=
 =?utf-8?B?aDZvKzZpK2tLdVBaSnJGdkhCLzc4Z0FtaFgrNkpxM21Ha3BCeU5OOXE5TFI3?=
 =?utf-8?B?ZjVGWnNBb0srVVh6M1lyQzZDR2xrVXJxbVpXYTZycC9pNzl0Qm03V08zbHVJ?=
 =?utf-8?B?VjhBSGhTQVRZL0RSVVRnQXFlWncxbkgvRGhLT3RvWGdDclNGSmdEK25tTVdP?=
 =?utf-8?B?WVpnZUYyYk92T3MxZlNpUEFHMThVbkNmM2VaQnAxZjFRMXcwalEvUU9XbXJT?=
 =?utf-8?B?TTA4ZXF5NFR5Si9GVDU2Zk9PQzI0ZEV1NVhiNzlBYS9KREJhVVN2NFo3STZJ?=
 =?utf-8?B?VUJwWHFqTTB2RnJHR2hOT2hMWTVDcXc5VkRlZklXZ3JIUmtQVGU2dlZuZ2lR?=
 =?utf-8?B?WDlraFJpZ3hUcHFxdzFMSVkrZnZRdHdnWU03eHlweHlXVnM4a2NOUi9Gc3JZ?=
 =?utf-8?B?U053eHBXUUJYVDc3dGttaGFhdVNZWTlPWTZ1RjBOK0tzbThmcjNsUlZZUy9E?=
 =?utf-8?B?L243Y3BTQ2hueFFZR2VWVXpkMzNTc2NkcDJ4R1p2NHVVeHI1QXZmRzROSzBZ?=
 =?utf-8?B?cjAwMS8wVjRQWTFSRDZzRlJtaHBCKzZTK2xGQW1INkloa3VRbTNLNG1kaFE5?=
 =?utf-8?B?dnFjbWUzR2xNN1cxMXV0dEdQRkV1VmV5OW5GRW1iTUxIRzVxMmtFa3grVjBQ?=
 =?utf-8?B?NytsNkdHQkpmeURsOWRhamMwTlFWUDVGSDZTUHVWcHpPQ1J5dlF3YmMyTkp5?=
 =?utf-8?B?NnNELzZGK3dxSVFRTkNyRElDVUNkVGFMNHBHOWwvQ3B5V3NMQlJZa0JWRHVJ?=
 =?utf-8?B?WUs4ZkpDZG5jWDlFRU91eVZHRkcyWDFUTVNmQld2UHd2T2Z2eS8yUGMxd2kw?=
 =?utf-8?B?YVc3ZFBQK0FVUnpTd1lhOStLcy85Rk43U3NoM0h6VjJSZmU0LzNITVR5VDRi?=
 =?utf-8?B?cEh3VW5lUS9nOEZZcjMzTERuUE9iWHlNSS9sQThKRU93Y1FyWjFrNU5qQTVm?=
 =?utf-8?B?UUdzOUpFOU1NamJjcThVblY0Qm1YekFINnhxbTcvVmtVaE1qNUUxWDZrM1J0?=
 =?utf-8?B?Y1N0OEpCdSswZFc1dnNXQ1pRM3phYnlhMUVHL0NqWTFYNm02dFg1V0dMUkNZ?=
 =?utf-8?B?OENlTlU4eU0wOVBXTTZJS09ZMmRxQkxHUnZSWUJVOHY3UG5HSE5PeG9kYWNJ?=
 =?utf-8?B?S3NxbEs4Q0k0dnpVTCtYbWJqQjR5UUpNR0ZRa2FQSlQ5UmRvSXpmTmRlRGw5?=
 =?utf-8?B?dWg5N3NnNnlpTmZQZUxBRURKRnpVbWl1M1R3YzNZTEFTb1BSQ2w0NHFwREc5?=
 =?utf-8?B?ZDlUZTJrMCtzbXBteEl6Wktja1p0TTRqNSsxSFQ2djZ5VWthTlRxQmZXVUNC?=
 =?utf-8?B?MXhMT1JpQVZxRHE2Mm0vL0FaZkt2cExDVi9MU3JidjhyWFJBYk00T01iT1lU?=
 =?utf-8?B?UGtsdEJrRkFiWHgyMG82aVBQMnFTbmlhN00ramt1dmZDWXlxT3d1VkNLWlMx?=
 =?utf-8?B?ZUd0dm8vYVFZTTVJNFhUV0l1U1RaWkcrSWZkOGxEN3F2VlpGVEYyMkRpby9q?=
 =?utf-8?B?NWdOWjVpQWdreXJpYW1LRndjVFhTaFpodlNRVStmbzN5TDh4NWhIb1BTZVU1?=
 =?utf-8?B?SkVyK2xYQkFaRFU4aFp6dm9nZ05YNGw5NUxwNHc2bWRLc2I2a2xZVHBEbFU3?=
 =?utf-8?B?QnZsa1Z3RFRzZEdxN0ZKSXFJN0xkSFF6ZmlFK0VwUlFDRitiMm5XazN4Rllk?=
 =?utf-8?B?SGVjWXQzKzFWcWZCY3VxRXUxckdqdkNiL3NCKzg1WlVMOTBtQ2g0WTZNbWNN?=
 =?utf-8?B?aGt5UXkzQ3ZYbnNmUmZMN2JxWkxQQkYyOWxqS2pPM1d3WDVtSS91N3l2VXFi?=
 =?utf-8?B?ODAyVlBCazFkOFh2REF6Y2c2MTdLbWlZNnFVcmwvWGNzZUlXanFsTGpOWk02?=
 =?utf-8?B?eVIrcjQ0Y3FnRTFpclNBMDgzcTQ0TFFKV0ZXR3p4cGJncWt5T1d6RDg2aUJ5?=
 =?utf-8?B?UHRJcVU3cGExN1NHaE1QTjdUd21zUjNVWTU5R0Q4cThHZTZOOVdxUT09?=
X-Exchange-RoutingPolicyChecked:
	nsB+BZP+mPzmR8N2EuDRoDeule1IB8wtkB4kxiRXLk/PjBiMlVtbo0x2A3daqBXNl0CKCxle9M4OVTzSOZTkOVA7E3U4ZUmHckLHMgM+OvPg2UIA5hioUu1c/SzDb5useNlqRFhq1MrahKE1pjiIs6BbAzQRwnPpBF9W/MeSgNxsiLoxLL2ATobtrEJ2mty9xAGjGJ630h5RDdEeuCmUQv5VpdP7IUbJG3jsO7LrA3eDx4zR6iRevH2JXJWEKA9269KS0zAch7hASMOzi/cOuzIKg/+bwPDhIMqcx9gnhYK72M9T/zey9K2BCgHxWFn/GkTzf1HWGyDDnu+N/uq3Dw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	rzINdrqp8fSbLOR8esXq/Kf8F56g5EZ0IpDyy+jD9/dEP2rjN6pc9LpB+2yjskm4HzI9iwF1fUWC/I2C6XGe5kEB/tAh+0EOx5Guszb31L9ktHVgB1vxgvUGVhh9lfohjvmR9kUeAOj48Xfb6yxu6FvuV5RMK7Sa/GN4WOMFGRMVNiKwsfDkObfOxKgOIyUH1mo1GpV1Df4K0cQstElyHSQbcv+GP051VdaIQhkFO5pzwYhf4Ca28po54aLTN21nAAF5CcvFQfQwhurEVya+3Igc+kaJF2KGoaSmazN90mygG4epl9l1QVEM+dYNy6EFbU+gosgfGtFEGcw18XHY01Fwg1kfuUHmNyeHbehyAFQUxCpKsom02+xO9LRNWgfBTphbaLXMzxJtHz2ILDdRNwUsyoIMz3IvQIrz2wLOWnn2M3HRKTZ4qa1YP9RTuuQ28AOuQV2ZbumVRIeqE3VqPBNyqDnpAercQbCHBc1u59piV7RHwEzXEZqFxGWRwwDuei9zi0HhyQKP5PHm/s6t4fmqvqQXnxPLSS5YH+vh97HGduSaBBno0tw6MQeqAIu32fkrYZy4Ii/4G1wavQhUpXlWm62bT+qRAvOaWxYsXvU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be2d7470-9b85-49bc-b1c2-08de85ebbd80
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 19:14:27.7497
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GYb1HyRC/677kfJqykwMVDzxSzXeR+SAcDxb5Ns3u4m1esxjMxlyDx1pxKo0CeJDBqvjiSwt9h1kX5Zh/d+5nQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5099
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-19_03,2026-03-19_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 spamscore=0
 adultscore=0 malwarescore=0 mlxlogscore=949 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2603050001
 definitions=main-2603190154
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE5MDE1NCBTYWx0ZWRfX4XIzAhUk/Hi1
 Niw5iYmFh+cd5ECze/UIBlAf3l9MwkDCg4IfllhmWqJ3MXG7PdCt9G6cS946EHPfiI6nEQ0u9rg
 1SKvKcabrXqUlXJInhEc5RnPnCmuWJKMzLAde+/xXYjAlVsg2qFsfjSLyNz6veGHcFKR4V2mZ9I
 AUyJNAcauGmi3gGm5zakDruWjuZFWW+6GzJcTihTYNILB9NDLfezzLTL+v+Jld86ipDV5rKkiqn
 O/n+KFT9yr6FL5VuOQ7W0m8A63ZgJytrEZow3vABF++NYcgarzM3qTIVsNmGRSx5pBzRVv9RI4s
 mGFW3u9J8NDg9MTJeUN0y9Bib/70SuUZ0jSGBausz4/PuGlIdQ/W9s3hEJ1GJTPePodrJIRMbTm
 U0slaAoMMc8C86kuCPtJTcNccYsyp/PSfYptkT1gw0sr1kYFf/6O+LPcc1Te71w3/o9NSw5ZpCB
 QrLBNG3ZkAst2WvuX1eyPXp6K4ZD8sizgZDrSN2U=
X-Authority-Analysis: v=2.4 cv=AI0/m/Lt c=1 sm=1 tr=0 ts=69bc4b19 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=x0eKOSpe3m1H3M0S9YoZ:22 a=OMWGzLcLm4KacoxGzVYA:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12272
X-Proofpoint-GUID: rdkbR_VvP3l5GbjnlDPPpj1dTIz8qG5Q
X-Proofpoint-ORIG-GUID: rdkbR_VvP3l5GbjnlDPPpj1dTIz8qG5Q
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20284-lists,linux-nfs=lfdr.de];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,oracle.onmicrosoft.com:dkim,oracle.com:dkim,oracle.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chuck.lever@oracle.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 8B32C2D199E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/16/26 11:14 AM, Jeff Layton wrote:

> diff --git a/fs/nfsd/netlink.c b/fs/nfsd/netlink.c
> index 4e08c1a6b3943cda5b44c2b64bcf3a00173a08db..81c943345d13db849483bf0d6773458115ff0134 100644
> --- a/fs/nfsd/netlink.c
> +++ b/fs/nfsd/netlink.c
> @@ -59,7 +59,7 @@ static const struct genl_split_ops nfsd_nl_ops[] = {
>  		.cmd		= NFSD_CMD_THREADS_SET,
>  		.doit		= nfsd_nl_threads_set_doit,
>  		.policy		= nfsd_threads_set_nl_policy,
> -		.maxattr	= NFSD_A_SERVER_MAX,
> +		.maxattr	= NFSD_A_SERVER_FH_KEY,
>  		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
>  	},
>  	{

This hunk is clearly not related to adding "a generic netlink family for
cache upcalls". Should I apply it instead to the appropriate FH-signing
patch, which is still in my nfsd-testing branch?


-- 
Chuck Lever

