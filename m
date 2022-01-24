Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B892B4977DF
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Jan 2022 04:53:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241204AbiAXDxK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 23 Jan 2022 22:53:10 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:56866 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241200AbiAXDxK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 23 Jan 2022 22:53:10 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E11EA21997;
        Mon, 24 Jan 2022 03:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1642996388; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w8lR7J8JNn9z3HgJi0/q20xbPjyDJKVj8xh3UiEzhOQ=;
        b=BIFtq0WxNoK33RbSSnkbhn7EkwZIJe9uuHRxyCZ03NZ7aYWSjcVp24hiAUh1n0iZ2FW66L
        KiFctLtDEFU4K29rI7mnmXznzvDMex258aT9xsPPVtAk0JwooEtTFgRa2cnmEDBVQaOpA0
        MSFdLM9c+p5eGfwo5yPWmePVfpPljq0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1642996388;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w8lR7J8JNn9z3HgJi0/q20xbPjyDJKVj8xh3UiEzhOQ=;
        b=T7wT1d1qNNR2PFPLlpZBeDaBKmfxRWNTJgT+STJswMATGxn3qssrMiMMOHHdaw5UYROrSd
        59Joc+ibKdu2eGBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D33C113305;
        Mon, 24 Jan 2022 03:53:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id XkU8I6Ei7mGURQAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 24 Jan 2022 03:53:05 +0000
Subject: [PATCH 12/23] NFS: remove IS_SWAPFILE hack
From:   NeilBrown <neilb@suse.de>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>
Cc:     linux-nfs@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 24 Jan 2022 14:48:32 +1100
Message-ID: <164299611280.26253.6924680050876339981.stgit@noble.brown>
In-Reply-To: <164299573337.26253.7538614611220034049.stgit@noble.brown>
References: <164299573337.26253.7538614611220034049.stgit@noble.brown>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This code is pointless as IS_SWAPFILE is always defined.
So remove it.

Suggested-by: Mark Hemment <markhemm@googlemail.com>
Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfs/file.c |    5 -----
 1 file changed, 5 deletions(-)

diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index 9e2def045111..4d4750738aeb 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -44,11 +44,6 @@
 
 static const struct vm_operations_struct nfs_file_vm_ops;
 
-/* Hack for future NFS swap support */
-#ifndef IS_SWAPFILE
-# define IS_SWAPFILE(inode)	(0)
-#endif
-
 int nfs_check_flags(int flags)
 {
 	if ((flags & (O_APPEND | O_DIRECT)) == (O_APPEND | O_DIRECT))


