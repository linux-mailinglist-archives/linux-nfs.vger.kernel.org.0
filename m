Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0AB44B5DD0
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Feb 2022 23:40:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbiBNWkg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 14 Feb 2022 17:40:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231928AbiBNWkf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 14 Feb 2022 17:40:35 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05513145AFD
        for <linux-nfs@vger.kernel.org>; Mon, 14 Feb 2022 14:40:26 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id AE5BC1F38C;
        Mon, 14 Feb 2022 22:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1644878425; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2lJLstLDZJO6+H/8m0fwIYPGDSE4LDsDdxjHua867r8=;
        b=2R+1JyG2S6AYmpxkcdgpBe0AI+wOPVOBlR3wSKW3yoTv1VTKvZjUWWPFVspdCDhxM4Cy3/
        HsXJFmEjuIryNpqvNh99ppKq1V7AuoYo6IPtXngLmgTLBTg6u1WHpst21uhKWv/SkfHtoC
        gJUJfqRJ+Q++Mdg6avSoOS2SsF1m5Qs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1644878425;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2lJLstLDZJO6+H/8m0fwIYPGDSE4LDsDdxjHua867r8=;
        b=mkxAuDi5EgD31aJAwsjQmlYm0ra2XOSeUXsR/LdBMYGFt1aUHqrZRYyakEA48O3+EoHQOR
        lLwAnrh4Mpsx6ZAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4359D13BCC;
        Mon, 14 Feb 2022 22:40:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id gNQ4O1faCmJ+HAAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 14 Feb 2022 22:40:23 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Benjamin Coddington" <bcodding@redhat.com>
Cc:     "Chuck Lever III" <chuck.lever@oracle.com>,
        "Steve Dickson" <SteveD@RedHat.com>,
        "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] nfsuuid: a tool to create and persist nfs4 client
 uniquifiers
In-reply-to: <863AB69A-D5D6-4F22-950C-E5F468CD4552@redhat.com>
References: <cover.1644515977.git.bcodding@redhat.com>, =?utf-8?q?=3C9c04664?=
 =?utf-8?q?8bfd9c8260ec7bd37e0a93f7821e0842f=2E1644515977=2Egit=2Ebcodding?=
 =?utf-8?q?=40redhat=2Ecom=3E=2C?=
 <7642FA55-F3F2-4813-86E2-1B65185E6B36@oracle.com>,
 <3d2992df-7ef7-50ba-4f11-f4de588620d2@redhat.com>,
 <DDB59BD9-8C29-45C3-ABAF-B25EDDB63E09@oracle.com>,
 <D0908E76-C163-4DBF-A93C-665492EB9DB2@redhat.com>,
 <E2C56D5B-AC77-48D1-9AF6-268406648657@oracle.com>,
 <4657F9AE-3B9E-4992-9334-3FF1CF18EF31@redhat.com>,
 <C7533D80-25B3-4722-94A9-0440C48B8574@oracle.com>,
 <945849B4-BE30-434C-88E9-8E901AAFA638@redhat.com>,
 <06B01290-E375-455E-A6D7-419CA653A0D1@oracle.com>,
 <948D8123-E310-4A35-BF04-C030F20EA83C@redhat.com>,
 <164479707170.27779.15384523062754338136@noble.neil.brown.name>,
 <863AB69A-D5D6-4F22-950C-E5F468CD4552@redhat.com>
Date:   Tue, 15 Feb 2022 09:40:18 +1100
Message-id: <164487841838.17471.17533209830495307129@noble.neil.brown.name>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 14 Feb 2022, Benjamin Coddington wrote:
> On 13 Feb 2022, at 19:04, NeilBrown wrote:
>=20
> > On Sat, 12 Feb 2022, Benjamin Coddington wrote:
> >> On 11 Feb 2022, at 15:51, Chuck Lever III wrote:
> >>
> >>>> On Feb 11, 2022, at 3:16 PM, Benjamin Coddington
> >>>> <bcodding@redhat.com> wrote:
> >>>>
> >>>> On 11 Feb 2022, at 15:00, Chuck Lever III wrote:
> >>>>
> >>>>>> On Feb 11, 2022, at 2:30 PM, Benjamin Coddington
> >>>>>> <bcodding@redhat.com> wrote:
> >>>>>>
> >>>>>> All the arguments for exacting tolerances on how it should be named
> >>>>>> apply
> >>>>>> equally well to anything that implies its output will be used for
> >>>>>> nfs client
> >>>>>> ids, or host ids.
> >>>>>
> >>>>> I completely disagree with this assessment.
> >>>>
> >>>> But how, and in what way?  The tool just generates uuids, and spits
> >>>> them
> >>>> out, or it spits out whatever's in the file you specify, up to 64
> >>>> chars.  If
> >>>> we can't have uuid in the name, how can we have NFS or machine-id or
> >>>> host-id?
> >>>
> >>> We don't have a tool called "string" to get and set the DNS name of
> >>> the local host. It's called "hostname".
> >>>
> >>> The purpose of the proposed tool is to persist a unique string to be
> >>> used as part of an NFS client ID. I would like to name the tool based
> >>> on that purpose, not based on the way the content of the persistent
> >>> file happens to be arranged some of the time.
> >>>
> >>> When the tool generates the string, it just happens to be a UUID. It
> >>> doesn't have to be. The tool could generate a digest of the boot time
> >>> or the current time. In fact, one of those is usually part of certain
> >>> types of a UUID anyway. The fact that it is a UUID is totally not
> >>> relevant. We happen to use a UUID because it has certain global
> >>> uniqueness properties. (By the way, perhaps the man page could mention
> >>> that global uniqueness is important for this identifier. Anything with
> >>> similar guaranteed global uniqueness could be used).
> >>>
> >>> You keep admitting that the tool can output something that isn't a
> >>> UUID. Doesn't that make my argument for me: that the tool doesn't
> >>> generate a UUID, it manages a persistent host identifier. Just like
> >>> "hostname." Therefore "nfshostid". I really don't see how nfshostid
> >>> is just as miserable as nfsuuid -- hence, I completely disagree
> >>> that "all arguments ... apply equally well".
> >>
> >> Yes - your arguement is a good one.   I wasn't clear enough admitting
> >> you
> >> were right two emails ago, sorry about that.
> >>
> >> However, I still feel the same argument applied to "nfshostid"
> >> disqualifies
> >> it as well.  It doesn't output the nfshostid.  That, if it even contains
> >> the
> >> part outputted, is more than what's written out.
> >>
> >> In my experience with linux tools, nfshostid sounds like something I can
> >> use
> >> to set or retrieve the identifier for an NFS host, and this little tool
> >> does
> >> not do that.
> >>
> >
> > I agree.  This tool primarily does 1 thing - it sets a string which will
> > be the uniquifier using the the client_owner4.  So I think the word
> > "set" should appear in the name.  I also think the name should start "nfs=
".
> > I don't much care whether it is
> >   nfssetid
> >   nfs-set-uuid
> >   nfssetowner
> >   nfssetuniquifier
> >   nfssetidentity
> >   nfsidset
> > though perhaps I'd prefer
> >   nfs=3Dset=3Did
> >
> > If not given any args, it should probably print a usage message rather
> > than perform a default action, to reduce the number of holes in feet.
> >
> > .... Naming  - THE hard problem of computer engineering ....
>=20
> No, it does NOT set the uniquifier string.  It returns it on stdout.  If
> you run it without args it just prints the string.  Its completely harmless.

Ahhh... I missed that.
Hence the "%c" magic in the udev rules, which takes the output and
stores it in the attribute.
This is a defensible approach if the tool will always be used with udev
... but you know what I think of using udev here.

Nevertheless, the main purpose when running this program is to set the
identity, even though the current implementation offloads some of the
work to udev.
So I think it should do exactly that and be named accordingly.

NeilBrown
