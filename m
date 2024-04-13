Return-Path: <linux-nfs+bounces-2795-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A8258A3D91
	for <lists+linux-nfs@lfdr.de>; Sat, 13 Apr 2024 17:57:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A51B81F212BF
	for <lists+linux-nfs@lfdr.de>; Sat, 13 Apr 2024 15:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C43A4D106;
	Sat, 13 Apr 2024 15:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Hfhz15uJ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="EtpboPyE"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A664D5A5;
	Sat, 13 Apr 2024 15:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713023813; cv=fail; b=QKh7pc7wiwzqc3OAZ+Bx6WZ+U9T09wJ1ftfQCUihJVjdPli7/FERKwjpc2EellxMtKr0VZYSnl6zXkuLhMFy5dvlbsxYbHEyralQLOPnNN4Pj7TwnekpvbcrsFJmz3abmTQ/2NUcozLmVSMXnd5pINtszPqmXbqW6Nw4a9OCEKM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713023813; c=relaxed/simple;
	bh=8hL39drLKLhvJmdB3T9iY47Ftp2DOTAogw2mMfDg2js=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jQ0pYQWXv4+EoxpGTKtEtUHeaBCXksc1dxEzrbMZKhsnJZDgwQWxJDg6w2Mqc3Jb/XiVxAHD92r8v5tTo+zE6PMXcGjFm/ARnB7jPtBVXDp+xDXfpgrs6vURNoF/v4HRRdOabnuwbSw6FYmJO0N15M4oW+6FmWpfKO75SaTlB+E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Hfhz15uJ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=EtpboPyE; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43DEiRB5009784;
	Sat, 13 Apr 2024 15:56:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=QqfzjNlkbRoMfq8ID4FaPz1LPjFCLtarAuxT3h49iWE=;
 b=Hfhz15uJFudZgSDpFNwEj/9QFV6DQIrhEWqE2UbF93Ec4VP31HrfngPvI4D6qAjwDcoW
 V5pQ78UhMAKWojjIdBR6Ua4JcKE1OFHOI9vDraDREIFUaC0kctwNbttZdGhSfO0+x+dQ
 0eZT1zD6U8br+dKI5W91EeI2/gStyXTOvpAjGnue84UhuoiX0f8Vw5o98vjAMhOjR8an
 eFtwp7s+OSaa1ymwvwKuKBJE/4qGuAnrbHrKAPSGbCkAkO/C4hkPN6WqqbFwHK40bFcr
 64f5Pv6m2u5nwwc5NG3cGlIeMOAXFrpJn/vOh+vX2NyOdr10zkoR4f0cS3Ps8WjZHlzy Yw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xfgff8hy2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 13 Apr 2024 15:56:22 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43DEHjGP029181;
	Sat, 13 Apr 2024 15:56:21 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xfgg47738-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 13 Apr 2024 15:56:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sd02VFpJwRTsuoE0l1ceLPCz11NRXSoadAb6oy67MNUAz0eKuOybh20eJ9S8OpwO41b7xxd8WVvRokWO1Z7DYLUKe31BiS33811XIX6VMerDzMWlCtY3O4bndVEvzkiTJkEPD5YkHNxzQosVE9nVnlbfOlGPHqiDENMY2PixwswU4GKmF8o35NYeRSJweLvH3Pr+Wz3xiKR2Pt4OsjmJFyivWYHGA3THngbHEBNOWrqbbcOx8sTWIf4TuUzYB+Q5NnGqGTbYdj97I8mprRWaHE0Nn1MB65PpeeiV18XwpqMDtG7v4C/sqbLNPg8mNmAKyDrjj5qExaBDIRQ4mZdl2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QqfzjNlkbRoMfq8ID4FaPz1LPjFCLtarAuxT3h49iWE=;
 b=cCj6NEMigjQ+0T8r5x956SnL5tFEtMQ92H2Pl2asKG+WQME7uD2o4F/uOJubCdQz+sZzqnABZb00N2r5QAPdQjGh/Sl0lmH9bND0/6QCjpqVGA18BxId/QLXWjeE7Igj9HUmLvtvuY/UWFNjoGrRyIv6aw8yn4TQ2Mxol3Or69PYMQVk6j5I3xTGrUw1TyWVk0dyP0LQqd4khr7/KoEUzRBaEUz20kQSgqiHjUOzEg90I7m7Z6oEGS8MiQNJepbS6hzWvcvMwN7a5WphuT/+wPD6k55OLvs7iRFmmG1La1j5ijDwYKCWab6x2ifcQuWIK+/7DN27eHJ6ehT5fkwF/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QqfzjNlkbRoMfq8ID4FaPz1LPjFCLtarAuxT3h49iWE=;
 b=EtpboPyENwU7yJX8OnGQ8pUWDVWzxlqqc+f8OguTtBHMObpYKvAEvjk17qgSOWlWikM9fl0vJfSzSSvCLf6Q8yg1SpbeZtU44PfFN/UKdPbOEPeTqzfpnV2uJkovXwp/qKih2VjwIvAVRTN33NYi41QL8ll77WFYvalvBEe0lb4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS7PR10MB7374.namprd10.prod.outlook.com (2603:10b6:8:eb::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Sat, 13 Apr
 2024 15:56:19 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.7409.055; Sat, 13 Apr 2024
 15:56:18 +0000
Date: Sat, 13 Apr 2024 11:56:15 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
        linux-stable <stable@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "patches@kernelci.org" <patches@kernelci.org>,
        "lkft-triage@lists.linaro.org" <lkft-triage@lists.linaro.org>,
        "pavel@denx.de" <pavel@denx.de>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "sudipm.mukherjee@gmail.com" <sudipm.mukherjee@gmail.com>,
        "srw@sladewatkins.net" <srw@sladewatkins.net>,
        "rwarsow@gmx.de" <rwarsow@gmx.de>,
        "conor@kernel.org" <conor@kernel.org>,
        "allen.lkml@gmail.com" <allen.lkml@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        Calum Mackay <calum.mackay@oracle.com>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Darren Kenny <darren.kenny@oracle.com>,
        Ramanan Govindarajan <ramanan.govindarajan@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 5.15 00/57] 5.15.155-rc1 review
Message-ID: <ZhqrH0II0ZJj0dzW@tissot.1015granger.net>
References: <20240411095407.982258070@linuxfoundation.org>
 <2c2362c7-ace7-4a79-861e-fa435e46ac85@oracle.com>
 <27E1E4C4-86C3-4D78-AF85-50C1612675E0@oracle.com>
 <21c9bcf9-2d44-4ab2-b05c-a1712ac1a434@oracle.com>
 <ZhmYS9ntNbDZvkKE@tissot.1015granger.net>
 <11019956-95c4-4c35-b690-b8515b439eb2@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11019956-95c4-4c35-b690-b8515b439eb2@oracle.com>
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
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS7PR10MB7374:EE_
X-MS-Office365-Filtering-Correlation-Id: 72c8ceaf-1f1d-42af-7628-08dc5bd241e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	lUJ3PIpAVGMIAhnFypwVEwqxVlhV/ByqhPpkFRFxQzQoH9V299sJZ8aC7ygPfmR7aspQ8F38h8Z5DVkEY1rt/XVWRLKDoPbo5tXdFSiRY9JPZcrXuR5VqzdJyiZw53wP9yq7aTFXamgc7HKkUUd4cSR06lbhR0hR2wZmk1PWMhnw9zW/4fwI48vAqDVrL4g4N8BOfy4QwspSU3gmZ/cZBK9sSJ+qofFzqyCe8pFaoKfGSCLRyWrkO/w34cfZBkHoH3aciAkAor60ERIrayVl1qO5Lt5ystxLHPM6l+Lhb7YfxVfiGDumCIvacM8d36pW2UJUP4+9KPpfYPHvEOiUdXZdWRYkUTp8aeVBe5C+MzBwHe4yWy7/7zs2V9FksH/B0jTfTb/QosLeV4M035dulBQ+MCrHY750oLmXcbkMcj5oEj+cKKvF9sUq896ZAahduivS8xLXWTX+zlVG5K5Q9nfiNlcNP3ZqvlsHXtXo21xwmbFZLBW8bQwDJwo6jcC8scuUAIV+dazytrgj9r388Y5i1PJ1wTEPQFGy6p0nvJ5UIUf1HmKD5/M+rxvZxwJ5YeKb49W1irLcTnmFcCFYuUWThWNocMxthyt2KAnvOeZWmJoC3sXD27G+k0QWdwtGRfZRVoqfYXz9MYo1gl+B06pzDE1q713zukWZtRE5+WE=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?PZrdXkZFY4iussSJortr2n4jxirg6wapEAc5xz8MOPc81XIrXGMEbgZAxU7+?=
 =?us-ascii?Q?hDgzyMCLh9HlSzkOsxpLMdc62XRlHJwl2Yy6h4R9FWdp54MC0Y5t7gWZOedE?=
 =?us-ascii?Q?nIJaeVQvMN1/OIFlIA1YSkgHR/MvVr4ipTuMkGlARrkuXX+5PRWLHV6e4VoC?=
 =?us-ascii?Q?5FeoPGN79cTrvCSiH26Cu6mZgerIwY/PYUSTVUAccexJJFgbs8IucyBHVdHa?=
 =?us-ascii?Q?xjr6RS6TusnFxUWfRK5Pc7XYbOLLpNFA41x4867azq1GbM8nxPFF88zp7o+l?=
 =?us-ascii?Q?lhXXeuy7oths6Iy56GWrQDl/mN0HlrEQl/SR4oQqpKnjWxxnBmq1LiuzyOwQ?=
 =?us-ascii?Q?yGc8jyAe8KaSr8zcFoeA2OhdtYOcOn3ot4ThbTpV1F9qppDeQZg5fGN05yUx?=
 =?us-ascii?Q?Pz9ndkySauDesf0YAPXRBlDxm2DS8FQj4M7JBrFmOUTuXWQhIIUJkdVSSFAF?=
 =?us-ascii?Q?YydlWmQv6VCCxjNxCSaFSpAfWK5pzHmcGXlV7mpIF7WrsJe9Cs5kq08Lnuly?=
 =?us-ascii?Q?ZsNVBKAEMOPaj0HIbdsSREbfril8/Aj7Mt8kQxt4/oQ+/VouwMtndwT+ETqX?=
 =?us-ascii?Q?TFMd3zDk9Qc6sCWHV5ZR/DDeyG2zHmBQZbYPuYgz6EkkvF4uHEQqnGd4pQO/?=
 =?us-ascii?Q?vPaoXNnm/deL7Pw2d+eoK6GwN4ChSLYgYN8yPjagwzQStCZVAz/urnbzpcV+?=
 =?us-ascii?Q?w5O3f3sdZvi9Tj7dK/ehD4FmbgJB7fcCS8eenXiSRxGjTwL7iqHnylNmxl8K?=
 =?us-ascii?Q?SAsdU+4AxnoR3gAsGjJStKiRVHiym/gbLroLxry4XddeT2jC8kV21AuLNHTg?=
 =?us-ascii?Q?oxzoyj7iUYqXK2gjdE8L+luKMmjPr6wwhwFigh0oL7oPGdGs/4BONEe5DiDQ?=
 =?us-ascii?Q?UO9ZKG2n57HHZk7bRsf3Owt0xiRNEFxl3TAka5HqThtngDklmfPUe0d97940?=
 =?us-ascii?Q?rvUS4c0mAU1gOXOXxg+6liSozs3K0/7ycu+gooYtIJGUhey0UvXNmh0q9Kr8?=
 =?us-ascii?Q?ThYrjk4GCdkdo5BHScq/Nfp7HSQPeBnJRveqpvOLn2dSCBl/7DQ0XeS5Ar4/?=
 =?us-ascii?Q?uDWtErpvNvh3vMG2HH9GYjMcSriCBC3lR3LIiGqm6nW/Mhz3h7e0DweMnzLL?=
 =?us-ascii?Q?YbBVHfGimLrzN2obAPwBNjKXtUjS5D+ctMRHkVthKPjI110vtDDAFwogANqh?=
 =?us-ascii?Q?Ngk9rwP6D/j3mQvBPCMzVX7ZulL1ZfW8SMiIjzZNYrHQdp8/fcAzJ/rDhnKY?=
 =?us-ascii?Q?eUEzBtg1oNi5f1tB55YNqBjQcxWn0DvT2ErlELGL+D9oP+iPZClVryqMsfgY?=
 =?us-ascii?Q?b4RMKTTNCnAQbKsmT6F4Ipm6NjJnxcbLjlwe7z5WNOOHzKUYMGG4QViunGxg?=
 =?us-ascii?Q?XkAk2JVNiG6Iuuri+q67jVx5SrJaX/MKVzBzBoIz9g1VgKXrAuBzj0mBHrfK?=
 =?us-ascii?Q?bfLwxReaCdyRFLFolx2SJZJb8vmMIsypmDAJryv5axxjWxH9sjwZqaArqOgd?=
 =?us-ascii?Q?VSrRPs+fT0pEwb/xN2IRhjNpa3IqKz2ToHDTQvoAY3a8HznA3Nj8Tb3phph6?=
 =?us-ascii?Q?Oqdq9SHr3uvVxhRPrf7xnoBCbbr6GLASp6h9ZqsRCs5EQ4UmaUIi3FVIgEJ4?=
 =?us-ascii?Q?LQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	MTUJvE1XpxkKybV1t7f40M+Y4o1aA19bUWIK4GMHpPDnZ5hWte4uOSXCoMqK/mxYIRXEJYqmA2o5Ez5B2jZ2wW9JfLqiqB2acXAJF792oJldIKBQJAvzomH7UB1gGf6PgyybvtaBpG/gKC3uFOENAiqcpIjE6uCdbI2Yqs8vVxzVT0RAPCOUrOATWEFSTDfF+d2JLNecYWDZkZIK0/Ztkt7I5KEFoqYqsYeZhS44UsC8HCGkYNkyb9M7azUJOjp2SkzLTbw+CwKZcYHuN9nAJMJ5cJ9/EpzE6WW1/BNbkUIUCi8eYtDqlfcBoQO/8EQ+LPbyScJStpTSM9/NZbTAEGKn9tbQ8msx5D1jHNvaiD/FywANKRZnWBvUxU17U2xygugoYQHuTi5ic33WG4Xpm052QJfWu4ka61sbk+0h1lfOqQUX2RwV+vYxyZ4PRBoFbRw4MpzIXplapKu8gBbE4Z0NeIi5ycwaSRLCpWWp/lsY8Q1itNuf7ItrrCbnfWWrBC3M3u6Mi0ek2DZeJIj4kieBPDs2QkJV7cI/5Ge73fsTGiJNmcC5MsuhlftnR1213L96PptiVPP6eMLgCChO8oZRERsr4ckvp9S7YVs2fQ4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72c8ceaf-1f1d-42af-7628-08dc5bd241e4
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2024 15:56:18.8819
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N053o4Iw54287PQ9oqWegUkV6bDZhfbQ0RliLKEkqefGXkIIuoPKYynmVSpLL40hv+l25KiMD0Ou0cMkXdM2mA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7374
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-13_05,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 mlxscore=0 malwarescore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404130117
X-Proofpoint-ORIG-GUID: LdthkOwC9lSR0hs2zL4ljGzbPhUvllJp
X-Proofpoint-GUID: LdthkOwC9lSR0hs2zL4ljGzbPhUvllJp

On Sat, Apr 13, 2024 at 03:04:19AM +0530, Harshit Mogalapalli wrote:
> Hi Chuck and Greg,
> 
> On 13/04/24 01:53, Chuck Lever wrote:
> > On Sat, Apr 13, 2024 at 01:41:52AM +0530, Harshit Mogalapalli wrote:
> > > # first bad commit: [2267b2e84593bd3d61a1188e68fba06307fa9dab] lockd:
> > > introduce safe async lock op
> > > 
> > > 
> > > Hope the above might help.
> > 
> > Nice work. Thanks!
> > 
> > 
> > > I didnot test the revert of culprit commit on top of 5.15.154 yet.
> > 
> > Please try reverting that one -- it's very close to the top so one
> > or two others might need to be pulled off as well.
> > 
> 
> I have reverted the bad commit: 2267b2e84593 ("lockd: introduce safe async
> lock op") and the test passes.
> 
> Note: Its reverts cleanly on 5.15.154

Harshit also informs me that "lockd: introduce safe async lock op"
is not applied to v6.1, so it's not likely necessary to include here
and can be safely reverted from v5.15.y.


-- 
Chuck Lever

