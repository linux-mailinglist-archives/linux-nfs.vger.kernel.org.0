Return-Path: <linux-nfs+bounces-8194-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B5069D5F37
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Nov 2024 13:48:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D34F71F237E3
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Nov 2024 12:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7692A1DE3BF;
	Fri, 22 Nov 2024 12:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ivxwpFls"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A2D10F1
	for <linux-nfs@vger.kernel.org>; Fri, 22 Nov 2024 12:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732279682; cv=none; b=Xh75DhM51x6I/TCm/OmI3iZvZEHfaeM/10sad7nq3DMXukAyTFtCkqKxgPpirfJBKBbLdDfCpACTbkeQJZQssRGT4rQIVcj5nKssLTyzN8UXzp5rxYJBcUK0/uIMDECgisX9zt6SF+IZTGltCHOPFUHcS1ganZi6K1BWas+cFS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732279682; c=relaxed/simple;
	bh=GMXvurGcRAl7pN3DCV+eL6H5leAk95czgjWVNnZTMSU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=le52Mhpp4Hs+wUNTRxi4M///jHhJyxxrY3Oqn7RHwtcYSEfxB7wp2WRnwuGx07WVHMseGUyKs7ifBK/9rr7sO7EvQYvmKZ2bOkdQGG/WnmBzT06kQSk3qjxN8qqRvopj4pH5vAdb26cKqawV2r0LLw8IHGOT1o/pbG7d8jd0QfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ivxwpFls; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732279678;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=mvwIpvdpfAjZgfFLx4APetKR2nQbssWTWJ5Wil/F77Y=;
	b=ivxwpFlskCX0mSxZnbrq2HaiUl09gIBxQWVHt2uZobxuLzDByCpIg+uoJxLwIZoh8C3sEi
	CNRz13MonWMWRePlzX046RwMxBZLLQuWMva75whTmXHM811kN6/aw8bRUFkyS9PvVozMPz
	EgGFixxboKKb0YAz2rCQ5rV+kZ5X/Ds=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-685-SAAtANJjOoSbH5ScdMiruQ-1; Fri,
 22 Nov 2024 07:47:56 -0500
X-MC-Unique: SAAtANJjOoSbH5ScdMiruQ-1
X-Mimecast-MFC-AGG-ID: SAAtANJjOoSbH5ScdMiruQ
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6936819560A6;
	Fri, 22 Nov 2024 12:47:55 +0000 (UTC)
Received: from bcodding.csb.redhat.com (unknown [10.22.74.7])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 05B8F195E481;
	Fri, 22 Nov 2024 12:47:53 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Cc: linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH v3 0/2] two fixes for pNFS SCSI device handling
Date: Fri, 22 Nov 2024 07:47:51 -0500
Message-ID: <cover.1732279560.git.bcodding@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

A bit late for v6.13 perhaps, but here are two fresh corrections for pNFS
SCSI device handling, and some comments as requested by Christoph.

On v2: add full commit subject in 1/2, change the caller in 2/2.
On v3: add r-b for Chuck, tweak comments in 2/2.

Benjamin Coddington (2):
  nfs/blocklayout: Don't attempt unregister for invalid block device
  nfs/blocklayout: Limit repeat device registration on failure

 fs/nfs/blocklayout/blocklayout.c | 15 ++++++++++++++-
 fs/nfs/blocklayout/dev.c         |  6 ++----
 2 files changed, 16 insertions(+), 5 deletions(-)


base-commit: adc218676eef25575469234709c2d87185ca223a
-- 
2.47.0


