Return-Path: <linux-nfs+bounces-10503-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F2BAA54AD5
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Mar 2025 13:36:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD40D3A5F1A
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Mar 2025 12:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D07C720CCDC;
	Thu,  6 Mar 2025 12:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=clip-os.org header.i=@clip-os.org header.b="UKIrSAgW"
X-Original-To: linux-nfs@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6C620C03C;
	Thu,  6 Mar 2025 12:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741264537; cv=none; b=hLcNNrGqEz228g8zysyrs6cZkDoDZuiGhg5tML1j6lbSxzjlQxccrT5P96zDQgAfyEitZ0nGBKBg+QV6XIqeWoRqFpNA4AMrSwrl8gPMuKBiFiJiPmsiR4lQ49oSsWGOMbK9j9MB2CxLeqLjMfwb4lx1UnVVa7HpBzMASB86J6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741264537; c=relaxed/simple;
	bh=hEdnDwVJYm+8ExpU7Gb8sRVeW+r5/QBiFQu5n+BciFc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sEtGXEsHQz5F5lF18zUeqc84/oXcFH7M5gWfi44gJVwD1CEKPpYY4A2qobrtRaW+AB9QmLwzIgb+7pUoZoQUjav5RMWdVi9F06SdzEsdz0UDPaNpcjCrXpmfY9yEJRQpcREIBtGYSlBMF+TZA5ZJy2hdHmQumY1GEJBkdP/phPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=clip-os.org; spf=pass smtp.mailfrom=clip-os.org; dkim=pass (2048-bit key) header.d=clip-os.org header.i=@clip-os.org header.b=UKIrSAgW; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=clip-os.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=clip-os.org
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0C37B44251;
	Thu,  6 Mar 2025 12:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=clip-os.org; s=gm1;
	t=1741264533;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DZX6+XiM6OJ3HGkhOxfUk7v+ByCTdttaIt3fhOvtZ1o=;
	b=UKIrSAgWvAWf7ebts3IU6CXQztXJeLemf0lDgxFLUNAfE7LaxCHyQhYzwzh8zKJFuvbk99
	RbykJYW4ySJOUC+Mabg8lepOlc4f1Vw7PjGlwbl33/IEOFQBO4XzcEvTmhHhF7l6J+XFpI
	/I4nUsfcT6XoVA8qqNCZD2RrQKRR0PNPc9Qg5ZvcofLwqSFAjvDpUp3KUwauTxavAGm/a4
	8V61qtFjof0lc1/VYO7Em8635XiDXMkUPN93woX2zFBea6iYv7K19nlSK8xgEvpf2ymccG
	ZBzkaFQoQC4IzaQbC2nKrTGNuSZNjRxw8UO6qdvKonCreSaFBkIFSDmGAU/rUg==
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
Subject: [PATCH v3 3/3] sysctl: Fixes max-user-freq bounds
Date: Thu,  6 Mar 2025 13:35:10 +0100
Message-ID: <20250306123514.386434-4-nicolas.bouchinet@clip-os.org>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdejjeekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpehnihgtohhlrghsrdgsohhutghhihhnvghtsegtlhhiphdqohhsrdhorhhgnecuggftrfgrthhtvghrnhepteehfeetkeeujeethfehieelhfejfeduteejieelveegfeefieeuheeiteethfevnecukfhppeeltddrieefrddvgeeirddukeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdeifedrvdegiedrudekjedphhgvlhhopegrrhgthhhlihhnuhigrddrpdhmrghilhhfrhhomhepnhhitgholhgrshdrsghouhgthhhinhgvthestghlihhpqdhoshdrohhrghdpnhgspghrtghpthhtohepuddvpdhrtghpthhtoheptghouggrsegtshdrtghmuhdrvgguuhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohgurghlihhsthestghouggrrdgtshdrtghmuhdrvgguuhdprhgtphhtthhopehlihhnuhigqdhnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhhitgholhgrshdrsghouhgthhhinhgvthesshhsihdrghhou
 hhvrdhfrhdprhgtphhtthhopehjrdhgrhgrnhgrughoshesshgrmhhsuhhnghdrtghomhdprhgtphhtthhopegtlhgvmhgvnhhssehlrgguihhstghhrdguvgdprhgtphhtthhopegrrhhnugesrghrnhgusgdruggv
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
index e110857824fcb..528b43e893d49 100644
--- a/drivers/char/hpet.c
+++ b/drivers/char/hpet.c
@@ -730,7 +730,9 @@ static const struct ctl_table hpet_table[] = {
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


