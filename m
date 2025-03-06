Return-Path: <linux-nfs+bounces-10501-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22257A54AD0
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Mar 2025 13:35:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A92616C991
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Mar 2025 12:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7726C20B807;
	Thu,  6 Mar 2025 12:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=clip-os.org header.i=@clip-os.org header.b="feEV66fm"
X-Original-To: linux-nfs@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657EA20B7EB;
	Thu,  6 Mar 2025 12:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741264534; cv=none; b=u2dqpqIsCttRGlceLz0yFdTMI9b4fzxG9PXgdUd6GDxaNJq9Px597lkx6jplghr4vJ+zRXDmEkMVQv292ZuN1nIoVFUo2EGCf/ZRFwQfH2hdUT4pQd+MNyhXl5SpgBhRXayP8WUhGnO1nqbVT9H+xxa+aWpOcG628EitEGVVSAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741264534; c=relaxed/simple;
	bh=KYLE385lYBDE+b0rW4pq24p5hzoXwRewcZlo53DkeuA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dTU6qHwWtAf9WDWPtvEC/g77VNPNvTbJvxjbtpDf4Ovb+L9QaFvSLoSmLmH920agl2sDs7G6oi46AHRhAUoWWkzlC4g79jxzggYYyarZq9MneS+xnSDi4ytvUiMSaCUGvAxGDLb+ViX+2RHx+3p6kxq/7pRYsei3yHt3t0Lx0Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=clip-os.org; spf=pass smtp.mailfrom=clip-os.org; dkim=pass (2048-bit key) header.d=clip-os.org header.i=@clip-os.org header.b=feEV66fm; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=clip-os.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=clip-os.org
Received: by mail.gandi.net (Postfix) with ESMTPSA id AD6AA4424F;
	Thu,  6 Mar 2025 12:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=clip-os.org; s=gm1;
	t=1741264530;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bKGPv+VkKk+jMpdUIOW6EvNju9ijdlaeQ1JxJiPSdBc=;
	b=feEV66fmn/UIC3rJWk1YmSAQePrruvbUjH9AEbG6BXTcAjsPXf+dWVt1qNrUm3ux4CA5K3
	35GpdpBe4Ulqufq0rnMR5VLO+lHgxWpytYxVXon+JXLSI/NxEquAf3hgZWi2HKAZVd2GVa
	4R7cwnPKMR7DWJHYprHI3aX429XvaFUWPwUo09+93j46SRAZzTaCMZYdZdFrxqhtVQleUJ
	z8HVJScmIzpjAjHhIC+wI4yEvxNciRvUAEXHiaeaEWNUEFlFd30e9XMFqBmVvttmBWZGNl
	zhOfdsrOOlm/MdivSWYnlT6InlbS3+hbPaWrBoMWsqj05zR9139Jqb6QcS1yDQ==
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
Subject: [PATCH v3 1/3] sysctl: Fixes idmap_cache_timeout bounds
Date: Thu,  6 Mar 2025 13:35:08 +0100
Message-ID: <20250306123514.386434-2-nicolas.bouchinet@clip-os.org>
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

Bound idmap_cache_timeout sysctl writings between SYSCTL_ZERO
and SYSCTL_INT_MAX.

The proc_handler has thus been updated to proc_dointvec_minmax.

Signed-off-by: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
---
 fs/nfs/nfs4sysctl.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/nfs4sysctl.c b/fs/nfs/nfs4sysctl.c
index d1a92d8f8ba4c..c36d89afb13af 100644
--- a/fs/nfs/nfs4sysctl.c
+++ b/fs/nfs/nfs4sysctl.c
@@ -32,7 +32,9 @@ static const struct ctl_table nfs4_cb_sysctls[] = {
 		.data = &nfs_idmap_cache_timeout,
 		.maxlen = sizeof(int),
 		.mode = 0644,
-		.proc_handler = proc_dointvec,
+		.proc_handler = proc_dointvec_minmax,
+		.extra1 = SYSCTL_ZERO,
+		.extra2 = SYSCTL_INT_MAX,
 	},
 };
 
-- 
2.48.1


