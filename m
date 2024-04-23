Return-Path: <linux-nfs+bounces-2963-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F11B88AF428
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Apr 2024 18:32:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD86328EB5A
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Apr 2024 16:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 800AC13CFBE;
	Tue, 23 Apr 2024 16:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XYIPOgo0"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7B413C3E3
	for <linux-nfs@vger.kernel.org>; Tue, 23 Apr 2024 16:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713889923; cv=none; b=lq7kphXMIGUh239tCCckj5Md0Kn6C1ILaKvbrbkeXwvC2LgtjlzXNdr4od/Sjj0jn8ng75E6wnn5ixVKHhi9BNy51aO3LFsetKOx06u18KjVzof7sJJHWiZL8Qs2i33whvddeD/TJ3JwrJeC1iQbUHsgbvDn/RxqFTLYm5M2Q9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713889923; c=relaxed/simple;
	bh=9TFJBIp1pcmU93Uwfru2PyRm2ybd79FOSpQ0vTq+ap0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=liXv+fbtEAO7YMOCD0jSo5vTWgRzIWft31ZoA04YpIDcvY4xBkHiet/tbp1NAU+Exlf2gRnCMfbRNQ6oWxmgGLyqhX+ntsrzOz3gRpHs71MqCbUSPd7W6CRk9wBuhagREAhxz4xKvofpRcKWiyFTDf2Eb54mGKdOIielGhc2ru0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XYIPOgo0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7682DC2BD11;
	Tue, 23 Apr 2024 16:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713889923;
	bh=9TFJBIp1pcmU93Uwfru2PyRm2ybd79FOSpQ0vTq+ap0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=XYIPOgo0LjnPWmxgNUokvuvkngW2UtwLcqKYJRd3UjIGDnP59xpCknT6Ng1pv5zQ2
	 PQDOfE/CxePP3bjYv+jlVMzRZzjKGJ/Z3NEpKGq72E2b8BAHl+EU5f+IeMSFZYKR/s
	 6AsXK+I7/eMAmbtsVzJlvpAaMfeg88s4/Kf1EL/OYly05kBSszW/jaWHiCxFplKWvL
	 STRcqUlVtbxpuzDBWcwcilxH3/Z3tgY8IOakcXf/erwHFBWsNptLTrSVFjPZkBmX5h
	 /+ekO6POd0OThHmFKPDD34nMMwIE+7qyKPpn7uUGq5IVmTFOGPI4Yy0z8FLOu2zFIT
	 eOZjlac0ceh7A==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 23 Apr 2024 12:31:55 -0400
Subject: [PATCH nfs-utils v3 3/3] systemd: use nfsdctl to start and stop
 the nfs server
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240423-nfsdctl-v3-3-9e68181c846d@kernel.org>
References: <20240423-nfsdctl-v3-0-9e68181c846d@kernel.org>
In-Reply-To: <20240423-nfsdctl-v3-0-9e68181c846d@kernel.org>
To: Steve Dickson <steved@redhat.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
 Neil Brown <neilb@suse.de>
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=906; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=9TFJBIp1pcmU93Uwfru2PyRm2ybd79FOSpQ0vTq+ap0=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBmJ+J/K7ZY904geoTO+eOGp3yEBLMzIuR4w2hAw
 QOqu8rVVwKJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZififwAKCRAADmhBGVaC
 FUDiD/0d01SvixTBBczpSADE1OEd1emYxoQYfjdPiGEUere5l5yVy2btITj/5jltCu+ZD3VvA20
 BDduXVfyPHoUoQB4VAjtIO8hT9jtBAhAom/c5SzGphVDToNEkdi+Fo4XloK/lxsRSUVh6+KCcZU
 vzyI+CBOQDNGPx2XxY1XUpSQpyxwkIpXAt9aGHKUFhnyGWDSHAocu4x91pzv6HjwqeQTs83mQKh
 M60ORZXfG/y24PpTYFvFD4WH1cr0O2cwuBuS82hrg5pEi4mE5zRVlW+eIDNn5RcNOJN3xTzFcF8
 UxsO9eFj5aawM2+utF0Xwvz01/KfPNkQoUc+qNZ0vygm5AGHZ6rlwz1+UUzsBAf/n8mtdGU5odH
 bMh67LuR2XyXM5Jrmw9AquAZvs8oVgzViY59wgMGuHI87ygimXahE4Amwmek9epT9P3/GwXvfH4
 D4ogspu235pRQ0B/GSqc0KOsFcMM1Rnwyut1h4TYrR0y3XkXMQdqiBr0Lucf6dDwtO8v+9foe6U
 VO1q1KH/7sVr8x7FfEfMtXwf0cpi0UAg+KzauENg+EANgftlWo4LKxv1StqdUKmsmcRyZkRMHQX
 2dRnDf0toXyCILOS0MOqvmYQIba10h1GaJb266oHINJM/aLgJrNylCOGhD5L0E4ut30fxc6gzZp
 FNkjDQv/+lrcF+A==
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


