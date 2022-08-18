Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33C71599183
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Aug 2022 01:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245567AbiHRX4L (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 18 Aug 2022 19:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245194AbiHRX4K (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 18 Aug 2022 19:56:10 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5863D59AF
        for <linux-nfs@vger.kernel.org>; Thu, 18 Aug 2022 16:56:09 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 50C375C61A;
        Thu, 18 Aug 2022 23:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1660866968; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=iBCYri3e9f7zjcp8EM0SAGJXg78ya19Wqan/T6oe5Aw=;
        b=KdFWN2PYJyGJ58LEiMV64akTs6MzjG334yZjnuZhuSzxrnDW5Z7lmRmuToKmhiaujUK08b
        8pZMD/Z+epbQup9G6Ja2SpJC+Yaqto4h5LYLgsEfEDFypcLlrCyoUsjOMgg0RfPq3RpTXb
        T+r8SVgKOTZ0RmcnwdA1xe2Fs7sD76Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1660866968;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=iBCYri3e9f7zjcp8EM0SAGJXg78ya19Wqan/T6oe5Aw=;
        b=e6PCd0zqA3CJ3U2Dyka5MmIAVTNsJRghXx6PllyIJwoXwuDVT/d/V+BVTLgexPEiJzl3Jv
        aSnO6OrdWPACV5Dg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E6511133D1;
        Thu, 18 Aug 2022 23:56:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id DOL4J5bR/mJhQwAAMHmgww
        (envelope-from <neilb@suse.de>); Thu, 18 Aug 2022 23:56:06 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>
Cc:     Olga Kornievskaia <aglo@umich.edu>, hooanon05g@gmail.com,
        linux-nfs <linux-nfs@vger.kernel.org>
Subject: [PATCH v2] NFS: unlink/rmdir shouldn't call d_delete() twice on ENOENT
Date:   Fri, 19 Aug 2022 09:55:59 +1000
Message-id: <166086695960.5425.17748020864798390841@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


nfs_unlink() calls d_delete() twice if it receives ENOENT from the
server - once in nfs_dentry_handle_enoent() from nfs_safe_remove and
once in nfs_dentry_remove_handle_error().

nfs_rmddir() also calls it twice - the nfs_dentry_handle_enoent() call
is direct and inside a region locked with ->rmdir_sem

It is safe to call d_delete() twice if the refcount > 1 as the dentry is
simply unhashed.
If the refcount is 1, the first call sets d_inode to NULL and the second
call crashes.

This patch guards the d_delete() call from nfs_dentry_handle_enoent()
leaving the one under ->remdir_sem in case that is important.

In mainline it would be safe to remove the d_delete() call.  However in
older kernels to which this might be backported, that would change the
behaviour of nfs_unlink().  nfs_unlink() used to unhash the dentry which
resulted in nfs_dentry_handle_enoent() not calling d_delete().  So in
older kernels we need the d_delete() in nfs_dentry_remove_handle_error()
when called from nfs_unlink() but not when called from nfs_rmdir().

To make the code work correctly for old and new kernels, and from both
nfs_unlink() and nfs_rmdir(), we protect the d_delete() call with
simple_positive().  This ensures it is never called in a circumstance
where it could crash.

Fixes: 3c59366c207e ("NFS: don't unhash dentry during unlink/rename")
Fixes: 9019fb391de0 ("NFS: Label the dentry with a verifier in nfs_rmdir() an=
d nfs_unlink()")
Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfs/dir.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index dbab3caa15ed..8f26f848818d 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -2382,7 +2382,8 @@ static void nfs_dentry_remove_handle_error(struct inode=
 *dir,
 {
 	switch (error) {
 	case -ENOENT:
-		d_delete(dentry);
+		if (d_really_is_positive(dentry))
+			d_delete(dentry);
 		nfs_set_verifier(dentry, nfs_save_change_attribute(dir));
 		break;
 	case 0:
--=20
2.37.1

