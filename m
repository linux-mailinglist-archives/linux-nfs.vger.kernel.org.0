Return-Path: <linux-nfs+bounces-10485-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C156A502C0
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Mar 2025 15:54:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 116A93ADE49
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Mar 2025 14:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B91D24EF67;
	Wed,  5 Mar 2025 14:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jlXYD95U"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C157F24EF60;
	Wed,  5 Mar 2025 14:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741186175; cv=none; b=sU8AooIxTPj1R9U6cdWEepxtdFU72qmMEAzMgiOzTBlOLuMbXSz5DwU1ABuPBQjClKu4GVxFhybnZTjWxeOWLW5/khG4RsWEmMYOZ8kbCkMzsvCIFMcHAqtnuTZYy9p6jmeNtyLV0fpsI65rDbBQeNaXvgIletZ6pV33Rm+RNeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741186175; c=relaxed/simple;
	bh=D84ci62grFcuJO70CerFjW0xkC4+IeGaiwJ4WHWUeUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=embmpk/5aPjpaoPoAPQ8YJJHTGpKlZ3RHScG6qTixuyvzhL54sihu0NveAcCGq6Ub4pX+JrcdmTasGLJb+HaKAPuwtOA1E68QsLp755bAkW+P7o6wuPyS1eEdAVgTCpB/xX/5rt30VH2wHBtDW28YKrIOjGNWQlWHVHidg6cl+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jlXYD95U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B002FC4CEE2;
	Wed,  5 Mar 2025 14:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741186175;
	bh=D84ci62grFcuJO70CerFjW0xkC4+IeGaiwJ4WHWUeUk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jlXYD95UtYNurBOZKb7cznBPK2Ow4UV4h8WGuk0pIvNT8xpqMzzyAFFzzodRE2QGq
	 rPWIeyzOGSoilrex9Fqs9HFgGLuSn0DPB0xK/j7lPS240PsPTR9OiO1F/T7cKxczmO
	 XPn+C4W0p9aZW7PBPYW2q5jzfU0KKV+sEZIxwN/eknFrJcUZNG/CBD42G3GWtUVE49
	 FPkpinv0EFJFBpc3unSkvG6ySZ1UEYUZMjTsu96JGVCuNaxlgkL1iK0Iu1q/bLKv/T
	 4tYXNGX1jbisd+KuiW/BauHUirM8tAxxEK/aP4U1RthJof5GEvN6cg/a4Ro26MwJjn
	 ch7/fVAQWdbWQ==
Date: Wed, 5 Mar 2025 15:49:30 +0100
From: Joel Granados <joel.granados@kernel.org>
To: cel@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-scsi@vger.kernel.org, codalist@coda.cs.cmu.edu, linux-nfs@vger.kernel.org, 
	nicolas.bouchinet@clip-os.org, Chuck Lever <chuck.lever@oracle.com>, 
	Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>, Clemens Ladisch <clemens@ladisch.de>, 
	Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, 
	Jan Harkes <jaharkes@cs.cmu.edu>, Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>, 
	Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
	Bart Van Assche <bvanassche@acm.org>, Zhu Yanjun <yanjun.zhu@linux.dev>, 
	Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v2 2/6] sysctl: Fixes nsm_local_state bounds
Message-ID: <nh4mo25vhojzwf6djsocdmbylu4xrzlle3zoqoxvif3dobygoh@qkwjicufplpq>
References: <20250224095826.16458-1-nicolas.bouchinet@clip-os.org>
 <20250224095826.16458-3-nicolas.bouchinet@clip-os.org>
 <174103811019.30862.13359233350686241870.b4-ty@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <174103811019.30862.13359233350686241870.b4-ty@oracle.com>

On Mon, Mar 03, 2025 at 04:42:17PM -0500, cel@kernel.org wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> On Mon, 24 Feb 2025 10:58:17 +0100, nicolas.bouchinet@clip-os.org wrote:
> > Bound nsm_local_state sysctl writings between SYSCTL_ZERO
> > and SYSCTL_INT_MAX.
> > 
> > The proc_handler has thus been updated to proc_dointvec_minmax.
> > 
> > 
> 
> Applied to nfsd-testing with modifications, thanks!
> 
> [2/6] sysctl: Fixes nsm_local_state bounds
>       commit: 8e6d33ea0159b39d670b7986324bd6135ee9d5f7
> 
> --
> Chuck Lever
Thx!

@nicolas: remove this one from your next Version

Best

-- 

Joel Granados

