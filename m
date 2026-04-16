Return-Path: <linux-nfs+bounces-20905-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MIsYLM0n4Wl0pwAAu9opvQ
	(envelope-from <linux-nfs+bounces-20905-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 20:17:49 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 304E3413A79
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 20:17:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7829B30D75CA
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 18:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 476CA330B0B;
	Thu, 16 Apr 2026 18:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X0UH1HTd"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2489A3346A8
	for <linux-nfs@vger.kernel.org>; Thu, 16 Apr 2026 18:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776363302; cv=none; b=NgDhnVX/1uKRC2D1qPJzQkDjRjUZ90Z4o5wXAmL7EUbo2O7AZuTGpcsAWYGxAkF9ErDlvAkBfVCtpaof+zRtAJJvEO98+V22ZXVuEzWaGapq7A2sC1+avcoKBkB7NW6yK02klWFd7pKqX63FZ4sQEoGbtE8UT2LRpjedqO0X6cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776363302; c=relaxed/simple;
	bh=6o7RRJcNWS8rP+m/KgO33hWlQ8U+QMiH+Dj8a0hqTeE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U8F1c8JBzrOi5kyxLygTXX+d/ZAIofe1MW1kI5hL+3s3AOb1zpT5BYMooJnVCjDfwa2smM+PhS3x+ey9jjYtEFeyNLKu3WZQzkpr18e19USlVJ4fW9FbB4YzVadqKNFATOjZB+9p7px6NqzMwiQ1taaz3Ep/CLJ+NS+Up20Pgqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X0UH1HTd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97715C2BCB9;
	Thu, 16 Apr 2026 18:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776363301;
	bh=6o7RRJcNWS8rP+m/KgO33hWlQ8U+QMiH+Dj8a0hqTeE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=X0UH1HTdpzuePJlPJv+s+ikhhUWGEpZFvoWHyWNwbMWAxZflpDircF52P7973Wwds
	 MMZhu8V2pXgHwMVHpF684HqE3uq8ZVvSyH7SCwPfUFBaD/jdXeCS/8MiBJrW03K0So
	 cvETtdZISpl4PrR4zVdyeq3aK9Vjsd6HK/IND6l6VmNpZMT9hHhWATX1Vf/Y+9PUNI
	 yMxiYbV01RoutuwZZREe/ZVi3U+g+oeAlbgmNTatuLvjuZkjlfseAfl2hzXpLvscA5
	 PKc5EsrXkzt8Zpk3GJzbmzkJgMYk5TMpo8OCZ01cLsXi4DtwKPCQJZvCDaXDPEwfTF
	 N+yzBVjK6XIDA==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 16 Apr 2026 11:14:35 -0700
Subject: [PATCH pynfs v2 03/25] server41tests: add a basic
 GET_DIR_DELEGATION test
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260416-dir-deleg-v2-3-fad510db5941@kernel.org>
References: <20260416-dir-deleg-v2-0-fad510db5941@kernel.org>
In-Reply-To: <20260416-dir-deleg-v2-0-fad510db5941@kernel.org>
To: Calum Mackay <calum.mackay@oracle.com>
Cc: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5589; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=6o7RRJcNWS8rP+m/KgO33hWlQ8U+QMiH+Dj8a0hqTeE=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBp4ScfjjHf7pOFN31ocz2tm7Rb66Nqv5mXrTVsR
 zoGNezA6X+JAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaeEnHwAKCRAADmhBGVaC
 FbQ+EACTXbXf+GAoy0HWuMtufIX72Bf/VIqtZkHnttfMF3VDkNLoQ8vrKk8g+KkpWGDejR9pZH6
 nQ4RoBHgFHXyGtP3YouCNM/z5cIsjUt9lQJvbm86u33T2PQBW10a1ruA94QSs31nbVdlB2zBUin
 ehnCvz8/KwBjsnGKluDQXAQXz24mpQJfiCUtPBHJByDD1+L5Ua+08qgKlnzQ9D/AD76h+vmlnvx
 8DeO3SwANvt0ZzoW8lArahqRc8qBgygSBWqwquxeJer41ZPcGGmGZKX8p+angm+ywyPm3gMyLzn
 f866wJb1Z7Zt/2C0FFpWQjW6/ikEyXU1+a/KJx2DO556xpQoKjCnk7uLil6SrezOE5eBHoeslpN
 VNCBKLSupuvmi0MfnAtZ75VzVthWgFIsJTz5NqbC1dRgSArcCdsEcnwJ2+UMxqTf2bRAtbngLv8
 8mjfBzf7uyHWKlFz834xYQ86L20kbX9OK+PdmqiXJIsdsNB0NxOZ2Xv7jYmwMztaETNigkiURck
 Is/uGRRMcRLrv1RLlaFeudLMBVd3gvNSxEA73mcgHg4o+OonanIlqTpJioat0mkoqsDgol5vslO
 MOhB6O/DcObG08CS9hicCi8i7931P2Nrd+NsJtKfRMvs2Gv8unyCZENRL4pasrWep4M5Qk5nCsQ
 qLxv3Z58JkHvhKw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20905-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 304E3413A79
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Test basic dir delegation handout, recall and return

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 nfs4.1/nfs4client.py                 |   6 +++
 nfs4.1/server41tests/__init__.py     |   1 +
 nfs4.1/server41tests/st_dir_deleg.py | 102 +++++++++++++++++++++++++++++++++++
 3 files changed, 109 insertions(+)

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
index 000000000000..ab4387f0bd9b
--- /dev/null
+++ b/nfs4.1/server41tests/st_dir_deleg.py
@@ -0,0 +1,102 @@
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
+                                      OPEN4_SHARE_DENY_NONE, owner, how, claim) ]
+    slot = sess2.compound_async(open_op)
+    completed = recall.wait(2)
+    env.sleep(.1)
+
+    ops = [ op.putfh(fh), op.delegreturn(deleg) ]
+    res = sess1.compound(ops)
+    check(res)

-- 
2.53.0


