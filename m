Return-Path: <linux-nfs+bounces-5003-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D85D1938BE0
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Jul 2024 11:17:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 164581C20C91
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Jul 2024 09:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4066A16A37C;
	Mon, 22 Jul 2024 09:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WLZ0IS9N"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A464168C20
	for <linux-nfs@vger.kernel.org>; Mon, 22 Jul 2024 09:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721639845; cv=none; b=UM8Ny/GpbsD7ke8NFYJzp1966OB+nK4Al/2/eLSIf7QFH10lgz/hLvkG0NohpTlY7+v1ATixclux4VHcbGTPPtKhTeRjvshqhQ96a7CoZtacWWUSVmtgscy7SP/b1h8sVURqFw4g1IQu346xAWgJqPGf8UMElbcHC0qlM0d6OZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721639845; c=relaxed/simple;
	bh=E30xYizy50M/gnD5hNpv7Bp1+w+yMzrpUDqXA5Ku56Q=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=qT6+UjXbk/X4UhXXtq5jJaMctkD3N3/yq/+FSk3Bm7rXKoIyWtlg5tQ2uZvPsUgtrKuAfYgOm4kPHltLiaurlTqD6zMfqtqEUcWogOkWpXbFGGcS4lSO4PpCtCWL+NEOG3iVliXI5gP9U5nzFIBkFteXX+5t+Nkswo5OZRNKOrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WLZ0IS9N; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721639841;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dHyfL7iUIRrfiNyEs/Fnf/n7vTlVpaDSivpVqXnkDlE=;
	b=WLZ0IS9NM/ULaZ93Nyh2/HhC66q+1vh/w7yCzDaUEvG7ksceDW8tuGyPAM4rJqh+9bXApQ
	vSYAKGP95iH/vr7AlCaOqGb6Y7Y/fbCvu/xmdrnCJENYTuAyjMnTWiRKgfL9Y0/r/wiLvm
	6LGYds28RogtqJ1UTKyEgWkziqSThcE=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-518-CdUF98RMPmWm2gCRS3l-8A-1; Mon,
 22 Jul 2024 05:17:17 -0400
X-MC-Unique: CdUF98RMPmWm2gCRS3l-8A-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E2E441955D56
	for <linux-nfs@vger.kernel.org>; Mon, 22 Jul 2024 09:17:16 +0000 (UTC)
Received: from bighat.boston.devel.redhat.com (unknown [10.22.8.88])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2AF5A1955D45
	for <linux-nfs@vger.kernel.org>; Mon, 22 Jul 2024 09:17:16 +0000 (UTC)
From: Steve Dickson <steved@redhat.com>
To: Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [PATCH] rpc-gssd.service has status failed (due to rpc.gssd segfault).
Date: Mon, 22 Jul 2024 05:16:38 -0400
Message-ID: <20240722091638.53546-1-steved@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

From: Paulo Andrade <pandrade@redhat.com>

Ensure strings are not NULL before doing a strdup() in error path.

Fixes: https://issues.redhat.com/browse/RHEL-43286
Signed-off-by: Steve Dickson <steved@redhat.com>
---
 utils/gssd/gssd.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/utils/gssd/gssd.c b/utils/gssd/gssd.c
index d7a28225..01ce7d18 100644
--- a/utils/gssd/gssd.c
+++ b/utils/gssd/gssd.c
@@ -365,12 +365,12 @@ gssd_read_service_info(int dirfd, struct clnt_info *clp)
 
 fail:
 	printerr(0, "ERROR: failed to parse %s/info\n", clp->relpath);
-	clp->upcall_address = strdup(address);
-	clp->upcall_port = strdup(port);
+	clp->upcall_address = address ? strdup(address) : NULL;
+	clp->upcall_port = port ? strdup(port) : NULL;
 	clp->upcall_program = program;
 	clp->upcall_vers = version;
-	clp->upcall_protoname = strdup(protoname);
-	clp->upcall_service = strdup(service);
+	clp->upcall_protoname = protoname ? strdup(protoname) : NULL;
+	clp->upcall_service = service ? strdup(service) : NULL;
 	free(servername);
 	free(protoname);
 	clp->servicename = NULL;
-- 
2.45.2


