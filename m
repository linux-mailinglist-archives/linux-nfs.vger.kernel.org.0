Return-Path: <linux-nfs+bounces-15790-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 01CDCC1FDC9
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Oct 2025 12:42:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7AF2B3428FF
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Oct 2025 11:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 661B22F12A2;
	Thu, 30 Oct 2025 11:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="GU90VdMg"
X-Original-To: linux-nfs@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11022100.outbound.protection.outlook.com [52.101.43.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7835C279DB6
	for <linux-nfs@vger.kernel.org>; Thu, 30 Oct 2025 11:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761824532; cv=fail; b=VArzNOQUaLJqtDZ+kcKQa1GiZEWNAetU5R2wd785k2LPryg4D0ULQiSb76oucQoE4IWJEp0HyshpvQYurDgRTr8aL+/ir4N/Kbqckz3NTEIpe7z3Hptpwj3o48cE2f4BUoij/5vdscmtWOeeSwFxkkLIfcVqojXoOCpeXcRdN5o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761824532; c=relaxed/simple;
	bh=4qSM2I6b4C2YgK33S+mA9m6nsR/zSdzMNmC/hLI6ODs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rsCLPLEflxCWsiMEbR17c0SpQIfy/TNUurboOKZcu5np2cpX4MnEWzkelo6feSgLcnZ0S1Xo8N5M9w8D0dSlGJuByxeLNAd9BNvFeSKZrCw7u3yFsYlgPOQ9IrnBSRxKedMDNDZDTZXROQH6Aydc6z5PS/nLR7voVbCqM/zJFHE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=GU90VdMg; arc=fail smtp.client-ip=52.101.43.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=icNYSO/KsYHMVAGN5BTELABOwv9TRRTmoTv/Q2Q9TyBG36wdnaH6rV04pMfy6CAwc9VMAWlVzyBE+PO+CuQsc2EiixeNLJuidh/R9jJRlJ1mj9MMbuUQgUl8ENADd8LInnKSgrZWBC92y7zPsiZD4TE9ocujOvnFixdwUhoxrzn2T/qgrFg4q2ocnk6SPn9lqi0N82koKVkIcxRCtDvE3ST7cyke0lQ0VijCmHvhgI4q/jzQiMRvIVVYjWNgxVltVtmZaMQfyLjeM6PyD/Zdyz2RZuafuwFhhQ3H0iMwQ/mFaNNVgfkPjINX0xYbu7BQ/RVvDD4G6PazEITm0R2yeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4qSM2I6b4C2YgK33S+mA9m6nsR/zSdzMNmC/hLI6ODs=;
 b=dZAcUnne0o8hllvsqvNPYrOJ5P0q2ilcj8BPUbZYdaY6QqtJMMvMIiDF9TGIfvavc/b/tp8SOx5IbxF0Fck8oAi7BO1xoO7ly63Y7JtkqX+2VU7RQO6hs7qkBLZfRiJCYImC0hzc/lw5Y3tQckAZgeiug6KxhHFs0i/fR/2ttYMtQxL3WZnZ9kej7R70c5HmrtqeD/WxVY5TD23C6wn6UsDmp8xTOnXF8ZymW+YogUMvw4oz6abJWBAWDsLwqWkvzJ/6PPgLIFUHNVt/ZWyNVZxv/z1nd72lNUFvkSjhKdjstK6eJZj6N/v5IFbC5WSqKKkazxNXVOncfeIYCCFpsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4qSM2I6b4C2YgK33S+mA9m6nsR/zSdzMNmC/hLI6ODs=;
 b=GU90VdMgXg0VFfbWa9BBid/kjHW2eceTSHxklDaBldeMy7OEwuJfRM68pk/xCfhaVBdUnNcdE8oNj7XujOf5APubzQjGnDa2I/RWc4klaH8B9xZzy/PGCMu6hnVQ30dFdjljbc/DjbNbaNHkg75E2rdBWbUNLqUwdb/RTU62lgg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from PH7PR13MB6217.namprd13.prod.outlook.com (2603:10b6:510:249::12)
 by MW3PR13MB4108.namprd13.prod.outlook.com (2603:10b6:303:5b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Thu, 30 Oct
 2025 11:42:08 +0000
Received: from PH7PR13MB6217.namprd13.prod.outlook.com
 ([fe80::9a18:22fa:f07c:4eb3]) by PH7PR13MB6217.namprd13.prod.outlook.com
 ([fe80::9a18:22fa:f07c:4eb3%4]) with mapi id 15.20.9275.013; Thu, 30 Oct 2025
 11:42:08 +0000
From: Benjamin J Coddington <ben.coddington@hammerspace.com>
To: Yang Xiuwei <yangxiuwei2025@163.com>
Cc: trondmy@kernel.org, anna@kernel.org, bcodding@redhat.com,
 linux-nfs@vger.kernel.org, Yang Xiuwei <yangxiuwei@kylinos.cn>
Subject: Re: [PATCH] NFS: sysfs: fix leak when nfs_client kobject add fails
Date: Thu, 30 Oct 2025 07:42:04 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <819B26B4-BD53-4A8A-9F65-B80939C877AD@hammerspace.com>
In-Reply-To: <20251030030325.157674-1-yangxiuwei2025@163.com>
References: <20251030030325.157674-1-yangxiuwei2025@163.com>
Content-Type: text/plain
X-ClientProxiedBy: BYAPR08CA0063.namprd08.prod.outlook.com
 (2603:10b6:a03:117::40) To PH7PR13MB6217.namprd13.prod.outlook.com
 (2603:10b6:510:249::12)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR13MB6217:EE_|MW3PR13MB4108:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d60d64c-dc69-4622-5739-08de17a95b29
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OWtK9mYaMWG2+/k9k3KweGlJB29WTVt9RSWqqJRiEYsdJpRk55kupBRej+/x?=
 =?us-ascii?Q?HirjVJda15xUssicmsqC2vl6uM0t1eWoCbVqCkokV5XtSNpWJLGmgiHw7xbg?=
 =?us-ascii?Q?VKB/X5Uf2ozuoQZNc9a0D2YXzC4I6xUYtfKPZTCuHtfg/Vhmd7MMdx18kKZH?=
 =?us-ascii?Q?6jr28r3KdjjwzAoJXqr11AuHCc8ULyYkEqe9RxNoM9o4ojqI3iUn+uLPvhaB?=
 =?us-ascii?Q?tZCybzIaedjJX7RrZayiMg/D193d4lGqX2jsSH+4e2mJYcHy6jx+zdWfRxO1?=
 =?us-ascii?Q?B5Ys+pTql0uhqF+lBvTU3tVEGrBU9EsLfKy0KJsPy3bXs9OMd2cD5GBhORtZ?=
 =?us-ascii?Q?/eJ0SsA1iUsM4ukBWl7XTATxPhjrQMPG06Owactx3XMkHOJZAEbdt/em5NXh?=
 =?us-ascii?Q?vsNOp4WTkEiQPZ3+STTSl5Qo3iLXD+m69xh4Ui8roGUZOZsbFQov2ugc0k3V?=
 =?us-ascii?Q?CwrJSjkUbfrDJHBzu5cdVeZFWW0dmL13Nzk1dmY4deJ2CXJ1rsgifko+Bswd?=
 =?us-ascii?Q?acotKqQCf3Eaa+Ds0XmTunIiLV9p9xyg4UDzKbP58jTsOXNzINXOMt+J6AFX?=
 =?us-ascii?Q?NK8IfxTLFowZYFJ4Ct9+R6SWQbRLBwWq/QB4/R5T6mnJayf9yBpid/mnE+ZM?=
 =?us-ascii?Q?c3XKQpvtwWLg6LH+rkcd4qr+gTybpUOp5SaHHQ+5AYp7Db0ED4JT68QmE6Cg?=
 =?us-ascii?Q?EbTaFedax7ouxt572XNVipAKE39z3oqGyyvk/jVZZxxYm6+GJYIcq2sunz70?=
 =?us-ascii?Q?U/0/yVhYoM27HCCiB/+Evui1NX/wZYaU2CvQG+C4JDzKdxHYey/ocNikvkzE?=
 =?us-ascii?Q?kpZ11JDfrGNeJlUkBT71BjtoLQvxtyb2V0iJ32Ewqy9Rhj0gAKhgDq1wuACD?=
 =?us-ascii?Q?jzWI6U2NpDwFbtHBVaHv5czD0lDmM2hloZlP0PV7IMyiAEQs9H8oY5v0CI+2?=
 =?us-ascii?Q?nlEBFrUQADeCM5PDY+Lr+7b/haL4zjfvim7sTc7dLUYZX3SpVuStHvRcTw3J?=
 =?us-ascii?Q?ilFYRW0YaWi3n8Y67+1ib1U3QyNb5ONgfcOZFm1bnJ6IkybQIevmUUwuOtDn?=
 =?us-ascii?Q?gQ11ra1S+CfkAFFjWf0w5d0sf38uAH4ZA/J92Wv3weWn2heejChKp/W7Y5Rs?=
 =?us-ascii?Q?3dJGJVaiF+kSOznCUHbLeqlQlfO34axKiQ8uU6bVwgVY5xuALLi7rsAU2l7n?=
 =?us-ascii?Q?FBuQ08eRtR73ZtTGiITTupUK74LVE6O7RpCOfyzwe0rF+G9N4sRTPiSSPfqn?=
 =?us-ascii?Q?bAOFf0ME/A2tW4L9QsLvAQh1tCWP9EzYe9o2ymN3lKcwDpmNf1+pcppwlRdV?=
 =?us-ascii?Q?yNVWuq1ChVQIY3X9Nloe27uLE66O7vEloSs0PQHANucCAGmKxH+QctTvob28?=
 =?us-ascii?Q?vVJud3jnAO8ZY3lPjCYaEiwSnScY8OV+9vqf67JwyFn7qofpNeZVwMOc3jtm?=
 =?us-ascii?Q?5h2Ox37PcEzKqTcuFTxQBwxXH6/LhckC?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR13MB6217.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ezkhrwuN3smCnfVa+LKtedL6kD+BJ/+Bf1/Cz2eRHRM7r08R6y0PFiJDPevU?=
 =?us-ascii?Q?De73XSo0P0SlQeubtw/fR54cvE6HMp3N2dHonUen03r84NBKg9Fp3HHnJjhk?=
 =?us-ascii?Q?Vl9TiqN5UD0r/CB8DgGCnLCjag7EnakkYevLKWFtGKK+jJAKgN9f8xWYR7X9?=
 =?us-ascii?Q?iaR4bJDXGqecEqhJp3RkIvuX7X1pA5fYgCC3L27yoPzBhqEIFL137CSVaaKp?=
 =?us-ascii?Q?0VwF3SBRH+zVQ8BDqEXUETGLnvhpnGjmD+kt+9o04yKzBIEsEmc44xolSfao?=
 =?us-ascii?Q?vV9lxVOZd0z+XBtrlmtRYa0KHXttSAq7weZQNhyXsmkYwV4gGCk1W/fOqvSn?=
 =?us-ascii?Q?v3Shav62wuIiBkNzsgby6TNLj7+fQ45gctUkXsD7Oqo401ipd5qWIr4C2Yf5?=
 =?us-ascii?Q?8vraP51vVmwx11JbtWfWT4aZ4rXxWsomn86MOAasOtV84jgBkoG3LCmGHBwB?=
 =?us-ascii?Q?ebyDwnydxKx537xSZjOsZZyatWEZdqRzi8Zk6ndXRQfJLb/egiLl03Xf1VzE?=
 =?us-ascii?Q?79AjkeRM+sDPz+y1OxOBLIvDAVMLWejosoBGGSwuXjQ5V2eYUSJHZkJ+HHUZ?=
 =?us-ascii?Q?dIBHZWw4bsWEO4JgmloBOHKHzLQYh2m4GpDvrwTM4xvds2WxRtOIijeSQ2j+?=
 =?us-ascii?Q?5f5C7dxJcuVPPAo9oxdhHw38wcYftB+7cWX7IvV/3okIaG6ras2WwE4MXVDK?=
 =?us-ascii?Q?UforDY06DGjIKUuWDSv+QaKCmGE8032oJZMUNdsjiaU3Qjis5wgYwKWWnpyO?=
 =?us-ascii?Q?RH7/DrPpKFGmUXZTQB8uxdf8ftKDAYf8Ec1FclLPK3dPe3nuxZnCeuqXnZ1R?=
 =?us-ascii?Q?WIwbYRlIuQaPq3zQghiveuSBHiRM/CGKYrdD0yWQ2su01DRuBeEE0HqW2Z1v?=
 =?us-ascii?Q?I5JMtpVq/5vhiaEnLNIIgc/pvv7DaPP8M0jrhgdqwhZ7/YuUYsJ2sgYvAHOY?=
 =?us-ascii?Q?tahHD1yzMy7++wG/4STnZWFySz73FKPQiz3tB8qRChxVfToqBrUqKS4Sx2lI?=
 =?us-ascii?Q?GxsjuW4kBfZtkdGze4DhskYEtCl1D3PBcXdBQEpzpDs52rrRthjTcwWqrYoK?=
 =?us-ascii?Q?USAuv+Czu0Yh8j8krnn8/1iZAh0vTO9bh3NSvSF8B51O86Tp57Dbt+hrLsp3?=
 =?us-ascii?Q?rXXk3OylD6Z5oEZwZ2FFyq5AvUBFwxNd/jRyWMhUzVQ528NRBbG0VEDX326O?=
 =?us-ascii?Q?wbQ+69p6qnlFFry3uKhstPRQUxXUNJZQhQ+ayAF+MN+bUtzZiT75vza190Ln?=
 =?us-ascii?Q?vr1jwvlufjQnxSkv9yDIV2c8iYnKrC9zoOK7C+BM3Ce9VGKF5DPb9yeD+lfS?=
 =?us-ascii?Q?6td2ReD9bWUWfzPnSImLl7hOm0NIH39xYrerZdu21y0L7Q/3cZy1L95bv8ej?=
 =?us-ascii?Q?Q92vab9nC4IxkvvXL7b7egZL8/p6k2tHmTZdCgpy+16mL1aEbGAwL3N+PFrI?=
 =?us-ascii?Q?0CIBH9RfQIfuCtRdi3rm2C0V0Oe2LLD8eoeQeUviixBorKSH0sHTd1WJTSIH?=
 =?us-ascii?Q?t7VuqvoiqJdOsEEIAjKjjapphR2+lGnDFqbVhu0PTDaTM8M7VUm9MrIP2w7c?=
 =?us-ascii?Q?jiAt7GwLqfG35cYuGTu5vW98aVLRGIe7PZzESmTKtm4E61BOh7kyaVQIjA2S?=
 =?us-ascii?Q?dw=3D=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d60d64c-dc69-4622-5739-08de17a95b29
X-MS-Exchange-CrossTenant-AuthSource: PH7PR13MB6217.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 11:42:08.0593
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eagLl7kl7qgh69qxfdc4vL5vouSRw1nbI4sDMcpcJC0+p7wvqZ7iCX72zoeNdkGly8Quw8COasIe8vJxxQLDF/s9DquyWD2OX1fSHJn6lb8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR13MB4108

On 29 Oct 2025, at 23:03, Yang Xiuwei wrote:

> From: Yang Xiuwei <yangxiuwei@kylinos.cn>
>
> If adding the second kobject fails, drop both references to avoid sysfs
> residue and memory leak.
>
> Fixes: e96f9268eea6 ("NFS: Make all of /sys/fs/nfs network-namespace unique")
>
> Signed-off-by: Yang Xiuwei <yangxiuwei@kylinos.cn>

Reviewed-by: Benjamin Coddington <ben.coddington@hammerspace.com>

Ben

