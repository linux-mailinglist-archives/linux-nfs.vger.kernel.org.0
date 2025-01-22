Return-Path: <linux-nfs+bounces-9464-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB574A193C5
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Jan 2025 15:19:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA4FF3A1012
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Jan 2025 14:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0547C213259;
	Wed, 22 Jan 2025 14:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Q8CAU+vB";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="y754yO09"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2554A212D6E
	for <linux-nfs@vger.kernel.org>; Wed, 22 Jan 2025 14:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737555584; cv=fail; b=cZkuVNeWxWZVxruepCkKbPHIp6LrVsLc3ZUrTZJPOu82vIrcTGYwixeghix8Q8jJRu146z0uXkWBP+lhNZr3QVhxfrU83yyP0Vml5lrUaz1+PmwT9PJXt3Drikypp+MrlwRkNYc+VS+rPdTgXwYVakckLgRfWLWlcXNADuwFXf4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737555584; c=relaxed/simple;
	bh=aqiXcQRAB9eeUHnznKLVpB+H9GAnOuqflT3sNWZiH/g=;
	h=Message-ID:Date:Subject:To:References:Cc:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HXXHa7EFkuRhOtMnypHIjGKDtiGVjR/pWPw/z9/aps2d3DPr5coW5ybTu/IQL+YTo4Yx0W9Vfv99MF1L9/puOeRN3jxTGi33AZPmofnnduABJfgFMrJzlkfWqSqTJB0o2oF2MoJ0ZXbtOD5knYHnkPljYIVdx2lW59RObUFkShA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Q8CAU+vB; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=y754yO09; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50MEBuEl029382;
	Wed, 22 Jan 2025 14:19:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=Yj6ueOBj6wzGnc7jx+sLC41vSmIV40UrH+s6c3od78A=; b=
	Q8CAU+vBxRBxTztRRDB6wrmLuzuiqYG8U9TbPMGbreUmBesI+vPNVb5XJhOu5c8h
	CytofeQtVG+N60BRCHfYdO9aGJiIuzSBcsRmTn0o11fV0A18blSWMYn5QajxR5zm
	HakndS2kHcNc5nDXA9rO/V8D52kjbhmU4mtdjsBHPU7JvzeG/UUvBo6H1bcKBBhF
	Iexry6eMIRXrDbhPlnRs6db0Am6Th45ggS75OLtPN+FdLkHrhmxXsGkiyzicMBzt
	GVqwUAScBUIpUNEqujBtHd+wEtrGhLEMb/OqQR+0t9S0S4/I1vOD4lmukGuceg5y
	PA89UNkWECH+2pNSc97k8g==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4485qkys6e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Jan 2025 14:19:15 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50MCJr02004810;
	Wed, 22 Jan 2025 14:19:15 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 449195p4ng-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Jan 2025 14:19:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rnc8xY40UF6l9W8o5yLQXObAo1DIjpzxfygynoGM+qimaHrrEBPeONrMNSyPqzjg3atYQjv42KvCh5SrdLfbhtpmPJn35GbvF5mlqltuTym2NuNaJEQZLX/dIt9mZhGaRL/MZWUmXwvL/Qg4sLoYymOraLFk2JvTIBtl3tR2M4TAQSbugw8OP4x+d/0qffcwSSZJT0D9wb2Bs10sm8IoPwmDf9BVd9Nr0pyqdjJwZkl0u/aTFYsCQkZLR4RybItGK8YGUyMZtlib/pQLjdeoY3bUlo88iSAKrC14eSKHrS+denpJelfcnkLNsYMv+L7cOrgvplwUvHGyous2J9H+4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yj6ueOBj6wzGnc7jx+sLC41vSmIV40UrH+s6c3od78A=;
 b=EAPvWMIEUCg//odDjzbssRfQLIG5VdACQLOGnx8P34Jfomi376uVKUlNZsdKK9i7DXgEmkg6H/jod7XqxFPMNBpsiAWf533Klyb4jDrloEGlqwsg2aIhDFwEg8hzXQ+RWFds9eoDa8f/jUEpsCh7moOgiw83kBR8YocFzS1MRAkOYFY6hPWO/NvIxF35S5no2KiHbWUByn2K+ywuG+SdE/eqy+td93nY/noS2IPcErQKy+06g1/nPWQpDntUDuvx5hLPOhQaxK35psoUt4ooSpb70g3k09sXAOp8QSWArPPzmHAZA0bjD3Tid3BuipBT+8uB2fOu7IVgRz8/N3JHmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yj6ueOBj6wzGnc7jx+sLC41vSmIV40UrH+s6c3od78A=;
 b=y754yO09NQxOEqLEWLsts2RumEB8Ov4Skp2Jhb/XebtyvDcy8qq+db4h+XekaqvrhWtu7MyfTVmzUDwE4xICSECYyg6lt0WibZGpXgrtHBG2SzwnKn6NuXPN6Tw8IodqAy0I1YPatTVhtvQKfRQnv2faLI1RthKbKbQ2vJcIwA4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM4PR10MB7403.namprd10.prod.outlook.com (2603:10b6:8:184::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.17; Wed, 22 Jan
 2025 14:19:13 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%3]) with mapi id 15.20.8356.020; Wed, 22 Jan 2025
 14:19:13 +0000
Message-ID: <10abf17a-b996-4881-9cf1-675fb0f5f9e8@oracle.com>
Date: Wed, 22 Jan 2025 09:19:11 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: NFSD threads hang when destroying a session or client ID
To: Baptiste PELLEGRIN via Bugspray Bot <bugbot@kernel.org>,
        baptiste.pellegrin@ac-grenoble.fr
References: <20250121-b219710c9-24c03eb0cb57@bugzilla.kernel.org>
 <20250122-b219710c13-b7767e78d1ec@bugzilla.kernel.org>
Content-Language: en-US
Cc: benoit.gschwind@minesparis.psl.eu, linux-nfs@vger.kernel.org,
        harald.dunkel@aixigo.com, trondmy@kernel.org, carnil@debian.org,
        anna@kernel.org, tom@talpey.com, herzog@phys.ethz.ch,
        jlayton@kernel.org, cel@kernel.org
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20250122-b219710c13-b7767e78d1ec@bugzilla.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR07CA0020.namprd07.prod.outlook.com
 (2603:10b6:610:20::33) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DM4PR10MB7403:EE_
X-MS-Office365-Filtering-Correlation-Id: 2099a576-5a10-462a-7d54-08dd3aefbec7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VFlONGZpRDZsTS9IVHJwdG9zS3c5RGFTTU5WRVBEcVYrRnBZbDlEK2QvZlI1?=
 =?utf-8?B?WnRFcjFUM0J3S2lqVkM3bTJnRkpLODhHRWFWaVYrSFJORXpDaVRiSlBRNHFX?=
 =?utf-8?B?Z0pGNVFLTUlWZ21NQ2hWWVZ0clRVdU5qY1p4UHp0VVB6N2xiRXc0Rmk2TUUw?=
 =?utf-8?B?N3QzNU1OaTE3TnhEUXYxajJYVE05S0pzZzUyS2s3akZXckhPR1ZScjJ6V0lo?=
 =?utf-8?B?bHdLcG5mMUhLSEV4cDRUZitDMkVHaUc4V0M0NjdaTmNqaC9NRjl3SEFjS3hZ?=
 =?utf-8?B?NTNtS3JmVS9yRlhtc1JQVVJraHZEcTR5ZjFaUmpKbFpoYXhTZjhyZFN5NVMy?=
 =?utf-8?B?Q1Y2eVRuM0ZJYTZZV1d0QngvQnlFYXpaakVnUmhDby9SbkJEMXl0RUMxRjIv?=
 =?utf-8?B?Um9rZ0RuSmVhczhCbWd5STRubTM5ZlR5dHRBSzNtYTZiNGdWdTk5RzlwZEFk?=
 =?utf-8?B?bTJMayt5QnZDSit0UnpiNmxrNHgrUDBLWFZtTmlqSVJ5VDBpMW5QY1dWSENq?=
 =?utf-8?B?WDBVdXgvTUNvR0lSOWovdzhuNlFwVDhhVDNjY1FLT0pYRlVRTTdnZzFiQ05q?=
 =?utf-8?B?RVhYU1dkQ3pZc3JiRG1pZ1VWL3h4UWUrUm10cCtHZkVOV1UrVDFBaUZ4dGxn?=
 =?utf-8?B?SWkrKzM0NW93YTFDZThLcHdqKzVDQlRacmw3Qkw5Wk5XMkd1QzI1TjhKa3Fz?=
 =?utf-8?B?RUl3cSt4dS9kYi9pclBkQng2YjdVR05DWTlTajdvUThWYVE5TkRhbmJEVm5v?=
 =?utf-8?B?TG0yUStYMktoZEplMS9rWkpiUXIrbVdPOGxkT1N2VFVnN05XNEVsR3U2MUkr?=
 =?utf-8?B?WmJxbHJhT3Z2ZEN0OGhQRkhYN284MjExVDZqanZvQ1ZxYXlXcWxHUGtxbzFN?=
 =?utf-8?B?ZlUwaXBqSklhUklhcC9GeE9ERGVDWGpvZDd6aFJNRUo5WUdVaHdhc3NEWTUw?=
 =?utf-8?B?NmhPdEpWY1lYek5lelFNd2ZaMm44WmkvY0Fqa1Qwd3dkSUswZHJ3a3Z5N2xi?=
 =?utf-8?B?aDdQdjhqemNWTmxPYzB0NUsxU0R3dVFBRUl4b2NPdzlsVmhhdTZTckIzeWx5?=
 =?utf-8?B?ZFFjems0bFJUNmM4eTVUZi8wUzJ5b0t1cFhxTmQrN2RJYVQwMk9WcnpSUitW?=
 =?utf-8?B?SG4xbVNqdUpwb3ZHZ0dCVUsrZTJ6bWpVLy90aWJObmYyekJ3SzRIVFY1Z0FO?=
 =?utf-8?B?STFORjBnc1lNZDFZSURnbC9NV3FOODNFRUFDeXhMbHFVTTlwclZxK2FVQkV3?=
 =?utf-8?B?MzBsdG4rVTFzUnJLaVVwMnBCUEl6enYrNEkvT3l5eXEyMU4zdldGaVUrcmVC?=
 =?utf-8?B?aU05aWs2TThSQUlZMjE4Rk91anRhanlMandCaFJmKzgwL2oyOFc5RXE4ejd5?=
 =?utf-8?B?bi8zM2JxZk5admlhaUNqeFpKR2N3Tkh1cUUrdXBEN25PNTBUQmRZdWlWVE5r?=
 =?utf-8?B?elZWK2J6S2h3aFBWcVRDZDBKenlqQi9HM0JIbzh2LzVRM00wdzJzMWxMZTNZ?=
 =?utf-8?B?NTRkNGN3ZnZaN1JLZEd4cDUwcUFDZk5DMTNCSXZ3QjhZb3Nybkp4b1h2alhG?=
 =?utf-8?B?Z2lIQmI4elZSbFJxV3BIc2hEQzR6VDYrRzJpc1B3bUxYMFI3SzhodGV2cmtM?=
 =?utf-8?B?TUN3ajU1bzdwQ2MxYk1BM0tTSnViOW5kTFk5VnJzZkRmNUZ3MHg0Q0F4SVY4?=
 =?utf-8?B?aDdhVjJBNUJMSVlyTlBHV1FBYytvaEhheGk1RUxZWE9yWnQ0Z2RoRC9ya2lq?=
 =?utf-8?B?RTRobURZSWtxMUpDcUN4ZkQxcnRVc1lOTjFFVmhJVkEzTHBFeWd6UEpkU0tN?=
 =?utf-8?B?RzFaU3czL1FGai9SRHVIa0c3SjhMQXU0VTJUYkZLQ25rQjdjM3ZrTnBSVnl6?=
 =?utf-8?Q?RBR1ySNJLCYwC?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?em9FVzVyWU5OMHM0Q0t6ZkppdG1mUVRIeXFHR0VsSkd3NmhZK3BlbmxlWjl6?=
 =?utf-8?B?WnlCOUUxZkY1b3RWclBNek9KVUdVbzI2QTlYWEVOVjFpeFQ5N3NyWFhQV0N5?=
 =?utf-8?B?K3orbXBlemorc2NsMzZSTVgrYmt5cEwraHpJUzdlUGZOVzYrVjJSZVRQK0ZC?=
 =?utf-8?B?WVdlbDFuU1c4cHhzYjlXUmJWT1pQRlI0bjQ3NFhaaXZQVkUxdFdIWWJUaHI4?=
 =?utf-8?B?bThUTm9ycjlYZTg1T2xwWTc3SUlmU05CMGE2TmFDRFBIbTg0enZmd1ZKZjdJ?=
 =?utf-8?B?WHFsSXJZQ054bDRpaUFSWXVvYTBQT0IybWhjUWo2R3kzaVo5OE4xY1dsU0RK?=
 =?utf-8?B?ZVl3MXRZUG8xa1FHUzd3Y1ZjR2hXdFJ0MlpBT3lLd3FybVZTczVJQ1hTb3dm?=
 =?utf-8?B?clRENmdlTXRQUnpETTZTWDgrUCtXM3FpTnNEMkliT2Nua09KbFJrTVV3djZ1?=
 =?utf-8?B?TjNjT2QyU3JhK1ZzeHdzKzRxR1pZOVBuSThIa0JGVGlUaFhYT3RjL3l4bmRJ?=
 =?utf-8?B?Q1hiRGp4Y3ZNQWhvQ0toWGlnTUFZbTkyUHVpSlA5MFd5YmlJb3FqYmxReEZO?=
 =?utf-8?B?Y0RkcHY4K2FKVllRMkRuRm43ZzY5ZHY5dU03L0w3dlV6azNVQitsR251VjRL?=
 =?utf-8?B?SlU3RXl0OFEwQkplVUtBQXlSY1hTTXcrdFJYenE2QmRtY1R6SkhkOWwyR01K?=
 =?utf-8?B?SDRHYkNiS2tKQWtUYkJKRWRTMGgwV0RyZks3UzNtdXdtZUcySVZSR1d0Yjhk?=
 =?utf-8?B?TUtvM0phUTBHVnZ6QlhuU0hTNUl3eS9UUHJxQkJyVEZINnJtRkVQZ2VkdjBB?=
 =?utf-8?B?dmdDeFVoL1RVM2E4Ty9aWUl5Y2E1R3JkNDg0QVJDRG9JM09CczdwMGF0QTRB?=
 =?utf-8?B?cFBZMVF1dUluYTZNWFplMmIrVW9LRDZxbWhRTUljU3hLQkhyS3ZBTkkxY0xN?=
 =?utf-8?B?Yi9TK1grODNLQmpxQjJ4aHBxaFZhQy9FaW0vK2xlMTk4Z3RKMEttQnYyMFZK?=
 =?utf-8?B?QkZGeVgrNENhU1RxTVNHTEI4ZlBTZUVyOUNKNGljQWhvbHRORGtROXZnWHJs?=
 =?utf-8?B?cGVTL3lNUVIxRVVXZlJ4ZENVeDFGcmYxSHJtRnR4SGV5VW9aNFhmVTljSnkw?=
 =?utf-8?B?cC92UmhNdHh6N0dYVDczdUlsZWlMZ0srZis0VU84RGl5bU1uK2lqODRsSHJ1?=
 =?utf-8?B?N1pQMlNPNm5TZGNsUGprdTQ2SjJ0RkZBOUlyUElLNXZuRS9vbXM0YmdGVDhx?=
 =?utf-8?B?T3Q5RUkzYmlkaWRZOGowcExpcEMvemROcTFkSzBXMHYxZ1FSRW8wS2xRWXdM?=
 =?utf-8?B?dWxKTm5lSTU3citBdUN3UG51aXJIVGNCWUJYWU05YnVRMG8yR05HZGRKTk1z?=
 =?utf-8?B?b0VUNlNRaENBMEJ2UDY2aFplSGNrK2tyOUd1elZ5Qm8zNzNjT3pZQ1hubDNr?=
 =?utf-8?B?Z3NSZkQzMFgrUFFkRUE4NTNHR3pTNURxQ1VOd0hsUlBXaW8rZjJ4elZlWHlM?=
 =?utf-8?B?YzdMaWFzV3Y1NVVvU0d3VHNZV1h6RjhObUx5Zlp6Qi8zem5DbUltbFlrNVpL?=
 =?utf-8?B?RzU4aGE4OCt2Rmx3WFhlYW5WZ1FTdXd6bkhRV3g0Z1BvRUZwR3QvK2x0K2U0?=
 =?utf-8?B?M2c2K24zY2JaNHlaVTNOV0NQM0VSOFBDcnBUOVlQMjliSkJocWs4MG5nTHNi?=
 =?utf-8?B?ejE3a0RzckZWZkRhTzlwelhvOG5kMFRLdGxKVUd5dC80aFZhR255YVJsYWpq?=
 =?utf-8?B?bERSdEdFeGVhZjdDQWNjdmYwM2RVVk83bzVIQVpsMm9pZlltVTdPWVViV2w4?=
 =?utf-8?B?UGEwY1grc2R3dys1Yll3aGtmNStTQWRyNnhDTENZOFRtNkZ6UDhON2J1ak5C?=
 =?utf-8?B?YW5SeHBNNlBIUXJMUC9WTzhCYUx2QjZ5eXMzZzk0R0ZibFJJMDZqZHl0SVN2?=
 =?utf-8?B?ZHl2cmRTYXRuYm42Q3FjQTRQQnQrbHZrYmlRL09hWWF6NUF2UnFTTGt2TXJU?=
 =?utf-8?B?ODdRall6cmxyRzIxVldDVUlyWG5YWDVpdFVkUUk1eWlMVWl6Smh1aUVVM3gv?=
 =?utf-8?B?UjlRWmtBU1dkK1hsdjlxYkFOUGJYWjZNOWNvRFhwM2tGTlFLQ3JEUlJ1MStw?=
 =?utf-8?Q?Quhhj43h2VaKX1O/u3c3zyWP/?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	WKQDNhDMEo6cWFb6F6L1DpP+iPpeauIIq+3ytO2oAjnXE/3GK1OSDDM8bM2NrTkKQTIWXUaCOMV6Ni1va+ZUAH+GxoTLcEaJWh5eIk+Uc8vlntZtLzDQwp2qcVPOXuxDibAIubqdEtX214ROi4KCazI2msZYWf+As/sVJlWXkBiJcrpo+apKgiwP5KeDNMTNrFBClIev8kd5F5OsSrOgnpIj/ed/skIlfjnl9RFUAQCwy9u8QLhoDYjGGenDpcmG/+/qRuQiz+v860MJboHsBfrn1zwKyJU1O9q979v2nyW/pSv8KIK4k1E245qYnMIZ0h0CZJSTjqt7hXBDnPNJEExqzkYsoeAYG3NTYBNCPGrb5W9WWX7g4cLU1Pql+GmZMpEpdHqxLBmDvs2iBSWtegEi7LAGcarWVUFTbbMnr/9oR/GV7Gdy2KQJRs2mMnDKfelamocf4LjkAzOBHFx6JGq6M8iaXSXzIM+si0JsBUcQEDSyrw5SNBxP+vmJy1vzkc8q6wZ9aLQVy6OOL8GnHjAmw3nLhlM2zUemjhXjP1n8CsVCLUkV6UL4pL7o/5mqIRRk+GCjSv4n+zfYw8lQsLKpk+rRfapzsyBjQSca0xc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2099a576-5a10-462a-7d54-08dd3aefbec7
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2025 14:19:13.1397
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Alg6SoPpujkzIsAa8shqsWrHeUZynyaEzJHieH8p5MiXv6ql+t5aGCAcufd/l87IhBd7vwHKpDQdFHxXOHySZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB7403
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-22_06,2025-01-22_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501220106
X-Proofpoint-GUID: gOxmQJBik8JfovwM6a7krNB900_X4MUK
X-Proofpoint-ORIG-GUID: gOxmQJBik8JfovwM6a7krNB900_X4MUK

On 1/22/25 6:40 AM, Baptiste PELLEGRIN via Bugspray Bot wrote:
> Baptiste PELLEGRIN writes via Kernel.org Bugzilla:
> 
> (In reply to Chuck Lever from comment #9)
>>
>> The server generates a CB_RECALL_ANY message for each active client. If the
>> number of active clients increases from zero at server boot time to a few
>> dozen, that would also explain why you see more of these over time.
> 
> This mean that something can stay active overnight ? In my case, no client are running outside opening hour. They are all suspended or power off.
> 
>>
>> "-e sunrpc:xprt_reserve" for example would help us match the XIDs in the
>> callback operations to the messages you see in the server's system journal.
> 
> 
> I will try to help you I much as I can. Is not really a problem for me to run trace-cmd on all clients as they are all managed with Puppet. I will try as soon as possible.
> 
> You confirm to me that I need to run "trace-cmd record -e sunrpc:xprt_reserve" on all my clients ? No more flags ?

Don't change the clients. The additional command line option above goes
on the existing server trace-cmd, but only if the NFS server system does
not have any NFS mounts of its own. I'm trying to keep the amount of
generated trace data to a minimum.

The point here is to record the XIDs of each of the backchannel
operations. These XIDs will show up in the "unrecognized XID" messages
on your server.


> Did you see that I have added the "-e sunrpc:svc_xprt_detach -p function -l nfsd4_destroy_session" flags in my last recorded trace ? Do I need to add new one for the next crash ?
> 
> I will also send to you the dump of current kernel task next time.


-- 
Chuck Lever

