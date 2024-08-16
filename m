Return-Path: <linux-nfs+bounces-5420-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 928F9955316
	for <lists+linux-nfs@lfdr.de>; Sat, 17 Aug 2024 00:06:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 494A9282679
	for <lists+linux-nfs@lfdr.de>; Fri, 16 Aug 2024 22:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E4E8143C67;
	Fri, 16 Aug 2024 22:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZHqkML0K";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="EbRryr50"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718281420CC;
	Fri, 16 Aug 2024 22:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723845982; cv=fail; b=dy3aiGBe3hKxLPcvswaoAzQMGwj88ZL1F34yCIBokNBjXZsRnRruCeIw4xLjjOQ4fT4sSoo8gYLNqV3eUu1G8RCdTZX2RF2+irLeomOUf8I3xZ5kLTdkxjTM/pQJ9C/ZU+FVH5x7WoEzh3jPZOjp2iIep4jIp+FSiqrMM0TVw3w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723845982; c=relaxed/simple;
	bh=830xrYLuEn5IQ/hnHCwl0OOU1GgfGJgXCXaP6Wqisps=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=cDR8Q1wthgT3mzhDl7glu7zlqd14uecjev0llgC3QXR0fLGwp338tihMW4J/zIKWAYCJxizgZEs5i+c9NVZ7F64hUwtMdqXwe0Pl3nQ6c96Z6rDXO58TgGh3Wgh12a52xyX5Nf9uRDC46HJqysjIH7aopdFicm2xfRNKaZvLvQQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZHqkML0K; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=EbRryr50; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47GLBwfF031738;
	Fri, 16 Aug 2024 22:06:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:content-transfer-encoding
	:content-type:mime-version; s=corp-2023-11-20; bh=lLcbvYpe0Eg9nO
	+ZIDWLyVHfFcZKIbDOhkl+6VED3js=; b=ZHqkML0Kd+Sz44u0gH1pR+0z6YVw3V
	2mS90Q5irGmA9En79nueQthNQesZFhsXbIIR3Fq2fIg2SHXKnJMo0nHQB28qQkDv
	kVwLyHZUCAqNZ+gk7PzJez05/hIkljlEUcwh27QFM0b3tcj6YKRZiBxeIpI5w0Wn
	S5CNwhTwo3qavFMuFHZW9RMGBvF1mJx3A8WBmwbB0K2qX3cjfjqm6JvWdpZXfRud
	0xDKEdLEZrIUoSjjZ41J00wF7P1iNQN2hSpEEjyZtXNZgIMwLZ8ejhsDK+ugLMIk
	yk6+4yUB+6lIH2F6/7zjgMdvOKEVzuhbj53zTQPWgGsOF1jeNejofDMA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40wy035m6n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Aug 2024 22:06:10 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 47GKKSmb021228;
	Fri, 16 Aug 2024 22:06:09 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40wxnkdage-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Aug 2024 22:06:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JwVq33T6WkJcqxAUkZvM3QKSV4/mpr6GfQwTGKnoD1awEuc0+uQ/lrhB/e1ilbD/W7nGSfM8WWkYLavgUEUEdvzfoRo6XHlSfCLUGxlXoOIhSE4f4gOIvxeEtGOL+cufN4Kj2yQ2HY+fjgB/1jXq5pLABxGPTuiwwtCxpyw2MSbzPEssb5zsfLBiNsH3o4dLx+Z2rsx8QBuKrVWg+T1PfEhBwuu3CYfZ4eFi6bzNoDrstZw8FzRZdMgn8PXeFCe2mNiyijoj9A+tdi9kcDEy5/+yJReghVAyNxY+0766GZLp1tCfkUrgGdYxsK9ktKoQZS4NQpTaKTR7DFR+tw1jHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lLcbvYpe0Eg9nO+ZIDWLyVHfFcZKIbDOhkl+6VED3js=;
 b=hEeWDPA1XiWiC3jRAXEE9v7fUOfpPzkw6tn9irZVaZ2SRmAPrV39recSW/RJk3i8jQtbj4SRkIoBnD371Ek+N0HicMXw0VjImK3xWLWGzOLF7gtjVvKWetkaDUHx10JgxiiNDyBHfatA0kNMIVDIxoE9KsjFiki1pkv3xxOSkv22JvMZNmaUp32qM9/Mu9jPwzicv47Jtv1RTBOsbuBWc/KFD8SL7hbAGIm+qEJIMiAUMvRGD12TsVbdtgdAeYmofosSk7RhmkQGUWwam1iyhzxTUjyaDRGyhyYKKFj9vg/ItliGhEdh0rZMSBegr7R6JI4cdsnQ8lqIKOVUF6Ncfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lLcbvYpe0Eg9nO+ZIDWLyVHfFcZKIbDOhkl+6VED3js=;
 b=EbRryr50EMzp9K74KtBO/MEBhQUg7o1G8r0wlGaqCyp0bs6a+GQhgTfCGnlGNl+yu50TMvVjcTdtsiOJ5L/QMGdu7Rg0K2/TpnfXdExmokFWwpT0HES50HpUWurqxlF8YOedcicZJpzEBkT7RIqdZb2YbPYnAe0pmV25F66ZEZ0=
Received: from PH8PR10MB6597.namprd10.prod.outlook.com (2603:10b6:510:226::20)
 by SA1PR10MB7683.namprd10.prod.outlook.com (2603:10b6:806:386::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.10; Fri, 16 Aug
 2024 22:06:06 +0000
Received: from PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca]) by PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca%4]) with mapi id 15.20.7897.009; Fri, 16 Aug 2024
 22:06:05 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>
Cc: Tom Talpey <tom@talpey.com>, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-debuggers@vger.kernel.org,
        Dai Ngo <Dai.Ngo@oracle.com>, Jeff Layton <jlayton@kernel.org>,
        Olga Kornievskaia <kolga@netapp.com>,
        Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>,
        Stephen Brennan <stephen.s.brennan@oracle.com>
Subject: [PATCH 0/1] SUNRPC: convert RPC_TASK_* constants to enum
Date: Fri, 16 Aug 2024 15:05:59 -0700
Message-ID: <20240816220604.2688389-1-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.43.5
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0182.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::7) To PH8PR10MB6597.namprd10.prod.outlook.com
 (2603:10b6:510:226::20)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6597:EE_|SA1PR10MB7683:EE_
X-MS-Office365-Filtering-Correlation-Id: b4eb2005-b80d-4f31-fdb5-08dcbe3f9fc1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sf6dkDqxJB22TtLwQAFdacCK6ZGhzMny/gX0nOMnSX7k1GCmabqD+3RoFMyl?=
 =?us-ascii?Q?FzlFVv+V1FVXwpg7Yk06mUi7kbLlzE58CWbfvcyIRmJpKcsurQBRL6z2KlxU?=
 =?us-ascii?Q?5WEFIi4SjsFoRIVR1NqKA9DY5fhySZL1mwinmVZrAn/qMstV+7xbJOHZPFvz?=
 =?us-ascii?Q?uxkjfup7Hmvs+TcQ95Rp3iCaQkfajNz629+uax2SNogIWUsBDGQrTEjht78h?=
 =?us-ascii?Q?/yJ1nq9Lq8JAed5qLxN6ozRyftmRiXMA0vkdEPm7LF6XmzmTjd2igQG4ptuA?=
 =?us-ascii?Q?yHrHn+H7qILcwARO+gMu97At+QeJ6G22HNmp7/7PAy6JFnZbO7RIdD3vwrDq?=
 =?us-ascii?Q?JFPj1eOPlvjqjPpkcoPRbK90Szputqu10Ydp9Zoz3M3Otzr+bWHQqkhlXei/?=
 =?us-ascii?Q?NlJbgkW7tQ+qu6zkSQXawhJ66KvmCr0kVrwhgZTsil7ZfALpwdt1YNtmEMFd?=
 =?us-ascii?Q?U//GZ4Y4SDUQaF7bNbuXfAM1F0yIETW9roYAs5UhA7koesxnpTvlazTohNPF?=
 =?us-ascii?Q?c6U/+nafkoUOsChxPQb7+fcFnTleqgl83/fwqVBW/ZIKco5TErjOebUbFDVu?=
 =?us-ascii?Q?SlrRcE2XIbQDVs3slc9jGcyZ7nXLrNLW2xh2Fs4+nUfZVEQ2PH3KMBpNFBiR?=
 =?us-ascii?Q?ljAw2Tj9rVk7JFNZSUo37mMNdTwHJnzIRoyLQj50twP5zF921gi72DiRXcxY?=
 =?us-ascii?Q?Wz99odPMD6VOLj786OPg/jni0jDCTokunVhjIL6b6Ed5fwbSCORi8fnU1jOH?=
 =?us-ascii?Q?vbRZdxPUanEhNxF2vkp335PkCoa8PWIHe2gLzbQAtCjOfxRE145C/Xpj55Ik?=
 =?us-ascii?Q?0/kaOWUAecip+4f3abfFMY7WEjs8W8ptqb9QpCasK7l1QL7DLOjlDA1yD1SH?=
 =?us-ascii?Q?ypzsPCgVO5dVBOwcXl6WqRK1bsZW9lG5rfFOTGamze807pCoIQZ3XY40Llv0?=
 =?us-ascii?Q?YDuGQvlb98xsGQy2ZqyimuDBp2WMIiUXV094Lo0PHcUycKWBbq8XIzacyPWr?=
 =?us-ascii?Q?mO137KPvmdNQHDfHdDrPfReOXffq2Hrl47bifuxvNSBOX5qvfLvh8jSaUa0O?=
 =?us-ascii?Q?Xt8JT+jsRQ8IeXwdA5zBvzFpd7XnKsFe6f9We/pNmGH6nm7l5eDJd/D2hPpB?=
 =?us-ascii?Q?WN5I+7IHQAogy9LjDlcfN7Wi+Wdq7O2ShAbffRzD5Ywzpv4x0fwrjYsfgvGb?=
 =?us-ascii?Q?RRlyLuWl/uxoK78jUcX5BLyyCfCyO4BdrZslUVQ28jg9lf8aJ071q/37ygLY?=
 =?us-ascii?Q?6UaR6cTLDMfLRm05hp9JJU6DIKjDqOa8hp6XdngU0jDj7ls9+ciReHgSEccr?=
 =?us-ascii?Q?QX8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6597.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aj/xAmL5niMo7iL+3leerq9NQgqIjfAiUWskPUGEINC0zL9i6QN9/w2IyPPd?=
 =?us-ascii?Q?URES9DhnjWRcmlfqfn9W6AdwNcvivDTl5y/fzgj6BLzdiwrvIQo5+GfFIHxc?=
 =?us-ascii?Q?J3bYcLebExHFEgs3qkJjzbrgJEQfiVh/mJvSS2MENAblHZU5nvEV12zddCAR?=
 =?us-ascii?Q?4Jl4u2bYliTKdNJQlZZPsRr77VPtXrmpILLh0Zbp5eqQopnSc+GzscpwYGv8?=
 =?us-ascii?Q?KdsMXrcK2jpEuxdh4k16x6EdiQdRSUU1Fz1Dqm6Cptm1KzAZ46CIM4wy6vXD?=
 =?us-ascii?Q?TaIaTuesIkL8HhHgfzkQQ/NJKbgniETYRZfVQjCttBEP4c0XmCmKl4A1RWfE?=
 =?us-ascii?Q?ko5XpYI8WcHrpowCthKxtCEZ+ECb3A2qc2G7MHVh8FQpwHqH4L/ejHdpWMO3?=
 =?us-ascii?Q?td07GgJmZOrSAfY4cfP6JRwL0U4xnxR+ZuL3MhBPZqvwZ5emhvCRn4S4u/2q?=
 =?us-ascii?Q?fEmhddetkXdKxWC5MdMlpc6AxPTgpMQ9IYa8CBt1IUQtLqDewfKM33oywtWv?=
 =?us-ascii?Q?lpXE5bBxCxPiOZkee3MQ6cJUV2H69HpsphNW9zpRorU+ySSDrYnJWRYhe+xS?=
 =?us-ascii?Q?PsYZi+XABTSjdzjYGUCnUbuWAEerMhEANGfd7+2ZbG85fb4tve0LOrVjNSxG?=
 =?us-ascii?Q?6j9oDknUKpa7p23vNN+mVFEReFnWTAN36n3nnmZF2kVQEByBZTKKIMo8fjw8?=
 =?us-ascii?Q?LTzQ0HhhRx9rl1tm4aEiaGS8TZ/8OuLDGc/ApkcaF469+dhwZFB56elWXPFj?=
 =?us-ascii?Q?9CMImnJIbZlRQQduDs3v7+ZhDc8DuGrxozwG+sdvtcX/m40F61HZQ26iUZ6+?=
 =?us-ascii?Q?4M5eAQXgCC2a/BUePGfT3Z3xmRVLCQdHK199H7nEwaOeC6tivfPlN9kWjHFa?=
 =?us-ascii?Q?K4Qyt25xhNK9GLiGtploenO+7wZUyasTtR4wJjGyzb8V5bDJsvXThXsDuWhY?=
 =?us-ascii?Q?2OdM9eCc+9cJFkEv4+At60duQ7+xOAkmWxRIQMVO5n6L+jtqNiqm94Hf7eAY?=
 =?us-ascii?Q?mQcopuPK4tyCEEOsTeju+11sOTw+PLQnj5wR89ivOAqbsDRNKoi3roGvlotL?=
 =?us-ascii?Q?Pi9RzkmMkcjysz3XsU7zQOiarme0pZvBV/gvGbxp6bqaFwnEBQMXndq49rNh?=
 =?us-ascii?Q?v4ao5T0P67vtOX82rJoL0DAEkhIdiOZgCFWXsjrG0Dx7wgy1yBPP8uEZyIct?=
 =?us-ascii?Q?BhaMA/oXooSYuLelHh2IUkX7Nil9RI439ksJ/bCbmR1bkohiNeXy6N/h4DZS?=
 =?us-ascii?Q?Jtc78wra1NhtleyTr1a0QSKtg16drcLqqKroWYnVSBzdfCRxemB7mgOcRuD7?=
 =?us-ascii?Q?yozLSFliDCzNKNyTxc4ekL+wa+SjAYRLPGVO/tLtiabF89OEFv8N6uA11PwR?=
 =?us-ascii?Q?kuk1hemK8LXVoVmcQW5sMplbxmzFBz1JbXX2WLXdNfEFD0dLNTylJsJGQWty?=
 =?us-ascii?Q?1YCqTDLeMKIe8ap7gm6v/x6k3kcGja9icdJIbEI3yVHOl2eNYM3pWf4Repze?=
 =?us-ascii?Q?Hi5A0SMwWts2dCaTnsx/ro/ZoewpUbhagfVB+vJpnCHzLsabumrIJsBAle2D?=
 =?us-ascii?Q?sckd1l0CdQ/sziddwj52MqKZMsrgl+2mXYHq5BGl+l5oc53qEBJK8AP5arvI?=
 =?us-ascii?Q?9Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/fa/Vqq1jERsGq7R/9j02Qh19m0Ei2U3Fvi2gSvDaPTuOFuu6/wSjWiUcv2VyWkJondGXujkCPAtss3ChUIZjvLY8EiKUowr1uR495zr6NumAseZNIDuNiRyU7OLcuWBzVh6yvU8MgQqtGqvwlwAqx4XlEbXefRFIgL1DsFVcTbAl5ps3M2w1O2w4GAl9g5UcrZEhGaRayEb8KLldwq8DGFj1whRgwtPoApG67UepuGg76Vk41qMa95jSRGeqUlg/jUFlZ0hlIKuqKKWPrlh5UqYsTj4tEn4rTzYqFR1G/QXIiiP8P/ktUR6qazOX+M0xxzpG3mMzS8zxvRtEaV9CCkOj5BBrwn+kAOnv3dZeIkMHHiqDBA3DMZU2wklWZkyvF0xjU+6rfT75za8Y0uqO+tr+8MnogeJSZUZ7Ga87+HMUYEPrfd1oMAS9hc2dM29p08btwxJkozVHwnThnqrNpAnKjEdt3EEhQYjwc7UM46xkW08vdxbG2U7XqeGfg3vD8edEHwCbHB8atZ+s/cA6qc5sUWwLPMGVmJDOQCA2QZiw4gto58fJ14LczHEVJLEjEwmaXVlDS10jIcfTiNxWDyFsakoK/himKECkXhNjBA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4eb2005-b80d-4f31-fdb5-08dcbe3f9fc1
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6597.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 22:06:05.3476
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hv/9Cr3ZwqCW55f+vmeCJfa2f+W++LEWZoPB1Kk29J9gbHnkCEo3HKReW+un/B17okyWMe3zKKAYOK7T6JYTralNQ5y8/KEas0ZGDGNdW68=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7683
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-16_16,2024-08-16_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 bulkscore=0
 phishscore=0 malwarescore=0 suspectscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408160157
X-Proofpoint-GUID: fUbaxEbA6Lf0VKk4e1lE1ygk_EOgp0_4
X-Proofpoint-ORIG-GUID: fUbaxEbA6Lf0VKk4e1lE1ygk_EOgp0_4

Hi folks,

For context on this change, I work on the drgn debugger [1] and also
maintain a growing set of helpers [2] that can examine live systems & core
dumps and give detailed information about the state of different
subsystems. One such helper (not written by me) shows all RPC tasks and
their states. For example:

=============================== RPC_TASK =================================
---- <rpc_task: 0xffff8dc383548a00>  tk_op: nfs4_delegreturn_ops  tk_action: call_status
     tk_client: 0xffff8dc385c0fe00  tk_client.cl_xprt: 0xffff8dc4f79f9000
     tk_xprt: 0xffff8dc4f79f9000
     tk_status: 0 (OK) tk_rpc_status[0] (OK)
     tk_runstate: 0x16  (RPC_TASK_QUEUED|RPC_TASK_ACTIVE|RPC_TASK_MSG_RECV_WAIT)
     tk_priority: 1  tk_timeout(ticks): 6095245983  tk_timeouts(major): 0
     <tk_rqstp: 0xffff8dc47025d000>  rq_xid: 0x96143ed3  rq_retries: 0

---- <rpc_task: 0xffff8dc383548400>  tk_op: nfs4_close_ops  tk_action: call_status
     tk_client: 0xffff8dc385c0fe00  tk_client.cl_xprt: 0xffff8dc4f79f9000
     tk_xprt: 0xffff8dc4f79f9000
     tk_status: 0 (OK) tk_rpc_status[0] (OK)
     tk_runstate: 0x16  (RPC_TASK_QUEUED|RPC_TASK_ACTIVE|RPC_TASK_MSG_RECV_WAIT)
     tk_priority: 1  tk_timeout(ticks): 6095245983  tk_timeouts(major): 0
     <tk_rqstp: 0xffff8dc47025ca00>  rq_xid: 0x96143ed4  rq_retries: 0

To do that it needs to be able to interpret the RPC_TASK_* constants back
to their human readable names. Of course these can be hard-coded and this
has been done, but in this particular case, the RPC state codes have been
updated and changed several times:

729749bb8da1 ("SUNRPC: Don't hold the transport lock across socket copy operations")
7ebbbc6e7bd0 ("SUNRPC: Simplify identification of when the message send/receive is complete")
cf9946cd6144 ("SUNRPC: Refactor the transport request pinning")
ae67bd3821bb ("SUNRPC: Fix up task signalling")

Most of these simply add to the end of the list, but at least one (7ebbbc6e7bd0)
shuffles around existing codes. Creating maintainable debugging scripts that can
be used over a range of kernel versions is difficult when you need to detect
these sorts of shuffles. We *can* do this by detecting the presence or existence
of other code changes that occurred in the same commit, but this tends to get
tedious, and it's not very reliable. It certainly won't help in case a similar
change happens in the future.

Converting constants from macros to enums is a great way to avoid this for the
future. While macros aren't typically encoded in debuginfo, enum definitions
are. Of course macros aren't always suitable for 64-bit constants. But in this
case, the RPC_TASK_* constants are bit numbers, so they aren't impacted by this
limitation. So this change shouldn't have any impact except making the code
easier to debug.

Thanks,
Stephen

[1]: https://drgn.readthedocs.io/en/latest/
[2]: https://github.com/oracle-samples/drgn-tools

Stephen Brennan (1):
  SUNRPC: convert RPC_TASK_* constants to enum

 include/linux/sunrpc/sched.h | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

-- 
2.43.5


