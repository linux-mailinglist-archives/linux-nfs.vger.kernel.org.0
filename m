Return-Path: <linux-nfs+bounces-8892-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2132A00A03
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Jan 2025 14:46:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE7C6163BE8
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Jan 2025 13:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 377FA1F9EDF;
	Fri,  3 Jan 2025 13:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V8mVwA0U"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A868B1FA260
	for <linux-nfs@vger.kernel.org>; Fri,  3 Jan 2025 13:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735911984; cv=none; b=QkXVGIYXDATlU3MYqb4AgEYGf2W5zmYvSUP/5d+9ajp8KfQrg1xnsGl6LaXMxcl/Nq293vd9Q4jFCcb2RiB3B65T9JPm42K37A0vsBnGs33qiaDmlPDxaK174x2UW9zQSl9ZDoZffNCDSB/CBZ9BYUkPbqklEVI5qbTNNpDCXvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735911984; c=relaxed/simple;
	bh=7//awNtDJQ19vrgPbVhtCrFPERTDslu4HtW1iJmSCwU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lG7hlpLfybYvuEiY741fqLxq9+Jlz5NOv+hwXXTPedM6PC6CGzmorwRt0CP4DdwIfrbY5IjytET+nsfVfjhqLZI/Nt4QNpXPxY+FzWAnSwR8OvAy+oZ4E6MGy/vn/XqIDKNWcug5xkf08yel0QJpPRVAQ+AtyBTW411pqLeKqes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V8mVwA0U; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1735911979;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=OyaraXjfalKp4euJ7rQFM7IA42f5TWDKK1/gUXDFI/w=;
	b=V8mVwA0Uj3m2ooaELx/QeXLkxwU5LDLsOH9FV61liPpGy/eXrfuELXsX13LuKQElW2VRt0
	a6W3Mjz5dJ45JdM/qJZzTkzbuSmx6+lztwIX5ZgqBZSSRF1fVu6e1CbcAVb25BL3/hrrow
	OwW1axxW2An6ROjlj3StLIUFTeG52xc=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-632-NgfgDrvMMXWBhuAENOpq-w-1; Fri,
 03 Jan 2025 08:46:17 -0500
X-MC-Unique: NgfgDrvMMXWBhuAENOpq-w-1
X-Mimecast-MFC-AGG-ID: NgfgDrvMMXWBhuAENOpq-w
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 83C591956089
	for <linux-nfs@vger.kernel.org>; Fri,  3 Jan 2025 13:46:16 +0000 (UTC)
Received: from dobby.home.dicksonnet.net (unknown [10.22.80.194])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EE6103000197
	for <linux-nfs@vger.kernel.org>; Fri,  3 Jan 2025 13:46:15 +0000 (UTC)
From: Steve Dickson <steved@redhat.com>
To: Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [PATCH] nsm_make_temp_pathname: Removed A Warning
Date: Fri,  3 Jan 2025 08:46:14 -0500
Message-ID: <20250103134614.323240-1-steved@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

file.c:200:22: warning: assignment discards ‘const’ qualifier from pointer target type [-Wdiscarded-qualifiers]

Signed-off-by: Steve Dickson <steved@redhat.com>
---
 support/nsm/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/support/nsm/file.c b/support/nsm/file.c
index de122b0f..8d4ab9a9 100644
--- a/support/nsm/file.c
+++ b/support/nsm/file.c
@@ -197,7 +197,7 @@ nsm_make_temp_pathname(const char *pathname)
 
 	base = strrchr(pathname, '/');
 	if (base == NULL)
-		base = pathname;
+		base = (char *)pathname;
 	else
 		base++;
 
-- 
2.47.1


