Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 892827C4923
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Oct 2023 07:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbjJKFQZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 11 Oct 2023 01:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbjJKFQY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 11 Oct 2023 01:16:24 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A2069E
        for <linux-nfs@vger.kernel.org>; Tue, 10 Oct 2023 22:16:21 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 598B31F8D9;
        Wed, 11 Oct 2023 05:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1697001380; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Cp8y+48CpcA8VGo+HHNY1HR+kEbRsXE0VzkyNJUs+yI=;
        b=rbVDH1UdqveAwJ1XvCftRc8J0vZ1pz67ssOTIqxw7gp9tzwVpsVs4ApRebX3By0uvb5Yq3
        TBEMpQbN7To5sVUOsHK4iZbkhW/rbNYcAvlrkO6d8yi9Asco6GVqGOWOvLmiFVOGWQuCwJ
        EhM8nF9aejo/4Jvb3sqTcr3dpNCIymY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1697001380;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Cp8y+48CpcA8VGo+HHNY1HR+kEbRsXE0VzkyNJUs+yI=;
        b=YDu01gQ6HrR6znwkyb5eB9BMWSk12L0p4U2FftZTaOuV3IQJznigJR7DN61Co0p1wEXhEE
        AhP9dcLwfJuBobDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1814313586;
        Wed, 11 Oct 2023 05:16:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0y8yL6IvJmWGQgAAMHmgww
        (envelope-from <neilb@suse.de>); Wed, 11 Oct 2023 05:16:18 +0000
From:   NeilBrown <neilb@suse.de>
To:     Steve Dickson <steved@redhat.com>
Cc:     linux-nfs@vger.kernel.org,
        Trond Myklebust <trondmy@hammerspace.com>
Subject: [PATCH 3/3 RFC] export: nfsd_fh - always an answer to a well-formed question.
Date:   Wed, 11 Oct 2023 15:58:02 +1100
Message-ID: <20231011051131.24667-4-neilb@suse.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231011051131.24667-1-neilb@suse.de>
References: <20231011051131.24667-1-neilb@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

When the kernel asks mountd for some information it is important that
mountd reply as the kernel will not ask again.
When we don't have a useful reply we want the kernel to see this
as a transient failure.  This not currently (v6.6) any way to
communicate a transient failure.  The best we can do is give a
negative answer which is already expired.  This will at least
allow the kernel to ask again.

The kernel needs to be enhanced to not treat an entry that is already
expired as ever reliable.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 support/export/cache.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/support/export/cache.c b/support/export/cache.c
index 5307f6c8d872..74cacea9f0cc 100644
--- a/support/export/cache.c
+++ b/support/export/cache.c
@@ -894,7 +894,7 @@ static void nfsd_fh(int f)
 		 * quiet rather than returning stale yet
 		 */
 		if (dev_missing)
-			goto out;
+			goto out_delay;
 	} else if (found->e_mountpoint &&
 	    !is_mountpoint(found->e_mountpoint[0]?
 			   found->e_mountpoint:
@@ -904,8 +904,7 @@ static void nfsd_fh(int f)
 		   xlog(L_WARNING, "%s not exported as %d not a mountpoint",
 		   found->e_path, found->e_mountpoint);
 		 */
-		/* FIXME we need to make sure we re-visit this later */
-		goto out;
+		goto out_delay;
 	}
 
 	bp = buf; blen = sizeof(buf);
@@ -934,6 +933,26 @@ out:
 	nfs_freeaddrinfo(ai);
 	free(dom);
 	xlog(D_CALL, "nfsd_fh: found %p path %s", found, found ? found->e_path : NULL);
+	return;
+
+out_delay:
+	/* We don't have a definitely answer to give the kernel - maybe we will later.
+	 * This could be because an export marked "mountpoint" isn't a mountpoint, or
+	 * because a mountpoint fails with a strange error like ETIMEDOUT as is possible
+	 * with an NFS mount marked "softerr" which is being re-exported.
+	 * If we tell the kernel nothing, it will never ask again, so we have
+	 * to give some answer.  A negative answer that has already expired
+	 * is the best we can do.
+	 */
+	bp = buf; blen = sizeof(buf);
+	qword_add(&bp, &blen, dom);
+	qword_addint(&bp, &blen, fsidtype);
+	qword_addhex(&bp, &blen, fsid, fsidlen);
+	qword_addint(&bp, &blen, time(NULL) - 1);
+	qword_addeol(&bp, &blen);
+	if (blen <= 0 || cache_write(f, buf, bp - buf) != bp - buf)
+		xlog(L_ERROR, "nfsd_fh: error writing reply");
+	xlog(D_AUTH, "unknown access to %s", *dom == '$' ? dom+1 : dom);
 }
 
 #ifdef HAVE_JUNCTION_SUPPORT
-- 
2.42.0

