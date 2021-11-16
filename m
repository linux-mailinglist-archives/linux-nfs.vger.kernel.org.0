Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC13F4527EA
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Nov 2021 03:47:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239042AbhKPCuc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 15 Nov 2021 21:50:32 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:37292 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356826AbhKPCs1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 15 Nov 2021 21:48:27 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id EED111FD47;
        Tue, 16 Nov 2021 02:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1637030726; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=STuKPK8oZgtzlQ4TzQCaIEO4WItR+O1Pk/1ubRhrUlo=;
        b=ZCw8oIvZtxNtv4c+HmVtPJpEbXwIaN63nTDizauf48LPH/v7Mjo7rKwBrFfBZn63AC4StO
        PE4GztE7Xc8RXSgsFSJVJ76414RoAMIBbhaKYPWURVN9SNj26rp84CbVYkRKrfVr3p+mhg
        w5x9wbEeJT4RY853YvZ8tCTrCgAUb0Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1637030726;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=STuKPK8oZgtzlQ4TzQCaIEO4WItR+O1Pk/1ubRhrUlo=;
        b=5BGexwnp1XLU+pa89ep9cuEGHTTW3PysChT7qH1Aza20mJSBwF/2Zyi4j7usu3YsUPwB6/
        LuxAgAHhgtfAQ1BA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 97E9313B70;
        Tue, 16 Nov 2021 02:45:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id AG6oFUQbk2G5CAAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 16 Nov 2021 02:45:24 +0000
Subject: [PATCH 00/13] Repair SWAP-over-NFS
From:   NeilBrown <neilb@suse.de>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>
Cc:     linux-nfs@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 16 Nov 2021 13:44:04 +1100
Message-ID: <163702956672.25805.16457749992977493579.stgit@noble.brown>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

swap-over-NFS currently has a variety of problems.

Due to a newish test in generic_write_checks(), all writes to swap
currently fail.
With that fixed, there are various sources of deadlocks that can cause
a swapping system to freeze.

swap has never worked over NFSv4 due to the occasional need to start the
state-management thread - which won't happen when under high memory
pressure.

This series addresses all the problems that I could find, and also
changes writes to be asynchronous, and both reads and writes to use
multi-page RPC requests when possible (the last 2 patches).

This last change causes interesting performance changes.  The rate of
writes to the swap file (measured in K/sec) increases by a factor of
about 5 (not precisely measured).  However interactive response falls
noticeably (response time in multiple seconds, but not minutes).  So
while it seems like it should be a good idea, I'm not sure if we want it
until it is better understood.

I'd be very happy if others could test out some swapping scenarios to
see how it performs.  I've been using
    stress-ng --brk 2 --stack 2 --bigheap 2
which doesn't give me any insight into whether more useful work is
getting done.

Apart from the last two patches, I think this series is ready.

Thanks,
NeilBrown

---

NeilBrown (13):
      NFS: move generic_write_checks() call from nfs_file_direct_write() to nfs_file_write()
      NFS: do not take i_rwsem for swap IO
      MM: reclaim mustn't enter FS for swap-over-NFS
      SUNRPC/call_alloc: async tasks mustn't block waiting for memory
      SUNRPC/auth: async tasks mustn't block waiting for memory
      SUNRPC/xprt: async tasks mustn't block waiting for memory
      SUNRPC: remove scheduling boost for "SWAPPER" tasks.
      NFS: discard NFS_RPC_SWAPFLAGS and RPC_TASK_ROOTCREDS
      SUNRPC: improve 'swap' handling: scheduling and PF_MEMALLOC
      NFSv4: keep state manager thread active if swap is enabled
      NFS: swap-out must always use STABLE writes.
      MM: use AIO/DIO for reads from SWP_FS_OPS swap-space
      MM: use AIO for DIO writes to swap


 fs/nfs/direct.c                 |  12 +-
 fs/nfs/file.c                   |  21 ++-
 fs/nfs/io.c                     |   9 ++
 fs/nfs/nfs4_fs.h                |   1 +
 fs/nfs/nfs4proc.c               |  20 +++
 fs/nfs/nfs4state.c              |  39 ++++-
 fs/nfs/read.c                   |   4 -
 fs/nfs/write.c                  |   2 +
 include/linux/nfs_fs.h          |   8 +-
 include/linux/nfs_xdr.h         |   2 +
 include/linux/sunrpc/auth.h     |   1 +
 include/linux/sunrpc/sched.h    |   1 -
 include/trace/events/sunrpc.h   |   1 -
 mm/page_io.c                    | 243 +++++++++++++++++++++++++++-----
 mm/vmscan.c                     |  12 +-
 net/sunrpc/auth.c               |   8 +-
 net/sunrpc/auth_gss/auth_gss.c  |   6 +-
 net/sunrpc/auth_unix.c          |  10 +-
 net/sunrpc/clnt.c               |   7 +-
 net/sunrpc/sched.c              |  29 ++--
 net/sunrpc/xprt.c               |  19 +--
 net/sunrpc/xprtrdma/transport.c |  10 +-
 net/sunrpc/xprtsock.c           |   8 ++
 23 files changed, 374 insertions(+), 99 deletions(-)

--
Signature

