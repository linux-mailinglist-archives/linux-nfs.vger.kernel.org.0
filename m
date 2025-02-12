Return-Path: <linux-nfs+bounces-10059-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 378B1A32BD0
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Feb 2025 17:36:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6B6B16957F
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Feb 2025 16:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE5E250C1A;
	Wed, 12 Feb 2025 16:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BfnKqQI2";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jTPqwwcv"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554B7250BF5;
	Wed, 12 Feb 2025 16:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739378069; cv=fail; b=kA7MoD+1kv8PGhU+Z61ByBXNvuHqZCK1o+d/6SEs9lpwXYHf0pOgidVR8sL4Au3lkapNxwKlmOHv4rg9cZYtRU5Abug6W8R/tYIMSG0iTeay7EpzatZwMCiAsyN5DF6GwP+tkrsg+QW8lpuPNUIuCHe/snhtHDr51OaVvNaXt5c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739378069; c=relaxed/simple;
	bh=/UL/rJC4xTL0Ad74pHg7olwQAZJCArHWqu+QcCX7A34=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cEX6nym39xlqTiyhiSIewBZPnwqjR9NiD723goAbiPoFMZpTpLbOOrT0G9rydaFoGHHeeF7CGihUGhbz1UoDi60XTAEqkhK0YBbxVGj503U0k1QlGXQbtbNFSQRnPCrUdyjT1Li8P5+gWoVqRj4AHMngUkdU7zIX3u3pGTOtOGo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BfnKqQI2; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=jTPqwwcv; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51CEtXv5002911;
	Wed, 12 Feb 2025 16:34:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=yA4zG0np4aqBImwMP69QilajHlfmNJLJYIyo5tSnlWM=; b=
	BfnKqQI2o1E5ZDuCnZzjBiTQdmzRhNMNpJafzCzrmY779kNjlYR/Zkp46bNFAljP
	JG7xF5Hg3bvhI5NyxHJaShQ/P0eJ5OmEhXSd0fzQMgowhn4QVF/agBOq7CFQ3lXl
	g/6byI8hxwWQ6xVfdVc4MbZ5S16Qdvm2+1X9/msDS8Ta84qBLPem9vM9a/GjSXN4
	UZV4andpW/LKcEuHbkQD0MogALMVBASgfbBhtHniCYQNtu6zNYYMuQ1dl5Yb+OnZ
	Ml5WLq0e1h+l1NhOla2lyeADD2MPMHZlLlYOrZc5VZGO0HTPMi0P+gT/n81RDaIr
	S4f3fVVMgSN0TsLM5ZfD2A==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0q2ftmd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Feb 2025 16:34:16 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51CGDdEx026949;
	Wed, 12 Feb 2025 16:34:15 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44nwqag3fc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Feb 2025 16:34:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jKVCz0EPQn+Q21ETUta9kTMftIes6UXIOn0S4Zn2zIGEQSKWPv+usGzwzcQ6j1enIiSnXrVmpmoKjfdZ+pboWRc15wvZAPXEIRo5jB2+auglswnpIKvILOypOTkBkPMR4cZe8UOCSpotDBwP6XH24zxjtqYyh4JnoNMWxaaggnpda1gm1aUOn3rdVlhKlIJ0cZNf9HdIx8ciHnXRMoW2Dbhoen+K68UjloafiYw69eMgZjfAGNZCW9Waxlf6AdtVqlwssEsg37f5XHjRmLvAnbZFcpDAQsc1p9mpaUsYZoHUuqficODLrLychY7itLpQKAZhkeM+z47bEdODo2/sQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yA4zG0np4aqBImwMP69QilajHlfmNJLJYIyo5tSnlWM=;
 b=SciJ7kQwd/o4xtpxvytojT60REdR3Nc7+CJdw0Gau7Mx821f8WP55AXGpokL2JY3MaXoWCCwZ4xVsugW9uVT2f9aUgAWoW47BuKXnbpDz3Rde86bMp+OyU8VJ9gTphwKNi3OYHlTGvzAsG/eBpsft2DydLR7WBe7g+7M1lkoOweIHHvNVNR680rCpZvcq6uR//zaM/UCTfQwNx4S+R0Mc/ogT+YKg6/78kalnPU/tGf2sA3LzbB4xTgPOsfpIeGPbQQg3ZRAbSTFHxGOxCrTsIfBs6ZTI8OAri3zVef6ExKCi+F14Ds1AYyfuzkC9lggtvTCQkoFvDwSQt1Id0XJbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yA4zG0np4aqBImwMP69QilajHlfmNJLJYIyo5tSnlWM=;
 b=jTPqwwcvksXPQWdMeO4MVUvPwfipF6sZW+TuD+v4xzpDio4+lWFIUyUtPPy/scMN5KT1ofcIrBwJ2xOH7KqO64n8f0uqbMI+KAL9JnCzTnRUp/M42p8Er5woo7GHNBldqRXzLgPykDcoioGjWY/dU1rMOsV13t3+BjIQCr4ktZU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by LV3PR10MB7795.namprd10.prod.outlook.com (2603:10b6:408:1b6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Wed, 12 Feb
 2025 16:34:12 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.8422.015; Wed, 12 Feb 2025
 16:34:12 +0000
Message-ID: <d139037b-03b3-485f-ab98-e4613163a2d9@oracle.com>
Date: Wed, 12 Feb 2025 11:34:10 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nfsd: allow SC_STATUS_FREEABLE when searching via
 nfs4_lookup_stateid()
To: Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250212-nfsd-fixes-v1-1-935e3a4919fc@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20250212-nfsd-fixes-v1-1-935e3a4919fc@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0031.namprd03.prod.outlook.com
 (2603:10b6:610:b3::6) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|LV3PR10MB7795:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ac20a5f-6753-4cb6-f345-08dd4b83153c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WXR0Qlg4bnlmYjhzUkg3UklCS1B2WEN4dk1vODZja1BqZ1gvWEY0eXFTNlhp?=
 =?utf-8?B?akRVOURQK2V1aEU5VXlJdU14dEdSZkMxZENoYnhJUkEyK0pRN0dBaHZVMm9n?=
 =?utf-8?B?NFluZE5DVVptRlowTjNHNUh1aisyWXhtVFJLQ1A1Ly9rZ0hZVFIydUVPY1Yy?=
 =?utf-8?B?N0FPYUVIU2N1bG53MCt1M2E1OStZaG5NWVNyaFNob1JhOThaZkltaE8vZGI0?=
 =?utf-8?B?VlI1VHFSK1pTc0gxbHo1OEV5STVEcHUySUdsMEFVQVVuQXpkeS8zay83ZHpV?=
 =?utf-8?B?d0syUFlIcnlRdXhuYktXVWdwMzFCNTZGV013eGo5UUFUMUpXcTRMczFvQzNK?=
 =?utf-8?B?VzNsd1EyOHFWc3ZranVLaEljL2ZYcm90Z0p3cmZULysrMVMxYng0eFJxdWRq?=
 =?utf-8?B?NUtpSlVybVNhOVZBbHJJSERpdEZSaGlQMkdjanlwaXExc0tiVjh1ODZkZjhL?=
 =?utf-8?B?ZGloalVUeEVwNnB5RkxRKys3cndHKzVsU0RqT0JYRFU5TnZXTjMzbEYrdUNY?=
 =?utf-8?B?NjJjSlpHVjF5VmJkd0ZmR2g1ZmlnVkljM0NlblZPZWhQQmxjMTliVHJCVXdm?=
 =?utf-8?B?OTlCdzlZTFdSZm1RVXl4V3JSemtFWk15WStJL1plNm1HT0VxQXlPRFI4WWJv?=
 =?utf-8?B?Q2toTmJ5aHhBN01hbm8wamdVV0ZkQlR4RlhJTlRCZjZleXNtbGR3SHNFeEhT?=
 =?utf-8?B?cmRaaEhLZzZMUisrbUdBbWpqWWh5Y0pDV0hBWUNpeStoUzM2V1o4cEdFZWVT?=
 =?utf-8?B?bUM4SElWc1RvN3BFeEhoMVB0TkYyeGpSU29YVXVLbHhiR3VBbUdDN0xYbkhZ?=
 =?utf-8?B?ZS9RQ2c2RFp2Nkx2YlM5WkkxcXp4Qm1OYnVkeWt5eW5Ma1ZwaFNsSlJ5SHNh?=
 =?utf-8?B?aWdSSkRPL2tRdzg5czBVeDZqaG1pTDY4emNhOTY4cHg4eTVsZGd3Sy9DUU5o?=
 =?utf-8?B?ZHh4T09NU1RueTJzZXNvbmZIa2lVVllpVkk5NXJVVWZHaUpaOXFZZDN0bFA0?=
 =?utf-8?B?MXZFTEsxUFJ0cVhvMUVBRXl2NkkyY2EvT040Ui8xRUFnUXRDUXNOSkkwMzNL?=
 =?utf-8?B?WUtxTzBMeHlsQmhoc2RXTzhBcjE0czBudkdMcTBWc1FtdjJmZ3JmS2k0WEl5?=
 =?utf-8?B?SzE1T0xxK3I3V2hFZ05zWGNyWHpsUjFrYTJ6bjdzUGl0Um5GZTZ5V2RCV283?=
 =?utf-8?B?OW9xQVBiWTFJN2t4c1ZvSGRmZWxaSUFJd0lKZWNkTTBlWmw4M2pEemh0ZzFq?=
 =?utf-8?B?ejBLL1pFaS9NN3hrR3NXelZnTGY0ajd3NEQzdTJISjZIeWo2VGdRWUFCaFVv?=
 =?utf-8?B?UHJPTGliMFpkNkFjbWR6THFiWGZUbVNoMEdIMDJIbXpvUG9jNmt3cEhWNFFH?=
 =?utf-8?B?STlsa01NUGtBOWg4ZjZVa1FHam5mMDRGZlY2YmZhSXZDRzhWZnFTNXR6WFlo?=
 =?utf-8?B?Vmo3cW1oTjBwdm1rejNpMjcxeWs2NHVEZFlyMDJlaFJSWnIwSGFOa2h1ZC9q?=
 =?utf-8?B?cktWZjQ1MEtFY0FzNXlFeW5rc2FRMENGa2xjR0tZNmFzbHhBUjVoa1AxVFVu?=
 =?utf-8?B?cHhiM2dSQkZ4WlgzVEhlWU5pdHhtUU1aalZsT2JwUWIyZzBUSmtVdEFnOHF2?=
 =?utf-8?B?aHhuUVVrRnpaOW5tczhvckRGTE9KREkxQW81c0VsSlAzOHExN0ZscDJFYVBa?=
 =?utf-8?B?QTVXQ1dyOVpub0syZU5uN3ZSRnJmNHFiWldSMDdGeVNQazlGUXFsRHFtMjRV?=
 =?utf-8?B?cGdldExkRzdZNDJlbzRweWMwWU44Q2JDbFlBSzQvbFBFRXlOelZPT0w1WDZS?=
 =?utf-8?B?cTFRa3BaU1Z2M0tjS1BGc0ZTQ0Y1S0dSUng4TzdQQjR6bnA1RFFNZitXaGNt?=
 =?utf-8?Q?pvSPnHafpXHGR?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SUJzYUg3TVU3b3VmVW04dEFJTjNlSSs0OFd6S016UzY1THhxS3JXZnVOL3RH?=
 =?utf-8?B?NDlBb1FCMUVrMWR4U1pDZlhTdU9reGtXSThqQzZMNEZnaldsMDJPYURsZVhY?=
 =?utf-8?B?Nk9TbHhQOEdiK3o3cmFoWm1rcnpORmZ1Q0hhemRvOUgwYzdGRDlSTDJkQkpC?=
 =?utf-8?B?b0phZzJMeG1XWEg0UE5JUGN2cW5vU0h1a3Z6bEltRUptcXpsUmgzUkczazZO?=
 =?utf-8?B?M0dPc2lHMWhOTHh2Q3pmcEZZOUZzZ21Jbk13czNOTkg4ejhuUHMreTRoOUtY?=
 =?utf-8?B?VHc5OTFpYmhOTTVjS2c5NHo5UVE1Q0hCQk1wQ0twWG9YbmV2Q3JFS3R1SzE1?=
 =?utf-8?B?TGt3MUdYUDkzYUEyazlWd0tsMGhoWEFxOFpCNW0ydlpQOGtaSzJwRnRnd0pr?=
 =?utf-8?B?VW40L3lCbzR1V0MzdFlpN05JMEI0Sk5FaUViS2RmSVBFcWg4L0xoc3kxYkFU?=
 =?utf-8?B?MWZEQVhtcmE1Y29GODRwcEFNVS9GbzNUNXZESTdZRTRSTDd3dy9LOXpCVkdy?=
 =?utf-8?B?WWwzOXlITzVjOXh6ZTBreGlmYncrQzJxQnpWTDlqR0oyMVkxU0VveUVuakIy?=
 =?utf-8?B?dXlHWkUxQVRvK0RlRDF5UmZDNlJTTmREWFZadGFTa2o5ZW1wSHBRVFJSYm1X?=
 =?utf-8?B?ZmtqTEE4OXRJbm14aWRoTmZLaTFiUHVVaEQwbkRrOVBxdTBYcVVwUEFFZ3Yr?=
 =?utf-8?B?cXN1UTZDSEZsVlAxVmxKVmVkcFJIZlRObUZrTHgyblRhSlVhdEVZZkZSb1Rl?=
 =?utf-8?B?OEYyakRoNzM5QXpTY2FLY2JEU0NwR1BiQTZWR0tTYnN5cVNmZk94dDl1VHJz?=
 =?utf-8?B?L21yRGlvdDRyYVFPbkEwZFpzeTdwR3RJQkJ3ekN3TjFsNjNTQjkrcUhJTUpr?=
 =?utf-8?B?RHRCYzZxVGNGc2YxM3dhaHBnL2tKdnJhdmNMYzN3OFhobVpYNUxELytHcDdS?=
 =?utf-8?B?WUMvZGc0V005RUZTWEFmK1BVaWlBdG9BMmFYNXc0THphbDZGZUVYZVR2ZTd6?=
 =?utf-8?B?RloxNGJNaTlKMEtaSDdUR0Y3TWN1UVpBSWtFOWpIVmJVSjdpZkhqS1NHTEwy?=
 =?utf-8?B?eVBkN3ZMSncybUFQTVFHK3dpbHBhTGJJU20wbkxjanUvTmFHL212N0Zyb3JO?=
 =?utf-8?B?aERRK0wyMjQ3QW02aExOQ2F4QXVDaEZIQWxtWFV6ekNZT3hHRE1vWnl4RWpm?=
 =?utf-8?B?d0FXNlJwWnovR2FYU1l0TGF4S3dTQkRaWjBvdUw5dGN3ZFVHcUtUNjNudVV6?=
 =?utf-8?B?V1k0WUg3dTQxUi9JRlRtMThHSzk0cUltVEgvTzdibjBzVHY4N2gyODZXZ1l0?=
 =?utf-8?B?OHlrNjlWVWNzRjg0OGxDV1h5a09mUlFXZUhxZi9xR2FiaFdGbUZTQlJYV2x3?=
 =?utf-8?B?VEI0alpzVksrM0QrY2wxOUZzVG1vSml5Mjd4MFU0MU9VRkhrL25NUFRXM1hn?=
 =?utf-8?B?UXYvbjlqTVZNNzNXd04zUDNUUXhqOGNOV2I4Y3B6MGN3Wm5BOEV6UTBMQS9N?=
 =?utf-8?B?NHhPWHpBU0w1Y3ZDbXk4aWZJb2RHUlFPN2VFa2kxVjg5OWt1N3VCTHNTWTdB?=
 =?utf-8?B?SWl0cHdrTFlTc2tHTlNwYjRPVnpZa1hJdmpoK3lMdGVQM3ZJY1d5a3RNYnp1?=
 =?utf-8?B?Ty9ocmpacmQ2UnJDY2xsbTMzYmFGekJTanhwM1FIMS9ER3N2cFV3ZHpTaTUr?=
 =?utf-8?B?cnREa011V2dDdTIrU3RweEZYaXEzZHQxeDFCUnRZQW50QXhLNTRRWmtIU1I4?=
 =?utf-8?B?L0cvZ2VaejJQMjRsMjhJMmF4R2VWc0lnNHVqOHoyTWdhemM5akZpV2RUZjFa?=
 =?utf-8?B?Ri9Xc3RpVzdQSm5UbXVQNTUvSFJjaHgxUFFxZlhZUGd2MEZob0NrenkxNVJJ?=
 =?utf-8?B?cUxMTHA5OEgvV29qWjFyOHhmNDgydlJTVGxsNnBKcmo0WUZFTmhmOVhhUWFK?=
 =?utf-8?B?bkRRV2c4RFhtbkVIUWx1OWgxZ3JTU1p5WkdUZ3h1S1dWKzRnMDRhUVdRT0Vj?=
 =?utf-8?B?NGE1NWtaUzBaS25udENIOGg5TU9LV1YxZCtQbmRRdTE0eTBydDVkQlBNNTBC?=
 =?utf-8?B?OFB6SUdMbC9MUFpLS0Q1YXpHd2hGbDNuMksxamZXWXRQUnlNNVBKVnJLUWcx?=
 =?utf-8?B?SUR4citLUXdTd3BYMEZvT1hsd2tiWmdyKzZHejd6QU1md2UxUXNCYnhvYWZS?=
 =?utf-8?B?T0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Zq7ySIsglXZ5Gl9uwumWRuPyQEUuIb1eBbJ4zea+KYKREKiBu9FReLK2CEzZvpymPrw5DaCzEk09Zc9PKJTfKMxYUHBrslEAf0r81AEI+mmsR3OwOdUjapr+1sRj052QX8mB6zRrX4ZUaViu57tMPYnbtQx7WyMJvqFMg0cUuIT6YLZJ56e66i0LHy5pzJIW5VhZx8lQLWMNaTUppTOCDpf8TC/EqB2ws3TcZWzlIMphZ4qRgcka5rW8qH2NnX1lf+LKaiCU/lYdzEBsh7W8lhpCblToYtEGxkofteYXwaIIM7HgzZv8j1fZco7jPXGRXDOr24TT7TDjqi0akyjxmd+8jV7NM75SzON0TVOb6+TROG5MF/mUcCb2Im8EK0g1VrWR6CZqCYnvxn3qD1EIhmd3X9dMtShJjjkLFDUPG5RsVMkfycpuy7rDqKznR9HcVLBRmd6oKEmNRyyzZgB+HlO6HIVqd4AFlf15ygmidO/LvGsNuihS7EonsEL9R6qLy7V+YIfoyo6nRjzHT9X8eR6EUDAAWj38J+toeFoLFUsrknCDLpcADlXkElkOPvRfQEyekru9+ztceIxEuBI4+aY+rnS6i+7iJftUai4hRBA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ac20a5f-6753-4cb6-f345-08dd4b83153c
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 16:34:12.8001
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7uDhNpWMkpcoJCkdpSf/1eW9dBasefgyV1G993TL5qgGxyqOD9hs7rE4oCkGhJ/B7wPDed9gLEgJRAjXVkqEyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7795
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-12_05,2025-02-11_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=839 malwarescore=0
 adultscore=0 mlxscore=0 phishscore=0 suspectscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502120123
X-Proofpoint-GUID: vyIL7Cen3Rq14dSrMX3O3nw4hAdDQINV
X-Proofpoint-ORIG-GUID: vyIL7Cen3Rq14dSrMX3O3nw4hAdDQINV

On 2/12/25 11:29 AM, Jeff Layton wrote:
> When a delegation is revoked, it's initially marked with
> SC_STATUS_REVOKED, or SC_STATUS_ADMIN_REVOKED and later, it's marked
> with the SC_STATUS_FREEABLE flag, which denotes that it is waiting for
> s FREE_STATEID call.
> 
> nfs4_lookup_stateid() accepts a statusmask that includes the status
> flags that a found stateid is allowed to have. Currently, that mask
> never includes SC_STATUS_FREEABLE, which means that revoked delegations
> are (almost) never found.
> 
> Add SC_STATUS_FREEABLE to the always-allowed status flags.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> This fixes the pynfs DELEG8 test.

A little release engineering:

 - The DELEG8 mention IMO should be the lede in the patch description

 - Do we want Fixes: and/or Cc: stable tags?


> ---
>  fs/nfsd/nfs4state.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 153eeea2c7c999d003cd1f36cecb0dd4f6e049b8..56bf07d623d085589823f3fba18afa62c0b3dbd2 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -7051,7 +7051,7 @@ nfsd4_lookup_stateid(struct nfsd4_compound_state *cstate,
>  		 */
>  		statusmask |= SC_STATUS_REVOKED;
>  
> -	statusmask |= SC_STATUS_ADMIN_REVOKED;
> +	statusmask |= SC_STATUS_ADMIN_REVOKED | SC_STATUS_FREEABLE;
>  
>  	if (ZERO_STATEID(stateid) || ONE_STATEID(stateid) ||
>  		CLOSE_STATEID(stateid))
> 
> ---
> base-commit: 4990d098433db18c854e75fb0f90d941eb7d479e
> change-id: 20250212-nfsd-fixes-fa8047082335
> 
> Best regards,


-- 
Chuck Lever

