Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5655F9477
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Oct 2022 01:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231343AbiJIX4n (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 9 Oct 2022 19:56:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231358AbiJIX4Z (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 9 Oct 2022 19:56:25 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C15659E6
        for <linux-nfs@vger.kernel.org>; Sun,  9 Oct 2022 16:27:26 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1034E21990;
        Sun,  9 Oct 2022 23:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1665358017; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=TaNuYY+3/4Lw3dXwZWbMe6oN9MF/pzaSe6ZDKsbzngw=;
        b=AQ7vNBcMFFj1NISnO8nAX9LtN601hQnY8xSLXCLEgn8CwDoyrExMGg+XMnQyMnBh2vzTa9
        ++c3ayfnJfIrTVyGbDcvwiIT42TDKOoSqD8dfVaqLAMtQ8SNmoofxNH8aoOylhdnXM9z9K
        xMQT2S1DclbBoeTbL0PLq4gTG9NvZ8I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1665358017;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=TaNuYY+3/4Lw3dXwZWbMe6oN9MF/pzaSe6ZDKsbzngw=;
        b=uMGvSyCHhP0fu/JPGFIrklX0C9199vhfCUEvtaG/OaLTk/KjDDfdeqODhHoeB+FmZOMAxt
        AQW+I0SOE58FBrAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E598D13A9A;
        Sun,  9 Oct 2022 23:26:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id TnjCJ79YQ2NCSgAAMHmgww
        (envelope-from <neilb@suse.de>); Sun, 09 Oct 2022 23:26:55 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: [PATCH] NFS: avoid spurious warning of lost lock that is being unlocked.
Date:   Mon, 10 Oct 2022 10:26:51 +1100
Message-id: <166535801153.14457.14655654011921069380@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


When the NFSv4 state manager recovers state after a server restart, it
reports that locks have been lost if it finds any lock state for which
recovery hasn't been successful.  i.e. any for which
NFS_LOCK_INITIALIZED is not set.

However it only tries to recover locks that are still linked to
inode->i_flctx.  So if a lock has been removed from inode->i_flctx, but
the state for that lock has not yet been destroyed, then a spurious
warning results.

nfs4_proc_unlck() calls locks_lock_inode_wait() - which removes the lock
from ->i_flctx - before sending the unlock request to the server and
before the final nfs4_put_lock_state() is called.  This allows a window
in which a spurious warning can be produced.

So add a new flag NFS_LOCK_UNLOCKING which is set once the decision has
been made to unlock the lock.  This will prevent it from triggering any
warning.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfs/nfs4_fs.h   | 1 +
 fs/nfs/nfs4proc.c  | 3 ++-
 fs/nfs/nfs4state.c | 3 ++-
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/nfs4_fs.h b/fs/nfs/nfs4_fs.h
index 79df6e83881b..f50297dee304 100644
--- a/fs/nfs/nfs4_fs.h
+++ b/fs/nfs/nfs4_fs.h
@@ -149,6 +149,7 @@ struct nfs4_lock_state {
 	struct nfs4_state *	ls_state;	/* Pointer to open state */
 #define NFS_LOCK_INITIALIZED 0
 #define NFS_LOCK_LOST        1
+#define NFS_LOCK_UNLOCKING   2
 	unsigned long		ls_flags;
 	struct nfs_seqid_counter	ls_seqid;
 	nfs4_stateid		ls_stateid;
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 3ed14a2a84a4..ae2a3849ea60 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -7016,12 +7016,13 @@ static int nfs4_proc_unlck(struct nfs4_state *state, =
int cmd, struct file_lock *
 		mutex_unlock(&sp->so_delegreturn_mutex);
 		goto out;
 	}
+	lsp =3D request->fl_u.nfs4_fl.owner;
+	set_bit(NFS_LOCK_UNLOCKING, &lsp->ls_flags);
 	up_read(&nfsi->rwsem);
 	mutex_unlock(&sp->so_delegreturn_mutex);
 	if (status !=3D 0)
 		goto out;
 	/* Is this a delegated lock? */
-	lsp =3D request->fl_u.nfs4_fl.owner;
 	if (test_bit(NFS_LOCK_INITIALIZED, &lsp->ls_flags) =3D=3D 0)
 		goto out;
 	alloc_seqid =3D NFS_SERVER(inode)->nfs_client->cl_mvops->alloc_seqid;
diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
index 9bab3e9c702a..c26a3792ecca 100644
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -1620,7 +1620,8 @@ static int __nfs4_reclaim_open_state(struct nfs4_state_=
owner *sp, struct nfs4_st
 		spin_lock(&state->state_lock);
 		list_for_each_entry(lock, &state->lock_states, ls_locks) {
 			trace_nfs4_state_lock_reclaim(state, lock);
-			if (!test_bit(NFS_LOCK_INITIALIZED, &lock->ls_flags))
+			if (!test_bit(NFS_LOCK_INITIALIZED, &lock->ls_flags) &&
+			    !test_bit(NFS_LOCK_UNLOCKING, &lock->ls_flags))
 				*lost_locks +=3D 1;
 		}
 		spin_unlock(&state->state_lock);
--=20
2.37.3

