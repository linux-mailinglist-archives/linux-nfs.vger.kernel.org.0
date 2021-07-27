Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 200703D83C3
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Jul 2021 01:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232750AbhG0XPh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 27 Jul 2021 19:15:37 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:59966 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232314AbhG0XPh (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 27 Jul 2021 19:15:37 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E41EC2227C;
        Tue, 27 Jul 2021 23:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1627427735; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=xOgxaBxb3YxZ42LEq8uL0daRSF34LXkNtTtD8Dix0PA=;
        b=VJr3deVDrt3B7pbZT1vdiF4+LLvd8FAu/SA3UUXxGBsUJ9LLiOKHMvvljfywZC2QRLkAKl
        2OSZ+nC7utPUNAiyg6KYp3YEtZgTa0lu2iFtvvsBJGi6ArbkjyG6f8b6TzKA6SfuNA9rFS
        UVEYva70UPAo1icbtWoicJAwjRAijJo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1627427735;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=xOgxaBxb3YxZ42LEq8uL0daRSF34LXkNtTtD8Dix0PA=;
        b=yeGvvHbUBh8LgRSsMj2zj4FIyX7Mqfs1ltLq2YcYbspv6QTHJ7WzVafaazz7fKfEeaw7OJ
        jxnA5YNRv21JSfDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D2C1013B91;
        Tue, 27 Jul 2021 23:15:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4BjzI5aTAGEAXQAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 27 Jul 2021 23:15:34 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <Anna.Schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH] NFS: fix minor issues with automount expiry.
Date:   Wed, 28 Jul 2021 09:15:31 +1000
Message-id: <162742773175.21659.17666555162574585184@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


1/ If automount expiry timeout is set to zero, new mounts are not added
   to the list.  If the timeout is then changed, those previously
   mounts will still not be timed out.  This is probably not what
   would be expected.  Simply refusing to start the timer
   is sufficient to prevent timeout.

2/ the MODULE_PARM_DESC for nfs_mountpoint_expiry_timeout is missing
   a space between to two sentences.  This is hidden by the fact that
   the string is broken onto to line - against current policy.
   So join onto a single (long) line, and add the space.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfs/namespace.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/namespace.c b/fs/nfs/namespace.c
index bc0c698f3350..be5e77a80811 100644
--- a/fs/nfs/namespace.c
+++ b/fs/nfs/namespace.c
@@ -196,10 +196,10 @@ struct vfsmount *nfs_d_automount(struct path *path)
 		goto out_fc;
=20
 	mntget(mnt); /* prevent immediate expiration */
+	mnt_set_expiry(mnt, &nfs_automount_list);
 	if (timeout <=3D 0)
 		goto out_fc;
=20
-	mnt_set_expiry(mnt, &nfs_automount_list);
 	schedule_delayed_work(&nfs_automount_task, timeout);
=20
 out_fc:
@@ -366,5 +366,4 @@ static const struct kernel_param_ops param_ops_nfs_timeou=
t =3D {
=20
 module_param(nfs_mountpoint_expiry_timeout, nfs_timeout, 0644);
 MODULE_PARM_DESC(nfs_mountpoint_expiry_timeout,
-		"Set the NFS automounted mountpoint timeout value (seconds)."
-		"Values <=3D 0 turn expiration off.");
+		"Set the NFS automounted mountpoint timeout value (seconds). Values <=3D 0=
 turn expiration off.");
--=20
2.32.0

