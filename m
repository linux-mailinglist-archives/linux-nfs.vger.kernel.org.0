Return-Path: <linux-nfs+bounces-15956-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBE9FC2DEC9
	for <lists+linux-nfs@lfdr.de>; Mon, 03 Nov 2025 20:44:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BA2E3B159A
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Nov 2025 19:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E49DA31B13F;
	Mon,  3 Nov 2025 19:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Op1ueu6S";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="lrEaYSx7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A8B310625
	for <linux-nfs@vger.kernel.org>; Mon,  3 Nov 2025 19:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762198952; cv=fail; b=bu0GB3Xm2v+IMoXxOeFqxUx9o6rAADRqWkOe5vA+MxhxH3YcDckMR3y4CnfrNJxncofto+oZRS13VlFgX6i5QFOeQIucum2P5wxTB5NsZlTrQdPvJSPk951lEAp4+Kz/60c06o8+KJCaAzmiLPU/PTsEqoTcuscAkJoNVUyFSOQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762198952; c=relaxed/simple;
	bh=SamVrB/jMf59ekCGQHS50dFdw/IHg8zj/KqIVZMh7pI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=atAavmGG6y0u6B6Vf+hdU5yquYdVF+Rbl9WfQxo3krqZBCcccOd6oFdEpDA9lGOR91eRwi6GIQ0LbE8TngwiT87sIedvQ0mTbiaJPm/5l9tgwnisWDfXWVrJ/ztGHYGdt9mOBBG3pCz1UpEld+PoqnM6sULCLGX8faIcMDkBXSY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Op1ueu6S; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=lrEaYSx7; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A3JTbZw001353;
	Mon, 3 Nov 2025 19:42:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=MdL4qi84+NCn+tZ5dJZNTkVtFSM3CUgydxrm504K+L4=; b=
	Op1ueu6SPyySHYoRyy2Q9DQLIA+btmCa13WARFzL6PRTLDmEDJvDoKdaqtFgLuQb
	/J735U1qQqWTujXgSNduf3mavVMkYFL23S7X8M7EwBK9n6KlQLW8xq5BqSGuuz9o
	LmWArcjBMHhrUgT/yCigE2U2HArEpx8Dplcv3TGrspU27YlFrGLDSYIBWFqhV8Yw
	f2szf8729uvDvojcqB3HGgblqG46mQJQkpsBuJ5g/jbyCaOBmZSgwG6FTdsuyyvP
	L3wdJ3ROPJZ0kcoM17l7x3vxmzeLM3JOAxY+0NxmCi6XN4kjPv60//XA99IZgsxQ
	DVx9DZpjrROG9MqRi1Dp8A==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a72kgr10w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Nov 2025 19:42:26 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A3IROXM009620;
	Mon, 3 Nov 2025 19:42:25 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010038.outbound.protection.outlook.com [52.101.85.38])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a58nc4p8e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Nov 2025 19:42:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nWj/XYVpR/iNv+QK8tIvUoe/b5HVeHFHfIGMH1Eo6HUKmKkJWiHf8g2KXfg2OCE2KABw1ekosCehG1QOpY/UT1iV+WofJxIE0/8axhqRjET6KwzIk9xkO47KssbnrC6DZB8rRxAvyf/fOb+EL3VTPkv9OPNsn4E7H85qsP6G/UfKONdXJzuZhvsJNPiOTW5la6jkzaYztz0WhTmtBc/jPCFWpfntkLcBoXBLSwqA7US/9CIQKuLm5h+m+uIUf2uCk+FI35yotkjc8FbHnIA3cwOicUhx1+QpbP5bJDhmCuNscAqIytitgIKElW5UqMiS97f5hKM6IIuhUU/wE/CIog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MdL4qi84+NCn+tZ5dJZNTkVtFSM3CUgydxrm504K+L4=;
 b=mMY1uzS1WAHPWjgF8m/z7/xHI1N32FWh4sj5+0GJiUn4mh2tISZN4gY7UmzpJ9Fc1Qih1ovH8SU2nx4mXcGNg9osXWjDiOeAHuqxzdqU8mAEGGtfHULUGwiN+tiURsXKrzEzQSiPewM+RKNnDVqIuhdpYmXWUdh4FsbOPnrAhiKJtpiTJ/O8AMcR+ZKOjnharIzFj1FxOpAcPTzKGv4tWz43rEtNXQlYtHWXBiPy4LazZr7iPLJ/rJjg6pY0XS44v6AV+YEQPQ8Gdx56IMW2BzM1f4Uou9fyEurtMNFSOGHMQ8CsY5vwMZc7feYPxvWrdH1teCp7jZ2SjIdGQRyv6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MdL4qi84+NCn+tZ5dJZNTkVtFSM3CUgydxrm504K+L4=;
 b=lrEaYSx7XSE2qvrqBqT9ApnQtfertD7KZ2gAZTFbaZalaEnJ66KJq96VegahQfeF4vKnaTT5AAZaioUArhcrvO6vogtZOTHiqOkeT4HLc5zN6+SOnSFkMPxoPqnMvGvSO74F+rfur0G0G/UAGaHSlimt9xaLDMKdtBPWyu53rI4=
Received: from BY5PR10MB4290.namprd10.prod.outlook.com (2603:10b6:a03:203::15)
 by DM6PR10MB4267.namprd10.prod.outlook.com (2603:10b6:5:214::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 19:42:22 +0000
Received: from BY5PR10MB4290.namprd10.prod.outlook.com
 ([fe80::c86a:40f1:7833:ef3c]) by BY5PR10MB4290.namprd10.prod.outlook.com
 ([fe80::c86a:40f1:7833:ef3c%3]) with mapi id 15.20.9275.015; Mon, 3 Nov 2025
 19:42:20 +0000
Message-ID: <ffd32dca-3a61-4e26-affe-f4aab7b31c47@oracle.com>
Date: Mon, 3 Nov 2025 14:42:14 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] SUNRPC: protect access to rpc_xprt bc_serv
To: Olga Kornievskaia <okorniev@redhat.com>, trondmy@kernel.org,
        anna@kernel.org
Cc: linux-nfs@vger.kernel.org
References: <20251030214759.62746-1-okorniev@redhat.com>
 <20251030214759.62746-3-okorniev@redhat.com>
Content-Language: en-US
From: Anna Schumaker <anna.schumaker@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20251030214759.62746-3-okorniev@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR04CA0009.namprd04.prod.outlook.com
 (2603:10b6:610:52::19) To BY5PR10MB4290.namprd10.prod.outlook.com
 (2603:10b6:a03:203::15)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4290:EE_|DM6PR10MB4267:EE_
X-MS-Office365-Filtering-Correlation-Id: 44519a85-2dab-491a-f007-08de1b111a01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZDJURUFma0dpdFVGdlY1OXVoZ3JQTHRkTEJKc2ovY2tLMlJsVE9FYU9yNVlQ?=
 =?utf-8?B?NzRZRDdSc09ZTHdpZE8zWWZnL2JtVFdHNjB5SE5ua0NoWWJGbHNPRDVObTdw?=
 =?utf-8?B?cm82dmM1RjNtNGZjeWdhUE1xakJvbEZsL0NrbDkxbk1WY0pFa2FUNERJQlVv?=
 =?utf-8?B?b0tQR3RiMmNCTkJJaVhkQXR6cHpRT2l6WklXQ054ZVg4UE5xbDVLVnYybE4y?=
 =?utf-8?B?OEdIdW9uVWluVThYbWhCQnZySTBPWXJsQm9Ja090Qk00RjZ1UVlTdTFCdVRI?=
 =?utf-8?B?d3cza3VRcUcrVDhYeEszT0JwN080cHpsVW5YODJPejFsZDZzYmxGTHorY1ZI?=
 =?utf-8?B?YXBOcktLM2VuNHpqcm5OM3ViVmJHNklGcmlTcGR1eGlJZ1pnZHdzaE1temJW?=
 =?utf-8?B?c3h6ZVNPK1ZnekVsMVVUZ3ErNmRRSmlTVHVLTUFnc0VwYzA4VmNFQ1RwOE1N?=
 =?utf-8?B?ZFlIQTQwUW9SQXF4cXdvSjhqZnpyenlnbjZJS1JlL3lPQzNvUCtvRFozMlg4?=
 =?utf-8?B?MDNvNEZvaDJ4WkRDaWNTVVd3TVloNGd2d0t5cUVPNXd1UFFLT0RXR2x5UDRM?=
 =?utf-8?B?RnVYSk9heHJSUG9mdXhhNkpOT2EwWmRZR20zaEJ1NVMrS0d6K21QUjhhazlM?=
 =?utf-8?B?bWVRS2hvV1p0VWhGaHBUU0ZhSHA4M2VDRHE5MUhvaW55eWlDL2l0U1l6V2lI?=
 =?utf-8?B?WVdlbjVCRXRzQnNBOXo2ZFNxU3lEeThrQzVXaW9IL0FBbE5zaWtUL1A1QmtC?=
 =?utf-8?B?dklObTJhQjl0UGIyOHBHWXBZRDJXWm1QdmtXZWVSSmlEZWVpWjdSZWFsZFVu?=
 =?utf-8?B?elQzUWE3VTJ4N0YwUllNb2JQOFpRcisrL0FzRHIzV1pEWnRnNTVXTkc2VWg4?=
 =?utf-8?B?bDNnRGd5S1pwSlJkK1BkcWZTMkFXRGg0ZjZyR2tYZVYxc3Vic3I4N2ZtbVZY?=
 =?utf-8?B?K1ZtMXBOZnZpZkttVzhQTnVoOEdqSUl3SHJBZVFDcXhleHVBOFFOdDg5RnMz?=
 =?utf-8?B?YXkxTHFqTmp4a0NVRkdEMytyUllrbFA3ZGc2NEtsbkZUSmd3WGtjNzlzdGJH?=
 =?utf-8?B?UTRZUXM3OThhS1lPRGt1TU5KZzg2cnUrUHZoeUF6cWR6ODdCQU1ONnpYamcy?=
 =?utf-8?B?ak9jUG15WkhZYlloYjl1UVJ4cGQvTkdVamxla21wcVNWQTlLbjZrYW9LOFZs?=
 =?utf-8?B?QlB4djN5MWxPM0M0WS9qeTZPV240NDlEMDV1Y3l6RVpNQWw3S0V2SGptalBw?=
 =?utf-8?B?S3N5aURzVmV2WElxYTdnS09QS1FIWndtVjQ3Ty8xVUwyT0VEYXdkdEtaTVVr?=
 =?utf-8?B?ekxRVHJxeHhnRGswclZoOWlrWFhaRDRlZ2xXMXlQcXArNFFFd3FBNFBoNk81?=
 =?utf-8?B?Z2NoTHRFbm1qdUJxMk9JdXdkK3gxTDdoVGh6L1ZWWWJ1NmhKNFQxd1FJWHVE?=
 =?utf-8?B?OEM3YWpvVVprRnpXNVBPazBVZEdOOWNHUUlUamJtby9LeEI4dW9Td09NMkFx?=
 =?utf-8?B?eVY4ZTBmNE1qZVBIRTFPSWVoRDNvN2pnNGxaMWE5NkxrSUZ2cmh4WE43eDB1?=
 =?utf-8?B?cUtsdUhHeHFqbytvZ3EraXRZcmpneng2Tmo2aDIwL250NCt0dU83dmVoTjJ4?=
 =?utf-8?B?ZzBvK1FwNFgxYjduRzZJTVBLbHJFeHZqc3ZSc3NuSUxuSndRQkFXOXp3aU1G?=
 =?utf-8?B?VWJuK2N3K1FFdVVBK2haQjVpM1pYdlVUbURVRHo0cG9JTC9QV3RId0hkTEE4?=
 =?utf-8?B?N3hlcEkweU94NXByT0hQc2JvbGtCSXh5cW5BWTl1ZjlaekpMS09LRDVmVkFG?=
 =?utf-8?B?MjhmVThNTjVmanlkcW5RdTJsMUpYTkg5ZGRsc3JzKy9McGlNUFNudXpMWjRG?=
 =?utf-8?B?SkNJZDkxdE5sanhkUWJkWnlNZTJ1bU5CWTQ3UEtEVkIyMHJrRmNPMHBXMTlr?=
 =?utf-8?Q?RY5MWECc0Obi42FlbcPH/HetBD/zID20?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eXVGbGlnNTBaNnp1WDFabzhLY2ljTzFWeTZ3Z2NFTDlFbjUvcGVCVHNJanZz?=
 =?utf-8?B?NVB0WFZraXJLcjVRcHBFTGg4MzJGb3VSQVZXYVhvYkhJSEZNRUNBTW1vZEx2?=
 =?utf-8?B?RzU1WHcyaERjblo1NHNPVTZheUFvMWZITEQ3VDNvRitxckFOSWNKcW9HL2Jm?=
 =?utf-8?B?WWlXa0pEcGpXekcrVGh3ZGJkb21DcmQrUXdQZGF6OUp6Y0pvL0N3Qk1INlVu?=
 =?utf-8?B?NzNBa25PVDU0SnAvSVVnTTVZZkR6ZWtleitndWpTSGdsSVNXSXI2Q2xRUTZT?=
 =?utf-8?B?dG95ZDNDNng5dUhhZS9GbUkweFdmRERaSlMrSE1md0puS2NIcjRxYXlhdzl6?=
 =?utf-8?B?bjZPLzNDNzBGNndEdWFQTGZuR1N0dlBhZUo4b2FxY0FHQ1RjNTR6eDQ1aTVJ?=
 =?utf-8?B?KzQzb2lwQzh6aENyWkFrQnFlb1hhdC9RNjVRQVZHODJMcXFPWjFqdFZVb1RL?=
 =?utf-8?B?aVpPTWxBYUdZcStjTTN6SENkOFhRR1BDQS9HN0VhYUJLYUdaUG8zYTBYNFVL?=
 =?utf-8?B?SnNrYVptNi84ZGQ2bkVWSU5RYTdkUkpGNXB2NkF0WS9qRTF1a2RKQlFleVlq?=
 =?utf-8?B?SEV0OFZrbUgxWi9iRlQ3TEl6M1J0MHhuVXlrMEtNTGVBMmpGMTFKMk9FZDFK?=
 =?utf-8?B?TDlSbmtZemdLdnh4eE5CMm5pOXU5Y2NhTjZnSkk4VHJqWUozVE9UTTNWM0px?=
 =?utf-8?B?VDhwQlNUc3pxWlhUS2NLVTJFRytBb0JuUnpkc0xKRHp4eG5qaWkxcTFsVk8x?=
 =?utf-8?B?ekVBOTlyQ2htSVhHWUx1SVNUakd1UTBKRzdhMm5Pc2FEdWpPUUJSMHN2d3FH?=
 =?utf-8?B?bkZVTGdsMU8vVU5UMEJZaGJ3VmdpcTc4dHFhQjFXbWMyc2hjaFNKYlVOUGRn?=
 =?utf-8?B?bzVHdC9sMHNjSjV2Y0dvWVQ3TC9Rb3Q3Yi9pMUhmTkRjWjEzL1g3T05uOTFP?=
 =?utf-8?B?NzNRT3BmSm5BQ0RpdCtyTG9vbDhSeWpjY3NyTVEwZjVOcnNWZVdoUTJYSVho?=
 =?utf-8?B?RWszcytXaFQ4UE14VjczME05d1RyeFpaeGkxa1g4MzkyL0lYQ3p4cW9DaVZr?=
 =?utf-8?B?RGJxcWhaZnhjSFhTMGd0VzZlUjVYNHE1cTZFZ0dxSTZsOUFORnJLRUR3L3R4?=
 =?utf-8?B?VHF0NW5ncm5neWlqZENXQ1RuU0E0WkxCdFc0REZoM1pDQkJWV1poN2NhcGVz?=
 =?utf-8?B?eGl0ZGVWREFCK2oyempLYzZzVkIrRTBySjV2UXVvT2o4U1djM1cxZjRHOWxh?=
 =?utf-8?B?Wk5TeXViVDh5R1RLUlVKdHpyTjg2eG9YazRhbW1URWxhUlpDMVlSYVpzMDVt?=
 =?utf-8?B?TmtZbzUwOHcvQStXTjFVbFZqbG52WWRySFh3SjZYd0RlckxkYUFnaENZa3Fw?=
 =?utf-8?B?Sis2QzczNnJDRkhudFdQMVZjcGd6QngxVGFiSUtwRjBJNjFjQ1FRUUZrYzdk?=
 =?utf-8?B?TnZEZTNJL3lJbkFXTDBUd01jVEVjbkZ1UTRSd0pvR1p0WXc5cUphbUVYS2Ez?=
 =?utf-8?B?UUhCWjZPeCtUKzJoVlZnWjdDRUZmeDd5UFpTUDRrdUlyWFRCbHJoaEZuckJM?=
 =?utf-8?B?UFlDWHBVTzlPNjVtVEFqRGZ4QThsR3Z3VkJ2ZEFIRjBORmVqRXpGMkF0UnhG?=
 =?utf-8?B?bnVZUTZyL0dQYU14NWpPdlBSMU1uYmJIaDMrMnplcTJtS0xVZkVLa1BkMFhQ?=
 =?utf-8?B?UGhKcUJscGR3R2N2d2RJUFJMMkcwVHBab2hnd1hPYzRTbkUrbjlJZFZRSW5J?=
 =?utf-8?B?aTIxSjZKVGhIaGtUWDc4R1dMQjV5OGFUYWVlNWhpL0JPS3d5ZFFlVHU0blZP?=
 =?utf-8?B?UmxNUnhpTDRjNWVnSTMrOG9SNnI5OE9MMXBVMFpKWnY3Z2RYRElDZ3VhWDRF?=
 =?utf-8?B?bk5mUG5EbGtwWVNkdzYvb1lpOFpua3JWWHFsYXF5dWlvaHZURDFzZjd3SEIy?=
 =?utf-8?B?N3BRWTYyTWQ3eUViTzk0TVZ3cldGUjdwa25wdmFpZ0Z0NXdvaWNqVG52NkVN?=
 =?utf-8?B?T3lVM1BBc2NQYnl5TjJBOGd4aXhoZ2RHdDR4ZFV0NXk5Vm5ScWN6dDhjMi9o?=
 =?utf-8?B?UTNpSys2cnlZcmNTN3YyN2VSVFhiYS9iOXQ1UzdGbmM0QzNncXo2ajQxeVhU?=
 =?utf-8?B?VVgrSytxWGVldkN0bmpOZGJsYXpPVXYxbjhYbGo1YnlMZ3ZxV0Q1TWgwY002?=
 =?utf-8?B?cHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	gmEfsL5T98wbYhCTmGgyArE1j71SPTHDYrIl+zDn+mMJiNVk7EjkZoAwTJou5+/FdU7c/uX+Fn5mzNCM8b1nhqy3XDjgZTZFXwG9y5/+gLd/i2O9tFyrPHBMJCpX51Lgjdz7YUtlO5qGxve17CmbMwRBQ9YWPno/LmYkf0cEeatPCC44kPLKLR8BwW9xYp+im+Hb2owJqxSEPMZzaiPl1iyJRpbihW0n+0aFbv+Es45e4PZKNFzjd27X/H+6bWd04NjqnF19sUtzBmnDwTno8FS86ufcr8At5PQtmQebu3g3SQCf6yWuaXHsMQmYwjubXwN/V3h9sGMHI+xwH2G/AKNvBQnZ5dh5C+c3C1Vu+0zzFuHldSbXtZxryLlNhcNPLMHbrdciOzrX+cnSS2qPOXzBJGMArIAPTYptv1Wh5GhUAI7TBThqSlYqeRsR4Qv3zKA933A6Q1PofrprOHb4MeydrYydtoDyFSF48pNVoKATSntq/iTxaWTkd5zAqiHjYvXyTk05ohz6eRFgoGW7Be96c17DSI3qVniif7KREHt9CgTbA/nSJKq2D1B/3RhFuNwi1Tn/xWCCjJDKEqtSfCg2F1g/tie8vvJ2+LOEki8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44519a85-2dab-491a-f007-08de1b111a01
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 19:42:20.8751
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y/GLzvtK8IMk/j23wiKpVdGfkDxuWMb81LDTCuG+m+rkJG3sadEjHTBLogL0SkaE34KD0MmDa1R2Kz6Cqb4yAmNUx0Xc7NBD/C9qb4kM194=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4267
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_04,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511030176
X-Proofpoint-ORIG-GUID: DzBicagVQbbtA9fMA0zicyh_Fjbg5VOn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAzMDE3NCBTYWx0ZWRfXygKbx8Kb0TkR
 2Dmgo6ab7LnLvzlj/AqkPJvGqp5eOjNq/h1n6N7S7To2az00OnCW936ttz82MzjBlw3MozCGXyq
 zD8VNeyP+dhdskscSiCw0By3HfqDkEn2CeKiaUsXLMmVr7rOxsMbZrCtCeHYbF54yqGIsD1xVDk
 dTqcD1Bi6kdFq1+KBpsSovswxJzAHpUEpgJVDbO0yuj88MUMj8Ew4lhY/wTynal9htgXmrZklqA
 /tVPdbY3Ka8JoLU2Ilgiz3wvr2kj9dBD93cw1TI+lAgdcdGR5qZ+q0RpPOk7apNYDeDsVVjo7c1
 ssZpDyI0u4cUe72/st5olX9FhWb7M3psn49o1GrAVdREiXXyl/iD5Om4ZuuZscOcWt5yIz1ZzHo
 MX5NL0e70/SntpR87pfrNs3S+i9olL+L4MIqDj7KYqQzakrBfBA=
X-Proofpoint-GUID: DzBicagVQbbtA9fMA0zicyh_Fjbg5VOn
X-Authority-Analysis: v=2.4 cv=PIkCOPqC c=1 sm=1 tr=0 ts=690905a2 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=20KFwNOVAAAA:8 a=zvtOe4UJbajyz2RXGqEA:9 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:13657

Hi Olga,

On 10/30/25 5:47 PM, Olga Kornievskaia wrote:
> We need to protect access to bc_serv usage thru the bc_pa_lock
> and make sure that backchannel request processing is accessing
> a valid pointer.
> 
> Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
> ---
>  include/linux/sunrpc/bc_xprt.h    |  1 +
>  net/sunrpc/backchannel_rqst.c     | 27 ++++++++++++++++++++++++---
>  net/sunrpc/xprtrdma/backchannel.c | 11 +++++++----
>  3 files changed, 32 insertions(+), 7 deletions(-)
> 
> diff --git a/include/linux/sunrpc/bc_xprt.h b/include/linux/sunrpc/bc_xprt.h
> index f22bf915dcf6..6f57685192aa 100644
> --- a/include/linux/sunrpc/bc_xprt.h
> +++ b/include/linux/sunrpc/bc_xprt.h
> @@ -31,6 +31,7 @@ int xprt_setup_bc(struct rpc_xprt *xprt, unsigned int min_reqs);
>  void xprt_destroy_bc(struct rpc_xprt *xprt, unsigned int max_reqs);
>  void xprt_free_bc_rqst(struct rpc_rqst *req);
>  unsigned int xprt_bc_max_slots(struct rpc_xprt *xprt);
> +void xprt_svc_destroy_nullify_bc(struct rpc_xprt *xprt, struct svc_serv **serv);
>  
>  /*
>   * Determine if a shared backchannel is in use
> diff --git a/net/sunrpc/backchannel_rqst.c b/net/sunrpc/backchannel_rqst.c
> index caa94cf57123..916f78cd3306 100644
> --- a/net/sunrpc/backchannel_rqst.c
> +++ b/net/sunrpc/backchannel_rqst.c
> @@ -24,6 +24,22 @@ unsigned int xprt_bc_max_slots(struct rpc_xprt *xprt)
>  	return BC_MAX_SLOTS;
>  }
>  
> +/*
> + * Helper function to nullify backchannel server pointer in transport.
> + * We need to synchronize setting the pointer to NULL (done so after
> + * the backchannel server is shutdown) with the usage of that pointer
> + * by the backchannel request processing routines
> + * xprt_complete_bc_request() and rpcrdma_bc_receive_call().
> + */
> +void xprt_svc_destroy_nullify_bc(struct rpc_xprt *xprt, struct svc_serv **serv)
> +{
> +	spin_lock(&xprt->bc_pa_lock);
> +	svc_destroy(serv);
> +	xprt->bc_serv = NULL;
> +	spin_unlock(&xprt->bc_pa_lock);
> +}
> +EXPORT_SYMBOL_GPL(xprt_svc_destroy_nullify_bc);
> +
>  /*
>   * Helper routines that track the number of preallocation elements
>   * on the transport.
> @@ -354,7 +370,7 @@ struct rpc_rqst *xprt_lookup_bc_request(struct rpc_xprt *xprt, __be32 xid)
>  void xprt_complete_bc_request(struct rpc_rqst *req, uint32_t copied)
>  {
>  	struct rpc_xprt *xprt = req->rq_xprt;
> -	struct svc_serv *bc_serv = xprt->bc_serv;
> +	struct svc_serv *bc_serv;
>  
>  	spin_lock(&xprt->bc_pa_lock);
>  	list_del(&req->rq_bc_pa_list);
> @@ -366,6 +382,11 @@ void xprt_complete_bc_request(struct rpc_rqst *req, uint32_t copied)
>  
>  	dprintk("RPC:       add callback request to list\n");
>  	xprt_get(xprt);
> -	lwq_enqueue(&req->rq_bc_list, &bc_serv->sv_cb_list);
> -	svc_pool_wake_idle_thread(&bc_serv->sv_pools[0]);
> +	spin_lock(&xprt->bc_pa_lock);
> +	bc_serv = xprt->bc_serv;
> +	if (bc_serv) {
> +		lwq_enqueue(&req->rq_bc_list, &bc_serv->sv_cb_list);
> +		svc_pool_wake_idle_thread(&bc_serv->sv_pools[0]);
> +	}
> +	spin_unlock(&xprt->bc_pa_lock);

Can this be done in a helper function that is also called from rpcrdma_bc_receive_call()
to reduce code duplication?

Thanks,
Anna

>  }
> diff --git a/net/sunrpc/xprtrdma/backchannel.c b/net/sunrpc/xprtrdma/backchannel.c
> index 8c817e755262..01055446ec56 100644
> --- a/net/sunrpc/xprtrdma/backchannel.c
> +++ b/net/sunrpc/xprtrdma/backchannel.c
> @@ -261,11 +261,14 @@ void rpcrdma_bc_receive_call(struct rpcrdma_xprt *r_xprt,
>  	trace_xprtrdma_cb_call(r_xprt, rqst);
>  
>  	/* Queue rqst for ULP's callback service */
> -	bc_serv = xprt->bc_serv;
>  	xprt_get(xprt);
> -	lwq_enqueue(&rqst->rq_bc_list, &bc_serv->sv_cb_list);
> -
> -	svc_pool_wake_idle_thread(&bc_serv->sv_pools[0]);
> +	spin_lock(&xprt->bc_pa_lock);
> +	bc_serv = xprt->bc_serv;
> +	if (bc_serv) {
> +		lwq_enqueue(&rqst->rq_bc_list, &bc_serv->sv_cb_list);
> +		svc_pool_wake_idle_thread(&bc_serv->sv_pools[0]);
> +	}
> +	spin_lock(&xprt->bc_pa_lock);
>  
>  	r_xprt->rx_stats.bcall_count++;
>  	return;


