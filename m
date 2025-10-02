Return-Path: <linux-nfs+bounces-14912-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55C67BB446A
	for <lists+linux-nfs@lfdr.de>; Thu, 02 Oct 2025 17:10:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59FD57AC27F
	for <lists+linux-nfs@lfdr.de>; Thu,  2 Oct 2025 15:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE0F618A6A7;
	Thu,  2 Oct 2025 15:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RKlHYKKk";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mjQy0nfS"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E784717A2EA;
	Thu,  2 Oct 2025 15:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759417824; cv=fail; b=pGbEzsLPq/UUjmOPB1r+zCIGwDAzoh6g7vmMiNdF5kAOEzxQhSNGmGQhbDrH2DYRxs064Egi3tnBGmXx2y04rAlSpK/jWZkjKGmPL+CQvHpQB3iewIuEUOPyp1U5B4GpCSSypnnWxl0dZbHqE8C4s1PY6dgk0kM9Gz7qmrLnqmY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759417824; c=relaxed/simple;
	bh=oo3LB548Ju+Dffuwv2cZpMm38Jitcb5cF/6zIxQyITE=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=r3YkqqrRobbsNd95eDE74IxmRp0EhCARxsZ4jNHcTbURDz6RJiStK1+dYjSAYPl/Xs/O/w+ItBdwUtsfDE+IvBdcNmaYD8LRzT7lneIBXnXFJrbPByULEnxkPEOdb0XO3ZrTHjKSsd/zXph3kVk9lJG80ZtngVudvznnavX2tpw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RKlHYKKk; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mjQy0nfS; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 592DN680003419;
	Thu, 2 Oct 2025 15:09:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=6M+caNW8Yro5bN6hWjqWeyDkI3OTBbubIE2NvZX2zo4=; b=
	RKlHYKKkDkFFHRwHsuGQ67TAjF5oHRHRzIm9A2P+nzRtu9rAGogWo0fFtWF7Q7AF
	w9r6TmtBxkhXu2BgxpRjsSG97f51bdFrKAoztwQRCyKwzk0pr4E0zidmfJPTxTZV
	ms1hwEYTVqFHqYZ8HBbhm9BQCPuyvz1SihlZIlW1uaUxKdZA8wxkF2YWcs4YUvB2
	qb5nCLF4svKZNzx0c4/x+HXNnTD/c5bMoWerXggLU/xJUGyhR2g8eed+zhm3J0vv
	4IgQ55QpscGTEIvieuHM08f4l2cjF4qgejasP3lxvervZUTe7rwXQIX6S/U1OBVd
	GRr3Sn4cXj/jZSSUs5kUfQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49gmf1ufdy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 Oct 2025 15:09:44 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 592Dg7WD000323;
	Thu, 2 Oct 2025 15:09:44 GMT
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012017.outbound.protection.outlook.com [52.101.53.17])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49e6ch21b0-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 Oct 2025 15:09:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l7dybrPJnpaUZWXTtM1vk7szRc11VPWLU80VFpelhnTmnJe3TX0GgzRw4Q/IKTxr0an8gMTaD4ulKciWewkgBnmLCF75pFKK+Lo0A0rx9WZQdR41A3wQ/h6n9OYazE/Zh6a5Z71efSUhkAapXW+VSntb1W/RwflLU2ejgtnQ3Sdm9TDRikt7R5MRocHdOiVoRC/m1bom1bDVmBV+7WBHkfAp4iTAYduWsmfhIa2P8gBmlWhKFvN+zFHJHE1khdMSlFj+CzGOlr7XWy9xVfQhZZTp4IGTbqK9vsJDVKsm9eayBmFAdSynIvclMiLb7RhADrDDl40RVSre7BvwWB/0+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6M+caNW8Yro5bN6hWjqWeyDkI3OTBbubIE2NvZX2zo4=;
 b=fSXcO3B2Awu81OmKeONrUl8FGC7GLdhwglYoiZTAftrzcGcLyeUpRZAgp9CtnqwBdUAhbWO3DeKL07h7qH17jXoHxtXTzKVOw6Usx1bkcpSfH1+gU2Cj0qgqCIp+l8TLYaWTviTScFPoPWKmTTVY6/UND/OvfHNOMvxPEQDmLaE1P11YGMhH1e0YSlTPSu0PWCLh5xxZFzz3Kc7mOoIlv4n9wuMiR8p9Hfflqx2PoYz1wKSj+zAzYSdQL27Eh60jqYH2tTyZlSmNOmVksp3cO0HdsE9Z/dsJJE2AVw8vpTEgJssU+xQuohIV27tZLdtpXtXqIJYnaGW6LbO4t4zl1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6M+caNW8Yro5bN6hWjqWeyDkI3OTBbubIE2NvZX2zo4=;
 b=mjQy0nfSyYc/Je/NOBddXvquAaBs6isfp26dNX+YW4s4Hb6VGgA9n29KkfaKd8A6N3FiCetUjx96rIJU8+arISUeKDaGXc2m6ertOe/Ptz2OTZ6+biyGvnW5I8Gg9otdA+w9R+HVzMpOgH7PNz97LKFFpWcas06QYPhtW+7BmEA=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS0PR10MB6078.namprd10.prod.outlook.com (2603:10b6:8:ca::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.18; Thu, 2 Oct 2025 15:09:10 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.9160.017; Thu, 2 Oct 2025
 15:09:09 +0000
Message-ID: <2097dca1-78e1-44d8-aeb6-d46b94a63078@oracle.com>
Date: Thu, 2 Oct 2025 11:09:07 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] nfsd: remove long-standing revoked delegations by
 force
From: Chuck Lever <chuck.lever@oracle.com>
To: Li Lingfeng <lilingfeng3@huawei.com>
Cc: yukuai1@huaweicloud.com, houtao1@huawei.com, yi.zhang@huawei.com,
        yangerkun@huawei.com, lilingfeng@huaweicloud.com,
        zhangjian496@huawei.com, bcodding@redhat.com,
        linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org,
        tom@talpey.com, Dai.Ngo@oracle.com, neil@brown.name,
        jlayton@kernel.org, okorniev@redhat.com
References: <20250905024823.3626685-1-lilingfeng3@huawei.com>
 <8646ca56-a1ef-403a-85ce-18b90235ab99@oracle.com>
Content-Language: en-US
In-Reply-To: <8646ca56-a1ef-403a-85ce-18b90235ab99@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0322.namprd03.prod.outlook.com
 (2603:10b6:610:118::27) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS0PR10MB6078:EE_
X-MS-Office365-Filtering-Correlation-Id: 80cbc8ee-bebd-4fb9-4335-08de01c5a37c
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?SWM2VDNkcUc5ZVJEbU93UVhPS3BzNHRMbWowdkFlZkczZjA2N1NuYTFxajV2?=
 =?utf-8?B?QlJFLzR1QnJ2dDFkclNINWJza05TQWRDQlE5R05BSnFyd2xxOWJFWVBMZlU2?=
 =?utf-8?B?Y0pDaU93am8wTnZ0YVRMK0ZvakJGWmFrOTlzYzErZy9BSitNRDdrYlNLSXBG?=
 =?utf-8?B?Wkgrak1qTVpoMkRIWHFnRWs5OW9lbWo0MnVaZmw1bjByZk0zeEl2TDh0c2w2?=
 =?utf-8?B?dE4zKytmRzFFa3V1bmFZZ1NVMVptMC9TTGJXYlR6VTNiTDhydkg1eWYwYXdF?=
 =?utf-8?B?Y1dKMDJaTkJRQU1FNEc2c3N0RHBOVDhYSGxGMU1Ld2FPdU93a3lQOVlubzNH?=
 =?utf-8?B?TlFMNHZWaDhRQ2VCa3FvbGZuSGh0WXlnUno4Z0dDTFV4eUFhcFJtK1NuaTJv?=
 =?utf-8?B?NFpHVWF4bnlrT29PM01WVmlqb0RuRkNsbWgwMlk2WEllMUc1YkliMTI5Tkk5?=
 =?utf-8?B?VjdMa1pVaWhUYStaN3BEM3EwYXFBaWlPZnR1TjFWcit5WXYrQzMzTlEvYzcr?=
 =?utf-8?B?K0l1Szdpdkoxb01UTXc1bmxKbzY5NEk2M1FwdXpDbWZYSFhXV0FjcXdyRmQ3?=
 =?utf-8?B?dWQ4bklSY2VzaWVtMUcrNyt0d2RLVjBmcHFydittMWxPcUU4QlU1WjFuV0xx?=
 =?utf-8?B?ZGd0bk9oV0Qyd09Eb0ZWdUlNTHIxY1NXSkNadWRoL0dYM0xNVDMwZkhqOWYr?=
 =?utf-8?B?OXQwVTBiVjhLbzdkbkl0dENlMlpVU3I4VFcrSURGY3d3RnNLUmhYWnZydGl4?=
 =?utf-8?B?eVJaZzJSMkZwcHpvb0ZneGVpakYydkdweEtUQWFZbisyazYvZDdmY2RhQldU?=
 =?utf-8?B?eUNVWmFKTExhWGk5bkZMYnVzZEE5SkdwZ1Vrdi9pT24raU9NazI5SjQxb1R2?=
 =?utf-8?B?ayt0SGNhKzkrSDMyMjZVZDdhY0RQS2tKcWFJQUhRU1gxS0RKSW0yeXdHampV?=
 =?utf-8?B?OFNCVVg0UzJyMi9BdFhudkZybGtjMVpxbzhiWEk5cGUwVzYxNlhPb1FYMmUz?=
 =?utf-8?B?OW9lb25QWStQbEtWaGh6SG56bFo5MlFVOVByWVF2SE9remV1TEFHL09qcFVv?=
 =?utf-8?B?YTZ6YjA3cEJxNUY5dU10cHVTQ3RMWUxUTDU5cTVjSDUzbEpiTG00eXJBY1lC?=
 =?utf-8?B?d1NveGE0T3NwZ1VXOHRQb01TSW94WDBCb1czbFZPZjZiYzFCOWtWZmg1allu?=
 =?utf-8?B?Q01JZ29OS21uSVBxWDNDeHFwNiszWUdtbWxEbE11aVRWQXg3MnFnbXlFME5G?=
 =?utf-8?B?Z0FrNURIK2Z4dHBtWnVIWThHblVmZ051NG9QRE1CczQrRXk5b3ZUbS84Q2Vt?=
 =?utf-8?B?Qm9LQ0FyT0x2Rk5rakxFSC9CQnpyOUhma0YwaEl1SDlpUVVtK096ZGY4M1gw?=
 =?utf-8?B?WFI4UHVjVXNzNG43T0J2VmM1U2cxS3d5Y0djUzN6RGxTYjhkd3hmYmJqQVhP?=
 =?utf-8?B?TU9pMWl2RnRvWG9JbVFiNTFXZjNiRnR4cENxVVZ0RzJnWXUzSGE1SDFRamh1?=
 =?utf-8?B?bEFacm9OMERzUmRwUTRiaVp6N2FOSGRrMlhRUHFpalpFbTFUdnhQWDg3OGJE?=
 =?utf-8?B?N3pTcXBSMzg3cUNVM1pkbWJFQjdTTkdmcGtwNUxMaDloWUJVQ3BtTDEyTlN6?=
 =?utf-8?B?T1NzallxYjRmSVRXcGV1S2tWdkRxdXJTaElXYm5QVUhHV2cxbWdLaWxKVXpo?=
 =?utf-8?B?MXVnQ2FFcVo4ZFJtWS9jcnU3d3FCZ21hUFYrdENCWUlqTFdlblFTUVpmRDVQ?=
 =?utf-8?B?SVdiSkxyS3daYkNJOFlFUkEwUng1ME1ZclRpTEF4VFQyeWJONzVycGdIOEZ2?=
 =?utf-8?B?Rm0zMW1YTjhFbzBUZWs5QUtRbDR0YXVBREhyOW1zOStFTVJZYTB6bkVPRlNJ?=
 =?utf-8?B?ek5YZHhSaUFJQ2dQbzNSbGNsa0IxdytUVnZ5NnRoZ1d5T2pkSm13WThqUnJr?=
 =?utf-8?Q?dM4GJ4j3cXbFEOIV705dfJFny7Xfxfd/?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?OUQzcTRyNkhMVExTVmRIUHdScXFvcWFZbUozVDZqWUt0SjRUUU5CdFFmY1ZC?=
 =?utf-8?B?T0hpYUxaRDErOTlvSitiTlNDN0RyZ1F1a01kSWl0L25rK204VGZydzBtc29I?=
 =?utf-8?B?cmhEd0I2aS9oRnZ4UVpkWGkrWE1iSFhtaFJaYjZEZnI4UnVFN2pGY3FGdFV4?=
 =?utf-8?B?NmpiNlNVaEM5Mkp3TTJqYnVLS3dUYmtEdktPbnJhNFRIUmtqd2VlYXBadE0r?=
 =?utf-8?B?UndMcTB1Q0JzRS9zVzh0QzFBUkMwMWRsZTFzVytTbFpRQTN1Q3U0THdjVTgw?=
 =?utf-8?B?Q2dYdXdjSURVUk1Ia2JzVHpEcDFUZ3JxT05ielhMSXNSUlN4TGY2VVVWQmdU?=
 =?utf-8?B?T3ViaTJHWGU0dmd6bDRpYkhGTTdldVhXVnBvYXlrYnpTeTg5VTJlZXRGUVpz?=
 =?utf-8?B?emtobzQzeHZmNms3Z2UyQ0xnNUJna0JHYTJEVU0wRTRrRlJEQW1NQVo2TzZH?=
 =?utf-8?B?UTJGbjV3WklYc1hlMFlRdWRIOWFIZllmOGwvdkhuSk9xdVFDTThIb01UdWxY?=
 =?utf-8?B?b3hBdzRIc3cxbHAyZDBmLzE5cktOb0pMamc2NWZiVzFCdWdZenZ4dEZMcndT?=
 =?utf-8?B?eitmbkcrN2wzRFAweEN4K0puZWVQdjU3VHd6dGNPbzBSSEJTei9YMEFHN2Vi?=
 =?utf-8?B?azg0Nlo5TE9BOTZMZkNIbk5XTERYbXRGbmNVLy9zMElpYVFCT2h6MHZ2aTZh?=
 =?utf-8?B?Q1MxSkFacVhnZUJkMG1PVEh5WTlucGZjdGVoelRlbGpRSUFuM3crczBFV2lv?=
 =?utf-8?B?QlBUQW42RXMydFdKZ21PaDQyTFhoNnZRckdBMWtsTWlkUWs2cTlZbENVV1JZ?=
 =?utf-8?B?QWVBZzZVWWtWd1pZOXFYczRtaU8vV3lJZllpYmo2ZzVxbk90eWE0Q0hwREdX?=
 =?utf-8?B?ZlpVd09CZG1HalFkTmdKQ1ltaDh1RmxITE4rVm5lbmUyZWk3dGFjdWFlK2Zj?=
 =?utf-8?B?UlBnancyczBuc2dVOVZHYTB6OG1FNGRVckJyL2R4N3FDL1ZLSzNLRUZQZ1cy?=
 =?utf-8?B?WFJEc3ZaUkxjOEZYTGdWcSs1YUJ3Z1hNRlQwNU5GSVdraDU0SU1iQk5tRzhY?=
 =?utf-8?B?di9tMWlmRS9VRmxoUlk1TktLTEZzK1hRelhQbUdEVDA0R3NBaXZ2YmNsTkxo?=
 =?utf-8?B?T3J5eWQreEZGaTlMZmd5SnFKZVlvRUZhV1ZkSEZPZUdmUXBMZDJSRFpSc01E?=
 =?utf-8?B?WnVtMy9nUGJKdldLV3g5MzZYU0JDVW5VS2syb1ZiN2Q0cTg3bFEzd2VYRm9x?=
 =?utf-8?B?a1ZaZi9YKzcxT1Rrbk45aUF3Rm15TEdPT0ZZNGNEYkc4K1V3NjBNdXUxMmpC?=
 =?utf-8?B?MG41T3BQanNJV2RHQys3S0pNL0VtemlJb1granhhOWlLNG1EVkg3MUpoUWZa?=
 =?utf-8?B?bXJRcEVxVzhKNTFlVzdHRjcvL3Z6UDAxUnVPR3VjUlhRUGJNSDdvWEM0Qmx4?=
 =?utf-8?B?QW5GaDdsZ2pvYmZwZ3lmbWYxWEZhUzBnMElHU2hHRWF5c1VoWkpySzRJOEFT?=
 =?utf-8?B?YkxBRllwTTJBZU1pNnJQS01rWC9IMlUyYmp0T2dyUkt1Njl3S01UenFpR3E0?=
 =?utf-8?B?QXVNMHhMSkN2SWpjMzUvWm9CNFB2YWVMNU9aSCtzem1XMzU1ajRwVGFZZ2tk?=
 =?utf-8?B?Z0NhNUg1d2pyN1VZZ1BHSVlNZkdhNFAvd1JsS0lqaDRZWWhuTXBCbmwzMGFn?=
 =?utf-8?B?SDUzbzIyRlNlSzZybStmMzZkL0xmelJjYzh5aFV3N0M3N0RRZTlGTVFuemlC?=
 =?utf-8?B?bnpvbzdUb3BOakR3TGhJem1Kejk3WXVYN1h0VEZ3Y0Roc0VsaHRiYVVSYWN5?=
 =?utf-8?B?QmJleVNOLzhMZzh2czd6cWVLUVdiNmFkeGJyMHhiemJINmtFMHliNUhEQnBS?=
 =?utf-8?B?RENRT3ZyK1ZJQlp4THBGc0J3RWdFbHE4a29BR05QWUF2RnFMSkNTNXdLdUVF?=
 =?utf-8?B?QSsvRHIvSElCdjFZK2o2NXpaWHY1ZS9jUkVxR2owRTIvYnlNQ0VkclgvZW9F?=
 =?utf-8?B?em1CVmh1clg1VkFiQ0RST0c1SittZGJXSzdKc3R0cHM4ZVBoS1Q0THBRczlv?=
 =?utf-8?B?dXRoY0xMa1U0am51c2Vnb2tsalpVMXVUejlDSFJ4eTRHTTNHNHpvTkIzY0xx?=
 =?utf-8?Q?o6XKInLe3O8xCB2GSh8aFx1j3?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	sbvIVsVQI/IwE3UCLWyegT0Dxb6W4uOP5+6VcMViuSeaJB7UwNIpMWLGJ+SzFNTia0cgPJA2Ge4UTJcopfXn/uDoEc+qcH6yovKBhu5JRhUyHfbC5DcLOaw+qubZ84nYGXXDlqb+EYGBAxk0NysAGZuuPSf5cdPIVjGELwM0wNx8G262+e041LgyaqQ95Volg+FrOCqWqFtLO8zyY8Q7JlRXffEoWuoLrKFWa1lFcA7/0B1Tzed6o3HH3K8/SYJLtq9Ve7NuU0StbrAcSvgV9m4hA9kYP1zzEZ7rAYZYwP6A5fwrzeHXqWxNSHzWU+Y0KCDFcroqh0e6YmjKvT2lYgdUhTmCWlxUlSpV+WEDxhBf0ts+98cuLe6QSq/24Zo73WtXHhMiT3RR+o6Lrp7DgXSqYoT814jyhsLKyEEk2M/Mgf42SPqk4a9kes1Cl9YSQdu0R/ND3/rt059jtYPAEqQx8wioxHR7yAZWM/ESHSlsmm+JJNZxOAzL5QCxvUBiAQcSKEeD2GQgoyUdeea3M3ARNWECw+TeJtBXa18khqxyVo2ZDzLNp10tV15M0Mx7Fwr/8vwVlDJ5EBn3QR0nXIRKERkU3lzIAioWL1qUWmM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80cbc8ee-bebd-4fb9-4335-08de01c5a37c
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2025 15:09:09.8476
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c87H5XsGEkuRR/jEdII6Ad7lO2E/a+BEYnojn9rE2oPxdINJtgw2gTt3mMnCK3XZqFEn3h3hnycRmZKELM47/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6078
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-02_05,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 phishscore=0 mlxscore=0 suspectscore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2509150000 definitions=main-2510020129
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTMwMDE2NyBTYWx0ZWRfX+aOymOTdvEm+
 3ODJDwlwgLB45k3WndoTIXe1Gg76hAyc0O8cnqwZiJCg2PorAHwS6t7bHC62WBB7FDX+sIwYHhI
 Xxly3PmUKYNVD186ZpumJCMjVBzS7ehzJk3WhtwOD3+joI5w4znB4hy0uy5xnQwpUaSiaNG4EEJ
 J6fd4613HlR3d/MId+fGwB/uSM2x+WtMtCasmwO2ZGWU+zA1zs3j25/rmifCDbKsg37FzL/hSXu
 Db11W01VsVeumhF9/3yjamKZhi+On11zREAjDOFu61komZUTMhq8A9TIjd0c29CBOFjjTtZ3mCM
 QPN4mOo6ohgIMa31h4rr4hFUe4679Aaj5DyRt8tVT8J7AWzik0w0zcRSH1ASycEKXlDNMuzWS7R
 gVRl8g1Kd+HScbGC7dSJBfwY/gLB8hG6pEPjL/yrutLPpROYZPo=
X-Authority-Analysis: v=2.4 cv=K/cv3iWI c=1 sm=1 tr=0 ts=68de95b8 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=i0EeH86SAAAA:8
 a=FnxsOxxyaODc_VZjamEA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12089
X-Proofpoint-GUID: 60PnWLKLP87Qo-Y6eX0q1BHMBn7vizCW
X-Proofpoint-ORIG-GUID: 60PnWLKLP87Qo-Y6eX0q1BHMBn7vizCW

On 9/29/25 3:40 PM, Chuck Lever wrote:
> On 9/4/25 7:48 PM, Li Lingfeng wrote:
>> When file access conflicts occur between clients, the server recalls
>> delegations. If the client holding delegation fails to return it after
>> a recall, nfs4_laundromat adds the delegation to cl_revoked list.
>> This causes subsequent SEQUENCE operations to set the
>> SEQ4_STATUS_RECALLABLE_STATE_REVOKED flag, forcing the client to
>> validate all delegations and return the revoked one.
>>
>> However, if the client fails to return the delegation like this:
>> nfs4_laundromat                       nfsd4_delegreturn
>>  unhash_delegation_locked
>>  list_add // add dp to reaplist
>>           // by dl_recall_lru
>>  list_del_init // delete dp from
>>                // reaplist
>>                                        destroy_delegation
>>                                         unhash_delegation_locked
>>                                          // do nothing but return false
>>  revoke_delegation
>>  list_add // add dp to cl_revoked
>>           // by dl_recall_lru
>>
>> The delegation will remain in the server's cl_revoked list while the
>> client marks it revoked and won't find it upon detecting
>> SEQ4_STATUS_RECALLABLE_STATE_REVOKED.
>> This leads to a loop:
>> the server persistently sets SEQ4_STATUS_RECALLABLE_STATE_REVOKED, and the
>> client repeatedly tests all delegations, severely impacting performance
>> when numerous delegations exist.
>>
>> Since abnormal delegations are removed from flc_lease via nfs4_laundromat
>> --> revoke_delegation --> destroy_unhashed_deleg -->
>> nfs4_unlock_deleg_lease --> kernel_setlease, and do not block new open
>> requests indefinitely, retaining such a delegation on the server is
>> unnecessary.
>>
>> Fixes: 3bd64a5ba171 ("nfsd4: implement SEQ4_STATUS_RECALLABLE_STATE_REVOKED")
>> Reported-by: Zhang Jian <zhangjian496@huawei.com>
>> Closes: https://lore.kernel.org/all/ff8debe9-6877-4cf7-ba29-fc98eae0ffa0@huawei.com/
>> Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
>> Reviewed-by: Jeff Layton <jlayton@kernel.org>
>> ---
>>   Changes in v2:
>>   1) Set SC_STATUS_CLOSED unconditionally in destroy_delegation();
>>   2) Determine whether to remove the delegation based on SC_STATUS_CLOSED,
>>      rather than by timeout;
>>   3) Modify the commit message.
>>
>>   Changes in v3:
>>   1) Move variables used for traversal inside the if statement;
>>   2) Add a comment to explain why we have to do this;
>>   3) Move the second check of cl_revoked inside the if statement of
>>      the first check.
>>  fs/nfsd/nfs4state.c | 35 +++++++++++++++++++++++++++++++++--
>>  1 file changed, 33 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>> index 88c347957da5..20fae3449af6 100644
>> --- a/fs/nfsd/nfs4state.c
>> +++ b/fs/nfsd/nfs4state.c
>> @@ -1336,6 +1336,11 @@ static void destroy_delegation(struct nfs4_delegation *dp)
>>  
>>  	spin_lock(&state_lock);
>>  	unhashed = unhash_delegation_locked(dp, SC_STATUS_CLOSED);
>> +	/*
>> +	 * Unconditionally set SC_STATUS_CLOSED, regardless of whether the
>> +	 * delegation is hashed, to mark the current delegation as invalid.
>> +	 */
>> +	dp->dl_stid.sc_status |= SC_STATUS_CLOSED;
>>  	spin_unlock(&state_lock);
>>  	if (unhashed)
>>  		destroy_unhashed_deleg(dp);
>> @@ -4470,8 +4475,34 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>>  	default:
>>  		seq->status_flags = 0;
>>  	}
>> -	if (!list_empty(&clp->cl_revoked))
>> -		seq->status_flags |= SEQ4_STATUS_RECALLABLE_STATE_REVOKED;
>> +	if (!list_empty(&clp->cl_revoked)) {
>> +		struct list_head *pos, *next;
>> +		struct nfs4_delegation *dp;
>> +
>> +		/*
>> +		 * Concurrent nfs4_laundromat() and nfsd4_delegreturn()
>> +		 * may add a delegation to cl_revoked even after the
>> +		 * client has returned it, causing persistent
>> +		 * SEQ4_STATUS_RECALLABLE_STATE_REVOKED, disrupting normal
>> +		 * operations.
>> +		 * Remove delegations with SC_STATUS_CLOSED from cl_revoked
>> +		 * to resolve.
>> +		 */
>> +		spin_lock(&clp->cl_lock);
>> +		list_for_each_safe(pos, next, &clp->cl_revoked) {
>> +			dp = list_entry(pos, struct nfs4_delegation, dl_recall_lru);
>> +			if (dp->dl_stid.sc_status & SC_STATUS_CLOSED) {
>> +				list_del_init(&dp->dl_recall_lru);
>> +				spin_unlock(&clp->cl_lock);
> 
> Does unlocking cl_lock here allow another CPU to free the object
> that @next is pointing to? That pointer address would then be
> dereferenced on the next loop iteration.
> 
> Might be better to stuff dp onto a local list, then "put" all
> the items on that list once this loop has terminated and cl_lock
> has been released.

I intended to include this patch in nfsd-next for v6.18, but since I
haven't gotten a response, I have dropped it for now.

When we get closure on my question above, I am happy to requeue it
for a later merge window.


>> +				nfs4_put_stid(&dp->dl_stid);
>> +				spin_lock(&clp->cl_lock);
>> +			}
>> +		}
>> +		spin_unlock(&clp->cl_lock);
>> +
>> +		if (!list_empty(&clp->cl_revoked))
>> +			seq->status_flags |= SEQ4_STATUS_RECALLABLE_STATE_REVOKED;
>> +	}
>>  	if (atomic_read(&clp->cl_admin_revoked))
>>  		seq->status_flags |= SEQ4_STATUS_ADMIN_STATE_REVOKED;
>>  	trace_nfsd_seq4_status(rqstp, seq);
> 
> 





-- 
Chuck Lever

