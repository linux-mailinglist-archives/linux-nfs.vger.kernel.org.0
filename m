Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B22FB2CE2BF
	for <lists+linux-nfs@lfdr.de>; Fri,  4 Dec 2020 00:36:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727445AbgLCXfl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 3 Dec 2020 18:35:41 -0500
Received: from elasmtp-masked.atl.sa.earthlink.net ([209.86.89.68]:37086 "EHLO
        elasmtp-masked.atl.sa.earthlink.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727272AbgLCXfl (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 3 Dec 2020 18:35:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mindspring.com;
        s=dk12062016; t=1607038540; bh=Y8JyoLYOL2NF94Nn1Oa2PFmWdMDv8BjSuPyZ
        LK0ixB8=; h=Received:From:To:Cc:References:In-Reply-To:Subject:Date:
         Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:
         X-Mailer:Content-Language:Thread-Index:X-ELNK-Trace:
         X-Originating-IP; b=Ts7SIdHIzluXP5JaxG4Z40VzmnZsvOGiGuKlLG8OzwJICr
        MbeazBteVM7THsRr2cdiStz/rzn0FhZlGsgtL5a7bvwl2BPayyP1TBuJt32Hz//6hqf
        G9bNsREjqHkW6EM0SSWvqETRwk2p8SZmkGNwkY3nukySlIG7VSMlSJR9SSEOdlExyqG
        SYYd4p35wApg6NrJAtyIKQARndLlS/oN2MS+Z08rCSJqiJgQgKXaLa7KS3H8w7AeGH/
        nsYwYzUxYZlrkYfn+IxHuGVZpypfyidu3mhFkwxZabXT6NMn7boUr/4OxvL4GsWkR5T
        bw2MiWR9fvjr7R91ey3s70zDTwEg==
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=dk12062016; d=mindspring.com;
  b=G1fYh5UGv+R4CSopQsJ9IDNLw5V9HwmBkaccEKWT7kRjMaMWGSw2UIBbt47+b5cGBrqWg8ccEBfc+LbluxYHmpZLnAqTgFzQ5iBOKMUJxwug2z0iU//bXBTV2XxA8KB9FIKG9l/6vcf911Bk0OR/xeeAjL7Fgg43qlejUSyn0xAzkgqOeXsQfNe5iifE+yUZf1yDD2OE8yHPUxwSorrDn9j1KiVoQ/OJilRMTEl9zRtE8zacCio3cCv1y4AyUph6tVuWK0NU82YTOTmV4XNB8roMANDttNMkm+ZzjpbGu3H0Hs5nDUu2NA8HbK49JhrppF6DithPiCUHvkJYzHd8Aw==;
  h=Received:From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer:Content-Language:Thread-Index:X-ELNK-Trace:X-Originating-IP;
Received: from [76.105.143.216] (helo=FRANKSTHINKPAD)
        by elasmtp-masked.atl.sa.earthlink.net with esmtpa (Exim 4)
        (envelope-from <ffilzlnx@mindspring.com>)
        id 1kky7m-0007JI-2v; Thu, 03 Dec 2020 18:34:58 -0500
From:   "Frank Filz" <ffilzlnx@mindspring.com>
To:     "'Trond Myklebust'" <trondmy@hammerspace.com>,
        <bfields@fieldses.org>
Cc:     <linux-cachefs@redhat.com>, <linux-nfs@vger.kernel.org>,
        <daire@dneg.com>
References: <1055884313.92996091.1606250106656.JavaMail.zimbra@dneg.com>         <20201124211522.GC7173@fieldses.org>         <932244432.93596532.1606324491501.JavaMail.zimbra@dneg.com>         <1403656117.98163597.1606998035261.JavaMail.zimbra@dneg.com>         <20201203185109.GB27931@fieldses.org>         <4903965f2beb742e0eca089b5db8aa3a4cabb7f0.camel@hammerspace.com>         <20201203211328.GC27931@fieldses.org>         <9df8556bf825bd0d565f057b115e35c1b507cf46.camel@hammerspace.com>         <019001d6c9bd$acbeb6b0$063c2410$@mindspring.com>         <b9e8da547065f6a94bed22771f214fef91449931.camel@hammerspace.com>         <20201203220421.GE27931@fieldses.org>         <0452916df308e9419f472b0d5ffb41815014dce4.camel@hammerspace.com>         <01a001d6c9c5$37eb34f0$a7c19ed0$@mindspring.com> <72362b839eb2ecc992f41a0e7783545b13e8ecbc.camel@hammerspace.com>
In-Reply-To: <72362b839eb2ecc992f41a0e7783545b13e8ecbc.camel@hammerspace.com>
Subject: RE: Adventures in NFS re-exporting
Date:   Thu, 3 Dec 2020 15:34:57 -0800
Message-ID: <01ae01d6c9cc$e9a40440$bcec0cc0$@mindspring.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 15.0
Content-Language: en-us
Thread-Index: AQGLCl71o/mllkcOM8ZTKfem/khTDAJjSqDGAjc9/isC5PHtZAIjFAJ1Aky2llQCn/rUrgIxRIQHAZ398i8CN7bmMADvqBOLAe1pYKUB7+rmhAJQ0TVJqZ/jItA=
X-ELNK-Trace: 136157f01908a8929c7f779228e2f6aeda0071232e20db4d0096a3f9fc75a393ccdc255d81cb1b59350badd9bab72f9c350badd9bab72f9c350badd9bab72f9c
X-Originating-IP: 76.105.143.216
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

> > > -----Original Message-----
> > > From: Trond Myklebust [mailto:trondmy@hammerspace.com]
> > > Sent: Thursday, December 3, 2020 2:14 PM
> > > To: bfields@fieldses.org
> > > Cc: linux-cachefs@redhat.com; ffilzlnx@mindspring.com; linux-
> > > nfs@vger.kernel.org; daire@dneg.com
> > > Subject: Re: Adventures in NFS re-exporting
> > >
> > > On Thu, 2020-12-03 at 17:04 -0500, bfields@fieldses.org wrote:
> > > > On Thu, Dec 03, 2020 at 09:57:41PM +0000, Trond Myklebust wrote:
> > > > > On Thu, 2020-12-03 at 13:45 -0800, Frank Filz wrote:
> > > > > > > On Thu, 2020-12-03 at 16:13 -0500, bfields@fieldses.org
> > > > > > > wrote:
> > > > > > > > On Thu, Dec 03, 2020 at 08:27:39PM +0000, Trond =
Myklebust
> > > > > > > > wrote:
> > > > > > > > > On Thu, 2020-12-03 at 13:51 -0500, bfields wrote:
> > > > > > > > > > I've been scratching my head over how to handle =
reboot
> > > > > > > > > > of a
> > > > > > > > > > re-
> > > > > > > > > > exporting server.  I think one way to fix it might =
be
> > > > > > > > > > just to allow the re- export server to pass along
> > > > > > > > > > reclaims to the original server as it receives them
> > > > > > > > > > from its own clients.  It might require some =
protocol
> > > > > > > > > > tweaks, I'm not sure.  I'll try to get my thoughts =
in
> > > > > > > > > > order and propose something.
> > > > > > > > > >
> > > > > > > > >
> > > > > > > > > It's more complicated than that. If the re-exporting
> > > > > > > > > server reboots, but the original server does not, then
> > > > > > > > > unless that
> > > > > > > > > re- exporting server persisted its lease and a full =
set
> > > > > > > > > of stateids somewhere, it will not be able to =
atomically
> > > > > > > > > reclaim delegation and lock state on the server on
> > > > > > > > > behalf of its clients.
> > > > > > > >
> > > > > > > > By sending reclaims to the original server, I mean
> > > > > > > > literally sending new open and lock requests with the
> > > > > > > > RECLAIM bit set, which would get brand new stateids.
> > > > > > > >
> > > > > > > > So, the original server would invalidate the existing
> > > > > > > > client's previous clientid and stateids--just as it
> > > > > > > > normally would on reboot--but it would optionally =
remember
> > > > > > > > the underlying locks held by the client and allow
> > > > > > > > compatible lock reclaims.
> > > > > > > >
> > > > > > > > Rough attempt:
> > > > > > > >
> > > > > > > >
> > > > > > > > =
https://wiki.linux-nfs.org/wiki/index.php/Reboot_recovery_
> > > > > > > > for_
> > > > > > > > re-expor
> > > > > > > > t_servers
> > > > > > > >
> > > > > > > > Think it would fly?
> > > > > > >
> > > > > > > So this would be a variant of courtesy locks that can be
> > > > > > > reclaimed by the client using the reboot reclaim variant =
of
> > > > > > > OPEN/LOCK outside the grace period? The purpose being to
> > > > > > > allow reclaim without forcing the client to persist the
> > > > > > > original stateid?
> > > > > > >
> > > > > > > Hmm... That's doable, but how about the following
> > > > > > > alternative:
> > > > > > > Add
> > > > > > > a function
> > > > > > > that allows the client to request the full list of =
stateids
> > > > > > > that the server holds on its behalf?
> > > > > > >
> > > > > > > I've been wanting such a function for quite a while anyway
> > > > > > > in order to allow the client to detect state leaks (either
> > > > > > > due to soft timeouts, or due to reordered close/open
> > > > > > > operations).
> > > > > >
> > > > > > Oh, that sounds interesting. So basically the re-export =
server
> > > > > > would re-populate it's state from the original server rather
> > > > > > than relying on it's clients doing reclaims? Hmm, but how =
does
> > > > > > the re-export server rebuild its stateids? I guess it could
> > > > > > make the clients repopulate them with the same "give me a =
dump
> > > > > > of all my state", using the state details to match up with =
the
> > > > > > old state and replacing stateids. Or did you have something
> > > > > > different in mind?
> > > > > >
> > > > >
> > > > > I was thinking that the re-export server could just use that
> > > > > list of stateids to figure out which locks can be reclaimed
> > > > > atomically, and which ones have been irredeemably lost. The
> > > > > assumption is that if you have a lock stateid or a delegation,
> > > > > then that means the clients can reclaim all the locks that =
were
> > > > > represented by that stateid.
> > > >
> > > > I'm confused about how the re-export server uses that list.  Are
> > > > you assuming it persisted its own list across its own
> > > > crash/reboot?
> > > > I
> > > > guess that's what I was trying to avoid having to do.
> > > >
> > > No. The server just uses the stateids as part of a check for 'do I
> > > hold state for this file on this server?'. If the answer is 'yes'
> > > and the lock owners are sane, then we should be able to assume the
> > > full set of locks that lock owner held on that file are still =
valid.
> > >
> > > BTW: if the lock owner is also returned by the server, then since
> > > the lock owner is an opaque value, it could, for instance, be used
> > > by the client to cache info on the server about which uid/gid owns
> > > these locks.
> >
> > Let me see if I'm understanding your idea right...
> >
> > Re-export server reboots within the extended lease period it's been
> > given by the original server. I'm assuming it uses the same =
clientid?
>=20
> Yes. It would have to use the same clientid.
>=20
> > But would probably open new sessions. It requests the list of
> > stateids. Hmm, how to make the owner information useful, nfs-ganesha
> > doesn't pass on the actual client's owner but rather just passes the
> > address of its record for that client owner. Maybe it will have to =
do
> > something a bit different for this degree of re-export support...
> >
> > Now the re-export server knows which original client lock owners are
> > allowed to reclaim state. So it just acquires locks using the =
original
> > stateid as the client reclaims (what happens if the client doesn't
> > reclaim a lock? I suppose the re-export server could unlock all
> > regions not explicitly locked once reclaim is complete). Since the
> > re-export server is acquiring new locks using the original stateid =
it
> > will just overlay the original lock with the new lock and write =
locks
> > don't conflict since they are being acquired by the same lock owner.
> > Actually the original server could even balk at a "reclaim" in this
> > way that wasn't originally held... And the original server could
> > "refresh" the locks, and discard any that aren't refreshed at the =
end
> > of reclaim. That part assumes the original server is apprised that
> > what is actually happening is a reclaim.
> >
> > The re-export server can destroy any stateids that it doesn't =
receive
> > reclaims for.
>=20
> Right. That's in essence what I'm suggesting. There are corner cases =
to be
> considered: e.g. "what happens if the re-export server crashes after =
unlocking
> on the server, but before passing the LOCKU reply on the the client", =
however I
> think it should be possible to figure out strategies for those cases.

That's no different than a regular NFS server crashes before responding =
to an unlock. The client likely doesn't reclaim locks it was attempting =
to drop at server crash time. So then one place we would definitely have =
abandoned locks on the original server IF the unlock never made it to =
the original server. But we're already talking strategies to clean up =
abandoned locks.

I won't be surprised if we find a more tricky corner case, but my gut =
feel is every corner case will have a relatively simple solution.

Another consideration is how to handle the size of the state list... =
Ideally we would have some way to break it up that is less clunky than =
readdir (at least the state list can be assumed to be static during the =
course of the fetching of it, even for a regular client just interested =
in it, it could pause state activity until the list is retrieved).

Frank

Frank

