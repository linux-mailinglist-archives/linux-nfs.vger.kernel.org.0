Return-Path: <linux-nfs+bounces-18658-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oPGWO4cagmmZPAMAu9opvQ
	(envelope-from <linux-nfs+bounces-18658-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 03 Feb 2026 16:55:52 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D56EDB922
	for <lists+linux-nfs@lfdr.de>; Tue, 03 Feb 2026 16:55:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EA1E3305245C
	for <lists+linux-nfs@lfdr.de>; Tue,  3 Feb 2026 15:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D2593B8BCE;
	Tue,  3 Feb 2026 15:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="cDBsRjzF"
X-Original-To: linux-nfs@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11023081.outbound.protection.outlook.com [40.107.201.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E65E3B95FC
	for <linux-nfs@vger.kernel.org>; Tue,  3 Feb 2026 15:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770134135; cv=fail; b=IjpN0LEDPtgFhv5R5jpb8FKkmjqBh+QIFTyhta0TphgGV/UmEF9lxLHE4iejpNDK5fFCYYwkfbjKcgPamFsPHlvahRkPdFsGI3nvbRziXi8ZzulwwnLLwyQ5Qrc2ohrN/26YWS0Z+5Ui9wdRAJaUMBuOVp15hbrcjpMO3YNrOOM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770134135; c=relaxed/simple;
	bh=lWyrPg037rbEmmyBvh5/8hBbGukiNLsV1gzq2lzdjo8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UBRIyconQsRxI299aGV228AK+qV7p0icCQvahLYcQH9LSP+LMaztzkVxu0zxyMNmZPEhY1XFn5faBRb8KgqN9yTkNjzbCukMksib0UUlK1W3TziwbrFbZnM8WMDt8pkeQhOIKMLhqj0qc2k76IelKix3dN+O70c+l0ujTniGnHg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=cDBsRjzF; arc=fail smtp.client-ip=40.107.201.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fb6UYtu9A5om6snopibAK2LgrfVrbK05gR9Dbq9nsG3Njgerr0cDlN8Iz4JlaPSeZ+wXIRW1tos3ee8c9S7gsSePG1FDPrkDLznsZfptQXp7ekRTZLxxsxY2esfgfkZjyng59z8Cw6/YI/C9FvffsQBEb+6koEOL3KenxINZKPSzFaF2WihTgQQNPK0AY0MxYPATxGChNIspAd3LTVoUEicbbMz1D4+JFnTL4VzoqHztj1hfxeGcmY7jhHp9VorGYs83l5Yo7p7CAsqfiA3nevDN9ghGHN+10YkiIjA5S57j7+b/EQudpcHWqKKgh2ljj2EtWhJ8RevQLtXp2K6e/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VqT+giTHNC3H4ez7/AhTvULPzf+DUrZJ094NiXIHBm8=;
 b=f2CXJlDV27MYm8ytW9jjm8dU25lJscGmH/wvbDmBY1hsS7uGK1knDj941yVEjLovrbckQ3VmZ/YJJMbCpby6EDekuzr1GyP7p2ea704SYrv9yENDA5QxOLWArzvMB8I4wUoPRjd3oh4cJC5QNFHEeiXBD/nxasNDGoXpMRM/iyoLnrc6KwZf6VxKdQmxBl9kCuZwQunP047P9YWb4xTqnufgKU9iQ70hL3UzsPo++wVon8JWDwutV4MciD2hMCheEHRyxmAYMIx6pKeIpT/ooz9sdg5Pv96npCDpBKGyyyouNXOHjWYe//ihQajvUVnINFdRWuQryuhhGWGs110q1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VqT+giTHNC3H4ez7/AhTvULPzf+DUrZJ094NiXIHBm8=;
 b=cDBsRjzF1c1V5ywIWrGPx185sM+vcDeZ/c21bt8E2x5IBd1u9CIfDV7twUZYrBPdl38FX6c0yKwDxBudSzFb7l1BNigU+l3e/Gv4jWHN0k7ZIX/s6pEdE2kWvJMrJ6C04mfTKJys2jYIvmc62qcqMJ8EXjKy2iJRrsrLZzkgIjw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from DM8PR13MB5239.namprd13.prod.outlook.com (2603:10b6:5:314::5) by
 BY3PR13MB5041.namprd13.prod.outlook.com (2603:10b6:a03:36b::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.16; Tue, 3 Feb 2026 15:55:26 +0000
Received: from DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3]) by DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3%4]) with mapi id 15.20.9564.016; Tue, 3 Feb 2026
 15:55:26 +0000
From: Benjamin Coddington <bcodding@hammerspace.com>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Steve Dickson <steved@redhat.com>, linux-nfs@vger.kernel.org,
 NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH v3 1/2] exportfs: Add support for export option sign_fh
Date: Tue, 03 Feb 2026 10:55:22 -0500
X-Mailer: MailMate (2.0r6272)
Message-ID: <2FB11C41-9BE0-47AC-AB38-B274C8B203F7@hammerspace.com>
In-Reply-To: <b303b933-530d-44b1-a614-c8bb91ce9f34@oracle.com>
References: <cover.1770051230.git.bcodding@hammerspace.com>
 <60b48050a0998ca214526bbfec406ed084305617.1770051230.git.bcodding@hammerspace.com>
 <b303b933-530d-44b1-a614-c8bb91ce9f34@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: BY5PR16CA0023.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::36) To DM8PR13MB5239.namprd13.prod.outlook.com
 (2603:10b6:5:314::5)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR13MB5239:EE_|BY3PR13MB5041:EE_
X-MS-Office365-Filtering-Correlation-Id: 41678563-fc30-4106-f4de-08de633ca567
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7142099003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vUwctY3Tyiu64wgpsCXBb+jz9k0m+OMozySovccrKI4IdKC2MNHgqktBVTJw?=
 =?us-ascii?Q?NtV+MdQLmPXW+cXiEyHQeo1+JG3IhTd674jW3+16VKTB7V6qPs+boYWCdvYy?=
 =?us-ascii?Q?l9D2LUEJpiN/kzhCuu4tHQtJTtpoUW1u54OV7i6L3ycT5yMpXl7tvA19wzka?=
 =?us-ascii?Q?ZA+vbwIy1dEbfpGRwr2sjJcyvVy+BmpOAcQ1pu9ono/HXmYBnaOUDSZfFFZB?=
 =?us-ascii?Q?47Lx/exSjqBUZKr9bru3v44zyxuuV+3FDvwGKzBjk9K3iuBCpM+RVOXnNV65?=
 =?us-ascii?Q?SSKqDy7GPp+O/Wk5hM/XApI1bkw8BbRHIsdcy+yMkvSg10Gzyvz44rONKteG?=
 =?us-ascii?Q?+mwKt4poQ5BcdhVlsa0MQIr23D+/wYOv3NDOuOpC4G919Q+YDe4R4BXPU7uS?=
 =?us-ascii?Q?iacqLXpFSMPkY0D4y0dVRTg3jzeGXnMK1XvErie41dlX3MGu151387z3kHbS?=
 =?us-ascii?Q?gjBjX/ewdLxm/YRtbgAis5K3abdJyadGijbwuPaMqet2CVYG9HPTmafI1bgj?=
 =?us-ascii?Q?60FvtAk6JKpWGony9b9+h5bBBq5XeR8u3CO8hs2AWd233DhqemXis44++Q1F?=
 =?us-ascii?Q?IPVEZvKaZ6eq2gEZ1GKGcy2zzjj440aNXK/g8eMiZQilON4azIhnWpNPK/3t?=
 =?us-ascii?Q?dDWVEx1CXe8Dlz5ekef0OVfkQku/f4UvU7luPuOI8a/9/SCCbM6cnWgRqDEj?=
 =?us-ascii?Q?wH9Nycx6DcbbdeEYiOY36FWtk4qTrsxZ+HifS+znl3wtKdyxUwFG0PDsUr76?=
 =?us-ascii?Q?pQWf8AMxhk6f87oAt2IR4zX/La43gINuv6d0heoc5UJ+513UGqVdOEPTP1Yx?=
 =?us-ascii?Q?Z8EjycnXUBA0VTzvMx48PEndPTRUv0ebiHKZM5BtBPpdZmOwF9WcnaNtTDnF?=
 =?us-ascii?Q?exjktozldKYFF/AAfKruiIPs0OO4vYXbTr+ylg+NjvicoGxFM4Z+Z3K9VmVE?=
 =?us-ascii?Q?/tWHUOS7Efg3vNPN6ZbwqzUROUoGJP6ffHG2kx3P3qF2pFxbT+asZGmRoeFU?=
 =?us-ascii?Q?dij0lMSM8r7TSK1+Kc2gWmODY6A56hnYm4CGOp0JSvRW7k+sD8UqXm2Hwfh2?=
 =?us-ascii?Q?npW9NZqlMb9Cu9Arj9eCrqjlq+bjK/uuAPn5fZhbw28v5HAPzJM62CWSdEV4?=
 =?us-ascii?Q?mQqbLvcnGGO0tkbz+rX3tTd7U72K58Vt+pZCJOYy4LQhpxX/Z5RrwZ0Z9kap?=
 =?us-ascii?Q?TJLoLG0OrtAAdgXEmcB30N7ou+bTFoVC7cTJPqQ8FkYiYiKZE/mp+qHATkRR?=
 =?us-ascii?Q?1HxvetcM7LJhjXAwk8RvmpYDNRw2yLH7iNOju01f6qVfYOr0c+mWkCWs0Q+0?=
 =?us-ascii?Q?ESEyuDXTvoMiTbU/zsLtE7LQO4y6Bd3y9P80hHpKchWlgNEr0E2L3SmmFUCA?=
 =?us-ascii?Q?j/rsrWkBY+OqxEbJ6RtK1x/eFIAXC3sL9W93ZcSJRXb5b89cx3uiG4mIojfz?=
 =?us-ascii?Q?q3CMFxHBT5E4nTf7Cr4E2uclE3FooSZD8YredHaZVtrQayQO2smHGrvIv9NP?=
 =?us-ascii?Q?PZi04dtUwX4duvcQjycTr7x/XcwxQbzSytJ9rG2kmWHTP3FU7C87yyxoP8/x?=
 =?us-ascii?Q?ujXQj5ze8K4HVxpKAMs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5239.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7142099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZtTheLWM3dv2yMViYbOdnA+cZ0iCWhQVqUYy56gWgB77MdKZR8B+Lh2thRmf?=
 =?us-ascii?Q?8zWO2z3VF58O94iK/iseRXFIyNsBtd/4wlHZ2TKWt024/gzbpoyFnb8t9jWc?=
 =?us-ascii?Q?ONBudspwz+YZf9sT+8cQhYBGij3RcNeB42BzT3j4ew8Vr5CW7vfiCcHonSqX?=
 =?us-ascii?Q?NUkdvxL7XVPnyuDLnH4DgbikpP/+Cv6A4wiRCF2RF21S2eDIim1Od9GLxn48?=
 =?us-ascii?Q?vPZKm8KkHLPL3v93V551r3u1ZI6ylUtg3SWrmICI66F/nO+KAzIpVPV5WRQB?=
 =?us-ascii?Q?qm399f0ymoYADEf92AvZoDdRi1xiEggA0q9n9OTcVJFkWdisfwcOYEg78dO2?=
 =?us-ascii?Q?YKU1Egusb5thOBF1bHZ3Eiw+ZAqGZAxF4fn+obzSyPXOchPu56tE+9RzPUHp?=
 =?us-ascii?Q?u5VvvCuQO++yP8vQinhc+y+H9IEH3yzTRZX07BFPsAEbOiC9BIBciGRQAgZy?=
 =?us-ascii?Q?5SAzbG4PPW6Xj/eWn7BWa8Fp9Q+/aD201R14t5ev4owCsS3ZCP+n4NuZwV/m?=
 =?us-ascii?Q?6Tv5IosMdZ17wgYzASmv4uTHwif7/R5kJqz3nXSaXAB1GjX4dxqgQKkoENlm?=
 =?us-ascii?Q?cm9F1YtqjeVvit4QLvTjkZG90W7OhIp0MwgguvQ+3OhqPZkLI7Djhbipb1rG?=
 =?us-ascii?Q?rxzmglBLokohq0cwl/YpEWlrhkx9anKJbmB6ARDD06TZWM75+RmVWO8y2TpY?=
 =?us-ascii?Q?7AG3mzufOfRQSlKmTkFM10RimmfMWsYupZEmIBV4z82TwBA9o2rOD/dgzw+1?=
 =?us-ascii?Q?inEYqe/rCTmIs7us7g7Ghh+8cnvz+WTqSUoq6ejKNu4BQzyaobKG0czRKAoB?=
 =?us-ascii?Q?g4PGPiZWwL7vvU8molXyQiq289u3oqRfIlBifs6MURjsuR8VP9EI3+Qp9xFM?=
 =?us-ascii?Q?QG+e7dOjryLfo9fnRMaPOFJR0lkIYZ3Vp6qwlrlstk8FNMDcOaCB/NljaAt/?=
 =?us-ascii?Q?pHm4dNrZHWAbJQDr9Lhw/WwbJGGXiN2T72V08t1faINJ2s7qbHPcfIdw5um2?=
 =?us-ascii?Q?mb6N2+wc7ME2QHqbwYLQ5F7OKu/R7iMzHKz4vHmw4zxkeO0vlfwKNTfLBlB1?=
 =?us-ascii?Q?YS8Wv/tapoTZKarzIqXAZtBwh4/uwdKWad1AUglLxKdAKxRZwCczmUt9oSos?=
 =?us-ascii?Q?tBalZcrv6MOG5zri41pEH+6iFdFc3tqTs9VfaLrdtC38Q+WsVy8UFw1YOFDg?=
 =?us-ascii?Q?sQPllwLNLVHvQomPg3kp2Zu4o3qllfhv8/38XaHb9OTHvvrdDEIxPYvNyeX5?=
 =?us-ascii?Q?TKXWXIcxMpOeynr/Zy+5Pi7YJvHXtUOnJdWcY2B751xGLdBhPW1yEq6I1Yjb?=
 =?us-ascii?Q?J/jH1o6jmL8ciV3k8ueq3oOuJjBOOfP2XQyR3PTi+AEuURoWlmYh0ytDTIq5?=
 =?us-ascii?Q?9MjgNrDaXmR7gIPLtr2hEXN5ypr3vklrSmUoO88w06YKDbZX4wbVypY9BtRD?=
 =?us-ascii?Q?rcY+TvSALrNNTTh5fQbpHGNGL+3yfQ8SGNMorIyPfQYpOdjlrdt46BQNxmYN?=
 =?us-ascii?Q?x1t+/n7xU6fv7+ewdGisqmiaeGY1TGrLGUPunaqAr6ordKRAsgoREK19ejKG?=
 =?us-ascii?Q?+8Bq8GEaqR1W86H2uL14S9GHd+VT9HhsoT99seTZpz5dlzHlqMdtgWvll/uy?=
 =?us-ascii?Q?uvaY6qDxgU4icOmY3VFnxsjF63rxsoLtEIKWxYLs8wiBy1EWTGQpBYwpJToJ?=
 =?us-ascii?Q?jWVFakoBBpCnqjxB7RymlYNejWuI+yaGW2CbRjsFfa2ziy4O0xilGll4lJv2?=
 =?us-ascii?Q?ufwOM/ZmYnEK3S2btC7e4QR0yYfWUGI=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41678563-fc30-4106-f4de-08de633ca567
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5239.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 15:55:26.0460
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QYBEWvtc+iKWaDLyrg7ss8Md0Ct6Tvrd62pcXMMEWNyRfs3+MOqybuaBlgV6IPw7wEuLsJnVO42vnNmFGA8E5OTs1AyGIA6CtBHa2jFQevw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR13MB5041
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[hammerspace.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[hammerspace.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18658-lists,linux-nfs=lfdr.de];
	DKIM_TRACE(0.00)[hammerspace.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bcodding@hammerspace.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6D56EDB922
X-Rspamd-Action: no action

On 3 Feb 2026, at 9:17, Chuck Lever wrote:

> On 2/2/26 11:59 AM, Benjamin Coddington wrote:
>> If configured with "sign_fh", exports will be flagged to signal that
>> filehandles should be signed with a Message Authentication Code (MAC).
>>
>> Signed-off-by: Benjamin Coddington <bcodding@hammerspace.com>
>> ---
>>  support/include/nfs/export.h | 2 +-
>>  support/nfs/exports.c        | 4 ++++
>>  utils/exportfs/exportfs.c    | 2 ++
>>  utils/exportfs/exports.man   | 9 +++++++++
>>  4 files changed, 16 insertions(+), 1 deletion(-)
>>
>> diff --git a/support/include/nfs/export.h b/support/include/nfs/export.h
>> index be5867cffc3c..ef3f3e7ea684 100644
>> --- a/support/include/nfs/export.h
>> +++ b/support/include/nfs/export.h
>> @@ -19,7 +19,7 @@
>>  #define NFSEXP_GATHERED_WRITES	0x0020
>>  #define NFSEXP_NOREADDIRPLUS	0x0040
>>  #define NFSEXP_SECURITY_LABEL	0x0080
>> -/* 0x100 unused */
>> +#define NFSEXP_SIGN_FH		0x0100
>>  #define NFSEXP_NOHIDE		0x0200
>>  #define NFSEXP_NOSUBTREECHECK	0x0400
>>  #define NFSEXP_NOAUTHNLM	0x0800
>> diff --git a/support/nfs/exports.c b/support/nfs/exports.c
>> index 21ec6486ba3d..6b4ca87ee957 100644
>> --- a/support/nfs/exports.c
>> +++ b/support/nfs/exports.c
>> @@ -310,6 +310,8 @@ putexportent(struct exportent *ep)
>>  		fprintf(fp, "nordirplus,");
>>  	if (ep->e_flags & NFSEXP_SECURITY_LABEL)
>>  		fprintf(fp, "security_label,");
>> +	if (ep->e_flags & NFSEXP_SIGN_FH)
>> +		fprintf(fp, "sign_fh,");
>>  	fprintf(fp, "%spnfs,", (ep->e_flags & NFSEXP_PNFS)? "" : "no_");
>>  	if (ep->e_flags & NFSEXP_FSID) {
>>  		fprintf(fp, "fsid=%d,", ep->e_fsid);
>> @@ -676,6 +678,8 @@ parseopts(char *cp, struct exportent *ep, int *had_subtree_opt_ptr)
>>  			setflags(NFSEXP_NOREADDIRPLUS, active, ep);
>>  		else if (!strcmp(opt, "security_label"))
>>  			setflags(NFSEXP_SECURITY_LABEL, active, ep);
>> +		else if (!strcmp(opt, "sign_fh"))
>> +			setflags(NFSEXP_SIGN_FH, active, ep);
>>  		else if (!strcmp(opt, "nohide"))
>>  			setflags(NFSEXP_NOHIDE, active, ep);
>>  		else if (!strcmp(opt, "hide"))
>> diff --git a/utils/exportfs/exportfs.c b/utils/exportfs/exportfs.c
>> index 748c38e3e966..54ce62c5ce9a 100644
>> --- a/utils/exportfs/exportfs.c
>> +++ b/utils/exportfs/exportfs.c
>> @@ -718,6 +718,8 @@ dump(int verbose, int export_format)
>>  				c = dumpopt(c, "nordirplus");
>>  			if (ep->e_flags & NFSEXP_SECURITY_LABEL)
>>  				c = dumpopt(c, "security_label");
>> +			if (ep->e_flags & NFSEXP_SIGN_FH)
>> +				c = dumpopt(c, "sign_fh");
>>  			if (ep->e_flags & NFSEXP_NOACL)
>>  				c = dumpopt(c, "no_acl");
>>  			if (ep->e_flags & NFSEXP_PNFS)
>> diff --git a/utils/exportfs/exports.man b/utils/exportfs/exports.man
>> index 39dc30fb8290..bd6669f431ba 100644
>> --- a/utils/exportfs/exports.man
>> +++ b/utils/exportfs/exports.man
>> @@ -351,6 +351,15 @@ file.  If you put neither option,
>>  .B exportfs
>>  will warn you that the change has occurred.
>>
>> +.TP
>> +.IR sign_fh
>> +This option enforces signing filehandles on the export.  If the server has
>> +been configured with a secret key for such purpose, filehandles will include
>> +a hash to verify the filehandle was created by the server in order to guard
>> +against filehandle guessing attacks which can bypass path-name based access
>> +restrictions.  Note that for NFSv2 and NFSv3, some exported filesystems may
>> +exceed the maximum filehandle size when the signing hash is added.
>
> Now I thought NFSv2 wasn't supported.

My mistake, I will update this wording.  There's nothing here (or in the
kernel patches) that tries to handle the NFSv2 case.

Ben

