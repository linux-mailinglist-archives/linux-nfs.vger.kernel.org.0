Return-Path: <linux-nfs+bounces-15813-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB6F7C22757
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Oct 2025 22:48:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAA7142244C
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Oct 2025 21:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01C0C2D0C9D;
	Thu, 30 Oct 2025 21:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eeVz26d6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5874B524D1
	for <linux-nfs@vger.kernel.org>; Thu, 30 Oct 2025 21:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761860887; cv=none; b=M3O3kUy/SZSNNJNOl/SGylovK0Ams1xm1ZMnhIKWHr65AuI/Axf4GvA7inw6uI6NdR6mWfc0MocnkP2LGbXLXgAEyvfFsoMqYiZyYqD68xyIUn18q3GLAatseFVHzzwJoCu88mJNuoDvjD6HA/9nmB6xYg9CtWvEhW6kokN6X4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761860887; c=relaxed/simple;
	bh=Ht7X23VN6k6agSE+ZkH5pR3ehihTyhv/hTaQfW0fgJI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O05p5ISUdmPOvHUAtjRYHr47Qp6uVqZNyl31Lvnn+4i5KdUO0yRh3HhGsTLtSmiQMMsklXSauF3O7Csxu7C5wY/JL6x+3ifKh/Y3McpxTZ/Au0ulBIt3QruuBe2ZLU1l3+Jw2jpspn7HYoUJN6SOLJSELSAQZs5+L0fl0O6XTao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eeVz26d6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761860884;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LO5uTik4CEqnxS5U7nKvbogbwdZysnFrHLiQBzSmiHM=;
	b=eeVz26d6rRVcaYUPsX4w17qfJtR3veBaiSAMhNKS8OKJH9+nYXbfdjplhIV3O7VvRB1QAS
	0HsF52qxaLoLTBRc09xXvAWGSgd5MnyeA7RLXz00n8R5OPVd0GEE5zIskdCXI3dxK0WoLS
	GKR1+CpuLoo+MWL4tieIB5+txliIQ+g=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-176-eSho8dm-MLmtuzSuzTECtg-1; Thu,
 30 Oct 2025 17:48:02 -0400
X-MC-Unique: eSho8dm-MLmtuzSuzTECtg-1
X-Mimecast-MFC-AGG-ID: eSho8dm-MLmtuzSuzTECtg_1761860881
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9595B1954B0C;
	Thu, 30 Oct 2025 21:48:01 +0000 (UTC)
Received: from okorniev-mac.redhat.com (unknown [10.22.64.252])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B583719540DA;
	Thu, 30 Oct 2025 21:48:00 +0000 (UTC)
From: Olga Kornievskaia <okorniev@redhat.com>
To: trondmy@kernel.org,
	anna@kernel.org
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v2 0/3] protect access to bc_serv
Date: Thu, 30 Oct 2025 17:47:56 -0400
Message-ID: <20251030214759.62746-1-okorniev@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

This patch series tries to address the problem that can arise when
the client is shutting down but gets a backchannel request. As it
stands now, In nfs4_shutdown_client() we call nfs4_destroy_callback()
which would destroy/free the bc_serv structure stored in an xprt
structure. But the xprt structure is still around for a bit until
it's destroyed. If we get backchannel request after svc_destroy()
is called, then in xprt_complete_bc_request() we are accessing freed
memory.

I propose to use bc_pa_lock lock to protect access to the bc_serv
structure and make sure we free/nullify bc_serv under the lock
and then access it under a lock in  xs_complete_bs_request() and
rpcrdma_bc_receive_call().

-- v2 fixing kernel test bot reported compile error in usage of
xprt_svc_destroy_nullify_bc (CONFIG_SUNRPC_BACKCHANNEL toggle related)

Olga Kornievskaia (3):
  NFSv4.1: pass transport for callback shutdown
  SUNRPC: protect access to rpc_xprt bc_serv
  NFSv4.1: protect destroying and nullifying bc_serv structure

 fs/nfs/callback.c                 | 11 +++++++++--
 fs/nfs/callback.h                 |  3 ++-
 fs/nfs/nfs4client.c               |  9 +++++++--
 include/linux/sunrpc/bc_xprt.h    |  1 +
 net/sunrpc/backchannel_rqst.c     | 27 ++++++++++++++++++++++++---
 net/sunrpc/xprtrdma/backchannel.c | 11 +++++++----
 6 files changed, 50 insertions(+), 12 deletions(-)

-- 
2.47.1


