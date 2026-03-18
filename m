Return-Path: <linux-nfs+bounces-20265-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6LwROlYlu2nIfgIAu9opvQ
	(envelope-from <linux-nfs+bounces-20265-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Mar 2026 23:21:10 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 89E1B2C355D
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Mar 2026 23:21:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C81B1301A7BC
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Mar 2026 22:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D50C351C18;
	Wed, 18 Mar 2026 22:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iq+zsiSd"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E590A30BF67;
	Wed, 18 Mar 2026 22:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773872468; cv=none; b=rxFtVD5VJBP3cDvrS1/U6dmOvvSamzQR8OHO95HzZ+j1q3fjX2uktm9vGCsFiQoJwbeC9YLVLxnNwNTaIOmSTHg43ioukeDfNUjOXRS3nL/2AB4yiro2yMcSuKu3Lnoh4XfmogFT1RQAgqXWZ04QFRsTmWMFEPcxFP2DiM/5q8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773872468; c=relaxed/simple;
	bh=OXJH/WQXIwljxWLSOn1MCT66uyjPLJ9/bptLdNUiBY8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e7mBYDiwuginfCx2u2FHxLZ3yHT2AURQo1Gp7bZBH4NNMjXLfyhVbC+Vw8fW+6WLUsWacYIwUE3sKpduCg1eqWedJOOUR22NCfEkADsq15teiP/JpTaiAlcwIrjlBnBEhIlkozWpgYd0yryy3IqeKknbvv86E/770QAjbK8XjCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=iq+zsiSd; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=A1pzINGI0p7kOYnI6h/PSeamIRgJ4xB+DsKqeGxuT6g=; b=iq+zsiSdjL9/JcAHtVmOVLkqlU
	6YXk9ptjNwl7qQEPrH66Byr5HuC+HcuQ/l1+mrGvLdz2QzfXOyLIiYyV6bWNYTsGIxfOgUt59btqo
	+mNa2KDQWZ2m3eqjmCyoWLxQzWvBhe7xv8p4B84JLu6JIqNO1Fi/PM53Zr+J10KX0BNGLX+ShbuIp
	T51V5hC2flPD3GRjRf5kHbOeGScCpKMDEt4i7GFggF0YCfzTsc/hbEP8NIMgaYnHs53k5OW/OQ7Tj
	euUqUKM5rb10HLRmFewYJvfy/0hOp6zMmP/OZALFQD6JG5td2hBJERqTOYWtQY2ckGnyk2bjmvVDw
	loEkLT1A==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2zGE-00000009Qor-1EsJ;
	Wed, 18 Mar 2026 22:21:06 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Dai Ngo <dai.ngo@oracle.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	linux-nfs@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH] NFSD: Docs: clean up pnfs server timeout docs
Date: Wed, 18 Mar 2026 15:21:05 -0700
Message-ID: <20260318222105.3031225-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20265-lists,linux-nfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rdunlap@infradead.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	NEURAL_HAM(-0.00)[-0.991];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:dkim,infradead.org:email,infradead.org:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,oracle.com:email]
X-Rspamd-Queue-Id: 89E1B2C355D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Make various changes to the documentation formatting to avoid docs
build errors and otherwise improve the produced output format:

- use bullets for lists
- don't use a '.' at the end of echo commands
- fix indentation

Documentation/admin-guide/nfs/pnfs-block-server.rst:55: ERROR: Unexpected indentation. [docutils]
Documentation/admin-guide/nfs/pnfs-scsi-server.rst:37: ERROR: Unexpected indentation. [docutils]

Fixes: 6a97f70b45e7 ("NFSD: Enforce timeout on layout recall and integrate lease manager fencing")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
# for Chuck's tree
Cc: Dai Ngo <dai.ngo@oracle.com>
Cc: Chuck Lever <chuck.lever@oracle.com>
Cc: linux-nfs@vger.kernel.org
Cc: linux-doc@vger.kernel.org

 Documentation/admin-guide/nfs/pnfs-block-server.rst |   20 +++++-----
 Documentation/admin-guide/nfs/pnfs-scsi-server.rst  |   20 +++++-----
 2 files changed, 20 insertions(+), 20 deletions(-)

--- linux-next-20260316.orig/Documentation/admin-guide/nfs/pnfs-block-server.rst
+++ linux-next-20260316/Documentation/admin-guide/nfs/pnfs-block-server.rst
@@ -47,12 +47,12 @@ system log with the following format:
 
     FENCE failed client[IP_address] clid[#n] device[dev_name]
 
-    Where:
+    where:
 
-    IP_address: refers to the IP address of the affected client.
-    #n: indicates the unique client identifier.
-    dev_name: specifies the name of the block device related
-              to the fencing attempt.
+    - IP_address: refers to the IP address of the affected client.
+    - #n: indicates the unique client identifier.
+    - dev_name: specifies the name of the block device related
+      to the fencing attempt.
 
 The server will repeatedly retry the operation indefinitely. During
 this time, access to the affected file is restricted for all other
@@ -62,11 +62,11 @@ clients access the same file simultaneou
 To restore access to the affected file for other clients, the admin
 needs to take the following actions:
 
-    . shutdown or power off the client being fenced.
-    . manually expire the client to release all its state on the server:
+    - shutdown or power off the client being fenced.
+    - manually expire the client to release all its state on the server::
 
-      echo 'expire' > /proc/fs/nfsd/clients/clid/ctl'.
+        echo 'expire' > /proc/fs/nfsd/clients/clid/ctl'
 
-      Where:
+    where:
 
-      clid: is the unique client identifier displayed in the system log.
+      - clid: is the unique client identifier displayed in the system log.
--- linux-next-20260316.orig/Documentation/admin-guide/nfs/pnfs-scsi-server.rst
+++ linux-next-20260316/Documentation/admin-guide/nfs/pnfs-scsi-server.rst
@@ -29,12 +29,12 @@ system log with the following format:
 
     FENCE failed client[IP_address] clid[#n] device[dev_name]
 
-    Where:
+    where:
 
-    IP_address: refers to the IP address of the affected client.
-    #n: indicates the unique client identifier.
-    dev_name: specifies the name of the block device related
-              to the fencing attempt.
+    - IP_address: refers to the IP address of the affected client.
+    - #n: indicates the unique client identifier.
+    - dev_name: specifies the name of the block device related
+      to the fencing attempt.
 
 The server will repeatedly retry the operation indefinitely. During
 this time, access to the affected file is restricted for all other
@@ -44,12 +44,12 @@ clients access the same file simultaneou
 To restore access to the affected file for other clients, the admin
 needs to take the following actions:
 
-    . shutdown or power off the client being fenced.
-    . manually expire the client to release all its state on the server:
+    - shutdown or power off the client being fenced.
+    - manually expire the client to release all its state on the server::
 
-      echo 'expire' > /proc/fs/nfsd/clients/clid/ctl'.
+        echo 'expire' > /proc/fs/nfsd/clients/clid/ctl'
 
-      Where:
+    where:
 
-      clid: is the unique client identifier displayed in the system log.
+      - clid: is the unique client identifier displayed in the system log.
 

