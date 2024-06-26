Return-Path: <linux-nfs+bounces-4339-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26D07918E5B
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Jun 2024 20:25:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 807FDB22798
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Jun 2024 18:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F86119068C;
	Wed, 26 Jun 2024 18:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W03JxCvH"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD87190661
	for <linux-nfs@vger.kernel.org>; Wed, 26 Jun 2024 18:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719426298; cv=none; b=asHnPVA7lnWfDi5DnaoX7jp9eXBA5CHwEMZfNfiPLdXPeRxA+lUuxpHPFRtPGUU3aR1AvMBHL4OAtapa1ldMLtx3h8XxHZPhcsSS7dtT6eHiD2XpXcmScW4xgwfNHXYT/mhrVGTPjJAMaeue/zIQnEecd7oATu42fMAcocHQJJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719426298; c=relaxed/simple;
	bh=qE34YemZGEe9NkSzdbrQmELxaCXOmZqaZhtvaeoYnMA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=twngvT4CJRMfY9FWEdjLp7o4BhkjVBDwt4kJCXTwBNna1532yR+M4pFvYZa5cH3vv7z1IDM/JiX80TpK/8lFfGGow7Hh1ixl17Vsw2vjUab+pFwMvLRFVm/gSGosXU3oFjiZ+gcvt6HGR3SA1FH3pO0qIEFAjEe7oa8gQ9knSvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W03JxCvH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2737CC32782;
	Wed, 26 Jun 2024 18:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719426298;
	bh=qE34YemZGEe9NkSzdbrQmELxaCXOmZqaZhtvaeoYnMA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W03JxCvHGljHKE8xj4B7HTBwb6o/OSyzinZJbzbP3a0S9Bgzj5mMn8s1uOYbN2eWW
	 ORsBxK3bE+8T+soBn0vc5KOKQAbmfep66nu6ZF2gRdws0nWzpizFTWsfuPoSjMImzk
	 iqzBaKRbmR6Am13rnW6ttWTPctYwwewt/pYWFJI2OA6OExKc7nexldVbJOBzyqFnPQ
	 8fm3R/4nPjLEHrQmTAfSwXjxUg8KELVnWARS0JHls6wKQ2LfdvIyj3BRT9dPaVlVZL
	 31GvJ3tl5GoJxEI700NKeYCNoZ/FyW8cIAm/iNkM8dd22GmglfzzwWP6Q9g1NRVidP
	 1mpoz6ObZrDMA==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>,
	snitzer@hammerspace.com
Subject: [PATCH v8 14/18] SUNRPC: remove call_allocate() BUG_ON if p_arglen=0 to allow RPC with void arg
Date: Wed, 26 Jun 2024 14:24:34 -0400
Message-ID: <20240626182438.69539-15-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240626182438.69539-1-snitzer@kernel.org>
References: <20240626182438.69539-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is needed for the LOCALIO protocol's GETUUID RPC which takes a
void arg.  The LOCALIO protocol spec in rpcgen syntax is:

/* raw RFC 9562 UUID */
typedef u8 uuid_t<UUID_SIZE>;

program NFS_LOCALIO_PROGRAM {
    version LOCALIO_V1 {
        void
            NULL(void) = 0;

        uuid_t
            GETUUID(void) = 1;
    } = 1;
} = 400122;

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 net/sunrpc/clnt.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index cfd1b1bf7e35..2d7f96103f08 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -1894,7 +1894,6 @@ call_allocate(struct rpc_task *task)
 		return;
 
 	if (proc->p_proc != 0) {
-		BUG_ON(proc->p_arglen == 0);
 		if (proc->p_decode != NULL)
 			BUG_ON(proc->p_replen == 0);
 	}
-- 
2.44.0


