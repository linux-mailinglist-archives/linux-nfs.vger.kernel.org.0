Return-Path: <linux-nfs+bounces-10307-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F904A41A04
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Feb 2025 11:03:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25BD31891C44
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Feb 2025 10:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 842E125742D;
	Mon, 24 Feb 2025 09:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=clip-os.org header.i=@clip-os.org header.b="pgHOFZqz"
X-Original-To: linux-nfs@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35627250BFF;
	Mon, 24 Feb 2025 09:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740391151; cv=none; b=UxqKmOqkZFB3HmvxTpcvrXdoOCVcQWu38ezsq32XAXFvvHqJd7+2JDN/UHwPtIK+Gk46tPi+OpS+zp/t/wG4ldMjHfg22O8GyHgUsqRXye9niyE7gWOc8STbzmNuIyANh0sts+xphSYrJkyz12Lt62ZsupdEnqXLjpEe2NneMj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740391151; c=relaxed/simple;
	bh=Ea19bN/vjnrpIUiyzr84w6ttaRjcsA+GtfYkhI4u6CY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BYXk6G1HImOU8U8Ggxo3SA9VwlhpJiMnZmkL7jdxcxTYz6o0UnN7vJqoEhtSWjvszgF/5jI9fdwXoqlD1YxeWWoRnhzXXQbXuwq3aVFVNfqD+vjLJ7AIKDhbIYfGD1L/65cZ2BicGYjDeRnlx9FV+evYjIMrFk9/oz+xUpEjagQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=clip-os.org; spf=pass smtp.mailfrom=clip-os.org; dkim=pass (2048-bit key) header.d=clip-os.org header.i=@clip-os.org header.b=pgHOFZqz; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=clip-os.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=clip-os.org
Received: by mail.gandi.net (Postfix) with ESMTPSA id 82D2643418;
	Mon, 24 Feb 2025 09:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=clip-os.org; s=gm1;
	t=1740391147;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bpK9rjA2Iyr1/4shXdCRa2AwF0Vk//SchKoDcQ5rZXo=;
	b=pgHOFZqzeHdQFKGLTV8alC7SVrURSEguknik0k81xZ5Sgkp9h8Hrnk9tUXg0CU7YU9HaiA
	DuLoPOGFB8gRzv3smWOd9ug0P/vDOEJ8kgqVqOvjIwWLHaDMVZ21cKc0hngGakpUBZjpBI
	ZoiSInR2ofB44v4+W38e5GTV+zVsLGgUB8wWtwABtUPywYzeadkkt6H9YA5QePlcqjaYyN
	bovfoBR9pnOzH4VTa8DdwpoxF/ovCh0KVPmHluAqoqOWL0GjX1Y1x76JsRI01wlPH+nop0
	0MJ7NmPSFO0ky0cb+Csd6h0bnrzqwpeMP2/XW73HbhXNC6Ddei4FpSZxZ2ibGA==
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
Subject: [PATCH v2 5/6] sysctl/infiniband: Fixes infiniband sysctl bounds
Date: Mon, 24 Feb 2025 10:58:20 +0100
Message-ID: <20250224095826.16458-6-nicolas.bouchinet@clip-os.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250224095826.16458-1-nicolas.bouchinet@clip-os.org>
References: <20250224095826.16458-1-nicolas.bouchinet@clip-os.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -60
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdejkeegkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnegoufhorhhtvggutfgvtghiphdvucdlgedtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpehnihgtohhlrghsrdgsohhutghhihhnvghtsegtlhhiphdqohhsrdhorhhgnecuggftrfgrthhtvghrnhepteehfeetkeeujeethfehieelhfejfeduteejieelveegfeefieeuheeiteethfevnecukfhppeeltddrieefrddvgeeirddukeejnecuvehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehinhgvthepledtrdeifedrvdegiedrudekjedphhgvlhhopegrrhgthhhlihhnuhigrddrpdhmrghilhhfrhhomhepnhhitgholhgrshdrsghouhgthhhinhgvthestghlihhpqdhoshdrohhrghdpnhgspghrtghpthhtohepvdejpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqrhgumhgrsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqshgtshhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghouggrlhhishhtsegtohgurgdrtghsrdgtmhhurdgvughupdhrt
 ghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehnihgtohhlrghsrdgsohhutghhihhnvghtsehsshhirdhgohhuvhdrfhhrpdhrtghpthhtohepjhdrghhrrghnrgguohhssehsrghmshhunhhgrdgtohhmpdhrtghpthhtoheptghlvghmvghnsheslhgrughishgthhdruggv
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


