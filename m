Return-Path: <linux-nfs+bounces-13494-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B215B1E77A
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Aug 2025 13:41:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D27B1AA06A5
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Aug 2025 11:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA12526A08D;
	Fri,  8 Aug 2025 11:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eiHJrS/G"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C4A25D8F0;
	Fri,  8 Aug 2025 11:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754653269; cv=none; b=mLugFBIkS8eY66Ey1Rvtg5o4Ai9hao2Rv74htGoOy3JO32xYeKj8hREUrJ/aB7fIef22KQ0AccKkKmbHJhhOk6nmQfWruVS6kKcm5qd1rOdFICWgFGGGVBe71Wnaow77knLoi+ynrl0sqEGKAx0CRpOPO1yvhrCBhKWUhdtqTqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754653269; c=relaxed/simple;
	bh=/fH4duGoHe/rkBCDfE8+YUuEtMoGs25+J2LCOCU7aIs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ayuXhkolgYebLWX9xA3yLHwFK8AD8HEf6WL3toElsApev29HMlSd1VJF2wVV6p9+OBSSjglqRsCUze6cnSMc9PtMQSW2BLHY/C4CFacbOdbzi9i2eYgdCAA0dn7qOsBGD9zRbGI65Rbic4nHrnA/DO2VCGjIO9EDpA3XTOKvzpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eiHJrS/G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D69A0C4CEED;
	Fri,  8 Aug 2025 11:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754653269;
	bh=/fH4duGoHe/rkBCDfE8+YUuEtMoGs25+J2LCOCU7aIs=;
	h=From:Subject:Date:To:Cc:From;
	b=eiHJrS/G/4kOxM5oWbSeUcEPDS++vnKG5lyxeI7syt+aeEoR5eYF/j0yDuwd4IUma
	 6a+5ecVimYW1w6reZ3+89bC2xPgeMv+R1vdjCSOHu5QLeJUnyWBLdIQa7DuC56SjNL
	 MnIXryntJyRAhLvrY6ksXTEGtSjmohOZ0u6BSFA8AIAiecaSibJGK3Gr2N2rruJarH
	 YxX4+ZBPNeKEQIIpGTCI9ohd7Le503XvoAKr0xY/xaLtmydNltt6TIGMNkl3TLsdLl
	 m28iTjDVFhFRR/EA31zbwC/2LoiAKPK8vPMaDyKpnx+4yp9l+zebSiLf485af5sbax
	 rAUCLnJPUDxPQ==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH 0/5] nfs: more client side tracepoints in write and
 writeback codepaths
Date: Fri, 08 Aug 2025 07:40:29 -0400
Message-Id: <20250808-nfs-tracepoints-v1-0-f8fdebb195c9@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAC3ilWgC/x3MQQqAIBBA0avErBM01KSrRAvJsWaj4UQE4t2Tl
 m/xfwXGQsiwDBUKPsSUU4caB9hPnw4UFLphkpORTs4iRRZ38TtemdLNIqrgtHLWWB2gV1fBSO9
 /XLfWPnXieiZhAAAA
X-Change-ID: 20250807-nfs-tracepoints-f1d84186564d
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=911; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=/fH4duGoHe/rkBCDfE8+YUuEtMoGs25+J2LCOCU7aIs=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBoleJOQ/Zvsh45ZmfhXy9PDXE4ZymveEyMCwFdg
 luDFCyu1kqJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaJXiTgAKCRAADmhBGVaC
 FcnyEACI4JvVXfSg4lcXbE7w+g4d6mOneb47bxMckLAi22driLROFNKvdLADSpJeQnceG2Kb6+W
 FSSDJkSFx80dYod5fNr4diZqos2R/3Qlv8h604ry/knE8USqCPHaoQnhu0XDrRCRLC3KQtu6GWF
 I42R1njGcaF0MdccCkdTmbuHE4dbBnKRjMtOeSckI06ntbx6ifBpWtVXlczR1P1ztt4KEr1kPzH
 9HZUUyH8iu5rxQI3BCkn8BtBh8kcIUFEBTaE4jszYErBFgLljOzjaqW4tEI28beYtGssdjkeiMP
 KIxQT9U15sf3IK/fN/MGHbviYGxVz2+6biGP8DUECd7/3Q61vQoCBs/1dGYx14YogwenMkHC5bD
 AXjuLBaED5LH3aZU2KgqFl/fYzZ+qsAVfXIWltRNbjGhJ5zS9raclkpr9cqxiTtYW0I5Ryj9SS9
 Fkykrw0qlr0tYaXcUg7y61vmxyA+U+qnmyBJQf/EKRZtfEPOiTaHCfVkTm7tMovVmgpljnNXPn4
 DsnlXkqKKq1DY4qWJ5LEgFD5oPsBJpTGLZGsacZw7JD/ZXRBNR63q2MxsOtVb4+QPfyXwnmsBCL
 bWXXkXyGbZrRS4sJ44GwzOVNpamc55VckB2xEsslJeBjvg9f/rJtChf4MNm0wZtyIu0TZqNEcXb
 XBpWhnU7h7mOfCw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

This is a pile of tracepoint additions and cleanups. Most of these I
plumbed in while tracking down the recent client-side corruption I've
been hunting. Please consider for v6.18.

Thanks,

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Jeff Layton (5):
      nfs: remove trailing space from tracepoint
      nfs: add tracepoints to nfs_file_read() and nfs_file_write()
      nfs: new tracepoints around write handling
      nfs: more in-depth tracing of writepage events
      nfs: add tracepoints to nfs_writepages()

 fs/nfs/file.c     |  20 ++++++--
 fs/nfs/nfstrace.h | 135 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 fs/nfs/write.c    |  22 +++++++--
 3 files changed, 168 insertions(+), 9 deletions(-)
---
base-commit: 0919a5b3b11c699d23bc528df5709f2e3213f6a9
change-id: 20250807-nfs-tracepoints-f1d84186564d

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


