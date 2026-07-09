Return-Path: <linux-nfs+bounces-23226-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cAh2FoXyT2raqwIAu9opvQ
	(envelope-from <linux-nfs+bounces-23226-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 09 Jul 2026 21:12:05 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 28672734CC2
	for <lists+linux-nfs@lfdr.de>; Thu, 09 Jul 2026 21:12:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=arzXV0o3;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23226-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23226-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3899530BEFAC
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Jul 2026 19:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 146F73A1A29;
	Thu,  9 Jul 2026 19:03:08 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F8A39A057
	for <linux-nfs@vger.kernel.org>; Thu,  9 Jul 2026 19:02:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783623788; cv=none; b=tAjuYpVPohdpqX7jKACOq/CGQhT7VPC5pQEVQ5fn2TNm5xBL1pOk5VYUgxTgVvb5IXw6q0ZdiwKP6OJ0CMJtXDRt/NoVwWCPi00HyxChFE9yDLX7gxSGFBiqWT6x4Uy7YMDL+D0p2bTyRLOCHhRjE3NbDAaiY+Ru4WzmdOA4Y9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783623788; c=relaxed/simple;
	bh=5g9VmIxvmwWkzgYnZqs2aA8ejF1eyNTzjFA+syyUc5w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YHFITyzmaDkC5aV24RkHww6zBYY2yOJGHOrhspmxGWuRayeySjZ8Vks8m5QA2TXIFkhdkIg6ktUMrP7bGmjVxZAgqnqMd/FSEn3cQ0KJTyCgReGwkhDHy0Gj4NtR1iOzrkUEeZAkmMqS6nvRVBuQ9VdL6S3EhpOUgIaKlyuWFmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=arzXV0o3; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C568C1F00A3A;
	Thu,  9 Jul 2026 19:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783623776;
	bh=ssqSyy6PD1j/fv8Wb2ttS6dHMztoMMBy2RbQSRbfR0o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=arzXV0o38G1DclONNBCKkmINuZqSyhZCQJjHq9+LhWs05ttCqqQozEzD7lF4+jO6d
	 JPgY5RhD3j9wHJ3hPYlfbrAlQ1/eoB4APrN0hD68QJogOxRS1y+dl9bq/Df7i7SDKX
	 N80tJbfmC7QQ8RkkLeTNeKoH01xmnR4V8B0Ey2Dycu0tkkbqBN5uZODC0ARTwpryRq
	 JxNvTew3t4P+uv1RvJZbW20FxqBrEuH6lr1e3M0bJ5vNWfWivOuGtVgPzbCPcFJp10
	 WQHW7hN7nHdh7h3oz0xEk4sPklIf71VQpKorYMYoQNwqp0bO60hwqc90OuJdTU1Q7A
	 T7hZq5p6a5/gw==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 09 Jul 2026 15:02:40 -0400
Subject: [PATCH pynfs 12/13] server41tests: support a second server for
 inter-server copy
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-copy-v1-12-849bf581d7cb@kernel.org>
References: <20260709-copy-v1-0-849bf581d7cb@kernel.org>
In-Reply-To: <20260709-copy-v1-0-849bf581d7cb@kernel.org>
To: Calum Mackay <calum.mackay@oracle.com>
Cc: Chuck Lever <cel@kernel.org>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=10529; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=5g9VmIxvmwWkzgYnZqs2aA8ejF1eyNTzjFA+syyUc5w=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqT/BVJa76mTJR/SfqusrV+ZXz8OecVpZnpFssG
 dL3TF4Nh5KJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCak/wVQAKCRAADmhBGVaC
 Ff9rD/9baLm+0wu5bD5tsO+qhoyBU1rm1ZIrfxHH0hr6YPO6gN1pRdO4CO1C+VUFgOcDqPWeIpQ
 x6G2YJ6NRa+eTq7Y26jphwZI2BdgJxN2QAcDMi/SeIBc74mZlNAHU81dmDClVIcZ3QnPQbjO7Jo
 UDjxtvf4XX2fg7K5gQAxFHTuDj5c2pzydKUjC5KFywwSCk3zWst1k81rog7ziy/+t0FNXZYmK+O
 uzjh0kxMLwCbqljsFCPU9qExllNDk6qK7mIAPtZO2QT6NYgFxZceuXtTbksYsmbq52+Df7D2Fxa
 440mVrNDi0nxBUV2VKfBZBzMwztgHairja+2a69xNGmmdwMAao4wB/jsEvFivT5gNqXNgsxCgly
 ce+nvJVq0VvCZZlSS5k5bAWLbKLNRDmhph84BaEf7uxVx+CI4LX8xE60sluoLpPe7a5weah1qPD
 pReQwHdMzlaVnI4biREYZ7BomQyW0n2Xqmz+fgKDvMoQLJi4vk8wnHv95OdxlzwrpRgtPUn+ygU
 8nvrz6TlkUnaPcc5OlHczjWZ0gALzlmdBCWnGfVjkSz36DB4ZNO04/Uo+75NvF4kjY8oLbzK+Sy
 DJVA/4aSTTfUrfgu/4kt/zi3W1Bqmmi6i80QOHfk9j0sDuXj6JhN30+VmNPhHcTBGFkD27S9Jo3
 Js/NX47yxJvkTfQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23226-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 28672734CC2

Inter-server (server-to-server) COPY tests need to talk to two servers.
Add a --server2 SERVER:/PATH option, parsed with parse_nfs_url, and an
optional second client env.c2 in the test environment.

The environment now creates, initializes, and cleans up the test tree on
both servers, and factors credential creation into a helper so c2 gets a
credential built the same way as c1.  When --server2 is not given, c2 is
None and single-server runs are unaffected.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 nfs4.1/server41tests/environment.py | 127 ++++++++++++++++++++++++------------
 nfs4.1/testserver.py                |  14 ++++
 2 files changed, 98 insertions(+), 43 deletions(-)

diff --git a/nfs4.1/server41tests/environment.py b/nfs4.1/server41tests/environment.py
index c14b12cbfca5..38cd5a7a7185 100644
--- a/nfs4.1/server41tests/environment.py
+++ b/nfs4.1/server41tests/environment.py
@@ -119,23 +119,23 @@ class Environment(testmod.Environment):
         self._lock = Lock()
         self.opts = opts
         self.c1 = nfs4client.NFS4Client(opts.server, opts.port, opts.minorversion, secure=opts.secure)
-        s1 = rpc.security.instance(opts.flavor)
-        if opts.flavor == rpc.AUTH_NONE:
-            self.cred1 = s1.init_cred()
-        elif opts.flavor == rpc.AUTH_SYS:
-            self.cred1 = s1.init_cred(uid=opts.uid, gid=opts.gid, name=opts.machinename)
-        elif opts.flavor == rpc.RPCSEC_GSS:
-            call = self.c1.make_call_function(self.c1.c1, 0,
-                                              self.c1.default_prog,
-                                              self.c1.default_vers)
-            krb5_cred = AuthGss().init_cred(call, target="nfs@%s" % opts.server)
-            krb5_cred.service = opts.service
-            self.cred1 = krb5_cred
-        self.c1.set_cred(self.cred1)
+        self.cred1 = self._make_cred(self.c1, opts.server)
         self.cred2 = AuthSys().init_cred(uid=1111, gid=37, name=b"shampoo")
 
         opts.home = opts.path + [b'tmp']
         self.c1.homedir = opts.home
+
+        # Optional second server, used only by inter-server (server-to-server)
+        # COPY tests.  Enabled by passing --server2 SERVER:/PATH on the
+        # command line; None otherwise so single-server runs are unaffected.
+        self.c2 = None
+        if getattr(opts, "server2", None):
+            self.c2 = nfs4client.NFS4Client(opts.server2_host, opts.server2_port,
+                                            opts.minorversion, secure=opts.secure)
+            opts.server2_home = opts.server2_path + [b'tmp']
+            self.c2.homedir = opts.server2_home
+            self._make_cred(self.c2, opts.server2_host)
+
         # Put this after client creation, to ensure _last_verf bigger than
         # any natural client verifiers
         self.timestamp = int(time.time())
@@ -146,38 +146,72 @@ class Environment(testmod.Environment):
         self.stateid1 = stateid4(0xffffffff, b'\xff'*12)
 
         log.info("Created client to %s, %i" % (opts.server, opts.port))
+        if self.c2 is not None:
+            log.info("Created second client to %s, %i" %
+                     (opts.server2_host, opts.server2_port))
+
+    def _make_cred(self, client, server_host):
+        """Build and install an RPC credential on client for server_host."""
+        s = rpc.security.instance(self.opts.flavor)
+        if self.opts.flavor == rpc.AUTH_NONE:
+            cred = s.init_cred()
+        elif self.opts.flavor == rpc.AUTH_SYS:
+            cred = s.init_cred(uid=self.opts.uid, gid=self.opts.gid,
+                               name=self.opts.machinename)
+        elif self.opts.flavor == rpc.RPCSEC_GSS:
+            call = client.make_call_function(client.c1, 0,
+                                             client.default_prog,
+                                             client.default_vers)
+            cred = AuthGss().init_cred(call, target="nfs@%s" % server_host)
+            cred.service = self.opts.service
+        client.set_cred(cred)
+        return cred
+
+    def _all_clients(self):
+        """All configured clients (c1, and c2 if a second server was given)."""
+        return [c for c in (self.c1, self.c2) if c is not None]
 
     def init(self):
         """Run once before any test is run"""
         if self.opts.noinit:
             return
-        sess = self.c1.new_client_session(b"Environment.init_%i" %
-                                                    self.timestamp)
+        self._init_server(self.c1, self.opts.path, self.opts.home)
+        if self.c2 is not None:
+            self._init_server(self.c2, self.opts.server2_path,
+                              self.opts.server2_home)
+        self.clean_sessions()
+        self.clean_clients()
+
+    def _init_server(self, c, path, home):
+        """Prepare (and optionally build) the test tree on a single server."""
+        sess = c.new_client_session(b"Environment.init_%i" % self.timestamp)
         if self.opts.maketree:
-            self._maketree(sess)
-        # Make sure opts.home exists
-        res = sess.compound(use_obj(self.opts.home))
-        check(res, msg="Could not LOOKUP /%s," % b'/'.join(self.opts.home))
+            self._maketree(sess, path, home)
+        # Make sure home exists
+        res = sess.compound(use_obj(home))
+        check(res, msg="Could not LOOKUP /%s," % b'/'.join(home))
         # Make sure it is empty
-        clean_dir(sess, self.opts.home)
+        clean_dir(sess, home)
         sess.c.null()
-        self.clean_sessions()
-        self.clean_clients()
 
-    def _maketree(self, sess):
+    def _maketree(self, sess, path=None, home=None):
         """Make test tree"""
+        if path is None:
+            path = self.opts.path
+        if home is None:
+            home = self.opts.home
         # ensure /tmp (and path leading up) exists
-        path = []
-        for comp in self.opts.home:
-            path.append(comp)
-            res = sess.compound(use_obj(path))
+        p = []
+        for comp in home:
+            p.append(comp)
+            res = sess.compound(use_obj(p))
             check(res, [NFS4_OK, NFS4ERR_NOENT],
-                      "LOOKUP /%s," % b'/'.join(path))
+                      "LOOKUP /%s," % b'/'.join(p))
             if res.status == NFS4ERR_NOENT:
-                res = create_obj(sess, path, NF4DIR)
-                check(res, msg="Trying to create /%s," % b'/'.join(path))
+                res = create_obj(sess, p, NF4DIR)
+                check(res, msg="Trying to create /%s," % b'/'.join(p))
         # ensure /tree exists and is empty
-        tree = self.opts.path + [b'tree']
+        tree = path + [b'tree']
         res = sess.compound(use_obj(tree))
         check(res, [NFS4_OK, NFS4ERR_NOENT])
         if res.status == NFS4ERR_NOENT:
@@ -210,16 +244,21 @@ class Environment(testmod.Environment):
         """Run once after all tests are run"""
         if self.opts.nocleanup:
             return
-        sess = self.c1.new_client_session(b"Environment.init_%i" % self.timestamp)
-        clean_dir(sess, self.opts.home)
-        sess.c.null()
+        homes = [(self.c1, self.opts.home)]
+        if self.c2 is not None:
+            homes.append((self.c2, self.opts.server2_home))
+        for c, home in homes:
+            sess = c.new_client_session(b"Environment.init_%i" % self.timestamp)
+            clean_dir(sess, home)
+            sess.c.null()
         self.clean_sessions()
         self.clean_clients()
 
     def startUp(self):
         """Run before each test"""
         log.debug("Sending pretest NULL")
-        self.c1.null()
+        for c in self._all_clients():
+            c.null()
         log.debug("Got pretest NULL response")
 
     def sleep(self, sec, msg=''):
@@ -260,16 +299,18 @@ class Environment(testmod.Environment):
         return b"%s_%i" % (os.fsencode(t.code), self.timestamp)
 
     def clean_sessions(self):
-        """Destroy client name env.c1"""
-        for sessionid in list(self.c1.sessions):
-            self.c1.compound([op.destroy_session(sessionid)])
-            del(self.c1.sessions[sessionid])
+        """Destroy all sessions on all configured clients"""
+        for c in self._all_clients():
+            for sessionid in list(c.sessions):
+                c.compound([op.destroy_session(sessionid)])
+                del(c.sessions[sessionid])
 
     def clean_clients(self):
-        """Destroy client name env.c1"""
-        for clientid in list(self.c1.clients):
-            self.c1.compound([op.destroy_clientid(clientid)])
-            del(self.c1.clients[clientid])
+        """Destroy all client ids on all configured clients"""
+        for c in self._all_clients():
+            for clientid in list(c.clients):
+                c.compound([op.destroy_clientid(clientid)])
+                del(c.clients[clientid])
 
 #########################################
 debug_fail = False
diff --git a/nfs4.1/testserver.py b/nfs4.1/testserver.py
index 0970c64efe34..f38279b36cba 100755
--- a/nfs4.1/testserver.py
+++ b/nfs4.1/testserver.py
@@ -153,6 +153,13 @@ def scan_options(p):
                  help="Use FH for certain specialized tests")
     p.add_option_group(g)
 
+    g = OptionGroup(p, "Inter-server copy options",
+                    "A second server enables NFSv4.2 inter-server "
+                    "(server-to-server) COPY tests.")
+    g.add_option("--server2", default=None, metavar="SERVER:/PATH",
+                 help="Second server and export for inter-server copy tests")
+    p.add_option_group(g)
+
     g = OptionGroup(p, "Server workaround options",
                     "Certain servers handle certain things in unexpected ways."
                     " These options allow you to alter test behavior so that "
@@ -259,6 +266,13 @@ def main():
 
     opt.server, opt.port = server_list[0]
 
+    # Optional second server for inter-server copy tests
+    if opt.server2 is not None:
+        server2_list, opt.server2_path = nfs4lib.parse_nfs_url(opt.server2)
+        if not server2_list:
+            p.error("%s not a valid server name" % opt.server2)
+        opt.server2_host, opt.server2_port = server2_list[0]
+
     if not args:
         p.error("No tests given")
 

-- 
2.55.0


