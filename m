Return-Path: <linux-nfs+bounces-16301-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C27B7C5323F
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Nov 2025 16:46:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 15247500138
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Nov 2025 15:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39019342517;
	Wed, 12 Nov 2025 15:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WCCay3ud";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bvrm+/0Y"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA67342514;
	Wed, 12 Nov 2025 15:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762959760; cv=fail; b=MJcgfeLggjK7EdWp2TdycQwhzyXvvGmcDdpo+TbThDO2dMVGJl8WeSI4d2HGclWoZUutA5OkE124VNqCm83NDWZBRv1EZf6hcc5qX1csGa/3Un8agMGensyVWH127NPQ6B0tP4poN8kDWXBJMDD6uC0drBfhQZb9mWlgtmWC/Ec=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762959760; c=relaxed/simple;
	bh=rDwzEIFipp4iKiQKO1/svE34dfYFsX2Oy1pSyrObLx8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=m+Bni8hnpZ3gZgUQi78ALgdaYrSKsHlcY7TVAAFnEsROwMxAADHLKf9h+/DqVBk8IBCUrSQSXKWJasBzB2vymolZ6b7eZH/updNWX/eN3E7buoeg+bjajOsDr1452RBZUkWDSBQlkDtkoqfsVYzVkMR9tSHOc9XwJ5dWCvAQSqk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WCCay3ud; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bvrm+/0Y; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ACEuH2v017770;
	Wed, 12 Nov 2025 15:02:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=wjIzGTXgBx3SxAUvQnG1d6V5tk0hw6RUcBUt3YIHfls=; b=
	WCCay3udYp8eK+8sjR/2VO9Vqmo3pGg0dSPqaCpV1O75bJ1kIPwNrQlm5fFjg9Cj
	0dr4unyKXkuaN/CUDChxwLmidRT+Z8fC5LK04uuX9INfgQBq1wrvpeucPPXhUvU2
	IYkNb1soM/lI5Ucwl+DQnHazRRxGqGEkq0uh95VkPYi8+/XittJOIHeaDIiKYsEU
	4zeeCs9sd+q61p4XvXj6ihrlkrGhiLe9atp5MtI4r+7UW773bhiUutof0Zl99E+0
	jAGh9Y0ZFVQiOoHBZJKz9Um5MoiV6KGXXy7dFhAKrIe2egHi67y0glzA+zNtnMRK
	hwPHIiByYCMYMEaBA0gqHw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4acv97r1pc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Nov 2025 15:02:12 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5ACEG3Rl011369;
	Wed, 12 Nov 2025 15:02:11 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011019.outbound.protection.outlook.com [40.93.194.19])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vaeb0wf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Nov 2025 15:02:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TO6uyzuUVeLDNMcv3sH7SnquRT7SjWCLXRWNwJ8NkH5b6sOpChWP3PBgfUzEO5XLoV+PyU/nSljcKLYQlHbLQ/G+KB+M/07wtjT46y9149F8kSkZzm0IK47SFaYRWGLzEYPFuQwl60cSGmrU65Rekrpu/bgnhJVEhoCqFT7oUx5xSKSmg8bopRozirHL0LFlKEVx9jVp+ELH+E229VGTtbvI34hEFoDjg1kfDYzU4bD+qf8mcMYd3Mw2D/mYglo0EpeTCTBz3Tml4sl+U/gsNoBK4C2dUnfTjH/ffpwh2hiKHD3uxkdxUuL/I2iwPZBAyxpoz0gcrQFqXmqX+5eBYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wjIzGTXgBx3SxAUvQnG1d6V5tk0hw6RUcBUt3YIHfls=;
 b=NTV1XEO85cYtMnZaPa3acGY56/B0ceFXMJKZHAiZfbcnUFtwUJb+v+qMyBScK28mrN8+POKPtLnm+oPeX6Rgq68g/CPVOJm+vfPCAEewsvnlys+jiLgTlu5UwfZYwdmY6II4F1PwJA2z2rgVlo5BeZoy848T0pe3UIkCWGKvV1N/y2hh0XNcBOZJ5dn7oZ2uNiTbi8obzYb3aSJPdXnme+ZmgIAZKrZU36yCnUd48DsOqV3553q3Xk/We0UXcbJG1h4WuPefa3LxMAEG+MR4nvdrK88QengicElYbdslTcby4M93Kphqx9VZ2DxJmlcG8+CQHPOArPAZ4Fn6LiGaUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wjIzGTXgBx3SxAUvQnG1d6V5tk0hw6RUcBUt3YIHfls=;
 b=bvrm+/0YqayNx5ujwT9seppluwLXS341Oyicp1gVs7HIU/5wQwbqeL/NRYa6YvJZIsXgwiVqrpt6UKIzPbRRvTJgafO9NLe8FufFNevJyi2aJmKIx0BZKuutloq4hlF1DzzJKNqQpDJXCvBDj3Nv8FxN+mBuMr9m1M4WI1nFh/M=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH2PR10MB4182.namprd10.prod.outlook.com (2603:10b6:610:7a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Wed, 12 Nov
 2025 15:02:06 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.9298.010; Wed, 12 Nov 2025
 15:02:06 +0000
Message-ID: <265384ab-c2d5-438d-9071-25fdd7ea724c@oracle.com>
Date: Wed, 12 Nov 2025 10:02:03 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/6] net/handshake: Store the key serial number on
 completion
To: alistair23@gmail.com, hare@kernel.org,
        kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
        kch@nvidia.com, hare@suse.de,
        Alistair Francis <alistair.francis@wdc.com>
References: <20251112042720.3695972-1-alistair.francis@wdc.com>
 <20251112042720.3695972-2-alistair.francis@wdc.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20251112042720.3695972-2-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR08CA0013.namprd08.prod.outlook.com
 (2603:10b6:610:33::18) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH2PR10MB4182:EE_
X-MS-Office365-Filtering-Correlation-Id: f153edbb-36f0-4155-7b50-08de21fc71de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OWkxZ0t2UnI1cFhiU1kzZkppdTBNYXVOQTRQTFJ5OC9vclhTMTZ3S3k3bHZO?=
 =?utf-8?B?czZxY0hqeDJPb1BKaEVuRlhzSmdxbzUvSTZGNHNvazg1bXIxVFJrNmpzVWJ4?=
 =?utf-8?B?anZxT0dKSTFjVFhBNU5FSytwclA4Mk9RK0RnMmFFYloxclZONU9tOVY5TUw3?=
 =?utf-8?B?MWZ4WFFKUDhwSkZvOVdINVEzOHhoVS8rNDg5WmRDNVRJVVVFQjl6ZlJLVzRp?=
 =?utf-8?B?UjFUVW1tRi9ZaE9xZlZHV3dERDNlVUdNcDQyYWtITjY1V0J3N2h2L014eHNY?=
 =?utf-8?B?K1ltRy82UEd4dG91NmhVeW4waFQyamowcERibHl6UHNDNE5SZDRwUWJQM1d4?=
 =?utf-8?B?czFkY2xwY3NNL0NlL0pKQnBRYzB0SUJZK0t0dFQvRElHK1M4eGNxSTVNb3Ja?=
 =?utf-8?B?dU9qeitUQVQwLzFzUzFvZkZOQXV3NzBQRG5ad3FRK3VIUHpwR1RwT2gvOURF?=
 =?utf-8?B?NWFjVlFOUVRhSkkxWW5qK0lMNk1rUUY1RVRuVlBJRW9jNlhQeGtkTkdwVE5q?=
 =?utf-8?B?bk1TTDJHRkdUUmkwTE44ODhyMDlnQUtvbWlRcnViZUs5MmhLZGhtUFFLMWVu?=
 =?utf-8?B?VFRzR2l1S2E1TmZYOE5Rck0yVXdFSmU0MkczQVppd2pLdHVDUm5vYysxRWJs?=
 =?utf-8?B?eFpoRFd3bllzaUxlMnM1eHhkNFFhbzN6TlBFVFpXN2ZQYmFmUXViTjVKaHVG?=
 =?utf-8?B?cG5CeGhBZGozODYxU0lvaEg3cGhmRGNWWXBDVStCVTZCdHpkMjltYmMxc0ww?=
 =?utf-8?B?UktKT0E3ekZDUDRnZnFhMTkrcVhQMU1CVExkZGlDV2RnNWJRbWpYYVc1SUVs?=
 =?utf-8?B?bEY2SnFLTVQvbVV2aDIwUlBaLzVaMWlOK045M0hWaTIxYUhXUWJTc0toRlNU?=
 =?utf-8?B?RGdvWS9TeWNYN1pQamlSVkMyditHbGV1SWtyUFpWUHlOcmI4dkVvSnlVR2dB?=
 =?utf-8?B?ZVhqMmVmQ3FIOVZQMXJFdXloNjYvUGNrbGNXakVpeUkwamd0cjVyUFV0emZ6?=
 =?utf-8?B?UDNzejZFaEZQOHdEZXNlNTVmSkttN2k2dUhtbVNLMmtsT3FmSElSdmxBYXB5?=
 =?utf-8?B?R2JPQ1h1emFPWnRHRjRQZE1SSkx5OHZOS2RMRUdhbHU0R2w1MWV0NEI5eFlU?=
 =?utf-8?B?OXVxNUtma2lLRnpndjBSbTRKT05YUW9JM1JXazhIZDM4MVI1S0VyOGQ5K21N?=
 =?utf-8?B?MTRrQ0hzdnBHVDlPRjBiWURSdUw5Mk5Zb0RhU2t2anRITHB1VlNoay9CdUtx?=
 =?utf-8?B?NHJZYjcrMG1lZW1hM0U0RHpxcXRCdGRzNnJ1enloYjd5SDFoeWFNdnplNktL?=
 =?utf-8?B?WTNodnpDdlRIWTZ1QzZIdUlQSGd5MWNoQytJTi9CM2w0ZlVEYld1VE1BaVF5?=
 =?utf-8?B?WS9hLzNmTDk3b3dhRG80MXZ0UVEzNU96eVZleVFuWU9DaCs5MkhCbHdZMlJw?=
 =?utf-8?B?aGNRTDhJYTVpY1ViTkY2TzEvYzFSREZZWUtoTjdYdU1MeG1wRFZRYnBqVzhP?=
 =?utf-8?B?aEV6LzBuL3kwbzh0U1c2L3JVSVZqaCthUjlhTWRIUlQ3MXNBaE42aFMrQ1ll?=
 =?utf-8?B?ZktFUnl6bit6TzVNY1p0MnZOWjBiM25ITnk3MmNzV25DalVZaVArN0tHU29B?=
 =?utf-8?B?WTJXTitOSG11U2cvaVA1L1BXSU95dEk3a0RMRWZsMW4vd0FrN2t0Y0lMd1ps?=
 =?utf-8?B?UzRjaHNsekFKS3JyZExGK2hacElHSzZSVXZtQWdQOGhBTUlud2JBb3Njc09L?=
 =?utf-8?B?MW1OQnExTE5ENzQvV2dSaVZIVEZ6ZmowdTcxMmprOFZKMEk5R2xlZTdIZFdw?=
 =?utf-8?B?U2RHdWtEZ3FVR2ZPNHNMSkE1eWRGUGM0cUVFaTNBOEdvUVo4ZmZPa05qTGFR?=
 =?utf-8?B?b1JoL0RicU1yRFd1N01TMzRhZUxGcmtsNVJ3Y2FwRUNsc2psRkFCUFZIY0pw?=
 =?utf-8?Q?xPZTmICBcr20/PdxeR030wnpJJ/hIbvW?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V21HSjZSTk00aXQ2LzQxZktuZldyeGFMdjdFNDNjVU5WRTVneENueThZYS8z?=
 =?utf-8?B?YnpFNDBGZWdqRXd6SUNrb2lDaUxTRjN5d0Nobis0bFpRbm5zOEd1SDBxRERk?=
 =?utf-8?B?VmhUc3l5RnZ1bVUvZ01TVDFxelBteFNaSENBL1lhTXVQYklPVTFNblExTUlT?=
 =?utf-8?B?L2wwMzNhbitucGx5aldZUkYrUTI1RDcwSlVSOS80WHQ2WXJXTUYxcVAyd20y?=
 =?utf-8?B?VER5YS9mY2czM1lEbzd0NXRiaERtVTl2QUNUTFpETldHQnJEbzZOZ25WZk54?=
 =?utf-8?B?d0YvSVYvRUw0TnVsUXlHNlVFcllFd0tnZGpQRTFsUVBZUExyM3l4T2tTZjJ0?=
 =?utf-8?B?K2hhM0krdW1hdXRjWWU3cXh2QkdLRWh5TkhEQ1RGbzFFTHlvUFlJRjdQYk9s?=
 =?utf-8?B?UTI3c2JnaFBMeXFZZUdWdFZtcTByazVGYXdXRHBhenNoMHpFdzRGcms0UTNZ?=
 =?utf-8?B?YUI1SlQwRzhRd1FwbkdHQk52aGJuNjRMMXp3MktYUUVleVhJb0FlQ25kd2VZ?=
 =?utf-8?B?RVVIQkxoVU1QU09WZVFUV2pBL2huVDVCRWExaVoyUStLU09qL3VIeGRmSDYw?=
 =?utf-8?B?VmM2QU9nSFVPY0xBeW1YNlJWMW04Vk9TM1AwdS82VG9oZm84RXVtTVZRM2o2?=
 =?utf-8?B?NERDeFRuVkFvVVh2eFVzalJCcUFXNWlHY2E5MDlxT3NaendpM1JZNW40Zm1l?=
 =?utf-8?B?Q0pMeWdaR21jREJXNmhEaWJnaWtCUTRvblQ2UStlY2huSDNxNGUySzVTL0tP?=
 =?utf-8?B?Vy9PUTd3aWo4cHVJeFkyaVpsNzdZUEFzYVZweVBJeWJXQnVjZ0JLMGVIREUx?=
 =?utf-8?B?Q3dDZzVvVGIxaW1OczM5WlZYTE04eVBVaEdWVmZjbFBpNXpqL3h5VEh4VXFX?=
 =?utf-8?B?dEZqQys4VFFISStyZzZSc2RZWVFTb04zU1MzWm00bzdPTTNEYkZKSnJFM0Fw?=
 =?utf-8?B?eXJ4bC9rbGJXekxVaU9ockgzMjNXbzYwMUp3aVhBaHNaa25IQk9rYWVyZFJ4?=
 =?utf-8?B?MWJVSE1HNm1OVi9uTVFxMHVBQXpCczZQRGR0YUExbUEzK084SnlGT3BUZStu?=
 =?utf-8?B?TmtnQjNTWWtPT0t2eDEydW93Syt6djVoeWZ6NmpRWFpmNG9zQVJJQjRYZXFm?=
 =?utf-8?B?R2cwL0txLzVnRGMwc1RIY2wrZVVoc2txSDg1ODZoUXlzbG1MTThYM04ybWEz?=
 =?utf-8?B?bEt0MjY2OEUyNnNZaXJMZEJEaWhqVWZaRG1aMDcwMm9QWVAzK3hBMTkxUTRN?=
 =?utf-8?B?UmowYU40UzJXSkpRRERmZ3Y3eDBrWmZKUjJiR1Z4eGYzYmxxblNhNkVpS0Zl?=
 =?utf-8?B?R3dDOEsvT0M1Nm80d2FhTEExRkp1eGhYWTFpakJxUlFBKzFnWVY1aUg0Ritl?=
 =?utf-8?B?ZVIwRXFDTzNCSWFJN3FqTVZJaFYxMXQ4bE9uYnFzVmJLSjV4NWVCRWRJUkxK?=
 =?utf-8?B?TnJVakpDVk9udnB3N1JCcHVyS1hCSXJ1a3JubkFsNC9NMjNMcVhTQ0p2OUx1?=
 =?utf-8?B?TFVJQ1hGb29VM0RzU0w4UjMweGozRllaSFZ6aVVhUFdtT1BZRGp3KzlsOGFn?=
 =?utf-8?B?OWluTGZQMmplYzJTT3RBQ2toSko0UklTUFRVUHJkTGNlZVUzUUp5NWpIb25n?=
 =?utf-8?B?a0QyaHYwcmtPZ2FhVm5iemJZeE9uQ3hJRlhTeUlVVEpMU2w2TkhrdnVrMzV6?=
 =?utf-8?B?MjhGTkNNMGdZOC82cUlzSWRkSjVsT2JqTE1ETDhNWHVTNGlpcm9YczYzVHo0?=
 =?utf-8?B?eVRmV0Q4eXV6TWNtSlJwOURES21NSE9SYS9CanVuSnJOSkUvTkFNZTVnYWlq?=
 =?utf-8?B?Qkx3VlZGdk9iZlJGK0ZXVEswY3pXcU1KU25rTHdPTy9Fd0pSVURwRnZacTFK?=
 =?utf-8?B?eW5RTytwSlNoc1Z6SEE5dEFuZ1NNM0FkYlFDUjJSTWdSVVR6WnVLOXlPcnNy?=
 =?utf-8?B?SXdwdVJOSDAwNnZ3R3VJOFkySDZybGtiN3l6aThibVZERldGNW93UHQ1WHZC?=
 =?utf-8?B?R2NMN2hBVlhaRTVFRWFjQ2N5RE1xbk1KZm4xQm5ncG9VeVl0R2ZqNkgwdXpG?=
 =?utf-8?B?NnZ2TWc1R0EwdlFOL3hvK2tvVWkxNGF0RXNmalBkT1lIeGZpYTAwaUVCQW1s?=
 =?utf-8?Q?RCfnBwUEmNvuZs8a9hp9uteGZ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	HKdFWitF6XXUbml0i7vGca9YUVJBDVll20iikWvlfLGNwl3qh9p7jH5210w7xQTM2V2M1PN/pQ8eLzgsBc1wyKD+Ayyb3Jxwy377JCiwIhBLO0V0ni8zU5P1Y9jghsquNybKRy75azushseWVA8n4IHyYD7Zs+sxaVqjB4YrNPmxUykN2azYo7xGw/GiuknhomaicM32E0mKrIDPYBvl/75fWQWdcksIFjzeMYxuGzl0pjA+EpeQGeRNrkh1PuO+Y9Y3FpK9C5/2v3h6e9JFif+70PkU8sOtLEeeTRq+wNU1MKjKgSu42W6gQTONCE9bL2k4k4nIEkoF6kD8NSMpse1ShoBGwgyRHFwH2La3cqnaW7a/uaJ3JdJgKOXPL4PEWvRrGkNZhvh521ri05EjYz6po20dhNfiPOh3/rtrd1zODNBWHKo/CSeLftIoh3Vwux3IvgdAKGdLhvRmmaoWuUWrmA8NF5TR+Q1SQMR3aWYKScBApMcpvtZUQUDp4BlxAKPqkS3ODKc0MfigoPTZNFzM0M7D6WUNVrENIboRtP7KBnBm84vwUVwQ8CTU7658Cy0lDxJOBQWvO/ZciX2Xhcjs2oWRl30dkL7/yEoYkiE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f153edbb-36f0-4155-7b50-08de21fc71de
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 15:02:06.0214
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jK3rvcV8j7KDX51V7zQ/CgE7WzTrmr+8CtTIl13zlFSEbRwu4J8r4i1d6j77bXwQPtiUlBXCDzDskHfSNUg0ZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4182
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_04,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 spamscore=0
 phishscore=0 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511120121
X-Authority-Analysis: v=2.4 cv=Cseys34D c=1 sm=1 tr=0 ts=6914a174 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=pGLkceISAAAA:8 a=JF9118EUAAAA:8 a=yPCof4ZbAAAA:8 a=zqJBN6IEQoyygF5RKowA:9
 a=QEXdDO2ut3YA:10 a=xVlTc564ipvMDusKsbsT:22 cc=ntf awl=host:12099
X-Proofpoint-ORIG-GUID: wFxvcOXfcXbTnNkxIskJ6NJeEv76XWPy
X-Proofpoint-GUID: wFxvcOXfcXbTnNkxIskJ6NJeEv76XWPy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDExOSBTYWx0ZWRfXwe+QbKsF4y6r
 KE7uvo3ZtgUA74q5+1GP51D8yhWJxex7nA2MzUoou4mfh8/2FhmsZnlnbdaP/dli6J8zCT9l8bN
 UpapIZgw6Nc+tKk5tgCUiJA5xQGZ0y6BMHNhKpjg2BZNH1Js3aIqND2JBbHMTrOH0yrwkkjwOsq
 PF960iH7I5R9cOyT7BH2jkGfmj6Z+P7vojKrSPvySq9OZOu5N+1/Es2+wv3fDnSWnHCoJ+invyj
 VxhR6RvMejQa3BoOA+PhXLXqsmEGZGPckitjytaH8xhkVeBEEjKURDF8vQvYSbE7H/WUUzvX1gB
 J5ijWrsoEQ11ZOgJ/9Nfhy4iW5DbBBrVja/LLabG3TYqaiMaO5JskJyoZWIIVTtSIQShvnBk2V/
 PO7hlVY/9tDP8mF3Wr15Nyi24WwEcml2mSqmvICyxdPNGy9NcTM=

On 11/11/25 11:27 PM, alistair23@gmail.com wrote:
> From: Alistair Francis <alistair.francis@wdc.com>
> 
> Allow userspace to include a key serial number when completing a
> handshake with the HANDSHAKE_CMD_DONE command.
> 
> We then store this serial number and will provide it back to userspace
> in the future. This allows userspace to save data to the keyring and
> then restore that data later.
> 
> This will be used to support the TLS KeyUpdate operation, as now
> userspace can resume information about a established session.
> 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> Reviewed-by: Hannes Reincke <hare@suse.de>
> ---
> v5:
>  - Change name to "handshake session ID"
> v4:
>  - No change
> v3:
>  - No change
> v2:
>  - Change "key-serial" to "session-id"
> 
>  Documentation/netlink/specs/handshake.yaml |  4 ++++
>  Documentation/networking/tls-handshake.rst |  1 +
>  drivers/nvme/host/tcp.c                    |  3 ++-
>  drivers/nvme/target/tcp.c                  |  3 ++-
>  include/net/handshake.h                    |  4 +++-
>  include/uapi/linux/handshake.h             |  1 +
>  net/handshake/genl.c                       |  5 +++--
>  net/handshake/tlshd.c                      | 15 +++++++++++++--
>  net/sunrpc/svcsock.c                       |  4 +++-
>  net/sunrpc/xprtsock.c                      |  4 +++-
>  10 files changed, 35 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/netlink/specs/handshake.yaml b/Documentation/netlink/specs/handshake.yaml
> index 95c3fade7a8d..a273bc74d26f 100644
> --- a/Documentation/netlink/specs/handshake.yaml
> +++ b/Documentation/netlink/specs/handshake.yaml
> @@ -87,6 +87,9 @@ attribute-sets:
>          name: remote-auth
>          type: u32
>          multi-attr: true
> +      -
> +        name: session-id
> +        type: u32
>  
>  operations:
>    list:
> @@ -123,6 +126,7 @@ operations:
>              - status
>              - sockfd
>              - remote-auth
> +            - session-id
>  
>  mcast-groups:
>    list:
> diff --git a/Documentation/networking/tls-handshake.rst b/Documentation/networking/tls-handshake.rst
> index 6f5ea1646a47..0941b81dde5c 100644
> --- a/Documentation/networking/tls-handshake.rst
> +++ b/Documentation/networking/tls-handshake.rst
> @@ -60,6 +60,7 @@ fills in a structure that contains the parameters of the request:
>          key_serial_t    ta_my_privkey;
>          unsigned int    ta_num_peerids;
>          key_serial_t    ta_my_peerids[5];
> +        key_serial_t    handshake_session_id;
>    };
>  
>  The @ta_sock field references an open and connected socket. The consumer
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 9058ea64b89c..024d02248831 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -1694,7 +1694,8 @@ static void nvme_tcp_set_queue_io_cpu(struct nvme_tcp_queue *queue)
>  		qid, queue->io_cpu);
>  }
>  
> -static void nvme_tcp_tls_done(void *data, int status, key_serial_t pskid)
> +static void nvme_tcp_tls_done(void *data, int status, key_serial_t pskid,
> +			      key_serial_t handshake_session_id)
>  {
>  	struct nvme_tcp_queue *queue = data;
>  	struct nvme_tcp_ctrl *ctrl = queue->ctrl;
> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> index 470bf37e5a63..7f8516892359 100644
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c
> @@ -1780,7 +1780,8 @@ static int nvmet_tcp_tls_key_lookup(struct nvmet_tcp_queue *queue,
>  }
>  
>  static void nvmet_tcp_tls_handshake_done(void *data, int status,
> -					 key_serial_t peerid)
> +					 key_serial_t peerid,
> +					 key_serial_t handshake_session_id)
>  {
>  	struct nvmet_tcp_queue *queue = data;
>  
> diff --git a/include/net/handshake.h b/include/net/handshake.h
> index 8ebd4f9ed26e..68d7f89e431a 100644
> --- a/include/net/handshake.h
> +++ b/include/net/handshake.h
> @@ -18,7 +18,8 @@ enum {
>  };
>  
>  typedef void	(*tls_done_func_t)(void *data, int status,
> -				   key_serial_t peerid);
> +				   key_serial_t peerid,
> +				   key_serial_t handshake_session_id);
>  
>  struct tls_handshake_args {
>  	struct socket		*ta_sock;
> @@ -31,6 +32,7 @@ struct tls_handshake_args {
>  	key_serial_t		ta_my_privkey;
>  	unsigned int		ta_num_peerids;
>  	key_serial_t		ta_my_peerids[5];
> +	key_serial_t		handshake_session_id;

Please follow the existing field name convention and add a "ta_"
prefix.


>  };
>  
>  int tls_client_hello_anon(const struct tls_handshake_args *args, gfp_t flags);
> diff --git a/include/uapi/linux/handshake.h b/include/uapi/linux/handshake.h
> index 662e7de46c54..b68ffbaa5f31 100644
> --- a/include/uapi/linux/handshake.h
> +++ b/include/uapi/linux/handshake.h
> @@ -55,6 +55,7 @@ enum {
>  	HANDSHAKE_A_DONE_STATUS = 1,
>  	HANDSHAKE_A_DONE_SOCKFD,
>  	HANDSHAKE_A_DONE_REMOTE_AUTH,
> +	HANDSHAKE_A_DONE_SESSION_ID,
>  
>  	__HANDSHAKE_A_DONE_MAX,
>  	HANDSHAKE_A_DONE_MAX = (__HANDSHAKE_A_DONE_MAX - 1)
> diff --git a/net/handshake/genl.c b/net/handshake/genl.c
> index f55d14d7b726..6cdce7e5dbc0 100644
> --- a/net/handshake/genl.c
> +++ b/net/handshake/genl.c
> @@ -16,10 +16,11 @@ static const struct nla_policy handshake_accept_nl_policy[HANDSHAKE_A_ACCEPT_HAN
>  };
>  
>  /* HANDSHAKE_CMD_DONE - do */
> -static const struct nla_policy handshake_done_nl_policy[HANDSHAKE_A_DONE_REMOTE_AUTH + 1] = {
> +static const struct nla_policy handshake_done_nl_policy[HANDSHAKE_A_DONE_SESSION_ID + 1] = {
>  	[HANDSHAKE_A_DONE_STATUS] = { .type = NLA_U32, },
>  	[HANDSHAKE_A_DONE_SOCKFD] = { .type = NLA_S32, },
>  	[HANDSHAKE_A_DONE_REMOTE_AUTH] = { .type = NLA_U32, },
> +	[HANDSHAKE_A_DONE_SESSION_ID] = { .type = NLA_U32, },
>  };
>  
>  /* Ops table for handshake */
> @@ -35,7 +36,7 @@ static const struct genl_split_ops handshake_nl_ops[] = {
>  		.cmd		= HANDSHAKE_CMD_DONE,
>  		.doit		= handshake_nl_done_doit,
>  		.policy		= handshake_done_nl_policy,
> -		.maxattr	= HANDSHAKE_A_DONE_REMOTE_AUTH,
> +		.maxattr	= HANDSHAKE_A_DONE_SESSION_ID,
>  		.flags		= GENL_CMD_CAP_DO,
>  	},
>  };
> diff --git a/net/handshake/tlshd.c b/net/handshake/tlshd.c
> index 081093dfd553..85c5fed690c0 100644
> --- a/net/handshake/tlshd.c
> +++ b/net/handshake/tlshd.c
> @@ -26,7 +26,8 @@
>  
>  struct tls_handshake_req {
>  	void			(*th_consumer_done)(void *data, int status,
> -						    key_serial_t peerid);
> +						    key_serial_t peerid,
> +						    key_serial_t handshake_session_id);
>  	void			*th_consumer_data;
>  
>  	int			th_type;
> @@ -39,6 +40,8 @@ struct tls_handshake_req {
>  
>  	unsigned int		th_num_peerids;
>  	key_serial_t		th_peerid[5];
> +
> +	key_serial_t		handshake_session_id;

Please follow the existing field name convention and add a "th_"
prefix.


>  };
>  
>  static struct tls_handshake_req *
> @@ -55,6 +58,7 @@ tls_handshake_req_init(struct handshake_req *req,
>  	treq->th_num_peerids = 0;
>  	treq->th_certificate = TLS_NO_CERT;
>  	treq->th_privkey = TLS_NO_PRIVKEY;
> +	treq->handshake_session_id = TLS_NO_PRIVKEY;

Please define a TLS_NO_SESSION_ID symbolic constant for initializing
this field, which is not a private key.


>  	return treq;
>  }
>  
> @@ -83,6 +87,13 @@ static void tls_handshake_remote_peerids(struct tls_handshake_req *treq,
>  		if (i >= treq->th_num_peerids)
>  			break;
>  	}
> +
> +	nla_for_each_attr(nla, head, len, rem) {
> +		if (nla_type(nla) == HANDSHAKE_A_DONE_SESSION_ID) {
> +			treq->handshake_session_id = nla_get_u32(nla);
> +			break;
> +		}
> +	}
>  }
>  
>  /**
> @@ -105,7 +116,7 @@ static void tls_handshake_done(struct handshake_req *req,
>  		set_bit(HANDSHAKE_F_REQ_SESSION, &req->hr_flags);
>  
>  	treq->th_consumer_done(treq->th_consumer_data, -status,
> -			       treq->th_peerid[0]);
> +			       treq->th_peerid[0], treq->handshake_session_id);
>  }
>  
>  #if IS_ENABLED(CONFIG_KEYS)
> diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
> index 7b90abc5cf0e..2401b4c757f6 100644
> --- a/net/sunrpc/svcsock.c
> +++ b/net/sunrpc/svcsock.c
> @@ -444,13 +444,15 @@ static void svc_tcp_kill_temp_xprt(struct svc_xprt *xprt)
>   * @data: address of xprt to wake
>   * @status: status of handshake
>   * @peerid: serial number of key containing the remote peer's identity
> + * @handshake_session_id: serial number of the userspace session ID
>   *
>   * If a security policy is specified as an export option, we don't
>   * have a specific export here to check. So we set a "TLS session
>   * is present" flag on the xprt and let an upper layer enforce local
>   * security policy.
>   */
> -static void svc_tcp_handshake_done(void *data, int status, key_serial_t peerid)
> +static void svc_tcp_handshake_done(void *data, int status, key_serial_t peerid,
> +				   key_serial_t handshake_session_id)
>  {
>  	struct svc_xprt *xprt = data;
>  	struct svc_sock *svsk = container_of(xprt, struct svc_sock, sk_xprt);
> diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
> index 3aa987e7f072..5c6e7543f293 100644
> --- a/net/sunrpc/xprtsock.c
> +++ b/net/sunrpc/xprtsock.c
> @@ -2589,9 +2589,11 @@ static int xs_tcp_tls_finish_connecting(struct rpc_xprt *lower_xprt,
>   * @data: address of xprt to wake
>   * @status: status of handshake
>   * @peerid: serial number of key containing the remote's identity
> + * @handshake_session_id: serial number of the userspace session ID
>   *
>   */
> -static void xs_tls_handshake_done(void *data, int status, key_serial_t peerid)
> +static void xs_tls_handshake_done(void *data, int status, key_serial_t peerid,
> +				  key_serial_t handshake_session_id)
>  {
>  	struct rpc_xprt *lower_xprt = data;
>  	struct sock_xprt *lower_transport =

Aside from a few nits:

Reviewed-by: Chuck Lever <chuck.lever@oracle.com>


-- 
Chuck Lever

