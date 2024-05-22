Return-Path: <linux-nfs+bounces-3336-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB25B8CC2DE
	for <lists+linux-nfs@lfdr.de>; Wed, 22 May 2024 16:12:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82AFE28542A
	for <lists+linux-nfs@lfdr.de>; Wed, 22 May 2024 14:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25F4D43AAB;
	Wed, 22 May 2024 14:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="M+cUjXvg";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YI6WqLVv"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048801E4AB
	for <linux-nfs@vger.kernel.org>; Wed, 22 May 2024 14:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716387173; cv=fail; b=qh/YDrhPtZi1LWOJs+HDI8ZhMXxI5GVmoAn/7pot9IUpA5RwxALHcE7cwRYfvvpu06/I5JXnFrtJA+ST21ox86N+fePbeayfP9RQdbLvPR4EKvBQOBAMkOW8Wu/+j45WAuACX3R15rbmWLIvyEqC8/ISfxKYxyDTgAwMln6mZEU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716387173; c=relaxed/simple;
	bh=ahay91OS4fS08KUXp4Bz7fw5rmFzLrbTYCqiIlU3AMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hDiR06yEa64mvIyv86SM9m9JToZnDMPKiSMYTJT7s73dN0AtkmPurLObx5NSxLSPa+drc/pre3wiORIinLkh6iGp8AEnRt0bHqnbqbal/RW3ycevjhuRJQFcBVyO3QBtfMPzV1aYbqumILSwneRaXaTAJJVUuHmGOsK0yvaFayI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=M+cUjXvg; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YI6WqLVv; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44MCqlV4003039;
	Wed, 22 May 2024 14:12:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=CnulVL/z5un6W/cNWjVZehMb1wvV69NFae0eLd1A1jg=;
 b=M+cUjXvg4DNZCvLm3rzS035jbVh3k3K2Sv4r8CaWGOWroG90koYC/yQtDZJ7nrakH0YR
 p7rOmEI92IYj2nI0MmmEXpKc4mUX4QyIbDcLox4u03q+jI4fe15CMyIJB4pZKVCBqloz
 v4sAQvUQi68m+VBtfUKGVru9eUR0P/bu2hHzWU/l0zHKZXbwj+cDw+yOGbraIzXMc/zZ
 uJFaq+gbA7w933ZeiDJspvyBfZbkL35WaU/1WAoC114xTMKajA3qV8+dtvNqIL0qgp/X
 ZNNB6l9e7xDjsr/cffIQEYeWfGwMwA3YgXeUJ7sYh0X81V1DDOG95XUHZ0PG2OcbNJc/ Fg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y6m7b7jkc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 May 2024 14:12:43 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44ME2xUt038368;
	Wed, 22 May 2024 14:12:41 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3y6jsf8w0q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 May 2024 14:12:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M7KW2fMMW1qy0t4TuL7JO6RrzmFL1PCOiB2lVOHlSVj9DaYsp+E4YirFuUTSQmFufnlWuG1Tp//izW57km1FR0hfpQlQYPlbdqyqWvtmkisMmdVBfUuWlzKW8KvkYqqqN7rkavfTF0/nSGWerIDMVzA5op3cAPDy1eiJ0zwB2sh5QMIShRjwDJnvnsFwl2CK7iE9v/VuM9XQQvKfgmvjNqpfqk5EwHW7J/vw4jRAvIlwCXqAAP4li1J4uSEg6a7w5youwxSZ3ZifD6RuyWUQuJ53KGe10B2vLGUL0QIH2pp4ZBdDVabXcA2mvdmXJTjvlEzQeGjAz2NpFIPiRh931Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CnulVL/z5un6W/cNWjVZehMb1wvV69NFae0eLd1A1jg=;
 b=VlUcQIWi4TnQQwv6lrNVmBuTS+NNYJXjbBbjE/cIjR4o5iJmywfvNdxwrJg3OuTKsCe7fcVjUiLNvYJxxFGAcjlAE8GZGLRrH7fKXGP1HV34LM93e7RgnbcH1CAcBsw/PwtELpFHwZmqyuDt2VEtpsGLpxsI9IDpSEnAabd1BWtQ40oY8U+EB+OS/W8U/arxfLVttopEBzAXsrnltow7wMETobuyIvh+bxOdIvZXvlgiubx4D50yBCpnIt82ZzVtisq3tFqu3mRc7Eta5MwpzCp5lTrZ8dM81Wr3tOwQldCkbxFIr3QnuQ79tEGW3UqIiRYxn2onnBoRCZ2jSH479g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CnulVL/z5un6W/cNWjVZehMb1wvV69NFae0eLd1A1jg=;
 b=YI6WqLVvR5QfM+RzI57+4/41IN3IlxWtPKmo/M4G1wZ4iPCmqq6mvyQqZ/eALGzvbDrl5ticrFmrP0VmD8IubF5RGTp1PJRF5/+P5uDVEPeJxoC281njllzwVHMBxQQL4+MuSzlijGuG+PTOV+Hddju5LUB8DCfzhaQ0ObBl+qw=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BN0PR10MB5109.namprd10.prod.outlook.com (2603:10b6:408:124::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.20; Wed, 22 May
 2024 14:12:28 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.7611.016; Wed, 22 May 2024
 14:12:28 +0000
Date: Wed, 22 May 2024 10:12:26 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>
Cc: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        Igor Raits <igor@gooddata.com>, Jeff Layton <jlayton@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>
Subject: Re: [regression] nfsstat/nfsd crash system "general protection
 fault, probably for non-canonical address ..." after 6.8.9->6.8.10 update
Message-ID: <Zk39Sr6GmwQQ5NjS@tissot.1015granger.net>
References: <CAK8fFZ7rbh5o9XG1D5KAPSRyES-8W8AphxsLJXOWUFZK49i8fA@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8fFZ7rbh5o9XG1D5KAPSRyES-8W8AphxsLJXOWUFZK49i8fA@mail.gmail.com>
X-ClientProxiedBy: CH0PR04CA0107.namprd04.prod.outlook.com
 (2603:10b6:610:75::22) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|BN0PR10MB5109:EE_
X-MS-Office365-Filtering-Correlation-Id: aa54bb89-96a7-4d9d-efa2-08dc7a6936a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?3eq+h+F8l4zNdDKSMdxdn91ED4R1GwrE4zB3kIeI7CEMJtc2FegGEQXKX++/?=
 =?us-ascii?Q?wQxBsNV0rrnYl98f7Em6z0srtKC/BV9p6RM4P5rlaYE1wEIMXF+93K9itdgt?=
 =?us-ascii?Q?zm+ZyOlXtYb6GSiNFX2zYz4PpcMacGWefLYs7yCCM2qIEUgaUKCd+EaEt4XH?=
 =?us-ascii?Q?1MjqLb5tH4ViW5/iMfpVaVvQwD54AZbTjogS5tzP0uYQz6z01aGV6bfH5qvX?=
 =?us-ascii?Q?zCJXUt5MEe7KlB9vFD7SG7BZygPEM/UINIc84xAe9DWUkYpD4O+9FxDAdro6?=
 =?us-ascii?Q?eGsWUibOm/5ENsU9m/IYYAYW3L7HfxfwjShdAi81Z7UzgKnBq06jfBky3MOf?=
 =?us-ascii?Q?8mQxsKZrRyS8qNnfTslC4M8TyX58am38fefJypTtCX+1T6NzGdSQ48jHxRrD?=
 =?us-ascii?Q?n9niZa7cd7R5gtD2EaazkLBdTv1iPm83X9D2B9DK6O6iEWhkC/bjWZLMouG5?=
 =?us-ascii?Q?MyptetLYME0y32F/RHZ/GZmiq/RCOpXe+fguwF/UYlTE7h3tp7n6Q+L+j5Ru?=
 =?us-ascii?Q?8h9GWlwjaABYmf6sUbmjHHUWV9PXaHTCzvbX0jrANOyNVrB88+3GU5IPvSti?=
 =?us-ascii?Q?o1VQ7bqQ1fcuRrxwkzqIrivEbuMU3hEQKA6snmKco4hejE2z2wgosqJKlWNo?=
 =?us-ascii?Q?jwZa0WTeesWzeoS2KTL1deUKwCdX8Vub0mNO787huTSch+NqJGANJ24ry488?=
 =?us-ascii?Q?Q37ZENE76Nx4YVW/WDH2GEF/EjkYM5OCxa4LlO/qFRGoDSsRyN+TSzDoRu7r?=
 =?us-ascii?Q?Ot10QO4+PBxu2eJDaxTZ9/+T2b41VpRhs/sSS0j15ACqNF9jWkgh3cYOqCC8?=
 =?us-ascii?Q?VOz8jnNxk0vGpKCyROmkM0HDc0+U40N4BngcLURGa3u6AGs3KKCSna8Q84D/?=
 =?us-ascii?Q?ThprB1RJigItpA5PD8U08vS5xgblMYgh/r8wd9QEjIISFUGvUU2ueXDwwSLg?=
 =?us-ascii?Q?94eKJEjzj2yE25lY0QW7SSiLtPfO5xrXwuoZE5zfkYrXD+AD4Nzjc7EAvILY?=
 =?us-ascii?Q?lOk3VJBU55FhcLC0DQnpsZNxVJvzna18HiMgEXMSazrCvsNmz3cGO8Mi5uBe?=
 =?us-ascii?Q?3LDYBMcHVhFS8CpUC+oBN3Eo71r9SReJDjdfE0yBiWkme8qdKY9QmIRmZpdQ?=
 =?us-ascii?Q?ysDpM6DLjQY/9FhUYOT8vNOnm0/+kL3VCRkUbrcqakrMop31Z+2cMVMS9vxg?=
 =?us-ascii?Q?tFgtwq7HggTN3eoabyE+CHRna4/cujw6n0HTOvLcXfihkzTu6WlXnZvreJ38?=
 =?us-ascii?Q?xFkYc/4b8xKXdtJ1XjaGkH3LWI/KYseL8H6gnzf5Bg=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?RpeCE4D/faI6ujgRFfpNZ3+8wGO0VBneX3Oju/55BELOxJDbASWdrUiDpH3r?=
 =?us-ascii?Q?Iw/GRiFnE271cp7+obmHShHUZcM19OojQ7pxSaKXMe85yjHKgzSbdaQHhbH2?=
 =?us-ascii?Q?6iLU4immvGA50YlLTMaP588TuURqySYJSz6CMe46wfny9d4rtSWR8Jcmm8ow?=
 =?us-ascii?Q?eVFOheS09jdpX8l+DunHLRfPCnt+oPs+FFpgAZknaEINFVrsIYIHKc8QzPD8?=
 =?us-ascii?Q?lIHxp+8u/+CitxKRuAef2E5EKZvbPI2Dqx6+PkGIm6rocySrWo43okIO4V0p?=
 =?us-ascii?Q?XF+9Jsa3HtGXZ7q/v6DYqEieckBJjD6aTxRRF6i6n8mfzKPF0FKIkDfmM5W6?=
 =?us-ascii?Q?nDzNYmsT3Z0LqP5eCZ6XobPmSuePQh0DL4D12PCHHZC+3OsMO2xa5fIN0soR?=
 =?us-ascii?Q?/yd+vuaoIF4ShH1/85Ie6kYPS0wTen4JeBbR0XNIbaXgXEXP88LHzvTIKgWn?=
 =?us-ascii?Q?Zc/mfGutiOChxr8DbEezdWBTk+D4PKJtvcu49tfLTBC7XfFWQdi26qdriWHp?=
 =?us-ascii?Q?vxePdzD1lMaA3oYAAX/GxuiVk5ZfK1ieu73FaVXmxCC0QR/2T8hw332PfapV?=
 =?us-ascii?Q?YUB4o978wC3Lkmg1udCMrwP7z21MXNEdZJkE6vqTADkdv/hKAkxWOF95mj8c?=
 =?us-ascii?Q?YB8/Dp/geirq11+7nYxzPj50slClgvdWLUPrt4f72HapgXe+Lgd57gHOABoo?=
 =?us-ascii?Q?oGjb4uxus0Z7OJg/sNtxKB/GL7jOzQsh+tlG/YvyWwYJuCPW/1Py7Z5y9FG2?=
 =?us-ascii?Q?Y+pTKxQNzrBhi8eMsueT0khIvAIQ53qs5WU66UqMzW3rr752vqfOrXazo9Dp?=
 =?us-ascii?Q?NfkGV0z/8xZpkuZZLQJvCLVMBvz7CIOt+mtGm+YAm8Pj0eP9DuWsBlFj44m4?=
 =?us-ascii?Q?8k+ip0ui1/Ixh4Kh/iaqVgk9232KbWLDVw1Ie5DAfruAYhgydzouZGrcGwLv?=
 =?us-ascii?Q?PW6vmWx3nQghwbZKtMQctRlRWrrnuFTKPtv6fpFZCurDtN2oaz1g6+g31/1T?=
 =?us-ascii?Q?co4KuBij3uOTrqyIg5W7yGHyceduzmJ3oJKT14o9Tw5w1c5DYFzNxVo82x8E?=
 =?us-ascii?Q?e9ohoRDcj0m/UVohA+3j8gTpFvooJD6LyYXbqucZIAFhQvnmZsSA56omJ8hF?=
 =?us-ascii?Q?uCTfNktM0Ib5Y6jfSfRQRP1eaB42hSM0x9HOBhu1BSM1lN8V7nm3N3u56tJf?=
 =?us-ascii?Q?GnRrzmtqVhMGKT9qVSnvrFo0Y5fl+gHwUA24Ehuc48kHUd+jwK9IxoRLzAZ+?=
 =?us-ascii?Q?bnnYAAmBcrrJfGxcSqhNlTTVIidk2kuJpixlkYPK2K9PaqxgOCK6MJLJek5x?=
 =?us-ascii?Q?obsOoKM2OgZFLW3F+EcjTii32OJgvkFwN7ej9SM3TLrB32mShyGDg18g1KMb?=
 =?us-ascii?Q?q+MlQgZhxtp7YjQgokfPcb9Yebcc843eBW+wJeiRCvKSErYwNPfF2eUeQu6l?=
 =?us-ascii?Q?EQBNn5YsRh1QOib/9Xd3DsjduDqrbdMt01TNxFhlVOZLJBgCHw0AT+q6aTJ5?=
 =?us-ascii?Q?TVrN6Kj0Pvcl7P0nnptcnq+10sRtltggaHDugf7a2CXTDmKvYvJKOF0N4xlY?=
 =?us-ascii?Q?rki93wo4LcGb8EhQMOd9NB+JmDnFzGYjMpQVN1+xg6sZ1du6Wbx3GHsZe/rv?=
 =?us-ascii?Q?iw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	psdWLNauQvfZnaxenettF2QM+3hqQsyc+6YuDMmx4TQnE3h0Y6FQPkkMgwfuXeg3OcgV18n7Lr4j/+aSDr3lUl6mpSp2DlXq+fbiB7WvhHt2u2DpY/bPgf1lD5tHHRgtdwQUCdP1+sim3jMeALn8OsDpxCNtjKOepgPcqRCkvpi8xaqwNth38NcldbpoRMbOJuhIc2WZWUzC+HbimNLKZm1DvKbxyCbEMr6ewdDIAj9Fjk8rcwtYM6n8judsMXERwfqpBl4hZyk6vjxZrTzbTeHRTAlrS6caVxedZDEm/pLo1k1v5I2HEs6VDEFXzfFr360RH1IDQAhgUfnqnPGEjzOG6SoIUibw0qCx/qz9GE8D0CIdP+HmJfSsgc2r4Te9ytBKetAYT8ldPilL2o3/wy2FIwFMSVqM5JgSdwBJmIe2axiy5JWDFFgUiriGTXeqDA8wAbMCdLwb6pmNzgXvLRiPmPxwhwQF2soznu5jXIv9w5+UyD7goSuaFRwHvefYz/PWKUKilxe8tSwBybI6GSe9/PuA4o6n+NgpfWUMbKhxtsPQHM5WaYmTXnA1E3h7Q8tYLcjd1OkERibAu/wK9HbvlI+Px3VXTTV06NpWWts=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa54bb89-96a7-4d9d-efa2-08dc7a6936a1
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2024 14:12:28.8289
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j7hMbbUDiilKJ40cucE9iqbxnRgEN5oP3CjrFXvdX312LaJYQ7YRxGJTypzeNlwd4icD6fSmfX9e0frTyp88SQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5109
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-22_07,2024-05-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 malwarescore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405220095
X-Proofpoint-ORIG-GUID: w8lYK0PDJsY-oVg6aHjKEWgLzWp6fPTZ
X-Proofpoint-GUID: w8lYK0PDJsY-oVg6aHjKEWgLzWp6fPTZ

On Wed, May 22, 2024 at 04:36:57AM -0400, Jaroslav Pulchart wrote:
> Hello,
> 
> I would like to report some issue causing a "general protection fault"
> crash (constantly) after we updated the kernel from 6.8.9 to 6.8.10.
> This is triggered when monitoring is using nfsstat on a server where
> nfsd is running.
> 
> [ 3049.260633] general protection fault, probably for non-canonical
> address 0x66fb103e19e9cc89: 0000 [#1] PREEMPT SMP NOPTI
> [ 3049.261628] CPU: 22 PID: 74991 Comm: nfsstat Tainted: G
> E      6.8.10-1.gdc.el9.x86_64 #1
> [ 3049.262336] Hardware name: RDO OpenStack Compute/RHEL, BIOS
> edk2-20240214-2.el9 02/14/2024
> [ 3049.263003] RIP: 0010:_raw_spin_lock_irqsave+0x19/0x40
> [ 3049.263487] Code: cc 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90
> 90 0f 1f 44 00 00 41 54 9c 41 5c fa 65 ff 05 a6 92 f5 42 31 c0 ba 01
> 00 00 00 <f0> 0f b1 17 75 0a 4c 89 e0 41 5c c3 cc cc cc cc 89 c6 e8 d0
> 07 00
> [ 3049.264882] RSP: 0018:ffffb1bca6b9bd00 EFLAGS: 00010046
> [ 3049.265365] RAX: 0000000000000000 RBX: 66fb103e19e9c989 RCX: 0000000000000001
> [ 3049.265953] RDX: 0000000000000001 RSI: 0000000000000001 RDI: 66fb103e19e9cc89
> [ 3049.266542] RBP: ffffffffc15df280 R08: 0000000000000001 R09: ffffa049a1785cb8
> [ 3049.267112] R10: ffffb1bca6b9bd70 R11: ffffa04964e49000 R12: 0000000000000246
> [ 3049.267702] R13: 66fb103e19e9cc89 R14: ffffa048445590a0 R15: 0000000000000001
> [ 3049.268278] FS:  00007fa3ddf03740(0000) GS:ffffa05703d00000(0000)
> knlGS:0000000000000000
> [ 3049.268928] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 3049.269443] CR2: 00007fa3dddfca50 CR3: 0000000342d1e004 CR4: 0000000000770ef0
> [ 3049.270025] PKRU: 55555554
> [ 3049.270371] Call Trace:
> [ 3049.270723]  <TASK>
> [ 3049.271035]  ? die_addr+0x33/0x90
> [ 3049.271423]  ? exc_general_protection+0x1ea/0x450
> [ 3049.271879]  ? asm_exc_general_protection+0x22/0x30
> [ 3049.272344]  ? _raw_spin_lock_irqsave+0x19/0x40
> [ 3049.272803]  __percpu_counter_sum+0xd/0x70
> [ 3049.273219]  nfsd_show+0x4f/0x1d0 [nfsd]
> [ 3049.273666]  seq_read_iter+0x11d/0x4d0
> [ 3049.274073]  ? avc_has_perm+0x42/0xc0
> [ 3049.274489]  seq_read+0xfe/0x140
> [ 3049.274866]  proc_reg_read+0x56/0xa0
> [ 3049.275257]  vfs_read+0xa7/0x340
> [ 3049.275647]  ? __do_sys_newfstat+0x57/0x60
> [ 3049.276059]  ksys_read+0x5f/0xe0
> [ 3049.276439]  do_syscall_64+0x5e/0x170
> [ 3049.276836]  entry_SYSCALL_64_after_hwframe+0x78/0x80
> [ 3049.277296] RIP: 0033:0x7fa3ddcfd9b2
> [ 3049.277719] Code: c0 e9 b2 fe ff ff 50 48 8d 3d ea 1d 0c 00 e8 c5
> fd 01 00 0f 1f 44 00 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75
> 10 0f 05 <48> 3d 00 f0 ff ff 77 56 c3 0f 1f 44 00 00 48 83 ec 28 48 89
> 54 24
> [ 3049.279139] RSP: 002b:00007ffd930672e8 EFLAGS: 00000246 ORIG_RAX:
> 0000000000000000
> [ 3049.279788] RAX: ffffffffffffffda RBX: 0000555ded47c2a0 RCX: 00007fa3ddcfd9b2
> [ 3049.280402] RDX: 0000000000000400 RSI: 0000555ded47c480 RDI: 0000000000000003
> [ 3049.281046] RBP: 00007fa3dddf75e0 R08: 0000000000000003 R09: 0000000000000077
> [ 3049.281673] R10: 000000000000005d R11: 0000000000000246 R12: 0000555ded47c2a0
> [ 3049.282307] R13: 0000000000000d68 R14: 00007fa3dddf69e0 R15: 0000000000000d68
> [ 3049.282928]  </TASK>
> [ 3049.283310] Modules linked in: mptcp_diag(E) xsk_diag(E)
> raw_diag(E) unix_diag(E) af_packet_diag(E) netlink_diag(E) udp_diag(E)
> tcp_diag(E) inet_diag(E) tun(E) br_netfilter(E) bridge(E) stp(E)
> llc(E) nfsd(E) auth_rpcgss(E) nfs_acl(E) lockd(E) grace(E) sunrpc(E)
> nf_conntrack(E) nf_defrag_ipv6(E) nf_defrag_ipv4(E) binfmt_misc(E)
> zram(E) tls(E) isofs(E) vfat(E) fat(E) intel_rapl_msr(E)
> intel_rapl_common(E) kvm_amd(E) ccp(E) kvm(E) irqbypass(E)
> virtio_net(E) i2c_i801(E) virtio_gpu(E) i2c_smbus(E) net_failover(E)
> virtio_balloon(E) failover(E) virtio_dma_buf(E) fuse(E) ext4(E)
> mbcache(E) jbd2(E) sr_mod(E) cdrom(E) sg(E) ahci(E) libahci(E)
> crct10dif_pclmul(E) crc32_pclmul(Ea) polyval_clmulni(E)
> polyval_generic(E) libata(E) ghash_clmulni_intel(E) sha512_ssse3(E)
> virtio_blk(E) serio_raw(E) btrfs(E) xor(E) zstd_compress(E)
> raid6_pq(E) libcrc32c(E) crc32c_intel(E) dm_mirror(E)
> dm_region_hash(E) dm_log(E) dm_mod(E)
> [ 3049.283345] Unloaded tainted modules: edac_mce_amd(E):1 padlock_aes(E)
> 
> Any suggestion on how to fix it is appreciated.

Bisect between v6.8.9 and v6.8.10 would give us the exact point
where the failures were introduced.

I see that GregKH pulled in:

26a0ddb04230 ("nfsd: rename NFSD_NET_* to NFSD_STATS_*")
b7b05f98f3f0 ("nfsd: expose /proc/net/sunrpc/nfsd in net namespaces")
abf5fb593c90 ("nfsd: make all of the nfsd stats per-network namespace")

for v6.8.10 as a Stable-Dep-of: 18180a4550d0 ("NFSD: Fix nfsd4_encode_fattr4() crasher")

Which is a little baffling, I don't see how those two change sets
are mechanically related to each other. But I suspect the culprit is
one of those three stat-related patches.


-- 
Chuck Lever

