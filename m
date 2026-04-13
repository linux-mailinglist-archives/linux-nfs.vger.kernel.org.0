Return-Path: <linux-nfs+bounces-20825-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iFp/Frte3WmadAkAu9opvQ
	(envelope-from <linux-nfs+bounces-20825-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Apr 2026 23:23:07 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E59533F382A
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Apr 2026 23:23:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3508A3014BA9
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Apr 2026 21:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F2667DA66;
	Mon, 13 Apr 2026 21:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=spiritfinder-org.20251104.gappssmtp.com header.i=@spiritfinder-org.20251104.gappssmtp.com header.b="rTHrtZI3"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901B737C904
	for <linux-nfs@vger.kernel.org>; Mon, 13 Apr 2026 21:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776115384; cv=pass; b=Q7uc6lwKaqze81GOhCdF3ciwQ4X9qub812ZBSFiLPsrwbs9IYaPyBmyFooEH4wzWjx4EfJtmhrd4yg4g2btuYvmtHEQY3nUA5CB7xmoeavMAI/4rTb623+WGKNyGnoxGNJQ/HaZGrmZm9sCD4GJFq5rNbhajB/in7PYvzr/UPFk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776115384; c=relaxed/simple;
	bh=+Ajxdh5bfxtJQlWLG5czDBuvywHTjLerl85nW/wbv7Y=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=ERzEtb93IoIHPzn2y5MBRgMjgoKW+1qqOVONOY1XnGBA//bMvWWY8rxsUGLQgoOEHw3AffZ7IYZK36+fhXfjUsUUF/j3Qt8L6GV19oKs9zXZcQh7iwSJImYA2itAXOb1E38Y881Oj8GLQHhRYrr8yo3L4hvdFP4/zftD+KaFmS0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=spiritfinder.org; spf=pass smtp.mailfrom=spiritfinder.org; dkim=pass (2048-bit key) header.d=spiritfinder-org.20251104.gappssmtp.com header.i=@spiritfinder-org.20251104.gappssmtp.com header.b=rTHrtZI3; arc=pass smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=spiritfinder.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spiritfinder.org
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-794719afcd4so47361617b3.1
        for <linux-nfs@vger.kernel.org>; Mon, 13 Apr 2026 14:23:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776115382; cv=none;
        d=google.com; s=arc-20240605;
        b=J+oS2y6HtZRAnETHIPEZ3BVEOxCCnR2X7W9Wn5StbuRInWMXeJHuFpulO+OASNtCKH
         est11YBteIJ/2uBbW9pBXL8n4I6uggGLLGVuWqmjitoUBtFadB6HqchXUbJGnQrIT4wP
         7i6h9CUIXwNLzMGronJkOxmL+lf4VPd4thIujb5isbVYTKyg9Erdkd51GF1QhH3vHGZu
         3LisWz8phgiMjbB/MWpDXCpC5lXT7Xa+W9FeyMqjYHm7Ztc6hK5NktWrEv8CHQmoIIUn
         lFfOf+VMq7ysP77qw2sAx4iB8F1FF2YIOtxu6K53Wo1Y17iox/WpZXH/IHAUWD87QR0F
         3O8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=+Ajxdh5bfxtJQlWLG5czDBuvywHTjLerl85nW/wbv7Y=;
        fh=Mys3y4MwsHRytUQMpdfGBn3oGRYLcLloxNwkFYMYMmg=;
        b=C6r9b0mQUjRkaC50iK4t1qqvF84p4Or1fdr9zTizpKlcDtQ4yzWfU1qrHut8mOW1UK
         obek4SA3QkcDjDkyw4BmPzC94EQ57xZLqufp25l3cep5SF6Vo5jBzxhFtl7tdV1L8hzp
         lrJnl2COQ7jQEVf8k6SfNbaZWrAA9/yInyfFzLee2753JfnDZOV4lLst6OQ8gcFFZ9zl
         uesRolwqgdNCLeoVa65uqC6NsaQD7XN+5kaEt94Tmlqr+hy6dpWc8hkW52O56w8pClk8
         CYYoxUj/VsGxtKYODOH0aZYKRnQ55KUtcnKVSDMa+8Er6a58IglNjyTNI/TDnX1DGzSw
         bThQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spiritfinder-org.20251104.gappssmtp.com; s=20251104; t=1776115382; x=1776720182; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+Ajxdh5bfxtJQlWLG5czDBuvywHTjLerl85nW/wbv7Y=;
        b=rTHrtZI3mqh8YzCk3aY8c78MKq2vy30czbjeYGFzkTu9xwB6X4K+8NfYvy2W2wgdIU
         jF2MmX/7jDaifFlkUiEmwk/nhk0y3aSEJ8WtXRKQsSGbPpjIRJtudYbWRuwbU1uG0Jog
         aqQ/aqrZ3kpobFaIqeZATHYn7QchR87jjIcsOrtWK5JTuOaFMEukxxtuE7fdQ44F6A4j
         e3zI0nuUmu+kg+3Ou1IU/NyW6TEb51NdmKo7ooMKiGzSqU/Jy4uUXjOWstWDTrgr07Om
         0p8K4eckpzsfdQ5zRsqGGW2eqgD8Awu4ZnSzIm5XlQUiVSE0lGMVdYGWNtzgQIl5lOIQ
         OBDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776115382; x=1776720182;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Ajxdh5bfxtJQlWLG5czDBuvywHTjLerl85nW/wbv7Y=;
        b=d5JiJGG+8mm4Lnr1vMUnah7AHhxquen9aEUvBniGY66NDJoGsPjy8xt5f8FsZ51Fvs
         NTGPTk3DPHBBWRKJq/eXXSaKf6/caDzeIBpZwAydHssVOFe1uREjbRN0C8c5OQTZ/h1x
         ofUW2Mh26XhuM8PvgJAyoLbyUnPuI/XebnkrdQ5mnHJoxFkNjntAQCYjkpyBsgAX48S2
         WqMVcPuoTvSzoGl6ELBiANK7XpgbPjOhWGQFxEJPohBQbDJeQSqkl2gfHe6Vc7W/ohBV
         wUDG0XqpCKB9ctRKi41xi0YBTUFQJ8ZVZSV9UXcvNpPDfX4dd83b0V0StVRkPlRBElUE
         jmzQ==
X-Gm-Message-State: AOJu0YwxuCF3rr9XyG7/55hi3vG73OBuqJfs2uuQ9LGhkxIevWA/w2ff
	XGPci+NVUoginUfZQ516JbOiTJK7XCiYK+Bq2p4PhZ33T6cX5U8AwxwzVeh8GI6uFcNhKRJrVZB
	lIP4L1eXOZeswZvkLRjp4ARd8KQ9PUeJ8Uiq2oOm0FPhcaIW1gom4
X-Gm-Gg: AeBDieuLJSf91qbYNHpG4aw+7ljlEV48LVxgDeSdQyOyb39WJqNxeIhFdV0zYJSu8ZC
	t/cYgnNIN0JAzhC7vGDm8x7wlWzRbJP6rCkPPKhrb/Wolw9xq0v6dlUvinFSeHPDOeb0RSSP3u3
	z4Vb/luTBvyD7K9gZm6EgGv7hSCy7z/ei1bF9tOtBWA+zDCx43mHcIGGX25LN9o94khgh69M1QM
	h/LSh4UQwFYonGQn8O4zQ9piUl2WwOmYSB7Sm2INw+UepyH2/FTcqPDS8uGQVGUqtRtT873V8Op
	eA80LVxW2Bc9RyjLnG1re3Xyjnhuca+kUhPa5LM=
X-Received: by 2002:a05:690e:2493:b0:64e:e2ac:eebd with SMTP id
 956f58d0204a3-65198b87f74mr10571422d50.32.1776115382102; Mon, 13 Apr 2026
 14:23:02 -0700 (PDT)
Received: from 559722579009 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 13 Apr 2026 14:23:00 -0700
Received: from 559722579009 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 13 Apr 2026 14:23:00 -0700
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jennifer Scott <j.scott@spiritfinder.org>
Date: Mon, 13 Apr 2026 14:23:00 -0700
X-Gm-Features: AQROBzDrHsPRex2gK_6Kc9c_x0ew3P5fSC_xghul4I2StFtkzIubKcmpFkcjKW8
Message-ID: <CA+sMk+eHXaR0P0rrwiKwaHxBaQ0yt7D9mBZzghT-KruXrvreDw@mail.gmail.com>
Subject: Take a Peek at This!
To: linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.56 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[spiritfinder-org.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[spiritfinder.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20825-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	DKIM_TRACE(0.00)[spiritfinder-org.20251104.gappssmtp.com:+];
	SUBJECT_ENDS_EXCLAIM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[j.scott@spiritfinder.org,linux-nfs@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,spiritfinder.org:url]
X-Rspamd-Queue-Id: E59533F382A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

Recently, I made a big move across the country to go back to my
hometown. It was and wasn=E2=80=99t an easy decision for me to make. I love=
d
where I was living, but I=E2=80=99d allowed some bad habits to creep back i=
nto
my life; I had just gone through a stressful and tumultuous breakup;
and I just needed a change.

Now I'm attempting to use this transition period to replace those poor
habits with more beneficial behaviors. For example my phone is turned
off after sunset. Every night, I spend time doing something I enjoy,
such as writing. This was incredibly satisfying to me.

Can I write a guest article on your website to share what I've learned
about breaking unhealthy behaviors? Taking tiny or large actions
toward healing can have a huge impact on your mental health, and I'd
like to share this with others.

Please let me know what you think.

Take care,
Jennifer
Spiritfinder.org


P.S. If this topic doesn=E2=80=99t quite click, just say the word and I=E2=
=80=99ll
send some new ones your way. And if you=E2=80=99d rather not get emails fro=
m
me at all, that=E2=80=99s okay too. I try to make content that feels natura=
l
to read and easy for folks (and smart tools) to find.

