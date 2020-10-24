Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDD0F297A2B
	for <lists+linux-nfs@lfdr.de>; Sat, 24 Oct 2020 03:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758426AbgJXB3i (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 23 Oct 2020 21:29:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:36439 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1758422AbgJXB3g (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 23 Oct 2020 21:29:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603502989;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ogycSequd4RWbLt37l5/NyaOWw9tEvhtrAKSAsPiEMw=;
        b=NK4hm2iNyGekxqzmTIpiMbx1UtghfIgVJ/gENY7Yz2J04qD0xFOnsOnUn9dQmK2A5PLPKG
        OIWYuvfbvtfZ3jTQ8AEsyOKhK0czVfFE2W1LR9ws0JK17X1CxKDVt52ceSoSksNXaYJmuj
        KIhrRzD84YATytBJz2RrAK0TLIejhBU=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-54-Urs5qayDMFC1VC4u0Fpwug-1; Fri, 23 Oct 2020 21:29:43 -0400
X-MC-Unique: Urs5qayDMFC1VC4u0Fpwug-1
Received: by mail-il1-f198.google.com with SMTP id w12so2985663ilj.7
        for <linux-nfs@vger.kernel.org>; Fri, 23 Oct 2020 18:29:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ogycSequd4RWbLt37l5/NyaOWw9tEvhtrAKSAsPiEMw=;
        b=a1eOoYNEDSIt1dReOoeAfaEaxcZrcdS+eRqQKXkZ178OO/Cc9hJLsIP+qHoapp6jST
         jc0thzHHvNlsOCmOdgcN+XQMwhlfQ8QJ/sR8Bog0vy4dmFkbwd9SnU2GBXcGUPFyMTnv
         CXqqnv6JwxjyEL+uMJHs2NgMI1yc/zr4vYhZwm2VFgLY00rkw+JFE9ygmKKkmvtgg0XD
         Tj2wTeKMkLcY96ax6g18EuKHNS6UQx2+kVOBHcDO/N9aA/6Ez4HOUYBim5p1yiLaMKtp
         eAYm9Zo8bDsE1cIVKCIUaKuYNsID3h7tdKZz6gjh1xt/jazAeBvksWp13RiXCIjMfeTv
         OjTg==
X-Gm-Message-State: AOAM530P4kTx71y/Q1IzrJ5JnNnpABcTOSVD8OFnEhqdnsFHntsl1+pV
        tWwlPDvLvZ3wzXXLLtPgVJnzhKESzfRVq7R3FB/LfXHzGUtan67St5cDe3II5lJYFb4pmqY2sc+
        6FxCIcnhbRf59sC/FkJ2VAdLzmxKK5OwN9QlC
X-Received: by 2002:a6b:b2d3:: with SMTP id b202mr3802844iof.160.1603502976602;
        Fri, 23 Oct 2020 18:29:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxL9cgjj9msggBKdld+zc3mavGBv95bE1zEnc9UIG56vqccc9hNyG8nL/Sg+QJaV3dufZIxfd4ReLL9I0jiepM=
X-Received: by 2002:a6b:b2d3:: with SMTP id b202mr3802831iof.160.1603502976385;
 Fri, 23 Oct 2020 18:29:36 -0700 (PDT)
MIME-Version: 1.0
References: <20201019093356.7395-1-rbergant@redhat.com> <20201019132000.GA32403@fieldses.org>
 <alpine.DEB.2.21.2010231141460.29805@ramsan.of.borg> <20201024000434.GA31481@fieldses.org>
In-Reply-To: <20201024000434.GA31481@fieldses.org>
From:   Roberto Bergantinos Corpas <rbergant@redhat.com>
Date:   Sat, 24 Oct 2020 03:29:25 +0200
Message-ID: <CACWnjLw_EJBnz9ywkg=-7HVScJT1gKRmYRda1MWUrPYTWkHXzw@mail.gmail.com>
Subject: Re: [PATCH] sunrpc: raise kernel RPC channel buffer size
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-nfs@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Good point Geert !

> How about making it a kvmalloc?

I can post a new patch using kvmalloc, Bruce looks we can also
prescind of queue_io_mutex, what do you think ?

>
> --b.
>

