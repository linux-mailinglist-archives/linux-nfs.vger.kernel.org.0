Return-Path: <linux-nfs+bounces-17318-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 09B7BCDFFD6
	for <lists+linux-nfs@lfdr.de>; Sat, 27 Dec 2025 18:00:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AF5523016738
	for <lists+linux-nfs@lfdr.de>; Sat, 27 Dec 2025 17:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5146812F5A5;
	Sat, 27 Dec 2025 17:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="Eb4RhWo2"
X-Original-To: linux-nfs@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11022126.outbound.protection.outlook.com [40.93.195.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41238834
	for <linux-nfs@vger.kernel.org>; Sat, 27 Dec 2025 17:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766854832; cv=fail; b=b/RnISCexPFgfxdECT3PDRJcxCvGDGQc31Z77Sx4sDLc6c1gTD5TLjFAWiX10aLxB4zvAguqsWRMhkc3tnuQi7ALuSQgpd2vXiEbsl+DWon+CoVozcvaKU4g3gDz8Rnea7NswB2KJkxXBDbwesBkrOdVIHj1Pvx8u58skcs9+50=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766854832; c=relaxed/simple;
	bh=rIalNp3GGa8iIkarhPgHiUk3edJxeChvvk8rJXsvNuw=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=PISxBrpC55OT9aEo4GmwaHl74KUc1WSICf4ODAc7bAM4HS6e1zwo58LU2f1Eh3BwBVa0PjBgQAodMw1+Sx0GK2G/jpg2r8Te/6nEp+ZigGM2yx0Izh6KuJBBw5jiKPsFJ6xxsF0mhzcC/HVaxQdAyN13oO5ALXaRXnl1lAjlBN8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=Eb4RhWo2; arc=fail smtp.client-ip=40.93.195.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Swybd27G9o+d4OzutQlJ67skKPMJqUREaawuxEy4oYVBuk1SoskOk8jBUy/5jbIiCkIDT4O8Gwpoqx8pHaUFYXhvhQHz6dxHGV+lB5IJXqQ6ZirzoZWWoOVjRjepHTlyI7L7Y9Bo4r76fabR/wmTF7gzew31iOQD4/bTYeroI2mdPS/YXakcXmb1lgx9RbSvbg2OZAwEfym3fHqRQnS4QvLGI+1jYkdgkwTdNgpKSAp3ZgFSmStMyeS2cZclEolWOf31w8vWQSdt1Ln8do9d+ypCgbYGtKnsWsdq1ejyuZbIewJJZF8vY/JMvi9Xsc3UlpzsWxKzVwJdmN6rqRiyZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JgFE6EwCh1bv86Z/4M/PpLd1WemtrWgzTvphc+o8MaA=;
 b=D0zMjsjlnBe5ZazjN1mY/Pyfh4FBOsP5teEku+32tkoWNJoxMehQaTb3GS5lrCqwwz6ihjQRUum5ttRK4LkfGrRnO9O6325IouvGvRi4/eRRsa/ocAkWWenHqiUFb74iE8EPaQbyYrjkcP89e73TWJuVNBHYTGFEnXlA1hXnihYIA8CGfMGuPq1pxkcfU97MOb5nZxnWRfiLMg/ZlEfKwgCdVQ/Gv2BlZRDUeEImGw09PpML60mryXIOfAzctGeghY9pYTdetjrjuJZXneIb20StiUcVtYyvdtNGvP7AKsCpynzfEQo1tUuaeJiI28v+8u9SMIRWw0/+aaMSAspA0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JgFE6EwCh1bv86Z/4M/PpLd1WemtrWgzTvphc+o8MaA=;
 b=Eb4RhWo2wkQR8rBXd5Ztz13cLfMmI+oXa5qbWu5wlugZ9diRWF4X8CCmWGECiiV8IEvgAfAliz5fTIa4XfFp4YJJMvY8uGxvCLZI9cg/z29jYJmGaseQzj3M/ESSjyVk1m8o+/bRhuFHPy3xO1AkKqJvrJS2F58vXiMofqD2Gaw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from SA1PR13MB6648.namprd13.prod.outlook.com (2603:10b6:806:3e7::10)
 by PH7PR13MB5406.namprd13.prod.outlook.com (2603:10b6:510:126::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.11; Sat, 27 Dec
 2025 17:00:26 +0000
Received: from SA1PR13MB6648.namprd13.prod.outlook.com
 ([fe80::c48a:c42a:aa18:2ef4]) by SA1PR13MB6648.namprd13.prod.outlook.com
 ([fe80::c48a:c42a:aa18:2ef4%3]) with mapi id 15.20.9456.013; Sat, 27 Dec 2025
 17:00:26 +0000
From: Benjamin Coddington <bcodding@hammerspace.com>
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: [RFC/v1] kNFSD Encrypted Filehandles
Date: Sat, 27 Dec 2025 12:00:24 -0500
X-Mailer: MailMate (2.0r6272)
Message-ID: <510E10A4-11BE-412D-93AF-C4CC969954E7@hammerspace.com>
Content-Type: text/plain
X-ClientProxiedBy: PH8P221CA0036.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:346::25) To SA1PR13MB6648.namprd13.prod.outlook.com
 (2603:10b6:806:3e7::10)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR13MB6648:EE_|PH7PR13MB5406:EE_
X-MS-Office365-Filtering-Correlation-Id: 54ce61da-6241-4222-742d-08de45696eaa
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Z2C6QSV6OUAYpqsXkZPXoK/P4O79cdwWUd5T0v4MvAPVU9Sac/zvSS2cRsMa?=
 =?us-ascii?Q?/Be33Zl3G9A7JIaGOmN9cazIRAquZwHLVnCwbECAbzYXvfmPXTkklHZIZqHS?=
 =?us-ascii?Q?iXGU0r4l/fR4Ivkz6eWYN341r/i4OzBWmgWh+yiNLPLDA8V/mamKSttxYsKK?=
 =?us-ascii?Q?gdbVeW2xE/eWfB+URjbyMlXk6pXoRJse7qUXrPyDWPYOgIikrXl7rgjt1ADi?=
 =?us-ascii?Q?rrLLwpQAzoqrF6teD5ltFlvKPINhDS9t19besMaWHAywCfPTVpzWKdc6G/YK?=
 =?us-ascii?Q?nRXMnGUzYIgGv2Dwh0er2Dapl1LIX4RwVeaQ0n5PlZNQ6xXdboQeWZ2ygBGN?=
 =?us-ascii?Q?aUilhq+3ouirQHhScl1zp9taajZxXRUPwVySVCar4q0BITWi/74JuTI5LN2n?=
 =?us-ascii?Q?Sx1EirDbd5VviYtkNszaXzfjtViSH8FIc7bmT9DHdm6CkeiF+vQC4dHr6GwD?=
 =?us-ascii?Q?eq1qs34crKmaR2D2nmbmuLwaWN15oUW7NljnkIe6il8wdhTZuryszOnqLFWR?=
 =?us-ascii?Q?NpHRAiwfNVo+vuEEnqtfWlWz3Fe1GpBLZb5oSD47zlKSvD/g2Zw53lihl2oN?=
 =?us-ascii?Q?swm94xlmgw43YnyCSOh17gKotGogjjvrDoikZYWccztJ9YyFyY4RjVWsgEXw?=
 =?us-ascii?Q?LkDX8ueI3mLdErVEgQCdVzm10JvYAZ28QLYciPrb0/ogOHDIcmLqDK3Kqqnd?=
 =?us-ascii?Q?aPvIm74NQwvFyzybmt02JWKuj72oWikoP15GrBdxdTll+RXAIU2vuscGCsbr?=
 =?us-ascii?Q?4xO/kMBalQXzuzcaqWFW1fm5orLVKMVdBQaXQJg7xLLgUBIUXdKmFKhiP01p?=
 =?us-ascii?Q?gCc6OswKOWHoyiRChLK18nOIPdEerGAcLe327UoYJIVpa3kjg31SybYMjZ+w?=
 =?us-ascii?Q?6r7X/rLjuGoOLoeu7iI2sREk2gAIZHJzK4TGkKBeAgr270aXoaE3eA61IFZd?=
 =?us-ascii?Q?TkPeFoc1LzTsCi93ROWZkuwNbndwXbJRVfWNklaniavCg6ydh1CARBRLZrrN?=
 =?us-ascii?Q?3BDjw2hpMaG00eDXBp+pHegjzNFnMl39IGWCzbmdx3zUlhisbTCX2XYE7UoK?=
 =?us-ascii?Q?++f3Cv8dVOKWFFrFe6zATFJ93LclvLWMURs+UCpLKMZlzywZondOx87Dqq2g?=
 =?us-ascii?Q?l0dcQncjMhQlE8+KQqwE9rfvAg5xZb6XqpYvZGV5DFSNY9tf+b7Bat//lTRr?=
 =?us-ascii?Q?aVFgvcjvCUiM/v8DWyLD/tDSAYSAKVCPPa9fmaFN7KE3DUsIPc5idexjoE2a?=
 =?us-ascii?Q?+dAxY03rGmtGf+Eu3YSG5pHfuDCNtRQIlsEO0hpIx3KeZLNwTgUVBiovW0U4?=
 =?us-ascii?Q?uFGbS6rVanh8jq0ZtqRJcJ5NvxUxBGjI8S+1sW3mJVzqYD6MBVslzddb/ggU?=
 =?us-ascii?Q?YkvvWmfQapsrrBqgTK9gLOu0i6fw4x05PdoxnoKrh/SfRvGwpKHA/VRUaI1/?=
 =?us-ascii?Q?1vTMaSmEmswDlOxcuPQg1aeZcZVyzZ8D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR13MB6648.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?i3QfdI+nD76ZXQw98ba6t3cFNnJgNXEzBNTwP9TJpoS4cvDdjY5nEv3TVAkI?=
 =?us-ascii?Q?5vJmO+tHxR35y2aD2ldNyabDnrhB8xgvv3TpcL2Yj3jaN3Lh//3sInnGFs4W?=
 =?us-ascii?Q?3mkorCEVT3cDMjgjlM7vKnGKas3aI8PTt+mT7BgSU1BB2d2PsGOQXo7olaTB?=
 =?us-ascii?Q?zyUGk3hASBgjMbKZci+8IDEENit3Di0v46bkcCJZpRpe0gyfELI7yMGh6yEA?=
 =?us-ascii?Q?yhDb/a0FbnD2mUZvB3ZKjR3ChWWUzZsSoyea/NazlxKoQ5hqiXUsNWTgFBH/?=
 =?us-ascii?Q?7sxIRcbxXWSI1Pbw0oBVBgO2vIGGPn4inoV0zqTGWMJpwMdgtdRsKXK01jTC?=
 =?us-ascii?Q?PH2ecIkBFAXEcZfyAx3GZken1DH9CZJiSWMbHKEAMBQZ2CynX9bfcKIfmBPk?=
 =?us-ascii?Q?QagwVSO52MQQHoFBYzYCujerHhlPW8o1TrwR3N3Q5m/JNr2j5yHiI+fgwhj6?=
 =?us-ascii?Q?0kdz0+PQRAjlv/SwbpCYWct44I6bHilkDWKQN0Zizqfqv47qJOFI9D1UPjG2?=
 =?us-ascii?Q?1rKCUissD1Pa3gAv/Fa2hnvZ62+z04FMJRlz83cwbgoSme3z0WuXlyhIDnPU?=
 =?us-ascii?Q?TrIXHlcQQbwtPQond87PdBJZtXFThNW1RphcZ+efS/aPPyg84C/dBTiRUQDc?=
 =?us-ascii?Q?YHHHHEsgHIHKgqMuqaNSP0kg8q4o9E0xPnB5Jp2zBxvrYgQ3xSfyeXXcckF1?=
 =?us-ascii?Q?SR/+1FlXQmpQSJC9zoWPuaurPlYtV7bIZM5blVP7piNsSMHRGyRa4KWKhEEg?=
 =?us-ascii?Q?uyuFKQIOLYbY1YurraPIG3DM5AFN9wDnYSs41ZipqjOW65t8UqIdx+DyVXop?=
 =?us-ascii?Q?wxIqdUSC0LIqRR9ax+aKi6X9TU76AYwlkpt3Ty9a7VJfWX6NoeSQkPFBc8T+?=
 =?us-ascii?Q?TCtR4H2Dkysf2R7MpRTnI5MvDSzCioW6p1rrZj/mU6jV3oR/Jg5SgmzWw5/f?=
 =?us-ascii?Q?Sv3is6EaP8CDQXN6R2LNwdodbCo90z0WhUBjM3K1If11D4/IeS+Be3IlGZxF?=
 =?us-ascii?Q?NZe5peu1Lw1BYpj0D7qVarf5D3F5iKDmBu8nsnHMrO9J0odWs0wc2XGu3/D/?=
 =?us-ascii?Q?fuBbNMSgG6sR5x9luwOyK8p8QuZ9LKatb5e8OEr2pdUePoJglAKc2AVQHk8d?=
 =?us-ascii?Q?Gmm8vz04MDhK91+H9KciS8Ko6oD2WFh4awIdXdu/iM62kKU48z8A4bQIVVpT?=
 =?us-ascii?Q?crK0SekbIgfyu4jWDfcjDr89YJB+KfVZMRocHNyUprLr4jqdfsMR8dNZbK5M?=
 =?us-ascii?Q?acKiW5KvWnWciK48nYFUz38MhbEmNCVSRpgEzAk4tvB4XBjfG/nQKTzffqKs?=
 =?us-ascii?Q?vJmNZucjsmLEJpJpH7b0ZuKbPcc10LwanMg5WX62niI0zOhUxZzXN1eH++uF?=
 =?us-ascii?Q?BN6B4w26W7D5kHwpqELwvz6cu+PsSi5iPPbk0Iyn9cvjhBejbiuZa5x9i3I8?=
 =?us-ascii?Q?9YV98wmYnVYvjVnCGV67QQa0ynTvhpJ/hTPWgj4Q+K+/Y9O2D9vBkuY1GH7X?=
 =?us-ascii?Q?sYIrhGmzaW5lXWufxo1DbMWM9JkMylaFNBcTWs0h/ofGxJnTvpKr6Bb0WLgj?=
 =?us-ascii?Q?3qIgY7+4fILCqpn9cH+CNBBEPLZyRWRTrmDgSx0EJkXT/BcFS6oGmbXntgt/?=
 =?us-ascii?Q?eYx5u1fKkCiM+/rN7gUCm6TgE7G9V0aqK0yj58TyDRsRvP/MhBbtKZ0uBdJN?=
 =?us-ascii?Q?MBInEJCZ3dWzcDe/4wWH467h0uPp5E4S9flQm1oUnhHsETJ54tx2edS/5dvk?=
 =?us-ascii?Q?ZQ34hl1fQc0DHvUeAGvUw8ocquXMTDw=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54ce61da-6241-4222-742d-08de45696eaa
X-MS-Exchange-CrossTenant-AuthSource: SA1PR13MB6648.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Dec 2025 17:00:26.5072
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5knW1jt+sf0LJZ6MblX5AB3Wy6F/dLRrgfo5f+royytvzI8qZBnJLTFPPrJ62pqC2WGxI2w6pMaifR0pzJYwPvlUHYn0j8AuM5TejifOCXg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR13MB5406

Following are patches for nfs-utils and linux kernel to implement kNFSD
encrypted filehandles.  Currently, kNFSD's filehandles expose a lot of
information to anyone able to view them.  On some systems, filehandle
guesses can be used to subvert security measures.

This is a working implementation, but it is still in rough shape - there are
various comments left over and I would like to introduce a few more
tracepoints and refine man pages and/or add kernel documentation.  I plan on
doing this work in parallel with accepting critique and refining the
approach.

That said, I'm posting this before traveling for a few weeks and will be
slow to respond in that timeframe.  I'd expect to have another version out
later in the month of January.

All comments and critique welcome - thanks for looking!
Ben

