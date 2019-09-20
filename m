Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0488B8EF1
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Sep 2019 13:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438177AbfITLZ6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Sep 2019 07:25:58 -0400
Received: from mail-io1-f43.google.com ([209.85.166.43]:40465 "EHLO
        mail-io1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438173AbfITLZ6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Sep 2019 07:25:58 -0400
Received: by mail-io1-f43.google.com with SMTP id h144so15276018iof.7
        for <linux-nfs@vger.kernel.org>; Fri, 20 Sep 2019 04:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VZrKbzdxU387h76wC3NwBRGveE+UFgnDwEMlzw/LMS0=;
        b=tRDJi/OyZORWgjeBRKKm/vrNwFTIUQkOymaypR+qRpdC0KUrVVIswFeEkNd0ZyAaj8
         DcbZE3cR6DD6oM2xh7OFf8As/01cUVhpGWuBGlPQEuoK2wsIn40zCciviQ9FErOiM2RF
         se+NOI15wyBw7kLIs9rFxrFom+noKgnbnsKL5/wUbf9dCu52BoQWLdXJQUwH2xyysuWQ
         8zyLr0ERz4LvUowNJKZQ1b1LKy59B58PmsJ57Vx2Sj8z2X/bLk7vewdGfxIg15AHMVqa
         Efe9ggj8KG/a+c2Lg69JwY8M8VPgZtJ1Ve/dt+8hB9vkOq3HtdNVQPV8j3aoadnvnvYB
         9mVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VZrKbzdxU387h76wC3NwBRGveE+UFgnDwEMlzw/LMS0=;
        b=Df8kFrXN6yW3TOizZvqPQ3oZPQlLXJgfgMwxQ94v1oo1mohvW5LnDLXP2cKkeEwr7d
         2cx2cLuYuqJM3XRqu6YbkGxW4b9cIKUu8TXUgSFEX32WePulXIhjmS/XeagWMPxRzBjb
         5gbXfA3FoQZ49/0WaoayzElOO43hL9RnyGF9UVyvEg7w2vZguJWLJ74BVcNx4UCatnGo
         gWLnrm8miaCbbSaAUuHNEIjuAAYxFbazr7/XtQQhwmTr2yvhny8G7bZj+pXtZfnue3bu
         lrguia/pFQhsZJZWiIXXaQk5jdcMF7JuIy9jQMITfP2g7x0ZddLXqV58c5dMHuRmwBEU
         X7Mw==
X-Gm-Message-State: APjAAAXo6OB7ktm7QLoTeMVYui6BdT8PpkkU0+UrtUjNrc0Nou+V0Zyw
        G3EpVMoCPaj4qZ47ktpggcTf9+QxNQ==
X-Google-Smtp-Source: APXvYqzLhxQeIdio/mD6pMY5DglKkTpIeAhYhWqIg3rEb59UAcyx+/65ensOzQ6nVHhtKuxTcsrjvw==
X-Received: by 2002:a6b:6013:: with SMTP id r19mr18277099iog.94.1568978757342;
        Fri, 20 Sep 2019 04:25:57 -0700 (PDT)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id q74sm1308736iod.72.2019.09.20.04.25.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2019 04:25:56 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     Anna Schumaker <Anna.Schumaker@netapp.com>
Cc:     Olga Kornievskaia <aglo@umich.edu>, linux-nfs@vger.kernel.org
Subject: [PATCH v3 0/9] Various NFSv4 state error handling fixes
Date:   Fri, 20 Sep 2019 07:23:39 -0400
Message-Id: <20190920112348.69496-1-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Various NFSv4 fixes to ensure we handle state errors correctly. In
particular, we need to ensure that for COMPOUNDs like CLOSE and
DELEGRETURN, that may have an embedded LAYOUTRETURN, we handle the
layout state errors so that a retry of either the LAYOUTRETURN, or
the later CLOSE/DELEGRETURN does not corrupt the LAYOUTRETURN
reply.

Also ensure that if we get a NFS4ERR_OLD_STATEID, then we do our
best to still try to destroy the state on the server, in order to
avoid causing state leakage.

v2: Fix bug reports from Olga
 - Try to avoid sending old stateids on CLOSE/OPEN_DOWNGRADE when
   doing fully serialised NFSv4.0.
 - Ensure LOCKU initialises the stateid correctly.
v3: Fix locking
 - Ensure the patch "Handle NFS4ERR_OLD_STATEID in LOCKU" locks the
   stateid when copying it in nfs4_alloc_unlockdata().

Trond Myklebust (9):
  pNFS: Ensure we do clear the return-on-close layout stateid on fatal
    errors
  NFSv4: Clean up pNFS return-on-close error handling
  NFSv4: Handle NFS4ERR_DELAY correctly in return-on-close
  NFSv4: Handle RPC level errors in LAYOUTRETURN
  NFSv4: Add a helper to increment stateid seqids
  pNFS: Handle NFS4ERR_OLD_STATEID on layoutreturn by bumping the state
    seqid
  NFSv4: Fix OPEN_DOWNGRADE error handling
  NFSv4: Handle NFS4ERR_OLD_STATEID in CLOSE/OPEN_DOWNGRADE
  NFSv4: Handle NFS4ERR_OLD_STATEID in LOCKU

 fs/nfs/nfs4_fs.h   |  11 ++-
 fs/nfs/nfs4proc.c  | 209 +++++++++++++++++++++++++++++++--------------
 fs/nfs/nfs4state.c |  16 ----
 fs/nfs/pnfs.c      |  71 +++++++++++++--
 fs/nfs/pnfs.h      |  17 +++-
 5 files changed, 233 insertions(+), 91 deletions(-)

-- 
2.21.0

