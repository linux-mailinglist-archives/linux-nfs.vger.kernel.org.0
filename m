Return-Path: <linux-nfs+bounces-21472-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IFmPFZPvAWpHmQEAu9opvQ
	(envelope-from <linux-nfs+bounces-21472-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 11 May 2026 17:02:43 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AB6FD510C41
	for <lists+linux-nfs@lfdr.de>; Mon, 11 May 2026 17:02:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4A49C305808B
	for <lists+linux-nfs@lfdr.de>; Mon, 11 May 2026 14:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1A6C3FE66F;
	Mon, 11 May 2026 14:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B36cI4lx"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4F13A1D05;
	Mon, 11 May 2026 14:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778511314; cv=none; b=vFiLi2+OxyogYHlrvFdy2pOR+Lonp//VQDju6MtINxQ8PoWyvpHg0cBrvXjfIGJAO5ZqvJOdudmBmfD8vfVQiCntFjF910a9dx5wRT+ni3dqQFfOT69lLU6WMZrEzPVwZNcXbwGMbylrZ3fkzm74C9h/3WeiJ8KdYBXpLP7104o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778511314; c=relaxed/simple;
	bh=6bkUFk7agXrVGw01n0hkhQsMUbSxdQH7PYPRMmWMUcw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eRgwr6rTq4JNMaoePMQvgG9tF6k9vE1lUuBkIU1jBxAgyErJF9pzQuPe+UvW2EGZUC+9C+FtVOEYoflkdf2CgTy6WyqAoGH3EFzUnxYNaoJUg177z+f9L3p9GskSFOAXZzjDrAM1kf9OS+bgRmqIV2/+R71HqU9rHI0PqH0wshc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B36cI4lx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B62EC2BCB0;
	Mon, 11 May 2026 14:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778511314;
	bh=6bkUFk7agXrVGw01n0hkhQsMUbSxdQH7PYPRMmWMUcw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B36cI4lxkeKOrJg/YdwbrT9QFnN+7rE9cz0Kky2/Q0526+AEGWwQPoTE9qjPqMDeb
	 GsQxQEwqcwpoPR7xJfJt4ke0fGSHgnXDTs74QCH3PcCySzkUYUhWn1OEyMSvK8dVBi
	 meiLygIryKP1+8dQlZftGCG/2SdCNzQg/RmCG9UG5BuNgquK013JCqHIB105LciE9o
	 oxNc+MysamaiqgVPh0Pwr+VONqKb+fjTLpnpqtMqjPHS3KqFQZQ7UVyJUuDQs7kPpJ
	 Ii51EEwjYFanIdUoSukGU5nIUGrXy39uwG4I4Lb4+s2I3P+YvZao+5xnMVLvz7TF8D
	 tck0/JxcJZ6+Q==
Date: Mon, 11 May 2026 16:55:04 +0200
From: Christian Brauner <brauner@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, 
	linux-xfs@vger.kernel.org, linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-api@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
	hirofumi@mail.parknet.co.jp, linkinjeon@kernel.org, sj1557.seo@samsung.com, 
	yuezhang.mo@sony.com, almaz.alexandrovich@paragon-software.com, slava@dubeyko.com, 
	glaubitz@physik.fu-berlin.de, frank.li@vivo.com, tytso@mit.edu, adilger.kernel@dilger.ca, 
	cem@kernel.org, sfrench@samba.org, pc@manguebit.org, ronniesahlberg@gmail.com, 
	sprasad@microsoft.com, trondmy@kernel.org, anna@kernel.org, jaegeuk@kernel.org, 
	chao@kernel.org, hansg@kernel.org, senozhatsky@chromium.org, 
	"Darrick J. Wong" <djwong@kernel.org>, Roland Mainz <roland.mainz@nrubsig.org>, 
	Steve French <stfrench@microsoft.com>
Subject: Re: [PATCH v14 00/15] Exposing case folding behavior
Message-ID: <20260511-kaffee-therapieren-1335259c65ee@brauner>
References: <20260507-case-sensitivity-v14-0-e62cc8200435@oracle.com>
 <20260511-wertverlust-vorbringen-070f016f3bd4@brauner>
 <705e1769-6a5e-440d-bf50-5e5feec2b88d@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <705e1769-6a5e-440d-bf50-5e5feec2b88d@oracle.com>
X-Rspamd-Queue-Id: AB6FD510C41
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
	TAGGED_FROM(0.00)[bounces-21472-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.sourceforge.net,mail.parknet.co.jp,kernel.org,samsung.com,sony.com,paragon-software.com,dubeyko.com,physik.fu-berlin.de,vivo.com,mit.edu,dilger.ca,samba.org,manguebit.org,gmail.com,microsoft.com,chromium.org,nrubsig.org];
	RCPT_COUNT_TWELVE(0.00)[32];
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
X-Rspamd-Action: no action

On Mon, May 11, 2026 at 10:07:44AM -0400, Chuck Lever wrote:
> On 5/11/26 10:02 AM, Christian Brauner wrote:
> > On Thu, 07 May 2026 04:52:53 -0400, Chuck Lever wrote:
> >> Christian, let's lock this one in. I will post subsequent changes
> >> as delta patches.
> >>
> >> Following on from:
> >>
> >> https://lore.kernel.org/linux-nfs/20251021-zypressen-bazillus-545a44af57fd@brauner/T/#m0ba197d75b7921d994cf284f3cef3a62abb11aaa
> >>
> >> [...]
> > 
> > Applied to the vfs-7.2.exportfs branch of the vfs/vfs.git tree.
> > Patches in the vfs-7.2.exportfs branch should appear in linux-next soon.
> 
> Not vfs-7.2-casefold ?
> 
> Fwiw, I was intending to rebase nfsd-next on the vfs integration branch,
> which should have both vfs-7.2-casefold and vfs-7.2.exportfs merged in,
> along with Jeff's series that implements the infrastructure to support
> directory delegation properly. LMK if that's crazy talk.

I think you should just merge:

vfs-7.2.exportfs
vfs-7.2.casefold

as the order doesn't matter and they don't depend on each other. I have
marked both branches as shared so they won't get touched again. If more
ends on either of these branches it doesn't matter to you. IOW, I think
you should just pick the minimum you need and then you don't need to
hear from again and by the time you send your pull request all the
prerequisites will already be in Linus' tree.

If you merge in vfs.all you're subject to problems from rebases. So I'd
not recommend that.

