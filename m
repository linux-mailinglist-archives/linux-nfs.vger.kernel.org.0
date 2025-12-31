Return-Path: <linux-nfs+bounces-17379-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7444ACEB0C1
	for <lists+linux-nfs@lfdr.de>; Wed, 31 Dec 2025 03:22:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 827CA301E1AD
	for <lists+linux-nfs@lfdr.de>; Wed, 31 Dec 2025 02:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D7A71FC0EA;
	Wed, 31 Dec 2025 02:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KqUkbhnp"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A952E36F1
	for <linux-nfs@vger.kernel.org>; Wed, 31 Dec 2025 02:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767147752; cv=none; b=WK/w2tAejMWoVGbbashDwfZ0fO9TmN2z7g3b+N8KXyzkduUVo7CUe5O8eTnYPWSZK4WhRF7sFwRuCCDP+aKK6nXmPx0ukOLjB6RzexkRH/02knjegz0JacrarXbwvFGH5nBZBZdP97OuceSpNdaJL/JJirPxmurAaEbEio/e/RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767147752; c=relaxed/simple;
	bh=Cvc3+ka7sRLiCyA2tt1vqABo1XxXqSLGBD+SjCTh3xI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kEjvHxb18Js2YkeVEtsSkotQqQm46ySznOUeLT2mkaM7MqYkUb50GOuPdS7aEDsrY5LDIRsZo21lNBLW5u/sNV/ptkhfFo1W68Ae6GWRsL391dWXSJz6ORamWkdwALnM2TENk7NWckSsIvvZFepdMHiBaUQbkuLZAbRbPW9U5y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KqUkbhnp; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7a9c64dfa8aso7986851b3a.3
        for <linux-nfs@vger.kernel.org>; Tue, 30 Dec 2025 18:22:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767147750; x=1767752550; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R/wV9c8MwvgdjHjUdKqV3TOqq+5E4ggDI49Mhm6WG8M=;
        b=KqUkbhnptUVsayZfnb+AwiZ67iPUHnyv6WLaKm/WnyBNcq/iakO2UIqS08xDcz2jwt
         ITz4wDzvMxsWXWGsI5GtmdEU6TZ4BXaKcxLkyQZQDBVyZNgcQwxNOxVR6tmsYtbnRh7X
         ixgrujk4XOk2L8f1wHBZ3mI4VjsNg4VYSGSCnqI3MjW5U23ApkVAN0qMEcC2JnhdT+uS
         WPRC1EMXmD9Ml3S78osmS2jIjcYbJ9UhssgC/jdUoZG2xvXxNO/NeFCyOOaF0aUDTwy5
         W0/RmgpDgMOANY/L0eK41dnxfCbXPNcuRD8OumbdgXS1eOUpwU+l2UdfFJ8YtP1H+qjI
         H0Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767147750; x=1767752550;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=R/wV9c8MwvgdjHjUdKqV3TOqq+5E4ggDI49Mhm6WG8M=;
        b=RSRpLJMEyJhX/BddIlQa0CEmkSV+HVYe/9GUR33AeuOumj2qZj51Uzj+0MQqsXm0tm
         oWihGu8zLjYX2mwlf2ohwwqB1pkFe57Qpa5ZtkPnrG4fDEHWpFc19RmEsbeVEKjLHBOt
         eoa+hZsU+cNaZhF+c2ynrYGyZMJuKVjcDS5GGQrAB6a5jmwKjoiNoukM6EPBf6WVmMBe
         GGV2J7ZFKSdaL9v7pKtmXBZR8sknTxZU0KifkFBwsdhWZz28lrRVbPDIOFTXEc/Xd3EY
         qlu/HHcHAmYu/Smsi7DIWoWcoKbYWFnBwZBQi9bt0GV1VxXV2KDHF72bo4EN+KcXHn52
         u3lg==
X-Gm-Message-State: AOJu0YyjJWyJIBSdIs2aCLotlYnWKKvOLo5g2bqpHz0fyq36azvjL5Iv
	4CohtoLT+QAhkqEvbsuvcJBvNHq/ZbtNwDd9FWCDxExN2gj7FPiuf36Rk016VRI=
X-Gm-Gg: AY/fxX4lM+wUXrzA4z4gmDOoGAHykbNUWXvp/G5J+0tU1ULYUoO/Oe+chh2y/ioIddl
	PIN6lapepXE+VDwoHXSnjZ8t8mBl9NWGanVV1pZcdH7pB+RsAyCyBqqo1eLTy2Adlkp3qlBI7qh
	IiY1eNe3WshWy4GF/ud22ek1hybkurb/Eq+j66n7ZIh3r4Lt8u52pZHpY+kXDYGceOTgbXB4Hxc
	cnqPddPF1+e2BMibF1P/WiXrFmTk2nTdMgno8HxZ9aZu1vJRi4B3vaBZDU3UHsrHuKlFS7dQVXW
	rl2ReUs0so3kIh5I3ZoubOcWT1y8IE4BYl5vl8FJA+2r1SzkI1rMXSjy+PL4HByv+BLgHyUereW
	udjNs9etowLSLJMjFBOA8XgNuBFO0BO/n6ebuqJs5g5AIisASjMllTJjruA7aLHZQJbum8QksAa
	YAODYcraXBaBLZ0j7ml5fRB0tTyfZ3lOc9Sc+P+W/Ll2a5cqSoyh5ApBNp
X-Google-Smtp-Source: AGHT+IH/TBqUw5S9wcATy+yfq3P3XQ/+zB3XKd/6qIWyg4b/VsPLZALpzzYLYOs5kGb7UGhmiZyMrQ==
X-Received: by 2002:a05:6a00:450c:b0:7e8:43f5:bd3e with SMTP id d2e1a72fcca58-7ff66d5fc16mr34440137b3a.42.1767147750102;
        Tue, 30 Dec 2025 18:22:30 -0800 (PST)
Received: from nfsv4-laptop2.cgocable.net (d75-157-27-199.bchsia.telus.net. [75.157.27.199])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7e197983sm33659267b3a.33.2025.12.30.18.22.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 18:22:29 -0800 (PST)
From: rick.macklem@gmail.com
To: linux-nfs@vger.kernel.org
Cc: Rick Macklem <rmacklem@uoguelph.ca>
Subject: [PATCH v1 12/17] Call sort_pacl_range() for decoded POSIX draft ACLs
Date: Tue, 30 Dec 2025 18:21:14 -0800
Message-ID: <20251231022119.1714-13-rick.macklem@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251231022119.1714-1-rick.macklem@gmail.com>
References: <20251231022119.1714-1-rick.macklem@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rick Macklem <rmacklem@uoguelph.ca>

posix_valid_check() expects the ACEs in a POSIX draft ACL
to be sorted, so sort them.  Since sort_pacl_range() uses bubble
sort, it will only make a single pass through the ACEs if they
are already sorted, which will often be the case.

Signed-off-by: Rick Macklem <rmacklem@uoguelph.ca>
---
 fs/nfsd/nfs4xdr.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index d12e479c18d3..72530203e985 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -483,6 +483,16 @@ nfsd4_decode_posix_acl(struct nfsd4_compoundargs *argp, struct posix_acl **acl)
 		}
 	}
 
+	/*
+	 * posix_acl_valid() requires the ACEs to be sorted.
+	 * If they are already sorted, sort_pacl_range() will return
+	 * after one pass through the ACEs, since it implements bubble sort.
+	 * Note that a count == 0 is used to delete a POSIX ACL and a count
+	 * of 1 or 2 will always be found invalid by posix_acl_valid().
+	 */
+	if (count >= 3)
+		sort_pacl_range(*acl, 0, count - 1);
+
 	return nfs_ok;
 }
 
-- 
2.49.0


