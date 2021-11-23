Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC6B4599BB
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Nov 2021 02:30:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbhKWBeD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 22 Nov 2021 20:34:03 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:57770 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbhKWBeD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 22 Nov 2021 20:34:03 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 630FA218B2;
        Tue, 23 Nov 2021 01:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1637631055; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=kSKNHNBuywMFjn0Loc58mFyuV0OYRXvVnXRusEgMqDg=;
        b=jUgxt2LMjmAwmCghcbE62LPolL/xJNhZkLBjA1s3wi8JSJe+POiASQrAs5mnXrvZX9aHut
        rxwgA2b5NBbtit/hkCW4Br6Af9F3xXKAY1feshA1nIKGIRsl3EJBkr+qFfp1XdQfSxQ8os
        l5JHY/6WAjJbtc8CK+Hc6bCeyVT7hX8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1637631055;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=kSKNHNBuywMFjn0Loc58mFyuV0OYRXvVnXRusEgMqDg=;
        b=JjMx5zTv391rq4dV2zHZDZ+bpnZ3O8bs/wMIiV3i28hYb3UKeBvKFjVtdScOaFj3MOBmhD
        SRmGHVJbI9ERxnBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3E5E213BD4;
        Tue, 23 Nov 2021 01:30:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id knj5OU1EnGGdcwAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 23 Nov 2021 01:30:53 +0000
Subject: [PATCH 00/19 v2] SUNRPC: clean up server thread management
From:   NeilBrown <neilb@suse.de>
To:     "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Date:   Tue, 23 Nov 2021 12:29:35 +1100
Message-ID: <163763078330.7284.10141477742275086758.stgit@noble.brown>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This is a revision of my series for cleaning up server thread
management.
Currently lockd, nfsd, and nfs-callback all manage threads slightly
differently.  This series unifies them.

Changes since first series include:
  - minor bug fixes
  - kernel-doc comments for new functions
  - split first patch into 3, and make the bugfix a separate patch
  - fix management of pool_maps so lockd can usse svc_set_num_threads
    safely
  - switch nfs-callback to not request a 'pooled' service.

NeilBrown


---

NeilBrown (19):
      SUNRPC/NFSD: clean up get/put functions.
      NFSD: handle error better in write_ports_addfd()
      SUNRPC: stop using ->sv_nrthreads as a refcount
      nfsd: make nfsd_stats.th_cnt atomic_t
      SUNRPC: use sv_lock to protect updates to sv_nrthreads.
      NFSD: narrow nfsd_mutex protection in nfsd thread
      NFSD: Make it possible to use svc_set_num_threads_sync
      SUNRPC: discard svo_setup and rename svc_set_num_threads_sync()
      NFSD: simplify locking for network notifier.
      lockd: introduce nlmsvc_serv
      lockd: simplify management of network status notifiers
      lockd: move lockd_start_svc() call into lockd_create_svc()
      lockd: move svc_exit_thread() into the thread
      lockd: introduce lockd_put()
      lockd: rename lockd_create_svc() to lockd_get()
      SUNRPC: move the pool_map definitions (back) into svc.c
      SUNRPC: always treat sv_nrpools==1 as "not pooled"
      lockd: use svc_set_num_threads() for thread start and stop
      NFS: switch the callback service back to non-pooled.


 fs/lockd/svc.c             | 194 ++++++++++++-------------------------
 fs/nfs/callback.c          |  12 +--
 fs/nfsd/netns.h            |  13 +--
 fs/nfsd/nfsctl.c           |  24 ++---
 fs/nfsd/nfssvc.c           | 139 +++++++++++++-------------
 fs/nfsd/stats.c            |   2 +-
 fs/nfsd/stats.h            |   4 +-
 include/linux/sunrpc/svc.h |  58 ++++-------
 net/sunrpc/svc.c           | 166 ++++++++++++++-----------------
 9 files changed, 248 insertions(+), 364 deletions(-)

--
Signature

