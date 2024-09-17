Return-Path: <linux-nfs+bounces-6528-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B286B97ABDA
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Sep 2024 09:11:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1938128D10D
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Sep 2024 07:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E3705C613;
	Tue, 17 Sep 2024 07:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=astro.su.se header.i=@astro.su.se header.b="bWD9ANzk"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-prod-route12.it.su.se (mail-prod-route12.it.su.se [77.238.37.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1506C18C22
	for <linux-nfs@vger.kernel.org>; Tue, 17 Sep 2024 07:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.238.37.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726557113; cv=none; b=TrOplhwVioeP5kYEiuDujVvjvp1ZC7jaNqD6Hi8a/q5KVkGJTGlbC6kvabAAoafhYMUxKaVJ1ejD9Mm49uyiKx8UBeHIDCvCCw6QWnJhwlWHX0GIRIw5o9wz9YGefQvl7k5mSqWuXSK8KnPZVGCuNWg6b/QtOU8bWrx72KZ2zy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726557113; c=relaxed/simple;
	bh=BPvGAChEvz7EG3fPrsgm4v0OfeFtlotikGeC3vdoyOg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fhU8cms94irfw8vQk9yEoCFhciv4tiBEqHj1aQ0Ifhm8OX38VXNxfzqNJNL4j/uuOlWJ0o5fVhlb9AHvHPexCu+8ha4qHBmwyPiZzJ25Mcm9C1hxhOJTYpyib5yCne1kyZuKruXvV8C4rsfnVOVHavakKuzhP2ZO5PWLhxCTZNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=astro.su.se; spf=pass smtp.mailfrom=astro.su.se; dkim=pass (2048-bit key) header.d=astro.su.se header.i=@astro.su.se header.b=bWD9ANzk; arc=none smtp.client-ip=77.238.37.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=astro.su.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=astro.su.se
Received: from mailfilter-ng-1.sunet.se (mailfilter-ng-1.sunet.se [192.36.171.207])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-prod-route12.it.su.se (Postfix) with ESMTPS id 4X7CWF6Mc5z1YW
	for <linux-nfs@vger.kernel.org>; Tue, 17 Sep 2024 09:06:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=astro.su.se; s=halonv1;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
	 from:date:from;
	bh=JHO8trRYfHQW3x7vRc/xz5S561xr/5t1nmafop8CrFw=;
	b=bWD9ANzkdVqt3BwERE/JIuWR99PPldrMf32m4QPAShi0z3karFBLzKS/ppFSPMC9VB5kjAbpjeT6x
	 hEq8zAB1e/jwY2CVFuHXEgGIuotP8gt2zUfM8S2O1qeKSkca50xKwNRtb0j02okmkW3BPtbnDlz83h
	 CkYi5oErGhf5v0eJSEeNWb3J4shgjD0HRvv6+8xMlz4uck5W98H0rwGKuktjqJc/KD9QfTe2sj2J5Q
	 E8BNYZeelLhnd3abF1nHZgVF5XcHK6xsWvej2bGfw/+RBC5FY7lvPkZrkXY+MsFKlM0tmfSyDAzP72
	 N6QcRfaHHIUdWu64/Hic8PwlNkRUFDw==
X-Halon-ID: 5edbc8c3-74c3-11ef-9866-0050569a42e2
Received: from smtp.su.se (mail-prod-smtp11.it.su.se [130.237.181.107])
	by mailfilter-ng-1.sunet.se (Halon) with ESMTPS
	id 5edbc8c3-74c3-11ef-9866-0050569a42e2;
	Tue, 17 Sep 2024 07:06:33 +0000 (UTC)
Received: from EBOX-PROD-SRV20.win.su.se (ebox-prod-srv20.win.su.se [IPv6:2001:6b0:5:1462:5455:3248:4844:b999])
	by smtp.su.se (Postfix) with ESMTPS id 4X7CWD6nC2z1Vm;
	Tue, 17 Sep 2024 09:06:32 +0200 (CEST)
Received: from as-2866.astro.su.se (130.237.200.212) by
 EBOX-PROD-SRV20.win.su.se (130.237.162.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 17 Sep 2024 09:06:32 +0200
Date: Tue, 17 Sep 2024 09:06:23 +0200
From: <Sergio.Gelato@astro.su.se>
To: Salvatore Bonaccorso <carnil@debian.org>
CC: Steve Dickson <steved@redhat.com>, Neil Brown <neilb@suse.de>,
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: rpc.idmapd runs out of file descriptors
Message-ID: <ZukqbzFrXtnxn4CQ@as-2866.astro.su.se>
References: <ZmCB_zqdu2cynJ1M@astro.su.se>
 <ZuU7S2Gli6oAALPJ@eldamar.lan>
 <e43aa92c-d91c-4931-b807-5edec649b2b4@redhat.com>
 <Zugkgr-Y5_2iyQFS@as-2866.astro.su.se>
 <ZuhR1bpMZmDWsNew@eldamar.lan>
 <ZuhovpK7Xhkuu3h9@eldamar.lan>
 <Zuh2aG50e-cg3h81@eldamar.lan>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Zuh2aG50e-cg3h81@eldamar.lan>
X-ClientProxiedBy: ebox-prod-srv27.win.su.se (130.237.162.247) To
 EBOX-PROD-SRV20.win.su.se (130.237.162.204)

On Mon, Sep 16, 2024 at 08:18:16PM +0200, Salvatore Bonaccorso wrote:
> > > > On Mon, Sep 16, 2024 at 01:54:35PM +0200, Steve Dickson wrote:
> > > > > It did because it was not in the appropriate format... The patch
> > > > > was an attachment, not in-line, no  Signed-off-by: line and
> > > > > the patch was not create by git format-patch command (which
> > > > > adds PATCH in the subject line).
> > > > (not even by reference to the Linux kernel tree).
> > > 
> > > Thank you all for looking into it. Steve, do you need to have it
> > > re-submitted in a git format-patch format? At least a Signed-off-by
> > > line by Sergio would be needed in my understanding.
> > 
> > I guess otherwise we can use soemthing like the following though a
> > Signed-off-by is probably not right here, or is it enough if I say
> > Reported-by: and Patch-originally-by: although the later is not an
> > official kernel doc mentioned tag?

I don't object to (nor do I require) your adding a

Signed-off-by: Sergio Gelato <Sergio.Gelato@astro.su.se>

(I am indeed the author of the patch, and it's too trivial to be
copyrightable anyway).

I guess Neil's comment earlier can be taken as equivalent to an Acked-by:. 

By the way, I have wondered whether to change the other two instances of
"goto out" in dirscancb() as well. For the first one (calloc() failure)
I think this would be counterproductive (one is likely to get the same
error on all subsequent iterations), the second (directory open()) is
more debatable (but failure of the directory open() should be so rare
that it doesn't matter).

> And then one seems to be able to do so many mistakes around one patch.
> Here is an improved version (v2), fixing a typo in the Link reference
> and using a Closes: tag after the Reported-by:
> 
> This now should be better than the previous one.
> 
> Regards,
> Salvatore
> 
> From 46989ce210d27dbb3ad89095030c687db70c78be Mon Sep 17 00:00:00 2001
> From: Sergio Gelato <Sergio.Gelato@astro.su.se>
> Date: Tue, 4 Jun 2024 16:02:59 +0200
> Subject: [PATCH v2] rpc.idmapd: nfsopen() failures should not be fatal
> 
> dirscancb() loops over all clnt* subdirectories of /run/rpc_pipefs/nfs/.
> Some of these directories contain /idmap files, others don't. nfsopen()
> returns -1 for the latter; we then want to skip the directory, not abort
> the entire scan.
> 
> Reported-by: Sergio Gelato <sergio.gelato@astro.su.se>
> Closes: https://lore.kernel.org/linux-nfs/ZmCB_zqdu2cynJ1M@astro.su.se/
> Link: https://bugs.debian.org/1072573
> Patch-originally-by: Sergio Gelato <sergio.gelato@astro.su.se>
> Signed-off-by: Salvatore Bonaccorso <carnil@debian.org>
> ---
> Changes in v2:
> - Fix typo in URL for Debian bug reference
> - Reorder patch tags and use Closes tag after Reported-by
> 
>  utils/idmapd/idmapd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/utils/idmapd/idmapd.c b/utils/idmapd/idmapd.c
> index cd9a965f8fbc..5231f56d24a8 100644
> --- a/utils/idmapd/idmapd.c
> +++ b/utils/idmapd/idmapd.c
> @@ -556,7 +556,7 @@ dirscancb(int fd, short UNUSED(which), void *data)
>  			if (nfsopen(ic) == -1) {
>  				close(ic->ic_dirfd);
>  				free(ic);
> -				goto out;
> +				continue;
>  			}
>  
>  			if (verbose > 2)
> -- 
> 2.45.2
> 

