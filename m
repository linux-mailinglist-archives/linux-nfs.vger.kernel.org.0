Return-Path: <linux-nfs+bounces-20061-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2LN5Ew+7smmvPAAAu9opvQ
	(envelope-from <linux-nfs+bounces-20061-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Mar 2026 14:09:35 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EE6E2724C8
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Mar 2026 14:09:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 63EE13004637
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Mar 2026 13:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72ECE3C5533;
	Thu, 12 Mar 2026 13:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QuXu+KMY"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E808E3BE641;
	Thu, 12 Mar 2026 13:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773320968; cv=none; b=dsNaRjuqWD1kZtXsjq8rO/XbkMTm5kIoo4hA2vtc9pp67wQnX3vcQmSJ+Ct5sJnlxHIyVGTqcIrdWRIz+BJrH7LUC8l56Ijv7RCbHAknVmHztoEzs6D0mtlAeK4G03v++bn9vFt9X3YzFgKKor6bVxp588bB1dUpGlw7LZ7YAKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773320968; c=relaxed/simple;
	bh=Yz3OL1KpyG2yKr6gkMaSuXdDFnsxy/KItTSgPiff9iE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=chh2BIMzvxYHeXxsaFc7NWcAGgh08f5u6RFga3zwXSPN9CWIkvZwmhCmOlIx7WMpIz2sciQd8bTziUHsUXdsIa4xpvg5NZAib48t5GZRMPO4YwrbEFsx6fiNeyb4lcLX+aLzIF77ypbhI0JrNF4JKitJ4BF/yM3z5BAgkEiOYb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QuXu+KMY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 118D6C4CEF7;
	Thu, 12 Mar 2026 13:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773320967;
	bh=Yz3OL1KpyG2yKr6gkMaSuXdDFnsxy/KItTSgPiff9iE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=QuXu+KMYo0Dz81SKmHU0iceDsh3gobD4WKjLriMKyMQ68Jk5UQbLsk1trb0JJ72Vx
	 sGeCMF5O9WsydacKEbPe+HuX5kDaa1LYi7t1XEit7mRXTnVbHmTEB/E4S5XRtzMjLU
	 XCh4ezUNG/5VcwnrPaAAQPk8oCmEb/NzCpXBgdWKVlpf/NrG9OLDnx7FyYjt1QnkhB
	 gJDYUTTWPKS+APcCu0qy2ZZrdO/Y8jxEq0oSKFtu9q1zygutoONyllAbSaaca/1/tL
	 0p9ntMOxBD/zbzjkmv02mIEEP3OmElYV6d+qH0kKCOze098Ue2l/Zc3Sf2aIPThUlV
	 /Kq9jhjUUIcpg==
Message-ID: <c42bc9a8ccb53e4afbb74734a9705459c45d7909.camel@kernel.org>
Subject: Re: [Question]nfs: should nfs timeout even with
 NFS_CS_NO_RETRANS_TIMEOUT ?
From: Trond Myklebust <trondmy@kernel.org>
To: "zhangjian (CG)" <zhangjian496@huawei.com>, anna@kernel.org, Jeff Layton
	 <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 12 Mar 2026 09:09:26 -0400
In-Reply-To: <77b2c3ea-52d0-4f2f-8cca-4481f3426fc5@huawei.com>
References: <ff8debe9-6877-4cf7-ba29-fc98eae0ffa0@huawei.com>
	 <850dcbf562b7eb5848278937092d2d8511eb648f.camel@kernel.org>
	 <1e1eadf5-fab9-4919-a71a-864aa7109c7b@huawei.com>
	 <23b52d16-4b74-43e4-9fff-73ac57c9ef89@huawei.com>
	 <80c9ba69f1d35928ea9d21e146e60f194cff7405.camel@kernel.org>
	 <77b2c3ea-52d0-4f2f-8cca-4481f3426fc5@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	SUBJECT_ENDS_QUESTION(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20061-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[trondmy@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,hammerspace.com:email]
X-Rspamd-Queue-Id: 4EE6E2724C8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 2026-03-12 at 12:19 +0800, zhangjian (CG) wrote:
>=20
>=20
> On 3/6/2026 12:49 PM, Trond Myklebust wrote:
> > On Fri, 2026-03-06 at 10:46 +0800, zhangjian (CG) wrote:
> > > Hi experts on NFS:
> > >=20
> > > Recently we meet an error:
> > > 1.Nfs wait for sunrpc
> > > 2.Sunrpc send OPEN message and hang the rpc task onto sunrpc
> > > pending
> > > queue.
> > > 3.Server never reply, and since NFS_CS_NO_RETRANS_TIMEOUT is
> > > forced
> > > and
> > > connection is ESTABLISHED, task will never be retransmitted.
> > > This cause procedures waiting on this file hang forever.
> > > I know using "umount -f " to kill rpc task works. And the key to
> > > the
> > > problem most likely lies in the network layer. But should nfs
> > > retransmit
> > > it after waiting for so long?
> > >=20
> > > Wish for reply. Thanks
> > >=20
> > > Zhangjian
> > >=20
> > Please read the NFSv4 spec. It very clearly states that the client
> > should never retransmit unless the connection breaks.
> >=20
>=20
> NFSv4 spec said client should never retransmit, but not said client
> need
> to wait forever. Maybe sunrpc should tell nfs -ETIMEOUT and nfs
> return
> ERROR rather than retransmit.

You are 100% free to use the existing 'soft' or 'softerr' mount options
if you have applications that can parse those (non-POSIX) errors.
Note however that there is no way to tell the server that you are
'cancelling' an RPC call, so it will hold onto that slot until it is
done executing the call (see RFC8881, Section 2.10.6.1.). So you are
eventually going to run out of usable slots, and the system will gum up
anyway.

The default mount option is 'hard', because those are the only
semantics that are compatible with POSIX and NFSv4.x.

--=20
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trondmy@kernel.org, trond.myklebust@hammerspace.com

