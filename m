Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC9F1369488
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Apr 2021 16:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbhDWOYG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 23 Apr 2021 10:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbhDWOYG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 23 Apr 2021 10:24:06 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 568B6C061574
        for <linux-nfs@vger.kernel.org>; Fri, 23 Apr 2021 07:23:30 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 2784E7291; Fri, 23 Apr 2021 10:23:29 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 2784E7291
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1619187809;
        bh=eHLY9fngVIilCsSLMt3AL64cUF5pJRzwzzB2Q2yhsIo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P0pKBoz10DEjwcfC8AqY5XPmzuYFpiRxdy2nZFKgTFh1yw/ygRU/v96VCLII3OeJ2
         Fm+Y2jSab6hQxW+5DFmCrimg2FCWnKTuvl6B3ZxHWLaAkNXow3DmJ4yYv6gS26xfGe
         EbLIgoSWF5fbCSIfsWZ7E2BPsHKsGDmG3XEeeRqQ=
Date:   Fri, 23 Apr 2021 10:23:29 -0400
From:   "J . Bruce Fields" <bfields@fieldses.org>
To:     Petr Vorel <pvorel@suse.cz>
Cc:     linux-nfs@vger.kernel.org, Steve Dickson <steved@redhat.com>,
        NeilBrown <neilb@suse.com>, Chuck Lever <chuck.lever@oracle.com>,
        Alexey Kodanev <alexey.kodanev@oracle.com>
Subject: Re: [RFC PATCH 1/1] mount.nfs: Fix mounting on tmpfs
Message-ID: <20210423142329.GB10457@fieldses.org>
References: <20210422191803.31511-1-pvorel@suse.cz>
 <20210422202334.GB25415@fieldses.org>
 <YIIuUPrlbBlr1ooD@pevik>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YIIuUPrlbBlr1ooD@pevik>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Apr 23, 2021 at 04:17:52AM +0200, Petr Vorel wrote:
> Hi,
> 
> > On Thu, Apr 22, 2021 at 09:18:03PM +0200, Petr Vorel wrote:
> > > LTP NFS tests (which use netns) fails on tmpfs since d4066486:
> 
> > > mount -t nfs -o proto=tcp,vers=4.2 10.0.0.2:/tmp/ltp.nfs01.nfs-4.2/LTP_nfs01.UF6gRZCy3O/4.2/tcp /tmp/ltp.nfs01.nfs-4.2/LTP_nfs01.UF6gRZCy3O/4.2/0
> > > mount.nfs: mounting 10.0.0.2:/tmp/ltp.nfs01.nfs-4.2/LTP_nfs01.UF6gRZCy3O/4.2/tcp failed, reason given by server: No such file or directory
> 
> > We should figure out the reason for the failure.  A network trace might
> > help.
> 
> Anything specific you're looking for?

Actually I was thinking of capturing the network traffic, something
like:
	tcpdump -s0 -wtmp.pcap -i<interface>

then try the mount, then kill tcpdump and look at tmp.pcap.

First, though, what's the output of "exportfs -v" on the server?

Note you need an "fsid=" option on tmpfs exports.

--b.

> 
> Doing full debug
> rpcdebug -m nfs -s all
> rpcdebug -m nfsd -s all
> rpcdebug -m rpc -s all
> 
> I see
> [13890.993127] nfsd_inet6addr_event: removed fd00:0001:0001:0001:0000:0000:0000:0002
> [13890.995428] nfsd_inet6addr_event: removed fe80:0000:0000:0000:1463:9fff:fea6:01b1
> [13891.002920] nfsd_inetaddr_event: removed 10.0.0.2
> [13891.007501] IPv6: ADDRCONF(NETDEV_CHANGE): ltp_ns_veth2: link becomes ready
> [13891.223432] NFS:   parsing nfs mount option 'source'
> [13891.225347] NFS:   parsing nfs mount option 'proto'
> [13891.227216] NFS:   parsing nfs mount option 'vers'
> [13891.228684] NFS:   parsing nfs mount option 'addr'
> [13891.229994] NFS:   parsing nfs mount option 'clientaddr'
> [13891.231326] NFS: MNTPATH: '/tmp/LTP_nfs01.lQghifD6NF/4.1/tcp'
> [13891.232923] --> nfs4_try_get_tree()
> [13891.235025] NFS: get client cookie (0x0000000013cf211e/0x0000000014b6df5b)
> [13891.237466] RPC:       set up xprt to 10.0.0.2 (port 2049) via tcp
> [13891.239618] RPC:       Couldn't create auth handle (flavor 390004)
> [13891.241556] nfs_create_rpc_client: cannot create RPC client. Error = -22
> [13891.243306] RPC:        destroy backchannel transport
> [13891.244017] RPC:       set up xprt to 10.0.0.2 (port 2049) via tcp
> [13891.244610] RPC:        backchannel list empty= true
> [13891.246232] RPC:       xs_connect scheduled xprt 000000005ddf4c3d
> [13891.247547] RPC:       xs_destroy xprt 00000000aeaed403
> [13891.250574] RPC:       xs_bind 0.0.0.0:873: ok (0)
> [13891.252225] RPC:       worker connecting xprt 000000005ddf4c3d via tcp to 10.0.0.2 (port 2049)
> [13891.254253] RPC:       xs_tcp_state_change client 000000005ddf4c3d...
> [13891.255693] RPC:       state 1 conn 0 dead 0 zapped 1 sk_shutdown 0
> [13891.257195] svc: server 000000007f0b7417, pool 0, transport 00000000f97f22bc, inuse=2
> [13891.258946] RPC:       000000005ddf4c3d connect status 115 connected 1 sock state 1
> [13891.260685] RPC:       xs_close xprt 00000000aeaed403
> [13891.260794] RPC:       xs_tcp_send_request(40) = 0
> [13891.263161] svc: server 000000007f0b7417, pool 0, transport 00000000f97f22bc, inuse=2
> [13891.264876] svc: svc_authenticate (0)
> [13891.264981] svc: server 00000000b4f0c1f0, pool 0, transport 00000000f97f22bc, inuse=3
> [13891.267954] svc: calling dispatcher
> [13891.270971] RPC:       xs_data_ready...
> [13891.273229] RPC:       setup backchannel transport
> [13891.274481] RPC:       adding req= 000000002ea0e13e
> [13891.275823] RPC:       setup backchannel transport done
> [13891.278253] svc: initialising pool 0 for NFSv4 callback
> [13891.279811] nfs_callback_create_svc: service created
> [13891.281138] NFS: create per-net callback data; net=f0000304
> 
> FYI tests are being done on network namespaces, thus there should be no real
> network issue. But I'll retest it on a real network. I admit that netns + tmpfs
> might be unrealistic scenario in practice.
> 
> Kind regards,
> Petr
> 
> > --b.
