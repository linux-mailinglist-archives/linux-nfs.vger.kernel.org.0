Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 571D93ECC4C
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Aug 2021 03:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231628AbhHPBU5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 15 Aug 2021 21:20:57 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:34466 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232755AbhHPBU4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 15 Aug 2021 21:20:56 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id BA9C71FE51;
        Mon, 16 Aug 2021 01:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1629076824; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pQr3bieAwNWdHhjcp1bgIqqxip0KkwHOamDTW3fxzIE=;
        b=S5SDWe86lZSOtDOaZGS+W2SbOIh2zHsc4F3oEDTCiiyCaWjfZ/xHXTclObengVEZ2I0V1/
        Js3+ROXPY4COkHTYvb2rxRaORtKVPIs8ycpATqk5Ux82ELcmqz9XDZhRwanvV/lGKBttDq
        A7k8Pwf+NIBbtgo1/kfoJ9yvVt7CCmE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1629076824;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pQr3bieAwNWdHhjcp1bgIqqxip0KkwHOamDTW3fxzIE=;
        b=9mcjSVh9GkdYvWNauws2n0iBI7skB9c8F17bb+Aj/dEB7VbpbGBVyMe+dABTYr6Le2tic2
        tvIx3Utrm2TVN8Dg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D50E213C84;
        Mon, 16 Aug 2021 01:20:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id oxf/Ile9GWHpRQAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 16 Aug 2021 01:20:23 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Mike Javorski" <mike.javorski@gmail.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: NFS server regression in kernel 5.13 (tested w/ 5.13.9)
In-reply-to: <CAOv1SKDDOj5UeUwztrMSNJnLgSoEgD8OU55hqtLHffHvaCQzzA@mail.gmail.com>
References: <CAOv1SKCmdtchm5Z2NU80o49tkrHpAkPFaHKj4-vLDN5bZNCz-Q@mail.gmail.com>,
 <162846730406.22632.14734595494457390936@noble.neil.brown.name>,
 <CAOv1SKBZ7sGBnvG9-M+De+s=CfU=H_GBs4hJah1E4ks+NSMyPw@mail.gmail.com>,
 <CAOv1SKCUM5cGuXWAc7dsXtbmPMATqd245juC+S9gVXHWiZsvmQ@mail.gmail.com>,
 <162855893202.12431.3423894387218130632@noble.neil.brown.name>,
 <CAOv1SKAaSbfw53LWCCrvGCHESgdtCf5h275Zkzi9_uHkqnCrdg@mail.gmail.com>,
 <162882238416.1695.4958036322575947783@noble.neil.brown.name>,
 <CAOv1SKB_dsam7P9pzzh_SKCtA8uE9cyFdJ=qquEfhLT42-szPA@mail.gmail.com>,
 <CAOv1SKDDOj5UeUwztrMSNJnLgSoEgD8OU55hqtLHffHvaCQzzA@mail.gmail.com>
Date:   Mon, 16 Aug 2021 11:20:19 +1000
Message-id: <162907681945.1695.10796003189432247877@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sun, 15 Aug 2021, Mike Javorski wrote:
> I managed to get a cap with several discreet freezes in it, and I
> included a chunk with 5 of them in the span of ~3000 frames. I added
> packet comments at each frame that the tshark command reported as > 1
> sec RPC wait. Just search for "Freeze" in (wire|t)shark in packet
> details. This is with kernel 5.13.10 provided by Arch (See
> https://github.com/archlinux/linux/compare/a37da2be8e6c85...v5.13.10-arch1
> for diff vs mainline, nothing NFS/RPC related I can identify).
>=20
> I tried unsuccessfully to get any failures with the 5.12.15 kernel.
>=20
> https://drive.google.com/file/d/1T42iX9xCdF9Oe4f7JXsnWqD8oJPrpMqV/view?usp=
=3Dsharing
>=20
> File should be downloadable anonymously.

Got it, thanks.

There are 3 RPC replies that are more than 1 second after the request.
The replies are in frames 983, 1005, 1777 These roughly correspond to
where you added the "Freeze" annotation (I didn't know you could do that!).

983:
  This is the (Start of the) reply to a READ Request in frame 980.
  It is a 128K read.  The whole reply has arrived by frame 1004, 2ms
  later.
  The request (Frame 980) is followed 13ms later by a TCP retransmit
  of the request and the (20usec later) a TCP ACK from the server.

  The fact that the client needed to retransmit seems a little odd
  but as it is the only retransmit in the whole capture, I don't think
  we can read much into it.

1005:
  This is the reply to a 128K READ request in frame 793 - earlier than
  previous one.
  So there were two READ requests, then a 2 second delay then both
  replies in reverse order.

1777:
  This is a similar READ reply - to 1761.
  There were READs in 1760, 1761, and 1775
  1760 is replied to almost immediately
  1761 gets a reply in 4 seconds (1777)
  1775 never gets a reply (in the available packet capture).

Looking at other delays ... most READs get a reply in under a millisec.
There are about 20 where the reply is more than 1ms - the longest delay
not already mentioned is 90ms with reply 1857.
The pattern here is=20
   READ req (1)
   GETATTR req
   GETATTR reply
   READ req (2)
   READ reply (1)
  pause
   READ reply (2)

I suspect this is the same problem occurring, but it isn't so
noticeable.

My first thought was that the reply might be getting stuck in the TCP
transmit queue on the server, but checking the TSval in the TCP
timestamp option shows that - for frame 983 which shows a 2second delay
- the TSval is also 2seconds later than the previous packet.  So the
delay happens before the TCP-level decision to create the packet.

So I cannot see any real evidence to suggest a TCP-level problem.
The time of 2 or 4 seconds - and maybe even 90ms - seem unlikely to be
caused by an NFSd problem.

So my guess is that the delay comes from the filesystem.  Maybe.
What filesystem are you exporting?

How can we check this? Probably by turning on nfsd tracing.
There are a bunch of tracepoints that related to reading:

	trace_nfsd_read_start
	trace_nfsd_read_done
	trace_nfsd_read_io_done
	trace_nfsd_read_err
	trace_nfsd_read_splice
	trace_nfsd_read_vector
	trace_nfsd_read_start
	trace_nfsd_read_done

Maybe enabling them might be useful as you should be able to see if the
delay was within one read request, or between two read requests.
But I don't have much (if any) experience in enabling trace points.  I
really should try that some day.  Maybe you can find guidance on using
these tracepoint somewhere ... or maybe you already know how :-)

NeilBrown
