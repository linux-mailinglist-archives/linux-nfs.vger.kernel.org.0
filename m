Return-Path: <linux-nfs+bounces-2370-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3902687EBC4
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Mar 2024 16:11:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C016A281AA1
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Mar 2024 15:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 732B228DD6;
	Mon, 18 Mar 2024 15:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d1aNVn7q"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54854EB50
	for <linux-nfs@vger.kernel.org>; Mon, 18 Mar 2024 15:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710774666; cv=none; b=N9CTqU08iD/p58fY3M460WSWW/ghQQdCqO3kT/wQITyOfBr7T5ChSn5YvcOsAXby8LWVkY0zjeoRgF6Whko983FYKjoCcWIfJwX0RpeUQpWYxUnJfszHyUM0Qm8EniswWeTREKUBVWa+ae/w2Nrgh2r5/wgQtef4Ilu3P8IBgPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710774666; c=relaxed/simple;
	bh=LPtwYLTuqJc5BBsInh5pQG8uaHeNhPG49+HQ7eFv0g0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=bd90aNe8jDV/+/dvzEGrExjHQ42h+vBG9EAyAXoJMOOSKVBunRbJtM8Fq7PBYj3Uq/BJ9CdSD8v6p1l0o8kRbdo0AIBn/2AKsgO3aFm1CbZEgqfFUDPWzGZIEHxuBEHW7Sm4eHtUyynCjaANMMWEM6Ztum5GhWs5HAz8R2j1wAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d1aNVn7q; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710774663;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tc9nRWLZD0aDllGvcK6WcmcK7F36+buIaYlg8CfGE9w=;
	b=d1aNVn7qV8AV+jFlwgx/UBZxvU3fYgNbZV/JJMY2G/UTehRsQqaQuADiFCjI6joYLsa/So
	JXrceYLF27+cGoQw7OTo/pWmTR8yUutUU62AfxVzbnj+FlTJnrkhKLRDLrtdv/N346/j31
	PwQ9PWZcT+Q9IEUQrEiVtw5eXhpaZ7I=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-651-31Bv8g_lPEulaFsjLjWVbQ-1; Mon,
 18 Mar 2024 11:11:01 -0400
X-MC-Unique: 31Bv8g_lPEulaFsjLjWVbQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7C6C03C0D7BA
	for <linux-nfs@vger.kernel.org>; Mon, 18 Mar 2024 15:11:01 +0000 (UTC)
Received: from bighat.boston.devel.redhat.com (bighat.boston.devel.redhat.com [10.19.60.48])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 68B92200AFA3
	for <linux-nfs@vger.kernel.org>; Mon, 18 Mar 2024 15:11:01 +0000 (UTC)
From: Steve Dickson <steved@redhat.com>
To: Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [PATCH] rpcb_clnt.c: memory leak in destroy_addr
Date: Mon, 18 Mar 2024 11:11:01 -0400
Message-ID: <20240318151101.11043-1-steved@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

From: Herb Wartens <wartens2@llnl.gov>

Piece was dropped from original fix.

Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=2225226
Signed-off-by: Steve Dickson <steved@redhat.com>
---
 src/rpcb_clnt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/rpcb_clnt.c b/src/rpcb_clnt.c
index 68fe69a..d909efc 100644
--- a/src/rpcb_clnt.c
+++ b/src/rpcb_clnt.c
@@ -121,6 +121,7 @@ destroy_addr(addr)
 			free(addr->ac_taddr->buf);
 			addr->ac_taddr->buf = NULL;
 		}
+		free(addr->ac_taddr);
 		addr->ac_taddr = NULL;
 	}
 	free(addr);
-- 
2.44.0


