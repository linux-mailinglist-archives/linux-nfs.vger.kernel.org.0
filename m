Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24D5F3E2A81
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Aug 2021 14:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343626AbhHFM1X (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 6 Aug 2021 08:27:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36737 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243739AbhHFM1W (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 6 Aug 2021 08:27:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628252826;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=qvwVJlh4ZViaD8ZQdZR3E+uWZGjkXMTLA/OAcGiTvY0=;
        b=YY5/Z9634i4NQy4yCiUXJtTtcGh9sVpkOa1p7nEzdXthVqk6ceEm2m4mohfZura1Yt/ZUs
        7tKuZyCzwUFhfTG9QrP4tj38mA8IxrfTEPUgBOrCSa8okkx/9un3XrrYrEcHIhNNZ1QwWp
        cULjHnTMwER0jPZ+pTco9hYEJDguyhw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-603-H266kHiNPwywjpII05Hifg-1; Fri, 06 Aug 2021 08:27:04 -0400
X-MC-Unique: H266kHiNPwywjpII05Hifg-1
Received: by mail-wm1-f70.google.com with SMTP id 132-20020a1c018a0000b029025005348905so2394455wmb.7
        for <linux-nfs@vger.kernel.org>; Fri, 06 Aug 2021 05:27:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:mime-version
         :content-transfer-encoding;
        bh=qvwVJlh4ZViaD8ZQdZR3E+uWZGjkXMTLA/OAcGiTvY0=;
        b=R+SXl8khSHpNOOOEyCQrVV7eIfPo67GZqmVtEcl+WxhmvHeK/At3rscBZX2FbhZIGA
         7G8wYiQXSPPlUjSmPo+1FveZjPZvu6+Cfh1p5SPk9HY2lhYC/wbmRmWAzYzm0e1uIA6V
         nS9dLvzsbYkLaUMe8JshToViYxTbVRS4WJrYNaMt+aqM7E3qF19bxYEp83SpU/Pzw1N2
         8hIQpGMpuAMejo7B5qfvdYjiBqBaJzpCqAf3y/AUHT8Jx+GHWeh3LxmfeiewxKiYjFd2
         1doOpIDyvzDUxl46vB+7Bhlrapu9AXz4hz69EqqdnZnrEln/AZkiQM9lKQpDI6qxUmdN
         jqOQ==
X-Gm-Message-State: AOAM533ejsDNRh0eQU7QLhH/4roX01OI+lXudPCvcE6vsX7gL7VfEcUu
        P4ic/1698PDuRrK2KENlQ2ibYHeiaGZSJ+NCaX32eM2iauYkZwacPOlTzaHa+oJ0eTb9AwSQQBW
        9+0j3uoEHJEv01KKYUc2zNFwQuVYhSwIkLUyrHI7hspKV7gQ1yjQ+WTK4F1DB5ahCmovyYtFtk9
        M=
X-Received: by 2002:a05:600c:2159:: with SMTP id v25mr20483657wml.187.1628252823776;
        Fri, 06 Aug 2021 05:27:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyw3x36iClc9JAB4ZtXSNN4vuFayfH2vWtVZeHOxFRDmbbEcV9zsTonhBzKajQxQSkR+hvoYQ==
X-Received: by 2002:a05:600c:2159:: with SMTP id v25mr20483642wml.187.1628252823553;
        Fri, 06 Aug 2021 05:27:03 -0700 (PDT)
Received: from ajmitchell.remote.csb ([95.145.245.173])
        by smtp.gmail.com with ESMTPSA id j2sm9615691wrd.14.2021.08.06.05.27.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Aug 2021 05:27:03 -0700 (PDT)
Message-ID: <ee45aa412acaf7a2c035ad98e966394a7293dd9f.camel@redhat.com>
Subject: [PATCH 0/4] nfs-utils: A series of memory fixes
From:   Alice Mitchell <ajmitchell@redhat.com>
To:     linux-nfs@vger.kernel.org
Cc:     Steve Dickson <steved@redhat.com>
Date:   Fri, 06 Aug 2021 13:27:02 +0100
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This series of patches fix a number of potential memory leaks
and memory errors within nfs-utils that mostly happen under
various error conditions.

Signed-off-by: Alice Mitchell <ajmitchell@redhat.com>

Alice Mitchell (4):
  nfs-utils: Fix potential memory leaks in idmap
  nfs-utils: Fix mem leaks in gssd
  nfs-utils: Fix mem leaks in krb5_util
  nfs-utils: Fix mem leak in mountd

 support/nfsidmap/nss.c   |  4 ++--
 support/nfsidmap/regex.c |  1 +
 utils/gssd/gssd.c        | 10 +++++-----
 utils/gssd/krb5_util.c   | 18 ++++++++++++++++--
 utils/mountd/rmtab.c     |  3 +++
 5 files changed, 27 insertions(+), 9 deletions(-)

-- 
2.27.0


