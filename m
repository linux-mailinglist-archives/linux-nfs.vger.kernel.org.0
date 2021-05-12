Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9594937CADD
	for <lists+linux-nfs@lfdr.de>; Wed, 12 May 2021 18:55:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237486AbhELQci (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 12 May 2021 12:32:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:36540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238999AbhELQHA (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 12 May 2021 12:07:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 48DB961D08;
        Wed, 12 May 2021 15:35:36 +0000 (UTC)
Subject: [PATCH v2 06/25] NFSD: Add nfsd_clid_confirmed tracepoint
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Cc:     dwysocha@redhat.com, bfields@fieldses.org, rostedt@goodmis.org
Date:   Wed, 12 May 2021 11:35:35 -0400
Message-ID: <162083373536.3108.8971756085153346664.stgit@klimt.1015granger.net>
In-Reply-To: <162083366966.3108.12581818416105328952.stgit@klimt.1015granger.net>
References: <162083366966.3108.12581818416105328952.stgit@klimt.1015granger.net>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This replaces a dprintk call site in order to get greater visibility
on when client IDs are confirmed or re-used. Simple example:

            nfsd-995   [000]   126.622975: nfsd_compound:        xid=0x3a34e2b1 opcnt=1
            nfsd-995   [000]   126.623005: nfsd_cb_args:         addr=192.168.2.51:45901 client 60958e3b:9213ef0e prog=1073741824 ident=1
            nfsd-995   [000]   126.623007: nfsd_compound_status: op=1/1 OP_SETCLIENTID status=0
            nfsd-996   [001]   126.623142: nfsd_compound:        xid=0x3b34e2b1 opcnt=1
  >>>>      nfsd-996   [001]   126.623146: nfsd_clid_confirmed:  client 60958e3b:9213ef0e
            nfsd-996   [001]   126.623148: nfsd_cb_probe:        addr=192.168.2.51:45901 client 60958e3b:9213ef0e state=UNKNOWN
            nfsd-996   [001]   126.623154: nfsd_compound_status: op=1/1 OP_SETCLIENTID_CONFIRM status=0

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4state.c |   10 +++++-----
 fs/nfsd/trace.h     |    1 +
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 69405cc9d823..37cef1f498e1 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -2816,14 +2816,14 @@ move_to_confirmed(struct nfs4_client *clp)
 
 	lockdep_assert_held(&nn->client_lock);
 
-	dprintk("NFSD: move_to_confirm nfs4_client %p\n", clp);
 	list_move(&clp->cl_idhash, &nn->conf_id_hashtbl[idhashval]);
 	rb_erase(&clp->cl_namenode, &nn->unconf_name_tree);
 	add_clp_to_name_tree(clp, &nn->conf_name_tree);
-	if (!test_and_set_bit(NFSD4_CLIENT_CONFIRMED, &clp->cl_flags) &&
-	    clp->cl_nfsd_dentry &&
-	    clp->cl_nfsd_info_dentry)
-		fsnotify_dentry(clp->cl_nfsd_info_dentry, FS_MODIFY);
+	if (!test_and_set_bit(NFSD4_CLIENT_CONFIRMED, &clp->cl_flags)) {
+		trace_nfsd_clid_confirmed(&clp->cl_clientid);
+		if (clp->cl_nfsd_dentry && clp->cl_nfsd_info_dentry)
+			fsnotify_dentry(clp->cl_nfsd_info_dentry, FS_MODIFY);
+	}
 	renew_client_locked(clp);
 }
 
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index b5bf792575d5..c0cf98f6da63 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -509,6 +509,7 @@ DEFINE_EVENT(nfsd_clientid_class, nfsd_clid_##name, \
 	TP_PROTO(const clientid_t *clid), \
 	TP_ARGS(clid))
 
+DEFINE_CLIENTID_EVENT(confirmed);
 DEFINE_CLIENTID_EVENT(expired);
 DEFINE_CLIENTID_EVENT(purged);
 DEFINE_CLIENTID_EVENT(renew);


