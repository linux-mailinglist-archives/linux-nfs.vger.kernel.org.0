Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A32CF415237
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Sep 2021 22:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238049AbhIVU6d (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 22 Sep 2021 16:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237744AbhIVU6W (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 22 Sep 2021 16:58:22 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ABC1C06175F
        for <linux-nfs@vger.kernel.org>; Wed, 22 Sep 2021 13:56:35 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id a15so5270358iot.2
        for <linux-nfs@vger.kernel.org>; Wed, 22 Sep 2021 13:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=srf-ext-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=p2+bnwDe8NnQejQwDcKsqilbxGCbNYLi3v9x+JtVwzo=;
        b=MbKcG4/R5RX+6CXXG7OGSqx4WMKFaCW3VHwfd6ccQy3jTkrUDbgzOLGW+mDovBaZdn
         IxECEXTuSH98xiuYJgyakW2zIxmSuVog6M1JbWmAndSbs5mSzaEWQWKkZej/hIU646Nt
         yQkbD5KZTo4zD0kIa/fMw9JUkLuic/HK6tnmIKjgcC9SArQ03vfTSHIj9ZOVk3iZXzm+
         8Ckv23Rbug3bf1mNoqM1UdcHZBgQghy8cYcSyqsvwNuyhgniwMm4kCx2+P3WRGVEHFfB
         bmV3G8KbtrRTh+WDefO4cBHAjD0zyuLp7RFKhjq4NeLMwyCRXG6XzavfxlblhkXJMBgX
         AzkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=p2+bnwDe8NnQejQwDcKsqilbxGCbNYLi3v9x+JtVwzo=;
        b=Of+dZTTR21PCkOew2UXI8BhrwQV7bcZZqobBY7eJ4KUrkrYZBZgkcHPgfznCM1edac
         7WiWNMaoC+9kHaKQjLgN4N3wZhho/SxMLI1xyKBUkWsFtTNee8nr4xr31oX9TkfcvUQL
         Qi+Dgsp0cCWXG3Wng69+5dxaJL/02VISWL1MqU0Cb/N+/bS8fv288Bu0uodBG977suXb
         2oEkgSBgipidmnBJXgR5y9JByTlhj39FroogX8iIZvjGEx3Q+Okvv0JAEz/6UyXuVNfT
         ab8TdV4IkGo9WOOhPuMJfKA6r8xnXDHkA1wiI8haoclnjbios1LVzWqn2VAewygMx8cw
         Y0+Q==
X-Gm-Message-State: AOAM531vIa229hdpQXHCLp4Vq0qzNAkhITXRr4fo4PGIPgqkSdI+iDXK
        HImaN90t4p5+2GZeIUr9uDECt/iOKQVxnkHBlaK6ECReTgG+9g==
X-Google-Smtp-Source: ABdhPJzhQUonEgw+v17s2Wja/goJ1+PI82+eASjeRJPEHWtc+iqhL3EbHYjF5CgRJxtG2yngTrFlsSl8jVlD4zbO/Bo=
X-Received: by 2002:a5e:c110:: with SMTP id v16mr857064iol.43.1632344194597;
 Wed, 22 Sep 2021 13:56:34 -0700 (PDT)
MIME-Version: 1.0
From:   Kazi Anwar <kazia@srf-ext.com>
Date:   Wed, 22 Sep 2021 15:56:23 -0500
Message-ID: <CAGw7ksJxiKkOf2F9FUDCa_mSAkoU6U=vCXFcupsu+izKuEE1WA@mail.gmail.com>
Subject: nfs4err_delay
To:     linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi,
We are running nfs v 4.1 on centos 7.6.
We are seeing an NFS issue where when files/dirs are deleted from a
client they are occasionally stuck at unlinkat system call(according
to strace its stuck for 100.5 secs every time). Can anyone explain
this behavior?
Running tcp dump shows nfs4err_delay status sent from the server to
the stuck client.

--
Kazi Anwar
