Return-Path: <linux-nfs+bounces-15068-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AA94BC68C2
	for <lists+linux-nfs@lfdr.de>; Wed, 08 Oct 2025 22:13:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E5D364E253A
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Oct 2025 20:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 247F7221FBB;
	Wed,  8 Oct 2025 20:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wwl7vVGt"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B1A1C8630
	for <linux-nfs@vger.kernel.org>; Wed,  8 Oct 2025 20:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759954432; cv=none; b=lSn0ysg71BYaKUivD/zKyYRRz2GPt9kblNrSHD9K15dVfAC/FAB9NoyuyK0faWh+9GwAgVyuLAQpP9Y41sXaixJVFbchnLGxG+KzGHgc6I8H5sUDIoWZP83ki0raDkmUnM6vGst2HvicNDO5QYANWbupWM/rH7+zHgDLu3Hjaag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759954432; c=relaxed/simple;
	bh=NjnUuHb6kICyQGdBkIWLwSeq37lq98llugtg/udjVho=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=iWNYYNSf+YptME8LOUmIqm5RepaxYTiT4EaB0M2a7WGzADguKjZC/buOrWK0Le5MO2eh0eng1DRKU/nktQrfXvxFrEdJ9MElnlApkUIkO3Au2/65AouyoprUKNB0zj+5xVWZB27mba1R4byfarbPkjiaei5qrCWOqMxuOF22/js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wwl7vVGt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63961C4CEE7;
	Wed,  8 Oct 2025 20:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759954430;
	bh=NjnUuHb6kICyQGdBkIWLwSeq37lq98llugtg/udjVho=;
	h=From:Subject:Date:To:Cc:From;
	b=Wwl7vVGtRMDctcqz23vALLKEY8hg9IglNpKz88gaJUwENFouAJ7aG+nMoFS7pc8cO
	 R+10J+rVd62pSO3U/EUkiD8TMNXmjWLRmLEQFh+XPyBYUfM/f+Eeu10q3d5FNj0bCA
	 f6N0fzRUXVhbW4JYHBEnSKVI9VAIueaT8jx1hAa81ytWozaS6avNz6zIZzCEHuXY8D
	 YERSJabTAXlXSAVIr5sFABDBP6NaIvA0KjFa002iBweVagF1IbMLibnzzBt4UvL2Tr
	 ksAYy68LC2//qSKblFDCkM/nRiZPFeywrSLJKCUE0Rab4bAtW4bHdhVY80s5wQwm2D
	 Q3qctXDcVH9lg==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH 0/2] nfsd/nfsdctl: default to starting with v4.0 servers
 disabled
Date: Wed, 08 Oct 2025 16:13:41 -0400
Message-Id: <20251008-master-v1-0-c879be4973c8@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPXF5mgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDAwML3dzE4pLUIl1zIxNTC/Pk5ERLy0QloOKCotS0zAqwQdGxtbUAAnM
 h/lgAAAA=
X-Change-ID: 20251008-master-724587cca99a
To: Steve Dickson <steved@redhat.com>
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=676; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=NjnUuHb6kICyQGdBkIWLwSeq37lq98llugtg/udjVho=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBo5sX9rZoD+w3gYRwJc/+/JOsCdvVuMMZiyZfDy
 iUPtsMX14yJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaObF/QAKCRAADmhBGVaC
 FVX1EACb0Vt+hQs7pZ2sgMnmp9cIRS4w7jRO+Y2mD8Cd4/EnJrMydKMhAwGE0E3HWZEoEnM0tuy
 cgRh2dBGE3zUTzVpvbeEYJ8PNVRv6tL4DYHpUya+oFWisrPhvGHBPaLUjnXPhe+ePVidxmmr9uL
 Xw3JabVgms9zPdNe2xQFbqmhQudgGdgMV23IvUBtyVZODcANTW+evNCtIeawdX5wysp5I/5RvcN
 OGXdKsB6YIhOVx1folNl8NYZyER079YXt/X4ZtoA7SeG3zGcJ1xWtmd2Q5MW5X2Bfq80mRNtlDL
 bRmlGp6nR28ZOKIwp0M0dlS/ex7Qvp3JoVDTHzRYrA/WpsNSMlDsA9xzJ5mD1eqkz/YUaWOJU8p
 hqr4YQofldrQ3PV+zfpLGiTXi2M4nJZQ8so9NcBIXEfKZwD2s/JFI5X7K8ICDS+kFCtHLiLAWTT
 q8nE1ElsDKMbS3PKZBBba03Tx+rsu0z++4+fdCqrAowKiHP/DPIJEx6fDlRC3LGexQGpRjD2n+a
 Z2tCTM5cgN2yynaryE0dTdmrJBqailvBgVM7feKiAQi7WBHhU8PjzkZ5tOeXNbr8G6ryVFBcBKk
 FG4wNJQHXbVwiFk43b2k9vdK52y1Z5WiQPu3FhCC9bOClcnmdmze1cDCcLe/ua2oYMGQX4JVF5T
 Nwbs+aBaB6L3J/Q==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

At this week's NFS Bakeathon, we had a discussion around deprecating the
NFSv4.0 protocol. To prepare for that eventuality, make the NFS server
only accept NFSv4.0 if it was explicitly requested in the config file or
in command-line options.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Jeff Layton (2):
      nfsd: disable v4.0 by default
      nfsdctl: disable v4.0 by default

 utils/nfsd/nfsd.c       | 5 +++--
 utils/nfsdctl/nfsdctl.c | 2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)
---
base-commit: 612e407c46b848932c32be00b835a7b5317e3d08
change-id: 20251008-master-724587cca99a

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


