Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 203FC3AF24B
	for <lists+linux-nfs@lfdr.de>; Mon, 21 Jun 2021 19:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbhFURwK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 21 Jun 2021 13:52:10 -0400
Received: from mta-101a.oxsus-vadesecure.net ([51.81.61.60]:45737 "EHLO
        oxsus1nmtao01p.internal.vadesecure.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230330AbhFURwJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 21 Jun 2021 13:52:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; bh=vLvdQK6F2OPrE6ghsiCYkQKKlvSHyf7FEzLFeZ
 E9pnc=; c=relaxed/relaxed; d=earthlink.net; h=from:reply-to:subject:
 date:to:cc:resent-date:resent-from:resent-to:resent-cc:in-reply-to:
 references:list-id:list-help:list-unsubscribe:list-subscribe:list-post:
 list-owner:list-archive; q=dns/txt; s=dk12062016; t=1624297779;
 x=1624902579; b=M1VdPB4pry+hdRoQYKRB0rW2b69jZ1IlN6xOSXjhgDOJbIWI8a8DA9D
 U6e5xS8b3ICrRCiSiJic5JCCa8d1EnybuQL0vrhlAsFl3SBu/6H56xswrWm2Mal33cQO2t0
 EjkltPNh2TkoLx7nB8bjryvPpiTLFOKwOVCnjcHhrZDeNIF3/SA8TL8Pm+b9+dhYETdLJks
 ytwK0utLvgnwpU08niYL4d1M8brV4SiZuUI3WYbuxjlwjh9MSmUYjgPOGaAaCjzA6OFzI/s
 hXcyCdvVCUrFcpL2pbZUEALxLd5TKN+HAd4JySnyh7THWu5WdZ5v0mlUT6h8ImWwV5VbiQm
 O1w==
Received: from FRANKSTHINKPAD ([76.105.143.216])
 by oxsus1nmtao01p.internal.vadesecure.com with ngmta
 id 17381248-168aaa395ba566ab; Mon, 21 Jun 2021 17:49:39 +0000
From:   "Frank Filz" <ffilzlnx@mindspring.com>
To:     "'Wang Yugui'" <wangyugui@e16-tech.com>
Cc:     "'NeilBrown'" <neilb@suse.de>, <linux-nfs@vger.kernel.org>
References: <162425113589.17441.4163890972298681569@noble.neil.brown.name> <000001d766aa$a16b3470$e4419d50$@mindspring.com> <20210621225541.3CEB.409509F4@e16-tech.com>
In-Reply-To: <20210621225541.3CEB.409509F4@e16-tech.com>
Subject: RE: any idea about auto export multiple btrfs snapshots?
Date:   Mon, 21 Jun 2021 10:49:38 -0700
Message-ID: <001901d766c5$cf427af0$6dc770d0$@mindspring.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQIzFiZkIi9fTc+trkZAk2y5KmQzqQIQRiB1AtBi4qiqQFfscA==
Content-Language: en-us
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

> > > I think the problem is that the submount doesn't appear in
/proc/mounts.
> > > "nfsd_fh()" in nfs-utils needs to be able to map from the uuid for a
> > > filesystem to the mount point.  To do this it walks through
> > > /proc/mounts checking the uuid of each filesystem.  If a filesystem
isn't listed
> there, it obviously fails.
> > >
> > > I guess you could add code to nfs-utils to do whatever "btrfs subvol
> > > list" does to make up for the fact that btrfs doesn't register in
/proc/mounts.
> > >
> > > NeilBrown
> >
> > I've been watching this with interest for the nfs-ganesha project. We
recently
> were made aware that we weren't working with btrfs subvols, and I added
code
> so that in addition to using getmntent (essentially /proc/mounts) to
populate
> filesystems, we also scan for btrfs subvols and with that we are able to
export
> subvols. My question is does a snapshot look any different than a subvol?
If they
> show up in the subvol list then we shouldn't need to do anything more for
nfs-
> ganesha, but if there's something else needed to discover them, then we
may
> need additional code in nfs-ganesha. I have not yet had a chance to check
out
> exporting a snapshot yet.
> 
> >  My question is does a snapshot look any different than a subvol?
> 
> No difference between btrfs subvol and snapshot in theory.
> 
> but the btrfs subvol number in product env is usually fixed, and the btrfs
> snapshot number is usually dynamic.
> 
> For fixed-number btrfs subvol/snapshot, it is OK to put them in the same
> hierarchy, and then export all in /etc/exports static, as a walk around.
> 
> For dynamic-number btrfs snapshot number, we needs a dynamic way to export
> them in nfs.

OK thanks for the information. I think they will just work in nfs-ganesha as
long as the snapshots or subvols are mounted within an nfs-ganesha export or
are exported explicitly. nfs-ganesha has the equivalent of knfsd's
nohide/crossmnt options and when nfs-ganesha detects crossing a filesystem
boundary will lookup the filesystem via getmntend and listing btrfs subvols
and then expose that filesystem (via the fsid attribute) to the clients
where at least the Linux nfs client will detect a filesystem boundary and
create a new mount entry for it.

Frank

