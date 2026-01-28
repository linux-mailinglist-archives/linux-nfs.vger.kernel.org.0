Return-Path: <linux-nfs+bounces-18550-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4CqHNtOUeWmOxgEAu9opvQ
	(envelope-from <linux-nfs+bounces-18550-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Jan 2026 05:47:15 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 324359D139
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Jan 2026 05:47:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D3E813008207
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Jan 2026 04:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ECA9285C80;
	Wed, 28 Jan 2026 04:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WrMkYyzV"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00062264A8
	for <linux-nfs@vger.kernel.org>; Wed, 28 Jan 2026 04:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769575633; cv=none; b=Nsyjx6s+5aJnVa2+It35qOAY+B0/oLtHZ3TVnXa3DrpjMp6qCTP7A2GPkzTTWa0GSkfr/GMofPc2NSVTP02BDGT/hbPsa5elzXEnSVXVTCrjls8Ff5nOcKSiRQIeTW6ACm+mexR1ZnECnJ3N1yak7IFBM+7Iilt/HIieSJ8lqIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769575633; c=relaxed/simple;
	bh=caXaA6Gba7SUmGi80HSan/uNzhPlJCqoY44GOHhJYDo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ShUhe0FKV+t6iHQN7vr/UEoPUg90roz1TU2MOgyQKmjWf2G56IPT6VSB6E5TohL+pnPwF6golFwws5/MNpv1aKHNPBFr++9wOROcWlfi1Tz9boirds/uKbnA+FfBR7vH2ZoIufjYwmY7q5OePsS8A0UhZm+DGdCjxRX9X9BGBbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WrMkYyzV; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=Vzbl6z/C2ZVYMhiNd2MreZOcHcNcD1Ds9JdgehcKlZs=; b=WrMkYyzVAsSOa/6a66tXltncc4
	c6eJlcwIVe4jCcQfROJURm3H/VvmhRDsD2iJr9c1isJd+BRNiVmbKZTvS3URHY3f6z98vf56tA71v
	c7zFvrJHzsNrnHNZfjKmbskivvf+RmAY34BE93uLQfykUIqejPuRLgb7aOOAf7haPJ3ArpQj3neIh
	UIZgce0Id/gGW4zOLkKyZj7AtPQka4EMVaan9ORBm15BVZ1Ok9l/lUb6CC/iRB4vTQ0PkSutZEJPn
	d8PehzNXrdWDAnv8G5CiyGcbxUGnnMNPQZ88PxIpatdez9T5DSt9YEjUTmZGe7SQDK4Sz0BwugRm/
	Uv8Sh3WQ==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vkxSQ-0000000FRGO-0RX6;
	Wed, 28 Jan 2026 04:47:10 +0000
From: Christoph Hellwig <hch@lst.de>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: Chris Mason <clm@meta.com>,
	linux-nfs@vger.kernel.org
Subject: delayed delegation return handling fix
Date: Wed, 28 Jan 2026 05:46:02 +0100
Message-ID: <20260128044706.556046-1-hch@lst.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18550-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:dkim,lst.de:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 324359D139
X-Rspamd-Action: no action

Hi all,

Chris Mason reported issues with the handling of delayed delegation
returns in the resent "add a LRU for delegations" series.

This series fixes that by not only doing the proper unlock, but also
by adding a new list dedicated to the delayed returned delegations.

Note that I could not trigger the delayed delegation handling naturally
and had to add crude error injection to force it.

Diffstat:
 fs/nfs/client.c           |    1 
 fs/nfs/delegation.c       |   94 ++++++++++++++++++----------------------------
 fs/nfs/delegation.h       |    5 --
 fs/nfs/nfs3proc.c         |    3 -
 fs/nfs/nfs4trace.h        |    3 -
 fs/nfs/proc.c             |    3 -
 include/linux/nfs_fs_sb.h |    2 
 include/linux/nfs_xdr.h   |    2 
 8 files changed, 45 insertions(+), 68 deletions(-)

