Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 387944E1E57
	for <lists+linux-nfs@lfdr.de>; Mon, 21 Mar 2022 01:00:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343848AbiCUABW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 20 Mar 2022 20:01:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238451AbiCUABW (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 20 Mar 2022 20:01:22 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C66C985958
        for <linux-nfs@vger.kernel.org>; Sun, 20 Mar 2022 16:59:57 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 41C901F37E;
        Sun, 20 Mar 2022 23:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1647820796; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=klYdqQO/NURcgD1ROjrMJO2bsBcF7280Dxg+GeEZy50=;
        b=b6ciy5CA8YWhbj7ni1r/kEvG3UpRJrv4lR6qCkDepEyyMLFUemK3XE4AmoSYKhDb73x1c4
        8Do/fS2EdqThF1XdkGJm+PMDOY7JL/SN9Omuza7TGmYjew3M4WETVvm/LjBl50SIgz4gtF
        LqBaZpKaLy4TywN2YPjh4YfkvFUHa88=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1647820796;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=klYdqQO/NURcgD1ROjrMJO2bsBcF7280Dxg+GeEZy50=;
        b=w9mJP14j7mkcZb6SJJ0kMaAUk9jVlqeE9w7qXiuU5G7SMjgaUOAZDUM8XgR8w+WHglb2pv
        x19uE/tLtLYExrBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 22D0D134F5;
        Sun, 20 Mar 2022 23:59:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id yuauM/q/N2LtHQAAMHmgww
        (envelope-from <neilb@suse.de>); Sun, 20 Mar 2022 23:59:54 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: [PATCH] NFS: Improve warning message when locks are lost.
Date:   Mon, 21 Mar 2022 10:59:51 +1100
Message-id: <164782079118.24302.10351255364802334775@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


NFSv4 can lose locks if, for example there is a network partition for
longer than the lease period.  When this happens a warning message

  NFS: __nfs4_reclaim_open_state: Lock reclaim failed!

is generated, possibly once for each lock (though rate limited).

This is potentially misleading as is can be read as suggesting that lock
reclaim was attempted.  However the default behaviour is to not attempt
to recover locks (except due to server report).

This patch changes the reporting to produce at most one message for each
attempt to recover all state from a given server.  The message reports
the server name and the number of locks lost if that number is non-zero.
It reports that locks were lost and give no suggestion as to whether
there was an attempt or not.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfs/nfs4state.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
index f5a62c0d999b..f45719599ea2 100644
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -1592,7 +1592,8 @@ static inline void nfs42_complete_copies(struct nfs4_st=
ate_owner *sp,
 #endif /* CONFIG_NFS_V4_2 */
=20
 static int __nfs4_reclaim_open_state(struct nfs4_state_owner *sp, struct nfs=
4_state *state,
-				     const struct nfs4_state_recovery_ops *ops)
+				     const struct nfs4_state_recovery_ops *ops,
+				     int *lost_locks)
 {
 	struct nfs4_lock_state *lock;
 	int status;
@@ -1610,7 +1611,7 @@ static int __nfs4_reclaim_open_state(struct nfs4_state_=
owner *sp, struct nfs4_st
 		list_for_each_entry(lock, &state->lock_states, ls_locks) {
 			trace_nfs4_state_lock_reclaim(state, lock);
 			if (!test_bit(NFS_LOCK_INITIALIZED, &lock->ls_flags))
-				pr_warn_ratelimited("NFS: %s: Lock reclaim failed!\n", __func__);
+				*lost_locks +=3D 1;
 		}
 		spin_unlock(&state->state_lock);
 	}
@@ -1620,7 +1621,9 @@ static int __nfs4_reclaim_open_state(struct nfs4_state_=
owner *sp, struct nfs4_st
 	return status;
 }
=20
-static int nfs4_reclaim_open_state(struct nfs4_state_owner *sp, const struct=
 nfs4_state_recovery_ops *ops)
+static int nfs4_reclaim_open_state(struct nfs4_state_owner *sp,
+				   const struct nfs4_state_recovery_ops *ops,
+				   int *lost_locks)
 {
 	struct nfs4_state *state;
 	unsigned int loop =3D 0;
@@ -1656,7 +1659,7 @@ static int nfs4_reclaim_open_state(struct nfs4_state_ow=
ner *sp, const struct nfs
 #endif /* CONFIG_NFS_V4_2 */
 		refcount_inc(&state->count);
 		spin_unlock(&sp->so_lock);
-		status =3D __nfs4_reclaim_open_state(sp, state, ops);
+		status =3D __nfs4_reclaim_open_state(sp, state, ops, lost_locks);
=20
 		switch (status) {
 		default:
@@ -1899,6 +1902,7 @@ static int nfs4_do_reclaim(struct nfs_client *clp, cons=
t struct nfs4_state_recov
 	struct rb_node *pos;
 	LIST_HEAD(freeme);
 	int status =3D 0;
+	int lost_locks =3D 0;
=20
 restart:
 	rcu_read_lock();
@@ -1918,8 +1922,11 @@ static int nfs4_do_reclaim(struct nfs_client *clp, con=
st struct nfs4_state_recov
 			spin_unlock(&clp->cl_lock);
 			rcu_read_unlock();
=20
-			status =3D nfs4_reclaim_open_state(sp, ops);
+			status =3D nfs4_reclaim_open_state(sp, ops, &lost_locks);
 			if (status < 0) {
+				if (lost_locks)
+					pr_warn("NFS: %s: lost %d locks\n",
+						clp->cl_hostname, lost_locks);
 				set_bit(ops->owner_flag_bit, &sp->so_flags);
 				nfs4_put_state_owner(sp);
 				status =3D nfs4_recovery_handle_error(clp, status);
@@ -1933,6 +1940,9 @@ static int nfs4_do_reclaim(struct nfs_client *clp, cons=
t struct nfs4_state_recov
 	}
 	rcu_read_unlock();
 	nfs4_free_state_owners(&freeme);
+	if (lost_locks)
+		pr_warn("NFS: %s: lost %d locks\n",
+			clp->cl_hostname, lost_locks);
 	return 0;
 }
=20
--=20
2.35.1

