Return-Path: <linux-nfs+bounces-17344-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E66CCE6A74
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Dec 2025 13:11:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D02453007614
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Dec 2025 12:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B7CC27A130;
	Mon, 29 Dec 2025 12:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="aET9mwwB"
X-Original-To: linux-nfs@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11022127.outbound.protection.outlook.com [40.107.200.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9E1271443
	for <linux-nfs@vger.kernel.org>; Mon, 29 Dec 2025 12:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767010310; cv=fail; b=Dlnp1iHLdLAfiIAku8IYpbcCd9e0dRmztkgLPC347PvQ0iJboQLXw695t5vP1OT1cV5WpRf4vyrsZk6z1qLbqE6i/D54844LTfyrpCJZzZ5VLJ5c1HhFcf2P+Te/dBXxVUJK6l0Q8fqFwzMYvdo9hCkkxt+9Jg2QuyZebIr7GBY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767010310; c=relaxed/simple;
	bh=4QP3tshV1zaxGCneU7f5UO+w+NFwtr+JdQm6r0aERAc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fNy/XWAt/U/hBGOS59SdlXaiSW6tZm5rehS+9f7aLDvQYpaMz1NQx6MIhZ9khqe0feHc1bXKmDZwQYcf/kscifqNgKzSRpxf6fXBqJH6H3y1jgaX+xPBb3nBb6dBI/rJdXnDdvl/Glql3FQCtT0gJGf6mo1OHbB62cVXswvANrQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=aET9mwwB; arc=fail smtp.client-ip=40.107.200.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=giX4o4CHNeMYMGAyH76YwJi6+onHRgUT//5NKDpcf7G8QdPQt62XbPa8EmQ38que44ROAEZWUgvpM7oKcR3WNbi7uqVWKujemTfYKAkoumUODUpnFhGLb4sQlBWxUGITvTTOJUHItOldq951TODg0jPXmjh0xbZeox5kDQkRp86ZQtg7e16NEuPli1xtgaWPhI59nHJmM9USg8lO3MtPvFyOSdtedqvOS+Lfat/Vo4+AJMRCEwqTJCB19u9g1LPUwAWtBqNCzvmpz+sQvoKi01D5cS+/RbvnA6KqNnFW7teYibIbKoqyEddMtOW6ygTOjwCo8A0N67d89k5mveMtfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y+xjA4xNCxWWH65Q6f+94J2qVp5JD21lpORSbpDtxaQ=;
 b=a9A7i5sMW+xiw+//FL3XpbgF5yxERLc+ZaomACNj4qoaNd56VUiTz2LjdPDj4VKYl6cRqKKeTeTp/PPMyZK3eTPfKAH/jgtN0z3KQbUleuZSBORXo2zkgwojRZp8tl8DMYnX5wuZ+DcKNCMO6ixcAKuuJt4MJJUiJJPQACIEzvBoVf2fcmjYjWEjeVTIsFBpQ9wlR29y3l/8MSmLyxYdEKcExh77IC0sAKNvEnlMmkWuQy86x/5OZAn2mCwW2ubLjF8g+LuXMR9U3ZgKGw6PVjcV3B4UVLz+hahErFyPUZ+mg6PQOaJ8fIV3rNvYG+3mxZkqHuyk2BpIjM+G/GAkiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y+xjA4xNCxWWH65Q6f+94J2qVp5JD21lpORSbpDtxaQ=;
 b=aET9mwwBz5gL4PGhYCiJzU7XRYBM7F0CKrB5euwxtDkxdFIqJhWvjE9rOjJEAyxwFAsZzqdC9hsdXWxScsRiOrxyb2Lmx+Cabt7IEMjZPGM5QfjfyznChg/cb6Oj1hNi/ngygvIYALcPFLBOaBCdy/mh5BA0Li/LZ4vnXKWjZLM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from SA1PR13MB6648.namprd13.prod.outlook.com (2603:10b6:806:3e7::10)
 by SJ0PR13MB5270.namprd13.prod.outlook.com (2603:10b6:a03:3d3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.14; Mon, 29 Dec
 2025 12:11:44 +0000
Received: from SA1PR13MB6648.namprd13.prod.outlook.com
 ([fe80::c48a:c42a:aa18:2ef4]) by SA1PR13MB6648.namprd13.prod.outlook.com
 ([fe80::c48a:c42a:aa18:2ef4%3]) with mapi id 15.20.9456.013; Mon, 29 Dec 2025
 12:11:44 +0000
From: Benjamin Coddington <bcodding@hammerspace.com>
To: NeilBrown <neil@brown.name>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
 linux-nfs@vger.kernel.org
Subject: Re: [PATCH v1 1/7] nfsd: Convert export flags to use BIT() macro
Date: Mon, 29 Dec 2025 07:11:41 -0500
X-Mailer: MailMate (2.0r6272)
Message-ID: <854F25D2-88A3-4751-8F9C-7EA3F77DD64A@hammerspace.com>
In-Reply-To: <176690003439.16766.6214649554459236248@noble.neil.brown.name>
References: <cover.1766848778.git.bcodding@hammerspace.com>
 <55ef75dd1010f20a449117405b281c0e9318fd43.1766848778.git.bcodding@hammerspace.com>
 <176690003439.16766.6214649554459236248@noble.neil.brown.name>
Content-Type: text/plain
X-ClientProxiedBy: PH7PR02CA0011.namprd02.prod.outlook.com
 (2603:10b6:510:33d::8) To SA1PR13MB6648.namprd13.prod.outlook.com
 (2603:10b6:806:3e7::10)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR13MB6648:EE_|SJ0PR13MB5270:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d0e4e52-0920-433e-a7ac-08de46d36edc
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mU/LL6zQSR6uTp0XTs4Y4Xcc0/D/E8Cg/LYiN+EFKpdYNaKji6j5PhHpH2cP?=
 =?us-ascii?Q?xLsUXLfmW/aqI7qP+iVyu6gYcHceQewGSEOcRs3QCbEsTM5MSvT2WqTU4DzC?=
 =?us-ascii?Q?tWv05CxXrRtRtSAzmq99WuGnC3+s78zuMfc6TzzjbHLpdUREba6H+c3P4FUe?=
 =?us-ascii?Q?ZaJaN58JkJEt3EzlR/mUbWFJX0EVrRVKBtSLmFF7klCqOkVnHl8r8RXYCpYV?=
 =?us-ascii?Q?5rFkjH3ks7K7pHlg8rl7xK5WW0056jdSpFy1f5qqndyoCbRqXxwJ0u4Ag+7H?=
 =?us-ascii?Q?pl6S2mpmIFotgV1jGLPTguMbKISaSNciM7UpsKEDcW/yVJfkJlnFpklsQfBg?=
 =?us-ascii?Q?OXMB1RIq9kC/+AAOVXb2tz6AD5w44MRRVBmrLU+bkYz7h7fnbgO47wVnQGZk?=
 =?us-ascii?Q?+9DRHqCilxy/rf/EEzEECTtIxb+ge9ucmrJ9+CSEBP/p7qyW3Xu+ABoU8K8V?=
 =?us-ascii?Q?CiVo+U6H1BhFqc2yT6u8Ssaj7xFBoL9+SGVQbjPFwfMRbBvW2YDJ3Z5SdEpv?=
 =?us-ascii?Q?61YFsBTlmpsgK5J8iGqRmfNg96BIoStay4H+QT1R02jcd98qgMZDurL/V8oE?=
 =?us-ascii?Q?EEtOdE2lGTsn/9DUvLxx1d97n0+TiWqShpCDd9b2bG1o3MulA2h5YovJIg3Q?=
 =?us-ascii?Q?34S1Ge9Bdvej72x0110cWLQvGXEKkkoHf2xSZJZxHpn/+rsn09YBiFEttjWA?=
 =?us-ascii?Q?bCLBjZS+2bj6Q4fYWM5abu8NhV3y0k4MoMPNyyrdOTk3RGtqgEJ7W3udzeXO?=
 =?us-ascii?Q?fLQ3NSKwAArZKQaI5zImDLq3mIW14nrTTBH0nE8vExE9hLBvwfJyznnZnXDn?=
 =?us-ascii?Q?BYnlgrKFqQF4zpIqMdya4dfXZtTIJWgA82lAod1PLrTSczqA78FywQsLgLnB?=
 =?us-ascii?Q?bdeS/t1QKYFUnpgsZqsWuP344YnTCRstBPQ4rEVNyhp/dYL6UH44fNAZjgNp?=
 =?us-ascii?Q?IdiG+5XuM16kyh08yuxEOZ9cwczhl79Dz+k2kyoDHJjYFLQAfwokJXVw83Qh?=
 =?us-ascii?Q?Kp/WQG7nSq/6zwOzWWPKoOsf5axM6OzmE1yUnfRSRXMFZC3NZuO7h4Oo303k?=
 =?us-ascii?Q?S9iiAnXVDQRnal47Elta94PXQpR0iV6SXCobrLOEC7pOR85FX3KRcYdzx4RZ?=
 =?us-ascii?Q?9GM39/H+sPQNc7WP9mM40kig7EZC/0GFxTgGz57jRunSgWzf693wns/0XxC4?=
 =?us-ascii?Q?LYsnpy0+pnrc7K62tdA+bLIt+0Iy4KTaC7Z8PPpTDc/nwtrGZe2bgS3nLS4k?=
 =?us-ascii?Q?KrWOfZP+KIKGKqcoaHtStgwLOT15nyM3LQSZlSwT2oYX/OdwA9a7NshfEWBX?=
 =?us-ascii?Q?4pRjhi8JFZqukcYjcTTKrT6kgabQI87RTes3efqbXH6lfBWxseDzbden/aWR?=
 =?us-ascii?Q?RdiGyz5EE1x2c//cU1XZNLoxeUun+zb9FHc7EB4Fzi2qmOYn+TNsUl+k0RMD?=
 =?us-ascii?Q?XsqRx83TDiR/9YkHfr028QA9MXLDEx5m?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR13MB6648.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2y3GZ0PSAyg5v5c2lc76oUF3r6t2uT2OgQgDVGJbrV/z7ZMyArn8NgSA00eA?=
 =?us-ascii?Q?4rYasvVbuAfjJkkPtAQpnTZBkItLAZJtRbsSiNOf8Rjvjk/gcQMx3X2BB+gf?=
 =?us-ascii?Q?1YD31f75me/DDHLhGeVOr5bN7otmIegpFOdpspD9Tr/gN5O8VczJexCQ/6JY?=
 =?us-ascii?Q?86s+sFBjqRa+9yZ0QhQMkifg262ZpKVoBnTrbfc6NKmrPgaiyIiIbITKFR/m?=
 =?us-ascii?Q?L8iCXnCc3Sn0i21eXM0K/nxfcDzguPT+G4RMVkeFACupHE1K7+6I3V2jBHOG?=
 =?us-ascii?Q?IKbTiYrWsOFcgUs3CUkzXfDIO+wVMWmUf+53RPncupSWtpixRw/GBkJay30x?=
 =?us-ascii?Q?gUXX2P/WAiy1fkGrYR5Mgx9wpaK08bms1p1bzDkE3eaRi9njTTp9K7OY2zgR?=
 =?us-ascii?Q?J238eqKWL8DD+Gqngfq7v05m0u0RbTx+B+cGz6uTaLYbQdBb8e00eGVsXJ7M?=
 =?us-ascii?Q?A6GlaT/QR06MphbjPK4saMblwlRA02GsIFiuaz6EK+efrca7HabGmGT+Bq+Z?=
 =?us-ascii?Q?cr+CUq5hfaeurIBm76e4O3fDnsnPWFNBzZTX6G3CIQsqJxflVDXY5Lx0467r?=
 =?us-ascii?Q?tPfq2PEGWT+179dF9N22DtIC5hgmsrbgPK/WDu9DuuJr9McEiqvuZy+bken8?=
 =?us-ascii?Q?Gqs1+Ih58w7h81TAmFwbBGe7HgCpDnT7CkACdLk8yAwO94A3S4X7TKoL/uHx?=
 =?us-ascii?Q?FlNv9zVoWFXCcN/dsGkSVHyeo1MZ7Xy/+pLnqDz9VRWJPO6z3oHsPw4snnEP?=
 =?us-ascii?Q?q7RcTg5jW1H2vrDTqxQ0x4JqlxFsLXzQfU2vv6rfvyWxEJewye2CUMhruAp5?=
 =?us-ascii?Q?BRsoanPCatHZSVqCSsz0jMItdT7g0mq243fWPnZRbdcu7gYsYHUc6RnzzJbE?=
 =?us-ascii?Q?FeKeCpesWzM8eOZo2hfDYR6aKatu3/oTDeDhjyw5fRHE1Gl4NmMmZOqeUjLk?=
 =?us-ascii?Q?Jyfg/OQv+RSpzXQcncZnAWZuFdW9xpMoRaryLSRQmi4akz4QiWlqJG4zFl7q?=
 =?us-ascii?Q?bCN7pMnmiZYwLtNMSpbRb2jT/Ote4PCV5kyO1kZ/cynac7lL689nIS5A4XqP?=
 =?us-ascii?Q?BOLQIIxPslfvQd0oatjI1p+9m6waFti3s0TBTn1McOYRRTfCIxPf+iatN2rG?=
 =?us-ascii?Q?lkjY1DB63xp55JiOoAoth1rzY8dz1pPkdrY7efGMuFfosCBjhz6uqEOulHdO?=
 =?us-ascii?Q?+oU0Tkoo3lF4fIGonh0Lkiep55Y7p8+fGxOLmi6lCAKPIRvC4yeuCAffYKpi?=
 =?us-ascii?Q?OMLMxXjke1vIOcA7Of2799dMVBhkYPRe0h8oLUPT+wyg49bogY+n74vrjfjV?=
 =?us-ascii?Q?tjPPKGyCpQKs4WtSBmBraWbMzusDH2vxhfR7CHaj2fC83kExzBODptiFkZJ7?=
 =?us-ascii?Q?YOTMMwSK0Xfv/LeuiAh69WfIOUEc8nzfq5042B+6BsepzQlJH8Hr/bu9gk5/?=
 =?us-ascii?Q?axhQR/fHUnjV1aAPAoh+UQ7Ew7SrsdQv2laa9ReU1GIy5lufY9s6wGsBatE2?=
 =?us-ascii?Q?IF0xIMrfA3mSf+EF5paJPT3cyS/oBhr62xyz7VcsZ2NkesZ63YcqAR57lKt1?=
 =?us-ascii?Q?OUSYSA4KMPd0bIeCaDhTDmW5Sjq1T/UOEsHjxF07I9PIpm23r8xFjMfhxp/v?=
 =?us-ascii?Q?MDG5he1R00CxrA2utFPHl3/hTIPyPj0iKe4jmCNH/8RDZceTV3sV8hPoCK67?=
 =?us-ascii?Q?VkhYvwy0mBNHQMg2Yol9gh/KJN14cVTDykcGwBVTZaIiN3Ern4MCAJVGSsKg?=
 =?us-ascii?Q?NwGL2LIIPSoIyWOglrrWRl2A108Y6qc=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d0e4e52-0920-433e-a7ac-08de46d36edc
X-MS-Exchange-CrossTenant-AuthSource: SA1PR13MB6648.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2025 12:11:44.6315
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GcbbYz8YMv6o8gs6aHp2pl9Kf1K9SFeagnQNVT3uKjPd6Fwc5xa1Xkm05A/MiIF3ylEMCZkW/ZRuO9z0cx9YMWeY/cg2URTmX6u794v/ssE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR13MB5270

On 28 Dec 2025, at 0:33, NeilBrown wrote:

> On Sun, 28 Dec 2025, Benjamin Coddington wrote:
>>
...
>>  /* All flags that we claim to support.  (Note we don't support NOACL.) */
>>  #define NFSEXP_ALLFLAGS		0x3FEFF
>
> Could we make this:
>
>   #define NFSEXP_ALLFLAGS ((BIT(18)-1) - NFSEXP_NOACL)
>
> Or something like that?

Sure can, will do.

Ben

