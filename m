Return-Path: <linux-nfs+bounces-20483-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qFg5FoRqx2loXAUAu9opvQ
	(envelope-from <linux-nfs+bounces-20483-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 28 Mar 2026 06:43:32 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AE02834D70F
	for <lists+linux-nfs@lfdr.de>; Sat, 28 Mar 2026 06:43:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 703503013D79
	for <lists+linux-nfs@lfdr.de>; Sat, 28 Mar 2026 05:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25CBE2E7179;
	Sat, 28 Mar 2026 05:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XVLWiSf0"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55361A6807
	for <linux-nfs@vger.kernel.org>; Sat, 28 Mar 2026 05:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774676609; cv=none; b=cGa01WcZ9I62l39BArV9O0Dnex3eSQqdzL4qAZ6iDTiR3Rl+pXqIDunRK1rfcCGxuKdf6u6JcAADzgUyHS8w+MPPJupZXfLeHgGBeSfdbfypc7RfPnXsvK99uUigqaGMA69ZuIefEtoie7cCCBaoH/q+fqWecZ5c/lwqH4UzNLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774676609; c=relaxed/simple;
	bh=skGz6kf4JxEYcT4pOQfTU0y/SL6LAQbgi8LAR7NvC9s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GZ7qwwsVySHOOBV1EGOgshnMZeZJm6Z9Uyu5SEwJG2vwIjUkOFQpZ/TOUr9quARpWXxa9Jn6utpv+hQzSOFgX/U/qS2FdHoQJ8xCHLdMPOerF7q+O2N7niQbwZFnjxnHmcVeGrScS50PB9QSiUV1nAydDSVFCUWPR7AgsOgLRSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XVLWiSf0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774676606;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rYdb/SqpR/BZp19XB25nPb+GMt+fhwX2uIVNM2Tiz0E=;
	b=XVLWiSf0fjqxZxUXYJ2wr+FMxedSP/Wq/iossd4Tqyar7zhZQsHRsEbdeGsXrBU8Drfimx
	MpVxf9ihRiiMOqX2fKxDsUbsjEExjODNshYjuv4J+1AFQ8X82ZsrbpEK5TqJ0v0PvdolnE
	P3OUtBusdEQvLrU6AqwyhZMlPaToPJI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-379-1kGTwfOqOgyszkK_XRsOUw-1; Sat,
 28 Mar 2026 01:43:22 -0400
X-MC-Unique: 1kGTwfOqOgyszkK_XRsOUw-1
X-Mimecast-MFC-AGG-ID: 1kGTwfOqOgyszkK_XRsOUw_1774676602
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DEBB6195608D;
	Sat, 28 Mar 2026 05:43:21 +0000 (UTC)
Received: from localhost (dell-per660-10.rhts.eng.pek2.redhat.com [10.73.4.30])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E1A7630001A1;
	Sat, 28 Mar 2026 05:43:20 +0000 (UTC)
From: Jianhong Yin <jiyin@redhat.com>
To: linux-nfs@vger.kernel.org
Cc: calum.mackay@oracle.com,
	jlayton@kernel.org,
	bcodding@redhat.com,
	smayhew@redhat.com,
	jiyin@redhat.com
Subject: [PATCH v3 2/4] pynfs: fix nfs4.1/nfs4server.py error with python3.12+
Date: Sat, 28 Mar 2026 13:42:43 +0800
Message-ID: <20260328054243.3072769-4-jiyin@redhat.com>
In-Reply-To: <20260328054243.3072769-2-jiyin@redhat.com>
References: <20260328054243.3072769-2-jiyin@redhat.com>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20483-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiyin@redhat.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AE02834D70F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

force use gdbm as the backend of shelve module, to avoid error:
'''
sqlite3.ProgrammingError: SQLite objects created in a thread can only be used in that same thread.
'''

test pass on RHEL-9 RHEL-10 and Fedora-43

Signed-off-by: Jianhong Yin <jiyin@redhat.com>
---
 nfs4.1/fs.py | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/nfs4.1/fs.py b/nfs4.1/fs.py
index 31e7528..39a55b2 100644
--- a/nfs4.1/fs.py
+++ b/nfs4.1/fs.py
@@ -932,9 +932,11 @@ class ConfigFS(FileSystem):
 ###################################################
 
 import os
+import sys
 import pickle
 import shutil
 import shelve
+import dbm.gnu as gdbm
 
 class StubFS_Disk(FileSystem):
     _fs_data_name = b"fs_info" # DB name where we store persistent data
@@ -948,6 +950,16 @@ class StubFS_Disk(FileSystem):
             self._init(path)
         # XXX Note shelve DB is still open
 
+    def _dbpath(self, path):
+        """
+        generate proper dbpath format according python version.
+        see: https://docs.python.org/3.13/library/dbm.html#module-dbm.gnu
+        """
+        dbpath = os.path.join(path, self._fs_data_name)
+        if sys.version_info < (3, 11):
+            dbpath = dbpath.decode("utf-8")
+        return dbpath
+
     def _reset(self, path, fsid):
         """Create an empty fs, overwriting all existing data."""
         # Check path exists
@@ -959,8 +971,8 @@ class StubFS_Disk(FileSystem):
         shutil.rmtree(path)
         os.makedirs(path)
         # This needs to be open before calling __init__
-        d = self._fs_data = shelve.open(os.path.join(path, self._fs_data_name),
-                                        "n")
+        db = gdbm.open(self._dbpath(path), "n")
+        d = self._fs_data = shelve.Shelf(db)
         d["_nextid"] = self._nextid
         # normal __init__
         FileSystem.__init__(self)
@@ -980,8 +992,8 @@ class StubFS_Disk(FileSystem):
         if not os.path.isdir(path):
             raise RuntimeError("Path doesn't exist, try using '--reset' option")
         # Ensure persistent fs data exists there
-        d = self._fs_data = shelve.open(os.path.join(path, self._fs_data_name),
-                                        "w") # w needed for later allocation
+        db = gdbm.open(self._dbpath(path), "w") # w needed for later allocation
+        d = self._fs_data = shelve.Shelf(db)
         # Do __init__ portion that is needed
         self.objclass = FSObject
         self._disk_lock = Lock("FSLock(Disk)")
-- 
2.53.0


