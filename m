Return-Path: <linux-nfs+bounces-11504-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0CE4AAC776
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 16:08:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E154B4A1FA6
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 14:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBB7C281343;
	Tue,  6 May 2025 14:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XLTUaTZr"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49BC3278745
	for <linux-nfs@vger.kernel.org>; Tue,  6 May 2025 14:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746540501; cv=none; b=h3HcDGmoNIW8uC+9sCHLVPIv/MQGKGZrws+f0ezNtjiMuKn5Zp4Tf2ktrKHDuJDkcb97PyTE367vLi+BvzNydrMYquPKtUPU+EKBQ08H0SveRnxrTxyzO/arnLZGhv8S0EnK1b+FpGLT0r0xnn0NSZDYE1EwmPLkmIxHUN/e+LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746540501; c=relaxed/simple;
	bh=8dbFMyXjusDJBwJo5CQ2X3v2m+hUT05WefJxUWggZgU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B1LbOetnSVsP4lYX1YwKVrmju3QFCzY8/Idd6Q0llDlcnPwC3wy3NCXzaDbCo2I/TFOlYjBiNFfu2WzejqhQ+d6aD1GFXH7i7GelIy3FChGXWFu5U361fDrQv/zbkDBo/CvsQZRkp50nMdjQotPPpwWqc+deSIungZaqWtZ/ju8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XLTUaTZr; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=tpJbyb9nLR5f1oPeHyjvkIZEOn/soC/95tBLnoSrMoY=; b=XLTUaTZrCONZiid/9zO9f+SCQF
	I8reBG5v/xaSRRZ5Qpb7/+o2o4u1pUyIPy3OMyGqLXlHNuVY2f9GO0eFkrMQAQzMjLaWSHovcVbhe
	pNpQ7GjbYt0aDrA3T1QBLAmsLLY+gstjdgzraY2jXjWxO6OVbufbsgLCrYi1HiQ2TofJ9lORxTtsX
	5C5aOeZ1XBSP/kQ2eUSfPL+FQGvGUgwBVi3HGxY8h3pznFriqrtIZVml1f608RTBvliwmUN5By5nl
	dTWnSGbZg19K6jBgsEV14InFoi5NXZv4GjUE3iX5oQDCdjmhohi98HqLWrseQwpXPfLe3IgUd7tPz
	xs0Vyinw==;
Received: from 2a02-8389-2341-5b80-3871-beb2-232f-7711.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:3871:beb2:232f:7711] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCIy3-0000000CG43-1lPv;
	Tue, 06 May 2025 14:08:19 +0000
From: Christoph Hellwig <hch@lst.de>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: writeback cleanups
Date: Tue,  6 May 2025 16:07:46 +0200
Message-ID: <20250506140815.3761765-1-hch@lst.de>
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

Diffstat:
 write.c |   54 +++++++++++++++++++-----------------------------------
 1 file changed, 19 insertions(+), 35 deletions(-)

