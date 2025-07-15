Return-Path: <linux-nfs+bounces-13085-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12FEFB063A2
	for <lists+linux-nfs@lfdr.de>; Tue, 15 Jul 2025 17:59:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51998580E79
	for <lists+linux-nfs@lfdr.de>; Tue, 15 Jul 2025 15:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE74F2AD2D;
	Tue, 15 Jul 2025 15:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qR4J+qSa";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mQk9HJXI"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7F418DF80
	for <linux-nfs@vger.kernel.org>; Tue, 15 Jul 2025 15:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752595175; cv=fail; b=ZtaOa/8W3C8bdotNPMSBv8KdSwuJkvfQt5qnuwpgFOf1dm8OYW+B2BfnKP/IDrLnmnWoLG42ObiRkRRfbioqII5GJAfzsle/ZhwA0tFTCt1HSOdI5ArSi9ahQyALuqVWWuk4dEyuQJKWia9JgWeACj7WXwQk3ihncnyKf5/ntRQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752595175; c=relaxed/simple;
	bh=AavdiB0+HJNHlutIlV2yV8VEC6s5zMiIOP1/503oPwo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=F5ZKNhMj6J+dh6OOzUOT9nwAjLLIkMtlP1+d7NKgbfpirbVcA99rnQpnn90awp7ll2JTSbOBArQHcpiMuVcSJqZjxU6RZlWCGLuPUcE6AgcETKPEoDQy5dlhb5JkR9mnKZy86FW86kBSygeJhOTs2GdUXVuy6qgZrol9QoupGoA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=qR4J+qSa; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mQk9HJXI; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56FDZOZi026013;
	Tue, 15 Jul 2025 15:59:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=cK3uA52+CkteC9HaRbo0hJSdnXjUqmZjo1K/SBDKnfg=; b=
	qR4J+qSaOIEyVkcnRfXAjpgue9sLNNzjzH/hgGupLTNA7uXxUuCj5NxjMF0MD7mG
	FZ/TUB9OG/B5GTc212Lw50lFnio/6LVJPoSURu3991ga4E+d7XlfkKexxxGlExf+
	4aegvAYqL7ojfPN8wJE7CPrk6wmU6e84dwTxaDd2o/SuQ0WjhLqweAE7+arVCrCE
	nD2lDSNSmy9kRW+C+978Hv2mSyisUlSMVWLJ+zOJNJVgEcngb45NFQMt0/mXdVeF
	kOgSBXwuV5tbJeG/kcyzGtFbnpZYEowE40sd5YM0+cNgqGfTSoljteoiUcKCc2kE
	IgLouNxNgIjbYHc2Ci8eZA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47ujr0y01x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Jul 2025 15:59:28 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56FEi4OA030320;
	Tue, 15 Jul 2025 15:59:23 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2070.outbound.protection.outlook.com [40.107.223.70])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ue5a5apc-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Jul 2025 15:59:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qNUFFPtRTKvuUyC2VwbcYbHrCqXNtFLIEIlbTbu4bXMFkbPBllCcgH6/zROZiJf8i0G3gZFBmEONt5Bw5WbJKLaTn7Asp9WoWoOsNU+vILkHvvk1QMNFntqQ3SvDkeSNW7oG3zVekdTntZ8izaDMPox819E7nygYVV90LW/U0lUaiUclPz6YektJfohN5HYrfuiPGV6Ru+MjtsfGJKOhlBcnV37TN6y2O5GhMMspGmZ+kTn8B4POjyDqCcIkveJzyiXkRwpYxgR6EgDfTogCEtNUg4IsKhH8YwY61FtNjCrGreLpGB5Xf6ypsedSHI8HHX4yGH0Zr+dssErZfhXklw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cK3uA52+CkteC9HaRbo0hJSdnXjUqmZjo1K/SBDKnfg=;
 b=hOoe4xtKtBENmT7ucwjS11fiFX3nO5VAmemjtdpQHyThfyP61ap1fkxLo94WRrZ/QriaYKTnCUh43uIwCQWOSn5Cj+WsziAkq5VCTHP4I1asdn9yxxxyYuDE2ul2UsP4QHCdqj18Tg0aLRl8wEkGv5S6XgqS/cmpwwb3O8tkTbxFGkqyhLp2AIlLYpJ01dum+BcK3eqEKeQoqsXOh4QQWYur11M0IbQwMj03Q3EQ7lwBfiTG3/l8weoDscBtO7HGmY5zpmIGd6QrcdnTA1gP3sdb75oT44FNf3xvq+WgXGNx7kmaxYMbH490pYo8nZ0doqG1UU6olxelzDCbMkI3CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cK3uA52+CkteC9HaRbo0hJSdnXjUqmZjo1K/SBDKnfg=;
 b=mQk9HJXI0b+q3DQM68cF1cNvNpRF1pqEWLNQ6Ly9arqxYdj48cr4Ba2p3YjNvblfupGpICUZ8H0K90zT6JrJoXecJAiq26EkNdBKlwj9O1qZDsZa5R9/IJOOLgrq70+zOY/rJippa4XRt+W1CaovNVKaPjZ48YkcvmEhvn89Ti8=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH7PR10MB6458.namprd10.prod.outlook.com (2603:10b6:510:1ed::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Tue, 15 Jul
 2025 15:59:19 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.8901.021; Tue, 15 Jul 2025
 15:59:19 +0000
Message-ID: <abcca88d-89c0-4bba-8d30-422237299ffe@oracle.com>
Date: Tue, 15 Jul 2025 11:59:17 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/5] NFSD: add "NFSD DIRECT" and "NFSD DONTCACHE" IO
 modes
To: Mike Snitzer <snitzer@kernel.org>
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
References: <20250714224216.14329-1-snitzer@kernel.org>
 <ef2837a6-1551-4878-a6da-99e9bc6d1935@oracle.com>
 <aHZqouReZXmD-ql6@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <aHZqouReZXmD-ql6@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0202.namprd03.prod.outlook.com
 (2603:10b6:610:e4::27) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH7PR10MB6458:EE_
X-MS-Office365-Filtering-Correlation-Id: c381b87c-be51-42f3-5557-08ddc3b88ee0
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?Rkc4V24vN3BUb0tNT2hQMmRzWUxVS1NDQ0NPcFV0b3NEbVFVS28rVGZLbnFV?=
 =?utf-8?B?TTNhazd4STN3VlpzR2lPdStYTTZobEFwVm45Nkxxb2FzUGk0KzY2YW9SUHkw?=
 =?utf-8?B?N2lWbjhtL3Y4ZXNqaG9XTkRidzlxSGxTQmJuTksySnRZTDcxM09FdUQ3KzRx?=
 =?utf-8?B?dWZRd3dUdytkaVc5NDN5dVlMc09IK1I3RnZYSkxGVi9uV2NXSjNRNDZuNXQx?=
 =?utf-8?B?S0F6amc4RXA5c0N1TSs2Q1RMSW1TM2ZnbERnWEhkKy9obHJSWHM0QnhWTHFZ?=
 =?utf-8?B?dForcEkwWisrb2srbEd3RS9jelBJSjMraEpYVktSbTFGMVdYdE9IRTZ1OVJU?=
 =?utf-8?B?bzFmeEViZU1DREMyNHQ5ckNtU09EWHlNdFVEVUhEVWtzV3NRL2piMk1yZWJL?=
 =?utf-8?B?aUc3TFJlRE1UcDhodGpCZ2o2R2Nudmtqb3pHVEVobUF3TW56TjV2QjYvcWNB?=
 =?utf-8?B?OUliSW5OUWpzaEZiWG1HUWs0MThxNkJ3QjBqTU1hODJRaGdLeExJdVM3Nkhs?=
 =?utf-8?B?clhUcFhSYzExS1VHeDdFangvc0xzaGFLemY5QXZpc1hidWdTYzI0ZHlwdDRM?=
 =?utf-8?B?RGc5TzhnQTJmT3VuVzBGbEU3RXpVUTM5dll4YUVlWFY4MmJtMTNGUjM1Yjlw?=
 =?utf-8?B?Qkx1aEtTSW5tV242Vjhrczlac3l2QUpGTnNMVHNock4yMHREa29qeEhraVpO?=
 =?utf-8?B?c09iN3dHRTdwM0szQUxhSE8vS0FYaURPeFdlWEpyY1NmN0NiSG8zRDdOZWlx?=
 =?utf-8?B?Q2lRZUNTRGhPdFZyd3gxUlF6YXZtK3pRWWhzSlFXa0NtUWw2dWx3R0dOalcw?=
 =?utf-8?B?QnlQdTFuTERYZVZ6dnk5NW5XbkJnWEtPV1FXemFsdkx2bGNxODkycXRhV0Fi?=
 =?utf-8?B?Zkg1NENCOFpSdGNFTTUwam9QSDEySklvMkJFUm5FRldFd0MzMGhNSHZacU1D?=
 =?utf-8?B?bjhHUHV0NmFWMzdhTTBrYnlESUtQdTZrT2o2eVY3WGNHeEMxMTRVU1F6M2o3?=
 =?utf-8?B?b1FXQzRVM2cwZmlKZm5wdWN1K0gzNTJmNkd6YzZoeERxeW9Ndi84U1hyZWdW?=
 =?utf-8?B?d1Y4amx1UGtVbHYyVGRMMm0vRFo2RDFBUjN5Q2lQdTY4dllGS0JRaTIraGQ0?=
 =?utf-8?B?RS9GbWgxQnJpWWpMZ1pERyszUXg2YWVIZTZEL3FYMnlBL1JKWnBhdjlMMkFW?=
 =?utf-8?B?dS9JNXIvaVgzSWNIVk5GSlJUUllONW1VWTBZemFQNC9ZZ2ZWUzFXcDVQVzRM?=
 =?utf-8?B?WnRhQmtvbGFrd08wenVMSmV5UzZidTY2ZUxFRWFyUm1JdWtqeno3d0MvdmFB?=
 =?utf-8?B?amloMmt5Y0FmV25mc3ZndTFkYndVMHVMQ1lqdnZPSE5BdU1mQ1hpMVIxMnht?=
 =?utf-8?B?Ty9uNFBJc0cwNlhZY3FmK2NwZXVXWFlzQ01jNEd5WW9GR1ppWFVrUnVKcjRG?=
 =?utf-8?B?M3V5YzVHUFgyeG13cUVRRnVjSlhOa2F4QWNXMjZuRGtmUlRLbmVQQnFWTVFV?=
 =?utf-8?B?N0RUVTNhWGR3Z0ZYTGpoUk9oSnJnbWJhaDJ4SlhrRlVLYXJiMzVCaUhXbEh1?=
 =?utf-8?B?d01TTG9VdFJaQTBDcHk3bzZGZFp0ZmV4ZUdWUXhLT0JNMXdaeWhXYnpyWUhq?=
 =?utf-8?B?TjkyOWUvK2QyRGh2Z200b01tZDZNLzR6aTZvSEJBTGpOVmNCTzYzbS83UXhS?=
 =?utf-8?B?K2VnTUFpbzF4am4wdzJzbWpmMmUrYzBDRnhXaGVNcHYzNFhNTGNOY1l0ME1N?=
 =?utf-8?B?djhHTnFLMk9iL3hYWFI4T0VOUVcrRkFVdm9JYi9obnU5Qm1vQ3Z2WTh4dkpZ?=
 =?utf-8?B?cFBHYkYweHBCOWNBZ2RVekhZbGt0UGhEZU9LQWVrZ0x0MXNjVVViRTJOcWx5?=
 =?utf-8?Q?D6kbx06wGpeNN?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?dWdmZ3diNkRxcCtCWWxwU1VFNHVnN1R6SlNHSk1naEplenV5NjhzMGxpMWx4?=
 =?utf-8?B?RDNWSzZXZStUMitxZGszRVA2NkxTeExZTFBKUlk3KzN1Q1R3M3ZUaUpIZkZN?=
 =?utf-8?B?eE16UnpPVUx2eHFpVjl5VVZrMXh6WldFYnIyd052NnU2Z3pTVnVNSkFSZVdD?=
 =?utf-8?B?ZkRueTlaQWRycjB0bmF6ZXkxZzBwZ1VLZ3Q0Q2J3dkFGV0ZiMW5KTlMwd1Zl?=
 =?utf-8?B?b09TMG91c1lVdERxTnhnYnYwUVo0YUhHcGZ6YVFCUG5seHo0U2p5SmkxMnRO?=
 =?utf-8?B?L21jaVZUTXk3c2svemp6Z09rcll2UndVRkoyMnVZQk1hMkxVYmhTSDJoK0Ny?=
 =?utf-8?B?SEVaU2dESEFRYW91cXo3NFdQa1ppL0tHT05RZVhUQUxLejJvZ0FabDBLS3du?=
 =?utf-8?B?dmc1bFlCRHVSeElXVkxpWEhMcVp1ZFJIQ0ZxeVYrL3d5UmgzT0dnbXJVaXJZ?=
 =?utf-8?B?b0JQRkRlZ0JRUVFMbmVoazRIbktrSG1qSUNFR2JpQXg1OUVTWVFIa0R4QVFy?=
 =?utf-8?B?VW54YzlrVjNybEM3M1RWRmVrUjdmZWV6ZDdJN2hNM1dxK0YwY09HZ0gxNExo?=
 =?utf-8?B?Wm1UekRXdW1nb25QQlZ0T3JNeTNXTVFZcTZwUXdrdCtYZ2JuNndBN2RVUVJt?=
 =?utf-8?B?ZUxGMkllSmZCbkpBVFZUdEFHUk51YSt2RkJSNGM5R2xsVldxbGlGQ2xFZ0ZN?=
 =?utf-8?B?ZTNhbmtDaEtIUm1GSzRla00rSFFhOWxsMmtSY2hTWjhMYXF2eEV6cFhLOVB6?=
 =?utf-8?B?YzV2Y2pQWEFVWEdsbThrWm82WjBVVHJOeWJUVVRIcDlNNGtMTnBCalc0T29L?=
 =?utf-8?B?aVY0dW80ZUY1RWNrMnpQMFNkYnVaTlQ1ZytGVlRvYSt3Y1hRL3V3MWFYK2ZT?=
 =?utf-8?B?TU5xR25ydGVrcGZEMFc1cHR1YVNmTHpKVnlxZ3lXM0x0N1VURDBuajE5Qjg5?=
 =?utf-8?B?SGFnalJzWHhGV2lZa3A3d1RnZHdNK2JYOGhwU2VkRWZxTGhCYkMwdEI2aG9v?=
 =?utf-8?B?UXE4T0NiWS9ZL3ZZVlRNcnhLclJvMncxM1FqVVA5dms3SlI1d3ExNUo2YVpv?=
 =?utf-8?B?b0hQUEJCU3V3bmdXWUo0YVRRMzU1RUlHd3k2Mm4zUFA4R3c4ZWtlMzV2bGwz?=
 =?utf-8?B?ZkY0dHZpUG1HYjdoRDZYQkwrQ0ZrN09zb1hodnBYd3A1SmlwbEd1TnhwWmNi?=
 =?utf-8?B?QnpEdTJ5bVo5ZEFSbW4ydFRnYnA1NERycWZEL1dsMVdWU1VTUnRhdk1HY011?=
 =?utf-8?B?UG1iUUVJek1VSC9DNmdBUTZkVjQ5OFk4Y1NPNUd4aHFaOWdzWlhvT21UbXhT?=
 =?utf-8?B?NEtBRDNDRWZ3V3ovb3hVZ2tRVHZzdzJjVVZIOGEreGE2czZ1OTFPUjZwVDVp?=
 =?utf-8?B?ODZ4NWxLaDlKN1ZEY2JiclBEM1J6WEtJU2xtQkROVHhBYnQyMmJhd2Z4ZkVS?=
 =?utf-8?B?aUlzOVJkUWNuNldJalpCVUlUUVdQUFora1NMS3Y4RFNwRFh0WHlSQ0xoNXRs?=
 =?utf-8?B?dXQvOGhmNHZYc3ZNczVXSHJsVjRlNzBLQStGcFBqOEFRSnErYlZFbGtzd2Uy?=
 =?utf-8?B?VWZ5MlhkN2ZjOGU1dzM2Mkk1TEJRL1ZpblExRTV1cE9oeG4rZWhDbmxPbGpk?=
 =?utf-8?B?SnAxUWs0OEt4WFdqd3huTDJvQWpPYmRiajNtdjI4WE81cGJYY1kveWVKclYv?=
 =?utf-8?B?UlBJRkU5VmpIdTBCc1RuMExYNW5VRXd5QjhwVUVjRytnbU9pNlNjZFZJZ3Vv?=
 =?utf-8?B?VGozZFd5S2FHSFV4TWhIQ2dITXRxaGo5dnU1dmY1eTQ1NFFXaHFBT1p3eTZS?=
 =?utf-8?B?MGxIeU9NTjZpem1NSTNhUXBhSHBFWjlQenpxZGhwb1ZoWFVvazAzajBIZjNP?=
 =?utf-8?B?aEVra0M2dkpodzgyT29UYmd0MkNDOUZDM0Y0a1NMTTl2QmJaK2FBSTRWOS9X?=
 =?utf-8?B?MlJpVkVaL3FGVzIwc0dpUWhYN2dXRlhrdDUxWUlxby8zc2pKendxR3A1Q3RK?=
 =?utf-8?B?UGFEQmNkcUViS3A2cStPMFk3STlvWkpvM091TlNNK3JRSTJwN2M4MitGMEl6?=
 =?utf-8?B?MDFYejQ5WDRWWmZvR2dOUzd4RDdpQVBCV2t3N1RZbzRTMWZ3cEtOdTU2VWV1?=
 =?utf-8?Q?KFFrT1hCelWJdPfWz3zShpWIL?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	V8+0FTVUTl5LoFVLQQitq3OHoXDD7KXY3PfDt0/Kfc14HMBfJCFSt8WqBNoitfxIWk+piMM2jP1DI8Nn5Zl6SMMJclB1c10drfMMTq9o+x8Ht8trmheTeP+24BruJnjX2mSvG5bqSSePvGb69SRm7W04oGnqBssuA/jqG2CHR7wNcN/Lhm38OWCHvdwcN+r2midvcYiZnKvkKsijjRsPZucbxHva8wOQp/ycQMzsQ26hxiOlOgWX5SXKx6EO1zCvZtmxluz1zR1Ggvqqp+2Uor71T7A0o3u8ogQvjnkIatkbhg8J87tpDWbqcQ02lQe1Z9xoqTpOv0N7Cp+nmT389auBYU6nf5028w3v7xRQSnYIyrlniDWVLTys76KXgCkoSYWVauvLbOrCMhiMyxvcjWUyBh+llJ9XDVMKEg28/GxL0s2imzD09AOXF9F6AWAKP1AJcTXRtTcg9mnpBYSdGYxqiYfO20/4z/npBNfqD/bCJbhc57DVnNUPZYMJdsvl4mwH0zoO3UENZtmgeXIdEzm/QgQxjoTyy6pk8aZO1CjiSMtQVGHSJ3A4Polzz7BcQh1P+LdE6XrH5mx8lXzBRcJ0ax5HsyB/1ND3sWrF7V8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c381b87c-be51-42f3-5557-08ddc3b88ee0
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 15:59:19.7179
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TyGzYsHfxMm8jhyN1CS+hnv5+ywZ/tS8Aq0vXPVZL3UURtvG5TkGsNJ1GhfkOaDC9qQQ0BnKoUZiFo6H+Y2YJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6458
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-15_04,2025-07-15_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 adultscore=0 spamscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507150147
X-Authority-Analysis: v=2.4 cv=d9T1yQjE c=1 sm=1 tr=0 ts=68767ae0 cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=WLGaNtMBAAAA:8 a=HaI9P65KmcMt5G5iZ7IA:9 a=QEXdDO2ut3YA:10 a=gcKz3hfdHlw52KqWNJGX:22
X-Proofpoint-ORIG-GUID: kjClke-qtO7dXZRcsx05fd5Fa8pACrCN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDE0NyBTYWx0ZWRfX6sx/S4Xar/93 sdAaV9nsIpXMB0HCLm95OOKiFP5Gs7omnWww1KSSSPYDDt2256pxdh/aBuVOjVAU9doxLgRm9ws VqbXRcwOFo5/KXP5VGiwQqvhgwE+6vI5/8U5hFMMAH4fqfwxvU25TaRhhCS29Qpvu8YM1TnWckk
 kNnpTZIX3knOcC72Zrr8Qx3D7Wx7Ky7LiQh7C8ORk3Z2KtG+HvSpXFulkOLQIDZ1Pgst006RDDs EX2fjjSJTJmyaU/oLsIjjgAql4Y4LDS2xCY7QFP7BNoCmyH40kCsu6ja2oxBD8JTjmthQcGGBtW qanVaaddLZ89nKOyPWxsihBmt0slKrm0IbSb/NzxJWLWFmSsTMVCz6sKdd6Of2Gv5EFhXnE0OrZ
 TH7wFpPg/PAGGHlKfWYJCJzZqbmg0lAgwJ/Gq2CgzmGd4wPDyoRf8LHSbCmseAj8oM72/Aem
X-Proofpoint-GUID: kjClke-qtO7dXZRcsx05fd5Fa8pACrCN

On 7/15/25 10:50 AM, Mike Snitzer wrote:
> On Tue, Jul 15, 2025 at 09:59:05AM -0400, Chuck Lever wrote:
>> Hi Mike,
>>
>> There are a lot of speculative claims here. I would prefer that the
>> motivation for this work focus on the workload that is actually
>> suffering from the added layer of cache, rather than making some
>> claim that "hey, this change is good for all taxpayers!" ;-)
> 
> Really not sure what you're referring to.  I didn't make any
> speculative claims...
> 
>> On 7/14/25 6:42 PM, Mike Snitzer wrote:
>>> Hi,
>>>
>>> Summary (by Jeff Layton [0]):
>>> "The basic problem is that the pagecache is pretty useless for
>>> satisfying READs from nfsd.
>>
>> A bold claim like this needs to be backed up with careful benchmark
>> results.
>>
>> But really, the actual problem that you are trying to address is that,
>> for /your/ workloads, the server's page cache is not useful and can be
>> counter productive when the server's working set is larger than its RAM.
>>
>> So, I would replace this sentence.
> 
> Oh, you are referring to Jeff's previous summary.  Noted! ;)
> 
>>> Most NFS workloads don't involve I/O to
>>> the same files from multiple clients. The client ends up having most
>>> of the data in its cache already and only very rarely do we need to
>>> revisit the data on the server.
>>
>> Maybe it would be better to say:
>>
>> "Common NFS workloads do not involve shared files, and client working
>> sets can comfortably fit in each client's page cache."
>>
>> And then add a description of the workload you are trying to optimize.
> 
> Sure, certainly can/will do for v4 (if/when v4 needed).
>  
>>> At the same time, it's really easy to overwhelm the storage with
>>> pagecache writeback with modern memory sizes.
>>
>> Again, perhaps this isn't quite accurate? The problem is not only the
>> server's memory size; it's that the server doesn't start writeback soon
>> enough, writes back without parallelism, and does not handle thrashing
>> very well. This is very likely due to the traditional Linux design
>> that makes writeback lazy (in the computer science sense of "lazy"),
>> assuming that if the working set does not fit in memory, then you should
>> simply purchase more RAM.
>>
>>
>>> Having nfsd bypass the
>>> pagecache altogether is potentially a huge performance win, if it can
>>> be made to work safely."
>>
>> Then finally, "Therefore, we provide the option to make I/O avoid the
>> NFS server's page cache, as an experiment." Which I hope is somewhat
>> less alarming to folks who still rely on the server's page cache.
> 
> I can tighten it up respecting/including your feedback.  0th patch
> header aside, are you wanting this included somewhere in Documentation?

Nothing in a fixed Documentation file, at least until we start nailing
down the new per-export administrative interfaces.


> (if it were to be part of Documentation you'd then be welcome to
> refine it as you see needed, but I can take a stab at laying down a
> starting point)

You are in full control of the cover letter, of course. I wanted to
point out where I thought the purpose of this work might differ a little
from what is advertised in this cover letter, which is currently the
only record of the rationale for the series.


>>> The performance win associated with using NFSD DIRECT was previously
>>> summarized here:
>>> https://lore.kernel.org/linux-nfs/aEslwqa9iMeZjjlV@kernel.org/
>>> This picture offers a nice summary of performance gains:
>>> https://original.art/NFSD_direct_vs_buffered_IO.jpg
>>>
>>> This v3 series was developed ontop of Chuck's nfsd_testing which has 2
>>> patches that saw fh_getattr() moved, etc (v2 of this series included
>>> those patches but since they got review during v2 and Chuck already
>>> has them staged in nfsd-testing I didn't think it made sense to keep
>>> them included in this v3).
>>>
>>> Changes since v2 include:
>>> - explored suggestion to use string based interface (e.g. "direct"
>>>   instead of 3) but debugfs seems to only supports numeric values.
>>> - shifted numeric values for debugfs interface from 0-2 to 1-3 and
>>>   made 0 UNSPECIFIED (which is the default)
>>> - if user specifies io_cache_read or io_cache_write mode other than 1,
>>>   2 or 3 (via debugfs) they will get an error message
>>> - pass a data structure to nfsd_analyze_read_dio rather than so many
>>>   in/out params
>>> - improved comments as requested (e.g. "Must remove first
>>>   start_extra_page from rqstp->rq_bvec" was reworked)
>>> - use memmove instead of opencoded shift in
>>>   nfsd_complete_misaligned_read_dio
>>> - dropped the still very important "lib/iov_iter: remove piecewise
>>>   bvec length checking in iov_iter_aligned_bvec" patch because it
>>>   needs to be handled separately.
>>> - various other changes to improve code
>>>
>>> Thanks,
>>> Mike
>>>
>>> [0]: https://lore.kernel.org/linux-nfs/b1accdad470f19614f9d3865bb3a4c69958e5800.camel@kernel.org/
>>>
>>> Mike Snitzer (5):
>>>   NFSD: filecache: add STATX_DIOALIGN and STATX_DIO_READ_ALIGN support
>>>   NFSD: pass nfsd_file to nfsd_iter_read()
>>>   NFSD: add io_cache_read controls to debugfs interface
>>>   NFSD: add io_cache_write controls to debugfs interface
>>>   NFSD: issue READs using O_DIRECT even if IO is misaligned
>>>
>>>  fs/nfsd/debugfs.c          | 102 +++++++++++++++++++
>>>  fs/nfsd/filecache.c        |  32 ++++++
>>>  fs/nfsd/filecache.h        |   4 +
>>>  fs/nfsd/nfs4xdr.c          |   8 +-
>>>  fs/nfsd/nfsd.h             |  10 ++
>>>  fs/nfsd/nfsfh.c            |   4 +
>>>  fs/nfsd/trace.h            |  37 +++++++
>>>  fs/nfsd/vfs.c              | 197 ++++++++++++++++++++++++++++++++++---
>>>  fs/nfsd/vfs.h              |   2 +-
>>>  include/linux/sunrpc/svc.h |   5 +-
>>>  10 files changed, 383 insertions(+), 18 deletions(-)
>>>
>>
>> The series is beginning to look clean to me, and we have introduced
>> several simple but effective clean-ups along the way.
> 
> Thanks.
> 
>> My only concern is that we're making the read path more complex rather
>> than less. (This isn't a new concern; I have wanted to make reads
>> simpler by, say, removing splice support, for quite a while, as you
>> know). I'm hoping that, once the experiment has "concluded", we find
>> ways of simplifying the code and the administrative interface. (That
>> is not an objection. call it a Future Work comment).
> 
> Yeah, READ path does get more complex but less so than before my
> having factored code out to a couple methods... open to any cleanup
> suggestions to run with as "Future Work".  I think the pivot from
> debugfs to per-export controls will be perfect opportunity to polish.
> 
>> Also, a remaining open question is how we want to deal with READ_PLUS
>> and holes.
> 
> Hmm, not familiar with this.. I'll have a look.  But if you have
> anything further on this point please share.

Currently I don't think we need to deal with it in this patch set. But
note that NFSv4.2 READ_PLUS can return a map of unallocated areas in a
file. We should think a little about whether additional logic is needed
when using O_DIRECT READs.


-- 
Chuck Lever

