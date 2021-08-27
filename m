Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F47C3FA1A1
	for <lists+linux-nfs@lfdr.de>; Sat, 28 Aug 2021 00:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232372AbhH0W6D (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 27 Aug 2021 18:58:03 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:41968 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232289AbhH0W6C (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 27 Aug 2021 18:58:02 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 80DEF223BB;
        Fri, 27 Aug 2021 22:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1630105032; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WXXd/efJMpN0edd0ubzBR5l1fPjK5efmoUouY4ORkvw=;
        b=nwCeqaB/4F9wzj5dsCCCOS89A5FlqqWQpg4iJu9y6kF2saLLP43Zy0IjFk8DoRFRbPcNsW
        CGHMctzlfBdOEce7dAb/9B/KZui1kJrEh2P4pBGgN6fTrAJjZVFbFNVG02npHhbrfvZEp+
        cnCYcMBDkShHm0I5eZbM3t/iyN47BvE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1630105032;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WXXd/efJMpN0edd0ubzBR5l1fPjK5efmoUouY4ORkvw=;
        b=lUR/G2fDQ4CpIZhSlO16JWzquvrR9+rYjiYV6rjyXORkWuniw6uXUpGAijmAVVQB407K4G
        qPtcGY85yMaMVLCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E43C813A66;
        Fri, 27 Aug 2021 22:57:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id VxM0KMZtKWH9IwAAMHmgww
        (envelope-from <neilb@suse.de>); Fri, 27 Aug 2021 22:57:10 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Frank Filz" <ffilzlnx@mindspring.com>
Cc:     "'J. Bruce Fields'" <bfields@fieldses.org>,
        "'Chuck Lever'" <chuck.lever@oracle.com>,
        linux-nfs@vger.kernel.org, "'Josef Bacik'" <josef@toxicpanda.com>
Subject: RE: [PATCH v2] BTRFS/NFSD: provide more unique inode number for btrfs export
In-reply-to: <002901d79b53$41ddba40$c5992ec0$@mindspring.com>
References: <162995209561.7591.4202079352301963089@noble.neil.brown.name>,
 <162995778427.7591.11743795294299207756@noble.neil.brown.name>,
 <20210826201916.GB10730@fieldses.org>,
 <163001583884.7591.13328510041463261313@noble.neil.brown.name>,
 <002901d79b53$41ddba40$c5992ec0$@mindspring.com>
Date:   Sat, 28 Aug 2021 08:57:07 +1000
Message-id: <163010502766.7591.10398654528737145909@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sat, 28 Aug 2021, Frank Filz wrote:
>=20
> Changing the fsid for sub-volumes is Ganesha's solution (before adding
>  that, we couldn't even export the sub-volumes at all).=20

What does Ganesha use for the mounted-on-fileid? There doesn't seem to
be an "obvious" answer so I wonder what was chosen.

>=20
> Mangling the fileid is definitely the best solution if there will be lots o=
f sub-volumes. For a few sub-volumes changing fsid does create additional mou=
nt points on the client with some issues, but does guarantee there will be no=
 fileid collision.
>=20
> My gut feel is your solution is the best one and Ganesha may need to switch=
 to that solution.

Thanks for the encouragement.  Changing the fsid does seem easier is
many ways, but I don't really like the consequences or implications.

Thanks,
NeilBrown
