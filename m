Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D99B3683176
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Jan 2023 16:26:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233218AbjAaP01 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 31 Jan 2023 10:26:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233216AbjAaPZw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 31 Jan 2023 10:25:52 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC27E6E90
        for <linux-nfs@vger.kernel.org>; Tue, 31 Jan 2023 07:24:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 97899B81D1B
        for <linux-nfs@vger.kernel.org>; Tue, 31 Jan 2023 15:24:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD311C433EF;
        Tue, 31 Jan 2023 15:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675178688;
        bh=ko+GrHLwk3V6Oq+V6kfiA/dCKDDJs//JbZWDothNtaA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ZN5LK9ysFsNxo4IzN6IV5OCKcRAe5jjmIBWkOu8KNhEblc4tMAFNn+4MGhOlNxA/6
         Ek7vKhobKvvRsUYgWPRgQnDKPZ2fQNRCD0T484qfK7hnva0oI7ffw170fA+AmdNBIc
         06LprVgGwmxy+D+PUvJhVj+UkEfcoOn4kDDSRhJfklJxYDGu5XOUJ746pbojIIJIEq
         qJj1T8Epjknlu/19zhibCGpoJyw4m2N3kkgl9CEkyCghqyjniYbrHHUrze7wT2+21z
         vt9C7NZEmYLg5YizFsFCsDJnO8lLhOxszE1vmRIOND6OTONaLEIauDDpZ81Ud0YZYe
         +WDSc99s6T11w==
Message-ID: <c9cd6a0bd4d709795943119603541fb40e2d8a8d.camel@kernel.org>
Subject: Re: Zombie / Orphan open files
From:   Jeff Layton <jlayton@kernel.org>
To:     "Andrew J. Romero" <romero@fnal.gov>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Cc:     Chuck Lever <chuck.lever@oracle.com>
Date:   Tue, 31 Jan 2023 10:24:46 -0500
In-Reply-To: <SA1PR09MB75528A7E45898F6A02EDF82EA7D09@SA1PR09MB7552.namprd09.prod.outlook.com>
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

On Tue, 2023-01-31 at 14:42 +0000, Andrew J. Romero wrote:
>=20
> > From: Jeff Layton <jlayton@kernel.org>
> =20
> > What do you mean by "zombie / orphan" here? Do you mean files that have
> > been sillyrenamed [1] to ".nfsXXXXXXX" ? Or are you simply talking abou=
t
> > clients that are holding files open for a long time?
>=20
> Hi Jeff
>=20
> .... clients that are holding files open for a long time
>=20
> Here's a complete summary:
>=20
> On my NAS appliances , I noticed that average usage of the relevant memor=
y pool
> never went down. I suspected some sort of "leak" or "file-stuck-open" sce=
nario.
>=20
> I hypothesized that if NFS-client to NFS-server communications were frequ=
ently disrupted,
> this would explain the memory-pool behavior I was seeing.
> I felt that Kerberos credential expiration was the most likely frequent d=
isruptor.
>=20
> I ran a simple python test script that (1) opened enough files that I cou=
ld see an obvious jump
> in the relevant NAS memory pool metric, then (2) went to sleep for shorte=
r than the
> Kerberos ticket lifetime, then (3) exited without explicitly closing the =
files.
>  The result:  After the script exited,  usage of the relevant server-side=
 memory pool decreased by
> the expected amount.
>=20
> Then I ran a simple python test script that (1) opened enough files that =
I could see an obvious jump
> in the relevant NAS memory pool metric, then (2) went to sleep for longer=
 than the
> Kerberos ticket lifetime, then (3) exited without explicitly closing the =
files.
>  The result:  After the script exited,  usage of the relevant server-side=
 memory pool did not decrease.
> ( the files opened by the script were permanently "stuck open" ... deplet=
ing the server-side pool resource)
>=20
> In a large campus environment, usage of the relevant memory pool will eve=
ntually get so
> high that a server-side reboot will be needed.
>=20
> I'm working with my NAS vendor ( who is very helpful ); however, if the N=
FS server and client specifications
> don't specify an official way to handle this very real problem, there is =
not much a NAS server vendor can safely / responsibly do.
>=20
> If there currently is no formal/official way of handling this issue ( ser=
ver-side pool exhaustion due to "disappearing" client )
> is this a problem worth solving ( at a level lower than the application l=
evel )?
>=20
> If client applications were all well behaved ( didn't leave files open fo=
r long periods of time ) we wouldn't have a significant issue.
> Assuming applications aren't going to be well behaved, are there good gen=
eral ways of solving this on either the client or server side ?
>=20

Yeah, that's an interesting problem. From the server's standpoint, we're
just doing what the client asked. It asked for an open stateid and we
gave it one. It's up to the client to release it, as long as it keeps
renewing its lease.

Would it be wrong for to use client creds for CLOSE or OPEN_DOWNGRADE
RPCs when the appropriate user creds are not available? The client is
just releasing resources, after all, which seems like something that
ought not require a specific set of creds on the server.

--=20
Jeff Layton <jlayton@kernel.org>
