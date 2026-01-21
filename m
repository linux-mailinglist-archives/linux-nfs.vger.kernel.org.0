Return-Path: <linux-nfs+bounces-18267-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +JGuMAZAcWnKfQAAu9opvQ
	(envelope-from <linux-nfs+bounces-18267-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Jan 2026 22:07:18 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DB5B5DCD3
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Jan 2026 22:07:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BF13874B931
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Jan 2026 20:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5415D3AE71C;
	Wed, 21 Jan 2026 20:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="CxcykedC"
X-Original-To: linux-nfs@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11022081.outbound.protection.outlook.com [52.101.53.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1923C3BBA01
	for <linux-nfs@vger.kernel.org>; Wed, 21 Jan 2026 20:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769027894; cv=fail; b=oT85J8Z47Da43O4C270tbxTGt1d0/0i3zvLDjYMdJshzViGoqJJz9WrPiXgTreiy/3Zo3+rXUuX2+xi5kweQNbDcjmRl8bAYvMyLb8XsDSGL8WR3UdDF3JORLQhiaJNfRvt6e/W3fy9O2VjdQwgjvlp1xD+GuM6Dz28Qm7iiliQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769027894; c=relaxed/simple;
	bh=bQ1nSKrz2QGeKKfjYvERhbokRvgaST2cupmC6iMLrLE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PwGCsL0WIHhSWPvdRUH5NLAosPGBdjZSKFvVBohsR0QIao/Hj5NMnt9KPRy0Yr+7UbMJZ5mHJGEkV8DpvHlfpeWNRMeutxNyoWSYENPOMijB2+pm8a34jGy6l5/8pUWgJsi+5CdxEKuY/ywajiMDXMfb/Jt7SbWWAzjmAES4/LI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=CxcykedC; arc=fail smtp.client-ip=52.101.53.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jl+UWMJ/fw2ZzEIVUeIDsjwpvMkUi4jLpshZFNEsDDSuEupOlEaYKk/y6fL+y5OFJ2ht5kRPnT8IJmKu/hOmoRwjmYcdhRWUpskCu3YnYu8gIkKbggMrBWJ0/IvuK4KIU6qmLtfzmGrgKBHdOj5Fk0wk9kOwNtOCy5v2rh3im2hGpKpXOJjL+h30BSy44bzeZNcU4xuhfnj9DTH8lm/guLm35u0WNLgdCm7XQlmDGYxLkB5I59mcHAyPWhuLcO0RempFi8z/dHTg1KKgXVkx3fLRRM+IJ3Hy7DUBtzjrr5bDQ40zKTBBVk6a4EhpKrBIZKcVJMHCsXMfFpWkiPOyUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2P9Z3K0crUPtvX/UEG6DM+7Tm2Jdmh+wE5PP0WuZbmU=;
 b=uMNoh5Tsk22ark9X6glaT2xictCxR/Ct5cC7eDQlIM36QTP74LqakB+G3WMx04Fzv+yujh9k2Y1/l5XoSXyhhG+ZgXR02PZeJKhLQmhv2tqcAHNRUuocWuG9Lkz6ArzM58kVLcLnnJORuesYmyYVKfpODW6WhXbUv5etU7ydJyRAfRHc32uRx0maKiEp5fpgt8cpaxfsUEOgjkeRWlbj2QqCr9h6jBKBaEQAGsOOOFXZTdOgw4Pik9vvovx47QHRozAI9Va1Y6IwcmU8n5p6pLPh7RZ5d6nSepcrty1zfUt0zwVE/WKH7WysILNk9Tmb+4xsNHcAZc6Du/nxHIxtZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2P9Z3K0crUPtvX/UEG6DM+7Tm2Jdmh+wE5PP0WuZbmU=;
 b=CxcykedCk++91wJFr5Kl3KCsLbU+ZuTe01gpLFqVhjyTF8DJvSHMFsgixzXlLaqgOHtQfjIHdgC+6N97QXRqDZKQin2/+K7uHoBUMRDS6P7jlou2Nl4LKdEBXWQFmvwgstmEfmEOZyklDyBZn9LwHbZ5gnsV70Lr8uVA9SwS35E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from DM8PR13MB5239.namprd13.prod.outlook.com (2603:10b6:5:314::5) by
 PH0PR13MB5422.namprd13.prod.outlook.com (2603:10b6:510:128::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Wed, 21 Jan
 2026 20:38:03 +0000
Received: from DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3]) by DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3%4]) with mapi id 15.20.9520.011; Wed, 21 Jan 2026
 20:38:03 +0000
From: Benjamin Coddington <bcodding@hammerspace.com>
To: Steve Dickson <steved@redhat.com>,
	Benjamin Coddington <bcodding@hammerspace.com>
Cc: linux-nfs@vger.kernel.org,
	Chuck Lever <chuck.lever@oracle.com>,
	NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v2 1/2] exportfs: Add support for export option sign_fh
Date: Wed, 21 Jan 2026 15:37:55 -0500
Message-ID: <60b48050a0998ca214526bbfec406ed084305617.1769027750.git.bcodding@hammerspace.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1769027750.git.bcodding@hammerspace.com>
References: <cover.1769027750.git.bcodding@hammerspace.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7PR17CA0039.namprd17.prod.outlook.com
 (2603:10b6:510:323::18) To DM8PR13MB5239.namprd13.prod.outlook.com
 (2603:10b6:5:314::5)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR13MB5239:EE_|PH0PR13MB5422:EE_
X-MS-Office365-Filtering-Correlation-Id: b4d4ea8f-70c3-42bd-322d-08de592cf8b0
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7142099003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ery4WLQlEalV7yBOjELpo572/RyNpC1UkNet/lFq3qD4ig/jJUcKidC81T5p?=
 =?us-ascii?Q?U4EOUF7UmB3sjOvww/Wx7kzTVM7ksQSGR21EwAO2+kQfaSquXkB6snBXiOgm?=
 =?us-ascii?Q?B+cuT8XoRDg4ERLBHXM1tdG4PwqHP75OahHRrjcgeviKIeTeAeDFsosHzAZv?=
 =?us-ascii?Q?q+BK/WtUjbBooGn+lwMq4Orm4Tzcp0Rz/5ENeZfN4poLqDhCKILzKm8F9Brn?=
 =?us-ascii?Q?svELmZJbEC3uWcbg1amxarNtYas9EuICSHeHvu843kUe7+hHHap5aXH0CT1J?=
 =?us-ascii?Q?vT19GrzxPfhJtj4ux7b73B0exmUq7drIEcuyiV7cIwZ+ouDRsoV+mcC2hoZt?=
 =?us-ascii?Q?5Da/vi+QxPF3vY1xS7x2h0FzCIk1shCRDnJNVXyh6pDxOTjMNgZI8az0RZ8F?=
 =?us-ascii?Q?eLwZjvZJgcb1CFm6Bi2IORgBa97SCIPafwyFCI0+JjYbt14xO3M6vPkrTUt5?=
 =?us-ascii?Q?Z23sR08v2Pz8YeOo5e0CaILKYyNhenTvwhXzrckUqv7fJzE3PXVNqaVjNC71?=
 =?us-ascii?Q?XF65G8C9fDg0GT3H8y4PzhbJQ31/RfxlElxaqOpKTMNCKVgIBj2+1VmgRlG5?=
 =?us-ascii?Q?Jvab9yucO/nq5AZsZVdm5wMdoWFAw4qlJmsK7fSDovwaUNOw6cu9qhBSeNAo?=
 =?us-ascii?Q?wJg+03kha7mFDAeCp6qiDfsENoCYZ+T4uEmZ4Iz5WvjFDcCdAx1N5k8btqqP?=
 =?us-ascii?Q?MpfweAQRb1zTwr2M+3CVHEl7Bq5YQbn4vnMGUwL80kA7t7MDdTyAKk3mcjyg?=
 =?us-ascii?Q?H75youtMT6GX4M/28mQX6kLFMYl2McNj/yN765SZEzNIovyGGF8uQLWAPzO8?=
 =?us-ascii?Q?honCGAPAQ1bauK5IhFvE46xTGQZxJ3ilBp+DKBmqPtTiycxaPtYxjrgmnHHd?=
 =?us-ascii?Q?rbASFp6P3pYnf1cJ+caAA5Lo5RQmLerek9/3XFN2snPtRr2saQyPLfw/GtR3?=
 =?us-ascii?Q?X7gJCGjW1QWGsXGm4UG1QKUss+xFlUuj0fGQdvcTJ4Tx17zOAUbMDr8iPLBP?=
 =?us-ascii?Q?+P3uaRjRrVFmbShVDMZ+Xp9IjkoEwDCTZXAXvT6jPb0tsi1K/Fcb28yKOvoA?=
 =?us-ascii?Q?VP4anJ3HuMWapx5p6U9ce872/f1gMRWZBLWNq42xR2ghI5FweTgMrsRiRYjH?=
 =?us-ascii?Q?bqCvPpPdypzpiho4/E8K8kzXEMoSN8hDkzbcqhm40yBZ7mGzUqVotlzo1igp?=
 =?us-ascii?Q?fcPurBd4efPPdHwImWslZz+ePrCgga6diZCUBTz8jPtwnPXx13010BOzuoi1?=
 =?us-ascii?Q?8K2PXDBuZsfAte+ywtu6lMWva9ZQqG7vZ7y55AsZUAEKzcGwuxUwOM1PcdDc?=
 =?us-ascii?Q?QSkyM+KqyeQJNHDSY8mFLHJkrjmWxj5l7TTqtmDg0PTgbcG8zSjtuW1vT19U?=
 =?us-ascii?Q?K4jnWV1HYcz1P+dZwZza+uoz0PDX9Px8pXenvSo7kdZo0f0xivOZQEgPWm32?=
 =?us-ascii?Q?740SVOhUSm6664dEFJcz2HB0sVS1BU9Ya+lQMWz2ATqP9tRtnB4HM3MVNPS2?=
 =?us-ascii?Q?jXE5J8hHWXSIMZdY2XsgC3PkkrJg0GoosxJjG5eECmX+ARjr0f1E87k6c0sH?=
 =?us-ascii?Q?RE8+8QkR8qN5a4wMXVc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5239.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7142099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YPkQXOwK75u8IdfqpOIxrCW2fz+sOROY0tFycMCtlNgfwtw6c2NbP/+UY+U6?=
 =?us-ascii?Q?wvaxjdJHg4AoseHmiFu8d5YVI/GIgzUAjJfqA7dj2UVXFIlzCrJlRTs3ZMAz?=
 =?us-ascii?Q?x3Uk8sdxlh/msb5jpr2TW3deHYQk6Fwi1lHiLd4vOdQwdLeTYEYSQx7izn1Z?=
 =?us-ascii?Q?ufhSP3dK/0VQVYbDg7m3jdRwsdocePNmgRT9joZ4/ueTvF0QhGZNyh/jUJb3?=
 =?us-ascii?Q?QiExFF5BeXjwM+9ixq1zIuKjoa2Q5QAMFli1Fm/74lshJn0o6o/m6aYjA74V?=
 =?us-ascii?Q?zrcPieJfLkKrOGvn1Flo/teoyZUhJW6texmY/gIpFQR4M31rhVpJhZ0VueLU?=
 =?us-ascii?Q?ykef8Yed/0mDSxCJeYFtEbzVBQHAZsxL3Q88c9XESd/dkLDQye35Y2L95Qxm?=
 =?us-ascii?Q?tUWAonJosj7WuQ4EwbboSqfwxVdQLRxOcuy3g+ZZV41XlwyB7bNjG33dDKQV?=
 =?us-ascii?Q?4S0DaNNo/+wTRWq0HqygMcLUW6qJjHpJabbQ+CQRO0qW3EBQJQQZhVWWEMX4?=
 =?us-ascii?Q?uCmIC91L2DwLYShlEnuX67BE/eswPYYkB76ZXE2ncc1ozAQseRqEc89ckgfq?=
 =?us-ascii?Q?I3un/1gSdhFuEBXdce58j/UNQFC5Ji/WX17Fl5PanLKWUlaFwzxTh0BcUXnD?=
 =?us-ascii?Q?jqi4vbsSh8b3T/oq8aW2D+CIYw5CQ8awE83rcPdd4u8hAkQe530XocQLDevc?=
 =?us-ascii?Q?nSmoIJ3pnLc+KxCCkiFqOL++NSXC4yvAz+cJcjbxMPP796P9wY015Lvy8HZP?=
 =?us-ascii?Q?NQO9YlVggrXn/89FxtwfJY1MaRfByzviIh9R52tCmT0pJaD/sR5SKv/m341g?=
 =?us-ascii?Q?NWj0pFisc+r3qMDd8270W6wmr4jNLyEQzsvXXCfWrRW9LOsSWzulkudbTXzo?=
 =?us-ascii?Q?NeBBAh6mu5QxtdRlK9WVQF9FUzhcpvC+6JbnQXVfVWqcwn00jCpnCgAntItt?=
 =?us-ascii?Q?ymc8NpUQVDyHoYbA9wTylCQgFqU4BxvczuLn5UzJVphNByk/xBk/ImgCJWzJ?=
 =?us-ascii?Q?MuYaKiAXwyvMxQ7zJpLk4ECqHxC0sGsdADyFK8dG3RidcEEqmUTb6m6/1DYM?=
 =?us-ascii?Q?gj65MjIixEdF5ewAvGLpN0aXhVDO6B1QzKb0KvhrQgAY0BfRiOO5iWIV9Wh6?=
 =?us-ascii?Q?JfnApDiOawoPgt4k2KRi1y684FhFmnXNbe5dYNkwnvyr/N4de08UcvXHz/6Y?=
 =?us-ascii?Q?HbffZg6jyXi3n4DywohEqYh3WG2990xIsJU2YWJJWJimRR6O9N8yDAuE6oyF?=
 =?us-ascii?Q?EuPZPwdR6g79YwxJdkS6WSHpl5TCrPrv16+b6XMqiY4xxvjsQK2R5lc3ugeY?=
 =?us-ascii?Q?BBBWjBXhYjrRPZsIAOQOKt0y9hYnUiH/tc2HHVF2gk4sQVjrF4DACRzb+M1j?=
 =?us-ascii?Q?k4HLY0McrNScBJaqECUeHhrHN0NbGqwVBJ7ntMKcGbhOBo1bOoCaqaXmdXjV?=
 =?us-ascii?Q?+pWQtQOMMp+0XW6wZ00c4CEKN6EweUfQxhvFqXEuF+FxniAbU9GNffLbRHEX?=
 =?us-ascii?Q?o4J11/rfF3FpvEzQ+Fb8+is72r5TVLBY3zh2E8bTogHE80E55nUcgn41fhzU?=
 =?us-ascii?Q?egHX/OVEo/nfC5Sock33r+KYf9GdPrKQTc92wI57FnYuerZE7QAGP1UfpODg?=
 =?us-ascii?Q?7kueE9R7yqo1SSDf4svjKncCPQhg0LMTIELdxHOZlVQtuMvNlIInt3j6Wl7W?=
 =?us-ascii?Q?Kg+hp7pkHHi1iEtrH7NKqf83IQ/JA4SStcq1Fd35O0uELUPezE6TWv8lo5wK?=
 =?us-ascii?Q?1gk9/K8gmyQY1X24OWrhXIY9mOLHKKM=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4d4ea8f-70c3-42bd-322d-08de592cf8b0
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5239.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 20:38:02.0719
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 971ait1g5zXazlPCfLuulcQNs+vXvQSBFGuGHootM34JPHPxZ0xKhTlNYstxo6y9dcd3DWOG9MRauOuvjbl1Me4r5CkApCxAu02OWfGkvwY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR13MB5422
X-Spamd-Result: default: False [1.54 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[hammerspace.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-18267-lists,linux-nfs=lfdr.de];
	DMARC_POLICY_ALLOW(0.00)[hammerspace.com,none];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bcodding@hammerspace.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[hammerspace.com:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[hammerspace.com:email,hammerspace.com:dkim,hammerspace.com:mid,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 6DB5B5DCD3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

If configured with "sign_fh", exports will be flagged to signal that
filehandles should be signed with a Message Authentication Code (MAC).

Signed-off-by: Benjamin Coddington <bcodding@hammerspace.com>
---
 support/include/nfs/export.h | 2 +-
 support/nfs/exports.c        | 4 ++++
 utils/exportfs/exportfs.c    | 2 ++
 utils/exportfs/exports.man   | 9 +++++++++
 4 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/support/include/nfs/export.h b/support/include/nfs/export.h
index be5867cffc3c..ef3f3e7ea684 100644
--- a/support/include/nfs/export.h
+++ b/support/include/nfs/export.h
@@ -19,7 +19,7 @@
 #define NFSEXP_GATHERED_WRITES	0x0020
 #define NFSEXP_NOREADDIRPLUS	0x0040
 #define NFSEXP_SECURITY_LABEL	0x0080
-/* 0x100 unused */
+#define NFSEXP_SIGN_FH		0x0100
 #define NFSEXP_NOHIDE		0x0200
 #define NFSEXP_NOSUBTREECHECK	0x0400
 #define NFSEXP_NOAUTHNLM	0x0800
diff --git a/support/nfs/exports.c b/support/nfs/exports.c
index 21ec6486ba3d..6b4ca87ee957 100644
--- a/support/nfs/exports.c
+++ b/support/nfs/exports.c
@@ -310,6 +310,8 @@ putexportent(struct exportent *ep)
 		fprintf(fp, "nordirplus,");
 	if (ep->e_flags & NFSEXP_SECURITY_LABEL)
 		fprintf(fp, "security_label,");
+	if (ep->e_flags & NFSEXP_SIGN_FH)
+		fprintf(fp, "sign_fh,");
 	fprintf(fp, "%spnfs,", (ep->e_flags & NFSEXP_PNFS)? "" : "no_");
 	if (ep->e_flags & NFSEXP_FSID) {
 		fprintf(fp, "fsid=%d,", ep->e_fsid);
@@ -676,6 +678,8 @@ parseopts(char *cp, struct exportent *ep, int *had_subtree_opt_ptr)
 			setflags(NFSEXP_NOREADDIRPLUS, active, ep);
 		else if (!strcmp(opt, "security_label"))
 			setflags(NFSEXP_SECURITY_LABEL, active, ep);
+		else if (!strcmp(opt, "sign_fh"))
+			setflags(NFSEXP_SIGN_FH, active, ep);
 		else if (!strcmp(opt, "nohide"))
 			setflags(NFSEXP_NOHIDE, active, ep);
 		else if (!strcmp(opt, "hide"))
diff --git a/utils/exportfs/exportfs.c b/utils/exportfs/exportfs.c
index 748c38e3e966..54ce62c5ce9a 100644
--- a/utils/exportfs/exportfs.c
+++ b/utils/exportfs/exportfs.c
@@ -718,6 +718,8 @@ dump(int verbose, int export_format)
 				c = dumpopt(c, "nordirplus");
 			if (ep->e_flags & NFSEXP_SECURITY_LABEL)
 				c = dumpopt(c, "security_label");
+			if (ep->e_flags & NFSEXP_SIGN_FH)
+				c = dumpopt(c, "sign_fh");
 			if (ep->e_flags & NFSEXP_NOACL)
 				c = dumpopt(c, "no_acl");
 			if (ep->e_flags & NFSEXP_PNFS)
diff --git a/utils/exportfs/exports.man b/utils/exportfs/exports.man
index 39dc30fb8290..bd6669f431ba 100644
--- a/utils/exportfs/exports.man
+++ b/utils/exportfs/exports.man
@@ -351,6 +351,15 @@ file.  If you put neither option,
 .B exportfs
 will warn you that the change has occurred.
 
+.TP
+.IR sign_fh
+This option enforces signing filehandles on the export.  If the server has
+been configured with a secret key for such purpose, filehandles will include
+a hash to verify the filehandle was created by the server in order to guard
+against filehandle guessing attacks which can bypass path-name based access
+restrictions.  Note that for NFSv2 and NFSv3, some exported filesystems may
+exceed the maximum filehandle size when the signing hash is added.
+
 .TP
 .IR insecure_locks
 .TP
-- 
2.50.1


