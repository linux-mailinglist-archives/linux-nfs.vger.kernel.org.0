Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9EBB6EB9C9
	for <lists+linux-nfs@lfdr.de>; Thu, 31 Oct 2019 23:43:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbfJaWnE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 31 Oct 2019 18:43:04 -0400
Received: from mail-yb1-f177.google.com ([209.85.219.177]:37758 "EHLO
        mail-yb1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbfJaWnE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 31 Oct 2019 18:43:04 -0400
Received: by mail-yb1-f177.google.com with SMTP id z125so3112393ybc.4
        for <linux-nfs@vger.kernel.org>; Thu, 31 Oct 2019 15:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h4M0nLoOKStfF4Ekjo1jl1kOx6PTtsWhvoRYjqFsdv0=;
        b=S6KYWjUvkpeFn2656gkoe3qtkRW4BCQ3liDqzBfKjshS1RXkGJiMiy5NjnfTtjMbV6
         M3lNVCdtYc5pc5IOlzH8AMFtBI/1AuIDP1INdIQxgfBJ66IFwjL1pa4exYwpsFKL7arC
         A9xjwexFGmbyqgg0OM1ywzIDAXgjrD6882Y33Fqb2kGqf4ZiqOHuIKsGHXxuYgkdGWDL
         RiMYwFKViM+RJareWQg06Fw+7PuwcXqrZMMFFCEli7p4jegVbf8QRPeIy0a6jSKHfJae
         tes9IhCE1FoVFjUJSIeTYmftP+NiZ3IrHH+edSJpmxiYiQwMxW9bEguG22UnsqXoqwCY
         blkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h4M0nLoOKStfF4Ekjo1jl1kOx6PTtsWhvoRYjqFsdv0=;
        b=cIHPWgWrqzEFP5KCsemlSrM7bLsmi8Phxgl1duflLv/fYFLUSJ/ZOoVRTS822eJJPD
         0GvCOOFGxiAl1nkGgVlTcJ7W8Ngtr5L8tqLoJ0JH7AoN4ks5ojJsNessGhPE34RhQRhB
         OCKdIh6Vmb0C7oSS8bsPqJ+nvVsKedxcuondBHl7mWKm/WGSLQdWqZKhyNlh5Xgv5AbC
         ioBFp9jfJ1B6YxfzHTSEsGZtuoGIHxO+CIBU8RLNZlXI99jZssEM5XxkA893IHpkxKtr
         mQZO8hO53f1alR4UCcNo4UVjtp7Ozjy4NjDjR3dWsh/uwjSR8LBWmIOQUJJYPeTLQjqa
         cSMw==
X-Gm-Message-State: APjAAAUMLIjb+1jWYYKlG+RBP9FO5XhT8sY4CfaRwaK+ininlKdJVKgM
        rCC99GD3YJUS2PqsuXOQkiVoPok=
X-Google-Smtp-Source: APXvYqywI4bBVJ0tkygVXtR91BlGVHhaCI5h83uPv7bmYGqH3CTkb5mpf6zU+jeYcb4cwddIVFZ+8w==
X-Received: by 2002:a5b:8cb:: with SMTP id w11mr6887728ybq.9.1572561782381;
        Thu, 31 Oct 2019 15:43:02 -0700 (PDT)
Received: from localhost.localdomain ([50.105.87.1])
        by smtp.gmail.com with ESMTPSA id d192sm1720287ywb.3.2019.10.31.15.43.00
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2019 15:43:01 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 00/20] Delegation bugfixes
Date:   Thu, 31 Oct 2019 18:40:31 -0400
Message-Id: <20191031224051.8923-1-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.23.0
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

Trond Myklebust (20):
  NFSv4: Don't allow a cached open with a revoked delegation
  NFS: Fix an RCU lock leak in nfs4_refresh_delegation_stateid()
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
  NFSv4: nfs4_return_incompatible_delegation() should check delegation
    validity
  NFSv4: Fix nfs4_inode_make_writeable()
  NFS: nfs_inode_find_state_and_recover() fix stateid matching
  NFSv4: Fix races between open and delegreturn
  NFSv4: Handle NFS4ERR_OLD_STATEID in delegreturn
  NFSv4: Don't retry the GETATTR on old stateid in
    nfs4_delegreturn_done()

 fs/nfs/callback_proc.c |   4 +-
 fs/nfs/delegation.c    | 170 +++++++++++++++++++++++++++++------------
 fs/nfs/delegation.h    |   4 +-
 fs/nfs/nfs4_fs.h       |   6 ++
 fs/nfs/nfs4proc.c      |  25 +++---
 fs/nfs/nfs4state.c     |   7 +-
 fs/nfs/nfs4super.c     |   4 +-
 7 files changed, 151 insertions(+), 69 deletions(-)

-- 
2.23.0

