Return-Path: <linux-nfs+bounces-16635-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 17BE6C7629D
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Nov 2025 21:16:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 116854E2B76
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Nov 2025 20:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE0633242AA;
	Thu, 20 Nov 2025 20:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D4/eVOtj"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96EA3274B35
	for <linux-nfs@vger.kernel.org>; Thu, 20 Nov 2025 20:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763669756; cv=none; b=jDfC4GXP9QcfFpiBO6Kd7JlZ5Rtsd4l5O8RVh5M4TGDsuWSyV7HwRmUsuPC+uQ5u3XO4wBE0qJge9MPU9mq43Rj+/3Gbw6p4frxL70+ZW2jjD78FiZOeXIENE4TQvPx8wUEUQ0Q5PWY7CxT7tir5UtgyS1FGjcC/My8cvLu7U3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763669756; c=relaxed/simple;
	bh=4C7TptZBqJyyEJ+/+ItsYKJ62IurW20qorGKvh+AoRE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ej7ZQpnd0xWJ6sXbbzA4MICBFUGlRDYPM75O10i/pmAgodcg9dQ3jd00yEMNMdTL+8grGQXCzpraNsLVKZPzAIY5fTQhKhBDNjBNqGshOGurmo8IP+0lEubVDk/YyY7Tg+n9NlshkigGT6RZVcZdRDGGUIlWhvY5x8u3/lqs0ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D4/eVOtj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 836FCC4CEF1;
	Thu, 20 Nov 2025 20:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763669756;
	bh=4C7TptZBqJyyEJ+/+ItsYKJ62IurW20qorGKvh+AoRE=;
	h=From:To:Cc:Subject:Date:From;
	b=D4/eVOtjQVv6js97fTZlZSOD8myClNz/lH595YPt+sC8Y0UV2bZyh+heJpoVhfHQb
	 FGg8eysmJ+7YDOKUDXuPISVPw7IUNE2wF4DNJqAnLuBQ3rGKGY6XAt1HHujkQAGhzr
	 TGbbrU2PbrFVTTipRK2pgn9VRIj6bjNqxv1nJNo3dJqtuv+Csu5tr7pC77l1pDOhDb
	 BzdKLZ0S4AmGTHIHyYvk0W8/rh87StA24qCMWfbxEbGdNma2BCPJ6xb5Px/ENOrSlp
	 W2LWLgwXc0s1kHplNutkySLGRt1TSkqo2zZ54I0Ht/jy4MjXqJUqb0YjsZpDvhmIl5
	 Mnr/tcAC/Tqdw==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 1/2] NFSD: Add instructions on how to deal with xdrgen files
Date: Thu, 20 Nov 2025 15:15:51 -0500
Message-ID: <20251120201552.9668-1-cel@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

xdrgen requires a number of Python packages on the build system. We
don't want to add these to the kernel build dependency list, which
is long enough already.

The generated files are generated manually using

  $ cd fs/nfsd && make xdrgen

whenever the .x files are modified, then they are checked into the
kernel repo so others do not need to rebuild them.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/Makefile | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/Makefile b/fs/nfsd/Makefile
index 55744bb786c9..f0da4d69dc74 100644
--- a/fs/nfsd/Makefile
+++ b/fs/nfsd/Makefile
@@ -26,7 +26,15 @@ nfsd-$(CONFIG_NFSD_FLEXFILELAYOUT) += flexfilelayout.o flexfilelayoutxdr.o
 nfsd-$(CONFIG_NFS_LOCALIO) += localio.o
 nfsd-$(CONFIG_DEBUG_FS) += debugfs.o
 
-
+#
+# XDR code generation (requires Python and additional packages)
+#
+# The generated *xdr_gen.{h,c} files are checked into git. Normal kernel
+# builds do not require the xdrgen tool or its Python dependencies.
+#
+# Developers modifying .x files in Documentation/sunrpc/xdr/ should run
+# "make xdrgen" to regenerate the affected files.
+#
 .PHONY: xdrgen
 
 xdrgen: ../../include/linux/sunrpc/xdrgen/nfs4_1.h nfs4xdr_gen.h nfs4xdr_gen.c
-- 
2.51.0


