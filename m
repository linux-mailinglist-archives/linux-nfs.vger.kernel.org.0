Return-Path: <linux-nfs+bounces-18765-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UEgKISEJhWmj7gMAu9opvQ
	(envelope-from <linux-nfs+bounces-18765-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 05 Feb 2026 22:18:25 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D0ACAF78B7
	for <lists+linux-nfs@lfdr.de>; Thu, 05 Feb 2026 22:18:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2C136300334F
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Feb 2026 21:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60AE9281525;
	Thu,  5 Feb 2026 21:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="HEuQMNM5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11021120.outbound.protection.outlook.com [52.101.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264C21F5858
	for <linux-nfs@vger.kernel.org>; Thu,  5 Feb 2026 21:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770326302; cv=fail; b=RdQkOs4+n4Jk7TnXkFhbbnYXquxfc6ptY0IW6bVcq7mXNYsrw9C1D0p4hguPBXzwoqzPvyU1xApaCLecw/yM+/EGWC8/5XjcKZe6x1xA+9ZToFjRJowh60qw2m66gcCJuioFhu3waGHF0Vf1rXjxLSbIr/bJSEg76doDTEEzyMA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770326302; c=relaxed/simple;
	bh=4laoq12CQUDi7NUylD1hZ4GqjNtEeOVYhRx5bwpticM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CkLBpHMgtxbj1GMcHdUUs9JOprlSuYfgsL+33axAJGZYVh+I3GbcgCxgp/9WXlFefkuyyjLqMcK0hk0WOVvd2sCmY2ijUuTIZ/frIUcS93Or1Ipd+A5Db36VHSw6bTL43IuMlQsxULYQremnwsTB26RiSFxtaKHTBb7vRfpe1zQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=HEuQMNM5; arc=fail smtp.client-ip=52.101.52.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SYd3G47Hn9HTaiz+jm7OcMd8/RFyQUxoxUEeSDmsLSc/5UCgrxFDYcRkFFpIjZyuCXSp+MWMfDiWK/BbTRFnNfhJAXYi3lGNlA0NUC6KlFjnbhAHlQkvUjBBEFbRvPfnMlIqKcbN4pb4EGVdwC9mnnTj6+Cx47SaDaYjvlmS11hP/i86hzFixdMbEY/9x47AY9URPlz/SBLu6OvYcKnhwoUXhPKJW/wMUJ5XJIBtmKAyoC0kreMwMf6PTAV0C2fhC82UVe1+y7tzqnClw+es2AiJ5FkFG7+IwwDp2q5sozMvZeAhN6ng+k6yl9uWd97k5+drBeaExKpANnUs26xomQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4laoq12CQUDi7NUylD1hZ4GqjNtEeOVYhRx5bwpticM=;
 b=kjYZNfa88rOp0iNCd8AnB0ZOidT/8unDyOakhu0g1KuGSQ9EhDGCgHqv3sXlFbWLo1twv9hyjE8K5349CPWCIzP4JcNN+t+oomg75pE2C7nW3Nhadoxy/WZshyTbZulkJ7/faHqP1V3kkGLPKMPrjNm2BfpWz8VYn/AsMwMNlvsuaLBBvjPjMDyZjnahrGb5gHm8r6pqyAPclfHcZGdgTYF/71K3Ulp0thVtdc2nlbsQA61+vadxPFHOLNG0Hqw5ujp/V539dJIGKEBsOSqWlqAOjY3AXoXrMJwabqC6kiW98c5TOsj73jYFR2UpP4VhHFmNmbb5yNgbx71eJRsaXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4laoq12CQUDi7NUylD1hZ4GqjNtEeOVYhRx5bwpticM=;
 b=HEuQMNM5gttHfj8dZWEVqnLOpNSl7eW/+ybbDrLMAjffDy07z+hKnJaQyCu0dq3gt6IZdmsGmpZsAB0tClB3j79Zcfep7nvm71QvJi4ZDrIkVHfXmv1vVIFRjQrKuTidfT67Hgv6b8WJngEGs622cW8GfBg+EnEpaG4nS/11A1E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from DM8PR13MB5239.namprd13.prod.outlook.com (2603:10b6:5:314::5) by
 DS7PR13MB4768.namprd13.prod.outlook.com (2603:10b6:5:3a6::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.15; Thu, 5 Feb 2026 21:18:16 +0000
Received: from DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3]) by DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3%4]) with mapi id 15.20.9564.016; Thu, 5 Feb 2026
 21:18:15 +0000
From: Benjamin Coddington <bcodding@hammerspace.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Steve Dickson <steved@redhat.com>, Chuck Lever <chuck.lever@oracle.com>,
 linux-nfs@vger.kernel.org
Subject: Re: [PATCH nfs-utils 0/3] nfsdctl: properly handle older kernels that
 don't support min-threads
Date: Thu, 05 Feb 2026 16:18:12 -0500
X-Mailer: MailMate (2.0r6272)
Message-ID: <3BC4C7E2-7800-4BC2-A937-4EBF4BE27F93@hammerspace.com>
In-Reply-To: <20260204-minthreads-v1-0-9f348608f884@kernel.org>
References: <20260204-minthreads-v1-0-9f348608f884@kernel.org>
Content-Type: text/plain
X-ClientProxiedBy: PH3PEPF000040AA.namprd05.prod.outlook.com
 (2603:10b6:518:1::4c) To DM8PR13MB5239.namprd13.prod.outlook.com
 (2603:10b6:5:314::5)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR13MB5239:EE_|DS7PR13MB4768:EE_
X-MS-Office365-Filtering-Correlation-Id: d326e060-17cc-4e08-71fa-08de64fc132a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?k3B40J56dlhlEnm4hdBXaX80n2O1Vs0LKMBa0T9kuj1Ci6eabm7RDg+MlRZh?=
 =?us-ascii?Q?14OBHOer021Imz3MenX6mqxYRbKAZg5zivkzdKd0aZlJqxeZmXft1sLnGILm?=
 =?us-ascii?Q?FjrwNSUOe6TjYTeJdVKRvcpClRLvm5n9M9wTauoYQhpGZZTQo0pH/1zkYpGm?=
 =?us-ascii?Q?5Pzq7IOEnxuIWM1FmoatoTSk/iV6Dbr0mpRetTecPYOXoBIQF0Z7bLuhZBj6?=
 =?us-ascii?Q?+REfQov0M3h0SPGCLksmR/gxtylYg6x2WOjghrdnaEGHFOieVY9y+89b+VTA?=
 =?us-ascii?Q?liPojYQh3WakKsx9Xdbi70kdAw7WEQmckijlc33hZqEpi88Y4ImV2fOkjIhA?=
 =?us-ascii?Q?DcUUiIfyUL0BdUfdSXAA6mhEehfI0Z8yB5OK7M+yA7yf+xXWAKBdJcpeY6oO?=
 =?us-ascii?Q?mnc2D7RaRO6OKTmzi1Wfew3ZCajwaG2y6zPx8gkDHBa4ey1w+vN28oLcVgPh?=
 =?us-ascii?Q?0z17ggXz7e31/KUi4YK05g4OgXIk1VTLl03lP4YGajATuP4sfBMBsobzfab1?=
 =?us-ascii?Q?hlEkjoerhfG8CXwJawmJMROYur67z/8O62Lb6OfYaSii1iWjLS+ClpIm2yjX?=
 =?us-ascii?Q?pxu2vH84py1fbPzwmmQue1qEz0d2VzbACbaJLBcdHUf24TfTspjharDxQVGU?=
 =?us-ascii?Q?OzyJ/N0XhvsfwxuwCabJjpxCnmEeQQYHHp8xLSWOw/DdjLLvfZen02dMhjoS?=
 =?us-ascii?Q?fN3HBKFGrLX6uJrRnauzCqa2N5vyI7w2xog8RT8oVJcNnVjJObSkLbcNcX/c?=
 =?us-ascii?Q?NkKYzauTcM/bHdOjNdFwH3WU9+IltPAnBuW35hCAUOfqQtbidm6mJ8LST0nX?=
 =?us-ascii?Q?kPOj0awGFNLoLlP/CPGeJbC1TLS0DFzj7Cr41CzToa7RIOc/Vc9Ji/vt3e6u?=
 =?us-ascii?Q?NvvflfMRxhG3W0/rUHYkqJD43IstqQOAFRYD6JK2Ll3r0x33iQISaRIJTKl6?=
 =?us-ascii?Q?hQKxTTy0oIJMqEmpA3svLizW4Fuy3XJWErdTviGAKLj5XZI2pIhzLTtIVXZh?=
 =?us-ascii?Q?WTxrSIxfAZf9L0Sq6mMUapkk28pUHKoHs8XCN2vLVvUzrOMkxiR9q4Pv9HDE?=
 =?us-ascii?Q?GysnhCOPotYE4QThhd5jgPrfsWB30ti9TWpafptqQgBiZ0NP74yWvIsRfCUv?=
 =?us-ascii?Q?jNx7MpgMSK0n4KN5RM6ASdTL0jn5fCjy217wx09Z5CBrRBWnMvATccil3h7B?=
 =?us-ascii?Q?CujYBqjXn2ZEG/TVjvHoyN7jyfQ4buPmiMLxR+Cgh4VcaoExRWId2MCJHzlN?=
 =?us-ascii?Q?VmCj2aH0wfFyPW4YpscR9H3XAHzyqrDMjc9ttQuibrixxW8HoPwaJt75i4GX?=
 =?us-ascii?Q?69LYoSnbQBkr9lUA4aJu0UyQ1eYu5LlshP6OxP+bfz2mN0N/o5pfdB4TKxs8?=
 =?us-ascii?Q?mCN89tQpvunJhhq098Lq7TRf+ywUy1WedPdkF3BZHkh0bOFP61TBftEgAb0h?=
 =?us-ascii?Q?Ej6+Z2A74wo5OJ7Q9U0VIjeL7KS/fqtd7Do/jZC04AXRnEQ2cw7x79fj1Wh7?=
 =?us-ascii?Q?a9lFtA8ZijxSG8fAjVjvcJtxmSgRtnvoapF9ZyLDeaLiBLc9JBlHiVm0PE6F?=
 =?us-ascii?Q?M4TOcz9pyutWCQDb2HE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5239.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mPLLD1cdfF79xUycrAXK1UO/yUtVw9ASKRaFL030K02Y2q8HTwZx4pxXF9AS?=
 =?us-ascii?Q?mq9O7l9tIEcSwIEy13X4IClimMsTCM2RM7h2UpsrgriivVZXnp7b6LHSiRv7?=
 =?us-ascii?Q?BZBPdAESqlBLAAkpmSoQzYtn0DSiMUnLieImt6aXSQspNFraxwAs60rkfF3I?=
 =?us-ascii?Q?N6neVvMHti8Iqgvmb74m/Jf7Mv6aJ3ZKpWejILiIlzJNlVn96FFnLiZ/TJfb?=
 =?us-ascii?Q?pETc/OXsznRbnzpJUtspWd9gkjhrdqW/3TO9UEvwVixdcg7yGmMBFrGHMck+?=
 =?us-ascii?Q?flH3IZSjPviCAwSrBxN6m1/ui+6FXSDlpxaBZuxn3hwkzhQpCbQzpk6xFGS+?=
 =?us-ascii?Q?6rjs568Zfhy32D8Fz0TIs9205CZXqOYQjLmGW88mLd4/sz7fiPrgUN6mkCdY?=
 =?us-ascii?Q?fQhmqzC9RZER4kjRaKHalexE1MXDBfSWBPiIjfXyp8CmIm69Mlh9vjsOqKdV?=
 =?us-ascii?Q?9zy7CbjC+ll0o/LiSva6yVZvCRoGf2tpSkF5VZe1EroRJcCLHlIQ9fdIH8yL?=
 =?us-ascii?Q?FDv05221NHtnuBPuECRwUfTa5Z1lbjvnr40BJjHSkO0gHwCK84GMzNKraXIF?=
 =?us-ascii?Q?x0siA00++1JWqqZll2V0Qu+Di04F/rqboj29GgkkGhSNjoqauZOe8uRZPwBq?=
 =?us-ascii?Q?JMSK3W6EJfp+oFTWTlPgeZQQ82NyMugJRLoBhWTHmCqkezZtkbjvPfpn16eh?=
 =?us-ascii?Q?Gbk+u2n6JzL/5GTrAYU+xBXYnRZ51EswDS6A1IxFiMw9j13DCcB632NzCLaa?=
 =?us-ascii?Q?+XFOQsDH1p2O7yQfPhsUOWOj+uq81NKEQsb4fN71MZaepsvOyb4j96nsfMMq?=
 =?us-ascii?Q?GP07vFGOTdzntMKIi5lSYDG7fyHT+Z54hNUZqBa/ACPiQRe2QYo3Hb03l7Lf?=
 =?us-ascii?Q?B3o36dI9ekJKd0gzTFDVs4vuLVwKceN2bEsL53ltcZqQcjSwLarJLyVE4ah0?=
 =?us-ascii?Q?bLpHruE3JjRZiLJ5tfgvAWjvC2ZLQ+N9bf56x88VIeSl9ppLnrlryyPssUyG?=
 =?us-ascii?Q?7kBMjr/J0b8GHGomff7ChCxve/hSlLe7RAq2MDDsb7VFajphsnf1nlsYqqUa?=
 =?us-ascii?Q?u3Y7lxmqCUvgunl/QHGCi52jy8NAYoeyWKSWqHNHC/ARP2gtTT5+yegnQjG2?=
 =?us-ascii?Q?2bCRklpZmRV3Yoy7sd1q0M2nB+IDfWUy8R3KXHxoAEsB5G/joDMMCC5az0/G?=
 =?us-ascii?Q?wyrr4q824pSn/996Cw96N8I/JQf4C9vP5niYyR4VnpLqz+Gri7iMVyxr/q1J?=
 =?us-ascii?Q?knZAsEYqVhfwPyjOg73Cf/z6RAlzAWA1QyGoMOuYfVC3htEL3R+YHff7WaeB?=
 =?us-ascii?Q?shmtylXEdfh8iSVj8aEd/3O4qksBK5zsaXsE8fLGbc/jtAwAaFeRG4vQbqtT?=
 =?us-ascii?Q?grzZCL4DK1ufCQza04eQdIMpkeN8D2HSkKokANY3lWsjn5LrBgW0IEx3E5PE?=
 =?us-ascii?Q?kMGvlKj3nRU8FyIUZ3DdK4XrqiYSN7dSuHN04lzhtRwmYRPZ17wBNA4ljBE9?=
 =?us-ascii?Q?5hv32Ko7PER9OGy0agb0eINkrrZaKDRX0+AwNidOUhTKaHN2S/Dkq/pXWBgy?=
 =?us-ascii?Q?Kv40fUFWDK+JWtgA7HR5/FhBd+q1omYD/Oh3Ww7MzKd/kcfHJUDeqmEToPx0?=
 =?us-ascii?Q?Ln/ou/iOtBuM0gFFWiEUojhXhpPCKH6KwIIsDtTQGrKUryQDFadLNxiyHjhp?=
 =?us-ascii?Q?Sn55p/1ohiEc7q1GreRUjzLHAv3OfM6TCttZCLRvThLUQTtihDkJERNqK8P4?=
 =?us-ascii?Q?TcF5r8nIxWW9f24qUTPJqKztg4SuWA8=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d326e060-17cc-4e08-71fa-08de64fc132a
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5239.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 21:18:15.1603
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RIH/W3kaGOGSbtrFZ47mcE0Iz/E5QjHJRqile7vOhPxXZcIbRKEuLQVC400QKJG5vYvBgjK0zH6Quwr8qpNKhuSk95vlxJ2W0dQz5nzJAHc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR13MB4768
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[hammerspace.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[hammerspace.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-18765-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[hammerspace.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bcodding@hammerspace.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,hammerspace.com:email,hammerspace.com:dkim,hammerspace.com:mid]
X-Rspamd-Queue-Id: D0ACAF78B7
X-Rspamd-Action: no action

On 4 Feb 2026, at 7:28, Jeff Layton wrote:

> Ben reported a problem with using new userland with old kernel. If he
> tried to send down a setting that the kernel doesn't support, it returns
> -EINVAL to the call.
>
> This patch series adds a mechanism for nfsdctl to tell what attributes
> are supported by the "threads" command. If can then use that to
> determine whether to pass down the min-threads attribute or report an
> error or warning.
>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Thanks for these Jeff!

For all three:

Reviewed-by: Benjamin Coddington <bcodding@hammerspace.com>
Tested-by: Benjamin Coddington <bcodding@hammerspace.com>

Ben

