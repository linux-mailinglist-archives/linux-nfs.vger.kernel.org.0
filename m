Return-Path: <linux-nfs+bounces-16543-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B63EDC6F158
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Nov 2025 14:57:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 703AC3A22B6
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Nov 2025 13:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C42E35A959;
	Wed, 19 Nov 2025 13:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QXphSgiE"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318463546EF
	for <linux-nfs@vger.kernel.org>; Wed, 19 Nov 2025 13:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763560133; cv=none; b=J6SfRQZhGcMT+TjZhVgoJ++n3KJmGmc+NayGQXvmoASOocmUNADwPBBFnhPeYyUXtsKNXg35D+FFk7ypU4YlpoxiXkMJq0w0/g8TMWwx4CMwvnkEe0r/LTwI+cNYiWrDqhi43vtlvhiMhT1GXS6b6l7I1B0b9tStz2Jm1lYm/Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763560133; c=relaxed/simple;
	bh=jFXxKJfx8ei7qn3FzXsOjQIf/u4uXUpLt/x73yeM7CQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ePFltqTtE+aM4pwDVM0sdvuE5yrToQQGNRBqbXUk+0bMLAzKfOFuGuHhNSTncKy+KgX7zjSOH2t5XUscef2ODv3DPaYAyRKyzTviB0YIl0yKRKobVTNszDoglK9ksM5iRIphIYkv52V0NFUp9qv2nYcFgAHXyPF3O6lWoEoxclg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QXphSgiE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21ADCC4AF0D;
	Wed, 19 Nov 2025 13:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763560132;
	bh=jFXxKJfx8ei7qn3FzXsOjQIf/u4uXUpLt/x73yeM7CQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=QXphSgiEmUFmcPXq1U6QZ6196oxS96jU0rz+G+xGyCJYMnMzczLslSYnrz3Nj2Lxc
	 C7ttFTrmce+JfolkcVsw/1Wed6j1ik2lFq9nzL+GSikM699nhmm/WMugyIxnAycqns
	 ujsJZaSICMa9PZdZTnIa1ACch5q9tkt3c5Gw9Ud34UiY3rOyxkDg8kVR1KMkvvFBgl
	 vvb8A3NfwrtIvurReCVjS1+/ft2uH0e+e48DAq8w/Ll8WEo3BVWVP5TfrcEpojpnS5
	 FUvb2zGpO4tEFW+3Ny5X3T1yCHgcZcv88JbsXc9L1LZiyHdbm+5FjogQnmnkAtV65q
	 9ETgbhEdCEjZA==
Message-ID: <53bc46637bdc4b267a318c74fb4c97cb382f29d1.camel@kernel.org>
Subject: Re: Spurious -EEXIST from NFSv3
From: Trond Myklebust <trondmy@kernel.org>
To: Michael Stoler <michael.stoler@vastdata.com>, linux-nfs@vger.kernel.org
Cc: Dan Aloni <dan.aloni@vastdata.com>
Date: Wed, 19 Nov 2025 08:48:50 -0500
In-Reply-To: <CAGztG2BdRW8fy9iF5u0iJmMoXrc2G0NQTt8jwk12Q=Q+e0FaLQ@mail.gmail.com>
References: 
	<CAGztG2BdRW8fy9iF5u0iJmMoXrc2G0NQTt8jwk12Q=Q+e0FaLQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-11-19 at 12:52 +0200, Michael Stoler wrote:
>=20
> =C2=A0
> You don't often get email from michael.stoler@vastdata.com.=20
> Learn why this is important=20
>=20
>=20
>=20
>=20
>=20
>=20
> =C2=A0 =C2=A0 I=E2=80=99m having an issue with an NFS driver based on Lin=
ux 5.15.147.
> The function nfs_verifier_is_delegated() spuriously returns true for
> NFSv3 file inside nfs_do_lookup_revalidate(). This causes the
> d_revalidate method to return true for a removed file, which in turn
> leads to an -EEXIST error during exclusive creation of a non-existent
> file.
>=20
> =C2=A0 =C2=A0It appears that the root cause is an initialization races or=
 an
> uninitialized d_time value. The attached patch resolves the issue,
> but is there a more graceful or proper solution?
>=20

That patch is incorrect. The verifier must be initialised for all
visible dentries, irrespective of the NFS version. Let me see if I can
come up with something.

--=20
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trondmy@kernel.org, trond.myklebust@hammerspace.com

