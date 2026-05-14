Return-Path: <linux-nfs+bounces-21626-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IB6EFXU3BmqWgQIAu9opvQ
	(envelope-from <linux-nfs+bounces-21626-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 14 May 2026 22:58:29 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C4DB6546DDC
	for <lists+linux-nfs@lfdr.de>; Thu, 14 May 2026 22:58:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C2A6730254EC
	for <lists+linux-nfs@lfdr.de>; Thu, 14 May 2026 20:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6F7E390200;
	Thu, 14 May 2026 20:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CjQH07Kn";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="faXBpmAp"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4BBA316199
	for <linux-nfs@vger.kernel.org>; Thu, 14 May 2026 20:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778792293; cv=fail; b=aU+1xwbnvJ0cNpNerOQB9n6Hza/Fea8LdvMdUrMen0mwlEwZaScl8hQIfOTuuP/hX6O5Q44Ltd+Lmt3zP3sDPo+UxR7HP6oxW2M865x7nvmy19905/J8fw133tNFdA89yuzLfuVTiC9jRUkMXyLoafvXXL1cllaDMwld9wGuI5Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778792293; c=relaxed/simple;
	bh=Zvc05xWY69BXUSAhtUjF0YtaS/pvcL1j7bjUgiN+vhM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=R8RHePAMa/r3srFDf5Iq+KxP0RYQWd2TwVAwTGOEc0AjuHP76MBCwwYA5H4Kjtoz0ew1ocXQ7Up6VaYV0EBqP+rlYFLIT6RpaJojSRCkbhrnFgyHaIaH+cXzqK42ohMlk68y3095s6evkoynzzg+CLLaBb5tGPvtuhtCo1IivLQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CjQH07Kn; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=faXBpmAp; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64EKSZw22967558;
	Thu, 14 May 2026 20:58:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=dZb9XNjwd8fyFgLKbBsziTAaCiLIw/bOk5w6R/9/QsE=; b=
	CjQH07Kn2Ngyuxy9d0yoKUMUfRTNsDq2IZGJbISc0ZtKkvQ2d9OYkKYw/Lo3YRGY
	s1+QNKplhSKPh9GjpnpevGqMxljF6zSufUj7IkuA++jE8VNpKf6rHU0MsrrQ7wLf
	ZiH/64+qthaQagcqQiVeFHrsL8jg+3Vty0Rs/xKxdvzYw/GvlG6BFA712N2o8r/d
	V6wMd0zt+1eS8gmA75xv9TjoDgGb9YSheO35fA/wdTknx9CFtF9wHQvEw8lFnu4o
	qNmILuAZNE58/xVyOS2ll3wS94eMz6yImQLN18FEXOBSETQNi2K4mfVI6K63KZjV
	kw+K5KY5sIB0p7ekFb64CQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4e5m1rg6bk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 May 2026 20:57:59 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 64EKsrKf040209;
	Thu, 14 May 2026 20:57:58 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010057.outbound.protection.outlook.com [52.101.193.57])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4e5kvxck8g-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 May 2026 20:57:58 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OYZzmFn67LI1umQYP2IxKM9esDWq0eV3KzFf3ZqqeMz2YE4B6OUf2pZo67kjuzvghkcDqUNIugsBlfz0OvKMRoM2AFDQHrEMpuWFuKFqhEdz2EVuSlsdBUfsJPU2pWEM1FeKplYo+CczUPFKuORe9ohd4P2tPeNmFx8s5jRYxXx6TTvPt3JOMQCjfnKRlTr+rAJgl4KeCJVSedn3hI4ukWYq4lfw3CxOGuTpe0flOAwmQ0ilt9REmSp49rqiXaCytpGsFIJ2LsyhMz/p3pu+yzH6BvgsDhMAjDwPVaLpDD1NptfMWnFrcz1DUBN1e1jac4FXUorR5qlVHftk5nT7SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dZb9XNjwd8fyFgLKbBsziTAaCiLIw/bOk5w6R/9/QsE=;
 b=mh9lF09hTZmZryCykkj57WCcclHBfzlHj54DJv9PEr2tlM6fZzj6j5vtYmuR4rtP7FRs219GP5jwWMZVGiQgtBqHu1ioVBjvWIbl4G4gEbeezVVrjKdHlQI7IDceUDJdV4BmObs3RN1euEw78UCG0aF1DNDVRFRvoy59AI7ZMScPlUjLBdnZImHj2efjeYnWjOxeb4fBgOAmN2c8OsZh/u2tzfy7rgi8l+WZT8y3DYEo7LGb9zlRFhFg5kQVN8gmXjHjzy+NZOeN7FRbnjhiwpICgyqXf8qDdk2EGhln3uiKu2jBsOhTeWrjycEETVWKUS1L8jYg8ouFrmN/UEw5iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dZb9XNjwd8fyFgLKbBsziTAaCiLIw/bOk5w6R/9/QsE=;
 b=faXBpmApl/0noBc6DAA1rsdLlAxX/SWkYUYAb153hK0vo5SU9Ca564XPXtNZ6CxP8NmjZiRVmz5vU0u5BKEXfWj7dCc/Z30GE3i7adbi6W8FWxlYEbIBLSKwS4IOgDABTThXA5iwQNfMO65yJ210boqcvzVCuWQu34iCfLcO4os=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA3PR10MB8489.namprd10.prod.outlook.com (2603:10b6:208:583::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.22; Thu, 14 May
 2026 20:57:49 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::4083:91ab:47a4:f244]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::4083:91ab:47a4:f244%3]) with mapi id 15.20.9913.009; Thu, 14 May 2026
 20:57:49 +0000
Message-ID: <4890ba05-19ab-484b-a123-6649900ac34e@oracle.com>
Date: Thu, 14 May 2026 16:57:46 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] tls: Preserve sk_err across recvmsg() when data has
 been copied
To: Chuck Lever <cel@kernel.org>, NeilBrown <neil@brown.name>,
        Jeff Layton <jlayton@kernel.org>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>
References: <20260514205607.348291-1-cel@kernel.org>
 <20260514205607.348291-3-cel@kernel.org>
From: Chuck Lever <chuck.lever@oracle.com>
Content-Language: en-US
In-Reply-To: <20260514205607.348291-3-cel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0247.namprd03.prod.outlook.com
 (2603:10b6:610:e5::12) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|IA3PR10MB8489:EE_
X-MS-Office365-Filtering-Correlation-Id: ffa8b814-9802-4423-6961-08deb1fb74de
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|56012099003|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
 Z+J2OPG97xCI5ZUxbrRPQBdMz7DYupa4IxWTzTXb9E1Wj46nHKNcgiXvVLqJOv0L8HxnhIgMGzfzNMP2sCrK1ZVLD75hRK9njU5xcGN79hw7Z5Z8EHwVKjkHXzMjIOnxibgFVvNIzfYuZadZiJ6su+KJMGNklKRWRV2Q0TbVv9At0kpUqxSpJ9vm44HtqmMDz8Ff2HPyctEne9WXH9hPWbQNB5CJuLghGW1MxtnuV+fXC1sR9b0zivgHWHpwxUYx651Og28/PDlG61N+4r0jQ7531yy3x+Y/hJkMzUKXhAmX0A6AujUtbJ5LZC2HjU9avaZwz33zFDawvPMdYe91etkLba0oBEeyIGY0+CgiQagxDnyNweHw2MFNWS6kkUDOGhyLTrJrIzQxwBezKBnplgXktWSgHXj1mvxrl5tvYNuWMBZCDt6uoMk9fuSUHyPeEuJvCoVCgEjnDugrp3WKscHH6HDABxe36lDFng/lzAsQQ51ib4bgtGsWM4vX9c/JKMCl5QULa2mZKLJAWDY9l12CYBF9rGc5Ku0tKN1/ZxaKiPY7SBQEEmS0XP5M8h0IoQIrisbDD7OtizbQC1zcIp3B0m0FP5brWtdg8PQD7kEfgcKbTXaZnNR1gDqVzsy4WvQonaZ1kXEWbmtOtZobrj2RRRJk8YZNfiV+1L1aRkLRV9SFbfIn/S2p4JMWz9hZ
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(56012099003)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?U1cwMkY1L3JLaGxvc2NUN1Q0RDY5a0lRS2RDVzNUam1YZzRTM3N6Q05IL3NZ?=
 =?utf-8?B?a0dkQnJyMUxMU2trSllmaGhHS2FRdmtoOUJhZFZ2Tll0a09oeHFsZDFxVDR0?=
 =?utf-8?B?UUI0SEljOWdNQ1N0U2E5K0plUkYvWFhUa0dwdEV2MFZDelR2UENFTHZrMnFD?=
 =?utf-8?B?dnN5a3dza1hzZmMwakN0VWFFb25acVUxTXFiT1FCOU9za0xtdzE3dVkvblcv?=
 =?utf-8?B?enlKcm9ldFZ0RllOckQxZjM4RWlCMFhwZmRqWXVVTTBmNDJxWUtxRUgwMGNR?=
 =?utf-8?B?VDdiLzRIRnVra29Cb3pjUUdWVThnc1c4RUtwdFg2TXp1OXJrN0NUUHUrNWQ4?=
 =?utf-8?B?M29HQmU3K0p3MHZxQmhqZzhzbUVHbGNWSTdENE04eE02RlNpZVlaY0IyaldF?=
 =?utf-8?B?anBmYnFiaDB1TlBWUFIrbkVVQjlKR0xvdmhZeTlvVEFzdHJOTUo2djY1b3NK?=
 =?utf-8?B?VjlCclFrU1VXSGZya1J0NHZNVUo4UlhNYXhTMTN5ZzBCUTlicVFzem45Ynkx?=
 =?utf-8?B?Y25tZ29Ucy9JdDVEZWk0S2pFWFVXRmd2YllrYTh0LzFnNmtjSVlrUVcyQnVT?=
 =?utf-8?B?SUFnNkJPUVBpUzRURjZLcUVpSTFhSmN0WDhZY2h3MUt3dWU1WG0ySURTL2tQ?=
 =?utf-8?B?RER5OEZRckg2TVpNZVFFZURzR0ZxVUxYaWJwbURIdlVQUW5pODRlMXE1VEtL?=
 =?utf-8?B?c0VHUTRyRVQ1QndDUDZ2anJSdFBOY2NVQldRL0NHTUFaT3ByT3dqN29ZbXpn?=
 =?utf-8?B?MWIxS0t4UkVKT0pMS2ZKNjdKa2EzOEFJRU1rUGxERkt4c0lObVcwTmc4QjRs?=
 =?utf-8?B?K25ZZkJ4cFdROUpUaXFOaDVibWpac0dtcEwxQXhkWVlQNDVmamgzTHBFQ1E2?=
 =?utf-8?B?cUxwNHVrbGI2cEorbUxXakJucERKQnRIRXZqcFZLTmpxZHFacmJUZXhGL0k3?=
 =?utf-8?B?ZFlkd0o1UUZWNXJGY1U5aWVxUW42ZStpMDhqdHd5bEdmL3BoaDlYeUlzeHhR?=
 =?utf-8?B?U2o5TEJYR3YwaGJIRkcyaDRNRWNwVTFOYjVTdnAwMEZETGhQeGowTVk1V3ph?=
 =?utf-8?B?MHIzWFhwUDBmaGdOK016WDJGU3U4a0RRR21NVmlUU2FENytuTy9YaDV0dzZn?=
 =?utf-8?B?b0VucnA1T3l5dFFEVkdIU3lZd1gyQjllYk1RdUxGdU80ZHVvazBqWmREcWor?=
 =?utf-8?B?QTBDZTlhSVJQUHUxZHZjOC9LT3VzRVJJcnVnSUZlOG00UXEyMHhBZ2Nyc3dv?=
 =?utf-8?B?L2g1STdUSDVsTGpCOFh4M05GY0plUzljS1RiSGpYRnBTTDNwanBRZW1qRkpl?=
 =?utf-8?B?V1E3VkI3VjFJYXdzR05aaWlpcmFxcSt1YTJQMzhzaGtwNWtxUFVDOEVGZUtK?=
 =?utf-8?B?VDd2eDdWYU5iMloxaWxJY2Vxc1A3RzdXZ3pweGlVcnFrblpiZEN6a0ZqcDIx?=
 =?utf-8?B?aHBaWTkwV0xiNTA1L2hESUVaYmVEdWNaQzBIdWVlQk5KU2h1SWNFWlprRWJs?=
 =?utf-8?B?VHJocmVPeE1vbGkvS01YcXJldHlpeU9mWkRoZFFGMFZiSDI0Y1hvTTVJUTlt?=
 =?utf-8?B?TmtENlVZTlhwYlVMaEYrNkw4TXR5NkxFdm5OdlcrcklmUWVXVlRwMS9oNU5l?=
 =?utf-8?B?MGduWCtNb0tWSmJZUXFXcVlyaVI1c2JJSTFLaGI1b0Zzc2lia3M3L3Z2b3Vj?=
 =?utf-8?B?SjN4NFpmblNtRTdiYWx1OXR0U0ZwRFE4WlNDNlZkMEVOdFo2R0VYWDVwTG4v?=
 =?utf-8?B?bWUyYzBsZG1DTnluN2dyYjlaSU9waFlxWVNqNFh0K3E5cFNWZEZmRHFEdVVi?=
 =?utf-8?B?Sml0SWo4TWZtaHAzbWwxQ1hHcXVKUXl4L0NFMm1sRUpsWlVRZklkbkVnWktx?=
 =?utf-8?B?SHdXQ3l0Q1FYYXhvdWMwZ3BUUGdRNGN3R281QnMycW1zQzBQNWJ0enFSVHdR?=
 =?utf-8?B?dG9VQjBWUVJKa012cGZwNGlWazFrRS9Lb2tiUGcvNFRwcE9Kd1FsZTdxMEpH?=
 =?utf-8?B?bEgzMGh3VUR6QXdQUno4d0VVSkxzYjB0bjdJMzdGQ2FYeW9ZYjllUTNQV3lH?=
 =?utf-8?B?M29uRGFBdzNKOHRweDBoSDdadnlUMGEzWUJ6U2M5eTU0QmVxaWxGNklyMEky?=
 =?utf-8?B?K2V6a3V1aFUwTFBDZGp3ODhESEpuTTR1ZlBPV3AwTTlPY3NKNWF6c3J5QzZE?=
 =?utf-8?B?ZTBGbjNlM2lwUG12ZlBhNVhnSXVLVWpSVmhxMTFla0tiSkhyZGdSMEdtbDNz?=
 =?utf-8?B?Mm5hUlphRzN4MlNrVVdqRjE2d0lLYU8xZ3BzcU9LWGlKa1MvcGFSMDUvZUZ4?=
 =?utf-8?B?NHlVRVJ5NXV6QmE4aHp0R3hBYzFCQ2lsb1lCM1lPcGhzYUhZM1JsUT09?=
X-Exchange-RoutingPolicyChecked:
	nlBVxkg/Hl4KM73GsUSw8HXopXQ3avaVZuAw2TF4Bku1G+85y4BdKgMhktHHbT+Yau9pU+wrtGsGyJlezwXwjKMJsEgg5KUgck2yljodVGmJ+3ilKU2E7tBYyFaHGYBmuYjIH4xdKqbZ9Mc/uYM2+liK1nXIQH2NL3/4Fhf+vGAro5oPHFYoPb+dWvc4X8q4cODsMgKLpXpmmQWoNP0XKOoG9V36OcxyV+F96ojM4YH7TOyrald6dxvwSP8jwPsyl8rc6fiWHbSV/WA9CL4VB51w01zZdxs5GjLUxXiRnJ9qCP0hY5iwdOORLgS2B0ym02H1Xz+/wP/0A/Sk1ic7lg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	lteubhpiqrQaS8ZSkmu+xLYcbbLLn3mm6Xolf7vXbCwYqZaD/8Y6dUfK6c25fDboM5sR0UlYqXmBJIUN6ds83gQ7nwwYTPjLw+b78iE4uvqzYxtHLMJj1udSC/BFYpk8+x6GldJMzdi6opwd6B/I18QJGrOJ7Ly/GtJY7sDXotT+N8jWqyB1TqWc3Mz1JkurFdTo6PTJwpyB3K+s7E1WOoxr3CwQnEFwqBDl20NwFiS37efaxw6nSNeiGxtgqxVGku2or8kIxKyfNz4CtRCM6RmtlkjArdYtx/2zLnNEc7mrQrxFLcdtO+tJkCexxH1nP8fzxAtBzCL7ACzU4LESTvMOVMCnPlBmjXvqiBB0Kx1ZnFBqvv51XsCk++JrvtsD2c3F9PiKUV3iZBuVyKgdjBzf5lBm5oXA1QcpnUP5HR9/DiHqIfmSkfZ30iJrF9rYcQCkWI0xscWxTgFcGrwjZBfi0IQ38G5U99kkyFtmZhwO+2j6UcD4eikmsh7quk7i/0/833jsHcCTsHP8mCjhHJs2kFSwfI3fmlffUkZRmzaN3UhZZQY76IhMGXZfx7GD85ou2aHp+b7qjT79ROpJTpVwIrrYoYVpF20lAb5I0As=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffa8b814-9802-4423-6961-08deb1fb74de
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 20:57:48.9926
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tgk3iW8Id37iZ5M94d/4w0S6diO2nMh27DqjL3LxwIJ9e4bdDVQJ4foBT5Y5Q73JwAPuKH7uZCpJpxjQjdCwcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8489
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_05,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 adultscore=0 bulkscore=0 lowpriorityscore=0 mlxscore=0 phishscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=999 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2605130000 definitions=main-2605140207
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDIwNyBTYWx0ZWRfX/aYB/cl5Tw4y
 uBM0V2gV/Bmot8xEX+uj9mrpWkmYSrqGno9uKmHNmRczCLJHfOYvi96Mu1e/gF8EJvQtR2cJoss
 zgqdxCTgREJCP/lUMxE1JHBKvOYQULJlsd3L7SBr3N5gKRe9/1rEO9frP9Ybr2xZW5hBM9IVEgT
 WOoONdP91dKhdz/SHCVyDgfgq3ntaCXFbU3G5G5hNEvuKc4njdedO9WPYolxjX1jxEXI/lHBM70
 nVsUSyyQs+mE9yb0t2Ei+UfN9K3wffwOlJfH/HC9vDivgvhHqaFQt7S26P3ncIYlklElgg1Xx+U
 AX/M103keWId2/ChkJ6zT6YQPu6W0fN3kUEiElYtbvMHLSXh4mhsr5Yn+qv2iTPx54IpjEXSreF
 hxPLzkBVvoyUzL9hHGBZNpNqa6i8ClpANu5r0DSFTLrV68MSvQdaOOyC5LkgBBs4I4AaQThZKdM
 jG8NsBa+3gAmWydtaGA==
X-Authority-Analysis: v=2.4 cv=cfDiaHDM c=1 sm=1 tr=0 ts=6a063757 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=3I1J8UUJPc9JN9BFgKH3:22 a=yPCof4ZbAAAA:8
 a=VwQbUJbxAAAA:8 a=Od2ZbRvRFBpwgIZ3RboA:9 a=+jEqtf1s3R9VXZ0wqowq2kgwd+I=:19
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: r2FSMfn1d7M2xmmoaCJdfOt4fkxXQ22_
X-Proofpoint-GUID: r2FSMfn1d7M2xmmoaCJdfOt4fkxXQ22_
X-Rspamd-Queue-Id: C4DB6546DDC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21626-lists,linux-nfs=lfdr.de];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oracle.com:email,oracle.com:mid,oracle.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chuck.lever@oracle.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

On 5/14/26 4:56 PM, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> The sk_err check in tls_rx_rec_wait() consumes the error via
> sock_error(), which clears sk_err atomically. When the caller
> (tls_sw_recvmsg, tls_sw_splice_read, or tls_sw_read_sock) already
> has bytes copied to userspace, it returns those bytes and discards
> the error from this call. sk_err is now zero on the socket, so the
> next read syscall observes only RCV_SHUTDOWN and reports a clean
> EOF instead of the actual error (typically -ECONNRESET).
> 
> The race is reachable when tls_read_flush_backlog()'s periodic
> sk_flush_backlog() triggers tcp_reset() in the middle of a
> multi-record read.
> 
> Pass a has_copied flag to tls_rx_rec_wait(). When has_copied is
> false, consume sk_err via sock_error() as before. When has_copied
> is true, report the error from READ_ONCE() but leave sk_err set:
> the caller returns the byte count and discards the err from this
> call, and the next read syscall surfaces the preserved sk_err. This
> mirrors the tcp_recvmsg() preserve-and-surface pattern.
> 
> The decrypt-abort path is unaffected: tls_err_abort() raises
> sk_err to EBADMSG after tls_rx_rec_wait() returns, and nothing
> on the caller's return path consumes it, so the EBADMSG surfaces
> on the next read.
> 
> tls_sw_splice_read() passes has_copied=false: it processes
> one record per call, so no bytes have been copied within the
> function when tls_rx_rec_wait() runs. A reset that arrives
> between iterations of splice_direct_to_actor() (the sendfile()
> path) is still consumed by sock_error() in the later call, and the
> outer loop returns the prior iterations' byte count and drops the
> error. tcp_splice_read() exhibits the same pattern at the iteration
> boundary; addressing it belongs at the splice_direct_to_actor()
> layer and is out of scope here.
> 
> Fixes: c46b01839f7a ("tls: rx: periodically flush socket backlog")
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  net/tls/tls_sw.c | 20 ++++++++++++++------
>  1 file changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
> index 2590e855f6a5..c4cc4e357848 100644
> --- a/net/tls/tls_sw.c
> +++ b/net/tls/tls_sw.c
> @@ -1356,9 +1356,14 @@ void tls_sw_splice_eof(struct socket *sock)
>  	mutex_unlock(&tls_ctx->tx_lock);
>  }
>  
> +/* When has_copied is true the caller has already moved bytes to
> + * userspace. Report sk_err but leave it set so the next read
> + * surfaces it instead of a spurious EOF, otherwise sk_err is
> + * consumed via sock_error().
> + */
>  static int
>  tls_rx_rec_wait(struct sock *sk, struct sk_psock *psock, bool nonblock,
> -		bool released)
> +		bool released, bool has_copied)
>  {
>  	struct tls_context *tls_ctx = tls_get_ctx(sk);
>  	struct tls_sw_context_rx *ctx = tls_sw_ctx_rx(tls_ctx);
> @@ -1376,8 +1381,11 @@ tls_rx_rec_wait(struct sock *sk, struct sk_psock *psock, bool nonblock,
>  		if (!sk_psock_queue_empty(psock))
>  			return 0;
>  
> -		if (sk->sk_err)
> +		if (sk->sk_err) {
> +			if (has_copied)
> +				return -READ_ONCE(sk->sk_err);
>  			return sock_error(sk);
> +		}
>  
>  		if (ret < 0)
>  			return ret;
> @@ -1413,7 +1421,7 @@ tls_rx_rec_wait(struct sock *sk, struct sk_psock *psock, bool nonblock,
>  	}
>  
>  	if (unlikely(!tls_strp_msg_load(&ctx->strp, released)))
> -		return tls_rx_rec_wait(sk, psock, nonblock, false);
> +		return tls_rx_rec_wait(sk, psock, nonblock, false, has_copied);
>  
>  	return 1;
>  }
> @@ -2100,7 +2108,7 @@ int tls_sw_recvmsg(struct sock *sk,
>  		int to_decrypt, chunk;
>  
>  		err = tls_rx_rec_wait(sk, psock, flags & MSG_DONTWAIT,
> -				      released);
> +				      released, !!(decrypted + copied));
>  		if (err <= 0) {
>  			if (psock) {
>  				chunk = sk_msg_recvmsg(sk, psock, msg, len,
> @@ -2287,7 +2295,7 @@ ssize_t tls_sw_splice_read(struct socket *sock,  loff_t *ppos,
>  		struct tls_decrypt_arg darg;
>  
>  		err = tls_rx_rec_wait(sk, NULL, flags & SPLICE_F_NONBLOCK,
> -				      true);
> +				      true, false);
>  		if (err <= 0)
>  			goto splice_read_end;
>  
> @@ -2373,7 +2381,7 @@ int tls_sw_read_sock(struct sock *sk, read_descriptor_t *desc,
>  		} else {
>  			struct tls_decrypt_arg darg;
>  
> -			err = tls_rx_rec_wait(sk, NULL, true, released);
> +			err = tls_rx_rec_wait(sk, NULL, true, released, !!copied);
>  			if (err <= 0)
>  				goto read_sock_end;
>  

Ignore this email. It looks like something left over from a previous
posting.


-- 
Chuck Lever

