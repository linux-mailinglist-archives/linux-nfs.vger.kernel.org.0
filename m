Return-Path: <linux-nfs+bounces-4028-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA14290DD75
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Jun 2024 22:31:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 758371C21818
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Jun 2024 20:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55BA513CF9C;
	Tue, 18 Jun 2024 20:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OUbnoI0r";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="niig353M"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9799C53E24
	for <linux-nfs@vger.kernel.org>; Tue, 18 Jun 2024 20:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718742704; cv=fail; b=OWn9ZiiDYOhkc35Awa58f5HrX+3b3lOrCkO+zNXkXaZDCAbAJfjFjpaNRGa1/5p2PD7wPicJ8nt5SOLeDVT/61Ipw0Krd6pzKiW8kw1ocKowS6zw2fF38LCRAbXWPjpVP5mz/AEFDX5AhdH8oJamfPvET5af7HO0zzvV256c7Tk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718742704; c=relaxed/simple;
	bh=zH1nibXcfesaOPPCRu+VVbVKr1ZiqZZU6lyeld+hsB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RxM9GLNlqvI/6Zgsp/Qj/XJCeSA2t9Ew/SrZXgAPfGZkTFMcJ4I3CdJ4kOUuTWQza/92KAp6Tp9JqJAr3sbfJZDYzhHc+uhRmiQBPKNWtnLSY7IP+DS48nAFNQF/nFIshxdx+jlMyl/OHzYdy9IPrPLMN08UgDZUurAO/4bjwlQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OUbnoI0r; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=niig353M; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45IIUtfw020963;
	Tue, 18 Jun 2024 20:31:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=7ti71/pn3l4t/b+
	H+yFGF+5XL/RSAlm/SSfSOASmgHY=; b=OUbnoI0r9XS9dj7G54r0bPKnvrCNsw4
	XDnTbaqedgqSt66kc9Gf2yGug7pW6W/oWzEhJSlI8P43erXjV3uD43talAjvAT6d
	3smPc3RNyLqFrmv+VlU2X21aNg9SA/KdFC6T13+NJLR+gSLA+ddFNl4R9wUy68Wb
	C86PlpOT5s1oUu3X+iyL/vQ7jMAh9mR1FRiyiEDdTT77WCoL13vumF1TUKVT0hVx
	DwL3NRrONd2M6QwANcl/+FLT3O4J2NlLhyYirU/+MrgYvHEWOS4ealZ5A0x1nj30
	57A/APsU2c2cVxiCvuiqgY37FWGOsb/LkXL8i4oZuHEvpSxAdv9SA2g==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ys1vedwqj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Jun 2024 20:31:34 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45IK4lAI034772;
	Tue, 18 Jun 2024 20:31:33 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2044.outbound.protection.outlook.com [104.47.55.44])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ys1d8nppb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Jun 2024 20:31:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eWYAjRm1UPqwFsLCrxZZDqGfifmJ3qotN8E/DXSLWE2MiI7AeDY3ijSVhvafLIAyqjej0pJHD/fXJq1IZKifhzQvXXJU25C46Oi8IiW4+pda5+NBGUTj3oZvejQleoBp5MI0USapxcIxQpipcdtyHy07GGrOWVdfxA9O4llepF4MPnkSr9WeyZzCUagCuKW5MnT1XO/Ds5GxwpcLo7deBg7FARu4XD0g+lWYkazA+smS3ywlj3mOOTEwwIKSkkrYjR8ffhe6a3etS5cUCUHd2QptmKgCMP2cuTlaiV4KJXRgoMKJ4xE7TCC2NIDop0l3sEY8Z3vXWmOE5kf2G27GWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ti71/pn3l4t/b+H+yFGF+5XL/RSAlm/SSfSOASmgHY=;
 b=VzleYZ2vb6WLd6fcz+5YKaG+ldQz64K3wL/EReS+VrR5wmVSVTGDglWNCpajQSDdFZRV9rB34josbBYvtDbxkGTGu/RGnJQz5NkNk3x10yqhCgI7l+dQVrYMazRa1oGPbXbE0hIO2lhdWTCo+EGuwLOVpbsInwhHlAFLqVSSWlkL98UWGDeb+NFWYk3US2AvX6o16cWKagQxJnS1kua2OlJrHKOT148u2BTY1SZJY7g3+uxQUDtUSjEdPYNybYb74w59nLwVOXK1xFYZx8IS5athAC1GVgk50K86geO+ajtIGFq2M2ZAk6P24Gb/5wObFkrnUWzTCM+WBqJ8FkrlEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ti71/pn3l4t/b+H+yFGF+5XL/RSAlm/SSfSOASmgHY=;
 b=niig353MIOgw7l0I0xnP5aNSmKd8/mQVmqLpXyjIz2fkuhCFS5XdgeLuZ9Lex9xygV6IwJD3v3CR5gVCpxCliKjCd4CnU+RNmfA7l4SHj0hDwYWw73DPludm3vThfS/PcsB3RrQsaEsasgEnmrLrP7KmgErQKqzwLlvJpi4Z0i4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA1PR10MB6470.namprd10.prod.outlook.com (2603:10b6:806:29f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Tue, 18 Jun
 2024 20:31:31 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.7698.017; Tue, 18 Jun 2024
 20:31:31 +0000
Date: Tue, 18 Jun 2024 16:31:28 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, Ben Coddington <bcodding@redhat.com>
Subject: Re: [PATCH] SUNRPC: Fix backchannel reply, again
Message-ID: <ZnHuoD3JrXk0ho8O@tissot.1015granger.net>
References: <20240614141851.97723-2-cel@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240614141851.97723-2-cel@kernel.org>
X-ClientProxiedBy: CH0PR13CA0012.namprd13.prod.outlook.com
 (2603:10b6:610:b1::17) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SA1PR10MB6470:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c98a612-edfa-423d-5306-08dc8fd5a375
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|376011|366013|1800799021;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?4NNXY61FZEe9Xy81dtY38AKIoc/73avJ036ALAR1i4D609OFrmWIM/Vo7Sy1?=
 =?us-ascii?Q?XA+01unXg//19TAGDumbLiZ+RV6EVOlTb5CX+5AsEQk46OgJFSdPucVHCgIS?=
 =?us-ascii?Q?lN9fgZFFtMOPHvrUIl7uwfpRXQlNrI+qePVUGpAAZvLpP0Yzx3m1CIWXoEMH?=
 =?us-ascii?Q?f5AKnbrJs/amBg1jo7jwv5Sx7r1piYWBN9eZXz5LmJ8NXK2R5fNxtik+qV+J?=
 =?us-ascii?Q?Eeq9mDwH0uoZE27JQHPq4d+5L4jjqHOU8B7pyLZBMa6LonhUIAStmCufoyme?=
 =?us-ascii?Q?BabdREOkPEhCMiP+opkNt0DE5S0qsODj5bCAkfBP7ZTRhFNcZYO+1KbtKWpo?=
 =?us-ascii?Q?GOgXFhM8ZOIHrEf3nEwUT4wQ2UcBmlmDY4ufuSMDe769H5lrA/65jjF4cd5b?=
 =?us-ascii?Q?QB5huF4yElKhW6I1+gy03EZFl49gMtzAmkI7ATMQbM8EZr2Bon5MBxfShASs?=
 =?us-ascii?Q?iMCFn3vf5O9QhUfe7svqLD/6Av1XOwfSo3zlTQQix95xJNDJBWgpG/Bu4ep2?=
 =?us-ascii?Q?gl4YlBbKr4+24Rlp1sbk+JWUfph+pp2+7uYIpX7un5I6p/MVk0H+3OQqSLyj?=
 =?us-ascii?Q?2lrZ0liHcri7Jc30hg2M1FbKElz87pZ36KVjZ1xPCL7cyCtkeK4EDFW6SwZZ?=
 =?us-ascii?Q?u8b5vdt0ONoaUh1fCt7HoHhykpB4Zltg9RHJaFy++hMoBLdFFLNarkBSoKWR?=
 =?us-ascii?Q?PJsYetOqtW4XKJPS+nMTPnyiXC3uIvcWkKygJOy86RZSle1rkvg9j+vp2ZnI?=
 =?us-ascii?Q?ezu6FeYLxUS6+ZL7H8JDch+XI0HBvsn/ErvOxfaFNwoVLXRKDgIeH4FSMsbm?=
 =?us-ascii?Q?vCxm/zB10Igl6kX5iOGBICwTUWMzdUoj804Kx5FDAi8UvdB7us/RfRC4sIfM?=
 =?us-ascii?Q?EL+Sv0gPfelyaNlio1IuzWXv1zDl5h76Y6tt+N+JC0bogbU7nIuHSRjBpE/E?=
 =?us-ascii?Q?f3ItqrEuuaTEcCguLKprOGF3Mn8f6v3v83qT0x5qmC3U335El/ytFGUHntfh?=
 =?us-ascii?Q?OOAHTKb/dES2t19MOOnXHQxa8uHwDgyJ2RamG2FFSVut3xtkWrfM56CS+xOb?=
 =?us-ascii?Q?yT2qG/dHDJthqn4xJYLOxiQs2A90Y3JKhJcvEBrfmL1v9io6dE1bfnCxamEx?=
 =?us-ascii?Q?5pE5I9uJP0Tgmpa6aNKXduNAIxr8IVY8/rHWaZIgyPs0MrYrTeyruZnazKP2?=
 =?us-ascii?Q?GjNTB1DS8PiX4Y2wBNmFUxaZvGVKvcKQVhHPiojlfqUZG3Gktq66xiEFuKci?=
 =?us-ascii?Q?1zWBDkTb30GLdFSSFxf/eRr+WOAkeY8AgVjF548WrpRm0QaUBP+Sa2DiAnnx?=
 =?us-ascii?Q?VwQ=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(366013)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?+/r9FcGhtzzA37acRqNYeMWeLdB+nSKulFw2vXWmug3BWQhgKirT2ObGHq51?=
 =?us-ascii?Q?+BAFRePZfKthMwNGfqMq7jQ/bwixzv+5uOLkBqOatlSlQaIHrPQy6CCLCtkJ?=
 =?us-ascii?Q?Rnd/gGr98tLNZ8/v/fZPqMcjD8eBG1uPy7tXIyiE7oo69/1STt2SDM7+zxCU?=
 =?us-ascii?Q?ivLeQcQJv9XKzuG7DeRZJhWQs77auMrosD2ORs8HFW6oevw5ADKfFVv4dTov?=
 =?us-ascii?Q?QAz50nA/XSDs6m9Ft5Xvrdbu5tRj+mBtRoBqb7b5GWYewFQ1EyF1iu5bplK1?=
 =?us-ascii?Q?t9Hfo8lIciOxCN+Tkbrnaye9GDvbIPe7WMdtLmoWhz7ZF1CMDCNb8xoitBn3?=
 =?us-ascii?Q?5PLAE6KHn5VL+W2p2Cwc4UJ2gtMh/zNOZNr7aLn+ugv4BYFLnEQE40KSJ4vs?=
 =?us-ascii?Q?sM6V+ZljVM/KlUl2QifnaYKQbxrLJGyBMb0zKwEF4cmG2G8NXjxikMuSvrnB?=
 =?us-ascii?Q?SleKD2qYCzB9tvVKbAr8SKnLsZ8SKmD6FJOWDV38eUjYB9IxDBFtJdEIHEeG?=
 =?us-ascii?Q?B1cBL6EKMK3q6yVXyEhBK4irBMaRQUl1+iiJ8YyXhgNV/NhDk2U9+cC08q7e?=
 =?us-ascii?Q?rh3xMJlFuNiMlIkqZJCkiQaaDbts6+8Cs479hSpm57GlXcfFvMQ8BHgtZ4o9?=
 =?us-ascii?Q?SrUIfS0FPvsVraxN6P/qkWnp16Uq7AzBxLJPJMyw/xJAIJagfZnfuDvxGsd1?=
 =?us-ascii?Q?5V7uR4vUmZBB1r00OWS6ies8q5DueUL0MhQGCpCYVQyzF7SgycdUN4Fz7auJ?=
 =?us-ascii?Q?MRFN0ctgk6EbpcsEKFiXOTfnotwXPR3JMhSBaOF9YPW9QvcL4I77r05SehQb?=
 =?us-ascii?Q?u8BYKLwQ2nyafpUQcq38ez21nQwYaRR4J3acK/QL9R/y/V8X5jMHaJld7U4d?=
 =?us-ascii?Q?NtGgabDUD3fxQd74jAysianvAnkwN1YuX1QKvl6oEotxCRYKD0GhmQ3Pra04?=
 =?us-ascii?Q?sqCguxloSW9W3WoL3D+RF0vjckzRilKBg0dfnMib3Aae1pqT7bDPfe4fF8LP?=
 =?us-ascii?Q?4HL3+Pylh/jAPadLlUr243GG29AOA3lawEIhXv1f0dpxwzYdJMkGzHkNIGks?=
 =?us-ascii?Q?wdqQDv2MHIYaZRFjNX5RQvz8bbeG33K5fcovhigL8nUKVkbQOKvnIZgwnTQW?=
 =?us-ascii?Q?iSKgIs2BqjRen94ELLEsctssNvA12So053Wz5jI8ig7pQj2goZKuMRvqnPaL?=
 =?us-ascii?Q?Rcdlsnl7G0D0DrF1XMDhE84xIcHk993LGJQR6QzBcm8hR/NmN93MR+fuZVbk?=
 =?us-ascii?Q?Rqs590DDypxuQCjLKLdr20SUu917C9B/j4FnRWQyqUSVwSyfCfLnVl7eHtUX?=
 =?us-ascii?Q?qR8Jd5i+2/47QvA8gS8u/AU5lK5IRUUfKSKefmuw9d/IfbgpDWKhJbb9cPUb?=
 =?us-ascii?Q?um54JnoxLin5tgKXGfx7lklfZ08JaeE9KWWnrMZ6OoEivM3nF4aKHACNiklZ?=
 =?us-ascii?Q?+Vy5nHyIaNCEVNwQDCvgyI+NVcO1e5L1s6o7pmZUQ008pZ26bLdJlqPRHuzX?=
 =?us-ascii?Q?pue+QqSN+oglF03tgmVzaKu7VWonDE9hbRxE42wTn4mrb7NJ/MPTH923LrTN?=
 =?us-ascii?Q?Y6UWFjTl530qfbEuJfMd/8ABUqEIjGIkWWzUKbXIzrekEXzT9kd2DFmADWGT?=
 =?us-ascii?Q?BA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	u77K7IgLM0W/ECeYSVWyPe0VOD6tKi5y03Uc1uvgM/j1B5s8BUZkyQW8fNDVDdC/LCaqshjP7mWrJgSy5Rg1DjaczUwWcD3jZLj8r7ZOnlDXGe0odFdYgMdyKTSpFtnfj87z2NqWcPEW5kQTJDUnL6W3rWHjmDfDaQONoEyhC8IuN/9ku1iR+jYmatipxCoiW/UT5duPKcFpSW8IY+4DyHTtatCjILgh0c9w165GzofmXuQ5OkO3wjQdlh7Qb5+Hsa59dN7aq4f6xTzSs5Gaz4Bu97A0I4v3cW5PSmGs3qMcXsjTnB/luNrXYKZzbv7ul1wAd3WunqdF1PyOBHkkpzXoHmkMtgcuAOTMpsRUCj0Sq/+V4FEGE76YI50PaHmzFqDFxa+6rp2UOzaDu8MS0J2ifRWP8vLTHuY/4DIKgCt7jEVo1E4Zmm+I80aHA6deVvu8PXMPXFrv4zUzSCw/mSOTQ52X/gBM8cPV4S8cyljYapNqOx9Ge3OrMPoYuJcZ4CMwImtOs9stErscaW/GFrofJHQwcx419zIGvh7RxqKSWijC2EsPURq/CSNKHXln5jEq4MgtH6Fo8iTV5FIft2ZTmvtzBbYG4BBkhIdd43Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c98a612-edfa-423d-5306-08dc8fd5a375
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 20:31:31.4626
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U1PslbACL58vdOTxwyHx0392tel3cu8/zxydQaP3gOq4A/od0pIqqftgd81o8YFhP32jgzEVO+5Iowv32PTfqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6470
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-18_03,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 phishscore=0 spamscore=0 mlxscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406180151
X-Proofpoint-ORIG-GUID: y44ihXYUx9EO6onUyvXtom-k3LJ4SiWI
X-Proofpoint-GUID: y44ihXYUx9EO6onUyvXtom-k3LJ4SiWI

On Fri, Jun 14, 2024 at 10:18:52AM -0400, cel@kernel.org wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> I still see "RPC: Could not send backchannel reply error: -110"
> quite often, along with slow-running tests. Debugging shows that the
> backchannel is still stumbling when it has to queue a callback reply
> on a busy transport.
> 
> Note that every one of these timeouts causes a connection loss by
> virtue of the xprt_conditional_disconnect() call in that arm of
> call_cb_transmit_status().
> 
> I found that setting to_maxval is necessary to get the RPC timeout
> logic to behave whenever to_exponential is not set.
> 
> Fixes: 57331a59ac0d ("NFSv4.1: Use the nfs_client's rpc timeouts for backchannel")
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  net/sunrpc/svc.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
> index 965a27806bfd..f4ddb2961042 100644
> --- a/net/sunrpc/svc.c
> +++ b/net/sunrpc/svc.c
> @@ -1643,6 +1643,7 @@ void svc_process_bc(struct rpc_rqst *req, struct svc_rqst *rqstp)
>  		timeout.to_initval = req->rq_xprt->timeout->to_initval;
>  		timeout.to_retries = req->rq_xprt->timeout->to_retries;
>  	}
> +	timeout.to_maxval = timeout.to_initval;
>  	memcpy(&req->rq_snd_buf, &rqstp->rq_res, sizeof(req->rq_snd_buf));
>  	task = rpc_run_bc_task(req, &timeout);
>  
> -- 
> 2.45.1
> 

Hi - would love to see this in 6.10-rc. Is there a chance that
could happen?

-- 
Chuck Lever

