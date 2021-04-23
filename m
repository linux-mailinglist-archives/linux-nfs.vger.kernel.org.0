Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A73B3697EB
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Apr 2021 19:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243190AbhDWRFV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 23 Apr 2021 13:05:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:34104 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229957AbhDWRFU (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 23 Apr 2021 13:05:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0341CADAA;
        Fri, 23 Apr 2021 17:04:43 +0000 (UTC)
Date:   Fri, 23 Apr 2021 19:04:41 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     "J . Bruce Fields" <bfields@fieldses.org>
Cc:     linux-nfs@vger.kernel.org, Steve Dickson <steved@redhat.com>,
        NeilBrown <neilb@suse.com>, Chuck Lever <chuck.lever@oracle.com>,
        Alexey Kodanev <alexey.kodanev@oracle.com>
Subject: Re: [RFC PATCH 1/1] mount.nfs: Fix mounting on tmpfs
Message-ID: <YIL+KWuPmgm8A82C@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20210422191803.31511-1-pvorel@suse.cz>
 <20210422202334.GB25415@fieldses.org>
 <YIIuUPrlbBlr1ooD@pevik>
 <20210423142329.GB10457@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210423142329.GB10457@fieldses.org>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Bruce,

> On Fri, Apr 23, 2021 at 04:17:52AM +0200, Petr Vorel wrote:
> > Hi,

> > > On Thu, Apr 22, 2021 at 09:18:03PM +0200, Petr Vorel wrote:
> > > > LTP NFS tests (which use netns) fails on tmpfs since d4066486:

> > > > mount -t nfs -o proto=tcp,vers=4.2 10.0.0.2:/tmp/ltp.nfs01.nfs-4.2/LTP_nfs01.UF6gRZCy3O/4.2/tcp /tmp/ltp.nfs01.nfs-4.2/LTP_nfs01.UF6gRZCy3O/4.2/0
> > > > mount.nfs: mounting 10.0.0.2:/tmp/ltp.nfs01.nfs-4.2/LTP_nfs01.UF6gRZCy3O/4.2/tcp failed, reason given by server: No such file or directory

> > > We should figure out the reason for the failure.  A network trace might
> > > help.

> > Anything specific you're looking for?

> Actually I was thinking of capturing the network traffic, something
> like:
> 	tcpdump -s0 -wtmp.pcap -i<interface>

> then try the mount, then kill tcpdump and look at tmp.pcap.

I don't see anything suspicious, can you please have a look?
https://gitlab.com/pevik/tmp/-/raw/master/nfs.v3.pcap
https://gitlab.com/pevik/tmp/-/raw/master/nfs.v4.pcap
https://gitlab.com/pevik/tmp/-/raw/master/nfs.v4.1.pcap
https://gitlab.com/pevik/tmp/-/raw/master/nfs.v4.2.pcap

tcpdump -s0 -iany host 10.0.0.1 and 10.0.0.2

> First, though, what's the output of "exportfs -v" on the server?
* v3 (the only working)
mount -t nfs -o proto=tcp,vers=3 10.0.0.2:/tmp/LTP_nfs01.S5dolLhIlD/3/tcp /tmp/LTP_nfs01.S5dolLhIlD/3/0

exportfs -v
/tmp/LTP_nfs01.S5dolLhIlD/3/tcp
		<world>(sync,wdelay,hide,no_subtree_check,fsid=6436,sec=sys,rw,secure,no_root_squash,no_all_squash)

* v4
mount -t nfs -o proto=tcp,vers=4 10.0.0.2:/tmp/LTP_nfs01.5yzuZYRSRl/4/tcp /tmp/LTP_nfs01.5yzuZYRSRl/4/0
mount.nfs: mounting 10.0.0.2:/tmp/LTP_nfs01.5yzuZYRSRl/4/tcp failed, reason given by server: No such file or directory

exportfs -v
/tmp/LTP_nfs01.5yzuZYRSRl/4/tcp
		<world>(sync,wdelay,hide,no_subtree_check,fsid=6695,sec=sys,rw,secure,no_root_squash,no_all_squash)

* v4.1
mount -t nfs -o proto=tcp,vers=4.1 10.0.0.2:/tmp/LTP_nfs01.xSWfcygtYM/4.1/tcp /tmp/LTP_nfs01.xSWfcygtYM/4.1/0
mount.nfs: mounting 10.0.0.2:/tmp/LTP_nfs01.xSWfcygtYM/4.1/tcp failed, reason given by server: No such file or directory

exportfs -v
/tmp/LTP_nfs01.xSWfcygtYM/4.1/tcp
		<world>(sync,wdelay,hide,no_subtree_check,fsid=6965,sec=sys,rw,secure,no_root_squash,no_all_squash)

* v4.2
mount -t nfs -o proto=tcp,vers=4.2 10.0.0.2:/tmp/LTP_nfs01.xkKpqpRikV/4.2/tcp /tmp/LTP_nfs01.xkKpqpRikV/4.2/0
mount.nfs: mounting 10.0.0.2:/tmp/LTP_nfs01.xkKpqpRikV/4.2/tcp failed, reason given by server: No such file or directory

exportfs -v
/tmp/LTP_nfs01.xkKpqpRikV/4.2/tcp
		<world>(sync,wdelay,hide,no_subtree_check,fsid=7239,sec=sys,rw,secure,no_root_squash,no_all_squash)


> Note you need an "fsid=" option on tmpfs exports.
Yes, the test uses PID based fsid: fsid=$$

> --b.

Thanks a lot for your time!

Kind regards,
Petr
