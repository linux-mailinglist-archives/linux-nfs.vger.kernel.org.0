Return-Path: <linux-nfs+bounces-18330-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mFbQIhuTcmkMmQAAu9opvQ
	(envelope-from <linux-nfs+bounces-18330-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 22 Jan 2026 22:14:03 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 297226DA31
	for <lists+linux-nfs@lfdr.de>; Thu, 22 Jan 2026 22:14:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 39CCD300B9D6
	for <lists+linux-nfs@lfdr.de>; Thu, 22 Jan 2026 21:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 440043BB9EB;
	Thu, 22 Jan 2026 21:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hj6uYYTX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF4F3AA1A9
	for <linux-nfs@vger.kernel.org>; Thu, 22 Jan 2026 21:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769116438; cv=none; b=ExYxLXwl00EqUuLUpe9LqplkdzCb3883vcidpOVIaS2R5Ca5rCw9p4+RuiRXJ6UImRLziZRdf6/4mqOIKNsTnqPuR+kyC9hgEsOuXrw1a0AS/cP4zDtuvxVlqRztO2y6ZrJua15Q/adIqjasE/V/G17Wga13BeHYLYP1B/h2pYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769116438; c=relaxed/simple;
	bh=QqdqOxEF1IZ1ZVO+IuF2xGK0+FICnSXkcrRDUwG9UEE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Q+9GOTUcuE6NbqZfqDlpHMuZX+pN2ZdU1z4hXYCxWoWwM+dR5qpURfEObW3NO7YFeBt6figxT5QKSC9F5j43unXkhvM5REnj9xs2Oka1RsQkogpjDxlbnwMjFCx3Nex8B0mt+ZT6STCq2RJ6Vg1n1HVEkFsJe0Oc97YDTdgKb68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hj6uYYTX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76D44C116C6;
	Thu, 22 Jan 2026 21:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769116436;
	bh=QqdqOxEF1IZ1ZVO+IuF2xGK0+FICnSXkcrRDUwG9UEE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=hj6uYYTXfRznuD51MgJkjbbupkHDGq8cgrKtDZXH/TDd+vrWceZMpCsKN5xsRAw3T
	 fP7UVzhwYgLYclKbbwq6w6OEbMYfEJG0Gbc/AApdm+2HrxiOmDh8Vss9PvZZljQBt9
	 UUm/gdipq/eVGiI1dZT5Yey4KIyH6Ox7LZgliGvjk4yjEdCMqhAMW1fI3XiZq1PZlH
	 IQPTW6dn8iKZgrk2NQ+YANiUOo8XZidBs9/slrRfdijri79TkrpOJdFGDtO5NUJ4XV
	 nB5ZsoS7PxTU8RvSyXKwkkTtDNMogReu7W4lenCVgUCWspFGvUwtids/lRdoBIuCoE
	 HNlrSanOfZKiQ==
Message-ID: <48d4e00bd1e37b95e21f2afac15e8fc96c06b868.camel@kernel.org>
Subject: Re: Possible regression after NFS eof page pollution fix (ext4
 checksum errors)
From: Trond Myklebust <trondmy@kernel.org>
To: Mark Bloch <mbloch@nvidia.com>
Cc: Linoy Ganti <lganti@nvidia.com>, Bar Friedman <bfriedman@nvidia.com>, 
	linux-nfs@vger.kernel.org, Maor Gottlieb <maorg@nvidia.com>
Date: Thu, 22 Jan 2026 16:13:55 -0500
In-Reply-To: <9871411e-8272-4f95-80f0-2b86e55231b8@nvidia.com>
References: <447f41f0-f3ab-462a-8b59-e27bb2dfcbc0@nvidia.com>
	 <43278ef7e260f46de5a7130331f30e12b916f89a.camel@kernel.org>
	 <3e7d4222-9326-4761-819f-114831919c80@nvidia.com>
	 <d6419d6b1e24c2a704a44f6347bfcfa59fa195c2.camel@kernel.org>
	 <211e07b8129353fbec59b44f4859ce22947f222b.camel@kernel.org>
	 <391d9e32-afef-4b1c-adf9-422204360c77@nvidia.com>
	 <9871411e-8272-4f95-80f0-2b86e55231b8@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18330-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[trondmy@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 297226DA31
X-Rspamd-Action: no action

On Thu, 2026-01-22 at 12:00 +0200, Mark Bloch wrote:
>=20
>=20
> On 11/01/2026 9:03, Mark Bloch wrote:
> > Hi Trond,
> >=20
> > On 11/01/2026 2:24, Trond Myklebust wrote:
> > > Hi Mark,
> > >=20
> > > On Mon, 2026-01-05 at 10:20 -0500, Trond Myklebust wrote:
> > > >=20
> > > > OK so if I'm understanding correctly, this is organised as ext4
> > > > partitions that are stored in qcow2 images that are again
> > > > stored on a
> > > > NFSv4.2 partition.
> > > >=20
> > > > Do these qcow2 images have a file size that is fixed at
> > > > creation
> > > > time,
> > > > or is the file size dynamic?
> >=20
> > The file size is dynamic (with a fixed maximum of 35 GB).
> >=20
> > > > Also, does changing the "discard" option from "unmap" to
> > > > "ignore"
> > > > make
> > > > any difference to the outcome?
> >=20
> > The discard option is already set to "ignore" in the image.
> > Do you want us to test the other options just to see if it makes
> > a difference?
> >=20
> > >=20
> > > I've been staring at this for several days now, and the only
> > > candidate
> > > for a bug in the NFS client that I can see is this one. Can you
> > > please
> > > check if the following patch helps?
> >=20
> > Thanks for the patch, I'll let the team dealing with the issue know
> > and let them test the patch.
> > I'll update once I know anything.
>=20
> We've been testing your patch for some time now and didn't hit the
> issue.
> Feel free to add Bar's tested by tag as she was the one
> that actually tested the fix. Thanks for looking into this.
>=20
> Tested-by: Bar Friedman <bfriedman@nvidia.com>
>=20
> Mark
>=20


Thank you very much for testing, Bar! I unfortunately already sent the
patch upstream as it was clearly a necessary fix (even though it was
not obvious to me that it would be sufficient to fix your reported
problem). I'm therefore hoping it will hit the 6.18.x stable kernels
soon.

>=20

--=20
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trondmy@kernel.org, trond.myklebust@hammerspace.com

