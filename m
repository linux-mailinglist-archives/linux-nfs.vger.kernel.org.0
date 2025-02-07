Return-Path: <linux-nfs+bounces-9951-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE71CA2D00D
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Feb 2025 22:54:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEE46188D296
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Feb 2025 21:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B476B1B424E;
	Fri,  7 Feb 2025 21:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jeivBvLd"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877B51B3953;
	Fri,  7 Feb 2025 21:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738965250; cv=none; b=e1eG4nYW4yNsZW8YiZ1FuCh5wsIElueFOIfrU+A9fUivZdCoYcx7bjq8xH+YJwKtsPj1I5z7Y9il+mY+PWyTQWVmZ2Ic8JcQzvhJ+C400oVbhyU5g5rKqhuQV1pytM6xEkWmGRu6moltRew5pb9yfVPPYV/+Qi3O5C+e5g9vFNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738965250; c=relaxed/simple;
	bh=8QX0PGPdSwxlfa0eKSWx+B63/sE8b0OHupVIwvXqpkg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Lj4aRquW9+2raNoimFtR4FDFwczqI2J42SnUpFcu06tkWcpy7Iz/lKgFSslpEtTfknYzHNlSRX9kEt8yndYufZcG6m/qOYAmNamdrS12xzmMNudL5364Ty6CUg/6m4yx02HywxY1hD+uMNhV6JvJqy4+MXsa71MYdzlTiqjHU5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jeivBvLd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28027C4CED1;
	Fri,  7 Feb 2025 21:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738965250;
	bh=8QX0PGPdSwxlfa0eKSWx+B63/sE8b0OHupVIwvXqpkg=;
	h=From:Subject:Date:To:Cc:From;
	b=jeivBvLdIOd6jY4aSGurPm7wQX7ljeAnHqvZJXPTSKmGNG5+vQ4NVMx2KzertDqvI
	 h+549x1Hkj0zoIs7ZCSd5Mo1ICu4aGmZgocbZkfS9ZmYVyR1TNuQVe+tyvfyPFIXR/
	 G6UJYDELtO7MOV6y3Wu2QmjA/Zsdr2PD7mRRmpwJ1f7Pd3En3qGiZlNVrmv5URiu21
	 QnvIRiimbgvb+HLWKv7IR1MXfpFJb3WtPW7cIs1E9JCsk1PTioHPviep1r2RCtOBAy
	 4+eIzgOv/epWI0vHPYALiuqNsbqAh0HT0BsdDxAIUSM2dkuEQHgQTFARiPd06XpauA
	 B8iqL7NpKfHMQ==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v5 0/7] nfsd: CB_SEQUENCE error handling fixes and cleanups
Date: Fri, 07 Feb 2025 16:53:47 -0500
Message-Id: <20250207-nfsd-6-14-v5-0-f3b54fb60dc0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOuApmcC/3XMQQ6CMBCF4auQrq2ZTlsqrryHcVHKAI0GTGuIh
 nB3Cxsx6PJN5vtHFil4iuyYjSzQ4KPvuzT0LmOutV1D3FdpMwTUIFDyro4Vz7lQvARTGJIHXTl
 g6f8eqPbPpXW+pN36+OjDa0kPYr7+qgyCA3dCSGNVbdHS6Uqho9u+Dw2bMwOuabGmmCgaAFdgL
 UmpDZV/qUxUQ05GkCwoLzdUfSiCWVOVqLBWoVNgMNdfdJqmNxN6Uq5UAQAA
X-Change-ID: 20250123-nfsd-6-14-b0797e385dc0
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, "J. Bruce Fields" <bfields@fieldses.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2394; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=8QX0PGPdSwxlfa0eKSWx+B63/sE8b0OHupVIwvXqpkg=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBnpoD26+/gG2N5KLyQSo9WWHpKJ+FLS4OudZabY
 robPwKujReJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZ6aA9gAKCRAADmhBGVaC
 FdilD/4ll8LFjU4KL7LHtXoYrLrDXu4MxMXQ6uVVZzH+e61tYUBBZR1l9Dd5FAKhXsOPxtzgCXt
 RAdBVseF5K3vuL+HAQgkxyU2W0DUSaw8cdqxVDKyY9+AUO7Zzz4gTy60AtyUar7jCdI4HyqKq2u
 Rlztw4hsnchRLc6sT8YkhkxIeOVu23lnT9dhp3Gx+ZD6zSQmDW/8jW7dInO2l3CMQsR3uN7ZD3u
 C8UVbNw4CRw7BP3NTmRZNbchY6uWpvKt+6Y43vQt6Uew3SMpiO2lnjU+aZIUgZlP7uhUD8nEmyv
 nEGz1j7s/u1vIT3Ync35TN56JwbCNYudWSmMFKCExxzWq6p874PA2KZUKQP5VRks/kBqESUfid7
 e0D2AtgUmDvm/y0Gq5vOlUZSefgzedtgaEGMPO0k4RTHfTzbr+7pPJcKXi92rf9lzdZ5zh8KW0I
 3sQFBaVqHj8iG3nPJWaLfeP6S1uxf72sBYVhfW1mSFceesK/HVdAXdgy6jvaHHVr8hbExiklPar
 +ydNmqlV/++MbFfzr+NziYnt50PtBt7dyhyDpzQZSq/QwVcL5dzZHPs0+lOzxdk9nKlIoHJFwRc
 ceE1xYaboRTVvcFqvFkZEu6vyYsBPGWtDTfE07RO3vfwj8LaBOTTwJ/X7fiqpEsAQGCjYJYRNBH
 MfF9OYfMX5hxhfQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

This patch is mostly the same as the v4 series, but with the first
patch broken up into multiple changes (as Chuck suggested), and a few
changes to the comments.

Another minor difference here is that I didn't change the code to ignore
the return value of rpc_restart_call() and rpc_restart_call_prepare().
These could end up being backported to kernels that have to handle those
cases.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Changes in v5:
- don't ignore return of rpc_restart_call() and rpc_restart_call_prepare()
- Break up the nfsd4_cb_sequence_done() error handling changes into multiple patches
- Link to v4: https://lore.kernel.org/r/20250207-nfsd-6-14-v4-0-1aa42c407265@kernel.org

Changes in v4:
- Hold back on session refcounting changes for now and just send CB_SEQUENCE
  error handling rework.
- Link to v3: https://lore.kernel.org/r/20250129-nfsd-6-14-v3-0-506e71e39e6b@kernel.org

Changes in v3:
- rename cb_session_changed to nfsd4_cb_session_changed
- rename restart_callback to requeue_callback, and rename need_restart:
  label to requeue:
- don't increment seq_nr on -ESERVERFAULT
- comment cleanups
- drop client-side rpc patch (will send separately)
- Link to v2: https://lore.kernel.org/r/20250129-nfsd-6-14-v2-0-2700c92f3e44@kernel.org

Changes in v2:
- make nfsd4_session be RCU-freed
- change code to keep reference to session over callback RPCs
- rework error handling in nfsd4_cb_sequence_done()
- move NFSv4.0 handling out of nfsd4_cb_sequence_done()
- Link to v1: https://lore.kernel.org/r/20250123-nfsd-6-14-v1-0-c1137a4fa2ae@kernel.org

---
Jeff Layton (7):
      nfsd: prepare nfsd4_cb_sequence_done() for error handling rework
      nfsd: always release slot when requeueing callback
      nfsd: only check RPC_SIGNALLED() when restarting rpc_task
      nfsd: when CB_SEQUENCE gets ESERVERFAULT don't increment seq_nr
      nfsd: handle CB_SEQUENCE NFS4ERR_BADSLOT better
      nfsd: handle CB_SEQUENCE NFS4ERR_SEQ_MISORDERED error better
      nfsd: lift NFSv4.0 handling out of nfsd4_cb_sequence_done()

 fs/nfsd/nfs4callback.c | 102 +++++++++++++++++++++++++++++--------------------
 1 file changed, 61 insertions(+), 41 deletions(-)
---
base-commit: 50934b1a613cabba2b917879c3e722882b72f628
change-id: 20250123-nfsd-6-14-b0797e385dc0

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


