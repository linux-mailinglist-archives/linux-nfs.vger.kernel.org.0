Return-Path: <linux-nfs+bounces-11943-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5693CAC69BB
	for <lists+linux-nfs@lfdr.de>; Wed, 28 May 2025 14:50:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 260D6176DCA
	for <lists+linux-nfs@lfdr.de>; Wed, 28 May 2025 12:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9BA1284696;
	Wed, 28 May 2025 12:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eK+Bn/wL"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89EF12459EA
	for <linux-nfs@vger.kernel.org>; Wed, 28 May 2025 12:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748436609; cv=none; b=BT9iAEA0PkAM2JoHUJCtjnHplqTX38TLPZ1WFPs0IW1/3UtrtWAHwmc61NXX+bHNsV2KfmjGUkLk5wFTqckWCkrgNkenhO5PN6xybrUEI/sbnB7Df7cPI8BtyQgh098E/cohf1h3P4GTt/xDbl7ALHVIAvQH/rsQDuISeyXnF7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748436609; c=relaxed/simple;
	bh=8RohFwYf1UQa6fPIjjmoFhR2aEu03DGXz7tXutF+Owk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bPmBhNFPz0ntIijdiBAgNeB4lO0kqu0g8gkPU/nMDsuLerZcJPVIcxiGQrZc1B6MwZWMYc9hpkL55aWAC/zuIupRAwgRO4S5Hwif60Ymddr0bn+5KNWWE1MtEy0oHvLbk6wmqbU4hFn33i/Lizl0eJeky2XuvTNsJwdFUY45f8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eK+Bn/wL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748436606;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KMbME3SLpF3A5W8PUoEQOii2HMBD/KsNeoWFs7+pnFA=;
	b=eK+Bn/wLcJAg9kFnyIMNNfrwg7kuERiS4Z1HmjdCBkZsQSGj49u8BGOVv0ydbMOMQvzdOK
	T6Hk+UWlSE2OC4/4KnWEcETRvDspJAgo+TY/6ZGnuOnvVgczdI0oEO7M5IKcPur1Shvn8w
	W+r7XMoZwPB3mM9iDmEONToc7Di1Fnk=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-441-lCtvatqxPSGhkhVVSPFexA-1; Wed,
 28 May 2025 08:50:04 -0400
X-MC-Unique: lCtvatqxPSGhkhVVSPFexA-1
X-Mimecast-MFC-AGG-ID: lCtvatqxPSGhkhVVSPFexA_1748436603
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A3D5E19560B1;
	Wed, 28 May 2025 12:50:03 +0000 (UTC)
Received: from bcodding.csb.redhat.com (unknown [10.22.58.2])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 527FC1956095;
	Wed, 28 May 2025 12:50:02 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Lance Shelton <lance.shelton@hammerspace.com>,
	Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v2 0/3] NFS Client btime support
Date: Wed, 28 May 2025 08:49:58 -0400
Message-ID: <cover.1748436487.git.bcodding@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

We're getting requests to allow the client to support btime, current kNFSD
already supports this for compatible filesystems.

I've rebased and worked the first three patches from
https://lore.kernel.org/linux-nfs/20211227190504.309612-1-trondmy@kernel.org/
onto v6.14, and I've been driving them around bakeathon without any signs
of trouble yet this week.

Thanks Trond and Anne for this (years-ago) work.

v2 - fix unnecessary cast to printk

Anne Marie Merritt (1):
  nfs: Add timecreate to nfs inode

Trond Myklebust (2):
  Expand the type of nfs_fattr->valid
  NFS: Return the file btime in the statx results when appropriate

 fs/nfs/inode.c            | 45 ++++++++++++++++++++++++-------
 fs/nfs/nfs4proc.c         | 14 +++++++++-
 fs/nfs/nfs4trace.h        |  3 ++-
 fs/nfs/nfs4xdr.c          | 24 +++++++++++++++++
 fs/nfs/nfstrace.h         |  3 ++-
 include/linux/nfs_fs.h    |  7 +++++
 include/linux/nfs_fs_sb.h |  2 +-
 include/linux/nfs_xdr.h   | 57 ++++++++++++++++++++-------------------
 8 files changed, 115 insertions(+), 40 deletions(-)

-- 
2.47.0


