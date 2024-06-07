Return-Path: <linux-nfs+bounces-3591-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BF8090067E
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Jun 2024 16:27:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3560A1C22D23
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Jun 2024 14:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9E0E196C7B;
	Fri,  7 Jun 2024 14:27:00 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609D6195990
	for <linux-nfs@vger.kernel.org>; Fri,  7 Jun 2024 14:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717770420; cv=none; b=UVjz7BG4CJ2yaR3Te+PmrPFXL1LL+7Qk0qVkifpih246XhsYMO4iYAvpRwEXjmqBlCXOtTAz7i7F2efjjj90aK+uBepI+RgH9GZKKWW8AWkMqtx+jCsWjcWl0t1JdcLwPxzlyJFcqUeE/fBG9XSysUkowKNMmcmQuuN/qhL7xbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717770420; c=relaxed/simple;
	bh=1s9XtguGzy718U2FTfcxPUJDpoNLfxn/vMir5mGQtR8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RrjEYHFteeHdS+Crq53+CyriRGPRzeud4OIiPSvaHZjo8GrwggdUwn6LMkT68hpJxpkcnTV4GK86GSSMRO8XjLBHuRSk008tH0Ic4owBZtqf4D0qogv7xaqAcw+ok9TGeu28NMYVIO0KTuTesHffoLGuc2YfVHtNGpuivE3hs8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=snitzer.net; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=snitzer.net
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-795186ae3e9so129107185a.0
        for <linux-nfs@vger.kernel.org>; Fri, 07 Jun 2024 07:26:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717770418; x=1718375218;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WBu4ftenDpGj2LTcihy+HJK+af1mIHEXJBb1XhHAnao=;
        b=ivnU5rBE9XYyaoeuyJvbvFldDARGMUnctCc+JCDl40YQer1JdaJqrBGHNjG+dZRn/m
         0rlcZuqRyFi9Acre6/asWHEE4wdVaKT11TZAUZahJ1Ptg7Wd0oqXmGr+d7pFjWynYMjf
         zZLuKm6Jh+nYpWgGn8mR9JVp2o4mSGM6YJ4WwtTQHttLnqE+W1LLqVZRW/stpNM71Ljb
         TvqOXkaDclYO/eSSp5PaNhCruMcFDGihMloy595aouJ0sO9NtP/c2hx9BsYyVJEUW+OK
         b0S1FQd3tr7rQlqqVb9OtarAM0svKgjLbxUIUF9BFRHpRptr+VidKv5kPSrCNUxsP5h4
         yU0Q==
X-Gm-Message-State: AOJu0Yw/2OXnvaEDN6lOYct0dzFbaAtUQ1mw/sPpEI2En0QJy23RCbYu
	Pr4sgtF9ah5v1dJMRqcOrmgr9D+ky+fTQvQiubmMoL/qSv2uSu40Bfx9G9A3ndXB5wEvamAmz+P
	XY5GHjQ==
X-Google-Smtp-Source: AGHT+IFS/pF1NCckuHIRpAJMbCKa7aMuVLYrirRmYAxuFHNi6ruiNyeF8DwzigfbFIdzFxTAHDBvZw==
X-Received: by 2002:a05:620a:2a12:b0:792:b835:19be with SMTP id af79cd13be357-7953c43e61fmr337196985a.43.1717770417908;
        Fri, 07 Jun 2024 07:26:57 -0700 (PDT)
Received: from localhost (pool-68-160-141-91.bstnma.fios.verizon.net. [68.160.141.91])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79532871570sm169137885a.54.2024.06.07.07.26.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 07:26:57 -0700 (PDT)
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trondmy@hammerspace.com>,
	snitzer@hammerspace.com
Subject: [for-6.11 PATCH 06/29] sunrpc: add rpcauth_map_to_svc_cred
Date: Fri,  7 Jun 2024 10:26:23 -0400
Message-ID: <20240607142646.20924-7-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240607142646.20924-1-snitzer@kernel.org>
References: <20240607142646.20924-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Weston Andros Adamson <dros@primarydata.com>

Add new funtion rpcauth_map_to_svc_cred which maps a generic rpc_cred to an
svc_cred suitable for use in nfsd.

This is needed by the localio code to map nfs client creds to nfs server
credentials.

Signed-off-by: Weston Andros Adamson <dros@primarydata.com>
Signed-off-by: Lance Shelton <lance.shelton@hammerspace.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 include/linux/sunrpc/auth.h |  4 ++++
 net/sunrpc/auth.c           | 16 ++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/include/linux/sunrpc/auth.h b/include/linux/sunrpc/auth.h
index 61e58327b1aa..5ebf031361a1 100644
--- a/include/linux/sunrpc/auth.h
+++ b/include/linux/sunrpc/auth.h
@@ -11,6 +11,7 @@
 #define _LINUX_SUNRPC_AUTH_H
 
 #include <linux/sunrpc/sched.h>
+#include <linux/sunrpc/svcauth.h>
 #include <linux/sunrpc/msg_prot.h>
 #include <linux/sunrpc/xdr.h>
 
@@ -184,6 +185,9 @@ int			rpcauth_uptodatecred(struct rpc_task *);
 int			rpcauth_init_credcache(struct rpc_auth *);
 void			rpcauth_destroy_credcache(struct rpc_auth *);
 void			rpcauth_clear_credcache(struct rpc_cred_cache *);
+bool			rpcauth_map_to_svc_cred(struct rpc_auth *,
+						const struct cred *,
+						struct svc_cred *);
 char *			rpcauth_stringify_acceptor(struct rpc_cred *);
 
 static inline
diff --git a/net/sunrpc/auth.c b/net/sunrpc/auth.c
index 04534ea537c8..55a03a3bcac2 100644
--- a/net/sunrpc/auth.c
+++ b/net/sunrpc/auth.c
@@ -308,6 +308,22 @@ rpcauth_init_credcache(struct rpc_auth *auth)
 }
 EXPORT_SYMBOL_GPL(rpcauth_init_credcache);
 
+bool
+rpcauth_map_to_svc_cred(struct rpc_auth *auth, const struct cred *cred,
+			struct svc_cred *svc)
+{
+	svc->cr_uid = cred->uid;
+	svc->cr_gid = cred->gid;
+	svc->cr_flavor = auth->au_flavor;
+	svc->cr_principal = NULL;
+	svc->cr_gss_mech = NULL;
+	if (cred->group_info)
+		svc->cr_group_info = get_group_info(cred->group_info);
+
+	return true;
+}
+EXPORT_SYMBOL_GPL(rpcauth_map_to_svc_cred);
+
 char *
 rpcauth_stringify_acceptor(struct rpc_cred *cred)
 {
-- 
2.44.0


