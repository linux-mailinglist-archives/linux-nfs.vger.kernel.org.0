Return-Path: <linux-nfs+bounces-6531-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AC99A97B2C9
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Sep 2024 18:15:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48275B2B27F
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Sep 2024 16:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB728175D2A;
	Tue, 17 Sep 2024 16:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UAAIdkZ6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5202185930
	for <linux-nfs@vger.kernel.org>; Tue, 17 Sep 2024 16:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726589719; cv=none; b=BD7tsJfYdFJARuZEGNFHDjEXIy7QJVMALw1XbyrkEvx1fhT6G6d6LsRllXmU6+/KgR5iwQ0CdX0hrpJ2h/SyAHhqG02/X6jZx8lsq5cMgutsCkilodcKASFsORy0KZRqJo7rxzp1pcE/R/vOs4zwPWzAY+Nb51278LuS6gaVDSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726589719; c=relaxed/simple;
	bh=TQQNifVDevcAuWSxknauRfYwo5TZ8QjdWYoDqab1VcU=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=IKH7eZPKpgogn07+7sci8lleM1mij/uTj5sus0osxfZyy9w5h1iV6yJlJCDjCM7uv6yVupKHOR5eQKXBx2mDxjXrTRLLu5ONI1j2JVhVxd1pfuXg07pAnpM5Me3i9fV00zpt/1cB9AW8tPMXdNHfe5NfA1HS2528lv3UXlGZI80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UAAIdkZ6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 974FFC4CEC5;
	Tue, 17 Sep 2024 16:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726589718;
	bh=TQQNifVDevcAuWSxknauRfYwo5TZ8QjdWYoDqab1VcU=;
	h=Subject:From:To:Cc:Date:From;
	b=UAAIdkZ6wUnUHKgJThr1nDaIfIo5WciN/B7tsHscapQot0Z1S6wbaLoB/TwRnJlnG
	 w9LTVWNtzFg+c/WYAzFefbC1M49jd8+vVFCuPbdPzz0y2qAwtXEcVnBfKD+ejID55u
	 EsJ0nLqC0fJ5p2k+1rr+AOChX8LEZSgCKzgaN9BJrGGcvMXpnLFzni7OGwSi5SPt36
	 8X+tz0+j/nAPEM/KOPVu6jaOcmGp5oKUy4obYicw8RJ0oWW8SNdYjrKjAMeycYP+tj
	 Jdf31u/vpGOZ9aMbuQrmoRUW5Gr8whOoeasMCUDzh8j3idv8AQhzAd+bS5BE3rZWz9
	 Fzlk5NRPxaBsw==
Subject: [PATCH 0/2] Fix XDR decoder integer overflows
From: Chuck Lever <cel@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: dan.carpenter@linaro.org
Date: Tue, 17 Sep 2024 12:15:17 -0400
Message-ID: 
 <172658941960.2454.16533800561565430909.stgit@oracle-102.chuck.lever.oracle.com.nfsv4.dev>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

As reported yesterday by Dan Carpenter. I plan to apply these for
v6.13. Review comments welcome.

---

Chuck Lever (2):
      NFSD: Prevent a potential integer overflow
      svcrdma: Address an integer overflow


 fs/nfsd/nfs4callback.c                  | 14 +++++++-------
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c |  8 +++++++-
 2 files changed, 14 insertions(+), 8 deletions(-)

--
Chuck Lever


