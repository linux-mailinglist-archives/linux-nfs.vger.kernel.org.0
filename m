Return-Path: <linux-nfs+bounces-3772-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7431C907887
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jun 2024 18:44:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B23A1F23447
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jun 2024 16:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DD6B12D757;
	Thu, 13 Jun 2024 16:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FQiO7Kg4"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1C4143887
	for <linux-nfs@vger.kernel.org>; Thu, 13 Jun 2024 16:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718297066; cv=none; b=iMT901otryM9CQKtO/cqo43kRQs08ylbQFQEbYOaJ3+YuDIZ51PUYMpjLmxrhT9TxQUdx0QnpEa6cQfcMQvdA1kq1YMOsgIKB4lFz9sjkBo8RMTEF1wDb6oqiAMO8GpqzdJCGtH7jpTreRdroE7fqyWkj91BiMCUJFUbRrogzEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718297066; c=relaxed/simple;
	bh=f48iFP3SPbeAFvwyogV03dOTaVVJ3l7higDe2p2yPeM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=njLj4/x77P/dd68hg97tj49yDnuo1FS7RiG9J4k2HmU3U2elS18SUsJKSO71pYXHQQTwyY/ebd4Z1jbzE0CVOPiOcteWzlYk0ppI/nhFTe7nUj0G2juOKD7OUm3CkCVN+1tyn56wJOlv1muMnlRVprcjc7dRAZHJGtvQevNPTHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FQiO7Kg4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DD5FC2BBFC;
	Thu, 13 Jun 2024 16:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718297066;
	bh=f48iFP3SPbeAFvwyogV03dOTaVVJ3l7higDe2p2yPeM=;
	h=From:Subject:Date:To:Cc:From;
	b=FQiO7Kg4QOQVuWk0awZBJAnvOdWwGLlgDTxQaiwT59G38WMCDgiZy3+hxvNf5lQDt
	 1d8dTb0AEVL0t+eMdS1yxj8EawA3mpNvFv6MvKpbpIBFP4t/9737U6fxWUROqYBexr
	 0Q3KTvSZqokPTUdlWHInh64PtzhmO62EdaV3ov9RNlwRYq4IvhWfkiPOhST1dCtInI
	 GMto4pf6Z4Mq/lQlDghgPch8nZ70aijiLQPyBsMzUkKClTkxyeKLEV11ZcHbOJmq1B
	 a9Tj4lffMfvmbJzgZD09s6m1MmWQMq8yFoIzQFqMR38lD9CEmxR55ZPWiMYqUHxb8p
	 dN74FiOjZiMog==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH nfs-utils v5 0/4] nfsdctl: new nfs-utils tool for managing
 the kernel NFS server
Date: Thu, 13 Jun 2024 12:44:05 -0400
Message-Id: <20240613-nfsdctl-v5-0-0b7a39102bac@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANUha2YC/2XNQQ6CMBAF0KuYrq1pp2MprryHcQHtVBoJmBaJh
 nB3Kxs0LH/mvz8TSxQDJXbaTSzSGFLouxyO+x2zTdXdiAeXMwMBKFAC73xydmi5r0ztDCphvWO
 5/Yjkw2tZurBc4s8htIld86kJaejje/kxyqWwmRslF5y8085Sba3A851iR+2hj7dlZIRfqFcIG
 ZYVKl3UhRQONlD9QFArVF9I2kgjrUHtNhBXqAWuEDOsoETpCwOE9g/O8/wBNUxa1lUBAAA=
To: Steve Dickson <steved@redhat.com>
Cc: linux-nfs@vger.kernel.org, Lorenzo Bianconi <lorenzo@kernel.org>, 
 Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3555; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=f48iFP3SPbeAFvwyogV03dOTaVVJ3l7higDe2p2yPeM=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBmayHfsJm4qp1FTCjO/wOYTTKdyKTnL39HbqObk
 w/Izg6qg0+JAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZmsh3wAKCRAADmhBGVaC
 FUutD/4jRoGLGJCuw1W/0hYfX+deGVoJ4rhwTKxaW3hJz9FUEqfovW11F/EQGbt5BA++g/Aq+OQ
 X5x77SYxx/Ey2DeQ5BM8ImQ6f6F68//3NWs/vglv3hcHY3LxhN8Nxx5FR96KCGk4p2ZmlIko0zW
 wEffDsWDKPDh1FPvYMD2pXKjbpQRLtEsHM8xYVJQi8BhdlvctVFf5tj0GXxKJqC98++Cqi2QOC7
 ujrb1SLZUBeTFV4dxxCpBGrt4vzs+5lh80FrWIibMUJ6VQVz8oMTXxmR5P2YF5kvYHBEKMXKLdv
 K5YYE0Re8WAHbC5v3Rg48hv9bkVkVtVE4QgL/VM8FTSCe+6nKlxAqpoolp42vxhxSWR3dCt88Ic
 SuClUVcOYkjNuyclBllJf1/4zLvBfh7Yrg1C7Dl3kfrD6FMsmeyFw2NtKcisO+MFPZVhjO3F7GQ
 ZdNB2p0TTfQQCjCB3o2OS6a6m+0FPSO91l/Q5lS8qIMQZY6Cdyu0s5Otv0itZFpmLRPvOM7GV3d
 Qw3VviAtNmsb/R+72zEJVesQGJS1OJOnFeP1TSkdXEylZjaIIwrexcGFAN/8b2feiFCR/I4gTZq
 d3cZtBMxQk+CgbqQuVohaZjxHaIUHMPTOr5buGhZB4yiXneXduCKRvF3O7+s1AjEBZ1ud8OIXDk
 6qdxnQFwGrbkeRA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Hi Steve,

The new netlink management interfaces [1] have been merged for v6.10
[2]. Please consider merging this series into nfs-utils. I think the
code is fine but it may need some autoconf/automake love. See below...

This series adds a new tool to nfs-utils called nfsdctl, which is
intended as an eventual replacement for rpc.nfsd (and maybe other
tools). It's a subcommand based interface like nmcli or virsh, so we can
easily expand the interface later to deal with new sorts of
configuration.

This version of the tool should be at feature parity with rpc.nfsd, at
least as far as autostarting the server. This posting also includes a
manpage and an update to the nfs-server systemctl service, to start
using the new interface when possible.

I've also included a patch that adds the manpage source. It's much nicer
to edit that and regenerate it if we have to update it later. We can
drop that patch if you just want to keep the result though.

This does ship a copy of nfsd_netlink.h along with the tool that gets
used if the uapi headers aren't new enough. This is a temporary measure.
Once new enough kernels are shipping in the field (in a year or so?), we
can drop that and some related autoconf junk.

[1]: https://lore.kernel.org/linux-nfs/cover.1713878413.git.lorenzo@kernel.org/T/#m5fd847189894f58e93706c40340e18858f242a27
[2]: https://lore.kernel.org/linux-nfs/171606732267.14195.18399250065227381901.pr-tracker-bot@kernel.org/T/#t

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Changes in v5:
- add support for pool-mode setting
- fix up the handling of nfsd_netlink.h in autoconf
- Link to v4: https://lore.kernel.org/r/20240604-nfsdctl-v4-0-a2941f782e4c@kernel.org

Changes in v4:
- add ability to specify an array of pool thread counts in nfs.conf
- Link to v3: https://lore.kernel.org/r/20240423-nfsdctl-v3-0-9e68181c846d@kernel.org

Changes in v3:
- split nfsdctl.h so we can include the UAPI header as-is
- squash the patches together that added Lorenzo's version and convert
  it to the new interface
- adapt to latest version of netlink interface changes
  + have THREADS_SET/GET report an array of thread counts (one per pool)
  + pass scope in as a string to THREADS_SET instead of using unshare() trick

Changes in v2:
- Adapt to latest kernel netlink interface changes (in particular, send
  the leastime and gracetime when they are set in the config).
- More help text for different subcommands
- New nfsdctl(8) manpage
- Patch to make systemd preferentially use nfsdctl instead of rpc.nfsd
- Link to v1: https://lore.kernel.org/r/20240412-nfsdctl-v1-0-efd6dcebcc04@kernel.org

---
Jeff Layton (3):
      nfsdctl: asciidoc source for the manpage
      systemd: use nfsdctl to start and stop the nfs server
      nfsdctl: add support for pool-mode

Lorenzo Bianconi (1):
      nfsdctl: add the nfsdctl utility to nfs-utils

 configure.ac                 |   19 +
 systemd/nfs-server.service   |    4 +-
 utils/Makefile.am            |    4 +
 utils/nfsdctl/Makefile.am    |   13 +
 utils/nfsdctl/nfsd_netlink.h |   96 +++
 utils/nfsdctl/nfsdctl.8      |  293 ++++++++
 utils/nfsdctl/nfsdctl.adoc   |  152 ++++
 utils/nfsdctl/nfsdctl.c      | 1584 ++++++++++++++++++++++++++++++++++++++++++
 utils/nfsdctl/nfsdctl.h      |   93 +++
 9 files changed, 2256 insertions(+), 2 deletions(-)
---
base-commit: 94b48ccc0b0304809027fcead03343f4c716c4f4
change-id: 20240412-nfsdctl-fa8bd8430cfd

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


