Return-Path: <linux-nfs+bounces-16415-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 670B0C5F55C
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Nov 2025 22:19:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E28053A29FE
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Nov 2025 21:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC30235502E;
	Fri, 14 Nov 2025 21:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s1Nvo7a7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB1E354AD9;
	Fri, 14 Nov 2025 21:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763155165; cv=none; b=NkStSJp4sjnP2xxRNC8YXSH95hVRr6o4cwPtfUVaBgmSymMZ4RfSjm16MdVveCGg9hkn5zs7ULzkCDoup6vEokV61034z42WEKXSy/MpZHGHzkTKGddYRTnZRLItlt9FsSqir0Lmz5SoQq1rJRY3RPIuI4mZU0AAkeyX6hB9WWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763155165; c=relaxed/simple;
	bh=fRjsJ4ILbYmevq3A+UeisJRyRN2VEPlnEnUDonmJ7qM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P+PzrsTdADrEplh0J8nnX8I1T2ZX/CTayhw8GDHez2f/YZGuS+9vzH9Y5wZCZ0I3/5uCTINhcfesgjzfguFkL5xvsGXZGFqNb0yug2cQV8gpYZr+ltSokc/qxO1KnIRlrT4o+F7swJBaFYDYzt8ADZ7aG8BNUSjZVFZPj8DuP4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s1Nvo7a7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73D9DC4CEF5;
	Fri, 14 Nov 2025 21:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763155165;
	bh=fRjsJ4ILbYmevq3A+UeisJRyRN2VEPlnEnUDonmJ7qM=;
	h=From:To:Cc:Subject:Date:From;
	b=s1Nvo7a7jVB2YQHXt6n19VTBwfq4OyQLXNtpFNlIL2dOadX6HhGMNvMlzIB9aeqXX
	 rASJGWKe/zUwB6374x0ZsPdhm3hUxCIyKXo/zmxyZKaEGzoY7Ecyw+bFRH8Pqenq0P
	 IPO8m9huLSpXqX9S1qPsbopYylLVmx09vjLCM9ljvVCFzCsnCaHrHjEIoW3bHGqHtl
	 dxiIGIhnEUQihcCTIj9gm0NPVT/5EraEE1H1hf0rOOXxd06X1AxDyAlYsjHbrwd10B
	 QLxcKDQfnOjVuuNyteT0wB9f+x1IbK7htoHRIk5k9gWBcrCIVGg3dbcGkTyCPHH48d
	 xu8NjtPKL/eWw==
From: Chuck Lever <cel@kernel.org>
To: Andrew Morten <akpm@linux-foundation.org>,
	david.laight.linux@gmail.com,
	NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>,
	speedcracker@hotmail.com
Subject: [PATCH v1 v6.12.y] nfsd: Replace clamp_t in nfsd4_get_drc_mem()
Date: Fri, 14 Nov 2025 16:19:22 -0500
Message-ID: <20251114211922.6312-1-cel@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: NeilBrown <neil@brown.name>

A recent change to clamp_t() in 6.1.y caused fs/nfsd/nfs4state.c to fail
to compile with gcc-9. The code in nfsd4_get_drc_mem() was written with
the assumption that when "max < min",

   clamp(val, min, max)

would return max.  This assumption is not documented as an API promise
and the change caused a compile failure if it could be statically
determined that "max < min".

The relevant code was no longer present upstream when commit 1519fbc8832b
("minmax.h: use BUILD_BUG_ON_MSG() for the lo < hi test in clamp()")
landed there, so there is no upstream change to nfsd4_get_drc_mem() to
backport.

There is no clear case that the existing code in nfsd4_get_drc_mem()
is functioning incorrectly. The goal of this patch is to permit the clean
application of commit 1519fbc8832b ("minmax.h: use BUILD_BUG_ON_MSG() for
the lo < hi test in clamp()"), and any commits that depend on it, to LTS
kernels without affecting the ability to compile those kernels. This is
done by open-coding the __clamp() macro sans the built-in type checking.

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220745#c0
Signed-off-by: NeilBrown <neil@brown.name>
Stable-dep-of: 1519fbc8832b ("minmax.h: use BUILD_BUG_ON_MSG() for the lo < hi test in clamp()")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4state.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

Changes since Neil's post:
* Editorial changes to the commit message
* Attempt to address David's review comments
* Applied to linux-6.12.y, passed NFSD upstream CI suite

This patch is intended to be applied to linux-6.12.y, and should
apply cleanly to other LTS kernels since nfsd4_get_drc_mem hasn't
changed since v5.4.

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 7b0fabf8c657..41545933dd18 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1983,8 +1983,10 @@ static u32 nfsd4_get_drc_mem(struct nfsd4_channel_attrs *ca, struct nfsd_net *nn
 	 */
 	scale_factor = max_t(unsigned int, 8, nn->nfsd_serv->sv_nrthreads);
 
-	avail = clamp_t(unsigned long, avail, slotsize,
-			total_avail/scale_factor);
+	if (avail > total_avail / scale_factor)
+		avail = total_avail / scale_factor;
+	else if (avail < slotsize)
+		avail = slotsize;
 	num = min_t(int, num, avail / slotsize);
 	num = max_t(int, num, 1);
 	nfsd_drc_mem_used += num * slotsize;
-- 
2.51.0


