Return-Path: <linux-nfs+bounces-9189-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B5D4A0C565
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Jan 2025 00:13:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0EC77A40BE
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Jan 2025 23:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DF781F9F6D;
	Mon, 13 Jan 2025 23:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VSrfczTE"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13431F9EDA
	for <linux-nfs@vger.kernel.org>; Mon, 13 Jan 2025 23:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736810008; cv=none; b=VsWMNK7Azi/VAmyO/OuA5TwcM/N4Bu5fjxCtpCKjcSpkbrMq3Wxxa5oOViyVlyJkc/0sgASmxQawGpbIZaDMnqWws9A02/jKYkX5T8Pa72kIiNVtKRUrzbAjzhj2TD/Wld4eE+jCkVk/inweM6mWS6zMW69kIWAT4JEhqTton14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736810008; c=relaxed/simple;
	bh=XhgFMIFwVqUTEs6YxgV9n7oiBr1tqvuPCo3S6zh7Lks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JwfnfEaBu+cAkPWRk8KJkezl90BRjxaVIoovqAhkKjDlHJTnMyzyjVip2GhtoyLGhikP6FR06EB3epH9CWEusLu536Jtc05ANrNYbtoRckggtcJZyll7J2A+CcINA4KRRkVKIDiVaW8hk+bwV//gqCRjMBEJ/lAdeCuAZTsFJA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VSrfczTE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736810005;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=49SXEE6H2w3mYGYc3t04GkCD6JiGs9OgABSGQCy3gZM=;
	b=VSrfczTEj/SxYpwlb32PFlyQVI+RQdmVSIZUcQBpRGcj9LcsC3JWsdzSxZoCMNwSghR7zQ
	kVJD3UulfbOhXisiXCJJgnET+5pmUltQcet1SrM+ebQ88BUTSnwsUNqFy6Bb859Bu0R5Th
	z6f78tzYN5HWi6Hn9ghD5lKiLiyolPA=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-511-Wku_ZuM7On6ScdR52z5ajQ-1; Mon,
 13 Jan 2025 18:13:22 -0500
X-MC-Unique: Wku_ZuM7On6ScdR52z5ajQ-1
X-Mimecast-MFC-AGG-ID: Wku_ZuM7On6ScdR52z5ajQ
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 832D01956048;
	Mon, 13 Jan 2025 23:13:21 +0000 (UTC)
Received: from aion.redhat.com (unknown [10.22.64.152])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 540F319560BC;
	Mon, 13 Jan 2025 23:13:21 +0000 (UTC)
Received: from aion.redhat.com (localhost [IPv6:::1])
	by aion.redhat.com (Postfix) with ESMTP id D615C2EA88F;
	Mon, 13 Jan 2025 18:13:19 -0500 (EST)
From: Scott Mayhew <smayhew@redhat.com>
To: steved@redhat.com
Cc: jlayton@kernel.org,
	yoyang@redhat.com,
	linux-nfs@vger.kernel.org
Subject: [nfs-utils PATCH v3 3/3] nfsd: fix version sanity check
Date: Mon, 13 Jan 2025 18:13:19 -0500
Message-ID: <20250113231319.951885-4-smayhew@redhat.com>
In-Reply-To: <20250113231319.951885-1-smayhew@redhat.com>
References: <20250113231319.951885-1-smayhew@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

rpc.nfsd's version sanity check needs to check both the major and
minor versions before failing with a "no version specified" error.

Signed-off-by: Scott Mayhew <smayhew@redhat.com>
---
 utils/nfsd/nfsd.c | 29 ++++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/utils/nfsd/nfsd.c b/utils/nfsd/nfsd.c
index f787583e..a4056499 100644
--- a/utils/nfsd/nfsd.c
+++ b/utils/nfsd/nfsd.c
@@ -68,7 +68,7 @@ read_nfsd_conf(void)
 int
 main(int argc, char **argv)
 {
-	int	count = NFSD_NPROC, c, i, error = 0, portnum, fd, found_one;
+	int	count = NFSD_NPROC, c, i, j, error = 0, portnum, fd, found_one;
 	char *p, *progname, *port, *rdma_port = NULL;
 	char **haddr = NULL;
 	char *scope = NULL;
@@ -330,11 +330,30 @@ main(int argc, char **argv)
 		exit(1);
 	}
 
-	/* make sure that at least one version is enabled */
+	/*
+	 * Make sure that at least one version is enabled.  Note that we might
+	 * need to check the minorvers bit field twice - first while handling
+	 * major version 4 in versbits, and again if no major verions were
+	 * enabled in versbits.
+	 */
 	found_one = 0;
-	for (c = NFSD_MINVERS; c <= NFSD_MAXVERS; c++) {
-		if (NFSCTL_VERISSET(versbits, c))
-			found_one = 1;
+	for (i = NFSD_MINVERS; i <= NFSD_MAXVERS; i++) {
+		if (NFSCTL_VERISSET(versbits, i)) {
+			if (i == 4) {
+				for (j = NFS4_MINMINOR; j <= NFS4_MAXMINOR; j++) {
+					if (NFSCTL_MINORISSET(minorvers, j))
+						found_one = 1;
+				}
+			} else {
+				found_one = 1;
+			}
+		}
+	}
+	if (!found_one) {
+		for (i = NFS4_MINMINOR; i <= NFS4_MAXMINOR; i++) {
+			if (NFSCTL_MINORISSET(minorvers, i))
+				found_one = 1;
+		}
 	}
 	if (!found_one) {
 		xlog(L_ERROR, "no version specified");
-- 
2.45.2


