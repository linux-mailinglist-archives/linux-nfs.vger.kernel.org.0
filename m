Return-Path: <linux-nfs+bounces-8988-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25BB8A06744
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Jan 2025 22:37:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCA7F188A2C4
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Jan 2025 21:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EED4203709;
	Wed,  8 Jan 2025 21:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PGBgYj0o"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A62F202C58
	for <linux-nfs@vger.kernel.org>; Wed,  8 Jan 2025 21:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736372248; cv=none; b=mZKDCayaAngBV1VHHYYPKaGNswPn0zrrT8Kz+Ky4WjbrX4Wu1khFknN9mliIwIfB21Ra5toBvZxVb8TDLfPekK4DWT/NralA3T8Q2dl7+FJK5OvWM/WCIgqOH9teZFOTSiV39OvfcZfFoCqnvS7CjDUoMaD682SCJ3Dy2pSTwJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736372248; c=relaxed/simple;
	bh=jj7iwpfhFS3UXNofoCYVf3/yWGLpAAwxz5FukzaPxZc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PN1LadcSpa3HxvzXuEXfXsCC/1P1nBp4HFMWBLRC3PFkM6vIuICfeDtvX91fAqm6T1g0vITXNs45CPKm3SXqR97iTbH8Tnty6N8Ho/NoUyY64/ckHlv3I8OggVfBqlX0mkThD8hvM/MpUSnG2NjVCxU+GfuU1b9gaIoQSah22AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PGBgYj0o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33F9CC4CEDF;
	Wed,  8 Jan 2025 21:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736372247;
	bh=jj7iwpfhFS3UXNofoCYVf3/yWGLpAAwxz5FukzaPxZc=;
	h=From:To:Cc:Subject:Date:From;
	b=PGBgYj0onVAAI10WyyeORo9nWWz/aripkHqZc5OQ+T3EYQlO+dk2l+Ch/yF8/jN2r
	 VkzZMdb8dssPWDhEmUdtsBQpVDBM/Y+7A0mM8bs+r0+WGCnU5Mi4ArkFsWNFXXdujH
	 VfrTwgItvgwF/68qI37Nswbx8yldli5CQ1mp4PmjGCCIMDgVZ6wXKMQRfhrZvOZsrX
	 dDmV8miJH5RgaTMG9ssOhJ8mb3UwY1A8FbTqwXEkl5YnhG7rDP0dFg9Rsxig/IRWob
	 gBcd64b/PyExqRqnimRE6d0npBmN/mb4kwFUnx2KqPQ87sD3TxYB3/0iZZy+qTZSlK
	 E6Hgl1mJmkgWg==
From: Anna Schumaker <anna@kernel.org>
To: linux-nfs@vger.kernel.org,
	steved@redhat.com
Cc: anna@kernel.org
Subject: [PATCH NFS-UTILS 00/10] rpcctl: Various Improvements
Date: Wed,  8 Jan 2025 16:37:16 -0500
Message-ID: <20250108213726.260664-1-anna@kernel.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Anna Schumaker <anna.schumaker@oracle.com>

The first several patches in this series fix up several Python style
errors found through the flake8 to clean up the tool. The remaining
patches update the tool for the xprtsec and add_xprt features added to
the NFS / sunrpc client with the companion kernel patches.

Thoughts?
Anna

Anna Schumaker (10):
  rpcctl: Fix flake8 whitespace errors
  rpcctl: Fix flake8 line-too-long errors
  rpcctl: Fix flake8 bare exception error
  rpcctl: Fix flake8 ambiguous-variable-name error
  rpcctl: Add missing docstrings to the Xprt class
  rpcctl: Add missing docstrings to the XprtSwitch class
  rpcctl: Add remaining missing docstrings
  rpcctl.py: Rename {read,write}_addr_file()
  rpcctl.py: Add support for the xprtsec sysfs attribute
  rpcctl: Add support for `rpcctl switch add-xprt`

 tools/rpcctl/rpcctl.man |   4 ++
 tools/rpcctl/rpcctl.py  | 145 ++++++++++++++++++++++++++++++----------
 2 files changed, 114 insertions(+), 35 deletions(-)

-- 
2.47.1


