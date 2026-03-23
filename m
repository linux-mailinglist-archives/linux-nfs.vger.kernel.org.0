Return-Path: <linux-nfs+bounces-20318-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4MTBLzXnwGl6OQQAu9opvQ
	(envelope-from <linux-nfs+bounces-20318-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Mar 2026 08:09:41 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 322082ED4E3
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Mar 2026 08:09:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 310E63007CB9
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Mar 2026 07:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55BAD35C19B;
	Mon, 23 Mar 2026 07:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="b67nSWLy"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4409F3164B4;
	Mon, 23 Mar 2026 07:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774249676; cv=none; b=erwydNDFu4GsvM/WG57SaOVCa+p41e79nVf2dYv61LXt/Ap4wGHUYoWg3w+tDkeXfJO07oFHGFkM81VPzzsc726OhuZZNqTJ9qfE+d5ItNKrhL0jEhGKiPsub2IJAMhrD27jN3EZKkEMuMToLc9jpnpa5OUo6r/QDwHTEtt86nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774249676; c=relaxed/simple;
	bh=n6/esmbLLYnCWbjYRY2cIW6J4XQPij2omFb4qzktfWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KEpqNxBh6TPKGo5qYtprDQti0eijhDjO+uwiX1L1WZAlleLea8wVV3XGDoRSXJnhkhEUNp6JT5l/+d5u4D/Q9lYzzHo/g2mjzIHvUtP6UDcjOlh8i4BCZnTWLRTvZyC1R5mfxvkAa7bLhQdvjV9fG0Zkzdkdj0gozpx9AN/xvAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=b67nSWLy; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=Y0BBALfCpyrhzBLB2pqit20jC5qy1ednoG0tRG1R0MY=; b=b67nSWLyTDSIQ73f4+8uBq7SuB
	6bEJerb77b+DYbyOm4ggaWzIa7yNneh2m+bRQFK5AxJ/ssCniQErdXYCbHlMRZ/oBz64bJH6Ydba9
	RQgNA7unYfXNE3onFuaULerHooctTIlpWrKeNnIiilUmexblJm0u5TWkQf/CnQdTjjFd75wsw1NBG
	cD7A8gnytQDY7NOnrmWrt2NHzts0L0GQNPhm2NemP4cbfIwwjNoxMz9a7m2ou1gRdQHvUOva10sMW
	QQ+2nSHmN3uKHgRM065u0H50OYeXRPTgjxzA9vhhcMsaR3MYdXkW+N3NohS4xBH9E5k7eIKs/rW+P
	fcWNiD/w==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4ZOB-0000000GALn-4AZb;
	Mon, 23 Mar 2026 07:07:52 +0000
From: Christoph Hellwig <hch@lst.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>
Cc: NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Carlos Maiolino <cem@kernel.org>,
	linux-nfs@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: support multiple block devices per file system for block-style layouts
Date: Mon, 23 Mar 2026 08:07:16 +0100
Message-ID: <20260323070746.2940140-1-hch@lst.de>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20318-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[oracle.com,kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[infradead.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lst.de:mid]
X-Rspamd-Queue-Id: 322082ED4E3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi all,

this series adds support for exporting multiple block devices using
block-style from nfsd, and uses that to implement support for the XFS
RT device.  To get there is also first cleans up the block-style layout
interface in exportfs.

Diffstat:
 MAINTAINERS                    |    2 
 fs/nfsd/blocklayout.c          |   69 ++++++++++++++++--------------
 fs/nfsd/export.c               |    3 -
 fs/nfsd/flexfilelayout.c       |    3 -
 fs/nfsd/nfs4layouts.c          |   32 ++++---------
 fs/nfsd/pnfs.h                 |    2 
 fs/nfsd/xdr4.h                 |    5 +-
 fs/xfs/xfs_export.c            |    4 -
 fs/xfs/xfs_pnfs.c              |   93 +++++++++++++++++++++++++++++++---------
 fs/xfs/xfs_pnfs.h              |   11 ++--
 include/linux/exportfs.h       |   25 +++-------
 include/linux/exportfs_block.h |   94 +++++++++++++++++++++++++++++++++++++++++
 12 files changed, 235 insertions(+), 108 deletions(-)

