Return-Path: <linux-nfs+bounces-22008-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AHZpB4H6FmqGzwcAu9opvQ
	(envelope-from <linux-nfs+bounces-22008-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 27 May 2026 16:06:57 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C63B5E5936
	for <lists+linux-nfs@lfdr.de>; Wed, 27 May 2026 16:06:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A3A13301FA59
	for <lists+linux-nfs@lfdr.de>; Wed, 27 May 2026 13:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F468405C4B;
	Wed, 27 May 2026 13:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qIBpy1mN";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="KgR9WW0/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF5B1427A;
	Wed, 27 May 2026 13:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779890336; cv=fail; b=nKA6H1bR6fu3ItHo+Heur9l3fbK/+fmAqxe17MBcZAyyHaihzBpBw2mwy5xav43AmmDcWzIELp3v0SvRqzkuMb20VpqG3xD6JxU7P7ETBnGS4SfAZ5zMmzwjKj7Bm4Mbeam6h49sXU/Af0E5trLLr4jcvpHhGJ79SAbiJ1OKXzE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779890336; c=relaxed/simple;
	bh=SFwbPWdkV6miZOcfAfe9il0VJ3hS6AZ20mSVcVWlpx8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LdzoOIwjUFxgTpy9tykcgggIwijQSyUySYtF8wyMDSJIXnMGYeygnwuHmXTaAg38GPNlmRPFbI+oWIbVgYGP31tN8/9pnEsdxXZ7kcYuHtRBUe+fqgQvOR3GRYNBOblkLhrEBoP61HefBcMD4+XY6AHRdCDuL4FTmOXQ4CWWNCc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=qIBpy1mN; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=KgR9WW0/; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64QN0Obs1933437;
	Wed, 27 May 2026 13:58:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=diYXcfMBJ+NCLlz7rRxFC41cv6fPFzIOjuW7rnUEnT4=; b=
	qIBpy1mNWEYnMwVfLFvc5XsPyuEqv7pdIMUMmld7H5IcPC5qNtQzJLG5p94ILin2
	bcRbj6KanF6X+cp0ZaksFX+BVb6fJRqLDYAOhs1CPOI3cN/gs1es+EnH4QNON3Yk
	W9BtIdU6gqez3BHmOvJYc1WiOnbmo0RjZIeM9HHPFoyRc6JDHtHv2y6LqLGDGLnd
	UAQKfU9Gcvsq1mtZJ7fJK52c4brGrEUjnSZbfUbLRNJ6G/WyQxfUN0enub2wv3Ma
	VC/25kWNAybjgek2Ldk190k3TSCp/zJan2cwImFQJVQdapZYPsrHs3ZJVjNQtWBt
	5a2JGPBpcZ0ScloJQVztdA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4eb49cnmq5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 May 2026 13:58:22 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 64RDsq72023768;
	Wed, 27 May 2026 13:58:19 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010050.outbound.protection.outlook.com [52.101.61.50])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4edjwy31gr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 May 2026 13:58:19 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gtidkyei/cL9Kc/iC/0MBOT5jEFJ2EQX5R+HBQZYNojEKOpjH8f+Gydvf6lzol+CtkrXAn8U8l7PWcuSKeDln/BFBAF58oW3Ngv7xpPb3dxYE7Om2KcmKAZ2doX2ZfEd0q4jztNv6MGijCIJb1yufGbp4aC7kNVPKkjVNPQXvrWYa2ZO5J4ErG457MjBVMs9WNDszdGIAb4T9lOCxHNMEJ+I6LPH3CfR9DTe5rqxji9EumtemXUNCB3GlCcj3BnX1sTy+apF91N5ZC2R/GTH64KDTt1Q9ir7TaRvUzF/qakvGmomCYGepQpK7hp13Hh38ZjwYPOW8x5FHQ6zreA0Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=diYXcfMBJ+NCLlz7rRxFC41cv6fPFzIOjuW7rnUEnT4=;
 b=hofivVhvcxKXtE22rVialFRQtAx7RaLfCzhqv4ftZQcmCH0NxW7g1bbg7NAtbW0xm6MVnUkapaKD6ABwbdwxb+96pEq/1erW0kpd7LS5eETbb5pPlfxBKoivb06UlzLoUBIw+4cVojtf7eu4Kf6aa8X3MOPhs1epqB0z/9qmcYCGGkJ+P6/JcCQPc/KmxX0i3evpAvMCSsksAbNgzeJqsnKSpDsR+/+ohIHPYMHnyhD0/8G04kMqm7MKDQImBNc099JINjp0uJmWDkF4ejvSNaYh9qxp9UsY9qtWh+CN1r7UI5r+l+cZnb7tZx761+Quz6kJczZJ+BGKlCmHHvYwww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=diYXcfMBJ+NCLlz7rRxFC41cv6fPFzIOjuW7rnUEnT4=;
 b=KgR9WW0/k0DGDQWul6Y2t3+eHdC/5b5QYx9mIgYhpk9wntJs3baXxXrO+R2gtstYLyBSsMn4LZoD5mgX5+0YqKKO/HCDh+AWiMysF9NTJqWN1dn+Img23m3R6n1MWnY3exh6gk1eswCGGTNscq2kOrcbmnxyPzqRI8jtgJAGn3Q=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA1PR10MB5923.namprd10.prod.outlook.com (2603:10b6:208:3d5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 27 May
 2026 13:58:14 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::4083:91ab:47a4:f244]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::4083:91ab:47a4:f244%3]) with mapi id 15.21.0071.011; Wed, 27 May 2026
 13:58:13 +0000
Message-ID: <276835c4-78d4-411d-8097-93cdfb000648@oracle.com>
Date: Wed, 27 May 2026 09:58:11 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: revisiting alloc_pages_bulks semantics?
To: Christoph Hellwig <hch@lst.de>,
        "Vlastimil Babka (SUSE)"
 <vbabka@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Brendan Jackman <jackmanb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-nfs@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20260527071816.GA17632@lst.de>
 <df21e8b0-a67b-4b71-8178-91221b596949@kernel.org>
 <20260527121920.GB6079@lst.de>
From: Chuck Lever <chuck.lever@oracle.com>
Content-Language: en-US
In-Reply-To: <20260527121920.GB6079@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0378.namprd03.prod.outlook.com
 (2603:10b6:610:119::33) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|IA1PR10MB5923:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e0e3788-0ffe-4a00-25fd-08debbf7fe85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|56012099006|5023799004|4143699003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	1RV+iUlisjDmxx11Nkr5UOC75qPwF+rzz1E6uIzDbUyMYdTYeKySmdwz+8Sq6Qg5ohHLFRDPklq29au1vUqSHNChf3Epd3E5Bxho+BetGc3EkA+PQNiEjb1+HVLoxdd24THOQrW8pW5I6DzBlYGyPzR1oBhWSGG3yZc1QsftULuwuj7qJg0A4ajAsWia4kqGwjKOJxQDT0hAXwT+t0YOpggMTFO1YlxekBG9BAGMjyZYq6sRsXUE4PrMTltdkxraTOF9BMRxuAJohRN6w/CY4X4pzzK2PX/ZENIyDBXcluJWpDJ3pyUP6OCMJQjX000wrVtGLmRE9GDk9c8L+MllFpEASHXAFUdL1F4G6DtjS3yPYTzJsLEflpfbEtP4EutF2WVVDUcsWfOZniiae9UIlF1oCWG6bRN0Yw6bw02Bv5z6FZyo9H/OW8YFJxykzYgOyj7ZH/6vAJoeYs3Tgi0w8Ud2gj6jtKyeMnDp0akTVRsXj3m3r2rj4RLtQNr2nRVxPg31KHesm/OOaUUL3zIPFAw4/5i+V6fp8aMgNfWzgLy7Blerg/TMoDZy7pO6PPVgg/bGHB2gpPyzPPU3LV9p/xePYeOAutQap9xhJdqqJ/HoQ9Oefxd9GPoDGhQeoSDzUETFLlX8TJum4eN/zMlSONuW/+/x9ZSaHJoeMUppIKEJih5u7KmCk3DV2BsjJqY5
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(56012099006)(5023799004)(4143699003)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WlJnY24rSFBEU1pMM3hrYlpXaUJXN1BTTjlJUGIxOE4rTVI2dk0xYlN1bmU0?=
 =?utf-8?B?VWtEb0pSREhlYWRLWVVPVnpJTWRPZUZlTUlXTXNLUmZPQWZrVndoeTRnNGhW?=
 =?utf-8?B?ZSsxM2dXVlRIc2hnT05FVzQ4dHF1VHZZenBzbGk1TWxSZ0Nnd1BZSFFmanhy?=
 =?utf-8?B?dEFuRExjZlpaU21Lc0VWbmxlQ2lSRjI1REdPZlgxdmIzMGFURXlTY3kvMkJG?=
 =?utf-8?B?MzFMMGhCd0VqQlUxYWV1Q3dURTZzcHFqZi82M3RJeDI3SU5CMWQxK1RCVnJh?=
 =?utf-8?B?SC8zajZ3aUJ1amtpbERpUmtpc1AvYzZob2wwQ1BNeEROZ0QzOXowVDdnZTlK?=
 =?utf-8?B?cnZyNWhyWEsxeFdHaC9YbG80VFc3VUFWUjJVYlZGRXFycFZVU2lyWkg5b205?=
 =?utf-8?B?U3ovc3ZwVElmd2NVUXp5Z0xQejhXN2EwZW1FWHlxYU5NOTNjVW1uenFkL1Ju?=
 =?utf-8?B?WXV2WkxvQ2ZpR3dITHNseWovNUJqakxzclpSbXZ1Nmpqc2VyRUNkVXRvT3Fq?=
 =?utf-8?B?Njh1NmIwUTg1Zkx2c2ZvbTB5cHAwejlOaHc2eHF2VldIL3V1TW41Yzkwemdr?=
 =?utf-8?B?SlFqSVRXMWpSQ1dGWmFXWUtYa0IzTFVNTGVNMnhnVFk0T1ptL0ZRcGRmUDd0?=
 =?utf-8?B?TlZIVFZKSFVibUkwZVQ5MEE3VTd2cEJLQlBPcHdZeDFUa2NwMkVzOXlOWG0w?=
 =?utf-8?B?d2I5MjMranhtZENLLys2dFY0cGY2bi9kYWUzbFNmMkZHeGQyNEdGRXd0NWNy?=
 =?utf-8?B?WHFNNzJTZkRYUWFTWGRUSE50eVNBbG95b1Z1TzZHRzY5dm9DMmlvWG1Jbmhz?=
 =?utf-8?B?QnJGQzlSQUVWRXRRbjVXSUl6WDBkY3libVdlUkZIVHR6d3k0VFlVeVhtU2s4?=
 =?utf-8?B?KzVYMEZNN25QWUhwUlU1a25IM3lveWtEaEJKVnRjRVBqWitQWk9McHJ5NXU3?=
 =?utf-8?B?cXJxUHhiTmNsdy9aQzg0Mi91SWxHQzE5TU81UTBUamFHMTlLcHUzY1czQ1VB?=
 =?utf-8?B?cnhvY09qR0J4TmUvT1ZwUjFlc3ViZWlWQVpreUpCNmw2K2hBR3QrcWNxcW8w?=
 =?utf-8?B?RXpHblNBQWhIMS9DQlVhREF1MTFVU0VLakMzNkVFa2FqcG4rTlY5cE9mUFJt?=
 =?utf-8?B?S1o2ZmNheFRscWhHVDFDK3dpMm5rZXR5eC9OZ1Zqc29yNndlVmdTQWR4K01L?=
 =?utf-8?B?cmo4SU5sdVpibVRzWkNOWTRKZW1KUmxBK0RoYy9pSEFUMCs0TGZKc1JYOHFh?=
 =?utf-8?B?RmhXWUF6dHhWVFcrWk03aUtQTUNJczc2V0pVUzd5K0ZKSmFTc3VsSHFTczAx?=
 =?utf-8?B?M0lSb1pFN1U2aS9LUERwTW1NcmlPaklRcjJuMFlaSjB0ZXZqemVSUVFLMVYv?=
 =?utf-8?B?ZHZXcTF1VDRTbE9SNjdyRUIvaW9DYjY0NnZ1VXFiMjlkUkxNL2Q3K25XVEN4?=
 =?utf-8?B?VDBDMkxRZFpmOUhyUXA4MzRYa05tNTBoQldXdHNOUndaeE5XaE14T0N5MkVN?=
 =?utf-8?B?Nkt2WnJnWm1weTVJZExLL2JOSVVIQnpNRnd2Q0FWV3cwNUJib1U2MklKU2ww?=
 =?utf-8?B?ZlVJb3RJdTNIeU4xTzhoTS9rSVFhNDAwWm85bElxcHZjaFdEcVRZelZoUUpw?=
 =?utf-8?B?K3ZvZzJuRkkzaHQ0aUdLQTdxdFNEU0Q4OVgyVUVEaS9TNzVJTWUxQlcwd28x?=
 =?utf-8?B?WStSNXVxT3d4bEd0bk1TeFdkSjFXb2JDVmFpcDVaYTBYUElydDIrNTdtd3VK?=
 =?utf-8?B?Zi83Q3hIZmVzNmRjUXNma005SEFmUDVhYWowb2gyQ2ZQNjJxd1k4UDZtaE1B?=
 =?utf-8?B?VStKMVorQkp0c1hTczIwaitaZGo3dU84QjhhWDBIM0l5NXFPK2dtL3llbllD?=
 =?utf-8?B?dnBrR1lhalB4WHMwN0ppTkhtMWtxMFE0RURuY3hXY1RwdGl4Z3oxbjdSQ1hR?=
 =?utf-8?B?VU1ZbkNqUW5RbkE1Unl1WGJWeDZNdTFWYWdkTHJnczE1ckRZVjVwVGMydHFD?=
 =?utf-8?B?dSszUmduQkh4TjU5eXdPR25GQ25YSGx0alVsanBBRjlEbnk4WnVtc3kySTh4?=
 =?utf-8?B?RFZ0RllibDY4L05kSE82Rjg1MzJUSHNwT2RldDU5eHg5M2pEQ0ZRd3dhUDhC?=
 =?utf-8?B?Y0RYUE5TTEkzNVg1ODF4VWpObk0vekFHL1NBaEduM0EwRWVaNmVrNHFvMHpk?=
 =?utf-8?B?RDFDTVY4ZUdLd1o5dWxzVERmRGU5N0NRZGt5TnNFQmRia1RTUDQ4c3RMUW1Y?=
 =?utf-8?B?SUZqbHNrZEpJWmFoZVNOMkVRK1I3RE9pZmpocmRkVzlBV2k5TG05L0MrYjd2?=
 =?utf-8?B?RUNCVkJJTFAwald3ZmU1WXE5UDVMWVF6SGsrUklZR0RBY29aODFmQT09?=
X-Exchange-RoutingPolicyChecked:
	buJHLxV0Mhu00sIH3pIl5gI5clhNAF+k9SF6gCaAf65R9HCbnL4Wp28iaaFlI89EZexSHs7/JenvB7UpC4L8Ja3RBCALzS4nnQx84q84b6sF7UySFPK5vapktLreJhDHeV2vZCCvoIf2GAiQBwP2VoXia1M3YI1WE6UQpKirTeQ1Gcf5j1wwwUYthLLghl5+Gb3s9YlltfCgrmN1vqsRuI2pbrKTcpmlxnnQTWVNXd9p/IIDybprGqieNmhuWlDXR8XayoStv1F1C0/bLzgnpFSpR8L7bO2WovbsACfYQMsgGogTy0285c3gQXuygAIwCiTsFXJFbUbAGY+gsZD4Qw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	tvtiPRGx+wU6xjnjCRIDobAF8TU5l/A3UOdFDlVAQzUtDl1zg2832O5JvwqqLhNhEHSXNExgAXqDQxgLrayxv5ZQdMrdZKL7Rgd+jj/QNSrpzmgtWDON0IbxY/roSI6SuHYNrYsuqrDsLHTEnXKlnXVxNXPi8isftnllzk7uAB/PbA8bsblMjyc7/bcEuy3AYajS60yv3kzki0wy7Im+FGGsurHIp0XH1cLbdn7BjYpHZxs9zxExfpBDcwk4JHcu5PLH7/ufD5iHbOCVmH0yzQGGwbS+L/WuANqZrbKhD8rrNYndm9Ch8CjjAAfjp1CCS8+vgrv/JAsKmXjo357AC85DTvWkFk9cYgjOPcno0TQ4He370QrWqx9bwMH93C/5XhEJALfVrCvp2RDsIBjFuIgjRbA29ESa1DqWD9ii0Ez6MQvrvRcN0sf8K05ANajAVXb/uiyDrffK5GRdW4Rsuf9zhwGYIOLJ4YuW+ucjPlRS4fTIZNIzVJHw8MuBLEshTzmuolRvY0qAQxy4besLRU+gW0QWqlvMzLi0mZ1LVWDVB4vtSyJ+Gtyb7KCMMiZoynl7E0rXOORU5T9lEYyn/vqKmvn4PXjdiqV7tcx+9Yw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e0e3788-0ffe-4a00-25fd-08debbf7fe85
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 13:58:13.6522
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: chhVdtB2tMVkd+O3TX4hjCXT9jJFC8tZlDwnFXaffIiZNut3vYqalep1EFduEkhp2JHxajaN2vO34VJ7Y6Kreg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB5923
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-27_02,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 adultscore=0 phishscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 spamscore=0 bulkscore=0 lowpriorityscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2605130000 definitions=main-2605270136
X-Proofpoint-ORIG-GUID: 6FmT4fkeBR00GHJ_gi50hF_hGeh01l7j
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI3MDEzNiBTYWx0ZWRfX3b+jC9W2aTu/
 8KKqiIsN5xFAcie9icO5GZKaZzQRyXH3obglGWZZJkiIjxBI7rQSUJhaEDDRb4guTfHaisbE3zY
 NYcuwWG+w8maNln8slKXuTiZof0LKHnhTmpOasQgo8ELLg6ima4H9PUbMxiJq2I7xoQGpEyjXkt
 lx+vbnIVj48xpgrGuDeNFvy8OTEBw+gBxJSBCs+PW/dvHRaDVy/OK4YM4DYKwvLijcGAvXwC4oI
 24PdaQw3A2aFwPndHQTvS8T8EC4CT96kYmKef1++q71pLYamjyqWSVhpHW0G3otTwWgnc3ZZ9Hb
 7+I6M4Fu+4d5Pb3naKw9uhw9/pHw9x+l6SNNnHOvJppSTKgUhHtke4JnEIh9JWDku5ZXRsbOxca
 c+TYrzxatawVFMYUZ8PJHqEHG38TONE5gUAtUZv0U+gH4VuPkRUnBkgv9eYhFPabL9Po0cRqqjK
 vr48fZU5gaVml/rub3Q==
X-Proofpoint-GUID: 6FmT4fkeBR00GHJ_gi50hF_hGeh01l7j
X-Authority-Analysis: v=2.4 cv=LYsMLDfi c=1 sm=1 tr=0 ts=6a16f87e cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=BqU2WV_vvsyTyxaotp0D:22 a=yPCof4ZbAAAA:8
 a=VwQbUJbxAAAA:8 a=uTX6QTuB_yQbv5mIwYMA:9 a=QEXdDO2ut3YA:10
X-Spamd-Result: default: False [0.84 / 15.00];
	SUBJECT_ENDS_QUESTION(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22008-lists,linux-nfs=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oracle.onmicrosoft.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chuck.lever@oracle.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 6C63B5E5936
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/27/26 8:19 AM, Christoph Hellwig wrote:
> On Wed, May 27, 2026 at 12:06:08PM +0200, Vlastimil Babka (SUSE) wrote:
>>> alloc_pages_bulks can do partial allocations for some reasons, and
>>> users usually have a fallback by either looping and calling it again
>>> or falling back to single page allocations.  This sucks!  Why can't
>>> we get our usual try as hard as you can semantics, requiring
>>> GFP_NORETRY or similar to relax it?
>>
>> If we do that, do we keep the possibility of partial success, i.e. return
>> how many were allocated? Seems wasteful to suceed N-1 and then throw all
>> away, if the caller can use a fallback only for the last one.
>> Do some callers need all-or-nothing semantics? Should a flag indicate which
>> one to use?
> 
> A lot of callers (but not all) need all or nothing semantics.  But
> freeing already allocated pages is the not a major problem - the caller
> just has to add a release_pages call if it didn't already have one
> for cleaning up later failures.

What the svc/nfsd thread is trying to avoid is sleeping uninterruptibly
waiting for memory resources. That stalls server shutdown, among other
things.

Guaranteeing forward progress is the bottom line.


>>> There is one single user (svc_fill_pages in sunrpc) that relies on it.
>>> For everyone else it creates extra burden and is very error prone
>>> (speaking from experience).
>>
>> Sounds good to me. Will sunrpc be easy to convert, or should it be another
>> flag to opt-in to the current behavior, that it would use?
> 
> I've added Chuck to the Cc list, but from memory sunrpc actually does
> make use of this feature and he objected to previous attempts to
> change it.  So a first step would be to have a lower-level helper
> that works as-is and a wrapper that zeroes the array, even if that
> doesn't feel as efficient as it could be.
If sunrpc is the only user, it might be sensible to hoist the "zero
fill" capability into sunrpc.ko.

The impact of walking the whole array, for this check, is measurable,
and I've got a patch in 7.1 to mitigate that:

commit d7f3efd9ff474867b04e1ea784690f02450a245b
(refs/patches/nfsd-fixes/sunrpc-optimize-rq_respages-allocation-in-svc_alloc_arg)
Author:     Chuck Lever <chuck.lever@oracle.com>
AuthorDate: Thu Feb 26 09:47:39 2026 -0500
Commit:     Chuck Lever <chuck.lever@oracle.com>
CommitDate: Sun Mar 29 21:25:09 2026 -0400

    SUNRPC: Optimize rq_respages allocation in svc_alloc_arg

    svc_alloc_arg() invokes alloc_pages_bulk() with the full rq_maxpages
    count (~259 for 1MB messages) for the rq_respages array, causing a
    full-array scan despite most slots holding valid pages.

    svc_rqst_release_pages() NULLs only the range

      [rq_respages, rq_next_page)

    after each RPC, so only that range contains NULL entries. Limit the
    rq_respages fill in svc_alloc_arg() to that range instead of
    scanning the full array.

    svc_init_buffer() initializes rq_next_page to span the entire
    rq_respages array, so the first svc_alloc_arg() call fills all
    slots.

    Reviewed-by: Jeff Layton <jlayton@kernel.org>
    Signed-off-by: Chuck Lever <chuck.lever@oracle.com>


-- 
Chuck Lever

