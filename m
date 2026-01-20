Return-Path: <linux-nfs+bounces-18219-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WBXhLvERcGlyUwAAu9opvQ
	(envelope-from <linux-nfs+bounces-18219-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Jan 2026 00:38:25 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 56C724DF19
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Jan 2026 00:38:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 01279B41928
	for <lists+linux-nfs@lfdr.de>; Tue, 20 Jan 2026 23:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02A723A7F7B;
	Tue, 20 Jan 2026 23:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PwWmuW0l"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25FE3EFD34
	for <linux-nfs@vger.kernel.org>; Tue, 20 Jan 2026 23:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768951371; cv=none; b=r74QV0twbbbSwm8zT8LzsNUrdx/aAwgMRKgSdWAEL4ywxb7QIP1CLGCQmntN/NVbN5JZtnC/KBYfJPtMQKbOhz1EP7gitUGUlt5FKPwmy1foqMcwaKmkZWngwkCfpTAj4NOtgnf15Xuv16YsHZc9RM3QjAfs+fUAtshODcHBW6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768951371; c=relaxed/simple;
	bh=aeDsQIBiXfmzKfF+KaC1bxAW54Ua0ovZHBbiXDdGASw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jDNGph4qA/qyXBegoH/jWdorZGu2o1ASQawKuB7sl7hmNwX9RO90bTm/gRcJ87sLVlq4FLiJhXrct1IOSaSKlpSjs8wsIJR5f8YO/j2F9QgkdgPZkvy/B9mqV8AKjslqOgJ/rd71JUol1F47eC09btn3iR0tk/fS5IEsTt7lmhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PwWmuW0l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 373F8C16AAE;
	Tue, 20 Jan 2026 23:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768951371;
	bh=aeDsQIBiXfmzKfF+KaC1bxAW54Ua0ovZHBbiXDdGASw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=PwWmuW0lZ1Jh7VTwZY+aW0CGH4VpnKw/4posee7y3LW2402dwHmPu9Fy3ZRzqUFAo
	 stLAe2QYxQohO6TVzWnowyP9i1i5Tv0Jcl4kAVr3F1a0qUR10AH24Y6XygpwOWc9jj
	 wkdJnz9fqrkVXyW7XTYTEu+QyHZWPRR3MXsw1deW8xGVSmdcIXOkoTbls+3TCIBA9H
	 KWa3+pnG7TMNXlWrcQex60yR4Y/TbmViaYvpgol0d24GY5iq+iullcv1LG2HA1QmD+
	 4tOzvuSrttGel5E9P32xfW+KkzE236C9dtqGFAYENAdAiETpqr8LUuhKy5iVHXhui/
	 acfOH5yAyC0Ig==
Message-ID: <e7e87d150b3f070ca872e5cf418331ebf8ed161f.camel@kernel.org>
Subject: Re: [PATCH RFC] NFS: Add some knobs for disabling delegations in
 sysfs
From: Trond Myklebust <trondmy@kernel.org>
To: Olga Kornievskaia <aglo@umich.edu>, Jeffrey Layton <jlayton@kernel.org>
Cc: Scott Mayhew <smayhew@redhat.com>, anna@kernel.org, 
	linux-nfs@vger.kernel.org
Date: Tue, 20 Jan 2026 18:22:50 -0500
In-Reply-To: <CAN-5tyGHz0yAQToc8cSUW=ka_F1a7Yqe5w1pkx1Vx3F-9nhESA@mail.gmail.com>
References: <20251125001544.18584-1-smayhew@redhat.com>
	 <e49d89f7818c72fb3f7bbb2dd90630394c55c0dc.camel@kernel.org>
	 <CAN-5tyGHz0yAQToc8cSUW=ka_F1a7Yqe5w1pkx1Vx3F-9nhESA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-18219-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[trondmy@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[hammerspace.com:email,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 56C724DF19
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 2026-01-20 at 15:46 -0500, Olga Kornievskaia wrote:
> On Mon, Nov 24, 2025 at 8:01=E2=80=AFPM Trond Myklebust <trondmy@kernel.o=
rg>
> wrote:
> >=20
> > Hi Scott,
> >=20
> > On Mon, 2025-11-24 at 19:15 -0500, Scott Mayhew wrote:
> > > There's occasionally a need to disable delegations, whether it be
> > > due
> > > to
> > > known bugs or simply to give support staff some breathing room to
> > > troubleshoot issues.=C2=A0 Currently the only real method for
> > > disabling
> > > delegations in Linux NFS is via /proc/sys/fs/leases-enable, which
> > > has
> > > some major drawbacks in that 1) it's only applicable to knfsd,
> > > and 2)
> > > it
> > > affects all clients using that server.
> > >=20
> > > Technically it's not really possible to disable delegations from
> > > the
> > > client side since it's ultimately up to the server whether grants
> > > a
> > > delegation or not, but we can achieve a similar affect in
> > > NFSv4.1+ by
> > > manipulating the OPEN4_SHARE_ACCESS_WANT* flags.
> > >=20
> > > Rather than proliferating a bunch of new mount options, add some
> > > sysfs
> > > knobs to allow some of the nfs_server->caps flags related to
> > > delegations
> > > to be adjusted.
> > >=20
> >=20
> > Shouldn't we rather be allowing the application to select whether
> > it
> > wants to request a delegation or not?
> >=20
> > IOW: while there may or may not be a place for a 'big hammer'
> > solution
> > like you propose, should we not rather first try to enable a
> > solution
> > in which someone could add a O_DELEGATION or O_NODELEGATION flag to
> > open() in order to specify what they want.
>=20
> Hi Trond,
>=20
> Shouldn't open flags be something that's a generic concept for all
> filesystems? O_DELEGATION seems to be NFS specific (or at most
> network
> filesystem specific).
>=20
> > That might also allow someone to add an LD_PRELOAD library to add
> > or
> > remove these flags from an existing application's open() calls.
> >=20
> > It might also be useful for the directory delegation functionality
> > that
> > Anna and Jeff have been working on...
>=20
> Being able to control directory delegations feature (might be) useful
> too? We used to be able to toggle features via mount options,
> wouldn't
> it be nice if we could again.... Toggling features via sysfs is
> useful
> for when mount is already in place though.
> >=20

Isn't Jeff Layton in the process of exporting the NFSv4 delegation
functionality to userspace through the lease mechanisms?

--=20
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trondmy@kernel.org, trond.myklebust@hammerspace.com

