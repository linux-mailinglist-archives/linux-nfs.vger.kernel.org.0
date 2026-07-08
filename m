Return-Path: <linux-nfs+bounces-23179-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BqvQBTDETmq3TgIAu9opvQ
	(envelope-from <linux-nfs+bounces-23179-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 08 Jul 2026 23:42:08 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B88C72A9A6
	for <lists+linux-nfs@lfdr.de>; Wed, 08 Jul 2026 23:42:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="CogA/i6Q";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23179-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23179-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F0A1930ED65F
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Jul 2026 21:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0A313F65E5;
	Wed,  8 Jul 2026 21:36:12 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1543F660B
	for <linux-nfs@vger.kernel.org>; Wed,  8 Jul 2026 21:36:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783546572; cv=none; b=Y/Mu/GiqQgtJJZpQZQoMsY/TWDBmHyrQT70SmvK+OPs7SLvnHgI24XzJVcKqSHdvt+rzTAeme95QP5IUtQ6QV92pl+wdqysmdnrsiv3/IC+p5casHQkIA7dB+QiB24F31vXKO/2at2LHmKQoloiRp7RoHysd9HEyHLZ8Mq9Jj80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783546572; c=relaxed/simple;
	bh=QS+IUibvFypmp6z30K+ypyfMnYBK+q0hsLN/1IRqrck=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T+2QEpGlxWSMZj+Jsqbh7UsImLIYP+uSOs/2AH9sfJqPUyddWDerwhrgwu38TBQL+99oGMpZ7lnk9zn5lX16YYXRz203UyAEqenCNej2wcnB2yfywaUrX2OVi/AaZUN5b8GWZcH6ELnNIElCk44tQs8Cuxbr8dGgCNAB33y8oCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CogA/i6Q; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EA431F000E9;
	Wed,  8 Jul 2026 21:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783546571;
	bh=QwSZtvo5U3/02/7GPdS94ANhEIkqFoBWzThwqIP3Ca0=;
	h=From:To:Cc:Subject:Date;
	b=CogA/i6QXAROt44fuX/qOsk/GYkLgfuCSg+uq+zzzug4bhcK77MMvQ8DJPngrkS6G
	 9mo8UNp74R4b8Djdm81td5h+sEk3P/wHnIwi57bQFfL1QLWebs9UdNntKHTYg6OZKn
	 cQwhino5eRYYMB9UUYXQY728BLjjUK793m3z4ODeZy8vvQD6jNVFTmUm/APdgofgai
	 5eMkLmjEKk28vAL278PlkWdHdCESMZPi9vKqc7cHoE3he6KIzaqkllPfwOC2cJ1Scl
	 ZkKbmqfJo4zRrvm1Kqjg0UkaQaw6VMwm4iQxKPnaEXXuUu5HCt0qvmtzYV+ezjVMrK
	 eWuYGKlVzF+BA==
From: Mike Snitzer <snitzer@kernel.org>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH] NFS/localio: fix nfs_local_dio_misaligned tracepoint
Date: Wed,  8 Jul 2026 17:36:10 -0400
Message-ID: <20260708213610.19001-1-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:trondmy@kernel.org,m:anna@kernel.org,m:linux-nfs@vger.kernel.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-23179-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[snitzer@kernel.org,linux-nfs@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[snitzer@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6B88C72A9A6

The intended focus of nfs_local_iters_setup_dio()'s call to
trace_nfs_local_dio_misaligned() is on the middle segment being
misaligned, yet the @offset passed in was local_dio->start_len.
It would appear this was a cut-n-paste bug from the preceding
nfs_local_iter_setup() call that passes local_dio->start_len.

Fix this by passing the @offset as local_dio->middle_offset and
calculate the start segment's offset rather than assume.

Example traces, before this fix:

   python3-32744   [006] .l... 132946.352360:
   nfs_local_dio_write: fileid=00:33:1286 fhandle=0xf1f7c10b
   offset=1048759 count=1048576 mem_align=4 offset_align=512
   start=1048759+329 middle=1049088+1048064 end=2097152+183

   python3-32744   [006] .l... 132946.352360:
   nfs_local_dio_misaligned: fileid=00:33:1286 fhandle=0xf1f7c10b
   offset=329 count=1048064 mem_align=4 offset_align=512
   start=329+329 middle=1049088+1048064 end=2097152+183

After this fix:

   python3-32744   [006] .l... 132946.352360:
   nfs_local_dio_write: fileid=00:33:1286 fhandle=0xf1f7c10b
   offset=1048759 count=1048576 mem_align=4 offset_align=512
   start=1048759+329 middle=1049088+1048064 end=2097152+183

   python3-32744   [006] .l... 132946.352360:
   nfs_local_dio_misaligned: fileid=00:33:1286 fhandle=0xf1f7c10b
   offset=1049088 count=1048064 mem_align=4 offset_align=512
   start=1048759+329 middle=1049088+1048064 end=2097152+183

Cc: stable@vger.kernel.org
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfs/localio.c  | 2 +-
 fs/nfs/nfstrace.h | 5 ++++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
index f42b6112a613..63c38dea50cc 100644
--- a/fs/nfs/localio.c
+++ b/fs/nfs/localio.c
@@ -446,7 +446,7 @@ nfs_local_iters_setup_dio(struct nfs_local_kiocb *iocb, int rw,
 
 	if (unlikely(!iocb->iter_is_dio_aligned[n_iters])) {
 		trace_nfs_local_dio_misaligned(iocb->hdr->inode,
-			local_dio->start_len, local_dio->middle_len, local_dio);
+			local_dio->middle_offset, local_dio->middle_len, local_dio);
 		return 0; /* no DIO-aligned IO possible */
 	}
 	iocb->end_iter_index = n_iters;
diff --git a/fs/nfs/nfstrace.h b/fs/nfs/nfstrace.h
index c70debb88aa1..2e1932962a81 100644
--- a/fs/nfs/nfstrace.h
+++ b/fs/nfs/nfstrace.h
@@ -1772,7 +1772,10 @@ DECLARE_EVENT_CLASS(nfs_local_dio_class,
 		__entry->count = count;
 		__entry->mem_align = local_dio->mem_align;
 		__entry->offset_align = local_dio->offset_align;
-		__entry->start = offset;
+		if (local_dio->start_len)
+			__entry->start = local_dio->middle_offset - local_dio->start_len;
+		else
+			__entry->start = 0;
 		__entry->start_len = local_dio->start_len;
 		__entry->middle = local_dio->middle_offset;
 		__entry->middle_len = local_dio->middle_len;
-- 
2.43.0


