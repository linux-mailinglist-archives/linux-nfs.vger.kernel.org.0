Return-Path: <linux-nfs+bounces-14154-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E99F6B50944
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Sep 2025 01:33:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A971754111C
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Sep 2025 23:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19799213236;
	Tue,  9 Sep 2025 23:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OovwCs0U"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98202B9B9
	for <linux-nfs@vger.kernel.org>; Tue,  9 Sep 2025 23:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757460797; cv=none; b=MJaXzEh837MTrgOOkwBRkIYJxnhXzdSiI3+A0SN83Ux+ok5ZD8rUbZZPRKyVFzN8s/prmz1h8aRUp0eD6R024PifNVNnzU4crBElJgJvfeLmiABotf3QZzlOiVmeloTJSsD9BkgDpq25CahbUGxL/S6STkywX2sFDdz3huHMCsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757460797; c=relaxed/simple;
	bh=QW8CLHUc6DrboAs1fonif0R6OUJwnH2kz6bPRgEbV7s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZOp7xJL2755dcAPtiahLMGpYi0Nelgw0zDORpCo3cYQQl3OZo1kVnU/ZTw9Cqfv71Fr6McP1hoIAZTmqCD0Zc7glC/+b6KU7sEt+AgF4dUCAline6KYEuKU7KrfPIaOdl4U9UgQsZBixW3zSS7+sOsoT5KNf/CImBN87xA9jtcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OovwCs0U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F498C4CEF4;
	Tue,  9 Sep 2025 23:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757460796;
	bh=QW8CLHUc6DrboAs1fonif0R6OUJwnH2kz6bPRgEbV7s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OovwCs0U2r7nVQNgV7BUpGwNCQMIF//UBiyoFToXEIrwRvUzo/VE0hc4utvCwLzPK
	 ODRHlCgRCRzT7y5wZOLoea/Q68gt+QovqlVWiIae+rAy9kFNX1ju3SQokauZ8cAvvu
	 QFx+v0lnMDhQ2awssxbuKHcJEIpbgJC8jgA+tHu4Ib5Gw+GwH6oCfqBocjz2tdDSbq
	 QoR4xWKTaVEewIGYlKEL3Au3/zPu2IAk5R/NDb+uxAYDRuPO4BCbpnWh41KXS1Ay/f
	 B7cKgQE+Urck4kVYsoOdlccKpU6N1GxitY7r698rbUeoE5Ycj8fcbTpOfCR8Kq6IOU
	 0fNU1XKgaZhrg==
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH 0/2] NFSD: continuation of NFSD DIRECT
Date: Tue,  9 Sep 2025 19:33:13 -0400
Message-ID: <20250909233315.80318-1-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20250909190525.7214-1-cel@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Chuck,

These patches build ontop of your recent series, here:
https://lore.kernel.org/linux-nfs/20250909190525.7214-1-cel@kernel.org/

The first sunrpc patch is carry-over from earlier iterations of my
NFSD DIRECT patchsets. I think it needed to be sure we have adequate
pages to handle expanding misaligned READ to fit in max payload. But
maybe not?

The 2nd "NFSD: Implement NFSD_IO_DIRECT for NFS WRITE" patch is a
refactored version of my earlier NFS WRITE support.  I tried to honor
the types of changes I saw in your rewrite of the NFSD_IO_DIRECT NFS
READ support. So I avoided needless maths and variables that were only
for the benefit of excessive tracepoint complexity (which I also
removed), while also establishing cleaner code that you can iterate on
further if you think something else needed. LOC isn't much smaller
but maybe you or others will see something that can be elided -- the
good news is this NFSD DIRECT WRITE code stands on its own like the
NFSD DIRECT READ does.

Not sure what NFSD DIRECT WRITE gray areas you think we need to work
through further in NFSD (but I could imagine there being room for
common Linux vfs code or other FS-specific code improvements to make
buffered vs direct safer). I know others have repeated concern but in
practice I haven't had any issues with this NFSD DIRECT WRITE
suppoort. So I welcome further discussion on what else needed.

Thanks,
Mike

Mike Snitzer (2):
  sunrpc: add an extra reserve page to svc_serv_maxpages()
  NFSD: Implement NFSD_IO_DIRECT for NFS WRITE

 fs/nfsd/debugfs.c          |   1 +
 fs/nfsd/trace.h            |   1 +
 fs/nfsd/vfs.c              | 215 ++++++++++++++++++++++++++++++++++++-
 include/linux/sunrpc/svc.h |   5 +-
 4 files changed, 216 insertions(+), 6 deletions(-)

-- 
2.44.0


