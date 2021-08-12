Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 546443EA9FD
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Aug 2021 20:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237511AbhHLSN5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 12 Aug 2021 14:13:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55929 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237510AbhHLSN5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 12 Aug 2021 14:13:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628792011;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6iNJwpA32npLdkow459lPgJ90z66IsXSFHVy0KlfjbU=;
        b=Mq2lPkRQkLxQQKmNMRLeSkFUc61efptwasU2JzIXjx9Q1HbFyG+xG0PEWNIhS533V7uH4E
        LBdtDfSh47kTbjIx0wgvXbPCaxzM7Gc0P3TlBbDg9qMsaDV90sCt/0b4AHaRCPvN1jdzSz
        K7+tOCOKwOYb5gVYjdMPq7cxJ86jUzs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-435-LbmOEEHvNTCuGXw9twHgNQ-1; Thu, 12 Aug 2021 14:13:29 -0400
X-MC-Unique: LbmOEEHvNTCuGXw9twHgNQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D04008799FA
        for <linux-nfs@vger.kernel.org>; Thu, 12 Aug 2021 18:13:28 +0000 (UTC)
Received: from ajmitchell.com (unknown [10.39.192.151])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C69DB604CC;
        Thu, 12 Aug 2021 18:13:27 +0000 (UTC)
From:   Alice Mitchell <ajmitchell@redhat.com>
To:     linux-nfs@vger.kernel.org
Cc:     steved@redhat.com, Alice Mitchell <ajmitchell@redhat.com>
Subject: [PATCH 3/4 v2] nfs-utils: Fix mem leaks in krb5_util
Date:   Thu, 12 Aug 2021 19:13:18 +0100
Message-Id: <20210812181319.3885781-4-ajmitchell@redhat.com>
In-Reply-To: <20210812181319.3885781-1-ajmitchell@redhat.com>
References: <20210812181319.3885781-1-ajmitchell@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

query_krb5_ccache: if the ret_realm strdup fails then ret_princname leaks

gssd_get_krb5_machine_cred_list: l was being leaked if the realloc failed
it was also leaked if the strdup of ccname failed

Signed-off-by: Alice Mitchell <ajmitchell@redhat.com>
---
 utils/gssd/krb5_util.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/utils/gssd/krb5_util.c b/utils/gssd/krb5_util.c
index c5f1152..6d059f3 100644
--- a/utils/gssd/krb5_util.c
+++ b/utils/gssd/krb5_util.c
@@ -1129,6 +1129,12 @@ query_krb5_ccache(const char* cred_cache, char **ret_princname,
 			    *str = '\0';
 			    *ret_princname = strdup(princstring);
 			    *ret_realm = strdup(str+1);
+			    if (!*ret_princname || !*ret_realm) {
+				    free(*ret_princname);
+				    free(*ret_realm);
+				    *ret_princname = NULL;
+				    *ret_realm = NULL;
+			    }
 		    }
 		    k5_free_unparsed_name(context, princstring);
 		}
@@ -1350,15 +1356,19 @@ gssd_get_krb5_machine_cred_list(char ***list)
 		if (retval)
 			continue;
 		if (i + 1 > listsize) {
+			char **tmplist;
 			listsize += listinc;
-			l = (char **)
+			tmplist = (char **)
 				realloc(l, listsize * sizeof(char *));
-			if (l == NULL) {
+			if (tmplist == NULL) {
+				gssd_free_krb5_machine_cred_list(l);
 				retval = ENOMEM;
 				goto out_lock;
 			}
+			l = tmplist;
 		}
 		if ((l[i++] = strdup(ple->ccname)) == NULL) {
+			gssd_free_krb5_machine_cred_list(l);
 			retval = ENOMEM;
 			goto out_lock;
 		}
-- 
2.27.0

