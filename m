Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA52E3EAEA0
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Aug 2021 04:39:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237149AbhHMCkP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 12 Aug 2021 22:40:15 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:42024 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237040AbhHMCkO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 12 Aug 2021 22:40:14 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 243E322161;
        Fri, 13 Aug 2021 02:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1628822388; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DQ3n49JlSDbeekDILskgDzhtIz6BI6/lCGtWv9f/UhU=;
        b=PvELbKB+J1/XEOCdzzkw/Wyw+QIkHBo3hXGst8Dirxw5f3qLGwl73/1YS90wE8ytMlYzbY
        1T7hrHDjxziGx1ddXck3wL4niR+CGZydnbn9XEHz9XWQIPm+CWPUY26S3WkBJbMz3MZwHR
        OAjedPIngN2wGfubrR+OsuMxp65HzhI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1628822388;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DQ3n49JlSDbeekDILskgDzhtIz6BI6/lCGtWv9f/UhU=;
        b=GxaOSX8DJ48nsxYLLNqgaY0m5ugQedCNCOjH5cs4iBf9kWTqE9ygEV1cFx5kr0T31QGLaI
        cddVkmC97/4p5IAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4EBDD13A1A;
        Fri, 13 Aug 2021 02:39:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id NX5rA3PbFWETKgAAMHmgww
        (envelope-from <neilb@suse.de>); Fri, 13 Aug 2021 02:39:47 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Mike Javorski" <mike.javorski@gmail.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: NFS server regression in kernel 5.13 (tested w/ 5.13.9)
In-reply-to: <CAOv1SKAaSbfw53LWCCrvGCHESgdtCf5h275Zkzi9_uHkqnCrdg@mail.gmail.com>
References: <CAOv1SKCmdtchm5Z2NU80o49tkrHpAkPFaHKj4-vLDN5bZNCz-Q@mail.gmail.com>,
 <162846730406.22632.14734595494457390936@noble.neil.brown.name>,
 <CAOv1SKBZ7sGBnvG9-M+De+s=CfU=H_GBs4hJah1E4ks+NSMyPw@mail.gmail.com>,
 <CAOv1SKCUM5cGuXWAc7dsXtbmPMATqd245juC+S9gVXHWiZsvmQ@mail.gmail.com>,
 <162855893202.12431.3423894387218130632@noble.neil.brown.name>,
 <CAOv1SKAaSbfw53LWCCrvGCHESgdtCf5h275Zkzi9_uHkqnCrdg@mail.gmail.com>
Date:   Fri, 13 Aug 2021 12:39:44 +1000
Message-id: <162882238416.1695.4958036322575947783@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 13 Aug 2021, Mike Javorski wrote:
> Neil:
>=20
> Apologies for the delay, your message didn't get properly flagged in my ema=
il.

:-)

>=20
> To answer your questions, both client (my Desktop PC) and server (my
> NAS) are running ArchLinux; client w/ current kernel (5.13.9), server
> w/ current or alternate testing kernels (see below).

So the bug could be in the server or the client.  I assume you are
careful to test a client against a know-good server, or a server against
a known-good client.

>                                                                 I
> intend to spend some time this weekend attempting to get the tcpdump.
> My initial attempts wound up with 400+Mb files which would be
> difficult to ship and use for diagnostics.

Rather than you sending me the dump, I'll send you the code.

Run
  tshark -r filename -d tcp.port=3D=3D2049,rpc -Y 'tcp.port=3D=3D2049 && rpc.=
time > 1'

This will ensure the NFS traffic is actually decoded as NFS and then
report only NFS(rpc) replies that arrive more than 1 second after the
request.
You can add

    -T fields -e frame.number -e rpc.time

to find out what the actual delay was.

If it reports any, that will be interesting.  Try with a larger time if
necessary to get a modest number of hits.  Using editcap and the given
frame number you can select out 1000 packets either side of the problem
and that should compress to be small enough to transport.

However it might not find anything.  If the reply never arrives, you'll
never get a reply with a long timeout.  So we need to check that
everything got a reply...

 tshark -r filename -t tcp.port=3D=3D2049,rpc  \
   -Y 'tcp.port=3D=3D2049 && rpc.msg =3D=3D 0' -T fields \
   -e rpc.xid -e frame.number | sort > /tmp/requests

 tshark -r filename -t tcp.port=3D=3D2049,rpc  \
   -Y 'tcp.port=3D=3D2049 && rpc.msg =3D=3D 1' -T fields \
   -e rpc.xid -e frame.number | sort > /tmp/replies

 join -a1 /tmp/requests /tmp/replies | awk 'NF=3D=3D2'

This should list the xid and frame number of all requests that didn't
get a reply.  Again, editcap can extract a range of frames into a file of
manageable size.

Another possibility is that requests are getting replies, but the reply
says "NFS4ERR_DELAY"

 tshark -r filename -t tcp.port=3D=3D2049,rpc -Y nfs.nfsstat4=3D=3D10008

should report any reply with that error code.

Hopefully something there will be interesting.

NeilBrown
