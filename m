Return-Path: <linux-nfs+bounces-20645-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id dubwCNNb0GkN7AYAu9opvQ
	(envelope-from <linux-nfs+bounces-20645-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 04 Apr 2026 02:31:15 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E635399570
	for <lists+linux-nfs@lfdr.de>; Sat, 04 Apr 2026 02:31:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CE0D2301AB95
	for <lists+linux-nfs@lfdr.de>; Sat,  4 Apr 2026 00:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A40C23183C;
	Sat,  4 Apr 2026 00:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="imboh27S"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8AC22652D
	for <linux-nfs@vger.kernel.org>; Sat,  4 Apr 2026 00:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775262660; cv=none; b=nx81J+GXmKJE6ssTgGHNu/TLEPIgaNqFlBPMOiiyqkfksgLBQL0NDGXbKRe9b4n4+FW/IshlNRbm08wOcd7MTkN2sgld7YrNUwCCQuV/Eo9zcZzpKmXSj3sVqR+tgRafIxTwFPsAZG1b5aFSjv3H3q3qIo4wtynojck5hL/bN44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775262660; c=relaxed/simple;
	bh=og0BOEOuiqMaYCENtIYr3PnA97pUguGWgOsVGICeoVg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t+jvxtQu9KQRgJ+F9YeqdUZlivDqpqaMsz5I8nWmgeDYY5HHFkbS5MS6rKWO5l1CK9NfhfA6nhpE2OJ/u4iLBXJNgZReS6Dg43NG8sL0RAxl3NbnsoMVD0FrC23yn8NH33oUBgc8QG5Py5WGA1UYP80u1VHU1MqlShsEQst6XXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=imboh27S; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775262656;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w5MMgV6cLdcxFKyHOYlcDZskrfVF0gjS3TQtqQBYgwY=;
	b=imboh27SNe4NUsuo6BIzdJJrmfbjAkmiDi5UGEWG22SLq9QmEt6GS7WvceW0eMfSp+jPf6
	HZxMYm6QI0bOFIb1F6E9rU7keibc9cNB4TTJXHfFumQNozrQlmcvhHea6wbmJrZ2KF7pF1
	TOffSKQKYtXDQw8g0cMcaFS4GbvkBuY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-658-iGBylJDCO4mkKovob_9LYw-1; Fri,
 03 Apr 2026 20:30:53 -0400
X-MC-Unique: iGBylJDCO4mkKovob_9LYw-1
X-Mimecast-MFC-AGG-ID: iGBylJDCO4mkKovob_9LYw_1775262652
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 883641800624;
	Sat,  4 Apr 2026 00:30:52 +0000 (UTC)
Received: from aion.redhat.com (unknown [10.22.88.38])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3977C3000223;
	Sat,  4 Apr 2026 00:30:52 +0000 (UTC)
Received: from aion.redhat.com (localhost [IPv6:::1])
	by aion.redhat.com (Postfix) with ESMTP id 127DF749EAF;
	Fri, 03 Apr 2026 20:30:51 -0400 (EDT)
From: Scott Mayhew <smayhew@redhat.com>
To: calum.mackay@oracle.com
Cc: linux-nfs@vger.kernel.org,
	Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v2 4/5] pynfs: fix erroneous test in DELEG24 and DELEG25
Date: Fri,  3 Apr 2026 20:30:49 -0400
Message-ID: <20260404003050.1560149-5-smayhew@redhat.com>
In-Reply-To: <20260404003050.1560149-1-smayhew@redhat.com>
References: <20260404003050.1560149-1-smayhew@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_FROM(0.00)[bounces-20645-lists,linux-nfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[smayhew@redhat.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 6E635399570
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

fattr4_time_deleg_modify is valid in CB_GETATTR and SETATTR.  attrs2
contains the attributes from a GETATTR reply, and will never contain the
fattr4_time_deleg_modify attribute.  Instead, we want to compare
fattr4_time_modify from attrs1 and attrs2.

Fixing that revealed a secondary issue.  In pynfs, these attributes are
nfstime4 objects, so:

1. We need to be careful about how we initialize the timestamps in
   cbattrs.  Otherwise we wind up indadvertently modifying the values in
   attrs1 and causing the DELEG25 test to fail.
2. We need compare the instance attributes (seconds, nseconds) rather
   than the object references (environment.py already has a
   compareTimes() function for this).

Finally, since I'm in there anyway I decided to convert the messages
from legacy printf-style formatting to f-strings.

Cc: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Scott Mayhew <smayhew@redhat.com>
---
 nfs4.1/server41tests/st_delegation.py | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/nfs4.1/server41tests/st_delegation.py b/nfs4.1/server41tests/st_delegation.py
index 754b56c..bbf6925 100644
--- a/nfs4.1/server41tests/st_delegation.py
+++ b/nfs4.1/server41tests/st_delegation.py
@@ -2,7 +2,7 @@ from .st_create_session import create_session
 from .st_open import open_claim4
 from xdrdef.nfs4_const import *
 
-from .environment import check, fail, create_file, open_file, close_file, do_getattrdict, close_file, write_file, read_file
+from .environment import check, fail, create_file, open_file, close_file, do_getattrdict, close_file, write_file, read_file, compareTimes
 from xdrdef.nfs4_type import *
 import nfs_ops
 op = nfs_ops.NFS4ops()
@@ -366,8 +366,10 @@ def _testCbGetattr(t, env, change=0, size=0):
             cbattrs[FATTR4_SIZE] = size
 
     if delegtype == OPEN_DELEGATE_WRITE_ATTRS_DELEG:
-        cbattrs[FATTR4_TIME_DELEG_ACCESS] = attrs1[FATTR4_TIME_ACCESS]
-        cbattrs[FATTR4_TIME_DELEG_MODIFY] = attrs1[FATTR4_TIME_MODIFY]
+        cbattrs[FATTR4_TIME_DELEG_ACCESS] = nfstime4(attrs1[FATTR4_TIME_ACCESS].seconds,
+                                                     attrs1[FATTR4_TIME_ACCESS].nseconds)
+        cbattrs[FATTR4_TIME_DELEG_MODIFY] = nfstime4(attrs1[FATTR4_TIME_MODIFY].seconds,
+                                                     attrs1[FATTR4_TIME_MODIFY].nseconds)
         if change != 0:
             cbattrs[FATTR4_TIME_DELEG_ACCESS].seconds += 1
             cbattrs[FATTR4_TIME_DELEG_MODIFY].seconds += 1
@@ -400,12 +402,11 @@ def testCbGetattrNoChange(t, env):
     """
     attrs1, attrs2 = _testCbGetattr(t, env)
     if attrs1[FATTR4_SIZE] != attrs2[FATTR4_SIZE]:
-        fail("Bad size: %u != %u" % (attrs1[FATTR4_SIZE], attrs2[FATTR4_SIZE]))
+        fail(f"Bad size: {attrs1[FATTR4_SIZE]} != {attrs2[FATTR4_SIZE]}")
     if attrs1[FATTR4_CHANGE] != attrs2[FATTR4_CHANGE]:
-        fail("Bad change attribute: %u != %u" % (attrs1[FATTR4_CHANGE], attrs2[FATTR4_CHANGE]))
-    if FATTR4_TIME_DELEG_MODIFY in attrs2:
-        if attrs1[FATTR4_TIME_MODIFY] != attrs2[FATTR4_TIME_DELEG_MODIFY]:
-            fail("Bad modify time: ", attrs1[FATTR4_TIME_MODIFY], " != ", attrs2[FATTR4_TIME_DELEG_MODIFY])
+        fail(f"Bad change attribute: {attrs1[FATTR4_CHANGE]} != {attrs2[FATTR4_CHANGE]}")
+    if compareTimes(attrs1[FATTR4_TIME_MODIFY], attrs2[FATTR4_TIME_MODIFY]) != 0:
+        fail(f"Bad modify time: {attrs1[FATTR4_TIME_MODIFY]} != {attrs2[FATTR4_TIME_MODIFY]}")
 
 def testCbGetattrWithChange(t, env):
     """Test CB_GETATTR with simulated changes to file
@@ -419,12 +420,11 @@ def testCbGetattrWithChange(t, env):
     """
     attrs1, attrs2 = _testCbGetattr(t, env, change=1, size=5)
     if attrs2[FATTR4_SIZE] != 5:
-        fail("Bad size: %u != 5" % attrs2[FATTR4_SIZE])
+        fail(f"Bad size: {attrs2[FATTR4_SIZE]} != 5")
     if attrs1[FATTR4_CHANGE] == attrs2[FATTR4_CHANGE]:
-        fail("Bad change attribute: %u == %u" % (attrs1[FATTR4_CHANGE], attrs2[FATTR4_CHANGE]))
-    if FATTR4_TIME_DELEG_MODIFY in attrs2:
-        if attrs1[FATTR4_TIME_MODIFY] == attrs2[FATTR4_TIME_DELEG_MODIFY]:
-            fail("Bad modify time: ", attrs1[FATTR4_TIME_MODIFY], " == ", attrs2[FATTR4_TIME_DELEG_MODIFY])
+        fail(f"Bad change attribute: {attrs1[FATTR4_CHANGE]} == {attrs2[FATTR4_CHANGE]}")
+    if compareTimes(attrs1[FATTR4_TIME_MODIFY], attrs2[FATTR4_TIME_MODIFY]) == 0:
+        fail(f"Bad modify time: {attrs1[FATTR4_TIME_MODIFY]} == {attrs2[FATTR4_TIME_MODIFY]}")
 
 def testDelegReadAfterClose(t, env):
     """Test read with delegation stateid after close
-- 
2.53.0


