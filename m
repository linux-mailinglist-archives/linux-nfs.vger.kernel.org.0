Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0937C49BFD1
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Jan 2022 01:02:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235076AbiAZACX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 25 Jan 2022 19:02:23 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:42784 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235042AbiAZACW (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 25 Jan 2022 19:02:22 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B901B1F3A8;
        Wed, 26 Jan 2022 00:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1643155341; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/XM3QhY2fjGwDoRLOed1rinLYL3Ehp3WMR2L3NJp//o=;
        b=QFSLb+M3mkY574E0OCvEemuy1kbmoMtONEWhW6CA1Vm7jlwVXxXMIPs3ZYqn+s5WrFlcIF
        lSqVlqr8615IwjJ3tsNmAwm0R+JM7/M7J9+y9EJTrJe8O8LkmlfHc0ArTcPzzP+Ae3qiwd
        Lw8PMYpiLc1RZm7sgpP8e+PCyLYeqSQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1643155341;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/XM3QhY2fjGwDoRLOed1rinLYL3Ehp3WMR2L3NJp//o=;
        b=RxRUpozeZsQkJmSYA9eFMd38ZlKXwGDwqBxomvycAH7UBUwb2wWePk8N4MThY7VUCDnIA3
        IpxwY4IDdHFhtcCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5146B13EFD;
        Wed, 26 Jan 2022 00:02:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 7SsaA4yP8GGDcwAAMHmgww
        (envelope-from <neilb@suse.de>); Wed, 26 Jan 2022 00:02:20 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     "Patrick Goetz" <pgoetz@math.utexas.edu>,
        "Daire Byrne" <daire@dneg.com>,
        "linux-nfs" <linux-nfs@vger.kernel.org>
Subject: Re: parallel file create rates (+high latency)
In-reply-to: <20220125212055.GB17638@fieldses.org>
References: <CAPt2mGOaRsKOiL_wuSK_D5oYYnn0R-pvVsZc5HYGdEbT2FngtQ@mail.gmail.com>,
 <20220124193759.GA4975@fieldses.org>,
 <adce2b72-ed5c-3056-313c-caea9bad4e15@math.utexas.edu>,
 <20220125212055.GB17638@fieldses.org>
Date:   Wed, 26 Jan 2022 11:02:16 +1100
Message-id: <164315533676.5493.13243313269022942124@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 26 Jan 2022, J. Bruce Fields wrote:
> On Tue, Jan 25, 2022 at 03:15:42PM -0600, Patrick Goetz wrote:
> > So the directory is locked while the inode is created, or something
> > like this, which makes sense.
>=20
> It accomplishes a number of things, details in
> https://www.kernel.org/doc/html/latest/filesystems/directory-locking.html

Just in case anyone is interested, I wrote this a while back:

http://lists.lustre.org/pipermail/lustre-devel-lustre.org/2018-November/00817=
7.html

it includes a patch to allow parallel creates/deletes over NFS (and any
other filesystem which adds support).
I doubt it still applies, but it wouldn't be hard to make it work if
anyone was willing to make a strong case that we would benefit from
this.

NeilBrown


>=20
> > File creation means the directory
> > "file" is being updated. Just to be clear, though, from your ssh
> > suggestion below, this limitation does not exist if an existing file
> > is being updated?
>=20
> You don't need to take the exclusive i_rwsem lock on the directory to
> update an existing file, no.
>=20
> (But I was only suggesting that creating a bunch of files by ssh'ing
> into the server first and doing the create there would be faster,
> because the latency of each file create is less when you're running it
> directly on the server, as opposed to over a wide-area network
> connection.)
>=20
> --b.
>=20
> >=20
> >=20
> > >
> > >So, it's not surprising you'd get a higher rate when creating in
> > >multiple directories.
> > >
> > >Also, that lock's taken on both client and server.  So it makes sense
> > >that you might get a little more parallelism from multiple clients.
> > >
> > >So the usual advice is just to try to get that latency number as low as
> > >possible, by using a low-latency network and storage that can commit
> > >very quickly.  (An NFS server isn't permitted to reply to the RPC
> > >creating the new file until the new file actually hits stable storage.)
> > >
> > >Are you really seeing 200ms in production?
> > >
> > >--b.
> > >
> > >>
> > >>If I start 100 processes on the same client creating unique files in a
> > >>single shared directory (with 200ms latency), the rate of new file
> > >>creates is limited to around 3 files per second. Something like this:
> > >>
> > >># add latency to the client
> > >>sudo tc qdisc replace dev eth0 root netem delay 200ms
> > >>
> > >>sudo mount -o vers=3D4.2,nocto,actimeo=3D3600 server:/data /tmp/data
> > >>for x in {1..10000}; do
> > >>     echo /tmp/data/dir1/touch.$x
> > >>done | xargs -n1 -P 100 -iX -t touch X 2>&1 | pv -l -a > /dev/null
> > >>
> > >>It's a similar (slow) result for NFSv3. If we run it again just to
> > >>update the existing files, it's a lot faster because of the
> > >>nocto,actimeo and open file caching (32 files/s).
> > >>
> > >>Then if I switch it so that each process on the client creates
> > >>hundreds of files in a unique directory per process, the aggregate
> > >>file create rate increases to 32 per second. For NFSv3 it's 162
> > >>aggregate new files per second. So much better parallelism is possible
> > >>when the creates are spread across multiple remote directories on the
> > >>same client.
> > >>
> > >>If I then take the slow 3 creates per second example again and instead
> > >>use 10 client hosts (all with 200ms latency) and set them all creating
> > >>in the same remote server directory, then we get 3 x 10 =3D 30 creates
> > >>per second.
> > >>
> > >>So we can achieve some parallel file create performance in the same
> > >>remote directory but just not from a single client running multiple
> > >>processes. Which makes me think it's more of a client limitation
> > >>rather than a server locking issue?
> > >>
> > >>My interest in this (as always) is because while having hundreds of
> > >>processes creating files in the same directory might not be a common
> > >>workload, it is if you are re-exporting a filesystem and multiple
> > >>clients are creating new files for writing. For example a batch job
> > >>creating files in a common output directory.
> > >>
> > >>Re-exporting is a useful way of caching mostly read heavy workloads
> > >>but then performance suffers for these metadata heavy or writing
> > >>workloads. The parallel performance (nfsd threads) with a single
> > >>client mountpoint just can't compete with directly connected clients
> > >>to the originating server.
> > >>
> > >>Does anyone have any idea what the specific bottlenecks are here for
> > >>parallel file creates from a single client to a single directory?
> > >>
> > >>Cheers,
> > >>
> > >>Daire
>=20
>=20
