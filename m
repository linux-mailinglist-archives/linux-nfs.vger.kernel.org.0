Return-Path: <linux-nfs+bounces-8751-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 158309FB3CD
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Dec 2024 19:07:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 935BF1663FC
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Dec 2024 18:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A45E31B87CE;
	Mon, 23 Dec 2024 18:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EZ/nl71l"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805C21B413F
	for <linux-nfs@vger.kernel.org>; Mon, 23 Dec 2024 18:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734977255; cv=none; b=MHIUKywzz76Framx6DhBpT3F748G1PCylCI557nGD6G55s+1t2oP52fWEULRO2dM+Uw1WLdL/bHM9bsSghJX4+fIteMlIQXSb3utxX5Covmku0sJYjM/u5gEgKBbUsMk/VnpKhGAw5a391vOv3+Dj7o0X+ShEJiiWDNk+ZYBteM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734977255; c=relaxed/simple;
	bh=uEXbfeAvqsxsMAL/dRo5lDw4DGxzeKpMA8o/9ewVt2E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NQESitdBZYhu7ZFg5/b8UnoIMyAUKCLyohP28oDLTTCOLJE99QRYAgXjJLjeoOjO/9ABTnIlQjKu4bqtamJN1P22cayBx8v1JQg50ez+Ya75hAL2xABWEgmKyQzlQYYk/Bxs/CQum9YGirxNEGlR0UPslLCPg2xshUdOtnR3ZLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EZ/nl71l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43A37C4CED3;
	Mon, 23 Dec 2024 18:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734977254;
	bh=uEXbfeAvqsxsMAL/dRo5lDw4DGxzeKpMA8o/9ewVt2E=;
	h=From:To:Cc:Subject:Date:From;
	b=EZ/nl71lJUoiQixpCJkxAz33vtX2v+taPTO9tysXEzCGtwxeZzN5jiNjq73sgmljL
	 SpmqL4qpVAzA5yEyQU6B/Dz0RtFXvudPniauEhwfypiipashIo4Ew4L4BRLUHfYmD2
	 +3i2QWy1J7W9yqDLYC5iuJfaDHCcZ23lmT7YQzsdRfw/FiUC+xmwgAprN+AK3DkKS0
	 2kVU+90XMlzvKwsI0wLCCp2p0+qK1c5qQ+MkJ2odWyeHykRpTfJyXq7jjOK0utmWnv
	 hB/wYLJ1WNFJOxmNkWlfiKiSHu/rr/wbM5Ctw6twx7Dkrra8a0GPtIBBgPJXoKzV0B
	 OWglWAVZfPKow==
From: cel@kernel.org
To: Neil Brown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Rick Macklem <rick.macklem@gmail.com>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 0/2] Fix XDR encoding near page boundaries
Date: Mon, 23 Dec 2024 13:07:25 -0500
Message-ID: <20241223180724.1804-4-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=817; i=chuck.lever@oracle.com; h=from:subject; bh=AvijCLVhZb4jCWfGJ9XVcoe+kQQam9MjijOmYjWll1s=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBnaabcABfVEK48A4aBxENtciSoSsWm2tew1ztx2 hv96VNcmMeJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCZ2mm3AAKCRAzarMzb2Z/ l5sZEACz9FbK+4KxewbHoXjwsfKHgPMw6QpbmVpaOg6mvCqtzkkk7gWm26Hz4BLVBcPacuhU79N w5Yh1kiaafvhWSjMP5c0DpIn9FU0Gy78bRVrEfYXhD+spbh5HNqlK8LMuDUHlTXbaxwA3Rz3Spq oyCdv4+2ew6zRa0FmkeJ4f36iskYb8VjzzRQuiVHAUHkPSLanTROsihEISfV+1+L1Wc8DpNKTau DBIrE6nxx9GBl0NGfnN8mDyS660eueeHRJjQtZVyhVqxWSl31mcjiZdFHG7K+0TSuTxjMLipe+g gDayfFkC+or3ksXrlP1zzR/IFP1tqfW1RJbhBYs8XC59zd6s+QVPhsN7uksHLyoexkG90s4skt5 nYZI9/5JZ40/7rA0K+U201W0tb8TFIW5qCfFRPnOh8+HniJCercixuw47irdFu2NFcw940Wb/JF H17Cy0QE67low0QOzjwgKhCzR6UrQacCC0EbI8Kb1IRa+kG5aXQx4FS9cjp8Gtg6u+bo02LXjP/ czqP5hOP8nh3ivvkLYfTvUs5JWSu6g5WL/0KPb6Xe5HnKmy9omnFSzZ7P05OjET0INXoxQ0SEGz rGcKutI3ZvZ09jashCVUUieBPlatE7PQxmrnSJL/k3iYjMy0gUz5H0cvJnvX5zLfwwQdWcrZXBt +TIoRDp6+DeT7Ug==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Build out the patch series to address the longstanding bug pointed
out by J David and Rick Macklem.

At least during NFSv4 COMPOUND encoding, using
write_bytes_to_xdr_buf() seems less brittle than saving a pointer
into the XDR encoding buffer.

I have one more patch to add (not yet included) that addresses the
issue in the NFSv4 READ and READ_PLUS encoders.

Changes since RFC:
- Document the guarantees around pointer returned by xdr_reserve_space()
- Use write_bytes_to_xdr_buf() instead

Chuck Lever (2):
  NFSD: Encode COMPOUND operation status on page boundaries
  SUNRPC: Document validity guarantees of the pointer returned by
    reserve_space

 fs/nfsd/nfs4xdr.c | 20 ++++++++++----------
 net/sunrpc/xdr.c  |  3 +++
 2 files changed, 13 insertions(+), 10 deletions(-)

-- 
2.47.0


