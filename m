Return-Path: <linux-nfs+bounces-13819-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD98B2F653
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Aug 2025 13:19:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 876DFAC2B05
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Aug 2025 11:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5604C30DD1C;
	Thu, 21 Aug 2025 11:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ve1QUmfc"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF4F30DD31
	for <linux-nfs@vger.kernel.org>; Thu, 21 Aug 2025 11:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755774940; cv=none; b=eHv0TPSLBqIc/Q4Y5iJJ2K1MZHs+oQvTLsFrsdW4xoqKydf7OCZySBv+K8HA4+S7XMQHFVzKhm3H4P3qXIluH63pdn5PlB/1yV5tuf8PRbYX/Lql3PpB4iyJNUhWf54m6FmIKNXBMZC9GmttDKEE/QSs24LroSHq3vdc4xRq1Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755774940; c=relaxed/simple;
	bh=bY5C9OXhWIjQl+YmHm08nIWoQ8Em4vwCgkIj1P1Adpo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LOV649ZAwUjmpr9YP9Bvtq0WOZFhPcbZzIIrSTusJyuqarWW5glwjVVp0PC2+XUBXHwW6Cfi8EHj7zvUuLC6VUyId+gBzH4rGSYRuAbwBAHaiygfWszQBhTPunzgwJw0PC8aqBL2hAZ7pZQz5etvU8e1hZkPx/hqK3dhVa0qcb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ve1QUmfc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755774937;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RleD0ujB8NeuvdCAsD1Bf5jN3B3l0tRvcKHUkf27tUs=;
	b=Ve1QUmfcaYYbnxYfwqKfn+UkWIGMPu3Nk92/VS9k/+76oJZnKtW9As4G5/y6jDTvXNvS6/
	CbdiIQLr+k6NdB5V/e3JhSJyDESNko4EC5Kx63Y1yDxzj3woWmZg5MIpiJLvHyNlz0g96C
	4FM4x6omgIkP+hkHEhKnbyTCOJN5TfA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-672-fNSZh4ZuNbuvpqwGyYn-hA-1; Thu,
 21 Aug 2025 07:15:33 -0400
X-MC-Unique: fNSZh4ZuNbuvpqwGyYn-hA-1
X-Mimecast-MFC-AGG-ID: fNSZh4ZuNbuvpqwGyYn-hA_1755774932
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DB0F4180024D;
	Thu, 21 Aug 2025 11:15:31 +0000 (UTC)
Received: from dobby.home.dicksonnet.net (unknown [10.22.80.72])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2FBB11955F24;
	Thu, 21 Aug 2025 11:15:31 +0000 (UTC)
From: Steve Dickson <steved@redhat.com>
To: Libtirpc-devel Mailing List <libtirpc-devel@lists.sourceforge.net>
Cc: Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [PATCH 04/12] Convert old-style function definitions into modern-style definitions
Date: Thu, 21 Aug 2025 07:15:15 -0400
Message-ID: <20250821111524.1379577-5-steved@redhat.com>
In-Reply-To: <20250821111524.1379577-1-steved@redhat.com>
References: <20250821111524.1379577-1-steved@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

With newer compilers (gcc 15.1.1) -Wold-style-definition
flag is set by default which causes warnings for
most of the functions in these files.

    warning: old-style function definition [-Wold-style-definition]

The warnings are remove by converting the old-style
function definitions into modern-style definitions

Signed-off-by: Steve Dickson <steved@redhat.com>
---
 src/rpcdname.c |  3 +--
 src/rtime.c    | 11 +++++------
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/src/rpcdname.c b/src/rpcdname.c
index 3e6a988..c3d1353 100644
--- a/src/rpcdname.c
+++ b/src/rpcdname.c
@@ -63,8 +63,7 @@ get_default_domain()
  * get rejected elsewhere in the NIS client package.
  */
 int
-__rpc_get_default_domain(domain)
-	char **domain;
+__rpc_get_default_domain(char **domain)
 {
 	if ((*domain = get_default_domain()) != 0)
 		return (0);
diff --git a/src/rtime.c b/src/rtime.c
index 29fbf0a..5bc52a8 100644
--- a/src/rtime.c
+++ b/src/rtime.c
@@ -62,10 +62,10 @@ extern int _rpc_dtablesize( void );
 static void do_close( int );
 
 int
-rtime(addrp, timep, timeout)
-	struct sockaddr_in *addrp;
-	struct timeval *timep;
-	struct timeval *timeout;
+rtime(
+	struct sockaddr_in *addrp,
+	struct timeval *timep,
+	struct timeval *timeout)
 {
 	int s;
 	struct pollfd fd;
@@ -146,8 +146,7 @@ rtime(addrp, timep, timeout)
 }
 
 static void
-do_close(s)
-	int s;
+do_close(int s)
 {
 	int save;
 
-- 
2.50.1


