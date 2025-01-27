Return-Path: <linux-nfs+bounces-9677-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B67FDA1D82D
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Jan 2025 15:23:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 944003A1F40
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Jan 2025 14:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3215C18A6B8;
	Mon, 27 Jan 2025 14:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=clip-os.org header.i=@clip-os.org header.b="oK4RMpI3"
X-Original-To: linux-nfs@vger.kernel.org
Received: from relay0.mail.gandi.net (relay0.mail.gandi.net [217.70.178.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0A917B50A;
	Mon, 27 Jan 2025 14:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737987654; cv=none; b=H//jENXMCsIwQ8ywNR1SSOJ1AexCTe2c+iulUuyfBnTZqm0aJ4f+N1agNRccFcNJwIlpRsAWUjSFHjxtiex9MQ+mmgsG2Y9L7BO2l4SBM9zyen6qnGD2pQPoeeV+mzwwii3cdiPNSCoCWi2HalKpbuX5XvDRkgRE436UQ/SIDTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737987654; c=relaxed/simple;
	bh=Ea19bN/vjnrpIUiyzr84w6ttaRjcsA+GtfYkhI4u6CY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xid+H6AlUpKtEvgW+SHttCpRt+7D4qbY9CJKS+dbfNxIVYd59OMTNK9hWVmD5vps/Ph+/pWarYb9fDlY0R6O575OdwVj4KXix8mhVl71s2HWDtyhRPXFLGAbPkfLIgq37lVSN/qY3f5pv73RRifbknNtnotJO0n3AJT2Id5LE0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=clip-os.org; spf=pass smtp.mailfrom=clip-os.org; dkim=pass (2048-bit key) header.d=clip-os.org header.i=@clip-os.org header.b=oK4RMpI3; arc=none smtp.client-ip=217.70.178.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=clip-os.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=clip-os.org
Received: by mail.gandi.net (Postfix) with ESMTPSA id C5C5844111;
	Mon, 27 Jan 2025 14:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=clip-os.org; s=gm1;
	t=1737987650;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bpK9rjA2Iyr1/4shXdCRa2AwF0Vk//SchKoDcQ5rZXo=;
	b=oK4RMpI3dzKiZRHAJg6VLOWUv10jeXjgka3xPpn2banC7QoavnAzWYsrSfCr/5NRbaVy+L
	fEsfE3xAmzqzAFWKw3CcYE01wanBlLgI8dhPIymIH0VovltVSiWVQGSjkbWx9UbJSXZ08Q
	ubnh7IXwdftT78C5C8IVBFD94tPdYOhfEGEmHutHQNoxrtf/CEs//5G4jkvyTJ7Gb9x0tK
	W/PrZpK/vI5bVETkTvsYPFM4gpNmNQ/t+PdcXJtjC17qCX1kT/KtkrLAPTNz4L3Z+FdUCs
	zI7aD/Zj9Hw1RdsESqboMgQhAuV7de9KQW/67xYJ9sTV8OCOEb+xpZk374t8zw==
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
Subject: [PATCH v1 8/9] sysctl/infiniband: Fixes infiniband sysctl bounds
Date: Mon, 27 Jan 2025 15:20:05 +0100
Message-ID: <20250127142014.37834-9-nicolas.bouchinet@clip-os.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250127142014.37834-1-nicolas.bouchinet@clip-os.org>
References: <20250127142014.37834-1-nicolas.bouchinet@clip-os.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -60
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedgudefgedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenogfuohhrthgvugftvggtihhpvdculdegtddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepnhhitgholhgrshdrsghouhgthhhinhgvthestghlihhpqdhoshdrohhrghenucggtffrrghtthgvrhhnpeetheefteekueejtefhheeilefhjeefudetjeeileevgeeffeeiueehieettefhveenucfkphepledtrdeifedrvdegiedrudekjeenucevlhhushhtvghrufhiiigvpeehnecurfgrrhgrmhepihhnvghtpeeltddrieefrddvgeeirddukeejpdhhvghloheprghrtghhlhhinhhugidrrddpmhgrihhlfhhrohhmpehnihgtohhlrghsrdgsohhutghhihhnvghtsegtlhhiphdqohhsrdhorhhgpdhnsggprhgtphhtthhopeduiedprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhrughmrgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhstghsihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohgurghlihhsthestghouggrrdgtshdrtghmuhdrvgguuhdpr
 hgtphhtthhopehlihhnuhigqdhnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvthhfihhlthgvrhdquggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohhrvghtvggrmhesnhgvthhfihhlthgvrhdrohhrgh
X-GND-Sasl: nicolas.bouchinet@clip-os.org

From: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>

Bound infiniband iwcm and ucma sysctl writings between SYSCTL_ZERO
and SYSCTL_INT_MAX.

The proc_handler has thus been updated to proc_dointvec_minmax.

Signed-off-by: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
---
 drivers/infiniband/core/iwcm.c | 4 +++-
 drivers/infiniband/core/ucma.c | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/core/iwcm.c b/drivers/infiniband/core/iwcm.c
index 7e3a55349e107..f4486cbd8f45a 100644
--- a/drivers/infiniband/core/iwcm.c
+++ b/drivers/infiniband/core/iwcm.c
@@ -109,7 +109,9 @@ static struct ctl_table iwcm_ctl_table[] = {
 		.data		= &default_backlog,
 		.maxlen		= sizeof(default_backlog),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_INT_MAX,
 	},
 };
 
diff --git a/drivers/infiniband/core/ucma.c b/drivers/infiniband/core/ucma.c
index 02f1666f3cbab..6e700b9740331 100644
--- a/drivers/infiniband/core/ucma.c
+++ b/drivers/infiniband/core/ucma.c
@@ -69,7 +69,9 @@ static struct ctl_table ucma_ctl_table[] = {
 		.data		= &max_backlog,
 		.maxlen		= sizeof max_backlog,
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_INT_MAX,
 	},
 };
 
-- 
2.48.1


