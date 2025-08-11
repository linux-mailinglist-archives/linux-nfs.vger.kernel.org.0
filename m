Return-Path: <linux-nfs+bounces-13566-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39581B21606
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Aug 2025 21:58:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DCAC1A23599
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Aug 2025 19:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80529299AB3;
	Mon, 11 Aug 2025 19:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fdYsMW21";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="QstCFq0I"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865E629BDA7
	for <linux-nfs@vger.kernel.org>; Mon, 11 Aug 2025 19:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754942282; cv=fail; b=mduFOhd1snLZunD9tWpe3e6Gm7RBWWvtPU5f7hA5/io09f5d1EGyjvS650W+PAp6YndcqA+YRbTKQglvxNSOz5MDNuK8DRV6u4hnwgN8fDN6OjVVRIsF5jMZ5K880Vah64eHFnIe1eg5tVm3QoJ9sJgIKg3BEKw5mtVHbswhKMc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754942282; c=relaxed/simple;
	bh=rvf8EsWhgmaiIUC30UeB0ofKp+ih3fbF70GNN2yVNXU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cEeyFsCwel6Llk8UmpcGR0SsOGS7kCmfp3S1xybnwwcP4MG12jd0moD6h7dduTv92rRTF4J4tFcQ5sqlbCc4J5ntZ8fHupv2qf3jQfeG5iMFwFUA6FzJ9f2WSmOLhMv4YhTm4f042hOh6bRS0ZkilBvy53IJ5hQ9eTdXeN+aorQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fdYsMW21; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=QstCFq0I; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57BJY0ac022512;
	Mon, 11 Aug 2025 19:57:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=hgytDSYoKXtapQI+EGP8CZnWOb+ywa0VKNI2yfS7TAY=; b=
	fdYsMW21j5Wehi/CnKjoGgwAtziv6nZBCsefIu1Pzo/rhUygM8KCsWdyQzgnAXq1
	mA8YZTL3I7IyMzJLaMWgXqA5pnq3iZ8JNkLG8678A21RFpeiKYgUqKcsvv23HcxP
	EsFLz5pgStb+o+nPc9RG1uWAkYXTRoZUBR5sHynAYtTTjpk9JdlNlkWdP5rgzaOb
	+5I9eGcqZTEehDW2XN4hu6wMadC9qzRuw6pi/QVJ68/ise2JYCZK9MeEw4Wgh/ZH
	D2KUmW3y3BL/m1v61ksIkMVV1nPLc0T97zQ4mRlcPBnVKE7BWmf7YSMGdQPu5bRi
	XYhrRo5xm/Q0iFY77TZB6w==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48dwxv3b45-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Aug 2025 19:57:52 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57BIiBKA038532;
	Mon, 11 Aug 2025 19:57:51 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12on2050.outbound.protection.outlook.com [40.107.237.50])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48dvsfm5aw-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Aug 2025 19:57:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VO3yIWWxV3fv3TZEl/WxDGmorCPVxdAjv0Yf26At5M1As9fb9yGS5eLu5VHcBEK2BWutVqroA53g7prGtqiwIwdL7gIEZ6gNKZNx3fPsFrIH5xvAdOf7YdHVCrVDQjO2hV7GUUrK0k66BdSOXy1qDFUb5IeuSjRGtjoA/ymsc3NEw2Q2JWH9wUPYOWPRiHpxJydPnh+IaJrz4JnjhewnVtAgPZcgBZT0ZoEAFtDQhXnLiCoE6/p1sMVozijoGdCnCQEOJOCsHS/rTLHthFs2mYn5CD3q6RzgYFjoN9u9v2c9fpKpyq3ubaS55mOnvhjHQSWlxrmJYsCf6Pe6j5/URw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hgytDSYoKXtapQI+EGP8CZnWOb+ywa0VKNI2yfS7TAY=;
 b=lmCzU/sWgS9TB5YBTBXtfFG2pXW+eoYP3bTvqWQ4GUKfzRxBU17grF7sMv3Qpk3XsVRFIFtoBo/t6Jx//Q4PyMNiZu+HEmuvrKocjxdcwI+QQFtcfwakGZh4uLDNNNDRRASaANHjnFvJidlzZ2bjg184V9BXu38Ju3m+YM4RyRlHAfv8Uwzfw1DOo0QWOkIJTBfRBIiAcPByWbg2lTt7jQU6lXO+NMmzneZ6R6g95/w7iqyCzbtv51kQoFmSz8g/0zgNusmUM9EcigZri8VTuTcRGk+2X/5zEwMk4M+CYsqPkx3l1NOlisbPhainA1z90ms+hqcM7/NGUiD5GGfhxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hgytDSYoKXtapQI+EGP8CZnWOb+ywa0VKNI2yfS7TAY=;
 b=QstCFq0I4Z0sndgy0bBWTSa71Zxa2PtM2Xl4pVlfB+nu2A/WQt2FqEGeYCQcZtf2J9/Gy3ztJsbCk9frd3S49SZxtotBgg6kGkagnBWmCuOAliHsHw9kPtoTnidQQy7YBT/9EX/ssLVZ+vkrCjy+lWr26qxJtWov3o0b74AyhMI=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH0PR10MB5065.namprd10.prod.outlook.com (2603:10b6:610:c5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Mon, 11 Aug
 2025 19:57:48 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%3]) with mapi id 15.20.9009.018; Mon, 11 Aug 2025
 19:57:48 +0000
Message-ID: <5c4a6471-2cca-4301-b747-7968d853a51a@oracle.com>
Date: Mon, 11 Aug 2025 15:57:46 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2] nfsd: nfserr_jukebox in nlm_fopen should lead to
 a retry
To: Jeff Layton <jlayton@kernel.org>, Olga Kornievskaia <aglo@umich.edu>
Cc: Olga Kornievskaia <okorniev@redhat.com>, linux-nfs@vger.kernel.org,
        neil@brown.name, Dai.Ngo@oracle.com, tom@talpey.com
References: <20250811181840.99269-1-okorniev@redhat.com>
 <20250811181840.99269-2-okorniev@redhat.com>
 <c7bf2dca30c1ac3c947da3fa9ee537cf3b57536a.camel@kernel.org>
 <CAN-5tyFbT8zR7mXL1bghSObya+nkynmNKBvJocteE9QnpweVUQ@mail.gmail.com>
 <b64743eaa10741aaac9ab7d7b20beb06e85d6447.camel@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <b64743eaa10741aaac9ab7d7b20beb06e85d6447.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0448.namprd03.prod.outlook.com
 (2603:10b6:610:10e::11) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH0PR10MB5065:EE_
X-MS-Office365-Filtering-Correlation-Id: 126f07cc-767e-4a7f-f6fb-08ddd9115898
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?VUR0T1gydGJ4SmxkM0RYVG9FanJCWUdBZEhlaUR2TXlvMmZZcHZtaDBmQXpK?=
 =?utf-8?B?MHl1Y3prMG1vMjBCTkU0WnA5K1ZDYXpGclFnUTVRNm1aUC8zNCtlcFZwNmlF?=
 =?utf-8?B?dmtJM3AydWNvMzg4R0JjNlZlSGRDNDdYZmdhRkh2dnNWay94QlVXM2lnTjJK?=
 =?utf-8?B?N1ZTZjNsMlVkN2lVeC9pRzlRNkloS3N1MTZVRDRmai8vdTNhS3hiRUcxenNk?=
 =?utf-8?B?N00xMGw2ZTJzTURPSzZXak9GQkt4NmZHeXQ2c2VyZ0cwa0J4RTcvMERLMHVo?=
 =?utf-8?B?SW1xc3FPT2tXMlNIQU9scFZSUWluSEZyc1FWTmZtOHZPeEo1ays4WDFvYW5h?=
 =?utf-8?B?SlRPaWJlNlgwdjJ3TXJGQzZ5Q1Rhd1lxc0ZtcjVmdDdDMDVzdVNYTXhZVE14?=
 =?utf-8?B?S2RsTjJrbm1qM080MmhuSzNTTnQ2ZHE4cVNya2kwTzhzNVZaaG1xRmFvNFVm?=
 =?utf-8?B?VENWbDkvZFJpek03b2ZkQTVVeCtGdVd5UkY5MHUrNTdFSFBDRkprblhZYTdv?=
 =?utf-8?B?V0EvbWRXcVUxVTBsUTZlMjczV2dvVHd6cnZrNFVCb3ZSWHhFbGQwMUZVK3Fq?=
 =?utf-8?B?R01jMWJOOEFIczRValRpYWxtWVdpTlI2OVhqVFIrSDcxdCtjVEdHcXhxd2lm?=
 =?utf-8?B?QUZDb1ZGMjJrZEtDYWZBalVvSXR0OVI2MUJrSTgrdnlNa0p6d256N3F6RjdW?=
 =?utf-8?B?VUNyRjFWaEhDWVlQclkzemJCS01sbDZGak02TWQxa1hMeGxnWnRlYkxqWnBp?=
 =?utf-8?B?QXZ0d00ya2dNV1RndHdLQ2s5RTlVdURGRk9wV1ZuRGNKMW5PQWtlVWRCcE4y?=
 =?utf-8?B?ZmJtV0xxZkFxSUhlOVVRVlVYclZvdlR0dUtldjlWcC9Qem1QamYyVzB5U3o3?=
 =?utf-8?B?c1ErZ0ZkY1NoQzNUb2NZVzNVa2VBbW9wZURPMmlhS21TU21tSUNRYk5KSzEv?=
 =?utf-8?B?TWtQUWZDclkrMHU5eXlMdzdCMGpPYWt1T2NodHpRUFhFdGtUZXdlbVF5Zmxs?=
 =?utf-8?B?VG92d25NUzRVcGEzWjR5TmJoOCtoeGxYZ056VTEza2IxaVNJVEFPV3lVNU0z?=
 =?utf-8?B?N2hUcEZCWlY0NkRKb2w4WVhtdHFYaU9nRStuRkQzQzRyNzFpVndIOVhFYUlN?=
 =?utf-8?B?cERTZGZLT0dJRUg5UGdpMmRaS3huZ2FUMEc3eWRtVngvV0tXYi9tUG5ZVVVz?=
 =?utf-8?B?ZlJ3cFIwT0pIUytNbnRJUUovdTRFZEhzaFZBYTdRU29hRU90QTBTTWJiYmtp?=
 =?utf-8?B?QXcwekJCVlZ0Q1MvV0xUSkY0Zkp4OUc2WjA1SDFXV1djeERhdlBxdkhjRGtk?=
 =?utf-8?B?VnA0YTJFVEh4TGNkVjNuK2tBdmtINEphekNadElNekFMUndSSysvUjJzb3NQ?=
 =?utf-8?B?OFlXN0FPU0M1YmZFUFJZOVBIV3crSjJ0akRaVUZ4WHI5eXRJakFmR3ZhL2U3?=
 =?utf-8?B?VnFVSDViWDUwYzY3UTdKZUd1bGNtbVZjUGRXb1BveFZXVGQxQktZVmpzN2xV?=
 =?utf-8?B?ZmpmVHJqcldPNWFTb2lueWxGZTk2bUFqMGlvTXBkUGNvUWU5aTk3UERmZ3FX?=
 =?utf-8?B?V1cvdHYvNmphYkd5U2o5R3ViaUZzUjlxdE9IM1FPcXJhN2JucTFtWW5YVE5J?=
 =?utf-8?B?QWswak9BMTQ4UjNuQ3M2QnM3cmVWNXhGb0grUlphcDM2ZFhxemNndnJvYjNN?=
 =?utf-8?B?WHlvZ0grcnFMRXRGd1hCbTNCNjRBdzhYSDF5VW5ONnd6cEJSYU5UaUxHc3VB?=
 =?utf-8?B?ci9mbjdVa2ZMU29nMHFMYzU1ZnR2ZEpZQkFMb25GWE5rWGRSTE9QNUNwbHpR?=
 =?utf-8?Q?nQ5R4+Epp/5OfpTqmLDlyn2RG8szlo06yjEcc=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?Umc4OFRIS3Vrbk5EcVE3RTlWa29SMDI5ZjRyNkVJVVVTWkNsYU4xWGNJd1RW?=
 =?utf-8?B?STl4anpJbDI4WVNKSWpxVXFvK0FyUnhsaTVIb01JNnFPYTZ0NzV2d1A0WVdU?=
 =?utf-8?B?SWhzNWgwV1hWY2ttbkRRL2VwWTM0bzF6RHhXbEVDd2xrVkw4SmpKZ2FuWXZH?=
 =?utf-8?B?S3YyOGVxNkdZTjgvc1lBVXB1V1NZQ3RJU0Rhd2ZHeERnWDcvcEZpLy8xOUpV?=
 =?utf-8?B?Tkt3NjNFYjJzckRkT3A2a3ZvUDMvNjl1TWtSd1ZmQ2dwQUpLV0VtVW1BandI?=
 =?utf-8?B?ZTYyWmhOa09wUTVmZkpXSVV5Y2RkUGg0WTFaSzFYNUszWDJoaW5sRWVuS1Fu?=
 =?utf-8?B?OGExWCs5cUNLWTh2RDZVTDZIM1lYZDQrWGtBSTJXbEhTQUxtNjJsbXJnQVF2?=
 =?utf-8?B?bEYyRzJ2NzNjbDVjZlIxYWxLaUhmMHRXUXhtS0xyTkMyenBaT1dLM3REbW4z?=
 =?utf-8?B?THAwdVJFaVh6bzFNaXNINlZqWCsvUmVBVVJqc09Nd0F4ZE1xcmdKeG45S1Fq?=
 =?utf-8?B?ZTFwMGNZc3ZkLzNueTVWaWNwT2IxS25vOVUwcEdXVTI3QmtKTmxxdWticEJj?=
 =?utf-8?B?K0tuQ0tDZXZCREVYU0NTV0pMbFFaOVB6aUJBRGw0T2VQdm50MzM4OWhFK3hR?=
 =?utf-8?B?TWdtUURlTmhGTkVMelhYY1VjYzBXait6KzcydnRMVTVRTHFmNUpLbmlwSnpE?=
 =?utf-8?B?cnZHU290RUYydWNMY3RhMkN6VEVnRHhORTBmSGNUMWFXTHFtNnpvaXNKVVRo?=
 =?utf-8?B?aVZSZ3FnUkVrQytmYlArbUc0WWZmVUprYXFXZHJNY29Cc25KSTVRNURFdmgr?=
 =?utf-8?B?WlJEYld3ZU02WlkzbnNZeFdQTWhBM0tpMmlVMFFlRjJxVm4yR0syTVdQZXF6?=
 =?utf-8?B?VTh3SEFKcUJ4Ryt0MUJyRjhZbTQ2aVJvekxNeHpjeDNMWXlqZjBDeUlPYW0y?=
 =?utf-8?B?eGE5L3F0dGhiMGFXOTRGaFlIcXduZDJEU0ZURXlaK25QQU9sZjdFVFV3OExT?=
 =?utf-8?B?UnlEVVZHZkxZVENKMkovMVRRcTJFVDBJanN5d3NqSzVoVkZGbVJpMlBoVm14?=
 =?utf-8?B?WlV5OHFCTXJrZlcyeTJvbVc4cktFOTNJclVXU29neXhSckpETUg2ekpHMDhD?=
 =?utf-8?B?aWE3aVBHS1c1T0pnOG9RY2tQY0J1WkRiazB4SFNuOFJPRk1ubDJkR2U4NGRt?=
 =?utf-8?B?bngyYk5aYjR2emMxTTB2a1NXa3h4VkMyL0Uvd1RoMGhGcnBkdkhmMzI2RHR3?=
 =?utf-8?B?dk50WnM4bS85UURoM3QxUi9YcWFwQll3WjR4TFJDNEM1cVFRVDJ5eDl4M1dE?=
 =?utf-8?B?RUxqRS8wdTkrNFBWakN5dm56VGhtZGtGUHdtMnpMY0ljQTQ3Q0V3bUR2ZTI3?=
 =?utf-8?B?TmRYVHZxWnZjYTVqTzU4OTM1TzJxYUhObTJGZWYyNWZmcUtscjEvMkV2cUpw?=
 =?utf-8?B?OUZRcXJzZnhud0tJMmg4S0lqVDBqSFJnVDQrMDFKQW1aN0ZINEFBZWl0VmFK?=
 =?utf-8?B?aG1Bd1BDbE4vTUdHY3dsT2xjeFUyK2o2bnJzZGtyWUZyQkFJS1lqZzNsY3VE?=
 =?utf-8?B?RTZOelNNNS9rYis4VTExOEE5c1BLR0dLZzB6eUp3cG5nRVRjem1rZlJWWUw0?=
 =?utf-8?B?OVFqMkpxRVpTdTgzYkFHNEhqVkVTQlFseEt3Vjc2NitsMzZmbEpzQUdoTkdK?=
 =?utf-8?B?Ym16a25DZ2w2eFE2cUV5azdLbENCUHVOTnpoNlZqQWZhalBxTFFKa2lhWEhq?=
 =?utf-8?B?eHZNM2o4Mi9HRHUzbE55alZXRDRnZFhBS29HT2wzbzVHZk5EWkg4OHg3ZFd0?=
 =?utf-8?B?Qk10TUNjMWM1bUNPTjJKUkFZMENzNldnQ0RlcEl2Z25ldEhnMk04dHlCWWxW?=
 =?utf-8?B?TlA0elpQbFByVlRLMC9SSGtkWEtSY1BOdFVIaVZqSlRBWEhqSXpLTTE2VFZk?=
 =?utf-8?B?WmpXQ1llbE40alNqS0JJa291VFhYOFN5SEJGcXNXeGpUNjB1Z3pjeDJNNVpL?=
 =?utf-8?B?TDBXOE9IZ3c4a1hobFgwQkxXbXIwZGJueXZIZHpLQ0NRUDFhSGl4THdOcmFm?=
 =?utf-8?B?Y3BKSG5VaTYwRnhFSTRZcXpnbVZWUUc4d2lWdDNzeXRUYk9DVjdKUnNZVS9k?=
 =?utf-8?Q?1+7D5iEcZalw5UBkX1yjry+es?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ypqB2CzwdvMwKdZEZYcqBeZa3QLrtJgZVnxf67ZFVPkJ0KUC984BKDu/4S4s3GpJJ67iDJGhOM74Fd++/AgmXsOuzJivwsqecUkq2c3jeXDWgRl9KLjGd3trhE8qksTlifOPkoyoRwYzc1qDnd9qWIFrquDJSt/PBATrAjXr5qgaWHzX92j5MsVYRyVPXi+Q+w5PpbuSfog6VZSNbNAJjPfDgQn0a3vKGGnD2A344DLkWOM7PgZzS1h/3/J7pfCUz5dq7tWvFJm305Gam2TA+CAx8ou04NgYKWsfhB1TjPtLXDFyYOjR9FJjt33j6N1QlW7O3XSs2fMuodlIQGSd9VHHv3N+VndH9UwNG6o7cjVStLUFBy+D7at+pjhkYPez3+K0ibCQaboVGvMyXhoc95e5JbAEqlO4BH0twxTlDO8XsDewabtnlm8jlbMW7P0RBS7gCpCQzaXEAw9aRM49EttJqd/Gm8WoiPoZ7ClfeqHZtBqD9rBTGwhwx7QpxwktyI/gF8VnUea7/FzwKyHKsIonFxa4winkJ/6mnMS4kuEFsQlwHREnOhm1IauuYXzNiIefR8JhP48nFjDiGb2tpypWuQnzDPA8CHHNW34KrSU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 126f07cc-767e-4a7f-f6fb-08ddd9115898
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 19:57:48.1797
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cYdSecnvpC0XCkhwP4TBXTt/JJI4zcfESqV/kNVQ/Wm+43ccbHyU9b8AZSH1yNHKx/67psSXqY5Ybu/PUiLM+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5065
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-11_04,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 phishscore=0
 spamscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2507300000
 definitions=main-2508110134
X-Proofpoint-GUID: 9UvI4t5h5ESRMvLu75NU3jROJlBBPe19
X-Proofpoint-ORIG-GUID: 9UvI4t5h5ESRMvLu75NU3jROJlBBPe19
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDEzNSBTYWx0ZWRfX6xUdum7uvrwt
 wlzaB6/Q/R6skscGStpn7v283AqWHyvSuhczMMgbZnTVsW4ab9HWFVlWueYhB1X6oSnT3JB2Uc4
 CPwm4ClAfZIGGE1W2oUvUfTk0tkOgpdPAB8JQcvHVN87jHcAdZgb6ZzErnUV0EGVVm9JXs/4jVI
 75s9rOEZkpBckubi9QUzFKZcAyKnzcVjSaNv22ld8HjaTKegx1iwhbW/QCL1Bi82wwmGftTj/2w
 e2SfBYC12GjSbwp1MwbgOBVdxpH+Sc5ZAEljRpPc1PaE+xaSlR2Jf1NTD97UEGoxugCX/M4VZC5
 XyWWZw1mgbmcnjjdkvybMBGjHMMhJDgZ0An/EH64iFdNyDB9rKePI1cZDK+BipDhlscF8VLoC9b
 wHMsEL0PjM4NQIfmWXHRisJ9NeaqZCuPCN6haWcPAe0ku0U71xIvlTpCg93Zlvyz9vfNrhNN
X-Authority-Analysis: v=2.4 cv=KJZaDEFo c=1 sm=1 tr=0 ts=689a4b40 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=uZvujYp8AAAA:8 a=VwQbUJbxAAAA:8
 a=20KFwNOVAAAA:8 a=kjanlvFv2yV3Xow3jyEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=krB-96SuNSwA:10 a=SLzB8X_8jTLwj6mN0q5r:22 cc=ntf awl=host:12070

On 8/11/25 3:56 PM, Jeff Layton wrote:
> On Mon, 2025-08-11 at 15:32 -0400, Olga Kornievskaia wrote:
>> On Mon, Aug 11, 2025 at 3:10 PM Jeff Layton <jlayton@kernel.org> wrote:
>>>
>>> On Mon, 2025-08-11 at 14:18 -0400, Olga Kornievskaia wrote:
>>>> When v3 NLM request finds a conflicting delegation, it triggers
>>>> a delegation recall and nfsd_open fails with EAGAIN. nfsd_open
>>>> then translates EAGAIN into nfserr_jukebox. In nlm_fopen, instead
>>>> of returning nlm_failed for when there is a conflicting delegation,
>>>> drop this NLM request so that the client retries. Once delegation
>>>> is recalled and if a local lock is claimed, a retry would lead to
>>>> nfsd returning a nlm_lck_blocked error or a successful nlm lock.
>>>>
>>>> Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
>>>> ---
>>>>  fs/nfsd/lockd.c | 1 +
>>>>  1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/fs/nfsd/lockd.c b/fs/nfsd/lockd.c
>>>> index edc9f75dc75c..ad3e461f30c0 100644
>>>> --- a/fs/nfsd/lockd.c
>>>> +++ b/fs/nfsd/lockd.c
>>>> @@ -57,6 +57,7 @@ nlm_fopen(struct svc_rqst *rqstp, struct nfs_fh *f, struct file **filp,
>>>>       switch (nfserr) {
>>>>       case nfs_ok:
>>>>               return 0;
>>>> +     case nfserr_jukebox:
>>>>       case nfserr_dropit:
>>>>               return nlm_drop_reply;
>>>>       case nfserr_stale:
>>>
>>> This works by triggering a RPC retransmission. That could time out on
>>> soft mounts if it takes a while to return a delegation. Looking at the
>>> NLM spec here:
>>>
>>>     https://pubs.opengroup.org/onlinepubs/9629799/chap14.htm
>>>
>>> What about returning NLM4_DENIED instead? The description there is:
>>>
>>> NLM4_DENIED
>>>     The call failed. For attempts to set a lock, this status implies
>>> that if the client retries the call later, it may succeed.
>>>
>>> Presumably the client should redrive this effectively indefinitely that
>>> way?
>>
>> I have previously tried "denied" but that lead to client failing with
>> no lock just like from nlm_failed instead of retrying. I think only
>> blocked (or block_grace) leads to a retry.
>>
> 
> Thanks, I noticed after I sent the above.
> 
> I think that the ideal thing to do would be to treat this like a
> blocked lock and try to call the client back when the delegation is
> returned. That may be difficult to do properly though, since you won't
> have a proper lock request to block on.
> 
> For now, this is a reasonable solution, but it might be good to have a
> comment that explains why the other options were unacceptable.

+1 -- either a comment in the code, or please add the explanation to the
patch description.


> You can add this to both patches:
> 
> Reviewed-by: Jeff Layton <jlayton@kernel.org>


-- 
Chuck Lever

