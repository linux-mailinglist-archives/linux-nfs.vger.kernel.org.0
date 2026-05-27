Return-Path: <linux-nfs+bounces-22022-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cmKTOwEeF2pA5gcAu9opvQ
	(envelope-from <linux-nfs+bounces-22022-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 27 May 2026 18:38:25 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C0C55E7E0A
	for <lists+linux-nfs@lfdr.de>; Wed, 27 May 2026 18:38:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B1939306401C
	for <lists+linux-nfs@lfdr.de>; Wed, 27 May 2026 16:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3273F438FFE;
	Wed, 27 May 2026 16:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dPzvUBxR"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA8B436379
	for <linux-nfs@vger.kernel.org>; Wed, 27 May 2026 16:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779899457; cv=none; b=kyjy/ALuAPer8pcmniny/V4M4bdU54BLIzcZzE13dToRd+crXLosrht7jvBEBALx2xsPHkKsTL1HdU3/ys0jAhqSt8Y0MHhS8IRmeJGOUvBAnfm7HMIp5iIdKO9MgeETZlPhofZl4HYROdenT9POCBHSJU5yXFdSjg/yR8qo4rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779899457; c=relaxed/simple;
	bh=au1B1idzmviqSEnIMRgvFiKgYlGG8vetxZSvl9tT9uI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fY17zxhv/bi5AhU//qRlFpd9bactJy/Ghj12VaBNvBIcSl+zBiUULdRdOoWrp4ofW4wMp8nhVlDClJ9bnzKk75Vn3v+nN0QdwGoyHMHmhKyUpUtOYPrO3nmEeqR6fmBenW7Od9qhKzMcOD20H5aEh2ECauRa6Y6fQebR6r79kgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dPzvUBxR; arc=none smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-65dbe04fc1bso12026265d50.1
        for <linux-nfs@vger.kernel.org>; Wed, 27 May 2026 09:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779899454; x=1780504254; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xHGOkpSqPyA6V8pXIPUUSy/4t7q9czhH9f99sPgTYbI=;
        b=dPzvUBxRs2lz45ZAVCqW2KHARZ+gHmtNU/zu6ve6RCsQQ5VyikFsZH16sr9I4dZyqr
         T8XST70RG4jdG2zWcQ0KBpFRu37SeOlxg9TtOuGjKwn9WgLpEYIHQgxAhizDs1OwWlvB
         G9CF5a0MWP1mODT2CXsxcjUtJENO69T8o6vxvB/2shMmS7l4h6oNc+x//CdkG/8ehSvT
         X7LiKndf6HEhiglnDpVgbKY9p8EP3G3+jisASii/u217mj6/K2xxcI/t76pmUBThxZEc
         GW4LU0lXgX/sfRq3a86jNAIIrtp2sAtDl1S3hfuzXX3g6TeiI4VKuEeOKGTI61y2NekA
         /jFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779899454; x=1780504254;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xHGOkpSqPyA6V8pXIPUUSy/4t7q9czhH9f99sPgTYbI=;
        b=d0p9oLflqjTeSM6Cx6tnhDp0OvLqm6MlyAVDv+qV7j64EJEZHT6Z/tJeLQ80mchQrM
         JwFj4sThCIxejC79d+H2mB5iPMabiYLZj0gS+8rUHy2N7IdWSvKHTXNUltYxkEJEc+v7
         cbtrnafR1BvXNA978XDRaU7jpF3c2fK3r7LIw/N6GL4sIwOeMy27d5Gw+0vOFhrSRy7l
         7aBtloVCPntXmACw9WGpbo6MzPoYAf2ILCfYEGrTX4HZG4pqSJXQEgAwwXI/UIHac1vC
         dBEAXxTwP/0it3AdSqzp0Ga7y/dm3XDiLC4Tl4a8Xgvz2sx/ehrbeYchuuOJydz9lXAP
         WzwA==
X-Forwarded-Encrypted: i=1; AFNElJ91svfSeZilHq6DJTBgBYyE4JbPqPfcHKf4KARi5N55ViePGig2c2XlKdztMNx9YwycIRywk4ZHeAA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxC9+VXLb39v3W4Ly8+EISr5qSAbnAOdWliPe6hHpmCJcJTw4mP
	YCZMh+ZikRzzGCXMzJjtCpA0Sdn+q+CvsjD3dzITGOmxBLpoZS/JgPKO
X-Gm-Gg: Acq92OG2nnxuRaaC1fjKMWy6abWxZCUvwX8gkLKtnt1qVodeMhQM2ayTUrJEDNq0blP
	UYBxK4h83qT6U5qLp3DbtCW4dv5XZLhTvwFx3P+lKjGXesclvPbVDwCB6urj35EQZH1OaoSzniA
	EQc/GBRMK8w+WNp+3F3VEETNhAnXBc1jjcdWhEZwY24i4nqWClWVw+9lu3u+coBl5OQC0Pz8XSM
	9M2iszqWmFZUVHpbzw67+wkf60R5Kw9ElPbh2tx9lYduY2SKt0FG6ULNF/zi9Yo07LwMNf/IDCu
	OhPwzk5HW2Bb0iDR5gPgoNC09Q28TelB9hLx0KFO6UOz4RL6VQHIodWDWQmv7dwvjW19KNA/ddi
	txXEwxpUOx96Ycdy3Mf1MJPENRFXnZXBIRQQ1SA8Ic7/NdhuBiZr5uCGuUP8umoUvNe8xhUJrqI
	fYF/2lvtgNI2P3PFWwZGURusU2huRYLkk/gwU2KtsyTWHGIWWs8TpWQH9qoO3Wg1cGOf7WM0n6M
	5CwboSKb1arfMsmm+vyS387A63XoypIjvp4nxfXWbCwXLnJx04PIA==
X-Received: by 2002:a05:690e:4289:20b0:657:1da9:7b36 with SMTP id 956f58d0204a3-65ec965ca03mr16989941d50.17.1779899454350;
        Wed, 27 May 2026 09:30:54 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cc812e0413sm188819356d6.31.2026.05.27.09.30.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 09:30:53 -0700 (PDT)
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
Subject: [PATCH v2 1/2] NFSv4/pNFS: reject zero-length r_addr in nfs4_decode_mp_ds_addr
Date: Wed, 27 May 2026 12:30:35 -0400
Message-ID: <20260527163036.1524927-2-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260527163036.1524927-1-michael.bommarito@gmail.com>
References: <20260527163036.1524927-1-michael.bommarito@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-22022-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 4C0C55E7E0A
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

 fs/nfs/pnfs_nfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

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


