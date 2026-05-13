Return-Path: <linux-nfs+bounces-21590-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WH8uOyIhBGpyEAIAu9opvQ
	(envelope-from <linux-nfs+bounces-21590-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 13 May 2026 08:58:42 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6923E52E591
	for <lists+linux-nfs@lfdr.de>; Wed, 13 May 2026 08:58:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5DB57306CB05
	for <lists+linux-nfs@lfdr.de>; Wed, 13 May 2026 06:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CED8418E025;
	Wed, 13 May 2026 06:58:30 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2AA368D63
	for <linux-nfs@vger.kernel.org>; Wed, 13 May 2026 06:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778655510; cv=none; b=pm1a6zxwKG6F3RgYmQsA9Stc/BJRd4PixSFGkeqsFzhxvyoc7oa9S3RyMLTpYrFiw8cwS5irfXPokkiZYTvbnIAi835kbd52rtrk0ZyJUjO+6khwBUWM/TNBne9Zo4byBqwz4wNSnT854oduY3KI+g2wJjVvAhSdERBbmgNpjlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778655510; c=relaxed/simple;
	bh=fIC6gi1IerqgavZtYwZK/t1ufNSDT6dEAuQs4QvrB/U=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=dgNO5xoTukZSiYdF47cv4sFNiRlckgbwttB92yoScQKS865okua8W7UPVgPJ1u4AcXROVvGGGw/KK2a8fI3pgxuvJ5yZxNz3CBJrDxR2qqN3YyBIQMTUnaFzSXeiauySC0R5lqc/el7KL4xlM7k8YtCJP7J1KJJuhLmiTHrLEnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-43d75312379so4795408f8f.1
        for <linux-nfs@vger.kernel.org>; Tue, 12 May 2026 23:58:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778655507; x=1779260307;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MZ9M0kS10J2rAHSiOo6d72SfAHsFYWmmZEUF8F/qQTI=;
        b=EGtoC/VxB8V1jcuX1zzvkgdYX8hrk4Dz4k6jhte7TSDv7GLVtOxRPvFdsxdcTrao8z
         u1RIUrZqBC52XsnWtG2f/9+G4JGWENRpej1S9/5p2ys77J7w8MJxt9mh38Ltwskv/omH
         u9G/jT7kIpQpr9JG/RB1thHltfTGQkkgbhGIG6OPC7DnATtRVHjvvnjLADW6q2D9/6Q5
         yUoHiDD23/mjmucR/reHwih6ZZIQ9nba8wDSBNrFKPSaAf4Ku5s9ER1B884lFJfxq0Hk
         sYjB3EznxfDDHCH+/KxJsUVE1q+Za/02HedBlABIMsRiLGV9CHtnrzB/5sgAixMXRgAb
         /jVQ==
X-Gm-Message-State: AOJu0YyjafOeNR5asPmcOTm5Q9l+lzsY7C3HbyQt4AlRV1mDR2UtCGw1
	JrknI37YuNWv8ooxAgpoB2RtregD4Q2pB5ziuyP8YIE0jPr+8Tl+v+K62KXvdA==
X-Gm-Gg: Acq92OHQsYHPeZgm8D7nkPY3XM9p/KTakqHG7XN+Vs0VyduC2f37f0wQiL4eQH8LeF5
	uizbXlraVEZsHSpCxrewVLDXdUc01RvesgKZEtR5u5UbMp2IyidkHIHSBso65kCe8FgVuEnjbt5
	dR7thNiUMSuQPxVIs16cP1g5AT6IvVzz+gRowqFYLA3bRaYhq3LkTU8wZtPpLdhSzrS9wrFoXbj
	0bI6HWaZfCG/YB4vOwM/pDAli0hZVhjyR3kFF6+O+VGlp8wkG0ZN6v+tlRkkyryolKX833iCPHn
	jGUpI+M3UEdWPwzJmW5C8Rk2jMzoRm6My81FXY1s/peagzdbPWF4tOqTxiJ/m3kssQYk70lzW4/
	jD9PNRT/nTT6z+NbmDMjUQ+m/glXveDA02w9m5jQeCiDDmuuU7dRFdJC0IYh/HXdGM2jWtAHhfG
	LXFsN7MmtrSdqe26rxYNkQfeTgvFRMXMDMIl7kXgupB7xxgexIETleNNVJ1wx5PJ+8dEA+rsi8k
	UcFtObuKdxdww==
X-Received: by 2002:a05:6000:2085:b0:457:5a1e:801e with SMTP id ffacd0b85a97d-45c440bc162mr3520752f8f.5.1778655507224;
        Tue, 12 May 2026 23:58:27 -0700 (PDT)
Received: from vastdata-ubuntu2.vastdata.com (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-454917d57aesm38632030f8f.26.2026.05.12.23.58.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 23:58:26 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nfs@vger.kernel.org,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>,
	Olga Kornievskaia <aglo@umich.edu>
Subject: [PATCH resend] pNFS/filelayout: fix cheking if a layout is striped
Date: Wed, 13 May 2026 09:58:24 +0300
Message-ID: <20260513065824.204117-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.43.0
Reply-To: sagi@grimberg.me
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6923E52E591
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21590-lists,linux-nfs=lfdr.de];
	DMARC_NA(0.00)[grimberg.me];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	HAS_REPLYTO(0.00)[sagi@grimberg.me];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sagi@grimberg.me,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.975];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,grimberg.me:email,grimberg.me:mid,grimberg.me:replyto]
X-Rspamd-Action: no action

A layout can still be striped with num_fh = 1 as it is perfectly possible
that both MDS and DSs can handle the same filehandle. Hence check according
to stripe_count > 1, which is the correct check to begin with.

We should not be called with flseg->dsaddr = NULL, but if for some reason
we do, return our best guess with is flseg->num_fh > 1.

Fixes: a6b9d2fa0024 ("pNFS/filelayout: Fix coalescing test for single DS")
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 fs/nfs/filelayout/filelayout.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/nfs/filelayout/filelayout.c b/fs/nfs/filelayout/filelayout.c
index 90a11afa5d05..c28b3d5bfa8c 100644
--- a/fs/nfs/filelayout/filelayout.c
+++ b/fs/nfs/filelayout/filelayout.c
@@ -778,6 +778,8 @@ filelayout_alloc_lseg(struct pnfs_layout_hdr *layoutid,
 static bool
 filelayout_lseg_is_striped(const struct nfs4_filelayout_segment *flseg)
 {
+	if (flseg->dsaddr)
+		return flseg->dsaddr->stripe_count > 1;
 	return flseg->num_fh > 1;
 }
 
-- 
2.43.0


