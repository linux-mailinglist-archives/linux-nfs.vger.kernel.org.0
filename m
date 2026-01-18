Return-Path: <linux-nfs+bounces-18086-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 39C8ED399CA
	for <lists+linux-nfs@lfdr.de>; Sun, 18 Jan 2026 21:38:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 077B63001FC0
	for <lists+linux-nfs@lfdr.de>; Sun, 18 Jan 2026 20:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 040C51D5160;
	Sun, 18 Jan 2026 20:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="KPuzfWeO"
X-Original-To: linux-nfs@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11022107.outbound.protection.outlook.com [52.101.53.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26AB13019D9
	for <linux-nfs@vger.kernel.org>; Sun, 18 Jan 2026 20:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768768726; cv=fail; b=p0nzD5CQhdNDqneCaZqvS6aXyqDENF5e+bnvTeSwkn3YHhHFbE7HhaQR0Ps8kY+Z5Nvpgq5w9hjboSd63uRqGFcJSd1mGrnfw/yeVb4Hn61+okusfzLSW1uc07gluhSaT9uS9ytutSbZRAVY5GxNBnYHrGtbTYDhqhQ99qu5FPQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768768726; c=relaxed/simple;
	bh=2RlH/3BZAPeaT03RqBBKui998K4keekYPsm1ao07N8E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aSMPReEwmbwPY8MReQSPOmlPMfG7SIuJI0CW+vaoGXoOKB9SJRz81zPA3UiFihDvqFmMee1HgteXbFGH3TiPi02VdAWWMlYC70ax6VCLplAUxTEnvqWkdtAirIeey25rZwJSmD7OAZPFNhT/DUSr94hfG2j5pdKuhzWIQ+pb5aI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=KPuzfWeO; arc=fail smtp.client-ip=52.101.53.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VZ+vLRwhDuiCec0a2XYrL93cPnCV3VLIzu5iFTjoAYfhp8Y0nbgfmmnz5heD17tpOlCIPxXVYdTsWAx3ffoed9zt40IHf8temV3Ize4DaFN+ymvqZJL7Bpwt2uG/CaZe8L8aX9BfzHbfUNNlc8dobNDN8crejLjNo0UZ9JkJsJQzhoV/debu3Vu43jOK/LurPQQGtIVNnf2v5krG9+csw7v+75DHFgcEPm3WhdI6LWP6FYcsi4S8/AobUJdA6KwFPVpNXxOhlyeJVejri6pz5pSAQa5POmIdstwUvToumeQoEbxpjiZqBVik4JGNGcWtQao830R0NYSJqtlDAdl9tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yodv9QnJRHSqu7UfB6akrAL9ipW8TTSBTdR+ERcjilQ=;
 b=qZ8PAYKCfXrzmRF+JJgbPDwTabm6wGp2rOFubEwM1QpkHjizBAfo5NtwqXhMNF3s8oBY4pPpVG8C2teyuy1O/IoDcSB8+KX+MKgWvJ96qBWTi1do5rmtYs8K7E9ZNw7Ku7NjwkD28xanmFR548GKeF2bLG576VHQTKPH2gHwKOUS9jzff6+WXSBp3MP4khOju9mWj0CWTQqyXx/NlH5/lYxTa73uDP1hMCs854sLUvmw4nOTlHNkjm2bUOjsBzvfXR3fATMuFcwuXMMKYstgfsKnzkjXiAtsL3xCeexQuQUo7hihsxL9BhmCa5OyANgv/V16JH4hiQrGw2dte8sM7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yodv9QnJRHSqu7UfB6akrAL9ipW8TTSBTdR+ERcjilQ=;
 b=KPuzfWeOW5jF3ptMimRNPk81v+TfAC7dCgPoTb7P7SzPxakGB8/7NZMnqREUQhuhEpF2sD4o4zUhvTIyjHaeLu5ehZ7Dwd0FANrp/I4TTItmwjiy5tQsmgf1zBIwJszeP9D5EqxCYY+fjqPQbpn2l5aHMb3qKt2Jx9Mi4K4MQi8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from DM8PR13MB5239.namprd13.prod.outlook.com (2603:10b6:5:314::5) by
 DM8PR13MB5157.namprd13.prod.outlook.com (2603:10b6:8:a::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.11; Sun, 18 Jan 2026 20:38:41 +0000
Received: from DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3]) by DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3%4]) with mapi id 15.20.9520.010; Sun, 18 Jan 2026
 20:38:41 +0000
From: Benjamin Coddington <bcodding@hammerspace.com>
To: Steve Dickson <steved@redhat.com>
Cc: NeilBrown <neil@brown.name>, linux-nfs@vger.kernel.org,
 Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH v1 1/2] nfsdctl/rpc.nfsd: Add support for passing
 encrypted filehandle key
Date: Sun, 18 Jan 2026 15:38:38 -0500
X-Mailer: MailMate (2.0r6272)
Message-ID: <733F089C-9E0D-433D-805A-3D91EF19E0AE@hammerspace.com>
In-Reply-To: <b8a5e632-2f23-4706-9daa-8e25133d1f8c@redhat.com>
References: <cover.1768586942.git.bcodding@hammerspace.com>
 <90fad47b2b34117ae30373569a5e5a87ef63cec7.1768586942.git.bcodding@hammerspace.com>
 <176868679725.16766.14739276568986177664@noble.neil.brown.name>
 <8328B53F-21DE-4237-AF79-5DE88D53D8B9@hammerspace.com>
 <b8a5e632-2f23-4706-9daa-8e25133d1f8c@redhat.com>
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0006.namprd13.prod.outlook.com
 (2603:10b6:208:256::11) To DM8PR13MB5239.namprd13.prod.outlook.com
 (2603:10b6:5:314::5)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR13MB5239:EE_|DM8PR13MB5157:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e94470e-54d9-499e-acf7-08de56d1907a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7142099003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?v7qKWOC2QZV1A55I1KWogSyuhc9QK/gbeN1TNiZyge9BgvRFlBpx+dOj9Fge?=
 =?us-ascii?Q?Vz8JLfPqIyhOK35ZDS9TVXBLoXdRlntaOjxryc+cufUayKsqPHnIL5AT3F/u?=
 =?us-ascii?Q?dLPKehG8DnB0fKIxaRfMTCEjo4XJf/4gRU1ZP989Kq5/8v2V2BNFiRBwoXwm?=
 =?us-ascii?Q?oZxtXx3f9bUrTjg7gaE0KmFlhq+JeiTpB+CvL26IRD9iDyQ4vlh+MiFM6WkP?=
 =?us-ascii?Q?qkWW9VpadqvQTJhGz0zC/enjXl2I9ygkvpMIe0RGYwB6xtJ1OqwQIUW51H6s?=
 =?us-ascii?Q?YpfC1p+QnM1LieC+hvPuQicOBc5c1qRvfB9e6j1rYWEr9MjM/7UVSXvD8znt?=
 =?us-ascii?Q?Fr/++KCJYeWGaDaqd2VIjlfdzWG80DfTj//f0zH8myE+MqF+zg/xSPVckExH?=
 =?us-ascii?Q?jQ3XxkygjriyeQzgUgQCe92LBri9pxZ02d/Awv5+AuenIDoBE5IO3hwyJALp?=
 =?us-ascii?Q?bCiRANMcpSbozI8jdaF6Jk/yleH2Ly5W92JT035Gp8bLW6aVXpHKcu1042t7?=
 =?us-ascii?Q?Okqms3F1pE47G7N/tGvPojcLizBjV+i9c34ThdOIVvOnq53Au8dz7AGzI/Ox?=
 =?us-ascii?Q?lFviEZokyhMFfidnr5X64v7hn05ai8twhMtx1cYIlbGEfh2az0liRQuea/5T?=
 =?us-ascii?Q?oVnhNfQtwgdh2VBToNrB6ATcsTyfsSgeuLRwka2kCyuufw89ecebHu57CP4F?=
 =?us-ascii?Q?zLitrx6Ym3PkFhyt28ZuW0OHkIYfYKCRQM5sG8q2jPQDhFsrD5RMEzjXe93p?=
 =?us-ascii?Q?kHaKnv8QoCeS8nkgLAz3vJ0I+3A4js7XwcqerTPMLhGmfChkqBBTN5v8ZO9H?=
 =?us-ascii?Q?j/k4p1hK+ZyfW6E62gEn0HpfGUHA9RGPpXqWsyjzZRDn/GTzoflYy/MN6PWS?=
 =?us-ascii?Q?7liBlwABOOD04vAS2OShFCTxSH7oT1hltd6CmjW3NQLkVkuiTQ2h6QEdPG0L?=
 =?us-ascii?Q?JkeZlaSXh8syAyBFdpxsTfc2CNijRmHOseCxiB9OJoF/IGhKd4KH9pr2AIIW?=
 =?us-ascii?Q?zvnL57uOabKvm3/GiBS9xMSflgAA9fZRW3evZ9W/f9ArL2J99GbmdjrBRRLG?=
 =?us-ascii?Q?avgOJgFN9GVR7MSOZo9C7b4KUAWcWIdT1HfJoAfMePTZYL8+gKiraaB+r57Q?=
 =?us-ascii?Q?RqZaBwproseoU0LJQIojuKVI+ksCTB1dVjpgrq6E6pjc4AXLgFKaxk7QXtTY?=
 =?us-ascii?Q?5tN5Y0vQciSaMYlZWzMYQWy7b/igwB7QRndEYYlI6v1YRaZwPEy/gXtqxFMS?=
 =?us-ascii?Q?fg3ONZgaZ1yqZyWMbfCyaehx7eWogcefTj3FboC8bKccfWL2VwFTCwiKHalZ?=
 =?us-ascii?Q?B818jgel/dIuBriQbMzmDyhf9KorWCSNjRDBnWaow7s60mCY7dyb4d8LQhQa?=
 =?us-ascii?Q?mmHNIUjCw/mBFnhQwHqInrrLtuxs5E10snhCqKhakWSlx3VAy9nw83NWWg2w?=
 =?us-ascii?Q?+W52x1sI01m/wKP74KScPlec3WnTHdKyCFIB7ufmrBorPH8tvDLSN4V1e48S?=
 =?us-ascii?Q?wTAVbRWYRHrQqAcny/5QMxQENZ+iI9hzF/97tdcgN3XRiTmP7h4e2EzfODF/?=
 =?us-ascii?Q?tiOF2WB2pV+/ZGk0tT0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5239.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7142099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?osizFu32p9Cj0+xYIadgnXxOG72A9EDmDuh6rvl/41Z4T1GSwJANp99yLIIx?=
 =?us-ascii?Q?b0aCA6iUQsvQBAQZY6J1g1f1k7vnSVGFq5SJdPF0GjN7qwshQHlGh9X/EA81?=
 =?us-ascii?Q?D7KK/MSZ5Lxc+MGpjqXNWdG6vfx52yzwYtsK94sOzfhrkmyCI86UXUWjPmyC?=
 =?us-ascii?Q?HuNFJtuV8aOl7eB2oyQU/Y8AyTuP60twY4OxijfBLGh828g/6xmp+BKEiOD1?=
 =?us-ascii?Q?BvxXnMcNLGf8gXBURHoNp36PUP/bh/ilshWQaE4PB7EBjrX9LzGgDEwubPZ/?=
 =?us-ascii?Q?ByqneKHz1fWNDCFbF3KNXxgdsP5ew+mZ6qmefFyZuKiKHzA10pR31mQMmVMQ?=
 =?us-ascii?Q?njgAWUOLk3FWA0M0YrXO5cM86opAi0gx7keiUqFzVre2d+PuGFwT50SQNwr5?=
 =?us-ascii?Q?PmfWQFVbsgouuRuISofbsKF89nZ02yuzZYfsExeR1LYP5FF61xlcgNtKolA1?=
 =?us-ascii?Q?4ig4DJtR3KNHKX9oyqvyB413Y+L64S/gJdEYP7K/9Y1q4SMMnBU/uUeMS2OG?=
 =?us-ascii?Q?SnFnHAznJEFSMjgbO94vyNspFvQvgmhgLQ20bmEZTsQeG0bDnraA09C9BnVJ?=
 =?us-ascii?Q?KKZkete8+lQ+iKN6+53bhFDuy+FmaNknlqdpBVXPhbrzgY+H0oEb6i2iswVy?=
 =?us-ascii?Q?1w1K45/5+QtXBAbLOzV6gT3cNI2wz9dElpLBq0oKUVZbdDWGGjqcEV6SXxpq?=
 =?us-ascii?Q?eMVWz4737JsRO7xFd1KyqhIZ6MUfWTVgVa9k858GkLc5E4zqDCWt1g6O3T++?=
 =?us-ascii?Q?atOfx7vWhKiTSlahO5OYnRURDgi80M5VsGn+os2RAh6m2m/jqlQddglnj9FH?=
 =?us-ascii?Q?REUDM46jvaTiWfMc1CtVzb1t/UW0/aTDFgAjacE4xgO7qsmREaEEafkFX9k2?=
 =?us-ascii?Q?9GVO13j34FQvdsRRQiBeRzUpJ81HZeBZv5IUZpejKXIxN1aEEFauZElPkHVT?=
 =?us-ascii?Q?GS/d+f2Nh84ZSsjqpmPuCcyoQ1z8KTvj6qmwNBD2+Jmszvqs2/yKd60AZfXw?=
 =?us-ascii?Q?Em8e7R325oexQ4JRnxYcmtcAUCvWt4yhpTVPnEIGyIn8f3B+E6K9NvKoAw/h?=
 =?us-ascii?Q?86bCdMePDVac9WlEkOYRwlsOhgdKMaoupsAOrZZNqrg3dnRtgXfdLQ6MWOOb?=
 =?us-ascii?Q?Kg+FDwuFtZCrTHbBZZ3wd7xYi87LdRXs6F+8XQ164elGSwe4scFgcUXkjYgh?=
 =?us-ascii?Q?FkqA2diFh5Vkwq4rTHeZeKnbVHZJbqmIoXCNo8MJYy7VqGyESzLDdBXpO5rW?=
 =?us-ascii?Q?gcAnzdIvUSVeXo/RdMLRYowmjEoyA+p6mB8rZrRMnFRDBoD+eMwIqJjAPsnj?=
 =?us-ascii?Q?iKVY/hUghNuTGM6E+ZkXN9PUevG7w7oCv6ykxr2el936V8yoX4vT7K7ba+tb?=
 =?us-ascii?Q?iynvsd5Oj6T9FL9vKJBoBqgM6/BKomluBZpHxqBSZrCpd9eNzPZPiY9UDUpy?=
 =?us-ascii?Q?/lPaTgCmvG3NiXNvTy2TNvB9jhrjhUCRiIhXY/XdzSXuiAKKep2PaQaqNj9u?=
 =?us-ascii?Q?OIUe4RcmA2GbTfIZbcEh9+aog2MBVMLzvM/ZdXmhQTi0gQ+MJIf9x9+4rOHY?=
 =?us-ascii?Q?AlmEWBqB/YPB92whN+PYLkkpu4jwey7nIV36pBN8Y+qT8Oeqp95z3VeQ5aNO?=
 =?us-ascii?Q?z6MhSR+kVKnBBstorC0tZ7c1qHEysJo4Jk4dZ2mDOEQ9Nxur6Oj4ksICU417?=
 =?us-ascii?Q?W3JltOYpbuNELDkvalGrVXAIOeNvUhQ0MSklbjcGBO2OeqxGdYupeauGVrul?=
 =?us-ascii?Q?bi9cqUJKj2otXVDc+/Eju/j6e6m8Tmo=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e94470e-54d9-499e-acf7-08de56d1907a
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5239.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2026 20:38:41.2526
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WwKXAQtkfONIKxkhk3HppwY+vOfeMnttOTXSxPi0aWCTPxTbnvrmtLKM7tuY8J6pbJDTnx/kw62Fjdvbr2STeNWgaOpzavrT6IzIp4vufbQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR13MB5157

On 18 Jan 2026, at 15:09, Steve Dickson wrote:

> On 1/18/26 11:59 AM, Benjamin Coddington wrote:
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
> I'm a bit confused... This patch conflicts with the
> "nfsdctl: Add support for passing encrypted filehandle key" patch.
>
> So which patches should I take and which patches are tested ;-)

Both are tested - but this series is more complete (but still missing a
hunk), because it has support for setting the filehandle signing key in both
nfsdctl and rpc.nfsd..  I am going to send a v2, probably tomorrow.

I think you can delay accepting this work until the kernel patches at least
make it into Chuck's nfsd-testing tree.  I can keep you appriased of the
that status.

Ben

