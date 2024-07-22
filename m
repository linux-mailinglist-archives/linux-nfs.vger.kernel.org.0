Return-Path: <linux-nfs+bounces-5010-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06E1F9392E9
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Jul 2024 19:01:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70EC4B21AC9
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Jul 2024 17:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 042B316C451;
	Mon, 22 Jul 2024 17:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LiwS14Ym"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4491C2FD
	for <linux-nfs@vger.kernel.org>; Mon, 22 Jul 2024 17:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721667697; cv=none; b=ATn372QSW/XDiLzb/08as5FAXWoljkNY73Sf9VZbkI0Z191jd+bmSbL/FtDJEvi1DxdNMYDHi93M8KKRS4PM8JtJFdfeiIhMB20LcBwlcJHKNHhQUuDAOF78kmZCVCp+0EGnY2NTC1iacbWQM6Sf/rvoCxASNPaa283lVZgZ/4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721667697; c=relaxed/simple;
	bh=q0y5b3MTYa/6DYbxPP8pbhlPCiLB+CK+qPsWLjZ0FdM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=t5E0piwZae7+FTfPmbsKIdiUAKhDRBrtskdxAyNQRqTYewPCXemw78re2acqoqcUUUG9MUuENlFdLvZiJ7GbrX/bkIe3+BTNhJkXohY6VQYkU1hGOpfAyMGo0Nd9OmO8jZfFSYvUMb7CCn8Zg6QRqdwZZy9U70zgmcKEV3R81KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LiwS14Ym; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98FE1C116B1;
	Mon, 22 Jul 2024 17:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721667697;
	bh=q0y5b3MTYa/6DYbxPP8pbhlPCiLB+CK+qPsWLjZ0FdM=;
	h=From:Subject:Date:To:Cc:From;
	b=LiwS14Ymdgdv5WkZ7Lr30mEnn6sW0N8NRB542MJhDxM8i6HqVD90sUu5WA55Y944c
	 bqNuAhnI/imloDNJx3c8uteIKSr0wQNK+1+47eHfd/6qSx0kxnFixW0hIfTIaFJWG2
	 NPpF2ARiUikYRaqR9ryq2ZwR3xmJMY5hITl0FLlukZXFEReV2KUpqc/XziBUZTIiFX
	 LAsjTge37m7UT+q915Q8PlchRVHDRJ0LxM1pdsuM6eeuwYJqBPW9dSUfLKaFKNSbzC
	 j7gcPR3SMgAbwNazTCyS4JwwLZoer/WRqkDQQ6jHFHiErMOenwKs8QMoom2gBC1J2x
	 3pynRdFRYHcfA==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH nfs-utils v6 0/3] nfsdctl: add a new nfsdctl tool to
 nfs-utils
Date: Mon, 22 Jul 2024 13:01:32 -0400
Message-Id: <20240722-nfsdctl-v6-0-1b9d63710eb5@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGyQnmYC/2WNQQ7CIBBFr9LMWgxQQqsr72FctDC0ExvaQCWap
 neXsFHj8mfee7NBxEAY4VxtEDBRpNnnoQ8VmLHzAzKyeYPkUnElJPMuWrNOzHVtb1tVc+MsZHo
 J6OhZSlfIEHusNEW45dNIcZ3Dq/xIogB/uSQYZ+istgZ7Y7i63DF4nI5zGEokyW9Rf0SZxVOna
 t30jeBW/oj7vr8BVT8+J+MAAAA=
To: Steve Dickson <steved@redhat.com>
Cc: linux-nfs@vger.kernel.org, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Chuck Lever <chuck.lever@oracle.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2285; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=q0y5b3MTYa/6DYbxPP8pbhlPCiLB+CK+qPsWLjZ0FdM=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBmnpBvqVxxQmQxkHqZewfLQ60mbtO7W76b3VJUT
 DYUBJAW97uJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZp6QbwAKCRAADmhBGVaC
 FQZ1D/kBhqa8svDSRioqGN0GtB4pY0MIA/gsOvU8+acyRNQs3gDLeWghqEEzt156ryIwyf/eg8l
 FR+NRzOQQSeDVg1jJA47F0BuxDJcEpAAx4tX6Js3V8KULgrt8FKecnAi2+o0Xhzskt0lPoiafjU
 7+uF9el31eO7YpQzVpQPLvlSnpSwQ+wdKxNs9Zte3PGR2QXKORRKSFvEqN6MWU25ABrZE6cAFLR
 dnTsI7k7pmuina09rOuSbNrkk1uR6+uibCfFyQIgAp/xLk2p3iR6wfJ5WZ7JHH4HboiP8xDIjcW
 /pIYLnWxjMFo4fGhpCR1wVT2wlIVHvbf/LcvmAIQlY3jo4DdLj80iMWvVdI0GTTt5G5c11rxvXD
 lw4ec9HBcYrL5NvspeWjCNMq26A1NMTj7CFxGbWC7BTMp/dPAhOU0BfCJIfe58xF6PH9EYvQJMv
 r51w4AoIhwN2ciC7g6BbsQV+Vk0HaD4aPqV+9ehLUGATUbsRVUhSNK17L1/0PSqZ3vgS0ZYzLGt
 pOXvyLSTUid7Pl4n9aEljaGqbKuBRVtIbnQzM3FM2iH2M8RPy67b/Tr/R7TI2Phv/G4djKlw1vu
 7HB/Cv1p3CJ9KS/vuiII/0YP5PC4H0viT4teXoSnk4ALw2/O1CoGU+mtb98XdoxrWbGEUHCCynd
 varAsMyA32NHQmw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Hi Steve,

Here's an squashed version of the nfsdctl patches, that represents
the latest changes. Let me know if you run into any other problems,
and thanks for helping to test this!

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Changes in v6:
- make the default number of threads 16 in autostart
- doc updates

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
      nfsdctl: add the nfsdctl utility to nfs-utils
      nfsdctl: asciidoc source for the manpage
      systemd: use nfsdctl to start and stop the nfs server

 configure.ac                 |   19 +
 systemd/nfs-server.service   |    4 +-
 utils/Makefile.am            |    4 +
 utils/nfsdctl/Makefile.am    |   13 +
 utils/nfsdctl/nfsd_netlink.h |   96 +++
 utils/nfsdctl/nfsdctl.8      |  304 ++++++++
 utils/nfsdctl/nfsdctl.adoc   |  158 +++++
 utils/nfsdctl/nfsdctl.c      | 1570 ++++++++++++++++++++++++++++++++++++++++++
 utils/nfsdctl/nfsdctl.h      |   93 +++
 9 files changed, 2259 insertions(+), 2 deletions(-)
---
base-commit: b76dbaa48f7c239accb0c2d1e1d51ddd73f4d6be
change-id: 20240412-nfsdctl-fa8bd8430cfd

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


