Return-Path: <linux-nfs+bounces-16485-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B8F5C6A9D7
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Nov 2025 17:27:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 274C635D023
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Nov 2025 16:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03CDA36A01E;
	Tue, 18 Nov 2025 16:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EHZh1oj7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D406934B1A8
	for <linux-nfs@vger.kernel.org>; Tue, 18 Nov 2025 16:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763482609; cv=none; b=GIzW6C3pu+8cNG3O/DyAn5UyaKeu8hlzHlI+oyGo7mbcmSAa1w9mXpxeuL7SQpWDRHHAjvSlwHluUmHq70GlvVOnt+F4cNtZ4B44Q3glp4bu5YAkRa97TGfpdWkQyyDstxtdkurZVYq5EV0H1laNIIzv2bgZp+wKx3rM4RLI6A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763482609; c=relaxed/simple;
	bh=CerVUsQGt0vga99pJnvrbRxbrd5H//S/TwFlAU/ncZU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tHD99qafD6pg7RXb8SADGWNvwWzNfwGjIHFbfEqi3CxQj+mPZnDxhj6bFx3tEuLadjy/o3qzEQMP8k2i05fs3bFtdmj4ilTGNrnKD9cLbBb2oIB9Bdqmua+P08q6lFpiNiv7uGJN1a9J5bS1BGwH5VlGeCsHiMNNl6kT1/A9KoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EHZh1oj7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAB5DC19422;
	Tue, 18 Nov 2025 16:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763482606;
	bh=CerVUsQGt0vga99pJnvrbRxbrd5H//S/TwFlAU/ncZU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=EHZh1oj7p8RmPCIJ6DnxdrOWdgoGBaEmNSS0k7UuZ696aqFQdp2trsGyQiayqCHip
	 C9qzwK2a7eOCVrqM1d9PRHXyINYGoNdKcYu8dovTsaFRpMWABRZF8qMPySt6LRKZRH
	 LsNwmnp6vd8OibP78iyHYCpkrrY+lSsudrvfTONzQd8SQ9umOU2J4kSb3maLAuKszZ
	 IEduoP24Gkym79jIS2fGHf1nWOFCBtSg3swjQT1WURdJhmt1qbeLCKNxXF9OVsXnoN
	 47aRDRv6F4DXPIILnLGGVr2s0Namm9G4DX3ZR8X1rp3Zk46XWFhWZE6D25jGIIDrA4
	 ga8JHXndbFx4w==
Message-ID: <1fd78dbccac873a277e71e55409acc5d1d3e6886.camel@kernel.org>
Subject: Re: [PATCH] nfs: Implement delayed data server destruction with
 hold cache
From: Trond Myklebust <trondmy@kernel.org>
To: Gaurav Gangalwar <gaurav.gangalwar@gmail.com>, anna@kernel.org, 
	tom@talpey.com, chuck.lever@oracle.com
Cc: linux-nfs@vger.kernel.org
Date: Tue, 18 Nov 2025 11:16:44 -0500
In-Reply-To: <fe6b3cb2fde809977394c5f605b844de043189ed.camel@kernel.org>
References: <20251118105752.52098-1-gaurav.gangalwar@gmail.com>
	 <fe6b3cb2fde809977394c5f605b844de043189ed.camel@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-11-18 at 09:43 -0500, Trond Myklebust wrote:
> On Tue, 2025-11-18 at 05:57 -0500, Gaurav Gangalwar wrote:
> > Introduce a hold cache mechanism for NFS pNFS data servers to avoid
> > unnecessary connection churn when data servers are temporarily
> > idle.
> >=20
> > Key changes:
> >=20
> > 1. Hold Cache Implementation:
> > =C2=A0=C2=A0 - Add nfs4_data_server_hold_cache to namespace structure
> > =C2=A0=C2=A0 - Move data servers to hold cache when refcount reaches ze=
ro
> > =C2=A0=C2=A0 - Always update ds_last_access timestamp on every referenc=
e
> >=20
> > 2. Configurable Module Parameters:
> > =C2=A0=C2=A0 - nfs4_pnfs_ds_grace_period: Grace period before destroyin=
g idle
> > =C2=A0=C2=A0=C2=A0=C2=A0 data servers (default: 300 seconds)
> > =C2=A0=C2=A0 - nfs4_pnfs_ds_cleanup_interval: Interval for periodic cle=
anup
> > =C2=A0=C2=A0=C2=A0=C2=A0 work (default: 300 seconds)
> >=20
> > 3. Periodic Cleanup Work:
> > =C2=A0=C2=A0 - Schedule delayed work on first DS usage (lazy initializa=
tion)
> > =C2=A0=C2=A0 - Check hold cache and destroy data servers that exceed gr=
ace
> > period
> > =C2=A0=C2=A0 - Reschedule work automatically for continuous monitoring
> >=20
> > 4. Callback Mechanism:
> > =C2=A0=C2=A0 - Use function pointer callback to avoid circular module
> > dependencies
> > =C2=A0=C2=A0 - nfsv4.ko registers cleanup callback during initializatio=
n
> > =C2=A0=C2=A0 - nfs.ko calls callback during namespace cleanup (if regis=
tered)
> >=20
> > 5. Timestamp Tracking:
> > =C2=A0=C2=A0 - Add ds_last_access field to nfs4_pnfs_ds structure
> > =C2=A0=C2=A0 - Update timestamp on DS allocation, lookup, and reference
> >=20
> > Benefits:
> > - Reduces connection setup/teardown overhead for intermittently
> > used
> > DSs
> > - Allows DS reuse if accessed again within grace period
> > - Configurable behavior via module parameters
> >=20
>=20
> Please read RFC8881 Section 12.2.10
> (https://datatracker.ietf.org/doc/html/rfc8881#device_ids)
>=20
> Specifically, the following paragraph, which disallows what you are
> proposing:
>=20
> Device ID to device address mappings are not leased, and can be
> changed
> at any time. (Note that while device ID to device address mappings
> are
> likely to change after the metadata server restarts, the server is
> not
> required to change the mappings.) A server has two choices for
> changing
> mappings. It can recall all layouts referring to the device ID or it
> can use a notification mechanism.
>=20

Note that you could circumvent the above restriction by adding a
revalidating step.
i.e. in order to figure out if the cached addresses and connections are
still valid and preferred, call GETDEVICEINFO after receiving the first
LAYOUTGET to re-reference the cached device id.

However given that we usually keep layouts around until the delegation
is returned (assuming the server handed us one), we should be caching
these connections for a minute or so already.

--=20
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trondmy@kernel.org, trond.myklebust@hammerspace.com

