Return-Path: <linux-nfs+bounces-5392-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C63F952462
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Aug 2024 23:01:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19487281F0D
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Aug 2024 21:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 772871BA862;
	Wed, 14 Aug 2024 21:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CHY/YT1y"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8381D1B9B59
	for <linux-nfs@vger.kernel.org>; Wed, 14 Aug 2024 21:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723669281; cv=none; b=i+XEhiw8qSGBZZNSGKsUx1Zb8KyOGlMlehaycGHjIv1lS0Yp4r810JJCLvDj3Zec6KQ/UAtoA5zQkgveoGqleNyklxuK08qpC1ZD+GZ0NXm3Zrex04ggZRcAlxqEMaRgRNQR9rHeK2gH6/wOt/sT4+bpt4NFZmwAIGANqF9AyYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723669281; c=relaxed/simple;
	bh=fu0/rCztkIc9HnDZxPGoWJXSZATuLq6YKMAkkcQkKTw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Hr5JRnJArIAcHfKq3FFy+Mpst7m8Ie5CVksqLW8mKyhXy7CPOAZqbVKfKDU2HVHl6lmu9X6IMJCwO2bdxEttpDt3JfZsAEnjd/BpHxUjjS0Qlyp3TTtPHls8Ef80Dg5ejJdLV0nQcTJ8FqfQ/wV0Nl4DrsD8NIYUDmL5CfLM+g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CHY/YT1y; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-44ffc1cc95fso55401cf.1
        for <linux-nfs@vger.kernel.org>; Wed, 14 Aug 2024 14:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723669278; x=1724274078; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=w/kLombGyF4i16mrFtVQJiNuC+h82l/v0UDeuDjQjdU=;
        b=CHY/YT1yGREtlhyihEQ6os48SmJ+k4kLRc0kwKtvEcLK5XNvSO+f/a+XnQ7EP64xKa
         puEibEYlEMuvh6n5OlqHIE/mNYiU85q0dpZtLQz5Pq8VS6LnImraqwVqwYYfqgU/TvEq
         yhvU0W913fXHcVFGBrL19By/C2DDPif8EIz1w4WQl/K0FMq/jvfv3NkzIYSXMQc5Umr8
         CePAZvuFOd863OHAgoQdyTdJ2QtQCtOfOTsrEPzhHKTqYZD4P/7C30E94D/tOGUYm+wh
         PMfEJgcAE3EKTdyEuAdng63F4vekVLNb/0n/3OSrOcpduQBxloG0e2SEsykYks8JLuFw
         2tgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723669278; x=1724274078;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w/kLombGyF4i16mrFtVQJiNuC+h82l/v0UDeuDjQjdU=;
        b=fosyto7X0g6fJ80buff3EkNK1QgG2T0Oll4vvzzo6MyXAIkj83ehnLr2jBax8f7U2Y
         GeaVgzntG2G5DBdgKsbIF2BndAW+v7KKX1oKR1OT9+0x+57HEeKrCuz3DLIUQGSOTFyB
         UMHcKwEQVDy8IehjMyrbWYzMT+g1lfcAZ3PJtkC00WmbKwk4NzqeIdIlMaF3amgYmR8/
         mH/gtkFzBZmuO/31CBLidzYsFJg3LjmfS3KJekUO1SZB190D+GlKW9Jqn2GavFR26Z0h
         96ubyeY2i15RdqwEJ33KfUVza4YHvFlbQgAlHs5V+ouoCt+UW9Isr3XEmraK2dHHVZVu
         6kHw==
X-Gm-Message-State: AOJu0Yzy1fRqA9SH9m27AxxJPBgOx6bX11b/bHtAI7EShgtpvhkEE2nR
	VC4T/t1jJ4gBFfIF+zcdSD8tm53sNr3qR/0NvJb6nrRztTdCdxIwGV6i8A==
X-Google-Smtp-Source: AGHT+IEfNR6SBceDShUv6jTpuMWS8mYlZ5nLY7XfJf5OPZKZc4kjnspqujhlTu06BcS+SP/d58Bkhg==
X-Received: by 2002:ac8:5a08:0:b0:450:2002:86d5 with SMTP id d75a77b69052e-45368e19449mr3582411cf.6.1723669278405;
        Wed, 14 Aug 2024 14:01:18 -0700 (PDT)
Received: from okorniev-mac.redhat.com ([2600:1700:6a10:2e90:d5e:fcaa:d875:8397])
        by smtp.googlemail.com with ESMTPSA id d75a77b69052e-45369fee649sm384121cf.29.2024.08.14.14.01.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 14 Aug 2024 14:01:17 -0700 (PDT)
Sender: Olga Kornievskaia <olga.kornievskaia@gmail.com>
From: Olga Kornievskaia <aglo@umich.edu>
X-Google-Original-From: Olga Kornievskaia <okorniev@redhat.com>
To: steved@redhat.com
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <okorniev@redhat.com>
Subject: [PATCH 1/1] rpcdebug: fix memory allocation size
Date: Wed, 14 Aug 2024 17:01:09 -0400
Message-Id: <20240814210109.15427-1-okorniev@redhat.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Memory isn't allocated enough to hold the null terminator.

Valgring complains about invalid memory access:

[aglo@localhost rpcdebug]$ valgrind ./rpcdebug
==222602== Memcheck, a memory error detector
==222602== Copyright (C) 2002-2024, and GNU GPL'd, by Julian Seward et al.
==222602== Using Valgrind-3.23.0 and LibVEX; rerun with -h for copyright info
==222602== Command: ./rpcdebug
==222602==
==222602== Invalid write of size 1
==222602==    at 0x4871218: strcpy (vg_replace_strmem.c:564)
==222602==    by 0x400CA3: main (rpcdebug.c:62)
==222602==  Address 0x4a89048 is 0 bytes after a block of size 8 alloc'd
==222602==    at 0x4868388: malloc (vg_replace_malloc.c:446)
==222602==    by 0x400C77: main (rpcdebug.c:57)
==222602==
==222602== Invalid read of size 1
==222602==    at 0x48710E4: __GI_strlen (vg_replace_strmem.c:506)
==222602==    by 0x492FA7F: __vfprintf_internal (vfprintf-internal.c:1647)
==222602==    by 0x49302F3: buffered_vfprintf (vfprintf-internal.c:2296)
==222602==    by 0x492F21F: __vfprintf_internal (vfprintf-internal.c:1377)
==222602==    by 0x491BC93: fprintf (fprintf.c:32)
==222602==    by 0x40103F: main (rpcdebug.c:100)
==222602==  Address 0x4a89048 is 0 bytes after a block of size 8 alloc'd
==222602==    at 0x4868388: malloc (vg_replace_malloc.c:446)

Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
---
 tools/rpcdebug/rpcdebug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/rpcdebug/rpcdebug.c b/tools/rpcdebug/rpcdebug.c
index ec05179e..1f935223 100644
--- a/tools/rpcdebug/rpcdebug.c
+++ b/tools/rpcdebug/rpcdebug.c
@@ -54,7 +54,7 @@ main(int argc, char **argv)
 	char *		module = NULL;
 	int		c;
 
-	cdename = malloc(strlen(basename(argv[0])));
+	cdename = malloc(strlen(basename(argv[0])) + 1);
 	if (cdename == NULL) {
 	  fprintf(stderr, "failed in malloc\n");
 	  exit(1);
-- 
2.43.5


