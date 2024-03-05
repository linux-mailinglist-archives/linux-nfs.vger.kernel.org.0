Return-Path: <linux-nfs+bounces-2214-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B4C8725AD
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Mar 2024 18:30:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC9AD282B1D
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Mar 2024 17:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62BAB16415;
	Tue,  5 Mar 2024 17:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PiA/PeUU"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1517171AD
	for <linux-nfs@vger.kernel.org>; Tue,  5 Mar 2024 17:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709659839; cv=none; b=NGs0SvR3vB905St4X/8PCgif6lBRVp53MgxEgHjFkjVvZ7/P02Qv/qDgOkFcQrHafL+OaFNEQx3M30ItUpK6+7O41ErSFtuzlUWl6hAE4ad6vSR9dHb/MG5FtGMo+cUKlVrJHlyxEdXT4bZD94Qp+wAXirt5Dk9luFjQnxzQpWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709659839; c=relaxed/simple;
	bh=A40W+dIFr2FNDMEQXikE3+HXKDshyAEDms3/gZ/5WWo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SCjemOoa/0ON0VpmxkJv12m2oMtU9/lH5Sk+vfk3RQHjpEsqIgPaDcr5lCpFGlrnpZspshm2MM9wBmQDTVRiJIoQvtzOM0tqjc16ynrsr8H/+HmdyjoF0wqQtUPMuqrFfHb4YvlpM2IGg7nieTdZ1RJEAChxPo5ANg1srtiuhNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PiA/PeUU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709659836;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JamRob1XtO8yUwHAkKUYFWI9JCdfNbPb4wTdy031khg=;
	b=PiA/PeUUE212ey1OJAEGVpMHfzPKY30P//o+wTm3XB4Qiq1pjWf7EJcFqeAbdu9r5utqC+
	rKlwTEgVBhY7hCgs6RaMLjo61Hl3LXm/I4dwRvMkL/3XepkG/FjlO6RjvY+enHqez9dLjv
	5bovl45AVSWaGwbLTu7iNfFMV33m8XA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-627-spHL4_fyM_O_YUlFNsBpTw-1; Tue,
 05 Mar 2024 12:30:31 -0500
X-MC-Unique: spHL4_fyM_O_YUlFNsBpTw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AFFCB38000A4;
	Tue,  5 Mar 2024 17:30:30 +0000 (UTC)
Received: from bcodding.csb.redhat.com (ovpn-0-8.rdu2.redhat.com [10.22.0.8])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2CE9B16A9B;
	Tue,  5 Mar 2024 17:30:30 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Trond Myklebust <trond.myklebust@primarydata.com>,
	Anna Schumaker <anna.schumaker@netapp.com>
Cc: linux-nfs@vger.kernel.org,
	Dave Wysochanski <dwysocha@redhat.com>
Subject: [PATCH] NFS: Read unlock folio on nfs_page_create_from_folio() error
Date: Tue,  5 Mar 2024 12:30:29 -0500
Message-ID: <810bc21335858754c1a3fbee0a3c94de001f4c3f.1709659767.git.bcodding@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

The netfs conversion lost a folio_unlock() for the case where
nfs_page_create_from_folio() returns an error (usually -ENOMEM).  Restore
it.

Reported-by: David Jeffery <djeffery@redhat.com>
Cc: <stable@vger.kernel.org> # 6.4+
Fixes: 000dbe0bec05 ("NFS: Convert buffered read paths to use netfs when fscache is enabled")
Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
---
 fs/nfs/read.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/nfs/read.c b/fs/nfs/read.c
index 7dc21a48e3e7..a142287d86f6 100644
--- a/fs/nfs/read.c
+++ b/fs/nfs/read.c
@@ -305,6 +305,8 @@ int nfs_read_add_folio(struct nfs_pageio_descriptor *pgio,
 	new = nfs_page_create_from_folio(ctx, folio, 0, aligned_len);
 	if (IS_ERR(new)) {
 		error = PTR_ERR(new);
+		if (nfs_netfs_folio_unlock(folio))
+			folio_unlock(folio);
 		goto out;
 	}
 
-- 
2.43.0


