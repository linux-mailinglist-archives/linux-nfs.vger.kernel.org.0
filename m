Return-Path: <linux-nfs+bounces-11738-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABD57AB8552
	for <lists+linux-nfs@lfdr.de>; Thu, 15 May 2025 13:52:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D6D73A78F4
	for <lists+linux-nfs@lfdr.de>; Thu, 15 May 2025 11:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BAD3298CB8;
	Thu, 15 May 2025 11:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XqhcJ7Xz"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0738929899E;
	Thu, 15 May 2025 11:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747309873; cv=none; b=EMG7Ix6j4dNRsYI9/xPnkWVU2o1rMUUsCzOrudjNslwTlZcqL9uGps7XLgw5DSEt4wcUPz5BzAgsH8QQ9r1bGipMDCdlyj43Wqvy/CqrgysTjb9twSjNbKCeMnU4xJs4JTKHQfYTrzOJbO1ALLlHA9zWAfLsAgynH05/jrLXCto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747309873; c=relaxed/simple;
	bh=ZQRUfxI7TgUOjkdJykkXZZT0pwskprr7yYlXq4QFCQg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SpO2W1rM8hCxig+AeVRaKfNXSLz5rfccurgqZSIS/rQ8/yFQXFcsnW7ERueneWCbCT1Difr0W6JrEl7vNoAJuAkx00hh1AQA0DwB/1LaokDhdcAv9TocNoctmubo9ojCeEOJMARQwDbsaCMRO5XTYn2JlWnrx8CErMS/Ap55cO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XqhcJ7Xz; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=ZQRUfxI7TgUOjkdJykkXZZT0pwskprr7yYlXq4QFCQg=; b=XqhcJ7Xz0KPLqUVOI1N4gxokpH
	nauTxFY5RT4CTI28/aAbRcf998YDCn9u7uaMXK7pGUyCeoYV1DgLG2ptQwMBEiJGZsWxRV+YNVIQ/
	O/Yl+Nhng/F6bx/aY68hgCQDiVBUWqQ07OQEnZ6fAgzX60l+FRxccnu+2CkzV4fmplp5rLLWgc/Ol
	dM6P5Zo+v/1Ey2S9og5as6vlD5FbB6rm2r/2jS2B2MyoOUBeDEjRG8m+PMGyEe/yC4/JvoanhDRVT
	ZJF9ip6KY+pox+67e7y20Jg9degcM817dKCWS3dSEI29MEMOeqOlByY60AFJhaTQtlLtP7TqeIUt8
	Inp7UmmQ==;
Received: from 2a02-8389-2341-5b80-81b5-a24e-41ab-85a6.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:81b5:a24e:41ab:85a6] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uFX7H-00000000SaN-01Ef;
	Thu, 15 May 2025 11:51:11 +0000
From: Christoph Hellwig <hch@lst.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trondmy@kernel.org>
Cc: Anna Schumaker <anna@kernel.org>,
	David Howells <dhowells@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	linux-nfs@vger.kernel.org,
	kernel-tls-handshake <kernel-tls-handshake@lists.linux.dev>,
	keyrings@vger.kernel.org
Subject: support keyrings for NFS TLS mounts v2
Date: Thu, 15 May 2025 13:50:54 +0200
Message-ID: <20250515115107.33052-1-hch@lst.de>
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

this series allows storing the key and certificate for NFS over
TLS mounts in the keyring and be specified using a mount option.
This way they don't need to be hardcoded in the global tlshd.conf
configuration file and can even be different per-mount.

Note that for now the .nfs keyring still needs to be added to
tlshd.conf, but that should go away with the handshake enhacement
from Hannes.

Changes since v1:
 - don't depend on nfsv4 for the keyring
 - fix compile when the kernel keyring is disabled

