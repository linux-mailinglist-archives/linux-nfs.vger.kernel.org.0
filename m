Return-Path: <linux-nfs+bounces-8932-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C91BA02757
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Jan 2025 14:58:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAC57188571A
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Jan 2025 13:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B97861DB951;
	Mon,  6 Jan 2025 13:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="npftfvk7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DE84wH9u"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54711A8F79
	for <linux-nfs@vger.kernel.org>; Mon,  6 Jan 2025 13:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736171910; cv=fail; b=A4VnnMyRG/RmXFH62L50zceZIlMhh2I1GFGyOWP7SYhDTvAVdpQpAP2xcEXXN6OCMc4zfgTGKmCSmMFR3ooJorJkwjhJAUHjRZV3yzvJaIGCxAAflDgY2cEHLAS/sis5uI8MkiShIv8auFxqWsOV7DSPRizyLQylrskfimosOd4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736171910; c=relaxed/simple;
	bh=MWsAtZ8cr210HQ6Xn+OUNAY4kPJ5LHHnxMKDvCFa0/M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rP2yjiOpGADUqDnMj1jUF7ynB6bHStqjWdUh3tcoomUlq7EvQGRmBwHvEGVOwP2RSwF9oC+VEoWLlnrdp0tpQetRMHZTCyxR+9nWNjQDmFf7iZHIB87aVP75/DgCQzBwU9UJeWdvRbZlKJe4nWAArXGo5cnRYov/tOF3YJ8WTTY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=npftfvk7; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=DE84wH9u; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5068toWE011154;
	Mon, 6 Jan 2025 13:58:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=ZIo3U/Zvo2+DLkhMQBsTwGuSMQUtl30raAMm795oFv0=; b=
	npftfvk7mUUWYMTauOQnQtUosLxadj5utXBSctjvlP9kxDgo/vHYUBRgEBnJkn4K
	5zwcpMqcqn7rXxodb8dvC7mpqxYrgBPgr+Ss2paNY/4ZmzfnpFYhSd9XWSA8xWGL
	gx9FLZnqisQvHXji8J79aqnevTYmEdmlpYPp/OG0qRZpB9Ytps07y1Mrr3Yke0sO
	QSG/bihwNuYE5M5IDU37PgwkhCNTpfxzDNC3cQhyZ7r1+Ry8GwGcAaerDFsyiuSK
	W+HJLEWFEDcxYMbWtk2GspaxVAPSZrDodAOPAh8X5GEMcHQq4gI8E3cCuQ3rxqmr
	arE0m/oToo52gf4/q5Lf2g==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43xuk02uh1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 06 Jan 2025 13:58:15 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 506Ce3j2005743;
	Mon, 6 Jan 2025 13:58:15 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43xue7aav3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 06 Jan 2025 13:58:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HjfWboJebKc2pHXZDmHErDnNd1JpyX8FRz8IdgUx4VGu/jOqRhSROq+6J3/gs2RtgZN7w/ArQbz7lVTo8rXZZTPnp+HpeVOalW958VhAZhU0Ixulog4vh89tKKBRWPI5mcx+OA0l16Vi6pWm3CzAsxLvoLmczBdyeFjISC8uO901DwHC/Y90sGBdvq/QqdqThdrhmcAC7W8J1EAZCDs++ctTliTTfKV13kQXeVPXlajapmj5AlCwOWhwWbXRTW+hm2+cbIeinbkpTziK6J639glgIRrdJWfat3cmxh+Vrvj2Gr/5tOLsBegLhrblDAaiXEWKDIyuQkQlGfiV8eZKtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZIo3U/Zvo2+DLkhMQBsTwGuSMQUtl30raAMm795oFv0=;
 b=XaFq1Coo90FHP4eWjH6bRBafUucVrelkSvhZuqrf6gDOxyHpmpCzFC8IZp5BmGlSMtE4g+Zpmt7eHoklFGa44bcI2UNg+vueF9lJJHev6uU999rOgvuLUf2Q+wH4ZWSfCB6X2Kw2xSFiQij6eYfbxi0AVRzo15XFfo8BHymOcFt8bLNs6b7i0FL/bhQniI7W33voTCAju2bswmqqnuQjg5TGWNujSnVHCMGvOvSbDJEtnsjsGYmRf2UQve2N9Eoj6yVZ7WkY+ypUm1cYfVvXeTAWF4UnmiXGRtGLhRr4JOsFyajMyxVKLvqCa+l3KLs2FspiJ2x7lgj+6o5h8FyHIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZIo3U/Zvo2+DLkhMQBsTwGuSMQUtl30raAMm795oFv0=;
 b=DE84wH9uN2PtFyI5eG8zEOdrF5aOjmiuOdLdUvdGZfxWBxHCqC9ATsZubpTSfy3dB4mnVDm93I7C6eR8/fHF9AR5QWbdg5b0g6o7z4wO4AG4woJzJrVioAwDspQgQR23hAtuVUOQU+AxctXri92J1O82rBVgzN7xNHeEpMbQAec=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA6PR10MB8157.namprd10.prod.outlook.com (2603:10b6:806:438::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.16; Mon, 6 Jan
 2025 13:57:52 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%3]) with mapi id 15.20.8314.015; Mon, 6 Jan 2025
 13:57:52 +0000
Message-ID: <e8eda0b1-c55f-4f86-8f7e-3c6a50dacac8@oracle.com>
Date: Mon, 6 Jan 2025 08:57:50 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nfsd: add scheduling point in nfsd_file_gc()
To: NeilBrown <neilb@suse.de>
Cc: Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>
References: <> <de100fd1-b741-4386-ac9c-21f3957d342e@oracle.com>
 <173613252284.22054.16371856139892298093@noble.neil.brown.name>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <173613252284.22054.16371856139892298093@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR02CA0022.namprd02.prod.outlook.com
 (2603:10b6:610:4e::32) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SA6PR10MB8157:EE_
X-MS-Office365-Filtering-Correlation-Id: c9e0a4a8-d174-4a84-1fd1-08dd2e5a1cb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NnN4MDNBaWYxb1Vsa3N5amJLVU1odXFSeXJtL1ZvbXhNcllxMTZ6RW1zRFZ5?=
 =?utf-8?B?dzN4UEEwTzhxTlByUGs3T0pTY2x4QllNeXBuNG5GYkpXakVCcnNGRXQrYU5y?=
 =?utf-8?B?d3ljbS8rZmh0ajR6Mm5jc3JtaUdhaGhKOGQ2czBQdkdTbjdKYWM0V2JxWnRH?=
 =?utf-8?B?UWJtSFZuanZWWW16dzRhWmNMclFHOVpOSzBueDRzQUc0ZzRsTmE4N3JYaWl2?=
 =?utf-8?B?aXVTY2t5UFBvdmlkb1FuakhZdHZMWlVXdGYxUHY3ekVzampyamdoRUxHUkNi?=
 =?utf-8?B?RkNZYlhpWnhEYXhyaW5RMWZqYmNoMStsVktUL2w3eXF5NW1ZSlJxL2lVMkJB?=
 =?utf-8?B?dmZsdVBEYWVlWG5mUVRPb0lOdXE3UklYdm9FQjVhaXpWeHVhZW11NlZ6QVVa?=
 =?utf-8?B?OHF2YTBsZkg4SVQ3MVRLQkxzelBnQzVTbW9Xa0FZVkZYbjBKcVBPVHlQQmdQ?=
 =?utf-8?B?ak44NzB1dlRZdkNwVlF5Y0VLMDNGZmZsbWRkS0JCSnYzS256em5qb1h5T3ND?=
 =?utf-8?B?Vit6QU9Ea0ZKRXVlbjFaNERhRE5ZQjB6MU9MeW9tYTZza0RpRDQ1UUtCOTZG?=
 =?utf-8?B?T3ZZQVg5QkdWT040SXpnSTJZNkUwRG5pVFJwdzRseFpUYUQzdHMzV1ZBUWlR?=
 =?utf-8?B?czRvSGxEaFhSd2xpYS9lTEZwdFN6bHJmbnZxR3ZrbER1Vk8wZ2Q5TzJLNmhY?=
 =?utf-8?B?S0k5ZVNiM0pOWWZjOE9vNzZrNE0xell1N3ZrM3d4ZE1iTVZ3QmpJMy91TWor?=
 =?utf-8?B?QW5USFZKa1JnVlBuOXEyeVpUQW9ETHhUcysySnlieXkwd1ZFNlFLNFB5TFdp?=
 =?utf-8?B?dGhXd25KRCtncEgxa29MNkFTVTBlZWkzeStTdlFzNXlvVjViRnBuR2pzaVdV?=
 =?utf-8?B?TWFoK1Ryd09hSUNCcG5uaEJyeldCc1FwbDlaaGpDVXk0SVg5Tkt4NmFHVEdM?=
 =?utf-8?B?cFh4ZzBEQm82MG9BUXdVZFU3dVlycXhRUkgycE9tUVMxeDNtM1NiakhCQ1Ez?=
 =?utf-8?B?SWhEaHNHWEJPZjNFcUNpNDdXMms3ejBaZlhKOGNmUjI4eWN5ZFo1Q2RTeFNo?=
 =?utf-8?B?NitMdUgxNDM2K290eFRKWWlhbzVWenFZV3NBdTdHT0J6MlByR0Z6ZnYwTFBx?=
 =?utf-8?B?T01TVS90NHVYZWkya2UvZ3pUNndnR1pMUHZCRVR0YmxwMWMrQkcyR1lKRlg1?=
 =?utf-8?B?U1dEWE8wQTNKblE1YnV5M0ptQ0JJZlRHRUZEa3J6dEZrSllzNm1yQWZTNGtl?=
 =?utf-8?B?dk9wbGtRVGZXSHUwN3V4RVc0L0NaUU0zTDFvSVc4dFZ5cmpta3BTaW5Bc2xQ?=
 =?utf-8?B?Zm5Kei9yRWk4OVpKVzlXUVdxMk5aaE9lak4xZ3BZTkFSaVo2eG5rejBvZFhj?=
 =?utf-8?B?bWovbFBCbDgxOEtUbFUvTnVUM0EvRitoY3R0T0duMkw3d2E4WTRVcTl1QW8y?=
 =?utf-8?B?WWlhQ003bDg5ZElNb2xpZ3Jrc0p0eVdYeGNjeTdlR3JWRlpDNEc0ZHBiOHI0?=
 =?utf-8?B?bmgyTDFKZUFxWjVPc2MvNWNNNE1BR0MzbzM4NEVDVzhqUk40RVlWdW0yb3Fs?=
 =?utf-8?B?L3NSYmxMMnhqNHRiY3o0VE9sbUdneFZlbXpML1lHZitnSTJlSmFhZDZmMld3?=
 =?utf-8?B?VWt0akdiYlEzQTA0U211NHNOSlBodk04T2lmdngrREZxQmNmdVg4VzNrUVRt?=
 =?utf-8?B?OGtEUmQzeGdUa3lMTys5R1F2eTdXalJUS1lNWm1oN0V2NUMxNCtoWnZYcjhw?=
 =?utf-8?B?QjZmRVhZeWFEcXgwb0JaTm1iM0tVUHF5MlFWNEk3ZjV4WVJGc25SY0M3L0Zq?=
 =?utf-8?B?QjRoQXJGQWlyakdsY01JR1VVUVQxenNBOFpqYzdxWTA4V2ZldnU3bGdYYUJm?=
 =?utf-8?Q?W7ytmWwSGUovo?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WFQ1cEYxWklybVRFREp1ajhFSXFmV3pXbnNOV0hSNW9sdUwvQU9ENHlIdHhi?=
 =?utf-8?B?c1o5Y01EWjJHQUJjdGtRa0V1L1VaYnk3U3R1QWM0UWtCRG95ajRCUzVOdHpv?=
 =?utf-8?B?OXdHanQyNnBGdDB1cDdpUkdPNTRNZ1NFV0RjYUpUNmpEYlppV3JiWGE5Slp1?=
 =?utf-8?B?YXByNDVXNDZrc1pSb1pZWVFldXhaR0JUOTVBL0NrWW9hb3RLNGwxZVBheWVN?=
 =?utf-8?B?LzM4WFRlYUVIMy9ud0FLUThNa1lsTXJCWUVVWFpsVWlvT2paRDAzL2YzSXZk?=
 =?utf-8?B?N0JPdHF1TmFLVkNjcWQrYzNiU1FUL0VtZzUyNHI2aFM1QzJNa0RmRnNjUkNR?=
 =?utf-8?B?bmR1dm1scWltaE9aVEd3QmxFQkNxZEI2UDRwZmFzem0yRzhjaWNXN3RGM1JS?=
 =?utf-8?B?aWNNU25wQ2Z1Y2ZJSnd0YTlJVGRIRHZnZUQyVXdzamhNdWNCZXh5em8wVmdw?=
 =?utf-8?B?U0IrTDd4cjVhTS9IVy9YcGhNT1VpUHJFelMzZ1UyKzBKSytMdHJ3L2g0K1Q2?=
 =?utf-8?B?OVFaTlIxb1ZDNDhBMC84ZkREN2ppY3Y3VUZyMnRGbjlNd2hFclN4TUFaeE56?=
 =?utf-8?B?cWUrZXJzV0FaTXNzenhENUhPdUN5NzJJRHNsbkcwejFzemhyWFNQaGZnNSs3?=
 =?utf-8?B?RnE2OXU2dEM5MDRKTkFTbzZOMFFaS1p3ODg4bWc5aldwV2llVXVtdUY1TXRk?=
 =?utf-8?B?ZmllVUprNzRlYWVtWEpBYUlDL3d4UzlXNUoxc2VLNXNrU2NzL2VKeTFrblhs?=
 =?utf-8?B?a2xydUlickVNWHFBOFZnV0hBVE52WWNhWkFreWNXVGRzT3h6eTdyVFFvelow?=
 =?utf-8?B?NzdlR3NDbkl5eEgrM2pabTRSQitKcmZGRXo4WWV4MmJhQTMvR3RTcHFMOG9p?=
 =?utf-8?B?Ylg2bVVzYXVzSy8wa1h4d3ZWK1VtbUhzZnhrUVlnRWw3Zms4cTJJTC9tMWk1?=
 =?utf-8?B?R0NLUnhhbE02ajBkcHBYSVRpTDh4VTV6cHJlZnB1LzdtckxMeTNZQ1BuUkI5?=
 =?utf-8?B?ekQvUzlvV2hGbWxJNjY1YWxJbHYzOWpFVW4wZldtZ3ZJZGhtNW1RQk4wYTMr?=
 =?utf-8?B?Y0loU056OW8xNVNQYWlHdU5rTzV3ZTVCSU4rNEdhVTM3L1BZNERVL3N3RDI0?=
 =?utf-8?B?SVV4WTJrdStDc0M3Y3ova0FNZWxBTVdJaitCczg2OUg5M2pXTUY5ZG1la1o4?=
 =?utf-8?B?Y0M3Q2tualVZMkpoZzFvM1JwN3p2WXNsVXFCc0NpSXlZNk9COHZCSTNVUC9H?=
 =?utf-8?B?aGxhR0NPMnZuU1lkZTJFN3pWUnU4a3NnNVpUeklkSjA0SUFkV3c5TnhkTkh3?=
 =?utf-8?B?aEZETDk3eW5VY0lPZ1U5cWVXSFRHcXlJUStZUlQvVHJxMCt3VGtzaVpRdVMy?=
 =?utf-8?B?OU5kZHNZRkRnQVR4WEtNS1JtMnFFU291dmhPK1ZUSG9GSHFjWUtqWUZwR3dz?=
 =?utf-8?B?N2MwRUJSeWx6a21lQ0gxQk5ldTcwSXZROWZxaHBmVlc2S1p1SlMxSXE2ZEw4?=
 =?utf-8?B?ZXJvclAxdzN4TFdTNnhRK0FUeTl1TXBsVGZqK0lLMWVGVEFTTDNFUVpXWlpm?=
 =?utf-8?B?cnFzZVR4bU84amZ1MFppdThrRW5mbDhhVmlQZk9LSWdjUXptckFhNjluYmlp?=
 =?utf-8?B?cjRKcjNLY0FMbFNHV0E5dWVDcVhhVkZQL1BVOStlcjltVGF1clVNNy8xVzZ0?=
 =?utf-8?B?dFViS2ZTWHJubTZaN2JkNm5iRnl2bjlQcXpMcTVGcVU2VkRCK1B3TWJEVXps?=
 =?utf-8?B?azk2a0dIaEpzYzlEbm1XRWNiem1ROG9LMXhDd1k1TjhJcjIyYVFZbDNYZGxR?=
 =?utf-8?B?S2wyVGVhd1lDNmI3RktkZElZTUkzdzdHdXVET0JxS2dGMTgySnFWQXpsMGFw?=
 =?utf-8?B?UmVsMFY3RjhycmN5cmRDM1grU1BDd2QzVGJlWGRKZW1iRFliQ0ovcXUwUWpZ?=
 =?utf-8?B?RXVvU2loMzUxSU80QzZvZm4wb0xrVlZ2NnZoc1J2dDJFTlVPM3I2QU9LOE8r?=
 =?utf-8?B?ekhIcGU1eWh0OEEvOU1ZNmRuQ0I0WWVIckF5cW52eVJMVS9vMjFZamNBZWxI?=
 =?utf-8?B?Ui9jSzlKT3VwaXE4ajJtMldQbGpoZ1o3bkxFaEorclg4NDdYQVpDQXp0b3NE?=
 =?utf-8?B?bFBEZ3hOMGNHNThFVWczVm5UNHRiQjEvTjl1VWRQNjU2eC9MeDI2bVFRcGFo?=
 =?utf-8?B?dFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	xlb3bIiMFGAWjV6r2a82DmrI6NbHeIq6/wOfIC8cx6uI/omM/k1DCrzLapWUy81mKRdCb9BhqLG1d9lAzCk3/vY5ommsV+v+N68YTGJ+9HjVLM7rTMXwT4fmOUYJOvBWLC1nYv0MTQkT9ztnJUpn6l1AGeVyla0VdnF9dFLg2Iwi6vGIOuGcMoe60wCo8W4ZNMdVYIDos1K5A4BYYuxVhUdLfzrSyKuom0KrCt4shjUjV2x22ChhZl5UlwwZKDZkUKpnmq1rNwoCZ60xqMx56LqToO3JrO72jY0vW6n8t/TDYcsSekv4SeOvAoAwmwsnXsKaI6FWK64dsB+zzZsaCJikUftVJq6v9UvYLkpG3NoOEKSrMBS4RShLapfFOD7TD4tD+qwY++acFZ2kCGnghw9gDNBIZ3N+QFizsa4SJdNo5laHoP4D7T8BhBtylxUbZbWK5AA4KFLSQW2elO81dXiWPMtYZFqrUxgAInLYfpLufrT7EWqMZIqOEFaAAKhtbukTEajMWjf+ROOEY7NML9jrRHq+k6LSpx0UQVDZmcK8+oqMrdsJwPWb8mHwive8EcA3x83VLF8EDXctFLs7JSZUQv2VXk8Ef2W80UNdQVU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9e0a4a8-d174-4a84-1fd1-08dd2e5a1cb2
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2025 13:57:52.1400
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yzuLhCzkm7XVGQuonTgpRwwDqqRT0QVip4jjLKfPP/0lYK/9aEh9Hvq4tqBbF29F8NN0HC/LRb1dRLyQmoDqpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR10MB8157
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-02_03,2025-01-06_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 suspectscore=0
 adultscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501060124
X-Proofpoint-ORIG-GUID: dEuSwb-2-u3A3e6XFhBXQiE-QkEdJFjk
X-Proofpoint-GUID: dEuSwb-2-u3A3e6XFhBXQiE-QkEdJFjk

On 1/5/25 10:02 PM, NeilBrown wrote:
> On Mon, 06 Jan 2025, Chuck Lever wrote:
>> On 1/5/25 6:11 PM, NeilBrown wrote:

>>> +		unsigned long num_to_scan = min(cnt, 1024UL);
>>
>> I see long delays with fewer than 1024 items on the list. I might
>> drop this number by one or two orders of magnitude. And make it a
>> symbolic constant.
> 
> In that case I seriously wonder if this is where the delays are coming
> from.
> 
> nfsd_file_dispose_list_delayed() does take and drop a spinlock
> repeatedly (though it may not always be the same lock) and call
> svc_wake_up() repeatedly - although the head of the queue might already
> be woken.  We could optimise that to detect runs with the same nn and
> only take the lock once, and only wake_up once.
> 
>>
>> There's another naked integer (8) in nfsd_file_net_dispose() -- how does
>> that relate to this new cap? Should that also be a symbolic constant?
> 
> I don't think they relate.
> The trade-off with "8" is:
>    a bigger number might block an nfsd thread for longer,
>      forcing serialising when the work can usefully be done in parallel.
>    a smaller number might needlessly wake lots of threads
>      to share out a tiny amount of work.
> 
> The 1024 is simply about "don't hold a spinlock for too long".

By that, I think you mean list_lru_walk() takes &l->lock for the
duration of the scan? For a long scan, that would effectively block
adding or removing LRU items for quite some time.

So here's a typical excerpt from a common test:

kworker/u80:7-206   [003]   266.985735: nfsd_file_unhash: ...

kworker/u80:7-206   [003]   266.987723: nfsd_file_gc_removed: 1309 
entries removed, 2972 remaining

nfsd-1532  [015]   266.988626: nfsd_file_free: ...

Here, the nfsd_file_unhash record marks the beginning of the LRU
walk, and the nfsd_file_gc_removed record marks the end. The
timestamps indicate the walk took two milliseconds.

The nfsd_file_free record above marks the last disposal activity.
That takes almost a millisecond, but as far as I can tell, it
does not hold any locks for long.

This seems to me like a strong argument for cutting the scan size
down to no more than 32-64 items. Ideally spin locks are supposed
to be held only for simple operations (eg, list_add); this seems a
little outside that window (hence your remark that "a large
nr_to_walk is always a bad idea" -- I now see what you meant).

IMHO the patch description should single out that purpose: We want to
significantly reduce the maximum amount of time that list_lru_walk()
blocks foreground LRU activity such as list_lru_add_obj().

The cond_resched() in this case might be gravy.


>>> +		ret = list_lru_walk(&nfsd_file_lru, nfsd_file_lru_cb,
>>> +				    &dispose, num_to_scan);
>>> +		trace_nfsd_file_gc_removed(ret, list_lru_count(&nfsd_file_lru));
>>> +		nfsd_file_dispose_list_delayed(&dispose);
>>
>> I need to go back and review the function traces to see where the
>> delays add up -- to make sure rescheduling here, rather than at some
>> other point, is appropriate. It probably is, but my memory fails me
>> these days.
> 
> I would like to see those function traces too.

Here's my reproducer:

1. On the client: Set up xfstests to use NFSv3
2. On the server: "sudo trace-cmd record -e nfsd &"
3. On the client: Run xfstests with "sudo ./check -nfs generic/750"


-- 
Chuck Lever

