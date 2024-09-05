Return-Path: <linux-nfs+bounces-6243-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F300A96DE5D
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Sep 2024 17:32:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AF981C22E6E
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Sep 2024 15:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A82F1A00EE;
	Thu,  5 Sep 2024 15:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uH8k+0/g"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BB819FA87;
	Thu,  5 Sep 2024 15:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725550292; cv=none; b=TKnG4AcG1Loiyw6ILSZl4JxDev6Mfeezt6usxB3fNKI5rOfcUaekXhSlMEqLngA/wU4B7kNDOWFX/BXqsvgYIvxFt2h75TmWcnHDcTEyrzHqUWxdT6Us7VwE+Yzki8J9NmN/0AOm5fSQ+c5aT2sGVQ/FGPOGj0vqZ3dCSLgWnzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725550292; c=relaxed/simple;
	bh=WrQwpFQatNZRt9Lw1ZfVw6rnfWjAGsPvrE+IRIcYlHc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G6CrFtzfxGzYheivXaiYW3CeY95h5RdZt+r+DjrMiwy/d59wsO5H0r6owPlMIzcbYqYPJQuRvU/HHwzS22jfp9Qj/ByyM32hxDs/CEZimFcQdEbCnFPjuHDDYbG1Ls1IY2XzX9aglBdTPp4qKQtiV26U4rMRCtVI7gxNCcrREGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uH8k+0/g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C12CC4CECA;
	Thu,  5 Sep 2024 15:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725550291;
	bh=WrQwpFQatNZRt9Lw1ZfVw6rnfWjAGsPvrE+IRIcYlHc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uH8k+0/gndH0iVE1k5N7/yXN5Ary2THP26wir3EgxB9/J+KTz7pl6mfGj8g6ErjkP
	 bIJLsr0VRhAYRCTpL4z7y+rMk4QbLKgq58oWryDiDBfJEsRHoyWlHQaDnDeudTjFn0
	 aWF/j/3k4lvMTQOElLgqTzJowW45sRXX46XAaMYFkj73UBHsvJBYo75w+HvivlcGMU
	 K1ZsA4wNE1p9s9LYkl0qnzBvSykY8QEBL9xNj4E4YQhoprvnmI5LPI91rYvVdiFt/Q
	 ffDgEXUUfevVEw0aSOYlawu235maNIrHlwjiIpz7XtXhZW4JZqcbc4JDAkVk7gVyex
	 Qq13KD97YkSTw==
From: cel@kernel.org
To: <stable@vger.kernel.org>
Cc: <linux-nfs@vger.kernel.org>,
	Petr Vorel <pvorel@suse.cz>,
	sherry.yang@oracle.com,
	calum.mackay@oracle.com,
	kernel-team@fb.com,
	Josef Bacik <josef@toxicpanda.com>,
	Jeff Layton <jlayton@kernel.org>
Subject: [PATCH 5.10.y 14/19] sunrpc: use the struct net as the svc proc private
Date: Thu,  5 Sep 2024 11:30:56 -0400
Message-ID: <20240905153101.59927-15-cel@kernel.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240905153101.59927-1-cel@kernel.org>
References: <20240905153101.59927-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Josef Bacik <josef@toxicpanda.com>

[ Upstream commit 418b9687dece5bd763c09b5c27a801a7e3387be9 ]

nfsd is the only thing using this helper, and it doesn't use the private
currently.  When we switch to per-network namespace stats we will need
the struct net * in order to get to the nfsd_net.  Use the net as the
proc private so we can utilize this when we make the switch over.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/stats.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sunrpc/stats.c b/net/sunrpc/stats.c
index c964b48eaaba..a004c3ef35c0 100644
--- a/net/sunrpc/stats.c
+++ b/net/sunrpc/stats.c
@@ -309,7 +309,7 @@ EXPORT_SYMBOL_GPL(rpc_proc_unregister);
 struct proc_dir_entry *
 svc_proc_register(struct net *net, struct svc_stat *statp, const struct proc_ops *proc_ops)
 {
-	return do_register(net, statp->program->pg_name, statp, proc_ops);
+	return do_register(net, statp->program->pg_name, net, proc_ops);
 }
 EXPORT_SYMBOL_GPL(svc_proc_register);
 
-- 
2.45.1


