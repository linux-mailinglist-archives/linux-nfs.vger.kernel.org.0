Return-Path: <linux-nfs+bounces-9186-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEF1BA0C564
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Jan 2025 00:13:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A964C7A218D
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Jan 2025 23:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE0F51E3DCB;
	Mon, 13 Jan 2025 23:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VMist3jw"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935331BD9EA
	for <linux-nfs@vger.kernel.org>; Mon, 13 Jan 2025 23:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736810006; cv=none; b=VK3x+KL/UWTr5KEjfddjPc66F7t1Obm4fq7JNrGaI/OgsJibAWknNuJWI5fcvx52aCaaYxDvj3TjclwKhTptoMlWW5WZxntPJoSXl5XrWyOYigip3dmtem6Rne3s8T3JWNws0cf8fimoVGEVo+ueVVZ8RUfaIZpxyBEobjm5yqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736810006; c=relaxed/simple;
	bh=pcBJqrPoA5HtS+Ey2mY+s72xRg02WeWsfIv+uIyOdLg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BEoBvOrirfPTFc8Iyog7IYDy3rayXvaOUebFlGeck+cYEyfRr+44uKHOJ9EO0pyp8YCxlPuz+T3Y7qr39tWBt+aSpT0bl/ZxGDxBOQnhizRbkBeGJh3Ac6TdE0zj2GfScKMDGBhBLtz+dxN9dZudPz7kt4lJCCtOH9WsXy/zstI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VMist3jw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736810003;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=OHC2L2vzCN+b/WLruta/WSPq1xas33KUKH2lIwX2L3c=;
	b=VMist3jwtS7922AdAZK++B4sfNV4v8Y5tTc0Vq6ELBwbvIquRkLIccjBa3Nc+wP5Tjj3oU
	bjZmX2qdJM/s8X8KK0tSktIM/lFbfmaaGtzC65vWIRXkjeZWalUqK8g1E99sXM0elGvgUn
	Oe0Tn2ASvYnkm9nSgGJ3iTdWWYO6h0Y=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-481-nMixT6_uODCNW3UzMGnPSg-1; Mon,
 13 Jan 2025 18:13:22 -0500
X-MC-Unique: nMixT6_uODCNW3UzMGnPSg-1
X-Mimecast-MFC-AGG-ID: nMixT6_uODCNW3UzMGnPSg
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4C04719560B0;
	Mon, 13 Jan 2025 23:13:21 +0000 (UTC)
Received: from aion.redhat.com (unknown [10.22.64.152])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 206483003FD3;
	Mon, 13 Jan 2025 23:13:21 +0000 (UTC)
Received: from aion.redhat.com (localhost [IPv6:::1])
	by aion.redhat.com (Postfix) with ESMTP id B03492EA88C;
	Mon, 13 Jan 2025 18:13:19 -0500 (EST)
From: Scott Mayhew <smayhew@redhat.com>
To: steved@redhat.com
Cc: jlayton@kernel.org,
	yoyang@redhat.com,
	linux-nfs@vger.kernel.org
Subject: [nfs-utils PATCH v3 0/3] version handling fixes for nfsdctl and rpc.nfsd
Date: Mon, 13 Jan 2025 18:13:16 -0500
Message-ID: <20250113231319.951885-1-smayhew@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Two changes in how nfsdctl does version handling and one for rpc.nfsd.

The first patch makes the 'nfsdctl version' command behave according to
the man page for w.r.t handling +4/-4, e.g.

# utils/nfsdctl/nfsdctl
nfsdctl> threads 0
nfsdctl> version
+3.0 +4.0 +4.1 +4.2
nfsdctl> version -4
nfsdctl> version
+3.0 -4.0 -4.1 -4.2
nfsdctl> version +4
nfsdctl> version
+3.0 +4.0 +4.1 +4.2
nfsdctl> version -4 +4.2
nfsdctl> version
+3.0 -4.0 -4.1 +4.2
nfsdctl> ^D

The second patch makes nfsdctl's handling of the nfsd version options in
nfs.conf behave like rpc.nfsd's.  This is important since the systemd
service file will fall back to rpc.nfsd if nfsdctl fails.  Note that the
v3 version of this patch also makes 'nfsdctl autostart' fail with an
error if no versions and no minor versions are enabled in nfs.conf.

The third patch (also new in this v3 posting) makes rpc.nfsd consider
the 'minorvers' bit field when determining whether any versions have
been enabled.  This takes care of two scenarios:
1) When vers4=y but vers4.0=vers4.1=vers4.2=n
2) When vers2=vers3=vers4=n but any of vers4.0/vers4.1/vers4.2=y

-Scott

Scott Mayhew (3):
  nfsdctl: tweak the version subcommand behavior
  nfsdctl: tweak the nfs.conf version handling
  nfsd: fix version sanity check

 utils/nfsd/nfsd.c       | 29 +++++++++++---
 utils/nfsdctl/nfsdctl.c | 86 +++++++++++++++++++++++++++++++++++------
 2 files changed, 98 insertions(+), 17 deletions(-)

-- 
2.45.2


