Return-Path: <linux-nfs+bounces-6519-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EC3697A6A5
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Sep 2024 19:21:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDB002818AA
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Sep 2024 17:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7550161321;
	Mon, 16 Sep 2024 17:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="CynsVpZv"
X-Original-To: linux-nfs@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D002B15B108
	for <linux-nfs@vger.kernel.org>; Mon, 16 Sep 2024 17:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726507218; cv=none; b=mqEvc5ks9zXqtxuPIoFfptTKd9ZSmtLbWcWB3o+pudQ6wy/2zupOglRNVMqgvfFCa0UdaA4DS1gVgkkDorUDtItPGagNL/3W4uGNFMmLes/vKUG4nGkdZV/AWua+d3nYhUkTQqmUm45/84xtjh8v7OV1wwndFaDM5fxD5QJAGSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726507218; c=relaxed/simple;
	bh=h6q1oIqmFwpco9kpc3iPVsjtsXliT77YdxWO/VsZmUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W5XltcFVuwCBR2JIPSLT18qhVKy4EYWZ7JHIHBr5C8/XEaslf4YcFfHJ07rwyPi/v+eJgzU2w5WZMbTi9Y9vg+aQ4/PmY+6gAWxWcaTw4M6+bMEVLwQrgXiWSi5p/GkBsSdFvrB+SmAdoqLcofRpU8/oqFgaIjXUduhcqWPa1dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=CynsVpZv; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=T46kfmASqM1YrY5bdjPLA6P21eVnuX2OQvK/eiv0f1Q=; b=CynsVpZvYxTsjzxET7BoYTUrba
	aHw9cKQSaKeyhp7y3PKyvfXBIfwkKWo0KxAhECeypgM7SFmeyDVtHXw1HfDjPTgSj2EUSNR2U0M7A
	fzR4zcGtHjN8/HCybZXTDpsNjROhiIXLmZ6Agsfq4rfK7L4ivAzpWmYPaYPrpz06g4fKThdRZx9RF
	SHzSWofcebPYaX8yxcuJ0ZPgLKs1gRAP5ITCdGYg1IzpPvz9Fkc4vZKTVDhDBP+2YHG+ti6Wi6GX9
	KxtYQtXhzJAhfpCzhiYrUlSioAXt3hySEx4Dvn0eJtBtmaL7fiV0Tv5cYXPRkQi6V3lt/0q2ji1Wn
	je9Dzrdw==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <carnil@debian.org>)
	id 1sqFOK-009TMZ-Jp; Mon, 16 Sep 2024 17:20:00 +0000
Received: by eldamar.lan (Postfix, from userid 1000)
	id 67699BE2DE0; Mon, 16 Sep 2024 19:19:58 +0200 (CEST)
Date: Mon, 16 Sep 2024 19:19:58 +0200
From: Salvatore Bonaccorso <carnil@debian.org>
To: Sergio.Gelato@astro.su.se, Steve Dickson <steved@redhat.com>
Cc: Kevin Coffman <kwc@citi.umich.edu>, Neil Brown <neilb@suse.de>,
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: rpc.idmapd runs out of file descriptors
Message-ID: <ZuhovpK7Xhkuu3h9@eldamar.lan>
References: <ZmCB_zqdu2cynJ1M@astro.su.se>
 <ZuU7S2Gli6oAALPJ@eldamar.lan>
 <e43aa92c-d91c-4931-b807-5edec649b2b4@redhat.com>
 <Zugkgr-Y5_2iyQFS@as-2866.astro.su.se>
 <ZuhR1bpMZmDWsNew@eldamar.lan>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZuhR1bpMZmDWsNew@eldamar.lan>
X-Debian-User: carnil

Hi all,

On Mon, Sep 16, 2024 at 05:42:13PM +0200, Salvatore Bonaccorso wrote:
> Hi all,
> 
> On Mon, Sep 16, 2024 at 02:28:50PM +0200, Sergio.Gelato@astro.su.se wrote:
> > On Mon, Sep 16, 2024 at 01:54:35PM +0200, Steve Dickson wrote:
> > > It did because it was not in the appropriate format... The patch
> > > was an attachment, not in-line, no  Signed-off-by: line and
> > > the patch was not create by git format-patch command (which
> > > adds PATCH in the subject line).
> > 
> > I see no mention of formatting requirements at
> > https://www.linux-nfs.org/wiki/index.php/Reporting_bugs
> > (not even by reference to the Linux kernel tree).
> 
> Thank you all for looking into it. Steve, do you need to have it
> re-submitted in a git format-patch format? At least a Signed-off-by
> line by Sergio would be needed in my understanding.

I guess otherwise we can use soemthing like the following though a
Signed-off-by is probably not right here, or is it enough if I say
Reported-by: and Patch-originally-by: although the later is not an
official kernel doc mentioned tag?

Regards,
Salvatore

From 997981dd8d2b5977dd4cd54dab59de4ee3f57725 Mon Sep 17 00:00:00 2001
From: Sergio Gelato <Sergio.Gelato@astro.su.se>
Date: Tue, 4 Jun 2024 16:02:59 +0200
Subject: [PATCH] rpc.idmapd: nfsopen() failures should not be fatal

dirscancb() loops over all clnt* subdirectories of /run/rpc_pipefs/nfs/.
Some of these directories contain /idmap files, others don't. nfsopen()
returns -1 for the latter; we then want to skip the directory, not abort
the entire scan.

Reported-by: Sergio Gelato <sergio.gelato@astro.su.se>
Patch-originally-by: Sergio Gelato <sergio.gelato@astro.su.se>
Link: https://lore.kernel.org/linux-nfs/ZmCB_zqdu2cynJ1M@astro.su.se/
Link: https:/bugs.debian.org/1072573
Signed-off-by: Salvatore Bonaccorso <carnil@debian.org>
---
 utils/idmapd/idmapd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/utils/idmapd/idmapd.c b/utils/idmapd/idmapd.c
index cd9a965f8fbc..5231f56d24a8 100644
--- a/utils/idmapd/idmapd.c
+++ b/utils/idmapd/idmapd.c
@@ -556,7 +556,7 @@ dirscancb(int fd, short UNUSED(which), void *data)
 			if (nfsopen(ic) == -1) {
 				close(ic->ic_dirfd);
 				free(ic);
-				goto out;
+				continue;
 			}
 
 			if (verbose > 2)
-- 
2.45.2


