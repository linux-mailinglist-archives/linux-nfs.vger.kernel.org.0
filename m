Return-Path: <linux-nfs+bounces-6567-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B61597D808
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Sep 2024 18:06:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD7051C21C80
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Sep 2024 16:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7853A17A5BE;
	Fri, 20 Sep 2024 16:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hFjhGhjh"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B942770B
	for <linux-nfs@vger.kernel.org>; Fri, 20 Sep 2024 16:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726848364; cv=none; b=SyToI+AQA6khIT1p63jVrpud+4IoigcjIBlal1s6D+Bqb4Z3fQ/38O3eJlb2jLcF6w2kAvsAxfRZflcn7yrVxFUp0l38pUhoNYmtx9KRwpuTmef+BKlofNnlhWcrPMGTQvIg+1XGkXMlLyFquLuvDWuoeMHU/66bjNWUfNy3E2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726848364; c=relaxed/simple;
	bh=8X5mBajZljVI9ZwljxXouNPehNQn25zeA3bDR+vk4dU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qwjSaZpGo4SMzdns1WwTSglYYhgosbEdcdibPKy4eGOPbsd6Vo0ibEP68gLylMrlFT5LWGw9QTQJgTTnUNfijVbDQdKW6IlQjKkZ6YAS+4aCMwLD0InLXnGBUy846RCW+DZOvGhrPSDFHykhjEtP0hGuXO/r42zX9VbNeYPtTfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hFjhGhjh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726848361;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xl+6gI7Pwj3bhaJcPenv52uE5Xe+pt3KJ/Q3qT+J9u4=;
	b=hFjhGhjhQ5p6dZzWM9VxJbDGndJiRjlxgtgv3S/eVutU2cPiGHoBOOXQ3ep1JJiUNYiVba
	pDKakEC9za46ZyyyCaQt6g7dBL0dzRZSBIsiWGERmQ6inkr8kKHmEt0HmVtvk5Gfj4BNps
	72KuiBxGrEdN8odteuJkdXY0pKx5Opg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-644-seHyb6pXPcOe1O3GKin_4g-1; Fri,
 20 Sep 2024 12:05:58 -0400
X-MC-Unique: seHyb6pXPcOe1O3GKin_4g-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E6F1E1920C7F;
	Fri, 20 Sep 2024 16:05:57 +0000 (UTC)
Received: from okorniev-mac.redhat.com (unknown [10.22.8.172])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A8DEA1956094;
	Fri, 20 Sep 2024 16:05:56 +0000 (UTC)
From: Olga Kornievskaia <okorniev@redhat.com>
To: chuck.lever@oracle.com,
	jlayton@kernel.org
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <okorniev@redhat.com>
Subject: [PATCH 1/1] nfsd: fix handling of WANT_DELEG_TIMESTAMPS on open
Date: Fri, 20 Sep 2024 12:05:51 -0400
Message-Id: <20240920160551.52759-1-okorniev@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Current, the server returns that it supports NFS4_SHARE_WANT_DELEG_TIMESTAMPS
but when the client sends that on the open, knfsd returns back with
bad_xdr error.

Fixes: d0eab73d48a0 ("nfsd: add support for delegated timestamps")
Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
---
 fs/nfsd/nfs4xdr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index c0bad580ab6d..adda8b489175 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -1109,6 +1109,7 @@ static __be32 nfsd4_decode_share_access(struct nfsd4_compoundargs *argp, u32 *sh
 	case NFS4_SHARE_PUSH_DELEG_WHEN_UNCONTENDED:
 	case (NFS4_SHARE_SIGNAL_DELEG_WHEN_RESRC_AVAIL |
 	      NFS4_SHARE_PUSH_DELEG_WHEN_UNCONTENDED):
+	case NFS4_SHARE_WANT_DELEG_TIMESTAMPS:
 		return nfs_ok;
 	}
 	return nfserr_bad_xdr;
-- 
2.43.5


