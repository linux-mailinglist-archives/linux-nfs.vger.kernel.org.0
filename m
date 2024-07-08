Return-Path: <linux-nfs+bounces-4744-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8B7F92AB69
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Jul 2024 23:42:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CE67284001
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Jul 2024 21:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02120145B06;
	Mon,  8 Jul 2024 21:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LyQRnI7M";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="pJ88vbF0"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367D714EC5D
	for <linux-nfs@vger.kernel.org>; Mon,  8 Jul 2024 21:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720474913; cv=fail; b=BAyJPXVQYi4vPCpqF/VMVN3EcJV9pxy0mz9/pdIWpw+Bf251Mj+qlEL+6uuDy81raJIvSsZWn12L0IK1SXTvw38ToL3ED8yfkmQL3NKG6o7LOp/Q9ecL3TwWh3J6REIu0VyAVOcN2sqevm8jGkpo3PAdqdA7it5U0KS9IyVskbg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720474913; c=relaxed/simple;
	bh=n2QViSiAdeFs2FypmjrXq3CdJIn0xs32BzJiFwwT81U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nyFKJE43kw/rNUcDloI3hZKpF+7GfE2BjcTG9c+e+cVBuHPkx7B5/RlMVm23AiaCmecHmaod/w2G0AECk4zs4IDMhz+l0ZhLeJKV2ufqEGe/a3ni1WeoY/nqemKcT7Ww6h5yww+iUMoUu1LyvAsTqpKoPwFYexRtXfHikING5VE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LyQRnI7M; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=pJ88vbF0; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 468JfZSt015855;
	Mon, 8 Jul 2024 21:41:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=adyeoNyQOGP+pXdVQxlMjYxV6wsXCrEc0WAKWxwy83Q=; b=
	LyQRnI7MmLioSkh9QokDYpXIYbqBIZeIYH/nBZabJsjwT9XL81q7gORZx6IRzCEd
	BwORtJXjz2F9zMsaw3UiAhaNdL+ASEIb6zPk6n7J367H+qENOvBOWlKGgRkYlc2O
	nKYO+BERPr5/k0PJ3zcT149u9QbfyAkfBayKyw5er7uhnplkwaz4lX5dJkRdV0kf
	yD7+4yGChPEQnj/TBpMv1UtspbzQGJeuRaPemKekwfyzdBr99M0doZWEo9Cr3NwZ
	whoe5FVjJq7cgFCVhpFIEg6LOEgqSmN6ftTw+JUZCgSZMtPJutTBQ4oH/gn86axg
	LB8S7jNmyVtxkF/r1n2gAw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wky3py4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Jul 2024 21:41:48 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 468KlQLL005053;
	Mon, 8 Jul 2024 21:41:47 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 407tvcr294-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Jul 2024 21:41:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q0vLs2lX+3XRKbSW0xdHhC8njqPxCePPZXUvTS0PBKKEIWWmXfHYLBvyRLGknyR7DUi6+SNriToSfqpDTLwMclmo3NbORH5MQ4IiTowiMqwuuHgE7VHTLp3Mnyrg1cHzruPA1Xr3w1ZyLK+BBviRypf6x2eoNta1DA0WoZK6YKFWZWU6AlDfbmfhxQ4JMmGdd8XjVizqORNb7Tc++hfltWiZi99MllV+dj7sQ2RYClWNYW2HTSYOdzpAgxp/hs0MT/kIRqeAzyDjEotHqW8k9d/623M6aKean4NRyGNYTD3VgDEaFa1FYY5fA3y0CyEqIvnc/ZKgrlL/Wh1PpHrkHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=adyeoNyQOGP+pXdVQxlMjYxV6wsXCrEc0WAKWxwy83Q=;
 b=KUR1mRUbCej9LBFkoLk1QlxZG+AsgkFj4uNZ40CNuDzjBHzT0Bcg/w203VGXxFw84sawdOybQqbNPUAb2WY471ghXxGD2qVPKFTW21u4UXIjjM/ONVC9RJq22QircUI2Lj7eTdoXV1u2HiNT84bbD7CZn0WWZM+6JYuDQwLyUTw+eOvH1lbwuVHcc+c+OciwYpfIjkWwc4rk8es7WF8mWlAVbS6waZR7TMAArYP5h66kUQ5pC7dpn8Fnwp7nb9pejbqkKQgx9EEF95g6AH6bcmWWfp1XKeBoeW4lXnKdbpZkTGShxFyF+ug9P/A1ltX88Lf+v6Nu7OE9d4BfPtRlyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=adyeoNyQOGP+pXdVQxlMjYxV6wsXCrEc0WAKWxwy83Q=;
 b=pJ88vbF0uHP+AOAr4vke0peWs1trQKuuSdYXZP26PWevqzpgfXzZdnM7IbPZn5JGanu6usOl4Mv2weml28v0UFNCZG7pVA7qFvkonO01snpnv7dfE1keGy78vV7dFS3lGCzSGlA/j/AdF5/Kw0yhju5WeWGRBSO2SanbguT7V/g=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by MW5PR10MB5692.namprd10.prod.outlook.com (2603:10b6:303:1a3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.35; Mon, 8 Jul
 2024 21:41:45 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::4c3a:47c2:806d:2e16]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::4c3a:47c2:806d:2e16%3]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 21:41:44 +0000
Message-ID: <e23bb0d4-7f83-45fd-8df1-b127e1f749db@oracle.com>
Date: Mon, 8 Jul 2024 14:41:42 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rfc] nfsd: offer write delegation for O_WRONLY opens
To: Sagi Grimberg <sagi@grimberg.me>,
        Chuck Lever III
 <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <20240706224207.927978-1-sagi@grimberg.me>
 <114581777d5b61b6973ec9ef2537ee887989e197.camel@kernel.org>
 <9156BC30-78C3-4854-8BC3-510E586B4613@oracle.com>
 <3b4ec3b0-5359-4f95-81a3-1d558756bddd@oracle.com>
 <5a071e49-f214-41d3-b29f-aa1860b12455@grimberg.me>
Content-Language: en-US
From: Dai Ngo <dai.ngo@oracle.com>
In-Reply-To: <5a071e49-f214-41d3-b29f-aa1860b12455@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR21CA0022.namprd21.prod.outlook.com
 (2603:10b6:a03:114::32) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4257:EE_|MW5PR10MB5692:EE_
X-MS-Office365-Filtering-Correlation-Id: 4725c2dc-2f6e-417f-d325-08dc9f96c326
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?RnJPOE1ZLy9IVEY4em5kaDBtaVJFSlFaUi9ZTXNYN2E1R3NhYXRTbXc5N2s2?=
 =?utf-8?B?bnhROFlodTFXWjRxZkNlakJHelVqdmJTVUFUUVh2T3VFbmY2TXBiQ3pCbzBk?=
 =?utf-8?B?NWdVVExhSFhBa1BZSnBXSHdTbnlyQ3hEZzV6VW9ZdlNuZkVseTJBWnNsS1Fh?=
 =?utf-8?B?dXFpQ2tLRThuQWx1VWY4cFZaQ0pSZUs5bTVmUlZUbEV3SHFMUlUvdnBGL05M?=
 =?utf-8?B?R0ZJdXczWUNsOCs0SThIRTJ4R2drZWQxeXQ0ODhvVmNlbmFpaUVUbnhvT1R0?=
 =?utf-8?B?by9mcCtWNHR6Vk9EbHlSeWpyYW9FY2tRU1dzclZpY3hSTlVEQ2QxbDRSand2?=
 =?utf-8?B?cjZqbFZ6MVU4QkcvRXFpbVBwUUVaZWRCVFlmVVhNYS94amNuWStIcGJrVXZl?=
 =?utf-8?B?ZWZwWWxHb0ZtZlBGMnZEKzdobUhPZkE0eEdvRS9tcU9kcmlQNHdKNVZUR1pM?=
 =?utf-8?B?USsyRklhVm9wTUJxKzJHeC82TnBRZDZUNU9hZFI3SHlwcU1RK3VMWkVYc1J2?=
 =?utf-8?B?amRwZHI2TlZsUDlxQUhJUlR6aXZTL2ZzdEtXbXVMTmVhRjBDMVluVzB3Wi9H?=
 =?utf-8?B?bVluTWJpMmE3dWlUaHdtNmRndDQxVG1pSUQya0tMaEFQVTlicHpKdTdkdnVM?=
 =?utf-8?B?ZkhGWittbjFDWnpGajE3RXVFZU51WWdEWStJRnYwdWMxQnUwS3FOdUs2d2p4?=
 =?utf-8?B?bkVYdU8rRkJkWGJwamtJd0owcXpiYVJWRWxxZ04zZkZ4N0puUTA1RjhZckJE?=
 =?utf-8?B?eGFQcWVUcWNkcVpwSCtXYVJlay8yT1hPWGpsS3R6aFhmQVdKUzNzVUsxR3Zu?=
 =?utf-8?B?SGJtdW94RHpuSVRUcTBVVE9RclRPSS81OWQyeG1YRFBmb1Y4dlJ2SlVtMXdn?=
 =?utf-8?B?QXdaZlJHZkdRcEZMS3B6WlVzVGFROEZmTFhpakZjTmo5dXNlVDR3VExmZnNq?=
 =?utf-8?B?Rld5UGcxVWtPdlBmTE5QL25abVlSQjBrMVFtWG1DUW83RlMxSlMzTlNJeFFY?=
 =?utf-8?B?SENxaFI4cGZzTkhIZVFGamtkbzY4Zzd3YXhZTVFpbXE2Z2J5R0dvSU9vc0tM?=
 =?utf-8?B?NjBjenROYkU4VUNMNWFVQUdYaGI3dStWekZnemxzZTBJNlg3a0VTUW5laitn?=
 =?utf-8?B?eTRLamJINjd2Z0RhNGNoVHkxYnRDaUlxNFR0NWxRcjJ6cCtBclpsazBJSnhC?=
 =?utf-8?B?aEJ0c0ZuKzJFR200WnFGVVBmWHNhbFNIckxPVkFGbGVRMDd1aC9hbEoxMk53?=
 =?utf-8?B?RUVhTTFlUXBnMm1jUVdFZzk5ejVXUGUybllEU3dtRGhIVG42bkFGOXJ2dTVS?=
 =?utf-8?B?MVpKL0JVL0VJd3BUMWErRysya3BiNlFXSUh6azdXdVVJYURoZk85ZzVqVXRo?=
 =?utf-8?B?RWt0SHVwb0FMMjBmVnd4RzZ3ejB1bzhwMXNwYlhpcXFEMGNnZWhDNk45L25E?=
 =?utf-8?B?TGRhcG9hRmp3SlllMFJkRWl4cFZqYXZKQUw3aGFCdnJSd0E0MFlPaGFubkVF?=
 =?utf-8?B?WmNQNCtOSjczczlDdGwxSWdkZzhSOVNzSTBVbUQvSDhBV2xRK1RxZTMveFhi?=
 =?utf-8?B?aHdhWlpKSUxoWERMWHRRQXBvUUtCVXRnYjlFYXFvNVpsSEd0Qi8rUWE0R3pT?=
 =?utf-8?B?dlVnSFY5RDFwZVNUTnZlKzBMVzJoV0lTMURHSmowT0JIa2ZXYXZnalQ2UHRq?=
 =?utf-8?B?YStiTW1XRHdUdWVnMU9ubEQzRHV0SDd5NUJTdHM4a2xxNmNUR2JlbW83ZkFC?=
 =?utf-8?Q?6p6HE0y+vU0H3ih35piBL2DOj7wqlJxt7r+5jnm?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VnpsYXYzak9paFdjZitjYStmMzBCMDVmQUNGc1p6TEt2VGRYaERzOUdDUU5Y?=
 =?utf-8?B?TEZBT2paYWwxcXUrc3FiWGJYOThlZWhUM0VWVUdCRUhwWjVnZHpGb2tmalND?=
 =?utf-8?B?N3BWNXdxNUFYdkVwalAxdWxDak5ISmM4MWRjZlJ0bjR3dURrWW10ZXZ5SGVv?=
 =?utf-8?B?ZFVteSt2V0ltcnBTWlA4V0lEZGNhQXNJbFVGZEZ1c1A1TWFRUFRlZFBNdUUy?=
 =?utf-8?B?ZjJpZnJhQW9STnFwdWkxMU9kU1lZUU1UT2Q1cnpQZml3STYrQnJLN0o5Yi9Q?=
 =?utf-8?B?cTN5dzZxcGhDSEJqbnc4YTdES2tQc2NhOEthcGdydWFrTEorbVBJVTNBMTRF?=
 =?utf-8?B?Y3VRK1dnTWxVTVpqL2lMY1R0M2JIK3F5aFFVV3JJQm1Ocjc3YW1tV01qemdt?=
 =?utf-8?B?MlIxNitKR2Q2a1BtVTVxK2JBM3RJOTNwUGhrOTBPTDZtUXVyTHN4UGJNSzMz?=
 =?utf-8?B?eFpPVEY0S1hVREdGRmZKWVVsbEswcUlqMUdBVTJtY0FyeUllSWRJSzIzZTZ2?=
 =?utf-8?B?OXFGMkdqeW1yUGd5cHEvUHp6WnluK29lNmdkSTRjeUlhdkdoZEdKSzdraXZI?=
 =?utf-8?B?QU8zR29sbG0yejY4WkFKejR4T2krZ2FwMHpVV2poWDRaNjZWdTkyR3V5Mlcz?=
 =?utf-8?B?S1dmOUhEajVHM3FuRkplTHRtYWRjaHVnSTlLdGpKK2s5WHZJVzZ6TE00cFBi?=
 =?utf-8?B?a1o4VVJjQzVzUm5PN3pCSjNyMzd2UTZZUjdjTm9yY1ZsVDNGOVdhcFd4aTA3?=
 =?utf-8?B?dHlJK0NXWWQweDFIT1FVbmgrZitiWFd1S3lrUko4V2xqaTd1NUVTYUhjVzB2?=
 =?utf-8?B?K3BGTkVCTDlNWnhDRkRBejh4d01mOWlpZFRPSFRjVEE2S0lOQng5d2FpSmdP?=
 =?utf-8?B?WndnRHo1bHZ0WEdvL0Q5RGRweC9DTDJYeXdLS0pNTFlCck1Ra002ZEFSMjYy?=
 =?utf-8?B?TjNCTnl3cS8rWGI1RHYvUStHU1EwOFZWVHA3bkczOTN4dUQxNzA4akd3T3V5?=
 =?utf-8?B?bHl5ZWoyUU5EUDNjb296dHdUWGxSS2JtQkpqdW9NeGdIRlMwaWZpM1l5eTZT?=
 =?utf-8?B?Z09XelpkcEdHNVJXMTY1UURrejFLa2NWLytrbVFsYjR3Ti9neW5XMlRLV0tD?=
 =?utf-8?B?dXhPUCtIdTZvMExxck5MK0FRMzltUGR6YzRSMzZRS1ZRMDNuTjdEWk5tMHB2?=
 =?utf-8?B?clorMDBsMEZ4N1FlL1Q3UThna1BONC96US9jdHhkUUY0eHZpTmFNRUFyUzZp?=
 =?utf-8?B?aG5BdmZ1TkxXc2FHMGdHRkhmVUE4QWQ5MnJKZ3ZLRGl3SWhtd2dRTkVGNEtp?=
 =?utf-8?B?dURPYzFXS2V1NWlMZW1MZkpKelcrcWpKS1greG9HT3R6QS9mM2xCVVY3Wktz?=
 =?utf-8?B?M3JRM0FZVUxvR0loVEkzMWprNzRqTW5jMnFuVlE4Q3VkcEdPd09MY2ZQbXJR?=
 =?utf-8?B?TUZyRm8wcnM5WXo4eWs4VzY0ZjFyLzhYTjhPa1JMSGR5aTBkRC9BalNlTi91?=
 =?utf-8?B?azVvN245WS9IcHpIQUZuUTQzemhibjdGU2pyWWN0ZWlrSFB1SGhVblVNNFdq?=
 =?utf-8?B?dS9henBkbTl4MjZyeDYzVGtTU1JjdDMraFhzc0RlUTNzSHpxdDZOSkhRV3ht?=
 =?utf-8?B?Wi9ldlE4dWFSME8ySTFCWkxtWmVkS0Z5ZWlINXRKL1JheDBGcE5FVVZVWWZx?=
 =?utf-8?B?akllUlpjWkRsN0Y1amxqdkgrQ1d0OTBCR2pmdW5iZ0dIUU1XL0x4NXEyT2RK?=
 =?utf-8?B?Z3IxR2lNS2VKV244VTRJWWQ5M2REZm1wUk5xYWVzVFBta3BFek5DM1ExY015?=
 =?utf-8?B?TGw1YTFrWnd5TW5GRXlxeTk0dCtGS2pwNFRnRW9LOTdRTmp4RFZuREZvemJU?=
 =?utf-8?B?ODk1RG9GLzQ1eGkrS05HdjU3R1Y4WWlZQm1IeDNTT2luSDJmenNCS2NTVWhn?=
 =?utf-8?B?QXQxeXRDMWp3cmxFRTFjSUlZczBaSlc0VmRmMFAxRi80cmVtNFpyK3ZHV0ZZ?=
 =?utf-8?B?MEhNbEYva05HWU80YW4vekYyUEVQSU5rbUJFUy9ETXB3SWRKRlRPOHk5S2ho?=
 =?utf-8?B?ZFY2RDJVZ29EeHVzMXVLeEZ1ZzBPU3Exc0JvVC9ORkI1TTdsdFYzbUtndWIr?=
 =?utf-8?Q?nxcqB1cyKpo97TJQcQUg9zFS6?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	X35rwFOc+/g5PCBhEM40XgiH+k4Y7tvqwtEWsTab3LrFrngIxa1yylRmU9DeVR17J/OjcGS20FN47pZMrbZ8mocbZNwn4O8CMoGiDcvc//CfXPW7Oi8HSpJXQSl8Wz0v3pEdsSRL72lzETrBb6ZGKgY1i6S0mhDaGQfClcv9wACSu39p+Fg1UZU7TozYkkcb/w/V4qLnSbzWeEE5L33I/iK1grr/ZO6LR62EgQWW9JIyLh7Ul0VTA1Y53/VX/mA6mSuGihXsDVo09LewoTyKXYQhaoWiPd18Bvk7X+KM6WV09gXmf/o+R/tJqi8MUT/ASTEvZBMRlsNo85a8qjRwykUQCSF9dS9BIX3tSlKsqks/i3oDEChazHBzOUBAMVYrkPu4dukmxh5HLmGoGk96GrYo1EDVZTSweYbpiP4X/7ABkvKEcVxfkYaBD7JhQUdG1+jkw9U4okGe/xIglBnkXnSLMUs7ZbyOlIEua9jiWcrplit0uo1XVSEeunMCJdCmjbUudkf0o0Y3EWaMwGeJygA2TE/w/i6wI+lOjK2YqrJZHSuWDplxf3sUFIK7y2D9Kkq8YH8fvkmNPs/nm77vVau55umEVJqd05G0kd1eZCU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4725c2dc-2f6e-417f-d325-08dc9f96c326
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 21:41:44.8904
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jLZoqb/2WoxyEti32vucZ6TmWAyx8LJBN7+lf/pSL+m3PpPFT37jYHH0o0q3hUz3m01O2f52nwoNSfrxcnbUtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5692
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-08_11,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 bulkscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407080160
X-Proofpoint-ORIG-GUID: ZK9gMtXHEsdunaLSm7G7BHen80S-wwUe
X-Proofpoint-GUID: ZK9gMtXHEsdunaLSm7G7BHen80S-wwUe


On 7/8/24 11:56 AM, Sagi Grimberg wrote:
>
>
> On 08/07/2024 20:39, Dai Ngo wrote:
>>
>> On 7/8/24 7:18 AM, Chuck Lever III wrote:
>>>
>>>> On Jul 7, 2024, at 7:06 AM, Jeff Layton <jlayton@kernel.org> wrote:
>>>>
>>>> On Sun, 2024-07-07 at 01:42 +0300, Sagi Grimberg wrote:
>>>>> Many applications open files with O_WRONLY, fully intending to write
>>>>> into the opened file. There is no reason why these applications 
>>>>> should
>>>>> not enjoy a write delegation handed to them.
>>>>>
>>>>> Cc: Dai Ngo <dai.ngo@oracle.com>
>>>>> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
>>>>> ---
>>>>> Note: I couldn't find any reason to why the initial implementation 
>>>>> chose
>>>>> to offer write delegations only to NFS4_SHARE_ACCESS_BOTH, but it 
>>>>> seemed
>>>>> like an oversight to me. So I figured why not just send it out and 
>>>>> see who
>>>>> objects...
>>>>>
>>>>> fs/nfsd/nfs4state.c | 10 +++++-----
>>>>> 1 file changed, 5 insertions(+), 5 deletions(-)
>>>>>
>>>>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>>>>> index a20c2c9d7d45..69d576b19eb6 100644
>>>>> --- a/fs/nfsd/nfs4state.c
>>>>> +++ b/fs/nfsd/nfs4state.c
>>>>> @@ -5784,15 +5784,15 @@ nfs4_set_delegation(struct nfsd4_open 
>>>>> *open, struct nfs4_ol_stateid *stp,
>>>>>   *  "An OPEN_DELEGATE_WRITE delegation allows the client to handle,
>>>>>   *   on its own, all opens."
>>>>>   *
>>>>> -  * Furthermore the client can use a write delegation for most READ
>>>>> -  * operations as well, so we require a O_RDWR file here.
>>>>> -  *
>>>>> -  * Offer a write delegation in the case of a BOTH open, and ensure
>>>>> -  * we get the O_RDWR descriptor.
>>>>> +  * Offer a write delegation in the case of a BOTH open (ensure
>>>>> +  * a O_RDWR descriptor) Or WRONLY open (with a O_WRONLY 
>>>>> descriptor).
>>>>>   */
>>>>> if ((open->op_share_access & NFS4_SHARE_ACCESS_BOTH) == 
>>>>> NFS4_SHARE_ACCESS_BOTH) {
>>>>> nf = find_rw_file(fp);
>>>>> dl_type = NFS4_OPEN_DELEGATE_WRITE;
>>>>> + } else if (open->op_share_access & NFS4_SHARE_ACCESS_WRITE) {
>>>>> + nf = find_writeable_file(fp);
>>>>> + dl_type = NFS4_OPEN_DELEGATE_WRITE;
>>>>> }
>>>>>
>>>>> /*
>>> Thanks Sagi, I'm glad to see this posting!
>>>
>>>
>>>> I *think* the main reason we limited this before is because a write
>>>> delegation is really a read/write delegation. There is no such 
>>>> thing as
>>>> a write-only delegation.
>>> I recall (quite dimly) that Dai found some bad behavior
>>> in a subtle corner case, so we decided to leave this on
>>> the table as a possible future enhancement. Adding Dai.
>>
>> If I remember correctly, granting write delegation on OPEN with
>> NFS4_SHARE_ACCESS_WRITE without additional changes causes the git
>> test to fail.
>
> That's good to know.
> Have you reported this over the list before?

I submitted a patch to allow the client to use write delegation, granted
on OPEN with NFS4_SHARE_ACCESS_WRITE, to read:

https://lore.kernel.org/linux-nfs/1688089960-24568-3-git-send-email-dai.ngo@oracle.com/

This patch fixed the problem with the git test. However Jeff reported another
problem might be related to this patch:

https://lore.kernel.org/linux-nfs/6756f84c4ff92845298ce4d7e3c4f0fb20671d3d.camel@kernel.org

I did not investigate this pynfs problem since we dropped this support.

>
>>
>> The cause of the failure is because the client does read-modify-write
>> using the write delegation stateid.
>
> Does the fact that this is the delegation stateid matters here? How?

The use of write delegation stateid for read only matters if the server
decides to allow it to be used for read since it's safe because no other
clients can write to the same file.

-Dai

>
>> This happens when an application
>> does partial write the client side, the Linux client reads the whole
>> page from the server, modifies a section and writes the whole page
>> back.
>
> Well, the test shouldn't fail for sure. There are servers out there that
> hand out write delegations for O_WRONLY opens, so the client is already
> facing this issue today (I guess no one noticed).
>
>> I think this is the case with the t0000-basic test in the git
>> test suite.
>>
>> I think this behavior is allowed in section 9.1.2 of RFC 8881.
>
> Yes, agree.

