Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 515B4460E27
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Nov 2021 05:54:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240837AbhK2E5x (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 28 Nov 2021 23:57:53 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:60050 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233993AbhK2Ezx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 28 Nov 2021 23:55:53 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id CEC33212CC;
        Mon, 29 Nov 2021 04:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1638161555; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=35K5YgPxX5x6XnmMfkmqSEZsXuP7eLE+iO88B1AJJGY=;
        b=JtaFXwv0+w3HvYGYr4VZonwG96T5lBVuYvfk8u6dMDqr1GxHBh7scUVxMVpAbotnqjjV4t
        oAjAOHENqi9GK+89YG6CbudxERix4WGR4IzosgjOMkoDOUIxaSfL3sLrEWI6aIGZ4WFsT2
        3Ja5d7ZYFisXbJWH85xZIpCpxRj7Ye8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1638161555;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=35K5YgPxX5x6XnmMfkmqSEZsXuP7eLE+iO88B1AJJGY=;
        b=eU8tz481l/2sP4m1qL6lLZjdGOMTBZz+2x3hOhxnG8AIUCpUWA7YplmyhGEx72nW9kIP7t
        ensaa+SJYAw6EQBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A3462133FE;
        Mon, 29 Nov 2021 04:52:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2pmtFpJcpGHVbgAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 29 Nov 2021 04:52:34 +0000
Subject: [PATCH 00/20 v3] SUNRPC: clean up server thread management
From:   NeilBrown <neilb@suse.de>
To:     "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Date:   Mon, 29 Nov 2021 15:51:25 +1100
Message-ID: <163816133466.32298.13831616524908720974.stgit@noble.brown>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This is v3 of mt server thread management cleanup series.
changes include:
 - splitting out a couple of patches, and moving simple bugfix to the
   front.
 - Fixed a bug in previous series where lockd module count was being
   incremented when the lockd thread started, but not decremented when
   it exited.
 - minor improvement to patch descriptions.

Thanks for the review and testing!

NeilBrown

---

NeilBrown (20):
      NFSD: handle errors better in write_ports_addfd()
      SUNRPC: change svc_get() to return the svc.
      SUNRPC/NFSD: clean up get/put functions.
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


 fs/lockd/svc.c             | 200 +++++++++++--------------------------
 fs/nfs/callback.c          |  32 ++----
 fs/nfsd/netns.h            |  13 +--
 fs/nfsd/nfsctl.c           |  24 ++---
 fs/nfsd/nfsd.h             |   2 +-
 fs/nfsd/nfssvc.c           | 159 +++++++++++++++--------------
 fs/nfsd/stats.c            |   2 +-
 fs/nfsd/stats.h            |   4 +-
 include/linux/sunrpc/svc.h |  79 ++++++++-------
 net/sunrpc/svc.c           | 175 ++++++++++++++------------------
 10 files changed, 286 insertions(+), 404 deletions(-)

--
Signature

