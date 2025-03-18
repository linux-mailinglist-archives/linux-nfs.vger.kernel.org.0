Return-Path: <linux-nfs+bounces-10660-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F794A67DED
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Mar 2025 21:17:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F11A3A339D
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Mar 2025 20:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1F4D1EF385;
	Tue, 18 Mar 2025 20:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fgimsVOC"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12051DED6E
	for <linux-nfs@vger.kernel.org>; Tue, 18 Mar 2025 20:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742329042; cv=none; b=W404HF4LDdWF3PFnvCTu9+j71xit9fG+xFzb+tvpGMwpNNliAz0+0Dqz9Vhqpltg95thj17noja8NjIPF6TWIN29t85Ee7231iGJY5SexCnouS7vqnBHU+7JqGgbe+Fx5p8u/a43Vdq6tC5ducD1X4Tqh830RQyLn2ha8LjfRKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742329042; c=relaxed/simple;
	bh=A6QRa/sMowj8o+TXiSeBlwtp+bkX6GHXEzPruqTgPh4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UYEciV/+yQMNKLJWu8dn6cc0A0jpq62QZOQkG40D5TAbrTIBOtuaxwfzuLeLwID2GaL3oCSSSDvELodU56u6GrqZdmT5jGUJASsYchKC5axdlvKor62v0WxWua5bgvxoFsoAZzrLTADtwcK7wLgUgDCcR1fCHRhb9Eh73DmLIYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fgimsVOC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742329039;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=FTLAEnfAyrhIHOgoZljpSNegw+EGq9r3S+8eesO7OW8=;
	b=fgimsVOCgyrU0/HgNDc8hAvUdWIomknBoGLAIlRusinfZfCtEUurzYzB2zeqLmqPPqP54O
	I4m2cVS++RIOWdtSnPNiPBbCfQQa8M2YA1NGXbbZApSDxEYlSiP9dQLUk77qpwW/CiBdlS
	iXFSjPWZcbB74YyRVVpf9FKDHUqyD5Q=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-442-aaSFJe7pO3uKjM5wQYmZ4w-1; Tue,
 18 Mar 2025 16:17:18 -0400
X-MC-Unique: aaSFJe7pO3uKjM5wQYmZ4w-1
X-Mimecast-MFC-AGG-ID: aaSFJe7pO3uKjM5wQYmZ4w_1742329037
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 78B6F180049D
	for <linux-nfs@vger.kernel.org>; Tue, 18 Mar 2025 20:17:17 +0000 (UTC)
Received: from aion.redhat.com (unknown [10.22.88.143])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3E57E1828A83;
	Tue, 18 Mar 2025 20:17:17 +0000 (UTC)
Received: from aion.redhat.com (localhost [IPv6:::1])
	by aion.redhat.com (Postfix) with ESMTP id 6D87E339DF4;
	Tue, 18 Mar 2025 16:17:14 -0400 (EDT)
From: Scott Mayhew <smayhew@redhat.com>
To: steved@redhat.com
Cc: yoyang@redhat.com,
	linux-nfs@vger.kernel.org
Subject: [nfs-utils PATCH] nfsdctl: ensure autostart honors the default nfs.conf versX.Y settings
Date: Tue, 18 Mar 2025 16:17:14 -0400
Message-ID: <20250318201714.1164817-1-smayhew@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Yongcheng noted that after disabling a versX.Y option in /etc/nfs.conf,
and starting nfsd, subsequently commenting out that option and
restarting nfsd would not result in it being re-enabled.

Reported-by: Yongcheng Yang <yoyang@redhat.com>
Fixes: 03b2e2a1 ("nfsdctl: tweak the nfs.conf version handling")
Signed-off-by: Scott Mayhew <smayhew@redhat.com>
---
 utils/nfsdctl/nfsdctl.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/utils/nfsdctl/nfsdctl.c b/utils/nfsdctl/nfsdctl.c
index 05fecc71..5ea848c9 100644
--- a/utils/nfsdctl/nfsdctl.c
+++ b/utils/nfsdctl/nfsdctl.c
@@ -1318,6 +1318,18 @@ static int configure_versions(void)
 	bool found_one = false;
 	char tag[20];
 
+	/*
+	 * First apply the default versX.Y settings from nfs.conf.
+	 */
+	update_nfsd_version(3, 0, true);
+	update_nfsd_version(4, 0, true);
+	update_nfsd_version(4, 1, true);
+	update_nfsd_version(4, 2, true);
+
+	/*
+	 * Then apply any versX.Y settings that are explicitly set in
+	 * nfs.conf.
+	 */
 	for (i = 2; i <= 4; ++i) {
 		sprintf(tag, "vers%d", i);
 		if (!conf_get_bool("nfsd", tag, true)) {
-- 
2.47.1


