Return-Path: <linux-nfs+bounces-8046-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 803879D1989
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Nov 2024 21:19:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D729B21AD7
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Nov 2024 20:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 230CB14D2BB;
	Mon, 18 Nov 2024 20:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="czaZ+0xX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE1E1DED66
	for <linux-nfs@vger.kernel.org>; Mon, 18 Nov 2024 20:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731961150; cv=none; b=PcN5ZFfrYqdMmOlB+9OjNdMQ0DHO4O6/WN83cCP2dBo+ralErNEB6VB0e9VjkTMKMA+XEpNbITCltrf7S3feA1aLYBKPETRc9dcahhXAiQOTEohtRc4zKPrpApNP8QgYpqNix56pSBAj6I8Pp61d+yf1VV3zQTJObVx2vDXhMz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731961150; c=relaxed/simple;
	bh=Geg7EWumcxB6X7Clq95qbAeiV/cwwQqTNq8qWO415O4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MwEfr3IM9XaZMsfBiF6fnvWDE2ZiYPxkT/gVblMpyUqF8X004WGd7sQaVPihe9n6V2a1K18dYxDEV9xPb8bu7+1aKSwVjj0SSaz4PO7LbUAFiSVENsSEESRMr1cWN9fl/zy5115rVaPl1ZMabKWmV3y8UQjsnwDm6XWysAvSpgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=czaZ+0xX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731961146;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TnuH4zEbD7/7yHR1hH194SLNcqO+I74LUppQu6+Dljc=;
	b=czaZ+0xXLmpV6AkrPm6KB3cKbvMqeaMVP4vExNq+4NEZ7LsQqdFapqgEW7eTMHn/UILOhB
	90dbfIIDAsUsYE6XCILS6qfyVdnYh7mMT8ZeAcwHDCWgEIaDTm/Kc8d/7ymg8f+JFqcH6E
	4mXdxDfSjcgCulhHFRh0QSXnF0wJKjQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-684-spI2vV-vPuSVy4w0Ivn6wA-1; Mon,
 18 Nov 2024 15:19:04 -0500
X-MC-Unique: spI2vV-vPuSVy4w0Ivn6wA-1
X-Mimecast-MFC-AGG-ID: spI2vV-vPuSVy4w0Ivn6wA
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E08FF1955EBA
	for <linux-nfs@vger.kernel.org>; Mon, 18 Nov 2024 20:19:03 +0000 (UTC)
Received: from aion.redhat.com (unknown [10.22.80.18])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B78F61955F43;
	Mon, 18 Nov 2024 20:19:03 +0000 (UTC)
Received: from aion.redhat.com (localhost [IPv6:::1])
	by aion.redhat.com (Postfix) with ESMTP id 38918222554;
	Mon, 18 Nov 2024 15:19:02 -0500 (EST)
From: Scott Mayhew <smayhew@redhat.com>
To: steved@redhat.com
Cc: linux-nfs@vger.kernel.org
Subject: [nfs-utils PATCH 1/2] nfsdctl: fix up the help text in version_usage()
Date: Mon, 18 Nov 2024 15:19:01 -0500
Message-ID: <20241118201902.1115861-2-smayhew@redhat.com>
In-Reply-To: <20241118201902.1115861-1-smayhew@redhat.com>
References: <20241118201902.1115861-1-smayhew@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

The help text in version_usage() has examples with a 'v' character in
the version string, but the format string in the sscanf() call in
version_func() doesn't contain a 'v' character.

Signed-off-by: Scott Mayhew <smayhew@redhat.com>
---
 utils/nfsdctl/nfsdctl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/utils/nfsdctl/nfsdctl.c b/utils/nfsdctl/nfsdctl.c
index f7c27632..ef917ff0 100644
--- a/utils/nfsdctl/nfsdctl.c
+++ b/utils/nfsdctl/nfsdctl.c
@@ -764,9 +764,9 @@ static void version_usage(void)
 	printf("    Display currently enabled and disabled versions:\n");
 	printf("        version\n");
 	printf("    Disable NFSv4.0:\n");
-	printf("        version -v4.0\n");
+	printf("        version -4.0\n");
 	printf("    Enable v4.1, v4.2, disable v2, v3 and v4.0:\n");
-	printf("        version -2 -3 -v4.0 +4.1 +v4.2\n");
+	printf("        version -2 -3 -4.0 +4.1 +4.2\n");
 }
 
 static int version_func(struct nl_sock *sock, int argc, char ** argv)
-- 
2.46.2


