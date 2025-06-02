Return-Path: <linux-nfs+bounces-12055-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC522ACB374
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Jun 2025 16:42:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A964A4A4E8D
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Jun 2025 14:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2891D227EBB;
	Mon,  2 Jun 2025 14:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="3e5MwHFM"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004C12288F4
	for <linux-nfs@vger.kernel.org>; Mon,  2 Jun 2025 14:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748874325; cv=none; b=KarTesGauFzIzgzOKwGlwSfgHV3ZoTF+HXDzUiauTPnI/Q3Fv2pvAiXbHLXOsHjLjjtMRh9VYCWO/fYgaj4jY/m7qYP0yqjgd/GLJslUIEUgNAg85DCEAHoVG5g9t8pP4Zi5bS7vIT9Yv67bIww95NlVJSppPrq20eAGm5GGZk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748874325; c=relaxed/simple;
	bh=FuhIjzzn12Tjt+zJo9mV5D47TJMwfvZPJEiQmIj9a00=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qEk8FLNYAFpYUqBoOaQ+l6+fdChbNQRaw/0Rv8nVP0J0SsfhEGgYHWalraZI6d3YSDaWxXBHvLCTy8xbUpwNgk2bRHAXzXxH6lsLk8Zum0ds+aHT0orAvp3Xo9YZUOdd+MvSDu8DUrT7cQk6ulRv35MaTzUKS/BgxjqRH4WTzIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=3e5MwHFM; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=59ALSCs5Xd9I4pC1VfM5WkHs/KUTPSbIoL7AXJAl1HU=; b=3e5MwHFMi/FTWt/aWjW7zjeN5x
	TOe071qnBr/PUUCUop7ncgq9rZtX05brtTXr6SjlC52CBL1lG2DfE7ATo1AZoh90qSLMi5zf7yl4F
	J0mXm81zpl+DWunrghBD4C/xO+li0rO36RBopxUxixdhGLjntERa3iiSrXTgd9GAwCQnwm3qX2Ak7
	FaKq42RjIOlaOTPi2ob17qkF2cjc7PzzueihjZLl8se+a838r9V4pQiuRinaDmsFzloF3+blE9+7S
	sNZDzNvECLIFbRgpUqaRekfPofCF8b/Z37zyspo9HP1nCZwGb/NG0unYpykAqHnEO4nIWoTuKMHP3
	gAlpp4ew==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uM66K-00000007ctJ-3cib;
	Mon, 02 Jun 2025 14:25:21 +0000
From: Christoph Hellwig <hch@lst.de>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: writeback cleanups v2 (resend)
Date: Mon,  2 Jun 2025 16:24:48 +0200
Message-ID: <20250602142517.408443-1-hch@lst.de>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Hi all,

this series has a bunch of cosmetic cleanups for the NFS folio writeback
code.

Changes since v1:
 - don't mess up code placement in one patch only to fix it up later

Diffstat:
 write.c |   54 +++++++++++++++++++-----------------------------------
 1 file changed, 19 insertions(+), 35 deletions(-)

