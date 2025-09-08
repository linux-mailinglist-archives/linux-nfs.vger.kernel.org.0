Return-Path: <linux-nfs+bounces-14129-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2425BB4973F
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Sep 2025 19:37:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CF1984E1F77
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Sep 2025 17:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31548314A8D;
	Mon,  8 Sep 2025 17:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="MajXPgGl"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699BA313520
	for <linux-nfs@vger.kernel.org>; Mon,  8 Sep 2025 17:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757352925; cv=none; b=Uxan9KtOzk4OJ9HaabR/LE2OBu8bknwM/AytezdxtvWGsVVtnbDQggYWn8ysaIxkwqsIusedmY8rcFCk5LWJ0CqK4NiOqokl9t7M7nzoFOlv4s99Wnu74bLZ0lYDjpkbHbpnh5eo9NdPIo5ytmLsiSW3EU/ePXW4mcyYblNpW3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757352925; c=relaxed/simple;
	bh=HfZZT1Ss+xiR7noTn0/+M0JokK4FLVAp5TtoTJpoZLg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LbZqIcMD4mWqP4xIYka+6JfR19gPVFlg0gXwf5LI83Qsu5MwicTxt3rN3QsybVCtGgkJMhkG9K8a/joicBCsBBq5GPqs+IB12YPG1QzbfJoMXQHOg0hS/5YK8DGiDr00nZP1YGN3VTMrudIr7ny0johTUX8LFLFSri+sWd1d8P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=MajXPgGl; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b03fa5c5a89so680904066b.2
        for <linux-nfs@vger.kernel.org>; Mon, 08 Sep 2025 10:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1757352922; x=1757957722; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K+xcW42PW6P6FXK1Z/g/rPN0nfSCPY3Sw2zQnUKbqaU=;
        b=MajXPgGlbseEJVwKjoJJshZtjKxnzb9tuz3ytDkD6l+eEs8vGDAcoizv776U8xyyjL
         6xzA8/CQZr8/XnaRiWoKJA0EcDzQutx/J/c01uyMxRBjeJuTgF7I6f7Ewp8s509iQw9L
         iVZZIC2YYJq4b/dOragkDyM2iiEDlGO8hO00d1BIS7OO/DIgJSEn3TARmau8LKC7FVVg
         GhJjOIsewLn0Wc8poXVIte2kTrhxJsN9C39a8ykkNmj7iJlrzxydwZFI4SG7xNmuHIxf
         msNXObF5fIbxEOWmw6V/i9xzA1U8iq7D/RtGTa5CrXsNzfOcV6cN2Q9Ll64TERzXcWlR
         8e7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757352922; x=1757957722;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K+xcW42PW6P6FXK1Z/g/rPN0nfSCPY3Sw2zQnUKbqaU=;
        b=rFMpplRnreP0TvYFOKVEw4NMVIf5id4j03RGnYnhhrH5Q0o1OyCVcRPvM9H2ZfbKaI
         idgmUcqgN2S4CaVdDXOYVnmE7qPMWHp9oVBFG+GAIVRjcl2p/XbJ3FeNEeL47SQtgBxV
         bbjgjMX2kRdUo09IqPcBoFPhpWriIoyqyQqFldZNU9I3uBE2XMnzoJOkPrE5O7sePEwF
         h9b7h5z8/sNSmLVJVnueQeSdPUs6vDfHv78xEBXp5saXnlKg6FTYAPEcw9MOqMEbxvAF
         ++vQbxAoPlEvNfhOGpK2c1p5dWHKGSPEoZ4YvruZLpCfJl73WHI91D9uN6oUAVlmYp/Q
         qZ3g==
X-Forwarded-Encrypted: i=1; AJvYcCWUkJFymoQ2YlxTqk6KqHiw8inXCa1KCEocEKY59Uphlw/3ncgXn0+2IKzTE4GwUWeWe74OkgCiJqg=@vger.kernel.org
X-Gm-Message-State: AOJu0YykOLgLNYbx7vM/+1Cp0jNeCVSQr2KJbinTMIPeY0RGdRIYJWyi
	gBjIxCPm1tRs+sn3mh3581X6TUr8PS0VM1W2oCB+1CvG4ieTx/j49x+h/duaE09Q+FE=
X-Gm-Gg: ASbGncubR0gYoNcxFtMrPkW/J37/NWZ3NIwl9iNYPnaawitbyk2emNVQhCaBK7b1P4c
	GkQ9hiH0Wbi7c205LT61XZntmYYmQBU/eWv0BSKx19r2V2rmX2nB+NCYNGgezKdlAP0IlnuQcin
	9qgW7u5LWk/9uDw1OJN9Y6j7L5LgjEEB61efNwbFu4zrCIzdrMCxNwH93wO66dL9xZ+OlIDNXTR
	Uv5TS7nARWcaxzC/kSijrRMVWVqdHL9Dfg/jydAkWFnsRoiEuNKgOpag4g/PtwRSqFfEccuvXEJ
	KyZSoCSTRwmloFMmtCNKzr4Zwci0fAIeTiadcFVPXnVzoq3B/ezl4xPvJCyVvaAd8h9j7p77b10
	eQ4A6PuaZve33tbu0JH39OOHYJQYl3HcPdfchYQ==
X-Google-Smtp-Source: AGHT+IE3aQGdvYUnNyHkKBO0L5lkZJBor1eSQ+r/TKcKx9FmR3RLe4HQZQMjz97fmemKwTvU0lSE5g==
X-Received: by 2002:a17:907:804:b0:b04:6047:d4b5 with SMTP id a640c23a62f3a-b04b16dd98cmr793763266b.44.1757352921526;
        Mon, 08 Sep 2025 10:35:21 -0700 (PDT)
Received: from localhost ([208.88.158.129])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b0432937d7esm1875723966b.17.2025.09.08.10.35.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 10:35:21 -0700 (PDT)
From: Jonathan Curley <jcurley@purestorage.com>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: Jonathan Curley <jcurley@purestorage.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH 1/1] NFSv4/flexfiles: Fix layout merge mirror check.
Date: Mon,  8 Sep 2025 17:35:16 +0000
Message-Id: <20250908173516.1178411-2-jcurley@purestorage.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250908173516.1178411-1-jcurley@purestorage.com>
References: <20250908173516.1178411-1-jcurley@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Typo in ff_lseg_match_mirrors makes the diff ineffective. This results
in merge happening all the time. Merge happening all the time is
problematic because it marks lsegs invalid. Marking lsegs invalid
causes all outstanding IO to get restarted with EAGAIN and connections
to get closed.

Closing connections constantly triggers race conditions in the RDMA
implementation...

Fixes: 660d1eb22301c ("pNFS/flexfile: Don't merge layout segments if the mirrors don't match")
Signed-off-by: Jonathan Curley <jcurley@purestorage.com>
---
 fs/nfs/flexfilelayout/flexfilelayout.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c b/fs/nfs/flexfilelayout/flexfilelayout.c
index 6d9aea16ef44..addf4357610e 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.c
+++ b/fs/nfs/flexfilelayout/flexfilelayout.c
@@ -334,7 +334,7 @@ ff_lseg_match_mirrors(struct pnfs_layout_segment *l1,
 		struct pnfs_layout_segment *l2)
 {
 	const struct nfs4_ff_layout_segment *fl1 = FF_LAYOUT_LSEG(l1);
-	const struct nfs4_ff_layout_segment *fl2 = FF_LAYOUT_LSEG(l1);
+	const struct nfs4_ff_layout_segment *fl2 = FF_LAYOUT_LSEG(l2);
 	u32 i;
 
 	if (fl1->mirror_array_cnt != fl2->mirror_array_cnt)
-- 
2.34.1


