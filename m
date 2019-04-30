Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EAFD2101CA
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Apr 2019 23:25:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726049AbfD3VZq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 30 Apr 2019 17:25:46 -0400
Received: from mail-vk1-f176.google.com ([209.85.221.176]:35046 "EHLO
        mail-vk1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726048AbfD3VZq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 30 Apr 2019 17:25:46 -0400
Received: by mail-vk1-f176.google.com with SMTP id t74so3460124vke.2
        for <linux-nfs@vger.kernel.org>; Tue, 30 Apr 2019 14:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=4xyXUYxnTFwy4NPFFIT+bS8lIfPyDn2kW+V+8jRdIQ0=;
        b=shBzugE8hMf8XoJlATvVlkK8JRwYYjt/nCiOjdjcyOZ6fsk9qZ+rohJTta0mNGIwTH
         owBzT0Ym/89tN+1TVrCwNjyM4AZCogwTE+AhcRsX6DJaWD6QmrtrH5xA7HXsKeVSFRsF
         owoFzsAWtNCeMH531f+4nsF35BWUoqFdyX3gAuWziTevWhGjTff+ACh5jf8ncQJOveGf
         Gk5oqfPXA7HWFjGVfcAusuerPwqkUT5Ph7SDo8/PlLjlXx41kws7wqA6pyTUzDxfGNE3
         yrXslyn+DbHY+43Vjh5RsFaeDhep4FP8w2cGfv03kWIdpj23yYFeiyZDpgwLXpMa0dB/
         Svrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=4xyXUYxnTFwy4NPFFIT+bS8lIfPyDn2kW+V+8jRdIQ0=;
        b=DMVWtO3GA2hPQMiDuj3x7i+F+XXRyl2IINwXCNI1clK01+H7fbgmorIsALjJDV1ESJ
         Ym/KcaPPgbXn773NDZ3TwNsQCfT6j72y5c9gg1RVevh5CnzxTXGlfrra/hdk/iLkr0qk
         393LQM0dGlXInYEdEVhkdiCMtOba02jbgdauk1U6DKEVXPsxzhmQJBUTgs7rBNwipD/A
         zY73rapIceMbfo8Gu/LKUmY+I4OnEJTVtFUWllWqPyHXykx/K+I3ALKupYxYptxkYej+
         /A6OWuRI2ZWBpCt+PxUQPcJehpH3lmAQBxXo3EoJqeJ8++ed6fqXvVrMVm5VgsnEPnb9
         IptQ==
X-Gm-Message-State: APjAAAUIuk+exxXO57zU7nDyfWt5BbScbAD1rqKSFgmDVqawZt6If/ic
        ZgKQGX3zGrrm3JNS3wfT+fACY+3Cs4ZxxDPrsvcr4NF+
X-Google-Smtp-Source: APXvYqxIoEIDwfvkxpMdGio8ke2ggU+248PBo17oxkcekp9Jh19i9fivoOTbKFpGcEN/JmgUTQxHXLc04PftNJV8IWw=
X-Received: by 2002:a1f:17cd:: with SMTP id 196mr2527671vkx.83.1556659545015;
 Tue, 30 Apr 2019 14:25:45 -0700 (PDT)
MIME-Version: 1.0
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Tue, 30 Apr 2019 17:25:33 -0400
Message-ID: <CAN-5tyG+ueNJapc-JGRsi=Tr5rKY6QxrHrouWgVo=6j8p5BeAA@mail.gmail.com>
Subject: question about pnfs logic
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Trond,

I'm trying to figure existing code in order to fix a problem. Can you
please help?

Say there was an IO to the DS and it timeouts. Pnfs code in the
filelayout_async_handle_error() marks the device unavailable and marks
the layout to be returned. Timed out IO is retried against the MDS.
The new IO tries to do the pnfs and because the device is marked
unavailable (returning EINVAL) it propagates back all the way to the
pg_init setup and fails the IO with EINVAL. But IO shouldn't fail.

My question is why are we returning the status of the
filelayout_check_deviceid(), I propose that instead we at that point
set lseg=NULL and then the IO would be redirected to the MDS.

Or maybe I'm missing something else?

My proposed fix would be:
diff --git a/fs/nfs/filelayout/filelayout.c b/fs/nfs/filelayout/filelayout.c
index 61f46facb39c..b3e8ba3bd654 100644
--- a/fs/nfs/filelayout/filelayout.c
+++ b/fs/nfs/filelayout/filelayout.c
@@ -904,7 +904,7 @@ fl_pnfs_update_layout(struct inode *ino,
        status = filelayout_check_deviceid(lo, fl, gfp_flags);
        if (status) {
                pnfs_put_lseg(lseg);
-               lseg = ERR_PTR(status);
+               lseg = NULL;
        }
 out:
        return lseg;
