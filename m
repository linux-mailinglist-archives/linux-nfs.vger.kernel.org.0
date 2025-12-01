Return-Path: <linux-nfs+bounces-16812-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CA58FC9711D
	for <lists+linux-nfs@lfdr.de>; Mon, 01 Dec 2025 12:38:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2774F4E1A44
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Dec 2025 11:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 005AF26CE06;
	Mon,  1 Dec 2025 11:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NNMsX8v+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5571826657D
	for <linux-nfs@vger.kernel.org>; Mon,  1 Dec 2025 11:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764588891; cv=none; b=gCZZzjXaoXs4QFSSmexQx5sml+Vlp/C5rhE1kzzpgUlaa0voIuW8cn+OJmMI4NqGuVQ44SwaLv3okmYrBLdqYIccOZpkbZWFmbj/VsArRcxYkqDEAOt9i8P12ceg+rR3yEGvS+SQ9Eg6e8y6wQY85xloBN9rWOvHaJr1m/g8Q1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764588891; c=relaxed/simple;
	bh=DuoFWSO41+bMbw/OAXvKPpzP0hvA1mSnPfRj8rBnfWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TbLbQb6HwO4djRdMnjTGVbkqR1Ms76t5pWDLptlKrHpDuCZX76uZB8YIEyJOZOc7NZEmk8DInIUyIMO3quBe3aL2YHd/xaugrDvTj8k6DMOBiwZ7ybApfcbyOn1sjix6ysuurUzqISvBXrJTpEWVU0hJVx6x6/uIiUynzT3KIqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NNMsX8v+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764588889;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IiZxINT0yvoeHntsAKTO1KteZgk2/I/SgdeX+tCgxZs=;
	b=NNMsX8v+J05e6BsGzwL74eNBr7pCtIBbAUyFoen4FmM8p23aHtIN/j7kmo4kgoxjVmYLCl
	dlEgT1afG9AtIHEBjrtUtypdQEQVL2MIGngrkE1SjvKywc0YDd+8mhZk0/GdbHWBiemFme
	zrZlwQ3LoK8e1bHeTfTUjMXyGMF3Qec=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-493-QUDSBQXXMZKegMURxlHS8A-1; Mon,
 01 Dec 2025 06:34:47 -0500
X-MC-Unique: QUDSBQXXMZKegMURxlHS8A-1
X-Mimecast-MFC-AGG-ID: QUDSBQXXMZKegMURxlHS8A_1764588887
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 050EE1800350;
	Mon,  1 Dec 2025 11:34:47 +0000 (UTC)
Received: from aion.redhat.com (unknown [10.22.64.87])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A7B861800346;
	Mon,  1 Dec 2025 11:34:46 +0000 (UTC)
Received: by aion.redhat.com (Postfix, from userid 1000)
	id D159C526C95; Mon, 01 Dec 2025 06:34:44 -0500 (EST)
Date: Mon, 1 Dec 2025 06:34:44 -0500
From: Scott Mayhew <smayhew@redhat.com>
To: Trond Myklebust <trondmy@kernel.org>
Cc: anna@kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH RFC] NFS: Add some knobs for disabling delegations in
 sysfs
Message-ID: <aS19VL6-SLpejH1r@aion>
References: <20251125001544.18584-1-smayhew@redhat.com>
 <e49d89f7818c72fb3f7bbb2dd90630394c55c0dc.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <e49d89f7818c72fb3f7bbb2dd90630394c55c0dc.camel@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Mon, 24 Nov 2025, Trond Myklebust wrote:

> Hi Scott,
>=20
> On Mon, 2025-11-24 at 19:15 -0500, Scott Mayhew wrote:
> > There's occasionally a need to disable delegations, whether it be due
> > to
> > known bugs or simply to give support staff some breathing room to
> > troubleshoot issues.=A0 Currently the only real method for disabling
> > delegations in Linux NFS is via /proc/sys/fs/leases-enable, which has
> > some major drawbacks in that 1) it's only applicable to knfsd, and 2)
> > it
> > affects all clients using that server.
> >=20
> > Technically it's not really possible to disable delegations from the
> > client side since it's ultimately up to the server whether grants a
> > delegation or not, but we can achieve a similar affect in NFSv4.1+ by
> > manipulating the OPEN4_SHARE_ACCESS_WANT* flags.
> >=20
> > Rather than proliferating a bunch of new mount options, add some
> > sysfs
> > knobs to allow some of the nfs_server->caps flags related to
> > delegations
> > to be adjusted.
> >=20
>=20
> Shouldn't we rather be allowing the application to select whether it
> wants to request a delegation or not?
>=20
> IOW: while there may or may not be a place for a 'big hammer' solution
> like you propose, should we not rather first try to enable a solution
> in which someone could add a O_DELEGATION or O_NODELEGATION flag to
> open() in order to specify what they want.
>=20
> That might also allow someone to add an LD_PRELOAD library to add or
> remove these flags from an existing application's open() calls.

Sure, allowing the application to specify whether it wants a delegation
or not would be better... but with open() being governed by POSIX and
with delegations being an NFS-specific feature, I figured adding open
flags related to delegations wasn't feasible.  I discussed it with Olga,
and she had the same opinion.  Are we mistaken here?

>=20
> It might also be useful for the directory delegation functionality that
> Anna and Jeff have been working on...
>=20
> Just some food for thought while you're digesting on Thursday :-)...
>=20
> --=20
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trondmy@kernel.org, trond.myklebust@hammerspace.com
>=20


