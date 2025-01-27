Return-Path: <linux-nfs+bounces-9675-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E1A2A1D81C
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Jan 2025 15:23:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC224166CAC
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Jan 2025 14:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 724F0175D5D;
	Mon, 27 Jan 2025 14:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=clip-os.org header.i=@clip-os.org header.b="OAotX0X+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from relay0.mail.gandi.net (relay0.mail.gandi.net [217.70.178.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2AA615EFA1;
	Mon, 27 Jan 2025 14:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737987651; cv=none; b=aGA1kHKpJw5D0LuYm4Udc5EiwJnICsLT5mJYC2+29qsM9grmLnR3W0+fg12iJSFwuYtkMuQFydls+ckNNXvnozICpd4y0s9NlN+aqAuaFpDFvWmmxgbciHV0q5vUxr4ovi/eFNcFQSkqEhsY76KSy6Ogh3U9DUOBCeDG1M8RZJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737987651; c=relaxed/simple;
	bh=QVW6+AudYsmUldqtr943V3avAI/kNy4VK7bZUAfma8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CgXO453OJaZuYfIquqre7pqObj+Nn31qITpl6GRhAGvItT1ssP6xByn5jNv1QBy5NTU8i+DOx/6y1g4KMN89J4hl2glRbj+sDtoNQORWWeSt1SmzGYpqqdLGOu9LmsMKkbONS/2Coru0+4THX9TRmhjrwHAeqTM+5RWGfjO/ngw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=clip-os.org; spf=pass smtp.mailfrom=clip-os.org; dkim=pass (2048-bit key) header.d=clip-os.org header.i=@clip-os.org header.b=OAotX0X+; arc=none smtp.client-ip=217.70.178.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=clip-os.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=clip-os.org
Received: by mail.gandi.net (Postfix) with ESMTPSA id 005E34410C;
	Mon, 27 Jan 2025 14:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=clip-os.org; s=gm1;
	t=1737987647;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KibZbzZo3TB3J4k1DB83wl5gFCd90FiiNovI3HiLcX0=;
	b=OAotX0X+7p4Lis1yPaWQsYekuDjhkei/lI4Pc18KMKZuT7Kl6xpRDzcdZXX/+oXY0xWzs6
	M5C0nZu6QoKo401n61yu+d97ipDboruf1yc3LVzwoRKSN+b+yFAfsTTHoWtVcZRmmmoikc
	2PomCh2vFRI3AxqV5LDdDRM3Zf6u+NfMr9n/OvTI+0KIJm4gnuHrt7Ntn7PmrgBQchuBMF
	zVJLod31tC23t5oVi1P1tjX+GL65KOGpeEA+awE0GYlv4BSP6C39RqBB5CHEWkjHfBD4ni
	GI82C9K06/3GHcnZwOxGfNwh91gmHlrd4mXmIVD/MMHebGrf6S8pLYa233V6Ng==
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
Subject: [PATCH v1 6/9] sysctl/coda: Fixes timeout bounds
Date: Mon, 27 Jan 2025 15:20:03 +0100
Message-ID: <20250127142014.37834-7-nicolas.bouchinet@clip-os.org>
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

Bound coda timeout sysctl writings between SYSCTL_ZERO
and SYSCTL_INT_MAX.

The proc_handler has thus been updated to proc_dointvec_minmax.

Signed-off-by: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
---
 fs/coda/sysctl.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/coda/sysctl.c b/fs/coda/sysctl.c
index 9f2d5743e2c89..2cba42c46ff10 100644
--- a/fs/coda/sysctl.c
+++ b/fs/coda/sysctl.c
@@ -20,7 +20,9 @@ static struct ctl_table coda_table[] = {
 		.data		= &coda_timeout,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_INT_MAX,
 	},
 	{
 		.procname	= "hard",
-- 
2.48.1


