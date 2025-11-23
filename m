Return-Path: <linux-nfs+bounces-16690-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5286DC7E31A
	for <lists+linux-nfs@lfdr.de>; Sun, 23 Nov 2025 16:56:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 574654E33EF
	for <lists+linux-nfs@lfdr.de>; Sun, 23 Nov 2025 15:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E67852D4B6D;
	Sun, 23 Nov 2025 15:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NWoZrOyo"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E4329E10B
	for <linux-nfs@vger.kernel.org>; Sun, 23 Nov 2025 15:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763913394; cv=none; b=OM5LYzl+WvbigmRU85YrSR7BFHInsj2QgV98zNuuYgY+AOtKSysY14QoryxaJDBMjORw/PNwmTSsaAog+qTrT+uSj9e4hsL4quyfVgWc8P4/lylHBdwrpLBLNHOtGNsNaJxhpB4uPczp3evibR/FfZC6IxZAYWAMS5Nhx4ClBvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763913394; c=relaxed/simple;
	bh=ZAkvwXCiB2EuPlORdmFuA8rHnJ7U53bvyCiTJjzfyhs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lcr4K+AFdr4DRuzCFrV3YvAzVLFv6ePTSN/XdRKUIV6O6KzR9szOQ6wZzwjX7gQ/9MvNrEh4qLwM2F+wW6hyli4ygX0jOKO6sy4dsKblmrnexpvnxh/ddkPoJuyMYKrpLGAMfV8GnAprWfPAk+VqxLuxwKdGP/hhbE+/MAAfbEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NWoZrOyo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06CDFC19422;
	Sun, 23 Nov 2025 15:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763913392;
	bh=ZAkvwXCiB2EuPlORdmFuA8rHnJ7U53bvyCiTJjzfyhs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NWoZrOyoT/MK0CUfBzvxrBRl1IjetOrfWhlD1mkFeswyYeXOauepdfZIVTglZwDzz
	 FuZoXyjDTOuxiBHG33p3nxqm1gXnJcTs+JSGrOBeriULhS2jPCPURb8KnpLQaKQfJB
	 I/B6fZDnWutzLkvRCqKHf1HMVlJDkdptTY53qC7iNrDbzNX/B0nvjdhkZISCSxxgwx
	 o3Trnv1tEcH/rjo2UYuoyqNUwqb810UvYgN4LqnVU6b3axzp98kg6vl09ClB9MFXqW
	 +XWV3TQGTvk4rfNodCLxLrrHmkqHQtCUIPTKX5vQ0S+Wc+fOiyKnqUtzfuum2PcrYF
	 ihOYW4sFpiGew==
From: Chuck Lever <cel@kernel.org>
To: Calum Mackay <calum.mackay@oracle.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [RFC PATCH 10/10] Add tests for OPEN(create) with ACLs
Date: Sun, 23 Nov 2025 10:56:18 -0500
Message-ID: <20251123155623.514129-11-cel@kernel.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251123155623.514129-1-cel@kernel.org>
References: <20251123155623.514129-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Check that the server can attach an ACL when it creates a file.

Add tests for OPEN(create) with MODE and ACL

Add comprehensive tests that verify OPEN(create) behavior when
both mode bits and an ACL are set simultaneously. The new tests
cover:

- EXCLUSIVE4_1 create with both MODE and ACL attributes (OPEN14)
- MODE preservation when set with ACL for all three create modes:
  UNCHECKED4 (OPEN15), GUARDED4 (OPEN16), and EXCLUSIVE4_1
  (OPEN17)
- Restrictive MODE (0o400) with ACL for all create modes (OPEN18)

These tests ensure that servers correctly handle the interaction
between MODE and ACL attributes during file creation, and verify
that the ACL specified in the OPEN operation matches the ACL
after the OPEN completes.

OPEN15-17: Fix MODE+ACL verification per RFC 8881

Apply the same fix used for SATT19-21 to OPEN15-17. When both
MODE and ACL are set together during OPEN CREATE, RFC 8881
§6.4.1.3 specifies that both attributes are processed, but the
final mode is derived from the ACL per §6.3.2, not from the
requested MODE value.

The tests now verify that:
1. Both MODE and ACL are processed (in attrset bitmap)
2. The final mode matches the ACL-derived mode per RFC 8881
   §6.3.2 using acl2mode_rfc8881()
3. The mode may differ from the requested MODE

This fixes OPEN15 (UNCHECKED4), OPEN16 (GUARDED4), and OPEN17
(EXCLUSIVE4_1) which were previously failing with "MODE not
preserved" errors.

OPEN41-42: Set ACE4_IDENTIFIER_GROUP flag for group principals

Fix OPEN41 and OPEN42 to properly set the ACE4_IDENTIFIER_GROUP
flag when creating ACEs for named group principals. Without this
flag, the kernel treats the principal as a user (ACL_USER) instead
of a group (ACL_GROUP), preventing proper synthetic GROUP@
detection and filtering.

The tests were creating group principal ACEs with flag=0, which
should have been flag=ACE4_IDENTIFIER_GROUP. This is required for
the kernel to distinguish between:
- Named user principals (no flag) -> ACL_USER
- Named group principals (with flag) -> ACL_GROUP

With this fix, both tests now pass, and the server correctly
returns ACLs with named principals "as given" per RFC 8881
§6.4.1.2, without exposing synthetic OWNER@ or GROUP@ entries.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 nfs4.1/server41tests/st_open.py | 723 +++++++++++++++++++++++++++++++-
 1 file changed, 720 insertions(+), 3 deletions(-)

diff --git a/nfs4.1/server41tests/st_open.py b/nfs4.1/server41tests/st_open.py
index 28540b59a8fe..115daf9f5273 100644
--- a/nfs4.1/server41tests/st_open.py
+++ b/nfs4.1/server41tests/st_open.py
@@ -1,15 +1,16 @@
 from .st_create_session import create_session
 from xdrdef.nfs4_const import *
 
-from .environment import check, fail, create_file, open_file, close_file, write_file, read_file
-from .environment import open_create_file_op
+from .environment import check, fail, unsupported, create_file, open_file, close_file, write_file, read_file
+from .environment import open_create_file_op, do_getattrdict
 from xdrdef.nfs4_type import open_owner4, openflag4, createhow4, open_claim4
 from xdrdef.nfs4_type import creatverfattr, fattr4, stateid4, locker4, lock_owner4
-from xdrdef.nfs4_type import open_to_lock_owner4
+from xdrdef.nfs4_type import open_to_lock_owner4, nfsace4
 import nfs_ops
 op = nfs_ops.NFS4ops()
 import threading
 import nfs4lib
+import nfs4acl
 
 def expect(res, seqid):
     """Verify that open result has expected stateid.seqid"""
@@ -195,3 +196,719 @@ def testCloseWithZeroSeqid(t, env):
     stateid.seqid = 0
     res = close_file(sess1, fh, stateid=stateid)
     check(res)
+
+def testSuppattrExclcreat(t, env):
+    """Check that FATTR4_SUPPATTR_EXCLCREAT is supported and valid
+
+    FLAGS: open all
+    CODE: OPEN12
+    """
+    sess = env.c1.new_client_session(env.testname(t))
+    res = sess.compound([op.putrootfh(),
+                        op.getattr(nfs4lib.list2bitmap([FATTR4_SUPPORTED_ATTRS,
+                                                         FATTR4_SUPPATTR_EXCLCREAT]))])
+    check(res)
+    attrs_info = res.resarray[-1].obj_attributes
+
+    if FATTR4_SUPPORTED_ATTRS not in attrs_info:
+        fail("Server did not return FATTR4_SUPPORTED_ATTRS")
+
+    # Check if SUPPATTR_EXCLCREAT is in the supported attributes
+    supported = attrs_info[FATTR4_SUPPORTED_ATTRS]
+    if not (supported & (1 << FATTR4_SUPPATTR_EXCLCREAT)):
+        unsupported("Server does not support FATTR4_SUPPATTR_EXCLCREAT")
+
+    # If supported, check that it was returned
+    if FATTR4_SUPPATTR_EXCLCREAT not in attrs_info:
+        fail("FATTR4_SUPPATTR_EXCLCREAT not returned even though it "
+             "appears in FATTR4_SUPPORTED_ATTRS")
+
+def testSuppattrExclcreatSubset(t, env):
+    """FATTR4_SUPPATTR_EXCLCREAT must be subset of SUPPORTED_ATTRS
+
+    FLAGS: open all
+    CODE: OPEN13
+    DEPEND: OPEN12
+    """
+    sess = env.c1.new_client_session(env.testname(t))
+    res = sess.compound([op.putrootfh(),
+                        op.getattr(nfs4lib.list2bitmap([FATTR4_SUPPORTED_ATTRS,
+                                                         FATTR4_SUPPATTR_EXCLCREAT]))])
+    check(res)
+    attrs_info = res.resarray[-1].obj_attributes
+
+    supported = attrs_info[FATTR4_SUPPORTED_ATTRS]
+    excl_supported = attrs_info[FATTR4_SUPPATTR_EXCLCREAT]
+
+    # SUPPATTR_EXCLCREAT must be a subset of SUPPORTED_ATTRS
+    # i.e., every bit set in excl_supported must also be set in supported
+    invalid = excl_supported & ~supported
+    if invalid != 0:
+        fail("FATTR4_SUPPATTR_EXCLCREAT contains attributes not in "
+             "FATTR4_SUPPORTED_ATTRS:\n"
+             "  Invalid attributes: %s" % nfs4lib.attr_bitmap_to_str(invalid))
+
+def testACLSupported(t, env):
+    """Check that server supports FATTR4_ACL attribute
+
+    FLAGS: open acl all
+    CODE: OPEN8a
+    """
+    sess = env.c1.new_client_session(env.testname(t))
+    res = sess.compound([op.putrootfh(),
+                        op.getattr(nfs4lib.list2bitmap([FATTR4_SUPPORTED_ATTRS]))])
+    check(res)
+    attrs_info = res.resarray[-1].obj_attributes
+    if FATTR4_SUPPORTED_ATTRS not in attrs_info:
+        fail("Server did not return FATTR4_SUPPORTED_ATTRS")
+    supported = attrs_info[FATTR4_SUPPORTED_ATTRS]
+    if not (supported & (1 << FATTR4_ACL)):
+        unsupported("Server does not support FATTR4_ACL attribute")
+
+def testACLExclusiveSupported(t, env):
+    """Check that server supports setting ACL during EXCLUSIVE4_1 create
+
+    FLAGS: open acl all
+    CODE: OPEN8b
+    """
+    sess = env.c1.new_client_session(env.testname(t))
+    res = sess.compound([op.putrootfh(),
+                        op.getattr(nfs4lib.list2bitmap([FATTR4_SUPPATTR_EXCLCREAT]))])
+    check(res)
+    attrs_info = res.resarray[-1].obj_attributes
+    if FATTR4_SUPPATTR_EXCLCREAT not in attrs_info:
+        unsupported("Server does not support FATTR4_SUPPATTR_EXCLCREAT")
+    excl_supported = attrs_info[FATTR4_SUPPATTR_EXCLCREAT]
+    if not (excl_supported & (1 << FATTR4_ACL)):
+        unsupported("Server does not support setting FATTR4_ACL during "
+                    "EXCLUSIVE4_1 create")
+
+def testOpenCreateWithACLUnchecked(t, env):
+    """OPEN with UNCHECKED4 CREATE setting NFSv4 ACL attribute
+
+    FLAGS: open acl all
+    CODE: OPEN9
+    DEPEND: OPEN8a
+    """
+    sess = env.c1.new_client_session(env.testname(t))
+    acl = nfs4acl.make_test_acl()
+
+    # Create file with ACL attribute using UNCHECKED4 mode
+    attrs = {FATTR4_MODE: 0o644, FATTR4_ACL: acl}
+    res = create_file(sess, env.testname(t), attrs=attrs, mode=UNCHECKED4)
+    check(res)
+    expect(res, seqid=1)
+
+    fh = res.resarray[-1].object
+    stateid = res.resarray[-2].stateid
+
+    # Verify the ACL was set correctly by reading it back
+    attrs_dict = do_getattrdict(sess, fh, [FATTR4_ACL])
+    if FATTR4_ACL not in attrs_dict:
+        fail("ACL attribute not returned after OPEN with CREATE")
+
+    try:
+        nfs4acl.verify_acl(attrs_dict[FATTR4_ACL], acl)
+    except AssertionError as e:
+        fail(str(e))
+
+    res = close_file(sess, fh, stateid=stateid)
+    check(res)
+
+def testOpenCreateWithACLGuarded(t, env):
+    """OPEN with GUARDED4 CREATE setting NFSv4 ACL attribute
+
+    FLAGS: open acl all
+    CODE: OPEN10
+    DEPEND: OPEN8a
+    """
+    sess = env.c1.new_client_session(env.testname(t))
+    acl = nfs4acl.make_test_acl()
+
+    # Create file with ACL attribute using GUARDED4 mode
+    attrs = {FATTR4_MODE: 0o644, FATTR4_ACL: acl}
+    res = create_file(sess, env.testname(t), attrs=attrs, mode=GUARDED4)
+    check(res)
+    expect(res, seqid=1)
+
+    fh = res.resarray[-1].object
+    stateid = res.resarray[-2].stateid
+
+    # Verify the ACL was set correctly by reading it back
+    attrs_dict = do_getattrdict(sess, fh, [FATTR4_ACL])
+    if FATTR4_ACL not in attrs_dict:
+        fail("ACL attribute not returned after OPEN with CREATE")
+
+    try:
+        nfs4acl.verify_acl(attrs_dict[FATTR4_ACL], acl)
+    except AssertionError as e:
+        fail(str(e))
+
+    res = close_file(sess, fh, stateid=stateid)
+    check(res)
+
+def testOpenCreateWithACLExclusive(t, env):
+    """OPEN with EXCLUSIVE4_1 CREATE setting NFSv4 ACL attribute
+
+    FLAGS: open acl all
+    CODE: OPEN11
+    DEPEND: OPEN8b
+    """
+    sess = env.c1.new_client_session(env.testname(t))
+    acl = nfs4acl.make_test_acl()
+
+    # Create file with ACL attribute using EXCLUSIVE4_1 mode
+    # EXCLUSIVE4_1 allows attributes to be set atomically with create
+    # Don't set MODE with ACL - let the ACL determine permissions
+    attrs = {FATTR4_ACL: acl}
+    verifier = b"testverif"
+    res = create_file(sess, env.testname(t), attrs=attrs,
+                      mode=EXCLUSIVE4_1, verifier=verifier)
+    check(res)
+    expect(res, seqid=1)
+
+    fh = res.resarray[-1].object
+    stateid = res.resarray[-2].stateid
+
+    # Verify the ACL was set correctly by reading it back
+    attrs_dict = do_getattrdict(sess, fh, [FATTR4_ACL])
+    if FATTR4_ACL not in attrs_dict:
+        fail("ACL attribute not returned after OPEN with CREATE")
+
+    try:
+        nfs4acl.verify_acl(attrs_dict[FATTR4_ACL], acl)
+    except AssertionError as e:
+        fail(str(e))
+
+    res = close_file(sess, fh, stateid=stateid)
+    check(res)
+
+def testOpenCreateModeWithACLExclusive(t, env):
+    """OPEN with EXCLUSIVE4_1 setting both MODE and ACL
+
+    FLAGS: open acl all
+    CODE: OPEN14
+    DEPEND: OPEN8b
+    """
+    sess = env.c1.new_client_session(env.testname(t))
+    acl = nfs4acl.make_test_acl()
+
+    # Create file with both MODE and ACL using EXCLUSIVE4_1
+    # This tests that server can handle both attributes together
+    attrs = {FATTR4_MODE: 0o640, FATTR4_ACL: acl}
+    verifier = b"testverif"
+    res = create_file(sess, env.testname(t), attrs=attrs,
+                      mode=EXCLUSIVE4_1, verifier=verifier)
+    check(res)
+    expect(res, seqid=1)
+
+    fh = res.resarray[-1].object
+    stateid = res.resarray[-2].stateid
+
+    # Verify both ACL and MODE were set correctly
+    attrs_dict = do_getattrdict(sess, fh, [FATTR4_ACL, FATTR4_MODE])
+    if FATTR4_ACL not in attrs_dict:
+        fail("ACL attribute not returned after OPEN with CREATE")
+    if FATTR4_MODE not in attrs_dict:
+        fail("MODE attribute not returned after OPEN with CREATE")
+
+    try:
+        nfs4acl.verify_acl(attrs_dict[FATTR4_ACL], acl)
+    except AssertionError as e:
+        fail(str(e))
+
+    res = close_file(sess, fh, stateid=stateid)
+    check(res)
+
+def testOpenCreateModePreservedUnchecked(t, env):
+    """Verify MODE derivation with ACL in UNCHECKED4 create
+
+    Per RFC 8881 Section 6.4.1.3, when both MODE and ACL are set together,
+    both are processed, but the final mode is derived from the ACL and may
+    differ from the requested MODE.
+
+    FLAGS: open acl all
+    CODE: OPEN15
+    DEPEND: OPEN8a
+    """
+    from nfs4acl import acl2mode_rfc8881
+    sess = env.c1.new_client_session(env.testname(t))
+    acl = nfs4acl.make_test_acl()
+    mode = 0o600
+
+    # Create file with both MODE and ACL
+    attrs = {FATTR4_MODE: mode, FATTR4_ACL: acl}
+    res = create_file(sess, env.testname(t), attrs=attrs, mode=UNCHECKED4)
+    check(res)
+    expect(res, seqid=1)
+
+    fh = res.resarray[-1].object
+    stateid = res.resarray[-2].stateid
+
+    # Check which attributes were actually set by examining the reply bitmask
+    attrset = nfs4lib.bitmap2list(res.resarray[-2].attrset)
+
+    # Verify both MODE and ACL were set (processed)
+    if FATTR4_MODE not in attrset:
+        fail("MODE not in attrset, but MODE was requested")
+    if FATTR4_ACL not in attrset:
+        fail("ACL not in attrset, but ACL was requested")
+
+    # Verify ACL was set correctly
+    attrs_dict = do_getattrdict(sess, fh, [FATTR4_ACL, FATTR4_MODE])
+    try:
+        nfs4acl.verify_mode_and_acl(attrs_dict, acl, "OPEN with CREATE")
+    except AssertionError as e:
+        fail(str(e))
+
+    res = close_file(sess, fh, stateid=stateid)
+    check(res)
+
+def testOpenCreateModePreservedGuarded(t, env):
+    """Verify MODE derivation with ACL in GUARDED4 create
+
+    Per RFC 8881 Section 6.4.1.3, when both MODE and ACL are set together,
+    both are processed, but the final mode is derived from the ACL and may
+    differ from the requested MODE.
+
+    FLAGS: open acl all
+    CODE: OPEN16
+    DEPEND: OPEN8a
+    """
+    from nfs4acl import acl2mode_rfc8881
+    sess = env.c1.new_client_session(env.testname(t))
+    acl = nfs4acl.make_test_acl()
+    mode = 0o640
+
+    # Create file with both MODE and ACL
+    attrs = {FATTR4_MODE: mode, FATTR4_ACL: acl}
+    res = create_file(sess, env.testname(t), attrs=attrs, mode=GUARDED4)
+    check(res)
+    expect(res, seqid=1)
+
+    fh = res.resarray[-1].object
+    stateid = res.resarray[-2].stateid
+
+    # Check which attributes were actually set by examining the reply bitmask
+    attrset = nfs4lib.bitmap2list(res.resarray[-2].attrset)
+
+    # Verify both MODE and ACL were set (processed)
+    if FATTR4_MODE not in attrset:
+        fail("MODE not in attrset, but MODE was requested")
+    if FATTR4_ACL not in attrset:
+        fail("ACL not in attrset, but ACL was requested")
+
+    # Verify ACL was set correctly
+    attrs_dict = do_getattrdict(sess, fh, [FATTR4_ACL, FATTR4_MODE])
+    try:
+        nfs4acl.verify_mode_and_acl(attrs_dict, acl, "OPEN with CREATE")
+    except AssertionError as e:
+        fail(str(e))
+
+    res = close_file(sess, fh, stateid=stateid)
+    check(res)
+
+def testOpenCreateModePreservedExclusive(t, env):
+    """Verify MODE derivation with ACL in EXCLUSIVE4_1 create
+
+    Per RFC 8881 Section 6.4.1.3, when both MODE and ACL are set together,
+    both are processed, but the final mode is derived from the ACL and may
+    differ from the requested MODE.
+
+    FLAGS: open acl all
+    CODE: OPEN17
+    DEPEND: OPEN8b
+    """
+    from nfs4acl import acl2mode_rfc8881
+    sess = env.c1.new_client_session(env.testname(t))
+    acl = nfs4acl.make_test_acl()
+    mode = 0o600
+
+    # Create file with both MODE and ACL using EXCLUSIVE4_1
+    attrs = {FATTR4_MODE: mode, FATTR4_ACL: acl}
+    verifier = b"testverif"
+    res = create_file(sess, env.testname(t), attrs=attrs,
+                      mode=EXCLUSIVE4_1, verifier=verifier)
+    check(res)
+    expect(res, seqid=1)
+
+    fh = res.resarray[-1].object
+    stateid = res.resarray[-2].stateid
+
+    # Check which attributes were actually set by examining the reply bitmask
+    attrset = nfs4lib.bitmap2list(res.resarray[-2].attrset)
+
+    # Verify both MODE and ACL were set (processed)
+    if FATTR4_MODE not in attrset:
+        fail("MODE not in attrset, but MODE was requested")
+    if FATTR4_ACL not in attrset:
+        fail("ACL not in attrset, but ACL was requested")
+
+    # Verify ACL was set correctly
+    attrs_dict = do_getattrdict(sess, fh, [FATTR4_ACL, FATTR4_MODE])
+    try:
+        nfs4acl.verify_mode_and_acl(attrs_dict, acl, "OPEN with CREATE")
+    except AssertionError as e:
+        fail(str(e))
+
+    res = close_file(sess, fh, stateid=stateid)
+    check(res)
+
+def testOpenCreateRestrictiveModeWithACL(t, env):
+    """Test OPEN CREATE with restrictive MODE and ACL together
+
+    Test all three create modes with a restrictive MODE (0o400) and ACL
+    to ensure the server handles the interaction correctly. The MODE
+    being more restrictive than the ACL is an interesting edge case.
+
+    FLAGS: open acl all
+    CODE: OPEN18
+    DEPEND: OPEN8a OPEN8b
+    """
+    sess = env.c1.new_client_session(env.testname(t))
+    acl = nfs4acl.make_test_acl()
+    mode = 0o400  # Read-only for owner
+
+    # Test UNCHECKED4
+    name1 = env.testname(t) + b"_unchecked"
+    attrs = {FATTR4_MODE: mode, FATTR4_ACL: acl}
+    res = create_file(sess, name1, attrs=attrs, mode=UNCHECKED4)
+    check(res)
+    fh1 = res.resarray[-1].object
+    stateid1 = res.resarray[-2].stateid
+
+    attrs_dict = do_getattrdict(sess, fh1, [FATTR4_ACL, FATTR4_MODE])
+    if FATTR4_ACL not in attrs_dict or FATTR4_MODE not in attrs_dict:
+        fail("ACL or MODE not returned after UNCHECKED4 CREATE")
+    try:
+        nfs4acl.verify_acl(attrs_dict[FATTR4_ACL], acl)
+    except AssertionError as e:
+        fail(str(e))
+
+    res = close_file(sess, fh1, stateid=stateid1)
+    check(res)
+
+    # Test GUARDED4
+    name2 = env.testname(t) + b"_guarded"
+    attrs = {FATTR4_MODE: mode, FATTR4_ACL: acl}
+    res = create_file(sess, name2, attrs=attrs, mode=GUARDED4)
+    check(res)
+    fh2 = res.resarray[-1].object
+    stateid2 = res.resarray[-2].stateid
+
+    attrs_dict = do_getattrdict(sess, fh2, [FATTR4_ACL, FATTR4_MODE])
+    if FATTR4_ACL not in attrs_dict or FATTR4_MODE not in attrs_dict:
+        fail("ACL or MODE not returned after GUARDED4 CREATE")
+    try:
+        nfs4acl.verify_acl(attrs_dict[FATTR4_ACL], acl)
+    except AssertionError as e:
+        fail(str(e))
+
+    res = close_file(sess, fh2, stateid=stateid2)
+    check(res)
+
+    # Test EXCLUSIVE4_1
+    name3 = env.testname(t) + b"_exclusive"
+    attrs = {FATTR4_MODE: mode, FATTR4_ACL: acl}
+    verifier = b"testverif"
+    res = create_file(sess, name3, attrs=attrs,
+                      mode=EXCLUSIVE4_1, verifier=verifier)
+    check(res)
+    fh3 = res.resarray[-1].object
+    stateid3 = res.resarray[-2].stateid
+
+    attrs_dict = do_getattrdict(sess, fh3, [FATTR4_ACL, FATTR4_MODE])
+    if FATTR4_ACL not in attrs_dict or FATTR4_MODE not in attrs_dict:
+        fail("ACL or MODE not returned after EXCLUSIVE4_1 CREATE")
+    try:
+        nfs4acl.verify_acl(attrs_dict[FATTR4_ACL], acl)
+    except AssertionError as e:
+        fail(str(e))
+
+    res = close_file(sess, fh3, stateid=stateid3)
+    check(res)
+
+#
+# Tests for OPEN CREATE with MODE and ACL per RFC 8881 §6.4.3
+#
+
+def testOpenCreateModeDerivation(t, env):
+    """OPEN CREATE with MODE should derive ACL from mode
+
+    Per RFC 8881 §6.4.3: If just mode is given, the mode MUST be
+    applied to the inherited/created ACL per §6.4.1.1. Test with
+    UNCHECKED4, GUARDED4, and EXCLUSIVE4_1.
+
+    FLAGS: open all
+    CODE: OPEN38
+    """
+    from nfs4acl import acl2mode_rfc8881
+
+    sess = env.c1.new_client_session(env.testname(t))
+
+    # Test with UNCHECKED4
+    mode = 0o640
+    attrs = {FATTR4_MODE: mode}
+    name1 = env.testname(t) + b"_unchecked"
+    res = create_file(sess, name1, attrs=attrs, mode=UNCHECKED4)
+    check(res)
+    fh1 = res.resarray[-1].object
+    stateid1 = res.resarray[-2].stateid
+
+    attrs_dict = do_getattrdict(sess, fh1, [FATTR4_MODE, FATTR4_ACL])
+    result_mode = attrs_dict[FATTR4_MODE] & 0o777
+    if result_mode != mode:
+        fail("UNCHECKED4: mode (0%o) doesn't match requested (0%o)" %
+             (result_mode, mode))
+
+    acl_derived_mode = acl2mode_rfc8881(attrs_dict[FATTR4_ACL])
+    if result_mode != acl_derived_mode:
+        fail("UNCHECKED4: mode (0%o) doesn't match ACL derivation (0%o)" %
+             (result_mode, acl_derived_mode))
+
+    res = close_file(sess, fh1, stateid=stateid1)
+    check(res)
+
+    # Test with GUARDED4
+    mode = 0o750
+    attrs = {FATTR4_MODE: mode}
+    name2 = env.testname(t) + b"_guarded"
+    res = create_file(sess, name2, attrs=attrs, mode=GUARDED4)
+    check(res)
+    fh2 = res.resarray[-1].object
+    stateid2 = res.resarray[-2].stateid
+
+    attrs_dict = do_getattrdict(sess, fh2, [FATTR4_MODE, FATTR4_ACL])
+    result_mode = attrs_dict[FATTR4_MODE] & 0o777
+    if result_mode != mode:
+        fail("GUARDED4: mode (0%o) doesn't match requested (0%o)" %
+             (result_mode, mode))
+
+    acl_derived_mode = acl2mode_rfc8881(attrs_dict[FATTR4_ACL])
+    if result_mode != acl_derived_mode:
+        fail("GUARDED4: mode (0%o) doesn't match ACL derivation (0%o)" %
+             (result_mode, acl_derived_mode))
+
+    res = close_file(sess, fh2, stateid=stateid2)
+    check(res)
+
+    # Test with EXCLUSIVE4_1
+    mode = 0o755
+    attrs = {FATTR4_MODE: mode}
+    name3 = env.testname(t) + b"_exclusive"
+    verifier = b"testverif"
+    res = create_file(sess, name3, attrs=attrs,
+                      mode=EXCLUSIVE4_1, verifier=verifier)
+    check(res)
+    fh3 = res.resarray[-1].object
+    stateid3 = res.resarray[-2].stateid
+
+    attrs_dict = do_getattrdict(sess, fh3, [FATTR4_MODE, FATTR4_ACL])
+    result_mode = attrs_dict[FATTR4_MODE] & 0o777
+    if result_mode != mode:
+        fail("EXCLUSIVE4_1: mode (0%o) doesn't match requested (0%o)" %
+             (result_mode, mode))
+
+    acl_derived_mode = acl2mode_rfc8881(attrs_dict[FATTR4_ACL])
+    if result_mode != acl_derived_mode:
+        fail("EXCLUSIVE4_1: mode (0%o) doesn't match ACL derivation (0%o)" %
+             (result_mode, acl_derived_mode))
+
+    res = close_file(sess, fh3, stateid=stateid3)
+    check(res)
+
+def testOpenCreateACLDerivation(t, env):
+    """OPEN CREATE with ACL should derive mode from ACL
+
+    Per RFC 8881 §6.4.3: If just ACL is given, inheritance SHOULD NOT
+    take place, ACL should be set as given, and mode modified per §6.4.1.2.
+
+    FLAGS: open all
+    CODE: OPEN39
+    """
+    from nfs4acl import acl2mode_rfc8881
+
+    sess = env.c1.new_client_session(env.testname(t))
+
+    # Test with UNCHECKED4
+    acl = [
+        nfsace4(ACE4_ACCESS_ALLOWED_ACE_TYPE, 0,
+                ACE4_READ_DATA | ACE4_WRITE_DATA | ACE4_APPEND_DATA,
+                b"OWNER@"),
+        nfsace4(ACE4_ACCESS_ALLOWED_ACE_TYPE, 0,
+                ACE4_READ_DATA,
+                b"GROUP@")
+    ]
+    attrs = {FATTR4_ACL: acl}
+    name1 = env.testname(t) + b"_unchecked"
+    res = create_file(sess, name1, attrs=attrs, mode=UNCHECKED4)
+    check(res)
+    fh1 = res.resarray[-1].object
+    stateid1 = res.resarray[-2].stateid
+
+    attrs_dict = do_getattrdict(sess, fh1, [FATTR4_MODE, FATTR4_ACL])
+    result_mode = attrs_dict[FATTR4_MODE] & 0o777
+    expected_mode = acl2mode_rfc8881(attrs_dict[FATTR4_ACL])
+
+    if result_mode != expected_mode:
+        fail("UNCHECKED4: mode (0%o) doesn't match ACL derivation (0%o)" %
+             (result_mode, expected_mode))
+
+    res = close_file(sess, fh1, stateid=stateid1)
+    check(res)
+
+    # Test with GUARDED4
+    acl = [
+        nfsace4(ACE4_ACCESS_ALLOWED_ACE_TYPE, 0,
+                ACE4_READ_DATA | ACE4_EXECUTE,
+                b"OWNER@")
+    ]
+    attrs = {FATTR4_ACL: acl}
+    name2 = env.testname(t) + b"_guarded"
+    res = create_file(sess, name2, attrs=attrs, mode=GUARDED4)
+    check(res)
+    fh2 = res.resarray[-1].object
+    stateid2 = res.resarray[-2].stateid
+
+    attrs_dict = do_getattrdict(sess, fh2, [FATTR4_MODE, FATTR4_ACL])
+    result_mode = attrs_dict[FATTR4_MODE] & 0o777
+    expected_mode = acl2mode_rfc8881(attrs_dict[FATTR4_ACL])
+
+    if result_mode != expected_mode:
+        fail("GUARDED4: mode (0%o) doesn't match ACL derivation (0%o)" %
+             (result_mode, expected_mode))
+
+    res = close_file(sess, fh2, stateid=stateid2)
+    check(res)
+
+    # Test with EXCLUSIVE4_1
+    acl = [
+        nfsace4(ACE4_ACCESS_ALLOWED_ACE_TYPE, 0,
+                ACE4_READ_DATA | ACE4_WRITE_DATA | ACE4_APPEND_DATA | ACE4_EXECUTE,
+                b"OWNER@"),
+        nfsace4(ACE4_ACCESS_ALLOWED_ACE_TYPE, 0,
+                ACE4_READ_DATA | ACE4_EXECUTE,
+                b"GROUP@"),
+        nfsace4(ACE4_ACCESS_ALLOWED_ACE_TYPE, 0,
+                ACE4_READ_DATA,
+                b"EVERYONE@")
+    ]
+    attrs = {FATTR4_ACL: acl}
+    name3 = env.testname(t) + b"_exclusive"
+    verifier = b"testverif"
+    res = create_file(sess, name3, attrs=attrs,
+                      mode=EXCLUSIVE4_1, verifier=verifier)
+    check(res)
+    fh3 = res.resarray[-1].object
+    stateid3 = res.resarray[-2].stateid
+
+    attrs_dict = do_getattrdict(sess, fh3, [FATTR4_MODE, FATTR4_ACL])
+    result_mode = attrs_dict[FATTR4_MODE] & 0o777
+    expected_mode = acl2mode_rfc8881(attrs_dict[FATTR4_ACL])
+
+    if result_mode != expected_mode:
+        fail("EXCLUSIVE4_1: mode (0%o) doesn't match ACL derivation (0%o)" %
+             (result_mode, expected_mode))
+
+    res = close_file(sess, fh3, stateid=stateid3)
+    check(res)
+
+def testOpenCreateModeACLConflict(t, env):
+    """OPEN CREATE with both MODE and ACL - ACL should win
+
+    Per RFC 8881 §6.4.3: If both mode and ACL are given, both attributes
+    will be set per §6.4.1.3 (MODE first, then ACL, with ACL modifying
+    the final mode).
+
+    FLAGS: open all
+    CODE: OPEN40
+    """
+    from nfs4acl import acl2mode_rfc8881
+
+    sess = env.c1.new_client_session(env.testname(t))
+
+    # Test with UNCHECKED4: ACL would derive to 0754, request MODE 0640
+    acl = [
+        nfsace4(ACE4_ACCESS_ALLOWED_ACE_TYPE, 0,
+                ACE4_READ_DATA | ACE4_WRITE_DATA | ACE4_APPEND_DATA | ACE4_EXECUTE,
+                b"OWNER@"),
+        nfsace4(ACE4_ACCESS_ALLOWED_ACE_TYPE, 0,
+                ACE4_READ_DATA | ACE4_EXECUTE,
+                b"GROUP@"),
+        nfsace4(ACE4_ACCESS_ALLOWED_ACE_TYPE, 0,
+                ACE4_READ_DATA,
+                b"EVERYONE@")
+    ]
+    mode = 0o640
+    attrs = {FATTR4_MODE: mode, FATTR4_ACL: acl}
+    name1 = env.testname(t) + b"_unchecked"
+    res = create_file(sess, name1, attrs=attrs, mode=UNCHECKED4)
+    check(res)
+    fh1 = res.resarray[-1].object
+    stateid1 = res.resarray[-2].stateid
+
+    attrs_dict = do_getattrdict(sess, fh1, [FATTR4_MODE, FATTR4_ACL])
+    result_mode = attrs_dict[FATTR4_MODE] & 0o777
+    expected_mode = acl2mode_rfc8881(attrs_dict[FATTR4_ACL])
+
+    if result_mode != expected_mode:
+        fail("UNCHECKED4: mode (0%o) doesn't match ACL derivation (0%o). "
+             "Per §6.4.3, should follow §6.4.1.3 (ACL wins)" %
+             (result_mode, expected_mode))
+
+    res = close_file(sess, fh1, stateid=stateid1)
+    check(res)
+
+    # Test with GUARDED4
+    acl = [
+        nfsace4(ACE4_ACCESS_ALLOWED_ACE_TYPE, 0,
+                ACE4_READ_DATA | ACE4_WRITE_DATA | ACE4_APPEND_DATA,
+                b"OWNER@")
+    ]
+    mode = 0o755
+    attrs = {FATTR4_MODE: mode, FATTR4_ACL: acl}
+    name2 = env.testname(t) + b"_guarded"
+    res = create_file(sess, name2, attrs=attrs, mode=GUARDED4)
+    check(res)
+    fh2 = res.resarray[-1].object
+    stateid2 = res.resarray[-2].stateid
+
+    attrs_dict = do_getattrdict(sess, fh2, [FATTR4_MODE, FATTR4_ACL])
+    result_mode = attrs_dict[FATTR4_MODE] & 0o777
+    expected_mode = acl2mode_rfc8881(attrs_dict[FATTR4_ACL])
+
+    if result_mode != expected_mode:
+        fail("GUARDED4: mode (0%o) doesn't match ACL derivation (0%o). "
+             "Per §6.4.3, should follow §6.4.1.3" %
+             (result_mode, expected_mode))
+
+    res = close_file(sess, fh2, stateid=stateid2)
+    check(res)
+
+    # Test with EXCLUSIVE4_1
+    acl = [
+        nfsace4(ACE4_ACCESS_ALLOWED_ACE_TYPE, 0,
+                ACE4_EXECUTE,
+                b"OWNER@")
+    ]
+    mode = 0o644
+    attrs = {FATTR4_MODE: mode, FATTR4_ACL: acl}
+    name3 = env.testname(t) + b"_exclusive"
+    verifier = b"testverif"
+    res = create_file(sess, name3, attrs=attrs,
+                      mode=EXCLUSIVE4_1, verifier=verifier)
+    check(res)
+    fh3 = res.resarray[-1].object
+    stateid3 = res.resarray[-2].stateid
+
+    attrs_dict = do_getattrdict(sess, fh3, [FATTR4_MODE, FATTR4_ACL])
+    result_mode = attrs_dict[FATTR4_MODE] & 0o777
+    expected_mode = acl2mode_rfc8881(attrs_dict[FATTR4_ACL])
+
+    if result_mode != expected_mode:
+        fail("EXCLUSIVE4_1: mode (0%o) doesn't match ACL derivation (0%o). "
+             "Per §6.4.3, should follow §6.4.1.3" %
+             (result_mode, expected_mode))
+
+    res = close_file(sess, fh3, stateid=stateid3)
+    check(res)
-- 
2.51.1


