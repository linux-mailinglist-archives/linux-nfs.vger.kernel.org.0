Return-Path: <linux-nfs+bounces-18260-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gD7VGxgxcWmcfAAAu9opvQ
	(envelope-from <linux-nfs+bounces-18260-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Jan 2026 21:03:36 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DAF295CC73
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Jan 2026 21:03:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 69E9884314C
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Jan 2026 17:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B600C4DC55A;
	Wed, 21 Jan 2026 17:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="OD+/HTU7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11022101.outbound.protection.outlook.com [52.101.53.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC5D4DC542
	for <linux-nfs@vger.kernel.org>; Wed, 21 Jan 2026 17:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769015175; cv=fail; b=FDSeltcOQuUoIu/s2wXlVWvtmj+QtePgnWiFuV7Cdpkr1OVm8A51G/6lnLJivT+rPlrd8M/QSVD1BIBD1T2YJS1wCiwfe3y8ALa52KcwGAGZAhrY7qy+1io2hzLQJ32dp18Aoa6IAqVDWQr0XEqOdzezhl+wCJSDcBqCf6ESZIo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769015175; c=relaxed/simple;
	bh=nxCehqYxrRoSQBpQruaeqFhXF79CK+bdv0JLwdP8be8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iNp7wwIgLVlqnJyxvKBdRjG/yMuP/x5qA1uhPLHNB2xKiyLslkSaHrVhnHAdvBvDjE8jxYDDJlGx5TZyunQqynh5z5DcLrlKyLnDc5bi4bfhM79Fx27VLdJkoDlGZwR9kNSg/EJ59bXGGvQ8kcyqN6LT/M6mgHvx8H2NGVNkMdw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=OD+/HTU7; arc=fail smtp.client-ip=52.101.53.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TwOgwFJTvp9AN0EoIe+z9T0jgQkJ5ddxwsfdtzoXsnu5E3XiN77rw9Zh7/G8KWWb6avYxUupg+x1gNvQFvMxSdniBj40vBsC4O/adpln7kag1AbBL/vnQwnTFCdCiW0A8laATd0Z/JuMGVB8Ji6jae6dxJ0JSsG94n9Vw0qoP8zAFSgGQxFDHQGwY+kJ08qYZ7xBWfUjErpoquB/woMyZCklCW5g3lwjqp/ojtGAdwF8Fr635NLzXFLz+ajh05J0X2ahhlGDEa+qxTlFdDtdV3xTo93nbGeaPUM6+i+vM+HXyfA7t7KVIVqtactccdpwnCHHS9TEB544wSSDf0VGKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zhDAPAarV4BqHWz6XodGChgyROaXQmHOecFaugGNopA=;
 b=a5SkCisiqpn9dO4YdD/LsRMb/OuszewvzITB5Thwm6YZ6CNQDpLg0wvUMc2oyhIO63bpLUeuffon03zqFsRhheiiINhi6aHNew0IhKYKS3qRi1s66BxvEbQSbUpXXQrVQOuRzl9okJzP55mQwL0Dj/MN//CzULpJ0B1EflfwCZWRjBe8z3i32k+X8SlYrIx3yueZOXd1O29dytqrcieuavMwVCzg0yI4OX+V2/Tvx3lZqxZFlCZp8yZl52fT9KVheDdI7VZabxlpuv/ZOijWl/5ctAOrMM5PfBbGG26m9iRoqMBgsBO2vlAB4CKWTpHiZ6/2HBU3tC0k2fVseokueQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zhDAPAarV4BqHWz6XodGChgyROaXQmHOecFaugGNopA=;
 b=OD+/HTU7W2XZTpen27hnmQaRWQ9h38Qzebi7mndZ9ymjPnjRWM+4s5/UjYcVfPfsUCv5aBpuNTYGiP0LwrlUMRxPVy2ziRs7EPIztOXpHEYlC5rpl7j75+aqtOJrzyz2tf4XXJWioQyYrIyolRybkGxWcaq8/JsMtHWABDLBhdM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from DM8PR13MB5239.namprd13.prod.outlook.com (2603:10b6:5:314::5) by
 SA5PR13MB7586.namprd13.prod.outlook.com (2603:10b6:806:476::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 17:06:08 +0000
Received: from DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3]) by DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3%4]) with mapi id 15.20.9520.011; Wed, 21 Jan 2026
 17:06:08 +0000
From: Benjamin Coddington <bcodding@hammerspace.com>
To: NeilBrown <neil@brown.name>
Cc: Steve Dickson <steved@redhat.com>, linux-nfs@vger.kernel.org,
 Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH v1 1/2] nfsdctl/rpc.nfsd: Add support for passing
 encrypted filehandle key
Date: Wed, 21 Jan 2026 12:06:06 -0500
X-Mailer: MailMate (2.0r6272)
Message-ID: <3EB8A763-21AF-44E3-8D22-030C6DC62A8B@hammerspace.com>
In-Reply-To: <176877755694.16766.8795981876133751749@noble.neil.brown.name>
References: <cover.1768586942.git.bcodding@hammerspace.com>
 <90fad47b2b34117ae30373569a5e5a87ef63cec7.1768586942.git.bcodding@hammerspace.com>
 <176868679725.16766.14739276568986177664@noble.neil.brown.name>
 <8328B53F-21DE-4237-AF79-5DE88D53D8B9@hammerspace.com>
 <176877755694.16766.8795981876133751749@noble.neil.brown.name>
Content-Type: text/plain
X-ClientProxiedBy: MN0PR04CA0001.namprd04.prod.outlook.com
 (2603:10b6:208:52d::35) To DM8PR13MB5239.namprd13.prod.outlook.com
 (2603:10b6:5:314::5)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR13MB5239:EE_|SA5PR13MB7586:EE_
X-MS-Office365-Filtering-Correlation-Id: 76cbe9fc-ebba-492c-7264-08de590f5e95
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7142099003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+rA6vaXBCEpwGDjhEzFO0xBHwqw5rb+bgsVX0EuzKG1P+RnHvg5DmMH5ZjQs?=
 =?us-ascii?Q?CtGmTWU7EYvA4Kgr45rJWK9TwmOPbmRwlMmsmo+Oq27dUseF+0eAjVnfZNwa?=
 =?us-ascii?Q?RGS4p0uIZFSoZeHA33eBssgqGzj3NFORMBFJNkXi5YptYh2sWz229t37mDaL?=
 =?us-ascii?Q?VUVk0S14FjItXs0HxhEKM5sx0R68Q2aL4MtF4p1Vjn66q10G/7ihH54Oj8b7?=
 =?us-ascii?Q?dWuO2i7uwMklLPClJHbcUancfadToWy6kpawNhSJD5sbsmzcezYEjjajLxUu?=
 =?us-ascii?Q?7/cbLOoJAprUzL73Lx2MhROsCDrLKFc2O7jd0KYPGmprBPhbGW/ZxjmO26TX?=
 =?us-ascii?Q?wGJNTTU88uHqSVCGdknHP3DbDEwm5O6gUkFjDfAoHbxko1ozo5/zrD/b2Ptl?=
 =?us-ascii?Q?hqK4Ti0HMd+m+4IKb1x0gt+QkohZjUBRd/PjPcSec6xiGbjKlUAG/XSYnYX5?=
 =?us-ascii?Q?l7P+xQrLziqymXZEGPWYgG2cRiDNrMAxyTYu+913C6E7pY/M/ImJs4dKSjzB?=
 =?us-ascii?Q?mJE33lA/NJy57Y06mqt0VJT5QFHZ/xFyQORK//Zu4xV9eiQR/TjWkh/nm1bO?=
 =?us-ascii?Q?XDm/l0gb9xx2IpUG62umIPQlNJqjAdX//nzt2pzvdIrSwxr7MZNzwDNlJPIy?=
 =?us-ascii?Q?I33Jx1WpbmTrj/WKcUmxluirnTTuaqYS3HR38p9bOMR4sAbQwsh1oO5jrpic?=
 =?us-ascii?Q?yv1kxzUVeke09yXL8iQpsnPKXFVXnac2lX2uJLbvBWrS5sXfEly8j+Z+zQjc?=
 =?us-ascii?Q?cKPudUAICnpVJOTnvwtvl6VI7JY7MeXicJCKY7ZVTy2wjVZacqYeSec/zc5H?=
 =?us-ascii?Q?8/zB4TI/xqxmdshUbq7BLvl1jH9e9WPTR4rEH7E81Oyv/ZZgkuzXQE8MF7dL?=
 =?us-ascii?Q?QVmS9yl4p/LtMyjWqvsJJYC0HcYJF3hEmZWX05FQi8VfOiC6ORU6m/Hs7yDr?=
 =?us-ascii?Q?lvFby8XZxOsYTGEd+58Ri4EQQhXmDAuSxUje0t/gujwgFwUwEOYGfiJgPsiv?=
 =?us-ascii?Q?UT+c7LNm7nazgKl68PyHASI3d8jSBDvPj1VmBAe0L6qR8YLEO7nP5YwUEGUM?=
 =?us-ascii?Q?ltLmEfQVqlb+/Of5w5nXuqnLQbs9GX9R1lNRJL79ol3OMLQNRVxWxpit2EdH?=
 =?us-ascii?Q?TzAfYqPmV4gEkFbvLLF65J1aJBng7R+NsB6+CZGuqXKdtVZmBTO0+nGOjpS/?=
 =?us-ascii?Q?sqVK/X0VvBAJPNagXXB05OV0xyrg70idRGZIl/2EYJrmdPuiWBNqOiAf8ROT?=
 =?us-ascii?Q?ppyMPK9zHTCOvi+asrOhFOM5aET1AWSEzwB+0HqgqXyh3Upae+rVZQqeuhlK?=
 =?us-ascii?Q?ea5/xG7B3Tr7yd4QYHkCmh0wP3Tjkq5Dy8wAy8J8TWhYuN0ukWXre2o+BdZZ?=
 =?us-ascii?Q?kEfG+E35WvT0pT0Rriy7Eufz10defSau2/JQwbda+tzsN7wGbV97yaSDLlyf?=
 =?us-ascii?Q?jy8PhG+mHzGEkQRgSrM4LX7UYwR+d+rhfuTxx7E/TxkDz2q9LoOyUymHSUMf?=
 =?us-ascii?Q?xFEHazdslTacqyUeVgJepRVEG6dABd8cAuXKdCYXpwV6yT3Z7PWMmISBqCzv?=
 =?us-ascii?Q?oCcPKAMMfyGOuVlFRY0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5239.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7142099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RBniLQfT0toV77c2eXcLRtg5Bs3TkbhuA6p1doon+mL1mMcOk6z8MLfP4nLn?=
 =?us-ascii?Q?GMBHOyx27BahZD08qZks+MZ9MwFF8pL/dZZydFP1EIydjxl4jVJLdnW72obo?=
 =?us-ascii?Q?iIObb5UrYvmTgWrWn5YLQ0K2+bgS1uTYy9umSnR+cjqNlxNa6QR1R8oeGJAM?=
 =?us-ascii?Q?r1QmKJJRH4AijDJ4QLAmzWxJ0pCworC9/CqjKuxqdDAmq3Vx19dn1BqUrGAI?=
 =?us-ascii?Q?uJltSbQeaQ9rOk3DpElbJ8kVKIiow+/4dDDzhsP0Ofir4QpFipJGiX4HYHco?=
 =?us-ascii?Q?5f2uJb4KzdNobwHA65H9PmxZ2AN/QFK2v8v2f1hwp3fnaEfUqMNR2ej2qo7c?=
 =?us-ascii?Q?RPOra1hvE/ejQKEEd5hDFXikexi/SvkpiYpgaELDY2rSoxY6xAtZzIhrDT0a?=
 =?us-ascii?Q?14T+y5P+I8EywoDyu1Gc8Z49cDJhIv8wo1hvDv3roAUJBJmGgpeJOCvDJxQi?=
 =?us-ascii?Q?2De87t0my777tYGZUtvS3ALYXoPaaR//gdLr6cYLY5YKGcZSRV/a3yR64jo7?=
 =?us-ascii?Q?FUroLRcbOJKwSC8wDQ9uX3++3qJqtKMAwvLhOscRJKvqErrbCWVCppWehrgU?=
 =?us-ascii?Q?C4Njh4B5aBW7Hh0Y6/gRtNF6rqYkT0Mztu+Li+F9FK9TmJtmFWEgWqdy6qoG?=
 =?us-ascii?Q?VYkqZSYHLoU5wW5t2fFiryufe0hw8w7PvjFo01ODorvcqCVqTfdtroKd+wvl?=
 =?us-ascii?Q?jyWvLLetNSd+m66yDLCi0hewdA9307fgk5drwd5Fj9baDo1PvlMldd99HSI2?=
 =?us-ascii?Q?aX2iE7Tb4DwgefOpMsNEZj9JuKE0qb16BURyg/I/TNrC1Is3yknqPrtqPeXl?=
 =?us-ascii?Q?L1WSObX7QOPb1yzf0EjVDgbMAnA0GsEIa95H2SXJn9GNKTDfD4NLGsYmBpmb?=
 =?us-ascii?Q?nkop/9cxjWVxjf6xl2f4J0FezvYepACpdXW4TO3//7pJVp+k/t2Qe1Xu+Ado?=
 =?us-ascii?Q?WVEqyUXI/PCxa1Pxe91DlyQfmnH6IxkfeYcZimwXTutaX/u0QZp+pfhABZxe?=
 =?us-ascii?Q?ZD0Shm/5NRw/B89wWevHb7K8J7YNNuSjP6OzBP+bhjkMEilI4hUrdWb6YMcC?=
 =?us-ascii?Q?GcbOHUax47BW5zN9gfKF02W1ozUU2ZN37ULLBfGxxKwvCaNTfa6mI7o+9ixh?=
 =?us-ascii?Q?7+VUVbuu/yOEJ9zDxuoX9pdklU9IosYbOIBjLlpy4cfkIweZTPAAzsvLMwqY?=
 =?us-ascii?Q?aMExV7Ij+l99o2rIpfY/HS8rRoiTeiALEW38LBEWBxWr/cWGdV7SP8tbOnqf?=
 =?us-ascii?Q?qorrzfGUjMbofn7xnipjowuM3po2an9p4dFR3HEyANLQh+b6b700v4v/fVQh?=
 =?us-ascii?Q?okexXiT/S9rVZJpBNQ+exg7HnyZ53/EbkD9WLQ2Xy7Hh4QcvLEpg4PVlR+eg?=
 =?us-ascii?Q?2kCU/g3n1WQDDupTTSzDXADutCy5MhYxYCy4by40oiSJq4O3DPxdP7X0WxLN?=
 =?us-ascii?Q?UR1v2sG581nUA2wCO+nUua8w6rzeR5/GcZlNj2eM5tfHRCSBwm8w7j09V7v+?=
 =?us-ascii?Q?MufJEy5a85TKFHgNODy4MrQw7j4lAhpNMMXDolbpW4w8cWFjZvZzVkuvXBE+?=
 =?us-ascii?Q?3SWEa5AiZ/E+bNsWH0h2QG0I32pkX6UWQXhAnWaXAPrT4vpcnAsF6XEOwUwP?=
 =?us-ascii?Q?1JGwHjhXL7HW/7liI7Ch+aFXNxtYjy0E8r7bx/29df3k68pxodIjKCuN93fn?=
 =?us-ascii?Q?aIC6SyGGeiD8z96m8tayUELR6cAZXAwHuMwlvez2ytEgsSvtGoTAe0UMY+yI?=
 =?us-ascii?Q?S76nb6MIyKLxsOH9drbGVSNiEtZtx6M=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76cbe9fc-ebba-492c-7264-08de590f5e95
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5239.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 17:06:08.1267
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H9B/ze/y1pfoyDPzJcEixVMZVd615kAuo+ZXN62ETP3xzRyNB4bFG/paxHEV7Ys2Ew91MfHJjJIE2Xe6xZAvFC8XTTxHRo5XMHQLVBQM7TQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PR13MB7586
X-Spamd-Result: default: False [0.54 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[hammerspace.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18260-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[hammerspace.com,none];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bcodding@hammerspace.com,linux-nfs@vger.kernel.org];
	RCVD_COUNT_FIVE(0.00)[5];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	DKIM_TRACE(0.00)[hammerspace.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,hammerspace.com:email,hammerspace.com:dkim,hammerspace.com:mid]
X-Rspamd-Queue-Id: DAF295CC73
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 18 Jan 2026, at 18:05, NeilBrown wrote:

> On Mon, 19 Jan 2026, Benjamin Coddington wrote:
>> On 17 Jan 2026, at 16:53, NeilBrown wrote:
>>
>>> On Sat, 17 Jan 2026, Benjamin Coddington wrote:
>>>> If fh-key-file=<path> is set in nfs.conf, the "nfsdctl autostart" command
>>>
>>> ... is set in THE NFSD SECTION OF nfs.conf
>>>
>>>
>>>> will hash the contents of the file with libuuid's uuid_generate_sha1 and
>>>> send the first 16 bytes into the kernel via NFSD_CMD_FH_KEY_SET.
>>>
>>> This patch adds no code that uses uuid_generate_sha1(), and doesn't
>>> provide any code for hash_fh_key_file()...
>>
>> I forgot to add the hash function after moving it into libnfs to make it
>> available to both rpc.nfsd and nfsdctl -- here it is, will fix on v2:
>>
>> diff --git a/support/nfs/fh_key_file.c b/support/nfs/fh_key_file.c
>> new file mode 100644
>> index 000000000000..350d36bf8649
>> --- /dev/null
>> +++ b/support/nfs/fh_key_file.c
>> @@ -0,0 +1,83 @@
>> +/*
>> + * Copyright (c) 2025 Benjamin Coddington <bcodding@hammerspace.com>
>> + * All rights reserved.
>> + *
>> + * Redistribution and use in source and binary forms, with or without
>> + * modification, are permitted provided that the following conditions
>> + * are met:
>> + * 1. Redistributions of source code must retain the above copyright
>> + *    notice, this list of conditions and the following disclaimer.
>> + * 2. Redistributions in binary form must reproduce the above copyright
>> + *    notice, this list of conditions and the following disclaimer in the
>> + *    documentation and/or other materials provided with the distribution.
>> + *
>> + * THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR
>> + * IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
>> + * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
>> + * IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
>> + * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
>> + * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
>> + * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
>> + * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
>> + * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
>> + * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
>> + */
>
> I wonder if it is time to stop putting this boilerplate in nfs-utils and
> start using SPDX like the kernel does.
>
>> +
>> +#include <sys/types.h>
>> +#include <unistd.h>
>> +#include <errno.h>
>> +#include <uuid/uuid.h>
>> +
>> +#include "nfslib.h"
>> +
>> +#define HASH_BLOCKSIZE  256
>> +int hash_fh_key_file(const char *fh_key_file, uuid_t uuid)
>> +{
>> +	const char seed_s[] = "8fc57f1b-1a6f-482f-af92-d2e007c1ae58";
>> +	FILE *sfile = NULL;
>> +	char *buf = malloc(HASH_BLOCKSIZE);
>
> Can this be
>    char buf[HASH_BLOCKSIZE];
> ??
>
>> +	size_t pos;
>> +	int ret = 0;
>> +
>> +	if (!buf)
>> +		goto out;
>> +
>> +	sfile = fopen(fh_key_file, "r");
>> +	if (!sfile) {
>> +		ret = errno;
>> +		xlog(L_ERROR, "Unable to read fh-key-file %s: %s", fh_key_file, strerror(errno));
>> +		goto out;
>> +	}
>> +
>> +	uuid_parse(seed_s, uuid);
>> +	while (1) {
>> +		size_t sread;
>> +		pos = 0;
>> +
>> +		while (1) {
>> +			if (feof(sfile))
>> +				goto finish_block;
>> +
>> +			sread = fread(buf + pos, 1, HASH_BLOCKSIZE - pos, sfile);
>> +			pos += sread;
>> +
>> +			if (pos == HASH_BLOCKSIZE)
>> +				break;
>> +
>> +			if (sread == 0) {
>> +				if (ferror(sfile))
>> +					goto out;
>> +				goto finish_block;
>> +			}
>> +		}
>
> I think this inner look is not needed or wanted.
> fread() will loop as needed until EOF or an error, and we don't want to
> continue on an error.

The fh_key_file can be any length - and this function reads it in
HASH_BLOCKSIZE chunks.  Each chuck gets hashed against the previous result.

That said, there is a bug where ferror(sfile) never gets assigned to "ret",
fixing that..

Ben

