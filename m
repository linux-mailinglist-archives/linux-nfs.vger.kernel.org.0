Return-Path: <linux-nfs+bounces-10306-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EBE6FA41A14
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Feb 2025 11:04:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 931617A84C3
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Feb 2025 10:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EAD7256C67;
	Mon, 24 Feb 2025 09:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=clip-os.org header.i=@clip-os.org header.b="M+CWHb2K"
X-Original-To: linux-nfs@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1907A255E4A;
	Mon, 24 Feb 2025 09:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740391149; cv=none; b=aM5S4hVcMyWTrMLG83dYxqw1nj9kRRf+BcRKkYqT/YYgi0ew05sCyYMOVEV768DmMPa4Zgu2bNSMa+HwkNeFts6lR/sK3quP/cp8VhQ1YIAU/6RnyOU54o63kH/Faf5w5EO6gikPExZGJ4xNHZyCMku2XWewIkW4BX2ym6C87X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740391149; c=relaxed/simple;
	bh=x7LDXz5gjzRqT41x6cb5nBAUnAncBQ9XsZlJ1yXvFDI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WbM+eiRojLUO1dC/j0AwYgkczQTRQctsTKHbmNRhfZlzMnOwZSKWjN7M2ts4qqMOMbUXlbbY07DNL11a9rTk6uzx8UiCSgveXYvDd3JcPIywQWQFMgXsj+zXx3IITBUyYa9tm71eoqLSJj9kojGrfGS52ToMQ5cIFL0xf7Ru5nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=clip-os.org; spf=pass smtp.mailfrom=clip-os.org; dkim=pass (2048-bit key) header.d=clip-os.org header.i=@clip-os.org header.b=M+CWHb2K; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=clip-os.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=clip-os.org
Received: by mail.gandi.net (Postfix) with ESMTPSA id 20E5B43421;
	Mon, 24 Feb 2025 09:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=clip-os.org; s=gm1;
	t=1740391145;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uG8YREgzOaMEIYr81Fw9Y59TiL3EgehsVEm3an6XvLc=;
	b=M+CWHb2K85uCIxnskX7Ao6BXhny6GB7A6S+TNZf9S+0+RLZxUTK4l8va3GCbH1VyWlI9PM
	Vemeql5AkUfBzqvRBmuxaHPDdDILj5j+qKIXKKCUZ38dsZscB7v0CPKouNVLNKEiDvjzDr
	OMzaZCwBeh8I6beSQ62sHh1saJ+ojS7m3tdRG7zVShp5o2WWXugxOMMduF9m+xBYPnQrLF
	SBQd1/eNZNOjEjCdk61hMz0EbO+cXKb7oea4Rb5h8X9i4GRrPQ4X3ppy4duolG9bG8ksgQ
	lyxTFQ4PkOHkw1EHUGMlRtTNytHvmZW3vRh90IBr1I10bR+RKPHZLPV+lssJdQ==
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
Subject: [PATCH v2 4/6] sysctl: Fixes scsi_logging_level bounds
Date: Mon, 24 Feb 2025 10:58:19 +0100
Message-ID: <20250224095826.16458-5-nicolas.bouchinet@clip-os.org>
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

Bound scsi_logging_level sysctl writings between SYSCTL_ZERO
and SYSCTL_INT_MAX.

The proc_handler has thus been updated to proc_dointvec_minmax.

Signed-off-by: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
---
 drivers/scsi/scsi_sysctl.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/scsi_sysctl.c b/drivers/scsi/scsi_sysctl.c
index be4aef0f4f996..055a03a83ad68 100644
--- a/drivers/scsi/scsi_sysctl.c
+++ b/drivers/scsi/scsi_sysctl.c
@@ -17,7 +17,9 @@ static const struct ctl_table scsi_table[] = {
 	  .data		= &scsi_logging_level,
 	  .maxlen	= sizeof(scsi_logging_level),
 	  .mode		= 0644,
-	  .proc_handler	= proc_dointvec },
+	  .proc_handler	= proc_dointvec_minmax,
+	  .extra1	= SYSCTL_ZERO,
+	  .extra2	= SYSCTL_INT_MAX },
 };
 
 static struct ctl_table_header *scsi_table_header;
-- 
2.48.1


