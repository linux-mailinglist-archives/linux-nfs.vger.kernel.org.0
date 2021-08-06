Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 130913E2A92
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Aug 2021 14:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242963AbhHFMb7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 6 Aug 2021 08:31:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44127 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240236AbhHFMb6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 6 Aug 2021 08:31:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628253102;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KixNqcHb8bfLfBeFccLz/WI0Jy7E7rn7CMMF9Jr+bLc=;
        b=eWrtWkHslDoRLTe0nwIJs0grVvYl0Y4Xrw102gto6zJlXX8/OIylbKz+FgPhJZ5lH7CE2E
        VxB2jRv28qHmE+KP+eEhXLb4qCNRREd1L4jAd7sgYCBf+a7DL2hPNVqVu7VSWTx0no05LD
        MOPy1RQlz5yvlxyQ46IRtZeR/k4Exd0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-161-XhD7dNHNPE2lA3PSW_engQ-1; Fri, 06 Aug 2021 08:31:41 -0400
X-MC-Unique: XhD7dNHNPE2lA3PSW_engQ-1
Received: by mail-wr1-f69.google.com with SMTP id s22-20020adf97960000b02901535eae4100so3097558wrb.14
        for <linux-nfs@vger.kernel.org>; Fri, 06 Aug 2021 05:31:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KixNqcHb8bfLfBeFccLz/WI0Jy7E7rn7CMMF9Jr+bLc=;
        b=JxB+1rERYOHfDQFU28uB7ZtAhBlmWgM+B4umg2mskh+5Z+L05Af4XoPQT/J2Yj4Z3N
         Qn6UvkSWl2tZcp7yMtxgEF4tRdxaHc9CRH6bQvpP7uSoz7u3fD10zCtIfRhd96tyJAHP
         wbAbeYPXQTpjoUIekjoOL2BSVfg9twd3yvZXTCzbajCKVNV+W+zcYscg9MIP+0ezNP9Y
         eJxUGyTj+BycWq3MYRxhBlmXazfC3lFHj3VcomhM6dxQZAZ+2uXYBUasT9vHlBoXu8yN
         XfzWoBim8xWwqOk9MkIKmebPDb5GnKPxeuIIJME/BDkMRpE9QfhHzj0SYyOgsON59LP2
         tsJg==
X-Gm-Message-State: AOAM531DDkw8AEuFRpobJN7SSaCSg3tWuoWxRBEYBenUKQ3rDaSoXspA
        Yxxe0zNalqhMo/FdBHwZADwiLyVYGwwjWA6hMOl/1QIvtEbnj5h0V5iU9N1d1LZeg03VqODtgtx
        KoR01N1R4sJxkwHl+eef2f/WVNblMYYGHQVk1rf6LGuv2xWhK5A4b9kZty8fihRIhG6yYKt07bo
        Y=
X-Received: by 2002:a5d:540d:: with SMTP id g13mr10401046wrv.329.1628253099753;
        Fri, 06 Aug 2021 05:31:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwwtScdnrXL9jtnengO2/2qgWeG1lgQbbF9bBRYmT72xXpg832E5gQqwZd3e5NjCiIu3mzh0A==
X-Received: by 2002:a5d:540d:: with SMTP id g13mr10401025wrv.329.1628253099549;
        Fri, 06 Aug 2021 05:31:39 -0700 (PDT)
Received: from ajmitchell.remote.csb ([95.145.245.173])
        by smtp.gmail.com with ESMTPSA id l9sm9257484wro.92.2021.08.06.05.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Aug 2021 05:31:39 -0700 (PDT)
Message-ID: <e0e036cb4e438fdeb5ed1b8a988dcb170907f012.camel@redhat.com>
Subject: [PATCH 1/4] nfs-utils: Fix potential memory leaks in idmap
From:   Alice Mitchell <ajmitchell@redhat.com>
To:     linux-nfs@vger.kernel.org
Cc:     Steve Dickson <steved@redhat.com>
Date:   Fri, 06 Aug 2021 13:31:38 +0100
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
 support/nfsidmap/nss.c   | 4 ++--
 support/nfsidmap/regex.c | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/support/nfsidmap/nss.c b/support/nfsidmap/nss.c
index 669760b..f00bd9b 100644
--- a/support/nfsidmap/nss.c
+++ b/support/nfsidmap/nss.c
@@ -365,9 +365,9 @@ static int _nss_name_to_gid(char *name, gid_t *gid,
int dostrip)
 out_buf:
 	free(buf);
 out_name:
-	if (dostrip)
+	if (localname)
 		free(localname);
-	if (get_reformat_group())
+	if (ref_name)
 		free(ref_name);
 out:
 	return err;
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


