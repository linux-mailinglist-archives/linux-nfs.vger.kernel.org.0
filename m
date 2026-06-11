Return-Path: <linux-nfs+bounces-22517-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DNPuEl8iK2qO3AMAu9opvQ
	(envelope-from <linux-nfs+bounces-22517-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jun 2026 23:02:23 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A3EF6755AD
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jun 2026 23:02:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=hammerspace.com header.s=google header.b=JitdQ1M0;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22517-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22517-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=hammerspace.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2BCF7312A83E
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jun 2026 21:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 483483624C5;
	Thu, 11 Jun 2026 21:02:20 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0CC36403B
	for <linux-nfs@vger.kernel.org>; Thu, 11 Jun 2026 21:02:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781211740; cv=none; b=OT0DR4grhxAuHz9YvkOrfXKX3OuILziAVAP0o/2Pwb3CbYisOxUEXIa0L6Mi15ke6t9A0YovG7DQyKRBrxKkf/RrAgGJUY7jOexAnknO1HQlFSGBGwOtBScEJl/XQSva7XkurrN7alWh8SWcA/xA1jhViQY1B2mPja8BrU7s6mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781211740; c=relaxed/simple;
	bh=C/XF1KBCPyp1iLX3144J1P57MzJBp2tT4lK8bU2T56k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qe3UhABNzEPNvN7rozDmW13wHC1iFnZACkVEwW0YMidFYCLeVPB9js91bchP0PYNhgF3ZHNqekska3ddeyaMyCfe0w84Lx3M+5KoAdnjml5eoG+IjyDlLiSOrNC4LxnnjMQzn93T2WPRgGtYXUQOhwgxI5qvGs7uixWrepDvE6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hammerspace.com; spf=fail smtp.mailfrom=hammerspace.com; dkim=pass (2048-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=JitdQ1M0; arc=none smtp.client-ip=209.85.161.52
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-69e66e11386so174342eaf.3
        for <linux-nfs@vger.kernel.org>; Thu, 11 Jun 2026 14:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hammerspace.com; s=google; t=1781211737; x=1781816537; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QMG6xmnDztSkSy7FDl0NP1E2iEDHgthTwtXRGrFHebA=;
        b=JitdQ1M0VfDbEQYatCUfvCmZB4Bcg4Jnub4GteNSr3xelGHb23eF2gceD2s2lw7DOP
         pELNEPClS7/h37+GlK1MmhDAJg2PZW8axWc37ZyipxeG7y3EzNrK4XblblVEZW/tpSbi
         6DGa25B2EGMi3OXY3HqMzcGkWI2XuIjkntNWoX6WGbCxSbpErzEaplxuDc7PADEpUCXC
         YmDpcTqqJSztcv74yla/5UFiGC2NGmmxzr1m58xzXed+swvTDv3vZnFgL9N3MM8AC2oy
         pLjNjivFiclqhRITtnrQnX6XgCk6jYz4EbKnqjw7attQbGhEATYY+woK95DJNx1fE7Vc
         r5cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781211737; x=1781816537;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QMG6xmnDztSkSy7FDl0NP1E2iEDHgthTwtXRGrFHebA=;
        b=Dpn7NMrFhzfb968iGDlmQJwSIwcv6HsLhFr+6yXXL6ZzGKTVtIwAdid+d1lwJ7ZcJe
         /js9VUUyr6f9frW1TPc1PXWdr7U2peBRADFFK/Lty8b5QvCcExpPAoUdqjaU1wWrnoYn
         VUW89NSTZLbSpsdifZAeDhA36Lo0zbcLsz4VHeArjodjvkQn+yy1ob7Vx9aSypJI9YLQ
         RHemeBTDC2G00xJNXTQM1Rkqc8jx+WWESVtGkBLD8C+L21rLb0Y3YyJU8Pj4vKVMZzJl
         w14Dvga78Xa22pc08TiE82ssFMacC3OIAIfHP7C2xYf/UwFIntamzMcQkbzz+AdJV/h8
         UsRQ==
X-Gm-Message-State: AOJu0YxHEpazXzKUjiD1wdJoEh3oU5bMLXK32m+fidI1kmWZExE3zYIn
	JWe8h3zrHhPp0CnKVvAc3dvtb8SB+D42Qa/BsKc7N7ReAI1VXnTB1EfBQZ9Itp46qsI=
X-Gm-Gg: Acq92OHXQ5RfQ9uQP7u9fW+wDcTTIsgRGu7zb1LvZarIFOH1f63xX5uqVCJOlG9kOtx
	YbkDhyN3Rh4Hk/cLSfdrSjUHxWzuVxkp98/bBO6riWrmaa/dusnSeE7rBEBph0Yt5nFVVu0bJ37
	MamISpIRg8ZQ8H6Y5VQdizLd+Hk5iMslD2COm0tNN25J3JEZq/v+Le5b7F51NI1QZu2SetYpp9C
	8NWmzv2NNDfoIB5bV+acxs4jbhirhycxe42leW2DgJlWeHWBZOxwpcegjtOoYYd5ygh91auM+Ui
	dkMyE49htt505dVBbIRLQ/MbUJFKfxIk8h5gLBm23IceZHv6aGShSO5BqZmt0X8VPWDlqrelubM
	yuVoe3caDwud9A4LzWc+zhsqCs/ftQR+sC4z+TX/xszRIKZMNSGrLiKMpPBMDUnDeYOyYP6E5OW
	wojUaOF0B+0qR+aOTedcAVZ/AVUwJd0OjEg4FGugjK39RCEh+ZnWCMWcDeXtw=
X-Received: by 2002:a05:6820:178f:b0:69e:2cb4:2ed8 with SMTP id 006d021491bc7-69ecaeddf06mr3297754eaf.26.1781211737357;
        Thu, 11 Jun 2026 14:02:17 -0700 (PDT)
Received: from bcodding.csb.hammerspace.com ([66.97.168.37])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69ed859454esm460370eaf.15.2026.06.11.14.02.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 14:02:17 -0700 (PDT)
From: Benjamin Coddington <ben.coddington@hammerspace.com>
X-Google-Original-From: Benjamin Coddington <bcodding@hammerspace.com>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH] NFSv4: include MAY_WRITE in open permission mask for O_TRUNC
Date: Thu, 11 Jun 2026 17:02:15 -0400
Message-ID: <47bbb0cddcc9a767aed56ff0cbae5135a2eefb13.1781211392.git.bcodding@hammerspace.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[hammerspace.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[hammerspace.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22517-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER(0.00)[ben.coddington@hammerspace.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:trondmy@kernel.org,m:anna@kernel.org,m:linux-nfs@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[hammerspace.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_NEQ_ENVFROM(0.00)[ben.coddington@hammerspace.com,linux-nfs@vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,hammerspace.com:dkim,hammerspace.com:email,hammerspace.com:mid,hammerspace.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2A3EF6755AD

POSIX requires write permission to truncate a file, so an open() that
specifies O_TRUNC must be authorized for write access regardless of the
O_ACCMODE access mode.

nfs_open_permission_mask() builds the access mask passed to
nfs_may_open(), which is the local authorization gate for OPENs the
client serves itself from a cached write delegation via the
can_open_delegated() path in nfs4_try_open_cached().  The mask is
derived from O_ACCMODE alone, so an open(O_RDONLY | O_TRUNC) against a
file the caller cannot write requests only MAY_READ and passes the
local check.  The OPEN is then satisfied locally and the truncation is
issued to the server as a SETATTR(size=0) over the delegation stateid,
which the server accepts under standard write-delegation semantics.
POSIX requires that this open fail with EACCES.

Include MAY_WRITE in the mask whenever O_TRUNC is set so the local
check matches the access the server would have enforced.

Suggested-by: Trond Myklebust <trondmy@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Benjamin Coddington <bcodding@hammerspace.com>
---
 fs/nfs/dir.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index e9ce1883288c..cb7ddaefdfb2 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -3344,6 +3344,8 @@ static int nfs_open_permission_mask(int openflags)
 			mask |= MAY_READ;
 		if ((openflags & O_ACCMODE) != O_RDONLY)
 			mask |= MAY_WRITE;
+		if (openflags & O_TRUNC)
+			mask |= MAY_WRITE;
 	}
 
 	return mask;

base-commit: 979c294509f9248fe1e7c358d582fb37dd5ca12d
-- 
2.53.0


