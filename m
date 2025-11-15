Return-Path: <linux-nfs+bounces-16420-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19336C608F4
	for <lists+linux-nfs@lfdr.de>; Sat, 15 Nov 2025 18:08:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B90D13A422B
	for <lists+linux-nfs@lfdr.de>; Sat, 15 Nov 2025 17:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97840280A3B;
	Sat, 15 Nov 2025 17:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qOF8bmw+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71798200113
	for <linux-nfs@vger.kernel.org>; Sat, 15 Nov 2025 17:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763226498; cv=none; b=rIf3ro9qmu7HyVafVe7+sXENtrw0sWav3rUn+YtE8WHUwH54olKVc8woBajJ+i2wNsa8ry0qUQm3x+vUCsDM7NajyiBH2ZQRCEgTatMg1Ow0xG9JQeJaz74UJhWfL9pqZEgB7sX5fkW4ncwjKZ/gGBWH9r3FqPlFdfAhikuos1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763226498; c=relaxed/simple;
	bh=YiNgbXmNCUoul5nLOCX79kcEnCaYZXOOxJps3xn+DjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mXYr22OmdYia1KyyDNNNiOly/a8xpn+MVnYvn6D6D7i38R2jSU8ZSoxJIXA8uUIaO1z2EsEHzihAbbc5VVhw+gH6WgDDR+vieH+Hbgcpz/XYWEdY6RI9IOVQ46QWVvIhD72tAwV8PPaKZo9K+3EjKfVXUQgP2hUHxOUYc65PLoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qOF8bmw+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B1F9C4CEF5;
	Sat, 15 Nov 2025 17:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763226497;
	bh=YiNgbXmNCUoul5nLOCX79kcEnCaYZXOOxJps3xn+DjQ=;
	h=From:To:Cc:Subject:Date:From;
	b=qOF8bmw+jcs7hv2XxM1skerBsneolFPrvHv8iux8DGnnd/6fXBe0N26lDqWneEUAo
	 qyHnjRCU2Um7KKDAuFsuzsZZEGKtuLOs78vFv9BzCxz4OCjMBOjd8d2NpLrLg63v0N
	 EJsmL2TeQTzRLVCNaP2LImO1pJdJhZ5iiY8fYgJV7//ZkdV2kclRA+N7RxeeDTQzQl
	 QO873gen86OwXPjRb9JUN/3cY1eyM6Ham63Pa6kiOrlJ5ihEYFFTDgpttpjRQ6AHDC
	 IRSG9wV2vlFqR4KoD8kaKJMfUI93MQCUWp5LzU4ElthSOaocDTuFlesUE6xSoeOuPD
	 cHHVyRfVwiBRQ==
From: Chuck Lever <cel@kernel.org>
To: Calum Mackay <calum.mackay@oracle.com>
Cc: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	<linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH] Add tests for OPEN(create) with ACLs
Date: Sat, 15 Nov 2025 12:08:15 -0500
Message-ID: <20251115170815.20696-1-cel@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Check that the server can attach an ACL when it creates a file.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 nfs4.1/server41tests/environment.py |  92 +++++++++++
 nfs4.1/server41tests/st_open.py     | 238 +++++++++++++++++++++++++++-
 2 files changed, 327 insertions(+), 3 deletions(-)

diff --git a/nfs4.1/server41tests/environment.py b/nfs4.1/server41tests/environment.py
index 48284e029634..0b39bce29870 100644
--- a/nfs4.1/server41tests/environment.py
+++ b/nfs4.1/server41tests/environment.py
@@ -277,6 +277,98 @@ debug_fail = False
 def fail(msg):
     raise testmod.FailureException(msg)
 
+def unsupported(msg):
+    raise testmod.UnsupportedException(msg)
+
+def access_mask_to_str(mask):
+    """Convert an ACE access_mask to a symbolic string representation"""
+    perms = [
+        (ACE4_READ_DATA, "READ_DATA"),
+        (ACE4_WRITE_DATA, "WRITE_DATA"),
+        (ACE4_APPEND_DATA, "APPEND_DATA"),
+        (ACE4_READ_NAMED_ATTRS, "READ_NAMED_ATTRS"),
+        (ACE4_WRITE_NAMED_ATTRS, "WRITE_NAMED_ATTRS"),
+        (ACE4_EXECUTE, "EXECUTE"),
+        (ACE4_DELETE_CHILD, "DELETE_CHILD"),
+        (ACE4_READ_ATTRIBUTES, "READ_ATTRIBUTES"),
+        (ACE4_WRITE_ATTRIBUTES, "WRITE_ATTRIBUTES"),
+        (ACE4_DELETE, "DELETE"),
+        (ACE4_READ_ACL, "READ_ACL"),
+        (ACE4_WRITE_ACL, "WRITE_ACL"),
+        (ACE4_WRITE_OWNER, "WRITE_OWNER"),
+        (ACE4_SYNCHRONIZE, "SYNCHRONIZE"),
+    ]
+    return " | ".join(name for bit, name in perms if mask & bit) or "(none)"
+
+def attr_bitmap_to_str(bitmap):
+    """Convert an attribute bitmap to a symbolic string representation"""
+    attrs = [
+        (FATTR4_SUPPORTED_ATTRS, "SUPPORTED_ATTRS"),
+        (FATTR4_TYPE, "TYPE"),
+        (FATTR4_FH_EXPIRE_TYPE, "FH_EXPIRE_TYPE"),
+        (FATTR4_CHANGE, "CHANGE"),
+        (FATTR4_SIZE, "SIZE"),
+        (FATTR4_LINK_SUPPORT, "LINK_SUPPORT"),
+        (FATTR4_SYMLINK_SUPPORT, "SYMLINK_SUPPORT"),
+        (FATTR4_NAMED_ATTR, "NAMED_ATTR"),
+        (FATTR4_FSID, "FSID"),
+        (FATTR4_UNIQUE_HANDLES, "UNIQUE_HANDLES"),
+        (FATTR4_LEASE_TIME, "LEASE_TIME"),
+        (FATTR4_RDATTR_ERROR, "RDATTR_ERROR"),
+        (FATTR4_ACL, "ACL"),
+        (FATTR4_ACLSUPPORT, "ACLSUPPORT"),
+        (FATTR4_ARCHIVE, "ARCHIVE"),
+        (FATTR4_CANSETTIME, "CANSETTIME"),
+        (FATTR4_CASE_INSENSITIVE, "CASE_INSENSITIVE"),
+        (FATTR4_CASE_PRESERVING, "CASE_PRESERVING"),
+        (FATTR4_CHOWN_RESTRICTED, "CHOWN_RESTRICTED"),
+        (FATTR4_FILEHANDLE, "FILEHANDLE"),
+        (FATTR4_FILEID, "FILEID"),
+        (FATTR4_FILES_AVAIL, "FILES_AVAIL"),
+        (FATTR4_FILES_FREE, "FILES_FREE"),
+        (FATTR4_FILES_TOTAL, "FILES_TOTAL"),
+        (FATTR4_FS_LOCATIONS, "FS_LOCATIONS"),
+        (FATTR4_HIDDEN, "HIDDEN"),
+        (FATTR4_HOMOGENEOUS, "HOMOGENEOUS"),
+        (FATTR4_MAXFILESIZE, "MAXFILESIZE"),
+        (FATTR4_MAXLINK, "MAXLINK"),
+        (FATTR4_MAXNAME, "MAXNAME"),
+        (FATTR4_MAXREAD, "MAXREAD"),
+        (FATTR4_MAXWRITE, "MAXWRITE"),
+        (FATTR4_MIMETYPE, "MIMETYPE"),
+        (FATTR4_MODE, "MODE"),
+        (FATTR4_NO_TRUNC, "NO_TRUNC"),
+        (FATTR4_NUMLINKS, "NUMLINKS"),
+        (FATTR4_OWNER, "OWNER"),
+        (FATTR4_OWNER_GROUP, "OWNER_GROUP"),
+        (FATTR4_QUOTA_AVAIL_HARD, "QUOTA_AVAIL_HARD"),
+        (FATTR4_QUOTA_AVAIL_SOFT, "QUOTA_AVAIL_SOFT"),
+        (FATTR4_QUOTA_USED, "QUOTA_USED"),
+        (FATTR4_RAWDEV, "RAWDEV"),
+        (FATTR4_SPACE_AVAIL, "SPACE_AVAIL"),
+        (FATTR4_SPACE_FREE, "SPACE_FREE"),
+        (FATTR4_SPACE_TOTAL, "SPACE_TOTAL"),
+        (FATTR4_SPACE_USED, "SPACE_USED"),
+        (FATTR4_SYSTEM, "SYSTEM"),
+        (FATTR4_TIME_ACCESS, "TIME_ACCESS"),
+        (FATTR4_TIME_ACCESS_SET, "TIME_ACCESS_SET"),
+        (FATTR4_TIME_BACKUP, "TIME_BACKUP"),
+        (FATTR4_TIME_CREATE, "TIME_CREATE"),
+        (FATTR4_TIME_DELTA, "TIME_DELTA"),
+        (FATTR4_TIME_METADATA, "TIME_METADATA"),
+        (FATTR4_TIME_MODIFY, "TIME_MODIFY"),
+        (FATTR4_TIME_MODIFY_SET, "TIME_MODIFY_SET"),
+        (FATTR4_MOUNTED_ON_FILEID, "MOUNTED_ON_FILEID"),
+        (FATTR4_SUPPATTR_EXCLCREAT, "SUPPATTR_EXCLCREAT"),
+        (FATTR4_SEC_LABEL, "SEC_LABEL"),
+        (FATTR4_XATTR_SUPPORT, "XATTR_SUPPORT"),
+    ]
+    result = []
+    for bit, name in attrs:
+        if bitmap & (1 << bit):
+            result.append(name)
+    return ", ".join(result) if result else "(none)"
+
 def check(res, stat=NFS4_OK, msg=None, warnlist=[]):
 
     if type(stat) is str:
diff --git a/nfs4.1/server41tests/st_open.py b/nfs4.1/server41tests/st_open.py
index 28540b59a8fe..2a06f301543a 100644
--- a/nfs4.1/server41tests/st_open.py
+++ b/nfs4.1/server41tests/st_open.py
@@ -1,11 +1,11 @@
 from .st_create_session import create_session
 from xdrdef.nfs4_const import *
 
-from .environment import check, fail, create_file, open_file, close_file, write_file, read_file
-from .environment import open_create_file_op
+from .environment import check, fail, unsupported, create_file, open_file, close_file, write_file, read_file
+from .environment import open_create_file_op, do_getattrdict, access_mask_to_str, attr_bitmap_to_str
 from xdrdef.nfs4_type import open_owner4, openflag4, createhow4, open_claim4
 from xdrdef.nfs4_type import creatverfattr, fattr4, stateid4, locker4, lock_owner4
-from xdrdef.nfs4_type import open_to_lock_owner4
+from xdrdef.nfs4_type import open_to_lock_owner4, nfsace4
 import nfs_ops
 op = nfs_ops.NFS4ops()
 import threading
@@ -17,6 +17,61 @@ def expect(res, seqid):
     if got != seqid:
         fail("Expected open_stateid.seqid == %i, got %i" % (seqid, got))
 
+def make_test_acl():
+    """Create a test ACL that maps cleanly to POSIX ACLs
+
+    Uses OWNER@, GROUP@, and EVERYONE@ to match POSIX user/group/other
+    structure, which helps servers that map NFSv4 ACLs to POSIX ACLs.
+
+    Includes both WRITE_DATA and APPEND_DATA for write permission, since
+    Linux NFS server's conservative NFSv4-to-POSIX mapping requires both
+    to grant POSIX write permission.
+    """
+    return [
+        nfsace4(ACE4_ACCESS_ALLOWED_ACE_TYPE, 0,
+                ACE4_READ_DATA | ACE4_WRITE_DATA | ACE4_APPEND_DATA | ACE4_READ_ACL,
+                b"OWNER@"),
+        nfsace4(ACE4_ACCESS_ALLOWED_ACE_TYPE, 0,
+                ACE4_READ_DATA,
+                b"GROUP@"),
+        nfsace4(ACE4_ACCESS_ALLOWED_ACE_TYPE, 0,
+                ACE4_READ_DATA,
+                b"EVERYONE@")
+    ]
+
+def verify_acl(returned_acl, expected_acl):
+    """Verify that returned ACL contains expected ACEs
+
+    Server may add additional ACEs, but the requested ones must be present
+    with at least the requested permissions.
+    """
+    if len(returned_acl) < len(expected_acl):
+        fail("Returned ACL has fewer entries than requested: "
+             "expected at least %d, got %d" % (len(expected_acl), len(returned_acl)))
+
+    # Verify the ACEs we set are present (server may add additional ACEs)
+    for i, expected_ace in enumerate(expected_acl):
+        if i >= len(returned_acl):
+            fail("Missing ACE %d in returned ACL" % i)
+        returned_ace = returned_acl[i]
+        if returned_ace.type != expected_ace.type:
+            fail("ACE %d type mismatch: expected %d, got %d" %
+                 (i, expected_ace.type, returned_ace.type))
+        if returned_ace.who != expected_ace.who:
+            fail("ACE %d who mismatch: expected %s, got %s" %
+                 (i, expected_ace.who, returned_ace.who))
+        # Check that requested permissions are present (server may add more)
+        if (returned_ace.access_mask & expected_ace.access_mask) != expected_ace.access_mask:
+            missing = expected_ace.access_mask & ~returned_ace.access_mask
+            fail("ACE %d access_mask mismatch:\n"
+                 "  Expected: %s\n"
+                 "  Got:      %s\n"
+                 "  Missing:  %s" %
+                 (i,
+                  access_mask_to_str(expected_ace.access_mask),
+                  access_mask_to_str(returned_ace.access_mask),
+                  access_mask_to_str(missing)))
+
 def testSupported(t, env):
     """Do a simple OPEN create
 
@@ -195,3 +250,180 @@ def testCloseWithZeroSeqid(t, env):
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
+             "  Invalid attributes: %s" % attr_bitmap_to_str(invalid))
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
+    acl = make_test_acl()
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
+    verify_acl(attrs_dict[FATTR4_ACL], acl)
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
+    acl = make_test_acl()
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
+    verify_acl(attrs_dict[FATTR4_ACL], acl)
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
+    acl = make_test_acl()
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
+    verify_acl(attrs_dict[FATTR4_ACL], acl)
+
+    res = close_file(sess, fh, stateid=stateid)
+    check(res)
-- 
2.51.0


