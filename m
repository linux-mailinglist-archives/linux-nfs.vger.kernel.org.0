Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2E244015C1
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Sep 2021 06:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232680AbhIFEpT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 6 Sep 2021 00:45:19 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:56824 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231461AbhIFEpR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 6 Sep 2021 00:45:17 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 95331220FF;
        Mon,  6 Sep 2021 04:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1630903452; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=RSn0F1pg7xrSk3+Y04XRlyfzCR4yceIYluAYIL+7kRg=;
        b=JoEfc5TYhjAnMa/YEuBhoavqkltdDKcsUZVsLt5IK192N+ou4ZWJ4PTRhP22+inhsVGiw0
        rRW5JinnTNsYburt13eYmEojzm7RxpFdbDCAxUNjAbzcAmDWu2JC5RvQ6j3PyW/bQ7UY86
        7fYrFeCyvVg3Lc+FQbydvPsQfGQfC/g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1630903452;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=RSn0F1pg7xrSk3+Y04XRlyfzCR4yceIYluAYIL+7kRg=;
        b=+jA37hk2Ds2u4MA6YBekWaXeLhuiYu1kCPWqYNyrIUJEjp7wR/4o9oPn9LSAz1xPl7GWGH
        mqlWzcRQzBbRUnCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8B819133A4;
        Mon,  6 Sep 2021 04:44:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id snbbEpucNWHXOwAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 06 Sep 2021 04:44:11 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     Chuck Lever <chuck.lever@oracle.com>,
        "J. Bruce Fields" <bfields@fieldses.org>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH] SUNRPC: use congestion_wait() in svc_alloc_args()
Date:   Mon, 06 Sep 2021 14:44:08 +1000
Message-id: <163090344807.19339.10071205771966144716@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


Many places that need to wait before retrying a memory allocation use
congestion_wait().  xfs_buf_alloc_pages() is a good example which
follows a similar pattern to that in svc_alloc_args().

It make sense to do the same thing in svc_alloc_args(); This will allow
the allocation to be retried sooner if some backing device becomes
non-congested before the timeout.

Every call to congestion_wait() in the entire kernel passes BLK_RW_ASYNC
as the first argument, so we should so.

The second argument - an upper limit for waiting - seem fairly
arbitrary.  Many places use "HZ/50" or "HZ/10".  As there is no obvious
choice, it seems reasonable to leave the maximum time unchanged.

If a service using svc_alloc_args() is terminated, it may now have to
wait up to the full 500ms before termination completes as
congestion_wait() cannot be interrupted.  I don't believe this will be a
problem in practice, though it might be justification for using a
smaller timeout.

Signed-off-by: NeilBrown <neilb@suse.de>
---

I happened to notice this inconsistency between svc_alloc_args() and
xfs_buf_alloc_pages() despite them doing very similar things, so thought
I'd send a patch.

NeilBrown


 net/sunrpc/svc_xprt.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index 796eebf1787d..161433ae0fab 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -10,6 +10,7 @@
 #include <linux/freezer.h>
 #include <linux/kthread.h>
 #include <linux/slab.h>
+#include <linux/backing-dev.h>
 #include <net/sock.h>
 #include <linux/sunrpc/addr.h>
 #include <linux/sunrpc/stats.h>
@@ -682,12 +683,10 @@ static int svc_alloc_arg(struct svc_rqst *rqstp)
 			/* Made progress, don't sleep yet */
 			continue;
=20
-		set_current_state(TASK_INTERRUPTIBLE);
-		if (signalled() || kthread_should_stop()) {
-			set_current_state(TASK_RUNNING);
+		if (signalled() || kthread_should_stop())
 			return -EINTR;
-		}
-		schedule_timeout(msecs_to_jiffies(500));
+
+		congestion_wait(BLK_RW_ASYNC, msecs_to_jiffies(500));
 	}
 	rqstp->rq_page_end =3D &rqstp->rq_pages[pages];
 	rqstp->rq_pages[pages] =3D NULL; /* this might be seen in nfsd_splice_actor=
() */
--=20
2.33.0

