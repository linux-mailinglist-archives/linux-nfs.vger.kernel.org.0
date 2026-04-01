Return-Path: <linux-nfs+bounces-20587-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MK9gH6szzWlwawYAu9opvQ
	(envelope-from <linux-nfs+bounces-20587-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 01 Apr 2026 17:03:07 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CCE5837CA3F
	for <lists+linux-nfs@lfdr.de>; Wed, 01 Apr 2026 17:03:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3D75131AE991
	for <lists+linux-nfs@lfdr.de>; Wed,  1 Apr 2026 14:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACE5E275AEB;
	Wed,  1 Apr 2026 14:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fCAJXm1F"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE99472794;
	Wed,  1 Apr 2026 14:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775054469; cv=none; b=FDi4E1GXOt+hUT4gfcY8ESZVlifXtY3hk+pF5HVM4sYr891qll4y6Sh4iKydUcJj2Hyh/4KeJ82z6UYvlaAZG+1ngtE+qj5CQ2OlKaNtKoyechw5PMAeo31WadDsdqJgdWjZzXjAZoXNIJlNwcfBtIfsQxTOF3z+q5Xvrf+G6OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775054469; c=relaxed/simple;
	bh=EXhKXp1GT+q2qy72zYybQPf3NgKMR5kCXb826i1v5/A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=irF0RWZmDZ+RhuZGsKs4qNYriYC2C9nOOtHWukQQ1+Aw6tFJwWoA7WxRK1Gr0e5bDIARvje51mkyvX6xCtHKaTz9VYAPrIrXbpo7erxK6Ypw4+ynrsqn/+DHoStogh8DrMOI0hAyVtsT+Va701r0yzB9SU8n7V8gWBQGWPVNQLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fCAJXm1F; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=u4SAZznvPizp8a07sCl6qiIOWjOjbAmC7+KfX5IMLfY=; b=fCAJXm1F6ahDq0bTHR0JpB4zW/
	7PglkxT25fqPb7orVCfy9u066j5GlcLJiAy/3xJDf+mYDoYW03g3e6rUrO+RlnUtFA5XIjdjyJCrY
	9FScuk62Rl3XEmeb2kkY/Jd05sf31JlQipVNJiQPCKUGqzcQ5U/8ar/92RiiXLtlIeGroDoSWzx8c
	wNuOEn+SCJoMvIBZ/pwuYWM2SA+h7hNNb6DRHcAkdt/z8umFqaBHUJmCj1A4q2uUxw1ClUNoJ54Nt
	3aZlp+5dthCmsZTvuQW0Hllb4YXOgyA4l6vQ9aYBnHfnb6m9JhrEmDakt2ciJWYnGS61LfBq9FpJN
	RJuLjzGg==;
Received: from [2a02:1210:321a:af00:3fa:89ae:5c22:a910] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7wkj-0000000FWGF-0J55;
	Wed, 01 Apr 2026 14:41:05 +0000
From: Christoph Hellwig <hch@lst.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>
Cc: NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: cleanup block-style layouts exports v2
Date: Wed,  1 Apr 2026 16:40:21 +0200
Message-ID: <20260401144059.160746-1-hch@lst.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spamd-Result: default: False [-0.06 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20587-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[oracle.com,kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[infradead.org:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: CCE5837CA3F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi all,

this series cleanups the exportfs support for block-style layouts that
provide direct block device access.  This is preparation for supporting
exportfs of more than a single device per file system.

Changes since v1:
 - consity struct exportfs_block_ops
 - fix spelling

Changes since the multi-device export series:
 - check for NULL bops in nfsd4_setup_layout_type
 - clearly document why we are ignoring loca_time_modify

Diffstat:
 MAINTAINERS                    |    2 
 fs/nfsd/blocklayout.c          |   37 +++++++----------
 fs/nfsd/export.c               |    3 -
 fs/nfsd/nfs4layouts.c          |   29 +++----------
 fs/xfs/xfs_export.c            |    4 -
 fs/xfs/xfs_pnfs.c              |   44 ++++++++++++++------
 fs/xfs/xfs_pnfs.h              |   11 ++---
 include/linux/exportfs.h       |   25 +++--------
 include/linux/exportfs_block.h |   88 +++++++++++++++++++++++++++++++++++++++++
 9 files changed, 162 insertions(+), 81 deletions(-)

