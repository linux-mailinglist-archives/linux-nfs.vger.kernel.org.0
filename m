Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 281533200FD
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Feb 2021 22:57:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbhBSV4y (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 19 Feb 2021 16:56:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbhBSV4i (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 19 Feb 2021 16:56:38 -0500
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11E26C061574;
        Fri, 19 Feb 2021 13:56:13 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id dg2so1213445qvb.12;
        Fri, 19 Feb 2021 13:56:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/kAaj2fbex8MjFjSBtp8cDY0E9z10TFEo1e5YFhbJNI=;
        b=C2EWjFWjCNfVw/NoIV4dCcPC36RUwTqMnkItllRXstEgzg71zYXYNmlmqENWt3E8cK
         0aykDxTXJ38Q9RcEkIV1XXOdl6RfwHr4us+uykLD8AFFVtn+JrU7ONufj3kYMpNEGONh
         vDlfqS9VWh8KSyQv6vX/yuTCz3ZaCUAJLTLcBMDLodVAetigynXAT2QrQwo4QfeWYc3I
         PBNZT3Bbjgv4gY1c1hyO0aGbawTEQa3+CNLpOAUsKYqewxl4/V8H2JrZrVqycPzeqfn+
         5hs+q88anhZ9/ho9Zrb7UW3ZzeOYgW8v7wyJIURDQOuipNHpfsRJI8nDhg9CW1vdVyOW
         3rHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=/kAaj2fbex8MjFjSBtp8cDY0E9z10TFEo1e5YFhbJNI=;
        b=U6+5FY1PGNuIUHYyF8PoryFtM/Hy4U2VDn29QNUI60H+ixh5d6yIFwLElLNxsTJS88
         i/oCVh8iWgRikw6KutlGC5cbyDbL3lIqxywvBvujfuToNGj26BueXTNqLtkWMgmKTjsC
         /9pHUBLwd9Yl+AlJf8esUCdLqw//Vfx9mV4b9L3JbIXQz3hGnoLcyv2xHOZacNmBz6au
         mQIxZHi1GYn5Nk8oFbacrIIJFp28mUlgnpG9U+mKFxdFlKakjG6zlRFHdJQM2/IghFtA
         5MsZIjbWf5jbOxivg7sy3gyJ8OE4KLmQEuz9qUOCoR1re/f5o8N+yrQihA/7opAHAxtR
         JRnQ==
X-Gm-Message-State: AOAM533yHOQGAYkJY0aPB2kkGqcebkWndQ1TV8HszxamoK7qD0XxrBF8
        11jWIbqTNP8PLUt4d05qhKClDiemQq8F8A==
X-Google-Smtp-Source: ABdhPJxXdHIJNZiXVqgd3fOtZL7u7xnLhZpSXX3mMalKstjbwGVcNPfEuPHfkirbF/vWDncGzDoVNA==
X-Received: by 2002:a05:6214:f6d:: with SMTP id iy13mr11503721qvb.24.1613771772228;
        Fri, 19 Feb 2021 13:56:12 -0800 (PST)
Received: from ubuntu-mate-laptop.localnet ([208.64.158.253])
        by smtp.gmail.com with ESMTPSA id b82sm7317694qkc.34.2021.02.19.13.56.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Feb 2021 13:56:11 -0800 (PST)
Sender: Julian Braha <julian.braha@gmail.com>
From:   Julian Braha <julianbraha@gmail.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fs: nfsd: fix kconfig dependency warning for NFSD_V4
Date:   Fri, 19 Feb 2021 16:56:10 -0500
Message-ID: <4276512.Scm06nC1gK@ubuntu-mate-laptop>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

When NFSD_V4 is enabled and CRYPTO is disabled,
Kbuild gives the following warning:

WARNING: unmet direct dependencies detected for CRYPTO_SHA256
  Depends on [n]: CRYPTO [=n]
  Selected by [y]:
  - NFSD_V4 [=y] && NETWORK_FILESYSTEMS [=y] && NFSD [=y] && PROC_FS [=y]

WARNING: unmet direct dependencies detected for CRYPTO_MD5
  Depends on [n]: CRYPTO [=n]
  Selected by [y]:
  - NFSD_V4 [=y] && NETWORK_FILESYSTEMS [=y] && NFSD [=y] && PROC_FS [=y]

This is because NFSD_V4 selects CRYPTO_MD5 and CRYPTO_SHA256,
without depending on or selecting CRYPTO, despite those config options
being subordinate to CRYPTO.

Signed-off-by: Julian Braha <julianbraha@gmail.com>
--- a/fs/nfsd/Kconfig 2021-02-09 22:05:29.462030761 -0500
+++ b/fs/nfsd/Kconfig 2021-02-11 12:00:48.974076992 -0500
@@ -73,6 +73,7 @@
   select NFSD_V3
   select FS_POSIX_ACL
   select SUNRPC_GSS
+ select CRYPTO
   select CRYPTO_MD5
   select CRYPTO_SHA256
   select GRACE_PERIOD


