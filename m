Return-Path: <linux-nfs+bounces-20646-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mN0JNdRb0GkA7AYAu9opvQ
	(envelope-from <linux-nfs+bounces-20646-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 04 Apr 2026 02:31:16 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F9A0399577
	for <lists+linux-nfs@lfdr.de>; Sat, 04 Apr 2026 02:31:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1F34E302D5EC
	for <lists+linux-nfs@lfdr.de>; Sat,  4 Apr 2026 00:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BE8E23C503;
	Sat,  4 Apr 2026 00:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WMSD3mTH"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF3C246768
	for <linux-nfs@vger.kernel.org>; Sat,  4 Apr 2026 00:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775262660; cv=none; b=uc6/yFPDCvumHMZRSgCcbGpkYoHQciC5QaoTpQNmyCZQnsZSxTZ48esPeo/uQN19d5RM+M0UCEj8iaakhRjp24f5NNUPbX+7RfdeAmFXUx/quL4SucJvGCa4BY7hnf1g2MFxG6b4hoAU7100ockOjbQ8PTiTlrkihy64PQDoGZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775262660; c=relaxed/simple;
	bh=lWs5kuRi+JfN6L88o1udakpnxS/vYsqBgsVTqZPMQB0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IP356Kakd1yITze+yv6xQvYRu9eCmlPck6PdhNJWu/AVr3zrg4rA7c7n80MU+ZQxTGK6eA2jNqXbJzhaOKUkXAiURPwiUGU7A9+xjNmNCNxeU9XPhD3IVy+AjgriPui5tbNWoq+26O9UPU6dK0jMxmYQQ8vxqAHY52yBIcBqED0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WMSD3mTH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775262658;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jDnGOZYE4StwahqPbHAm0OXOR/TQ+qFyVldZXO0hbVg=;
	b=WMSD3mTHkAVp985axHkXSLOFj4E+vI90nZjQ2Kc71s55ARxsXQsUTfQ65tcBX6TBAyhQLC
	JmbMqmnRkCAZIwtdoO1i1Ji7AzKoQmatYS46FczvDIhugqRSewlVtgld82Jo/EaFdfcHGt
	uww9a+qhCnr0NKrpi7nQNMGgIbNM9jw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-132-c0RczPWvMK2qewy23ZjOzw-1; Fri,
 03 Apr 2026 20:30:54 -0400
X-MC-Unique: c0RczPWvMK2qewy23ZjOzw-1
X-Mimecast-MFC-AGG-ID: c0RczPWvMK2qewy23ZjOzw_1775262653
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B67301956089;
	Sat,  4 Apr 2026 00:30:53 +0000 (UTC)
Received: from aion.redhat.com (unknown [10.22.88.38])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6845F180035F;
	Sat,  4 Apr 2026 00:30:53 +0000 (UTC)
Received: from aion.redhat.com (localhost [IPv6:::1])
	by aion.redhat.com (Postfix) with ESMTP id 1F8E4749EB0;
	Fri, 03 Apr 2026 20:30:51 -0400 (EDT)
From: Scott Mayhew <smayhew@redhat.com>
To: calum.mackay@oracle.com
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v2] pynfs: add delegation test for CB_GETATTR after sync WRITE
Date: Fri,  3 Apr 2026 20:30:50 -0400
Message-ID: <20260404003050.1560149-6-smayhew@redhat.com>
In-Reply-To: <20260404003050.1560149-1-smayhew@redhat.com>
References: <20260404003050.1560149-1-smayhew@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20646-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[smayhew@redhat.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 7F9A0399577
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

DELEG27 tests the scenario where a client has written data to the server
while holding a write delegation, but is not *currently* holding
modified data in its cache.

In this case, the CB_GETATTR should not trigger an mtime update (the
time_modify that client1 gets in the GETATTR after the WRITE should
match the time_modify it gets in the GETATTR in the DELEGRETURN
compound).

Signed-off-by: Scott Mayhew <smayhew@redhat.com>
---
 nfs4.1/server41tests/st_delegation.py | 151 ++++++++++++++++++++++++++
 1 file changed, 151 insertions(+)

diff --git a/nfs4.1/server41tests/st_delegation.py b/nfs4.1/server41tests/st_delegation.py
index bbf6925..6a08950 100644
--- a/nfs4.1/server41tests/st_delegation.py
+++ b/nfs4.1/server41tests/st_delegation.py
@@ -8,6 +8,8 @@ import nfs_ops
 op = nfs_ops.NFS4ops()
 import nfs4lib
 import threading
+import copy
+import time
 
 def _got_deleg(deleg):
     return (deleg.delegation_type != OPEN_DELEGATE_NONE and
@@ -476,3 +478,152 @@ def testDelegReadAfterClose(t, env):
     # cleanup: return delegation
     res = sess1.compound([op.putfh(fh), op.delegreturn(delegstateid)])
     check(res)
+
+def testCbGetattrAfterSyncWrite(t, env):
+    """Test CB_GETATTR after a FILE_SYNC4 WRITE
+
+    1. Client 1 opens a file (getting a write deleg or a write attrs deleg) and
+       does a GETATTR
+    2. Client 1 does a FILE_SYNC4 WRITE.  If we got a write delegation, it
+       follows this up with a GETATTR.  Otherwise we got a write attrs deleg
+       and we construct the attrs ourself.
+    3. Client 2 does a GETATTR, triggering a CB_GETATTR to client 1.  Client 2
+       then does an OPEN, triggering a CB_RECALL to client 1.
+    4. Client 1 does a PUTFH|SETATTR|GETATTR|DELEGRETURN if we have a write
+       attrs deleg, otherwise it does a PUTFH|GETATTR|DELEGRETURN.
+
+    time_modify should only change between steps 1 and 2.  It should not change
+    from steps 2 thru 4.
+
+    FLAGS: deleg all
+    CODE: DELEG27
+    """
+    cb = threading.Event()
+    cbattrs = {}
+    def getattr_post_hook(arg, env, res):
+        res.obj_attributes = cbattrs
+        env.notify = cb.set
+        return res
+
+    recall = threading.Event()
+    def recall_pre_hook(arg, env):
+        recall.stateid = arg.stateid
+        recall.cred = env.cred.raw_cred
+        env.notify = recall.set
+    def recall_post_hook(arg, env, res):
+        return res
+
+    size = 5
+
+    sess1 = env.c1.new_client_session(b"%s_1" % env.testname(t))
+    sess1.client.cb_post_hook(OP_CB_GETATTR, getattr_post_hook)
+    sess1.client.cb_pre_hook(OP_CB_RECALL, recall_pre_hook)
+    sess1.client.cb_post_hook(OP_CB_RECALL, recall_post_hook)
+
+    res = sess1.compound([op.putrootfh(),
+                          op.getattr(nfs4lib.list2bitmap([FATTR4_SUPPORTED_ATTRS,
+                                                          FATTR4_OPEN_ARGUMENTS]))])
+    check(res)
+    caps = res.resarray[-1].obj_attributes
+
+    openmask = (OPEN4_SHARE_ACCESS_READ  |
+                OPEN4_SHARE_ACCESS_WRITE |
+                OPEN4_SHARE_ACCESS_WANT_WRITE_DELEG)
+
+    if caps[FATTR4_SUPPORTED_ATTRS] & (1 << FATTR4_OPEN_ARGUMENTS):
+        if caps[FATTR4_OPEN_ARGUMENTS].oa_share_access_want & OPEN_ARGS_SHARE_ACCESS_WANT_DELEG_TIMESTAMPS:
+            openmask |= 1<<OPEN_ARGS_SHARE_ACCESS_WANT_DELEG_TIMESTAMPS
+
+    fh, stateid, deleg = __create_file_with_deleg(sess1, env.testname(t), openmask)
+    delegtype = deleg.delegation_type
+    if delegtype != OPEN_DELEGATE_WRITE_ATTRS_DELEG and delegtype != OPEN_DELEGATE_WRITE:
+        fail("Didn't get a write delegation.")
+    delegstateid = deleg.write.stateid
+
+    attrs1 = do_getattrdict(sess1, fh, [FATTR4_CHANGE, FATTR4_SIZE,
+                                        FATTR4_TIME_ACCESS, FATTR4_TIME_MODIFY])
+
+    cbattrs[FATTR4_CHANGE] = attrs1[FATTR4_CHANGE]
+    cbattrs[FATTR4_SIZE] = attrs1[FATTR4_SIZE]
+
+    env.sleep(1)
+    res = write_file(sess1, fh, b'z' * size, 0, delegstateid)
+    check(res)
+
+    if delegtype == OPEN_DELEGATE_WRITE_ATTRS_DELEG:
+        attrs2 = copy.deepcopy(attrs1)
+        now = divmod(time.time_ns(), 1000000000)
+        attrs2[FATTR4_TIME_ACCESS] = nfstime4(*now)
+        attrs2[FATTR4_TIME_MODIFY] = nfstime4(*now)
+        cbattrs[FATTR4_TIME_DELEG_ACCESS] = nfstime4(*now)
+        cbattrs[FATTR4_TIME_DELEG_MODIFY] = nfstime4(*now)
+    else:
+        attrs2 = do_getattrdict(sess1, fh, [FATTR4_CHANGE, FATTR4_SIZE,
+                                            FATTR4_TIME_ACCESS, FATTR4_TIME_MODIFY])
+
+    # No need to bump FATTR4_CHANGE because we've already flushed our data
+    cbattrs[FATTR4_SIZE] = size
+
+    sess2 = env.c1.new_client_session(b"%s_2" % env.testname(t))
+    slot = sess2.compound_async([op.putfh(fh),
+                                 op.getattr(1<<FATTR4_CHANGE |
+                                            1<<FATTR4_SIZE |
+                                            1<<FATTR4_TIME_ACCESS |
+                                            1<<FATTR4_TIME_MODIFY)])
+
+    completed = cb.wait(2)
+    if not completed:
+        fail("CB_GETATTR not received")
+
+    res = sess2.listen(slot)
+    check(res)
+    attrs3 = res.resarray[-1].obj_attributes
+
+    claim = open_claim4(CLAIM_NULL, env.testname(t))
+    owner = open_owner4(0, b"owner")
+    how = openflag4(OPEN4_NOCREATE)
+    open_op = op.open(0, OPEN4_SHARE_ACCESS_WRITE,
+                      OPEN4_SHARE_DENY_NONE, owner, how, claim)
+    slot = sess2.compound_async(env.home + [open_op, op.getfh()])
+    completed = recall.wait(2)
+    if not completed:
+        fail("CB_RECALL not received")
+
+    env.sleep(.1)
+
+    # Note if we have a write attrs deleg we should do a setattr before the
+    # delegreturn (see RFC 9754, section 5)
+    res = sess1.compound([op.putfh(fh),
+                          *([op.setattr(delegstateid,
+                                        {FATTR4_TIME_DELEG_ACCESS: cbattrs[FATTR4_TIME_DELEG_ACCESS],
+                                         FATTR4_TIME_DELEG_MODIFY: cbattrs[FATTR4_TIME_DELEG_MODIFY]})]
+                              if delegtype == OPEN_DELEGATE_WRITE_ATTRS_DELEG else []),
+                          op.getattr(1<<FATTR4_CHANGE |
+                                     1<<FATTR4_SIZE |
+                                     1<<FATTR4_TIME_ACCESS |
+                                     1<<FATTR4_TIME_MODIFY),
+                          op.delegreturn(delegstateid)])
+    check(res)
+    attrs4 = res.resarray[-2].obj_attributes
+
+    res = sess2.listen(slot)
+    check(res, [NFS4_OK, NFS4ERR_DELAY])
+    if res.status == NFS4_OK:
+        fh2 = res.resarray[-1].object
+        stateid2 = res.resarray[-2].stateid
+    else:
+        fh2 = None
+        stateid2 = None
+
+    close_file(sess1, fh, stateid=stateid)
+    if fh2 is not None and stateid2 is not None:
+        close_file(sess2, fh2, stateid=stateid2)
+
+    #print(f"attrs1: size {attrs1[FATTR4_SIZE]} change {attrs1[FATTR4_CHANGE]} mtime {attrs1[FATTR4_TIME_MODIFY]}")
+    #print(f"attrs2: size {attrs2[FATTR4_SIZE]} change {attrs2[FATTR4_CHANGE]} mtime {attrs2[FATTR4_TIME_MODIFY]}")
+    #print(f"attrs3: size {attrs3[FATTR4_SIZE]} change {attrs3[FATTR4_CHANGE]} mtime {attrs3[FATTR4_TIME_MODIFY]}")
+    #print(f"attrs4: size {attrs4[FATTR4_SIZE]} change {attrs4[FATTR4_CHANGE]} mtime {attrs4[FATTR4_TIME_MODIFY]}")
+
+    if compareTimes(attrs2[FATTR4_TIME_MODIFY], attrs4[FATTR4_TIME_MODIFY]) != 0:
+        fail(f"mtime after write ({attrs2[FATTR4_TIME_MODIFY]}) != "
+             f"mtime from delegreturn ({attrs4[FATTR4_TIME_MODIFY]})")
-- 
2.53.0


