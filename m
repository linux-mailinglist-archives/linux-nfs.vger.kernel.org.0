Return-Path: <linux-nfs+bounces-13439-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B866DB1BA01
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Aug 2025 20:26:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66FB818A3CF5
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Aug 2025 18:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16D64277819;
	Tue,  5 Aug 2025 18:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="saXYYVjP";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="C7cnMG+f"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A76291C3E
	for <linux-nfs@vger.kernel.org>; Tue,  5 Aug 2025 18:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754418375; cv=fail; b=E51oYTM02p4QKhMaNfQrq475Q9iScb1gPUNuf9tBsjs6WD8vwn7oPk+8lkIiXdbHYcw4Nijs3UPGJd/JH2Zk8ifX9SWF7fbMxuDx5g3ddHxwMgcTROusINZG9uC8EFnsjmKLIbPRrpxEtcJIv6y+DgotsSBy/BVLc3pAABtJBPQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754418375; c=relaxed/simple;
	bh=lKkHGZtUNVpwbzk6aP3aI7NP0LgdvUU1yKgKPaORCLE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NqW7VoEqrCfAh4LsNQuQoPiNyMkOgBrjT0O0lvweqyPIMQklXjuUvlm8zpR/xkJvsaN1WIzK7BWyD8snWpt0NKP+U6Fcp4RTdSDwgkV4KTcaFoT9QUWmpp0pvK4En59wLYaNT/jQbfGIJEuoOlWZ2h+Uw37C8lHe9wbivXBUSAA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=saXYYVjP; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=C7cnMG+f; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 575I1ske032478;
	Tue, 5 Aug 2025 18:26:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=X1/wq8F8fKfKUILhlDnHi1OxWKFmvlfu7rO3N74yq9M=; b=
	saXYYVjPir8dTW7B9uZBtjHXsenu0TnUOiQz4SfxvYMvpF0jCcZ7Rn/KmPdbViAn
	/o+K9yFOOtA9LsluDHo9foFQjtblZ0HpU9Dl8L1sTSL6dz0yQUHyJsUuORLWR3+S
	gLpHqzEc+BEMfqEGrEIKlBPKW8QzW9LlWAQq0yzYtaAnRK9cE3kp1v/P6Bome2t9
	rlF6Zsn3c+fUg6yp00NW34tJ8AYN6hayIOGS8eOWnVUCZwxeHrBDtudxiEB2g0Ow
	Q+f3KO1SdgJzDtuFA63hyIdpQnGjA+NY8eCW4VreouLLdwKL/wFd28dI/sSXCB/N
	4sZWaauqDjLL9oAYmqa3bA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48bpvjr1hj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 05 Aug 2025 18:26:09 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 575I478u028815;
	Tue, 5 Aug 2025 18:25:53 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2088.outbound.protection.outlook.com [40.107.236.88])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48bpwk0q9v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 05 Aug 2025 18:25:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LpJe+OQrcbPAs5DLWdy43MR6eEUbwalamMoIdmE/SnHJJueuP1p6ytShyGANpzRvkyHvRkxKup68zCXKosj4eXmvAgC3Yx/esk0ohDO5XzPaWJIRP0LW2XLPuOgZviYPcyvEtd+g4QJRJdOGzD9B/Lb034JHg48iIWkDKPsU8wCcwlyTJgqOn2Qn3CgbdPSXSqE88FhYzADA3YxhZiZIK+xeIEH+esdpHSVUqbmFkI/YzDXjDyPjzz61rbKqCesQ/a6b1a6dflrWxDzP0FGuO+f9exoGx9RwShnkHhmP3p5HLZ7mMmtkQOw4+uQq7fsXX9KMlLRwB4GuJSMqaHKooQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X1/wq8F8fKfKUILhlDnHi1OxWKFmvlfu7rO3N74yq9M=;
 b=qGDWH2D6lFkZD9C+3x8GoDY0lYcI2a0Jvum3433SL2EU5Oi9e5lgNFbM2vOamTX6c8DcH1vjbdy3JJgp9/VKFtFQH+X1FiywA8oF6fJ79przafE8Sld10Rmzr/uBBczARdN71Iu9eMAgjBoDPAl7QJbhy1XwjJuFccGfCnNYfeyaHzgBPGnMARNfs8Eps9BwQfzAXeesnt4AdVAk4pWQ3UzC2xNwlYxzLqlbItxULa9uK0o+edSO2QvQixvgKsNqGYn9BIxyIJnEOUC7Akan4MIjcZ45c/RF3d3CCQOrSBqRwScSZB7A1o2oJqcMzrYWEVrRYH+J2zSbJTPuyILABw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X1/wq8F8fKfKUILhlDnHi1OxWKFmvlfu7rO3N74yq9M=;
 b=C7cnMG+fDwiu1MZ4zkbGPqugX/QpMy7QmaShJfPnhy86jW5L68BcYd0gmD7rvlxGWqV3ddt1R4mP4TEYE6xPpnTRpiIzxejbDCt/+X1TfPQsxXHJQrH4IXgUg1gJbiNJJ2yhDxAv1ZDudW7rQeiwJOEeRkpxF+3UHifGINXfJ5M=
Received: from MW6PR10MB7639.namprd10.prod.outlook.com (2603:10b6:303:244::14)
 by IA1PR10MB7537.namprd10.prod.outlook.com (2603:10b6:208:457::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Tue, 5 Aug
 2025 18:25:51 +0000
Received: from MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6]) by MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6%4]) with mapi id 15.20.8989.018; Tue, 5 Aug 2025
 18:25:51 +0000
Message-ID: <9795ce6a-7b8c-4a1e-a536-0f804de502b3@oracle.com>
Date: Tue, 5 Aug 2025 11:25:49 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] SUNRPC: call_connect_status needs to destroy
 transport on ETIMEDOUT before retry
To: Trond Myklebust <trondmy@kernel.org>, anna@kernel.org
Cc: linux-nfs@vger.kernel.org
References: <1754334505-65027-1-git-send-email-dai.ngo@oracle.com>
 <48287a80e639d61eb507175ceb44d216e8032510.camel@kernel.org>
 <72e387a8-b800-431b-89c3-0104fbfe6273@oracle.com>
 <23fbff6b80f0c7c4b963f214c4c1e5d7b31c1d23.camel@kernel.org>
 <de62d42e-5e85-45d5-825b-369938a4a24c@oracle.com>
 <3978e03aa1638621bced96738ef210ed389e2afb.camel@kernel.org>
 <14935b2e-8124-4f46-a63e-331328d49d12@oracle.com>
 <5fde3098a1ae24966def603f127986d6a417e5c4.camel@kernel.org>
Content-Language: en-US
From: Dai Ngo <dai.ngo@oracle.com>
In-Reply-To: <5fde3098a1ae24966def603f127986d6a417e5c4.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH0PR07CA0112.namprd07.prod.outlook.com
 (2603:10b6:510:4::27) To MW6PR10MB7639.namprd10.prod.outlook.com
 (2603:10b6:303:244::14)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7639:EE_|IA1PR10MB7537:EE_
X-MS-Office365-Filtering-Correlation-Id: 5853a4eb-29c5-497e-bd6e-08ddd44d81b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aTY2ZFNzNUhhSlcwVEhhZVA3SHJPUkUyNEJaRTE1M3JPZ0hkbThWaXZrdUts?=
 =?utf-8?B?b3FVUVJtTDZKVkF0VWIrMk9lbmd2SjNDRTlIazEySGhBMWZlZFd2NjVXeGZF?=
 =?utf-8?B?WldSVXNORW1DN1N2NHVrZFV3VExuV1RVdUYwM0NacXB1THFxd1pGUkJyeXZG?=
 =?utf-8?B?ZnJpekp5aERybWw0SmhZdWo3YzFlME42WnQxMUpibENxTVZya1NnZzk2T29q?=
 =?utf-8?B?UjJOaDNyVktOR1N6dXNXZkQ4OEVJT0g1dXJrM1I4cUVoRzZ1QnZ6TWN4dStP?=
 =?utf-8?B?MnN4Y2VUWGN4SGl6MjRzZWUxKy80bTFCOFdPZGJuTXpPQm5MSGZqejFCaFA3?=
 =?utf-8?B?ZmUxUHdmWVZuSi9USkxCK0FNUkVCSmVEb3VaZFR0QzQ0VTVpRnp1NEE0YThQ?=
 =?utf-8?B?S1o4QVFsRGt5SS9iNFFlRnUvNFNnazdZUllOY0E4dEdyVGJXQzBGZXRyK2tZ?=
 =?utf-8?B?bElLQ2Z1aWJ2bEEraGxzaDByeXFYcndOSjYxKy8xSDl2VEdEc2Nja3l3Tmlk?=
 =?utf-8?B?YWhJaitqYjFaQitQbEFhcitzcTdtZDFIMWtlbkQ4MUNvRHpNMStSTTUrdERC?=
 =?utf-8?B?THFtV3JudzZqSGJpbXg3ZUUvZ0w4WGYvbXJMdUpOWTRzZEtwVnZaTUFuTmcw?=
 =?utf-8?B?bHVyUkxpWnU2Z1dPT1h6dzB0ZDVGVHJwUk9VOGltbDRJaWZpbnVYR1FtOUNB?=
 =?utf-8?B?NTA4Zk04L3QyY29uK2FjdXBZNDlrTmRwOGE2cmNjakQ0d3JLMittWTdCT2cw?=
 =?utf-8?B?ZVU1UFdpTk1MMURHZGM2Y0hlNmdNeHZqa3p1WlRaK3RveXBrbzdBR3B4NHZr?=
 =?utf-8?B?RnRXTGsva1VGNVJuNWFDUDFVREcrSWhzenozSTBXZi9HcnFXRXZyTnI0TCtW?=
 =?utf-8?B?NnVYc29Sak53Yjc3WGFzSCsxT1V4aHphVVhXZUo2ZGZDT0VMdkdzcDd2c0pY?=
 =?utf-8?B?eU5XK3BBNU10V2Uzc1BtTUxoRmNqYkhtUWk0bjQxTSt3SlA5NFd4VXVUZWM2?=
 =?utf-8?B?MnV0bUlwN2dBc1lqbkRtTFY5Z2g0RVZ3NnVlUityejluZlBSN0dXaVFKcng0?=
 =?utf-8?B?c04yVTBkL2w2dEpVdmZWdHNkVkxZRUlBTUtEZ1hyUVdBQ3dib0Zha1FoUnls?=
 =?utf-8?B?WXNvSUlPQXN5T29YVlVtc0MwOS8xSC8reUliRW5jSUQzYitqYnppSDE1ajRC?=
 =?utf-8?B?MkU3K0NKaTBFSkpvaWVYSmVsTWpXb2M1WEljdjdUYURkV29jYzdUa3ZScTZy?=
 =?utf-8?B?ZTZvNERSempvdmlyOEFWK3NKT0wyMm5zQ0hwRmxGOURVNks5N2pHOTc0ZnRz?=
 =?utf-8?B?NGduOS9tN2R1TDM0K0dCcG5sa1lxNGgyUk1jVy9WRnRlQVdzWW83VExqK2xB?=
 =?utf-8?B?bmFlNUF5aFdXam5pNUdGbGRNWlV0eld3dzFDdFg3N1VZTFI1QUxUOEpQU2Vl?=
 =?utf-8?B?TTRhVVJlVUJpTDBNQ1pubVpUU2Yxd21NRkNnd3dVRy9LR3pSY2x0VEpxeW9H?=
 =?utf-8?B?QzByZUFoOEJoRVhLQjg3a2FncitBMWt3aWlDWFpFeCt3Zkt5MERoL0dFNGpT?=
 =?utf-8?B?QlBvOW5pZmdoN1VzZ1I1U0E2K3dBbFlmWU1lNGo3bkNQQ1B3akQ5YlBNN3RX?=
 =?utf-8?B?UXVVdHdOMm9NdmdMczFqeVBXNmNCNjZVTVAxZTdLQ1I3ekIxdmg3R3AyMHh3?=
 =?utf-8?B?a3E5Y1l5R3JUdWxlS0d1MGFZdUpyczJFVlA4enRGUm5HY2NocTR4MFNkYUhJ?=
 =?utf-8?B?WXY0Nzl6WWRCUHhOdEpPelFxUUMrVW42akJNUVExY05YY0J0ek0vNkNyZi9H?=
 =?utf-8?B?amxkVk1HSktzTkYxa3Z5aXRxMjE2TjNMd3daeFlqZEV2amRzdGh0RGxrUlRz?=
 =?utf-8?B?K2dsSThkTVR1ZEd5ZEVCK0xhUEhLaDRZelZQdTlRbk5xR1hXRXB4aGhCaDZm?=
 =?utf-8?Q?zqM5blnFGbk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7639.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eWpLd2JCNTYzTEJHa3RiWGJWL29QaGZYZlNRRzlQYnZXdjAvVG5yZ05tN2x5?=
 =?utf-8?B?ZWtib3ViMHdiWXZoVEF6ZHQ0WDdNeFBFTDBDSTJVakZETU5NdVN4VHYwZXRU?=
 =?utf-8?B?RmpnWkk4ZnNKTUZudlllQnQ1TTIwWTdmMXhkQ3lFajJJcXdLeHZCUVoyMlkv?=
 =?utf-8?B?Vzk4SFg2QThOZjU1ZHJ0VlUzRm5VVThSRktSY0l3YUJxbWZjdmU0MGgvTURx?=
 =?utf-8?B?b0JkVG8xbXdCbWczajRaR2ZzT29hbWZ0OVAzamNJNmJoU3ZoNDVWMnhSSk0r?=
 =?utf-8?B?UnloU3piTUM0YXh2aFNIMi9qZ0VNZEtZUGxDS0Z0ZVd4WlhYTmo4QzNUTzVq?=
 =?utf-8?B?M0RMKzIvcktSajRxRTRERUthczNRbjkxU21aWDJPekRHczlTQllwRndBMVM1?=
 =?utf-8?B?ZGd3R1JxRklWZmIrelRDbEhXODZsL3kwcEM3VytJYmtDczZFNHllOW95TFRR?=
 =?utf-8?B?ajc2cGFqZUJaU3MyYU80dU5Ka1FzWkQzb3dzTUdieC9GZjFDeXIweXFXb2RI?=
 =?utf-8?B?eGQ3Q3RHN09mSVJNV0dMR2ZDV2V1ZzZrdUxqMEdMS1ZNSnZYUDZzVlJhZXdI?=
 =?utf-8?B?bWJQd0ppeXUyUC9GRkJiTUhMSzg1LzNnMWhwa1hNQVdmZW9wZHlRVzRvNU1G?=
 =?utf-8?B?TDE0eWgxZ2xBaERIUnJpT2ZDS0RNTlZvZDRKVW5wRGl6aldKOHhmODI4d1Bm?=
 =?utf-8?B?bEZsTEJwK2kyUHNBM05LbVpXOWJRb2xqS2NCbnhqc2tqOUQ4YkNZeGg0R0s5?=
 =?utf-8?B?aHhSWWxGY1FjQUtEajFUVHVTNm0wQldvNWxwOUEwOHZ1bVBpTE5FZGhBQW5X?=
 =?utf-8?B?dE1iVjVha1RKUEFvQ25wMVp0R2w2QldVTFJmYVA1VFlzay91N1prSExobjNa?=
 =?utf-8?B?ZDlHMnF0b3l5L01UKzNDelhKeUxZU2JQWXlNaWZ3N3BJL0lrUWd5Z3ZBdTBi?=
 =?utf-8?B?Y1VuWkUreFNreVdFQVQ5RkpUMU11Qk5aSmNLV1BSeUFEbWVmQ1U1cWlUSVZn?=
 =?utf-8?B?RTZuQlRjY2ZBRG5lRU9Bd3RhODJtSVAveDVNZVkzOFQzd2VJd0w0bnNPdjV4?=
 =?utf-8?B?VTRJZjA5WmVXYXFrN3dFS1JJYmlNQ2kwMzg5V0loa1h3Wmo4dWlGbVlUUnhU?=
 =?utf-8?B?c1BEVDgvOGVOZ3lUaHFTOE4zck1zTWpEeUtVUjViek5ZLzJBU1hXNTRHeHJo?=
 =?utf-8?B?dUU4UjZkTGRVcGRUZ3N1L3RVM1ZzaXUrOE5lS0ZtbS9QZ0ZSU2VTQ3VVU0ZL?=
 =?utf-8?B?cHFnYWFpREZwZWJKM0RCU0lvc2dHTjI4MDZpb0RYS2VaZ09iSnZMRXJyZVo2?=
 =?utf-8?B?ZVFGMVNXUnJJeTRQL05oNUo2Y2d3dXZuUUo5ZjNtN2RUTTNIV0RodFZlWkRj?=
 =?utf-8?B?ejhuODBUcEhibGZtVU11TGpnUzNUUHVhc3VYY1czTlhrTFpSSjZRQnpTeXdN?=
 =?utf-8?B?NjZEbmNPRzQ3c21SWXVzbDNUbFltaWFoZjVxQ1VpSEl1ZGhOSGV2cSsxWHZ6?=
 =?utf-8?B?YmF4MzVscm95T1MxUm9lSWRBQkVvSGxDUjJPWmNyRFVwL0RmRE05aWtyeHNC?=
 =?utf-8?B?cDMrVndSeWpUMnlHQTdFMGFhSnFxYTh5MUZyMnMrSGY0MDdJcDNNeDVVMVd3?=
 =?utf-8?B?aVkwYk9CNHpDL21NdjJCSlNHbDFJRHErVW9KYk80SHhQeFRranVaTHlKZjhm?=
 =?utf-8?B?OCtvajJFdmF5VTVZMWZ5MVhhTUNNczNVZmZLOU9mUVJmUlF3ck15OHRkcFhS?=
 =?utf-8?B?QVYvMUxUYmVHZmhNTDNrVlllSkVmekpOd0Z2OCsxVzBhYjZZditvd2ZGWjh0?=
 =?utf-8?B?b3JpN0s2YXdYOEJNK1R3YVdCVzlFdWQ1alpKZ25SdllFcCtzbVhnN0dpVDNo?=
 =?utf-8?B?SFBOcmZ5a25nNHY4UlN0bXJaR0hqRTJvRmVyU1dzbFFYVExZUElqSTBsZTB3?=
 =?utf-8?B?NjMyZnRvRzMxek05Z09aSWFzMURCaXEzRXlLaklIQ3ZiYVlSOXBtUWhIR3Mr?=
 =?utf-8?B?QXJZclpQeWlmT0NCWXFTK2lJRFh4Yy9CaVVFV0phcC8wVlBHVkl1VjFLaTlV?=
 =?utf-8?B?ZFFhYTBaREZuVFUxOEYzYTJTQmwySGxsR0o4SVVmSFRxb08zNHd5ekhmMk1O?=
 =?utf-8?Q?tSojCfFL2PurJFKDmyHkkIP5J?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	xApKe5Jmuai2uFUTj/DG9TBOFCgW57BBn0Z5P7mDLRJlRfa4YaBn4F34Z6AcwDqaayDF8hBCZvt7rb/pHf2iGVZ/0jKzKSxhXkWqR7G3IjO4Q3d1hv76vbcFZjQQ8uvz8ONZfgnaodDjh/itM209IFxsyP2planUZS0IMlwMjrBDmLtq8pnwlIU7uQw/rbUmQEVNO//J/UQ91QtaIS3TaJO1eepsS9OzA+vhuVFpQyCgjDSpQwXDywZsFixDqOuXtFIKaUox6nJl96gQJO7pX66fEqv5q+atTIoaVdgGJS7czvPKFHQtxZAQ6JM7tLvscAURJm6vX+LYXzQNzOvjI22s3RyOu1eBOQShNGvixliVaUm54kve5s1wXq/3mcqfokekft3FLHjy8tuZwyDtDcvRNShHI8yB7i2c0/i0l+EpthBsddrbOxhTzveFdoKd7K1Dt5p0K+qVz/eX4TThgoE3BSnSD8qINcibmi8aVUN0xUpH9FNyV4rOHtGGGOH7nruLxYG91C9r+4EwgeORUp6oIawwarjJzs5CSmbYsewCjYmmkZ5e7lSm1o5tYEiDBbAe6lcY5fBM3aNyB6NjZIi9vAKBqk4LfS6mgYeNCXI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5853a4eb-29c5-497e-bd6e-08ddd44d81b0
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7639.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 18:25:51.1334
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZyXX9GdFDIX/i503Y/Cy97EWX9Y9dssmfoO5uLQEWD6iRXey52D3lcX9bOneOGKFIcfgVN8VXMGZcBLzPozjzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7537
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-05_04,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 mlxscore=0
 phishscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2507300000
 definitions=main-2508050129
X-Proofpoint-ORIG-GUID: WsJUu7fyELpigmD1_zhBxT-hOfDIQGNo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA1MDEzMCBTYWx0ZWRfXy5b32j+R2XzK
 W0Mb3UBnWLbR3oEj2kcraoxpONixF9kyABkVI8ipUEF2CrBzU2ml0Y9W/sFFShu/LZbAdvSFYtv
 kdT2BQVWVlY4ElGu7/VYxThiKrvTSKMK/qjlow1BYB0cjWooQq+K6zQwHAiQSDhK9DMaYdyepJg
 aCc6IxLdOmuwRiEvjHCoKUYJJe2tVpn4ZGDcVhh21VPQ6hjUHouxhoEJMAeqApdJ9unHI/OWVGk
 Fpj0iYgLcTOUdf5BorDA9wNpiXtBgJ5936pVY77GmeXF1aCJH2CkshitGXxKS22cNUqFK3ypiid
 KffglZ4ZW3nCvpogtiunB4moIr8EvyTgouBt/Q85zHkfF17uoeWlf274pcGU1FxAQ9OgxdE1stq
 uQxISYvNE5XTQCAruC97axXYRQq0zTzs3j+Z7dukF9vIafEFSRyBt8R6GqZoXHkDIR62TI4A
X-Authority-Analysis: v=2.4 cv=dobbC0g4 c=1 sm=1 tr=0 ts=68924cc1 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=VRAhVXgp6rh1mnT0RIkA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=e10fF4DqEehlLX_lK1wm:22
X-Proofpoint-GUID: WsJUu7fyELpigmD1_zhBxT-hOfDIQGNo


On 8/5/25 10:41 AM, Trond Myklebust wrote:
> On Tue, 2025-08-05 at 10:07 -0700, Dai Ngo wrote:
>> On 8/5/25 9:41 AM, Trond Myklebust wrote:
>>> On Tue, 2025-08-05 at 08:46 -0700, Dai Ngo wrote:
>>>> On 8/4/25 4:55 PM, Trond Myklebust wrote:
>>>>> On Mon, 2025-08-04 at 13:13 -0700, Dai Ngo wrote:
>>>>>> On 8/4/25 12:21 PM, Trond Myklebust wrote:
>>>>>>> On Mon, 2025-08-04 at 12:08 -0700, Dai Ngo wrote:
>>>>>>>> Currently, when an RPC connection times out during the
>>>>>>>> connect
>>>>>>>> phase,
>>>>>>>> the task is retried by placing it back on the pending
>>>>>>>> queue
>>>>>>>> and
>>>>>>>> waiting
>>>>>>>> again. In some cases, the timeout occurs because TCP is
>>>>>>>> unable to
>>>>>>>> send
>>>>>>>> the SYN packet. This situation most often arises on bare
>>>>>>>> metal
>>>>>>>> systems
>>>>>>>> at boot time, when the NFS mount is attempted while the
>>>>>>>> network
>>>>>>>> link
>>>>>>>> appears to be up but is not yet stable.
>>>>>>>>
>>>>>>>> This patch addresses the issue by updating
>>>>>>>> call_connect_status to
>>>>>>>> destroy
>>>>>>>> the transport on ETIMEDOUT error before retrying the
>>>>>>>> connection.
>>>>>>>> This
>>>>>>>> ensures that subsequent connection attempts use a fresh
>>>>>>>> transport,
>>>>>>>> reducing the likelihood of repeated failures due to
>>>>>>>> lingering
>>>>>>>> network
>>>>>>>> issues.
>>>>>>>>
>>>>>>>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>>>>>>>> ---
>>>>>>>>      net/sunrpc/clnt.c | 2 +-
>>>>>>>>      1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>>>
>>>>>>>> diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
>>>>>>>> index 21426c3049d3..701b742750c5 100644
>>>>>>>> --- a/net/sunrpc/clnt.c
>>>>>>>> +++ b/net/sunrpc/clnt.c
>>>>>>>> @@ -2215,6 +2215,7 @@ call_connect_status(struct rpc_task
>>>>>>>> *task)
>>>>>>>>      	case -EHOSTUNREACH:
>>>>>>>>      	case -EPIPE:
>>>>>>>>      	case -EPROTO:
>>>>>>>> +	case -ETIMEDOUT:
>>>>>>>>      		xprt_conditional_disconnect(task-
>>>>>>>>> tk_rqstp-
>>>>>>>>> rq_xprt,
>>>>>>>>      					    task-
>>>>>>>>> tk_rqstp-
>>>>>>>>> rq_connect_cookie);
>>>>>>>>      		if (RPC_IS_SOFTCONN(task))
>>>>>>>> @@ -2225,7 +2226,6 @@ call_connect_status(struct rpc_task
>>>>>>>> *task)
>>>>>>>>      	case -EADDRINUSE:
>>>>>>>>      	case -ENOTCONN:
>>>>>>>>      	case -EAGAIN:
>>>>>>>> -	case -ETIMEDOUT:
>>>>>>>>      		if (!(task->tk_flags &
>>>>>>>> RPC_TASK_NO_ROUND_ROBIN)
>>>>>>>> &&
>>>>>>>>      		    (task->tk_flags & RPC_TASK_MOVEABLE)
>>>>>>>> &&
>>>>>>>>      		    test_bit(XPRT_REMOVE, &xprt->state))
>>>>>>>> {
>>>>>>> Why is this needed? The ETIMEDOUT is supposed to be a task
>>>>>>> level
>>>>>>> error,
>>>>>>> not a connection level thing.
>>>>>> If TCP was not able to sent the SYN out on due to the
>>>>>> transient
>>>>>> error
>>>>>> with the link status and the task just turns around a wait
>>>>>> again,
>>>>>> since
>>>>>> TCP does not retry the SYN, eventually systemd times out and
>>>>>> stops
>>>>>> the
>>>>>> mount.
>>>>>>
>>>>>>
>>>>>> Below is the snippet from the system log with rpcdebug
>>>>>> enabled:
>>>>>>
>>>>>>
>>>>>> Jun 20 10:23:01 qa-i360-odi03 kernel: i40e 0000:98:00.0 eth1:
>>>>>> NIC
>>>>>> Link is Up, 10 Gbps Full Duplex, Flow Control: None
>>>>>> Jun 20 10:23:09 qa-i360-odi03 NetworkManager[1511]: <info>
>>>>>> [1750414989.6033] manager: startup complete
>>>>>>
>>>>>> ... <NFS mount starts>
>>>>>> Jun 20 10:23:09 qa-i360-odi03 systemd[1]: Mounting /odi...
>>>>>> ...
>>>>>> Jun 20 10:23:09 qa-i360-odi03 kernel: RPC:     1 added to
>>>>>> queue
>>>>>> 0000000093f481cd "xprt_pending"
>>>>>> Jun 20 10:23:09 qa-i360-odi03 kernel: RPC:     1 setting
>>>>>> alarm
>>>>>> for
>>>>>> 60000 ms
>>>>>>
>>>>>> ... <link status down & up>
>>>>>> Jun 20 10:23:10 qa-i360-odi03 kernel: tg3 0000:04:00.0 em1:
>>>>>> Link
>>>>>> is
>>>>>> up at 1000 Mbps, full duplex
>>>>>> Jun 20 10:23:10 qa-i360-odi03 NetworkManager[1511]: <info>
>>>>>> [1750414990.6359] device (em1): state change: disconnected ->
>>>>>> prepare
>>>>>> (reason 'none', sys-iface-state: 'managed')
>>>>>> Jun 20 10:23:10 qa-i360-odi03 NetworkManager[1511]: <info>
>>>>>> [1750414990.6361] device (em1): state change: prepare ->
>>>>>> config
>>>>>> (reason 'none', sys-iface-state: 'managed')
>>>>>> Jun 20 10:23:10 qa-i360-odi03 NetworkManager[1511]: <info>
>>>>>> [1750414990.6364] device (em1): state change: config -> ip-
>>>>>> config
>>>>>> (reason 'none', sys-iface-state: 'managed')
>>>>>> Jun 20 10:23:10 qa-i360-odi03 NetworkManager[1511]: <info>
>>>>>> [1750414990.6383] device (em1): Activation: successful,
>>>>>> device
>>>>>> activated.
>>>>>>
>>>>>> ... <connect timed out>
>>>>>> Jun 20 10:24:11 qa-i360-odi03 kernel: RPC:     1 timeout
>>>>>> Jun 20 10:24:11 qa-i360-odi03 kernel: RPC:     1
>>>>>> __rpc_wake_up_task
>>>>>> (now 4294742016)
>>>>>> Jun 20 10:24:11 qa-i360-odi03 kernel: RPC:     1 disabling
>>>>>> timer
>>>>>> Jun 20 10:24:11 qa-i360-odi03 kernel: RPC:     1 removed from
>>>>>> queue
>>>>>> 0000000093f481cd "xprt_pending"
>>>>>> Jun 20 10:24:11 qa-i360-odi03 kernel: RPC:     1
>>>>>> call_connect_status
>>>>>> (status -110)
>>>>>>
>>>>>> ... <wait again>
>>>>>> Jun 20 10:24:11 qa-i360-odi03 kernel: RPC:     1
>>>>>> sleep_on(queue
>>>>>> "xprt_pending" time 4294742016)
>>>>>> Jun 20 10:24:11 qa-i360-odi03 kernel: RPC:     1 added to
>>>>>> queue
>>>>>> 0000000093f481cd "xprt_pending"
>>>>>>
>>>>>> ... <systemd timed out>
>>>>>> Jun 20 10:24:39 qa-i360-odi03 systemd[1]: odi.mount: Mounting
>>>>>> timed
>>>>>> out. Terminating.
>>>>>>
>>>>>> Jun 20 10:24:39 qa-i360-odi03 kernel: RPC:     1 got signal
>>>>>> Jun 20 10:24:39 qa-i360-odi03 kernel: RPC:     1
>>>>>> __rpc_wake_up_task
>>>>>> (now 4294770229)
>>>>>> Jun 20 10:24:39 qa-i360-odi03 kernel: RPC:     1 disabling
>>>>>> timer
>>>>>> Jun 20 10:24:39 qa-i360-odi03 kernel: RPC:     1 removed from
>>>>>> queue
>>>>>> 0000000093f481cd "xprt_pending"
>>>>>>
>>>>>> Jun 20 10:24:39 qa-i360-odi03 kernel: <-- nfs4_try_mount() =
>>>>>> -512
>>>>>> [error]
>>>>>> Jun 20 10:24:39 qa-i360-odi03 systemd[1]: odi.mount: Mount
>>>>>> process
>>>>>> exited, code=killed status=15
>>>>>> Jun 20 10:24:39 qa-i360-odi03 systemd[1]: odi.mount: Failed
>>>>>> with
>>>>>> result 'timeout'.
>>>>>>
>>>>>> This patch forces TCP to send the SYN on ETIMEDOUT error.
>>>>>>
>>>>> Something is very wrong here...
>>>>>
>>>>> If this patch is correct, and the call to
>>>>> xprt_conditional_disconnect()
>>>>> does indeed cause the socket to close, then something must have
>>>>> bumped
>>>>> xprt->connect_cookie.
>>>> I'm a little confused here, xprt_conditional_disconnect only
>>>> closes
>>>> the
>>>> socket if the connect cookie is still the same:
>>>>
>>>>            if (cookie != xprt->connect_cookie)
>>>>                    goto out;
>>>>
>>>> So in this case the xprt->connect_cookie has not been bumped.
>>> You're right... Sorry...
>>>
>>> So does this mean that the socket is still in the SYN-SENT state?
>>> It is
>>> normally supposed to remain in that state for 60 seconds, and
>>> resend
>>> SYN using an exponential back off.
>> Apparently this was not done by TCP in this scenario:
>>
>> ... mount starts
>> Jun 20 10:23:09 qa-i360-odi03 systemd[1]: Mounting /odi...
>> Jun 20 10:23:09 qa-i360-odi03 kernel: RPC:     1 added to queue
>> 0000000093f481cd "xprt_pending"
>>
>> Jun 20 10:23:10 qa-i360-odi03 NetworkManager[1511]: <info>
>> [1750414990.6383] device (em1): Activation: successful, device
>> activated.
>>
>> ... RPC task timed out on connect after 62 secs.  Note that at this
>> time the network link status was already up for more than 60 secs
>> Jun 20 10:24:11 qa-i360-odi03 kernel: RPC:     1 timeout
>> Jun 20 10:24:11 qa-i360-odi03 kernel: RPC:     1 __rpc_wake_up_task
>> (now 4294742016)
>>
>> ... RPC task goes back and wait again.
>> Jun 20 10:24:11 qa-i360-odi03 kernel: RPC:     1 sleep_on(queue
>> "xprt_pending" time 4294742016)
>> Jun 20 10:24:11 qa-i360-odi03 kernel: RPC:     1 added to queue
>> 0000000093f481cd "xprt_pending"
>>
>> ... nothing happened and systemd timed out after 90 secs and kill the
>> mount
>> Jun 20 10:24:39 qa-i360-odi03 systemd[1]: odi.mount: Mounting timed
>> out. Terminating.
>> Jun 20 10:24:39 qa-i360-odi03 kernel: <-- nfs4_try_mount() = -512
>> [error]
>> Jun 20 10:24:39 qa-i360-odi03 systemd[1]: odi.mount: Mount process
>> exited, code=killed status=15
>> Jun 20 10:24:39 qa-i360-odi03 systemd[1]: odi.mount: Failed with
>> result 'timeout'.
>>
>> I don't know why TCP does not retry the SYN after the networkk link
>> is
>> up again but I though instead of trying to figure out and fix the
>> problem
>> at TCP layer, we can make the RPC connect process a bit more robust
>> by using
>> a new socket for retry.
>>
> We should never be using individual RPC message timeouts as a measure
> for whether or not the TCP connection is down.
>
> For the initial connection attempt, we use the TCP_SYNCNT socket option
> to decide when to give up.

The problem we're having is the initial connection attempt at boot time,
NFS mount started while the network link has been stable yet. NetworkManager
could also be blamed here, it claims 'startup complete' which allows
systemd to start the NFS mounts.

And for some reasons TCP did not send the SYN under this flaky link condition,
even after the network link is up again; we don't see any SYN in the network
trace. The TCP_SYNCNT option is not in play here.

This seems like a bug in the TCP/network layer and it seems to me that
you prefer to push the responsibility to resolve this problem down to
TCP/network stack.

This problem is reproducible, do you want to collect any additional data
before making the final decision?

-Dai

>   Once the connection is established, we set
> TCP_USER_TIMEOUT as well as socket keepalive to ensure that the
> connection is still alive.
>
> I'm willing to consider further socket-specific timers, but not if the
> reason is to work around bugs (assuming that is indeed the case here).
>

