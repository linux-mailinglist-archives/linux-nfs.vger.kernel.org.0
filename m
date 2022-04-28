Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0D5B5128F1
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Apr 2022 03:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbiD1Blv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 27 Apr 2022 21:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiD1Blv (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 27 Apr 2022 21:41:51 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BA55771CA
        for <linux-nfs@vger.kernel.org>; Wed, 27 Apr 2022 18:38:38 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B347D210EE;
        Thu, 28 Apr 2022 01:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1651109916; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=dWdCkloDDbZZfSxDp0BsV56Kr7I7otqYJdvofs5VWdQ=;
        b=qHtgRW2gpTBJASLpc2Spq2v33nS5r0vDHt3BUPuPyKKWvNlbP32QLpReQhSrbuGFZDFsxB
        olptbHNgihwSlplcYjTnTTJUTuxS9mE6kY4NvE+nVjxkXNmuiuj8wYRKAjG38ruH9lb4LI
        j3zkhXtyYCaVDsojcwGyR3Do6KwowSQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1651109916;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=dWdCkloDDbZZfSxDp0BsV56Kr7I7otqYJdvofs5VWdQ=;
        b=bS+ggk6NFw/kJG+zpQB1au+p4OYu1HmKJw+Dm9tYq1AAysFqSHaR4Ip8osmimBbVpCeS90
        m8d+2iv0iEOv3+Cg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9E6AE13425;
        Thu, 28 Apr 2022 01:38:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id j6vKFhvwaWI9bQAAMHmgww
        (envelope-from <neilb@suse.de>); Thu, 28 Apr 2022 01:38:35 +0000
Subject: [PATCH 0/2] NFS: limit use of ACCESS cache for negative responses
From:   NeilBrown <neilb@suse.de>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>
Cc:     linux-nfs@vger.kernel.org
Date:   Thu, 28 Apr 2022 11:37:32 +1000
Message-ID: <165110909570.7595.8578730126480600782.stgit@noble.brown>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Since Commit 57b691819ee2 ("NFS: Cache access checks more aggressively")
(Linux 4.8) NFS has cached the results of ACCESS indefinitely while the
inode isn't changing.

This is often a good choice, but doesn't take into account the
possibility that changes out side of the inode can change effective
permissions.

Depending on configuration, some servers can map the user provided in
the RPC credential to a group list at time of request.  If the group
list for a user is changed, the result of ACCESS can change.

This is particularly a problem when extra permissions are given on the
server.  The client may make decisions based on outdated ACCESS results
and not even try operations which would in fact succeed.

These two patches change the ACCESS cache so that when the cache grants
an access, that is trusted indefinitely just as it currently does.
However when the cache denies an access, that is only trusted if the
cached data is less than acmin seconds old.  Otherwise a new ACCESS
request is made.

This allows additions to group membership to become effective with
only a modest delay.

The second patch contains even more explanatory detail.

Thanks,
NeilBrown

---

NeilBrown (2):
      NFS: change nfs_access_get_cached() to nfs_access_check_cached()
      NFS: limit use of ACCESS cache for negative responses


 fs/nfs/dir.c           | 80 +++++++++++++++++++++++++-----------------
 fs/nfs/nfs4proc.c      | 25 ++++++-------
 include/linux/nfs_fs.h |  5 +--
 3 files changed, 61 insertions(+), 49 deletions(-)

--
Signature

