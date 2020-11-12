Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89FD42AFD0B
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Nov 2020 02:50:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728361AbgKLBcT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 11 Nov 2020 20:32:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728136AbgKLAoi (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 11 Nov 2020 19:44:38 -0500
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EE3BC061A52
        for <linux-nfs@vger.kernel.org>; Wed, 11 Nov 2020 16:42:31 -0800 (PST)
Received: by mail-io1-xd43.google.com with SMTP id s10so4276887ioe.1
        for <linux-nfs@vger.kernel.org>; Wed, 11 Nov 2020 16:42:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=hVMls448WtiCHmEYYiwgm9q9rutrUQBdLNWKWdqqFcU=;
        b=Zi58cWkSVR+SHmfNL35r+95ic21DnWOrCIrUzgP8XqgEbrE8/SsMjAHoNYLanGHwpf
         dh0HZ06DEUcM/BBFwfvqMTRTvMd4sRZ4YvZqqao3Rmm/QbqPSJjAAPR8pxkfAJ/f6FXq
         XMfXVbLuP6z/C4mPfYvUIOlzehmw7vpmWEB7w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=hVMls448WtiCHmEYYiwgm9q9rutrUQBdLNWKWdqqFcU=;
        b=tzRG/7n3KM7b2oEMTbQhYeiPzvCScpnLp+HoBMpGXpfljSOYfkyZ12jTZ8aALtvooQ
         ZrPDx3OAhJ91SwsxM6OEwo7yvbmPNFbWCdnux/neoXXK7LnHNA95FCwr9k+LMlNk2fTE
         5ELuMbikNiKQR1ERmRc/ImIZHYt/tkSXuXe3PqAFe7PVUoRN0o3siVlqg8KyIgZhnRkl
         6rXwC2QiwDhSzVCmcLBNAlIY4LwfCaBdVAkyvLkPdAtIMUwiwCdvmR0d4La8N8kzRfsK
         3BvqRQuEFUkELd7S4phTsV1w/MeXuc+Tgjy88Lxy/+lNVV3pOVsI+spc01GbVRkIgGOz
         nArw==
X-Gm-Message-State: AOAM533iTP9XZe6qEpQBiiTq8HHbH8tlbkzVMmtXgsB/QiaVdClOogug
        JbjL0Cbj/7r1jcgZPPv19Oxymw==
X-Google-Smtp-Source: ABdhPJyu4kzjNlE/3+zoxJPDn7rR6SX7QbtDmZGQHGsO4qttKjaX5ffav4Yal9zr/bH8X3ruhnY0MQ==
X-Received: by 2002:a5e:8206:: with SMTP id l6mr20266636iom.126.1605141750643;
        Wed, 11 Nov 2020 16:42:30 -0800 (PST)
Received: from ircssh-2.c.rugged-nimbus-611.internal (80.60.198.104.bc.googleusercontent.com. [104.198.60.80])
        by smtp.gmail.com with ESMTPSA id z18sm1829584iol.32.2020.11.11.16.42.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Nov 2020 16:42:29 -0800 (PST)
Date:   Thu, 12 Nov 2020 00:42:28 +0000
From:   Sargun Dhillon <sargun@sargun.me>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "smayhew@redhat.com" <smayhew@redhat.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "schumaker.anna@gmail.com" <schumaker.anna@gmail.com>,
        "alban.crequy@gmail.com" <alban.crequy@gmail.com>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "mauricio@kinvolk.io" <mauricio@kinvolk.io>,
        "bfields@fieldses.org" <bfields@fieldses.org>
Subject: Re: [PATCH v4 0/2] NFS: Fix interaction between fs_context and user
 namespaces
Message-ID: <20201112004227.GB351@ircssh-2.c.rugged-nimbus-611.internal>
References: <20201102174737.2740-1-sargun@sargun.me>
 <CAMXgnP5cVoLKTGPOAO+aLEAGLpkjACy1e4iLBKkfp8Gv1U77xA@mail.gmail.com>
 <f6d86006ccd19d4d101097de309eb21bbbf96e43.camel@hammerspace.com>
 <20201111111233.GA21917@ircssh-2.c.rugged-nimbus-611.internal>
 <8feccf45f6575a204da03e796391cc135283eb88.camel@hammerspace.com>
 <20201111185727.GA27945@ircssh-2.c.rugged-nimbus-611.internal>
 <17d0e6c2e30d5b28cc1cb0313822e5ca39a2245c.camel@hammerspace.com>
 <20201112003056.GA351@ircssh-2.c.rugged-nimbus-611.internal>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201112003056.GA351@ircssh-2.c.rugged-nimbus-611.internal>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Nov 12, 2020 at 12:30:56AM +0000, Sargun Dhillon wrote:
> On Wed, Nov 11, 2020 at 08:03:18PM +0000, Trond Myklebust wrote:
> > On Wed, 2020-11-11 at 18:57 +0000, Sargun Dhillon wrote:
> > > On Wed, Nov 11, 2020 at 02:38:11PM +0000, Trond Myklebust wrote:
> > > > On Wed, 2020-11-11 at 11:12 +0000, Sargun Dhillon wrote:
> > > > 
> > > > The current code for setting server->cred was developed
> > > > independently
> > > > of fsopen() (and predates it actually). I'm fine with the change to
> > > > have server->cred be the cred of the user that called fsopen().
> > > > That's
> > > > in line with what we used to do for sys_mount().
> > > > 
> > > Just curious, without FS_USERNS, how were you mounting NFSv4 in an
> > > unprivileged user ns?
> > 
> > The code was originally developed on a 5.1 kernel. So all my testing
> > has been with ordinary sys_mount() calls in a container that had
> > CAP_SYS_ADMIN privileges.
> > 
> > > > However all the other stuff to throw errors when the user namespace
> > > > is
> > > > not init_user_ns introduces massive regressions.
> > > > 
> > > 
> > > I can remove that and respin the patch. How do you feel about that? 
> > > I would 
> > > still like to keep the log lines though because it is a uapi change.
> > > I am 
> > > worried that someone might exercise this path with GSS and allow for
> > > upcalls 
> > > into the main namespaces by accident -- or be confused of why they're
> > > seeing 
> > > upcalls "in a different namespace".
> > > 
> > > Are you okay with picking up ("NFS: NFSv2/NFSv3: Use cred from
> > > fs_context during 
> > > mount") without any changes?
> > 
> > Why do we need the dprintk()s? It seems to me that either they should
> > be reporting something that the user needs to know (in which case they
> > should be real printk()s) or they are telling us something that we
> > should already know. To me they seem to fit more in the latter
> > category.
> > 
> > > 
> > > I can respin ("NFSv4: Refactor NFS to use user namespaces") without:
> > > /*
> > >  * nfs4idmap is not fully isolated by user namespaces. It is
> > > currently
> > >  * only network namespace aware. If upcalls never happen, we do not
> > >  * need to worry as nfs_client instances aren't shared between
> > >  * user namespaces.
> > >  */
> > > if (idmap_userns(server->nfs_client->cl_idmap) != &init_user_ns && 
> > >         !(server->caps & NFS_CAP_UIDGID_NOMAP)) {
> > >         error = -EINVAL;
> > >         errorf(fc, "Mount credentials are from non init user
> > > namespace and ID mapping is enabled. This is not allowed.");
> > >         goto error;
> > > }
> > > 
> > > (and making it so we can call idmap_userns)
> > > 
> > 
> > Yes. That would be acceptable. Again, though, I'd like to see the
> > dprintk()s gone.
> > 
> 
> I can drop the dprintks, but given this is a uapi change, does it make sense to 
> pr_info_once? Especially, because this can have security impact?

Spending 5 minutes thinking about this, I think that best go out in another patch
that I can spin, and we can discuss there.
