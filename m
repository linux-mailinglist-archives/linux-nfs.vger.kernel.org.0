Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F3E14AFF25
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Feb 2022 22:22:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233271AbiBIVVj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 9 Feb 2022 16:21:39 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:52006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233188AbiBIVVj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 9 Feb 2022 16:21:39 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CBC0C03BFE8
        for <linux-nfs@vger.kernel.org>; Wed,  9 Feb 2022 13:21:41 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B5581210F0;
        Wed,  9 Feb 2022 21:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1644441700; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ibgyRU2KPic+pXyEVDb/d4FQ2HzD/gbh8wDpZ90bTcE=;
        b=1bCL5DrpipPmafXH/NQzpOTrH8tg3btFZ1ELndd1po/mZ9xb+By1cwE3qZtLlBC9V6HUja
        abN/Qrdz5akbZyjqFV88KTDo04NFViFGfBom708lqbKa/bcIRbt3BG+Mk1gCyxDluJ8ucd
        yyP4QfAzB2BZW780H22sbtI8qTc+9kM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1644441700;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ibgyRU2KPic+pXyEVDb/d4FQ2HzD/gbh8wDpZ90bTcE=;
        b=LObEqUhLl5xXKDOIJBafrT6XTKnkG9chCbFfQufP4Eg7lYEZDGkyRYBN3aSmSAppyzH5iS
        9B9iQq5NyRbVnfBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 71C9713AD9;
        Wed,  9 Feb 2022 21:21:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id WlfgC2MwBGJmJQAAMHmgww
        (envelope-from <neilb@suse.de>); Wed, 09 Feb 2022 21:21:39 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Steve Dickson" <steved@redhat.com>
Cc:     "Benjamin Coddington" <bcodding@redhat.com>,
        linux-nfs@vger.kernel.org
Subject: Re: [nfs-utils PATCH] nfs4id: a tool to create and persist nfs4
 client uniquifiers
In-reply-to: <6cfb516d-0747-a749-b310-1368a2186307@redhat.com>
References: =?utf-8?q?=3Cc2e8b7c06352d3cad3454de096024fff80e638af=2E16439791?=
 =?utf-8?q?61=2Egit=2Ebcodding=40redhat=2Ecom=3E=2C?=
 <6f01c382-8da5-5673-30db-0c0099d820b5@redhat.com>,
 <0AB20C82-6200-46E0-A76C-62345DAF8A3A@redhat.com>,
 <6cfb516d-0747-a749-b310-1368a2186307@redhat.com>
Date:   Thu, 10 Feb 2022 08:21:35 +1100
Message-id: <164444169523.27779.10904328736784652852@noble.neil.brown.name>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 09 Feb 2022, Steve Dickson wrote:
>=20
> On 2/8/22 11:22 AM, Benjamin Coddington wrote:
> > On 8 Feb 2022, at 11:04, Steve Dickson wrote:
> >=20
> >> Hello,
> >>
> >> On 2/4/22 7:56 AM, Benjamin Coddington wrote:
> >>> The nfs4id program will either create a new UUID from a random source or
> >>> derive it from /etc/machine-id, else it returns a UUID that has already
> >>> been written to /etc/nfs4-id.=C2=A0 This small, lightweight tool is=20
> >>> suitable for
> >>> execution by systemd-udev in rules to populate the nfs4 client=20
> >>> uniquifier.
> >>>
> >>> Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
> >>> ---
> >>> =C2=A0 .gitignore=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> >>> =C2=A0 configure.ac=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 4 +
> >>> =C2=A0 tools/Makefile.am=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0=C2=A0 1 +
> >>> =C2=A0 tools/nfs4id/Makefile.am |=C2=A0=C2=A0 8 ++
> >>> =C2=A0 tools/nfs4id/nfs4id.c=C2=A0=C2=A0=C2=A0 | 184 ++++++++++++++++++=
+++++++++++++++++++++
> >>> =C2=A0 tools/nfs4id/nfs4id.man=C2=A0 |=C2=A0 29 ++++++
> >>> =C2=A0 6 files changed, 227 insertions(+)
> >>> =C2=A0 create mode 100644 tools/nfs4id/Makefile.am
> >>> =C2=A0 create mode 100644 tools/nfs4id/nfs4id.c
> >>> =C2=A0 create mode 100644 tools/nfs4id/nfs4id.man
> >> Just a nit... naming convention... In the past
> >> we never put the protocol version in the name.
> >> Do a ls tools and utils directory and you
> >> see what I mean....
> >>
> >> Would it be a problem to change the name from
> >> nfs4id to nfsid?
> >=20
> > Not at all..=20
> Good...
>=20
> > and I think there's a lot of room for naming discussions about
> > the file to store the id too:
> >=20
> > Trond sent /etc/nfs4_uuid
> > Neil suggests /etc/netns/NAME/nfs.conf.d/identity.conf
> > Ben sent /etc/nfs4-id (to match /etc/machine-id)
> Question... is it kosher to be writing /etc which is
> generally on the root filesystem?
>=20
> By far Neil suggestion is the most intriguing... but
> on the containers I'm looking at there no /etc/netns
> directory.
>=20
> I had to install the iproute package to do the
> "ip netns identify" which returns NULL...
> also adds yet another dependency on nfs-utils.
>=20
> So if "ip netns identify" does return NULL what directory
> path should be used?

I'm not sure if this has been explicitly answered or not, so just in
case...=20
  if "ip netns/identify" report NAME, then use /etc/netns/NAME/foo
  if it fails or report nothing, use /etc/foo

I think this is required whether we use nfs4-id, nfs-id, nfs-identity,
nfs.conf.d/identity.conf or any other file in /etc.

NeilBrown
