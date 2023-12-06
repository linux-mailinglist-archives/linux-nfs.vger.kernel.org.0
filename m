Return-Path: <linux-nfs+bounces-377-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6460807A88
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Dec 2023 22:33:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D4FFB211F4
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Dec 2023 21:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AA0D70976;
	Wed,  6 Dec 2023 21:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WVY9/Iwd"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85F02F7
	for <linux-nfs@vger.kernel.org>; Wed,  6 Dec 2023 13:33:43 -0800 (PST)
Received: by mail-oo1-xc34.google.com with SMTP id 006d021491bc7-590638ff680so41537eaf.1
        for <linux-nfs@vger.kernel.org>; Wed, 06 Dec 2023 13:33:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701898423; x=1702503223; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5USLAotu/Ir6n/IBLfon1cOlR9qpajMvoZiPWq4vufA=;
        b=WVY9/IwdIDEiKGByu2Yy09RfTLnFiJeIBvXDj7u4HhGTGYhOYdxhaSOCWWcro/GKUj
         6BXtFJ5Ij3fzGFqGAXBVp3CQMfPWjAHKH0AH9r0Oltvd0ZSp0U3KCFc1ULscGpPsDkMK
         PwNF8sjX8lhj6D9QdO0gxJBBMgVTFW/JfX9Ni+uCd4I7jzOjklNsv4qPsvyrmV5hXS2G
         tn6GjAURWXG2w3BkJkjubfKHxJEbX7Dv1HwR9z8BePbsoSQUXiT0yZoRH4b+aL6gdX1a
         7uYZML+uuCuV+ZQYVOh5HBu4OtdAVt0Qf1hNbEw8pnZES0kg6Ga83JW/+K72e221Fm1X
         xXhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701898423; x=1702503223;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5USLAotu/Ir6n/IBLfon1cOlR9qpajMvoZiPWq4vufA=;
        b=dMum13R32fQiuM8kMnnjCgn4TanZg1CIRRaG+bqj7pbgsY/PNYBWxrHUjGRBMiotww
         oLbdaF7Ob7NdD7PvbYdnPenfgMtU2d9QRH758EtCaiQ5JLRQCb2yIwDAOQnvx1BEniI4
         thDJ9f5+J85p87HsmUkhQrKBTsSS+byxU1cKB8LLLQUF6SHHXyfXkudgFoaRPgrXRUXc
         FgnxCJvtUqvmYRYitWKHd4gHi1irtLtaiVReUquERDfYWSbjYDF+cw+70wpQMtbUb72P
         oxfQZOpd1YS5iogZ4GmxMPu030lcYjF0f/9bxzmYtDucsFYn1hjG9bCfPLIhPJNvvrd3
         OF6w==
X-Gm-Message-State: AOJu0YyW0si1iobS8O1yhN2XTNQC+HTOatDfIwlpT4wUBrCbeP1ix9ZO
	rGybcrgi6SeatmcW11opLD7ehEb4WJU=
X-Google-Smtp-Source: AGHT+IFSrCEeFIBQ69y9NDr1HcQMDcjKzr6wnEy2EvbPQsg3s+KWldWYMJJWSfYiRjq5tzs6FIN3HQ==
X-Received: by 2002:a4a:dc43:0:b0:58d:5302:5b18 with SMTP id q3-20020a4adc43000000b0058d53025b18mr2908281oov.1.1701898422814;
        Wed, 06 Dec 2023 13:33:42 -0800 (PST)
Received: from kolga-mac-1.attlocal.net ([2600:1700:6a10:2e90:b4ac:108b:be40:79b])
        by smtp.gmail.com with ESMTPSA id ro3-20020a05620a398300b0077da601f06csm256435qkn.10.2023.12.06.13.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 13:33:42 -0800 (PST)
From: Olga Kornievskaia <olga.kornievskaia@gmail.com>
To: steved@redhat.com
Cc: linux-nfs@vger.kernel.org,
	chuck.lever@oracle.com
Subject: [PATCH 6/6] configure: check for rpc_gss_seccreate
Date: Wed,  6 Dec 2023 16:33:32 -0500
Message-Id: <20231206213332.55565-7-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20231206213332.55565-1-olga.kornievskaia@gmail.com>
References: <20231206213332.55565-1-olga.kornievskaia@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Olga Kornievskaia <kolga@netapp.com>

If we have rpc_gss_sccreate in tirpc library define
HAVE_TIRPC_GSS_SECCREATE, which would allow us to handle bad_integrity
errors.

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 aclocal/libtirpc.m4 | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/aclocal/libtirpc.m4 b/aclocal/libtirpc.m4
index bddae022..ef48a2ae 100644
--- a/aclocal/libtirpc.m4
+++ b/aclocal/libtirpc.m4
@@ -26,6 +26,11 @@ AC_DEFUN([AC_LIBTIRPC], [
                                     [Define to 1 if your tirpc library provides libtirpc_set_debug])],,
                          [${LIBS}])])
 
+     AS_IF([test -n "${LIBTIRPC}"],
+           [AC_CHECK_LIB([tirpc], [rpc_gss_seccreate],
+                         [AC_DEFINE([HAVE_TIRPC_GSS_SECCREATE], [1],
+                                    [Define to 1 if your tirpc library provides rpc_gss_seccreate])],,
+                         [${LIBS}])])
   AC_SUBST([AM_CPPFLAGS])
   AC_SUBST(LIBTIRPC)
 
-- 
2.39.1


