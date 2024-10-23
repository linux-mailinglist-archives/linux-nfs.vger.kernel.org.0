Return-Path: <linux-nfs+bounces-7388-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F82C9ACBBE
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Oct 2024 15:55:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF913B2095E
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Oct 2024 13:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B24188289A;
	Wed, 23 Oct 2024 13:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mdbdQjKd";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="j9Rdfb2M"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2EE1A7264
	for <linux-nfs@vger.kernel.org>; Wed, 23 Oct 2024 13:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729691738; cv=fail; b=amPu1MGAGZeIDU0kYwqk02PiinBv4/l1A3vc0LbK5xUAZnsaKdiYLCfNfM8cq5h1rF2qkvWFjjtqpLZUVtI5W5NkSacN7MilhQc0RyI8SuOGyZ8s4btQZgP7BffXPv1bK0Evy6FJwOiy+rQWvpKojMkHQCJDxbAwrZ1ph8+pzx8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729691738; c=relaxed/simple;
	bh=J9xjQvCAzxhzGfhtm7zpSo4QHZ4jF8V2Yn5FM5txGlQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iaGVbpt0r11vUWYXMQfAPsV41Eud9BxOeH8rCLESS8o4jGADvxgstGF5Sv5fa5MVUqL/iYAKDF5e8QIKVE7yQq2+bruQDX9HRF//hcZIM78T4ce/UHHkKxgzQthHabtOj4SEDTScm1nERnexcTcUMHAyKowrpwMOPYnyOg3uF5A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mdbdQjKd; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=j9Rdfb2M; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49NBQiWS007092;
	Wed, 23 Oct 2024 13:55:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=T7XmReP8vGqh78Fg1Q
	8nbRw4a4mosxHnhq3XVDrR3iI=; b=mdbdQjKdq3CWIS7v5oanYID0h4Zp1Nce3Z
	xja92xddNLTzDQ+hYUPE2DGdGa9YHVNhWitd9tK2BpWgSFmtbDgQ7mfwsBkXmI/H
	eV/Hg+JqtpGVVDhTj04MVXc+AJLVfRGdqN5yKO1Io/ZU3O06KCLbMbv6nALSnwpL
	5u9VVKw8yt6Sn2ALV2CSn2AnxqEVPCacgxSLaD9vmMyEhp1dzsAFR+WTXEe6VkFR
	Hkrs9CDklao2fPyt+sYcEWv63RlrPVMgak2kgxmbmqtBDxFu7TZ5DydSW2XUaBWu
	g19iYOowzK87wAaPnp56bCceWeos+vYYOtGkukp4IEVWFgWxgdjA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c5asg5xd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Oct 2024 13:55:26 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49NCJ4k1036111;
	Wed, 23 Oct 2024 13:55:25 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42emh2jbrb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Oct 2024 13:55:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W6fnIzzEzmgBnJaBgVEiczxU4wfQIN3LM+EDZiflm+rFu9hwT75zxlSsI7eMX22rT9RtBesP9TToMZ4SfNnnn7bRDdhMwGuw6B+pfgimyBPEiMXtMxnYmEIKe65qgS9emRn0rCCytvrpkhSF+UTNLK9XVktoFV6x6QHav3mPVJ5IExfB63z/7YQv9l+9Vj7gEnhFvaUCt05KK1jM3vqWRCjEZkyR020OSAON/sqhKEVWfB4IdXBJZRMdfaYQ9Su/h/0kkW/lhqhV/7QofzbpA8BVUY7ExkKfgIavLZ7qBvxqbWeT8qU03z8TLucrH4A0apfsR2BCnEH4gPtW3p1Fpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T7XmReP8vGqh78Fg1Q8nbRw4a4mosxHnhq3XVDrR3iI=;
 b=kY/hw6Riw26DS9RAmZoWyMjyXO73iI5NAb80d6JgFnVlVfjTHqHdEDEmBvUFtPzjQgr/soXHtoTq8jhIedH1e5iyonlcTe9Gu01xVbl0MQ7Lt31vPeQlg4ddjFH+wIG7b+mUWgpGoekDFr+39lxfbSAsTV5ALFvnxiGrlBitYthB8NvRp1YLP7aw171v6q4M98SHQ8aANv0Qhe7/Pkd00hDRi32CHSAe3rpaDMDgk/Oz0ezeMB9aWrNS9Vfc460ZO1Yo5j1WI0tmAezFTw8PTo63OxWYB8UN7cBlcwDI7D/9s0AJsWh1eEVOmPZ9v2eY4m5JocBEKksWeCO19QuSNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T7XmReP8vGqh78Fg1Q8nbRw4a4mosxHnhq3XVDrR3iI=;
 b=j9Rdfb2M46LsJd4Jmy4DKwKKsMp8Emr3DtkK38vLfigNZMv2D1QZToDQMLVg4kDRjebHFCeJ+ezijOzyafpW7bU8cRMn7Ujf5QfoJ2NGKxMNR0CteBU4+Zt878abNx6R5/xyXXoSuY+c/nfSe63tryEpQEkQQXkEDF0ZMvyev7s=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS0PR10MB6948.namprd10.prod.outlook.com (2603:10b6:8:144::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.23; Wed, 23 Oct
 2024 13:55:22 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8093.018; Wed, 23 Oct 2024
 13:55:22 +0000
Date: Wed, 23 Oct 2024 09:55:16 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: NeilBrown <neilb@suse.de>
Cc: Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
        Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>
Subject: Re: [PATCH 3/6] nfs: dynamically adjust per-client DRC slot limits.
Message-ID: <ZxkARHvnShXOQM+/@tissot.1015granger.net>
References: <20241023024222.691745-1-neilb@suse.de>
 <20241023024222.691745-4-neilb@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241023024222.691745-4-neilb@suse.de>
X-ClientProxiedBy: AS4PR10CA0025.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d8::14) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS0PR10MB6948:EE_
X-MS-Office365-Filtering-Correlation-Id: c807314e-5f47-476d-88da-08dcf36a568c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+Gfrys9MYk5Tld8Kg4aM1nvxGM3v8tIyV30fS8YHIfMnq9i+NIFW164ZXUbP?=
 =?us-ascii?Q?XZN0Evpop5Jc4K2hf5x9FnAvYKLkoH61sU+wMgLAfytOzRHx4ZvvYp3YlDUU?=
 =?us-ascii?Q?Kb0oP12JYIJg+fhKi76ax1JF56q94DmE9MdrZYvrAS1COLIzMyUFZXj1btS0?=
 =?us-ascii?Q?NBoEL2ioNLMqsEv4YA5hUR3hY8tgJDYZtVvwn81aXKQEqfD1fxaUQwWkKM1L?=
 =?us-ascii?Q?Pck+jtO6tnl9o1Yoi3ASWDujuMK/LCi5QWr6zvpDEXEdtxY4uUHu85PQpnjc?=
 =?us-ascii?Q?1IIne6RxQbBt/EElSgugge3i3BNMj4cRWgz9ujWLGqecAqqpUI9i9wEA/ZbX?=
 =?us-ascii?Q?II6/LpoNi75LqQCnME+aYNTcfnk34H9vbIejpOOeW4QkGiwGm1bhdDwzuYQM?=
 =?us-ascii?Q?Pw/KjZTa6w+kx1MLJBqctz0/Dn9wBlDPdYpH2Rjui0bbpwoUuyKQxoKp+UvL?=
 =?us-ascii?Q?1to4M3UthPK4GFo5YaGw5O7C3RbPiogilHjTBe7Zq0UQUgjKqhmsVYRZVVEN?=
 =?us-ascii?Q?fZYvFxMdz7h1A0jLeS0jc3a9TfFVENVZnVHHK3qTWQw1sx7YVvDqD3YJcIfb?=
 =?us-ascii?Q?lB1l2CKRuEyJQQXiW6WvbdM/YtTZUHbODj+GuPIXEAd93U22Koz2SDm4o52X?=
 =?us-ascii?Q?m5QZxRtmBWywvyjWvQljv1nj5jxWigr0iSw4fxwPU/55IywYX4BatrIRZe3N?=
 =?us-ascii?Q?fMKLyAokFv/cFA69qTNZQ9dh1FsHCRdO2pUa99+HVOqYNZztjDePewFmyhQX?=
 =?us-ascii?Q?LxWbuhW896ZEk53yq6l/peN++HJjg16259iK2EhKBwVfrCk0m1ufkV9E7e3Y?=
 =?us-ascii?Q?V2GkIb4PMuXFqzJghZPNsCrX3oZn2pdlmKKEidW87E3xCkme7sp5m+As7sWY?=
 =?us-ascii?Q?gqFOdocFVVBYV5pmiF4dq2SEaHt4UFfJC76MikHqB63cTzKQlnCLml7kNOeY?=
 =?us-ascii?Q?LASCRt/M6v/WnrASJZeFw5ZJOxVY5cU4K8WqpKOXpI9G+p+eopwgIEKO3kYC?=
 =?us-ascii?Q?aGlbXuaQU6CR9zOKNubspPCtCfjn+QCLjnCkrRMwJ9DEIVn2FvxeeZCY3CqD?=
 =?us-ascii?Q?RAvjblv5X8deTH3Row4SypVjLdB9AwTYPo/KUWdZEfXIhhWyA3gbo+1QS6aD?=
 =?us-ascii?Q?qYe2UzNT2Cl0rVWuAKx2Qx62cYotTwJrhy/z+kL7M+FUI4WXpd777aWoUiMu?=
 =?us-ascii?Q?mmNTUYUq3C/qmwtIOz+yLQxdzVjI5Hm7QwM9O9LxCh0ckQxvJvfVoG3Lv4iR?=
 =?us-ascii?Q?V0NNNsrhrzqqgbFxtSav99ZKJB2ALaPztl6bnlvvviuvRrrablUd7KmN9lUF?=
 =?us-ascii?Q?nLErKHbPEoE2wvCCho522uJW?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LLuJ8Ye5TeQ2dXxvPw0bTG65ZBCLAMX5WFcT7dSZI1oS1nTGpbaUmUszq7/P?=
 =?us-ascii?Q?hDs/YP+NdXvXFGRvcAcXka+7xQ9XfHeMDaFNIpxtCwkXJUBmqFbks1BKeaPi?=
 =?us-ascii?Q?hByQ5iD4Jo/Nd74WYKCuZnL+397NYr0AnhBv8nWFyrrgtwi9lOB1kNV28yFq?=
 =?us-ascii?Q?YfPM0SZpMlGYDs0qCe5S4rtNkMg7Gum0owlxbxiCdhLXm0W6MY5Zur5yWZoV?=
 =?us-ascii?Q?JTVlo2YuAKlmCzvqQJqNXTzgasJQmF+lG/z+U1d2Ifgq/+oYeMcoFX7O7+sf?=
 =?us-ascii?Q?uPCCT9SHHJGyTS03Gei57NxwVXKyHuLsjb+HS2FtehMXpkak3GFmq/3rM0WC?=
 =?us-ascii?Q?6MqiAp0xJBmITWp51PVzW3LyrNtgzLPTQk9ZP3XXfsBBuVuBKi6IXy66ueK0?=
 =?us-ascii?Q?lKlP04heHhAHAWTKUIRf7sr8VohqMQjHyUldZPXiaYfAdv41YLvaM69q9JxP?=
 =?us-ascii?Q?rFwFOMElX1KjMcdfKdjj2VBl4DMdE4CkB0U4w9k5Sk2oeqm2hR62jp2UfZfy?=
 =?us-ascii?Q?fCf6fXQ/ZAJn3U5D6WuRyxuCg82tFSLfhaAu2vGaebi09hWqWuujzKgY+NmW?=
 =?us-ascii?Q?miQcdrVjGXDbl4fHtFKGMNHsFTEz8iNtOk0KrLg6vuMbVuwhXZH5djOki3jc?=
 =?us-ascii?Q?tKxNo0TS31V2lGj/ob13MEQSrvLGmuR9lDIh/PdiaiOsXuCa5klAYqYrqvfW?=
 =?us-ascii?Q?g0bcfeiUEUef6HTUcB9c82kPsN0doY//QEGdCPwBLxEAaauVrX4fBjUgkWzH?=
 =?us-ascii?Q?+sGvlg248ANO5AKBQ0EO92Da/5shOXLJnDKUJqID2WNOgM3Ngr/p2l5YBTsk?=
 =?us-ascii?Q?oeneLzr44L1ccWWd6LRI3KQVR1yIdAr2Q+kpTNrZK9MVuJ65WFCbPqB+LFr8?=
 =?us-ascii?Q?kLkPAY1ZmqsUY1WrCIWC16WpcYKduDWPNkWPdlHdeUL97UCqG1/0TFen7aUK?=
 =?us-ascii?Q?gkmWQMSn9AuaFBkCCtIBokFZFGWp9yJv+3SfpqS7d2WGWGnlAwD2JjkR6b4e?=
 =?us-ascii?Q?aNqah3c/VdaGqZUfx5IjFVb9LsWO+ZK3Jpx9hf/PVW/CeDTNSRhTMtNVKaGt?=
 =?us-ascii?Q?6CDMfZxjuWJPLSy4lRQA3vkfaOxi8sS17Jk0Ct7CB8ORqQ5TBAP6di+QcMz4?=
 =?us-ascii?Q?EdEtPHGqlCd2Dg5eFFlVaV/NhTNI0mp1jzUEkVp4YU4T48Dh6YypCWuDyF2b?=
 =?us-ascii?Q?+9DjyuMA8g2rcuLNzN8pdPAX7Hdr4ztoG2ufCSEuznOmic+PbfAVLBqCTe3f?=
 =?us-ascii?Q?7QIKN+9bJ48jGuvXcHCVbFDYtxm2gY9qdlkgJIQEuWmPxYK+0nNkOY2VHrgG?=
 =?us-ascii?Q?N+S6ligIqLxU1lWBrZgMIR/2ncBOZeVKnOcmZJvMmuyWuLE0Akj8FuqUsTwO?=
 =?us-ascii?Q?+ZwmerXXebnrijqWRCnWjdS6YYgkxg4y5FSJ+Tqy0ZndET3tqy3BXVE03x1T?=
 =?us-ascii?Q?ng29dgHG7q8thBaIK6k8p4MjtxLrkUCYT2CYV19Joq4bu7hyMyeTjMLTPF7w?=
 =?us-ascii?Q?R0AGuV893g011PNYxAaX+fuXH4ByuO3TVrFl6HupN+8qmfXfDQ3nh3q8WwTU?=
 =?us-ascii?Q?v9vbtjwuqMjbpsUN8nUx/TTbo1NgeJFKC8bOgAC+vJXI5f/bvkd5UXmmSqGk?=
 =?us-ascii?Q?3w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	pjINniTU6qhA3oEY8bPfUtQpj3ikgMnjxwjLjdxXBWlU6tm7hapAD+k2K7u/wQ828m5KfmsJE5dynzfwQo2er6aVXssd3CphfBkaiL2/64N4CK3T4szJX+rg4RREzI8SbwRw8aOq7qNyE3ZP8d9ypUYIiS+8p5ihcVH7EHdY+L97BRc1+Lf6mWPkKZAQhpqUAucwmxV2WEI/092aa+hf52YogUq/sc+67wxA+Inw1/sVDad0dvM6O9UpwyVtEKy6cf4QngJGgcstdOlzkqnUfbnt24s+OIvG+RoiBY7+TOcXMIQju44Vyhj/G8t60T5p45JEbIUu1RGc4KvpB3Moc5vA3p47TTVtwluhNg/bp4XuwT7Vno7z6KRsZVCDIl0JkIpA03aGNJDtFjSCvIISLm6KYITT122LhwSBOj4I90+nmdzbZqPcVf3vFuMwDJJDmlDOp0oTVMeIvLl/ADgxQfSICwbVPBRxx6TFz3zc+jETtqbn0jlJg6sFUMtdBMUHiLiSkupgwCHwT1SxlxX4a3lkYSJScx40s7Z+LWhVABc43HOf6QgwF+ZZ9NNjLvYRAnfEti1hws/AtKe48Siqo+MEz1u+fMMBHZOhOKAYc7w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c807314e-5f47-476d-88da-08dcf36a568c
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 13:55:22.8011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UBlaw7eUwEV9NXSAxdR02pXI7E7oEEdxx934cmO8T+rSvTLziEp21vYA4/cHTfTVXnLpcJkPf0Azg4ZPawQUVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6948
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-23_11,2024-10-23_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 spamscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410230084
X-Proofpoint-GUID: Zf09LRCsJlnvdG80omN1QAAxywx1z9XO
X-Proofpoint-ORIG-GUID: Zf09LRCsJlnvdG80omN1QAAxywx1z9XO

On Wed, Oct 23, 2024 at 01:37:03PM +1100, NeilBrown wrote:
> Currently per-client DRC slot limits (for v4.1+) are calculated when the
> client connects, and they are left unchanged.  So earlier clients can
> get a larger share when memory is tight.
> 
> The heuristic for choosing a number includes the number of configured
> server threads.  This is problematic for 2 reasons.
> 1/ sv_nrthreads is different in different net namespaces, but the
>    memory allocation is global across all namespaces.  So different
>    namespaces get treated differently without good reason.
> 2/ a future patch will auto-configure number of threads based on
>    load so that there will be no need to preconfigure a number.  This will
>    make the current heuristic even more arbitrary.
> 
> NFSv4.1 allows the number of slots to be varied dynamically - in the
> reply to each SEQUENCE op.  With this patch we provide a provisional
> upper limit in the EXCHANGE_ID reply which might end up being too big,
> and adjust it with each SEQUENCE reply.
> 
> The goal for when memory is tight is to allow each client to have a
> similar number of slots.  So clients that ask for larger slots get more
> memory.   This may not be ideal.  It could be changed later.
> 
> So we track the sum of the slot sizes of all active clients, and share
> memory out based on the ratio of the slot size for a given client with
> the sum of slot sizes.  We never allow more in a SEQUENCE reply than we
> did in the EXCHANGE_ID reply.
> 
> Signed-off-by: NeilBrown <neilb@suse.de>

Dynamic session slot table sizing is one of our major "to-do" items
for NFSD, and it seems to have potential for breaking things if we
don't get it right. I'd prefer to prioritize getting this one merged
into nfsd-next first, it seems like an important change to have.


> ---
>  fs/nfsd/nfs4state.c | 81 ++++++++++++++++++++++++---------------------
>  fs/nfsd/nfs4xdr.c   |  2 +-
>  fs/nfsd/nfsd.h      |  6 +++-
>  fs/nfsd/nfssvc.c    |  7 ++--
>  fs/nfsd/state.h     |  2 +-
>  fs/nfsd/xdr4.h      |  2 --
>  6 files changed, 56 insertions(+), 44 deletions(-)
> 
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index ca6b5b52f77d..834e9aa12b82 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -1909,44 +1909,26 @@ static inline u32 slot_bytes(struct nfsd4_channel_attrs *ca)
>  }
>  
>  /*
> - * XXX: If we run out of reserved DRC memory we could (up to a point)
> - * re-negotiate active sessions and reduce their slot usage to make
> - * room for new connections. For now we just fail the create session.
> + * When a client connects it gets a max_requests number that would allow
> + * it to use 1/8 of the memory we think can reasonably be used for the DRC.
> + * Later in response to SEQUENCE operations we further limit that when there
> + * are more than 8 concurrent clients.
>   */
> -static u32 nfsd4_get_drc_mem(struct nfsd4_channel_attrs *ca, struct nfsd_net *nn)
> +static u32 nfsd4_get_drc_mem(struct nfsd4_channel_attrs *ca)
>  {
>  	u32 slotsize = slot_bytes(ca);
>  	u32 num = ca->maxreqs;
> -	unsigned long avail, total_avail;
> -	unsigned int scale_factor;
> +	unsigned long avail;
>  
>  	spin_lock(&nfsd_drc_lock);
> -	if (nfsd_drc_max_mem > nfsd_drc_mem_used)
> -		total_avail = nfsd_drc_max_mem - nfsd_drc_mem_used;
> -	else
> -		/* We have handed out more space than we chose in
> -		 * set_max_drc() to allow.  That isn't really a
> -		 * problem as long as that doesn't make us think we
> -		 * have lots more due to integer overflow.
> -		 */
> -		total_avail = 0;
> -	avail = min((unsigned long)NFSD_MAX_MEM_PER_SESSION, total_avail);
> -	/*
> -	 * Never use more than a fraction of the remaining memory,
> -	 * unless it's the only way to give this client a slot.
> -	 * The chosen fraction is either 1/8 or 1/number of threads,
> -	 * whichever is smaller.  This ensures there are adequate
> -	 * slots to support multiple clients per thread.
> -	 * Give the client one slot even if that would require
> -	 * over-allocation--it is better than failure.
> -	 */
> -	scale_factor = max_t(unsigned int, 8, nn->nfsd_serv->sv_nrthreads);
>  
> -	avail = clamp_t(unsigned long, avail, slotsize,
> -			total_avail/scale_factor);
> -	num = min_t(int, num, avail / slotsize);
> -	num = max_t(int, num, 1);
> -	nfsd_drc_mem_used += num * slotsize;
> +	avail = min(NFSD_MAX_MEM_PER_SESSION,
> +		    nfsd_drc_max_mem / 8);
> +
> +	num = clamp_t(int, num, 1, avail / slotsize);
> +
> +	nfsd_drc_slotsize_sum += slotsize;
> +
>  	spin_unlock(&nfsd_drc_lock);
>  
>  	return num;
> @@ -1957,10 +1939,33 @@ static void nfsd4_put_drc_mem(struct nfsd4_channel_attrs *ca)
>  	int slotsize = slot_bytes(ca);
>  
>  	spin_lock(&nfsd_drc_lock);
> -	nfsd_drc_mem_used -= slotsize * ca->maxreqs;
> +	nfsd_drc_slotsize_sum -= slotsize;
>  	spin_unlock(&nfsd_drc_lock);
>  }
>  
> +/*
> + * Report the number of slots that we would like the client to limit
> + * itself to.  When the number of clients is large, we start sharing
> + * memory so all clients get the same number of slots.
> + */
> +static unsigned int nfsd4_get_drc_slots(struct nfsd4_session *session)
> +{
> +	u32 slotsize = slot_bytes(&session->se_fchannel);
> +	unsigned long avail;
> +	unsigned long slotsize_sum = READ_ONCE(nfsd_drc_slotsize_sum);
> +
> +	if (slotsize_sum < slotsize)
> +		slotsize_sum = slotsize;
> +
> +	/* Find our share of avail mem across all active clients,
> +	 * then limit to 1/8 of total, and configured max
> +	 */
> +	avail = min3(nfsd_drc_max_mem * slotsize / slotsize_sum,
> +		     nfsd_drc_max_mem / 8,
> +		     NFSD_MAX_MEM_PER_SESSION);
> +	return max3(1UL, avail / slotsize, session->se_fchannel.maxreqs);
> +}
> +
>  static struct nfsd4_session *alloc_session(struct nfsd4_channel_attrs *fattrs,
>  					   struct nfsd4_channel_attrs *battrs)
>  {
> @@ -3735,7 +3740,7 @@ static __be32 check_forechannel_attrs(struct nfsd4_channel_attrs *ca, struct nfs
>  	 * Note that we always allow at least one slot, because our
>  	 * accounting is soft and provides no guarantees either way.
>  	 */
> -	ca->maxreqs = nfsd4_get_drc_mem(ca, nn);
> +	ca->maxreqs = nfsd4_get_drc_mem(ca);
>  
>  	return nfs_ok;
>  }
> @@ -4229,10 +4234,12 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>  	slot = session->se_slots[seq->slotid];
>  	dprintk("%s: slotid %d\n", __func__, seq->slotid);
>  
> -	/* We do not negotiate the number of slots yet, so set the
> -	 * maxslots to the session maxreqs which is used to encode
> -	 * sr_highest_slotid and the sr_target_slot id to maxslots */
> -	seq->maxslots = session->se_fchannel.maxreqs;
> +	/* Negotiate number of slots: set the target, and use the
> +	 * same for max as long as it doesn't decrease the max
> +	 * (that isn't allowed).
> +	 */
> +	seq->target_maxslots = nfsd4_get_drc_slots(session);
> +	seq->maxslots = max(seq->maxslots, seq->target_maxslots);
>  
>  	trace_nfsd_slot_seqid_sequence(clp, seq, slot);
>  	status = check_slot_seqid(seq->seqid, slot->sl_seqid,
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index f118921250c3..e4e706872e54 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -4955,7 +4955,7 @@ nfsd4_encode_sequence(struct nfsd4_compoundres *resp, __be32 nfserr,
>  	if (nfserr != nfs_ok)
>  		return nfserr;
>  	/* sr_target_highest_slotid */
> -	nfserr = nfsd4_encode_slotid4(xdr, seq->maxslots - 1);
> +	nfserr = nfsd4_encode_slotid4(xdr, seq->target_maxslots - 1);
>  	if (nfserr != nfs_ok)
>  		return nfserr;
>  	/* sr_status_flags */
> diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> index 4b56ba1e8e48..33c9db3ee8b6 100644
> --- a/fs/nfsd/nfsd.h
> +++ b/fs/nfsd/nfsd.h
> @@ -90,7 +90,11 @@ extern const struct svc_version	nfsd_version2, nfsd_version3, nfsd_version4;
>  extern struct mutex		nfsd_mutex;
>  extern spinlock_t		nfsd_drc_lock;
>  extern unsigned long		nfsd_drc_max_mem;
> -extern unsigned long		nfsd_drc_mem_used;
> +/* Storing the sum of the slot sizes for all active clients (across
> + * all net-namespaces) allows a share of total available memory to
> + * be allocaed to each client based on its slot size.
> + */
> +extern unsigned long		nfsd_drc_slotsize_sum;
>  extern atomic_t			nfsd_th_cnt;		/* number of available threads */
>  
>  extern const struct seq_operations nfs_exports_op;
> diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> index 49e2f32102ab..e596eb5d10db 100644
> --- a/fs/nfsd/nfssvc.c
> +++ b/fs/nfsd/nfssvc.c
> @@ -78,7 +78,7 @@ DEFINE_MUTEX(nfsd_mutex);
>   */
>  DEFINE_SPINLOCK(nfsd_drc_lock);
>  unsigned long	nfsd_drc_max_mem;
> -unsigned long	nfsd_drc_mem_used;
> +unsigned long	nfsd_drc_slotsize_sum;
>  
>  #if IS_ENABLED(CONFIG_NFS_LOCALIO)
>  static const struct svc_version *localio_versions[] = {
> @@ -589,10 +589,13 @@ void nfsd_reset_versions(struct nfsd_net *nn)
>   */
>  static void set_max_drc(void)
>  {
> +	if (nfsd_drc_max_mem)
> +		return;
> +
>  	#define NFSD_DRC_SIZE_SHIFT	7
>  	nfsd_drc_max_mem = (nr_free_buffer_pages()
>  					>> NFSD_DRC_SIZE_SHIFT) * PAGE_SIZE;
> -	nfsd_drc_mem_used = 0;
> +	nfsd_drc_slotsize_sum = 0;
>  	dprintk("%s nfsd_drc_max_mem %lu \n", __func__, nfsd_drc_max_mem);
>  }
>  
> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> index 79c743c01a47..fe71ae3c577b 100644
> --- a/fs/nfsd/state.h
> +++ b/fs/nfsd/state.h
> @@ -214,7 +214,7 @@ static inline struct nfs4_delegation *delegstateid(struct nfs4_stid *s)
>  /* Maximum number of slots per session. 160 is useful for long haul TCP */
>  #define NFSD_MAX_SLOTS_PER_SESSION     160
>  /* Maximum  session per slot cache size */
> -#define NFSD_SLOT_CACHE_SIZE		2048
> +#define NFSD_SLOT_CACHE_SIZE		2048UL
>  /* Maximum number of NFSD_SLOT_CACHE_SIZE slots per session */
>  #define NFSD_CACHE_SIZE_SLOTS_PER_SESSION	32
>  #define NFSD_MAX_MEM_PER_SESSION  \
> diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
> index 2a21a7662e03..71b87190a4a6 100644
> --- a/fs/nfsd/xdr4.h
> +++ b/fs/nfsd/xdr4.h
> @@ -575,9 +575,7 @@ struct nfsd4_sequence {
>  	u32			slotid;			/* request/response */
>  	u32			maxslots;		/* request/response */
>  	u32			cachethis;		/* request */
> -#if 0
>  	u32			target_maxslots;	/* response */
> -#endif /* not yet */
>  	u32			status_flags;		/* response */
>  };
>  
> -- 
> 2.46.0
> 

-- 
Chuck Lever

