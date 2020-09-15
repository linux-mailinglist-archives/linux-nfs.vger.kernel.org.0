Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 427BD26B838
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Sep 2020 02:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbgIPAjd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 15 Sep 2020 20:39:33 -0400
Received: from cerberus.halldom.com ([79.135.97.241]:53025 "EHLO
        cerberus.halldom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbgIONHC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 15 Sep 2020 09:07:02 -0400
Received: from ceres.halldom.com ([79.135.97.244]:65112)
        by cerberus.halldom.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <linux-nfs@gmch.uk>)
        id 1kIAf6-000JBD-81
        for linux-nfs@vger.kernel.org; Tue, 15 Sep 2020 14:06:20 +0100
Subject: Re: mount.nfs4 and logging
To:     linux-nfs@vger.kernel.org
References: <S1725851AbgIKKt5/20200911104957Z+185@vger.kernel.org>
 <a38a1249-c570-9069-a498-5e17d85a418a@gmch.uk>
 <f06f86ef-08bd-3974-3d92-1fbda700cc11@RedHat.com>
From:   Chris Hall <linux-nfs@gmch.uk>
Message-ID: <f7b9c8b4-29a6-2f28-b1d9-739c546fd557@gmch.uk>
Date:   Tue, 15 Sep 2020 14:06:23 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <f06f86ef-08bd-3974-3d92-1fbda700cc11@RedHat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 14/09/2020 19:30, Steve Dickson wrote:
> Hello,
> 
> On 9/11/20 7:45 AM, Chris Hall wrote:

>> I have a client and server configured for nfs4 only.

> Would you mind sharing this configuration? Privately if
> that works better...

The client /etc/nfsmount.conf has:

   [ NFSMount_Global_Options ]
   Defaultvers=4
   Nfsvers=4
   Defaultproto=tcp
   Proto=tcp

and (now, see below) nothing else.

FWIW, I guess setting the 'Defaultvers' and 'Defaultproto' is 
redundant... but does not appear to stop anything from working.

Also FWIW, I gather that this is configuration for the client-side 
'mount' of nfs exports, *only*.  I suppose it should be obvious that 
this has absolutely nothing to do with configuring (server-side) 
'mountd'.  Speaking as a fully paid up moron-in-a-hurry, it has taken me 
a while to work that out :-(  [I suggest that the comments in the .conf 
files and the man-page could say that nfs.conf is server-side and 
nfsmount.conf is client-side -- just a few words, for the avoidance of 
doubt.]

The server /etc/nfs.conf has only:

   [nfsd]
   debug=0
   threads=8
   host=cerberus2
   port=1001
   # grace-time=90
   # lease-time=90
   udp=n
   tcp=y
   vers2=n
   vers3=n
   vers4=y
   vers4.0=y
   vers4.1=y
   vers4.2=y

I wish I knew whether the 'vers4.X' settings make the slightest 
difference.  This server is my firewall, hence the funky port number.

> I'm thinking that is a good direction to go towards
> so maybe we make this configuration the default??

I don't use nfs very much, but every time I have tangled with it I have 
come way limping :-(

Given that NFSv4 is going on 20 years old now, I do wonder why the 
earlier versions are not treated a "legacy".  When trying to discover 
how to configure and use nfs I find I am still wading through stuff 
which does not apply to NFSv4.  Much of what the "wisdom of the 
Internet" has to offer seems firmly routed in the past, and often NFSv4 
is describe in terms of its difference from NFSv3 and v2.

For example: I run nfs on my firewall machine so that I can configure it 
from elsewhere on the network.  Naturally, the firewall machine is 
firmly wrapped so that it may only be accessed by particular machines 
inside the network.  I also try to ensure that the absolute minimum 
number of daemons are running and the absolute minumum number of ports 
are open.  In that context, (a) is there a way to persuade 'systemctl 
start nfs-service' to be "nfs4 only", and to *not* start 'rpcbind' (and 
*not* open port 111), and (b) are rpc.idmapd, rpc.mountd and rpc.statd 
required for nfs4 ?  (ie, is nfsdcld sufficient ?)

>> The configuration used to work.
>>
>> I have just upgraded from Fedora 31 to 32 on the client.  I now get:
>>
>>    # mount /foo
>>    mount.nfs4: Protocol not supported

> I've been trying to keep the versions the same... hopefully
> nothing has broken in f31... ;-(

Rest easy: my problem was entirely self inflicted -- it had nothing 
directly to do with the upgrade from Fedora 31 to 32.

Since the client 'mount' and 'mount.nfs4' were not even attempting to 
speak to the server, I downloaded the source and the debug symbols and 
had a go at it with strace and gdb...

...and discovered that I had caused the problem by setting:

   mountproto=tcp
   mountvers=4

in /etc/nfsmount.conf at the client end.  [Full disclosure: I am 
building a replacement for the server and was reviewing all 
configuration at both ends, updating Fedora all round and generally 
tidying up.]

It turns out that mount.nfs4 takes a dim view of the existence of these 
settings and declines to do the mount(2) call; instead it sets 
errno=EPROTONOSUPPORT and returns as if the mount(2) had failed.  [See 
nfs_do_mount_v4() in stropts.c of utils/mount/.  I note in passing that 
it worries about "mounthost", "mountaddr", "mountvers" and "mountproto", 
where "mountaddr" is not mentioned in the man-page for nfs.  But it does 
not worry about "mountport", which is mentioned in the man-page.]

Having checked carefully, I now know that mountport, mountproto, 
mounthost and mountvers are all "Options for NFS versions 2 and 3 only". 
  But I don't know if their presence with 'nfsvers=4' would cause 
mount(2) to fail.

In any case, frankly, I think that mount is being singularly obtuse. 
Since it knows that these options do not apply, it could IMHO simply 
discard them.  If that's a step too far, it could produce a rather more 
informative message -- in particular *not* the standard system message 
for EPROTONOSUPPORT, which a quick search of POSIX.1-2017 tells me is 
returned only by socket() and socketpair() !

Thanks,

Chris
