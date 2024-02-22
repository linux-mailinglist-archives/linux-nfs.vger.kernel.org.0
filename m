Return-Path: <linux-nfs+bounces-2053-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A388860190
	for <lists+linux-nfs@lfdr.de>; Thu, 22 Feb 2024 19:37:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95D631C24557
	for <lists+linux-nfs@lfdr.de>; Thu, 22 Feb 2024 18:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2396971746;
	Thu, 22 Feb 2024 18:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mhNljDGU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WDEiOsV9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0289971724;
	Thu, 22 Feb 2024 18:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708626355; cv=fail; b=lp1Lvz/w5VfY9zxjbgJzRGfEzgjnnBehrN6QxotamGLVZQt/YGwxkQSEQPkg9WaX7qswZY+7MBXv7NZM/MWAb2eqRT6bhqqhn8xLAUnA2CiKzM/n0HpOlBvdafMlt3wWvhsBl0eMTMljN2/GQoNMextjFXX63D/N19IfIP1ruJU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708626355; c=relaxed/simple;
	bh=Mz4A4tI7+wFfxdonaYerROn2mDLxwSKdabZya1JpPys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ivdsoJ4sJs0xtGXgccscXcYsbR5jA5/f8ruX+1haiPHb8FyEqx81twpqQigbEbUkdje1Jn5mLIOPFudd5aGYSlW1Re6B36cs2DdKuV9p+3tthQk/VvBW8VlE4xGG04wECuqjq5FzQ0DkUAqsKEzc1kLJ0IuTtUpVIK2sPpVWdmg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mhNljDGU; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=WDEiOsV9; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41MGtear017880;
	Thu, 22 Feb 2024 18:25:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=qLM1P7S/5w7l9TgietxzgU067+Er/jU14NH5QE5WYJY=;
 b=mhNljDGUqsPwIIWKjrlCRfCglcEZ306OtTpZgokZdbZwAWaqjveSTt2HEGw0clzX3jI/
 kUZTfvTmenBC+N9Y+vFHg88YebAdFzS9Sk/sjrVRWMDPf7pBydHJiMVhP7g2lKCAbsV5
 Inc23VcGdfAZqzaJUDH8F0lh95/16vb7rwFqFLJo2dmce/HqE3k1ehPNUZDLmOYPY50j
 8cXsxljCg5qv8RJrx7TlsF6TgsiziUEnejlN3yfsMhg5EVREuIbmuU97xfg9E1B598KF
 kgzkooHrAjj4qiePAyNCastsqUklYfbqOKwIAqemaQ5tSTekFyYj/EN2fKi6EVIiylYO 7g== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wanbvnf63-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Feb 2024 18:25:41 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41MHVq3A024594;
	Thu, 22 Feb 2024 18:25:40 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wak8b25ju-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Feb 2024 18:25:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G5W5Vh/ApJzIikK3nnNSK6hX42kNqVK4qNAKOAvgZLccYb/7B7j8tmX9gVeP+fa+E4Ldv9TBo3tjtyAqTlA53zefD2S7S3M88MG6GZdz/UdwZG6gFlkI2sk+3R/ynCVLsPpLjJyi8ASL9AJ25uCrT9ybsSXHkktGDdDh3X34J6cLpojM8bzucK+Dj9MtuETIdEjcBIHM6bEuf3MToDgCG6RrD4jq4uQlpRYvZO+SxGM9YQGgNNhOIFatagzpWEKaCYhzZ7bAlZ02+A/Tv3rsfSpD5jeTUYNaX/LNNbm1k+502GyHpj/sxc9gM2tjJgqFxmTT8OfjB+8Isqqfc3/I3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qLM1P7S/5w7l9TgietxzgU067+Er/jU14NH5QE5WYJY=;
 b=d/2EPny3iI6nWk58yeb1O/7btCUbIn9GUopPJ+VyLkwWCCyK4EiEun7J0S73lHrpdwzeuZOpynbqgddskzgLd4Ln+wOChCc3SyPabHjm2ySuJn8LKZ+SHgqzHK0DVZaRRyoW1/GKzPY50JGcFWKwyLG+8+p+D5OTvjVtvWbjdoqCmlTDLcwaSljpiPVXeKdGjvGpVLOzhoiZ0IvECmE3G1KmpyH8RVo3tSPx3sKLCaDwR+obAvTW2zwOFe7tHklY5DkN1mFdiJ6QRiuyXsX0LZKc8B2C1Pp2gYpXucsWhp1cHK1OhXnw4zrIvzpuAjq/SnfF5W/Fo14zuUIi3J6Vqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qLM1P7S/5w7l9TgietxzgU067+Er/jU14NH5QE5WYJY=;
 b=WDEiOsV9+xPEm+Tn5kWg6dRbnf9PYTbWshyU4p+5axYIY2lPtzVdzq4VtQfXSN3BpCtUHOkAl6lu+TbZ/UWmVDxEXk1YcELxzpNJwg6efl6oNxiCBxPUf9ovCTlf/IiaB9D4VBtGRimojYzSojNz3ig/uJyccXo73iMzmMCJvIU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CO1PR10MB4450.namprd10.prod.outlook.com (2603:10b6:303:93::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.24; Thu, 22 Feb
 2024 18:25:37 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b%4]) with mapi id 15.20.7316.018; Thu, 22 Feb 2024
 18:25:37 +0000
Date: Thu, 22 Feb 2024 13:25:34 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        Neil Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Subject: Re: [PATCH] NFSD: Fix nfsd_clid_class use of __string_len() macro
Message-ID: <ZdeRnhXLhlXN4AqE@manet.1015granger.net>
References: <20240222122828.3d8d213c@gandalf.local.home>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222122828.3d8d213c@gandalf.local.home>
X-ClientProxiedBy: CH0PR03CA0212.namprd03.prod.outlook.com
 (2603:10b6:610:e7::7) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CO1PR10MB4450:EE_
X-MS-Office365-Filtering-Correlation-Id: 16fcc3c9-86d5-4d52-9cf1-08dc33d3aaae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	I6PBxjtLighcAsnVpuzlusJstowL6iS3TD5OMYQyjqWxpXFUSZH195Py7Y1wlNdZGV5psD6MeuNJPJLdi3a6wJZqfG91cfbvlWU+5M9Tcwfc9M6eVpL7zaJHhN+6PjLaS9akHqj8aJ3iz3Tb3f5KyHLMsTEXfZfN+2FuuKgBFzv4PlZ4s+dhJmSJyfCK70lKcHgg+QWV5gxLAHF3mll7wSj/2T4UBXq2iYcC+j47peibAUN4ERP1NxIlrJ+KwqwA6/YdNBROOsg4gBQX3emJP4J6scTpiev+btc5rI1YBcdfjoHKWN0/Zn3Z8gxjenzWU/jDOuUwlA5u04NGn54HWKJhUwrGNm09RJ8dYmlJmj7NBEJeXbqgegJZuitNQ42HhTUX2wlBvzpMgSGUmn1Jt0Vg+lKNF3iODWN6FT8rkumuVm6gStCtSVD3j7esDLIkFNcHq6IWPZAZ35ufRwibP4KUbIEtjY4IkWUB7eiLmNyeRXMVRTTe709h466UJ6oUvU7lCepkrvnqRkKqgpJO2Y3+oapt493HQABENHE/w40=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?AWSdT4ylgRGqGTis6UMLXHIMyxaKcdNLFcML/xahF2DbKPyDx4vvrer6e151?=
 =?us-ascii?Q?yk+7t3z6AJ3RVB93Z/RR/wRALYxi85yRD7iv5jbQ7idcFTEe0G/MckAGffYa?=
 =?us-ascii?Q?mEyfFTZ346q6Zfzw+RdfZFYox3t++9TJch3p0ygbXuO7GYWFJufnuTIA8hSI?=
 =?us-ascii?Q?5swjQghYVvB8uJOssHVkKSbaAFmgyOgXZRxDMy8JZnrhlkukpgX0ZY96bYo7?=
 =?us-ascii?Q?k7FvYbScf+mVJcl7lCQkO+sMlYQTDnrNPyr8d0vLWSsQBEMUf83KN66RCYk+?=
 =?us-ascii?Q?8TFCkuGXVqW18ONY+fPp8qnDeUErHRKj3dsmxD4rnhwAYyBQ7wy3QZMt5/DU?=
 =?us-ascii?Q?E9Hn4zTPpBVO1WiNjdUnMtRVfKyCDVgfxkbSes6ydf/E0OgyQnJ4sVodrNH+?=
 =?us-ascii?Q?5PU0aZQnmc6QfU2M5nH/R9Q3ohCRkFw7+2/AKcj0sxRAGrSD8nHTT+cEYDbg?=
 =?us-ascii?Q?r6pa6ClOqJ2veXO2w2SPcjpMkqfdvhrXhgW2Q1ccEeoWd5qQ71gvMtNkkPzJ?=
 =?us-ascii?Q?mfaYjlvkfDSPy2AH28wW4Ifnr7BQaacXWh0LtLFVhk4ohqInc1EAoGMiQrus?=
 =?us-ascii?Q?uiPMltlAeR/nXXZUVEkMoUNkO7REMqzgeifyQWyPNHLZybPClWZ2tPsSbkps?=
 =?us-ascii?Q?WRvZrbp41nNyEqMZY9Df1GFsmu9/3OUPTxzkEVIgdOzsnLfiSFHIZLh0txqb?=
 =?us-ascii?Q?Nqka4HtF/9QpETQEqRdZ6/yf9hyqgcJC6RBrjJAz+L2/PxB28n2jIO9eiliz?=
 =?us-ascii?Q?gBd9rarW99zmwhkOCNpT9IK0hPYFpXp2iT/VZAjU7+43XE4apjXpRmIqMTI0?=
 =?us-ascii?Q?38bd9KlKLRyggVU0G8yQ9hkL3eTpIT+XvyZ8P6ixkwFgO1kY2eU9tnKVsDob?=
 =?us-ascii?Q?WaMz2oV/wyA4IiTt4D3hX8CbkCWrqwpUpLPdqiYya4inDtrPNPOj29zuFIZj?=
 =?us-ascii?Q?wTbmhXe3rl6ucHDQD1AtSWCeKC+LwlvRK8x7xFsirmuaPzxO1T89tyKwJ2Yb?=
 =?us-ascii?Q?qj6G5cVz5cgvDeOTd493EfRuZx3oIzOdC5emGEP9SjRFC7JeJTZ+TCdkzLUB?=
 =?us-ascii?Q?y/M705Yj8u4TQSObf3agqOxo4PtKCDnGJO2PYsDHjb7rc/sEG/zZnCv8ChHv?=
 =?us-ascii?Q?CEy/7H63CuPbHGBPvy9pg6glBWzZHTbal7UYN9UsemnyO5ryM9iNdzZyvKVI?=
 =?us-ascii?Q?nEubbmD3fczAgjEgjQSMrJNVFwQ020DbC0SorhVTLwfujg3N70B5TgpzaGke?=
 =?us-ascii?Q?iE0TA0q60p7BykTm455BltO8F4MyRtN4VFkSkGYABSrMJzN7qRqS+doo0KPG?=
 =?us-ascii?Q?25uUh3LGZuRMTa5/sl9DEvGhCJSoUJMX9lUBM3Q/IwSnWvpK362ztEBIj8fF?=
 =?us-ascii?Q?Mdpc0VVaoVyHdKNeG3pR/k4UR1+lVvX/iq+jtCrFFXIyrlpisTdIoIzvlwzR?=
 =?us-ascii?Q?Y8uJojrd3JOBqjFrvmdyiDnJUEgOsGBx166PUczDdcLjrKuAxsLo6RnjpO5R?=
 =?us-ascii?Q?5jA4UfwV/LnmAx40dXzDAnWQgB8U56rbPbavbNP91yivblTSOAJBzLDNdYhN?=
 =?us-ascii?Q?pMo3yBHG8OOHN7Rc2sCwU/3K2z5Z85IjcqxG9j4SEmc9V1fccZeIa7S5mncp?=
 =?us-ascii?Q?hw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	cX1jf2zEy6Tyn8AZWDMrNG3ZLxUBeu3SuEqun5Ua1kW3N50xdeb4OdRDmAQlhMsuZlji1i89sWQ0hjSNFeipwsOucy5HZytHeCnQ7Iuma+NDPZRKhRTzd8WbIdN2VD90My1CILi7p0rxm5nmTgPA+Ipe0iP0H4NzAnPKxBJGPtqZynMtqk4ORGGXzABVm+kPtvMPkzlRlUAFjiFcRrl35bUPs7hTIV8BMQBeEWiwHV3cM9t3Zjfwti2G3pGnbRK/W+isKgc3YVccNRPnN147ky93jzINE7KidhVrdhzJK8EzHDqv/WWPVaOvJriYKwgbpDCy8KQbGWIXkTP/l62m6b5L0djMx3HGL+SMsDb5ax95X486fIa++Pq1ClZ/XtBPHllGvL3eCNvJVbfrktqVShDvQ7a14uTHpHVgGk0M1TjyZbYYuFzdivxTVeA1C+jCy6vz65IpGtbKH41nkBjnDvO6Pn3ccXVzeGL4Ksze0anN6sZYIX1uNFVxEzBR9k3siyS65IqK1VFGu3b8odNenI+f13UA2mJqanBndsShcxzQ8fLEnHDSwT+fdpW6GhAMtY1b4apvfkx24eVAaR+lnpu3hr5uyJImrkNcaoyU0zE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16fcc3c9-86d5-4d52-9cf1-08dc33d3aaae
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2024 18:25:37.5508
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bBmOdo5PYccnpba8QusZpUCPMUd3bwItN3YfvdS2+sRnVU4G5Sw/9evx8iQZnCe93dNeIUGHesFR+qQ+lTcong==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4450
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_14,2024-02-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402220144
X-Proofpoint-GUID: LqDO671s62jWOq-St45rkoRa2N_ukVK5
X-Proofpoint-ORIG-GUID: LqDO671s62jWOq-St45rkoRa2N_ukVK5

On Thu, Feb 22, 2024 at 12:28:28PM -0500, Steven Rostedt wrote:
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> I'm working on restructuring the __string* macros so that it doesn't need
> to recalculate the string twice. That is, it will save it off when
> processing __string() and the __assign_str() will not need to do the work
> again as it currently does.
> 
> Currently __string_len(item, src, len) doesn't actually use "src", but my
> changes will require src to be correct as that is where the __assign_str()
> will get its value from.
> 
> The event class nfsd_clid_class has:
> 
>   __string_len(name, name, clp->cl_name.len)
> 
> But the second "name" does not exist and causes my changes to fail to
> build. That second parameter should be: clp->cl_name.data.
> 
> Fixes: d27b74a8675ca ("NFSD: Use new __string_len C macros for nfsd_clid_class")
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  fs/nfsd/trace.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
> index d1e8cf079b0f..2cd57033791f 100644
> --- a/fs/nfsd/trace.h
> +++ b/fs/nfsd/trace.h
> @@ -843,7 +843,7 @@ DECLARE_EVENT_CLASS(nfsd_clid_class,
>  		__array(unsigned char, addr, sizeof(struct sockaddr_in6))
>  		__field(unsigned long, flavor)
>  		__array(unsigned char, verifier, NFS4_VERIFIER_SIZE)
> -		__string_len(name, name, clp->cl_name.len)
> +		__string_len(name, clp->cl_name.data, clp->cl_name.len)
>  	),
>  	TP_fast_assign(
>  		__entry->cl_boot = clp->cl_clientid.cl_boot;
> -- 
> 2.43.0
> 

Do you want me to take this through the nfsd tree, or would you like
an Ack from me so you can handle it as part of your clean up? Just
in case:

Acked-by: Chuck Lever <chuck.lever@oracle.com>

-- 
Chuck Lever

