Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9660E130EF
	for <lists+linux-nfs@lfdr.de>; Fri,  3 May 2019 17:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728239AbfECPKW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 3 May 2019 11:10:22 -0400
Received: from fieldses.org ([173.255.197.46]:54352 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726514AbfECPKW (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 3 May 2019 11:10:22 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id E8E611CC9; Fri,  3 May 2019 11:10:21 -0400 (EDT)
Date:   Fri, 3 May 2019 11:10:21 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Scott Mayhew <smayhew@redhat.com>
Cc:     jlayton@kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH] nfsd: update callback done processing
Message-ID: <20190503151021.GF12608@fieldses.org>
References: <20190502173212.9530-1-smayhew@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190502173212.9530-1-smayhew@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Thanks, looks good!  Added one more paragraph with what you'd originally
seen (see below), and applied for 5.2.

I haven't added a stable cc, since I didn't think you'd established that
this in itself was causing a major problem--tell me if I'm wrong.

--b.

commit 1c73b9d24f80
Author: Scott Mayhew <smayhew@redhat.com>
Date:   Thu May 2 13:32:12 2019 -0400

    nfsd: update callback done processing
    
    Instead of having the convention where individual nfsd4_callback_ops->done
    operations return -1 to indicate the callback path is down, move the check
    to nfsd4_cb_done.  Only mark the callback path down on transport-level
    errors, not NFS-level errors.
    
    The existing logic causes the server to set SEQ4_STATUS_CB_PATH_DOWN
    just because the client returned an error to a CB_RECALL for a
    delegation that the client had already done a FREE_STATEID for.  But
    clearly that error doesn't mean that there's anything wrong with the
    backchannel.
    
    Additionally, handle NFS4ERR_DELAY in nfsd4_cb_recall_done.  The client
    returns NFS4ERR_DELAY if it is already in the process of returning the
    delegation.
    
    Signed-off-by: Scott Mayhew <smayhew@redhat.com>
    Signed-off-by: J. Bruce Fields <bfields@redhat.com>

diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index 7caa3801ce72..b9cbd7189d74 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -1122,10 +1122,11 @@ static void nfsd4_cb_done(struct rpc_task *task, void *calldata)
 		rpc_restart_call_prepare(task);
 		return;
 	case 1:
-		break;
-	case -1:
-		/* Network partition? */
-		nfsd4_mark_cb_down(clp, task->tk_status);
+		switch (task->tk_status) {
+		case -EIO:
+		case -ETIMEDOUT:
+			nfsd4_mark_cb_down(clp, task->tk_status);
+		}
 		break;
 	default:
 		BUG();
diff --git a/fs/nfsd/nfs4layouts.c b/fs/nfsd/nfs4layouts.c
index 44517fb5c0de..a79e24b79095 100644
--- a/fs/nfsd/nfs4layouts.c
+++ b/fs/nfsd/nfs4layouts.c
@@ -693,7 +693,7 @@ nfsd4_cb_layout_done(struct nfsd4_callback *cb, struct rpc_task *task)
 			ops->fence_client(ls);
 		else
 			nfsd4_cb_layout_fail(ls);
-		return -1;
+		return 1;
 	case -NFS4ERR_NOMATCHING_LAYOUT:
 		trace_nfsd_layout_recall_done(&ls->ls_stid.sc_stateid);
 		task->tk_status = 0;
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 8078314981f5..dfe4b596c2e5 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -3970,6 +3970,9 @@ static int nfsd4_cb_recall_done(struct nfsd4_callback *cb,
 	switch (task->tk_status) {
 	case 0:
 		return 1;
+	case -NFS4ERR_DELAY:
+		rpc_delay(task, 2 * HZ);
+		return 0;
 	case -EBADHANDLE:
 	case -NFS4ERR_BAD_STATEID:
 		/*
@@ -3982,7 +3985,7 @@ static int nfsd4_cb_recall_done(struct nfsd4_callback *cb,
 		}
 		/*FALLTHRU*/
 	default:
-		return -1;
+		return 1;
 	}
 }
 
