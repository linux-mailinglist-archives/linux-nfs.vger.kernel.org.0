Return-Path: <linux-nfs+bounces-9702-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56E51A20021
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Jan 2025 22:51:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5A97165954
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Jan 2025 21:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 782381D88DB;
	Mon, 27 Jan 2025 21:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G1port5d"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527AC1DA4E
	for <linux-nfs@vger.kernel.org>; Mon, 27 Jan 2025 21:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738014658; cv=none; b=QJ2HekYJreCH/OmQyF4iEOrZozWTcG7J8fNMg+x/6EU17zRvK9R1k1vsQdN39kEUPM6FmnrcJu2T3X8JldNw5bXsyUdTlwjpiRmqq8jLy2+EGGQmFMFIcpk5VqT5eYoR8PtNOG7TR9AHmaTVjV8GXGPfc67iZZLzuzN5+o1N9LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738014658; c=relaxed/simple;
	bh=R3VCQPFiS6UQm9/fQxm+KYdWemvh4Fi0DRVFmMAsZtQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H0otThRVtJFSF9g1tW8/LHdloDL4lunrG3gZ6o2CjsmRMA47Xe3vvFTZ1LK2Kc1N+fbQ5UMS5vjvRWWSvDDJeSsBYf4bBhJr3e1C78gHZpNINmBDnrLbR+xZTtJOergbliUmwXzIAwqHNCv+Anap8NrHFNzYq4RRDOrLzHM0NRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G1port5d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49891C4CED2;
	Mon, 27 Jan 2025 21:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738014657;
	bh=R3VCQPFiS6UQm9/fQxm+KYdWemvh4Fi0DRVFmMAsZtQ=;
	h=From:To:Cc:Subject:Date:From;
	b=G1port5dbxGMfNuAvXgnT3K5x7HQ5ZknOWK5uNjV5Fpqpxe+Std9jW3zTJ2ojXzzP
	 lf0EUubAZQxLm/AoDUNkK3/r+gebNh1mQ2qnaWhLHcoIWarxf0zDhKbJWDl1HbTWZB
	 kROJhmr0NjgU4t5QmCJfrq3z8Xzl1nJGfldB1CWGu7AjAS2NVpCM2KxAeDYQDw01NQ
	 VxGI6tBltCU2LNGdcQ+kgjad4uIF5ws1MhG2zD9eelw+4zVPPRbFyv18MtZHQvGFQd
	 8uWqzNxhO1OoyGX3rRo0x8Bwd7KlSekwsFHB0j0HxqkhL+ZAzZqz0T/iKTpENPQ86H
	 zoqzO/0nYedaA==
From: Anna Schumaker <anna@kernel.org>
To: linux-nfs@vger.kernel.org,
	steved@redhat.com
Cc: anna@kernel.org
Subject: [PATCH nfs-utils v2 0/4] rpcctl: Various Improvements
Date: Mon, 27 Jan 2025 16:50:52 -0500
Message-ID: <20250127215056.352658-1-anna@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Anna Schumaker <anna.schumaker@oracle.com>

These patches depend on the corresponding kernel patches posted at the
same time. They update the rpcctl tool to use the new sunrpc sysfs
features, in a backwards compatible way that will run on older kernels.

v2:
 * Update `rpcctl client` output to include rpc program and version

Thanks,
Anna

Anna Schumaker (4):
  rpcctl: Rename {read,write}_addr_file()
  rpcctl: Add support for the xprtsec sysfs attribute
  rpcctl: Display new rpc_clnt sysfs attributes
  rpcctl: Add support for `rpcctl switch add-xprt`

 tools/rpcctl/rpcctl.man |  4 ++++
 tools/rpcctl/rpcctl.py  | 50 ++++++++++++++++++++++++++++-------------
 2 files changed, 38 insertions(+), 16 deletions(-)

-- 
2.48.1


