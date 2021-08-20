Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 716A23F2419
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Aug 2021 02:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234058AbhHTAcE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 19 Aug 2021 20:32:04 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:48052 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233644AbhHTAcE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 19 Aug 2021 20:32:04 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7DF7922167;
        Fri, 20 Aug 2021 00:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1629419486; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1clEmbo6WSFxTlRWktHErLYk+JNKnVjEVTMK1uzG+R4=;
        b=W9QZrFMCnWV7Mzt3gJhmyrslNodHg//PhAbmKg52Y6xqpPo1AiyEZzyPzAUQ7rGPyvrJrt
        y+tlzVgGBon+mb6sOMhP/09MJcIhATykdS04t5mBt16inxODFMcFWFBXstoF3lnPeqEjYW
        ZIy/8qpscBJ/i0lm1sZUVr2I3xTIECE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1629419486;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1clEmbo6WSFxTlRWktHErLYk+JNKnVjEVTMK1uzG+R4=;
        b=yBuMmYsRFXctVAs0mJBMN+E4mUvT05IJsuqRJ+l+aKtvTHG4qHNSAqqDrrdfem0uX1YApX
        DNmJp/xhEyLZuDAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5D1F713ACF;
        Fri, 20 Aug 2021 00:31:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6BC3Bt33HmEIJwAAMHmgww
        (envelope-from <neilb@suse.de>); Fri, 20 Aug 2021 00:31:25 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Mike Javorski" <mike.javorski@gmail.com>
Cc:     "Chuck Lever III" <chuck.lever@oracle.com>,
        "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>
Subject: Re: NFS server regression in kernel 5.13 (tested w/ 5.13.9)
In-reply-to: <162915491276.9892.7049267765583701172@noble.neil.brown.name>
References: <CAOv1SKCmdtchm5Z2NU80o49tkrHpAkPFaHKj4-vLDN5bZNCz-Q@mail.gmail.com>,
 <162846730406.22632.14734595494457390936@noble.neil.brown.name>,
 <CAOv1SKBZ7sGBnvG9-M+De+s=CfU=H_GBs4hJah1E4ks+NSMyPw@mail.gmail.com>,
 <CAOv1SKCUM5cGuXWAc7dsXtbmPMATqd245juC+S9gVXHWiZsvmQ@mail.gmail.com>,
 <162855893202.12431.3423894387218130632@noble.neil.brown.name>,
 <CAOv1SKAaSbfw53LWCCrvGCHESgdtCf5h275Zkzi9_uHkqnCrdg@mail.gmail.com>,
 <162882238416.1695.4958036322575947783@noble.neil.brown.name>,
 <CAOv1SKB_dsam7P9pzzh_SKCtA8uE9cyFdJ=qquEfhLT42-szPA@mail.gmail.com>,
 <CAOv1SKDDOj5UeUwztrMSNJnLgSoEgD8OU55hqtLHffHvaCQzzA@mail.gmail.com>,
 <162907681945.1695.10796003189432247877@noble.neil.brown.name>,
 <87777C39-BDDA-4E1E-83FA-5B46918A66D3@oracle.com>,
 <CAOv1SKA5ByO7PYQwvd6iBcPieWxEp=BfUZuigJ=7Hm4HAmTuMA@mail.gmail.com>,
 <162915491276.9892.7049267765583701172@noble.neil.brown.name>
Date:   Fri, 20 Aug 2021 10:31:22 +1000
Message-id: <162941948235.9892.6790956894845282568@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 17 Aug 2021, NeilBrown wrote:
> On Tue, 17 Aug 2021, Mike Javorski wrote:
> > Thanks for the pointer Chuck
> >=20
> > I ran the trace capture and was able to trigger two freezes in
> > relatively short order. Here is that trace file:
> > https://drive.google.com/file/d/1qk_VIMkj8aTeQIg5O0W3AvWyeDSWL3vW/view?us=
p=3Dsharing
> >=20
>=20
> There are gaps of 5.3sec, 4sec, 1sec and 1sec between adjacent trace
> points.
> The longest gap between 'start' and 'done' for any given xid is 354msec.
> So it doesn't look like the filesystem read causing the problem.
>=20
> The long gaps between adjacent records are:
> 0.354581 xid=3D0x4c6ac2b6
> 0.418340 xid=3D0x6a71c2b6
> 1.013260 xid=3D0x6f71c2b6
> 1.020742 xid=3D0x0f71c2b6
> 4.064527 xid=3D0x6171c2b6
> 5.396559 xid=3D0xd66dc2b6
>=20
> The fact 1, 1, and 4 are so close to a precise number of seconds seems
> unlikely to be a co-incidence.  It isn't clear what it might mean
> though.
>=20
> I don't have any immediae ideas where to look next.  I'll let you know
> if I come up with something.

I had separate bug report
  https://bugzilla.suse.com/show_bug.cgi?id=3D1189508
with broadly similar symptoms which strongly points to network-layer
problem.  So I'm digging back into that tcpdump.

The TCP ACK for READ requests usually goes out in 100 or 200
microseconds.  Sometimes longer - by a factor of about 100.

% tshark -r /tmp/javmorin-nfsfreeze-5.13.10-cap1\ .test.pcap  -d tcp.port=3D=
=3D2049,rpc -Y 'tcp.port=3D=3D2049 && rpc.msgtyp=3D=3D0 && nfs.opcode=3D=3D25=
' -T fields -e tcp.seq -e frame.time_epoch -e frame.number | sed 's/$/ READ/'=
 > /tmp/read-times
% tshark -r /tmp/javmorin-nfsfreeze-5.13.10-cap1\ .test.pcap  -d tcp.port=3D=
=3D2049,rpc -Y 'tcp.srcport=3D=3D2049' -T fields -e tcp.ack -e frame.time_epo=
ch -e frame.number | sed 's/$/ ACK/' > /tmp/ack-times
% sort -n /tmp/read-times /tmp/ack-times  | awk '$4 =3D=3D "ACK" && readtime =
{printf "%f %d\n", ($2 - readtime), $3; readtime=3D0} $4 =3D=3D "READ" {readt=
ime=3D$2}' | sort -n | tail -4
0.000360 441
0.012777 982
0.013318 1086
0.042356 1776

Three times (out of 245) the TCP ACK was 12 milliseconds or longer.  The
first and last were times when the reply was delayed by a couple of
seconds at least.  The other (1086) was the reply to 1085 - no obvious
delay to the READ reply.

These unusual delays (short though they are) suggest something odd in
the network layer - particularly as they are sometimes followed by a
much larger delay in a READ reply.

It might be as simple as a memory allocation delay.  It might be
something deep in the networking layer.

If you still have (or could generate) some larger tcp dumps, you could
try that code and see if 5.12 shows any ACK delays, and if 5.13 shows
more delays than turn into READ delays.  IF 5.13 easily shows a few ACK
delays thats 5.12 doesn't, then they might make a git-bisect more
reliable.  Having thousands of READs in the trace rather than just 245
should produce more reliable data.


As I suggested in the bug report I linked above, I am suspicious of TCP
offload when I see symptoms like this.  You can use "ethtool" to turn
off that various offload features.  Doing that and trying to reproduce
without offload might also provide useful information.

NeilBrown
