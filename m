Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A8F15835C3
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Jul 2022 01:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbiG0XsG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 27 Jul 2022 19:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiG0XsG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 27 Jul 2022 19:48:06 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 486ED4F6AB
        for <linux-nfs@vger.kernel.org>; Wed, 27 Jul 2022 16:48:05 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E4A643F5D1;
        Wed, 27 Jul 2022 23:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1658965683; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sn3TUB6HvjdKp4vGX4Wvv53abnu6cEQwgjHf2LN/Anw=;
        b=Nmw98/ov7vn+r5lylEDZs1FqxccGSvfUVgfUkOFcbHdMOtkVnQBMAgaCNrekToBVDSKUJL
        cLSc0Zy3AkzHsuL9ku3c4MmpI2ou3lwHFhmtkElElJV1k1UDvzZdZFkZMs+uHG82pG0Ws1
        +DQQawohk0G2xAtFHHCooiOJxi2zrnw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1658965683;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sn3TUB6HvjdKp4vGX4Wvv53abnu6cEQwgjHf2LN/Anw=;
        b=GDjQxcvhtsQ3wJcGue2t+3FrSRRvCMUaMINT9en7lyANqZmGBYgAPQTR43QM6vK804EYDa
        IT0oRAHBcipjqWAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D2F2B13A8E;
        Wed, 27 Jul 2022 23:48:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Ff8GJLLO4WJKHQAAMHmgww
        (envelope-from <neilb@suse.de>); Wed, 27 Jul 2022 23:48:02 +0000
Subject: [PATCH 09/13] NFSD: only call fh_unlock() once in nfsd_link()
From:   NeilBrown <neilb@suse.de>
To:     Chuck Lever III <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Date:   Tue, 26 Jul 2022 16:45:30 +1000
Message-ID: <165881793058.21666.4980994664396091336.stgit@noble.brown>
In-Reply-To: <165881740958.21666.5904057696047278505.stgit@noble.brown>
References: <165881740958.21666.5904057696047278505.stgit@noble.brown>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DATE_IN_PAST_24_48,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
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

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/vfs.c |   19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index f15ceed6d184..06b1408db08b 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1530,9 +1530,10 @@ nfsd_link(struct svc_rqst *rqstp, struct svc_fh *ffhp,
 	dirp = d_inode(ddir);
 
 	dnew = lookup_one_len(name, ddir, len);
-	host_err = PTR_ERR(dnew);
-	if (IS_ERR(dnew))
-		goto out_nfserr;
+	if (IS_ERR(dnew)) {
+		err = nfserrno(PTR_ERR(dnew));
+		goto out_unlock;
+	}
 
 	dold = tfhp->fh_dentry;
 
@@ -1551,17 +1552,17 @@ nfsd_link(struct svc_rqst *rqstp, struct svc_fh *ffhp,
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


