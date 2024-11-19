Return-Path: <linux-nfs+bounces-8091-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1432B9D1CB6
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Nov 2024 01:47:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FB9F281E04
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Nov 2024 00:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDD0C847B;
	Tue, 19 Nov 2024 00:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LBhXxUxz"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3FB1196;
	Tue, 19 Nov 2024 00:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731977255; cv=none; b=jMKjC9yw/JMp+RNVEo+POJ78yJ67wdsyU5kxI6w8mYf8RLzMxSpPexfv1XEgsH6cf3uGFOPuGBS2bnJ4E14d2acd3XfozzyxHE8XjIJr+uF0pVN7HaMjZZMJoj/YQG6gWL3Jrj5fxt8stiY1YOE7HsGLFF9oJTLlLoGH8QI6Nqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731977255; c=relaxed/simple;
	bh=GFdywPDt/DV4WcBGDX/bMizY3+b0W7G7827H3STBdUw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Di0HQy7oe7aaRUJJmCEqXKfE/2wPW/zqGrhTknUi8Jqto+gu1mk+JUvTca63O1sCw3Vn3qlPgCd5hgndgM4jgvkZSFcrWeGLsn0tSFzhIeFF6mtWh2C+qP5919kEyq2w2R9qeqrPdtailDUDOECmKUh6gUDFL8JhyDj9LnkQ4HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LBhXxUxz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3A4EC4CECC;
	Tue, 19 Nov 2024 00:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731977255;
	bh=GFdywPDt/DV4WcBGDX/bMizY3+b0W7G7827H3STBdUw=;
	h=From:To:Cc:Subject:Date:From;
	b=LBhXxUxzcmDxIi5nBJFnc4wwrvCWeBUk5P8jZ3zjVWQWz/rtZOkFwllxylxerZ0Sh
	 Cq+D6olffIygsAPlJW89vtXLsTegnwfKAavMsfahyBSiq25JSKkPBQ3CBeCQomA7TL
	 ti9vNXQmL6Zkag3fDSB4FU+Pz2/E+3I8cwYs63fMiG8+oX/8wP1zVgloduJz24BIdV
	 MjCc+itQaB0lgQ+MCYR+GdCPjATAC7j5PcrLMptGjw+jZG/yeePCPKdfCCI3B762mp
	 awkJcHVtbLbSUAH9ictNqdHeqHxIkxF1ysv6FXdyz4KQOfyyJm9l0fL3z0AQ6S32PF
	 W1I2/ygtAIRjA==
From: cel@kernel.org
To: <stable@vger.kernel.org>
Cc: <linux-nfs@vger.kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 5.10 0/5] Address CVE-2024-49974
Date: Mon, 18 Nov 2024 19:47:27 -0500
Message-ID: <20241119004732.4703-1-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Backport the set of upstream patches that cap the number of
concurrent background NFSv4.2 COPY operations.

Chuck Lever (4):
  NFSD: Async COPY result needs to return a write verifier
  NFSD: Limit the number of concurrent async COPY operations
  NFSD: Initialize struct nfsd4_copy earlier
  NFSD: Never decrement pending_async_copies on error

Dai Ngo (1):
  NFSD: initialize copy->cp_clp early in nfsd4_copy for use by trace
    point

 fs/nfsd/netns.h     |  1 +
 fs/nfsd/nfs4proc.c  | 36 +++++++++++++++++-------------------
 fs/nfsd/nfs4state.c |  1 +
 fs/nfsd/xdr4.h      |  1 +
 4 files changed, 20 insertions(+), 19 deletions(-)

-- 
2.47.0


