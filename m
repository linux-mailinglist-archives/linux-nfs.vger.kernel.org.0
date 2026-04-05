Return-Path: <linux-nfs+bounces-20661-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IFUAJlni0Wm8PwcAu9opvQ
	(envelope-from <linux-nfs+bounces-20661-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 05 Apr 2026 06:17:29 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0324539D4A5
	for <lists+linux-nfs@lfdr.de>; Sun, 05 Apr 2026 06:17:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BA6DE3007F4C
	for <lists+linux-nfs@lfdr.de>; Sun,  5 Apr 2026 04:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E57C318CBE1;
	Sun,  5 Apr 2026 04:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="seKwvMnU"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7062745E
	for <linux-nfs@vger.kernel.org>; Sun,  5 Apr 2026 04:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775362646; cv=pass; b=PFW+llmF1eftVDhHC77o3NhSneJ/hFTkcJv9im0w8cFJ/CJQDtXy8tddS8fWr4/m6pqhdBeux9+e0EywsMl16+ZkN2a/EPjJ0Gnpcyg3m3S6iBqggcRWOsPHJEAI3i3K1P7RE1t6egagpsL+FdBlmjAQbEeoZ/G+lOZ70Wee3GI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775362646; c=relaxed/simple;
	bh=CuBrSQ24eMijyS8UQwKaEoWlLrgwyAVb6j0yAIwOcf0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=GIXAOV/CCYnrk/9657UG3o7cmgl8M5veNemCW30oaioUrY5PTyHbUbpRtnp0oEmfoLV1DPJ/d4zowL3vQdqgSW+zoqYnUr0HRDgAVeabGUen2KWhlhnIj+naTBj6GGns4AMQLp7hNZ3l8rgs2yygesW5La/hBq2Xy040ZB0C3gg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=seKwvMnU; arc=pass smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5a0fc5e2c59so3033353e87.1
        for <linux-nfs@vger.kernel.org>; Sat, 04 Apr 2026 21:17:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775362643; cv=none;
        d=google.com; s=arc-20240605;
        b=jpUSgLBME3dV8ePBrlG+GjgJDv9K7jzk8xXMGNZw7xh+khxkuBc2Ww/JmI9loRPtNd
         sOZ+K406hrU2Y1MeysKey9BONEfeEwHCAPdSHdV92NqFN3iSzxscemcR4/P0RS7zERw9
         /tjr+yNoh5vhSpCRrmk1yTf1ApYVket7xG1VwmmuiYSSEPlJw1aOoCUmhxOtZuq4lEmf
         AkuwhV6DfaINCRCN/kAn1/HI0U76luCrpjCdh2czLU15ERjVkS+WFX4Ny+43eBktTjbG
         G+zWjkGTWhbKAb/DZKB+TMhkFAM1WMIfgeEzJ/LwtcjzZXGJrxPN/sopF7D3/SSzvS6V
         WdGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=JyGs0UKebTSSXhuxsNJGT3Yfl69SoJMcQxxsCuKFLDQ=;
        fh=soBZ4z6rOOq+fMpsmYxnZXfEKbWcTG96XLkb/GGLMbA=;
        b=V/B48vn8oCIOjjBypUS3LpOrBK4V3XPu8NTKioeS9KE0lwLQDAugveIhHZKtNey+lM
         o8AscCgcrd2LV86mr/dFI4FHZHgTea+/eyaQmA9biz5Yk9kh9TtH4KkMzqU2W1bopb+N
         /17NGgh0svf0ZacIiRUSpjrvGvaKzKI3oVvAyp70LtbZrloqAqOLgGdJUgoCVx1TVgxB
         BgfSdvWoByIIWiKw1nH5REIvAvum5K+OJux8+8kike9wU+7XRCA5ZMpUGcXYy6yzaouN
         DR458bU8utIm+/SYSsBjGv0K8C+J6SzD+XTEVc5XfH4N7yhcpii6lubtpp679hcFY5E3
         QvGg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775362643; x=1775967443; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JyGs0UKebTSSXhuxsNJGT3Yfl69SoJMcQxxsCuKFLDQ=;
        b=seKwvMnUubLqYkNga7nkeHRupTpADitqlBI8s/NtMv/r7gUp2f4F6TWSuh2pCIQxgS
         4u5AVm4DsbSPABBC52dqkz+qCnDSb26AnNYRiM9Hhahv9j9kJvqCYYdpAY/zUABumRZk
         J9hSTN/bSGhiAoSOE6UVNMRuON3nNDUjlSPo1vo1fF4aBFee0W7fAEn+Gn6SoqgJdqgZ
         CcRdwl3FRMrKW39JBD6ZWy1X8cb47g8r3xDAraKGW6vI2c+tbjBKUQTeqJ9oPPgUwqec
         bfEZ2EvdbFvIYWDbM97Vn3v9pi954b1FzbUpPfIY+wJU1gRsw1iJVMLv2Z8t4BR1V9z8
         mQcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775362643; x=1775967443;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JyGs0UKebTSSXhuxsNJGT3Yfl69SoJMcQxxsCuKFLDQ=;
        b=WE0kXHnC3zOL0kN+H6lThdWCpuoGeYXh7OwMD40i11k8Wg8SJuvJqoz5GWeRf0rc5Q
         febhrjrtLocsKBjt+yIcbhYPKykG4K/xv60VhRMkE+5TlhDzwcjA4pycD5fUw/anm4zp
         JpdO6eiO27p7hDtabTzkIA24JWUJ1aBzH6HFIeAWhlmprBUSWTuNydaG1NTNmLvLwMv0
         HXw/yPlwciF9iwasHuK0agr1dSVPxxCG89MImppFFhgOHD12X/efePtPrOxq3Lv73TyW
         Ycw4Mid+a/ayuCuozH0chrpbLTCPPy1CGUjh8svjDXQm0k4vk4NOni5tx/NlO1ZdHff/
         3DZQ==
X-Gm-Message-State: AOJu0YxHibmhCxLdb79HnevdQ2iDe6pScrWWg8lTFyAwSHLrZwbcFnSC
	IXl0X8QUMFB1Me9sjjFjDde1r4GfaDXWzj7bv5MsTakbDmIYQovrg8XZCaP6R2eqkc9+Dkx+cI+
	bfprSz0uXoBodyRif3r9xYvyUbHiokDVZwFxR
X-Gm-Gg: AeBDieukiuRuqO5gsoaikX6P6z3zKoUa44eSVtGRXP4lH9skBCWgGqZhYbftI81UmEH
	begJSDHJRz4FZ7fPznbnv4vmp0mRYCeBX7vk/Pums+3xLy3YUtH6J1ll7BLZvVeGVaohKrIyhJ/
	IlOgHjrz8/YRGVL566XUC5QCcSL0BOz+OC8640O/f/ShnY10gwIF/KDh0Q5gmhP/tPiaCOIVapC
	UTbQoDmF550cFzh5hgxO773g7dEeRLGS03IvI+dsTsMN23n+J8WssI7YMenJG2+4rSVyVK5kHlA
	SgRwTmM=
X-Received: by 2002:a05:6512:12d6:b0:5a2:78f8:60aa with SMTP id
 2adb3069b0e04-5a33758f27bmr2823052e87.37.1775362642829; Sat, 04 Apr 2026
 21:17:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Hiroyuki Sato <hiroysato@gmail.com>
Date: Sun, 5 Apr 2026 13:17:11 +0900
X-Gm-Features: AQROBzD4iU2asYwfDWJrioPebwn0udo4yQ-RZN6siBorn7m7_EvJaTNOaB0BOuE
Message-ID: <CA+Tq-RqDP_BAroLX6wVrNY1BMwC9BOZ-UorLje=TXBdEOj8hjQ@mail.gmail.com>
Subject: [Q] NFSD: COMPOUND reply tag padding not zeroed? (e.g. \xff\xff)
To: nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20661-lists,linux-nfs=lfdr.de];
	TO_DN_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_ONE(0.00)[1];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hiroysato@gmail.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: 0324539D4A5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

1. Observed behavior

* When sending a COMPOUND request with the tag "create_session" (14 bytes),
  the reply is expected to include XDR padding to a 4-byte boundary,
  i.e. "create_session" + "\x00\x00".
* On 5.14.0-611.45.1.el9_7.x86_64 (AlmaLinux 9), the padding bytes
  are sometimes observed to be non-zero (e.g. "\xff\xff").
* From inspection of recent upstream code, nfs4svc_encode_compoundres()
  also appears not to explicitly zero-fill the padding.

2. Questions

* Is this understanding correct?
* If so, is this a known issue or something that should be fixed?

3. Analysis

* In nfsd4_proc_compound(), space for taglen + tag + opcnt is reserved via:
  xdr_reserve_space(resp->xdr, XDR_UNIT * 2 + args->taglen);
* In nfs4svc_encode_compoundres(), only the tag payload is copied:
  memcpy(p, resp->tag, resp->taglen);
* The pointer is then advanced using: p += XDR_QUADLEN(resp->taglen);
* but the padding bytes do not appear to be explicitly zeroed.
* As a result, it seems possible that uninitialized data remains in
  the padding region, which may explain why non-zero values
  such as \xff\xff appear on the wire.

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs/nfsd/nfs4proc.c#n3055


```C
/*
 * COMPOUND call.
 */
static __be32
nfsd4_proc_compound(struct svc_rqst *rqstp)
{
    // snip
/* reserve space for: taglen, tag, and opcnt */
xdr_reserve_space(resp->xdr, XDR_UNIT * 2 + args->taglen);
```

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs/nfsd/nfs4xdr.c#n6389


```C
bool
nfs4svc_encode_compoundres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
{
    // snip
memcpy(p, resp->tag, resp->taglen);
p += XDR_QUADLEN(resp->taglen);
```

4. Additional observations

* A packet capture excerpt (attached separately via gist) shows:
  (https://gist.github.com/hiroyuki-sato/8ab30dffbbd2499e8b4741d89fd383be)
* The issue is not deterministic: when repeatedly sending CREATE_SESSION,
  it was observed roughly once every ~5 attempts.
* This was discovered while implementing an NFSv4 client in Rust.

Best regards,

-- 
Hiroyuki Sato

