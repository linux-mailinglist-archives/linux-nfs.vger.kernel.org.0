Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B506938BA8E
	for <lists+linux-nfs@lfdr.de>; Fri, 21 May 2021 01:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234300AbhETXx2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 20 May 2021 19:53:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233104AbhETXx1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 20 May 2021 19:53:27 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9DEAC061574
        for <linux-nfs@vger.kernel.org>; Thu, 20 May 2021 16:52:04 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id p24so26639192ejb.1
        for <linux-nfs@vger.kernel.org>; Thu, 20 May 2021 16:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Hwa3dQnrjyEoZ2ybZKS9iKiuNqHHPMYX5kah7YZ1fDc=;
        b=nzr7b4gqJ2Dmv6BQRTcdVialPgbBQFhaTcZH0OMNsYItxely2Sia3PmK9fkPX5cpmd
         OcWAuz4QCEoqciIqZjT3VmCZSYm/HYp68yAnS+zw8VMy6vGGxbhulZq5cNupgt25hGyg
         Juc9IPK+wOPmuCb7Tv+yhW181Wwq6lV9LdTxFKJyW468Qfq8Wf/CLmdyykAHeeMzTgJq
         evLa7P00eM7ykDaulDzOKGzSrEsaD/wHNAVX/GuxPUZ52KLRcR44CWxQmldc+RKNj/v6
         dETkftFjEEYpXUvGzdMGztFDML3b7AoZqvqy32F4I5mSnZKYJRc1u2llH1gsQM01+9cp
         8+Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Hwa3dQnrjyEoZ2ybZKS9iKiuNqHHPMYX5kah7YZ1fDc=;
        b=I/vqymETM4QI4P1bQEswkfQ96XNWsIqL6nZO/rUhVObsIG6IPq78t/85xvA1hOmzcF
         7dTmkpsAkawyPk7pCb6QOTFCu0EgKScBk+KLq7coNjp1T3dEC2fvAuScfV+L+OZ4Mzn8
         MVteFIan/fLKZUHRzelDIBrup+/EQwh5DQqBF7CaLIEJ6PaFaxkJPEk5/zZ8eSXCkA28
         rZm5rA5ZCAQcjaOyTtN/DyBN0tYBo3PW+ntj4xGxGjbYSAbQTbg2vscYzYqalU9W6Wpe
         wRnF9D6OBifdeAQcBTAqywfs+93UovLwupVPYkrY+ecYf87HZgGPrB0pXiEgUhorqnMG
         fjfA==
X-Gm-Message-State: AOAM530feIS3cXpM/fBO9uBGMwNftPpINAn5aSOfNIBCJkNO/pYF2q0B
        dEGlxqMoORSo9jFPsCNcba3deQyI6edlgwAxI7mbkipWQ8Q=
X-Google-Smtp-Source: ABdhPJxAq2f7Iwi1ukC07xTS4wXE78FuI7KohkT/2vi4IJgauOM+jOIV7LAkDLpxGC7hGGX9R3Pc76gXr6wGX7TRcqA=
X-Received: by 2002:a17:906:84d:: with SMTP id f13mr7242971ejd.451.1621554722981;
 Thu, 20 May 2021 16:52:02 -0700 (PDT)
MIME-Version: 1.0
References: <CO1PR05MB810163D3FD8705AFF519F0B4B72D9@CO1PR05MB8101.namprd05.prod.outlook.com>
 <CAN-5tyGgWx6F2s=t+0UAJJZEAEfNnv+Sq8eeBbnQYocKOOK8Jg@mail.gmail.com>
 <CO1PR05MB810173C0D970DE22AA9535B8B72A9@CO1PR05MB8101.namprd05.prod.outlook.com>
 <CO1PR05MB8101FEE18F82B0B3B251F1E5B72A9@CO1PR05MB8101.namprd05.prod.outlook.com>
In-Reply-To: <CO1PR05MB8101FEE18F82B0B3B251F1E5B72A9@CO1PR05MB8101.namprd05.prod.outlook.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Thu, 20 May 2021 19:51:51 -0400
Message-ID: <CAN-5tyGmq=LrO4SgqjJdhJkEgNfAHEbVNkNtEeuA3vvW7rjV=g@mail.gmail.com>
Subject: Re: NFSv4: Mounting NFS server which is down, blocks all other NFS
 mounts on same machine
To:     Michael Wakabayashi <mwakabayashi@vmware.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Mike,

Ok so I can reproduce it but the scenario is not exact what you are
stating. This is not an unreachable server. It requires that the
server is reachable but not responsive.

Using iptables I can say drop packets to port 2049 on one machine.
Then I mount that IP from the client. Your stack requires an "active"
but not responsive connection. And indeed until the 1st mount times
out (which it does), no other mounts go through.

But I think I agree with the previous comment that Trond made about
the need to wait for any clients that are in the middle initializing
until making any matches with it. I think a match can be made but the
initializing client can fail the initialization (based on what the
server returns).

My conclusion is: an unresponsive server will block other mounts but
only until timeout is reached.

On Thu, May 20, 2021 at 6:43 AM Michael Wakabayashi
<mwakabayashi@vmware.com> wrote:
>
> Hi Olga,
>
> If you are able to run privileged Docker containers
> you might be able to reproduce the issue running
> the following docker commands.
>
> docker pull ubuntu:hirsute-20210514 # ubuntu hirsute is the latest versio=
n of ubuntu
>
> # Run this to find the id of the ubuntu image  which is needed in the nex=
t command
> docker image ls # image id looks like "274cadba4412"
>
> # Run the ubuntu container and start a bash shell.
> # Replace <ubuntu_hirsute_image_id> with your ubuntu image id from the pr=
evious step.
> docker container run --rm -it --privileged <ubuntu_hirsute_image_id> /bin=
/bash
>
>
> # You should be inside the ubuntu container now and can run these Linux c=
ommands
> apt-get update # this is needed, otherwise the next command fails
>
> # This installs mount.nfs. Answer the two questions about geographic area=
 and city.
> # Ignore all the debconf error message (readline, dialog, frontend, etc)
> apt install -y nfs-common
>
> # execute mount commands
> mkdir /tmp/mnt1 /tmp/mnt2
> mount.nfs 1.1.1.1:/ /tmp/mnt1 &
> mount.nfs <accessible-nfs-host:path> /tmp/mnt2 &
> jobs  # shows both mounts are hung
>
> Thanks, Mike
>
>
> From: Michael Wakabayashi <mwakabayashi@vmware.com>
> Sent: Thursday, May 20, 2021 2:51 AM
> To: Olga Kornievskaia <aglo@umich.edu>
> Cc: linux-nfs@vger.kernel.org <linux-nfs@vger.kernel.org>
> Subject: Re: NFSv4: Mounting NFS server which is down, blocks all other N=
FS mounts on same machine
>
> Hi Orna,
>
> Thank you for looking.
>
> I spent a couple of hours trying to get various
> SystemTap NFS scripts working but mostly got errors.
>
> For example:
> > root@mikes-ubuntu-21-04:~/src/systemtap-scripts/tracepoints# stap nfs4_=
fsinfo.stp
> > semantic error: unable to find tracepoint variable '$status' (alternati=
ves: $$parms, $$vars, $task, $$name): identifier '$status' at nfs4_fsinfo.s=
tp:7:11
> >         source: terror =3D $status
> >                         ^
> > Pass 2: analysis failed.  [man error::pass2]
>
> If you have any stap scripts that work on Ubuntu
> that you'd like me to run or have pointers on how
> to setup my Ubuntu environment to run them
> successfully, please let me know and I can try again..
>
>
> Here's the call trace for the mount.nfs command
> mounting the bad NFS server/10.1.1.1:
>
> [Thu May 20 08:53:35 2021] task:mount.nfs       state:D stack:    0 pid:1=
3903 ppid: 13900 flags:0x00004000
> [Thu May 20 08:53:35 2021] Call Trace:
> [Thu May 20 08:53:35 2021]  ? rpc_init_task+0x150/0x150 [sunrpc]
> [Thu May 20 08:53:35 2021]  __schedule+0x23d/0x670
> [Thu May 20 08:53:35 2021]  ? rpc_init_task+0x150/0x150 [sunrpc]
> [Thu May 20 08:53:35 2021]  schedule+0x4f/0xc0
> [Thu May 20 08:53:35 2021]  rpc_wait_bit_killable+0x25/0xb0 [sunrpc]
> [Thu May 20 08:53:35 2021]  __wait_on_bit+0x33/0xa0
> [Thu May 20 08:53:35 2021]  ? call_reserveresult+0xa0/0xa0 [sunrpc]
> [Thu May 20 08:53:35 2021]  out_of_line_wait_on_bit+0x8d/0xb0
> [Thu May 20 08:53:35 2021]  ? var_wake_function+0x30/0x30
> [Thu May 20 08:53:35 2021]  __rpc_execute+0xd4/0x290 [sunrpc]
> [Thu May 20 08:53:35 2021]  rpc_execute+0x5e/0x80 [sunrpc]
> [Thu May 20 08:53:35 2021]  rpc_run_task+0x13d/0x180 [sunrpc]
> [Thu May 20 08:53:35 2021]  rpc_call_sync+0x51/0xa0 [sunrpc]
> [Thu May 20 08:53:35 2021]  rpc_create_xprt+0x177/0x1c0 [sunrpc]
> [Thu May 20 08:53:35 2021]  rpc_create+0x11f/0x220 [sunrpc]
> [Thu May 20 08:53:35 2021]  ? __memcg_kmem_charge+0x7d/0xf0
> [Thu May 20 08:53:35 2021]  ? _cond_resched+0x1a/0x50
> [Thu May 20 08:53:35 2021]  nfs_create_rpc_client+0x13a/0x180 [nfs]
> [Thu May 20 08:53:35 2021]  nfs4_init_client+0x205/0x290 [nfsv4]
> [Thu May 20 08:53:35 2021]  ? __fscache_acquire_cookie+0x10a/0x210 [fscac=
he]
> [Thu May 20 08:53:35 2021]  ? nfs_fscache_get_client_cookie+0xa9/0x120 [n=
fs]
> [Thu May 20 08:53:35 2021]  ? nfs_match_client+0x37/0x2a0 [nfs]
> [Thu May 20 08:53:35 2021]  nfs_get_client+0x14d/0x190 [nfs]
> [Thu May 20 08:53:35 2021]  nfs4_set_client+0xd3/0x120 [nfsv4]
> [Thu May 20 08:53:35 2021]  nfs4_init_server+0xf8/0x270 [nfsv4]
> [Thu May 20 08:53:35 2021]  nfs4_create_server+0x58/0xa0 [nfsv4]
> [Thu May 20 08:53:35 2021]  nfs4_try_get_tree+0x3a/0xc0 [nfsv4]
> [Thu May 20 08:53:35 2021]  nfs_get_tree+0x38/0x50 [nfs]
> [Thu May 20 08:53:35 2021]  vfs_get_tree+0x2a/0xc0
> [Thu May 20 08:53:35 2021]  do_new_mount+0x14b/0x1a0
> [Thu May 20 08:53:35 2021]  path_mount+0x1d4/0x4e0
> [Thu May 20 08:53:35 2021]  __x64_sys_mount+0x108/0x140
> [Thu May 20 08:53:35 2021]  do_syscall_64+0x38/0x90
> [Thu May 20 08:53:35 2021]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>
>
> Here's the call trace for the mount.nfs command
> mounting an available NFS server/10.188.76.67 (which was
> blocked by the first mount.nfs command above):
> [Thu May 20 08:53:35 2021] task:mount.nfs       state:D stack:    0 pid:1=
3910 ppid: 13907 flags:0x00004000
> [Thu May 20 08:53:35 2021] Call Trace:
> [Thu May 20 08:53:35 2021]  __schedule+0x23d/0x670
> [Thu May 20 08:53:35 2021]  schedule+0x4f/0xc0
> [Thu May 20 08:53:35 2021]  nfs_wait_client_init_complete+0x5a/0x90 [nfs]
> [Thu May 20 08:53:35 2021]  ? wait_woken+0x80/0x80
> [Thu May 20 08:53:35 2021]  nfs_match_client+0x1de/0x2a0 [nfs]
> [Thu May 20 08:53:35 2021]  ? pcpu_block_update_hint_alloc+0xcc/0x2d0
> [Thu May 20 08:53:35 2021]  nfs_get_client+0x62/0x190 [nfs]
> [Thu May 20 08:53:35 2021]  nfs4_set_client+0xd3/0x120 [nfsv4]
> [Thu May 20 08:53:35 2021]  nfs4_init_server+0xf8/0x270 [nfsv4]
> [Thu May 20 08:53:35 2021]  nfs4_create_server+0x58/0xa0 [nfsv4]
> [Thu May 20 08:53:35 2021]  nfs4_try_get_tree+0x3a/0xc0 [nfsv4]
> [Thu May 20 08:53:35 2021]  nfs_get_tree+0x38/0x50 [nfs]
> [Thu May 20 08:53:35 2021]  vfs_get_tree+0x2a/0xc0
> [Thu May 20 08:53:35 2021]  do_new_mount+0x14b/0x1a0
> [Thu May 20 08:53:35 2021]  path_mount+0x1d4/0x4e0
> [Thu May 20 08:53:35 2021]  __x64_sys_mount+0x108/0x140
> [Thu May 20 08:53:35 2021]  do_syscall_64+0x38/0x90
> [Thu May 20 08:53:35 2021]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>
> I've pasted the entire dmesg output here: https://nam04.safelinks.protect=
ion.outlook.com/?url=3Dhttps%3A%2F%2Fpastebin.com%2F90QJyAL9&amp;data=3D04%=
7C01%7Cmwakabayashi%40vmware.com%7C2759b06e70634987fce108d91b754e5f%7Cb3913=
8ca3cee4b4aa4d6cd83d9dd62f0%7C0%7C0%7C637571012932297691%7CUnknown%7CTWFpbG=
Zsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C=
1000&amp;sdata=3DxpENxRqSdn4aDPwB890%2Bh1RpB4dD2DfpnVGQeM6n0Io%3D&amp;reser=
ved=3D0
>
>
> This is the command I ran to mount an unreachable NFS server:
> date; time strace mount.nfs 10.1.1.1:/nopath /tmp/mnt.dead; date
> The strace log: https://nam04.safelinks.protection.outlook.com/?url=3Dhtt=
ps%3A%2F%2Fpastebin.com%2F5yVhm77u&amp;data=3D04%7C01%7Cmwakabayashi%40vmwa=
re.com%7C2759b06e70634987fce108d91b754e5f%7Cb39138ca3cee4b4aa4d6cd83d9dd62f=
0%7C0%7C0%7C637571012932297691%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAi=
LCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3D1uaPa3RDc=
R32%2Buh6NQd2F7wq5%2BvYZ0dnWcGve0bSj%2FQ%3D&amp;reserved=3D0
>
> This is the command I ran to mount the available NFS server:
> date; time strace mount.nfs 10.188.76.67:/ /tmp/mnt.alive ; date
> The strace log: https://nam04.safelinks.protection.outlook.com/?url=3Dhtt=
ps%3A%2F%2Fpastebin.com%2FkTimQ6vH&amp;data=3D04%7C01%7Cmwakabayashi%40vmwa=
re.com%7C2759b06e70634987fce108d91b754e5f%7Cb39138ca3cee4b4aa4d6cd83d9dd62f=
0%7C0%7C0%7C637571012932297691%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAi=
LCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3D1YwGfM0u1=
zQsWmOuZX6FJjYwlf3e01cMpJCDtK8JRI0%3D&amp;reserved=3D0
>
> The procedure:
> - run dmesg -C to clear dmesg logs
> - run mount.nfs on 10.1.1.1 (this IP address is down/not responding to pi=
ng) which hung
> - run mount.nfs on 10.188.76.67  which also hung
> - "echo t > /proc/sysrq-trigger" to dump the call traces for hung process=
es
> - dmesg -T > dmesg.log to save the dmesg logs
> - control-Z the mount.nfs command to 10.1.1.1
> - "kill -9 %1" in the terminal to kill the mount.nfs to 10.1.1.1
> - mount.nfs to 10.188.76.67 immediately mounts successfully
>   after the first mount is killed (we can see this by the timestamp in th=
e logs files)
>
>
> Thanks, Mike
>
>
>
> From: Olga Kornievskaia <aglo@umich.edu>
> Sent: Wednesday, May 19, 2021 12:15 PM
> To: Michael Wakabayashi <mwakabayashi@vmware.com>
> Cc: linux-nfs@vger.kernel.org <linux-nfs@vger.kernel.org>
> Subject: Re: NFSv4: Mounting NFS server which is down, blocks all other N=
FS mounts on same machine
>
> On Sun, May 16, 2021 at 11:18 PM Michael Wakabayashi
> <mwakabayashi@vmware.com> wrote:
> >
> > Hi,
> >
> > We're seeing what looks like an NFSv4 issue.
> >
> > Mounting an NFS server that is down (ping to this NFS server's IP addre=
ss does not respond) will block _all_ other NFS mount attempts even if the =
NFS servers are available and working properly (these subsequent mounts han=
g).
> >
> > If I kill the NFS mount process that's trying to mount the dead NFS ser=
ver, the NFS mounts that were blocked will immediately unblock and mount su=
ccessfully, which suggests the first mount command is blocking the other mo=
unt commands.
> >
> >
> > I verified this behavior using a newly built mount.nfs command from the=
 recent nfs-utils 2.5.3 package installed on a recent version of Ubuntu Clo=
ud Image 21.04:
> > * https://nam04.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fs=
ourceforge.net%2Fprojects%2Fnfs%2Ffiles%2Fnfs-utils%2F2.5.3%2F&amp;data=3D0=
4%7C01%7Cmwakabayashi%40vmware.com%7C2759b06e70634987fce108d91b754e5f%7Cb39=
138ca3cee4b4aa4d6cd83d9dd62f0%7C0%7C0%7C637571012932297691%7CUnknown%7CTWFp=
bGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%=
7C1000&amp;sdata=3DM6sP%2BH1XO2Ojhe0WOSCuFqDQDKJoOUdi2xR6dO5vkjQ%3D&amp;res=
erved=3D0
> > * https://nam04.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fc=
loud-images.ubuntu.com%2Freleases%2Fhirsute%2Frelease-20210513%2Fubuntu-21.=
04-server-cloudimg-amd64.ova&amp;data=3D04%7C01%7Cmwakabayashi%40vmware.com=
%7C2759b06e70634987fce108d91b754e5f%7Cb39138ca3cee4b4aa4d6cd83d9dd62f0%7C0%=
7C0%7C637571012932307646%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIj=
oiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3D1iJYjPv5CHpQ6VJ=
0DRPvHXvbiqQZgaE9pt7VeGNKq0U%3D&amp;reserved=3D0
> >
> >
> > The reason this looks like it is specific to NFSv4 is from the followin=
g output showing "vers=3D4.2":
> > > $ strace /sbin/mount.nfs <unreachable-IP-address>:/path /tmp/mnt
> > > [ ... cut ... ]
> > > mount("<unreadhable-IP-address>:/path", "/tmp/mnt", "nfs", 0, "vers=
=3D4.2,addr=3D<unreachable-IP-address>,clien"...^C^Z
> >
> > Also, if I try the same mount.nfs commands but specifying NFSv3, the mo=
unt to the dead NFS server hangs, but the mounts to the operational NFS ser=
vers do not block and mount successfully; this bug doesn't happen when usin=
g NFSv3.
> >
> >
> > We reported this issue under util-linux here:
> > https://nam04.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgit=
hub.com%2Fkarelzak%2Futil-linux%2Fissues%2F1309&amp;data=3D04%7C01%7Cmwakab=
ayashi%40vmware.com%7C2759b06e70634987fce108d91b754e5f%7Cb39138ca3cee4b4aa4=
d6cd83d9dd62f0%7C0%7C0%7C637571012932307646%7CUnknown%7CTWFpbGZsb3d8eyJWIjo=
iMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdat=
a=3D9N5DFtCJykN%2F3YigbajvZrBt6T2jpfGPyY6QujZDS2o%3D&amp;reserved=3D0
> > [mounting nfs server which is down blocks all other nfs mounts on same =
machine #1309]
> >
> > I also found an older bug on this mailing list that had similar symptom=
s (but could not tell if it was the same problem or not):
> > https://nam04.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpat=
chwork.kernel.org%2Fproject%2Flinux-nfs%2Fpatch%2F87vaori26c.fsf%40notabene=
.neil.brown.name%2F&amp;data=3D04%7C01%7Cmwakabayashi%40vmware.com%7C2759b0=
6e70634987fce108d91b754e5f%7Cb39138ca3cee4b4aa4d6cd83d9dd62f0%7C0%7C0%7C637=
571012932307646%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzI=
iLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DZ8agzK7vCLHVnY8yzJ23D3aB=
rWF0jsD7SYxwT3mtqjg%3D&amp;reserved=3D0
> > [[PATCH/RFC] NFSv4: don't let hanging mounts block other mounts]
> >
> > Thanks, Mike
>
> Hi Mike,
>
> This is not a helpful reply but I was curious if I could reproduce
> your issue but was not successful. I'm able to initiate a mount to an
> unreachable-IP-address which hangs and then do another mount to an
> existing server without issues. Ubuntu 21.04 seems to be 5.11 based so
> I tried upstream 5.11 and I tried the latest upstream nfs-utils
> (instead of what my distro has which was an older version).
>
> To debug, perhaps get an output of the nfs4 and sunrpc tracepoints.
> Or also get output from dmesg after doing =E2=80=9Cecho t >
> /proc/sysrq-trigger=E2=80=9D to see where the mounts are hanging.
