Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B10585A9C22
	for <lists+linux-nfs@lfdr.de>; Thu,  1 Sep 2022 17:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233277AbiIAPtp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 1 Sep 2022 11:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233055AbiIAPto (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 1 Sep 2022 11:49:44 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 063FA8C01D
        for <linux-nfs@vger.kernel.org>; Thu,  1 Sep 2022 08:49:41 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id u6so23122470eda.12
        for <linux-nfs@vger.kernel.org>; Thu, 01 Sep 2022 08:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dneg.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=t8FvJLH/E9hK1UQD+iLjPyT+JscE26L4ApCyj2ExwmY=;
        b=vk4hS+p1O4q+FJFpbg8S97wmrLou+Q1ds5BXwA9xMAJSM3TH/B6uWkke46DT/V4RoR
         MIg0J7PaFtLWvmQYLzZpzL971C34DElcBoStTzg28yY4i2a+LnLLK5a6XFet6QQnMnoh
         5Qi9VoVvYMnQy6HXOqlG1MP8La8B+FXbeLuYyfNIm5EzjyYA2L4lQHQrrSEcpraGJYe/
         yDESdMl/DslIAH1ubI1OeKiDeMSVWJm0ylRonCRKuXNw6o2FEB+CDyNhYfVyulUpOx4S
         Z8Uf7GNVpRa8nyqrVE11rrHwysqHx2ZkdrlhDg7aGhJsaAOZ5UZOojPCYbtUggTDP27E
         jRzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=t8FvJLH/E9hK1UQD+iLjPyT+JscE26L4ApCyj2ExwmY=;
        b=wPHM1VEXCn8MSDcO85nOnVjN0D7XA5LH8sEM/iQp/ap0dbXbB8MmuUW+k2mdCHVNXF
         6C2BfuHaSd8tR9+/zLnMcA5s2/9zcYB4etqKU01zRqj3y1x745F/kgsXkuIMSA6EAWX1
         IjMHKAWdU4Gj4CGAa9YZ8JXSA4wm57o1DrRWOLjek+CtlYis0m6OjXuIzZk5HcyXlFef
         bpuntfX/ydBYLAExGJQoTYLINE+im2+BPdDa31IZ2TKBsYF8fYvikhiirKwW1RBhiX9x
         +3LMHi1FjXWaAQVnf7xIMLo07RMRBlNsdYUCyb2C5RH9rJj15raXSSJiOJgQCjgURyTT
         6GmA==
X-Gm-Message-State: ACgBeo2PhrOInHGas7M0dbkE+KuThbwHfu3kjAYgi/3uDe867zauQQlF
        yTOAUzTLWJXdP7tYHGldaqajHb6vDEOy5IW2S1+qeXCbZNVJEg==
X-Google-Smtp-Source: AA6agR5I/otc6wv6atPNcZNoj8Xsd/51hpKHBo470/Tm39OE5A5hmNiCxJtKWAuEK9ueJnn5DmICy96sZKG+N2/wk4U=
X-Received: by 2002:a05:6402:4305:b0:448:5b80:757a with SMTP id
 m5-20020a056402430500b004485b80757amr18921261edc.198.1662047380230; Thu, 01
 Sep 2022 08:49:40 -0700 (PDT)
MIME-Version: 1.0
References: <CAPt2mGOnsA9pcmZQkr2q40d7A+NLj7=xr+dzFh7XwJPdGYW6Hw@mail.gmail.com>
 <a4abb5fcf94d706cc3f47d6b629763d5b1831c21.camel@hammerspace.com>
 <CAPt2mGMOSHssr_J6bcf8A8dnU_oHNf_UuHZsDk1WxVi=TUheWA@mail.gmail.com> <561ef18af88ecda0f7b8abf55c1dfb2b66cf5dea.camel@hammerspace.com>
In-Reply-To: <561ef18af88ecda0f7b8abf55c1dfb2b66cf5dea.camel@hammerspace.com>
From:   Daire Byrne <daire@dneg.com>
Date:   Thu, 1 Sep 2022 16:49:04 +0100
Message-ID: <CAPt2mGNm11o3-b+W66eUUj=bvW-XV9wuiU+_uG+zigFPTQ6TwA@mail.gmail.com>
Subject: Re: directory caching & negative file lookups?
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Yea, got it now. That all makes sense. Thanks!

Apologies for the noise. Now I just have to go and fix a bunch of our
user's code so I can forget about negative lookups again...

Daire

On Thu, 1 Sept 2022 at 16:43, Trond Myklebust <trondmy@hammerspace.com> wrote:
>
> On Thu, 2022-09-01 at 16:27 +0100, Daire Byrne wrote:
> > On Thu, 1 Sept 2022 at 14:55, Trond Myklebust
> > <trondmy@hammerspace.com> wrote:
> > > man 5 nfs
> > >
> > > Look for the section on the 'lookupcache=mode' mount option.
> >
> > So I get that the client caches negative lookups once we've made them
> > (the default lookupcache=all), but what I'm wondering is if we have
> > already cached the entire directory contents before the (negative)
> > lookup, can we not reply that it doesn't exist using that information
> > without having to go across the wire the at all (even the first
> > time)?
> >
> > Or is there no concept of "cached directory contents"? I thought that
> > maybe readdir/readdirplus knew about the "full contents" of a
> > directory?
> >
> > My thinking was that if we did a readdir/readirplus first, we could
> > then do lookups for any random non-existent filename without having
> > to
> > send anything across the wire. Like I said, a newbie question with
> > limited understanding of the actual internals :)
> >
> > Daire
>
> There is no concept of a 'fully cached directory'. The VFS and the
> memory management code are free to kick out any unused cached entries
> from the dcache at any time and for any reason. So the absence of an
> entry is not the same as a negative entry.
>
> Furthermore, certain features like case insensitive filesystems on
> servers makes it hard for the NFS client to know whether or not a
> specific name will or won't match an entry returned by readdir. In
> those circumstances, even if you think you have cached the entire
> directory, you are not guaranteed to know whether the lookup will fail
> or succeed.
>
> --
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
>
>
