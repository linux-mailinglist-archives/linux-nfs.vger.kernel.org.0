Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 584EF37634C
	for <lists+linux-nfs@lfdr.de>; Fri,  7 May 2021 12:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235501AbhEGKHo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 7 May 2021 06:07:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:60722 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235363AbhEGKHn (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 7 May 2021 06:07:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 91BCFAE42;
        Fri,  7 May 2021 10:06:42 +0000 (UTC)
Date:   Fri, 7 May 2021 12:06:40 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     NeilBrown <neilb@suse.de>
Cc:     "J . Bruce Fields" <bfields@fieldses.org>,
        linux-nfs@vger.kernel.org, Steve Dickson <steved@redhat.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Alexey Kodanev <alexey.kodanev@oracle.com>
Subject: Re: [PATCH/RFC nfs-utils] Fix NFSv4 export of tmpfs filesystems.
Message-ID: <YJURMBWOxqGK7rh1@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20210422191803.31511-1-pvorel@suse.cz>
 <20210422202334.GB25415@fieldses.org>
 <YILQip3nAxhpXP9+@pevik>
 <162035212343.24322.12361160756597283121@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162035212343.24322.12361160756597283121@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Neil,

> [[This is a proposed fix.  It seems to work.  I'd like
>   some review comments before it is committed.
>   Petr: it would be great if you could test it to confirm
>   it actually works in your case.
> ]]
Thanks for a quick fix. It runs nicely in newer kernels (5.11.12-1-default
openSUSE and 5.10.0-6-amd64 Debian). But it somehow fails on older ones
(SLES 5.3.18-54-default heavily patched and 4.9.0-11-amd64).

I have some problem on Debian with 4.9.0-11-amd64 fails on both tmpfs and ext4,
others work fine (testing tmpfs, btrfs and ext4). But maybe I did something
wrong during testing. I did:
cp ./utils/mountd/mountd /usr/sbin/rpc.mountd
systemctl restart nfs-mountd.service

Failure is regardless I use new mount.nfs (master) or the original from
Debian (1.3.3).

strace looks nearly the same on tmpfs and ext4:
socket(AF_INET, SOCK_STREAM, IPPROTO_TCP) = 5
fcntl(5, F_GETFL)                       = 0x2 (flags O_RDWR)
fcntl(5, F_SETFL, O_RDWR|O_NONBLOCK)    = 0
connect(5, {sa_family=AF_INET, sin_port=htons(111), sin_addr=inet_addr("10.0.0.2")}, 16) = -1 EINPROGRESS (Operation now in progress)
select(6, NULL, [5], NULL, {tv_sec=10, tv_usec=0}) = 1 (out [5], left {tv_sec=9, tv_usec=999997})
getsockopt(5, SOL_SOCKET, SO_ERROR, [0], [4]) = 0
fcntl(5, F_SETFL, O_RDWR)               = 0
rt_sigprocmask(SIG_SETMASK, ~[RTMIN RT_1], [], 8) = 0
getpeername(5, {sa_family=AF_INET, sin_port=htons(111), sin_addr=inet_addr("10.0.0.2")}, [128->16]) = 0
getsockname(5, {sa_family=AF_INET, sin_port=htons(54140), sin_addr=inet_addr("10.0.0.1")}, [128->16]) = 0
getsockopt(5, SOL_SOCKET, SO_TYPE, [1], [4]) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
getpid()                                = 920
rt_sigprocmask(SIG_SETMASK, ~[RTMIN RT_1], [], 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_SETMASK, ~[RTMIN RT_1], [], 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_SETMASK, ~[RTMIN RT_1], [], 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_SETMASK, ~[RTMIN RT_1], [], 8) = 0
write(5, "\200\0\0008bZ\360\303\0\0\0\0\0\0\0\2\0\1\206\240\0\0\0\2\0\0\0\3\0\0\0\0"..., 60) = 60
poll([{fd=5, events=POLLIN}], 1, 9999)  = 1 ([{fd=5, revents=POLLIN}])
read(5, "\200\0\0\34bZ\360\303\0\0\0\1\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\10\1", 65536) = 32
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_SETMASK, ~[RTMIN RT_1], [], 8) = 0
close(5)                                = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
socket(AF_INET, SOCK_STREAM, IPPROTO_TCP) = 5
fcntl(5, F_GETFL)                       = 0x2 (flags O_RDWR)
fcntl(5, F_SETFL, O_RDWR|O_NONBLOCK)    = 0

Kind regards,
Petr
