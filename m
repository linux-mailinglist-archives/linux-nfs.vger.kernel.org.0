Return-Path: <linux-nfs+bounces-10502-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 919CCA54AD4
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Mar 2025 13:35:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51F4C3AED63
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Mar 2025 12:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D57EF20C03B;
	Thu,  6 Mar 2025 12:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=clip-os.org header.i=@clip-os.org header.b="Enrrbqrt"
X-Original-To: linux-nfs@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62B7202C5C;
	Thu,  6 Mar 2025 12:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741264535; cv=none; b=ROhiSePfGHIHt/WXHoAOHol3YBhiDV1GIMLN3n/LJflur2SMq121v6SY39blgIT53CYccJTCfvnMWIUnwENByE640MB4DpswZHArm0LpGXJciYjKwjGBlTgeeLuJHqfOW5ZwYxf2jFYe7LsKwGJZSdjj3lUwSV4Ckxfa4vilHCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741264535; c=relaxed/simple;
	bh=yllEYqYVMLCt2QLV5kyEAqh6tj3UnOxIPtDxhcZ4mco=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tBObkbQQ6LVg73gQAIUovo0QqgnXZBp92Yx76f7QejDydwaihrZU0XOu/t0/xjla92cxf22HZPbB93sI5PL6ZgJ3ZugZC1waccBOkWggnlTnxLncCqRH1MkERjg9HyPztlfqj6xOojAWIkek2ssQJgjopFjDwUq8CdiDz9sqXeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=clip-os.org; spf=pass smtp.mailfrom=clip-os.org; dkim=pass (2048-bit key) header.d=clip-os.org header.i=@clip-os.org header.b=Enrrbqrt; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=clip-os.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=clip-os.org
Received: by mail.gandi.net (Postfix) with ESMTPSA id D3D504328A;
	Thu,  6 Mar 2025 12:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=clip-os.org; s=gm1;
	t=1741264531;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k4NWIVIP5PfuUyZ0qRIWf49V6Zi3c0xIKE7a82+fDhM=;
	b=EnrrbqrtY/+13mPnVJbeO92Znj8jTGD3OdD8SkMsRoMy1nTuJUKiI8FqNl5h7mxN4nxxVo
	L0Sf/9iPxp0I2Ji5fm1RPs6lwdYX+hOXoIHH09IIKmHyNmGvStTux/AHwoWtZjIRsh/kJL
	E4osovlp38TQgMP1NE+u5jyYL/bTsIuecDsszJQjjULY96TbUhNPj4i1qwvuDz0kOUgElD
	xtEUzFcAkho69OQRsndxqUaeAxyT41VYtGxjZJ1rlPzcci6Dpd4+VYw9u80I3yQzTCwmkn
	l87A0fA/5K8s0HBfzqYS8oLI1WC5JUy/zF/WTw2W6oK3kiry6Lk0VyPmp+F+wA==
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
Subject: [PATCH v3 2/3] sysctl/coda: Fixes timeout bounds
Date: Thu,  6 Mar 2025 13:35:09 +0100
Message-ID: <20250306123514.386434-3-nicolas.bouchinet@clip-os.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250306123514.386434-1-nicolas.bouchinet@clip-os.org>
References: <20250306123514.386434-1-nicolas.bouchinet@clip-os.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdejjeekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpehnihgtohhlrghsrdgsohhutghhihhnvghtsegtlhhiphdqohhsrdhorhhgnecuggftrfgrthhtvghrnhepvddvuedutdeifedvleegjeeuudetuddvlefgteeludehueehvdevvdefveelueejnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepledtrdeifedrvdegiedrudekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrieefrddvgeeirddukeejpdhhvghloheprghrtghhlhhinhhugidrrddpmhgrihhlfhhrohhmpehnihgtohhlrghsrdgsohhutghhihhnvghtsegtlhhiphdqohhsrdhorhhgpdhnsggprhgtphhtthhopeduvddprhgtphhtthhopegtohgurgestghsrdgtmhhurdgvughupdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghouggrlhhishhtsegtohgurgdrtghsrdgtmhhurdgvughupdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehnihgtohhlr
 ghsrdgsohhutghhihhnvghtsehsshhirdhgohhuvhdrfhhrpdhrtghpthhtohepjhdrghhrrghnrgguohhssehsrghmshhunhhgrdgtohhmpdhrtghpthhtoheptghlvghmvghnsheslhgrughishgthhdruggvpdhrtghpthhtoheprghrnhgusegrrhhnuggsrdguvg
X-GND-Sasl: nicolas.bouchinet@clip-os.org

From: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>

Bound coda timeout sysctl writings between SYSCTL_ZERO
and SYSCTL_INT_MAX.

The proc_handler has thus been updated to proc_dointvec_minmax.

coda_timeout type has been updated from an unsigned long to an unsigned
int since it is typically set to some value well under a minute.

Signed-off-by: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>

---

Changes since v2:
https://lore.kernel.org/all/20250224095826.16458-4-nicolas.bouchinet@clip-os.org/

* Changed coda_timeout type from unsigned long to unsigned int as
  suggested by Joel Granados and Jan Harkes.

---
 fs/coda/coda_int.h | 2 +-
 fs/coda/sysctl.c   | 4 +++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/coda/coda_int.h b/fs/coda/coda_int.h
index f82b59c9dd287..c7fc4c5a77d58 100644
--- a/fs/coda/coda_int.h
+++ b/fs/coda/coda_int.h
@@ -6,7 +6,7 @@ struct dentry;
 struct file;
 
 extern struct file_system_type coda_fs_type;
-extern unsigned long coda_timeout;
+extern unsigned int coda_timeout;
 extern int coda_hard;
 extern int coda_fake_statfs;
 
diff --git a/fs/coda/sysctl.c b/fs/coda/sysctl.c
index 0df46f09b6cc5..d6f8206c51575 100644
--- a/fs/coda/sysctl.c
+++ b/fs/coda/sysctl.c
@@ -20,7 +20,9 @@ static const struct ctl_table coda_table[] = {
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


