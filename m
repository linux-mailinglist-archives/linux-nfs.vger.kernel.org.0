Return-Path: <linux-nfs+bounces-5484-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D890958F0B
	for <lists+linux-nfs@lfdr.de>; Tue, 20 Aug 2024 22:10:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D4331C21003
	for <lists+linux-nfs@lfdr.de>; Tue, 20 Aug 2024 20:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AD80149C4F;
	Tue, 20 Aug 2024 20:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AijuHcOG"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7627318E34A
	for <linux-nfs@vger.kernel.org>; Tue, 20 Aug 2024 20:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724184605; cv=none; b=aldAfZUTHKK7AIa/rB0Y0eaUcj4Wi+0cL6r1/YQv3LBSDnjWHkzL7N5wtsgrRHFi8SWg7mbPGviYYJEx1C/d1hSHphnO6UhY0HZNHri+kk/nJfP92A2YDn4vx7CBF+QIFfyELqjg3Nj14lbJAT9qvSTFf8oQIv2MbHkCC5P5Epw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724184605; c=relaxed/simple;
	bh=VbgiEPL8AbhjDbiU1sr8vIA7hqB1DT0jjrZmzrPFLLg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Jcl3wsXOWSl773AxeHwXKKKpjR83rIi7K2KG5DAbHSFcdVO+HBkSWL0+4Zyj3tQYk1wktk6CU/0j1WmMEUO/i9dKm28Q6wKHy3gxP2qy6T1PC3pGN0TbPakSBrGIYTc/OH6Wfsf5QgusvlQIg5LTcxwiKdS89li6RHV7lRKBJN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AijuHcOG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B9C1C4AF0B;
	Tue, 20 Aug 2024 20:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724184604;
	bh=VbgiEPL8AbhjDbiU1sr8vIA7hqB1DT0jjrZmzrPFLLg=;
	h=From:To:Cc:Subject:Date:From;
	b=AijuHcOGdXX2sWp4MnX2n7Wl2OCh7FeQ5TW3j3NeL96+I5YuJwQAiEATuAcXpqvpT
	 7GlgZh4U86IMadmeY9523pF3sCaNTb1w7h/Jrqm5zzbFc21S38cowTBywB7BlC+g3n
	 +Rlv95gh26HNwh3Wdszg2COPd6dzuw2MUfVJE6PLLUBTGYA90q1q8tz91DvFSWe0nW
	 N+1WQ7peFNNMrPxqCi2D7kBHuszDcBk+JXGJSNgOXsBFhvC2Fzp9e0wsvAY4mCCJy/
	 4OOQiBB8Xb0wnafZU5QoLZdLdZFLdr94wmwr6J2H7JgRpKsc1WXBeeP/KwDK97iBRW
	 qeFT6KfTbkb1g==
From: cel@kernel.org
To: <linux-nfs@vger.kernel.org>
Cc: okorniev@redhat.com,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH] MAINTAINERS: Update Olga Kornievskaia's email address
Date: Tue, 20 Aug 2024 16:09:59 -0400
Message-ID: <20240820200959.22634-1-cel@kernel.org>
X-Mailer: git-send-email 2.45.2
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
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index f328373463b0..41d0202e40b3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12165,7 +12165,7 @@ KERNEL NFSD, SUNRPC, AND LOCKD SERVERS
 M:	Chuck Lever <chuck.lever@oracle.com>
 M:	Jeff Layton <jlayton@kernel.org>
 R:	Neil Brown <neilb@suse.de>
-R:	Olga Kornievskaia <kolga@netapp.com>
+R:	Olga Kornievskaia <okorniev@redhat.com>
 R:	Dai Ngo <Dai.Ngo@oracle.com>
 R:	Tom Talpey <tom@talpey.com>
 L:	linux-nfs@vger.kernel.org
-- 
2.45.2


