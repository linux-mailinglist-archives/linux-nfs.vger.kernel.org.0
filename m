Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26BD37ACEA9
	for <lists+linux-nfs@lfdr.de>; Mon, 25 Sep 2023 05:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbjIYDUy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 24 Sep 2023 23:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjIYDUy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 24 Sep 2023 23:20:54 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6B09BC
        for <linux-nfs@vger.kernel.org>; Sun, 24 Sep 2023 20:20:47 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B3D401F38D;
        Mon, 25 Sep 2023 03:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1695612042; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=1TRcZ9yifw7ha6jD31r/ImdnT+rk3eyXm34yOVcNa7U=;
        b=o9+9InczZ52LfBnSGCvVGhqTdDSxc5rkiS7k/HlpfdOSk5BZK7p5cy/Yy3ZUHDf9j3d6i5
        94NK7dVJkC/WGOqsslaMB68zCw649HZoo0Z06kq5YeENM6ZViWYY5p0ptok4QeTM5GPHBx
        MbYmL1eDMXgXancOUkKtVrYLWUDi8tI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1695612042;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=1TRcZ9yifw7ha6jD31r/ImdnT+rk3eyXm34yOVcNa7U=;
        b=OWXh5BIQEDYheQ7hADLZtOlLUKYYaMwzjXQi7zE9iKuDeAM2ioPpz1wPW9d6oyZ4OtL5+G
        qDr0iSVsb3fr1AAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 863ED1391E;
        Mon, 25 Sep 2023 03:20:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id jiWFDoj8EGUOTgAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 25 Sep 2023 03:20:40 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>,
        Linux NFS list <linux-nfs@vger.kernel.org>
Subject: [PATCH nfsd-next] NFSD: simplify error paths in nfsd_svc()
Date:   Mon, 25 Sep 2023 12:06:44 +1000
Message-id: <169561203735.19404.6014131036692240448@noble.neil.brown.name>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


The error paths in nfsd_svc() are needlessly complex and can result in a
final call to svc_put() without nfsd_last_thread() being called.  This
results in the listening sockets not being closed properly.

The per-netns setup provided by nfsd_startup_new() and removed by
nfsd_shutdown_net() is needed precisely when there are running threads.
So we don't need nfsd_up_before.  We don't need to know if it *was* up.
We only need to know if any threads are left.  If none are, then we must
call nfsd_shutdown_net().  But we don't need to do that explicitly as
nfsd_last_thread() does that for us.

So simply call nfsd_last_thread() before the last svc_put() if there are
no running threads.  That will always do the right thing.

Also discard:
 pr_info("nfsd: last server has exited, flushing export cache\n");
It may not be true if an attempt to start the first server failed, and
it isn't particularly helpful and it simply reports normal behaviour.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/nfssvc.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index c5890cdfe97b..d6122bb2d167 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -572,7 +572,6 @@ static void nfsd_last_thread(struct net *net)
 		return;
=20
 	nfsd_shutdown_net(net);
-	pr_info("nfsd: last server has exited, flushing export cache\n");
 	nfsd_export_flush(net);
 }
=20
@@ -786,7 +785,6 @@ int
 nfsd_svc(int nrservs, struct net *net, const struct cred *cred)
 {
 	int	error;
-	bool	nfsd_up_before;
 	struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
 	struct svc_serv *serv;
=20
@@ -806,8 +804,6 @@ nfsd_svc(int nrservs, struct net *net, const struct cred =
*cred)
 	error =3D nfsd_create_serv(net);
 	if (error)
 		goto out;
-
-	nfsd_up_before =3D nn->nfsd_net_up;
 	serv =3D nn->nfsd_serv;
=20
 	error =3D nfsd_startup_net(net, cred);
@@ -815,17 +811,15 @@ nfsd_svc(int nrservs, struct net *net, const struct cre=
d *cred)
 		goto out_put;
 	error =3D svc_set_num_threads(serv, NULL, nrservs);
 	if (error)
-		goto out_shutdown;
+		goto out_put;
 	error =3D serv->sv_nrthreads;
-	if (error =3D=3D 0)
-		nfsd_last_thread(net);
-out_shutdown:
-	if (error < 0 && !nfsd_up_before)
-		nfsd_shutdown_net(net);
 out_put:
 	/* Threads now hold service active */
 	if (xchg(&nn->keep_active, 0))
 		svc_put(serv);
+
+	if (serv->sv_nrthreads =3D=3D 0)
+		nfsd_last_thread(net);
 	svc_put(serv);
 out:
 	mutex_unlock(&nfsd_mutex);
--=20
2.42.0

