Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD72F49EE2F
	for <lists+linux-nfs@lfdr.de>; Thu, 27 Jan 2022 23:41:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237959AbiA0Wlc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 27 Jan 2022 17:41:32 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:50364 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbiA0Wlb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 27 Jan 2022 17:41:31 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 992D91F391;
        Thu, 27 Jan 2022 22:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1643323289; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7jeK6qAfgdjs0c4Od3y+Dw74C4BYLxtyDSaeA4UomaQ=;
        b=fP0BRp3F9o6JkMlBVvlIjhIF3+qvnlMnmj36Wt8ZzhTuonAkPZeRFi4G5rJZ06UbQuhyMr
        f17VAk92A4A7f7vf63mPaC4ITIxBeVURE12FEyhznpCl71d8ulT7RP6AaUrvWTU5aKpRFZ
        5c50hBdkziB9zauxnjf5prYtmzYbnLw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1643323289;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7jeK6qAfgdjs0c4Od3y+Dw74C4BYLxtyDSaeA4UomaQ=;
        b=d67QifSuoGDJWOO8TbtDTy+Gt5gu8yfgXwQ6PaEyBYUZZ+K/DJesollW/6Em3ElUuGBG1P
        mWE2kFfODUnXq0BA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C68E113CFF;
        Thu, 27 Jan 2022 22:41:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id y8YBIZgf82GyGAAAMHmgww
        (envelope-from <neilb@suse.de>); Thu, 27 Jan 2022 22:41:28 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Chuck Lever III" <chuck.lever@oracle.com>
Cc:     "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>
Subject: Re: [RFC PATCH 0/4] nfsd: allow NFSv4 state to be revoked.
In-reply-to: <7B388FE8-1109-4EDD-B716-661870B446C7@oracle.com>
References: <164325908579.23133.4781039121536248752.stgit@noble.brown>,
 <7B388FE8-1109-4EDD-B716-661870B446C7@oracle.com>
Date:   Fri, 28 Jan 2022 09:41:24 +1100
Message-id: <164332328424.5493.16812905543405189867@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 28 Jan 2022, Chuck Lever III wrote:
> Hi Neil-
>=20
> > On Jan 26, 2022, at 11:58 PM, NeilBrown <neilb@suse.de> wrote:
> >=20
> > If a filesystem is exported to a client with NFSv4 and that client holds
> > a file open, the filesystem cannot be unmounted without either stopping t=
he
> > NFS server completely, or blocking all access from that client
> > (unexporting all filesystems) and waiting for the lease timeout.
> >=20
> > For NFSv3 - and particularly NLM - it is possible to revoke all state by
> > writing the path to the filesystem into /proc/fs/nfsd/unlock_filesystem.
> >=20
> > This series extends this functionality to NFSv4.  With this, to unmount
> > an exported filesystem is it sufficient to disable export of that
> > filesystem, and then write the path to unlock_filesystem.
> >=20
> > I've cursed mainly on NFSv4.1 and later for this.  I haven't tested
> > yet with NFSv4.0 which has different mechanisms for state management.
> >=20
> > If this series is seen as a general acceptable approach, I'll look into
> > the NFSv4.0 aspects properly and make sure it works there.
>=20
> I've browsed this series and need to think about:
> - whether we want to enable administrative state revocation and
> - whether NFSv4.0 can support that reasonably
>=20
> In particular, are there security consequences for revoking
> state? What would applications see, and would that depend on
> which minor version is in use? Are there data corruption risks
> if this facility were to be misused?

The expectation is that this would only be used after unexporting the
filesystem.  In that case, the client wouldn't notice any difference
from the act of writing to unlock_filesystem, as the entire filesystem
would already be inaccessible.

If we did unlock_filesystem a filesystem that was still exported, the
client would see similar behaviour to a network partition that was of
longer duration than the lease time.   Locks would be lost.

>=20
> Also, Dai's courteous server work is something that potentially
> conflicts with some of this, and I'd like to see that go in
> first.

I'm perfectly happy to wait for the courteous server work to land before
pursuing this.

>=20
> Do you have specific user requests for this feature, and if so,
> what are the particular usage scenarios?

It's complicated....

The customer has an HA config with multiple filesystem resource which
they want to be able to migrate independently.  I don't think we really
support that, but they seem to want to see if they can make it work (and
it should be noted that I talk to an L2 support technician who talks to
the customer representative, so I might be getting the full story).

Customer reported that even after unexporting a filesystem, they cannot
then unmount it.  Whether or not we think that independent filesystem
resources is supportable, I do think that the customer should have a
clear path for unmounting a filesystem without interfering with service
provided from other filesystems.  Stopping nfsd would interfere with
that service by forcing a grace-period on all filesystems.
The RFC explicitly supports admin-revocation of state, and that would
address this specific need, so it seemed completely appropriate to
provide it.

As an aside ...  I'd like to be able to suggest that the customer use
network namespaces for the different filesystem resources.  Each could
be in its own namespace and managed independently.  However I don't
think we have good admin infrastructure for that do we?

I'd like to be able to say "set up these 2 or 3 config files and run=20
systemctl start nfs-server@foo and the 'foo' network namespace will be
created, configured, and have an nfs server running".
Do we have anything approaching that?  Even a HOWTO ??

Thanks,
NeilBrown
