Return-Path: <linux-nfs+bounces-22723-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ldWeNlSXNWrV0gYAu9opvQ
	(envelope-from <linux-nfs+bounces-22723-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Jun 2026 21:24:04 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 442CD6A7818
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Jun 2026 21:24:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=LCQfN3oW;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22723-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22723-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EA94630B22B4
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Jun 2026 19:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2BC2345CBF;
	Fri, 19 Jun 2026 19:23:12 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA571346FDA
	for <linux-nfs@vger.kernel.org>; Fri, 19 Jun 2026 19:23:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781896992; cv=none; b=VLDqf/wwgXz2D8yehhymrG0hbxfehER9dEzV4a4I0Deu0zixwJPNF77melzGF8VvqYCYCWOJt4zOXmrAzcMze6/huShjKbjibZdzgammToU5jIe/I4nsuz9feFQBDsAFm+MBvnzDqHSGJ5WtRqfZtLppU0JB14XpSNwGY32YL1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781896992; c=relaxed/simple;
	bh=o12/9687/7lbgYb22UFgNuQJfonHyTtkXS4gczf4bSg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Gb3iX7Qav7KdGcmqXZEN6J9WqWRL4YWQfLpaZeYWSdM2UEhVzslveD1DgshwcvzFk/qqbUfCvJWnsKhmQvw+j1D8Vpg6mz7OgulzICkM7+8ax0Ggou+XVNOaNMkrsjH/QADKPUSQgjgMzRmdGMw4pWTEtzY0M59Z5lqfa1nxYw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LCQfN3oW; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1FF31F000E9;
	Fri, 19 Jun 2026 19:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781896990;
	bh=h8fQxAzGbfy0MV0ZP3JxPX7IkiupM2RUuOcvtPOlvyU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=LCQfN3oW98PyQU/cilTFbRBDUc9PfePFwp7IMkZ+2WSH//Uec950gxBppK+h1iHLN
	 +jgtzcaVIi/8tE0S15bUQrE5ELPQyugtKPw8sR2sFHB+qqQgQ9O8mF5p0mOd64FL59
	 dH7RyM+d5+0Eyx9+g4qMoLPFau1Fwm/fWlOCmDTksZsRhO0fD2ydjA4L+2ftyuG4b+
	 c7HMi2M4y3333Pj7sg8IQY0z+igeZfvdS8poVurpo+bkZhSGXNnZcwXmjb78bwDgxO
	 6M0I80RUfmyFEaKMi3ZZyj7jPza8bRT52x3koP6osvaxKK9heyxufAbGEx6T8cV7ot
	 6xWXzYpgo9xkg==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 19 Jun 2026 15:22:45 -0400
Subject: [PATCH pynfs v3 26/26] nfs4.1: move a lot of log/log_cb.info
 messages to log/log_cb.debug
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260619-dir-deleg-v3-26-1077ce8aab1b@kernel.org>
References: <20260619-dir-deleg-v3-0-1077ce8aab1b@kernel.org>
In-Reply-To: <20260619-dir-deleg-v3-0-1077ce8aab1b@kernel.org>
To: Calum Mackay <calum.mackay@oracle.com>
Cc: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>, Scott Mayhew <smayhew@redhat.com>, 
 linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=8414; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=o12/9687/7lbgYb22UFgNuQJfonHyTtkXS4gczf4bSg=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqNZb+X46Zf/AeqFFEUbZA0HuIZ3fz4cVGnZfox
 Ui2VqI+IreJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCajWW/gAKCRAADmhBGVaC
 FUPPD/9Jr4BCcjucQ9pIrSaLbMHiPiRXS5QiiXHC8vUhCtq2D4qPSwI8f2k7JEzjwwcpA/U5nMX
 JuY9PIdg+0zVqJH2+7Rz+8LqgnNDHQNPGKK6++2GvpyaBu9QUuw95d9buk2V2wVOQXHopzkltCM
 w/RAWmGWW8SOQMPMhRQ7MKa9IDiBJBWRgO2iYqb74BMpwwmuNskdmCVKSilyYJ7eNwtlV4m0PUq
 CWgVp/+D61tlyjdVt88VrGYy56xbqMJs0COEUQ5xMDFSbkmHZHi//A0Ur3cjEq6cLff8NNpVUT1
 6ISJnxXeYfO9Cl4dkGkBb9/Af/1SY5ohssTVdW3KGfHGQqxDJVHTeA6xJQKcyyarray5BUUkNul
 RwWUP55jCvd2V8l6c4aYHZrLIhJXm9COqGQtVZJcXhAxHC2iVQsn+EPhcbjkoBXiZTjW7FxFCuk
 l6iPCtmkiHP5yB8xe8X3YQ3mw+U8AITD9xuQOa0W2bGhiGpF4786bo8uwnVWRpDft2h8D3rcqjC
 TgXME/06dP7B+FYHRFI4RmZ8qsMLirqo0X1zZ6LgseaeRKRILHAz8yL6es2742k+JY5ANw8NUMb
 4QKRjjHyLhvv4yzN8UusjiZJP+ccIN4RndX6wHDGcbUPaHgAQegNjHFykrI49vhDIJXJ96HqunT
 PekTmpg9JtVsq6Q==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22723-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:calum.mackay@oracle.com,m:chuck.lever@oracle.com,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:trondmy@kernel.org,m:anna@kernel.org,m:smayhew@redhat.com,m:linux-nfs@vger.kernel.org,m:jlayton@kernel.org,s:lists@lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 442CD6A7818

Most of these are note terribly useful in the normal case. Change them
from info level to debug.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 nfs4.1/nfs4client.py                  | 38 +++++++++++++++++------------------
 nfs4.1/server41tests/environment.py   |  4 ++--
 nfs4.1/server41tests/st_delegation.py |  3 ---
 3 files changed, 21 insertions(+), 24 deletions(-)

diff --git a/nfs4.1/nfs4client.py b/nfs4.1/nfs4client.py
index dbe7af761f16..79df26ea1cda 100644
--- a/nfs4.1/nfs4client.py
+++ b/nfs4.1/nfs4client.py
@@ -83,7 +83,7 @@ class NFS4Client(rpc.Client, rpc.Server):
         p = packer(check_enum=checks, check_array=checks)
         c4 = COMPOUND4args(tag, version, ops)
         if SHOW_TRAFFIC:
-            log_cb.info("compound args = %r" % (c4,))
+            log_cb.debug("compound args = %r" % (c4,))
         p.pack_COMPOUND4args(c4)
         return self.send_call(pipe, 1, p.get_buffer(), credinfo)
 
@@ -93,7 +93,7 @@ class NFS4Client(rpc.Client, rpc.Server):
         pipe = kwargs.get("pipe", None)
         res = self.listen(xid, pipe=pipe)
         if SHOW_TRAFFIC:
-            log_cb.info("compound result = %r" % (res,))
+            log_cb.debug("compound result = %r" % (res,))
         if self.summary:
             self.summary.show_op('call v4.1 %s:%s' % self.server_address,
                 [ nfs_opnum4[a.argop].lower()[3:] for a in args[0] ],
@@ -112,8 +112,8 @@ class NFS4Client(rpc.Client, rpc.Server):
     def handle_0(self, data, cred):
         """NULL procedure"""
         allow_null_data = True
-        log_cb.info("*" * 20)
-        log_cb.info("Handling CB_NULL")
+        log_cb.debug("*" * 20)
+        log_cb.debug("Handling CB_NULL")
         if data and not allow_null_data:
             return rpc.GARBAGE_ARGS, None
         else:
@@ -121,16 +121,16 @@ class NFS4Client(rpc.Client, rpc.Server):
 
     def handle_1(self, data, cred):
         # STUB
-        log_cb.info("*" * 20)
-        log_cb.info("Handling CB_COMPOUND")
+        log_cb.debug("*" * 20)
+        log_cb.debug("Handling CB_COMPOUND")
         p = nfs4lib.FancyNFS4Packer()
         res = CB_COMPOUND4res(NFS4ERR_BACK_CHAN_BUSY, "STUB CB_REPLY", [])
         p.pack_CB_COMPOUND4res(res)
         return rpc.SUCCESS, p.get_buffer()
 
     def handle_1(self, data, cred):
-        log_cb.info("*" * 20)
-        log_cb.info("Handling COMPOUND")
+        log_cb.debug("*" * 20)
+        log_cb.debug("Handling COMPOUND")
         # data is an XDR packed string.  Unpack it.
         unpacker = nfs4lib.FancyNFS4Unpacker(data)
         try:
@@ -146,7 +146,7 @@ class NFS4Client(rpc.Client, rpc.Server):
             args.req_size = len(data)
             # Handle the request
             env = self.op_cb_compound(args, cred)
-            log_cb.info(repr(env.results.reply.results))
+            log_cb.debug(repr(env.results.reply.results))
             # Pack the results back into an XDR string
             p = nfs4lib.FancyNFS4Packer()
             p.pack_CB_COMPOUND4res(CB_COMPOUND4res(env.results.reply.status,
@@ -162,9 +162,9 @@ class NFS4Client(rpc.Client, rpc.Server):
                 env.cache.data = p.get_buffer()
                 env.cache.valid.set()
         except NFS4Replay as e:
-            log_cb.info("Replay...waiting for valid data")
+            log_cb.debug("Replay...waiting for valid data")
             e.cache.valid.wait()
-            log_cb.info("Replay...sending data")
+            log_cb.debug("Replay...sending data")
             data = e.cache.data
         return rpc.SUCCESS, data, getattr(env, "notify", None)
 
@@ -190,7 +190,7 @@ class NFS4Client(rpc.Client, rpc.Server):
         status = NFS4_OK
         for arg in args.argarray:
             opname = nfs_cb_opnum4.get(arg.argop, 'op_cb_illegal')
-            log_cb.info("*** %s (%d) ***" % (opname, arg.argop))
+            log_cb.debug("*** %s (%d) ***" % (opname, arg.argop))
             env.index += 1
             # Look for function self.op_<name>
             funct = getattr(self, opname.lower(), None)
@@ -220,7 +220,7 @@ class NFS4Client(rpc.Client, rpc.Server):
             status = result.status
             if status != NFS4_OK:
                 break
-        log_cb.info("Replying.  Status %s (%d)" % (nfsstat4[status], status))
+        log_cb.debug("Replying.  Status %s (%d)" % (nfsstat4[status], status))
         return env
 
     def prehook(self, arg, env):
@@ -248,7 +248,7 @@ class NFS4Client(rpc.Client, rpc.Server):
         return funct(arg, env, res)
 
     def op_cb_sequence(self, arg, env):
-        log_cb.info("In CB_SEQUENCE")
+        log_cb.debug("In CB_SEQUENCE")
         if env.index != 0:
             return encode_status(NFS4ERR_SEQUENCE_POS)
         session = self.sessions.get(arg.csa_sessionid, None)
@@ -272,31 +272,31 @@ class NFS4Client(rpc.Client, rpc.Server):
         return encode_status(NFS4_OK, res)
 
     def op_cb_getattr(self, arg, env):
-        log_cb.info("In CB_GETATTR")
+        log_cb.debug("In CB_GETATTR")
         self.prehook(arg, env)
         res = self.posthook(arg, env, res=CB_GETATTR4resok())
         return encode_status(NFS4_OK, res)
 
     def op_cb_recall(self, arg, env):
-        log_cb.info("In CB_RECALL")
+        log_cb.debug("In CB_RECALL")
         self.prehook(arg, env)
         res = self.posthook(arg, env, res=NFS4_OK)
         return encode_status(res)
 
     def op_cb_notify(self, arg, env):
-        log_cb.info("In CB_NOTIFY")
+        log_cb.debug("In CB_NOTIFY")
         self.prehook(arg, env)
         res = self.posthook(arg, env, res=NFS4_OK)
         return encode_status(res)
 
     def op_cb_notify_lock(self, arg, env):
-        log_cb.info("In CB_NOTIFY_LOCK")
+        log_cb.debug("In CB_NOTIFY_LOCK")
         self.prehook(arg, env)
         res = self.posthook(arg, env, res=NFS4_OK)
         return encode_status(res)
 
     def op_cb_layoutrecall(self, arg, env):
-        log_cb.info("In CB_LAYOUTRECALL")
+        log_cb.debug("In CB_LAYOUTRECALL")
         self.prehook(arg, env)
         res = self.posthook(arg, env, res=NFS4_OK)
         if res is not NFS4_OK:
diff --git a/nfs4.1/server41tests/environment.py b/nfs4.1/server41tests/environment.py
index f5b1fea4a64c..c14b12cbfca5 100644
--- a/nfs4.1/server41tests/environment.py
+++ b/nfs4.1/server41tests/environment.py
@@ -443,7 +443,7 @@ def do_readdir(sess, file, cookie=0, cookieverf=b'', attrs=0,
     # Since we may not get whole directory listing in one readdir request,
     # loop until we do. For each request result, create a flat list
     # with <entry4> objects.
-    log.info("Called do_readdir()")
+    log.debug("Called do_readdir()")
     entries = []
     baseops = use_obj(file)
     while True:
@@ -458,7 +458,7 @@ def do_readdir(sess, file, cookie=0, cookieverf=b'', attrs=0,
             break
         cookie = entries[-1].cookie
         cookieverf = res.resarray[-1].cookieverf
-    log.info("do_readdir() = %r" % entries)
+    log.debug("do_readdir() = %r" % entries)
     return entries
 
 def do_getattrdict(sess, file, attrlist):
diff --git a/nfs4.1/server41tests/st_delegation.py b/nfs4.1/server41tests/st_delegation.py
index 41095b98a7a4..a67a3ba9e73f 100644
--- a/nfs4.1/server41tests/st_delegation.py
+++ b/nfs4.1/server41tests/st_delegation.py
@@ -266,10 +266,8 @@ def testServerSelfConflict3(t, env):
 
     fh, deleg = __create_file_with_deleg(sess1, env.testname(t),
             OPEN4_SHARE_ACCESS_READ | OPEN4_SHARE_ACCESS_WANT_READ_DELEG)
-    print("__create_file_with_deleg: ", fh, deleg)
     delegstateid = deleg.read.stateid
     res = open_file(sess1, env.testname(t), access = OPEN4_SHARE_ACCESS_WRITE)
-    print("open_file res: ", res)
     check(res)
 
     # XXX: cut-n-paste from _testDeleg; make helper instead:
@@ -319,7 +317,6 @@ def _testCbGetattr(t, env, change=0, size=0):
             openmask |= 1<<OPEN_ARGS_SHARE_ACCESS_WANT_DELEG_TIMESTAMPS
 
     fh, deleg = __create_file_with_deleg(sess1, env.testname(t), openmask)
-    print("__create_file_with_deleg: ", fh, deleg)
     attrs1 = do_getattrdict(sess1, fh, [FATTR4_CHANGE, FATTR4_SIZE,
                                         FATTR4_TIME_ACCESS, FATTR4_TIME_MODIFY])
 

-- 
2.54.0


