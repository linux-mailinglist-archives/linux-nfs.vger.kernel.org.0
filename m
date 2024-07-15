Return-Path: <linux-nfs+bounces-4893-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B217930F0D
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Jul 2024 09:47:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AEE33B20DF3
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Jul 2024 07:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E09184126;
	Mon, 15 Jul 2024 07:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xtmcQQbi";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="kQdnXnS8";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xtmcQQbi";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="kQdnXnS8"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13CB01836E6
	for <linux-nfs@vger.kernel.org>; Mon, 15 Jul 2024 07:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721029660; cv=none; b=ETOHGFNVD3Tox/ucks80qwPZIzqRsNnvlIR1L2VbdJsOWLFppKuFpdNWiQhhKeEmBRyNN/BZMFPaGhxrb3Hijf58g46M/sjkrZaI6Um27dCdPsFsHFJyg+SWcxe5LgFpgTN6/Qdn6ZTHBtbqf7G2sL4afeWMBL8kwPNDFxnWsgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721029660; c=relaxed/simple;
	bh=zb2KPj+r/OjAmUGPqWtkD2QKRgTxnfpygHbihaCSNVA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h6zgeeiTox+2XojHXbnnJKe+GifPtPX38FOoImKGN4KNn2RIhbiqO7Y+k9s7/JWAAg4HW6gwxqJWj0owNTrc7Iqr4HMDYfbTRwcH/sUT3eeiBAml5gnXi6Fu5FdGdS0Tt0ah5HAJtSl357VrvvCueO8N4tiEiPFtLAIE1ao9/sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xtmcQQbi; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=kQdnXnS8; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xtmcQQbi; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=kQdnXnS8; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 24F621F80B;
	Mon, 15 Jul 2024 07:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721029657; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+v14Rt4o3037+hhkNelW3hokj1y8/ArfmyTgs9MokJQ=;
	b=xtmcQQbifjxY6bO8JPrWN3OmDaKa1fSIZXO0KXf+owUsBJXHN7NtjL36Ct97kyyyCfBfwX
	Tc3Hz2nHWy35IZPVOcQnA29s3GlnLrvpnjse06KjMvtu8wY0wv/HMQ3Cc2rdUTc0MhTH/H
	XvzxGc3rXD9PRxKUJnGoqYfwmET1By4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721029657;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+v14Rt4o3037+hhkNelW3hokj1y8/ArfmyTgs9MokJQ=;
	b=kQdnXnS842/0hquhPvhNfkZwGJ7/H0OXbgRmsfUd8OQa0aWsnmHHfGoFNZLTyuQWXxjTDM
	naGWGD7wemfTqnAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721029657; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+v14Rt4o3037+hhkNelW3hokj1y8/ArfmyTgs9MokJQ=;
	b=xtmcQQbifjxY6bO8JPrWN3OmDaKa1fSIZXO0KXf+owUsBJXHN7NtjL36Ct97kyyyCfBfwX
	Tc3Hz2nHWy35IZPVOcQnA29s3GlnLrvpnjse06KjMvtu8wY0wv/HMQ3Cc2rdUTc0MhTH/H
	XvzxGc3rXD9PRxKUJnGoqYfwmET1By4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721029657;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+v14Rt4o3037+hhkNelW3hokj1y8/ArfmyTgs9MokJQ=;
	b=kQdnXnS842/0hquhPvhNfkZwGJ7/H0OXbgRmsfUd8OQa0aWsnmHHfGoFNZLTyuQWXxjTDM
	naGWGD7wemfTqnAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B1F99137EB;
	Mon, 15 Jul 2024 07:47:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6f7fGRbUlGa2bQAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 15 Jul 2024 07:47:34 +0000
From: NeilBrown <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <kolga@netapp.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Steve Dickson <steved@redhat.com>
Subject: [PATCH 01/14] lockd: discard nlmsvc_timeout
Date: Mon, 15 Jul 2024 17:14:14 +1000
Message-ID: <20240715074657.18174-2-neilb@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240715074657.18174-1-neilb@suse.de>
References: <20240715074657.18174-1-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 

nlmsvc_timeout always has the same value as (nlm_timeout * HZ), so use
that in the one place that nlmsvc_timeout is used.

In truth it *might* not always be the same as nlmsvc_timeout is only set
when lockd is started while nlm_timeout can be set at anytime via
sysctl.  I think this difference it not helpful so removing it is good.

Also remove the test for nlm_timout being 0.  This is not possible -
unless a module parameter is used to set the minimum timeout to 0, and
if that happens then it probably should be honoured.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/lockd/host.c             | 2 +-
 fs/lockd/svc.c              | 7 +------
 include/linux/lockd/lockd.h | 2 +-
 3 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/fs/lockd/host.c b/fs/lockd/host.c
index c11516801784..5e6877c37f73 100644
--- a/fs/lockd/host.c
+++ b/fs/lockd/host.c
@@ -440,7 +440,7 @@ nlm_bind_host(struct nlm_host *host)
 	if ((clnt = host->h_rpcclnt) != NULL) {
 		nlm_rebind_host(host);
 	} else {
-		unsigned long increment = nlmsvc_timeout;
+		unsigned long increment = nlm_timeout * HZ;
 		struct rpc_timeout timeparms = {
 			.to_initval	= increment,
 			.to_increment	= increment,
diff --git a/fs/lockd/svc.c b/fs/lockd/svc.c
index ab8042a5b895..71713309967d 100644
--- a/fs/lockd/svc.c
+++ b/fs/lockd/svc.c
@@ -53,7 +53,6 @@ EXPORT_SYMBOL_GPL(nlmsvc_ops);
 static DEFINE_MUTEX(nlmsvc_mutex);
 static unsigned int		nlmsvc_users;
 static struct svc_serv		*nlmsvc_serv;
-unsigned long			nlmsvc_timeout;
 
 static void nlmsvc_request_retry(struct timer_list *tl)
 {
@@ -68,7 +67,7 @@ unsigned int lockd_net_id;
  * and also changed through the sysctl interface.  -- Jamie Lokier, Aug 2003
  */
 static unsigned long		nlm_grace_period;
-static unsigned long		nlm_timeout = LOCKD_DFLT_TIMEO;
+unsigned long			nlm_timeout = LOCKD_DFLT_TIMEO;
 static int			nlm_udpport, nlm_tcpport;
 
 /* RLIM_NOFILE defaults to 1024. That seems like a reasonable default here. */
@@ -333,10 +332,6 @@ static int lockd_get(void)
 		printk(KERN_WARNING
 			"lockd_up: no pid, %d users??\n", nlmsvc_users);
 
-	if (!nlm_timeout)
-		nlm_timeout = LOCKD_DFLT_TIMEO;
-	nlmsvc_timeout = nlm_timeout * HZ;
-
 	serv = svc_create(&nlmsvc_program, LOCKD_BUFSIZE, lockd);
 	if (!serv) {
 		printk(KERN_WARNING "lockd_up: create service failed\n");
diff --git a/include/linux/lockd/lockd.h b/include/linux/lockd/lockd.h
index 1b95fe31051f..61c4b9c41904 100644
--- a/include/linux/lockd/lockd.h
+++ b/include/linux/lockd/lockd.h
@@ -200,7 +200,7 @@ extern const struct svc_procedure nlmsvc_procedures[24];
 extern const struct svc_procedure nlmsvc_procedures4[24];
 #endif
 extern int			nlmsvc_grace_period;
-extern unsigned long		nlmsvc_timeout;
+extern unsigned long		nlm_timeout;
 extern bool			nsm_use_hostnames;
 extern u32			nsm_local_state;
 
-- 
2.44.0


