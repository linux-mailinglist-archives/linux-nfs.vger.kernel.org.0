Return-Path: <linux-nfs+bounces-7146-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5662699CB98
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Oct 2024 15:31:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BC9E2833F0
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Oct 2024 13:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C424A19CCFA;
	Mon, 14 Oct 2024 13:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="IXgFt6lR"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-42aa.mail.infomaniak.ch (smtp-42aa.mail.infomaniak.ch [84.16.66.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7E81514CB
	for <linux-nfs@vger.kernel.org>; Mon, 14 Oct 2024 13:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728912660; cv=none; b=pn3nmafQU8KJOnhmcMgFOp5uDvu6xU+ptKMzGkWU4p8YZ4ZmEruBghjx3YlJaDkDKv9XRcx2W4b26bO+2wKfCyqIFig8zEMs6nWF8W3vtMiFKX6y4Yp3NMRPGKqqpwCoiI/OTKcigNCZKUqyvIb7wj7F5cFFF9o8TyVYcpKi6zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728912660; c=relaxed/simple;
	bh=2UVqbexnqNci3grd/5BSq40pYQ2u6L0Swq8qIQHkBKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HiyDL/Rbdr4lOd6Gf+1Gb0AZ/1yDJvDxfS+81KuV59GL4wkcjkvWAX10lKiD7xAczeGMZG1o/RuCmEWKyHUsR3dEVHUagK4/Lw6SrjvQltuqFW46yVx+YpulUCWJ8EYVM4/6fImEI8hBiOyy6CBifaxJVxSKlEaIeEbvNuKoQ7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=IXgFt6lR; arc=none smtp.client-ip=84.16.66.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246c])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4XRymB46ZCzY1y;
	Mon, 14 Oct 2024 15:30:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1728912650;
	bh=Po6hgLNsaKhPpGljJr4fPdd1Y7bt7xIfi6p+nTtQGvw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IXgFt6lRv5nmZd4eqoFCNKUKNkWSpMmiDNljyTkl0XRtSYm3240gTMrFL8EKWrkJb
	 t8uAlIcC/5Nk9NxuH7OJB9dwmiPobZxTL4E/sfEZQeEjG9NiCQclAW/2J/sONOu7lE
	 qA9IT52drx1bUvQt37VPI/OPjq+Z2G0FRxIGGt/0=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4XRym96Pn1zTsM;
	Mon, 14 Oct 2024 15:30:49 +0200 (CEST)
Date: Mon, 14 Oct 2024 15:30:45 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Paul Moore <paul@paul-moore.com>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org, audit@vger.kernel.org, 
	Eric Paris <eparis@redhat.com>
Subject: Re: [RFC PATCH v1 2/7] audit: Fix inode numbers
Message-ID: <20241014.Ahhahz2ux0ga@digikod.net>
References: <20241010152649.849254-1-mic@digikod.net>
 <20241010152649.849254-2-mic@digikod.net>
 <CAHC9VhR8AFZN4tU1oAkaHb+CQDCe2_4T4X0oq7xekxCYkFYv6A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhR8AFZN4tU1oAkaHb+CQDCe2_4T4X0oq7xekxCYkFYv6A@mail.gmail.com>
X-Infomaniak-Routing: alpha

On Fri, Oct 11, 2024 at 05:34:21PM -0400, Paul Moore wrote:
> On Thu, Oct 10, 2024 at 11:26 AM Mickaël Salaün <mic@digikod.net> wrote:
> >
> > Use the new inode_get_ino() helper to log the user space's view of
> > inode's numbers instead of the private kernel values.
> >
> > Cc: Paul Moore <paul@paul-moore.com>
> > Cc: Eric Paris <eparis@redhat.com>
> > Signed-off-by: Mickaël Salaün <mic@digikod.net>
> > ---
> >  security/lsm_audit.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> While answering some off-list questions regarding audit, I realized
> we've got similar issues with audit_name->ino and audit_watch->ino.
> It would be nice if you could also fix that in this patchset.

I can do that with the next version, but I'm wondering how it would fit
with the UAPI's struct audit_rule_data which has only 32-bit
fields/values.  Does 64-bit inode filtering currently work?

