Return-Path: <linux-nfs+bounces-3638-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 389BB9027ED
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Jun 2024 19:44:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB76C1F21C87
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Jun 2024 17:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D736142E98;
	Mon, 10 Jun 2024 17:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="c+DUF3xC";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Lu6nDbR7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9EF61DA4D
	for <linux-nfs@vger.kernel.org>; Mon, 10 Jun 2024 17:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718041449; cv=fail; b=ML7/V1nrz6GVoi6iA/qt8ibB61Y2RKpKOxg2JsopSHwMbx/G5/wfDmjijj6ZS2ghEmXHkPd3D4xfKdkR6lzxNabP8xLaSa87O9QkWGpOxwf04JLDsWqN7rO3WSJu+vCqkqJLF3XEwnA3xzTCHbGlPvvGbLet1SIgfVPCjEivTzI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718041449; c=relaxed/simple;
	bh=qY/HdsxiFnDVlrkSGK/5IFCXe9DvA+iIznMvEszXeNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uvjLX6MpJkqMHvmV/bp3TwsRJtuw9aWEbk6tyMftQceWpL2p9F6mjSvJH7OZLz+dw4DM/g7njyGqaCotZ/fv0b2d9w5ySufGfNdPRiu6C5W6f7IpLgCXRtKH/tjESEJKEcno+Fn7bIxaT6Jyd/9ISf2UraJefRJfNhrb4HFVQhM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=c+DUF3xC; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Lu6nDbR7; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45AEMP5T029317;
	Mon, 10 Jun 2024 17:43:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=dhGbi9eg3AjF6Bi
	hSA/m6tGo4WDXVlHcwkGdtzyNQp4=; b=c+DUF3xCOB50Jg8CtkyvwbC6B+sxaIh
	vRUH52OQ6qSkSuaniKFz+PKrX+Mkm03reM21XkC8ChsNhX10SSG/crctcBh5oMFG
	wMVrObVJoen4Rd2hYJarFml2JrzY+h/1pIBFwfaU/HOwHE6VDv3RsVmkuYe8FOLI
	BjoMZa3+/TbqC8DqyyzeAu6IE+Ok5b7FtYOg+qwqDtW/ZvT1HzLtA2URE9andTSO
	OJbJRdPkT/B+e5JVIFGE68RwxgM9tZkyrCnHQViA0JteFnldE+rNGU8S/k2qS9JG
	BO8EgUBldogDx+gHowsImukA3/leOsUG/fqD060r/dSVnqVv8OaC78A==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ymh7dk5qd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Jun 2024 17:43:51 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45AGEWsA020154;
	Mon, 10 Jun 2024 17:43:51 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2048.outbound.protection.outlook.com [104.47.70.48])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ync8w43f1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Jun 2024 17:43:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KhGpCCUfdNk+IBGzPpLvUAnQrhPez+FTf2WFlCtbLSvPPn/mgAw+uHIn/4wAopbF8FCHLwXSMU6R796c1YIKwPwGl23ACV/TbscvJ7S7KoNlU6UKkYfvoss+J01Gn7q5zUWNKGapHPrtYm3pTCfNWfrInokM9u3iroOeEH6+XPC+oUYl7J6QSTEK0pI94ecGCOUEIfF03QkHopuDITX2S/r2QYZsl7vEUBUgih20tHLJzN1q/W4n+l/b7Czkbh1xAIJhNTcicmQa5Jez7594VlKMo0Z5dwHKB1pB25eBBTSnjorrfJLC9AEcNyMtYSWraIJFzBlAwhnS40l/ydnanw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dhGbi9eg3AjF6BihSA/m6tGo4WDXVlHcwkGdtzyNQp4=;
 b=QE05wmuuQ3o9Dy2f2bK+Cw+Yx0Ndhln6B9yrSOrczSWECgufwoawWsnMUncvmSG4+xXMEREArLUzPSH075dEzeTziA4I5PTlFlMsehbO9pZtsio2eHsqXoBxH8fjmIlLr8+GiPKQchEHMtJw9+d/PZDFWhuF6XPJ48IiA+H3FyrQReQaTBLJs8tgBHsaajKPfx4ZP5bOAmQC74dafSWyzgpBigG2F3H2ZlatXtnxE34O1saqIu6hAWIQ0lSym90p0Syf6LDFxM22pTTrsIXF8NHJu+WPT5OM+9IajRksRxmISpjlGRFlz5nLc3iX97f8dbiUy8dYqGlp5eKClbynMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dhGbi9eg3AjF6BihSA/m6tGo4WDXVlHcwkGdtzyNQp4=;
 b=Lu6nDbR7ifMnFIhHYPoIMXKvMb/BfGq2tQMLEQQcCTrIfFADLyai3AkWSMJK8iAlRB2mDxZOVkKp1TdDr/suwCFOG8SxBe2gmWTYqYiFjPONA6h+0/lkC/9XJOcPU+y3rBcfS4J5H4JaWJIPOt4LgrbeIUVi5dkGhMSpQZj46Zg=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ0PR10MB4816.namprd10.prod.outlook.com (2603:10b6:a03:2d3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Mon, 10 Jun
 2024 17:43:48 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.7633.036; Mon, 10 Jun 2024
 17:43:48 +0000
Date: Mon, 10 Jun 2024 13:43:44 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Trond Myklebust <trondmy@hammerspace.com>
Cc: "cel@kernel.org" <cel@kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "tom@talpey.com" <tom@talpey.com>, "hch@lst.de" <hch@lst.de>,
        "dai.ngo@oracle.com" <dai.ngo@oracle.com>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        "neilb@suse.de" <neilb@suse.de>, "kolga@netapp.com" <kolga@netapp.com>
Subject: Re: [RFC PATCH] NFSD: Support write delegations for pNFS LAYOUT
 operations
Message-ID: <Zmc7UOSMmeGcqkBa@tissot.1015granger.net>
References: <20240610150448.2377-2-cel@kernel.org>
 <30924327aaee17182a83e18bc86e6a27a19d88ab.camel@hammerspace.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30924327aaee17182a83e18bc86e6a27a19d88ab.camel@hammerspace.com>
X-ClientProxiedBy: CH3P220CA0023.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:1e8::29) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SJ0PR10MB4816:EE_
X-MS-Office365-Filtering-Correlation-Id: 99cef2e1-0868-4ee3-f283-08dc8974e22c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?B3ODeeH04SnVE5DDG+eqn/1txLMmXpidY8Wx6V5HSPpx1sifptmIUOJkLZVd?=
 =?us-ascii?Q?bgMH0z9M4L1om04w3+Y9DL2YZiKWWfpRU3vVt6Sl9c5MyiWS16IbSdKuiJBJ?=
 =?us-ascii?Q?i++JfZQ75Beb/vt60rZSiJQDSfKrxrXO7aaJT5axgkvq0r4UCiMiW92oO6u4?=
 =?us-ascii?Q?T/clRXFGVxGvL8i0LmnYkDGinXVws8jVqB45CRUQIRPnpr6AIsON80VS7g8R?=
 =?us-ascii?Q?zRj7T9XKkMa3MzOl+1wNH6/mc2zLE8Y6OWKzwpt99nLg5RJ5t1Lti+6FWrWs?=
 =?us-ascii?Q?vWQ8nIXgs0PfohlVGwDlpZYDk7bjy/7UAhcM+Fy7iGbmbpGQ/vnj+U4oNoyk?=
 =?us-ascii?Q?PYUH1n+5bzyQMxfzsRIBIQxf8/XxJKd6tlYTr0QC/tuisy6LXJO8wMwmyvJn?=
 =?us-ascii?Q?Jm9+CRsBfXpoDHuA+Ji8kQw4TiTTot0++Ty2Ktrs+pR1uwQgETF4SzWPwDdb?=
 =?us-ascii?Q?Pmlu8Ls15/ukBftRmxsunC0AQe8Tr5jByB7SInXbW5etwOSfWsBbcDZBcEyw?=
 =?us-ascii?Q?bJ6qP3moW2N7xSFLKJu6vdE92lxtG3o6BVhmHq+P3DRnM8l2CwUHl4wl22LN?=
 =?us-ascii?Q?nUmc8HWbjZkBFJX45/EmQ30Eq5alo8icdThnSwXbPQuX2dvgWzFcDkSsFtrC?=
 =?us-ascii?Q?6e5JVcBO1sUb1B4rt5tVPQAsg2hdxUiRtYQXjtVBeK38HZ1FOB7OQd1sh/bw?=
 =?us-ascii?Q?bL5YxWsiGZdnrAYKMhbXcCxaz8T0ZFSgCW3o+5jdx1SyekTfLIZ2FgDG78Xb?=
 =?us-ascii?Q?polL4seZUWpauRo3ope0R/u/8QYsOfirqILPYsY18Q+kCVdQ3JiE7DO7R296?=
 =?us-ascii?Q?WdgXiy06tCYBdhYqhbkPvk7HDpu16/Y0J8NuR6m9DhuLuc3hEDo2SysJTf5T?=
 =?us-ascii?Q?57M7klFfRgm3HdjjMZaYuIniawdbHJeMc+2yrCoejC9yzZe1jCNgXR8YQ1d7?=
 =?us-ascii?Q?FSMgEKm2Aanz1uYzEXyIdibFL+JOm+b3WbZNgnFitjf+VzvwBz53rbHizSLA?=
 =?us-ascii?Q?LFvmMuegpxy8maIx6iwfeyGnY8hZM9nBg8f1MX3JxZ5hbQy5pHbCQ9SGxlRB?=
 =?us-ascii?Q?tiurXI3nztYqT2KbZiN9C9C5DEBaZdzuLfcj0ynjfCH7eTrFIVL55cEwBZKb?=
 =?us-ascii?Q?RLrlCMbbqBN/Bj+uDgaCBmMG0NJAXc6C6erGiKJwYWJPNtrOf6ajGWOyv8tv?=
 =?us-ascii?Q?S5yT1Vp8LKKApgG6dTjLL9jbjPmlRqdH743khXYU9yFs5Yaea6gq19ZKkp1Q?=
 =?us-ascii?Q?3SKTf6i9hii0BK0BumaempmUPSO8+FzaFTvfj0wrMN0o67DgCSZX7M+QnR/8?=
 =?us-ascii?Q?wX8HrR8d4fEGhUGd6MTQurG2?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?pp0jkx3F58jLnFfaYAE2I+745rgh9p69zTdUgm4T5LopUaKJl19mVaWIGk7O?=
 =?us-ascii?Q?Ugpvn9Yh2Qjm5+gHrYbU8qeeZbdVWgXWDiw4xjUOCgyw3H3mt1udEGeqOe9U?=
 =?us-ascii?Q?Ke0XU+/b9uXdwdcHZX51JHgMTehyLDK42eQvMox09MhwT3lCZpRUiTW/gBxj?=
 =?us-ascii?Q?EFOcUjQNIVUhAMKofWmNPtXugf3ix2jHdidx8wYevWtgIARh4epvqPe+qG+f?=
 =?us-ascii?Q?EAQfazkVePDSHRuGr9/rjCXJglcM+q/fpmIq7+27VzHjk3udxSK5z1xRzoPl?=
 =?us-ascii?Q?DbRI3awMisI84xdOiN06NijXv65I9eTUjo7U+J7nwcTtctO+rmVriqg5Oun2?=
 =?us-ascii?Q?VlVek7YMG8wKXUCyFRXwMFy7qsHJomXVF9rdUX45AlLH1hMLLdmyBc0rjcd8?=
 =?us-ascii?Q?eCA1cUkHyo5pauILuTx58/83wuuDbU2vPH9yFBI5Bf1Xd8bMX5RZHL8hZwtw?=
 =?us-ascii?Q?5qF6LSghIwzckv8Zg5VksbnzM9hAssKx0uMWB+ZclpVGZfPODWFIuFUO9Pus?=
 =?us-ascii?Q?GSPkatck7OVv1lORRWrTVRiMVJsiLvXkmsy/Iq+5XZ50JjO1m4ugJETcd+Gu?=
 =?us-ascii?Q?Oy0nMLCA1TODHnz3ZjU4KFeWlJ8xjEJ8i4VZAdAChYL5E+ewlcbrJm2dvcU1?=
 =?us-ascii?Q?SKhCkXL0r5VzOD0VJr2gbEkHDvKzFSkW7V/oO6viCTk5yVMCUpu7ygdu29Yj?=
 =?us-ascii?Q?UU7B82LXZU8Gjn92Li7KmsBGi6vXpaT/3v4sb+wS40fMc0fJOIQ6HtA/WMLO?=
 =?us-ascii?Q?QCs9q1DYuUmVSmM+UlGAlf/mwPfsZ7Et8SHKLlemU4K4YuVozCjJh/pK4z6A?=
 =?us-ascii?Q?MuOF2286uNB5Jb/JJ4bmu9RT/NtVWmcTJvs2bkZzm4qjEdSrMCfGCnvS+VhD?=
 =?us-ascii?Q?MCOLYW4aQPUwLQwDdJZtsFwmMCjuOL0LG76XpY9Pt3FvhNzD+tJ7Iy9i+ySd?=
 =?us-ascii?Q?p/9xtL6To5kvZMjDbMVIgasstC65J8Ixgun8UPqzFuNzVoUogU7UiHu+qtZE?=
 =?us-ascii?Q?u+g7SaUDcAgdHd5yutij21FPri5MeFV9yzjpy6zRtjR2BuPALS90fGFLUrn2?=
 =?us-ascii?Q?tkWZACBH6/WrV9Bk4/fKeADSgGKD57aAkHjxj6ZdPdl5lqzMvuI/d65WRxcK?=
 =?us-ascii?Q?krn+9mUXVzX8xDXRlpgYEGFA6BRO6dHFDjdbiKxGj4dcj/GZ/7X0Yx22UVKi?=
 =?us-ascii?Q?bTNPfily1SpOjT9BLwUe4MvHGUHxVK0hpBXOoU0NUVoukIWZJMoNFEGKPWgW?=
 =?us-ascii?Q?t2gh45Y6ySk1lLLI7BFbigQrofLvxcRSRkY5ufa9dIqI1H+PebUrdWJsqBmY?=
 =?us-ascii?Q?KaUVnluaRZScxG9yGo2lE6U4Z3AoqgpUR3iThdbZ/eGhguMSsyL3P/ZNOwyQ?=
 =?us-ascii?Q?wpeGZAAU8nQjy30CXqbAmfAF68CC0kBCKgXwjUNEXVuieDgKE+7f1TXULduq?=
 =?us-ascii?Q?tVTH+gVgb72oT2/Ju3y38K+xHRGpVxDuE7nr5qiCpRxCYXbSQW7jFXcJ8S9B?=
 =?us-ascii?Q?faoBPpbbRKjutMOZXXVMhXBNZYTWTRRXBaqK4Kkinu6GJnYPZYZxmsyBfcwZ?=
 =?us-ascii?Q?2tZeeOXyb68skJk2ZOVK6WJaavwUBRZ+MQqealQIHevmdbE88S7OH0xxPyr1?=
 =?us-ascii?Q?GQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	wwr881zHfOwxHdGVcqLSynOD/YPbMapP7AX7F4M8MKliHbp09KICkvCzSn5VE1SYMfi0J/CW8Cv4p9ziBVZkbvtCR8P6z4Z9wIkzG/RyNN9oq7aN2VhyS9gIJ65y9lu+8b0X9u0dNjg6mnn5wkqT42iAc3EaeZR6aN2bakW676Przj5D4GqsU5Kx/gDG4NENPY48zyV7qa8MerKGp+CbuLtutiTxEeLhV1BRSnZ4MC5e1TBq83yWW9bJ7QBvVe5CjXmdCWnWzqvUUfgnTd5QwlBsYQH8FiPGdxSjNQrtZ48vQkg63v57NSP39QZQG+k6JVVPGXdyd8AKOv7AVuUT8tKwy4ffEfKvaRHNiF4GcQVNHOkTKrCr32J/BXwrTtL56mWf5lJ7hQTtt0RSdVvzgZc1jS/VfuSuj9vfXDwSmIyk2uNqDB2q221kzfg5eRUbwltKh4ejHo5jYfSFZDfd6V2+BbAzB+DoFPpN2pyHnQCQVkb+PlAC+sL3Vbu9l9hsJF4ExTI0N/2c7IYih6/wPUaEp/uTr3GnEskbDtMwEidqStn9RSBzI3HXywWLvLgix3Ju/ABE4AneVXnT7jAYceUIDAdZpsZUZx/ht5OXSeg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99cef2e1-0868-4ee3-f283-08dc8974e22c
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2024 17:43:48.5349
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2byL+nOhWzWc/7VrYYgSV88UzYAlxlss7a39Zp30pS4WKX8tO95jdv/jT3+/HizP8xFuRRhajIRHZ+mK0lDsdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4816
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-10_04,2024-06-10_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406100133
X-Proofpoint-GUID: 8ZWRrGZuOOxULgqk6N0cObpHnLB1k6DQ
X-Proofpoint-ORIG-GUID: 8ZWRrGZuOOxULgqk6N0cObpHnLB1k6DQ

On Mon, Jun 10, 2024 at 04:21:33PM +0000, Trond Myklebust wrote:
> On Mon, 2024-06-10 at 11:04 -0400, cel@kernel.org wrote:
> > From: Chuck Lever <chuck.lever@oracle.com>
> > 
> > I noticed LAYOUTGET(LAYOUTIOMODE4_RW) returning NFS4ERR_ACCESS
> > unexpectedly. The NFS client had created a file with mode 0444, and
> > the server had returned a write delegation on the OPEN(CREATE). The
> > client was requesting a RW layout using the write delegation stateid
> > so that it could flush file modifications.
> > 
> > This client behavior was permitted for NFSv4.1 without pNFS, so I
> > began looking at NFSD's implementation of LAYOUTGET.
> > 
> > The failure was because fh_verify() was doing a permission check as
> > part of verifying the FH. It uses the loga_iomode value to specify
> > the @accmode argument. fh_verify(MAY_WRITE) on a file whose mode is
> > 0444 fails with -EACCES.
> > 
> > RFC 8881 Section 18.43.3 states:
> > > The use of the loga_iomode field depends upon the layout type, but
> > > should reflect the client's data access intent.
> > 
> > Further discussion of iomode values focuses on how the server is
> > permitted to change returned the iomode when coalescing layouts.
> > It says nothing about mandating the denial of LAYOUTGET requests
> > due to file permission settings.
> > 
> > Appropriate permission checking is done when the client acquires the
> > stateid used in the LAYOUTGET operation, so remove the permission
> > check from LAYOUTGET and LAYOUTCOMMIT, and rely on layout stateid
> > checking instead.
> 
> Hmm... I'm not seeing any checking or enforcement of the
> EXCHGID4_FLAG_BIND_PRINC_STATEID flag in knfsd.

I appreciate your review!

I see that BIND_PRINC_STATEID is not set by NFSD. RFC 8881 Section
18.16.4 says:
> Note that if the client ID was not created with the
> EXCHGID4_FLAG_BIND_PRINC_STATEID capability set in the reply to
> EXCHANGE_ID, then the server MUST NOT impose any requirement that
> READs and WRITEs sent for an open file have the same credentials
> as the OPEN itself, and the server is REQUIRED to perform access
> checking on the READs and WRITEs themselves.


Trond:
> Doesn't that mean that
> READ and WRITE are required to check access permissions, as per
> RFC8881, section 13.9.2.3?

Every NFSv4 READ and WRITE calls nfs4_preprocess_stateid_op(), and
nfs4_preprocess_stateid_op() calls nfsd_permission() (in
nfs4_check_file()). Seems like we're covered.


Trond:
> I'm not saying that the return of an ACCESS error is correct here,
> since the file was created using this credential, and so the caller
> should benefit from having owner privileges.

The alternative is to preserve the accmode logic but instead add the
NFSD_MAY_OWNER_OVERRIDE flag, me thinks, which is not objectionable.


Trond:
> However the issue is that knfsd should be either checking that the
> credential is correct w.r.t. the stateid (if
> EXCHGID4_FLAG_BIND_PRINC_STATEID is set and the stateid is not a
> special stateid) or that it is correct w.r.t. the file permissions (if
> EXCHGID4_FLAG_BIND_PRINC_STATEID is not set or the stateid is a special
> stateid).

But LAYOUTGET is not a READ or WRITE. I don't see language that
requires stateid / credential checking for it, but it's always
possible I might have missed something.

Also, RFC 5663 has nothing to say about BIND_PRINC_STATEID. Further,
I'm not sure how a SCSI READ or WRITE can check credentials as NFS
stateids are not presented to SCSI/iSCSI targets.

Likewise, how would this impact a flexfile layout that targets
an NFSv3 DS?

I think NFSD is checking stateids used for NFSv4 READ and WRITE as
needed, but help me understand how BIND_PRINC_STATEID is applicable
to pNFS block layouts...?


-- 
Chuck Lever

