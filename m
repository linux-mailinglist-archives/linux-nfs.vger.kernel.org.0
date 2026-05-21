Return-Path: <linux-nfs+bounces-21765-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ePP/JbY8D2rQIAYAu9opvQ
	(envelope-from <linux-nfs+bounces-21765-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 21 May 2026 19:11:18 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 15BD55A9F06
	for <lists+linux-nfs@lfdr.de>; Thu, 21 May 2026 19:11:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 91D2032D8D26
	for <lists+linux-nfs@lfdr.de>; Thu, 21 May 2026 15:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DE24355F2A;
	Thu, 21 May 2026 15:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QfwricTO"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD7C33A6E2
	for <linux-nfs@vger.kernel.org>; Thu, 21 May 2026 15:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779378422; cv=none; b=RbHiDdnu/R0E0OAEMVHSpPE6hkTWk6k+iBQsHqrdgFdEQ7SVRZ9+QeEDzCayowDv9zn8nSn3Fj9YJjxdz5EDsYNDRVZvvdqw82+AyyYpogdjjTr900VQMddGroBidY0XtWPyYX+VMRdefG1ZdRfN+FTzf0CKH5x6z1xHCGR2mG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779378422; c=relaxed/simple;
	bh=kSsXIv1KuOI6MaSbWJwgmunMdybpSqKv5WEsRoANJnE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=q/+GhXAvTpHYyjWWw/EV0ncWMUT6+Q9iCaNbi7PRASJmE2lps77YAL3WoUwgeKMhKIe+HVw9Qq1qicn0xhvKDGOPH7qIx9eX3q1Fz9hCgQMIuG+SaZwUcPFSZX/MkbE5s0B+R7sXIMdMVUxR4n97NNC4aBKsS6S2CAByFUhtZS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QfwricTO; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-67179ed133dso7470561a12.2
        for <linux-nfs@vger.kernel.org>; Thu, 21 May 2026 08:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779378419; x=1779983219; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tL+bGynNZuqZUYa89JaxNmi4jhFy/Ow30E13rLwsh0I=;
        b=QfwricTOVOdAhTYXpOrUQTARPS4b2unh/w0yeTR7+Od3aGZGIOHtX93g2u8cZnJDc9
         m13b5BbBUSpRvBnagT90TRkHLDePkFpuhhHNxuxNDlgKH6RxC1u5kekGcc+bFtrZXEsu
         VlnkzdklSFpIEDTuL59pcpjmzl7qfnZmCKumuq31npzM0qcRVyzo3NWKwY3HpFnHuD2k
         4jef+ly8fkMAh+Rp8o0WF1o89rRhphv/Wq0Hh/Z33vKDn/6cttnhBVia8O5WSaKNuYnD
         F9PzKkCCycMbtNLVo2J3SOsmiZ/c7mUEfyC0C95gc+3+2c0f+o8bT8ryFX23LOATL0/C
         UTrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779378419; x=1779983219;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tL+bGynNZuqZUYa89JaxNmi4jhFy/Ow30E13rLwsh0I=;
        b=Mj8HP47TmPDqkfjws0tauISDxxEINgMrcjVDguKCue8zHJFjHn6MLCnqH6WVZ3c822
         2w9kfpyvvop1cFeMGWrvvZatNI4hM/sTjPFzMAdoDRuobUeaQ/cs4W7yzdjIRGitmkSD
         ip5m7T45TYLAuniUYufvQSNKhg35jKS0TCL24W7EvBldMvxMNLt4H/NDpVZSmyiXi4yf
         GMP73ByjQAQwKycBfvRbXICknR+NOBIjzXraWU/Mi+rHp9wTCusqyfrIn+go7d8Wx0fp
         cHRDr9Vwhjv7/dpgxa/FwDOy8Ybs5GVdPUo1SwNw0xbfJ/9m8KJhWactxNQv9V1nLY8Y
         T6iA==
X-Forwarded-Encrypted: i=1; AFNElJ9/4cCsx0M8A2TL7MI31WpRSvOr6wXXxP1fgHbwWHjNqWpSEj7bihNHOFIVAHag7EbneWcQgZmsnok=@vger.kernel.org
X-Gm-Message-State: AOJu0YztZUZPFieaIkmzFjAKSlw9b80GCo6CkMRdAJGcq0TvdNweSrJK
	MsyJz+ek/Haq8I5RxtYy1sPo5uX3t6dJN4MTYo9edyz/+Zt7SfVBmLHx
X-Gm-Gg: Acq92OEDWJNPetwxmki10PPPnaIJ/xCCW7ry42JcP3zPUcA2qVn+OYh1dSKVLARau6W
	IazJgs1IlIZfdbuv/d6tW0pFqLjzCA5Y2D4AzcN9HkP0M5nspQbwR33M+mo7UcyRu+0uEMdaxrc
	wK7ZvbP9b5PqstyWCaXMcV/9ZLL8Lov2rco0KGHBM/V3riLWVgnsOA1D74+BCR41lMF4hBzWR72
	BTFbOfxY0SY7og+nEGOr9Isn7U1KWSnnZOnpQdgL30zcje5ykCZoqGVJgMneJ/2bx4ycr7cxzJn
	NBSPfJEeXLL53ak2nK0m+cbJUJ4zYnWqs3JQS4IQQQbnkG4T5ypU+/bFSWlnPsUMbEanhnUCq6v
	hSvUzwNel6s6EcYzL/bBP3yRfEML8c4ZVInJDfv80jzUY/88+gqpP/UzBj2pKoub8vZTgu2Y9hn
	BbGt0VSZXOdIuEE14HLoasDPtg5RhBBOdUJym30xFrjQ0uYZDhZC1TwvyAAOVU0CCRgcx6SqbLQ
	qZSaBKCD7RV7l9h77FSfLFYWGPDvg==
X-Received: by 2002:a05:6402:3789:b0:688:34c4:e8cc with SMTP id 4fb4d7f45d1cf-688360e6e6emr1863901a12.6.1779378418859;
        Thu, 21 May 2026 08:46:58 -0700 (PDT)
Received: from localhost.localdomain (79.184.247.34.ipv4.supernova.orange.pl. [79.184.247.34])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6887e224afdsm319974a12.9.2026.05.21.08.46.57
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 21 May 2026 08:46:58 -0700 (PDT)
From: =?UTF-8?q?Dominik=20Wo=C5=BAniak?= <stalion@gmail.com>
To: chuck.lever@oracle.com
Cc: jlayton@kernel.org,
	neil@brown.name,
	okorniev@redhat.com,
	Dai.Ngo@oracle.com,
	tom@talpey.com,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] nfsd: check get_user() return when reading princhashlen
Date: Thu, 21 May 2026 17:46:56 +0200
Message-ID: <20260521154656.63861-1-stalion@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21765-lists,linux-nfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stalion@gmail.com,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 15BD55A9F06
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In __cld_pipe_inprogress_downcall(), the get_user() that reads
princhashlen from the userspace cld_msg_v2 buffer does not check its
return value. A failing copy leaves princhashlen with uninitialised
stack contents, which are then used to drive memdup_user() and stored
as princhash.len on the resulting reclaim record. The other get_user()
calls in this function all check the return; only this one is missed,
which is most likely a copy-paste oversight from when v2 upcalls were
introduced.

Mirror the existing pattern used a few lines above for namelen.
namecopy is declared with __free(kfree) so the early return cleans up
the already-allocated buffer automatically.

Fixes: 6ee95d1c8991 ("nfsd: add support for upcall version 2")
Signed-off-by: Dominik Woźniak <stalion@gmail.com>
---
 fs/nfsd/nfs4recover.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
index b338473d6e52..6ea25a52d2f4 100644
--- a/fs/nfsd/nfs4recover.c
+++ b/fs/nfsd/nfs4recover.c
@@ -718,7 +718,8 @@ __cld_pipe_inprogress_downcall(const struct cld_msg_v2 __user *cmsg,
 				return PTR_ERR(namecopy);
 			name.data = namecopy;
 			name.len = namelen;
-			get_user(princhashlen, &ci->cc_princhash.cp_len);
+			if (get_user(princhashlen, &ci->cc_princhash.cp_len))
+				return -EFAULT;
 			if (princhashlen > 0) {
 				princhashcopy = memdup_user(
 					&ci->cc_princhash.cp_data,
-- 
2.50.1 (Apple Git-155)


