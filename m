Return-Path: <linux-nfs+bounces-11063-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C81F5A8286E
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Apr 2025 16:47:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 214C39063E9
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Apr 2025 14:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EF4218A6A5;
	Wed,  9 Apr 2025 14:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V9Va045H"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2693595C
	for <linux-nfs@vger.kernel.org>; Wed,  9 Apr 2025 14:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744209689; cv=none; b=uI2WcuRSQm2gsQUAx/+ZaJtLWKlCOoAS+0gEt5HAQ5RHjfADuDzsgihQxnmDzcaPkyVFh7Kn1b+kqGw5ymupcY4+f1kgcllA2tP2j17peApacFx0yYmhRo7o/Fec8rxBlngfCYVIuA997xqAq4G06knxASzNqVQlY9tk5GSxjXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744209689; c=relaxed/simple;
	bh=8ulhg2iqltWaVEOzBVjfJs4pXPKMCQskSRYaufVxImc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YOBGYhaubG9tplTEaqyZJyJxRV+mZvKzN6C4FIE8rDq2sj/dYX89rgFE3u9nIHO4eITLDaojVeEUnt8WmwqF6UNpiWoELosQzZHl5qkfgxz8NG35cleSlcpFr0UDd4UNvYogMXyqNHkD2eNi8w6PbQtROr3c8K1MF7WSGtbgYmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V9Va045H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CB2DC4CEE2;
	Wed,  9 Apr 2025 14:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744209688;
	bh=8ulhg2iqltWaVEOzBVjfJs4pXPKMCQskSRYaufVxImc=;
	h=From:To:Cc:Subject:Date:From;
	b=V9Va045H7vz+YgMEotmbO1V47zfzMp25n6tt83LupDB5FBq3XclnwaPu4E2tzwPC2
	 afdyM90zssD++kNA58LdwQRjvX7G9AQ+tNXev/lUJIYAtEer4u6VXe/8qhJ/NP9vrh
	 XHsq9NnS+FomcYttwLarb+pddFTpkcNaqMHCDIdUi9zYztQcr5SKebTAmxuRedw4+c
	 LGpv8nYz/zIRwoa9sUC9W2nb0Ml8IcsdCD1mzxo6TxS4fYnpTV14i6bhdEDYllTyqf
	 Ac0KNS9evvpq1GrtwtlMsR/rurfvwiGxP9ApZqb7ZiFg01I1wVnTNbp5ljhWAFZpFS
	 MN1wW0ignRlAg==
From: cel@kernel.org
To: Neil Brown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH] MAINTAINERS: Update Neil Brown's email address
Date: Wed,  9 Apr 2025 10:41:24 -0400
Message-ID: <20250409144124.19584-1-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

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


