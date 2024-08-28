Return-Path: <linux-nfs+bounces-5869-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 347E8962EAA
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Aug 2024 19:40:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6289281A60
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Aug 2024 17:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FCBD1A7068;
	Wed, 28 Aug 2024 17:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kzX6bDGR"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B58F1A4F15
	for <linux-nfs@vger.kernel.org>; Wed, 28 Aug 2024 17:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724866817; cv=none; b=LibHlWDmvJqNF06nrm/W4Y8ps9AdaIhv4eTglH+zpIyG95Bf4npTtP1LVNwiXb54FMCi4h3hKCylQQKgrFejypNAo9tYGBAIigbPrvuPCquJedTnLX1KuLVW5JpGaWtysPWTHa/A+H6bLIKSQIGwOjincXfgab2zfp5FiUcgBko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724866817; c=relaxed/simple;
	bh=oKbO+JltJlOnXD4peAa6mLTPzL9OzrmLezFkCPts63g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EDNi8/bGhPYxlBccPb1t96hB8zHGs+UXh2lHi8jUV7lMt07Y8ERzZGmV9zyubi3J6o/2cocq/l+KPgyxKL0dwX1pbjHefwFnTygKgdHctWUujicrQ9i9o4IlpaF0O9qFCpkT6T4kWhusNGhx3CkIU7uf60kThR7TApWBlhS1+gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kzX6bDGR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9280EC4CEC2;
	Wed, 28 Aug 2024 17:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724866817;
	bh=oKbO+JltJlOnXD4peAa6mLTPzL9OzrmLezFkCPts63g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kzX6bDGRq3zLEbY7LbnB8R8FA0NgpRL0T0mGdadA/A8LV3Eh+Eb4oVfG5ra6qQBRZ
	 SfiCtSQvZYFUptGLp3T9hGTrj08BQIOhM1TILxG0hSEo15QkeJdmHuFOFsrXQSN5Ai
	 k/eSf3wJl/ucKWB0pSA04qQfoJKiBNWSqGijsNjvuFNSDEK7zcNfUVKxf4gfFzYlsj
	 8+UATAuuOnOHXpPD28q42B0QnZFl1Qxq/m6UKOOGo3rCPXeKwDovGvJzOI5kbmiuEB
	 4ngMGnhjSI5hQ26Xq3lPNxTjVkR6hFi0Mo5oBDd+AbmGdmSVTsG8lqrDya+TnCzv3z
	 4IrFm1QRXtW9w==
From: cel@kernel.org
To: <linux-nfs@vger.kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [RFC PATCH 3/7] NFSD: Display copy stateids with conventional print formatting
Date: Wed, 28 Aug 2024 13:40:05 -0400
Message-ID: <20240828174001.322745-12-cel@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240828174001.322745-9-cel@kernel.org>
References: <20240828174001.322745-9-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1421; i=chuck.lever@oracle.com; h=from:subject; bh=/y9b7DgVsvjf36gzPBQSIiSN73wExXN0lZK9iTtABsc=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBmz2D67dZmsuz44/APgh8zvzLvEBaiELbr4E2Kr nSHc2wWng+JAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCZs9g+gAKCRAzarMzb2Z/ l2MWD/0VtT6mx6mk01vQR+xvYLl2snL0L/ATQbSkKIiFhj4xdamY0qE7koyoMSi9TaeFhEENRgk AUaGouCXS+WCZfNHGfXhOFPMV2avop7sJ95vNkHed3WPRX/6dI5xND1c2fpWcFzG52V9ePWToz3 ClxtCZoAvjrFhNyNtaNZXIovAwkkTHkXegvgMW+yNWWmGFFykfPWL2xIg62qut/xfZiadeKEcJN fRU3PNSLWet72AexMW/mypWHxMhyU3S0PJeb5dJ0hwxGeF7BZ8tOJS1PROqkfjawlvVBz1eul52 rvj3yjnlShkP+GOPdNTpqCUDQNdeojbdXKLeP5wusoBs1fQ/6Eye8HTTSe7/4PD6V4dRfxhZglG VrrOeAWGI9UL5MDmL4mit3D1pk1t9vQf9v5P+PZd/urDsoU2nJCcG/+CyzSnOTWHsx+rJlvOAiv klDz0oWOx123qMyq3ihkeUgc2NPqxXsXxfvF1Al6U0wjWHXxGI/sudHFE+MjI+ZRpDzzuAYK0Pe igmYtUQDOgNVmMDoztZeU736ccQtVIetvdUtfR+BFKKI5Ji9gQvkdzXqkWM/chJxmRsG7ninFPb ccY3KNFFX6RQHiJrboomQ2YHSpNq5iKXQ7j/yg6siDWGWWw2RemQVoO3sHV3cpR/Wxq7DABHFTj meIDgyIhxR1pttg==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Make it easier to grep for s2s COPY stateids in trace logs: Use the
same display format in nfsd_copy_class as is used to display other
stateids.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/trace.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index 77bbd23aa150..e61109d97b4e 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -2153,14 +2153,14 @@ DECLARE_EVENT_CLASS(nfsd_copy_class,
 				sizeof(struct sockaddr_in6));
 	),
 	TP_printk("client=%pISpc intra=%d async=%d "
-		"src_stateid[si_generation:0x%x cl_boot:0x%x cl_id:0x%x so_id:0x%x] "
-		"dst_stateid[si_generation:0x%x cl_boot:0x%x cl_id:0x%x so_id:0x%x] "
+		"src_client %08x:%08x src_stateid %08x:%08x "
+		"dst_client %08x:%08x dst_stateid %08x:%08x "
 		"cp_src_pos=%llu cp_dst_pos=%llu cp_count=%llu",
 		__get_sockaddr(addr), __entry->intra, __entry->async,
-		__entry->src_si_generation, __entry->src_cl_boot,
-		__entry->src_cl_id, __entry->src_so_id,
-		__entry->dst_si_generation, __entry->dst_cl_boot,
-		__entry->dst_cl_id, __entry->dst_so_id,
+		__entry->src_cl_boot, __entry->src_cl_id,
+		__entry->src_so_id, __entry->src_si_generation,
+		__entry->dst_cl_boot, __entry->dst_cl_id,
+		__entry->dst_so_id, __entry->dst_si_generation,
 		__entry->src_cp_pos, __entry->dst_cp_pos, __entry->cp_count
 	)
 );
-- 
2.46.0


