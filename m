Return-Path: <linux-nfs+bounces-14802-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7352ABACB5A
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Sep 2025 13:37:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB6C43A5BC4
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Sep 2025 11:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE4C260569;
	Tue, 30 Sep 2025 11:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QSkycYe+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6F025FA2C
	for <linux-nfs@vger.kernel.org>; Tue, 30 Sep 2025 11:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759232266; cv=none; b=bHamb+r7/klT4dIfWXWDl5tvwT89FRaJsxL+Qt3hJu93h9H3Pvb6bqArHGvyz9ls/jzHp4zJDbUHmb3/+GJySTtsb6cx6KBqufiM0Cw/Sj5RkvmaA9YJNDr0IrqQa8cRdAZp+cwqjno2+1ineAk/S1Y0ujXcYbumLm7M+lJRaX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759232266; c=relaxed/simple;
	bh=X1vhA6icCq+vNkH9HBRMVyOs1bICNTaKV0UTog0o87w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MZ4N+61ilTCJZ9H7ivRIfOXFvQVNW4xyzq4i8xagKuHAyPyw7quPXSIcc5TzMeBiZ/zUz8DBP3iGI0ERh4FFYw6H3W/zRowzyGXTp8uUHIm7qxbUqtLL8lHOtnXJ4HJsmULJmqU4oVsoVeMfuKQlpMMcqbNKrvzkT7SqenNDRus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QSkycYe+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83180C116C6;
	Tue, 30 Sep 2025 11:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759232265;
	bh=X1vhA6icCq+vNkH9HBRMVyOs1bICNTaKV0UTog0o87w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=QSkycYe+KaUlQx4R1sSi3u5L3PyHUoshcjM0iC7tFC9/rf3N/vfc0Oerwarh+nt9R
	 NvxMfBXFKS7vF7eHmdBbSN5NpVVrjY5rdfZKz3RphwkHJ3b5TPQmd3q8IJnrwVOEXb
	 z+5mLLc5Bg6JLGwZg886GFl2f1mXkUJe+xFPx7/0NOY991eNLLw71RkSDD4RKn1Rk6
	 UuQaVCKV7QwVa0F6p7ICOyqHQfimIVjUmZPrHma6y3kFE9irJdTehT7emHkCJk2i4n
	 7Wbkqpp4VCkUwZmr5hJvgWrz1CUZ9JP9cjRKrI3Uq8Rcp968JC8jGKVFL2ExRQr9ah
	 WrsYH1BBR5NYQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 30 Sep 2025 07:37:37 -0400
Subject: [PATCH pynfs 3/7] server41tests: add a basic GET_DIR_DELEGATION
 test
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250930-dir-deleg-v1-3-7057260cd0c6@kernel.org>
References: <20250930-dir-deleg-v1-0-7057260cd0c6@kernel.org>
In-Reply-To: <20250930-dir-deleg-v1-0-7057260cd0c6@kernel.org>
To: Calum Mackay <calum.mackay@oracle.com>
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4781; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=X1vhA6icCq+vNkH9HBRMVyOs1bICNTaKV0UTog0o87w=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBo28EG7zkdjWWERtxJohhs9s7aJYDZquZfk6Wb4
 J8vJhLn+c2JAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaNvBBgAKCRAADmhBGVaC
 FTOWEACnzJy7+mCzMSI5R+yzWyyTTSpwTnHb7cEXKoqUrBA0Z4fik/kQnSMk3V/hwZ6/0HO8nBA
 B4kXNlbl+PzGiDZ2ecFsfcIo6R7hn2rfrP17v1JUKtN9GvgW+LBXau8VZ1HICdlsZhESVql5ZOO
 nwxAwiuaZ6L3FR9zfVnfgbUp0INrx3xpIvZ8s2mvyzTR1qiAHpiWO7hUTJRw5rKGDYx2bcfy7Qs
 bDom0f5OF7mXZIyFQ+Dvqj0mHOlJ6d8ExS7BuqrXNLEb8pMi54jQmIss0x/Ax1mnVsvGv2r7Evd
 8gb4/a76guabrZGCnkLXHmvIgJXMZgfq7aDBGi5IQviGeTGzmJsV88L+J0CfCgFV/qvvI5KOhhE
 9yepAqV7aC5xHLLxz7h3ADBPHhFAZt9l7NZLeNL0ghUORGTG5NEPQ5qeea30YHNK00/58Il1HyY
 3onlKWAVD3PzvPCvG7wxAx7XmQkCzUBJ9qyuSG/VqRqsiXUGoDFej+qMw4zpxG2ey9vrckk1CcE
 0HXL4pDwlz4cdp75XV+NaehN/Gcn0H4Aq3xpF3YbINKtIszKRNFTRqOclQtYeTch5Q923yVNkZT
 +0+Jj5VuWgibzikaFoW1naxea1xTaqDJq25tXjQLliX0k4SP4HmNS1S4EF/YbhBCFziTFQXs0oi
 cTZ/b8SBH7JWgYg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 nfs4.1/nfs4client.py                 |  6 +++
 nfs4.1/server41tests/__init__.py     |  1 +
 nfs4.1/server41tests/st_dir_deleg.py | 77 ++++++++++++++++++++++++++++++++++++
 3 files changed, 84 insertions(+)

diff --git a/nfs4.1/nfs4client.py b/nfs4.1/nfs4client.py
index f4fabcc11be1328f47d6d738f78586b3e8541296..4650c052c118f1ceab30b6961aef885a910b96d5 100644
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
     def op_cb_layoutrecall(self, arg, env):
         log_cb.info("In CB_LAYOUTRECALL")
         self.prehook(arg, env)
diff --git a/nfs4.1/server41tests/__init__.py b/nfs4.1/server41tests/__init__.py
index 5f223788147816079de4e2b0e9638ae90aa6d908..1422b131b1b4778f1d0bba1a44a5ec51a6ebadcd 100644
--- a/nfs4.1/server41tests/__init__.py
+++ b/nfs4.1/server41tests/__init__.py
@@ -11,6 +11,7 @@ __all__ = ["st_exchange_id.py", # draft 21
            "st_trunking.py",
            "st_open.py",
            "st_delegation.py",
+           "st_dir_deleg.py",
            "st_verify.py",
            "st_getdevicelist.py",
            "st_lookupp.py",
diff --git a/nfs4.1/server41tests/st_dir_deleg.py b/nfs4.1/server41tests/st_dir_deleg.py
new file mode 100644
index 0000000000000000000000000000000000000000..d63a16e06edd4515033ad81986cf1e84871ee7ad
--- /dev/null
+++ b/nfs4.1/server41tests/st_dir_deleg.py
@@ -0,0 +1,77 @@
+from .st_create_session import create_session
+from .st_open import open_claim4
+from xdrdef.nfs4_const import *
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
+        cb.got_notify = True
+        env.notify = cb.set # This is called after compound sent to queue
+    def notify_post_hook(arg, env, res):
+        return res
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
+    notify_mask.append(NOTIFY4_GFLAG_EXTEND)
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
2.51.0


