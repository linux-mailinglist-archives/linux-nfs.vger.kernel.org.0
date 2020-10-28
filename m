Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8BE629DA74
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Oct 2020 00:23:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390212AbgJ1XXh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 28 Oct 2020 19:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390285AbgJ1XXY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 28 Oct 2020 19:23:24 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60E62C0613CF
        for <linux-nfs@vger.kernel.org>; Wed, 28 Oct 2020 16:23:24 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id s15so1279564ejf.8
        for <linux-nfs@vger.kernel.org>; Wed, 28 Oct 2020 16:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=00o1pI3dfKmHEdJBfQh/3tvt2bF/iiu0WFiZJ6SdfhQ=;
        b=ZHteILoKyNndlTshxri2aLg+tGFsVYRkgxplRT1gkrRETDY6Ii2LcuWxMksBrkIDXj
         kzS+a3mk9Y9rChLfO3amVN3WqtF497KjKrWk1X+poyPfOLRegbjG22oBotnT/c64FrwU
         57a57pZ8u/xdVT1RZwzK0KV89GqBsyhTzlM7iRZ8Yjhpcvj+IrTDP8kAXkVFJkrErBjd
         UHQyFUfRalXc/RENG7h0UHdAI6TpLKAbiiirhYmvI4wuj/zzVBD/8riLJ3bQfkprmBO6
         ecolkLRmJFgPsxke/ADLfTlFk9PsH/dfjwaUgnysPvSWVm5Ig+rpgoA+QpRShE40AK/+
         RjtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=00o1pI3dfKmHEdJBfQh/3tvt2bF/iiu0WFiZJ6SdfhQ=;
        b=XLrLqpcaz09+FXbcJ6zgok6yI/qqLbq702SnJfi8tNz5d6ExoILG8FhXCDzkml4un8
         C8i/KtRYp0Flwk4LsLyjxek3eF+hSeOlsuo43BbnzZcDmcLVz9gtUi1mYj2019u+7P0U
         sQEgtLarK/twbSp9o/V8q+kDsG/j/AR0z1MHa/ATa5wR1FZwPSMRNHOlpM9MOlp/eZJl
         iPevhRolFSoXaS4MhXZGPMlT12OH8yhz/aR68c4UDGx7gmdQvaDtAfm4VaCdObJq70KK
         xg2PoqJ/SRoaciesXKeQjAcojtmBfyUrKwFtvhd1YfoOkqISTY3UqQyOvwiOpnGOwhBX
         fXEA==
X-Gm-Message-State: AOAM531OYlwpIA10So6lGxiIA/apWTzXRRn/Eb03DZSaGnPjzMZlwYzm
        ikeRPsxqOstm0NL1ceO/ezUhvVP39sdbkvDcR/1B0IvlI34=
X-Google-Smtp-Source: ABdhPJyid69in67zCAvUISmjEYltAOvM4I/fgE3hToaY0OOVdeadp+KOT6OSCZ8+TBiV4DyV1ng357lLOJz/qxoRIgk=
X-Received: by 2002:a05:6402:1684:: with SMTP id a4mr6880160edv.319.1603875212263;
 Wed, 28 Oct 2020 01:53:32 -0700 (PDT)
MIME-Version: 1.0
References: <CAGj4m+5rpNqW=XnU2cxGmWiBi47w3XTvn9EGekVPjq74pHfFGA@mail.gmail.com>
 <20201027171240.GA1644@fieldses.org> <5dddc4b5-7777-859e-2730-28afc3067c57@math.utexas.edu>
In-Reply-To: <5dddc4b5-7777-859e-2730-28afc3067c57@math.utexas.edu>
From:   Vasyl Vavrychuk <vvavrychuk@gmail.com>
Date:   Wed, 28 Oct 2020 10:53:20 +0200
Message-ID: <CAGj4m+5j1ZK+=-4w6LpRLsnEPvi=UfpO3r8PruRtcJib9gbYyQ@mail.gmail.com>
Subject: Re: Hard linking symlink does not work
To:     Patrick Goetz <pgoetz@math.utexas.edu>,
        "J. Bruce Fields" <bfields@fieldses.org>
Cc:     linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Thanks for replies about my problem. It is actually a practical one...

I need to compile Yocto BSP which builds only under older
distributions. For convenience I have established a Vagrant virtual
machine which uses NFS to share workspace with the host machine.

Now coming back to hardlinking symlinks.

Yocto build system uses hardlinks to prepare sysroot for packages, and
symlinks are part of that sysroot provided by other packages.

On Tue, Oct 27, 2020 at 10:03 PM Patrick Goetz <pgoetz@math.utexas.edu> wrote:
>
>
>
> On 10/27/20 12:12 PM, J. Bruce Fields wrote:
> > On Fri, Oct 23, 2020 at 01:13:02PM +0300, Vasyl Vavrychuk wrote:
> >> I have found that hard links for regular files works well for me over NFS:
> >>
> >> $ touch bar
> >> $ ln bar tata
> >>
> >> But if I try to make hard link for symlink, then it fails:
> >>
> >> $ ln -s foo bar
> >> $ ln bar tata
> >> ln: failed to create hard link 'tata' => 'bar': Operation not permitted
> >
> > Huh.  I'm not sure I even realized it was possible to hardlink symlinks.
> > Makes sense, I guess.
>
> What's even the use case for hard linking a symlink?  That sounds like
> asking for trouble...
>
>
> >
> > I think my first step debugging this would be to watch wireshark while
> > attempting the "ln", and see what happens.  That should tell us whether
> > it's the client or server that's failing the operation.
> >
> > --b.
> >
> >>
> >> I am using NFSv4 with Vagrant, here is mount entry:
> >>
> >> 172.28.128.1:PATH on /vagrant type nfs4
> >> (rw,relatime,vers=4.0,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,port=0,timeo=600,retrans=2,sec=sys,clientaddr=IP,local_lock=none,addr=IP)
> >>
> >> I have also verified that rpc-statd is running on host.
> >>
> >> Host machine is Ubuntu 18.04 with NFS packages version 1:1.3.4-2.1ubuntu5.3.
> >>
> >> Will appreciate help on this.
> >>
> >> Thanks,
> >> Vasyl
