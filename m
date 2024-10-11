Return-Path: <linux-nfs+bounces-7102-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9209A99ADAB
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Oct 2024 22:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E5E01C223D2
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Oct 2024 20:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5CE01CC162;
	Fri, 11 Oct 2024 20:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O57dnpkz"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9154B199231
	for <linux-nfs@vger.kernel.org>; Fri, 11 Oct 2024 20:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728679590; cv=none; b=jtBY66z7n6dGTQGSLDJvbzJKis9XBGgyhhIh/+5KRPpmmsOsjZUhTxvVMXWXBnsTuRP2y+ccv1voP7Vphxc5rK+tey0MFv1xEAYG43BNDiR5bIeBifEX8SOSSuusqfdRdAOKSaATa2eyRO+4pBk+it1a2O5aBl1E520wVq2jHLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728679590; c=relaxed/simple;
	bh=fsZunknaAH7KAPL79VQDBpsYTQoF/XUtTWtz88nCoWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Et/SklQfxacRmYqt9X8zLa+mD2DxKjsjqwot5AT3Mob2ovQZusD9IKUIZ7Tw0MGSvpbojF9obYhMSKZNWbAeNu5VetNZpInpPu7EeD8rWbO0WQPDLkqsxuYSE1zftICKpkB0wYdo01dsxp946gl1o8Cltt5vAbcvyC1QQRqKVHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O57dnpkz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1A1CC4CEC3;
	Fri, 11 Oct 2024 20:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728679590;
	bh=fsZunknaAH7KAPL79VQDBpsYTQoF/XUtTWtz88nCoWQ=;
	h=From:To:Cc:Subject:Date:From;
	b=O57dnpkzvuEZ4bv6fLLQZBBW4pFRAkPKJWeIc0r1NCZbr8guH3EDu8l50Hs0LJSaA
	 qqiGp+PDGjMpVXmGkGOeyuQLUtILcIlQzFPqf7W1z6KV3xuCpF/OgKPgEqsi/S6q1l
	 T2+7XRQ/NTcII9LIJWxvSF28L5vzra+XkOSUQ3lWdOW5vTBwSMkOyHi1zEF8ZZy1fD
	 4ekY/V4+tca6dZ6C2lBDi63CbLY1PHn1RIS3aP/L/yI49R69Kba2ab/Vm4FJwHiF2g
	 e9Bi1Iz/jSSRGRCF4v+Hdk+bpRDMgmqeG63TZU0htk5uurk3r/xzsGFkvTqVB0RilS
	 /LI3xRQQBt16Q==
From: Anna Schumaker <anna@kernel.org>
To: linux-nfs@vger.kernel.org,
	torvalds@linux-foundation.org
Cc: anna@kernel.org
Subject: [GIT PULL] Please Pull NFS Client Bugfixes for Linux 6.12-rc
Date: Fri, 11 Oct 2024 16:46:28 -0400
Message-ID: <20241011204628.270296-1-anna@kernel.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

The following changes since commit 9852d85ec9d492ebef56dc5f229416c925758edc:

  Linux 6.12-rc1 (2024-09-29 15:06:19 -0700)

are available in the Git repository at:

  git://git.linux-nfs.org/projects/anna/linux-nfs.git tags/nfs-for-6.12-2

for you to fetch changes up to 7ef60108069b7e3cc66432304e1dd197d5c0a9b5:

  NFS: remove revoked delegation from server's delegation list (2024-10-09 15:39:22 -0400)

----------------------------------------------------------------
NFS Client Bugfixes for Linux 6.12-rc

Localio Bugfixes:
  * Remove duplicated include in localio.c
  * Fix race in NFS calls to nfsd_file_put_local() and nfsd_serv_put()
  * Fix Kconfig for NFS_COMMON_LOCALIO_SUPPORT
  * Fix nfsd_file tracepoints to handle NULL rqstp pointers

Other Bugfixes:
  * Fix program selection loop in svc_process_common
  * Fix integer overflow in decode_rc_list()
  * Prevent NULL-pointer dereference in nfs42_complete_copies()
  * Fix CB_RECALL performance issues when using a large number of delegations

Thanks,
Anna

----------------------------------------------------------------
Dai Ngo (1):
      NFS: remove revoked delegation from server's delegation list

Dan Carpenter (1):
      SUNRPC: Fix integer overflow in decode_rc_list()

Mike Snitzer (3):
      nfs_common: fix race in NFS calls to nfsd_file_put_local() and nfsd_serv_put()
      nfs_common: fix Kconfig for NFS_COMMON_LOCALIO_SUPPORT
      nfsd/localio: fix nfsd_file tracepoints to handle NULL rqstp

NeilBrown (1):
      sunrpc: fix prog selection loop in svc_process_common

Yang Li (1):
      nfs: Remove duplicated include in localio.c

Yanjun Zhang (1):
      NFSv4: Prevent NULL-pointer dereference in nfs42_complete_copies()

 fs/Kconfig                 |  2 +-
 fs/nfs/callback_xdr.c      |  2 ++
 fs/nfs/client.c            |  1 +
 fs/nfs/delegation.c        |  5 +++++
 fs/nfs/localio.c           |  7 +++----
 fs/nfs/nfs42proc.c         |  2 +-
 fs/nfs/nfs4state.c         |  2 +-
 fs/nfs_common/nfslocalio.c |  5 ++++-
 fs/nfsd/filecache.c        |  2 +-
 fs/nfsd/localio.c          |  2 +-
 fs/nfsd/nfssvc.c           |  4 ++--
 fs/nfsd/trace.h            |  6 +++---
 include/linux/nfs_fs_sb.h  |  1 +
 include/linux/nfslocalio.h | 15 +++++++++++++++
 net/sunrpc/svc.c           | 11 ++++-------
 15 files changed, 45 insertions(+), 22 deletions(-)

