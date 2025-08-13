Return-Path: <linux-nfs+bounces-13627-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4FD8B244DA
	for <lists+linux-nfs@lfdr.de>; Wed, 13 Aug 2025 11:01:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5986E16F159
	for <lists+linux-nfs@lfdr.de>; Wed, 13 Aug 2025 09:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A0681FAC34;
	Wed, 13 Aug 2025 09:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="QXiL+ujd";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="QXiL+ujd"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6512C324C
	for <linux-nfs@vger.kernel.org>; Wed, 13 Aug 2025 09:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755075666; cv=none; b=MWujXHqy1zY+7DcVG8KDmloP0OPGsEA1r47et7edPMFkYc2OUUe2Bl4byFvYy22qb89lvH/N7bQQ8TqBJW3336km5uRSz4vml7RsqOv1TbweXOCpbASY5Is0X8Tg0jREPL2rFa1e8VCU1g0Ax84q4nQT87dzYmo+Qe+Xh68mp7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755075666; c=relaxed/simple;
	bh=v0Ol2+P0w/JnXU++hy34WRuZubSld9OgKydOadYHHEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fWmJlmunMaSBXVFJsze7ogx6BoQVjjKmMEvQzr61BFEGtyZxQPaeTsq2V/8nbmc4V4wGnCFRLW3qsTggch+UVGxlaB5uLW869VmKM94bwEKCs3TAZS2wD3YOKfAhhzsVlPtVN6dJSJ1iryt7vd9ibpBw2As444ABAROo9I/H0qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=QXiL+ujd; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=QXiL+ujd; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from kunlun.arch.suse.cz (unknown [10.100.128.76])
	by smtp-out2.suse.de (Postfix) with ESMTP id 5D85B1F745;
	Wed, 13 Aug 2025 09:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1755075660; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VcguTF5VI1+L14bCxGeA9TNlK4VjBXBD3pT3xK2Abbc=;
	b=QXiL+ujdbO3SKU5m3Rr9OIMCqIbpqzzKvXDZ/eIkF6U/xltKJxiIQhMH3bNjw/dLphFEVj
	Geu58QXsrUODQR8FURNUP5UL67Mr3m8awtudddvKeYvhBWa0n4YrYaaZZINxJLdSoam2ip
	iNGXCdOAwG8rRCXrfwE2Q8IXmUo/MEM=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1755075660; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VcguTF5VI1+L14bCxGeA9TNlK4VjBXBD3pT3xK2Abbc=;
	b=QXiL+ujdbO3SKU5m3Rr9OIMCqIbpqzzKvXDZ/eIkF6U/xltKJxiIQhMH3bNjw/dLphFEVj
	Geu58QXsrUODQR8FURNUP5UL67Mr3m8awtudddvKeYvhBWa0n4YrYaaZZINxJLdSoam2ip
	iNGXCdOAwG8rRCXrfwE2Q8IXmUo/MEM=
From: Anthony Iliopoulos <ailiop@suse.com>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: "J . Bruce Fields" <bfields@fieldses.org>,
	linux-nfs@vger.kernel.org
Subject: [PATCH 1/2] NFSv4.1: fix backchannel max_resp_sz verification check
Date: Wed, 13 Aug 2025 11:00:46 +0200
Message-ID: <20250813090047.92365-2-ailiop@suse.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250813090047.92365-1-ailiop@suse.com>
References: <20250813090047.92365-1-ailiop@suse.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.981];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	ARC_NA(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid]
X-Spam-Flag: NO
X-Spam-Score: -2.80

When the client max_resp_sz is larger than what the server encodes in
its reply, the nfs4_verify_back_channel_attrs() check fails and this
causes nfs4_proc_create_session() to fail, in cases where the client
page size is larger than that of the server and the server does not want
to negotiate upwards.

While this is not a problem with the linux nfs server that will reflect
the proposed value in its reply irrespective of the local page size,
other nfs server implementations may insist on their own max_resp_sz
value, which could be smaller.

Fix this by accepting smaller max_resp_sz values from the server, as
this does not violate the protocol. The server is allowed to decrease
but not increase proposed the size, and as such values smaller than the
client-proposed ones are valid.

Fixes: 43c2e885be25 ("nfs4: fix channel attribute sanity-checks")
Signed-off-by: Anthony Iliopoulos <ailiop@suse.com>
---
 fs/nfs/nfs4proc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 7d2b67e06cc3..dfc3594dd231 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -9441,7 +9441,7 @@ static int nfs4_verify_back_channel_attrs(struct nfs41_create_session_args *args
 		goto out;
 	if (rcvd->max_rqst_sz > sent->max_rqst_sz)
 		return -EINVAL;
-	if (rcvd->max_resp_sz < sent->max_resp_sz)
+	if (rcvd->max_resp_sz > sent->max_resp_sz)
 		return -EINVAL;
 	if (rcvd->max_resp_sz_cached > sent->max_resp_sz_cached)
 		return -EINVAL;
-- 
2.50.1


