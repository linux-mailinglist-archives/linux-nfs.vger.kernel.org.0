Return-Path: <linux-nfs+bounces-22990-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LdxBHz45SWqlzQAAu9opvQ
	(envelope-from <linux-nfs+bounces-22990-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 04 Jul 2026 18:47:58 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BA117707FE9
	for <lists+linux-nfs@lfdr.de>; Sat, 04 Jul 2026 18:47:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=TBPsWm5W;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22990-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22990-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5141030125E0
	for <lists+linux-nfs@lfdr.de>; Sat,  4 Jul 2026 16:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7335327B32C;
	Sat,  4 Jul 2026 16:42:29 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0AE246BD5
	for <linux-nfs@vger.kernel.org>; Sat,  4 Jul 2026 16:42:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783183349; cv=none; b=hF78XssKkUHNQgBEMkv9wpOxTmL4GlOaeZjniwjdHnr9iFqxtWWPXp6ieXR6oWIPcIsRvUf83rIMTh+k2SwA99aky6yZo9blHKFT1tHqwp0w2/Zs/Qfg1UgauffrImZdMXa+f/f3NSXrnfno6aMxCspLwAPWbtLqPZDVImzCn4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783183349; c=relaxed/simple;
	bh=3DH3J6Rf9zeKLeuVKNgSsOratKRnhRIkPjLU6KuYHUM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TbxQWPcWbRf9Zc2sIV1/nR9XIeyZqLL7Y1fGzeSwWDmc2Q0XdqYULSpG7ucGvqylIoD7ggVLA+QsQcf5jID8l/bSKpM1rb/4p1wsNrPFC7RPikY+kGSgkpG/s72aAOP9jsQ//xrgTCLGLZGzebdqezFWkzdcWlZQUQ0StU0mAKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TBPsWm5W; arc=none smtp.client-ip=209.85.216.51
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-381216921aaso1467659a91.1
        for <linux-nfs@vger.kernel.org>; Sat, 04 Jul 2026 09:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783183347; x=1783788147; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wXfPC98kSxxFae2WuA2+su+R30KB2XgLe0qUBfwtF10=;
        b=TBPsWm5W4rCxzmauLB83CsllrqSUjOGaU9Imk3NHSBgMavF3kiNK2edgxGo7pLgp/7
         SY1zQdY4lYpzmZuu1w783XM2YxbV/Q8TJOJ8UBs299c3+SigLNTJ/MgAgsadbSg4PLj/
         ODhUP7zEnJqclLEpICRgksIVuhGUgI3IbRFejwsZnajijKHxUMIod1GFSSdJZUxDYtcv
         xP5GtGqW09PDpxa9NXzJ9siG1mKjp4ZCpgf56nCFZbf0l5d1YR3UwxrVdhge2tSm3h3c
         mvK5tRSzw3AxGHXioummkXVbsqrm8aLzY4ErLdWnRYrM98t4Hd3mYFtZirP7JnNhnYsT
         /4iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783183347; x=1783788147;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wXfPC98kSxxFae2WuA2+su+R30KB2XgLe0qUBfwtF10=;
        b=NU6dxZL3uu8iaxr/vi5qd0OtK8OE9PhqHJyh8PT9j/NqWghjg4JeIZqixc67YBI3nd
         wSdXfS2jd8LNh9IgDruOPqkzcOg672+X+/0keQCzg7K7loNCZO2M6vGasVehM9N9PM0w
         IYdWXHzL2HOjl9VMgu2rJgemI5eZPN9VRGIqcRBxHLEI0V4/gcLrJd8pHlvtgYCMMP3a
         hqjvjeOWOWBhCzYNJPxSxUVI1uFf6QKlBnlGGg9A7/oNsXGOoLIUsMDYNYRsApsQklRB
         r3D8isviS1dxp93WQa3Lp/NfyW12TfWN1T18LUgm+ooRWPMqn2PQU/TNq1g9gJBg7pdW
         Pw9A==
X-Forwarded-Encrypted: i=1; AHgh+Rp/UfGMaroCLlQf0W7GxmK7drcyxY1nVaJkTAwYHThzxzRPKfGYUBqcztxlaDiJLEhHI59c4xRA0ig=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1yc75tKiifqTd98boNIkZdsjVQJvjZ8zXT3vXdlCZnDnnVkWG
	ityWOdlLtnSvqF74+whvGsgC4sJ4Ve3/K7bhN+SZTEmq2PhJYBsxiTur
X-Gm-Gg: AfdE7cljrZqLgkPMbPfcMLnpBXpm2YhKD6nklv9obN4Zsjqgtrtft/iDc3FtgKs7ZY8
	25wXjQhnJ7YJaz3YZFuIC2XOcSUzyUyhaQ5qhftbrJjerNc+0HssGz8GZS1YhAC53R8aGTn+7BU
	1dXNot50v4SqURlWVDonXEuZFuZ142z7NmcSVJGPGHhKoT7trQ2BeDEns0Mxv5pc1adMIzSicGA
	mAyDNah52bnA5kBu8yeceMKXbyi3C79gd6mmmSzelIrRwb0OAEFdxW9eRJJd3IYKzDf5AvDgZuj
	CvpyzOqwQgQaVwZ7nG9+ITxdUn7VOxG4y+/SL9hFEBoXGoMQFxhkl32DK/c3bLDQpbbGrLj3tco
	XTtBWtv+PmHR3JntHx1TZskcBJJsEDTC+udnW2EpmZ95RxJNY0LKpyrBYo44XLCMP2OV7vHpcsE
	YZv/Q=
X-Received: by 2002:a17:90b:4b05:b0:36a:fcf5:64bd with SMTP id 98e67ed59e1d1-382807a9d55mr3783720a91.2.1783183347450;
        Sat, 04 Jul 2026 09:42:27 -0700 (PDT)
Received: from lgs.. ([152.32.214.178])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38127ccd661sm2606832a91.15.2026.07.04.09.42.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2026 09:42:27 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>
Subject: [PATCH] NFS: Fix delayed delegation return list handling
Date: Sun,  5 Jul 2026 00:42:17 +0800
Message-ID: <20260704164217.228078-1-lgs201920130244@gmail.com>
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
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-22990-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:trondmy@kernel.org,m:anna@kernel.org,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:lgs201920130244@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[lgs201920130244@gmail.com,linux-nfs@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BA117707FE9

The delayed delegation return handling added a separate
delegations_delayed list to keep delegations whose return needs to be
retried later. The delayed list is then spliced back to
delegations_return by nfs_server_clear_delayed_delegations(), which also
causes the state manager to retry the delegation return.

However, nfs_end_delegation_return() still moves delayed delegations to
delegations_return instead of delegations_delayed. As a result, the new
delayed list is never populated, nfs_server_clear_delayed_delegations()
always returns false, and NFS4CLNT_DELEGRETURN is not set again to drive
a retry.

Move delayed delegations to delegations_delayed so that the delayed
return path can splice them back to delegations_return and schedule the
retry as intended.

Fixes: 4039fbedcbcb ("NFS: fix delayed delegation return handling")
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 fs/nfs/delegation.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
index 9546d2195c25..f65e0930ac9d 100644
--- a/fs/nfs/delegation.c
+++ b/fs/nfs/delegation.c
@@ -594,7 +594,7 @@ static int nfs_end_delegation_return(struct inode *inode,
 	spin_lock(&server->delegations_lock);
 	if (list_empty(&delegation->entry))
 		refcount_inc(&delegation->refcount);
-	list_move_tail(&delegation->entry, &server->delegations_return);
+	list_move_tail(&delegation->entry, &server->delegations_delayed);
 	spin_unlock(&server->delegations_lock);
 	set_bit(NFS4CLNT_DELEGRETURN_DELAYED, &server->nfs_client->cl_state);
 abort:
-- 
2.43.0


