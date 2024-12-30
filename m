Return-Path: <linux-nfs+bounces-8845-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DCC5F9FE4FE
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Dec 2024 10:44:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE960188290A
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Dec 2024 09:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 729DF13A88A;
	Mon, 30 Dec 2024 09:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CaKeKcEh"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639F01A00D1
	for <linux-nfs@vger.kernel.org>; Mon, 30 Dec 2024 09:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735551862; cv=none; b=TNmFFa7VjZJhnnJqQQhcJcD/sN1zaQLImyG+1N4E2IK0Pzh7KsAJI7RrJLBlkrCYPGjrOrA4Em7VrcSSnitS6T5qfqDxPFkc7VcRN49qiy9NTLHXzVMj+El1qAJJwTTiLDpaJN7Wrd3ZEq+I5thCaE8Og7sFuS8C0Vf2CGT/P/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735551862; c=relaxed/simple;
	bh=9gqhBg+66t44MB9cH8lr/HMbl3A4/morXcDUUWj6Lb0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iUdVk0thKozgGALzh0L++mk0pA7kpR9zGVgB3yzopOY+5icoKIuzALwzVwv+xDJSqse+E4DqjUGEsVQU0r7u05Omj73JZiyLfvMeYTCyZZvNNvlOcA2vorA4u8290j91gitjZucV8LH7Oaq81LWVEHnd+WaheATK9x30brvjk+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CaKeKcEh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1735551859;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=FkILrVgI/L7rQvzbEKAIBs57FGs1cHSI3aKNXTaL684=;
	b=CaKeKcEhpmP16xyAay0rTbWb5B5hjz2LQn+672f/zBq9UFEGlWglddFEvDu4eHnRCzBEge
	e1TSAiK/mEfrx/ARny6RAYwR07obUACLKb9/AzFYXC0Ysss2UZFtNCfiZvE9MUPAVwMRoX
	U+Gw0ZRJbe/IWhXDasyo/zgYsPy1hfk=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-130-A7OdD8btORSu3M_VWyAQ-g-1; Mon,
 30 Dec 2024 04:44:17 -0500
X-MC-Unique: A7OdD8btORSu3M_VWyAQ-g-1
X-Mimecast-MFC-AGG-ID: A7OdD8btORSu3M_VWyAQ-g
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0ECC619560A3;
	Mon, 30 Dec 2024 09:44:16 +0000 (UTC)
Received: from localhost (dell-per750-06-vm-07.rhts.eng.pek2.redhat.com [10.73.180.56])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 421D51955F54;
	Mon, 30 Dec 2024 09:44:14 +0000 (UTC)
From: Yongcheng Yang <yongcheng.yang@gmail.com>
To: Steve Dickson <steved@redhat.com>
Cc: Linux NFS Mailing list <linux-nfs@vger.kernel.org>,
	Yongcheng Yang <yongcheng.yang@gmail.com>
Subject: [PATCH] nfsdctl: manpage fix a few typos
Date: Mon, 30 Dec 2024 17:43:49 +0800
Message-ID: <20241230094407.442310-1-yongcheng.yang@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Signed-off-by: Yongcheng Yang <yongcheng.yang@gmail.com>
---
 utils/nfsdctl/nfsdctl.8    | 10 +++++-----
 utils/nfsdctl/nfsdctl.adoc |  6 +++---
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/utils/nfsdctl/nfsdctl.8 b/utils/nfsdctl/nfsdctl.8
index 38dd1d30..b08fe803 100644
--- a/utils/nfsdctl/nfsdctl.8
+++ b/utils/nfsdctl/nfsdctl.8
@@ -2,12 +2,12 @@
 .\"     Title: nfsdctl
 .\"    Author: Jeff Layton
 .\" Generator: Asciidoctor 2.0.20
-.\"      Date: 2024-11-18
+.\"      Date: 2024-12-30
 .\"    Manual: \ \&
 .\"    Source: \ \&
 .\"  Language: English
 .\"
-.TH "NFSDCTL" "8" "2024-11-18" "\ \&" "\ \&"
+.TH "NFSDCTL" "8" "2024-12-30" "\ \&" "\ \&"
 .ie \n(.g .ds Aq \(aq
 .el       .ds Aq '
 .ss \n[.ss] 0
@@ -163,7 +163,7 @@ The fields are:
 .fam C
 + to enable a version, \- to disable
 MAJOR: the major version integer value
-MINOR: the minor version integet value
+MINOR: the minor version integer value
 .fam
 .fi
 .if n .RE
@@ -291,7 +291,7 @@ Set the pool\-mode to "pernode":
 .if n .RS 4
 .nf
 .fam C
-nfsctl pool\-mode pernode
+nfsdctl pool\-mode pernode
 .fam
 .fi
 .if n .RE
@@ -306,7 +306,7 @@ user, but configuring the server typically requires an account with elevated
 privileges.
 .SH "SEE ALSO"
 .sp
-nfs.conf(5), rpc.nfsd(8), rpc.mountd(8), exports(5), exportfs(8), nfs.conf(5), rpc.rquotad(8),  nfsstat(8), netconfig(5)
+nfs.conf(5), rpc.nfsd(8), rpc.mountd(8), exports(5), exportfs(8), rpc.rquotad(8), nfsstat(8), netconfig(5)
 .SH "AUTHOR"
 .sp
 Jeff Layton
\ No newline at end of file
diff --git a/utils/nfsdctl/nfsdctl.adoc b/utils/nfsdctl/nfsdctl.adoc
index 79f07cf0..c5921458 100644
--- a/utils/nfsdctl/nfsdctl.adoc
+++ b/utils/nfsdctl/nfsdctl.adoc
@@ -88,7 +88,7 @@ Each subcommand can also accept its own set of options and arguments. The
 
     + to enable a version, - to disable
     MAJOR: the major version integer value
-    MINOR: the minor version integet value
+    MINOR: the minor version integer value
 
   The minorversion field is optional. If not given, it will disable or enable
   all minorversions for that major version.
@@ -143,7 +143,7 @@ Change the number of running threads in first pool to 256:
 
 Set the pool-mode to "pernode":
 
-  nfsctl pool-mode pernode
+  nfsdctl pool-mode pernode
 
 == NOTES
 
@@ -157,4 +157,4 @@ privileges.
 
 == SEE ALSO
 
-nfs.conf(5), rpc.nfsd(8), rpc.mountd(8), exports(5), exportfs(8), nfs.conf(5), rpc.rquotad(8),  nfsstat(8), netconfig(5)
+nfs.conf(5), rpc.nfsd(8), rpc.mountd(8), exports(5), exportfs(8), rpc.rquotad(8), nfsstat(8), netconfig(5)
-- 
2.43.5


