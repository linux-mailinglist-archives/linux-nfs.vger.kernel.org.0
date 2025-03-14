Return-Path: <linux-nfs+bounces-10619-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DB1BA61454
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Mar 2025 15:57:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 524294618C6
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Mar 2025 14:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EF7F7485;
	Fri, 14 Mar 2025 14:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JGj1kMus"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00DC1FF7C1
	for <linux-nfs@vger.kernel.org>; Fri, 14 Mar 2025 14:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741964275; cv=none; b=M0jUiOhRiDXGAHQDzETy3m1vfjSilKbzhCv23dqk35jsK9wtDkhzodXUwvu3Br72PXmU/bPBtQ1j88mpf0JVxIqoTgItrCjYVltEANPnOxHYBZRHKzDOcE8ciYd39/vb+yyaGWqNUQHevlNXpEN7fMJh68j3Crj/vTbFRS0XGu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741964275; c=relaxed/simple;
	bh=rqU1mMkZv7S6XjyarOq31RLEPVZWfK7IbzXgiw+GGsA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rT0FUh8MOj9R/Q45oVRLYCkMEbk+/kjWA6aALoR/LGXWq09kdi6ALTwanlBga8r/blmL0RSpbwM4nEY1fJ8+yAM3RJj8ZEoHpvoHMCBGX03AvXIxILyMfUw4ElWp/3WX04X0O/2p4Khu/zlXeObvbex0K3ae2LeQznONagdLKW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JGj1kMus; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741964272;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Su1ARaLsfTE2KBzR7QD+n170cKSTGhKTAnpX8b6YKCQ=;
	b=JGj1kMusb9eSK8RuCrNrDryJ11FQI7HLrXmlQrquc217Irl7+HyiWkssrcJeiDgAczHXSy
	R5WWDzv/GKwl6HhD81QWQGUPF/0GlrHQZ0eXGTDcPEIu9xuGCqr1ir7AT596/CfWDUIRgp
	jDdY+0SAfLVvzpDww8sFGyO0atrVBGg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-342-Ke9ou4YjPaqeewpIM5jTzQ-1; Fri,
 14 Mar 2025 10:57:51 -0400
X-MC-Unique: Ke9ou4YjPaqeewpIM5jTzQ-1
X-Mimecast-MFC-AGG-ID: Ke9ou4YjPaqeewpIM5jTzQ_1741964270
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 65DDB1800262;
	Fri, 14 Mar 2025 14:57:50 +0000 (UTC)
Received: from aion.redhat.com (unknown [10.22.80.106])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2ECD218001E9;
	Fri, 14 Mar 2025 14:57:50 +0000 (UTC)
Received: from aion.redhat.com (localhost [IPv6:::1])
	by aion.redhat.com (Postfix) with ESMTP id 88560339005;
	Fri, 14 Mar 2025 10:57:48 -0400 (EDT)
From: Scott Mayhew <smayhew@redhat.com>
To: steved@redhat.com
Cc: romero@fnal.gov,
	bcodding@redhat.com,
	linux-nfs@vger.kernel.org
Subject: [nfs-utils PATCH] gssd.man: add documentation for use-gss-proxy nfs.conf option
Date: Fri, 14 Mar 2025 10:57:48 -0400
Message-ID: <20250314145748.1026752-1-smayhew@redhat.com>
In-Reply-To: <E11151A2-D253-4F26-BB94-5CDA22FEF1B6@redhat.com>
References: <E11151A2-D253-4F26-BB94-5CDA22FEF1B6@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Signed-off-by: Scott Mayhew <smayhew@redhat.com>
---
 utils/gssd/gssd.man | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/utils/gssd/gssd.man b/utils/gssd/gssd.man
index c735eff6..d9a264e8 100644
--- a/utils/gssd/gssd.man
+++ b/utils/gssd/gssd.man
@@ -392,6 +392,17 @@ Setting to
 is equivalent to providing the
 .B -H
 flag.
+.TP
+.B use-gss-proxy
+Setting this to 1 allows
+.BR gssproxy (8)
+to intercept GSSAPI calls and service them on behalf of
+.BR rpc.gssd ,
+enabling certain features such as keytab-based client initiation.
+Note that this has nothing to do with the functionality that
+.BR gssproxy (8)
+provides on behalf of the NFS server.  For more information, see
+.BR https://github.com/gssapi/gssproxy/blob/main/docs/NFS.md#nfs-client .
 .P
 In addtion, the following value is recognized from the
 .B [general]
@@ -405,7 +416,8 @@ Equivalent to
 .BR rpc.svcgssd (8),
 .BR kerberos (1),
 .BR kinit (1),
-.BR krb5.conf (5)
+.BR krb5.conf (5),
+.BR gssproxy (8)
 .SH AUTHORS
 .br
 Dug Song <dugsong@umich.edu>
-- 
2.48.1


