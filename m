Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C148D7235C5
	for <lists+linux-nfs@lfdr.de>; Tue,  6 Jun 2023 05:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbjFFDeI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 5 Jun 2023 23:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231258AbjFFDeG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 5 Jun 2023 23:34:06 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6FD811B
        for <linux-nfs@vger.kernel.org>; Mon,  5 Jun 2023 20:34:05 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2C8E02199D;
        Tue,  6 Jun 2023 03:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1686022444; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=bpANx9X+sQF5S7Kv+fFBW2DnhKe6tEMNo5nE7/ii0nw=;
        b=1dTnFYDRNJnc1u4A8Mw/hLM1PQXvhDskeBEXnYpPkG6ulnLssJXBykmj0f+VSXTGQNL5ZA
        QyHzYlLUkfU5I/hdRKMFygPNdfgerGX8VK418fBi5iGFJxGPynlL7PP6shFUz8o4rC/XC6
        gyVWPPFjUu8tfhcv4muUW1YLrzO8Z84=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1686022444;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=bpANx9X+sQF5S7Kv+fFBW2DnhKe6tEMNo5nE7/ii0nw=;
        b=eXnbPvleEVvjno4nA9IDAukrvQ4od4JP0PPCljaqIKWR+qtRK83qE5nF+h3tTEffCrXjDy
        TYJ6NihB2Ugm8eDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DE2FB13343;
        Tue,  6 Jun 2023 03:34:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ysFnIyqpfmR6KAAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 06 Jun 2023 03:34:02 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: [PATCH/RFC] NFS: fix use-after-free with O_DIRECT write
Date:   Tue, 06 Jun 2023 13:33:58 +1000
Message-id: <168602243849.29198.7621580343986486904@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


If the page size is greater than the wsize, O_DIRECT writes are broken
up into multiple sub-requests (subreqs) per page.
If there are two subreqs for a given page, one (not the head)
succeeds and the other succeeds but sees a write verifier mis-match, we
get a problem.

The first subreq will have been released (nfs_release_request) and will
have a refcount of zero and PG_TEARDOWN will be set.
The remainder of the request will be passed to
nfs_direct_write_reschedule() and thence to nfs_direct_join_group().

nfs_direct_join_group() calls nfs_release_request() on each non-head
subreq, and this results in a refcounter underflow.

The list is then passed to nfs_join_page_group() which should probably
ignore these completed subreqs too, though there is no serious problem
caused by not skipping them.  It finally gets to
nfs_destroy_unlinked_subrequests() which handles these unrefed subreqs
correctly.

This behaviour has been seen on a ppc64 machine with 64K page size,
mounting with NFSv3 an rsize=3Dwsize=3D32768.  The server-side filesystem
fills up causing the Linux NFS server to report ENOSPC and to update
the write verifier.

This patch adds tests on PG_TEARDOWN and skips those subrequests in
nfs_direcf_join_group().  It doesn't make changes to
nfs_join_page_group().

If a "head" subreq succeeds but other subreqs fail,
nfs_direct_join_group() will not join those subreqs back together.  I
doubt this is correct, but I haven't yet demonstrated a crash, or worked
through all the consequences.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfs/direct.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
index 9a18c5a69ace..d41d4b869d42 100644
--- a/fs/nfs/direct.c
+++ b/fs/nfs/direct.c
@@ -483,8 +483,10 @@ nfs_direct_join_group(struct list_head *list, struct ino=
de *inode)
 		for (next =3D req->wb_this_page;
 				next !=3D req->wb_head;
 				next =3D next->wb_this_page) {
-			nfs_list_remove_request(next);
-			nfs_release_request(next);
+			if (!test_bit(PG_TEARDOWN, &next->wb_flags)) {
+				nfs_list_remove_request(next);
+				nfs_release_request(next);
+			}
 		}
 		nfs_join_page_group(req, inode);
 	}
--=20
2.40.1

