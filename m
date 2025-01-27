Return-Path: <linux-nfs+bounces-9670-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA01AA1D7F9
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Jan 2025 15:21:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D224E1887AD0
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Jan 2025 14:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B3524B26;
	Mon, 27 Jan 2025 14:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=clip-os.org header.i=@clip-os.org header.b="ne/w0z5I"
X-Original-To: linux-nfs@vger.kernel.org
Received: from relay0.mail.gandi.net (relay0.mail.gandi.net [217.70.178.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC75812B94;
	Mon, 27 Jan 2025 14:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737987641; cv=none; b=komskIEBP1+TTlU2dOZG4OBWYbxz7yVdwePbt1TWl0pkt3jCTSqK+jufxNNwjVcAkfuPo6KAqZff/6DIAHU6ECk4EqzE5SvFFidWGuwa+MCNLmlu4TAhhL2/oBndtea7u03DQl75AV4s35mmrxVJ4+oG58ViVu9epn34ykipgT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737987641; c=relaxed/simple;
	bh=guyZ/MKlXIsvQlOpF2wFMhfgN/7gqK/EDP70Q870oR4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JPsEZv0uZSARYyOmymo7JEC25gJK0OfcZPhLJ0hKGEHOCj6XiHvcsXh6Zec4k4dNpmLT2RSqwlG9dvQNkC7LK3I/BarVtdLofEQYi8ecrNrz0IEmRTd25M2KFTy4DERQveHD2thZ2gYC9ASD56myaTdAz0qzPI31HMej7k+0ga0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=clip-os.org; spf=pass smtp.mailfrom=clip-os.org; dkim=pass (2048-bit key) header.d=clip-os.org header.i=@clip-os.org header.b=ne/w0z5I; arc=none smtp.client-ip=217.70.178.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=clip-os.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=clip-os.org
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1EFE144072;
	Mon, 27 Jan 2025 14:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=clip-os.org; s=gm1;
	t=1737987629;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=u8wm5rMnmAnyi9AFWZeRK7rLAfXC2gHYAuN/gOs/kNo=;
	b=ne/w0z5IU96ErSqVbgSgHiBBjPWJZ238V3evVvEwux7Pa0/w3b6qrbAHsxEn2n7HsCrsdu
	VguJQ+lKMsl2etTXJUm9peImKnJ3zRACD2QkPVwiXnu7kGHXq1bbmVSQzghUiJz7hqXXyN
	BGgu4H/UtqFfijplFgctu85tRT7j0ZTe3zJ6tM/6/OLG5heKSpjWec1fEMgMnp0p+YQ+8J
	QMBVb1Uf+scCSwJM01zbPrSYVa4dOcfBCCl/GqzjUYAAccY8KTHBVxV7vOAcyOPNq8KUFc
	4KPIrNgCtgTwb/APbt351AIjFqMUKZDlmXblQGhduTqdfgzY8BBRkm77MZTj1g==
From: nicolas.bouchinet@clip-os.org
To: linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	codalist@coda.cs.cmu.edu,
	linux-nfs@vger.kernel.org,
	netdev@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org
Cc: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>,
	Joel Granados <j.granados@samsung.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Leon Romanovsky <leon@kernel.org>,
	Zhu Yanjun <yanjun.zhu@linux.dev>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH v1 0/9] Fixes multiple sysctl bound checks
Date: Mon, 27 Jan 2025 15:19:57 +0100
Message-ID: <20250127142014.37834-1-nicolas.bouchinet@clip-os.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -60
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedgudefgedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenogfuohhrthgvugftvggtihhpvdculdegtddmnecujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepnhhitgholhgrshdrsghouhgthhhinhgvthestghlihhpqdhoshdrohhrghenucggtffrrghtthgvrhhnpeeiieegheetheeftedutdeifeeugfefveehvedviedutedvleeljeevkeekvdelkeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeeltddrieefrddvgeeirddukeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdeifedrvdegiedrudekjedphhgvlhhopegrrhgthhhlihhnuhigrddrpdhmrghilhhfrhhomhepnhhitgholhgrshdrsghouhgthhhinhgvthestghlihhpqdhoshdrohhrghdpnhgspghrtghpthhtohepudeipdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqrhgumhgrsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqshgtshhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghouggrlhhishhts
 egtohgurgdrtghsrdgtmhhurdgvughupdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehnvghtfhhilhhtvghrqdguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghorhgvthgvrghmsehnvghtfhhilhhtvghrrdhorhhg
X-GND-Sasl: nicolas.bouchinet@clip-os.org

From: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>

Hi,

This patchset adds some bound checks to sysctls to avoid negative
value writes.

The patched sysctls were storing the result of the proc_dointvec
proc_handler into an unsigned int data. proc_dointvec being able to
parse negative value, and it return value being a signed int, this could
lead to undefined behaviors.
This has led to kernel crash in the past as described in commit
3b3376f222e3 ("sysctl.c: fix underflow value setting risk in vm_table")

Most of them are now bounded between SYSCTL_ZERO and SYSCTL_INT_MAX.
nf_conntrack_expect_max is bounded between SYSCTL_ONE and SYSCTL_INT_MAX
as defined by its documentation.

This patchset has been written over sysctl-testing branch [1].
See [2] for similar sysctl fixes currently in review.

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/sysctl/sysctl.git/log/?h=sysctl-testing
[2]: https://lore.kernel.org/all/20250115132211.25400-1-nicolas.bouchinet@clip-os.org/

Best regards,

Nicolas

---

Nicolas Bouchinet (9):
  sysctl: Fixes nf_conntrack_max bounds
  sysctl: Fixes nf_conntrack_expect_max bounds
  sysctl: Fixes gc_thresh bounds
  sysctl: Fixes idmap_cache_timeout bounds
  sysctl: Fixes nsm_local_state bounds
  sysctl/coda: Fixes timeout bounds
  sysctl: Fixes scsi_logging_level bounds
  sysctl/infiniband: Fixes infiniband sysctl bounds
  sysctl: Fixes max-user-freq bounds

 drivers/char/hpet.c                     |  4 +++-
 drivers/infiniband/core/iwcm.c          |  4 +++-
 drivers/infiniband/core/ucma.c          |  4 +++-
 drivers/scsi/scsi_sysctl.c              |  4 +++-
 fs/coda/sysctl.c                        |  4 +++-
 fs/lockd/svc.c                          |  4 +++-
 fs/nfs/nfs4sysctl.c                     |  4 +++-
 net/ipv4/route.c                        |  4 +++-
 net/ipv6/route.c                        |  4 +++-
 net/ipv6/xfrm6_policy.c                 |  4 +++-
 net/netfilter/nf_conntrack_standalone.c | 12 +++++++++---
 11 files changed, 39 insertions(+), 13 deletions(-)

-- 
2.48.1


