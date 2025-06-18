Return-Path: <linux-nfs+bounces-12564-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2450CADF602
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Jun 2025 20:36:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A710E7AC34A
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Jun 2025 18:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CD7A27E07E;
	Wed, 18 Jun 2025 18:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ym8r7EUt"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902053085D2
	for <linux-nfs@vger.kernel.org>; Wed, 18 Jun 2025 18:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750271800; cv=none; b=gg7e3E8UYZ53qLhbKo4Xn/KGuOcJCs7zDWMmK1Tju3vxbULv0yEbY4ds2VKD01nrjpRCZLI7Fqbz3SOE4DKxQEtC1oc76Zlbh9Tzc3ioqAsuXWGK6hwrFyj4kQpRfDfjyacLG6n+pUPZAPIWx9ZVIL9mHf0TW2bsUzPeokkRdyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750271800; c=relaxed/simple;
	bh=vI90UmguT3KHF5paYQPtfy3pGwGjKg9I8Xf0qH1KHRg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PrnjW2cYBcSKwBFvTXJ/LBUZPc/8f7DYwlt+O56LELpBUuWSgh8w/nARgw26pec4gl02/FfQVTsqX7BTgN3likbAcPWN9Ui6qpUX3d6EXoy8gdV9l6A/dKJlR8/L4IpzLvqqJPIBFtDDg4DkWcMe8QmhYzduH1QYb0ygzUTxKsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ym8r7EUt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750271795;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=wRQyjLBobqkueoYSRV54e1NaDYsOk/uBSW4vIlFXn7I=;
	b=Ym8r7EUtL15O/m/3KiyhHRLRcXBMY6J1FwEneUWTgrT09PPv4waYMJ6LrfsL7nzADWb/PI
	H59Hy4krPYNbieLYm05QMe+dNgsOR/bQpDTtF/QFGK4kETurkQYjPRjcigUD0aNzEgx/bO
	+5UWyiPc7K5uIKM3m8Kf9pHPkonzFGo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-568-v5ZjCAycMp-L7CyTyLusyg-1; Wed,
 18 Jun 2025 14:36:32 -0400
X-MC-Unique: v5ZjCAycMp-L7CyTyLusyg-1
X-Mimecast-MFC-AGG-ID: v5ZjCAycMp-L7CyTyLusyg_1750271791
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8DB741800292;
	Wed, 18 Jun 2025 18:36:31 +0000 (UTC)
Received: from bcodding.csb.redhat.com (unknown [10.22.58.9])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BB78E19560B0;
	Wed, 18 Jun 2025 18:36:30 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: trondmy@kernel.org,
	anna@kernel.org
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH] NFSv4/pNFS: Fix a race to wake on NFS_LAYOUT_DRAIN
Date: Wed, 18 Jun 2025 14:36:29 -0400
Message-ID: <43be0de9ff48ea68dec20d07cb235e164e634588.1750271744.git.bcodding@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

We found a few different systems hung up in writeback waiting on the same
page lock, and one task waiting on the NFS_LAYOUT_DRAIN bit in
pnfs_update_layout(), however the pnfs_layout_hdr's plh_outstanding count
was zero.

It seems most likely that this is another race between the waiter and waker
similar to commit ed0172af5d6f ("SUNRPC: Fix a race to wake a sync task").
Fix it up by applying the advised barrier.

Fixes: 880265c77ac4 ("pNFS: Avoid a live lock condition in pnfs_update_layout()")
Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
---
 fs/nfs/pnfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
index 5f582713bf05..321d946503cd 100644
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -2043,6 +2043,7 @@ static void nfs_layoutget_end(struct pnfs_layout_hdr *lo)
 {
 	if (atomic_dec_and_test(&lo->plh_outstanding) &&
 	    test_and_clear_bit(NFS_LAYOUT_DRAIN, &lo->plh_flags))
+		smp_mb__after_atomic();
 		wake_up_bit(&lo->plh_flags, NFS_LAYOUT_DRAIN);
 }
 
-- 
2.47.0


