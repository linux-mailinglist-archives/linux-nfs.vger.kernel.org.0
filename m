Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B1BE37CAF3
	for <lists+linux-nfs@lfdr.de>; Wed, 12 May 2021 18:55:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239091AbhELQdH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 12 May 2021 12:33:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:36524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239175AbhELQHd (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 12 May 2021 12:07:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8DCFA61440;
        Wed, 12 May 2021 15:36:41 +0000 (UTC)
Subject: [PATCH v2 16/25] NFSD: Add cb_lost tracepoint
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Cc:     dwysocha@redhat.com, bfields@fieldses.org, rostedt@goodmis.org
Date:   Wed, 12 May 2021 11:36:40 -0400
Message-ID: <162083380066.3108.961893037484895767.stgit@klimt.1015granger.net>
In-Reply-To: <162083366966.3108.12581818416105328952.stgit@klimt.1015granger.net>
References: <162083366966.3108.12581818416105328952.stgit@klimt.1015granger.net>
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
index ad0139b6df15..79d504f461e6 100644
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
index 6afeda8652b3..bd683523b052 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -909,6 +909,7 @@ DEFINE_EVENT(nfsd_cb_class, nfsd_cb_##name,		\
 
 DEFINE_NFSD_CB_EVENT(setup);
 DEFINE_NFSD_CB_EVENT(state);
+DEFINE_NFSD_CB_EVENT(lost);
 DEFINE_NFSD_CB_EVENT(shutdown);
 
 TRACE_DEFINE_ENUM(RPC_AUTH_NULL);


