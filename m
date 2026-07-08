Return-Path: <linux-nfs+bounces-23170-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id AFyGHPhMTmq3KQIAu9opvQ
	(envelope-from <linux-nfs+bounces-23170-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 08 Jul 2026 15:13:28 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C16F6726ACB
	for <lists+linux-nfs@lfdr.de>; Wed, 08 Jul 2026 15:13:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=CSOvkRcM;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23170-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23170-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 383C8300C5B4
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Jul 2026 13:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F5B724887E;
	Wed,  8 Jul 2026 13:06:58 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62003242D7B
	for <linux-nfs@vger.kernel.org>; Wed,  8 Jul 2026 13:06:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783516018; cv=none; b=nouZsdxthD1dDUWKQ5RBy+sdi/UgzTaYwt+dH6i7n8qfNNP215VakE8vs0NVOohMhg+9SdzJDf/ZJQaY8moZBWh0vylMHjW2cEYnUXfV4rVPI0kUQhCGccjx1sj5akZcD09ky2s5ODtuauzwnbUiTboDm0XGtUZfIcYsAAQdP9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783516018; c=relaxed/simple;
	bh=fwy5fO/V7JapY3djJy0QpJK55av6p74lqWx9juegZb8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GaiGU0fdFj0NuIDJ/BfahYsM9DCyrjCuhTkyBjpubaH6ISfpu6xKL5TeVkZZL49NGb04RJZ88w7USN+1BAbRaerI0rGcnR+WtXpUdOcCxdl31jbG22AyLEC7/t5BHj3etZwMPAjeR36SgxZRw06FpEbXgURFtlIt8miGBOXMblM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CSOvkRcM; arc=none smtp.client-ip=209.85.214.180
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2cad4170e8eso8854635ad.3
        for <linux-nfs@vger.kernel.org>; Wed, 08 Jul 2026 06:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783516017; x=1784120817; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4H65Jt0qaP5+omtTAiQmAVRn7+xFeblOteKrGy1TQnM=;
        b=CSOvkRcMXhUHnEhDGDHuduJOOu4EVjJ3hstSvMx2oqSw1BdEhYqOtZ6FQWIF7H+jwx
         XAhE5e6pKGAQxrAr1/ejju3zcO5HtMyM9XMf5nlZBrCFDUVkYvWCHFojKuwH9bQn84ZU
         JXuQNjRUrqJtULVKwZVxXTFD1FBcJy7LQcW24Ho3mkMqyc7r12VaXOx3Ekz7PK7bzWzn
         rxdRydBVwak4bgojx8oHbaWCxFzJ3iqqkhLltfLJe3v1Cu1VevNOaOhrkJZiUiGHxPGJ
         V06gYgCINOavao86itgPaP3KPJ9I+YszPS2TYyZ6zcJjfkMh70WAPuc+k7hhfMzAuDUa
         OPEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783516017; x=1784120817;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4H65Jt0qaP5+omtTAiQmAVRn7+xFeblOteKrGy1TQnM=;
        b=iufQESwRtMEnvXqj+ks/wdc5/ecitMZ+M9+MK8Ivrv2/CEhO0C8YBp06stGPEMjpxC
         7OBxwjVodZ1bu6xAz4vaW4OSc2LIQ29gCqFoOqUG6MEidSYK6KOq89LSP73TH+Pf16EU
         bReQxwtzj3Msz3wubKj0kKap7QM4glWpYrac2MyE9qCL6bw/ZJR2e3XdlgtBPKHnxVaT
         WJIsPzF2gxmUb6N2moz8abUZwzG/tR+0PhzG2FCoxM9CpcdzE/z4Vvq1tZJ7IDgyI2nq
         LlHgme6pBulOXApqQsMd8DtxW3HDIuXyXu61sdejgDni1xopa6/Zpfif8nLctdBU22TN
         6PkQ==
X-Forwarded-Encrypted: i=1; AHgh+RoQPWXQ/r39ct6jrpsShJlYwLAi5YV50IEUnH6Wxkh9/c5lBfMAxik0tAAsAT2dDAL5VYS2ZD9yDLg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxlp7sZHftwRKXDyEhxfWl1zwUeWVpLlF1AkmYtp5VAgen1TWIz
	l85qEY/pl2BNIDqF9tiAWvzRBtq5lUuFu/NQh5HozuAVSl8O/hzidt+l
X-Gm-Gg: AfdE7ckZn29xKLFanRVERhzNbVU7LyjZwjwo2MghFD8RtG0RIG9CAQ1D1MVwpOYZsP9
	/vxhDP2YHfyUOaZ2jmIGC069MZdUI/G/wPTDEH+xFe8J8xlW5e8Jq+W2h/QvB3zLL1LPMz3DuHJ
	YQevw8C9JcNH6jHimQXhMQXs6Ldf5q1U9vKiKUbtybPsjS1MbPFyhgVOOgJ7o90rQs69GwCSDgC
	rXN7C7vG/acdBkZnv1WaXQfTNKDr33UuOFIrkPuLzjpzTJUO2lmAGejPRSxpiTCW9Xz9dAt9aFL
	iwKyUF/mRXQafm9KzSLCGHHfkeisSntQnQ/qQXH9O2GpWZ8YqIvl+6m8aQJpw43lylP/Hlj1nvN
	+CQdP/9ap7hz8nQWcI2NXHAHbySj6l2osCrlsvT8iNNr8zu7/tNLPkqr7H4AAAIpctuhTjvjI6E
	hXcgUnqJUWfA==
X-Received: by 2002:a17:903:3903:b0:2cb:14b3:4cfe with SMTP id d9443c01a7336-2ccea582ae2mr27025425ad.45.1783516016527;
        Wed, 08 Jul 2026 06:06:56 -0700 (PDT)
Received: from lgs.. ([101.76.249.46])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccf5a4fa46sm2927725ad.30.2026.07.08.06.06.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 06:06:55 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Chuck Lever <cel@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Jann Horn <jannh@google.com>,
	linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>
Subject: [PATCH] fhandle: handle detached mounts in capable_wrt_mount()
Date: Wed,  8 Jul 2026 21:06:48 +0800
Message-ID: <20260708130648.767811-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-23170-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:viro@zeniv.linux.org.uk,m:brauner@kernel.org,m:jack@suse.cz,m:cel@kernel.org,m:jlayton@kernel.org,m:amir73il@gmail.com,m:jannh@google.com,m:linux-fsdevel@vger.kernel.org,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:lgs201920130244@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[lgs201920130244@gmail.com,linux-nfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,gmail.com,google.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C16F6726ACB

The change referenced by the Fixes tag protects the lockless read of
mount->mnt_ns in may_decode_fh() with an RCU read-side critical section.

That prevents the namespace object from being freed while it is being
used, but it does not guarantee that mount->mnt_ns is non-NULL. A mount
can be detached concurrently after is_mounted() has checked the field and
before capable_wrt_mount() reads it again.

If capable_wrt_mount() observes the detached state, it currently
dereferences the NULL namespace pointer while passing mnt_ns->user_ns to
ns_capable().

Treat a detached mount as not capable for this permission relaxation and
return false when the RCU-protected mnt_ns read yields NULL.

Fixes: 40ab6644b996 ("fhandle: fix UAF due to unlocked ->mnt_ns read in may_decode_fh()")
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 fs/fhandle.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/fhandle.c b/fs/fhandle.c
index 1ca7eb3a6cb5..d9de7210a411 100644
--- a/fs/fhandle.c
+++ b/fs/fhandle.c
@@ -295,6 +295,9 @@ static bool capable_wrt_mount(struct mount *mount)
 	 */
 	guard(rcu)();
 	mnt_ns = READ_ONCE(mount->mnt_ns);
+	if (!mnt_ns)
+		return false;
+
 	return ns_capable(mnt_ns->user_ns, CAP_SYS_ADMIN);
 }
 
-- 
2.43.0


