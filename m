Return-Path: <linux-nfs+bounces-21198-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CGFjOMt772lKBwEAu9opvQ
	(envelope-from <linux-nfs+bounces-21198-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 17:07:55 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 45FAF474E6D
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 17:07:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1DC42300D6B8
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 15:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A95431F9BE;
	Mon, 27 Apr 2026 15:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EM08tPjL"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67BAC31F9B9;
	Mon, 27 Apr 2026 15:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777302237; cv=none; b=R5sdzu+k3eyD4a7UmANmV6ySs1q9yADLA1lkWew2z2GQmDpw5+TgbHlioPLvRlKDYM5yL7mNK+qWD2/pnQCaYXdIfN3obC/6yK1zyNtBNox2U/2dFcjt4g42GLqTWA9/Jkgn1ZC7PomlVcknoKovIfAgf6QNzq2fnSgLLfzIiy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777302237; c=relaxed/simple;
	bh=SKrT35lR/W3/frJ7TULszcx5EQ7A8DuKhwalrY4XnNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IJmeB3jq7gFj+nHTgV12sQu6udRsrd7YSyZbDDD70l4oL/0FHIpRsBnyBiT9C2VxU9dzH8g0po8MUEUINlIsuwPIohMQDa/hBvNR32IidEhWSSLxbn4HaArxqGFJk75LbtkWme5pNxbQKw6fdoR5uu7uUqXUSOAkmXq4ksdhvv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EM08tPjL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78DA4C19425;
	Mon, 27 Apr 2026 15:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777302237;
	bh=SKrT35lR/W3/frJ7TULszcx5EQ7A8DuKhwalrY4XnNs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EM08tPjLQuXWYB7FCM5uHhrDeffg7oJ2JZ4fh+Mg1pwOhzAIVgVtyUPz5NzQzITVE
	 yHjY79N5vzDXxcnX3IA7mKo1IIPxkqNrhPb/PrXsLJGcROcMh5ulh9DX6ziMbra5dF
	 nsWEWsnm+122Ey3baGAa4Ky3gYh9TOfmKIAno6mZWnSw+5ZL8zh6ot4oUS2By9RV54
	 fxm5gS62PGa0sqlW1V9Ay+crIniHH+JB5V0GMo1jx0SnOMCFhL/HwRwM4MJCjAszpU
	 C7rc2vqdG0tLGfAevuyRfbKflYcm0+aVOGCSDv/YNORz7rG2g136eXKkQUUi83O+EP
	 Kt9i+J3v3qEew==
Date: Mon, 27 Apr 2026 17:03:52 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <cel@kernel.org>, Christoph Hellwig <hch@lst.de>, 
	NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, 
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>, 
	Amir Goldstein <amir73il@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: cleanup block-style layouts exports v2
Message-ID: <20260427-landhaus-leiblich-cd21a25f741f@brauner>
References: <20260401144059.160746-1-hch@lst.de>
 <8bef4d4e-1c0d-451d-8854-ed0cba27ee1f@app.fastmail.com>
 <20260409-schwalben-neutralisieren-fb5a184e5049@brauner>
 <20260410111007.GA10292@lst.de>
 <20260414-ausbrechen-gemixt-ff09f46bdad2@brauner>
 <20260415052925.GC26559@lst.de>
 <217438cb-63ff-41d2-8f3c-fbdb1945a670@app.fastmail.com>
 <683650ce-0585-4607-8d93-9704b179fbd3@app.fastmail.com>
 <20260421-schusselig-proklamieren-23839cd64bca@brauner>
 <fb0803567b6176715d00e7c34a3095647f66f8d0.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fb0803567b6176715d00e7c34a3095647f66f8d0.camel@kernel.org>
X-Rspamd-Queue-Id: 45FAF474E6D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21198-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,lst.de,brown.name,redhat.com,oracle.com,talpey.com,vger.kernel.org,gmail.com,linux-foundation.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Thu, Apr 23, 2026 at 02:57:05PM -0400, Jeff Layton wrote:
> On Tue, 2026-04-21 at 14:04 +0200, Christian Brauner wrote:
> > On Fri, Apr 17, 2026 at 07:52:20AM -0700, Chuck Lever wrote:
> > > 
> > > On Wed, Apr 15, 2026, at 7:34 AM, Chuck Lever wrote:
> > > > On Tue, Apr 14, 2026, at 10:29 PM, Christoph Hellwig wrote:
> > > > > On Tue, Apr 14, 2026 at 12:01:39PM +0200, Christian Brauner wrote:
> > > > > > On Fri, Apr 10, 2026 at 01:10:07PM +0200, Christoph Hellwig wrote:
> > > > > > > On Thu, Apr 09, 2026 at 03:26:09PM +0200, Christian Brauner wrote:
> > > > > > > > > Christian, are you OK if I take this series through the NFSD tree?
> > > > > > > > 
> > > > > > > > Hm, I generally prefer infrastructure to go through the VFS tree.
> > > > > > > > You can get a stable branch ofc.
> > > 
> > > > In this case, pNFS is the only consumer that will notice or use the
> > > > new "infrastructure" and us NFS experts are the only ones who can test
> > > > and review it properly. And, the likelihood of conflicts with patches
> > > > in nfsd-testing is high (in fact we've already had at least one). It
> > > > makes sense to me to take this series through NFSD.
> > > 
> > > I see that Jeff has posted a series that modifies the fs_notify API surface
> > > to support the NFSv4 CB_NOTIFY operation. That likely counts as an
> > > infrastructure change.
> > > 
> > > To meet you halfway, Christian, you could take Christoph's series and
> > > Jeff's series into a "vfs.nfsd" tree and I can base my nfsd-next branch
> > > on that for the NFSD PR 7.2. Building the NFSD PR on that should avoid
> > > merge conflicts with significant changes I have planned.
> > 
> > Sounds perfect. I don't rebase branches unless there's something really
> > really gnarly to handle and I would ping you in advance if anything like
> > that were to happen.
> 
> Note that there is a small difference (error-handling fix) between the
> most-recently posted CB_NOTIFY patchset and what's currently in my
> tree. You can either pick or pull the series from my tree, or I can re-
> post. Let me know which you'd prefer:

Just repost, if you would be so kind. (I wonder whether we should start
having a quiet period for new work during the mw like net has.)

