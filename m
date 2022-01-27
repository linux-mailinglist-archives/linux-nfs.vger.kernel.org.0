Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EFD649DC40
	for <lists+linux-nfs@lfdr.de>; Thu, 27 Jan 2022 09:10:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237585AbiA0IKU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 27 Jan 2022 03:10:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237670AbiA0IKQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 27 Jan 2022 03:10:16 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B07EC06173B
        for <linux-nfs@vger.kernel.org>; Thu, 27 Jan 2022 00:10:16 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id q22so3100105ljh.7
        for <linux-nfs@vger.kernel.org>; Thu, 27 Jan 2022 00:10:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vastdata.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B+bn2qxyyknjeTuNArY0ewa4CJMwBNaoaMJB3yNgb6Q=;
        b=ORfJV5LtfxfVVuv4iqe9CeBX6g8EyJMn/ZEfOO2mvByAsvFg9syk7kIoBSIHw6z+XI
         UGJhyC3eDbdXEEqsDiu04RZWP2VDqlB54fSPUcIXmfNeP+veLv3DrbbQcm1/Za91dePE
         I6XFj5EjoYKwQLTfqp8cFzX2aLBwvgWOupBgBtKNBW4DkowWeCJacgmm3aIjYBWzypFs
         mW/UCYE6Up6HSQGmXEgLscJQdg7ujNoxvkwRrileWa6+8n/ZTjePuJOUkrs+8EVGtQFC
         hEKjzP2dYuSV9M0yRzQInQtAC/YrLrwBzSlWujOxrWA0PWf2kbKqKFynv1gHQ5pGr3uT
         66Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B+bn2qxyyknjeTuNArY0ewa4CJMwBNaoaMJB3yNgb6Q=;
        b=6L2J6LSeCfrxBy+7ZMgueYnnuOeVNfLM2t2j5nObBcRt82MfT1BGtZ8Hjmt/my2jVI
         cDLysoYW1FaYv7IX6GaxuPVmD88cG4jGR0BvdG62S9pq8TNRzKOHgjZrLdqoH5Tb/hGi
         9TGcvIKRsS3ftph1i1t3Xy74SGTAVwW/hz5HH3JI2CDbA46ZwEC1XH+o+33xRfKU1VFh
         /mSKXwPdQzski++RocgqrBRBURvHO9qpaM+8Qbm2RdE6va8LKXtLT26cCWHIICZJXcvu
         2D3/6Lo/qtRd0NReFdg2g3Bdj98O2yayWFFrttvvrUFwDLuXrthwmb/Cw1uDvM2Vva2F
         glNg==
X-Gm-Message-State: AOAM532ISBvprkTHYOL18FBRLCsto5174+6q1oTzRObw6Px9E9D5596K
        Crk+pbPXzM7wBENZfLQi7eEvHona2dyLSpPHLKiYXg==
X-Google-Smtp-Source: ABdhPJxRyoynfWfcMV9n93HPbPA4ardNZnhT1wdH3vhvSp2GyvPydT6H8ddH0vQLs48v9udBZ9UJHsZ9V2jCqMbMeyQ=
X-Received: by 2002:a2e:7d16:: with SMTP id y22mr2022362ljc.433.1643271014574;
 Thu, 27 Jan 2022 00:10:14 -0800 (PST)
MIME-Version: 1.0
References: <CANkgwes_79iE9MGvzGu_tLjNVZprTjTMNzohADRU6pw4Z3xC_w@mail.gmail.com>
 <20220126141053.GA29832@fieldses.org> <0bc601d812c9$8b52b750$a1f825f0$@mindspring.com>
In-Reply-To: <0bc601d812c9$8b52b750$a1f825f0$@mindspring.com>
From:   Volodymyr Khomenko <volodymyr@vastdata.com>
Date:   Thu, 27 Jan 2022 10:10:03 +0200
Message-ID: <CANkgwev3YoQcQwnJ6vb0sXt8J0OWzQN+n-9=92azJ4dYEPO3oQ@mail.gmail.com>
Subject: Re: [PATCH] pynfs minor: fixed Environment._maketree to use proper
 stateid during file write
To:     Frank Filz <ffilzlnx@mindspring.com>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Yes, I agree with you, accepting zero stateid is very important for the server.
However, our NFS4 server implementation is still in the early stages
of development so we intentionally have left this feature outside for
now.
So our intention is to run pynfs tests for other features we have
already implemented.

And yes, I would propose to make a dedicated test for a special
stateid feature (if it's not done yet).
From the protocol side, all-zeros and all-ones are special values for stateid.

Thanks!
Volodymyr.

On Wed, Jan 26, 2022 at 5:29 PM Frank Filz <ffilzlnx@mindspring.com> wrote:
>
> > On Fri, Jan 21, 2022 at 03:06:57PM +0200, Volodymyr Khomenko wrote:
> > >
> >
> > > From 63c0711f9cd8f8c0aaff7d0116a42b5001bddcd2 Mon Sep 17 00:00:00
> > 2001
> > > From: Volodymyr Khomenko <Khomenko.Volodymyr@gmail.com>
> > > Date: Fri, 21 Jan 2022 14:52:28 +0200
> > > Subject: [PATCH] Minor: fixed Environment._maketree (used by init) to
> > > use  proper stateid during file write
> > >
> > > _maketree is a part of generic init sequence for server41tests so the
> code
> > should be generic.
> > > Using zero stateid (when "other" and "seqid" are both zero, the
> > > stateid is treated as a special anonymous stateid) is a special
> > > use-case of anonymous access so it must not be used during generic
> > initialization.
> >
> > OK, applying, but I'm a little wary.  If a server isn't accepting the zero
> stateid
> > here then I think that's a server bug.
>
> Yea, that makes me nervous about a server bug also. Maybe we should have
> explicit special stateid tests.
>
> It's always tricky because initialization of the tree requires a bunch of
> stuff to work before it's explicitly tested...
>
> Frank
>
> > > Signed-off-by: Volodymyr Khomenko <Khomenko.Volodymyr@gmail.com>
> > > ---
> > >  nfs4.1/server41tests/environment.py | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/nfs4.1/server41tests/environment.py
> > > b/nfs4.1/server41tests/environment.py
> > > index 14b0902..0b7c976 100644
> > > --- a/nfs4.1/server41tests/environment.py
> > > +++ b/nfs4.1/server41tests/environment.py
> > > @@ -198,7 +198,7 @@ class Environment(testmod.Environment):
> > >                  log.warning("could not create /%s" % b'/'.join(path))
> > >          # Make file-object in /tree
> > >          fh, stateid = create_confirm(sess, b'maketree', tree +
> [b'file'])
> > > -        res = write_file(sess, fh, self.filedata)
> > > +        res = write_file(sess, fh, self.filedata, stateid=stateid)
> > >          check(res, msg="Writing data to /%s/file" % b'/'.join(tree))
> > >          res = close_file(sess, fh, stateid)
> > >          check(res)
> > > --
> > > 2.25.1
> > >
>
