Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B513E1DC687
	for <lists+linux-nfs@lfdr.de>; Thu, 21 May 2020 07:13:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbgEUFM7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 21 May 2020 01:12:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:34104 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726790AbgEUFM7 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 21 May 2020 01:12:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id CF7B0B213;
        Thu, 21 May 2020 05:13:00 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Craig Small <csmall@dropbear.xyz>, linux-nfs@vger.kernel.org
Date:   Thu, 21 May 2020 15:12:49 +1000
Subject: Re: How to separate NFS mounts have same device ID
In-Reply-To: <20200521023055.GA1246587@dropbear.xyz>
References: <20200521023055.GA1246587@dropbear.xyz>
Message-ID: <87eerdan1q.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

--=-=-=
Content-Type: text/plain

On Thu, May 21 2020, Craig Small wrote:

> Hi,
>   I'm the author of the psmisc programs that include things like killall and fuser.  I have a problem with finding files open on NFS mounts from the same server.  The issue is at https://gitlab.com/psmisc/psmisc/-/issues/10
>
> The way fuser does its job is to find the mounts you specify and collect the device IDs, then scans all /proc/<PID/fd/* for matching devices. However, NFS mounts from the same server have the same device ID so fuser reports every mount has the same file opened.
>
> Putting it another way, if I said "here is file /proc/<PID>/fd/3, dereference the symlink and tell me which of these two NFS mounts from the same server it comes from?" how would you do it?
> A simple string match (/mnt/a vs /mnt/b) does not work because you can have symlinks across mounts.

I would examine /proc/<PID>/fdinfo/3 and extract the 'mnt_id:' number,
then look for that (as the first field) in /proc/<PID>/mountinfo.

NeilBrown


>
> Any help here would be appreciated. I'm not subscribed to the list so hopefully, this makes it through whatever filters there are and please CC me on replies.
>
>  - Craig

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAl7GDdQACgkQOeye3VZi
gbmRIRAAspnl4XAGQbyhYdRpvczTXVCW2+pI6auDReMK9BfdFZ2cOQDZOV/mo1dT
SSbq9cBctuVghelRy/6aA+PNA09Wm2BeA7v+gyPKNX/ocbAlqlSXjzueq16ZMLPj
Q9l84fWYu4NJtd1jlxD3SYwbxV/C9XZb5UVdtbEb5fKs7eRSBYpz7VT7+0DOMgzu
VU7Ml8qr/6fVTbPki9+oYugGkeSQJXnMOVwjiFuYU/ShgMXR8FiRMve7YSJ4os4J
oxqeF2MI0Pe3vX9JoVfiHYUP+4puqJgXvpKExO9Z2EIulk6rDCk15OS7oz2LciUv
9c1pe8nGh8DMz4gPd72K2BHKzdzv4bYpnpgeHyv/8FafeQWasss+yBPBouHIwkbM
PBJh7Blj0o7GekVwQ/9YJIqpJplLB4qsv6oBPgzwTByqpOA67nzC1Y7iNAk0eUSS
eci6U7nvWN2QzQncBRVkvIZBLJ+xJ3MQZ7rh7RtXMh0VXZl+I48gzxQOoz3cjIaY
V+dgXHeyioGIaPytepfcmxmb6WTxz//YMXzTzbOQj8L4biezv8XMzZ2Y3vwRIq4H
xsVXDAVIUeuwbBMwz9xfPhPyTGPI1HHRQo/AbMKqMIFpcblFzf1FQjsbS6NCj1X7
dqcG6c0oxq1r8tGSERppw28R90isfvkuTdY567Fgp4YsOuCqEXY=
=uTa8
-----END PGP SIGNATURE-----
--=-=-=--
