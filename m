Return-Path: <linux-nfs+bounces-3555-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 196E68FBE7C
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Jun 2024 00:07:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F4D1B21ADD
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Jun 2024 22:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 779D61803D;
	Tue,  4 Jun 2024 22:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rl/UUQ60"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531CA320C
	for <linux-nfs@vger.kernel.org>; Tue,  4 Jun 2024 22:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717538864; cv=none; b=MIcaLb3QXs/k/ClA2xB49l/+8ZMGSo+MELrT3dg6qCLWjU2Jk3mpjULbNB89X3wX5YWbqlc2jgENv7zxdiJHcgXZWFm5xs04196wquCqJVx6JY4PmOBKpE+9IGqs2vdflBWl16ld2BXyGC6bKRVYaPYpKodrv1WifEFnXgmONiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717538864; c=relaxed/simple;
	bh=AihA7CUn41P2uWUq/z5iLlGb8kk9vJ/Ha5q+hDWCBXk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=o7MUFE6M7n16vYjtiAMl1ygA727E/+hBDBnDv6FMUvwapJ/6Jop2xgPV5ZZV9cPhwC5phq3F1i8p87ZlaDcGBzKym0CBKNJRJARp8TYMUbXbm7zVZdXO90HnUMQWmOGek2ZYanTosVFWBciCHFDHE1bYYrSAJ4g51vHTjSbarAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rl/UUQ60; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 585D5C2BBFC;
	Tue,  4 Jun 2024 22:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717538863;
	bh=AihA7CUn41P2uWUq/z5iLlGb8kk9vJ/Ha5q+hDWCBXk=;
	h=From:Subject:Date:To:Cc:From;
	b=Rl/UUQ6005pout5qPyw4drh2E3nZ1iGIWrILB+7HFj4Km65NwQyYBWMwtuZBDtVti
	 44QA0yYdl0c/gnaZRxy91DkQf7uNdmFWZ5ifbRWL11g/CNxCVVodVWiqYMbMmb177h
	 zRPObCQooAA36qGwBL0MZVqz5MavPwNdXHKM4gqR2pTQVTJrK5+WeIX9uVU46FhPpA
	 64z9YyeXdVGpZfdJWLkIG9CQWK1Dx3XA8wSlZLnQ/cO7VjKCwEGAiIIQLEgwJS/bN1
	 YuvO4GDWcAcDF0bknJl87RZcsnQvjiq4Rz9cPNVubk8YCT0gFvdV12YCFgVvRTldqy
	 szc6oJqieYCZA==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH nfs-utils v4 0/3] nfsdctl: new nfs-utils tool for managing
 the kernel NFS server
Date: Tue, 04 Jun 2024 18:07:28 -0400
Message-Id: <20240604-nfsdctl-v4-0-a2941f782e4c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACCQX2YC/2XNTQ6CMBAF4KuQWVvTv5TqynsYF9BOoZGAabHRE
 O5u7QaMy5d535sFIgaPEc7VAgGTj34ac5CHCkzfjB0Sb3MGTrmkknEyumjNPBDX6NZqKahxFnL
 7EdD5V1m6Qi6R5+yHCLd86n2cp/AuPxIrhb+5xAgl6KyyBltjqLzcMYw4HKfQlZHE91BtkGd4a
 qRQdVszavkfFDvIxQbFF6LSTDOjpbI/cF3XD+j+ENkcAQAA
To: Steve Dickson <steved@redhat.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
 Neil Brown <neilb@suse.de>
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3576; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=AihA7CUn41P2uWUq/z5iLlGb8kk9vJ/Ha5q+hDWCBXk=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBmX5AomMC1rHtY+gLBfy+5ZV6D/2qWJrL4Nksxc
 aL/gnXDhYmJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZl+QKAAKCRAADmhBGVaC
 FXQtEACmBkj0ABxmduOY7JQIDPLVRZTZWpQrlL8INeMxJBgkpBm/jp6wNsZSfdGUB73FGnCDQrY
 CIa1JDfZtjxNaREsym0eehvzJUZKtB7E4VFXIvhspdIXkPPvyNWh6opi6LFWGvUeTUp9KosZEmQ
 7c9xVqWbUQMsBu8USTJ9I+9+tZ86E/pa88ySHen0pZFBexmyJLjVfC4BlhOovTQmOVsfJMTIj61
 aXX4JzpRvJlcCA7dE+8Gtk5KzDxe/lgIB9zlHVLYKn2ULBYZegMPsjkXA2RGn3qV0pkOF8wIDln
 KEUOFF8p6i7J7qEnuTGIX6Mhe57QYMwOJpPCkLKXGTNGpdvyn4DlcC9cYLfq22ltPJYXQEZabst
 RVw6v1IAd5TCwpaylWeHvJ9Weg5QSP5GKaFzaV7FFoMlxeRanPkaUBmiTwamFXN+Xa8I96LHmTb
 2u3b9WnVaLYb6ObquJWU/4k+OS/O52ImvitUl9Y4/ylHAo3BiUtdg7Ijus1QkmFkLyhPRnYXD+a
 tytr4lzOZF0TB3toquq3rw3fGIEygvrizOPrJiQkjOjBk6cOqSkywSrBrwJyK+V5JWmBsbJHeiW
 trKC9UN59JxuDo4UcfyzK7xucLqDyNGRddROCm0+fwZTqsF8XJ27+0cMZg0KikwB1DDQjOLWd4Q
 eG2OhkLGQXiOJLQ==
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

The one thing that's not quite right here is the way the nfsd_netlink.h
file is handled. This set includes a copy of the proposed header, but it
would be better to build against the UAPI header in the kernel-headers
package instead. Older kernels have a subset of the new interface
though, so we can't build this against that file universally.

Is there a good way to test for the presence of an enum value in
autoconf? I didn't see any macros for it, but maybe there is some
generic test for C symbols we can use?

[1]: https://lore.kernel.org/linux-nfs/cover.1713878413.git.lorenzo@kernel.org/T/#m5fd847189894f58e93706c40340e18858f242a27
[2]: https://lore.kernel.org/linux-nfs/171606732267.14195.18399250065227381901.pr-tracker-bot@kernel.org/T/#t

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
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
 utils/nfsdctl/nfsdctl.adoc   |  140 ++++
 utils/nfsdctl/nfsdctl.c      | 1450 ++++++++++++++++++++++++++++++++++++++++++
 utils/nfsdctl/nfsdctl.h      |   93 +++
 9 files changed, 2075 insertions(+), 2 deletions(-)
---
base-commit: 94b48ccc0b0304809027fcead03343f4c716c4f4
change-id: 20240412-nfsdctl-fa8bd8430cfd

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


