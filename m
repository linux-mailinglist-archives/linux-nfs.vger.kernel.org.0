Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB5E567D06
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Jul 2022 06:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231361AbiGFETz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 6 Jul 2022 00:19:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbiGFETz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 6 Jul 2022 00:19:55 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62329167F4
        for <linux-nfs@vger.kernel.org>; Tue,  5 Jul 2022 21:19:53 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D231B1F8CB;
        Wed,  6 Jul 2022 04:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1657081191; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=AOWKGivkkop03mmfdhN7aSjFNyRtsb57nlFFbKyLAJo=;
        b=C/2CQIhI3u8PSziexiHLdPmHfElDO9hKrVMFR8wgsJnKyzNriMUVB08tgIw7GmPAUk/mVl
        nIlM39ozNXRfdKKX+MoBDxAqNG66Z22LI53fkUsE/h3A6kmFWd6eTCfrGERyR7sweL/bZj
        bB9oXjnbvpkp8+Net3+fY4C3rZfdxU8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1657081191;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=AOWKGivkkop03mmfdhN7aSjFNyRtsb57nlFFbKyLAJo=;
        b=C9ovImb4QgV9GjE4KPm50ndFaxVh80EG2kWt5b28+NrcToGaSi35FzrqMGlkJWdRDwqpG0
        cB8S8t0wIMMbrEBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BCED013A37;
        Wed,  6 Jul 2022 04:19:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id O1rWHWYNxWKTQQAAMHmgww
        (envelope-from <neilb@suse.de>); Wed, 06 Jul 2022 04:19:50 +0000
Subject: [PATCH 0/8] NFSD: clean up locking.
From:   NeilBrown <neilb@suse.de>
To:     Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     linux-nfs@vger.kernel.org
Date:   Wed, 06 Jul 2022 14:18:12 +1000
Message-ID: <165708033167.1940.3364591321728458949.stgit@noble.brown>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This series prepares NFSD to be able to adjust to work with a proposed
patch which allows updates to directories to happen in parallel.
This patch set changes the way directories are locked, so the present
series cleans up some locking in nfsd.

Specifically we remove fh_lock() and fh_unlock().
These functions are problematic for a few reasons.
- they are deliberately idempotent - setting or clearing a flag
  so that a second call does nothing.  This makes locking errors harder,
  but it results in code that looks wrong ...  and maybe sometimes is a
  little bit wrong.
  Early patches clean up several places where this idempotent nature of
  the functions is depended on, and so makes the code clearer.

- they transparently call fh_fill_pre/post_attrs(), including at times
  when this is not necessary.  Having the calls only when necessary is
  marginally more efficient, and arguably makes the code clearer.

nfsd_lookup() currently always locks the directory, though often no lock
is needed.  So a patch in this series reduces this locking.

There is an awkward case that could still be further improved.
NFSv4 open needs to ensure the file is not renamed (or unlinked etc)
between the moment when the open succeeds, and a later moment when a
"lease" is attached to support a delegation.  The handling of this lock
is currently untidy, particularly when creating a file.
It would probably be better to take a lease immediately after
opening the file, and then discarding if after deciding not to provide a
delegation.

I have run fstests and cthon tests on this, but I wouldn't be surprised
if there is a corner case that I've missed.

NeilBrown


---

NeilBrown (8):
      NFSD: drop rqstp arg to do_set_nfs4_acl()
      NFSD: change nfsd_create() to unlock directory before returning.
      NFSD: always drop directory lock in nfsd_unlink()
      NFSD: only call fh_unlock() once in nfsd_link()
      NFSD: reduce locking in nfsd_lookup()
      NFSD: use explicit lock/unlock for directory ops
      NFSD: use (un)lock_inode instead of fh_(un)lock for file operations
      NFSD: discard fh_locked flag and fh_lock/fh_unlock


 fs/nfsd/nfs2acl.c   |   6 +-
 fs/nfsd/nfs3acl.c   |   4 +-
 fs/nfsd/nfs3proc.c  |  21 ++---
 fs/nfsd/nfs4acl.c   |  19 ++---
 fs/nfsd/nfs4proc.c  | 106 +++++++++++++++---------
 fs/nfsd/nfs4state.c |   8 +-
 fs/nfsd/nfsfh.c     |   3 +-
 fs/nfsd/nfsfh.h     |  56 +------------
 fs/nfsd/nfsproc.c   |  14 ++--
 fs/nfsd/vfs.c       | 193 ++++++++++++++++++++++++++------------------
 fs/nfsd/vfs.h       |  19 +++--
 11 files changed, 238 insertions(+), 211 deletions(-)

--
Signature

