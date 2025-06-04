Return-Path: <linux-nfs+bounces-12111-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65223ACE4C0
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Jun 2025 21:22:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F15003A38A6
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Jun 2025 19:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC5771FAC29;
	Wed,  4 Jun 2025 19:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=muni.cz header.i=@muni.cz header.b="pQD3QVxR"
X-Original-To: linux-nfs@vger.kernel.org
Received: from minas.ics.muni.cz (minas.ics.muni.cz [147.251.4.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D667F1DC07D
	for <linux-nfs@vger.kernel.org>; Wed,  4 Jun 2025 19:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=147.251.4.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749064942; cv=none; b=LvVmucPVT3Oe+jP6MRhEO/rShRU8eKZkq0CLNq0UqXqHnnRMf94Q5Wk20pL2p83avPAhclfIKuDYXwbs7YqY5gWkDTlTLawPplyLbdyO/cIDdI/MkFx4KNH81F2J3RqEkfyk998iXm5541fqMxEgykGURkxcCSF8LCH+HJ5/a6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749064942; c=relaxed/simple;
	bh=hTBPApIpHzEhtP2VzsV5HDn6hcG++ybwYCjdA5vjYNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s2Hsy+w2zJWjTLWsDitRyOhuhYidPlBYeKs1qnw2+C7MEWPXYhb8fB6BHDg8TTLC9eJb5feQjVRbGRqmTttYB+ksxOL2Rv+2GMURYcSm0vl6mCLDD2+/aghIYykNdIvmwD6kT9edL1anLlEWMON+cSrlyhfFWKrapG78/dJDcA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ics.muni.cz; spf=pass smtp.mailfrom=ics.muni.cz; dkim=pass (2048-bit key) header.d=muni.cz header.i=@muni.cz header.b=pQD3QVxR; arc=none smtp.client-ip=147.251.4.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ics.muni.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ics.muni.cz
Received: from horn.ics.muni.cz (horn.ics.muni.cz [147.251.17.150])
	(authenticated user=salvet bits=0)
	by minas.ics.muni.cz (8.17.1.9/8.17.1.9/Debian-2+deb12u2) with ESMTPSA id 554JB5Nv3075512
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 4 Jun 2025 21:11:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=muni.cz; s=relay;
	t=1749064267; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:in-reply-to:in-reply-to:  references:references;
	bh=wrEmVfx5rg6wHxzv7NC5p3PzTIPR/6ImTyRd0BD1WcI=;
	b=pQD3QVxRQYi3IIcbQlV2b2R2Uv7Ecpx4nOQuttXxQZfaH2ap42McA0pcHGTCq9UGOP0mON
	8xKOnFSY37nFlVJtIVGl5zYxlvdiuuoRkk3ECmU8TGXemFsyBLzD/Tfhxj6ONClXtc9d4Q
	BvuuE6HK+pdMjocrYtMRdipxblqD5OLiZheqsIk9wvoRhWlocQ7+XBPNr/WlY2ilUWFmos
	g9RrmilWiIcbWGXJTIC+dEAymP2o/sjlFqepyeZOi5CyAcnhD5zdHmKaH2rUO1AZU6ibrY
	luXWJUeYwHrGQFkmA2G6BwDi+pJ05ySsk2cBAlpqwQB/uT/V1xbq/LRCo6Q2kQ==
Authentication-Results: relay.muni.cz;
	auth=pass smtp.auth=salvet smtp.mailfrom=salvet@ics.muni.cz
Date: Wed, 4 Jun 2025 21:11:05 +0200
From: Zdenek Salvet <salvet@ics.muni.cz>
To: Santosh Pradhan <santosh.pradhan@gmail.com>
Cc: =?iso-8859-2?B?THVr4bkgSGVqdG3hbmVr?= <xhejtman@ics.muni.cz>,
        linux-nfs@vger.kernel.org
Subject: Re: NFS stuck in nfs_lookup_revalidate
Message-ID: <aECaSYGt59HHgi7M@horn.ics.muni.cz>
Reply-To: salvet@ics.muni.cz
References: <18945D18-3EDB-4771-B019-0335CE671077@ics.muni.cz>
 <CAOuNp5kzbyVfbdumXJF3bb=RKxdE5P8aKJDeSoLtgEV9=9xU+g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOuNp5kzbyVfbdumXJF3bb=RKxdE5P8aKJDeSoLtgEV9=9xU+g@mail.gmail.com>
X-Muni-Envelope-From: salvet@ics.muni.cz
X-Muni-Envelope-To: linux-nfs@vger.kernel.org
X-Muni-Spam-TestIP: 147.251.17.150
X-Muni-Local-IP: yes
X-Muni-Local-Auth: yes
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.2 (minas.ics.muni.cz [147.251.4.35]); Wed, 04 Jun 2025 21:11:07 +0200 (CEST)
X-Virus-Scanned: clamav-milter 1.0.7 at minas
X-Virus-Status: Clean
X-Spamd-Bar: /
X-Rspamd-Action: no action
X-Rspamd-Server: minas
X-Rspamd-Queue-Id: 554JB5Nv3075512
X-Spamd-Result: default: False [-0.10 / 60.00];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[muni.cz:s=relay];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ARC_NA(0.00)[];
	FROM_MUNI(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	ASN(0.00)[asn:2852, ipnet:147.251.0.0/16, country:CZ];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TAGGED_RCPT(0.00)[];
	FROM_HAS_DN(0.00)[];
	HAS_REPLYTO(0.00)[salvet@ics.muni.cz];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com]
X-Muni-o365-Test: salvet@ics.muni.cz,linux-nfs@vger.kernel.org

On Thu, Jun 05, 2025 at 12:00:44AM +0530, Santosh Pradhan wrote:
> I am not sure but I vaguely remember that there was some similar issue and
> Neil introduced store_release_wake_up() which puts a full barrier  smp_mb()
> before calling wake_up_var().
> 
> index d0e0b435a843..e754e3e478a5 100644
> --- a/fs/nfs/dir.c
> +++ b/fs/nfs/dir.c
> @@ -1830,6 +1830,7 @@ static void unblock_revalidate(struct dentry *dentry)
>  {
>         /* store_release ensures wait_var_event() sees the update */
>         smp_store_release(&dentry->d_fsdata, NULL);
> + smp_mb();
>         wake_up_var(&dentry->d_fsdata);
>  }

Hello,
yes, upon rereading exact definition of smp_store_release(),
I am reasonably sure the comment is wrong and smp_mb() should be used,
it ensures the right ordering between store to d_fsdata and wait queue
data, not the smp_store_release(&dentry->d_fsdata,...).

Best regards,
Zdenek Salvet                                              salvet@ics.muni.cz 
Institute of Computer Science of Masaryk University, Brno, Czech Republic
and CESNET, z.s.p.o., Prague, Czech Republic
Phone: ++420-549 49 6534                           Fax: ++420-541 212 747
----------------------------------------------------------------------------
      Teamwork is essential -- it allows you to blame someone else.


