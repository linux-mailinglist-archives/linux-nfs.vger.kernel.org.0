Return-Path: <linux-nfs+bounces-11556-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07B32AAD9C6
	for <lists+linux-nfs@lfdr.de>; Wed,  7 May 2025 10:12:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B99D1C01CFE
	for <lists+linux-nfs@lfdr.de>; Wed,  7 May 2025 08:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 280D7222595;
	Wed,  7 May 2025 08:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sbcA9vDA"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91CA1155C83;
	Wed,  7 May 2025 08:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746605390; cv=none; b=qoDrkCz1TART+uOeBMSuNlf3spgm9kFxIwPkYZ9D4sKJOp/XtcPl+ra/i4HH05ayh4NOHcRZb12D2WrHog1u3KaUjGAYTGMAucbLNWERWNYHFySKSAAMMH9tVqz9/E0fBuMsETmabI+7bZ2ERAS+kkBSgi9FWibPk7AN39z4r5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746605390; c=relaxed/simple;
	bh=BRvB/VAG1T/D0znFWWCM/0+tgsKR5mqIW85A/0emX/M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ur0vg+wBcnbSVU0/ULa32GYCM+xS0+TUM3kCX4uPLZRQlaTEO04Juf7/rRbthgMrUEcLQy3cuAlm3WjFFuEGbjMt4Na/9Iesx6fsKhiFEY9fCoMeCVbMPRm6oboSigl1pXiaMDhfkzQzEnQ5yiPGyGydDZidj7PgQLSUSP/LgPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=sbcA9vDA; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=BRvB/VAG1T/D0znFWWCM/0+tgsKR5mqIW85A/0emX/M=; b=sbcA9vDAPlTUkrS96xKuu1iLDG
	Jt8BKSCXqx+ojJtd3i6MZMdo5YZzgnJtGHSbBdY9dSiy+oCvT8Fc+YEkWcfCKZRjsgMH71vaunyGz
	2W2ZLMaIT73j9oyZVYBNpJDL+tsRAOX7IzkNIoWRfS/hb+V6k4OTjDxF4H7PlXtlDNadniwAR1NaR
	zhmMThgb2FJ1jMS+DdYNc0gUi8a+GjiQfjRXfDnV2TlPDcb+YDr55Y6cQJxZ9hOsRLh94fH4+Gk8F
	jNsNQxoPGEo8MFV1Zw+eQz8CbfS5K1EVn6avbhGLdh7XmD9r0k8vKImocTv8ISOyUioLWX8FAPjnc
	PuAHwZfw==;
Received: from [2001:4bb8:2ae:8c08:f874:4a3:a9ae:2540] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCZqd-0000000Efif-2qZY;
	Wed, 07 May 2025 08:09:48 +0000
From: Christoph Hellwig <hch@lst.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trondmy@kernel.org>
Cc: Anna Schumaker <anna@kernel.org>,
	David Howells <dhowells@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	linux-nfs@vger.kernel.org,
	kernel-tls-handshake <kernel-tls-handshake@lists.linux.dev>,
	keyrings@vger.kernel.org
Subject: RFC: support keyrings for NFS TLS mounts
Date: Wed,  7 May 2025 10:09:39 +0200
Message-ID: <20250507080944.3947782-1-hch@lst.de>
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
tlshd.conf, but I'm going to look into a way out of that.

This is in many ways based on how NVMe handles the keyring for
TLS, and I might not fully understand what I'm doing.


