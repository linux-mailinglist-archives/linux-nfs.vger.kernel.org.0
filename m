Return-Path: <linux-nfs+bounces-13031-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 688BDB03A8A
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Jul 2025 11:13:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2130F16EB3E
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Jul 2025 09:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9A3523D281;
	Mon, 14 Jul 2025 09:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="Z6dsa+HT"
X-Original-To: linux-nfs@vger.kernel.org
Received: from esa3.hc1455-7.c3s2.iphmx.com (esa3.hc1455-7.c3s2.iphmx.com [207.54.90.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C28623D280
	for <linux-nfs@vger.kernel.org>; Mon, 14 Jul 2025 09:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.54.90.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752484353; cv=none; b=eLI3S1HddBybO9AcQb+ovVgOGnsCJsi+x/c9FEwsquhTmMUL7Ob5QcqVYME9rmY5U6pVYimmYF4T7fm0SpNcVWudFDpcG2h+Vs8O91Vsnh0OvkbVbFOi87phakLPN2pYGxjvXPMAE7rmH9d3Q+84rgqCpsub+/U3aRXxlBxITqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752484353; c=relaxed/simple;
	bh=K1ZbnVckCalTobgkZTpIqhUg2BTf/tMFC31CEaEgbh8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TsR3H4WdCwWRiQYhkhOkruJ1bQLjpgTSyjyjaO7HJLeIRoj3D5USPcMT+SxtS8TWC+G9GQ71xVTsQmfFrzE9Le5OnsdBGdFys0HNv0ev6Eo4XYBqQKzjroPyS5mdROQjFnrGRxtGTHJCvAB2Tio184JcieyCxGNcGhSda2J3s6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=Z6dsa+HT; arc=none smtp.client-ip=207.54.90.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1752484351; x=1784020351;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=K1ZbnVckCalTobgkZTpIqhUg2BTf/tMFC31CEaEgbh8=;
  b=Z6dsa+HThsVTd6PEt+QUtVJiE6Ytjvymfwpv2Ojn3nuNFscgiXP4FHIj
   PHZjYu9pS7N5QaKiLGb/o0e/ccsAvuBW57X+6rfsOt+MeVVX2RU2yj80b
   mhRuvRky9GPwY3OMtt79peuJWAO2M5yqgLtA6tq/qfU3O9ejSJtOqG3Z5
   2In6+5b1CfvOe1NpkKINbK9GMzzpij8ThacNlwXvZKSYSrKZbUZotc2bF
   3WisIH0GPA79ZoJst1SWhMNYsaDox7rrFaq87942z4ggXPMXTS0KWquQd
   JOBPFQlMb+wylHN1Ro0yIyNZGocAd0OTnD9MW9gSiYRQfobu3XjZcFHb9
   A==;
X-CSE-ConnectionGUID: LNJKo/bbRgm+oDxvxQg9pA==
X-CSE-MsgGUID: 3+7XESNiQFqt7d4tMg1sxg==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="206249960"
X-IronPort-AV: E=Sophos;i="6.16,310,1744038000"; 
   d="scan'208";a="206249960"
Received: from unknown (HELO az2uksmgr4.o.css.fujitsu.com) ([52.151.125.19])
  by esa3.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2025 18:12:23 +0900
Received: from az2uksmgm4.o.css.fujitsu.com (unknown [10.151.22.201])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by az2uksmgr4.o.css.fujitsu.com (Postfix) with ESMTPS id 7B2A0C00355
	for <linux-nfs@vger.kernel.org>; Mon, 14 Jul 2025 09:12:23 +0000 (UTC)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by az2uksmgm4.o.css.fujitsu.com (Postfix) with ESMTPS id DBA4B14003F3
	for <linux-nfs@vger.kernel.org>; Mon, 14 Jul 2025 09:12:22 +0000 (UTC)
Received: from G08XZGSD200059.g08.fujitsu.local (unknown [10.167.137.148])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 07D041A0071;
	Mon, 14 Jul 2025 17:12:18 +0800 (CST)
From: Chen Hanxiao <chenhx.fnst@fujitsu.com>
To: mora@netapp.com
Cc: linux-nfs@vger.kernel.org
Subject: [nfstest PATCH v2] TCP: Reassemble TCP PDU segments for complete NFS message processing
Date: Mon, 14 Jul 2025 17:11:36 +0800
Message-ID: <20250714091213.182-1-chenhx.fnst@fujitsu.com>
X-Mailer: git-send-email 2.49.0.windows.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Previously, nfstest was unable to process NFS header messages split across
multiple TCP segments, resulting in missed NFS operations
and numerous test failures. Such as Rocky Linux 9.6.

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
v2:
	fix nfstest_alloc TCP DATA segment reassemble

 packet/application/rpc.py | 28 ++++++++++++++++++++++++++++
 packet/pktt.py            |  5 +++++
 packet/transport/tcp.py   |  5 +++++
 packet/unpack.py          |  6 ++++++
 4 files changed, 44 insertions(+)

diff --git a/packet/application/rpc.py b/packet/application/rpc.py
index 718a300..7bea9f9 100644
--- a/packet/application/rpc.py
+++ b/packet/application/rpc.py
@@ -193,9 +193,35 @@ class RPC(GSS):
         pktt = self._pktt
         unpack = pktt.unpack
         init_size = unpack.size()
+        ip = pktt.pkt.ip
+        tcp = pktt.pkt.tcp
+        streamid = "%s:%d-%s:%d" % (ip.src, tcp.src_port, ip.dst, tcp.dst_port)
+        new_size = 0
         if self._proto == 6:
             # TCP packet
             save_data = ''
+            #if a split header coming and streamid not in pktt._tcp_pdu_map:
+            if tcp.flags.PSH and init_size < 16:
+                if streamid not in pktt._tcp_pdu_map:
+                    pktt._tcp_pdu_map[streamid] = unpack.getbytes()
+                    pktt._tcp_pdu_pkt[streamid] = pktt.pkt
+                    pktt._tcp_pdu_size[streamid] = unpack.size()
+                    return
+            elif tcp.flags.PSH:
+                # TCP PDU reassemble
+                if streamid in pktt._tcp_pdu_map:
+                    pktt._tcp_pdu_map[streamid] += unpack.getbytes()
+                    pktt._tcp_pdu_pkt[streamid] = pktt.pkt
+                    pktt._tcp_pdu_size[streamid] += unpack.size()
+
+                    pktt.unpack.replace_data(pktt._tcp_pdu_map[streamid])
+                    unpack = pktt.unpack
+                    pktt.pkt = pktt._tcp_pdu_pkt[streamid]
+                    new_size = pktt._tcp_pdu_size[streamid] - 4
+
+                    del pktt._tcp_pdu_map[streamid]
+                    del pktt._tcp_pdu_pkt[streamid]
+
             while True:
                 # Decode fragment header
                 psize = unpack.unpack_uint()
@@ -211,6 +237,8 @@ class RPC(GSS):
                         # Concatenate RPC fragments
                         unpack.insert(save_data)
                     break
+            if size < new_size:
+                size = new_size
             self.fragment_hdr = Header(size, last_fragment)
         elif self._proto == 17:
             # UDP packet
diff --git a/packet/pktt.py b/packet/pktt.py
index b9420f9..5e6a7ba 100644
--- a/packet/pktt.py
+++ b/packet/pktt.py
@@ -368,6 +368,11 @@ class Pktt(BaseObj):
         # IPv4 fragments used in reassembly
         self._ipv4_fragments = {}
 
+        # IPv4 PDU fragments
+        self._tcp_pdu_map = {}
+        self._tcp_pdu_pkt = {}
+        self._tcp_pdu_size = {}
+
         # RDMA reassembly object
         self._rdma_info = RDMAinfo()
 
diff --git a/packet/transport/tcp.py b/packet/transport/tcp.py
index e7fadf4..a5385c1 100644
--- a/packet/transport/tcp.py
+++ b/packet/transport/tcp.py
@@ -389,6 +389,11 @@ class TCP(BaseObj):
 
             # Get RPC header
             rpc = RPC(pktt, proto=6)
+            ip = pktt.pkt.ip
+            tcp = pktt.pkt.tcp
+            streamid = "%s:%d-%s:%d" % (ip.src, tcp.src_port, ip.dst, tcp.dst_port)
+            if streamid in pktt._tcp_pdu_size:
+                ldata = pktt._tcp_pdu_size[streamid] - 4;
         else:
             ldata = size - 4
 
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


