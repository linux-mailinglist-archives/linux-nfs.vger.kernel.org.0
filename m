Return-Path: <linux-nfs+bounces-22758-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IYRjKjgvOWpxoAcAu9opvQ
	(envelope-from <linux-nfs+bounces-22758-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Jun 2026 14:48:56 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 018646AF8D5
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Jun 2026 14:48:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=mmvgLgv4;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22758-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22758-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 62E92300D141
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Jun 2026 12:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF66D3ACEF2;
	Mon, 22 Jun 2026 12:48:44 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B553546C9
	for <linux-nfs@vger.kernel.org>; Mon, 22 Jun 2026 12:48:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782132524; cv=none; b=BsJPaTmRUH5n+dxuTBLwJRMt5pV5Ge7tkeYNz3hbuqj1naFPIFdxyOGloxfdg5Qa8/XeFolUQbPOQX67q42gpu/fJOoCIar20uWnfk5bu4Mrc+lLaM/Q+mOhL9cqNwDbQaRhAzsYUjD8yC07D73VduWgkSGQ6jlJ5V6OBfsa3Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782132524; c=relaxed/simple;
	bh=7UhmVNifHvpWdygs/hKPkb3kWpJCJc5El/F496P6DFc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ge2UHX/7GB/8X9WUEgU0gbXA8q0po3pNKFlpUmG9O58UHk9Hq5u56rNgV+ScrXU2HcN8C7M7+V9g9JKMdFtG1hMNEe37puxabJPM96Xpqbx8rZifhukn0xSBktiu3lAeHod/+VyNfQVxyD4ZmshiYpY4pdL7DCpB1ci6Je8SCxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mmvgLgv4; arc=none smtp.client-ip=209.85.219.47
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-8dc09919aa2so75379756d6.3
        for <linux-nfs@vger.kernel.org>; Mon, 22 Jun 2026 05:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782132522; x=1782737322; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lR9YIUyduaBXmLFLPkW+UdZWKjIZIGHLZDh+rPpzMHE=;
        b=mmvgLgv4o1cuWyJzbr9/QVZMXLR6+BA0DZs0j+8y7k0Pb4Y9nBkYfhMpDN/TpY7PGE
         +WxvZ/jJAoHNG//Ojd5rbPFDjkmbB/kOnliyyVK4Sn2CSN4U76ZJmPO9iSOWgaX6iHBa
         v3COq22ZvjqUSUrcBhImyVVzd9tEYIJfnpT/C5q79Slews+ycTcw5nPOk9PXbqSRlSQO
         H3LIFylIPsEbixTJbmdYHLGtxhGi0YuMiZRrtABAkkjZnd4OIchR9iW/jrm/biLggmRf
         6GGFVRwbnwyZNTHT2vSAXaGJLEyNi4AHEr0Gcsf9/8Sa4S/C3zfJAKvH5YPp3YCV1AYE
         OKfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782132522; x=1782737322;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lR9YIUyduaBXmLFLPkW+UdZWKjIZIGHLZDh+rPpzMHE=;
        b=D9b54Zxw6VlgJRQzfA0/IOz7TeQ/Zkyo0Sr2takXlb66hWKU5miqMPRgdHLWnK7ioK
         hU0j+OsH1nfh0qRY3rYYBGdgB1isgrbN6efWaZ+ps3iVD0pSn+tR1sVvQsTG+8eOOFZG
         ohmfGf6qeHwWBLwFF5/YfdjB5SSA5IKfwo/X/xd2TIsvDPmoq5G7F96wDKogZAegJnk5
         9dWpyioqt55LP++Q9TA/YbAQNMeMe+EK5FRSGEidxlOCU5SkgX8YFK8qH3gP0ams9GZ9
         HlsKhjGg1K2KDRaajcf2x2Y2BQ8JQHVGeMYHISrI4YPrLrwOWH1NeVME2fgq1qc3dJnZ
         mLTA==
X-Forwarded-Encrypted: i=1; AHgh+RoNBAeSiB1zuyfpOoRTsudV/qNKqj46NlQaDPFRAaVMCjTJkkgEBRgpHF9yVhKjw0E2uj8irR+yZFc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf9c8MNzk9eMqFjwFLkU1eCC4/xB03d+mhShWEqheayu+3m6xG
	0IMlGwo6y1O9UXaXf9MMgn8DnqrcE/p0EFy26wAJmes/lTXONxoLNcf0
X-Gm-Gg: AfdE7ckGl+EeVxrd5sWHVLPiyatvxP2Qhd+GEfdTMNplE9+Qj+t6zVIR99v69rHUy8T
	2i1De/fcJqiMLzK9qXhF3k52Zb9JWgLiAs7YCmvaIdFiKLJPl5LRvhtmjmr//UGZTP+5lMuLl9P
	zzmJ54Kt995ZbldnqKibIv8Lr8uNKXTDxtH6jtUOpL7r8kH92gVDLwQC9dKESLVjdQMJTxK/nqc
	awgxxZpcuODpvJX3Pknkw/hKQI9inesEGaBHU+/u1yX8DAjoA7k0ybT0ZhiEOAKPX8wNgu4xTBW
	n/NCWoEGpWV2wpdr0fEWktABjljAGmcgIIEI7m9rpPmy1/SbIuYpdbrcCha90Ay100GQsUpdlrv
	7G/gri+ObQ2Wkrzd/Wte06ZVBm4luy45E7Nb2XU2ZfeYXC1RZie2yjifBHpuAsRqaZLed2EFzn7
	NBMILb+t8T90Qwb40hI6LCcky7nS6F4F3hjArr6UJa5KZ/NuDYbIVulxts/yQsHDQi2d1iG/TcK
	Y8V+LgvhnNIQRVlK9R329GJ0s0/LZQL
X-Received: by 2002:a05:6214:248e:b0:8dc:4d62:398d with SMTP id 6a1803df08f44-8de3ecd8b61mr233735486d6.1.1782132522414;
        Mon, 22 Jun 2026 05:48:42 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8df81fcb4a4sm93659146d6.36.2026.06.22.05.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 05:48:41 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] NFSv4.1/pnfs: bound layout-type count in decode_pnfs_layout_types
Date: Mon, 22 Jun 2026 08:48:36 -0400
Message-ID: <20260622124836.1696330-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22758-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:trondmy@kernel.org,m:anna@kernel.org,m:jlayton@kernel.org,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER(0.00)[michaelbommarito@gmail.com,linux-nfs@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 018646AF8D5

decode_pnfs_layout_types() reads a server-controlled u32 count and then
reserves 4 * count bytes:

	fsinfo->nlayouttypes = be32_to_cpup(p);
	...
	p = xdr_inline_decode(xdr, fsinfo->nlayouttypes * 4);

The multiplication is u32, so any count >= 0x40000000 wraps to a small
value and xdr_inline_decode() reserves too few bytes. The NFS_MAX_LAYOUT
cap is applied only afterwards, so the subsequent reads run past the
short reservation. array_size() is not a safe guard here either:
xdr_inline_decode() runs its nbytes argument through
XDR_QUADLEN(((l) + 3) >> 2), which wraps SIZE_MAX to a zero-word
reservation instead of failing.

Reject counts that cannot fit in the u32 multiplication before the
reservation, and use sizeof(__be32) so the size arithmetic is explicit.

A malicious NFSv4.1+ server returning a crafted FATTR4_FS_LAYOUT_TYPES
attribute triggers this on the client during FSINFO decode.

This is the decode_pnfs_layout_types companion to the same XDR-wrap class
fixed in decode_getdeviceinfo (NFSv4.1/pnfs: bound notification bitmap
length in decode_getdeviceinfo).

Fixes: ca440c383a58 ("pnfs: add a new mechanism to select a layout driver according to an ordered list")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
Reproduced on a UML KASAN build with a KUnit case that feeds
decode_pnfs_layout_types() an xdr buffer whose nlayouttypes is 0x40000001:
nlayouttypes * 4 wraps, xdr_inline_decode() reserves a short buffer, and
the decode reads past xdr->end (KASAN slab-out-of-bounds read). With this
patch the count is rejected (-EIO) before the reservation. Benign control:
a small nlayouttypes decodes correctly on both stock and patched. The
KUnit test can ride as a separate patch (matching the decode_getdeviceinfo
series). Before/after logs available on request.

 fs/nfs/nfs4xdr.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
index c23c2eee1b5c4..8b7994f61d303 100644
--- a/fs/nfs/nfs4xdr.c
+++ b/fs/nfs/nfs4xdr.c
@@ -4903,8 +4903,16 @@ static int decode_pnfs_layout_types(struct xdr_stream *xdr,
 	if (fsinfo->nlayouttypes == 0)
 		return 0;
 
+	/* Reject counts that would overflow the u32 multiplication below.
+	 * array_size() is not sufficient here: xdr_inline_decode() passes
+	 * nbytes through XDR_QUADLEN(((l)+3)>>2), which wraps SIZE_MAX to
+	 * a zero-word reservation rather than failing.
+	 */
+	if (fsinfo->nlayouttypes > U32_MAX / sizeof(__be32))
+		return -EIO;
+
 	/* Decode and set first layout type, move xdr->p past unused types */
-	p = xdr_inline_decode(xdr, fsinfo->nlayouttypes * 4);
+	p = xdr_inline_decode(xdr, fsinfo->nlayouttypes * sizeof(__be32));
 	if (unlikely(!p))
 		return -EIO;
 

base-commit: ef0c9f75a19532d7675384708fc8621e10850104
-- 
2.53.0


