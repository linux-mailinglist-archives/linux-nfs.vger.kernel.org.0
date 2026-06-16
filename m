Return-Path: <linux-nfs+bounces-22644-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id uc+tJqmhMWqqogUAu9opvQ
	(envelope-from <linux-nfs+bounces-22644-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jun 2026 21:19:05 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 77276694EDD
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jun 2026 21:19:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=poochiereds-net.20251104.gappssmtp.com header.s=20251104 header.b="IXCt78/o";
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22644-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22644-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AEF2830015B6
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jun 2026 19:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE8AC3655E8;
	Tue, 16 Jun 2026 19:18:59 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8160B344D88
	for <linux-nfs@vger.kernel.org>; Tue, 16 Jun 2026 19:18:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781637539; cv=none; b=j4k94FA/mXCTVRrnmX0U5+7OTQ2gLrCURdcWY/jEp9oaY3j9j5Zbvp3NOnUvzF0pvbVKsWLXWYKXF7nsr2xV+P+ll6odEJMKOACiKDBwqMS5DYR8wSZxGN5JO1xLdF5Nfo4/f4gzdRnNElMlvmZB0LwZewodGysiaEWVL/88yoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781637539; c=relaxed/simple;
	bh=H3VmOvvmu7qfvDZr1MIn1qc5gwlwyUY/bQSzFnx+GNE=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=B79EXikEYeO4M+n8YfDs/9BdMHPSLE5uSdLdRoR4/1Skz8wjEEVjDQYMxA0wXlVAj3as7vnq/7Y0MgBuktcpeL95xyuLcQ7jVBbpG+4HJokcEXC2OqdzDyjqnd/gmhdSZIbgjmoOLOeYwVj37rZlYV5W3w+fBjxj5DhHqydRsWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=poochiereds.net; spf=fail smtp.mailfrom=poochiereds.net; dkim=pass (2048-bit key) header.d=poochiereds-net.20251104.gappssmtp.com header.i=@poochiereds-net.20251104.gappssmtp.com header.b=IXCt78/o; arc=none smtp.client-ip=74.125.224.53
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-6626cd98209so5331424d50.3
        for <linux-nfs@vger.kernel.org>; Tue, 16 Jun 2026 12:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poochiereds-net.20251104.gappssmtp.com; s=20251104; t=1781637536; x=1782242336; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:to:from:subject:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9yVUEpmVrvl8KPtLZ2xEDYRBVHjy0p0ZAepk65+9P4E=;
        b=IXCt78/oYNQ9l8miMW3Iy1JWdXuYLI5qIFGF3qL3M2mfdGFn1c8zv5SFiaG3MAI5AB
         /A3+ulmwllB/OLvy31lUmhrkP1FHCwt09ic7ut5T7I2EfPWdQDNg0Ejmrniq9BSE0ZyM
         WoDJZOw3/By70GhkyyDcn/OIiDPC46qrSwRC86vz6JEwAfmy4aT5lYMCTePjckp3kgdF
         gpQ6ecqGeU6YM2zRg1Z9YqQDkq+atxyU/qFuYpDV/5Ljv5KIVz3dw7f0UTZk8oG975m3
         5i4RPkfT0kVhqRryLQn41wSkOB+LL/ojQow7kHejVXN6YzJ327JZyGAGhIGRgo1G1Fb/
         ENng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781637536; x=1782242336;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9yVUEpmVrvl8KPtLZ2xEDYRBVHjy0p0ZAepk65+9P4E=;
        b=oU7KPiAuOI+eOMnAJt4niTEpkB5cV33KKzAVlN4F7jS1imFdBD6OnX223NF4g53j5D
         G4mddulx8PdGGpSyzlB71VyJFgIR+YC0NRiQA9ItR5Srf6HW9Gp2T+yICyejNnO/bOkb
         epiDBcAOTrs/uSTroZEB5K5uZvVJt509G/tWQ2nDz76YBjxoDUFo5e/SM4YkTL/MtJsp
         9UOiCqOSguZz/pbUNrA/DAKd2+Ppss2F/xmMNkbe0ebPNut/6n3vmPumP9ku77RYE+Ud
         VQBjlLA8hgd3gO43rtTIGdmN7quaKl7U2bn+Si03RGsS4GNvtUE5H/8sKuAiLkd8S2F2
         Lz3w==
X-Forwarded-Encrypted: i=1; AFNElJ/0z2slCJzvcoQRZULdEvuLrpiRNb9yoxdA2rzETuuS7JtS/bIwfMgJPFMe3Dn9MQwHnWjkqaEFN9E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDZP6CVF2leI/LcVbgmK7L7QYLkCsY+F1UjlNMUR/LFQUZ9fDx
	YIknVRa2ow0cJuOQukyR/cYr3Y2NWyqJns9wUqlwk5n2LpEg3oKlnI78GyRlbpUcmFA=
X-Gm-Gg: AfdE7clCx2yz5QKQ30UsIb158W87aTq89wGJSvzPrIqaPBfgq61vgoN8nwH40xRdp6z
	TYyypfPcHoFb62cF1yPdgp4iswfI2ikSk8DdwVBBjPJArrDJOzASgDQM2t8JPRQcdnGpOi4QRqc
	jLKClnvpZ7AjNaNx+W0fbtrBsKOViVbH6g0KdDMzUslGLBvJ1nvNN/RTQjyYS+MChsn1tz/RtQC
	5/EhIdFGbUx+Dx0634pdK3L4+xitjZ3fKwugZrUVYknuY09jhMNFGWq/X2LyAacntP1/sLbeiSO
	FQACCq0nQUrZWDtfujOJmqXTLTkL41POmVdU3w2B/NfdbbqwnavVu5XxwnU461cJ0V6R1BKi1r/
	WTfNoqzlb12JiTbYBcEtQJkoNEpWPOaws0PWwYe+V6qZXxNYqrKWRXlydy/jb0RNFsOU5I9OvRf
	siWTY2L7helwxQkmVm/V9D4ngeu0KrsycrKcttwMstrf1wF7xHSDjV8RWsdWldbo5dhPl3MzC8m
	w==
X-Received: by 2002:a05:690e:d4b:b0:660:4563:869d with SMTP id 956f58d0204a3-662cb9609a4mr624185d50.28.1781637536148;
        Tue, 16 Jun 2026 12:18:56 -0700 (PDT)
Received: from ?IPv6:2600:1700:ba2:6b5f:641d:e96:c688:ab47? ([2600:1700:ba2:6b5f:641d:e96:c688:ab47])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66274e2b181sm7538860d50.15.2026.06.16.12.18.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 12:18:55 -0700 (PDT)
Message-ID: <cb4eedd0becf980ed5d8113f54eb5d35ed56ae5c.camel@poochiereds.net>
Subject: Re: [PATCH v3 1/3] nfsd: reject out-of-range useconds in NFSv2
 SETATTR/CREATE
From: Jeff Layton <jlayton@poochiereds.net>
To: robbieko <robbieko@synology.com>, linux-nfs@vger.kernel.org
Date: Tue, 16 Jun 2026 15:18:54 -0400
In-Reply-To: <20260616054027.2360930-1-robbieko@synology.com>
References: <20260616054027.2360930-1-robbieko@synology.com>
Autocrypt: addr=jlayton@poochiereds.net; prefer-encrypt=mutual;
 keydata=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
 q/2QWqNFB6xOBr5rQ5xwl
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[poochiereds-net.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER(0.00)[jlayton@poochiereds.net,linux-nfs@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22644-lists,linux-nfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:robbieko@synology.com,m:linux-nfs@vger.kernel.org,s:lists@lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[poochiereds.net];
	DKIM_TRACE(0.00)[poochiereds-net.20251104.gappssmtp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@poochiereds.net,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,synology.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 77276694EDD

On Tue, 2026-06-16 at 13:39 +0800, robbieko wrote:
> From: Robbie Ko <robbieko@synology.com>
>=20
> The NFSv2 sattr decoder converts the wire useconds to nanoseconds in
> svcxdr_decode_sattr():
>=20
> 	iap->ia_atime.tv_nsec =3D tmp2 * NSEC_PER_USEC;
>=20
> tmp2 is a u32 and NSEC_PER_USEC is 1000, so the product is computed in
> unsigned long. On ILP32 that is 32 bits, and an out-of-range useconds
> value such as 4294968 wraps to tv_nsec =3D=3D 704. The corruption therefo=
re
> happens during decode, before any proc function can inspect the value,
> and a later range check on tv_nsec would see an in-range result and
> accept it.
>=20
> Guard the raw useconds before the multiplication and reject values
> greater than 1000000. useconds =3D=3D 1000000 is kept: it is the Sun
> convention for "set to the current server time", and the in-tree Linux
> NFSv2 client emits it in both the atime and the mtime field for a plain
> touch / utimes(file, NULL) (see encode_sattr() and
> xdr_encode_current_server_time() in fs/nfs/nfs2xdr.c). Rejecting 1000000
> would turn that common operation into a hard decode failure for both
> SETATTR and CREATE. 1000000 * NSEC_PER_USEC is 10^9, which does not wrap
> on ILP32, so the Sun convention value passes through safely; only
> genuinely out-of-range values (> 1000000) are rejected. The atime and
> mtime guards are therefore symmetric.
>=20
> The decoder only applied the Sun convention in the mtime block, which
> clears ATTR_ATIME_SET|ATTR_MTIME_SET when mtime useconds =3D=3D 1000000. =
If a
> client puts 1000000 in the atime field but not in the mtime field, the
> atime block stored an out-of-range tv_nsec (10^9) and left ATTR_ATIME_SET
> set, so the bogus value reached the filesystem. Apply the convention in
> the atime block as well, clearing ATTR_ATIME_SET so the server uses its
> current time and ignores the value. Only ATTR_ATIME_SET is cleared there;
> the mtime block keeps its existing behavior, where 1000000 means "set
> both atime and mtime to now".
>=20
> Signed-off-by: Robbie Ko <robbieko@synology.com>
> ---
>  fs/nfsd/nfsxdr.c | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>=20
> diff --git a/fs/nfsd/nfsxdr.c b/fs/nfsd/nfsxdr.c
> index ae71e0621317..48a4e89a5f41 100644
> --- a/fs/nfsd/nfsxdr.c
> +++ b/fs/nfsd/nfsxdr.c
> @@ -172,14 +172,45 @@ svcxdr_decode_sattr(struct svc_rqst *rqstp, struct =
xdr_stream *xdr,
>  	tmp1 =3D be32_to_cpup(p++);
>  	tmp2 =3D be32_to_cpup(p++);
>  	if (tmp1 !=3D (u32)-1 && tmp2 !=3D (u32)-1) {
> +		/*
> +		 * Guard the raw useconds before the unit conversion below.
> +		 * tmp2 * NSEC_PER_USEC is computed in unsigned long, which is
> +		 * 32 bits on ILP32, so an out-of-range value would wrap and
> +		 * silently produce a bogus in-range tv_nsec. useconds =3D=3D
> +		 * 1000000 is the Sun "set to current server time" convention
> +		 * (see the mtime block below); allow it and reject anything
> +		 * larger. Note 1000000 * NSEC_PER_USEC is 10^9, which does not
> +		 * wrap on ILP32.
> +		 */
> +		if (tmp2 > 1000000)
> +			return false;

The logic looks fine, but rather than having these verbose comments
above each use of 1000000, it'd be better to declare a constant and
document its use once above that.

Something like this (and consolidate the comments above that):

#define		SUN_V2_SET_TO_NOW	1000000

Though I think the current fashion is to use enums for this so they
show up in the debugger.

>  		iap->ia_valid |=3D ATTR_ATIME | ATTR_ATIME_SET;
>  		iap->ia_atime.tv_sec =3D tmp1;
>  		iap->ia_atime.tv_nsec =3D tmp2 * NSEC_PER_USEC;
> +		/*
> +		 * The Linux NFSv2 client emits useconds =3D=3D 1000000 in the
> +		 * atime field too (touch / utimes(file, NULL) sets ATTR_ATIME
> +		 * without ATTR_ATIME_SET). Apply the Sun convention here so
> +		 * the server uses its current time and ignores the bogus
> +		 * tv_nsec, instead of storing an out-of-range value when the
> +		 * mtime field does not also carry 1000000. Only ATTR_ATIME_SET
> +		 * is cleared; the mtime block keeps its own handling, where
> +		 * 1000000 means "set both atime and mtime to now".
> +		 */
> +		if (tmp2 =3D=3D 1000000)
> +			iap->ia_valid &=3D ~ATTR_ATIME_SET;
>  	}
> =20
>  	tmp1 =3D be32_to_cpup(p++);
>  	tmp2 =3D be32_to_cpup(p++);
>  	if (tmp1 !=3D (u32)-1 && tmp2 !=3D (u32)-1) {
> +		/*
> +		 * useconds =3D=3D 1000000 is a valid Sun convention here (see
> +		 * below); anything above that is out of range. Guard it before
> +		 * the unit conversion to avoid the ILP32 wrap described above.
> +		 */
> +		if (tmp2 > 1000000)
> +			return false;
>  		iap->ia_valid |=3D ATTR_MTIME | ATTR_MTIME_SET;
>  		iap->ia_mtime.tv_sec =3D tmp1;
>  		iap->ia_mtime.tv_nsec =3D tmp2 * NSEC_PER_USEC;

