Return-Path: <linux-nfs+bounces-1387-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A69583C7F2
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jan 2024 17:28:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06347B2333D
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jan 2024 16:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01D4C129A70;
	Thu, 25 Jan 2024 16:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ev8uzAiG"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B2477F02
	for <linux-nfs@vger.kernel.org>; Thu, 25 Jan 2024 16:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706200127; cv=none; b=qzNHzdOJBgx+Y61KIU4NUU2K0kGQPLxiR9bEPh8vwqxXMDup0f8QZQo7TrzSR5L2yJMo99Bm/Ox2kGW/GWMWQZdNbzh3tVoIkmgp6aArBM0qkQVn6TupLvY4tXG9diJNuz89ujyLF/4TJSiBgTrF4ZJU8uqEqX4y+k/0c4A4RXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706200127; c=relaxed/simple;
	bh=hdVGBrnBnC+42GuL+lMf5yaVyqNY2G8EPs25AdfRFjc=;
	h=Subject:From:To:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AtRm7i5NuV1gVvdTsSLTFdXHzA03r3lYQnx7Us0dOqyotZcW2vdRrSFDIo81E1FURrA8a0Mqm9VNmVQnTvF6m1ekT24CRG5B/GLPjQkLlKMP3jbxoLZgSppKLTdwrkGZGKY8nE+KWEoJc6mDUQvEfzKan8fbasT6cG+TVwbBTR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ev8uzAiG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EBF8C433F1
	for <linux-nfs@vger.kernel.org>; Thu, 25 Jan 2024 16:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706200127;
	bh=hdVGBrnBnC+42GuL+lMf5yaVyqNY2G8EPs25AdfRFjc=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=Ev8uzAiGOW8uBZbE8oAc+UF+bGGphf4svIlUFDzedwoNKKbBXV5ncKVQY81g591nN
	 aWcBwO9jnyhInfiGlCDHlzD2ZGtIc4dB5NYvBwU0R8eXr3lkP38OAd85WwluHwtVO7
	 /he18oxvOVBy+fWuPhV0ONAw/yJXRjufluYBU34iA+JmCQaMXAH1N+pXZBO+PeAUaT
	 uQB2u2zLHa4wewmy4CLE11KjAtH3Vm6oWajC5RnIMTITXESFohNQRRn3/EX0VE8Zgg
	 7jVhMRY8owIVG2vyACUf1OQQ24A/wdO3BAvoATUIt0/4ChfhTFF2Wv9jO9fvxCXdW4
	 NWfbTid0MZO9g==
Subject: [PATCH RFC 01/13] NFSD: Reset cb_seq_status after NFS4ERR_DELAY
From: Chuck Lever <cel@kernel.org>
To: linux-nfs@vger.kernel.org
Date: Thu, 25 Jan 2024 11:28:46 -0500
Message-ID: 
 <170620012605.2833.4823193318339130630.stgit@manet.1015granger.net>
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

I noticed that once an NFSv4.1 callback operation gets a
NFS4ERR_DELAY status on CB_SEQUENCE and then the connection is lost,
the callback client loops, resending it indefinitely.

The switch arm in nfsd4_cb_sequence_done() that handles
NFS4ERR_DELAY uses rpc_restart_call() to rearm the RPC state machine
for the retransmit, but that path does not call the rpc_prepare_call
callback again. Thus cb_seq_status is set to -10008 by the first
NFS4ERR_DELAY result, but is never set back to 1 for the retransmits.

nfsd4_cb_sequence_done() thinks it's getting nothing but a
long series of CB_SEQUENCE NFS4ERR_DELAY replies.

Fixes: 7ba6cad6c88f ("nfsd: New helper nfsd4_cb_sequence_done() for processing more cb errors")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4callback.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index 926c29879c6a..43b0a34a5d5b 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -1178,6 +1178,7 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
 		ret = false;
 		break;
 	case -NFS4ERR_DELAY:
+		cb->cb_seq_status = 1;
 		if (!rpc_restart_call(task))
 			goto out;
 



