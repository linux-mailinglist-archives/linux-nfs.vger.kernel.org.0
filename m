Return-Path: <linux-nfs+bounces-14829-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21D62BAE9F7
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Sep 2025 23:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD9963AA7D9
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Sep 2025 21:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC882136658;
	Tue, 30 Sep 2025 21:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KHuL4H0I"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889D12E40E
	for <linux-nfs@vger.kernel.org>; Tue, 30 Sep 2025 21:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759267830; cv=none; b=XOKDRdeitfrKIFuhXxhTTi7bQ8sPy4yoxX0mgBv4E7GPtd3ujAVR0l6WNxdVCQQMOLdvp4zDcypM6XAG24X8ZmmGRalrqR5hw+2YELfVRYejcSpIGrBVSnxKut+5ABRAtK/ExeK8v0PWSO2vI8UERR52Ee8kdH9TVRPca76gj6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759267830; c=relaxed/simple;
	bh=eqlyTtv43fot+rSL90AmiHY2j65ACctk32MIL7UWWQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mvnRFWMtpRW+6fg3jS2f+kdxL+jCTXPQ+SKck1t13cIDG9HrtQ4SlUn4v0ZqlSBNQr+6OS+wjCZozPYrwK0LGxTVkV8TR+i6RH+fN/V7pr+a69twXV1ytl2UMQMZCxnrZQ0SZ/0NzMX3hzMqXD79Kh76/joLOHAWVBlifzq0GK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KHuL4H0I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0C7EC4CEF0;
	Tue, 30 Sep 2025 21:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759267829;
	bh=eqlyTtv43fot+rSL90AmiHY2j65ACctk32MIL7UWWQk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KHuL4H0Iw8NY61xTG0cw/p8Hvd2b6eR/FccqO3RQ/53kojjAhn5C+e6Gkq7zk0vOK
	 TvOzL8tjbeqEk6fj0CTtUhYDG3uU3zAvkKSSCUnM4oay+85tBpnxPoVtVkDKlgNuJL
	 VTKMeEsRiguSxWYwio9Mqqp44UtP/WiowTUb2uMiGRc0Ohghm+wvpMiY1b3tgq7VJ/
	 3UW7crJA/cQoIH/CAUrpLVCsYbv1TVVgCuNq7qt2oeNO9+M3+tLMj89qfEpAal3qd4
	 A2qbBb40OlA5BCZMEDKHxczV2qPbe0BApdYWW0XwA7e388h7ommxKLJY5yu8bAR6oc
	 cQnbSM9C8HDww==
Date: Tue, 30 Sep 2025 17:30:27 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Anna Schumaker <anna.schumaker@oracle.com>
Cc: Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Subject: Re: [GIT PULL v2] NFS LOCALIO O_DIRECT changes for Linux 6.18
Message-ID: <aNxL88GmEzJ5hsHl@kernel.org>
References: <20250915154115.19579-1-snitzer@kernel.org>
 <aMiMpYAcHV8bYU4W@kernel.org>
 <aNLfroQ8Ti1Vh5wh@kernel.org>
 <aNQqUprZ3DuJhMe4@kernel.org>
 <aNgSOM9EzMS_Q6bR@kernel.org>
 <aNwEo7wOMrwcmq9b@kernel.org>
 <aNwwOvAZh5VAliWW@kernel.org>
 <2951eea3-772b-4a1a-9169-3d9a3c0661c5@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2951eea3-772b-4a1a-9169-3d9a3c0661c5@oracle.com>

On Tue, Sep 30, 2025 at 04:53:49PM -0400, Anna Schumaker wrote:
> Hi Mike,
> 
> On 9/30/25 3:32 PM, Mike Snitzer wrote:
> > Hi Anna,
> > 
> > Given that my NFS LOCALIO O_DIRECT changes depend on NFSD changes
> > which will be included in the NFSD pull request for 6.18, I figured it
> > worth proposing a post-NFSD-merge pull request for your consideration
> > as the best way forward logistically (to ensure linux-next coverage,
> > you could pull this in _before_ Chuck sends his pull to Linus).
> 
> I've applied your patches with the one NFSD patch acked-by Chuck and pushed
> it out to my linux-next for a few days of wider testing. I agree with Chuck
> that the remaining fixes can go in through an -rc once they're ready.

Perfect, thanks for the update.

Note that there will be merge conflicts that both linux-next and Linus
will need to resolve.  Due to these nfsd-next commits:

c926f0298d3cd NFSD: Relocate the fh_want_write() and fh_drop_write() helpers
c1f203e46c55a NFSD: Move the fh_getattr() helper
2ee3a75e42081 nfsd: discard nfsd_file_get_local()

$ git checkout -b merge-conflict-test cel/nfsd-next
branch 'merge-conflict-test' set up to track 'cel/nfsd-next'.
Switched to a new branch 'merge-conflict-test'

$ git merge anna-nfs/linux-next
Auto-merging fs/nfsd/filecache.c
Auto-merging fs/nfsd/filecache.h
Auto-merging fs/nfsd/localio.c
Auto-merging fs/nfsd/vfs.h
CONFLICT (content): Merge conflict in fs/nfsd/vfs.h
Auto-merging include/linux/nfslocalio.h
Auto-merging include/linux/sunrpc/svc_xprt.h
Auto-merging include/linux/sunrpc/xdr.h
Auto-merging net/sunrpc/svc.c
Auto-merging net/sunrpc/svc_xprt.c
Automatic merge failed; fix conflicts and then commit the result.

Resolving the fs/nfsd/vfs.h conflict is really easy (just remove the
marked region), the problem is that the test merge I just did caused
this hunk to get dropped on the floor:

diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index 062cfc18d8c6..0bc2608a80b0 100644
--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@ -698,8 +698,12 @@ __be32 fh_getattr(const struct svc_fh *fhp, struct kstat *stat)
 		.mnt		= fhp->fh_export->ex_path.mnt,
 		.dentry		= fhp->fh_dentry,
 	};
+	struct inode *inode = d_inode(p.dentry);
 	u32 request_mask = STATX_BASIC_STATS;
 
+	if (S_ISREG(inode->i_mode))
+		request_mask |= (STATX_DIOALIGN | STATX_DIO_READ_ALIGN);
+
 	if (fhp->fh_maxsize == NFS4_FHSIZE)
 		request_mask |= (STATX_BTIME | STATX_CHANGE_COOKIE);
 
Might be a good idea to resolve the conflict in a branch for
linux-next and Linus to reference?

Thanks,
Mike

