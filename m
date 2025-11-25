Return-Path: <linux-nfs+bounces-16708-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1558BC82F7F
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Nov 2025 02:01:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B75AA3457EA
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Nov 2025 01:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC5D836D4F0;
	Tue, 25 Nov 2025 01:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iD3Qfx/+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969D736D4E8
	for <linux-nfs@vger.kernel.org>; Tue, 25 Nov 2025 01:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764032457; cv=none; b=GLWABj/GyVnVb7NvqRAlqaK6D8ZuiEtTLY+C3eX0RE6EVI1eOeNkyvSzZPagF/3hM8j8yF8Lwp4SMbyGGrwdoxBt0G12Yo+CBetIIZEq0UHLoUHLaX4a3cTlPD8ZIf5Row06/P1+3l9bn4whBw/S1Cubzr14vjW6xVsi40XOC+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764032457; c=relaxed/simple;
	bh=+kCGaWZHDXCDMqaxd3tlQNOZ4vcC1l7VE4yOPHk/bRw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mCJ1yA3lRSBF8QJhRH7Xi8qo5dk7y4gmSbOcnwQltv+d060Uw9Cv4TW0JruFfniQCtgYp3uNZio+LjhZS+K3aFIcLTYE1DZwTMZQEZbzdahb/17GuDfPrx8Up8e5BH+PIHtz2FhdH2xy0v8SNxg3jtMoG+ztfQiCn6G61zKP8YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iD3Qfx/+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA8F2C4CEF1;
	Tue, 25 Nov 2025 01:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764032457;
	bh=+kCGaWZHDXCDMqaxd3tlQNOZ4vcC1l7VE4yOPHk/bRw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=iD3Qfx/+NJuOYBs/HXeblpbzIumt3CaZjH/PwiEG06oiSTtpxvYI2B5FdPMWzVgfn
	 nWee9FKr/BNTD4t8T7ZyrYMYcmxc5Xc9uLDn7Bo7j4aPvAVoJlEr5Aw+tnBJwe4BoF
	 HECXtaq0kGh7kpCYJRlabSksd3hfXXWdYAE2F/GIC2I0rUoRuaOAKkcU5UtPSfFC04
	 S73KDgBCB7T+ANjf3HlTOrClVmM0KIQ6Fuyrdjid92C93+w9+1xICTWx1Rt5+qfLWe
	 ok0eZ+xS3H7nebVP6n+Fy8G/3wgbqA9L1h8nP3H6VIl1tvWe3jqgDrgqc6AbvQ83n+
	 Q9PfKnfMM0LqA==
Message-ID: <e49d89f7818c72fb3f7bbb2dd90630394c55c0dc.camel@kernel.org>
Subject: Re: [PATCH RFC] NFS: Add some knobs for disabling delegations in
 sysfs
From: Trond Myklebust <trondmy@kernel.org>
To: Scott Mayhew <smayhew@redhat.com>, anna@kernel.org
Cc: linux-nfs@vger.kernel.org
Date: Mon, 24 Nov 2025 20:00:55 -0500
In-Reply-To: <20251125001544.18584-1-smayhew@redhat.com>
References: <20251125001544.18584-1-smayhew@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Scott,

On Mon, 2025-11-24 at 19:15 -0500, Scott Mayhew wrote:
> There's occasionally a need to disable delegations, whether it be due
> to
> known bugs or simply to give support staff some breathing room to
> troubleshoot issues.=C2=A0 Currently the only real method for disabling
> delegations in Linux NFS is via /proc/sys/fs/leases-enable, which has
> some major drawbacks in that 1) it's only applicable to knfsd, and 2)
> it
> affects all clients using that server.
>=20
> Technically it's not really possible to disable delegations from the
> client side since it's ultimately up to the server whether grants a
> delegation or not, but we can achieve a similar affect in NFSv4.1+ by
> manipulating the OPEN4_SHARE_ACCESS_WANT* flags.
>=20
> Rather than proliferating a bunch of new mount options, add some
> sysfs
> knobs to allow some of the nfs_server->caps flags related to
> delegations
> to be adjusted.
>=20

Shouldn't we rather be allowing the application to select whether it
wants to request a delegation or not?

IOW: while there may or may not be a place for a 'big hammer' solution
like you propose, should we not rather first try to enable a solution
in which someone could add a O_DELEGATION or O_NODELEGATION flag to
open() in order to specify what they want.

That might also allow someone to add an LD_PRELOAD library to add or
remove these flags from an existing application's open() calls.

It might also be useful for the directory delegation functionality that
Anna and Jeff have been working on...

Just some food for thought while you're digesting on Thursday :-)...

--=20
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trondmy@kernel.org, trond.myklebust@hammerspace.com

