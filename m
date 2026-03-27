Return-Path: <linux-nfs+bounces-20443-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IIrxKbIFxml2FQUAu9opvQ
	(envelope-from <linux-nfs+bounces-20443-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Mar 2026 05:21:06 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E5B33F129
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Mar 2026 05:21:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 580A730151E9
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Mar 2026 04:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADFAD358365;
	Fri, 27 Mar 2026 04:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hgXagZcx"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2906D36C5B1
	for <linux-nfs@vger.kernel.org>; Fri, 27 Mar 2026 04:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774585111; cv=none; b=J3ss40rT9PMaJ0QVM95cg9UYPiq2DFNde5FqsS5Oh/gXkTOYSDd4W4Ra7wyxbAEwqeXatibeKXJ1ptiUokYUrLsGkJKFAm+E+4gWJDEQ22tAcmdzFEAlHh2bUe6kUSas2QVDhIBPAcjFOANcfA6RHkjfEauDk/O0gajHQgue+QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774585111; c=relaxed/simple;
	bh=KnYgn0+D5XvYTgDgxJI4Uz0wdzhw8pVvwQNUXHRKMl8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cl7/bDYZ1wlXDysEsVhGmLSX0m8LLfnTCp+XxL3JlSkul8m8GJWYHte3PVJ/oacy2n3x1GVXw77EY283lIe94hTV7zf8J5545Nn6GfbCZbgbHgzQUAzH98+aueeRX8i4xbHmabLHnRGnC2m69f8F0QL2vDaPqrTBaGDZdG8Zdzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hgXagZcx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774585108;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nFq0HOKAJeTWAhT/0yWrmuqvdTdQzXK3rHFrtTyb9B0=;
	b=hgXagZcxb9ZXGXH4TSfDvh5bYv9DMxVvDydPvxBflZ54FbeD6hFihPr3zVwC5zFQ9lscw/
	dLFayutfbCn//2GP9mOze4BHg/k+VS25NhgEIumGYdHDTgifbNCa9W7K4e/MXTLxZEeUBK
	68fqWt9FwIWuGuKqdw8xnfGc7odJdPE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-257-Ai6R_bAYNieP_9YH1dHvUg-1; Fri,
 27 Mar 2026 00:18:26 -0400
X-MC-Unique: Ai6R_bAYNieP_9YH1dHvUg-1
X-Mimecast-MFC-AGG-ID: Ai6R_bAYNieP_9YH1dHvUg_1774585104
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 10405195608B;
	Fri, 27 Mar 2026 04:18:24 +0000 (UTC)
Received: from localhost (dell-per660-10.rhts.eng.pek2.redhat.com [10.73.4.30])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 951531800671;
	Fri, 27 Mar 2026 04:18:22 +0000 (UTC)
From: Jianhong Yin <jiyin@redhat.com>
To: linux-nfs@vger.kernel.org
Cc: calum.mackay@oracle.com,
	jlayton@kernel.org,
	bcodding@redhat.com,
	smayhew@redhat.com,
	jiyin@redhat.com,
	Jianhong Yin <yin-jianhong@163.com>
Subject: [PATCH v2 1/4] pynfs: fix nfs4.1/nfs4server.py
Date: Fri, 27 Mar 2026 12:16:18 +0800
Message-ID: <20260327041620.2115456-2-jiyin@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20443-lists,linux-nfs=lfdr.de];
	FREEMAIL_CC(0.00)[oracle.com,kernel.org,redhat.com,163.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiyin@redhat.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F2E5B33F129
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Scott Mayhew <smayhew@redhat.com>

Signed-off-by: Jianhong Yin <yin-jianhong@163.com>
Signed-off-by: Scott Mayhew <smayhew@redhat.com>
---
 nfs4.1/config.py                 | 20 ++++-----
 nfs4.1/dataserver.py             | 30 ++++++-------
 nfs4.1/fs.py                     | 37 ++++++++--------
 nfs4.1/nfs4client.py             |  2 +-
 nfs4.1/nfs4server.py             | 73 ++++++++++++++++----------------
 nfs4.1/nfs4state.py              | 18 ++++----
 nfs4.1/sample_code/ds_exports.py |  2 +-
 nfs4.1/server_exports.py         | 12 +++---
 8 files changed, 93 insertions(+), 101 deletions(-)

diff --git a/nfs4.1/config.py b/nfs4.1/config.py
index 3777e31..8691e1c 100644
--- a/nfs4.1/config.py
+++ b/nfs4.1/config.py
@@ -117,8 +117,7 @@ class MetaConfig(type):
             setattr(cls, attr.name, property(make_get(i), make_set(i),
                                              None, attr.comment))
 
-class ServerConfig(object):
-    __metaclass__ = MetaConfig
+class ServerConfig(metaclass=MetaConfig):
     attrs =  [ConfigLine("allow_null_data", False,
                          "Server allows NULL calls to contain data"),
               ConfigLine("tag_info", True,
@@ -131,17 +130,16 @@ class ServerConfig(object):
 
     def __init__(self):
         self.minor_id = os.getpid()
-        self.major_id = "PyNFSv4.1"
+        self.major_id = b"PyNFSv4.1"
         self._owner = server_owner4(self.minor_id, self.major_id)
-        self.scope = "Default_Scope"
-        self.impl_domain = "citi.umich.edu"
-        self.impl_name = "pynfs X.X"
+        self.scope = b"Default_Scope"
+        self.impl_domain = b"citi.umich.edu"
+        self.impl_name = b"pynfs X.X"
         self.impl_date = 1172852767 # int(time.time())
         self.impl_id = nfs_impl_id4(self.impl_domain, self.impl_name,
                                  nfs4lib.get_nfstime(self.impl_date))
 
-class ServerPerClientConfig(object):
-    __metaclass__ = MetaConfig
+class ServerPerClientConfig(metaclass=MetaConfig):
     attrs = [ConfigLine("maxrequestsize", 16384,
                         "Maximum request size the server will accept"),
              ConfigLine("maxresponsesize", 16384,
@@ -175,15 +173,13 @@ _invalid_ops = [
     OP_RELEASE_LOCKOWNER, OP_ILLEGAL,
     ]
 
-class OpsConfigServer(object):
-    __metaclass__ = MetaConfig
+class OpsConfigServer(metaclass=MetaConfig):
     value = ['ERROR', 0, 0] # Note must have value == _opline(value)
     attrs = (lambda value=value: [ConfigLine(name.lower()[3:], value, "Generic comment", _opline)
                                   for name in nfs_opnum4.values()])()
 
 
-class Actions(object):
-    __metaclass__ = MetaConfig
+class Actions(metaclass=MetaConfig):
     attrs = [ConfigLine("reboot", 0,
                         "Any write here will simulate a server reboot",
                         _action),
diff --git a/nfs4.1/dataserver.py b/nfs4.1/dataserver.py
index f76ca5a..74ca864 100644
--- a/nfs4.1/dataserver.py
+++ b/nfs4.1/dataserver.py
@@ -59,27 +59,27 @@ class DataServer(object):
 
     def get_netaddr4(self):
         # STUB server multipathing not supported yet
-        uaddr = '.'.join([self.server,
-                          str(self.port >> 8),
-                          str(self.port & 0xff)])
-        return type4.netaddr4(self.proto, uaddr)
+        uaddr = b'.'.join([self.server.encode("utf-8"),
+                          str(self.port >> 8).encode("utf-8"),
+                          str(self.port & 0xff).encode("utf-8")])
+        return type4.netaddr4(self.proto.encode("utf-8"), uaddr)
 
     def get_multipath_netaddr4s(self):
         netaddr4s = []
         for addr in self.multipath_servers:
             server, port = addr
-            uaddr = '.'.join([server,
-                            str(port >> 8),
-                            str(port & 0xff)])
-            proto = "tcp"
+            uaddr = b'.'.join([server.encode("utf-8"),
+                            str(port >> 8).encode("utf-8"),
+                            str(port & 0xff).encode("utf-8")])
+            proto = b"tcp"
             if server.find(':') >= 0:
-                proto = "tcp6"
+                proto = b"tcp6"
 
             netaddr4s.append(type4.netaddr4(proto, uaddr))
         return netaddr4s
 
     def fh_to_name(self, mds_fh):
-        return hashlib.sha1("%r" % mds_fh).hexdigest()
+        return hashlib.sha1(mds_fh).hexdigest()
 
     def connect(self):
         raise NotImplemented
@@ -122,7 +122,7 @@ class DataServer41(DataServer):
                                         summary=self.summary)
         self.c1.set_cred(self.cred1)
         self.c1.null()
-        c = self.c1.new_client("DS.init_%s" % self.server)
+        c = self.c1.new_client(b"DS.init_%s" % self.server.encode("utf-8"))
         # This is a hack to ensure MDS/DS communication path is at least
         # as wide as the client/MDS channel (at least for linux client)
         fore_attrs = type4.channel_attrs4(0, 16384, 16384, 2868, 8, 8, [])
@@ -154,11 +154,11 @@ class DataServer41(DataServer):
         access = const4.OPEN4_SHARE_ACCESS_BOTH
         deny = const4.OPEN4_SHARE_DENY_NONE
         attrs = {const4.FATTR4_MODE: 0o777}
-        owner = "mds"
+        owner = b"mds"
         mode = const4.GUARDED4
         verifier = self.sess.c.verifier
         openflag = type4.openflag4(const4.OPEN4_CREATE, type4.createhow4(mode, attrs, verifier))
-        name = self.fh_to_name(mds_fh)
+        name = self.fh_to_name(mds_fh).encode("utf-8")
         while True:
             if mds_fh in self.filehandles:
                 return
@@ -338,14 +338,14 @@ class DSDevice(object):
                 server_list = server_list[:-1]
                 try:
                     log.info("Adding dataserver ip:%s port:%s path:%s" %
-                             (server, port, '/'.join(path)))
+                             (server, port, b'/'.join(path)))
                     ds = DataServer41(server, port, path, mdsds=self.mdsds,
                                     multipath_servers=server_list,
                                     summary=server_obj.summary)
                     self.list.append(ds)
                 except socket.error:
                     log.critical("cannot access %s:%i/%s" %
-                                 (server, port, '/'.join(path)))
+                                 (server, port, b'/'.join(path)))
                     sys.exit(1)
         self.active = 1
         self.address_body = self._get_address_body()
diff --git a/nfs4.1/fs.py b/nfs4.1/fs.py
index 7f690bb..41149f1 100644
--- a/nfs4.1/fs.py
+++ b/nfs4.1/fs.py
@@ -6,10 +6,7 @@ from nfs4lib import NFS4Error
 import struct
 import logging
 from locking import Lock, RWLock
-try:
-    import cStringIO.StringIO as StringIO
-except:
-    from io import StringIO
+from io import BytesIO
 import time
 from xdrdef.nfs4_pack import NFS4Packer
 
@@ -182,7 +179,7 @@ class FSObject(object):
 
     def init_file(self):
         """Hook for subclasses that want to use their own file class"""
-        return StringIO()
+        return BytesIO()
 
     def _init_hook(self):
         pass
@@ -671,7 +668,7 @@ class RootFS(FileSystem):
         self.fattr4_supported_attrs |= 1 << FATTR4_MAXWRITE
         self.fattr4_supported_attrs |= 1 << FATTR4_MAXREAD
         self.fsid = (0,0)
-        self.read_only = True
+        self.read_only = False
 
     def alloc_id(self):
         self._nextid += 1
@@ -711,7 +708,7 @@ class ConfigObj(FSObject):
         self._reset()
 
     def _reset(self):
-        self.file = StringIO()
+        self.file = BytesIO()
         self.file.write("# %s\n" % self.configline.comment)
         value = self.configline.value
         if type(value) is list:
@@ -931,7 +928,7 @@ import shutil
 import shelve
 
 class StubFS_Disk(FileSystem):
-    _fs_data_name = "fs_info" # DB name where we store persistent data
+    _fs_data_name = b"fs_info" # DB name where we store persistent data
     def __init__(self, path, reset=False, fsid=None):
         self._nextid = 0
         self.path = path
@@ -991,17 +988,17 @@ class StubFS_Disk(FileSystem):
         self.root = self.find(d["root"])
 
     def find_on_disk(self, id):
-        fd = open(os.path.join(self.path, "m_%i" % id), "r")
+        fd = open(os.path.join(self.path, b"m_%i" % id), "rb")
         # BUG - need to trap for file not found error
         meta = pickle.load(fd)
         fd.close()
         obj = self.objclass(self, id, meta)
         if obj.type == NF4REG:
-            fd = open(os.path.join(self.path, "d_%i" % id), "r")
-            obj.file = StringIO(fd.read())
+            fd = open(os.path.join(self.path, b"d_%i" % id), "rb")
+            obj.file = BytesIO(fd.read())
             fd.close()
         elif obj.type == NF4DIR:
-            fd = open(os.path.join(self.path, "d_%i" % id), "r")
+            fd = open(os.path.join(self.path, b"d_%i" % id), "rb")
             obj.entries = pickle.load(fd)
             fd.close()
         return obj
@@ -1018,10 +1015,10 @@ class StubFS_Disk(FileSystem):
             self._fs_data["_nextid"] = id
             self._fs_data.sync()
             # Create meta-data file
-            fd = open(os.path.join(self.path, "m_%i" % id), "w")
+            fd = open(os.path.join(self.path, b"m_%i" % id), "wb")
             fd.close()
             # Create data file
-            # fd = open(os.path.join(self.path, "d_%i" % id), "w")
+            # fd = open(os.path.join(self.path, b"d_%i" % id), "wb")
             # fd.close()
         finally:
             self._disk_lock.release()
@@ -1032,11 +1029,11 @@ class StubFS_Disk(FileSystem):
         self._disk_lock.acquire()
         try:
             # Remove meta-data file
-            meta = os.path.join(self.path, "m_%i" % id)
+            meta = os.path.join(self.path, b"m_%i" % id)
             if os.path.isfile(meta):
                 os.remove(meta)
             # Remove data file
-            data = os.path.join(self.path, "d_%i" % id)
+            data = os.path.join(self.path, b"d_%i" % id)
             if os.path.isfile(data):
                 os.remove(data)
         finally:
@@ -1049,20 +1046,20 @@ class StubFS_Disk(FileSystem):
         try:
             # Create meta-data file
             log_fs.debug("writing metadata for id=%i" % id)
-            fd = open(os.path.join(self.path, "m_%i" % id), "w")
+            fd = open(os.path.join(self.path, b"m_%i" % id), "wb")
             log_fs.debug("%r" % obj.meta.__dict__)
             pickle.dump(obj.meta, fd)
             fd.close()
             if obj.type == NF4REG:
                 # Create data file
-                fd = open(os.path.join(self.path, "d_%i" % id), "w")
+                fd = open(os.path.join(self.path, b"d_%i" % id), "wb")
                 obj.file.seek(0)
                 fd.write(obj.file.read())
                 fd.close()
             elif obj.type == NF4DIR:
                 # Create dir entries
                 log_fs.debug("writing dir %r" % obj.entries.keys())
-                fd = open(os.path.join(self.path, "d_%i" % id), "w")
+                fd = open(os.path.join(self.path, b"d_%i" % id), "wb")
                 pickle.dump(obj.entries, fd)
                 fd.close()
         finally:
@@ -1408,7 +1405,7 @@ class FSLayoutFSObj(FSObject):
     def init_file(self):
         self.stripe_size = NFL4_UFLG_STRIPE_UNIT_SIZE_MASK & 0x4000
         if self.fs.dsdevice.mdsds:
-            return StringIO()
+            return BytesIO()
         else:
             return FileLayoutFile(self)
 
diff --git a/nfs4.1/nfs4client.py b/nfs4.1/nfs4client.py
index f4fabcc..073ea8b 100644
--- a/nfs4.1/nfs4client.py
+++ b/nfs4.1/nfs4client.py
@@ -183,7 +183,7 @@ class NFS4Client(rpc.Client, rpc.Server):
                 return env
         try:
             self.check_utf8str_cs(args.tag)
-        except NFS4Errror as e:
+        except NFS4Error as e:
             env.results.set_empty_return(e.status, "Invalid utf8 tag")
             return env
         # Handle the individual operations
diff --git a/nfs4.1/nfs4server.py b/nfs4.1/nfs4server.py
index f56806e..47d6cba 100755
--- a/nfs4.1/nfs4server.py
+++ b/nfs4.1/nfs4server.py
@@ -21,7 +21,7 @@ from nfs4commoncode import CompoundState, encode_status, encode_status_by_name
 from fs import RootFS, ConfigFS
 from config import ServerConfig, ServerPerClientConfig, OpsConfigServer, Actions
 
-logging.basicConfig(level=logging.WARN,
+logging.basicConfig(level=logging.DEBUG,
                     format="%(levelname)-7s:%(name)s:%(message)s")
 log_41 = logging.getLogger("nfs.server")
 
@@ -350,7 +350,7 @@ class ClientRecord(object):
                         state.delete()
                     # STUB - what about LAYOUT?
                     # STUB - config whether DELEG OK or not
-            except StandardError as e:
+            except Exception as e:
                 log_41.exception("Ignoring problem during state removal")
         self.state = {}
         self.lastused = time.time()
@@ -365,7 +365,7 @@ class SessionRecord(object):
     """The server's representation of a session and its state"""
     def __init__(self, client, csa):
         self.client = client # reference back to client which created this session
-        self.sessionid = "%08x%08x" % (client.clientid,
+        self.sessionid = b"%08x%08x" % (client.clientid,
                                     client.session_replay.seqid) # XXX does this work?
         self.channel_fore = Channel(csa.csa_fore_chan_attrs, client.config) # Normal communication
         self.channel_back = Channel(csa.csa_back_chan_attrs, client.config) # Callback communication
@@ -570,18 +570,18 @@ class NFS4Server(rpc.Server):
         self._fsids = {self.root.fs.fsid: self.root.fs} # {fsid: fs}
         self.clients = ClientList() # List of attached clients
         self.sessions = {} # List of attached sessions
-        self.minor_versions = [1]
+        self.minor_versions = [1, 2]
         self.config = ServerConfig()
         self.opsconfig = OpsConfigServer()
         self.actions = Actions()
-        self.mount(ConfigFS(self), path="/config")
+        self.mount(ConfigFS(self), path=b"/config")
         self.verifier = struct.pack('>d', time.time())
         self.recording = Recording()
         self.devid_counter = Counter(name="devid_counter")
         self.devids = {} # {devid: device}
         # default cred for the backchannel -- currently supports only AUTH_SYS
         rpcsec = rpc.security.instance(rpc.AUTH_SYS)
-        self.default_cred = rpcsec.init_cred(uid=4321,gid=42,name="mystery")
+        self.default_cred = rpcsec.init_cred(uid=4321,gid=42,name=b"mystery")
         self.err_inc_dict = self.init_err_inc_dict()
 
     def start(self):
@@ -796,7 +796,7 @@ class NFS4Server(rpc.Server):
         self.check_utf8str_cs(str)
         if not str:
             raise NFS4Error(NFS4ERR_INVAL, tag="Empty component")
-        if '/' in str:
+        if b'/' in str:
             raise NFS4Error(NFS4ERR_BADCHAR)
 
     def op_compound(self, args, cred):
@@ -808,7 +808,7 @@ class NFS4Server(rpc.Server):
             return env
         try:
             self.check_utf8str_cs(args.tag)
-        except NFS4Errror as e:
+        except NFS4Error as e:
             env.results.set_empty_return(e.status, "Invalid utf8 tag")
             return env
         # Handle the individual operations
@@ -834,10 +834,10 @@ class NFS4Server(rpc.Server):
                     # catch error themselves to encode properly.
                     result = encode_status_by_name(opname.lower()[3:],
                                                    e.status, msg=e.tag)
-                except NFS4Replay:
+                except NFS4Replay as e:
                     # Just pass this on up
                     raise
-                except StandardError:
+                except Exception as e:
                     # Uh-oh.  This is a server bug
                     traceback.print_exc()
                     result = encode_status_by_name(opname.lower()[3:],
@@ -919,7 +919,7 @@ class NFS4Server(rpc.Server):
         check_session(env, unique=True)
         if arg.csa_flags & ~nfs4lib.create_session_mask:
             return encode_status(NFS4ERR_INVAL,
-                                 msg="Unknown bits set in flag")
+                                 msg=b"Unknown bits set in flag")
         # Step 1: Client record lookup
         c = self.clients[arg.csa_clientid]
         if c is None: # STUB - or if c.frozen ???
@@ -982,13 +982,13 @@ class NFS4Server(rpc.Server):
         if protect.type != SP4_SSV:
             # Per draft26 18.47.3
             return encode_status(NFS4ERR_INVAL,
-                                 msg="Did not request SP4_SSV protection")
+                                 msg=b"Did not request SP4_SSV protection")
         # Do some argument checking
         size = protect.context.ssv_len
         if len(arg.ssa_ssv) != size:
-            return encode_status(NFS4ERR_INVAL, msg="SSV size != %i" % size)
+            return encode_status(NFS4ERR_INVAL, msg=b"SSV size != %i" % size)
         if arg.ssa_ssv == "\0" * size:
-            return encode_status(NFS4ERR_INVAL, msg="SSV==0 not allowed")
+            return encode_status(NFS4ERR_INVAL, msg=b"SSV==0 not allowed")
         # Now we need to compute and check digest, using SEQUENCE args
         p = nfs4lib.FancyNFS4Packer()
         p.pack_SEQUENCE4args(env.argarray[0].opsequence)
@@ -1009,10 +1009,10 @@ class NFS4Server(rpc.Server):
         check_session(env, unique=True)
         # Check arguments for blatent errors
         if arg.eia_flags & ~nfs4lib.exchgid_mask:
-            return encode_status(NFS4ERR_INVAL, msg="Unknown flag")
+            return encode_status(NFS4ERR_INVAL, msg=b"Unknown flag")
         if arg.eia_flags & EXCHGID4_FLAG_CONFIRMED_R:
             return encode_status(NFS4ERR_INVAL,
-                                 msg="Client used server-only flag")
+                                 msg=b"Client used server-only flag")
         if arg.eia_client_impl_id:
             impl_id = arg.eia_client_impl_id[0]
             self.check_utf8str_cis(impl_id.nii_domain)
@@ -1034,7 +1034,7 @@ class NFS4Server(rpc.Server):
             if c is None:
                 if update:
                     # Case 7
-                    return encode_status(NFS4ERR_NOENT, msg="No such client")
+                    return encode_status(NFS4ERR_NOENT, msg=b"No such client")
                 else:
                     # The simple, common case 1: a new client
                     c = self.clients.add(arg, env.principal, self.sec_flavors)
@@ -1042,7 +1042,7 @@ class NFS4Server(rpc.Server):
                 if update:
                     # Case 7
                     return encode_status(NFS4ERR_NOENT,
-                                         msg="Client not confirmed")
+                                         msg=b"Client not confirmed")
                 else:
                     # Case 4
                     self.clients.remove(c.clientid)
@@ -1057,11 +1057,11 @@ class NFS4Server(rpc.Server):
                     if c.verifier != verf:
                         # Case 8
                         return encode_status(NFS4ERR_NOT_SAME,
-                                             msg="Verifier mismatch")
+                                             msg=b"Verifier mismatch")
                     elif c.principal != env.principal:
                         # Case 9
                         return encode_status(NFS4ERR_PERM,
-                                             msg="Principal mismatch")
+                                             msg=b"Principal mismatch")
                     else:
                         # Case 6 - update
                         c.update(arg, env.principal)
@@ -1069,7 +1069,7 @@ class NFS4Server(rpc.Server):
                     # Case 3
                     # STUB - need to check state
                     return encode_status(NFS4ERR_CLID_INUSE,
-                                         msg="Principal mismatch")
+                                         msg=b"Principal mismatch")
                 elif c.verifier != verf:
                     # Case 5
                     # Confirmed client reboot: this is the hard case
@@ -1103,7 +1103,7 @@ class NFS4Server(rpc.Server):
                                 c.protection.rv(arg.eia_state_protect),
                                 self.config._owner, self.config.scope,
                                 [self.config.impl_id])
-        return encode_status(NFS4_OK, res, msg="draft21")
+        return encode_status(NFS4_OK, res, msg=b"draft21")
 
     def client_reboot(self, c):
         # STUB - locking?
@@ -1143,9 +1143,9 @@ class NFS4Server(rpc.Server):
             if arg.bctsa_digest:
                 # QUESTION _INVAL or _BAD_SESSION_DIGEST also possible
                 return encode_status(NFS4ERR_CONN_BINDING_NOT_ENFORCED,
-                                     msg="Expected zero length digest")
+                                     msg=b"Expected zero length digest")
             if arg.bctsa_step1 is False:
-                return encode_status(NFS4ERR_INVAL, msg="Expected step1==True")
+                return encode_status(NFS4ERR_INVAL, msg=b"Expected step1==True")
             dir = bind_to_channels(arg.bctsa_dir)
             nonce = session.get_nonce(connection, [arg.bctsa_nonce])
             # STUB this should be a session method
@@ -1175,9 +1175,9 @@ class NFS4Server(rpc.Server):
                 old_s_nonce, old_c_nonce = session.nonce[connection]
             except KeyError:
                 return encode_status(NFS4ERR_INVAL,
-                                     msg="server has no record of step1")
+                                     msg=b"server has no record of step1")
             if old_c_nonce == arg.bctsa_nonce:
-                return encode_status(NFS4ERR_INVAL, msg="Client reused nonce")
+                return encode_status(NFS4ERR_INVAL, msg=b"Client reused nonce")
             p = nfs4lib.FancyNFS4Packer()
             p.pack_bctsr_digest_input4(bctsr_digest_input4(arg.bctsa_sessid,
                                                            arg.bctsa_nonce,
@@ -1208,8 +1208,7 @@ class NFS4Server(rpc.Server):
         check_session(env)
         # xxx add gss support
         secinfo4_list = [ secinfo4(rpc.AUTH_SYS) ]
-        res = SECINFO_NO_NAME4res(NFS4_OK, secinfo4_list)
-        return encode_status(NFS4_OK, res)
+        return encode_status(NFS4_OK, secinfo4_list)
 
     # op_putpubfh SHOULD be the same as op_putrootfh
     # See draft23, section 18.20.3, line 25005
@@ -1356,14 +1355,14 @@ class NFS4Server(rpc.Server):
         claim_type = arg.claim.claim
         if claim_type != CLAIM_NULL and arg.openhow.opentype == OPEN4_CREATE:
             return encode_status(NFS4ERR_INVAL,
-                                 msg="OPEN4_CREATE not compatible with %s" %
+                                 msg=b"OPEN4_CREATE not compatible with %s" %
                                  open_claim_type4[claim_type])
         # emulate switch(claim_type)
         try:
             func = getattr(self,
                            "open_%s" % open_claim_type4[claim_type].lower())
         except AttributeError:
-            return encode_status(NFS4ERR_NOTSUPP, msg="Unsupported claim type")
+            return encode_status(NFS4ERR_NOTSUPP, msg=b"Unsupported claim type")
         existing, cinfo, bitmask = func(arg, env)
         # existing now points to file we want to open
         if existing is None:
@@ -1462,7 +1461,7 @@ class NFS4Server(rpc.Server):
             ace = nfsace4(ACE4_ACCESS_DENIED_ACE_TYPE, 0,
                           ACE4_GENERIC_EXECUTE |
                           ACE4_GENERIC_WRITE | ACE4_GENERIC_READ,
-                          "EVERYONE@")
+                          b"EVERYONE@")
             deleg = open_read_delegation4(entry.get_id(), False, ace)
             return open_delegation4(entry.deleg_type, deleg)
 
@@ -1557,7 +1556,7 @@ class NFS4Server(rpc.Server):
         check_cfh(env)
         env.cfh.check_dir()
         if arg.cookie in (1, 2) or \
-               (arg.cookie==0 and arg.cookieverf != "\0" * 8):
+               (arg.cookie==0 and arg.cookieverf != b"\0" * 8):
             return encode_status(NFS4ERR_BAD_COOKIE)
         objlist, verifier = env.cfh.readdir(arg.cookieverf, env.session.client, env.principal) # (name, obj) pairs
         # STUB - think through rdattr_error handling
@@ -1690,7 +1689,7 @@ class NFS4Server(rpc.Server):
         check_session(env)
         check_cfh(env)
         if env.cfh.fattr4_type != NF4LNK:
-            return encode_status(NFS4_INVAL, msg="cfh type was %i" % i)
+            return encode_status(NFS4_INVAL, msg=b"cfh type was %i" % i)
         res = READLINK4resok(env.cfh.linkdata)
         return encode_status(NFS4_OK, res)
 
@@ -1734,7 +1733,7 @@ class NFS4Server(rpc.Server):
         self.check_component(arg.newname)
         if not nfs4lib.test_equal(env.sfh.fattr4_fsid, env.cfh.fattr4_fsid,
                                   kind="fsid4"):
-            return encode_status(NFS4ERR_XDEV, msg="%r != %r" % (env.sfh.fattr4_fsid, env.cfh.fattr4_fsid))
+            return encode_status(NFS4ERR_XDEV, msg=b"%r != %r" % (env.sfh.fattr4_fsid, env.cfh.fattr4_fsid))
         order = sorted(set([env.cfh, env.sfh])) # Used to prevent locking problems
         # BUG fs locking
         old_change_src = env.sfh.fattr4_change
@@ -1891,10 +1890,10 @@ class NFS4Server(rpc.Server):
             check_session(env)
             check_cfh(env)
             if arg.loga_length == 0:
-                return encode_status(NFS4_INVAL, msg="length == 0")
+                return encode_status(NFS4_INVAL, msg=b"length == 0")
             if arg.loga_length != 0xffffffffffffffff:
                 if arg.loga_length + arg.loga_offset > 0xffffffffffffffff:
-                     return encode_status(NFS4_INVAL, msg="offset+length too big")
+                     return encode_status(NFS4_INVAL, msg=b"offset+length too big")
             if not env.session.has_backchannel:
                 raise NFS4Error(NFS4ERR_LAYOUTTRYLATER)
             # STUB do state locking and check on iomode,offset,length triple
@@ -2047,7 +2046,7 @@ class NFS4Server(rpc.Server):
         # "The server MUST specify...an ONC RPC version number equal to 4",
         # Per the May 17, 2010 discussion on the ietf list, errataID 2291
         # indicates it should in fact be 1
-        return pipe.send_call(prog, 1, 0, "", credinfo)
+        return pipe.send_call(prog, 1, 0, b"", credinfo)
 
     def cb_null(self, prog, pipe, credinfo=None):
         """ Sends bc_null."""
diff --git a/nfs4.1/nfs4state.py b/nfs4.1/nfs4state.py
index e57b90a..d675a6b 100644
--- a/nfs4.1/nfs4state.py
+++ b/nfs4.1/nfs4state.py
@@ -215,10 +215,10 @@ class DictTree(object):
     def itervalues(self):
         def myiter(d, depth):
             if depth == 1:
-                for value in d.itervalues():
+                for value in d.values():
                     yield value
             else:
-                for sub_d in d.itervalues():
+                for sub_d in d.values():
                     for i in myiter(sub_d, depth - 1):
                         yield i
         for i in myiter(self._data, self._depth):
@@ -250,7 +250,7 @@ class FileStateTyped(object):
         # NOTE we are only using 9 bytes of 12
         # NOTE this needs to be client-wide, since keys of client.state[]
         # must be unique
-        return "%s%s" % (struct.pack("!xxxB", self.type),
+        return b"%s%s" % (struct.pack("!xxxB", self.type),
                          client.get_new_other())
 
     def grab_entry(self, key, klass):
@@ -290,13 +290,13 @@ class DelegState(FileStateTyped):
             return True
         # Find any delegation - use fact that all are of same type
         for e in self._tree.itervalues():
+            # The only thing that doesn't conflict is access==READ with READ deleg
+            if e.deleg_type == OPEN_DELEGATE_READ and \
+                    not (access & OPEN4_SHARE_ACCESS_WRITE):
+                return False
+            else:
+                return True
             break
-        # The only thing that doesn't conflict is access==READ with READ deleg
-        if e.deleg_type == OPEN_DELEGATE_READ and \
-                not (access & OPEN4_SHARE_ACCESS_WRITE):
-            return False
-        else:
-            return True
 
     def recall_conflicting_delegations(self, dispatcher, client, access, deny):
         # NOTE OK to have extra access/deny flags
diff --git a/nfs4.1/sample_code/ds_exports.py b/nfs4.1/sample_code/ds_exports.py
index 5d31148..1975e16 100644
--- a/nfs4.1/sample_code/ds_exports.py
+++ b/nfs4.1/sample_code/ds_exports.py
@@ -6,4 +6,4 @@ from fs import StubFS_Mem
 
 def mount_stuff(server, opts):
     B = StubFS_Mem(2)
-    server.mount(B, path="/pynfs_mds")
+    server.mount(B, path=b"/pynfs_mds")
diff --git a/nfs4.1/server_exports.py b/nfs4.1/server_exports.py
index ef857ee..1271c4a 100644
--- a/nfs4.1/server_exports.py
+++ b/nfs4.1/server_exports.py
@@ -4,22 +4,22 @@ from dataserver import DSDevice
 def mount_stuff(server, opts):
     """Mount some filesystems to the server"""
     # STUB - just testing stuff out
-    A = StubFS_Disk("/tmp/py41/fs1", opts.reset, 1)
+    A = StubFS_Disk(b"/tmp/py41/fs1", opts.reset, 1)
     B = StubFS_Mem(2)
     C = StubFS_Mem(3)
-    server.mount(A, path="/a")
-    server.mount(B, path="/b")
-    server.mount(C, path="/foo/bar/c")
+    server.mount(A, path=b"/a")
+    server.mount(B, path=b"/b")
+    server.mount(C, path=b"/foo/bar/c")
     if opts.use_block:
         dev = _create_simple_block_dev()
         E = BlockLayoutFS(5, backing_device=dev)
-        server.mount(E, path="/block")
+        server.mount(E, path=b"/block")
     if opts.use_files:
         dservers = _load_dataservers(opts.dataservers, server)
         if dservers is None:
             return
         F = FileLayoutFS(6, dservers)
-        server.mount(F, path="/files")
+        server.mount(F, path=b"/files")
 
 def _create_simple_block_dev():
     from block import Simple, Slice, Concat, Stripe, BlockVolume
-- 
2.53.0


