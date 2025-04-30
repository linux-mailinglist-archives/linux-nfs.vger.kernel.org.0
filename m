Return-Path: <linux-nfs+bounces-11361-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F815AA4178
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Apr 2025 05:47:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F217A1BC36A5
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Apr 2025 03:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75D7543AA1;
	Wed, 30 Apr 2025 03:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="Af+Eo+8F"
X-Original-To: linux-nfs@vger.kernel.org
Received: from esa4.hc1455-7.c3s2.iphmx.com (esa4.hc1455-7.c3s2.iphmx.com [68.232.139.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586243FE4
	for <linux-nfs@vger.kernel.org>; Wed, 30 Apr 2025 03:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.139.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745984868; cv=none; b=bBG8oqot2JynVqqVqiWhPZk3iIpGtCwGsI9J2mDUAmLTtT0zVCEOjJxKZA3PR5mWjEMm9wWULSHSIHi+a1wSphV4bHGHpncvyf/LuJM319guECZeyz0t1tgtOXzEaWiWNk2KwGDV+HGxgbWPABEDbt+W1TJIPEWZq91ohTSAers=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745984868; c=relaxed/simple;
	bh=8lTVGivkmIRFwTHa/SY1mDER9lPxR8OaGO5SIsueVjo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gAffr2FpiDsLzL3GVBb4wdE/2mfzjVJ8/anFkEvxuFyMyh7xB6eNG6jrP0z/wIzzvkmJgH14m0iZyERwaEwMm06NhRoqqDJc5UBq+RSY/Q9MvYPfhmabuGFEIpLnr0SDW1UIBaQ3wQfJ7UtH34jHN6NAtEh9+szP9dEXB+jYNiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=Af+Eo+8F; arc=none smtp.client-ip=68.232.139.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1745984866; x=1777520866;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8lTVGivkmIRFwTHa/SY1mDER9lPxR8OaGO5SIsueVjo=;
  b=Af+Eo+8FIf02nt7lVcKfsWj1NLgxyWGYv1PASPK1y5E4RYHZoeCctwNq
   s+ZdbZWnlO+TVifbjoxIg5RnkTeaEyZ8OBiRsz5ElmbDSdNNweO6e5hJB
   UeYrrqapsdMq/WzJfVBhk54FMZ1e+4DV/Aqntd2X1pGhxFccyEJdwAgSR
   8ixIxhgAxYAVEoESj1WgOwUM9GZKAOwe0CQ9GlQ5qYjbU1bIwjzRwirV0
   GcjZ1uePWrrbLhg7U/YlcUmJJ8FjAz+HDswXucuscKcxJB09ESmq0r5yL
   zR2/OICe8BzodbFpC5g8B8mz1iYdL5HZ7ujaE4WBCuu5iW0oSIypYQjK4
   Q==;
X-CSE-ConnectionGUID: S7qQFanKQIG17i4vBqm5vQ==
X-CSE-MsgGUID: 0tGHGWZnS0C1F9jmYBZBFg==
X-IronPort-AV: E=McAfee;i="6700,10204,11418"; a="198445008"
X-IronPort-AV: E=Sophos;i="6.15,251,1739804400"; 
   d="scan'208";a="198445008"
Received: from unknown (HELO oym-r4.gw.nic.fujitsu.com) ([210.162.30.92])
  by esa4.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 12:46:34 +0900
Received: from oym-m3.gw.nic.fujitsu.com (oym-nat-oym-m3.gw.nic.fujitsu.com [192.168.87.60])
	by oym-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 28667DBB80
	for <linux-nfs@vger.kernel.org>; Wed, 30 Apr 2025 12:46:32 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by oym-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id CDE80D728D
	for <linux-nfs@vger.kernel.org>; Wed, 30 Apr 2025 12:46:31 +0900 (JST)
Received: from G08XZGSD200059.g08.fujitsu.local (unknown [10.167.135.156])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 0FAB61A0071;
	Wed, 30 Apr 2025 11:46:30 +0800 (CST)
From: Chen Hanxiao <chenhx.fnst@fujitsu.com>
To: mora@netapp.com
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH] TCP: Reassemble TCP PDU segments for complete NFS message processing
Date: Wed, 30 Apr 2025 11:45:36 +0800
Message-ID: <20250430034616.1872-1-chenhx.fnst@fujitsu.com>
X-Mailer: git-send-email 2.49.0.windows.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Previously, nfstest was unable to process NFS messages split across
multiple TCP segments, resulting in missed NFS operations
and numerous test failures.

For example:

4   0.000816 192.168.122.198 → 192.168.122.199 NFS 110 V4 NULL Call
5   0.001073 192.168.122.199 → 192.168.122.198 TCP 66 2049 → 775 [ACK]
		Seq=1 Ack=45 Win=65152 Len=0 TSval=3032720633 TSecr=443583529
6   0.001155 192.168.122.199 → 192.168.122.198 TCP 70 2049 → 775 [PSH, ACK]
		Seq=1 Ack=45 Win=65152 Len=4 TSval=3032720634 TSecr=443583529 [TCP segment of a reassembled PDU]
7   0.001155 192.168.122.199 → 192.168.122.198 NFS 90 V4 NULL Reply (Call In 4)

This patch introduces functionality to reassemble TCP segments,
allowing nfstest to accurately decode complete NFS messages,
similar to Wireshark's "TCP Segment of a Reassembled PDU.

Signed-off-by: Chen Hanxiao <chenhx.fnst@fujitsu.com>
---
 packet/pktt.py          |   6 +++
 packet/transport/tcp.py | 104 +++++++++++++++++++++++++++++++++++++++-
 packet/unpack.py        |   6 +++
 3 files changed, 115 insertions(+), 1 deletion(-)

diff --git a/packet/pktt.py b/packet/pktt.py
index b9420f9..3609fdc 100644
--- a/packet/pktt.py
+++ b/packet/pktt.py
@@ -368,6 +368,10 @@ class Pktt(BaseObj):
         # IPv4 fragments used in reassembly
         self._ipv4_fragments = {}
 
+        # IPv4 PDU fragments
+        self._tcp_pdu_map = {}
+        self._tcp_pdu_pkt = {}
+
         # RDMA reassembly object
         self._rdma_info = RDMAinfo()
 
@@ -419,6 +423,8 @@ class Pktt(BaseObj):
         del self._tcp_stream_map
         del self._rpc_xid_map
         del self._rdma_info
+        del self._tcp_pdu_map
+        del self._tcp_pdu_pkt
 
     def __del__(self):
         """Destructor
diff --git a/packet/transport/tcp.py b/packet/transport/tcp.py
index e7fadf4..432b9ff 100644
--- a/packet/transport/tcp.py
+++ b/packet/transport/tcp.py
@@ -20,6 +20,7 @@ RFC  793 TRANSMISSION CONTROL PROTOCOL
 RFC 2018 TCP Selective Acknowledgment Options
 RFC 7323 TCP Extensions for High Performance
 """
+import copy
 import nfstest_config as c
 from baseobj import BaseObj
 from packet.unpack import Unpack
@@ -27,7 +28,9 @@ from packet.transport.mpa import MPA
 from packet.application.dns import DNS
 from packet.application.rpc import RPC
 from packet.application.krb5 import KRB5
-from packet.utils import OptionFlags, ShortHex
+from packet.application.rpc_const import *
+from packet.application.rpc_creds import rpc_credential
+from packet.utils import OptionFlags, ShortHex, IntHex
 
 # Module constants
 __author__    = "Jorge Mora (%s)" % c.NFSTEST_AUTHOR_EMAIL
@@ -275,6 +278,35 @@ class TCP(BaseObj):
             # This is a re-transmission, do not process
             return
 
+        if self.flags.PSH:
+            if streamid not in pktt._tcp_pdu_map:
+                pktt._tcp_pdu_map[streamid] = unpack.getbytes()
+                pktt._tcp_pdu_pkt[streamid] = pktt.pkt
+            else:
+                # TCP PDU reassemble
+                pktt._tcp_pdu_map[streamid] += unpack.getbytes()
+                pktt._tcp_pdu_pkt[streamid] = pktt.pkt
+
+            pktt.unpack.replace_data(pktt._tcp_pdu_map[streamid])
+            pktt.pkt = pktt._tcp_pdu_pkt[streamid]
+
+            try:
+                self._has_rpc_header(pktt)
+                self._decode_payload(pktt, stream)
+                del pktt._tcp_pdu_map[streamid]
+                del pktt._tcp_pdu_pkt[streamid]
+
+                if self.length > 0:
+                    stream.last_seq = seq
+                    stream.next_seq = seq + self.length
+                    if self.seq_number + self.length > UINT32_MAX:
+                        # Next sequence number will wrap around
+                        stream.seq_wrap += UINT32_MAX + 1
+                        return
+            except:
+                # looks like parts of PDU?
+                return
+
         self._decode_payload(pktt, stream)
 
         if self.length > 0:
@@ -284,6 +316,76 @@ class TCP(BaseObj):
                 # Next sequence number will wrap around
                 stream.seq_wrap += UINT32_MAX + 1
 
+    def _has_rpc_header(self, pktt):
+        '''
+        Internal method, try to decode RPC header from unpack
+        Only TRY to decode, but save noting
+        '''
+        pktt_try_unpack = copy.copy(pktt.unpack)
+        try_init_size = pktt_try_unpack.size()
+        save_data = ''
+        while True:
+             # Decode fragment header
+            try_psize = pktt_try_unpack.unpack_uint()
+            size = (try_psize & 0x7FFFFFFF) + len(save_data)
+            last_fragment = (try_psize >> 31)
+            if size == 0:
+                 return False
+            if last_fragment == 0 and size < pktt_try_unpack.size():
+                # Save RPC fragment
+                save_data += pktt_try_unpack.read(size)
+            else:
+                if len(save_data):
+                    # Concatenate RPC fragments
+                    pktt_try_unpack.insert(save_data)
+                break
+
+        # Decode XID and RPC type
+        pktt_try_xid  = IntHex(pktt_try_unpack.unpack_uint())
+        pktt_try_type = pktt_try_unpack.unpack_uint()
+        if pktt_try_type == CALL:
+            # RPC call
+            rpc_version = pktt_try_unpack.unpack_uint()
+            program     = pktt_try_unpack.unpack_uint()
+            version     = pktt_try_unpack.unpack_uint()
+            procedure   = pktt_try_unpack.unpack_uint()
+            credential  = rpc_credential(pktt_try_unpack)
+            if not credential:
+                return
+            verifier = rpc_credential(pktt_try_unpack, True)
+            if rpc_version != 2 or (credential.flavor in [0,1] and not verifier):
+                return
+        elif type == REPLY and pktt.rpc_replies:
+            # RPC reply
+            reply_status = pktt_try_unpack.unpack_uint()
+            if reply_status == MSG_ACCEPTED:
+                verifier = rpc_credential(pktt_try_unpack, True)
+                if verifier:
+                    return
+                accepted_status = accept_stat_enum(pktt_try_unpack)
+                if accepted_status == PROG_MISMATCH:
+                    prog_mismatch = Prog(pktt_try_unpack)
+                elif accept_stat.get(accepted_status) is None:
+                    # Invalid accept_stat
+                    return
+            elif reply_status == MSG_DENIED:
+                rejected_status = reject_stat_enum(pktt_try_unpack)
+                if rejected_status == RPC_MISMATCH:
+                    rpc_mismatch = Prog(pktt_try_unpack)
+                elif rejected_status == AUTH_ERROR:
+                    auth_status = auth_stat_enum(pktt_try_unpack)
+                    if auth_stat.get(auth_status) is None:
+                        # Invalid auth_status
+                        return
+                elif reject_stat.get(rejected_status) is None:
+                    # Invalid rejected status
+                    return
+            elif reply_stat.get(reply_status) is None:
+                # Invalid reply status
+                return
+        else:
+            return
+
     def __str__(self):
         """String representation of object
 
diff --git a/packet/unpack.py b/packet/unpack.py
index 223cf60..603102e 100644
--- a/packet/unpack.py
+++ b/packet/unpack.py
@@ -194,6 +194,12 @@ class Unpack(object):
         self._state.append([sid, self._offset])
         return sid
 
+    def replace_data(self, data):
+        """replace current working buffer"""
+        self._data = data
+        self._offset = 0
+        self._state = []
+
     def restore_state(self, sid):
         """Restore state given by the state id"""
         max = len(self._state)
-- 
2.47.1


