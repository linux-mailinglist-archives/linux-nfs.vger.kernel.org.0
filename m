Return-Path: <linux-nfs+bounces-8150-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE1A39D3D79
	for <lists+linux-nfs@lfdr.de>; Wed, 20 Nov 2024 15:24:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7E7AB2C98D
	for <lists+linux-nfs@lfdr.de>; Wed, 20 Nov 2024 14:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 514B41AB534;
	Wed, 20 Nov 2024 14:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L8LhXfjt"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711592746D
	for <linux-nfs@vger.kernel.org>; Wed, 20 Nov 2024 14:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732111784; cv=none; b=R8l6CmrYZqvdDTwe/gg11fd65sCmqnQzFIEnKvlho95q66y1XwamZWj9thV0wCntRgP2AiMsIFsUrr+ijB6HCdmn3BevF+MyfT+h9+o/waOPzCzR8JDCxLvv/GQVv3vZ7dbctSah5e7DNQI2HPV3QhOl7XTEt7WmyPqaOdUaoss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732111784; c=relaxed/simple;
	bh=kTPHfsq4DJAcWWjUzh3BGlulaCBUrfKYBfa77ltIsvc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fEqo+uHtmrmZy+CrjYaWt/wHTWa6a5Cc6jEl6zuwveg4/rnYgDl8XaKkDi8zoAMkbRA7zXa3T6ahyEc9h0jqaEdMOZ5NMZ873AefWHj/NMsMUbTmGMpggqDLN1isXOV+cCpqrxWhgvDp6elQaW9s4vKMSJ1kuR0LhBC3FrjkFxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L8LhXfjt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732111781;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zrUcZWPztkGVBiyMC7XdsN6uvVC0ZWFJvxTNJD+Z3sA=;
	b=L8LhXfjt/SXheDlwZyYZahFx9mxePviohVu+si9r0d8T0QVfoXVb+2AMtaLiNC82r2hZuy
	2EuFdf/n2/Kxz7L6aQ8ftjcQyiiAFv6wtGhO65CqCL+rOTpCc3rM5MZgE9dJMAyi87PJT+
	fq+zeOBNLMXrlyYIesXpuiFeTnUd7dk=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-25-j7GLY49kMEuUecpW9LA-WA-1; Wed,
 20 Nov 2024 09:09:40 -0500
X-MC-Unique: j7GLY49kMEuUecpW9LA-WA-1
X-Mimecast-MFC-AGG-ID: j7GLY49kMEuUecpW9LA-WA
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4E7C819541BE;
	Wed, 20 Nov 2024 14:09:38 +0000 (UTC)
Received: from bcodding.csb.redhat.com (unknown [10.22.74.7])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BFF101955F4A;
	Wed, 20 Nov 2024 14:09:36 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Cc: linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 0/2] two fixes for pNFS SCSI device handling
Date: Wed, 20 Nov 2024 09:09:33 -0500
Message-ID: <cover.1732111502.git.bcodding@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

A bit late for v6.13 perhaps, but here are two fresh corrections for pNFS
SCSI device handling, and some comments as requested by Christoph.

On v2: add full commit subject in 1/2, change the caller in 2/2.

Benjamin Coddington (2):
  nfs/blocklayout: Don't attempt unregister for invalid block device
  nfs/blocklayout: Limit repeat device registration on failure

 fs/nfs/blocklayout/blocklayout.c | 12 +++++++++++-
 fs/nfs/blocklayout/dev.c         |  6 ++----
 2 files changed, 13 insertions(+), 5 deletions(-)


base-commit: adc218676eef25575469234709c2d87185ca223a
-- 
2.47.0


