Return-Path: <linux-nfs+bounces-12455-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 854B6AD95E8
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Jun 2025 22:08:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B70821750B4
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Jun 2025 20:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5EDA2343B6;
	Fri, 13 Jun 2025 20:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P9MM+LHu"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE5C22DF9E
	for <linux-nfs@vger.kernel.org>; Fri, 13 Jun 2025 20:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749845279; cv=none; b=cxaJo/3m/ItN2C70It4ehq6BDQJQwOG9di3JMNQTqhwymOrX9fwxLu8yb3om2AO7Wd2vIJRzrxqPECb0aapi3WQFWnZPjLfLiWIv3qni2/pkgoxeND4Jpi/VFk+GSPQghKxKuDJIiZGcTshGd+hp2O5TulRjl+hk5VQkV9iCFxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749845279; c=relaxed/simple;
	bh=ax5MYncJf+uWFJIOALsSjdGI80+DJwVCgqSTqxgIyZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lRH7oMqJXt+UV3X3f1iEpczWyWj+bvPvCKvBpaLVjle61YB+aq7p92Mg3c0VPPgO6KvQlqqz/GM9zJwJ4HHl5Ca1nsMkG9ozygyC9Y5cYSHQQDYY/K56rvNwyqMHjfMbjvFOzkkzSF0mtRrrVG2yrEeHBPkwV7QbsU0B/WuZLCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P9MM+LHu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A876C4CEE3;
	Fri, 13 Jun 2025 20:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749845279;
	bh=ax5MYncJf+uWFJIOALsSjdGI80+DJwVCgqSTqxgIyZU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P9MM+LHuzdrFA90J2B9AFn8wBijGxiyDtENM45OtdfY8DlGIwjKB4nRj1lTZL5emC
	 Dr0BZKUXatRw9wY/6hMBrF9bvEZSYCMWIdh53LdVXy9Tv+51tUHsBYlYxikg/Tsizz
	 PI4omVlgehWi0plI3SsmxqVbGa0aZucNLmXywdMsvFvddcWe0b6MPiSSm8wOYuerOB
	 YyCfyU0hctemhs+CaFlQIAYVrMN6qToPrFYyBcSCNdv5sxu9cvQlJZP7NVJhszDMVz
	 pdwrtRADGujqewUqWE3Wu6KWK1JSasDhq0ormwy/W6wKId8+t13Q5nh5rCxQkI1uNb
	 bdpR/MEUQ7OTw==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH v1 3/5] NFSD: Remove definition for trace_nfsd_file_gc_recent
Date: Fri, 13 Jun 2025 16:07:45 -0400
Message-ID: <20250613200747.7110-3-cel@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250613200747.7110-1-cel@kernel.org>
References: <20250613200747.7110-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Event nfsd_file_gc_recent was added by commit 64912122a4f8 ("nfsd:
filecache: introduce NFSD_FILE_RECENT") but never used.

Reported-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/trace.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index 79a18a694d46..693d3d8fcdce 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -1377,7 +1377,6 @@ DEFINE_EVENT(nfsd_file_lruwalk_class, name,				\
 	TP_ARGS(removed, remaining))
 
 DEFINE_NFSD_FILE_LRUWALK_EVENT(nfsd_file_gc_removed);
-DEFINE_NFSD_FILE_LRUWALK_EVENT(nfsd_file_gc_recent);
 DEFINE_NFSD_FILE_LRUWALK_EVENT(nfsd_file_shrinker_removed);
 
 TRACE_EVENT(nfsd_file_close,
-- 
2.49.0


