Return-Path: <linux-nfs+bounces-1210-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D37B4833582
	for <lists+linux-nfs@lfdr.de>; Sat, 20 Jan 2024 18:34:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D5B71C20849
	for <lists+linux-nfs@lfdr.de>; Sat, 20 Jan 2024 17:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C231095C;
	Sat, 20 Jan 2024 17:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G//6unyP"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8551094E;
	Sat, 20 Jan 2024 17:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705772043; cv=none; b=PF635nilEe8I/pRV0Jd348IxyhgMG0HnnLalDantI7c9VNQZFFMdcR+pUlOdTH8XFYSMwErc2WfLFC+CqL6U30NDGD8wMR6Z8Oz3+Ntb1RhlvYYsr+Tb0eEmW2pJX7TE6l2OaD+L0+/J1AFbr5HW46DPZT90lSKf2c66ScmsPsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705772043; c=relaxed/simple;
	bh=7GgBh/qpAS9IH8JJ4QNVMuDWn+um6pf5lH+Qln2AaEU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=klr2iQ59r93H05JSZUOnHwnQ7EKwGgLZStibGWqdvfbAWUSlQQ45s9lGOPfpywYPtnSXwDyAaxtpVWLdS1YLV1BRfz4PkQB3pnieT2HZboG0ft+3R/PJE2C9EF9ggDfpKVRV3osIi9125BUuWitwWgcbX04Fty7os3yz/xn8vHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G//6unyP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBEEDC433C7;
	Sat, 20 Jan 2024 17:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705772041;
	bh=7GgBh/qpAS9IH8JJ4QNVMuDWn+um6pf5lH+Qln2AaEU=;
	h=From:To:Cc:Subject:Date:From;
	b=G//6unyP9nLF3/WesvyMFgWyepUiwNRpOvga9Q/ZJiFbiyL6JiZqaDjLRIHJCLMlC
	 MN4Iw2KtwF24Pbxu4vxhKHpY20JkWYe7h9IY2VhVFL3a6aMmB3s9rBQ6sEcPwO1GQX
	 WR3Gq9WbTW1zrSn5DY0TGabxhZnZf9H4AfVrwVrc/q6YeQRO/eyaLDjcaEy/sxxnhV
	 U88wev8aLzWCrAt02Pz7IYLeHAt1oLqvuXy10NY+5QShR2wxL3I7ZVK20RQ0l2v1qc
	 sCYEKtG7+avK3XK9KuOI+Eb1TIk65kWeMZICQl35C7a7gWvTbUr/qX2sHiciyaJtem
	 hXj1QLNFQTn0A==
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: lorenzo.bianconi@redhat.com,
	neilb@suse.de,
	jlayton@kernel.org,
	kuba@kernel.org,
	chuck.lever@oracle.com,
	horms@kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH v6 0/3] convert write_threads, write_version and write_ports to netlink commands
Date: Sat, 20 Jan 2024 18:33:29 +0100
Message-ID: <cover.1705771400.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce write_threads, write_version and write_ports netlink
commands similar to the ones available through the procfs.

Changes since v5:
- for write_ports and write_version commands, userspace is expected to provide
  a NFS listeners/supported versions list it want to enable (all the other
  ports/versions will be disabled).
- fix comments
- rebase on top of nfsd-next
Changes since v4:
- rebase on top of nfsd-next tree
Changes since v3:
- drop write_maxconn and write_maxblksize for the moment
- add write_version and write_ports commands
Changes since v2:
- use u32 to store nthreads in nfsd_nl_threads_set_doit
- rename server-attr in control-plane in nfsd.yaml specs
Changes since v1:
- remove write_v4_end_grace command
- add write_maxblksize and write_maxconn netlink commands

This patch can be tested with user-space tool reported below:
https://github.com/LorenzoBianconi/nfsd-netlink.git

Lorenzo Bianconi (3):
  NFSD: convert write_threads to netlink command
  NFSD: add write_version to netlink command
  NFSD: add write_ports to netlink command

 Documentation/netlink/specs/nfsd.yaml |  94 ++++++
 fs/nfsd/netlink.c                     |  63 ++++
 fs/nfsd/netlink.h                     |  10 +
 fs/nfsd/nfsctl.c                      | 396 ++++++++++++++++++++++
 include/uapi/linux/nfsd_netlink.h     |  44 +++
 tools/net/ynl/generated/nfsd-user.c   | 460 ++++++++++++++++++++++++++
 tools/net/ynl/generated/nfsd-user.h   | 155 +++++++++
 7 files changed, 1222 insertions(+)

-- 
2.43.0


