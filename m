Return-Path: <linux-nfs+bounces-15970-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D73C2E3BB
	for <lists+linux-nfs@lfdr.de>; Mon, 03 Nov 2025 23:15:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C92E3BCF80
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Nov 2025 22:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18CEC2EF654;
	Mon,  3 Nov 2025 22:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A5Bmwd+R"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669F32DF122
	for <linux-nfs@vger.kernel.org>; Mon,  3 Nov 2025 22:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762208028; cv=none; b=ly1QCMenq74PvHYfax8z1OhBnUm57gIqgzlFIWhKj+q108Tqt6/dASIA8d3ov0fSaxoDrylEIjbCEWK7l8Y2irUCxb6N0PRmnzsSrntJwCqZOcrTVYyA/F5zzQa9y49hL1Fun3dwj9CUMB8GlJ6QEswsrFg1DFcRowQcId35wWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762208028; c=relaxed/simple;
	bh=ByczKYmulYNS+cX4RZRSWcTm5v4JqT1uNOY2i/DsZ78=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m4HPUdMi5ygGPzj8V9e11g1GtF7AkaIc5Y4ycQwGw1TkFxGPB9sI8a2lEIGgqswt74rYPpkU6LzUsfb8PeVCAtW6zhrQPjoLg3jijJOOAGRFb6Z1FxvBxBHaOnPPF1RJz5ouXOpkqaYF3ZcOYcaDRPLFXfX3Em3GzMxbmlt9ruQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A5Bmwd+R; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762208025;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bA9yZlLcsXhLFn/5IZHkfk40SMzinStlZ0RTMri/36k=;
	b=A5Bmwd+RMs4Xb46hm1wWODRNh+n6SYXE0JxR/b8+qM7WWiM9TQp7nCwf01+elhQdk3BnQq
	R2SLS9NhWB89b8Y4SGpdpw35ueBVjBycnxPeyCRtUUVPblH75i+XM78qnecZLR7s9InbC/
	tf9K5X7L1KwgEUUBgDKlJP0p5ybrocQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-61-Okkysmg5MwCXj_-7LJr3sA-1; Mon,
 03 Nov 2025 17:13:42 -0500
X-MC-Unique: Okkysmg5MwCXj_-7LJr3sA-1
X-Mimecast-MFC-AGG-ID: Okkysmg5MwCXj_-7LJr3sA_1762208021
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 217F219560A3;
	Mon,  3 Nov 2025 22:13:41 +0000 (UTC)
Received: from okorniev-mac.redhat.com (unknown [10.22.81.195])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5452219560A2;
	Mon,  3 Nov 2025 22:13:40 +0000 (UTC)
From: Olga Kornievskaia <okorniev@redhat.com>
To: trondmy@kernel.org,
	anna@kernel.org
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v3 0/4] protect access to bc_serv
Date: Mon,  3 Nov 2025 17:13:35 -0500
Message-ID: <20251103221339.45145-1-okorniev@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

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

-- v3 Addressing Anna'a comments. (1) created function for shared
code between tcp/rdma backchannel and (2) created
xprt_svc_destroy_nullify_bc() for both on/off CONFIG_SUNRPC_BACKCHANNEL
values.

-- v2 fixing kernel test bot reported compile error in usage of
xprt_svc_destroy_nullify_bc (CONFIG_SUNRPC_BACKCHANNEL toggle related)

Olga Kornievskaia (4):
  NFSv4.1: pass transport for callback shutdown
  SUNRPC: cleanup common code in backchannel request
  SUNRPC: new helper function for stopping backchannel server
  NFSv4.1: protect destroying and nullifying bc_serv structure

 fs/nfs/callback.c                 |  7 +++++--
 fs/nfs/callback.h                 |  3 ++-
 fs/nfs/nfs4client.c               |  9 ++++++--
 include/linux/sunrpc/bc_xprt.h    |  6 ++++++
 net/sunrpc/backchannel_rqst.c     | 35 ++++++++++++++++++++++++++++---
 net/sunrpc/xprtrdma/backchannel.c |  8 ++-----
 6 files changed, 54 insertions(+), 14 deletions(-)

-- 
2.47.1


