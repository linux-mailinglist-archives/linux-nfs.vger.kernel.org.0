Return-Path: <linux-nfs+bounces-3054-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72AB48B5D8C
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Apr 2024 17:25:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CAC51B2B824
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Apr 2024 15:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31BF981AA1;
	Mon, 29 Apr 2024 15:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YD6BHOKw"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D87580630
	for <linux-nfs@vger.kernel.org>; Mon, 29 Apr 2024 15:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714403814; cv=none; b=ZCkgVoCMiMbdI/wKa8RZOvNyTBkgIYGCG+cOQwZi2MNRgenytQlUVH5d/cBLd5xUV+SgMSXLoRuMwB7qJkGzB355HvZIdECgCdpY1v0QCDbSG/+3ID/DRwuItX0LHLqVVrUjQV3b1ZqA+63pMdMjzJJomBq2eIFGOsfgleliQZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714403814; c=relaxed/simple;
	bh=u+lcC7GhORAvQHVucnqhZJJoAfU0Selqktx68r53c9s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S+Be5vdBPq86RXYZ3ms+dKiKGXOmdFHBtnkny7elG0c0zgf2bVfdpyIvyg79XStiOx6PfqEs1vmbe3+gtu2pqpnO0rDDnT6EftWml7xmsdNvlQ9C/Mg9zsTM5cQU4JY+pOuCCUWPVjvEeralBrOVAKIbaGxp9awhvlt5VnWf/nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YD6BHOKw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3214FC116B1;
	Mon, 29 Apr 2024 15:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714403813;
	bh=u+lcC7GhORAvQHVucnqhZJJoAfU0Selqktx68r53c9s=;
	h=From:To:Cc:Subject:Date:From;
	b=YD6BHOKwfeMRx7Jv0HJo6H1DsYdXqXzL4wlGE6j+Ux7XgIjXJMwKn308mDLYBozxU
	 seNGmma+wt3dXCb/LQaldw1dEUS11MAjfPxAspZxy7jeCY4pBrstd/sFmqd6FI0OGk
	 25/cp3/GGTphu66CcQm2Vc4iLwa7IyTn1ZwhYsxpENDAmWhyd96Tf7ePShr2yLEXM7
	 0eFYHXjauJqHx7lHR6MqDevxRRfS3q1Pj3Maf4IkGvXGIM4FONm4JyLfSvvlkla+qL
	 kxYN995OKmNf+6g3y1T+d/OtbUvHgFxlOeZf5gTaqCudqq1tqIqiSIVddXjcR1afYa
	 fcgyeFGcQNyYw==
From: cel@kernel.org
To: Olga Kornievskaia <kolga@netapp.com>,
	Dai Ngo <dai.ngo@oracle.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [RFC PATCH 0/4] NFSv4.2 OFFLOAD_STATUS for the Linux NFS client
Date: Mon, 29 Apr 2024 11:16:33 -0400
Message-ID: <20240429151632.212571-6-cel@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1159; i=chuck.lever@oracle.com; h=from:subject; bh=cNLTxDpwXihmQofUyKkFDjw6W67Su6KwkcOe83NBLSA=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBmL7nQiABPucD3sQQOTaXGE5aNPa8EJJ7e1vr/O 6T6kOS8LFeJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCZi+50AAKCRAzarMzb2Z/ l9K7EAC3AbWvlBcMo/YaHggxPOVYeDfiBFdFuBicR+/Mir2V0lG+YNAOJMUuplQx7IoJDh0MWKH WtvNscX1f/yogJIx7A5fYhN5rlBUWd50dbK5JBKBYQuqtPy0bbAvYs33lo4R0XJqp51GlpD8vHc HkTOoiIwp64MRqUElTsZaizgtDBKYIuBCAKoT2pq3ZWpcaVUpCJD9QU1KNk4uC2SpQzz+e28DQe 223Ua8HhaPVdGl7pOQJ/OV4z++42rk6G4Q29c4ZsV8NSEeVQbbLKJuCOmQ/F9anAWmCqGjaqBZs +XU5xkWGkjv0byTPUnVvNIzcC+38k5+3TfLqLpQ66DrCtziQ5+915SMpkdMPciem4qkwY7UTDN7 +9q4bXK2y7AizotQrBdrUHatSmkh+LdvZfrwkfSUx6kJ+YNP3Hf8FbOhkgYjW8AebCULxH6NqGv 6ESXSRL6q6lOPZSCOinO4zOo/KJEpd04tsIDM9jyV1/zzAIQKtD1ddXNxYepzApbd5scy70gpfY fbYsZOkt2NfL2YwJaSvkih7lPr0YXi/lN52sKBAtMcPmr0zE1WpwFgvrfVUxP5KXMIxAmLTUTKa sadvPADuPRzBX7hGMwSDSjHS8AYygjY5kOy+xTmlSZV9cM4C2bamXR8O6NpWzgPmv4iqbKZKVbI 3hV0EPGmq8MknUg==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Async COPY operations will wait indefinitely if the CB_OFFLOAD is
lost. Fix this by using OFFLOAD_STATUS to periodically check the
progress of the COPY.

This is compile-tested only. Looking for review and testing.

IMO the only controversial part is how OFFLOAD_STATUS will handle
situations where the server is temporarily unreachable. Right now
I've set RPC_TASK_SOFTCONN so the RPC is dropped immediately, and
the COPY operation should simply go back to waiting another few
seconds.

Chuck Lever (4):
  NFS: Implement NFSv4.2's OFFLOAD_STATUS XDR
  NFS: Refactor trace_nfs4_offload_cancel
  NFS: Rename struct nfs4_offloadcancel_data
  NFS: Implement NFSv4.2's OFFLOAD_STATUS operation

 fs/nfs/nfs42proc.c        | 114 +++++++++++++++++++++++++++++++++-----
 fs/nfs/nfs42xdr.c         | 101 ++++++++++++++++++++++++++++++++-
 fs/nfs/nfs4trace.h        |  11 +++-
 fs/nfs/nfs4xdr.c          |   1 +
 include/linux/nfs4.h      |   1 +
 include/linux/nfs_fs_sb.h |   1 +
 include/linux/nfs_xdr.h   |   1 +
 7 files changed, 215 insertions(+), 15 deletions(-)


base-commit: e67572cd2204894179d89bd7b984072f19313b03
-- 
2.44.0


