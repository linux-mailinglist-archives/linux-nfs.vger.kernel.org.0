Return-Path: <linux-nfs+bounces-20023-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6KcmAy4psWkBrgIAu9opvQ
	(envelope-from <linux-nfs+bounces-20023-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Mar 2026 09:34:54 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A55FC25F68C
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Mar 2026 09:34:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F2C753050010
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Mar 2026 08:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB988359A8F;
	Wed, 11 Mar 2026 08:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HuZJ8Iky";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="SUGc1Vsd"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53844359A6C
	for <linux-nfs@vger.kernel.org>; Wed, 11 Mar 2026 08:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773217642; cv=pass; b=K5QhX9SLEHh1K9VS0Rdqe9S38yWn7KOk0+c7QTXThgw2MVMrLFNEQaxqbRhZ0qtZ5ZQ+3y4HoHBBeZc+Adw6CQFE76kt01GBy59yKN+eazJ8CTqHuxy1VIB4AZlTvxn/WGQ29Ifubv4R4h9wwWlnwtfvIDIErHW4DGQXsDhFiFI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773217642; c=relaxed/simple;
	bh=nJ2q3IpA0YHrVpjb++MKGtv21cG2AhHuvZBj/KNZLBU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OblYIjFNHuR9T4S8hs4Aqo15J1YLcKcBf97bPkFNnGV0T7UzBB7zTIwHWW5z7nKQ3GchlzWX5ShksKSiN+iHLOTeKi9YDfDkIm0wVHVpPh8QhumNXRuj6kvWlATMOkUlxrooy30BcZw+EJQr7tylYntaFBLh3fPzhTbEeVeDQik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HuZJ8Iky; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=SUGc1Vsd; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773217640;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ta2zU8IPOH3qbg7tBAvO082q0HZS82bipGoP6zDp+gY=;
	b=HuZJ8IkysyvCtu4tske7Y6IJcuILKJtoWmhKQa+HQKjSfYbjU53mmvyJBQZZjqWxhJkpwA
	am74xjT95FtSAyaHrEjW8h4DrpI6s+lFAt3kgyKWNNx1slYTvJKVXnC4Cx228EF1vBuoqj
	xV1KQxhEi0rt2ah8TRlxV7N6SAWMQMQ=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636--b71ZiTyOfqnHHhh8vad0Q-1; Wed, 11 Mar 2026 04:27:18 -0400
X-MC-Unique: -b71ZiTyOfqnHHhh8vad0Q-1
X-Mimecast-MFC-AGG-ID: -b71ZiTyOfqnHHhh8vad0Q_1773217637
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-38a2f76333aso41441011fa.0
        for <linux-nfs@vger.kernel.org>; Wed, 11 Mar 2026 01:27:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773217637; cv=none;
        d=google.com; s=arc-20240605;
        b=d6o0HcBAXigN87SzfT8Tmd/SL5XNkByOIcj4i4TPfYIslXFmp2vC6IyFEvxXj9msTp
         Zy0QHDWS0lQcBKIdw3z+vhMqP/3gVzxvLMkGy/w8no60Gl4A/cjul2uUb6ok+l+cTtJn
         pDbxhgMK1QGH/U1KVTFSja7zLS9ywmuI9Ob8Sv1rPcaDH8g3lmcr3T4YEMqq/U3ikENN
         +VxIAPXr2/Cud+HQ2suKUCK7rHJKAXfE5JDZ3sLnqhjeumuRwLDUoXcYGoYOBWt0qVMX
         QaQUbdewU3pPSykqrngMDTsSjMmVnAvaxH+cHgtjElfXfpN076sNBDT9PrtUUm21XwuD
         hjgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ta2zU8IPOH3qbg7tBAvO082q0HZS82bipGoP6zDp+gY=;
        fh=uJFe3LQ0PDTPJWtDVoBD6Ai3XdgBPEjXcSR0ubU1t4s=;
        b=EQe2/yUihctz7LDBj2+4PD6WUHen2GDOxx+vym3TJWDWCb7qjZVprlBsYTP6jrkp9b
         RbyT6q4CIU2Au2o7c/Y8pHezZnx86PHBhgO2KqcLqKS37CkOh1IF0cyi1onZjMy+5JkS
         8J+fzvxmuBElIb0rxVI4oCEoCZ/wT0t6QrNSG3AXGR3jFMivKCbxEknuQ2oDyv0FMh4E
         BA8IpScyo1suhR8J9Pp8w8UHsGWZHn9AQvAAnFBMbdrUBcSQBR4S2KcZRPbtulNto9+E
         8dUWCsy0Cpook1Qv+k2Oa72VMoBa94P1E5HraSdyHEf1kDW3JRE91a8iqw15jESesNuj
         3C8g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773217637; x=1773822437; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ta2zU8IPOH3qbg7tBAvO082q0HZS82bipGoP6zDp+gY=;
        b=SUGc1VsdobatgVsKQwQIE8jPT9ZnRi/LL/NBo+xL1obQVTdUlBkyC/nNuCjK0hwPnY
         G1PNCKKiuSgsHabUc6wz/RRkI6DXVH48qCNH7U/dNzMbF0gy33dhYHnfcux/NgheMDfV
         6HgqNcEn1ZeE4TVM0g72p1LRX+PljqcOSLqeT7KULHKk+6UT3wRJNOf/OwI0L6VwQEeP
         GAiEDpqP62xUpv7riPVZeMVxlrwoPvNt/qNN16qwvRH/0M5mw2h+g6qEVe1wy7jBHEel
         01tv93qwR29mp5Q1oRCJXkA9ntCIcLXv71bLUytH4tEgxB5b+jovTLbpfLmu7feXtPLW
         P4MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773217637; x=1773822437;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ta2zU8IPOH3qbg7tBAvO082q0HZS82bipGoP6zDp+gY=;
        b=Bh7ci5B38aBRHI+16vJgk8HErzu8PCj2bCAxARXtGBEyM/vKPJfZeRV0ss7wwx4fZa
         CFFM0LST2fvOm7RVdkTleaDvQ1EE4UYvuFyvWQx+PjCZX+1CgR81iyNF9uu88FNyXZGG
         XGdsx/BL38Z6G1wK+NpVTSS6TLfViayS27Mx/0nEF66JG+N0Z80s0zXr5mhCBijqLsDC
         aFUaTkDAJ48U0u061skil8cnhgTDQ4/QRByq8J+QXYs/2VZpt0+Dq3VYeDOgJKZH86Fd
         4tersWQIIca0hOQ+JqQQaNcick+TwJ5SE3wT9XmhuTek+AbSvOXFktMppCTtIAawzQK+
         9L5A==
X-Forwarded-Encrypted: i=1; AJvYcCWlISk8fmyngMMMyJa77HGLShHo0iwAn1eaFHf9ioN8qiS2oIT1qGzGDYDvCm6U9D7c/tyT1HqNXLE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwaKMjiBLu8F2rEotlGs/BzLKGQQb1W1EV0bUW5hCsFFzMLv/g
	Uj1pzSNFNjrikucMbfVi8z8nnqR4LFoVWvCUtz0trjRbrCqib5LNkXkvQWFiRuFv/LupqiaiSWT
	AqlTZ61KudAVEvprnwjBl6Wcu/QlzbyHORUdXiVS5x4eliAvTXIXGO+U1pGZ+x6o/C4w9MmsqIu
	jzb2c3OhFXSH7SoCM3KZ4ElE6yd19SmgdqnD4F
X-Gm-Gg: ATEYQzwtr56F9A44GhcM0nIgH2DBH6CAnJ6/+8+biSHg+gWU5nBu1z0yYXtwnhwWFTr
	SMtyn9/ghHqkoKe8ec2HNpVhHi0MOY3G4K7HZ22iSWfTgGf4wvo560unay4A6X9l3nI8O7EwxBT
	LnPNcyHfMzq4XzINz2ggSzjWiePTM81J2ef/jIzNDfBHKKxHBaY149QX5ksbaJ0AV53cqzNDMMj
	XbmOGIXoWlWkVdVy+vu0DW4N5dFtWWcAZxP5B4OXYDVcOOidUA=
X-Received: by 2002:a2e:a887:0:b0:38a:29e9:d29f with SMTP id 38308e7fff4ca-38a67e7e201mr6177501fa.35.1773217637241;
        Wed, 11 Mar 2026 01:27:17 -0700 (PDT)
X-Received: by 2002:a2e:a887:0:b0:38a:29e9:d29f with SMTP id
 38308e7fff4ca-38a67e7e201mr6177451fa.35.1773217636756; Wed, 11 Mar 2026
 01:27:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260309145025.107623-1-atomlin@atomlin.com>
In-Reply-To: <20260309145025.107623-1-atomlin@atomlin.com>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Wed, 11 Mar 2026 16:27:04 +0800
X-Gm-Features: AaiRm53g3b9N54jScxHExbID5iTy7i77bXokBseDkKzXlhznXmcDzr1ORtBJzi8
Message-ID: <CAHj4cs8zCdtm7PYcbqtsQpWWCB9n71D00b5LPksLq5op7WUd=Q@mail.gmail.com>
Subject: Re: [PATCH 0/2] nfsrahead: fix uninitialised memory crash and refine
 fast-path logging
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: steved@redhat.com, tbecker@redhat.com, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: A55FC25F68C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_FROM(0.00)[bounces-20023-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yi.zhang@redhat.com,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-nfs];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,atomlin.com:email]
X-Rspamd-Action: no action

Hi Aaron

Verified the issue was fixed now with your patch, thanks.

Tested-by: Yi Zhang <yi.zhang@redhat.com>

On Mon, Mar 9, 2026 at 10:50=E2=80=AFPM Aaron Tomlin <atomlin@atomlin.com> =
wrote:
>
> Hi Steve, Yi,
>
> This series addresses two issues stemming from the recent fast-path
> optimisation used to reject non-NFS block devices, which were caught duri=
ng
> blktests.
>
>     1.  [PATCH 1/2] fixes the glibc abort(3) by explicitly
>         zero-initialising the device_info struct. This prevents the clean=
up
>         path from attempting to free uninitialised stack memory when the
>         fast-path triggers an early exit.
>
>     2.  [PATCH 2/2] updates the error handling in main() to log a
>         descriptive debug message rather than a general error when a devi=
ce
>         is intentionally skipped, preventing misleading udev journal spam=
.
>
> Aaron Tomlin (2):
>   nfsrahead: zero-initialise device_info struct
>   nfsrahead: quieten misleading error for non-NFS block devices
>
>  tools/nfsrahead/main.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> --
> 2.51.0
>


--=20
Best Regards,
  Yi Zhang


