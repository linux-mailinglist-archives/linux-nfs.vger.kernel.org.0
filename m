Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 259A8682DDC
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Jan 2023 14:27:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231797AbjAaN1s (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 31 Jan 2023 08:27:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232043AbjAaN1r (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 31 Jan 2023 08:27:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF03D2410E
        for <linux-nfs@vger.kernel.org>; Tue, 31 Jan 2023 05:27:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3298DB81C98
        for <linux-nfs@vger.kernel.org>; Tue, 31 Jan 2023 13:27:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E20FC433EF;
        Tue, 31 Jan 2023 13:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675171662;
        bh=d+rqoTZMeYfHaktCLloZDDD++glDPeRJLJPrRCrTaq4=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=XGjDepBEz/o/QC8XnClqjWYFsqzC/qVUwdsIB3W2Kk5EuTH+1W9MYiD5pK0xz/Rtk
         AjmIwxUpN3fhcgTZJrPttsfPFXi7r1rOc3IFBK+ndB9Zn4uBeaixquZAcTLdVUfLoI
         JpdgWqB2C58IIVah3DR2bQXRGXAq7fnk6HTHvhYEIzyhm7wMasCv9JHcqRGct6u7+V
         8WCPf2qEeoqmUWZxJPBl6/otbhpcw3afwYvGPiKbI5j3n5nqcpoJ6vqv7Y7zK5M4o1
         DbZgFoS1zp+Jgy8K6t87qdTkkpW2+7fYldpIX0z1gj3/kgn0xkeSizTgB1+Fj7WZKh
         XVl5WIwifN0Fg==
Message-ID: <2bc328a4a292eb02681f8fc6ea626e83f7a3ae85.camel@kernel.org>
Subject: Re: Zombie / Orphan open files
From:   Jeff Layton <jlayton@kernel.org>
To:     "Andrew J. Romero" <romero@fnal.gov>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Date:   Tue, 31 Jan 2023 08:27:41 -0500
In-Reply-To: <SA1PR09MB75521717AA00DCAD6CAB5118A7D39@SA1PR09MB7552.namprd09.prod.outlook.com>
References: <YQBPR01MB10724B629B69F7969AC6BDF9586C89@YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM>
         <YQBPR01MB10724AEE306F99C844101EED086CF9@YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM>
         <YQBPR01MB10724F79460F3C02361279E8686CF9@YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM>
         <654e3b7d15992d191b2b2338483f29aec8b10ee1.camel@kernel.org>
         <YQBPR01MB10724B36E378F493B9DED3C7E86D39@YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM>
         <3c02bd2df703a68093db057c51086bbf767ffeb1.camel@kernel.org>
         <YQBPR01MB1072428BC706EE8C5CC34341186D39@YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM>
         <936efa478e786be19cb9715eba1941ebc4f94a1b.camel@kernel.org>
         <SA1PR09MB75521717AA00DCAD6CAB5118A7D39@SA1PR09MB7552.namprd09.prod.outlook.com>
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

On Mon, 2023-01-30 at 22:11 +0000, Andrew J. Romero wrote:
> Hi
>=20
> This is a quick general NFS server question.
>=20
> Does the NFSv4x  specification require or recommend that:   the NFS serve=
r, after some reasonable time,=20
> should / must close orphan / zombie open files ?
>=20
> On several NAS platforms I have seen large numbers of orphan / zombie ope=
n files "pile up"=20
> as a result of Kerberos credential expiration.
>=20
> Does the Red Hat NFS server "deal with" orphan / zombie open files ?
>=20
> Thanks
>=20
> Andy Romero
> Fermilab
>=20

What do you mean by "zombie / orphan" here? Do you mean files that have
been sillyrenamed [1] to ".nfsXXXXXXX" ? Or are you simply talking about
clients that are holding files open for a long time?

--=20
Jeff Layton <jlayton@kernel.org>

[1]: https://linux-nfs.org/wiki/index.php/Server-side_silly_rename
