Return-Path: <linux-nfs+bounces-15511-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1809BFBB79
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Oct 2025 13:47:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56623188BDD7
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Oct 2025 11:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99CC633F8A8;
	Wed, 22 Oct 2025 11:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Vjm3KRNM"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB46C33FE12
	for <linux-nfs@vger.kernel.org>; Wed, 22 Oct 2025 11:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761133541; cv=none; b=UkOb7G6cDwxkcKoIcrtmdE7gf4hhVo+NPi23Vs84rA7ONkrkufZSj7VLZCs8oG7zvG1s6JgkJttvdUZqJmeMLvcEQGyGNMjH+p7cVNfqFT+lttFCS/+Gk+Xhntd4z2Eio1v62t4o8sNretoI7moRzJxE1RTeAyyzhx9jIREhSRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761133541; c=relaxed/simple;
	bh=S2SQLHAqp/sgTU1GZcAE2nK/AhJfH4x2MwWwGlybYdU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=g5RDiGmgMLomR0t1bwPVbMw05sEnRE8Q69FIrfTQGoPwrxZose943qYIkZaRZJXXDNSiURF837OVyLDWPYHH042jX9F6LJqe+z2YqFBPMlIimUuSAeWLMcnbNRFrFdJOSjvOrICO1KTJRcZ4o6biRqBIZ/wW9yCDogNjukaoJA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Vjm3KRNM; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=IaAWUfx20fb+tAquMTFt/lZZK1mC/oSL8J+Oqs1asoo=; b=Vjm3KRNMzdmcUaPk4cPlUm1iMR
	6DYaQpWVOP7akWPZk7yupXlkMFkWev3KGnF04O02d4NXAYrRFefjsX5uUctGo/UK3LR0jnm6DbEBw
	YdJpTvxH5XzRr5KyRK2WLqHeSRSyOoeE4ss3owL7+MQ4VlqD2TwC/0cQmUxJTPb1tSrzhjjbL0tPR
	KdzeF5xcW+JeujGEmxHn5pjEuWPT7mVRZsamUFnO3+C6+OEUdbY9ymKVobI/YoD6JGcKPQLOkzIx0
	k1zfk/JwIn5f4egZs8J+7zrtNyQTy25LGNsjizPXB+5aoAMgGYZxumeFLt732dTutwLs/vu8iRyAz
	ln0c5ASw==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBXHd-00000002hxF-1qgb;
	Wed, 22 Oct 2025 11:45:37 +0000
From: Christoph Hellwig <hch@lst.de>
To: chuck.lever@oracle.com,
	jlayton@kernel.org
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH] MAINTAINERS: add a nfsd blocklayout reviewer
Date: Wed, 22 Oct 2025 13:45:30 +0200
Message-ID: <20251022114533.2181580-1-hch@lst.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Add a minimal entry for the block layout driver to make sure Christoph
who wrote the code gets Cced on all patches.  The actual maintenance
stays with the nfsd maintainer team.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 MAINTAINERS | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f2bc6c6a214e..1dbdf64bc362 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13586,6 +13586,10 @@ F:	include/uapi/linux/sunrpc/
 F:	net/sunrpc/
 F:	tools/net/sunrpc/
 
+KERNEL NFSD BLOCK and SCSI LAYOUT DRIVER
+R:	Christoph Hellwig <hch@lst.de>
+F:	fs/nfsd/blocklayout*
+
 KERNEL PACMAN PACKAGING (in addition to generic KERNEL BUILD)
 M:	Thomas Weißschuh <linux@weissschuh.net>
 R:	Christian Heusel <christian@heusel.eu>
-- 
2.47.3


