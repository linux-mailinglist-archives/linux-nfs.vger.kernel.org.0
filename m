Return-Path: <linux-nfs+bounces-13549-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C256EB20987
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Aug 2025 15:03:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E91B57A3E19
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Aug 2025 13:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A14819C560;
	Mon, 11 Aug 2025 13:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QjzbsPNf"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6025B3B29E;
	Mon, 11 Aug 2025 13:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754917397; cv=none; b=WSq6EQEg02RpxETVbsvj92c5I61LjS5TAcS9xDuElWSNiVmhizP27gvRPkIhSWrVPmztL3EWt2ys90pXoVIEYQhvyrJxjU5c5ikcJKVNIxWucJlhs0bmKlhM86rzO9HvuWC2ApTRCbHURelYXynCRAaBQI9XwssiTjzGjWGqMn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754917397; c=relaxed/simple;
	bh=nyWhbSykx6E52BnfjzxRnFJKTUek7padXw4kN3T5ym8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MJEWTseOudrCpUh9A46wMNizWghGIabd/he/oXnHqWY4I5PKy68jCxVJsQwaFjdKCoWQqCeKlSo6YGJi72NEndqz1i/SdK1Sb9vm4u2oxQD9oXQJeH9HfOFuiPPgaMUBtMt0e3VG8kl+Jysjk9R6nV+HUJBQA7H7bNHQRkM14aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QjzbsPNf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 844EBC4CEED;
	Mon, 11 Aug 2025 13:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754917396;
	bh=nyWhbSykx6E52BnfjzxRnFJKTUek7padXw4kN3T5ym8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=QjzbsPNf1wio9uRRvLbpLgGktMQfnLj0TQy71UCADJ0JG6eT+XCRJRXR0OLMC1x7S
	 yy3wyzeRan7BLKu65C3kGdxdefFhElEuUNY04nE+UqtC1FOWd/1uv/BLo4OT9m9xMn
	 kJ+tp0aaaOwzXiSFBE92uSfcxilU0ceTZwSi2wH57eqDBVBkAQ+qO6E1NorpMWBPVq
	 RuUtPhsPUZOGMZ3B3iPCe4RK20XGFYFedhJJJaPnmAOfILKqIcYBD8M2D/z7yy6JOo
	 A454lgBIqSBRgv93taZ34mZAuNLTIwnGV3i6sVG7n2gjLxfhlDg/05nzr87PYHWsYD
	 cW68dKFvRlL6Q==
Message-ID: <e539e0ed77438b4f4353a78451add2ab5e69ec38.camel@kernel.org>
Subject: Re: [Question]nfs: never returned delegation
From: Trond Myklebust <trondmy@kernel.org>
To: "zhangjian (CG)" <zhangjian496@huawei.com>, anna@kernel.org
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 11 Aug 2025 06:03:14 -0700
In-Reply-To: <ff8debe9-6877-4cf7-ba29-fc98eae0ffa0@huawei.com>
References: <ff8debe9-6877-4cf7-ba29-fc98eae0ffa0@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-08-11 at 20:48 +0800, zhangjian (CG) wrote:
> Recently, we meet a NFS problem in 5.10. There are so many
> test_state_id request after a non-privilaged request in tcpdump
> result. There are 40w+ delegations in client (I read the delegation
> list from /proc/kcore).
> Firstly, I think state manager cost a lot in
> nfs_server_reap_expired_delegations. But I see they are all in
> NFS_DELEGATION_REVOKED state except 6 in NFS_DELEGATION_REFERENCED (I
> read this from /proc/kcore too).=20
> I analyze NFS code and find if NFSPROC4_CLNT_DELEGRETURN procedure
> meet ETIMEOUT, delegation will be marked as NFS4ERR_DELEG_REVOKED and
> never return it again. NFS server will keep the revoked delegation in
> clp->cl_revoked forever. This will result in following sequence
> response with RECALLABLE_STATE_REVOKED flag. Client will send
> test_state_id request for all non-revoked delegation.
> This can only be solved by restarting NFS server.
> I think ETIMEOUT in NFSPROC4_CLNT_DELEGRETURN procedure may be not
> the only case that cause lots of non-terminable test_state_id
> requests after any non-privilaged request.=20
> Wish NFS experts give some advices on this problem.
>=20

You have the following options:

   1. Don't ever use "soft" or "softerr" on the NFS client.
   2. Reboot your server every now and again.
   3. Change the server code to not bother caching revoked state. Doing
      so is rather pointless, since there is nothing a client can do
      differently when presented with NFS4ERR_DELEG_REVOKED vs.
      NFS4ERR_BAD_STATEID.
   4. Change the server code to garbage collect revoked stateids after
      a while.


--=20
Trond Myklebust Linux NFS client maintainer, Hammerspace
trondmy@kernel.org, trond.myklebust@hammerspace.com

