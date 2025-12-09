Return-Path: <linux-nfs+bounces-17012-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BEBF1CB071C
	for <lists+linux-nfs@lfdr.de>; Tue, 09 Dec 2025 16:46:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9338A3009AB4
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Dec 2025 15:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 263522641E3;
	Tue,  9 Dec 2025 15:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="CgrXCj7o"
X-Original-To: linux-nfs@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11022128.outbound.protection.outlook.com [52.101.43.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F211A9FB4
	for <linux-nfs@vger.kernel.org>; Tue,  9 Dec 2025 15:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765295170; cv=fail; b=C7FjSMZUOl7d7f4R17PwOp9cB65vwAPUSQexZnAg/GNL5SU3u2P9HjZVjkY6o75WAkMpfjXJapHd6MfrPqpmdgA9IXiQWGus6TuP0ZkMpfalY5rlXA5whuJ20PoTz6Tuur33Rx/0JBpKGbla1YXpJHJuTVQQGPohHp1rqyeVaGE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765295170; c=relaxed/simple;
	bh=a51EbzyOGF/HX9/7uBTQ+274ax664xuZn8QPdf3PwSI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fiK9MNeEYJquUFizlIPo/zDYDOd/wnchLrNQnEarzcnlSDjFOvfCgxKD02XJCx8sKwhQ0JW180K86K3G4wtVosqMraupsejAMTm4VtTfrjdjlZl2YczUA3RN9tDdIaVMBdRdV/Jp0YsIA6jBHAHuDxifLnSGcMCapUW7tGfu6fc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=CgrXCj7o; arc=fail smtp.client-ip=52.101.43.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gxWAQIf+VEb9ktFamHS9wwsJhDafM/74NDaLJBeoBD7ex/8gdWR6VJeQS4zFGMPUfv9But43eaATorqzFw+dF/i/T9o+DyHjUthLcb3b6r1mgH6As7ahHEtq0u9T8XTBAqgB3pxqo/H7kbC4zKKt8J2bxBW0BgDvW/DKNgvJi0PTgumRYqarpAKiH2zWezNgaKMH2MMidHdjvkya5lzbHY6ChAKlJgTjlLp66QN4eUIsFBGfIIVj9vS8ku6FKPX2BqGzly+lAwf4Pw/yhMWCnN47w6k5xkSxPFUWSVRv+2VaNDJ5MHaWcs9mM7Rnn8Hzfp7nehLjo4+T445b3bD7aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s7lZ4HIG4BgKyJy/p24ZV/WfwHod9eGFEgvHcCyiZ0s=;
 b=cscCxz834Yok2dk/j8Xbbh5EYvIJAZTHRLFrFDoF3bGtjrzXwI+0M85IQLgwfbYXJST5fcKzMYflLwaPBiQPNdpg/4l5aLhriJko9RndJ6STZNSG4LEQER9o5vuhHQ/qMOGjtsX1MpUw8vcynEH70WmURIYghLczGOpdRnkEg3lvoqA4q7NeqqGQURVe1TICD/wKwOJwYloQrtI75vVPDcyVnuSaho/IIi50/jWG/FGjd8Q7UX0PADtZf4w4N2cEY7b7U6eY3F+sXmrEKB+mCb03bk8M/l6LHbkWLityZOOdIFKuDon0L3d1Z+TaVwGn4vVTD7RXd4fL+7cmiWlVjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s7lZ4HIG4BgKyJy/p24ZV/WfwHod9eGFEgvHcCyiZ0s=;
 b=CgrXCj7oXDcOD3B8TIlKEHtbeqWsYkbdJc4qvM0gvOvBObz4trmHQ5Le6+eo+tBF89vj12RYxAM+va4Fdn3yIMhjDHVhlSj3zxvotpVD190OTD2YLZ4TFQ+kb018t+5tt1rUzwTp5V3hKmEaooV8MEJbwVLsp83QoDTWpTwCpHY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from SA1PR13MB6648.namprd13.prod.outlook.com (2603:10b6:806:3e7::10)
 by MW4PR13MB5530.namprd13.prod.outlook.com (2603:10b6:303:182::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.13; Tue, 9 Dec
 2025 15:45:40 +0000
Received: from SA1PR13MB6648.namprd13.prod.outlook.com
 ([fe80::c48a:c42a:aa18:2ef4]) by SA1PR13MB6648.namprd13.prod.outlook.com
 ([fe80::c48a:c42a:aa18:2ef4%3]) with mapi id 15.20.9412.005; Tue, 9 Dec 2025
 15:45:39 +0000
From: Benjamin Coddington <bcodding@hammerspace.com>
To: Trond Myklebust <trondmy@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: Re: [PATCH] pNFS: Fix a deadlock when returning a delegation during
 open()
Date: Tue, 09 Dec 2025 10:45:37 -0500
X-Mailer: MailMate (2.0r6272)
Message-ID: <B737E0A1-A462-4129-879E-417290E96A27@hammerspace.com>
In-Reply-To: <0988361336efb7d2b185069a870b1cc7bf356ccc.camel@kernel.org>
References: <24ff118a0bc9c9a845df3987e532365e9d6ecf2a.1765224921.git.trond.myklebust@hammerspace.com>
 <3090400A-1FB8-4DE3-AB71-08D2D7451ADD@hammerspace.com>
 <0988361336efb7d2b185069a870b1cc7bf356ccc.camel@kernel.org>
Content-Type: text/plain
X-ClientProxiedBy: PH0PR07CA0069.namprd07.prod.outlook.com
 (2603:10b6:510:f::14) To SA1PR13MB6648.namprd13.prod.outlook.com
 (2603:10b6:806:3e7::10)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR13MB6648:EE_|MW4PR13MB5530:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d970a74-8086-4b2c-8dc4-08de373a00fd
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xOINSehveCzQ/iEj5R6CCpmX1N6mDrQz93D3MnbROpmXHBamQ/+ZTJHRASYs?=
 =?us-ascii?Q?Q9fyhbdaDsxpv8tWqezcWq8UxMoRsvzSg0J3PIwXUzkw51GXmAsd1ztXTGKr?=
 =?us-ascii?Q?+DGsTn3bFHQ04sI62MkxY7N/MBOmqxx/+T0Mbp7CYaFywkYaQ5OyG28jHeTB?=
 =?us-ascii?Q?aKLSlpzaUqJyXKy/VdsN+wkJNsoMZ6FfHHftRqhJkuRChkJYY/kkQ1tjffsJ?=
 =?us-ascii?Q?FqZ0NcXpaSZE44cK6ZESNIKFMhbvubjkDAnQaBeC8Snso8JrukJ3UT4gYIUG?=
 =?us-ascii?Q?YILFZIa8RKZK8Ihe+KN4L4s593TxwLHTpgCUZWBuInsyotZJsoAv2R6pYPa5?=
 =?us-ascii?Q?QrJqOQIXWqqydMvVX8GQKNe4X3d6IlMC7Ylh/hlEDBNPpRt2/ycHIKu8auyN?=
 =?us-ascii?Q?0XCzozXY8ryuOXYrmjw//q4Knjkox3xz9ZCIV2ov0ZY0AdjJd6VXi5ooXwZX?=
 =?us-ascii?Q?nDNyxUKKXpjExjUWc6jhoXj+/Sy6PwHXhJCOMWE0K/4j2Vvt8AKzBJ4TCrD0?=
 =?us-ascii?Q?btqyCSK+bd0vTRXwvrFyVKu2tMxh95PLUVHB7OG6XDlwqjQoHLsxJd898+Id?=
 =?us-ascii?Q?KEXZIL/PVXyAMLtjbHW23Saamf2x8ySkYKfLHwwh2fkOmYMBtET7MQ5t68tm?=
 =?us-ascii?Q?6pcQmvEjREMPxpPaIa0K56kYpWvj/TVZzsO97Ci62rTA/hxAV4xXcNVKaPpz?=
 =?us-ascii?Q?qEzgXR7Btx5qLXEL+2hL8PBgBXfe5M1CYRrTfuXeS737A/Y61Gjx/jPfJgnx?=
 =?us-ascii?Q?m9my8/bVChvelITNgO9yWoWywAkk5WqPTvF/zlgxPyf2oIs6oWk4NcMbhSnl?=
 =?us-ascii?Q?+YIElSNysTVshsAgwdRbJFuTdlmEbPa7TAqMbmBCIYXCq/J3Z0ouQYexB8eE?=
 =?us-ascii?Q?8ziDGwaRYjKpyRmh1HkIlGgMg0qMVfPtRYJ2UWFbbs0h0t/pgTp5ifdbTrpZ?=
 =?us-ascii?Q?SPJyiqF9r8E1Eh36U2ymsEhjiYnpurHEtnscNgbRO8NFGmBlststqWyMiQK2?=
 =?us-ascii?Q?+77DE0gWKl+4jRoXsjDTCTF3ZcayFO/HOlNcmQ/fE0Sql+LjcQY911fbqFVp?=
 =?us-ascii?Q?97bHxEVkH5BYI1i3kgxxtz/8cgskIyRBvFYrYZ+NGcJV7WYrxxeG6/F3aBOk?=
 =?us-ascii?Q?pRoVrcOmPv2KaXYxslWUl2iC2aL5bugYactUMuY0J30nHXT2hmcWLg7hlkNF?=
 =?us-ascii?Q?gqaXWG2Lwf7LSh7vp1nV0b1P+iFIdf5szKJoqtIXJmYsgEsIB/1AM3PLf5Pi?=
 =?us-ascii?Q?TwsJVmM+MGTA51HPqFJ9lyFmKN85FATU/cVXo4NLaY/uIgUeLKE72PeYjuew?=
 =?us-ascii?Q?+fhAateUJ9Bk0DLRHk1zTCgc9FgzwXcu3vA69OyXfbeNUqR3G61tMDUrKowi?=
 =?us-ascii?Q?1qpsQZBRFTj4LlnnZwrSdIFH3pL/IlLpjrFWOSIqx4851creDptXKXw2Gqeo?=
 =?us-ascii?Q?HtZ4/weFn9vGYFiRIbVmMswY6gYu/ROx?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR13MB6648.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?maDhxnwW5ko0qLDNC/oKDl7Uu/8zYZNBM9Vld3ipw+WsbB8T5MvI/y7fWNeW?=
 =?us-ascii?Q?lo/zf6TRR60+yh1qyZIdKVBmNP+J76z1SS8C9HLyUyXjAJ8+oi/G4XzTBgwv?=
 =?us-ascii?Q?xxLaFHf+Mx8pfIr8NCH83YNrNiLVV3Y88u4AnNu65m8Dyfiqf7KUgv27zwgK?=
 =?us-ascii?Q?guUDaAp0vOCEbeTAwTxmXG+B6dfOETU5qU2KT4sSdeTTiRZ5PVrx+G44M+mb?=
 =?us-ascii?Q?WqmWXXsWlqHG+ppkTsnkDhv8/mUxwZ8whfgRGenGJnHfaGtIZdfMcxi3t9dR?=
 =?us-ascii?Q?2Ufyx+Zz5kj4Xhi4Trr8/11HztSXEPsF4pe13hf02OSYzWb3CLw8zS6IxvMg?=
 =?us-ascii?Q?+bO6nxv+Cpch25fIeEb29UjJc4od0VDJ8jmB6YUBvryExm4V5TzWZcL+LNN7?=
 =?us-ascii?Q?IvYBjmEwMzin7ZY1t/DxT7tEcEm6ecHPmHSRMzMEQwSjRu0GkSh/hnrx53l3?=
 =?us-ascii?Q?2fJ4y+wP8Vgz2qgT0LBIvkj+UoOhCHKgB+YS0qxp58s0ofdSEtgdY/DuIX4D?=
 =?us-ascii?Q?lKTu9USHLqqEamwS3wopRIxUP4ZXZG6XCmrjOBKJM1GH8J/VNT6bPAt8Bn4k?=
 =?us-ascii?Q?zBRlwsiKNO9ALCjNMEL4aaIbU53/PWHYpA/uMTVi+uWmDPj4XS88P2nOngSJ?=
 =?us-ascii?Q?rVVyQIXqEWXw6rY+7PNRsEhwBFOPPrMAAm8zi8VNUOLRg5qBkvctfN06d5ij?=
 =?us-ascii?Q?Q6lEW5bAJ7gAcnsiULr1mIFnSFbJT8IIAfJ9FC9JDomwLIi/Rm62X4Ucj6l5?=
 =?us-ascii?Q?KtMDfaOuj/B+st4upHcrQlJfk2oFJCLJgPYQ0+IPOQlNalJlLvdoBr+jtYGy?=
 =?us-ascii?Q?xmwFQ27UK++1sQ/oPM1zgbG4dJQysHbWGoqsay5QB5uQo/ADad3OIMurgSzJ?=
 =?us-ascii?Q?L7LYuD04EaWmbXDeLHwUl0SB68S+G32/AJM8Qsz30ZjTBRXckoTovb29YXCb?=
 =?us-ascii?Q?pyTgvVkxnOtKJuyBDAukxROqdZkhBQxSyJIMjT2B7ofTrvz8oXhrzlQTgMin?=
 =?us-ascii?Q?KjH5m3Zl9DkF5d+wM82nngFoebmjRk1HcrvkKDOo3/UVjqIziSaEeT3JLQ6O?=
 =?us-ascii?Q?PCevTbnGCVPUB4PbBTgjwLYlNBRAO9d5WGf/LUBaLThWL/r53iI09jvfyz4c?=
 =?us-ascii?Q?6rTKiNhutIs43uta4ANhozaIx3OYE0tPTzgjnU7yanXBejaQ3rbzLktbBd69?=
 =?us-ascii?Q?dm7Ine+Km1jvijsUtTmyJbOShnkf358c9fLgJDO62IDKDEoAMuNHUANYNUEI?=
 =?us-ascii?Q?NjUx0wKQtkkuXQaRiGLhnX8WtC9mPtqX7R8KKJbkHldyXN6NJHOv2YqbndoN?=
 =?us-ascii?Q?UtDuDpmMmhN81h4xUbk4QD4v3ciBdhgLbbH/lx97kBHrxXm6JRhUpEPJWNUS?=
 =?us-ascii?Q?4xb24k2zLc/Za+jusa60Lfc/RTt1r2eWn/CjAlEt/P5Nt7piBtlW+WoUramU?=
 =?us-ascii?Q?KqD1vcBqG1TN3+GWDgJHLxqG1W6KQDvevnQ8rVwimaz5EBw/c7I6oW9Rfdz7?=
 =?us-ascii?Q?bQC2Cqi3mS0WxyBLwB8K9zo/nnAy0nUllQdXpbvpiFRVvT0LXdBz/LlQbdZA?=
 =?us-ascii?Q?8Fh5gadgHD5TkKzBBJ4W/GcPw2ZqSEUtlX+EjLpe7KnvO2L916hIHAX/zW9q?=
 =?us-ascii?Q?wA=3D=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d970a74-8086-4b2c-8dc4-08de373a00fd
X-MS-Exchange-CrossTenant-AuthSource: SA1PR13MB6648.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 15:45:39.8555
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +puNaOmqrlAzLh/EQ9/8LuOhLrmA3xOZ9j9x6RFMLH/dH+RboFpjRE7vq5vFXAFf0ILy2048bogvuEMQ8LmKaWLeSnpLYDEZ4fLfoCMSHqc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR13MB5530

On 9 Dec 2025, at 10:39, Trond Myklebust wrote:
> On Tue, 2025-12-09 at 10:27 -0500, Benjamin Coddington wrote:
>> On 8 Dec 2025, at 16:05, Trond Myklebust wrote:
>>> @@ -1582,12 +1575,43 @@ bool pnfs_roc(struct inode *ino,

..
>>> +	if (skip_read) {
>>> +		bool writes = false;
>>> +
>>> +		list_for_each_entry(lseg, &lo->plh_segs, pls_list)
>>> {
>>> +			if (lseg->pls_range.iomode != IOMODE_READ)
>>> {
>>
>>
>> ^^ This seems clever, can iomode be zero here, perhaps if another layout
>> type doesn't know the rules for it?
>
> The only valid iomodes for a layout segment are IOMODE_READ and
> IOMODE_RW. If the server doesn't obey that rule, then it is violating
> the NFSv4.x protocol, and should be taken out behind the shed.

Ah, got it - yes I see _ANY is only for LAYOUTRETURN and CB_LAYOUTRECALL.

There were some 'pnfs_iomode' vars in the kernel getting set to 0 for some
special cases, but I don't see that happening for any lsegs.  I just
wondered if another layout driver might trip over this someday.

Ben

