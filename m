Return-Path: <linux-nfs+bounces-2846-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1950C8A71AE
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Apr 2024 18:49:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA1ED285DFC
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Apr 2024 16:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EA3A132C23;
	Tue, 16 Apr 2024 16:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uz7tG3bm"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B85F132C1B
	for <linux-nfs@vger.kernel.org>; Tue, 16 Apr 2024 16:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713286154; cv=none; b=c/3Xd4nlR2Q/jEvGvkaBJIE1MtXvvzkDwXZ9RmFHhKY9afX447bt0AO9oSMxs4VCPpRZhvowIxpVgPMkE7uTD3cNakeuXqRGBTvgS4MWEOzocb/KYE+YYjnjaxY/tHhGPYCv6+P05QBroO0UQO8gOv/vKM9Pt8e4aWGcXPak6yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713286154; c=relaxed/simple;
	bh=9TFJBIp1pcmU93Uwfru2PyRm2ybd79FOSpQ0vTq+ap0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rToCCFxQjMomcxp4AWQvP630EsE6fyC1ztTXijSf+9mvTrdr7M/UZ+KqhcD/Xs2LxzZoa79KOrQVfsdkzzgBIHHpZK4yzwNrJw8AwwRkWGvle41seOnC8bzWzaLOtiYSY5fo9Yu+vhhc0CzhiSjfQEdU5rx50vL12djA7ZRDIpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uz7tG3bm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D203BC4AF09;
	Tue, 16 Apr 2024 16:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713286154;
	bh=9TFJBIp1pcmU93Uwfru2PyRm2ybd79FOSpQ0vTq+ap0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Uz7tG3bmrNbIaoS3YvEjoqeNv3BiT6FuwEZzwRM2ggYV0YoHAzdTYd7XIcwJqPkzS
	 gVcJY14z4MsMzZb/omMx8dL0ZtNjuOXRltFuQlZZwarmC92FQQd2DXkiZOGAnfhzHc
	 ZfH8BP5bmS2Q2IrJOdRE6qZr4UkHMeYCrmQqS22OlCbhbuh7PRYFV39hp7GbgjZSpM
	 SNsZpwkwcXF8LIkmu18oZcQ7FK8LQ3wvQmwtvF3EsmUVxSrSyogU3ML+U/WjonaoN3
	 u39xfRlBpbZozk4+M29HFscBN4QRh5a3WsWvnhiyJpy1HsAkP5aFwNecWCdId6WVXg
	 JqEo+cF64oQLg==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 16 Apr 2024 12:48:50 -0400
Subject: [PATCH nfs-utils v2 4/4] systemd: use nfsdctl to start and stop
 the nfs server
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240416-nfsdctl-v2-4-9a4367b710d2@kernel.org>
References: <20240416-nfsdctl-v2-0-9a4367b710d2@kernel.org>
In-Reply-To: <20240416-nfsdctl-v2-0-9a4367b710d2@kernel.org>
To: Steve Dickson <steved@redhat.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
 Neil Brown <neilb@suse.de>
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=906; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=9TFJBIp1pcmU93Uwfru2PyRm2ybd79FOSpQ0vTq+ap0=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBmHqwGTzIjz1GjwBTrybvQpAlvFW6Hojs+TWZhc
 z+bqbq66o+JAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZh6sBgAKCRAADmhBGVaC
 FT9tD/9tvxNunQeAoRT0Ka6QRF5S5pGtHh0A8iVceKR6vZx2WAvAnIZCNxoJIYqXGuhPyngt1B+
 8jWxZw7pt4Qd6D9QsUSJJsxhiVFajDtuwEHCDuOhIGbyHBSEpdMR3wfKbnuVVjmrYPsq1gqsYjv
 Vi2Nwei8Mw9CB8KBHbmF5zf579MIJOhg6qNDbvUbpwE3MTECtQ/ZsgJZrlEoS4jsT1YGwdShIYT
 jOgHK1vY/iAX65xOoFrg5LKOCooN4F8F0TOEI48BU0lES+UXcgSU839sMrue7YIxT9ouy3BahoI
 W/6jQ4By7L60wnZ7af9wDUeCGRp03pIoAUQVp63yh1qqRacQwex1o+ZikOZ80OBdKCIR/OU3xq0
 vQlwkQ/XdU961r9o96Gu93pbE71FYe7H9Zo0grTp/Wb0rCvc/SM1HqZAck9dD3H2y8ydh3DB0wo
 690xTrdwBn0iGQDAw2cURAqFF1CeglWZKYPyYq7F+IYjGQcUWIi+LgL7khdlDM3STzIeeIsl4L5
 I9nFK3m/QUWDSpaGvQFrObCcqhVxyrgEwR79FQwVMvp69sCMI6daczNFjuN4r+Huq17hRjK8r4U
 1Opm3U2rzBxcws7FVFc/Io/TvENZ1UWSVHJyBFsqY3NqJ95aEzYUT65WmHg/JiIHr6lZ0FowBhv
 btXqDyD4rw78yLQ==
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
2.44.0


