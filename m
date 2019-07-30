Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 993DA7B618
	for <lists+linux-nfs@lfdr.de>; Wed, 31 Jul 2019 01:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbfG3XI4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 30 Jul 2019 19:08:56 -0400
Received: from fieldses.org ([173.255.197.46]:41940 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726704AbfG3XI4 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 30 Jul 2019 19:08:56 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 15EF61C26; Tue, 30 Jul 2019 19:08:56 -0400 (EDT)
Date:   Tue, 30 Jul 2019 19:08:56 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Jia-Ju Bai <baijiaju1990@gmail.com>
Cc:     chuck.lever@oracle.com, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: nfsd: Fix three possible null-pointer dereferences
Message-ID: <20190730230856.GE3544@fieldses.org>
References: <20190724082803.1077-1-baijiaju1990@gmail.com>
 <20190730230339.GD3544@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190730230339.GD3544@fieldses.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Jul 30, 2019 at 07:03:39PM -0400, J. Bruce Fields wrote:
> Thanks!  But I think actually the correct fix is just to remove the NULL
> checks entirely.

So, something like the following (untested).--b.

commit 7ce38d2d8a66
Author: J. Bruce Fields <bfields@redhat.com>
Date:   Tue Jul 30 19:06:38 2019 -0400

    nfsd: Remove unnecessary NULL checks
    
    "cb" is never actually NULL in these functions.
    
    On a quick skim of the history, they seem to have been there from the
    beginning.  I'm not sure if they originally served a purpose.
    
    Reported-by: Jia-Ju Bai <baijiaju1990@gmail.com>
    Signed-off-by: J. Bruce Fields <bfields@redhat.com>

diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index 397eb7820929..524111420b48 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -512,11 +512,9 @@ static int nfs4_xdr_dec_cb_recall(struct rpc_rqst *rqstp,
 	if (unlikely(status))
 		return status;
 
-	if (cb != NULL) {
-		status = decode_cb_sequence4res(xdr, cb);
-		if (unlikely(status || cb->cb_seq_status))
-			return status;
-	}
+	status = decode_cb_sequence4res(xdr, cb);
+	if (unlikely(status || cb->cb_seq_status))
+		return status;
 
 	return decode_cb_op_status(xdr, OP_CB_RECALL, &cb->cb_status);
 }
@@ -604,11 +602,10 @@ static int nfs4_xdr_dec_cb_layout(struct rpc_rqst *rqstp,
 	if (unlikely(status))
 		return status;
 
-	if (cb) {
-		status = decode_cb_sequence4res(xdr, cb);
-		if (unlikely(status || cb->cb_seq_status))
-			return status;
-	}
+	status = decode_cb_sequence4res(xdr, cb);
+	if (unlikely(status || cb->cb_seq_status))
+		return status;
+
 	return decode_cb_op_status(xdr, OP_CB_LAYOUTRECALL, &cb->cb_status);
 }
 #endif /* CONFIG_NFSD_PNFS */
@@ -663,11 +660,10 @@ static int nfs4_xdr_dec_cb_notify_lock(struct rpc_rqst *rqstp,
 	if (unlikely(status))
 		return status;
 
-	if (cb) {
-		status = decode_cb_sequence4res(xdr, cb);
-		if (unlikely(status || cb->cb_seq_status))
-			return status;
-	}
+	status = decode_cb_sequence4res(xdr, cb);
+	if (unlikely(status || cb->cb_seq_status))
+		return status;
+
 	return decode_cb_op_status(xdr, OP_CB_NOTIFY_LOCK, &cb->cb_status);
 }
 
@@ -759,11 +755,10 @@ static int nfs4_xdr_dec_cb_offload(struct rpc_rqst *rqstp,
 	if (unlikely(status))
 		return status;
 
-	if (cb) {
-		status = decode_cb_sequence4res(xdr, cb);
-		if (unlikely(status || cb->cb_seq_status))
-			return status;
-	}
+	status = decode_cb_sequence4res(xdr, cb);
+	if (unlikely(status || cb->cb_seq_status))
+		return status;
+
 	return decode_cb_op_status(xdr, OP_CB_OFFLOAD, &cb->cb_status);
 }
 /*
