Return-Path: <linux-nfs+bounces-2760-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15ACD8A1D14
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Apr 2024 20:02:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F4021C239B8
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Apr 2024 18:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD8AC1C8FD1;
	Thu, 11 Apr 2024 16:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VgN4az/L"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832074776A;
	Thu, 11 Apr 2024 16:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712854071; cv=none; b=Awgj0IB0J95pR6IyT+u0xej9oTKQzkSvwv0wwuQZahe9mVrfKrMYVQdTqwIEdhYq6SoyrR55rr2sqW1kC3GhQ51rUT+L79F1W/J2vfY+zncEU/SUciUu+FTO6g6F+9BuGKjxPOqc2iK+t5O4tkgmUj+2DQIdjn2Itf9hp7lVs94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712854071; c=relaxed/simple;
	bh=Tsp7fVDAL7sxwe0z4KoaIWlEorLoi8doWzqxnvhLZvE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ryDzd7+0+P8lQTcWu4QgEylYJou4DYnmFNke9j/bI/295aYWrVEZg6iJFX+n3U/lxKaB3w0poXX4R+hJfQpBzJfc9g1OAevSllLBZN4MYFoPKd/QyoVBIZhiyYYlbzWLjc8gz4s+wGxslUZB6pHhEv6fbz0rm7i3mhvFSkW1ZkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VgN4az/L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3C6DC072AA;
	Thu, 11 Apr 2024 16:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712854071;
	bh=Tsp7fVDAL7sxwe0z4KoaIWlEorLoi8doWzqxnvhLZvE=;
	h=From:To:Cc:Subject:Date:From;
	b=VgN4az/LIeyBmae3lQp+lGgejFgVdti6XAFXcVkju9bvWOu95ussGKwc1nBV0lLQ4
	 sbokR5XJNK8oVrO0kWXnRjrbuUQQKwhAR5KqjCzZJzbn7v263Dv01+eyLhw0S77ry7
	 2WyBjaccpkesQwgtOSNKJTWHAsFGndVmS+FgOaX50SMD2DVZ5BAPw/BcSPK7pAYGmP
	 XLcu5wpGzJLWTWotwzOOtyXTdKYO9aMx2khzsSnuhCU/yIWdxBi3eVKV1/X7Eo0Qkd
	 YlmZoynQJwn4/IfzIsgT1Oj5Mb6y8nU/ovyFwo+7qw20CZuzvLyxcIbYeAwKwUForP
	 2KbX3IFaAptFA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: lorenzo.bianconi@redhat.com,
	chuck.lever@oracle.com,
	jlayton@kernel.org,
	neilb@suse.de,
	netdev@vger.kernel.org,
	kuba@kernel.org
Subject: [PATCH v7 0/5] convert write_threads, write_version and write_ports to netlink commands
Date: Thu, 11 Apr 2024 18:47:23 +0200
Message-ID: <cover.1712853393.git.lorenzo@kernel.org>
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
https://github.com/LorenzoBianconi/nfsdctl

Jeff Layton (1):
  SUNRPC: add a new svc_find_listener helper

Lorenzo Bianconi (4):
  NFSD: convert write_threads to netlink command
  NFSD: add write_version to netlink command
  SUNRPC: introduce svc_xprt_create_from_sa utility routine
  NFSD: add listener-{set,get} netlink command

 Documentation/netlink/specs/nfsd.yaml |  94 ++++++
 fs/nfsd/netlink.c                     |  63 ++++
 fs/nfsd/netlink.h                     |  10 +
 fs/nfsd/netns.h                       |   1 +
 fs/nfsd/nfsctl.c                      | 433 ++++++++++++++++++++++++++
 fs/nfsd/nfssvc.c                      |   3 +-
 include/linux/sunrpc/svc_xprt.h       |   5 +
 include/uapi/linux/nfsd_netlink.h     |  44 +++
 net/sunrpc/svc_xprt.c                 | 167 ++++++----
 9 files changed, 760 insertions(+), 60 deletions(-)

-- 
2.44.0


