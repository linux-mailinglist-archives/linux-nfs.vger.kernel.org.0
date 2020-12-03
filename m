Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3641C2CE109
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Dec 2020 22:46:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727375AbgLCVqh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 3 Dec 2020 16:46:37 -0500
Received: from elasmtp-masked.atl.sa.earthlink.net ([209.86.89.68]:50076 "EHLO
        elasmtp-masked.atl.sa.earthlink.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726917AbgLCVqh (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 3 Dec 2020 16:46:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mindspring.com;
        s=dk12062016; t=1607031996; bh=3PbT2ZNa3m2nr5N0ul5Dx4o6IOwG9pW675Vh
        eZmahu0=; h=Received:From:To:Cc:References:In-Reply-To:Subject:Date:
         Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:
         X-Mailer:Content-Language:Thread-Index:X-ELNK-Trace:
         X-Originating-IP; b=kiIPF6wL7jZmxuNO0+UyuggBdZC4Sz9H2zZemVoPx82ytt
        Y6kMrgAGixmgswf5filu5ZJbvYWgfRKUr9swuHDc+ktkHD0gJJj09RfUQk3+D2n7wZd
        4N7CEHXnWXrbN975bsoBOHn/10VJ7OGnlvJ7WA2hvT072Bt/arzLaPANmCAyQIljwrK
        ly6zIS0pmt9RvriSFS2Ps51OtTk/teMhlbj58Jgt9X4rP+wH2NML7yjDb4oTqUqajn4
        pCKTSm+qks64v8VHeex1tBoNrbb0cYTrZB3VaNFx4GAE8k4x0Fh1iubijtvWsG8rHVM
        R73fzr54WLu3wSone0t5JHjdxPSA==
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=dk12062016; d=mindspring.com;
  b=Pdg9W63an64CEBPJPLbKjpwKkZFILqgVvJEY0xiN4ESlSl+b3VyKRQdolD10FrVD6IbjvhyfSrEoCLFMhT781MNZg6p29RsLFtBV8CxY0w+mI62dxEVVDgi2Do/VQjSsq1Jmt4Cl2+gnJwnHujwZcMFTLWlAnkFJ/+ioVMxqfpTJzM9orJRuz47Wcmmu2qhswWzRfNkmA9IfqUXabcQmRItAOMdctmLLzMxL1UOzPVLk3uTS+wkb9Z+mMzVf+7ezfDzRSBOgnWNAvPLP2H9P0htxoc+/84gJcuxUziI9BlC2URb/yD9zXUlychfG/aRkloi4ZkfTC8V+FjGfnrcx/A==;
  h=Received:From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer:Content-Language:Thread-Index:X-ELNK-Trace:X-Originating-IP;
Received: from [76.105.143.216] (helo=FRANKSTHINKPAD)
        by elasmtp-masked.atl.sa.earthlink.net with esmtpa (Exim 4)
        (envelope-from <ffilzlnx@mindspring.com>)
        id 1kkwQD-000AvW-GC; Thu, 03 Dec 2020 16:45:53 -0500
From:   "Frank Filz" <ffilzlnx@mindspring.com>
To:     "'Trond Myklebust'" <trondmy@hammerspace.com>,
        <bfields@fieldses.org>
Cc:     <linux-cachefs@redhat.com>, <linux-nfs@vger.kernel.org>,
        <daire@dneg.com>
References: <279389889.68934777.1603124383614.JavaMail.zimbra@dneg.com>         <635679406.70384074.1603272832846.JavaMail.zimbra@dneg.com>         <20201109160256.GB11144@fieldses.org>         <1744768451.86186596.1605186084252.JavaMail.zimbra@dneg.com>         <1055884313.92996091.1606250106656.JavaMail.zimbra@dneg.com>         <20201124211522.GC7173@fieldses.org>         <932244432.93596532.1606324491501.JavaMail.zimbra@dneg.com>         <1403656117.98163597.1606998035261.JavaMail.zimbra@dneg.com>         <20201203185109.GB27931@fieldses.org>         <4903965f2beb742e0eca089b5db8aa3a4cabb7f0.camel@hammerspace.com>         <20201203211328.GC27931@fieldses.org> <9df8556bf825bd0d565f057b115e35c1b507cf46.camel@hammerspace.com>
In-Reply-To: <9df8556bf825bd0d565f057b115e35c1b507cf46.camel@hammerspace.com>
Subject: RE: Adventures in NFS re-exporting
Date:   Thu, 3 Dec 2020 13:45:52 -0800
Message-ID: <019001d6c9bd$acbeb6b0$063c2410$@mindspring.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 15.0
Content-Language: en-us
Thread-Index: AQH6EgB+BqEYpR696aBJdQxY01PEsQE5qoLXAZr58eYBXdorRQGLCl71AmNKoMYCNz3+KwLk8e1kAiMUAnUCTLaWVAKf+tSuAjFEhAeo62WsYA==
X-ELNK-Trace: 136157f01908a8929c7f779228e2f6aeda0071232e20db4d9d9b728c00c9d2eb053184b77ba33483350badd9bab72f9c350badd9bab72f9c350badd9bab72f9c
X-Originating-IP: 76.105.143.216
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

> On Thu, 2020-12-03 at 16:13 -0500, bfields@fieldses.org wrote:
> > On Thu, Dec 03, 2020 at 08:27:39PM +0000, Trond Myklebust wrote:
> > > On Thu, 2020-12-03 at 13:51 -0500, bfields wrote:
> > > > I've been scratching my head over how to handle reboot of a re-
> > > > exporting server.  I think one way to fix it might be just to
> > > > allow the re- export server to pass along reclaims to the =
original
> > > > server as it receives them from its own clients.  It might =
require
> > > > some protocol tweaks, I'm not sure.  I'll try to get my thoughts
> > > > in order and propose something.
> > > >
> > >
> > > It's more complicated than that. If the re-exporting server =
reboots,
> > > but the original server does not, then unless that re-exporting
> > > server persisted its lease and a full set of stateids somewhere, =
it
> > > will not be able to atomically reclaim delegation and lock state =
on
> > > the server on behalf of its clients.
> >
> > By sending reclaims to the original server, I mean literally sending
> > new open and lock requests with the RECLAIM bit set, which would get
> > brand new stateids.
> >
> > So, the original server would invalidate the existing client's
> > previous clientid and stateids--just as it normally would on
> > reboot--but it would optionally remember the underlying locks held =
by
> > the client and allow compatible lock reclaims.
> >
> > Rough attempt:
> >
> >
> > =
https://wiki.linux-nfs.org/wiki/index.php/Reboot_recovery_for_re-expor
> > t_servers
> >
> > Think it would fly?
>=20
> So this would be a variant of courtesy locks that can be reclaimed by =
the client
> using the reboot reclaim variant of OPEN/LOCK outside the grace =
period? The
> purpose being to allow reclaim without forcing the client to persist =
the original
> stateid?
>=20
> Hmm... That's doable, but how about the following alternative: Add a =
function
> that allows the client to request the full list of stateids that the =
server holds on
> its behalf?
>=20
> I've been wanting such a function for quite a while anyway in order to =
allow the
> client to detect state leaks (either due to soft timeouts, or due to =
reordered
> close/open operations).

Oh, that sounds interesting. So basically the re-export server would =
re-populate it's state from the original server rather than relying on =
it's clients doing reclaims? Hmm, but how does the re-export server =
rebuild its stateids? I guess it could make the clients repopulate them =
with the same "give me a dump of all my state", using the state details =
to match up with the old state and replacing stateids. Or did you have =
something different in mind?

Frank

