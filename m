Return-Path: <linux-nfs+bounces-20817-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AF18CL2X22n1DgkAu9opvQ
	(envelope-from <linux-nfs+bounces-20817-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 12 Apr 2026 15:01:49 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F183E3EAA
	for <lists+linux-nfs@lfdr.de>; Sun, 12 Apr 2026 15:01:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BB0C73007AE4
	for <lists+linux-nfs@lfdr.de>; Sun, 12 Apr 2026 13:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4943D2DA75B;
	Sun, 12 Apr 2026 13:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fhxD1PBq"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177FD3D76
	for <linux-nfs@vger.kernel.org>; Sun, 12 Apr 2026 13:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775998906; cv=none; b=DBhFarm+Xo5vWq7g6lHgrg+5Y93NkJOvbPSiu7JpCtGdmBDG6oK4i7uOymbDoCjMU7XyzczdlvPmMaKHoUAoNoWJK0HQ0UQ5rc4OJr4PAtnXV8joR9TLSczBHQ0t0kSXxBwo63o05InrQIxdBxgnJefkHuIBXNEfVbGqkgdG37U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775998906; c=relaxed/simple;
	bh=cleIdl+qTbfwmZynQCgtqwVhKgKS41FqDMKHUuTqD50=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ABqverKj0x2TPEdFBEe9AkPfK3WQdugg75pj1l+1WusvMmxZ2pAd7Jo+N1hy8ZsWk8x9YDJrRaFrSWttsBSd4Ygsdk/NMtckq/TKffPOQ9eyBXh4Apcx2o+GeG05EvFB+ZpmC9q4niqBGTqYJVunlhslhW3lnImd2Ge12a6jobo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fhxD1PBq; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2ad9f316d68so15388085ad.2
        for <linux-nfs@vger.kernel.org>; Sun, 12 Apr 2026 06:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775998904; x=1776603704; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tEuqZf5lySQourIJHgDHr+YWzyz6c3oHQnabpz7xMSk=;
        b=fhxD1PBqVf3a36tt/tHj5XKf9UTHD2FZ9s8QwDLlnRNHyYzBpJ9P/VsnW8Hwf+kMZW
         SQQav7YyDQYxobwqN6agnZWXm3+MnZFC71tsUZ3l8ZGCzie+TTFQ0niOXRIdBkfIytVp
         AiR+GKrPfQEFNgXY2R3nRBrUUDtR1g1Mv/1ZTKU4vvHodj0VKK2RqcJH5o5VhKqp1tm2
         BegFKGcBYS7cwCHkX0rdplKIZVajXgB86dgivoduyv4F8mPbOMmmlvTudb0gLhRDrzqa
         gSgqCpKQ6gr+hXnvC1++bl/wrQmjKeh5qxFIfaXWVci3LpzrN4+70Pu/iNyezRHrYY+7
         nq8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775998904; x=1776603704;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tEuqZf5lySQourIJHgDHr+YWzyz6c3oHQnabpz7xMSk=;
        b=INrd0fQ/K+iJdv86qy4OCMJS0XmAK0z5nK3E01yqtIjJT5CkKogSPWxSx0vYMf3lmR
         rDoqT9i1C4yNzFEFyI8IJ8H0Okw8UjJlZjxWrNptncJrAsrued5UuKZq4K5CS5Ps9Yre
         PSWqsPkPY9bZFwsRbZgmNSlk9oHlxAlQ4sZL7fibshQKn36fH8OB3gFZ7s4Y7xFvZyRZ
         WhwqDQhjG9oQXc4pfL2yIMJONK9wddTFLS6j35j7FRPOT3MmaWKVk87iAMWcLhXRYffL
         ZGe2znm5yyQ5uPtHskDEPp/pbKqaerYh1Vhia0BK5zvXzgUGu3kUpDBUXiMEYPJklQ8r
         YhxA==
X-Forwarded-Encrypted: i=1; AFNElJ+HUDdHq3V6sBEVJZfK1owwqE3msj3V+Zm3wssAn4Pg+So0rph3GnjS9t10fHOg2rRrW1p1pywzEXI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNm7iI60BnkYgsjnVjRjCJYP6IxqLfXNezpWlzeaRWlhBptNaA
	oveJPD3236lgVjt6BZ4/ProOpM5zEMO2AGK9SXJDcieej+YEVkGcLRa5
X-Gm-Gg: AeBDiethdD/G9z/DEcW/0EAHoq2+c6vCRbtRHS9dIXAHhyiUgJH7bmnFlGIx/w/LaEB
	F/Q14EFKoj1p/uH6xZr5vIbBBsw4f+n3+cmCqRSXZa+hBuhU3MuthXN2nolDQUPyN/huiFoI7Yb
	n5q17Hj3GVarI3W+vP7s2kS2dDKEf5nsfmNBHuQ2188h/pXA6iGMzHAh707V2T1I4KwbyTJahPL
	djQRwPRySZFSvNaETYogB7ZZKR12lawoXCALrossjHmeHYlAec8s1iMP9OQVj5RsNN+OP44McjM
	R426F+zVzDfZH6jMai/6LgUwpBPVsXErXp0NvKm8UA0CIpZrTe+5c6BwlP5EwuTWkzrBjQQqn2T
	N94d0p38o1FdaS4MbBtxkLEIBsx7wdg3O/0tM6nL+vCI9EDenEodU+U0Hde8l1kwoa/yqC/TPlB
	cbJJFLk+jZDf+mPP3m2Icidyql2HSS8ef3/UWFKwxapWD36Ih64ShJ+QdlfwPWefBaoPUm5k2vB
	bmE5OHUZXPpSK/0dwHPFyickKGc
X-Received: by 2002:a17:903:288:b0:2ae:46b9:c653 with SMTP id d9443c01a7336-2b2d5a43e92mr101961225ad.33.1775998904099;
        Sun, 12 Apr 2026 06:01:44 -0700 (PDT)
Received: from localhost.localdomain (ec2-54-199-123-161.ap-northeast-1.compute.amazonaws.com. [54.199.123.161])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2d4ddcda9sm87099115ad.28.2026.04.12.06.01.40
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 12 Apr 2026 06:01:43 -0700 (PDT)
From: Xiaobo Liu <cppcoffee@gmail.com>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xiaobo Liu <cppcoffee@gmail.com>
Subject: [PATCH] nfsd: fix replay buffer length underflow in nfsd4_encode_operation
Date: Sun, 12 Apr 2026 21:01:33 +0800
Message-ID: <20260412130133.2308-1-cppcoffee@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[brown.name,redhat.com,oracle.com,talpey.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-20817-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cppcoffee@gmail.com,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-nfs];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 73F183E3EAA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When nfsd4_encode_operation() truncates the reply back to
op_status_offset + XDR_UNIT, the replay-cache path may still try to
compute the encoded payload length from xdr->buf->len.

If xdr->buf->len is smaller than op_status_offset + XDR_UNIT, the
subtraction underflows and the result is assigned to an int. That can
produce an invalid negative/small value, allowing the subsequent
NFSD4_REPLAY_ISIZE check to make the wrong decision and use a bogus
length for replay-buffer handling.

Fix this by validating the buffer length before subtracting. If the
encoded length would underflow, force the value into the "too large to
cache" path so rp_buflen is cleared instead of reading invalid data.

Signed-off-by: Xiaobo Liu <cppcoffee@gmail.com>
---
 fs/nfsd/nfs4xdr.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 9d2349131..5e9e49057 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -6278,9 +6278,14 @@ nfsd4_encode_operation(struct nfsd4_compoundres *resp, struct nfsd4_op *op)
 		warn_on_nonidempotent_op(op);
 		xdr_truncate_encode(xdr, op_status_offset + XDR_UNIT);
 	} else if (so) {
-		int len = xdr->buf->len - (op_status_offset + XDR_UNIT);
+		unsigned int len;
 
 		so->so_replay.rp_status = op->status;
+		if (xdr->buf->len >= op_status_offset + XDR_UNIT) {
+			len = xdr->buf->len - (op_status_offset + XDR_UNIT);
+		} else {
+			len = NFSD4_REPLAY_ISIZE + 1;
+		}
 		if (len <= NFSD4_REPLAY_ISIZE) {
 			so->so_replay.rp_buflen = len;
 			read_bytes_from_xdr_buf(xdr->buf,
-- 
2.34.1


