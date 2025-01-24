Return-Path: <linux-nfs+bounces-9584-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1977FA1B8A6
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Jan 2025 16:16:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4BB93A2413
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Jan 2025 15:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5013970819;
	Fri, 24 Jan 2025 15:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i4In4S3s"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB12111AD
	for <linux-nfs@vger.kernel.org>; Fri, 24 Jan 2025 15:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737731757; cv=none; b=oxNCvs1zSNlODPaiSuO5+iycmZm0x3/gnnwlgko3uaRhHlLlOxPZAMHXAktQvQT6jLrp9U7blWCQeiQVKwwaUXVjmT/lBVVBM+me+mIqr2cFqAOCpmG0LuR6qLmocQkRSIScjZwu1Zg7Quittj6zmQAby/xWPe2ww9ap5K6/wmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737731757; c=relaxed/simple;
	bh=rAjIW9inF8idkMGfGn4XKK/yxJP1i6l9rrpMHkZ8GnE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TfoZYjt0+XZ9wT7SpFRwiKyWSvVdtgcnZUHRBpvzE9UECe3z43ZL0L3+BPsHnD4GuwcEOmVOm/NmsbJlGt818Sz65CnQcDytTMvkZgaQuo11rpf3juPnVD0s4WQV3uGbT+mRLCIO5eMdmxmgFF99ujxqY1KM9Z+DHpIhSuJVRmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i4In4S3s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5C10C4CED2;
	Fri, 24 Jan 2025 15:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737731756;
	bh=rAjIW9inF8idkMGfGn4XKK/yxJP1i6l9rrpMHkZ8GnE=;
	h=From:To:Cc:Subject:Date:From;
	b=i4In4S3s9pnPSxTD0isHyfj50hk/VLXTXBDrni0LkbPfXLW11NYLBwncKuN3ek0CG
	 JguR/SLhw+y1Shsw2X+2mApTq7q4ec2etB8DpBjvGVlz6lW+VKUl5gy+j6Vrqmz+zp
	 X0PitiQDySCNxmBS57QrMWuMgRbV9lh840a5VCdR+zmYyJaSo/WaGe/o0InC96RgNf
	 +w0hHWXnXKaBTkLu6ZJ2J7nSJujqQQz2JPxS471oXVuWg5C46VfGJUkZIPNZxAsen2
	 QZ1CoxivF1rPzK4RfXTF9z5+CEbkXpJSM0wZ8nYrAsejwFtzV4eHXIIH7FZeLiIewN
	 sAG7kJFE8IKOA==
From: cel@kernel.org
To: Amir Goldstein <amir73il@gmail.com>,
	Neil Brown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 0/4] Avoid returning NFS4ERR_FILE_OPEN when not appropriate
Date: Fri, 24 Jan 2025 10:15:49 -0500
Message-ID: <20250124151553.17824-1-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

This short series aims to prevent NFSD from returning
NFS4ERR_FILE_OPEN when an NFSv4 LINK, RENAME, or REMOVE operation
targets a directory.  The only time the protocol spec permits a
server to return FILE_OPEN is when the target of the operation is an
object that is open and cannot be closed immediately to satisfy the
request.

I would have preferred these fixes go into NFSv4-specific sections
of NFSD, but the current structure of the code prevents doing that
while maintaining operational efficiency. Plus, these small patches
should be able to apply cleanly to LTS kernels.

We can defer deeper restructuring for later. For example,
fh_verify() could be made to return an errno instead of a generic
NFS status code; then the VFS utility functions in fs/nfsd/vfs.c
could be made to do the same, making their callers responsible for
the proper NFS version-specific translation of the errno into a
status code.

This series has been only compile tested. I'm posting early for
review and comment about this approach, but please do test these if
you have the ability to trigger -EBUSY easily.

NFSv4 OPEN is also affected, but because of its complexity will
require careful audit (ie, a separate patch set). Please send a copy
of the output of WARN_ONCE so we can see where to start digging in
that area.

Changes since RFC:
- Address a minor code odor
- Clarify some code comments

Chuck Lever (4):
  NFSD: nfsd_unlink() clobbers non-zero status returned from
    fh_fill_pre_attrs()
  NFSD: Never return NFS4ERR_FILE_OPEN when removing a directory
  NFSD: Return NFS4ERR_FILE_OPEN only when renaming over an open file
  NFSD: Return NFS4ERR_FILE_OPEN only when linking an open file

 fs/nfsd/vfs.c | 103 +++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 77 insertions(+), 26 deletions(-)

-- 
2.47.0


