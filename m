Return-Path: <linux-nfs+bounces-6928-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 804FB995090
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Oct 2024 15:47:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35FBB1F21674
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Oct 2024 13:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D76A1D1302;
	Tue,  8 Oct 2024 13:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TXAplIgg"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7B513959D
	for <linux-nfs@vger.kernel.org>; Tue,  8 Oct 2024 13:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728395257; cv=none; b=GTY43tVW5wL7wS2AFL66/qDvrdnP0gbbybAvfsW9bLIomYq10+n981yhBLxWi6NFJpzrgPj24eAXvWdEfmqnobhhTw1VlgojLd7Tr1aM/x7x5seEW/yoS+sltxbO5DCYE3xYAXDo8APRKzEQQAq1Gk94poHyc+kdH720H8AfRLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728395257; c=relaxed/simple;
	bh=+e0kH6bCA1Yr7CyTTkq1jxgosWMH+IKZoZMrUHwYlq0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eA2QZG04KHXPa4b6HXUGfLlV3LkiNAKMdf8ua3wLZrhIHN8O024sZJXsViGemzHPaPP46ZgxKTiBWid3Q5hRtKlVOJLbm61KdRLitWj+kwMffZHYwwRxWIocwCj11Wu/OIZy6jgm3YuCz1FLMEBoR8tDsOSzEtLCQeKPwDCexCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TXAplIgg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8B98C4CEC7;
	Tue,  8 Oct 2024 13:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728395257;
	bh=+e0kH6bCA1Yr7CyTTkq1jxgosWMH+IKZoZMrUHwYlq0=;
	h=From:To:Cc:Subject:Date:From;
	b=TXAplIggXRRsHFwURnMYhxBdfPLNlIotbABs0rzwVAe4Y/OkKY4ug2IBV+ksuTpmp
	 LGTTbBYe7Md2tpoajbYRM/X5gGvwyJlYxkX193g7kBOlXq/0ZfetypxhVQG/qvduYp
	 nCBOEuu8uXE2e4LdI8KjvDYOC98koGmK7VNjXheX3kej2sjkEMZWo8NlNWjPsngN+X
	 xLgk+rAMs+WY5jutaGjxwD9THeiRsSIXh/fnHlYKnA9XrZ/aDW2vnGjb/qKIrVQIsJ
	 CYcECQyo13zGA+ZnrzXZIxR5uGGU2dBdPwjabfxsVA3gdDxTx1FDHV/HlWEZ6IlBJ3
	 9FFSOQgFVnB4A==
From: cel@kernel.org
To: Neil Brown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [RFC PATCH 0/9] async COPY fixes
Date: Tue,  8 Oct 2024 09:47:19 -0400
Message-ID: <20241008134719.116825-11-cel@kernel.org>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1779; i=chuck.lever@oracle.com; h=from:subject; bh=/HCqJc7wrRIpBhO6fseJvFIIbn8kmTn1yYEd6w995kM=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBnBTfnsK4cMtQrFtMcGlF0qKvAAqLk8Yjk+ql47 BLoWa3RRVqJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCZwU35wAKCRAzarMzb2Z/ lyo6D/9SaAg/Zao3m5no4H1mxuv9LikxHtr5OGxQe9lZDxp+sA2MfHERH8E8HhYs1jtpJHzeBTM wKn8DFJ3CO1H6FFnG6wdondAMPNOKWrFlxsvGAPJKyDg48H4vjzKGgx7p4/vRItw4Ub+XPB/imS GYDWlbBtDV2/b8DvwhXkWFmQozUVGtduiMBfhJL+4edumWJKHYrSh3O0nmnwoLpsl8rXLVrpumH DP1tJ/j+ubdXCBTuFNAmI+JHkAGG1RPUjCmbOVgoPo84e97okYvMYTQ3a9JBvs5+PfKV4sTFMCO 5f6OfogJ32GqFb1dsVzaD5Bee6wUvGtd8ZdCSDi4WhftrDktcqX6wDItb+K9vo99yTQILEyuuRv QdA7zuOzgSn7dlATDPobO4ztlBKh9G9ZmTssaSYJie0gQtae0+nCrCbjaU734+FFCs4JnayA+vU rRNrVgoggn/zMwVoillnsL9yUpSjmJygkbILxmxfdBCgtL0K9ZsVC7GclNUIMLPsoP9l8KWacbO QzHUj70zr+Y7dTZtAVcZ927oV2T4GlwS7tKZhNi6tybALZkjebdaFIr8RwxapR6558b0jByqAMA WA0oKBLobW7ts40SAnqcQwfobLkNJ9YOR8zzqf8yEO9vawCIb7NYplGgPh2y7Gqblcv/hfrNP8g TWTqJ1Chjb5jQcg==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Hi -

There are edge cases on both the Linux NFS server and client that
can be improved to make notification of COPY completion reliable.
This series accomplishes two things, primarily:

1. Add support for OFFLOAD_STATUS to the Linux NFS client

2. Modify NFSD to keep the copy state ID around so that
   OFFLOAD_STATUS can find the completed COPY

That should be enough to make async COPY reliable so that it can be
enabled again in NFSD. I'd like to shoot for doing that in v6.13.

Due to other bugs and issues, this has unfortunately been somewhat
of a background task lately, so any independent testing would be
greatly appreciated.

When we agree that these are ready, I can split them up so they can
be merged independently via the client and server trees.

Chuck Lever (9):
  NFS: CB_OFFLOAD can return NFS4ERR_DELAY
  NFSD: Free async copy information in nfsd4_cb_offload_release()
  NFSD: Handle an NFS4ERR_DELAY response to CB_OFFLOAD
  NFS: Fix typo in OFFLOAD_CANCEL comment
  NFS: Implement NFSv4.2's OFFLOAD_STATUS XDR
  NFS: Rename struct nfs4_offloadcancel_data
  NFS: Implement NFSv4.2's OFFLOAD_STATUS operation
  NFS: Use NFSv4.2's OFFLOAD_STATUS operation
  NFS: Refactor trace_nfs4_offload_cancel

 fs/nfs/callback_proc.c    |   2 +-
 fs/nfs/nfs42proc.c        | 198 +++++++++++++++++++++++++++++++++++---
 fs/nfs/nfs42xdr.c         |  88 ++++++++++++++++-
 fs/nfs/nfs4proc.c         |   3 +-
 fs/nfs/nfs4trace.h        |  11 ++-
 fs/nfs/nfs4xdr.c          |   1 +
 fs/nfsd/nfs4proc.c        |  26 +++--
 fs/nfsd/xdr4.h            |   4 +
 include/linux/nfs4.h      |   1 +
 include/linux/nfs_fs_sb.h |   1 +
 include/linux/nfs_xdr.h   |   5 +-
 11 files changed, 311 insertions(+), 29 deletions(-)

-- 
2.46.2


