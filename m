Return-Path: <linux-nfs+bounces-16572-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 25D61C70A4B
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Nov 2025 19:29:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3FF6B34B686
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Nov 2025 18:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87C6425EFBE;
	Wed, 19 Nov 2025 18:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o0hVnMhp"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A60288C34
	for <linux-nfs@vger.kernel.org>; Wed, 19 Nov 2025 18:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763576672; cv=none; b=TqHUF6xFaNzsL1fnuQ8rlfIjLnqLKfJkpRX66wfrSYYoz64IIkfOUoWb0Vf/RbH7eg/aC7ymiPyPjxGzfu78dLJ+vVmJDm/FzSwJKg9kgqltuioBp3vAyMSPSYnY7QA971f8iSePReXB6uyMyLVPMzPLHvE9nrk6qdAXV+UJJ1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763576672; c=relaxed/simple;
	bh=/+/BtcFT/YcCq4fkuNftQ7uqBuyrzC/gmC5W0l0EdBU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=D1QknoIY6c23fADAoCdEN405C9Q4f9ImLATYpumsJ3rsUUkNxKV5WsM2kkDc2mXMwBHacAERIaeGGI7I5zjxUJKqJoFkTL1XiwBPPM099illi5xLji9RU8Uj5qE0f9UM2huHaNs+ofuoQY+aOY4IXWVvfyTv2VguuEDeaxS6PdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o0hVnMhp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78870C4CEF5;
	Wed, 19 Nov 2025 18:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763576671;
	bh=/+/BtcFT/YcCq4fkuNftQ7uqBuyrzC/gmC5W0l0EdBU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=o0hVnMhp1mnwmGU7hDDfUVWgt2GWoV/fJ9AeIdxBEJxf0EcR/5rBN6l6KveM8a/Z0
	 y9jVo6sAPcJtcygYNXH/ms3K7jcjC6UWS7bajiRnD8li9G4Wi/BB8SbEjmZM2JJQNt
	 qL76lg8m/KjGW0AtfYIHwvFkWrnhatD4qYvwynhzG24H1ImJs5KQyS3pPm9OMdK0n7
	 S8ja0r9q2oRa9k410bQFyjivwR9zzaLvsuYKhyFQ48/H5Vp5sJ1b+VAxDEqaq8gdXb
	 bKVO4Ja/YiX58dNp8e4uKaylfEK4EgoDG2JmB17MELF5s5F1zmooHe7psKDz5ysLYz
	 ksy58tj3nhHcw==
Message-ID: <08ce85ac96d63f4ac9dd94bf444095359ffe4dbd.camel@kernel.org>
Subject: Re: [PATCH] nfs: Implement delayed data server destruction with
 hold cache
From: Trond Myklebust <trondmy@kernel.org>
To: gaurav gangalwar <gaurav.gangalwar@gmail.com>
Cc: anna@kernel.org, tom@talpey.com, chuck.lever@oracle.com, 
	linux-nfs@vger.kernel.org
Date: Wed, 19 Nov 2025 13:24:29 -0500
In-Reply-To: <CAJiE4O=62Yxeo=24p9k3H_dC6Z7LuVwLFo8ca98yJTvsSTMfhQ@mail.gmail.com>
References: <20251118105752.52098-1-gaurav.gangalwar@gmail.com>
	 <fe6b3cb2fde809977394c5f605b844de043189ed.camel@kernel.org>
	 <1fd78dbccac873a277e71e55409acc5d1d3e6886.camel@kernel.org>
	 <CAJiE4O=62Yxeo=24p9k3H_dC6Z7LuVwLFo8ca98yJTvsSTMfhQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-11-19 at 22:04 +0530, gaurav gangalwar wrote:
> Thanks Trond for review comments, reply inline.
>=20
> On Tue, Nov 18, 2025 at 9:46=E2=80=AFPM Trond Myklebust <trondmy@kernel.o=
rg>
> wrote:
> >=20
> > On Tue, 2025-11-18 at 09:43 -0500, Trond Myklebust wrote:
> > > On Tue, 2025-11-18 at 05:57 -0500, Gaurav Gangalwar wrote:
> > > > Introduce a hold cache mechanism for NFS pNFS data servers to
> > > > avoid
> > > > unnecessary connection churn when data servers are temporarily
> > > > idle.
> > > >=20
> > > > Key changes:
> > > >=20
> > > > 1. Hold Cache Implementation:
> > > > =C2=A0=C2=A0 - Add nfs4_data_server_hold_cache to namespace structu=
re
> > > > =C2=A0=C2=A0 - Move data servers to hold cache when refcount reache=
s zero
> > > > =C2=A0=C2=A0 - Always update ds_last_access timestamp on every refe=
rence
> > > >=20
> > > > 2. Configurable Module Parameters:
> > > > =C2=A0=C2=A0 - nfs4_pnfs_ds_grace_period: Grace period before destr=
oying
> > > > idle
> > > > =C2=A0=C2=A0=C2=A0=C2=A0 data servers (default: 300 seconds)
> > > > =C2=A0=C2=A0 - nfs4_pnfs_ds_cleanup_interval: Interval for periodic
> > > > cleanup
> > > > =C2=A0=C2=A0=C2=A0=C2=A0 work (default: 300 seconds)
> > > >=20
> > > > 3. Periodic Cleanup Work:
> > > > =C2=A0=C2=A0 - Schedule delayed work on first DS usage (lazy
> > > > initialization)
> > > > =C2=A0=C2=A0 - Check hold cache and destroy data servers that excee=
d
> > > > grace
> > > > period
> > > > =C2=A0=C2=A0 - Reschedule work automatically for continuous monitor=
ing
> > > >=20
> > > > 4. Callback Mechanism:
> > > > =C2=A0=C2=A0 - Use function pointer callback to avoid circular modu=
le
> > > > dependencies
> > > > =C2=A0=C2=A0 - nfsv4.ko registers cleanup callback during initializ=
ation
> > > > =C2=A0=C2=A0 - nfs.ko calls callback during namespace cleanup (if
> > > > registered)
> > > >=20
> > > > 5. Timestamp Tracking:
> > > > =C2=A0=C2=A0 - Add ds_last_access field to nfs4_pnfs_ds structure
> > > > =C2=A0=C2=A0 - Update timestamp on DS allocation, lookup, and refer=
ence
> > > >=20
> > > > Benefits:
> > > > - Reduces connection setup/teardown overhead for intermittently
> > > > used
> > > > DSs
> > > > - Allows DS reuse if accessed again within grace period
> > > > - Configurable behavior via module parameters
> > > >=20
> > >=20
> > > Please read RFC8881 Section 12.2.10
> > > (https://datatracker.ietf.org/doc/html/rfc8881#device_ids)
> > >=20
> > > Specifically, the following paragraph, which disallows what you
> > > are
> > > proposing:
> > >=20
> > > Device ID to device address mappings are not leased, and can be
> > > changed
> > > at any time. (Note that while device ID to device address
> > > mappings
> > > are
> > > likely to change after the metadata server restarts, the server
> > > is
> > > not
> > > required to change the mappings.) A server has two choices for
> > > changing
> > > mappings. It can recall all layouts referring to the device ID or
> > > it
> > > can use a notification mechanism.
> > >=20
> nfs4_data_server_cache is per network namespace and cache ds_addrs ->
> nfs_client, so it should be independent of device id.

OK, but that dissociates the address cache from the deviceid cache, and
means that when we finally get round to implementing deviceid
notifications, then we'll have to manage 2 levels of caching. That's
not desirable either.

If you really need this extra caching of connections, then is there any
reason why you can't just implement it with deviceid notifications?

> I am trying to understand how a change in Device ID to device address
> mapping can make difference to nfs4_data_server_cache,
> since this cache lookup is done using ds address. As long as the
> address and connections are valid it should be fine.
> One scenario I can think of for address is valid but connection is
> not
> could be an ip address move, but in that case connection should reset
> and nfs client should reconnect.

Are you asking under what circumstances a notification might want to be
sent?
The following come to mind: rebalancing client load across multiple IP
addresses, managing RDMA vs plain TCP connections, network
failover/failback to a different IP and/or subnet, or just letting the
client know about temporary outages of some addresses. In some cases,
it could even just be that the data server is being decommissioned, and
so the deviceids are being deleted permanently.

The point is that notifications allow you to do caching of connections
indefinitely if you want to.

One thing to note though, is that since hyperscalers have been known to
set up environments where the number of data servers reaches the 1000s,
you will at the very least want to limit the maximum size of the cache.

> >=20
> > Note that you could circumvent the above restriction by adding a
> > revalidating step.
> > i.e. in order to figure out if the cached addresses and connections
> > are
> > still valid and preferred, call GETDEVICEINFO after receiving the
> > first
> > LAYOUTGET to re-reference the cached device id.
> Didn't get this, GETDEVICEINFO should be already happening after
> LAYOUTGET, so if there is change in device info it will get it.
> >=20
> > However given that we usually keep layouts around until the
> > delegation
> > is returned (assuming the server handed us one), we should be
> > caching
> > these connections for a minute or so already.
>=20
> We have enabled only read delegations, so this is unlikely to help.

Sure, but that's something you can fix on the server. The client
support is already fully implemented.

--=20
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trondmy@kernel.org, trond.myklebust@hammerspace.com

