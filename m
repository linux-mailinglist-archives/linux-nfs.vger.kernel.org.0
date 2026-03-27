Return-Path: <linux-nfs+bounces-20444-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iNILJr8Fxml2FQUAu9opvQ
	(envelope-from <linux-nfs+bounces-20444-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Mar 2026 05:21:19 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E1B333F130
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Mar 2026 05:21:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DF5D53018741
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Mar 2026 04:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA4EF318EFF;
	Fri, 27 Mar 2026 04:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O/Bwd9ZL"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5EC1D5141
	for <linux-nfs@vger.kernel.org>; Fri, 27 Mar 2026 04:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774585114; cv=none; b=MzgfD6TkIV1usoMRfAtSq1gH437T0J/dnuDdel4Ev08LLj/PaZ7VT2Bba+5zT4e9tULvFL48fRJ3+o+UTh3aWcb4divhZtzFhpIDHXmyMcZEM4G4tZEWnpEmfrazXTQkSbNuG26RetLkp2eZfIpBYAK2mhATV2WSmS2wz2KSraA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774585114; c=relaxed/simple;
	bh=WX2bPM1pQCbxnlm1fN+UecCksj+nK+yOMO8efZB5Nj4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iNZPmqoun8gUN8nwNA+wTZs2aUnpoNwXdKYqwhNatc7Xri0H3JUUx79LpjYLMDQR+nk8w64pWvs+zXLvFgPWWXnjWE2hWiwlReb7sl5LQRj3j5GLexkV8+w7WTK1C7eRD8NnrR8b2zNINSk6FXaAm3wSs3ERi8IrKuWKKGPOAA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O/Bwd9ZL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774585112;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+NDCTyDKD2FoxPB+MvB19u9xboGqx5F3Fz0onjJBuWY=;
	b=O/Bwd9ZL51kIARihNmqPgNGUigXvSJu+u2OI2FSp82e/0yIM95XhFaOvdj5Sm8FdPuoS0T
	TI/PAB6aKUSTx+Y8gbek6RzFGAQSdSgtu9KhFeRrwyUSwzhecB6o9RQTuyTDHOnYiL95mJ
	aV8Y/EZ42NGPqX1kVsUSoJh2ZQsuK18=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-265-zvPSXKGaPBaSxpVdxmd0sQ-1; Fri,
 27 Mar 2026 00:18:30 -0400
X-MC-Unique: zvPSXKGaPBaSxpVdxmd0sQ-1
X-Mimecast-MFC-AGG-ID: zvPSXKGaPBaSxpVdxmd0sQ_1774585109
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 597E3195608E;
	Fri, 27 Mar 2026 04:18:29 +0000 (UTC)
Received: from localhost (dell-per660-10.rhts.eng.pek2.redhat.com [10.73.4.30])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 77C8118001FE;
	Fri, 27 Mar 2026 04:18:28 +0000 (UTC)
From: Jianhong Yin <jiyin@redhat.com>
To: linux-nfs@vger.kernel.org
Cc: calum.mackay@oracle.com,
	jlayton@kernel.org,
	bcodding@redhat.com,
	smayhew@redhat.com,
	jiyin@redhat.com
Subject: [PATCH 2/4] pynfs: more nfs4.1/nfs4server.py fixes
Date: Fri, 27 Mar 2026 12:16:19 +0800
Message-ID: <20260327041620.2115456-3-jiyin@redhat.com>
In-Reply-To: <20260327041620.2115456-2-jiyin@redhat.com>
References: <20260327041620.2115456-2-jiyin@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20444-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiyin@redhat.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,root.id:url]
X-Rspamd-Queue-Id: 2E1B333F130
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Scott Mayhew <smayhew@redhat.com>

Signed-off-by: Scott Mayhew <smayhew@redhat.com>
---
 nfs4.1/dataserver.py |  2 +-
 nfs4.1/fs.py         | 17 +++++++++++++----
 nfs4.1/nfs4server.py | 12 ++++++++++--
 nfs4.1/nfs4state.py  | 28 ++++++++++++++--------------
 4 files changed, 38 insertions(+), 21 deletions(-)

diff --git a/nfs4.1/dataserver.py b/nfs4.1/dataserver.py
index 74ca864..4d3a305 100644
--- a/nfs4.1/dataserver.py
+++ b/nfs4.1/dataserver.py
@@ -111,7 +111,7 @@ class DataServer41(DataServer):
                 self.reset()
             else:
                 log.error("Unhandled status %s from DS %s" %
-                          (nfsstat4[res.status], self.server))
+                          (const4.nfsstat4[res.status], self.server))
                 raise Exception("Dataserver communication error")
 
     def connect(self):
diff --git a/nfs4.1/fs.py b/nfs4.1/fs.py
index 41149f1..305326b 100644
--- a/nfs4.1/fs.py
+++ b/nfs4.1/fs.py
@@ -14,6 +14,14 @@ log_o = logging.getLogger("fs.obj")
 log_fs = logging.getLogger("fs")
 logging.addLevelName(5, "FUNCT")
 
+def _hasattr(obj, attr):
+    try:
+        getattr(obj, attr)
+        return True
+    except:
+        pass
+    return False
+
 class MetaData(object):
     """Contains everything that needs to be stored
 
@@ -58,7 +66,7 @@ class FSObject(object):
     def _getsize_locked(self):
         # STUB
         if self.fattr4_type == NF4REG:
-            if hasattr(self.file, "__len__"):
+            if _hasattr(self.file, "__len__"):
                 return len(self.file)
             else:
                 orig = self.file.tell()
@@ -185,7 +193,7 @@ class FSObject(object):
         pass
 
     def __setattr__(self, name, value):
-        if name != "meta" and hasattr(self.meta, name):
+        if name != "meta" and _hasattr(self.meta, name):
             setattr(self.meta, name, value)
         else:
             object.__setattr__(self, name, value)
@@ -317,7 +325,8 @@ class FSObject(object):
                                     tag = "attr %i not writable" % attr)
                 name = "fattr4_%s" % nfs4lib.attr_name(attr)
                 # Note all writable attrs are object attrs
-                if hasattr(self, name):
+
+                if _hasattr(self, name):
                     base = self
                 else:
                     base = self.meta
@@ -961,7 +970,7 @@ class StubFS_Disk(FileSystem):
         d["root"] = self.root.id
         d["fsid"] = self.fsid
         for attr in dir(self):
-            if attr.startswith("fattr4_") and not hasattr(self.__class__, attr):
+            if attr.startswith("fattr4_") and not _hasattr(self.__class__, attr):
                 d[attr] = getattr(self, attr)
         d.sync()
 
diff --git a/nfs4.1/nfs4server.py b/nfs4.1/nfs4server.py
index 47d6cba..6422008 100755
--- a/nfs4.1/nfs4server.py
+++ b/nfs4.1/nfs4server.py
@@ -16,7 +16,7 @@ import random
 import struct
 import collections
 import logging
-from nfs4state import find_state
+from nfs4state import find_state, SHARE, BYTE
 from nfs4commoncode import CompoundState, encode_status, encode_status_by_name
 from fs import RootFS, ConfigFS
 from config import ServerConfig, ServerPerClientConfig, OpsConfigServer, Actions
@@ -27,6 +27,14 @@ log_41 = logging.getLogger("nfs.server")
 
 log_cfg = logging.getLogger("nfs.server.opconfig")
 
+def _hasattr(obj, attr):
+    try:
+        getattr(obj, attr)
+        return True
+    except:
+        pass
+    return False
+
 ##################################################
 # Set various global constants and magic numbers #
 ##################################################
@@ -1510,7 +1518,7 @@ class NFS4Server(rpc.Server):
             else:
                 base = obj
             name = "fattr4_%s" % nfs4lib.attr_name(attr)
-            if hasattr(base, name) and (obj.fs.fattr4_supported_attrs & 1<<attr): # STUB we should be able to remove hasattr
+            if _hasattr(base, name) and (obj.fs.fattr4_supported_attrs & 1<<attr): # STUB we should be able to remove hasattr
                 ret_dict[attr] = getattr(base, name)
             else:
                 if ignore:
diff --git a/nfs4.1/nfs4state.py b/nfs4.1/nfs4state.py
index d675a6b..3ff6cdf 100644
--- a/nfs4.1/nfs4state.py
+++ b/nfs4.1/nfs4state.py
@@ -21,7 +21,7 @@ POSIXLOCK = False
 SHARE, BYTE, DELEG, LAYOUT, ANON = range(5) # State types
 NORMAL, CB_INIT, CB_SENT, CB_RECEIVED, INVALID = range(5) # delegation/layout states
 
-DS_MAGIC = "\xa5" # STUB part of HACK code to ignore DS stateid
+DS_MAGIC = b"\xa5" # STUB part of HACK code to ignore DS stateid
 
 @contextmanager
 def find_state(env, stateid, allow_0=True, allow_bypass=False):
@@ -34,7 +34,7 @@ def find_state(env, stateid, allow_0=True, allow_bypass=False):
         # Could meddle with state.other here if needed
         anon = True
     # First we convert special stateids, see draft22 8.2.3
-    if stateid.other == "\0" * 12:
+    if stateid.other == b"\0" * 12:
         if allow_0 and stateid.seqid == 0:
             state = env.cfh.state.anon0
             anon = True
@@ -43,10 +43,10 @@ def find_state(env, stateid, allow_0=True, allow_bypass=False):
             # Special stateids must be passed in explicitly
             if stateid in [None, nfs4lib.state00, nfs4lib.state11]:
                 raise NFS4Error(NFS4ERR_BAD_STATEID,
-                                tag="Current stateid not useable")
+                                tag=b"Current stateid not useable")
         else:
             raise NFS4Error(NFS4ERR_BAD_STATEID)
-    elif stateid.other == "\xff" * 12:
+    elif stateid.other == b"\xff" * 12:
         if allow_0 and stateid.seqid == 0xffffffff:
             stateid = nfs4lib.state00 # Needed to pass seqid checks below
             state = (env.cfh.state.anon1 if allow_bypass else env.cfh.state.anon0)
@@ -57,31 +57,31 @@ def find_state(env, stateid, allow_0=True, allow_bypass=False):
         # Now map stateid to find state
         state = env.session.client.state.get(stateid.other, None)
         if state is None:
-            raise NFS4Error(NFS4ERR_BAD_STATEID, tag="stateid not known")
+            raise NFS4Error(NFS4ERR_BAD_STATEID, tag=b"stateid not known")
         if state.file != env.cfh:
             raise NFS4Error(NFS4ERR_BAD_STATEID,
-                            tag="cfh %r does not match stateid %r" %
+                            tag=b"cfh %r does not match stateid %r" %
                             (state.file.fh, env.cfh.fh))
     state.lock.acquire()
     # It is possible that while waiting to get the lock, the state has been
     # removed.  In that case, the removal sets the invalid flag.
     if state.invalid:
         state.release()
-        raise NFS4Error(NFS4ERR_BAD_STATEID, tag="stateid not known (race)")
+        raise NFS4Error(NFS4ERR_BAD_STATEID, tag=b"stateid not known (race)")
     if state.type != LAYOUT:
         # See draft22 8.2.2
         if stateid.seqid != 0 and stateid.seqid != state.seqid:
             old = (stateid.seqid < state.seqid)
             state.lock.release()
             if old:
-                raise NFS4Error(NFS4ERR_OLD_STATEID, tag="bad stateid.seqid")
+                raise NFS4Error(NFS4ERR_OLD_STATEID, tag=b"bad stateid.seqid")
             else:
-                raise NFS4Error(NFS4ERR_BAD_STATEID, tag="bad stateid.seqid")
+                raise NFS4Error(NFS4ERR_BAD_STATEID, tag=b"bad stateid.seqid")
     else:
         # See draft22 12.5.3
         if stateid.seqid == 0:
             state.lock.release()
-            raise NFS4Error(NFS4ERR_BAD_STATEID, tag="layout stateid.seqid==0")
+            raise NFS4Error(NFS4ERR_BAD_STATEID, tag=b"layout stateid.seqid==0")
     try:
         yield state
     finally:
@@ -342,8 +342,8 @@ class AnonState(FileStateTyped):
     def __init__(self, *args, **kwargs):
         kwargs["depth"] = 1 # key = (int,)
         FileStateTyped.__init__(self, *args, **kwargs)
-        self._tree[(0 ,)] = AnonEntry("\x00" * 12, self, (0,))
-        self._tree[(1 ,)] = AnonEntry("\xff" * 12, self, (1,))
+        self._tree[(0 ,)] = AnonEntry(b"\x00" * 12, self, (0,))
+        self._tree[(1 ,)] = AnonEntry(b"\xff" * 12, self, (1,))
         self._tree[(DS_MAGIC, )] = DSEntry(DS_MAGIC * 12, self, (DS_MAGIC, ))
 
 class ShareState(FileStateTyped):
@@ -686,9 +686,9 @@ class ShareEntry(StateTableEntry):
 #             # This test is the whole reason for the silly 3-bit
 #             # representation.  It basically prevents the seqence
 #             # OPEN(share=BOTH), OPENDOWNGRADE(share=SINGLE).
-#             raise NFS4Error(NFS4ERR_INVAL, tag="Failed history test")
+#             raise NFS4Error(NFS4ERR_INVAL, tag=b"Failed history test")
 #         if access == 0 and deny != 0:
-#             raise NFS4Error(NFS4ERR_INVAL, tag="access==0")
+#             raise NFS4Error(NFS4ERR_INVAL, tag=b"access==0")
 #         self.access_hist, self.deny_hist = new_access, new_deny
 #         self.share_access, self.share_deny = access, deny
 
-- 
2.53.0


