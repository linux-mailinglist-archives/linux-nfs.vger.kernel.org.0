Return-Path: <linux-nfs+bounces-8331-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C6FA9E2B31
	for <lists+linux-nfs@lfdr.de>; Tue,  3 Dec 2024 19:44:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0FA03B21865
	for <lists+linux-nfs@lfdr.de>; Tue,  3 Dec 2024 16:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 162AE1F4283;
	Tue,  3 Dec 2024 16:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X+UEuZ6i"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E545418BC1D
	for <linux-nfs@vger.kernel.org>; Tue,  3 Dec 2024 16:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733243359; cv=none; b=tJJfDXSRRVVXWhL9y3QXlQtjcicN+aHo+1I1bHgoZfr6JV7tg7O6B2SfJdFiuyZlRif9K2h6YcyQJ1nTyn2cZYLNOhaJdy06J9EJg/TFRzoIuUI6bxkrvUb8uO6HLgHBBp8AXXM87sMVLXUBRSwD9AJwV5NvbG1AUYoah5eNTFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733243359; c=relaxed/simple;
	bh=vuJcrKJGCfyxBIfoRVcAqChfPRs7HYPC8SKAWuARWFo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AQYGSAqgQCOFTMUXzHjE6zhCEgZlQB2G0H2qAUNEjK2ZpLj98OtY6TVK+ks+/fdkQn1uTVUQ5JOpBdmasMFRZxaMjjkhwMJjmDrWJF9OjEP1/6IKjiHX79jiAWqDqUxxzPkUmjtT0Twv/31YByoReUOwSlNTbCbBxIaRiHhbvl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X+UEuZ6i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D0B1C4CECF;
	Tue,  3 Dec 2024 16:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733243358;
	bh=vuJcrKJGCfyxBIfoRVcAqChfPRs7HYPC8SKAWuARWFo=;
	h=From:To:Cc:Subject:Date:From;
	b=X+UEuZ6iuKAnqXtRulzVd9KAyx6g+7YS1v/KT2yKVHa1H+h8PCyZcom0tnL75x2mi
	 ia7R4AkvZUqqKdelU6Vt/G23n98Lrn5gYEaq0sv96Y/rIeaOoS2tI3W7VEVCkNqvOd
	 6L/WJ3cfpFD3t+SekHNI0+ebmx6XqgPfVGjaCn0XkJxNzh0OiMuhJmhjDtIgFEpmgk
	 fNQbWeTJuMXebI10XXtryypjX/RErbtDb+3MloxEC4Eu2pBsc+mW6huVCDBmbiLAIl
	 6vUvlse01mwIMj+mhiX/lYa2esYZxRyFlrgcCNeKa0PF7192sHXUB7jmwXm2IvqUID
	 KYiurjR6u/WYQ==
From: cel@kernel.org
To: Olga Kornievskaia <okorniev@redhat.com>,
	Anna Schumaker <anna@kernel.org>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v1 0/7] Client-side OFFLOAD_STATUS implementation
Date: Tue,  3 Dec 2024 11:29:09 -0500
Message-ID: <20241203162908.302354-9-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1491; i=chuck.lever@oracle.com; h=from:subject; bh=C7/U2aiNJzKLFLwCW1YLH2ohfnHgo1jbeigY9zFsENM=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBnTzHUZlCjM5zYZrGmkIgSLfm73txmXjaWCeCCP fExVgqvFOaJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCZ08x1AAKCRAzarMzb2Z/ lxdYD/4op9ZDDloRll0f1hqtVXEYyQnwGNHouYF/zJEftYdTkYbSDj2JN5/vlkyQC66Y1wwHkHy cnPZDWx9FuZAbWHqFuY0p0YnGfwvQvLNz7FiBDvQfbJyyKNX1hOR1chZNLCPc0fA5TPMr/6IdNf xPopCOkEUQoKMCE1gWkrjQHztUXzT0c4lgY0RYJib2xwVX4sOUVj2xHxiNDSbqBpP08pxj+rKh0 AEMmuVlw4emOH3Oqot+vvakgYYHfPp2U4BA88j04s0+BVafrTzdqJoh9HNpXKeom7pCr54Hg4UA s19wyMhFlDiDwDkIg5+JCzsdU8ySQpdUTIVeFwi0uOvJFbWThbpzEQ6LmP8/ks/9aCjvZbxRXgq 62yhzs9DqVpOSMcNCCZeWKJVQZO2QgYqoRU1WLz9kFKnEsLj77CBb0U8cfq4ckXxQFvLBThfqjc o6e1vOYWHPgURlDEhO7Ymf78zvmkQ1yWwoBlte+6mZP+H8rldzvD5+hqMFI2qXu9yqN05kqPPkE Q+BBlgqGwuOA7oNQ7ZIUd7CKwL/6VonEA/ANo1MrHHTWVGl2YHFwl33scDNJ8DHwoyJG3G3dUzE oandDqEldgBn1Kx+RcFpODx0DBtl5KHr9mZFN+5rLM1pRDPLzTxc9lCjy2C8LBs3jm/X2KAL5WM Xi+Emw9gFdELilA==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

SCSI implementation experience has shown that an interrupt-only
COPY offload implementation is not reliable. There are too many
common scenarios where the client can miss the completion interrupt
(in our case, this is a CB_OFFLOAD callback).

Therefore, a polling mechanism is needed. The NFSv4.2 protocol
provides one in the form of the new OFFLOAD_STATUS operation. Linux
NFSD implements OFFLOAD_STATUS already. This series adds a Linux NFS
client implementation of the OFFLOAD_STATUS operation that can query
the state of a background COPY on the server.

These patches are also available here:

https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git/log/?h=fix-async-copy

Chuck Lever (7):
  NFS: CB_OFFLOAD can return NFS4ERR_DELAY
  NFS: Fix typo in OFFLOAD_CANCEL comment
  NFS: Rename struct nfs4_offloadcancel_data
  NFS: Implement NFSv4.2's OFFLOAD_STATUS XDR
  NFS: Implement NFSv4.2's OFFLOAD_STATUS operation
  NFS: Use NFSv4.2's OFFLOAD_STATUS operation
  NFS: Refactor trace_nfs4_offload_cancel

 fs/nfs/callback_proc.c    |   2 +-
 fs/nfs/nfs42proc.c        | 205 ++++++++++++++++++++++++++++++++++----
 fs/nfs/nfs42xdr.c         |  88 +++++++++++++++-
 fs/nfs/nfs4proc.c         |   3 +-
 fs/nfs/nfs4trace.h        |  11 +-
 fs/nfs/nfs4xdr.c          |   1 +
 include/linux/nfs4.h      |   1 +
 include/linux/nfs_fs_sb.h |   1 +
 include/linux/nfs_xdr.h   |   5 +-
 9 files changed, 292 insertions(+), 25 deletions(-)

-- 
2.47.0


