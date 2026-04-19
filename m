Return-Path: <linux-nfs+bounces-20947-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cNAGJwmo5GncXwEAu9opvQ
	(envelope-from <linux-nfs+bounces-20947-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 19 Apr 2026 12:01:45 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3962E423968
	for <lists+linux-nfs@lfdr.de>; Sun, 19 Apr 2026 12:01:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EA8E0300463F
	for <lists+linux-nfs@lfdr.de>; Sun, 19 Apr 2026 10:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EEE832B9B6;
	Sun, 19 Apr 2026 10:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kp9taxsy"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE722D77EE
	for <linux-nfs@vger.kernel.org>; Sun, 19 Apr 2026 10:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776592897; cv=none; b=KQysz6Oyba7i2v5aH5fv3x4Hdcfe8ZdLPEa92IpeH+n0UImkPPbtGZebO3tQ5rinVTX7sykmsjh0sXXBsYlY+9/Yvqv9cnapt7hv2v43o3MYmyK0iYwMbmOR4bac5JuLLPA2930hzvdxo9wV3Uim7wO54xwa+u+Sd23VnE6sJvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776592897; c=relaxed/simple;
	bh=vlXMssL6dTmyuBAvai953kW7rxSb5ZratMJyADN/lnM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jaJ8VFrO2aJZDyG+t+cK7LW+NmyNUJ0Nw4IYLexPQfI1IYBNESv4A+ZBmXwJ9RRjLNs3rjHu9dSTE43x1nGUNMcTsm+Je5muDVfpvFEDa6zDZ0+4KdbhXL2xs07Mk4MOGIWeJJSCAxldBP+QaSu1nwxNoKxwNDI/yJQiiDsSHvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kp9taxsy; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-35fbca04006so1100387a91.1
        for <linux-nfs@vger.kernel.org>; Sun, 19 Apr 2026 03:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776592895; x=1777197695; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e+Mhu+Zipa+6oKg3YXJawOMN1redozqDAbFYLPc1zv8=;
        b=Kp9taxsyW9d73GEDavKoPlpM7XnKlwQJL/YtrHV/KEzfzyKkLZXY+mjzlK8Ns4/tk6
         KJtU/+LqqqjykrFK7tFWSLF4NBKKsyAEPzvcoGJ2PB0BoCJCBASuhQl7InT5xu3AGmOa
         heyq3A6klgmYOw2eLdnP6RcytBmzjvV8/hn+0cpYKtZeOKiqvAHytpbvj05OCTsZKln/
         EF2dtNILGYj6mpMmyYzqi6/DMSgcQc6P+CbVgNbhT5rz0H8220G2KWU46bHstQ5imRC7
         o8cLxhOUFlYYugdqKoAwzmzmZQK9UxATuLVCk4lrWhxyjUKKout6tyDr9Q7hJ9DKmjr0
         w9jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776592895; x=1777197695;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=e+Mhu+Zipa+6oKg3YXJawOMN1redozqDAbFYLPc1zv8=;
        b=NskEOIuEoJsvU64UR76FajbBYJ4mbbYlBsIKAfxIMdBlUHUtUlFapUSXmz2kpokNrN
         nCFK7ojib5wnOwBHt+iDeCWjtZzGp4jxYX16OT2j6+/0WkfJiGjXuAaQg1XYCjvySqUJ
         XdPHh1MmBXFfr04jLHvuPn9XXWXz1YnUY9B+kAMhZaRXBcXBVkLLLnWJIVgflb8k2Dgw
         eJZwwFWe/gnJJ1WPjvVhGERCnyXbr1axdIUTxVoHsfQ1jYKnMZjxXhUSHLngIpUiPb91
         ETg5LDxTA0IjAdJUojSLuRA6XS6v+jIUMh9AOzSdTAmIKrCrNBBU13VXW0NZ3iKEfBXP
         I6bw==
X-Forwarded-Encrypted: i=1; AFNElJ+qXgeI6BY/ubZMcuRVMR74rP8Fqh6/vwWuJC19j32GfzNKgR8IexdzXhHgqozda+psqgLTNbL5AEM=@vger.kernel.org
X-Gm-Message-State: AOJu0YysovTKbLhtYFOMeeEYve2mMpWBLEnj+f4tKZk/t09Emmeh87Wp
	ZepQu3Bk6rV5gJ2FUXpIbttsn5KKtv9iugQ82qCYGRRGrlcv8iUIK0CW
X-Gm-Gg: AeBDieuWwJQQI2OsyNqn/D9u8OGVPSeJJXH82xigmldtG+o8QNribaxninj5a2JoROu
	7f5k0Z+sRWLlb1D7fQGGeYdGJCg0dn7IPpl1CDB5Y9PGTfuT1JSrLNPGv8zDo9O7u2R4h3+funn
	jG/InRbOWxthwvnFoXSd1OqA5eQXLJOhO0hVXfcWJrynPIy45FseAoatc3uZ/NFIEM9KZSNcSmh
	eVhUQpp7zrZgu9+7hCgFMOwiQfRBDg26Ryy6XnhEBZJawqZnhb0w45EsWAEMca41L//aXkRoD4l
	+dWjjvZ1vF772wMfQh4BbJ6759pFlCQxsIurXUStGv3hLgLtBqYCA3GFlg5XyUdfE2tdwRsIwtZ
	Cy+4IK86BlAtSFvVzwNE6+HtchqPNX/qsP0y4pww/fBgmQ8mXRkd4NMfbS45hunWYHfd5jRhzbA
	qBR9TFeBRZ+mhObBuBGIOhnQEA1Wg/WzJKmPxZ7jerZU7sbAt57NgANl/hj2gozAMLe83dzNIuR
	IlEXLxs5BGrtlOLSgBLszDl78aIHpcEzArVCCzO
X-Received: by 2002:a17:90b:5288:b0:35e:5051:fb18 with SMTP id 98e67ed59e1d1-361404a2830mr9713299a91.26.1776592895547;
        Sun, 19 Apr 2026 03:01:35 -0700 (PDT)
Received: from localhost.localdomain (1-160-233-238.dynamic-ip.hinet.net. [1.160.233.238])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-361410bafa9sm7114296a91.15.2026.04.19.03.01.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2026 03:01:35 -0700 (PDT)
From: Sean Chang <seanwascoding@gmail.com>
To: Benjamin Coddington <ben.coddington@hammerspace.com>
Cc: Jeff Layton <jlayton@kernel.org>,
	trondmy@kernel.org,
	anna@kernel.org,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sean Chang <seanwascoding@gmail.com>
Subject: [PATCH v2 1/2] NFS: remove redundant __private attribute from nfs_page_class
Date: Sun, 19 Apr 2026 18:01:27 +0800
Message-ID: <20260419100128.20546-2-seanwascoding@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260419100128.20546-1-seanwascoding@gmail.com>
References: <20260419100128.20546-1-seanwascoding@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20947-lists,linux-nfs=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seanwascoding@gmail.com,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 3962E423968
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The nfs_page_class tracepoint uses a pointer for the 'req' field marked
with the __private attribute. This causes Sparse to complain about
dereferencing a private pointer within the trace ring buffer context,
specifically during the TP_fast_assign() operation.

This fixes a Sparse warning introduced in commit b6ef079fd984 ("nfs:
more in-depth tracing of writepage events") by removing the redundant
__private attribute from the 'req' field.

Signed-off-by: Sean Chang <seanwascoding@gmail.com>
---
 fs/nfs/nfstrace.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/nfstrace.h b/fs/nfs/nfstrace.h
index 9f9ce4a565ea..ff467959f733 100644
--- a/fs/nfs/nfstrace.h
+++ b/fs/nfs/nfstrace.h
@@ -1496,7 +1496,7 @@ DECLARE_EVENT_CLASS(nfs_page_class,
 			__field(dev_t, dev)
 			__field(u32, fhandle)
 			__field(u64, fileid)
-			__field(const struct nfs_page *__private, req)
+			__field(const struct nfs_page *, req)
 			__field(loff_t, offset)
 			__field(unsigned int, count)
 			__field(unsigned long, flags)
-- 
2.43.0


