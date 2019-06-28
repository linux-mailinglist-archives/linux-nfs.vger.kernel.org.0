Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD09559B92
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Jun 2019 14:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbfF1Mg7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 28 Jun 2019 08:36:59 -0400
Received: from mx3.molgen.mpg.de ([141.14.17.11]:39019 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726578AbfF1Mg7 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 28 Jun 2019 08:36:59 -0400
Received: from theinternet.molgen.mpg.de (theinternet.molgen.mpg.de [141.14.31.7])
        by mx.molgen.mpg.de (Postfix) with ESMTP id D4A152000C012;
        Fri, 28 Jun 2019 14:36:57 +0200 (CEST)
From:   Donald Buczek <buczek@molgen.mpg.de>
To:     linux-nfs@vger.kernel.org, trond.myklebust@hammerspace.com,
        anna.schumaker@netapp.com
Cc:     Donald Buczek <buczek@molgen.mpg.de>
Subject: [PATCH 0/4 RESEND] nfs4.0: Refetch lease_time after clientID reset
Date:   Fri, 28 Jun 2019 14:36:36 +0200
Message-Id: <20190628123640.8715-1-buczek@molgen.mpg.de>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

(rebased on linux-next)

We've noticed, that nfs mounts with vers=4.0 do not pick up a updated
lease_time after a restart of the nfs server. This was discussed in
the thread "4.0 client and server restart with decreased lease time" on
linux-nfs [1].

This patch set fixes the issue for nsf4.0 clients so that hey behave as
nfs4.1 and nfs4.2 clients do.  After a new clientID is established, the
lease_time is re-fetched and used.

I've notcied, that the flag NFS_CS_CHECK_LEASE_TIME is not functional in
the existing code. It is set and tested, but never reset. Either
nfs4_setup_state_renewal should reset the flag after it verified the
lease_time or the flag could be removed altogether. I left it as is,
because I don't known what is preferred.

[1] https://marc.info/?t=154954022700002&r=1&w=2

Donald Buczek (4):
  nfs: Fix copy-and-paste error in debug message
  nfs4: Rename nfs41_setup_state_renewal
  nfs4: Move nfs4_setup_state_renewal
  nfs4.0: Refetch lease_time after clientid update

 fs/nfs/nfs4state.c | 46 +++++++++++++++++++++++-----------------------
 fs/nfs/nfs4xdr.c   |  2 +-
 2 files changed, 24 insertions(+), 24 deletions(-)

-- 
2.21.0

