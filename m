Return-Path: <linux-nfs+bounces-20625-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0DY0OFrAz2ky0QYAu9opvQ
	(envelope-from <linux-nfs+bounces-20625-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 03 Apr 2026 15:27:54 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D57543946F3
	for <lists+linux-nfs@lfdr.de>; Fri, 03 Apr 2026 15:27:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B8E6D30116A5
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Apr 2026 13:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 337CB3B8922;
	Fri,  3 Apr 2026 13:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E1pGaOQS"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431B63B777D
	for <linux-nfs@vger.kernel.org>; Fri,  3 Apr 2026 13:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775222868; cv=none; b=SkzLxARjX+GRUIc1AIoCoGqVOcUVc/qi4W9k/AI5Plu8o6SEf6uW7MjeifCPst8hrVSmXo1+nFOfNfniNEUMrhFDf4PKUtd7uzE0gdwilev6h0MinmjhiTYjKEpnreWmY6sfslDPpbtOVSS508aURzvVdAt+aggrNnzSTEBCvO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775222868; c=relaxed/simple;
	bh=Za0E+SVPrZ6Eo+V80CJQ8fFA7ka2RCCw0GfftXFY8+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k+9hudgaY6ik4u064jNKiz79ToumYIS1WiE0/TE6KOsLoEHHOdQT0ADVEw4e9M241nnAzt5MObsp+DiSrBMrGagGi4yOqiT1iBs9zU80q5ptWY3F4S0IYDAQvauNQH1I+hAtJzyv/ZsSBnuGXCIe4j9B+pWGvnyf80E8fM1xlKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E1pGaOQS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775222865;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DDdRNXMOoMQ6gb3iletDvmbl8i3dep8C4711GexKESQ=;
	b=E1pGaOQSs8B20ulXwyo8XmzyS/KFuYYSLsDAHkqiujmR1IMDB3CfDXIhIu19gxdauPnYnT
	YBw0hghZF6Kb2n2LFFB/shmNSO3mAuKPs+q45VM17/g+AfYX0F5D2Mgqu2OLrB/5n5r7K/
	xoH0/7FmURnl1B61HgRbWsak7/TJJu0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-608-qDTTNK8gNumPZeuFff48TQ-1; Fri,
 03 Apr 2026 09:27:44 -0400
X-MC-Unique: qDTTNK8gNumPZeuFff48TQ-1
X-Mimecast-MFC-AGG-ID: qDTTNK8gNumPZeuFff48TQ_1775222863
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7D4701964CFE;
	Fri,  3 Apr 2026 13:27:39 +0000 (UTC)
Received: from aion.redhat.com (unknown [10.22.88.38])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3E0C21800997;
	Fri,  3 Apr 2026 13:27:39 +0000 (UTC)
Received: from aion.redhat.com (localhost [IPv6:::1])
	by aion.redhat.com (Postfix) with ESMTP id 2B7A2749DEC;
	Fri, 03 Apr 2026 09:27:38 -0400 (EDT)
From: Scott Mayhew <smayhew@redhat.com>
To: calum.mackay@oracle.com
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 1/5] pynfs: ensure tests clean up after themselves
Date: Fri,  3 Apr 2026 09:27:34 -0400
Message-ID: <20260403132738.1482011-2-smayhew@redhat.com>
In-Reply-To: <20260403132738.1482011-1-smayhew@redhat.com>
References: <20260403132738.1482011-1-smayhew@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20625-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FROM_NEQ_ENVFROM(0.00)[smayhew@redhat.com,linux-nfs@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: D57543946F3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

I noticed my server was taking longer to exit grace on restart after
running pynfs.  The server was waiting for several clients (which have
already gone away) to finish reclaim.  You can observe the client ids
using 'nfsdclddb print' while the server is in grace (or prior to
reboot):

$ sudo nfsdclddb print
Schema version: 4 current epoch: 47 recovery epoch: 46
Clients in current epoch:
Clients in recovery epoch:
id = COUR2_1774823970_2, princhash = (null)
id = ALLOC1_1774823970, princhash = (null)
id = ALLOC2_1774823970, princhash = (null)
id = ALLOC3_1774823970, princhash = (null)
id = DELEG9_1774823970_1, princhash = (null)
id = DELEG9_1774823970_2, princhash = (null)
id = DELEG2_1774823970_1, princhash = (null)
id = DELEG23_1774823970_1, princhash = (null)
id = DELEG1_1774823970_1, princhash = (null)
id = DELEG4_1774823970_1, princhash = (null)
id = DELEG8_1774823970_1, princhash = (null)
id = DELEG8_1774823970_2, princhash = (null)
id = DELEG25_1774823970_1, princhash = (null)
id = DELEG24_1774823970_1, princhash = (null)
id = DELEG6_1774823970_1, princhash = (null)
id = DELEG7_1774823970_1, princhash = (null)
id = DELEG5_1774823970_1, princhash = (null)
id = DELEG3_1774823970_1, princhash = (null)

These tests were all failing to close some of their open files, causing
DESTROY_CLIENTID at the end of the test to return NFS4ERR_CLIENTID_BUSY.

On older servers these client ids would stick around for 1 lease period.
With the newer courteous server they may stick around indefinitely, so
it's important for the tests to clean up after themselves.

Signed-off-by: Scott Mayhew <smayhew@redhat.com>
---
 nfs4.1/server41tests/st_courtesy.py   |  2 +
 nfs4.1/server41tests/st_delegation.py | 59 +++++++++++++++++++++------
 nfs4.1/server41tests/st_sparse.py     | 10 ++++-
 3 files changed, 58 insertions(+), 13 deletions(-)

diff --git a/nfs4.1/server41tests/st_courtesy.py b/nfs4.1/server41tests/st_courtesy.py
index 54cf17d..60089c9 100644
--- a/nfs4.1/server41tests/st_courtesy.py
+++ b/nfs4.1/server41tests/st_courtesy.py
@@ -84,6 +84,8 @@ def testLockSleepLock(t, env):
     res = sess2.compound(cour_lockargs(fh, stateid))
     check(res, NFS4_OK)
 
+    close_file(sess2, fh, stateid=stateid)
+
 def testShareReservation00(t, env):
     """Test OPEN file with OPEN4_SHARE_DENY_WRITE
        1st client opens file with OPEN4_SHARE_DENY_WRITE
diff --git a/nfs4.1/server41tests/st_delegation.py b/nfs4.1/server41tests/st_delegation.py
index 41095b9..d41f12d 100644
--- a/nfs4.1/server41tests/st_delegation.py
+++ b/nfs4.1/server41tests/st_delegation.py
@@ -17,6 +17,7 @@ def __create_file_with_deleg(sess, name, access):
     res = create_file(sess, name, access = access)
     check(res)
     fh = res.resarray[-1].object
+    stateid = res.resarray[-2].stateid
     deleg = res.resarray[-2].delegation
     if (not _got_deleg(deleg)):
         res = open_file(sess, name, access = access)
@@ -24,11 +25,11 @@ def __create_file_with_deleg(sess, name, access):
         deleg = res.resarray[-2].delegation
         if (not _got_deleg(deleg)):
             fail("Could not get delegation")
-    return (fh, deleg)
+    return (fh, stateid, deleg)
 
 def _create_file_with_deleg(sess, name, access):
-    fh, deleg = __create_file_with_deleg(sess, name, access)
-    return fh
+    fh, stateid, deleg = __create_file_with_deleg(sess, name, access)
+    return (fh, stateid)
 
 def _testDeleg(t, env, openaccess, want, breakaccess, sec = None, sec2 = None):
     recall = threading.Event()
@@ -43,7 +44,7 @@ def _testDeleg(t, env, openaccess, want, breakaccess, sec = None, sec2 = None):
     sess1.client.cb_post_hook(OP_CB_RECALL, post_hook)
     if sec2:
         sess1.compound([op.backchannel_ctl(env.c1.prog, sec2)])
-    fh = _create_file_with_deleg(sess1, env.testname(t), openaccess | want)
+    fh, stateid = _create_file_with_deleg(sess1, env.testname(t), openaccess | want)
     sess2 = env.c1.new_client_session(b"%s_2" % env.testname(t))
     claim = open_claim4(CLAIM_NULL, env.testname(t))
     owner = open_owner4(0, b"My Open Owner 2")
@@ -62,6 +63,7 @@ def _testDeleg(t, env, openaccess, want, breakaccess, sec = None, sec2 = None):
     check(res, [NFS4_OK, NFS4ERR_DELAY])
     if not completed:
         fail("delegation break not received")
+    close_file(sess1, fh, stateid=stateid)
     return recall
 
 def testReadDeleg(t, env):
@@ -103,6 +105,7 @@ def testNoDeleg(t, env):
                       OPEN4_SHARE_ACCESS_WANT_NO_DELEG)
     check(res)
     fh = res.resarray[-1].object
+    stateid = res.resarray[-2].stateid
     deleg = res.resarray[-2].delegation
     if deleg.delegation_type == OPEN_DELEGATE_NONE:
         fail("Got no delegation, expected OPEN_DELEGATE_NONE_EXT")
@@ -110,6 +113,7 @@ def testNoDeleg(t, env):
         fail("Got a delegation (type "+str(deleg.delegation_type)+") despite asking for none")
     if deleg.ond_why != WND4_NOT_WANTED:
         fail("Wrong reason ("+str(deleg.ond_why)+") for giving no delegation")
+    close_file(sess1, fh, stateid=stateid)
 
 
 def testCBSecParms(t, env):
@@ -170,7 +174,7 @@ def testDelegRevocation(t, env):
     """
 
     sess1 = env.c1.new_client_session(b"%s_1" % env.testname(t))
-    fh, deleg = __create_file_with_deleg(sess1, env.testname(t),
+    fh, stateid, deleg = __create_file_with_deleg(sess1, env.testname(t),
             OPEN4_SHARE_ACCESS_READ | OPEN4_SHARE_ACCESS_WANT_READ_DELEG)
     delegstateid = deleg.read.stateid
     sess2 = env.c1.new_client_session(b"%s_2" % env.testname(t))
@@ -180,7 +184,7 @@ def testDelegRevocation(t, env):
     open_op = op.open(0, OPEN4_SHARE_ACCESS_WRITE, OPEN4_SHARE_DENY_NONE,
                         owner, how, claim)
     while 1:
-        res = sess2.compound(env.home + [open_op])
+        res = sess2.compound(env.home + [open_op, op.getfh()])
         if res.status == NFS4_OK:
             break;
         check(res, [NFS4_OK, NFS4ERR_DELAY])
@@ -188,6 +192,12 @@ def testDelegRevocation(t, env):
         # depend on the above compound waiting no longer than the
         # server's lease period:
         res = sess1.compound([])
+    if res.status == NFS4_OK:
+        fh2 = res.resarray[-1].object
+        stateid2 = res.resarray[-2].stateid
+    else:
+        fh2 = None
+        stateid2 = None
     res = sess1.compound([op.putfh(fh), op.read(delegstateid, 0, 1000)])
     check(res, NFS4ERR_DELEG_REVOKED, "Read with a revoked delegation")
     slot, seq_op = sess1._prepare_compound({})
@@ -217,6 +227,10 @@ def testDelegRevocation(t, env):
     if flags & ~SEQ4_STATUS_RECALLABLE_STATE_REVOKED:
         print("WARNING: unexpected status flag(s) 0x%x set" % flags)
 
+    close_file(sess1, fh, stateid=stateid)
+    if fh2 is not None and stateid2 is not None:
+        close_file(sess2, fh2, stateid=stateid2)
+
 def testWriteOpenvsReadDeleg(t, env):
     """Ensure that a write open prevents granting a read delegation
 
@@ -228,20 +242,28 @@ def testWriteOpenvsReadDeleg(t, env):
     owner = b"owner_%s" % env.testname(t)
     res = create_file(sess1, owner, access=OPEN4_SHARE_ACCESS_WRITE)
     check(res)
+    fh = res.resarray[-1].object
+    stateid = res.resarray[-2].stateid
 
     sess2 = env.c1.new_client_session(b"%s_2" % env.testname(t))
     access = OPEN4_SHARE_ACCESS_READ | OPEN4_SHARE_ACCESS_WANT_READ_DELEG;
     res = open_file(sess2, owner, access = access)
     check(res)
+    fh2 = res.resarray[-1].object
+    stateid2 = res.resarray[-2].stateid
 
     deleg = res.resarray[-2].delegation
     if (not _got_deleg(deleg)):
         res = open_file(sess2, owner, access = access)
-        fh = res.resarray[-1].object
+        fh2 = res.resarray[-1].object
+        stateid2 = res.resarray[-2].stateid
         deleg = res.resarray[-2].delegation
     if (_got_deleg(deleg)):
         fail("Granted delegation to a file write-opened by another client")
 
+    close_file(sess1, fh, stateid=stateid)
+    close_file(sess2, fh2, stateid=stateid2)
+
 def testServerSelfConflict3(t, env):
     """DELEGATION test
 
@@ -264,13 +286,15 @@ def testServerSelfConflict3(t, env):
     sess1.client.cb_pre_hook(OP_CB_RECALL, pre_hook)
     sess1.client.cb_post_hook(OP_CB_RECALL, post_hook)
 
-    fh, deleg = __create_file_with_deleg(sess1, env.testname(t),
+    fh, stateid, deleg = __create_file_with_deleg(sess1, env.testname(t),
             OPEN4_SHARE_ACCESS_READ | OPEN4_SHARE_ACCESS_WANT_READ_DELEG)
-    print("__create_file_with_deleg: ", fh, deleg)
+    print("__create_file_with_deleg: ", fh, stateid, deleg)
     delegstateid = deleg.read.stateid
     res = open_file(sess1, env.testname(t), access = OPEN4_SHARE_ACCESS_WRITE)
     print("open_file res: ", res)
     check(res)
+    fh = res.resarray[-1].object
+    stateid = res.resarray[-2].stateid
 
     # XXX: cut-n-paste from _testDeleg; make helper instead:
     sess2 = env.c1.new_client_session(b"%s_2" % env.testname(t))
@@ -280,16 +304,26 @@ def testServerSelfConflict3(t, env):
     how = openflag4(OPEN4_NOCREATE)
     open_op = op.open(0, OPEN4_SHARE_ACCESS_WRITE,
                       OPEN4_SHARE_DENY_NONE, owner, how, claim)
-    slot = sess2.compound_async(env.home + [open_op])
+    slot = sess2.compound_async(env.home + [open_op, op.getfh()])
     completed = recall.wait(2)
     env.sleep(.1)
     res = sess1.compound([op.putfh(fh), op.delegreturn(delegstateid)])
     check(res)
     res = sess2.listen(slot)
     check(res, [NFS4_OK, NFS4ERR_DELAY])
+    if res.status == NFS4_OK:
+        fh2 = res.resarray[-1].object
+        stateid2 = res.resarray[-2].stateid
+    else:
+        fh2 = None
+        stateid2 = None
     if not completed:
         fail("delegation break not received")
 
+    close_file(sess1, fh, stateid=stateid)
+    if fh2 is not None and stateid2 is not None:
+        close_file(sess2, fh2, stateid=stateid2)
+
 def _testCbGetattr(t, env, change=0, size=0):
     cb = threading.Event()
     cbattrs = {}
@@ -318,8 +352,8 @@ def _testCbGetattr(t, env, change=0, size=0):
         if caps[FATTR4_OPEN_ARGUMENTS].oa_share_access_want & OPEN_ARGS_SHARE_ACCESS_WANT_DELEG_TIMESTAMPS:
             openmask |= 1<<OPEN_ARGS_SHARE_ACCESS_WANT_DELEG_TIMESTAMPS
 
-    fh, deleg = __create_file_with_deleg(sess1, env.testname(t), openmask)
-    print("__create_file_with_deleg: ", fh, deleg)
+    fh, stateid, deleg = __create_file_with_deleg(sess1, env.testname(t), openmask)
+    print("__create_file_with_deleg: ", fh, stateid, deleg)
     attrs1 = do_getattrdict(sess1, fh, [FATTR4_CHANGE, FATTR4_SIZE,
                                         FATTR4_TIME_ACCESS, FATTR4_TIME_MODIFY])
 
@@ -351,6 +385,7 @@ def _testCbGetattr(t, env, change=0, size=0):
     check(res, [NFS4_OK, NFS4ERR_DELAY])
     if not completed:
         fail("CB_GETATTR not received")
+    close_file(sess1, fh, stateid=stateid)
     return attrs1, attrs2
 
 def testCbGetattrNoChange(t, env):
diff --git a/nfs4.1/server41tests/st_sparse.py b/nfs4.1/server41tests/st_sparse.py
index 960ed5a..0c05e44 100644
--- a/nfs4.1/server41tests/st_sparse.py
+++ b/nfs4.1/server41tests/st_sparse.py
@@ -1,6 +1,6 @@
 from .st_create_session import create_session
 from xdrdef.nfs4_const import *
-from .environment import check, fail, create_file
+from .environment import check, fail, create_file, close_file
 import nfs_ops
 op = nfs_ops.NFS4ops()
 import nfs4lib
@@ -21,6 +21,8 @@ def testAllocateSupported(t, env):
     res = sess.compound([op.putfh(fh), op.allocate(stateid, 0, 1)])
     check(res)
 
+    close_file(sess, fh, stateid=stateid)
+
 def testAllocateStateidZero(t, env):
     """Do a simple ALLOCATE with all-zero stateid
 
@@ -31,10 +33,13 @@ def testAllocateStateidZero(t, env):
     sess = env.c1.new_client_session(env.testname(t))
     res = create_file(sess, env.testname(t), access=OPEN4_SHARE_ACCESS_WRITE)
     fh = res.resarray[-1].object
+    stateid = res.resarray[-2].stateid
 
     res = sess.compound([op.putfh(fh), op.allocate(env.stateid0, 0, 1)])
     check(res)
 
+    close_file(sess, fh, stateid=stateid)
+
 def testAllocateStateidOne(t, env):
     """Do a simple ALLOCATE with all-one stateid
 
@@ -45,6 +50,9 @@ def testAllocateStateidOne(t, env):
     sess = env.c1.new_client_session(env.testname(t))
     res = create_file(sess, env.testname(t), access=OPEN4_SHARE_ACCESS_WRITE)
     fh = res.resarray[-1].object
+    stateid = res.resarray[-2].stateid
 
     res = sess.compound([op.putfh(fh), op.allocate(env.stateid1, 0, 1)])
     check(res)
+
+    close_file(sess, fh, stateid=stateid)
-- 
2.53.0


