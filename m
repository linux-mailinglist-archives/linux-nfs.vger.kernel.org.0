Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32EFB14F2ED
	for <lists+linux-nfs@lfdr.de>; Fri, 31 Jan 2020 20:46:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726109AbgAaTqg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 31 Jan 2020 14:46:36 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40425 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbgAaTqf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 31 Jan 2020 14:46:35 -0500
Received: by mail-wr1-f67.google.com with SMTP id j104so10040483wrj.7
        for <linux-nfs@vger.kernel.org>; Fri, 31 Jan 2020 11:46:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fgcLe8zYDisfZlrtNVUVsQkz1lNpbPSJd0uHX+pjXVc=;
        b=SYEWEr8DjGBhnlj5q+PhTrYpu0eN8CL0Njy6BMBkQTgyCXyGA1iYVNCYaDO7cJ1nwg
         Ejj8tAfJkdL8GQtmA6jzEHcLeGDwGBQ76+4haE8QzCVn4U00M6oWBv8KIAC8fzLHTUcX
         /wESEckcFGtsZDYirFBITc4fq3ETzIPoqQRCGNxQMRJDwnjPm5xim7yNI0FZ7bB8iV73
         2y05AhW7PfqEG/fGvCZkk5otiyeNFzHLSESgDGlYngZBPf2eOI5E1GqFOJwO13SR4PDl
         RIb2uMzdE50yaVXH7g7r5xhRHSQIBs/5+vPvIm2WnGZ7/IvOcFiJWmqzMLIj/9/+bfkG
         eN1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fgcLe8zYDisfZlrtNVUVsQkz1lNpbPSJd0uHX+pjXVc=;
        b=otIqZKDjSFRQWIzeLi764QjfWolh4lyCef4wQoE+8TUo7PzTEzifCSIbSMBS1ZuCEy
         pfjZ2QKQqUDxm4+GtHmKzd/lFHT5f0k+228tF7hzF1ynKOoDWRjo3B52CRBWrF24B+km
         nloP8je5oGooJAuFY0eIMmNfpu3aA/8Jpm0oHke21Jo5WkQoXN6ZZ7OLWHZCbJTFKMsW
         C93yD9m3/refmzz8X5uUWH5rtTRcJVkb7+d29bM7K+yKJCe9EJPNWiYg+3q+R9HzBSnV
         8zgGSyOa0sWiDWIZ5dIJCmZ0HisKuCISiH7XPflA/BK0q+IlmNfNcSSp4DMTfYuf6rNY
         2U8w==
X-Gm-Message-State: APjAAAVhIzvazY83LXPzQTZnZZ1j59VF9yLIeFIf8MQHI78/0gSik6wX
        KUl//M/62ex9EJdVOINujzpNNl/iLGTvXUpw/rU=
X-Google-Smtp-Source: APXvYqxnexm7qhB82U/PBBZB5WXYn0B0hEs4uc2vc9uSJvYzoGGIbKP/sAFX7jFDM5J1hWisG0X4ywp67nv/Gh4DJJE=
X-Received: by 2002:adf:c54e:: with SMTP id s14mr4761wrf.385.1580499992621;
 Fri, 31 Jan 2020 11:46:32 -0800 (PST)
MIME-Version: 1.0
References: <20200131165702.1751-1-olga.kornievskaia@gmail.com>
 <45AE6B67-4B01-412B-8ABF-94E06BFB77D8@oracle.com> <CAN-5tyG-Mjk1pvba-9b38Nfp_jA-CUaobtLtPj1UfXyRoj-wxA@mail.gmail.com>
 <E45EBB55-7669-4E1E-9F3F-E57BFAB2B7D7@oracle.com> <CAN-5tyEFwLpWi=MM=1EetQy4+y=RB4uJ3D8dYNBQ81gr4OmyeQ@mail.gmail.com>
 <E8111218-B7AA-4AC7-A6E2-78BEC46D6486@oracle.com>
In-Reply-To: <E8111218-B7AA-4AC7-A6E2-78BEC46D6486@oracle.com>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Fri, 31 Jan 2020 14:46:21 -0500
Message-ID: <CAN-5tyH8HWHij8HN2Wviy84XfqR571kJK+7Q0sNDk1Es2oc3_Q@mail.gmail.com>
Subject: Re: [PATCH 1/1] NFSv4.0 encode nconnect-enabled client into clientid
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Jan 31, 2020 at 2:09 PM Chuck Lever <chuck.lever@oracle.com> wrote:
>
>
>
> > On Jan 31, 2020, at 1:55 PM, Olga Kornievskaia <olga.kornievskaia@gmail.com> wrote:
> >
> > On Fri, Jan 31, 2020 at 1:36 PM Chuck Lever <chuck.lever@oracle.com> wrote:
> >>
> >>
> >>
> >>> On Jan 31, 2020, at 12:46 PM, Olga Kornievskaia <olga.kornievskaia@gmail.com> wrote:
> >>>
> >>> Hi Chuck,
> >>>
> >>> Thanks for the discussion!
> >>>
> >>> On Fri, Jan 31, 2020 at 12:10 PM Chuck Lever <chuck.lever@oracle.com> wrote:
> >>>>
> >>>> Hi Olga-
> >>>>
> >>>>> On Jan 31, 2020, at 11:57 AM, Olga Kornievskaia <olga.kornievskaia@gmail.com> wrote:
> >>>>>
> >>>>> From: Olga Kornievskaia <kolga@netapp.com>
> >>>>>
> >>>>> It helps some servers to be able to identify if the incoming client is
> >>>>> doing nconnect mount or not. While creating the unique client id for
> >>>>> the SETCLIENTID operation add nconnect=X to it.
> >>>>
> >>>> This makes me itch uncomfortably.
> >>>
> >>> I was asked...
> >>>
> >>>> The long-form client ID string is not supposed to be used to communicate
> >>>> client implementation details. In fact, this string is supposed to be
> >>>> opaque to the server -- it can only compare these strings for equality.
> >>>
> >>> Indeed, to servers it should only be using it for equality no argument
> >>> there but I don't think they are prohibited from deriving info from it
> >>> but shouldn't complain if something changed.
> >>>
> >>> My reasoning was that we are currently already putting some
> >>> descriptive stuff into the clientid string. We specify what version
> >>> this client is. So why not add something that speaks about its
> >>> nconnect ability?
> >>
> >> RFC 7350 Section 9.1.1 discusses what belongs in the client ID string.
> >>
> >> - Does adding nconnect help distinguish this client from others?
> >> I think that it adds no new value there.
> >
> > How does adding LinuxV4.0 helps?  I think "nconnect" servers the same
> > value. It distinguishes from another linux client that doesn't do
> > nconnect.
>
> "Linux NFSv4.x" is historical. But it does distinguish between
> Linux and other operating systems.
>
> If you add nconnect to the client ID string, then most Linux
> NFSv4.x mounts will have "nconnect=x" where x is the default
> setting. That's no better than just "Linux NFSv4.x".
>
>
> >> - How do you guarantee that this client presents the same nconnect
> >> setting after every reboot? If the nconnect setting varies for different
> >> mount points, it's possible that the cl_nconnect value can be different
> >> depending on the order the client performs the mounts.
> >
> > Different mount points share the same clientid. A submount will have
> > the same nconnect as the original mount. Given existing
> > implementation, we can't have different mounts with different nconnect
> > values.
>
> The nconnect value can change over a client reboot. If the
> /etc/fstab or /etc/nfsmount.conf settings are changed, the
> cl_nconnect value will change.
>
> It's not OK to add a hidden dependence on lock reclaim to
> the nconnect mount option.
>
>
> > What reboot are we talking about server or client?
> >
> > On a client reboot, the same nconnect value is used (if say it's
> > mounted from /etc/fstab). If somebody, after a client reboot, manually
> > remounted and used a different nconnect value, so what, it's a
> > different mount, what problem are you thinking about?
> >
> > If you are talking about a server reboot, then why would a client's
> > data structure change that stores the value that created the orginal
> > clientid string with the nconnect value.
> >
> >
> >> In fact I don't see how the client is constrained to present the same
> >> nconnect setting even during the same reboot, for similar reasons.
> >>
> >> That will break open/lock state reclaim, iiuc. And it will be subtle,
> >> silent, non-deterministic breakage.
> >
> > I'm missing how this can be possible.
>
> If you have multiple NFSv4 mounts in /etc/fstab and they have different
> nconnect settings, then the client's cl_nconnect value will depend on
> which one gets mounted first. Isn't that how it works?

Ok, I see it now. if /vol1 was mount with nconnect=2 and /vol2 with
nconnect=3 then "first" mount wins.

I retract my patch then. Thank you for your help!

> That would mean that the client presents a different client ID string
> to the server depending on which of these mounts happens first after a
> client reboot.
>
> We have the same problem with the sec= setting, which is why the kernel
> chooses a setting mostly independently of the sec= mount option.
>
>
> >>>> IMO you would also need to write something akin to a standard that describes
> >>>> this convention so that servers can depend on the form of the string.
> >>>>
> >>>> How would a server use this information?
> >>>
> >>> The server is interested in identifying whether or not client is doing
> >>> nconnect or not in order to decide whether or not to apply extra
> >>> locking for a given client mount in order to provide best performance.
> >>> In 4.1 spec, we clearly define how to bind connections to
> >>> session/clientid so server can use that information but 4.0 is lacking
> >>> that and a server is left to just deal with existence of multiple
> >>> connection (trunking) at any give time.
> >>
> >> You can't insist that clients use NFSv4.1 in those cases?
>
> This seems like a pertinent question. What is wrong with suggesting
> the use of NFSv4.1 in such cases?
>
>
> >> Seems like this is proposing that the Linux NFS client should be changed
> >> to fix a server implementation issue for a protocol that already has been
> >> fixed in newer versions.
> >>
> >>
> >>>>> Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> >>>>> ---
> >>>>> fs/nfs/nfs4proc.c | 20 +++++++++++---------
> >>>>> 1 file changed, 11 insertions(+), 9 deletions(-)
> >>>>>
> >>>>> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> >>>>> index 402410c..a90ea28 100644
> >>>>> --- a/fs/nfs/nfs4proc.c
> >>>>> +++ b/fs/nfs/nfs4proc.c
> >>>>> @@ -5950,7 +5950,7 @@ static void nfs4_init_boot_verifier(const struct nfs_client *clp,
> >>>>>             return 0;
> >>>>>
> >>>>>     rcu_read_lock();
> >>>>> -     len = 14 +
> >>>>> +     len = 14 + 12 +
> >>>>>             strlen(clp->cl_rpcclient->cl_nodename) +
> >>>>>             1 +
> >>>>>             strlen(rpc_peeraddr2str(clp->cl_rpcclient, RPC_DISPLAY_ADDR)) +
> >>>>> @@ -5972,13 +5972,15 @@ static void nfs4_init_boot_verifier(const struct nfs_client *clp,
> >>>>>
> >>>>>     rcu_read_lock();
> >>>>>     if (nfs4_client_id_uniquifier[0] != '\0')
> >>>>> -             scnprintf(str, len, "Linux NFSv4.0 %s/%s/%s",
> >>>>> +             scnprintf(str, len, "Linux NFSv4.0 nconnect=%d %s/%s/%s",
> >>>>> +                       clp->cl_nconnect,
> >>>>>                       clp->cl_rpcclient->cl_nodename,
> >>>>>                       nfs4_client_id_uniquifier,
> >>>>>                       rpc_peeraddr2str(clp->cl_rpcclient,
> >>>>>                                        RPC_DISPLAY_ADDR));
> >>>>>     else
> >>>>> -             scnprintf(str, len, "Linux NFSv4.0 %s/%s",
> >>>>> +             scnprintf(str, len, "Linux NFSv4.0 nconnect=%d %s/%s",
> >>>>> +                       clp->cl_nconnect,
> >>>>>                       clp->cl_rpcclient->cl_nodename,
> >>>>>                       rpc_peeraddr2str(clp->cl_rpcclient,
> >>>>>                                        RPC_DISPLAY_ADDR));
> >>>>> @@ -5994,7 +5996,7 @@ static void nfs4_init_boot_verifier(const struct nfs_client *clp,
> >>>>>     size_t len;
> >>>>>     char *str;
> >>>>>
> >>>>> -     len = 10 + 10 + 1 + 10 + 1 +
> >>>>> +     len = 10 + 10 + 1 + 10 + 1 + 12 +
> >>>>>             strlen(nfs4_client_id_uniquifier) + 1 +
> >>>>>             strlen(clp->cl_rpcclient->cl_nodename) + 1;
> >>>>>
> >>>>> @@ -6010,9 +6012,9 @@ static void nfs4_init_boot_verifier(const struct nfs_client *clp,
> >>>>>     if (!str)
> >>>>>             return -ENOMEM;
> >>>>>
> >>>>> -     scnprintf(str, len, "Linux NFSv%u.%u %s/%s",
> >>>>> +     scnprintf(str, len, "Linux NFSv%u.%u nconnect=%d %s/%s",
> >>>>>                     clp->rpc_ops->version, clp->cl_minorversion,
> >>>>> -                     nfs4_client_id_uniquifier,
> >>>>> +                     clp->cl_nconnect, nfs4_client_id_uniquifier,
> >>>>>                     clp->cl_rpcclient->cl_nodename);
> >>>>
> >>>> Doesn't this also change the client ID string used for EXCHANGE_ID ?
> >>>
> >>> I didn't think it would hurt there. But honestly, I just didn't know
> >>> which of the 3 functions that we have to create clientid were used for
> >>> what protocols so I added nconnect to all.
> >>
> >> non_uniform is for NFSv4.0 only. uniform can be used by any minor version.
> >>
> >>
> >>>>>     clp->cl_owner_id = str;
> >>>>>     return 0;
> >>>>> @@ -6030,7 +6032,7 @@ static void nfs4_init_boot_verifier(const struct nfs_client *clp,
> >>>>>     if (nfs4_client_id_uniquifier[0] != '\0')
> >>>>>             return nfs4_init_uniquifier_client_string(clp);
> >>>>>
> >>>>> -     len = 10 + 10 + 1 + 10 + 1 +
> >>>>> +     len = 10 + 10 + 1 + 10 + 1 + 12 +
> >>>>>             strlen(clp->cl_rpcclient->cl_nodename) + 1;
> >>>>>
> >>>>>     if (len > NFS4_OPAQUE_LIMIT + 1)
> >>>>> @@ -6045,9 +6047,9 @@ static void nfs4_init_boot_verifier(const struct nfs_client *clp,
> >>>>>     if (!str)
> >>>>>             return -ENOMEM;
> >>>>>
> >>>>> -     scnprintf(str, len, "Linux NFSv%u.%u %s",
> >>>>> +     scnprintf(str, len, "Linux NFSv%u.%u nconnect=%d %s",
> >>>>>                     clp->rpc_ops->version, clp->cl_minorversion,
> >>>>> -                     clp->cl_rpcclient->cl_nodename);
> >>>>> +                     clp->cl_nconnect, clp->cl_rpcclient->cl_nodename);
> >>>>>     clp->cl_owner_id = str;
> >>>>>     return 0;
> >>>>> }
> >>>>> --
> >>>>> 1.8.3.1
> >>>>>
> >>>>
> >>>> --
> >>>> Chuck Lever
> >>
> >> --
> >> Chuck Lever
>
> --
> Chuck Lever
>
>
>
