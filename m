Return-Path: <linux-nfs+bounces-20953-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GF/GOqYD5WlCdQEAu9opvQ
	(envelope-from <linux-nfs+bounces-20953-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 19 Apr 2026 18:32:38 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 50BC7424B96
	for <lists+linux-nfs@lfdr.de>; Sun, 19 Apr 2026 18:32:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B27E8303CE9A
	for <lists+linux-nfs@lfdr.de>; Sun, 19 Apr 2026 16:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 489C82D97BD;
	Sun, 19 Apr 2026 16:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hvjc1NdP"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1A32D63E5
	for <linux-nfs@vger.kernel.org>; Sun, 19 Apr 2026 16:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776616309; cv=none; b=h7Z8nHi1uGGIjvq7Z7fpuCKqgmjQxWzdq23hIxOuvPzd5BrnvBCJGJIDK5oM1UvEWiU0qi37gbXjNrCCTqxGIYcDZYb7ZvK5v3Bz8Q+BC8i/KuBJgsXdJn87Z9WMZXBqVX14ziztXeBYzgXPSKkKujs4tQARxTzVIIK/du6KOdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776616309; c=relaxed/simple;
	bh=NL7/rpUFZgcXfFXM3mLGmeyhHSstJj05hAh1BkI2xWc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g588+PzTFd7ImVAwdeV26j//jOSMKgc/QV4YnPaLH2nyPoXiaIfWFGR6opbZDYnPHJZNM3N+F7JQKkbGcteDIk7K0T2sBWHp+CQq6Bhe1ysxby2tc7XUvdDDkD7tnOd0l/ph37TWDWqQEfruLqt3pjS1OFVyy5BYwHZsvMB6raw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hvjc1NdP; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c76bde70ec9so679024a12.2
        for <linux-nfs@vger.kernel.org>; Sun, 19 Apr 2026 09:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776616306; x=1777221106; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IYB76730a2VnObmOSGsgG6RhIK7mfAkEXznIiOrB1/E=;
        b=Hvjc1NdPSc67F7HAWxe6IAHl/aUX6hamQdsN0Chy7FHLxQ6xRSJhF1C9k4q1ecFE74
         5Gl2Xm4p9ga1v3M1Yb9NMQcnQz0ISduMB4fNvOLE9gWLfThQk74/lPfR1QoT4mdejA+H
         Jiyr+7W9Gzfxld37MyOnEVrSiU7wzKPlVVfpUfhyrYyv2/oXvs/NKpBp7dfEaY9UcGnj
         I84UAVPlupC5n9BGH8XFr1BGnu7d+S1gVTNuN3kJa0ZlFcBHqw5UbYjVFouPxeOU03id
         MRat5S+ZvTtswNX1mw720qsAq+6cvh8A10qFnTs67O8/oOtYRMgE11FaBcw2EmhVjNkQ
         C6Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776616306; x=1777221106;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IYB76730a2VnObmOSGsgG6RhIK7mfAkEXznIiOrB1/E=;
        b=lCdR50qN9DTiSNVkMG5iFTOthPAbvQSygO05GoTvQunuSP7SaHxzD1N43IhbnwhvLC
         8FuE3mY0jz8t9pMFsVSUr8khT3H2T6nb877aSH5x//sw2T0wkk1KR81IaLutyqOkBaua
         mP095sWfsq2KghbbdV3eQFtX+VGSu7f0RMb/ckpAmNf3gn1tvFPnLNU0mGGZ2c+1eSkc
         YCWMvsGSxxJXJZVfprqLxmFkLJKO+g7UPoo6+sL678iiwyAcd7S5ipqc74kuNCvTW9sF
         dpvBfrH7bpS/ThWzXdMZyQusnp0rxGF1D68mLVqNhOJfnYjiLGHOFc7Zs08wXEO8y+pa
         Xcbw==
X-Forwarded-Encrypted: i=1; AFNElJ8ukqxC16mXn3tZvJyNGjUY6U027N+jmCsuyQDFYRPBEWWr/XHWinclm+C5QsNC0LCWZinF/tgKeAI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAMK6Ye2uPX9qCYr2DxHq9T/BNDsaWdLBFtdPFpVb6b8ScS7Dz
	ZNJFhJQkSfhwrzX+L7F8euCPQ9RYqvhmwGDKMKNsi1Jazwhe3COHdZXr
X-Gm-Gg: AeBDievJuYRqbVDHXvOQpWzyRWbiLSVZoeh0xHqcCfn5sKZEA1d385OhNKUA8QNyrDO
	YDKmbRy7tqN58ZHfMKdL8UA/YBsf8+1kmMtCPv2bIAoDUaXufREjTf/77O/Cu6eih8mOg1DfWEJ
	fP/sBQf2kODnm7REftYBdKyVZDnENBdkAu2Wnd1PsTpYunQSADSVrM5rx+aX6A9x/NQ+BCZ4Rqa
	Yq/0L0OVRtKsQZpKvmxQN0Xn40MBO43MpnkhrS2He9X0dz5EspWGJPPTWmdH8oN19AXNjKJtQ7K
	rNHUEBmBVL7gY4gF+yK0mKx2SROK6SAubDZyFKUy22imn8MZF59zmr7S4kv9KqUIaRlnvDZUV9u
	0eq03OU7ntcLIuNraPhMFewoVFElAAOGGjKXnT3uvlnw2gb6B41UTQWCuDkvWTlOiUTEZQbqpVb
	bJbp1n5uz+djxHEQz8tpQpqvnc3Rw89uAJ9uTTkYkOK75BLb+q5/Vf8ZX1Nf6bv9IdtZnz1YcaX
	UeV4Qaou+QS+M3yh3kah1EZUN+joQ==
X-Received: by 2002:a17:90b:3c8d:b0:35a:18b1:c245 with SMTP id 98e67ed59e1d1-361403bd142mr11178841a91.3.1776616306029;
        Sun, 19 Apr 2026 09:31:46 -0700 (PDT)
Received: from localhost.localdomain (1-160-233-238.dynamic-ip.hinet.net. [1.160.233.238])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-361417748aesm7814196a91.0.2026.04.19.09.31.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2026 09:31:45 -0700 (PDT)
From: Sean Chang <seanwascoding@gmail.com>
To: Benjamin Coddington <ben.coddington@hammerspace.com>
Cc: Jeff Layton <jlayton@kernel.org>,
	trondmy@kernel.org,
	anna@kernel.org,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sean Chang <seanwascoding@gmail.com>,
	Benjamin Coddington <bcodding@hammerspace.com>
Subject: [PATCH v3 1/2] NFS: remove redundant __private attribute from nfs_page_class
Date: Mon, 20 Apr 2026 00:31:37 +0800
Message-ID: <20260419163138.26963-2-seanwascoding@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260419163138.26963-1-seanwascoding@gmail.com>
References: <20260419163138.26963-1-seanwascoding@gmail.com>
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com,hammerspace.com];
	TAGGED_FROM(0.00)[bounces-20953-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seanwascoding@gmail.com,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-nfs];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,hammerspace.com:email]
X-Rspamd-Queue-Id: 50BC7424B96
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The nfs_page_class tracepoint uses a pointer for the 'req' field marked
with the __private attribute. This causes Sparse to complain about
dereferencing a private pointer within the trace ring buffer context,
specifically during the TP_fast_assign() operation.

This fixes a Sparse warning introduced in commit b6ef079fd984 ("nfs:
more in-depth tracing of writepage events") by removing the redundant
__private attribute from the 'req' field.

Reviewed-by: Benjamin Coddington <bcodding@hammerspace.com>
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


