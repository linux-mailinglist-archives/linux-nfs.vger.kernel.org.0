Return-Path: <linux-nfs+bounces-15713-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27495C11006
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Oct 2025 20:29:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39E8B19A3C49
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Oct 2025 19:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D600D30C62D;
	Mon, 27 Oct 2025 19:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GgxUq529"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A1827FD62
	for <linux-nfs@vger.kernel.org>; Mon, 27 Oct 2025 19:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761593006; cv=none; b=YQEP6TumJiTKpM7IHmYUjyc/a0QhD5zMgNMgdgHy6uYau1qMlpa4+OoaZw/a8bcerlLMtcG1KSZd5PWP7sVEwOdqEvLt+lwNLXjx1nFKVqnU24KSH69OHVIfXxGIykmAzAM+YBUtLZsTeDh9matwYRb7CMbClM2NaBsE+tWssKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761593006; c=relaxed/simple;
	bh=aL7qkg9EfNeu95K6kqSUNI2c+naRvw6phU+BM8/XJ74=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VcfoxDu2fY6PirXxautKMexZLjYmaMtUSB4/TDgSqYH95SgS/QPEQQOywJup7CogGJ5vaX1TvsfEFHm0ukR+BVJOjTQpH1J2YXZKZYmtdsZ2aEutJgIMPMjgPwuZuL6O/kFiHvtwjmwkgD9TUbqJH0oGvtC7cmsHAaYde30yTVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GgxUq529; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761593004;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TyRUar5sZcocPwlcZaoYklo/kuVr4bKrMWohKiUGc1Q=;
	b=GgxUq529l0r5yGC2bu9jVbnzffeuwiutxvWit1a5heLyFc+t2NBH4v3fCjSGTz1IzLh/v3
	KLeGh0sQZ8inuU6b2aQ6Yp9cHlrhUhh9Tre4w8Y4ibTt/5yrMTYmSHCPCZIvR0ZKwk7Spq
	0POHpbbLfqoh38P3BzBr7sr3EjnfJ8E=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-614-qbrp9E6_OP-dtGy7qfx-yQ-1; Mon,
 27 Oct 2025 15:23:21 -0400
X-MC-Unique: qbrp9E6_OP-dtGy7qfx-yQ-1
X-Mimecast-MFC-AGG-ID: qbrp9E6_OP-dtGy7qfx-yQ_1761593000
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 508B11801360;
	Mon, 27 Oct 2025 19:23:20 +0000 (UTC)
Received: from okorniev-mac.redhat.com (unknown [10.22.89.72])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 22ED330001A2;
	Mon, 27 Oct 2025 19:23:18 +0000 (UTC)
From: Olga Kornievskaia <okorniev@redhat.com>
To: trondmy@kernel.org,
	anna@kernel.org
Cc: linux-nfs@vger.kernel.org
Subject: [RFC PATCH 0/3] protect access to bc_serv
Date: Mon, 27 Oct 2025 15:23:15 -0400
Message-ID: <20251027192318.86366-1-okorniev@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

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

Olga Kornievskaia (3):
  NFSv4.1: pass transport for callback shutdown
  SUNRPC: protect access to rpc_xprt bc_serv
  NFSv4.1: protect destroying and nullifying bc_serv structure

 fs/nfs/callback.c                 |  7 +++++--
 fs/nfs/callback.h                 |  3 ++-
 fs/nfs/nfs4client.c               |  9 +++++++--
 include/linux/sunrpc/bc_xprt.h    |  1 +
 net/sunrpc/backchannel_rqst.c     | 27 ++++++++++++++++++++++++---
 net/sunrpc/xprtrdma/backchannel.c | 11 +++++++----
 6 files changed, 46 insertions(+), 12 deletions(-)

-- 
2.47.1


