Return-Path: <linux-nfs+bounces-1255-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA4E3837164
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Jan 2024 19:59:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 093A61C29F8B
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Jan 2024 18:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC34B41208;
	Mon, 22 Jan 2024 18:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gyGZrWbE"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1451B3D96B
	for <linux-nfs@vger.kernel.org>; Mon, 22 Jan 2024 18:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705948181; cv=none; b=tNZTxBQUVOwGFE3SPEqrA2VVGOT+DGEEVyTWoWyELSokjEdRuG8pd025S4F3Sb9gvT9VpczndSpGAtuo7a+zVsfvLtGitdmg4iA+jOH07UzXFAkp8ODdEDIkuT0lAeQY8o0JjdM4CcNezGf2CTjEczZ74oU5liSJSIdUvDqOOTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705948181; c=relaxed/simple;
	bh=5nNN1eibhkZBGFYnzB2mH2GkLdsw5XnDnCFlo5XPUAQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mBo/hllU2wojhAm2aJMtdjIfjOzjMN0mFkPY5q5RgNJnPl4R2hsPgZgyXfp0hVwEyB+57Tb/tyEA9efWiJ9g4mMwB5XvOfGvEsnjj/2bQveLlKDTdvulVSkrL9xzMk6lak6ZyCuiWMSaemvohzAbyWtUmBHHKR6KwxoieZBlojk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gyGZrWbE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705948178;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Ux7M4l1/HhLrMQMcamgb6OJg5W0IDvJNoEXLL0n5XuA=;
	b=gyGZrWbE8MVZPQEqbyDmxi/AI4hkQTvQoG2b4RW5fpVSYQpk1SvLbbRerY6qPh6PjqwGeJ
	AjMWh2Y39Kb72ddIs5HzYXNxRlmvWIjpjRzqo3jcNVUKuECVXHT4qucBXzWR1rL4/ebiYI
	3KgDTYR2lzeWgNlcZ5DFaaN8Fc9nruc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-471-8bPVzMYsNx2XmBJ5sK58FQ-1; Mon, 22 Jan 2024 13:29:13 -0500
X-MC-Unique: 8bPVzMYsNx2XmBJ5sK58FQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E7B3A845DF5
	for <linux-nfs@vger.kernel.org>; Mon, 22 Jan 2024 18:29:09 +0000 (UTC)
Received: from bighat.boston.devel.redhat.com (bighat.boston.devel.redhat.com [10.19.60.48])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D51812166B33
	for <linux-nfs@vger.kernel.org>; Mon, 22 Jan 2024 18:29:09 +0000 (UTC)
From: Steve Dickson <steved@redhat.com>
To: Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [PATCH] reexport.c: Some Distros need the following include to avoid the following error
Date: Mon, 22 Jan 2024 13:29:09 -0500
Message-ID: <20240122182909.97503-1-steved@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

reexport.c: In function ‘connect_fsid_service’:
reexport.c:41:28: error: implicit declaration of function ‘offsetof’ [-Werror=implicit-function-declaration]
   41 |                 addr_len = offsetof(struct sockaddr_un, sun_path) + strlen(addr.sun_path);
      |                            ^~~~~~~~
reexport.c:19:1: note: ‘offsetof’ is defined in header ‘<stddef.h>’; did you forget to ‘#include <stddef.h>’?
   18 | #include "xlog.h"
  +++ |+#include <stddef.h>
   19 |
reexport.c:41:37: error: expected expression before ‘struct’
   41 |                 addr_len = offsetof(struct sockaddr_un, sun_path) + strlen(addr.sun_path);
      |                                     ^~~~~~
cc1: some warnings being treated as errors

Signed-off-by: Steve Dickson <steved@redhat.com>
---
 support/reexport/reexport.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/support/reexport/reexport.c b/support/reexport/reexport.c
index c7bff6a..1febf59 100644
--- a/support/reexport/reexport.c
+++ b/support/reexport/reexport.c
@@ -9,6 +9,7 @@
 #include <sys/vfs.h>
 #include <unistd.h>
 #include <errno.h>
+#include <stddef.h>
 
 #include "nfsd_path.h"
 #include "conffile.h"
-- 
2.43.0


