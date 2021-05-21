Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D04438CF99
	for <lists+linux-nfs@lfdr.de>; Fri, 21 May 2021 23:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbhEUVH6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 21 May 2021 17:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbhEUVH5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 21 May 2021 17:07:57 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F42BC061574
        for <linux-nfs@vger.kernel.org>; Fri, 21 May 2021 14:06:33 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id o5so15797902edc.5
        for <linux-nfs@vger.kernel.org>; Fri, 21 May 2021 14:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=csR6KsT5Iq5HTFqVe4VPgVnscx3C6+/j5b/Epvw0lVM=;
        b=OPnkD8/22BIVkqJdshOddF9qfdeWiLXlmLe6oEb+0IoQzAUcfdw67tmghooG368Jyr
         yX/tM290/76/hwyMWUplcBhMiTCgMO1b0SpMA9tveB4u4bRrYxfTwFFpUcKoqXZ0LWAK
         DRfvF1G18JveHUOfMDXpRsTE1nqkGT/L3dp1jZWvh5pkoaS819ppfNbr69oFAfTMxPIo
         M3Cn3By91qzwjhoLTVvQU6mpWulOcL4Lj+Wr2IecjUC9jmyl6U0Ol9KWzKE3P+R49Ndo
         HHXxpuup5ZKK8XTXyZ3UU7bX2k2GgbEadSPd/x3BsR0kU6CKvXCYiDcTrTu27i/Mefsl
         Da2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=csR6KsT5Iq5HTFqVe4VPgVnscx3C6+/j5b/Epvw0lVM=;
        b=JVkce/QFNOtiAoZySI8rnI5G2PB8bch0MKTNUsAW/0Omjzs39BUInDNSWGwSIkaS5r
         5eCI0pfujl09+TqMEsKAoUX3RPi9qhbMLl14dHcpRsMWFGoD8w/MbZT3uPEWOPopKSmH
         ogDaOitMY63/cBSX6GKxh0yfE61ThQnZb3jqNHoW1cvJH90BM4hcl8o26G0BcyIPTcRw
         V/2gbE+C9ll6mf4/7A8t2HB/FBC59so99ZJyPLuk5qxhndwCsOeOpABlvb/6/a2wUJgb
         332//S9b8vShwJTeG/sNnXMRfC1bytJK28D2ude7/yoE6OD215ipMTA6RPSj7hbuyDub
         tfpw==
X-Gm-Message-State: AOAM532aHpCrNFwLgf4hJd5IcgJfbPyQmXcJPjAjFzFJTR0bCuUw4Ed+
        rWw+My4J1g6iDYxsWRpi1NleMfa8slPxVe9gz0SNls/9umA=
X-Google-Smtp-Source: ABdhPJybYHOKb8Hhymip0ezyio1dNrqNFQTOfYt1jCTRs1ZO6jLl3s+pvWbU7svze69ANA21o28+A7BjxQPjdbZrJaw=
X-Received: by 2002:a05:6402:3546:: with SMTP id f6mr13312035edd.267.1621631191648;
 Fri, 21 May 2021 14:06:31 -0700 (PDT)
MIME-Version: 1.0
References: <CO1PR05MB810163D3FD8705AFF519F0B4B72D9@CO1PR05MB8101.namprd05.prod.outlook.com>
 <CAN-5tyGgWx6F2s=t+0UAJJZEAEfNnv+Sq8eeBbnQYocKOOK8Jg@mail.gmail.com>
 <6ae47edc-2d47-df9a-515a-be327a20131d@RedHat.com> <CO1PR05MB8101FD5E77B386A75786FF41B7299@CO1PR05MB8101.namprd05.prod.outlook.com>
 <CAN-5tyFVGexM_6RrkjJPfUPT5T4Z7OGk41gSKeQcoi9cLYb=eA@mail.gmail.com> <CO1PR05MB8101B1BB8D1CAA7EE642D8CEB7299@CO1PR05MB8101.namprd05.prod.outlook.com>
In-Reply-To: <CO1PR05MB8101B1BB8D1CAA7EE642D8CEB7299@CO1PR05MB8101.namprd05.prod.outlook.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Fri, 21 May 2021 17:06:20 -0400
Message-ID: <CAN-5tyEp+4_tiaqxuF7LoLUPt+OFn-C_dmeVVf-2Lse2RXvhqA@mail.gmail.com>
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

Hi Michael,

On Fri, May 21, 2021 at 4:31 PM Michael Wakabayashi
<mwakabayashi@vmware.com> wrote:
>
> Hi Olga,
>
> > But I would like to know  what's a legitimate reason for a machine to
> > have a listening but not responsive port 2049
>
> The NFS server in this case was decommissioned and taken offline.

You say that it's taken offline. If it's offline there shouldn't be
anything listening on port 2049. I was only able to reproduce the
problem when a client is able to send a SYN to the server and not
getting a reply back. If the server is offline, there will always be a
reply back (RST or something of the sorts). Client tries a bit but it
never gets stuck in the rpc_execute() state because it would get a
reply from the TCP layer. Your stack is where  there is no TCP reply
from the server.

> The user's automated tests was not updated and still trying to
> mount this offline NFS server.
>
> We refer to this decommissioned server as being unreachable.
> Maybe it's a difference in terminology, but for us if the IP address does=
 not
> respond to ping (as in this case), we refer to it as being  unreachable.
> Other tools use this same terminology. For example "fping":
> $ fping 2.2.2.2
> 2.2.2.2 is unreachable
>
> We can't really prevent users from making mistakes.
> * Users will continue to accidentally mount decommissioned servers.
> * Users will continue to mount the wrong IP addresses in their tests and =
elsewhere.
> And when these situation occur, it will block valid NFS mounts.
>
> Should I be prevented from mounting NFS shares because
> someone else mistyped the NFS server name in their mount command?
>
> From a user perspective, it's not clear why a mount of a
> decommissioned(and therefore down) NFS server is blocking
> mounts of every other valid NFS server?
> Shouldn't these valid NFS servers be allowed to mount?
>
> Thanks, Mike
>
>
>
>
>
> From: Olga Kornievskaia <aglo@umich.edu>
> Sent: Friday, May 21, 2021 12:35 PM
> To: Michael Wakabayashi <mwakabayashi@vmware.com>
> Cc: Steve Dickson <SteveD@redhat.com>; linux-nfs@vger.kernel.org <linux-n=
fs@vger.kernel.org>
> Subject: Re: NFSv4: Mounting NFS server which is down, blocks all other N=
FS mounts on same machine
>
> On Fri, May 21, 2021 at 3:09 PM Michael Wakabayashi
> <mwakabayashi@vmware.com> wrote:
> >
> > > This code came in with commit c156618e15101 which fixed a deadlock in=
 nfs client initialization.
> >
> > > My conclusion is: an unresponsive server will block other mounts but =
only until timeout is reached.
> >
> > Hi Steve and Olga,
> >
> > We run multiple Kubernetes clusters.
> > These clusters are composed of hundreds of Kubernetes nodes.
> > Any of these nodes can NFS mount on behalf of the containers running on=
 these nodes.
> > We've seen several times in the past few months an NFS mount hang, and =
then several hundred up to several thousand NFS mounts blocked by this hung=
 NFS mount processes (we have many "testing" workloads that access NFS).
> > Having several hundred NFS mounts blocked on a node causes the Kubernet=
es node to become unstable and severely degrades service.
> >
> > We did not expect a hung NFS mount to block every other NFS mount, espe=
cially when the other mounts are unrelated and otherwise working properly.
> >
> > Can this behavior be changed?
>
> Hi Michael,
>
> I'm not sure if the design can be changed. But I would like to know
> what's a legitimate reason for a machine to have a listening but not
> responsive port 2049 (I'm sorry I don't particularly care for the
> explanation of "because this is how things currently work in
> containers, Kubernetes"). Seems like the problem should be fixed
> there. There is no issue if a mount goes to an IP that has nothing
> listening on port 2049.
>
> Again I have no comments on the design change: or rather my comment
> was I don't see a way. If you have 2 parallel clients initializing and
> the goal is to have at most one client if both are the same, then I
> don't see a way besides serializing it as it's done now.
>
> >
> > Thanks, Mike
> >
> >
> > ________________________________
> > From: Steve Dickson <SteveD@RedHat.com>
> > Sent: Thursday, May 20, 2021 11:42 AM
> > To: Olga Kornievskaia <aglo@umich.edu>; Michael Wakabayashi <mwakabayas=
hi@vmware.com>
> > Cc: linux-nfs@vger.kernel.org <linux-nfs@vger.kernel.org>
> > Subject: Re: NFSv4: Mounting NFS server which is down, blocks all other=
 NFS mounts on same machine
> >
> > Hey.
> >
> > On 5/19/21 3:15 PM, Olga Kornievskaia wrote:
> > > On Sun, May 16, 2021 at 11:18 PM Michael Wakabayashi
> > > <mwakabayashi@vmware.com> wrote:
> > >>
> > >> Hi,
> > >>
> > >> We're seeing what looks like an NFSv4 issue.
> > >>
> > >> Mounting an NFS server that is down (ping to this NFS server's IP ad=
dress does not respond) will block _all_ other NFS mount attempts even if t=
he NFS servers are available and working properly (these subsequent mounts =
hang).
> > >>
> > >> If I kill the NFS mount process that's trying to mount the dead NFS =
server, the NFS mounts that were blocked will immediately unblock and mount=
 successfully, which suggests the first mount command is blocking the other=
 mount commands.
> > >>
> > >>
> > >> I verified this behavior using a newly built mount.nfs command from =
the recent nfs-utils 2.5.3 package installed on a recent version of Ubuntu =
Cloud Image 21.04:
> > >> * https://nam04.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%=
2Fsourceforge.net%2Fprojects%2Fnfs%2Ffiles%2Fnfs-utils%2F2.5.3%2F&amp;data=
=3D04%7C01%7Cmwakabayashi%40vmware.com%7C254806799e3f45388def08d91c8f9c45%7=
Cb39138ca3cee4b4aa4d6cd83d9dd62f0%7C0%7C0%7C637572225410414697%7CUnknown%7C=
TWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0=
%3D%7C1000&amp;sdata=3DqWsYLeSLC0k89%2FHJGqhMlBnEvGR%2Bdqxve4n56bww%2Bnk%3D=
&amp;reserved=3D0
> > >> * https://nam04.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%=
2Fcloud-images.ubuntu.com%2Freleases%2Fhirsute%2Frelease-20210513%2Fubuntu-=
21.04-server-cloudimg-amd64.ova&amp;data=3D04%7C01%7Cmwakabayashi%40vmware.=
com%7C254806799e3f45388def08d91c8f9c45%7Cb39138ca3cee4b4aa4d6cd83d9dd62f0%7=
C0%7C0%7C637572225410414697%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJ=
QIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3D5sHt34ZBtsa7=
MjRP0RbymhbjOn%2FT5X5JUWvIQV93PUU%3D&amp;reserved=3D0
> > >>
> > >>
> > >> The reason this looks like it is specific to NFSv4 is from the follo=
wing output showing "vers=3D4.2":
> > >>> $ strace /sbin/mount.nfs <unreachable-IP-address>:/path /tmp/mnt
> > >>> [ ... cut ... ]
> > >>> mount("<unreadhable-IP-address>:/path", "/tmp/mnt", "nfs", 0, "vers=
=3D4.2,addr=3D<unreachable-IP-address>,clien"...^C^Z
> > >>
> > >> Also, if I try the same mount.nfs commands but specifying NFSv3, the=
 mount to the dead NFS server hangs, but the mounts to the operational NFS =
servers do not block and mount successfully; this bug doesn't happen when u=
sing NFSv3.
> > >>
> > >>
> > >> We reported this issue under util-linux here:
> > >> https://nam04.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2F=
github.com%2Fkarelzak%2Futil-linux%2Fissues%2F1309&amp;data=3D04%7C01%7Cmwa=
kabayashi%40vmware.com%7C254806799e3f45388def08d91c8f9c45%7Cb39138ca3cee4b4=
aa4d6cd83d9dd62f0%7C0%7C0%7C637572225410414697%7CUnknown%7CTWFpbGZsb3d8eyJW=
IjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;s=
data=3DUrD%2FaBX2S4Qq7CrgltIc9lEzA8oEQQn0srMXtrq%2B6CE%3D&amp;reserved=3D0
> > >> [mounting nfs server which is down blocks all other nfs mounts on sa=
me machine #1309]
> > >>
> > >> I also found an older bug on this mailing list that had similar symp=
toms (but could not tell if it was the same problem or not):
> > >> https://nam04.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2F=
patchwork.kernel.org%2Fproject%2Flinux-nfs%2Fpatch%2F87vaori26c.fsf%40notab=
ene.neil.brown.name%2F&amp;data=3D04%7C01%7Cmwakabayashi%40vmware.com%7C254=
806799e3f45388def08d91c8f9c45%7Cb39138ca3cee4b4aa4d6cd83d9dd62f0%7C0%7C0%7C=
637572225410414697%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2lu=
MzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DlBAE9wZbykGQ8VPH6YsAt=
uaIpMpDcAtqsxVNDV%2BaNTk%3D&amp;reserved=3D0
> > >> [[PATCH/RFC] NFSv4: don't let hanging mounts block other mounts]
> > >>
> > >> Thanks, Mike
> > >
> > > Hi Mike,
> > >
> > > This is not a helpful reply but I was curious if I could reproduce
> > > your issue but was not successful. I'm able to initiate a mount to an
> > > unreachable-IP-address which hangs and then do another mount to an
> > > existing server without issues. Ubuntu 21.04 seems to be 5.11 based s=
o
> > > I tried upstream 5.11 and I tried the latest upstream nfs-utils
> > > (instead of what my distro has which was an older version).
> > >
> > > To debug, perhaps get an output of the nfs4 and sunrpc tracepoints.
> > > Or also get output from dmesg after doing =E2=80=9Cecho t >
> > > /proc/sysrq-trigger=E2=80=9D to see where the mounts are hanging.
> > >
> > It looks like Mike is correct... The first process (mount 1.1.1.1:/mnt)=
 is
> > hung in trying the connection:
> >
> > PID: 3394   TASK: ffff9da8c42734c0  CPU: 0   COMMAND: "mount.nfs"
> >  #0 [ffffb44780f638c8] __schedule at ffffffff82d7959d
> >  #1 [ffffb44780f63950] schedule at ffffffff82d79f2b
> >  #2 [ffffb44780f63968] rpc_wait_bit_killable at ffffffffc05265ce [sunrp=
c]
> >  #3 [ffffb44780f63980] __wait_on_bit at ffffffff82d7a4ba
> >  #4 [ffffb44780f639b8] out_of_line_wait_on_bit at ffffffff82d7a5a6
> >  #5 [ffffb44780f63a00] __rpc_execute at ffffffffc052fc8a [sunrpc]
> >  #6 [ffffb44780f63a48] rpc_execute at ffffffffc05305a2 [sunrpc]
> >  #7 [ffffb44780f63a68] rpc_run_task at ffffffffc05164e4 [sunrpc]
> >  #8 [ffffb44780f63aa8] rpc_call_sync at ffffffffc0516573 [sunrpc]
> >  #9 [ffffb44780f63b00] rpc_create_xprt at ffffffffc051672e [sunrpc]
> > #10 [ffffb44780f63b40] rpc_create at ffffffffc0516881 [sunrpc]
> > #11 [ffffb44780f63be8] nfs_create_rpc_client at ffffffffc0972319 [nfs]
> > #12 [ffffb44780f63c80] nfs4_init_client at ffffffffc0a17882 [nfsv4]
> > #13 [ffffb44780f63d70] nfs4_set_client at ffffffffc0a16ef8 [nfsv4]
> > #14 [ffffb44780f63de8] nfs4_create_server at ffffffffc0a188d8 [nfsv4]
> > #15 [ffffb44780f63e60] nfs4_try_get_tree at ffffffffc0a0bf69 [nfsv4]
> > #16 [ffffb44780f63e80] vfs_get_tree at ffffffff823b6068
> > #17 [ffffb44780f63ea0] path_mount at ffffffff823e3d8f
> > #18 [ffffb44780f63ef8] __x64_sys_mount at ffffffff823e45a3
> > #19 [ffffb44780f63f38] do_syscall_64 at ffffffff82d6aa50
> > #20 [ffffb44780f63f50] entry_SYSCALL_64_after_hwframe at ffffffff82e000=
7c
> >
> > The second mount is hung up in nfs_match_client()/nfs_wait_client_init_=
complete
> > waiting for the first process to compile
> > nfs_match_client:
> >
> >        /* If a client is still initializing then we need to wait */
> >         if (clp->cl_cons_state > NFS_CS_READY) {
> >             refcount_inc(&clp->cl_count);
> >             spin_unlock(&nn->nfs_client_lock);
> >             error =3D nfs_wait_client_init_complete(clp);
> >             nfs_put_client(clp);
> >             spin_lock(&nn->nfs_client_lock);
> >             if (error < 0)
> >                 return ERR_PTR(error);
> >             goto again;
> >         }
> >
> > This code came in with commit c156618e15101 which fixed
> > a deadlock in nfs client initialization.
> >
> > steved.
> >
