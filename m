Return-Path: <linux-nfs+bounces-18278-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QHevEWhacWnLGAAAu9opvQ
	(envelope-from <linux-nfs+bounces-18278-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Jan 2026 23:59:52 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C8B5F303
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Jan 2026 23:59:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9643C72474A
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Jan 2026 22:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EFAF44CF50;
	Wed, 21 Jan 2026 22:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="LuLNLKIn"
X-Original-To: linux-nfs@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11022126.outbound.protection.outlook.com [52.101.53.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63BA3ACEE9
	for <linux-nfs@vger.kernel.org>; Wed, 21 Jan 2026 22:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769036384; cv=fail; b=j5VliyOsROJPIY48ultUNnpVWT4gH3L++WprEb1zMXOuK9zGy54LW+blyohUpKEolVd7FgfW3yNMpEm1HhUfonnThdE2ajIYd0fIP/YqaFx7aAdeLnRDtAgqU8VlUDG2WliQtPN/pXd10n8P9vGC99rx76T4MhAk85oixx2tKSg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769036384; c=relaxed/simple;
	bh=H6zHJXdynuuOSpCbIb2EoCMJ6gBb682ipzbrGIlI5SA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=k8s7bkEDfHgMH45ALDAPVD5JnohTZeS34PLMY8SMPKjRG+J9S31+48kjqTNMvsze9RhlEuRRgx+zilFo7GAoFxRfXT7yEK0KMvg6XdRBqXNiOvHo1ohoZNu8nrUOOaxks0w5uknSa4IT3F7b/apC7YyxIMrLsXMKDR8Jx8PBKVE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=LuLNLKIn; arc=fail smtp.client-ip=52.101.53.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fBScTfJtHJ/psnJ5MUM/eec4erYElPgC1nVRi3eQ/4V7/xMwFwxUQLtYCSBIMlywZMcXDYHOHr6UTLvC5yvAJQkUeQnl2L6O2XsRyR7zIva7GfuydG8a10AU9pPFitYwiTJPBwi3Ow6CDB089G8B+1f260joXaXR19WUDQKH8mMd3Jr5NPqLMlKXAMTPlEwZn2RWffvn6ao3z1lqxg/VAnbSvPETWBw5/gp0a0QEgUM7VR2HYPYrS42qQa07gV1/BDQJ4z76ZyFQDLKWRtFoBeO3Vm+oZHaPwqByaqQzaOsnWA5J1PLNxQ19Zk7cq++bf0N/luAe6QlLqfX+1dwnjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kzypD2pOefb5ITUCG6l0P+WYDy+cnO058bFkkOZYq/w=;
 b=wV8AvKz53wZHO3hyLX0izXmrI2a+mbXVxTYYajhmauQGZsLtGVWvSfqcLwHFvLEnVAGzKZHm28zlNipEXGjkQYkpEWKZS7pyoInjXYOYMdfpxOVODOI574rVxmPFLCM39InNz/EL+ah16ySm5ghPPao9dTSiVqzbONAbzXXXyfBBcDbcUwX00k4uuGRH1x1m+2Mv2Q3WQVWIN9nKx/fyRCYBaB2AGqzt9dQ1HKAsZGRZjnFpGTbOmxvxyuJidZOknOuIBueUOJp91lYgE6ePGZ7Sf3/Bh6gvxBS8vbOKbK8ga3pjr6nQLK5mOEmW7NMhjPnjRWagLciFTGoq3xliYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kzypD2pOefb5ITUCG6l0P+WYDy+cnO058bFkkOZYq/w=;
 b=LuLNLKInZkek28t9O887JITJiuVqNtUpdMdwMXE/IDPS7F9w7xyridfkMpBHLBjIDcec9mdCxOBK8xGCXMPs40HbLvoGCTPuFqte26ObyNaZh2kziKiKRTL6F1v/hLmBIL8hczyktVqUioT2ZbP61WZbJ58giO3MpPQCp2azb2k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from DM8PR13MB5239.namprd13.prod.outlook.com (2603:10b6:5:314::5) by
 SA1PR13MB7702.namprd13.prod.outlook.com (2603:10b6:806:4c3::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.9; Wed, 21 Jan 2026 22:59:24 +0000
Received: from DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3]) by DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3%4]) with mapi id 15.20.9520.011; Wed, 21 Jan 2026
 22:59:24 +0000
From: Benjamin Coddington <bcodding@hammerspace.com>
To: NeilBrown <neil@brown.name>
Cc: Steve Dickson <steved@redhat.com>, linux-nfs@vger.kernel.org,
 Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH v1 1/2] nfsdctl/rpc.nfsd: Add support for passing
 encrypted filehandle key
Date: Wed, 21 Jan 2026 17:59:20 -0500
X-Mailer: MailMate (2.0r6272)
Message-ID: <EDA07D4D-F2D3-458B-A975-FDC02E8F377B@hammerspace.com>
In-Reply-To: <176903512916.16766.9732522324635199948@noble.neil.brown.name>
References: <cover.1768586942.git.bcodding@hammerspace.com>
 <90fad47b2b34117ae30373569a5e5a87ef63cec7.1768586942.git.bcodding@hammerspace.com>
 <176868679725.16766.14739276568986177664@noble.neil.brown.name>
 <8328B53F-21DE-4237-AF79-5DE88D53D8B9@hammerspace.com>
 <176877755694.16766.8795981876133751749@noble.neil.brown.name>
 <3EB8A763-21AF-44E3-8D22-030C6DC62A8B@hammerspace.com>
 <176903512916.16766.9732522324635199948@noble.neil.brown.name>
Content-Type: text/plain
X-ClientProxiedBy: PH7PR13CA0020.namprd13.prod.outlook.com
 (2603:10b6:510:174::27) To DM8PR13MB5239.namprd13.prod.outlook.com
 (2603:10b6:5:314::5)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR13MB5239:EE_|SA1PR13MB7702:EE_
X-MS-Office365-Filtering-Correlation-Id: b228800d-efe7-46e0-2d3a-08de5940b864
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7142099003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8CNeDgHfeI7Z25VElGJSMfIX/IjK9zv1Tj3ciN/seFxwuO/yLmchn8vbhezF?=
 =?us-ascii?Q?gjBzD0LmR0WNz3dEZOOSIvuSnz/HnwAT+L2zk8PSUVN9QqBqv/oy9BTUW3p4?=
 =?us-ascii?Q?iLTy7IuWr0sCg9TOF0ipmWSU2UME2P3n5F8d0+cxMjrnr3/o9o+W+EDk0mTR?=
 =?us-ascii?Q?4f8EosxBiebEAbLEjCWTiQMfvPs0gBrKBxRqoWsWPIOfxANRFPfubpYPeeMj?=
 =?us-ascii?Q?3Ck10puWHpTxQrWUhJZi/VwIXsrPvGSkv59RDmrUlO/0koxwLIQ2PwG31JFA?=
 =?us-ascii?Q?tMAAmurmp+zFhr4Z8R31mncMbrOD6I32q11cVOCHE27Z5LblcW2Wlw9NZ/wu?=
 =?us-ascii?Q?QoMQ/S21wq7Dd7yrslJx5cnKpfV5FK+50XGUcgtsxONEe9kBbrLDzMEeVbGX?=
 =?us-ascii?Q?IlMfT8M7atO0ZLSxpPlqhg0lTy6o4jYGbAmaal6WMShAeslmxSzJ5zmZxJmO?=
 =?us-ascii?Q?QDoz5IJwNzR36fMLSoOseGzM9LGy07ff1jo53sbdxyRJ+QwfuMfeRWthUqYZ?=
 =?us-ascii?Q?HFtSvO41ss2CYDc6DIWIN5iSr5iFgmTYxd718sUJZKtFoBRbABp5kJBM29ub?=
 =?us-ascii?Q?rzzzWbF+2R+/xHhNK7JcqWlfxJ5WSFeR4uQ/4Nve2mngAYq/QIO2mojxyS5/?=
 =?us-ascii?Q?zeczLl4mvIZwzyNSUWdVEJUI1ydja3+kq6TGpLOLVa2n5LBf+8j2ho/dzK9K?=
 =?us-ascii?Q?plHIXn/0uOPD//PtUBxgi8p6d8hdIU8wRmUzff0kDp8BSkZxPXjNeSCqLVcY?=
 =?us-ascii?Q?AWSd+z9+eZnkRXs50uHzKCQu2BpMZIsRyi7rX/D2tFdhjpgX7ESiH1LIP60p?=
 =?us-ascii?Q?Zhete+QkDqnlX04rr1jUZCsEXBYVeY3JDxQ0lZ6lHK4/uqmoqHemML7eUCZo?=
 =?us-ascii?Q?8YNUQ9ShSnnT4bG8Tya6TuipAYWg6OOUfJl/tVLqJPvIAr5aOnV/nlalKk8H?=
 =?us-ascii?Q?VhhbsLY65KX7cxpRTLOFiEqolgJtvFXA4sda9UNZ2LRkQ/9pgsvCkM8upj3g?=
 =?us-ascii?Q?RGVz0UIjF837HbbNF3M5LhAk1cUs3Z7uDM1fBg2Peexc5PIQ2Fr7hUHx1+5q?=
 =?us-ascii?Q?6f0cvgHvk5yq2KGVh+QiMWVpUeqslFKq7oaw+IeafQG7MGOB80DT/menlm8w?=
 =?us-ascii?Q?E1411l7WK7gErKC31WV9f4wmBbpRBB+JbzGJSLwSgRo7UCA1E8szP2FvOWPp?=
 =?us-ascii?Q?/xVcd2AmAF3Zn4sY2i8V5DYNMk6jkbjFk0pQc7KTJT3nDX7C8EYOHzIzSfbI?=
 =?us-ascii?Q?r4XvhtG7NLtPeiiKgL6/buSWMMr3QGlB82GZPExxMWT9G1R5dX+lMddbbcRZ?=
 =?us-ascii?Q?Sx0kEzL3PstDk44UB6jx+tZQGtRhxtESWsiAH4AaQbqgfwIrYILLdpKgln3N?=
 =?us-ascii?Q?enj1+Fu54gZs2XUZu5faaERqN4NO1gYbw8oq6VjXHBRWv0/I82dosrzx437a?=
 =?us-ascii?Q?lyAkfnHZd2ZI6f9ocq55aY0DSDtCCwFDCxxA+XEJ7aOn7Nuid94E66Phq0WJ?=
 =?us-ascii?Q?+AS2TC8ptfARWlxyCFmyXIr4H9uBd0vVr40h48Ywj+V7aTIUtT+Oxmo2Cm6n?=
 =?us-ascii?Q?AFCIqH25TWT+QLy0oZA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5239.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7142099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+HlzYpIDjzG0xpkgFedztvhfE9UF6eJ1QIo9IQ04W8xeo/qCyt1V0paPINJv?=
 =?us-ascii?Q?8QRhcUrC+E/n/bdX5CV1KLvpw76hrgw/Vcko81VZFImGXMQdHZOEJGTq3Rdp?=
 =?us-ascii?Q?i2Fui09RnfeZwfO8SONe22cTVu8YV2NwrOJad4fLA9HZE6cNKC9BYesDYK3d?=
 =?us-ascii?Q?nNzXolhGwTiyRSw5g8jkg5w+GC795/KiBq7jU33jsU3P+Q2m+KUF09s5AIQ3?=
 =?us-ascii?Q?gGQx6tQ1DOj/jh4iCmye9WI7DoiPcZXPD89JqlKgvDsf+bwAZOOZnRIFf0e2?=
 =?us-ascii?Q?hWYgc+H0YxAFi6pbUMk4p8SvDPBKe42mBkPA7jC5t9AA8XxenNYMj45ORbvz?=
 =?us-ascii?Q?o82dcoARK0PGivwL2kkZc4bP8k6HKbBXC7m5XFGvobcMsNGuWM4SKQz7QtAv?=
 =?us-ascii?Q?x35iXHDoqCTiJZXEK01bOP7dpBuGYfC+WNocRmwj7VmxtvFyfjPoIt6nJmSo?=
 =?us-ascii?Q?DkSddL9VdO9ayT0h2jrN5vKr2ZLn29a0yLeCVshGyIeZI/NAyecG6Ov9Y53n?=
 =?us-ascii?Q?/J3qYaMif6bYqcT+BKtAFfZZ2/RFu+RTc/6UP5TtyTYdG8PdrK16qSC8OITw?=
 =?us-ascii?Q?y2RvvLBb/Oa4mJ6yfpBfM5MIY7KSW7i/iveRab+E9HbRuxXSH+HYldV5B45A?=
 =?us-ascii?Q?fEnYP5USUl2G4elgsvq/xmscmaS2WFo1GGlvSFG1OgGWJWLX6H6OgDm0hVdA?=
 =?us-ascii?Q?w1+Zxj95qjkabM6J9tspYHf/WuNyWAM96fXiOQNYMgbkUChlAf03HT55DuxD?=
 =?us-ascii?Q?R5kO6SkTQciS197BUhajkQqfv9rwO+GbfmJBSMdn3fsG1fqmWyzmU2eGRfmc?=
 =?us-ascii?Q?xJhq24Xsy/gQMAjjQu7tvAK2ks2NU77vTG8hHkIpQ+fbYPMqfIqI9K20NPoZ?=
 =?us-ascii?Q?MA6wcdZfo64kUDFgXly+lsJ5RI5zKaPbwF2DtxNEXO3XmxM2p/I22HNXm/2y?=
 =?us-ascii?Q?szdfxiceh+tyHKX139j0+QpojoEnb/JBqPlrn16jsgIbG9xLL75kAprKjPgM?=
 =?us-ascii?Q?zjYzsyPbvos28/1T4tt6FHQuYP5leO1dwWyFCiTy9yNNMuVgoo7d+v0oB3bE?=
 =?us-ascii?Q?I+0iNByFgKElDfc+NEODzb4x+8V9AJ0tM41duWALNdT/+9mOhwJ0Pu+sj77I?=
 =?us-ascii?Q?u+n82jMKHkQNLzNAWZkXh3Ij+gXt53UyFZdWKtJPhWLH5yNqV7MIZHrSc7uw?=
 =?us-ascii?Q?YmlWHrpQKihvn6x1bkF7RbpbP5oYPKcxUCC4omGP6WveSLb+cpBpMhxXvnTF?=
 =?us-ascii?Q?uUmts8V1p23coEv/UhegmitJoTH8P3duNeqPx2qxnHZQTHnU8YxrW/eVQD+n?=
 =?us-ascii?Q?rJ04kRdnNTSue4EdDEuCMHE8t/yZ4WoNi5/1m9NVQIe3qxJbRMQK/5qjXBjs?=
 =?us-ascii?Q?hjMFrLH7Vdu5XQ8OyVAi04/+1Up+FYhE4vEO8T6FOFgoq6fZt7DI9FNDlnsi?=
 =?us-ascii?Q?5R47KlfzOb9hwaINEvRK6sdPqj0ztjUIqlyxG8JVfqZOJi2pKoaUJKwRaoQP?=
 =?us-ascii?Q?qaFwEqjxpKfvChEdLa5N/6wDWeEPGCXPBBuPgYS0OfonL0b/4SZU3c/gl6Xj?=
 =?us-ascii?Q?2G+vENYEcblrRh+QoJxK0KikGw8USbcWvbat8B/ZQYgc+l4KZPdRF9RjLacs?=
 =?us-ascii?Q?Vozf8EuPt5FypRErhfDzxEMysyK0YBUFeVt0gAsAmkQ4PmupFhrSPRJGkE+Y?=
 =?us-ascii?Q?BsG8ATUnhom1WPJId6iNXHxXA7K2dEu30P3o6169F+DIiRIfFA8UaMsy6EBF?=
 =?us-ascii?Q?HlhBRg5SS0n91C9xh5E6h3SIVrx4Qts=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b228800d-efe7-46e0-2d3a-08de5940b864
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5239.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 22:59:24.0643
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +EOWo1IZrt5AGi29Nv7cHM8mAMzeorKRy7gFIiCbwBsw5GU/0PyglVaHmDQYoDWUjIQm/tNYfKZAQM0DzIvJBRiRrgXFb8UKRQ2KjoUVC80=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR13MB7702
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.54 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[hammerspace.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18278-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns,hammerspace.com:email,hammerspace.com:dkim,hammerspace.com:mid]
X-Rspamd-Queue-Id: C0C8B5F303
X-Rspamd-Action: no action

On 21 Jan 2026, at 17:38, NeilBrown wrote:

> On Thu, 22 Jan 2026, Benjamin Coddington wrote:
>> On 18 Jan 2026, at 18:05, NeilBrown wrote:
>>
>>> On Mon, 19 Jan 2026, Benjamin Coddington wrote:
>>>> On 17 Jan 2026, at 16:53, NeilBrown wrote:
>>>>
>>>>> On Sat, 17 Jan 2026, Benjamin Coddington wrote:
>>>>>> If fh-key-file=<path> is set in nfs.conf, the "nfsdctl autostart" command
>>>>>
>>>>> ... is set in THE NFSD SECTION OF nfs.conf
>>>>>
>>>>>
>>>>>> will hash the contents of the file with libuuid's uuid_generate_sha1 and
>>>>>> send the first 16 bytes into the kernel via NFSD_CMD_FH_KEY_SET.
>>>>>
>>>>> This patch adds no code that uses uuid_generate_sha1(), and doesn't
>>>>> provide any code for hash_fh_key_file()...
>>>>
>>>> I forgot to add the hash function after moving it into libnfs to make it
>>>> available to both rpc.nfsd and nfsdctl -- here it is, will fix on v2:
>>>>
>>>> diff --git a/support/nfs/fh_key_file.c b/support/nfs/fh_key_file.c
>>>> new file mode 100644
>>>> index 000000000000..350d36bf8649
>>>> --- /dev/null
>>>> +++ b/support/nfs/fh_key_file.c
>>>> @@ -0,0 +1,83 @@
>>>> +/*
>>>> + * Copyright (c) 2025 Benjamin Coddington <bcodding@hammerspace.com>
>>>> + * All rights reserved.
>>>> + *
>>>> + * Redistribution and use in source and binary forms, with or without
>>>> + * modification, are permitted provided that the following conditions
>>>> + * are met:
>>>> + * 1. Redistributions of source code must retain the above copyright
>>>> + *    notice, this list of conditions and the following disclaimer.
>>>> + * 2. Redistributions in binary form must reproduce the above copyright
>>>> + *    notice, this list of conditions and the following disclaimer in the
>>>> + *    documentation and/or other materials provided with the distribution.
>>>> + *
>>>> + * THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR
>>>> + * IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
>>>> + * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
>>>> + * IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
>>>> + * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
>>>> + * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
>>>> + * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
>>>> + * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
>>>> + * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
>>>> + * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
>>>> + */
>>>
>>> I wonder if it is time to stop putting this boilerplate in nfs-utils and
>>> start using SPDX like the kernel does.
>>>
>>>> +
>>>> +#include <sys/types.h>
>>>> +#include <unistd.h>
>>>> +#include <errno.h>
>>>> +#include <uuid/uuid.h>
>>>> +
>>>> +#include "nfslib.h"
>>>> +
>>>> +#define HASH_BLOCKSIZE  256
>>>> +int hash_fh_key_file(const char *fh_key_file, uuid_t uuid)
>>>> +{
>>>> +	const char seed_s[] = "8fc57f1b-1a6f-482f-af92-d2e007c1ae58";
>>>> +	FILE *sfile = NULL;
>>>> +	char *buf = malloc(HASH_BLOCKSIZE);
>>>
>>> Can this be
>>>    char buf[HASH_BLOCKSIZE];
>>> ??
>>>
>>>> +	size_t pos;
>>>> +	int ret = 0;
>>>> +
>>>> +	if (!buf)
>>>> +		goto out;
>>>> +
>>>> +	sfile = fopen(fh_key_file, "r");
>>>> +	if (!sfile) {
>>>> +		ret = errno;
>>>> +		xlog(L_ERROR, "Unable to read fh-key-file %s: %s", fh_key_file, strerror(errno));
>>>> +		goto out;
>>>> +	}
>>>> +
>>>> +	uuid_parse(seed_s, uuid);
>>>> +	while (1) {
>>>> +		size_t sread;
>>>> +		pos = 0;
>>>> +
>>>> +		while (1) {
>>>> +			if (feof(sfile))
>>>> +				goto finish_block;
>>>> +
>>>> +			sread = fread(buf + pos, 1, HASH_BLOCKSIZE - pos, sfile);
>>>> +			pos += sread;
>>>> +
>>>> +			if (pos == HASH_BLOCKSIZE)
>>>> +				break;
>>>> +
>>>> +			if (sread == 0) {
>>>> +				if (ferror(sfile))
>>>> +					goto out;
>>>> +				goto finish_block;
>>>> +			}
>>>> +		}
>>>
>>> I think this inner look is not needed or wanted.
>>> fread() will loop as needed until EOF or an error, and we don't want to
>>> continue on an error.
>>
>> The fh_key_file can be any length - and this function reads it in
>> HASH_BLOCKSIZE chunks.  Each chuck gets hashed against the previous result.
>
> Yes, so the outer loop is clearly needed.
> The inner loop will never execute more than once as fread() only returns
> short reads on EOF or error.

Oh yeah - you're quite right.  Crazy how a blind spot can stick like that.
Thanks!

Ben

