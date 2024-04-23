Return-Path: <linux-nfs+bounces-2960-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F0DF8AF425
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Apr 2024 18:32:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1C1B1F2309D
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Apr 2024 16:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29C933217;
	Tue, 23 Apr 2024 16:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lmNxHpdT"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05CA7160
	for <linux-nfs@vger.kernel.org>; Tue, 23 Apr 2024 16:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713889921; cv=none; b=Y9mNvQtmH80/Nj2xybbMLVNT24JXVwEwPIkYm24EZE7RF8UjAWadon8HU43ASRK197CbAzcO5wBQCeUS4+0hgfjRL7cSr/jrI5QydelhiVjNN0KsofkpVs0tbev9niFuUBhhyjfVpneoA9sfiSnNFYpWAS0KqS58fl9Wg4PnA7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713889921; c=relaxed/simple;
	bh=VTgwXxFNG6bt24cVQ7dT01+VRmspUXuxpLfHA5vBjO8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=frOGxs+IcgitdbLyoH+9oARPw2c+2/liw9whpRt4CdWQxxLacdkPUMNZQjqUFShXB7r9YxDSx7ZF7PTS2Y4DRG2IdbnHM5jyZWxaloyILjqyn1jTM+Hi+qyRAMax9Ey4/FdIMdLQ75zrNF/exmw0H6iLMFrhYDnCxWbi3oYTLwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lmNxHpdT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02106C116B1;
	Tue, 23 Apr 2024 16:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713889920;
	bh=VTgwXxFNG6bt24cVQ7dT01+VRmspUXuxpLfHA5vBjO8=;
	h=From:Subject:Date:To:Cc:From;
	b=lmNxHpdTbmRroA7Q3YlYpEtPwQN2eOtIU8FQ6dMJJESyuPude1ucQF4cY/ZjDC2cz
	 0aVIGkiTpamn9t/ChFHxXZxPaAJGzE0KCFaxA3QNGVw4HyP8emCyWvLNOI5Z6ajcur
	 yJ2lHILvAiSUhBNjrcpocpHejeJvuX4r7N8a1Ow7MY3G6j2MQ4lrr/I2BZkFwdcPp9
	 6tQeK3SZ5LI6uHtmhDUChjB11JLE7Sy9rdAUv/1XeM4qkxg9w7KZQgJpgIDywfe7zc
	 F7gVEG8SS1laQ/XGkRLqdLhK4bj4yY6OWItvlbUsXNysTeWEwAOjkg6cbSM7oaRwFN
	 6Xt2z2+ldFNNg==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH nfs-utils v3 0/3] nfsdctl: new nfs-utils tool for managing
 the kernel NFS server
Date: Tue, 23 Apr 2024 12:31:52 -0400
Message-Id: <20240423-nfsdctl-v3-0-9e68181c846d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHjiJ2YC/2WNQQ6CMBBFr2JmbU1bGkBX3sO4gM4UJpJiWmw0h
 LvbdKPG5c+892aFSIEpwmm3QqDEkWefR7XfgR07P5BgzBu01EYapYV3Ee0yCde1PbamktYhZPo
 eyPGzlC6QIfFYeIpwzaeR4zKHV/mRVAH+ckkJKchhjZZ6a6U53yh4mg5zGEok6W+x/og6i8fOV
 HXTN0qi/hG3bXsDawFO/+MAAAA=
To: Steve Dickson <steved@redhat.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
 Neil Brown <neilb@suse.de>
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3244; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=VTgwXxFNG6bt24cVQ7dT01+VRmspUXuxpLfHA5vBjO8=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBmJ+J7eVglhiDnNhe5oCTUklMoqR+UZUSx2Yoqq
 e5kQJBzgMGJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZifiewAKCRAADmhBGVaC
 FZzmEACb5jVdU9if5Dqi9lv7TiMvUOqluVzKK2aAPv4/53jJczbzzeOIgKv4MT68GIfgK9Kyk0q
 YUgn/QdA1psi70LqyIRBdAZYDZuOijhykxPPKmYMLH/Y6LHoHMUq02RwcjXmxafS3p4VE69F2n9
 G2zyX6USkECMLWBUdbQxVABdHjtzJaOsVnijOfvMAtVlALIiuAdecFkrNlop7OnMlu3qb7S9cHd
 pkJ9ql+7X0cFEcrFv83F3567ff/MIX3KrAQAGs1RJfu70Hk4jM144prZWidndL2Gd3gL9pGNJHs
 8S9qdWsKCqGIXqmINIxUzI4IlwV0aDj4yh6NmVMok9B0TWJQK59yJx9IvgnwRtIPEaR6gWN5+dt
 xVXRnTk6x7vdrlxD2wRk+780/9AaUByIm6OQuu4uUVWWuNST/zTY4FNCONAmkMS9GRWY71o4G29
 /RpulGP4M9jeroF41qfodubitrVT8D71b8g3Hlfzcpccb2SRn5m0pBh+UONzzGJXKZU3tDNKbyO
 bOfjCdd7nZmLOTKPmYgeDLqo+Uk3zxrY1O4ukU34PhSa/7xzRwceI8iCbLByVge/5k0P36Iqm3L
 hHASMxg518Vn0mIKjN2EQfSj2evQNJ5sMT87RCFVWD+3OCw+TaRvlsy+nhn1lG+t9c0QO0uUFma
 6Z9oijEEIpneCZQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Lorenzo posted an updated version of his netlink interface patches [1],
so here is an updated version of the companion userland patches. To be
clear, to test these, you need a kernel with his netlink patches.

The series adds a new tool to nfs-utils called nfsdctl, intended
as an eventual replacement for rpc.nfsd. It's a subcommand based
interface like nmcli or virsh, so we can easily expand the interface
later to deal with new sorts of configuration.

This version of the tool should be at feature parity with rpc.nfsd, at
least as far as autostarting the server. This posting also includes a
manpage and an update to the nfs-server systemctl service, to start
using the new interface when possible.

I've also included a patch that adds the manpage source. It's much nicer
to edit that and regenerate it if we have to update it later. We can
drop that patch if you just want to keep the result though.

The one thing that's not quite right here is the way the nfsd_netlink.h
file is handled. This set includes a copy of the proposed header, but it
would be better to build against the UAPI header in the kernel-headers
package instead. Older kernels have a subset of the new interface
though, so we can't build this against that file universally.

Is there a good way to test for the presence of an enum value in
autoconf? I didn't see any macros for it, but maybe there is some
generic test for C symbols we can use?

[1]: https://lore.kernel.org/linux-nfs/cover.1713878413.git.lorenzo@kernel.org/T/#m5fd847189894f58e93706c40340e18858f242a27

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
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
Jeff Layton (2):
      nfsdctl: asciidoc source for the manpage
      systemd: use nfsdctl to start and stop the nfs server

Lorenzo Bianconi (1):
      nfsdctl: add the nfsdctl utility to nfs-utils

 configure.ac                 |   13 +
 systemd/nfs-server.service   |    4 +-
 utils/Makefile.am            |    4 +
 utils/nfsdctl/Makefile.am    |   13 +
 utils/nfsdctl/nfsd_netlink.h |   86 +++
 utils/nfsdctl/nfsdctl.8      |  274 ++++++++
 utils/nfsdctl/nfsdctl.adoc   |  140 +++++
 utils/nfsdctl/nfsdctl.c      | 1426 ++++++++++++++++++++++++++++++++++++++++++
 utils/nfsdctl/nfsdctl.h      |   93 +++
 9 files changed, 2051 insertions(+), 2 deletions(-)
---
base-commit: c6aa75d25b79121c4cf83ae09a04f8728c4e6593
change-id: 20240412-nfsdctl-fa8bd8430cfd

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


