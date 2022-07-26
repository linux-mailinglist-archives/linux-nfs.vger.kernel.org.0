Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F21C9580BE8
	for <lists+linux-nfs@lfdr.de>; Tue, 26 Jul 2022 08:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234878AbiGZGsj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 26 Jul 2022 02:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237774AbiGZGsh (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 26 Jul 2022 02:48:37 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A24F21802
        for <linux-nfs@vger.kernel.org>; Mon, 25 Jul 2022 23:48:35 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 582A41F9CE;
        Tue, 26 Jul 2022 06:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1658818114; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YsTVe8Y+2Q+DxS/8ApTCzzBvg9zIqfRAIYUjeHzZYzc=;
        b=QGpzhLCdQ9EvVJE3ZIEf9OCwUlD8nlfQMOGJGrbHYfpbsHj8BoWdYhlfwQZpzlHHSdfwUu
        mv8CQPo0ayFWpo4/2+qwionrTfkXypWYk6iVUAKFYLF2hjLe0jNAMHzg4bMP1pUMCFTy1E
        VnyZfjQDmR20mMLHoNl+37eItWk/1qA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1658818114;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YsTVe8Y+2Q+DxS/8ApTCzzBvg9zIqfRAIYUjeHzZYzc=;
        b=6dohU2xWrdjqmgiHYxdSh7wc4Pp7m2LUBjHVNzjF+mSgkDfQvyOeyupRDVyCWa626Gx1aQ
        mTaz3SJSnHgUAfDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4BBBB13A7C;
        Tue, 26 Jul 2022 06:48:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id PQgjA0GO32LkWAAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 26 Jul 2022 06:48:33 +0000
Subject: [PATCH 08/13] NFSD: always drop directory lock in nfsd_unlink()
From:   NeilBrown <neilb@suse.de>
To:     Chuck Lever III <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Date:   Tue, 26 Jul 2022 16:45:30 +1000
Message-ID: <165881793058.21666.12825902860406411178.stgit@noble.brown>
In-Reply-To: <165881740958.21666.5904057696047278505.stgit@noble.brown>
References: <165881740958.21666.5904057696047278505.stgit@noble.brown>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Some error paths in nfsd_unlink() allow it to exit without unlocking the
directory.  This is not a problem in practice as the directory will be
locked with an fh_put(), but it is untidy and potentially confusing.

This allows us to remove all the fh_unlock() calls that are immediately
after nfsd_unlink() calls.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/nfs3proc.c |    2 --
 fs/nfsd/nfs4proc.c |    4 +---
 fs/nfsd/vfs.c      |    7 +++++--
 3 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
index 0060a89997d4..774e4a2ab9b1 100644
--- a/fs/nfsd/nfs3proc.c
+++ b/fs/nfsd/nfs3proc.c
@@ -480,7 +480,6 @@ nfsd3_proc_remove(struct svc_rqst *rqstp)
 	fh_copy(&resp->fh, &argp->fh);
 	resp->status = nfsd_unlink(rqstp, &resp->fh, -S_IFDIR,
 				   argp->name, argp->len);
-	fh_unlock(&resp->fh);
 	return rpc_success;
 }
 
@@ -501,7 +500,6 @@ nfsd3_proc_rmdir(struct svc_rqst *rqstp)
 	fh_copy(&resp->fh, &argp->fh);
 	resp->status = nfsd_unlink(rqstp, &resp->fh, S_IFDIR,
 				   argp->name, argp->len);
-	fh_unlock(&resp->fh);
 	return rpc_success;
 }
 
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 915c9457a571..1aa6ae4ec2f5 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1002,10 +1002,8 @@ nfsd4_remove(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		return nfserr_grace;
 	status = nfsd_unlink(rqstp, &cstate->current_fh, 0,
 			     remove->rm_name, remove->rm_namelen);
-	if (!status) {
-		fh_unlock(&cstate->current_fh);
+	if (!status)
 		set_change_info(&remove->rm_cinfo, &cstate->current_fh);
-	}
 	return status;
 }
 
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 877331fabae0..f15ceed6d184 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1742,12 +1742,12 @@ nfsd_unlink(struct svc_rqst *rqstp, struct svc_fh *fhp, int type,
 	rdentry = lookup_one_len(fname, dentry, flen);
 	host_err = PTR_ERR(rdentry);
 	if (IS_ERR(rdentry))
-		goto out_drop_write;
+		goto out_unlock;
 
 	if (d_really_is_negative(rdentry)) {
 		dput(rdentry);
 		host_err = -ENOENT;
-		goto out_drop_write;
+		goto out_unlock;
 	}
 	rinode = d_inode(rdentry);
 	ihold(rinode);
@@ -1785,6 +1785,9 @@ nfsd_unlink(struct svc_rqst *rqstp, struct svc_fh *fhp, int type,
 	}
 out:
 	return err;
+out_unlock:
+	fh_unlock(fhp);
+	goto out_drop_write;
 }
 
 /*


