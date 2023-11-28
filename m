Return-Path: <linux-nfs+bounces-148-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8542B7FC8FA
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Nov 2023 23:01:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17678B20ED5
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Nov 2023 22:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BEE844C80;
	Tue, 28 Nov 2023 22:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kw4XuXFf"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6CA42A8B;
	Tue, 28 Nov 2023 22:01:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D13A6C433C7;
	Tue, 28 Nov 2023 22:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701208885;
	bh=RV9g/t2EzQc2GBGpQK9UoK2EhzhDRy66qZFeOv/BhaA=;
	h=Subject:From:To:Cc:Date:From;
	b=Kw4XuXFfYqHzDH+NzjqBrz/FIG3JqcD1g9AlFie0njtgQYACIuOilOkcxyaCMToPS
	 ZS3+XBT09pHm3z3PrWhtmkB5ylRWAF7gB7ZmBkvzXYGU0UrLJuPbQIidt06JPhNVdf
	 GId9elFruIbbhtcy2HuKkciee0U1MJIkzIfVkNRtscvUPa3jtlhlKpScRZyZEDBNbg
	 bXdqrYd7axdrd/zD8B1O8VxaB7iOoyTgSe3YFo4+Q7cQruWx+ZNrn+W7WtEOpGa4WE
	 xw53HmOztPfwE5jzVbkIUmVZCHt6QM46+FUJEmkXti8sVCYK3aax5eT3kpUuHzQeAf
	 fT80mlT6Wrfyw==
Subject: [PATCH 0/2] nfsd fixes for 6.1.y
From: Chuck Lever <cel@kernel.org>
To: stable@vger.kernel.org
Cc: linux-nfs@vger.kernel.org
Date: Tue, 28 Nov 2023 17:01:22 -0500
Message-ID: 
 <170120886349.1725.10740679467794019580.stgit@klimt.1015granger.net>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Backport of upstream fixes to NFSD's duplicate reply cache. These 
have been hand-applied and tested with the same reproducer as was 
used to create the upstream fixes.

---

Chuck Lever (2):
      NFSD: Fix "start of NFS reply" pointer passed to nfsd_cache_update()
      NFSD: Fix checksum mismatches in the duplicate reply cache


 fs/nfsd/cache.h    |  3 ++-
 fs/nfsd/nfscache.c | 65 +++++++++++++++++++++++++++++++---------------
 fs/nfsd/nfssvc.c   | 15 +++++++++--
 3 files changed, 59 insertions(+), 24 deletions(-)

--
Chuck Lever


