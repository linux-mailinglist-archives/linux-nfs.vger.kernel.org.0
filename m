Return-Path: <linux-nfs+bounces-8155-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EB27B9D3F40
	for <lists+linux-nfs@lfdr.de>; Wed, 20 Nov 2024 16:42:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57DEAB2A9D7
	for <lists+linux-nfs@lfdr.de>; Wed, 20 Nov 2024 15:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 337B5156F39;
	Wed, 20 Nov 2024 15:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OhKiw4kB";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="GWCPjYmB"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4117F191;
	Wed, 20 Nov 2024 15:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732116159; cv=fail; b=dLBQlozEL3F3igq7xDej1fUiL0oi5fIXHGqMhnu34cebaej8RJ1xIRhfsqg0E/zatr1hEnGTy5IQF+LP+NzGdbbh5rY6OyPLcWsJ9cv0fiYG1OgCK2Saf7wSmXEidNRPPskhmBDEsxi+E53wQ1qbgA5DoejtR6q1DW35nrTWlUw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732116159; c=relaxed/simple;
	bh=DY2NQd8cVaOIsX8JaaD1vYNjZ694K8C5yf0ZacTrUu4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gHBmQVeB47Yb3RNpma18ThIzQoZ/PeZKpgkSus7fLZFgvyyPEFx92ojm4HLqBMfwH9/rrPhXq1Xv43w0g7dcpzYH0YiZhDY0B5DXIsaTzGKFkgMnG9l21OD7wCtN7ZSPLX3c0cpgGavAL+IGXMi/gwKe8bjw4BjmXY9YtULE7bM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OhKiw4kB; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=GWCPjYmB; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AKBNZlp025140;
	Wed, 20 Nov 2024 15:22:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=F7/hoWBbDidw8MZZw7
	aQrwR0PVechuOfk2SLf/6q03A=; b=OhKiw4kBzKK1VtVr7HtIT/HVlg/33EBRfm
	wpQeyZybZzsBl8FVbZykzgDi60RLSS9ubbYfOFbFCfLCKBSKqW+xf/1z71v6sLqJ
	Z8Qs1frh6WlZX7EhyS9FBOoXk7b/ONQW6WlK27JibVwEqJrQacTTf/D39Teo83QE
	MFk+a8vVN07QeYQND+9vRNsYO3uVxoGPWUkQasDZ6BCB6YqthedFA0wv28Ad5a3l
	2vGhvkgrQLV5yieQiHCDZw6lPc0aS840lwLhkJ4kMYCHtDqfECbJoaXAG4uYoFws
	8whKtR4037X1z0dO5hAMD04qYAxhfkjtlhLhtqH9JxXlaLQARvdw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42xk0sqksk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Nov 2024 15:22:29 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AKFDD01037418;
	Wed, 20 Nov 2024 15:22:28 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2176.outbound.protection.outlook.com [104.47.58.176])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42xhuaeguh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Nov 2024 15:22:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nnuMnjyyijEayoDF2mV5R3mrDxIZI+PtLYUjFqPqU2wz9ZMOK4UQkPdlvkzXptThGceGFLl8vaJdi0wZobAnkXiF9vzYAS+hO1mWXCpRVu1+o28lgl8doFZEmT2Y4Gi3YVS/fhAWPsP5CWFHnx1iSGihVOUFh++amwStI4OA+OkCQRkCubf5EcEa2bvAN4Cjt1syX+ih4OkBfRAL2pvndhEDBP+ohSGxAdIKi/A6Ij9BG2xLY5CuX9MydNxfZpfc34nVAMJn5II1m18fDQhlb4YPmZy/3H5tXyOPUAIsp3uU/OQ5XZouzkzu+ckQLvAT3CmyYkHKahGUBFQJsguRTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F7/hoWBbDidw8MZZw7aQrwR0PVechuOfk2SLf/6q03A=;
 b=JN6AGzPTZn/gPVb53xcTQKPxDxXp6PXyFUAtKVLgc47km+wA6j5omCI/Zuv8zBXtH9XlcGaWTuFkLVce4R4XTSQRA3H+bTXNLiP1yPpGJ6YssGpamvLuCImKVP4jT+sCuq8E9p3MTjckkSBprOXfAXMuaC1y2MckAPlekgO+eM0yhj0LoikvmuEUvIQlF1RIAi0vxbt+ovgdUDg+Ak2N34m+Le3SpNRutvqezLbUZr25y+cOD2+HfM8DwCgBPs5XGfGLXv3XfXdrzfIt94wlKOGMWDHhSSazZb/YcAYUm8aV2rNxhXr37arLtCxE9Wih0vsLleu+YD0dzwKYhLNhmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F7/hoWBbDidw8MZZw7aQrwR0PVechuOfk2SLf/6q03A=;
 b=GWCPjYmBxgZEcG4EE2ZtMQCiYXd+nzSh7OXpEcmd2vSFJhohlnmK45fQreVD/HpkPw8n9RC01WnP6VLuDw32bomn6ROx5V7qoz2mCugSUWIwHxlxl6OvMuehlpRygpAJkKMboW+JGEU7j7xZ8pajnGVRr98ZOefeAZt5FLInkP0=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MW4PR10MB6393.namprd10.prod.outlook.com (2603:10b6:303:1ec::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Wed, 20 Nov
 2024 15:22:25 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8158.023; Wed, 20 Nov 2024
 15:22:24 +0000
Date: Wed, 20 Nov 2024 10:22:20 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: Benjamin Coddington <bcodding@redhat.com>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 2/2] nfs/blocklayout: Limit repeat device registration on
 failure
Message-ID: <Zz3+rNnvxE2TRT0v@tissot.1015granger.net>
References: <cover.1732111502.git.bcodding@redhat.com>
 <d156fbaf743d5ec2de50a894170f3d9c7b7a146c.1732111502.git.bcodding@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d156fbaf743d5ec2de50a894170f3d9c7b7a146c.1732111502.git.bcodding@redhat.com>
X-ClientProxiedBy: CH0P221CA0017.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:11c::26) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|MW4PR10MB6393:EE_
X-MS-Office365-Filtering-Correlation-Id: bb7af130-00fc-467e-85f5-08dd09772294
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?93V9QNLacIIm4Cdw2dkFEpz7CzHgFnclYKsE5mHEft59fkvN94zUE67a+ewl?=
 =?us-ascii?Q?KNFnztaJNIa1GAOgwHC8SV6ouPDM0fh7oNG1vcRpAMqo17nKoHj/OtEDPz2l?=
 =?us-ascii?Q?2OXP2U+4rPVKfQ7/QNVxeUH2+tIw6Kdvflj870Ei0G79qsCsgZ6e0wJQz2Zl?=
 =?us-ascii?Q?A/0Xw+m83ujaaGMcmg9ogJ62+4pAaCyRdYf/bgDgY+MJOYJRR+ESbG7ZdPpz?=
 =?us-ascii?Q?Y4CF68IFcxRay8hFmHLiErlYn8xTaAObZiC5/WKiLPp0H3G77kjQ/VrrXE6S?=
 =?us-ascii?Q?7jxES5BqpcMOFQu4Rk0Iklbv58y6HwUKp+nwdbGNbX631dD5PGZw2m7eD+3c?=
 =?us-ascii?Q?1fOeU38FCaZSFdC6D6jhCGSmnyf4MNVeeRZykTPrM16Fy73UPwCLrBgo01/e?=
 =?us-ascii?Q?Flc35GKyZbtaRUL63Ar/NponAxdXkY7+dnFkqT/XHc3pSq2aYfGZq+Rd9L6S?=
 =?us-ascii?Q?kwL0HkC1zx9xqR5cshlAagB5L0ZguW+61sGdUoECVAhpnh+N55lTYaU9t/5X?=
 =?us-ascii?Q?1wkmxqNDQ5IAFMmezImmM7WDOhQNAvW15joGTTcls1hu8ulv8DJcdBJC2HvC?=
 =?us-ascii?Q?mMqN6Bb9SEi8qT9cSlgvCV4x29rI/Xijr1rtivGoo3ZcsgrjG6q12oi9xjVl?=
 =?us-ascii?Q?rT5lLRC74UM0bIUZ+b0Sug48fqVbIC+Zh/ydyRq0sKKtzoqIoBmNdeRMP3hQ?=
 =?us-ascii?Q?VPhW0DyjlXfC8WZNaqDJQEGJ9EjZT+y+roJJCwvRpJ8eD81wiqc9AYrcsj4R?=
 =?us-ascii?Q?rLDr6eBZQ/6Yw1hnZzIQPQ06qUJgZSCipPvzbYYMgVfFOjSFSacT2LSMGViE?=
 =?us-ascii?Q?YkdVQvs5E4hTMab78zFrjN4MZccTProUKtR9XpckHvubH65tuewDex8YR6i5?=
 =?us-ascii?Q?T4VAWUsG2Z6uYnZgY704RkcHjo76cy7MOCBSLVWxsQOQqD67OjdO83BWpmGS?=
 =?us-ascii?Q?4to2H331W+pz2WvwtHvB7hzgT9pb5V45F7HZ7lDZCmXaiCyGqnneqkWisvep?=
 =?us-ascii?Q?0U9UDldJloKUcOMSXZnETvKJa4laWjMImjdQ3F1qZG4DRecNtihguio+C7wH?=
 =?us-ascii?Q?jUmEkBKRKiWAzszlDuzmJnJK0XtBJoJckttEyqWftyG6r8H8DPjAT4qr+Tz4?=
 =?us-ascii?Q?jXUIPRRRju0zWoRPSw40Vg6jBvRFyAbYTpPomu/nwQITAHJy5A4GNGSvinPv?=
 =?us-ascii?Q?UY/4ezT3ja376/OwOxcZxy2sIR8JZ8gVfhhhb5e7rIt7aXWt5jlDz3AvXcoG?=
 =?us-ascii?Q?zOCUCRamk7IJTJcziWuqICE+UcYlhEsPmru+l802pgdnUIhTKUxKVTdbLmM1?=
 =?us-ascii?Q?WUU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?89BcY5oMideYJORcwJuk/1Qe29nfLQYInRKdcs95bcCkVlVOGN3aE8xGCp0v?=
 =?us-ascii?Q?1B8oFVcBMMZAp7WQCYBi/SbWl7rmjRcUQdn7F/QRpowNibxSxYY7kf4RkPiD?=
 =?us-ascii?Q?LuYVRmXgUpx2AzpuXK0kkYvg6Gdq8ccgVraJLbkdPifekIv6M+M2yNCMK+NA?=
 =?us-ascii?Q?/VsuJxOGbYjAwhnC1a6qSSvA1XCt9MF6hGWuLTlwsrsNWSo9xnsiMdz17tnK?=
 =?us-ascii?Q?3px0hB9TWnVEncTVDkYEuh/uhoaENNS9KAnjCb/xGo9ms5t386L30VB9mfNm?=
 =?us-ascii?Q?Jz8dsR3Cxfazf3shr9u9XOv8kiKuPHHLWWdvRP3zKrb4tYxaIgG0iuIZNPAt?=
 =?us-ascii?Q?93L5TD1K1izKhv0SoIiCOc8PQP5wiR/yJD/8QpLRpyOAiPKVvMFaN8PnwWtJ?=
 =?us-ascii?Q?UkYziCYeeR3UnobrMPE461se0o/Ecnbcv2fqPJz2czElxKyknH/3BJZW6YE+?=
 =?us-ascii?Q?UrcoW8FxeZdR6S8E0FobOfWTTcbI4UWnKLSGrZhAoC2kTabQ/ayGWFpuBKj4?=
 =?us-ascii?Q?S64VQXkM3fi2cF3osXiVGklN6WDxgCGv72B5l7F/beOAuk/JYA14VebKgk0o?=
 =?us-ascii?Q?d/ogirnyD6WGz9bJPImuNc4JJKWjwG+39l4EyXjpxG63uEfHp87DPZQB4bbI?=
 =?us-ascii?Q?IJw15RjBFZ3fEFeSKXTaHQoaWw6YVq2CUqDZwcgMGodtTXiH1XZInA67V0o/?=
 =?us-ascii?Q?2HP7d4BuRzpJ2VlIx+euCkGLLX6zpXYMFrJv7MRJ2h/ZTqkrGMrLlQsiMTa/?=
 =?us-ascii?Q?qWM+1PasT6gWujoSb60GioYLOT2I0KnbeM0JQHQc2z2wlLuPScyc9L7MvMne?=
 =?us-ascii?Q?pmfU//WWhTBucBM2JsgQ4/a0q80tCKvtwFAdtJPd+8q1X2ZB6lME6KECF+tG?=
 =?us-ascii?Q?+NEP9WFVjr1u6FZoq13r6h0HUn6aGiZyO8nv7m5T8Bw7Q6U8q8BHSNi9FuLI?=
 =?us-ascii?Q?fryI4TekQzrYIqbR+juppapZD76vfcd5tuId/IsTSzBdjI8ZFT7euy+coPnw?=
 =?us-ascii?Q?erBG9mOitI4/QRCixru98RkU85WdTMiBLXm4Ek90ED9T/ofxWPHZfZutoMt0?=
 =?us-ascii?Q?vR2v4TVwtLf2y0tgpaAJlIbsQZg9G7dRscj5fP19Xn4Ne/l2ExI0OpxU6O3S?=
 =?us-ascii?Q?Pb2/zxJh5QoDD8RTYP1w2ErNXd9Tjeg1Oq28OU5YBpTOLsNMYVbI6fR/g80i?=
 =?us-ascii?Q?+wYF044+bjZLp01040zDsne6tEtjMoocaNgRf1CMltgMVm54uUQddfVTQ13c?=
 =?us-ascii?Q?I7vpykhVbIXqyNX5++bG1VxBM2u1a0rL8Ig+FQ2DdlPyQCgpyr4H8J+sAVvh?=
 =?us-ascii?Q?wv44lVBpamdVzz/X8UrM2DZGyq0nwmVSK+dqsQvvzvs/Un8jCXPbLWBYPAtN?=
 =?us-ascii?Q?2xKQPEdBrPd14xQfDpUIUjO8+Np4A0yftgLLD5A9QZ5TRRVJl8qlaWbqPClz?=
 =?us-ascii?Q?zmTi805jpLIU7soFBbEHk8W4y3OaKhap00s7x8SAr/FdI4d6eMcFDlMXnNwi?=
 =?us-ascii?Q?hr6s6yZSZik4t8K9q+3s2R0JPTiNxOoQbu24oBllQREJ94fscllSTSgMahmE?=
 =?us-ascii?Q?i7LLdpLJGcDH7+o4WmOUw387lFTmYNgkvMSA3EUbEmiiE9TfD4Bb3+UHb8zj?=
 =?us-ascii?Q?Cg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	6a6n1MwuCGtaBJ9PzPQU0BRCulkT4tyaYHV+YeTPfhhwo2LJ5hVeJcJUmylwfo5MTaaUSwi84QIVdL5z1R0IoB4JOm4Azaw25RN1/rHaLGCLDDsZpOUgOS0v9nCvT6RoStHR9HN8RQh7GiNZusurPE+iu65GBmn3tBMSbCiVBJBzEeaoUQ9Et+I0USgnJAS1XjtLsDHhTMHlz3IhN4K0Dnlt542p17eSNsAOJz6/DEVYUOb8diN6l/uL/pQpkl/syCO/Cq42R1IKk4rwKsXDBKQkAK/DOqfe0OaaQ/Ig35UNVp4moDRP6nMZbP5ijyr5DgyZtImc31ZLa+UXgbj86UAZEyLGg7j4zzRcD9kiy2xKn/yFPnMXpUhy6/PNYE5z9svAPMMhE24quAi7kP8HWh2/pb2sN/MNgWlyaHyxIhtAf/7Y/FlWJxCJL/Mz2H5wytcDp9UCAWq5/NeWCI5uFv1vXR38AeHRY8VP2XcTTcTankTkmh1fUgo92MiBL4gK2Q21AGgX2la802KXLypEumdDJ4SXeCAxxD/CDAnZpsLyh/BdwJY5jF8HbDSDzyxuZW8EHlpEHMd/HpoNJam5H6cTZRBOvgRFT3KhS3CE1s0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb7af130-00fc-467e-85f5-08dd09772294
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2024 15:22:24.3625
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +LbI92x51cBjvBq2HMubXhSme+tE6FK/3ZKdo4WoN6bNDw9y+TjXGcg4JJX+Mak9cER7eBmWQeLLH8Pss54lTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6393
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-20_12,2024-11-20_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 suspectscore=0 mlxlogscore=940 phishscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411200103
X-Proofpoint-ORIG-GUID: MScc7O-r69DIC-ZQkKQktDtOP0otQhfR
X-Proofpoint-GUID: MScc7O-r69DIC-ZQkKQktDtOP0otQhfR

On Wed, Nov 20, 2024 at 09:09:35AM -0500, Benjamin Coddington wrote:
> If we're unable to register a SCSI device, ensure we mark the device as
> unavailable so that it will timeout and be re-added via GETDEVINFO.  This
> avoids repeated doomed attempts to register a device in the IO path.
> 
> Add some clarifying comments as well.
> 
> Fixes: d869da91cccb ("nfs/blocklayout: Fix premature PR key unregistration")
> Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/nfs/blocklayout/blocklayout.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/nfs/blocklayout/blocklayout.c b/fs/nfs/blocklayout/blocklayout.c
> index 0becdec12970..b36bc2f4f7e2 100644
> --- a/fs/nfs/blocklayout/blocklayout.c
> +++ b/fs/nfs/blocklayout/blocklayout.c
> @@ -571,19 +571,29 @@ bl_find_get_deviceid(struct nfs_server *server,
>  	if (!node)
>  		return ERR_PTR(-ENODEV);
>  
> +	/*
> +	 * Devices that are marked unavailable are left in the cache with a
> +	 * timeout to avoid sending GETDEVINFO after every LAYOUTGET, or
> +	 * constantly attempting to register the device.  Once marked as
> +	 * unavailable they must be deleted and never reused.
> +	 */
>  	if (test_bit(NFS_DEVICEID_UNAVAILABLE, &node->flags)) {
>  		unsigned long end = jiffies;
>  		unsigned long start = end - PNFS_DEVICE_RETRY_TIMEOUT;
>  
>  		if (!time_in_range(node->timestamp_unavailable, start, end)) {
> +			/* Force a new GETDEVINFO for this LAYOUT */

Or perhaps: "Uncork subsequent GETDEVINFO operations for this device"
<shrug>

>  			nfs4_delete_deviceid(node->ld, node->nfs_client, id);
>  			goto retry;
>  		}
>  		goto out_put;
>  	}
>  
> -	if (!bl_register_dev(container_of(node, struct pnfs_block_dev, node)))
> +	/* If we cannot register, treat this device as transient */

How about "Make a negative cache entry for this device"


> +	if (!bl_register_dev(container_of(node, struct pnfs_block_dev, node))) {
> +		nfs4_mark_deviceid_unavailable(node);
>  		goto out_put;
> +	}
>  
>  	return node;
>  
> -- 
> 2.47.0
> 

It took me a bit to understand what this patch does. It is like
setting up a negative dentry so the local device cache absorbs
bursts of checks for the device. OK.

Just an observation: Negative caching has some consequences too.
For instance, there will now be a period where, if the device
happens to become available, the layout is still unusable. I wonder
if that's going to have some undesirable operational effects.


-- 
Chuck Lever

