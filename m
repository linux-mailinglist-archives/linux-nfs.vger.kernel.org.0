Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 162AE68E739
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Feb 2023 05:45:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbjBHEpu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 7 Feb 2023 23:45:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbjBHEps (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 7 Feb 2023 23:45:48 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B57E019F2E
        for <linux-nfs@vger.kernel.org>; Tue,  7 Feb 2023 20:45:47 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2EAB733AC8;
        Wed,  8 Feb 2023 04:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1675831546; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=peRkUXH0MGv/3Raj16TdEvg6YueqodYfWKEv2Td74s0=;
        b=BdKrTvbH8hFeoka3gW2zLlmXtZ2bdo4wOaeccQxonk1Svxn7gUTr3f9qWra2mrJdqdo8eZ
        fzmLmIL1/TlxkSQHEVID40/3oSYFcMC6VAgpRkn4YNwUcUJT1K1WtO+38BSkpijcuLcDX8
        l2ph3vK4AT39ntezH0yXOqQboqaAXIc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1675831546;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=peRkUXH0MGv/3Raj16TdEvg6YueqodYfWKEv2Td74s0=;
        b=m5TieGlav9kBL54eHRK9K8n+Fm2rxvpcguJLCWQREYvVjfCtXW/zbHT1pcZmo2RaJDGE7l
        nycojjXbb3DU75Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 33F7613A1F;
        Wed,  8 Feb 2023 04:45:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id SHLBMPco42MvNQAAMHmgww
        (envelope-from <neilb@suse.de>); Wed, 08 Feb 2023 04:45:43 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     Trond Myklebust <trondmy@kernel.org>,
        Anna Schumaker <anna@kernel.org>
Cc:     Olga Kornievskaia <aglo@umich.edu>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: [PATCH] NFS: fix disabling of swap
Date:   Wed, 08 Feb 2023 15:45:38 +1100
Message-id: <167583153834.1616.15276280761550553611@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


When swap is activated to a file on an NFSv4 mount we arrange that the
state manager thread is always present as starting a new thread requires
memory allocations that might block waiting for swap.

Unfortunately the code for allowing the state manager thread to exit when
swap is disabled was not tested properly and does not work.
This can be seen by examining /proc/fs/nfsfs/servers after disabling swap
and unmounting the filesystem.  The servers file will still list one
entry.  Also a "ps" listing will show the state manager thread is still
present.

There are two problems.
 1/ rpc_clnt_swap_deactivate() doesn't walk up the ->cl_parent list to
    find the primary client on which the state manager runs.

 2/ The thread is not woken up properly and it immediately goes back to
    sleep without checking whether it is really needed.  Using
    nfs4_schedule_state_manager() ensures a proper wake-up.

Reported-by: Olga Kornievskaia <aglo@umich.edu>
Fixes: 4dc73c679114 ("NFSv4: keep state manager thread active if swap is enab=
led")
Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfs/nfs4proc.c | 4 +++-
 net/sunrpc/clnt.c | 2 ++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 86ed5c0142c3..22b88fdf1660 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -10597,7 +10597,9 @@ static void nfs4_disable_swap(struct inode *inode)
 	/* The state manager thread will now exit once it is
 	 * woken.
 	 */
-	wake_up_var(&NFS_SERVER(inode)->nfs_client->cl_state);
+	struct nfs_client *clp =3D NFS_SERVER(inode)->nfs_client;
+
+	nfs4_schedule_state_manager(clp);
 }
=20
 static const struct inode_operations nfs4_dir_inode_operations =3D {
diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index 993acf38af87..229af546a9e1 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -3350,6 +3350,8 @@ rpc_clnt_swap_deactivate_callback(struct rpc_clnt *clnt,
 void
 rpc_clnt_swap_deactivate(struct rpc_clnt *clnt)
 {
+	while (clnt !=3D clnt->cl_parent)
+		clnt =3D clnt->cl_parent;
 	if (atomic_dec_if_positive(&clnt->cl_swapper) =3D=3D 0)
 		rpc_clnt_iterate_for_each_xprt(clnt,
 				rpc_clnt_swap_deactivate_callback, NULL);
--=20
2.39.1

