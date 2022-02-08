Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0086A4AE37C
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Feb 2022 23:23:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350060AbiBHWWr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 8 Feb 2022 17:22:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386583AbiBHU4I (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 8 Feb 2022 15:56:08 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBFF2C0612C3
        for <linux-nfs@vger.kernel.org>; Tue,  8 Feb 2022 12:56:06 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8CA601F383;
        Tue,  8 Feb 2022 20:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1644353765; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w7qulzs7l7p1FYvl0feBpI3DJ/fOLDz+kfJCkUNLat0=;
        b=b0Q4GEOfzTDF6NcSghAmCZCuZtBeKc4ZEmXf6/AtsMujdgRyPg2l10q+duXrvr9kenE88S
        3GxNf9VM0yZhpQy0enJwZ5paGRldSEQ3af6kCYPk1thjt87bgl1rxNREOFMsSvz74nXg0Z
        WXF10ZJT45QNPmNUHmAvQRS+iavx4y8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1644353765;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w7qulzs7l7p1FYvl0feBpI3DJ/fOLDz+kfJCkUNLat0=;
        b=dnVyenRFDr0iIXCvs2r6siOYwp6j6rYq5KOXY6b2VfA+xTy+tf6dw44Dbqbedo1BN1gLwb
        5hza1A8F/trOZ+AQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AF6C213780;
        Tue,  8 Feb 2022 20:56:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id E6thGuTYAmKcNAAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 08 Feb 2022 20:56:04 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Benjamin Coddington" <bcodding@redhat.com>
Cc:     "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>
Subject: Re: v4 clientid uniquifiers in containers/namespaces
In-reply-to: <A677D8A9-FD0B-43E5-82D6-E660CCB8B185@redhat.com>
References: <6CEC5101-0512-4082-81F8-BDFEC5B6DF3A@redhat.com>,
 <164428557862.27779.17375354328525752842@noble.neil.brown.name>,
 <A677D8A9-FD0B-43E5-82D6-E660CCB8B185@redhat.com>
Date:   Wed, 09 Feb 2022 07:56:00 +1100
Message-id: <164435376000.27779.4059629372785561121@noble.neil.brown.name>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 08 Feb 2022, Benjamin Coddington wrote:
> On 7 Feb 2022, at 20:59, NeilBrown wrote:
>=20
> > On Sun, 06 Feb 2022, Benjamin Coddington wrote:
> >> Hi all,
> >>
> >> Is anyone using a udev(-like) implementation with NETLINK_LISTEN_ALL_NSI=
D?
> >> It looks like that is at least necessary to allow the init namespaced ud=
ev
> >> to receive notifications on /sys/fs/nfs/net/nfs_client/identifier, which
> >> would be a pre-req to automatically uniquify in containers.
> >
> > Could you walk me through the reasoning here - or point me to where it
> > has been discussed.
>=20
> https://lore.kernel.org/linux-nfs/20210414181040.7108-1-steved@redhat.com/

Thanks.  I did remember that discussion though it was helpful to refresh
my memory, and to be sure there is nothing else.

>=20
> > It seems to me that mount.nfs is the place to set nfs_client/identifier.
> > It can be told (via /etc/nfs.conf or /etc/nfsmount.conf) how to generate
> > and where to store the identifier.  It can check the current value and
> > update if needed.  As long as the identifier is set before the first
> > mount, there is no rush.
> >
> > Why does it need to be done in response to a uevent??
>=20
> I think the assertion was that it was the only sensible way, and it does
> seem to be better than exposing yet another knob when all that's needed is a
> way to distinguish and persist NFS clients when network namespaces can come
> and go at any time, and there can be a lot of them.

"assertion" is an apt word.  There wasn't a whole lot of reasoned
argument, mostly just assertions.

The best argument was that "nfs.conf is not namespace aware", which is
only somewhat true.  Using "ip netnfs exec" will make
non-namepsace-aware tools work correctly in namespaces providing their
config files are in /etc/netns/NAME - they get bind-mounted over the
files in /etc.
And of course /etc/nfs.conf can be MADE namespace aware.

There is also a reasonable argument that auto-editiing /etc/nfs.conf
risks collision with an admin, but that is why we have /etc/nfs.conf.d

For me, the weakest part of the Steve's case was that he presented it as
"setting module parameters via nfs.conf" rather than "configuring client
identity via nfs.conf".  A number of the early negative responses were
focused on the distraction of a module parameter being involved.

The weakness for the alternative, of course, is the fact that using the
udev mechanism requires running udevd in each network namespace, which
is an unnecessary burden.

So I still STRONGLY think that the identity should be set by mount.nfs
reading (and writing) some file in /etc or /etc/netnfs/NAME, and I
weakly think that the file should be in /etc/nfs.conf.d/ so that the
reading is automagic.

Thanks,
NeilBrown
