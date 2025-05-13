Return-Path: <linux-nfs+bounces-11672-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6052BAB4EAE
	for <lists+linux-nfs@lfdr.de>; Tue, 13 May 2025 10:58:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EAD4863344
	for <lists+linux-nfs@lfdr.de>; Tue, 13 May 2025 08:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A09DB20E318;
	Tue, 13 May 2025 08:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nzpA5t7l"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67D11EB19F
	for <linux-nfs@vger.kernel.org>; Tue, 13 May 2025 08:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747126667; cv=none; b=sNbT42qjRW9F0xUFYpdWhJsmbFFd7QiqsgJMdEu6UJu+x4ZDV2aJiH6FhVllqVT+Iby6CKdmmZEWbK7kf5fQSs1x+oILo6nULxsDAFoked54rTGDdrpyAFJo6koAmS4d+xJ3alBWttOB//yMeDwmwMhNlg2JQPWjBxtc46sP8P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747126667; c=relaxed/simple;
	bh=ILTAmSj+DnTF9OBGetVQ/stAf8FgJAWYY1D3qqZECDY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RnEhHu3Mm1WiPjEGoZdKQ7HQPGk4MgO/EEMc3BqqJKinOZj5CUFSPsuPNelc/cQJ+enlCvkTzFAtCO4w2gxMnWoPyGsSwlJOeKzS1KcK9W2ey9mFH3HrUMw4Iukn31DRxbyevllbwHcMf8N39tJkJmtiBKIiExauM/YszGVrgSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=nzpA5t7l; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=VSuTP49ejCixYT0hhJ1JhZuSLuSpZ98diAJI9rDeL98=; b=nzpA5t7lrDlBm7SgmjpCt7W6m2
	9mivm0tQEOr6bQ4J3/fLp7+u/N0C/+t5NTQh1hwMfYZd/w9b6TcaJOx+js0ceCSL/80FEkBt4ifxC
	LNBAS63cTSNe+gtBilVX5aBYH3798zj+WG1aDlPME/7usoVp/qlaZKpLQdTzy8qGvT6jxDBeISQMP
	BUkJE31KwRoM0uGa5BHs8xIYHZJykzD1hSXyvnZ5BSFyLiRwRxWrsLQqSB3iLTAG4fg+uMphPFr+S
	NBr8Wsczgy5Ul+B5ik80LGkhDOVr1ldQOO4s93YyGNV+iHy5T6UO7LYgPfP2AT3KfBHdchpIqfTHP
	quEoJTpA==;
Received: from 2a02-8389-2341-5b80-3c00-8f88-6e38-56f1.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:3c00:8f88:6e38:56f1] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uElSI-0000000BpAQ-3pOv;
	Tue, 13 May 2025 08:57:43 +0000
From: Christoph Hellwig <hch@lst.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: small sunrpc cleanups
Date: Tue, 13 May 2025 10:57:23 +0200
Message-ID: <20250513085739.894150-1-hch@lst.de>
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

just a few small cleanups done while looking at the code.

Diffstat:
 fs/nfsd/nfs3proc.c         |    2 
 fs/nfsd/nfsproc.c          |    2 
 include/linux/sunrpc/xdr.h |    3 
 net/sunrpc/socklib.c       |  144 +++++++++++++++------------------------------
 net/sunrpc/xdr.c           |   11 +--
 5 files changed, 57 insertions(+), 105 deletions(-)

