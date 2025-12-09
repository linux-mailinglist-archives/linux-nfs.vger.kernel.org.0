Return-Path: <linux-nfs+bounces-17009-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 76F4BCB0660
	for <lists+linux-nfs@lfdr.de>; Tue, 09 Dec 2025 16:27:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D10873069547
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Dec 2025 15:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 888C322A4E8;
	Tue,  9 Dec 2025 15:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="T0qCmBsa"
X-Original-To: linux-nfs@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11022078.outbound.protection.outlook.com [52.101.53.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62312139CE
	for <linux-nfs@vger.kernel.org>; Tue,  9 Dec 2025 15:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765294064; cv=fail; b=EkmljjKK5kiZbt04+EjUHCNxngI5n/Opp7QzLMnrSox1gRg7L8c33HNTLAoIkypzrhze5gAPWVFtrupYrlyjN3h38x4u9l/U+uQ+3xD6Dyu/2R/xoEgJb2QGudTTf/U6/j9yDN8fnSFVshMWPE/Xr8XKonQ/NwvtBcLFtBhjQgs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765294064; c=relaxed/simple;
	bh=a3VMGhDaCGGXXnVODMI1e/bZN3rXKiA7wtJv2fMldCo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JAkGnPC7UHksonXSJLIejhEYYGfTd4jkCO4B+iC3I4FT2J7IN3k5dABngV5+hbFZcOGxA9BFMCNVJUNZ5w79A1UEC/D1D8dTpTjHSKp6iSyeL/JSiCOfxzTAqknlAFXdrQNyi1td5SI0YZDE3T90uFUDIrqhGN/I6zvdImgtlyY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=T0qCmBsa; arc=fail smtp.client-ip=52.101.53.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rBHKUSnE+PBqnC6bCpJgw9xqSKj+ZCzAbxAtLLyOET7scciKQc3YFti+OZcF6433/PbMHinedHRoRPQIuTCH9epu0yoW0nQ2YODUTpDKHMe8aksApjlRBD3VZ1+tFCl4zdAOgcEg4JR0E0VAV4gVYVB7wEOuecDvDLQj3B5vtBWRm4Or8Qsvdqi7n2C4uGdAq0l5WtaIHuBy3KPitYucGrIKy4yrcnKSrwQZx2L0SiOBsUgwTlwOj9DIw3UqDJXb3H+zUr23eqS9C7o16h2TyTJwt0Ovk+mGYshxeFW5g52ZbXDgNWDBk8nclYP/uZM6r+yFqiCRAfdh+ghEjZs/EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HLvBUUhbBZ06hXxB5OjNGb0Xpli2EdzHnMV9gLdD1sg=;
 b=RUg5lxAoTDqKgJPlZQeEHA4yFPWrNO95bkHKePnwZALdzGXX+SgQXF+wlVrlSY5bCwIDkbq+9UccrTTNAfxe4+9BOcpCEB8QBDlF7EXgfqf4EmSEKNAxkYH7yTbo9pZT3pRpzh+QyfEIJmiKwWX/ZMmqqCiMayYuMtPYSSIvIqdYs+bGgXjq/p/TWK0iehz/kApsNBwolvaD2xi8nFt+uXCjHN7GYFEjGxjHnsvxWDgWnC/j86FNWrYMMhe962BA3VaaUZ9+kQD44xlKWU3mXi4eK3T4xewqqSjUIDU2Ed7t9FCCBChgbYt1flyy3log6BiI1AEVmy6KnVFaKveVcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HLvBUUhbBZ06hXxB5OjNGb0Xpli2EdzHnMV9gLdD1sg=;
 b=T0qCmBsaC5+cNzd7DgYCp7TH0fUfFLBBY/smWVboZv/dYeT9d9eitm31Vz8+rO1bZdExjANYo32eoxYnhzNIqXWe+u1mL112uKDGqnUAp3a57iDLlfTOGq2zHDuuISlJyR8pPb5Qp94WbaA6U7s3wjxpSO7cAENU4ZJS83U5tsE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from SA1PR13MB6648.namprd13.prod.outlook.com (2603:10b6:806:3e7::10)
 by DM6PR13MB3953.namprd13.prod.outlook.com (2603:10b6:5:2a9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.7; Tue, 9 Dec
 2025 15:27:39 +0000
Received: from SA1PR13MB6648.namprd13.prod.outlook.com
 ([fe80::c48a:c42a:aa18:2ef4]) by SA1PR13MB6648.namprd13.prod.outlook.com
 ([fe80::c48a:c42a:aa18:2ef4%3]) with mapi id 15.20.9412.005; Tue, 9 Dec 2025
 15:27:38 +0000
From: Benjamin Coddington <bcodding@hammerspace.com>
To: Trond Myklebust <trondmy@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: Re: [PATCH] pNFS: Fix a deadlock when returning a delegation during
 open()
Date: Tue, 09 Dec 2025 10:27:36 -0500
X-Mailer: MailMate (2.0r6272)
Message-ID: <3090400A-1FB8-4DE3-AB71-08D2D7451ADD@hammerspace.com>
In-Reply-To: <24ff118a0bc9c9a845df3987e532365e9d6ecf2a.1765224921.git.trond.myklebust@hammerspace.com>
References: <24ff118a0bc9c9a845df3987e532365e9d6ecf2a.1765224921.git.trond.myklebust@hammerspace.com>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: PH8P223CA0018.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:510:2db::28) To SA1PR13MB6648.namprd13.prod.outlook.com
 (2603:10b6:806:3e7::10)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR13MB6648:EE_|DM6PR13MB3953:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a9acc95-dd5e-457b-3d60-08de37377ca4
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GNxhdZrzJpmfHAqP914neXgxUi84kJfF6w88nc7pQNEZc4PKNGCCxDqnHxT+?=
 =?us-ascii?Q?0Im01kRFBjmf4TY0tP7QrFMeZI4HEjVRtnx+0vHYrnxWasdnhj/HChFtrXIi?=
 =?us-ascii?Q?C/Jecrl0hRAi09cG8xUuUvnZJVOIbQiSAZS+q/SNSIhJbCb6CYT1pTgRjd00?=
 =?us-ascii?Q?UgPyAbFOkP2ff5bnNAy02mj9rz5iPx8W3GUoXaYB1MsoUsjlHTuPZ1A62+h8?=
 =?us-ascii?Q?tJqffLTfvb6jVB1v5OMpdM6LxlmfnfnPVw91Vos+enhdBgAFiRfbShgr/LKM?=
 =?us-ascii?Q?Lp6vmOC27pZrlEwNBjrI1X7H0V+yEBNjm5vIGAejcfuJA3BtJmIYmeK49IME?=
 =?us-ascii?Q?oTf83Z79ZO6AGLG+5v631l6hsxQmkkKykVuDgnsNk16GJIrvy3LFw4YfK+oR?=
 =?us-ascii?Q?PYuRntKgtEgleb9ul4/3ql+FeFGvmMuzeAbLdIdKaOQ/PUx9F+9k+XFcEJao?=
 =?us-ascii?Q?uHDzAbxXKDTL8I1bDA45+b/NHbyv9bo/+MVDbnpc6rch9EVol55tMNlETXOB?=
 =?us-ascii?Q?cFDVHlGLmWwQ00nRhNLesuos8CEDMeUE4am/OGCb4qj9mG6cwTrN3Silf4EQ?=
 =?us-ascii?Q?KZF8AksY8ioOt5gzTDC9ZNsqkSlsBWdjwnXrTSKXKeCFYsXZV559NklEi8x8?=
 =?us-ascii?Q?kRNxAXJ9wUpKvPOsqS4VDsYkXI7oIl5qSNPzUvLBHJB23zox7j7m9uHy6lGd?=
 =?us-ascii?Q?DSW/DudGwpHsaF6mzxKtndIVqc+QIsgX5JBtGO+rLHn+cwTuSGiqTshkIkaN?=
 =?us-ascii?Q?DC3yyjMS8UXIlt4lRNw1JOAQ8/k8VN/xJ/9t28eTCFthGzQmVtTFQyuYLYb3?=
 =?us-ascii?Q?IKPu9Wz9vJmo3x4AeAczr9JxKPZFIw2DHA8JGygg4WO94/z1b+681I9ZCTVQ?=
 =?us-ascii?Q?68oOveBPNQWwtwGkdw1oAzp2YDlKSE2I4h31hvWhOMyBpsWmqtP9elkoowA4?=
 =?us-ascii?Q?Ao8KB3ddN9yiZzyuzY+zZnyxgtXtJI9tdhmRHxk/JeyqMUNGFHwdXJgZD1KW?=
 =?us-ascii?Q?J4a+mRIRCYj81EsuOwVPO11ei866XD8iN9H4xReL0hYhepNlc088OS79bIjE?=
 =?us-ascii?Q?F53m3KwP6sil6Bt7JCwomhN2dNHibDkWjALvCslihz1VzZo0YDh8JsyvIiOu?=
 =?us-ascii?Q?YScixNmvZVpjEHsvNEsUwVS2fS6OZMEoq0TIWWKjAjuBNTneTQ4WYCx0Y1jW?=
 =?us-ascii?Q?vp+MIV1Kx+vdjF+WmPMPgNqoAUAfj67la/XxT1NfdUTWGJCDnXxI3B85bXTo?=
 =?us-ascii?Q?pv2UCpMvYChyzDbhZXT4pvya1enjfPTyg4hchOjguG5i74F3I9OvPFQJddNE?=
 =?us-ascii?Q?bPQoJ04t/C1WePrLwWFWA508YVj1+vtsSNs4/Z3/4ienCy6g7gJBflfhtKzn?=
 =?us-ascii?Q?vZ7AOg6fSl63Gk4EIdvt8RgCD8oybv4gzTHAxBqmT+L5MVf1z0/RW+ei+zLL?=
 =?us-ascii?Q?1JkD05LA9NqxXeqjJ+jozQB1JuvMyaC9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR13MB6648.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7yuoyPY39K6/OK5bPDpsj/CjTZaKl9GbOqp3HXMFsNuhA9E1tYVOx6b/iNIx?=
 =?us-ascii?Q?PAsOqmRkPYBZRTly8oqNZuZgivQiS0udglrrO1EbJ6dC73FQNNanE9ryoNmf?=
 =?us-ascii?Q?UJ16LTkDT36q9GZhcA/9FY4+FxqUNUhWBeb6c4uh7ug0REn8WIdpUtBHmEpb?=
 =?us-ascii?Q?QDQEePtwU95IxnanCCES2QcxisrIew/zgsYl+gW458XS87wNqWxkLQGf7wX8?=
 =?us-ascii?Q?tzjhwTEh1c9tFLahDw6qhcba8ZKxC75FBkE7B7laoC80gFxkPrpexsWcgsgo?=
 =?us-ascii?Q?5PBixB7fgVE7j17DumScHcmvuL1BpJxPinX9yAUxZAFVZTJK84OUS/GPH0Ok?=
 =?us-ascii?Q?4/AUpz9jn3N8D4RUks0mBfmhYjdTmV+wW72n7jqFtP5RdFpZZwWqOOz0eppD?=
 =?us-ascii?Q?R0FJI/j0T/mKOXWaYHk56ccVpnFQcQAtotnhlyVk8ICy2PFyx62dFVoVNw3e?=
 =?us-ascii?Q?CcjAeAgo4HfxhndWzodg4RCk4hhXVGQXlxeALVIIQkdkIHXNkHxpmvNxBS1p?=
 =?us-ascii?Q?JQilVLNxybpKREsjxdfc0eP/k1NnqL5Tyd28S38+DoI6djKuj9FTFnqHV2yB?=
 =?us-ascii?Q?f1yh96yJXs1vHprV+VUhHMaFmAvmhm5WpMSBEn85mNaFYkNqDTV9bPgrOqhG?=
 =?us-ascii?Q?sVyLMIFgM8ZfUr86zCwEahNTB0AO41ywiX6fK36j45wAhSXFjxtvHHvmlVdU?=
 =?us-ascii?Q?K0d4jnRbL1oR8pEv+duhYieiihvP4A/ylp03U+BFV6A7bp6buqxqtugiutoj?=
 =?us-ascii?Q?49QQcYXnTHzJgqoPrGQIhEhNgkgUl+DHkDIpi1lfNdx0VEaBQNpXf+YCfVLD?=
 =?us-ascii?Q?B+oukXnIvthSyDyXCZLvM8oBQ3vw4GnIaQor2UyRNsI6855AfUvHwRglPVkO?=
 =?us-ascii?Q?upn30LSxOv7rjIfPyJvHnswR+Bon/ARm+LpLKx4Y4lJJ81APtSX/e2FNwB2H?=
 =?us-ascii?Q?5SL3B7VubLOwShtAlPhUkhBbB0LLc7QccEKmD56jH1Ga0am2P1EWjmvU8ztz?=
 =?us-ascii?Q?DqhemlRoFGdEYuYR2myiMwpmeiO3gq+ZWPcUSQazC2mjlROcxzK7LO27wwkE?=
 =?us-ascii?Q?gLosBYSQMFc788KuIM9VbhhRgGOAUogo7m7nosuhmJ/Li3orQdo2ys54D/Mq?=
 =?us-ascii?Q?9os9W6qVPAggGQL4i84gTM60156FbPpk9xFi6+G6XCbmrhNJMcOEjyLVyrKf?=
 =?us-ascii?Q?bAmdeTVPU456n1GB9H7fiRhdbwTkkclbwtzVabq86QHhb8oNGa+55fR/BRli?=
 =?us-ascii?Q?GQaQbpO8aqIZ0EfUpuU7fDnz1/3MvODU3iiYwQolBzKPa+VCX8U8hHDN7FEG?=
 =?us-ascii?Q?LCgywr0Tvzov42IMIwqWpJtLN+x+Dm+LnWIPG2VjlyV0PT3zm287Iz8Q/dtF?=
 =?us-ascii?Q?VF8dTkqpW6++r0rRLW0DzI4PWkjpvUzv/2jZGePpEMiNzdKg3LNsx+KVjnjR?=
 =?us-ascii?Q?9Dp9FaIlnV/Hr/VgJvMWl9C1dnL7+ffm76j64I9UoXdf0DDW9xVmLpaVWobx?=
 =?us-ascii?Q?7/inIuLX+bwu653SfE73hXgPKMdqES+BcDEXzzynqn8WznZ7EaObOqG2mQfp?=
 =?us-ascii?Q?xBJ59BXckkWuDpRMbQsOLaGM/a6wycOoCkSdWVtHp1NrzQa2qFM5TzmscHoD?=
 =?us-ascii?Q?hw=3D=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a9acc95-dd5e-457b-3d60-08de37377ca4
X-MS-Exchange-CrossTenant-AuthSource: SA1PR13MB6648.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 15:27:38.8500
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aqxnO/2kv61MN+F/cAk5avpHjZcejN2ECtqAVdX3FpKR8CdEBrYWXNnvv4f6T1rAETcklSvy5Bo+xDL/E5lYA+wedV0h7QlNQLjlT30ixV8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR13MB3953

On 8 Dec 2025, at 16:05, Trond Myklebust wrote:

> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>
> Ben Coddington reports seeing a hang in the following stack trace:

Thanks!!  Question below:

>   0 [ffffd0b50e1774e0] __schedule at ffffffff9ca05415
>   1 [ffffd0b50e177548] schedule at ffffffff9ca05717
>   2 [ffffd0b50e177558] bit_wait at ffffffff9ca061e1
>   3 [ffffd0b50e177568] __wait_on_bit at ffffffff9ca05cfb
>   4 [ffffd0b50e1775c8] out_of_line_wait_on_bit at ffffffff9ca05ea5
>   5 [ffffd0b50e177618] pnfs_roc at ffffffffc154207b [nfsv4]
>   6 [ffffd0b50e1776b8] _nfs4_proc_delegreturn at ffffffffc1506586 [nfsv=
4]
>   7 [ffffd0b50e177788] nfs4_proc_delegreturn at ffffffffc1507480 [nfsv4=
]
>   8 [ffffd0b50e1777f8] nfs_do_return_delegation at ffffffffc1523e41 [nf=
sv4]
>   9 [ffffd0b50e177838] nfs_inode_set_delegation at ffffffffc1524a75 [nf=
sv4]
>  10 [ffffd0b50e177888] nfs4_process_delegation at ffffffffc14f41dd [nfs=
v4]
>  11 [ffffd0b50e1778a0] _nfs4_opendata_to_nfs4_state at ffffffffc1503edf=
 [nfsv4]
>  12 [ffffd0b50e1778c0] _nfs4_open_and_get_state at ffffffffc1504e56 [nf=
sv4]
>  13 [ffffd0b50e177978] _nfs4_do_open at ffffffffc15051b8 [nfsv4]
>  14 [ffffd0b50e1779f8] nfs4_do_open at ffffffffc150559c [nfsv4]
>  15 [ffffd0b50e177a80] nfs4_atomic_open at ffffffffc15057fb [nfsv4]
>  16 [ffffd0b50e177ad0] nfs4_file_open at ffffffffc15219be [nfsv4]
>  17 [ffffd0b50e177b78] do_dentry_open at ffffffff9c09e6ea
>  18 [ffffd0b50e177ba8] vfs_open at ffffffff9c0a082e
>  19 [ffffd0b50e177bd0] dentry_open at ffffffff9c0a0935
>
> The issue is that the delegreturn is being asked to wait for a layout
> return that cannot complete because a state recovery was initiated. The=

> state recovery cannot complete until the open() finishes processing the=

> delegations it was given.
>
> The solution is to propagate the existing flags that indicate a
> non-blocking call to the function pnfs_roc(), so that it knows not to
> wait in this situation.
>
> Reported-by: Benjamin Coddington <bcodding@hammerspace.com>
> Fixes: 29ade5db1293 ("pNFS: Wait on outstanding layoutreturns to comple=
te in pnfs_roc()")
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> ---
>  fs/nfs/nfs4proc.c |  6 ++---
>  fs/nfs/pnfs.c     | 58 +++++++++++++++++++++++++++++++++--------------=

>  fs/nfs/pnfs.h     | 17 ++++++--------
>  3 files changed, 51 insertions(+), 30 deletions(-)
>
> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> index ec1ce593dea2..51da62ba6559 100644
> --- a/fs/nfs/nfs4proc.c
> +++ b/fs/nfs/nfs4proc.c
> @@ -3894,8 +3894,8 @@ int nfs4_do_close(struct nfs4_state *state, gfp_t=
 gfp_mask, int wait)
>  	calldata->res.seqid =3D calldata->arg.seqid;
>  	calldata->res.server =3D server;
>  	calldata->res.lr_ret =3D -NFS4ERR_NOMATCHING_LAYOUT;
> -	calldata->lr.roc =3D pnfs_roc(state->inode,
> -			&calldata->lr.arg, &calldata->lr.res, msg.rpc_cred);
> +	calldata->lr.roc =3D pnfs_roc(state->inode, &calldata->lr.arg,
> +				    &calldata->lr.res, msg.rpc_cred, wait);
>  	if (calldata->lr.roc) {
>  		calldata->arg.lr_args =3D &calldata->lr.arg;
>  		calldata->res.lr_res =3D &calldata->lr.res;
> @@ -7005,7 +7005,7 @@ static int _nfs4_proc_delegreturn(struct inode *i=
node, const struct cred *cred,
>  	data->inode =3D nfs_igrab_and_active(inode);
>  	if (data->inode || issync) {
>  		data->lr.roc =3D pnfs_roc(inode, &data->lr.arg, &data->lr.res,
> -					cred);
> +					cred, issync);
>  		if (data->lr.roc) {
>  			data->args.lr_args =3D &data->lr.arg;
>  			data->res.lr_res =3D &data->lr.res;
> diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
> index 7ce2e840217c..33bc6db0dc92 100644
> --- a/fs/nfs/pnfs.c
> +++ b/fs/nfs/pnfs.c
> @@ -1533,10 +1533,9 @@ static int pnfs_layout_return_on_reboot(struct p=
nfs_layout_hdr *lo)
>  				      PNFS_FL_LAYOUTRETURN_PRIVILEGED);
>  }
>
> -bool pnfs_roc(struct inode *ino,
> -		struct nfs4_layoutreturn_args *args,
> -		struct nfs4_layoutreturn_res *res,
> -		const struct cred *cred)
> +bool pnfs_roc(struct inode *ino, struct nfs4_layoutreturn_args *args,
> +	      struct nfs4_layoutreturn_res *res, const struct cred *cred,
> +	      bool sync)
>  {
>  	struct nfs_inode *nfsi =3D NFS_I(ino);
>  	struct nfs_open_context *ctx;
> @@ -1547,7 +1546,7 @@ bool pnfs_roc(struct inode *ino,
>  	nfs4_stateid stateid;
>  	enum pnfs_iomode iomode =3D 0;
>  	bool layoutreturn =3D false, roc =3D false;
> -	bool skip_read =3D false;
> +	bool skip_read;
>
>  	if (!nfs_have_layout(ino))
>  		return false;
> @@ -1560,20 +1559,14 @@ bool pnfs_roc(struct inode *ino,
>  		lo =3D NULL;
>  		goto out_noroc;
>  	}
> -	pnfs_get_layout_hdr(lo);
> -	if (test_bit(NFS_LAYOUT_RETURN_LOCK, &lo->plh_flags)) {
> -		spin_unlock(&ino->i_lock);
> -		rcu_read_unlock();
> -		wait_on_bit(&lo->plh_flags, NFS_LAYOUT_RETURN,
> -				TASK_UNINTERRUPTIBLE);
> -		pnfs_put_layout_hdr(lo);
> -		goto retry;
> -	}
>
>  	/* no roc if we hold a delegation */
> +	skip_read =3D false;
>  	if (nfs4_check_delegation(ino, FMODE_READ)) {
> -		if (nfs4_check_delegation(ino, FMODE_WRITE))
> +		if (nfs4_check_delegation(ino, FMODE_WRITE)) {
> +			lo =3D NULL;
>  			goto out_noroc;
> +		}
>  		skip_read =3D true;
>  	}
>
> @@ -1582,12 +1575,43 @@ bool pnfs_roc(struct inode *ino,
>  		if (state =3D=3D NULL)
>  			continue;
>  		/* Don't return layout if there is open file state */
> -		if (state->state & FMODE_WRITE)
> +		if (state->state & FMODE_WRITE) {
> +			lo =3D NULL;
>  			goto out_noroc;
> +		}
>  		if (state->state & FMODE_READ)
>  			skip_read =3D true;
>  	}
>
> +	if (skip_read) {
> +		bool writes =3D false;
> +
> +		list_for_each_entry(lseg, &lo->plh_segs, pls_list) {
> +			if (lseg->pls_range.iomode !=3D IOMODE_READ) {


^^ This seems clever, can iomode be zero here, perhaps if another layout
type doesn't know the rules for it?

Otherwise, looks good - thanks for the rescue!   It would have taken me
a month to get this far.

Reviewed-by: Benjamin Coddington <bcodding@hammerspace.com>

I've been musing about NFS growing something like is_sync() scoped thing
that the kernel uses in other places - then we could modify our
wait_on_bit() interfaces to complain about it.
</half-baked thought>

Ben

