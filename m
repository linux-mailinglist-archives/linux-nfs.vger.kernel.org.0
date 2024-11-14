Return-Path: <linux-nfs+bounces-7947-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 382CF9C7F9F
	for <lists+linux-nfs@lfdr.de>; Thu, 14 Nov 2024 02:00:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA7602831D8
	for <lists+linux-nfs@lfdr.de>; Thu, 14 Nov 2024 01:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FBBEF9C0;
	Thu, 14 Nov 2024 01:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CLEJYcke"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8052F14287
	for <linux-nfs@vger.kernel.org>; Thu, 14 Nov 2024 01:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731546019; cv=none; b=qZ4GuBEmwtIjn64EIBz4Kt3I3fNUaYUNmG92P1qGYBHZcAukyZ6hh18CSa4VmhsqPZtv6pUS1xNUIAkt5pwr/NzVyOGe5Nww0q84xtn7JOkRNsNiiXmX1ddbGyV3W75AXToCfwjWT8JSM/4Ps/twlCuKTp2gqPzQT0VQmBi9XP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731546019; c=relaxed/simple;
	bh=D8VmxyKP6l2APbupqGOUdFGl9WjkEDO0krD2zKqTqB8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=a2ROO9RVRuuw6S1oFPZQFN+mTvxIaLo1c7rICIgsY3K6kSRYw4+GfPVBX84OzpVO103rB7TkWqOUK+PllmE3bQcRI4tPO6xj3YE4Hx82/Dyl0azm8nFGFrrzpT1rBPwAT6yxY7Eex9PTqIzTLLPzlwJ56SWnSSgZScCVKjy3igU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CLEJYcke; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731546016;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=IQE9VKaqfOVfZuXd32jHiSQJsilUtY315dvv10oYXI4=;
	b=CLEJYckesXJ7Q5vO6u/FcKSfj67YuoI/VQELOdxtRMFivBW4mLFu4EnMulIZWqVU40E+m7
	boMKwWw9SG4Z7IfIJYkZif34vPXAF7MwhfoIIFDVA69sCbRz3HR62iqXLySa5EV97DNVBS
	FYOODPr7BM6YFvvI21yJ06Dr6ZPvbuQ=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-1-TTRnCPDuNg-d7baKySnALw-1; Wed,
 13 Nov 2024 20:00:14 -0500
X-MC-Unique: TTRnCPDuNg-d7baKySnALw-1
X-Mimecast-MFC-AGG-ID: TTRnCPDuNg-d7baKySnALw
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8E5961955F57
	for <linux-nfs@vger.kernel.org>; Thu, 14 Nov 2024 01:00:13 +0000 (UTC)
Received: from dobby.kenosha.org.com (unknown [10.22.64.144])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0B90B1956089
	for <linux-nfs@vger.kernel.org>; Thu, 14 Nov 2024 01:00:12 +0000 (UTC)
From: Steve Dickson <steved@redhat.com>
To: Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [PATCH] Revert "getnetconfig.c: free linep to avoid memory leakage"
Date: Wed, 13 Nov 2024 20:00:11 -0500
Message-ID: <20241114010011.544247-1-steved@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

This reverts commit f138e68e7ffefa3f4d71857ddb137fff877fd1d0.
---
 src/getnetconfig.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/src/getnetconfig.c b/src/getnetconfig.c
index 7888f8c..d547dce 100644
--- a/src/getnetconfig.c
+++ b/src/getnetconfig.c
@@ -503,7 +503,9 @@ getnetconfigent(netid)
 	    break;
 	}
     } while (stringp != NULL);
-    free(linep);
+    if (ncp == NULL) {
+	free(linep);
+    }
     fclose(file);
     return(ncp);
 }
-- 
2.47.0


