Return-Path: <linux-nfs+bounces-5013-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6DDB9392EB
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Jul 2024 19:01:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C69B31C216E2
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Jul 2024 17:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14F7916EB6E;
	Mon, 22 Jul 2024 17:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hhP3K0V9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5653C2FD
	for <linux-nfs@vger.kernel.org>; Mon, 22 Jul 2024 17:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721667701; cv=none; b=K2u6xipPaFfhPWrYnNHcJ+PpbjsqTOPB4Nqx2RxxCuKfMDOEZ1IMh9DxXzYmP9OmY3cL4HtDPUFMLngj3DFmK1oRDLDPhn3YjZFp38+ZrBXlTc2/Nii16bLEuSZpanNhnzY1ieAKTPEfjrvWjiRzHW+sdodojy+jcf4/x0pK6Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721667701; c=relaxed/simple;
	bh=qntMwaaweWl+Gg/eTntykRnBFONN9GK9xqHM7sT7/nI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VYwPwVlU984rT5g/tcdPsdP7aQLPwiBeWEOKbu7IINuVtoeR/7Dr3lk650J0HMy129+Cm+mkUHooXdLYnAqWj1YIdK5xcIz2vuOohGjzNqA677UcHPEhPhRKf2YOyXhm6pOJjmRlczFZIbgSteJcU6YtV/7diXK9UV2z5tqMBuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hhP3K0V9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7164C4AF0D;
	Mon, 22 Jul 2024 17:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721667700;
	bh=qntMwaaweWl+Gg/eTntykRnBFONN9GK9xqHM7sT7/nI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hhP3K0V9wcStKXb0iYLqfCKie8uv9537CbykqO6tTBU/KAWsfG1td9e+Kw2mbcOHa
	 tojDID71I0aF5Svy8GR/obnbCMlbt+vWl0VHkr82Wg/SYaL5l7r2vKN7PyQfGgoad7
	 LefvS3qvej9mXryvLIzFI4uf2/TaitYUvxy5ZdHKuvheOriA/ZUjt/vd2vdv7186Mn
	 egUjn9/vR3tstXu8Ovs4uxchN1x/DN3XXnzlZ2InxoDg3ftkQpugC37XEfCf+9DY7K
	 +W8vZucfN5hg6pB7of7We/u5Xd8Ka+24JNKhGThIimkIh+4OrxMHhyImRXyeqbKMT8
	 Gm7FEdr3QTKgg==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 22 Jul 2024 13:01:35 -0400
Subject: [PATCH nfs-utils v6 3/3] systemd: use nfsdctl to start and stop
 the nfs server
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240722-nfsdctl-v6-3-1b9d63710eb5@kernel.org>
References: <20240722-nfsdctl-v6-0-1b9d63710eb5@kernel.org>
In-Reply-To: <20240722-nfsdctl-v6-0-1b9d63710eb5@kernel.org>
To: Steve Dickson <steved@redhat.com>
Cc: linux-nfs@vger.kernel.org, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Chuck Lever <chuck.lever@oracle.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=906; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=qntMwaaweWl+Gg/eTntykRnBFONN9GK9xqHM7sT7/nI=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBmnpBwzX/odIlohfk4A1O0E/AeZSeLQWj9QFtGY
 SGSWfAsAWOJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZp6QcAAKCRAADmhBGVaC
 FR/ZEACEl0HAveDpbDqPIez/h+/TIcBOPb7HBs1exyFIzg6gYSF1xq28zFZdfjp951Fxc1CcfII
 XLowYuxCGVvqU9hZ8CuhH9sHR4BG5DVBH4lyyUhcCnczeouNg/lM0mve0z5ZVTrTIKzaeyPrvpN
 U2OTCWobllVFpz5WjmtnY5cF1S6fwDcNmbqiiE3Kkbvl96gU0KZNHDuRgPOeqOUDL8OKCDWdTbs
 bly4XYBbso6myziNphbOA75eg8T4YYErpdY1hNai89/htIcENCWSOg5Qh2TTGvBET+UJeK+gJ53
 tRw5/gjnM09jKtpcyagUlY6htnsdj+I4YEJolGWBsYXu9H6cL+8VzALEyPSdwdBgx9mPkaohKh/
 6e+2Mxr166Zzt/iZtxbaIsZgePE42zPjazx8MRKjqd+NG4oJqlceZZjAGtKa+AnkHmemAv8P3lw
 5L4M3YNEd/OSaCAMChSeWEBPGcNrCXUaaRNf2Mb2VGncJoa3nwAMt73Hua/FvjOsf+RaO0qkz4W
 DeScsyUwhlz+H24qqQhPvUgEO/8/lZT2SVnfZ/BHBgyz1kdwAhIFI4cg9oYWOpEBpUUOriwd5K+
 BGqclo3oC4sajuWDUPMCSOH54xMYQEdRlYIHGMrnd88ePpq0V05bCPG/4XU+3LaYnk/U8YRS7XF
 FVy42foJGpOaPsA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Attempt to use nfsdctl to start and stop the nfs-server. If that fails
for any reason, use rpc.nfsd to do it instead.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 systemd/nfs-server.service | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/systemd/nfs-server.service b/systemd/nfs-server.service
index ac17d5286d3b..8793856aa707 100644
--- a/systemd/nfs-server.service
+++ b/systemd/nfs-server.service
@@ -23,8 +23,8 @@ After=rpc-gssd.service gssproxy.service rpc-svcgssd.service
 Type=oneshot
 RemainAfterExit=yes
 ExecStartPre=-/usr/sbin/exportfs -r
-ExecStart=/usr/sbin/rpc.nfsd
-ExecStop=/usr/sbin/rpc.nfsd 0
+ExecStart=/bin/sh -c '/usr/sbin/nfsdctl autostart || /usr/sbin/rpc.nfsd'
+ExecStop=/bin/sh -c '/usr/sbin/nfsdctl threads 0 || /usr/sbin/rpc.nfsd 0'
 ExecStopPost=/usr/sbin/exportfs -au
 ExecStopPost=/usr/sbin/exportfs -f
 

-- 
2.45.2


