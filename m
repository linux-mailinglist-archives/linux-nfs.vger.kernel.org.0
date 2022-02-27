Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D25D14C5FF0
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Feb 2022 00:51:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231375AbiB0Xvg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 27 Feb 2022 18:51:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiB0Xvf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 27 Feb 2022 18:51:35 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C78C049FB9
        for <linux-nfs@vger.kernel.org>; Sun, 27 Feb 2022 15:50:57 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 632D01F891;
        Sun, 27 Feb 2022 23:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1646005856; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dSJTncVvco70M4Slorpug5TivvbDPMgomp5jzqRdNI8=;
        b=McEchP5YcYud1tKtzohz2L85Ttfwymtlwjo2cM4oFUzjf6l+M0FvAaq11fIfhRaP8wX1ub
        MJ8IzEZurcQEwxNsrLGBzh5gDD2grCCuDH+neKBsdN3vSui2TSJk0Z5a/LTyGqwuTqA24Q
        0OIumspmYgrXOf4q9kvvwWIZiLh2Cww=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1646005856;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dSJTncVvco70M4Slorpug5TivvbDPMgomp5jzqRdNI8=;
        b=TPI0SVW88zLKJT9QNkiVOjvaTpT+21ee/7ey63Pl6f9h96CROhi/Z/T8toreyvF3LLSP8B
        A5fWduBmlmFS6hAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0087712FC5;
        Sun, 27 Feb 2022 23:50:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 59d+K14OHGKvKwAAMHmgww
        (envelope-from <neilb@suse.de>); Sun, 27 Feb 2022 23:50:54 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Benjamin Coddington" <bcodding@redhat.com>
Cc:     "Trond Myklebust" <trondmy@hammerspace.com>,
        anna.schumaker@netapp.com, linux-nfs@vger.kernel.org
Subject: Re: [PATCH] NFSv4: use unique client identifiers in network namespaces
In-reply-to: <7CDAEA98-3A8D-459A-80FE-82AA58A4EDA2@redhat.com>
References: =?utf-8?q?=3C6e05bf321ff50785360e6c339d111db368e7dfda=2E16443499?=
 =?utf-8?q?90=2Egit=2Ebcodding=40redhat=2Ecom=3E=2C?=
 <189aba691b341f64f653817c9cdf018ef34ac257.camel@hammerspace.com>,
 <7CDAEA98-3A8D-459A-80FE-82AA58A4EDA2@redhat.com>
Date:   Mon, 28 Feb 2022 10:50:52 +1100
Message-id: <164600585213.15631.6635814364853064416@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 09 Feb 2022, Benjamin Coddington wrote:
> On 8 Feb 2022, at 15:27, Trond Myklebust wrote:
>=20
> > On Tue, 2022-02-08 at 15:03 -0500, Benjamin Coddington wrote:
> >> In order to differentiate client state, assign a random uuid to the
> >> uniquifing portion of the client identifier when a network namespace
> >> is
> >> created.=C2=A0 Containers may still override this value if they wish to
> >> maintain
> >> stable client identifiers by writing to
> >> /sys/fs/nfs/net/client/identifier,
> >> either by udev rules or other means.
> >>
> >> Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
> >> ---
> >> =C2=A0fs/nfs/sysfs.c | 14 ++++++++++++++
> >> =C2=A01 file changed, 14 insertions(+)
> >>
> >> diff --git a/fs/nfs/sysfs.c b/fs/nfs/sysfs.c
> >> index 8cb70755e3c9..9b811323fd7f 100644
> >> --- a/fs/nfs/sysfs.c
> >> +++ b/fs/nfs/sysfs.c
> >> @@ -167,6 +167,18 @@ static struct nfs_netns_client
> >> *nfs_netns_client_alloc(struct kobject *parent,
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return NULL;
> >> =C2=A0}
> >> =C2=A0
> >> +static void assign_unique_clientid(struct nfs_netns_client *clp)
> >> +{
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unsigned char client_uuid[16];
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0char *uuid_str =3D kmalloc(UU=
ID_STRING_LEN + 1,=20
> >> GFP_KERNEL);
> >> +
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (uuid_str) {
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0generate_random_uuid(client_uuid);
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0sprintf(uuid_str, "%pU", client_uuid);
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0rcu_assign_pointer(clp->identifier,=20
> >> uuid_str);
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> >> +}
> >> +
> >> =C2=A0void nfs_netns_sysfs_setup(struct nfs_net *netns, struct net *net)
> >> =C2=A0{
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct nfs_netns_client =
*clp;
> >> @@ -174,6 +186,8 @@ void nfs_netns_sysfs_setup(struct nfs_net *netns,
> >> struct net *net)
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0clp =3D nfs_netns_client=
_alloc(nfs_client_kobj, net);
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (clp) {
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0netns->nfs_client =3D clp;
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0if (net !=3D &init_net)
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0assign_u=
nique_clientid(clp);
> >
> > Why shouldn't this go in nfs_netns_client_alloc? At this point you've
> > already published the pointer in netns, so you're prone to races.
>=20
> No reason it shouldn't, I'll put it there if that's what you want.
>=20
> I thought that's why it was RCU-ed, and figured we'd just do it before=20
> the
> uevent.
>=20
> > Also, why the exclusion of init_net?
>=20
> Because we're unique enough if we're not in a network namespace, and any
> additional uniqueness we might need (due to NAT, or cloned VMs) /should/=20
> be
> getting from udev, as you envisioned.  That way, if we are getting
> uniquified, its from a source that's likely persistent/deterministic. =20
> If we
> just generate a random uniquifier, its going to be different next boot=20
> if
> there's no udev rule and userspace helpers.  That's going to make things=20
> a
> lot worse for simple setups.

I liked this patch at first, but I no longer think it is a good idea.

It is quite possible today for containers to provide sufficient
uniqueness simply by setting a unique hostname before the first NFS
mount.
Quite possibly some containers already do this, and are working
perfectly.

If we add new randomness, the they will get a different identifier on
each boot.  This is bad for exactly the same reason that it is bad for
"net =3D=3D &init_net".

i.e.  I believe this patch could cause a regression for working sites.
The regression may not be immediately obvious, but it may still be
there.
For this reason, I think this patch should be dropped.

Thanks,
NeilBrown
