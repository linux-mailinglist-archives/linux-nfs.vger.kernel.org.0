Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45B6E37FD9A
	for <lists+linux-nfs@lfdr.de>; Thu, 13 May 2021 20:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231825AbhEMSwy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 13 May 2021 14:52:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:43028 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230366AbhEMSwy (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 13 May 2021 14:52:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9BED7B124;
        Thu, 13 May 2021 18:51:43 +0000 (UTC)
Date:   Thu, 13 May 2021 20:51:41 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     NeilBrown <neilb@suse.de>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        linux-nfs@vger.kernel.org, Steve Dickson <steved@redhat.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Alexey Kodanev <alexey.kodanev@oracle.com>
Cc:     debian-kernel@lists.debian.org
Subject: Re: Re: [PATCH/RFC nfs-utils] Fix NFSv4 export of tmpfs filesystems.
Message-ID: <YJ11PY61nE+Njf1S@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20210422191803.31511-1-pvorel@suse.cz>
 <20210422202334.GB25415@fieldses.org>
 <YILQip3nAxhpXP9+@pevik>
 <162035212343.24322.12361160756597283121@noble.neil.brown.name>
 <YJURMBWOxqGK7rh1@pevik>
 <162087884172.5576.348023037121213464@noble.neil.brown.name>
 <YJ1yQ3fga7YGRRI9@pevik>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YJ1yQ3fga7YGRRI9@pevik>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Neil, all,

[Cc also Debian kernel folks as we're trying to fix issues which could hit them.
See https://lore.kernel.org/linux-nfs/YILQip3nAxhpXP9+@pevik/T/#t ]

> Hi Neil,

> > On Fri, 07 May 2021, Petr Vorel wrote:
> > > Hi Neil,

> > > > [[This is a proposed fix.  It seems to work.  I'd like
> > > >   some review comments before it is committed.
> > > >   Petr: it would be great if you could test it to confirm
> > > >   it actually works in your case.
> > > > ]]
> > > Thanks for a quick fix. It runs nicely in newer kernels (5.11.12-1-default
> > > openSUSE and 5.10.0-6-amd64 Debian). But it somehow fails on older ones
> > > (SLES 5.3.18-54-default heavily patched and 4.9.0-11-amd64).

> > > I have some problem on Debian with 4.9.0-11-amd64 fails on both tmpfs and ext4,
> > > others work fine (testing tmpfs, btrfs and ext4). But maybe I did something
> > > wrong during testing. I did:
> > > cp ./utils/mountd/mountd /usr/sbin/rpc.mountd
> > > systemctl restart nfs-mountd.service

> > That is the correct procedure.  It should work...
> Thanks for a confirmation.


> > > Failure is regardless I use new mount.nfs (master) or the original from
> > > Debian (1.3.3).

> > What error message do you get on failure? It might help to add "-v" to
> > the mount command to see more messages.
> +1. I'll add it to the tests (+ printing mount.nfs version).

> Here is debug info (when using nfs-utils 2.5.3 - master, with your patch):
> * NFSv3 on ext4 (OK)
> nfs01 1 TINFO: setup NFSv3, socket type tcp
> nfs01 1 TINFO: Mounting NFS: mount -v -t nfs -o proto=tcp,vers=3 10.0.0.2:/var/tmp/LTP_nfs01.14F4lC51P6/3/tcp /var/tmp/LTP_nfs01.14F4lC51P6/3/0
> mount.nfs: trying 10.0.0.2 prog 100003 vers 3 prot TCP port 2049
> mount.nfs: trying 10.0.0.2 prog 100005 vers 3 prot TCP port 58997
> mount.nfs: timeout set for Thu May 13 08:22:46 2021
> mount.nfs: trying text-based options 'proto=tcp,vers=3,addr=10.0.0.2'
> mount.nfs: prog 100003, trying vers=3, prot=6
> mount.nfs: prog 100005, trying vers=3, prot=6
> nfs01 1 TINFO: starting 'nfs01_open_files 10'
I'm sorry, this one is when running the original rpc.nfsd.
When running your patched, it fail (as I previously reported).

> * NFSv3 on tmpfs (OK)
> nfs01 1 TINFO: setup NFSv3, socket type tcp
> nfs01 1 TINFO: Mounting NFS: mount -v -t nfs -o proto=tcp,vers=3 10.0.0.2:/tmp/LTP_nfs01.oJEz2xd9ZI/3/tcp /tmp/LTP_nfs01.oJEz2xd9ZI/3/0
> mount.nfs: trying 10.0.0.2 prog 100003 vers 3 prot TCP port 2049
> mount.nfs: trying 10.0.0.2 prog 100005 vers 3 prot TCP port 58997
> mount.nfs: timeout set for Thu May 13 08:23:01 2021
> mount.nfs: trying text-based options 'proto=tcp,vers=3,addr=10.0.0.2'
> mount.nfs: prog 100003, trying vers=3, prot=6
> mount.nfs: prog 100005, trying vers=3, prot=6
> nfs01 1 TINFO: starting 'nfs01_open_files 10'
The same here.

> * NFSv4.1 on tmpfs (FAIL)
> nfs01 1 TINFO: setup NFSv4.1, socket type tcp
> nfs01 1 TINFO: Mounting NFS: mount -v -t nfs -o proto=tcp,vers=4.1 10.0.0.2:/tmp/LTP_nfs01.QnnFGEV4rs/4.1/tcp /tmp/LTP_nfs01.QnnFGEV4rs/4.1/0
> mount.nfs: mount(2): No such file or directory
> mount.nfs: mounting 10.0.0.2:/tmp/LTP_nfs01.QnnFGEV4rs/4.1/tcp failed, reason given by server: No such file or directory
> mount.nfs: timeout set for Thu May 13 08:23:02 2021
> mount.nfs: trying text-based options 'proto=tcp,vers=4.1,addr=10.0.0.2,clientaddr=10.0.0.1'
> nfs01 1 TBROK: mount command failed
> nfs01 1 TINFO: Cleaning up testcase

The failure has really something to do with rpcbind ("mount.nfs: portmap query
failed:"):
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
write(2, "mount.nfs: trying 10.0.0.2 prog "..., 66) = 66
socket(AF_INET, SOCK_STREAM, IPPROTO_TCP) = 5
fcntl(5, F_GETFL)                       = 0x2 (flags O_RDWR)
fcntl(5, F_SETFL, O_RDWR|O_NONBLOCK)    = 0
connect(5, {sa_family=AF_INET, sin_port=htons(37873), sin_addr=inet_addr("10.0.0.2")}, 16) = -1 EINPROGRESS (Operation now in progress)
select(6, NULL, [5], NULL, {tv_sec=10, tv_usec=0}) = 1 (out [5], left {tv_sec=9, tv_usec=999998})
getsockopt(5, SOL_SOCKET, SO_ERROR, [111], [4]) = 0
fcntl(5, F_SETFL, O_RDWR)               = 0
close(5)                                = 0
write(2, "mount.nfs: portmap query failed:"..., 79) = 79

Kind regards,
Petr

> > > strace looks nearly the same on tmpfs and ext4:

> > This shows mount.nfs connecting to rpcbind, sending a request, getting a
> > reply, and maybe looping around and trying again?

> > There doesn't seem to be anything kernel related that would affect
> > anything there so I cannot think why on older kernel would make a
> > difference.  Or an older rpcbind...
> Well, it uses 1.2.5-0.3+deb10u1, i.e. nearly the latest version (Steve released
> 1.2.6 3 days ago). And it's the same version as in openSUSE Tumbleweed where it
> works well.


> > Maybe I'll experiment on a SLE12 kernel.
> Thanks!

> > NeilBrown

> Kind regards,
> Petr
