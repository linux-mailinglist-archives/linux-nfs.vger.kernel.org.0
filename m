Return-Path: <linux-nfs+bounces-3769-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21BF79076B8
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jun 2024 17:31:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3DEC28A4A1
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jun 2024 15:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4442912CDBC;
	Thu, 13 Jun 2024 15:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iSIqmr/L";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="A5g+VcC1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741C218028;
	Thu, 13 Jun 2024 15:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718292702; cv=fail; b=Be2umRct5U4NQEYeFOWM1eWRjOlNB2MEAnoJ45NyAYdZNnhSpCdeIY9EwK85y0BSjpYcOhKg4E5z3++XgxaNKQiN3n5KasT5XdPcIRoVOnfIcVMtjJtgROQDH9E1GGLbv/I3hE4fucuNQWLrbrqm6EaH6ZDhyxflO7yvq4n5G0w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718292702; c=relaxed/simple;
	bh=sH1hGBA/KCbfl7UFqlm7ClsMnDBwOC2GRToe0ET27Ik=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Op6a9PGIs9PXE+tj4WOYna0NL3sWjzLn5ZuLBUbaEuIw8/G0WNmJ8qvZ20493BObhwKmsEZT2enfLzzUZ9r7gQtKuIiQvm6SyA8Pen5h7lNsMerLFtpDInZEMzmVwEdyLRlU+hTDMjM5o4xKwO365jCFQAOniOBdthzSTkaogDQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=iSIqmr/L; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=A5g+VcC1; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45DEtQEI004343;
	Thu, 13 Jun 2024 15:31:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=sH1hGBA/KCbfl7UFqlm7ClsMnDBwOC2GRToe0ET27
	Ik=; b=iSIqmr/Lw9Dgj8iI1eRVcez8mzouO5PvfBWiR3IoM2WKdlciMJCEWMm0N
	rwP1ZyP3ZaFm1hMcgWXRP8cbHRKggTchxjDHJ1VDvs+C//bh2JN7qePBoYZSfLMm
	PXoRt2oRalk7YBe2W4bgte7PFRsps3+ITbSogLnrhbooAqTAl1dVybtX7i4OmxLb
	hNeBlH511mV1+/dLVghsop8TDPAGYSn3z03TCiXRmSjaId6kRAaSfJBRPQhrFBQw
	8l4TNPE4QjWXJHjuvFxKJDSYcPRhmJAnKxT8BQ6guX2qYtbF84Vws41iZjBShfF7
	UGV58/VkNOWNcHCCG9kruvsd79iUw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ymh199t7q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Jun 2024 15:31:21 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45DESUJR014400;
	Thu, 13 Jun 2024 15:31:20 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2176.outbound.protection.outlook.com [104.47.58.176])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3yncex2uss-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Jun 2024 15:31:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kulDyaoBNgC4yI6MRjgZkSkLIslO1ScMgrCll0nKwkE4KN4PVxjF/oVplWssqNGoJBlJ7e6d2Vn4a0EzoQSzlHmR4VuWfkcC17SDbn0nPrbXBYXJYQ0QM9Uf1G2/iB4YpVr8Wrq2MrcBdDSsErTyvUmOmIh/R74GPXMGW8aU1VPRRM6jxz91KNuU0SQ+/s2RLmZo69J6YjiAYphw+E+grYgPXn+MVyThoHa8SOqW2gG/KcmuOQ6VagCPmovB6LbTAGKAHHaKDRlk6dlt+3o4yzwFjvGUZcm4aCxvU6334bEM+ulWazE24rkdUrA8jw3lTnKcchtCAghOqDHzl3+HVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sH1hGBA/KCbfl7UFqlm7ClsMnDBwOC2GRToe0ET27Ik=;
 b=Nv3rCRIvnSQHjf8Ai0xeLRVNEp+CZEZ/YW/Fu2jr+o0DMa3amzSs8DM/WPYCO94AYteoFiHVaUiDJjJfQ8FklXriK2b9eqN5S196QNWk2l08ofCB4TpQCqi63k9vZi9gsM5n1zgGoS8XJ1m9K1ShAdxd2NJAKuxddN7PhcPbQrDkGUVjjp6k3rPMEZ80dv4RGhI84FoKtM9987Wr609aXUbfWQAHVfj3a1tCIZnLmbPFlsSVLQsL/gYgCkkjHDNnQYajFCy7gCBQY5ChrcdvWkHoncrdeNKIzZaslgVttlwasw2x7sBg/ITWit22JvgeeBQMoz6RbSs6gaI62Q0PKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sH1hGBA/KCbfl7UFqlm7ClsMnDBwOC2GRToe0ET27Ik=;
 b=A5g+VcC1tMp1aNLapuXGAD7y2XyP3kxktkVrkW0MQ3wn8/SVrHUW5g5hMnjpSZzeqN5YqCaWVHZpzRDjDW5+PiWdkwdEzhdiCV64GZ5shBn8vWmFgTUZaHKBdZRFZS3H0PopGbG5Xyb9ew3ksBRwHDsHDmf2WLIqSK5tjGZZDgI=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MN6PR10MB8024.namprd10.prod.outlook.com (2603:10b6:208:501::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.23; Thu, 13 Jun
 2024 15:31:18 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.7633.036; Thu, 13 Jun 2024
 15:31:18 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: ChenXiaoSong <chenxiaosong@chenxiaosong.com>
CC: Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker
	<anna@kernel.org>,
        Benjamin Coddington <bcodding@redhat.com>,
        Olga
 Kornievskaia <kolga@netapp.com>,
        Josef Bacik <josef@toxicpanda.com>, Jeff
 Layton <jlayton@kernel.org>,
        Linux NFS Mailing List
	<linux-nfs@vger.kernel.org>,
        Linux Kernel Mailing List
	<linux-kernel@vger.kernel.org>,
        "liuzhengyuan@kylinos.cn"
	<liuzhengyuan@kylinos.cn>,
        "huhai@kylinos.cn" <huhai@kylinos.cn>,
        "chenxiaosong@kylinos.cn" <chenxiaosong@kylinos.cn>
Subject: Re: Question about pNFS documentation
Thread-Topic: Question about pNFS documentation
Thread-Index: AQHavW2QBBcqYXgDhEyPRodGlikhM7HF0pCA
Date: Thu, 13 Jun 2024 15:31:17 +0000
Message-ID: <08BB98A6-FA14-4551-B977-8BC4029DB0E1@oracle.com>
References: 
 <BA2DED4720A37AFC+88e58d9e-6117-476d-8e06-1d1a62037d6d@chenxiaosong.com>
In-Reply-To: 
 <BA2DED4720A37AFC+88e58d9e-6117-476d-8e06-1d1a62037d6d@chenxiaosong.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.600.62)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|MN6PR10MB8024:EE_
x-ms-office365-filtering-correlation-id: 1422df03-9d61-4a55-bef5-08dc8bbddea1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230035|1800799019|366011|7416009|376009|38070700013;
x-microsoft-antispam-message-info: 
 =?utf-8?B?OE5Pdk5OOXhVRHNOS09rV2RwR3RiRjFuQmFlR21MZzY0YTFLVmZmVUhSOGNC?=
 =?utf-8?B?MXZIMTE3M2xxc0xFUGJLZlFtdlhMZWdpMXMxdktUeTJQUkxpWElVNzhvTFY4?=
 =?utf-8?B?NVd6dC9ObmxnRzhDTXgrRnEwVG5aVTFFeU5jUGZwc29ERU05MStPd3BocUNu?=
 =?utf-8?B?cG9mMHRnelZBUS81RW9IWkN4alkvMU03MzVvNFlHMkVsUVArOFVNem41S2V2?=
 =?utf-8?B?UytsUzAzQzZ6R0RnRUFZTVVsMjdSZE1YTGxPcCtRaGI2SS81V1ZzSU5kYzUv?=
 =?utf-8?B?MXlweG4vS25ianV4NFJlYStkUC90dERmT3ZlQ09KaDd1aUJoQTVLNDEvRXEz?=
 =?utf-8?B?ajA3Vk5yZCtGRjRqS21GTEFSSEphS0F1UFBocDNaTC9IdVR4Ri9sUG1NWS9N?=
 =?utf-8?B?YndxQ1UrNDRkVkpYbzh2WER2Y1BkTUVMbmJ0bk84cjM2bk1DZHZQWi9ka09z?=
 =?utf-8?B?WWZleHI0d3FHQkQrUTY3bUtBOUhJUWpHNzRsTktVOWFRMFJRNzFJeVlBU2hK?=
 =?utf-8?B?SGRscnlhMkJHL09mQUFTcjJoVEV0K0k1bUVxZ1VWS3U3c1llaXdFSG9JWldB?=
 =?utf-8?B?NXdWclJJLzFjaWJJaW9sZ1VnQWFWVjUwR0N5ckUrcnVPcXlCNGptMVVXSmlh?=
 =?utf-8?B?bUFSdHRKT3BGVUl4czNyVFF5QjF5cHc5YkV4WU9qSHY4YzNSc3ByOVl1NEJW?=
 =?utf-8?B?ZzZEdUQxV2xneWJqcG45bm4rSFhtaGtzL1JSSUFNVWZ6KzhGc2dKQXg3dkt4?=
 =?utf-8?B?ZTJseFk1QVpEeXBZcks2UkdQcmlsNmF4YXhUNWZ5cjJjYkJLS3QyVEgwRVRa?=
 =?utf-8?B?dUJrQ3JQYXNFRnFxd2o5aDl4VDlYcEtocVlqUnJoVnpHSFJGWDFUWHpsaXBK?=
 =?utf-8?B?bzh5OGhJTmtXMTdXMTVqTnAxZEphR2xwSzkvbHhTTGxERHpQdFcxVUkydWpK?=
 =?utf-8?B?aS9JUkk5REd4c2llR1ZsaUM4TTQ2SFhnTC9vV0dqT09WM2QxVm05OXBjVVJC?=
 =?utf-8?B?SXN4RU8rUWtRSnNnWlJtb0lkZGhuMDNiaGxkY01jd3pGV2YwQUtxdjdxaU9q?=
 =?utf-8?B?N3Q1ZFdxRDhxaE5FWWdsN1dsRVBGazBmOS9YTElZOFVXdTVjbHRiM2QzQURP?=
 =?utf-8?B?dmViTitXa0U4dDJWZ2NQeVBNR2ZRREZlQ1Zyd1ByaGJvcDM4enltd0ZUTEZR?=
 =?utf-8?B?SUZLVVFic3lYTDAxQ2hrd1FFUElTQnh3OTMrb3ZEY3E0b0hTbFVvVGZOc0JG?=
 =?utf-8?B?WHl1QllwaGdtalFKdVU1MnV3Q0lrZ0UreW50eHRlRTVSUllqM25nM3czc0Jw?=
 =?utf-8?B?cXZ1VFl5WVduVTcvb3d0QUE4czVWRE1IK3hKZkdRWmNEMVdXa2RpcWU3dVo2?=
 =?utf-8?B?R05idkJJd1RqYnVIZzFSNEIzaS9neDk0YW9oOEpUeG90NFNzcjhLMlJtN0Z6?=
 =?utf-8?B?MDU4U0FZL0R3TmJzS3dQdHc1am9ZTDFqSnlnaktzSUh3djRTNkluWlZMblRU?=
 =?utf-8?B?VkQzZ2NHb2d0SkJtZXZObmU2d2F1WGE4R2RXdlo3NlczRFowRVAxbTVXeUdC?=
 =?utf-8?B?M0ZVMkNtNU1xTlA4RW1XS2JVdEVyTDdZRnlSbDljK3R6cUhBQ1BWeHNVRUZZ?=
 =?utf-8?B?TXE1eEJ6cjN0OEZneXJtT0w0Y2NzM3VrZm05N2VYTzBYeVNyNVRFVHBIY2x3?=
 =?utf-8?B?dU94aVJOZXBySHZFTEgyRGY1SzgyN1czWFozLzJnQUxsQThLMUxpQUxHYk94?=
 =?utf-8?Q?R301tuqtZiN60fiKtxONp5ahSWGu20I83yie7sJ?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230035)(1800799019)(366011)(7416009)(376009)(38070700013);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?U3k0YXFnR1dVcDB5ZWJRM0dBanI2RG5BazloWVFpTGpmelE3dGQ2WE1pMFE3?=
 =?utf-8?B?U3dKZTE0Z2R1K1E3S1EwVkVoNGpuaVNld1BPLzJjSnZYN1ZpUUhZMmZ0VnFj?=
 =?utf-8?B?K0x6dEpJV2NFNEVXN2NacndacVNaalhWMzcyQmhMRHBiUWJkQmNIcUdLb1Nk?=
 =?utf-8?B?WjE3eUFueVczS1ZydTFNeHh3UURSWFlZeFBtb095Q0VBQzY3OWw5NUJUL1RR?=
 =?utf-8?B?RmFzUk1aaStaSzJFajBvMll3OExzNCtENjR0WWRtcGVReEVFN3pYdnJZNTVT?=
 =?utf-8?B?TjEzS0ZZNDVUdVVpOFJYOTM3RnVUYW5kQ2J5djBRb2d4RHFMOXVhRjR2OGlj?=
 =?utf-8?B?ank0NkY3SU1nRWh4czcwdVBSVlJLR2drb2xXSmNuM0pLSXh1SlAyS1FBR2pS?=
 =?utf-8?B?ZUhrQlJBdUcxZ2p3MytpbndBKzVjYTlJM0w3S3lJLzNqbXU1VE81UHhGV1M0?=
 =?utf-8?B?Nm5XbWhWVEZrd2RqYThoTXlFem1PSlpOVVdpUkI1YjRac1phS3E1VGxocXZh?=
 =?utf-8?B?b2RPMUp0am15WkkzSmhXRm1sUjNtNVJ4QThGZDIxNEdodXFBWFJDdEw2aVFF?=
 =?utf-8?B?STFOdEZqUUh5cTRxNVFXZ0ZDOUU4aUtvUzB1S05JUlhiVUMzTVpJQWZXR0ln?=
 =?utf-8?B?WFA1TEUrUVVYc1hDcFg1VFFxODV2MHM1cnpHZkZ1NS9YR3luRlF6T2dybnJz?=
 =?utf-8?B?SitqeXEram1ueVZqLy9KU24rdWZ3dVF6ZFN6QkNKQUl4aEpOY0oreHF2VnZw?=
 =?utf-8?B?YzMydmQ5NXR2S1NMM1NYcVNLR2FYdHNpdkJLeWNSVWZoOGZSRVlMN1E0U2Ex?=
 =?utf-8?B?T1BoZDNQUzBKbEs3R3JYblk5aktGL0NNNXR2YWZmSG9LY3FWdFU2N1ZwUk1L?=
 =?utf-8?B?RnNWNEE5SkJCZkRjRnNnOVhmZlF1alR0NHFROHZIN1dEb1ZBUDI1YUVLcHdT?=
 =?utf-8?B?b2Q2WjMwUml6N3FWQ3BuRVZpWTZmQzNmMUVqcEtLeEJ3bmlCTEswNVZUWlF1?=
 =?utf-8?B?N01ScndVOXpWSlhDVnlCczJySktPbmFMdkh3aWNJZHNKM2g0SUh2WURKdUlL?=
 =?utf-8?B?MlExOFgxaTdWN1g2dHN3TmNhakZUeVhLRmpKQXJ4Z0x3MElEcWhZVjE0S0k5?=
 =?utf-8?B?UVFsY2lRR29iWFdsVE0zTmJGSGs5RXdRRXpvbFROY3FaSm1iMlpXd3BEVGxJ?=
 =?utf-8?B?T24waytReGVCREtQbWc3OGFzQ09GWUVDU2VXYVhrVGFlbnpkY2UyQWtlM1hP?=
 =?utf-8?B?bGdsdGpudUk1Z0J6ZzArNVkxbE5STUJQQ05NeGlQTS9wM0tsVTlrNzM2TjZu?=
 =?utf-8?B?UDVXeUlSU0N0SEdSMTQ1L2U1eEhiQkV3WDVWMWxZa2VCaEY4Q2xYdGN4eStY?=
 =?utf-8?B?U2xBZXNVRTZwUEo2ZmNsSG4ydVV4bjg5eXkvdjJTemlwS3QvU21WMTM3cHJK?=
 =?utf-8?B?bVJIQXBobUtFbWxWcGFjbTFObG5ibjJJTENiL2lIMkhiZ1lpT3hnMTNiTnpn?=
 =?utf-8?B?S0huK3BOL3NVU3FFcUl6Q295cE1DbEhJQkhZc1FPQ2lsTWcwTE5aUHMrd25G?=
 =?utf-8?B?QWRqa2ZWMkFNL2w2KzFETGRzZGt2elBQTzk4TlU0MHJpYzhvWUQ4VWRGVlRP?=
 =?utf-8?B?QjU3WWdPdjNoODJzTHlVZDYzUEJxK0VObFF3cUV5UzVyQmUrcDdCTVhzdkl2?=
 =?utf-8?B?U1NsYWdMU3M2Y1I3c1dFY09GbzVrUXZzdC9pTTRXc3l4REhMZjN0aHQ1VHgw?=
 =?utf-8?B?WERXT3FZOFRFc2gvUWpaWXl6VTI0UHYzYlFkS3l5WlFPSkVhU1RvVkVvNjlU?=
 =?utf-8?B?OW13Z1krSGp0RmdUbVh1K01zSk1ZOHpHS0ZkaFdBdVMzSS9hU0Y3WjhycTVL?=
 =?utf-8?B?ZGU2aWkwNWZxcWJMWUNqLzI0QUM5RlZ1V0RVYlJXdTRuUGpjWWZzTFlvWEtZ?=
 =?utf-8?B?U1g2MSs0N3YvOWhLWlprN3llRXFGZ0U5cU9CMmpCYmFkb1c3WmdhYTJlRm56?=
 =?utf-8?B?MFZLSElPWHA4VEtYSVl6a2hEV041TkdhZU40dmhERGhvcFFNTmdmMmw5Vlc2?=
 =?utf-8?B?V0l5enJlNHNUczVtN08rNklnYWU0TjBWbFgxT21pVEh2alZHSmswSVRJejJr?=
 =?utf-8?B?NExBQUZVVk9pTldJV1BkTGtjeUtmNThlV3h0WmZ5dCtMSXZFTm43bkZJejlS?=
 =?utf-8?B?SUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <387CCEC7309E834C973E3792AA4796E2@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	wrqSssJWgQQkDI+/1H6YBuc85+rjzD68w3Zc/Yp68sN2jhJ98RbU7/A7WZIUQkCY39Pk4aQmyFJfDk7nrfFebDJMr61RGpcC53Z8wob/LwHBLtBfUuXJdQ+wGOTVaHZQzqcezWY9kCrzLemaD8V4z5/NKKhnnVjXoSWROB8eS8z95PwwVjpnoehXcVKdINC4Mf1Pl9QiYkcpObEA7hbT88UonmM/2+fGb2lB8wOUUOezX1lJoMgWEC9T7Spotth8AajeOyy/zInF5VsWuWcNNSwXNOHt0QronOjP25bpGlpkePlkBtvt7sSvcs9k+Uy277kskz1rugs5Xf0xNjHgC9jiVwJ2+1R3ITZc8u7ylMLpkshEXk7yNNi+sbt0KRjMW0P7cWvLFQLIMl4T/NzbujWxmyFKmY4qiIoxm82a3xSWFQxLONhhsUdmIFj1/mPJ6ojWAev9ewluK25zIPjZcJg4ovSbIuK1ZXGbBVcyJVXa2aGm9TpXs0+74g2jGK1lx3l0nKcMPxphZhIoEok3MUqzDZDNDrTQP38qi/Eqrbkl8aOPNu7IYqY8/EDCv30inWiAA167i8SI6uNL/cZuTNcBg5TZ2K3JlOZ3XH1JxL4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1422df03-9d61-4a55-bef5-08dc8bbddea1
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2024 15:31:17.9860
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O2gnCukwG9sJ3+ECPxFg65pgkd82ATCMFLocSw2VOzLkhh5dj/J/8gOAoNBFOaxSn/L5ifour1byL59YtcV35g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB8024
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-13_09,2024-06-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406130112
X-Proofpoint-GUID: GXcmfUpB6NGLMn5C4W0H6lN1cpWZPUI5
X-Proofpoint-ORIG-GUID: GXcmfUpB6NGLMn5C4W0H6lN1cpWZPUI5

SGktDQoNCj4gT24gSnVuIDEzLCAyMDI0LCBhdCA0OjM14oCvQU0sIENoZW5YaWFvU29uZyA8Y2hl
bnhpYW9zb25nQGNoZW54aWFvc29uZy5jb20+IHdyb3RlOg0KPiANCj4gR3JlZXRpbmdzLA0KPiAN
Cj4gSSBhbSB2ZXJ5IGludGVyZXN0ZWQgaW4gUGFyYWxsZWwgTkZTIChwTkZTKSBhbmQgd2FudCB0
byBzZXR1cCBhIHRlc3RpbmcgYW5kIGRlYnVnZ2luZyBlbnZpcm9ubWVudCBmb3IgcE5GUy4gSSBm
b3VuZCBzb21lIHBORlMgZG9jdW1lbnRhdGlvbiBbMV0gWzJdIFszXSwgYnV0IEkgc3RpbGwgZG9u
J3Qga25vdyBob3cgdG8gc2V0dXAgTGludXggZW52aXJvbm1lbnQgYWJvdXQgZmlsZSBsYXlvdXQs
IGJsb2NrIGxheW91dCwgb2JqZWN0IGxheW91dCwgYW5kIGZsZXhpYmxlIGZpbGUgbGF5b3V0LiBT
b21lIGRvY3VtZW50YXRpb24gbGlrZSBzcE5GUyhzaW1wbGUgcE5GUykgaXMgdW5tYWludGFpbmVk
IGFuZCB3YXMgZHJvcHBlZC4gQ2FuIHlvdSByZWNvbW1lbmQgc29tZSBvdGhlciBkZXRhaWxlZCBk
b2N1bWVudGF0aW9uKGhvdyB0byB1c2UgcE5GUyBpbiBMaW51eCk/DQo+IA0KPiBUaGFua3MsDQo+
IENoZW5YaWFvU29uZy4NCj4gDQo+IFsxXSBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20v
bGludXgva2VybmVsL2dpdC90b3J2YWxkcy9saW51eC5naXQvdHJlZS9Eb2N1bWVudGF0aW9uL2Fk
bWluLWd1aWRlL25mcy9wbmZzLWJsb2NrLXNlcnZlci5yc3QNCj4gDQo+IFsyXSBodHRwczovL2dp
dC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC90b3J2YWxkcy9saW51eC5naXQv
dHJlZS9Eb2N1bWVudGF0aW9uL2FkbWluLWd1aWRlL25mcy9wbmZzLXNjc2ktc2VydmVyLnJzdA0K
PiANCj4gWzNdIGh0dHBzOi8vbGludXgtbmZzLm9yZy93aWtpL2luZGV4LnBocC9QTkZTX0RldmVs
b3BtZW50DQoNCkknbSBub3QgYXdhcmUgb2YgcmVjZW50IGRvY3VtZW50YXRpb24gb3RoZXIgdGhh
biB3aGF0IHlvdQ0KaGF2ZSBsaXN0ZWQgaGVyZS4NCg0KTm90ZSB0aGF0IHRoZSBMaW51eCBORlMg
Y2xpZW50IGltcGxlbWVudHMgdGhlIGZpbGUsIGJsb2NrLA0KYW5kIGZsZXhmaWxlIGxheW91dCB0
eXBlcywgYnV0IHRoZSBMaW51eCBORlMgc2VydmVyDQppbXBsZW1lbnRzIG9ubHkgdGhlIHBORlMg
YmxvY2sgbGF5b3V0IHR5cGUuDQoNCkkndmUgYmVlbiBidWlsZGluZyBvdXQgdGVzdGluZyB0aGF0
IHdlIGNhbiBydW4gZm9yIGVhY2gNCnJlbGVhc2Ugb2YgTkZTRCB0aGF0IHdpbGwgZXhlcmNpc2Ug
cE5GUyBibG9jayBsYXlvdXQNCnN1cHBvcnQgaW4gdGhlIExpbnV4IE5GUyBzZXJ2ZXIgYW5kIGNs
aWVudCwgc2luY2UgcE5GUw0KYmxvY2sgaXMgdGhlIGNvbW1vbiBkZW5vbWluYXRvciBiZXR3ZWVu
IG91ciBjbGllbnQgYW5kDQpzZXJ2ZXIuDQoNCkxvb2sgYXQgdGhlIDkgY29tbWl0cyBhdCB0aGUg
dGlwIG9mIFsxXS4gVGhlc2UgY29udGFpbg0KY2hhbmdlcyB0byBrZGV2b3BzIHRoYXQgYWRkIHRo
ZSBhYmlsaXR5IGZvciBpdCB0byBzZXQgdXANCmFuIGlTQ1NJIHRhcmdldCBhbmQgZW5hYmxlIHBO
RlMgb24gaXRzIGxvY2FsIE5GUyBzZXJ2ZXIuDQpJZiB5b3UgY2FuIHJlYWQgQW5zaWJsZSBzY3Jp
cHRzLCB0aGVzZSBtaWdodCBoZWxwIHlvdQ0KZm9ybSByZWNpcGVzIGZvciB5b3UgdG8gc2V0IHVw
IHlvdXIgb3duIGVudmlyb25tZW50DQp1c2luZyB0aGUgTGludXggTkZTIGltcGxlbWVudGF0aW9u
IGFuZCBpdHMgaVNDU0kgdGFyZ2V0DQphbmQgaW5pdGlhdG9yLg0KDQpBZG1pbiBkb2N1bWVudGF0
aW9uIChvdXRzaWRlIG9mIGtkZXZvcHMpIGlzIG9uIHRoZSB0by1kbw0KbGlzdCwgYnV0IGhhc24n
dCBiZWVuIHN0YXJ0ZWQuDQoNCg0KLS0NCkNodWNrIExldmVyDQoNClsxXSBodHRwczovL2dpdGh1
Yi5jb20vY2h1Y2tsZXZlci9rZGV2b3BzL3RyZWUvcG5mcy1ibG9jay10ZXN0aW5n

