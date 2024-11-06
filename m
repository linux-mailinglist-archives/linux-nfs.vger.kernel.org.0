Return-Path: <linux-nfs+bounces-7728-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B7639BF4F2
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Nov 2024 19:14:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 232FE1C22DAA
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Nov 2024 18:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0CCE208202;
	Wed,  6 Nov 2024 18:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hBaXBURm"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1013B207A19
	for <linux-nfs@vger.kernel.org>; Wed,  6 Nov 2024 18:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730916828; cv=none; b=Y63c4N6UvG9uOKhAi6oqZdmePyyiWibXPi6a/xGyBv7OtsePMyx094u+KDVjUcOb8LFSXTjClV43nTekD4Ic5ZItS6mi4iFoG/PuikqIXM2JQ8R+KCgjSfF7GB3SiiYxtOkmlaJiPKa59aryEUcGORl3ps2Arjo4601mB9mjsTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730916828; c=relaxed/simple;
	bh=jH7WAc82Eai88yIY8rNFHbI6wi279Jkl12zONSI4VNA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fzJiZNqlYSjuHrBxUWuZzhghpRoxSr5wyWCrniD/dCAVeDSAwmARQ0DWWJhmn7kyiFfFHUQoDJSm47C3qrPcEs1Atcimnc/KdjluR/rzAUyvkHYYoof7SqmCccMebepVzf4RViEtxHon6pqaZPmIrbEeWvMTTj5ooDKtyJ12jmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hBaXBURm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730916826;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Hm9ei/RzBabEvgTFFQJ79GMg/ebqF6nbEHSMFOhcjtk=;
	b=hBaXBURmqWYkMFA9r1tKivO7en51GMvJIgnV+R52voOE3+VtTFOtc2lPNgnMZ8Re240rtc
	IZEfkv6MIgqDjrtNMMhcZnjVEXM9dX8QZwLal68x83dUgN9gzJKz/9CWOv3oRDdxarvGqg
	nbghsbsbmHBztEqC0Yh/Z33QsFwOEH4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-408-EaaTq9yTMrupv5q6o8dCXg-1; Wed,
 06 Nov 2024 13:13:44 -0500
X-MC-Unique: EaaTq9yTMrupv5q6o8dCXg-1
X-Mimecast-MFC-AGG-ID: EaaTq9yTMrupv5q6o8dCXg
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 13C8B195609D
	for <linux-nfs@vger.kernel.org>; Wed,  6 Nov 2024 18:13:44 +0000 (UTC)
Received: from aion.redhat.com (unknown [10.22.88.35])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DC5031955F41;
	Wed,  6 Nov 2024 18:13:43 +0000 (UTC)
Received: from aion.redhat.com (localhost [IPv6:::1])
	by aion.redhat.com (Postfix) with ESMTP id 5D5CD21E26B;
	Wed,  6 Nov 2024 13:13:42 -0500 (EST)
From: Scott Mayhew <smayhew@redhat.com>
To: steved@redhat.com
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH] Makefile.am: allow mount.nfs to be writeable by owner
Date: Wed,  6 Nov 2024 13:13:42 -0500
Message-ID: <20241106181342.776776-1-smayhew@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Red Hat-based systems, the debug symbol files are built with a
.gdb_index section to speed up gdb initialization.  The gdb-add-index
program calls objcopy to merge the index file into the object file.
That fails if the object file isn't writeable by the owner.

Signed-off-by: Scott Mayhew <smayhew@redhat.com>
---
 utils/mount/Makefile.am | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/utils/mount/Makefile.am b/utils/mount/Makefile.am
index 5ff1148c..83a8ee1c 100644
--- a/utils/mount/Makefile.am
+++ b/utils/mount/Makefile.am
@@ -50,7 +50,7 @@ install-exec-hook:
 	  ln -sf mount.nfs mount.nfs4 && \
 	  ln -sf mount.nfs umount.nfs && \
 	  ln -sf mount.nfs umount.nfs4 && \
-	  chmod 4511 mount.nfs )
+	  chmod 4711 mount.nfs )
 uninstall-hook:
 	(cd $(DESTDIR)$(sbindir) && \
 	    rm -f mount.nfs4 umount.nfs umount.nfs4)
-- 
2.45.2


