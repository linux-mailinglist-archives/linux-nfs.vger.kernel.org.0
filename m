Return-Path: <linux-nfs+bounces-16767-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA34C8FD5F
	for <lists+linux-nfs@lfdr.de>; Thu, 27 Nov 2025 19:00:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35F113AED8D
	for <lists+linux-nfs@lfdr.de>; Thu, 27 Nov 2025 17:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40CEC2F60CA;
	Thu, 27 Nov 2025 17:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="LjTeTI+W";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ozXkWwQo"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447B02F83B4
	for <linux-nfs@vger.kernel.org>; Thu, 27 Nov 2025 17:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764266336; cv=none; b=R5Ocn/wWsZb9Uxy43Kf7/VTqBv32RH8fmHhdYfqdAnuZ2w7IJsMylMkHkqeBKP7dDOUIjA7bziUpv5KBShXG/zO/kERjRB5et0TXERb+5Nb5anwVqHuYXRrhVZuge1flirMjxjyynMdYRc7wnp0et4qmyDKfofXrXkhK3+bNsfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764266336; c=relaxed/simple;
	bh=KxnHkjnVnZ6TgOdAA8JxaeOec8CYFIkP8zyi8kr3cpY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lyrt7vFOuPJdP1VjMMfGtCZGHYkv3MgwjyNWshmnM4jknpp935nBUn1aDL729xRgjvmR/unXRmmzq0FBusYvZlhzRcunYVRAs3ZAyHWDPFT96P7r37QiuLv7TDj0B2gRhQfUH10U8lrna6Ir1OCpiyeCsPl4Blcp8yuTAY8nBZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=LjTeTI+W; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ozXkWwQo; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from kunlun.arch.suse.cz (unknown [10.100.128.76])
	by smtp-out2.suse.de (Postfix) with ESMTP id 6F81A5BCCE;
	Thu, 27 Nov 2025 17:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1764266329; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PgtLLMpSqB4C6RIRJA/gqYhCTxKW+cgtBd+/999RS+k=;
	b=LjTeTI+W6WXy8OFG0nwdgOIJj72wF4EvXx6Z6tODUeNyvPLoovWVNdFyyEkbOyUon6HHcV
	V7x0rSjpOyrcMpDldQNQ3tw7at5W36eJnznOH4WOIMkM28M01ZnM38MML91i2wXsXS8Rgx
	rHDRIQhkMXwDiHfGtJ2wc0fbygvKd8A=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1764266328; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PgtLLMpSqB4C6RIRJA/gqYhCTxKW+cgtBd+/999RS+k=;
	b=ozXkWwQos2piNDaY7JVqzOqnlR2uOcXubP+FyO6ATYNq6fnvehQOcyx4k1DN5nhQxLwSpU
	SzNFH5VOxhVG/jh2Qv8nCpLrK4D8MBESKWyLYZuOWsPXt5q3XpNHbompdCJ78lhb8kkP2t
	yg2B20aaRzQobKD3y4wMfsd2etk7kgs=
From: Anthony Iliopoulos <ailiop@suse.com>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: <linux-nfs@vger.kernel.org>
Subject: [PATCH 2/2] nfsd: fix return error code for nfsd_map_name_to_[ug]id
Date: Thu, 27 Nov 2025 18:57:53 +0100
Message-ID: <20251127175753.134132-3-ailiop@suse.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251127175753.134132-1-ailiop@suse.com>
References: <20251127175753.134132-1-ailiop@suse.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_ZERO(0.00)[0];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	URIBL_BLOCKED(0.00)[suse.com:mid,suse.com:email,kunlun.arch.suse.cz:helo];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kunlun.arch.suse.cz:helo,suse.com:mid,suse.com:email]
X-Spam-Level: 
X-Spam-Score: -2.80
X-Spam-Flag: NO

idmap lookups can time out while the cache is waiting for a userspace
upcall reply. In that case cache_check() returns -ETIMEDOUT to callers.

The nfsd_map_name_to_[ug]id functions currently proceed with attempting
to map the id to a kuid despite a potentially temporary failure to
perform the idmap lookup. This results in the code returning the error
NFSERR_BADOWNER which can cause client operations to return to userspace
with failure.

Fix this by returning the failure status before attempting kuid mapping.

This will return NFSERR_JUKEBOX on idmap lookup timeout so that clients
can retry the operation instead of aborting it.

Fixes: 65e10f6d0ab0 ("nfsd: Convert idmap to use kuids and kgids")
Signed-off-by: Anthony Iliopoulos <ailiop@suse.com>
---
 fs/nfsd/nfs4idmap.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/nfsd/nfs4idmap.c b/fs/nfsd/nfs4idmap.c
index 8cca1329f348..123ac45b512e 100644
--- a/fs/nfsd/nfs4idmap.c
+++ b/fs/nfsd/nfs4idmap.c
@@ -654,6 +654,8 @@ nfsd_map_name_to_uid(struct svc_rqst *rqstp, const char *name, size_t namelen,
 		return nfserr_inval;
 
 	status = do_name_to_id(rqstp, IDMAP_TYPE_USER, name, namelen, &id);
+	if (status)
+		return status;
 	*uid = make_kuid(nfsd_user_namespace(rqstp), id);
 	if (!uid_valid(*uid))
 		status = nfserr_badowner;
@@ -671,6 +673,8 @@ nfsd_map_name_to_gid(struct svc_rqst *rqstp, const char *name, size_t namelen,
 		return nfserr_inval;
 
 	status = do_name_to_id(rqstp, IDMAP_TYPE_GROUP, name, namelen, &id);
+	if (status)
+		return status;
 	*gid = make_kgid(nfsd_user_namespace(rqstp), id);
 	if (!gid_valid(*gid))
 		status = nfserr_badowner;
-- 
2.52.0


