Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B3D737931A
	for <lists+linux-nfs@lfdr.de>; Mon, 10 May 2021 17:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbhEJPxv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 10 May 2021 11:53:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:43792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230506AbhEJPxv (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 10 May 2021 11:53:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2ECC4615FF;
        Mon, 10 May 2021 15:52:46 +0000 (UTC)
Subject: [PATCH RFC 11/21] NFSD: Add an nfsd_cb_probe tracepoint
From:   Chuck Lever <chuck.lever@oracle.com>
To:     dwysocha@redhat.com, bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org
Date:   Mon, 10 May 2021 11:52:45 -0400
Message-ID: <162066196546.94415.3502942815930876277.stgit@klimt.1015granger.net>
In-Reply-To: <162066179690.94415.203187037032448300.stgit@klimt.1015granger.net>
References: <162066179690.94415.203187037032448300.stgit@klimt.1015granger.net>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Record a tracepoint event when the server performs a callback
probe. This event can be enabled as a group with other nfsd_cb
tracepoints.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4callback.c |    1 +
 fs/nfsd/trace.h        |    1 +
 2 files changed, 2 insertions(+)

diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index c2a2a58b3581..ddab969d7865 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -998,6 +998,7 @@ static const struct rpc_call_ops nfsd4_cb_probe_ops = {
  */
 void nfsd4_probe_callback(struct nfs4_client *clp)
 {
+	trace_nfsd_cb_probe(clp);
 	nfsd4_mark_cb_state(clp, NFSD4_CB_UNKNOWN);
 	set_bit(NFSD4_CLIENT_CB_UPDATE, &clp->cl_flags);
 	nfsd4_run_cb(&clp->cl_cb_null);
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index 13ab373aaa75..0845116cbe3f 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -861,6 +861,7 @@ DEFINE_EVENT(nfsd_cb_class, nfsd_cb_##name,		\
 	TP_ARGS(clp))
 
 DEFINE_NFSD_CB_EVENT(state);
+DEFINE_NFSD_CB_EVENT(probe);
 DEFINE_NFSD_CB_EVENT(lost);
 DEFINE_NFSD_CB_EVENT(shutdown);
 


