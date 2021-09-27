Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66D9D41A3EA
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Sep 2021 01:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238137AbhI0Xug (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 27 Sep 2021 19:50:36 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:43526 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237972AbhI0Xug (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 27 Sep 2021 19:50:36 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B6DA6222B3;
        Mon, 27 Sep 2021 23:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1632786536; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=ewSI48UGI/Hu36g1TvWmRrFCQ0/Lapc0J1Xzw9Rlhh0=;
        b=THtV2qyu6zOjEx5JOOhHbHZCGkEZ1MAVbVhmviMVNbMIbKokFppk8nT4vHCiqkQZXqMUFo
        oqkWVytrMOX7fNrU9UrYkOZy2ERJKgbXzy1Sz6PBaUzOXFIf1M0seEV/BDHX0cxT11N7nG
        QqwNyT75zrmSRVVc34JbpldlcB3eTNM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1632786536;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=ewSI48UGI/Hu36g1TvWmRrFCQ0/Lapc0J1Xzw9Rlhh0=;
        b=O0DnkI/gMyZ/lp64b3szzTP6bVNWzs57/8ogwg5lH1kSjjCEz+T8ljBubUKd6yHkdt5jOC
        YS8IT5xyNpuA4eDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 996BC13A5D;
        Mon, 27 Sep 2021 23:48:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id mgNXFWdYUmFwJQAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 27 Sep 2021 23:48:55 +0000
Subject: [PATCH 0/3] Don't store cred in nfs_access_entry
From:   NeilBrown <neilb@suse.de>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Date:   Tue, 28 Sep 2021 09:47:57 +1000
Message-ID: <163278643081.17728.10586733395858659759.stgit@noble.brown>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

It turns out that storing a counted ref to 'struct cred' in
nfs_access_entry wasn't a good choice.
'struct cred' contains counted references to 'struct key', and users
have a quota on how many keys they can have.  Keeping a cred in a cache
imposes on that quota.

The nfs access cache can keep a large number of entries, and keep them
indefinitely.  This can cause a user to go over-quota.

This series removes the 'struct cred *' from nfs_access_entry and
instead stores the uid, gid, and a pointer to the group info.
This makes the nfs_access_entry 64 bits larger.

Thanks,
NeilBrown

---

NeilBrown (3):
      NFS: change nfs_access_get_cached to only report the mask
      NFS: pass cred explicitly for access tests
      NFS: don't store 'struct cred *' in struct nfs_access_entry


 fs/nfs/dir.c            | 63 ++++++++++++++++++++++++++++++++++-------
 fs/nfs/nfs3proc.c       |  5 ++--
 fs/nfs/nfs4proc.c       | 13 +++++----
 include/linux/nfs_fs.h  |  6 ++--
 include/linux/nfs_xdr.h |  2 +-
 5 files changed, 67 insertions(+), 22 deletions(-)

--
Signature

