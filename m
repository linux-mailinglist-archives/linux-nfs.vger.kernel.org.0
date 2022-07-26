Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A676580BD7
	for <lists+linux-nfs@lfdr.de>; Tue, 26 Jul 2022 08:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237858AbiGZGqf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 26 Jul 2022 02:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237776AbiGZGqe (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 26 Jul 2022 02:46:34 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C84201EAFE
        for <linux-nfs@vger.kernel.org>; Mon, 25 Jul 2022 23:46:33 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 58F1834595;
        Tue, 26 Jul 2022 06:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1658817991; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=ZLzWk/qU4dU6J2EdsmsXbjIubh0L0To9Nfu6l4+1jRw=;
        b=Y4Mr2XiFAizUMzVm6snJzUptOPLlswdBwM5JCB6OsB1raoMvZrTbpmL8VzO4Da1BP9SEb4
        2V8MJu2huFtXslR64rmKghPSqn8Wdx9o5aQpxGUgQN63nBl/ZPoCclAbEnvyj+/vcBjajr
        AbGX0ar+38vAeWAbSEN0t/bxvsx9hNI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1658817991;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=ZLzWk/qU4dU6J2EdsmsXbjIubh0L0To9Nfu6l4+1jRw=;
        b=CGRmacDaAwtpczwtSm3yBnyBQK46aKzu3PhhHaE9uxMbDcXK9vD2tIDThwSNb+XUjZq7+F
        4C5tOC+YTC/jz9AQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3E84713A7C;
        Tue, 26 Jul 2022 06:46:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 5sjKOsWN32IiWAAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 26 Jul 2022 06:46:29 +0000
Subject: [PATCH 00/13] NFSD: clean up locking
From:   NeilBrown <neilb@suse.de>
To:     Chuck Lever III <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Date:   Tue, 26 Jul 2022 16:45:30 +1000
Message-ID: <165881740958.21666.5904057696047278505.stgit@noble.brown>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This is the latest version of my series to clean up locking -
particularly of directories - in preparation for proposed patches which
change how directory locking works across the VFS.

I've included Jeff's patches to validate the dentry after getting a
delegation.  The second patch has been changed quite a bit to use
nfsd_lookup_dentry(). I've left Jeff's From: line in place - let me know
if you'd rather I change it.

Setting of ACLs and security labels has been moved from nfs4 code to
nfsd_setattr() which allows quite a lot of code cleanup.

I think I've addressed all the concerns that have been raised, though
maybe not in the way that was suggested.

I've tested this with cthon tests over v2, v3, v4.0, v4.1, and xfstests
on v3 and v4.1, and pynfs 4.0, 4.1.  No problems appeared.

Thanks,
NeilBrown


---

Jeff Layton (2):
      NFSD: drop fh argument from alloc_init_deleg
      NFSD: verify the opened dentry after setting a delegation

NeilBrown (11):
      NFSD: introduce struct nfsd_attrs
      NFSD: set attributes when creating symlinks
      NFSD: add security label to struct nfsd_attrs
      NFSD: add posix ACLs to struct nfsd_attrs
      NFSD: change nfsd_create()/nfsd_symlink() to unlock directory before returning.
      NFSD: always drop directory lock in nfsd_unlink()
      NFSD: only call fh_unlock() once in nfsd_link()
      NFSD: reduce locking in nfsd_lookup()
      NFSD: use explicit lock/unlock for directory ops
      NFSD: use (un)lock_inode instead of fh_(un)lock for file operations
      NFSD: discard fh_locked flag and fh_lock/fh_unlock


 fs/nfsd/acl.h       |   6 +-
 fs/nfsd/nfs2acl.c   |   6 +-
 fs/nfsd/nfs3acl.c   |   4 +-
 fs/nfsd/nfs3proc.c  |  25 ++---
 fs/nfsd/nfs4acl.c   |  46 ++-------
 fs/nfsd/nfs4proc.c  | 153 ++++++++++++-----------------
 fs/nfsd/nfs4state.c |  71 +++++++++++---
 fs/nfsd/nfsfh.c     |  22 ++++-
 fs/nfsd/nfsfh.h     |  58 +----------
 fs/nfsd/nfsproc.c   |  19 ++--
 fs/nfsd/vfs.c       | 230 +++++++++++++++++++++-----------------------
 fs/nfsd/vfs.h       |  31 ++++--
 fs/nfsd/xdr4.h      |   1 +
 13 files changed, 314 insertions(+), 358 deletions(-)

--
Signature

