Return-Path: <linux-nfs+bounces-9678-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 396B4A1D835
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Jan 2025 15:24:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 151B83A3526
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Jan 2025 14:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88AF018CC1C;
	Mon, 27 Jan 2025 14:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=clip-os.org header.i=@clip-os.org header.b="WMJpchMr"
X-Original-To: linux-nfs@vger.kernel.org
Received: from relay0.mail.gandi.net (relay0.mail.gandi.net [217.70.178.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A23E188926;
	Mon, 27 Jan 2025 14:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737987655; cv=none; b=SqVgPn9vqXweMnMZj7KJM2gBRcnox9+YOEU88/cC8HrwdhCQOiblR+GYhlGVuSLm23Vb0eEF23gx4CRlMqyvPDAOSeGafV1Ub22mOi071ZTVFPGTgQx13Z9SqC0xYYKa2gs7uraed/gWnmaeudfGSX3LQF2mTgS3KFTUVzcz0LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737987655; c=relaxed/simple;
	bh=s4FGh8+Jt0+W5EtK2lxHVEDvNUFrgHmLElUFdHDZ5wo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TQDwoUawxnSE4YKQ4WGEh3ojaqKqiODkcnlOXyZ/K5v7x0OPdm0OY7uOT0ZAj/2D0aXEAC+TmxNzuvwZsEXX9ftmIAE4xpvVVdm5Zij7gx974/4lkKOIi8itpO2AZdlBfOb0HrMKCEfIqIxkuSYH/4J08UabjNYIVB/PT54SYE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=clip-os.org; spf=pass smtp.mailfrom=clip-os.org; dkim=pass (2048-bit key) header.d=clip-os.org header.i=@clip-os.org header.b=WMJpchMr; arc=none smtp.client-ip=217.70.178.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=clip-os.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=clip-os.org
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2D60F440FC;
	Mon, 27 Jan 2025 14:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=clip-os.org; s=gm1;
	t=1737987651;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1sxrIc3JChwt94nC6YIZ2Rtxk2QrX9t8Sx5zP8GJlJ8=;
	b=WMJpchMr/d9IWQ30ZHv8W7O+2o/suSR7o6FzrqGnScIcv/5d77JhXcHXGgp0IKyaC0X+We
	rwDKUf9qzjgbKvgWK1QnhyzlEVB69oOzUFJlK+1fSwHe1znef1hJSU3tbtRaf+/yMwAYa/
	8YmAap3vzf5bXjBWUS6vm2iIAbBysahbjEdOuL067dq3/84W/rSTHQOw8LPrfPPsObte0f
	f+cGA5WvQcfFlU/eYtolXeAKHFtzIjh7VuHPUhGuspwLyvlQW/WBLJeKhwXMaEDDneF1UZ
	pgo4eMOIgq/taBshBEjX3XO/WNK9k1ixQrwgNLFFB+UqxR+k/dvGI85j7in73Q==
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
Subject: [PATCH v1 9/9] sysctl: Fixes max-user-freq bounds
Date: Mon, 27 Jan 2025 15:20:06 +0100
Message-ID: <20250127142014.37834-10-nicolas.bouchinet@clip-os.org>
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

Bound max-user-freq sysctl writings between SYSCTL_ZERO
and SYSCTL_INT_MAX.

The proc_handler has thus been updated to proc_dointvec_minmax.

Signed-off-by: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
---
 drivers/char/hpet.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/char/hpet.c b/drivers/char/hpet.c
index 48fe96ab46490..02d2e76b7ef7e 100644
--- a/drivers/char/hpet.c
+++ b/drivers/char/hpet.c
@@ -730,7 +730,9 @@ static struct ctl_table hpet_table[] = {
 	 .data = &hpet_max_freq,
 	 .maxlen = sizeof(int),
 	 .mode = 0644,
-	 .proc_handler = proc_dointvec,
+	 .proc_handler = proc_dointvec_minmax,
+	 .extra1 = SYSCTL_ZERO,
+	 .extra2 = SYSCTL_INT_MAX,
 	 },
 };
 
-- 
2.48.1


