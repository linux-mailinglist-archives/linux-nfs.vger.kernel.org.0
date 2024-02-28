Return-Path: <linux-nfs+bounces-2106-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 704BE86A74F
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Feb 2024 04:46:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F36D128AEE1
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Feb 2024 03:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7D7B200DD;
	Wed, 28 Feb 2024 03:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="KNmHzAgm";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="WppRTDEu";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="KNmHzAgm";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="WppRTDEu"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E564200BF
	for <linux-nfs@vger.kernel.org>; Wed, 28 Feb 2024 03:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709092008; cv=none; b=ttsphkjGHlNjQo6vXxMsQweCJ9UN4Dm7/nhJVwwTUD/8hGI9BkjlDSXThBjwZC/qHy5YWWLNf3GeqA+i7P76Tw+Iw6gnMIfKeLFn9JOVzkJWNOY5uHo9UTKX9nX2MVQ/LHinsn1+spJj0WHpa6xH2H0gVtqMe3VtDkiroyIOATc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709092008; c=relaxed/simple;
	bh=yvKas0Ab0XqYUA75hi1epw5HhhTsDkJnbY7CNh6OKQw=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:Date:Message-id; b=FWPM6miRrHzy8VY3WqR8e6qnRJwELYWpYjizoTzbD1kdTARLG0y/EWPTs5IY23weq76BrbpqGBLT1J4+ysYOcf1oZQffhLLAYWpWfIBpOUuIq/MV8a1PVQzZ9GeIhRfiFl74dwIhHC8jLtC6I4dDaLR0v2z3ixSO2tWDbzFVhMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=KNmHzAgm; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=WppRTDEu; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=KNmHzAgm; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=WppRTDEu; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6C4D51FDD1;
	Wed, 28 Feb 2024 03:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709092004; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=t9sTw1PRmiNuisHTI3BarLYfTjqSvjbDL11Ef7Irnz8=;
	b=KNmHzAgmBwvHXWF9wLphN/9FP++bsj3Z+8o+dhfK975GdGdgesujiPD+bfCBNRPR2c6mEb
	y0/zJJHuXCg43XxjN/PUGnfKGpjSuF5/5JZMdQNe/OmNAnljktKw9Zyc/0xuF5Iu/i9xMI
	txDgjjiIats8rHBkjyLMJAOxOuRvfjU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709092004;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=t9sTw1PRmiNuisHTI3BarLYfTjqSvjbDL11Ef7Irnz8=;
	b=WppRTDEukzhD6tDnd4mRpVkz/uz86sjdfREeWP3x+ag+LB4FUfo7qSgvvaspQFTz02w+yb
	t/wqoK/pa2W/LXAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709092004; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=t9sTw1PRmiNuisHTI3BarLYfTjqSvjbDL11Ef7Irnz8=;
	b=KNmHzAgmBwvHXWF9wLphN/9FP++bsj3Z+8o+dhfK975GdGdgesujiPD+bfCBNRPR2c6mEb
	y0/zJJHuXCg43XxjN/PUGnfKGpjSuF5/5JZMdQNe/OmNAnljktKw9Zyc/0xuF5Iu/i9xMI
	txDgjjiIats8rHBkjyLMJAOxOuRvfjU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709092004;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=t9sTw1PRmiNuisHTI3BarLYfTjqSvjbDL11Ef7Irnz8=;
	b=WppRTDEukzhD6tDnd4mRpVkz/uz86sjdfREeWP3x+ag+LB4FUfo7qSgvvaspQFTz02w+yb
	t/wqoK/pa2W/LXAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8221B13A92;
	Wed, 28 Feb 2024 03:46:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KOoMCaKs3mVRZgAAD6G6ig
	(envelope-from <neilb@suse.de>); Wed, 28 Feb 2024 03:46:42 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: Trond Myklebust <trond.myklebust@hammerspace.com>,
 Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, Zhitao Li <zhitao.li@smartx.com>
Subject:
 [PATCH] NFS: Restore -EIO as error to return when "umount -f" aborts request.
Date: Wed, 28 Feb 2024 14:46:38 +1100
Message-id: <170909199843.24797.6320949640369986924@noble.neil.brown.name>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-0.10 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -0.10


When "umount -f" is used to abort all outstanding requests on an NFS
mount, some pending systemcalls can be expected to return an error.
Currently this error is ERESTARTSYS which should never be exposed to
applications (it should only be returned due to a signal).

Prior to Linux v5.2 EIO would be returned in these cases, which it is
more likely that applications will handle.

This patch restores that behaviour so EIO is returned.

Reported-and-tested-by: Zhitao Li <zhitao.li@smartx.com>
Closes: https://lore.kernel.org/linux-nfs/CAPKjjnrYvzH8hEk9boaBt-fETX3VD2cjjN=
-Z6iNgwZpHqYUjWw@mail.gmail.com/
Fixes: ae67bd3821bb ("SUNRPC: Fix up task signalling")
Signed-off-by: NeilBrown <neilb@suse.de>
---
 include/linux/sunrpc/sched.h | 2 +-
 net/sunrpc/clnt.c            | 2 +-
 net/sunrpc/sched.c           | 6 +++---
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/sunrpc/sched.h b/include/linux/sunrpc/sched.h
index 2d61987b3545..ed3a116efd5d 100644
--- a/include/linux/sunrpc/sched.h
+++ b/include/linux/sunrpc/sched.h
@@ -222,7 +222,7 @@ void		rpc_put_task(struct rpc_task *);
 void		rpc_put_task_async(struct rpc_task *);
 bool		rpc_task_set_rpc_status(struct rpc_task *task, int rpc_status);
 void		rpc_task_try_cancel(struct rpc_task *task, int error);
-void		rpc_signal_task(struct rpc_task *);
+void		rpc_signal_task(struct rpc_task *, int);
 void		rpc_exit_task(struct rpc_task *);
 void		rpc_exit(struct rpc_task *, int);
 void		rpc_release_calldata(const struct rpc_call_ops *, void *);
diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index cda0935a68c9..cdbdfae13030 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -895,7 +895,7 @@ void rpc_killall_tasks(struct rpc_clnt *clnt)
 	trace_rpc_clnt_killall(clnt);
 	spin_lock(&clnt->cl_lock);
 	list_for_each_entry(rovr, &clnt->cl_tasks, tk_task)
-		rpc_signal_task(rovr);
+		rpc_signal_task(rovr, -EIO);
 	spin_unlock(&clnt->cl_lock);
 }
 EXPORT_SYMBOL_GPL(rpc_killall_tasks);
diff --git a/net/sunrpc/sched.c b/net/sunrpc/sched.c
index 6debf4fd42d4..e4f36fe16808 100644
--- a/net/sunrpc/sched.c
+++ b/net/sunrpc/sched.c
@@ -852,14 +852,14 @@ void rpc_exit_task(struct rpc_task *task)
 	}
 }
=20
-void rpc_signal_task(struct rpc_task *task)
+void rpc_signal_task(struct rpc_task *task, int err)
 {
 	struct rpc_wait_queue *queue;
=20
 	if (!RPC_IS_ACTIVATED(task))
 		return;
=20
-	if (!rpc_task_set_rpc_status(task, -ERESTARTSYS))
+	if (!rpc_task_set_rpc_status(task, err))
 		return;
 	trace_rpc_task_signalled(task, task->tk_action);
 	set_bit(RPC_TASK_SIGNALLED, &task->tk_runstate);
@@ -992,7 +992,7 @@ static void __rpc_execute(struct rpc_task *task)
 			 * clean up after sleeping on some queue, we don't
 			 * break the loop here, but go around once more.
 			 */
-			rpc_signal_task(task);
+			rpc_signal_task(task, -ERESTARTSYS);
 		}
 		trace_rpc_task_sync_wake(task, task->tk_action);
 	}
--=20
2.43.0


