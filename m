Return-Path: <linux-nfs+bounces-2679-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5194389A44B
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Apr 2024 20:41:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E50461F25AA7
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Apr 2024 18:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA0FF17278A;
	Fri,  5 Apr 2024 18:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SDkz3uD7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800AD1EB36;
	Fri,  5 Apr 2024 18:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712342461; cv=none; b=rzlTjbE6ngYHOIwtKOXs5XSoIb6htbU+6HwoarslkBExjCCG0Z0ZLssqw5qR1+63ch32Mz/kgaSmpZ09LatEyJd7FmjJotf1sABWJcxr4uFCA7r5xWKRIbXcjQkGqcGpFkQuK5WJI0okRrWuLm/GpQxOfy2JUnB0JczmDlF8GAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712342461; c=relaxed/simple;
	bh=57nNe2p7gcYuo/Kij2flNVNM8RMZMqbqX1psYkWJMAA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=jWKpnRKs884Ul6UDYOYL4KfLGmtfKlKIZtuABmGZxsG0czUaOBA9rJyx6x0XS/6gHGGVFZybW2q8j8J5pWepqrtgswoHo/Far+6YhLzbbHxOaoE8fCo0PL3onSqD2jXf1zctVGybsg5cAgB3IDjfm8pxhQpgQA1hUr8dGAHOFdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SDkz3uD7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33E8CC433F1;
	Fri,  5 Apr 2024 18:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712342460;
	bh=57nNe2p7gcYuo/Kij2flNVNM8RMZMqbqX1psYkWJMAA=;
	h=From:Subject:Date:To:Cc:From;
	b=SDkz3uD7u9rieDKAskvbViO3sDGxC/zfe/cVXKRwTiiu9dvLkiUBaIFDn7d+7tinv
	 tCkFRR+zffKvvYXDxw+VaQe03/kY9gD5QmXryVVlKTfQ7cmZpW0y5TADGv1bnPgeel
	 1SMD3y47EPPeAiHd4lIHtV7yMq2oun51iZn964r7T6gl1efTLEYWo+afBEU3dEYC1S
	 L6ZY0fFwgeR56FpRT/1+5/q40heXCKJ60RMnbEnooc8G5A9td8paHK1eYCimR57S86
	 JhOT7+zXbDY1j75LWReYLER6wgqZIgxUCdkMFQBFBs0Q5eDBaSsCtJOW3GvomuPOSX
	 cd1eIyXteWPJQ==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH 0/3] nfsd: tracepoint cleanups and additions
Date: Fri, 05 Apr 2024 14:40:48 -0400
Message-Id: <20240405-nfsd-fixes-v1-0-e017bfe9a783@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALBFEGYC/x2LQQqAIBAAvyJ7bsFEL30lOpiutRcLFyIQ/97Sc
 ZiZDkKNSWAxHRo9LHxVhXkykM5YD0LOyuCs89bbgLVIxsIvCcacfHA+ktsL6HA3+oX26zbGBwE
 Z+OlcAAAA
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=808; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=57nNe2p7gcYuo/Kij2flNVNM8RMZMqbqX1psYkWJMAA=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBmEEW2Sf5Klhcwetw9holfYAYSSrTeS1isrWdwo
 tk+W31ijWmJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZhBFtgAKCRAADmhBGVaC
 FUCXEACIeg/crLsQQAP3CGuJddlHjgXtB3BSqUvz8EBJSQGju1dj5R1B0yc8bN/jOjDXZJKNJ5h
 ztl00FvivG3ZE0/Fq9phUawd+pN5xl6fx0FeYz15nqbVEqrSjO+wFlxuvqqlzlGvPUmWsastH3M
 maKKFkFjUGitm2HZmLLknl1e6q75BZVBCVQMEoptwD/X+AmIWI4vy+TkAlAsuxa2qGC8ofGrJGd
 XRTsDRDirLLRanS5TUZYvXAW48OZw7lAQTdW2OwVncx+WEl0o7uiVbVMbGpy5+aJ6IfSTZE/U82
 jPemJMUhy99Pu5laNMtkv1tchBP79SHzokxCDN0NwPjoO7/1c6pkbemXNBrFljDX0TQKjoGa7PJ
 6pnCH9sOK5ulE/gMXCxfnvlO1BgiY0gUH/sV8cO1dKoCA4oPLapOt+ud6LKBkHd394GSPcG6fVB
 razVUgbBoedEHM9jvJNEcMUHIjWHoWUB/Po6aKWRW8sgeBlN76PLDMXMxI1Nc75lDcaLFv9VPUi
 v1a7jgnsz9Y1mWSiVYs9vvggtxsxf/8etJSetmljZeUPfcKQkZ4D//4j4hKRrvcwWfcaGn3tfaw
 b3bvtjq0vElzmg0kHW8Shdal+E6eUbJTBsaG9tM/QREF+xHs2Y0tC31KvZPAT5tdvGGg++XZxiA
 SWALZyXiPzNpxCQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

First a patch to remove a few newlines from existing tracepoint string
formats, and then a couple of new tracepoints to instrument some of the
activity around CREATE_SESSION and client expiry. Probably reasonable
for v6.10.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Jeff Layton (3):
      nfsd: drop extraneous newline from nfsd tracepoints
      nfsd: new tracepoint for check_slot_seqid
      nfsd: add tracepoint in mark_client_expired_locked

 fs/nfsd/nfs4state.c | 18 +++++++++------
 fs/nfsd/trace.h     | 64 ++++++++++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 72 insertions(+), 10 deletions(-)
---
base-commit: 10396f4df8b75ff6ab0aa2cd74296565466f2c8d
change-id: 20240405-nfsd-fixes-adc4524ae2bf

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


