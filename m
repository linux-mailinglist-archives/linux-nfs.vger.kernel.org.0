Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54E006C3539
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Mar 2023 16:11:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231588AbjCUPLj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 21 Mar 2023 11:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231561AbjCUPLe (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 21 Mar 2023 11:11:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C5AB113C2
        for <linux-nfs@vger.kernel.org>; Tue, 21 Mar 2023 08:11:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A81B961CBD
        for <linux-nfs@vger.kernel.org>; Tue, 21 Mar 2023 15:11:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9956CC433EF;
        Tue, 21 Mar 2023 15:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679411481;
        bh=k2p0L/2pV3jBUSKScaX8eINXK9sjX4wL6sN8pcrxIbU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=bGS0J6IVhqIX+x0Lk/ElzoPmQkZcnQJLGWBZ4p9Nqd7MKeNga/4vPXwCJPMhaxOvA
         PCWuwGMPkWL7mAeShnek91xFfB9rzvKEI0ZMg1wEvp7BUZpTN3zpxIsOKa6fNp/9jf
         HCVXyreSpKhhc8vKPPaPsNHmOV9cvbwmROVkby39scz6If2hZTU5pEMls7aS9uAFXN
         rglHBDKIQeM43oNSFo+G9hqfqHO1FhJgbg04kQfLiPmFWlf76SAHtvxY/7r+EdC8Dj
         51ZqvA1vVYY/liredVKAOQWcVDzsHV8Fpuo/g5N01f55FcAODQ+o9fdX0xSOa+BEFo
         I7fVCUWXt6Cbw==
Message-ID: <d1d1dcc9833a32c3530251c75c888a6156e200b0.camel@kernel.org>
Subject: Re: [PATCH v1 4/4] exports.man: Add description of xprtsec= to
 exports(5)
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Chuck Lever <cel@kernel.org>, Steve Dickson <SteveD@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Date:   Tue, 21 Mar 2023 11:11:19 -0400
In-Reply-To: <00B8D419-0F7F-43FB-8DA1-5C6BD93DE1A7@oracle.com>
References: <167932279970.3437.7130911928591001093.stgit@manet.1015granger.net>
         <167932295124.3437.894267501240103990.stgit@manet.1015granger.net>
         <fdfa374a7d5072c9b4606476b52f049a6a165ef9.camel@kernel.org>
         <00B8D419-0F7F-43FB-8DA1-5C6BD93DE1A7@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 2023-03-21 at 14:08 +0000, Chuck Lever III wrote:
>=20
> > On Mar 21, 2023, at 8:06 AM, Jeff Layton <jlayton@kernel.org> wrote:
> >=20
> > On Mon, 2023-03-20 at 10:35 -0400, Chuck Lever wrote:
> > > From: Chuck Lever <chuck.lever@oracle.com>
> > >=20
> > > Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> > > ---
> > > utils/exportfs/exports.man |   45 +++++++++++++++++++++++++++++++++++=
++++++++-
> > > 1 file changed, 44 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/utils/exportfs/exports.man b/utils/exportfs/exports.man
> > > index 54b3f8776ea6..cca9bb7b4aeb 100644
> > > --- a/utils/exportfs/exports.man
> > > +++ b/utils/exportfs/exports.man
> > > @@ -125,7 +125,49 @@ In that case you may include multiple sec=3D opt=
ions, and following options
> > > will be enforced only for access using flavors listed in the immediat=
ely
> > > preceding sec=3D option.  The only options that are permitted to vary=
 in
> > > this way are ro, rw, no_root_squash, root_squash, and all_squash.
> > > +.SS Transport layer security
> > > +The Linux NFS server supports the use of transport layer security to
> > > +protect RPC traffic between itself and its clients.
> > > +This can be in the form of a VPN, an ssh tunnel, or via RPC-with-TLS=
,
> > > +which uses TLSv1.3.
> >=20
> > This is a little awkward, as the NFS server really isn't involved at al=
l
> > at that level in the case of a VPN or ssh tunnel. How about:
> >=20
> > The Linux NFS server supports transport layer security (TLS) to protect
> > RPC traffic between itself and its clients via RPC-with-TLS which uses
> > TLSv1.3. Alternately, RPC traffic can be secured via a VPN, ssh tunnel
> > or similar mechanism that encrypts traffic in a way that is transparent
> > to the server.
>=20
> Sure, that expresses what I was after.
>=20
>=20
> > > .PP
> > > +Administrators may choose to require the use of
> > > +RPC-with-TLS to protect access to individual exports.
> > > +This is particularly useful when using non-cryptographic security
> > > +flavors such as
> > > +.IR sec=3Dsys .
> > > +The
> > > +.I xprtsec=3D
> > > +option, followed by a colon-delimited list of security policies,
> > > +can restrict access to the export to only clients that have negotiat=
ed
> > > +transport-layer security.
> > > +Currently supported transport layer security policies include:
> > > +.TP
> > > +.IR none
> > > +The server permits clients to access the export
> > > +without the use of transport layer security.
> > > +.TP
> > > +.IR tls
> > > +The server permits clients that have negotiated an RPC-with-TLS sess=
ion
> > > +without peer authentication (confidentiality only) to access the exp=
ort.
> > > +Clients are not required to offer an x.509 certificate
> > > +when establishing a transport layer security session.
> > > +.TP
> > > +.IR mtls
> > > +The server permits clients that have negotiated an RPC-with-TLS sess=
ion
> > > +with peer authentication to access the export.
> > > +The server requires clients to offer an x.509 certificate
> > > +when establishing a transport layer security session.
> > > +.PP
> > > +The default setting is
> > > +.IR xprtsec=3Dnone:tls:mtls .
> >=20
> > Shouldn't that list order be reversed? IOW, shouldn't we default to mtl=
s
> > first since it's more secure?
> >=20
> > It might also be good to spell out what the kernel does with an ordered
> > list here. In what order are these methods attempted and at what point
> > does the server give up?
>=20
> There's no order to this list. It's simply a list of
> transport layer security settings that the server will
> permit clients to use on this transport.
>=20
> The "ordered list" concept is from the MNT protocol.
> For xprtsec, there's no communication or negotiation
> of preferences with clients.
>=20

Duh, of course. That makes sense.

>=20
> > > +This is also known as "opportunistic mode".
> > > +The server permits clients to use any transport layer security mecha=
nism
> > > +to access the export.
> > > +.PP
> > > +The server administrator must install and configure
> > > +.BR tlshd
> > > +to handle transport layer security handshake requests from the local=
 kernel.
> >=20
> > In the event that tlshd isn't running, what happens? I assume we give u=
p
> > on TLS at that point, but how long does it take for the kernel to
> > realize that it's not there?
>=20
> If tlshd is not running, the handshake request fails immediately.
> There's no timeout needed thanks to netlink multi-cast.
>=20

Good, thanks!

>=20
> > > .SS General Options
> > > .BR exportfs
> > > understands the following export options:
> > > @@ -581,7 +623,8 @@ a character class wildcard match.
> > > .BR netgroup (5),
> > > .BR mountd (8),
> > > .BR nfsd (8),
> > > -.BR showmount (8).
> > > +.BR showmount (8),
> > > +.BR tlshd (8).
> > > .\".SH DIAGNOSTICS
> > > .\"An error parsing the file is reported using syslogd(8) as level NO=
TICE from
> > > .\"a DAEMON whenever
> > >=20
> > >=20
> >=20
> > --=20
> > Jeff Layton <jlayton@kernel.org>
>=20
> --
> Chuck Lever
>=20
>=20

--=20
Jeff Layton <jlayton@kernel.org>
