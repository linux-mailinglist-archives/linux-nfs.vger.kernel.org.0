Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 158A14599CF
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Nov 2021 02:32:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbhKWBf4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 22 Nov 2021 20:35:56 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:37202 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbhKWBf4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 22 Nov 2021 20:35:56 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 243E21FD33;
        Tue, 23 Nov 2021 01:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1637631168; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M42bhQIasE2MvpVoJ/Qwc7TcaBZXRZCimM8iH/q8+qU=;
        b=p/AMNhp+QVBesP2HRDAEwY2GkJY3dHcyhRzRAyabR9Lt93dk2N+XhEkTLYMEuxy1trvEUe
        dW2gIvNaCx9+7jvCeLs35GMi+yI/6vVGx9oc5FrKKrz4BIwh+Rtwe4QMudDwENxvRgmWBS
        P151EO1YhXkzBTZnWW5elQcRqr3Xq9A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1637631168;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M42bhQIasE2MvpVoJ/Qwc7TcaBZXRZCimM8iH/q8+qU=;
        b=2DCHlNiAVRo2eF1UQaQdCOLebLVjP4U7e7NnG2qoexzT0ImPOvebTBMsOGUFOxuPqPZIy1
        TkZJEFK2HMqFhOCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F1A4C13BD4;
        Tue, 23 Nov 2021 01:32:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id pF7eKr5EnGE5dAAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 23 Nov 2021 01:32:46 +0000
Subject: [PATCH 19/19] NFS: switch the callback service back to non-pooled.
From:   NeilBrown <neilb@suse.de>
To:     "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Date:   Tue, 23 Nov 2021 12:29:35 +1100
Message-ID: <163763097551.7284.13645796472410259327.stgit@noble.brown>
In-Reply-To: <163763078330.7284.10141477742275086758.stgit@noble.brown>
References: <163763078330.7284.10141477742275086758.stgit@noble.brown>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Now that thread management is consistent there is no need for
nfs-callback to use svc_create_pooled() as introduced in Commit
df807fffaabd ("NFSv4.x/callback: Create the callback service through
svc_create_pooled").  So switch back to svc_create().

If service pools were configured, but the number of threads were left at
'1', nfs callback may not work reliably when svc_create_pooled() is used.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfs/callback.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/callback.c b/fs/nfs/callback.c
index 6cdc9d18a7dd..c4994c1d4e36 100644
--- a/fs/nfs/callback.c
+++ b/fs/nfs/callback.c
@@ -286,7 +286,7 @@ static struct svc_serv *nfs_callback_create_svc(int minorversion)
 		printk(KERN_WARNING "nfs_callback_create_svc: no kthread, %d users??\n",
 			cb_info->users);
 
-	serv = svc_create_pooled(&nfs4_callback_program, NFS4_CALLBACK_BUFSIZE, sv_ops);
+	serv = svc_create(&nfs4_callback_program, NFS4_CALLBACK_BUFSIZE, sv_ops);
 	if (!serv) {
 		printk(KERN_ERR "nfs_callback_create_svc: create service failed\n");
 		return ERR_PTR(-ENOMEM);


