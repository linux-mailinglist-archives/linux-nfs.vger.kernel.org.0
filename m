Return-Path: <linux-nfs+bounces-18913-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YFCtH+q7jmkWEQEAu9opvQ
	(envelope-from <linux-nfs+bounces-18913-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Feb 2026 06:51:38 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 684F213312F
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Feb 2026 06:51:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 324253029F6D
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Feb 2026 05:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E76E2701CF;
	Fri, 13 Feb 2026 05:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="NucdvvTX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0130926CE2B
	for <linux-nfs@vger.kernel.org>; Fri, 13 Feb 2026 05:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770961892; cv=none; b=DtUF+0MdJTsYq4VGtDQNCbGUsmMMy0Qit25SsX+fTb61aweLOJ6uh6U7bDFaJTvEkUtGBxbLLrU2HlZ6/3HQidGL+Sqo4stEoF0UUEwjtrIy8a3SFeC5Wmwm3+ANG4RiS2i2cGDK5ukcOxCfUSeXmy7H39eywkmfaC1QiBrTVvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770961892; c=relaxed/simple;
	bh=Z/yQn8DzSvsjQsxW3X/WSGnYwmjkz9b/zpQanQyUDoI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=HLh9qTmbjb8kq2Xp3D4Uuj/JeSwYy8BrwrgAPolrs/CUPUy2S6b2psP2FUBl0XC/Th1kT2slevRKHAIkjLk7j79lb4JQqQJIU/hE09By9Mj9m67pzLS3iCsXtGEP+FPIAZh4mPfk4VOPxnDhI/7X15KF/tHGDRk2TXUbvxi+rTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=NucdvvTX; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20260213055126epoutp0358d6d382143d668ebeb68e62da3ad682~TuHQFyuE80722607226epoutp03k
	for <linux-nfs@vger.kernel.org>; Fri, 13 Feb 2026 05:51:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20260213055126epoutp0358d6d382143d668ebeb68e62da3ad682~TuHQFyuE80722607226epoutp03k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1770961886;
	bh=02DDEaQljJH+1NIoCRiXwA4Cox05Tk7oMWaIvNrazSM=;
	h=From:To:Cc:Subject:Date:References:From;
	b=NucdvvTXujmEfYfriSe+LqqnwNbnMqP+LoZiobsIbMhGPR8CzisJjGUk74J8wHOlr
	 78n39vIpmh6qEKn10F7msTFMQ9WC2XOhL3Kz0Ixg7UN3A3umCiyoir+0Mp1zo+SRs9
	 nhmMFMcalYQJZboHssKoO/ChnE423Dbf7PkjDtO0=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
	20260213055126epcas5p24356d9d29f340cec40f8474b60ab888e~TuHPkBxBP2327423274epcas5p2w;
	Fri, 13 Feb 2026 05:51:26 +0000 (GMT)
Received: from epcas5p1.samsung.com (unknown [182.195.38.95]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4fC1WJ4TXQz2SSKX; Fri, 13 Feb
	2026 05:51:24 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20260213055123epcas5p25f52d5961c04b1a1f514827a494a0773~TuHNHL6z22327923279epcas5p2j;
	Fri, 13 Feb 2026 05:51:23 +0000 (GMT)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260213055119epsmtip27175adf3780b7d24b46fc8ee007de103~TuHJE0T9c2557525575epsmtip2h;
	Fri, 13 Feb 2026 05:51:19 +0000 (GMT)
From: Kundan Kumar <kundan.kumar@samsung.com>
To: jaegeuk@kernel.org, chao@kernel.org, agruenba@redhat.com,
	trondmy@kernel.org, anna@kernel.org, hch@lst.de, brauner@kernel.org,
	jack@suse.cz, viro@zeniv.linux.org.uk, djwong@kernel.org, jlayton@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	gfs2@lists.linux.dev, linux-nfs@vger.kernel.org, gost.dev@samsung.com,
	anuj20.g@samsung.com, vishak.g@samsung.com, joshi.k@samsung.com, Kundan
	Kumar <kundan.kumar@samsung.com>
Subject: [PATCH v2 0/4] Avoid filesystem references to writeback internals
Date: Fri, 13 Feb 2026 11:16:30 +0530
Message-Id: <20260213054634.79785-1-kundan.kumar@samsung.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260213055123epcas5p25f52d5961c04b1a1f514827a494a0773
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260213055123epcas5p25f52d5961c04b1a1f514827a494a0773
References: <CGME20260213055123epcas5p25f52d5961c04b1a1f514827a494a0773@epcas5p2.samsung.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[samsung.com,none];
	R_DKIM_ALLOW(-0.20)[samsung.com:s=mail20170921];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	TAGGED_FROM(0.00)[bounces-18913-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,samsung.com:mid,samsung.com:dkim];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kundan.kumar@samsung.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[samsung.com:+];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 684F213312F
X-Rspamd-Action: no action

The series introduces writeback helper APIs and converts f2fs, gfs2
and nfs to stop accessing writeback internals directly.

As suggested by Christoph [1], filesystem code that directly accesses
writeback internals is split out:
[1] https://lore.kernel.org/all/20251015072912.GA11294@lst.de/

No functional changes intended.

Changes since v1:
1) Added comment indicating that these functions shall not be used by
   filesystems that support cgroup writeback. (Christoph)
2) Pass inode instead of bdi for modifying writeback accounting stats,
   will make it easier to select proper wb context for the upcoming
   parallel writeback patches. (hence dropped the previous reviewed-bys
   for patch 4)

Kundan Kumar (4):
  writeback: prep helpers for dirty-limit and writeback accounting
  f2fs: stop using writeback internals for dirty_exceeded checks
  gfs2: stop using writeback internals for dirty_exceeded check
  nfs: stop using writeback internals for WB_WRITEBACK accounting

 fs/f2fs/node.c              |  4 ++--
 fs/f2fs/segment.h           |  2 +-
 fs/gfs2/super.c             |  2 +-
 fs/nfs/internal.h           |  2 +-
 fs/nfs/write.c              |  3 +--
 include/linux/backing-dev.h | 13 +++++++++++++
 6 files changed, 19 insertions(+), 7 deletions(-)


base-commit: 05f7e89ab9731565d8a62e3b5d1ec206485eeb0b
-- 
2.25.1


