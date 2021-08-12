Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 872CA3EA9FA
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Aug 2021 20:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237463AbhHLSNy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 12 Aug 2021 14:13:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:35040 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229850AbhHLSNy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 12 Aug 2021 14:13:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628792008;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wqW9N6nC8tvtKEfunTv2HYnvf5i94m4NNDiovWEBrJo=;
        b=jR87EbM931CZ6vb9Ai/YDDxEzHZQbdXPO+FNnB+265wN7gyZcbS6MPHYZ8ERD5ZBAWsXYg
        vIEbl6SaBv0vDwcLFY8SfQVtf+C/fqXjvtzpQWDujbEykop4lPZaVFlmvvq+wH7Ls5XWzN
        IQHtBe8os/DP61j/BXQJZ34Z1BffJEo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-292-hjfKIkVvPOizBaIKXkmeZg-1; Thu, 12 Aug 2021 14:13:26 -0400
X-MC-Unique: hjfKIkVvPOizBaIKXkmeZg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F10991082925
        for <linux-nfs@vger.kernel.org>; Thu, 12 Aug 2021 18:13:25 +0000 (UTC)
Received: from ajmitchell.com (unknown [10.39.192.151])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EA3C118AD4;
        Thu, 12 Aug 2021 18:13:24 +0000 (UTC)
From:   Alice Mitchell <ajmitchell@redhat.com>
To:     linux-nfs@vger.kernel.org
Cc:     steved@redhat.com, Alice Mitchell <ajmitchell@redhat.com>
Subject: [PATCH 1/4 v2] nfs-utils: Fix potential memory leaks in idmap
Date:   Thu, 12 Aug 2021 19:13:16 +0100
Message-Id: <20210812181319.3885781-2-ajmitchell@redhat.com>
In-Reply-To: <20210812181319.3885781-1-ajmitchell@redhat.com>
References: <20210812181319.3885781-1-ajmitchell@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

regex.c: regex_getpwnam() would leak memory if the name was not found.

nss.c: nss_name_to_gid() the conditional frees look like a potential
       memory leak, removed the unnecessary conditions.

Signed-off-by: Alice Mitchell <ajmitchell@redhat.com>
---
 support/nfsidmap/nss.c   | 6 ++----
 support/nfsidmap/regex.c | 1 +
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/support/nfsidmap/nss.c b/support/nfsidmap/nss.c
index 669760b..0f43076 100644
--- a/support/nfsidmap/nss.c
+++ b/support/nfsidmap/nss.c
@@ -365,10 +365,8 @@ static int _nss_name_to_gid(char *name, gid_t *gid, int dostrip)
 out_buf:
 	free(buf);
 out_name:
-	if (dostrip)
-		free(localname);
-	if (get_reformat_group())
-		free(ref_name);
+	free(localname);
+	free(ref_name);
 out:
 	return err;
 }
diff --git a/support/nfsidmap/regex.c b/support/nfsidmap/regex.c
index fdbb2e2..958b4ac 100644
--- a/support/nfsidmap/regex.c
+++ b/support/nfsidmap/regex.c
@@ -157,6 +157,7 @@ again:
 	IDMAP_LOG(4, ("regexp_getpwnam: name '%s' mapped to '%s'",
 		  name, localname));
 
+	free(localname);
 	*err_p = 0;
 	return pw;
 
-- 
2.27.0

