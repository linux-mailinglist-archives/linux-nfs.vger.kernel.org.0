Return-Path: <linux-nfs+bounces-21262-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WD0MBAQS8WmXcQEAu9opvQ
	(envelope-from <linux-nfs+bounces-21262-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Apr 2026 22:01:08 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B81F948B69A
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Apr 2026 22:01:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 97C97303F077
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Apr 2026 20:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D69A3C0607;
	Tue, 28 Apr 2026 20:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z20xA9l5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C619A3806DB
	for <linux-nfs@vger.kernel.org>; Tue, 28 Apr 2026 20:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777406435; cv=none; b=C6cH3b8xGnuBN7IIzmymNWU4LcQOgGR3JThIWHEcIEo7gnkW//RWlmS/yoEQlD7A/IdltpKX1WBiW6nrl5Y8hht3v2be9b5bdIRYcZ7qfq2T0KCsZB09dtdd/e5yxsIwB5RZmZ1IF4cSUtTMY50oNNe6qAVxltJCaTgeuHEqEGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777406435; c=relaxed/simple;
	bh=UwFS0dd2RC6WbLqC99/vh9zVfjHSjn6RR9/yavDHuXE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=C/LREUiKT5wFQ26guI3sQMcBjTbafkr9VzUo9sA4jvQg38pYFPQWLYOIyX6i9UUV6xJWjonm41i7tmoD2O4EycfZBna879WgvMq+wQlWEcYcfa3yXEzRty+HTfeHrnunj2LPs7QqA+0GcYP8Gs+TA88kFpTxXHWeJ2pWw7bmipA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z20xA9l5; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-79885f4a8ffso126810057b3.3
        for <linux-nfs@vger.kernel.org>; Tue, 28 Apr 2026 13:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777406433; x=1778011233; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6Mssbq0uzAAJj7NJ/R0nT6iVhqOt878+U1l9ukIlgRg=;
        b=Z20xA9l5dyN0NlQnCAkKKux1KLCkLxhFPPM0BD2POGEw1BnyWrg4eprEB2P9brkdE3
         J9FIp6opo9AFst3dI/6p37vMhZ/HiGhUxEffCMQsO1A5qB+h80bX/lQIRxSY7wGCqIcA
         CuMq/0C6KCciKHgl6mt5y6fNhFsHdiIA9bifVEddqZCqVQEmTaQb2lGy+hBiyioDjTXY
         /xM0K++CkZ7lA/rRWnKKfZVelSvMotL7kVV14inZ6SUpdVM6QCyLjCbens7G9bDzEi4M
         uia3mWTlOmKRm2geyv+fKbYO/WPsQ/I31HkoFKmUfSxGVP6cXNcFrADXzUxxefBJigLT
         JzKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777406433; x=1778011233;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Mssbq0uzAAJj7NJ/R0nT6iVhqOt878+U1l9ukIlgRg=;
        b=E7V1LDhGuPvKAj4lvrjT/2esckypJf7tomlsKlEtYMFKUOVD6TCjRLTwFVob8Njnem
         uxhFiosQK8dGdI4wrBLWrl8pHkZyoCGBXI1Ce2Gg1rZNzV42HkRzHbP455+B/37mHfEE
         vBHBzoPehsxycUaYfRwc98c/RO852AF0Tnkjx3jfeSjGEO+VMv388ao7UBAcwHC9fHvM
         IB2CpxH8qA6hpKjG/Ft48RdZhGwGEMrj/tqaPu6ahSEHnPK+yvYBQWM+gMhu8lisdZ/N
         fi4sQtE+MAwX9UA5qM4L+HpQfIq5TDYbFN23XiognxbJCjRMwQOFyq+0zB8UxSoorrWc
         eEkg==
X-Gm-Message-State: AOJu0YxvB9eVVnYiG72KUEpuafyUFNvLfaFkuN77YUHk6FXoSg38L7ov
	qKQHRv2bdBZge+pbTwars/hdkUJmUcEDfdD7+wxHSsLQYgGo3yw/9rSBsl47xw==
X-Gm-Gg: AeBDieupbTRDnSaM5PfpOCJowc1T+K0THyyMMQSvtZzEQF5MVtpHK/gbu8cVHyPIzIQ
	YQoHzvEMz7FvumygL/htZ3wMharOhsne5/Q+xSHVb7g/Wt3rWWImidD1gKNDco7XF942KuBQept
	lXBHQPXAZrJeS8kpr6zqJvmygSecFb13egwLqMMw7EvagUmAqgw8XihUoSksCmJtxSTAtKoHpcf
	Ow2/mWvDynVEQiNl28ggb80beL4FxlWP/Zs+2iQNfRa1UDOkABaIwX2SNpiMZbDgt7we9bQWUt3
	+hlTjBkGUm3QVWStTgdSIIl6TM33d9P6/bYLZx7mvop9o9JFnCGJkzv2aq++RTiye0EoipYPouT
	Nl5B5ibcjb9mBvRTQ7dXKrw47nfsAJ5ZfvZJ98/STmV1w5OKwhwp6tHC2nhVE2Qx6+rZebiUl3J
	Sl4bLiScqB5IPFO2V/sY//x+h4DZ+S/pRhFW6fQZjw
X-Received: by 2002:a05:690c:385:b0:799:182:17d1 with SMTP id 00721157ae682-7bcf57b6adamr45660987b3.45.1777406432686;
        Tue, 28 Apr 2026 13:00:32 -0700 (PDT)
Received: from localhost ([2804:1b3:8302:9360:bc6d:42df:1757:1d95])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd24b8a86dsm1803717b3.0.2026.04.28.13.00.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 13:00:32 -0700 (PDT)
From: Kenner de Azevedo dos Santos Miranda <kenner.linuxdev@gmail.com>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jonathan Curley <jcurley@purestorage.com>,
	Tigran Mkrtchyan <tigran.mkrtchyan@desy.de>,
	Chuck Lever <chuck.lever@oracle.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Kenner de Azevedo dos Santos Miranda <kenner.linuxdev@gmail.com>
Subject: [PATCH] nfs: flexfilelayout: fix unused-but-set variable 'err'
Date: Tue, 28 Apr 2026 15:59:19 -0400
Message-ID: <20260428195919.29794-1-kenner.linuxdev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B81F948B69A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21262-lists,linux-nfs=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,purestorage.com,desy.de,oracle.com,kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kennerlinuxdev@gmail.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

The variable int err in f_layout_io_track_ds_error() is set but not used in the code.

The warning was identified by running make w=1:

   warning: variable ‘err’ set but not used

I set the (void)err to prevent the warning.

I didn`t test with hardware, i ran again the make w=1 and the warning was removed.

Signed-off-by: Kenner de Azevedo dos Santos Miranda <kenner.linuxdev@gmail.com>
---
 fs/nfs/flexfilelayout/flexfilelayout.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c b/fs/nfs/flexfilelayout/flexfilelayout.c
index 8b1559171fe3..d9a0fed41eac 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.c
+++ b/fs/nfs/flexfilelayout/flexfilelayout.c
@@ -1536,6 +1536,7 @@ static void ff_layout_io_track_ds_error(struct pnfs_layout_segment *lseg,
 				       mirror, dss_id, offset, length, status, opnum,
 				       nfs_io_gfp_mask());
 
+	(void)err;
 	switch (status) {
 	case NFS4ERR_DELAY:
 	case NFS4ERR_GRACE:
-- 
2.43.0


