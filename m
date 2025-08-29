Return-Path: <linux-nfs+bounces-13951-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5DA6B3C164
	for <lists+linux-nfs@lfdr.de>; Fri, 29 Aug 2025 18:57:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77CFD56686A
	for <lists+linux-nfs@lfdr.de>; Fri, 29 Aug 2025 16:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60BA233EAEA;
	Fri, 29 Aug 2025 16:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NbUWKXUK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3EE33EAE5
	for <linux-nfs@vger.kernel.org>; Fri, 29 Aug 2025 16:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756486665; cv=none; b=D7P+guX+yycah0uPdXMsjSe+zuTu9ufgHGBUfs56uvaMQGQCuxaha09PX1Jvy/G5lbqoOxsKvZxkEQYZsDDxwMsW+XmRr6tPnRyRQQgR3RPhLhAlIRlq435qQvwSsct+wLOBa2KKDl0BGTPI6AMCADMhRV+Bl9hzAIdr7W66Vgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756486665; c=relaxed/simple;
	bh=VM/llPWZiefyqxVler3a4Unpmzm4a9DzyXZ835CCeG8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Eu1E8ivH6tvM1jr9IbJXItofb3EfNnQPAmVfUxEnXNAZAlrH7ea5U4VxQmiu6dp/zbrslux3+Z3V8w9KqeetaOdiiL1XUKGz+pR4wnBr1tm/EEEIvqQcsBNxF4w/hy6JLbesDf1OY5p1+Fi5fAkSYpyMjuy4plpTG5agBfPNQ+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NbUWKXUK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A2E6C4CEF0;
	Fri, 29 Aug 2025 16:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756486664;
	bh=VM/llPWZiefyqxVler3a4Unpmzm4a9DzyXZ835CCeG8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=NbUWKXUKgNx3cYIZNid8S8bg3IQJMp8S5TqvLB3r6uD9Q0iTHzf8Z9VIQGtDXrimO
	 sI1T6BbzSi218trxs1I+GOn/R0nYEei9La+/qy3YaC5xQURbP9ar9FihE4eYtx8AwG
	 NEfqyjB0m1ZpbkIF5QBCzqUIhrTi0A1oQXtK7rX91nlKVxA8ZV/ZUDRih9ftEancB9
	 0lFLozNicnan+D6hFt4Lc2Jj4ff0Bk40FRt2Gv3Av4ah+qKQ7B/RPCPgpeo136rHLj
	 kWIk5zHd9n6GN8vQMY+DQbVPCKb45GN++ycKGvqEHEy4k6FqgnyQ3qT07UUgh37AFZ
	 cBge/qWTupK/g==
From: Trond Myklebust <trondmy@kernel.org>
To: linux-nfs@vger.kernel.org,
	Scott Haiden <scott.b.haiden@gmail.com>
Subject: [PATCH 0/4] More server capability fixes
Date: Fri, 29 Aug 2025 12:57:38 -0400
Message-ID: <cover.1756486626.git.trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <528e7a88-9c63-43d4-8c67-50a36ceda8a7@gmail.com>
References: <528e7a88-9c63-43d4-8c67-50a36ceda8a7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Fix more issues where the client's server capability tracking is
failing.

Trond Myklebust (4):
  NFSv4: Don't clear capabilities that won't be reset
  NFSv4: Clear the NFS_CAP_FS_LOCATIONS flag if it is not set
  NFSv4: Clear NFS_CAP_OPEN_XOR and NFS_CAP_DELEGTIME if not supported
  NFSv4: Clear the NFS_CAP_XATTR flag if not supported by the server

 fs/nfs/client.c   | 2 ++
 fs/nfs/nfs4proc.c | 7 ++++---
 2 files changed, 6 insertions(+), 3 deletions(-)

-- 
2.51.0


