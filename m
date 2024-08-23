Return-Path: <linux-nfs+bounces-5631-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7797C95D372
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Aug 2024 18:30:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAD711C216CF
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Aug 2024 16:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0AB0189515;
	Fri, 23 Aug 2024 16:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YDIDC6aV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JP2bDl0h"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81CCD185928
	for <linux-nfs@vger.kernel.org>; Fri, 23 Aug 2024 16:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724430648; cv=fail; b=t5lWycISxs7qEQYqC57gk4Kqfps/k/ZdGOEm/HgNchvaM+/VAU19NxR2hV5VaciMLx8pplDz09MsswmDXJB6bQIDF9GAZfS7KklOEKJpg57by1Ocp/6Dfr5oYNpd1wScf5ffM8OGlb1AJHX11IqpfLv9FRYY0fuu6pcJkNKGt8M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724430648; c=relaxed/simple;
	bh=0Q9VYyd74F3CR2Mkmmwn1pUZYvH5G38vYzVhxZqOPSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZjFwBJB34+Ri7S5Lcx8B+zL/vC12ay8fsXsS7uMmjME96IE0l2bo/5iXcXM95aeIf/1G6hBIUIP0yvlvDRkqde3X+HgIQQJ2m8h47MfbxHVdc3ZTLSoKn1GpGu57w+aPaKj7Y0ZKYWQwCBexglmPzrxIkPWFpp7PRpy29pUSga4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YDIDC6aV; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JP2bDl0h; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47NFMUd5016057;
	Fri, 23 Aug 2024 16:30:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=cY0TyC/B+W5Y0Qe
	yXJXNgt0ms/Z92mkbd/baRtM0hyM=; b=YDIDC6aV1pGjH1BDePb7UP8eZtMull1
	JnNl1BJ61Ru+B1p8vCa+zCNwh6gmDACryiOdiZ8ZnRf21ZmLKuYovxGpVNkPj7wu
	BvJ2q6C8l2XnhEJRWH/YsXLzoNQN/ABf4ULtSkSZ+6lmYc2RBbeVXDEYBAWqT6Iu
	A0ZnVZbmj1xGPkkUsu4bIPknOS/r4iSRRhrGF7B9eIwIfijC9DVTD61zTOrV9NFO
	IQx04XvGw0nxAWKu30C4dCeHOhjYH5U8hSX1X6oho7xab9o0VJ+riLuyZptZ7kGc
	P0kQNpkvpAY+KB+ePp/GQvG/eUM51MCTDGS7iaFwJv+S0VW+DUhM57A==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 412m4v4rsu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Aug 2024 16:30:41 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47NGTCd5032214;
	Fri, 23 Aug 2024 16:30:39 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2049.outbound.protection.outlook.com [104.47.70.49])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 416x058211-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Aug 2024 16:30:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mXPsRWV+EKNRgdBXa8C1+r8e93ynYWk6bUOKW69ao/zD98HrB7Qu0Yhsev4nse5UeVWkp375d7lncX50o5NsFy9f9piZ3Kz0gykDSSy2nlftvhhPmtUQ8Mz7I0r4udFYBbkjTHmyXvSFRDC9aMeuaAhTilCoYISEPItryr5wrggNpHpJQ79nLZZmWxb117OF9QlnY1XoeDUYeopWZDBxvKiRJAjmXVzS5preDO+DYvu7vnhm0jCcV5WQU5HCJEdGO7AqxKF9ivdCer6eKhMTh1CqrX0LUaaYruIwUuIw8ALYt4S4Hd3QR2OxhMnYUy9sTQzbZc8EOj6zpat18h6Ygw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cY0TyC/B+W5Y0QeyXJXNgt0ms/Z92mkbd/baRtM0hyM=;
 b=uI6KAEQIyGjC9ehlAqbaSfK2Gk0LSFlNeS3ZaYy6UZj8E2uVO6EKhodiB97LtLLcWdL3V0DEi2JO/vts5ZdGiT74YFqde/WG7znVGien6GoQKINEZp0bTQrOzX2H6zfa5LmuCe8ueI+WF+wcUlEDMbLilOYF+N/Vc0o8q4RK+hJRrgsv3TDOyFLOlDCDBAyG6gQUnHbJ/GXFGBlTLt3GePvpMd8GIy6oyOzHjpgt1uEile1Lcxe8Jhefz+Ouww2f4LfpPtMfLq9cO7ZrBTmW8AiuSf4QFOZzC0tXM6WvmBxv6YOhXXc9kH40BRk0HavUoI3mcMV+/sk4GpVWf4T8XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cY0TyC/B+W5Y0QeyXJXNgt0ms/Z92mkbd/baRtM0hyM=;
 b=JP2bDl0hug6Rd5OyJoZXhoJVdWzxz0mr5w3Qz8cHO0ut4RODGFIq6+is/bjI/s0GYPpBVfE28V42U7qGLoOc3Sktxp1gy/KsydEELmpsK1EWpeG+X+vJ4AdALuYPaPkW05rrtD94ziW/hjWuSoh13wc5xoB1z9eFpkCAG7AGN8E=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CY8PR10MB6658.namprd10.prod.outlook.com (2603:10b6:930:54::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.17; Fri, 23 Aug
 2024 16:30:37 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7918.006; Fri, 23 Aug 2024
 16:30:36 +0000
Date: Fri, 23 Aug 2024 12:30:33 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Olga Kornievskaia <okorniev@redhat.com>
Cc: jlayton@kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2] nfsd: prevent panic for nfsv4.0 closed files in
 nfs4_show_open
Message-ID: <Zsi5KQf9mco8fD3a@tissot.1015granger.net>
References: <20240823155108.72516-1-okorniev@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240823155108.72516-1-okorniev@redhat.com>
X-ClientProxiedBy: CH2PR17CA0015.namprd17.prod.outlook.com
 (2603:10b6:610:53::25) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CY8PR10MB6658:EE_
X-MS-Office365-Filtering-Correlation-Id: ab85bb60-797a-40a0-6361-08dcc390eb0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TMNOSw+V1xIJBD/cRW4HhyTMTIXRdgLtdwUcezlWz3EpdPWK6A2WXk1p0Oy/?=
 =?us-ascii?Q?XtG1+Wbl8Q2fpPXWHyJAzNJiiDBYIglKZZ/m45pKMAlMRLkTmPyFo2apurLW?=
 =?us-ascii?Q?kcqymjnRocUTSemuGUPVk5UWXj+9Kj/QrDdXktQE9ALSs7qvB+M5yLJEF0xM?=
 =?us-ascii?Q?VHOyzvhAShI4a4uSBy+2Df7G5Q/heQGnFvtbxlsftcYkO3seOU5paqHtfhi+?=
 =?us-ascii?Q?7cLjdZg2uScVFsxTCZ4yte+p+qh9I41FR8FmjLEn1teXUKgefs/LOArcVFT2?=
 =?us-ascii?Q?GOiqojsFwAla9qWtbxxnH8kE7Hi+uLLsCrIfjhhlmHHyHjgxUcEiyOUX9p9o?=
 =?us-ascii?Q?ntbysEt0POGX9uSVgVkcJgTQbv8gbFmHxY6TuUn/ZsOup+eAzLFn2HupW5Wl?=
 =?us-ascii?Q?B2djQC9G6ap5pe6Plw0LImrZKJZHBCPipfj3AMGMaGiezWkZI6hfppdCcd14?=
 =?us-ascii?Q?CLi4FgB9vPKb5j1PFmO+Ymsd7Xs7htnvH44XA7M1rwjlBway1ByNzLP8yUAG?=
 =?us-ascii?Q?kZAVg+gDgsr8Sn+cMWTun1ReYgApHDYYO/sMdE4zmPeDCywvSamQJ1FZwPvk?=
 =?us-ascii?Q?+HB01+eNzYuSVU7sK8Kg9m30w4l+Mhp87Ld6Iu4gMgljhd+lkPurJsok7vpL?=
 =?us-ascii?Q?s5X8T90zN1ND8C5GpZlEJMIBI7Cds3TqAM9wJVNistFeG5wygY+wn2giFuj6?=
 =?us-ascii?Q?T8orBodjKPLTggsyAaO9mu+kupX4QYEZzk1fi2nWU+R8YaXfE4fvuN9mPUzl?=
 =?us-ascii?Q?VfvBCKUE+tFSVu5M0yqwGtbF4cR04UDuHL13peXt3bl4tONJnjZehpUK+U/s?=
 =?us-ascii?Q?sW3TosTO+rq33IqKL7vVUvLMyJkT/+0NIZ6AmbfDz/8MN9lhcLIqdgZRi339?=
 =?us-ascii?Q?BjOvXwCM+AUROpCyA3z4LGct/sDnEtUyI2xM/NGrFG4JR7V7UeNkiKGBXe/x?=
 =?us-ascii?Q?PHZGZwQmDYTyBkbu+7zgy21ahavhIgnJ9TARKT+3qd507P6u8P8Twk7osCgP?=
 =?us-ascii?Q?pyTC9PWjNxbRNo21NgGujMCn8l8c2GKDdXQhYOPHaemY1PZd4BYmPGaLpFmY?=
 =?us-ascii?Q?JVKcX4dal2nMxWHjxE/5XTmJOLe5v99O2X1tUXCI/mR+0nUDn88mpQxGcN+/?=
 =?us-ascii?Q?sjnPLt2xxPY1XNkYDjtrJFRMepB/ygL4n5hQuN+N/hGE4MjpiXk0r9aLqRje?=
 =?us-ascii?Q?S8hC/NX8zU+UVifCB1qDOWN8nh3FKCNXkMEF//xP2S/W+zJbc2zp0LjQab9k?=
 =?us-ascii?Q?iqTtoNQtf9ZUYMgPV6GYQB2D4QZcB7XsIfiE9Ab3DSxA+cMHdl9v67uhKPfD?=
 =?us-ascii?Q?XyHhgwdKAHWQu4z52R2S4ClW1hSevUdP3RSKnNZaskUSSA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ITZnA4uXlDHkskwg959cwJAKke+ZA7IOnoJL2ZpVl5MF82LoOiAJey9Hf4RJ?=
 =?us-ascii?Q?7wXVGtrmk0ZzOU1zsiGJQ7x+2w/S255g3eYuza65XxeArMFLkObH7DywMM+e?=
 =?us-ascii?Q?F3mWM86JJlfKgjLWE/w05xdXnHzSyE8GB/6LaAwfiGtCpqfWaNL3mealt1tR?=
 =?us-ascii?Q?y+sKmwVwjEsTHEw8rkPKzi7uCrHpyTXKigKVM3BeouokWxczks+mNrJTkyAG?=
 =?us-ascii?Q?TYZyH7Ym56qtUE+f6HwbFvIv4ExrINKohoni486U/Dk35vQHqdyA1ynOTC6u?=
 =?us-ascii?Q?iri4Y8GJN4nYg5F4DSrsjuEvBP6d8nbw9LZiWY2keiK7+QrbdjQR/ooauoYx?=
 =?us-ascii?Q?uqtEQqQN1uVDc/M9mNDHQtFXPdEY5Ya75N9vtYbJVGYQ72Q37Rfgd/vz7P+a?=
 =?us-ascii?Q?zqBu4zGWvbj3gVzbJhiW44GXH63yXAX720tRVCIPkb5y5NLWhfC5PyKYAIKN?=
 =?us-ascii?Q?xCM9BzFb0IfnZoOxi9kTlR4lFN8MArmcEflbMJRgvFDyOzwnJFSIEgKTWoxt?=
 =?us-ascii?Q?lZSEa3r564Bg2VrCkbFn7ezN9B6VAEiR/7CC3McbMUBG2EOl+E0pWTWradHC?=
 =?us-ascii?Q?7VFewzyPhHmauACj2JGbQwFKxs7EZQkzd5+6/uGrNGqDljI7iGuexPuCt84n?=
 =?us-ascii?Q?LV8ND/gLXt61aXcpvOf6Xg/TigaGZb75Z+GUGAvexC7l+ASxJ/JkbA0PWZEy?=
 =?us-ascii?Q?LY5YCmD2LAe9yG0um2cMM/gdaYPUbJYv44Ucp1cmT0ejfbYir1jMqKSTOdHL?=
 =?us-ascii?Q?HbU/XK+PVSOsq3emJIwjK0D4dNkhuKGXdUXKEpV3P1t9vkPYf62GKgBzP7p+?=
 =?us-ascii?Q?HzD0qNbFaWeFygy9q43HmKcZe6ttQT++3pDQyz3KRaCpzHLCAd8kBDP3pPln?=
 =?us-ascii?Q?sDbhmwY+F2w96nuCEujuORvcvXzH7Zl4etURHmjGQPqccn5VDbYRGxCa0bZH?=
 =?us-ascii?Q?Itrcvn4dosh/JvCsXbV5XNkpQlRLbhzqlriCyt+qeya5YM9+3mYQfhwUwfvg?=
 =?us-ascii?Q?MU6TEY1kCEfOvQm1mECNzhWener6Tv6+xqu8TtKKfnyHdSi5iGlWezbMeSue?=
 =?us-ascii?Q?iydCgpKh3JBcMdy36/64oQmW7Wh79RBDr0/uflg0FF+L3TehexwJvxYw1GOP?=
 =?us-ascii?Q?ebEcwcuXtBwi42iYKgFHaspqJWPdKY6bv0JzY0hzOdQPaKCv8AcauFJh/g8D?=
 =?us-ascii?Q?GmDJwihelkceRRoAbm/EIgAU24bodTGHkdLkOOHLv8Bzhy94aKbk72H+2qJN?=
 =?us-ascii?Q?g9+cIB2lT1OKnnTCEZ30FzdwGWpMe7se6gof6QXGN8VdMivXtOJi8Jr4bFec?=
 =?us-ascii?Q?uiXLapeW8ksNmQke0/RtVXk6RBXg3jDXhymT78X82TgQGvhsdOJlQBOQmtnZ?=
 =?us-ascii?Q?hSpJ3oaIvfwI44IkbWRZKdrCJChbBDUidatUw9yEiLhqbUVtayEwpJkWM1xj?=
 =?us-ascii?Q?qaU2n87OevTgNznXEbllp3OGopUTFnH3CcN68qhfG4cJ3frS3BKeOapMpMuW?=
 =?us-ascii?Q?ATa0llnt6RLRS4bkL9sgKHleLJ01jb/xgsNgwIW2hbo2a5iMEpE7JAViVGCl?=
 =?us-ascii?Q?8nALVrm1sj31wZYcgiNvWWFQK+OBxvPMRMur1mtR?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QJpX2iptvDwsHyt8JW2k95uqNkQJVrXCiunUoo7YeV+qTbpmXqB9SI/f+GFOuPuN3CN2DHl7fkuyjQsswLyPhw1vGU6ye50+B2ltyW5iGgGmYBak4JikEhcxBK7VsQxKGz+nGXI5vkW7zg6g5iHMVdZ1FN7CpO0yFfNRf/lBtMOhCjrOY2j3h0t7HRXSa6fYFse0YrduEwWafq18l8XRfaZsZcPpsduBHgmnQiUxV6nC/iEOca+3uAGlwhWfSEwORMdHoTyqIbFMukItfD41LjDDMZe5bo7ZKMnQUaWzdVLH2FNF6GCBN8oczIoOt0cJ8pPdGQmCo8avcGEmK8MtaqxcJZL2yVUuBR+h5v7QIL5Ye5pGa5OQ4lV2mmDMkksGY3mKA8nrEepeay03ahZD6RnzG1A9yPyLbcm0fU3sgLt3AnUQeiNjy0wkJJF8FTNHam75l+LqgxqsM2wMNku/BJMyBR7mMbXFRQ6moJXUUD+P3zEspIf1B+c1D5jJAoh6wCsVCQ6VMJlCRLcL5DK9JIvMDwRvM4OvNqJZ/P3fg9oZXdrSiwo2maPwIJCD8dWhwKmW5E/KQ8eQ8IWKKqVOu7rvcH6vXRwSP/r+hT9IF/Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab85bb60-797a-40a0-6361-08dcc390eb0e
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 16:30:36.6945
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8JA92L+V2nNWj5fWZPaNxxjdK5jxb83BiUAyIVK/ehXTebjoX938rmSoU2G1sD90guIWn39J+MC2bDb5BnKs4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6658
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-23_13,2024-08-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=806 adultscore=0 mlxscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408230121
X-Proofpoint-ORIG-GUID: jLXKFqXf8ObpGi8K__wyyU5n7aAJ7Bpf
X-Proofpoint-GUID: jLXKFqXf8ObpGi8K__wyyU5n7aAJ7Bpf

On Fri, 23 Aug 2024 11:51:08 -0400, Olga Kornievskaia wrote:
> Prior to commit 3f29cc82a84c ("nfsd: split sc_status out of
> sc_type") states_show() relied on sc_type field to be of valid
> type before calling into a subfunction to show content of a
> particular stateid. From that commit, we split the validity of
> the stateid into sc_status and no longer changed sc_type to 0
> while unhashing the stateid. This resulted in kernel oopsing
> for nfsv4.0 opens that stay around and in nfs4_show_open()
> would derefence sc_file which was NULL.
> 
> [...]

Applied to nfsd-fixes for v6.11-rc, thanks!

[1/1] nfsd: prevent panic for nfsv4.0 closed files in nfs4_show_open
      commit: a204501e1743d695ca2930ed25a2be9f8ced96d3

-- 
Chuck Lever

