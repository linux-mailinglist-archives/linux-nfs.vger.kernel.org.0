Return-Path: <linux-nfs+bounces-21850-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IPGTHqkFEWp+ggYAu9opvQ
	(envelope-from <linux-nfs+bounces-21850-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 23 May 2026 03:40:57 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EF4135BC5E5
	for <lists+linux-nfs@lfdr.de>; Sat, 23 May 2026 03:40:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E5576301DC13
	for <lists+linux-nfs@lfdr.de>; Sat, 23 May 2026 01:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0226279329;
	Sat, 23 May 2026 01:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="foIDOb2j"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0873025DB1A
	for <linux-nfs@vger.kernel.org>; Sat, 23 May 2026 01:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779500442; cv=none; b=PUE4bW54d6AsEdHcKRYpPgSLkC3I33d71n/SGFTPmKXn6X/z5hW+Hv7sSWkAk7EQRDmDUV2u0r3gIeOg7WhaF3JbZmdhXUP9P8+R/CMnPHxTrqwtdct750Q+FetJVJqBU5ORE0jX8qRjHhZvbFvzPMTsMrfuvtDgcwsyn5IY8+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779500442; c=relaxed/simple;
	bh=ESbQr55fNsYNb1/DBObk305jbsHQFrKluJIJGXJV+Xk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QxAF4KeGIgeBNi6dji7Md5HQioKMOh7S2IK1HHwP0zsrBbeomUeuGy8W3PGNt2s0lLGYMqAAV/zK5uwowXXUD2jbeDaci+3WE1evUXOsmc7qLgFsQRGsB6YQehPWloa/27ZUHph1kpea6RpBYzbohrXLNVRBYU2iVz5OWThnwWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=foIDOb2j; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-516d15ed2bcso18183401cf.0
        for <linux-nfs@vger.kernel.org>; Fri, 22 May 2026 18:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779500440; x=1780105240; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e4WE67d3yOm7V6IzrZ9cvMKTT03sFO+GY/Hwtj8Zxsg=;
        b=foIDOb2jfGLOQ3OOoprusSJVKU3peVCY0QB811LXiW9JAqfug+hATMOoloC+S9xFBI
         Z33I+sDwxEyTcJYIiewRCsCpuPq+NUI6FM5fXZ99LbmlX8jvKdTdv+1SYlXjLQ9eq0/C
         oHzLj+V756CX21HnLuGzu/hNoTLCgDwgvhqjqgVaqTwI1wJUApyT62CJboA2MbEY9dgB
         VHzzGMYhz04Kn6q9F7eDkIgtBGAhxZjj9K10ZHETZi7iZ4/LhUOKLD7fNcYscoC28Q5r
         GfgvB6vY+Cd2gBsYnw80gEt7EkQvV8TTP74z7RnhngC3AvEYflQ623PIo80r6eHy8Hts
         GCEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779500440; x=1780105240;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=e4WE67d3yOm7V6IzrZ9cvMKTT03sFO+GY/Hwtj8Zxsg=;
        b=XmNC6XmMS6ePu/Y6g+leFeXYC6bWRVO0vmysiMUdpluIuNDA0sJrht12bH+a85/pwp
         JG0o0lVVxxBZ6qus5kyVTJ6nWZWPk0rvnDq0oI+9OmMT2MyOs4oVf2msVHhoPTCF4/+R
         0LGhN00rBW+8wfyGMwPIIQ3pPXAiokp5KL5eUFmpJbLThrq8ksFP5IojR8ElgFZ21CR3
         jOR3jLtyaBGWM1Ardvm9TkDxO5fOvM8Pu3bg9f3v1CdJOEBwFfIqGhuI23HG4QD5pbjh
         MA7DkDSRUyoYOSTHfWPYu53mvRwO6COb/p8KewKQptzm2sOm7UdBMPUhsRJOJebgn81e
         WoHA==
X-Forwarded-Encrypted: i=1; AFNElJ8mdJr9iJpJxodKaYvsiaq3Z72U20/MEcRqwH3g1Q6SSDC5aECLllxG5zccIGxN/F2MgD/I/4tcrCs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcTx7rcRVxov3lxG0uXKMZC9zmE+7mlPym7Bp89JTFGwI4BcCY
	viRYQglqad2tzkkZCdOWU+14SxC0KK4/XeV3AFaRdTMqp7eTwSAE0/Qb
X-Gm-Gg: Acq92OG0RupDFmR04IQyxNWH8CwQ9sXHFmR50jj8O9V8aCh6OrIK9TcOO2JOpmLW7Ym
	dG2O24UFM+jAI8xweHmh5WkETgO1KH+PvSncAMJKggqN4J91obg4jr7dCp6dDcz/e2f2MQvs3/f
	bEIR/r83Gvz+GljogafuqxDqYXhiRPxXldS22wp6vW0GqgwtnmN3/GBuidfo6qxd1PpQua+FzRt
	wATrYSb6gH8zVzemxC3SK6CZl+dLHznd8yUiP3DfY9t5bnUi5sdjvJ38UEgPBSHcmWQT1uh4+S/
	cdsJ6XhfbxwKaKPcTomnppuyRLGzYLMt4SNdzOJaOHwUc8I4WirbWAQkIgKNGH0YQBtmHjCQlqM
	kCRvh8M1dNAi6AH8fCb4S2xEZvmq65PjkfT4TtvQTabQfjkgOFuCqyTbLxuUjdTzkv5VQOvoiNp
	i8dJZtF36mUDVZ4jUCagmQ7iugKtpuHPLVKqhta8ZVuiOMqXVfs0n/nacwkdk5hY7mBR7VCCBRC
	4pk4d6W+CbsUMqJlE0r
X-Received: by 2002:a05:622a:5a8a:b0:50f:340f:ff35 with SMTP id d75a77b69052e-516d58a9118mr67895161cf.26.1779500439995;
        Fri, 22 May 2026 18:40:39 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516d8b247c4sm28559031cf.7.2026.05.22.18.40.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 18:40:39 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>,
	Tom Haynes <Thomas.Haynes@primarydata.com>,
	Peng Tao <tao.peng@primarydata.com>,
	Kees Cook <kees@kernel.org>,
	Mike Snitzer <snitzer@kernel.org>,
	Tigran Mkrtchyan <tigran.mkrtchyan@desy.de>,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 1/2] NFSv4/pNFS: reject zero-length r_addr in nfs4_decode_mp_ds_addr
Date: Fri, 22 May 2026 21:40:32 -0400
Message-ID: <20260523014033.2459677-2-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260523014033.2459677-1-michael.bommarito@gmail.com>
References: <20260523014033.2459677-1-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-21850-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: EF4135BC5E5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

nfs4_decode_mp_ds_addr() decodes the r_netid and r_addr opaques of a
netaddr4 from a GETDEVICEINFO multipath-DS body, then immediately
calls strrchr(buf, '.') to locate the port separator. Both decodes
use xdr_stream_decode_string_dup(), and the current code checks only
"nlen < 0" / "rlen < 0" before dereferencing the returned string.

When the on-wire opaque has length zero, xdr_stream_decode_opaque_inline()
returns 0 and xdr_stream_decode_string_dup() falls through to its
"*str = NULL; return ret" tail, leaving buf NULL with a return value
of 0. The "< 0" check does not catch this, and the next line is
strrchr(NULL, '.'), a kernel NULL pointer dereference reachable from
any pNFS-flexfile client mounted against a malicious or compromised
metadata server.

Reject the zero-length cases explicitly so the decoder fails with
-EBADMSG (treated as a malformed GETDEVICEINFO body) instead of
panicking the client.

Cc: stable@vger.kernel.org
Fixes: 6b7f3cf96364 ("nfs41: pull decode_ds_addr from file layout to generic pnfs")
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
 fs/nfs/pnfs_nfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Reproduced via a malicious NFSv4.1/pNFS server returning a flexfile
GETDEVICEINFO body with multipath_count >= 3 and one valid
(netid, uaddr) pair.  Linux 7.0-rc7 + KASAN, QEMU/KVM.  Stock kernel:

  Oops: general protection fault [#1] SMP KASAN NOPTI
  KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
  RIP: 0010:strrchr+0x24/0x80
  Call Trace:
   nfs4_decode_mp_ds_addr+0xca/0x570
   nfs4_ff_alloc_deviceid_node+0x357/0x1370
   nfs4_find_get_deviceid+0x6b6/0xa90
   nfs4_ff_layout_prepare_ds+0x3cf/0xa40
   ff_layout_choose_ds_for_read+0x14c/0x350
   ff_layout_pg_init_read+0x2a2/0xb90
   ...
   nfs_file_splice_read+0xcf/0x190
   do_sendfile+0x8eb/0xdf0
  Kernel panic - not syncing: Fatal exception

Deterministic for any multipath_count >= 3; multipath_count <= 2
does not crash because the loop ends before consuming the malformed
trailing bytes.

Patched kernel rejects the same crafted body and a baseline
multipath_count = 1 mount + read completes normally.


diff --git a/fs/nfs/pnfs_nfs.c b/fs/nfs/pnfs_nfs.c
index 12632a706da88..0ff43dbcb7cd7 100644
--- a/fs/nfs/pnfs_nfs.c
+++ b/fs/nfs/pnfs_nfs.c
@@ -1075,14 +1075,14 @@ nfs4_decode_mp_ds_addr(struct net *net, struct xdr_stream *xdr, gfp_t gfp_flags)
 	/* r_netid */
 	nlen = xdr_stream_decode_string_dup(xdr, &netid, XDR_MAX_NETOBJ,
 					    gfp_flags);
-	if (unlikely(nlen < 0))
+	if (unlikely(nlen <= 0))
 		goto out_err;
 
 	/* r_addr: ip/ip6addr with port in dec octets - see RFC 5665 */
 	/* port is ".ABC.DEF", 8 chars max */
 	rlen = xdr_stream_decode_string_dup(xdr, &buf, INET6_ADDRSTRLEN +
 					    IPV6_SCOPE_ID_LEN + 8, gfp_flags);
-	if (unlikely(rlen < 0))
+	if (unlikely(rlen <= 0))
 		goto out_free_netid;
 
 	/* replace port '.' with '-' */
-- 
2.53.0


