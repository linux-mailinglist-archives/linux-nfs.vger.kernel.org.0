Return-Path: <linux-nfs+bounces-16341-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A27C57EEC
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Nov 2025 15:27:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAF283B85D3
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Nov 2025 13:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5075823A99E;
	Thu, 13 Nov 2025 13:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LCpTXoI5";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="pnnKWnRQ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98FEF239E9B;
	Thu, 13 Nov 2025 13:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763042179; cv=fail; b=q52sz64XHaiM3jvhHjqrGg7nWqgvSBLYZ8uiViW/lfoMULSmtrWMpYxzG0dtK/wjjPAkGbQxRJkpzJUB3gWpTD0su2xfmGtvVYplL9fwZU4iWMPl3xNGF1+XPPlaLfqYJnsyqVQbVi5MdqTO802ezzbKgnSNDYHukYZScvjx5ck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763042179; c=relaxed/simple;
	bh=x50vR+yEkTE6ecMo8BiQoHM1EN/lRIJYOPsPMLCwrsg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WIODxbh1BsptHUYOFLO7K7/ou4DmrmWWepjmZX32MxJCsoDbs84Du+8oARP/b1THAewa0it1vEJKjsO1MCUJqzhkWat2ngLArxke0COGZ0aMcijLgHWMG1zvOhzf6T220dJ62I7Oh0sz4viPrFxsY4cVPK2YNzXN6Xcf/5KBRiU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LCpTXoI5; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=pnnKWnRQ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ADCUavI023170;
	Thu, 13 Nov 2025 13:56:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=GHbr/iHJex9MfnaaLiRkhV0+5aHJWfy4IIMClL8EvtE=; b=
	LCpTXoI5kr9yvAlluWJg6UBY0kq8yzSy6DU9RAfr2RZ4X22up1uBthwpXg3UXaZ6
	ewX4QSbY69ZrFF+7AXnHdsG040isToalj9b7HtFZvo177prgVk+Du9UGpXfkK2hz
	4AUqfDfqUCAcpzNLF5fqSZu8lO2/XlMbgwo0eln1yg3Gx5ovzglNp+6w6YUmtLP0
	nBm8bhZUNXmrI/burmm8c5ijdQbDjJmyLqHFqS4C7BpPRF0+lDS0Qvdc4aagLY/C
	r8D2sxtbbcyzs3YdRsuDBQNms0WX9UgYSiVWh/OxV8Zkvd2WrUvasTe0mnNTaN5q
	AeLMcqdrEC0MgGdjtqdiIA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4acvsst8ny-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 13:56:03 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5ADButeQ010789;
	Thu, 13 Nov 2025 13:56:02 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012020.outbound.protection.outlook.com [40.107.209.20])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vanww2x-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 13:56:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v+XEUrPnexUS++QAGWJZAyffHA3rTLWx+389Qw+yDTDNuoTpWj4GsKJxmnlO4ltMqENBx4mxDnT3SbPxwkkrbG0umUwDctvg2iSteKEjYY/MJJEQdTdUUb7BAcW9HzCVWrRCb4otczf0d9IJKuMoEMGhaBMMcuJCQ+V3ZIzfaz299iVi3Tg7v49jqTHXnVoezGsocZfwN0gJSlnSSfxEDjbsHvieXX909nlvRfjXWlkhqJJ9K4nh1l68c0IP+YmS+HVRx8iHUTniUMNN9/bGE44ZVWbxjMl5L0ehZo5VCQQs9TF93szl+S0NTCrZX0A8CyrOnNq//XRmSDPQzlQ8kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GHbr/iHJex9MfnaaLiRkhV0+5aHJWfy4IIMClL8EvtE=;
 b=kvuaGiqyp7WLf8gqs3FROhttf5/GxYlaJkqcDjHMv9MxZ5BS74OgBQMwlcNAznBvRtAJiaSpHcvamu+EfBmMuZaaAZiB9CGFXKPybKg0KiT741ZTLB5luwU/YXhJY/wgBPgFX+LLLmVOt3Ab0Zuc60uQOT3dInYj41FlWJKf5xFkUgVYbPy5iqVEpl+iFIFKAqWKwjlhOQtzZG1iVnKjz4L1Lp4I8YjPzAbTvOlx4aT3dgJDr5zcMZb8wIddCimHn0goxzV/P+7Fp2mrMP1Qk/FU3Mk9ofsqogFu6ag6Qy4HsjRryp660SkDB68jwjF91dIBkJM7OIIHpNM4LB1x2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GHbr/iHJex9MfnaaLiRkhV0+5aHJWfy4IIMClL8EvtE=;
 b=pnnKWnRQyU5uP3bqwU6lMOejko+muKQalMPhFuY/FCoT7lWlPfM+QL/tZDFYXHPOMZH4SaCZJLf2AWjZ1K6naAsE8uoc/XFKRh4ZiWkDSD9GhD1anUGZD1DRcslG0j5VcFO5d7frn9ykl8rlWkiOy6UMhn6aJm1y5DsveCLaVQw=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH8PR10MB6623.namprd10.prod.outlook.com (2603:10b6:510:221::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Thu, 13 Nov
 2025 13:55:52 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.9298.010; Thu, 13 Nov 2025
 13:55:52 +0000
Message-ID: <28311b28-f6f9-4d41-9ef6-c1977b932073@oracle.com>
Date: Thu, 13 Nov 2025 08:55:50 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] nfsd: Mark variable __maybe_unused to avoid W=1
 build break
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Cc: Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
        Bill Wendling <morbo@google.com>,
        Justin Stitt <justinstitt@google.com>
References: <20251113083131.2239677-1-andriy.shevchenko@linux.intel.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20251113083131.2239677-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5PR05CA0019.namprd05.prod.outlook.com
 (2603:10b6:610:1f0::27) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH8PR10MB6623:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e1faeba-4d7c-4b16-cf2d-08de22bc5c0a
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?ekkvY1R0UGRpZ1Z1ZEozWTNBTmFveGgrbHdXMkRyQmFmZzFxTStUOFVsQVFq?=
 =?utf-8?B?RjdOajRHeFBrZUpvNWVINnU2N1FaNUJMblJlaWRWWHdJYkJjY294WmlPUEE4?=
 =?utf-8?B?RGdScTl3K0hsN1Qzc0VsTFpISE5HNzRBbHRraEM5cUJkWS9NQ2IvUFVlNHB2?=
 =?utf-8?B?WWdZcW42aGlBWHJTaEVsMDNaRVpWYzVNUFZBOTFSMUoyMGlEL3RIMk1iaVZG?=
 =?utf-8?B?OXVIU0ZVeGFaZXlZUlBZekRUZ0VHU2l4dER2bGZNYUpnMWNEL0doQ2xqSC94?=
 =?utf-8?B?V0oraWdXRjNkL1BJZ0swSE5HSndGTmNlMThSc2NiakpWc3FFbFNWeG5MRk5I?=
 =?utf-8?B?ZGg0Z1E3REQ2UXc4ek5raDBtbDVoY1c5M0ZNRG4ybklvYlBuT3FheWZXanV3?=
 =?utf-8?B?bnZEL2R5dExsM0lORjF3YnVVaHJHS1V1eGQrbDRtQlhpNzB6UHpSam5mbXdG?=
 =?utf-8?B?ZnJWdFhhSitkNDEyVjY4WmRKKytEWng0OWNoMGUwdFh2RE80Z1k4aHppNTNM?=
 =?utf-8?B?NjJ6TExqWmJzNXE0aVFTRCtZVzdJRFBndkpQRzhNL00ySTdVTVltTzlOTThT?=
 =?utf-8?B?aWZ1b2o0TWthZklhUkgrQ2lCTi83eGVXdXlvc2J6TVFFaDd1cGNyT3hGV3Vp?=
 =?utf-8?B?ZlBhOWtRLzZ2dmtBLy9oRVBDdG5CdmoxNDF0anN4QzcwdERXQ0U5dHNFZXMv?=
 =?utf-8?B?L1FCY1EydERveXRjU2Qvc0hUdndWemFnS2tTR0JSL3E2My9ObHowOFZqRGVX?=
 =?utf-8?B?bDZNTWFGNnBOUEVBU0xsQlF1SVZobVloc0J4b2FVZGVoU2FwZUxuNUtoYW1r?=
 =?utf-8?B?R3V3Zm9QRlhjZDlBa0VjN3dnbE1xT3JXeE5ac3Q5RnBCT21GYldWRGtsQ1Jo?=
 =?utf-8?B?TWZkUk40NHdQWmp0TEZzSDhaVmcrUDd5TEJodnNEU0JyQnJOajVYQjBYMEJt?=
 =?utf-8?B?ZXovUW9FWkdBZEo5TXUzaUVwdEdwSlI4aVR6RFJVaUZvUHd6M21kZWdkem1l?=
 =?utf-8?B?QjhxaFpDQ1IrUzJ0dDNRY0RSWU1OUFBDR01rTXB0WklPR29pV1U2NkdqcU16?=
 =?utf-8?B?RXdsQWxkdy9ScGRYZXZjbUlLY0pkQkRoa2wrZERvcTdwcWNReWNLbkFrbk9V?=
 =?utf-8?B?ZVZ4WllCK0JOTEpqU2E5VnlxSXc5OHRNZkFuY1UxOFVrdFF0d1VjRGY3ZGFS?=
 =?utf-8?B?OUpLZUExQ1lSek8zUzg4enppL0R4Qkl5ZDUyMXAzVU5pUHRCd1R1THVpOG5Z?=
 =?utf-8?B?bi92R2wvblQ3QWd6S2dKZFZQWUF1WTM3QzVsVFFnUFJpd0gxa3BCa3d5SmtJ?=
 =?utf-8?B?VVIvUEc2cTJBL05aN2dtaExhR1JvbzU2aFlScWFoRXAxcDVncUJRcFYyV1li?=
 =?utf-8?B?V3VtcjVVWVFzNDNVcC82K0xUYlNieGNDcVJzNUlsblBsT21ncEdxTWJ0QXpV?=
 =?utf-8?B?S3BFNlVJS0FESXk4aUxFTkFFSjBid1loZW9nR3MwR2RWZ0Z5OGFYemJVWXBI?=
 =?utf-8?B?dnc5a3RRWnBSL05rTmxkdWYrdks5dzRldXJiWEV2WVM3VXZIZDQzNk4xbmNK?=
 =?utf-8?B?SkhuUEdFZStDZFB4WXpQbUQ5bDM0MW5xbmhEMnRUZ1dMem5lM1drbENqOEVK?=
 =?utf-8?B?aTNRb2RnR0xrWjU1K2ZENkpBU2JVSFlobTZlcld5cnQzSzloVUZRTnV2Z3pw?=
 =?utf-8?B?UWg4Qk5aak1SdHN2TG9lejFzR2F5alZHcGNUVXZQOHUwaERQU3ZhYzk4OUFo?=
 =?utf-8?B?RkV2czhKUU1jUldzNnFFVUJXYUdGLy9obE15cWttaFlpbUZOUUlwRmYxMlM2?=
 =?utf-8?B?NEdQOEdDd2xYdnp4N3JRQXJLNE1EYzF6eUVSNklyN0NZTmNwK0VWSDV0b0VM?=
 =?utf-8?B?NjRFYWVDN0JibUJPTExOOWhES0pZOFpVR1ROanlBTVBaekZjTEZsTnVzL21z?=
 =?utf-8?Q?rnl/AYtHpbVrBTeSHgNiwa7N0sXnSzGb?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?Sm5EMTVqQWhlZG90dm9McDFJbElvVXpjV05LZVBUbHhESlRpdVlGbnlvNUZx?=
 =?utf-8?B?Qy92dEMyRmp0KzAzR2RuK0pQV0RyMEptS29EcnFNZks0aVlKclpkQ3dPb2tH?=
 =?utf-8?B?aFlqNWdFTlM1RHdCdnFDRFdMOGN3UHlXa3JLMklXOUhPeFJlSkR6TFZqaVJk?=
 =?utf-8?B?K1MzbWNwQlRCd3BXcWVEeXNHZjI5Y2dBbWRqbityMm9maW1GSmpRcXM5YjE1?=
 =?utf-8?B?Q25RUmNUUUV5NFdTREdQQkFOWENZL0Q4U25KTGlKeW1pai9XL0pZbmpQTElW?=
 =?utf-8?B?YkJIMnRJaUdwVFVTN2FkTkFLL0kxUkkxWk1aMHp3SWR6TUFRMkZ4YmJZYmRl?=
 =?utf-8?B?S2JXQjN1RG1KVXN0TGRkR2luMlY4SG4rR3pPdVdsVHpyYmR6bjBJbExUajNT?=
 =?utf-8?B?ZE5XdTBQcEZxQ0MzZGJRTHhadW5wYVJuQldEUEFmUFFJVVVMNG5WK29OYm42?=
 =?utf-8?B?WWRsdm9PaGgzYThqWFdFTTY2bHZJQ0hZcnJUUHF2N2lEMWlYeTdEa2ppVVBi?=
 =?utf-8?B?MzV1NUlwSUNlV1B6alRmaW93SHNpWjVTaE9RL21SOUpvVmdCM0xNbSs4ejlO?=
 =?utf-8?B?UUtjb2VDTmxQc0RnQjBtWGtJRFpHVldSMHhtVWFkblVsbGxNbWJ6M1EyTnhQ?=
 =?utf-8?B?cGpkNUFzejQxWHZIS1VKeTdPSSs4ZEF6UWRzSGMyRkp1OEVERWptT0NYc2xj?=
 =?utf-8?B?N215dU04aVZBZ0dxd2hVbUtnZzJjd281OENmZTNnSlpmR3NiQVpSV1Q2Q3Bq?=
 =?utf-8?B?cDBrODl5d3d6QU9wd1gwcytTcGlwVTlCK2Y0b0xhc2N2RnVVdlJmNndsakZj?=
 =?utf-8?B?eEk5dVgzOENXZFlvWHU5SitOSmtPK2x0VzQvc0xFL0hNMVdLc3NZcUdubTRW?=
 =?utf-8?B?TXBPeVJnOGpIU2pLSCtSc2ZUYTlGN1NkaDFvTXZwVUswNTZpbGlmbUVTRTN1?=
 =?utf-8?B?bXAwZjVCaVNXKzI0K1JpM2ZLclBjRkJQd3lhTDllOUE2emxQZDd0ZXBmT1Ni?=
 =?utf-8?B?SC83YWhqdStzbWJJTExIUVEyclFBcE93Vjl4eUUxVmhUUUFKQUFZamc0N1Bt?=
 =?utf-8?B?YitHZndqcmRwNlNJTTJmK0VxUkpnVUxQZFdBclFvRzBaTWhpTHhnT29Uc29I?=
 =?utf-8?B?aDZDeGNDMlJ6MFRkNWZUZFNOZ0F6SzkweVpuTEtoREp5dUFqRDBXcE5uYnlF?=
 =?utf-8?B?NUlSYTEzMVZ6aUVvbHB3d1hhMUxDTVFtdEt0MHRmd3BzQ2RUcVlJSFhPMUFJ?=
 =?utf-8?B?aUFTdnVQcXpLNG1lR3pjRlpVSFpUL1piR28wUWU2ZjYwMGk5blJ5ODlrSWRK?=
 =?utf-8?B?WU01UHgxWXJYN01VUzAvZzdoUy9sNFloOWF2UkdVVmJHSTVCNkVLY0htU0px?=
 =?utf-8?B?N1NUcFpmODB2ZnhQR3U4djZEbUpaWXNpVHZDVStadGpEQVAycGZheXlOdUY1?=
 =?utf-8?B?YUFTcDV0TGNSN1lFSmZ3ZTdTN2huSGJVRk1jOFQ2REF1bkhrRlFqTTJRNGhU?=
 =?utf-8?B?VVNsK1hxaFpCVldwOExhMjV6eTk5cE5vaUw5cmR2SVpFR2tjUnQzNVVXaVdK?=
 =?utf-8?B?U083VEZud3dSa1IxYnZZL0grZWMyQWhudmJUcGhzUHZtdEFkdmtXUDlZaHNN?=
 =?utf-8?B?U2wzNXRLRlM2MFRVeUlJN0tlTzFOdDhGeUEyU1Jjajc5SG1aQzJZUGVMdzVM?=
 =?utf-8?B?MTd3NlFWQVYxSGlWbGFTYUE3S3lDQk12b1pCVGhrU0lRbmNtQk9xZUdrclRD?=
 =?utf-8?B?YTBwQ1c4WUtWZkZTRjN0VGh3Q2dESGd6SlR5YUNsY2wwelJrSnN3SDFGVFJt?=
 =?utf-8?B?RWdMVG1hdEVoY2toZHNoQ280eTZyOTFqLzRwUjBzQlZ6c0Z5TExzNU43V282?=
 =?utf-8?B?cVh2SWZWSllKYzdIWjZwYnZrWTVlOG5uN0ZIallIa1lVakxLT2tuT0RoWXY3?=
 =?utf-8?B?SXkxK3hobGNnY21jcDEwUFBiTmplYnlEdnRVdWx6TTR3SnZndnB5VUtNTGFq?=
 =?utf-8?B?NVNzOC9PMzVRdUJTcmY3ZWxGQkhISzRVZWpKN3ZQU3VMd3grYThMTUt4eXFB?=
 =?utf-8?B?OVV3RmZ2K1pNWTF4dG12NzUzNFFTSnRwOGFRUnZBZTRENzF6WEJrRXdKZXZ3?=
 =?utf-8?B?TzZPK0ErR2t5UUJSaktneURyRytlc2JLcHFDMkZVcjF1STBkZU1ZeFFGTGM0?=
 =?utf-8?B?cmc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	zlSUwmeGUB0qReDuGlpPNW402NAq2akJYLexo85kJm8HKk43PTwr7XirRanTCf4Kwgbx5DQoyFIzc8bgO/Uqlb5h9fV4nrNSozSEErJYQjt3vPfm/FSJ4WbnV6JsPiSkjdDXsPGTq3i84fwTia6avxF3u2kvva9yNDY7Li6QgCNBCo0Acy8XtxS4Uwv/mOC7+TyGLMXZAbq0RYCaPRlVQkko/gblwQFRvKOvtp9OwEWPwZuROjaCyQrBDzpe2Z94YivRHEuJbivgDcQuUrYtH9tO0WS4M6DMVKnkdJhr5QoNe0sUb/64kFWDHhrU4Pwm8R1DHSSkfO8BR8ANxqObAqchcIM8+GhiPiWQBBF/d9Oxl6R14pfH58koedhy7YgDmqC2HNdiT4TOvOBl3aZ6W9yGJ1DN6VoNWmWdyl1/dmvmgKEphXzuTaa+EpLbIi+52pmdn6nkavg9WVRkQT383O3CyfupIyG4kclui+gliixpyiV7nTYWHzbyKfBTc6iv4cwEwXsY5hepNrBL4iC6LyzYLSKAmdBDNmsGMKlgOSOgix86Mwswv25RzQp/jKPUYbkh9OM4HJ9vz8kJm3Li5DuqEXrBkMYcKhlvdeasvz8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e1faeba-4d7c-4b16-cf2d-08de22bc5c0a
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 13:55:52.8157
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yanQCO4crlJWKZ7JMsnMV8hWDbzolm5j7k25jNw8dqZIN+n+byrH8+viuKhpR9LoMOMt7E3yI2mfLun7ihYqiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6623
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_02,2025-11-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 mlxscore=0
 phishscore=0 mlxlogscore=999 spamscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511130106
X-Authority-Analysis: v=2.4 cv=bJUb4f+Z c=1 sm=1 tr=0 ts=6915e373 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=PVWyGGI_dUP4S9UKt5QA:9 a=QEXdDO2ut3YA:10
 cc=ntf awl=host:12100
X-Proofpoint-GUID: -T_HqXrojOvpgnP8P6yiSwjNE9ZeAwIp
X-Proofpoint-ORIG-GUID: -T_HqXrojOvpgnP8P6yiSwjNE9ZeAwIp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDEyMyBTYWx0ZWRfX3pgBy+Uz40uM
 4u8E3gwH/BH0XvbVNRSs1IZ8/wwU6dHcbb4+FoSFvfOWjPjHwchLovYaSEdc1LmIMCMUvOMQxHf
 87/watpVTT/GyjI+dy5cMe98+bICPiS/ieQtCIWsphjUubplflqv2WJp1k0gACl8KO+nsl/jIEK
 CxhhveC0ldR2ByKm2u2a7TpNQCzejC87s1qa6LpMzssY2iQy22tdMW0MQumie/GnMWBulBFimDs
 kuv/mwn+Jp9Z1OfKGfk2kxZO2dHjTItMsrjy/tkShOldhXZvjKvcBzoeQHHboUD4q520sK3hE4n
 ClWlz/mVyCHxJQVwO9zRVu6mrSLg3BnGya9sQXWnz/YEIqYtHcQ5VM29hMh47cyfbrYI626PMCa
 5rey8o1uZwZnXgL5H3NXeSKZvv4LqCEgsu4khGKEPW2pSSBYZT4=

On 11/13/25 3:31 AM, Andy Shevchenko wrote:
> Clang is not happy about set but (in some cases) unused variable:
> 
> fs/nfsd/export.c:1027:17: error: variable 'inode' set but not used [-Werror,-Wunused-but-set-variable]
> 
> since it's used as a parameter to dprintk() which might be configured
> a no-op. To avoid uglifying code with the specific ifdeffery just mark
> the variable __maybe_unused.
> 
> The commit [1], which introduced this behaviour, is quite old and hence
> the Fixes tag points to the first of Git era.
> 
> Link: https://git.kernel.org/pub/scm/linux/kernel/git/history/history.git/commit/?id=0431923fb7a1 [1]
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  fs/nfsd/export.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
> index 9d55512d0cc9..2a1499f2ad19 100644
> --- a/fs/nfsd/export.c
> +++ b/fs/nfsd/export.c
> @@ -1024,7 +1024,7 @@ exp_rootfh(struct net *net, struct auth_domain *clp, char *name,
>  {
>  	struct svc_export	*exp;
>  	struct path		path;
> -	struct inode		*inode;
> +	struct inode		*inode __maybe_unused;

We typically use "#ifdef CONFIG_SUNRPC_DEBUG" instead for this purpose.
I don't think that would be terribly out of place.


>  	struct svc_fh		fh;
>  	int			err;
>  	struct nfsd_net		*nn = net_generic(net, nfsd_net_id);


-- 
Chuck Lever

