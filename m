Return-Path: <linux-nfs+bounces-4871-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 930FE92FF28
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Jul 2024 19:11:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B69761C21554
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Jul 2024 17:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B27E1178393;
	Fri, 12 Jul 2024 17:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Xfc129Gq";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="D5ouqQoV"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9B017624C;
	Fri, 12 Jul 2024 17:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720804145; cv=fail; b=Rk34TqCxBZPDPNNQDEXqbQYUL+LZ2w1b+bf9oLVYh2o+QUeOGS2JDSrO2MsLGIZX5xEezYbqAiq68RzvtTVJS3i62Nko4AgeSM/lee0UYrovRL3atxzojAm14A+NJC4IBIQzF/U7WUoMN33ryMRKavcNZiStkgJvK0XofC969Sk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720804145; c=relaxed/simple;
	bh=x9aUwgcIda0wbYOvOglEadj5llk0rpJk5bnlmy90unk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LTrw1EVeXoZfPpUWsjUucwrCgYrbHJjG1512tnSe36wo2s/AkaN5AQHzG3RNmuKphQZVM7R1fvSbs22WfwP2pzZdzmfYeeS8cySOKbkffTsVFXPzZG+O0vqs9CMEO741BwTTJAioxJiYsF/fxOAmTJX8IIuzy8EfZIysEWBO2Cc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Xfc129Gq; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=D5ouqQoV; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46CDIM1t025593;
	Fri, 12 Jul 2024 17:08:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=AGTzQ7a+cG/LjlC
	CgDYmzxkcRK8NXjhSM1HH6lNYZV0=; b=Xfc129Gqle95Y3fYUVI7scmAPCpI0ZL
	kWMyAbwVc0bSn9GO7hQ9SSChBLFsEsUle281aujR8+iq4QSpC5VvSbXueOSLYz3S
	PttfMw5Qu+uvE8+TSZxeRHLKaMLxqlFDnqzSo69VeU7AjVxXGNJQDrFXoIx7S4IF
	3VmeTCpuA827P4QVC1Bd6ud4nYUPAGdDKZcTBoQoaixE2q73ngRZkV0hsHqvTaPF
	jy+8X3MKbF3zdzxOXH2shCTQC0A13HTLzAAHP+RV9C86iwvVgwW4np+VqFRnu/jj
	d+Ccpx8DFow1dP9tTyl1uTvmiskDndsSw8ecxNlVckQu7Nt2UkOrmRw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wknvb5m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Jul 2024 17:08:54 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46CFlbVf028745;
	Fri, 12 Jul 2024 17:08:53 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2043.outbound.protection.outlook.com [104.47.55.43])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 409vv6k403-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Jul 2024 17:08:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nx4pYwT3eIrd+2U+VtrV5bxhZQk9Z89IG2DabjJAul8nqF6MhyJRRA0ogq9Lt+7lYN2dzQieBEsKkV/OA/EOoUX8lShVcdgSPbUHDAC0d83v+RkQtWz1O9U5ECzunYnGpcFKznYl6i42LwN/CkYuncDsvAOdcZFQ10z+z5DHJwjbm7kVoAlLnNJbXJJ0yd6KemJdXUuPtzWuFt2xvWIIOBU7M/3cH+5IAVgsQNcjP65A4wjwkq9kV7JGY4fo0F53TFdw66l1rqMWuUB3hLkTBvrFrRe0wxBx0YLPIEtBu1Yut7DN7VElwZxSncJuhsQXccs1gylmbM3MLsmN6RHCtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AGTzQ7a+cG/LjlCCgDYmzxkcRK8NXjhSM1HH6lNYZV0=;
 b=KsdliRtNxUowSAtBrSYzQIELQ26PXQXtDIz8Ela0BLnBRXFThYiOH3Eal3itdQK/dnkh9pZWL4XJZB3GSZtKOZjmDkBTjwSyKDzvRKMU+PuCi4lS7QuQVL7dPPoQ5t5fHDSl/614D57F3kzaLoVMxtiDjrx/GmKe7axG6F/eoyKkYwjHBcqsJ9gZFob/ooZB+/7RPFHKr4rT6p13Bpryiz8cfX+MYaLC+86O1PWJTzfjz1+txmhEP+uzd9KyIh4VgqpvAJAMWI7EwFeI80h4nmmAJNiRG1DIP2aMJe5u8cbTNEQk7s0NH7nZUWGJ9xth4WxxT3bPYO4wKd9DZ8j7yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AGTzQ7a+cG/LjlCCgDYmzxkcRK8NXjhSM1HH6lNYZV0=;
 b=D5ouqQoVesj1Jz1UlzDgdUNBYizqdbDuL4oVwiIbc+z46QSgRWts7JTgsTMNsgWv4xd9EPmtzN2NK8RnvwRW8O/KB7/5ONPF2aiKhkVvF7Hno7HQgFWw2jqYSV8algM+QxjMxSJzttHMKB8/hyrpiKs/kk1zNP6IKsepJY3UIjk=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SN7PR10MB6641.namprd10.prod.outlook.com (2603:10b6:806:2ac::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Fri, 12 Jul
 2024 17:08:49 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7762.024; Fri, 12 Jul 2024
 17:08:49 +0000
Date: Fri, 12 Jul 2024 13:08:46 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Neil Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nfsd: nfsd_file_lease_notifier_call gets a file_lease as
 an argument
Message-ID: <ZpFjHrWCLhTivuOl@tissot.1015granger.net>
References: <20240712-nfsd-next-v1-1-58c5f2557436@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240712-nfsd-next-v1-1-58c5f2557436@kernel.org>
X-ClientProxiedBy: CH2PR18CA0021.namprd18.prod.outlook.com
 (2603:10b6:610:4f::31) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SN7PR10MB6641:EE_
X-MS-Office365-Filtering-Correlation-Id: 47198223-3686-4e40-7c98-08dca2954c4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?Y8s0HmW3EqCaH+n4W66yReXG/Cswr02+OWIw/YTKc+eB7cz6rGh4oWeV15ku?=
 =?us-ascii?Q?TdIRD/Un+ipKt1I+HWtfgvaN4wC3ktY2GcA1dhvReEYv0MFp7kpn9CJPtd+R?=
 =?us-ascii?Q?DeOKmybEELMGbnuDicBmDj5d/FAuhq9AwimJm/At5K6ReBPB3QGlz2Kx3Ust?=
 =?us-ascii?Q?lAU9JDkRGePcMGX5C1RWsq5E3inNbmD1RMtiqrwn2/zNKSFRwe/JxOs4L3x4?=
 =?us-ascii?Q?2adFhtviQjDPBwXcyB7bHvtTRaUzCaEeFw2z6oDI9jPb/DRj8KK9yVseameq?=
 =?us-ascii?Q?WpT6xQBkqW8mqMXQdYjbhzZGBeMQYRmxzym+4qG2c6AHKQ0sk9t+4b+YZ4cV?=
 =?us-ascii?Q?dH38FM5Lnjv94JBbOvuJ/danbBf8CYFxtkV5+NntQQOJx/bPrP4c1aI3nLxk?=
 =?us-ascii?Q?OrVw3IvsrjZKnzZXNL7pm5YP3bqvxkMSjp+a4kl9OR22OYs9SXNAf3ViPBqC?=
 =?us-ascii?Q?aoCZQiFybfoBt9Ww66nRs3/k4wzCQjRMYBqt8qXkUGaERGjI/m3K1l58OQrO?=
 =?us-ascii?Q?QTYdcFTbpOuDKhBHeEiz5BD86ln5EMlOvsGCranCna6eAG5F44Rm0+cJQEct?=
 =?us-ascii?Q?FtAlle+QHB4ZR3t0x3NHt/1O3neJVekCYdS0P1IpX2hrU6rsqYf1HheKb5FB?=
 =?us-ascii?Q?rf+7vJzgSMrGDvLv3UIhpdz7QKEFbOVvFXLhnfNycljJZ9DsBRwoj+Ct1VgI?=
 =?us-ascii?Q?6+5hqSxi70UZn4VJV5/jNSJehl0ufbBBj1dwLjYkpke0O1Ia6a2TdP+df8lV?=
 =?us-ascii?Q?7fxruJgchcFhiQ2nQxmBwyV1LGq3ZWPDS+8w7VWNtfF6yMtSW+Bcjn7Ppw7y?=
 =?us-ascii?Q?/eDyudPK0lgoWF1pfm/MLRDsT3GsRBQSKSH8Tb+p2F+szlF2f4KkdIk8f9fj?=
 =?us-ascii?Q?dueQ4DJF+x1b17XHbVpvjMcfhFoq5lBW1dAN4cNaw5ccBe1gvnW5f534TGNJ?=
 =?us-ascii?Q?AMV0vt474YRju6F9vT3wF2T4OOgSu/qmTZJH8/ppScwaotaJYrkIzdfiO3Q1?=
 =?us-ascii?Q?ehXJpCQQJ8+jDRmdD8od7x4eem73HwU77e2sZvW96cJpTRvi54JdaUXBLJWE?=
 =?us-ascii?Q?7/odXdAA7JQe9+DuLKQZGilOFXm6bNfMPeKYX/H8+KK2Wfp8GD4QY4/EFDWf?=
 =?us-ascii?Q?7Ec7HYdOTf5Zc9SmioT1OkOXka3k57tn1RVPjozf+7Z66qqnomxH1tTKr/mm?=
 =?us-ascii?Q?udCmYIByjVHuPSnOAX4SZK1u5QjEVkhC6l1JxaKXclUjNCOwX2hKhnte6/fo?=
 =?us-ascii?Q?Oc1mArGE9L4AVcbSUWdYI3/kazqbuY/fWvIWZE4LZNyLBAsEIorwtiCJXjbE?=
 =?us-ascii?Q?U3Bk3VUuTCjblElDOzw/cnxij9bbASPQjr84+KVUDV9Wwg=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?8WX2LbRE2jpGGuAzAKGB7Esy1WidUgXlFWogM+16rziExda2qt7bK2eD1+Pe?=
 =?us-ascii?Q?X04mvnYo5vDf4jAvzs//rLJU3ltuk/YrOGztYuvhMcf0hswPx1Zw3hnG8qtG?=
 =?us-ascii?Q?dlqgvDHLFsxdHtcBxo512ZNcAlCrj29lYcCWJDYtKg63eWv16p6vrr/+ORE0?=
 =?us-ascii?Q?a0t1YfMr7VmUSsWSCDxBGlTtnvYdS379Xa+Bjlnc1TWKqlKjOOzMNcyA7mYw?=
 =?us-ascii?Q?pZra1OHMDyJ/5OuUlexiiXhSCskV7za6ZR7Mo8LEnJ6DMUCGxLV7CH8brhWe?=
 =?us-ascii?Q?AsmhQUON7FCaBMdOOsrhbzaqNCRgGE6JhxoMLoOlSvyD7nL+2SOnr6t1CI/I?=
 =?us-ascii?Q?fFFpm5tYTZTDl6AZLujFHvgrDuu5/0kgVfZJmVJPijSHSBb183589rdZpVJz?=
 =?us-ascii?Q?CWiR29QG51hgPGhPt15GKm3/LJ/16OOqAAkQ56coSOm0LmuXYsvFXOBjz3Ve?=
 =?us-ascii?Q?fSkMoL1MIFzMKIfKpPDpsVPMnuGBrfVRyVaaH/+LQwA+FSy2ia/9LRmf48ko?=
 =?us-ascii?Q?CNhWAZOKOKq2fpCR3rkLFYFXUbmxI7fp9oWI7MHLa45AEpm1aqeQT1SFa+E9?=
 =?us-ascii?Q?7x0qUC7H3j8ldoalbvwqXXlKSy5JHkgVRsdb/MxfxsKVS6aiac1K9MzqSOq5?=
 =?us-ascii?Q?yUAGiEhyWiqLLKAncYfmCKtaKpr1At34GKANzrvGcgHs0A3+6SetcQaAqxu1?=
 =?us-ascii?Q?kKV+5MAukyZqSwA+F+yqfpOd/O6tux1jlb1I4Pd6tRd+I0w9fRzVU3WP57ec?=
 =?us-ascii?Q?KPCF6KncY5z/Zry2z3mtlxzdy7cKCoOxLgUes4unJGiE6S4o0XECApyw7UWq?=
 =?us-ascii?Q?bycn2flWE61re+K86z+ahNOjbC/xmFD7mdfBPHpEkZCVZTZCme/zUP7Cn7F0?=
 =?us-ascii?Q?4nxfJ9CpY9EhAmuRV9iMoE6P6w0deu1ydoSn3ASr6SHlP5wDL4ZHmfwPjFWx?=
 =?us-ascii?Q?rLUH4ESaxvCs1SlhRQmQya5Rc0BKR1djel5RBP/9nu4+38Dh9n3eFHGq3Zvy?=
 =?us-ascii?Q?gza3dlO4P45hxwTnW85sPl+eSXo3oA2Q/Sq8QBw7/rV/aU4APvltLcoRNB/J?=
 =?us-ascii?Q?60s3jgdTpK3y9ytG03HgqGN2Zljby3d0eQLDf0eu5fGGuKgD3RwZgLFBK3pa?=
 =?us-ascii?Q?6mQbMUuyKPpm157lDbpfCk5MOo7OidceR3LIMMUKLvREtRD1lHK45XcYVYf7?=
 =?us-ascii?Q?bDvVBy67RteKdfal1NFG7CiEGhUpSm0fP8f/l6sDvyfwVdFB/m4O3lYJG/z9?=
 =?us-ascii?Q?CxX0eJ9SSlOSAWuKMUQ7z1ve0iFXtdnUOWnvg8eoeiXG2CLG10+SUbK22oiD?=
 =?us-ascii?Q?+SR5/AhtUVe+mQqkK8W0ofNlYH6uJNmcVexyzUuqTXq8MaZWC5B8HWPNA0py?=
 =?us-ascii?Q?RXR1CEFbSvK0+wqY9Nv8M+3uZ4AJzoMSI9m5rI8KSJxHYqHvJGMgycg/7ASu?=
 =?us-ascii?Q?6R8eqEm5G9DIgeo2LeTjrGGOmqaUpCLYH+NTcPZY1Ph9MXn348KowGo9xwLP?=
 =?us-ascii?Q?aiaS/yGYm/kwhKXYqVaAukUbBxlihQ9B6mDF9PHS4T0r66xG5Kli+RWghPhL?=
 =?us-ascii?Q?a393avfCJMyDygQ0glmCnWqVdb5A1gVIyNHYmOIaREFgYfTUNvlL5GdobmxH?=
 =?us-ascii?Q?LA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	2VfxlS88YTFN6sHnGxhMwyfll3Bf9j2wKkjnD5pICteY+336m/7m1xBhn9dEuOX8zcK5yxBXpzj7/pA0dme3sNYKvjL8Sxe6CrYGRx/694EDhv3zAdASYMRVCAdSlJreC86DIlGy/rSr7vMk84P3Es5kKzGSyIH6ckmaMoS2+VhZ0jzCcnsCupMI/yQ1i1xN0tVkxAbd8J5beKb4c2J/UcGXauORTz0rNW2viZNkxSYMlwbkJO0fmxEf3zmHzc6UgLnDvh8sR1xEqdXILI7ZHzYBEqN4KNYMbz3zmtIw/uQf0VMhBdw0kdhOyIRu4jckVrnlPFsSvFPNYlH9I42gypqSDyrAqZCwkt16i4OOvP+sNeSS2qo7Mavvhjzm8abLCVZnwHU7xRU+vLHquoILa060l3iJ5NnyOY1CV8V7e8ZM3G8YuFsOUsI4M8mgIcI3AxWZB/hhxymQ8NY8Dsyyi31O7dumiNiXMhlBT8MXY3eAFWsP/1Onk4M1IL1BEY4fUyyTEl9f8hjqMkmjL4smr7MrvOiYVanUArqUgpUDp9k/jFmc1jcLniff4+ciqkR/M+7q3bMtpRVfSYzaWaQ6OWjnknp9IG4k860chfMhFa4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47198223-3686-4e40-7c98-08dca2954c4d
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2024 17:08:49.5616
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8ZpVVuM7AiNBwbUwNY6vMWaab4j1p0CYDqZR+zlqw+1iitZ+W8UWhFZmvXJXj4BBtrZ/kL1pDBPaD5bE2zJxrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6641
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-12_13,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407120116
X-Proofpoint-GUID: wmRRhT6uvmDi35Ci1bOeoKGLlYU1VcQj
X-Proofpoint-ORIG-GUID: wmRRhT6uvmDi35Ci1bOeoKGLlYU1VcQj

On Fri, Jul 12, 2024 at 07:26:44AM -0400, Jeff Layton wrote:
> "data" actually refers to a file_lease and not a file_lock. Both structs
> have their file_lock_core as the first field though, so this bug should
> be harmless without struct randomization in play.
> 
> Fixes: 05580bbfc6bc ("nfsd: adapt to breakup of struct file_lock")
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/nfsd/filecache.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> index 88dac1abdde3..ea506882fec2 100644
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@ -667,7 +667,7 @@ static int
>  nfsd_file_lease_notifier_call(struct notifier_block *nb, unsigned long arg,
>  			    void *data)
>  {
> -	struct file_lock *fl = data;
> +	struct file_lease *fl = data;
>  
>  	/* Only close files for F_SETLEASE leases */
>  	if (fl->c.flc_flags & FL_LEASE)
> 
> ---
> base-commit: f862772862db0e2bbd711a03ac6e6cff89e306cb
> change-id: 20240712-nfsd-next-ba50db14fc85
> 
> Best regards,
> -- 
> Jeff Layton <jlayton@kernel.org>
> 

Applied to nfsd-next (for v6.11) with the addition of Reported-by:,
Closes:, and Tested-by: tags.

-- 
Chuck Lever

