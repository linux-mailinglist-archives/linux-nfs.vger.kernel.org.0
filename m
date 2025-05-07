Return-Path: <linux-nfs+bounces-11544-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F294EAAD49B
	for <lists+linux-nfs@lfdr.de>; Wed,  7 May 2025 06:49:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E27089808D5
	for <lists+linux-nfs@lfdr.de>; Wed,  7 May 2025 04:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8344015A85E;
	Wed,  7 May 2025 04:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jkE3pcUn"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8621F956
	for <linux-nfs@vger.kernel.org>; Wed,  7 May 2025 04:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746593355; cv=none; b=MuHJ5tUjblI/G6sa8159QghooVQj9p9F8RL2Yd+AimLlt1RnqbHye5YnTwatm+Mb0Fbrh9C+85IkX1p5yRd31ypA5Lj67+tOn4W6XjYz53jKCrrrogn6CvoHSRgevhmUS0HZINtz6ce6gBAK29Q6odDNFTxE+T+id9v886q/Pw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746593355; c=relaxed/simple;
	bh=FuhIjzzn12Tjt+zJo9mV5D47TJMwfvZPJEiQmIj9a00=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Usz1edL6KaNFGqG9Kz378lS8QbNtxSQsCT9kDwFieB/1I52gdBUGufHWNoebvUrfQmqfeVYjOnECP5yD4Vkllaw/ZDyKIWNmuym3sJPnzPbk/zhIrihHF1XK2jT4VZB11p3gSFUls9+jyasWoFrg08rjLxlVuc7k6/uLQYuuzDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jkE3pcUn; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=59ALSCs5Xd9I4pC1VfM5WkHs/KUTPSbIoL7AXJAl1HU=; b=jkE3pcUnKYpReF6dPD+BADei0n
	y76FYoREuaeNYTQsI/URYYJMmY4F8z01iDG7BlN1Wbi0JPLwIncFgOMmHbq4/n6Aa8L7LCTGmPepd
	BjoaD9vo3B0XCNj4jIN2gOopE6tx0bwMVcDZBTNV/rdYJqQYARl9y7GSHl29TXv7heLgIC8nhUz/X
	F2b+IoJaM62A2MYx0DKjhpp/SHeeCLJ/oER00BkhINfxgQT6jk1to923uFIEj9OwXtU/p+Ao5b9lV
	UB3AeyR52dapdckNevQQnAgNw1Ir6n5+WV5v557JRa9DVjo5SgqpbDcaZmsHL2cTyIgAex9KGHO9P
	oQ2knP6w==;
Received: from 2a02-8389-2341-5b80-3ba7-83fe-7065-4f0b.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:3ba7:83fe:7065:4f0b] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCWiW-0000000ECX9-30c6;
	Wed, 07 May 2025 04:49:13 +0000
From: Christoph Hellwig <hch@lst.de>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: writeback cleanups v2
Date: Wed,  7 May 2025 06:48:50 +0200
Message-ID: <20250507044908.3891983-1-hch@lst.de>
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

