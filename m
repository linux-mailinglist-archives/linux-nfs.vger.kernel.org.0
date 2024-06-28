Return-Path: <linux-nfs+bounces-4394-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C7F91C7DD
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Jun 2024 23:11:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E7BA1F2367F
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Jun 2024 21:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 383FC7F7FC;
	Fri, 28 Jun 2024 21:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cOF75ZQF"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126CE7F7C6
	for <linux-nfs@vger.kernel.org>; Fri, 28 Jun 2024 21:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719609083; cv=none; b=pa4HUrV2rjChm/rOYkUpmvNb/85thQfbLggCvutMB6OQDYNx4ZJ5IRMz/UsFegRUsG9QRrQOQYS3PCGYzykqtXpIz2GOFvxmiJC3n1tNFT1jLdLqsH8yl4xfuOjFWI3zOvT9KGn6uHMgRTUq7wDBpJDaezPnePp42SUAy3tbt/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719609083; c=relaxed/simple;
	bh=qE34YemZGEe9NkSzdbrQmELxaCXOmZqaZhtvaeoYnMA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ymc2AUGvEL+nS3mJMrPznriTu7cOLVXtvq6lLyiNgtXbjXc0QK1eh9naWNmdaqfrHEtTyQ1VZjPRFpWLUviQbmOWznUdyM1kYwg5n17GaOERVkkXBncevRUSJJLAgm39XvWtSYCZSH8ZpnCEPhvla0DJE0o+QgkBnKjdwm20Dbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cOF75ZQF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE863C116B1;
	Fri, 28 Jun 2024 21:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719609082;
	bh=qE34YemZGEe9NkSzdbrQmELxaCXOmZqaZhtvaeoYnMA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cOF75ZQFfpo5UCthFOE74mQ85ctHq/Zo/xuYSQRUr+2N+IwbDa/PLValsuSQtIsET
	 8Wkjxm2xm7TIxmOnqTlA+wKk5HkKob40/rr7pqGXIm0KyUbyYfBWhsMSBpO5Ik7LD5
	 NtrntxuAZWqb352lePIIJ+L0lilzFAEAtwZr35jtAKHPEDlau4fLM8STqqsJ6nI/QO
	 N8wedPS35iFPYf/W73Iuin71rcJqrqVSWQYALX3ysJFReH6zJuWENcj/Jkd3rQdhwD
	 nQ99RbRMtFJ1iHEJCpad7fWPDhOwtWPpw8pH8DApSe1cqL0BV6rZhbb14EaINrU2AW
	 yUqslbJgosUnw==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>,
	snitzer@hammerspace.com
Subject: [PATCH v9 11/19] SUNRPC: remove call_allocate() BUG_ON if p_arglen=0 to allow RPC with void arg
Date: Fri, 28 Jun 2024 17:10:57 -0400
Message-ID: <20240628211105.54736-12-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240628211105.54736-1-snitzer@kernel.org>
References: <20240628211105.54736-1-snitzer@kernel.org>
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


