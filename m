Return-Path: <linux-nfs+bounces-8199-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 306429D611E
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Nov 2024 16:11:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78349B23CCF
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Nov 2024 15:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E58C1DE2BF;
	Fri, 22 Nov 2024 15:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qyf22EVv"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767BD83CD3
	for <linux-nfs@vger.kernel.org>; Fri, 22 Nov 2024 15:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732288285; cv=none; b=qaMHeVUhbieZist2MsOMwMkkyJtdVjYHZbldVmdaCjimFWixyQrtxgrhYeJYe/jvcFjA3GF6q0yxARbKcZSyoCvMj7fOzfFOe+vmRIFHPxJA124WCuON5WCKVhDdVA+J7JoueGnVF1JFWRZjp1xckeBGFj0Y/e7X+Twu5/q+0yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732288285; c=relaxed/simple;
	bh=EmxuOCAstcHjb+AyjYkPAKLbSEefeeHjKTfwcB1VwNA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jJY2S+iNTJbeQAlYdH05bTXEtjSSyyHdSru+TpL8ZlkcTKbVa/gq4niW58D3pRW2EX9ehACiHhvC4rwqU/EQTGuyC0TLH8oc0c7UwPwURro2tz7MLuLb/Qr2XQbvrywNG2neN4hJCVJ9iAv/LfM7Ay+224858RS/ohNGTMsenA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qyf22EVv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732288282;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=gkrLDnQRXbiYmOpIL8sqh5yHPfjqFY6H4f66AvZUaU4=;
	b=Qyf22EVvBYKe5hwQ5+SlmZsgceX6B3zXSdErY8zuksvgkH+UqNC92BdzVf0anDPbXh4igb
	GHuSlYME//aJd1EKoULhKwi0i05RFc2/YZ1H2tYrU+8q6tvGMFOV5zApLR52OSAMzA4K1+
	4n2nuY8R130VN7MRq9BUveOXOndxCA8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-60-L8rMQoH7MbeBew-AgYsu9g-1; Fri,
 22 Nov 2024 10:11:16 -0500
X-MC-Unique: L8rMQoH7MbeBew-AgYsu9g-1
X-Mimecast-MFC-AGG-ID: L8rMQoH7MbeBew-AgYsu9g
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C23261955E87;
	Fri, 22 Nov 2024 15:11:14 +0000 (UTC)
Received: from bcodding.csb.redhat.com (unknown [10.22.74.7])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5213A19560A3;
	Fri, 22 Nov 2024 15:11:13 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Cc: linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH v4 0/2] two fixes for pNFS SCSI device handling
Date: Fri, 22 Nov 2024 10:11:10 -0500
Message-ID: <cover.1732288202.git.bcodding@redhat.com>
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
On v4: rebase on linux-next

Benjamin Coddington (2):
  nfs/blocklayout: Don't attempt unregister for invalid block device
  nfs/blocklayout: Limit repeat device registration on failure

 fs/nfs/blocklayout/blocklayout.c | 15 ++++++++++++++-
 fs/nfs/blocklayout/dev.c         |  6 ++----
 2 files changed, 16 insertions(+), 5 deletions(-)


base-commit: cfba9f07a1d6aeca38f47f1f472cfb0ba133d341
-- 
2.47.0


