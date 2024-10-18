Return-Path: <linux-nfs+bounces-7281-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE619A410E
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Oct 2024 16:23:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D39BB2281B
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Oct 2024 14:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69C151EE002;
	Fri, 18 Oct 2024 14:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IzZtFLUr";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XLJfaxY2"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028EF13C8E2;
	Fri, 18 Oct 2024 14:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729261428; cv=fail; b=bbjx+JQKBnNbsHP7LTFejtYmSM+8oLcr2cvRTNNVdP0Le71oMZBthZO0ufCK/+rFdFChtirw+7xG8H4sPHmX/OxiUoXOWxwlKVmYzHa5SEEemcQeG2KEp4bm8g8n0+9p0RBfauMAh9oWskrJJiNeM7FoV/pgyXerpymDhxg6b4c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729261428; c=relaxed/simple;
	bh=VfY0qVrp2um0BXkNLZoDmRraRigTZE8azHURE9+T9mU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tc8+k8Aef/qPr3aF8Ozi0+vna90wHQ/rqLIiw7xc0SlxkfJEDOoHhxVO4B4xTT5nOHo7bj4SqI/cX81HZu3OIXoJE6nxqAeGvOyplyXE4eH5Q+ofnMp7G7TBX5mVYXJgyEx7ElMFK1fpsPZDA6Mv+HMyd1PWeuYt0deEOcZb7oo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=IzZtFLUr; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XLJfaxY2; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49IEBiAJ014201;
	Fri, 18 Oct 2024 14:23:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=TLbwieM1fCNrkkVQZq
	jb8ZfRTbc4AO8iLlKvWHIPnlk=; b=IzZtFLUrUPT3k73P+uqXHgM/N/kdo3p7ut
	b3ZTg1uKr2pbZJ8kANWFK8xGgaP9O+toKVPVAlnUdJNgs6jQof9JBEgRvhsZ+y4c
	TAmAAPCCSLuMDsuhuFCCcDVHP6hRWIE0QnFZUTwHf0Hf70NBThmp+Vgx6PYHQugP
	8oAXkp4lL9JgXyeRWAy+p92n9YDnaEH0c7UKsrRRL3GamjoT26UfVXkaXodB2zAp
	HK6cCJxdoW1DDS6xu31Fe7MFu4ROCREIizz4iJZgKMVDGWW3CdaTrsk5JfyBF+a+
	2vOcZsOrmx85DMMbVgkBeaPf2KVL+rPWBsJd45efhOoZeuXrWMfA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427g1arq9n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Oct 2024 14:23:40 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49IDarub027261;
	Fri, 18 Oct 2024 14:23:39 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2045.outbound.protection.outlook.com [104.47.74.45])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 427fjj9861-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Oct 2024 14:23:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aEv/bJ5TV67qUeMrbv6vj3eJAwt1GnuDhGwrvDv4Ls/CCmTjC16KZA6H1U28TDwI07vevOitsEaVNPBrOUCUOBU/RtFg0dIXO2oZ61CkQGIz6xOSx7ElGZkJb/WQ882GT52yD6LKhOMdJzt1rjJuBAK9rGHzt0izAg2Zcz7PLjbwQFrRqU8GqdKBsZ9omTLlbi8s9QP7fhIqFwGCegAGSnX6sQiJVwtw+pWXQaRqOFixAjl/1fpfE1DowtguoYbEdKAfrSt0NpNxOtEA5jHjaCYAUIdil/4Ix3szU04aMr8hwQlZ6r5lEdXSHefYCOKLNs5WaskaZRGDnirzF6J1aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TLbwieM1fCNrkkVQZqjb8ZfRTbc4AO8iLlKvWHIPnlk=;
 b=j8rGo8yWULDhFqMCUYddLMEQBT52HfurppSnJ2yEUD8Lt+jaaMtJBfCcr2K3LRIIsbG8v3NH0KEF/s3eRc3YDBHofHIb9kKLgXQinEzye/mQeSSA6lUK2cd5/J2Sakw2kgwbEOqOppOrb4IAVBHQIWvoS08qacesPMMKAr7sUUcMMI87KQ8nKpZ0ZSx2o4Z94zdnje+EKJJymuWnwhE5t+yeKharMX9XL/eBlhHH7JIudY5Zh6QZMFJ04JBg86dh/bOslAT9klYtxDr54T0TlsyjVAHTYNN2LTpeMqRUf/YfKirp7t5uaGNd1EEOMsY8W0X0kA/NEFzuzUvPDNHH6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TLbwieM1fCNrkkVQZqjb8ZfRTbc4AO8iLlKvWHIPnlk=;
 b=XLJfaxY2Gx39VSFwmWDgYHcm/qflA+3fsv3240UCpxrEDuTfYTlqDZUr3d0Ujmy5aejx+Y3YPaaALrV6kJs+DSS8j7cgKx8u3+TQQNpwYznYCtzz2HEXgpgbVuDBYE69PUzLZoKYIo2cavwZIlBKKe1LRYFDFXBd+F8YeCTHitU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA6PR10MB8133.namprd10.prod.outlook.com (2603:10b6:806:436::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.23; Fri, 18 Oct
 2024 14:23:37 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.8069.020; Fri, 18 Oct 2024
 14:23:37 +0000
Date: Fri, 18 Oct 2024 10:23:34 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Kinglong Mee <kinglongmee@gmail.com>
Cc: Trond Myklebust <trondmy@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-rdma@vger.kernel.org
Subject: Re: [RFC PATCH 4/5] SUNRPC: support resvport and reuseport for
 rpcrdma
Message-ID: <ZxJvZqmKsPTtOFUR@tissot.1015granger.net>
References: <1a765211-2d1e-48ef-a5ca-a6b39b833d5a@gmail.com>
 <Zw/GUeIymfw+2upD@tissot.1015granger.net>
 <a4dc7417-1d0c-4700-9102-0ecc2c9e81ab@gmail.com>
 <ZxEP/zBCaSgxbJU7@tissot.1015granger.net>
 <c04e7270-1415-4c6a-8bca-a77cc0403287@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c04e7270-1415-4c6a-8bca-a77cc0403287@gmail.com>
X-ClientProxiedBy: CH5PR05CA0007.namprd05.prod.outlook.com
 (2603:10b6:610:1f0::12) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SA6PR10MB8133:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d524eb8-d9e2-412b-d404-08dcef807489
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ovsc7c1ZPr/uxLDZ0fZ1j+ookZkq4HudC3L+B9P1YG0IPD909iQ/JEuSbAMP?=
 =?us-ascii?Q?wRiE86Z0Evip0YRVaXxUh1JFor+Kpl3sE0TDjxXFe3YqfXHGeC682h17qtx2?=
 =?us-ascii?Q?3TY8ec9Bvx7Ep6wdli6fTIoeA9Ehfs/Sv5u5UnpdYacb1iAGSclKEHWpw3Lt?=
 =?us-ascii?Q?eDKoZj3lnqmlh0RGoc80PM9Grqjk7HImntdXMBZ2onpuF0UAGE83Vm/wmLeL?=
 =?us-ascii?Q?o4CuxwkAYAKwKwo7QfQnFw/H/7hSl94G9+v78LmTXqPfCVeJlz/d9Qva8W12?=
 =?us-ascii?Q?hpB+pg9jfCxVfY3oVOJPTWptZayV6hTj2fZBnjJnME2EE+oB68SyIn/fh3sw?=
 =?us-ascii?Q?Kq7mic+jiMRvyfOHH7kU8HlQUYbPfEooFGpmVpw97JLgxE747+EHHzNL7HwB?=
 =?us-ascii?Q?Y/BEFKRYaDQDZsflTay9PDuf9ynWksQhVOoEq86NCHAIN3oulVAXhc3LQF+2?=
 =?us-ascii?Q?F6nZ7hZuB3hkqb/sx9BZ5hZ8e0r9uVDrBjYwr/jq0b2EgcL0567gIc794hb5?=
 =?us-ascii?Q?Wv1DdtpcpURp/alCx77IdV92X/FDiRLrlX6bree4mrpLyz374Nj/nLnBUREW?=
 =?us-ascii?Q?J+P/RW+YJd3v1EulCAxFHHIEMozHfOFIXkXXeXfRU3kYZ+sN19OuemO3cbPk?=
 =?us-ascii?Q?GPKWdf+PjsJgkIahK2Xc7hIrh2eDuAdXbrQ46vwIdFWD/ZaK0DMGCzVdoNy7?=
 =?us-ascii?Q?0YCqBuKDCCBOSdVrora3LZ2TLfF0T2jZhEAopHfu1GNG+mw5Lbnb+TCeOw/l?=
 =?us-ascii?Q?JNhqBo5abJFJEH/qdwL1XvPMSXQLHl3tK/Tea9L1Ebh/JKaxYyZvutYDqoC1?=
 =?us-ascii?Q?FuRJedUVKxe+hnUgXN4hli120Uu5TihqQ33tiwxk9hxs7eiwQHJJzTg4kNbD?=
 =?us-ascii?Q?p/EvXUkIL+r3tyCzyXo8IS1KWeim0cv6/DUJRFCJwBew7nL/9QGt5Sp6ZhMM?=
 =?us-ascii?Q?Np5dm2j3SyBkwYxOv6G3MwO3mCMad8fC08P10EIK1tXvl27fTN7OJ+akYkYv?=
 =?us-ascii?Q?J1FcSXQtTcddCAAUC+NQhRoaRNHPd7Bqza4Z43eisg15OcDNFOsI+LB83Qsq?=
 =?us-ascii?Q?acPf5JppPUxXnp4Joig+Oqig5YGA7PVBcljeZvUOpUy6R9zKUMaf5k5f5GqV?=
 =?us-ascii?Q?qOtBGNiN1zcQwS9q8ieiKQbn+S1qWOidIAIneVQB4ZbKmrmEvXNZ8iwJJ6pI?=
 =?us-ascii?Q?uWDfF3ELgO9RizVZoNWSbRqnO5WgIlQGu5DQYTp+N0sCFbKAGq8SgdgOyBE3?=
 =?us-ascii?Q?MFgZS92tjJhKrsIhd2X4ZSp6v0sbNCV8EyG1h7WiahhGOj5YlBB1zwpKj3Qe?=
 =?us-ascii?Q?1nr9HHcC6Bpc6CqQ97DXX/wM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hav/O82wXqJlkuXqBaBHdElP/iuzV9Q/+2nSVhCv41WZMtn55rUJFlVyjxMH?=
 =?us-ascii?Q?weCuBJrdOjFth8IFDpmqtcIXnjkID/cqPb7onNMeMSEzrGzOwIQUHzrZQJU2?=
 =?us-ascii?Q?5rVHx2oVupmkfLJkyqRgtOMGt40WC1R8y/pGBv9LebaZqTR6BFbO64/aZjiA?=
 =?us-ascii?Q?MMkgiaNGKrr9PlJAeMJuXB4VrYYz0jStgQ09BkyI4dbZNz/PLEVxRPvpLjKV?=
 =?us-ascii?Q?gbV7adkiRpoNaZ3IgQP7WT6LzsZ3CAjRB559VFeM9lUL2NdvTqEjvGGuLZ9Z?=
 =?us-ascii?Q?LSSxAXlJiSxrwyIVi/swID4b/V3aFXwGptLLl392lM9kHoywOVwsFVb95da1?=
 =?us-ascii?Q?dmw7wx39ob7d4nNaTTmlF48796G0xCR7G3rFRnnbVQEJ5/0RrWAseaC5Nh8l?=
 =?us-ascii?Q?IJcNPP/WxzquKaA46ky5Ml9bXUFLXd+1mHN1UE0puABUHpzRTirqyrde4qnx?=
 =?us-ascii?Q?bM4hJnpsUX11d85BfkwYNYZg97PtMusR2ckb46pvaQRw4gSXIaE/fkwFffrY?=
 =?us-ascii?Q?V3qXDfS923VXezzQp7tLuCfkbc2hIBxd4UdrjbC14nkk6S1IfX/zH9VmOE5u?=
 =?us-ascii?Q?od9nKomEIrkxU8kf70rHxx40sSsMEn1d+t9FSgQgbwkWlQgWmPCHGl7NDFHY?=
 =?us-ascii?Q?1JRp3YfOd3RIi/StTE8AatrW4xQpXQs+VADCrkcEeSw6V+oAGcdyj3drbYFN?=
 =?us-ascii?Q?MYyoHpolT8UP2AV65ikODgh+NiDMjMWcim9g9TdF0g2qzGefhfl5PQjOOTRi?=
 =?us-ascii?Q?6cGwd7a5J4P8mMt+a+xT+8QJ8OemLNK7zNv3A/19pNgxOeGPmZAsSAi4NOmw?=
 =?us-ascii?Q?8mbbb1wb9YcqY01OhEKheeb9VOspFLvH4ckSug44P+uE1iUiXGcqIjPYWFG/?=
 =?us-ascii?Q?qgBuwex0WhvTS7Vli3jtfKpXNlqhzQhtf9d+OsyQLO1ecy+BMujQG5K7oTTR?=
 =?us-ascii?Q?B+cKMKnWvWvKhfYcMMIE9ZzRsKpQ0mwdMcYqg//H8eSgxlQN0FATcJ8ISGii?=
 =?us-ascii?Q?2OtvAKeX0ldiJr1RdFH1bm31MirvjL3WFr9sgfh3ac+X7mvS3pv5Htn8qQiI?=
 =?us-ascii?Q?MrkIqVEJjSBWLfFOjGL8/O0SsCmo2oOSONsHxbHFmqIhTGctJe81sF6yT4wO?=
 =?us-ascii?Q?HxNPAgQu0YnV4MyFtyFPMTac1Bv5qOtZ8DjjJTACmlgF0hotuLVmqpNmmTY2?=
 =?us-ascii?Q?GKpu5EFsDd6NJBBiSxQF9qDupKK77qHa9vT5l5WPiYK79z6ZpVweP7yBC5A/?=
 =?us-ascii?Q?Qj6lfWVoyNKI89vgvP11jgIEbjoE6GLyp2GWOzhWsRp8qVi62yutUEas5MUT?=
 =?us-ascii?Q?KkeBKqqUfoiSV+7foMFEEKxtH0dJ+gnvwqkEaZIIc7YvKCGsVKhzZOg2PXet?=
 =?us-ascii?Q?Cz9n+K2xMRGgV/+qmd0SBMh/TC2eivJCswH1cbi/JUDqFzRal1md5XUxiO7h?=
 =?us-ascii?Q?6sJgj3EX13fLD3ikDRsOgPvHoZKO2G++AHESFKmhZdScvmodV6L1LtAoafV4?=
 =?us-ascii?Q?HJ/TqMTHvg6CPbh9HrUul97PiKCqn6qzuG9QomyyVIQyydtKjTRrnvkvyk9E?=
 =?us-ascii?Q?l1awBeyxclDAYk0gkv7rtSQPNo3d7yeIa9dFLLsQ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	aNkz7c9KOb9w+ZZekfoCqtQTODKiX/S6dfsxlqJu20FlMtDRuM1gjXqfKTVljp0BFJ4rRJhuR+ym4eXfdy94izACwNkWK6/sTcVHHpRsDidSr++4c93kjkqxjCVr5lWVCJr6/3zjgSJUVyLhYnb7wT8ZKfCUqlIqm6sZpXDq6t8UCjh5LTYaqOQeKYLNTla/dGLLSJLrqWqSr245BoFq+aF/mLcSKihd5yqWy+MkDBJai0VZhxK/RPBGxe6J9IQ3KS2FAwbTqfQinKcHufRxHSPYqssZvApXAOnL4zztrskOle1BFQAT56XswOBfLOEjHNSCOaoeLZT4s4jYROzerttaUqSChH+NU8A4PGAA5hpMt3S9ErThPO5wpZ+N/C1LB9PDHuuNe5YhwPcJeXRB66bo0ywjAujSAVb+S8y6eeGgb3jistG4F2O7ONShdfJYaTDmC/iZZDMo77gtksEkQa7U7TmKYd1eTIOdw/xHGsAsnFyhVYPMzblOaqoUPUJ+rF+OVr0onNvZ+hjanLv1wCEC23J6+D0mjBis5NZ26eNonJ1xezX5ejRZ74O2tOFv64A+P6LHF1TGTy7Wn5Ag/1PORvyiUqPuYpxMb3EXfkA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d524eb8-d9e2-412b-d404-08dcef807489
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 14:23:37.1601
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SaZI8HcRAMFhsJ8CHJocxdujDgjeIgJYBnhaH2nhyKE2BR+7pM8zM7Q+d1yezcHvWdDkpZHFzrXtyy+hmX3rpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR10MB8133
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-18_10,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410180091
X-Proofpoint-GUID: xs-xM9nsAwVa_qHi5ZaEoP1oM8cWZZqk
X-Proofpoint-ORIG-GUID: xs-xM9nsAwVa_qHi5ZaEoP1oM8cWZZqk

On Fri, Oct 18, 2024 at 05:23:29PM +0800, Kinglong Mee wrote:
> Hi Chuck,
> 
> On 2024/10/17 9:24 PM, Chuck Lever wrote:
> > On Thu, Oct 17, 2024 at 10:52:19AM +0800, Kinglong Mee wrote:
> >> Hi Chuck,
> >>
> >> On 2024/10/16 9:57 PM, Chuck Lever wrote:
> >>> On Wed, Oct 16, 2024 at 07:48:25PM +0800, Kinglong Mee wrote:
> >>>> NFSd's DRC key contains peer port, but rpcrdma does't support port resue now.
> >>>> This patch supports resvport and resueport as tcp/udp for rpcrdma.
> >>>
> >>> An RDMA consumer is not in control of the "source port" in an RDMA
> >>> connection, thus the port number is meaningless. This is why the
> >>> Linux NFS client does not already support setting the source port on
> >>> RDMA mounts, and why NFSD sets the source port value to zero on
> >>> incoming connections; the DRC then always sees a zero port value in
> >>> its lookup key tuple.
> >>>
> >>> See net/sunrpc/xprtrdma/svc_rdma_transport.c :: handle_connect_req() :
> >>>
> >>> 259         /* The remote port is arbitrary and not under the control of the
> >>> 260          * client ULP. Set it to a fixed value so that the DRC continues
> >>> 261          * to be effective after a reconnect.
> >>> 262          */
> >>> 263         rpc_set_port((struct sockaddr *)&newxprt->sc_xprt.xpt_remote, 0);
> >>>
> >>>
> >>> As a general comment, your patch descriptions need to explain /why/
> >>> each change is being made. For example, the initial patches in this
> >>> series, although they properly split the changes into clean easily
> >>> digestible hunks, are somewhat baffling until the reader gets to
> >>> this one. This patch jumps right to announcing a solution.
> >>
> >> Thanks for your comment.
> >>
> >>>
> >>> There's no cover letter tying these changes together with a problem
> >>> statement. What problematic behavior did you see that motivated this
> >>> approach?
> >>
> >> We have a private nfs server, it's DRC checks the src port, but rpcrdma doesnot
> >> support resueport now, so we try to add it as tcp/udp.
> > 
> > Thank you for clarifying!
> > 
> > It's common for a DRC to key on the source port. Unfortunately,
> > IIRC, the Linux RDMA Connection Manager does not provide an API for
> > an RDMA consumer (such as the Linux NFS client) to set an arbitrary
> > source port value on the active side. rdma_bind_addr() works on the
> > listen side only.
> 
> rdma_bind_addr() also works on client before rdma_resolve_addr.
> From man rdma_bind_addr,
> "
>    NOTES
>        Typically,  this routine is called before calling rdma_listen to bind to
>        a specific port number, but it may also be called on the active side of
>        a connection before calling rdma_resolve_addr to bind to a specific address.
> "
> And 9P uses rdma_bind_addr() to bind to a privileged port at p9_rdma_bind_privport().
> 
> Librdmacm supports rdma_get_local_addr(),rdma_get_peer_addr(),rdma_get_src_port() and
> rdma_get_dst_port() at userspace.
> So if needed, it's easy to support them in linux kernel.
> 
> Rpcrdma and nvme use the src_addr/dst_addr directly as 
> (struct sockaddr *)&cma_xprt->sc_cm_id->route.addr.src_addr or
> (struct sockaddr *)&queue->cm_id->route.addr.dst_addr.
> Call helpers may be better then directly access.
> 
> I think, there is a key question for rpcrdma.
> Is the port in rpcrdma connect the same meaning as tcp/udp port?

My recollection is they aren't the same. I can check into the
semantic equivalency a little more.

However, on RDMA connections, NFSD ignores the source port value for
the purposes of evaluating the "secure" export option. Solaris, the
other reference implementation of RPC/RDMA, does not even bother
with this check on any transport.

Reusing the source port is very fraught (ie, it has been the source
of many TCP bugs) and privileged ports offer little real security.
I'd rather not add this behavior for RDMA if we can get away with
it. It's an antique.


> If it is, we need support the reuseport.

I'm not following you. If an NFS server ignores the source port
value for the DRC and the secure port setting, why does the client
need to reuse the port value when reconnecting?

Or, are you saying that you are not able to alter the behavior of
your private NFS server implementation to ignore the client's source
port?


> Thanks,
> Kinglong Mee
> 
> > 
> > But perhaps my recollection is stale.
> > 
> > 
> >> Maybe someone needs the src port at rpcrdma connect, I made those patches. 
> >>
> >> For the knfsd and nfs client, I don't meet any problem.
> >>
> >> Thanks,
> >> Kinglong Mee
> >>>
> >>>
> >>>> Signed-off-by: Kinglong Mee <kinglongmee@gmail.com>
> >>>> ---
> >>>>  net/sunrpc/xprtrdma/transport.c |  36 ++++++++++++
> >>>>  net/sunrpc/xprtrdma/verbs.c     | 100 ++++++++++++++++++++++++++++++++
> >>>>  net/sunrpc/xprtrdma/xprt_rdma.h |   5 ++
> >>>>  3 files changed, 141 insertions(+)
> >>>>
> >>>> diff --git a/net/sunrpc/xprtrdma/transport.c b/net/sunrpc/xprtrdma/transport.c
> >>>> index 9a8ce5df83ca..fee3b562932b 100644
> >>>> --- a/net/sunrpc/xprtrdma/transport.c
> >>>> +++ b/net/sunrpc/xprtrdma/transport.c
> >>>> @@ -70,6 +70,10 @@ unsigned int xprt_rdma_max_inline_write = RPCRDMA_DEF_INLINE;
> >>>>  unsigned int xprt_rdma_memreg_strategy		= RPCRDMA_FRWR;
> >>>>  int xprt_rdma_pad_optimize;
> >>>>  static struct xprt_class xprt_rdma;
> >>>> +static unsigned int xprt_rdma_min_resvport_limit = RPC_MIN_RESVPORT;
> >>>> +static unsigned int xprt_rdma_max_resvport_limit = RPC_MAX_RESVPORT;
> >>>> +unsigned int xprt_rdma_min_resvport = RPC_DEF_MIN_RESVPORT;
> >>>> +unsigned int xprt_rdma_max_resvport = RPC_DEF_MAX_RESVPORT;
> >>>>  
> >>>>  #if IS_ENABLED(CONFIG_SUNRPC_DEBUG)
> >>>>  
> >>>> @@ -137,6 +141,24 @@ static struct ctl_table xr_tunables_table[] = {
> >>>>  		.mode		= 0644,
> >>>>  		.proc_handler	= proc_dointvec,
> >>>>  	},
> >>>> +	{
> >>>> +		.procname	= "rdma_min_resvport",
> >>>> +		.data		= &xprt_rdma_min_resvport,
> >>>> +		.maxlen		= sizeof(unsigned int),
> >>>> +		.mode		= 0644,
> >>>> +		.proc_handler	= proc_dointvec_minmax,
> >>>> +		.extra1		= &xprt_rdma_min_resvport_limit,
> >>>> +		.extra2		= &xprt_rdma_max_resvport_limit
> >>>> +	},
> >>>> +	{
> >>>> +		.procname	= "rdma_max_resvport",
> >>>> +		.data		= &xprt_rdma_max_resvport,
> >>>> +		.maxlen		= sizeof(unsigned int),
> >>>> +		.mode		= 0644,
> >>>> +		.proc_handler	= proc_dointvec_minmax,
> >>>> +		.extra1		= &xprt_rdma_min_resvport_limit,
> >>>> +		.extra2		= &xprt_rdma_max_resvport_limit
> >>>> +	},
> >>>>  };
> >>>>  
> >>>>  #endif
> >>>> @@ -346,6 +368,20 @@ xprt_setup_rdma(struct xprt_create *args)
> >>>>  	xprt_rdma_format_addresses(xprt, sap);
> >>>>  
> >>>>  	new_xprt = rpcx_to_rdmax(xprt);
> >>>> +
> >>>> +	if (args->srcaddr)
> >>>> +		memcpy(&new_xprt->rx_srcaddr, args->srcaddr, args->addrlen);
> >>>> +	else {
> >>>> +		rc = rpc_init_anyaddr(args->dstaddr->sa_family,
> >>>> +					(struct sockaddr *)&new_xprt->rx_srcaddr);
> >>>> +		if (rc != 0) {
> >>>> +			xprt_rdma_free_addresses(xprt);
> >>>> +			xprt_free(xprt);
> >>>> +			module_put(THIS_MODULE);
> >>>> +			return ERR_PTR(rc);
> >>>> +		}
> >>>> +	}
> >>>> +
> >>>>  	rc = rpcrdma_buffer_create(new_xprt);
> >>>>  	if (rc) {
> >>>>  		xprt_rdma_free_addresses(xprt);
> >>>> diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
> >>>> index 63262ef0c2e3..0ce5123d799b 100644
> >>>> --- a/net/sunrpc/xprtrdma/verbs.c
> >>>> +++ b/net/sunrpc/xprtrdma/verbs.c
> >>>> @@ -285,6 +285,98 @@ static void rpcrdma_ep_removal_done(struct rpcrdma_notification *rn)
> >>>>  	xprt_force_disconnect(ep->re_xprt);
> >>>>  }
> >>>>  
> >>>> +static int rpcrdma_get_random_port(void)
> >>>> +{
> >>>> +	unsigned short min = xprt_rdma_min_resvport, max = xprt_rdma_max_resvport;
> >>>> +	unsigned short range;
> >>>> +	unsigned short rand;
> >>>> +
> >>>> +	if (max < min)
> >>>> +		return -EADDRINUSE;
> >>>> +	range = max - min + 1;
> >>>> +	rand = get_random_u32_below(range);
> >>>> +	return rand + min;
> >>>> +}
> >>>> +
> >>>> +static void rpcrdma_set_srcport(struct rpcrdma_xprt *r_xprt, struct rdma_cm_id *id)
> >>>> +{
> >>>> +        struct sockaddr *sap = (struct sockaddr *)&id->route.addr.src_addr;
> >>>> +
> >>>> +	if (r_xprt->rx_srcport == 0 && r_xprt->rx_xprt.reuseport) {
> >>>> +		switch (sap->sa_family) {
> >>>> +		case AF_INET6:
> >>>> +			r_xprt->rx_srcport = ntohs(((struct sockaddr_in6 *)sap)->sin6_port);
> >>>> +			break;
> >>>> +		case AF_INET:
> >>>> +			r_xprt->rx_srcport = ntohs(((struct sockaddr_in *)sap)->sin_port);
> >>>> +			break;
> >>>> +		}
> >>>> +	}
> >>>> +}
> >>>> +
> >>>> +static int rpcrdma_get_srcport(struct rpcrdma_xprt *r_xprt)
> >>>> +{
> >>>> +	int port = r_xprt->rx_srcport;
> >>>> +
> >>>> +	if (port == 0 && r_xprt->rx_xprt.resvport)
> >>>> +		port = rpcrdma_get_random_port();
> >>>> +	return port;
> >>>> +}
> >>>> +
> >>>> +static unsigned short rpcrdma_next_srcport(struct rpcrdma_xprt *r_xprt, unsigned short port)
> >>>> +{
> >>>> +	if (r_xprt->rx_srcport != 0)
> >>>> +		r_xprt->rx_srcport = 0;
> >>>> +	if (!r_xprt->rx_xprt.resvport)
> >>>> +		return 0;
> >>>> +	if (port <= xprt_rdma_min_resvport || port > xprt_rdma_max_resvport)
> >>>> +		return xprt_rdma_max_resvport;
> >>>> +	return --port;
> >>>> +}
> >>>> +
> >>>> +static int rpcrdma_bind(struct rpcrdma_xprt *r_xprt, struct rdma_cm_id *id)
> >>>> +{
> >>>> +	struct sockaddr_storage myaddr;
> >>>> +	int err, nloop = 0;
> >>>> +	int port = rpcrdma_get_srcport(r_xprt);
> >>>> +	unsigned short last;
> >>>> +
> >>>> +	/*
> >>>> +	 * If we are asking for any ephemeral port (i.e. port == 0 &&
> >>>> +	 * r_xprt->rx_xprt.resvport == 0), don't bind.  Let the local
> >>>> +	 * port selection happen implicitly when the socket is used
> >>>> +	 * (for example at connect time).
> >>>> +	 *
> >>>> +	 * This ensures that we can continue to establish TCP
> >>>> +	 * connections even when all local ephemeral ports are already
> >>>> +	 * a part of some TCP connection.  This makes no difference
> >>>> +	 * for UDP sockets, but also doesn't harm them.
> >>>> +	 *
> >>>> +	 * If we're asking for any reserved port (i.e. port == 0 &&
> >>>> +	 * r_xprt->rx_xprt.resvport == 1) rpcrdma_get_srcport above will
> >>>> +	 * ensure that port is non-zero and we will bind as needed.
> >>>> +	 */
> >>>> +	if (port <= 0)
> >>>> +		return port;
> >>>> +
> >>>> +	memcpy(&myaddr, &r_xprt->rx_srcaddr, r_xprt->rx_xprt.addrlen);
> >>>> +	do {
> >>>> +		rpc_set_port((struct sockaddr *)&myaddr, port);
> >>>> +		err = rdma_bind_addr(id, (struct sockaddr *)&myaddr);
> >>>> +		if (err == 0) {
> >>>> +			if (r_xprt->rx_xprt.reuseport)
> >>>> +				r_xprt->rx_srcport = port;
> >>>> +			break;
> >>>> +		}
> >>>> +		last = port;
> >>>> +		port = rpcrdma_next_srcport(r_xprt, port);
> >>>> +		if (port > last)
> >>>> +			nloop++;
> >>>> +	} while (err == -EADDRINUSE && nloop != 2);
> >>>> +
> >>>> +	return err;
> >>>> +}
> >>>> +
> >>>>  static struct rdma_cm_id *rpcrdma_create_id(struct rpcrdma_xprt *r_xprt,
> >>>>  					    struct rpcrdma_ep *ep)
> >>>>  {
> >>>> @@ -300,6 +392,12 @@ static struct rdma_cm_id *rpcrdma_create_id(struct rpcrdma_xprt *r_xprt,
> >>>>  	if (IS_ERR(id))
> >>>>  		return id;
> >>>>  
> >>>> +	rc = rpcrdma_bind(r_xprt, id);
> >>>> +	if (rc) {
> >>>> +		rc = -ENOTCONN;
> >>>> +		goto out;
> >>>> +	}
> >>>> +
> >>>>  	ep->re_async_rc = -ETIMEDOUT;
> >>>>  	rc = rdma_resolve_addr(id, NULL, (struct sockaddr *)&xprt->addr,
> >>>>  			       RDMA_RESOLVE_TIMEOUT);
> >>>> @@ -328,6 +426,8 @@ static struct rdma_cm_id *rpcrdma_create_id(struct rpcrdma_xprt *r_xprt,
> >>>>  	if (rc)
> >>>>  		goto out;
> >>>>  
> >>>> +	rpcrdma_set_srcport(r_xprt, id);
> >>>> +
> >>>>  	return id;
> >>>>  
> >>>>  out:
> >>>> diff --git a/net/sunrpc/xprtrdma/xprt_rdma.h b/net/sunrpc/xprtrdma/xprt_rdma.h
> >>>> index 8147d2b41494..9c7bcb541267 100644
> >>>> --- a/net/sunrpc/xprtrdma/xprt_rdma.h
> >>>> +++ b/net/sunrpc/xprtrdma/xprt_rdma.h
> >>>> @@ -433,6 +433,9 @@ struct rpcrdma_xprt {
> >>>>  	struct delayed_work	rx_connect_worker;
> >>>>  	struct rpc_timeout	rx_timeout;
> >>>>  	struct rpcrdma_stats	rx_stats;
> >>>> +
> >>>> +	struct sockaddr_storage	rx_srcaddr;
> >>>> +	unsigned short		rx_srcport;
> >>>>  };
> >>>>  
> >>>>  #define rpcx_to_rdmax(x) container_of(x, struct rpcrdma_xprt, rx_xprt)
> >>>> @@ -581,6 +584,8 @@ static inline void rpcrdma_set_xdrlen(struct xdr_buf *xdr, size_t len)
> >>>>   */
> >>>>  extern unsigned int xprt_rdma_max_inline_read;
> >>>>  extern unsigned int xprt_rdma_max_inline_write;
> >>>> +extern unsigned int xprt_rdma_min_resvport;
> >>>> +extern unsigned int xprt_rdma_max_resvport;
> >>>>  void xprt_rdma_format_addresses(struct rpc_xprt *xprt, struct sockaddr *sap);
> >>>>  void xprt_rdma_free_addresses(struct rpc_xprt *xprt);
> >>>>  void xprt_rdma_close(struct rpc_xprt *xprt);
> >>>> -- 
> >>>> 2.47.0
> >>>>
> >>>
> >>
> > 
> 

-- 
Chuck Lever

