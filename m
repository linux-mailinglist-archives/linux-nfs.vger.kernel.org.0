Return-Path: <linux-nfs+bounces-5004-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3311E938C1E
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Jul 2024 11:33:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B08F7B2126F
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Jul 2024 09:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3ECC16C6A4;
	Mon, 22 Jul 2024 09:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cZwkclqG"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A26316C692
	for <linux-nfs@vger.kernel.org>; Mon, 22 Jul 2024 09:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721640776; cv=none; b=JoQn82+WTb9Bz6Uwm6FUj85RzzlcFVM+23hydz90W3iWlbPLWO3a+MTmLyEEBe4QVPBrSJSjJnv3npenIMaI84RVtT6Tlul8B6JOdUaOnEtuFkvslE0rn70pkin3Uo7br0FYhS2mRCFy4BeV0Di8fvdRM+JOroA+tmaZAFVzSvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721640776; c=relaxed/simple;
	bh=S9nkHi5a4u8FplO5Vp+bd2o97x0x5D8zkif0K/+WIdI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=OySs9yWGKowh0ccQ4u6gEwZ6ckO+3cQXkVXK/QB2/gI1fSxLYbsPvR9qWgCgCIzNyP51Ntz4SJRya7fKc6DT3wo+oQlUNTMMr3PKVQGDzlthwzIW667vfENgi82T4lMCIjUUldy3N+TpiZ9DiDHolOBLUksnRYfm5fjFfn/FgXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cZwkclqG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721640774;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5c2LmvT/tWqWiwToj2Yo11s0Ln8sxCNHuazsn9JQjHc=;
	b=cZwkclqGimonZIYv23m5E90UxKxXF1pvLEjSrJQcow8tr8UZqII658izNugrdj4jURe4JB
	qW5KTDgJky3OUWq2/WOD63ze9LOXZhs5Xu118ISxioZdyvlim/h973T+3F11MiZ66195IM
	iplcqcBtW97hsgHNHxPL+iMETAhOKUM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-669-SKRkjSYeOnulvx9HWUgr6A-1; Mon,
 22 Jul 2024 05:32:49 -0400
X-MC-Unique: SKRkjSYeOnulvx9HWUgr6A-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 914E71955BF7
	for <linux-nfs@vger.kernel.org>; Mon, 22 Jul 2024 09:32:48 +0000 (UTC)
Received: from bighat.boston.devel.redhat.com (unknown [10.22.8.88])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C5F7619560B2
	for <linux-nfs@vger.kernel.org>; Mon, 22 Jul 2024 09:32:47 +0000 (UTC)
From: Steve Dickson <steved@redhat.com>
To: Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [PATCH] nfsidmap: Fix a memory leak
Date: Mon, 22 Jul 2024 05:32:09 -0400
Message-ID: <20240722093209.64038-1-steved@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Reported-by: Zhang Yaqi <zhangyaqi@kylinos.cn>
Signed-off-by: Steve Dickson <steved@redhat.com>
---
 support/nfsidmap/umich_ldap.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/support/nfsidmap/umich_ldap.c b/support/nfsidmap/umich_ldap.c
index 1aa2af49..0f88ba44 100644
--- a/support/nfsidmap/umich_ldap.c
+++ b/support/nfsidmap/umich_ldap.c
@@ -200,6 +200,7 @@ static int set_krb5_ccname(const char *krb5_ccache_name)
 		IDMAP_LOG(5, ("Failed to set creds cache for kerberos, err(%d)",
 			      retval));
 	}
+	free(env);
 #endif /* else HAVE_GSS_KRB5_CCACHE_NAME */
 out:
 	return retval;
-- 
2.45.2


