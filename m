Return-Path: <linux-nfs+bounces-22700-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VhHKAQ2XNWqm0gYAu9opvQ
	(envelope-from <linux-nfs+bounces-22700-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Jun 2026 21:22:53 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B2D146A77B8
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Jun 2026 21:22:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=JH6lgsBA;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22700-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22700-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B7C723014C7E
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Jun 2026 19:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B93B344D86;
	Fri, 19 Jun 2026 19:22:51 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CBA533E360
	for <linux-nfs@vger.kernel.org>; Fri, 19 Jun 2026 19:22:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781896971; cv=none; b=WtlrH7UyfBZ01XFQi+Qrh/ueiX+ySOJ5Zkg7dz5lJ+FK8yyhI3a+v4ur6+bH09qW8435heGZatvAMRHVzjNhAEtvIMbynoVnGEfbw8yW37FW4tLXl08/c8n0P1NeUQ4yvo/Xk9wm88YR39GuoQLBHA2ZZFFncZ5NzsJo9YLQ+nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781896971; c=relaxed/simple;
	bh=B1vu1ivcqpEpDECFzvkfHeqjMYDunsfnCWnsv8v33b0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RjG0G+PKLjNKwKp9/YChbx8iqwt8vf6hpylvIOYJ/nm7p2X6hLWAO7voj8JIyVZhzwDrROLletqZZhw270Y7WtB1yoHO7/DzgPMqRo56/Xyta5AtszVK3FhRbhNyLg8q9IXHqOAj1xPVfKoF0iF4jBawlASO+mk7IdV02GbD008=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JH6lgsBA; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AE281F00A3D;
	Fri, 19 Jun 2026 19:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781896963;
	bh=8ZJHCSKqW+HFYukf7vMFNlzL9NwBW4TOqym6TmI1M6w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=JH6lgsBAZxfgVGdPO6/ruPsuNW4s4YYkHsvRNW3704RlsAAbFp4lF1vzwlu64fOBh
	 wyR0U1Y6McWAXqux8yqCU30r9k3n3nf2isgjos9WMZrg+qYJNPT4FmwdZeIjpLP+wj
	 3z88d+9GBMxlVffYy4Dgs13U/jRVpIdAajR3+FB4f3Ay+CBsmqcD9lSn051etEgYH7
	 0QvDgv9b167bmPeDa72L4sEbCoHKT6bBWwPJfMxHfLom7jEXBvv544BL7C25TE7gjI
	 RUo5VTraRtmSzLpxvx8l/T7622rs0A0d/tGDshho8gpqjY6BkF8IXqpmUqfLKAinFe
	 zgh3KspHCzoEA==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 19 Jun 2026 15:22:22 -0400
Subject: [PATCH pynfs v3 03/26] server41tests: add a basic
 GET_DIR_DELEGATION test
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260619-dir-deleg-v3-3-1077ce8aab1b@kernel.org>
References: <20260619-dir-deleg-v3-0-1077ce8aab1b@kernel.org>
In-Reply-To: <20260619-dir-deleg-v3-0-1077ce8aab1b@kernel.org>
To: Calum Mackay <calum.mackay@oracle.com>
Cc: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>, Scott Mayhew <smayhew@redhat.com>, 
 linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5877; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=B1vu1ivcqpEpDECFzvkfHeqjMYDunsfnCWnsv8v33b0=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqNZb5ZbmpUij6ji7wVDg0UVC8L+8ni74WedQ4G
 UK/TDroKKGJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCajWW+QAKCRAADmhBGVaC
 FTZ4D/9QKM8lfHYJZ0k8lIEhxUpnCdu5JVOZYI3DaAfkZPnizqUqfooWlKvRsFsJ+5C274aWChp
 6IZhnosMKpXhXIxDMZ2FDb1eFgcLl3dlrLXW2eOPP/q4bFDdDDxlZ54bgSCBRmWcENhTT9miB51
 GISNrWwzjOXxa4fqWRnZfhTLtbmYyXG6dvluA0i/ofpFu27sHG61WxxOsBWQ/Kk5nGcyOrr3qPh
 7/yMVYN0IZ4qNnyVYGww/uBuxya5GOb1AwD953vm/8MkwJebMnQmpeHConzW9ipzyYh+rkMMPLG
 XR7tRRZfYlyea9s6XouQo0I9aOmdkIKZfkMzedEtIs4wckZKlumrNDbguymTjvlfS99eSFBsEqE
 EbwJP67YRRdb6UOkHgxG4cBfzo3A+E8MlkezZlmyDCyA/1yGPgLrf6Mm0Hi8vrvOfX3Swreo/Ot
 3A2Q7rQaDpVNR2LBGTZ4bk5aPV+fHfIMFk8d28lsk791heemTrUn5KI8pM8umrN34QWeJmqph5H
 axLXoh8FuIA4YezZXjtZ/DyhpAHo6x1rjC51jCPV9iKFS7YbjOEXCDg1tY3SXRP3C/tjcJ4mDrP
 Fd/riGGcMgCOUq5A6Sj8F8RLeIpkewUPvXR7srXacS7Iz5O4KW7dMw/ikrwB9ZDdizlJWEltIBP
 RmONg0X9jzJLnfA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22700-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B2D146A77B8

Test basic dir delegation handout, recall and return

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 nfs4.1/nfs4client.py                 |   6 ++
 nfs4.1/server41tests/__init__.py     |   1 +
 nfs4.1/server41tests/st_dir_deleg.py | 109 +++++++++++++++++++++++++++++++++++
 3 files changed, 116 insertions(+)

diff --git a/nfs4.1/nfs4client.py b/nfs4.1/nfs4client.py
index 25d7fd16f12b..dbe7af761f16 100644
--- a/nfs4.1/nfs4client.py
+++ b/nfs4.1/nfs4client.py
@@ -283,6 +283,12 @@ class NFS4Client(rpc.Client, rpc.Server):
         res = self.posthook(arg, env, res=NFS4_OK)
         return encode_status(res)
 
+    def op_cb_notify(self, arg, env):
+        log_cb.info("In CB_NOTIFY")
+        self.prehook(arg, env)
+        res = self.posthook(arg, env, res=NFS4_OK)
+        return encode_status(res)
+
     def op_cb_notify_lock(self, arg, env):
         log_cb.info("In CB_NOTIFY_LOCK")
         self.prehook(arg, env)
diff --git a/nfs4.1/server41tests/__init__.py b/nfs4.1/server41tests/__init__.py
index 156c5e3082eb..c654212c617e 100644
--- a/nfs4.1/server41tests/__init__.py
+++ b/nfs4.1/server41tests/__init__.py
@@ -28,4 +28,5 @@ __all__ = ["st_exchange_id.py", # draft 21
            "st_xattr.py",
            "st_courtesy.py",
            "st_callback.py",
+           "st_dir_deleg.py",
            ]
diff --git a/nfs4.1/server41tests/st_dir_deleg.py b/nfs4.1/server41tests/st_dir_deleg.py
new file mode 100644
index 000000000000..99768389cfa8
--- /dev/null
+++ b/nfs4.1/server41tests/st_dir_deleg.py
@@ -0,0 +1,109 @@
+from .st_create_session import create_session
+from .st_open import open_claim4
+from xdrdef.nfs4_const import *
+from xdrdef.nfs4_pack import NFS4Unpacker
+
+from .environment import check, fail, create_obj, use_obj
+from xdrdef.nfs4_type import *
+import nfs_ops
+op = nfs_ops.NFS4ops()
+import nfs4lib
+import threading
+
+zerotime = nfstime4(seconds=0, nseconds=0)
+
+def decode_notify_event(change):
+    """Decode a notify4 into its typed event structure."""
+    mask = nfs4lib.bitmap2list(change.notify_mask)
+    unpacker = NFS4Unpacker(change.notify_vals)
+    if NOTIFY4_REMOVE_ENTRY in mask:
+        return (NOTIFY4_REMOVE_ENTRY, unpacker.unpack_notify_remove4())
+    elif NOTIFY4_ADD_ENTRY in mask:
+        return (NOTIFY4_ADD_ENTRY, unpacker.unpack_notify_add4())
+    elif NOTIFY4_RENAME_ENTRY in mask:
+        return (NOTIFY4_RENAME_ENTRY, unpacker.unpack_notify_rename4())
+    elif NOTIFY4_CHANGE_DIR_ATTRS in mask:
+        return (NOTIFY4_CHANGE_DIR_ATTRS, unpacker.unpack_notify_attr4())
+    return (None, None)
+
+def bitmap4_to_int(bitmap):
+    """Convert a bitmap4 (list of uint32 words) to a single integer."""
+    result = 0
+    for i, word in enumerate(bitmap):
+        result |= word << (32 * i)
+    return result
+
+def _getDirDeleg(t, env, notify_mask, cb):
+    def recall_pre_hook(arg, env):
+        cb.stateid = arg.stateid # NOTE this must be done before set()
+        cb.cred = env.cred.raw_cred
+        cb.got_recall = True
+        env.notify = cb.set # This is called after compound sent to queue
+    def recall_post_hook(arg, env, res):
+        return res
+    def notify_pre_hook(arg, env):
+        cb.stateid = arg.cna_stateid
+        cb.fh = arg.cna_fh
+        cb.changes = arg.cna_changes
+        cb.got_notify = True
+        env.notify = cb.set # This is called after compound sent to queue
+    def notify_post_hook(arg, env, res):
+        return res
+
+    cb.got_recall = False
+    cb.got_notify = False
+
+    c = env.c1
+    sess1 = c.new_client_session(b"%s_1" % env.testname(t))
+    sess1.client.cb_pre_hook(OP_CB_RECALL, recall_pre_hook)
+    sess1.client.cb_post_hook(OP_CB_RECALL, recall_post_hook)
+    sess1.client.cb_pre_hook(OP_CB_NOTIFY, notify_pre_hook)
+    sess1.client.cb_post_hook(OP_CB_NOTIFY, notify_post_hook)
+
+    topdir = c.homedir + [t.code.encode('utf8')]
+    res = create_obj(sess1, topdir)
+    check(res)
+    fh = res.resarray[-1].object
+
+    ops = [ op.putfh(fh), op.get_dir_delegation(False,
+                                                nfs4lib.list2bitmap(notify_mask),
+                                                zerotime, zerotime,
+                                                nfs4lib.list2bitmap([]),
+                                                nfs4lib.list2bitmap([]))]
+    res = sess1.compound(ops)
+    check(res)
+    deleg = res.resarray[-1].gddrnf_resok4.gddr_stateid
+    return (sess1, fh, deleg)
+
+def testDirDelegSimple(t, env):
+    """Test basic dir delegation handout, recall and return
+
+    FLAGS: dirdeleg all
+    CODE: DIRDELEG1
+    """
+    c = env.c1
+    recall = threading.Event()
+    sess1, fh, deleg = _getDirDeleg(t, env, [], recall)
+
+    # new client -- create a file in the dir
+    sess2 = c.new_client_session(b"%s_2" % env.testname(t))
+    claim = open_claim4(CLAIM_NULL, env.testname(t))
+    owner = open_owner4(0, b"owner")
+    how = openflag4(OPEN4_CREATE, createhow4(GUARDED4, {FATTR4_SIZE:0}))
+    open_op = [ op.putfh(fh), op.open(0,
+                                      OPEN4_SHARE_ACCESS_WRITE | OPEN4_SHARE_ACCESS_WANT_NO_DELEG,
+                                      OPEN4_SHARE_DENY_NONE, owner, how, claim), op.getfh() ]
+    slot = sess2.compound_async(open_op)
+    completed = recall.wait(2)
+    env.sleep(.1)
+
+    ops = [ op.putfh(fh), op.delegreturn(deleg) ]
+    res = sess1.compound(ops)
+    check(res)
+
+    # Reap the async open and close any file it created
+    res = sess2.listen(slot)
+    if res.status == NFS4_OK:
+        open_stateid = res.resarray[-2].stateid
+        file_fh = res.resarray[-1].object
+        close_file(sess2, file_fh, stateid=open_stateid)

-- 
2.54.0


