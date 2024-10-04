Return-Path: <linux-nfs+bounces-6870-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3650499121C
	for <lists+linux-nfs@lfdr.de>; Sat,  5 Oct 2024 00:04:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE7E3B20D6D
	for <lists+linux-nfs@lfdr.de>; Fri,  4 Oct 2024 22:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA47D83CDA;
	Fri,  4 Oct 2024 22:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RTRAGAxa"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44CB7147C86
	for <linux-nfs@vger.kernel.org>; Fri,  4 Oct 2024 22:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728079456; cv=none; b=keCd8UlforsMMIUpHwC2av1H598rffn3WBHD7n15Nqi9v6ZZaju8KUXl3Fn3FWIGtaIruIkOkvN3p0ckBDD8HHYeYEnFtH+FevHWJ2H79vIQUetCOh6wsqJJd6l3JP2s955dh2fh9gjHAmkMUniy3EfmXTSQvt2YeYZ/qwoQQL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728079456; c=relaxed/simple;
	bh=H6F4oisiXQH5TBReZgwJfn2qQ2ERUEF3fm/x7plkIUY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lqNwpyOdaMDh3bWN+XuhuPkic58gAr64Pdq/RiEBsXLo/evACMpAdEL9f0HyIHS1un4v0Ai++sDEW+q97GOULgDFSNz+HpTEr/6E/yzdB5kL2+OCwFNfPDbu6qlnBWU4KGmqRpmqM36zp2mjkLzUWz7uEYH8ydeEDX4wmLc85E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RTRAGAxa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728079454;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0IGprmyyjjQzPQe4OyVSogmJi13grvMR6zOq7likQRU=;
	b=RTRAGAxaMKXKUmd9UtC9XGmmUZ62KrzFS+l93DBiCNLiUqPhOAuoBfgGkmkpoaa/zc3hw8
	mCBSATHoiCXPsSF76/X0xgh+XOxsAz3dgqW3QqD5oz3nbvj5OcgDplRdfUhF21Ljv3XXZs
	GjacecfRUSRAFRMLRn3eSBGjIqMXgw0=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-453-kX7D7GGiPzq4M-mge1oM_g-1; Fri,
 04 Oct 2024 18:04:09 -0400
X-MC-Unique: kX7D7GGiPzq4M-mge1oM_g-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C481019560AE;
	Fri,  4 Oct 2024 22:04:07 +0000 (UTC)
Received: from okorniev-mac.redhat.com (unknown [10.22.17.120])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 352D81956088;
	Fri,  4 Oct 2024 22:04:06 +0000 (UTC)
From: Olga Kornievskaia <okorniev@redhat.com>
To: chuck.lever@oracle.com,
	jlayton@kernel.org
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <okorniev@redhat.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/1] nfsd: fix possible badness in FREE_STATEID
Date: Fri,  4 Oct 2024 18:04:03 -0400
Message-Id: <20241004220403.50034-1-okorniev@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

When multiple FREE_STATEIDs are sent for the same delegation stateid,
it can lead to a possible either use-after-tree or counter refcount
underflow errors.

In nfsd4_free_stateid() under the client lock we find a delegation
stateid, however the code drops the lock before calling nfs4_put_stid(),
that allows another FREE_STATE to find the stateid again. The first one
will proceed to then free the stateid which leads to either
use-after-free or decrementing already zerod counter.

CC: stable@vger.kernel.org
Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
---
 fs/nfsd/nfs4state.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index ac1859c7cc9d..56b261608af4 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -7154,6 +7154,7 @@ nfsd4_free_stateid(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	switch (s->sc_type) {
 	case SC_TYPE_DELEG:
 		if (s->sc_status & SC_STATUS_REVOKED) {
+			s->sc_status |= SC_STATUS_CLOSED;
 			spin_unlock(&s->sc_lock);
 			dp = delegstateid(s);
 			list_del_init(&dp->dl_recall_lru);
-- 
2.43.5


