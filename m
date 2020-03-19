Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD8FF18B9DA
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Mar 2020 15:59:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727286AbgCSO7S (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 19 Mar 2020 10:59:18 -0400
Received: from smtp-o-2.desy.de ([131.169.56.155]:42907 "EHLO smtp-o-2.desy.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726785AbgCSO7R (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 19 Mar 2020 10:59:17 -0400
Received: from smtp-buf-2.desy.de (smtp-buf-2.desy.de [IPv6:2001:638:700:1038::1:a5])
        by smtp-o-2.desy.de (Postfix) with ESMTP id D0EE2160B5C
        for <linux-nfs@vger.kernel.org>; Thu, 19 Mar 2020 15:59:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp-o-2.desy.de D0EE2160B5C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=desy.de; s=default;
        t=1584629953; bh=aZogjubIW3dzdUFc2Y6UYyiza4RIl5Wyxb5dNstmUEU=;
        h=From:To:Cc:Subject:Date:From;
        b=Du5rDWtIw6EqzPQkaxhBvci5KTldd+9BQncMFNgdqM7+HDqNfyOa8u9OXRP0rjxcf
         +FtWylAJ3NidsAJ82bmmEpvO38oRkbrsD0c8mHhXHqdY0REdi4pApvlIqpaTPnvCZ0
         DRWBDc1+OJ7pjV3MA0J+0Ic9AQuG0J14ZZuvnjYA=
Received: from smtp-m-2.desy.de (smtp-m-2.desy.de [131.169.56.130])
        by smtp-buf-2.desy.de (Postfix) with ESMTP id CB9401A008D;
        Thu, 19 Mar 2020 15:59:13 +0100 (CET)
X-Virus-Scanned: amavisd-new at desy.de
Received: from nairi.desy.de (VPN0221.desy.de [131.169.253.220])
        by smtp-intra-2.desy.de (Postfix) with ESMTP id 7D7CA100076;
        Thu, 19 Mar 2020 15:59:13 +0100 (CET)
From:   Tigran Mkrtchyan <tigran.mkrtchyan@desy.de>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org,
        Tigran Mkrtchyan <tigran.mkrtchyan@desy.de>
Subject: [PATCH] nfsv41: add set of xattr related tests
Date:   Thu, 19 Mar 2020 15:59:11 +0100
Message-Id: <20200319145911.284743-1-tigran.mkrtchyan@desy.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Signed-off-by: Tigran Mkrtchyan <tigran.mkrtchyan@desy.de>
---
 nfs4.1/nfs4lib.py                   |   1 +
 nfs4.1/server41tests/__init__.py    |   1 +
 nfs4.1/server41tests/environment.py |   1 +
 nfs4.1/server41tests/st_xattr.py    | 246 ++++++++++++++++++++++++++++
 nfs4.1/xdrdef/nfs4.x                | 111 ++++++++++++-
 5 files changed, 359 insertions(+), 1 deletion(-)
 create mode 100644 nfs4.1/server41tests/st_xattr.py

diff --git a/nfs4.1/nfs4lib.py b/nfs4.1/nfs4lib.py
index 36b0948..c2cdfb7 100644
--- a/nfs4.1/nfs4lib.py
+++ b/nfs4.1/nfs4lib.py
@@ -730,5 +730,6 @@ attr_info = { FATTR4_SUPPORTED_ATTRS : A("r", "fs"),
               FATTR4_RETENTION_HOLD : A("rw", "obj"),
               FATTR4_MODE_SET_MASKED : A("w", "obj"),
               FATTR4_FS_CHARSET_CAP : A("r", "fs"),
+              FATTR4_XATTR_SUPPORT : A("r", "obj"),
               }
 del A
diff --git a/nfs4.1/server41tests/__init__.py b/nfs4.1/server41tests/__init__.py
index 47bdd79..a4d7ee6 100644
--- a/nfs4.1/server41tests/__init__.py
+++ b/nfs4.1/server41tests/__init__.py
@@ -24,4 +24,5 @@ __all__ = ["st_exchange_id.py", # draft 21
            "st_current_stateid.py",
            "st_sparse.py",
            "st_flex.py",
+           "st_xattr.py",
            ]
diff --git a/nfs4.1/server41tests/environment.py b/nfs4.1/server41tests/environment.py
index 76f2ef1..e7bcaa9 100644
--- a/nfs4.1/server41tests/environment.py
+++ b/nfs4.1/server41tests/environment.py
@@ -107,6 +107,7 @@ class Environment(testmod.Environment):
         AttrInfo('time_modify', 'r', nfstime4(0, 0)),
         AttrInfo('time_modify_set', 'w', settime4(0)),
         AttrInfo('mounted_on_fileid', 'r', 0),
+        AttrInfo('xattr_support', 'r', False),
         ]
 
     home = property(lambda s: use_obj(s.opts.home))
diff --git a/nfs4.1/server41tests/st_xattr.py b/nfs4.1/server41tests/st_xattr.py
new file mode 100644
index 0000000..de28b2c
--- /dev/null
+++ b/nfs4.1/server41tests/st_xattr.py
@@ -0,0 +1,246 @@
+from .st_create_session import create_session
+from xdrdef.nfs4_const import *
+
+from .environment import check, fail, create_file, open_file, close_file
+from .environment import open_create_file_op, do_getattrdict
+from xdrdef.nfs4_type import open_owner4, openflag4, createhow4, open_claim4
+from xdrdef.nfs4_type import creatverfattr, fattr4, stateid4, locker4, lock_owner4
+from xdrdef.nfs4_type import open_to_lock_owner4
+import nfs_ops
+op = nfs_ops.NFS4ops()
+import threading
+
+current_stateid = stateid4(1, b'\0' * 12)
+
+def testGetXattrAttribute(t, env):
+    """Server with xattr support MUST support.
+
+    FLAGS: xattr
+    CODE: XATT1
+    """
+    sess = env.c1.new_client_session(env.testname(t))
+    res = sess.compound([op.putrootfh(), op.getattr(1 << FATTR4_SUPPORTED_ATTRS|1 <<FATTR4_XATTR_SUPPORT)])
+    check(res)
+
+    if FATTR4_SUPPORTED_ATTRS not in res.resarray[-1].obj_attributes:
+        fail("Requested bitmap of supported attributes not provided")
+
+    bitmask = res.resarray[-1].obj_attributes[FATTR4_SUPPORTED_ATTRS]
+    if bitmask & (1 << FATTR4_XATTR_SUPPORT) == 0:
+        fail("xattr_support is not included in the set of supported attributes")
+
+    if FATTR4_XATTR_SUPPORT not in res.resarray[-1].obj_attributes:
+        fail("Server doesn't support extended attributes")
+
+
+def testGetMissingAttr(t, env):
+    """Server MUST return NFS4ERR_NOXATTR if value is missing.
+
+    FLAGS: xattr
+    CODE: XATT2
+    """
+    sess = env.c1.new_client_session(env.testname(t))
+    open_op = open_create_file_op(sess, env.testname(t), open_create=OPEN4_CREATE)
+    res = sess.compound(open_op + [op.close(0, current_stateid)])
+    check(res, NFS4_OK)
+
+    fh = res.resarray[-2].object
+    res = sess.compound([op.putfh(fh), op.getxattr("user.attr1".encode("UTF-8"))])
+    check(res, NFS4ERR_NOXATTR)
+
+def testCreateNewAttr(t, env):
+    """Server MUST return NFS4_ON on create.
+
+    FLAGS: xattr
+    CODE: XATT3
+    """
+    sess = env.c1.new_client_session(env.testname(t))
+    open_op = open_create_file_op(sess, env.testname(t), open_create=OPEN4_CREATE)
+    res = sess.compound(open_op + [op.close(0, current_stateid)])
+    check(res, NFS4_OK)
+
+    fh = res.resarray[-2].object
+    key = "user.attr1".encode("UTF-8")
+    value = "value1".encode("UTF-8")
+    res = sess.compound([op.putfh(fh), op.setxattr(SETXATTR4_CREATE, key, value)])
+    check(res)
+
+    res = sess.compound([op.putfh(fh), op.getxattr(key)])
+    check(res)
+    if value != res.resarray[-1].gxr_value:
+        fail("Returned value doesn't")
+
+def testCreateNewIfMissingAttr(t, env):
+    """Server MUST update existing attribute with SETXATTR4_EITHER.
+
+    FLAGS: xattr
+    CODE: XATT4
+    """
+    sess = env.c1.new_client_session(env.testname(t))
+    open_op = open_create_file_op(sess, env.testname(t), open_create=OPEN4_CREATE)
+    res = sess.compound(open_op + [op.close(0, current_stateid)])
+    check(res, NFS4_OK)
+
+    fh = res.resarray[-2].object
+    key = "user.attr1".encode("UTF-8")
+    value = "value1".encode("UTF-8")
+    res = sess.compound([op.putfh(fh), op.setxattr(SETXATTR4_EITHER, key, value)])
+    check(res)
+
+    res = sess.compound([op.putfh(fh), op.getxattr(key)])
+    check(res)
+    if value != res.resarray[-1].gxr_value:
+        fail("Returned value doesn't match with expected one.")
+
+def testUpdateOfMissingAttr(t, env):
+    """Server MUST return NFS4ERR_NOXATTR on update of missing attribute.
+
+    FLAGS: xattr
+    CODE: XATT5
+    """
+    sess = env.c1.new_client_session(env.testname(t))
+    open_op = open_create_file_op(sess, env.testname(t), open_create=OPEN4_CREATE)
+    res = sess.compound(open_op + [op.close(0, current_stateid)])
+    check(res, NFS4_OK)
+
+    fh = res.resarray[-2].object
+    key = "user.attr1".encode("UTF-8")
+    value = "value1".encode("UTF-8")
+    res = sess.compound([op.putfh(fh), op.setxattr(SETXATTR4_REPLACE, key, value)])
+    check(res, NFS4ERR_NOXATTR)
+
+def testExclusiveCreateAttr(t, env):
+    """Server MUST return NFS4ERR_EXIST on create of existing attribute.
+
+    FLAGS: xattr
+    CODE: XATT6
+    """
+    sess = env.c1.new_client_session(env.testname(t))
+    open_op = open_create_file_op(sess, env.testname(t), open_create=OPEN4_CREATE)
+    res = sess.compound(open_op + [op.close(0, current_stateid)])
+    check(res, NFS4_OK)
+
+    fh = res.resarray[-2].object
+    key = "user.attr1".encode("UTF-8")
+    value = "value1".encode("UTF-8")
+    res = sess.compound([op.putfh(fh), op.setxattr(SETXATTR4_CREATE, key, value)])
+    check(res)
+
+    res = sess.compound([op.putfh(fh), op.setxattr(SETXATTR4_CREATE, key, value)])
+    check(res, NFS4ERR_EXIST)
+
+def testUpdateExistingAttr(t, env):
+    """Server MUST return NFS4_ON on update of existing attribute.
+
+    FLAGS: xattr
+    CODE: XATT7
+    """
+    sess = env.c1.new_client_session(env.testname(t))
+    open_op = open_create_file_op(sess, env.testname(t), open_create=OPEN4_CREATE)
+    res = sess.compound(open_op + [op.close(0, current_stateid)])
+    check(res, NFS4_OK)
+
+    fh = res.resarray[-2].object
+    key = "user.attr1".encode("UTF-8")
+    value1 = "value1".encode("UTF-8")
+    value2 = "value2".encode("UTF-8")
+    res = sess.compound([op.putfh(fh), op.setxattr(SETXATTR4_CREATE, key, value1)])
+    check(res)
+
+    res = sess.compound([op.putfh(fh), op.setxattr(SETXATTR4_REPLACE, key, value2)])
+    check(res)
+
+    res = sess.compound([op.putfh(fh), op.getxattr(key)])
+    check(res)
+    if value2 != res.resarray[-1].gxr_value:
+        fail("Returned value doesn't match with expected one.")
+
+def testRemoveNonExistingAttr(t, env):
+    """Server MUST return NFS4ERR_NOXATTR on remove of non existing attribute.
+
+    FLAGS: xattr
+    CODE: XATT8
+    """
+    sess = env.c1.new_client_session(env.testname(t))
+    open_op = open_create_file_op(sess, env.testname(t), open_create=OPEN4_CREATE)
+    res = sess.compound(open_op + [op.close(0, current_stateid)])
+    check(res, NFS4_OK)
+
+    fh = res.resarray[-2].object
+    key = "user.attr1".encode("UTF-8")
+
+    res = sess.compound([op.putfh(fh), op.removexattr(key)])
+    check(res, NFS4ERR_NOXATTR)
+
+def testRemoveExistingAttr(t, env):
+    """Server MUST return NFS4_ON on remove of existing attribute.
+
+    FLAGS: xattr
+    CODE: XATT9
+    """
+    sess = env.c1.new_client_session(env.testname(t))
+    open_op = open_create_file_op(sess, env.testname(t), open_create=OPEN4_CREATE)
+    res = sess.compound(open_op + [op.close(0, current_stateid)])
+    check(res, NFS4_OK)
+
+    fh = res.resarray[-2].object
+    key = "user.attr1".encode("UTF-8")
+    value = "value1".encode("UTF-8")
+    res = sess.compound([op.putfh(fh), op.setxattr(SETXATTR4_CREATE, key, value)])
+    check(res)
+
+    res = sess.compound([op.putfh(fh), op.removexattr(key)])
+    check(res)
+
+def testListNoAttrs(t, env):
+    """Server MUST return NFS4_ON an empty list if no attributes defined.
+
+    FLAGS: xattr
+    CODE: XATT10
+    """
+    sess = env.c1.new_client_session(env.testname(t))
+    open_op = open_create_file_op(sess, env.testname(t), open_create=OPEN4_CREATE)
+    res = sess.compound(open_op + [op.close(0, current_stateid)])
+    check(res, NFS4_OK)
+
+    fh = res.resarray[-2].object
+
+    res = sess.compound([op.putfh(fh), op.listxattrs(0, 8192)])
+    check(res)
+
+    if not res.resarray[-1].lxr_eof:
+        fail("EOF flag is not set")
+
+    if len(res.resarray[-1].lxr_names) > 0:
+        fail("Unexpected attributes returned")
+
+def testListAttrs(t, env):
+    """Server MUST return NFS4_ON and list of defined attributes.
+
+    FLAGS: xattr
+    CODE: XATT11
+    """
+    sess = env.c1.new_client_session(env.testname(t))
+    open_op = open_create_file_op(sess, env.testname(t), open_create=OPEN4_CREATE)
+    res = sess.compound(open_op + [op.close(0, current_stateid)])
+    check(res, NFS4_OK)
+
+    fh = res.resarray[-2].object
+
+    keys = ["user.attr1", "user.attr2", "user.attr3", "user.attr4", "user.attr5", "user.attr6"]
+
+    for key in keys:
+        value = "value".encode("UTF-8")
+        res = sess.compound([op.putfh(fh), op.setxattr(SETXATTR4_CREATE, key.encode("UTF-8"), value)])
+        check(res)
+
+    res = sess.compound([op.putfh(fh), op.listxattrs(0, 8192)])
+    check(res)
+
+    xattrs = [key.decode("UTF-8") for key in res.resarray[-1].lxr_names]
+    if len(xattrs) != len(keys):
+        fail("Invalid number of entries returuned <expected> %d, <actual> %d" % (len(keys), len(xattrs)))
+
+    for key in keys:
+        if key not in xattrs:
+            fail("Unexpected attribute received %s" % key)
diff --git a/nfs4.1/xdrdef/nfs4.x b/nfs4.1/xdrdef/nfs4.x
index c2c9361..7b4e755 100644
--- a/nfs4.1/xdrdef/nfs4.x
+++ b/nfs4.1/xdrdef/nfs4.x
@@ -259,7 +259,12 @@ enum nfsstat4 {
  NFS4ERR_OFFLOAD_DENIED = 10091,/* dest not allowing copy  */
  NFS4ERR_WRONG_LFS      = 10092,/* LFS not supported       */
  NFS4ERR_BADLABEL       = 10093,/* incorrect label         */
- NFS4ERR_OFFLOAD_NO_REQS= 10094 /* dest not meeting reqs   */
+ NFS4ERR_OFFLOAD_NO_REQS= 10094, /* dest not meeting reqs   */
+
+ /* rfc8276 (xattr) */
+
+NFS4ERR_NOXATTR         = 10095, /* xattr does not exist    */
+NFS4ERR_XATTR2BIG       = 10096  /* xattr value is too big  */
 };
 
 /*
@@ -809,6 +814,11 @@ struct write_response4 {
         verifier4       wr_writeverf;
 };
 
+/*
+ * rfc8276 (xattr)
+ */
+ typedef component4     xattrkey4;
+ typedef opaque         xattrvalue4<>;
 
 /*
  * NFSv4.1 attributes
@@ -900,6 +910,10 @@ typedef change_attr_type4
                 fattr4_change_attr_type;
 typedef sec_label4      fattr4_sec_label;
 typedef uint32_t        fattr4_clone_blksize;
+/*
+ * rfc8276 (xattr)
+ */
+typedef bool            fattr4_xattr_support;
 
 %/*
 % * REQUIRED Attributes
@@ -1002,6 +1016,11 @@ const FATTR4_SPACE_FREED        = 78;
 const FATTR4_CHANGE_ATTR_TYPE   = 79;
 const FATTR4_SEC_LABEL          = 80;
 
+%/*
+% * new in rfc 8276 (xattr)
+% */
+const FATTR4_XATTR_SUPPORT      = 82;
+
 /*
  * File attribute container
  */
@@ -1335,6 +1354,16 @@ enum nfs_opnum4 {
  OP_SEEK                = 69,
  OP_WRITE_SAME          = 70,
  OP_CLONE               = 71,
+
+ %
+ % /* new in rfc8276 (xattr) */
+ %
+ OP_GETXATTR            = 72,
+ OP_SETXATTR            = 73,
+ OP_LISTXATTRS          = 74,
+ OP_REMOVEXATTR         = 75,
+
+
  OP_ILLEGAL             = 10044
 };
 
@@ -3136,6 +3165,74 @@ enum ff_cb_recall_any_mask {
     FF_RCA4_TYPE_MASK_RW   = -1
 };
 
+
+/*
+ * rfc8276(xattr)
+ */
+
+struct GETXATTR4args {
+     /* CURRENT_FH: file */
+     xattrkey4     gxa_name;
+};
+
+union GETXATTR4res switch (nfsstat4 gxr_status) {
+case NFS4_OK:
+        xattrvalue4   gxr_value;
+default:
+        void;
+};
+
+enum setxattr_option4 {
+        SETXATTR4_EITHER      = 0,
+        SETXATTR4_CREATE      = 1,
+        SETXATTR4_REPLACE     = 2
+};
+
+struct SETXATTR4args {
+        /* CURRENT_FH: file */
+        setxattr_option4 sxa_option;
+        xattrkey4        sxa_key;
+        xattrvalue4      sxa_value;
+};
+
+union SETXATTR4res switch (nfsstat4 sxr_status) {
+ case NFS4_OK:
+        change_info4      sxr_info;
+ default:
+        void;
+};
+
+struct LISTXATTRS4args {
+        /* CURRENT_FH: file */
+        nfs_cookie4    lxa_cookie;
+        count4         lxa_maxcount;
+};
+
+struct LISTXATTRS4resok {
+        nfs_cookie4    lxr_cookie;
+        xattrkey4      lxr_names<>;
+        bool           lxr_eof;
+};
+
+union LISTXATTRS4res switch (nfsstat4 lxr_status) {
+ case NFS4_OK:
+        LISTXATTRS4resok  lxr_value;
+ default:
+        void;
+};
+
+struct REMOVEXATTR4args {
+        /* CURRENT_FH: file */
+        xattrkey4      rxa_name;
+};
+
+union REMOVEXATTR4res switch (nfsstat4 rxr_status) {
+ case NFS4_OK:
+        change_info4      rxr_info;
+ default:
+        void;
+};
+
 /*
  * Operation arrays (the rest)
  */
@@ -3257,6 +3354,12 @@ union nfs_argop4 switch (nfs_opnum4 argop) {
  case OP_WRITE_SAME:    WRITE_SAME4args opwrite_same;
  case OP_CLONE:         CLONE4args opclone;
 
+/* Operations new in rfc8276 (xattr) */
+case OP_GETXATTR:      GETXATTR4args opgetxattr;
+case OP_SETXATTR:      SETXATTR4args opsetxattr;
+case OP_LISTXATTRS:    LISTXATTRS4args oplistxattrs;
+case OP_REMOVEXATTR:   REMOVEXATTR4args opremovexattr;
+
  /* Operations not new to NFSv4.1 */
  case OP_ILLEGAL:       void;
 };
@@ -3386,6 +3489,12 @@ union nfs_resop4 switch (nfs_opnum4 resop) {
  case OP_WRITE_SAME:    WRITE_SAME4res opwrite_same;
  case OP_CLONE:         CLONE4res opclone;
 
+/* Operations new in rfc8276 (xattr) */
+case OP_GETXATTR:      GETXATTR4res opgetxattr;
+case OP_SETXATTR:      SETXATTR4res opsetxattr;
+case OP_LISTXATTRS:    LISTXATTRS4res oplistxattrs;
+case OP_REMOVEXATTR:   REMOVEXATTR4res opremovexattr;
+
  /* Operations not new to NFSv4.1 */
  case OP_ILLEGAL:       ILLEGAL4res opillegal;
 };
-- 
2.25.1

