Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49E34E2732
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Oct 2019 01:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbfJWX6L (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 23 Oct 2019 19:58:11 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:44487 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbfJWX6L (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 23 Oct 2019 19:58:11 -0400
Received: by mail-il1-f194.google.com with SMTP id f13so20628939ils.11
        for <linux-nfs@vger.kernel.org>; Wed, 23 Oct 2019 16:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=JHWq1+nQ3vKrCj1F2y6oUgBDKRRyOYQaLQciB12XliA=;
        b=aywqOgpjubZhIVDtyLSKjSbQifGTNhYfUsfiT5NlU/0TySC2EOmHslp2wK0IaM/xrN
         y0rGdzXol1YJIcqZMh4dtOD+GZv8iw7pY+KkrmD3g4nQSE0SE6ni/ZhRQLEy42vSsNan
         vM6INfOXYfoJwH3qL5mrsjhGzI3ePZtDtXsCqHMRoT7lUVtyD5piBwoSy14XCISBbUHY
         FdOs3sX8KndOc0JS5nYeGSjj2xw6yTg8RQBaLNs9TODQbdOJA9cDX2lg1N2aP5QSQnr4
         ZJQj8OcIQw5kUVygiiCmbHczi1b3AHzgenNwplYhs2FXrJpgjSrNs6xUgKBm+PTjOfFq
         Xo4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JHWq1+nQ3vKrCj1F2y6oUgBDKRRyOYQaLQciB12XliA=;
        b=E3rM8XFzMWlJdVQnage+7keW4gqz0ELbpImPEZwLqvjaluFl7PDWCHRMqq0wuSeLbA
         J86GCKcKo7sQPLF93H58yQ2Y70TiXs2tPQesob//Q5U9QfovTvCg2syKXmwF+VjPggfh
         jBenaleE9w1wIBaOXFRULKop4GhHx11ruKMceY19qk9ZAuLtFKVV+w4FzKaRTXtALqZA
         strrYAViwf8Oax01D3ZH797DdKmCT+3BU1Uqirg5sBDRthx0SG4kIoIUp58Djli6hcdo
         nTrgvu/T5BgApHKZ5Tq8bCjenvZS9tNWxmZ/pWMmn0nowQgDRF68wqsfgCYdjznMEYyo
         r5kA==
X-Gm-Message-State: APjAAAXZVJCHSK7TzKnNOnXvc+FzNvn8WZla6QucGr0GCxVDvfTzV+Nu
        StYKrXY0pV4hpdlspRqUoLLiyXQ=
X-Google-Smtp-Source: APXvYqwpQ8elE/BR6UkRN5kky/PLDdL4+DfsO02V/a7tVI4XSEOQ5dEg9NuIt7jfd8bsPGohMXTyCA==
X-Received: by 2002:a92:3985:: with SMTP id h5mr22755189ilf.251.1571875090121;
        Wed, 23 Oct 2019 16:58:10 -0700 (PDT)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id z18sm2405409iob.47.2019.10.23.16.58.09
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 16:58:09 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 01/14] NFSv4: Don't allow a cached open with a revoked delegation
Date:   Wed, 23 Oct 2019 19:55:47 -0400
Message-Id: <20191023235600.10880-2-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191023235600.10880-1-trond.myklebust@hammerspace.com>
References: <20191023235600.10880-1-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

If the delegation is marked as being revoked, we must not use it
for cached opens.

Fixes: 869f9dfa4d6d ("NFSv4: Fix races between nfs_remove_bad_delegation() and delegation return")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/delegation.c | 3 +--
 fs/nfs/delegation.h | 1 +
 fs/nfs/nfs4proc.c   | 6 +-----
 3 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
index 071b90a45933..5f3eea926af5 100644
--- a/fs/nfs/delegation.c
+++ b/fs/nfs/delegation.c
@@ -42,8 +42,7 @@ void nfs_mark_delegation_referenced(struct nfs_delegation *delegation)
 	set_bit(NFS_DELEGATION_REFERENCED, &delegation->flags);
 }
 
-static bool
-nfs4_is_valid_delegation(const struct nfs_delegation *delegation,
+bool nfs4_is_valid_delegation(const struct nfs_delegation *delegation,
 		fmode_t flags)
 {
 	if (delegation != NULL && (delegation->type & flags) == flags &&
diff --git a/fs/nfs/delegation.h b/fs/nfs/delegation.h
index 9eb87ae4c982..2b35a99929a0 100644
--- a/fs/nfs/delegation.h
+++ b/fs/nfs/delegation.h
@@ -69,6 +69,7 @@ bool nfs4_copy_delegation_stateid(struct inode *inode, fmode_t flags, nfs4_state
 bool nfs4_refresh_delegation_stateid(nfs4_stateid *dst, struct inode *inode);
 
 void nfs_mark_delegation_referenced(struct nfs_delegation *delegation);
+bool nfs4_is_valid_delegation(const struct nfs_delegation *delegation, fmode_t flags);
 int nfs4_have_delegation(struct inode *inode, fmode_t flags);
 int nfs4_check_delegation(struct inode *inode, fmode_t flags);
 bool nfs4_delegation_flush_on_close(const struct inode *inode);
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index ab8ca20fd579..294ea8c1a163 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -1436,11 +1436,7 @@ static int can_open_cached(struct nfs4_state *state, fmode_t mode,
 static int can_open_delegated(struct nfs_delegation *delegation, fmode_t fmode,
 		enum open_claim_type4 claim)
 {
-	if (delegation == NULL)
-		return 0;
-	if ((delegation->type & fmode) != fmode)
-		return 0;
-	if (test_bit(NFS_DELEGATION_RETURNING, &delegation->flags))
+	if (!nfs4_is_valid_delegation(delegation, fmode))
 		return 0;
 	switch (claim) {
 	case NFS4_OPEN_CLAIM_NULL:
-- 
2.21.0

