Return-Path: <linux-nfs+bounces-11293-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61BA9A9DC1A
	for <lists+linux-nfs@lfdr.de>; Sat, 26 Apr 2025 18:05:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF4AF3A3979
	for <lists+linux-nfs@lfdr.de>; Sat, 26 Apr 2025 16:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F4B425C83E;
	Sat, 26 Apr 2025 16:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZZTAI6dr"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F471C36;
	Sat, 26 Apr 2025 16:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745683533; cv=none; b=OM3PY+jtV1ciG22msTEW5cFQMCEaUQys9ffSkXL5T8ZLOx0ufd/sTGvlUvvAcKhtdjIUsUULSm+xYxyBMUpPgB5Qh6/4BXRjKsaMf8rh5VdZEQEC9ylTi1oe0gteCLz0i10NGW9San1QjS/rAyG+Q3F1Tn7uKoAvQuk6AGAujQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745683533; c=relaxed/simple;
	bh=xan2qxjdMJOzG0gyDi5jgCZcUJJpvz5TZiWFb+2Jl6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=afWo2vwcp7uWhomTR472iDL/QYO/Ezzaeg1ZIWAcN5bdSZIML5EVbtjqtmqojqEp/EWC5Vy8Q+900LHnldeFUB9mVpq+uBfkXk1elLeLJKeEAgEh2rwzdNUFAmIh62jljjyBfzHSi9UAEFfLcwSlfgZtlUAncYx0XuP/Nscdasc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZZTAI6dr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58998C4CEE2;
	Sat, 26 Apr 2025 16:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745683532;
	bh=xan2qxjdMJOzG0gyDi5jgCZcUJJpvz5TZiWFb+2Jl6Y=;
	h=From:To:Cc:Subject:Date:From;
	b=ZZTAI6dr0oYRwNxa9VlMkNKahV92b91AsYYyPjPgiIFUMC3KCRQZB6RJlJxbK2Or/
	 plKqr/o07Fdyi2wvAs2HzCKnhVpug1U1oZm1n3nLhikQZ1AoeiJyW91rFhl9C3413Q
	 9ixlDQqVZX7MPmK4PUnFhQjSZPjCrdYzYdahfCuvd4I5rd4HwIU+4C5j+50FAlAda4
	 6OodNijLgtc2j9B5QlsyDRtfK1TVxqzTNSrFEpeplyfDPRCk9yxgbfzRrJbgQovYYD
	 DnMRoA0hB0HJGm+leK6Kwnasz7kL0Y+lPfDuKy7C2MryksP3WvQ8Sqn86YsYUAIYIv
	 aU2ok0zFGpOQQ==
From: cel@kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: <linux-nfs@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	Jeff Layton <jlayton@kernel.org>
Subject: [GIT PULL] 2nd round of NFSD fixes for v6.15
Date: Sat, 26 Apr 2025 12:05:31 -0400
Message-ID: <20250426160531.5466-1-cel@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit a1d14d931bf700c1025db8c46d6731aa5cf440f9:

  nfsd: decrease sc_count directly if fail to queue dl_recall (2025-04-13 16:39:42 -0400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.15-2

for you to fetch changes up to 831e3f545b0771f91fa94cdb8aa569a73b9ec580:

  Revert "sunrpc: clean cache_detail immediately when flush is written frequently" (2025-04-26 12:00:43 -0400)

----------------------------------------------------------------
nfsd-6.15 fixes:

- Revert a v6.15 patch due to a report of SELinux test failures

----------------------------------------------------------------
Chuck Lever (1):
      Revert "sunrpc: clean cache_detail immediately when flush is written frequently"

 net/sunrpc/cache.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

