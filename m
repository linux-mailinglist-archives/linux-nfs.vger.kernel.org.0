Return-Path: <linux-nfs+bounces-22094-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KGVAMmEfGmqx1ggAu9opvQ
	(envelope-from <linux-nfs+bounces-22094-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 30 May 2026 01:21:05 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 65C35609B16
	for <lists+linux-nfs@lfdr.de>; Sat, 30 May 2026 01:21:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8131C3059A66
	for <lists+linux-nfs@lfdr.de>; Fri, 29 May 2026 23:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0D413A960E;
	Fri, 29 May 2026 23:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q7p46jZj"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85ACE39FCBC
	for <linux-nfs@vger.kernel.org>; Fri, 29 May 2026 23:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780096844; cv=pass; b=E3SKMJfmtyzde47lRJdzc6m8WzryVU16NrFl8ouIcOCJofsqCpTi4CqliQH7lhr5bWJrbCMiesjtf08G3a8LXAH8BE9kw0lKrUWkrIhB3oZz8omQDWibvOI1KWJwkDxARVROZls30GZpFC0fP8hcVIjBXAYOYj1fN0FwygoGT7Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780096844; c=relaxed/simple;
	bh=YjIDv3oUmukGAaN6mkwwdBmyFlUxKktyeguSPzzDcBI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z8fGIqSNVmR2OE+wX29VNa4IAjp/wJpFMDRcgujXinLSl7rht4vcXn9c9rRvHGFpdqdnZnhLmts+fIhN3qcoHO9ogkKl/I49ORAeOlETjZj9xFgA30V2KXtnxDcvE487/OqCqavZBthXThhQteHimZ+1wOw5EIGXDlEqy3ou87g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q7p46jZj; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6870ad8072eso9876414a12.0
        for <linux-nfs@vger.kernel.org>; Fri, 29 May 2026 16:20:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780096842; cv=none;
        d=google.com; s=arc-20240605;
        b=Zk0dMVAJA1UdIHt5X8t/te2PtyDRX/l3nV8MgcO9E+gkmZWYCrkSWXaXs2MnYK0iEu
         eIiXSthR6AEqRmUicCeY8YGcYLBZKIp6wS69aVi2fsNGEPsB0BhbA39JOv1LN8ijirze
         8ZdYfeAXP8X1YsB/8q6oYNvhBfDDBw1+/J+8Ow9UsA7amLIn2s33YgBIObdJBRCyC8dX
         7T0r8xzLSHktJPNUZVVVhATSrwkn4IS3wA3hSmHb+U6SHn54hoN5m8X5GYJgUEXG7apQ
         thDoVdgodGl2W6IjVbWUsTv+3HcHzK5lpanxh3RuWxKE+Qetzeyc/fQCtPViuqKdNCiU
         6Vdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=L+jY/uZOD20Pz5i330VjYbUshBovXNA/fEHqDZqrc7M=;
        fh=G+6MKh+mYroKZsaQjUybKwTURxN4Jkwq7imavXLTUOk=;
        b=WXt/a1JG9hqNr7XMWSfLye7G2Ux7Uhs5jMMZ8WljeOr2ul85tDu8EHC1+MWFjAOXag
         4gHKwcew7EhbrXoNui134RZST3b3pr8ASvYHJNyll08wxvhlLXTw/PHUg65uRf1H5yIB
         5Hyk3h0sssA4XXzAM6nlS/sJyIEqvW/i2zkj17BYQVrHXWQaSYOTeRCNzkwozob3Vpb7
         eP9ZgIJ3uFHuHzPw3Vx82GBL9UKhVx/jwcnttTk+Tys7AfRb7Sw3jVvE8zHlWRKu/cSY
         6X/Vm+7bC9oIdDKlbhmuRTfAJhNFmxtnpUhmTO/ida9rer5TGQ8r1sHTMF4Lt+Z/nE6p
         SCYQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780096842; x=1780701642; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L+jY/uZOD20Pz5i330VjYbUshBovXNA/fEHqDZqrc7M=;
        b=Q7p46jZj3K/YcyTACCdxtRWxDRJyoVYMO2Ns/rlwuhm2OASviyoF7Bh72ic7WOu5mO
         f0EhDVgp8+NUxx/jWW49sWtPtlVzMjf6vmHEXtwaYwL1eGtCle7TXiCH93UwSAxGTeYJ
         rn6f6t0P7JNmqhXzG0KAJffKvEV2cl/fi3u+V0sgOGiSkP5/jQ5fU8beXLTA+uuPz/eu
         rNn1nsvNL3UTXuu8or1M/h5pH715nQcUjjddKRABv76ascVk6yv60i9QMdJA2KgR4yrH
         YXEL0CGWKRicjZ+m2pPTMYIloqzdE1e2Q1uo0NJV9dCgbcdh+tNWWnfIuVivptY6TJ3l
         oHIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780096842; x=1780701642;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=L+jY/uZOD20Pz5i330VjYbUshBovXNA/fEHqDZqrc7M=;
        b=dbRTDxQIWJMMHMwUltT/8MmB77R/j919nW30QK1arwQxVoaP4My21MGdPai9aPYoBP
         kef4T5nMSrOye++7cJSTM2l8bkLfUw/WKpIribAPJ5OtOuiB09QDEvgJs5bvX2+d90NM
         4AqshT8rSNsK4YbNdSQ1SNKbKubAOoge38HAOsr1C2B1mTswQKS3g8urrx126YjVjD/m
         3MlohTzOfOeoULM7P3KhUyE/nQmH/jn2ajCTTCBnLzkEGCKvc7OuH2ln/LGfE20fi/aZ
         SpzwfXsuoskYDhe8alwkYSD6VqImRWj3C4AMdGAIgP0Hwm/w1kbSOzUFJh+4D3j9CBBH
         On0w==
X-Forwarded-Encrypted: i=1; AFNElJ+JD3w5278gjWqghcgR1JKEDXkNx2JaPY4flEiwwtX/7qOgcZDGQxfa0ktdLQjfZDBLRd1VeRCXXU0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnGvwFatnRPpZKhtOaJvlFp34KcCLLaj676h1Xb84NMtm73/1Z
	/SlLgGN7dqN/SBvHJszWOfmbxz675/r6nuTcTiBIfVHkndvXeYLVtXzroKiVGtXIMlavq2s0g0d
	D9Y0tNxW1IHrwd46E9jwZQRiS2Tr4yA==
X-Gm-Gg: Acq92OEwD8MaBf/+XZIljODiwgEthEB48oX29AX4QFGGsOF25Wbe0j2uezRiQIYEVxq
	FNMqp2Y1Ril2yJ342d7pMPmWlnGUNeqKIQxQRoNqewxETnMfsHT29iJeNxVd2CMcDDsRMC7c05F
	uGwBuver5vhYwyNq6s/MtiuW+aAeB8pXuGS/v0aiF/2k7sN4/vArWRJ9Nlk2JCqD6ObVvNYx2AE
	Yl5NG84doZ8+omLgSCSIh7j0ZK6JubzJ6lkJAFGWY/SH7QHIJdgI81qlkYJc4hi5PdnbzKYpSaw
	eSpQbBl7Gs/obDEsCun3hIr0B/7j4M7Drxwkj45aPWS9EinadO/3Rv5YhXuA
X-Received: by 2002:a05:6402:5106:b0:66f:76c8:f747 with SMTP id
 4fb4d7f45d1cf-68c9313fd46mr670592a12.6.1780096841732; Fri, 29 May 2026
 16:20:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1779995818.git.bcodding@hammerspace.com>
 <64a9c99c387432399b4c4d9ce6dd4836b0170c15.1779995818.git.bcodding@hammerspace.com>
 <461703b49f85216f6f6b18656e290287b0f701a0.camel@kernel.org> <32A38159-77F7-41CC-9567-2089531D05F1@hammerspace.com>
In-Reply-To: <32A38159-77F7-41CC-9567-2089531D05F1@hammerspace.com>
From: Rick Macklem <rick.macklem@gmail.com>
Date: Fri, 29 May 2026 16:20:29 -0700
X-Gm-Features: AVHnY4L9g5F8alYq33fkNXhybofyiZ_JVk0WF_fCfKezhs1MpetA3dW4Yg9UjXs
Message-ID: <CAM5tNy5apeovZgH-Uci4ESEHzAP4A9ATMp0djR2Ttr-HM1peSA@mail.gmail.com>
Subject: Re: [PATCH 1/1] nfs: return a write delegation when a SETATTR drops
 our write access
To: Benjamin Coddington <ben.coddington@hammerspace.com>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22094-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rickmacklem@gmail.com,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Queue-Id: 65C35609B16
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 29, 2026 at 9:22=E2=80=AFAM Benjamin Coddington
<ben.coddington@hammerspace.com> wrote:
>
> On 29 May 2026, at 10:00, Trond Myklebust wrote:
> >
> > Hmmm... I'd argue that while recalling the delegation in this case is
> > mandatory for NFSv4.0, that is certainly not true for NFSv4.1.
> >
> > Furthermore, I'd argue that if the holder of a write delegation is just
> > changing the mode, then that should never result in a delegation recall
> > for a well written NFSv4.1 server. The reason is this does not impact
> > the client's ability to cache data, metadata or lock state. It only
> > impacts its ability to rely on previously cached access data when
> > handling new opens.
> >
> > One can argue whether or not it's needed for a uid or gid change by
> > said holder of the delegation, but there too I'd say the right
> > behaviour is to err on the side of not recalling.
> > The exception might be if this is an attribute delegation, and the
> > result will be that the cred attached to the delegation will no longer
> > be able to issue a SETATTR to update the atime/mtime on delegation
> > return.
> >
> > So yes to pre-emptive invalidation of the access cache, but I'm very
> > sceptical to actually pre-emptively returning the delegation or even
> > the layouts.
>
> The latency I was chasing comes from the server electing to recall on the=
se
> SETATTRs.
>
> You're right that for v4.1 the mode change doesn't need to trigger a reca=
ll,
> and that the only client-side exposure is stale cached access on subseque=
nt
> opens.  It's already covered in the SETATTR reply path changing mode/uid/=
gid
> where it sets NFS_INO_INVALID_ACCESS in nfs_update_inode(), and a fresh o=
pen
> over the delegation still goes through nfs_may_open() -> nfs_do_access(),=
 so
> it revalidates with the server rather than trusting the cached result.
>
> The server isn't recalling these for cache coherence.  When the change
> removes the holder's write, a later SETATTR(size) under the delegation
> carries the delegation stateid, not an open stateid
> (nfs4_copy_delegation_stateid()), and the client can reopen O_WRONLY from
> the delegation with no OPEN on the wire =E2=80=94 so the server can't tel=
l whether
> the holder still has the file open for write, nor apply the usual
> "open-for-write overrides current mode" check for the truncate. The recal=
l
> forces a DELEGRETURN + CLAIM_DELEGATE_CUR reclaim that re-establishes a r=
eal
> (or absent) open stateid, letting the server decide the truncate correctl=
y.

I will note that, since your server allows WRITEs based on the
delegation stateid,
it could allow SETATTR(size) based on a delegation stateid as well.
(SETATTR(size)
is just a weird variant of WRITE. is it not.) Now, how to implement
this in the server
would be up to you guys.

I suppose the disadvantage of doing the DELEGRETURN pre-emptively will neve=
r
allow server implementations to figure out how to allow it without a
CB_RECALL, etc.

I do plan on patching the FreeBSD server to allow READ, WRITE and SETATTR(s=
ize)
based on a write delegation stateid (and READ based on a read
delegation stateid).
Of course it will take a while for that to find its way into the
world. The FreeBSD
server will be doing the CB_RECALL in the meantime.

Useful discussion. Thanks, rick

>
> For write-retaining SETATTRs none of that applies and the server shouldn'=
t
> recall =E2=80=94 which is where the latency I was chasing actually came f=
rom, and
> the better place to remove it.
>
> Thanks for the review.
>
> Ben
>

