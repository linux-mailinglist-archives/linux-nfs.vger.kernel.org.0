Return-Path: <linux-nfs+bounces-11180-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C280A944D3
	for <lists+linux-nfs@lfdr.de>; Sat, 19 Apr 2025 19:28:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76225176998
	for <lists+linux-nfs@lfdr.de>; Sat, 19 Apr 2025 17:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5ADD1DEFF5;
	Sat, 19 Apr 2025 17:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dgaT/A+5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C011DED63
	for <linux-nfs@vger.kernel.org>; Sat, 19 Apr 2025 17:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745083703; cv=none; b=JjgT+prkZJFhbkst2Xa9U/vENFe5SP35KraH18Xas23V3J+rXlSSG2nz3oFXFm+pBEK3IDePI/fb2KC/ebgkfLOJQpC4oiYbGRUm+DN26EmrWI6csAbrRLp7di3kambFPhlG4OFpWQP/QUk6XvdAdo+iaitCp/xnCv6zI46RGmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745083703; c=relaxed/simple;
	bh=CxcB1iwbNS5W8iwOz9ybZZdGfHg5zpSoqMunnQ9A73o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FmBEf5p33OdvlKkkOo+lJgTmqxUrYeDOns327j9vvmjecSeWxe7Hp8TWQvXosWCEvFU/ZVNToRX3eHpZMj4D/LB2akho6YfLrg4YtA6ZW41jjzgAcjKcZXCATX7ddEQKIAikpbVTnhc0mpR58so248Y+1TI5DeoauXK9Jeekqvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dgaT/A+5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99B7FC4CEE7;
	Sat, 19 Apr 2025 17:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745083703;
	bh=CxcB1iwbNS5W8iwOz9ybZZdGfHg5zpSoqMunnQ9A73o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dgaT/A+5M/MAGYTC7Eykv8n4t9X5tKEHAZQPqHUIuTLdU2SqEo7JpbCJJX3Q3/x3j
	 47WT9rhLS4v5vlGTXKeKSbikItok4et7dTKDHMAgci8gpdp1H+eAGIE+82Sbh4akRo
	 51VC30UK/JJT8sul50pYKqj2ySaxY0ufbtA6lJmCwlcY0AdN534Fbp9dNtV8b7t/ai
	 bbAQFjvTRIcYJqlndG0+NnnmwYP6mNgWD2lhXCum7e/cvfuD4WIazNmK49jCdOGxtC
	 P7Uoa7ujZL5p5Ed4VTc/57P5qHuBhpYrRvcB3CK9CCJdY9snC9GhBzi0frJQE8N7Y5
	 Ip59e8dp/qIoQ==
From: cel@kernel.org
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 02/10] sunrpc: Add a helper to derive maxpages from sv_max_mesg
Date: Sat, 19 Apr 2025 13:28:10 -0400
Message-ID: <20250419172818.6945-3-cel@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250419172818.6945-1-cel@kernel.org>
References: <20250419172818.6945-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

This page count is to be used to allocate various arrays of pages,
bio_vecs, and kvecs, replacing the fixed RPCSVC_MAXPAGES value.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index 74658cca0f38..5b879c31d7b8 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -159,6 +159,18 @@ extern u32 svc_max_payload(const struct svc_rqst *rqstp);
 #define RPCSVC_MAXPAGES		((RPCSVC_MAXPAYLOAD+PAGE_SIZE-1)/PAGE_SIZE \
 				+ 2 + 1)
 
+/**
+ * svc_serv_maxpages - maximum pages/kvecs needed for one RPC message
+ * @serv: RPC service context
+ *
+ * Returns a count of pages or vectors that can hold the maximum
+ * size RPC message for @serv.
+ */
+static inline unsigned long svc_serv_maxpages(const struct svc_serv *serv)
+{
+	return ((serv->sv_max_mesg + PAGE_SIZE - 1) >> PAGE_SHIFT) + 2 + 1;
+}
+
 /*
  * The context of a single thread, including the request currently being
  * processed.
-- 
2.49.0


