Return-Path: <linux-nfs+bounces-6735-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AEEC598AD09
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Sep 2024 21:39:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EBEC1F23798
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Sep 2024 19:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D2019A288;
	Mon, 30 Sep 2024 19:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lk5nzvmS";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="h/PQ+4eh"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23859199FC4
	for <linux-nfs@vger.kernel.org>; Mon, 30 Sep 2024 19:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727725122; cv=fail; b=L95vsFcZVnjaGw3Z+Lmgsitd3vxRyb/dH5dTllhRhHYjvMBtl+jxzRR6H9AK4grB60UBcMmCXszVH4f6fgTo7ffkC6yEsbLIYcGxDiINDxlKHFPk/affOk+o2voH4XQGy/9GNPAVqhcdAk3FtFBK8EYN3tJX1D56Pzw1hbYRvBs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727725122; c=relaxed/simple;
	bh=NvMyrr6wbKINPzuOKklcLLKujoJNzPYWg6iptl8rhF0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=D3zWQl5UfInatNAFVoEzfnkWDQ49123pnsVabDzVOgaXPQagONuhHYYZrzMi+ZuOnSBzRF9MT9cmTthqW5IYcij5Ovn2Qh0Mi6OzqeK9lxOVRe306mHstvKE+N6uLF2KtSGuWMiXrL5a0bROZ/ZxSpLxsOC7fEX8dFDOi163NUU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lk5nzvmS; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=h/PQ+4eh; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48UIv1Yk008331;
	Mon, 30 Sep 2024 19:38:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=CSXxqfO88lobDWwR50ujpBuiOiY7Ffkai2Wz+Mlh62g=; b=
	lk5nzvmS8cTvh3kBN5x7cj/ie3bzAsnj92zc5vvi134wmEBy/jbnSXSCKWv1rc2M
	9eouexUHtlh74dMAqJ4Mh80551KQAG8aRPahTIOlgFkXAlaGO6L0qRyTTxpvlU09
	f704/vK/KDoa2UCegjfIdKioa75UeP70tLQavXrRQO0rZZnDEqTKWZzC2B74vSbt
	dv1wTHIIhD+RwyoxTTXH21X0uMr7Ossl2J3CToyFaAa7Xqsa5EccZ71+Jj13CO7I
	anKgearsLIq2fDPS1Q89xEohXCzhOqMKewo07S0BQz4lU0+qYcECKNayBeRKf8fN
	4VamP6g9jPbGiIBWLO5uSA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41xabtmhe2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Sep 2024 19:38:34 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48UIt1ih026276;
	Mon, 30 Sep 2024 19:38:33 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41x886hg2c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Sep 2024 19:38:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vGfIagzGbMmdfIG+ds+J+vnICeJ+1pvJ6wWgS+VoCtcfduk6t2gSSsuZGjU7EO0IMAdZZTLqRk61BrTDxbIpgcGYxDbdhgIl2CixmnviiMl6E0s6xfIj/942XFFW8Fe1NOaS3GlXWkkOr18Q2LKuLicWVPQ85LeRCGP8D1qPu1Z3njIlxd44Uws9rFjoj39rQvX7yneRdPBvuZmcbBw1AOxhBsH6BJl5z1X71zTAtjHQlJ68IX+XMbX6lnwSw5PGKWlMN8cyZLbKQGivZ/NvZJEkZe5E5kerkONzakJqrOela01b12y+zlkDZwotZjFSvJfBc8h5eiby0ksgPv4TPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CSXxqfO88lobDWwR50ujpBuiOiY7Ffkai2Wz+Mlh62g=;
 b=Xo0/VRciGdhDd24v+YUyfmiXqhzk4ra2w5nelXv1yOURV3WQuNLxetJAGB8PqD1kwvICXMaEhIBM7x5na6arMC+9F4rBIOzKK5oxE6YSXKPuqhQNwnMw9lJMjNRTKNJs7FKVCaOjFEetPlApHgdWYQ9/62oGg8N1KbcAWmSxbhubDbn75Gc/6YlIb7kQ8P8Oo65U4HISqXfhc8W61EnRqxPhphLyxqMFV6JDevNvtxMcO1axpMPc+oifG/xJ4keUe5J2FRY1+4TwenAke1PuWDrwBFkmAhxN0e5Q3qG1gEHrZOeBwzApJ+fJRDyixfg5qPHUQbeHEzGiiqiSVms5uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CSXxqfO88lobDWwR50ujpBuiOiY7Ffkai2Wz+Mlh62g=;
 b=h/PQ+4ehdi2fwGF7MqKP979090RQED3InVW81s1520maK/ICiyQr/wxUG13uF3eLjh18mZr/02Pb6XyQvA/nAWEDb8a43C5Vxtb7db4N4o5UBysjZR5/EeTm0W5cGyYMGtcfmWno48zOJjdj41jjWNPmA4kJ7cH8zTTAKMSV6Tk=
Received: from SN6PR10MB2958.namprd10.prod.outlook.com (2603:10b6:805:db::31)
 by MN0PR10MB5933.namprd10.prod.outlook.com (2603:10b6:208:3cf::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15; Mon, 30 Sep
 2024 19:38:30 +0000
Received: from SN6PR10MB2958.namprd10.prod.outlook.com
 ([fe80::1aa6:4097:e5c6:932]) by SN6PR10MB2958.namprd10.prod.outlook.com
 ([fe80::1aa6:4097:e5c6:932%4]) with mapi id 15.20.8026.014; Mon, 30 Sep 2024
 19:38:30 +0000
Message-ID: <1e2638f2-aeb1-41f7-9580-6fcb860593b9@oracle.com>
Date: Mon, 30 Sep 2024 15:38:29 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sunrpc: fix prog selection loop in svc_process_common
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neilb@suse.de>
Cc: Anna Schumaker <anna@kernel.org>,
        Dan Carpenter
 <dan.carpenter@linaro.org>, linux-nfs@vger.kernel.org
References: <172741974136.470955.11402099885897272884@noble.neil.brown.name>
 <Zva+4FotyYdXTpwW@tissot.1015granger.net>
Content-Language: en-US
From: Anna Schumaker <anna.schumaker@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <Zva+4FotyYdXTpwW@tissot.1015granger.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR03CA0011.namprd03.prod.outlook.com
 (2603:10b6:610:59::21) To SN6PR10MB2958.namprd10.prod.outlook.com
 (2603:10b6:805:db::31)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB2958:EE_|MN0PR10MB5933:EE_
X-MS-Office365-Filtering-Correlation-Id: 218c6b2b-fbc4-40de-7078-08dce1877689
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OFZ6aXRBUVlEZ04xWlRiK2VuRExzRW55MDZRdFVSUXdxV2xiSy9EQmZHN0cy?=
 =?utf-8?B?YUhpRFNBZEZxS3h4U1dsdkdWdlBJOEdTdlRWcE5nQVVoR1FzMVBZN1NBaW1m?=
 =?utf-8?B?QXFzdjBGekt5QzJxaEJ5WUNpR3YrK1p4dklmaEpvZ040S0ZWU0VmcTMrUWxG?=
 =?utf-8?B?MjI5ejlHU21KV2ZJNDdZa3dNNmxmNUpuUFJLVW5OeDVERjgxeGNlOTFZemFQ?=
 =?utf-8?B?azEzclduMVJLbi9pRXM4T05yS2MxMVhJUW41TEV4UnRLODBVdHVQSGVFeW95?=
 =?utf-8?B?K1l3MWpQSDNSMmU0S3lEaXFFNVNxd2FoRllXQkthaEhVNGkzaU1DRjBuYlNC?=
 =?utf-8?B?OUt6OVRvQlZ3eXlHU2dGdjc3L1FjRkhvZFoxL3FhTUNoQ3JjQ3dMUUo0bzZR?=
 =?utf-8?B?OVlnZG5nN3pvb2pEVXRUVEdwQXk1MThKMVBseUJwdnJTcVJzaFQxRk9aTTJs?=
 =?utf-8?B?Rk9BK1ZwY2pINHJpb3o3ZHJwUnVQREgyNkU5SDRPUld5TlRCWmU3dll3YzJ2?=
 =?utf-8?B?RW15dFpIdG9yMXVUYkVnS01ZcGlzUWNuYmRUaVNVeUNqN2NOdmtVb0RtZ0tx?=
 =?utf-8?B?QWEreGhIRkhPUnJEKzllT2tkRm5TcnVjTFN3QzIwTCtSMVNmSVhaTGlZYkdn?=
 =?utf-8?B?ZkVDMmdYSXhYU2o5bFUyVkJZOVErVnZIR2JScEl2Z3Y3amZ4WHJkbGxJVE8r?=
 =?utf-8?B?d1NMaXlvcEljV0J1bFFwQjNiOG1lUWw1Z1BDQTcyWS9wYXVkaWhKN3E0TjV1?=
 =?utf-8?B?UCt3UXMwdkpMdUxSOUNDZllscXEwZUJlWGs1Q01EZlZ5amZSMVNHVExqVFhp?=
 =?utf-8?B?QXVmTDBDY2RtVFlYTTdVUnNPRE5BeE5GdmtnbjE4UlZlY1FaZVNEcmNBcDNW?=
 =?utf-8?B?b3V3aXpBSGozN3Z1R3o2aDZBQjdSMVUvc1lYSnorckE4eFkwMC9oM2t0U1lX?=
 =?utf-8?B?WktqeUhKQVNWYkx2bnBpZ0p0THAyaG5IRW5ZbFdIbTYxTDIvY2xVZGI1aXFi?=
 =?utf-8?B?aFBiZXFSaWdFQ1hwV1hienJCTHcwSU5saFFFQm14U2dJMGp6R3VRdkx6eTZq?=
 =?utf-8?B?bkQ1QmJCK2ZBYmlkY2s3VFR2ZkdIZEhVSFN6dzhSVnVGOU1XWnZ2OFMvY3dI?=
 =?utf-8?B?RCtVZnRwZGlVQjNUR1ptenVhTGJmeGZQSXRhY3UwVnM1NzJvTDdPK0tlUTdy?=
 =?utf-8?B?Vi8vajA4cTIwdTlLYVdQWDIvRzdvVGpwUHVLd21zdzNqUGJWcnZreWNMZ2Vs?=
 =?utf-8?B?UC92cVVIKzluRld0aHpaa05xbjAraitNaVVZTFJhSXloa0xPNGhqTzFibmpq?=
 =?utf-8?B?ZkJWQ0NSN1ZDdGFHTUJwSXllMFFsWk5JZWhrbXlQNmxlV1FJenUzeVVJVTRU?=
 =?utf-8?B?R2lLR21rYXVOYWVnck1FY3B5NlVJQU5rMjVieTBhMVZEZ1ZLMGpaMFFlRFNF?=
 =?utf-8?B?bHVoN1RhcVNhdlo3OXN0eEhoVXNUVTA0am5KdWpRVmZabnY3SmFRQVdkL1Zk?=
 =?utf-8?B?OW5YNkxPQzl0WTVqcGdwcG40SnhwMUpORGMxRExGMlIrNjB2QUZSemVEOWRO?=
 =?utf-8?B?cDlKRnFhOE1uWTc2Rk1sQm9XQmc5RUJNN1Q4eXdhRmZZa2RaVUxCTnhBVVRU?=
 =?utf-8?B?Y2krc3g5SDlkeWdGUC9zNzZkeTY0WW1WM3FKM2VBQkZRWFFWM0V6THJwZkVz?=
 =?utf-8?B?UXQ5amQvSDdVY2VBeUdlRmVwM2Zjc0swb3VQUnlKM0FNd29JbEtVNGFnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB2958.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZzFVR2NiYXc4cEQwVlFKWjRiNXU5KzFSUUhIQld3NC9kVGdHZWovblpTYWl6?=
 =?utf-8?B?YWVjV2xQM2pORVJMSEs2VjMwcmV2UCtHZ0lPb3cwK1MzTlpDSDk1ZVRiWWRu?=
 =?utf-8?B?enRoWFpWWUw3a1RPTmhxellGTjk5bmhJcGtyb3ZTZ21FYUhWUUQyMys4VEFt?=
 =?utf-8?B?SkR1YVVuNVJ4RktlT0dVNTJVQ1B3YjhyZFFmMG5pL3lnM003SG0rejVYUzNL?=
 =?utf-8?B?a09hYkUzY2tUUUw5RFBsZVBMdnVkVWNWNzJGN3hDQmJsRG44eWwyUmQrenNU?=
 =?utf-8?B?bXlEMEZ5bWQyR3p2b24vVXZKWHRQeW1RMDBTTE9CcWNEOUM3RWJoMDB4RnZ1?=
 =?utf-8?B?WGI1UG5kL3dKelVUQVI4cVQ5aVY3TjI3Q2hHNkdMdUM0NzhYckFUU2RpdDFB?=
 =?utf-8?B?a2hsaXY3dUtyblpERnNxZ1JQa0dXMllUb2h5UXU0Wm93b1p3L1FpekM4d0Vp?=
 =?utf-8?B?NThxTWNEeEEzQVNNbUxMTzBReWN1eDdHOXVSOTcvQzJTaU1PK2w3MXRYQ0l2?=
 =?utf-8?B?aVRxM0g5UmJkMUJaTm1weWRLYWxoTFB4T281a3VUS2Q1VlhwN2FTSTBCL3Qx?=
 =?utf-8?B?NXk3cnM3UmJyZWVlS3pXNlYzeUNDdXVDVU1YUEtnU0pmY1VWMHZDRm90TlBQ?=
 =?utf-8?B?d1duMnRGbmJJdzZwWjZaWURQUFNWUWVEdWp6dXdWZ0tJWDJmbnhoOHB3L0lS?=
 =?utf-8?B?SjQxNmduL0QyQk5iUVNleHJGL0RQdURvOTdla3FsbmJZdkdnajIvMk92Rjg1?=
 =?utf-8?B?aXhlbWNkb2dKd2R2ZXhPc2RVYUNYdDliZzlheEUzQTNQbkczdlBVM3NhRWtn?=
 =?utf-8?B?dHZMWmluV2FDMWN2b2RndkFyNzQ4ZERldFFWRm5iUlk3N2pnblcyTHA0K1lP?=
 =?utf-8?B?V2NuSXhwRjhYYStFaEN6ZHN0OVJCT0h5ejhQYnNuV21uYzFSQzlESkJhNlpq?=
 =?utf-8?B?VndLcnl3Rk5DTFJUaGdvM1lwWVBCNGVMUTZxbmVsQnovSlJzMzdFZFlXaWhl?=
 =?utf-8?B?K0V5L0paTUVFUEw3M0Jxd3RBa0N6QUZlbGtYbnFweGVBYnpIUmVrMzZrT2Fr?=
 =?utf-8?B?aG9uSklNa2UxNkxRcTF2TWsyVXlMZThEczdabUloalo1eDV5eXJRbFZZS1F3?=
 =?utf-8?B?blN1SDlpOU5DQU9wYTNZeDRhalUrOG1Sd3A2a09pUGF6b0tDdWpuUk9MSGlM?=
 =?utf-8?B?by9hRzdtT2FkSC9Kb2NSeWdvVlFZbVJyQmNvSDB0N0t4K0FBZkYwQStCSGlz?=
 =?utf-8?B?Mkp5TDl1L3NXM054Ym5DeVJMQVk2R3BqSW5vOEtHRmFsVUZtTHhTSUEzUXpR?=
 =?utf-8?B?L1ZMZVhXcVpjdlhXcnlsdWJiNnUrckdLV3VYRnJoN25DRG1PcG1BM2tmOFJV?=
 =?utf-8?B?NXZFRHlEaWlSdCt1eGplZlRWVjJ1MitYdFFQQzI5Ulo5S2U3VDhCVExqLzZj?=
 =?utf-8?B?VHgxVUdza2F6b29la3ZjS2pCSS8yN25DV3JLTkUrbWFtWnZSVDRrTitMdC9C?=
 =?utf-8?B?LzJKeFpnVGlPSzQvc2I0M29aNTltUm1UdmUyU2MyenczNnZLcFE0d3dnYWlR?=
 =?utf-8?B?Q293ZGEyMEIrSTEvamdiSXZMNTVYRFJ4NkdXcjAyN1IwWjd0UnJDTzdNdlZB?=
 =?utf-8?B?VTNlTmtnVlNZUVJuWVFTMHJQR3o3QWw1Q2hCYytSOEFPOUlUY0VvaGFweDFS?=
 =?utf-8?B?OUErR2phUGRsb3d3N2FBSk9vcnFBbEJSYWRSMS82QmwreVcvMUw4UkRUV1FT?=
 =?utf-8?B?YVJLWFEzMmtCVkRkeGlSVCs4OXlqaEFUK0ZEaFVCbkdXM0VFL0J1T2M0RW1o?=
 =?utf-8?B?M01MdzVTVitGWjdoS3Nqbk8rU2NuQWJ2OXNmS1lJdEQwSUlnd01LOXFPbmpj?=
 =?utf-8?B?b3ZxY1FGM29zczhqTXkzVHozZkxwbmZ0dHkvbzUvdk51anJabjN3MkQxdGFD?=
 =?utf-8?B?MUlUQ0luNVpSY1dmL2VuMDVEQW1Ldnp5VnB1TGF2L3o1Vm5PKzUzUWVNaHdo?=
 =?utf-8?B?cmZ2THJ1dmt3NUd1SGhibGZSbk1kdTlYd0U0Y1lzdjhzUHE0eDk3bUQzSHJ3?=
 =?utf-8?B?V09pRWo2TVoyMTE0V2Z1a2wzMmxCZFVCWmlsL2hXWUhoVWhSN2xGTWp4NWIz?=
 =?utf-8?B?NktXU21XNW5RU1BFblJ4ZWJWWGR6ajlpT1BMN3Z5WUxCKzlkR3FJcmd3clBT?=
 =?utf-8?B?Zmk5SWZJSGh2QTR6V0ViY2taUnJJc2EvbmFRbk5KY0FkamEzWUNFS0pIZkUv?=
 =?utf-8?B?aENEcFk5T1BDdm1LTk9sQWJiR1ZnPT0=?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	3qR/Vlo3LP0iVyemaxPAVSS0/XhwWJbnb4Cs/3Oyy3W4XhBvmUF5qFoduZYtgk/z8I+1yoW/EymJ3tvPvLf1cQznMDN4huZFnAtavPlVhgsLnz0BZEjCy5B5y0FHtLBFRHnuAhAfPy7UWWPYY+DpzRnY6AGL+ON1CDxyUt+k0IkBxTvJSuIN4YsFCHYG3q7vEbDQQyf8q29LnJtgIvc2JxDuKkxqmSmBkC+ESmQlVNqz7GhrNrEKWQp800QJ2gNv4ux032SzeKC6HrqmgXh+TPSrYDfnFwL11PY0nInhd5JhXvSxRbktH21bxsjvKfH/pZFYWXOocBOpX00Xz1rxOq0DY0P1bG6fnXF6zCcVET7puk7yxbZd1JuK3YM3t5vgAImKbBH7Y+w0tijyVCTwB2wstI5jtnIl7ZosMfz5L/dybg93sT/DZ36I67r37SLqGvsoOgEHcw93uK5KfTSameZaYnTurOe4MTiHkd7Q4QRSI9IVM6VK7TN9mY3EfussU2M5kBbgANs1guC6GJXcFcMjx77x2profYwLRnpS/AJjVDqSmeOvbQEl2RmIqjbVRtD9RMZEzz7BLtNjEiWN3GIyTweQgvAVYCtZl6J9Oak=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 218c6b2b-fbc4-40de-7078-08dce1877689
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB2958.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 19:38:30.7285
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n1PR/DVsPqZ6/qYHoyv24Shdacb0qeIzwFHP2E4q+VA0dw4VasxSiPrvvLEU2E+VU9VmR7xp9gA/2hEqXuWroidL088QKnSIL4VxfwVeO7g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR10MB5933
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-09-30_19,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2409300142
X-Proofpoint-ORIG-GUID: s-SFUM1hzLJEOabUj3XlBlJJ9PLhcYdM
X-Proofpoint-GUID: s-SFUM1hzLJEOabUj3XlBlJJ9PLhcYdM



On 9/27/24 10:19 AM, Chuck Lever wrote:
> On Fri, Sep 27, 2024 at 04:49:01PM +1000, NeilBrown wrote:
>>
>> If the rq_prog is not in the list of programs, then we use the last
>> program in the list and we don't get the expected rpc_prog_unavail error
>> as the subsequent tests on 'progp' being NULL are ineffective.
>>
>> We should only assign progp when we find the right program, and we
>> should initialize it to NULL
>>
>> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
>> Fixes: 86ab08beb3f0 ("SUNRPC: replace program list with program array")
>> Signed-off-by: NeilBrown <neilb@suse.de>
> 
> Acked-by: Chuck Lever <chuck.lever@oracle.com>
> 
> 
>> ---
>>
>> Hi Anna,
>>  could you take this please - a fix to a patch in your latest pull
>>  request to Linus.
>> Thanks,
>> NeilBrown
>>

Sure! I'll get it queued up, and push out bugfixes to my linux-next branch in the next day or two.

Anna

>>
>>  net/sunrpc/svc.c | 11 ++++-------
>>  1 file changed, 4 insertions(+), 7 deletions(-)
>>
>> diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
>> index 7e7f4e0390c7..79879b7d39cb 100644
>> --- a/net/sunrpc/svc.c
>> +++ b/net/sunrpc/svc.c
>> @@ -1321,7 +1321,7 @@ static int
>>  svc_process_common(struct svc_rqst *rqstp)
>>  {
>>  	struct xdr_stream	*xdr = &rqstp->rq_res_stream;
>> -	struct svc_program	*progp;
>> +	struct svc_program	*progp = NULL;
>>  	const struct svc_procedure *procp = NULL;
>>  	struct svc_serv		*serv = rqstp->rq_server;
>>  	struct svc_process_info process;
>> @@ -1351,12 +1351,9 @@ svc_process_common(struct svc_rqst *rqstp)
>>  	rqstp->rq_vers = be32_to_cpup(p++);
>>  	rqstp->rq_proc = be32_to_cpup(p);
>>  
>> -	for (pr = 0; pr < serv->sv_nprogs; pr++) {
>> -		progp = &serv->sv_programs[pr];
>> -
>> -		if (rqstp->rq_prog == progp->pg_prog)
>> -			break;
>> -	}
>> +	for (pr = 0; pr < serv->sv_nprogs; pr++)
>> +		if (rqstp->rq_prog == serv->sv_programs[pr].pg_prog)
>> +			progp = &serv->sv_programs[pr];
>>  
>>  	/*
>>  	 * Decode auth data, and add verifier to reply buffer.
>> -- 
>> 2.46.0
>>
> 


