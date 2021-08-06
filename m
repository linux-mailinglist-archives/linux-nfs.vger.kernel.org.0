Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C172D3E2AA2
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Aug 2021 14:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343685AbhHFMdY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 6 Aug 2021 08:33:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26858 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1343684AbhHFMdX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 6 Aug 2021 08:33:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628253187;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iyKrp7I82f3wYzsbQR/1Jeu1cFgJoa6hSbBVeuarAhw=;
        b=aBKKqab/FHf+b/WXRp92MTLHUic1RlV8xvM9u7Jg0hgGJ9qJw+kzG6+T3MrzILcOyoBHl9
        0olwyvvNqX3XG7utH7oJyFFoFkSfKpbt+uBbnKcPmw7nmrpk1xtZ8HZ/jNhuch502hiHsO
        zdSn2NDPuD4IUI0WEtVSlOcQpE8yj40=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-58-kn_afhZmN3SYpT9HDqOCXw-1; Fri, 06 Aug 2021 08:33:06 -0400
X-MC-Unique: kn_afhZmN3SYpT9HDqOCXw-1
Received: by mail-wr1-f72.google.com with SMTP id z10-20020adfdf8a0000b02901536d17cd63so3107340wrl.21
        for <linux-nfs@vger.kernel.org>; Fri, 06 Aug 2021 05:33:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iyKrp7I82f3wYzsbQR/1Jeu1cFgJoa6hSbBVeuarAhw=;
        b=KPj8pTLuEhcEygcNV9lr9JsYC5KPmxcrQo7KiSqjwGaysXI6aCsRRtDdMiq6GybfOj
         bifQrCChJSTi3caOGaSEn1NDoW2vzritt3g+XlxksjXMwKuqe7VrUoD4ocF2zHS1p1lb
         A07PTohkQ1q3cN23q1ozCl2FnfIZzWMbit2eHiwxSJopIaFNpDehXL7YfbwO6W9ZTZEN
         c0S+uH+lfq8J8Tf4LHO6kDuXv0WGc+eBXGekLEcPRCwYqeRz/Z6XbuPLYFpF42fmQhD/
         DZfMlIyIU3zm5pCBekgoAPsm3Kh/Y0bGviZ8CQ70v2HEnkZCn9pvnXVxjVflJRYrFSap
         wUug==
X-Gm-Message-State: AOAM532NR4j4Pz/aAVyWBwDRfNHoqbF50jKsGC3DnWyKx6wgOT8GlNou
        nILRzFFcvzZqRFA2aTQbywyNlNFcMdBsuqGUuDPL+CVWoAMIY6GePGaucM8mQG0ohhd6OtzR0xj
        WHGB6CYWWssHvjRD8rra0ZVImlayYJ+kDKTLaGhZFB8Ws1UlUhpF7igf9B5YQStUy04CtQzyQQX
        Y=
X-Received: by 2002:a1c:9814:: with SMTP id a20mr3027509wme.158.1628253185465;
        Fri, 06 Aug 2021 05:33:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzmMg9VqmJ2JHoSFT9sB6HwJMTD0NkQF9vURb8zxMUJzxL/IY22NKxh1atSYpC7rctiUr3N6g==
X-Received: by 2002:a1c:9814:: with SMTP id a20mr3027488wme.158.1628253185241;
        Fri, 06 Aug 2021 05:33:05 -0700 (PDT)
Received: from ajmitchell.remote.csb ([95.145.245.173])
        by smtp.gmail.com with ESMTPSA id b14sm9881355wrm.43.2021.08.06.05.33.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Aug 2021 05:33:05 -0700 (PDT)
Message-ID: <3209bf6bdf0a167a19cd56be5c57abfcc761850b.camel@redhat.com>
Subject: [PATCH 3/4] nfs-utils: Fix mem leaks in krb5_util
From:   Alice Mitchell <ajmitchell@redhat.com>
To:     linux-nfs@vger.kernel.org
Cc:     Steve Dickson <steved@redhat.com>
Date:   Fri, 06 Aug 2021 13:33:04 +0100
In-Reply-To: <ee45aa412acaf7a2c035ad98e966394a7293dd9f.camel@redhat.com>
References: <ee45aa412acaf7a2c035ad98e966394a7293dd9f.camel@redhat.com>
Content-Type: text/plain
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

DQo=


