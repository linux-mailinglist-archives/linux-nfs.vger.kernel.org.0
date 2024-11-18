Return-Path: <linux-nfs+bounces-8044-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 256E39D1988
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Nov 2024 21:19:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A645BB22A22
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Nov 2024 20:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC0CB1E5705;
	Mon, 18 Nov 2024 20:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I5l7KOfg"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120F414D2BB
	for <linux-nfs@vger.kernel.org>; Mon, 18 Nov 2024 20:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731961148; cv=none; b=BMe91XsnZKFPWOEejPdTg/eGAWpxWwPbS2Ku9lDuc8+QA4wZ6VAeeSNKqtO2K9My9wECyXIXTdCx7ov4Q3/EvzB36zX8VJo9py1ATWjJAZUkjm+witcFyVrNcB1PgjOZ1865+jr+6JPVbG/MdL/grN3NsW38bF53e6vjxqe9Fw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731961148; c=relaxed/simple;
	bh=KfgJtKd2TH16pRp5STlDgr6uR7E+hb2eVJtKIQ44FEM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X75+nHe0ccrAfCdHD/dDIRsQRIKNxFTWhP09n8XKp1InNUMdVz4bQMnQez8OWTKWboitoRpknzrQZ5IlnmvS9rNsffrCPuanTPHn23Ksw6/ILT1EhO5tn424rxK9d9o0H7LWyW0eSAd74s/eT0y+e30ugpuBgdYFOEtrfO9DPxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I5l7KOfg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731961146;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1lGJBDFKAMFKPLos9aIw7WukF+GJFxvvHVpfLjhLlW4=;
	b=I5l7KOfgp73zJ5cU27G5y8mrr9zNyU3oRWxk/C8R2pw82ClSgGBWyk00786xEYN8f1ptVS
	tum0x4NV/GLWg357w0C8Cy8IXbyQj3nzRz0VJ6O1cx5UeC/nygRXcJWH2vQ5IsIDZ1GZaw
	gZDq+yXgTM6/BAJ6nXGZnzP3uPnSP1A=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-49-MoIw4W2VMIuvNiSe3-EPvQ-1; Mon,
 18 Nov 2024 15:19:04 -0500
X-MC-Unique: MoIw4W2VMIuvNiSe3-EPvQ-1
X-Mimecast-MFC-AGG-ID: MoIw4W2VMIuvNiSe3-EPvQ
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DDA431955F42
	for <linux-nfs@vger.kernel.org>; Mon, 18 Nov 2024 20:19:03 +0000 (UTC)
Received: from aion.redhat.com (unknown [10.22.80.18])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AB5721956054;
	Mon, 18 Nov 2024 20:19:03 +0000 (UTC)
Received: from aion.redhat.com (localhost [IPv6:::1])
	by aion.redhat.com (Postfix) with ESMTP id 448C3222555;
	Mon, 18 Nov 2024 15:19:02 -0500 (EST)
From: Scott Mayhew <smayhew@redhat.com>
To: steved@redhat.com
Cc: linux-nfs@vger.kernel.org
Subject: [nfs-utils PATCH 2/2] nfsdctl: clarify when versions can be set on the man page
Date: Mon, 18 Nov 2024 15:19:02 -0500
Message-ID: <20241118201902.1115861-3-smayhew@redhat.com>
In-Reply-To: <20241118201902.1115861-1-smayhew@redhat.com>
References: <20241118201902.1115861-1-smayhew@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Attempting to make version changes while there are nfsd threads running
fails with -EBUSY, so make note of it on the man page.

Signed-off-by: Scott Mayhew <smayhew@redhat.com>
---
 utils/nfsdctl/nfsdctl.8    | 12 ++++++++++--
 utils/nfsdctl/nfsdctl.adoc |  2 ++
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/utils/nfsdctl/nfsdctl.8 b/utils/nfsdctl/nfsdctl.8
index dae1863d..38dd1d30 100644
--- a/utils/nfsdctl/nfsdctl.8
+++ b/utils/nfsdctl/nfsdctl.8
@@ -2,12 +2,12 @@
 .\"     Title: nfsdctl
 .\"    Author: Jeff Layton
 .\" Generator: Asciidoctor 2.0.20
-.\"      Date: 2024-07-22
+.\"      Date: 2024-11-18
 .\"    Manual: \ \&
 .\"    Source: \ \&
 .\"  Language: English
 .\"
-.TH "NFSDCTL" "8" "2024-07-22" "\ \&" "\ \&"
+.TH "NFSDCTL" "8" "2024-11-18" "\ \&" "\ \&"
 .ie \n(.g .ds Aq \(aq
 .el       .ds Aq '
 .ss \n[.ss] 0
@@ -176,6 +176,14 @@ all minorversions for that major version.
 .fam
 .fi
 .if n .RE
+.sp
+.if n .RS 4
+.nf
+.fam C
+Note that versions can only be set when there are no nfsd threads running.
+.fam
+.fi
+.if n .RE
 .RE
 .sp
 \fBpool\-mode\fP
diff --git a/utils/nfsdctl/nfsdctl.adoc b/utils/nfsdctl/nfsdctl.adoc
index 7119b44d..79f07cf0 100644
--- a/utils/nfsdctl/nfsdctl.adoc
+++ b/utils/nfsdctl/nfsdctl.adoc
@@ -93,6 +93,8 @@ Each subcommand can also accept its own set of options and arguments. The
   The minorversion field is optional. If not given, it will disable or enable
   all minorversions for that major version.
 
+  Note that versions can only be set when there are no nfsd threads running.
+
 *pool-mode*::
 
   Get/set the host's pool mode. This will cause the server to start threads
-- 
2.46.2


