Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C9427E1F1
	for <lists+linux-nfs@lfdr.de>; Thu,  1 Aug 2019 20:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729985AbfHASG7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 1 Aug 2019 14:06:59 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:33293 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726825AbfHASG7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 1 Aug 2019 14:06:59 -0400
Received: by mail-vs1-f68.google.com with SMTP id m8so49590580vsj.0
        for <linux-nfs@vger.kernel.org>; Thu, 01 Aug 2019 11:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FykGvrwXfH/zKtdPtX60heHaryJB88Qcq9bs7kPOsQI=;
        b=X8nbkXEeOs2JSd1RzPv8W5mmXp8IveD4XMyyz9e4n8hAjupaalwDpJp1BrA2qIs0zJ
         G8aiTznOlU9eLWQe6mnAUBEuwjetd7QiBII8zppYtuocYd9bHIzy6NPNw+7JpV15etlF
         +hMcwK/yTVAZaS5OViyyX+YoeM82hn+5Y6Gvs9+KmJG9JOCPlyqjUMFtcLWwRs640bYu
         2xoa2SPifYfOGtZ+n39u7K9BqYfKFiRAaBS3mSQOTJV1NgKb7s7D+oHG2llGufL75PFO
         fXFMv+Ikblx6LJlCIbQ6pG0l/OXNMrkMIKZ1Nwl+OjwZVeRGEDA4pynI83ekgJ0VZdoU
         2A8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FykGvrwXfH/zKtdPtX60heHaryJB88Qcq9bs7kPOsQI=;
        b=jPJDTasfy1/JL3itXOLVcxkJFkiLo1SvVWiWAXcZph68/8r7vin+kGxzZ2dv9y6BZC
         Vz344TJAPHOlP8FJ9j22aU14bBkpB8Q5KcHo9lHxdxTKtqnXn3DlsWA7gW9eGnAcbKAi
         TziXUahq0TPL9tsBfUJeE2PvYXIYSAzIqcalFKoSdxCZzpfFgSHYbWUm47Ta4QMauuv1
         ljiabxpiikYB+SgJ1RhQ0RS3+uR3DF5No4OWxCG+k/Ls3d+yIjZ1wmChqBut9cYlxIUP
         IDcLmP0I8K6JgUHnN+2yA2xy6a0Xyqn7PtVsxMaI/MXEZH8COFeTlyxSPGUBVn0dTsM3
         yY5Q==
X-Gm-Message-State: APjAAAUST6iK20luuTNmLhTgc3si3Ipy9K7pAFSq8nQhR/2AuX0fwZ8e
        ygrXKTcmnVSp6NMItWrii2Uc7B5sUy4DWePO8XwBuA==
X-Google-Smtp-Source: APXvYqzs0ARAXTLYeL3nH5xbWI9pFpKp97U+7c1j8W+dM0MHhPqus4QthnVK1X0jMgp/JiFQvScg5HWueI+zyFgFoQY=
X-Received: by 2002:a67:8907:: with SMTP id l7mr83822668vsd.194.1564682817716;
 Thu, 01 Aug 2019 11:06:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190708192352.12614-1-olga.kornievskaia@gmail.com>
 <20190708192352.12614-6-olga.kornievskaia@gmail.com> <20190719220116.GA24373@fieldses.org>
 <CAN-5tyHdxBcEH0xPV2814nUMEHPCsQ9iD_A7K=W3ZeE6b4OJxg@mail.gmail.com>
 <20190723205846.GB19559@fieldses.org> <CAN-5tyFTRr9KPYAzq-EaOMqDeJU31-qHGsLyCmEtd18OMxCFNQ@mail.gmail.com>
 <CAN-5tyEbwjPNbXKWXv+3=geisjH-i=xKWRqgyXa3v9Xk=OvdEw@mail.gmail.com>
 <20190731215118.GA13311@parsley.fieldses.org> <CAN-5tyGz5M1eMFC=CJUEdTB7cAq-PRis8SJMEnrcr4Svmmy03w@mail.gmail.com>
 <20190801151239.GC17654@fieldses.org> <CAN-5tyE8xdJhs5C_bOo0a9yLRUAvkKi7OLOq47He5P0OR8PGyQ@mail.gmail.com>
In-Reply-To: <CAN-5tyE8xdJhs5C_bOo0a9yLRUAvkKi7OLOq47He5P0OR8PGyQ@mail.gmail.com>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Thu, 1 Aug 2019 14:06:46 -0400
Message-ID: <CAN-5tyEx7-kddfgsvSGAsCD3amMXq-iGLkQN2GdmaXOc19GwkA@mail.gmail.com>
Subject: Re: [PATCH v4 5/8] NFSD check stateids against copy stateids
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     "J. Bruce Fields" <bfields@redhat.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Aug 1, 2019 at 11:41 AM Olga Kornievskaia
<olga.kornievskaia@gmail.com> wrote:
>
> On Thu, Aug 1, 2019 at 11:13 AM J. Bruce Fields <bfields@fieldses.org> wrote:
> >
> > On Thu, Aug 01, 2019 at 10:12:11AM -0400, Olga Kornievskaia wrote:
> > > On Wed, Jul 31, 2019 at 5:51 PM J. Bruce Fields <bfields@redhat.com> wrote:
> > > >
> > > > On Wed, Jul 31, 2019 at 05:10:01PM -0400, Olga Kornievskaia wrote:
> > > > > I'm having difficulty with this patch because there is no good way to
> > > > > know when the copy_notify stateid can be freed. What I can propose is
> > > > > to have the linux client send a FREE_STATEID with the copy_notify
> > > > > stateid and use that as the trigger to free the state. In that case,
> > > > > I'll keep a reference on the parent until the FREE_STATEID is
> > > > > received.
> > > > >
> > > > > This is not in the spec (though seems like a good idea to tell the
> > > > > source server it's ok to clean up) so other implementations might not
> > > > > choose this approach so we'll have problems with stateids sticking
> > > > > around.
> > > >
> > > > https://tools.ietf.org/html/rfc7862#page-71
> > > >
> > > >         "If the cnr_lease_time expires while the destination server is
> > > >         still reading the source file, the destination server is allowed
> > > >         to finish reading the file.  If the cnr_lease_time expires
> > > >         before the destination server uses READ or READ_PLUS to begin
> > > >         the transfer, the source server can use NFS4ERR_PARTNER_NO_AUTH
> > > >         to inform the destination server that the cnr_lease_time has
> > > >         expired."
> > > >
> > > > The spec doesn't really define what "is allowed to finish reading the
> > > > file" means, but I think the source server should decide somehow whether
> > > > the target's done.  And "hasn't sent a read in cnr_lease_time" seems
> > > > like a pretty good conservative definition that would be easy to
> > > > enforce.
> > >
> > > "hasn't send a read in cnr_lease_time" is already enforced.
> > >
> > > The problem is when the copy did start in normal time, it might take
> > > unknown time to complete. If we limit copies to all be done with in a
> > > cnr_lease_time or even some number of that, we'll get into problems
> > > when files are large enough or network is slow enough that it will
> > > make this method unusable.
> >
> > No, I'm just suggesting that if it's been more than cnr_lease_time since
> > the target server last sent a read using this stateid, then we could
> > free the stateid.
>
> That's reasonable. Let me do that.

Now that I need a global list for the copy_notify stateids, do you
have a preference for either to keep it of the nfs4_client structure
or the nfsd_net structure? I store async copies under the nfs4_client
structure but the laundromat traverses things in nfsd_net structure.

>
> > > > Worst case, if the network goes down for a couple minutes and
> > > > the target tries to pick up a copy where it left off, it'll get
> > > > PARTNER_NO_AUTH.  I assume that results in the same error being returned
> > > > the client, at which point the client knows that the copy_notify stateid
> > > > may have installed and can do what it chooses to recover (like send a
> > > > new copy_notify).
> > >
> > > Yes the client recovers but the cost of setting up the source server
> > > to destination is huge so any retries would kill the performance.
> >
> > In the rare case when the server goes an entire cnr_lease_time between
> > reads, the performance hit of recovery won't be an issue.
> >
> > > > The FREE_STATEID might also be a good idea, but I guess we can't count
> > > > on it.
> > > >
> > > > Maybe the spec could use some errata to clarify that FREE_STATEID is
> > > > allowed on copy_notify stateids, that clients should send it when
> > > > they're done, and that servers are allowed to expire copy_notify
> > > > stateid's even after their first use.
> > >
> > > FREE_STATEID is for a stateid
> >
> > The discussion of FREE_STATEID in 4.1 says "The FREE_STATEID operation
> > is used to free a stateid that no longer has any associated locks
> > (including opens, byte-range locks, delegations, and layouts)."  A
> > clarification that it can be used for any stateid would be nice.  (Is
> > that true?  Do we want it for COPY stateid's too?)
>
> We don't need it for the COPY stateids as there is a OFFLOAD_CANCEL if
> the client wants to stop, otherwise, the destination server has no
> problems with knowing when to free the copy stateid.
>
> >
> > --b.
> >
> > > which a copy_notify (or copy) stateid is so I don't see anything that
> > > really needs any extra stating.
> > >
> > > I think what's needed is specifying that for COPY_NOTIFY a client must
> > > do a FREE_STATEID when its done with a stateid.
