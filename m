Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F308567D09
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Jul 2022 06:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231386AbiGFEUA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 6 Jul 2022 00:20:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbiGFET7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 6 Jul 2022 00:19:59 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2B1A272C
        for <linux-nfs@vger.kernel.org>; Tue,  5 Jul 2022 21:19:57 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A712722106;
        Wed,  6 Jul 2022 04:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1657081196; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rzy6MFguVAbNkbOictP0ahE6dTKboejlODTLHzbykFg=;
        b=In2IdmxzSoWFmeYEsjjcJ033eyuV5/yj/RMG8eAxK5t0jouPtkj6cXOCT+8r9663VbWvK5
        lF8bliQnVLM9s04wPryGuzkA7kg8dJFIFwoN7ozfwezJIPFjdyB5IlLa3ImGENcwF0tz7F
        DaFYxKSVtyhXrDBukqz0O+SypMuxS2g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1657081196;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rzy6MFguVAbNkbOictP0ahE6dTKboejlODTLHzbykFg=;
        b=nsL5qit9MJCukqMN8JafajH5m76P/OPuX+Xfnnym//Pn4sfFzZlCK3sHeEUd/k6+tJOxgI
        8oew3nRyy0/bbHCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 82A4713A37;
        Wed,  6 Jul 2022 04:19:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ASsLD2sNxWKdQQAAMHmgww
        (envelope-from <neilb@suse.de>); Wed, 06 Jul 2022 04:19:55 +0000
Subject: [PATCH 1/8] NFSD: drop rqstp arg to do_set_nfs4_acl()
From:   NeilBrown <neilb@suse.de>
To:     Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     linux-nfs@vger.kernel.org
Date:   Wed, 06 Jul 2022 14:18:12 +1000
Message-ID: <165708109255.1940.15894552631928142042.stgit@noble.brown>
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

do_set_nfs4_acl() only needs rqstp to pass to nfsd4_set_nfs4_acl()

The latter only needs the rqstp to pass to fh_verify().

In every case that do_set_nfs4_acl() is called, fh_verify() is not
needed.  It is only needed for filehandles received from the client, the
filehandles passed to do_set_nfs4_acl() have just been constructed by
the server, and so must be valid.

So we can change nfsd4_set_nfs4_acl() to only call fh_verify() is rqstp
is not NULL, and always pass NULL from do_set_nfs4_acl().

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/nfs4acl.c  |   12 +++++++-----
 fs/nfsd/nfs4proc.c |    9 ++++-----
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/fs/nfsd/nfs4acl.c b/fs/nfsd/nfs4acl.c
index eaa3a0cf38f1..5c9b7e01e8ca 100644
--- a/fs/nfsd/nfs4acl.c
+++ b/fs/nfsd/nfs4acl.c
@@ -753,7 +753,7 @@ static int nfs4_acl_nfsv4_to_posix(struct nfs4_acl *acl,
 
 __be32
 nfsd4_set_nfs4_acl(struct svc_rqst *rqstp, struct svc_fh *fhp,
-		struct nfs4_acl *acl)
+		   struct nfs4_acl *acl)
 {
 	__be32 error;
 	int host_error;
@@ -762,10 +762,12 @@ nfsd4_set_nfs4_acl(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	struct posix_acl *pacl = NULL, *dpacl = NULL;
 	unsigned int flags = 0;
 
-	/* Get inode */
-	error = fh_verify(rqstp, fhp, 0, NFSD_MAY_SATTR);
-	if (error)
-		return error;
+	if (rqstp) {
+		/* Get inode */
+		error = fh_verify(rqstp, fhp, 0, NFSD_MAY_SATTR);
+		if (error)
+			return error;
+	}
 
 	dentry = fhp->fh_dentry;
 	inode = d_inode(dentry);
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 5af9f8d1feb6..60591ceb4985 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -163,12 +163,11 @@ is_create_with_attrs(struct nfsd4_open *open)
  * in the returned attr bitmap.
  */
 static void
-do_set_nfs4_acl(struct svc_rqst *rqstp, struct svc_fh *fhp,
-		struct nfs4_acl *acl, u32 *bmval)
+do_set_nfs4_acl(struct svc_fh *fhp, struct nfs4_acl *acl, u32 *bmval)
 {
 	__be32 status;
 
-	status = nfsd4_set_nfs4_acl(rqstp, fhp, acl);
+	status = nfsd4_set_nfs4_acl(NULL, fhp, acl);
 	if (status)
 		/*
 		 * We should probably fail the whole open at this point,
@@ -474,7 +473,7 @@ do_open_lookup(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate, stru
 		goto out;
 
 	if (is_create_with_attrs(open) && open->op_acl != NULL)
-		do_set_nfs4_acl(rqstp, *resfh, open->op_acl, open->op_bmval);
+		do_set_nfs4_acl(*resfh, open->op_acl, open->op_bmval);
 
 	nfsd4_set_open_owner_reply_cache(cstate, open, *resfh);
 	accmode = NFSD_MAY_NOP;
@@ -861,7 +860,7 @@ nfsd4_create(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		nfsd4_security_inode_setsecctx(&resfh, &create->cr_label, create->cr_bmval);
 
 	if (create->cr_acl != NULL)
-		do_set_nfs4_acl(rqstp, &resfh, create->cr_acl,
+		do_set_nfs4_acl(&resfh, create->cr_acl,
 				create->cr_bmval);
 
 	fh_unlock(&cstate->current_fh);


