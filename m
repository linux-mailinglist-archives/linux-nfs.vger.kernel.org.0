Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A64E38CE37
	for <lists+linux-nfs@lfdr.de>; Fri, 21 May 2021 21:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235929AbhEUThC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 21 May 2021 15:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234456AbhEUThB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 21 May 2021 15:37:01 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E8F0C061574
        for <linux-nfs@vger.kernel.org>; Fri, 21 May 2021 12:35:37 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id k14so28614715eji.2
        for <linux-nfs@vger.kernel.org>; Fri, 21 May 2021 12:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dNShyS1x5OsFNLtoZ452i7QLY3xFiGNh/bt7/x27BLg=;
        b=PrnLNr6ewOvxCGbXUeGu8OoVVlReg14ef46ewx53mZR4M1/71hJGYymhdesTFtyGC9
         1FrRI9RAF4f3IGW7mWXDyfa6gTxW1tPWH3xdRDRj6MzR+23gUOlGtaO62kMkvUWgCcVu
         kv5zAJSkw29E5Ft/KVzkmG1Gfbf7O2SfIGvtMNfsGEMsbITWzUJfSRJwqfvS3n/7Vlhh
         4oo0i7ip1qyITvEsBm8bjoQkPbt/KJKE8Re+/2yyv7pG6zD9qrH6zOOxSGjwzmDFlbDY
         S7LCBx0wFyB7qJoxvy6JJT5d8aKlgFf0VgIAn0gQft37liBnvcNiF1W/jGQWS79hmwMM
         +dVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dNShyS1x5OsFNLtoZ452i7QLY3xFiGNh/bt7/x27BLg=;
        b=FKRy/RLJyT03OLfZySC3lQBZHHiZsvUHIDupGfU3MWxIGvAEsKl1VvaP7qjBpGRnEA
         g+pZG+bisHg2cvswWpYw6MUJwCPH/JaSlMWXSglq0F4JDfO5zOxvxWmYgVe7UwgFsi0b
         +SSOlzqodRWetW0+v/SdHizStK4bDptV1BaahHYCTdrRFE6ohSBZvPmaCJlcmbMpy+LD
         AVebU5YJwMzOPlt4suIa4dU7SOM3QnPvPOFTD7OCcMBPv7gQvj6GYMmaicozUT5M6jCO
         l/OoqrE540k/iMmtVrc2ZoAwf/hVKzuJf6dWe13VkkWYLunaokh784laCk9h6l1TuPV1
         f2hw==
X-Gm-Message-State: AOAM530b/gezTvg8S1rX9sUBc5ZktguZAewZBzD3WRe6HXWeiAgLvw/t
        3dd+JMIqVQk9q/mI5DsH+PqTasbbHU5xWAG8OlU=
X-Google-Smtp-Source: ABdhPJy/ecQ8CvmfrCn8V04EVUz1Sf2J8iT9L385LyG2UjIsmCm3/zIMQJKDYxaq7H+CbmJS0KCS9RXvZxkZm1UqFho=
X-Received: by 2002:a17:906:7c02:: with SMTP id t2mr11913977ejo.0.1621625735501;
 Fri, 21 May 2021 12:35:35 -0700 (PDT)
MIME-Version: 1.0
References: <CO1PR05MB810163D3FD8705AFF519F0B4B72D9@CO1PR05MB8101.namprd05.prod.outlook.com>
 <CAN-5tyGgWx6F2s=t+0UAJJZEAEfNnv+Sq8eeBbnQYocKOOK8Jg@mail.gmail.com>
 <6ae47edc-2d47-df9a-515a-be327a20131d@RedHat.com> <CO1PR05MB8101FD5E77B386A75786FF41B7299@CO1PR05MB8101.namprd05.prod.outlook.com>
In-Reply-To: <CO1PR05MB8101FD5E77B386A75786FF41B7299@CO1PR05MB8101.namprd05.prod.outlook.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Fri, 21 May 2021 15:35:23 -0400
Message-ID: <CAN-5tyFVGexM_6RrkjJPfUPT5T4Z7OGk41gSKeQcoi9cLYb=eA@mail.gmail.com>
Subject: Re: NFSv4: Mounting NFS server which is down, blocks all other NFS
 mounts on same machine
To:     Michael Wakabayashi <mwakabayashi@vmware.com>
Cc:     Steve Dickson <SteveD@redhat.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, May 21, 2021 at 3:09 PM Michael Wakabayashi
<mwakabayashi@vmware.com> wrote:
>
> > This code came in with commit c156618e15101 which fixed a deadlock in n=
fs client initialization.
>
> > My conclusion is: an unresponsive server will block other mounts but on=
ly until timeout is reached.
>
> Hi Steve and Olga,
>
> We run multiple Kubernetes clusters.
> These clusters are composed of hundreds of Kubernetes nodes.
> Any of these nodes can NFS mount on behalf of the containers running on t=
hese nodes.
> We've seen several times in the past few months an NFS mount hang, and th=
en several hundred up to several thousand NFS mounts blocked by this hung N=
FS mount processes (we have many "testing" workloads that access NFS).
> Having several hundred NFS mounts blocked on a node causes the Kubernetes=
 node to become unstable and severely degrades service.
>
> We did not expect a hung NFS mount to block every other NFS mount, especi=
ally when the other mounts are unrelated and otherwise working properly.
>
> Can this behavior be changed?

Hi Michael,

I'm not sure if the design can be changed. But I would like to know
what's a legitimate reason for a machine to have a listening but not
responsive port 2049 (I'm sorry I don't particularly care for the
explanation of "because this is how things currently work in
containers, Kubernetes"). Seems like the problem should be fixed
there. There is no issue if a mount goes to an IP that has nothing
listening on port 2049.

Again I have no comments on the design change: or rather my comment
was I don't see a way. If you have 2 parallel clients initializing and
the goal is to have at most one client if both are the same, then I
don't see a way besides serializing it as it's done now.

>
> Thanks, Mike
>
>
> ________________________________
> From: Steve Dickson <SteveD@RedHat.com>
> Sent: Thursday, May 20, 2021 11:42 AM
> To: Olga Kornievskaia <aglo@umich.edu>; Michael Wakabayashi <mwakabayashi=
@vmware.com>
> Cc: linux-nfs@vger.kernel.org <linux-nfs@vger.kernel.org>
> Subject: Re: NFSv4: Mounting NFS server which is down, blocks all other N=
FS mounts on same machine
>
> Hey.
>
> On 5/19/21 3:15 PM, Olga Kornievskaia wrote:
> > On Sun, May 16, 2021 at 11:18 PM Michael Wakabayashi
> > <mwakabayashi@vmware.com> wrote:
> >>
> >> Hi,
> >>
> >> We're seeing what looks like an NFSv4 issue.
> >>
> >> Mounting an NFS server that is down (ping to this NFS server's IP addr=
ess does not respond) will block _all_ other NFS mount attempts even if the=
 NFS servers are available and working properly (these subsequent mounts ha=
ng).
> >>
> >> If I kill the NFS mount process that's trying to mount the dead NFS se=
rver, the NFS mounts that were blocked will immediately unblock and mount s=
uccessfully, which suggests the first mount command is blocking the other m=
ount commands.
> >>
> >>
> >> I verified this behavior using a newly built mount.nfs command from th=
e recent nfs-utils 2.5.3 package installed on a recent version of Ubuntu Cl=
oud Image 21.04:
> >> * https://nam04.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2F=
sourceforge.net%2Fprojects%2Fnfs%2Ffiles%2Fnfs-utils%2F2.5.3%2F&amp;data=3D=
04%7C01%7Cmwakabayashi%40vmware.com%7Cb6738a1c16d84aaeea4708d91bbeae36%7Cb3=
9138ca3cee4b4aa4d6cd83d9dd62f0%7C0%7C0%7C637571328052661113%7CUnknown%7CTWF=
pbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D=
%7C1000&amp;sdata=3D9hzJL1yA2EfyWsfuMOhH%2FpMUF%2BneUy3Q2XgCazi3CQw%3D&amp;=
reserved=3D0
> >> * https://nam04.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2F=
cloud-images.ubuntu.com%2Freleases%2Fhirsute%2Frelease-20210513%2Fubuntu-21=
.04-server-cloudimg-amd64.ova&amp;data=3D04%7C01%7Cmwakabayashi%40vmware.co=
m%7Cb6738a1c16d84aaeea4708d91bbeae36%7Cb39138ca3cee4b4aa4d6cd83d9dd62f0%7C0=
%7C0%7C637571328052661113%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQI=
joiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DJbfU1Ym%2B6ZTJ=
UwzPZlPpZtk8Kc0TLfSY7aDDJWr5AuU%3D&amp;reserved=3D0
> >>
> >>
> >> The reason this looks like it is specific to NFSv4 is from the followi=
ng output showing "vers=3D4.2":
> >>> $ strace /sbin/mount.nfs <unreachable-IP-address>:/path /tmp/mnt
> >>> [ ... cut ... ]
> >>> mount("<unreadhable-IP-address>:/path", "/tmp/mnt", "nfs", 0, "vers=
=3D4.2,addr=3D<unreachable-IP-address>,clien"...^C^Z
> >>
> >> Also, if I try the same mount.nfs commands but specifying NFSv3, the m=
ount to the dead NFS server hangs, but the mounts to the operational NFS se=
rvers do not block and mount successfully; this bug doesn't happen when usi=
ng NFSv3.
> >>
> >>
> >> We reported this issue under util-linux here:
> >> https://nam04.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgi=
thub.com%2Fkarelzak%2Futil-linux%2Fissues%2F1309&amp;data=3D04%7C01%7Cmwaka=
bayashi%40vmware.com%7Cb6738a1c16d84aaeea4708d91bbeae36%7Cb39138ca3cee4b4aa=
4d6cd83d9dd62f0%7C0%7C0%7C637571328052661113%7CUnknown%7CTWFpbGZsb3d8eyJWIj=
oiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sda=
ta=3D9dDoFaVP%2FjW6PPZTopYItCWTL7G8Fp62PKPf7ZtCWqs%3D&amp;reserved=3D0
> >> [mounting nfs server which is down blocks all other nfs mounts on same=
 machine #1309]
> >>
> >> I also found an older bug on this mailing list that had similar sympto=
ms (but could not tell if it was the same problem or not):
> >> https://nam04.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpa=
tchwork.kernel.org%2Fproject%2Flinux-nfs%2Fpatch%2F87vaori26c.fsf%40notaben=
e.neil.brown.name%2F&amp;data=3D04%7C01%7Cmwakabayashi%40vmware.com%7Cb6738=
a1c16d84aaeea4708d91bbeae36%7Cb39138ca3cee4b4aa4d6cd83d9dd62f0%7C0%7C0%7C63=
7571328052661113%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMz=
IiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3Du0F20wNC6L40aTwYKtF2GD7=
eAzlrgotrPvGED%2FWwlzc%3D&amp;reserved=3D0
> >> [[PATCH/RFC] NFSv4: don't let hanging mounts block other mounts]
> >>
> >> Thanks, Mike
> >
> > Hi Mike,
> >
> > This is not a helpful reply but I was curious if I could reproduce
> > your issue but was not successful. I'm able to initiate a mount to an
> > unreachable-IP-address which hangs and then do another mount to an
> > existing server without issues. Ubuntu 21.04 seems to be 5.11 based so
> > I tried upstream 5.11 and I tried the latest upstream nfs-utils
> > (instead of what my distro has which was an older version).
> >
> > To debug, perhaps get an output of the nfs4 and sunrpc tracepoints.
> > Or also get output from dmesg after doing =E2=80=9Cecho t >
> > /proc/sysrq-trigger=E2=80=9D to see where the mounts are hanging.
> >
> It looks like Mike is correct... The first process (mount 1.1.1.1:/mnt) i=
s
> hung in trying the connection:
>
> PID: 3394   TASK: ffff9da8c42734c0  CPU: 0   COMMAND: "mount.nfs"
>  #0 [ffffb44780f638c8] __schedule at ffffffff82d7959d
>  #1 [ffffb44780f63950] schedule at ffffffff82d79f2b
>  #2 [ffffb44780f63968] rpc_wait_bit_killable at ffffffffc05265ce [sunrpc]
>  #3 [ffffb44780f63980] __wait_on_bit at ffffffff82d7a4ba
>  #4 [ffffb44780f639b8] out_of_line_wait_on_bit at ffffffff82d7a5a6
>  #5 [ffffb44780f63a00] __rpc_execute at ffffffffc052fc8a [sunrpc]
>  #6 [ffffb44780f63a48] rpc_execute at ffffffffc05305a2 [sunrpc]
>  #7 [ffffb44780f63a68] rpc_run_task at ffffffffc05164e4 [sunrpc]
>  #8 [ffffb44780f63aa8] rpc_call_sync at ffffffffc0516573 [sunrpc]
>  #9 [ffffb44780f63b00] rpc_create_xprt at ffffffffc051672e [sunrpc]
> #10 [ffffb44780f63b40] rpc_create at ffffffffc0516881 [sunrpc]
> #11 [ffffb44780f63be8] nfs_create_rpc_client at ffffffffc0972319 [nfs]
> #12 [ffffb44780f63c80] nfs4_init_client at ffffffffc0a17882 [nfsv4]
> #13 [ffffb44780f63d70] nfs4_set_client at ffffffffc0a16ef8 [nfsv4]
> #14 [ffffb44780f63de8] nfs4_create_server at ffffffffc0a188d8 [nfsv4]
> #15 [ffffb44780f63e60] nfs4_try_get_tree at ffffffffc0a0bf69 [nfsv4]
> #16 [ffffb44780f63e80] vfs_get_tree at ffffffff823b6068
> #17 [ffffb44780f63ea0] path_mount at ffffffff823e3d8f
> #18 [ffffb44780f63ef8] __x64_sys_mount at ffffffff823e45a3
> #19 [ffffb44780f63f38] do_syscall_64 at ffffffff82d6aa50
> #20 [ffffb44780f63f50] entry_SYSCALL_64_after_hwframe at ffffffff82e0007c
>
> The second mount is hung up in nfs_match_client()/nfs_wait_client_init_co=
mplete
> waiting for the first process to compile
> nfs_match_client:
>
>        /* If a client is still initializing then we need to wait */
>         if (clp->cl_cons_state > NFS_CS_READY) {
>             refcount_inc(&clp->cl_count);
>             spin_unlock(&nn->nfs_client_lock);
>             error =3D nfs_wait_client_init_complete(clp);
>             nfs_put_client(clp);
>             spin_lock(&nn->nfs_client_lock);
>             if (error < 0)
>                 return ERR_PTR(error);
>             goto again;
>         }
>
> This code came in with commit c156618e15101 which fixed
> a deadlock in nfs client initialization.
>
> steved.
>
