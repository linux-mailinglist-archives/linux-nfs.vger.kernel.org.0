Return-Path: <linux-nfs+bounces-19056-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6JyKBM+Xl2nB1wIAu9opvQ
	(envelope-from <linux-nfs+bounces-19056-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Feb 2026 00:07:59 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F64D163771
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Feb 2026 00:07:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3EFE23019530
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Feb 2026 23:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7429629B79B;
	Thu, 19 Feb 2026 23:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n5s0rhyv"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FEBE32D7DA
	for <linux-nfs@vger.kernel.org>; Thu, 19 Feb 2026 23:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771542462; cv=none; b=qDDzcNUr3nAbj6yFxEWLFEAvX3AG2uHji2pVuMA4+1O+s+klh015ksxzD85nqLcGjHxqjPNBHuir5I0g5k5vEyDQaoutqGcu6ZzhH4jHvSYb0rmJTl36UaFGf7IKZuTNM2nl9Lbn/+fIa7grK++iDgJC71DrYnkJa2pJXbeO+bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771542462; c=relaxed/simple;
	bh=Laff54AfrdYYBa6XghOeKWbISto5TPGzQ200q8/EngQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JVdPmjJS7a4uFVgaU4xf4bdX7CrvwQjMye0eyn8Jal52RRFHnxp752eLoBB/mwiN6WSj0S5GnjG0b6MDH/lO4N4awXxgp8G0DbHwSt3jmvfLJyART6LXUS3o43SRa0gzsRCozNnzZNP+U11F5QwRwzvv2HMpRS5mZbb2t4kSjz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n5s0rhyv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E537C4CEF7;
	Thu, 19 Feb 2026 23:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771542462;
	bh=Laff54AfrdYYBa6XghOeKWbISto5TPGzQ200q8/EngQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n5s0rhyvCb3WioDp6ru9rCb/D1wfeGanWe/YA64ZPO1I7xIEaMU7Pt7y4r+1xaUPN
	 qL0CPkiKbREMtSOVByKrTo/Uyb61LB4UAfSJWjA9CsbUpLuB5+kfjDMRXMMejGJUr8
	 i7+YNOiPoRpkIvoMMDXHqKnxqEVo2buHjmwZb5M5jmc6EkExEbTkUCqDa910lH0/Em
	 BJrOzYuhKWW4T2GlBX2YqHVcbCAFz0/zoLIgvB/oZfkX4Orn/OLJTGCoBay/wjTL27
	 5wOaxFZkTj+jGrQhYSoufI/WnOBTroFX6l54BrvcpKJ3547Gd/bqgeTObpDASksiqy
	 NxEZX/7SnPjCw==
Date: Thu, 19 Feb 2026 18:07:40 -0500
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Jeff Layton <jlayton@kernel.org>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna.schumaker@oracle.com>,
	linux-nfs@vger.kernel.org
Subject: Re: [RFC PATCH 00/11] NFS/NFSD: nfs4_acl passthru for NFSv4 reexport
Message-ID: <aZeXvNclhMMzsweq@kernel.org>
References: <20260219221352.40554-1-snitzer@kernel.org>
 <098b9502-8868-47c9-b164-be80bb11ae74@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <098b9502-8868-47c9-b164-be80bb11ae74@oracle.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19056-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[snitzer@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5F64D163771
X-Rspamd-Action: no action

On Thu, Feb 19, 2026 at 05:21:06PM -0500, Chuck Lever wrote:
> On 2/19/26 5:13 PM, Mike Snitzer wrote:
> > Hi,
> > 
> > This patchset aims to enable NFS v4.1 ACLs to be fully supported from
> > an NFS v4.1 client to an NFSD v4.1 export that reexports NFS v4.2
> > filesystem which has full support for NFS v4.1 ACLs (DACL and SACL).
> > 
> > The first 6 patches focus on nfs4_acl passthru enablement (primarily
> > for NFSD), patch 7 adds 4.1 nfs4_acl passthru support (DACL and SACL),
> > patch 8 optimizes particular nfs4_acl passthru implementation in NFSD
> > to skip memcpy if nfs4_acl passthru isn't needed, patches 9-11 offer
> > the corresponding required NFSv4 client changes.
> > 
> > This work is based on the NFS and NFSD code that has been merged
> > during the 7.0 merge window.
> > 
> > This patchset is marked as RFC because I expect there will be
> > suggestions for possible NFSD implementation improvements.
> 
> A couple of random observations:
> 
> 1. I haven't been a fan of these double-subsystem patch sets. Is there
> any way we can get this split into one set for NFSD and one for the NFS
> client, with as little code sharing between the two as possible? Maybe a
> pipe dream, I know.

Open to suggestions, but the reexport nature of this patchset makes it
tough for each half to be entirely standalone.

As is, patches 1 - 8 could all land via NFSD. But the code would be
dormant because no filesystems would set EXPORT_OP_NFSV4_ACL_PASSTHRU.

NFS _could_ just apply patch 3 (so it'd duplicate NFSD's commit for
patch 3) and then apply NFS patches 9 - 11.

> 2. Do you have a plan for similar passthru support for the NFSv4.2 POSIX
> draft ACL extension?

Wasn't on my radar, but I know you and Rick have been busy getting
NFSv4 POSIX draft ACL support to land in NFSD. I still have work ahead
to understand all that you guys landed... but being POSIX I just paid
attention to the mutual exclusion of your newer work versus nfs4_acl.

Excuse my naivety but doesn't NFSD now provide support for NFSv4.2
POSIX draft ACL extension? So what's the usecase you're thinking
passthru would be meaningful for?

If you might provide some guidance on expected work items that'd help
plant seeds. I can try to bone up on NFSv4.2 POSIX draft ACL extension
and we could discuss further at Bake-a-thon?

Relative to NFS v4.1 ACL passthru, Hammerspace needing to support 4.1
access for the benefit of kerberos usage made adding 4.1 ACL passthru
to 4.2 a compelling feature/requirement to implement.

Mike

