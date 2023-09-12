Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7124C79C363
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Sep 2023 04:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240883AbjILC5I (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 11 Sep 2023 22:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240891AbjILC4z (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 11 Sep 2023 22:56:55 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D3F114D42B
        for <linux-nfs@vger.kernel.org>; Mon, 11 Sep 2023 18:25:07 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3B6401F74C;
        Tue, 12 Sep 2023 01:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1694481906; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=c+O/x3/K5RK5jgt0Oj1cbCVEObR8so+N3HTFSppsqqk=;
        b=UEbrb1ENwY4nX5obinaWhjeye8PYQ8136zcZF89tohDHj7+XsIzKsPLi4LeNZCS18jKiGd
        lPTnCeeMHhed7kj+LbHWsuPIWbkhKovshLcI4oe5TBbQtgHG2N6BbpMINfX0I7AHvGwG6S
        gX7Ce405fDA+moKtXcIHktkAW9aedCk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1694481906;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=c+O/x3/K5RK5jgt0Oj1cbCVEObR8so+N3HTFSppsqqk=;
        b=IQiQ2d66lKk49OAnU77ZcIk74eaRzBX4SbwR6aam+Ew/6bgvX5cuVWtCLYz4AnXuFPAkLu
        Gext7dD6eVDHo6AQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1156713582;
        Tue, 12 Sep 2023 01:25:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id nshqLe+9/2RYaAAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 12 Sep 2023 01:25:03 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     Linux NFS list <linux-nfs@vger.kernel.org>,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Subject: [PATCH] NFSD: fix possible oops when nfsd/pool_stats is closed.
Date:   Tue, 12 Sep 2023 11:25:00 +1000
Message-id: <169448190063.19905.9707641304438290692@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


If /proc/fs/nfsd/pool_stats is open when the last nfsd thread exits, then
when the file is closed a NULL pointer is dereferenced.
This is because nfsd_pool_stats_release() assumes that the
pointer to the svc_serv cannot become NULL while a reference is held.

This used to be the case but a recent patch split nfsd_last_thread() out
from nfsd_put(), and clearing the pointer is done in nfsd_last_thread().

This is easily reproduced by running
   rpc.nfsd 8 ; ( rpc.nfsd 0;true) < /proc/fs/nfsd/pool_stats

Fortunately nfsd_pool_stats_release() has easy access to the svc_serv
pointer, and so can call svc_put() on it directly.

Fixes: 9f28a971ee9f ("nfsd: separate nfsd_last_thread() from nfsd_put()")
Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/nfssvc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index 1582af33e204..551c16a72012 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -1082,11 +1082,12 @@ int nfsd_pool_stats_open(struct inode *inode, struct =
file *file)
=20
 int nfsd_pool_stats_release(struct inode *inode, struct file *file)
 {
+	struct svc_serv *serv =3D
+		((struct seq_file *) file->private_data)->private;
 	int ret =3D seq_release(inode, file);
-	struct net *net =3D inode->i_sb->s_fs_info;
=20
 	mutex_lock(&nfsd_mutex);
-	nfsd_put(net);
+	svc_put(serv);
 	mutex_unlock(&nfsd_mutex);
 	return ret;
 }
--=20
2.42.0

