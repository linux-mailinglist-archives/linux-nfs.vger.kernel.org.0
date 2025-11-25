Return-Path: <linux-nfs+bounces-16715-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64AEEC86DA1
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Nov 2025 20:49:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 190DC3B3E38
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Nov 2025 19:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF06F284671;
	Tue, 25 Nov 2025 19:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mzAbKZ8d"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89EC92528FD
	for <linux-nfs@vger.kernel.org>; Tue, 25 Nov 2025 19:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764100180; cv=none; b=BSIvTx1KHcduEupVbxyJzCPHVK4awrv+b0BhRuzogg/Uk/nel3NbyZHpMv849tVxHuSk2YnthqiHP9omYiQnX3eo8bTvD6ttm1mCNyafdT+T2XtN6cEfTX3SJO0nmzZzPjGdcOEQRZtu3S4tI7cisV8TtOEyozA3xxisqOUdgaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764100180; c=relaxed/simple;
	bh=DsGbqvdX6rYNgmSwz25TFSR1eGqN6XLSZj0t619QlSc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fKepldvheglJH0RP9sCwp5ojFeEQpVywLBQJVPBMkIRevXWTZadq152WvOj7vKR37IwcQ7HEEqefaJvlp0Y+gc9gkXIRgxo8Gup7tBgMLzLavUlVYRLIgxjeIac2BcdmDIr7j3co9ORBxZKghtaY3l1SBM4LghR9VVcSNUZQbcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mzAbKZ8d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C63C2C4CEF1;
	Tue, 25 Nov 2025 19:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764100180;
	bh=DsGbqvdX6rYNgmSwz25TFSR1eGqN6XLSZj0t619QlSc=;
	h=From:To:Cc:Subject:Date:From;
	b=mzAbKZ8dNByJziWhjPwVpLZ/iZ4AqWM0eyG4Rn6MbgQBPhXNPliLNibgFjJJmH8sd
	 MZuqbzicVKZhBxA8R1PSiKd4H7F+nYBrOniFe7vgYm4sn90YWQeMyMmFnDnE0yie5Z
	 D7PsX3xRKiOzJ0Pjo0H2sPOJ8ugTwdmGHrOGYdM4Mn7OlwJjKUH8uEGtmJHG6tJm5k
	 ju02LGLGtCKV3GY7M28iYBrp4pB+HYFxVMxgIVig/8L2xM5TdQcs9J27WZYA11rJ5d
	 R/kIeEeMeC9Lb2yPMOwLLqMbln131Q2q4TgDxTFgiGQ9ltwNqqiwnHLWrqXTLyzz6K
	 9XpFu3bQq5P4g==
From: Chuck Lever <cel@kernel.org>
To: <linux-nfs@vger.kernel.org>
Cc: Calum Mackay <calum.mackay@oracle.com>,
	aurelien.couderc2002@gmail.com,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 0/9] pynfs tests for setting ACL+MODE
Date: Tue, 25 Nov 2025 14:49:25 -0500
Message-ID: <20251125194936.770792-1-cel@kernel.org>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

There are plenty of corner cases when an NFSv4 client requests
setting an NFSv4 ACL and POSIX mode bits in the a single SETATTR
request. It's even worse for NFS server implementations that have
to translate NFSv4 ACLs to POSIX ACLs.

Note that the in-kernel Linux NFS client itself does not support 
NFSv4 ACLs since Linux is a POSIX ACL ecosystem. I believe it will
never send an OPEN(create) or SETATTR that sets an NFSv4 ACL and
mode bits simultaneously, relying on only user space tooling to set
the ACL. So we must depend on only pynfs for testing this particular
NFSD facility.

pynfs didn't have many tests in this particular category when I set
out to troubleshoot a recently reported ACL+MODE bug in NFSD. So
I've written a handful to exercise this specific case.

Changes since RFC:
* De-duplicate code shared between NFSv4.0 and NFSv4.1
* Remove named principals tests for now
* Replace incorrect usage of binary strings
* Add missing patch descriptions

Chuck Lever (9):
  Add helper to report unsupported protocol features
  Add helper to format attribute bitmaps
  Add a helper to compute POSIX mode bits from NFSv4 ACLs
  Add access_mask_to_str() helper to nfs4.0/nfs4acl.py
  Add make_test_acl() helper to nfs4acl modules
  Add verify_acl() helper to nfs4acl modules
  Add verify_mode_and_acl() helper to nfs4acl modules
  Add tests for SETATTR with MODE and ACL
  Add tests for OPEN(create) with ACLs

 nfs4.0/nfs4acl.py                   | 180 ++++++
 nfs4.0/servertests/st_setattr.py    | 863 +++++++++++++++++++++++++++-
 nfs4.1/nfs4acl.py                   |   1 +
 nfs4.1/nfs4lib.py                   |   8 +
 nfs4.1/server41tests/environment.py |   3 +
 nfs4.1/server41tests/st_open.py     | 723 ++++++++++++++++++++++-
 6 files changed, 1774 insertions(+), 4 deletions(-)
 create mode 120000 nfs4.1/nfs4acl.py

-- 
2.51.1


