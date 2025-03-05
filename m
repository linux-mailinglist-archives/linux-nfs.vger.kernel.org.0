Return-Path: <linux-nfs+bounces-10483-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03375A502AE
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Mar 2025 15:51:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D0E2177CC9
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Mar 2025 14:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C524024E4A7;
	Wed,  5 Mar 2025 14:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="W94EF1DU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="o1JdeUfq"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C9213959D
	for <linux-nfs@vger.kernel.org>; Wed,  5 Mar 2025 14:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741186000; cv=fail; b=j9AJajEtUB+JT5iMQ4AqH5hdfRfEKSS1HofMCbbiAY9VvVKY5ZDTyIlI7bYBePj1IN5rsTiLW99YpNTXfnYrvtwNBNcG14j1fWJhgFE1XNr9hfKx1upAX2mkdzyrOFfs7+K+M/N4S2xmAdEoWQsJ8VZzP2KyXmSTVUCrrKaItiQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741186000; c=relaxed/simple;
	bh=A8zrvSPVtGi3qQm/tNrWavVTo7fOwJvihzGR4eE9tI4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kmloAgLj/DsFoRQAvGgzs0pS7QWro9c9e7lwmiyfsTfZv1ZnQ8npSU7U1VW9RqUqUWED0fUroxJUfMuxjmGk+qDqA3je76CucVz79BIwQt3GfEJvowYqWygSUXR0607Ey+bA9c2BpKgrjZlfheCULFfYgEVWpeakHRE3ZA8nJAI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=W94EF1DU; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=o1JdeUfq; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 525C4998031897;
	Wed, 5 Mar 2025 14:46:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=dv6DSZlNQZmYP+bP5r5Qr2Hnu+dcHBItch5efK2rAuk=; b=
	W94EF1DUunVnC5K/64jNmgbG5QFmCygYwlH3BX6Z3vZ2Lz8RRBZJNsK5HSkKhy20
	LYMATHMeFp4O+oR36MnuRsgzEUtQroUGUqrr1ZLOZZgBUeEvfSs4JH/T/fkvWRkB
	t7k998OH6dfQIkgq22lufzkV5A9M00MaFi7B5Yb1+KvYIUhCpmoMsM4zPXpaWKU3
	8SBqfkgYeHNOKBRMP2JFx0htv7u4ibqJVPfhxo7pbV8o5h6wU1WShfyzh/IytCXx
	xEHTlT45aP5En+LdDQj7epHOIbpUPU8iS82xHCJVc6xNB1TqRivG+9bPbgrAn2rE
	TCIqZsbqDARgfT3mDjH0mg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453u8hftut-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Mar 2025 14:46:25 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 525DjFGc019915;
	Wed, 5 Mar 2025 14:46:24 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2043.outbound.protection.outlook.com [104.47.56.43])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 453rpbpk81-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Mar 2025 14:46:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kPX46zEpIrfTI2CHodpbeoVefgaUh+Lx2IUp7Kb6KQILrwxXosWYqP50QITN8eu2mB+hrAYMgpkFIpSEtAazATko7F/DXulwvQnnWR02jDaQgR8/U9VRmo8k2HCieB/g89e+dcSgZDNVmqFqu6TeGyci8UBq4fCLYId0sIaA07arQYvKce8Vth7/uBkbLwffUDlDu6pulGmddUlTNo9qLDwINscs71hG3b0mkTAtvoIou3CSBPrhXxgZCeTbFroDELQPwd9oiSmQldUqdqHmViHSVNji9S49J1BOHuBzxhPgjrqo7lPaPBIhFais3D6mXd2q5ln3NIVUW8vBjqOz8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dv6DSZlNQZmYP+bP5r5Qr2Hnu+dcHBItch5efK2rAuk=;
 b=PVzxiEDXYwuk7GoDRN8ikgMfaMoYPQEiMH/m2hBZeUaO4C2NP8KESMx4gIYqmS04bT0yMW8w6bdWHNvARn+IIk5RGHH9ZC2uOWve2uVA5NyAhQwD8Umuk5hax651WOUbI6j3m8GEI5KcxCbbEol27LQXZk7h216XE9bEX7K/uOFu+b+yF0eusrWcLZy+gurE8auMiQrZGzJtkyZWit7hPxHqckEjTrlmKru9WUJqmvcdTQ1/4AdSa5+sDRptl3dLGYzXmrNbpotB6hsMWbDJ7U7fMpVbJ3cTy4SR7ukgr34uJ+S8gtgjBPaY0qAtSg/o7YgYgPz4e1X+K1H5ZcxJLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dv6DSZlNQZmYP+bP5r5Qr2Hnu+dcHBItch5efK2rAuk=;
 b=o1JdeUfq5AM7i4PBs6XCM7sqFTDHPGwYYWJ1+Eti6RLU7Nbxn0wA4zCeBIXSi8E0LZSfEW4h2mXXHOpu8rLq+RBIECqdZTRcmf/Tk3yLfvuyNsGP/rjRocWoCYjMIecuR+i00KVhURq01KvK2DuoKzV++fJ34D5GTOTxkPH1yaU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ0PR10MB4734.namprd10.prod.outlook.com (2603:10b6:a03:2d2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.26; Wed, 5 Mar
 2025 14:46:22 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8511.017; Wed, 5 Mar 2025
 14:46:22 +0000
Message-ID: <ac7d9408-c1fd-4f4b-88a3-162a9f3cf176@oracle.com>
Date: Wed, 5 Mar 2025 09:46:20 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 2/2] NFSD: allow client to use write delegation stateid
 for READ
To: Jeff Layton <jlayton@kernel.org>, Dai Ngo <dai.ngo@oracle.com>,
        neilb@suse.de, okorniev@redhat.com, tom@talpey.com
Cc: linux-nfs@vger.kernel.org, sagi@grimberg.me
References: <1741120693-2517-1-git-send-email-dai.ngo@oracle.com>
 <1741120693-2517-3-git-send-email-dai.ngo@oracle.com>
 <22c1c21fde3a5b17851207664571341e3dcfc315.camel@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <22c1c21fde3a5b17851207664571341e3dcfc315.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR12CA0012.namprd12.prod.outlook.com
 (2603:10b6:610:57::22) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SJ0PR10MB4734:EE_
X-MS-Office365-Filtering-Correlation-Id: ec2d7970-b8cd-4bb9-2baf-08dd5bf47f44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SmpkaXEzSFJicXBMeTRFU2tPSlpHVW9zZ0lOdy85eU1IR2g0UVBpVXpETk1K?=
 =?utf-8?B?V0pBNkJ5UkxXOFlLZ1YrekVQN0wzeTd4a3E1aUJ0aHRxRGhiVmV6MWU4ZkVO?=
 =?utf-8?B?WENwYkl2OXY1ayt6ZGpGbEUzdzZoaFNYNjFHT284ZjNNckkwNC9MZ1Vxbmlo?=
 =?utf-8?B?QjVvc2MyVHhNWExaSm4zbU5oY3drYU1ibDVQVnNISmtXS2VaTUNiTWdzUnNl?=
 =?utf-8?B?Y05vSmtRWTVLZDg0bVBtajdnYzd5UnNNRGl3WEQvRmMzdlR2VXo2bSt0djU2?=
 =?utf-8?B?dmQ1SFNIankwbFlKWXNZWDJRS2tkeVpXSk9nZ1N6WXJQYWxhQlFGeVpXRlNq?=
 =?utf-8?B?aVEra2hSajIzV2dub3BJQmQ3b0hyZEJKbE1VamdMV0ZFOW1xaXJLV0IwYlVV?=
 =?utf-8?B?ZnFSUWdLNmtYVUx5QVAyLzQ4dnB5by9DV3NyQXBwL1pOU05wMy9OWWpvVWFm?=
 =?utf-8?B?bUoxc09QbnFLVVF0Z3gvVU93VFVIVG0rbTROTlVSd1VEcGZ1Yzk2OEc0d1BM?=
 =?utf-8?B?cVRPVklVTDVZeHM1bXpsYVlyRzJvcEw5ME5JZlFkQW9rVjE1azdyamlKeUF4?=
 =?utf-8?B?YkkwMjNDZ09PV0lSc05NS3E5MkVsTENFY3B4dTlCQkx3T1c0YVV0WndQa20v?=
 =?utf-8?B?ZGh6MDExam5iNWlUMEhySUhRdEpPbUlxZEQzTU8xYmx3QlBFVUdjM25sRndV?=
 =?utf-8?B?NmlaT0hDMDgrWXNGUEV0UkFXUlFWT1l0ZExaK0tyT3JrMk5MN3NScSt2M2Ju?=
 =?utf-8?B?dE1XWTlmV0FSQnMvRjMvQzF0L0k0dXR2NG8rRjUxU1RodVNHZldDLzRNTUtv?=
 =?utf-8?B?ZUlYblpNU3ZjSEJ0UE9nT2tHSmlnWUhyWXp0YVk5L3Z6ZG51MTZQQndsQ2FG?=
 =?utf-8?B?RURObmtXemVRR1IxNzdKVmdackRlMTBUeVZ5Y1MyYlRJWERBQ3ZSVHgyRmRj?=
 =?utf-8?B?TXRDanlqc25LRm16MGhaS1VGNjY3RVI5OXVKU3dJZGJnU1p5MnhubzFFVmZu?=
 =?utf-8?B?aVR4a0Rpeko4SjJSL3A5VzE3cDlOczV3NFJGYW01Yk9EbW4xanhDNExwaWYz?=
 =?utf-8?B?VGUzS3lNTUdBN0xYYkQ2V3RrdjQ2REhUM2VOTUtBTlhoVEkxMHVTcDgvM1pn?=
 =?utf-8?B?cFh5ZFZXYUdMNTk3a1FZTkMxTm1EcnYrcDU2TStEK1ZWeU40TGFMNktkbC9R?=
 =?utf-8?B?bDIvTHFNdTNBSFlKcEZpZHgzKzlTWmxjZ1RocFRFY1RqU2dIL3ZWWmYwbnFG?=
 =?utf-8?B?SVdvMFh5NVZxTUVPTmJvd0xRbHhTWmtLNGNLa3ljMENIRjYwSi90c0gvTi94?=
 =?utf-8?B?SkxIUXczSUYyYy8rcUorYXFsMmF6L05pRGpoZndKWXhxaG5xQWVzbFYvTVMv?=
 =?utf-8?B?cmxzU056WjFyVnFvVjVRTGJLb1VYVFFuNEtBVEplakJmb2NnZkcvMmJnbm8y?=
 =?utf-8?B?MmNsT2ozbTE3cVY1STFQTnFyWmxTNXg3cWJYbDhKdTEyQW14QTZoeTlLcVdT?=
 =?utf-8?B?MHpNc0prcTErck0wVHBrNXVCSEN3bG8zRGs0UUVHSWVwQnNVN2lTK2tvSXNn?=
 =?utf-8?B?WFMxUDNLY2owQ0J4SFR4N2dsM0VnZmNYa2RuMW1qdjZqV0tDR1NqYU5FckhK?=
 =?utf-8?B?TE4vRVFiMmVsby9rT3A0cFRCRkU1V1VFUzVRVXg1MHI3R2xzSnplc0k2dU9p?=
 =?utf-8?B?N2RmQXFiMUhLY213R055MjdVbG9rOTJQdU8xNFU4a1FHZFdldW1IUUtCTjlL?=
 =?utf-8?B?WXgzUnhtWTZBVGhGbHY0VDNhbm4zeEkyK3AwaXp3RldOTU92YzBNVXF0UDBG?=
 =?utf-8?B?bkNFT0N6aFpQdk5naVpJTFdVcitSVlNSWjJxTkhPVXEzS0lkRll5V00xajlt?=
 =?utf-8?Q?hpNfv6X6x+fUE?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R0I1d0MxbTJpWUluTThyYTIwV3R0NEJEMXJqdVZOVnRZcGFsL2JlUkp5US9H?=
 =?utf-8?B?cXBQY1luNWV3b0ZFZkxHL2pJUEtLZlE5M3lLUENaMFM4RlVEOHM1VDFFVmhQ?=
 =?utf-8?B?TXc3VElIRVRDMkNmVlRib1ZGaXp1ZUZpSG5rVmdRUkp2U2RzTE1oWmdkL3dO?=
 =?utf-8?B?QmNTOS84VVkwTWMxbWZGZkkweVYvUUdjVWZYeExDNDUzMmxZZ1ROR3h4QUI4?=
 =?utf-8?B?bGdrWklvL2RYd01MWUl3RWNuNzkrNHVQOXVhSE9FL3Y2cVJoMjhZcWRPTjdk?=
 =?utf-8?B?L3ByTXhUSDdmRWNOSW93Q2xXUGlKTWp3RUNCWjdqYjJJOWhCZTllV21wNkZV?=
 =?utf-8?B?b0QyNkZqYTJER1FTS0EwcGZ1d2N0UUJmbVZqMGpHUERoYmFxUEovNkI4a1lp?=
 =?utf-8?B?VzdwajNISzVwMW0yMUJDTUtmV3YxaEg4NkNabFgxdkl4VmdWOEpySlNTY1Ay?=
 =?utf-8?B?b1hMNFpNK1ZKVGlQZVkvYTdDQzJBMTEzc29GcCtoQzY2cHF3WXVpRmJVNzhx?=
 =?utf-8?B?UGVMdjhlQ2JzMC9Ha0xsRm84ZjJ4NXdTd01wUy82dFM4L3duVHZUR01oblha?=
 =?utf-8?B?YXA0cUdGZFp1bkdXUVNhZG9EVkxxam4wL0NoMElXQzdNdTgvdW5SZkJ6QkNt?=
 =?utf-8?B?WHBIY3VUd0wxZ3NvOUJLNDg0anA2UXViVkJnU0o1Y2tRSXBVU3A3OWRGL1B2?=
 =?utf-8?B?TXlkdWtwOHk2aEEyM3czKzdtU2trNU1jMy9KZVJUK1NubkVnK2EwbldHeEtW?=
 =?utf-8?B?RGhhcEZiTWhQejlCa2p2VTI1bTJKbGZ0bUpIbnF6TDU1Snl6WEdVdW41bkw3?=
 =?utf-8?B?KzhBRnk4YzlVQmNnVUxrYitlQmMwZ3lXK21ubFB1OW1jR1B2OVQ2SXN1SDlW?=
 =?utf-8?B?V3VIdXowdGt4RmtzNWRvMkllbUVJaEdoK0hmbFIvTU15dlpLb0NPZ1JNaDR3?=
 =?utf-8?B?K0swblI3SS9ZN2JzMXNPUFIrQXVkOGM1QnZaSGdQMXJaN0V5bUV2UVhRTDlV?=
 =?utf-8?B?L2krcDhMekVhNzFwUU5vMUdJdG5Jcml1OFpGcW1wL29Lb2d3czA0eEo5a0dp?=
 =?utf-8?B?RWlZNzFBT1QyRXpqeW0vVWtFQVlNekZLRnV2ZzdEaDJ2V0x2MzdBK0Nzenhv?=
 =?utf-8?B?ajNZc3FEakdMZ01wZXZ6dDkyRU1DZXM5cTBkWWY1OTlwUm9BM3dQVWZpaDFX?=
 =?utf-8?B?ZjdLR3hTUEwyNG1tUXl3TU1NZWRLK3d6ZzVYSXh3RURaV01lSUIxUm1KaGdJ?=
 =?utf-8?B?dG5UcUR0b0JYZFZITVN0eUJBaDJTWUlLeDBzN2tCRjgvazkzZ1FLR2g5bU9O?=
 =?utf-8?B?eUw3RnBuTXJIVW9Oc3JIc2djbTU4UUxMa1JLVDNSKzFubUxPeWE4VThGSHZY?=
 =?utf-8?B?a0hRSkxWV3NoUVc2OUw4eTNpU1YzaDRZZXJRRGNOdi8vYzJpY2QzSms3cGx3?=
 =?utf-8?B?R2dzbzFIMUw0NmF4SUV0MjhZb1JhL1Z5TTh5Zy9mcVZjWElrQktxd29NZ1Uv?=
 =?utf-8?B?WkJJNVZ5UjB6QnJjSllnMGhlUVpTMUIxUFVZdlZVMnpDQjd4WjZVbWtjMjE4?=
 =?utf-8?B?WCt4by9jdjZuTWtid2VIZ0U2S1plTDhxSStOZHIvUkp4dEhjanNiWW9tUFR4?=
 =?utf-8?B?bGpBM0w2Y1dGYmROWGJ4NFNUSXNsbUZQVnY2bU1xWXNlbnpEVDFETlpHdU02?=
 =?utf-8?B?QWp2Q2d0R2R1RzNzM29WdHg1aE9JdTlGblByNHlyZTNjR3ZNZzdoYWM3RWRN?=
 =?utf-8?B?QWEzUDRza3F4TW1PS3hGS3dTaVJWcVFpaENmKzZ4dE9qdTl4K0lPZGVhZVJQ?=
 =?utf-8?B?K25RYytSakxBVWluNWpGWGlMa1RIdFFsK2V5SzQwS0lGdnhWMjZPdy96NHRG?=
 =?utf-8?B?ZXJUZEZmQWppM1dhakxHcElCc01yZzFxdmE5dTU2KzdxeUhVa2xSRUhkK0k5?=
 =?utf-8?B?d0VqaHkyWXNobGVwdkJJSGM1a29OU0JTS2dUSU1kSWRLZW56MmNDNWN6RzNI?=
 =?utf-8?B?SW1tZ1lVVGdtS0tWSS9yMkRWMVJRR01iY1VRMnlpcnozTHR5SjVsNWx1QWJO?=
 =?utf-8?B?ek0zYW5Ud2UzWmUyNno5MkdONHNEQzVsTUFrV0pkRW10cDlrME5zblNHZFZZ?=
 =?utf-8?B?T1hITFM1SSswcU9McjFSNkJKQ1ZuTXlJRTdlODFsWDBHT3kzdmpFbUtJRmU5?=
 =?utf-8?B?c2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	x4DXCB6flGRa4YEehwfg81LV5uYYJ5rUZa8ywjI0Kh6Kn34pHKVUJoH5oc6VvcdVl6WJD3v6YRlfXU+ywZYrXySrov+VDcNjfK4sP7eTloj5c+YkkxPrrwc5JY/d0cgqy8e/0tQAblQZbqdi9qrLycMu7reYRG1ve8o2xw4GIS1E4Cg25jJXK5+j5CpIID/tOeYeGUOHtnbMe3hJpeyrBQV8Vs01Z+JunLX3KuDOdsVJGSDgdTIG6UjUSwFlKmx2sXZWTOYVU5py468vUK19ijHCKrNRvve2TY3bLe8nCGadGtLcuB9L1kCnNmfeOOnWVlIAjgOhcKCttD3ZslN+gQYRPpS0ECY0yi+0Wt8qEdtK/EqDyTXJ8DJ6euRp4u74Y1wL7ilGnxqXCs9boau/kDJkrLsdIZH3Xcx/5kOQg1FwdBW5W3qG/zwUumOFg58u/yLvK3kj4UAXhmoq4Q2ozoVXEFlRQzScyepN12ZV/RbsbiU0KK3Uo5J+x7EkWVexSulnNAhGj0twyL6XvXg68aymrIHlKV148A6NnVzWi9OvOrgo2NPrg6YaKcpUoqTw7jdNWUCrS3uhzmRDQoXBNGyeINlcCtJ6Mfb9WwOxxLU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec2d7970-b8cd-4bb9-2baf-08dd5bf47f44
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 14:46:22.2834
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Oe3tXWhnVSkR/dTgWajb/AQ5noP9g4mkYb249E3+OCfTkpAM5QKTSf7+MCI2iTSY1Cllpwt+ZlaCTxucy5PLkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4734
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-05_06,2025-03-05_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 phishscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503050115
X-Proofpoint-GUID: lWiB4E6hiku2m9WNS-Sr3vCn49mQO6Zw
X-Proofpoint-ORIG-GUID: lWiB4E6hiku2m9WNS-Sr3vCn49mQO6Zw

On 3/5/25 9:34 AM, Jeff Layton wrote:
> On Tue, 2025-03-04 at 12:38 -0800, Dai Ngo wrote:
>> Allow READ using write delegation stateid granted on OPENs with
>> OPEN4_SHARE_ACCESS_WRITE only, to accommodate clients whose WRITE
>> implementation may unavoidably do (e.g., due to buffer cache
>> constraints).
>>
>> For write delegation granted for OPEN with OPEN4_SHARE_ACCESS_WRITE
>> a new nfsd_file and a struct file are allocated to use for reads.
>> The nfsd_file is freed when the file is closed by release_all_access.
>>
>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>> ---
>>  fs/nfsd/nfs4state.c | 44 ++++++++++++++++++++++++++++++++++++--------
>>  1 file changed, 36 insertions(+), 8 deletions(-)
>>
>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>> index b533225e57cf..35018af4e7fb 100644
>> --- a/fs/nfsd/nfs4state.c
>> +++ b/fs/nfsd/nfs4state.c
>> @@ -6126,6 +6126,34 @@ nfs4_delegation_stat(struct nfs4_delegation *dp, struct svc_fh *currentfh,
>>  	return rc == 0;
>>  }
>>  
>> +/*
>> + * Add NFS4_SHARE_ACCESS_READ to the write delegation granted on OPEN
>> + * with NFS4_SHARE_ACCESS_WRITE by allocating separate nfsd_file and
>> + * struct file to be used for read with delegation stateid.
>> + *
>> + */
>> +static bool
>> +nfsd4_add_rdaccess_to_wrdeleg(struct svc_rqst *rqstp, struct nfsd4_open *open,
>> +			      struct svc_fh *fh, struct nfs4_ol_stateid *stp)
>> +{
>> +	struct nfs4_file *fp;
>> +	struct nfsd_file *nf = NULL;
>> +
>> +	if ((open->op_share_access & NFS4_SHARE_ACCESS_BOTH) ==
>> +			NFS4_SHARE_ACCESS_WRITE) {
>> +		if (nfsd_file_acquire_opened(rqstp, fh, NFSD_MAY_READ, NULL, &nf))
>> +			return (false);
>> +		fp = stp->st_stid.sc_file;
>> +		spin_lock(&fp->fi_lock);
>> +		__nfs4_file_get_access(fp, NFS4_SHARE_ACCESS_READ);
>> +		set_access(NFS4_SHARE_ACCESS_READ, stp);
>> +		fp = stp->st_stid.sc_file;
>> +		fp->fi_fds[O_RDONLY] = nf;
>> +		spin_unlock(&fp->fi_lock);
>> +	}
>> +	return (true);
> 
> no need for parenthesis here ^^^
> 
>> +}
>> +
>>  /*
>>   * The Linux NFS server does not offer write delegations to NFSv4.0
>>   * clients in order to avoid conflicts between write delegations and
>> @@ -6151,8 +6179,9 @@ nfs4_delegation_stat(struct nfs4_delegation *dp, struct svc_fh *currentfh,
>>   * open or lock state.
>>   */
>>  static void
>> -nfs4_open_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
>> -		     struct svc_fh *currentfh)
>> +nfs4_open_delegation(struct svc_rqst *rqstp, struct nfsd4_open *open,
>> +		     struct nfs4_ol_stateid *stp, struct svc_fh *currentfh,
>> +		     struct svc_fh *fh)
>>  {
>>  	bool deleg_ts = open->op_deleg_want & OPEN4_SHARE_ACCESS_WANT_DELEG_TIMESTAMPS;
>>  	struct nfs4_openowner *oo = openowner(stp->st_stateowner);
>> @@ -6197,7 +6226,8 @@ nfs4_open_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
>>  	memcpy(&open->op_delegate_stateid, &dp->dl_stid.sc_stateid, sizeof(dp->dl_stid.sc_stateid));
>>  
>>  	if (open->op_share_access & NFS4_SHARE_ACCESS_WRITE) {
>> -		if (!nfs4_delegation_stat(dp, currentfh, &stat)) {
>> +		if ((!nfsd4_add_rdaccess_to_wrdeleg(rqstp, open, fh, stp)) ||
> 
> extra set of parens above too ^^^
> 
>> +				!nfs4_delegation_stat(dp, currentfh, &stat)) {
>>  			nfs4_put_stid(&dp->dl_stid);
>>  			destroy_delegation(dp);
>>  			goto out_no_deleg;
>> @@ -6353,7 +6383,8 @@ nfsd4_process_open2(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nf
>>  	* Attempt to hand out a delegation. No error return, because the
>>  	* OPEN succeeds even if we fail.
>>  	*/
>> -	nfs4_open_delegation(open, stp, &resp->cstate.current_fh);
>> +	nfs4_open_delegation(rqstp, open, stp,
>> +		&resp->cstate.current_fh, current_fh);
>>  
>>  	/*
>>  	 * If there is an existing open stateid, it must be updated and
>> @@ -7098,10 +7129,6 @@ nfs4_find_file(struct nfs4_stid *s, int flags)
>>  
>>  	switch (s->sc_type) {
>>  	case SC_TYPE_DELEG:
>> -		spin_lock(&s->sc_file->fi_lock);
>> -		ret = nfsd_file_get(s->sc_file->fi_deleg_file);
>> -		spin_unlock(&s->sc_file->fi_lock);
>> -		break;
>>  	case SC_TYPE_OPEN:
>>  	case SC_TYPE_LOCK:
>>  		if (flags & RD_STATE)
>> @@ -7277,6 +7304,7 @@ nfs4_preprocess_stateid_op(struct svc_rqst *rqstp,
>>  		status = find_cpntf_state(nn, stateid, &s);
>>  	if (status)
>>  		return status;
>> +
>>  	status = nfsd4_stid_check_stateid_generation(stateid, s,
>>  			nfsd4_has_session(cstate));
>>  	if (status)
> 
> Patch itself looks good though, so with the nits fixed up, you can add:
> 
> Reviewed-by: Jeff Layton <jlayton@kernel.org>

Dai, I can fix the parentheses in my tree, no need for a v5.


-- 
Chuck Lever

