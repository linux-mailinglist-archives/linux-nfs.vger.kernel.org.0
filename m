Return-Path: <linux-nfs+bounces-6545-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE7D697C45F
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Sep 2024 08:39:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FF6D1C21959
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Sep 2024 06:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1909E18DF63;
	Thu, 19 Sep 2024 06:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EpVca3P2"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2078.outbound.protection.outlook.com [40.107.101.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6579B54658;
	Thu, 19 Sep 2024 06:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726727948; cv=fail; b=BtXq3ynDQwQ0ZnYIxM4zqsHn2apv5vZY+TQgxIIsRGMyW11GefDrcug5yn9RybN3/1qDO6/Jho/5bsGuMsOc5hkLPmIIUw5xStLJjWjSVOyu54wET/s40Y7pkxVeUuk4rHDzRL+ohHRmj4zmDbfQbXUqiEODP9X0TOCrFr2soJ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726727948; c=relaxed/simple;
	bh=a2IMgIA5giJZ6E7F7JnclQLN+qC0KS5cXnuV9313CP8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WIZbHeMj2Mdbbbrp9UlIKqAGeeAGh3a7vSkXSC5l3scvbc36DoFxvnXYwRiWCiT3dRlVO8ApakSfo/MtemO3xR/JaXYIcfVpBiWQW9hkFJlXB1KjQHG67J8afhEEYujA+KYtSxLz4a2r0GQZQC8JGvE16oggqNxAGPfGsIhOn10=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EpVca3P2; arc=fail smtp.client-ip=40.107.101.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cTWU3z4hsgF6UJjRQd+LpxKmNeOrYZhZSqj6e6feIzRdLn8PlfbAIyzF7utKzM82JWkx40xivni59IRkM0RwqweL1YIEqedyhAeAAUEhkidhrgTiCUUuzCMe0Rr4f0lSda5iGQtGijQv07Q4HQFGbxcEkzN7vfJm3+RID1D/TikZwP1EqhDrl6gjnZdkvuo54roN3WF5RjWfS4Rs2R++HSLnnTK/+KSMicHiO6LP2szjmKXRXaTLc0R3RrJ5qixbIQMhax5pEyaRodWWrXBx/54NM9OEGBF5CJSLezhvelilYn+esSuNTmEC8AjR9PimTcp0st8/+q8LzZdy5JUV6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4yJ2nikZ0gkOTClFoXEoMOLbi11p3n56tZ7WkvXpZLk=;
 b=R8oU049VepEV0AITfX0g0Jvz3yCWXuJFnBWUDv2dM6VNvktB/WJdV4AQj/SBXmScKKeer34JWOUG+UM5pwfrmfQyIhmFwFKdbZ3hilp/qDl6zVLXlQy0RaMBlSSTEfbH21ohcc8nZGq7Nh+TcdpdEzkDjJT0bVD+PGd23Xh+GeGGJHdGkmXuf3yfTTvNtlC+lFR+03Tps1ywJ93J4LlCGy2h2yDgy2rb1fnC0JIRPhLOPKcgFPO/cZFQxfAa53rAnO8/AJlMGhaMQNIzLwAlCRTNkrmBsNQJAA7a48qMZ7f6C4jy4veiwEWDNCNy2+Jc33D2PxEMMeCdSELv/+YmQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4yJ2nikZ0gkOTClFoXEoMOLbi11p3n56tZ7WkvXpZLk=;
 b=EpVca3P25URWQCq/Xga6BqHPBcaXwBWUEINBEasp/Xf6y6Xd0ree/JX/HLBV/wemeDvcjQ3Vn+vBts36JChJC11Q7XUv6FNh8Lv2Co9bDgIVNI7YQIbSfG+nV7t7X/HVkhUxDcIsE042Phk2e7Jj57U2TYydpvU16f30APo3kvCPjatwaSPK5Rzq4aJll5GiUwG0gLOhMEjcePCj6cDpZxuuI1zKOKbbzXB8xuAuDoVoq5OfEGlKsg4x6hLdomnphitgN8ToQV12DqqQC7R87C/gqjmHwfPDqNiszUJU3MkSeWvBgRq4agwz/sSxTGyKH2M5NPnyBR0nxqriUKlwGw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM8PR12MB5447.namprd12.prod.outlook.com (2603:10b6:8:36::7) by
 DM4PR12MB6640.namprd12.prod.outlook.com (2603:10b6:8:8f::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7982.16; Thu, 19 Sep 2024 06:39:03 +0000
Received: from DM8PR12MB5447.namprd12.prod.outlook.com
 ([fe80::5f8:82ee:7da9:219b]) by DM8PR12MB5447.namprd12.prod.outlook.com
 ([fe80::5f8:82ee:7da9:219b%4]) with mapi id 15.20.7982.012; Thu, 19 Sep 2024
 06:39:03 +0000
Message-ID: <c98e8af5-f50c-49e4-8ced-0795ebcd2fbb@nvidia.com>
Date: Thu, 19 Sep 2024 07:38:57 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nfs: simplify and guarantee owner uniqueness.
To: NeilBrown <neilb@suse.de>, Steven Price <steven.price@arm.com>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
 linux-nfs@vger.kernel.org,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <172558992310.4433.1385243627662249022@noble.neil.brown.name>
 <5c90c3d0-c51f-4012-9ab6-408d023570c8@arm.com>
 <172652955677.17050.4744720185342907808@noble.neil.brown.name>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <172652955677.17050.4744720185342907808@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0221.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:33a::20) To DM8PR12MB5447.namprd12.prod.outlook.com
 (2603:10b6:8:36::7)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5447:EE_|DM4PR12MB6640:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e2ca1e9-1fc9-4088-568a-08dcd875c04b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aHpvdWpyQ2FSNTM0L0xPK3RLbnczMFp4N2MxbnROemdraVRmcWhyWDcxWk01?=
 =?utf-8?B?dWNLbG1kVXIwTHJWSVBGbkZ5NW44dDVrQ3FYeEtuVVphSTNiTjBmcWxzR3N3?=
 =?utf-8?B?aFVTNGZtUWVZUzlhRHpHVG1EWEZEcHlUeUczUDdpdWt3M1J4V1pWWUJQUHRF?=
 =?utf-8?B?ZFF4cmNLY1NyNlZNdmhFVEFKU3RZUnJQazFnYmFJRGtMTlRvdHlIR3N4Z25O?=
 =?utf-8?B?YXFRQlhzT25ERVVuTWRDdGVrbElPZUNwTGNBRlQybUlCTzNWcjRlOGUxWjdn?=
 =?utf-8?B?Mk1VZ2pObUl1ZkhLbHZ5VFpyYVlOQ1Q5RksrNUdPWTVzVnBWRzEwMksyR3pV?=
 =?utf-8?B?am5lWlhFZjZZRHl4UVBDR1p3bS90M2Nha1p6UzhpUVdaclJzWjdXdkkwVnlT?=
 =?utf-8?B?UlYzMzlWbjZkNnVneVVyWVpYdDBMaERDcWlGd0tYYXlxaEdTLzNsMGYwdWFD?=
 =?utf-8?B?K3JBdE9GL3p3aXM5QVNvcVpOZkNjbHRWYU5OdDZJQm9LN3pnTzRDNC9rUEIv?=
 =?utf-8?B?ZTVSamFSeFkvamVKcDd0Ukx2RFhKNU1VVnJjMnJMdVZBRFJYQnBVUnZGMnBy?=
 =?utf-8?B?YW5kUU5uSjc2cUtYZHh0QVlmODB6L3k4UGdNdU1Bc3k0NXhiU3VFRzd2VlRJ?=
 =?utf-8?B?Q0JZV21RbHRTalBtZlRkYjBjWXhGTXl6d2FQTUZUMDVmUkY1SGxFb253NVVV?=
 =?utf-8?B?R1luNWtDVDFqdHdtemQ2MnZSMWlHMkhlNU5JeVg5OFlHTjFUQjRZa0NXNzMy?=
 =?utf-8?B?dEpvckRjQWt0dkt5QnJvNE9FZFZ4d1pMOGo4ZWFIakFNQUFLVTRCYmZQTm1o?=
 =?utf-8?B?Q0lUaDF6SjNJV0JNNmwydWJCYnZtNHhQNUgxR2paeHl3OG10b0hKSWNyODc0?=
 =?utf-8?B?MmY5ckhYVndXQ2lUSUJSbjI3dFB1RmcrWlp4cGNkSVlpRUhFSFRCa3dEK0Vu?=
 =?utf-8?B?NTZMa2hZRThUVWpRbGdBVUdWSHh6QUl2TWRYd1hJZlllZC9ZemFXNUxHN3Zh?=
 =?utf-8?B?a0lqb0JGSnI0VkQwZUQ3MVNyRWNUSkM3VEFkT3ROQjFVb0ZBTjVyVkxvWE40?=
 =?utf-8?B?RmlySGs4ak1Wc1BZN1ljRENSOTA2MGNidFVpQW1TQ0dTckxKeHpxWkhpbFVp?=
 =?utf-8?B?R1RRSFBCVTkzWkZDaGpSdEpqdk5ob0h6UCtxM1hHRWt6VEYzZzN4VWVNOUhG?=
 =?utf-8?B?b2NqTzFkUEk2eHNKdGQ4dFQranR4cjBkOHhUTnZkdDkxVHdabUJlZjFtTVNq?=
 =?utf-8?B?NUpYZWtuMVR2Y2dWL0prUFRmWkJtQW1jTVhQaWp6MTZZSFF6d0lLVkV2c2d1?=
 =?utf-8?B?UEFzYjBIRndlQ2k1RFg5VFUwcFo4OVF5azBVQUcyTk8wR2w2K2V6a0VaMkVW?=
 =?utf-8?B?MTdaMEVvajFnNGJBVHdsY01kaDlsR3Rtc0htVHZBSE5RVXh6anlpTUFGRWJ3?=
 =?utf-8?B?SnJ6VmxOUlllaVNUZStLQVJIZDBBYXZHV3dURmlidmNuRnd3TUhZT3dtdC90?=
 =?utf-8?B?NkxUZ1NKWUZETktjSi9vL0RDTVAxRXluSkl2cU0weUZGNGtIMmlmc2dCK3lB?=
 =?utf-8?B?MDducDN2dTBJNWtKbXAxdGRPODhNbEIrODM2WkwwdUFmT2c5LzAvOTJuRkJJ?=
 =?utf-8?B?WDk4cEdPVjU4WlJhSFpsczYyS3FyTkJrSlNKREYzeGV6QzVnMWJwVldLT3Z2?=
 =?utf-8?B?dnRjUjMwSFJ6MGNvd2I4WlBjODAvdDRrRWpRNFdBaVlrY2N5ZWhDWkF4ZnZW?=
 =?utf-8?B?Yy9NMjBPUmhsZ09NeWd2U0dWUlc2MnN6VWlPVDRzdlNBZ01kS1haeFYxV3V1?=
 =?utf-8?B?aDBHQ0Z5QnRzeUdhQ0JOdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5447.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c0ZsYUJBK3hPcnhSeWNCaW9hNXoyeUR6QVFqZjVOL2wwZk51OUY5cm1FYTB0?=
 =?utf-8?B?TE9vaHVrckpyelovTzlWbjBTdWRUaS8vTXZnSUtPWm8vQXZBTVNjNE5wZ1k3?=
 =?utf-8?B?YTBxcS9mSDlPNFRSNGVBc3o3OHRHVEZJSW4rRHFHRnJxOWlWMzIvS0pWS2NU?=
 =?utf-8?B?Zm9kRFRCUmlBQTFtRWs2aXhOMG9SM2NER2ZNdTNud2hSaThhV2xPQzIvZHhI?=
 =?utf-8?B?OUtLc2NCcUVkaVJTMGtSZHFrNzBmZVZ0aHlncm1wRzBoNFlPWVJOOFlid2F4?=
 =?utf-8?B?aGJYN0hIUlBKOGFsUGh3ZHRuMm8rN3J6RUM4NEpKTWJRMnNmeGFTNFhYSE1w?=
 =?utf-8?B?M0J5dVFBZThySzd0bytpOG9ZS3QwUUpRd0FHYjVHb2IrelZFWHFNT240VFlC?=
 =?utf-8?B?T2lxZ2MyT05JeWtqZnNZNUVVMGg4cWV6TEx3TWRGblpkaWJoZjBvZlFIdUho?=
 =?utf-8?B?QWpuTTh4MmFlQzJJVjhZaDFZM0xsb1RiR3l2azhaWDBoSlM5Smc5VUhmMjAz?=
 =?utf-8?B?QVlGQXBuQXV1UTV5cTM0M2Y0YmdFQnZrdUR4RkVQUXhWK2F0bjJnL080RWFH?=
 =?utf-8?B?Z0VJNElZcVpxYTdKdVAxWWhwc3EzNThIR2NWc2g1OENaTklMcGpQZzNRVGhF?=
 =?utf-8?B?OUVEU3lRcnhzc1pwc3FhU09sSWNiemVhdGxDMlIzc3M2WDlnQ1BwcFJLNGVw?=
 =?utf-8?B?M01hSUNLbjBWelZ0Yk1yNGlzSXNidGJVSmdlam42ZWswRm9nM3pvaS83eTMz?=
 =?utf-8?B?VUoyeDZJQW1wQSs1MXVYOEswRzZiZ3Y0bExNb1dsVHlsNWVEcExXbWFPd2Uw?=
 =?utf-8?B?QkRLRVhwOTFJOGp2dk9sN0xQTFV1dWYzZUJxeVlmUGVuR1VZWU1TVCtwc1Qr?=
 =?utf-8?B?RWNWVS8yanJHNzVDV3RkS0Q5cVBEVWdxbHl0bTIwVkNwdlB6Q1pvbmhiZ0N3?=
 =?utf-8?B?ZXUvUGlKVHUrWUZkVGxDTWExWjFzYVRsVEFXNk9nUnE5TnhTTHlJcG11SHdy?=
 =?utf-8?B?V0g2bzlmVzJiMWhRUEx4M1cvSzJUODFzVnJWZmRkR2R2SndidmttSXkyV1Fk?=
 =?utf-8?B?c3lxMWg2cFZkSjB0d0JCTlVQQzVJcmJBaGZFZUtWZnlnK3lQUnIwY2hVTnhX?=
 =?utf-8?B?OUFSS0pnUnd2bTcxYkJOSXpwMytueDgwazhrRjdyajF0NS91TEtYVHdJOUxy?=
 =?utf-8?B?Y2QwVUdJTklaSEJsOFRtakJLMEYyK0d6NnZ5UlN5Mi9DN2hOaXBZTURod0Rz?=
 =?utf-8?B?RlNnRndaL2RML2xFb0ppMklKTzZTQWdHN0FkRTZ0aFZMQloxVkpPUWVsSVBk?=
 =?utf-8?B?dDFqYkUweFRKRlFNVDllS2RyaklDdUthRHZsRzZ0eElnQVhsSlhkZWNLNUYy?=
 =?utf-8?B?THYySEhRR1I0NlM2MEQrdml1WHF5N1duRVlKUVZMZUZJdDJKS2g5VTQvbkly?=
 =?utf-8?B?RlNEazlkYkkvK2QzdmJCZ0p0MXcwd1luMC80Z1dmbkxIS0E1RG02QkRxempO?=
 =?utf-8?B?RE42K2ovL3o5YW5GdER1ZCtodmNIR1h3alhzbWJFdm9hQlJZQjBzVU9NUEdo?=
 =?utf-8?B?SktBZkllLytIcGNJWVNlMm1UZUYyT1ZoMTFWMk9DaExSWU5NZm9jK0Q1ZDJn?=
 =?utf-8?B?S0NtTE1leHQvbDd2L0ZkTWlrTmRtOFQ1bnR1WXhZNXBLRDBoL3lNRmFIUEFC?=
 =?utf-8?B?eklTaXU1WGFGcjdLRFBmbmtuZE5jS2kyWStKUVBaczZ0bDFyeS9GUTM3Skxy?=
 =?utf-8?B?cTZIQm1EWTZPZjEvMHloeHUzaHJXT1Vaak5VMjFWZytwK2RxYWszVlVyVDR6?=
 =?utf-8?B?TC94RndRMFViK3UweHlHY0IxMnpvOWZKTU5Qbmc4NUhkWEUzS0xORHR6WUFT?=
 =?utf-8?B?U3d5N25Od0hSUGhNbkorNmh5TXdyY1pqWVBNcFJZNGRNbEUxMk8zMlVJRWRv?=
 =?utf-8?B?R0h1eTdOclJpMUhuOGcwK2JJLzhWVWZVakF5c3d3bEMvTWdTVFdUNkVyVkhO?=
 =?utf-8?B?VDQwanI0YVZKdlRkNEwxS1BrL3E1a1doRXArSnlnditJQ0Yzazgza09BZTFG?=
 =?utf-8?B?QU9JbE1iVEtPSTdiWDE5TWJjM216TWhJK3ltbGlGZ1FiSDNYZ2xqTndldkN2?=
 =?utf-8?Q?fnXsv5eOHaIHON5H6+FyeJkeN?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e2ca1e9-1fc9-4088-568a-08dcd875c04b
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5447.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 06:39:03.0786
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fyD3wEzK3oltSU68dkNSfJ8v5UuuECK4IMSiIYWNzDmaLklMcWwBwQjxfIulK2+djI6eInoJKz1RtCnZpihQAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6640

Hi Neil,

On 17/09/2024 00:32, NeilBrown wrote:
> On Tue, 17 Sep 2024, Steven Price wrote:
>>
>> Hi Neil,
>>
>> I'm seeing issues on a test board using an NFS root which I've bisected
>> to this commit in linux-next. The kernel spits out many errors of the form:
>>
>> [    7.478995] NFS: v4 server <ip>  returned a bad sequence-id error!
>> [    7.599462] NFS: v4 server <ip>  returned a bad sequence-id error!
>> [    7.600570] NFS: v4 server <ip>  returned a bad sequence-id error!
>> [    7.615243] NFS: v4 server <ip>  returned a bad sequence-id error!
>> [    7.636756] NFS: v4 server <ip>  returned a bad sequence-id error!
>> [    7.644808] NFS: v4 server <ip>  returned a bad sequence-id error!
>> [    7.653605] NFS: v4 server <ip>  returned a bad sequence-id error!
>> [    7.692836] NFS: nfs4_reclaim_open_state: unhandled error -10026
>> [    7.699573] NFSv4: state recovery failed for open file
>> arm-linux-gnueabihf/libgpg-error.so.0.29.0, error = -10026
>> [    7.711055] NFSv4: state recovery failed for open file
>> arm-linux-gnueabihf/libgpg-error.so.0.29.0, error = -10026
>>
>> (with the filename obviously varying)
>>
>> The NFS server is a standard Debian 12 system.
>>
>> Any ideas?
> 
> Not immediately.  It appears that when the client opens a file during
> recovery, the server doesn't like the seqid that it uses...
> 
> Recover happens when the server restarts and when the client and server
> have been out of contact for an extended period or time (>90 seconds by
> default).
> Was either of those the case here?  Which one?


I am seeing various failures on -next and bisect is also pointing to
this commit. Reverting it does fix these issues. On one board I also
observed ...

[   12.674296] NFS: v4 server 192.168.99.1  returned a bad sequence-id error!
[   12.780476] NFS: v4 server 192.168.99.1  returned a bad sequence-id error!
[   12.829071] NFS: v4 server 192.168.99.1  returned a bad sequence-id error!
[   12.971432] NFS: v4 server 192.168.99.1  returned a bad sequence-id error!
[   13.102700] NFS: v4 server 192.168.99.1  returned a bad sequence-id error!
[   13.171315] NFS: v4 server 192.168.99.1  returned a bad sequence-id error!
[   13.216019] NFS: v4 server 192.168.99.1  returned a bad sequence-id error!
[   13.273610] NFS: v4 server 192.168.99.1  returned a bad sequence-id error!
[   13.298471] NFS: v4 server 192.168.99.1  returned a bad sequence-id error!

And on the same board I see ...

[   16.496417] NFS: nfs4_reclaim_open_state: unhandled error -10026
[   16.991736] NFS: nfs4_reclaim_open_state: unhandled error -10026
[   17.106226] NFS: nfs4_reclaim_open_state: unhandled error -10026

Jon

-- 
nvpublic

