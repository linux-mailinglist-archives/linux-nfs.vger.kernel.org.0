Return-Path: <linux-nfs+bounces-4616-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B9B7926E59
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Jul 2024 06:33:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7B4D1F22609
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Jul 2024 04:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 970F061FFE;
	Thu,  4 Jul 2024 04:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lif9feU4"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B9161FF8
	for <linux-nfs@vger.kernel.org>; Thu,  4 Jul 2024 04:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720067520; cv=none; b=BTRwzZ7QUleeAwH1DzXEsvXhBDvSuYguc3I6XHBcN8FtESMbE6pmomOy6T4MoQCtWtB08HEgvfrFl+FSISgBYIf+R8bwdBQFSoyQuUi4GPcqEAnhQiWb6sAbZYbdEqmfl4G1HvAVG6S9Lw/VNLPH41Jr6jwNgSDn5vgqDx8w3lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720067520; c=relaxed/simple;
	bh=0kY338owzOcQAjBjPE4gD809E8r5x3sxCtl5CIAid84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oxKrXTMsFurXF6S+B0ZP0h4iiTV6J0E0QY2+JC//td21wYFRmT3esOuCUu39adtqsP+hQQaCNWbhE6+F7cX+i13GsePWK1jPGj2lMmtfUlN3ubeZJPjRkE6f9jvjXBLARl5s4/f+SnSUyPhXJEW6OhQSXWJkA6Vhq/8oJDaXsLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lif9feU4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B84D0C4AF0C;
	Thu,  4 Jul 2024 04:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720067520;
	bh=0kY338owzOcQAjBjPE4gD809E8r5x3sxCtl5CIAid84=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lif9feU4Vu1n7JIuOr9XiL9Ko/bwZJ9dOXM/QSgf4eGcsT2hjHIpx1WubN/EADWDN
	 HNjL44thjGDBEJ7RzPc+U2b4YRcMxplhRrmkdtWfN3SXrbeQMrKYLQh13l9f303lYX
	 Cil14daD+fgHBXvbxlPLl0JDiad/EY81lzoSMna9ZOyo4902E2TqHLh8QAHU0r3jpu
	 NF1NQHl01wfRj/gpiBqS1MLbBcUwWGzX5cAV9c8+y8tdwu6PtQVnVwsHVMi5/emItr
	 KBWB789CNaqi+9MSFjvyfGyRoDD2BWvdnqKeZGDvMlDxOAJNKZxNxlvKNK6cKg9lEy
	 QkZu/4YqNgtjw==
Date: Thu, 4 Jul 2024 00:31:58 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: NeilBrown <neilb@suse.de>
Cc: Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	Christoph Hellwig <hch@infradead.org>, linux-nfs@vger.kernel.org
Subject: Re: Security issue in NFS localio
Message-ID: <ZoYlvk7LnhyUCYU1@kernel.org>
References: <172004548435.16071.5145237815071160040@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <172004548435.16071.5145237815071160040@noble.neil.brown.name>

On Thu, Jul 04, 2024 at 08:24:44AM +1000, NeilBrown wrote:
> 
> I've been pondering security questions with localio - particularly
> wondering what questions I need to ask.  I've found three focal points
> which overlap but help me organise my thoughts:
> 1- the LOCALIO RPC protocol
> 2- the 'auth_domain' that nfsd uses to authorise access
> 3- the credential that is used to access the file

I'm missing some details that are critical to giving your hypothetical
attack vector teeth.  But I do think no matter what we need to be
precise with documenting localio's security in localio.rst.

> 1/ It occurs to me that I could find out the UUID reported by a given
> local server (just ask it over the RPC connection), find out the
> filehandle for some file that I don't have write access to (not too
> hard), and create a private NFS server (hacking nfs-ganasha?) which
> reports the same uuid and reports that I have access to a file with
> that filehandle.  If I then mount from that server inside a private
> container on the same host that is running the local server, I would get
> localio access to the target file.

Even if nfs-ganasha were modified to allow the nfs client's
nfs_init_localioclient() to establish access to the 'struct net'
associated with the knfsd (rpc_bind_new_program -> GETUUID ->
nfsd_uuid_is_local): what does that _really_ give the nfs client?

The nfs client still needs to call into nfsd with nfsd_open_local_fh()
which requires rpc_clnt->cl_auth to allow access to the server's
files.

In an earlier email Chuck asked why localio's svcauth_unix_set_client()
would ever fail, and he correctly answered his question with:
"Wouldn't it only be because the local application is trying to open a
file it doesn't have permission to?"

Yes, if a client never actually negotiated with the NFS server that
provides access to protected files, then the client must not be
granted access.  _This_ is why having a "fake" svc_rqst is important.
[Also "fake" isn't a great name considering it is still meant to
enforce required established NFS credentials.]

> I might not be able to write to it because of credential checking, but I
> think that is getting a lot closer to unauthorised access than I would
> like.

Kind of hand-wavy on the finale... but I'm also relieved ;)

That said, I appreciate the desire to avoid the "fake" svc_rqst based
access control.  So I still agree it is worthwhile to carry your
nfsd_file_acquire_local() series through to completion.

> I would much prefer it if there was no credible way to subvert the
> LOCALIO protocol.
>
> My current idea goes like this:
>  - NFS client tells nfs_common it is going to probe for localio
>    and gets back a nonce.  nfs_common records that this probe is happening
>  - NFS client sends the nonce to the server over LOCALIO.
>  - server tells nfs_common "I just got this nonce - does it mean
>    anything?".  If it does, the server gets connected with the client
>    through nfs_common.  The server reports success over LOCALIO.
>    If it doesn't the server reports failure of LOCALIO.
>  - NFS client gets the reply and tells nfs_common that it has a reply
>    so the nonce is invalidated.  If the reply was success and nfs_local
>    confirms there is a connection, then the two stay connected. 
> I think that having a nonce (single-use uuid) is better than using the
> same uuid for the life of the server, and I think that sending it
> proactively by client rather than reactively by the server is also
> safer.

Inverting and tweaking the localio protocol like this is clever, but
it still strikes me as unnecessary (given above).

Having it be less widely accessible is a good idea in general though.

> 2/ The localio access should use exactly the same auth_domain as the
>    network access uses.  This ensure the credentials implied by
>    rootsquash and allsquash are used correctly.  I think the current
>    code has the client guessing what IP address the server will see and
>    finding an auth_domain based on that.  I'm not comfortable with that.

nfsd_local_fakerqst_create() isn't guessing.  rpc_peeraddr() returns the
IP address of the server because the rpc_clnt is the same as
established for traditional network access.

>    In the new LOCALIO protocol I suggest above, the server registers
>    with nfs_common at the moment it receives an RPC request.  At that
>    moment it knows the characteristics of the connection - remote IP?
>    krb5?  tls?  - and can determine an auth_domain and give it to
>    nfs_common and so make it available to the client.
> 
>    Jeff wondered about an export option to explicitly enable LOCALIO.  I
>    had wondered about that too.  But I think that if we firmly tie the
>    localio auth_domain to the connection as above, that shouldn't be needed.

I do have concerns that your approach to use "exactly the same
auth_domain" isn't so much better than what the current localio code
does.  But I'll concede it sounds better than the hackish "fake"
svc_rqst based security of the current localio code.

Worth doing just to see how it all shakes out in benchmarks, and on a
"better approach" level, but I do currently have "speed kills" concerns.

> 3/ The current code uses the 'struct cred' of the application to look up
>    the file in the server code.  When a request goes over the wire the
>    credential is translated to uid/gid (or krb identity) and this is
>    mapped back to a credential on the server which might be in a
>    different uid name space (might it?  Does that even work for nfsd?)
>
>    I think that if rootsquash or allsquash is in effect the correct
>    server-side credential is used but otherwise the client-side
>    credential is used.  That is likely correct in many cases but I'd
>    like to be convinced that it is correct in all case.  Maybe it is
>    time to get a deeper understanding of uid name spaces.

You just made me feel slightly better about not knowing enough about
user namespaces.
 
> Have I missed anything?  Any other thoughts?

Here is the branch again that I'd like to use as a base for continued
_incremental_ localio development (make code evolution clearer, if you
want to rip and replace code, just remove in a separate commit.. I
can rebase to cleanup when the dust settles):
https://git.kernel.org/pub/scm/linux/kernel/git/snitzer/linux.git/log/?h=nfs-localio-for-next

Thanks for spending time on all of this localio stuff!

It's now 4th of July for me, so I'm with Jeff: I need a drink! ;)

Mike

