Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31AFF38D1A3
	for <lists+linux-nfs@lfdr.de>; Sat, 22 May 2021 00:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbhEUWkL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 21 May 2021 18:40:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbhEUWkL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 21 May 2021 18:40:11 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F32AC061574
        for <linux-nfs@vger.kernel.org>; Fri, 21 May 2021 15:38:46 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id z12so31179375ejw.0
        for <linux-nfs@vger.kernel.org>; Fri, 21 May 2021 15:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T0dXHtJslOmUtiZjL8qoRRTNLbhlsYASk+gsFZ2zw40=;
        b=h/xf+AUAhImGDiG6NBhoDvU1p2VFIjm+8Pz7wL3ir1QAXsqupPSkEvTSbc1ybUvq6y
         WTzpl6xN+YiEAxhRLD13T5TCvk6N7BqnbJ2cxEr5zmASclZqT2SRKako7e3RxLkQhpfS
         yAhlVOXO5/FnCW9tuXDJ5vzfHGnmNO7XPqPk4b14SUD20NGhbm0uFJI8KIoNWMDq1mql
         kQ8jms+wdFoykSP2XaOI171ndaqZmJQ/AXAGhuOfUP0S7I2U6rhnf1gE3DaQrMW3ST0k
         mg5ys46cCpmSbxKcIkwHMGoqJoVFZkb2pyouK6U1GERha8VUTeuLnApRxgKqPrOgn3hb
         OBnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T0dXHtJslOmUtiZjL8qoRRTNLbhlsYASk+gsFZ2zw40=;
        b=bP6xuFy5bJ2TkHIlMpSLwDn3cWxjB3xeq3BOhSbAQxXZYWTlU3miEJY62qJ2ESnTFH
         MKeiBavUThwgIiFB7ENmDJOe46SCRKwG35KxdqDUmD0f9SSp+2sstmRDXc7gnSGkdDTB
         yapgTQNy9ejRjs9j+ss83d0b6D7c1PlemAL71OLtUauKFlHhl/Lqb2QFlpIy/wSbxya6
         v0m7A8AwVMXXOhUp8IjVTZIIixkE5x6gyN2RzTP6vOE90YmZ4sJl8RdKO5V5+cOC1vRo
         jClJz0bab4Gm3f68nBwE3vQ3VY/mFD43Dy+vYzOjrsip/Hz4+y5APFJQm6khm+q2rtIQ
         pbJw==
X-Gm-Message-State: AOAM532522uW4vkZL+IRv4j/M+FR1V893C1K2b13sZ5aJ6m8uGpudHL+
        5q1MeKF28mSZ2faliVLOtHmZRqs2UfNk+ykv5co=
X-Google-Smtp-Source: ABdhPJwZhU+nXA1+Uq840g0goZfCLo+Rqxe8reOBo0b66QYTdQyViC3IwOZ9qCng0mSam/BK94MhbcST9L1e7usCUOk=
X-Received: by 2002:a17:906:584e:: with SMTP id h14mr12442128ejs.432.1621636724409;
 Fri, 21 May 2021 15:38:44 -0700 (PDT)
MIME-Version: 1.0
References: <CO1PR05MB810163D3FD8705AFF519F0B4B72D9@CO1PR05MB8101.namprd05.prod.outlook.com>
 <CAN-5tyGgWx6F2s=t+0UAJJZEAEfNnv+Sq8eeBbnQYocKOOK8Jg@mail.gmail.com>
 <6ae47edc-2d47-df9a-515a-be327a20131d@RedHat.com> <CO1PR05MB8101FD5E77B386A75786FF41B7299@CO1PR05MB8101.namprd05.prod.outlook.com>
 <CAN-5tyFVGexM_6RrkjJPfUPT5T4Z7OGk41gSKeQcoi9cLYb=eA@mail.gmail.com>
 <CO1PR05MB8101B1BB8D1CAA7EE642D8CEB7299@CO1PR05MB8101.namprd05.prod.outlook.com>
 <CAN-5tyEp+4_tiaqxuF7LoLUPt+OFn-C_dmeVVf-2Lse2RXvhqA@mail.gmail.com>
In-Reply-To: <CAN-5tyEp+4_tiaqxuF7LoLUPt+OFn-C_dmeVVf-2Lse2RXvhqA@mail.gmail.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Fri, 21 May 2021 18:38:32 -0400
Message-ID: <CAN-5tyExni7BcNkf0VxYdfFcydBhys3T8Y06PCHE81dZiPLg6w@mail.gmail.com>
Subject: Re: NFSv4: Mounting NFS server which is down, blocks all other NFS
 mounts on same machine
To:     Michael Wakabayashi <mwakabayashi@vmware.com>
Cc:     Steve Dickson <SteveD@redhat.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Content-Type: multipart/mixed; boundary="000000000000e9e89505c2deb815"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

--000000000000e9e89505c2deb815
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 21, 2021 at 5:06 PM Olga Kornievskaia <aglo@umich.edu> wrote:
>
> Hi Michael,
>
> On Fri, May 21, 2021 at 4:31 PM Michael Wakabayashi
> <mwakabayashi@vmware.com> wrote:
> >
> > Hi Olga,
> >
> > > But I would like to know  what's a legitimate reason for a machine to
> > > have a listening but not responsive port 2049
> >
> > The NFS server in this case was decommissioned and taken offline.
>
> You say that it's taken offline. If it's offline there shouldn't be
> anything listening on port 2049. I was only able to reproduce the
> problem when a client is able to send a SYN to the server and not
> getting a reply back. If the server is offline, there will always be a
> reply back (RST or something of the sorts). Client tries a bit but it
> never gets stuck in the rpc_execute() state because it would get a
> reply from the TCP layer. Your stack is where  there is no TCP reply
> from the server.
>

More on my explanation. I'm attaching 2 sets of tracepoints. 1 case is
"unreachable" (there is no machine with such IP 192.168.1.108 in my
case -- this is your example of somebody providing a bad name or
address. It will not prevent any other mounts from proceeding) and 2nd
case is "unresponsible" (192.168.1.68, something is listening on 2049
but not responding... it produced the stack trace you have provided.
It also demonstrates that mounts will succeed but only after things
timeout.

In the "unreachable" case, TCP is able to figure out its unreachable
pretty fast and timeout. The line to look for in the "unreachable.log"
file:
          <...>-67711   [001] .... 341123.253898: rpc_stats_latency:
task:12763@3 xid=3D0xb8a00f1d nfsv4 NULL backlog=3D0 rtt=3D0 execute=3D3082=
006

In case of the un-responsible server, TCP takes a lot longer to timeout:
           <...>-67806   [001] .... 341558.088633: rpc_stats_latency:
task:12814@1 xid=3D0x0f8fd007 nfsv4 NULL backlog=3D0 rtt=3D0
execute=3D181069428


There is a better way of using tracepoint but the quick (my preferred
way) way I turn on trace points is (as root) and then examining them:
cd /sys/kernel/debug/tracing
echo 1 > events/sunrpc/enable
echo 1 > events/nfs4/enable
cat trace_pipe > /tmp/trace_pipe.output

ctrl-c after test is done. Examine the output file.

I suggest that you get tracepoints from your system and see if it
behaves more like the "unresponsive" case than "unreachable" case by
comparing to the tracepoints I provided. The "unreachable" case: TCP
layer is failing us with -113 which is "host unreachable" so we give
up and go back to the NFS layer. The "unresponsive" case: TCP layer is
failing with -107 "not connected" so the RPC layer will retry several
times.

> > The user's automated tests was not updated and still trying to
> > mount this offline NFS server.
> >
> > We refer to this decommissioned server as being unreachable.
> > Maybe it's a difference in terminology, but for us if the IP address do=
es not
> > respond to ping (as in this case), we refer to it as being  unreachable=
.
> > Other tools use this same terminology. For example "fping":
> > $ fping 2.2.2.2
> > 2.2.2.2 is unreachable
> >
> > We can't really prevent users from making mistakes.
> > * Users will continue to accidentally mount decommissioned servers.
> > * Users will continue to mount the wrong IP addresses in their tests an=
d elsewhere.
> > And when these situation occur, it will block valid NFS mounts.
> >
> > Should I be prevented from mounting NFS shares because
> > someone else mistyped the NFS server name in their mount command?
> >
> > From a user perspective, it's not clear why a mount of a
> > decommissioned(and therefore down) NFS server is blocking
> > mounts of every other valid NFS server?
> > Shouldn't these valid NFS servers be allowed to mount?
> >
> > Thanks, Mike
> >
> >
> >
> >
> >
> > From: Olga Kornievskaia <aglo@umich.edu>
> > Sent: Friday, May 21, 2021 12:35 PM
> > To: Michael Wakabayashi <mwakabayashi@vmware.com>
> > Cc: Steve Dickson <SteveD@redhat.com>; linux-nfs@vger.kernel.org <linux=
-nfs@vger.kernel.org>
> > Subject: Re: NFSv4: Mounting NFS server which is down, blocks all other=
 NFS mounts on same machine
> >
> > On Fri, May 21, 2021 at 3:09 PM Michael Wakabayashi
> > <mwakabayashi@vmware.com> wrote:
> > >
> > > > This code came in with commit c156618e15101 which fixed a deadlock =
in nfs client initialization.
> > >
> > > > My conclusion is: an unresponsive server will block other mounts bu=
t only until timeout is reached.
> > >
> > > Hi Steve and Olga,
> > >
> > > We run multiple Kubernetes clusters.
> > > These clusters are composed of hundreds of Kubernetes nodes.
> > > Any of these nodes can NFS mount on behalf of the containers running =
on these nodes.
> > > We've seen several times in the past few months an NFS mount hang, an=
d then several hundred up to several thousand NFS mounts blocked by this hu=
ng NFS mount processes (we have many "testing" workloads that access NFS).
> > > Having several hundred NFS mounts blocked on a node causes the Kubern=
etes node to become unstable and severely degrades service.
> > >
> > > We did not expect a hung NFS mount to block every other NFS mount, es=
pecially when the other mounts are unrelated and otherwise working properly=
.
> > >
> > > Can this behavior be changed?
> >
> > Hi Michael,
> >
> > I'm not sure if the design can be changed. But I would like to know
> > what's a legitimate reason for a machine to have a listening but not
> > responsive port 2049 (I'm sorry I don't particularly care for the
> > explanation of "because this is how things currently work in
> > containers, Kubernetes"). Seems like the problem should be fixed
> > there. There is no issue if a mount goes to an IP that has nothing
> > listening on port 2049.
> >
> > Again I have no comments on the design change: or rather my comment
> > was I don't see a way. If you have 2 parallel clients initializing and
> > the goal is to have at most one client if both are the same, then I
> > don't see a way besides serializing it as it's done now.
> >
> > >
> > > Thanks, Mike
> > >
> > >
> > > ________________________________
> > > From: Steve Dickson <SteveD@RedHat.com>
> > > Sent: Thursday, May 20, 2021 11:42 AM
> > > To: Olga Kornievskaia <aglo@umich.edu>; Michael Wakabayashi <mwakabay=
ashi@vmware.com>
> > > Cc: linux-nfs@vger.kernel.org <linux-nfs@vger.kernel.org>
> > > Subject: Re: NFSv4: Mounting NFS server which is down, blocks all oth=
er NFS mounts on same machine
> > >
> > > Hey.
> > >
> > > On 5/19/21 3:15 PM, Olga Kornievskaia wrote:
> > > > On Sun, May 16, 2021 at 11:18 PM Michael Wakabayashi
> > > > <mwakabayashi@vmware.com> wrote:
> > > >>
> > > >> Hi,
> > > >>
> > > >> We're seeing what looks like an NFSv4 issue.
> > > >>
> > > >> Mounting an NFS server that is down (ping to this NFS server's IP =
address does not respond) will block _all_ other NFS mount attempts even if=
 the NFS servers are available and working properly (these subsequent mount=
s hang).
> > > >>
> > > >> If I kill the NFS mount process that's trying to mount the dead NF=
S server, the NFS mounts that were blocked will immediately unblock and mou=
nt successfully, which suggests the first mount command is blocking the oth=
er mount commands.
> > > >>
> > > >>
> > > >> I verified this behavior using a newly built mount.nfs command fro=
m the recent nfs-utils 2.5.3 package installed on a recent version of Ubunt=
u Cloud Image 21.04:
> > > >> * https://nam04.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Fsourceforge.net%2Fprojects%2Fnfs%2Ffiles%2Fnfs-utils%2F2.5.3%2F&amp;dat=
a=3D04%7C01%7Cmwakabayashi%40vmware.com%7C254806799e3f45388def08d91c8f9c45%=
7Cb39138ca3cee4b4aa4d6cd83d9dd62f0%7C0%7C0%7C637572225410414697%7CUnknown%7=
CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn=
0%3D%7C1000&amp;sdata=3DqWsYLeSLC0k89%2FHJGqhMlBnEvGR%2Bdqxve4n56bww%2Bnk%3=
D&amp;reserved=3D0
> > > >> * https://nam04.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Fcloud-images.ubuntu.com%2Freleases%2Fhirsute%2Frelease-20210513%2Fubunt=
u-21.04-server-cloudimg-amd64.ova&amp;data=3D04%7C01%7Cmwakabayashi%40vmwar=
e.com%7C254806799e3f45388def08d91c8f9c45%7Cb39138ca3cee4b4aa4d6cd83d9dd62f0=
%7C0%7C0%7C637572225410414697%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiL=
CJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3D5sHt34ZBts=
a7MjRP0RbymhbjOn%2FT5X5JUWvIQV93PUU%3D&amp;reserved=3D0
> > > >>
> > > >>
> > > >> The reason this looks like it is specific to NFSv4 is from the fol=
lowing output showing "vers=3D4.2":
> > > >>> $ strace /sbin/mount.nfs <unreachable-IP-address>:/path /tmp/mnt
> > > >>> [ ... cut ... ]
> > > >>> mount("<unreadhable-IP-address>:/path", "/tmp/mnt", "nfs", 0, "ve=
rs=3D4.2,addr=3D<unreachable-IP-address>,clien"...^C^Z
> > > >>
> > > >> Also, if I try the same mount.nfs commands but specifying NFSv3, t=
he mount to the dead NFS server hangs, but the mounts to the operational NF=
S servers do not block and mount successfully; this bug doesn't happen when=
 using NFSv3.
> > > >>
> > > >>
> > > >> We reported this issue under util-linux here:
> > > >> https://nam04.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%=
2Fgithub.com%2Fkarelzak%2Futil-linux%2Fissues%2F1309&amp;data=3D04%7C01%7Cm=
wakabayashi%40vmware.com%7C254806799e3f45388def08d91c8f9c45%7Cb39138ca3cee4=
b4aa4d6cd83d9dd62f0%7C0%7C0%7C637572225410414697%7CUnknown%7CTWFpbGZsb3d8ey=
JWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp=
;sdata=3DUrD%2FaBX2S4Qq7CrgltIc9lEzA8oEQQn0srMXtrq%2B6CE%3D&amp;reserved=3D=
0
> > > >> [mounting nfs server which is down blocks all other nfs mounts on =
same machine #1309]
> > > >>
> > > >> I also found an older bug on this mailing list that had similar sy=
mptoms (but could not tell if it was the same problem or not):
> > > >> https://nam04.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%=
2Fpatchwork.kernel.org%2Fproject%2Flinux-nfs%2Fpatch%2F87vaori26c.fsf%40not=
abene.neil.brown.name%2F&amp;data=3D04%7C01%7Cmwakabayashi%40vmware.com%7C2=
54806799e3f45388def08d91c8f9c45%7Cb39138ca3cee4b4aa4d6cd83d9dd62f0%7C0%7C0%=
7C637572225410414697%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2=
luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DlBAE9wZbykGQ8VPH6Ys=
AtuaIpMpDcAtqsxVNDV%2BaNTk%3D&amp;reserved=3D0
> > > >> [[PATCH/RFC] NFSv4: don't let hanging mounts block other mounts]
> > > >>
> > > >> Thanks, Mike
> > > >
> > > > Hi Mike,
> > > >
> > > > This is not a helpful reply but I was curious if I could reproduce
> > > > your issue but was not successful. I'm able to initiate a mount to =
an
> > > > unreachable-IP-address which hangs and then do another mount to an
> > > > existing server without issues. Ubuntu 21.04 seems to be 5.11 based=
 so
> > > > I tried upstream 5.11 and I tried the latest upstream nfs-utils
> > > > (instead of what my distro has which was an older version).
> > > >
> > > > To debug, perhaps get an output of the nfs4 and sunrpc tracepoints.
> > > > Or also get output from dmesg after doing =E2=80=9Cecho t >
> > > > /proc/sysrq-trigger=E2=80=9D to see where the mounts are hanging.
> > > >
> > > It looks like Mike is correct... The first process (mount 1.1.1.1:/mn=
t) is
> > > hung in trying the connection:
> > >
> > > PID: 3394   TASK: ffff9da8c42734c0  CPU: 0   COMMAND: "mount.nfs"
> > >  #0 [ffffb44780f638c8] __schedule at ffffffff82d7959d
> > >  #1 [ffffb44780f63950] schedule at ffffffff82d79f2b
> > >  #2 [ffffb44780f63968] rpc_wait_bit_killable at ffffffffc05265ce [sun=
rpc]
> > >  #3 [ffffb44780f63980] __wait_on_bit at ffffffff82d7a4ba
> > >  #4 [ffffb44780f639b8] out_of_line_wait_on_bit at ffffffff82d7a5a6
> > >  #5 [ffffb44780f63a00] __rpc_execute at ffffffffc052fc8a [sunrpc]
> > >  #6 [ffffb44780f63a48] rpc_execute at ffffffffc05305a2 [sunrpc]
> > >  #7 [ffffb44780f63a68] rpc_run_task at ffffffffc05164e4 [sunrpc]
> > >  #8 [ffffb44780f63aa8] rpc_call_sync at ffffffffc0516573 [sunrpc]
> > >  #9 [ffffb44780f63b00] rpc_create_xprt at ffffffffc051672e [sunrpc]
> > > #10 [ffffb44780f63b40] rpc_create at ffffffffc0516881 [sunrpc]
> > > #11 [ffffb44780f63be8] nfs_create_rpc_client at ffffffffc0972319 [nfs=
]
> > > #12 [ffffb44780f63c80] nfs4_init_client at ffffffffc0a17882 [nfsv4]
> > > #13 [ffffb44780f63d70] nfs4_set_client at ffffffffc0a16ef8 [nfsv4]
> > > #14 [ffffb44780f63de8] nfs4_create_server at ffffffffc0a188d8 [nfsv4]
> > > #15 [ffffb44780f63e60] nfs4_try_get_tree at ffffffffc0a0bf69 [nfsv4]
> > > #16 [ffffb44780f63e80] vfs_get_tree at ffffffff823b6068
> > > #17 [ffffb44780f63ea0] path_mount at ffffffff823e3d8f
> > > #18 [ffffb44780f63ef8] __x64_sys_mount at ffffffff823e45a3
> > > #19 [ffffb44780f63f38] do_syscall_64 at ffffffff82d6aa50
> > > #20 [ffffb44780f63f50] entry_SYSCALL_64_after_hwframe at ffffffff82e0=
007c
> > >
> > > The second mount is hung up in nfs_match_client()/nfs_wait_client_ini=
t_complete
> > > waiting for the first process to compile
> > > nfs_match_client:
> > >
> > >        /* If a client is still initializing then we need to wait */
> > >         if (clp->cl_cons_state > NFS_CS_READY) {
> > >             refcount_inc(&clp->cl_count);
> > >             spin_unlock(&nn->nfs_client_lock);
> > >             error =3D nfs_wait_client_init_complete(clp);
> > >             nfs_put_client(clp);
> > >             spin_lock(&nn->nfs_client_lock);
> > >             if (error < 0)
> > >                 return ERR_PTR(error);
> > >             goto again;
> > >         }
> > >
> > > This code came in with commit c156618e15101 which fixed
> > > a deadlock in nfs client initialization.
> > >
> > > steved.
> > >

--000000000000e9e89505c2deb815
Content-Type: application/x-gzip; name="unreachable.log.gz"
Content-Disposition: attachment; filename="unreachable.log.gz"
Content-Transfer-Encoding: base64
Content-ID: <f_koyw3c8y0>
X-Attachment-Id: f_koyw3c8y0

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
--000000000000e9e89505c2deb815
Content-Type: application/x-gzip; name="unresponsive.log.gz"
Content-Disposition: attachment; filename="unresponsive.log.gz"
Content-Transfer-Encoding: base64
Content-ID: <f_koyw3c9k1>
X-Attachment-Id: f_koyw3c9k1

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
SQEA
--000000000000e9e89505c2deb815--
