Return-Path: <linux-nfs+bounces-16874-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D2C0CA0EAF
	for <lists+linux-nfs@lfdr.de>; Wed, 03 Dec 2025 19:23:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8A12F34127CE
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Dec 2025 17:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54A98330B1C;
	Wed,  3 Dec 2025 15:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="deexZAqs"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6AF330B06;
	Wed,  3 Dec 2025 15:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764777140; cv=none; b=eEnjfsbjhEzWT1aSU1XqrFADMVioKCCKXgjDzgZJYpDEHLZ7J3naduw7FtsuW3knyDSaOWwsDK4QwNoZEy1b52rDbqQKbzf114z/m+yqhJpP/lEdTtTZ+o32jQzrgk+xGdBC5AAmqZ7QHwhQyzPMNx31RCFUxsGbEcfuoyjlU7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764777140; c=relaxed/simple;
	bh=xVTxNRALNFdWoG4qQlYof2f8iKg+DLGRYAkFSqKEgE4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=QXvbAjnKpWyRUflaDs6PjrzJr+aFmJCamJ0Ys+eEV6fSfQ70NzEL8QVR2ywp3gb2fhbdOiV6ZAHCH43I89UMJty9MFNrC2bv0fBLBp0JV5qSLPsrBGwy/OICSlnMMsGgSB80zZaaAyI4DDnD4IwBeXijeVf+K3J5ZyEEI4p+IMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=deexZAqs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 477ECC4CEF5;
	Wed,  3 Dec 2025 15:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764777139;
	bh=xVTxNRALNFdWoG4qQlYof2f8iKg+DLGRYAkFSqKEgE4=;
	h=From:Subject:Date:To:Cc:From;
	b=deexZAqsq1EKOATXf39fkSbmUyzmcIpb/Fe7t7FeR+SL3XAsyy7BT29tSlJzTmw5p
	 2tAKL9JIa5TK7DsS0zfRKl2AREzR1SxIEMh2gGWZvJqtQvi27Sn9mYoHcB9F8yg6Iy
	 mNnGK52cBbiXeyivTfD1Z00TnjRXDSFhS1HX5RU9956+1fabDmHbGhviBCPGvi1Xm2
	 6X3lz1huzlZadXSuq/Q1amnwxmqrYviJ1RTlsmv3Gp0JDCCwPdJjZfBlE+zv3AXx87
	 Lfiy0mzl6afhBYf5usdBDWFD7JsUvjyGH7xvRrUsMMQ660HysufsAdI2WpTcjnpX7l
	 LadTKEMivtd6A==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH 0/2] nfsd: delegated timestamp fix
Date: Wed, 03 Dec 2025 10:52:14 -0500
Message-Id: <20251203-nfsd-7-0-v1-0-653271980d7e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDIwNj3by04hRdc10DXcskA6PUFEODVBMDcyWg8oKi1LTMCrBR0bG1tQB
 FeySKWgAAAA==
X-Change-ID: 20251203-nfsd-7-0-9b02ed10e407
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=718; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=xVTxNRALNFdWoG4qQlYof2f8iKg+DLGRYAkFSqKEgE4=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpMFyyIOA/EPKXbNZK5R4Qsv5EMp8oAwkKALVF8
 yoL9tvawqCJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaTBcsgAKCRAADmhBGVaC
 FeMEEAChtzn1rB9rV2Q45WTM8k//HgRPi3U13ErFhyGmEUPoDQSxEQUUd5sljeQnI0YI0l4cZYM
 nVttwwe1ID5Z8OqhqL4mcw/1cb3wy4c4coGhWvZx7cQSGHz/6Nvls6bsW5M8TI465MTDHOY9T6r
 ej7wqbUaZUwdB1VU0Rk2I7VROcJtKepD3+oIOOMtDB9xIjINPlbE3C5bzp+rGou/o9TSLsTFEmq
 5f22AxnsvJG3ynuPkk/vYm7wFU9EQhgTnyqsGawo+9KBqGTEQsUnAaqUMJmVszGdXqQKhjbVlpy
 H1Nu+ww6xM7vbFzdLbCtSr9M2Ol2r0umwwkZ7UCUSJfaaZDhQduN+AmIVNm8vp5proOnSayoQwn
 2l94vHjNpmfgcOWtCPDHLaD8AGVWv6jh5mcOLSb5MSbtOQaBTunxX0Wl4fvLcQ0lYQMKQMC5aux
 Uua4G7MV9VCWBY0+2gdpLXCCGUESWNlJUTI9s9oAi4b56Ccxky813LTMvFPyaOPIq3mLlhRSy1W
 rVMqigCd+ypQKdmBFLsNq1iPad4XORMB7olVm8/vzNDm8Ii4pJoYVp4lwMPXNnGaEg333SFkj0/
 qUrbHLtvxo6GpC8VefruPt6Q6PcW1FhkSoPTXhPK3MSQUHMD2028XfqgMrTg5Sz/BM7PhfJzTor
 KZhaldaMTgz6lTQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

The first patch fixes a bug I found with delegated timestamps, and the
second makes the warning message that prompted the fix more distinct.

This is probably fine to wait until v7.0, but I think it's safe to take
them sooner since it is a bugfix.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Jeff Layton (2):
      nfsd: use ATTR_DELEG in nfsd4_finalize_deleg_timestamps()
      nfsd: prefix notification in nfsd4_finalize_deleg_timestamps() with "nfsd: "

 fs/nfsd/nfs4state.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
---
base-commit: 8c83500a552a34821bf9d865aec5a5588b4cfe7c
change-id: 20251203-nfsd-7-0-9b02ed10e407

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


