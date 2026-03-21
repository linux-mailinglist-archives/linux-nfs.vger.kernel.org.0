Return-Path: <linux-nfs+bounces-20310-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sEODEJrJvmm4cAMAu9opvQ
	(envelope-from <linux-nfs+bounces-20310-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 21 Mar 2026 17:38:50 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D27D52E65BB
	for <lists+linux-nfs@lfdr.de>; Sat, 21 Mar 2026 17:38:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 76BA23019125
	for <lists+linux-nfs@lfdr.de>; Sat, 21 Mar 2026 16:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8506A3112B2;
	Sat, 21 Mar 2026 16:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kdHxGaca";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="v36QtiVe"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E109F2DAFB0;
	Sat, 21 Mar 2026 16:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774111116; cv=fail; b=eYJb9KXLPrCp8eIxR4NgJUMkNFJ8LruZ4yJY4yBOUu6zys4y6WfCY6Tx6XQkLsuyUeU+S77AE9uRVKAhge46M1HOman7h3Rh5kjnSjbvOBUofxFY9cOCvMZlYFaaQd9l4fxCzx7D5mQNp24OlyY0JFZQxnPSBC4yDPFEs0Xmgtg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774111116; c=relaxed/simple;
	bh=sfmVxNd+Yas7opc+dnUKCtn0LFYjKYBKID9sIf1ZnoE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Lirx4ZMuvHvynkJt45B0frgzc/kANotsaYcI1YDhLRX2X3vVczhDeeR3MblhC3kq59ZlJTmunJW8nz0rr+Mq+ACYFoAgfLY39TLKewlcf9c0kUKCeGG63EPpkSvg5pI3xSvqD/VcuUYK3P40NVcuJNkVWh+4VqO/28JY6GhE+Ic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kdHxGaca; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=v36QtiVe; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62LGbCak1543987;
	Sat, 21 Mar 2026 16:38:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=8aJ1DGv1C/GvuMVGvqsGj+ZbsZPWfYUIEQp69RcHgDw=; b=
	kdHxGacalgp/slC0/i0HyrMwo8XLih4V9tgT9iN1Y1a32+2br7E/KYCoeGLT0ZUw
	O20vNvvOjTSsSRJfgiUFsX2f51znn/35Pes0r8YZ52WeJ5bon8yc+1wJegRXg3l5
	I2NRqrqrrEWxpVe9PHX3DqGhgdxiXZHkxxRPqBBJcAMY0DS50SmpASLTLWG68Lha
	vJjI02oEjuTn6ghXBikE3CRrdk75zBh8qX+l9nyQRVzk1EhohRMWbAW7NkELm8/C
	1O3Ulka/QhKbRvmvsj+toCn5NdoJz5zg6YngG1jRTjLcBkSY0QFlvXH/2ava4mzK
	kL3osJBLvUNKCh23c/Ep+Q==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4d1kj28964-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 21 Mar 2026 16:38:23 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62LFCX9L012371;
	Sat, 21 Mar 2026 16:38:22 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010049.outbound.protection.outlook.com [52.101.56.49])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4d1hscyhcr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 21 Mar 2026 16:38:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p/TTMK17vFFTwZqrjdM7PdWc4qYv/sTuP/mGnN8qyEtRt6Z6m4YSa4GKtmRtxTGlwetVVpodtMnIqB/fDtPOK3ctzZQNxBovo+h9l6qzPcZergGAo/1AwOu3eJ2kLhyQEYgEr7Hs6t0HOZVsKjzcI0sI1mq3iKu6lSx+Kk3WqGw/e8fck1vHmc0aIxVx63SuyhFaJVMeWVP6PtR6Q1upGnMN8bNS2gvrCkJmpLUrMNDcEqm8+q2ffRajRcP7idGUHGSiEYE4VLxuXg35QnStNidWNyFnYU6jKE09UcRYY2sCs8e7Ye/tK6Tktm+n0EFZW4WyVuJClmusvMuNPDC3IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8aJ1DGv1C/GvuMVGvqsGj+ZbsZPWfYUIEQp69RcHgDw=;
 b=dlWM2S+/S3vZ/1UF712OkZP3dI/yes0DhFcFsHR6WAOkfA3K+DxzH1eAXo9UEFTzZUTHt4iA5+XIChn4qV5wn8ilOq81IwyMtkvEXFN04jwWsPAw7FMuxe8u5zoaKFtQu3s7BIuFUnRhgR8aQ5CYL3NmICBXG/az+noKpJen+5yKwQew4AnIn3+UauqCjEMBBBXrZfNjulPsyAqoH9zY2QmEVB3SDpgbVtaZ1Y8/xoeGfqPM7Vkegu7KK698f5B45HWk9ngPKOHf84hzkxvACTxGqHyYH7CLvhtW4t2xiHT9Na7emSPCL1o7hMOaRzdbmMnjnCbaOKef+e0RprgPfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8aJ1DGv1C/GvuMVGvqsGj+ZbsZPWfYUIEQp69RcHgDw=;
 b=v36QtiVe7pyoC7pSytro8IwHko2hfulbhSeQ2AbXsV18eQvlUv1bCUYhBJAt9K1t+W2JqSkuwlQc08oTI54VmJhzA/bo8wWWz+DlDDToMn3aXFB3gZebHma2scJVXHxMpBF/xfEHA3MIgvmFcEby0/Rj4CPtiBLyI58ZTbftW/k=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH7PR10MB7782.namprd10.prod.outlook.com (2603:10b6:510:2fd::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.25; Sat, 21 Mar
 2026 16:37:55 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::4083:91ab:47a4:f244]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::4083:91ab:47a4:f244%4]) with mapi id 15.20.9723.022; Sat, 21 Mar 2026
 16:37:55 +0000
Message-ID: <e3702d11-2157-46bb-b6aa-0ab60b51eecf@oracle.com>
Date: Sat, 21 Mar 2026 12:37:53 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/5] sunrpc: Fix dprintk type mismatch using
 do-while(0)
To: Sean Chang <seanwascoding@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
        David Laight <david.laight.linux@gmail.com>,
        Anna Schumaker
 <anna@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: netdev@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260321141510.68214-1-seanwascoding@gmail.com>
 <20260321141510.68214-2-seanwascoding@gmail.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20260321141510.68214-2-seanwascoding@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5P223CA0012.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:610:1f3::26) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH7PR10MB7782:EE_
X-MS-Office365-Filtering-Correlation-Id: 810944e6-89c0-4dcc-d4eb-08de87683431
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|7053199007|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	RJGXL5fZ4p0c2j0882vV+A/9t960GU9Wwq6gCfUqQUoYZXmUIQWzIAIwBkWfFAPvZGhizVTwpecK19V7RsHPnAOsZ4HfplaH5AX6jiri1u5BMhiTfne3dBDd0S/bWXpVlYYWkPmfo5D7clTfTHd3/Td/qTXl+rSTzg7TBYZe+iDk8RkZYW0vAZEusasvjUy3eD8zX8HFNV7aFVq+y9WtKUhFdeNmQnwfqKQrLv6DPNadri4gOiCcuvRv6ynGwbPxwlPTNIwBj0IXvd5olJ7d3dFnYYy3N5mCfNsSmPXEPTnEMuCTlbK3cAJBVh7UPzVaQZmK6ZiU5zmH5OaMiFjyAjpwfVXaRFKnxw5e+qNQq5ZspTVGGsisB877kf/JoRfGgACVHqg/SMBHGpJZT0YWTES6zhtMBWaESBOpjroRaIo6ExMkw+TQTRjbN0IXKMl2sEcKiYH5MXSaylVsY8X9CvSmw7VGLyHBcKiMZNFafdJywkrIb1sT/gmib9acdEheLx/8wpkI0r9373k36bsgXcGOJ/+Ja6GzpR9ZoHjR5ydznU45b+HCFT67XNqnMKMqvUVBfUsxZrHsQs7icXYNCjcko+YFDr1lpJnB1yT63BS/iFojL3Zedtg9/ZRWDiTnLfPuRhFDZUJHeoeBOJHwougd+BLtSdBLyAVwr6ZI3R/d8m8b4gcRD7Xwz+fv5maALE7THMDFF5sOBbyH+cUnGcSGiw7PqrjDKwnBZuhdkGM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?REorUyt6RzY4WittNjZwTTVpQ2dPY2xxVEVUemRkbTI5bnhaZGlURU5vQUlm?=
 =?utf-8?B?d212V1A1aXNneUV0aXpmT2Q1U0U3N2hFK3ZvU1hWaXlHYTBPMjgvVGQ4azBM?=
 =?utf-8?B?d0sremdLTnFhOGZObnJEY3Q4SWVHcnQ2cjJ5ZDVNOXFLTEd4eUJTNGtRQ2Rj?=
 =?utf-8?B?SXE2bmdCSE1WMVk0bnp2Ym4xVFFKOERVQko5b2lWSGJvdVBZbEI0bEpqcTBX?=
 =?utf-8?B?eFlLemVaT0RHZncyREZCK09WWXBYNllQOXdMakRBamg0YXY5dFBNNENUTVln?=
 =?utf-8?B?cUVCYmZzZ2V6MVZEWDd3WlJCRHNER2EzbStHU041TG5tVFk4UUlZS2JGQWN4?=
 =?utf-8?B?VXczL1premwvR2czTE9Ma05GMlNqejVxT1BZRC9HVkJPZzRsdmt5aXBSRWhI?=
 =?utf-8?B?VEhGdWVBcnAwRkJmNk9SYjNyMk5iVS9QcFBDemdwQ0hUUHNucXNlblc2bmUz?=
 =?utf-8?B?TTNjZHhhVjNkS3U3Z1pFMHhocEdBdUorTjdMTTlINzhtZUtLSFMxMnFKWUhp?=
 =?utf-8?B?bWF6RGdpR3VaMGc4ZGVBYTJYTGJ5bHgxQkxYUFVHbmdzNVJMenZrbWMrejJF?=
 =?utf-8?B?SGs4b1F4eXhGS0JSSm9XNjY3NnlKdk9Nb2JLRTMzS2F1YUF5K2FINW5ST3My?=
 =?utf-8?B?Nmd5TEpFUjRQZ1NreC9yb1hSOVJ4OTRBQVU4YjZoNmM3SHh3eXFOUVlrUGM4?=
 =?utf-8?B?bkNlOXZOa29PS2szRFhHd3FFalVHeFc4TkZhV251N3RXQ0xNaUY4Tzcxa1V2?=
 =?utf-8?B?VnNXdFBOU1IxZS9RdWZuN2s2ZlBjR1pmbDYyYWR2aUZyTWlreXZNV2pmdWhD?=
 =?utf-8?B?eUJDdTVzVUlrS1E3N0NLeGsreTZiaTlVbC9pcHdoQXNuVFFIVkppWFpqMVdm?=
 =?utf-8?B?WDA1LzN1SXd3dWdRcHBIa1hiWVd0cUU3eDBSTXFQV3BkK2FBMVBNb015NGJB?=
 =?utf-8?B?dmFMenl2RFVrVEJmSEJEN1luWmd4YjZkQWNHc3BhRFpETFFwelk0L0VsbVc1?=
 =?utf-8?B?NzBvWUl4M1YrWWhkQUtnZ3lsU0hmbGVCdUw2dW1ON0FDUTh2WlRCblZEcVZt?=
 =?utf-8?B?UWRjMGRpS0JGNHpGZXdFQjlHMkdtalF3dXc5bWVRZGsyTDFCQmRPMkc0NTRC?=
 =?utf-8?B?dnJ2OWZ4T2VzSWdyYzE3allTWG5ndDI4REZPK3BMNkpENFpRejZhTWNWWkRW?=
 =?utf-8?B?VFdKTzdSU0g0T0NBTWx3VlBKblVsMjY5cWJQUkJDM0dqK29oalhaSGVWSWZv?=
 =?utf-8?B?V2NTQkYzaHBOY3N6NGk3dGh3ZnEydlN4dFBpcFRyd0hwTmhBQ29acExOY3Iv?=
 =?utf-8?B?a1h0S0I5cGhJNXc1dzRpNFF0eTFoV1pBUDVITXU1ZVk3emh2cUI2SFlTVzhu?=
 =?utf-8?B?NjYvT1VTYlF4V0ZTRWxyTE5xWTAyYWluMDh0V2JiL05oVWtmQnZMcVptdlIr?=
 =?utf-8?B?QVZ6WDM5Uk9Cek04SWJSd1dQNE1mZDdxSDA1L0ZlRHFFRktyQUFTMmlmSGNE?=
 =?utf-8?B?eFVjQXJTTnhhQzZ4ZFd6UmFXUUhQd2ZoQ2hlSWZGL3dldlNhckVPTitUUW5w?=
 =?utf-8?B?ZWRiMCtLZnZTRHkycm16cmxqYjFVd09aTjdJNHllcEkvVWsrQmkwOGpjQWow?=
 =?utf-8?B?N1ZDVEhITzRZUm13TXBHaTg4RlV4M1pJSCtsV1ozMHB1TVNITzFwL01SSFBt?=
 =?utf-8?B?WVh3U0hwR2hBcm8xTFRocnIwR0MvSENwZXZKelVmVTRJVkYxa1BUak5JdFNF?=
 =?utf-8?B?MU0zSVNyeTcyWjNDZDN3Z2N5UmZ4dThzWThlOVpuWXdDQlBBMklrQ0UxYmFa?=
 =?utf-8?B?eXhJVlJiV3BRTmpJcUhxeWNkMXVtRmMyQi8wbWY0anQwNVFmcHBJYmdlRzZ4?=
 =?utf-8?B?NXB6T0RyZmRHM2wxYkN0WXdwTGkyVVdOSmY1M0ZoN1o2VTVXVC9IeVJJcWhH?=
 =?utf-8?B?TWlZbDdGR0F4aEpSZnZXU1huWlZPMzFwZnJqODYxbDkyNlJuOXZUbzJZV1Y2?=
 =?utf-8?B?dlV1NFRyRHlXOUtoR2FJRVlWdWJRWUVMTWF1SlNwSlJ1akh2Tkt0NEhvVXFs?=
 =?utf-8?B?dk5ZQ0VyUW0vcnZ3aUkwVXZiS2l0NVRXTW9VaCtxWUpqanV1TmxheXRZbklz?=
 =?utf-8?B?VE5BeCsyeURsSWJyYjFIWm9FNWFWN0o4V2d4R3JLMlJlNTA2ODZ4TWE2d0xG?=
 =?utf-8?B?ZEFWRlF3ZkJKTmk3dXk1K0kxd0lUYkdxOUZ3YW9LdFZQN05UQTYwQ1duS1JH?=
 =?utf-8?B?Y3J1L1VGOFhmMUxKVm44NzQva2o3anplRm0xdzFDRWx3VHpFdUdRRXNYdXJP?=
 =?utf-8?B?RjNIN2UxNE9XdUtnMnFlczYrSVZ2ZVZzSnM0TzhGZmpkY2JqVWM2dz09?=
X-Exchange-RoutingPolicyChecked:
	ds/NiGDKiitVI2C0hMFyTW+nG02Lz35RIPARZ1trOsUMVyke3KmwIbGgr7+wS8h28mVJT2PvGR3wZmcAY/O216KQkOBE9LO2xEofz5hTQeDnmibeg5jvtqoAaFzKvDy2lA28CMlwIHJeAEt1taKlIHXtiwlhNgYsxDK+p6DZbhkRpzY00CjVAKhvs2Pbi5Mca66JIsho7mykUbiPTaA77Pp3HZaTWQ/qgLzxtXIP7iof33tO45dNRFqYhJKFk1EffhebNhmq8KS9jIWplTg3Nkn/BHYXQ3QJF/bN0dpbYh2lG7GZ4d4RJR8ZKf3clSt8/dxdY+XWYqedM2lS3fQxyQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	tdQ+OXn02olqdp8WJfxNr/LCY+cSsFq/RpI2QIql8N+syDNt8aXlmcmKmDiAfXKAWCz9C3i1TNKn8RI5rs9eVcBlQWeaXOeJknBdGDVhjre5/nRNWIcWqhNJ9IECbrdd1h32KijPoVjOJu9R3DxE8p0yKwT7fDVgG0oTmWNGT29Vs1++U6xIXDI7O8QV6b6I/eU/meKidDiiFIuNhWwMatUt1kdoOvpqz8CnIRO2HeyaGWCiqCtjCyBqdmk4IoW9Q8ghD7yMTByQYPztbABcdm5fbs5GmWjMqOXWy49UGC3HUqE3jGtlvZgtPkkNTxb3URdIRr/OsgA5qt8gxSImhVf4VAjMQTczf4MQnjVsiUlvLyNC1jOXdUNkjSCpe4RNpXIHMP4v1P5NUoJKiU+kioPnK5US6k2qmBUtqY7qBoXeWsY0/9GV3E2zAAtlLJ0zBQs7uu4yCTJ9N+9hObT1n2PR2J+FUEIgIwGWsVsE28U+b+XQ/KNav2q83QdnpiLJej8r1X8P52avP/i2afrEezN1Ow+2IRwq6W+6ZydhhmUr2dWdsRMtz1YFqwmMvdlbGHlMU3qywSwuNupHd0T7a2XLw0dcCUfPNvT+c7K5j7A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 810944e6-89c0-4dcc-d4eb-08de87683431
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2026 16:37:55.6408
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MCTiDq+0bY+d/nDdSH+i3cCO/Hij+Rn2WhbATT3UZkjDgMlp5nskqN2klxdW2HMXJcu1LTyc+H6hAxMQcWgKug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7782
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-21_05,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2603050001
 definitions=main-2603210141
X-Proofpoint-ORIG-GUID: _Zaz8fSlwBPf8ZSRQ5r60E0bCsRi48ve
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIxMDE0MCBTYWx0ZWRfX0A0ShjGQ3dQJ
 mSeIMxTvFcIWaTdiOPtUYYOIEPldcH8KrxAV3202D9exG7JPFfMvVxrHiQ2cSuNoufv9BBhm6Xt
 a8lXZFvWt7Wgq6mD5ncQGMKHOlVQy6kP52vqEtXSTwAPgVZxPDh2i2DQDkbk65zA8gs/2F1BnJ1
 Tt+lV/ahUaeywwhafCIFXEcdnSEmm0FZW04vSD8YOzf9SokXh3fveYzL27N4BqT4T2jkg6n4fb9
 9txZgCKCfz90mjGv58cIYHOR9p31f3tN1bEBUO9VTynn8L8DIE3SqgvK0PNjRFAeiMNAEMIMLZT
 NwMTjqUAu2H+gUk0HWUJO8Bl2pudTbofVV9v1uqjAtsPZ+W/Hz1lskMAD3eUcrnxOXH5r6MQzrL
 Pw9tnFZrk2x+7W8RjuWGjS+wTQ1gU5tU4OWm412KyAPu2OQFxCXyapaeJoSPr1RarJ/8loNLjjz
 on0LLMpYElGDKoI5ApUBAe+F1GaT45+NQ5moUJOg=
X-Proofpoint-GUID: _Zaz8fSlwBPf8ZSRQ5r60E0bCsRi48ve
X-Authority-Analysis: v=2.4 cv=KtJAGGWN c=1 sm=1 tr=0 ts=69bec97f b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=RD47p0oAkeU5bO7t-o6f:22 a=pGLkceISAAAA:8
 a=6JyDLAPPXVOWPAQjdmUA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12272
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20310-lists,linux-nfs=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oracle.onmicrosoft.com:dkim,oracle.com:dkim,oracle.com:mid];
	FREEMAIL_TO(0.00)[gmail.com,lunn.ch,kernel.org,intel.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chuck.lever@oracle.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: D27D52E65BB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/21/26 10:15 AM, Sean Chang wrote:
> Following David Laight's suggestion, simplify the macro definitions by removing
> the unnecessary 'fmt' argument and using no_printk(VA_ARGS) directly.

Generally we prefer a commit message to open with an explanation of why
the change is needed. Your first paragraph instead opens with what was
done ("Following David Laight's suggestion, simplify ...") rather than
why the change is necessary. The Sparse warning motivation is buried in
the second paragraph. Consider leading with a problem statement in this
and subsequent patches in this series.


> To resolve a Sparse warning (void vs int mismatch) when dfprintk is used in
> conditional statements, wrap the non-debug definition in a do-while(0) block.
> This ensures the macro always evaluates to a void expression.

The non-debug definitions in the diff below are:

> -# define dfprintk(fac, fmt, ...)        no_printk(fmt, ##__VA_ARGS__)
> -# define dfprintk_rcu(fac, fmt, ...)    no_printk(fmt, ##__VA_ARGS__)
> +# define dfprintk(fac, ...)             no_printk(__VA_ARGS__)
> +# define dfprintk_rcu(fac, ...) no_printk(__VA_ARGS__)

These are not wrapped in do { ... } while (0), and no_printk()
evaluates to int (0), not void. The do-while(0) wrapping that
was discussed on the list and fixes the Sparse warning appears
to be in a later patch in this series (the nfs_errorf
refactoring), not in this one.

Should the commit message second paragraph be removed or revised
to reflect what this patch actually does?


> Suggested-by: David Laight <david.laight.linux@gmail.com>
> Signed-off-by: Sean Chang <seanwascoding@gmail.com>
> ---
>  include/linux/sunrpc/debug.h | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/sunrpc/debug.h b/include/linux/sunrpc/debug.h
> index ab61bed2f7af..f6f2a106eeaf 100644
> --- a/include/linux/sunrpc/debug.h
> +++ b/include/linux/sunrpc/debug.h
> @@ -38,8 +38,6 @@ extern unsigned int		nlm_debug;
>  do {									\
>  	ifdebug(fac)							\
>  		__sunrpc_printk(fmt, ##__VA_ARGS__);			\
> -	else								\
> -		no_printk(fmt, ##__VA_ARGS__);				\
>  } while (0)
>  
>  # define dfprintk_rcu(fac, fmt, ...)					\
> @@ -48,15 +46,13 @@ do {									\
>  		rcu_read_lock();					\
>  		__sunrpc_printk(fmt, ##__VA_ARGS__);			\
>  		rcu_read_unlock();					\
> -	} else {							\
> -		no_printk(fmt, ##__VA_ARGS__);				\
>  	}								\
>  } while (0)
>  
>  #else
>  # define ifdebug(fac)		if (0)
> -# define dfprintk(fac, fmt, ...)	no_printk(fmt, ##__VA_ARGS__)
> -# define dfprintk_rcu(fac, fmt, ...)	no_printk(fmt, ##__VA_ARGS__)
> +# define dfprintk(fac, ...)		no_printk(__VA_ARGS__)
> +# define dfprintk_rcu(fac, ...)	no_printk(__VA_ARGS__)
>  #endif
>  
>  /*


-- 
Chuck Lever

