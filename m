Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D53A2CE0C7
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Dec 2020 22:35:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbgLCVdV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 3 Dec 2020 16:33:21 -0500
Received: from elasmtp-dupuy.atl.sa.earthlink.net ([209.86.89.62]:54154 "EHLO
        elasmtp-dupuy.atl.sa.earthlink.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726071AbgLCVdV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 3 Dec 2020 16:33:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mindspring.com;
        s=dk12062016; t=1607031200; bh=UOeV+vuypme2Zy+XrvlK6KTauVtiYgwOSz0h
        +W8epG4=; h=Received:From:To:Cc:References:In-Reply-To:Subject:Date:
         Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:
         X-Mailer:Content-Language:Thread-Index:X-ELNK-Trace:
         X-Originating-IP; b=B9c7toPsyfz+KEUq1CgXOwtfVWi9vodVkH90s/R4jlaPX0
        xPtNtE18ZxuG1zusSdneJFL7ihgqo42lMP0I6MQM2rfkd/1GcMVz3mueS/LY7yt+Adu
        Nx1VekeKrCHtiq5SM1yQxmJMPDBbOnzJO/uNTo5wsi+ySb8Tg4HfjJoMS+RrZ5fQtp2
        XfbLq3M4wxIZq8Xs5+BFXSUSaLeV3Kznby+0LvHVkodDty2WdAoZMG3KhyVGpsZ7Ayp
        8UQzPEjZSHaYKWdDOVabBWM1tOtR1dkqjZoWRyjPVEEKbbfIkHfo0O7xjib9+riWdIv
        FCs9XOB/Rvu9xbLVWAP0FiUhz/kA==
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=dk12062016; d=mindspring.com;
  b=Be7idtbucoNu33dD2rRql0twawJGmiNaWArbmUaAso+m30z0LXgEuSvMD9xSWzyWsXJ5e6HBjkmo29hd/oVihbSxxbX1N8XuRL10rsWnfCn7dYKRh1zniNmRFZxSLqdJXFNFG+WYqcS3lEro9pyUpdecLCIeUgOJLJkoQv2EXOu5js+Jb7ACptWZ74t3DxPWHwTAqOTNKR42nAMibqH2eTsk7ufNbRsQ1jj4TLfGq77ejJM6Hc41F++rPaYv9pcuRArwyDvtFyibno+f9TZ2ACk6hU4SVQ7uuNGC0mkdsk1Mr4wzZEx7c9RiLRjrwMSCl6Yi82GaZQExU6G57/hr6g==;
  h=Received:From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer:Content-Language:Thread-Index:X-ELNK-Trace:X-Originating-IP;
Received: from [76.105.143.216] (helo=FRANKSTHINKPAD)
        by elasmtp-dupuy.atl.sa.earthlink.net with esmtpa (Exim 4)
        (envelope-from <ffilzlnx@mindspring.com>)
        id 1kkwDM-000Gy1-22; Thu, 03 Dec 2020 16:32:36 -0500
From:   "Frank Filz" <ffilzlnx@mindspring.com>
To:     <bfields@fieldses.org>,
        "'Trond Myklebust'" <trondmy@hammerspace.com>
Cc:     <daire@dneg.com>, <linux-cachefs@redhat.com>,
        <linux-nfs@vger.kernel.org>, "Jeff Layton" <jlayton@redhat.com>,
        "'Solomon Boulos'" <boulos@google.com>
References: <279389889.68934777.1603124383614.JavaMail.zimbra@dneg.com> <635679406.70384074.1603272832846.JavaMail.zimbra@dneg.com> <20201109160256.GB11144@fieldses.org> <1744768451.86186596.1605186084252.JavaMail.zimbra@dneg.com> <1055884313.92996091.1606250106656.JavaMail.zimbra@dneg.com> <20201124211522.GC7173@fieldses.org> <932244432.93596532.1606324491501.JavaMail.zimbra@dneg.com> <1403656117.98163597.1606998035261.JavaMail.zimbra@dneg.com> <20201203185109.GB27931@fieldses.org> <4903965f2beb742e0eca089b5db8aa3a4cabb7f0.camel@hammerspace.com> <20201203211328.GC27931@fieldses.org>
In-Reply-To: <20201203211328.GC27931@fieldses.org>
Subject: RE: Adventures in NFS re-exporting
Date:   Thu, 3 Dec 2020 13:32:34 -0800
Message-ID: <018d01d6c9bb$d16eb890$744c29b0$@mindspring.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 15.0
Content-Language: en-us
Thread-Index: AQH6EgB+BqEYpR696aBJdQxY01PEsQE5qoLXAZr58eYBXdorRQGLCl71AmNKoMYCNz3+KwLk8e1kAiMUAnUCTLaWVAKf+tSuqPzrGvA=
X-ELNK-Trace: 136157f01908a8929c7f779228e2f6aeda0071232e20db4d7249f465b171b271a08ce68149647c55350badd9bab72f9c350badd9bab72f9c350badd9bab72f9c
X-Originating-IP: 76.105.143.216
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

> On Thu, Dec 03, 2020 at 08:27:39PM +0000, Trond Myklebust wrote:
> > On Thu, 2020-12-03 at 13:51 -0500, bfields wrote:
> > > I've been scratching my head over how to handle reboot of a re-
> > > exporting server.  I think one way to fix it might be just to =
allow
> > > the re- export server to pass along reclaims to the original =
server
> > > as it receives them from its own clients.  It might require some
> > > protocol tweaks, I'm not sure.  I'll try to get my thoughts in =
order
> > > and propose something.
> > >
> >
> > It's more complicated than that. If the re-exporting server reboots,
> > but the original server does not, then unless that re-exporting =
server
> > persisted its lease and a full set of stateids somewhere, it will =
not
> > be able to atomically reclaim delegation and lock state on the =
server
> > on behalf of its clients.
>=20
> By sending reclaims to the original server, I mean literally sending =
new
> open and lock requests with the RECLAIM bit set, which would get brand
> new stateids.
>=20
> So, the original server would invalidate the existing client's =
previous
> clientid and stateids--just as it normally would on reboot--but it =
would
> optionally remember the underlying locks held by the client and allow
> compatible lock reclaims.
>=20
> Rough attempt:
>=20
> 	https://wiki.linux-nfs.org/wiki/index.php/Reboot_recovery_for_re-
> export_servers
>=20
> Think it would fly?

At a quick read through, that sounds good. I'm sure there's some bits =
and bobs we need to fix up.

I'm cc:ing Jeff Layton because what the original server needs to do =
looks a bit like what he implemented in CephFS to allow HA restarts of =
nfs-ganesha instances.

Maybe we should take this to the IETF mailing list? I'm certainly =
interested in discussion on what we could do in the protocol to =
facilitate this from nfs-ganesha perspective.

Frank



