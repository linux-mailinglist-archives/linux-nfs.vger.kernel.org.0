Return-Path: <linux-nfs+bounces-14793-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE15BAA95F
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Sep 2025 22:16:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D03D74E069C
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Sep 2025 20:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C6E92BAF9;
	Mon, 29 Sep 2025 20:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ATYzKefT"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6787A1EEE6
	for <linux-nfs@vger.kernel.org>; Mon, 29 Sep 2025 20:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759176985; cv=none; b=pzTFjmrTjU4sj5TJhbfnfIsdawrE7Jc+ZwX9ONBcNwYI6Loaa7/U9sZUe8tYtiFQ7xwdrYNbVfjf1c5Txu+9DiurSOI+GzCGrboTVWKoc5kh3LyP9k3rAIT8JT6hDZgc7gN4394WU0Q16kBf4uUxBlJj7KwPKIODcFEC9suH+iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759176985; c=relaxed/simple;
	bh=IbKVvz/qvlbTFuKsvi8J+gM+wwnAsf5+yL/sRwyVv0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bOWHTFvtGsFYaXENR7Yjlb6odU5j+zPFFdUdJh99BvtOOHjxF7L6QfRgf/Ablk09KZm3OC31YnwTBAY3i4Tigswq4QU9CXW0luxKA3LHCbzXF72h7YIG14AAOldjbRRlk4WlHWt86Oo4LFcXXMb5vU+YNQ3pL50ltaZv+V7/qQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ATYzKefT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78B02C4CEF4;
	Mon, 29 Sep 2025 20:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759176984;
	bh=IbKVvz/qvlbTFuKsvi8J+gM+wwnAsf5+yL/sRwyVv0Q=;
	h=From:To:Cc:Subject:Date:From;
	b=ATYzKefTFr5DjMjSbh94tSP3mDvLP+FwG3Gdi4FjP6f2r1yCkumYkTWvoXdRP+fGg
	 GEe6qVd4lwVEqknqmiXH7ojtYu87/Ey5klBC2pZ811NWIQrPLx81hIRBr+Tg/S7Fi+
	 bTedqjJ7t6OdJ21i+jygC70X7+1zDPqwHvbNBpsQ0CcLrW9jSugTUBwWZxryZSsnvI
	 3jN3zRQMD1Y0A1OBSZdSK1n9Ud/c1ScCFGnSeb+jvoLyrkku9LnHaaDfq6T2EluyXM
	 9+BIv1xSl0GHhzP2lMaHQno4yFFOhXlTTVT5TQL4No5guQ3xV0G4DIpOl9LvxB+oD0
	 YwHJkcRWYjWGg==
From: Chuck Lever <cel@kernel.org>
To: Calum Mackay <calum.mackay@oracle.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH] Add some tests for unsupported fattr4 attributes
Date: Mon, 29 Sep 2025 16:16:22 -0400
Message-ID: <20250929201622.37884-1-cel@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Linux NFSD does not implement a handful of these NFSv4.0 fattr4
attributes. Ensure that NFSD's fattr4 result encoder is correctly
clearing the result mask and returning NFS4_OK.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 nfs4.0/servertests/st_getattr.py | 149 +++++++++++++++++++++++++++++++
 1 file changed, 149 insertions(+)

diff --git a/nfs4.0/servertests/st_getattr.py b/nfs4.0/servertests/st_getattr.py
index 1c47ebf60571..d423aa1df46d 100644
--- a/nfs4.0/servertests/st_getattr.py
+++ b/nfs4.0/servertests/st_getattr.py
@@ -521,6 +521,155 @@ def testOwnerName(t, env):
         t.fail_support("owner not a supported attribute")
     # print(res.resarray[-1].obj_attributes)
 
+def testArchive(t, env):
+    """GETATTR on "archive" attribute
+
+    FLAGS: getattr all
+    DEPEND: LOOKFILE
+    CODE: GATT11a
+    """
+    c = env.c1
+    ops = c.use_obj(env.opts.usefile)
+    ops += [c.getattr([FATTR4_ARCHIVE])]
+    res = c.compound(ops)
+    check(res, [NFS4_OK, NFS4ERR_ATTRNOTSUPP], "GETATTR(archive)")
+    if res.status == NFS4ERR_ATTRNOTSUPP:
+        t.fail_support("archive not a supported attribute")
+
+def testHidden(t, env):
+    """GETATTR on "hidden" attribute
+
+    FLAGS: getattr all
+    DEPEND: LOOKFILE
+    CODE: GATT11b
+    """
+    c = env.c1
+    ops = c.use_obj(env.opts.usefile)
+    ops += [c.getattr([FATTR4_HIDDEN])]
+    res = c.compound(ops)
+    check(res, [NFS4_OK, NFS4ERR_ATTRNOTSUPP], "GETATTR(hidden)")
+    if res.status == NFS4ERR_ATTRNOTSUPP:
+        t.fail_support("hidden not a supported attribute")
+
+def testMimetype(t, env):
+    """GETATTR on "mimetype" attribute
+
+    FLAGS: getattr all
+    DEPEND: LOOKFILE
+    CODE: GATT11c
+    """
+    c = env.c1
+    ops = c.use_obj(env.opts.usefile)
+    ops += [c.getattr([FATTR4_MIMETYPE])]
+    res = c.compound(ops)
+    check(res, [NFS4_OK, NFS4ERR_ATTRNOTSUPP], "GETATTR(mimetype)")
+    if res.status == NFS4ERR_ATTRNOTSUPP:
+        t.fail_support("mimetype not a supported attribute")
+
+def testQuotaAvailHard(t, env):
+    """GETATTR on "quota avail hard" attribute
+
+    FLAGS: getattr all
+    DEPEND: LOOKFILE
+    CODE: GATT11d
+    """
+    c = env.c1
+    ops = c.use_obj(env.opts.usefile)
+    ops += [c.getattr([FATTR4_QUOTA_AVAIL_HARD])]
+    res = c.compound(ops)
+    check(res, [NFS4_OK, NFS4ERR_ATTRNOTSUPP], "GETATTR(quota_avail_hard)")
+    if res.status == NFS4ERR_ATTRNOTSUPP:
+        t.fail_support("quota_avail_hard not a supported attribute")
+
+def testQuotaAvailSoft(t, env):
+    """GETATTR on "quota avail soft" attribute
+
+    FLAGS: getattr all
+    DEPEND: LOOKFILE
+    CODE: GATT11e
+    """
+    c = env.c1
+    ops = c.use_obj(env.opts.usefile)
+    ops += [c.getattr([FATTR4_QUOTA_AVAIL_SOFT])]
+    res = c.compound(ops)
+    check(res, [NFS4_OK, NFS4ERR_ATTRNOTSUPP], "GETATTR(quota_avail_soft)")
+    if res.status == NFS4ERR_ATTRNOTSUPP:
+        t.fail_support("quota_avail_soft not a supported attribute")
+
+def testQuotaUsed(t, env):
+    """GETATTR on "quota used" attribute
+
+    FLAGS: getattr all
+    DEPEND: LOOKFILE
+    CODE: GATT11f
+    """
+    c = env.c1
+    ops = c.use_obj(env.opts.usefile)
+    ops += [c.getattr([FATTR4_QUOTA_USED])]
+    res = c.compound(ops)
+    check(res, [NFS4_OK, NFS4ERR_ATTRNOTSUPP], "GETATTR(quota_used)")
+    if res.status == NFS4ERR_ATTRNOTSUPP:
+        t.fail_support("quota_used not a supported attribute")
+
+def testSystem(t, env):
+    """GETATTR on "system" attribute
+
+    FLAGS: getattr all
+    DEPEND: LOOKFILE
+    CODE: GATT11g
+    """
+    c = env.c1
+    ops = c.use_obj(env.opts.usefile)
+    ops += [c.getattr([FATTR4_SYSTEM])]
+    res = c.compound(ops)
+    check(res, [NFS4_OK, NFS4ERR_ATTRNOTSUPP], "GETATTR(system)")
+    if res.status == NFS4ERR_ATTRNOTSUPP:
+        t.fail_support("system not a supported attribute")
+
+def testTimeBackup(t, env):
+    """GETATTR on "time backup" attribute
+
+    FLAGS: getattr all
+    DEPEND: LOOKFILE
+    CODE: GATT11h
+    """
+    c = env.c1
+    ops = c.use_obj(env.opts.usefile)
+    ops += [c.getattr([FATTR4_TIME_BACKUP])]
+    res = c.compound(ops)
+    check(res, [NFS4_OK, NFS4ERR_ATTRNOTSUPP], "GETATTR(time_backup)")
+    if res.status == NFS4ERR_ATTRNOTSUPP:
+        t.fail_support("time_backup not a supported attribute")
+
+def testTimeAccessSet(t, env):
+    """GETATTR on "time access set" attribute (write-only)
+
+    FLAGS: getattr all
+    DEPEND: LOOKFILE
+    CODE: GATT11i
+    """
+    c = env.c1
+    ops = c.use_obj(env.opts.usefile)
+    ops += [c.getattr([FATTR4_TIME_ACCESS_SET])]
+    res = c.compound(ops)
+    check(res, [NFS4ERR_INVAL, NFS4ERR_ATTRNOTSUPP], "GETATTR(time_access_set)")
+    if res.status == NFS4ERR_ATTRNOTSUPP:
+        t.fail_support("time_access_set not a supported attribute")
+
+def testTimeModifySet(t, env):
+    """GETATTR on "time modify set" attribute (write-only)
+
+    FLAGS: getattr all
+    DEPEND: LOOKFILE
+    CODE: GATT11j
+    """
+    c = env.c1
+    ops = c.use_obj(env.opts.usefile)
+    ops += [c.getattr([FATTR4_TIME_MODIFY_SET])]
+    res = c.compound(ops)
+    check(res, [NFS4ERR_INVAL, NFS4ERR_ATTRNOTSUPP], "GETATTR(time_modify_set)")
+    if res.status == NFS4ERR_ATTRNOTSUPP:
+        t.fail_support("time_modify_set not a supported attribute")
 
 ####################################################
 
-- 
2.51.0


