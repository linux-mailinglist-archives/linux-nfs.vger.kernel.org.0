Return-Path: <linux-nfs+bounces-16295-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DF2A4C52EA0
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Nov 2025 16:12:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B4F664FBEDB
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Nov 2025 14:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03467340A6F;
	Wed, 12 Nov 2025 14:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aCLa6vLp";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hKICn7YU"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592FA2C0266;
	Wed, 12 Nov 2025 14:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762958347; cv=fail; b=Bx8I2V1+dvJZOP99wKGlDH/NeObmwf0eBEbjKaKoVYQ17yEQTKsOyo4NZB0vQgR01769OoKB39HM8rSF07AOdYMJ0s0aE/S5BfzZZopZF7rIdmGYqccAqyPxuNKcddy5lrwyMPiipZ9CvHxXYMiGOk5DaoRW6jlvApcONoOJefY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762958347; c=relaxed/simple;
	bh=SLeYb5zLTqKQLTcnUubJUxm8Tgd69eVKfEXSiDVgKr8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UPEol9aDJLsdzpk8A9vbcVeCjrz2aAd0UdEYbi+LyS3uWKicKQsE7RFx0IEtcSeJtYIfQx1VvbNwjq48UMiiqpja7uX91CG2rGrKBxUCTx+rM1RrsssuvAazD+mwKgwNTUQ35uvy9VTOzUbfV/r6odFeZAt4DdUmCZPQK0gYFmM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=aCLa6vLp; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hKICn7YU; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ACEYVNS010079;
	Wed, 12 Nov 2025 14:38:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=yqZYi500rZkF8oZ88ObVhF/QmRPqQmDjGz0KU6yXrq4=; b=
	aCLa6vLpf6//9EjRRpc3AL0YR7krPNDfEXBZKZ4f5kf9NL73nD4LdzWcYvdf8GbB
	xCCZqRkWqVymMRdPhD0z4FJ/+h0ukAMjnSzCpo9js/0OOcfMIoogop9gF0Z/reRF
	inPks1eEiwsDf7qr4UyVm5V+iP7XVKj7nXL2w8dm/k44rQyobTeNJritYmaKHOKv
	YpU2tOkb/HHbZZx/3q3YCklke0/TaLJ8FqwPMSLJpZmXpakm2ML9XyJK1tuukMkc
	szpyKBxorIYehuDAh7Fvxy9mVHglAZQtmrXIcljH9gAssdZBGSv/nhvVvtxVHRyY
	I78l7inNtpbfuCDXPg0vOg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4acu650601-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Nov 2025 14:38:43 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5ACEG4xo032419;
	Wed, 12 Nov 2025 14:38:43 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013071.outbound.protection.outlook.com [40.107.201.71])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vamher6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Nov 2025 14:38:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kMgAvz1EjmJfvRQ4iwzgIKUPg6HvJyFmzPxWmXOvMQ0WRe/slOXYtTA+WpUo68w4oQc15WD+S7mm9aIVCrmS5G29ddmHRiqT5LdbyB1X80lgK/6fqocC6R4izxcJXjR4rfUcqp9DlJw9q3KSQxxOnHide57eCGpJIsFMMqd/Y8psGpbkOoiPOJkIylWgojdn/sPDZqDFo60jGxEdBbEmWgfNHLni74JV4AcznMGUno5fPDQLfRL8aTcb/h/glGPQ848fCdf0/f6wwDPGBg+JkhE/vS2l0BWNA9uL5LORPHvvCb/QNZl9Ay36ueZ+JQE2nVJmyxWWHqI8oz5mmBY5Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yqZYi500rZkF8oZ88ObVhF/QmRPqQmDjGz0KU6yXrq4=;
 b=L6+bhgAEUKVm+NDNmapR2EYKmc9cSGiyLKHY1tXXtpmXsbSAOgMBFuWah9NPMv5WCRHs+F5Kw/E2qT8mOwzyARtBsZcebhFajKSjVZUoUXdw1w+APlZy6u30QTwy57vdzoSZVoeH7v0u6vF52wzeQLYBm4dUo8jdK3AWi5MlkUhc7tUWKdtAuLC323yiBjU83XnXA4YXMvIPNdDtMM3ZaZk+kWBDWZ5x5pscTxnXKnddd0ihSpoWjIC5jeWCX8p1rEu3C8gmfhC8gdMFO0QMBzACxFcx86KjS9+cuBMuzHryYyfFoNA6gzL7hpS8jC5+0xh/Pb7k1ijysKWiwQNFNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yqZYi500rZkF8oZ88ObVhF/QmRPqQmDjGz0KU6yXrq4=;
 b=hKICn7YU2Nv4t0rZ5VjN51a3Cgsus0kFGEEgi0obX4pKtJYzq1U9aneBB+Gob1dRPy+xVbptflEjBvv3zPnrH703Rd3XcdUlTA27jSo/+t4Ci/ugX7Mscse6FAqrhfIVUdCnRY1syMyyCRqtJG4xCV/tNwxb+PibVNnTbpmnEKc=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BY5PR10MB4353.namprd10.prod.outlook.com (2603:10b6:a03:201::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Wed, 12 Nov
 2025 14:38:38 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.9298.010; Wed, 12 Nov 2025
 14:38:38 +0000
Message-ID: <74bfc555-7ae3-4d2c-bf53-c06bacab5caa@oracle.com>
Date: Wed, 12 Nov 2025 09:38:36 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/6] nvme-tcp: Support KeyUpdate
To: Christoph Hellwig <hch@lst.de>
Cc: alistair23@gmail.com, hare@kernel.org,
        kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org,
        kbusch@kernel.org, axboe@kernel.dk, sagi@grimberg.me, kch@nvidia.com,
        hare@suse.de, Alistair Francis <alistair.francis@wdc.com>
References: <20251112042720.3695972-1-alistair.francis@wdc.com>
 <20251112042720.3695972-6-alistair.francis@wdc.com>
 <20251112065925.GF4873@lst.de>
 <f7dd4e03-352f-48ba-8a0d-ab9e793ef385@oracle.com>
 <20251112143804.GB2831@lst.de>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20251112143804.GB2831@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0432.namprd03.prod.outlook.com
 (2603:10b6:610:10e::20) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|BY5PR10MB4353:EE_
X-MS-Office365-Filtering-Correlation-Id: c59c84ef-6162-4e96-76b9-08de21f92af4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?alFYdnN3em9HQTRNZ2czNEVVTyt5V005SFBRMStIellkalk0RXVtQ1VDdU5X?=
 =?utf-8?B?M0g3RGRLRHBnZTRWRGlqaVlmQytWczlKcnIxMDFBNHdUM3lwRjdQNUlJUGpL?=
 =?utf-8?B?L2ZFQUxlUjg4eWU3RWtNNzBwOWtDT1RyYmV5WUs3b1A2SmFzcXc4enJhUkhJ?=
 =?utf-8?B?VlhsS0NobGZlUnF6Q0kwL29KeTNWV2hnSnpQNnU0cmdDWUtkRktya1NOakRp?=
 =?utf-8?B?b1ZMbkpBSG9ydDdJT0JmeVozWStyZ1lSSFdmQ1JERklmdjBJejRUVkg4UmVQ?=
 =?utf-8?B?U2dselFvN0wwT3JKb2p0RWo1VVVMQ1VDVksrM2JuMFhwdGxzUm50cXZVZGsx?=
 =?utf-8?B?S3hXdDdCU2ZhOEhva3NjN1JDbG9EUXEvV0VuVjZ2RjJqRkJvUTE2Njg1aEZx?=
 =?utf-8?B?VWhtcDJLT3pOdFpZaGVGOGdCY2l0RVlrZ3lMV1JzVGN6WCtubVRBdy8wMDJS?=
 =?utf-8?B?L0NidlZaUG05akRFQ0I0bWpVa2tCK0RtODVzOTRKRXRlL0VzRUhRTFV1R1Y3?=
 =?utf-8?B?bjdFN2hocVp5R25rWDQ3NnRnRWxPOUhTOFV6VVBkR0o3MytRTWp6bUVFY2F3?=
 =?utf-8?B?d2cvZENyRVdiclhIZ3ZHT0pLaW8va0c2Y0JvQTBFaDZYOS82OVRTbm1OcEsw?=
 =?utf-8?B?WXJIeTNvUXRMSlpSQlhiTFpEUm9pM0M0OE5ZcTRJWnU0dnJsdzA1eXlpREgx?=
 =?utf-8?B?Z1BJVmR2Y3ZpN3VUc1lsNjkrVTQ5VHBKeGhvUGdybU1zcGZJNnJaL3B0SjIv?=
 =?utf-8?B?NktuZkJwcUczbyt4NUFBN0gzWG5HRWEwQmNLNzA1ZGFtRkkvOWdydURCeFBC?=
 =?utf-8?B?MmVKQ05zR1dhZzJhdnl2a05keHEzWXBSdXpzY25kTURHRnB1RjhsWlFzL2ph?=
 =?utf-8?B?cituSDBJeGxuZVBnOUprZXdtMC90YzhDUEtDc3hUQlRWa1RHNGpnVmZ5S3pG?=
 =?utf-8?B?a21vRzVKL0ZaOEVaOUUwQjNFNXVaMEF1TVBQcWVISVhmekhpYzkxMHAxcW5G?=
 =?utf-8?B?ZDloVUFvQ0ZCNnA3U1hZcG9heGxEZktSWUdxMVFDYllhRXBYT3lMWG9UYmY2?=
 =?utf-8?B?VHVDbnhFN0NpWHVTZnVJTXl2R21nTm5pL2N6MVJNZjVYQjlXTzhJbGc1Ri9L?=
 =?utf-8?B?L3U5WTh6WTUrb21udlF1M3h5UlVMd2l4anFlb2Y1T1NRMHlJck0yT2h3aE5i?=
 =?utf-8?B?QktySk1KQzhOaHFEQVJBK2hHWVpKdVZYTWZQbllVSXNEQlJxSUtuaXpRbGtu?=
 =?utf-8?B?aXcyUFRyYklXK1ZnME5JQTJ4Z3B0YmRONEJoZEhLZXpvd1F4VmordEs3TmNO?=
 =?utf-8?B?K0hzWGl2OEFnTzNjZkFPem5tL2ZTa3JYS1J6OXRlb3pHOGw2Y1UwMTBsc2dH?=
 =?utf-8?B?Mlc5dnN1aHMxNEJDd05Zdk1oRm8wQ3k4eFVvS1Q5b2NCVzVtMzNGUkZnTVM1?=
 =?utf-8?B?MWovTWtXOVF2NEhIRW9rNWRjd2cwcDhjV0lDRUFSbnI1VVd0MldTY2VmK2Jp?=
 =?utf-8?B?RmdYVHdwNkE0cjdaV2ZsWGJmVTB2VWcwSnhrUFpkVlhVRGFQeHg3Z3VvazV4?=
 =?utf-8?B?YVZPNlorZ3FjQW82WU5sYmtmODRTcVczZGNIdXUrRmVNVXNjaE10Q1IydExH?=
 =?utf-8?B?U2M4RFlXa25SOEZmN3NXcGVFR3NJS1AzRHZUekJKY0ZsbzU5VW9SNGQ0SDMx?=
 =?utf-8?B?bGNzY3VxRTMrK0VFS3ZvYjMyWEJRY1A4THhncmtnUHIxTlFMSGY0a3RSb2hQ?=
 =?utf-8?B?R3pISS9MS1daaGtsR3dDRXBGbjlEdU8raFFXWndodDBmL0RoWUJqTkp5aDZm?=
 =?utf-8?B?QmlCV0QyM3pkZEcwS0lBM0NuMkJwUi9jM1BKR3Q4cjN4SjVBNWUwajFjRHhR?=
 =?utf-8?B?OXYxRTIzbGt0SkVCcERSTmdZTEpJb0ZVcjJGVTY2Zm1xM0lWNXVLbnRKSmNi?=
 =?utf-8?Q?x7LRjjak+nWdnJqg0e0rn14iNxlVGIN5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NnpCMGdaSkhXZ3l3WC9waFpNenBaaGp0azl1SW9GNmtYVzNDaXRyK2NOamZH?=
 =?utf-8?B?b2xZRk5QNWhFRHA4UUpTaUpwT2tsK21LWUR1OGw2QXF3Y1pmcVVVa2t5d1ZM?=
 =?utf-8?B?bnpLQll1SHFJZGM2c2xrUHBBdTYvYkpQNG9xMytiQlZTME9UYVhiVnpSVkRP?=
 =?utf-8?B?WXN1S0tqNFNiWmgyVFZVbUsybElFN3U1VW9YT1J3QnZYL1Fxb0NiRmNQWG40?=
 =?utf-8?B?aDJKVm82OWNrUVZoeC85eU9ETzluVzlnTXFGbkdnWnMyc1hadEJGcTZhU29m?=
 =?utf-8?B?UUlpMHpMMlc0UVphZWtKVjVtTHNDeHhjQW1aUnhkODUwWjZISjRCWGxZeGpJ?=
 =?utf-8?B?VGJyamsrNmEwV0NSeFN2cHJjUjI4UVZCYktuR1FlcFU2VkZVOEdraUJ5KzZ2?=
 =?utf-8?B?ZDlzNC9yVU9TVERHL1BPOTljU2VPeUpQSzBFcFJmQTdpWUthc2k3eUhjdFN1?=
 =?utf-8?B?TGpRODlWNUF5UUV3UFJVb1RMRGhGcVNMWldIWCtqU3FBOUdkQm9xdjhxMDVQ?=
 =?utf-8?B?UXM1YW5GczRId1lqR1I5eGRwRUtQS3diWTNIbTA0ZFZQN3pqc2h2cmpjMVBm?=
 =?utf-8?B?Z2loVHhmZ3ZRUTZSeDRGaW1MWHU3M3prdFhDT0prZ2JLVXJNMVVYejZvSFlm?=
 =?utf-8?B?MGVZV25sa29BcCs2ZEJQSWtlTU5KUVB0L2ZuVGlTb25EQTI0ZFE0MmE3eFQw?=
 =?utf-8?B?NkJnYTRZS2pZZVRYQzYxRW5GamUvVmtsZkRuQmd0Tmw0RW9kbFl0OCtrbTQv?=
 =?utf-8?B?c2hYdFlXb0xVckRpWTBaRVEwSk5CdDlOejEyUFZ3czV5SXlSUTJmSTFRWktL?=
 =?utf-8?B?MUxuQjZELzFCR04yc3NyUnhaTU00YTVnbnlpN0xtOUcydjE4Z1hxbU0wUVV4?=
 =?utf-8?B?VXZLZnlVSFFWWTJmMWpBbEFYUERSUkZnOHFWd0xIeWxSTEMvMGp2WFlINmFk?=
 =?utf-8?B?RnQ1RVdiOThIUG40bDJIbGNmNmZRdmI2ekwvRjBGdlhrT3c1Z091NlJLQzI0?=
 =?utf-8?B?aHF6TklkK0NmMEdIc0dPcThTSmtyeTZIcHpMMDZ1YXV2VFNQbTM4K3UzaC8z?=
 =?utf-8?B?MDVyVkRIWDRmY0V5R3pJd3dtY210ZERORytyMm0yRjlBQnRYNDhaSFlFcitp?=
 =?utf-8?B?MVhtaS9nSzBKSTBlb1U1cFo4SHZYR3p1YlRSRm5oSjlwNFU1NUF5Qlc3WXhV?=
 =?utf-8?B?aTYvM3BwUUZ5WHpSZGhicXRCaU5zYk5qTnBQbXlBUmVaVEpBMDBVUjBocU5q?=
 =?utf-8?B?d0NHZFhubWNjSWkrNGhCRVI5UzZwMVhSLzJMa2trNkpESldaSzZvaEFCZmFX?=
 =?utf-8?B?eWp6dFZVUWh1NFQ3QlBQS2ZiQzZnWk5weWVvOG9tc0dIRk85ekI3NTVQTWtN?=
 =?utf-8?B?cmRkMkw1dGlKdUV4QVQ0QzRvbENzR2VIU2dQY1BvUGtoRHNZQkhXMFZweldB?=
 =?utf-8?B?L0hjNFN2QmtuT1YwNmNHV0VKVVU3OVBoT3dRZm1Ub2FhQS9ZRmNjNUZ6Zk4z?=
 =?utf-8?B?QWRkaUp6d016blgya2YrZGl6YlBJT216YnA4cVk3d3QzcW0xWE5iZ3lyWU5D?=
 =?utf-8?B?SzlkOGgzNmFMTGpWdGd4YmRZMzk5Vmo4SVVpVnJxSjFBTHRKODRjQ3BZL2pq?=
 =?utf-8?B?czRjR0FSRFRqVjF0dnZMdXg3VnVrRFlEWGFvRStNVjJEUjg5NlhmcHByOHpK?=
 =?utf-8?B?Sk1ib2R5azVkMlIrRy9TanV5T212UEY4Yks4bE5sUldMb2RvRkwzNFI3YUFw?=
 =?utf-8?B?bHdLN3RVendOQi9sWDF3TGExd0hKYmN1eGhGRE5paWNtdGc1Z29iL2wxenF1?=
 =?utf-8?B?TzcwRnpoV2FLOWw5UXhFU3lXcU5QZHBYamlPbkhFODZPVEVvTm54MkJpbmhV?=
 =?utf-8?B?QzlxVDNCbmRwL2F6Q3lLMlA1MmM5OUw3WkVnbWtKVWNQa25hemp3Z1ZVb0RF?=
 =?utf-8?B?OHhraHNHT2V0MTduTFRTanBVTXFWLzc1SzRIMjg5VDRsdFVndUhDN0xPYi82?=
 =?utf-8?B?bHE3eHZVclNISVQ2K3d2MTJINmtqWHl2OEREaC9oLzlIbEU5ekdVRy9iZ01O?=
 =?utf-8?B?MXNxRUZNVTdrR2JUK2NOTmpjd0pYRTdFVW01MnV5QXliMlpMQ0dhdFgyMlJW?=
 =?utf-8?Q?oz1JVRRjTmyL7kZQe/s6GL9aA?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	p+XhRld6gdq/krtdt2E1PzhEGGFQ7R3lisY+rDB2UjgHOPKQnELfBiNf0s13G0Iip2jAkUM9xk6HTjQ4K7Ltz8qJp59cmfkjGjM7QgjrcMeNc7o4Le7YYVn2om0AZPR1LnW6j5LtJt5ZPhC4pI238260kzc18sf3dYPYF29fojgKft2tB5emlrqiDu2p3eYfRgZh2rdpxvifK1eLBSQzmjXqPxUnNriXcv6f1rM2UozTOATiOrQBdOrvvRPGu7rORjxmkXijQRg5Avo2CMzzUVlP5J3qOEOoFzQkmBmdJ+2b/keqikwbo3RdIAZmpO1yO95oiVdHgNKcpq5y5MIrADB1jRhoXd2K35BDyeQHQ5pg4z+SLYd2odj3PNz9VG/Gv+wlfl6DtpenL7Df3DDrPdG2agDE6kMgEyMKdISjsOb9DCh2ZVA1qortYh0wBYnSMAFVeDFpHBHwlMGLE2UU3fKh5vFszgW6xcNDeqQdl2D/aCyEzTTKLxAiU6kkEf5wsrc/+TpBww6JWD0hic7NsmQoVlnUGGPbiXhtjjYYkkB2KHrcx4LAGQYePbRBNQETZOvqjHc7gasJdkGyFSMw4kKVVHwD9JSi/DaLOYcnf0w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c59c84ef-6162-4e96-76b9-08de21f92af4
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 14:38:38.7052
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MBsS2deAZzYbAouPupHaJy/cq1n/zEYYJKmHeaFQq9LWb4HI9fAz/gCZ0Tg4L7hnZBv+566JRfvBhXpLIQ0rVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4353
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_04,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 mlxscore=0
 phishscore=0 mlxlogscore=866 spamscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511120118
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDEwOSBTYWx0ZWRfXy5vclSji7gHz
 9PzmgYg4OK6HlQrjwhBlJTXt5XEOqjeDyCZpzWwIDYSrtwAusKnEMsqCyutxfIKFNVPPC5Nfabm
 x75yebfBqxnZlXPtbEgHPJH2oXCpoPwngYXjBT5cPSpmrwglYJAjPpLMCoXZE0ZP6HNp+1lKzzd
 5HWYNTwdbXZMfDeErxbVWPTuJDKmw5fNANnvn5b2LL1aqXW7QHoD0RrRGhbKh16KxcgU57jOAaZ
 pKHC0Sll3JVRJ3AvZUgdOdxsrfbmCGDR+HoDbFr/HF2s2gWjoLchMTMIlSSn+GzLLVulTXrat+U
 FlNk1Ncz6U/yxdU1ufvhkNGIcFJ+edfg9qp9qOPM82DTdeZqhuV0xF2CSGMRuzgqJSTTAgAeB+k
 zik3nm7UhiLSAiOl3N+RWfRb8XZ1FqgBhuiY4DHzNHSZ7QIWCS0=
X-Authority-Analysis: v=2.4 cv=UvFu9uwB c=1 sm=1 tr=0 ts=69149bf3 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=vX5-pKDpQXTfG0k8p2EA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12100
X-Proofpoint-ORIG-GUID: QGtroLYNo885vNrn3PpNxGWZzewVIYj_
X-Proofpoint-GUID: QGtroLYNo885vNrn3PpNxGWZzewVIYj_

On 11/12/25 9:38 AM, Christoph Hellwig wrote:
> On Wed, Nov 12, 2025 at 09:31:35AM -0500, Chuck Lever wrote:
>> But it is correct style for net/ .
> 
> Maybe.  But why would non-net/ code care about their odd preference?

Yes. My bad. Carry on!


-- 
Chuck Lever

