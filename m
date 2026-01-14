Return-Path: <linux-nfs+bounces-17842-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 492B0D1EB55
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Jan 2026 13:21:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A927F30021F4
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Jan 2026 12:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A46F1387573;
	Wed, 14 Jan 2026 12:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C4Ldngz4"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2963904D0
	for <linux-nfs@vger.kernel.org>; Wed, 14 Jan 2026 12:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768393292; cv=none; b=XCNz3y8j/Lkup5evKWkMvmQ9iPwYDRDomyOwZlSCD6ct3k/7Fir9NX44VdZBSEKpQghJOdC+By12VHSJ4e3rHmoS+pSUVLtDax0MIyIDzIWoZohdVNn3MuxjD5elDwc3EVdebiHWm7AsQxHNa0eSGSmQ6EX8wpX6NxvOvIJnMck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768393292; c=relaxed/simple;
	bh=U8vCaKMV8v0Mww1r8kq9lCPE+Pjr3hP1s/n3Iw+dGP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m/UOfwwnO7GP2BXaDBNeJ9ixd2/SMqfsOxpxua+L6vON8wGAvyQ2cAbYhCZq5geoQwM0afv6dcTTR/fX3wVWZRpPwPZiGRLo3iELd//Fs61jPlFjBbiYd6h7oAR/3p1UZnwCjddjQvNysYh6qrIadtJBEltpXfQw4C6TTle3RuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C4Ldngz4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768393290;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9Z5TEtZfOBG2rNi5eF6KtCQy571ueLem0EOVKDD00bE=;
	b=C4Ldngz4HEuf9RYYg7K0IZyZTOo0xPMIrIvJM0OncvwIArrYgrRWHnnc1BP1PaLAQeSZBC
	ZDtivKA/aBjqjZOqsXtIyWG89FLNzxWTkX0wr5ymAX3mN1iePm+VSvg3N8UHZnG+EhuKtR
	BhCLRteJXbjLDrz6S4iIaYjXDCPLbqk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-547-xkIa7iKbMVGOtxgKaCIrPw-1; Wed,
 14 Jan 2026 07:21:17 -0500
X-MC-Unique: xkIa7iKbMVGOtxgKaCIrPw-1
X-Mimecast-MFC-AGG-ID: xkIa7iKbMVGOtxgKaCIrPw_1768393276
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AF1E7180034F;
	Wed, 14 Jan 2026 12:21:15 +0000 (UTC)
Received: from aion.redhat.com (unknown [10.22.64.190])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8AAC41956048;
	Wed, 14 Jan 2026 12:21:15 +0000 (UTC)
Received: by aion.redhat.com (Postfix, from userid 1000)
	id 3637E5B6EB6; Wed, 14 Jan 2026 07:21:14 -0500 (EST)
Date: Wed, 14 Jan 2026 07:21:14 -0500
From: Scott Mayhew <smayhew@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Salvatore Bonaccorso <carnil@debian.org>, linux-nfs@vger.kernel.org,
	Steve Dickson <steved@redhat.com>
Subject: Re: [nfs-utils] "blkmapd open pipe file
 /run/rpc_pipefs/nfs/blocklayout failed" and handling of nfs-blkmap.service
 service
Message-ID: <aWeKOn18EZYOyLxj@aion>
References: <176814099134.689475.12160936392296863650@eldamar.lan>
 <aWc5dO3fP4J67x0H@infradead.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aWc5dO3fP4J67x0H@infradead.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Tue, 13 Jan 2026, Christoph Hellwig wrote:

> On Sun, Jan 11, 2026 at 03:17:24PM +0100, Salvatore Bonaccorso wrote:
> > For Debian purposes at least I would like to make things bit less
> > irritating for users, keep ideally the service enabled by default, so
> > that administraors whant to make use of pNFS setup with the
> > blocklayout layout protocol, they just need to make the module load.
> 
> The original blocklayout is deprecated because there is almost no
> way to use it safely.   So I'd argue for not enabling blkmapd by
> default, and maybe even splitting it into a separate binary package.
> 
> Note that none of this affects the revised scsi/nvme layouts that are
> safe to use, and don't require blkmapd.
> 
Right, on both Fedora and RHEL nfs-blkmap.service is disabled by default
(via /usr/lib/systemd/system-preset/99-default-disable.preset) because
we support SCSI layout but not block layout.  I could have sworn I've
floated the idea of dropping blkmapd from the Red Hat packages
altogether, but I can't find anything in Bugzilla or Jira.


