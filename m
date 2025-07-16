Return-Path: <linux-nfs+bounces-13113-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E66B07A84
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Jul 2025 17:59:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AB691AA52D9
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Jul 2025 15:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED0692F49EF;
	Wed, 16 Jul 2025 15:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AlX+fCQN"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C997129E0EE
	for <linux-nfs@vger.kernel.org>; Wed, 16 Jul 2025 15:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752681560; cv=none; b=tNC+vLzumjetvK2Zdt0py6V1w1l8HVfjyzRDhAD3oUgZoir1hs+svW5NCgbKy9krJimRA59Ouyq2Kt0s3EHhNrve/HHnq0EjcZIFntj42YlJlLJqN2BYWeYsCItd2l/WciSJRK8FXFGaykJ7ZXWXJ4RDDxpwX1dYV+WzkekVbsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752681560; c=relaxed/simple;
	bh=Qu9Ow2wRUwQ8+Cm2NuUK1r3HWZylK0O7QMqRs/XBC7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I6x+l1ub+V3hEanH5Z6+7a5ASVwHt3B7sqDPFRZKLxJDBrUXJWH9WU4LfX8zCVvt3VQOOCcK6JL58jgSDHrtxKmocccWHoUb612TeQgtmBLqzsEfJI9rWlQ5oyJ8QzZi7aZkbRGg4L/M8K7Cyz2kN53skt3hKL9ieVsWVYHrJOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AlX+fCQN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3797C4CEE7;
	Wed, 16 Jul 2025 15:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752681560;
	bh=Qu9Ow2wRUwQ8+Cm2NuUK1r3HWZylK0O7QMqRs/XBC7Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AlX+fCQNcuLdO6mirNmX0/fA+U8yGQgU5bVUhl9sCDOadyboRsw4kqsE/VkXKLtZX
	 RrkryrmqVq0KE4JninLnUDrnqFjeCpCW3Z6+xGcy9PCf+FwmW5mYpIbe7G/xL2Nyrl
	 tarU++6ppud76Z0Z4FJHe3gOFqhd3Dqjy681KVeDaXipzd8EESU36POmoSK+FyJq3N
	 iqyLhx+DXVEFQVzp5SjJ8yp3BmGGze1vGCekMvM0Qz9Ht/kRMRos3UZg137izCdLLK
	 EEf02F8DyWRbNu/7987F8KB/izV7567R1GADwJ5LlXIT5gT2AB1bSzmHJw/N1+/HXC
	 86DBQlWYQyADg==
From: Trond Myklebust <trondmy@kernel.org>
To: Anna Schumaker <anna.schumaker@oracle.com>
Cc: NeilBrown <neil@brown.name>,
	Mike Snitzer <snitzer@kernel.org>,
	linux-nfs@vger.kernel.org
Subject: [PATCH v2 0/3] Fix localio hangs
Date: Wed, 16 Jul 2025 08:59:15 -0700
Message-ID: <cover.1752671200.git.trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1752618161.git.trond.myklebust@hammerspace.com>
References: <cover.1752618161.git.trond.myklebust@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

The following patch series fixes a series of issues with the current
localio code, as reported in the link
https://lore.kernel.org/linux-nfs/aG0pJXVtApZ9C5vy@kernel.org/


Trond Myklebust (3):
  NFS/localio: nfs_close_local_fh() fix check for file closed
  NFS/localio: nfs_uuid_put() fix races with nfs_open/close_local_fh()
  NFS/localio: nfs_uuid_put() fix the wake up after unlinking the file

 fs/nfs_common/nfslocalio.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

-- 
2.50.1


