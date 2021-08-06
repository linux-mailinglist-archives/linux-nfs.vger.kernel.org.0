Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A5093E2AA3
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Aug 2021 14:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240311AbhHFMeC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 6 Aug 2021 08:34:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:57681 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238794AbhHFMeC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 6 Aug 2021 08:34:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628253226;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aESQJrjRjEGA2KBzRJNS+CI346f4W84tNzuVuGynsGk=;
        b=ffefhdAN3yD1EfZFZ63hTdH7qzl3nwYwiq+zfXO4aomh7iLOtDiwglKI6PH1DHBnULXJte
        rPvxNoD4RjoFtD3ysdk80K/fa1DkIsrP7U/5G7Wvr0xyTzwE5cMkvulrUYVaeRIxKDsMuw
        nWHvq/ipkpqbhrY7FFynqJkTAdri7wY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-428-26wt8Yr7MrOYfzg-49YItw-1; Fri, 06 Aug 2021 08:33:44 -0400
X-MC-Unique: 26wt8Yr7MrOYfzg-49YItw-1
Received: by mail-wr1-f71.google.com with SMTP id f6-20020adfe9060000b0290153abe88c2dso3103058wrm.20
        for <linux-nfs@vger.kernel.org>; Fri, 06 Aug 2021 05:33:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aESQJrjRjEGA2KBzRJNS+CI346f4W84tNzuVuGynsGk=;
        b=abF3nJBdaPn76FM+krBoOTPyOwZR7cdsmHBp/7xPrgPevPx3r5BzcAeXaWbEvDDnPe
         lavT9QpMhu+bWmPpEO/rYUI3ZTL4T8Gvqo8ecIEbGN02+2EwYr5rAQZvkxYhnQmq7Wuq
         8L5Q7wAJ3sBkl3IKAgi1s9dYGnSoBbmfGQ3wUNXdkGsMNnEE2FGPTM4OKQsBTnA0s4sA
         oo5RLl2i8Xt0XMMCOenoNcwCAWMml7RUQSlS8g/kUzvujHVsGL6PES6HJr+v+oNbmqSU
         wbaF0CPiqjDLgpILV2wiHk5e2MboVu1t1CbyCTw+F5+LhgyohBRQfNNoRX+ElsqROZp4
         4hUQ==
X-Gm-Message-State: AOAM530n2FBjPi+S3NKL8aWURdBCsrbDkS5oaZYeu/nY7ws4OIy0Rlqh
        Lukkpm90c6Lzrria/WP61x6a473LuiNwAp0BSsN9ejsJ8yPnIBOroioc/Cwqwu/XOy9Zg3SBS39
        JQE125bqLTM/i2ygQdDoRN4wpi7GR/7LvTiGn0+E0fsto/tjkhoezDgHB8ZaAEbMNMjlE5sJoI0
        Y=
X-Received: by 2002:adf:ec50:: with SMTP id w16mr10704074wrn.56.1628253223618;
        Fri, 06 Aug 2021 05:33:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz0Y49ueJ/Wz2xCnuuQ6uLrfCI8s48uMCVD+9PCB0uxsKKhUe21xHZeAm+f1HGkzdBUtHmjRg==
X-Received: by 2002:adf:ec50:: with SMTP id w16mr10704063wrn.56.1628253223492;
        Fri, 06 Aug 2021 05:33:43 -0700 (PDT)
Received: from ajmitchell.remote.csb ([95.145.245.173])
        by smtp.gmail.com with ESMTPSA id y4sm8412147wmi.22.2021.08.06.05.33.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Aug 2021 05:33:43 -0700 (PDT)
Message-ID: <ff86aef24ddf77e413ec410eedd4312991e91be7.camel@redhat.com>
Subject: [PATCH 4/4] nfs-utils: Fix mem leak in mountd
From:   Alice Mitchell <ajmitchell@redhat.com>
To:     linux-nfs@vger.kernel.org
Cc:     Steve Dickson <steved@redhat.com>
Date:   Fri, 06 Aug 2021 13:33:42 +0100
In-Reply-To: <ee45aa412acaf7a2c035ad98e966394a7293dd9f.camel@redhat.com>
References: <ee45aa412acaf7a2c035ad98e966394a7293dd9f.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


Signed-off-by: Alice Mitchell <ajmitchell@redhat.com>
---
 utils/mountd/rmtab.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/utils/mountd/rmtab.c b/utils/mountd/rmtab.c
index 2da9761..752fdb6 100644
--- a/utils/mountd/rmtab.c
+++ b/utils/mountd/rmtab.c
@@ -233,6 +233,9 @@ mountlist_list(void)
 			m->ml_directory = strdup(rep->r_path);
 
 			if (m->ml_hostname == NULL || m->ml_directory == NULL) {
+				free(m->ml_hostname);
+				free(m->ml_directory);
+				free(m);
 				mountlist_freeall(mlist);
 				mlist = NULL;
 				xlog(L_ERROR, "%s: memory allocation failed",
-- 
2.27.0


