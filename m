Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFB5A38E8E5
	for <lists+linux-nfs@lfdr.de>; Mon, 24 May 2021 16:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233022AbhEXOo1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 24 May 2021 10:44:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:40612 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232987AbhEXOo1 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 24 May 2021 10:44:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1621867377; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=r6uLFHCZyO1l7dTpX6d9koL4QpVtDk3LEaC3Zmx1vls=;
        b=BivY2CR7O2DBDjAlFEpQAmb49ayzHUW9+nd7QV5B4C8CO8NALEPpqO+OwWV66KauVFoG+s
        hPUuM2M8TW904KIKjyfYRt0jBiNei7aQ5hVddNaVDQRo65vq3q/fyKr8MHEpgdrknx1aHk
        XyG1FUOFmAO2zVzffm0fghYCF1K1vLE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1621867377;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=r6uLFHCZyO1l7dTpX6d9koL4QpVtDk3LEaC3Zmx1vls=;
        b=h+2AYF5GjbywM8l9REi4cwny+GyAhBxu0PWMiT84gwwJBFRHXDbJhaeV9kpHvPKOkC06gG
        IQdn2hGYVMaqRrCg==
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 95653ADE5;
        Mon, 24 May 2021 14:42:57 +0000 (UTC)
From:   Petr Vorel <pvorel@suse.cz>
To:     linux-nfs@vger.kernel.org
Cc:     Petr Vorel <pvorel@suse.cz>,
        "J . Bruce Fields" <bfields@redhat.com>,
        "Yong Sun (Sero)" <yosun@suse.com>
Subject: [PATCH pynfs 1/3] remove trailing whitespace
Date:   Mon, 24 May 2021 16:42:49 +0200
Message-Id: <20210524144251.30196-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 nfs4.0/nfs4acl.py        |  9 +++--
 nfs4.0/nfs4client.py     |  4 +--
 nfs4.0/nfs4lib.py        | 78 ++++++++++++++++++++--------------------
 nfs4.0/nfs4server.py     | 18 +++++-----
 nfs4.0/nfs4state.py      | 54 ++++++++++++++--------------
 nfs4.0/testserver.py     | 18 +++++-----
 nfs4.1/config.py         |  2 +-
 nfs4.1/fs.py             |  8 ++---
 nfs4.1/locking.py        |  8 ++---
 nfs4.1/nfs4client.py     | 22 ++++++------
 nfs4.1/nfs4commoncode.py | 12 +++----
 nfs4.1/nfs4lib.py        | 16 ++++-----
 nfs4.1/nfs4proxy.py      |  2 +-
 nfs4.1/nfs4server.py     | 56 ++++++++++++++---------------
 nfs4.1/nfs4state.py      | 12 +++----
 nfs4.1/setup.py          |  5 ++-
 nfs4.1/testclient.py     | 24 ++++++-------
 nfs4.1/testmod.py        | 15 ++++----
 nfs4.1/testserver.py     | 16 ++++-----
 rpc/rpc.py               | 14 ++++----
 rpc/setup.py             |  5 ++-
 showresults.py           |  4 +--
 xdr/setup.py             |  3 +-
 xdr/xdrgen.py            | 36 +++++++++----------
 24 files changed, 218 insertions(+), 223 deletions(-)

diff --git a/nfs4.0/nfs4acl.py b/nfs4.0/nfs4acl.py
index b7f033e..69e0d0b 100644
--- a/nfs4.0/nfs4acl.py
+++ b/nfs4.0/nfs4acl.py
@@ -2,7 +2,7 @@
 # nfs4acl.py - some useful acl code
 #
 # Written by Fred Isaman <iisaman@citi.umich.edu>
-# Copyright (C) 2004 University of Michigan, Center for 
+# Copyright (C) 2004 University of Michigan, Center for
 #                    Information Technology Integration
 #
 
@@ -87,7 +87,7 @@ def acl2mode(acl):
     for ace in short:
         if perms[ace.who] is not None: continue
         if ace.type == ALLOWED:
-            bits = 0 
+            bits = 0
             for mode, bit in modes:
                 if mode & ace.access_mask == mode:
                     bits |= bit
@@ -103,7 +103,7 @@ def acl2mode(acl):
         if perms[key] is None:
             perm[keys] = 0
     return perms["OWNER@"]*0o100 + perms["GROUP@"]*0o10 + perms["EVERYONE@"]
-        
+
 def maps_to_posix(acl):
     """Raises ACLError if acl does not map to posix """
 
@@ -147,7 +147,7 @@ def chk_triple(mask, allow, deny, flags, not_mask):
         raise ACLError("Triple mask does not have required flags  %x" % flags)
     if not_mask != mask.access_mask:
         raise ACLError("Triple mask is not same as a previous mask")
-    
+
 def chk_everyone(acl, flags):
     if len(acl) != 2:
         raise ACLError("Had %i ACEs left when called chk_everyone" % len(acl))
@@ -216,4 +216,3 @@ def printableacl(acl):
                (type_str[ace.type], ace.flag, ace.access_mask, ace.who)
     #print("leaving printableacl with out = %s" % out)
     return out
-    
diff --git a/nfs4.0/nfs4client.py b/nfs4.0/nfs4client.py
index d3d6e88..bc714d3 100755
--- a/nfs4.0/nfs4client.py
+++ b/nfs4.0/nfs4client.py
@@ -4,7 +4,7 @@
 # nfs4client.py - NFS4 interactive client in python
 #
 # Written by Fred Isaman   <iisaman@citi.umich.edu>
-# Copyright (C) 2006 University of Michigan, Center for 
+# Copyright (C) 2006 University of Michigan, Center for
 #                    Information Technology Integration
 #
 
@@ -126,6 +126,6 @@ def main(server):
     c = PyShell(server)
     c.interact("Try COMPOUND([PUTROOTFH()])")
     print("Goodbye!")
-        
+
 if __name__ == "__main__":
     main(sys.argv[1])
diff --git a/nfs4.0/nfs4lib.py b/nfs4.0/nfs4lib.py
index 905f8f4..934def3 100644
--- a/nfs4.0/nfs4lib.py
+++ b/nfs4.0/nfs4lib.py
@@ -2,24 +2,24 @@
 # nfs4lib.py - NFS4 library for Python
 #
 # Requires python 3.2
-# 
+#
 # Written by Fred Isaman <iisaman@citi.umich.edu>
-# Copyright (C) 2004 University of Michigan, Center for 
+# Copyright (C) 2004 University of Michigan, Center for
 #                    Information Technology Integration
 #
 # Based on version
 # Written by Peter Astrand <peter@cendio.se>
 # Copyright (C) 2001 Cendio Systems AB (http://www.cendio.se)
-# 
+#
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License as published by
-# the Free Software Foundation; version 2 of the License. 
-# 
+# the Free Software Foundation; version 2 of the License.
+#
 # This program is distributed in the hope that it will be useful,
 # but WITHOUT ANY WARRANTY; without even the implied warranty of
 # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 # GNU General Public License for more details.
-# 
+#
 # You should have received a copy of the GNU General Public License
 # along with this program; if not, write to the Free Software
 # Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
@@ -72,7 +72,7 @@ class UnexpectedCompoundRes(NFSException):
     """The COMPOUND procedure returned OK, but had unexpected data"""
     def __init__(self, msg=""):
         self.msg = msg
-    
+
     def __str__(self):
         if self.msg:
             return "Unexpected COMPOUND result: %s" % self.msg
@@ -83,7 +83,7 @@ class InvalidCompoundRes(NFSException):
     """The COMPOUND return is invalid, ie response is not to spec"""
     def __init__(self, msg=""):
         self.msg = msg
-    
+
     def __str__(self):
         if self.msg:
             return "Invalid COMPOUND result: %s" % self.msg
@@ -105,8 +105,8 @@ class FancyNFS4Packer(nfs4_pack.NFS4Packer):
             data = dict2fattr(data)
         return data
 
-    # def pack_dirlist4(self): 
-        
+    # def pack_dirlist4(self):
+
 class FancyNFS4Unpacker(nfs4_pack.NFS4Unpacker):
     def filter_bitmap4(self, data):
         """Put bitmap into single long, instead of array of 32bit chunks"""
@@ -121,7 +121,7 @@ class FancyNFS4Unpacker(nfs4_pack.NFS4Unpacker):
         """Return as dict, instead of opaque attrlist"""
         return fattr2dict(data)
 
-    
+
     def filter_dirlist4(self, data):
         """Return as simple list, instead of strange chain structure"""
         e = data.entries
@@ -133,8 +133,8 @@ class FancyNFS4Unpacker(nfs4_pack.NFS4Unpacker):
             array.append(e[0])
         data.entries = array
         return data
-        
-        
+
+
 # STUB
 class CBServer(rpc.RPCServer):
     def __init__(self, client):
@@ -165,8 +165,8 @@ class CBServer(rpc.RPCServer):
             OP_CB_GETATTR: 0,
             OP_CB_RECALL: 0,
             #OP_CB_ILLEGAL: 0,
-            }            
-        
+            }
+
     def set_cb_recall(self, cbid, funct, ret):
         self.recall_lock.acquire()
         self.recall_funct[cbid] = funct
@@ -209,7 +209,7 @@ class CBServer(rpc.RPCServer):
             return rpc.GARBAGE_ARGS, b''
         else:
             return rpc.SUCCESS, b''
-    
+
     def handle_1(self, data, cred):
         """Deal with CB_COMPOUND"""
         print("*****CB received COMPOUND******")
@@ -223,7 +223,7 @@ class CBServer(rpc.RPCServer):
         self.nfs4packer.reset()
         self.nfs4packer.pack_CB_COMPOUND4res(cmp4res)
         return rpc.SUCCESS, self.nfs4packer.get_buffer()
-            
+
     def O_CB_Compound(self):
         tag = b''
         try:
@@ -247,7 +247,7 @@ class CBServer(rpc.RPCServer):
             if ok != NFS4_OK:
                 break
         return ok, results, tag
-        
+
     # FIXME
     def O_CB_GetAttr(self, op, cbid):
         print("******* CB_Getattr *******")
@@ -272,7 +272,7 @@ class CBServer(rpc.RPCServer):
         self.recall_return[cbid] = NFS4_OK
         self.recall_lock.release()
         return res
-            
+
 # STUB
 AuthSys = rpc.SecAuthSys(0,b'jupiter',103558,100,[])
 
@@ -527,12 +527,12 @@ class NFS4Client(rpc.RPCClient):
         res = self.compound(ops)
         check_result(res)
         return res.resarray[-1].switch.switch.object
-    
+
     def do_readdir(self, file, cookie=0, cookieverf = b'', attr_request=[],
                    dircount=4096, maxcount=4096):
         # Since we may not get whole directory listing in one readdir request,
         # loop until we do. For each request result, create a flat list
-        # with <entry4> objects. 
+        # with <entry4> objects.
         attrs = list2bitmap(attr_request)
         cookie = 0
         cookieverf = b''
@@ -553,7 +553,7 @@ class NFS4Client(rpc.RPCClient):
                 else:
                     break
             entry = reply.entries[0]
-            # Loop over all entries in result. 
+            # Loop over all entries in result.
             while 1:
                 entry.attrdict = entry.attrs
                 entry.count = count
@@ -648,7 +648,7 @@ class NFS4Client(rpc.RPCClient):
             # There was no delegation granted, so clean up recall info
             self.cb_server.clear_cb_recall(self.cbid)
         return res
-        
+
     def open_file(self, owner, path=None,
                   access=OPEN4_SHARE_ACCESS_READ,
                   deny=OPEN4_SHARE_DENY_WRITE,
@@ -706,7 +706,7 @@ class NFS4Client(rpc.RPCClient):
             check_result(res)
             stateid = res.resarray[-1].switch.switch.open_stateid
         return (fhandle, stateid)
-        
+
 
     def create_confirm(self, owner, path=None, attrs={FATTR4_MODE: 0o644},
                        access=OPEN4_SHARE_ACCESS_BOTH,
@@ -726,7 +726,7 @@ class NFS4Client(rpc.RPCClient):
         res = self.open_file(owner, path, access, deny)
         check_result(res, "Opening file %s" % _getname(owner, path))
         return self.confirm(owner, res)
-        
+
 ##     def xxxopen_claim_prev(self, owner, fh, seqid=None,
 ##                        check=None, error=NFS4_OK, msg=''):
 ##         # Set defaults
@@ -778,7 +778,7 @@ class NFS4Client(rpc.RPCClient):
             res.count = res.resarray[-1].switch.switch.count
             res.committed = res.resarray[-1].switch.switch.committed
         return res
-    
+
     def read_file(self, file, offset=0, count=2048, stateid=stateid4(0, b'')):
         ops =  self.use_obj(file)
         ops += [op4.read(stateid, offset, count)]
@@ -794,7 +794,7 @@ class NFS4Client(rpc.RPCClient):
         """Lock the file in fh using owner for the first time
 
         file can be either a fh or a path"""
-        
+
         if lockowner is None:
             lockowner = b"lockowner_%f" % time.time()
         if openseqid is None: openseqid = self.get_seqid(openowner)
@@ -838,7 +838,7 @@ class NFS4Client(rpc.RPCClient):
         test_owner = lock_owner4(self.clientid, tester)
         ops += [op4.lockt(type, offset, len, test_owner)]
         return self.compound(ops)
-                  
+
     def close_file(self, owner, fh, stateid, seqid=None):
         """close the given file"""
         if seqid is None: seqid = self.get_seqid(owner)
@@ -898,22 +898,22 @@ def get_attr_name(bitnum):
     """Return string corresponding to attribute bitnum"""
     return get_bitnumattr_dict().get(bitnum, "Unknown_%r" % bitnum)
 
-_cache_attrbitnum = {} 
+_cache_attrbitnum = {}
 def get_attrbitnum_dict():
     """Get dictionary with attribute bit positions.
 
     Note: This function uses introspection. It assumes an entry
-    in nfs4_const.py is an attribute iff it is named FATTR4_<something>. 
+    in nfs4_const.py is an attribute iff it is named FATTR4_<something>.
 
     Returns {"type": 1, "fh_expire_type": 2,  "change": 3 ...}
     """
-    
+
     if _cache_attrbitnum:
         return _cache_attrbitnum
     for name in dir(nfs4_const):
         if name.startswith("FATTR4_"):
             value = getattr(nfs4_const, name)
-            # Sanity checking. Must be integer. 
+            # Sanity checking. Must be integer.
             assert(type(value) is int)
             attrname = name[7:].lower()
             _cache_attrbitnum[attrname] = value
@@ -922,9 +922,9 @@ def get_attrbitnum_dict():
 _cache_bitnumattr = {}
 def get_bitnumattr_dict():
     """Get dictionary with attribute bit positions.
-    
+
     Note: This function uses introspection. It assumes an entry
-    in nfs4_const.py is an attribute iff it is named FATTR4_<something>. 
+    in nfs4_const.py is an attribute iff it is named FATTR4_<something>.
     Returns { 1: "type", 2: "fh_expire_type", 3: "change", ...}
     """
 
@@ -933,7 +933,7 @@ def get_bitnumattr_dict():
     for name in dir(nfs4_const):
         if name.startswith("FATTR4_"):
             value = getattr(nfs4_const, name)
-            # Sanity checking. Must be integer. 
+            # Sanity checking. Must be integer.
             assert(type(value) is int)
             attrname = name[7:].lower()
             _cache_bitnumattr[value] = attrname
@@ -949,7 +949,7 @@ def get_attrpackers(packer):
     dict = get_attrbitnum_dict()
     for name in dir(nfs4_pack.NFS4Packer):
         if name.startswith("pack_fattr4_"):
-            # pack_fattr4 is 12 chars. 
+            # pack_fattr4 is 12 chars.
             attrname = name[12:]
             out[dict[attrname]] = getattr(packer, name)
     return out
@@ -964,7 +964,7 @@ def get_attrunpacker(unpacker):
     attrunpackers = {}
     for name in dir(FancyNFS4Unpacker):
         if name.startswith("unpack_fattr4_"):
-            # unpack_fattr4_ is 14 chars. 
+            # unpack_fattr4_ is 14 chars.
             attrname = name[14:]
             bitnum = get_attrbitnum_dict()[attrname]
             attrunpackers[bitnum] = getattr(unpacker, name)
@@ -977,7 +977,7 @@ _cache_attrpackers = get_attrpackers(_cache_packer)
 def dict2fattr(dict):
     """Convert a dictionary of form {numb:value} to a fattr4 object.
 
-    Returns a fattr4 object.  
+    Returns a fattr4 object.
     """
 
     attrs = sorted(dict.keys())
@@ -993,7 +993,7 @@ def dict2fattr(dict):
         packerfun(value)
         attr_vals += packer.get_buffer()
     attrmask = list2bitmap(attrs)
-    return fattr4(attrmask, attr_vals); 
+    return fattr4(attrmask, attr_vals);
 
 def fattr2dict(obj):
     """Convert a fattr4 object to a dictionary with attribute name and values.
diff --git a/nfs4.0/nfs4server.py b/nfs4.0/nfs4server.py
index 3cf6ec2..2dbad30 100755
--- a/nfs4.0/nfs4server.py
+++ b/nfs4.0/nfs4server.py
@@ -4,7 +4,7 @@
 #
 # Written by Martin Murray <mmurray@deepthought.org>
 # and        Fred Isaman   <iisaman@citi.umich.edu>
-# Copyright (C) 2001 University of Michigan, Center for 
+# Copyright (C) 2001 University of Michigan, Center for
 #                    Information Technology Integration
 #
 
@@ -62,7 +62,7 @@ def verify_utf8(str):
         return True
     except UnicodeError:
         return False
-            
+
 def access2string(access):
     ret = []
     if access & ACCESS4_READ:
@@ -119,7 +119,7 @@ class NFS4Server(rpc.RPCServer):
             return rpc.GARBAGE_ARGS, ''
         else:
             return rpc.SUCCESS, ''
-    
+
     def handle_1(self, data, cred):
         self.nfs4unpacker.reset(data)
         print
@@ -129,7 +129,7 @@ class NFS4Server(rpc.RPCServer):
             self.nfs4unpacker.done()
         except XDRError:
             print(repr(self.nfs4unpacker.get_buffer()))
-            
+
             raise
             return rpc.GARBAGE_ARGS, ''
         cmp4res = COMPOUND4res(ok, tag, results)
@@ -175,7 +175,7 @@ class NFS4Server(rpc.RPCServer):
             return NFS4ERR_MINOR_VERS_MISMATCH, [], tag
         if not verify_utf8(tag):
             return NFS4ERR_INVAL, [], tag
-        self.prep_client()            
+        self.prep_client()
         results = []
         ok = NFS4_OK
         for op in cmp4args.argarray:
@@ -278,7 +278,7 @@ class NFS4Server(rpc.RPCServer):
     # FIXME: have it actually do something
     def op_delegpurge(self, op):
         return simple_error(NFS4ERR_NOTSUPP)
-    
+
     # FIXME: have it actually do something
     def op_delegreturn(self, op):
         return simple_error(NFS4ERR_NOTSUPP)
@@ -402,7 +402,7 @@ class NFS4Server(rpc.RPCServer):
     def op_lookup(self, op):
         print("  CURRENT FILEHANDLE %s" % repr(self.curr_fh))
         print("  REQUESTED OBJECT %s" % op.oplookup.objname)
-        
+
         if not self.curr_fh:
             return simple_error(NFS4ERR_NOFILEHANDLE)
         if self.curr_fh.get_type() == NF4LNK:
@@ -595,7 +595,7 @@ class NFS4Server(rpc.RPCServer):
         # check access!
         if not op.opputfh.object in self.fhcache:
             return simple_error(NFS4ERR_BADHANDLE)
-        self.curr_fh = self.fhcache[op.opputfh.object] 
+        self.curr_fh = self.fhcache[op.opputfh.object]
         return simple_error(NFS4_OK)
 
     def op_putpubfh(self, op):
@@ -898,7 +898,7 @@ class NFS4Server(rpc.RPCServer):
         self.state.unconfirmed.remove(x=entry2.x)
         self.state.reset_seqid(c)
         return simple_error(NFS4_OK)
-            
+
     def op_verify(self, op):
         print("  CURRENT FILEHANDLE %s" % repr(self.curr_fh))
         if not self.curr_fh:
diff --git a/nfs4.0/nfs4state.py b/nfs4.0/nfs4state.py
index 8aca178..ca40172 100755
--- a/nfs4.0/nfs4state.py
+++ b/nfs4.0/nfs4state.py
@@ -233,7 +233,7 @@ class NFSServerState:
                 owner.lastseqid = None
         except KeyError:
             pass
-        
+
     def check_seqid(self, obj, seqid, mustexist=True, open_confirm=False):
         """Check that seqid against stored one for obj.
 
@@ -276,7 +276,7 @@ class NFSServerState:
         if mod32(lastseq + 1) == seqid:
             return
         raise NFS4Error(NFS4ERR_BAD_SEQID)
-    
+
     def advance_seqid(self, owner, op, args, cfh=None):
         """Advance stored seqid for owner, if appropriate. Cache the rest.
 
@@ -416,7 +416,7 @@ class NFSServerState:
             self.next_id += 1
             self.state[id] = self.StateIDInfo(fh, info)
             return id
-            
+
     def __owner2info(self, owner, allownew=False):
         """Returns info for given owner.
 
@@ -476,7 +476,7 @@ class NFSServerState:
     def __getowner(self, id):
         """Returns owner associated with given id"""
         return self.state[id].owner.owner
-        
+
     def __check_clientid(self, clientid):
         """Checks that clientid is not stale"""
         if clientid / 0x100000000 != unpacknumber(self.instance):
@@ -497,7 +497,7 @@ class NFSServerState:
             self.confirmed.renew(clientid)
         except KeyError:
             raise NFS4Error(NFS4ERR_EXPIRED)
-        
+
     def new_lockowner(self, openowner):
         """Use openowner data to create a new lock owner"""
         if openowner.lock_seqid != 0:
@@ -547,8 +547,8 @@ class NFSServerState:
             return True
         else:
             return False
-                
-        
+
+
     def __testlock(self, fh, ids, type, offset, end):
         """Raise NFS4ERR_DENIED if conflicting lock exists"""
         deny = fh.state.testlock(ids, type, offset, end)
@@ -675,7 +675,7 @@ class NFSServerState:
                     del self.state[id]
             del self.openowners[clientid]
 
-        
+
 #########################################################################
 
 
@@ -727,7 +727,7 @@ class NFSFileState:
         """Change 3 bit internal value to 2 bit external"""
         if value & 4: return 3
         else: return value & 3
-        
+
     def downshares(self, id, access, deny):
         """Downgrade shares.  access == deny == 0 removes shares completely"""
         if id not in self.shares:
@@ -879,7 +879,7 @@ class NFSFileState:
         for lock in list[:]:
             if lock.overlaps(start, end):
                 list.remove(lock)
-        
+
 #########################################################################
 
 class NFSFileHandle:
@@ -901,31 +901,31 @@ class NFSFileHandle:
 
     def __repr__(self):
         return "<NFSFileHandle(%s): %s>" % (self.get_fhclass(), str(self))
-    
+
     def __str__(self):
         return self.name
-            
+
     def supported_access(self, client):
         raise "Implement supported_access()"
-        
+
     def evaluate_access(self, client):
         raise "Implement evaluate_access()"
 
     def get_attributes(self, attrlist=None):
         raise "Implement get_attributes"
-                
+
     def get_directory(self):
-        raise "Implement get_directory"                
+        raise "Implement get_directory"
 
     def get_type(self):
         raise "Implement get_type"
-    
+
     def read(self, offset, count):
         raise "Implement read"
 
     def write(self, offset, data):
         raise "Implement write"
-        
+
     def link(self, target):
         raise "Implement link"
 
@@ -1214,7 +1214,7 @@ class VirtualHandle(NFSFileHandle):
             raise "hardlink called with non-directory self"
         if file.fattr4_type == NF4DIR:
             raise "hardlink to a directory"
-        
+
         self.__link(file, newname)
 
     def __link(self, file, newname):
@@ -1243,7 +1243,7 @@ class VirtualHandle(NFSFileHandle):
         if self.fattr4_type == NF4DIR:
             return len(self.dirent) == 0
         raise "is_empty() called on non-dir"
-        
+
     def read(self, offset, count):
         if self.fattr4_type != NF4REG:
             raise "read called on non file!"
@@ -1272,7 +1272,7 @@ class VirtualHandle(NFSFileHandle):
         self.fattr4_size = len(self.dirent)
         self.fattr4_time_modify = converttime()
         self.fattr4_time_metadata = converttime()
-    
+
     def rename(self, oldfh, oldname, newname): # self = newfh
         file = oldfh.dirent[oldname]
         self.__link(file, newname)
@@ -1291,7 +1291,7 @@ class VirtualHandle(NFSFileHandle):
             return self.dirent.verifier
         else:
             raise "getdirverf called on non directory."
-        
+
     def read_link(self):
         if self.fattr4_type != NF4LNK:
             raise "read_link called on non NF4LNK."
@@ -1338,7 +1338,7 @@ class HardHandle(NFSFileHandle):
         self.file = file
         self.dirent = None
         self.mtime = 0
-        
+
     def do_lookupp(self):
         return self.parent
 
@@ -1361,7 +1361,7 @@ class HardHandle(NFSFileHandle):
                     ret_dict[attr] = fsid4(0, 0)
             elif attr == FATTR4_LEASE_TIME:
                     ret_dict[attr] = 1700
-            elif attr == FATTR4_FILEID: 
+            elif attr == FATTR4_FILEID:
                     ret_dict[attr] = stat_struct.st_ino
             elif attr == FATTR4_MAXFILESIZE:
                     ret_dict[attr] = 1000000
@@ -1378,7 +1378,7 @@ class HardHandle(NFSFileHandle):
             elif attr == FATTR4_OWNER_GROUP:
                     ret_dict[attr] = stat_struct.st_gid
             elif attr == FATTR4_RAWDEV:
-                    ret_dict[attr] = specdata4(0, 0) 
+                    ret_dict[attr] = specdata4(0, 0)
             elif attr == FATTR4_TIME_ACCESS:
                     ret_dict[attr] = nfstime4(stat_struct.st_atime, 0);
             elif attr == FATTR4_TIME_MODIFY:
@@ -1387,7 +1387,7 @@ class HardHandle(NFSFileHandle):
 
     def get_fhclass(self):
         return "hard"
-    
+
         def get_link(self):
                 return os.readlink(self.file)
 
@@ -1426,7 +1426,7 @@ class HardHandle(NFSFileHandle):
         for i in self.oldfiles:
             del self.dirent[i]
         return self.dirent.values()
-        
+
     def read_link(self):
         return os.readlink(self.file)
 
@@ -1435,7 +1435,7 @@ class HardHandle(NFSFileHandle):
         fh.seek(offset)
         fh.write(data)
         fh.close()
-        return len(data) 
+        return len(data)
 
 # This seems to be only used now by O_Readdir...can we get rid of it?
 ## class NFSClientHandle:
diff --git a/nfs4.0/testserver.py b/nfs4.0/testserver.py
index 801142e..0ef010a 100755
--- a/nfs4.0/testserver.py
+++ b/nfs4.0/testserver.py
@@ -2,24 +2,24 @@
 # nfs4stest.py - nfsv4 server tester
 #
 # Requires python 3.2
-# 
+#
 # Written by Fred Isaman <iisaman@citi.umich.edu>
-# Copyright (C) 2004 University of Michigan, Center for 
+# Copyright (C) 2004 University of Michigan, Center for
 #                    Information Technology Integration
 #
 # Based on pynfs
 # Written by Peter Astrand <peter@cendio.se>
 # Copyright (C) 2001 Cendio Systems AB (http://www.cendio.se)
-# 
+#
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License as published by
-# the Free Software Foundation; version 2 of the License. 
-# 
+# the Free Software Foundation; version 2 of the License.
+#
 # This program is distributed in the hope that it will be useful,
 # but WITHOUT ANY WARRANTY; without even the implied warranty of
 # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 # GNU General Public License for more details.
-# 
+#
 # You should have received a copy of the GNU General Public License
 # along with this program; if not, write to the Free Software
 # Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
@@ -112,7 +112,7 @@ def scan_options(p):
                  help="Force test dependencies to be run, "
                  "even if not requested on command line")
     p.add_option_group(g)
-    
+
     g = OptionGroup(p, "Test output options",
                     "These options affect how test results are shown.")
     g.add_option("-v", "--verbose", action="store_true", default=False,
@@ -227,7 +227,7 @@ def printflags(list):
     for s in list:
         if s not in command_names:
             print(s)
-    
+
 def main():
     nfail = -1
     p = OptionParser("%prog SERVER:/PATH [options] flags|testcodes\n"
@@ -316,7 +316,7 @@ def main():
                 (opt.security, str(valid.keys())))
     opt.flavor = valid[opt.security]
     opt.service = {'krb5':1, 'krb5i':2, 'krb5p':3}.get(opt.security, 0)
-               
+
     # Make sure args are valid
     opt.args = []
     for a in args:
diff --git a/nfs4.1/config.py b/nfs4.1/config.py
index 8779fe1..3777e31 100644
--- a/nfs4.1/config.py
+++ b/nfs4.1/config.py
@@ -116,7 +116,7 @@ class MetaConfig(type):
         for i, attr in enumerate(attrs):
             setattr(cls, attr.name, property(make_get(i), make_set(i),
                                              None, attr.comment))
-        
+
 class ServerConfig(object):
     __metaclass__ = MetaConfig
     attrs =  [ConfigLine("allow_null_data", False,
diff --git a/nfs4.1/fs.py b/nfs4.1/fs.py
index e8d413e..7f690bb 100644
--- a/nfs4.1/fs.py
+++ b/nfs4.1/fs.py
@@ -176,7 +176,7 @@ class FSObject(object):
         self.lock = RWLock(name=str(id))
         self.seek_lock = Lock("SeekLock")
         self.current_layout = None
-        self.covered_by = None # If this is a mountpoint for fs, equals fs.root 
+        self.covered_by = None # If this is a mountpoint for fs, equals fs.root
         # XXX Need to write to disk here?
         self._init_hook()
 
@@ -760,7 +760,7 @@ class ConfigObj(FSObject):
     def exists(self, name):
         """Returns True if name is in the dir"""
         log_o.log(5, "FSObject.exists(%r)" % name)
-        # HACK - build a fake client 
+        # HACK - build a fake client
         class Fake(object):
             def __init__(self):
                 self.clientid = 0
@@ -911,7 +911,7 @@ class ConfigFS(FileSystem):
         else:
             # Is a directory.  Tree is currently set up like:
             #                       config (1)
-            #        ______________/ /   \  \______________      
+            #        ______________/ /   \  \______________
             #       /               /     \                \
             # actions (8)   serverwide (2)  perclient (3)  ops (4)
             #
@@ -1292,7 +1292,7 @@ class BlockLayoutFS(FileSystem):
 
     def _make_files(self, dev):
         # STUB - hard code some test files with various properties
-        
+
         # These will use test_layout_dict to get id to layout mapping
         princ = nfs4lib.NFS4Principal("root", system=True)
         bs = self.fattr4_layout_blksize
diff --git a/nfs4.1/locking.py b/nfs4.1/locking.py
index 1dc428f..238fdad 100644
--- a/nfs4.1/locking.py
+++ b/nfs4.1/locking.py
@@ -2,7 +2,7 @@ from __future__ import with_statement
 import threading
 
 
-DEBUG = False # Note this only affects locks at creation 
+DEBUG = False # Note this only affects locks at creation
 
 class Counter(object):
     def __init__(self, first_value=0, name="counter"):
@@ -62,7 +62,7 @@ class _DebugLock(object):
         self.lock = threading.Lock()
         self.name = name
 
-    
+
     @_collect_acq_data()
     def acquire(self):
         self.lock.acquire()
@@ -86,7 +86,7 @@ class _RWLock(object):
     """
     # NOTE - in case of read-only filesystem, want acquire/release to
     # revert to NOPs, while acquire-write should raise error.
-    
+
     def __init__(self):
         self._cond = threading.Condition()
         self._write_lock = threading.Lock()
@@ -171,7 +171,7 @@ class _RWLockVerbose(_RWLock):
     """
     # NOTE - in case of read-only filesystem, want acquire/release to
     # revert to NOPs, while acquire-write should raise error.
-    
+
     def __init__(self, name=""):
         super(_RWLockVerbose, self).__init__()
         self.name = "RWLock_%s" % name
diff --git a/nfs4.1/nfs4client.py b/nfs4.1/nfs4client.py
index df573d6..c9d8775 100644
--- a/nfs4.1/nfs4client.py
+++ b/nfs4.1/nfs4client.py
@@ -99,7 +99,7 @@ class NFS4Client(rpc.Client, rpc.Server):
                 [ nfs_opnum4[a.argop].lower()[3:] for a in args[0] ],
                 nfsstat4[res.status])
         return res
-    
+
     def listen(self, xid, pipe=None, timeout=10.0):
         if pipe is None:
             pipe = self.c1
@@ -167,7 +167,7 @@ class NFS4Client(rpc.Client, rpc.Server):
             log_cb.info("Replay...sending data")
             data = e.cache.data
         return rpc.SUCCESS, data, getattr(env, "notify", None)
-        
+
     def check_utf8str_cs(self, str):
         # XXX combine code with server
         # STUB - raises NFS4Error if appropriate.
@@ -234,7 +234,7 @@ class NFS4Client(rpc.Client, rpc.Server):
         if funct is None:
             return
         funct(arg, env)
-        
+
     def posthook(self, arg, env, res=None):
         """Call the function post_<opname>_<clientid> if it exists"""
         if env.session is None:
@@ -246,7 +246,7 @@ class NFS4Client(rpc.Client, rpc.Server):
         if funct is None:
             return res
         return funct(arg, env, res)
-        
+
     def op_cb_sequence(self, arg, env):
         log_cb.info("In CB_SEQUENCE")
         if env.index != 0:
@@ -430,18 +430,18 @@ class ClientRecord(object):
         else:
             # Add hook
             setattr(self.c, hook_name, funct)
-        
+
     def cb_pre_hook(self, op_num, funct=None):
         if op_num == OP_CB_SEQUENCE:
             raise RuntimeError("Hook depends on session info from CB_SEQUENCE")
         self._cb_hook("pre", nfs_cb_opnum4[op_num][3:].lower(), funct)
-        
+
     def cb_post_hook(self, op_num, funct=None):
         self._cb_hook("post", nfs_cb_opnum4[op_num][3:].lower(), funct)
-        
+
 # XXX FIXME - this is for Slot code, put in reuasable spot if this works
-from nfs4server import Slot        
-from nfs4server import Channel as RecvChannel 
+from nfs4server import Slot
+from nfs4server import Channel as RecvChannel
 
 class SendChannel(object):
     def __init__(s, attrs):
@@ -464,7 +464,7 @@ class SendChannel(object):
             raise RuntimeError("Out of slots")
         finally:
             self.lock.release()
-                
+
 class SessionRecord(object):
     def __init__(self, csr, client):
         self.sessionid = csr.csr_sessionid
@@ -515,7 +515,7 @@ class SessionRecord(object):
                              kwargs.pop("cache_this", False))
         slot = self.fore_channel.slots[seq_op.sa_slotid]
         return slot, seq_op
- 
+
     def compound_async(self, ops, **kwargs):
         slot, seq_op = self._prepare_compound(kwargs)
         slot.xid = self.c.compound_async([seq_op] + ops, **kwargs)
diff --git a/nfs4.1/nfs4commoncode.py b/nfs4.1/nfs4commoncode.py
index 24c4650..bba5a69 100644
--- a/nfs4.1/nfs4commoncode.py
+++ b/nfs4.1/nfs4commoncode.py
@@ -47,7 +47,7 @@ def %(encode_status)s_by_name(name, status, *args, **kwargs):
         raise
         pass
     raise RuntimeError("Problem with name %%r" %% name)
-        
+
 def %(encode_status)s(status, *args, **kwargs):
     """Called from function op_<name>, encodes the operations response.
 
@@ -63,7 +63,7 @@ def %(encode_status)s(status, *args, **kwargs):
 class %(CompoundArgResults)s(object):
     size = property(lambda s: s._base_len + nfs4lib.xdrlen(s._env.tag))
     tag = property(lambda s: s.prefix + s._env.tag)
-    
+
     def __init__(self, env, prefix=b""):
         self.status = NFS4_OK # Generally == self.results[-1].status
         self.results = [] # Array of nfs_resop4 structures
@@ -106,7 +106,7 @@ class %(PairedResults)s(object):
         #        self.cache = self.reply[0:1] + [NFS4ERR_RETRY_UNCACHED_REP]
         #                        ^
         #                         \should be SEQ
-        
+
         # STUB - do size checking on self.reply
         if self.env.caching or self.env.index == 0:
             self.cache.append(result)
@@ -122,7 +122,7 @@ class %(PairedResults)s(object):
         self.reply.status = self.cache.status = status
         if tag is not None:
             self.env.tag = tag
-        
+
     # Generally make class behave like self.reply
     def __getitem__(self, key):
         return self.reply[key]
@@ -132,7 +132,7 @@ class %(PairedResults)s(object):
 
 class %(CompoundState)s(object):
     """ We hold here all the interim state the server needs to remember
-    
+
     as it handles each operation in turn.
     """
     def __init__(self, args, cred):
@@ -172,7 +172,7 @@ class %(CompoundState)s(object):
         """Pull security triple of (OID, QOP, service) from cred"""
         # STUB
         return 0
-    
+
     def get_connection(self, cred):
         """Pull connection id from credential"""
         return cred.connection
diff --git a/nfs4.1/nfs4lib.py b/nfs4.1/nfs4lib.py
index 5eada23..b1a247b 100644
--- a/nfs4.1/nfs4lib.py
+++ b/nfs4.1/nfs4lib.py
@@ -100,7 +100,7 @@ def set_attrbit_dicts():
     """Set global dictionaries manipulating attribute bit positions.
 
     Note: This function uses introspection. It assumes an entry
-    in nfs4_const.py is an attribute iff it is named FATTR4_<something>. 
+    in nfs4_const.py is an attribute iff it is named FATTR4_<something>.
 
     Returns {"type": 1, "fh_expire_type": 2,  "change": 3 ...}
             { 1: "type", 2: "fh_expire_type", 3: "change", ...}
@@ -111,7 +111,7 @@ def set_attrbit_dicts():
     for name in dir(xdrdef.nfs4_const):
         if name.startswith("FATTR4_"):
             value = getattr(xdrdef.nfs4_const, name)
-            # Sanity checking. Must be integer. 
+            # Sanity checking. Must be integer.
             assert(type(value) is int)
             attrname = name[7:].lower()
             attr2bitnum[attrname] = value
@@ -172,7 +172,7 @@ class UnexpectedCompoundRes(NFSException):
     """The COMPOUND procedure returned OK, but had unexpected data"""
     def __init__(self, msg=""):
         self.msg = msg
-    
+
     def __str__(self):
         if self.msg:
             return "Unexpected COMPOUND result: %s" % self.msg
@@ -183,7 +183,7 @@ class InvalidCompoundRes(NFSException):
     """The COMPOUND return is invalid, ie response is not to spec"""
     def __init__(self, msg=""):
         self.msg = msg
-    
+
     def __str__(self):
         if self.msg:
             return "Invalid COMPOUND result: %s" % self.msg
@@ -242,11 +242,11 @@ class FancyNFS4Unpacker(NFS4Unpacker):
             list.append(e)
         data.entries = list
         return data
-            
+
 def dict2fattr(dict):
     """Convert a dictionary of form {numb:value} to a fattr4 object.
 
-    Returns a fattr4 object.  
+    Returns a fattr4 object.
     """
 
     attrs = sorted(dict.keys())
@@ -259,7 +259,7 @@ def dict2fattr(dict):
         getattr(packer, bitnum2packer[bitnum])(value)
         attr_vals += packer.get_buffer()
     attrmask = list2bitmap(attrs)
-    return xdrdef.nfs4_type.fattr4(attrmask, attr_vals); 
+    return xdrdef.nfs4_type.fattr4(attrmask, attr_vals);
 
 def fattr2dict(obj):
     """Convert a fattr4 object to a dictionary with attribute name and values.
@@ -648,7 +648,7 @@ class AttrConfig(object):
         self._f = (kind=="obj")
         self._s = (kind=="serv")
         self._fs = (kind=="fs")
-    
+
 from xdrdef.nfs4_const import *
 
 A = AttrConfig
diff --git a/nfs4.1/nfs4proxy.py b/nfs4.1/nfs4proxy.py
index dd870d9..1b935fa 100755
--- a/nfs4.1/nfs4proxy.py
+++ b/nfs4.1/nfs4proxy.py
@@ -235,7 +235,7 @@ class NFS4Proxy(rpc.Server):
         log.debug("Proxy sent:")
         log.debug(repr(args))
         calldata = packer.get_buffer()
-        try:    
+        try:
             ret_data = self.forward_call(calldata, callback)
         except rpc.RPCTimeout:
             log.critical("Error: cannot connect to destination server")
diff --git a/nfs4.1/nfs4server.py b/nfs4.1/nfs4server.py
index 9422481..f56806e 100755
--- a/nfs4.1/nfs4server.py
+++ b/nfs4.1/nfs4server.py
@@ -109,7 +109,7 @@ class Recording(object):
     """Store RPC traffic for client"""
     def __init__(self):
         self.reset()
-        
+
     def add(self, call, reply):
         """Add call and reply strings to records"""
         if self.on:
@@ -121,7 +121,7 @@ class Recording(object):
             queue = collections.deque()
             self.queues[stamp] = queue
         self.queue = queue
-        
+
     def reset(self):
         self.stamp = "default"
         self.on = False
@@ -198,15 +198,15 @@ class StateProtection(object):
                                   handles)
             rv.spr_ssv_info = info
         return rv
-            
-        
-        
+
+
+
 class ClientList(object):
     """Manage mapping of clientids to server data.
 
     Handles the handing out of clientids, the mapping of
     client supplied ownerid to server supplied clientid, and
-    the mapping of either to ClientRecords, where all of the 
+    the mapping of either to ClientRecords, where all of the
     server's state data related to the client can be accessed.
     """
     def __init__(self):
@@ -240,7 +240,7 @@ class ClientList(object):
         """
         c = ClientRecord(self._nextid, arg, principal, security=security)
         if c.ownerid in self._data:
-            raise RuntimeError("ownerid %r already in ClientList" % 
+            raise RuntimeError("ownerid %r already in ClientList" %
                                c.ownerid)
         # STUB - want to limit size of _nextid to < 2**32, to
         # accomodate ConfigFS, which embeds clientid into fileid.
@@ -271,7 +271,7 @@ class VerboseDict(dict):
         if self.config.debug_state:
             log_41.info("+++ Removing client.state[%r]" % key)
         dict.__delitem__(self, key)
-        
+
 class ClientRecord(object):
     """The server's representation of a client and its state"""
     def __init__(self, id, arg, principal, mech=None, security=None):
@@ -289,7 +289,7 @@ class ClientRecord(object):
         self._next = 1 # counter for generating unique stateid 'other'
         self._handle_ctr = Counter(name="ssv_handle_counter")
         self._lock = Lock("Client")
-        
+
     def update(self, arg, principal):
         """Update properties of client based on EXCHANGE_ID arg"""
         if self.confirmed:
@@ -320,7 +320,7 @@ class ClientRecord(object):
         str = "handle_%i:%i" % (self.clientid, self._handle_ctr.next())
         self.security[rpc.RPCSEC_GSS]._add_context(self.protection.context, str)
         return str
-        
+
     def get_new_other(self):
         self._lock.acquire()
         # NOTE we are only using 8 bytes of 12
@@ -332,7 +332,7 @@ class ClientRecord(object):
     def __hash__(self):
         """Guarantee this can be used as dict key"""
         return hash(self.clientid)
-    
+
     def renew_lease(self):
         self.lastused = time.time()
 
@@ -446,15 +446,15 @@ class Channel(object):
         """Bind the connection to the channel"""
         if connection not in self.connections:
             self.connections.append(connection)
-                              
-        
+
+
 class Cache(object):
     def __init__(self, data=None):
         self.data = data
         self.valid = threading.Event() # XXX Is anyone waiting on this?
         if data is not None:
             self.valid.set()
-            
+
 class Slot(object):
     def __init__(self, index, default=default_replay_slot):
         self.id = index
@@ -798,7 +798,7 @@ class NFS4Server(rpc.Server):
             raise NFS4Error(NFS4ERR_INVAL, tag="Empty component")
         if '/' in str:
             raise NFS4Error(NFS4ERR_BADCHAR)
-    
+
     def op_compound(self, args, cred):
         env = CompoundState(args, cred)
         env.is_ds = self.is_ds
@@ -912,8 +912,8 @@ class NFS4Server(rpc.Server):
         res = SEQUENCE4resok(session.sessionid, slot.seqid, arg.sa_slotid,
                              arg.sa_highest_slotid, channel.maxrequests, 0)
         return encode_status(NFS4_OK, res)
-        
-               
+
+
     def op_create_session(self, arg, env):
         # This implements draft22
         check_session(env, unique=True)
@@ -1003,7 +1003,7 @@ class NFS4Server(rpc.Server):
         digest = protect.context.hmac(p.get_buffer(), SSV4_SUBKEY_MIC_T2I)
         res = SET_SSV4resok(digest)
         return encode_status(NFS4_OK, res)
-            
+
     def op_exchange_id(self, arg, env):
         # This implements draft21
         check_session(env, unique=True)
@@ -1041,7 +1041,7 @@ class NFS4Server(rpc.Server):
             elif not c.confirmed:
                 if update:
                     # Case 7
-                    return encode_status(NFS4ERR_NOENT, 
+                    return encode_status(NFS4ERR_NOENT,
                                          msg="Client not confirmed")
                 else:
                     # Case 4
@@ -1271,7 +1271,7 @@ class NFS4Server(rpc.Server):
         env.cfh = env.sfh
         env.cid = env.sid
         return encode_status(NFS4_OK)
-    
+
     def op_create(self, arg, env):
         check_session(env)
         check_cfh(env)
@@ -1360,7 +1360,7 @@ class NFS4Server(rpc.Server):
                                  open_claim_type4[claim_type])
         # emulate switch(claim_type)
         try:
-            func = getattr(self, 
+            func = getattr(self,
                            "open_%s" % open_claim_type4[claim_type].lower())
         except AttributeError:
             return encode_status(NFS4ERR_NOTSUPP, msg="Unsupported claim type")
@@ -1388,7 +1388,7 @@ class NFS4Server(rpc.Server):
         self.check_component(arg.claim.file) # XXX Done as part of lookup?
         # BUG - file locking needs to be fixed
         old_change = env.cfh.fattr4_change
-        existing = env.cfh.lookup(arg.claim.file, env.session.client, 
+        existing = env.cfh.lookup(arg.claim.file, env.session.client,
                                   env.principal)
         if arg.openhow.opentype == OPEN4_CREATE:
             # STUB - all sort of new stuff to add here
@@ -1551,7 +1551,7 @@ class NFS4Server(rpc.Server):
             p = nfs4lib.FancyNFS4Packer()
             p.pack_entry4(e)
             return len(p.get_buffer())
-            
+
         offset = 3 # index offset used to avoid reserved cookies
         check_session(env)
         check_cfh(env)
@@ -1841,7 +1841,7 @@ class NFS4Server(rpc.Server):
         with find_state(env, arg.deleg_stateid, allow_0=False) as state:
             state.delegreturn()
         return encode_status(NFS4_OK)
-    
+
     def op_getdevicelist(self, arg, env): # STUB
         check_session(env)
         check_cfh(env)
@@ -1931,7 +1931,7 @@ class NFS4Server(rpc.Server):
         else:
             state = layoutreturn_stateid(False)
         return encode_status(NFS4_OK, state)
-    
+
     def op_illegal(self, arg, env):
         return encode_status(NFS4ERR_OP_ILLEGAL)
 
@@ -1973,7 +1973,7 @@ class NFS4Server(rpc.Server):
     def ctrl_illegal(self, arg):
         #print("ILLEGAL")
         return xdrdef.sctrl_const.CTRLSTAT_ILLEGAL, xdrdef.sctrl_type.resdata_t(arg.ctrlop)
-        
+
     def op_setclientid(self, arg, env):
         return encode_status(NFS4ERR_NOTSUPP)
 
@@ -1996,7 +1996,7 @@ class NFS4Server(rpc.Server):
 
     def fsid2fs(self, fsid):
         return self._fsids[fsid]
-        
+
     def cb_compound_async(self, args, prog, credinfo=None, pipe=None, tag=None):
         if tag is None:
             tag = "Default callback tag"
@@ -2031,7 +2031,7 @@ class NFS4Server(rpc.Server):
             data = p.unpack_CB_COMPOUND4res()
         log_41.info(data)
         return data
-    
+
     def cb_null_listen(self, xid, pipe, timeout=5.0):
         header, data = pipe.listen(xid, timeout)
         log_41.info("Received CB_NULL reply")
diff --git a/nfs4.1/nfs4state.py b/nfs4.1/nfs4state.py
index f2cad04..e57b90a 100644
--- a/nfs4.1/nfs4state.py
+++ b/nfs4.1/nfs4state.py
@@ -60,7 +60,7 @@ def find_state(env, stateid, allow_0=True, allow_bypass=False):
             raise NFS4Error(NFS4ERR_BAD_STATEID, tag="stateid not known")
         if state.file != env.cfh:
             raise NFS4Error(NFS4ERR_BAD_STATEID,
-                            tag="cfh %r does not match stateid %r" % 
+                            tag="cfh %r does not match stateid %r" %
                             (state.file.fh, env.cfh.fh))
     state.lock.acquire()
     # It is possible that while waiting to get the lock, the state has been
@@ -747,7 +747,7 @@ class DelegEntry(StateTableEntry):
             # BUG deal with this
             raise RuntimeError
         # NOTE that we come in w/o state lock...when should we grab it?
-        # ANSWER - we care about self.status, which can be set to 
+        # ANSWER - we care about self.status, which can be set to
         # INVALID anytime by deleg_return
         slot = session.channel_back.choose_slot()
         seq_op = op4.cb_sequence(session.sessionid, slot.get_seqid(),
@@ -760,9 +760,9 @@ class DelegEntry(StateTableEntry):
             return
         # All sorts of STUBBINESS here
         pipe = session.channel_back.connections[0]
-        xid = dispatcher.cb_compound_async([seq_op, recall_op], 
+        xid = dispatcher.cb_compound_async([seq_op, recall_op],
                                            session.cb_prog, pipe=pipe)
-        # Note it is possible that self.invalid is True, but don't 
+        # Note it is possible that self.invalid is True, but don't
         # want to take the lock
         self.status = CB_SENT
         res = dispatcher.cb_listen(xid, pipe)
@@ -823,13 +823,13 @@ class ByteEntry(StateTableEntry):
 #         list = self.locklist
 #         if not list:
 #             list.append(ByteLock(type, start, end))
-#             return 
+#             return
 #         i = 0
 #         while (list and list[i].end < start):
 #             i += 1
 #         list.insert(i, ByteLock(type, start, end))
 #         # Merge adjacent locks
-#         # Really want range(i+1, i-1, -1), but need to account for list edges 
+#         # Really want range(i+1, i-1, -1), but need to account for list edges
 #         for i in range(min(i+1, len(list)-1), max(1,i)-1, -1):
 #             if i > 0 and list[i].start == list[i-1].end + 1 and \
 #                list[i].type == list[i-1].type:
diff --git a/nfs4.1/setup.py b/nfs4.1/setup.py
index 37b99a0..e13170e 100644
--- a/nfs4.1/setup.py
+++ b/nfs4.1/setup.py
@@ -54,11 +54,11 @@ class build_py(_build_py):
 setup(name = "nfs4",
       version = "0.0.0", # import this?
       package_dir = {"nfs4" : ""},
-      packages = ["nfs4", "nfs4.server41tests"], 
+      packages = ["nfs4", "nfs4.server41tests"],
       description = "NFS version 4.1 tools and tests",
       long_description = DESCRIPTION,
       cmdclass = {"build_py": build_py},
-      
+
       # These will be the same
       author = "Fred Isaman",
       author_email = "iisaman@citi.umich.edu",
@@ -66,6 +66,5 @@ setup(name = "nfs4",
       maintainer_email = "iisaman@citi.umich.edu",
       url = "http://www.citi.umich.edu/projects/nfsv4/pynfs/",
       license = "GPL"
-      
       )
 
diff --git a/nfs4.1/testclient.py b/nfs4.1/testclient.py
index dd68bda..87cdb30 100755
--- a/nfs4.1/testclient.py
+++ b/nfs4.1/testclient.py
@@ -2,20 +2,20 @@
 # nfs4stest.py - nfsv4 server tester
 #
 # Requires python 3.2
-# 
+#
 # Written by Fred Isaman <iisaman@citi.umich.edu>
-# Copyright (C) 2004 University of Michigan, Center for 
+# Copyright (C) 2004 University of Michigan, Center for
 #                    Information Technology Integration
 #
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License as published by
-# the Free Software Foundation; version 2 of the License. 
-# 
+# the Free Software Foundation; version 2 of the License.
+#
 # This program is distributed in the hope that it will be useful,
 # but WITHOUT ANY WARRANTY; without even the implied warranty of
 # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 # GNU General Public License for more details.
-# 
+#
 # You should have received a copy of the GNU General Public License
 # along with this program; if not, write to the Free Software
 # Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
@@ -49,12 +49,12 @@ def scan_options(p):
     .nocleanup = (False)
     .outfile   = (None)
     .debug_fail = (False)
-    
+
     .security = (sys)
 
     .force   = (False)
     .rundeps = (False)
-    
+
     .verbose  = (False)
     .showpass = (True)
     .showwarn = (True)
@@ -70,7 +70,7 @@ def scan_options(p):
     .usefile   = (None)
     .usedir    = (None)
     .usespecial= (None)
-    
+
     """
     p.add_option("--showflags", action="store_true", default=False,
                  help="Print a list of all possible flags and exit")
@@ -90,7 +90,7 @@ def scan_options(p):
 ##     g.add_option("--security", default='sys',
 ##                  help="Choose security flavor such as krb5i [sys]")
 ##     p.add_option_group(g)
-    
+
     g = OptionGroup(p, "Test selection options",
                     "These options affect how flags are interpreted.")
     g.add_option("--force", action="store_true", default=False,
@@ -99,7 +99,7 @@ def scan_options(p):
                  help="Force test dependencies to be run, "
                  "even if not requested on command line")
     p.add_option_group(g)
-    
+
     g = OptionGroup(p, "Test output options",
                     "These options affect how test results are shown")
     g.add_option("-v", "--verbose", action="store_true", default=False,
@@ -207,7 +207,7 @@ def printflags(list):
     for s in list:
         if s not in command_names:
             print(s)
-    
+
 def main():
     p = OptionParser("%prog SERVER:/PATH [options] flags|testcodes\n"
                      "       %prog --help\n"
@@ -275,7 +275,7 @@ def main():
 ##                 (opt.security, str(valid.keys())))
 ##     opt.flavor = valid[opt.security]
 ##     opt.service = {'krb5':1, 'krb5i':2, 'krb5p':3}.get(opt.security, 0)
-               
+
     # Make sure args are valid
     opt.args = []
     for a in args:
diff --git a/nfs4.1/testmod.py b/nfs4.1/testmod.py
index 6285758..e368853 100644
--- a/nfs4.1/testmod.py
+++ b/nfs4.1/testmod.py
@@ -1,9 +1,9 @@
 # testmod.py - run tests from a suite
 #
 # Requires python 3.2
-# 
+#
 # Written by Fred Isaman <iisaman@citi.umich.edu>
-# Copyright (C) 2004 University of Michigan, Center for 
+# Copyright (C) 2004 University of Michigan, Center for
 #                    Information Technology Integration
 #
 from __future__ import print_function
@@ -194,7 +194,7 @@ class Test(object):
             out += ' ' + w
             lout += lw + 1
         return out
-            
+
     def fail(self, msg):
         raise FailureException(msg)
 
@@ -275,14 +275,14 @@ class Environment(object):
     def shutDown(self):
         """Run after each test"""
         pass
-        
+
 def _run_filter(test, options):
     """Returns True if test should be run, False if it should be skipped"""
     return True
 
 def runtests(tests, options, environment, runfilter=_run_filter):
     """tests is an array of test objects, to be run in order
-    
+
     (as much as possible)
     """
     for t in tests:
@@ -307,7 +307,7 @@ def _runtree(t, options, environment, runfilter=_run_filter):
     for dep in t.dependencies:
         if dep.result == DEP_FUNCT:
             if (not options.force) and (not dep(t, environment)):
-                t.result = Result(TEST_OMIT, 
+                t.result = Result(TEST_OMIT,
                                   "Dependency function %s failed" %
                                   dep.__name__)
                 return
@@ -322,7 +322,7 @@ def _runtree(t, options, environment, runfilter=_run_filter):
             return
         elif (not options.force) and \
                  (dep.result in [TEST_OMIT, TEST_FAIL, TEST_NOTSUP]):
-            t.result = Result(TEST_OMIT, 
+            t.result = Result(TEST_OMIT,
                               "Dependency %s had status %s." % \
                               (dep, dep.result))
             return
@@ -421,7 +421,6 @@ def createtests(testdir):
                 t.dependencies.append(funct)
     return tests, flag_dict, used_codes
 
-                 
 def printresults(tests, opts, file=None):
     NOTRUN, OMIT, SKIP, FAIL, WARN, PASS = range(6)
     count = [0] * 6
diff --git a/nfs4.1/testserver.py b/nfs4.1/testserver.py
index 3cecfdc..d3c44c7 100755
--- a/nfs4.1/testserver.py
+++ b/nfs4.1/testserver.py
@@ -2,24 +2,24 @@
 # nfs4stest.py - nfsv4 server tester
 #
 # Requires python 3.2
-# 
+#
 # Written by Fred Isaman <iisaman@citi.umich.edu>
-# Copyright (C) 2004 University of Michigan, Center for 
+# Copyright (C) 2004 University of Michigan, Center for
 #                    Information Technology Integration
 #
 # Based on pynfs
 # Written by Peter Astrand <peter@cendio.se>
 # Copyright (C) 2001 Cendio Systems AB (http://www.cendio.se)
-# 
+#
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License as published by
-# the Free Software Foundation; version 2 of the License. 
-# 
+# the Free Software Foundation; version 2 of the License.
+#
 # This program is distributed in the hope that it will be useful,
 # but WITHOUT ANY WARRANTY; without even the implied warranty of
 # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 # GNU General Public License for more details.
-# 
+#
 # You should have received a copy of the GNU General Public License
 # along with this program; if not, write to the Free Software
 # Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
@@ -95,7 +95,7 @@ def scan_options(p):
                  help="Force test dependencies to be run, "
                  "even if not requested on command line")
     p.add_option_group(g)
-    
+
     g = OptionGroup(p, "Test output options",
                     "These options affect how test results are shown.")
     g.add_option("-v", "--verbose", action="store_true", default=False,
@@ -215,7 +215,7 @@ def printflags(list):
     for s in list:
         if s not in command_names:
             print(s)
-    
+
 def main():
     p = OptionParser("%prog SERVER:/PATH [options] flags|testcodes\n"
                      "       %prog --help\n"
diff --git a/rpc/rpc.py b/rpc/rpc.py
index 4a454d7..4d1eb09 100644
--- a/rpc/rpc.py
+++ b/rpc/rpc.py
@@ -122,7 +122,7 @@ class FancyRPCPacker(rpc_pack.RPCPacker):
                          py_data.proc,
                          self._filter_opaque_auth(py_data.cred),
                          py_data.verf)
-        
+
 ###################################################
 
 class DeferredData(object):
@@ -144,7 +144,7 @@ class DeferredData(object):
         self.data = None
         self._exception = None
         self.msg = msg # Data that thread calling fill might need
-        
+
     def wait(self, timeout=10):
         """Wait for data to be filled in"""
         self._filled.wait(timeout)
@@ -458,7 +458,7 @@ class ConnectionHandler(object):
 
         # Create internal server for alarm system to connect to
         self.s = self.expose((LOOPBACK, 0), socket.AF_INET, False)
-        
+
         # Set up alarm system, which is how other threads inform the polling
         # thread that data is ready to be sent out
         # NOTE that there are TWO sockets associated with alarm, one
@@ -643,7 +643,7 @@ class ConnectionHandler(object):
 
     def _event_rpc_call(self, msg, msg_data, pipe):
         """Deal with an incoming RPC CALL.
-        
+
         msg is unpacked header, with length fields added.
         msg_data is raw procedure data.
         """
@@ -785,7 +785,7 @@ class ConnectionHandler(object):
 
         # For AUTH_SYS:
         #    check machinename, mode - again how is accept list set on server?
-        
+
         # For GSS:
         #   illegal enum values should return AUTH_BADCRED
         #      this will be noticed by XDR unpack failing, which means
@@ -877,7 +877,7 @@ class ConnectionHandler(object):
             # A list of all sockets we have open, indexed by fileno
             self.sockets[s.fileno()] = s
         return s
-            
+
     def make_call_function(self, pipe, procedure, prog, vers):
         def call(data, credinfo, proc=None, timeout=15.0):
             if proc is None:
@@ -887,7 +887,7 @@ class ConnectionHandler(object):
             # XXX STUB - do header checking
             return header, data
         return call
-    
+
     def listen(self, pipe, xid):
         # STUB - should be overwritten by subclass
         header, data = pipe.listen(xid)
diff --git a/rpc/setup.py b/rpc/setup.py
index 7297099..99dad5a 100644
--- a/rpc/setup.py
+++ b/rpc/setup.py
@@ -46,11 +46,11 @@ class build_py(_build_py):
 setup(name = "rpc",
       version = "0.0.0", # import this?
       package_dir = {"rpc" : ""},
-      packages = ["rpc"], 
+      packages = ["rpc"],
       description = "GSS enabled RPC client and server",
       long_description = DESCRIPTION,
       cmdclass = {"build_py": build_py},
-      
+
       # These will be the same
       author = "Fred Isaman",
       author_email = "iisaman@citi.umich.edu",
@@ -58,6 +58,5 @@ setup(name = "rpc",
       maintainer_email = "iisaman@citi.umich.edu",
       url = "http://www.citi.umich.edu/projects/nfsv4/pynfs/",
       license = "GPL"
-      
       )
 
diff --git a/showresults.py b/showresults.py
index 5abd72a..944db40 100755
--- a/showresults.py
+++ b/showresults.py
@@ -2,9 +2,9 @@
 # showresults.py - redisplay results from nfsv4 server tester output file
 #
 # Requires python 3.2
-# 
+#
 # Written by Fred Isaman <iisaman@citi.umich.edu>
-# Copyright (C) 2004 University of Michigan, Center for 
+# Copyright (C) 2004 University of Michigan, Center for
 #                    Information Technology Integration
 #
 
diff --git a/xdr/setup.py b/xdr/setup.py
index e8af152..3acb8a2 100644
--- a/xdr/setup.py
+++ b/xdr/setup.py
@@ -12,7 +12,7 @@ Add stuff here.
 
 setup(name = "xdrgen",
       version = "0.0.0", # import this?
-      py_modules = ["xdrgen"], 
+      py_modules = ["xdrgen"],
       scripts = ["xdrgen.py"], # FIXME - make small script that calls module
       description = "Generate python code from .x files",
       long_description = DESCRIPTION,
@@ -25,6 +25,5 @@ setup(name = "xdrgen",
       maintainer_email = "iisaman@citi.umich.edu",
       url = "http://www.citi.umich.edu/projects/nfsv4/pynfs/",
       license = "GPL"
-      
       )
 
diff --git a/xdr/xdrgen.py b/xdr/xdrgen.py
index 130f364..6064586 100755
--- a/xdr/xdrgen.py
+++ b/xdr/xdrgen.py
@@ -1,22 +1,22 @@
 #!/usr/bin/env python3
 # rpcgen.py - A Python RPC protocol compiler
-# 
+#
 # Written by Fred Isaman <iisaman@citi.umich.edu>
-# Copyright (C) 2004 University of Michigan, Center for 
+# Copyright (C) 2004 University of Michigan, Center for
 #                    Information Technology Integration
 #
 # Based on version written by Peter Astrand <peter@cendio.se>
 # Copyright (C) 2001 Cendio Systems AB (http://www.cendio.se)
-# 
+#
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License as published by
-# the Free Software Foundation; version 2 of the License. 
-# 
+# the Free Software Foundation; version 2 of the License.
+#
 # This program is distributed in the hope that it will be useful,
 # but WITHOUT ANY WARRANTY; without even the implied warranty of
 # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 # GNU General Public License for more details.
-# 
+#
 # You should have received a copy of the GNU General Public License
 # along with this program; if not, write to the Free Software
 # Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
@@ -25,7 +25,7 @@
 # Note <something>_list means zero or more of <something>.
 #
 # TODO:
-# Code generation for programs and procedures. 
+# Code generation for programs and procedures.
 #
 
 ##########################################################################
@@ -209,7 +209,7 @@
         practice is to wrap arguments into a structure.
 """
 # Spec above allows the following problems:
-# typedef void; 
+# typedef void;
 # typedef enum <enum_body> ID[5];  <---Not a problem
 # typedef enum <enum_body> ID<>;   <---Not a problem
 
@@ -243,7 +243,7 @@ keywords = ("bool", "case", "const", "default", "double", "quadruple",
 # Required by lex.  Each token also allows a function t_<token>.
 tokens = tuple([t.upper() for t in keywords]) + (
     "ID", "CONST10", "CONST8", "CONST16",
-    # ( ) [ ] { } 
+    # ( ) [ ] { }
     "LPAREN", "RPAREN", "LBRACKET", "RBRACKET", "LBRACE", "RBRACE",
     # ; : < > * = ,
     "SEMI", "COLON", "LT", "GT", "STAR", "EQUALS", "COMMA"
@@ -320,7 +320,7 @@ def p_specification(t):
     '''specification : definition_list'''
 
 def p_definition_list(t):
-    '''definition_list : definition definition_list 
+    '''definition_list : definition definition_list
                        | empty'''
 
 def p_definition(t):
@@ -536,17 +536,17 @@ def p_struct_body(t):
     t[0] = t[2]
 
 def p_declaration_list_1(t):
-    '''declaration_list : declaration SEMI''' 
+    '''declaration_list : declaration SEMI'''
     t[0] = [t[1]]
 
 def p_declaration_list_2(t):
-    '''declaration_list : declaration SEMI declaration_list''' 
+    '''declaration_list : declaration SEMI declaration_list'''
     t[0] = [t[1]] + t[3]
 
 def p_enum_body(t):
     '''enum_body : LBRACE enum_constant_list RBRACE'''
     # Returns a list of const_info
-    t[0] = t[2] 
+    t[0] = t[2]
 
 def p_enum_constant(t):
     '''enum_constant : ID EQUALS value'''
@@ -809,7 +809,7 @@ class Info(object):
             newdata = "%s.%s" % (data, self.id)
         if self.array:
             newdata = data
-            subheader = "%sdef pack_one_%s(self, data):\n" % (prefix, self.id) 
+            subheader = "%sdef pack_one_%s(self, data):\n" % (prefix, self.id)
             varindent = indent
             if self.fixed:
                 array = "%sself.pack_farray(%s, data, pack_one_%s)\n" % \
@@ -835,7 +835,7 @@ class Info(object):
             newdata = "%s.%s" % (data, self.id)
         if self.array:
             subheader = "%sdef unpack_one_%s(self, data):\n" % \
-                        (prefix, self.id) 
+                        (prefix, self.id)
             varindent = indent
             array = "%s%sreturn data\n" % (prefix, varindent)
             if self.fixed:
@@ -1385,7 +1385,7 @@ class %sUnpacker(xdrlib.Unpacker):
 """ % ("%s", indent, indent2, indent2, indent2)
 
 known_basics = {"int" : "pack_int",
-                #"enum" : "pack_enum", 
+                #"enum" : "pack_enum",
                 "uint" : "pack_uint",
                 "unsigned" : "pack_uint",
                 "hyper" : "pack_hyper",
@@ -1393,8 +1393,8 @@ known_basics = {"int" : "pack_int",
                 "float" : "pack_float",
                 "double" : "pack_double",
                 # Note: xdrlib.py does not have a
-                # pack_quadruple currently. 
-                "quadruple" : "pack_double", 
+                # pack_quadruple currently.
+                "quadruple" : "pack_double",
                 "bool" : "pack_bool",
                 "opaque": "pack_opaque",
                 "string": "pack_string"}
-- 
2.31.1

