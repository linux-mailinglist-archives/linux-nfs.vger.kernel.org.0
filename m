Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5B9C5954A0
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Aug 2022 10:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbiHPILH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 16 Aug 2022 04:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232002AbiHPIKQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 16 Aug 2022 04:10:16 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C7FD9FF7
        for <linux-nfs@vger.kernel.org>; Mon, 15 Aug 2022 23:35:40 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A7398382AF;
        Tue, 16 Aug 2022 06:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1660631738; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=sSiUS2bJ8VKWddLfrmXez5xX6dRLY9R5d2Y5iVN7zbc=;
        b=nTrGijRMwkax3ZiCHE5Ztmwy7+jteGftHdtrutrYEc7BbDWqooeB8NSjYIQlpjXN3JMxIM
        2oGk3vpmawOoU8ON1sC97TQ8m9zaQ4TOLvf07ENa3YYxHXGJT+pJ0W3m7Mwl8efPpNOY+K
        06NLwu+SpUNy01hUo8/1lWjUDRkBXsw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1660631738;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=sSiUS2bJ8VKWddLfrmXez5xX6dRLY9R5d2Y5iVN7zbc=;
        b=00AIlWzSK9vCsdFkxY9dmb4tdBSqKp3ncCeVfVknem4RpCu3KoxoWgZ5bIRa1gu9ZCPHUV
        oe4/twLHgrcfAPBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8B169139B7;
        Tue, 16 Aug 2022 06:35:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +ploEbk6+2LoMAAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 16 Aug 2022 06:35:37 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: [PATCH] NFS: unlink/rmdir shouldn't call d_delete() twice on ENOENT
Date:   Tue, 16 Aug 2022 16:35:34 +1000
Message-id: <166063173439.5425.8345694210902041629@noble.neil.brown.name>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

Refcount is almost always 1 in nfs_unlink() so this must almost never
happen else we would have seen crashes before.

This patch removes the d_delete() call from nfs_dentry_handle_enoent()
so as to leave the one under ->remdir_sem in case that is important.

Fixes: 9019fb391de0 ("NFS: Label the dentry with a verifier in nfs_rmdir() an=
d nfs_unlink()")
Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfs/dir.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index dbab3caa15ed..4648b421025c 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -2382,7 +2382,6 @@ static void nfs_dentry_remove_handle_error(struct inode=
 *dir,
 {
 	switch (error) {
 	case -ENOENT:
-		d_delete(dentry);
 		nfs_set_verifier(dentry, nfs_save_change_attribute(dir));
 		break;
 	case 0:
--=20
2.37.1

