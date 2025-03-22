Return-Path: <linux-nfs+bounces-10752-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D85A6C69E
	for <lists+linux-nfs@lfdr.de>; Sat, 22 Mar 2025 01:13:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DEB67A61EA
	for <lists+linux-nfs@lfdr.de>; Sat, 22 Mar 2025 00:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CF39800;
	Sat, 22 Mar 2025 00:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c1ZjCW60"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767EA173
	for <linux-nfs@vger.kernel.org>; Sat, 22 Mar 2025 00:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742602400; cv=none; b=U1h2W+NF0PMbvKojTxTlZzMts6KOIZcD1otEUOHhvKGtSBk/9h3VqLEQFQMBO7duRc4hs6kZdTd5t47ljwLAiXRR6YpDqVmaTCueVDw53eRnrcS20tpcHyVqW3xcn6Q7Sp4iYp7iegLsbpt0B+nBgz7lr4CNWUyzA8SPFfdikMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742602400; c=relaxed/simple;
	bh=cuojYw/bjJFs6O1TXb2FT2k/rDSrUyhikEpmK8QZKIg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hWVEJVC4J5UOh7EIGMkMW8HadNEm5K0qZg0TilQ75PC2sQdsoIeTpb2t3T8iv0vQapggXnoYG4R4LkvXKBi4uyQiGXI2czvAdsIDGX7Jx1VtPza2/J4s+nim1UiBCadlQAL18N0cKd9qTWQxWOHonX49mY4J9LBBimeRyyejEeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c1ZjCW60; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742602397;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=cQJ+lzgEYH4sP69fVO2yd/Sph/s5evrYSxKLFzMXbTQ=;
	b=c1ZjCW60fEAnDM9RxiWJ15+vQCwX2AtiPjSzNtj4o7CLHILnwgvZXS/ZeR1ya/oFdOE9T9
	9pEMcjCPhn7vNRf+CgQDq6yZcl5AOfXjs9UHUMg6AT7PEZqs68SeMpdX4KAbL2LCwJonpD
	R3U2Su/ilBIZ+SseEfyBscVbp7tPsbQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-116-_WSvFwlwNQq-k32A9rnh3A-1; Fri,
 21 Mar 2025 20:13:11 -0400
X-MC-Unique: _WSvFwlwNQq-k32A9rnh3A-1
X-Mimecast-MFC-AGG-ID: _WSvFwlwNQq-k32A9rnh3A_1742602390
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 82D741800EC5;
	Sat, 22 Mar 2025 00:13:10 +0000 (UTC)
Received: from okorniev-mac.redhat.com (unknown [10.22.64.19])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id ECDE919560AF;
	Sat, 22 Mar 2025 00:13:08 +0000 (UTC)
From: Olga Kornievskaia <okorniev@redhat.com>
To: chuck.lever@oracle.com,
	jlayton@kernel.org
Cc: linux-nfs@vger.kernel.org,
	neilb@suse.de,
	Dai.Ngo@oracle.com,
	tom@talpey.com,
	Olga Kornievskaia <okorniev@redhat.com>
Subject: [PATCH 0/3] access checking fixes for NLM under security policies
Date: Fri, 21 Mar 2025 20:13:03 -0400
Message-Id: <20250322001306.41666-1-okorniev@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Since commit 4cc9b9f2bf4df ("nfsd: refine and rename NFSD_MAY_LOCK")
for export policies with "sec=krb5:..." or "xprtsec=tls:.." NLM
locking calls on v3 mounts fail. And for "sec=krb5" NLM calls it
also leads to out-of-bounds reference while in check_nfsd_access().

This patch series address 3 problems.

The first patch addresses a problem related to a TLS export
policy. NLM call dont come over TLS and thus dont pass the
TLS checks in check_nfsd_access() leading to access being
denied. Instead rely on may_bypass_gss to indicate NLM and
allow access checking to continue.

The other 2 patches are for problems related to sec=krb5.
The 2nd patch is because previously for NLM check_nfsd_access()
was never called and thus nfsd4_spo_must_allow() function wasn't
called. After the patch, this lead to NLM call which has no
compound state structure created trying to dereference it.
This patch instead moves the call to after may_bypass_gss
check which implies NLM and would return there and would
never get to calling nfsd4_spo_must_allow().

The last patch is fixing what "access" content is being passed
into the inode_permission(). Prior to 4cc9b9f2bf4df, the code would
explicitly set access to be read/ownership. And after is passes
access that's set in nlm_fopen but it's lacking read access.

Olga Kornievskaia (3):
  nfsd: fix access checking for NLM under XPRTSEC policies
  nfsd: adjust nfsd4_spo_must_allow checking order
  nfsd: reset access mask for NLM calls in nfsd_permission

 fs/nfsd/export.c | 20 ++++++++++----------
 fs/nfsd/vfs.c    |  7 +++++++
 2 files changed, 17 insertions(+), 10 deletions(-)

-- 
2.47.1


