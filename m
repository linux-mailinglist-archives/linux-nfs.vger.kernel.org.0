Return-Path: <linux-nfs+bounces-18852-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AA2gIBlei2mYUAAAu9opvQ
	(envelope-from <linux-nfs+bounces-18852-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Feb 2026 17:34:33 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D4EB911D408
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Feb 2026 17:34:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E3F66306E804
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Feb 2026 16:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CFD330BF60;
	Tue, 10 Feb 2026 16:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y2LiZcAF"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E7F305E3B;
	Tue, 10 Feb 2026 16:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770741154; cv=none; b=CPw4B3ViPTrVK0QbK/reMj1Zs3+UPnsXPe3xJYi6Nl8JOWo2mh7GTZ2wtucbR/EdVUrZEc6cISvkLYAxQO1KroiDqs1YO192xo4muymfb0AJkISvM4gKNmm/s5g4JZnenIeNcrjG8BnRPKEwTspwOwIN9lzR7kCUd/Nkk/uqKfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770741154; c=relaxed/simple;
	bh=pusn716g+JIM3RS5MPp+XlMCPQGS0mFCQ2k7SNQD5zI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sjw+rg2CTkoIVSOQWYY3fMtDmFj6Sn4iPP+HKMz9r6nzxbE1BNOFNeV4ZbWIhVbLRv9XZ8LLf40333N/GCWGEjha+YWjZY/fho4FFFNTmR5n2Zb4v/WkAlLnGEHOxziKr9MEaGGWgWJ7tDd+3YrXnPSunQ0TjLa3uAFRYcYbQJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y2LiZcAF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9781EC19424;
	Tue, 10 Feb 2026 16:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770741154;
	bh=pusn716g+JIM3RS5MPp+XlMCPQGS0mFCQ2k7SNQD5zI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y2LiZcAFPUEW3kVBMtP5wnGfSk0hvy4o14ZsoNXP6icK1Hqi7Gkyk3APwkwepMr1J
	 NyEP4AGNq1ioPt3aNQB/niT+Ka+ARNbRmKJh2pKQNvGVo7G+auKIArp++hpkd6MU2D
	 OsI/IP+6aLLtu/pE56rH9i6Sxi34UmmP4qxEdD4hdnbTvVLDAm8JGXus5v7uYr01C/
	 w7fNev8Jg/WuVKp4TAY4SgjZPUqG4OPRseC0DpoW91BWEblkqV8z2PvuUZufDfYLDB
	 KEPu2fka2oHeGYk+rzpPcj0VizwtN6EChBBlvH9e97sQhEWfrVSVuEdIvibGqMucwv
	 TwU6t9yXCha2w==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [RFC PATCH 09/15] svcrdma: Release write chunk resources without re-queuing
Date: Tue, 10 Feb 2026 11:32:16 -0500
Message-ID: <20260210163222.2356793-10-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260210163222.2356793-1-cel@kernel.org>
References: <20260210163222.2356793-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[ownmail.net,kernel.org,redhat.com,oracle.com,talpey.com];
	TAGGED_FROM(0.00)[bounces-18852-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D4EB911D408
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

Each RDMA Send completion triggers a cascade of work items on the
svcrdma_wq unbound workqueue:

  ib_cq_poll_work (on ib_comp_wq, per-CPU)
    -> svc_rdma_send_ctxt_put -> queue_work    [work item 1]
      -> svc_rdma_write_info_free -> queue_work [work item 2]

Every transition through queue_work contends on the unbound
pool's spinlock. Profiling an 8KB NFSv3 read/write workload
over RDMA shows about 4% of total CPU cycles spent on this
lock, with the cascading re-queue of write_info release
contributing roughly 1%.

The initial queue_work in svc_rdma_send_ctxt_put is needed to
move release work off the CQ completion context (which runs on
a per-CPU bound workqueue). However, once executing on
svcrdma_wq, there is no need to re-queue for each write_info
structure. svc_rdma_reply_chunk_release already calls
svc_rdma_cc_release inline, confirming these operations are
safe in workqueue and nfsd thread context alike.

Release write chunk resources inline in
svc_rdma_write_info_free, removing the intermediate
svc_rdma_write_info_free_async work item and the wi_work
field from struct svc_rdma_write_info.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc_rdma.h   |  1 -
 net/sunrpc/xprtrdma/svc_rdma_rw.c | 13 ++-----------
 2 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/include/linux/sunrpc/svc_rdma.h b/include/linux/sunrpc/svc_rdma.h
index e6cb52285818..9691238df47f 100644
--- a/include/linux/sunrpc/svc_rdma.h
+++ b/include/linux/sunrpc/svc_rdma.h
@@ -232,7 +232,6 @@ struct svc_rdma_write_info {
 	unsigned int		wi_next_off;
 
 	struct svc_rdma_chunk_ctxt	wi_cc;
-	struct work_struct	wi_work;
 };
 
 struct svc_rdma_send_ctxt {
diff --git a/net/sunrpc/xprtrdma/svc_rdma_rw.c b/net/sunrpc/xprtrdma/svc_rdma_rw.c
index b0bbebbecb3e..e62abdbf84f8 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_rw.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_rw.c
@@ -215,19 +215,10 @@ svc_rdma_write_info_alloc(struct svcxprt_rdma *rdma,
 	return info;
 }
 
-static void svc_rdma_write_info_free_async(struct work_struct *work)
-{
-	struct svc_rdma_write_info *info;
-
-	info = container_of(work, struct svc_rdma_write_info, wi_work);
-	svc_rdma_cc_release(info->wi_rdma, &info->wi_cc, DMA_TO_DEVICE);
-	kfree(info);
-}
-
 static void svc_rdma_write_info_free(struct svc_rdma_write_info *info)
 {
-	INIT_WORK(&info->wi_work, svc_rdma_write_info_free_async);
-	queue_work(svcrdma_wq, &info->wi_work);
+	svc_rdma_cc_release(info->wi_rdma, &info->wi_cc, DMA_TO_DEVICE);
+	kfree(info);
 }
 
 /**
-- 
2.52.0


