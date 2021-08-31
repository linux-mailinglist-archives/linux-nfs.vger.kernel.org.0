Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 281803FC20A
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Aug 2021 07:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233905AbhHaFAF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 31 Aug 2021 01:00:05 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:43422 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbhHaFAF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 31 Aug 2021 01:00:05 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0CE8E20106;
        Tue, 31 Aug 2021 04:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1630385950; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3YiktSWIJng9g/Dkiu/bU4dtkQgaEE8phjWhC9bkFps=;
        b=qklGnEwlQmktk69iqwIBFOMwneATF0bjMzzTerV3PPLQwGuzLpj7wMFRD65obHp8DGYRn1
        qa0sMR6IYzZxuQA+QnqADhcjKWG2RtEvRczUKFu+bGoLNAQIeGM79RMsXc2U8E1RI3ceLu
        40UwLr72kRBbo/EwH5eWz/3Km7Oelac=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1630385950;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3YiktSWIJng9g/Dkiu/bU4dtkQgaEE8phjWhC9bkFps=;
        b=D0Fdrm1Rk5MuICpn8t2PDjVFSAgiGsne7uj93QxIkVTuy7EkGgGzTXPCaZ4F/caUGDz3IN
        t6QhH2RrcNT1C/Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6AA0513A4A;
        Tue, 31 Aug 2021 04:59:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id BCEqChy3LWEWAwAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 31 Aug 2021 04:59:08 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Christoph Hellwig" <hch@infradead.org>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        "Chuck Lever" <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org,
        "Josef Bacik" <josef@toxicpanda.com>
Subject: Re: [PATCH v2] BTRFS/NFSD: provide more unique inode number for btrfs export
In-reply-to: <YSnhHl0HDOgg07U5@infradead.org>
References: <162995209561.7591.4202079352301963089@noble.neil.brown.name>,
 <162995778427.7591.11743795294299207756@noble.neil.brown.name>,
 <YSkQ31UTVDtBavOO@infradead.org>,
 <163010550851.7591.9342822614202739406@noble.neil.brown.name>,
 <YSnhHl0HDOgg07U5@infradead.org>
Date:   Tue, 31 Aug 2021 14:59:05 +1000
Message-id: <163038594541.7591.11109978693705593957@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sat, 28 Aug 2021, Christoph Hellwig wrote:
> On Sat, Aug 28, 2021 at 09:05:08AM +1000, NeilBrown wrote:
> > There doesn't seem to be any other option - and this is still an
> > improvement over the current behaviour.
> >=20
> > Collisions should still be quite a few years away, and there is hope
> > that the btrfs developers will take action before then to provide some
> > certainty.   Not much hope, but some.
>=20
> I think that is a very dangerous assumption.  Given how every inode
> allocation tends to be somewhat predictable I'm also really worried
> that this actually opens up an attach vector.  Last but not least

It doesn't 'open up' anything because it is already possible to cause inode
number collisions for NFS mounts of BTRFS.  So this patch is a net
improvement.

I agree that it isn't perfect, but it is the best I have managed to find
and it does solve real problems.  Can you suggest any way to make it
better?

> I also very much disagree with any of the impact to common code.
> Most importantly the kstat structure, which exist to support the stat
> family of system calls and not as a side channel for NFS file handles
> (nevermind that it is hidden in a nfs patch and didn't even Cc the
> fsdevel list), but also all the impact to the generic nfsd code for
> this very broken concept.  If you want to support such a scheme in
> btrfs as the lesser of evils (which I disagree with), please make
> sure it stays self-contained in the btrfs specific file handle
> encoding and decoding.

Making the change purely in btrfs is simply not possible.  There is no
way for btrfs to provide nfsd with a different inode number.  To move
the bulk of the change into btrfs code we would need - at the very least
- some way for nfsd to provide the filehandle when requesting stat
information.  We would also need to provide a reference filehandle when
requesting a dentry->filehandle conversion.  Cluttering the
export_operations like that just for btrfs doesn't seem like the right
balance.  I agree that cluttering kstat is not ideal, but it was a case
of choosing the minimum change for the maximum effect.

fsdevel *was* cc:ed on the early discussion of this patch

https://lwn.net/ml/linux-fsdevel/162969155423.9892.18322100025025288277@noble=
.neil.brown.name/

I felt we were at a point where I really needed to focus in on the nfsd
side of the discussion, with the nfsd developers.

As you are probably aware I have already been through several approaches
to solve this problem.  I'm not against exploring other avenues, but
only if they are genuinely likely to provide measurably better results.=20
I'd be very happy to hear your suggestions.

NeilBrown
