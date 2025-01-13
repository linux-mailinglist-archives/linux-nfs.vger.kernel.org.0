Return-Path: <linux-nfs+bounces-9163-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC84A0BC10
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Jan 2025 16:32:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8686163A16
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Jan 2025 15:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ABC01C5D49;
	Mon, 13 Jan 2025 15:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XRJudsTL"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56734240225
	for <linux-nfs@vger.kernel.org>; Mon, 13 Jan 2025 15:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736782366; cv=none; b=qnmlQ6KyJclgV43ktQedttsSG0CM3qeHGaT8HcdfrBzgJ46LB2TDWNI+z5spFWklQ0k4ZXmaN5QH7LpcY0yQAUzM+AtrFFQe1aC/zEyqVrOcN8sKwiFqekkIPJYufqMzBvVCrgMC92xqCJvr2LfXEvsSuKbfyhAsY80aqmGCjsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736782366; c=relaxed/simple;
	bh=wOueoAEORare0XRlsNjXFrrdfXUcE+FImZmILjJbpqk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pC3xFP/ESXRGBByRHCvjyfDQuVZ7sv3qcUGMUw0g+ZCbdwmnOvLQr7GXn8o2jkX/I32gFCUak2Vm3Qjvvyt64iBeeT6T4kJTv5kuh19ap7xcwaEC/schM5WGtUxe3EtPNkt1L0FSARXc50LIurCXi8K/SEgQQ2Au8FiIjNZhO3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XRJudsTL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83174C4CEE2;
	Mon, 13 Jan 2025 15:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736782366;
	bh=wOueoAEORare0XRlsNjXFrrdfXUcE+FImZmILjJbpqk=;
	h=From:To:Cc:Subject:Date:From;
	b=XRJudsTLh3T21tDu4KrNIlHFZRDNingIGThnVeEUZegwrON8dRNI76/Pupt3AUxUE
	 gxyR5cCngX2asRqXCUYrTO8dGVIt6x6GC5NqZ57Pcihcg64d/mAkN2XAVR5Q6gLqcC
	 9/R1YvX4Z8Y4wxAcZ/8nnfS267SHbnmEMeCBhzk8956udDo7IgNCpOebkBrUS/T992
	 sv8oTb4wWxyMJPmoQLRHlWMHPvdiQT9rCqivQqZZT7QzJQQsAo89994rUAxTqTyjGW
	 cdGR3FD4vWhTivn01SJK/6l3InEHIG4RNaBjDwfSNT1yuVg+f7+6MV7j3NmukyTQxo
	 lcFYHG6egVaIg==
From: cel@kernel.org
To: Neil Brown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v3 0/7] Client-side OFFLOAD_STATUS implementation
Date: Mon, 13 Jan 2025 10:32:35 -0500
Message-ID: <20250113153235.48706-9-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1628; i=chuck.lever@oracle.com; h=from:subject; bh=58D/nRejx037dycbiOmMBT0tNRbSTiYQ3ICQ12w1Mt4=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBnhTIT1HipTYurOx6bDmkTIPDNaEEZKt8InhgZf MRQMzZAHXyJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCZ4UyEwAKCRAzarMzb2Z/ lyT3D/0Q0Kir5eBB4gRMo8hxRW2VleqlqIj9fXqUmzWPPfcrT70krJySLojOoimOfivezQdmeor Y93xXHtC1vNBk9cB1NNfMpczpEikixYZt43lmA6WFLkm6CpVcmWFTl/2g2HVafIk2DlqA6y0lOe CffRtu4jSTQc/m+DYQp8fI3NvGeikzzqimcxfPlIZ4JZptJ7iz7fZRvyDluNjfSiWRMWkokI8Dg oUXYHkUuUDsl7Q9tpkuZCy4RhVexpMetUgAdgrcoCLOSTgLIwJLCAuyhSZzCW7WPtRd6POvvjwu FfFF0nFEhnesfVevj/FXWenKDdeL4TY0nLMNddkgXjwu4XNkZ42uSgYzOel9++8eD9+EEe9s6h5 rQQxdf7E14YA5gtCstTmpBmmlSsCxGJHNUmyilYwC9v6ZSEz77xKdzN0uhwSRhonZCpuTkJhoIj UdUNojGQsRv0S+gJW/enSODKxuKVrSKPcqQSUUaqJ29QrjLahf0jBuzRA/L+t3gLVpMpeGcr+Dc Az1XH/n7hqJ8LqEJYmeyxnBC9DcGGH7PugXBsF1drXFnbg/66zVI/LFHGKhw6agltU9XpoOWOqG CybDILDRyeafga+/gDfmBi20hCRHCgjxVVowzzhNP06367YAj3fL1QxNT5IcT8h0HDKm903BO5b sTG1RBKFjUZu55g==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

SCSI implementation experience has shown that an interrupt-only
COPY offload implementation is not reliable. There are too many
common scenarios where the client can miss the completion interrupt
(in our case, this is an NFSv4.2 CB_OFFLOAD callback).

Therefore, a polling mechanism is needed. The NFSv4.2 protocol
provides one in the form of the its OFFLOAD_STATUS operation. Linux
NFSD implements OFFLOAD_STATUS already. This series adds a Linux NFS
client implementation of the OFFLOAD_STATUS operation that can query
the state of a background COPY on the server.

These patches are also available here:

https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git/log/?h=fix-async-copy

Reposting to restart the review process.

Changes since v2:
- Use an exponential backoff before posting OFFLOAD_STATUS

Chuck Lever (7):
  NFS: CB_OFFLOAD can return NFS4ERR_DELAY
  NFS: Fix typo in OFFLOAD_CANCEL comment
  NFS: Rename struct nfs4_offloadcancel_data
  NFS: Implement NFSv4.2's OFFLOAD_STATUS XDR
  NFS: Implement NFSv4.2's OFFLOAD_STATUS operation
  NFS: Use NFSv4.2's OFFLOAD_STATUS operation
  NFS: Refactor trace_nfs4_offload_cancel

 fs/nfs/callback_proc.c    |   2 +-
 fs/nfs/nfs42proc.c        | 190 ++++++++++++++++++++++++++++++++++----
 fs/nfs/nfs42xdr.c         |  88 +++++++++++++++++-
 fs/nfs/nfs4proc.c         |   3 +-
 fs/nfs/nfs4trace.h        |  11 ++-
 fs/nfs/nfs4xdr.c          |   1 +
 include/linux/nfs4.h      |   1 +
 include/linux/nfs_fs_sb.h |   1 +
 include/linux/nfs_xdr.h   |   5 +-
 9 files changed, 277 insertions(+), 25 deletions(-)

-- 
2.47.0


