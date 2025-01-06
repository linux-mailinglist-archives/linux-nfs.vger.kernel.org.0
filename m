Return-Path: <linux-nfs+bounces-8935-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90587A02DB7
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Jan 2025 17:27:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1C521885778
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Jan 2025 16:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A7ED166F07;
	Mon,  6 Jan 2025 16:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XdvQWNaC"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5109114AD2B;
	Mon,  6 Jan 2025 16:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736180834; cv=none; b=FTnMkrbZPOpeJ7atbS/X/isxWVaQoh8TxUjvIuWyai1edd2TTWM0DiYp+9e4Fv85H9AmdlL5aRfQ4Lvr1eUZYiv4OWCwMZVZTgm2k4P3iYaM1tRXVvyCyZtv0MPzp50h8lJWssgHPtXwIPQ2nWh5GdJGXeQ2Xx76/amkavU2ncU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736180834; c=relaxed/simple;
	bh=qknyeIuk7vwF3kZJfa4pgkkq5oqBltdINejG9zx0bKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K6riQmlt39cyNde+ghfNDzPHxTlEYdRjpFTyxzxhq92E0rp0Hqe6e8wFyVAiXJIuDxTIiO71mhG2JjXgpnfaBNoDbVEoJRk/ejfq5xl+gk6cHT1Ho1G3nZOeQHRsak91zS4/3eBzKJECaq/kUqwMIufXu6ArvrkvTabI2/Wt7ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XdvQWNaC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 740FDC4CED2;
	Mon,  6 Jan 2025 16:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736180834;
	bh=qknyeIuk7vwF3kZJfa4pgkkq5oqBltdINejG9zx0bKg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XdvQWNaCXT7olxR12IbTVMfenEr6P7+lHpxFNMCYclp89k4s1Znw0tt75beJ0rEQ6
	 dayh2HI1JJDWw0dNywP/+mYLRjV9WmmYy904QReoqmhj30hB0JDAM9JkjE1CmWj95m
	 nOeUjUkhn2J4FAjjXx7Il2fwE7q/dLw9nk6ihBQc=
Date: Mon, 6 Jan 2025 17:27:11 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Li Lingfeng <lilingfeng3@huawei.com>, cve@kernel.org,
	linux-kernel@vger.kernel.org, linux-cve-announce@vger.kernel.org,
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Jeff Layton <jlayton@kernel.org>, NeilBrown <neilb@suse.de>,
	yangerkun <yangerkun@huawei.com>,
	"zhangyi (F)" <yi.zhang@huawei.com>, Hou Tao <houtao1@huawei.com>,
	"yukuai (C)" <yukuai3@huawei.com>,
	"chengzhihao1@huawei.com" <chengzhihao1@huawei.com>,
	ZhangXiaoxu <zhangxiaoxu5@huawei.com>
Subject: Re: CVE-2024-50106: nfsd: fix race between laundromat and
 free_stateid
Message-ID: <2025010602-sureness-clang-0a8d@gregkh>
References: <2024110553-CVE-2024-50106-c095@gregkh>
 <ef9774e3-572b-427f-99e9-c6a456ffe4fc@huawei.com>
 <2024121713-reproduce-rippling-73cc@gregkh>
 <e6bc81ec-4536-44e4-983a-28b8bc0f3979@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e6bc81ec-4536-44e4-983a-28b8bc0f3979@oracle.com>

On Tue, Dec 17, 2024 at 08:55:20PM -0500, Chuck Lever wrote:
> On 12/17/24 10:59 AM, Greg Kroah-Hartman wrote:
> > On Tue, Dec 17, 2024 at 11:30:41PM +0800, Li Lingfeng wrote:
> > > Hi,
> > > after analysis, we think that this issue is not introduced by commit
> > > 2d4a532d385f ("nfsd: ensure that clp->cl_revoked list is protected by
> > > clp->cl_lock") but by commit 83e733161fde ("nfsd: avoid race after
> > > unhash_delegation_locked()").
> > > Therefore, kernel versions earlier than 6.9 do not involve this issue.
> > > 
> > > // normal case 1 -- free deleg by delegreturn
> > > 1) OP_DELEGRETURN
> > > nfsd4_delegreturn
> > >   nfsd4_lookup_stateid
> > >   destroy_delegation
> > >    destroy_unhashed_deleg
> > >     nfs4_unlock_deleg_lease
> > >      vfs_setlease // unlock
> > >   nfs4_put_stid // put last refcount
> > >    idr_remove // remove from cl_stateids
> > >    s->sc_free // free deleg
> > > 
> > > 2) OP_FREE_STATEID
> > > nfsd4_free_stateid
> > >   find_stateid_locked // can not find the deleg in cl_stateids
> > > 
> > > 
> > > // normal case 2 -- free deleg by laundromat
> > > nfs4_laundromat
> > >   state_expired
> > >   unhash_delegation_locked // set NFS4_REVOKED_DELEG_STID
> > >   list_add // add the deleg to reaplist
> > >   list_first_entry // get the deleg from reaplist
> > >   revoke_delegation
> > >    destroy_unhashed_deleg
> > >     nfs4_unlock_deleg_lease
> > >     nfs4_put_stid
> > > 
> > > 
> > > // abnormal case
> > > nfs4_laundromat
> > >   state_expired
> > >   unhash_delegation_locked
> > >    // set NFS4_REVOKED_DELEG_STID
> > >   list_add
> > >    // add the deleg to reaplist
> > >                                  1) OP_DELEGRETURN
> > >                                  nfsd4_delegreturn
> > >                                   nfsd4_lookup_stateid
> > > nfsd4_stid_check_stateid_generation
> > >                                    nfsd4_verify_open_stid
> > >                                     // check NFS4_REVOKED_DELEG_STID
> > >                                     // and return nfserr_deleg_revoked
> > >                                   // skip destroy_delegation
> > > 
> > >                                  2) OP_FREE_STATEID
> > >                                  nfsd4_free_stateid
> > >                                   // check NFS4_REVOKED_DELEG_STID
> > >                                   list_del_init
> > >                                    // remove deleg from reaplist
> > >                                   nfs4_put_stid
> > >                                    // free deleg
> > >   list_first_entry
> > >    // cant not get the deleg from reaplist
> > > 
> > > 
> > > Before commit 83e733161fde ("nfsd: avoid race after
> > > unhash_delegation_locked()"), nfs4_laundromat --> unhash_delegation_locked
> > > would not set NFS4_REVOKED_DELEG_STID for the deleg.
> > > So the description "it marks the delegation stid revoked" in the CVE fix
> > > patch does not hold true. And the OP_FREE_STATEID operation will not
> > > release the deleg.
> > 
> > Thanks for the research.  If the maintainers involved agree, we'll be
> > glad to add a .vulnerable file to our git repo and regenerate the json
> > entry to reflect this starting point for the issue.
> 
> Hi Greg,
> 
> As mentioned earlier, our reviewers felt that this bug would indeed be
> difficult or impossible to reproduce before 83e733161fde, and there
> have been no reports of similar crash symptoms in kernels before v6.9.
> 
> No objection to updating the CVE to reflect that.

The CVE has now been updated to reflect this, thanks!

greg k-h

