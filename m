Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99D96467F96
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Dec 2021 22:55:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353908AbhLCV65 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 3 Dec 2021 16:58:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353907AbhLCV64 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 3 Dec 2021 16:58:56 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D4BBC061751
        for <linux-nfs@vger.kernel.org>; Fri,  3 Dec 2021 13:55:32 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 92AAD6463; Fri,  3 Dec 2021 16:55:31 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 92AAD6463
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1638568531;
        bh=+LFap4t2mWQdfnaPP/K9PX6O0tPPfg78n5LRvdGY+lg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h6Z8JI8t33AjmsV+YvjOUS8DVrc4gAigOZ2lB15PW++HZrXcMobmsl8DhUT/kkjm3
         Fy48OJQ1+Vcd3Qm6QpLa7TVUTW4nlLRQF+KMIgErTrLfXdU+0MD/uEa4FD4CEieoVG
         dlVPY0KebRryFXRhFtl7ZLUUidFqtbPYI1nWCuQU=
Date:   Fri, 3 Dec 2021 16:55:31 -0500
From:   Bruce Fields <bfields@fieldses.org>
To:     Steve Dickson <steved@redhat.com>
Cc:     dai.ngo@oracle.com, linux-nfs@vger.kernel.org
Subject: [PATCH] nfsdcld: use WAL journal for faster commits
Message-ID: <20211203215531.GC3930@fieldses.org>
References: <22000fe0-9b17-3d88-1730-c8704417cb92@oracle.com>
 <B42B0F9C-57E2-4F58-8DBD-277636B92607@oracle.com>
 <6f5a060d-17f6-ee46-6546-1217ac5dfa9c@oracle.com>
 <20211130153211.GB8837@fieldses.org>
 <f6a948a7-32d6-da9a-6808-9f2f77d5f792@oracle.com>
 <20211201143630.GB24991@fieldses.org>
 <20211201174205.GB26415@fieldses.org>
 <20211201180339.GC26415@fieldses.org>
 <20211201195050.GE26415@fieldses.org>
 <20211203212200.GB3930@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211203212200.GB3930@fieldses.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: "J. Bruce Fields" <bfields@redhat.com>

Currently nfsdcld is doing three fdatasyncs for each upcall.  Based on
SQLite documentation, WAL mode should also be safe, and I can confirm
from an strace that it results in only one fdatasync each.

This may be a bottleneck e.g. when lots of clients are being created or
expired at once (e.g. on reboot).

Not bothering with error checking, as this is just an optimization and
nfsdcld will still function without.  (Might be better to log something
on failure, though.)

Signed-off-by: J. Bruce Fields <bfields@redhat.com>
---
 utils/nfsdcld/sqlite.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/utils/nfsdcld/sqlite.c b/utils/nfsdcld/sqlite.c
index 03016fb95823..b248eeffa204 100644
--- a/utils/nfsdcld/sqlite.c
+++ b/utils/nfsdcld/sqlite.c
@@ -826,6 +826,9 @@ sqlite_prepare_dbh(const char *topdir)
 		goto out_close;
 	}
 
+	sqlite3_exec(dbh, "PRAGMA journal_mode = WAL;", NULL, NULL, NULL);
+	sqlite3_exec(dbh, "PRAGMA synchronous = FULL;", NULL, NULL, NULL);
+
 	ret = sqlite_query_schema_version();
 	switch (ret) {
 	case CLD_SQLITE_LATEST_SCHEMA_VERSION:
-- 
2.33.1

