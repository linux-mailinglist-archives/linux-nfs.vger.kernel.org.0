Return-Path: <linux-nfs+bounces-13344-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 851B6B176BD
	for <lists+linux-nfs@lfdr.de>; Thu, 31 Jul 2025 21:44:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 002181C24416
	for <lists+linux-nfs@lfdr.de>; Thu, 31 Jul 2025 19:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA952459F6;
	Thu, 31 Jul 2025 19:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rcWwbfqU"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B62245019
	for <linux-nfs@vger.kernel.org>; Thu, 31 Jul 2025 19:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753991090; cv=none; b=NM4pnPxn/Kbe47p5ochv7ONjfFtb5tzfQ5naIXmyPZvwi9Zsw7WbJsW22DhGAUsNzeUSrQ74IbqoAvq/OYFF9YWr3ozxX0Aewfs8sL4cuQqr5lsP6jozAfCXRui7uOyWpAkBHAl7kGfI0uqnvEBZk88KCchPNMxov+6LVi6qStw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753991090; c=relaxed/simple;
	bh=6+1jjLum42sVPRRlW6C8wKlbWZIgos3VJtE3dSvKvuY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sn1nKA29pdfi3aQ2cwTAaDbLhiLZ20y6Hy42/Ca0zB0yDft/uf5G0DDvJ2WXV0Wc1FW+q7rGTPWt590NBJKtacDaSSUrDbsFNJ7HIl3b2FDl9qcW29D3V9R+CpnrnvfrIbVUxo3SEgFMo5TdzbSI7x1NnQCuLBPaUWm7F/RWY1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rcWwbfqU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F22BAC4CEEF;
	Thu, 31 Jul 2025 19:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753991090;
	bh=6+1jjLum42sVPRRlW6C8wKlbWZIgos3VJtE3dSvKvuY=;
	h=From:To:Cc:Subject:Date:From;
	b=rcWwbfqUtSFRAPMENaw3uufyUzLNt94opdNMRnO1tiOr7fIi4huNf3+TebFQpqf1z
	 j/KTZd3f97s7AMpBimP+MnuxYvj6lBNpOR9mqAleyNrX23qvG+QPaRjHz0BUM71M/V
	 LbXPZJVrYD1QrTnLl9cGPaTp+kn7s0SqebD5LJlotFevRa1xP72tHUdZr8IV0mcRUx
	 n6jOgs83i6eAwGjMq5A0VMFMOC6i6eJubCDyM5n1cn1umqTpFp5ZcwTAbftxhS2L/Z
	 hZlc6Xxp6+Kmo7UTVOaiukWlCG6TejCznbZm9n8jq8g4ZPe7zwg2EKzqvaFbmTZqzH
	 fTEqg6Eie62zg==
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v2 0/4] NFSD DIRECT: add handling for misaligned WRITEs
Date: Thu, 31 Jul 2025 15:44:44 -0400
Message-ID: <20250731194448.88816-1-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This series builds on what has been staged in the nfsd-testing branch.

This code has proven to work well during my testing.  Any suggestions
for further refinement are welcome.

Changes since v1:

- switched to using an EVENT_CLASS to create nfsd_analyze_{read,write}_dio

- added 4th patch, if user configured use of NFSD_IO_DIRECT then NFS
  reexports should use it too (in future, with per-export controls
  we'll have the benefit of finer-grained control; but until then we'd
  do well to offer comprehensive use of NFSD_IO_DIRECT if it enabled).

Thanks,
Mike

Mike Snitzer (4):
  NFSD: refactor nfsd_read_vector_dio to EVENT_CLASS useful for READ and WRITE
  NFSD: prepare nfsd_vfs_write() to use O_DIRECT on misaligned WRITEs
  NFSD: issue WRITEs using O_DIRECT even if IO is misaligned
  NFSD: handle unaligned DIO for NFS reexport

 fs/nfs/export.c          |   3 +-
 fs/nfsd/filecache.c      |  11 +++
 fs/nfsd/trace.h          |  52 ++++++++---
 fs/nfsd/vfs.c            | 188 ++++++++++++++++++++++++++++++++-------
 include/linux/exportfs.h |  13 +++
 5 files changed, 220 insertions(+), 47 deletions(-)

-- 
2.44.0


