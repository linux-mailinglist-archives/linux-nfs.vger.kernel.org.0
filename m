Return-Path: <linux-nfs+bounces-10302-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE637A41A00
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Feb 2025 11:03:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39D011789F9
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Feb 2025 10:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B72642500B1;
	Mon, 24 Feb 2025 09:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=clip-os.org header.i=@clip-os.org header.b="nAeA2GRW"
X-Original-To: linux-nfs@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C3C24C67F;
	Mon, 24 Feb 2025 09:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740391141; cv=none; b=moPBIpSTHcBbHOUdYen3UA6/AipmgfmUHWZaBYiel7WKPWUp0cdodOTDJIidh42XJCa4JnsGo5WFxjmEqUd5YygIK8R7af3nZDCoOODxj6soWULkE5aXy/KZz+tCrrMaXBuqoLhW0SXD5Un9sm27rnc5TNIRdrH3nf6fd35jh1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740391141; c=relaxed/simple;
	bh=St/Eg/Hi0vB7O+toXHNs7Kfoy1TZReJPLQjUNk6OFTM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nKPGVTrremwfxyoOyzsDVD/zmrv0uMSZhMXmBjhSMWKLxNlkO6o5o7L0ZpT/GPmv7aUXmHqklCO9yHHAbPS78TUq/TRr+yTzRRtlNqXTj9AcP78UKcsDYbwm5fwFblOlHvJX7gwaqGM7pGCk0QDIX1GvCVGNXZw9FEyKqil7Q4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=clip-os.org; spf=pass smtp.mailfrom=clip-os.org; dkim=pass (2048-bit key) header.d=clip-os.org header.i=@clip-os.org header.b=nAeA2GRW; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=clip-os.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=clip-os.org
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2131543412;
	Mon, 24 Feb 2025 09:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=clip-os.org; s=gm1;
	t=1740391135;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=OysVBN1ZNK5dif5sP6Y9T/fqYZ6/xViWz15nOzq5Uko=;
	b=nAeA2GRWpLlfhwWV3sPCzWRZ10S3t0aB8aN+tZCCdp8uZEjfQtAbF+oPi3Pvcp8Q27Bo0R
	MSDkHxKa1Kc3f+HhtoIDc1U40J7KhkWxpDwWfdFVvqPYGOohTAOGEM0oMKjnS/seoVTdLb
	U8miYmOnI28l6XAzD2nABtiEwBsUQQUexfRtz3zK67qnVmJG2ISHjbhM6KHGXPAqOc81EH
	bbdOifVMdSwD7c45NhL20tZ6F8shZTHWESUC2NFLxpTzKgLlwv7GibEYq6yefpBIc30Cbx
	/24whkYWMLedNtncMCOLtAVWqKQOSJfB1oMtW7YnYcnTwxqOLyBCdH1TjMxPxg==
From: nicolas.bouchinet@clip-os.org
To: linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	codalist@coda.cs.cmu.edu,
	linux-nfs@vger.kernel.org
Cc: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>,
	Joel Granados <j.granados@samsung.com>,
	Clemens Ladisch <clemens@ladisch.de>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Jan Harkes <jaharkes@cs.cmu.edu>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Neil Brown <neilb@suse.de>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Zhu Yanjun <yanjun.zhu@linux.dev>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH v2 0/6] Fixes multiple sysctl bound checks
Date: Mon, 24 Feb 2025 10:58:15 +0100
Message-ID: <20250224095826.16458-1-nicolas.bouchinet@clip-os.org>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdejkeegkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnegoufhorhhtvggutfgvtghiphdvucdlgedtmdenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpehnihgtohhlrghsrdgsohhutghhihhnvghtsegtlhhiphdqohhsrdhorhhgnecuggftrfgrthhtvghrnhepieeigeehteehfeetuddtieefuefgfeevheevvdeiudetvdelleejveekkedvleeknecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepledtrdeifedrvdegiedrudekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrieefrddvgeeirddukeejpdhhvghloheprghrtghhlhhinhhugidrrddpmhgrihhlfhhrohhmpehnihgtohhlrghsrdgsohhutghhihhnvghtsegtlhhiphdqohhsrdhorhhgpdhnsggprhgtphhtthhopedvjedprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhrughmrgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhstghsihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohgurghlihhsthest
 ghouggrrdgtshdrtghmuhdrvgguuhdprhgtphhtthhopehlihhnuhigqdhnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhhitgholhgrshdrsghouhgthhhinhgvthesshhsihdrghhouhhvrdhfrhdprhgtphhtthhopehjrdhgrhgrnhgrughoshesshgrmhhsuhhnghdrtghomhdprhgtphhtthhopegtlhgvmhgvnhhssehlrgguihhstghhrdguvg
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

They are now bounded between SYSCTL_ZERO and SYSCTL_INT_MAX.
The proc_handlers have thus been updated to proc_dointvec_minmax.

This patchset has been written over sysctl-testing branch [1].
See [2] for similar sysctl fixes currently in review.

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/sysctl/sysctl.git/log/?h=sysctl-testing
[2]: https://lore.kernel.org/all/20250115132211.25400-1-nicolas.bouchinet@clip-os.org/

Best regards,

Nicolas

---

Changes since v1:
https://lore.kernel.org/all/20250127142014.37834-1-nicolas.bouchinet@clip-os.org/

* Detached patches 1/9, 2/9 [3] and 3/9 [4]
* Adapted the cover-letter message to match the reduced patchset

[3]: https://lore.kernel.org/all/20250129170633.88574-1-nicolas.bouchinet@clip-os.org/
[4]: https://lore.kernel.org/all/20250128103821.29745-1-nicolas.bouchinet@clip-os.org/

---

Nicolas Bouchinet (6):
  sysctl: Fixes idmap_cache_timeout bounds
  sysctl: Fixes nsm_local_state bounds
  sysctl/coda: Fixes timeout bounds
  sysctl: Fixes scsi_logging_level bounds
  sysctl/infiniband: Fixes infiniband sysctl bounds
  sysctl: Fixes max-user-freq bounds

 drivers/char/hpet.c            | 4 +++-
 drivers/infiniband/core/iwcm.c | 4 +++-
 drivers/infiniband/core/ucma.c | 4 +++-
 drivers/scsi/scsi_sysctl.c     | 4 +++-
 fs/coda/sysctl.c               | 4 +++-
 fs/lockd/svc.c                 | 4 +++-
 fs/nfs/nfs4sysctl.c            | 4 +++-
 7 files changed, 21 insertions(+), 7 deletions(-)

-- 
2.48.1


