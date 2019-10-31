Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4565CEB9DC
	for <lists+linux-nfs@lfdr.de>; Thu, 31 Oct 2019 23:43:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729527AbfJaWnb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 31 Oct 2019 18:43:31 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:42391 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728182AbfJaWnb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 31 Oct 2019 18:43:31 -0400
Received: by mail-yb1-f194.google.com with SMTP id 4so3103968ybq.9
        for <linux-nfs@vger.kernel.org>; Thu, 31 Oct 2019 15:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=EwYPYULTeO/0uNpMARXXa2UdlMr9jw2KBzS6WN4/c2U=;
        b=rxRrcLteyOLYpNV+SLZdaLTViFe8qQqT2w3QwmdUq++Pq20SK8Xh0glbGQkcEXX+9z
         ARnQXshOAlhOBNWMKmpwpt0KvXQGUeAjvsvG/AH5WL+neSLCwWdVhelDt74pOq86ytKs
         HfeZEfx2GzkGcSpvs6Jcem0mJE5CYSn83ouLSKBgV2RpZuaDSUNAAg4btSX8MPaRXM6d
         FtD/i/JXviuMbg2RhJdPrqOx3W/XKuYBvGvAMnsRJ57L12nl2dijb0BNgpTdN434XY9g
         YYJW80rgjavRV3x4/teqtIltmtlslyzzmxp5AdvPheGdZ+ZKAGpgLM9QjQmcMhDQOjXD
         Assw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EwYPYULTeO/0uNpMARXXa2UdlMr9jw2KBzS6WN4/c2U=;
        b=DMQaM1MKgzfg92q1BPx4olwJOrIgeaoXs4DkJijY7ZPmaTLEFSNZRUHXYcs6G3g+6V
         17xKuyJEUQ0/STc6BkNx9bHFJsDEWsAdeXHU2FzoxG1xpUMFh4bEDYfgwiGAMY2SE/Cr
         bpCkPSKbVeBr/r/z+0gv/BAWoO61OidtOgie3JsiHsPN05L3s63FxAu+P2DFQpND9xUt
         ZLt6F0D/8TJ4vR1FPSTHClcF0Q2dPEctKUUm74UTpRnx/Kf2k/0Up1q1llQpuabyBeA6
         9Fd8IdYjw7ZuXqCSmsppk31YuQUyAZYAe69ebgksRnuKOTblZhzK6F5lQr4Kz9f7Wk5x
         tJfA==
X-Gm-Message-State: APjAAAWulgfwJHgfgVDXt8gp+qyvTdpy+kOtlpBe4xFy0g0BGNuDDo20
        08B3L0bWz0d6zFB1c8QH5npE8Aw=
X-Google-Smtp-Source: APXvYqy7Euvi7qtHPnZLQ9IvYMA/ZAGQ0WVcgbT2OJuXs9QX/1bIxUsq4gLqcn1nfHwJZU5mVoLKvA==
X-Received: by 2002:a25:c586:: with SMTP id v128mr6691614ybe.387.1572561809473;
        Thu, 31 Oct 2019 15:43:29 -0700 (PDT)
Received: from localhost.localdomain ([50.105.87.1])
        by smtp.gmail.com with ESMTPSA id d192sm1720287ywb.3.2019.10.31.15.43.28
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2019 15:43:28 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 19/20] NFSv4: Handle NFS4ERR_OLD_STATEID in delegreturn
Date:   Thu, 31 Oct 2019 18:40:50 -0400
Message-Id: <20191031224051.8923-20-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191031224051.8923-19-trond.myklebust@hammerspace.com>
References: <20191031224051.8923-1-trond.myklebust@hammerspace.com>
 <20191031224051.8923-2-trond.myklebust@hammerspace.com>
 <20191031224051.8923-3-trond.myklebust@hammerspace.com>
 <20191031224051.8923-4-trond.myklebust@hammerspace.com>
 <20191031224051.8923-5-trond.myklebust@hammerspace.com>
 <20191031224051.8923-6-trond.myklebust@hammerspace.com>
 <20191031224051.8923-7-trond.myklebust@hammerspace.com>
 <20191031224051.8923-8-trond.myklebust@hammerspace.com>
 <20191031224051.8923-9-trond.myklebust@hammerspace.com>
 <20191031224051.8923-10-trond.myklebust@hammerspace.com>
 <20191031224051.8923-11-trond.myklebust@hammerspace.com>
 <20191031224051.8923-12-trond.myklebust@hammerspace.com>
 <20191031224051.8923-13-trond.myklebust@hammerspace.com>
 <20191031224051.8923-14-trond.myklebust@hammerspace.com>
 <20191031224051.8923-15-trond.myklebust@hammerspace.com>
 <20191031224051.8923-16-trond.myklebust@hammerspace.com>
 <20191031224051.8923-17-trond.myklebust@hammerspace.com>
 <20191031224051.8923-18-trond.myklebust@hammerspace.com>
 <20191031224051.8923-19-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

If the server returns NFS4ERR_OLD_STATEID in response to our delegreturn,
we want to sync to the most recent seqid for the delegation stateid. However
if we are already at the most recent, we have two possibilities:

- an OPEN reply is still outstanding and will return a new seqid
- an earlier OPEN reply was dropped on the floor due to a timeout.

In the latter case, we may end up unable to complete the delegreturn,
so we want to bump the seqid to a value greater than the cached value.
While this may cause us to lose the delegation in the former case,
it should now be safe to assume that the client will replay the OPEN
if necessary in order to get a new valid stateid.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/delegation.c | 1 +
 fs/nfs/nfs4proc.c   | 7 +++----
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
index 48f3c6c9672f..fe57b2b5314a 100644
--- a/fs/nfs/delegation.c
+++ b/fs/nfs/delegation.c
@@ -1252,6 +1252,7 @@ bool nfs4_refresh_delegation_stateid(nfs4_stateid *dst, struct inode *inode)
 	delegation = rcu_dereference(NFS_I(inode)->delegation);
 	if (delegation != NULL &&
 	    nfs4_stateid_match_other(dst, &delegation->stateid) &&
+	    nfs4_stateid_is_newer(&delegation->stateid, dst) &&
 	    !test_bit(NFS_DELEGATION_REVOKED, &delegation->flags)) {
 		dst->seqid = delegation->stateid.seqid;
 		ret = true;
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index c7e4a9ba8420..33a8e53e976c 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -6196,10 +6196,9 @@ static void nfs4_delegreturn_done(struct rpc_task *task, void *calldata)
 		task->tk_status = 0;
 		break;
 	case -NFS4ERR_OLD_STATEID:
-		if (nfs4_refresh_delegation_stateid(&data->stateid, data->inode))
-			goto out_restart;
-		task->tk_status = 0;
-		break;
+		if (!nfs4_refresh_delegation_stateid(&data->stateid, data->inode))
+			nfs4_stateid_seqid_inc(&data->stateid);
+		goto out_restart;
 	case -NFS4ERR_ACCESS:
 		if (data->args.bitmask) {
 			data->args.bitmask = NULL;
-- 
2.23.0

