Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8821F4527EE
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Nov 2021 03:47:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347298AbhKPCug (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 15 Nov 2021 21:50:36 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:59368 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356876AbhKPCsf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 15 Nov 2021 21:48:35 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 398F321910;
        Tue, 16 Nov 2021 02:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1637030735; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1/BSIu6f8h3udxg/DtgGyKIFrkiRDq54LWgglD0VugE=;
        b=IplAxp1y0sekl7XcljUnG5z89tZMSeqbWmLOhyGMm6vG+6I7vAkuytzPBU64O7NA+Eh0fk
        y+rZNiyqm9YhWdNNwTYf9+lssWL3iGI3wRyd2yNX3uVMn7sAg6KKFp4i0ZFKbsZRwsO1P4
        /BP+n7Jkn6O9I+qUqUoTwbwVKb1J6QE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1637030735;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1/BSIu6f8h3udxg/DtgGyKIFrkiRDq54LWgglD0VugE=;
        b=AWlfzuqouIRw64bl6P8ib6Gos4ML2cOYA82dE/tQ3Wp7jzocfC+UdQnkeEIwOpvnqpyzwP
        R2e+lzQOcjNzc6Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D80E713B70;
        Tue, 16 Nov 2021 02:45:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 1wlgJUwbk2G+CAAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 16 Nov 2021 02:45:32 +0000
Subject: [PATCH 01/13] NFS: move generic_write_checks() call from
 nfs_file_direct_write() to nfs_file_write()
From:   NeilBrown <neilb@suse.de>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>
Cc:     linux-nfs@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 16 Nov 2021 13:44:04 +1100
Message-ID: <163703064449.25805.2687706207398048223.stgit@noble.brown>
In-Reply-To: <163702956672.25805.16457749992977493579.stgit@noble.brown>
References: <163702956672.25805.16457749992977493579.stgit@noble.brown>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

generic_write_checks() is not needed for swap-out writes, and fails if
they are attempted.
nfs_file_direct_write() currently calls generic_write_checks() and is in
turn called from:
  nfs_direct_IO  - only for swap-out
  nfs_file_write - for normal O_DIRECT write

So move the generic_write_checks() call into nfs_file_write().  This
allows NFS swap-out writes to complete.

Fixes: dc617f29dbe5 ("vfs: don't allow writes to swap files")
Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfs/direct.c |    5 +----
 fs/nfs/file.c   |    6 +++++-
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
index 9cff8709c80a..1e80d243ba25 100644
--- a/fs/nfs/direct.c
+++ b/fs/nfs/direct.c
@@ -905,10 +905,7 @@ ssize_t nfs_file_direct_write(struct kiocb *iocb, struct iov_iter *iter)
 	dfprintk(FILE, "NFS: direct write(%pD2, %zd@%Ld)\n",
 		file, iov_iter_count(iter), (long long) iocb->ki_pos);
 
-	result = generic_write_checks(iocb, iter);
-	if (result <= 0)
-		return result;
-	count = result;
+	count = iov_iter_count(iter);
 	nfs_add_stats(mapping->host, NFSIOS_DIRECTWRITTENBYTES, count);
 
 	pos = iocb->ki_pos;
diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index 24e7dccce355..45d8180b7be3 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -615,8 +615,12 @@ ssize_t nfs_file_write(struct kiocb *iocb, struct iov_iter *from)
 	if (result)
 		return result;
 
-	if (iocb->ki_flags & IOCB_DIRECT)
+	if (iocb->ki_flags & IOCB_DIRECT) {
+		result = generic_write_checks(iocb, from);
+		if (result <= 0)
+			return result;
 		return nfs_file_direct_write(iocb, from);
+	}
 
 	dprintk("NFS: write(%pD2, %zu@%Ld)\n",
 		file, iov_iter_count(from), (long long) iocb->ki_pos);


