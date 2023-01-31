Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 476626834F0
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Jan 2023 19:13:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbjAaSNi (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 31 Jan 2023 13:13:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjAaSNi (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 31 Jan 2023 13:13:38 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 386291027D
        for <linux-nfs@vger.kernel.org>; Tue, 31 Jan 2023 10:13:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C339F61631
        for <linux-nfs@vger.kernel.org>; Tue, 31 Jan 2023 18:13:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5C67C433EF;
        Tue, 31 Jan 2023 18:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675188816;
        bh=gIXaTvsl0L7t4Ghe8H0IKcSuyVG32tx8GsVPlQxP0zw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Jpim2Hdl00XzBC3zDNihvixNAkwz9YToGI39Rv4TaHtPRYCW5UgwVW914XAHmP4HV
         58wEkBw5lUMJcHuYgh6K8HNyOJg4ozMZrDHxUJ4+jhtq/SMih2MuMC52z/iksyWO7p
         owvdqbkss6vgNg6egMmidovggC5P/ZNxoc6zGH+k/Q+L+mpKPhFYWGI9AF8uzLOXqY
         75vnGyfutZhqOu1H+mvrW1mDc1+4cdDRPQBupaK1pbklSvZ3F5CeuTp4sCs/mW7mlh
         ZFx66P273N2HoYKyYA7Gnt18cGEooCbY4mrDJ4BYKzNw7kDVZKxF+IcA/nO15if2Eg
         XDHfUoHnw3cZA==
Message-ID: <94acb98a90e9b11cf8eac50ec215befc33023436.camel@kernel.org>
Subject: Re: Zombie / Orphan open files
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever III <chuck.lever@oracle.com>,
        "Andrew J. Romero" <romero@fnal.gov>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Date:   Tue, 31 Jan 2023 13:13:34 -0500
In-Reply-To: <0BBE155A-CE56-40F7-A729-85D67A9C0CC3@oracle.com>
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
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 2023-01-31 at 16:34 +0000, Chuck Lever III wrote:
>=20
> > On Jan 31, 2023, at 9:42 AM, Andrew J. Romero <romero@fnal.gov> wrote:
> >=20
> > In a large campus environment, usage of the relevant memory pool will e=
ventually get so
> > high that a server-side reboot will be needed.
>=20
> The above is sticking with me a bit.
>=20
> Rebooting the server should force clients to re-establish state.
>=20
> Are they not re-establishing open file state for users whose
> ticket has expired? I would think each client would re-establish
> state for those open files anyway, and the server would be in the
> same overcommitted state it was in before it rebooted.
>=20
> We might not have an accurate root cause analysis yet, or I could
> be missing something.
>=20

My assumption was that the client wasn't able to get credentials to run
the CLOSE RPC in this case, so it can't properly send the call. That's a
big assumption though. It'd be good to confirm this.

It looks like the CLOSE codepath on the client calls nfs4_state_protect
with NFS_SP4_MACH_CRED_CLEANUP, and that should make it use the machine
cred? I'm not 100% clear here though...it looks like that may be
conditional on what was sent by the server in EXCHANGE_ID.

FWIW, I don't see any reason we shouldn't use the machine cred for the
close compound. Nothing we do in there should require permission
checking.

BTW: is this NFSv4.0 or v4.1+ (or a mix)?
--=20
Jeff Layton <jlayton@kernel.org>
