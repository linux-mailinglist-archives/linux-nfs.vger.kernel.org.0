Return-Path: <linux-nfs+bounces-20541-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8G2oDVjry2l6MgYAu9opvQ
	(envelope-from <linux-nfs+bounces-20541-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Mar 2026 17:42:16 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C052636BE97
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Mar 2026 17:42:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7E1373044595
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Mar 2026 15:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EF68421A08;
	Tue, 31 Mar 2026 15:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OmK6SIeM"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF72425CC3;
	Tue, 31 Mar 2026 15:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774971258; cv=none; b=eiAL5WLukYcT0LCkvt5uJ4244RqO5dFnVykPlN3oDZruLqWGqXKiU35OSLGymhvcr9S4ZDz1eR1sXqEkFUchhMsrizweTg4s3DgCYFcdowYeVa5/R7d29+M6LnQTFNY+4SxHFGw0uo2XVFERwPhK1D9W3ADF+DIah1/3Dq0pa/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774971258; c=relaxed/simple;
	bh=9AZtQ2D6WBBVD7MQVqmIuXHy7u2LqPFID7ZvgYraP7M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gxWwJ47+W3C2bn+qx4zxRgwL1CdpjE6oUvM1jkddDj06CzCQM4XBRU38D2yS9H0vbIvTT2LChlac0MLSriaPOB5qwJGGXcWEeWKSE5vvARVcT/ocKTw46eETDYeK00LVfeKWF3j02DglNPLplP9d4oQHtLYNa2D+yzgZhGdu/Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OmK6SIeM; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=i9lw/q3fT9bt3+jGGatqUjqfwXx3JLiHqioO9c20YTk=; b=OmK6SIeMA0rzZqBDblmrHfYV35
	rVAN5Okc31tOAmZ4oqQvC3M9Q0oBlDwSB3mAIrV2laVv1hmxFwDJNbrKMxORAJYdjqA8ZIQBk0kZ9
	7Sr/d2V1GYmW4saJI3vaFOO9R+JMjSAvrw8EsF+r3pDkJGNfcXRUMbDx58Eb/ZhbLHG/Klsxm3XVn
	8zcUOa3Go1NU1HIv6xiFnaK+GMG6ZtajGsQGVxFYtYDBxx0VoqaiGnXqe1v8ZLgjLzl3g5U7vx56E
	VBN4+EwHDsDk5ZT/Jz/27iKsOqo5Kt+etsdrfEDINP2ko+653kfRh8qSEtD8N+BSLjXuqA+fjWzHw
	TdpIP5ZQ==;
Received: from [2a02:1210:321a:af00:3fa:89ae:5c22:a910] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7b6Y-0000000DBpV-006s;
	Tue, 31 Mar 2026 15:34:10 +0000
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
Subject: cleanup block-style layouts exports
Date: Tue, 31 Mar 2026 17:33:25 +0200
Message-ID: <20260331153406.4049290-1-hch@lst.de>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20541-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[oracle.com,kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[infradead.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,lst.de:mid]
X-Rspamd-Queue-Id: C052636BE97
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi all,

this series cleanups the exportfs support for block-style layouts that
provide direct block device access.  This is preparation for supporting
exportfs of more than a single device per file system.

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

