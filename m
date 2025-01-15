Return-Path: <linux-nfs+bounces-9268-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19A7CA12F2B
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Jan 2025 00:24:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6182D188780A
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Jan 2025 23:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 723B91DD884;
	Wed, 15 Jan 2025 23:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U3ve9l5q"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F801DCB2D
	for <linux-nfs@vger.kernel.org>; Wed, 15 Jan 2025 23:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736983470; cv=none; b=GMxU92RLQwBgtvoSJlgxz4XPaf+ZuyKcaswhLWOLkzx3x70loIHGMiA6GfNmoXfiIWWWILvWmLO3orA8t0REX8Rw5IvAYhzu+gqC8oyahJlgaXz0CGCh0wNEez/mP8TdSpUCnn1DgfcVZiUzQCuG3nok9SuYqSkkdIw38zanz/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736983470; c=relaxed/simple;
	bh=9vyHE5S4wVP78C6HbXA8y6BWDRF7T2odFtUMEaRASlQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=E3Cww7DxxJLBOcYI528Vo1D/E4DilIGINvW/eudoA4twAgfVNdjz8schkJz9YD4gUTAnio3xl9tP+0vLIso++N3xvN2vMzlIByW8mGRACX4bXhTeoVA4F8lvlrg/qsBb+S4j0rPByoO1mKLcuF9uVdkRzcm+Da1NcNkJ3f/PdtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U3ve9l5q; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736983467;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w5Qlm+ZqzRrVU13FRsZgqwth1mTjN8qNZrRGAH7Gb2U=;
	b=U3ve9l5qLXYdabyr+X4TqyjQoIc6IXPaK3iO5dY5Isnpl2aQ6H4jJ/TkA4W0nBfB6au0HB
	N8GlUSSyY8h/mZPzaKdiLRA8a1TGewfYJdDVUtu4GdBwxkAt4hHp2Yq9tbqQfcyVFFn5qo
	L7tCxRKiAe5Nd2aLBomAFRXFLoumkMY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-401-CjyKejWrMj-bcSh7_DqLNA-1; Wed,
 15 Jan 2025 18:24:26 -0500
X-MC-Unique: CjyKejWrMj-bcSh7_DqLNA-1
X-Mimecast-MFC-AGG-ID: CjyKejWrMj-bcSh7_DqLNA
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3CC11195608B;
	Wed, 15 Jan 2025 23:24:25 +0000 (UTC)
Received: from okorniev-mac.redhat.com (unknown [10.22.64.125])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3D2FD3003E7F;
	Wed, 15 Jan 2025 23:24:24 +0000 (UTC)
From: Olga Kornievskaia <okorniev@redhat.com>
To: chuck.lever@oracle.com,
	jlayton@kernel.org
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <okorniev@redhat.com>
Subject: [PATCH 3/3] nfsd: fix management of listener transports
Date: Wed, 15 Jan 2025 18:24:06 -0500
Message-Id: <20250115232406.44815-4-okorniev@redhat.com>
In-Reply-To: <20250115232406.44815-1-okorniev@redhat.com>
References: <20250115232406.44815-1-okorniev@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

When a particular listener is being removed we need to make sure
that we delete the entry from the list of permanent sockets
(sv_permsocks) as well as remove it from the listener transports
(sp_xprts). When adding back the leftover transports not being
removed we need to clear XPT_BUSY flag so that it can be used.

Fixes: 16a471177496 ("NFSD: add listener-{set,get} netlink command")
Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
---
 fs/nfsd/nfsctl.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 95ea4393305b..3deedd511e83 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1988,7 +1988,7 @@ int nfsd_nl_listener_set_doit(struct sk_buff *skb, struct genl_info *info)
 	/* Close the remaining sockets on the permsocks list */
 	while (!list_empty(&permsocks)) {
 		xprt = list_first_entry(&permsocks, struct svc_xprt, xpt_list);
-		list_move(&xprt->xpt_list, &serv->sv_permsocks);
+		list_del_init(&xprt->xpt_list);
 
 		/*
 		 * Newly-created sockets are born with the BUSY bit set. Clear
@@ -2000,6 +2000,7 @@ int nfsd_nl_listener_set_doit(struct sk_buff *skb, struct genl_info *info)
 
 		set_bit(XPT_CLOSE, &xprt->xpt_flags);
 		spin_unlock_bh(&serv->sv_lock);
+		svc_xprt_dequeue_entry(xprt);
 		svc_xprt_close(xprt);
 		spin_lock_bh(&serv->sv_lock);
 	}
@@ -2031,6 +2032,7 @@ int nfsd_nl_listener_set_doit(struct sk_buff *skb, struct genl_info *info)
 
 		xprt = svc_find_listener(serv, xcl_name, net, sa);
 		if (xprt) {
+			clear_bit(XPT_BUSY, &xprt->xpt_flags);
 			svc_xprt_put(xprt);
 			continue;
 		}
-- 
2.47.1


