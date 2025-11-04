Return-Path: <linux-nfs+bounces-16034-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70683C333D4
	for <lists+linux-nfs@lfdr.de>; Tue, 04 Nov 2025 23:31:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EF453A392D
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Nov 2025 22:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A414526A1BE;
	Tue,  4 Nov 2025 22:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a6TN3mJ0"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C353A2FABFA
	for <linux-nfs@vger.kernel.org>; Tue,  4 Nov 2025 22:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762295374; cv=none; b=jRzF2WHP54G7n3CNWWzi8b74S4ncoF3A6AHMBDAD6hY+Vr5vdL3HzpA/Ik0t9WthaqAO7RZ6XM1cH9kDN/1xp22WpcpC4W7R7bUlJSWFR/5OOYe8yTqMnmKAYBO9A4JUTXEYPNyKEGv2UdHh94wTACKeuD+IlfBRjxzbfc3wzYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762295374; c=relaxed/simple;
	bh=w9h/z9fbCh/qYKs2PgDP6pO4yZvzQEkX+1ei7XKdVfM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eF5jZXdXyhi/Pchp5GICAMH+zeUuDgmdnsWOw7AUtXPBiJcX6SdfcLtAjFt0vID6wfq3mDxpjq5Qz8Vy7H1kzxwrbe2k7fsRBycL7qACDjfl5eRLS39+jsZeb63UI9Ed0DDWcYS2dkjqt9qHxWtwNtL9Y3ZstBFLfClQA2NxuvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a6TN3mJ0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762295371;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ujiv6NlUUypo9YYB1x5mXcHkfWjbQ4aN4g/N4935NBg=;
	b=a6TN3mJ0KBXaG686gUq8rNSyEonwz0iKwQAyEyAC+1vmmjpwNjXxFtX4KtBC6pBEmT+7wt
	zfHejJPJaoEOV9qKrYPQX4i56p+uXJFjNjFe+WRAMxYUE0BaMsUnAOYUDxnqxALhSWdpqV
	dzIwjh9n/uuhl2JgL7bWApPpq0a2CcA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-556-AXop4JRxOLSzI-cWSuIByA-1; Tue,
 04 Nov 2025 17:29:30 -0500
X-MC-Unique: AXop4JRxOLSzI-cWSuIByA-1
X-Mimecast-MFC-AGG-ID: AXop4JRxOLSzI-cWSuIByA_1762295369
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3E9C8180035D;
	Tue,  4 Nov 2025 22:29:29 +0000 (UTC)
Received: from okorniev-mac.redhat.com (unknown [10.22.88.89])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 695791956056;
	Tue,  4 Nov 2025 22:29:28 +0000 (UTC)
From: Olga Kornievskaia <okorniev@redhat.com>
To: trondmy@kernel.org,
	anna@kernel.org
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v4 0/4] protect access to bc_serv
Date: Tue,  4 Nov 2025 17:29:23 -0500
Message-ID: <20251104222927.69423-1-okorniev@redhat.com>
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

-- v4 addressing Anna's comments and compile issue.

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

 fs/nfs/callback.c                 |  4 ++--
 fs/nfs/callback.h                 |  3 ++-
 fs/nfs/nfs4client.c               |  9 ++++++--
 include/linux/sunrpc/bc_xprt.h    |  7 +++++++
 net/sunrpc/backchannel_rqst.c     | 35 ++++++++++++++++++++++++++++---
 net/sunrpc/xprtrdma/backchannel.c |  8 ++-----
 6 files changed, 52 insertions(+), 14 deletions(-)

-- 
2.47.1


