Return-Path: <linux-nfs+bounces-8304-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20FA29E08EA
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Dec 2024 17:45:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA83A16A246
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Dec 2024 16:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E32519E7FA;
	Mon,  2 Dec 2024 16:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VLSktX6K";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="u03y+5xa"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26CA175D26;
	Mon,  2 Dec 2024 16:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733157133; cv=fail; b=AmZntZXqS5dcyMGRoS1We9qOSi3sVxZfcL0NIzd+SUzdlCxDffm+hgvycx2vGk3c7PPnldTL1sMsKbCj5eXeM/NwCZfE8Yoh86Eth1aBvOO3On1vAYHpEx3/B0NnM/jc8+GlZf22ofZo3zPYMTiTmran6+7oaxBQ6Y6PE3u0Umg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733157133; c=relaxed/simple;
	bh=vS2QdzwZ8w5ZO9ttVvR1m2/pkvEVFoBqSVaKiqtfJZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=P36Gtr9+4FB7BOABJi43CrWhNRqLfH+JwZSomL8ziVO0g4stoG1Z9llZYzjfkTlmoPKgmjYv0ZobxOCSMi4Yk6t7BS90jS9hdiTJ51BZQDbtD56xd3PHsT05N5p7NEkfUBXZu0hY4ENfB4Zqym8mJNlcQU+Y/MpCAF+VMTahpvg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VLSktX6K; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=u03y+5xa; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B2DXsEP012929;
	Mon, 2 Dec 2024 16:26:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=21gwjTxfxMdFA+1MApuC/kCu/GzDIl8KhZIF7GSjxH8=; b=
	VLSktX6KP7GdYI+t9H16suNdFGChUn1P3lrzthbYFviGe+QRa0UudAQEINtvVj3l
	IINn2SuXvS90IK3K0HWF7J1A06HYW/QhPjct8PBpB54DaSj+SnPGDYKNIywdsG4J
	rvGw0o8omXVXNSMX41IANYEihnAhLE/d4a9hbrXSY+yxtrNFKvN+JSo/b1AwLDbi
	x1uYhlf240CwFq8Rh8qGPcPSZ/6Zcad273B4Fyb+QqawtJGiNAhb9AMeKSwjNPwj
	sGOiTvsezLgPIqVuwJ1Tw1xnWMkKp4lewZiUsM38JZJd/x/JHNvgMuktDWgz6qZZ
	LxHWX8h4Imw83p8EET8yOA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 437s4c3x29-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 02 Dec 2024 16:26:29 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4B2F71n1037068;
	Mon, 2 Dec 2024 16:26:28 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2169.outbound.protection.outlook.com [104.47.73.169])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 437s574swq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 02 Dec 2024 16:26:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oThhgPbJw6Glzu573V8VnyMvRAlCQmfzPOqiWFf1J+10gLZwvMxiK/M/dRncj+txaO5b074cB28Fni7qFB+VNuHkLgvsMSFf+QiqB4r/Jz+JhDNhIK+WYBngWxl+HAV7vBaEK8Yud5NZVxDKwjHzEBMVyqKlK1hLZ4YunQB9Eexjvijl8ZSjE6FGF2PiW02vn/fgXE47GtkFam7c8b5yzoHBsEfnF3KXIVduaPYSAf+Q8ShteRwrgH37sHODuYgGH3wCtsLRHSIQ7KXbnd8cljVQJmd0q2Udn4p4CRryZl+XJB73CP9XqTLilMw+AQzIhYiRyb8S/QeA4SlBTlaB/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=21gwjTxfxMdFA+1MApuC/kCu/GzDIl8KhZIF7GSjxH8=;
 b=yAeAZLtcqvs1Je7shT0NDjq/lf3zIfc3J8fzzZYgoCJfmhi7FrV7El0eUJgiaN3SvYdgImV6KzjqsuAUJkx+hf/H3e/zD0tQ/Nqh2SEhSzuEL7MMKgnoUKCM4l9l0PnyfguM1kthC6q6AltCp43Qh68RhO2Z7+S4OhjVxkHTKs8O3EQd4UBqB7gxiheCfSXyxwwAeTrQhzoiFxoBpD1WPNg4Lb8oFR+nnf+v1OvniDvYPD5geT5psYQCDySsxJKLWUIpwcPBaOF6jV7bKDf1YrnY8frj2NBMrMdLYHmWVH/u/uCiBgI82UHOMxxWNpULv6VOgndwGp2qI54IgffspA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=21gwjTxfxMdFA+1MApuC/kCu/GzDIl8KhZIF7GSjxH8=;
 b=u03y+5xaEALowA5FEIWToTiEK70HRL+/3Bn0M33RFeHneJ2XsoS52c31s9pSAHDkSTjJcP95AyvpVsBekNoAH6Wga2v0R84BsM4R++YlldvFysGL4qw7aEe5CalLlFO5Y/SGIAal5Vx4ESSTkCsl+VkF4EQunJikVYSbdxxvLgU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Mon, 2 Dec
 2024 16:26:18 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%7]) with mapi id 15.20.8207.017; Mon, 2 Dec 2024
 16:26:17 +0000
Date: Mon, 2 Dec 2024 11:26:14 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: lilingfeng@huaweicloud.com
Cc: "zhangjian (CG)" <zhangjian496@huawei.com>,
        Li Lingfeng <lilingfeng@huaweicloud.com>, jlayton@kernel.org,
        neilb@suse.de, okorniev@redhat.com, kolga@netapp.com,
        Dai.Ngo@oracle.com, tom@talpey.com, Trond.Myklebust@netapp.com,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai1@huaweicloud.com, houtao1@huawei.com, yi.zhang@huawei.com,
        yangerkun@huawei.com, lilingfeng3@huawei.com
Subject: Re: [PATCH] nfsd: set acl_access/acl_default after getting successful
Message-ID: <Z03fpnNYHjuKox0E@tissot.1015granger.net>
References: <20241107014705.2509463-1-lilingfeng@huaweicloud.com>
 <93fd0f1c-812f-4393-ad73-4d07ecebf979@huawei.com>
 <CAM5tNy4rYLWSuO_KrgXJrHV+DPhOoZGZAdWLZsW35u3qWuMSvg@mail.gmail.com>
 <CAM5tNy4QXM8bhcfTtrKt+ogWPPOKe5g06j1sgFm5z8=BKP-4vw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM5tNy4QXM8bhcfTtrKt+ogWPPOKe5g06j1sgFm5z8=BKP-4vw@mail.gmail.com>
X-ClientProxiedBy: CH0PR04CA0035.namprd04.prod.outlook.com
 (2603:10b6:610:77::10) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|BY5PR10MB4196:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e9b47eb-fccf-46e3-15e9-08dd12ee0c7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RUNrSStOZ29TL2drVm94VzBEMUhrV1ZKWHVDWTEwSjVWOHhrRGRKaThEbUZk?=
 =?utf-8?B?a0pzQ0l0a2MzcDh4UjIvVDcza2lQanNlcllNY0RadzZjWVVNaGNseUlPQmI4?=
 =?utf-8?B?Y0ZSREdOREptSUIzaXJkdHNoNmxtYkZic29PNkNqT3cwblhlV0VpaXkwOUtU?=
 =?utf-8?B?YTNMWjRiai9wYXZTY0cvckNYZDkxVnIydWQxQkFWT282bGFoU08xR1czTURx?=
 =?utf-8?B?WGp0b2JBSCtNMVZKQkRJRHJxWDUvL1B6c04wQVNobUkrb0JuNk1oREgrQ1Mx?=
 =?utf-8?B?MmdOV2JhNmQycVNtYWhVUWxPL0VzSjZ4TWVaU2JXMm1lUWN4aFRRMDFjdllW?=
 =?utf-8?B?aVJ3dDg0R3NEUW1jWTR6ZjUzMnVNYjJoK1ZnYUFRbHJZc3lJY0YvUVhFYVM2?=
 =?utf-8?B?U2hmVDBvMFB1Tnh1MUlhclROeWpEanVaWGJ6ZGsxeHZUWnRzWTRnZ0h2bys2?=
 =?utf-8?B?OEIwYkxqbjk4eXNnajcwdGNXd0tsa3JsWmZUNWlXMmQ5MGYxS2luUldFTGdX?=
 =?utf-8?B?OWdMODloMXFBUWJCWnM2QjQvcXlkMytHcDVyMTBWUGdNVGtZdFRpQi9peDhv?=
 =?utf-8?B?NnpDL0VUUTJ3K1dQTkNacCtpUXYxeVBzcVhjVnF2S2NsTTNJU2ZQZWNtNWhD?=
 =?utf-8?B?ZmJOem5yTXlxcTUvclJUanp3dkRtWnI4K0Q2QWhYbGJ1WXZrTzlYUkkySVF6?=
 =?utf-8?B?cUlKeEJvR3lUSnF0VTFrZzRrRmR5ODBybUUrMm5wWlJudWt0WlVuK2NYTjVB?=
 =?utf-8?B?bjAzN0NMem9FNCsrRUhKVHlaZ0ZQWU1xN1BnM1NNQkdYVUZEZlVucHhsbm5v?=
 =?utf-8?B?NVJQU3lLa2ZwN3Jma3IvdEtTY1dzTUp2eTU5dm5uOVlTUU1NY1ErVERSblFU?=
 =?utf-8?B?ZWltOWsvdjc2UXQxZjNkUFo5TUwxMWVycG1lNjZiVHFmaVU4YUtGckFhZHMw?=
 =?utf-8?B?NURmM3VVY3kyRjhEd3JEaWxUWkhYMHNES1hscmY4dGpWSjlteGRPcUlJbmRa?=
 =?utf-8?B?V01HL3g4UjRZZmtXRWJ1YngwMVc0NzdSUGhxeDZ6TEVQeEk4eXNWQ0dOTzhF?=
 =?utf-8?B?K0E3WVdkcStrWndObGo2ZStrY0hHbzV3NzhFSHExMjFYYVFlTEdvdTVtSkxU?=
 =?utf-8?B?MUlHblN5NVlBenBNTWZ5dnZMcmJxTDRWQXNOZkt6VjA5T0M1S3JTOEw5MlFW?=
 =?utf-8?B?VWh0MngzbHp1T3N0d2c5ZkVsTmp4MElXL0w4WmdBakRvK0diS0hRK1FsRGdY?=
 =?utf-8?B?K0FzQWN4SkV4YUdXMXBPSi81S3RUaEZkU0J3TGlTTngxRkNWK1RZcTVDcHJ3?=
 =?utf-8?B?bFRZblBEcGp5WGZtVFBGdFFLMnNsSGhwc0NQMG5hblpyUXZqYk9VSTUwbGhi?=
 =?utf-8?B?bk5ZZUlsNnh5d3hNVXlPczMxQ0xaU3M4L1ZMSVRGdnQySVhLSkRyaEYrRlhG?=
 =?utf-8?B?WkdKTDdueHdsM29Bc2tWUC9CUXhVbWRTU2NFaG5JL05MWjhiQ0F6ZEFWekVa?=
 =?utf-8?B?ZU5MM25FeFAzRzhqWVBRVEZ1Z1cvY2JWbHJrV291RzArcWMycisxWWN2SG53?=
 =?utf-8?B?QVpsTTg3SDFzVnZmSE53cis0VTY5VnIxKzhTYzFTbE1Vd2lYMmlMZVM3V0VY?=
 =?utf-8?B?SWxPM3RjcjVtUEpLZHZNVGY5REtZSGtpd20xL1RuSG5uRzZjMnp3ZUQ3djUr?=
 =?utf-8?B?MG1MbDVTVEFJaTVwcGJnUEJtWWlpOGJKME5SclVOL3BzWkFwVnlKa290ZzJN?=
 =?utf-8?B?MFMwUlA5WXV4UUh3eXdtdExaNjErbEtzQTlOcmJsK1QvN3pYY1NBcU1kWlBr?=
 =?utf-8?B?MnpXWWhKUlQyM2cxdUtJUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q3RjRkdTcXVEQndvZ0V0ZGFkUkNSVFljSXpYMzhsRkQxRmtxZ1JUandwb0ZX?=
 =?utf-8?B?QUFHS1R5U0NaUVViSjdGb3lZNlNnQjNoVyt6eFZoRFF4WEN3a1diV1RHRmhK?=
 =?utf-8?B?T0N1dkN3ekJCR0NNNUpqeUNvVU5mZEZKK0dubHBOWUFFQ2F0S1BnZFhXakFi?=
 =?utf-8?B?TVhnb3oxK0pIVmVKMEY0a0NpeGp0amx2QUpBamQ0eW5wQTFVa25kYmRrMXpa?=
 =?utf-8?B?T0Q4TTBJZllwWTJwUERPLzVPREJOZWlJRHM3Z3RtL0VzZUlkQUg0S1VKTkR2?=
 =?utf-8?B?OHF4S2dBNWI5RTcyelpLcG5pbjRtSndwVnZtZ0xZNk5rdTF0MzJjemlqVHh5?=
 =?utf-8?B?cmozcXo1QVlQeWhTenQ4bWJrWVpNc3M0UjkreHBCQ0ZlWnZqZ3h1cGNXN1hR?=
 =?utf-8?B?Rzh1enJWM25qcGN0RzBtVXJyYVJEVFpzNEQzMmh2TXdSWVZzdHlaUklWbVUy?=
 =?utf-8?B?YnpseGNDUG5zV1NRbGpDdW9KVHpOQjRrZlBEa1IwbzNsY0U2YnpyS2tRa3ls?=
 =?utf-8?B?VFdrazdJdmdGNEYyZkFaaTI4eFp4VkR1Q05PbnJOY3VwckljSWluRnl0T1di?=
 =?utf-8?B?anBwZG52WlREWTBmNUVGa0R5OURUMUwrSjVwWnNxU2svNjNmTlJYc0RuLzZv?=
 =?utf-8?B?YTJrSWxqWHJyRWFNVHRlN0NmQVZqbFJjaGozeXFpbXdNNEFhdWNLYnViMEhs?=
 =?utf-8?B?WTl6WUV1Y1R2ZHpZd3F6akx3dnBFTUNnKzhkaHMwcjFNY0ZCUEEwTUxab1FV?=
 =?utf-8?B?WUN2eE92NExqc0tFdnJER1VpY0VLUmZ5blZJQXg1TVd5bWRKT1EySmNEOUJV?=
 =?utf-8?B?aVpEeWdFRWVQbFJxY3phU3c0L3lxdTBhRzcySmIybUFVS2lITytWa1ZoNFpn?=
 =?utf-8?B?RXREV3g2TkswSHpVVWgrTXpDN1JOc0NIOG5nT0VMN3Q2amphWGdJUlgwVWw1?=
 =?utf-8?B?elBlcDEyWFNkZ0NoZ0dXVmRkTCtNcWpPQitVZXV5WGtCcDd5ZFpvekx4L0hi?=
 =?utf-8?B?WlRYT1pBT1ZscHdCaFBXSjkzNEdkZFJuT0lUU1R4dlJoRnVXWlV2NW9BTUVS?=
 =?utf-8?B?NnFIbkhiSkNuY3NIc3dkSG9iNGZna0RaNHhydGtNZ1Z4MC9WNTFqZmFvcmYz?=
 =?utf-8?B?V2xnT2prMnE4aFhydUNXQ1FWU0Mwc3V2RWJ4Zktsc01BZE9pdTlna2VWSDlh?=
 =?utf-8?B?c3NXK3dVMlZnZ3YzeHRYbmZGTzVjbjhCYXVGNmVubnRJMmsxR1h6Qk1CRVFm?=
 =?utf-8?B?eHJPMFVWRmlUcDJJR29Ia3RXL09XaittbWo2OXFDTDViNEprcE9ibEZjRFlC?=
 =?utf-8?B?MFJBeEh1L3JhY3owcHoyRXVCY1ByUFloeDFsM1RYSzlCU2RmTTlVNjVWZUhV?=
 =?utf-8?B?RUhJVyt4RkpMTFhESUt1cUJZUW03K1FYU0t2VEdmeXZrbVR4bjZQT2NaY3RY?=
 =?utf-8?B?WjJmSlJxVGVqV0pOYnlyT3BXWXR5cE9MOHJEWFJjQmVqZStBMkZFNlIrWjdD?=
 =?utf-8?B?czg2WFFsZGVyNms0U0R0M2QwZUhoTWQwdUROSlhkZEFYbjBTRHd3eHdNSkJU?=
 =?utf-8?B?WFdxRmNReEI1M2FHekQ1V2JOQTBuRlNhclVBU2ZpajJoUzAxc0tiK0t0VThz?=
 =?utf-8?B?UEJWSDZjUnRlZnY1anVEVURNRENMQitNMi80Q01iMTMyekJRZVc2SHdCbUF2?=
 =?utf-8?B?UFl6bUc0b0NONW94ZVQ4SlFLWnpsOUh5cUpMOEQ4cjRGMktzUWZsOS9hY1J5?=
 =?utf-8?B?VjloWG9nSlhSckRyc2lTTmZFZ2VSdjhwSVE2b2NwZTJ5SEdCaHI0WkN0allk?=
 =?utf-8?B?MVREOUNXVmttQ0g2bUNQQlZsRGIrblRNUDJ3ZzQ5cFdUSTVjVHBrTHBxVjFI?=
 =?utf-8?B?RWJzV0ZWYzVWd0pPOHNtUk5qSjkrL25LdWJkQ25Rb2JhTTY0ME9wVEpOQTNW?=
 =?utf-8?B?ZHB0M1VFTkVIVk1LZ0lOSGlIRFU1b3J5Rk93NGk1bzkzd3lETFg5MlJuWVhN?=
 =?utf-8?B?MUgxdExmR05ENVQxN2RTb3ppWnFyaHdyUFNBUkhuKzJENWdWNWtBMTA4bmly?=
 =?utf-8?B?ME8yMllQZW1sc3VhZ29XVGpYNTRqcFQxNlRQVi9xSVNtYkQrWlJrUld5Q0RU?=
 =?utf-8?B?SDJjQXBZV0xjTXZoY2lPRm9VQ2lid2FRREMrQU1rVHNac2hORXBvM0tjMjhW?=
 =?utf-8?B?aWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+/Sl1zsL7qG6Ez/iM6AbLOWqCbiRrSjhnLAJxps/lP0hMmtl/zOpzuRTJ1toj/77kITWyYljKE+LF5SJfM9gQr28r3dioEGFE9IUFai8fKK4SNcf7gM2RH3Seps8cdICy/DTMsUC9f/W/3ShotR0fDjPl0HquhlWFqL1CYRf0uEwRkVdEKG5FuEU6ZrfPSrz2/VJfnV9BCGPSJS329N22UKHT+h+kr3t4PjakMnU9irZwX25Y7CRz8/m+c3Qg4aDchAZc730LrHiC4Hog9Vu7kKgGaypl7fPJDFeUzKhOjfndgmpxqoSVf8FtAPfaFcO8xEKpJn349Qfs4ezViw0Fj2a07GXumr+JA1kMoDX8N7RcG1qBwSCsMAhCGyCER/NzkJA3lJv+F/YQT1bg/HIkwyEu6EXbtD07rByUo5tSNJWrtA+6sQ+x0Qa/01/DIE5L/xJm3OKak8h2DnMwO4taQ3cvbkJ8MQya3zl62YHgQraZNrdrQks8RfxxCfsb0Ca4epCgtqTwUr3IrG8OxvuwTp8D44PBukyWJsKQ8JRUy2XFU6GQ5W4mfvR6rlTx2ADQq+CdhNcpZpPzxhC7mIJvfdGrsc6rj2PXoq79qRX354=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e9b47eb-fccf-46e3-15e9-08dd12ee0c7b
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 16:26:17.8652
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SEAhQ6/6l9DFDk4c3IP/KLknVEJauWh1V49RlCbvNRbxJypTJ6wrOwnRdfI8nenRPjpS5PYZHUZzFd2zIjOczQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4196
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-02_12,2024-12-02_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412020140
X-Proofpoint-ORIG-GUID: -iUdKUSjtWjtph_FbwkOiymR4IoxNxRf
X-Proofpoint-GUID: -iUdKUSjtWjtph_FbwkOiymR4IoxNxRf

On Wed, Nov 27, 2024 at 07:37:42PM -0800, Rick Macklem wrote:
> On Wed, Nov 27, 2024 at 7:14 PM Rick Macklem <rick.macklem@gmail.com> wrote:
> >
> > On Wed, Nov 27, 2024 at 5:18 PM zhangjian (CG) <zhangjian496@huawei.com> wrote:
> > >
> > > there is one case when disk error cause get_inode_acl(inode,
> > > ACL_TYPE_DEFAULT) return EIO,
> > > resp->acl_access will not be null. posix_acl_release(resp->acl_default)
> > > will trigger this warning.
> > >
> > >
> > > > If getting acl_default fails, acl_access and acl_default will be released
> > > > simultaneously. However, acl_access will still retain a pointer pointing
> > > > to the released posix_acl, which will trigger a WARNING in
> > > > nfs3svc_release_getacl like this:
> > > >
> > > > ------------[ cut here ]------------
> > > > refcount_t: underflow; use-after-free.
> > > > WARNING: CPU: 26 PID: 3199 at lib/refcount.c:28
> > > > refcount_warn_saturate+0xb5/0x170
> > > > Modules linked in:
> > > > CPU: 26 UID: 0 PID: 3199 Comm: nfsd Not tainted
> > > > 6.12.0-rc6-00079-g04ae226af01f-dirty #8
> > > > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> > > > 1.16.1-2.fc37 04/01/2014
> > > > RIP: 0010:refcount_warn_saturate+0xb5/0x170
> > > > Code: cc cc 0f b6 1d b3 20 a5 03 80 fb 01 0f 87 65 48 d8 00 83 e3 01 75
> > > > e4 48 c7 c7 c0 3b 9b 85 c6 05 97 20 a5 03 01 e8 fb 3e 30 ff <0f> 0b eb
> > > > cd 0f b6 1d 8a3
> > > > RSP: 0018:ffffc90008637cd8 EFLAGS: 00010282
> > > > RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff83904fde
> > > > RDX: dffffc0000000000 RSI: 0000000000000008 RDI: ffff88871ed36380
> > > > RBP: ffff888158beeb40 R08: 0000000000000001 R09: fffff520010c6f56
> > > > R10: ffffc90008637ab7 R11: 0000000000000001 R12: 0000000000000001
> > > > R13: ffff888140e77400 R14: ffff888140e77408 R15: ffffffff858b42c0
> > > > FS:  0000000000000000(0000) GS:ffff88871ed00000(0000)
> > > > knlGS:0000000000000000
> > > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > CR2: 0000562384d32158 CR3: 000000055cc6a000 CR4: 00000000000006f0
> > > > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > > > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > > > Call Trace:
> > > >   <TASK>
> > > >   ? refcount_warn_saturate+0xb5/0x170
> > > >   ? __warn+0xa5/0x140
> > > >   ? refcount_warn_saturate+0xb5/0x170
> > > >   ? report_bug+0x1b1/0x1e0
> > > >   ? handle_bug+0x53/0xa0
> > > >   ? exc_invalid_op+0x17/0x40
> > > >   ? asm_exc_invalid_op+0x1a/0x20
> > > >   ? tick_nohz_tick_stopped+0x1e/0x40
> > > >   ? refcount_warn_saturate+0xb5/0x170
> > > >   ? refcount_warn_saturate+0xb5/0x170
> > > >   nfs3svc_release_getacl+0xc9/0xe0
> > > >   svc_process_common+0x5db/0xb60
> > > >   ? __pfx_svc_process_common+0x10/0x10
> > > >   ? __rcu_read_unlock+0x69/0xa0
> > > >   ? __pfx_nfsd_dispatch+0x10/0x10
> > > >   ? svc_xprt_received+0xa1/0x120
> > > >   ? xdr_init_decode+0x11d/0x190
> > > >   svc_process+0x2a7/0x330
> > > >   svc_handle_xprt+0x69d/0x940
> > > >   svc_recv+0x180/0x2d0
> > > >   nfsd+0x168/0x200
> > > >   ? __pfx_nfsd+0x10/0x10
> > > >   kthread+0x1a2/0x1e0
> > > >   ? kthread+0xf4/0x1e0
> > > >   ? __pfx_kthread+0x10/0x10
> > > >   ret_from_fork+0x34/0x60
> > > >   ? __pfx_kthread+0x10/0x10
> > > >   ret_from_fork_asm+0x1a/0x30
> > > >   </TASK>
> > > > Kernel panic - not syncing: kernel: panic_on_warn set ...
> > > >
> > > > Clear acl_access/acl_default first and set both of them only when both
> > > > ACLs are successfully obtained.
> > > >
> > > > Fixes: a257cdd0e217 ("[PATCH] NFSD: Add server support for NFSv3 ACLs.")
> > > > Signed-off-by: Li Lingfeng <lilingfeng@huaweicloud.com>
> > > > ---
> > > >   fs/nfsd/nfs3acl.c | 14 ++++++++------
> > > >   1 file changed, 8 insertions(+), 6 deletions(-)
> > > >
> > > > diff --git a/fs/nfsd/nfs3acl.c b/fs/nfsd/nfs3acl.c
> > > > index 5e34e98db969..17579a032a5b 100644
> > > > --- a/fs/nfsd/nfs3acl.c
> > > > +++ b/fs/nfsd/nfs3acl.c
> > > > @@ -29,10 +29,12 @@ static __be32 nfsd3_proc_getacl(struct svc_rqst *rqstp)
> > > >   {
> > > >       struct nfsd3_getaclargs *argp = rqstp->rq_argp;
> > > >       struct nfsd3_getaclres *resp = rqstp->rq_resp;
> > > > -     struct posix_acl *acl;
> > > > +     struct posix_acl *acl = NULL, *dacl = NULL;
> > > >       struct inode *inode;
> > > >       svc_fh *fh;
> > > >
> > > > +     resp->acl_access = NULL;
> > > > +     resp->acl_default = NULL;
> > (A) These two lines fix the bug, without other changes needed, I think...
> Oops, I was wrong w.r.t. this. These two lines need to be repeated after the
> posix_acl_relase() calls under "fail:".
> > > >       fh = fh_copy(&resp->fh, &argp->fh);
> > > >       resp->status = fh_verify(rqstp, &resp->fh, 0, NFSD_MAY_NOP);
> > > >       if (resp->status != nfs_ok)
> > > > @@ -56,19 +58,19 @@ static __be32 nfsd3_proc_getacl(struct svc_rqst *rqstp)
> > > >                       resp->status = nfserrno(PTR_ERR(acl));
> > > >                       goto fail;
> > > >               }
> > > > -             resp->acl_access = acl;
> > Because you deleted this line...
> > > >       }
> > > >       if (resp->mask & (NFS_DFACL|NFS_DFACLCNT)) {
> > > >               /* Check how Solaris handles requests for the Default ACL
> > > >                  of a non-directory! */
> > > > -             acl = get_inode_acl(inode, ACL_TYPE_DEFAULT);
> > > > -             if (IS_ERR(acl)) {
> > > > -                     resp->status = nfserrno(PTR_ERR(acl));
> > > > +             dacl = get_inode_acl(inode, ACL_TYPE_DEFAULT);
> > > > +             if (IS_ERR(dacl)) {
> > > > +                     resp->status = nfserrno(PTR_ERR(dacl));
> > > >                       goto fail;
> > The goto fail here will not release the access acl, if I read the code
> > correctly.
> > > >               }
> > > > -             resp->acl_default = acl;
> > > >       }
> > > >
> > > > +     resp->acl_access = acl;
> > > > +     resp->acl_default = dacl;
> > > >       /* resp->acl_{access,default} are released in nfs3svc_release_getacl. */
> > > >   out:
> > > >       return rpc_success;
> > >
> > Actually, all that is needed to fix the bug is adding the two lines
> > that initialize
> > them both NUL, I think.. I marked that change (A) above.
> Nope, I was wrong w.r.t. this part. You either need to set
>      resp->acl_access = acl;
>      resp->acl_default = dacl;
> after the posix_acl_relase() calls or switch to using the local
> acl and dacl variables for these posix_acl_release calls and stick
> with what you did above w.r.t. resp->acl_access and resp->acl_default.
> 
> Anyhow, I think the case I noted above where get_inode_acl(inode,
> ACL_TYPE_DEFAULT)
> fails will not release acl with your patch.
> 
> rick

Howdy -

This one didn't make it into v6.13 because there are some
outstanding (and ambiguous, at least to me) review comments. Can you
address the comments, update the patch, and post it again?

-- 
Chuck Lever

