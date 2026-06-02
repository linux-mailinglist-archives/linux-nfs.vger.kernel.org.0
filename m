Return-Path: <linux-nfs+bounces-22200-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +G0VDIS6HmrZJgAAu9opvQ
	(envelope-from <linux-nfs+bounces-22200-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 02 Jun 2026 13:12:04 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B185162D2E4
	for <lists+linux-nfs@lfdr.de>; Tue, 02 Jun 2026 13:12:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5FFC83071CA7
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Jun 2026 11:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B28A397E91;
	Tue,  2 Jun 2026 11:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Ea4DL2V7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011015.outbound.protection.outlook.com [52.101.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6D53955FB;
	Tue,  2 Jun 2026 11:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780398291; cv=fail; b=bD66SbeM0m3ZIHrK9l1JbQchL6Ic4N4WcJT7rc05jADq+vi31G9uCTYKiWSw+m60S4/YHw8hbPHkQegm6CwCYnNeDPJoIIHUqyh7BaaQhPCfaLCwmm5iIwWtr0bAN/r9VDdKelJ1/UPoVEU9M1XGs5G+P3GWQKKZRREhqTyQ9Rs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780398291; c=relaxed/simple;
	bh=3SaOOkLHsotaZ59op/597eTKC3ZCy59GlZvhwB14CXY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NDvryK5XW4fWpCcUPoOenSMqSDBwD6EHAEt8G9QugPzdfRhxtsoxdolbLcVORoTR1sq7BS3q2DDQ3ek26owwEXbcVDkW5jt3CVG/yNWSsw6KZR3VjN6iCW4FylPIijyNaJTnroURtw+a4lfSH3bJWp+X6YIrLI1Dq2Q07vFvMgA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Ea4DL2V7; arc=fail smtp.client-ip=52.101.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RLd4p7IvX/ugxkINYMz6+6ekh4C2weloTWWAPqqKg2EfTiAErdCsFP7fEpPFZq5XHSrU8y3YJy5AqMvQFcI9Wl45mfwjfxBxT2bJFvhdEYZuvlROvSyEyU319wwipTmI2VuFK0JQeCLbnIpYtlkEP8/i5soQYHl/efdQjtuiJhdlEWlZPrxWH2i1WLoVGLhEVum/2s1aHpkoREfSWj4NZOL32f4Db3krbcQgX3BZjEbXW3fx3jvwUoxI9/+8vPZonWaLulCzC2ZB+GIXFsg5D83bcgWEUO+xOWWlKZ7o0sniuwcOeJPyq9mkbMDmVyp8npawaIA2pevDu7E35opHzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1SkM6PMSJyb59KtUP6qAeixpjiOiIBqPeTrrlnb+7FM=;
 b=LLtqS2t5IV+QvpU1Uz3XMUOs6YMz3SICY3mHCg84iyUONwU7D1UIUMqDmXLM0mxhIVpZnM8Yyz+Rm6VjsfXbjD2Z6ytrJsHb3LR03NS83F94RinRkaTrY68xG/wzZjodpXWUkPFmUUkvj/mdNNZ60+Al7IcwWucJi67ESN/LES1emw/0O7ZbajrE/7LBPw+aFgQH5EZawp/5LqnxjnY0EG930FmKvR1HCAtGh2tNf5yZblPE+9XiUdOt9TXHC9t68UlIGX7hUfVa0th2ikwtbgo7d48+2LKYIMQq1x3bJ5Pd6KxnHbadY6Vdx1G+2IfpWuFMCFwqWxbcwqa4i6szDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1SkM6PMSJyb59KtUP6qAeixpjiOiIBqPeTrrlnb+7FM=;
 b=Ea4DL2V7j+uv4euBJzgf4/UijpN8KnbD89t9chj+N9KE6GT26irhxYRqELmPybqrjXzHmqIA6l6emJORIhuXq8VEAt9mcPbWKGJZEknMSV17ykaAy5t9Xg3NEqSd/UVARM8CfjT8MlX2IKXBcKP2h5ogD2IcVf91QhRlO0r5YOre4QZcS2VaMtanmWnF81+qvxpBzQbvkYOdG2xa6qL84EdWSJokUfBMKIqn/umcTyuegWYhAbPSNAyTtxe8arqApaISRHkiVx8HdGGoBZbx6MmiHVp9tQVPUaEjP2pBiWdWliwFvtNowQEpjYirZ3JHqe91hLzf+WiU5YEphlmqpQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DB7PR04MB4428.eurprd04.prod.outlook.com (2603:10a6:5:35::11) by
 AS4PR04MB9508.eurprd04.prod.outlook.com (2603:10a6:20b:4cb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Tue, 2 Jun 2026
 11:04:46 +0000
Received: from DB7PR04MB4428.eurprd04.prod.outlook.com
 ([fe80::2c47:ed15:8f49:9185]) by DB7PR04MB4428.eurprd04.prod.outlook.com
 ([fe80::2c47:ed15:8f49:9185%3]) with mapi id 15.21.0071.014; Tue, 2 Jun 2026
 11:04:46 +0000
From: xiaoning.wang@oss.nxp.com
To: trondmy@kernel.org,
	anna@kernel.org,
	dros@primarydata.com
Cc: linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] nfs: keep PG_UPTODATE clear after read errors in page groups
Date: Tue,  2 Jun 2026 19:04:38 +0800
Message-Id: <20260602110438.3489554-2-xiaoning.wang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260602110438.3489554-1-xiaoning.wang@oss.nxp.com>
References: <20260602110438.3489554-1-xiaoning.wang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0017.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::19) To DB7PR04MB4428.eurprd04.prod.outlook.com
 (2603:10a6:5:35::11)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR04MB4428:EE_|AS4PR04MB9508:EE_
X-MS-Office365-Filtering-Correlation-Id: fad07aee-5ab7-4477-4f8d-08dec096c1c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|376014|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	TJTPCV0XO0zETAHQZSaEJRNNK7Pn/9595fJgbxIhPCrXJwHScPCI34U3M+3o4eS9HKJAmP3ViOyAYX46ladDuE9f8NN4l8eGxf8TtHdArEJwlrMZIXwmb/2ko/1a0NfSaHBYzYTL53KdtEesy9NW/4gysYzWgvSXdhhFUMwEGP0c9bloQ1q+hL707zviJOq+een6ZX0mlsoIWnYPRZhP8ixf7oWjJIkVovUJeg+RFt1CDMeyjvL0eSW2NngQcKGtatTj5hjgFuwTieeD0gCY3qz0ZPZJgk2fP99UWUi5AzDKp1m1jUYMJZWRib4M4EmMjTNbc4FGDgHaltmQXH2ju63vfmkodQ/NvPmYyqzFDQRxjEEg4F41zS9Z+fs7/9I7upKuwuTNoUMzOIEkEVhi7kOTtsD6u4PZ7FeZgGARqUEOl2JtQANbwNANLjWHzTBP0fK+JiHmcG2mzQIzLtYchwqmSX1e6sEATyJ+2OfBGZ/HROXxcG47xe3/dncTcplKdn1A+67dLzhEhA4PuLyvTvEocBF3tFG8/DwNZzoA9OBoQvjOR3gDbdXpJmI4i30bNILTffH1iXseufh91mwf9rp66hgcF/dptlxMWfOFf0KpVwnIeVXP500uZtj23jMusnfo8f24omfiCo4O+bU7PzyZZpFkKCCGRrCLz4PZqyQ6Ox9Q/7k11VhSqDaNkEdK
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4428.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(376014)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?695OKXJfOB1K1DCEMYJP8gtXYdzQyv0c06Q3xawr5AHRExTKo/05UexhGsIS?=
 =?us-ascii?Q?SmnuyIYht/NusBhpnxPUvXEBqG5eyRy8WDPL00I/Ddjp2h0FCMMplGLX69Ac?=
 =?us-ascii?Q?RD4OjqJUOhU3tN5Y0Ln+guH9YqfITZnVQw16d2/smZyQjeYSpIGtzLTjzWlN?=
 =?us-ascii?Q?khSMhujcKID3wdLSWmyO2dm1+zKoYjIkLKLJGunSQfbsoeoC3/+2DHfhKfXW?=
 =?us-ascii?Q?lafEoQMiVTW+3jwLFqP2Rr90NyIerkUnMNF4oohMhokMF/anLAnIL2RipKc6?=
 =?us-ascii?Q?x+JAXl7HicYcBuQiVK8TPxBpYrsHKJ63ZBYp+TxYgAJveZ76yS02nglDOk1Q?=
 =?us-ascii?Q?CWGZdXQ3extTIkeJySkZol1KurYLDHQlGX6eZN/JZ72MZxhfnINedgIhyvpa?=
 =?us-ascii?Q?1XaRzLx7SG7IrlY28thqT8VJ9rx33Dus8T17EMTNZUTm1rwQSnpo2DJ1/KcB?=
 =?us-ascii?Q?O3M5MJNAqPaemZcl3ZXfT/T8PhDNyc4YHYYlpPoORoL8oA8hvjUQCNEq6m7f?=
 =?us-ascii?Q?ivOQkdTEHpfRqSaR7KOl+Dy77MQo6tkwFZ7jsL9o7aIAwTU2BYFx5HySTkl0?=
 =?us-ascii?Q?bckF0YKAcU6T56uYNju3QC5HDifTpvTAEhLsz3LUIPFRh8UE8yjUnfljcu0q?=
 =?us-ascii?Q?YIO6EiPjjaROZskAP6DBGK65zZJAWULNiJNwwrmnoeJduaj3MfHu1fqFudvc?=
 =?us-ascii?Q?/Qj1elemWVRWHe6b9Ra9cLtoJAY++MWEhJXDZuIjPp/T5THLGNPvNq3V8GbI?=
 =?us-ascii?Q?fcy5YTLLEzJCclWriuS6Z9KH5yN3Mg+/cOPuzRI3Y8dumt3u3k8Z2kDin+v9?=
 =?us-ascii?Q?pGgKEK77qJZMEXzgFzd7kJcMIfDHyTm/fZ5QJs+Q4LoVDs88OcyWtp2n9+73?=
 =?us-ascii?Q?Jw+BDuFyQSBDTAl4hw0e4tm/w369RrRgU90IAaAJXsiiFoSAeMuRZiArxhrR?=
 =?us-ascii?Q?4WmJNvTS8A4OOg6uQ3L7Ny8y1dVRJt7KDNiYQ3mEEuO24ibPYlXtB4/2QkXA?=
 =?us-ascii?Q?9uNPiAlJ8QD9CaOdpCtoy1jIXOGFZBGgm+sd3kMbDCQcQlrT4S6tJkPNYL7W?=
 =?us-ascii?Q?mFkrjAJzYGtWPrev8PVJ6dsA3A1kzzuuMzLBX0HVdijGf6SX0u47k7HXeCG2?=
 =?us-ascii?Q?BQBX/0IuCxL6fFG6BstEO7C1hBLsTcveDy9ES/bUF84FyFUOpyQnASkfN9Nv?=
 =?us-ascii?Q?GONvCtaFBvu2UjVkEpAYliG02D5NzQoZJRw+p+mkSWPI7o4rl/d7veG2dwJT?=
 =?us-ascii?Q?6hQnoEfkNLGeGrZOuImJ2Ogq1zW5etUs2/akZg7C2X8gy7zMV1M3a6ahu+xe?=
 =?us-ascii?Q?qt6uTYQVuqBpC5kTvfbkxMkzyUs8ugWXNnl8V8TnFYuJtKlnGPcq4vHgsjUz?=
 =?us-ascii?Q?HnwAYlZSNA/jRRFp5AQklawRYoIYmOBitp2yRBqwJuTEgM2j8WhPTNKUbgxi?=
 =?us-ascii?Q?6/S9Q+W/5bFjdasG7gt3SsOrfesIF1xYR362+JodonRGZyQ3i0E0kgaZWa8L?=
 =?us-ascii?Q?n+47sBtK1HF7zEEel6+bv0Wf+qr6GitJd/YWRiXcGPS1yJYNy1+EOCrD3cTl?=
 =?us-ascii?Q?kzMGQfz8mJEA4mmYkwHIGRSuTC0lkGVPTcXzBgzlqVdw70WT5CRqoZ7tSuCR?=
 =?us-ascii?Q?eLEmWJDHC5W1F7eWN7GePEa7yvxMtixbnXQy8MwWj7M40UFoGyxM/ET+RtJK?=
 =?us-ascii?Q?2y3x2ZX7HHkB2GegcXy8BPZYr1TiAZYpg7oT3i63q56dwQ8d4s/hJl4rYSAx?=
 =?us-ascii?Q?dM163dxam7Ald/D/cBs7F47a4TF+xTu4MgjBECKmtfn6ee9QD1vb?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fad07aee-5ab7-4477-4f8d-08dec096c1c1
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4428.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 11:04:46.4773
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 55toO8tOKfMpN8/MlRiYtwrYpj8Vo0Rzwbw56Xn9BrFsUtFvr9+mjWGfD9qCY5vMAde/OQ2fii+pLeKwad2fCCMFKbeo5aCcy+t1wj/WUIc83P9NJBEgJh5U7OY8rzgd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9508
X-Rspamd-Queue-Id: B185162D2E4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.94 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-22200-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xiaoning.wang@oss.nxp.com,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_NONE(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.nxp.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nxp.com:email,NXP1.onmicrosoft.com:dkim]
X-Rspamd-Action: no action

From: Clark Wang <xiaoning.wang@nxp.com>

When a read request is split into multiple subrequests, earlier
completions may advance PG_UPTODATE state for the page group once
their bytes fall within hdr->good_bytes. If a later subrequest in
the same group then completes with NFS_IOHDR_ERROR, the read path
needs to clear any accumulated PG_UPTODATE state and keep later
completions from rebuilding it.

Otherwise, a subsequent successful subrequest can re-enter
nfs_page_group_set_uptodate(), restore the page-group sync state,
and leave stale PG_UPTODATE behind for nfs_page_group_destroy()
to trip over in nfs_free_request().

Add a sticky page-group read-failed flag. Once any subrequest in
the group is known to be bad, mark the group failed, clear any
accumulated PG_UPTODATE state, and refuse further PG_UPTODATE
synchronization for the rest of the completion walk.

Fixes: 67d0338edd71 ("nfs: page group syncing in read path")
Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
---
 fs/nfs/read.c            | 25 ++++++++++++++++++++++++-
 include/linux/nfs_page.h |  1 +
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/read.c b/fs/nfs/read.c
index e1fe78d7b8d0..2b70bd2b934b 100644
--- a/fs/nfs/read.c
+++ b/fs/nfs/read.c
@@ -132,10 +132,32 @@ static void nfs_readpage_release(struct nfs_page *req, int error)
 
 static void nfs_page_group_set_uptodate(struct nfs_page *req)
 {
-	if (nfs_page_group_sync_on_bit(req, PG_UPTODATE))
+	bool uptodate = false;
+
+	nfs_page_group_lock(req);
+	if (!test_bit(PG_READ_FAILED, &req->wb_head->wb_flags) &&
+	    nfs_page_group_sync_on_bit_locked(req, PG_UPTODATE))
+		uptodate = true;
+	nfs_page_group_unlock(req);
+
+	if (uptodate)
 		folio_mark_uptodate(nfs_page_to_folio(req));
 }
 
+static void nfs_page_group_mark_read_failed(struct nfs_page *req)
+{
+	struct nfs_page *tmp;
+
+	nfs_page_group_lock(req);
+	set_bit(PG_READ_FAILED, &req->wb_head->wb_flags);
+	tmp = req;
+	do {
+		clear_bit(PG_UPTODATE, &tmp->wb_flags);
+		tmp = tmp->wb_this_page;
+	} while (tmp != req);
+	nfs_page_group_unlock(req);
+}
+
 static void nfs_read_completion(struct nfs_pgio_header *hdr)
 {
 	unsigned long bytes = 0;
@@ -172,6 +194,7 @@ static void nfs_read_completion(struct nfs_pgio_header *hdr)
 			if (bytes <= hdr->good_bytes)
 				nfs_page_group_set_uptodate(req);
 			else {
+				nfs_page_group_mark_read_failed(req);
 				error = hdr->error;
 				xchg(&nfs_req_openctx(req)->error, error);
 			}
diff --git a/include/linux/nfs_page.h b/include/linux/nfs_page.h
index afe1d8f09d89..4b9a35dbc062 100644
--- a/include/linux/nfs_page.h
+++ b/include/linux/nfs_page.h
@@ -33,6 +33,7 @@ enum {
 	PG_TEARDOWN,		/* page group sync for destroy */
 	PG_UNLOCKPAGE,		/* page group sync bit in read path */
 	PG_UPTODATE,		/* page group sync bit in read path */
+	PG_READ_FAILED,		/* page group saw a read error */
 	PG_WB_END,		/* page group sync bit in write path */
 	PG_REMOVE,		/* page group sync bit in write path */
 	PG_CONTENDED1,		/* Is someone waiting for a lock? */
-- 
2.34.1


