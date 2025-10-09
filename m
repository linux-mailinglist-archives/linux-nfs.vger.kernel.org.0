Return-Path: <linux-nfs+bounces-15092-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9017ABC9AE2
	for <lists+linux-nfs@lfdr.de>; Thu, 09 Oct 2025 17:04:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 726454E42FC
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Oct 2025 15:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD1CA2EBBAD;
	Thu,  9 Oct 2025 15:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Sd0ktzYF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="EKcHcX5W"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF242E8DF0;
	Thu,  9 Oct 2025 15:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760022257; cv=fail; b=MZZnx3Z+ubs7xcNpvKT4SW4ONm1R/WZd4nx1brBU37PgZjK5XOTqt0PiAe5xQZGcwZ9xczN6h+sutAcX22gnLBgcgXvF6UMvQBa9L3mlhLpkDmH/vzs+PlrszEKKO0HdtnGgJQ451dhsoHCg1lQ0pmhaWWfNvZ9lJPPVW7pTmZA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760022257; c=relaxed/simple;
	bh=dEoxsF3F5r78lNNFUuz2Ptw4Lrj2yICFBXewPPoaBwg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QnkwJJqTiJX6ABNZEGggU6nftXTdITMrI82Q4KzVPIi+rvmaHwc4I/3mf5qsdPCP2hP+FZM60WrwXr044LFnbVdG/AimJYUQnoBmtlai1njzoX0kpvQvPFoFco8ZQ7r4ZEmy8M2DU1+KhHcCrTQsbWYJEoa/7HAcT0gTBI12/YY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Sd0ktzYF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=EKcHcX5W; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 599EtlSk007039;
	Thu, 9 Oct 2025 15:04:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=9hNgi2jb5c1VsW7Vk7AGr6/YEIgbScrK3W5V2dagkNU=; b=
	Sd0ktzYF9Zh73x9a3nE+WFX7vOkkKcfld6cd8DNh34CpQvoAU920KhlvC71UtXfM
	j1lxeY+7n3RH3nCA2QquMbeyFAc7YboGQwodu3DpU1dt5E5SV97pB05o2nbkb3VK
	StBDOer8+afWMV0uyF9JykbMrGlalZ4CArmRKMPibNJcsHQ/DkqrzHSnFpaoNJU6
	RHOkpQFUyVQflIn7Iq+Q7JEw0E7VWgO6aEbIHPhsfi7WH36EOddMNKd1C+P9EmE5
	Gjw10FF8vYpCXEwP780BV7Tgwsu3ndzhblnESGoVNZwVcX/C7Yy1sXLIR6rHnEdi
	AcKXAxRLrLrLYJJ0N+0Xmg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49nv69stn8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 09 Oct 2025 15:04:01 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 599DgM1L037136;
	Thu, 9 Oct 2025 15:04:00 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011059.outbound.protection.outlook.com [40.93.194.59])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49nv641rjv-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 09 Oct 2025 15:04:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CtfNa0X5OIHKc8iTgbzmzgZh0D87hQBn7B3UVVu1SbmoumsEE3mwspnWq65/a3fPn1jg3xBY5iwyZKEuBCOFp30uS++rgizhalMSpBcqLWVNRPai+4KQ4xJiddS9oOtXJhA6tWZhTq7maCwGbgacgVo81lyN9eCt8aWe9rUR9TFMN7+RBfbUXejLlpE6uqD1XbS12mMvVh2sDeCPUogib3degWTz105KUFWWuuBuS3QBDdX/jAkCLptasSb5rTiQprWFbasQQdFi40hwutYMusY+MdbCFj42Ey01vK6NuVI/RIzaumkrsFwNHohxQG81rmCoZaGz86fI8BlF9j7EBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9hNgi2jb5c1VsW7Vk7AGr6/YEIgbScrK3W5V2dagkNU=;
 b=kaxC4eRgD3D0JrIHspW6jT5Fd2K2TcP9ZjqzxFcrheWhIx4Mlmcx2HKThaWOuFZj7GApARvapKSGmg0TxDto5pGhlXQpKb4kg0ktbwBESR/v8z/KqtETNOxI5+JMOBKTmgZ5YIhfh7RZGdsFgWx6DpYawqtSIe1pl8okm3AWlqC8GgBvP9rkOvKp9irATHq+uxnHiC9PBKevYEuhjkAeb5BDidjaoWr47FWhNbyTuqFBMov7IFy7mdl02eatFKw00DPXUA0VlOSB1Gq+Dn+lL96LcVsnq078B/fvW7XC3uDOrm/aorLTsoJeLo+4tiUkbc4Vf6H+8QA+F14Cfc9OBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9hNgi2jb5c1VsW7Vk7AGr6/YEIgbScrK3W5V2dagkNU=;
 b=EKcHcX5W8QbC9/JEltuixaimNR061AntdPwZIdphDaq/aIbePKqT+320sC+57djjxHp24IZchzlX1mH3vFfu1wWWi/158JxeFOBBQwkgVqek5Yt4OkRXRsuevoWBtBxl8n0SdqD3K56kyXZW4tuev28x2nqmu2obFdFzwrxVwPM=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM4PR10MB8220.namprd10.prod.outlook.com (2603:10b6:8:1cc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Thu, 9 Oct
 2025 15:03:57 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.9203.007; Thu, 9 Oct 2025
 15:03:57 +0000
Message-ID: <56718ad5-fdb3-4588-bab9-7b9a1879cad0@oracle.com>
Date: Thu, 9 Oct 2025 11:03:55 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] sunrpc: add a slot to rqstp->rq_bvec for TCP
 record marker
To: Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>,
        Anna Schumaker <anna@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        David Howells <dhowells@redhat.com>
Cc: Brandon Adams <brandona@meta.com>, linux-nfs@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251009-rq_bvec-v3-0-57181360b9cb@kernel.org>
 <20251009-rq_bvec-v3-2-57181360b9cb@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20251009-rq_bvec-v3-2-57181360b9cb@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0360.namprd03.prod.outlook.com
 (2603:10b6:408:f6::35) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DM4PR10MB8220:EE_
X-MS-Office365-Filtering-Correlation-Id: c31c6cb8-0a27-4f4b-0c1d-08de074511de
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|1800799024|376014|366016|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?b3FVQjVOUXlYQTBqVDludlppS1JlOVpUV0U0SkgzRkVBblM0YUYvN3g3NCtn?=
 =?utf-8?B?eUJaWXB3RWVGc2RzYm5HZERMMWhyNmN1bmphSGZST1FiQjdIdXJQUzdWNlRT?=
 =?utf-8?B?dmRKZE1IaXZGcTRMWnVvS3MxME4zVEhIYzR1bzFodUtQRjFjQzdZVzJjSmRl?=
 =?utf-8?B?V3IwN2tESDltNVRwYlVXdFR6bGxSTDRxNStESGZzcFg0SkpJL2RSTUEraFJW?=
 =?utf-8?B?Tm9GYW94bWwrZnI0RCtpOG1iNWJXckRiT3lqWTBkdlNpNkEvb1F6KzF6TFU0?=
 =?utf-8?B?aHZscm15dDVWV0QzeHU4SmNYSGV3NDI4WG45OUZrNHdXaCttYjBLWlB6ZEc3?=
 =?utf-8?B?aWJtd25tbkgrdkJvOWlnNmQvYjZyVGtYU2QzRXJmNkxhb3ZSSkxPVDZvZVZx?=
 =?utf-8?B?OEJpQzVpVFl3LzdsMjcwc0JuQmtNcmU2RmdIVjl6Q2xOb2lIMm02dkJEaldR?=
 =?utf-8?B?RjQ5djJBKzBValFoSnRCVHFSbTBFVFZrbFJzU2hDZmJOUEdsNWFOalZYc3dk?=
 =?utf-8?B?SldsUlNEU0hqckI2TFRFZi95aGhyWGRta1FmWTVnZU1vVkNWalE1WjNDV3FY?=
 =?utf-8?B?c2g0Q2IyTlNkNXNNbzhmdGFMYmw3OWJHbGREeVpuTFpLdFB2Q29hcjdOeFVB?=
 =?utf-8?B?d0Z1M0N6TStIMUxqTjdObklGb1lKZ3JCY0J3SU9wWHc4S0lQSUZUNWlEVmVj?=
 =?utf-8?B?K09WQTNBdW84TVZ0eElrYXpIdlR5dTdncTNML2tSN0xOQ3ZQYWE0UnBHTDdK?=
 =?utf-8?B?ZVN0NUN5aTVRa0JsdEN6Wk1qMU1GZDIxL0pTV1RYRTl2cEtzNzJaTVpBZDlx?=
 =?utf-8?B?TlhyUHZsRWdBV2FmWjFKeW0wQkN0WXF4Um5wNmQyM0xobTFEaFZrMTl4QXFM?=
 =?utf-8?B?a3VpVVMyV3ppcDRNV2FneGtVNHNvbHJTcm9ZYWFtTXZ5ZThsS3N2TWwwdUZ5?=
 =?utf-8?B?T0pJUEJ1cDVMdk1adTN5VjJveXZHY0VQd1FUOUt6VGZUNHhGU0VCZU9Bak1E?=
 =?utf-8?B?OHRnczNKUFZLMlU4dFFFWHVIbENBNmpvVnNubmtHQVBTL1pneUN6b0FxRnZ1?=
 =?utf-8?B?YXgzTkt2TWhZcHZNWXY4STJvakhPN1oyaFJqSW5UaWFVWlBnN2lDelRJRit2?=
 =?utf-8?B?blc3TFJyd09IK0dueDFRa1h1a3FWUHVjbnZUQy91WnBqVG9QUXYzNEllZDJx?=
 =?utf-8?B?WHFMWnh2MktZSjZXaWMrRGFCb2tQTFpHMFBhNkNRYmswcmtLb1N6QkNpSGh1?=
 =?utf-8?B?UFBjSVZsZjFTejNDZkdqeGRkK0Z0anNFb0NkWnVWOFZwNGtLRDV4YkplODVn?=
 =?utf-8?B?aVhEb0Z3VUE2K29NRlJGd2M3aWptY0xNRlJROWx4Z0lHSzVlQlM1V0g3Smkz?=
 =?utf-8?B?a1RlbXp2cGgzdG5MSEJ3UHk2enQrSU1IbGg0MFd6YUZlYUtMR2RGRjJEVzlO?=
 =?utf-8?B?Rktaem5HM010elJIZmNZbVV2WEhucE9wSlJOcW1PRHh2MGdnbUtqM3VZbHRR?=
 =?utf-8?B?bUl1RFFLT2RCdWUwSlZOYlNuODBYM3dpNkVtMTBHbTBRdzE0SUpJR1htQmg1?=
 =?utf-8?B?VDVFOW1CcFQrL3l5K1BUUTBLTmdlaUYxZ0IwSWw3L0lBNFRpUkZsSk9peDZU?=
 =?utf-8?B?VHZoTlllSXpOQU1xNmtCTUlURG1OS2xIM3IrNVQ0aGJrNlpyM3UzdEpmc0Zi?=
 =?utf-8?B?Q1kvOHllNDZDOTQwRFpzakMwL3dpa2FFM0Z3VWJmWmZXdTdQU2ZRMFRUS1pu?=
 =?utf-8?B?QXg3RCtpOGcrOHFqRTV1dDdmV09wWVg5amlvR0RUNllVSkU3Z2VwbzN5eVNR?=
 =?utf-8?B?a1RCZk8xeTJoUHFPZitvM2VJSmpsd3crMFpuZVdBeVh5VmoySysxR1RrWjZU?=
 =?utf-8?B?WTl4TXU1MGlodVJGaTEyRW1LZ3pXT0k4N0JoZEl6SncyTnoxb0doMURESjlM?=
 =?utf-8?B?TkdZY3VENmtXYzNEUytXS3FEOWpmbzA2OURib3k4VmMrUi9vL0xhRElXRnp4?=
 =?utf-8?Q?VKJLJi2yX0J1UNDXxG4cpxBuDrCOHU=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?czhuWUVpeS93WGM4WEpDTi9UbVprM0poalljQXBlNnFFeUgwcEwyTHRZY3Bx?=
 =?utf-8?B?KzB5WkRua2krckd1TDhCM3NPc0puUlh3aGJTWjBBUjJkckxkYytCQmVzbHFm?=
 =?utf-8?B?eDZwSG5JQ1RiRWwrRW5Db3h4SUsrSkF4ZUNxTkR2R1RKTXRndDl5T3ZVeXkw?=
 =?utf-8?B?U0JlTEpQaEoxemxDTDB1WWVWQlFCenNxWTJaOGY1NFlVaWcwSjJrcTFKSHRZ?=
 =?utf-8?B?THhRWnNQbXF0eVQ2R3FEczU0d0hBQXpDajlHUTRFNUQwbFc1Q3grSUR6NG5k?=
 =?utf-8?B?b1ovT1dXZDF2OWwvV3puZlhEZG9HUXVWV1pCNUkySjRpRWNKVlFCeDNQRW0y?=
 =?utf-8?B?cEVvQ25OUGZyYUt6MDNBWTYxck9RY3lJeXkyNDZYR29EVFFUUFVkUlE5ekRP?=
 =?utf-8?B?ViswQjQ5UWxUVVBHNiszUG9FTllKWFZTMytUN21pU0JoU2RZNWhYUFZPYTla?=
 =?utf-8?B?YStCL3JMak9yUXpqbTBzL0xIQkVLU2pIMVltZm54aUYyaXY5RzZpcDJUZWc4?=
 =?utf-8?B?TmVpSnU3YUIvdW52azhBOXFYUHdNcW1FRklTajNSMldRY0xyZzBQUVJCOU54?=
 =?utf-8?B?TEIwQnlXZkRCWkxUbXRmbnQ1NVJwdEVGbGRVUjF4NE1Wd2FKZXBWTVNZK3E0?=
 =?utf-8?B?Z2l0MHhyZmozRW5QbzNSMnRLeG01eDAyemlNNkkrYlNHV28wN2xZaTNka0k3?=
 =?utf-8?B?ekU2TTRCTDRDZzdCcy9IQzdSVlZLemJPam5yeVJpNTBZTnljOVo0bHVHOGJI?=
 =?utf-8?B?aDhtcE5MZWRPN0tKNjlDcUpkTFBDZUI1Vzl6dnVNUG84MWJJOXh3OGxCN0lK?=
 =?utf-8?B?b3ZLWURFcFYwWEYrcUYzMUtJV1poaWhsU1NpSExGWG1SUVRLUzgrZFBQNlpZ?=
 =?utf-8?B?dWxJQ1RQUDVWc3dIL1ZpZUExVldVTDJLVms5cmp5UjdjQTRka256K1NOelJw?=
 =?utf-8?B?WFBjME5FOWhKUjBiNjMreFFxSFZ5VVp0NnZBWThMVWRzMGZGMVI0L2ZtalA3?=
 =?utf-8?B?MkNpMTByTjRESHFBYVJvUFBmK0d1WFpXcHoycjlwNloreHJUejgvaGF3aElT?=
 =?utf-8?B?RU0xbXFFWEQ3UnJYcmcxWnMra0E1QUNBenNuMkpEUmdIR2NGc3hVOW5Eandp?=
 =?utf-8?B?ekt6MElYYXZIVDlLaEhiQ0g2L0F4eUZiZXVha2w3NmUzRmdqR2NoUVpaWHBy?=
 =?utf-8?B?aGk2RzJCaDJUWmhKejlvZmozZlo5VlFQRkNvN1o2NnF3UkIvbjRQbzduVXAr?=
 =?utf-8?B?UDYwcEFia25ROVhTQllkMUpoVlN2dW84MWZoUWVGU1FHRFVjZDVVVXNxRENM?=
 =?utf-8?B?cE8wQzUzcVAvUVord1paQVYzZmEwZUgzM24wVE12TS9CRWZFRHl6ZHA3RWhx?=
 =?utf-8?B?dGRLbkNkRXJlb3ovUHZmcDlSUmZ2dks1emRxakVCNWNYb21ZU3UwakpkeDly?=
 =?utf-8?B?UTJtNWFFNHlEN0JoVzdzNm14d0xna1FCSzR1Q0RiajhidkcvbHJxMWJIL1M2?=
 =?utf-8?B?NnpXSlpnQk94R1VWTDJZVS9FdTNocUZHR011NXNrOFcrK3NRUTZYNThYL3ZN?=
 =?utf-8?B?NVUvOWUycytjOTVsMXNJNndJWHVkNytYaGFrd3ZPK2xmdXJyRzRVV1ZpS0VH?=
 =?utf-8?B?WHVMbHN2WEIvcFd0RnBvK29HOUlKeURTMmdIMElZbmhmUUFKZmNrbGliUG1I?=
 =?utf-8?B?dHMwM2dTaDUyWitsMWhYKytOeUMyN1BYMk9ndFY5citvbVd3cllpL25MSXdW?=
 =?utf-8?B?ajR0WTl6eXJxNG5VVlAyRnBsKzBRL21qNkJTOUNhTFhVSUF0NlRtM2cwbi9u?=
 =?utf-8?B?ZFRtQmVjbytDVGc1eWpRUG5mVkhhSzFpL2dCVDdGbmFwMlRWR1IwcDlOYU8z?=
 =?utf-8?B?MHhCc1F4YkVMOTlEVFNEa0MrdFZoZ3ljY0ppVUN1TjdWZWVhYUpVZTFzVHRt?=
 =?utf-8?B?OHl6TEx1bjhsWkRpK01Lb1JKcWRjb3dTUElyc2NMM1dqTnFBY3lWSHlUUGl0?=
 =?utf-8?B?K29XSGlqaTE3TU9Cbi8rSEdDZTFhT2R4dmdMVG5OQ0VLUTRGd1lGWlU1SDVp?=
 =?utf-8?B?bTRjSzhNK2VzUndFSTBjcHZBZTZTd01VaEtvd1dLNEE4S0tLMVNUWXdOQ0dC?=
 =?utf-8?B?anQxVFIxYnFuYzNOWEpTNXVvNzZlcWFTNW02NDgrK293RlBGd2Z6Y0UyNFVo?=
 =?utf-8?B?K2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	EqqvMME9iw8aFVeXboxxToXau5Ptyq3pCA4o4XWNaFurJieZKanfx0urYNFyTrBo1185qKBEJVIRI6vN4OtYz/+9B6kqi8wAyD/a9ADarN6kLdVUNm7BiQtPwk2bol9zTeRSlhB0mOTV2IyDALAMESKzlMkLH53q1Au37gnYqyxk3NeN7GQnEd/Is2CR70MZY9uPDPThCaIwxVn36q5YerdWsVLpQFJCvo6jqc3Qxg/Di8V84PO/Cvfg7iI2g0wUQ7zDqz3vCaLT6/AH8x4f5eJb3K33WTBNc1BYs2272DzL79sWzpDGoW9LWz77sBAZ1v+tThp2pJAUz1SdPnLrbVc2iGt8UuKyADequiGiy6s9RwuNHBYFMTBJF8s5xLIP/WlIQLYlQ88B010V8PbR/0kz6S9gd5qYCCvDbfiw81WXic1xmZ/26T+LAqEj2YQVOqS7XmZOcZajKSoVqH0/9KXlR6ONHbpZUxbALf5PcadHts5G3Yhe9xBG8r8aN5Oz2EBNrvmVsnxBt67qOt5ZE3ro8x4+Hg22YE8xI7fwamjAeWZOOiwRIbyravmgFZQ1by7TOhpljPLEan8JBr9xnOTJt2AKWTgPxXER0dq3khc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c31c6cb8-0a27-4f4b-0c1d-08de074511de
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2025 15:03:57.0026
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xnWZrXCiGgnNGLA9ze3ePIl/KpcbiiE0UnGU/KDMDKvCGZGHAL5OfenLLvV9qTW+zEfewrBAq+IN9kwTTWKYpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB8220
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-09_05,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 phishscore=0 spamscore=0 adultscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510090090
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX6PeYy8cAnHvN
 5MWG6KX4CVRtR8FN4q8yHrjQJrXrBGLfcBnjbo7sSdKF2vtrKm0I5iBbyFJjDKFAJkEFMC/kCkV
 NHKzCKIvDjTwfIiK3pZORjFsmDuHN7fw7dtltkY1H9T6ddnPuEfBn2ijdNB5F6VJGuLme+DMJQ1
 eb9c0JEKVIo6vpTJy92Kl8gBZUxJ9yJDSKEPu5OyswOQCkjDbqxKAbOz+p/cM+xaX0j3ooxiEV3
 6DugEI6nWAH+iIAS0CYsqm6RwH+mXH1TM+wQKibhA51uo6w3eCrNLfya3r2P3ju1d9EpXsJKka4
 R4HksuSLqn310JhJok7tYQdGI2DM/gdsWQCOhc2xuAd9NBuZyJS2aBhOP5GG8RXGN4BviiKGjEl
 ILbrpPJNMibE10wp/b0RBryygR2OdOKmPPkonbrXNn/ZRo7yaTc=
X-Authority-Analysis: v=2.4 cv=dtrWylg4 c=1 sm=1 tr=0 ts=68e7cee1 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VabnemYjAAAA:8 a=VwQbUJbxAAAA:8
 a=QeqP6Tv5zezTxy5z2j0A:9 a=QEXdDO2ut3YA:10 a=gKebqoRLp9LExxC7YDUY:22 cc=ntf
 awl=host:13624
X-Proofpoint-GUID: BHMKBgDCyMWXqxSEV4awAfclnpdpuab0
X-Proofpoint-ORIG-GUID: BHMKBgDCyMWXqxSEV4awAfclnpdpuab0

On 10/9/25 10:40 AM, Jeff Layton wrote:
> We've seen some occurrences of messages like this in dmesg on some knfsd
> servers:
> 
>     xdr_buf_to_bvec: bio_vec array overflow
> 
> Usually followed by messages like this that indicate a short send (note
> that this message is from an older kernel and the amount that it reports
> attempting to send is short by 4 bytes):
> 
>     rpc-srv/tcp: nfsd: sent 1048155 when sending 1048152 bytes - shutting down socket
> 
> svc_tcp_sendmsg() steals a slot in the rq_bvec array for the TCP record
> marker. If the send is an unaligned READ call though, then there may not
> be enough slots in the rq_bvec array in some cases.
> 
> Add a rqstp->rq_bvec_len field and use that to keep track of the length
> of rq_bvec. Use that in place of rq_maxpages where it's iterating over
> the bvec.

Granted that the number of items in rq_pages and in rq_bvec don't have
to coincide, they just happen to be the same, historically. And, each
bvec in rq_bvec doesn't necessarily have to be a page.


> Fixes: e18e157bb5c8 ("SUNRPC: Send RPC message on TCP with a single sock_sendmsg() call")
> Tested-by: Brandon Adams <brandona@meta.com>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/nfsd/vfs.c              | 6 +++---
>  include/linux/sunrpc/svc.h | 1 +
>  net/sunrpc/svc.c           | 4 +++-
>  net/sunrpc/svcsock.c       | 4 ++--
>  4 files changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 77f6879c2e063fa79865100bbc2d1e64eb332f42..6c7224570d2dadae21876e0069e0b2e0551af0fa 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -1111,7 +1111,7 @@ nfsd_direct_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  
>  	v = 0;
>  	total = dio_end - dio_start;
> -	while (total && v < rqstp->rq_maxpages &&
> +	while (total && v < rqstp->rq_bvec_len &&
>  	       rqstp->rq_next_page < rqstp->rq_page_end) {
>  		len = min_t(size_t, total, PAGE_SIZE);
>  		bvec_set_page(&rqstp->rq_bvec[v], *rqstp->rq_next_page,
> @@ -1200,7 +1200,7 @@ __be32 nfsd_iter_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  
>  	v = 0;
>  	total = *count;
> -	while (total && v < rqstp->rq_maxpages &&
> +	while (total && v < rqstp->rq_bvec_len &&
>  	       rqstp->rq_next_page < rqstp->rq_page_end) {
>  		len = min_t(size_t, total, PAGE_SIZE - base);
>  		bvec_set_page(&rqstp->rq_bvec[v], *rqstp->rq_next_page,
> @@ -1318,7 +1318,7 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  	if (stable && !fhp->fh_use_wgather)
>  		kiocb.ki_flags |= IOCB_DSYNC;
>  
> -	nvecs = xdr_buf_to_bvec(rqstp->rq_bvec, rqstp->rq_maxpages, payload);
> +	nvecs = xdr_buf_to_bvec(rqstp->rq_bvec, rqstp->rq_bvec_len, payload);
>  	iov_iter_bvec(&iter, ITER_SOURCE, rqstp->rq_bvec, nvecs, *cnt);
>  	since = READ_ONCE(file->f_wb_err);
>  	if (verf)
> diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
> index 5506d20857c318774cd223272d4b0022cc19ffb8..0ee1f411860e55d5e0131c29766540f673193d5f 100644
> --- a/include/linux/sunrpc/svc.h
> +++ b/include/linux/sunrpc/svc.h
> @@ -206,6 +206,7 @@ struct svc_rqst {
>  
>  	struct folio_batch	rq_fbatch;
>  	struct bio_vec		*rq_bvec;
> +	u32			rq_bvec_len;
>  
>  	__be32			rq_xid;		/* transmission id */
>  	u32			rq_prog;	/* program number */
> diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
> index 4704dce7284eccc9e2bc64cf22947666facfa86a..a6bdd83fba77b13f973da66a1bac00050ae922fe 100644
> --- a/net/sunrpc/svc.c
> +++ b/net/sunrpc/svc.c
> @@ -706,7 +706,9 @@ svc_prepare_thread(struct svc_serv *serv, struct svc_pool *pool, int node)
>  	if (!svc_init_buffer(rqstp, serv, node))
>  		goto out_enomem;
>  
> -	rqstp->rq_bvec = kcalloc_node(rqstp->rq_maxpages,
> +	/* +1 for the TCP record marker */
> +	rqstp->rq_bvec_len = rqstp->rq_maxpages + 1;

What bugs me about this is that svc_prepare_thread() shouldn't have
specific knowledge about the needs of transports. But I don't have a
better idea...


> +	rqstp->rq_bvec = kcalloc_node(rqstp->rq_bvec_len,
>  				      sizeof(struct bio_vec),
>  				      GFP_KERNEL, node);
>  	if (!rqstp->rq_bvec)
> diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
> index 377fcaaaa061463fc5c85fc09c7a8eab5e06af77..2075ddec250b3fdb36becca4a53f1c0536f8634a 100644
> --- a/net/sunrpc/svcsock.c
> +++ b/net/sunrpc/svcsock.c
> @@ -740,7 +740,7 @@ static int svc_udp_sendto(struct svc_rqst *rqstp)
>  	if (svc_xprt_is_dead(xprt))
>  		goto out_notconn;
>  
> -	count = xdr_buf_to_bvec(rqstp->rq_bvec, rqstp->rq_maxpages, xdr);
> +	count = xdr_buf_to_bvec(rqstp->rq_bvec, rqstp->rq_bvec_len, xdr);
>  
>  	iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, rqstp->rq_bvec,
>  		      count, rqstp->rq_res.len);
> @@ -1244,7 +1244,7 @@ static int svc_tcp_sendmsg(struct svc_sock *svsk, struct svc_rqst *rqstp,
>  	memcpy(buf, &marker, sizeof(marker));
>  	bvec_set_virt(rqstp->rq_bvec, buf, sizeof(marker));
>  
> -	count = xdr_buf_to_bvec(rqstp->rq_bvec + 1, rqstp->rq_maxpages - 1,
> +	count = xdr_buf_to_bvec(rqstp->rq_bvec + 1, rqstp->rq_bvec_len - 1,
>  				&rqstp->rq_res);
>  
>  	iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, rqstp->rq_bvec,
> 


-- 
Chuck Lever

