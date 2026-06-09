Return-Path: <linux-nfs+bounces-22406-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rMcVJwdOKGqiBwMAu9opvQ
	(envelope-from <linux-nfs+bounces-22406-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 09 Jun 2026 19:31:51 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F04E9662FAB
	for <lists+linux-nfs@lfdr.de>; Tue, 09 Jun 2026 19:31:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=mOsLRsXo;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22406-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22406-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BDFB730086C3
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Jun 2026 17:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5564A47ECC9;
	Tue,  9 Jun 2026 17:24:04 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF5148A2A5
	for <linux-nfs@vger.kernel.org>; Tue,  9 Jun 2026 17:24:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781025844; cv=none; b=Ajw4nbRCgm+MWKsjMp93iOD89yCxZBWMyNlQtz5CDuzDVv+dY/DeaOJx5cgG5rdeCADCabHQVRv7IHQlA0zfX35jDq5Gjf+WW1OobAMKPs6xuAPbQPakuJtZir9oGJ40h71dzy///vyfKjJYUaqkUrlJ5Q+pIaaheb9QXUhERvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781025844; c=relaxed/simple;
	bh=4WIQETbdd7ZVgqTHQyb8NbGqFO8RlIZ/rrczYaaOPrE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ny4kYhEPJGzAYMzYMuBal9kyHgOsphEv0SNlS5jZAcaZ58qds01B8bxnBrYjYqE4gt3Ilbz51w4vzY/KLjNBorIo9xIiRhO23t+xdAxbjCQeQ3kwd6V8pxnVwunK0ibSp+zTc0v0ePACND8nW2r+s4lI7c6N/xfI+I0IzVR7d8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mOsLRsXo; arc=none smtp.client-ip=209.85.167.53
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5aa68dbb38aso5493885e87.2
        for <linux-nfs@vger.kernel.org>; Tue, 09 Jun 2026 10:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781025841; x=1781630641; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kNDHPL4QZCBB2D1DReJErdxEUGCSQvUdM0eZQrbXxbw=;
        b=mOsLRsXo4a3GQD5Jx9ZiPj2za1E6m8Vc2Tu6wVWnD7zCGAI+iUpGTJEHr56GUJn9RJ
         d4Kh2B+XLjMzoHaP7XJakbQKsBhXTT1re9bqUKP/o3IWneTjKESMauyLNXSxNZkNONEa
         e0QQXLflRRS9Uv5AmNnjcWZ05lD8uFJVgjYDey4defHYgbNmI5jrPQZH9MWYFSzG4WUT
         ToT+0ddpjyeTuPoRsZUG/2cCwZwyfnF+glJy1J+J7NkOhRLR7VOQw0ekXg21H34y1+w/
         kdwosRG0yyYKSLL/VOBKRnTPzjqkUskMBLogdcmdcXEHsXMijwgXnQT9ZGZZqFZuG2H8
         Vxkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781025841; x=1781630641;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kNDHPL4QZCBB2D1DReJErdxEUGCSQvUdM0eZQrbXxbw=;
        b=gY6Zmsd4qEmMyCtKhDmfUn48qIgeAGQmHd6Lcmjdv8/zuRvjilec8hdHdTLVaVJx8v
         4EH62SLGbxgKyu7HZKxDFQQiMSd7fIbor6PJiEyapYbzQLiIOOV5Pf776qc86D5JxSSo
         IEJe+EpVfLZBvtY9cU2YyyCqaF3HKNJQKwCWAndBSFmbPlHH6kpw+pO/OYSAvjDdvaDg
         C6C6ZgcZ1Zx3L+G4ShC0CdGxjIrgqkjxOgiKy5309U5w+q7J7HscWGWu/ZjlEnsSOUHB
         kYlNUD2LyW0iOSQSUOe9Sdw6H2wgwX5+oKdPF/zceb5ixtPrVsCbz+xjBwQciiPAm2oT
         A6Gw==
X-Forwarded-Encrypted: i=1; AFNElJ+DEX+P//Qc3ujwUTmvfz3zU05tY+boOB0gs1U3akM6rpJIEaaw0eJinJcsEgCHHthRvIn+J5BxL00=@vger.kernel.org
X-Gm-Message-State: AOJu0YzH1TT1GasaaLhhZDkNq8R2i8vZkQCm7RRrKF8Z+v7LaBG6NU4j
	kMTxFoz+5ka+UH75RSbx4xbAYKpYPif2lQPcWjJisbVuEynlMiN0OQtG
X-Gm-Gg: Acq92OFQ0fppdv1tE27gLVY18nW7DNy7xafcoH6LmSWcXU5wpfLCFi7SNqndPkmLbe3
	WOWZGknPzM8iRlPLLQYxLvzXmgls7qe8EQY5T+6j4UYuat4v77O42ZWvsMqPMMR6k3+P9PHjhrd
	nxztlQwwCmXJ3JN8wq1BNUTafTKQe+FLIx85cmVKLUVf7+1kCumSrbOnhI3R+ZdnFvrFcKlxctn
	L7M5No4ITPqH6otYx09TDG/I4EMo+gqNvWIwLtss/Cin32gNp9pIgzlCl39w7y3jIwCPX8yjpZL
	c9ldXKANIHoDBqqrNe8GBI4yXWY0pAON9HjU1/0ej77Qd6b04BVtCVAcQUq9KDDfYfpEtvCvzbJ
	W0smlCfNA4K+eL/7DDLPB3tH6MzSCCM+aXEL6xCKqA/giuw2mIOisRmMdDsYHhqT/FLxWRnFsaS
	MYnTlpmzH5TN5d+YQeva3eF2jsV5xaKyN1CmZw5wMKKVRd6AoMJohwvYLtpBAjGCnmogBm6sf/Y
	ZrJJAw=
X-Received: by 2002:ac2:4e09:0:b0:5ad:a51:20a8 with SMTP id 2adb3069b0e04-5ad0a512258mr1135766e87.18.1781025840827;
        Tue, 09 Jun 2026 10:24:00 -0700 (PDT)
Received: from c0624c666cc5.devsec.astralinux.ru ([93.188.205.42])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa7b99c11csm4729939e87.78.2026.06.09.10.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 10:23:59 -0700 (PDT)
From: Vladislav Nikolaev <vlad102nikolaev@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Vladislav Nikolaev <vlad102nikolaev@gmail.com>,
	"J. Bruce Fields" <bfields@fieldses.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	lvc-project@linuxtesting.org,
	syzbot+e34ad04f27991521104c@syzkaller.appspotmail.com
Subject: [PATCH 5.10/5.15] nfsd: don't ignore the return code of svc_proc_register()
Date: Tue,  9 Jun 2026 20:23:54 +0300
Message-ID: <20260609172356.1887-1-vlad102nikolaev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22406-lists,linux-nfs=lfdr.de];
	FORGED_SENDER(0.00)[vlad102nikolaev@gmail.com,linux-nfs@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,fieldses.org,oracle.com,vger.kernel.org,kernel.org,brown.name,redhat.com,talpey.com,linuxtesting.org,syzkaller.appspotmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:vlad102nikolaev@gmail.com,m:bfields@fieldses.org,m:chuck.lever@oracle.com,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jlayton@kernel.org,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:lvc-project@linuxtesting.org,m:syzbot+e34ad04f27991521104c@syzkaller.appspotmail.com,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vlad102nikolaev@gmail.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs,e34ad04f27991521104c];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,appspotmail.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F04E9662FAB

From: Jeff Layton <jlayton@kernel.org>

commit 930b64ca0c511521f0abdd1d57ce52b2a6e3476b upstream.

Currently, nfsd_proc_stat_init() ignores the return value of
svc_proc_register(). If the procfile creation fails, then the kernel
will WARN when it tries to remove the entry later.

Fix nfsd_proc_stat_init() to return the same type of pointer as
svc_proc_register(), and fix up nfsd_net_init() to check that and fail
the nfsd_net construction if it occurs.

svc_proc_register() can fail if the dentry can't be allocated, or if an
identical dentry already exists. The second case is pretty unlikely in
the nfsd_net construction codepath, so if this happens, return -ENOMEM.

Reported-by: syzbot+e34ad04f27991521104c@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/linux-nfs/67a47501.050a0220.19061f.05f9.GAE@google.com/
Cc: stable@vger.kernel.org # v6.9
Signed-off-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Vladislav Nikolaev <vlad102nikolaev@gmail.com>
---
Backport fix for CVE-2025-22026
 fs/nfsd/nfsctl.c | 9 ++++++++-
 fs/nfsd/stats.c  | 4 ++--
 fs/nfsd/stats.h  | 2 +-
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index ba2eaf3744ef..cc0dea883fbd 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1460,17 +1460,24 @@ static __net_init int nfsd_init_net(struct net *net)
 	retval = nfsd_stat_counters_init(nn);
 	if (retval)
 		goto out_repcache_error;
+
 	memset(&nn->nfsd_svcstats, 0, sizeof(nn->nfsd_svcstats));
 	nn->nfsd_svcstats.program = &nfsd_program;
+	if (!nfsd_proc_stat_init(net)) {
+		retval = -ENOMEM;
+		goto out_proc_error;
+	}
+
 	nn->nfsd_versions = NULL;
 	nn->nfsd4_minorversions = NULL;
 	nfsd4_init_leases_net(nn);
 	get_random_bytes(&nn->siphash_key, sizeof(nn->siphash_key));
 	seqlock_init(&nn->writeverf_lock);
-	nfsd_proc_stat_init(net);
 
 	return 0;
 
+out_proc_error:
+	nfsd_stat_counters_destroy(nn);
 out_repcache_error:
 	nfsd_idmap_shutdown(net);
 out_idmap_error:
diff --git a/fs/nfsd/stats.c b/fs/nfsd/stats.c
index 7a58dba0045c..6d1c6067c80e 100644
--- a/fs/nfsd/stats.c
+++ b/fs/nfsd/stats.c
@@ -113,11 +113,11 @@ void nfsd_stat_counters_destroy(struct nfsd_net *nn)
 	nfsd_percpu_counters_destroy(nn->counter, NFSD_STATS_COUNTERS_NUM);
 }
 
-void nfsd_proc_stat_init(struct net *net)
+struct proc_dir_entry *nfsd_proc_stat_init(struct net *net)
 {
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 
-	svc_proc_register(net, &nn->nfsd_svcstats, &nfsd_proc_ops);
+	return svc_proc_register(net, &nn->nfsd_svcstats, &nfsd_proc_ops);
 }
 
 void nfsd_proc_stat_shutdown(struct net *net)
diff --git a/fs/nfsd/stats.h b/fs/nfsd/stats.h
index 14525e854cba..b9329285bc1d 100644
--- a/fs/nfsd/stats.h
+++ b/fs/nfsd/stats.h
@@ -15,7 +15,7 @@ void nfsd_percpu_counters_reset(struct percpu_counter *counters, int num);
 void nfsd_percpu_counters_destroy(struct percpu_counter *counters, int num);
 int nfsd_stat_counters_init(struct nfsd_net *nn);
 void nfsd_stat_counters_destroy(struct nfsd_net *nn);
-void nfsd_proc_stat_init(struct net *net);
+struct proc_dir_entry *nfsd_proc_stat_init(struct net *net);
 void nfsd_proc_stat_shutdown(struct net *net);
 
 static inline void nfsd_stats_rc_hits_inc(struct nfsd_net *nn)
-- 
2.47.3

