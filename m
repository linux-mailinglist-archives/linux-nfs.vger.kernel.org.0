Return-Path: <linux-nfs+bounces-13890-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DF1AB34E04
	for <lists+linux-nfs@lfdr.de>; Mon, 25 Aug 2025 23:27:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 673A21B25B50
	for <lists+linux-nfs@lfdr.de>; Mon, 25 Aug 2025 21:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A21B41991D2;
	Mon, 25 Aug 2025 21:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="bzeFCP92"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52882882BD
	for <linux-nfs@vger.kernel.org>; Mon, 25 Aug 2025 21:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756157261; cv=none; b=Yi55Anhw8hfyjo9Lo2Cj2FtQkFKRK90H2Lgo7OSBv7JUzg85aw+A75Fg9b12phY+tL30L0gdAxLhl45I6ZOdwx+mdWzuFjAiWC1GIZ3kmsHHnkbcF5OgpsKImuM+LUUELnkjV9YuqxFYk7hk+YxCxI4Ydu8A3BLj9eAcSGSctgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756157261; c=relaxed/simple;
	bh=C6pIljQUVbXribM74eO/Yi4zDmJMVwzxtOTyMoH2G6c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e8fR90WuE8Z7EGEige6hSmk/gXm4ByemjgdkosN2xZPNvXT6wIG8F4rni1QG9m7AQP3XwhHVfHEkzE4OoTXCOVFJgTnoNnqUjS3/bNLUi1XOof7JnPBLx9Fd4j7iadJga17/UjF3ttQWp5NRK+6UfcjLaRFgyz95lycTHnqv66s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=bzeFCP92; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-61c38da68ddso5559278a12.2
        for <linux-nfs@vger.kernel.org>; Mon, 25 Aug 2025 14:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1756157257; x=1756762057; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J+rHpWL/Piu+edXatPGs9bVuXgKSl2HpG+xEZdZh0g8=;
        b=bzeFCP92Qi9XXEie1uk8LgF3fQw4hWTitFrGyyhw1JtPIguGgR9BEQZ0JH5zghvYk5
         2Yoxq50vK4V68hHXIo3beqVUxoaEWkOlRAbDNLfyHjqMnr+3468pZ3Sf7oOuNtv1VSsq
         dlVoeJcYbafWF67EzS1Cf68A6u/3UQ0yZCLpHAfLXL49eVlLd3NnyAxr6zs78bC2tMam
         S4Kkmc/wsRjTbtrLUwfrVpyuKg3Ck7gV6kVvm3pAPFMYxbMSh6fZBkcyHzHT6msngymS
         bk3G0Ki+ED5gn644VL/CVOwzrrMLTSBk/q+bcZenUeqqQmIsHgNAQtrgergyhCwnJrhT
         Cemw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756157257; x=1756762057;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J+rHpWL/Piu+edXatPGs9bVuXgKSl2HpG+xEZdZh0g8=;
        b=IpuxhNVgRxBHQ0mjjGC5/cQ9GAwP00PzY76TEQssjtu6/CAG3/8Zq/VJUG8MtrWdxK
         FwleimPpwOlEDcDucjUW33e2BPBJPT91OVZHNskFJwfD6BNqxLGdQH+NN+QW8aGba5w1
         1vIW8XkcnNBo41H/BEa5CBBnD5WIJ36uukTUWC2oT/7R+nprpODd+c8pPNGidVDdgNdx
         +niy3SSPQ8V6gwZLgyjllgrudGz5NNYHEq7DNcXuX0NxZUG+VotP22Gj/pfvAn5l3hbw
         bUZ+rUQSPaxukeJ1mwVoGpd4dsCcJsD6bCy9D53fxEy809g3PN3iBP/MmLpeLzjrJPhB
         QZ2A==
X-Forwarded-Encrypted: i=1; AJvYcCVbhQNs+pyu9goLndqmhO1lXoz9T11t9Uu4Dx7GaixC0KEJfwrnaZAI0pHw0A3e++Q8fyQVJ95yuXg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCHO5MRx3PGWmw671dvDp8+SUz37coSVtOgjxM7pInFBpYbiu9
	y5YLRAg0lETpDrnncAL879F4Dk8YBE37lfotWV7Lt84455AenDOfUFtAZT1/+IeMT2dObh3yAyD
	axTFI
X-Gm-Gg: ASbGncttPa1KE4sm8BUySnoHH8EX4pmlNqxJqEIkQFFgjPmtvdt97aSwAojDU0dm35P
	WnOKOeOluI4SKvAT2I+T9LRuU8nEDUw8FFLGNAAHqwi6d6EbrTsBmbLQO4slugfgIKpQ1aaQvmL
	d11mMxSK1IgMCpaIi0kZsrybpym1kbMQc5Wbk4PBKONwV703C2EhA5Rm/gp/IbK1JGU/jq2QBD8
	5TB91UdjaJoQBWQ+0UI7xdhbp3kmD2DbdXSQhBQzlKzPA1wjLvZT0NP2mPrsFwevPQHyLcKKObP
	Em/IJvXMXPgAKHGK9RIMfdgnhhD5o4reeSkb0975clD/HxhRNf7okV5EYaAvrCx3L2fL3aggGOd
	apvKcIz/zIShjibkBk2+tHT8=
X-Google-Smtp-Source: AGHT+IFIMq69fDW1WOZqY+dp6Dv59Bh3B3JlWQT4zs7cK1GTmp0PtSpgp5mQ/g5herG3H6ZeBfefRA==
X-Received: by 2002:a05:6402:5256:b0:61c:71b3:74c7 with SMTP id 4fb4d7f45d1cf-61c71b37925mr3180433a12.37.1756157257167;
        Mon, 25 Aug 2025 14:27:37 -0700 (PDT)
Received: from localhost ([208.88.158.128])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-61c5010e151sm4028715a12.4.2025.08.25.14.27.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Aug 2025 14:27:36 -0700 (PDT)
From: Jonathan Curley <jcurley@purestorage.com>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: Jonathan Curley <jcurley@purestorage.com>,
	linux-nfs@vger.kernel.org
Subject: [RFC PATCH v1 2/9] NFSv4/flexfiles: Use ds_commit_idx when marking a write commit
Date: Mon, 25 Aug 2025 21:27:22 +0000
Message-Id: <20250825212729.4833-3-jcurley@purestorage.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250825212729.4833-1-jcurley@purestorage.com>
References: <20250825212729.4833-1-jcurley@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct this path to use ds_commit_idx. Another noop preparation
change. In current code commit_idx == mirror_idx but when striping is
enabled that will not be true.

Signed-off-by: Jonathan Curley <jcurley@purestorage.com>
---
 fs/nfs/write.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index 374fc6b34c79..422bb817cc85 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -977,7 +977,7 @@ static void nfs_write_completion(struct nfs_pgio_header *hdr)
 			req->wb_nio = 0;
 			memcpy(&req->wb_verf, &hdr->verf.verifier, sizeof(req->wb_verf));
 			nfs_mark_request_commit(req, hdr->lseg, &cinfo,
-				hdr->pgio_mirror_idx);
+				hdr->ds_commit_idx);
 			goto next;
 		}
 remove_req:
-- 
2.34.1


