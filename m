Return-Path: <linux-nfs+bounces-11746-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A79CAB899A
	for <lists+linux-nfs@lfdr.de>; Thu, 15 May 2025 16:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0DF517B7040
	for <lists+linux-nfs@lfdr.de>; Thu, 15 May 2025 14:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C97061E3775;
	Thu, 15 May 2025 14:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U3kxeA4l"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9ECE7260C
	for <linux-nfs@vger.kernel.org>; Thu, 15 May 2025 14:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747320028; cv=none; b=M2/ZgaG0JTjOwMdimN4ZUxZxyiBA7sYBHCp9eD/4NK6Ey1/MS+S9pO3ouTuJxSn/yv07vU3IExnD5oHlbxRWE8iwKlXEzN9xubFi7JlbQp40NV372POApWfL+PTL81+J+npT7mLWJM+JrJtDh/UM/iHsmq47IRvgOqsiKNf01Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747320028; c=relaxed/simple;
	bh=tkZPBr/rQV4HsIuoY6lN6+WWipPD0m5BLFuaZry6Mcc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Qumx8D27rju0wl87lWvKJc/Yf8y/Zdmlkhh89S744+N4QIX8iPI8c7kIQMHvQgqnopozxGw1PlMQaEI6Lm83B30MyJMRxd9rp4lNDNBoPiAQn8ttt/JVvoE/R/yU/V7KP6GdbMsIZGjojSKhDMzNfYRXAWNifzVHd3NtLW4hbM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U3kxeA4l; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747320025;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=h09iUcdkMVbyULTGogEeqjgQQX9Lwd8UXRk8Bw4Ez/c=;
	b=U3kxeA4lgi5Nn1FROlWFWksxy3ER+CNbGBEcxIHS/VocS5aojBdZDgdmTHMp/P3UZKzg15
	WpwsaGN74Akt2ZMc14gdW2Wi+yLLiRruo0kXu9pXxvj2EYMDJCusHgmOU8IgoF0V1haQ5Z
	OI4KfZsLkUHtNwXEKG/UHYl/YRY8tWM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-445-mWplpjrfPrqoDV10mEHT0Q-1; Thu,
 15 May 2025 10:40:22 -0400
X-MC-Unique: mWplpjrfPrqoDV10mEHT0Q-1
X-Mimecast-MFC-AGG-ID: mWplpjrfPrqoDV10mEHT0Q_1747320021
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4FDAA180036E;
	Thu, 15 May 2025 14:40:21 +0000 (UTC)
Received: from bcodding.csb.redhat.com (unknown [10.22.90.176])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 69198195608D;
	Thu, 15 May 2025 14:40:19 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Lance Shelton <lance.shelton@hammerspace.com>
Subject: [PATCH v1 0/3] NFS Client btime support
Date: Thu, 15 May 2025 10:40:15 -0400
Message-ID: <cover.1747318805.git.bcodding@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

We're getting requests to allow the client to support btime, current kNFSD
already supports this for compatible filesystems.

I've rebased and worked the first three patches from
https://lore.kernel.org/linux-nfs/20211227190504.309612-1-trondmy@kernel.org/
onto v6.14, and I've been driving them around bakeathon without any signs
of trouble yet this week.

Thanks Trond and Anne for this (years-ago) work.

Anne Marie Merritt (1):
  nfs: Add timecreate to nfs inode

Trond Myklebust (2):
  Expand the type of nfs_fattr->valid
  NFS: Return the file btime in the statx results when appropriate

 fs/nfs/inode.c            | 48 ++++++++++++++++++++++++++-------
 fs/nfs/nfs4proc.c         | 14 +++++++++-
 fs/nfs/nfs4trace.h        |  3 ++-
 fs/nfs/nfs4xdr.c          | 24 +++++++++++++++++
 fs/nfs/nfstrace.h         |  3 ++-
 include/linux/nfs_fs.h    |  7 +++++
 include/linux/nfs_fs_sb.h |  2 +-
 include/linux/nfs_xdr.h   | 57 ++++++++++++++++++++-------------------
 8 files changed, 117 insertions(+), 41 deletions(-)

-- 
2.47.0


