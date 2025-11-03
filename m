Return-Path: <linux-nfs+bounces-15959-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01B09C2E022
	for <lists+linux-nfs@lfdr.de>; Mon, 03 Nov 2025 21:16:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A54D73BDB2C
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Nov 2025 20:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9CAF1E0DD8;
	Mon,  3 Nov 2025 20:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="O1dhDoIA";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="0P0IdCDq"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67FC63D561
	for <linux-nfs@vger.kernel.org>; Mon,  3 Nov 2025 20:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762200968; cv=fail; b=QdETnppza80+kh0smuLeZuIqya8tc6icoLMXonh/iNU8P8JU35u9XX40f24CHv+BuaQ9WbfFmYPdeb1nj+pQVvMP0xJxkgUKx6hGqH7Os14tgSFPPv/nt+FllRghPf7extwWSukI5Kkt52Y4gew+BBI2TofkTnL4JS8PUeCf3hg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762200968; c=relaxed/simple;
	bh=xXZJsSdFkvV2a6nmqCQO4YDjye3Kj9Nx9YV/1nq/6q4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eObq4GLnPy+aC+GXmkreOgu7jk2sPTba8ULnLxPevPAcLJNm9DoyQQ5Ol+BkfmjcJH9BxI7F413KXerkv71BoIgpXr91dXKOhCeiUn/PKqcEzsNY0CZHJJPT/mG6v8lay0V8zuxUIIwqowNWgxUL81mY6ipki8tA2waTgOqPVDA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=O1dhDoIA; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=0P0IdCDq; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A3KAcI0018020;
	Mon, 3 Nov 2025 20:15:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=ttWN70Ohj0pvcIZTITgvjBALvItvFNjw7j95EsQWua0=; b=
	O1dhDoIApM/v2gwcR2vspmzbDvE48qy0qs/Ajl92j/mJbEQ+6BHPV6kRgyXTDjVx
	Fh0Xr+/GV8lK8DQechv8TC8hDCjHveJSqSbjLPaDbkgjjiZJZID/5MsuPvUIqTCR
	tJYHieqJZwIGh6rYC8CvGcOHfxG77r6VfF7EPcQ+OW4FmvWckS/K928q0mFsuuhv
	xcm1fKD2diK/RZLxBlKEFFo7QsXvulTsgg1el7zFh3rG62TrSxbxPpCR8an4sLHJ
	4tM44g0MiyRmtHPUt+vmSe8viJ21g0vd3BGbG/jb//QZzWEbB01Qe7sXQrP+LwIA
	G0zrQ+Nf5lA2+tvXnj/JMg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a736ag0kn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Nov 2025 20:15:54 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A3J1IsS015094;
	Mon, 3 Nov 2025 20:15:45 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013068.outbound.protection.outlook.com [40.93.201.68])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a58n8d9m1-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Nov 2025 20:15:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UxoYrwdaAK8B8cjlHzT34j9N9mEMeJVvnK16SLWogbLv0rI4eYSKFns5gWfxo0RRlXNtpcwOzYpnN4aN6oU1jloXCqObdWl/aFtXcuEam7RQnVkVc3KuAzEF3CwVUWYDOO3pDZybQERXmNWsL7CZRNzxwAnLlSHU/Rj1bYEQ4WunQwH2W2zEiKtD1K4DqXtiS9/5XKWoVYHatOD9GjCjBpPOIqmHFl2122KHRmB/ue4pidri9DAAD7EWH5BURTc+JfiLgCxd88JYuMxnAkDKQ6wGWp/2uT1yP74IvHajT9KwkG4b5zbWru/eTtZ3y0X1HLrk85ZWneuUnlS5bZtRDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ttWN70Ohj0pvcIZTITgvjBALvItvFNjw7j95EsQWua0=;
 b=FBQDIPukh/bg9/agMD15Lg8krbRlX9oBO4HyejooQXPvUtXILxPNBmVpA9ssPD0ZRSPYJ1lxLTRkKQhOHmdLsCxOWN7XkY1iOEcyIESXKmj3fTAPYaCesYZHDliEM403HuikJkBRtssMFrB70/sy8/YI9ttb0BGDDICLqPy1tEy6SO5T0ge9RD9Uj40AQxYX2B5LkCPoG3YTkM1kEnnDfeSOQq2+VtwfjqND+z+G2nF+Vy/HSDD+r7l5BaCp1qmjmUyXa6OfFsNAY4ufrKFzw0mvseGMouN8L+vRPjWmNcsZ865dddxEWq6syXTzq7N2NzY32dgUqVU6bWkRyZ/8Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ttWN70Ohj0pvcIZTITgvjBALvItvFNjw7j95EsQWua0=;
 b=0P0IdCDqomYgIlOl7aNd20HbiGzi3U6gJDqUH7rddPZ84DiUyhcycE+WlQEBVHgin93gP3VQjROpld4RdrO4xb32gT8Fh5aMKTEEnETFgFqqQrI1AyFW9JrZaqqw7uTiSm+5Io9hoRgJMy1f6XPMsnD4XmaflABCjkecUydCtMs=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH0PR10MB5099.namprd10.prod.outlook.com (2603:10b6:610:ca::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.17; Mon, 3 Nov
 2025 20:15:42 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.9253.017; Mon, 3 Nov 2025
 20:15:42 +0000
Message-ID: <40c969cf-9898-48f5-88bb-d6bed7b54a9c@oracle.com>
Date: Mon, 3 Nov 2025 15:15:40 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] NFSD: Do not fence the client on
 NFS4ERR_RETRY_UNCACHED_REP error
To: Dai Ngo <dai.ngo@oracle.com>, Christoph Hellwig <hch@lst.de>
Cc: jlayton@kernel.org, neilb@ownmail.net, okorniev@redhat.com, tom@talpey.com,
        linux-nfs@vger.kernel.org
References: <20251101185220.663905-1-dai.ngo@oracle.com>
 <20251101185220.663905-3-dai.ngo@oracle.com> <20251103114500.GC14852@lst.de>
 <841a3ef8-d5c8-4f87-9244-f79a10c66e3b@oracle.com>
 <b8489e0f-550c-4c63-8429-fb2d44f24c0e@oracle.com>
 <f0d7da8c-2447-4f57-a64c-6a8eb7853019@oracle.com>
 <f4ddebf0-7039-47c9-8e20-9622c8b33ddd@oracle.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <f4ddebf0-7039-47c9-8e20-9622c8b33ddd@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR14CA0042.namprd14.prod.outlook.com
 (2603:10b6:610:56::22) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH0PR10MB5099:EE_
X-MS-Office365-Filtering-Correlation-Id: 18182b4b-b71d-40e7-518f-08de1b15c376
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?VXduUGswTExpaFphL09RWEdWSWJ3cGt4Q3NBRlhhSGZpMU9waVovNkFNZmtr?=
 =?utf-8?B?c0tMMU93aGkzM0lXa2dFWnNvNTYzeDc5cHdjN0I1Nzk3N2xqLzJmN2VCL0l0?=
 =?utf-8?B?L002VnpHNzBtZzhIalpZL1V5UVlYY0MrWUY0K0tjTmNMTUc2QkZWSUxxWTZn?=
 =?utf-8?B?RW05a1hsZVd6UDNLZWoydGdhWE44WTcvQ3FvbmdpNUxMKzNUMHB5aDVQVmVK?=
 =?utf-8?B?aytncUVoSEg0YUZzQXVESlB3RDBTZTVsWDAzanQzZ1A0T1pNN2NCcGhrdmI4?=
 =?utf-8?B?WUJOd2liRkJRMEdOUWY2Q3ZtcHprU2h2Vk1sOXE1dGZPUmhGdHRxZ1ZHdkJU?=
 =?utf-8?B?aUQ4N0V3Ym5EZzA1aHRxV1h4QkxCQVRTWnEyNUR0TWNOamVaUjJNUE9nYnBF?=
 =?utf-8?B?R3BEQzN4TXBmVStpRGczMWlJL0xVMjRxUUFzTDFIeUdpb0VlTmluaXh5dzdW?=
 =?utf-8?B?WERJWTd0S3c4bXovMWt0L0FVTkNRaUVjdGhINmp6S2Z5RFRwdjNBMHEyWndm?=
 =?utf-8?B?WWVJZ3JJZ3pSS0E5Ym5kZXVNckZReGdCTjNzeE1UR2g3V0NFUEFqMk1peFIy?=
 =?utf-8?B?RDBqbDNNWmtuSno0d1J1Z2dFczhDNitsZ1pWV0tDS0Y2RktaUTRyMWhDTFQx?=
 =?utf-8?B?NXVLQkxKM3VrNTBBNlErcXh0UTg4ZTFhS1BtT2RHdjFRTHV5WHpYSlhyOGw4?=
 =?utf-8?B?Y3czaFR5VFF5WGExRGUyVVBNZGZuM081Q09BaVN5UkttYnN2d2c1VE8zNVRL?=
 =?utf-8?B?RTVFbG5nVXdHcE1ROUNDa25xNUs4bEpCd0txZkVHNGNnMU1SRVNlcHM5WjZO?=
 =?utf-8?B?M1ZxRC9rL3VsZGhnRXZhb3RiNnEvcklRUE90c1JmNE5lODJOdWZxRVpIajBk?=
 =?utf-8?B?L0QveE5aRkowamc0V04vV1l5OEdTTEE3Wm1WcGZGT3Y3Q0hYUTNUbVh2L1hz?=
 =?utf-8?B?cHQvTC9jK2R1YzVZV3VaMmtYdHBOWXd0VGgyaWxIRVNZZkV6a0twMGZUK0RL?=
 =?utf-8?B?eFl3U0FFVXREUmVZRGhxWlozWGNSZEw4SzQxenN2S0pRazlDQ3Vyd3V1Y1NV?=
 =?utf-8?B?U3hKRkZKVCtDWi9tZ0hTR0cxVUF6YTFKUlZ2bjROWTZxc05aeXNEUW1uZzJk?=
 =?utf-8?B?WDZQbHRiUUZyWW5sR0o5L09EWVRzTy95QlVIbW1iQS9STTlWVkdrVzBYaXBj?=
 =?utf-8?B?alBySEoyU0dwS0ovSW9IWnR6UXpNYlJ0c21vdmVmeERpTlVKTDBiZWUwcm1w?=
 =?utf-8?B?SkRkYThyRnY2M3AwbjlNT25LTHVXNTJEd1NqSnloYWF2VlBHWnJML3I5TnhX?=
 =?utf-8?B?czhBMFJqSit4cGZVWkkvMlRBMFpqNFN0QkVGb2x1RGg5YUhmMmVUSU9xZzZY?=
 =?utf-8?B?bkZmR0kyUmdyM0RBNTdYNytwS0Y3d2RzWDYvaHA4d3NuTDdtRHNzeEYrWEo5?=
 =?utf-8?B?NjVpL2FQU2JRWkU5YWJ2YTdScmYrYlcvaEhrZmZZT2lsTXJNbVZHTTBaZnk5?=
 =?utf-8?B?NFA2ODNLWmlKS1owMnhYbW1tRjhSZGEvZk5EZi90NnQzYm5EL1I5a013ck9x?=
 =?utf-8?B?bnMzVm9CYVJwcEZLNUJ5NzRXSkw4dk8yWW0rTVFpNDJnaCtSOGRmY1hZZVU5?=
 =?utf-8?B?M0ZpalFxNE9oWXdzWUt3WGl4Mm4yRDdpOTNHdFNBL2E1c3BsT0d2alZZa2hx?=
 =?utf-8?B?MEtRNzQwbzRxL3BDT1hEMDhLdWtCRlk3Q1hzdUx4QTJYcXJFdkpOVlhGeDdv?=
 =?utf-8?B?TjNVY3o5NVpocmZwd3JuYXFOOHZCRzV2VDAwT05OQ29QWUNFa1lEMFB0SEx2?=
 =?utf-8?B?WDJHbWdZUERKd1lZTFpkM2dFckFqQWlxR1V6RWxZN3Yya3RpU3ZuaTN0ODlm?=
 =?utf-8?B?NWh6aTNXWFpEcGVndDZIWFN6TEhiN0g3cXIzZ3Q1dEQrek9WeHJ0OVpnT1ZC?=
 =?utf-8?Q?4GkZQhJce1cgF/oZn5CoywzZfWmOUhuO?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?L1NNSXZuOVNncDFFY0QrUjJ2Qmd5M3Mzckp1SVV0WmtwMGl0ZlZpQWY4RnVV?=
 =?utf-8?B?VlcwVFBBVlVzM055V2FhYmpSQTJuZ3FYb0dML2RpcEFyUW4vMlBMdEcwS2J2?=
 =?utf-8?B?VzlnYUhlVlVmMkZWOWJXM1hiWnV5dmxaTmIwUWZiZkVEanUxMlNscGFndzlr?=
 =?utf-8?B?ZGxTTFNhSlYyenQzc0lXdDdUQTNlUWxubVFvN1F3eW1sWGlyNTVwb09hbCtJ?=
 =?utf-8?B?UHlhVkx6SktwVWZXREk2eVB1ekh0QWczT0dKY2FsRXNqNGNoTmJ4bm8zTnlN?=
 =?utf-8?B?MGtSQzRNSzl5Tk9sekMvUWFDSzRvRk5YVUNGbkJ5eWRVMHJVLzZnZUQvS28z?=
 =?utf-8?B?b3Frb3NNOGVtKy9Xc1dNYzVpRzNXTkRYU211dnVlaFZ1RUhOUTVoRHdtU1FG?=
 =?utf-8?B?UzlDcXhqNTY4ay95OHJKWDdyOWhBZ0pid0M5K2hrZHJ5bFdIakQ5ZFdxWjNY?=
 =?utf-8?B?Mkl3K2RLZDRYNlJRSW1OWWNPNWpDTWZjR3k3cGVPdHNKRnNteG1zTGxrbFo3?=
 =?utf-8?B?MWNLb3laQXByRit4S042TlhPZlAzMWQ5Ulh5bTVCWTFwcnExQk56elFERWFT?=
 =?utf-8?B?eHd2ZkFEbnVzeHpMTWp3clpkUVc5N204WWJqbEtCTy9YNklvUkwzUUhIcnZX?=
 =?utf-8?B?cXM2VnRyYlE3a2RIcFQ4WUlncFNiSEVHZDV1WmNBSmdLeFQ0QjZNUXNTMkc1?=
 =?utf-8?B?RTVDMnNmc3FNbjBELzlueXNiUU1iQTRobnlsYndmOUhpTE0yUzZuVmR5U1Z4?=
 =?utf-8?B?L2xFL3d5RVI3KytuWUZBY242UU0wK3NrMWxvQnBxWnVpbVVISlY4aFFnVE9L?=
 =?utf-8?B?VVh4anVqcjdFVEVCbC9qRG10NTBueGgveGhYTXRTd3FUY2toRy92S2plek1n?=
 =?utf-8?B?QkI5RDNDUDBzRGpRQ3RVOC9nWGxTQVBPMGFrcWRMVzRIUXkvQVVEdDBRLzFC?=
 =?utf-8?B?WThDS3dieHU2emR3T1FxR0R3UjBGdG0zMm9sWXVCWFU1dEQrK1piTGR6YzJi?=
 =?utf-8?B?d0hqOWIxWVI4bVlTd2kwSUNWTU5EMU9vWm9HZkZrYS90c0JjNlN5MG9mMndX?=
 =?utf-8?B?a2tMZkVTV0dZQTF5dFJhUXhGZEgvbWZRaG5Na1gzM0FtWDlIdzRPWUFXRzM2?=
 =?utf-8?B?a3hxMHlnYWxobXJxSlBVNnJLcnJORTF0Zk50QmdGSkxta2FzdlkxR0E3K04x?=
 =?utf-8?B?U01Ca1U3RUNYR0J1MFR1dmp1NGJLd2p2bkFET1I4bVJScWRycXJkQ3p1SHJh?=
 =?utf-8?B?V1haU1hoaExzY05QZUlZNCtqckV5VVc2bmE3TkhlZENFb2FXTit0UGRIckxY?=
 =?utf-8?B?VXNyMTVhZzFFUytEMWswNjBvVDFuQTllckVQT25KcnNLRDAxZnhyTkFlS0dY?=
 =?utf-8?B?UVB2eEpmNTJzcEZESVQ1OWlIUHpXbm5jbWFGUllBY01zUGtsMU5GWHk3VEo5?=
 =?utf-8?B?V09KQVNBVWxBM0V5UCsydk1kNEVQZGpDMS96b3Z2YXBHWUJ6YXVTbFg2cS9D?=
 =?utf-8?B?a3BqeXhRR0VVWkxLYVFXM1VONmFKSFJxM1NhYnloS0Z3SzBCMUp2MzVvYncw?=
 =?utf-8?B?d3c1YWg3blE4ZUtpb1l2L2xJQTVoY1hkMTdHZTNqY05nR3pvNDNEQVJhV0J1?=
 =?utf-8?B?TklIOW9JVVZzalVQQnN0Q1ZkNk5COWwxa0txcVBtQmhPNFAzMFdnaTJuaW9R?=
 =?utf-8?B?MFQxU3BXMjU5SldDMEN3ai9lTmZrV3pUeWVibGlQNTV0emp6WUlabTl6bWx4?=
 =?utf-8?B?LzNla0NHOS9OKy8wV2NUQzNtK1BxZDE1QUhMTExRZWJZZDg4VFR3VzZxcE9H?=
 =?utf-8?B?ZkFTUjR1NU5hajR0Z3JDakRFVllQaFRYbW1IS0cwUHFKb2x3MVVzSXY1ckQ2?=
 =?utf-8?B?YlBWZzVUTEs0RUhwTFczWUJ1S1l3aXY0T1hVNldmVzJZaFIzSVYxQ1VidkRt?=
 =?utf-8?B?OFVpdk1uUHo3K2FhWU9sVDc5VGhRU0hvcGNUOHJhWkoyOUZOemNuMXhISzZ3?=
 =?utf-8?B?bnNkV3hTWjVRbVlZRkVuZkxFVjNPa2t3WHpNSDQvVnVscHMvWDBUeDFpT3RJ?=
 =?utf-8?B?OFNtd3d2c3QyWkdrNWxDZE50RXZVUmJ3SFp2UE1sMU9WZVZpOGJoUGN6cGJN?=
 =?utf-8?Q?bkFdS10ymY8htbQQ0UsHuf6kC?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	BzJk/oFY++8098k81zP5BI3pP+ILC7hDq/6CZ54LnGU0tdS71kVg1yQHKlIM+Zk6ZfzNGQq+4eHFcXEDrHwYIn0iaQrTErhGsMIaUooP2Oqh4ANNSeg5EeoiBIG/QuP0HdhTiCGTyiwExLyCnoNp7A7AucWe63sQ1v90UF62AinC2jMiime/BzqC9qG4FJ+y+CKHKA2OcSaYjxaoVatVAkEIIFVfK5MynJVNL5mDgHlsQ/SeVoTOyUPk0VsjsfBItSSI3HncTPKYfQnLmEP7kN3RtF8G+li29AzZHvGov5mvosiiqUdYEfIOWCa4jFWzXE2ly7/Gozkk9ELXfs7NkR+ovf5tksS75fBSSqf7eyeRa918Gk+Rt4P50iupfnjR79if+oO1Rqc2H+9HLgP7ypfLotQ1trwa2P8faBqcIm024X9u7ZwZ4EXBgtA5YYGrCC17SwWGWImIBys1S/lYbM4YW/fSXwalT2f7fHDZNA9KG0L7rW1dHoSP2pXQASWFaEy7fI5PWYtKAALjbhU34Y5NNDQzrRGK2S2UaKEMmkxKAjgMYTdkWV2OKnzpOk+HjhxQWQpgEsS2BMqtqMqrXETvBqAeD9mjZkb04cR2f5g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18182b4b-b71d-40e7-518f-08de1b15c376
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 20:15:42.2217
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cvpHxBrk47o4t6fEKKc8l2lZhYxvPFuFFPanYCZ2ASyXbTeYfqUVz6Ie8i7Cc0L8cLkiCCuMRuMCVQvIbhjEzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5099
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_04,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 spamscore=0
 adultscore=0 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511030181
X-Authority-Analysis: v=2.4 cv=IroTsb/g c=1 sm=1 tr=0 ts=69090d7a b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VZVx88yVb4sPzVAqdqIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: yTZEK6tO2m1eegDNcXVMvFq0wFMb_5KI
X-Proofpoint-ORIG-GUID: yTZEK6tO2m1eegDNcXVMvFq0wFMb_5KI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAzMDE4MCBTYWx0ZWRfX+1zCl4wcpT3v
 ftLP2Bly3czoEgcvKXXVMJVvse9Sg9asxEI4M3VqD9jKgy6kE1+IGeK6dmKuMSrO7uZG4cffE6M
 ujnK1O4KBGrUZnpB9ozIYABHh2d6mi8pjsSZGIKtyt+hwq0z4x+XgEhHhbt4Bcpx+yuv6vn9Hkg
 /xEQ5NmCr6aCjv7eVFkmnvxNXCcoW5mb/1BHM2UrIV5ri3MvJcKOr5boYcMiXfquILtJzkO7XIu
 jLNs3In3woVbc+Ljh7cNM1iuS2JCetFYd/kJ96fIZRm/V9acg8obiZ9utlbvyiW0wso8X1ftdL6
 XqvFAX+0GI1qn6DLSbRFht53wTN4UZgPThbGypMmFsb03PV2dFHCUiL9gB5LXnVOSLqPprJCfMR
 6ftg9lYCc6m9WPoK9nj9eJUFTIvYCw==

On 11/3/25 2:14 PM, Dai Ngo wrote:
>>   and I disagree that fencing is harsh, because
>> NFS4ERR_RETRY_UNCACHED_REP is supposed to be quite rare, and of course
>> there are other ways this error can happen.
> 
> Yes, this error should be rare. But is fencing the client is a correct
> solution for it? IMHO, NFS4ERR_RETRY_UNCACHED_REP means the client has
> received and replied to the server, it just somehow the server did not
> see the reply due to many reasons.

Fencing seems appropriate when there is a clear indication that the
client and server state are out of sync. The question is why, and how do
we prevent that situation from occurring? And, when we get into this
state, what is the correct recovery?

I don't see NFSD doing this short-circuit when processing a CB_RECALL
response, for instance.


> I think in this case we should just
> mark the back channel down and let the client recover it, instead of
> fencing the client.

Clearly the backchannel needs to recover properly from
NFS4ERR_RETRY_UNCACHED_REP, and if it goes into a loop, something is not
right. I don't think this is the correct fix for looping, either.

I don't understand why, after the server indicates a backchannel fault,
the client and server don't replace the session. The server is trying
to re-use what is obviously an incorrect slot sequence ID; it shouldn't
expect any different result by retrying.

So, yes, there are one or more real bugs here. But ignoring a sign that
state synchrony has been lost is not the right fix.


-- 
Chuck Lever

