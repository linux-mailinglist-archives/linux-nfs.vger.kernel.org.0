Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58B8B5AF440
	for <lists+linux-nfs@lfdr.de>; Tue,  6 Sep 2022 21:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbiIFTMp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 6 Sep 2022 15:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiIFTMo (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 6 Sep 2022 15:12:44 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BA307A762
        for <linux-nfs@vger.kernel.org>; Tue,  6 Sep 2022 12:12:43 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id bj12so25405840ejb.13
        for <linux-nfs@vger.kernel.org>; Tue, 06 Sep 2022 12:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=CZEQVH/xXYLBlgEbfKD8ayPCXVmWyg7S7QfF4SWSUnE=;
        b=OoAlpTdZLllwYd6wVWcyvumltqExICGh/hig6omgObW+VM9R4H7RUOwV9dwqt/QLbZ
         kLTcQqcvI+jX2Qp7RBEFd6P9Hjc1bTB4UtaTihIlHcEUxHMJndRbI1T8bFsFi2CVCv5S
         cbqGbDHlOFid320Du3vKCdORWCfdAo2V0K0TSLZQPQvtsWADi0ie6fnTquK+WUHxYKBd
         szTu6RiPmu5cdC/C+2NtquuSLB5eJLvmjE8pVp1JchnSP++VsdpghCpg5v/Iqo2O/3Cr
         pa6XGwyVLbP5UveGeC2oUCIDYt9eA1Pnq+8Wag5PGdwVT15YlJMXV5kf//rUE/gJ3Ljx
         xTtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=CZEQVH/xXYLBlgEbfKD8ayPCXVmWyg7S7QfF4SWSUnE=;
        b=QhA7zlbRAww/tzZ4dlzb973+7B0IeluczJrOSGjMh0ppzS1oRflDWNNHpgW4xco1G6
         6mZHU4K3+H9IExB7aRQ60oLWfgeMtV3D6NTMPD3mwqYZR2prCdq8VbYr2GEUPT00YRHB
         4m71Ca/1a1Jx9yl/+/HZ5C9JimGkvM6BDsiRN1LN4Qpy3+/GOeWKiLG/bp8NJeOk9e8r
         ldJ3xfhYZxZm8KUkIJlTg8wVkG+ciT6Q3Nsd5+N4911GfSNrOEs+PTO7U2e0l9E/oH+3
         wilrezsANTgSWE40+LphgjN6CWgprzYLg0AiGWhxkR2R/m6PwTY3ZwKuCMV/0wiavTQu
         fFNw==
X-Gm-Message-State: ACgBeo1BVlJ514lYVBuc3lKfEmzJe4nz1g+W9/g0gWqmRu8ByHYfY9PC
        tez7PXLg4crbzSeaA9eE9wrFlihaC63SwTQZXnY=
X-Google-Smtp-Source: AA6agR4ImEwqekJhMNXxZozwWbOyv8LlbNtWagIv4LigzyRpsvYNc2yTOMlv1+O5DSpu1bvFbNcLJt4aaGHNskOvXBg=
X-Received: by 2002:a17:907:d2a:b0:741:4f42:df74 with SMTP id
 gn42-20020a1709070d2a00b007414f42df74mr31622770ejc.535.1662491561860; Tue, 06
 Sep 2022 12:12:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAN-5tyGkHd+wEHC5NwQGRuQsJie+aPu0RkWNrp_wFo4e+JcQgA@mail.gmail.com>
 <5c423fdf25e6cedb2dcdbb9c8665d6a9ab4ad4b1.camel@kernel.org>
 <CAN-5tyEOTVDhR6FgP7nPVon76qhKkexaWB8AJ_iBVTp6iYOk1g@mail.gmail.com>
 <11BEA7FE-4CBC-4E5C-9B68-A0310CF1F3BE@oracle.com> <CAN-5tyHOugPeTsu+gBJ1tkqawyQDkfHXrO=vQ6vZTTzWJWTqGA@mail.gmail.com>
 <D0A6E504-F2C2-4A5F-BC51-FD3D88A790F0@redhat.com>
In-Reply-To: <D0A6E504-F2C2-4A5F-BC51-FD3D88A790F0@redhat.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Tue, 6 Sep 2022 15:12:30 -0400
Message-ID: <CAN-5tyHYH7ODzmTK=Maa3NZOSxfcE0mfaWY11+n2htQpya869g@mail.gmail.com>
Subject: Re: Is this nfsd kernel oops known?
To:     Benjamin Coddington <bcodding@redhat.com>
Cc:     Chuck Lever III <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Sep 6, 2022 at 2:28 PM Benjamin Coddington <bcodding@redhat.com> wrote:
>
> On 1 Sep 2022, at 21:27, Olga Kornievskaia wrote:
>
> > Thanks Chuck. I first, based on a hunch, narrowed down that it's
> > coming from Al Viro's merge commit. Then I git bisected his 32patches
> > to the following commit f0f6b614f83dbae99d283b7b12ab5dd2e04df979
>
> No crash for me after reverting f0f6b614f83dbae99d283b7b12ab5dd2e04df979.

I second that. No crash after a revert here.

>
> Ben
>
