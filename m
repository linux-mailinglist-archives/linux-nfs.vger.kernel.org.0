Return-Path: <linux-nfs+bounces-9583-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71F71A1B862
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Jan 2025 16:05:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4936518812D4
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Jan 2025 15:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF6D146D6B;
	Fri, 24 Jan 2025 15:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CsL/CeQx";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="GQHvR/Ql"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2487D78F57;
	Fri, 24 Jan 2025 15:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737731149; cv=fail; b=XiCHSu6swJYNwkMBuh1LK6Tq/SmfNb8Y189A1Vh85Iagv6bqOivz50wo2z9v4XhW0zfQ+gnFbWT6wAyIsVGERYIJJ9vuL5iYtgm79cxj8+Xd7dJznFB+8jmeTOA1y7bCcAYdy5TSTXZmliMpD3/AAUZtGWwZPBlHJ3Kw0gRslxU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737731149; c=relaxed/simple;
	bh=SYjPWr/r5NJefrIfzAugqovH+OsdagdTZ/iOd/0w0Jw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PFi9dSMkDwPgljArOoJ1J6l9/dNkk6dKQeYN6sAhOJ5LhgHRuNnfbDtuXVbNvxGySkzbcku9cp0qiA8r1i/pqs8WLiA1hKOmk9zqoRYF7qqHCHeXiEz2Zn08L/epj2ALMGgtBKtzr54JYQt2MXIHz9DMKmCR4Fs78uY6xa6BjGM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CsL/CeQx; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=GQHvR/Ql; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50O8g1ng019126;
	Fri, 24 Jan 2025 15:05:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=8+P2bcnaibPiPukbnx8t+uNLmAXsgJbkXSuVa9Ymk4I=; b=
	CsL/CeQx1cMLdDnT6t0g7pT5THQlJOuI1MUyi7ahoQX4lBQp+Lhgp1B+kjtLuCj+
	JPCln8kLSWZeh8AG9xfLQSKDt1TuBDgUmBkHlbDGTGD1QEJx40MJ5flRswuZjWMS
	zQFTDj2nG/RsYqoo46rN8DsjDHK3MdUBwaKDTWbc0uec32hojn8ec/pfDDuqcb+F
	LWv65t3RGS3UfllxUDfER9MwDx3Baf+E6M2tN+HgrNiHS3RTnH7prLIAMTzHPtWc
	yZ9+PjE0sWMVtyS58wAgx3K5hOfdj2RpGtOrYU9Qf0QvZkEF06GngsG/NTIg4LYz
	VsJsH+C1XpvacKAtS0vtXA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4485qav71b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jan 2025 15:05:35 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50OE3J1j030424;
	Fri, 24 Jan 2025 15:05:35 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2048.outbound.protection.outlook.com [104.47.58.48])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 449196jkbt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jan 2025 15:05:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=akaiK+Ghb7BywTJk++U8dNQUJI7xRjKHMXzx2WWZPsoaJMUOrX63EQL41smnqbkAVkFhPEh6qhP9gi2x1vyRG+Co941opreOM3eAYZtn89/46yRiHkKWqy9C7TUzh11pae1hvUp+QlNpcq0qJNqS/hQHB55/vMaf9IQFdXt3GF0hSCaCJJg6ZktywurUN0R1/WAjRZYaSq5y1ydEoXumwg2Flu1QOwUhkT8EA1kE9jY+ugojVgw5ksv/N09iQ2Pw5v59nWSpXSxzPB6CcnnOwJBOoFRAvvEEgZoWvn+ft9SYKefXOYggOkiKrC4Jv37PvWYRvc5wF6Nn2pA2Rr+s2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8+P2bcnaibPiPukbnx8t+uNLmAXsgJbkXSuVa9Ymk4I=;
 b=jl2tawAXLHP7FpKoAdm148Dbg3uqZn83IKa0cHgiZ+GwWCWYWAJyLYcG7sb2To7ompRWUrWFObCaz5kcmwAbigUqiXa3sTtH4LxReatKDzX0UldJmurq4mbKFWwkLjfUmPrL7TM2dDBrd3TE1iBKc4JhyQlMwVL6DwvmCEj9SSEM0G1uiTJAqVLznrpFVscvF32kwmMaItjCWI29efTUFx52sOf8qW/SrkP0q5MZ4omT3MYPPgLfnJFyutDQXyFYpxGkjDBkHVcrMtjJ38wpf7EApktVDC/aJseYSnocLcew1eAVJyq0WU8f9uLc5LrHE+20fmqbqWRR9SiXKShbrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8+P2bcnaibPiPukbnx8t+uNLmAXsgJbkXSuVa9Ymk4I=;
 b=GQHvR/Ql/v/ZwSZtyNToM3EQYGV+y7ItU4ck2apcDpEyu5JdYuJBaY0FOr8DCrqSKkzcMYxCCLcx89CEtjnDZKTG0rZSB19usbI7ubd0ZDig6X/46je5+I8hFQuvsYvbeHYfY6zwIo/Jadjfax+asObs159LZo3WJXPIkvZfQ6g=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM3PR10MB7948.namprd10.prod.outlook.com (2603:10b6:8:1af::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.18; Fri, 24 Jan
 2025 15:05:33 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.8377.009; Fri, 24 Jan 2025
 15:05:32 +0000
Message-ID: <1f967fd7-17b6-402e-ac55-aba956ba0d65@oracle.com>
Date: Fri, 24 Jan 2025 10:05:30 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] nfsd: clean up and amend comments around
 nfsd4_cb_sequence_done()
To: Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, "J. Bruce Fields" <bfields@fieldses.org>,
        Kinglong Mee <kinglongmee@gmail.com>,
        Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
References: <20250123-nfsd-6-14-v1-0-c1137a4fa2ae@kernel.org>
 <20250123-nfsd-6-14-v1-7-c1137a4fa2ae@kernel.org>
 <8a6e1930-feee-47f8-8260-874b9c47f20e@oracle.com>
 <42ef9ff65c27fb7347f72e85b583ff74b2200bd6.camel@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <42ef9ff65c27fb7347f72e85b583ff74b2200bd6.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR08CA0024.namprd08.prod.outlook.com
 (2603:10b6:610:5a::34) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DM3PR10MB7948:EE_
X-MS-Office365-Filtering-Correlation-Id: ceb92ea3-99c8-487a-bf4e-08dd3c888c80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|376014|1800799024|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aFY2VVpYZ3licE83RlpMb3dmZXR6dWk3VTFFd0NJemdLbENUc1oybGFER3Zz?=
 =?utf-8?B?d05jM2xVOVNhclp1WnMxUzVEZHJjMTFVM1NEUFVrOHBBb2pvZmRnc05PbFlO?=
 =?utf-8?B?K2pTTVBtM1MvZTFjN0M4c0xvT2JLMUlXU3owTXMrV1l1YnZlTEIvUVpqbWll?=
 =?utf-8?B?OHQvU2Jqa2pYalF0UmNBVXA3K1pCMEZkQkMzK0tGbFZrUEc1VXhyNXNiV0cv?=
 =?utf-8?B?aUVicjFGbEpPVnM5eElGaHB5eVJ2aG0wRko2aDRtN3pjU1prMmF4a1N0ajhh?=
 =?utf-8?B?MXdHSFo1cFVTaWp6emtpZStNbnJVcmtHaVU1d3djUHEvNVZ4L0NDZGNLRU5i?=
 =?utf-8?B?WWdJMHpHc21NTEZIVWJpMlllRG9FL1NMTFo3cVRFVjdIMmNMQkNjUkp2OVFS?=
 =?utf-8?B?QWttVkVwWWs4Z1pYdklmNUZub2NRV29WR3hjbnozSEdtVGdzUml1c3k0RGx0?=
 =?utf-8?B?eWdvblpwYStjcTRXTHcraEF5ZEYwRnk3elhUMXJLdGY3NFNSVnV0K1o4cmVH?=
 =?utf-8?B?RTVCYXIrWFpjL09oYzBrYTV0aTVSaU9hOFV5cjZaNVg0TzZlS2N5VklqM0xJ?=
 =?utf-8?B?TlJqVVA2eERQcS9FSUlPVm4ycnNwQlJhY0lQTkg5SlZCVTg1T29HR05tN1hL?=
 =?utf-8?B?M1NGeEFoeHlOdUNUMU5HVVp4WnRvbU1OdVNnenFKQU1rNmtXUWRlUVRURHNl?=
 =?utf-8?B?ZlRteTZMR1gybkdBbitINXRzTGJsRC9keWZlNUtuaG11WmZaaWdGSisvV2dD?=
 =?utf-8?B?cTVlUmYvUUk4OFdrcGYxZDc5L1BiQ2RBWXpIZkt1N3dwdm8yQ3B6bUNaN2Qr?=
 =?utf-8?B?VW5BaC9EekZnSlQyWkhBaHczNU5keFdTS0tRT1kwWFJjQkJxWXNuNEZMeHBM?=
 =?utf-8?B?SjZGN1h3cS9rNktHd3lBMTdjSS9tYURUU20yVXR1QVdrcFJYby95Q05mbEpY?=
 =?utf-8?B?bFR4NXV3eUxtTVJQR0o2eXEvVGhMUmpnL21PeTBNbGVlNW5xMTJyaWFQWUJQ?=
 =?utf-8?B?OHFqWXlLVUdOT3pUOXY0U0lxNTYyU2NNcG41dUg3UXpXbUdac25TN0RUQTRz?=
 =?utf-8?B?SGhYZWx0aFNVcFc5eEZRZDBXOU5sQUhlY2VYNHN3QkZPbEdTc0tNcSsybmM5?=
 =?utf-8?B?R3JPUHVQQzFOQW1jbTZvU1ptc0Y0Rlh0cU5DaU5sazVab2NUazkrWkVVMFIw?=
 =?utf-8?B?YXowMUsyQ1oycHhHc2lWUUhqUmo2dzgyak84TnFGQmJyNkdGNFUzcFdzVXla?=
 =?utf-8?B?QkRxQ3cvVDVDRkY4M1Rsa0wydlhoN1FVdFhCc0RtNkZQTEZzcmlTbFJhQlV5?=
 =?utf-8?B?SiswUVV0ajJJcjgvRVY1Q2F1ZWZIWFpNSzVaeDhGR3Vpd014dTFvM3ZvUUdG?=
 =?utf-8?B?K0hSWnJwT1Q2OWk5QWYzZ3YyZC9XaGZxeVpCQWxNL3Q5ZlpVKys1YnR5d0VB?=
 =?utf-8?B?SzdvcVZjTzk0K2pNelRMV1BUQjY4UlEzbG9wMzl4NUR2VDJyOFVaeWUzNmRE?=
 =?utf-8?B?M2FiSzRveGNKdk9odWZPanlZend3RU11NlIwV0tuSXdKZitla0lnRVBhQ0xZ?=
 =?utf-8?B?UGhmRW1WcVFNdmliMWNzMTVPR2NTYURnKzM4Tmx6NFYzU1RrVnZDWVFSOFVl?=
 =?utf-8?B?Q0JEczhUL1h3MWZ4Sk5WMjJMNlYreDBzck9NK05CZUZVa3loUnJuVjJCa0cw?=
 =?utf-8?B?Y0ZDbnhua2FOZkZSVHVzSWNLWThWYldDVU1wVlB6V09zNVlheXRIQTQrWlJH?=
 =?utf-8?B?dUxnZ0hLWUE5SHkvdnRuNG84bUs0aHcvd3M1QXZIMWVsZkdheEZqQUNPNlFT?=
 =?utf-8?B?NFlXR0NjU3ZqOEh2d3Q3aUtkZC83aTBhMFIxL2J5UFo0dk1VK2lDcy9iWjJi?=
 =?utf-8?B?cVRzVUROeURpNFpRVGhLUGNHK1RwNzl2dFZCeS8zRmRKRnVidC9JM2poRy9X?=
 =?utf-8?Q?7NDZ2PhTKeg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Ri9WK1dVWW44QkJQL0JEZnh4UzRaeHZqN1J3VGlXQkQ2QlNDbWt5WXlkYUha?=
 =?utf-8?B?cDVzYlhrNDNNeHpoZ1NacGZHN1Vld3cxV2VYS2NadWtGTk11VDRJSGJWdDVo?=
 =?utf-8?B?ZE9ycisrRWl1SHdsVkQ4eU1hME1sOUo3bzBGZzJLWDM1SEVtMzNITHlIM0dw?=
 =?utf-8?B?WS9ya1Z5Q0dVUlVjTFY5OERqSkRveS9RcEhWRlg2MVpkc2ZXZ3FYUUdTOG0x?=
 =?utf-8?B?dnR2TG1XV0EycHRoRzZXNFRrYW01SW01RlN2UTQySmQ2bEttTE9wNmZSc1pF?=
 =?utf-8?B?RURsSzNvcGt0MWV3aXdtd0ZkNXVpMThoSHVMWnZFSFJQVld0Z1VoUVVBVzU5?=
 =?utf-8?B?ai9HNjdVQllzYXZIK3dLcU9Fck93Y2hsWWRHZ1pISXVtVjhKNnBsa1A1Ykgr?=
 =?utf-8?B?VlRFNHBGRUhzVTZMZVVSd3pDb2hNU1JwSkcxSnhzTGtCL1plVzRoNU9LQnEx?=
 =?utf-8?B?SHhkeWY5amZibStpb2dRZExHRWdjTDd2ZkFkdHpKRjh1Q2pWeVNaZWtRRU1R?=
 =?utf-8?B?V2E5ODFNRUxmN0hYc1hsWHVSUTF3S0xNRThGVGQzcm1zZHB0VndRMDh6RWZk?=
 =?utf-8?B?cU8zZ28zVnJVVHpta1pzbFp2YzFsc0JWSVZLSHliYVMvdDgxeFF5RWJUYnBh?=
 =?utf-8?B?ZERVV1p1Z2pyM3BxZGtJb3dFeVdkYVN3TGNkMHVSQTFzREJkVHlBREZUMlJW?=
 =?utf-8?B?cWE0TjJHRG94UUMrOEw2TjY4U1gyUUVmUlgyZjl0RVA3SjFmQkpDa21HYmk4?=
 =?utf-8?B?UlpSS05EaDNHanMzNjd2eXNNaVpZVDRUZG1COG9uTEovVTlLQzViYlBvSFR1?=
 =?utf-8?B?N2FOcVJVS2V2RU9kWU9EWmZIaG5teGkxZTJncHlVejVld0VnNmNvVmwyL29W?=
 =?utf-8?B?cGVCc1k4bGs1YTg4Tkx2c2N5T0VyamdKOUowVDNQYVRGMlRoanhUcGRZS3ln?=
 =?utf-8?B?Sk9wQ0cvN1l5Q2NyNmczSDlKU0pxSHpGMk40dGZRUFd3UTVtNEs0S3BZbmkv?=
 =?utf-8?B?S21xZDA4SWRCYkhVNVVrRkhrR3BVSW5FcHBHQi9IZVExNG1DSUpHbVpDemRu?=
 =?utf-8?B?ZmxkTTRwS2kwdlJOU3NLQm51b0RKdm5TTjlIcTR3WTFrS1g2WE54OS9CYnZX?=
 =?utf-8?B?V0R3TXRscldNMVFqTDR6WHJaT1NORnR4Vm5zRVQ4cUI4OVhzamcySVJxZXNm?=
 =?utf-8?B?SjNTQk15Mzg0R0Z2akxpREZka0MxanZaMFZhUSticm01dndtcG1GMlp1Mjgz?=
 =?utf-8?B?VTVueDhMUmJRVVVDeTBmekpjOFJkVTF6d3NMNkZRYlh5VDhtSDhrcVU0czdu?=
 =?utf-8?B?elE0clN0ejdMN3ozY3ZuZUovSUJhS2phN1JCM3JmSDBHN0dic0N2Nmg1TUxZ?=
 =?utf-8?B?RERtRW9uYWpMZUR5OTRnTDJ1Y0Q5ZDMrN3l5NlBSWXNxa1lJeDZxL0hnM2Zq?=
 =?utf-8?B?aktVTmxWcDg2Y2VJWHFidkRZbzQyK3JIcXcxL1YyeEJOUU9EZ3FxMTd6R21v?=
 =?utf-8?B?MExVM3FPTzV3SVFzNHRndjdCRDNBck0vdEJpbU9INWhlR2VwL21ITUlWbFZQ?=
 =?utf-8?B?WFFxVDJRNlhjbmo3RUVwd2wxS2hFYVBzeHZLcnZzclY2SDJ0ZWJCS1VkcU50?=
 =?utf-8?B?SWE3T085aGpSRExrRC9rbzZIcmtxdFluOTJLeHc0S0tQbTNheGY3SmN0QVZW?=
 =?utf-8?B?NjNwWXlYOUo1UWlKdE1LY29JK01hRmk1Vm1nN1RMb2wremUwUHhxd1F2SFVL?=
 =?utf-8?B?clE4WUNPSzBzM2UyZk9PdDZVd2FDbVVrUit2eDVxd1dRaFB3NGVDZVp5dVcy?=
 =?utf-8?B?L0VKR3AxZ0xrTjVoTlBOVkJBNTZVUEorbERyTWdzMWFzdVhrRUhDYTlIWktL?=
 =?utf-8?B?RGpQUFh5RnRNRXJ1U0dGNndweEpIOVBjZmFaWVBpMUhWZEtGVEsrTE56eFIz?=
 =?utf-8?B?aUVEQTZhcm5YUWlOOU9NcHEzQ09WSWcxZUlpdXo3RkxTK3duVEtUYzZsejJL?=
 =?utf-8?B?Y3FVTTg5OU1tczQvR0h5UUkwVTRJRU9nejdQeGZQaVZ3Uk0zUjZ2ZDdZYi9h?=
 =?utf-8?B?c2syMEc2VEpTNVVnaENWRi8xUmd1eWo2YmtqdVloNkQ2aTJwM1BQSEhpcG5m?=
 =?utf-8?B?T1BmYkFsS3QyN0hEa3AvMFErSlJ3anllUm9iNVpPNExYNnp4YTh3UG02NVhX?=
 =?utf-8?B?eFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Wu+LgUp87GF2My8FPhoKxKpsmE621EL/4dBdPa5TTI3CH6aAqpstpAkp0T0cBHey/fo8++I0vdSCjQNLax9d49m0bMHKKKGh7GAMxzdlYOLtvV7Ke2npct+nFbkMoTWtLKYAdQyrkJrQtaEn6trvlbQUctJ3/97bZrroSZySqWAI1PS/npTRM+z+6p+beKrIEBk4Ew418I2I79/Z2bOvROX4IxXt+vBaR5OwSFWHxwLP0SsFeB/OJvjc8FeAyMPxEbHvrPvUpA3LcP5FZ1oJC7uk3KjpGVmNcUxj20PECkHh3hrIjHmUUAW2L6ukQXLHOvXNw3Ox9rQ+Vt7Ic4586Zu8J/FMp7Mg8yejJ9QwPyxn+65Zw68x9NJx+4j6rhe31ETBNrhQMtPAhnc4ySoUON6mrhATOLEIcbph3bGOZYriDVxz++mTD7VEYzi6l5jTIIWZgiGWBZlmXF+qr8v0Og6JE0FXpoF1r7Rtc6HQptO3K5PSLd/BOkDsSgUbvOlHK9EZXH9a8Q80VjkdSu65RDSToQxLn7usdv18WZ9ih/0BFG82OseW7nj9TRdykjTbkY/TzVgsEZQYdXbIoVYJDVpY3hkijgFh5Jp0nLOzxfo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ceb92ea3-99c8-487a-bf4e-08dd3c888c80
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2025 15:05:32.8098
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vOEH68lwSSP/9jhN4biPhSV75w8PrEUeISp1ztBAD0LTHXYwIav/ZXNDlBsRIoQp5IqIyL6L7r+k0PhSAsYTAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR10MB7948
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-24_06,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 suspectscore=0 mlxscore=0 spamscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2501240106
X-Proofpoint-GUID: n3NynsyZcWP2nvFKA1H6aoVCXRaHdUom
X-Proofpoint-ORIG-GUID: n3NynsyZcWP2nvFKA1H6aoVCXRaHdUom

On 1/24/25 9:50 AM, Jeff Layton wrote:
> On Fri, 2025-01-24 at 09:43 -0500, Chuck Lever wrote:
>> On 1/23/25 3:25 PM, Jeff Layton wrote:
>>> Add a new kerneldoc header, and clean up the comments a bit.
>>
>> Usually I'm in favor of kdoc headers, but here, it's a static function
>> whose address is not shared outside of this source file. The only
>> documentation need is the meaning of the return code, IMO.
>>
> 
> If you like. I figured it wouldn't hurt to do a full kdoc comment.

Kdoc comments are pretty noisy. This one doesn't seem to me to add
much real value -- its callers are all right here in the same file.


>>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
>>> ---
>>>    fs/nfsd/nfs4callback.c | 26 ++++++++++++++++++++------
>>>    1 file changed, 20 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
>>> index 6e0561f3b21bd850b0387b5af7084eb05e818231..415fc8aae0f47c36f00b2384805c7a996fb1feb0 100644
>>> --- a/fs/nfsd/nfs4callback.c
>>> +++ b/fs/nfsd/nfs4callback.c
>>> @@ -1325,6 +1325,17 @@ static void nfsd4_cb_prepare(struct rpc_task *task, void *calldata)
>>>    	rpc_call_start(task);
>>>    }
>>>    
>>> +/**
>>> + * nfsd4_cb_sequence_done - process the result of a CB_SEQUENCE
>>> + * @task: rpc_task
>>> + * @cb: nfsd4_callback for this call
>>> + *
>>> + * For minorversion 0, there is no CB_SEQUENCE. Only restart the call
>>> + * if the callback RPC client was killed. For v4.1+ the error handling
>>> + * is more sophisticated.
>>
>> It would be much clearer to pull the 4.0 error handling out of this
>> function, which is named "cb_/sequence/_done".
>>
>> Perhaps the need_restart label can be hoisted into nfsd4_cb_done() ?
>>
> 
> If we do that then we'll need to change this function to return
> something other than a bool, and that's a larger change than I wanted
> to make here. I really wanted to keep these as small, targeted patches
> that can be backported easily.
> 
> I wouldn't object to further cleanup here on top of that though.

There's no reason to document the 4.0 logic if it's about to be moved
out. I strongly prefer making the code more self-documenting. Adding
a comment here about 4.0 then adding a patch on top moving the code
somewhere else seems silly to me.


>>> + *
>>> + * Returns true if reply processing should continue.
>>> + */
>>>    static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback *cb)
>>>    {
>>>    	struct nfs4_client *clp = cb->cb_clp;
>>> @@ -1334,11 +1345,11 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
>>>    	if (!clp->cl_minorversion) {
>>>    		/*
>>>    		 * If the backchannel connection was shut down while this
>>> -		 * task was queued, we need to resubmit it after setting up
>>> -		 * a new backchannel connection.
>>> +		 * task was queued, resubmit it after setting up a new
>>> +		 * backchannel connection.
>>>    		 *
>>> -		 * Note that if we lost our callback connection permanently
>>> -		 * the submission code will error out, so we don't need to
>>> +		 * Note that if the callback connection is permanently lost,
>>> +		 * the submission code will error out. There is no need to
>>>    		 * handle that case here.
>>>    		 */
>>>    		if (RPC_SIGNALLED(task))
>>> @@ -1355,8 +1366,6 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
>>>    	switch (cb->cb_seq_status) {
>>>    	case 0:
>>>    		/*
>>> -		 * No need for lock, access serialized in nfsd4_cb_prepare
>>> -		 *
>>>    		 * RFC5661 20.9.3
>>>    		 * If CB_SEQUENCE returns an error, then the state of the slot
>>>    		 * (sequence ID, cached reply) MUST NOT change.
>>> @@ -1365,6 +1374,11 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
>>>    		ret = true;
>>>    		break;
>>>    	case -ESERVERFAULT:
>>> +		/*
>>> +		 * Client returned NFS4_OK, but decoding failed. Mark the
>>> +		 * backchannel as faulty, but don't retransmit since the
>>> +		 * call was successful.
>>> +		 */
>>>    		++session->se_cb_seq_nr[cb->cb_held_slot];
>>>    		nfsd4_mark_cb_fault(cb->cb_clp);
>>>    		break;
>>
>> This old code abuses the meaning of ESERVERFAULT IMO. NFS4ERR_BADXDR is
>> a better choice. But why call mark_cb_fault in this case?
>>
>> Maybe split this clean-up into a separate patch.
>>
>>
> 
> I'm only altering comments in this patch. Do you really want separate
> patches for the different comments?

Why call mark_cb_fault here? If NFSD retransmits this operation on a
fresh session/transport it will just fail to decode the reply again.

Do we believe that the decoding failure means there was a transport
problem of some kind?

It's clear we do not understand this code well enough to update the
existing comment, so my review comment above suggests a broader code
change is necessary.


-- 
Chuck Lever

