Return-Path: <linux-nfs+bounces-171-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 785447FDE0D
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Nov 2023 18:13:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B20A01C20951
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Nov 2023 17:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8DB7405D0;
	Wed, 29 Nov 2023 17:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sN1imfPA"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65453D0D6;
	Wed, 29 Nov 2023 17:13:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0A97C433C7;
	Wed, 29 Nov 2023 17:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701277988;
	bh=n0EA6tr7lpM+sWN304wVoqMFxn4vKkm/EFOAGbM/m5M=;
	h=From:To:Cc:Subject:Date:From;
	b=sN1imfPA/MYZfHS4/+q1UI2oumHuPRyBklRgmt9eLc8bnYqTU6zADfZ901Ocw5fwn
	 Lo3sblQ1TxIbbTi3LB54NznB3hfgN04vuF5Ct8R//gb6aQ/wi21Oad5z6hlU5Ld11X
	 JC9vJM7FeSI1dKHjJnmiMz9/BDfvHSZTId8M8JjuXnNEj+lVWdbkot75gVo+ALVo7R
	 VbNg+7WYOMly0pclr8WFDs0765Z3X59SKqr0+ErKRFwHS/UTJ451T5Q6eb1R07R/Q/
	 JBIt2oHul/AhB19esLuCVF4q3gCUHankl6rj04XeiNJX1y9m/UZIx8POl5dySLQvHU
	 7KjRO+38tjlRw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: lorenzo.bianconi@redhat.com,
	neilb@suse.de,
	netdev@vger.kernel.org,
	jlayton@kernel.org,
	kuba@kernel.org
Subject: [PATCH v5 0/3] convert write_threads, write_version and write_ports to netlink commands
Date: Wed, 29 Nov 2023 18:12:42 +0100
Message-ID: <cover.1701277475.git.lorenzo@kernel.org>
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
  NFSD: convert write_version to netlink command
  NFSD: convert write_ports to netlink command

 Documentation/netlink/specs/nfsd.yaml |  83 ++++++++
 fs/nfsd/netlink.c                     |  54 ++++++
 fs/nfsd/netlink.h                     |   8 +
 fs/nfsd/nfsctl.c                      | 267 +++++++++++++++++++++++++-
 include/uapi/linux/nfsd_netlink.h     |  30 +++
 tools/net/ynl/generated/nfsd-user.c   | 254 ++++++++++++++++++++++++
 tools/net/ynl/generated/nfsd-user.h   | 156 +++++++++++++++
 7 files changed, 845 insertions(+), 7 deletions(-)

-- 
2.43.0


