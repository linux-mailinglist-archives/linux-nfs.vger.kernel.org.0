Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88B63683953
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Jan 2023 23:28:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbjAaW21 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 31 Jan 2023 17:28:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbjAaW21 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 31 Jan 2023 17:28:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9AC213D41
        for <linux-nfs@vger.kernel.org>; Tue, 31 Jan 2023 14:28:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6C9FD61735
        for <linux-nfs@vger.kernel.org>; Tue, 31 Jan 2023 22:28:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C6BDC4339B;
        Tue, 31 Jan 2023 22:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675204104;
        bh=JKdB9IsajCVWV4+43C6R+YyaTxibwoa44AlFzNNAR2Y=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=FUM1O4bflRyTBHa1l6A0vmCnCG/9CArrAn/em/mDeZAzTput0xtuT6Gwez7v60AqP
         BeO7gncWSTvfwJb70dvi9ZObU2P63c4ngV01qBbX5wjXoXCRWbuhoOsiuA5m8b8EwK
         Y8SUoj1nHowJxT4zouxhepgaDiY9OAh+hkz4u44OqF3o6gamZtkJ3IeVRZjuKJF/7i
         WdAGtU62+AQT+Ytl/AEsY0SmYE9nsb96sr14Cbs2Pm1gq9Qx4R98PiGnr4FGVBVfDJ
         olIqhdm52c6K38qwWrXOXceul26sHBql9DfHOkMuOJ/kdhMAkrCc4aEgbC+CZI1YU+
         J0wjxHaYhAR2Q==
Message-ID: <5c2856f1408d801b9fede6478071c94b755376bf.camel@kernel.org>
Subject: Re: Zombie / Orphan open files
From:   Jeff Layton <jlayton@kernel.org>
To:     Olga Kornievskaia <aglo@umich.edu>,
        "Andrew J. Romero" <romero@fnal.gov>
Cc:     Chuck Lever III <chuck.lever@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Date:   Tue, 31 Jan 2023 17:28:22 -0500
In-Reply-To: <CAN-5tyGdaL_pYgqgS0TDwqCzVu=0rgLau8TDZMTe+hmC395UtQ@mail.gmail.com>
References: <YQBPR01MB10724B629B69F7969AC6BDF9586C89@YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM>
         <YQBPR01MB10724AEE306F99C844101EED086CF9@YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM>
         <YQBPR01MB10724F79460F3C02361279E8686CF9@YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM>
         <654e3b7d15992d191b2b2338483f29aec8b10ee1.camel@kernel.org>
         <YQBPR01MB10724B36E378F493B9DED3C7E86D39@YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM>
         <3c02bd2df703a68093db057c51086bbf767ffeb1.camel@kernel.org>
         <YQBPR01MB1072428BC706EE8C5CC34341186D39@YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM>
         <936efa478e786be19cb9715eba1941ebc4f94a1b.camel@kernel.org>
         <SA1PR09MB75521717AA00DCAD6CAB5118A7D39@SA1PR09MB7552.namprd09.prod.outlook.com>
         <2bc328a4a292eb02681f8fc6ea626e83f7a3ae85.camel@kernel.org>
         <SA1PR09MB75528A7E45898F6A02EDF82EA7D09@SA1PR09MB7552.namprd09.prod.outlook.com>
         <0BBE155A-CE56-40F7-A729-85D67A9C0CC3@oracle.com>
         <SA1PR09MB755212AB7E5C5481C45028A8A7D09@SA1PR09MB7552.namprd09.prod.outlook.com>
         <CAN-5tyHOJ=qXUU73VsZC9Ezs7_-eZ46VDtiE_DWB3bdyr768gA@mail.gmail.com>
         <SA1PR09MB7552C7543CE6E9D263C070D4A7D09@SA1PR09MB7552.namprd09.prod.outlook.com>
         <CAN-5tyGdaL_pYgqgS0TDwqCzVu=0rgLau8TDZMTe+hmC395UtQ@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 2023-01-31 at 17:14 -0500, Olga Kornievskaia wrote:
> On Tue, Jan 31, 2023 at 2:55 PM Andrew J. Romero <romero@fnal.gov> wrote:
> >=20
> >=20
> >=20
> > > What you are describing sounds like a bug in a system (be it client o=
r
> > > server). There is state that the client thought it closed but the
> > > server still keeping that state.
> >=20
> > Hi Olga
> >=20
> > Based on my simple test script experiment,
> > Here's a summary of what I believe is happening
> >=20
> > 1. An interactive user starts a process that opens a file or multiple f=
iles
> >=20
> > 2. A disruption, that prevents
> >    NFS-client <-> NFS-server communication,
> >    occurs while the file is open.  This could be due to
> >    having the file open a long time or due to opening the file
> >    too close to the time of disruption.
> >=20
> > ( I believe the most common "disruption" is
> >   credential expiration )
> >=20
> > 3) The user's process terminates before the disruption
> >      is cleared.  ( or stated another way ,  the disruption is not clea=
red until after the user
> >     process terminates )
> >=20
> >    At the time the user process terminates, the process
> >    can not tell the server to close the server-side file state.
> >=20
> >   After the process terminates, nothing will ever tell the server
> >   to close the files.  The now zombie open files will continue to
> >   consume server-side resources.
> >=20
> >   In environments with many users, the problem is significant
> >=20
> > My reasons for posting:
> >=20
> > - Are not to have your team  help troubleshoot my specific issue
> >    ( that would be quite rude )
> >=20
> > they are:
> >=20
> > - Determine If my NAS vendor might be accidentally
> >   not doing something they should be.
> >   (  I now don't really think this is the case. )
>=20
> It's hard to say who's at fault here without having some more info
> like tracepoints or network traces.
>=20
> > - Determine if this is a known behavior common to all NFS implementatio=
ns
> >    ( Linux, ....etc ) and if so have your team determine if this is a p=
roblem that should be addressed
> >    in the spec and the implementations.
>=20
> What you describe  --- having different views of state on the client
> and server -- is not a known common behaviour.
>=20
> I have tried it on my Kerberos setup.
> Gotten a 5min ticket.
> As a user opened a file in a process that went to sleep.
> My user credentials have expired (after 5mins). I verified that by
> doing an "ls" on a mounted filesystem which resulted in permission
> denied error.
> Then I killed the application that had an opened file. This resulted
> in a NFS CLOSE being sent to the server using the machine's gss
> context (which is a default behaviour of the linux client regardless
> of whether or not user's credentials are valid).
>=20
> Basically as far as I can tell, a linux client can handle cleaning up
> state when user's credentials have expired.
> >=20

That's pretty much what I expected from looking at the code. I think
this is done via the call to nfs4_state_protect. That calls:

       if (test_bit(sp4_mode, &clp->cl_sp4_flags)) {                  =20
                msg->rpc_cred =3D rpc_machine_cred();
                ...                           =20
       }

Could it be that cl_sp4_flags doesn't have NFS_SP4_MACH_CRED_CLEANUP set
on his clients? AFAICT, that comes from the server. It also looks like
cl_sp4_flags may not get set on a NFSv4.0 mount.

Olga, can you test that with a v4.0 mount?
--=20
Jeff Layton <jlayton@kernel.org>
