Return-Path: <linux-nfs+bounces-6069-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D96F967271
	for <lists+linux-nfs@lfdr.de>; Sat, 31 Aug 2024 17:44:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF110282BF5
	for <lists+linux-nfs@lfdr.de>; Sat, 31 Aug 2024 15:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08BD81F95A;
	Sat, 31 Aug 2024 15:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QBdJzxtg"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92D08468
	for <linux-nfs@vger.kernel.org>; Sat, 31 Aug 2024 15:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725119073; cv=none; b=F4Mf5pQzb2Qpm2Cyiua2XLi/yp0Z5Zi7UuADyKMI1LNQb2ZzJbswDQklvxXBi1QQ0k1PrRc1s9mkRSGRyLBznR1s3fxffpTSthHgAIwtgFxvCtw5FfhGmsTMqc9uGAFqmJ8uxJu5XvoQo7dj431qJv8c5oExuYKXcADHYNQ4F/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725119073; c=relaxed/simple;
	bh=IVSkIUYlXIe9udBTVvbpb2n0FEa9D4MVrvESUuRFn74=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NcR+t3GHvbo7pH0viO2H8biAmVxYRzIhXpyubt0bS/knaaGm6hPVOPlLx4l0eJS3I9QuaFEggpRY3d70AeneL7ewDLXBM0t7zwLq1l63Rhf+IDtDowF1m8AjkZY/s/Lo8PAw2Umh298ebZ0iZsOOb0qXKU7LjhTKe7qHswoq6f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QBdJzxtg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725119070;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MiCos2RNDlKm+sVIUTLeYRtbi6y+Kacz9fDCXFbHvxk=;
	b=QBdJzxtgF/AYMrkrFB01ZDIbOjTj5f6EPshS8ogXg2IntJXY1fwT7TczChuKsGoIaGjTSM
	I68vD11sx47amuC4ENM3yaYVnWPs4uZU62zTOpDqWt+jOxNUH2LLaSXM2QO0zTtngzz5Gu
	u8AOXFAs994YIzb82erhR0ahbjQIbDU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-124-zkQnI3fvOA6xP9Q6ukI2IA-1; Sat,
 31 Aug 2024 11:44:28 -0400
X-MC-Unique: zkQnI3fvOA6xP9Q6ukI2IA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 743BB1955D48;
	Sat, 31 Aug 2024 15:44:27 +0000 (UTC)
Received: from bighat.boston.devel.redhat.com (unknown [10.22.17.28])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8333B1955F35;
	Sat, 31 Aug 2024 15:44:26 +0000 (UTC)
From: Steve Dickson <steved@redhat.com>
To: Libtirpc-devel Mailing List <libtirpc-devel@lists.sourceforge.net>
Cc: Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [PATCH] Move rpbind's default configuration to /run verses /var/run
Date: Sat, 31 Aug 2024 11:44:25 -0400
Message-ID: <20240831154425.59200-1-steved@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Signed-off-by: Steve Dickson <steved@redhat.com>
---
 configure.ac     | 4 ++--
 man/rpcbind-fr.8 | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/configure.ac b/configure.ac
index 8f4cef3..cbbc172 100644
--- a/configure.ac
+++ b/configure.ac
@@ -32,8 +32,8 @@ AC_ARG_ENABLE([rmtcalls],
 AM_CONDITIONAL(RMTCALLS, test x$enable_rmtcalls = xyes)
 
 AC_ARG_WITH([statedir],
-  AS_HELP_STRING([--with-statedir=ARG], [use ARG as state dir @<:@default=/var/run/rpcbind@:>@])
-  ,, [with_statedir=/var/run/rpcbind])
+  AS_HELP_STRING([--with-statedir=ARG], [use ARG as state dir @<:@default=/run/rpcbind@:>@])
+  ,, [with_statedir=/run/rpcbind])
 AC_SUBST([statedir], [$with_statedir])
 
 AC_ARG_WITH([rpcuser],
diff --git a/man/rpcbind-fr.8 b/man/rpcbind-fr.8
index 7db39e7..711acdd 100644
--- a/man/rpcbind-fr.8
+++ b/man/rpcbind-fr.8
@@ -138,8 +138,8 @@ est red
 .Xr rpcbind 3 ,
 .Xr rpcinfo 8
 .Sh FILES
-.Bl -tag -width /var/run/rpcbind.sock -compact
-.It Pa /var/run/rpcbind.sock
+.Bl -tag -width /run/rpcbind.sock -compact
+.It Pa /run/rpcbind.sock
 .Sh TRADUCTION
 Aurelien CHARBON (Sept 2003)
 .El
-- 
2.46.0


