Return-Path: <linux-nfs+bounces-10630-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A90E4A650A1
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Mar 2025 14:22:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 097FA174B5F
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Mar 2025 13:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFA1723C390;
	Mon, 17 Mar 2025 13:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OINX4ays"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4554F23C8B6
	for <linux-nfs@vger.kernel.org>; Mon, 17 Mar 2025 13:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742217735; cv=none; b=im+O27daPx18IPbzz5v6GhiYffQPj+iWVtU85PgGKovgKV6t2r0rqaTb61rl7msGlbAekQhwV6yDmSVGhVAz8NZwyk4Bm1z1Zn7y/+bQCyvJZAkqPV6hATh/E1WmXK3xlscNvgsbJnqKiKPpMInug157N2pflSx2aQs3AYaS3AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742217735; c=relaxed/simple;
	bh=MLIG8EcdIBNePneXZwGGBOWQUk+rZKLMlyO0D7ats/w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rrvJNh2J+HeXlfg3mvGhs7YD7zUxP2k1v3/wutBjA7s1FiN6MtbLi89fLW+5krrKhMuu4NVH2dxfviYrHQTqTo1JdZTuG7ElsVG9L8qCDX2TTcammRf1uU9qGAuRMJmGcMEsUypc0ocnCwiPD+WEmUs3e31SfLKehtFVUUWwcgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OINX4ays; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742217733;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gG2J43kfWCJsUBIgMMmjpMs3rCOPOiBpA16rJMn/FgE=;
	b=OINX4aysD40Z2UuchOrrql7TdCXx22BbI0K5oLHWFcAoO9xCwPvFmG6+ioopl67HRNFp0B
	T09xIPOovbtm9D6Uz5jFXqNr0MEet+hxJKJ3xv4NVywT70e+3qvPTPRX1JGsTy3Gv3XxG/
	aVPp3xDf4ftnAo7wRUJjcJ+LGgJMUFM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-288-cFRgiZ-xPA6gDjk4fqjxqw-1; Mon,
 17 Mar 2025 09:22:09 -0400
X-MC-Unique: cFRgiZ-xPA6gDjk4fqjxqw-1
X-Mimecast-MFC-AGG-ID: cFRgiZ-xPA6gDjk4fqjxqw_1742217728
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 857B1180AF50;
	Mon, 17 Mar 2025 13:22:08 +0000 (UTC)
Received: from aion.redhat.com (unknown [10.22.88.143])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4B3EA18001D4;
	Mon, 17 Mar 2025 13:22:08 +0000 (UTC)
Received: from aion.redhat.com (localhost [IPv6:::1])
	by aion.redhat.com (Postfix) with ESMTP id 80ACD339A5B;
	Mon, 17 Mar 2025 09:22:06 -0400 (EDT)
From: Scott Mayhew <smayhew@redhat.com>
To: steved@redhat.com
Cc: romero@fnal.gov,
	bcodding@redhat.com,
	linux-nfs@vger.kernel.org
Subject: [nfs-utils PATCH v2] gssd.man: add documentation for use-gss-proxy nfs.conf option
Date: Mon, 17 Mar 2025 09:22:06 -0400
Message-ID: <20250317132206.1096158-1-smayhew@redhat.com>
In-Reply-To: <9e7f3d6a-0989-4778-a2c0-ffafdebefa87@redhat.com>
References: <9e7f3d6a-0989-4778-a2c0-ffafdebefa87@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Signed-off-by: Scott Mayhew <smayhew@redhat.com>
---

v2 - slight phrasing change.

 utils/gssd/gssd.man | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/utils/gssd/gssd.man b/utils/gssd/gssd.man
index c735eff6..4a75b056 100644
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
+Note that this is unrelated to the functionality that
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


