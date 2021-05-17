Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4E7B3830AF
	for <lists+linux-nfs@lfdr.de>; Mon, 17 May 2021 16:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237660AbhEQOaN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 17 May 2021 10:30:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:58872 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239420AbhEQO2c (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 17 May 2021 10:28:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 393F1AC86;
        Mon, 17 May 2021 14:27:14 +0000 (UTC)
Date:   Mon, 17 May 2021 16:27:12 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     NeilBrown <neilb@suse.de>
Cc:     "J . Bruce Fields" <bfields@fieldses.org>,
        linux-nfs@vger.kernel.org, Steve Dickson <steved@redhat.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Alexey Kodanev <alexey.kodanev@oracle.com>,
        debian-kernel@lists.debian.org
Subject: Re: Re: Re: [PATCH/RFC nfs-utils] Fix NFSv4 export of tmpfs
 filesystems.
Message-ID: <YKJ9QLCDRRSQ7EFB@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20210422191803.31511-1-pvorel@suse.cz>
 <20210422202334.GB25415@fieldses.org>
 <YILQip3nAxhpXP9+@pevik>
 <162035212343.24322.12361160756597283121@noble.neil.brown.name>
 <YJURMBWOxqGK7rh1@pevik>
 <162087884172.5576.348023037121213464@noble.neil.brown.name>
 <YJ1yQ3fga7YGRRI9@pevik>
 <YJ11PY61nE+Njf1S@pevik>
 <162122092561.6103.8867715057681755093@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162122092561.6103.8867715057681755093@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Neil,

> On Fri, 14 May 2021, Petr Vorel wrote:

> > The failure has really something to do with rpcbind ("mount.nfs: portmap query
> > failed:"):
> > rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
> > write(2, "mount.nfs: trying 10.0.0.2 prog "..., 66) = 66
> > socket(AF_INET, SOCK_STREAM, IPPROTO_TCP) = 5
> > fcntl(5, F_GETFL)                       = 0x2 (flags O_RDWR)
> > fcntl(5, F_SETFL, O_RDWR|O_NONBLOCK)    = 0
> > connect(5, {sa_family=AF_INET, sin_port=htons(37873), sin_addr=inet_addr("10.0.0.2")}, 16) = -1 EINPROGRESS (Operation now in progress)
> > select(6, NULL, [5], NULL, {tv_sec=10, tv_usec=0}) = 1 (out [5], left {tv_sec=9, tv_usec=999998})
> > getsockopt(5, SOL_SOCKET, SO_ERROR, [111], [4]) = 0
> > fcntl(5, F_SETFL, O_RDWR)               = 0
> > close(5)                                = 0
> > write(2, "mount.nfs: portmap query failed:"..., 79) = 79

> The "111" from getsockopt...SO_ERROR is ECONNREFUSED.  That suggests
> that rpcbind wasn't even running.

> This is different to the first strace you reported where mount.nfs
> successfully connected to rpcbind, sent and request and got a response,
> and then fail the mount.  That would happen if, for example, rpc.mountd
> wasn't running.

> So I think these failures are caused by some problem with restarting the
> services and aren't actually testing the code at all.

> Could you try again and make sure rpcbind and rpc.mountd are running on
> the server before attempting the mount?
I'm sorry, you're right, indeed rpc.mountd was not running and previously
probably by rpcbind not running. Not sure what exactly was wrong I'll test your
v2 probably only on openSUSE.

BTW apart from checking whether rpcbind is running I'd check only rpc.nfsd.
Or should be anything else tested? IMHO rpc.mountd, rpc.idmapd and rpc.statd
are nfs-server.service dependencies (the service, which starts also rpc.nfsd).

Kind regards,
Petr

> Thanks,
> NeilBrown

