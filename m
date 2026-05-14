Return-Path: <linux-nfs+bounces-21621-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UJaeG/M2BmqWgQIAu9opvQ
	(envelope-from <linux-nfs+bounces-21621-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 14 May 2026 22:56:19 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BC263546D91
	for <lists+linux-nfs@lfdr.de>; Thu, 14 May 2026 22:56:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D4E4F3001CFD
	for <lists+linux-nfs@lfdr.de>; Thu, 14 May 2026 20:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E5C83ACEE6;
	Thu, 14 May 2026 20:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uQSjHlB4"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BBA43F4121
	for <linux-nfs@vger.kernel.org>; Thu, 14 May 2026 20:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778792173; cv=none; b=Ush7kR8M4k0xqCJm+cbzes0kreHtqhmCIvtHdZZlSH/S3eRtPTndMf2xlSnCgdRwNrMk9fiwKq61p8nxvDkI1MJnCjyL86fIhIWybf5WsjGhHq/p6KN3s8zTRim+EV+gcusYfsjxhdBlAkfPmyumDTQCLIILWQ1zh7C7KQAoLUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778792173; c=relaxed/simple;
	bh=eTGVhUN1yoEIzXOs1o1O7X2xjU4YMGMQBTssZ7S3Cw0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sTbM5XjIxKjdODZZCHU4UwH12ARnbVvXdSiSEBk8HiQ/qXyis7rLq0eOVf18JXZ/8IiK6TnZ1Y6FZoW7wDaoDa/GP7bBHWf+5PC9bpTACgfR0ZMWT42VfHWcQu/tNNTCwQlEGXi+K1P7Z1Av+M5PGXp6xZpI7lVTOgHOu7EFml8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uQSjHlB4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65ABDC2BCB3;
	Thu, 14 May 2026 20:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778792173;
	bh=eTGVhUN1yoEIzXOs1o1O7X2xjU4YMGMQBTssZ7S3Cw0=;
	h=From:To:Cc:Subject:Date:From;
	b=uQSjHlB4VkmQrmly/p/q4TCQrGmy6QtUKOikgSTGBgs2hM8lEdLJ3HiS5TadEhLCy
	 z6N6XHm4XfUlPrHHnCXjTGBH20BbjDHwLy78s/IrXUe0wQ46vHa61y+qWPFNzQMryN
	 cNGuH/fkj9po75qBGDklcl9Rj+zxpLXOY+9yL+K3bV8G8O3xo9myTVN7NF0fxiNW/H
	 uM9QiX9prz+wOEW4RGwlcLQpSgSUAbQvYlAyO83lTtJxqP3N7PSkEhLnT6MRMostvx
	 kF+VO27IzCXgHP7kHG/wCsPLxvTxS7pxUXlzpzIZmq0c86sinrZTNahb4WkGOf0QJt
	 Nfumgsv1wANgg==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 0/3] three lockd fixes
Date: Thu, 14 May 2026 16:56:03 -0400
Message-ID: <20260514205607.348291-1-cel@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: BC263546D91
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21621-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,oracle.com:email]
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

Jeff reported an issue earlier today, and while crafting the fix,
LLM review found two more pre-existing nearby problems.

Chuck Lever (3):
  lockd: Plug nlm_file leak when nlm_do_fopen() fails
  lockd: Plug nlm_file refcount leak on cached nlm_do_fopen() failure
  lockd: Avoid hashing uninitialized bytes in nlm4svc_lookup_file()

 fs/lockd/lockd.h    | 8 ++++++++
 fs/lockd/svc4proc.c | 3 +++
 fs/lockd/svcsubs.c  | 7 ++++---
 3 files changed, 15 insertions(+), 3 deletions(-)

-- 
2.54.0


