Return-Path: <linux-nfs+bounces-9674-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0F1BA1D811
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Jan 2025 15:22:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F6C51664F3
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Jan 2025 14:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89ECE15A842;
	Mon, 27 Jan 2025 14:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=clip-os.org header.i=@clip-os.org header.b="YHSBX8/J"
X-Original-To: linux-nfs@vger.kernel.org
Received: from relay0.mail.gandi.net (relay0.mail.gandi.net [217.70.178.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08257155747;
	Mon, 27 Jan 2025 14:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737987648; cv=none; b=GxbJWlpCklbncGJZY+nxyh8sqWVBMBMp7zbQjjiqqzuKHiXy6caoumgRtXRurKBbzpzXF1j4iOxnzCqCIh49w0YNsP+cx3U2VDTplWhuvAGbSLBZT0PQXXveDsAWIkLAdr2mIvvHZCS4sTlgfEou6LebX3gImi7v+qpVFabhCLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737987648; c=relaxed/simple;
	bh=C7EQBwFwMT89/Rd4X93SE6Y8ImjJa4MR5t8f/2AXViM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SotzUwDFHZO5UrvtEFXXwBh/7XL40Zt8MCkxT1xptMeN9/hWLsMc4U/hQ/iWX+U7DsaJ9Q5sM05q4zStgULkSYA00Rhg3VMAyBIexob8HSuBn3shngz641JHqqEhyhblBGuFtiOwEWwrI039stast1RWmq2mP/Kr1LyW1XBRmGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=clip-os.org; spf=pass smtp.mailfrom=clip-os.org; dkim=pass (2048-bit key) header.d=clip-os.org header.i=@clip-os.org header.b=YHSBX8/J; arc=none smtp.client-ip=217.70.178.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=clip-os.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=clip-os.org
Received: by mail.gandi.net (Postfix) with ESMTPSA id 21EFE440FC;
	Mon, 27 Jan 2025 14:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=clip-os.org; s=gm1;
	t=1737987644;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WgivBUMYj657OYvxESBYxd1xBssg7E3u24chPtywJeY=;
	b=YHSBX8/JZlTQrmOu9q79eGbSYd64j0Wv2Kp3qogOlzYCsXOJOq8HjvzDsVqF2bIt9aCxkO
	pNMC2x17TEOp3r/1/f5OAiAxtQ6kk7eRXs2ttetnSy7MAg0jkOz98LUWbS46eMBID4E8RP
	dlxjashR+xQAmpEIqARjYVIr+f00YFh9pgvGjX2L9DfL+WsVxd9PlNloLfpGx9Td+BVENH
	f5hFHud/0L11IcAIJKVngXYQluJPcf99mD8MYI9nM3UUctr1E25nvJgHijnhc93SVSTpaL
	/j25628idAAx9LCu0bUsb/PzKqurfxKVLRI8H59E5V0u97LVsGpXwSIcP+QIug==
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
Subject: [PATCH v1 5/9] sysctl: Fixes nsm_local_state bounds
Date: Mon, 27 Jan 2025 15:20:02 +0100
Message-ID: <20250127142014.37834-6-nicolas.bouchinet@clip-os.org>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedgudefgedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenogfuohhrthgvugftvggtihhpvdculdegtddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepnhhitgholhgrshdrsghouhgthhhinhgvthestghlihhpqdhoshdrohhrghenucggtffrrghtthgvrhhnpeetheefteekueejtefhheeilefhjeefudetjeeileevgeeffeeiueehieettefhveenucfkphepledtrdeifedrvdegiedrudekjeenucevlhhushhtvghrufhiiigvpeefnecurfgrrhgrmhepihhnvghtpeeltddrieefrddvgeeirddukeejpdhhvghloheprghrtghhlhhinhhugidrrddpmhgrihhlfhhrohhmpehnihgtohhlrghsrdgsohhutghhihhnvghtsegtlhhiphdqohhsrdhorhhgpdhnsggprhgtphhtthhopeduiedprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhrughmrgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhstghsihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohgurghlihhsthestghouggrrdgtshdrtghmuhdrvgguuhdpr
 hgtphhtthhopehlihhnuhigqdhnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvthhfihhlthgvrhdquggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohhrvghtvggrmhesnhgvthhfihhlthgvrhdrohhrgh
X-GND-Sasl: nicolas.bouchinet@clip-os.org

From: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>

Bound nsm_local_state sysctl writings between SYSCTL_ZERO
and SYSCTL_INT_MAX.

The proc_handler has thus been updated to proc_dointvec_minmax.

Signed-off-by: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
---
 fs/lockd/svc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/lockd/svc.c b/fs/lockd/svc.c
index 4ec22c2f2ea3c..84752d27d0072 100644
--- a/fs/lockd/svc.c
+++ b/fs/lockd/svc.c
@@ -468,7 +468,9 @@ static struct ctl_table nlm_sysctls[] = {
 		.data		= &nsm_local_state,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_INT_MAX,
 	},
 };
 
-- 
2.48.1


