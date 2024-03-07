Return-Path: <linux-nfs+bounces-2233-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA24D875213
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Mar 2024 15:41:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8639D288AF4
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Mar 2024 14:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05D4B1C68F;
	Thu,  7 Mar 2024 14:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iWMJrU2i"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B89A1E53F
	for <linux-nfs@vger.kernel.org>; Thu,  7 Mar 2024 14:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709822485; cv=none; b=kKgeme9c8JHPi2dEs/1K2seVFNWZKEjlOA832hAjUkOQSibebhggbgMM46dj+TNKYwfO4XkDioo7imKqg2t0mvN/HI9xAOLG2aciqeI6bsBt6GWTl5jo3WywjZq6U7fstR6Qnc+IpGMMFqBnUHqTCjB5vzc1YzDQiC0Ra44OSFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709822485; c=relaxed/simple;
	bh=SzT0R3H52cY0fba/1SVOKjpIXyO+XlXQ5KMtrTf67kE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YHC7a3POCbNouWz9hnaSP1cWapwJpjnSqhanBVWgPLR43xL1qYkUHELhxdU7H+5gjD9OSGRFm+jIYjPw0jW/PTl+O5z52Q/NRP//UXR6/vr73kF7YZP3h0Y0/xPZaOwdLukpk9iz3xQXt4UE5GSYLijt1v0+GeLJKqY0hdF6XNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iWMJrU2i; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709822483;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YU+U233K9DHLwl+rYDJUK9J48Ivi7ET72VEDHN0OOHk=;
	b=iWMJrU2igBFKgWx+W/f+WoXF5dG2NhI+BPJfJVGouXPcZ35R2JmNUZvfhwvP1EWwJaizxc
	xTHOcnX4i5nST8GW6qVlYUKPCnfNsfq7EEvCtxiHa/JVYbAr+GAnEpb1Ik9qn4vBuzcEs1
	6TEvuEeMAUBe5rf7eyh8VHhxOnjp1h4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-407-pMMJEJuMMoaWgQKCPrsC6w-1; Thu, 07 Mar 2024 09:41:20 -0500
X-MC-Unique: pMMJEJuMMoaWgQKCPrsC6w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6CE648A7A09;
	Thu,  7 Mar 2024 14:41:19 +0000 (UTC)
Received: from bcodding.csb.redhat.com (ovpn-0-8.rdu2.redhat.com [10.22.0.8])
	by smtp.corp.redhat.com (Postfix) with ESMTP id F1DB8111DCF4;
	Thu,  7 Mar 2024 14:41:18 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna.schumaker@netapp.com>
Cc: linux-nfs@vger.kernel.org,
	Dave Wysochanski <dwysocha@redhat.com>
Subject: [PATCH RESEND] NFS: Read unlock folio on nfs_page_create_from_folio() error
Date: Thu,  7 Mar 2024 09:41:18 -0500
Message-ID: <810bc21335858754c1a3fbee0a3c94de001f4c3f.1709659767.git.bcodding.resend@redhat.com>
In-Reply-To: <810bc21335858754c1a3fbee0a3c94de001f4c3f.1709659767.git.bcodding@redhat.com>
References: <810bc21335858754c1a3fbee0a3c94de001f4c3f.1709659767.git.bcodding@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

The netfs conversion lost a folio_unlock() for the case where
nfs_page_create_from_folio() returns an error (usually -ENOMEM).  Restore
it.

Reported-by: David Jeffery <djeffery@redhat.com>
Cc: <stable@vger.kernel.org> # 6.4+
Fixes: 000dbe0bec05 ("NFS: Convert buffered read paths to use netfs when fscache is enabled")
Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
---

Resending this as I messed up Trond's email address on the first try:
https://lore.kernel.org/linux-nfs/CALF+zOn50xfKDBxqG1JfWVcRa+PvMvMpcWYfJmt0FWoUe0mW5w@mail.gmail.com/T/#t

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


