Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64FCF3E509E
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Aug 2021 03:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237225AbhHJB3V (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 9 Aug 2021 21:29:21 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:51234 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237220AbhHJB3S (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 9 Aug 2021 21:29:18 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B8F0420052;
        Tue, 10 Aug 2021 01:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1628558936; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IlE4hxH1OAZHv4daM+CU4Nw1iiAiN07ttV2IbAeGNfk=;
        b=WMgxgyYzDPibEtBH7Hc6baI4GtX2I57L+H0mo/xSqVWDEVlCcs/GvfO0ThvzGpCc5eHvUT
        1tXyIlKktQdDVYXsDXHvJrWSRZFDl1kK7Y0m7TJbAGcIqV+JDMfLcjRQ5Uo5c7Japmc/EG
        60VZ5pWTi1G5zwnKwLAc+dd3hStvIUU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1628558936;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IlE4hxH1OAZHv4daM+CU4Nw1iiAiN07ttV2IbAeGNfk=;
        b=ZotQ5O9yRBzpLIOAnoX0HH5lyPlJHW7O2Q0ysxe92ekLWKk8lcv84s2grEuC2VQOWpVNLo
        thkdn1NjPjA/m9Dw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AB1F6133DD;
        Tue, 10 Aug 2021 01:28:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 3aJhGlfWEWENPgAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 10 Aug 2021 01:28:55 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Mike Javorski" <mike.javorski@gmail.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: NFS server regression in kernel 5.13 (tested w/ 5.13.9)
In-reply-to: <CAOv1SKCUM5cGuXWAc7dsXtbmPMATqd245juC+S9gVXHWiZsvmQ@mail.gmail.com>
References: <CAOv1SKCmdtchm5Z2NU80o49tkrHpAkPFaHKj4-vLDN5bZNCz-Q@mail.gmail.com>,
 <162846730406.22632.14734595494457390936@noble.neil.brown.name>,
 <CAOv1SKBZ7sGBnvG9-M+De+s=CfU=H_GBs4hJah1E4ks+NSMyPw@mail.gmail.com>,
 <CAOv1SKCUM5cGuXWAc7dsXtbmPMATqd245juC+S9gVXHWiZsvmQ@mail.gmail.com>
Date:   Tue, 10 Aug 2021 11:28:52 +1000
Message-id: <162855893202.12431.3423894387218130632@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 10 Aug 2021, Mike Javorski wrote:
> Managed to get the rpcdebug info for some freezes today. I had a loop
> running to call the rpcbind command that Neil provided and then sleep
> for 2 seconds. Each triggering event was the opening of a new video
> file (I was shuffling through files with mpv). I haven't managed to
> get a tcp capture yet trying to get one that isn't too massive, but
> the timing is tricky, and this doesn't happen every time.
>=20

Thanks for the logs.

They show consistent "a:call_status" and "q:xprt_pending".  They also
show a timeout in the range 10000-20000.  This number is in 'jiffies',
which is normally millisecs, so 10 to 20 seconds.

That means the RPC layer (thinks it has) sent a request (made a call)
and is waiting for a reply to arrive over the network transport (i.e.
the TCP connection).  However that would typically involve a much longer
timeout.  For NFSv3 and 4.0, 60 seconds is the norm.  For NFSv4.1 I
*think* there is no timeout as NFS never resends requests unless the TCP
connection is broken.  So I don't know what to make of that.

Given the fact that it recovers in 5-10 seconds, it seems very likely
that it actually has sent the request (presumably the timeout doesn't
expire).  Mostly likely the server is being delayed in replying.  A
tcpdump trace would confirm this.

I don't think you've said anything about what NFS server you are using.=20
It is Linux, or something else?  If Linux, what kernel do you run there?

One thing that might cause a delay when accessing a file is if some
other client has a 'delegation' and takes a while to return it.
e.g.
  client2 creates a file for writing
  server gives it a 'write delegation'
  client2 queues up lots of write request
  client1 asks to read the file.
  server says to client2 "please return the delegation"
  client2 starts flushing its data, but either takes too long or=20
   has some other hiccup. Eventually it is returned, or the server
   revokes it
  server tells clients one it can read now.

This is leading to me asking: do you have other NFS clients that might
be accessing the same file, or might have accessed it recently?

NeilBrown


> -----------------------------
>=20
> [31229.965368] -pid- flgs status -client- --rqstp- -timeout ---ops--
> [31229.965370] 44224 c801      0 8c478d70 2473aa3b    15395  8531859
> nfsv4 READ a:call_status [sunrpc] q:xprt_pending
> [31229.965411] 44225 c801      0 8c478d70 a7d3b9b8    15395  8531859
> nfsv4 READ a:call_status [sunrpc] q:xprt_pending
> [31231.966982] -pid- flgs status -client- --rqstp- -timeout ---ops--
> [31231.966986] 44224 c801      0 8c478d70 2473aa3b    14795  8531859
> nfsv4 READ a:call_status [sunrpc] q:xprt_pending
> [31231.967027] 44225 c801      0 8c478d70 a7d3b9b8    14795  8531859
> nfsv4 READ a:call_status [sunrpc] q:xprt_pending
> [31233.968741] -pid- flgs status -client- --rqstp- -timeout ---ops--
> [31233.968745] 44224 c801      0 8c478d70 2473aa3b    14194  8531859
> nfsv4 READ a:call_status [sunrpc] q:xprt_pending
> [31233.968787] 44225 c801      0 8c478d70 a7d3b9b8    14194  8531859
> nfsv4 READ a:call_status [sunrpc] q:xprt_pending
>=20
> -----------------------------
>=20
> [31292.534529] -pid- flgs status -client- --rqstp- -timeout ---ops--
> [31292.534530] 45744 c801      0 8c478d70 2473aa3b    15340  8531859
> nfsv4 READ a:call_status [sunrpc] q:xprt_pending
> [31292.534554] 45745 c801      0 8c478d70 50cbef7b    15342  8531859
> nfsv4 READ a:call_status [sunrpc] q:xprt_pending
> [31294.536203] -pid- flgs status -client- --rqstp- -timeout ---ops--
> [31294.536206] 45744 c801      0 8c478d70 2473aa3b    14740  8531859
> nfsv4 READ a:call_status [sunrpc] q:xprt_pending
> [31294.536232] 45745 c801      0 8c478d70 50cbef7b    14742  8531859
> nfsv4 READ a:call_status [sunrpc] q:xprt_pending
> [31296.537826] -pid- flgs status -client- --rqstp- -timeout ---ops--
> [31296.537830] 45744 c801      0 8c478d70 2473aa3b    14139  8531859
> nfsv4 READ a:call_status [sunrpc] q:xprt_pending
> [31296.537871] 45745 c801      0 8c478d70 50cbef7b    14141  8531859
> nfsv4 READ a:call_status [sunrpc] q:xprt_pending
> [31298.539474] -pid- flgs status -client- --rqstp- -timeout ---ops--
> [31298.539478] 45744 c801      0 8c478d70 2473aa3b    13539  8531859
> nfsv4 READ a:call_status [sunrpc] q:xprt_pending
> [31298.539522] 45745 c801      0 8c478d70 50cbef7b    13541  8531859
> nfsv4 READ a:call_status [sunrpc] q:xprt_pending
> [31300.541040] -pid- flgs status -client- --rqstp- -timeout ---ops--
> [31300.541044] 46048 c801      0 8c478d70 50cbef7b    17965  8531859
> nfsv4 READ a:call_status [sunrpc] q:xprt_pending
> [31300.541108] 46049 c801      0 8c478d70 2473aa3b    17965  8531859
> nfsv4 READ a:call_status [sunrpc] q:xprt_pending
> [31302.542632] -pid- flgs status -client- --rqstp- -timeout ---ops--
> [31302.542635] 46922 c801      0 8c478d70 50cbef7b    18000  8531859
> nfsv4 READ a:call_status [sunrpc] q:xprt_pending
>=20
> ---------------------------
>=20
> [31375.046020] -pid- flgs status -client- --rqstp- -timeout ---ops--
> [31375.046022] 47336 c801      0 8c478d70 cebaa9a6    15964  8531859
> nfsv4 READ a:call_status [sunrpc] q:xprt_pending
> [31375.046048] 47337 c801      0 8c478d70 f7145d4d    15964  8531859
> nfsv4 READ a:call_status [sunrpc] q:xprt_pending
> [31377.047361] -pid- flgs status -client- --rqstp- -timeout ---ops--
> [31377.047365] 47336 c801      0 8c478d70 cebaa9a6    15364  8531859
> nfsv4 READ a:call_status [sunrpc] q:xprt_pending
> [31377.047406] 47337 c801      0 8c478d70 f7145d4d    15364  8531859
> nfsv4 READ a:call_status [sunrpc] q:xprt_pending
> [31379.048801] -pid- flgs status -client- --rqstp- -timeout ---ops--
> [31379.048805] 47336 c801      0 8c478d70 cebaa9a6    14764  8531859
> nfsv4 READ a:call_status [sunrpc] q:xprt_pending
> [31379.048845] 47337 c801      0 8c478d70 f7145d4d    14764  8531859
> nfsv4 READ a:call_status [sunrpc] q:xprt_pending
> [31381.050376] -pid- flgs status -client- --rqstp- -timeout ---ops--
> [31381.050380] 47336 c801      0 8c478d70 cebaa9a6    14163  8531859
> nfsv4 READ a:call_status [sunrpc] q:xprt_pending
> [31381.050421] 47337 c801      0 8c478d70 f7145d4d    14163  8531859
> nfsv4 READ a:call_status [sunrpc] q:xprt_pending
> [31383.051746] -pid- flgs status -client- --rqstp- -timeout ---ops--
> [31383.051749] 47336 c801      0 8c478d70 cebaa9a6    13563  8531859
> nfsv4 READ a:call_status [sunrpc] q:xprt_pending
> [31383.051775] 47337 c801      0 8c478d70 f7145d4d    13563  8531859
> nfsv4 READ a:call_status [sunrpc] q:xprt_pending
> [31385.053182] -pid- flgs status -client- --rqstp- -timeout ---ops--
> [31385.053185] 47342 c801      0 8c478d70 f7145d4d    17980  8531859
> nfsv4 READ a:call_status [sunrpc] q:xprt_pending
> [31387.054422] -pid- flgs status -client- --rqstp- -timeout ---ops--
> [31387.054426] 47818 c801      0 8c478d70 f7145d4d    17761  8531859
> nfsv4 READ a:call_status [sunrpc] q:xprt_pending
> [31387.054467] 47819 c801      0 8c478d70 cebaa9a6    17762  8531859
> nfsv4 READ a:call_status [sunrpc] q:xprt_pending
>=20
>=20
> - mike
>=20
>=20
> On Sun, Aug 8, 2021 at 5:28 PM Mike Javorski <mike.javorski@gmail.com> wrot=
e:
> >
> > Appreciate the insights Neil. I will make an attempt to
> > trigger/capture the fault if I can.
> >
> > - mike
> >
> > On Sun, Aug 8, 2021 at 5:01 PM NeilBrown <neilb@suse.de> wrote:
> > >
> > > On Mon, 09 Aug 2021, Mike Javorski wrote:
> > > > I have been experiencing nfs file access hangs with multiple release
> > > > versions of the 5.13.x linux kernel. In each case, all file transfers
> > > > freeze for 5-10 seconds and then resume. This seems worse when reading
> > > > through many files sequentially.
> > >
> > > A particularly useful debugging tool for NFS freezes is to run
> > >
> > >   rpcdebug -m rpc -c all
> > >
> > > while the system appears frozen.  As you only have a 5-10 second window
> > > this might be tricky.
> > > Setting or clearing debug flags in the rpc module (whether they are
> > > already set or not) has a side effect if listing all RPC "tasks" which a
> > > waiting for a reply.  Seeing that task list can often be useful.
> > >
> > > The task list appears in "dmesg" output.  If there are not tasks
> > > waiting, nothing will be written which might lead you to think it didn't
> > > work.
> > >
> > > As Chuck hinted, tcpdump is invaluable for this sort of problem.
> > >   tcpdump -s 0 -w /tmp/somefile.pcap port 2049
> > >
> > > will capture NFS traffic.  If this can start before a hang, and finish
> > > after, it may contain useful information.  Doing that in a way that
> > > doesn't create an enormous file might be a challenge.  It would help if
> > > you found a way trigger the problem.  Take note of the circumstances
> > > when it seems to happen the most.  If you can only produce a large file,
> > > we can probably still work with it.
> > >   tshark -r /tmp/somefile.pcap
> > > will report the capture one line per packet.  You can look for the
> > > appropriate timestamp, note the frame numbers, and use "editcap"
> > > to extract a suitable range of packets.
> > >
> > > NeilBrown
> > >
> > >
> > > >
> > > > My server:
> > > > - Archlinux w/ a distribution provided kernel package
> > > > - filesystems exported with "rw,sync,no_subtree_check,insecure" optio=
ns
> > > >
> > > > Client:
> > > > - Archlinux w/ latest distribution provided kernel (5.13.9-arch1-1 at=
 writing)
> > > > - nfs mounted via /net autofs with "soft,nodev,nosuid" options
> > > > (ver=3D4.2 is indicated in mount)
> > > >
> > > > I have tried the 5.13.x kernel several times since the first arch
> > > > release (most recently with 5.13.9-arch1-1), all with similar results.
> > > > Each time, I am forced to downgrade the linux package to a 5.12.x
> > > > kernel (5.12.15-arch1 as of writing) to clear up the transfer issues
> > > > and stabilize performance. No other changes are made between tests. I
> > > > have confirmed the freezing behavior using both ext4 and btrfs
> > > > filesystems exported from this server.
> > > >
> > > > At this point I would appreciate some guidance in what to provide in
> > > > order to diagnose and resolve this issue. I don't have a lot of kernel
> > > > debugging experience, so instruction would be helpful.
> > > >
> > > > - mike
> > > >
> > > >
>=20
>=20
