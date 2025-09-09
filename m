Return-Path: <linux-nfs+bounces-14159-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B23AB5095B
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Sep 2025 01:49:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4353A4E803C
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Sep 2025 23:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D530263C69;
	Tue,  9 Sep 2025 23:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eDI+Fwwt";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="I0bru85/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE664295516
	for <linux-nfs@vger.kernel.org>; Tue,  9 Sep 2025 23:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757461750; cv=fail; b=pNhuQ9AxI279HOLpwAfbkajEL0IXLAXjQt2ffyeJakHhdOQqXPI0hSGeGvpgbT+ndGbli7vIf0VIRPIrF5H1WI6SgR9wJ0ETP1ZWy9ppeoLNkbiJWite87OwYw2NeDiHM/ECL26eVH98K2q9i/7VTtCglH6wsX4LiDAvdVo0mjo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757461750; c=relaxed/simple;
	bh=rjCXMAiXnaxaWEjzjwaH+mJZVHjf9TOce8mKD/F0lDc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HTKhIq6UmIekq8EAgEQ92yhBJMgORtQ2whfVk3tcTn+vVJpfi0QkZmyO/kC+hjBTjK7yuhyMCSNKFxJztmTgkhygGdSNyvAO2gdRxv5Tdog59Ul3iiWOR3pW8EQ4n/FJZb+CLL3m+S7WVqUj0qEzq0ea6kgwi6xDYgaCW0Oixfo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eDI+Fwwt; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=I0bru85/; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 589L0bfL002113;
	Tue, 9 Sep 2025 23:48:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=nPUGEsMy5af7sdEPU7mX6lu4F5wl5qIPkhETI8MsuUw=; b=
	eDI+FwwtPdxPqVcEPiYQY38+1thfyohUcUCTHgmwEVEVAY37rkTrpZzWhCvy8MbP
	Swa/rjpghPQbCE/hEbQCnbio/iYa09DuchmW+avW4Dor6qEsF727kucD7o7VHb8U
	vXSa3XEuGg3hdFlL3D9YkFEmoFovKTbgW3f4mX3j6jhJ1xdDgHn/yFZVVIQ+CyUD
	mu5vU08Ia7gSlPlSt+XJPzlDyPLdRSwIx46QWfb7otqyKE+sT925tKp3wtGfCVn6
	EOs22CSLBOutdwd4z1SWHuhu6f0ZBo/GJMA9WziabRuPpAGuO4H5AxmwdYMU6r4j
	kpw7g5A56gURCnZcUnb7Fg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49226su12a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Sep 2025 23:48:55 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 589N0gf0030708;
	Tue, 9 Sep 2025 23:48:54 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012017.outbound.protection.outlook.com [40.107.200.17])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 490bda8vvj-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Sep 2025 23:48:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OKuvc5a5chy5N0OSNRL/89f7pmUYw0+cuI10NG/IJ/6k2nXigVo8reItmCdPS64gXWiLOnNFvU20rWxlbPL2uEQZR3CUXl+WUJ0K/2dmHuQAm+wFULjjmaE/0RJudF7F+n6PtafhmWdNnYe4qtxJu7eQZu30Y9Nq1ydsXJz3F44ruw6t60SpYD0HpoacZAt38EgtPHmRA/LGKy6/89LHf4gtzVELe3OV5gClrlDlGZV471LQkluR34mWsxYF5+yR37Sv96s6sFiZMomGySIi0sEmEo9F4f348TZuQD3SFYeO4OPfq8Msg3WpnjF9IGbMumMx8olNFdahDHKqrhSwOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nPUGEsMy5af7sdEPU7mX6lu4F5wl5qIPkhETI8MsuUw=;
 b=Y3dnS5ZN9QV9wkoVfyjnRLJ+Ni4IqoPB8HQnOFaM8dtpDKKjdnRdUL//C07AlXZ4zxH468sAWRkh2Gx9/0tI8y4jZarOMtO5K0MVgCZSaxbIErhQGHDbcTOlrg7ZmHJ6P3NqmPCKiClm6dUMD70jDNna37X8C9v02L8WWUYp/2cGIAURWiJ6oadezOjMpTQkNEpIludAa341FyTDIU6xrSgs1mshWQd6VNomzV4H+Rn3sObxisyexhprfjX0i4w+rBUxTX/xEVyDr3eTAZvgJHG8SebDexpHEPT/TdlIpoSEW/weMYEPhNsDuT2aoaVnK5RxAA9sRwQ0ZObB61//Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nPUGEsMy5af7sdEPU7mX6lu4F5wl5qIPkhETI8MsuUw=;
 b=I0bru85/iqeTnL8b5i4qiYhwxA/V9ZrHHWFfSckkrnjE/hIv5GnRhOXyAa4IqwEsMXNikp8HKgODDxJHBiDlpEzDU6zPB8iOnWhhEHnXm02ke22w81z7rdeA5WN/Zx3cHQdTcXzqWod1lowz5IVvuG2SH+t2y0wt5iaHzEryH6A=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ0PR10MB4558.namprd10.prod.outlook.com (2603:10b6:a03:2d8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 23:48:50 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%3]) with mapi id 15.20.9094.021; Tue, 9 Sep 2025
 23:48:50 +0000
Message-ID: <7a7feb18-a24b-432d-918b-8dbe44af51c9@oracle.com>
Date: Tue, 9 Sep 2025 19:48:48 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/3] NFSD: Implement NFSD_IO_DIRECT for NFS READ
To: Chuck Lever <cel@kernel.org>, neil@brown.name
Cc: Jeff Layton <jlayton@kernel.org>, Olga Kornievskaia
 <okorniev@redhat.com>,
        Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        linux-nfs@vger.kernel.org, Mike Snitzer <snitzer@kernel.org>
References: <20250909190525.7214-1-cel@kernel.org>
 <20250909190525.7214-4-cel@kernel.org>
 <175746104715.2850467.8246435920764028613@noble.neil.brown.name>
 <bb2c9e28-fc38-4990-b881-b652bcccd405@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <bb2c9e28-fc38-4990-b881-b652bcccd405@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5P220CA0019.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:1ef::17) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SJ0PR10MB4558:EE_
X-MS-Office365-Filtering-Correlation-Id: 195c3c1f-3e28-4e8a-bb4a-08ddeffb6ce9
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?eDhRRmdjb0pDOEVLMHRRR1dqemlSUTNaMzVlc1A5eURYRFU1VU8xdVVPaWFy?=
 =?utf-8?B?UWFLYmJaVEUrQis3Zk83U29wWFN5NlpzUmpkYWlLdncySSsyV085Q1JXVzly?=
 =?utf-8?B?VERXa2IrR0wvSm03ajhnUk56UlFKbGllVm5nNUxXaGVWOFcvbFhwSENYSm1s?=
 =?utf-8?B?czNuTFRORVZUNENGTFQ1clB1QWM5UEg2L2dNbVZOUFhPalRKK2ord3dPSlNl?=
 =?utf-8?B?OSt5bmlXc2NHeVdSMTdZazk5U2w1S0lrUndNUmFWWmVaemZoYW1PRStOUE5E?=
 =?utf-8?B?a0pzVkNJbDBMR3pHb1RBWWxrUzRMNDVmaWVUUXVBWDdGRTNKVGc3SVFERUdB?=
 =?utf-8?B?S1d5enIwVGFhU0NmZ1B6RWxJaWZKZm8wTElJZ3R3L1VXWnI1WGF5aCtOVW9X?=
 =?utf-8?B?V1RxSzg0VDlWRk9NL2Z6QXgyM0MyeXpxQnNKZUtSZTNyOEdteER2VkQwWmpB?=
 =?utf-8?B?aFl0ZUFDelBKVmE1TGpTdVUyRStpbHMxcFBOME8wK1ZYUVNFNXJ0MWZWOGhs?=
 =?utf-8?B?clRxa1VJeWsxQ0tjR2c1WDZOUC82Ympqa3NrOENrakNOMkZvSWY1NHhTenRu?=
 =?utf-8?B?dGt3SCtLa2pSbFlHdW8yQzZsTHNFUDFDZU56bkx4bmFDQVkyTnZ2bkVVTytj?=
 =?utf-8?B?TFBqNGl0aGowUkorYmMzOHc1Y0U3SDJJTG9lRFdyZTJLS3FOak9XMW92WVgx?=
 =?utf-8?B?WVlnSFpuQUM5djlZSHJDRXVkNUN5b29uZzBmVmVXZWM4amF4aWYwWWl5S3lN?=
 =?utf-8?B?U0JVSHU0YW1tdS9Id1BUcjBFMDZzQ2Qyc2h5SlgzWFgxZ3Fvak9ocnhqektx?=
 =?utf-8?B?L3VNakxOU1BlWDRRaWplTGRmdWlEa01pYko4Mk9wS2Qva3N4R1VyR2FicHNr?=
 =?utf-8?B?SWoyUDg3ZW9aS3RFakVCcDkvTFBRZi8xYUlYUkRUVTkrYkxBZVBvK2lmdTla?=
 =?utf-8?B?TGx3LzdSMWZhK0hRNkdsQWtFV2J0dEFxUkhjM2RpK3BJVlZ3Z0VJcUlZS0xG?=
 =?utf-8?B?WFhZTFArTisrZUt5RkhJelVBcXZ2U0ZYRXp5ZHc3eTI2eXAvL2hnamVkd3k0?=
 =?utf-8?B?YzEzSjl0VTRpeDJ5ekNrYmpFNEM5ek45U2toVE5zMzFpVnpTMjRtSXVLQk5O?=
 =?utf-8?B?Z1hGdTFNcFJzVUtFUU91MnVkYXV5STM1ZDRXelV3VkhuMmM3OVQ3RW5adW5n?=
 =?utf-8?B?cGVoM0FONGdhU3FCYzB1eU1mT2RYZVo3aCtsVGc0S0NyODJaV0ZBNnBzWFMz?=
 =?utf-8?B?ZVljNXRIbE41R3pVUExjTXNBMmZwMUlUbHo1bGxWNHJwcEs3ZFo3U0c3bXZ0?=
 =?utf-8?B?R2JYa3FZTUhKV3ZKUi9tWDdMb2tFenp1R0daLzdpUjdRWStlWi9pdnBPZm1k?=
 =?utf-8?B?MElwUEdwOHlndDZGZUpXeXJ2K0pxbXFIakd5RmIzeWtvU0cxRDFHU3NCNzd6?=
 =?utf-8?B?N20rYnN2MGJQUk04L3kwTXNHTjcyTnA3RkFnK0x1R2wvYzB2T0dzZkVidEtF?=
 =?utf-8?B?bGhBVkEyMXJqdDB3MVJDb1FQdTlOMXZhSFFuU3Q2Tm5KaTliUXVIcTMvNlRz?=
 =?utf-8?B?b0R1cWU1eld2Nm4wbm4zbDhKaUEwT3JTUnhrYnFSYUJXY05teVEveWtPZTdB?=
 =?utf-8?B?bmFBTk55eFlSV2FYUThMcFhtaHhzSmRsTTFMNGhUNklERHFiRUdYT2FmWCs5?=
 =?utf-8?B?RW95b1gxTklQRG5qRWJPN1B1c283K2FrckRvOE9ZV01ySzdUdXJJUzMxSVhn?=
 =?utf-8?B?MFdTUW13SW1icXB3SXZCZkg5cXpHazVJWHJMQndTZFhXYjFsT1Zha3hYa3ds?=
 =?utf-8?B?TThzOTlHdDFJQVRYT2lwNk54R2cyRjFmNnJTY0RCcEVSbVNyV3pqRnhrZ3pz?=
 =?utf-8?B?Z3hhcThkZm9WbjJUcGRkSjhQdHYvZitXZjJ4SThMbTE5KzZ1dERySC9BZFhZ?=
 =?utf-8?Q?/C4pKlyKHew=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?OC8xd2RZQzFGTUVMNVE3WTk2QjJMdTFLc04rZC90cTY2Z1J2SHVnNTdaaTk4?=
 =?utf-8?B?bk1BYnZib0RhQ2J6MEJ6aVFFbVdidTl6eUl0R2g0WUdPZnVZc1ZOQ0x2NTIz?=
 =?utf-8?B?RDIzY0g5OXdNMEQ5OXBlSGZvZjdBRVJnbFF2N1NjVTF2RWxRU0FTN3B5bHlQ?=
 =?utf-8?B?K3Z2TmJUSk8zMWZGWkVNdUI5dkJMUkhFTWhEaUN6NUliUHoxTERBdk1RNGd2?=
 =?utf-8?B?WVpodEtNT21KNStIVmRoRVF3RVQ3TEdNMHViR2dvL3k0akVyZngxeEhIMkR5?=
 =?utf-8?B?K2FaL1RHZFY3elJ3MEYxcExYZkE4ZXZsYWlCVUN4Ym1nSW1lSFUxSHQyTHBN?=
 =?utf-8?B?R3FpaG14S3prQ3dNdUNSSXcyR0dLZnR5N3Q3OVozTktleG9wRGpjS3Boa0F3?=
 =?utf-8?B?NFUySDgxNWdEdVhMRHR3cjAvcXp0YnZMWDY0Qy9YRWw0aFNER3o3YWVZczZ3?=
 =?utf-8?B?Qy9zUWhUR1BmQXgvdWlLVlF5RjZNZ2wxUHJ1YTZ3NDViQnVRVDJZQ1VtMGdm?=
 =?utf-8?B?OWpZT1h5bmM3MUNIaUtzS09MejR3eVlZNUVFY29BQ3ZUaDZwOEk0N3JYZzNC?=
 =?utf-8?B?Z2gvZ3dtbDRmSkxjK1FtRGRuRHBUN3pqK1EyNDgrS3orN2kvdGFRc3N0a2l4?=
 =?utf-8?B?TzNpQ3QyZ0lObk9NYU5uTkV3UTBZekx0YzBwL2E4TU9QeFhrWk91bXRWRnBZ?=
 =?utf-8?B?Uk5mMThZYzlnczVTUnhZakVaeEVGNnRienpDbEdaT0N3M1FNU1BmQTdiUlRh?=
 =?utf-8?B?aHlTOUFzVjc2WDRaOGxDQis2dUVXdTZvdjAyUVl0TE1sQkNNVDRoYkwzUWxI?=
 =?utf-8?B?T2tua2FNaFF5TDlnVFI2VFQwcVRud1EyZ044T3ROQjhGSG03bVc2cWg0ejk3?=
 =?utf-8?B?dUJKSmNEMGR1N1ErQWRoSnNzZVBiOVlXM01KbTA3bEMxRUI5dVFYeEJldlpO?=
 =?utf-8?B?S0ZnakxwWGlZeU55amF5WWREV1pJVGZmb3FkdVRmZGNWSlZ3QWNUcVpmTEFS?=
 =?utf-8?B?SGhvUUkwVVo1YmlMb0JJYzJXcG9nWCtMcXI2bFpMd2tneWwvOUlPeG9jY2Vt?=
 =?utf-8?B?NThDS0ZhVzZyNEN2UlNBc0JMR1pGL3k5OW1JTFkwb0N3OEd4emlEeFZhMmhh?=
 =?utf-8?B?RFpFUmR3TDUzdnRKdW5pU2VmbWRmZHNiR2FLT2JrdjhrVXRDUTlNQXM1V3px?=
 =?utf-8?B?VzBUdTlXWnBGZmljRnQ1VDM5WXRXM1pZbkN3SGZRWXlpTi82ZVNLM2JDemll?=
 =?utf-8?B?YjkrSk1kanpFTGhRSE10REN6SUsrU0R3SDN5UDNGVGVJWHZqcVQ5Rk9QUHNM?=
 =?utf-8?B?SzN4dW04QkRpWjhGVzFsaEdzWGpVcEkwK24rMHNrakxKMnBjV0paY3JRNjBm?=
 =?utf-8?B?MUNwZGV2N05wdHFBQXV6SUcycUM1MVZIL3RkVXp6dStaMFZHN0NSTHNHdVF1?=
 =?utf-8?B?ajZrTDVyT2h1Q3BhU2FuVVJwcWRMOE9TckQvcXpYcDk0NXdKeFZxY3FseUNP?=
 =?utf-8?B?V0xXRDFKSWVPR0k1Rko2UjJLdHlQMU5hU2RsVzgzZ1B4czcyb3o0OXhCMzlV?=
 =?utf-8?B?N0lyRkVQUkwzSEgyT2pXUzc5bXJ2R3kxS3FWbm1VSnNiTkc0MC9ubmtjdnNo?=
 =?utf-8?B?QUpWVy9DNkhWeFFlM1dZc3NkeVU4dWtranZERGpPTnIraWl6QWZjZUV0YXJu?=
 =?utf-8?B?QUxoeDlmbENnejJFWCtvZXV5cVlMbHd3K042L01PQmRVUm8zajdyMWJYS2ZN?=
 =?utf-8?B?YitleTdVSkQrcHJNZXJFb3J1N0dSbDl4VXhUN1p3aGhud1lHZ1JWbmNtczl3?=
 =?utf-8?B?ckNiSjBYOXFvQW5ZcmhnVTg5SHFOYjZhVEUyM0dieXlSNko2RFJxNzdNZDZp?=
 =?utf-8?B?bStwU1VIbnkyRTNkWTJkbEZvU0g2SnA3NTBJMnF3cUY0RmlKV0hIZDRNbjNP?=
 =?utf-8?B?VGxsUnorOTJtWjl2U0hET1hPNWpIdUVVaEJodWp0NG1yNEhSQkhyQUsveGtU?=
 =?utf-8?B?bTNmUTJLRzBsUmdpRUJ1SVpYYWtSS2lUMVFKNEptVDVWdnNDM0lGTmpXMzFY?=
 =?utf-8?B?THh1cnNmdDdkUDJoanBYN1phWjN4dlY1UjVJMjlmejM0YmVIL1NjR0Uvbk1R?=
 =?utf-8?Q?Z41T4hE6+Cvj1SfaFh77+wcTB?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	u4fVmLww8M05Wtizkj5rxt3KZIk3aslr0kMYN5JkPzlMks21x/C0VOelCntaCoRBFFt9/hL4E2dpPmSHGqsYRoaweuoXEmliOcxt59RbSkjgEMMBG7KcXbwGRH8zbpGMAXw0FuQHoQePngDB+xURhuo0hMMbdm8DMPhotJTjtUOWbByr6zWnw+5d9igiXU6tQQSKdbNT0wA0Zw1gqYR0uYB4adRrZn3+sIq5iiOufXdI6/7hM1dWJgqeapkmaNB3tkQxSaKCzFlJEpCm3VaXVwA+rmSi+sGYUMMu33Cq7CNK9bD52a5rznZpHCOyOjD/b85RY/ui7Te7lS4EQ6KL8IUckrQSkz9DRIlhxWt6bho8u0ZRUVCDNAuQ+4Lpo3Nxx73jUTXDm2deRHFbjJBrxcYKV+tS4TcugMG+jpJiDqWW9+425C5FV8qQaU8E7BU8KaI9GzMxdLZyl67a19+O/6De7OdeS9dPcsHIeAbRgpsv65cBHuJiIrTsWEWoO4YsDPKZcjt+iKeqfsYIIuqrFiIS6/OKkCVdn5pbBDmKJ5kbVign7sBS4MjPd8AHGfEuzXPoOc4I9pituwnZKNcsFz/5JdKGZ2h0dM1r2wojJds=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 195c3c1f-3e28-4e8a-bb4a-08ddeffb6ce9
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 23:48:50.1545
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iMWKQvoXmjkoxyEC6Tu/oPMUN+cqvh/MDNV0BU3PtU5ZxC4XCAY9+5NgtY4dvhKVhLqoCTDa4kG59z1oW4ld/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4558
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-09_03,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509090233
X-Authority-Analysis: v=2.4 cv=QeRmvtbv c=1 sm=1 tr=0 ts=68c0bce7 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=wkDz2F7hEXnEu1ALwZMA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: B3uS6wnz3HM7SeOPDgiLsBi3nW-TaZsm
X-Proofpoint-GUID: B3uS6wnz3HM7SeOPDgiLsBi3nW-TaZsm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE1OCBTYWx0ZWRfX9jMUuBpcmjY9
 36ROuJ6IVfyusX+vGpBBFTgca0k5s2Emkwtq6gAMwttBqVogDtNAQDLb+D0bq8quNVpxEPqXXJd
 KHqEOiyJsENo9sfMueVurWD+BCha1Q+9MCdtrfK4GywQAS4sZqnPv7bCUfHEJ9nGDwRPaFRoTqA
 mDZBEBsKmk6++eCPPUuz5lIpx4w2dorgOWh4341vKiiRqy7aH38eQOWtq1PjdUzYwe8kq41upuu
 Rd6O9W0PA+dRoylzdjEoklXnrHLXFWI9pSWneoxAEldSIhvNalP7agPETS7tTUmvqEtYubm1rrM
 nUygLZQAhF/RDwohgNbMozgXO0M6ksqAAJXXjEWfsPWFR1OwQl7UlYG08f0f77FggpM7/1tpIg3
 m7yW/gqm

On 9/9/25 7:39 PM, Chuck Lever wrote:
>> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
>> index 441267d877f9..9665454743eb 100644
>> --- a/fs/nfsd/vfs.c
>> +++ b/fs/nfsd/vfs.c
>> @@ -1074,6 +1074,79 @@ __be32 nfsd_splice_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
>>  	return nfsd_finish_read(rqstp, fhp, file, offset, count, eof, host_err);
>>  }
>>  
>> +/*
>> + * The byte range of the client's READ request is expanded on both
>> + * ends until it meets the underlying file system's direct I/O
>> + * alignment requirements. After the internal read is complete, the
>> + * byte range of the NFS READ payload is reduced to the byte range
>> + * that was originally requested.
>> + *
>> + * Note that a direct read can be done only when the xdr_buf
>> + * containing the NFS READ reply does not already have contents in
>> + * its .pages array. This is due to potentially restrictive
>> + * alignment requirements on the read buffer. When .page_len and
>> + * @base are zero, the .pages array is guaranteed to be page-
>> + * aligned.
> Where do we test that this condition is met?
> 
> I can see that nfsd_direct_read() is only called if "base" is zero, but
> that means the current contents of the .pages array are page-aligned,
> not that there are now.

The above comment might be stale; I'm not sure the .page_len test is
necessary. As long as the payload starts on a page boundary, it should
meet most any plausible buffer alignment restriction.

However, if there are additional restrictions needed, checks can be
added in nfsd_iter_read() just before nfsd_direct_read() is called.


-- 
Chuck Lever

