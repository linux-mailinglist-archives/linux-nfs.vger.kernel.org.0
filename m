Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92D69381142
	for <lists+linux-nfs@lfdr.de>; Fri, 14 May 2021 21:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233130AbhENT54 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 14 May 2021 15:57:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:57444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233033AbhENT54 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 14 May 2021 15:57:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7098C61285;
        Fri, 14 May 2021 19:56:44 +0000 (UTC)
Subject: [PATCH v3 15/24] NFSD: Add cb_lost tracepoint
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Cc:     dwysocha@redhat.com, bfields@fieldses.org
Date:   Fri, 14 May 2021 15:56:43 -0400
Message-ID: <162102220371.10915.4184457731193101246.stgit@klimt.1015granger.net>
In-Reply-To: <162102191240.10915.5003178983503027218.stgit@klimt.1015granger.net>
References: <162102191240.10915.5003178983503027218.stgit@klimt.1015granger.net>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Provide more clarity about when the callback channel is in trouble.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4state.c |    2 ++
 fs/nfsd/trace.h     |    1 +
 2 files changed, 3 insertions(+)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index aa645aeee7b6..377ec4a6a771 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1745,6 +1745,8 @@ static void nfsd4_conn_lost(struct svc_xpt_user *u)
 	struct nfsd4_conn *c = container_of(u, struct nfsd4_conn, cn_xpt_user);
 	struct nfs4_client *clp = c->cn_session->se_client;
 
+	trace_nfsd_cb_lost(clp);
+
 	spin_lock(&clp->cl_lock);
 	if (!list_empty(&c->cn_persession)) {
 		list_del(&c->cn_persession);
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index 1c43e6647d1e..336dc4c45416 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -912,6 +912,7 @@ DEFINE_EVENT(nfsd_cb_class, nfsd_cb_##name,		\
 
 DEFINE_NFSD_CB_EVENT(setup);
 DEFINE_NFSD_CB_EVENT(state);
+DEFINE_NFSD_CB_EVENT(lost);
 DEFINE_NFSD_CB_EVENT(shutdown);
 
 TRACE_DEFINE_ENUM(RPC_AUTH_NULL);


