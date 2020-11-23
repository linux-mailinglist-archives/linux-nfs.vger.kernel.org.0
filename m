Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B334F2C12F8
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Nov 2020 19:18:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732617AbgKWSRt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Nov 2020 13:17:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28987 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730411AbgKWSRt (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 Nov 2020 13:17:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606155468;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=4B5ekyejXXau6sBCrQA+snRY6dudfJUivrXJWPS43QY=;
        b=hlyizdmBOHbRTVAjEUwCA6WRMJWXk3PEDrsHTUJkJnMlrsEa/tTsWIlXGwEYeMzJIrsn2Y
        UrCiLI8zmrPQB6it7oH0IZt2hjxtAnjvMyumSEkGbliOsCuhvmdgzAnC/UWG8lCc4kgsLz
        XA2TXA++2ibZeVPqLE6G6lzMhcPr5Yo=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-362-V0Zwmh_kOPiS2v4LDsJMvw-1; Mon, 23 Nov 2020 13:17:43 -0500
X-MC-Unique: V0Zwmh_kOPiS2v4LDsJMvw-1
Received: by mail-pg1-f198.google.com with SMTP id j30so1847313pgj.17
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 10:17:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=4B5ekyejXXau6sBCrQA+snRY6dudfJUivrXJWPS43QY=;
        b=WlCAs3hG1DthXyKNPfkh0pruGHk5aPShBWDFxl4W3l5feVOIDVhJygJOdvh03VNBRY
         Oiv5oUZ39rRGEoDZrJbqxjD0v3Ue0DkbJ8ueQwnpR8NV9jZw1Z+8jSpXRxMR4ehgzcrX
         JA/PRVIf6M+46Tf9DgyNRUhqcjdTEHRYcZBrzXdRWTft6nrdvRbffeBUkqNPKqajuLMT
         gUEdnMnofpqCwxne8hVIYv6qXUncFBS7CUeYcsrkn+SFlEv1bhCsmPoqgqPiDUYKVZ1L
         p1m2sN73SvGZptDczXRTgLdYDPqQdxqP5uWo+Y73JkPiQ2MW0zfJLZIYsdvRV3kbhFDk
         UkKA==
X-Gm-Message-State: AOAM531+qzfFBdKFkRtIff7NZ8PFNF2FMVsEJwZ7H316rW8DzJRbU51F
        XGB7a+nnRRwIVchs/KPVDeUeKrs5vHc4XKlWO/H9TwKs6w0u+DtqYrGJjePgSvBZhPEHwy9A86G
        FyUT+TfBrnicgobNw+8K5psF2fS70TTNDf5ax
X-Received: by 2002:a17:902:9891:b029:d8:fdf6:7c04 with SMTP id s17-20020a1709029891b02900d8fdf67c04mr617517plp.54.1606155461947;
        Mon, 23 Nov 2020 10:17:41 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyTAyZoEIj6qA4Yz4M6PB0QCbOhc3Cbm+nGPwYq/ccLCusjFCE84g8e7khcSth75lF9plFxzf2u+ppiHRYfUao=
X-Received: by 2002:a17:902:9891:b029:d8:fdf6:7c04 with SMTP id
 s17-20020a1709029891b02900d8fdf67c04mr617500plp.54.1606155461688; Mon, 23 Nov
 2020 10:17:41 -0800 (PST)
MIME-Version: 1.0
From:   Jacob Shivers <jshivers@redhat.com>
Date:   Mon, 23 Nov 2020 13:17:05 -0500
Message-ID: <CALe0_74eB89Koni0i14aB=2CSitzg1WkRihe7KZGDJ5OoPSahw@mail.gmail.com>
Subject: gssd: set $HOME to prevent recursion when home dirs are on kerberized
 NFS mount revisted
To:     linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Commit 2f682f25c642fcfe7c511d04bc9d67e732282348 changed existing
behavior to avoid a deadlock for users using Kerberized NFS home dirs.

However, this also prevents users leveraging their own k5identity
files under their home directory and instead rpc.gssd uses a
system-wide /.k5identity file. For users expecting to use their own
k5identity file this is certainly unexpected.

Below is some pseudo code that was proposed and would just add a flag
allowing for the behavior prior to
2f682f25c642fcfe7c511d04bc9d67e732282348:

/* psudo code snippet starts here */
        /*
         * Some krb5 routines try to scrape info out of files in the user's
         * home directory. This can easily deadlock when that homedir is on a
-        * kerberized NFS mount. By setting $HOME unconditionally to "/", we
+        * kerberized NFS mount. Some users may not have $HOME on NFS.
+        * By default setting $HOME unconditionally to "/", we
         * prevent this behavior in routines that use $HOME in preference to
         * the results of getpw*.
+        * Users who have $HOME on krb5-NFS should set
`--home-not-kerberized` in argv
+        * Users who have $HOME on krb5-NFS but want to use their
$HOME anyway should set NFS_HOME_ACCESSIBLE=TRUE
         */
+       if (argv == '--home-not-kerberized') ||
(getenv("NFS_HOME_ACCESSIBLE") == 'TRUE') {
+               log.debug('Not masking $HOME, this breaks on Kerberized $HOME');
+       }
+       else {
+               log.debug('Assuming $HOME requires Kerberos, use
`--home-not-kerberized` to change this behavior');
        if (setenv("HOME", "/", 1)) {
                printerr(1, "Unable to set $HOME: %s\n", strerror(errn));
                exit(1);
        }
+       }
/* psudo code snippet ends here */

While acknowledging the use of this flag for Kerberized NFS home dirs
is undesirable and would cause a deadlock, there should be no issue
for users not using Kerberized NFS home dirs.

Does anyone consider adding the above proposed flag as being problematic?

