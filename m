Return-Path: <linux-nfs+bounces-14625-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 856F4B97AB4
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Sep 2025 00:00:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FD333A943A
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Sep 2025 22:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E6811A9FA8;
	Tue, 23 Sep 2025 22:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jUAvU4p1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8363930E851
	for <linux-nfs@vger.kernel.org>; Tue, 23 Sep 2025 21:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758664801; cv=none; b=Z4x1C14E6oem68OowuStRiB0bByYpbGQlFCdLpdTLkElLVEMIw9Vqp09iaCThADXRDeIFTdlsmkE1WSyYnn/TAFIjp32qy18mz0y2uYG2FMgD7eBmXRcNCdGmf8V8dbyCY/TfQpwbnUncc/PihpzYtBMSM5+aOSj3sEcb1zu/yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758664801; c=relaxed/simple;
	bh=Ac7wX1EcJW61J7SRXvwAycy1oG96MyD89ehtvgNJ1Uo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BAUdgIyLXRv0RGVoUM8cwGigX/OWsWx7IXJwG/ciB0CWgYZul5nA9/SXJDRLaHCSS2JLG2viUmrMxdxuzhkLpasV0wBSQvZ9SLmuXU55bARN4nM//xtdgxuupv880yVkcMjxP8U9mEmktJSkDWGwaRhUW6nAwya/H8HzyLEt80c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jUAvU4p1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758664798;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nw1WGp3VYAJDx3Pq27nNqcVSSFWIplEeNMO/7R3YVUM=;
	b=jUAvU4p16qtE84aPtwBYSUJ2PTXeATLBa15hpYLlPCWuSEKIW023duVhn5YWt8B5YayDaq
	T/ymD2+vW4jDWWasMoXGsG6J3bz+UYeQ1ekrkMSnS/uJ65tDTAK/BWWo5o3Aq89f8FFtpn
	ZTzSC+LPMVX9AgXQjqwVm774ZtKIqJk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-397-8Yil5tiMMhW9IMYGHW36mA-1; Tue,
 23 Sep 2025 17:59:56 -0400
X-MC-Unique: 8Yil5tiMMhW9IMYGHW36mA-1
X-Mimecast-MFC-AGG-ID: 8Yil5tiMMhW9IMYGHW36mA_1758664796
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0C88A19560B2;
	Tue, 23 Sep 2025 21:59:56 +0000 (UTC)
Received: from aion.redhat.com (unknown [10.22.89.158])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9FDEA19560B1;
	Tue, 23 Sep 2025 21:59:55 +0000 (UTC)
Received: from aion.redhat.com (localhost [IPv6:::1])
	by aion.redhat.com (Postfix) with ESMTP id 16B1B46F6F8;
	Tue, 23 Sep 2025 17:59:54 -0400 (EDT)
From: Scott Mayhew <smayhew@redhat.com>
To: calum.mackay@oracle.com
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 4/4] 4.1 server tests: add test for CB_NOTIFY_LOCK with an expired client
Date: Tue, 23 Sep 2025 17:59:53 -0400
Message-ID: <20250923215953.165858-5-smayhew@redhat.com>
In-Reply-To: <20250923215953.165858-1-smayhew@redhat.com>
References: <20250923215953.165858-1-smayhew@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

If a client with blocked locks expires, the server can panic in
nfsd4_lm_notify().  Fixed by kernel commit 68ef3bc31664 "nfsd: remove
blocked locks on client teardown".

The test uses the serverhelper to forcibly expire the 2nd client, so you
need to use the --serverhelper and --serverhelperarg options, e.g.

nfs4.1/testserver.py SERVER:PATH --serverhelper=examples/server_helper.sh --serverhelperarg=SERVER callback

Signed-off-by: Scott Mayhew <smayhew@redhat.com>
---
 nfs4.1/server41tests/__init__.py    |   1 +
 nfs4.1/server41tests/st_callback.py | 127 ++++++++++++++++++++++++++++
 2 files changed, 128 insertions(+)
 create mode 100644 nfs4.1/server41tests/st_callback.py

diff --git a/nfs4.1/server41tests/__init__.py b/nfs4.1/server41tests/__init__.py
index 5f22378..156c5e3 100644
--- a/nfs4.1/server41tests/__init__.py
+++ b/nfs4.1/server41tests/__init__.py
@@ -27,4 +27,5 @@ __all__ = ["st_exchange_id.py", # draft 21
            "st_flex.py",
            "st_xattr.py",
            "st_courtesy.py",
+           "st_callback.py",
            ]
diff --git a/nfs4.1/server41tests/st_callback.py b/nfs4.1/server41tests/st_callback.py
new file mode 100644
index 0000000..1a0648b
--- /dev/null
+++ b/nfs4.1/server41tests/st_callback.py
@@ -0,0 +1,127 @@
+from .environment import check, fail, create_file, open_file, close_file
+from .environment import open_create_file_op
+from xdrdef.nfs4_const import *
+from xdrdef.nfs4_type import locker4, lock_owner4
+from xdrdef.nfs4_type import open_to_lock_owner4
+import nfs_ops
+op = nfs_ops.NFS4ops()
+import threading
+import logging
+log = logging.getLogger("test.env")
+
+def testCbNotifyLockExpiredClient(t, env):
+    """Tests CB_NOTIFY_LOCK with an expired client
+
+    FLAGS: callback
+    CODE: CALLBACK1
+    """
+    cb = threading.Event()
+    def pre_hook(arg, env):
+        log.info("inside pre_hook")
+        cb.set()
+    def post_hook(arg, env, res):
+        log.info("inside post_hook")
+        return res
+
+    # create the first client
+    c1 = env.c1.new_client(b"%s_1" % env.testname(t))
+    sess1 = c1.create_session()
+    res = sess1.compound([op.reclaim_complete(FALSE)])
+    check(res)
+
+    # create the test file and obtain write lock
+    res = create_file(sess1, env.testname(t))
+    check(res)
+    fh1 = res.resarray[-1].object
+    stateid1 = res.resarray[-2].stateid
+    open_to_lock_owner = open_to_lock_owner4(0, stateid1, 0, lock_owner4(0, b"lock1"))
+    locker = locker4(open_owner=open_to_lock_owner, new_lock_owner=True)
+    lock_op = op.lock(WRITE_LT, False, 0, NFS4_UINT64_MAX, locker)
+    res = sess1.compound([op.putfh(fh1), lock_op])
+    check(res, NFS4_OK)
+
+    # create the second client
+    c2 = env.c1.new_client(b"%s_2" % env.testname(t))
+    sess2 = c2.create_session()
+    sess2.client.cb_pre_hook(OP_CB_NOTIFY_LOCK, pre_hook)
+    sess2.client.cb_post_hook(OP_CB_NOTIFY_LOCK, post_hook)
+    res = sess2.compound([op.reclaim_complete(FALSE)])
+    check(res)
+
+    # open the test file and attempt to obtain a read lock
+    res = open_file(sess2, env.testname(t))
+    check(res)
+    fh2 = res.resarray[-1].object
+    stateid2 = res.resarray[-2].stateid
+    open_to_lock_owner = open_to_lock_owner4(0, stateid2, 0, lock_owner4(0, b"lock2"))
+    locker = locker4(open_owner=open_to_lock_owner, new_lock_owner=True)
+    lock_op = op.lock(READW_LT, False, 0, NFS4_UINT64_MAX, locker)
+    res = sess2.compound([op.putfh(fh2), lock_op])
+    check(res, NFS4ERR_DENIED)
+
+    # keep the first client active, allow the second client to expire
+    for i in range(3):
+        env.sleep(60)
+        res = sess1.compound([])
+        check(res, NFS4_OK)
+
+    # a courteous server may have kept the client around anyway - forcibly expire it
+    env.serverhelper(b"expire %s_2" % env.testname(t))
+
+    # close the file on the first client and see if the second client
+    # gets a CB_NOTIFY_LOCK (it shouldn't!)
+    res = close_file(sess1, fh1, stateid=stateid1)
+    check(res)
+
+    cb.wait(10)
+    if cb.is_set():
+        log.warning("Got CB_NOTIFY_LOCK on an expired client!")
+        cb.clear()
+
+    res = close_file(sess2, fh2, stateid=stateid2)
+    check(res, NFS4ERR_BADSESSION)
+
+    # open and write lock the test file again on the first client
+    res = open_file(sess1, env.testname(t), access=OPEN4_SHARE_ACCESS_BOTH)
+    check(res)
+    fh1 = res.resarray[-1].object
+    stateid1 = res.resarray[-2].stateid
+    open_to_lock_owner = open_to_lock_owner4(0, stateid1, 0, lock_owner4(0, b"lock1"))
+    locker = locker4(open_owner=open_to_lock_owner, new_lock_owner=True)
+    lock_op = op.lock(WRITE_LT, False, 0, NFS4_UINT64_MAX, locker)
+    res = sess1.compound([op.putfh(fh1), lock_op])
+    check(res, NFS4_OK)
+
+    # set up the second client again
+    c2 = env.c1.new_client(b"%s_2" % env.testname(t))
+    sess2 = c2.create_session()
+    sess2.client.cb_pre_hook(OP_CB_NOTIFY_LOCK, pre_hook)
+    sess2.client.cb_post_hook(OP_CB_NOTIFY_LOCK, post_hook)
+    res = sess2.compound([op.reclaim_complete(FALSE)])
+    check(res, [NFS4_OK, NFS4ERR_COMPLETE_ALREADY])
+
+    # open the test file again on the second client and attempt to obtain a read lock
+    res = open_file(sess2, env.testname(t))
+    check(res)
+    fh2 = res.resarray[-1].object
+    stateid2 = res.resarray[-2].stateid
+    open_to_lock_owner = open_to_lock_owner4(0, stateid2, 0, lock_owner4(0, b"lock2"))
+    locker = locker4(open_owner=open_to_lock_owner, new_lock_owner=True)
+    lock_op = op.lock(READW_LT, False, 0, NFS4_UINT64_MAX, locker)
+    res = sess2.compound([op.putfh(fh2), lock_op])
+    check(res, NFS4ERR_DENIED)
+
+    # close the file on the first client and see if the second client
+    # gets a CB_NOTIFY_LOCK.  If it does, try to obtain the lock.
+    res = close_file(sess1, fh1, stateid=stateid1)
+    check(res)
+
+    cb.wait(10)
+    if cb.is_set():
+        res = sess2.compound([op.putfh(fh2), lock_op])
+        check(res)
+    else:
+        fail("Did not receive CB_NOTIFY_LOCK")
+
+    res = close_file(sess2, fh2, stateid=stateid2)
+    check(res)
-- 
2.51.0


