Return-Path: <linux-nfs+bounces-1496-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC8D83E0D1
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jan 2024 18:47:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08A0F1F23A1C
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jan 2024 17:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 953A620B09;
	Fri, 26 Jan 2024 17:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jXf5SHsV"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B1120B03
	for <linux-nfs@vger.kernel.org>; Fri, 26 Jan 2024 17:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706291156; cv=none; b=Tkn4CyEeH204gEXy3H7hVAVvlNzrC2bjTDOXASfZZrsaCQvReA6bAKH5twFmYdohTbtKhPdm+xFtKqm7BF3l6BwH1QnCd4oxiuj2RrBeaMh7ujFLj4ittc+mQdPMxLBk0CinYiUTcipWChPiQgK34ZgFTqJE4UixQt8pvqJqFbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706291156; c=relaxed/simple;
	bh=sGj1/p7XKLYshUz/QjtvupKf/QrZ0KM4wFbwT5oXQys=;
	h=Subject:From:To:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G2k6kQqmA6Xo2p98d+GTi5WUYf3wQgGF3Wm9GiHusFZ8ynTerq4y9gB2BfW0dbqBpjwUh58w2cH/D/2SmNtm4HqcnM8hT40DMOGIM3v1VYvI9KJLRLih+oiZXbpT+kLfXd+YQM7gwBMQAivJF3xTu0+nSvXkAgNfHn6gsL/+9Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jXf5SHsV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEA7CC433C7
	for <linux-nfs@vger.kernel.org>; Fri, 26 Jan 2024 17:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706291156;
	bh=sGj1/p7XKLYshUz/QjtvupKf/QrZ0KM4wFbwT5oXQys=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=jXf5SHsV2SwiKr1gVVO5TRhSohPe9fCurGGQVjIFgOO6Fl1X+nD0IiM+o77vHEt2V
	 IegN8/7R1CIGVzkDiUU0SHJHCNYwwb+RCJoJ+6oOjoTnXNEBJHNjMrOnTK2Ru+J4UM
	 jfTwVlp6pAFX2dKvXYklVcAOP4cwerPYH7mPCWYwYk8TvPg0bktcZS+ME/AnE7gTzy
	 2iyLeR7BIqNYK7e4JZiYmvSj/f/bb7CsAJ6NVMJdVNJq5jqOSe3ylBBwJ9UybP/zr2
	 FST48bDo/Qd8jR+gRx7H3Fnw48yLSzHGse42Kj5/cStIZWMTDUibul7A/yoyuBNAtr
	 f+GYXKYzKnR+w==
Subject: [PATCH 2 07/14] NFSD: Rename nfsd_cb_state trace point
From: Chuck Lever <cel@kernel.org>
To: linux-nfs@vger.kernel.org
Date: Fri, 26 Jan 2024 12:45:54 -0500
Message-ID: 
 <170629115495.20612.14499519793163904716.stgit@manet.1015granger.net>
In-Reply-To: 
 <170629091560.20612.563908774748586696.stgit@manet.1015granger.net>
References: 
 <170629091560.20612.563908774748586696.stgit@manet.1015granger.net>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Chuck Lever <chuck.lever@oracle.com>

Make it clear where backchannel state is updated.

Example trace point output:

kworker/u16:0-10    [006]  2800.080404: nfsd_cb_new_state:    addr=192.168.122.6:0 client 65b3c5b8:f541f749 state=UP
         nfsd-940   [003]  2800.478368: nfsd_cb_new_state:    addr=192.168.122.6:0 client 65b3c5b8:f541f749 state=UNKNOWN
kworker/u16:0-10    [003]  2800.478828: nfsd_cb_new_state:    addr=192.168.122.6:0 client 65b3c5b8:f541f749 state=DOWN

kworker/u16:0-10    [005]  2802.039724: nfsd_cb_start:        addr=192.168.122.6:0 client 65b3c5b8:f541f749 state=UP
kworker/u16:0-10    [005]  2810.611452: nfsd_cb_start:        addr=192.168.122.6:0 client 65b3c5b8:f541f749 state=FAULT
kworker/u16:0-10    [005]  2810.616832: nfsd_cb_start:        addr=192.168.122.6:0 client 65b3c5b8:f541f749 state=UNKNOWN
kworker/u16:0-10    [005]  2810.616931: nfsd_cb_start:        addr=192.168.122.6:0 client 65b3c5b8:f541f749 state=DOWN

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4callback.c |    4 +++-
 fs/nfsd/trace.h        |    3 ++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index 78d9939cf4b0..a63171ccfc2b 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -1006,7 +1006,7 @@ static void nfsd4_mark_cb_state(struct nfs4_client *clp, int newstate)
 {
 	if (clp->cl_cb_state != newstate) {
 		clp->cl_cb_state = newstate;
-		trace_nfsd_cb_state(clp);
+		trace_nfsd_cb_new_state(clp);
 	}
 }
 
@@ -1390,6 +1390,8 @@ nfsd4_run_cb_work(struct work_struct *work)
 	struct rpc_clnt *clnt;
 	int flags;
 
+	trace_nfsd_cb_start(clp);
+
 	if (clp->cl_flags & NFSD4_CLIENT_CB_FLAG_MASK)
 		nfsd4_process_cb_update(cb);
 
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index c134c755ae5d..6003af2bee33 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -1371,7 +1371,8 @@ DEFINE_EVENT(nfsd_cb_class, nfsd_cb_##name,		\
 	TP_PROTO(const struct nfs4_client *clp),	\
 	TP_ARGS(clp))
 
-DEFINE_NFSD_CB_EVENT(state);
+DEFINE_NFSD_CB_EVENT(start);
+DEFINE_NFSD_CB_EVENT(new_state);
 DEFINE_NFSD_CB_EVENT(probe);
 DEFINE_NFSD_CB_EVENT(lost);
 DEFINE_NFSD_CB_EVENT(shutdown);



