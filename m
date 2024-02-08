Return-Path: <linux-nfs+bounces-1861-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C41B84E496
	for <lists+linux-nfs@lfdr.de>; Thu,  8 Feb 2024 17:00:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E830FB25E1F
	for <lists+linux-nfs@lfdr.de>; Thu,  8 Feb 2024 16:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE1FF7EEE9;
	Thu,  8 Feb 2024 16:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tjJ1q7Jj"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93B97D40E
	for <linux-nfs@vger.kernel.org>; Thu,  8 Feb 2024 16:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707408024; cv=none; b=Q0j9NQ5tyEU6iudQjpHupiio5zHmLJ8Yr8oE/j4vT4BpIXI3B720WCEmglk6/ZmZfLSOVJxY03QgTp+CJbSwOrEMnx4PevExrSLR8CyqcsHdIszEPwqRhPdqnTwG6T38nNQVLi1oaW3+mOEsR7Dcx3GrOXcv2qSgvTN+MI2ILxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707408024; c=relaxed/simple;
	bh=yecoeZxjLtVqZFmJnu+jXoX5CbRt1O2OfxHEZ8Gxy8Q=;
	h=Subject:From:To:Date:Message-ID:MIME-Version:Content-Type; b=Dl8T40PDqcSngzcCMIMvz4/J1+xmy1zypgd5eW/JbDVB0J73nuWqBd0MfGt/OloQxbGRRZl01FF0dpF8Yhv2QyvOheuLRNY5fn2c5ke2nch3LGTkFhYwEn6YtjAW3CerdFYLRRJakJXisAOgKVsS6JnR8gLYk1PBkRTktaLw3n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tjJ1q7Jj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A952C433C7
	for <linux-nfs@vger.kernel.org>; Thu,  8 Feb 2024 16:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707408024;
	bh=yecoeZxjLtVqZFmJnu+jXoX5CbRt1O2OfxHEZ8Gxy8Q=;
	h=Subject:From:To:Date:From;
	b=tjJ1q7JjsTYDtA/zBF8ctd6bBgvaaPSNuEViync2fb/Z7zOZKiZtP8pmsE1ewgm+u
	 9LuLDhRKmZ7uzsJID2/Eo5upNw5YCnEls/vHNZLOD3qt5fpHmlfKhkbNI2Vu+6YlYW
	 LSkhzao74TdAQJ9SxL+zX6h37YuH3sboSBTSlILmT25tjKBhC/zNOectXEmjANxjL2
	 /gCeDfYb7She+eUC5ok211SResEWoEFfy8+icaEj7+h1rxvpamAlC5s8onGaweNZ/l
	 FHNePomQcmlmsfMp/By57kiOP48X7vAEr6Z7fS5/y3nPn9veQA3pX2fZ9XU+cVqVZO
	 qG2JqPEnd5aMQ==
Subject: [PATCH v1 0/2] Fix CREATE_SESSION
From: Chuck Lever <cel@kernel.org>
To: linux-nfs@vger.kernel.org
Date: Thu, 08 Feb 2024 11:00:23 -0500
Message-ID: 
 <170740799184.2139.1775683633369731917.stgit@manet.1015granger.net>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

NFSD's CREATE_SESSION implementation does not follow spec. Here
are a couple of patches to get it back into compliance.

---

Chuck Lever (2):
      NFSD: Fix the NFSv4.1 CREATE_SESSION operation
      NFSD: Document the phases of CREATE_SESSION


 fs/nfsd/nfs4state.c | 63 ++++++++++++++++++++++++++-------------------
 1 file changed, 37 insertions(+), 26 deletions(-)

--
Chuck Lever


