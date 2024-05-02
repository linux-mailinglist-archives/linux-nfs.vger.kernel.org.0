Return-Path: <linux-nfs+bounces-3127-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12FAA8B9BE9
	for <lists+linux-nfs@lfdr.de>; Thu,  2 May 2024 15:53:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD2E2283F4F
	for <lists+linux-nfs@lfdr.de>; Thu,  2 May 2024 13:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD01613C678;
	Thu,  2 May 2024 13:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lPU9xsSc"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD9713C66C
	for <linux-nfs@vger.kernel.org>; Thu,  2 May 2024 13:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714658018; cv=none; b=TuyVeL4Y6aB6u9jsJIYEx+guQS6DbnPGEPemroGGYOea/MwzHg+mDVXw7/k2/heFMAmNZ69esB/v07ietdEaX5XHTHq3w1VuylxNVrqW818/8o4tOndNUQMbAbqwS3vWJ/Q1HRmwx6gOYX93Q0VLgxOUtRTQ1hHSRZSswyoa3tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714658018; c=relaxed/simple;
	bh=Lxn/dVm9433zXEKL4+dlqar5ZsHQoQYwB72gerb+K5c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sytcA5uqEnrFGmUOQPjvc3rY7Xck5l8qHsBzkjqVfiNrVFhT1hfLaXccN6l0ItxUJRBDKHYXHf/4+uNjSH3QDJKdhdUdyf5tLOEH9FusgGF70yuY7U6wNh39QsgeRBvyJLC/y4JY9W/xhB8aVcajNDv7i180h+p+iWjhUeaFYrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lPU9xsSc; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a595199cb9bso236199666b.3
        for <linux-nfs@vger.kernel.org>; Thu, 02 May 2024 06:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714658015; x=1715262815; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=4ZX5R6bgG5aRxC5lW0K3u0aGPrCIK4LqLl3kYW2XesU=;
        b=lPU9xsScgyvLi0gqRzHHV8rT6/xf6VQan0tHm9HiJfkwQc4D7Nds9kXy8bzu+v/VE+
         3FONhj19prKSt/Trp1/Lei/nEff7rkDW6529j4H6Rtoh+ul0+F85ps6miUNZa7lXkilQ
         oNwTOTq3EspnyOSDG1hy9L3otughyT2H6KYzVkX3V+sRPNCLUQQv06LoV90dWM/aAFF3
         Qlsa6u9RAVmzQJFtrprT8DNcjH3TfK8LnJ5KZxJzwKM1cZ+9t/yEcYjlkMGaH/JWXFrR
         MZvhVxw3+r4DHlgj0ofr4js/gxHKxEKFKut36Tx3GyX+poHP8U8ivmszs9aA1Iq9p5hx
         +dlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714658015; x=1715262815;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ZX5R6bgG5aRxC5lW0K3u0aGPrCIK4LqLl3kYW2XesU=;
        b=qCkK1v8Ivwj6v5xFAzbL9eyeEvjkzCLFmnRpHPe5CvPOSYRo4TVf7NE01mXqN9SzE1
         H7Tit2T63/tsiLt2IeaArW/xp8lBAnmskGJuMuOpoIOfAxnXPUTxfLIdwGFq5r6XtSDC
         sXjzhwUmebap1EgyzCP+970k8Qf+jgaINomb/ZuIdvrVbs6MMnXIHN8uIOTFmrOdHuzy
         iEZs9MD57UmX8YjYBdabksadw5wx/k9+8hNuIvWvBH06yXOkEnvlImNHMnBHQlZoVsIV
         OUh8FdZvxISALFhx0mm8ORhJzJXnkdx2hiRuXj/UB/4szHMFM4wsajoD/C9ODLzYftka
         O8bw==
X-Gm-Message-State: AOJu0YzdOv0g+F762KoY4k40bh/QnOVOWWtypVw3/xZ7U1jjLmc/NnLK
	yb5TfCoKXTdKcfqUOT0PYLZILv/uL01qiZdLT0553umgOz5ftQ8aYqBLFsZ6
X-Google-Smtp-Source: AGHT+IGvwBRWysVDsiqZH9rWVyb35uEQ/DnxsA79RD7pglvriyii/ucEngC6AsuK+ppCpnWuUBSAag==
X-Received: by 2002:a17:906:3388:b0:a59:257d:7aad with SMTP id v8-20020a170906338800b00a59257d7aadmr4034922eja.46.1714658014641;
        Thu, 02 May 2024 06:53:34 -0700 (PDT)
Received: from eldamar.lan (c-82-192-242-114.customer.ggaweb.ch. [82.192.242.114])
        by smtp.gmail.com with ESMTPSA id o3-20020a1709064f8300b00a58ea7cfeedsm587287eju.62.2024.05.02.06.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 06:53:33 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id C397EBE2EE8; Thu, 02 May 2024 15:53:32 +0200 (CEST)
From: Salvatore Bonaccorso <carnil@debian.org>
To: Steve Dickson <steved@redhat.com>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Salvatore Bonaccorso <carnil@debian.org>,
	Vladimir Petko <vladimir.petko@canonical.com>
Subject: [PATCH] junction: export-cache: cast to a type with a known size to ensure sprintf works
Date: Thu,  2 May 2024 15:53:20 +0200
Message-ID: <20240502135320.3445429-1-carnil@debian.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

As reported in Debian, with the 64bit time_t transition for the armel
and armhf architecture, it was found that nfs-utils fails to compile
with:

	libtool: compile:  gcc -DHAVE_CONFIG_H -I. -I../../support/include -I/usr/include/tirpc -I/usr/include/libxml2 -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64 -D_TIME_BITS=64 -Wdate-time -D_FORTIFY_SOURCE=2 -D_GNU_SOURCE -pipe -Wall -Wextra -Werror=strict-prototypes -Werror=missing-prototypes -Werror=missing-declarations -Werror=format=2 -Werror=undef -Werror=missing-include-dirs -Werror=strict-aliasing=2 -Werror=init-self -Werror=implicit-function-declaration -Werror=return-type -Werror=switch -Werror=overflow -Werror=parentheses -Werror=aggregate-return -Werror=unused-result -fno-strict-aliasing -Werror=format-overflow=2 -Werror=int-conversion -Werror=incompatible-pointer-types -Werror=misleading-indentation -Wno-cast-function-type -g -O2 -Werror=implicit-function-declaration -ffile-prefix-map=/<<PKGBUILDDIR>>=. -fstack-protector-strong -fstack-clash-protection -Wformat -Werror=format-security -c xml.c  -fPIC -DPIC -o .libs/xml.o
	export-cache.c: In function ‘junction_flush_exports_cache’:
	export-cache.c:110:51: error: format ‘%ld’ expects argument of type ‘long int’, but argument 4 has type ‘time_t’ {aka ‘long long int’} [-Werror=format=]
	  110 |         snprintf(flushtime, sizeof(flushtime), "%ld\n", now);
	      |                                                 ~~^     ~~~
	      |                                                   |     |
	      |                                                   |     time_t {aka long long int}
	      |                                                   long int
	      |                                                 %lld

time_t is not guaranteed to be 64-bit, so it must be coerced into the expected
type for printf. Cast it to long long.

Reported-by: Vladimir Petko <vladimir.petko@canonical.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218540
Link: https://bugs.debian.org/1067829
Link: https://bugs.launchpad.net/ubuntu/+source/nfs-utils/+bug/2055349
Fixes: 494d22396d3d ("Add LDAP-free version of libjunction to nfs-utils")
Suggested-by: Vladimir Petko <vladimir.petko@canonical.com>
Signed-off-by: Salvatore Bonaccorso <carnil@debian.org>
---
 support/junction/export-cache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/support/junction/export-cache.c b/support/junction/export-cache.c
index 4e578c9b37b1..00187c019d60 100644
--- a/support/junction/export-cache.c
+++ b/support/junction/export-cache.c
@@ -107,7 +107,7 @@ junction_flush_exports_cache(void)
 		xlog(D_GENERAL, "%s: time(3) failed", __func__);
 		return FEDFS_ERR_SVRFAULT;
 	}
-	snprintf(flushtime, sizeof(flushtime), "%ld\n", now);
+	snprintf(flushtime, sizeof(flushtime), "%lld\n", (long long)now);
 
 	for (i = 0; junction_proc_files[i] != NULL; i++) {
 		retval = junction_write_time(junction_proc_files[i], flushtime);
-- 
2.43.0


