Return-Path: <linux-nfs+bounces-8628-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CEA7F9F509F
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Dec 2024 17:15:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70E787A96D7
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Dec 2024 16:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B53B11FCD07;
	Tue, 17 Dec 2024 16:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rPd0F531"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9831FCCFF;
	Tue, 17 Dec 2024 16:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734451202; cv=none; b=Q4ph1lM4xEVjyvsPwe35Z7cmRIwrYz0bbaNLsyRwRzHEW7SpzZx48xZ+hfTClQY9hX4xsd8Du86YZwBVN+v5I8R6+YpQc6sQCE327rl9NK5o5n/wpj0AuFPLyle5wDPkCnbGvu2t2KB2FwcjfGBX8RJpwI+YPb9+e0qdZLdu1dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734451202; c=relaxed/simple;
	bh=xCKUQNxXucXZ8ICMApJ15nckq8nAUUkgFrBwlbRo1NE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cgvaUnjrYgnudj3Ag5kNRZcOWKMPL6afOoXWErPuRRC3hfOQh8jbzeUqP9zlN0S+s0Ne+ahNWXH96i6WR5rPDvYFy4GkOu5MsD2iW0WWjWQ6jdiC5n3wJuLLdkGuzsYmxSf5TF4YJQ3FzclJMbcTINu5w4beUqA5vuAD/ZhN0ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rPd0F531; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C8E9C4CED3;
	Tue, 17 Dec 2024 16:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734451202;
	bh=xCKUQNxXucXZ8ICMApJ15nckq8nAUUkgFrBwlbRo1NE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rPd0F5311VnXBXvEwJJ5aVEcV3/2VJc1PSO72EutsktpTy7Tk5MOfhxQJSojSSo8e
	 tym7ZqFDNPXd0Mi/WcGId1FS0/wUbyMB+6thl2MYoSZJB4akqM/SSa0ibmpOFkoSDn
	 4OFla7H7P6xcndq04DdDw3A18FfK/G01DoZenlZk=
Date: Tue, 17 Dec 2024 16:59:58 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Li Lingfeng <lilingfeng3@huawei.com>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org,
	linux-cve-announce@vger.kernel.org,
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>, NeilBrown <neilb@suse.de>,
	yangerkun <yangerkun@huawei.com>,
	"zhangyi (F)" <yi.zhang@huawei.com>, Hou Tao <houtao1@huawei.com>,
	"yukuai (C)" <yukuai3@huawei.com>,
	"chengzhihao1@huawei.com" <chengzhihao1@huawei.com>,
	ZhangXiaoxu <zhangxiaoxu5@huawei.com>
Subject: Re: CVE-2024-50106: nfsd: fix race between laundromat and
 free_stateid
Message-ID: <2024121713-reproduce-rippling-73cc@gregkh>
References: <2024110553-CVE-2024-50106-c095@gregkh>
 <ef9774e3-572b-427f-99e9-c6a456ffe4fc@huawei.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ef9774e3-572b-427f-99e9-c6a456ffe4fc@huawei.com>

On Tue, Dec 17, 2024 at 11:30:41PM +0800, Li Lingfeng wrote:
> Hi,
> after analysis, we think that this issue is not introduced by commit
> 2d4a532d385f ("nfsd: ensure that clp->cl_revoked list is protected by
> clp->cl_lock") but by commit 83e733161fde ("nfsd: avoid race after
> unhash_delegation_locked()").
> Therefore, kernel versions earlier than 6.9 do not involve this issue.
> 
> // normal case 1 -- free deleg by delegreturn
> 1) OP_DELEGRETURN
> nfsd4_delegreturn
>  nfsd4_lookup_stateid
>  destroy_delegation
>   destroy_unhashed_deleg
>    nfs4_unlock_deleg_lease
>     vfs_setlease // unlock
>  nfs4_put_stid // put last refcount
>   idr_remove // remove from cl_stateids
>   s->sc_free // free deleg
> 
> 2) OP_FREE_STATEID
> nfsd4_free_stateid
>  find_stateid_locked // can not find the deleg in cl_stateids
> 
> 
> // normal case 2 -- free deleg by laundromat
> nfs4_laundromat
>  state_expired
>  unhash_delegation_locked // set NFS4_REVOKED_DELEG_STID
>  list_add // add the deleg to reaplist
>  list_first_entry // get the deleg from reaplist
>  revoke_delegation
>   destroy_unhashed_deleg
>    nfs4_unlock_deleg_lease
>    nfs4_put_stid
> 
> 
> // abnormal case
> nfs4_laundromat
>  state_expired
>  unhash_delegation_locked
>   // set NFS4_REVOKED_DELEG_STID
>  list_add
>   // add the deleg to reaplist
>                                 1) OP_DELEGRETURN
>                                 nfsd4_delegreturn
>                                  nfsd4_lookup_stateid
> nfsd4_stid_check_stateid_generation
>                                   nfsd4_verify_open_stid
>                                    // check NFS4_REVOKED_DELEG_STID
>                                    // and return nfserr_deleg_revoked
>                                  // skip destroy_delegation
> 
>                                 2) OP_FREE_STATEID
>                                 nfsd4_free_stateid
>                                  // check NFS4_REVOKED_DELEG_STID
>                                  list_del_init
>                                   // remove deleg from reaplist
>                                  nfs4_put_stid
>                                   // free deleg
>  list_first_entry
>   // cant not get the deleg from reaplist
> 
> 
> Before commit 83e733161fde ("nfsd: avoid race after
> unhash_delegation_locked()"), nfs4_laundromat --> unhash_delegation_locked
> would not set NFS4_REVOKED_DELEG_STID for the deleg.
> So the description "it marks the delegation stid revoked" in the CVE fix
> patch does not hold true. And the OP_FREE_STATEID operation will not
> release the deleg.

Thanks for the research.  If the maintainers involved agree, we'll be
glad to add a .vulnerable file to our git repo and regenerate the json
entry to reflect this starting point for the issue.

thanks,

greg k-h

