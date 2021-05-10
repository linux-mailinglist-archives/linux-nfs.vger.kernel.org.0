Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E601F379311
	for <lists+linux-nfs@lfdr.de>; Mon, 10 May 2021 17:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbhEJPxK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 10 May 2021 11:53:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:43188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231492AbhEJPxI (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 10 May 2021 11:53:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 012636143C;
        Mon, 10 May 2021 15:52:02 +0000 (UTC)
Subject: [PATCH RFC 04/21] NFSD: Add cb_lost tracepoint
From:   Chuck Lever <chuck.lever@oracle.com>
To:     dwysocha@redhat.com, bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org
Date:   Mon, 10 May 2021 11:52:02 -0400
Message-ID: <162066192225.94415.5154454204479189279.stgit@klimt.1015granger.net>
In-Reply-To: <162066179690.94415.203187037032448300.stgit@klimt.1015granger.net>
References: <162066179690.94415.203187037032448300.stgit@klimt.1015granger.net>
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
index b517a8794400..4b2dc9d97cac 100644
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
index 9378a6ec4089..7577a4a46861 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -863,6 +863,7 @@ DEFINE_EVENT(nfsd_cb_class, nfsd_cb_##name,		\
 
 DEFINE_NFSD_CB_EVENT(setup);
 DEFINE_NFSD_CB_EVENT(state);
+DEFINE_NFSD_CB_EVENT(lost);
 DEFINE_NFSD_CB_EVENT(shutdown);
 
 TRACE_EVENT(nfsd_cb_setup_err,


