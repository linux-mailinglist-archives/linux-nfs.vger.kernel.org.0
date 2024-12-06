Return-Path: <linux-nfs+bounces-8402-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 503909E7B6E
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Dec 2024 23:12:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BA6E16A041
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Dec 2024 22:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 166641E2007;
	Fri,  6 Dec 2024 22:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hyub.org header.i=@hyub.org header.b="t1Y2TObz"
X-Original-To: linux-nfs@vger.kernel.org
Received: from hyub.org (hyub.org [45.33.94.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DCCC22C6C0
	for <linux-nfs@vger.kernel.org>; Fri,  6 Dec 2024 22:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.33.94.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733523170; cv=none; b=bqgD+XVA2ie3VHlh7sYAPc5vdSD5GnLcb76YvaPBtaQFE4Wk6fmZsagpxU+gjYzFTvpm4KxIDsWy/vGa/eD6zYjDtOSFyFuJf7PSDj9LGcKwfHD6vxHnFMoNL6Z8ZoCgRPJ2TZMUGLe63OBHTcR3cYz1tPSUDX2yaCqtrFnNXz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733523170; c=relaxed/simple;
	bh=uD5u+DDja1KSzz2v5g8CwudHCF/Msl9v0aWeiddDo/M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i9Xmb8pGxKli+GONjjKwjwXO6x1lavg6gCmgzCOjnw/Grpw4wXHgeTu9KZlp3/wpd2Dm+6gabXWpS0Amad4BIz/KVPHPie6rcfIG28UL7oUwmBNpJwsSB2vV/sIKSSRZENKYjeFfovwUNC4Yuplc6NNd9gc4EMspWGdgHSynlw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hyub.org; spf=pass smtp.mailfrom=hyub.org; dkim=pass (2048-bit key) header.d=hyub.org header.i=@hyub.org header.b=t1Y2TObz; arc=none smtp.client-ip=45.33.94.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hyub.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hyub.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hyub.org; s=dkim;
	t=1733523160;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EYFLzz+xiRzwaWZryCofz5R6HWzz8+Eqiro0UqmLN9Y=;
	b=t1Y2TObz+X+bg3r3Iw6RQBsjyWfF4IJDU0m25Z0cFEj7gCl9bruzMQhlp23dU2/oz8f/UZ
	ok0g4A/EB1F9S/sZLjS6sbPvasqwYQlff6xI7kIqahHt628ZdYYg2JpdZX+p9dYwunAILv
	w0lQvHBZjM2PJTC/Lr6ZEZLxNdZj0HhXQqYfNardGuwhuTr6lyELcv40mY9mD7OjB0MtnC
	Zp+I8XpxTtUolr2rFgutfx0tmXc1dxiAm9MPR8OxL6eE0YlL8QWBcoeZ4iSx38Ry1czyA+
	diLtOB+K9OV7KvXSh0XQArK0uF+bkK3zV8q6e5M9cFOqSdGUFdBc9rG9ZZ50ZA==
From: Christopher Bii <christopherbii@hyub.org>
To: steved@redhat.com
Cc: Christopher Bii <christopherbii@hyub.org>,
	linux-nfs@vger.kernel.org
Subject: [PATCH 0/5] nfs export symlink vulnerability fix (duplicate(ish))
Date: Fri,  6 Dec 2024 17:11:52 -0500
Message-ID: <20241206221202.31507-1-christopherbii@hyub.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

It is hinted in the configuration files that an attacker could gain access
to arbitrary folders by guessing symlink paths that match exported dirs,
but this is not the case. They can get access to the root export with
certainty by simply symlinking to "../../../../../../../", which will
always return "/".

This is due to realpath() being called in the main thread which isn't
chrooted, concatenating the result with the export root to create the
export entry's final absolute path which the kernel then exports.

PS: I already sent this patch to the mailing list about the same subject
but it was poorly formatted. Changes were merged into a single commit. I
have broken it up into smaller commits and made the patch into a single
thread. Pardon the mistake, first contribution.

Thanks

Christopher Bii (5):
  nfsd_path.h - nfsd_path.c: - Configured export rootdir must now be an
    absolute path - Rootdir is into a global variable what will also be
    used to retrieve   it later on - nfsd_path_nfsd_rootdir(void) is
    simplified with nfsd_path_rootdir   which returns the global var
    rather than reprobing config for rootdir   entry
  nfsd_path.c: - Simplification of nfsd_path_strip_root(char*)
  nfsd_path.h - nfsd_path.c: - nfsd_path_prepend_dir(const char*, const
    char*) -> nfsd_path_prepend_root(const char*)
  NFS export symlink vulnerability fix - Replaced dangerous use of
    realpath within support/nfs/export.c with   nfsd_realpath variant
    that is executed within the chrooted thread   rather than main
    thread. - Implemented nfsd_path.h methods to work securely within
    chrooted thread   using nfsd_run_task() helper
  support/nfs/exports.c - Small changes

 support/export/export.c     |  17 +-
 support/include/nfsd_path.h |   9 +-
 support/misc/nfsd_path.c    | 362 ++++++++++++------------------------
 support/nfs/exports.c       |  49 ++---
 4 files changed, 151 insertions(+), 286 deletions(-)

-- 
2.47.1


