Return-Path: <linux-nfs+bounces-15522-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76D03BFD8E5
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Oct 2025 19:24:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FA373ADCDD
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Oct 2025 17:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 612AA21773D;
	Wed, 22 Oct 2025 17:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EkoJ9DWV"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA5920D51C
	for <linux-nfs@vger.kernel.org>; Wed, 22 Oct 2025 17:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761152448; cv=none; b=cF+WVk3zoRflU4aIeIwGp/rfIlQIB3lDJBrIa5+ypqAmBLnAgECBANh3d6qThUXULiAoHl4AvhpOfzclaSWEr4XwYL05yrsyzEUb6vBNVXPP2YCerS9EYHN54/fBsiseYodRTXssdI5qPZr19TI3i+aqy7duAmpvkO7iAKHYgG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761152448; c=relaxed/simple;
	bh=3jPF5r1m7X5DylYEXRPUMwiGVA9p4W6wehFtA28J8Mo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W7o561DQZAUmNcid8Hldg5pEUgbChQ3Yr9iyqnNf3F2EyZUt2eHU2ZO5d/2r/T3qPzMs/xQ/OupbiYtRhDiDfO7eD94PDAszwGCKprzm7kovo4I5VVSKclSemg1d0t3f0frIhF6mmKo1Gf25DMZxQZaMn6pB+gLIOUfe9ItPLcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EkoJ9DWV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97360C4CEF7;
	Wed, 22 Oct 2025 17:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761152447;
	bh=3jPF5r1m7X5DylYEXRPUMwiGVA9p4W6wehFtA28J8Mo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EkoJ9DWV3sL9HRiRvQQVNU8eJx6bG2+KrLNoK655caPGkmIleUR+lJPsaVJaYlzvA
	 NxKzRdxXd6C/W+77IDpkFQOmXSEfQOpoLMHBUdMCjtujWkWm5DVoGGM6iJr+DM63Ks
	 RCnviTqiYsBSINEqdqH1bF6l+CBsgAQ/dzIlYaQfHtvcYtY76+OIM/tLAj4+vrdwIf
	 oaJJ25+MxLaftRgkDrKCjbXawBiaeUeN9rEpMIm9pebPtMhOzjYeTiUtmhCAV8GTrg
	 pQ8iR/evWqrL8ttjpZ3UjBxLAwkVPwaKedEwwORi3qK1SGqoSiZwGrEzvLCfBYCm+c
	 7jYtWfn8FCSRA==
Date: Wed, 22 Oct 2025 13:00:46 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <cel@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
	jonathan.flynn@hammerspace.com
Subject: Re: [PATCH v5 0/4] NFSD: Implement NFSD_IO_DIRECT for NFS WRITE
Message-ID: <aPkNvmXsgdNJtK_7@kernel.org>
References: <20251020162546.5066-1-cel@kernel.org>
 <aPZkYqyFZ4SGnMbF@kernel.org>
 <c5e0409a-5fce-4adc-bdd4-584a7c384c95@kernel.org>
 <1ddb2a85a04320f6b8db6b2436ff63852dcfbbc9.camel@kernel.org>
 <4a2ab6a7-9af5-4d86-9b54-34a4f4a9682d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a2ab6a7-9af5-4d86-9b54-34a4f4a9682d@kernel.org>

On Tue, Oct 21, 2025 at 09:35:32AM -0400, Chuck Lever wrote:
> On 10/21/25 7:12 AM, Jeff Layton wrote:
> > On Mon, 2025-10-20 at 12:44 -0400, Chuck Lever wrote:
> >> On 10/20/25 12:33 PM, Mike Snitzer wrote:
> >>> On Mon, Oct 20, 2025 at 12:25:42PM -0400, Chuck Lever wrote:
> >>> Just a bit concerned about removing IOCB_SYNC in that
> >>> we're altering stable_how to be NFS_FILE_SYNC.
> >> Commit 3f3503adb332 ("NFSD: Use vfs_iocb_iter_write()") introduces
> >> the first use of IOCB_ flags in NFSD's write path, and it uses
> >> IOCB_DSYNC. The patch has Reviewed-by's from Christoph, Neil, and
> >> Jeff.
> >>
> >> Should we be concerned that IOCB_DSYNC does not persist time stamp
> >> changes that might be lost during an unplanned server boot?
> >>
> >> As a reminder to the thread, Section 3.3.7 of RFC 1813 says:
> >>
> >>          If stable is FILE_SYNC, the server must commit the data
> >>          written plus all file system metadata to stable storage
> >>          before returning results.
> >>
> >> The text is a bit blurry about whether "file system metadata" means
> >> all of the outstanding metadata changes for every file, or just the
> >> metadata changes for the target file handle.
> >>
> >> NFSD has historically treated DATA_SYNC and FILE_SYNC identically,
> >> as the Linux NFS client does not use DATA_SYNC (IIRC).
> >>
> > 
> > Surely it just meant for the one file.
> 
> Well yes that is the traditional understanding. I'm merely pointing out
> that the actual text is not quite as specific as what we've come to
> understand.
> 
> 
> > FILE_SYNC is only applicable to
> > WRITE/COMMIT operations and those only deal with a single file at a
> > time.
> 
> True but you may recall that NFSD's COMMIT used to ignore the range
> arguments and flush the whole file. Some file systems used to flush
> all dirty data in this case, IIRC.
> 
> There's always been a bit of a mismatch between the spec and what NFSD
> has implemented.
> 
> 
> > If the client gets back FILE_SYNC on a write, it should _not_
> > assume that all outstanding dirty data to all files has been sync'ed.
> 
> Agreed.
> 
> But back to Mike's point.
> 
> - The spec says NFS_DATA_SYNC means persist file data.
> 
> - The spec says NFS_FILE_SYNC means persist file data and file
>   attributes.
> 
> - After consulting with the section describing COMMIT, I think that
>   COMMIT is supposed to persist both file data and attributes.
> 
> And my reading of the code in fs/nfsd/vfs.c is that NFSD does the
> equivalent of NFS_DATA_SYNC in all of these cases, and has done for
> as long as I cared to chase the commit log.
> 
> Moveover, commit 3f3503adb332 did not introduce this behavior.
> 
> Previous to that commit, nfsd_vfs_write() passed RWF_SYNC to
> vfs_iter_write(). This API uses kiocb_set_rw_flags() to convert the RWF
> flag into an IOCB flag. kiocb_set_rw_flags does this:
> 
>         kiocb_flags |= (__force int) (flags & RWF_SUPPORTED);
>         if (flags & RWF_SYNC)
>                 kiocb_flags |= IOCB_DSYNC;
> 
> And that's where I copied IOCB_DSYNC from. The use of RWF_SYNC was
> introduced in 2016 by commit 24368aad47dc ("nfsd: use RWF_SYNC").
> 
> So we've tacitly agreed to let NFSD fall short of the specs in this
> regard for some time. However I don't believe this is documented
> anywhere.
> 
> Based on this reasoning, IOCB_DSYNC is historically correct for the
> DIRECT WRITE path and its fallbacks. I'm guessing that an O_DIRECT WRITE
> is going to persist the written data but won't persist file attribute
> changes either.
> 
> I'm open to making NFSD adhere more strictly to the spec language, but
> I bet there will be a performance impact. Maybe that impact will be
> unnoticeable on modern storage devices.

I was able to get NFSD Direct's use of IOCB_DSYNC|IOCB_SYNC tested
with Jonathan Flynn last week, there was no performance difference on
his modern test cluster (8 "enterprise" NVMe devices in the server).

Was very comforting to learn IOCB_SYNC didn't cause any performance
loss.

Mike

