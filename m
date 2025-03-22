Return-Path: <linux-nfs+bounces-10755-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C026BA6C6A2
	for <lists+linux-nfs@lfdr.de>; Sat, 22 Mar 2025 01:15:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6C277A62F8
	for <lists+linux-nfs@lfdr.de>; Sat, 22 Mar 2025 00:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB3452E338E;
	Sat, 22 Mar 2025 00:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LQckMva5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0E3F9C1
	for <linux-nfs@vger.kernel.org>; Sat, 22 Mar 2025 00:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742602542; cv=none; b=hIZDDt2eG4k58Dddmuz6f49kPVT4rIhwuBiSGyUz2CVJPbszJvJFukTmLc6/msUSQrVNfxTaItVQYSc2osDiKe3bsUAcqrJHlh9Qaf1jXEAJfUoXawDBqz9hu52W1Jw5F2LpVmyOdeKzEgBM3CHo0BH9mVXqcg3CLs5e1vm9KDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742602542; c=relaxed/simple;
	bh=JJO4elqzLEeUMZiR7QiSlsu8Hmcj+RXFnnfBB3JpTig=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MfEZ1752dHON8bqQ7z7ygHs6WTpvZtg7t96VrBrdrnaAOTbQV9E3W0Rjx2I0S7X/mOARAh6cB1m5xAKVmSQ34rVjJHwSB3hGMwJAGxGhmjLAuJLdYHs3GRbo3ClDhwSpX8DpZseUDO+diWmbn4ZD9dnFBX8kS4NBFs3T+v1c10c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LQckMva5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742602540;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nAs8LP/AD062of6xSns8W2yOfNMarC/kAE2NWetGNt4=;
	b=LQckMva5zasxEEHhHb0mTMtYXBzzlPAzJknpR2vQVY4fMpo8dbrYJK2+umrvExq8f7vtbd
	mf2sp4f6TZ4XMsmYkB/m1Q+v9Q482or7bK7/1jGjgEFIeDtqcojtjKNG355SZb/x02HXmQ
	lPPIzvQM1zvifXME7QejGNMgmCndOKk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-99-JhoxJA8INoaIuHCvpyJipg-1; Fri,
 21 Mar 2025 20:15:36 -0400
X-MC-Unique: JhoxJA8INoaIuHCvpyJipg-1
X-Mimecast-MFC-AGG-ID: JhoxJA8INoaIuHCvpyJipg_1742602535
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 637D018004A9;
	Sat, 22 Mar 2025 00:15:35 +0000 (UTC)
Received: from okorniev-mac.redhat.com (unknown [10.22.64.19])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0616519560AF;
	Sat, 22 Mar 2025 00:15:33 +0000 (UTC)
From: Olga Kornievskaia <okorniev@redhat.com>
To: chuck.lever@oracle.com,
	jlayton@kernel.org
Cc: linux-nfs@vger.kernel.org,
	neilb@suse.de,
	Dai.Ngo@oracle.com,
	tom@talpey.com,
	Olga Kornievskaia <okorniev@redhat.com>
Subject: [PATCH 3/3] nfsd: reset access mask for NLM calls in nfsd_permission
Date: Fri, 21 Mar 2025 20:13:06 -0400
Message-Id: <20250322001306.41666-4-okorniev@redhat.com>
In-Reply-To: <20250322001306.41666-1-okorniev@redhat.com>
References: <20250322001306.41666-1-okorniev@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

NLM locking calls need to pass thru file permission checking
and for that prior to calling inode_permission() we need
to set appropriate access mask.

Fixes: 4cc9b9f2bf4d ("nfsd: refine and rename NFSD_MAY_LOCK")
Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
---
 fs/nfsd/vfs.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 4021b047eb18..7928ae21509f 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -2582,6 +2582,13 @@ nfsd_permission(struct svc_cred *cred, struct svc_export *exp,
 	if ((acc & NFSD_MAY_TRUNC) && IS_APPEND(inode))
 		return nfserr_perm;
 
+	/*
+	 * For the purpose of permission checking of NLM requests,
+	 * the locker must have READ access or own the file
+	 */
+	if (acc & NFSD_MAY_NLM)
+		acc = NFSD_MAY_READ | NFSD_MAY_OWNER_OVERRIDE;
+
 	/*
 	 * The file owner always gets access permission for accesses that
 	 * would normally be checked at open time. This is to make
-- 
2.47.1


