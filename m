Return-Path: <linux-nfs+bounces-4924-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A77BF9316CC
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Jul 2024 16:31:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DBC1B21DC2
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Jul 2024 14:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 530CA18D4A4;
	Mon, 15 Jul 2024 14:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IzoHZgJa";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="blVNaB62"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE44213B295
	for <linux-nfs@vger.kernel.org>; Mon, 15 Jul 2024 14:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721053827; cv=fail; b=KO6CMV/GyQvBCMLNfQCqQXm1lNboo3B57VZAkyYCX5IdoqNSaGu/3Vh0acL0FURtvMLQJ2oZt0Mat8aWDBUxTyCWHQKIKUYbOyEhbPMI2LJ8AV5TOVyq6Jj6ojCmeuavwe6VUKJpwmoJ6CfA7iDfZWdTChMoElY+roYUZR78eTQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721053827; c=relaxed/simple;
	bh=M+yDCdmsGrUyCpDahl0ntRyHDBAUZN8j+7mzr4KuwDs=;
	h=Date:From:To:Subject:Message-ID:Content-Type:Content-Disposition:
	 MIME-Version; b=Idx4bbiB62YFIAIVIs4NfK2wz4/farpsqiHR77GQth9EOnOQj4j2CIsGWOXANtBjtptgDR68aSby3QfMLyu2NYcLPrN1e1z6oag94evZRQ29weC6EwKXodRxlKWyKGlW2Gd4t69zd0VVMn5A+YjBuXBYgwUNEOEUlcd3m3YDxEg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=IzoHZgJa; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=blVNaB62; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46FENbJM002966
	for <linux-nfs@vger.kernel.org>; Mon, 15 Jul 2024 14:30:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:subject:message-id:content-type:mime-version; s=
	corp-2023-11-20; bh=ltllOoyVz3J/DclLmW7bLiPKKkkr8OzAvTngBo7ShH8=; b=
	IzoHZgJaU75zH9fPVBN9IIgmAHAa308OiKAVyRzK/N7273Xpk0AVCDGaK+gPCSyX
	nPYpG2WVULp+AU9BGvj0Yw0BD00zapr3VllXWxqkAjHlbvrNE9J8NhX80qU6OEWd
	sHrEb+6z0Nlp4EFWDqUWTpSZv8udASHp/BjUM4fjLMKZO+yC9/NbcyTXWUKTq5fc
	JiYabcJpFzn6H5M9dwI46rssCRCPYJ2De6l3QKgIzWEkWuezytD3NW+z4cahvVTe
	8JaiEpW+AEzjvvqZuyR2mFbNzrrepxgUOFdbbPSR78hev9rpmGlM2ipIwuEV484E
	npphzTgEXjKQ/T1nAcYXAQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40bh6sufc8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-nfs@vger.kernel.org>; Mon, 15 Jul 2024 14:30:24 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46FDSiJk023534
	for <linux-nfs@vger.kernel.org>; Mon, 15 Jul 2024 14:30:23 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40bg1dt2jw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-nfs@vger.kernel.org>; Mon, 15 Jul 2024 14:30:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xzdjLkFc93GyV1bOeEakWmVZs8Ca6/d/VjzOZDaqWM4YWQIx4IfyunZQhS0jtyiThK1hcQ/6UnL5JrfZ0j44AzCcjR7PAlQlGvF6AqwFNcn+kg5/STCGZfZjitLaZnEuU+YCX5MqkP0yx70mTCywJDBd8LD0cCYy3d402rd26m6RHRP1mN1B+26JJz0gUDBYqhcqfAZtrQzD1EQbZC/GVPqIVAxSWE/SznJivaBKxZVzgUtJD4adWEN2XSX8vuc1lthen/hO1GHd6vVb1PvlB49xl5WuT84LpygmcsnH2ozxExA19lHDcGFEKPYGRI2hYJKuhuX5xyAblxiQHQbDUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ltllOoyVz3J/DclLmW7bLiPKKkkr8OzAvTngBo7ShH8=;
 b=q19IEJHDgl8uM8J07/Kme5VIdFDNx5JcVTtbimri84M9PFcsN1PEQJBXjWs7yXQdD+NeO4loEjZXZauXmnuLi+vZDUHw05zuXF3wEXT1jQyMaV9WI1mFzB8UghnVn1S4ohlmqBXSGDws93JD9krQDMzU9Jnim6Ci96qQ6T5GubsB210hBH/ug/L6+xHKzuMWAGowP+N8sDqkrh/HkrLWbD3ug1k9r60juSJs5f3xGhVnfuKbSQwtE4TtjI1WzSwu5+eaLU2TiTsGqcxReZuVuupbjFJnSpQ2ucD+4RmMbsZrk5qdw+g6vYGmz8h0DCY6MuBEG1zk75O3YzgT8CTYrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ltllOoyVz3J/DclLmW7bLiPKKkkr8OzAvTngBo7ShH8=;
 b=blVNaB623MjzQAj9twLF7xhlUNQlMBdKVN/t4JeVmfO24X0Q0imVo3eUiDGCw3mnr0x35ITkM6DeVh63nEpp2cOUPdRfoAXCXP1HaE0bdgpJfXC1FhNrMW65a7Bf2dEaTcciK+sV/LoTAQV52NunawnLri0vusC7MtTJQhLh1bI=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MN2PR10MB4221.namprd10.prod.outlook.com (2603:10b6:208:1d7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Mon, 15 Jul
 2024 14:30:22 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7762.027; Mon, 15 Jul 2024
 14:30:22 +0000
Date: Mon, 15 Jul 2024 10:30:18 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: linux-nfs@vger.kernel.org
Subject: long-term stable backports of NFSD patches
Message-ID: <ZpUyeh/fSDJWXrle@tissot.1015granger.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: CH0PR04CA0097.namprd04.prod.outlook.com
 (2603:10b6:610:75::12) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|MN2PR10MB4221:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c175692-c827-4751-9143-08dca4daa8a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?1fEiWkSia/mnfZvW6VA9ImxObvodIFsUVZ6+ci2dFSB+w+xq7cpCe6nin4JJ?=
 =?us-ascii?Q?E6AKKrBAUsf1477gLtcRdqhYZmj9tW6KKqn8J9V5zwfpvRAZyKnJqc2cLEBP?=
 =?us-ascii?Q?jYcR3rdeC00oUCiohBLfpg6A6sXFMDpJma3J3Z6cWWdlJCSjeha5fFtvcOOn?=
 =?us-ascii?Q?3CFsYzViOcGvvUVouR236eF5Nn9poicBKZ9YwKfGQR/Wqe6aHnTLO1kc//SE?=
 =?us-ascii?Q?003g3zCBK4MrsfLV3x+zScnekdeKwTy+NivNS2Npjd4/18mbKyLMkpu003Ti?=
 =?us-ascii?Q?7+HcvgVXyfgkvPhcMX3VWF+v6ZpI9Y2lrgLzpejSVLkrqpsGr2yah/Y/2kZh?=
 =?us-ascii?Q?SuuNC85MjfG8reW58W0ybnKaCvYSpbG7Bhgv2hAgFR29+CtOLtnbKKz4/ftx?=
 =?us-ascii?Q?c+JaAogQ118c0UcQymLmz8Iz6GjK6gCRFvboEKJXQqSMdNWLgbEHQw2KRwgO?=
 =?us-ascii?Q?X8hwtzBC877wWvOmFudevXmhNbMp7mS2qPooq0/o/ABJ6Jgd6ILi0oQPJbxx?=
 =?us-ascii?Q?lCPPoBjKYH1yT+e7P5mJIHQcmu5ZmkoUx1jlfnkqQeFk1qDZDSrQS6cCgc+I?=
 =?us-ascii?Q?vcTdlSfJYWWO7PZ8aCMWdPQJNExjf73btmn4Rm9iQZSsuDWkohCFYtP4oUJm?=
 =?us-ascii?Q?3vfrHuQAyzoGtBSEnP6c+OU6nU0d50vKfpQ9Owi9Yx8fpsiTJZbI/rJlK1rG?=
 =?us-ascii?Q?8ON+cjOpJL/RSWwRAekPUFUcaaKl8wf/OTGenhh3V8Py/15ogNWUsu1Zhmyt?=
 =?us-ascii?Q?yt370lbDvFPbEc3CphnSCkKg8BmSFnLY7tNrJgI+QUsMQFgPitL85lR1H6cB?=
 =?us-ascii?Q?mhBC8+69C5pWU4kkSZY2NLW7KBVsIm9MzAD8XNAJ95vtVDvobUPojpxZsIRG?=
 =?us-ascii?Q?dIZRsqvKcaUYm/ZcvifZPoHQs/sJ37zxwkjt7+RnRAdKA8tLCzGU8GOPeXSS?=
 =?us-ascii?Q?O+QUbI/sbEOLSEds1ei84tGDOm92+Tr2NoZdujpwvi+d/Yk9TKl3owVtNVPa?=
 =?us-ascii?Q?79rlI2sys5Nz5RD0lFyfxXaDHgfaShCXgDuHBzxulfrttQTLbEi/TC4lNwQx?=
 =?us-ascii?Q?ooU5i747psuY5fMXg78t3yiEStvEBFOU/VeoAEDKIIkAFIaHrculHflSPLpe?=
 =?us-ascii?Q?srYlc5NvDgVd66Cd8JBKJOazBJ7ssO/bmPnSb2zziIpQ8kzBehpVaHmL33Pm?=
 =?us-ascii?Q?nLwLTzju8OmCME7HrFPwdZmnsh60P2mCr4+UQx4M7s4re+OpOrG9oN3AdYp5?=
 =?us-ascii?Q?WdZnNLh1esm86BLXEaEj2E9P+ZIbv9NlVJuqgTvzdllzi8HZb8+hFTPvuve/?=
 =?us-ascii?Q?vd4=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?z0kwijmDO+fcvuprfJ4en6REWLKLuDha2l0XtlqNEaZHAbGCjQVas2EQbtWJ?=
 =?us-ascii?Q?mrlfMSxnQEvqRWtIfZPZPzhZhYicFR+JPBFxSqSsQJIPlO0T/pOBIQgLosf2?=
 =?us-ascii?Q?4XwAuL1zb+gaha4m6ef5HewTojXrIFT8T7CrElMT1NVzBjFBHcaiTgMnG0rG?=
 =?us-ascii?Q?x663AFz5zj8LXaE+zQogIYbWvjpQDpZl1DvjmrQXWd8kTDSss2d4ylQTaHos?=
 =?us-ascii?Q?USUZxzx/JsG0YiN/Av6yBeYRCOWTKkD0ZMhiNTWChUWGpJ9RGewYP7DbFnFr?=
 =?us-ascii?Q?MGbt3bCB05EQ+ID2NXR6NzPiG0a/tajFo0p6I1XIa+dpxeU1aH40k+TpuNqu?=
 =?us-ascii?Q?EazwMDfjORaKhZAQMy7dXdnXYbcgzrd6/2eGZ7rGRFNJTGN0h/eeKsRT9X3u?=
 =?us-ascii?Q?5lg92BUqPChuvdeW660EGCT6QNYVdPrh/R0DFlLE1udcTZgCgG3Av7SxzE2B?=
 =?us-ascii?Q?wUiQjLJguD7D8SQz/4jxj/vm7XY0p8Z4mZostSv1Y6rsmJE6Qs1YQvHlFWJH?=
 =?us-ascii?Q?Fi5XiMC8b3bpv7vrQL6ODEl4JytJx/P5QFsGnQjQZGN5S3bx6MAeQT/vuiON?=
 =?us-ascii?Q?eVnFBSj+6qwGuj+LByOJlpY6HAZjTI2V8oJ4WM4BFHIVUXLNl5N1b8CXg+JE?=
 =?us-ascii?Q?FxyroigK/qHtXJYoqv3vnovRR5RTHNjgT6ldZIqgrDqR8PUO3aO/1VzgnCn+?=
 =?us-ascii?Q?YkzsundwEZRHNbTiHoxXAtT66Nohn1esz58C91msdaS2/3J6gHK35F3rgZGC?=
 =?us-ascii?Q?ZXq4tWQih9UsjSTD9YEaWHIHTfE9zyGhX0J8h+DLQN7qQW1SVzcu2j7STFGO?=
 =?us-ascii?Q?lug4iwgX6jQsG5PTLWy+FseEfVf+VbuUYiLuAOYN6Q+8E1zwyvwliKCCTbbH?=
 =?us-ascii?Q?7VzrR32gK9o/3FJoaF5ea/Q5+UML2FiGSpGKUKhrasbDg/Y8yt/kJ7khkR0G?=
 =?us-ascii?Q?kb6hgX1fScAxVd9v5/AP8XM6IFTBG4PIloHdQmGARNPtjBq9bNUCERf4JRF+?=
 =?us-ascii?Q?slGSeAW7tX22hA4jZG0m24jhu8V2TSftnN0B8pjZADlve4W6iAP16lXH1Mh8?=
 =?us-ascii?Q?IOWS/a3OeVfxdGD5DW7CfzYgzjRqgI2HwXz/KQ9J6EsqG8UOdIU7pfyf3nZm?=
 =?us-ascii?Q?Q9xigSCm/YthzkDk1G3R5msAEJArlO6m+drH5PHHvmMqM572DQ4ydvNrCj1o?=
 =?us-ascii?Q?8+qil5+MaKszG7Y/YEY58k8jd2oBHEvAdKq4mIUoumHmeK7I0zSDSKhcHAS0?=
 =?us-ascii?Q?vVFox830Q+9CXN8tabAn7pcctpFeHZwQq/KaxkwVaPqW7ofUWBZO8znyGp7s?=
 =?us-ascii?Q?1HuuvnMPRZCrTXsB7DUo+dXxeLxIrNNQ5SpSH+9emcjPgLv5FNWA5cn4Ou6N?=
 =?us-ascii?Q?IqUkWC6zktTAuVCNcxrYeuNlMqOJ8GsgEbIBtBqNIZzNgkO9FHWk7ThmOFym?=
 =?us-ascii?Q?XEbSwsc7c9Lz5OoEdUx0blKCus95kWeLhNOfJGz1ufpwPvt6wZYpXJzXb/ji?=
 =?us-ascii?Q?I44EW6NC/MrOJw81vQeR6VlFkwU0Oo7PUxVqC0blljvE0YK2n7lzydZkxHjw?=
 =?us-ascii?Q?XsHeKvbLr/J/cbS43OqMFIcY2q4gVzOZRZl7W5XI?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	wuazypQaCbh8OkJ8/fbhBFPGIDZg0JMHCSAkNbHDHHWMeWfNW6MXG4Y5s1cYkkLvS/dh75dfmy443xLc3peQHS5H3Fo0pwpY9Bpia+zjHxryoRe7KUiv0RKwqf3GonVfKNyhPI2Yfe2zSyHCY7AmCIUfStbb2pBjWmCQNW1xYVqmzqWKGdM7uWG2RQaxAPSjq4fXi5FpoU2p6hP93w41ok1vmxo0pr2y7K5pyGOCh4xArR9o+1RH78ZN2BiAlsZPF/NRx/h3gGQaiFsRXRWrhLk4GrJBxgDIcJG++CVrNJrKFhzdmemJosnxzt5wEgNHI6Dd82wsemuXawUT/LTh0IIZvkrYU/yivXWgiUoJZkcbacj8GNf91fm0cFiNM7RkzOgW/TIS1fZbXTu3K2+wEggspKTInHUy51tOB/ggAS+xpHXh3s30XkN65UZppWWOvJvwtwEkv8K5nWFQqCx/3KINvcC2OOudihCyG3zieX7+W7RAoVCQE7bIFzDuLx0gQ80JFt99nKVpJebNhGBZ9RELY01MK/jgXSFKbRLOo6jOd/gD3H082kRt6+AxJpdIKE2gbqrH/HGmm0A+i042jQ4GBR8wBmjUsuG7l/QTm+s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c175692-c827-4751-9143-08dca4daa8a2
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2024 14:30:21.9961
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +TAkvKXRKgXta2ofKpMHcvvSMm9QZH8WGxHo2IqAHuZx8oZTYKPdx8UpbWJ7hcvl1MKWBfqLqd3+nQ5RVHcK7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4221
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-15_09,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 mlxscore=0 phishscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407150114
X-Proofpoint-GUID: 8SwIo78h6aFstgalACxNd66RbL0mb0Mt
X-Proofpoint-ORIG-GUID: 8SwIo78h6aFstgalACxNd66RbL0mb0Mt

It's apparent that a number of distributions and their customers
remain on long-term stable kernels. We are aware of the scalability
problems and other bugs in NFSD in kernels between v5.4 and v6.1.

To address the filecache and other scalability problems in those
kernels, I'm preparing backported patches of NFSD fixes for several
popular LTS kernels. These backports are destined for the official
LTS kernel branches so that distributions can easily integrate them
into their products.

Once this effort is complete, Greg and Sasha will continue to be
responsible for backporting NFSD-related fixes from upstream into
the LTS kernels.

---

I've pushed the NFSD backports to branches in this repo:

https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git

If you are able, I encourage you to pull these, review them or try
them out, and report any issues or successes. I'm currently using
the NFS workflows in kdevops as the testing platform, but am
planning to include other tests.


Out-of-kernel follow-up work

Amir Goldstein made these review requests:

- Adjust the LTP test fanotify09 to update the comment with the
appropriate 5.15.y version
- Update fanotify_init(2) "FAN_REPORT_TARGET_FID (since Linux 5.17)"
- Update fanotify_mark(2) "FAN_MARK_EVICTABLE (since Linux 5.19)"
- Update fanotify_mark(2) "FAN_RENAME (since Linux 5.17)"
- Update fanotify_mark(2) "FAN_FS_ERROR (since Linux 5.16 and 5.15.???)"
- Update fanotify_mark(2) "FAN_MARK_IGNORE (since Linux 6.0)"

I posted man page updates this week, and Amir has reviewed them. The
only remaining item is working with Peter Vorel to update LTP's
fanotify09 test.

-- 
Chuck Lever

