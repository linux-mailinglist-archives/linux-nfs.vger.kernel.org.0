Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6E5F567D11
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Jul 2022 06:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231349AbiGFEUs (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 6 Jul 2022 00:20:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbiGFEUr (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 6 Jul 2022 00:20:47 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D25921838E
        for <linux-nfs@vger.kernel.org>; Tue,  5 Jul 2022 21:20:46 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 84ACC22849;
        Wed,  6 Jul 2022 04:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1657081245; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w7LQxZ6st6gsPWv1TDn+iaNfRHm08fMBBxCDWaA9wrE=;
        b=F6A2QvJ7XvYoc8co6F7BhNSO2xXdBaFnpi6ekoiLRg7M1WMvVHNF19gYvCj2yzfrJV7yyP
        7bnowXPmsqkZcyj6j2ayb4rQclQY6MfDmM3kkikqY3XMZR40cM9l6nL/XG1G51h+HOHnVC
        0Qrglm0FaJKyeZLBD4/5j37QBRxVMWs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1657081245;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w7LQxZ6st6gsPWv1TDn+iaNfRHm08fMBBxCDWaA9wrE=;
        b=ZHtR5xZIlGqsE+jMJeUBnupClZc1vB82zpemIYzpAMVX2hhqG/RoOkCuM0UqYjgyXBsbRm
        YqXJAaa/WVjiCXCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 67E4513A37;
        Wed,  6 Jul 2022 04:20:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0IgWCZwNxWLvQQAAMHmgww
        (envelope-from <neilb@suse.de>); Wed, 06 Jul 2022 04:20:44 +0000
Subject: [PATCH 4/8] NFSD: only call fh_unlock() once in nfsd_link()
From:   NeilBrown <neilb@suse.de>
To:     Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     linux-nfs@vger.kernel.org
Date:   Wed, 06 Jul 2022 14:18:12 +1000
Message-ID: <165708109258.1940.6581517569232462503.stgit@noble.brown>
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

On non-error paths, nfsd_link() calls fh_unlock() twice.  This is safe
because fh_unlock() records that the unlock has been done and doesn't
repeat it.
However it makes the code a little confusing and interferes with changes
that are planned for directory locking.

So rearrange the code to ensure fh_unlock() is called exactly once if
fh_lock() was called.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/vfs.c |   18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 3f4579f5775c..4916c29af0fa 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1551,8 +1551,10 @@ nfsd_link(struct svc_rqst *rqstp, struct svc_fh *ffhp,
 
 	dnew = lookup_one_len(name, ddir, len);
 	host_err = PTR_ERR(dnew);
-	if (IS_ERR(dnew))
-		goto out_nfserr;
+	if (IS_ERR(dnew)) {
+		err = nfserrno(host_err);
+		goto out_unlock;
+	}
 
 	dold = tfhp->fh_dentry;
 
@@ -1571,17 +1573,17 @@ nfsd_link(struct svc_rqst *rqstp, struct svc_fh *ffhp,
 		else
 			err = nfserrno(host_err);
 	}
-out_dput:
 	dput(dnew);
-out_unlock:
-	fh_unlock(ffhp);
+out_drop_write:
 	fh_drop_write(tfhp);
 out:
 	return err;
 
-out_nfserr:
-	err = nfserrno(host_err);
-	goto out_unlock;
+out_dput:
+	dput(dnew);
+out_unlock:
+	fh_unlock(ffhp);
+	goto out_drop_write;
 }
 
 static void


