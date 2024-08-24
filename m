Return-Path: <linux-nfs+bounces-5699-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90DA495DF91
	for <lists+linux-nfs@lfdr.de>; Sat, 24 Aug 2024 20:23:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47D1928251C
	for <lists+linux-nfs@lfdr.de>; Sat, 24 Aug 2024 18:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48FC159164;
	Sat, 24 Aug 2024 18:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NMq85UWc";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nM1qaT45"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370D2320C;
	Sat, 24 Aug 2024 18:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724523779; cv=fail; b=liK6lPMZFOLrevGzNe4Rb9M5VVhPLjCM0nRu8aTdmY10PfHKyDVDEndJ+gtAoXUUA6ezzB+F8oo6XNAadtTody3LCclwKLLsnnmV9PwIPP1tc5NIC75laTd82OZ3tjPye+nn8cn7wWvobpTKOasbQxXtl3LJKBGBJnVkTIXnygo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724523779; c=relaxed/simple;
	bh=vFYC6E6LlrLJcNUjWBWTxXYl9QuT8SrxlPEDArZO8DQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=to1XDXac+8UHie2uBpLzzaGrHY56/t3aRn5qJJRIebRVxg+Ezl4xnvbJVfLRwynTHaQsztnQZTw+eYSrBghSJTr/2wRiIriD1yF+5qTkVgUASWtjO42jVuqQO5TGJ5wSaVvS2IrE6mH1tkZ08wDtw2e8+3dgELlcUW+xYVH5FzM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NMq85UWc; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nM1qaT45; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47OGPxBk021132;
	Sat, 24 Aug 2024 18:22:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=7cPl0cc0G3whKe9
	6y0YDrDqyruUVsj9fW3Q7LQN0rSA=; b=NMq85UWclU46KWisJSGn8avrEv72Jsg
	9gamSxaRA0m/qk7IrR93X4/cPrzpJjNlO5580SlsRuXY8lBIjZV+kzUcxo9tEWne
	7aGJrncPxEnPPpwn+n8auNZOZ3nOQqFTru6vA1WENSbtifMimJQTKHdVtPaNqiN+
	43zJY/cO3aGToF+XUq8jqE/+LKKRLtwsVHo7kMwWkQ+Vgs0e7Q1PnSsvHWOyveIn
	dERqtFRJ7Gt/YmCh8R/etisUJz3BdKQRy/eAj3ECB3v/A1Pmnm2jbDcG1tvcVRrl
	eDx8XznB41BRQvPp3fjpqGIczcAcCMv4EkOHyXt+rjJ2mYmqKThCrWg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41782srhkb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 24 Aug 2024 18:22:02 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47OIJfl0003817;
	Sat, 24 Aug 2024 18:22:00 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 417mpur2gt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 24 Aug 2024 18:22:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uCj3SjSkXAbdZ9RkRwZZmp6PRoQsspHG62s4uaGVufoFjQ241ro3pEkmX9RGc52QXZzkNgngDxLz6/NDMAHQ9oUelErWC97VOc/JQx3xV5FlsKk7oFsg1erwQR0DEtf8bpacZMoLmZFjwgDJOaOKPXRjQNN9pE6neMbCTKssqny7ApHZMr+UavvNtoaagSQ1prf599mgUn57YoyOPvivFo8T/Y7s68GI8rMMdZYQxI5K0x4L5dKjGwAFLr1jqA/Q2S/SlWT16qQpXxOMiiAFfIyLFwC3D8JA6fqXT2BAzNVOTCQorpIM3GP98ImnLAws8IUKhaJLY9Nqziq8Qg6cgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7cPl0cc0G3whKe96y0YDrDqyruUVsj9fW3Q7LQN0rSA=;
 b=WMt6mx7dQS3bkzzYry/yuatJHcsW2FPUujFegCr3qBmW5br9uIjka7j0nBpz54YKP26xO0yU4zAlKNZs8t8T/oWaKPQDGCi4rrbEakf+qJnjQY8rUKDYyBOkj+aDL3ryyhMlB71dCEFsDhpUORaMs+lMMUTrMjExt8ZyqO7mP+juH9LECq9djgPhQKmriXXaLjMO1Bwzm30keaWwbiE7l3SiXTT90M+XjhZ91z2UXEb3MchSMv1iJGMVpIBV/wd52dTBaDM6QxyYEAckxvWEu79pnAIcswaoiHS/XXHcD8QAqWacBonZIytXhiG4Lp+RSxv51jlY9YE/xnLekj8f0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7cPl0cc0G3whKe96y0YDrDqyruUVsj9fW3Q7LQN0rSA=;
 b=nM1qaT4500a8C2OrLjcx7kL3xp8V5an20NxfUQEmX+dKDIuRx0o5qLQ4h4qufqk93qXojqeVIdevjv3nNr1E2VLnuFWzQqN5lw7oPSqNeiK0zbsKFUsMbFep+HwfjRDAbTlhEYclw63wjSZ/BoZUNY0Ai5rjTNdr8+UqlvsjxSw=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MW5PR10MB5737.namprd10.prod.outlook.com (2603:10b6:303:190::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.12; Sat, 24 Aug
 2024 18:21:56 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7918.006; Sat, 24 Aug 2024
 18:21:56 +0000
Date: Sat, 24 Aug 2024 14:21:51 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Simon Horman <horms@kernel.org>
Cc: Li Zetao <lizetao1@huawei.com>, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, marcel@holtmann.org,
        johan.hedberg@gmail.com, luiz.dentz@gmail.com, idryomov@gmail.com,
        xiubli@redhat.com, dsahern@kernel.org, trondmy@kernel.org,
        anna@kernel.org, jlayton@kernel.org, neilb@suse.de,
        okorniev@redhat.com, Dai.Ngo@oracle.com, tom@talpey.com,
        jmaloy@redhat.com, ying.xue@windriver.com, linux@treblig.org,
        jacob.e.keller@intel.com, willemb@google.com, kuniyu@amazon.com,
        wuyun.abel@bytedance.com, quic_abchauha@quicinc.com,
        gouhao@uniontech.com, netdev@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-nfs@vger.kernel.org, tipc-discussion@lists.sourceforge.net
Subject: Re: [PATCH net-next 8/8] SUNRPC: use min() to simplify the code
Message-ID: <Zsokv8+9aDoR4uOu@tissot.1015granger.net>
References: <20240822133908.1042240-1-lizetao1@huawei.com>
 <20240822133908.1042240-9-lizetao1@huawei.com>
 <20240824180750.GQ2164@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240824180750.GQ2164@kernel.org>
X-ClientProxiedBy: CH0PR13CA0011.namprd13.prod.outlook.com
 (2603:10b6:610:b1::16) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|MW5PR10MB5737:EE_
X-MS-Office365-Filtering-Correlation-Id: 76648766-4635-4798-ec9e-08dcc469a30f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4136ueQrxDx0/yIefK8heEayRxgkzQkYNQ2tfv79H3TJdcJJUtOwWwaNN0ur?=
 =?us-ascii?Q?KdpdEIrT2PvBioNhteuxtKuCD6VS+LYEIwcZ+7FxrFkcw0qWmMMGiiqYiDOd?=
 =?us-ascii?Q?+q452bS8yCo36WuY+ougLjPskpVsT0VPd/VDjjey8WshWK58vgWLDEvMACEP?=
 =?us-ascii?Q?oR+X7bHV6O854Btue2uKFAa3zsTuInoUDGAzOX625mCg3NUm5rlXF8tYMrpt?=
 =?us-ascii?Q?9AzK9hESLUJT0JUHi0OuCjDUdN7uiBNCn51CA/iAvLmkS9Fm9ASDH9Pbyu6Y?=
 =?us-ascii?Q?Cse8ivLdFnZy392TQr4uNMruyvWVannyIbZiKZdqSZIbzCeO6RhuEP6DqYEO?=
 =?us-ascii?Q?sEb2UvwgrA5i8PM+2V+QuZlq/QWGnwp7FFyfat/ckaUhJMgm9W7FaiyPRXFi?=
 =?us-ascii?Q?ULu+san6IwkTwVPYCF57wkLM5X8pmDC0Z2SqIdhVWeLfxAUSBmiReFEovTz1?=
 =?us-ascii?Q?PbKT/UkrJVyW1gWuvsLFwjjbQn3fhRt/T2IwqZaWtIi2tlm0IZq0MEpwAHCC?=
 =?us-ascii?Q?thVZ9CMRVJLiGSzMKzK3nIwaRQy8ZnMw5kteMTPaAYvPfMUTnuAscGwkLsUo?=
 =?us-ascii?Q?a/tI08S/kZn9KZlkWtTfIAgePTckcraep2KVyM5Wa4A76NsbAJa1Z6pQWEIz?=
 =?us-ascii?Q?eG9XAfe0jIbnZonbLqu+m4CHLhsMf6VWTs9toxravjozG0nCzZMLHah0Re7f?=
 =?us-ascii?Q?WE2lHRBUmeKOoYXCsihiUlqKHVTRe6UKGynfxKnNuWNRlx3KwfQZ5E60EUm7?=
 =?us-ascii?Q?x7l25K0m2Dd1kaC7uDWfpl4XzhogVmIMignOmA8+Gq7X/GMQIiJ5IjuE2WBm?=
 =?us-ascii?Q?Gytq8b22RyfIor0LVddRqitroIoA+9GZhRvEDPVhBcH6KyCtkn/DAKMLjlOa?=
 =?us-ascii?Q?LUwNPEyGKWl+vlHFg2pw8ah7ecVFZBZG9Sylt11sZsWEvWmKN+8NodQzVW0H?=
 =?us-ascii?Q?/sfwoP4XQTkeM5iJFgJXxhVbAm8iABp5fgARlvJPkVv4fXpfKdgcK2ViHQTu?=
 =?us-ascii?Q?wZ39dWi7ovtRpCiUU4xrOC8PboThcn4cxskTgzkm5pjQDlD1irLxFi7b6sBC?=
 =?us-ascii?Q?bP6Cvg34PdDe8HS704zZrOA5MHF9UZPfLeJM6zPOfLvThI7DPQMZS6+w5hyH?=
 =?us-ascii?Q?5ttMpCAf7oAaOdIajMzygCnuiWNDr5pskENytoCUO4aQMVn0WqmmZ+La478Y?=
 =?us-ascii?Q?EIaBY8j7iV74HQocaS7xKerN8EXJHbyM3+SvNe+zSn/I6PA8c+UYpHDX3suT?=
 =?us-ascii?Q?ObUhlSti26oZP+GJVPr3+Lrly8NSSEkwugqXyzU4HrrHOtVRlZnBZdcsT74Y?=
 =?us-ascii?Q?hHYqdCQZHtv90VIP2SJTiUvL2LFJ81dK8H2ypCL/VrqP3g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?98aOuh9xAJnxCf+M3+8HQa64KoKG/m7of7q7wlgo+E0g35WlO6jqaiRWmX/M?=
 =?us-ascii?Q?s3349rDBmiLi8uB4zOE7HDbi6SQHntdD+OlV/GzU5886j2TTT8ZCJ9/mfpdP?=
 =?us-ascii?Q?Y88AqnMtwddVtKUzE1uegYM5eKaEB9fAtpDexSroa16yMN+Z2K7mIb5v2obs?=
 =?us-ascii?Q?7opyN0FdEqyW2ZY1ZGwYgdfEsZMb/pIzRTTUBAcN69Bg03fH/d7yJIV91wlg?=
 =?us-ascii?Q?9xBYzUj29uQB6AujK/Te+g3m10msB4JluCl1qZCMUpmcexBqbvgXSHCppsMP?=
 =?us-ascii?Q?PIHt3w/8uBi4CKVaPdQnNuKV3VsXPORO+4CqMIAXSHlMs12wzieetPD0NLeX?=
 =?us-ascii?Q?pOkXm/y5XjjGO9n6jfI4TtIJaSUm1zD7heiPkvZAW5TGDO8ka8NY6Qv3YN2s?=
 =?us-ascii?Q?tYprUghryFNj4TV+V0jjnd+s3q2oJhft1kKm+huRXlv0gaPV3APDHvgT0ZDV?=
 =?us-ascii?Q?SVtsswr8CoxBSbS5elEmjhvd+wtjGQjzPjrnTqRhIonz+511GPmTvpzpyteD?=
 =?us-ascii?Q?IIOWhUqtI27GWR237K4cqvqTwTQspOOi8H6VDumB5dYwhcSsfP2OfipPAum0?=
 =?us-ascii?Q?HLzL9y4WxP3NMF2Zz6rCY0cR/r4/uCVUHl/za6StmBtVQ6Cz4PTBbfqrDToD?=
 =?us-ascii?Q?z1mEBrDmq/kgin/q5mhkfbz6IpaaUqjb9sZQ3+7DhpTGUPeoNSA8M5KrYnOf?=
 =?us-ascii?Q?Cr9GVq0c+llqvuUFpNiQxiwnJhryemyljJcy8J6Cay7hb+MCnJve0y7cnlQf?=
 =?us-ascii?Q?KW6kTRCZ9exBDhIQnVOs2mxMO7Qgr3aEomsjunsh/NMLm0izOjC4JtrVqQCn?=
 =?us-ascii?Q?Oq0DqfMRntE+rbd6kLyY+Q5+JFVEE78y2vQJutGYVoJNuPPKNHCAQMn0wd+a?=
 =?us-ascii?Q?fd1dQBTMfnUpMrCe11n/94YI8P8G26os/iHNaIcj+q2WiSTwuIET5d+5tUC/?=
 =?us-ascii?Q?oI3ZRWjcEX7TRbMPMzeYwJhTVLcCgclEKwrkg/fd2ywugQxtCpKfyKEE1ioT?=
 =?us-ascii?Q?mQ2An3aDfXORxaH9SXm4Mc+TpQyFq/1I8ZuNlnGT3gaFuu8iaAYpsOzjKeDZ?=
 =?us-ascii?Q?ynu5+xxJyPK4rZqA4Y6deKvHrORwlf4yskhiAjJTc45rJ0vSaIJfHCi4WdDA?=
 =?us-ascii?Q?FMzxhZ0+v8JO8Wu9ssQsNZ2157zA2S55ijXKbYoMSnaGVd/vZbazt6L94kxR?=
 =?us-ascii?Q?gU4mTXV20JDjL6IiKeUnkU0PkQ5SznkbBvmcy0XdiApP8S5qu/yM+6So1ZLN?=
 =?us-ascii?Q?8/VpN6H0s9RZO9okqBnE03m6jv5MWXD5jSLsIPow7uLf479hnb7jLz2ClXcg?=
 =?us-ascii?Q?JZB87UxmEMr/H1/J3IbK6rpaMdf9LOrm2iPuqnbGzDWa7XJZDyj3YOMnVmN1?=
 =?us-ascii?Q?v3o7FuvyOLFaMXy9yhAt4+5CcgZNtgEQtKma+9WQiYgHStQgorRktH2Isk81?=
 =?us-ascii?Q?k2Gw9MYY2SxMtpoF7A+vT8BatL9RWZ6gVtZ8sgVpIcCQzHoF9pKOlvArYBNm?=
 =?us-ascii?Q?NvXfY/jDjkX7iuE5JqYUiN8GJhVuBJAFUM0MJQ86s1LDFZN1zJLQx/Ha1g39?=
 =?us-ascii?Q?T9C9JK0++IAtyhr9hYJpW9wfhJ/Jo3qghdhXHoJ0tBtameqFEURyKLftrLYM?=
 =?us-ascii?Q?Iw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	06SL9bbvuTDqopwUMyfZ/4wFM/PB87KrTsbpbOMoC8X1GZiMhnOVc1Uu7lyq/AseYpAiAkHzbyc+ejI1LIaahV6LTC8erN7ZUb5IIcHzPyIYt2N02eXepluVLSQTzQ05t3A5yW80HN+0Eh0g3MpUzGtiXwp8RuOkHaCHq5zYajq6vTh9HOoUfiXxdoG3LbBMMkf3549/BucfrGbzDiksTdHPhBczTasDTVF+UlU/w6kLeUCuXGLp8Gl4R/gMz2hL6HaEO6uqV1VfVX06S0iINb0XQEiptZdjG0zm4W7xMLHMMWeItoX+IT1M3AsK8QPnozLyCjfyIdBJviF1E9SbksgI/m79c5b3Xuaf4iBuGhFiOON9qsP93jiSXx2582NdukS7cnpHYEghqpdi8H3GjBQbzU7p/JmoIiaBBq4omLhMd7Wn6hsItdD87a1PUs9ukLDahooR2gFiyN5FGUjrq39PobDa3DThVcQq/rwV2hcg7mgqhjDZg0BAz2mqBCcyWmHzngv1hHYDKGlA980sfUF6hu+daSF5VHF3QoMaPmNWjkwIZpLWIrHHNRgSM2rFGYFBHwTSIglqKY36SDL2iLO5hnKfFVtUhtLt10cp1oY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76648766-4635-4798-ec9e-08dcc469a30f
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2024 18:21:56.7508
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fHErgyxG+wQEb2wMiNHT9TCm1BGYJuQKsJ1TGW12pX1kqcUawHRkWueW19l2gBscsKlPrNF8OVJePOMZEhJdIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5737
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-24_12,2024-08-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 adultscore=0 phishscore=0 bulkscore=0 mlxscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408240119
X-Proofpoint-GUID: 5YcuhBJHNm_90jhW5slEj5rD_TzMPsqv
X-Proofpoint-ORIG-GUID: 5YcuhBJHNm_90jhW5slEj5rD_TzMPsqv

On Sat, Aug 24, 2024 at 07:07:50PM +0100, Simon Horman wrote:
> On Thu, Aug 22, 2024 at 09:39:08PM +0800, Li Zetao wrote:
> > When reading pages in xdr_read_pages, the number of XDR encoded bytes
> > should be less than the len of aligned pages, so using min() here is
> > very semantic.
> > 
> > Signed-off-by: Li Zetao <lizetao1@huawei.com>
> > ---
> >  net/sunrpc/xdr.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
> > index 62e07c330a66..6746e920dbbb 100644
> > --- a/net/sunrpc/xdr.c
> > +++ b/net/sunrpc/xdr.c
> > @@ -1602,7 +1602,7 @@ unsigned int xdr_read_pages(struct xdr_stream *xdr, unsigned int len)
> >  	end = xdr_stream_remaining(xdr) - pglen;
> >  
> >  	xdr_set_tail_base(xdr, base, end);
> > -	return len <= pglen ? len : pglen;
> > +	return min(len, pglen);
> 
> Both len and pglen are unsigned int, so this seems correct to me.
> 
> And the code being replaced does appear to be a min() operation in
> both form and function.
> 
> Reviewed-by: Simon Horman <horms@kernel.org>
> 
> However, I don't believe SUNRPC changes usually don't go through next-next.
> So I think this either needs to be reposted or get some acks from
> Chuck Lever (already CCed).
> 
> Chuck, perhaps you can offer some guidance here?
> 
> >  }
> >  EXPORT_SYMBOL_GPL(xdr_read_pages);
> >  
> > -- 
> > 2.34.1
> > 
> > 

Changes to net/sunrpc/ can go through Anna and Trond's NFS client
trees, through the NFSD tree, or via netdev, but they are typically
taken through the NFS-related trees.

Unless the submitter or the relevant maintainers prefer otherwise,
I don't see a problem with this one going through netdev. Let me
know otherwise.

Acked-by: Chuck Lever <chuck.lever@oracle.com>


-- 
Chuck Lever

