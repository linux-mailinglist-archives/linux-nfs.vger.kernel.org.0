Return-Path: <linux-nfs+bounces-16680-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B2E8C7E2FC
	for <lists+linux-nfs@lfdr.de>; Sun, 23 Nov 2025 16:56:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E6A544E0F48
	for <lists+linux-nfs@lfdr.de>; Sun, 23 Nov 2025 15:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE5BE224AE0;
	Sun, 23 Nov 2025 15:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dhDGZlr8"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90D41B4F2C
	for <linux-nfs@vger.kernel.org>; Sun, 23 Nov 2025 15:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763913387; cv=none; b=Y0BB1UlOo0xLLogTnvp0LYmSo/xhBlSUkyUaf5bkBDKxhCVSAWErHQmjojlOfheh3hx2TMIKd47zfuOyoW3AXOz/WcySi5VA3dwvFXogkWulPSen51u6559cztUQEb5zv1uRr9vnrWX01TMn4jnwm8d+teEqKKeUwKdHWCmxyBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763913387; c=relaxed/simple;
	bh=Vk3PUYtS80f1yqN7dCOt+usK+mO3WwcBi4lr9JT0Ogc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Lxd1sq7+xlWM/R2ywTmJ7Af8WZnkfLxsNObOd0uQuqbik4idXo2M4D72jSXfuXjlLtNyh8aFajRgwmWmh0G4tLKWP7T2wYVHr9qxW5FJUwq8ICJrrhAResoQaXhIeqfyUlPf0leyHrKQsovFY2ceyh0BWg+gzShwQHsyDbcwdjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dhDGZlr8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0F7BC113D0;
	Sun, 23 Nov 2025 15:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763913387;
	bh=Vk3PUYtS80f1yqN7dCOt+usK+mO3WwcBi4lr9JT0Ogc=;
	h=From:To:Cc:Subject:Date:From;
	b=dhDGZlr8TAaeTm4OqoYSUDeZAgq/NFHN/JPMWotdCCMU1Gr1zOnLLziG6BQ7tHFNk
	 JpLdMz4sgfWsenb9AGn65Jjn6MacdMI5330ofAKJFi086QSKRFYuw1G7LyQOaLMfcp
	 oscJh7CMyjM2VkutJEPWuMWDTVoDBDcHoHJJX4StTW0q9WrDO6DRmY/Z+RYuPl1m4o
	 Qda/O8cvvKernvGXvpAi3nqSlUekhICwzUfhdEvJUQfexuf8B0cmZZdc8LWvpVqQdx
	 pLNUzLd5RbqLy6ThDdvFNy/TfljD1VRfmCYmhRWbf7nODqhZFtNNLsBZZHUSr29HUO
	 FknNPs4Lb0HWw==
From: Chuck Lever <cel@kernel.org>
To: Calum Mackay <calum.mackay@oracle.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [RFC PATCH 00/10] pynfs tests for setting ACL+MODE
Date: Sun, 23 Nov 2025 10:56:08 -0500
Message-ID: <20251123155623.514129-1-cel@kernel.org>
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
the ACL. So we must depend on pynfs for testing this server feature.

pynfs didn't have many tests in this particular category when I set
out to troubleshoot a recently reported ACL+MODE bug in NFSD. So
I've written a handful to exercise this specific case.

These are RFC, so Calum, let's hold off on applying these until
they've had some review.

Chuck Lever (10):
  Add helper to report unsupported protocol features
  Add helper to format ACE access masks
  Add helper to format attribute bitmaps
  Add a helper to compute POSIX mode bits from NFSv4 ACLs
  Add make_test_acl() helper to nfs4acl modules
  Add access_mask_to_str() helper to nfs4.0/nfs4acl.py
  Add verify_acl() helper to nfs4acl modules
  Add verify_mode_and_acl() helper to nfs4acl modules
  Add tests for SETATTR with MODE and ACL
  Add tests for OPEN(create) with ACLs

 nfs4.0/nfs4acl.py                   | 180 ++++++
 nfs4.0/servertests/st_setattr.py    | 844 +++++++++++++++++++++++++++-
 nfs4.1/nfs4acl.py                   | 188 +++++++
 nfs4.1/nfs4lib.py                   |  69 +++
 nfs4.1/server41tests/environment.py |   3 +
 nfs4.1/server41tests/st_open.py     | 723 +++++++++++++++++++++++-
 6 files changed, 2003 insertions(+), 4 deletions(-)
 create mode 100644 nfs4.1/nfs4acl.py

-- 
2.51.1


