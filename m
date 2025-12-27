Return-Path: <linux-nfs+bounces-17330-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B9CB7CE0018
	for <lists+linux-nfs@lfdr.de>; Sat, 27 Dec 2025 18:14:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 03F5A301EC66
	for <lists+linux-nfs@lfdr.de>; Sat, 27 Dec 2025 17:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E026C3126C8;
	Sat, 27 Dec 2025 17:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="EWiVMuVz"
X-Original-To: linux-nfs@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11023142.outbound.protection.outlook.com [40.107.201.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B2A24466D
	for <linux-nfs@vger.kernel.org>; Sat, 27 Dec 2025 17:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.142
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766855664; cv=fail; b=JEgGZPC4uzpqZ+kRv4N6T6jR9g3mFGAbUHBMwuWDxG3m6ABvBSkgs5c7XqF425gnCOO+xUCRsuvzM8OlC/wBNpQUehabK/85qUVUgXb0vUvj450l/jE6Y6qI5ZP8qgIm1+SKFqvM6ffp8IdafmtZM0LaqgK+DyshipbL162UQR4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766855664; c=relaxed/simple;
	bh=42bNZZJOGDwhT4MFrY3vlfaQc+44bwbLJA8si+t3MSo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=L8vSFe5wVCZPfa7ibGl9kIJahxl5Nd9xZdq2QltC3mS3DC6UdoT2W3mVl5X7MPrH4/AaOgXO0QvZY2DtFZngpO940M0PC5mL7hlmUc8sZoxaO3StPTai9gtNggXT7XtV4SWtt/eNSTNMf9lf11BBBZ2ShWH7T1PNgSssNIjsEKs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=EWiVMuVz; arc=fail smtp.client-ip=40.107.201.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JT95xLysoA9CBLfFf+WjIX6/6+nEHEzcwVrGuKeJKmdrvcOnzyo3kTv4iiX8MR0qUOW6ZcEekwg/4rzdSlgi8mEo1QHRvARzV3/Nfa0g5PhPFD57mnbvSy46kzYBkS1jxzGK+D7ZLRBIyNP7flRxpB83bGeqt00n5alPWckWQ+8cZUatvbrnA5ULJ4pijvHqYb+n7woxwIukpKXBJEuRp+uJT5UkG7h1bza3Mgb60XtmaV6x2aPWuuXeA9Mbu4Crcmwbo08bLFL1mXiEobtwFhVPUiUEV4ZKtRyPueezNoJ9Gh2FUZg+TAiRcdi8TL9ocxS9oz3y8V20jQ2H1/BVSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uq1MS9ha/F3+33fbbTnJAJlnjof8etda0vDRGDwdTHQ=;
 b=O2JgI/bezNYUb2jJzMg19WjOCNXwQnR7sk4UllZDuO9xa+DP4z1BfbQe7bTOWceczoWdwe6yLisypobsWLZ5OGYNJb/pnE7SgH/WmxqHpZZWuDdzhERCP1xuy4NfutdZyJhUyOQirrL2TlwJ6sh4La0CaaKdIvxDw60bVB1c/mJqBlRfdUrSNjd50vSLXb1rn/y6NQh0mq5M+jp3VqJBWqzTT9Q+HqK9662TmrVLVYjCfY/+a2kC2pHpS/s4S6ozDK3SWs+/gYvTINYBJw7gD9xGTe9JCXndbya3N9MED35vQ0TZWALTOSeuGZFobyhaoOl9zm12jJy9dI1xriJ1pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uq1MS9ha/F3+33fbbTnJAJlnjof8etda0vDRGDwdTHQ=;
 b=EWiVMuVz0/o7CPZRGPR0bd9zzxfkyjAXqm4WJhijTBu1X1isgip67SbqVHRgvFDqw64c46yM3YuMdpT5TExg9QBMhbVOWVXa0fDciXmzVr7/BbuThkaDkAhqQvO9syyF0y8iKzAnchLRWg+jkw1HOx1Nv+mbO2D+05wJMJbo9Eg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from SA1PR13MB6648.namprd13.prod.outlook.com (2603:10b6:806:3e7::10)
 by SJ0PR13MB5286.namprd13.prod.outlook.com (2603:10b6:a03:3db::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.12; Sat, 27 Dec
 2025 17:14:19 +0000
Received: from SA1PR13MB6648.namprd13.prod.outlook.com
 ([fe80::c48a:c42a:aa18:2ef4]) by SA1PR13MB6648.namprd13.prod.outlook.com
 ([fe80::c48a:c42a:aa18:2ef4%3]) with mapi id 15.20.9456.013; Sat, 27 Dec 2025
 17:14:19 +0000
From: Benjamin Coddington <bcodding@hammerspace.com>
To: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
 NeilBrown <neil@brown.name>, Trond Myklebust <trondmy@kernel.org>,
 Anna Schumaker <anna@kernel.org>,
 Benjamin Coddington <bcodding@hammerspace.com>
Cc: <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v1 6/7] NFSD: Add filehandle crypto functions and helpers
Date: Sat, 27 Dec 2025 12:14:16 -0500
X-Mailer: MailMate (2.0r6272)
Message-ID: <17CA8289-2B5B-4004-B3A0-004352345559@hammerspace.com>
In-Reply-To: <0688787cf4764d5add06c8ef1fecc9ea549573d7.1766848778.git.bcodding@hammerspace.com>
References: <cover.1766848778.git.bcodding@hammerspace.com>
 <0688787cf4764d5add06c8ef1fecc9ea549573d7.1766848778.git.bcodding@hammerspace.com>
Content-Type: text/plain
X-ClientProxiedBy: PH8PR07CA0029.namprd07.prod.outlook.com
 (2603:10b6:510:2cf::27) To SA1PR13MB6648.namprd13.prod.outlook.com
 (2603:10b6:806:3e7::10)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR13MB6648:EE_|SJ0PR13MB5286:EE_
X-MS-Office365-Filtering-Correlation-Id: d9677f63-9b0f-48f8-439f-08de456b5f1f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5VtxKpgeNiRnSvHwbTh3jOid8iJzpUjIZPeyEPUCtS5ujNeD1A3oNfVm+vCW?=
 =?us-ascii?Q?HmWlKDZn2E6uyGj3ZAKp5mmCHG900+tMn8Xain4fGH6ndnpoDL/eXfTAc6oL?=
 =?us-ascii?Q?LvlpXDBoz9w71wQeBxnFzyYybZty+kmd91Uqh/9TwyvnSJrH4lyxLmUMn4S4?=
 =?us-ascii?Q?nGhYRMUAeRDqQZmRqED1FjjWZfI+wdTqJw2g4+0XrhuEW28ZatmAuy0fxLXv?=
 =?us-ascii?Q?F+3r2P3Vaf+Uu87gAGK3qPMwL4AJGC4BDhZo6Wykh11zR97SDRwetAaO42mE?=
 =?us-ascii?Q?6CCDyzpeuanbWXtOeRjwPPc+3su42uxU82Zb0UbcDi/jZghktDq2B1rjBKtN?=
 =?us-ascii?Q?GgjaijjC4yN95g0+t9DmrdlaCTNVrSQ3hUkljW14OcOgXWCkHSUT2KV/4em6?=
 =?us-ascii?Q?XbkIjCpAYyL/xG+E96M4g7KmjGdBtVgWkvkSJ6rez8niwLDK908OCG8jqCS6?=
 =?us-ascii?Q?TDdRefsaLdwG6rjMMuIrTbsZMa8JbbDK6Vykil8ymIqGA18E3nxLhniU22GN?=
 =?us-ascii?Q?GgOnl+QVD7ACQk/aFJ75gHyh1TKJwczKP8JFWIq/Ptcj2Jw4VmH+LFZRuol+?=
 =?us-ascii?Q?su/7aqo4YEnv8GzEzYoMT601DpDKdSVhISZyOp5fa7UU+wYN4EOsmd0xq7nD?=
 =?us-ascii?Q?LQ27oNhqGeqgV3DZm+ai3T2WDGc98s8kP1ct+sYo2Y01ShfqSHu2VpWCjuXW?=
 =?us-ascii?Q?uNLpYSXxmd+/75J3oMw28h0ORswLFVHGrdr9pz5gw5Mz7vJ87qIUHbYk0D4M?=
 =?us-ascii?Q?Nfs5edElJGbIgw9wUC/e7LKRBMQKIqMd3S9990j8Eku1vrmvi+LlVbIPsx74?=
 =?us-ascii?Q?dp5pDkOqLYfgu4nDJ2sGfIrslRTqOZV/no4DR8zlXgFeA/XmDOrfHACRGmFn?=
 =?us-ascii?Q?noVkbCjUlpfZxeTloXHFcIbCqvyCbWXelR4DzY6jsSme83qsP7bYCmLXYMpO?=
 =?us-ascii?Q?QHgH+Gf7cooq1eaXx0gvM6OuzoBGa8j6a4xrnr/ir+fK/ul7m9wLGzwXr14x?=
 =?us-ascii?Q?Hx9Dz/YQrNU86dZ4qxQmfrWlS/N1Ra3z3Su+9K5VP2VoEqcSW4cSsGFIhoGv?=
 =?us-ascii?Q?H2gvUcRpwAqesxnHQIKDRDUSXcAef4mSc3UBlgULp/Gp/O2wIqPsclij1u9x?=
 =?us-ascii?Q?nOLjYTMvOx57PNJckcKMXNen3axg2sLBMg/V7Le15fn+2oNJbFnigg2bn3k7?=
 =?us-ascii?Q?qufKclyVtW0jra3NtVMhdFBBxNKZMHtsDab+eLmL0+E+4jukYD3cIdhHAXj9?=
 =?us-ascii?Q?8dQjk4uA0+WYVE00mehOnRLEkqzLAaCcIzRtUBFLkpuCKpgBOgtuDqKfakHB?=
 =?us-ascii?Q?3x5Y8NHaDs1zt/KD5bo8clBn3uC0w8NCdJtEP68qQCxqzcE5cqwgAwVD6TC2?=
 =?us-ascii?Q?CC4L6yNsfD4kcPuaW7r9Nev6yBKuZQ73tIBSL7wsCQFI7x5DNdAyeZI+09Mi?=
 =?us-ascii?Q?ssRX93g6MuDBEZ0qUnQU2aSJ4H6eAUnY?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR13MB6648.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?t6yvtAZx4+TWG7GkpqK2rI1u+MRobuXGa/3/oFBX7Uo3Yl02GcpAGD2SDwFb?=
 =?us-ascii?Q?lNcy8hX/NQTuFXCdcAqrygLMfo2oCByocunHX+6yW5seChKYbV0KpOgCM8UR?=
 =?us-ascii?Q?134PPMJ65gkFLcYai6KMxxiLkjGFbEJn71aP0IFs48t8ZUIURohicK40WCaf?=
 =?us-ascii?Q?lQODnf1a6Vboaj2X10ID/GktmZ4Ka6LWVhMjtIT3/e01FIv2SCfWIEi2V4NI?=
 =?us-ascii?Q?3SLv1zc9E3kTCone0QLjZGhISPaIYpaqJQuyvpqPa7RLU3YQKkiJC6tWExaX?=
 =?us-ascii?Q?wLNrCqpZeJW4IyMbEmatpvNgT9NvHv8tP+o/p5Hr5CWwov0ZizAO46fVm5vv?=
 =?us-ascii?Q?QETOTYDVBFsUmbsCwye/UxAzXvUJInSzs9Yn8fisBGfu0VHY/dpqg1w86PSx?=
 =?us-ascii?Q?17upOVKR0TK7aq6jutglBupeO6hxq93r/tIIkWOD83KeZ4/Ve+YlWNErrSw0?=
 =?us-ascii?Q?ejZJtMnPGBx39dC+nQ4z8Wz+y0m5G4HKgMHLGJU79hwvr92tY4hLUa/Xaq+T?=
 =?us-ascii?Q?jIUJ0il4cNM2MuFuTJ7eDDJJig23QVKnuDIbjloE1wM3qi8hReL5zw1k6/7y?=
 =?us-ascii?Q?zp6il9w93RLLVl3/e6VvuKGQqdq9tl7/z/bA5mqlWcQ6Z8qErVozQC45fVQN?=
 =?us-ascii?Q?BCqdVcaTnlHKaYQvFTL3BNRmp8F5ogYyjkt5j8SYS823t++KQ+7/039Cyp+d?=
 =?us-ascii?Q?Do745Sv9YJuSphb0qcP81TnirPUIoKwdQ2D1y8EL5vqoDGvDQLWAEnYHF57r?=
 =?us-ascii?Q?YY0l94+h0QDv1zByWmX9CDjRVzDTHFZjHH/8VZUj/xmrTMiM9zi1asoB8xtZ?=
 =?us-ascii?Q?KoLJAYXzCcT5XM7I1zhi78ZJR0VggkOUQaVzoQg97r2wM7vUbRmQR3TtflQP?=
 =?us-ascii?Q?dLUs2a6H0hoi1rTBq+ahTCxFYhwDo1P8rPkSbZhuiAqGy+21Yu4ct0OgQfO/?=
 =?us-ascii?Q?Ljn/ouvPmigBWC9W7rARohuxilBmtcr3VvA/AW8MMqhKxhDQ/5QFTes0TmTk?=
 =?us-ascii?Q?NzBMeMbcFMMwuGtRmhOLSFCVyqLRSQkGZtilnnx0t4t350BOjMErHmctVDpn?=
 =?us-ascii?Q?qOp4dlbHi1SznP6iCM/HoyUJ8yDoBVxP0bqJxKCNQi5NscgUkGZy4eOm5wf3?=
 =?us-ascii?Q?zuDxyMcD4XK4vXEmEmBCrT7LtxvToW75EHsv3zwkaisIgmE3TgJq2LMPQJFY?=
 =?us-ascii?Q?9NXaCAVvIpr0akRNW0BjFLNcUth+/poTuy3T7eF/vafoZ++tbl+y+giZLgFr?=
 =?us-ascii?Q?i5O0LR5cF+QdN6rOmAO7C+h+Swt9hd02r9xKcSL8NV/pYYii2/Qc7l4OCqLx?=
 =?us-ascii?Q?iHhkAwHF0EgaBX2cD+QjLdD2LE3nzwkk5r3ZdxReczV52nJSWEs9sDg4zM8e?=
 =?us-ascii?Q?gQD3+SMpZ8Ac3oT02zwlQoOMvwSbKqQnW7JxIa2/8CW4fgwvEjkeBNzodKFk?=
 =?us-ascii?Q?MHgwysX3cH5DtIBTcCBFhqOqfi4AGFUi1tLbtZQ29V+dzx3TLeCBtBnNriix?=
 =?us-ascii?Q?AzkJPkP0S+UorKhil+JskHp4punqWqBO3nhNEg3eg8/FaWlto0lzasebGrTm?=
 =?us-ascii?Q?AHJ4s9lhlKrOXDQ8F0ox715aScdkNJ0HlnjAocTkIdfkdObINztCTWmguwdI?=
 =?us-ascii?Q?/1DGs89AYN8iZ4ba32u080pvgADCj6YiYx51YKifZIOzdrY8YcDOHDpFKREK?=
 =?us-ascii?Q?EolE/I6ekGENxUZgjpx/lwxvyYl+fvh0zyAZGb2Jo4EJq9GJE7T8D7188E/F?=
 =?us-ascii?Q?1AiNAbWm9hTB/sRbziyfUsG+V18c9Tc=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9677f63-9b0f-48f8-439f-08de456b5f1f
X-MS-Exchange-CrossTenant-AuthSource: SA1PR13MB6648.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Dec 2025 17:14:19.3385
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kFGB3htGX1nYYD1ZXlIFgXIt+PQAt+ZgziLx49RXc8RqApsD8qiYp9uqB+HizYviNXUZqn3lt+os0Sk7UjnBSjQBFsgKji+lCsaWlW14Qt8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR13MB5286

On 27 Dec 2025, at 12:04, Benjamin Coddington wrote:
> +	if (encrypting) {
> +		/* encryption */
> +		memcpy(&a_buf[fileid_offset], &fh->fh_raw[fileid_offset],
> +				fh->fh_size - fileid_offset);
> +		memcpy(b_buf, fh->fh_raw, fileid_offset);
> +
> +		/* encrypt the fileid using the fsid as iv: */
> +		memcpy(iv, fh_fsid(fh), min(sizeof(iv), key_len(fh->fh_fsid_type)));

^^ this needs to use min_t(size_t, .., ..) else we compare signed/unsigned..

Thank you -Wall x86_64 build..

> +
> +		/* pad out the fileid to block size */
> +		hash_size = fh_fileid_len(fh);
> +		pad = (bs - (hash_size & (bs - 1))) & (bs - 1);
> +		hash_size += pad;
> +
> +		sg_set_buf(&fh_sgl[0], &a_buf[fileid_offset], hash_size);
> +		sg_mark_end(&fh_sgl[1]);  /* don't need sg1 yet */
> +		sg_init_one(&hash_sg, &b_buf[fileid_offset], hash_size);
> +
> +		skcipher_request_set_crypt(&encfh->req, fh_sgl, &hash_sg, hash_size, iv);
> +		err = crypto_skcipher_encrypt(&encfh->req);
> +		if (err)
> +			goto out;
> +
> +		/* encrypt the fsid + fileid with zero iv, starting with the last
> +		 * block of the hashed fileid */
> +		memset(iv, 0, sizeof(iv));
> +
> +		/* calculate the new padding: */
> +		hash_size += key_len(fh->fh_fsid_type) + 4;
> +		pad = (bs - (hash_size & (bs - 1))) & (bs - 1);
> +		hash_size += pad;
> +
> +		sg_unmark_end(&fh_sgl[1]); /* now we use it */
> +		sg_set_buf(&fh_sgl[0], &b_buf[hash_size-bs], bs);
> +		sg_set_buf(&fh_sgl[1], b_buf, hash_size-bs);
> +		sg_init_one(&hash_sg, a_buf, hash_size);
> +
> +		skcipher_request_set_crypt(&encfh->req, fh_sgl, &hash_sg, hash_size, iv);
> +		err = crypto_skcipher_encrypt(&encfh->req);
> +
> +		if (!err) {
> +			memcpy(&fh->fh_raw[4], a_buf, hash_size);
> +			fh->fh_auth_type = FH_AT_ENCRYPTED;
> +			fh->fh_fileid_type = fh->fh_size; /* we'll use this in decryption */
> +			fh->fh_size = hash_size + 4;
> +		}
> +	} else {
> +		/* decryption */
> +		int fh_size = fh->fh_size - 4;
> +		memcpy(b_buf, &fh->fh_raw[4], fh_size);
> +
> +		/* first, we decode starting with the last hashed block and zero iv */
> +		hash_size = fh_size;
> +		sg_set_buf(&fh_sgl[0], &a_buf[fh_size - bs], bs);
> +		sg_set_buf(&fh_sgl[1], a_buf, fh_size - bs);
> +		sg_init_one(&hash_sg, b_buf, fh_size);
> +
> +		skcipher_request_set_crypt(&encfh->req, &hash_sg, fh_sgl, hash_size, iv);
> +		err = crypto_skcipher_decrypt(&encfh->req);
> +		if (err)
> +			goto out;
> +
> +		/* Now we're dealing with the original fh_size: */
> +		fh_size = fh->fh_fileid_type;
> +
> +		/* a_buf now has the decrypted fsid and header: */
> +		memcpy(fh->fh_raw, a_buf, fileid_offset);
> +
> +		/* now we set the iv to the decrypted fsid value */
> +		memset(iv, 0, sizeof(iv));;
> +		memcpy(iv, &a_buf[4], min(sizeof(iv), key_len(fh->fh_fsid_type)));

^^ ditto..

Ben

