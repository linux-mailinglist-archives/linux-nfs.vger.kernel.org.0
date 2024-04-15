Return-Path: <linux-nfs+bounces-2820-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C38E8A5B7D
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Apr 2024 21:51:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86846B25D51
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Apr 2024 19:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EC3A156677;
	Mon, 15 Apr 2024 19:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mZZuN2FM"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB40715666F;
	Mon, 15 Apr 2024 19:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713210306; cv=none; b=XoRgrCN96POhV5u3+Hwjc76FJ/Jd2QDwUIoyBWhqB1tlbhCjAyWXpE9fvezxcHqEygKA4efuynyj20aJr/+Fvmu7TboYRHQUQ09j++Q4vq8qKj97bWYlrbDn8UioUwAkfk1VFk0RiB5CeCr8kLX8xkKML4N/8EjUZ++NfjjqqQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713210306; c=relaxed/simple;
	bh=vIL46l7iKkKeFHTEjgaZNncOlDosmXcACT56qzJwRfA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=STmi0tB0CXFR1lJ+OgbWZyawCAUEtfcEX/lfb2IhCbfhlEpwZvxRkWLgRAvVj0zsIaGt5hOKixYvLCGGqI6tnMhzQyQBw5+iew/XMgQJ0ubLQHE/gjdhbG2PEZUKq24NXvyl6Y644OVM1+lrHEK1H3Zo0CZ6Cqk7nYkMFoeelqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mZZuN2FM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A4CFC2BD11;
	Mon, 15 Apr 2024 19:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713210306;
	bh=vIL46l7iKkKeFHTEjgaZNncOlDosmXcACT56qzJwRfA=;
	h=From:To:Cc:Subject:Date:From;
	b=mZZuN2FM6tkB8wALK+3LtA3Q0a2JoOF+y5F3zx1o26MqZXoHtq/vzg2+r8HMIuYhF
	 VUKY3gsAFkV3aRxGdMWj9cMyJK66gyb22BFW0VS1HKMlU2NXbZDtASlt1tvvCje9nJ
	 HCTn67866liMFVcIst8zoJ1qGPTkExCUIYF8TUjpQDnSB3uZ2ICZzSx8dMGEbdB/Ps
	 +U1NWhH5lQ93Ve8ycsy1Tvj74vnQb721hh2+KiVu/O+1rCbvQHMr808kdIRKnAhtHW
	 37BUA31l8FXO6Pi5+fmrdKMapBmvVwIPuP9PKzp23ifl3lWN1ULBnTfgtvwXfYbzdM
	 /hcRAYMlXyz8A==
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: lorenzo.bianconi@redhat.com,
	chuck.lever@oracle.com,
	neilb@suse.de,
	netdev@vger.kernel.org,
	kuba@kernel.org,
	jlayton@kernel.org
Subject: [PATCH v8 0/6] convert write_threads, write_version and write_ports to netlink commands
Date: Mon, 15 Apr 2024 21:44:33 +0200
Message-ID: <cover.1713209938.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce write_threads, write_version and write_ports netlink
commands similar to the ones available through the procfs.

Changes since v7:
- add gracetime and leasetime to threads-{set,get} command
- rely on nla_nest_start instead of nla_nest_start_noflag
Changes since v6:
- add the capability to pass sockaddr from userspace through listener-set
  command
- rebase on top of nfsd-next
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
https://patchwork.kernel.org/project/linux-nfs/cover/20240412-nfsdctl-v1-0-efd6dcebcc04@kernel.org/

Jeff Layton (2):
  nfsd: move nfsd_mutex handling into nfsd_svc callers
  SUNRPC: add a new svc_find_listener helper

Lorenzo Bianconi (4):
  NFSD: convert write_threads to netlink command
  NFSD: add write_version to netlink command
  SUNRPC: introduce svc_xprt_create_from_sa utility routine
  NFSD: add listener-{set,get} netlink command

 Documentation/netlink/specs/nfsd.yaml | 104 ++++++
 fs/nfsd/netlink.c                     |  65 ++++
 fs/nfsd/netlink.h                     |  10 +
 fs/nfsd/netns.h                       |   1 +
 fs/nfsd/nfsctl.c                      | 476 ++++++++++++++++++++++++++
 fs/nfsd/nfssvc.c                      |   7 +-
 include/linux/sunrpc/svc_xprt.h       |   5 +
 include/uapi/linux/nfsd_netlink.h     |  46 +++
 net/sunrpc/svc_xprt.c                 | 167 +++++----
 9 files changed, 819 insertions(+), 62 deletions(-)

-- 
2.44.0


