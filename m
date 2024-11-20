Return-Path: <linux-nfs+bounces-8159-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D61FE9D4260
	for <lists+linux-nfs@lfdr.de>; Wed, 20 Nov 2024 20:13:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 823531F21B6B
	for <lists+linux-nfs@lfdr.de>; Wed, 20 Nov 2024 19:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2E2A15E5D4;
	Wed, 20 Nov 2024 19:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KQao2wO+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A491F931;
	Wed, 20 Nov 2024 19:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732129999; cv=none; b=fSeGftuBxd+LrguA3KNI+oFUhTnKlr29SpVUfxdEL8HA2eO72Hl/AMnc1oh9y3LK62JfhsPh+VMt0HHk/UyQg4bvOAYwCDH6RGiIVL8V1AOVXPdZ6VrVMyXdKfAoOC3KVJdYHLHkhi2fExFEPwRR9FRvL0YorrLopiHAJYALkI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732129999; c=relaxed/simple;
	bh=H3LrQ9fkIallpsUHzUCoT6m++0lVjMjeE2LNNAGpGkk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L8zrUPZ5+d20qsRSATCraH0f7U6Sgl+MsnaRXHt+UgnJa6nnABp1iFpuC1gzrDIN4guCwfsdKcA8oILmS36mhQ9s2mOJ5/nz3v28b9mObaCWQNr+4RxhKHRJT3GH3qZVVddmi1PfSjvUwy2bpVyYpEDwBmQ1Y8Pjg3XHlg/QtTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KQao2wO+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E5B1C4CECD;
	Wed, 20 Nov 2024 19:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732129998;
	bh=H3LrQ9fkIallpsUHzUCoT6m++0lVjMjeE2LNNAGpGkk=;
	h=From:To:Cc:Subject:Date:From;
	b=KQao2wO+V81pvCCq0FYD85TryPgB+b7PL4jqjX92U4w+diMX6bCbQxWycPgfLDacW
	 oLaXic8FiU7HF43HQKHWsPyEY6ERizPrfOvHx4X4gadyMMgwjsAdnMqyBe2aftRLc8
	 b5CgmSv5YvAC6oF6NafkwEuTEET7WCtftii4a7GS4Sik+TdgfLwVgQD4/8fa/jtI9W
	 wNIfieArZ6YG+VeYS7d7ZLrrK9KMibnDzAp7TSjvpPFBl4/8GcEmx5yLHhx5Lodt/C
	 NqO2bRnILTByTuVNT408uVsavk3hzgVAjnVHAce7wPn1rgt39l+Xn7vllpCu/7aU2q
	 KzPnVBZ97kbHQ==
From: cel@kernel.org
To: <stable@vger.kernel.org>
Cc: <linux-nfs@vger.kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 5.4 0/1] Address CVE-2024-49974
Date: Wed, 20 Nov 2024 14:13:14 -0500
Message-ID: <20241120191315.6907-1-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Backport the upstream patch that disables background NFSv4.2 COPY
operations.

Unlike later LTS kernels, the patches that limit the number of
background COPY operations do not apply at all to v5.4. Because
there is no support for server-to-server COPY in v5.4, disabling
background COPY operations should not be noticeable.

Chuck Lever (1):
  NFSD: Force all NFSv4.2 COPY requests to be synchronous

 fs/nfsd/nfs4proc.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

-- 
2.47.0


