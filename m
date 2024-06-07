Return-Path: <linux-nfs+bounces-3590-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3551990067D
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Jun 2024 16:27:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C4F01C22CC9
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Jun 2024 14:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F993196D86;
	Fri,  7 Jun 2024 14:26:59 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3139E196C7B
	for <linux-nfs@vger.kernel.org>; Fri,  7 Jun 2024 14:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717770419; cv=none; b=o4TRWJnMW1cQeHcz3qHwkLyO399XB2bwFHnw1CiVN5G8uDAEfE2k+WKH4S5C71Oe3rYDOZ4odrJFZVocM6lzZLHwVR9itTvW544ifh0WSOxuKxJ7oKhqDwdJ1pXD4o+jHvnBwY8Pbz9FI3ZqnNMXL64ucFPq9RSFcwJitaqVVug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717770419; c=relaxed/simple;
	bh=ZizJIBp8OX5zeyb4UNdvs9mhq3CPxSSE8Bp8ADKuchI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oqJmdt6dFDl+mqCuT6DE7SXw35pEJXMqMlIf48/6sPBqtXRn+FWEZCeic2qE+HtWFok2mlAyCmSoT8VL87ZsOZXSQUvSWbscYyuzjJ7NcGTwKTq1GpGVrXFtj6aeoJFOGnYJUdnuIp1nj3LEa80ewXcXiAvxgzbosQPee0OVdCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=snitzer.net; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=snitzer.net
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7951c762462so126430585a.3
        for <linux-nfs@vger.kernel.org>; Fri, 07 Jun 2024 07:26:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717770416; x=1718375216;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kuX9b61Uf4qwQYns6rg6CnawWMxP0N5sKdUE6FBTVow=;
        b=qtboG46xHiLfAcpdzxuZiRhVbx+mUkv79utjlah9AmMB/eOaI5hTiGRdoV+p4m4d3v
         P8ayKlTMXxrIizgkc1/9TeiGV+P4clS1jlI7WdbbBYht303PFYz0TlWfYfhC65S+lxDB
         5WQHBcDH6oWXcTpOcj567r45uBzpCLrsIh3bq+MRYoFoclo5SFZGTdCt99Hwcz4y+PzR
         4pXe/VK5QRqkbthdqnoiDHe1xDAgVEcL4Amjflosspv66qDGQ9Iu2h2Oh1sd0fs7TsXU
         CCHmfroPcgL0s264Ou70n0EMZeS5S1yu2RMkdEbaRJA1r4MQTl1phS6ayvHFM+lh7lVU
         P0Sw==
X-Gm-Message-State: AOJu0YwmmOIL+2JmCLhb+wIXtiZvkK/eMyD2PRNlrximN6cRI6bYKcFo
	ZogCvg+PZHOTs/p29ZAWmqoP/V+y1Xbvy+Mj+zRguAC+Notr8sEIwDAlMHd++VcvrlZifTwXKt2
	KzX81/A==
X-Google-Smtp-Source: AGHT+IHULcrqG5Zag7uvbMq6gGCpur/Z6ETJWnI4d/ENvQ4VqrqhvDHCu++Gkd4sY/f3lqx1r/JNmQ==
X-Received: by 2002:a05:6214:2b8d:b0:6ae:d2d1:f3da with SMTP id 6a1803df08f44-6b059bacf0fmr29368196d6.31.1717770416328;
        Fri, 07 Jun 2024 07:26:56 -0700 (PDT)
Received: from localhost (pool-68-160-141-91.bstnma.fios.verizon.net. [68.160.141.91])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b053b13054sm15542416d6.138.2024.06.07.07.26.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 07:26:55 -0700 (PDT)
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trondmy@hammerspace.com>,
	snitzer@hammerspace.com
Subject: [for-6.11 PATCH 05/29] sunrpc: export svc_defer
Date: Fri,  7 Jun 2024 10:26:22 -0400
Message-ID: <20240607142646.20924-6-snitzer@kernel.org>
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

Signed-off-by: Weston Andros Adamson <dros@primarydata.com>
Signed-off-by: Lance Shelton <lance.shelton@hammerspace.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 include/linux/sunrpc/svc_xprt.h | 1 +
 net/sunrpc/svc_xprt.c           | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/sunrpc/svc_xprt.h b/include/linux/sunrpc/svc_xprt.h
index 0981e35a9fed..5ce68f6586f8 100644
--- a/include/linux/sunrpc/svc_xprt.h
+++ b/include/linux/sunrpc/svc_xprt.h
@@ -159,6 +159,7 @@ int	svc_xprt_names(struct svc_serv *serv, char *buf, const int buflen);
 void	svc_add_new_perm_xprt(struct svc_serv *serv, struct svc_xprt *xprt);
 void	svc_age_temp_xprts_now(struct svc_serv *, struct sockaddr *);
 void	svc_xprt_deferred_close(struct svc_xprt *xprt);
+struct	cache_deferred_req *svc_defer(struct cache_req *req);
 
 static inline void svc_xprt_get(struct svc_xprt *xprt)
 {
diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index dd86d7f1e97e..03d3969ca5c2 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -29,7 +29,6 @@ module_param(svc_rpc_per_connection_limit, uint, 0644);
 
 static struct svc_deferred_req *svc_deferred_dequeue(struct svc_xprt *xprt);
 static int svc_deferred_recv(struct svc_rqst *rqstp);
-static struct cache_deferred_req *svc_defer(struct cache_req *req);
 static void svc_age_temp_xprts(struct timer_list *t);
 static void svc_delete_xprt(struct svc_xprt *xprt);
 
@@ -1185,7 +1184,7 @@ static void svc_revisit(struct cache_deferred_req *dreq, int too_many)
  * This code can only handle requests that consist of an xprt-header
  * and rpc-header.
  */
-static struct cache_deferred_req *svc_defer(struct cache_req *req)
+struct cache_deferred_req *svc_defer(struct cache_req *req)
 {
 	struct svc_rqst *rqstp = container_of(req, struct svc_rqst, rq_chandle);
 	struct svc_deferred_req *dr;
@@ -1226,6 +1225,7 @@ static struct cache_deferred_req *svc_defer(struct cache_req *req)
 	dr->handle.revisit = svc_revisit;
 	return &dr->handle;
 }
+EXPORT_SYMBOL_GPL(svc_defer);
 
 /*
  * recv data from a deferred request into an active one
-- 
2.44.0


