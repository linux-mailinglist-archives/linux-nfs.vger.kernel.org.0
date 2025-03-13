Return-Path: <linux-nfs+bounces-10595-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1764DA5F98F
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Mar 2025 16:20:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40F3616FD07
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Mar 2025 15:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D0D663B9;
	Thu, 13 Mar 2025 15:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AT0cNdLR"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AFF7268C57
	for <linux-nfs@vger.kernel.org>; Thu, 13 Mar 2025 15:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741879143; cv=none; b=VuaM18WJGPh3gYxjkDyarhSTVRPN1IdsQCmZgP6meyt2AGXGM2qwd+WQs4g+XBQLPHiZZmP9fPyixJg/qOomG1CnZLtrY9nCjxyR8pysziobGlGw6NuzlkHzCpsdhBq2KAhv8+vSw+NP/uIZ9lD4Z3sTMGx1LRjMyBHZWt029HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741879143; c=relaxed/simple;
	bh=AHUC9tL4JFQzkZNMcKZ5gj9IiBSRu8W0ADyiGb/eTN4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ph6+VzUKBMX5YQb6B/0d5QjzQf+7tfViu0iKcG/52I9ydj4fH2o9j5oaUV4sGmo7O09GLChPjSCNnNU7UKgYJw2YlBKeVraAoVJlId+F8C3I44H2K3ePA/8jWYBRUuMhO4VnOZ9VyRCXS2jA9ox/s7WAbYLdiMUwHMBHfJealRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AT0cNdLR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741879140;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YzEHfd1DBW9TXZV74mux9isWqfzG2cVZcbHfbCbbyCA=;
	b=AT0cNdLR/bEYYuMTeKIeMwAoFlfg3MWKojKDnD81JXnF/RkjjsHuMjgydKBbh2SNIkzH+u
	8cPj4jhVnWFg+JYnq1fZg4DKCEg++JeAmE46CKnWIhetIypvZYWPSEk+38IQ54o8ezkGOk
	TvGTp0zvVqkqxoL2ndKBIIpLqL+tr/w=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-500-ojx8RSQuPJOPngXBDXyx-g-1; Thu,
 13 Mar 2025 11:18:59 -0400
X-MC-Unique: ojx8RSQuPJOPngXBDXyx-g-1
X-Mimecast-MFC-AGG-ID: ojx8RSQuPJOPngXBDXyx-g_1741879138
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2619F19560BD
	for <linux-nfs@vger.kernel.org>; Thu, 13 Mar 2025 15:18:58 +0000 (UTC)
Received: from bcodding.csb.redhat.com (unknown [10.22.76.7])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9602718001EF;
	Thu, 13 Mar 2025 15:18:57 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: steved@redhat.com
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH] nfs(5): Add new rdirplus functionality, clarify
Date: Thu, 13 Mar 2025 11:18:56 -0400
Message-ID: <149e91803c796d956f9b1d59189f612b59e144a1.1741878805.git.bcodding@redhat.com>
In-Reply-To: <cover.1741876784.git.bcodding@redhat.com>
References: <cover.1741876784.git.bcodding@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

The proposed kernel [patch][1] will modify the rdirplus mount option to
accept optional string values of "none" and "force".  Update the man page
to reflect these changes and clarify the current client's behavior for the
default.

[1]: https://lore.kernel.org/linux-nfs/8c33cd92be52255b0dd0a7489c9e5cc35434ec95.1741876784.git.bcodding@redhat.com/T/#u

Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
---
 utils/mount/nfs.man | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/utils/mount/nfs.man b/utils/mount/nfs.man
index eab4692a87de..91fc508de280 100644
--- a/utils/mount/nfs.man
+++ b/utils/mount/nfs.man
@@ -434,11 +434,16 @@ option may also be used by some pNFS drivers to decide how many
 connections to set up to the data servers.
 .TP 1.5i
 .BR rdirplus " / " nordirplus
-Selects whether to use NFS v3 or v4 READDIRPLUS requests.
-If this option is not specified, the NFS client uses READDIRPLUS requests
-on NFS v3 or v4 mounts to read small directories.
-Some applications perform better if the client uses only READDIR requests
-for all directories.
+Selects whether to use NFS v3 or v4 READDIRPLUS requests.  If this option is
+not specified, the NFS client uses a heuristic to optimize performance by
+choosing READDIR vs READDIRPLUS based on how often the calling process uses
+the additional attributes returned from READDIRPLUS.  Some applications
+perform better if the client uses only READDIR requests for all directories.
+.TP 1.5i
+.BR rdirplus={none|force}
+If set to "force", the NFS client always attempts to use READDIRPLUS
+requests.  If set to "none", the behavior is the same as
+.B nordirplus.
 .TP 1.5i
 .BI retry= n
 The number of minutes that the
-- 
2.47.0


