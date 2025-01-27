Return-Path: <linux-nfs+bounces-9669-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6256A1D7F0
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Jan 2025 15:20:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09390166379
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Jan 2025 14:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0649E8460;
	Mon, 27 Jan 2025 14:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=clip-os.org header.i=@clip-os.org header.b="oGfM8hEc"
X-Original-To: linux-nfs@vger.kernel.org
Received: from relay0.mail.gandi.net (relay0.mail.gandi.net [217.70.178.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC71D10A3E;
	Mon, 27 Jan 2025 14:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737987639; cv=none; b=QrDILofS8CZDIet9SCsb30esDiapD4nQAaWj61GLp1F/61GY5wxEGKtpH7ZhxY9/rsItIu2SErHzVIYE2nnymtZEhdFSbQzBi3NWHwwAyJRzE7ZuTYsZCvMghHATPNPCaNCdDwMGueAn13Wax2LTt8FJt2StvFcTgFOl3WV8p6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737987639; c=relaxed/simple;
	bh=uOM6tJrJ5zFAqB9991Cmwb9IscRLSSl/ju7jaqZLfNU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ig4i0aFFvH/VLJ2BFR9/brGiMdcONkXclwPG3FlPR6Ivn9GMDiLVV0TvHIfNHnrLNv8dDOTjA5JDmYLa2y8kvDLH9/tQmqkCBojrzgQUEUIhNjvsoVdb6GZN7/gE4aDafBmXVWmRT04ni0su4lNBpIxzBEU9xwrmAaR7rUzY5x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=clip-os.org; spf=pass smtp.mailfrom=clip-os.org; dkim=pass (2048-bit key) header.d=clip-os.org header.i=@clip-os.org header.b=oGfM8hEc; arc=none smtp.client-ip=217.70.178.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=clip-os.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=clip-os.org
Received: by mail.gandi.net (Postfix) with ESMTPSA id F3F7F44110;
	Mon, 27 Jan 2025 14:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=clip-os.org; s=gm1;
	t=1737987635;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Oh2Oh3J91gJ6kMI4DpWRpPpzvF6a8IlOhQ3OUmVv56o=;
	b=oGfM8hEcKeVYftipEUcCIgrl3RS5xlEqAGFYdkhoUKn1Pch0bzV+vwXNsglCz24FGDOAbn
	Iy2BjzrK70hn7hpqby5VCKBJXrDxl2+xIZr+wucN6kywcmrXV8jRlzTr2HmZ15GRDb8tAs
	cx0hXXUdREn7ePmSnMoz3e3UPWlQerAQI/spJZ9ozyrygdmvijfAwxobnulxJvaYX0LrsD
	uU/7MxG9x9Wb/09ga9tRAAOk5TDT2CYHJrwUjf7Ta4Fn2Fgr22vR4yewwPRreqVjuWRymv
	3H3XkeZkqo1jiFDt9vM9BYVx+cUNc+FbPV/qBpm0WZXqMuCE8oFi3M+YjOQEPg==
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
Subject: [PATCH v1 2/9] sysctl: Fixes nf_conntrack_expect_max bounds
Date: Mon, 27 Jan 2025 15:19:59 +0100
Message-ID: <20250127142014.37834-3-nicolas.bouchinet@clip-os.org>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedgudefgedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenogfuohhrthgvugftvggtihhpvdculdegtddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepnhhitgholhgrshdrsghouhgthhhinhgvthestghlihhpqdhoshdrohhrghenucggtffrrghtthgvrhhnpeetheefteekueejtefhheeilefhjeefudetjeeileevgeeffeeiueehieettefhveenucfkphepledtrdeifedrvdegiedrudekjeenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepihhnvghtpeeltddrieefrddvgeeirddukeejpdhhvghloheprghrtghhlhhinhhugidrrddpmhgrihhlfhhrohhmpehnihgtohhlrghsrdgsohhutghhihhnvghtsegtlhhiphdqohhsrdhorhhgpdhnsggprhgtphhtthhopeduiedprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhrughmrgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhstghsihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohgurghlihhsthestghouggrrdgtshdrtghmuhdrvgguuhdpr
 hgtphhtthhopehlihhnuhigqdhnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvthhfihhlthgvrhdquggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohhrvghtvggrmhesnhgvthhfihhlthgvrhdrohhrgh
X-GND-Sasl: nicolas.bouchinet@clip-os.org

From: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>

Bound nf_conntrack_expect_max sysctl writings between SYSCTL_ONE
and SYSCTL_INT_MAX.

The proc_handler has thus been updated to proc_dointvec_minmax.

The lower bound is SYSCTL_ONE as defined in the sysctl documentation.

Signed-off-by: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
---
 net/netfilter/nf_conntrack_standalone.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/netfilter/nf_conntrack_standalone.c b/net/netfilter/nf_conntrack_standalone.c
index 40ed3ef9cb22d..3ea60ff7a6a49 100644
--- a/net/netfilter/nf_conntrack_standalone.c
+++ b/net/netfilter/nf_conntrack_standalone.c
@@ -657,7 +657,9 @@ static struct ctl_table nf_ct_sysctl_table[] = {
 		.data		= &nf_ct_expect_max,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ONE,
+		.extra2		= SYSCTL_INT_MAX,
 	},
 	[NF_SYSCTL_CT_ACCT] = {
 		.procname	= "nf_conntrack_acct",
-- 
2.48.1


