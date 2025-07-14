Return-Path: <linux-nfs+bounces-13027-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA691B03714
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Jul 2025 08:31:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BC443A3453
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Jul 2025 06:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB3902CCDB;
	Mon, 14 Jul 2025 06:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="S7DDhTAW"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10AF4BE4A
	for <linux-nfs@vger.kernel.org>; Mon, 14 Jul 2025 06:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752474657; cv=none; b=RZ8A9E2eM6iwVEKG0clwIeQbinKZ6FQK+JWKTUzIdZlCWRVOMHTfsDdhAPTyOklxRRB2Mic/Ek2sstyGDF3bmPK0F51KLb6ivUMYVqrpG993bRboCc1LYO5YD+I47NCs06abRnPXdgodO5kuf8CX98w2L1q/QZeYiTkcXWQJpu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752474657; c=relaxed/simple;
	bh=MPhp/eTHfSB6ij6mitCVApkDp+S1sr7pzyTOnQJiHIs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pwutQ2JNnJVbkyTp+vw+4i/XtfSY26BGfw0iZh4TsDhfVsZaJqZmcMeiecbVhV/Y5HgcEKXYgNK9PgrjT9Uayw63L2DHhUzFi4ETDtruyXtnxVgeOi4YgRCoeCi55tkNjf56srFlCf64tgQIEEX07mqUT6k4hKjBCChXKLQUzhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=S7DDhTAW; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=kbQB2AuPkoG4svUZkpO0bfWZSYm6VVJAv96Qt3z7u00=; b=S7DDhTAW6rH5KNTzNIg+nGB4DY
	/4kPdqyRcGLJPwZW2jaXDVYuVFyjzNK6gOleDqmCRtD+wGy5vXT8vfmUb2Qeaab673zA5ToJin5C0
	EbwJrx0p18S7YWoupYgGG498bJRVdtAq0CsFDnhmHkuyqhMIBURSyyDlob9V2/2GmPZMZGnfXGamj
	TuGsllFrJ6MMd8wu1dlcXV3GceJSn4RvTg0GaR1ezGP25b9JQ3q8UDXmWsJV36OpU2AwevunnuZf2
	ge08aiWCfDwbHkmul29vhl5OqSxL7Kjg2PfCzQYmt9IxYWqrcNGjURB407AdHrPFlRmvkxec9R4Z9
	UKfFLGkQ==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubCiF-00000001Lyd-1SgS;
	Mon, 14 Jul 2025 06:30:55 +0000
From: Christoph Hellwig <hch@lst.de>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: add a clientid mount option
Date: Mon, 14 Jul 2025 08:30:44 +0200
Message-ID: <20250714063053.1487761-1-hch@lst.de>
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

this series adds a new clientid mount option that allows to use a
non-default clientid on a per-mount basis to make it easy to test
client-based behavior on a single client system.

Diffstat:
 fs/nfs/client.c           |   12 +++
 fs/nfs/fs_context.c       |   12 +++
 fs/nfs/internal.h         |    2 
 fs/nfs/nfs4client.c       |  152 ++++++++++++++++++++--------------------------
 fs/nfs/nfs4proc.c         |    7 +-
 include/linux/nfs_fs_sb.h |    1 
 6 files changed, 102 insertions(+), 84 deletions(-)

