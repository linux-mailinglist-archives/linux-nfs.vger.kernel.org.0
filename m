Return-Path: <linux-nfs+bounces-23224-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ucXNJAr0T2o7rAIAu9opvQ
	(envelope-from <linux-nfs+bounces-23224-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 09 Jul 2026 21:18:34 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E8F8734DE7
	for <lists+linux-nfs@lfdr.de>; Thu, 09 Jul 2026 21:18:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=EMOM9ReI;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23224-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23224-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DF53430273BE
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Jul 2026 19:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 267C73BB128;
	Thu,  9 Jul 2026 19:02:58 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4DDF3B8D70
	for <linux-nfs@vger.kernel.org>; Thu,  9 Jul 2026 19:02:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783623778; cv=none; b=eupWeHjmnAny41O0uhOQv687vcS7qt5vkiX9KKmpqWPti9fujKqBNz8JbpQ6EnAsesdDPrwOFDkY3bK1+OEV+pYnguvJTm9UfAdxdF4hbDSlGqeWr2qnDyyQAJ7O0xKvCu87xl6yxjAN/xlK57Cyna7n1CR1Fz5BF3X7nKXqg84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783623778; c=relaxed/simple;
	bh=kFofNUrX4Cjz1T4gqKl8koQHrN7mz7oGehFfLAIaPrY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jPjzkMLIpW7FbMAWrMXPnYJynZc781jvJ9FWElUdkJTw9M4yRAgxrYpZ8jJXedGn5RvXa0NdG8sFfdKFDkcf/t2hbkYYztTZGPwwRtP9+pIJ7XuUiBZ6Lq0jugI/B9Nxhx/x61G5xDxMDtC7/qjaFXRFapB6TTq5dmMPD805eYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EMOM9ReI; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1D381F00AC4;
	Thu,  9 Jul 2026 19:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783623775;
	bh=pxp/rjAfFOptvzysEggH7CaWHxNb6TJi6hPigkgF2N0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=EMOM9ReIf77H7JsmzzE0FxXtp6x8fYQ+9CQalesEwvqA6oTlyTAChc1r7d+SKtV+/
	 H3ZPO6IZfeGp+vbUBkpnlfWKtkOd/Iu3GKpijLEqB0q1DfjydJLwGFvzDfd4djZ/UR
	 nShNxlnnLUwzTuhYBYicn+0W/fC46SlnCNPvT4YXP8mtFKKOjqhnezQFG04tmKcdnq
	 Nd89kQx/M0cxkGVwxqBKBWBVIMOe/jTyRg3z2/RpQeOptOZ+IbjP/a8NuJUX1crTiu
	 dqTAWmpESb8IcIToUyJc3VPoPp1OsyZJScFYDARi5B8tQ7neukzuo+rRITZJOV9/Tt
	 cuwyII0WvX7XQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 09 Jul 2026 15:02:39 -0400
Subject: [PATCH pynfs 11/13] server41tests: test COPY_NOTIFY
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-copy-v1-11-849bf581d7cb@kernel.org>
References: <20260709-copy-v1-0-849bf581d7cb@kernel.org>
In-Reply-To: <20260709-copy-v1-0-849bf581d7cb@kernel.org>
To: Calum Mackay <calum.mackay@oracle.com>
Cc: Chuck Lever <cel@kernel.org>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=7012; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=kFofNUrX4Cjz1T4gqKl8koQHrN7mz7oGehFfLAIaPrY=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqT/BUtg6/SDWQCXP6vKLMe+K/J//8DmO5Wh9Hr
 pYpAxxp8QCJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCak/wVAAKCRAADmhBGVaC
 FXyfEACss0B//e4NtfzLGOSZ3niL3i4vNJgDUT4NXqKpi8AuMxsr/jfTCc185f8nKSafld8gMwO
 C6IlreTXWvr+4maSGmURZPA0ZfIdKvwk8cmlJh4HRv3KOm4JlXK8d9aSmfxze0/xHO8WLTcG4xx
 JXu26scPIcRQrC5xC1i6XSVl1moMm6miE+9v/AalQnzPUE3bYB+MKTQvBrt5dN6gAjCiV1H0GyQ
 9i4i/2bB/xcVGb0iXxLafCZYyYMinp4S8EOkT2e2culco+Q1a+MWeZtAVltmLDJADos/RHjeVRd
 ZZ8KVXLL9MHwCG6XahFiZQOzc9zYcMXHZliqIYSDqlXERWKVQ80ouONOpv/9CTNuoUHWehRAY1B
 Z5WLOzMFdHYX23DXkCzf1hPJxQZvasAWNPPNqxMrJSvZ8iFSrIa8J8Tvvxz/sRZkC+U3YM3TlAx
 QqyidP+44q6HOEJyQq+IfYnboesRJvHHwXN9n6AyEbhciUG9frGY7T/yVnCVwgcum1wuWxXoZvv
 p7+I9W+6gHC11Me9TSTt5fYjqrL5Xh5U4esd8XUaVQ6llZgIHrvssd59Lshs6unel0oHg3VNGmi
 96XTgMr8ojbjItQEpxdk5nFAmeHTOkf/7VfLkRZXxCyhOw+VeS9C3961nNqrbNK170jvYd4XTv4
 g6lQWIsgCzbN4sQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23224-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:calum.mackay@oracle.com,m:cel@kernel.org,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:linux-nfs@vger.kernel.org,m:jlayton@kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,res.data:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7E8F8734DE7

Add tests exercising the source-server half of NFSv4.2 inter-server copy
against a single server.  A client requesting an inter-server copy first
sends COPY_NOTIFY to the source server to authorize the destination and
obtain a source stateid and netloc list.

CPNOTIFY1 issues a basic COPY_NOTIFY and checks that a stateid and a
non-empty source_server list are returned; CPNOTIFY2 uses a bad source
stateid (expecting NFS4ERR_BAD_STATEID); CPNOTIFY3 omits the current
filehandle (expecting NFS4ERR_NOFILEHANDLE).  All three treat
NFS4ERR_NOTSUPP as unsupported so they are portable.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 nfs4.1/server41tests/st_copy.py | 115 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 114 insertions(+), 1 deletion(-)

diff --git a/nfs4.1/server41tests/st_copy.py b/nfs4.1/server41tests/st_copy.py
index 1a392f9377b8..7eb6e2c98c4d 100644
--- a/nfs4.1/server41tests/st_copy.py
+++ b/nfs4.1/server41tests/st_copy.py
@@ -1,3 +1,4 @@
+import socket
 import time
 
 from .st_create_session import create_session
@@ -7,7 +8,7 @@ from .environment import check, fail, create_file, open_file, close_file
 from .environment import open_create_file_op, use_obj, write_file, read_file
 from xdrdef.nfs4_type import open_owner4, openflag4, createhow4, open_claim4
 from xdrdef.nfs4_type import creatverfattr, fattr4, stateid4, locker4, lock_owner4
-from xdrdef.nfs4_type import open_to_lock_owner4
+from xdrdef.nfs4_type import open_to_lock_owner4, netloc4, netaddr4
 import nfs_ops
 op = nfs_ops.NFS4ops()
 
@@ -43,6 +44,23 @@ def _bad_stateid():
     # all-one READ-bypass special stateids) the server cannot recognize.
     return stateid4(1, b'\xde\xad\xbe\xef' * 3)
 
+def _server_netloc(env):
+    """netloc4 (NL4_NETADDR) naming the server under test.
+
+    The Linux server only accepts the NL4_NETADDR form of netloc4 and
+    rejects NL4_NAME / NL4_URL at decode time with NFS4ERR_BADXDR, so build
+    a universal address (RFC 1833: h.h.h.h.p1.p2) from the server address
+    and port.  For single-server COPY_NOTIFY tests this names the server
+    itself; we only need a netloc4 the source server will accept and record.
+    """
+    host, port = env.opts.server, env.opts.port
+    family, _, _, _, sockaddr = socket.getaddrinfo(
+        host, port, type=socket.SOCK_STREAM)[0]
+    ip = sockaddr[0]
+    uaddr = "%s.%d.%d" % (ip, (port >> 8) & 0xff, port & 0xff)
+    netid = b'tcp6' if family == socket.AF_INET6 else b'tcp'
+    return netloc4(NL4_NETADDR, nl_addr=netaddr4(netid, uaddr.encode('ascii')))
+
 def _write_data(sess, fh, stateid, data, offset=0):
     """Write data in chunks bounded by the session's max request size."""
     chunk = sess.fore_channel.maxrequestsize - 1024
@@ -323,3 +341,98 @@ def testCopyToSameFile(t, env):
     check(res)
     if res.data != data:
         fail("Same-file copy: data at offset 8192 does not match source")
+
+def testCopyNotify(t, env):
+    """COPY_NOTIFY authorizes a destination server to copy from the source
+
+    A client wanting an inter-server copy first sends COPY_NOTIFY to the
+    source server (CURRENT_FH = source file) naming the destination server.
+    The source returns a stateid and a list of netlocs the destination
+    should use to reach it; the client then hands these to the destination
+    server's COPY.  This exercises the source-server half against a single
+    server.
+
+    FLAGS: copy
+    CODE: CPNOTIFY1
+    VERS: 2-
+    """
+    sess = env.c1.new_client_session(env.testname(t))
+    src_fh, src_stateid = _create_and_open(sess, env.testname(t))
+    _write_data(sess, src_fh, src_stateid, b"copy notify test data")
+
+    ops = [op.putfh(src_fh),
+           op.copy_notify(src_stateid, _server_netloc(env))]
+    res = sess.compound(ops)
+    check(res, [NFS4_OK, NFS4ERR_NOTSUPP], msg="COPY_NOTIFY")
+    if res.status == NFS4ERR_NOTSUPP:
+        t.fail_support("Server does not support COPY_NOTIFY "
+                       "(inter-server copy source)")
+
+    cnr = res.resarray[-1]
+    # The client needs a source stateid to give to the destination's COPY.
+    if cnr.cnr_stateid is None:
+        fail("COPY_NOTIFY did not return a source stateid")
+    # And at least one netloc telling the destination how to reach the source.
+    if not cnr.cnr_source_server:
+        fail("COPY_NOTIFY returned an empty cnr_source_server list")
+
+def testCopyNotifyBadStateid(t, env):
+    """COPY_NOTIFY with an invalid source stateid should fail
+
+    FLAGS: copy
+    CODE: CPNOTIFY2
+    VERS: 2-
+    """
+    sess = env.c1.new_client_session(env.testname(t))
+    src_fh, _src_stateid = _create_and_open(sess, env.testname(t))
+
+    ops = [op.putfh(src_fh),
+           op.copy_notify(_bad_stateid(), _server_netloc(env))]
+    res = sess.compound(ops)
+    if res.status == NFS4ERR_NOTSUPP:
+        t.fail_support("Server does not support COPY_NOTIFY "
+                       "(inter-server copy source)")
+    check(res, NFS4ERR_BAD_STATEID, msg="COPY_NOTIFY with bad source stateid")
+
+def testCopyNotifyUnsupportedNetloc(t, env):
+    """COPY_NOTIFY with a name or URL netloc must not return NFS4ERR_BADXDR
+
+    NL4_NAME and NL4_URL are well-formed XDR, so a server that does not
+    support them must reject the operation with NFS4ERR_NOTSUPP, not
+    NFS4ERR_BADXDR (which is reserved for XDR that cannot be decoded).  A
+    server that does support them may return NFS4_OK.
+
+    FLAGS: copy
+    CODE: CPNOTIFY4
+    VERS: 2-
+    """
+    sess = env.c1.new_client_session(env.testname(t))
+    src_fh, src_stateid = _create_and_open(sess, env.testname(t))
+
+    for name, nl in [("NL4_NAME", netloc4(NL4_NAME, nl_name=b"nfs.example.org")),
+                     ("NL4_URL", netloc4(NL4_URL,
+                                         nl_url=b"nfs://nfs.example.org/"))]:
+        res = sess.compound([op.putfh(src_fh),
+                             op.copy_notify(src_stateid, nl)])
+        if res.status == NFS4ERR_BADXDR:
+            fail("COPY_NOTIFY with a %s netloc returned NFS4ERR_BADXDR; a "
+                 "well-formed but unsupported netloc should return "
+                 "NFS4ERR_NOTSUPP" % name)
+        check(res, [NFS4_OK, NFS4ERR_NOTSUPP],
+              msg="COPY_NOTIFY with a %s netloc" % name)
+
+def testCopyNotifyNoFh(t, env):
+    """COPY_NOTIFY without a current filehandle should fail
+
+    FLAGS: copy
+    CODE: CPNOTIFY3
+    VERS: 2-
+    """
+    sess = env.c1.new_client_session(env.testname(t))
+
+    ops = [op.copy_notify(env.stateid0, _server_netloc(env))]
+    res = sess.compound(ops)
+    if res.status == NFS4ERR_NOTSUPP:
+        t.fail_support("Server does not support COPY_NOTIFY "
+                       "(inter-server copy source)")
+    check(res, NFS4ERR_NOFILEHANDLE, msg="COPY_NOTIFY with no filehandle")

-- 
2.55.0


