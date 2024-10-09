Return-Path: <linux-nfs+bounces-6980-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4165399708E
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Oct 2024 18:08:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FCA3B22941
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Oct 2024 16:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E1E18E379;
	Wed,  9 Oct 2024 15:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DYBvte/G";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dykLAnW0"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D53A282F1
	for <linux-nfs@vger.kernel.org>; Wed,  9 Oct 2024 15:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728488738; cv=fail; b=s2QRFAURUmeRmQBh1Z2jjmtIyTFmCogIx/zqNGYohRHKxtKyBkbErX6E+FNA32qAPuk/NHc8cUMQxDLm1yGi2zoPGiRGj0zbiRdSGE2SpOqq/KBggUhm19b8IHw3jVF3XzbKcVDua8UVea6jZpQAiq4veP92GODotY6p0RDImok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728488738; c=relaxed/simple;
	bh=N0JinkNcYiRcXRqjLNwOcDXradPwyxuJqeLVqRCrL9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Nw5S5Eq83prjd33KpK4vjI4AtYgRrFTtzZvLysSV3hgkKCfCj0gwrQ9wNuq7Oc78mH0QzPuZi/t7+fuMOvOgWLRXSIKsIy2xHQsmmZ3N2mnmpq7mXmRlCscUgVXLRbB1AAcv3LGgrPYL/AtQecjzNZSNUHXJXLnl28j0Tp5Wz4Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DYBvte/G; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dykLAnW0; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 499Ethkm030340;
	Wed, 9 Oct 2024 15:45:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=awRiX+vg6ZQ223Oe2t
	vj9nXZ9G0zmozpwGX/zPbl94U=; b=DYBvte/GC0QucuFlJAO0eclPPxtQow6MCi
	BotwDb+kpEp2KIXT2ZL3UQ21rAQ9GWNPCdMePIXz4Pr1ynDCK/sqpgU4wvQHBZ5q
	idiabvnXHC6X183TbWxbbPhk1byJMjmGNdJpG6k8xPm1xdORtxwsqdHZnS8XqZhz
	Ec5qmumXMFXQl5NwltYQfXxBXnmmNaXHDsv5BAzFKIb51bDUpQqp+4slY0E3/5rs
	Em0xObAbj+dpmBAAm86oNqrMN42LQb5Hc38u55qVo8OZjy1jf52gN3ocPKwAxyr7
	YM+8OhIaBAnCbsho4gqu78PyId7EKD/LRAF6yIBYp54ISKa4zj5Q==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 422yyv8nyp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Oct 2024 15:45:25 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 499FTTCL015252;
	Wed, 9 Oct 2024 15:45:24 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 422uw8sjxq-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Oct 2024 15:45:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WFKC/WycHtHXcOJAe/la9GWIPiJNmReSr5NDiGBKipesqPEme5h6m3NBNsxka3rJRdrJbJrvHIVXDEESdh4s20x3ooX5EjAlOvLVLqFJJNeOxQSKd3Rb9ihujq17bxh8AzQKgY3lO/3LMVWq1T0F4cJ6zWEfQrokXA4abAviL2TBGJAsIL0SlURsNDc+NAkO5SDee/IPQSYPg3Gd5sLbl3uTOy/3R2vYCrXvBB42iPlfcdc/7FtHvl1DSMnWm6nilqbcySWRpZLt746sbwdgcrZH6MIQ1daSr2GdUgwN2ZpnX1h6UuuWrQ+x7EyNkQbS80ocYQbqEFhEmSyrvSMerw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=awRiX+vg6ZQ223Oe2tvj9nXZ9G0zmozpwGX/zPbl94U=;
 b=rBOkXNz1Zyq6cs3kAxpuGN0nrelbIp4rxmdjff+Xowz0us8h8+74t/3CSsFR/thlqVMuiCAKBD8L6iC1G8TXyJWVq0ecjRY7o2xRMX0AUcPpvJz1xtpb1eQyXnagWFU+etUEWoUuKQQQRXc86/nv+Hr0bu80Xs9aGtyHiiDCCn22vuNzVRNKJJajVzzfjThgBssiFr6lXK38o3MKgCltf3aawhsli/of5v+Dycmal7LnbbCmu1V4KEjXeU+kOLCiOTAr7CAAg98UEZ02YViFXVJc2XaNFeOd7dDz0v7C0yTIWgLAlce6MgIa6tSZ6PFCBD2Imbnm6UhMrb6wFAtLCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=awRiX+vg6ZQ223Oe2tvj9nXZ9G0zmozpwGX/zPbl94U=;
 b=dykLAnW0rlTSAydlLof+J2UilGKWVGFKWeczGTfhIGbefOAO2bD+0Q+8ekMkeIi4fxrro1ApNVyJLntw729TzfgoERifYxcZciqrcvFBOKOFXPrs7aVDfIwetzGI7F6nRU4aSRUDmWZtCyvX3AD1gITLQUcud3X3igl44XmsB4I=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH3PR10MB6812.namprd10.prod.outlook.com (2603:10b6:610:14b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Wed, 9 Oct
 2024 15:45:15 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.8048.013; Wed, 9 Oct 2024
 15:45:15 +0000
Date: Wed, 9 Oct 2024 11:45:12 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: NeilBrown <neilb@suse.de>
Cc: "cel@kernel.org" <cel@kernel.org>, Jeff Layton <jlayton@kernel.org>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        Olga Kornievskaia <kolga@netapp.com>
Subject: Re: [RFC PATCH 8/9] NFS: Use NFSv4.2's OFFLOAD_STATUS operation
Message-ID: <ZwalCPYPBwUa+P7y@tissot.1015granger.net>
References: <20241008134719.116825-11-cel@kernel.org>
 <20241008134719.116825-19-cel@kernel.org>
 <172842544436.3184596.6687790135549454861@noble.neil.brown.name>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <172842544436.3184596.6687790135549454861@noble.neil.brown.name>
X-ClientProxiedBy: CH0PR04CA0038.namprd04.prod.outlook.com
 (2603:10b6:610:77::13) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH3PR10MB6812:EE_
X-MS-Office365-Filtering-Correlation-Id: f912a3e1-e82b-4d57-4a96-08dce8795e84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NrjMaumEdrtIuN6FJ1vkEZqQQtHIjHDRb5GTz0wE847IGnMP9rR5bxpaOPlQ?=
 =?us-ascii?Q?+P2xiknlWGmPdATGDI7HyjKuu8pn4le4azUoJ97sUNnB2Bk6o3GwX/B3dybv?=
 =?us-ascii?Q?6EIkhMLsNGGKXOU4qis0t/PmLQxK4la0beKmGP8n4poG3XHVRYc+XDcoQMkF?=
 =?us-ascii?Q?HciyZ0/lveJqFxI8uoO4JbcmWpHeGP3u1DriVdcSy217Tc08rDUPsgdWKdq+?=
 =?us-ascii?Q?AQcExrEfCMw+DYDFad+3fEEdk0JjbZRBhu2zfkYooM7WWg5gvum8Z86D0NWx?=
 =?us-ascii?Q?+qZfjrmrkgpZchi+/4Qu+/Pd+LkXQVr2FakhR5RFRIlm2GqdMQ1/wLiXql4z?=
 =?us-ascii?Q?fGAMP7LPX4sYsQfB4ZlMj/7ThzDn2i+oSVC5gOLa9laTyeqxzlpI4kQOVX2J?=
 =?us-ascii?Q?Zhf1PMY3mYJ4e3ApGcAXPqWRp6+g1u4YR/tSMTrfnbcbf83CHa/uXPhVc9+T?=
 =?us-ascii?Q?QVVmJ+JZP+PkTNKdzKAEQnnoeZabEvkq+TjBTzFSPtNbCasjtZyWXRc76P4M?=
 =?us-ascii?Q?nLA+rFBoFoLwgVWtHJVHqOdATs9A1HnW6xmxkFEVM1F8pQpCp82nX6SMtPoA?=
 =?us-ascii?Q?p/LLoN1+cFT+jDfhofehttp9TetdAGjPS409f+k7GHqAFRmlHidZZeNfytzf?=
 =?us-ascii?Q?gMcWNmPRET9xY4QxOitEv9/1/CGsV6R5qylgk+jJ+LmO0QT5ZRra7XG3SNSJ?=
 =?us-ascii?Q?ymNNMW062iJQoVtOjjQSrvDzDHP61P6kjxm33Yt8NuCa8jwK4KlfjjrwK6r7?=
 =?us-ascii?Q?++PzlmJgF7DrZxXoaPp98qu1f5IMj7ZB4I4JNT1xeLQqluPyRAVeeqZchY9h?=
 =?us-ascii?Q?DGHXIhif/xiRdBTaYHGAcqkGAavtwfh0yCFNCUSbmPwjK5t4U7y2/e9wg9Ne?=
 =?us-ascii?Q?N29x36cYKWfZDi9WzlK1HDYSihv6hKhiarmPeo4HueRyYQ212Z78xyP3SuFj?=
 =?us-ascii?Q?9owbc3CQpxz3NV7tKsIc1nSKjPjvJD37+qHMEIz376JA65gP1UKa+xNIUdAL?=
 =?us-ascii?Q?myr8NqAhq6BXPnq3HhSGncB9BEfdSujOzlgKIT+6Vyux2hNWhzkCSuJVXGa/?=
 =?us-ascii?Q?t0AVTjh7m3Gv45JUCzUU1TLWCpM8LwEYIEZdp39Im9UrG1PIz+YCXZDNrNW0?=
 =?us-ascii?Q?nzSW1NRa4EwDS5hetXv1P9xlmM66hl46YMZpydiEhtQc0KMJ+mcwPoLV2kom?=
 =?us-ascii?Q?iC1AYwVDF7oWJ7MXa1k4zAH4UrvhzBjUFyZ1Ih58lkxFn0pkv+4cV1Dbo61c?=
 =?us-ascii?Q?s/vn9TKZvibHo2KPdkpUek2bTmCHk2Low3OAFN68Dw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WviFvjN8gyP6UnuE47gzF5xnumlCSsfnjfRKoBr1vf3TsUSFgw0+pvx4vdQS?=
 =?us-ascii?Q?dESsGZtb3GmYgS0M3dhwjnhbykNNXbrWzHAy2ogmlJWvd6bFbBoMVxKzc3j8?=
 =?us-ascii?Q?eiui9J3LBiecsFtDChem3B0SMr4eBxORACkIbsDPiT8yjiVfYpNrSQs0chmH?=
 =?us-ascii?Q?r2FyYF/fglkXFKBNdKngngAUgQcUJWgVhUC5jViWAx627YE3DIjarZXAGvXp?=
 =?us-ascii?Q?jnw35sLe47KJtgGlJ0oDqUIlOOsDiY9jo4Jg5mxopMbdqOzd+/MtyokeGKFI?=
 =?us-ascii?Q?232xjrIhCziUWfNd9COzKrojnIo2OZ1PhyMZNGxS2qzHXzwC7etcSJYqQ3j8?=
 =?us-ascii?Q?wESf2Tw9/uL3aoBGaHNXt7zHnaxFWsaxvkWgPOmPthbm0+Kef7u0OjCS0WeS?=
 =?us-ascii?Q?lALOFumKQx0B4/eGmTW0eiTHKWmF/0oo5+R43jqn2iJwZwri/xk1Vig2lPMh?=
 =?us-ascii?Q?lFFUmDVH89BemDn65hxvPVW4ZwXykbuWeCWIXAXUEUPgmj+YL6Vt3QD/sa8W?=
 =?us-ascii?Q?7thqHz42aOTEisX7zH+GcRAPj1vFFua5FhFPGXlUc6ruevvZjMW01aeCq4hr?=
 =?us-ascii?Q?i2gpuBSdyzc23mSW+mpbSRO6MHBJEwBgYQ/o2wfVQfoZkPEUf5Xsax2TLEJP?=
 =?us-ascii?Q?vMrDpko/dm3OYMTyLViKxCHD5PkXLxlbNWGfFc5lpQzXEorws2N+449ITtPJ?=
 =?us-ascii?Q?MQpDpchEC7PBsODcF90HPcnXbiBDh9qWmUFRbASN1qNpcD9bH+DIKhHye4Kl?=
 =?us-ascii?Q?pYFLGZ+yBQgjHaM7ThHDUpH6vc9qgSlNkOeIsdBUhVylaWsDIARxI+lPUizZ?=
 =?us-ascii?Q?pP1PvXCFsOcnoAsLfXQ2XwuOUTSaVOIRo6/sXfZ5sXb7BWJQn3N+04jHFEWG?=
 =?us-ascii?Q?Db/bzoFRj7zKyyuWG84ZhzhIFntDIo3Pa5lhPuduCArsI6/Njl98nxfAbPJx?=
 =?us-ascii?Q?kGUSKHac9Yav/npLtpitRIp46hWH6BOlH3aAlPl31a7Kd6c1iqDMLJ769NmW?=
 =?us-ascii?Q?9rkUHGiKK77mWaKLg9dQ+7Tm5+9nNNHckO7hOW9iCTLpLJkPTgzUwIDcys2H?=
 =?us-ascii?Q?NkELD+4Ly6Qe/ji5VrFkrl/QW3I4xbhmxitpkt30408OO5KySPWHqT9vJrQt?=
 =?us-ascii?Q?Wp4XLzPygKdiRYvNkcEmukBxHolKPb1EQXXXx47t0fIulEASPO6KTEhDVl1A?=
 =?us-ascii?Q?xxa3dg6VTsCVM8sBHHOTK2+FhmXUz4aBzv9cH5odWBwWp2MT+rDLuFAv7d4x?=
 =?us-ascii?Q?Mcz3Ho+elxefBcsOByuWXyrRIB+LjPFIkAUtyJeCYgDfkdmKeMbCcqyr7jIW?=
 =?us-ascii?Q?u3xiQzV4/Tz1uSQlVG0BAvRSekw7TsH5wMvO41yQmr728vXHYgN7LRlYdfaE?=
 =?us-ascii?Q?ScBjrmie1Lb2DDmtvIn2gP1TaKUkjp6F/xLY4+tSLcAHj+n0SfcKrj7sqpC0?=
 =?us-ascii?Q?jRJ0a8dd7tMPT9fmX7diFSUPEjXMCwhtBm/en6jfgrkIUhAWoaXrFZOssWjW?=
 =?us-ascii?Q?uKniEpN8zt7UjaOJqaZFzWhS94sQ5lMGEEz7pJsJzpBStrVHInhRfWHwBPtq?=
 =?us-ascii?Q?KvH0i1hM5SiX3loVd+H4SRH4NibYtl7RvkBvzVKy?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	VCM/Qz6PMZX6o7fbTKWKwtldib7opQvFtjnmBIt6ANE64V1i/UX08fmdE3UT6P6eFh1xLpbTyZFxlLuxvMnloXyNw8uBKiVz1nrYoSkKQ5tNusJ2MEjuMtXghYs0I9rwjBq3ldS2kGfIBDI7zaEFBt4jbtDezjI59UVKLsI7enkd+G/mmdb4CXSNIsJQyzrQ71alsmvNuy3E9RgiZtDqSUvUQKMJhCGehVCc+nUwKUuRVrelJmzunFwNj402L7WnSX2ymUdH6LEyHHNQ0XcsnjNZ22eflWQkbs6J1PGE82Dp6lb/tscSfAuB9fVM3i+V7CV4uk2al/OQDP/OZNuPiDgnjqm9hpbL5uNxNgW3uDzA9UqYzGJyxtJ+44i7DCUoSz0Uq8UbfVXSISuW7zQ6aY/cogwLSmpaJDik7XDbTI2IOEs/xQdus+yTkoqsrnqYfaElz6/ZDpDQGUPVXPl4+aDcJLh3Jru/hoK7ei/paPHdMtn4TxeTowyjWdUSgltVpc6ynbmjPR57vsoH9KyKVNr3zQU2DQLsryM/55NeI6RlFDVOWsbtkFl1Zvsb3r4KoXNDPeCa4AERc2qZbdpvXgmPMNXyQoMIV4jp7I9FI3E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f912a3e1-e82b-4d57-4a96-08dce8795e84
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 15:45:15.5510
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sBKyH7/0EL/nFJ3q9RiTbdffoCFB2ZgcKhcnWXreiofBcWYCoY8C4NybbrenltaC8yzGeON6U9Ghi+HDrDvrnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6812
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-09_14,2024-10-09_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 mlxscore=0 suspectscore=0 bulkscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410090098
X-Proofpoint-GUID: i-m666umYa1Zl9vOdlgGzjK-TUmw8qff
X-Proofpoint-ORIG-GUID: i-m666umYa1Zl9vOdlgGzjK-TUmw8qff

On Tue, Oct 08, 2024 at 06:10:44PM -0400, NeilBrown wrote:
> On Wed, 09 Oct 2024, cel@kernel.org wrote:
> > From: Chuck Lever <chuck.lever@oracle.com>
> > 
> > We've found that there are cases where a transport disconnection
> > results in the loss of callback RPCs. NFS servers typically do not
> > retransmit callback operations after a disconnect.
> > 
> > This can be a problem for the Linux NFS client's current
> > implementation of asynchronous COPY, which waits indefinitely for a
> > CB_OFFLOAD callback. If a transport disconnect occurs while an async
> > COPY is running, there's a good chance the client will never get the
> > completing CB_OFFLOAD.
> > 
> > Fix this by implementing the OFFLOAD_STATUS operation so that the
> > Linux NFS client can probe the NFS server if it doesn't see a
> > CB_OFFLOAD in a reasonable amount of time.
> > 
> > This patch implements a simplistic check. As future work, the client
> > might also be able to detect whether there is no forward progress on
> > the request asynchronous COPY operation, and CANCEL it.
> > 
> > Suggested-by: Olga Kornievskaia <kolga@netapp.com>
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=218735
> > Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> > ---
> >  fs/nfs/nfs42proc.c | 56 ++++++++++++++++++++++++++++++++++++++++------
> >  1 file changed, 49 insertions(+), 7 deletions(-)
> > 
> > diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
> > index 175330843558..fc4f64750dc5 100644
> > --- a/fs/nfs/nfs42proc.c
> > +++ b/fs/nfs/nfs42proc.c
> > @@ -175,6 +175,11 @@ int nfs42_proc_deallocate(struct file *filep, loff_t offset, loff_t len)
> >  	return err;
> >  }
> >  
> > +/* Wait this long before checking progress on a COPY operation */
> > +enum {
> > +	NFS42_COPY_TIMEOUT	= 3 * HZ,
> > +};
> > +
> >  static int handle_async_copy(struct nfs42_copy_res *res,
> >  			     struct nfs_server *dst_server,
> >  			     struct nfs_server *src_server,
> > @@ -184,9 +189,10 @@ static int handle_async_copy(struct nfs42_copy_res *res,
> >  			     bool *restart)
> >  {
> >  	struct nfs4_copy_state *copy, *tmp_copy = NULL, *iter;
> > -	int status = NFS4_OK;
> >  	struct nfs_open_context *dst_ctx = nfs_file_open_context(dst);
> >  	struct nfs_open_context *src_ctx = nfs_file_open_context(src);
> > +	int status = NFS4_OK;
> > +	u64 copied;
> >  
> >  	copy = kzalloc(sizeof(struct nfs4_copy_state), GFP_KERNEL);
> >  	if (!copy)
> > @@ -224,7 +230,9 @@ static int handle_async_copy(struct nfs42_copy_res *res,
> >  		spin_unlock(&src_server->nfs_client->cl_lock);
> >  	}
> >  
> > -	status = wait_for_completion_interruptible(&copy->completion);
> > +wait:
> > +	status = wait_for_completion_interruptible_timeout(&copy->completion,
> > +							   NFS42_COPY_TIMEOUT);
> >  	spin_lock(&dst_server->nfs_client->cl_lock);
> >  	list_del_init(&copy->copies);
> >  	spin_unlock(&dst_server->nfs_client->cl_lock);
> > @@ -233,15 +241,21 @@ static int handle_async_copy(struct nfs42_copy_res *res,
> >  		list_del_init(&copy->src_copies);
> >  		spin_unlock(&src_server->nfs_client->cl_lock);
> >  	}
> > -	if (status == -ERESTARTSYS) {
> > -		goto out_cancel;
> > -	} else if (copy->flags || copy->error == NFS4ERR_PARTNER_NO_AUTH) {
> > -		status = -EAGAIN;
> > -		*restart = true;
> > +	switch (status) {
> > +	case 0:
> > +		goto timeout;
> > +	case -ERESTARTSYS:
> >  		goto out_cancel;
> > +	default:
> > +		if (copy->flags || copy->error == NFS4ERR_PARTNER_NO_AUTH) {
> > +			status = -EAGAIN;
> > +			*restart = true;
> > +			goto out_cancel;
> > +		}
> >  	}
> >  out:
> >  	res->write_res.count = copy->count;
> > +	/* Copy out the updated write verifier provided by CB_OFFLOAD. */
> >  	memcpy(&res->write_res.verifier, &copy->verf, sizeof(copy->verf));
> >  	status = -copy->error;
> >  
> > @@ -253,6 +267,34 @@ static int handle_async_copy(struct nfs42_copy_res *res,
> >  	if (!nfs42_files_from_same_server(src, dst))
> >  		nfs42_do_offload_cancel_async(src, src_stateid);
> >  	goto out_free;
> > +timeout:
> > +	status = nfs42_proc_offload_status(src, &copy->stateid, &copied);
> > +	switch (status) {
> > +	case 0:
> > +	case -EREMOTEIO:
> > +		/* The server recognized the copy stateid, so it hasn't
> > +		 * rebooted. Don't overwrite the verifier returned in the
> > +		 * COPY result. */
> > +		res->write_res.count = copied;
> > +		goto out_free;
> > +	case -EINPROGRESS:
> > +		goto wait;
> > +	case -EBADF:
> > +		/* Server did not recognize the copy stateid. It has
> > +		 * probably restarted and lost the plot. State recovery
> > +		 * might redrive the COPY from the beginning, in this
> > +		 * case? */
> > +		res->write_res.count = 0;
> > +		status = -EREMOTEIO;
> > +		break;
> > +	case -EOPNOTSUPP:
> > +		/* RFC 7862 REQUIREs server to support OFFLOAD_STATUS when
> > +		 * it has signed up for an async COPY, so server is not
> > +		 * spec-compliant. */
> > +		res->write_res.count = 0;
> > +		status = -EREMOTEIO;
> 
> Should -ERESTARTSYS be handled here?

The "default" is to "goto out;" handle_async_copy() will return
-ERESTARTSYS in that case. What more should be done?


> NeilBrown
> 
> 
> > +	}
> > +	goto out;
> >  }
> >  
> >  static int process_copy_commit(struct file *dst, loff_t pos_dst,
> > -- 
> > 2.46.2
> > 
> > 
> > 
> 

-- 
Chuck Lever

