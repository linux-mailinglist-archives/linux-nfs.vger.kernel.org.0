Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92410381144
	for <lists+linux-nfs@lfdr.de>; Fri, 14 May 2021 21:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233038AbhENT6C (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 14 May 2021 15:58:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:57468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233033AbhENT6C (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 14 May 2021 15:58:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 90C8E61285;
        Fri, 14 May 2021 19:56:50 +0000 (UTC)
Subject: [PATCH v3 16/24] NFSD: Adjust cb_shutdown tracepoint
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Cc:     dwysocha@redhat.com, bfields@fieldses.org
Date:   Fri, 14 May 2021 15:56:49 -0400
Message-ID: <162102220985.10915.14015767336113364759.stgit@klimt.1015granger.net>
In-Reply-To: <162102191240.10915.5003178983503027218.stgit@klimt.1015granger.net>
References: <162102191240.10915.5003178983503027218.stgit@klimt.1015granger.net>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Show when the upper layer requested a shutdown. RPC tracepoints can
already show when rpc_shutdown_client() is called.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4callback.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index b6cc51a9f37c..ab1836381e22 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -1233,6 +1233,9 @@ void nfsd4_destroy_callback_queue(void)
 /* must be called under the state lock */
 void nfsd4_shutdown_callback(struct nfs4_client *clp)
 {
+	if (clp->cl_cb_state != NFSD4_CB_UNKNOWN)
+		trace_nfsd_cb_shutdown(clp);
+
 	set_bit(NFSD4_CLIENT_CB_KILL, &clp->cl_flags);
 	/*
 	 * Note this won't actually result in a null callback;
@@ -1278,7 +1281,6 @@ static void nfsd4_process_cb_update(struct nfsd4_callback *cb)
 	 * kill the old client:
 	 */
 	if (clp->cl_cb_client) {
-		trace_nfsd_cb_shutdown(clp);
 		rpc_shutdown_client(clp->cl_cb_client);
 		clp->cl_cb_client = NULL;
 		put_cred(clp->cl_cb_cred);


