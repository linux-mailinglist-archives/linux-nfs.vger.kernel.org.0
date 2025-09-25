Return-Path: <linux-nfs+bounces-14703-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71703B9DEFD
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Sep 2025 09:57:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5C311B27167
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Sep 2025 07:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 435EE26E704;
	Thu, 25 Sep 2025 07:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WjPBJr07"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89AE52750F3
	for <linux-nfs@vger.kernel.org>; Thu, 25 Sep 2025 07:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758787022; cv=none; b=uZ61INVi5fQMjLvst+WL3y7BXfV468RyhlsnbRgxoMfh20YFwv8EXbVv1IlF3Bc3g7E0Ml5nYgl/oBYFEqRqY2q1A4LjqSF2QYIiZYW07dOQyBpIzSqiC9855NVU4zjuWI7uqyqNUqJ/8XZD9shPcDnt4qudTOL+GOmavGyFh68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758787022; c=relaxed/simple;
	bh=G3X0HulBzhqLQGcKTKzDjrZkNM1oOZyyGOHbwlQdB3U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t/RduxWKAN2ZP7tE7ACD4oLmTbq/CJMoF940MeSE4X0vOdQlDB+DEj3CHpgkdEFFpzEZmeBlCOeCGuVJ5i0JU6K0jFo3fIHRPGvkAZ0xFvG4fP00m3zwzIdhetBW+rEFUw4oqApTq8lafLKEtUiP9ruxoduMIvddExBX8p20cHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WjPBJr07; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-3515a0bca13so20274871fa.1
        for <linux-nfs@vger.kernel.org>; Thu, 25 Sep 2025 00:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758787019; x=1759391819; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/LvC+F24rOHUo0H6x23FHMGYpNv9JEWx6/Wh3pzddxk=;
        b=WjPBJr07U738o2LPgmOsSeMxBhhUyCH7VOUPfIG+MnO/4czlpFW8oD3qqOv6S6vEkg
         i15mP1HiaieUtfp67i++xk3hHD47Z7axmvkGRJEAokPg4bf/+iy8OQ2I10zJmrlICe87
         aZJE31AM7jjo6vT/49HlZ/nMt+4U4CFmbML63fLVMhUNARrgKvjmu8B3SgSO4CoLNUJW
         FmaXrahc5j0HAHqsexNbN/VohBRgdMvPewNUwylfQWxdtaOJYA+83nDVNxgKqI5mTgtA
         GghUx7D0ze/xL4Ge6XVlx9bVjkF7ChnA20TdcPxaqFgndBxHX83X2/7mkGvRyWJGyaJ8
         bhNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758787019; x=1759391819;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/LvC+F24rOHUo0H6x23FHMGYpNv9JEWx6/Wh3pzddxk=;
        b=KQvr/d2RExfE0YenliwdGCnt/3/F/FCnruXLglmQlm8mw5s5rflAHhjEKJstDXYDoY
         qzMu5W8H4jJ+F7gIUJaPKqLrb/q5BXhG2B1FjY2v5nWCvzQ22SztgIO3IBhLPGQswZGy
         Q4H12nV+ko6/Sz4vyOGmJXsPfAH0i9QgeNBfRpG6ZmZ8sxzeZsBCanIbHqZ4hDF6gySX
         MlNHlqcKTgQObbifIKvg3rsFe8ZGKbrMy99Yq6LIWgC6QHjggNPH2qyJ4f6bv17i6Rzc
         NGZQ5ZO81mc1IRHEqriHGFCZMecbu0GfQGhWmMsfRTPU3P56TjbxGInh/8HHpW1tuFNI
         pD/g==
X-Forwarded-Encrypted: i=1; AJvYcCV/ATdBCbn5y+PIg7YqydgSOai+M36rC56WTacCv7ukNPyEZlzZxSh6MQS4zKtqeGAC5LntALgMwG4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRGsu/TlQaRBHjL1VWVpShd5ykRHfhlm+rDtKLEa7PRL5HYyLy
	xul71HfoL5GNJWAh5//UFbS41tCVzIvIuPQKZNpz5dt5Ls8/FWwCh0+6
X-Gm-Gg: ASbGncsPHx0PvGxhUGqoYlBf/P/S440/CtBEaq8dZF1eUeUS/hQye3iPV9C2XHgcnF+
	ogJWfzaD3R8w3D8GTySLIO7vpc4BPLDqsapuS6ju2v92nO7ScuFcRjFL3evCs+GKnRpyGm1ET6k
	rF8HsVmL2fEUnh8JCTuDcJ4AvsFtOvQGvrz+pfAmiel9iHkCulVqkVEVbPPeXcRuupVryuQ/jFq
	vR9YO5nVZKRCvZ9fqHaIxE//BJJkANamb2lKiw2gwYRodiBfpEYwL28M9BAEnKHjo7bsPpyib4g
	ENOLZR9mfu2sOwAYAUDT5i3aOVX+iFG8lirKtuynScGC/g+CKQshAVd+7Ii8ITbBPgIQ0Zeeu1C
	WeTaurXKcKKkFi+3KONOfOA5fHbdBfmc5H+Xt82v7kiC08AhkeoQXzUIkhYgkV6suq/dWX/dhyE
	ghp+1hpH2jmcpnbh/s
X-Google-Smtp-Source: AGHT+IEy5RHEB8Y3WCb1UHovAH+ye8tCG6UXPpK5piKqgeIHHYdFqZmWGJZvP6OP/JMTKg1WVGuJeg==
X-Received: by 2002:a2e:bc19:0:b0:36b:2fab:fa6f with SMTP id 38308e7fff4ca-36fb03a3834mr5397971fa.3.1758787018322;
        Thu, 25 Sep 2025 00:56:58 -0700 (PDT)
Received: from localhost.localdomain (broadband-109-173-93-221.ip.moscow.rt.ru. [109.173.93.221])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-36fb4772ca2sm3867031fa.12.2025.09.25.00.56.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 00:56:58 -0700 (PDT)
From: Alexandr Sapozhnkiov <alsp705@gmail.com>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Neil Brown <neilb@suse.de>,
	Olga Kornievskaia <kolga@netapp.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Alexandr Sapozhnikov <alsp705@gmail.com>,
	lvc-project@linuxtesting.org
Subject: [PATCH] nfsd: fix arithmetic expression overflow in decode_saddr()
Date: Thu, 25 Sep 2025 10:56:52 +0300
Message-ID: <20250925075653.11-1-alsp705@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexandr Sapozhnikov <alsp705@gmail.com>

The value of an arithmetic expression 'tmp1 * NSEC_PER_USEC' 
is a subject to overflow because its operands are not cast 
to a larger data type before performing arithmetic

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Alexandr Sapozhnikov <alsp705@gmail.com>
---
 fs/nfsd/nfsxdr.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/nfsd/nfsxdr.c b/fs/nfsd/nfsxdr.c
index 5777f40c7353..df62ed5099de 100644
--- a/fs/nfsd/nfsxdr.c
+++ b/fs/nfsd/nfsxdr.c
@@ -172,6 +172,8 @@ svcxdr_decode_sattr(struct svc_rqst *rqstp, struct xdr_stream *xdr,
 	tmp1 = be32_to_cpup(p++);
 	tmp2 = be32_to_cpup(p++);
 	if (tmp1 != (u32)-1 && tmp2 != (u32)-1) {
+		if (tmp2 > 1000000)
+			tmp2 = 1000000;
 		iap->ia_valid |= ATTR_ATIME | ATTR_ATIME_SET;
 		iap->ia_atime.tv_sec = tmp1;
 		iap->ia_atime.tv_nsec = tmp2 * NSEC_PER_USEC;
@@ -180,6 +182,8 @@ svcxdr_decode_sattr(struct svc_rqst *rqstp, struct xdr_stream *xdr,
 	tmp1 = be32_to_cpup(p++);
 	tmp2 = be32_to_cpup(p++);
 	if (tmp1 != (u32)-1 && tmp2 != (u32)-1) {
+		if (tmp2 > 1000000)
+			tmp2 = 999999;
 		iap->ia_valid |= ATTR_MTIME | ATTR_MTIME_SET;
 		iap->ia_mtime.tv_sec = tmp1;
 		iap->ia_mtime.tv_nsec = tmp2 * NSEC_PER_USEC;
-- 
2.43.0


