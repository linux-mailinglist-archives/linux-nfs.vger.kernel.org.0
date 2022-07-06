Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA6F567D18
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Jul 2022 06:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231592AbiGFEUP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 6 Jul 2022 00:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbiGFEUN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 6 Jul 2022 00:20:13 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B825B272C
        for <linux-nfs@vger.kernel.org>; Tue,  5 Jul 2022 21:20:12 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7B07C1F8B6;
        Wed,  6 Jul 2022 04:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1657081211; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V0ONAXNcsuNCM3u/6sv99D1JZhgOVP6Sd2g1CyRBucw=;
        b=Tb2G10wlMKonC3BsUuq9kRysePDfoocgrAok3mxud6aXt7hxcQTu6sSAUWEG+rT5t/8JjR
        oYrx7fmNKjuq+cv+XWiAa1YYXQLLUQ+j0v5JCY287HhtEUl3YZ7RKAFJHYCJXZfRJ/KwEa
        dpefM2sAXOzdqLpUceCoqy1HSuoU0I0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1657081211;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V0ONAXNcsuNCM3u/6sv99D1JZhgOVP6Sd2g1CyRBucw=;
        b=LKkwdYqCC9939Q+zji4oDzr1r5J4sDrU03FYYIpbpW4FnNv2k4QWsGK4VAssNeQLDhipw/
        YCY7uOv85hmC3wAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A923213A37;
        Wed,  6 Jul 2022 04:20:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qvVGGXcNxWK2QQAAMHmgww
        (envelope-from <neilb@suse.de>); Wed, 06 Jul 2022 04:20:07 +0000
Subject: [PATCH 3/8] NFSD: always drop directory lock in nfsd_unlink()
From:   NeilBrown <neilb@suse.de>
To:     Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     linux-nfs@vger.kernel.org
Date:   Wed, 06 Jul 2022 14:18:12 +1000
Message-ID: <165708109257.1940.5635801592688577227.stgit@noble.brown>
In-Reply-To: <165708033167.1940.3364591321728458949.stgit@noble.brown>
References: <165708033167.1940.3364591321728458949.stgit@noble.brown>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/nfs3proc.c |    2 --
 fs/nfsd/nfs4proc.c |    4 +---
 fs/nfsd/vfs.c      |    7 +++++--
 3 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
index 38255365ef71..ad7941001106 100644
--- a/fs/nfsd/nfs3proc.c
+++ b/fs/nfsd/nfs3proc.c
@@ -478,7 +478,6 @@ nfsd3_proc_remove(struct svc_rqst *rqstp)
 	fh_copy(&resp->fh, &argp->fh);
 	resp->status = nfsd_unlink(rqstp, &resp->fh, -S_IFDIR,
 				   argp->name, argp->len);
-	fh_unlock(&resp->fh);
 	return rpc_success;
 }
 
@@ -499,7 +498,6 @@ nfsd3_proc_rmdir(struct svc_rqst *rqstp)
 	fh_copy(&resp->fh, &argp->fh);
 	resp->status = nfsd_unlink(rqstp, &resp->fh, S_IFDIR,
 				   argp->name, argp->len);
-	fh_unlock(&resp->fh);
 	return rpc_success;
 }
 
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 3279daab909d..4737019738ab 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1052,10 +1052,8 @@ nfsd4_remove(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
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
index 1e7ca39e8a49..3f4579f5775c 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1762,12 +1762,12 @@ nfsd_unlink(struct svc_rqst *rqstp, struct svc_fh *fhp, int type,
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
@@ -1805,6 +1805,9 @@ nfsd_unlink(struct svc_rqst *rqstp, struct svc_fh *fhp, int type,
 	}
 out:
 	return err;
+out_unlock:
+	fh_unlock(fhp);
+	goto out_drop_write;
 }
 
 /*


