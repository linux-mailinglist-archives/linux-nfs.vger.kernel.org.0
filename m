Return-Path: <linux-nfs+bounces-20630-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cORXEmnAz2ky0QYAu9opvQ
	(envelope-from <linux-nfs+bounces-20630-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 03 Apr 2026 15:28:09 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BD539394710
	for <lists+linux-nfs@lfdr.de>; Fri, 03 Apr 2026 15:28:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8B635303A864
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Apr 2026 13:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E7A53B8958;
	Fri,  3 Apr 2026 13:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hNCPpLB7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8C43A3E96
	for <linux-nfs@vger.kernel.org>; Fri,  3 Apr 2026 13:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775222872; cv=none; b=fIlPfkBGvAJFCwhInxeA1kWbN1pVgJ+izMNq+UZyUKRh58QJ4OvoWDlT2RTcjYQOYXUQQIKNI96cK71GgpRmuBVKnHvAdVvl/vWw2cUZVcr/PbSD68y5huL+nVjMKvdT2YAfTy1LUbnlQU/8JYKqkRfgXbtkIMxd/3FWAcTbL3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775222872; c=relaxed/simple;
	bh=Ev0/TH1eAUEHe2n5ul6GZ1PCf/bWMcPSNtu+eajWENw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QnyS6ZYSnNdjT9z/KuWub0aJtkfeOJlQjYCv9g0lXyw9og+kdA/D8Q0VHnjSH6iT5H+hG+rYu0HAT6tcZ+Lk25WSiY8PaZDb3dJzZWJLem3LffReomIaQCuk8FE0qTSxAM51hOGVsAXMQNi4OXbTX+kcSsat3qEe5WkQxFSBzrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hNCPpLB7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775222870;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2qwxLCsXrdhX145KcCLHLRp/i21IDMeySKhu0WUi9C0=;
	b=hNCPpLB7fNnSns3lz7WtDAejNkOtIO0970yCVz1m0ohJq7oBOGLIho98w96nBcO15EmSVz
	GCSFVol47GIpvaUoCWZwKAKQFedokJttpHfiJ/vV7dBG7yAgdCbqgThF/tp5pLS5GBMrs/
	PZOz3QY7tsRwglQsIElLs6efCMvtOJA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-443-5SK_uD9_PT-HcdANrDjMZA-1; Fri,
 03 Apr 2026 09:27:47 -0400
X-MC-Unique: 5SK_uD9_PT-HcdANrDjMZA-1
X-Mimecast-MFC-AGG-ID: 5SK_uD9_PT-HcdANrDjMZA_1775222866
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7997B18007FD;
	Fri,  3 Apr 2026 13:27:41 +0000 (UTC)
Received: from aion.redhat.com (unknown [10.22.88.38])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0FAEF1955D6D;
	Fri,  3 Apr 2026 13:27:41 +0000 (UTC)
Received: from aion.redhat.com (localhost [IPv6:::1])
	by aion.redhat.com (Postfix) with ESMTP id 5EED6749DF0;
	Fri, 03 Apr 2026 09:27:38 -0400 (EDT)
From: Scott Mayhew <smayhew@redhat.com>
To: calum.mackay@oracle.com
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 5/5] pynfs: add delegation test for CB_GETATTR after sync WRITE
Date: Fri,  3 Apr 2026 09:27:38 -0400
Message-ID: <20260403132738.1482011-6-smayhew@redhat.com>
In-Reply-To: <20260403132738.1482011-1-smayhew@redhat.com>
References: <20260403132738.1482011-1-smayhew@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20630-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FROM_NEQ_ENVFROM(0.00)[smayhew@redhat.com,linux-nfs@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: BD539394710
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
This test currently passes if nfsd has delegated timestamps enabled and
fails if it does not have them enabled (nfsd-next commit "nfsd: add a
runtime switch for disabling delegated timestamps" comes in handy for
testing).

I posted the following kernel patch which fixes this failure:
https://lore.kernel.org/linux-nfs/20260403132209.1479385-1-smayhew@redhat.com/T/#u

 nfs4.1/server41tests/st_delegation.py | 152 ++++++++++++++++++++++++++
 1 file changed, 152 insertions(+)

diff --git a/nfs4.1/server41tests/st_delegation.py b/nfs4.1/server41tests/st_delegation.py
index 2257966..8a51eb9 100644
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
@@ -470,3 +472,153 @@ def testDelegReadAfterClose(t, env):
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
+    if (attrs2[FATTR4_TIME_MODIFY].seconds != attrs4[FATTR4_TIME_MODIFY].seconds
+            or attrs2[FATTR4_TIME_MODIFY].nseconds != attrs4[FATTR4_TIME_MODIFY].nseconds):
+        fail(f"mtime after write ({attrs2[FATTR4_TIME_MODIFY]}) != "
+             f"mtime from delegreturn ({attrs4[FATTR4_TIME_MODIFY]})")
-- 
2.53.0


