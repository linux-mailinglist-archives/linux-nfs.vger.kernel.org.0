Return-Path: <linux-nfs+bounces-9255-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BBAAA12C91
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Jan 2025 21:30:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB72B3A5B09
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Jan 2025 20:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4D0E191F75;
	Wed, 15 Jan 2025 20:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Medl7aId"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00E68F77
	for <linux-nfs@vger.kernel.org>; Wed, 15 Jan 2025 20:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736972998; cv=none; b=pqikhhbOgHBKjD5VrEpEqSA98jYjIXGpUHndT1rDyaNq/7xs3GBXFgQH2it9+P8RptRVw1kpu2/LJFmknQdx6UvJk8sgPwWiOKZ6rbuEJApGqKrX5kh3BQPn+Ij5U1zX8D2vt3/Ktp2cD0K8i7jA/MqSIcmpbKq1QqzF18giULw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736972998; c=relaxed/simple;
	bh=F5ff8X1e8PfyeY+UVXfjNDBLECahSlK0QsjCSEYq71g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dB6pFoviK+ZJ7zEcjUSWj+at6ACgF1TfZMkJKiPr2UFOAKIhkq8DVO8uEWf29W0gQpUe0aW5O9rg+NB2rlKad5eifrbcB/ZhN3CDZSBOMt19OAe4tSyzTnmgs7h89VRgevaM0yc4QXfEJ6uveX2TDbSXnWuZJVjHZH5vlCNXKQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Medl7aId; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6678C4CED1;
	Wed, 15 Jan 2025 20:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736972998;
	bh=F5ff8X1e8PfyeY+UVXfjNDBLECahSlK0QsjCSEYq71g=;
	h=From:To:Cc:Subject:Date:From;
	b=Medl7aId5eVj06w2i2h0ZyRxHNRKytGctRtT8PMpRJRD6cgpAiOVrDWW7n3udMn8F
	 Cm4CZ3tJrBr2DpFfxkmRjyl0JznWVYXKaf1BtO5K5sZb2QWzHHIK+m0qAxQS448VZv
	 PEkc0GvKqoXA+oacMPzbC4yVRA+Ry3ToGyzhSJ+AYKEbBNtS7l+JBH4lxRrkhrofsP
	 +fqe3Wws20QYHJOCTK8uEnbKPd2lRpKMQQZc6Z9EiBnTPInnASU5zd8vGPYQG+Vbq6
	 PCo5C5nVsYYVlH/liLrhm2Q/IdMy6cno+8HqLg7OTCZN2g+bBx8GAvjBCRWw0Paeex
	 tBQLUl1/X5Hbg==
From: Anna Schumaker <anna@kernel.org>
To: linux-nfs@vger.kernel.org,
	steved@redhat.com
Cc: anna@kernel.org
Subject: [PATCH nfs-utils v3 0/7] rpcctl: Flake8 cleanups
Date: Wed, 15 Jan 2025 15:29:49 -0500
Message-ID: <20250115202957.113352-1-anna@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Anna Schumaker <anna.schumaker@oracle.com>

Apologies for the noise. I just realized I gave the wrong range to `git
format-patch`, and accidentally resent somebody else's patch that has
already been merged.

This is a series of cleanups for rpcctl.py to fix up various style
issues after running `flake8` on the code.

Thoughts?
Anna


Anna Schumaker (7):
  rpcctl: Fix flake8 whitespace errors
  rpcctl: Fix flake8 line-too-long errors
  rpcctl: Fix flake8 bare exception error
  rpcctl: Fix flake8 ambiguous-variable-name error
  rpcctl: Add missing docstrings to the Xprt class
  rpcctl: Add missing docstrings to the XprtSwitch class
  rpcctl: Add remaining missing docstrings

 tools/rpcctl/rpcctl.py | 107 ++++++++++++++++++++++++++++++-----------
 1 file changed, 80 insertions(+), 27 deletions(-)

-- 
2.48.1


