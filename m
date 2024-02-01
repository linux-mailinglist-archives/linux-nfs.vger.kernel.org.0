Return-Path: <linux-nfs+bounces-1694-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF599845A2B
	for <lists+linux-nfs@lfdr.de>; Thu,  1 Feb 2024 15:24:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB2AB29393F
	for <lists+linux-nfs@lfdr.de>; Thu,  1 Feb 2024 14:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF3835CDF8;
	Thu,  1 Feb 2024 14:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uvbAMLL3"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8055626AB;
	Thu,  1 Feb 2024 14:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706797404; cv=none; b=QAIOYeG3ATQmiND+OHp5hPgR9aLCk65BfM0mHAKhkbL8ZVmazjrlUqJ+3XvSUCVQBAEVtpAckk7kfJ0tU76km7xwYNtvDIkw1CQZOO3T3teC71DI4dSzNByUkKd4+P77vYjRwyiBxbEsdXRXYgzn8LEOn0wGRysq61H9g3uBJAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706797404; c=relaxed/simple;
	bh=Nq84jGy45615xyRA015jQnO68sRciJmxyZT1LGxCDLE=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=V27PJVbPA8xsul/gKqUqLs7Bknol6W9vbbqYA260YjUNha3ek++9Ko5i4mEmi7cYetNLiKZ28qzT1MARqp5CdPetc0qiKz/Xr3wKbJ+FBm8Bqadd8i5CywEvq9QLlMU//PigAWVE0LrHVnP+DiJPEXXYHxQBXqxJijytF6uQOho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uvbAMLL3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B692C433C7;
	Thu,  1 Feb 2024 14:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706797404;
	bh=Nq84jGy45615xyRA015jQnO68sRciJmxyZT1LGxCDLE=;
	h=Subject:From:To:Cc:Date:From;
	b=uvbAMLL3cNPUJqXZX3cTRn0zckFNZoRpcKXKonIy7Oqgrk4jnZK5Wqyf2/rH7Txm+
	 N/JJFwNStZLRh5BM+Pv0dfjeJb01f0mixKbDV2XMWbUTLK5EEX2IDjHGKOxiUzJHOe
	 mCfhohVNTVgwv1eI4ZdjQ7P5p58uAYJ13j8QbWS6z2Se36nzEWfofnnm5jxS1d8v7r
	 SrYOJ1mHaeQ9p7hTYVNxYxV1C30ZaJ2O50cd5UiDqT1Cw94unk3hrhTz4HkN+t8XZY
	 fA4PS1kAmulOxcxmK/Rx62HZ0ZxyIrENZGNcdxbS9l8PJ5smkKrBA8em/69qaLGyWg
	 pUi9lZ5plls0g==
Subject: [PATCH 0/3] Fix RELEASE_LOCKOWNER
From: Chuck Lever <cel@kernel.org>
To: stable@vger.kernel.org
Cc: linux-nfs@vger.kernel.org
Date: Thu, 01 Feb 2024 09:23:23 -0500
Message-ID: <170679738225.14195.77163641928598673.stgit@klimt.1015granger.net>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Passes pynfs, fstests, and the git regression suite. Please apply
these to origin/linux-5.10.y.

---

Chuck Lever (2):
      NFSD: Modernize nfsd4_release_lockowner()
      NFSD: Add documenting comment for nfsd4_release_lockowner()

NeilBrown (1):
      nfsd: fix RELEASE_LOCKOWNER


 fs/nfsd/nfs4state.c | 65 +++++++++++++++++++++++++--------------------
 1 file changed, 36 insertions(+), 29 deletions(-)

--
Chuck Lever


