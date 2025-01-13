Return-Path: <linux-nfs+bounces-9157-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8925CA0B85E
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Jan 2025 14:39:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 046977A1840
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Jan 2025 13:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16FDD22CF31;
	Mon, 13 Jan 2025 13:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kGFLieNP";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dFxXRXs/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1D1125B2
	for <linux-nfs@vger.kernel.org>; Mon, 13 Jan 2025 13:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736775567; cv=fail; b=lfOJjBz8UZLxL13YYtm1n6UO20/1GtkNMnX3e+XWycijuS/8n5rMomOhBeiEXyauz3nsnMHpAM5HWp2a2SujpC4sFV3LdBIwfEk/KUeKjxz24KuB/xinKCvnjRUhGe8iURYkaB027dmOLWGk+9mqlpOaaBwxAK1ULWcr8Rt40pA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736775567; c=relaxed/simple;
	bh=b7UTNeWlIQrsZ3PonINWlCVxtQFT8qTrWuB/B/88LZk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Rtzg7XePd+M1kMg6W4n3O9vUEkXpRzEYwHXKegoDBVx8qsMAINi5863M1ZPQgBdR7sykaRYRlwuAAnO4US8E15jOz7KZvloAFq7xa6xG68Ka1zdaTw8WzpB7B+bRKIVORqQIwum9eeTCgzP/QhsE7zXE3rSxEt5q52TPWW3Ms/0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kGFLieNP; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dFxXRXs/; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50DDcPvq009495;
	Mon, 13 Jan 2025 13:39:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=Fef/9tfg0UNrgNlfrj6e2BpOnIIVQyvFqBAfuOW9aAM=; b=
	kGFLieNPcuAKFv0ATql7O6mIpXd2oBylbzkUczz7kmtzptbZNcNT4o6l8tdpg+7L
	iqf7xymiSZjhCWR1yoZE1vrHcRbq4mehX3L+VbxC2qkeQFQKCv3aHcOgMazcySv3
	1VVfZJDZmcjtaEcBGNZ6+XKHSlG3oB/82Sf2JxQ2f61l/t+SyO4IbXvrMrOsT58Q
	FGe4E6M7oOEJlnHNNpHlyB52RRg4Ogq6YJDiopN//ykb/Zg+nXs/wuZ1NjD7uRy+
	fprsxxBkZX1naBcUokWyJjVZ9Fl87BGZwRwrgL++k2YabodVmOpGtYrcxDhc0KZ+
	EjuvBXD7DaHH86j3R2FBpw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 443gh8ufhs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Jan 2025 13:39:22 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50DCw8Oj029872;
	Mon, 13 Jan 2025 13:39:22 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 443f36yv9m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Jan 2025 13:39:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M+pAHKmXhipe/v6/udUrkwtyuT7xfcUmVVdnN+Brsozgr1oo7A8ZFCpxUZ3asQSEi0CpXOmjn81OjH7/LUXQEj0iIVavyrMYDG3lXoXAwS59q+S2MQa/8McNiahmqLDIZn/hzQ+HdA4IxnuNGf6jWaTYVxpXIUn75ecG9dpFChZgsOFxIgTYlFtGoRtJw9qXLIwM+VjGSE+NNtV51N1kzuMsvFzptGy92OJobksqhVAeeL/c+cQcswD6t6VGYw/aFxYdp+n4sFUSikpt5o4DnBb8G5ZYLXDdtOhS19VAVvaVVSjNkKHYr+PQafTldFj/dfYLDpXWUKfjasicjCzIcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fef/9tfg0UNrgNlfrj6e2BpOnIIVQyvFqBAfuOW9aAM=;
 b=BQ38QRpuuPEXm8SFCHnpuXVCDiWTr8uJxl/uJa4aDBxDahssbsBaGeM8tFD74vfiX0vxkUrxyZVKbPFwWEzZPBQ6ePLW6Vdoou286ixukvMJPkX7HJIAe9N4K5m497DjdRqZNX7xxGdY4nZOvM/vNA19EZ4995EdOnUFqqRsBNIYtv0BJaxXvp6o1P8OC4EF59zx4RuI+vZcnAq1L2cmTijvCYFkaFWZJ6MXJ3uLsIdexPhaWMebKlRH8LedsrW4b/ZafBnZsScPyqs3Xf+tsvB7Jxtt/FuOkMe/WVVCnCk+QV98iwG7fjFvg5hrhlzWr54gHjenaKHX8SZ8qgOjsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fef/9tfg0UNrgNlfrj6e2BpOnIIVQyvFqBAfuOW9aAM=;
 b=dFxXRXs/kg3bGZkPwS1A75q/vn+k6/IV8P7SGeSL7ROu9aCAMMwmc5C78C/WbBQXv1UlcuCNwRr1bdgkAkdTOi7vGEQ3eFKhY+QkbQrgqqLa8xfvb+XY9/Z4IL06PlUoo+sscz4BDoEk1Iwl4FUNWxVHUkaPDkQfklohUeenEZw=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS7PR10MB5120.namprd10.prod.outlook.com (2603:10b6:5:3a5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.17; Mon, 13 Jan
 2025 13:39:20 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%3]) with mapi id 15.20.8335.011; Mon, 13 Jan 2025
 13:39:20 +0000
Message-ID: <adef5bc9-254c-412e-8fa8-6f5accedf7f7@oracle.com>
Date: Mon, 13 Jan 2025 08:39:18 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: nfsd4 laundromat_main hung tasks
To: Rik Theys <rik.theys@gmail.com>
Cc: linux-nfs@vger.kernel.org
References: <CAPwv0JnSQ=hsmUMy0VY-8k+dANBLNkJdFJ75q9EEE+Hj0XXB8A@mail.gmail.com>
 <d54d71f7-9bdb-49a4-8687-563558eca95e@oracle.com>
 <CAPwv0J=oKBnCia_mmhm-tYLPqw03jO=LxfUbShSyXFp-mKET5A@mail.gmail.com>
 <49654519-9166-4593-ac62-77400cebebb4@oracle.com>
 <CAPwv0J=ju3fZ8C_FFeDnzzKT-ppXaLCde64hQof3=g641Daudw@mail.gmail.com>
 <365e7037-733b-40d7-8046-b19ef3d803a8@oracle.com>
 <CAPwv0JmJErKaquZMApyUkpkFn9_x6C+32Dcfxeg0a4-=iR9wEQ@mail.gmail.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <CAPwv0JmJErKaquZMApyUkpkFn9_x6C+32Dcfxeg0a4-=iR9wEQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR04CA0019.namprd04.prod.outlook.com
 (2603:10b6:610:52::29) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS7PR10MB5120:EE_
X-MS-Office365-Filtering-Correlation-Id: 49f30dc8-f628-4fb1-7f26-08dd33d7aee0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ME1SR0J2cklqU01TQUE5RS9QU2RjRU9YTXpORmpyQnZxamZmNHlySm1SZzBH?=
 =?utf-8?B?dU9NNTEva3JQazd5WHZZbE5iVGpzaHBLTVRxMWdkc05CaGZHZ2dscnE3NDdw?=
 =?utf-8?B?bmh3Tzl0Z2drNkVnUGMxSTFiZEtLS0JWZXlUNTJvMkhSZHNkYi9RcmNyQlMr?=
 =?utf-8?B?Y24yS0QxMTdoVzFwSTJ1b3JXZk5aVFZocGRLMDIraW9BbnlQNmtDY3RjTXMr?=
 =?utf-8?B?SWFxd3UvYXF5bENkenVENDdRR3p4dEwxb3c3TWQzMEtYcHdoZVZBWkNPMEFG?=
 =?utf-8?B?Z00xRjZLUkdkcEtIVE12aXZEZFJZUmh3d2lJOTJxUXhsVkxIZEFCVTVmcFU1?=
 =?utf-8?B?S28vQ1BZV01ZWXhVTjZ6YTRVZmV6bHpiRWM1M1VDeTQ0TnZBUGlkSWJPUjFx?=
 =?utf-8?B?RHVwVUdqaUppZ3A2NTgyZWg3MDhsQmFsU21RM1lYbG1jNHM3THFXR1piUnZx?=
 =?utf-8?B?VWdtMHJsWEhYaHVQdFNMcWhPZmw1b3hxY041bTBEY0FLbGVvMW51ZXIvVk93?=
 =?utf-8?B?M1Jvbmd0Sk1sUU1UdkdaaGVkMjJES0VoMDRCMkgvV3JWemp3RW1JTS81ZlRP?=
 =?utf-8?B?b1cyL2pCQlF3dFpVVWFleE90S21TdmtRZHBmUS9qd0w1SG1pcXZqL1JybTdi?=
 =?utf-8?B?SXBnQ0RFazgrY3F1U1lFUjg3Uk1kZ1F3Rm9FUFEwOHo4T3VYSU02Mkp3SkFy?=
 =?utf-8?B?RDFZZ0tpY3E1N3F5WDVvRXJRSitFOU53WnNMeGhHWWdXbnVpdXRlVFY0NEtM?=
 =?utf-8?B?Yi8vam9oUkVXdCtoeG8rdWNGd0FOZjh4bXFrK1h2WEtIVXdXVHBtaUlDOG1o?=
 =?utf-8?B?SHBoNEd5ZE15ZCtUWDFNeUNCdzVYUU5ySDZkQUxNZkQ2MEdZcmZKanM2TjVK?=
 =?utf-8?B?dlM4U3VMN0NIeWdiYXRCV3ZNNzVVbjdZdGZ5bmFFZ3puSzh4S3RrUkJaTkVi?=
 =?utf-8?B?KzlSWHcybk84Y2lHUVJWaWxhTm5uYWJTdmd1QUVxOHhjR2pCMERSdGsrczBn?=
 =?utf-8?B?eTJ4aVVzS21uTE1DemFOOXk5dTF5NFFOa1I0UVRCVm9wa2hpSG1FNkZRNVk0?=
 =?utf-8?B?VUFYQ3hTQTdDYTNiMnVDSlUxMVhkd254WlJPSm1yYkZKN1lxdGt1dkhpZjFs?=
 =?utf-8?B?cnNxeXdreE1WYUZlVDFlOTl5akFiZlhUaXgySXhjY3VBbkFXNUlvTEJQQUtK?=
 =?utf-8?B?UDVmNEhzREd5SXI1bDNTbU1JNEtBRWk1WVBPNWFFZURvbmZHdG1Mb0JGNjY4?=
 =?utf-8?B?YjFuaGRqS2NyLzhVdlFla1JobmVOT2JabVAvNW51WVp6YWxhT3RrQkpFNjZQ?=
 =?utf-8?B?T1o3SkRVYk5OMHB0MXM1SEJzVVFuUmhhZzg5K0h0Y1R2c3BJbUhZNkdpZzVW?=
 =?utf-8?B?VE8zTFJIZFRoOEFHei9uY1l5eEppNXJiV0s3MlhxWUoyYVQ0NXBLcFZpQnRP?=
 =?utf-8?B?SGd0M2JGNDR4U2d1MVEyRC81NXh1MTFRNW05d0UxWHpNV0JielhPeGZRVHNy?=
 =?utf-8?B?aE83RlRNYk84QWFLakJyZEkvQ1BnOWVxbjM0RVJDNTlHL3NoR05CRlFaZkpQ?=
 =?utf-8?B?c3hSWHVHRGpzbmIzRTZuSmVrTTdlaU9IZ0xnRHo0d1ZjZjcwV1E0bTR6bWp5?=
 =?utf-8?B?ZFl4OWZOSHplM0g3UmcyWDdYcjdhN1djVUNodVZzYk9XUDRpZ1BVcFRWU2cy?=
 =?utf-8?B?WisyWmVLeGd4OUtTS2xFWWVJM2JRSFRUUDh1cUtKSEt2TnhNanJiTnBQL2Qw?=
 =?utf-8?B?N0gxK1gxcTlCWnJ6a0xaQTBzeVlUb1ZDbWhoTU1NRGc2RDVzbG5yRUxXQThX?=
 =?utf-8?B?eGhvY3Qxb3RCa1ByaDRnZXZacytRa3RwRTEvWFRWM2xJMjlsaGY0RFo0ZEl2?=
 =?utf-8?Q?Y/HSdyORm4XCR?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dGd1aVlLbEgzZFRoakRsQUNoM1B4L0NjMkg2bFZqRDFrY0ZJcUlLWStWTHNK?=
 =?utf-8?B?K1NnTVZmdVRjalRIamF6dzNVbVU4djlHSUdPdXRwNkhSOFV4MElUUUJWdXU1?=
 =?utf-8?B?MTAyc0lCMGFMWlNnbHFlQVlQRE1WRDFmMmpoRXNOQU5samVVUis2bHAzdEpv?=
 =?utf-8?B?TmFadWlTVWplV3NxTjVaK04ycmt4QUFseFVzSCtGVFl3RkRMaVkrSUd3eDIy?=
 =?utf-8?B?SmlDdFpCR1VnWHJ3UUdoSnUzaHpEVXBWMGxUUVBPRytrNExQUC95czBKL3lw?=
 =?utf-8?B?bTFDMEU4KzhVRWpuV1dmM0FlQXNNazYwUDVuUTgvQU1pSlNJQUdjN3I1WjU4?=
 =?utf-8?B?KzhyZEEyajRIK2h0cVh6NE1ZYkZaUHVjdzRLRlQ2QnI2SDdyYmdJcnVPMVpQ?=
 =?utf-8?B?OG5paUk0bFVLNVc4by9HV3lVVjdJTnkvbUI1ajNicDg4Z2pPMmlJRC8yS2tT?=
 =?utf-8?B?UHl6Zm04QkpMcDl6WXNsRVV2ZzBxWEtjMHhLOHlGMmxDVnNQdjBIZm5MYkZt?=
 =?utf-8?B?ZS9iK2Jjb2ErczlXRk4vWnlhYW9GUC9QcG9aV2YvR0tCYjl5b0dYSG8rRnVq?=
 =?utf-8?B?ZlJEZkdBeXpmR3lYMW1QMFNNUmFITHc0NnBJZUZTd21yRTlmb2U4cUxEQVZO?=
 =?utf-8?B?NGNOSlNNOHJuNkU3OUpqMGpndXVSWmN3R2pzV05GNWUzYjhaa3M0ejJxQVdw?=
 =?utf-8?B?MHBURXlGK1hhOCttV285ZldNcGhQeVpVN1lXb0lOdzJwR285YlpTUmQ3MFE4?=
 =?utf-8?B?L2tFUmErUTZGeGh1UTJ3Vm1vRXZJVm04N1RDazZZa285czhSRXo1L2k3SDBO?=
 =?utf-8?B?OHhGdWdKeS9LRWs4ZnM3Z0hDckFvTW5rbTVFKzVOd2Q3dGZEQ1pDSDQ3Sm4y?=
 =?utf-8?B?UXZDMkIzU0lyQmtWeTNqM08vR3d3ZVpPbE9TZkFRd0dHMm1LU2pSSUhFVUtw?=
 =?utf-8?B?a2JIbUwvdGl2SGlXSm1OdjR3MTV0WERKMHdYQ2VOK3JucDcrY3hRRTMzT2Ir?=
 =?utf-8?B?Y2xnS09XMkFnNTlRcExqR1d2Q21nTFRrOXJ0TzdnWldJWTlSS0lPaWRleDFJ?=
 =?utf-8?B?SkJFbGREVXlscWR0a3c1cVNWU05VbCt3SHd5czRzd0NCcFlkSDhlZ3ZldHE0?=
 =?utf-8?B?cFR5SWFBbW1DSkxiNmJLL29udjFMMWxxUFpQUzZVQUdyc2wvV2QzemM5aFB0?=
 =?utf-8?B?UWVVUUFYd0RhK1BjVXNvaU9NTm1qbkpub0FiQllqRWxzNWlhUllZQzhxY1ZZ?=
 =?utf-8?B?bDlwL01HcGo4aHNoYnNaall0WnRRQk10TmNrSVNDM2x4R3kyNnB2clRzY0hJ?=
 =?utf-8?B?emlSSHl0NHF6czFmTTE1QnI5VDBMaDR4azV4UnJtTWhKNTJ5c3RlYnpnejha?=
 =?utf-8?B?cFpHY244Q3RFME1yS3IvM2k5eUx2UDdSNVR0Z045MUtTTlRVdDlmazVoN3VW?=
 =?utf-8?B?bUN2aUx4elVVUEEzNUUxamdtdXJoWmpreDFSckZndE5xZGYyZnB1OTlzbmhF?=
 =?utf-8?B?VUE0ODN6TXZNVEJSSklyczhNc0V1NGJqVlVaUWEyK0d6clhWblc5cWR4R1dr?=
 =?utf-8?B?emhPa0l6aHRkTStLSlVRc3V6WkxvTUhsR1krNVJ2WkYxaFdCR056L3oybW1O?=
 =?utf-8?B?SHY4cnRXcUtkSXlkVVBnd0x4TGZEQUtHd0ZnTWNKNzMyNi8rRHFZczg4RHdw?=
 =?utf-8?B?cjJ4UXk4UDZRZ0NzSXdGcC9VRmRHNzhPMEIvZndOV0trRTlraGVVLzg5cGVj?=
 =?utf-8?B?RXduMTh4L1kzcGZlT2dUdkNSRTN5cGU1RTJ0MXZGeUYxaFhBWmFjNzdFT21B?=
 =?utf-8?B?TER2OUZtNjNhbDM0VjFtMVNmY2pQYnhLSmw4cjU0TkVybmNRaGtHK0IzUTlL?=
 =?utf-8?B?Q0hYTit1MDlMR1U4d0dteVJRUEJEdnVUbllSbUI0OWV2aTd4NWRKRytEZkZI?=
 =?utf-8?B?ck9zK1ZlTkJOTllXYjlOanRoVnBnY2JXVmtoMTNNTjJiZ05Ud0dDS09saXFz?=
 =?utf-8?B?TlllM3NiME9WOWRDVzJhTldIMXhKaEtCTFJwcFNxZ05rSXl6SjEzc3JGM1RZ?=
 =?utf-8?B?YlVqZVczTVVLejkrc3puc3RUejJZQTR5QmhoTEU2OHFlUzdqK0xtTElFRXhp?=
 =?utf-8?Q?foxndrT0u4404Eipvrio7u8T2?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	roAAs011AeAjkXhmL72QnlBkYHKLJcVL5iVnRNZCJSQBZ+RlWMWa2mYOgNl4bOjnGGFsciE7u48s0RFqdDcoJd32NrLACfb8A0nmfbuxN4R2rkpeNTViiHjRb4K+BZiC97GuxAU6ZynIfWSJBlpYnRTRSS8WP+nFe+zkzGhYK0s4nEX878psvnzzwQDoNKDi59PHqxDu32L8621ru70l5GZPcR/OKP+2wcom6u2BWkhMyQT3dQ4dZkWECRXX8z/uKR8/mGQ2zkVsKilQ8Wo+qQaolxReUvtcfp2BBP5/vgjTR8NkTMuvIEedzrEKsiQMq+YnOaHg6DHwhkLo/bk3bzAm5nlnJ+GK6alqku+qWjjXak0+2VJbv/gMkPL0iWIQmLVpKs62wSSksKWTg0Mqy+6kLvT/mWa5Og3+UXIEwI1kW6sVpk7EMc5LfZmCd1d0UD1QXFCRzgrkv+Wytv1AV/h1pYzInhUwG7iD5zP5KnbJwLGjeOMvUzM7zklKbN4v336QMPrG5OdNc2rk6g5KQurpuBVVc/ygyPPConSYpXf1d/vQCUCA1llmiOwtmrIdRHw0fS3f4nXQmy+i1Ek9raEopmjCvaLzpjcQvcgJLD8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49f30dc8-f628-4fb1-7f26-08dd33d7aee0
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2025 13:39:20.3145
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i90n4LBIgsT96zacXJHkt+J2NDr6EP5/Qw3GBnGeiMUdf6UysBD6xA2SHxaWTPrsoJUG3cfWy49C/WpqGtDCcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5120
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-13_05,2025-01-13_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=905
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501130115
X-Proofpoint-GUID: 0Ur3ZG4UclEp-uVKPKLHwWxRCUo5ZCuG
X-Proofpoint-ORIG-GUID: 0Ur3ZG4UclEp-uVKPKLHwWxRCUo5ZCuG

On 1/13/25 7:30 AM, Rik Theys wrote:
> I've created a systemd unit to run trace-cmd on boot. I've started it
> (before rebooting the system) to see how much disk space would be in
> use by having it running.
> When I stopped it and ran "trace-cmd report", it showed a lot of
> [FAILED TO PARSE] lines, such as:
> 
>              nfsd-6279  [035] 2560643.942059: nfsd_cb_queue:
> [FAILED TO PARSE] cl_boot=1734210227 cl_id=1829245597
> cb=0xffff94488e9c8d90 need_restart=0 addr=ARRAY[]
>    kworker/u192:4-4169949 [032] 2560643.942079: nfsd_cb_start:
> [FAILED TO PARSE] state=0x1 cl_boot=1734210227 cl_id=1829245597
> addr=ARRAY[]
>    kworker/u192:4-4169949 [032] 2560643.942081: nfsd_cb_bc_update:
> [FAILED TO PARSE] cl_boot=1734210227 cl_id=1829245597
> cb=0xffff94488e9c8d90 need_restart=0 addr=ARRAY[]
>    kworker/u192:4-4169949 [032] 2560643.942082: nfsd_cb_destroy:
> [FAILED TO PARSE] cl_boot=1734210227 cl_id=1829245597
> cb=0xffff94488e9c8d90 need_restart=0 addr=ARRAY[]
>              nfsd-6328  [028] 2560643.942503: nfsd_cb_probe:
> [FAILED TO PARSE] state=0x1 cl_boot=1734210227 cl_id=1829245598
> addr=ARRAY[02, 00, 00, 00, 0a, 57, 18, a4, 00, 00, 00, 00, 00, 00, 00,
> 00]
>              nfsd-6328  [028] 2560643.942504: nfsd_cb_queue:
> [FAILED TO PARSE] cl_boot=1734210227 cl_id=1829245598
> cb=0xffff94488e9c8300 need_restart=0 addr=ARRAY[02, 00, 00, 00, 0a,
> 57, 18, a4, 00, 00, 00, 00, 00, 00, 00, 00]
>    kworker/u192:4-4169949 [032] 2560643.942515: nfsd_cb_start:
> [FAILED TO PARSE] state=0x1 cl_boot=1734210227 cl_id=1829245598
> addr=ARRAY[02, 00, 00, 00, 0a, 57, 18, a4, 00, 00, 00, 00, 00, 00, 00,
> 00]
>    kworker/u192:4-4169949 [032] 2560643.942515: nfsd_cb_bc_update:
> [FAILED TO PARSE] cl_boot=1734210227 cl_id=1829245598
> cb=0xffff94488e9c8300 need_restart=0 addr=ARRAY[02, 00, 00, 00, 0a,
> 57, 18, a4, 00, 00, 00, 00, 00, 00, 00, 00]
>    kworker/u192:4-4169949 [032] 2560643.942769: nfsd_cb_setup:
> [FAILED TO PARSE] cl_boot=1734210227 cl_id=1829245598 authflavor=0x1
> addr=ARRAY[02, 00, 00, 00, 0a, 57, 18, a4, 00, 00, 00, 00, 00, 00, 00,
> 00] netid=tcp
>    kworker/u192:4-4169949 [032] 2560643.942770: nfsd_cb_new_state:
> [FAILED TO PARSE] state=0x0 cl_boot=1734210227 cl_id=1829245598
> addr=ARRAY[02, 00, 00, 00, 0a, 57, 18, a4, 00, 00, 00, 00, 00, 00, 00,
> 00]
>    kworker/u192:4-4169949 [032] 2560643.942770: nfsd_cb_destroy:
> [FAILED TO PARSE] cl_boot=1734210227 cl_id=1829245598
> cb=0xffff94488e9c8300 need_restart=0 addr=ARRAY[02, 00, 00, 00, 0a,
> 57, 18, a4, 00, 00, 00, 00, 00, 00, 00, 00]
> 
> Is there any additional option I need to specify, or can these items be ignored?

Nope. This means your distribution's user space tracing libraries
are old. The part of these records that failed to parse are the IP
addresses which aren't important for the current exercise.


-- 
Chuck Lever

