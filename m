Return-Path: <linux-nfs+bounces-20984-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CC6qOLlo52ke8AEAu9opvQ
	(envelope-from <linux-nfs+bounces-20984-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Apr 2026 14:08:25 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 74C1143A718
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Apr 2026 14:08:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3AA183007CAB
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Apr 2026 12:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94915351C14;
	Tue, 21 Apr 2026 12:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hSd3Iq3p"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E2E347514;
	Tue, 21 Apr 2026 12:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776773079; cv=none; b=QdzD/fSgdxf29zIgsQM5V9YSAdbsiL3rmcCXNVvxm2d5f0ACAD4TNO8fnXZtQu/qBwuxM5w+SS8hY9PhOblgzo4CwieeFRH1wyGfPi8oZ60syk73Bq3+ci7wYSJqQ5Iq1c1yjrAef6pVpQRv45Ut7ZUJUsvRezinK4SNFPvkyR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776773079; c=relaxed/simple;
	bh=w/LosulEMEyDaZmorxeK+3YoV8+pW6oIbTUUsPOfKvU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CD4qobsl4HqnAzmq4BKVbGyqk7upKwTe146+QMyRTIblKtE4ROvpVG7f3EkfGpPQy4Tpd/Ly+0jDL33DJlQUHJH4NyKvXUp96DxSjeDcInVLnuVM7SxhsaUsCbM6O88KkgEd+LSrsEsAi/HNzoVHr6W0PVnBJ6nU/7c0nvw5hWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hSd3Iq3p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B33DC2BCB0;
	Tue, 21 Apr 2026 12:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776773079;
	bh=w/LosulEMEyDaZmorxeK+3YoV8+pW6oIbTUUsPOfKvU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hSd3Iq3pqVy2V9Y25BAbKL7pHoFcIYzltNr1A0GzmaphPED8IYMASJ3ngECH3v/vk
	 yfFa4DU/CU5kMCKoVIgurs8/dOv0Plz6vRgDB+Oz6I2K02NTSnemTRssaW/Y4Fyzc5
	 mEoMdZo3qcnlM6xBlie+i8anDoH/XpoWltZegJH5Iw64blIA9p2PhIcUAWIQJ4UUKD
	 wg22K9yxSpz3fL4dTJI+aWRg813T54dFugx3jiRohwrf34Mo9TqywP2uHUz1Q8Y/qt
	 4Vu+hAWMxL0UL6JPcVMQ9OgI/MkBdIs0kDx+pX0gE5AdUSGA6OT/UfpyiHkr7VoSoI
	 ybDrFVrKcoFqA==
Date: Tue, 21 Apr 2026 14:04:33 +0200
From: Christian Brauner <brauner@kernel.org>
To: Chuck Lever <cel@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, NeilBrown <neil@brown.name>, 
	Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
	Amir Goldstein <amir73il@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: cleanup block-style layouts exports v2
Message-ID: <20260421-schusselig-proklamieren-23839cd64bca@brauner>
References: <20260401144059.160746-1-hch@lst.de>
 <8bef4d4e-1c0d-451d-8854-ed0cba27ee1f@app.fastmail.com>
 <20260409-schwalben-neutralisieren-fb5a184e5049@brauner>
 <20260410111007.GA10292@lst.de>
 <20260414-ausbrechen-gemixt-ff09f46bdad2@brauner>
 <20260415052925.GC26559@lst.de>
 <217438cb-63ff-41d2-8f3c-fbdb1945a670@app.fastmail.com>
 <683650ce-0585-4607-8d93-9704b179fbd3@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <683650ce-0585-4607-8d93-9704b179fbd3@app.fastmail.com>
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20984-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lst.de,brown.name,redhat.com,oracle.com,talpey.com,vger.kernel.org,kernel.org,gmail.com,linux-foundation.org];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 74C1143A718
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 17, 2026 at 07:52:20AM -0700, Chuck Lever wrote:
> 
> On Wed, Apr 15, 2026, at 7:34 AM, Chuck Lever wrote:
> > On Tue, Apr 14, 2026, at 10:29 PM, Christoph Hellwig wrote:
> >> On Tue, Apr 14, 2026 at 12:01:39PM +0200, Christian Brauner wrote:
> >>> On Fri, Apr 10, 2026 at 01:10:07PM +0200, Christoph Hellwig wrote:
> >>> > On Thu, Apr 09, 2026 at 03:26:09PM +0200, Christian Brauner wrote:
> >>> > > > Christian, are you OK if I take this series through the NFSD tree?
> >>> > > 
> >>> > > Hm, I generally prefer infrastructure to go through the VFS tree.
> >>> > > You can get a stable branch ofc.
> 
> > In this case, pNFS is the only consumer that will notice or use the
> > new "infrastructure" and us NFS experts are the only ones who can test
> > and review it properly. And, the likelihood of conflicts with patches
> > in nfsd-testing is high (in fact we've already had at least one). It
> > makes sense to me to take this series through NFSD.
> 
> I see that Jeff has posted a series that modifies the fs_notify API surface
> to support the NFSv4 CB_NOTIFY operation. That likely counts as an
> infrastructure change.
> 
> To meet you halfway, Christian, you could take Christoph's series and
> Jeff's series into a "vfs.nfsd" tree and I can base my nfsd-next branch
> on that for the NFSD PR 7.2. Building the NFSD PR on that should avoid
> merge conflicts with significant changes I have planned.

Sounds perfect. I don't rebase branches unless there's something really
really gnarly to handle and I would ping you in advance if anything like
that were to happen.

