Return-Path: <linux-nfs+bounces-9551-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F69BA1AB3C
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Jan 2025 21:28:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03DD71883A8F
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Jan 2025 20:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C68C81C5F20;
	Thu, 23 Jan 2025 20:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B1l8/HJv"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C6C1C5D62;
	Thu, 23 Jan 2025 20:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737663935; cv=none; b=q9lcFpTlAtuZAI8Ws62Cs1xRlApG6rLOGSgENAdafLOGgZx4F8eWhkwk3mRO0OqeidRxWtoAorfa2JqxEKV+Rnk6/yTIWOJLm1TONx+a8CWNWEXAJT1weyl5oxGYtDbQGby8pdPS6YL9sipzhB7sN23lw9qfT/g1KI+4rTGmCoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737663935; c=relaxed/simple;
	bh=InyBiJX/ZrPVjzxsBNdprnqCrCMGTNTHttu2kN3J+3A=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ikp59aOM7lo5t/Mu1fYqQYs4Bhs5LKvLAvDjDdy+YW8uVfArsDMUbMPFJlitvOZ+lHwtQc/fB4TSTczM8ZND4/5KR7NIdY5ytfxm1IZa/1A8OPmoYawqf5Xr9ZJo6cfj+/MvHIN7u8dY+utrKIBM6hc9owgQGL1Pa2lo8V7+4Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B1l8/HJv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A761C4CED3;
	Thu, 23 Jan 2025 20:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737663935;
	bh=InyBiJX/ZrPVjzxsBNdprnqCrCMGTNTHttu2kN3J+3A=;
	h=From:Subject:Date:To:Cc:From;
	b=B1l8/HJvYp9w4oLdxgo+rfXkz/Zioh3JQkn6IDo5THV2cTKOxhhr+OIxBH7Quc1X4
	 JgGQ21jabilC3K/GVCzJIFDF/McctbkqYcf4Dx5M8PkuL6PORsPfnL7pDV+DnPoZHW
	 FItMdaUT5ayLp1dwoDZlpYSDbDG1byfjCplFK8I55HeyKOstLeqMMtZBLYS/omjIyj
	 uHoEPJapT6Qe9HseNqlWbcQDJjBp3eBwgfi1ZWIHfafpZc1NC1MKnLEjkllujDR3JX
	 sKvm0nVh8TpKpuuOrp5EUctGCliG4Kkl7ZW4sDGo62mzbs/huHB776IEg5XJcFKrLW
	 VzFCuDMIy/+hA==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH 0/8] nfsd: CB_SEQUENCE error handling fixes and cleanups
Date: Thu, 23 Jan 2025 15:25:17 -0500
Message-Id: <20250123-nfsd-6-14-v1-0-c1137a4fa2ae@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAK2lkmcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDQyNj3by04hRdM11DE90kA3NL81RjC9OUZAMloPqCotS0zAqwWdGxtbU
 AdfVgblsAAAA=
X-Change-ID: 20250123-nfsd-6-14-b0797e385dc0
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, "J. Bruce Fields" <bfields@fieldses.org>, 
 Kinglong Mee <kinglongmee@gmail.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1550; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=InyBiJX/ZrPVjzxsBNdprnqCrCMGTNTHttu2kN3J+3A=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBnkqW7DC5ulbQLNbJnWLLi0FuKmMGANycWQr5Gb
 LIS97fL8kCJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZ5KluwAKCRAADmhBGVaC
 FfGBD/96BcnS1gx7z1ubD5AbyZcZOJ/QAu/MfqBIB+AXp6XzgRjjlAVkA690Z4LEQA+mliKQAEo
 Pzq11f8MYGyfumQqIn+i2EL3sH+lGVHkeTDCU0AyIYkkYiyOGh1sUAOGoX63oHibB78+KT7DXVG
 JfIT1/lWbbNBcL5wXpgReVP65iH4XvgE8tSfuoTswPvn31eZEKdq+d9BDycNO7RBq46k610FAzz
 8kZ0egcYoM65qz+hCngg6eZtmRMiCcZ8A1l2S3X2o2Ok/pJapwANNN1ThF37KuzudYfxyGoo9V8
 Iu+2a7t5KVFHs7eRqhecqO5eHtJG4ZWDhLFerNvPqxDsPfAzlpQV1LdGk+Ay3PWvjYI9oSNGvH2
 y7auyU6YphWMlcaOmWhqD2GLc5TaJci05qJdmff8jOElY/abStpaKYF7Ql9gEqKJprSSpk8iXsD
 T8vGogOD/HAlxtnrNsNNlLYHH/NtkPgypCoXbW6BjU4l9rBpvC7DlWJBpXHEAfk6LMWQ4f78gn0
 A14I1cHUxJpeK4Y7zRU1VN5+BrL9CaHNozyKjixlJlU/5vx6odPOQXEojgeg2mm2gQoTCohLx79
 iaJG4vkL32y5xzlZC4j1wygYpXzYdtMVUURMBz90n5fH45gPBmOI5MzDPEiy3X1kekwGeNiuuSp
 JLiGOKSes7EHtPg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

The first four patches fix bugs in the CB_SEQUENCE error handling. The
last patches are cleanups.

These are only lightly tested, mostly because we don't have a great way
to test backchannel error handling. I tried to keep these very small so
that we could bisect if there are problems.

These should probably go in via Chuck's tree, but the last patch touches
some NFS client code, so it'd be good to have R-b's or A-b's from Trond
and/or Anna on that one.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Jeff Layton (8):
      nfsd: don't restart v4.1+ callback when RPC_SIGNALLED is set
      nfsd: fix CB_SEQUENCE error handling of NFS4ERR_{BADSLOT,BADSESSION,SEQ_MISORDERED}
      nfsd: when CB_SEQUENCE gets NFS4ERR_DELAY, release the slot
      nfsd: fix default case in nfsd4_cb_sequence_done()
      nfsd: reverse default of "ret" variable in nfsd4_cb_sequence_done()
      nfsd: remove unneeded forward declaration of nfsd4_mark_cb_fault()
      nfsd: clean up and amend comments around nfsd4_cb_sequence_done()
      sunrpc: make rpc_restart_call() and rpc_restart_call_prepare() void return

 fs/nfs/nfs4proc.c           | 12 ++++----
 fs/nfsd/nfs4callback.c      | 69 +++++++++++++++++++++++----------------------
 include/linux/sunrpc/clnt.h |  4 +--
 net/sunrpc/clnt.c           |  7 ++---
 4 files changed, 45 insertions(+), 47 deletions(-)
---
base-commit: 0ab8e05a5a694a1e4c6854a98f08a477d16b6aeb
change-id: 20250123-nfsd-6-14-b0797e385dc0

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


