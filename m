Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA1113CAF7D
	for <lists+linux-nfs@lfdr.de>; Fri, 16 Jul 2021 01:02:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbhGOXFT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 15 Jul 2021 19:05:19 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:47594 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbhGOXFT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 15 Jul 2021 19:05:19 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 73ECF2031D;
        Thu, 15 Jul 2021 23:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1626390144; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qyGkJ1hsS1Zol+D2eq3hvIcD89VDtkbJiz1n+Wt2nM8=;
        b=xWcSpdZFrfB7SKR541wS8zk7svfg+q0IdTraF+Ed7ZiUvTWInz9Pm02B6/nVqKoC+F7BnX
        2NGm5waZeWBcj6peaB7cgk1KoWEajNVX8IBbmw8U2/EKf/XpDCZtA6UfqxZXr9FMQDKlVC
        btxVxICsVqOxhZT2+LHqHCW4GI7ycvU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1626390144;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qyGkJ1hsS1Zol+D2eq3hvIcD89VDtkbJiz1n+Wt2nM8=;
        b=SK0Y3VO/EjsZPuEu0rRV+VKv7jTERyS6c6Xq04tKoxFyxBCLC6Q/ptrVySK53qOmchLm9K
        S3OFuacjK0/HjYCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 45D2513C4B;
        Thu, 15 Jul 2021 23:02:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id GKZ4OXy+8GBsZwAAMHmgww
        (envelope-from <neilb@suse.de>); Thu, 15 Jul 2021 23:02:20 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Josef Bacik" <josef@toxicpanda.com>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        "Chuck Lever" <chuck.lever@oracle.com>, "Chris Mason" <clm@fb.com>,
        "David Sterba" <dsterba@suse.com>, linux-nfs@vger.kernel.org,
        "Wang Yugui" <wangyugui@e16-tech.com>,
        "Ulli Horlacher" <framstag@rus.uni-stuttgart.de>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH/RFC] NFSD: handle BTRFS subvolumes better.
In-reply-to: <edd94b15-90df-c540-b9aa-8eac89b6713b@toxicpanda.com>
References: <20210613115313.BC59.409509F4@e16-tech.com>,
 <20210310074620.GA2158@tik.uni-stuttgart.de>,
 <162632387205.13764.6196748476850020429@noble.neil.brown.name>,
 <edd94b15-90df-c540-b9aa-8eac89b6713b@toxicpanda.com>
Date:   Fri, 16 Jul 2021 09:02:16 +1000
Message-id: <162639013675.13764.11555673325105489888@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 16 Jul 2021, Josef Bacik wrote:
>=20
> I'm going to restate what I think the problem is you're having just so I'm =
sure=20
> we're on the same page.
>=20
> 1. We export a btrfs volume via nfsd that has multiple subvolumes.
> 2. We run find, and when we stat a file, nfsd doesn't send along our bogus =

> st_dev, it sends it's own thing (I assume?).  This confuses du/find because=
 you=20
> get the same inode number with different parents.
>=20
> Is this correct?  If that's the case then it' be relatively straightforward=
 to=20
> add another callback into export_operations to grab this fsid right?  Hell =
we=20
> could simply return the objectid of the root since that's unique across the=
=20
> entire file system.  We already do our magic FH encoding to make sure we ke=
ep=20
> all this straight for NFS, another callback to give that info isn't going t=
o=20
> kill us.  Thanks,

Fairly close.
As well as the fsid I need a "mounted-on" inode number, so one callback
to provide both would do.
If zero was reported, that would be equivalent to not providing the
callback.
- Is "u64" always enough for the subvol-id?
- Should we make these details available to user-space with a new STATX
  flag?
- Should it be a new export_operations callback, or new fields in
  "struct kstat" ??

... though having asked those question, I begin to wonder if I took a
wrong turn.
I can already get some fsid information form statfs, though it is only
64bits and for BTRFS is combines the filesystem uuid and the subvol
id.  For that reason I avoided it.

But I'm already caching the fsid for the export-point.  If, when I find
a different fsid lower down, I xor the result with the export-point
fsid, the result would be fairly clean (the xor difference between the
two subvol ids) and could be safely mixed into the fsid we currently
report.

So all I REALLY need from btrfs is a "mounted-on" inode number, matching
what readdir() reports.
I wouldn't argue AGAINST getting cleaner fsid information.  A 128-bit
uuid and a 64bit subvol id would be ideal.
I'd rather see them as new STATX flags than a new export_operations
callback.

NeilBrown
