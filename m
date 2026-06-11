Return-Path: <linux-nfs+bounces-22470-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mcJIN4L1Kmoi0AMAu9opvQ
	(envelope-from <linux-nfs+bounces-22470-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jun 2026 19:50:58 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 33BF3674274
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jun 2026 19:50:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=S03Xpldw;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22470-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22470-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B8A653368A3A
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jun 2026 17:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3AE24C8FE9;
	Thu, 11 Jun 2026 17:24:10 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D42A4219E1;
	Thu, 11 Jun 2026 17:24:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781198650; cv=none; b=sesZngAahEDCE2+bpIYC2tLionzKuIhPFR661VN7lWATXLy9uFMObD0O6+jSu7rgs/0iyzAlNB/WeaXU9ae6KCePG/GNO5hjVgQ9/vVL3jfJg9IvjTx+VR/8hnZTrYbuuvFr1m2is7c4Dr9nfEblOp2ff2+TaZIUHeUbsOvym10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781198650; c=relaxed/simple;
	bh=piaaKJ/hx+40f4O7jhQDr8pEzzodfkw3Uu+WlcOm9Yc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KmihXaRD6lujE0rVD4HcG+CgW8KTkgd6TmPM9VZv6sBRLrbKgXWXrBf2TzdwNhtQYxHn7eiQlTMLuM0G5n11xLF8Yx9HeraIoCNtYEBUK4l5fS4pxVhO4V3/fYbVGnZF4z1ZZNOdVxZL/bAOHhFjKFwtAfDScFRVQt08RMUOwkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S03Xpldw; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15E361F00893;
	Thu, 11 Jun 2026 17:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781198645;
	bh=gEfxsh3xWZYNfWNWgQTPKfHWm6DxMxvsiqDRysD0iho=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=S03XpldwSuN0vrVz8rpq25ih2ffC7/UllRXXT6GZyseV94UjGqQ+0gVGm2xxGMOM3
	 p3AfJ3FxEQ9TWvJHNpR1vwXO0iIkSbzxy6eRXQ2O2tiqnHxtq2ILqTBx5/bCVNwFKU
	 zw4IFt+KRct0NEHu8lK4cJtlICoP3dkf5lwfLZhPOwq0lIzKDr+aWekRAugxsoO7ti
	 8vYoUpMUgOQViB4kZAA2D8uhwGgBYKjo+KD1RdQk1FlAjMS7vkhV1CY5JblWaT4lkA
	 89Krh1E6PgV4/vcgFTIzMc9xX5y1oi1CTtI8IjxVAvWiO69ZfNxkbVZ1CcoDegCqhl
	 rNk67/QJKRLaQ==
Message-ID: <7ae31abd06022e7e348e2d7e194cf292b6471309.camel@kernel.org>
Subject: Re: [PATCH] nfs: fix refcount leak in
 nfs_direct_read_schedule_iovec()
From: Trond Myklebust <trondmy@kernel.org>
To: WenTao Liang <vulab@iscas.ac.cn>, anna@kernel.org
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Date: Thu, 11 Jun 2026 13:24:04 -0400
In-Reply-To: <20260611145956.90270-1-vulab@iscas.ac.cn>
References: <20260611145956.90270-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:vulab@iscas.ac.cn,m:anna@kernel.org,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[trondmy@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-22470-lists,linux-nfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[trondmy@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,hammerspace.com:email,iscas.ac.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 33BF3674274

On Thu, 2026-06-11 at 22:59 +0800, WenTao Liang wrote:
> When nfs_direct_read_schedule_iovec() encounters an error after
> get_dreq(dreq) increments the io_count but fails to start any I/O
> (requested_bytes =3D=3D 0), it falls through to the error path. That
> path calls nfs_direct_req_release() to drop the I/O path=E2=80=99s kref,
> but it never calls put_dreq() to balance the io_count. This leaves
> the request=E2=80=99s io_count permanently elevated, a reference counting
> violation that corrupts the teardown logic once the object is
> freed via the remaining kref.

Exactly how is this corruption supposed to happen? I'm not seeing
anything that cares about the value of io_count either in
nfs_file_direct_read or in nfs_direct_req_free.

>=20
> Fix the leak by calling put_dreq(dreq) before
> nfs_direct_req_release() in the zero-bytes error path, so the
> io_count is properly balanced.
>=20
> Cc: stable@vger.kernel.org
> Fixes: 65caafd0d214 ("SUNRPC reverting d03727b248d0 ("NFSv4 fix CLOSE
> not waiting for direct IO compeletion")")
> Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
> ---
> =C2=A0fs/nfs/direct.c | 1 +
> =C2=A01 file changed, 1 insertion(+)
>=20
> diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
> index 48d89716193a..41a6cabb0592 100644
> --- a/fs/nfs/direct.c
> +++ b/fs/nfs/direct.c
> @@ -400,6 +400,7 @@ static ssize_t
> nfs_direct_read_schedule_iovec(struct nfs_direct_req *dreq,
> =C2=A0	 */
> =C2=A0	if (requested_bytes =3D=3D 0) {
> =C2=A0		inode_dio_end(inode);
> +		put_dreq(dreq);
> =C2=A0		nfs_direct_req_release(dreq);
> =C2=A0		return result < 0 ? result : -EIO;
> =C2=A0	}

--=20
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trondmy@kernel.org, trond.myklebust@hammerspace.com

