Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1D5A3E2A9E
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Aug 2021 14:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343704AbhHFMcm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 6 Aug 2021 08:32:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54609 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1343699AbhHFMcm (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 6 Aug 2021 08:32:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628253146;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zCJcYHDj5auKge+/03UDfyPE2VgSp2GxYsZu4Bcf2fo=;
        b=PUXWm/srwrR5z0p2lLp80hf0iA0SC3fj8TR5f+KL/9n49wv65yquwS8ZOPMuvqMAxye7Db
        TNo6y4zIBKcmQd+fwei1+ahzorQt+p2w3IsxvPAwYrcUOV7TifguKs9ujRDpKczPadVCIl
        vmgOvXrQNzBTu4gJEF9EFGS8OPeSJ8w=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-51-wAnAUSLPPKOrl9w0WEtAeg-1; Fri, 06 Aug 2021 08:32:25 -0400
X-MC-Unique: wAnAUSLPPKOrl9w0WEtAeg-1
Received: by mail-wr1-f72.google.com with SMTP id o11-20020a5d474b0000b02901533f8ed22cso3093432wrs.22
        for <linux-nfs@vger.kernel.org>; Fri, 06 Aug 2021 05:32:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zCJcYHDj5auKge+/03UDfyPE2VgSp2GxYsZu4Bcf2fo=;
        b=e5KgxPirJmzwCkTsC5fNhMEYiZcjlobao6RXNjbE/bxy/uPpCu4OQ2vzwuJcmny2u2
         Abmc7vBAZBnmsKz6hp+EPX81mxgwtP5eHsb7AicE4tJ67E4SZGGccvrAyc9rI4Iew//5
         +wrqtW3Xoq2B1mCBvg7Gm/zmt4za43OqvmRq0t/abNBwkGDEL2k8dJOFjKiWTX0GDHmZ
         d7EDI3O7e6ssGDUQ3dBQAZV9TdovIEz/8nn2L+niG34Um/ULuSBW6bqQHy7KeYKMXhBF
         XyyW5KxM8GHIcL/kNfo4KkGahbzFqHW5uIrJ4eljCDQMLWbCvmxJbf6uFL2JMbya5ujy
         s9TQ==
X-Gm-Message-State: AOAM533JV2ASyBHIOKA5dQx6qiFPhX1UoRnvXHG8w7IpJbOdLXHOzAx9
        yuEr9Pb8mGcrn4+8sefWToauW8c/aEQWANcsQjn80eTbrh6W6PkWi0lHzAcIZYY8KXnd8GiiCJt
        ZBj0JQRBKJfdNyB3FjICw5cgB40UJbQ36SuM6JHNYFegq+gmAEZbGvDbStfw8OzVSjYmVvqhv2S
        Q=
X-Received: by 2002:adf:f845:: with SMTP id d5mr10376403wrq.267.1628253143776;
        Fri, 06 Aug 2021 05:32:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzE1F13IvQ6Q12V9LWNsTWFR1xLw+9avz9flvqfGHWuH06XiQLM7euObAZyg3MuyiRUUIwoVQ==
X-Received: by 2002:adf:f845:: with SMTP id d5mr10376383wrq.267.1628253143623;
        Fri, 06 Aug 2021 05:32:23 -0700 (PDT)
Received: from ajmitchell.remote.csb ([95.145.245.173])
        by smtp.gmail.com with ESMTPSA id s14sm8212809wmc.25.2021.08.06.05.32.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Aug 2021 05:32:23 -0700 (PDT)
Message-ID: <b8b806a99bd53ef9a1e8892f167ea919c52af730.camel@redhat.com>
Subject: [PATCH 2/4] nfs-utils: Fix mem leaks in gssd
From:   Alice Mitchell <ajmitchell@redhat.com>
To:     linux-nfs@vger.kernel.org
Cc:     Steve Dickson <steved@redhat.com>
Date:   Fri, 06 Aug 2021 13:32:22 +0100
In-Reply-To: <ee45aa412acaf7a2c035ad98e966394a7293dd9f.camel@redhat.com>
References: <ee45aa412acaf7a2c035ad98e966394a7293dd9f.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Also fix the modification of a returned config value which 
should be treated as const.

Signed-off-by: Alice Mitchell <ajmitchell@redhat.com>
---
 utils/gssd/gssd.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/utils/gssd/gssd.c b/utils/gssd/gssd.c
index 4113cba..0815665 100644
--- a/utils/gssd/gssd.c
+++ b/utils/gssd/gssd.c
@@ -1016,7 +1016,7 @@ read_gss_conf(void)
 		keytabfile = s;
 	s = conf_get_str("gssd", "cred-cache-directory");
 	if (s)
-		ccachedir = s;
+		ccachedir = strdup(s);
 	s = conf_get_str("gssd", "preferred-realm");
 	if (s)
 		preferred_realm = s;
@@ -1070,7 +1070,7 @@ main(int argc, char *argv[])
 				keytabfile = optarg;
 				break;
 			case 'd':
-				ccachedir = optarg;
+				ccachedir = strdup(optarg);
 				break;
 			case 't':
 				context_timeout = atoi(optarg);
@@ -1133,7 +1133,6 @@ main(int argc, char *argv[])
 	}
 
 	if (ccachedir) {
-		char *ccachedir_copy;
 		char *ptr;
 
 		for (ptr = ccachedir, i = 2; *ptr; ptr++)
@@ -1141,8 +1140,7 @@ main(int argc, char *argv[])
 				i++;
 
 		ccachesearch = malloc(i * sizeof(char *));
-	       	ccachedir_copy = strdup(ccachedir);
-		if (!ccachedir_copy || !ccachesearch) {
+		if (!ccachesearch) {
 			printerr(0, "malloc failure\n");
 			exit(EXIT_FAILURE);
 		}
@@ -1274,6 +1272,8 @@ main(int argc, char *argv[])
 
 	free(preferred_realm);
 	free(ccachesearch);
+	if (ccachedir)
+		free(ccachedir);
 
 	return rc < 0 ? EXIT_FAILURE : EXIT_SUCCESS;
 }
-- 
2.27.0


