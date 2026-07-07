Return-Path: <linux-nfs+bounces-23132-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TVaaHJPjTGphrgEAu9opvQ
	(envelope-from <linux-nfs+bounces-23132-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 07 Jul 2026 13:31:31 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0749D71AF48
	for <lists+linux-nfs@lfdr.de>; Tue, 07 Jul 2026 13:31:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=RuKJBK7c;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23132-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23132-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2FFDC3019920
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Jul 2026 11:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1FC52BEC34;
	Tue,  7 Jul 2026 11:22:37 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34041303A35
	for <linux-nfs@vger.kernel.org>; Tue,  7 Jul 2026 11:22:36 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783423357; cv=pass; b=QiIGvkZScaW22wIr5jOPLj5fZRLAH+MLvJ3I5JsJqOgGQOdx/ycoqWuvhOAon/3HZSecDHCc4pVZBB46RM4+eWOq99z/vfMr+AAf2aKw/dyCCcrXH54kP3HEIW2G8NPLoBA/fkDDW+fJcb00n1jmdZrXQtlL1O9+IruJTZWpU6w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783423357; c=relaxed/simple;
	bh=Ai6aH3bAzQ5F/P6PmYrtyqk7WXMC/vVWkXC5pNUHoI0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=DMyR46fgqdTNRDolvKmoP32h6RSBDglOmE6kori7OD0EPwaRCpH+XO8rOQ5atPghrA/DVWj9L73XMtDFUOaNgK2VQP4HawPEBVLN4VXfMzF/0nWDDmR7gdCTMrRkILfst/x6l/Kjtg2IV6OMvmTO7ypahw8SelS/WS12woY9lcE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RuKJBK7c; arc=pass smtp.client-ip=209.85.218.49
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c1254b73d63so449180466b.1
        for <linux-nfs@vger.kernel.org>; Tue, 07 Jul 2026 04:22:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783423354; cv=none;
        d=google.com; s=arc-20260327;
        b=dfFlqOqD6cAi8yl4eAVs1SnTuPNuZSrxhgSTdl+sekeJvQCZ5Esnch9UKBRQ7aIGiH
         kSIWykcxjmmbjrlVFxOJHrGp6svlhlXk1BffXlnwRqfhTnfZKopH0CLBfvywNGPWQgs8
         zclLZ+wObtxMqAC/Bm7t68R+lBfEzEXL6gOxi28nFV8GWp4UtAe7F3xMzWpauDpYbHf4
         9/srH3ymz8QmSRG2VmITM4OTSIsiBgnDZlxttyCgFsKtsJhRfleD1wHwyBmhTN3slbUk
         NRBOIAZRhic4CNIF/hgRRM0ksjPO5zHRN+8vbKQ88Rfru3HSRkDtwI/tv4KDd9ZO2s+m
         IEyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ai6aH3bAzQ5F/P6PmYrtyqk7WXMC/vVWkXC5pNUHoI0=;
        fh=A3pMOUK00huGibGCZBFsLekFLVbB5hHGKjUNNKwO+5E=;
        b=arFylQqvnpvLBCn1clh2f+hM9DTUXYkbC1rvL/DtOL+CERKv44hELPBSCio1RCbTvh
         xMrqsPk3BTG4wc7tpU72om9jSVcFACl4sC3and+9M2hu7GIKxG66Vlw80PWooBgI2aPo
         JfW5LtDKfr38Aon8g8r0R1j2QACxWA6tbaitk5stI0I2yUS9UPZfkpk5eyCT8ivakI67
         wXp6/bI1DqV831feHaUg91cBRyz+oqSkSN8A37ZKCaay2vfNurAW5ahXiKQZTAglZ0y1
         rvGvMhgY1JgWdicCwSkWYc3p4eQ5qC5uqTiqw3bLR4ytN+Ew27FsG/6T59D8WYM0RpRJ
         ve8w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783423354; x=1784028154; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ai6aH3bAzQ5F/P6PmYrtyqk7WXMC/vVWkXC5pNUHoI0=;
        b=RuKJBK7cScO/Q/CxUrbFNUwK0bN2kWsUkHOjdhs4PyMalnsw5h1nk3/bznlfxWGnyc
         pyasrixmZciKjz9HY0EVnPDTzYmgchx+vBZLnU95p4ScsRh+65Dl1j9sG858EI4bWjDj
         TWqKksVWZ5mnChtXtPOzxf9WAQh4JUlE6z8sCz62+te/PfUs6gJaso5DVJ76qhJrMRDq
         mWwVXJJqjeHPLUH0qWUBg2CxuRXtY7KC/Y8+NcTkWvkbJHgwni0tcpxvbGtXmGc28KC+
         Brd4NDnw5S/6Yq44mpSfsjZ/5s/3hN1jsEDCXpSr2kPHRLfSNQ8fD8GZyNjbi3GpQh3/
         4gBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783423354; x=1784028154;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ai6aH3bAzQ5F/P6PmYrtyqk7WXMC/vVWkXC5pNUHoI0=;
        b=HP4uKg0bZvXGFIxV0qOEVRI0reKHqOs+TCG1LwrdtKdQxrW1cmH23kerLUdtLA/Eve
         mcI2vt9wOXfo+mYXGq3wXSvjLxKy/zK4jfk+z83agV9Ww3D5Wv7q5bsjEeq47yrJ7pal
         Jj2GV9RE60HHud+fR/kxY4BkBvI+75LuHGSSmWqFQSt90uDfILtpzXGwnuqCZNuipOcS
         /nVhEZEJEM5o6sLKDH6AyOX7ln9pNnzYSK4QA9rPHC4cTCq/RoI8O+mhxd7+hJ1V2hfN
         zQe38NLgVlGnIjv7YfMBlwFsEx0q8RKN+iiUQbrArvzIX0fOotL8jJgw5iT/qFYWlZkM
         QRwA==
X-Gm-Message-State: AOJu0YzV0q42UJe4cT8rJene41BqAeQzgkHdeQnYGzfXnwmkHGbPNcWQ
	LP9YHvtxJ93siFgD9Tst8poFsL2LMm7/+y7cLTnelEYxiYvCiDZTSbKa3k1+dm7vBa5wXKIHUUD
	ahmkGAGXFZZeyeArXRxQGLlwS5F46zetBqg==
X-Gm-Gg: AfdE7ckhJdVY3vTihmZGnCDyqbsXPKz3P6pFOgKabpw+IyJVhnvEi4FzSJRdFCtYM6x
	vBmsi+s5YgH4B5GBy/iKNue9nAvmmKv7DMIPtJQe94uy3q4SxkN4smP5YQkWQ+NnTsGsiGDY2sb
	lnHnqee05ylWONaDaFlTPC56+R0P0KmFUjd8+HoaU/HFN8lajHEle2yA5Vgw6KOmAePz8gjSKQl
	s/RVA8XIBxaaC4czNl0VwElgqnVHD2W/ckA9ynbFPqywnw+7lZQuN5m8vNJVph/gVkzEq/Og2/3
	QnJbJVYjCQ==
X-Received: by 2002:a17:907:9492:b0:c12:919f:f6e3 with SMTP id
 a640c23a62f3a-c15a6858f40mr248125166b.57.1783423354283; Tue, 07 Jul 2026
 04:22:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALWcw=HsVbqgnBE+fW=qO9ULPww8_0amGjgw-f11FuoV2=ftOA@mail.gmail.com>
In-Reply-To: <CALWcw=HsVbqgnBE+fW=qO9ULPww8_0amGjgw-f11FuoV2=ftOA@mail.gmail.com>
From: Takeshi Nishimura <takeshi.nishimura.linux@gmail.com>
Date: Tue, 7 Jul 2026 13:22:00 +0200
X-Gm-Features: AVVi8CdSyXtwYhaRNrK318L82UXzQW7A8Pb4Rk9WTMoyPhq3d-sTH_HuVyDmZTI
Message-ID: <CALWcw=HMhCU_-UX7mHPwX9jqu-r7y7XBBrhg66UNjxYZaiO9Ew@mail.gmail.com>
Subject: Re: NFS swap with RDMA?
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	SUBJECT_ENDS_QUESTION(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	TAGGED_FROM(0.00)[bounces-23132-lists,linux-nfs=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:linux-nfs@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[takeshinishimuralinux@gmail.com,linux-nfs@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[takeshinishimuralinux@gmail.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0749D71AF48

?

On Thu, Jun 11, 2026 at 6:01=E2=80=AFPM Takeshi Nishimura
<takeshi.nishimura.linux@gmail.com> wrote:
>
> Dear list,
>
> does Linux swap over NFS file work with RDMA transports?
> --
> Internationalization&localization dev / =E5=A4=A7=E9=98=AA=E5=A4=A7=E5=AD=
=A6
> Takeshi Nishimura <takeshi.nishimura.linux@gmail.com>



--=20
Internationalization&localization dev / =E5=A4=A7=E9=98=AA=E5=A4=A7=E5=AD=
=A6
Takeshi Nishimura <takeshi.nishimura.linux@gmail.com>

