Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A887A453D46
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Nov 2021 01:47:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbhKQAuJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 16 Nov 2021 19:50:09 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:43320 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbhKQAuJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 16 Nov 2021 19:50:09 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2A7071FCA3;
        Wed, 17 Nov 2021 00:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1637110031; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=wzpyRjD1OPWOeb4lFIMTHqIABOoJxXFP+Ea8rYkdgSY=;
        b=Y6nvku9cQ+fshlRvWqASg+lZAIEAtpVHWZxyR8bkW7DGi3U0JBer8bclnLw1TBmLvJRj2A
        nz2bW1XFMJ5+5taALodRR6hssa0NxkckZ5Z2BNvQdlmD4sxqxU0inZO69JO6/i8WRb4FVH
        MMzqjavkA5GIWNaWaYrCFBp9IVRaz8k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1637110031;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=wzpyRjD1OPWOeb4lFIMTHqIABOoJxXFP+Ea8rYkdgSY=;
        b=3vPuinG1+7u+c/gxnMNv06HDlHUT5J5HpkioVWTQCtjcz1J4uZTkscra3by2U+QcBx8jQJ
        j4UtvM4GzDny4IDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 11C4D13BC1;
        Wed, 17 Nov 2021 00:47:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ffvtLw1RlGEfWgAAMHmgww
        (envelope-from <neilb@suse.de>); Wed, 17 Nov 2021 00:47:09 +0000
Subject: [PATCH 00/14] SUNRPC: clean up server thread management.
From:   NeilBrown <neilb@suse.de>
To:     "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Date:   Wed, 17 Nov 2021 11:46:49 +1100
Message-ID: <163710954700.5485.5622638225352156964.stgit@noble.brown>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

I have a dream of making nfsd threads start and stop dynamically.
This would free the admin of having to choose a number of threads to
start.
I'm not there yet, and I may never get there, but the current state of
the thread management code makes it harder to experiment than it needs
to be.  There is a lot of technical debt that needs to be repaid first.

This series addresses much of this debt.  There are three users of
service threads: nfsd, lockd, and nfs-callback.
nfs-callback, the newest, is quite clean.  This patch brings nfsd and
lockd up to a similar standard, and takes advantage of this increased
uniformity to simplify some shared interfaces.

It doesn't introduce any functionality improvements, and (as far as I
know) only fixes one minor bug (can you spot it?  If not, look at
c20106944eb6 and if you can see a second place that it could have
fixed).

Thanks for your review,
NeilBrown


---

NeilBrown (14):
      SUNRPC: stop using ->sv_nrthreads as a refcount
      nfsd: make nfsd_stats.th_cnt atomic_t
      NFSD: narrow nfsd_mutex protection in nfsd thread
      SUNRPC: use sv_lock to protect updates to sv_nrthreads.
      NFSD: Make it possible to use svc_set_num_threads_sync
      SUNRPC: discard svo_setup and rename svc_set_num_threads_sync()
      NFSD: simplify locking for network notifier.
      lockd: introduce nlmsvc_serv
      lockd: simplify management of network status notifiers
      lockd: move lockd_start_svc() call into lockd_create_svc()
      lockd: move svc_exit_thread() into the thread
      lockd: introduce lockd_put()
      lockd: rename lockd_create_svc() to lockd_get()
      lockd: use svc_set_num_threads() for thread start and stop


 fs/lockd/svc.c             | 190 ++++++++++++-------------------------
 fs/nfs/callback.c          |   8 +-
 fs/nfsd/netns.h            |   6 --
 fs/nfsd/nfsctl.c           |   2 -
 fs/nfsd/nfssvc.c           |  99 +++++++++----------
 fs/nfsd/stats.c            |   2 +-
 fs/nfsd/stats.h            |   4 +-
 include/linux/sunrpc/svc.h |  11 +--
 net/sunrpc/svc.c           |  61 ++----------
 9 files changed, 128 insertions(+), 255 deletions(-)

--
Signature

