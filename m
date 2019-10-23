Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57235E2733
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Oct 2019 01:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389801AbfJWX6M (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 23 Oct 2019 19:58:12 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:37801 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388872AbfJWX6M (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 23 Oct 2019 19:58:12 -0400
Received: by mail-il1-f195.google.com with SMTP id v2so209145ilq.4
        for <linux-nfs@vger.kernel.org>; Wed, 23 Oct 2019 16:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pkYdnqokRnukDcWatRjivO6EIQAJGmk2G6A5jkZBj0o=;
        b=QmBqhKliJbUNmfYuo4LOYHtXrpcQzFreK2K3U3aBYKcq0A7BPfeXMbfiib4IIkMPU1
         g4Ea0Uo0FNin9AFjIrxwtlvlR2kZoEVXEOgYrJefoFyf77gvFUinaxh8RnEnwGu+yVRB
         fLutJKXACuSsUILxz/PKdekjTkJZs+XKZj31C5BgX6q9HK7CkC/bvWF2/XhEAw27YY68
         uISOKyXnR+a7Eo2lN/utttDtDyhG0YwEJr9OkRtrYiAi8A2akgy/JP90S2HLW+ZCD68v
         t4mXvFtBv3bGSPx3JdWb4hFISiHEqfPoKyQ2IglxzHoFRL9syHkxPTMc67BwFpHoOLB3
         /PkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pkYdnqokRnukDcWatRjivO6EIQAJGmk2G6A5jkZBj0o=;
        b=HNpcrL1tgkIu0sm87O4v5yuzFzWOYacrum6lHm88SvXj/A3AiLIy1kn+4+iS+T1Zz0
         BkGBS0l0WEdyi0kOx5mh3MOtdO0C8GcjX9b26b2WWAOZrvEu8cP2RWJRSM4Yr/UtntPj
         HMn1g9ZrrlSh1fg/WpLAaIEPoYZ8GA/NZGUSSDpN5evIc0uqVkZZjJIGp44IozhcRCav
         N9fJC5AvIRPST+IYBqR5CFcvtaooUmbkVPV7KPzsNtjzyPgOOr9OlgVXru9vOgbznBd/
         mK9TNAX9+hl9xe+F2E1rJwU5lpDcRcXclbu9Twnkue9FJu8a7+7En3Z3Vlb57w8X7ew/
         8L7A==
X-Gm-Message-State: APjAAAXXsxANzTw/QHkkwW8X5pmyQ6NJVFoKP2h8p3G+mg4OIYKxADI5
        75IAOwvZyRdXkR/uyQvn9NUlsbg=
X-Google-Smtp-Source: APXvYqwLu52FPQgIsCnJAPrb28gG6On8oMW13curlki/AhThiUg7XE8IMrC/cZiukHAnoDs1k4tmWA==
X-Received: by 2002:a92:a308:: with SMTP id a8mr39762309ili.65.1571875089459;
        Wed, 23 Oct 2019 16:58:09 -0700 (PDT)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id z18sm2405409iob.47.2019.10.23.16.58.08
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 16:58:08 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 00/14] Delegation bugfixes
Date:   Wed, 23 Oct 2019 19:55:46 -0400
Message-Id: <20191023235600.10880-1-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The following patchset fixes up a number of issues with delegations,
but mainly attempts to fix a race condition between open and
delegreturn, where the open and the delegreturn get re-ordered so
that the delegreturn ends up revoking the delegation that was returned
by the open.
The root cause is that in certain circumstances, we may currently end
up freeing the delegation from delegreturn, so when we later receive
the reply to the open, we've lost track of the fact that the seqid
predates the one that was returned.

This patchset fixes that case by ensuring that we always keep track
of the last delegation stateid that was returned for any given inode.
That way, if we later see a delegation stateid with the same opaque
field, but an older seqid, we know we cannot trust it, and so we
ask to replay the OPEN compound.

Trond Myklebust (14):
  NFSv4: Don't allow a cached open with a revoked delegation
  NFSv4: Fix delegation handling in update_open_stateid()
  NFSv4: nfs4_callback_getattr() should ignore revoked delegations
  NFSv4: Delegation recalls should not find revoked delegations
  NFSv4: fail nfs4_refresh_delegation_stateid() when the delegation was
    revoked
  NFS: Rename nfs_inode_return_delegation_noreclaim()
  NFSv4: Don't remove the delegation from the super_list more than once
  NFSv4: Hold the delegation spinlock when updating the seqid
  NFSv4: Clear the NFS_DELEGATION_REVOKED flag in
    nfs_update_inplace_delegation()
  NFSv4: Update the stateid seqid in nfs_revoke_delegation()
  NFSv4: Revoke the delegation on success in nfs4_delegreturn_done()
  NFSv4: Ignore requests to return the delegation if it was revoked
  NFSv4: Don't reclaim delegations that have been returned or revoked
  NFSv4: Fix races between open and delegreturn

 fs/nfs/callback_proc.c |   2 +-
 fs/nfs/delegation.c    | 109 +++++++++++++++++++++++++++++------------
 fs/nfs/delegation.h    |   4 +-
 fs/nfs/nfs4proc.c      |  13 ++---
 fs/nfs/nfs4super.c     |   4 +-
 5 files changed, 88 insertions(+), 44 deletions(-)

-- 
2.21.0

