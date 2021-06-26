Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F36F3B4F64
	for <lists+linux-nfs@lfdr.de>; Sat, 26 Jun 2021 18:10:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbhFZQMX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 26 Jun 2021 12:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbhFZQMX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 26 Jun 2021 12:12:23 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2B65C061574
        for <linux-nfs@vger.kernel.org>; Sat, 26 Jun 2021 09:09:59 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id bz9so281865qvb.2
        for <linux-nfs@vger.kernel.org>; Sat, 26 Jun 2021 09:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NUe01N2Z93LLqq1GblLTUqwFzed3kvFcYaRQKmyia/4=;
        b=KCX0ctIIo8jkyEd+WVVDzj3+cWx8AqXGwsriGIS9Ilk47Abgh5EW8wp2l5dx0c2t/f
         vJRTGIS9Ed1e3t6Rh9rASOv8DEqz2X/WXVLgVxrlltfOgXiq02qD6L+tiphg6ATXElyQ
         0we8EpWf8ue9zXql0cPhoKoBDlW0Ftj9yGCCe0sSuI+GO+hLRgnkighrw+mMuMSGzfGi
         egUM2rDHHMPCQDZ+ml9+/iZBzWay4aEPCqNGIcYI/0It4wviAb1mBS0SakyvyDvHKEUk
         IGgj2LqmRORw2/1QYMPtackUhdJbtFgpGG3EoL+oHSL/4r4RYstZZ2BnlURl20SJZHCb
         izxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NUe01N2Z93LLqq1GblLTUqwFzed3kvFcYaRQKmyia/4=;
        b=rbkGyw+e78wR8JP3MV5AYTLamtfjLytkzNoYBMy6iM1rf/+qoRjyrIhiFndedWDwv2
         t8MIuBsGTEIVVB5o8pJtyAmTy5phLS7GLHpbvOiqfM/IskxogA56kscdAEEHLR5dqrKy
         qrMky3c05c+Wq2tdgf/4eDYWKxE8q9ojb8uM9XGei6fvIP06D9fZI9I9ycawvmBh+Lw0
         ycKso9OTjI425krsnOs1jXmMm0PgBMKvAkRFjryD7y/tcXLUEQskZutDgC07an69o1Y+
         +u5r3yHvNa3o9dNHl2lNa9ulKBBrGThv5zT3tSzvopkd8peDtWOtYWL8U/Xs/jH7WtbB
         w2rg==
X-Gm-Message-State: AOAM532mZ2VY76mYoXlzbpiLQTaXv31Y+wTc5VG1OAsDC0qZuTbC7rQh
        0EBRiZABTf/De10/7LHzeymP+SfGxuPB
X-Google-Smtp-Source: ABdhPJz5nnzngVkGI9/a9FPMkfWfNYOuZXb/m29112iElp60MyYAFNm6r9QbO8nFrjjh0ocsmCSYWg==
X-Received: by 2002:ad4:57d3:: with SMTP id y19mr17095455qvx.0.1624723798627;
        Sat, 26 Jun 2021 09:09:58 -0700 (PDT)
Received: from leira.hammer.space (c-68-36-133-222.hsd1.mi.comcast.net. [68.36.133.222])
        by smtp.gmail.com with ESMTPSA id s8sm2995141qke.72.2021.06.26.09.09.57
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Jun 2021 09:09:57 -0700 (PDT)
From:   trondmy@gmail.com
X-Google-Original-From: trond.myklebust@hammerspace.com
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 0/2] Embryonic support for case insensitive filesystems
Date:   Sat, 26 Jun 2021 12:09:54 -0400
Message-Id: <20210626160956.323472-1-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

The following patchset adds limited support for case insensitive
filesystems to NFSv4. It adds the ability to detect such filesystems,
and then turns off negative dentry caching. The reason is that we don't
know which filenames in the dentry cache are actually case folded
synonyms, so we need to ensure that we revalidate those negative
dentries even for the case where our client created the file or
directory.

Trond Myklebust (2):
  NFSv4: Add some support for case insensitive filesystems
  NFSv4: Just don't cache negative dentries on case insensitive servers

 fs/nfs/dir.c              |  3 +++
 fs/nfs/nfs4proc.c         |  8 +++++++-
 fs/nfs/nfs4xdr.c          | 40 +++++++++++++++++++++++++++++++++++++++
 include/linux/nfs_fs_sb.h |  2 ++
 include/linux/nfs_xdr.h   |  2 ++
 5 files changed, 54 insertions(+), 1 deletion(-)

-- 
2.31.1

