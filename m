Return-Path: <linux-nfs+bounces-1397-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38E1A83C804
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jan 2024 17:29:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BDAA1C25230
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jan 2024 16:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2792D129A7F;
	Thu, 25 Jan 2024 16:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nl9cmo6U"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0474077F02
	for <linux-nfs@vger.kernel.org>; Thu, 25 Jan 2024 16:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706200185; cv=none; b=O5dCfLtGAKAhioBG0SUO40NRfcuhUbwB8NCZrOOX+fEG+Wlth6fWjJ+TlpqkjcvDQYHPQ4jmWcfqDSkKV5o1KgTmTU7CAPAa4qSmFjeFiu1/zkoTSURs+nhw82FUjKXbGKSIdAJV6fL9rXFgmzdrbkz3SflRnptAspkr1AEwx3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706200185; c=relaxed/simple;
	bh=xV/8d6un0tZ1MxJIl+otAu/VWHtxWRlLP0tqM9ypkAc=;
	h=Subject:From:To:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pF5zpJdXxEfkqM/cw8BiogRtPgiyE4SErW0K2JMEFmyuAcRLFOvGLZ+V0MHp90yu8WTne75nyarOWHkGJMlx8j25Gg1x7XmhjxOsSNq2VvAY1r6vKn4eHngzEZShfs6VRCzfLUIEQzOBJEAs8WZCYb8H2/yalBcJrA4OEbfvqy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nl9cmo6U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B35BCC433C7
	for <linux-nfs@vger.kernel.org>; Thu, 25 Jan 2024 16:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706200184;
	bh=xV/8d6un0tZ1MxJIl+otAu/VWHtxWRlLP0tqM9ypkAc=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=nl9cmo6Uqk8nKHHWHEj8WNV/y6hZPpcfUb1yquqZGCE0uaxBcIOD9fM58qaaT+Jqe
	 kW96J4oND5Zvtuq670JSVxn14tHPJq2H7upIu5lTwh6WxWK37HspHHNNHxwkZikT1G
	 jN/eW+MnyTNYvQ47F056veUvjVp+jQvDLoDJj+loGBpeACFVIryHjIMAfdh07+1JkS
	 WNIIwXB2c52uupSFRMbFsL5DTakhk/Ib4xp8Ttt6HnSfsPUXI7f39SeNltBNY+1kk/
	 bC9HBYec3Y7bf0RAMZPXoIG20jcPil2sjpm8IfmI6XiipZNwC3yfr76JHeMswiZ/Ke
	 9qdlHgHRPxzUQ==
Subject: [PATCH RFC 10/13] NFSD: Replace comment with lockdep assertion
From: Chuck Lever <cel@kernel.org>
To: linux-nfs@vger.kernel.org
Date: Thu, 25 Jan 2024 11:29:43 -0500
Message-ID: 
 <170620018365.2833.3114414936937483602.stgit@manet.1015granger.net>
In-Reply-To: 
 <170619984210.2833.7173004255003914651.stgit@manet.1015granger.net>
References: 
 <170619984210.2833.7173004255003914651.stgit@manet.1015granger.net>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Chuck Lever <chuck.lever@oracle.com>

Convert a code comment into a real assertion.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4callback.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index 1e0f5a0bd804..dc308569bc31 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -1307,12 +1307,13 @@ void nfsd4_shutdown_callback(struct nfs4_client *clp)
 	nfsd41_cb_inflight_wait_complete(clp);
 }
 
-/* requires cl_lock: */
 static struct nfsd4_conn * __nfsd4_find_backchannel(struct nfs4_client *clp)
 {
 	struct nfsd4_session *s;
 	struct nfsd4_conn *c;
 
+	lockdep_assert_held(&clp->cl_lock);
+
 	list_for_each_entry(s, &clp->cl_sessions, se_perclnt) {
 		list_for_each_entry(c, &s->se_conns, cn_persession) {
 			if (c->cn_flags & NFS4_CDFC4_BACK)



