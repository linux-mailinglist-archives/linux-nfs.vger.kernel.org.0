Return-Path: <linux-nfs+bounces-11971-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0682AC7BEA
	for <lists+linux-nfs@lfdr.de>; Thu, 29 May 2025 12:46:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95BD01BC70A5
	for <lists+linux-nfs@lfdr.de>; Thu, 29 May 2025 10:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AFB0207A0B;
	Thu, 29 May 2025 10:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z27eOVWQ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00793155335
	for <linux-nfs@vger.kernel.org>; Thu, 29 May 2025 10:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748515558; cv=none; b=gYcEQcw2NOTaqLEAJ/OWF45OP4wQGOSZp9QcBIUFzCiB3aR9dqYW81z/OX8YZEsGr2BeqTEo+Y5H/ygmJEKU5BFOuDhKGJyV+Ud99z9pCDYkCosvMQakB9IfJw2b1lUK08Kla+JOW74p8GX2qqP36jF6D1+LRqisU+SWZ/FsoL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748515558; c=relaxed/simple;
	bh=Yq8a2b3/35qiod47rVFoLswOy84tsL2J0OutoXYZS7E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AI8YQuF7ypB26WWFAh4wQBqQJiOhPQwJGpXVGPslta5iUMN6AjQ1R3+GQWOPU2A1u3VRB0k+8aBGQ+ot9Ii0s+Bc/2LVxi6e5pHSBr2uguWtpEZNnvq92oU1U7sutkav/2Lk5HHkiaqwy1Fbkdgc1yQ60hJ6deh5nqpuHrob5/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z27eOVWQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748515553;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ZjIkMuRBUqSMo5as6KkRMAWOMFX050QlP+yAX1vTctk=;
	b=Z27eOVWQb5eCCcJyhp/Ye8S5c4ZpRCCfnev+JGj/SucRy40DRXZlsc+U8GYI01k9xDziOt
	XlY9u0l+lhYe5r0Sj/xR8ryLrKjNc+MCwYts6l9y+fHF2XqrPlENqzimSoxBU9F6xVTa3x
	l1suzFl+2QgdSSp5dIC2HDFUrjF1Rfs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-635-ur-ceb3lP72_KtysFvqHog-1; Thu,
 29 May 2025 06:45:50 -0400
X-MC-Unique: ur-ceb3lP72_KtysFvqHog-1
X-Mimecast-MFC-AGG-ID: ur-ceb3lP72_KtysFvqHog_1748515549
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 757631800446;
	Thu, 29 May 2025 10:45:49 +0000 (UTC)
Received: from bcodding.csb.redhat.com (unknown [10.22.58.2])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0C8A930002C0;
	Thu, 29 May 2025 10:45:47 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Lance Shelton <lance.shelton@hammerspace.com>,
	Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v3 0/3] NFS Client btime support
Date: Thu, 29 May 2025 06:45:44 -0400
Message-ID: <cover.1748515333.git.bcodding@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

We're getting requests to allow the client to support btime, current kNFSD
already supports this for compatible filesystems.

I've rebased and worked the first three patches from
https://lore.kernel.org/linux-nfs/20211227190504.309612-1-trondmy@kernel.org/
onto v6.14, and I've been driving them around bakeathon without any signs
of trouble yet this week.

Thanks Trond and Anne for this (years-ago) work.

v2 - fix unnecessary cast to printk
v3 - drop hunk unrolling INVALID_ATTR on 2/3, add BTIME to INVALID_ATTR

Anne Marie Merritt (1):
  nfs: Add timecreate to nfs inode

Trond Myklebust (2):
  Expand the type of nfs_fattr->valid
  NFS: Return the file btime in the statx results when appropriate

 fs/nfs/inode.c            | 34 +++++++++++++++++++----
 fs/nfs/nfs4proc.c         | 14 +++++++++-
 fs/nfs/nfs4trace.h        |  3 ++-
 fs/nfs/nfs4xdr.c          | 24 +++++++++++++++++
 fs/nfs/nfstrace.h         |  3 ++-
 include/linux/nfs_fs.h    |  8 ++++++
 include/linux/nfs_fs_sb.h |  2 +-
 include/linux/nfs_xdr.h   | 57 ++++++++++++++++++++-------------------
 8 files changed, 109 insertions(+), 36 deletions(-)

-- 
2.47.0


