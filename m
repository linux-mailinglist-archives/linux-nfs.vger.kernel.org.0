Return-Path: <linux-nfs+bounces-2947-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DFE28AE80C
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Apr 2024 15:26:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19080289654
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Apr 2024 13:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87EE0135A54;
	Tue, 23 Apr 2024 13:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EOi1fH0E"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF0D135A40;
	Tue, 23 Apr 2024 13:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713878758; cv=none; b=PQWXrgXiALhHva7nI5v4SLR/+SkZuCdBf4RCfm2eHIZhmaLmtBkZvshAIwJSskqLgbploWVNmPAdi3HI8qFroqsOSJE+f0ppoQ0y8B6hfmish1PZRFpZxFXwGDpLXU83gzYfZ21Tep9Db3J09L53g17HA2OuVNLmb5AiNeDn3po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713878758; c=relaxed/simple;
	bh=skTkkecSFD0c9nAp9jXPDMdBjTUFh9fUr2lBFML5bGE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C7hMhBe7RFRVbZZBHLhzU0VlBlVTO5KExcp1g+66Jmv1rxvVpAOF0hAj0YV7YHJfpOL7WMBY+OgI0uAKfgzGIcxJmBTxU2gVVB9db/enh400bihl7Y6KZh0uz2P9OGq2MfphTbsAVnGeExePCkqjh6ea+PvuKyut9QPpormH8B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EOi1fH0E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81331C116B1;
	Tue, 23 Apr 2024 13:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713878757;
	bh=skTkkecSFD0c9nAp9jXPDMdBjTUFh9fUr2lBFML5bGE=;
	h=From:To:Cc:Subject:Date:From;
	b=EOi1fH0EsXLRY3mF396XTWz7rjc7aSHOgrOp4VX1//FvJOhwFi/p/4JyTdliAZ/Wu
	 NI5Bs229KnsU3AIXVmilzyk6gnZa5+6iGY9UbEG2sPkNY/nhfgmSpnJt6ia1p2oFaJ
	 cThpI+sL74wcuMRev0RIfZ960Ow9MM/gnxYyfgSGuw5SuluLjIgccyN+y7fZOSaiLy
	 YFjU2ifh4orYIXZn+v2ZGF04ZMWRLH0F2pQqK19ae1b0F4AsjggeLoYOU8rMj9KRZX
	 T7Q4YHuBk05wTkTjAq9jjGbLIsbCV2xVAsTXnzjHoU5DRuS/30uMtiF28lgH+TYcDi
	 1PPEGSbNY5MKQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: neilb@suse.de,
	lorenzo.bianconi@redhat.com,
	chuck.lever@oracle.com,
	netdev@vger.kernel.org,
	kuba@kernel.org,
	jlayton@kernel.org
Subject: [PATCH v9 0/7] convert write_threads, write_version and write_ports to netlink commands
Date: Tue, 23 Apr 2024 15:25:37 +0200
Message-ID: <cover.1713878413.git.lorenzo@kernel.org>
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

Changes since v8:
- introduce scope parameter to write_thread command
- add the capability to specity multiple threads in write_thread for future
  usage
- fix comments
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

Jeff Layton (3):
  NFSD: move nfsd_mutex handling into nfsd_svc callers
  NFSD: allow callers to pass in scope string to nfsd_svc
  SUNRPC: add a new svc_find_listener helper

Lorenzo Bianconi (4):
  NFSD: convert write_threads to netlink command
  NFSD: add write_version to netlink command
  SUNRPC: introduce svc_xprt_create_from_sa utility routine
  NFSD: add listener-{set,get} netlink command

 Documentation/netlink/specs/nfsd.yaml | 110 ++++++
 fs/nfsd/netlink.c                     |  66 ++++
 fs/nfsd/netlink.h                     |  10 +
 fs/nfsd/netns.h                       |   1 +
 fs/nfsd/nfsctl.c                      | 517 +++++++++++++++++++++++++-
 fs/nfsd/nfsd.h                        |   2 +-
 fs/nfsd/nfssvc.c                      |  11 +-
 include/linux/sunrpc/svc_xprt.h       |   5 +
 include/uapi/linux/nfsd_netlink.h     |  47 +++
 net/sunrpc/svc_xprt.c                 | 167 ++++++---
 10 files changed, 870 insertions(+), 66 deletions(-)

-- 
2.44.0


