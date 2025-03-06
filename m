Return-Path: <linux-nfs+bounces-10500-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A54AA54ACF
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Mar 2025 13:35:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 342C63A4861
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Mar 2025 12:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DF5C205E25;
	Thu,  6 Mar 2025 12:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=clip-os.org header.i=@clip-os.org header.b="i+ObyS3e"
X-Original-To: linux-nfs@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D09820A5E7;
	Thu,  6 Mar 2025 12:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741264534; cv=none; b=EKstqPSEy+mAdU05eC1JbLV+IjdvsWEF2BdbGDhllRk3Zn2ruXLAanKrcGv8jeUraTjfdwGbm8cWcbrqL36+R+M9AMRLnSFG7RgLY9//JVizVhiE+YO0vNK9Eujm4NrR/y7sbirgh7SEzcGz+nnZtueEsMmONI8WKoTVSrJRnJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741264534; c=relaxed/simple;
	bh=Yjc4g7I3W0q996AfPYrXozncDPv74eSiI3Za5orBClw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Nl6Knv674N1w1MAcZFlz69z20VVGbW2lUNvCcXj2AdmkxWr6gjRRh/O4KlN/zvX9AR0Qktnw51nc/t7YX/15cPWOWInnK6KtdPZWeW3qx2lIz+zHzMaykDIiDddZnTQmxhvbD6PdB3aqo64D+RimR00Un7jogf+wxiHeAQbvvPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=clip-os.org; spf=pass smtp.mailfrom=clip-os.org; dkim=pass (2048-bit key) header.d=clip-os.org header.i=@clip-os.org header.b=i+ObyS3e; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=clip-os.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=clip-os.org
Received: by mail.gandi.net (Postfix) with ESMTPSA id B956041C84;
	Thu,  6 Mar 2025 12:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=clip-os.org; s=gm1;
	t=1741264529;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LIAupSyQFmMjLVkh2YfYSYCNekyDLDkOQLc1JGMLJy4=;
	b=i+ObyS3e3eXqSSUU5kHwJ12fYtwUEIDyBKyXFObUolVpP5yTDwHgJrrIfPFGnJJotghqKK
	70jNbwZYAHkr2AYZdxWAhKhkLvSCKDkEexz06lxNb5pY1TyC7eGq4giqbyQsaaPxjEUeRm
	Q0J93+vvcuvHSJyDm8wb5Nyyep3R6fb7Vg4ojHuZ1K703GQpehq8IJh1bD3qIC0q+QEQ70
	u8EAae+x95G9u2uDGxzVQvD2ereA+ApPEr5aKYLovTBe7WT61VR/M8TXS/K+4sz63/oM7h
	M7TuWs7pQHh72G4Vw2HGVcQINFZ6a/+TrkWSzEjkjN3B3XteBFY52fH/sVIYWA==
From: nicolas.bouchinet@clip-os.org
To: coda@cs.cmu.edu,
	linux-kernel@vger.kernel.org,
	codalist@coda.cs.cmu.edu,
	linux-nfs@vger.kernel.org
Cc: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>,
	Joel Granados <j.granados@samsung.com>,
	Clemens Ladisch <clemens@ladisch.de>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jan Harkes <jaharkes@cs.cmu.edu>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Subject: [PATCH v3 0/3] Fixes multiple sysctl bound checks
Date: Thu,  6 Mar 2025 13:35:07 +0100
Message-ID: <20250306123514.386434-1-nicolas.bouchinet@clip-os.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdejjeekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpehnihgtohhlrghsrdgsohhutghhihhnvghtsegtlhhiphdqohhsrdhorhhgnecuggftrfgrthhtvghrnhepieeigeehteehfeetuddtieefuefgfeevheevvdeiudetvdelleejveekkedvleeknecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepledtrdeifedrvdegiedrudekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrieefrddvgeeirddukeejpdhhvghloheprghrtghhlhhinhhugidrrddpmhgrihhlfhhrohhmpehnihgtohhlrghsrdgsohhutghhihhnvghtsegtlhhiphdqohhsrdhorhhgpdhnsggprhgtphhtthhopeduvddprhgtphhtthhopegtohgurgestghsrdgtmhhurdgvughupdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghouggrlhhishhtsegtohgurgdrtghsrdgtmhhurdgvughupdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehnihgtohhlrghsr
 dgsohhutghhihhnvghtsehsshhirdhgohhuvhdrfhhrpdhrtghpthhtohepjhdrghhrrghnrgguohhssehsrghmshhunhhgrdgtohhmpdhrtghpthhtoheptghlvghmvghnsheslhgrughishgthhdruggvpdhrtghpthhtoheprghrnhgusegrrhhnuggsrdguvg
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

Changes since v2:
https://lore.kernel.org/all/20250224095826.16458-1-nicolas.bouchinet@clip-os.org/

* Detached patches 2/6, 4/6 and 5/6
* Changed coda_timeout type from unsigned long to unsigned int as
  suggested by Joel Granados and Jan Harkes.

Changes since v1:
https://lore.kernel.org/all/20250127142014.37834-1-nicolas.bouchinet@clip-os.org/

* Detached patches 1/9, 2/9 [3] and 3/9 [4]
* Adapted the cover-letter message to match the reduced patchset

[3]: https://lore.kernel.org/all/20250129170633.88574-1-nicolas.bouchinet@clip-os.org/
[4]: https://lore.kernel.org/all/20250128103821.29745-1-nicolas.bouchinet@clip-os.org/

---

Nicolas Bouchinet (3):
  sysctl: Fixes idmap_cache_timeout bounds
  sysctl/coda: Fixes timeout bounds
  sysctl: Fixes max-user-freq bounds

 drivers/char/hpet.c | 4 +++-
 fs/coda/coda_int.h  | 2 +-
 fs/coda/sysctl.c    | 4 +++-
 fs/nfs/nfs4sysctl.c | 4 +++-
 4 files changed, 10 insertions(+), 4 deletions(-)

-- 
2.48.1

