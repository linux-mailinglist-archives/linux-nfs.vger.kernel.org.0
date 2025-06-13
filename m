Return-Path: <linux-nfs+bounces-12453-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35C57AD95E6
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Jun 2025 22:08:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AD8E18872FB
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Jun 2025 20:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF5AD23D28A;
	Fri, 13 Jun 2025 20:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aJzHwG74"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA052235066
	for <linux-nfs@vger.kernel.org>; Fri, 13 Jun 2025 20:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749845277; cv=none; b=P2imT9d3dIP6D6AWGoe3zjUGiNIsaH12+ttZzgddFbqGrz4mxMGWcUz9BWazWFay5xc3ua0PGQzpT141FjMZpy/HN0iZpMBu0TOL6HomSreyl84j1bTtqr3FvivZ3awJlLoKwC6ARi2gjEjU+dZoDUkgGtrpmLyyZ3Nbys/jhuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749845277; c=relaxed/simple;
	bh=7ktAHYzLzmCYcZlR5ywBvfi8uaJU0sGEze++XhpGc48=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uiqvma0qZ7GQVTl0KaZ3qmCpTIpdjLh9hCXaS8l5+BIdQGHXW6jOYqjV2+IACXMSPrmi7M1OGAKiESh/JBgBrU4CxP3rzJffZwlUy7C6q6NNP8y/C3zdC18pJIspoFXSdbbj08tecrl9GmQ4QBmnwyKIT7MrPMLCs4m+6DNXhq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aJzHwG74; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9178DC4CEE3;
	Fri, 13 Jun 2025 20:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749845277;
	bh=7ktAHYzLzmCYcZlR5ywBvfi8uaJU0sGEze++XhpGc48=;
	h=From:To:Cc:Subject:Date:From;
	b=aJzHwG74EPu9ZZMT4GH5LO7v70WvI/h/Vj0Hfk/oIr9DgGw4VoeeAhCAvxYjI1VsC
	 WCw28VWDmsrFXRZT7blTkodBXF32rflXpvutPsGE0sf2C+pBJ+/kn2f/fpQV6Lkkpe
	 ia6UnmBD+pi8YrxEk3uevvJRabVWxm8hHayWQ6Jav/fsIeB7DedYo9bwuwJtzm2IU6
	 lpft0WPeoURR+x/djPQFlPSwDAyCGR36/+F6Y9KJZPgqz88suXN3VA8yk9ZlcfZLgx
	 xZatpEx9G0h3OUmp8oRHrZnCW/dmKgNQvaHoUiX2kY+53qcLL0j2i8zjtyoijFUiZm
	 QiQDbhNW+CLlg==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH v1 1/5] NFSD: Remove definition for trace_nfsd_file_unhash_and_queue
Date: Fri, 13 Jun 2025 16:07:43 -0400
Message-ID: <20250613200747.7110-1-cel@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

trace_nfsd_file_unhash_and_queue() was removed by commit ac3a2585f01
("nfsd: rework refcounting in filecache").

Reported-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/trace.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index b244c6b3e905..93875c7ba358 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -1108,7 +1108,6 @@ DEFINE_NFSD_FILE_EVENT(nfsd_file_free);
 DEFINE_NFSD_FILE_EVENT(nfsd_file_unhash);
 DEFINE_NFSD_FILE_EVENT(nfsd_file_put);
 DEFINE_NFSD_FILE_EVENT(nfsd_file_closing);
-DEFINE_NFSD_FILE_EVENT(nfsd_file_unhash_and_queue);
 
 TRACE_EVENT(nfsd_file_alloc,
 	TP_PROTO(
-- 
2.49.0


