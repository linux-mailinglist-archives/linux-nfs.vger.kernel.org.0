Return-Path: <linux-nfs+bounces-1389-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E8A3183C7F4
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jan 2024 17:29:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79C71B23AD5
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jan 2024 16:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAEBE7762A;
	Thu, 25 Jan 2024 16:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GoMHj3ok"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7EDC73177
	for <linux-nfs@vger.kernel.org>; Thu, 25 Jan 2024 16:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706200140; cv=none; b=ER7zVd66zxp2Y7nqBRQp+6Bulx0q/sZi3vIhTE4LNxCtY2rErH9nsVck3V0quKAUVl1iMSnSSDVuuvAwx0Aw1pRc1iU9lKVDLCCewGzg8jz11+oxGpXxiNkPkNuDD0UW7AieKM8Duh4sh8JkcloWlIGdaBPd//t0Mwb8ndzbE7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706200140; c=relaxed/simple;
	bh=vlt3M4RIx68QmXCQCc6F6OIkuYYv9j05uwrzFmKuN+M=;
	h=Subject:From:To:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=alwJzdc+ZK3GYn45pNjTG+j/a6M55yA9NzMgBTWCFbHxAiuno6jP4QPGLzLhRnMv82c2m5k7/VtEfjuSpmg4uRpfPa2tY35VOBDMKf3KDLfXQG7p215v1Pp2S1SQFqvAbaWPUyMGkIiTvA+9pcB+He99x7xFyF89mkSYMpkNQ38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GoMHj3ok; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18DD0C433C7
	for <linux-nfs@vger.kernel.org>; Thu, 25 Jan 2024 16:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706200140;
	bh=vlt3M4RIx68QmXCQCc6F6OIkuYYv9j05uwrzFmKuN+M=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=GoMHj3okixJ33RDYmAo2Psb+QNRr1R0X84PYEmFNqpEsNMt3FLJzRy+Zb3v44n0JT
	 kojFsntXr7v65cPKleCGFevwAx0PKXI7k9wZhtcbx6gDCFfWLclnZWrGUpetsxBUYq
	 AUVC1YzLVT76dQt15Jels7AgntVAvzblfxWoGBH7pNheEGjtnGAaJO9E01iEWsVHet
	 Ot0jqJE4EyqaeVvWPhf2fP4Ul6y/SMqbTUe5NBr4p7cxHosAitftkL8NvXaSB+Sgu8
	 YKXhlkpe0b1St2iRWBLe4WwHlJ5VjJktO8gx3DIFm52kPg1SI4L0ZBMuVD39WJmruA
	 4ko39OzjjL2Bg==
Subject: [PATCH RFC 03/13] NFSD: Retransmit callbacks after client reconnects
From: Chuck Lever <cel@kernel.org>
To: linux-nfs@vger.kernel.org
Date: Thu, 25 Jan 2024 11:28:58 -0500
Message-ID: <170620013890.2833.522544267659511118.stgit@manet.1015granger.net>
In-Reply-To: 
 <170619984210.2833.7173004255003914651.stgit@manet.1015granger.net>
References: 
 <170619984210.2833.7173004255003914651.stgit@manet.1015granger.net>
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

NFSv4.1 clients assume that if they disconnect, that will force the
server to resend pending callback operations once a fresh connection
has been established.

Turns out NFSD has not been resending after reconnect.

Fixes: 7ba6cad6c88f ("nfsd: New helper nfsd4_cb_sequence_done() for processing more cb errors")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4callback.c |   13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index b2844abcb51f..1ff64efe1f5c 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -1171,12 +1171,21 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
 		break;
 	case -ESERVERFAULT:
 		++session->se_cb_seq_nr;
-		fallthrough;
+		nfsd4_mark_cb_fault(cb->cb_clp, cb->cb_seq_status);
+		ret = false;
+		break;
 	case 1:
+		/*
+		 * cb_seq_status remains 1 if an RPC Reply was never
+		 * received. NFSD can't know if the client processed
+		 * the CB_SEQUENCE operation. Ask the client to send a
+		 * DESTROY_SESSION to recover.
+		 */
+		fallthrough;
 	case -NFS4ERR_BADSESSION:
 		nfsd4_mark_cb_fault(cb->cb_clp, cb->cb_seq_status);
 		ret = false;
-		break;
+		goto need_restart;
 	case -NFS4ERR_DELAY:
 		cb->cb_seq_status = 1;
 		if (!rpc_restart_call(task))



