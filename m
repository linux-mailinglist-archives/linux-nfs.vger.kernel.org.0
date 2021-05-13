Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5F8D37FD53
	for <lists+linux-nfs@lfdr.de>; Thu, 13 May 2021 20:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231479AbhEMSkM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 13 May 2021 14:40:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:36452 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231361AbhEMSkM (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 13 May 2021 14:40:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1DC59AFC2;
        Thu, 13 May 2021 18:39:01 +0000 (UTC)
Date:   Thu, 13 May 2021 20:38:59 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     NeilBrown <neilb@suse.de>
Cc:     "J . Bruce Fields" <bfields@fieldses.org>,
        linux-nfs@vger.kernel.org, Steve Dickson <steved@redhat.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Alexey Kodanev <alexey.kodanev@oracle.com>
Subject: Re: Re: [PATCH/RFC nfs-utils] Fix NFSv4 export of tmpfs filesystems.
Message-ID: <YJ1yQ3fga7YGRRI9@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20210422191803.31511-1-pvorel@suse.cz>
 <20210422202334.GB25415@fieldses.org>
 <YILQip3nAxhpXP9+@pevik>
 <162035212343.24322.12361160756597283121@noble.neil.brown.name>
 <YJURMBWOxqGK7rh1@pevik>
 <162087884172.5576.348023037121213464@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162087884172.5576.348023037121213464@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Neil,

> On Fri, 07 May 2021, Petr Vorel wrote:
> > Hi Neil,

> > > [[This is a proposed fix.  It seems to work.  I'd like
> > >   some review comments before it is committed.
> > >   Petr: it would be great if you could test it to confirm
> > >   it actually works in your case.
> > > ]]
> > Thanks for a quick fix. It runs nicely in newer kernels (5.11.12-1-default
> > openSUSE and 5.10.0-6-amd64 Debian). But it somehow fails on older ones
> > (SLES 5.3.18-54-default heavily patched and 4.9.0-11-amd64).

> > I have some problem on Debian with 4.9.0-11-amd64 fails on both tmpfs and ext4,
> > others work fine (testing tmpfs, btrfs and ext4). But maybe I did something
> > wrong during testing. I did:
> > cp ./utils/mountd/mountd /usr/sbin/rpc.mountd
> > systemctl restart nfs-mountd.service

> That is the correct procedure.  It should work...
Thanks for a confirmation.


> > Failure is regardless I use new mount.nfs (master) or the original from
> > Debian (1.3.3).

> What error message do you get on failure? It might help to add "-v" to
> the mount command to see more messages.
+1. I'll add it to the tests (+ printing mount.nfs version).

Here is debug info (when using nfs-utils 2.5.3 - master, with your patch):
* NFSv3 on ext4 (OK)
nfs01 1 TINFO: setup NFSv3, socket type tcp
nfs01 1 TINFO: Mounting NFS: mount -v -t nfs -o proto=tcp,vers=3 10.0.0.2:/var/tmp/LTP_nfs01.14F4lC51P6/3/tcp /var/tmp/LTP_nfs01.14F4lC51P6/3/0
mount.nfs: trying 10.0.0.2 prog 100003 vers 3 prot TCP port 2049
mount.nfs: trying 10.0.0.2 prog 100005 vers 3 prot TCP port 58997
mount.nfs: timeout set for Thu May 13 08:22:46 2021
mount.nfs: trying text-based options 'proto=tcp,vers=3,addr=10.0.0.2'
mount.nfs: prog 100003, trying vers=3, prot=6
mount.nfs: prog 100005, trying vers=3, prot=6
nfs01 1 TINFO: starting 'nfs01_open_files 10'

* NFSv3 on tmpfs (OK)
nfs01 1 TINFO: setup NFSv3, socket type tcp
nfs01 1 TINFO: Mounting NFS: mount -v -t nfs -o proto=tcp,vers=3 10.0.0.2:/tmp/LTP_nfs01.oJEz2xd9ZI/3/tcp /tmp/LTP_nfs01.oJEz2xd9ZI/3/0
mount.nfs: trying 10.0.0.2 prog 100003 vers 3 prot TCP port 2049
mount.nfs: trying 10.0.0.2 prog 100005 vers 3 prot TCP port 58997
mount.nfs: timeout set for Thu May 13 08:23:01 2021
mount.nfs: trying text-based options 'proto=tcp,vers=3,addr=10.0.0.2'
mount.nfs: prog 100003, trying vers=3, prot=6
mount.nfs: prog 100005, trying vers=3, prot=6
nfs01 1 TINFO: starting 'nfs01_open_files 10'

* NFSv4.1 on tmpfs (FAIL)
nfs01 1 TINFO: setup NFSv4.1, socket type tcp
nfs01 1 TINFO: Mounting NFS: mount -v -t nfs -o proto=tcp,vers=4.1 10.0.0.2:/tmp/LTP_nfs01.QnnFGEV4rs/4.1/tcp /tmp/LTP_nfs01.QnnFGEV4rs/4.1/0
mount.nfs: mount(2): No such file or directory
mount.nfs: mounting 10.0.0.2:/tmp/LTP_nfs01.QnnFGEV4rs/4.1/tcp failed, reason given by server: No such file or directory
mount.nfs: timeout set for Thu May 13 08:23:02 2021
mount.nfs: trying text-based options 'proto=tcp,vers=4.1,addr=10.0.0.2,clientaddr=10.0.0.1'
nfs01 1 TBROK: mount command failed
nfs01 1 TINFO: Cleaning up testcase

> > strace looks nearly the same on tmpfs and ext4:

> This shows mount.nfs connecting to rpcbind, sending a request, getting a
> reply, and maybe looping around and trying again?

> There doesn't seem to be anything kernel related that would affect
> anything there so I cannot think why on older kernel would make a
> difference.  Or an older rpcbind...
Well, it uses 1.2.5-0.3+deb10u1, i.e. nearly the latest version (Steve released
1.2.6 3 days ago). And it's the same version as in openSUSE Tumbleweed where it
works well.


> Maybe I'll experiment on a SLE12 kernel.
Thanks!

> NeilBrown

Kind regards,
Petr
