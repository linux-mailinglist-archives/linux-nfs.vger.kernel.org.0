Return-Path: <linux-nfs+bounces-16355-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 536DDC5944F
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Nov 2025 18:52:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F0C83AA75C
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Nov 2025 17:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DF7A271456;
	Thu, 13 Nov 2025 17:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bjyVjKxa";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="PrALfTJ4"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D219A2877FA;
	Thu, 13 Nov 2025 17:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763055754; cv=fail; b=U+4bMZmLhA2t0BrW4+QxTu9LcTu16LEDqNha0vjg9FZ2M4w6jo89VHAzWSpU1xfdEmlv/nXbBTMgX8J4y6ACV0PO9X1cRWcUlQ8yfsTRVK7gZzrTREfZX2wBHXRiKgFJh/FZv/GmprKkrS78+5WYfH4YuRg/TdltFx4GbuGWlAA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763055754; c=relaxed/simple;
	bh=znoyIqhhsS/vAD8ZWq/Ypd85R2aVFqfGKBQ52MU+Eok=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JKeh09pY2pLTaVM2ujMupOT68wznQdOCnr8nnV5EwcU33x8giAiT7RkuZQDsR0mtxOdJVk73r8iYHSmOUTjO5nr88n9nI3NoZgZ08JaITgCi4SntrAm6lTRLNNCyJ7xSzAQiTW2o5ChMY7zeqO/jwsaZo2+Gdbp13s7I7YzAR4c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bjyVjKxa; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=PrALfTJ4; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ADE9vSC014744;
	Thu, 13 Nov 2025 17:42:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=2EajbWMgk4LIzo/CCWNForqhJBW9H5jH1KcPwRG9gvI=; b=
	bjyVjKxaXhqPa4UP74BuDjlLcoqtuNYaXuUHpmwcRjHZUa0QCTdIm7A15xZAXcmB
	2t8fOffeMQEZelPIlkwHUK5BKjfcZcDct5XJNY+KyYHvpORY94F8WKwgngUjCqsi
	WCgEyu48y4SaAKyGniDUIMoTAoKISEqUccseuqGp87deHg30UNtOY31BG8Uin7K8
	Mrsi8eRNEQyBBYvW477Zf0ktrM1vn2tWdCjkAJfiWAzVa4vvmT/4q/hGcIwgCPR3
	j9N9Tf0JEgKVQJRjKBz2UxVyaTV3/COrSA4cjeIgqX5THn+C/FMdwZEBmbxVS2Ab
	bdrQn2dt25lOju/sQkyNjQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4acxwq2brp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 17:42:25 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5ADHQx2a027689;
	Thu, 13 Nov 2025 17:42:24 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010027.outbound.protection.outlook.com [52.101.46.27])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vaggwyx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 17:42:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QT0pFGmaFHZD9rhVvaPEUzHoP2i1VXTmPuDQp+TqCky1llFNTKemFhLBvh9OUDfDQdxduVa4eRX+PBiI1mEdCSec3jOSdcyVWjNveXuK2XgwnwIz7PfKwhS9L+8TtV++Qp7hrjcDjSWa6i4qzNr9ngNSMqw4u7ptAZocWMYN+N0JePyCLK5peJ7poWXmbpMuoUA7vlP+SIXDgxfVp7/QSjiF4yh+XNktrZXhdkWXdzXaO1cCbDa1R2qJiPN7JmoTE3+qd5K8BfpSlzRKMI2E6HYNvQELfOdhH/PpKaJFFI4MdO1TpDBYWF4qHa0KNhE5ZFmzVT6nGo26S6CAeDRK/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2EajbWMgk4LIzo/CCWNForqhJBW9H5jH1KcPwRG9gvI=;
 b=p+nSVP88ScYl9vbNVam9YG81LGy9c1rcK09uFuqEEzveclbWD0fbsp4QOKDQP4b8Pxr5USS98rVDnS0lrGsgJ/mbW7/8SB8mDlBUyqLlpdAUa2f4ET06a+BsjywFCZK3Q1yCXv5uxxN2fFbBy9+uNQekOL396Zc/myyqjEWXrWkKdd+bKBsYXu/yKsKd4p5lv/W/sRuz/pnsSnZ/JxpGuDarcfB7tLdiqaBDxawps0q1lcRBEZXcv/hAoU3VMqftjRdxAQAPXAa2fahi3FWF9Lqi5oxrxCafTr452qfjH9WWP5mFAxMLPJPgvFPOpAz2e6dhEjsHUC4GfLxzEqovqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2EajbWMgk4LIzo/CCWNForqhJBW9H5jH1KcPwRG9gvI=;
 b=PrALfTJ4tCJ9RV+KCjOOC0xkFJfn3C7GdcaPNsVSAzCiQ1coF/u41GuZQkYGG558PBHAYUEoqr/qbbU9H+daf/GoFKbooloY25jJOij5zQKvDjaQX1u0L9NoDS6JJ4XfKB9nPqJ1fIshv+827PObjaOv1xOtT5GGe9Q+nlZHr+A=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by LV3PR10MB7939.namprd10.prod.outlook.com (2603:10b6:408:219::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Thu, 13 Nov
 2025 17:42:21 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.9298.010; Thu, 13 Nov 2025
 17:42:21 +0000
Message-ID: <ee87da48-24d8-4e18-a686-435dfbacc681@oracle.com>
Date: Thu, 13 Nov 2025 12:42:20 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Make RPCRDMA_MAX_RECV_BATCH configurable.
To: Gaurav Gangalwar <gaurav.gangalwar@gmail.com>
Cc: linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
References: <20251113164648.20774-1-gaurav.gangalwar@gmail.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20251113164648.20774-1-gaurav.gangalwar@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR03CA0018.namprd03.prod.outlook.com
 (2603:10b6:610:59::28) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|LV3PR10MB7939:EE_
X-MS-Office365-Filtering-Correlation-Id: 12e26fc7-b31d-44eb-d103-08de22dbffbd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RG8xcC83eU1iN0lMaEdnR1grUXlkZ3MxbFVoLzQvbzdDb1BQSDlORXMzOGFW?=
 =?utf-8?B?eThnTTJBZjc0akx0Nis2bEUxSUtRbWhpaHhzSitFTXozelN3Q3I5SmVkSVNs?=
 =?utf-8?B?ZlF4SFZaeEpteG1tVjVZK28xUGdISi9YaFNaQWY3eXoyNHJhNlNuWnFHQ2Rq?=
 =?utf-8?B?WHk5U2pmb1pkVnhGQTNXWXUzanFKVTlOSVZaZGY0eXhMQ21URFRGSUJ1VC95?=
 =?utf-8?B?T29NNE5tdE0xc3JqTWpmMG82Y2ZENU54bEVaME4rMlNVNklOY29Na05qRW15?=
 =?utf-8?B?WmRpcDJhTlhMcW1wdm9Ba05SN2Faa1BqQkhyc3R6akFPZW9LRTV6NTdYc3ps?=
 =?utf-8?B?eFVPTlVEbm8zOTc4SHIyVTlyVkp3YkJNbEtqMkJTT1dhMVgzZEZXdlpIU0o1?=
 =?utf-8?B?dUdMNlc2OUxFc0cvVlcxc0ZmeDJ2N01TRzZqc1RLQUtKTDZHcFQ3RVE0NDVZ?=
 =?utf-8?B?alZWUkN4SHE4MmQxY0FzbmtuMWkvaHJuM0VNdGpqS1BkMU5NMlkrQUJKRm1O?=
 =?utf-8?B?WEpiMU9mVGFLSFFFWVludGJjc3A5bXFsTGRSL1QzNEtwcjhKZDZPMG1PUkpN?=
 =?utf-8?B?cjBTVXFERUpZUkNyMG5GQ0R6MVZybWxGdG1CYzhjOXI0VE0yMTJLbHJQaXBP?=
 =?utf-8?B?QUgyQlkvd05WVE9QVmVxZFhHVGJkNEZqSnpWWXFWMjNLbm44U2o0QXV4SHUw?=
 =?utf-8?B?THRSWEJaVktya281ZHZRV0x1RHpzQWFmNnB6Z21SYWljU2lWUWwrTVZsNHpN?=
 =?utf-8?B?cEtmSlBPNW9weWZKdGRjcnhQRndTZWZpdURuN0l1NVVmdytlQlVwZVhodyto?=
 =?utf-8?B?ZXFNdlZEbmJzRXNacjZEckE2ZE1acFFJNVVrdjNjNjZMNWNpYWNnbjhMWVoz?=
 =?utf-8?B?YXh2ZzQ2MjJxdmlkY3ZzL1F4VzExTm9QVlVVVENNYzR3WlBGSFZ6cHdFZHY0?=
 =?utf-8?B?VXpjeWQ1cnYydE1FaDYrbDlnc3ZSd0daQkllMU5sa1ZJbmsxRXh5TVY1Z0Ir?=
 =?utf-8?B?YlMrWHorL1NNQ2VGZ2xQM2VnTXNCWktyZXp2VHFYeTM3TVR0RWNRWm1sL0ty?=
 =?utf-8?B?UHZhYnh1R2pjR1k1U21rZndNblZieGNDVEdoT3hrQzlXaUVleFZ2dXFEVzlM?=
 =?utf-8?B?dFQxakRLTUk5emZ3N2dINHVMOFZ4cVFsUTJONzBSN0tvRWFtZ0lKcmFRV3Nj?=
 =?utf-8?B?VWF6dE9JVmkrb1Y0bzMxODlubVlzOU8xbXQwbVlRaFZsQ1Y2Q2ZSODJvM0dz?=
 =?utf-8?B?RlJ2ZURrRXRmOTdDRXh5a0U5b1d4M3BVZXh6ejF2Rlo2V3E2U1M2QWJGUHRT?=
 =?utf-8?B?Zno5OG1sZy9tNFNBa3F2OUVtMStER3gxYXFMZmUybnh6TldxY3BGUUtQcCtr?=
 =?utf-8?B?U0tEY3RzZ2FzeDVxT1ZKbWNMVnkwVFJvNHUrT3dBWDUyUlhsQ0c2SVdlSzBH?=
 =?utf-8?B?Mm94TGIrQm1IZ3ZGa04vemtYZkovYWtGT0d4Z0wwdldkT25CU1ExenR4bXJF?=
 =?utf-8?B?LzNXTlUzNnBoVEhMeWJJaXdPSXBMVzBndklTOTFnSjF1YkFZelFsYWV2NEtj?=
 =?utf-8?B?NEVCdThsWjYvUy9kVkdXZG8zQTBuM2tiWks5TWVjcThUWHd3UUtXdmpmTEdF?=
 =?utf-8?B?NVZScmZZWk9Od1JqMG1RaGpOSldzbDRWTXUwak0xNWNJMWxTRFFnYlljN2I1?=
 =?utf-8?B?T2JYVlhrZVJHU1hHRitTZjltVzNwQWJzcjNsZlJNQzdFSDdsSHJpbzNZWmt2?=
 =?utf-8?B?NWdkOWtkVnoyeDRCbWN1NmZQK01yQ2kzWnJURUFUV0pGRVp0WWsvZjFnUC8x?=
 =?utf-8?B?Qm9manE0V2FRSXVLc01MeDRMS0dvWi9sU1NkZjBCb0IwMkZSblJQOFYxWHFG?=
 =?utf-8?B?TG5nOE5oRWFZRjN6STZSdzRMbnBaNldTWnRRWjhMOVZMUHllS0JHQlN2UU9H?=
 =?utf-8?Q?doC+jlP8kNXJ/gSc6Nq1gNKFEgolZLl/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N0tYeWxlWEJaYlJ0ZTcxb0tOMXh5UVJLWkNMUGIxNExvZkZvV2ZNUnFUUUVL?=
 =?utf-8?B?M3FYR0pMV056UUh1QkdDNnAxMXJ6MnNWam83YklqVS9zS3BXVWFnRjh5NHpa?=
 =?utf-8?B?RitReCtnMFlHQkNaOTAydCtyclZOaGtkYjM5UDJvODlKMkZkQUc3Ymk5b1pI?=
 =?utf-8?B?akhPTGszRUFMN2tqNy85eUdOK1NrSysrc3FCNTFiS3E3K3EvWWMvUjVPclFQ?=
 =?utf-8?B?K2JEWVFxSk1mZUVHSGxkRFNSYnlxVGNnMmhTblJwZ3BaaHF0cnUxcDNyUXdK?=
 =?utf-8?B?SXo3VFZ6NSs2OHdFc0dHQlJNZExibEN0dG9kTEtMa2JqODJ2WjVXSkg3RHZa?=
 =?utf-8?B?WXk0OU8rRmllUEtVYm00a0JyOTJyc1NaUVhUcURvRkR5VjBWa0dsS2RSYTZy?=
 =?utf-8?B?NU5qa2I5OE5POE42em5tTmt1eWhpTzBhWjJFMzhPTXVQUW4wMjBjek1LS0xR?=
 =?utf-8?B?b2E4QXp5Yk1DVlZBK1JKNk1WVmsrL3lia2ZuZzgrR0FLbytFU1RQWlhQR0Jo?=
 =?utf-8?B?VDh1dXIwc0s0NmkzZVBZQnkrL2hwZk9Pc2Y2Rm5ITFpSR0l3dkZuaktNTUJH?=
 =?utf-8?B?cnJiSjg2MUhjbHdpWXBxMDc2M3NLbUltZDRKTHBCQVRnSGczQkQ1d0NuQkNl?=
 =?utf-8?B?cHJhWHVwU0w2bTZub0d5L0JNNXdOLys4Z0U1cUIvWmV3OVNpSGlnQWVxaXNm?=
 =?utf-8?B?eGJBa0VlWFV3S0VsUHdpQk9DZGUwRm82b1QxT1R5TmVrVnBVRkxqTDVkaWds?=
 =?utf-8?B?QTU0eE8xKysyU3Q1a2NaeUNPTFdOOWo1dG4xeWJ2MEVabVl4VzNFRlpyUVdx?=
 =?utf-8?B?MWFtclFEanF3dWx3WXlwQW9WQnZZNHVYTXh6V2ZwamNIWU41N0hFQmU4KytX?=
 =?utf-8?B?SU8yVnczUWJ6U2NLWE15MThPcTdrRGFSK3lNaENoWC9JNm9mQ0tMZGNmUDBB?=
 =?utf-8?B?MTQ4Vm5BVGRDSVNUei9UYmZaTmdKVmliUitOMUFCTXo1MUpBTktIdzhINzZB?=
 =?utf-8?B?Qlp0ZWlqQzN2NE15SjZVbGlxZy9PU1E0c1V4R2E2TVo5M1BtTGU0NE9sN3R6?=
 =?utf-8?B?ZDlBWlJlUC9na09VdEprT0FZdHV4amdFUksxcnZ4K2IxOVJRb0FWMnpUYWtS?=
 =?utf-8?B?UXpQWVM3cDRSbHFMbHE5RFRiOHZqM1FrUGNPTUZ3ZUpZbkpwb2pyL3d3R2Zl?=
 =?utf-8?B?amtEOXFON0dUZmpqTzRxQzVPUkt6WnNqb2Q1V1FHRCt0clBYWVJpa2MvSVgw?=
 =?utf-8?B?KzZ1NzBEc3BibTVXaHl6cTFLNGtsR1dKMDMxbHVmeWI3VklOTmFQbW1RQVNw?=
 =?utf-8?B?Wk5TWCtXWm44TCtnMEZvNTgva0RVdGdlVCtYOHVwY2ZTN3pvVFJ3YlUzV290?=
 =?utf-8?B?d0RnaVNQdUo4Um5lTGpMTzlrcWZrNmgxZHBockVHVlJSOWFkRE9ReGVHU0lk?=
 =?utf-8?B?b1E0SnlGVjRkNDRRdTAxd1d2eEFuNVJoM1ZGUXR5NzBPM3QwYlJacXdqWFhz?=
 =?utf-8?B?bXQ3YkNaL09keDh1SWJwWjFpTXFsbmVza3lLV2pIOTM3aGdOemNWV01ic0k3?=
 =?utf-8?B?QUZ1QlNaODRPWjBZNUdIVGhLTkR0cVpWSEhFT0dmdnEvTlV1MzVPOHR4Ykxx?=
 =?utf-8?B?TldqNDRRUmFFNWQxaUhOKzYxWW5WZkkrSUppaHNWQk50aTdXNmszTTNRRGd1?=
 =?utf-8?B?ckNFd3NJdWs2NXlscjZwVDZpbmwzaFpKUUpubzFVKzN4bTJZV1I1amRQaHBs?=
 =?utf-8?B?azhTcUEraVRZWlJzcUxGclRUR3lWbEZEZDFGcCsrMmVzUTJBOUY5c2U0TStm?=
 =?utf-8?B?U1Jsd3UrNFpSR2dKdGJWcGFpNUt5TU9QaVA4MHRNTnQ4RmZZaXFJamJ5bUtw?=
 =?utf-8?B?VU9BakRIZUNjMHJmeDJMMG13TklxNFVmVXE2UDZVYXg5S0w0ekovVHB0MVBu?=
 =?utf-8?B?UUd5a3hJekxYWERGOEFlVGhaZGdrd0k2TjVXL1BtWlF3NG94U05BcHg3Y1k5?=
 =?utf-8?B?c1NoOU4ybzJ3bHdtK1MwY2ovcTIvUWVrRXZMc3FsQkdjZnlUdUh6aDZPSThO?=
 =?utf-8?B?RWcyWUFDZXNSSlV0VDRnM0NYa0k4Nk1WMnNyQml1dVZkZEpHVW1wWjg1bGNu?=
 =?utf-8?B?RlJwbm4vd0ZSYjhMdG9oRkVSbHhTN1ZGMjV6ZDZsRHpCVzgzd080Y0ZIeWJv?=
 =?utf-8?B?eUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	l/mi1WiyYbtKClWNs2DABzW/E5Mr+7DaIjjEqMNIm++4rtN9rwB/JZf/+tjnIwWfSpvRYyX/2VVJCPeyLetc9fRioyjwleZThVcS03rXAyBfuJoOouqsm7QennlWSHYwikZEufgyG8tol/aT3X8yaA+feDa1ke19CN/SnMgmXC4ueBzlj502ap11hU4C9du0/Rk64gWjODZrb4QNFAYneUx4MWjYOhwrrPGyH6zEYd60PwLXkz2oL+sTD4IbCn4pbv5Hp+ZZuG0andq1P/fugHRPhFnzsEHHNA3kQ54uzI4wAqj3Z5k06Qi+eLGY5Zq74DVilkJgAQNIJr6SPiJLeq/kAGBhfU9z6t0OognnybPiAhwxE8VOb8PuFJYjWNjSSzj4MccqCi6vQFhIMxJ+BVRm99A5RtnVnk3N6bGGF4qUlMip9Rk9gvJU8k2Al2UqHfdZErX8z/Zsv3PkQoygdVnz9UTRTkagjro8aaOB7uvfxl3QjrLEvaA4qsQT1NboG3JttiuwWbEe6SZsIy2dF3mDRI/ytxMcLkWBneqllsI+1U3+wcAeNDWQavxY4/O4DcZZqqKOilup7Ii6JnrhDxHbxOIm5/hpuB8TJMBmo24=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12e26fc7-b31d-44eb-d103-08de22dbffbd
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 17:42:21.7650
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0i1xX4WCYfj2so57U4puPvkH0P8ZO/VKZafBqkVu53vskMcrAyWNeZVa/nYoB9nHJFBWpDFz/yzHQN/TCm5+bQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7939
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_03,2025-11-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511130137
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDE0MSBTYWx0ZWRfX0m2VTnCTXzV2
 0nZ9mf/WRjVa/R+gAL5X49aFPNvBYreYFxUTkkLa9/f+quUD7plEkxBVPAUyteiD3fJBK9MIaJV
 M3yyn1oNVAUdq63cqFmtJ7/NyKoyUGvT1GG/b/F1DyqTh565tc6t60tgljq3Ta8jkDqqsRbWxn4
 UIIAdG4wbM63fsE27ZMAxWblHDh1aKjKLbwwqSs9WHF42tni36PSfMoieKqeZN83C2Td41TDFfx
 o1gJuKb7zYZamJaWjdu9j/wVI6Qc+ghZLpGF0oah2i9nvDSgsJplUKM5UU62+JP2uQ6rbL/tvfa
 oVcpJmGzGcf19WFP3rgHqnOAjiaCnMIFmTDAfiIjnulpoR8xIa3m6lSElKeBycOdSdoAgXPxSNk
 A9COG9WAN/kyZHJzmj4Xm3a/hRt9JlQt81MEc548S3278tQCo9c=
X-Proofpoint-ORIG-GUID: RRq19Qv5w9XnvEKQedXygDa5hgJ0I7po
X-Authority-Analysis: v=2.4 cv=RrjI7SmK c=1 sm=1 tr=0 ts=69161881 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=pGLkceISAAAA:8 a=E5RKnd8S-lp2Z5d71a0A:9 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:13643
X-Proofpoint-GUID: RRq19Qv5w9XnvEKQedXygDa5hgJ0I7po

On 11/13/25 11:46 AM, Gaurav Gangalwar wrote:
> Bumped up rpcrdma_max_recv_batch to 64.
> Added param to change to it, it becomes handy to use higher value
> to avoid hung.

NAK until we have a full root cause analysis. Please explain why
this change helps.


> Signed-off-by: Gaurav Gangalwar <gaurav.gangalwar@gmail.com>
> ---
>  net/sunrpc/xprtrdma/frwr_ops.c           | 2 +-
>  net/sunrpc/xprtrdma/module.c             | 6 ++++++
>  net/sunrpc/xprtrdma/svc_rdma_transport.c | 2 +-
>  net/sunrpc/xprtrdma/verbs.c              | 2 +-
>  net/sunrpc/xprtrdma/xprt_rdma.h          | 4 +---
>  5 files changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/net/sunrpc/xprtrdma/frwr_ops.c b/net/sunrpc/xprtrdma/frwr_ops.c
> index 31434aeb8e29..863a0c567915 100644
> --- a/net/sunrpc/xprtrdma/frwr_ops.c
> +++ b/net/sunrpc/xprtrdma/frwr_ops.c
> @@ -246,7 +246,7 @@ int frwr_query_device(struct rpcrdma_ep *ep, const struct ib_device *device)
>  	ep->re_attr.cap.max_send_wr += 1; /* for ib_drain_sq */
>  	ep->re_attr.cap.max_recv_wr = ep->re_max_requests;
>  	ep->re_attr.cap.max_recv_wr += RPCRDMA_BACKWARD_WRS;
> -	ep->re_attr.cap.max_recv_wr += RPCRDMA_MAX_RECV_BATCH;
> +	ep->re_attr.cap.max_recv_wr += rpcrdma_max_recv_batch;
>  	ep->re_attr.cap.max_recv_wr += 1; /* for ib_drain_rq */
>  
>  	ep->re_max_rdma_segs =
> diff --git a/net/sunrpc/xprtrdma/module.c b/net/sunrpc/xprtrdma/module.c
> index 697f571d4c01..afeec5a68151 100644
> --- a/net/sunrpc/xprtrdma/module.c
> +++ b/net/sunrpc/xprtrdma/module.c
> @@ -27,6 +27,12 @@ MODULE_ALIAS("svcrdma");
>  MODULE_ALIAS("xprtrdma");
>  MODULE_ALIAS("rpcrdma6");
>  
> +unsigned int rpcrdma_max_recv_batch = 64;
> +module_param_named(max_recv_batch, rpcrdma_max_recv_batch, uint, 0644);
> +MODULE_PARM_DESC(max_recv_batch,
> +		 "Maximum number of Receive WRs to post in a batch "
> +		 "(default: 64, set to 0 to disable batching)");
> +
>  static void __exit rpc_rdma_cleanup(void)
>  {
>  	xprt_rdma_cleanup();
> diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c b/net/sunrpc/xprtrdma/svc_rdma_transport.c
> index 3d7f1413df02..32a9ceb18389 100644
> --- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
> +++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
> @@ -440,7 +440,7 @@ static struct svc_xprt *svc_rdma_accept(struct svc_xprt *xprt)
>  	newxprt->sc_max_req_size = svcrdma_max_req_size;
>  	newxprt->sc_max_requests = svcrdma_max_requests;
>  	newxprt->sc_max_bc_requests = svcrdma_max_bc_requests;
> -	newxprt->sc_recv_batch = RPCRDMA_MAX_RECV_BATCH;
> +	newxprt->sc_recv_batch = rpcrdma_max_recv_batch;
>  	newxprt->sc_fc_credits = cpu_to_be32(newxprt->sc_max_requests);
>  
>  	/* Qualify the transport's resource defaults with the
> diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
> index 63262ef0c2e3..7cd0a2c152e6 100644
> --- a/net/sunrpc/xprtrdma/verbs.c
> +++ b/net/sunrpc/xprtrdma/verbs.c
> @@ -1359,7 +1359,7 @@ void rpcrdma_post_recvs(struct rpcrdma_xprt *r_xprt, int needed)
>  	if (likely(ep->re_receive_count > needed))
>  		goto out;
>  	needed -= ep->re_receive_count;
> -	needed += RPCRDMA_MAX_RECV_BATCH;
> +	needed += rpcrdma_max_recv_batch;
>  
>  	if (atomic_inc_return(&ep->re_receiving) > 1)
>  		goto out;
> diff --git a/net/sunrpc/xprtrdma/xprt_rdma.h b/net/sunrpc/xprtrdma/xprt_rdma.h
> index 8147d2b41494..1051aa612f36 100644
> --- a/net/sunrpc/xprtrdma/xprt_rdma.h
> +++ b/net/sunrpc/xprtrdma/xprt_rdma.h
> @@ -216,9 +216,7 @@ struct rpcrdma_rep {
>   *
>   * Setting this to zero disables Receive post batching.
>   */
> -enum {
> -	RPCRDMA_MAX_RECV_BATCH = 7,
> -};
> +extern unsigned int rpcrdma_max_recv_batch;
>  
>  /* struct rpcrdma_sendctx - DMA mapped SGEs to unmap after Send completes
>   */


-- 
Chuck Lever

