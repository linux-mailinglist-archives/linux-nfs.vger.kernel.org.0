Return-Path: <linux-nfs+bounces-11084-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F9C7A845BF
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Apr 2025 16:10:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D2407B2AE3
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Apr 2025 14:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3161B280CFC;
	Thu, 10 Apr 2025 14:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r+5g5KLv"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D50C276021
	for <linux-nfs@vger.kernel.org>; Thu, 10 Apr 2025 14:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744294216; cv=none; b=j1YqTFQZOWP4qTEOuY0y9LX6RAnDU6B9D8SMnDzCfiiVtV5nw3yoQw8gn7u3yf0qgQ+vfhpw5oGBBGcXVYjlDBLs46Q8bmXWgZTJpJO3VLnJUqc5ELQdmohyAa7Fv0xqCOUuO692YRE14SayPc9w8b9C+ORgG5IbKs7QFwiprKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744294216; c=relaxed/simple;
	bh=qQCYvbpX8gHB63hf9sGho2D9a+9uPW1p7hIGqjKfH4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mUkSiEYcSh/DOJ1a9jA+GVsPs1wzg7h+ic8c2nJiojGdv/HAejHSwFO3/buH0KNuowyaL1GlNzmxN5WKvZT/wWZqt8NtXv2HFcfW7g+WjL9hJ8wuoao6kgrUDVTaZ04DFQJfbEccNPLDttz75v2Ncz0SXNbR17GPoP+i13ARIDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r+5g5KLv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A4B9C4CEDD;
	Thu, 10 Apr 2025 14:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744294215;
	bh=qQCYvbpX8gHB63hf9sGho2D9a+9uPW1p7hIGqjKfH4Q=;
	h=From:To:Cc:Subject:Date:From;
	b=r+5g5KLvJ5hhvdxOtq4Ta21OaA/MoDaTK/oPMokBHSxtNuyv9ovOQwtcmRowipj+q
	 RWkfxm7AG+pxcTm8i9L3EfuMx+51PB7GDESvCGT/toC/l0IJq+h9vwN9/SHjIU9XS4
	 ZvOfRPzNsrGvteCCn0ag9ujjI3DKG8mnT+eSXmbABg+ofOSIJhWEN7DwqK6tLEv7dT
	 B9bB6Rp6Gs/VWcj6NRvP2K54IW5jRYfSVRkbwKs5CaTV91mnsKG9PjpKTvSMGn4Dqb
	 C4oJ4pj7A0N1tgM2hr65a5QOPG81tt34reuXDGDDcnuVj3gR8ZxnZBx+FuysJNz2Pp
	 yoPZ/ltoKKAiA==
From: cel@kernel.org
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2] MAINTAINERS: Update Neil Brown's email address
Date: Thu, 10 Apr 2025 10:10:12 -0400
Message-ID: <20250410141012.22187-1-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Neil is planning retirement, and has asked me to replace his Suse
email address with his personal email address. Both addresses
currently route to the same mailbox.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 .mailmap    | 2 ++
 MAINTAINERS | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index be60c13d2ee1..605a51dce19c 100644
--- a/.mailmap
+++ b/.mailmap
@@ -529,6 +529,8 @@ Naveen N Rao <naveen@kernel.org> <naveen.n.rao@linux.vnet.ibm.com>
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org> <quic_neeraju@quicinc.com>
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org> <neeraju@codeaurora.org>
 Neil Armstrong <neil.armstrong@linaro.org> <narmstrong@baylibre.com>
+NeilBrown <neil@brown.name> <neilb@suse.de>
+NeilBrown <neil@brown.name> <neilb@cse.unsw.edu.au>
 Nguyen Anh Quynh <aquynh@gmail.com>
 Nicholas Piggin <npiggin@gmail.com> <npiggen@suse.de>
 Nicholas Piggin <npiggin@gmail.com> <npiggin@kernel.dk>
diff --git a/MAINTAINERS b/MAINTAINERS
index c9763412a508..bf0deede9fdb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12602,7 +12602,7 @@ W:	http://kernelnewbies.org/KernelJanitors
 KERNEL NFSD, SUNRPC, AND LOCKD SERVERS
 M:	Chuck Lever <chuck.lever@oracle.com>
 M:	Jeff Layton <jlayton@kernel.org>
-R:	Neil Brown <neilb@suse.de>
+R:	NeilBrown <neil@brown.name>
 R:	Olga Kornievskaia <okorniev@redhat.com>
 R:	Dai Ngo <Dai.Ngo@oracle.com>
 R:	Tom Talpey <tom@talpey.com>
-- 
2.47.0


