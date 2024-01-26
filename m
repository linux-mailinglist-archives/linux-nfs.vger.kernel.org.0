Return-Path: <linux-nfs+bounces-1493-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C09883E0CE
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jan 2024 18:47:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F02B61F235B9
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jan 2024 17:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDD0C208B8;
	Fri, 26 Jan 2024 17:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s/bhFtCA"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A76208AF
	for <linux-nfs@vger.kernel.org>; Fri, 26 Jan 2024 17:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706291137; cv=none; b=AomHI2cLaNcQ6dy3wkipu21R8MywP+vDQIjSqOwB2Sl7II6bQAXthh8pKCo+n83Pc9P9BrzcsebzuyAmUO49EPMjMIp37v/R6RtGTcMZvFe4VppJYwo/sg2cZUI7VAak731ldQBnowSV1mADpRImagWv/e3O1ISZzTijqhKPpbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706291137; c=relaxed/simple;
	bh=VAqV5QdMwCWU4OPpYvQoSiOmWp1CcqeLrzhrccIsBx0=;
	h=Subject:From:To:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sQTZZVKFwpz13+UDkParGSSM4jVmdcNL4Hwd8YKcIW/erxTTDAgAEovFrQuJMXEl9zmnR7D5hV3Vbap1WFeJzGVcpdZ7RL6QM0g6Oe8eXWXvki0da2wur+5nNa1aIQ9OTSssU5SDVt1+tHcPW67aNEzbrv9cXfL9KZDnBfUqWI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s/bhFtCA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F11EC433F1
	for <linux-nfs@vger.kernel.org>; Fri, 26 Jan 2024 17:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706291137;
	bh=VAqV5QdMwCWU4OPpYvQoSiOmWp1CcqeLrzhrccIsBx0=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=s/bhFtCAl8yGTDSx/3g4p4lrw5yqeeziEmdqFRg2DYlj4GXDBV1RsJ1bary+OZNwg
	 uJcEXhWM8bgm4IZMunGWNvMi8rBhhagtFZ7PI4CZ1F5hEILRQNfLzts8n3gRSVCSKV
	 FJHFn8805y+v8mJTiA0rRDBkH0ZIzCNWZMQgeh29tsHpGiElgahMC8/xHoGeDMwBlm
	 2Z1PW/Ria+LiyCsaLJOL7xRFzL/uFP0OaQAEGLq8Mnjg9PydI49OVGhF4T2kN8lK1s
	 WbfJWRGy8k9sJXGQ+7gQQIGEnknHmscEnKu6YpLLR95/1NzZLpnzMfE7vPbDVFKFzO
	 FIl4Y2QovDTAw==
Subject: [PATCH 2 04/14] NFSD: Retransmit callbacks after client reconnects
From: Chuck Lever <cel@kernel.org>
To: linux-nfs@vger.kernel.org
Date: Fri, 26 Jan 2024 12:45:36 -0500
Message-ID: 
 <170629113601.20612.5705156104404285555.stgit@manet.1015granger.net>
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

NFSv4.1 clients assume that if they disconnect, that will force the
server to resend pending callback operations once a fresh connection
has been established.

Turns out NFSD has not been resending after reconnect.

Fixes: 7ba6cad6c88f ("nfsd: New helper nfsd4_cb_sequence_done() for processing more cb errors")
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4callback.c |   13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index 389d05985c52..3bff14241b3c 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -1178,12 +1178,21 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
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



