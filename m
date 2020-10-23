Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F1AA296C90
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Oct 2020 12:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S461989AbgJWKNQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 23 Oct 2020 06:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S461988AbgJWKNP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 23 Oct 2020 06:13:15 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EC36C0613CE
        for <linux-nfs@vger.kernel.org>; Fri, 23 Oct 2020 03:13:15 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id o26so1597354ejc.8
        for <linux-nfs@vger.kernel.org>; Fri, 23 Oct 2020 03:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=0tlIytENbNd3G7krIV219gExAgj570mX+2GR9JVhMy4=;
        b=BLYte7WTtTVSfrQBsVCN7i/ni5+WpUWrJC//LHiNj1P/v9F0ki8W+ideu9qdybHx0U
         1QsT9GMBur31nnK6J6tK7S6w1TVPKHUQNbu9Eb49W5LnZ5xvgxw51mGVfrGzKGIMbBtn
         Rhqpm6e63zg+NYjLd2VuEF2ZJnBdcebQSguGRt3esFYExoC28Sd1K4oEM+piC+0nzmMq
         fVCuDApuGILFISICm7M3oS2gf0WKRCIthI49uAkT+F09rnALyASXT6BsCTWEwil9VteI
         xUI/gdFlY+5Jp13XyNFfL79ayfNxunFebfE6W/uWO7aNw4AUI3xK1V5070Chz0MDByny
         kmow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=0tlIytENbNd3G7krIV219gExAgj570mX+2GR9JVhMy4=;
        b=lOspYnJHDAlbA8t2fcGQyYSjc5KjP7lPQDg+Ei1xDKQBt0e/jVUoH3VImHpYPaEyWD
         98hliJhkU4zUR5Z7QiaxQkg+kRtJ3p1Em+unXK3RYf8Zu/X59C5jTTu0UeglJojkvqAu
         B2HIGY6cUPAyiQJXf7o/Ev1N1L8tMEMSvn8mOvw/kbu/m0Lae0/e+263HUNv++eZCTty
         l+DhYoIerzRVVi4KOl11i2XbGG0K51TlryL6Lb6X05FYRbFhQhc+Cz9q449HEK5srFYi
         Y2MGbPjCmnU4kPBnwm5TFos76gHmUGApRz6CkN7k4gTFGeEJ1oDxY1FzYhI4VrGvUguX
         hWSw==
X-Gm-Message-State: AOAM533laE22HnE0btC3IaujZS/gEwFZgMfvjlKNSO9kz5gofqNNXXHg
        8IHdPOuQuXTEClFJsjCK7jXtSCtL11LEAzI6EcA4uo01orOzdg==
X-Google-Smtp-Source: ABdhPJxDi5SLlVdO4RfWv1ujB4Q+k5Xc0z9U/2r4DSL3whwV7mlse4k264mx2PMr7NLAdQDj96r6VpY5lcAkS/Xr0sg=
X-Received: by 2002:a17:906:1246:: with SMTP id u6mr1186202eja.432.1603447993399;
 Fri, 23 Oct 2020 03:13:13 -0700 (PDT)
MIME-Version: 1.0
From:   Vasyl Vavrychuk <vvavrychuk@gmail.com>
Date:   Fri, 23 Oct 2020 13:13:02 +0300
Message-ID: <CAGj4m+5rpNqW=XnU2cxGmWiBi47w3XTvn9EGekVPjq74pHfFGA@mail.gmail.com>
Subject: Hard linking symlink does not work
To:     linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi,

I have found that hard links for regular files works well for me over NFS:

$ touch bar
$ ln bar tata

But if I try to make hard link for symlink, then it fails:

$ ln -s foo bar
$ ln bar tata
ln: failed to create hard link 'tata' => 'bar': Operation not permitted

I am using NFSv4 with Vagrant, here is mount entry:

172.28.128.1:PATH on /vagrant type nfs4
(rw,relatime,vers=4.0,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,port=0,timeo=600,retrans=2,sec=sys,clientaddr=IP,local_lock=none,addr=IP)

I have also verified that rpc-statd is running on host.

Host machine is Ubuntu 18.04 with NFS packages version 1:1.3.4-2.1ubuntu5.3.

Will appreciate help on this.

Thanks,
Vasyl
