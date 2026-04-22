Return-Path: <linux-nfs+bounces-20996-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uFQMN+/C6Gm9PwIAu9opvQ
	(envelope-from <linux-nfs+bounces-20996-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Apr 2026 14:45:35 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 679D1446212
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Apr 2026 14:45:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CA0BB30F80C5
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Apr 2026 12:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBE843DE457;
	Wed, 22 Apr 2026 12:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="izm2m4DF"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3423DEADB;
	Wed, 22 Apr 2026 12:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776861508; cv=none; b=JmN0w9RmzWIqMmo28x1Tx9YKRAKK5v4bY6K5BGcQLJyWDmC7tqpyPghiBgwFZ7TJ+f0sH08dQuMbTY3f4nd97NO06fyMzsq0hPmQr01UTVth/Bx84bnhk0UJ4NRg20HEJGwCSd0r9QhFTbW8kxLstSvP8m5TKfjO3ciSgU13pmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776861508; c=relaxed/simple;
	bh=tRdYiJWoTHml6OILjpf0x5BPl1SO91GGLgBJGTe7NjA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lNnCN+oPvkXeK6YBBb6TxXxB9xcjHE9ATjwjd4GQOGzidtk8+8Q4jPGalETKeXNYhQMjkSqmqSvB0dzU/V6vu7/0u0yboRz/YCW5Vmr4sf9f0ch8F9+7vR2mrs87FsVNuaYIZ+4iYKXxPNkW/urtqwpskOS1oc4vyKm/HR9ORxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=izm2m4DF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81277C19425;
	Wed, 22 Apr 2026 12:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776861507;
	bh=tRdYiJWoTHml6OILjpf0x5BPl1SO91GGLgBJGTe7NjA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=izm2m4DF52xYyT/rhV1wIM/V6iTszKZv+KXpVyHkuhGzuxFgyzlwZrEzDM5bFvURp
	 2nrRYHMIjZzTceGjR3TTvkVkbf9hPVGN7BCtTPbeKOBz4b1hyo92RNqk4rovA0ROdS
	 U341DuuZ/9PFetXYj9L8cDLDcVdwkTgwhj416DXPy4sBhnb21xgSYv1nwJLZ2qVmxT
	 jSaSSp7blOY7jKeH0Hjx4AtV2LgaLwHWnh/hXbxU3YHqpUHdeL5kSlZh5Kzt1XPqFw
	 R6sOOl5EeEBG6kUMTAUukrsmjs9kaBFNfHOCF8T7tbSXXRJf7rgDeq2klwlKYtNDNH
	 dnRiLdnl+haDQ==
Message-ID: <ac3165e050f4fa9ca4dfd102f7ec1c5e554db693.camel@kernel.org>
Subject: Re: [PATCH] NFSv4: Fix state recovery deadlock when server misses
 grace period
From: Trond Myklebust <trondmy@kernel.org>
To: Zhihao Cheng <chengzhihao1@huawei.com>, anna@kernel.org
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	yangerkun@huawei.com, Li Lingfeng <lilingfeng3@huawei.com>
Date: Wed, 22 Apr 2026 08:38:25 -0400
In-Reply-To: <e8c5a503-e8b4-11ef-68fb-a0195ce07b07@huawei.com>
References: <20260422064447.358447-1-chengzhihao1@huawei.com>
	 <e8c5a503-e8b4-11ef-68fb-a0195ce07b07@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20996-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[trondmy@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huawei.com:email]
X-Rspamd-Queue-Id: 679D1446212
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 2026-04-22 at 14:55 +0800, Zhihao Cheng wrote:
> =E5=9C=A8 2026/4/22 14:44, Zhihao Cheng =E5=86=99=E9=81=93:
> Add lilingfeng3@huawei.com
> > NFS server restart causes client to enter an infinite loop during
> > state
> > recovery. The state manager gets stuck in NFS4CLNT_RECLAIM_NOGRACE
> > processing,
> > with the server repeatedly returning NFS4ERR_GRACE for each file
> > iteration.
> > This problem is reported in [1].
> >=20
> > Trigger sequence:
> > =C2=A0 1. Client opens 2 files. After server reboot, client enters
> > =C2=A0=C2=A0=C2=A0=C2=A0 nfs4_do_reclaim(RECLAIM_REBOOT). Server misses=
 grace period
> > and returns
> > =C2=A0=C2=A0=C2=A0=C2=A0 NFS4ERR_NO_GRACE, causing client to set
> > NFS4CLNT_RECLAIM_NOGRACE.
> > =C2=A0 2. Client enters nfs4_do_reclaim(RECLAIM_NOGRACE) to recover
> > first file.
> > =C2=A0=C2=A0=C2=A0=C2=A0 Server reboots again, open request returns NFS=
4ERR_BADSESSION,
> > client
> > =C2=A0=C2=A0=C2=A0=C2=A0 sets NFS4CLNT_SESSION_RESET.
> > =C2=A0 3. nfs4_reset_session calls nfs4_proc_create_session which fails
> > with
> > =C2=A0=C2=A0=C2=A0=C2=A0 ETIMEDOUT due to network=C2=B9=C3=8A=C3=95=C3=
=8F, nfs4_handle_reclaim_lease_error
> > sets
> > =C2=A0=C2=A0=C2=A0=C2=A0 NFS4CLNT_LEASE_EXPIRED but does NOT set
> > NFS4CLNT_RECLAIM_REBOOT.
> > =C2=A0 4. When nfs4_reclaim_lease runs, because NFS4CLNT_RECLAIM_NOGRAC=
E
> > is already
> > =C2=A0=C2=A0=C2=A0=C2=A0 set, it skips setting NFS4CLNT_RECLAIM_REBOOT =
(the bug,
> > modified by
> > =C2=A0=C2=A0=C2=A0=C2=A0 commit b42353ff8d346 ("NFSv4.1: Clean up
> > nfs4_reclaim_lease")).
> > =C2=A0 5. Server never receives RECLAIM_COMPLETE, so cl_flags lacks
> > =C2=A0=C2=A0=C2=A0=C2=A0 NFSD4_CLIENT_RECLAIM_COMPLETE. When processing=
 subsequent
> > files,
> > =C2=A0=C2=A0=C2=A0=C2=A0 server always returns nfserr_grace, causing in=
finite retry
> > loop.
> >=20
> > Fix it by setting NFS4CLNT_RECLAIM_REBOOT in nfs4_reclaim_lease if
> > NFS4CLNT_SERVER_SCOPE_MISMATCH is not set, so that the client sends
> > RECLAIM_COMPLETE to the server first, allowing subsequent nograce
> > recovery to proceed.
> >=20
> > Fetch a reproducer in [2].
> >=20
> > [1]
> > https://lore.kernel.org/linux-nfs/55da00d4-a656-4ed2-ae57-7f881297a1b2@=
huawei.com/
> > [2] https://bugzilla.kernel.org/show_bug.cgi?id=3D221399
> >=20
> > Fixes: b42353ff8d346 ("NFSv4.1: Clean up nfs4_reclaim_lease")
> > Cc: stable@vger.kernel.org
> > Reported-by: Li Lingfeng <lilingfeng3@huawei.com>
> > Closes:
> > https://lore.kernel.org/linux-nfs/55da00d4-a656-4ed2-ae57-7f881297a1b2@=
huawei.com/
> > Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
> > ---
> > =C2=A0 fs/nfs/nfs4state.c | 2 +-
> > =C2=A0 1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
> > index 305a772e5497..817327e73d88 100644
> > --- a/fs/nfs/nfs4state.c
> > +++ b/fs/nfs/nfs4state.c
> > @@ -2012,7 +2012,7 @@ static int nfs4_reclaim_lease(struct
> > nfs_client *clp)
> > =C2=A0=C2=A0		return nfs4_handle_reclaim_lease_error(clp,
> > status);
> > =C2=A0=C2=A0	if (test_and_clear_bit(NFS4CLNT_SERVER_SCOPE_MISMATCH,
> > &clp->cl_state))
> > =C2=A0=C2=A0		nfs4_state_start_reclaim_nograce(clp);
> > -	if (!test_bit(NFS4CLNT_RECLAIM_NOGRACE, &clp->cl_state))
> > +	else
> > =C2=A0=C2=A0		set_bit(NFS4CLNT_RECLAIM_REBOOT, &clp->cl_state);
> > =C2=A0=C2=A0	clear_bit(NFS4CLNT_CHECK_LEASE, &clp->cl_state);
> > =C2=A0=C2=A0	clear_bit(NFS4CLNT_LEASE_EXPIRED, &clp->cl_state);
> >=20
>=20
This will cause the client to try to do reboot recovery in a situation
where it isn't allowed to do so by the spec. We should never be setting
NFS4CLNT_RECLAIM_REBOOT if NFS4CLNT_RECLAIM_NOGRACE is already set.

One solution would be to just immediately call
nfs4_state_end_reclaim_reboot() if NFS4CLNT_RECLAIM_NOGRACE is set.

--=20
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trondmy@kernel.org, trond.myklebust@hammerspace.com

