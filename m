Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12702A230E
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Aug 2019 20:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727736AbfH2SNC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 29 Aug 2019 14:13:02 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:37740 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726661AbfH2SNC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 29 Aug 2019 14:13:02 -0400
Received: by mail-io1-f66.google.com with SMTP id q12so8809536iog.4
        for <linux-nfs@vger.kernel.org>; Thu, 29 Aug 2019 11:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zadara-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DvUVCWweJqz9GgGV84lI5+GoH0RrjDa34Uh97IPVVnE=;
        b=bI/d/9LBVY6fUonD4Dh59gpB0n56Y13vWsT8iXw+nFZUPOJHqcYyuIMzVlLNvEEsH1
         xzKSK1sBVYCq0UeD/YbqjwyE4NEZKGTKb0qhEfoGpGfD4dHJt7T0AuBbNe7wjhQCRp53
         /V4RinlgksmH9czC4bHp5ddh6EJE1ULHXS89556koXIG0d44gT2egOEh0P6aQSAHx+Bf
         eAV7nO18PrWsbL+YRklWyOnSVKENf80dPy/Qy6869YJB5SyLMaZJYwRAGO/lTEgltbOg
         uJRYZRiN9CBS8SK5uqbXdhR5QKggiC3hJ5G+QwPHoYVEEt6B9PsisHwRpA3jj0yp2/77
         J9zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DvUVCWweJqz9GgGV84lI5+GoH0RrjDa34Uh97IPVVnE=;
        b=ZRGWDaxzfm4RkPIqx/zxV/YhICcwOUjXtMnH0ncBSJoffG8tn/iRwCZwIWQ1ERfn0I
         BRfP+Acdz52mNX0ArYNodLOv0fJmdOIo5GAFnYi+Wpq4dUm4tPJIdv/7nNoNguTKGL2Q
         y160zKR951ETeOhuni2FESAaTnVGUdjG4GYKVlZrRx/CTVuT1cfUsfKJ6/RvLVF9t/PL
         aXaVBAThKgDrSox4rKfNSd4dE1vVJS/yK253jdsieRtqrbtCxnXrLyDwnK5OV5O1MVtT
         /CH9UzSmgyagP6iJMgjySgj0uNJB192gg+aSWkULYbTpQhQgOwZGBzWtcOvJw7t5dReT
         uVxA==
X-Gm-Message-State: APjAAAXeBR5OUOPzIRAuo9QYdiwT9zFjhs1ophkInURs3LAWV0ByVwjS
        S2yjl76jcKMjwUA95xTHNmH8unuwt23EriPtA70o2w==
X-Google-Smtp-Source: APXvYqyfqWZAXfrJsO0EIOGPEOiVTmTphsF8Nd5/zTEEW/QM592W7fkmwVxpSXL9FCmqxUOGOoCfgRt0e+Sd/MmdUdU=
X-Received: by 2002:a5d:8788:: with SMTP id f8mr12541175ion.20.1567102381218;
 Thu, 29 Aug 2019 11:13:01 -0700 (PDT)
MIME-Version: 1.0
References: <1566406146-7887-1-git-send-email-alex@zadara.com>
 <CAOcd+r0bXefi79dnwrwsDN1OecScfTjc8DYS5_9A8D5XKrh7QQ@mail.gmail.com>
 <20190826133951.GC22759@fieldses.org> <CAOcd+r059fh7J8T=6MdjPSCP39K5fpOZTsXZDUKq5TrPv_RcVQ@mail.gmail.com>
 <20190827205158.GB13198@fieldses.org> <CAOcd+r0Ybfr1WszjYc1K19Cf7JmKowy=Go6nc8Fexf5KxNyf=A@mail.gmail.com>
 <20190828165429.GC26284@fieldses.org>
In-Reply-To: <20190828165429.GC26284@fieldses.org>
From:   Alex Lyakas <alex@zadara.com>
Date:   Thu, 29 Aug 2019 21:12:49 +0300
Message-ID: <CAOcd+r3e52q_ds3zjya98whYarqoXf5C2umNEX-AGp4-R6=Cuw@mail.gmail.com>
Subject: Re: [RFC-PATCH] nfsd: when unhashing openowners, increment
 openowner's refcount
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     chuck.lever@oracle.com, linux-nfs@vger.kernel.org,
        Shyam Kaushik <shyam@zadara.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Bruce,

On Wed, Aug 28, 2019 at 7:54 PM J. Bruce Fields <bfields@fieldses.org> wrote:
>
> On Wed, Aug 28, 2019 at 06:20:22PM +0300, Alex Lyakas wrote:
> > On Tue, Aug 27, 2019 at 11:51 PM J. Bruce Fields <bfields@fieldses.org> wrote:
> > >
> > > On Tue, Aug 27, 2019 at 12:05:28PM +0300, Alex Lyakas wrote:
> > > > Is the described issue familiar to you?
> > >
> > > Yep, got it, but I haven't seen anyone try to solve it using the fault
> > > injection code, that's interesting!
> > >
> > > There's also fs/nfsd/unlock_filesystem.  It only unlocks NLM (NFSv3)
> > > locks.  But it'd probably be reasonable to teach it to get NFSv4 state
> > > too (locks, opens, delegations, and layouts).
> > >
> > > But my feeling's always been that the cleanest way to do it is to create
> > > two containers with separate net namespaces and run nfsd in both of
> > > them.  You can start and stop the servers in the different containers
> > > independently.
> >
> > I am looking at the code, and currently nfsd creates a single
> > namespace subsystem in init_nfsd. All nfs4_clients run in this
> > subsystem.
> >
> > So the proposal is to use register_pernet_subsys() for every
> > filesystem that is exported?
>
> No, I'm proposing any krenel changes.  Just create separate net
> namespaces from userspace and start nfsd from within them.  And you'll
> also need to arrange for them different nfsd's to get different exports.
>
> In practice, the best way to do this may be using some container
> management service, I'm not sure.
>
> > I presume that current nfsd code cannot
> > do this, and some rework is required to move away from a single
> > subsystem to per-export subsystem. Also, grepping through kernel code,
> > I see that namespace subsystems are created by different modules as
> > part of module initialization, rather than doing that dynamically.
> > Furthermore, in our case the same nfsd machine S can export tens or
> > even hundreds of local filesystems.Is this fine to have hundreds of
> > subsystems?
>
> I haven't done it myself, but I suspect hundreds of containers should be
> OK.  It may depend on available resources, of course.
>
> > Otherwise, I understand that the current behavior is a "won't fix",
> > and it is expected for the client machine to unmount the export before
> > un-exporting the file system at nfsd machine. Is this correct?
>
> You're definitely not the only ones to request this, so I'd like to have
> a working solution.
>
> My preference would be to try the namespace/container approach first.
> And if that turns out no to work well for some reason, to update
> fs/nfsd/unlock_filesystem to handle NFSv4 stuff.
>
> The fault injection code isn't the right interface for this.  Even if we
> did decide it was worth fixing up and maintaining--it's really only
> designed for testing clients.  I'd expect distros not to build it in
> their default kernels.

Hi Bruce,

We evaluated the network namespaces approach. But, unfortunately, it
doesn't fit easily into how our system is currently structured. We
would have to create and configure interfaces for every namespace, and
have a separate IP address (presumably) for every namespace. All this
seems a bit of an overkill, to just have several local filesystems
exported to the same client (which is when we hit the issue). I would
assume that some other users would argue as well that creating a
separate network namespace for every local filesystem is not the way
to go from the administration point of view.

Regarding the failure injection code, we did not actually enable and
use it. We instead wrote some custom code that is highly modeled after
the failure injection code. And that's how we found the openowner
refcnt issue, from which this thread started. Similarly to the failure
injection code, our code iterates over all the clients, all the
openowners, all the OPEN-stateids and the opened files. Then for each
opened file, it decides whether this file belongs to the file system
that has been just un-exported. To accomplish that, we added a custom
field to nfs4_file:
struct nfs4_file {
    atomic_t        fi_ref;
    spinlock_t        fi_lock;
    ...
#ifdef CONFIG_NFSD_ZADARA
    u64    fi_share_id; /* which exported FS this file belongs to; non-zero */
#endif /*CONFIG_NFSD_ZADARA*/
};

We also added some simple data structure that tracks all the exported
file systems, and assigns a unique "share_id" for each.In
find_or_add_file(), we consult the custom data structure that we
added, and assign a "fi_share_id" for every nfs4_file that is
newly-created.

The code that "forgets" all the relevant openowners looks like:

void forget_openowners_of_share_id(uint64 share_id)
{
    spin_lock(&nn->client_lock);
    list_for_each_entry(clp, &nn->client_lru, cl_lru) {
        spin_lock(&clp->cl_lock);
        list_for_each_entry_safe(oo, oo_next, &clp->cl_openowners,
oo_perclient) {
            list_for_each_entry(stp, &oo->oo_owner.so_stateids,
st_perstateowner) {
                if (stp->st_stid.sc_file->fi_share_id == share_id) {
                   // This file belongs to relevant share_id
                    ...
                }
            }
            if (openowner has only files from this "share_id") {
                // we don't expect same openowner to have files from
different share_ids
                nfs4_get_stateowner(&oo->oo_owner);// take extra refcnt
                unhash_openowner_locked(oo);
                atomic_inc(&clp->cl_refcount);
                list_add(&oo->oo_perclient, &openowner_reaplist);
            }
        }
        spin_unlock(&clp->cl_lock);
    }
    spin_unlock(&nn->client_lock);

    nfsd_reap_openowners(&reaplist);
}

So this code is very similar to the existing failure injection code.
It's just that the criteria for openowner selection is different.

Currently this code is invoked from a custom procfs entry, by
user-space application, before unmounting the local file system.

Would moving this code into the "unlock_filesystem" infrastructure be
acceptable? Since the "share_id" approach is very custom for our
usage, what criteria would you suggest for selecting the openowners to
be "forgotten"?

Thanks,
Alex.
