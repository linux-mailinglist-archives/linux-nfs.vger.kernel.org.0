Return-Path: <linux-nfs+bounces-10421-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EAC3A4C9ED
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Mar 2025 18:41:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3B1718867CC
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Mar 2025 17:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87DBA23F26B;
	Mon,  3 Mar 2025 17:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cVFIW2aB"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FCB823ED76;
	Mon,  3 Mar 2025 17:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741022777; cv=none; b=rRv48nCHhD8j/M4W15YojEq5Q3BRM1kfCDWQ+Uxd0TTCOtF1v70k34KMkzqKTAVAcMtq5jeqk28GBXcV3X1jsg6+bgG21FfdUAFnD8/OH8SO1hTCmmS6cK4DtVot5ModjJFq3+gAcpPWt3W7otj22xbiaqpAUIb2t6Ro2HvhkN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741022777; c=relaxed/simple;
	bh=M3zwmPSFyDgRrbI26d67suhYPxb/JbKj+ArYoTc5fh4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=c+3GZGAmBs/cONlGAhHWKDiNeQwJqLoQFi/H8xlK2q7kfLthpRJXHYMYe6/3SrsD5LpySJykYvEMu6PnybDCZlOGZGihScqX+1EveYjrDK9t82LxH8PcFZF68Foumrursro8ZOFrIdu125oRmQQlw8VCAC+e7M5vGroD3clLb1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cVFIW2aB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ECAFC4CEE5;
	Mon,  3 Mar 2025 17:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741022775;
	bh=M3zwmPSFyDgRrbI26d67suhYPxb/JbKj+ArYoTc5fh4=;
	h=From:Subject:Date:To:Cc:From;
	b=cVFIW2aBKZ1xdR79K2vD1mE4TJ1NBA+Jsb+SF1OeuCIe4pLAsRHV5d0zyTiN5lIKD
	 EezndNkh55tDbx17Wp77fhrBFSnjTXVHb6+cCiibHqn19VNaTCx/TR5fL4iJCG+iOM
	 52r5VSR0qJ0p0wz3JRZshcgxjqrr+eWWRbtnn3BBF9pEurX/sz9WKQMsRsdbmz0weD
	 ZPs9m3wcyrwxibLrUSGcMQg9kjfe+P5b1nCZPmHr/bO+UFrrZI0IZk3gZIHwgIl4l8
	 9TdBjnQ3EgeaIJ0CJqiRX4QWi70Eh3MDmub7R7OhULilDXoLIuec6A1nbyRmroFyWG
	 rFIjwwVn/AlEA==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH 0/5] nfsd: some small cleanup patches
Date: Mon, 03 Mar 2025 12:25:58 -0500
Message-Id: <20250303-nfsd-cleanup-v1-0-14068e8f59c5@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACbmxWcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDI0Nj3by04hTd5JzUxLzSAt0kk6TUpCQLAxNzoxQloJaCotS0zAqwcdG
 xtbUARkIY0F4AAAA=
X-Change-ID: 20250213-nfsd-cleanup-b4bebb80472d
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=830; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=M3zwmPSFyDgRrbI26d67suhYPxb/JbKj+ArYoTc5fh4=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBnxeYwNYtLej2MmQHZsZXV8jPBurrGgEjWhRfMV
 R6GiheOJoiJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZ8XmMAAKCRAADmhBGVaC
 FYfUEADGesxDUAYHX27SKNHsno2Xg8ydXb+ZwGhP8OuYB0tQO2B/piOZtT95PVYAAMWoEvq17fP
 QExVkfEtNYEuoF/AQPQg+vKynW6eDeWXvrYiY42npakmVIm3s5dDAWbosgNva6qk/MqZpnzxIo0
 UqWULr0bWj2ZHKOyFLz97/IxyH8WjjjdiqKCuXMfrfA0K3aGjyMLyanIe14y2LRhIDp3yLGKNfl
 cQRGw8wqQ07nOi+0EmdyHcxK50HbytTr6IrbjLVMydG0qU+AYaSFowjxWRL+X/oS+C10dR5x7cj
 vl2fR8ZBslXMsxya1OgTXRo8OgDojIxRliYlrSP4DRN885wi8DxJoWQD0xCRPmIsRk3VlGjwgPR
 +i5kpgF9+ql1SEhejoXYXgijmyPzdZhKliE1idhd5jsl8+2Cd6FUgvDFucOf7dynVXuNNdSG4kR
 1CAnwNYI2uJ8ToJvPiwWBbwUeJUnCSO2ratPwPJKLD87G933j3Fq4nqWAnrExYSie+z71nigoRf
 Q6y9hVXSm4Wz3BtLBWXApNhRjvHQhhZGFA4/TD0cD+kNb04+nKUsc9L29+XXCphubSxG+YTtQp5
 DJ7lRS5llTqHDQj3o9tCfczdxe45Kh9GcsyCr5z4CcNM48dpJmCb9cJ1JfKzb1mpPBIYneonG0M
 fudQXgYr5+e1OUQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

This is a pile of small patches that I've been collecting. None are
terribly critical.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Jeff Layton (5):
      nfsd: reorganize struct nfs4_delegation for better packing
      nfsd: remove unneeded forward declaration of nfsd4_mark_cb_fault()
      nfsd: remove obsolete comment from nfs4_alloc_stid
      nfsd: clean up if statement in nfsd4_close_open_stateid()
      nfsd: use a long for the count in nfsd4_state_shrinker_count()

 fs/nfsd/nfs4callback.c |  2 --
 fs/nfsd/nfs4state.c    | 20 +++++---------------
 fs/nfsd/state.h        |  2 +-
 3 files changed, 6 insertions(+), 18 deletions(-)
---
base-commit: 7dc86d35a5f8a7ac24b53792c704b101e5041842
change-id: 20250213-nfsd-cleanup-b4bebb80472d

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


