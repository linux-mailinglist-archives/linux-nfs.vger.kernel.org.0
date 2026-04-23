Return-Path: <linux-nfs+bounces-21073-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sGrrCP6P6mkU0wIAu9opvQ
	(envelope-from <linux-nfs+bounces-21073-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Apr 2026 23:32:46 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D8AAD457E82
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Apr 2026 23:32:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6FDA7300F5F9
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Apr 2026 21:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20AC826ADC;
	Thu, 23 Apr 2026 21:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="nT416hvl"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404B529BD8C
	for <linux-nfs@vger.kernel.org>; Thu, 23 Apr 2026 21:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776979962; cv=none; b=hyt9SqgcYL5YmxzrgdYKsVTbxfnujNw755Bg0CT29FgX/PTAZysbbE2Kgj3qdzmijViATcKvWd9iIcyCpBpoNlObw983W2R/lWrZEJP715y8c6XuGuL0MjNw56UsB/03awp2veqnMHm1CE14bzUpHC7hnQNrKCgv9Td2PJ2hcrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776979962; c=relaxed/simple;
	bh=bxUAkIGnMur+aw607kar8nkz5/Re3HySZqzoilCqNa0=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GZN1Iw1ni6SjQ5X47CZMTV5hjhJR81odmgnr/kV8lyRIWcUjyz1FtIE+fRFg8F8QliTKnDH8L1CNoKAjZmKo/1hSNEq2CVTooNKf2jBUPGZ+LE8s/l22QZkRLIKPC9lCO2pXhBztaisnjj3WgtGDJNTpmy1pOD5RDr+QcEFnOm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (2048-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=nT416hvl; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-479dd56d016so3369466b6e.3
        for <linux-nfs@vger.kernel.org>; Thu, 23 Apr 2026 14:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hammerspace.com; s=google; t=1776979959; x=1777584759; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6+vIboSvPLx3hvUrHAQR9qDaK2GABfNMedOrUabzBbU=;
        b=nT416hvl9n1bfz+aGCcxLDBnX4xImMYW4F1DX8AMobdGGnaDe6J/D+dv9ueJRJA+UL
         wCBFFz+seQoeyzTML8v9cYa1F/i1arP5RhyJwqt4V51MC26il2GIB6p86+S+7b+RL2fb
         3cTdWb0fj5Kz85yyrjnfPh1z780BUSEIFpCAhsy11pKGwYZRjY7lLOL/O5f7xMrme9aJ
         7jGuFjk5KJ22MGoa4mLQN85HM9YD2I/SPZtBe5Clxru7sMJUzYOdwWgxT+f8iTe+A/RC
         9Noj1p/3XKxPcPw/8yZzx37tDIiU8cUeUQuwCkiYFDQkMFIQ0mLutr6Lb6zpfxF49efC
         OhJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776979959; x=1777584759;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6+vIboSvPLx3hvUrHAQR9qDaK2GABfNMedOrUabzBbU=;
        b=PKL0CQKgdw4nlff4B5YW3HBpS2AEG90GGxmGTCktqMy6m1GyjZ5PCFvdhHxyOFfofn
         RPrqxZSfbR5PudKf+LBgQ4MhCyA6L3SzRwlY3s/i13Oi6gdi4L8vz9y4Gs4o4L2ZKJF7
         tgGaz5aQFQI6kJeHetfR1OrUWDKCPvmDfo9Cb1/xfOczOEeUUScjc6GvXyiItMyBvvqq
         PyT1TATgu8P5naK0DNGCNKbrTPSczvcPclGz1/emOoWaK3ayxY0T9HDBL6ArhkprtVAC
         A3c8+WrhvKA2jgm7Vr8tNlbc3qKihfFOOwBtcaJwsi0TxDsREw6CpOzmLEm1/Vghsjac
         L9Vg==
X-Forwarded-Encrypted: i=1; AFNElJ+T9Iy+nGXSJ4VeAUWKt12s7i7NJlZuxLpn4k7eWxhrk2T0DtJJ2SvxVjhnZqPZ5VEkUETL2IJK5kw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx48lk2tyTz7byzKFz/NTzDI6clya1FZsBV/S5Sg6wjZ5zc6R4e
	+NOqxA9xGU0Yw8N0HMDQl64JMs4fCsl3QZqGDj2+Tm8eArpVEJ1SEfako6tMuZEeEqY=
X-Gm-Gg: AeBDieuhv/zwM33yD7NUR5do7xf3Ihh0QipAH+PzmBG2aBu2h9VhcbJWMjqV87W+FMB
	7hOv4wrxi9hxpTn/k8BbG/B3Q8nTTZz4mJ8Ux+KLxLEKWDaNKgymGgqWvBPDAcebfkR1W6RnuLC
	Fg5R/MShLP24WJfP7QtYepksJYg2lx+JzrIfg5W+9hkbx54fO5OfgiPgCCEgzYZ2uLos0pmNg18
	+JWbn947wB/1OKoPQI9CXvfs8yosnaABRuwf1ofcIF/1pHUBdZtkGGwAksV/+LY0yxYMv8bAeul
	2T7kA2P/+O83ZHux4o/3THTa1F+IZcStez2WlkXQN50alwyTsEV5Vybm58dl73l0jmqX2rILnSQ
	IuB5+Vk6ryq11h2tfWNFJasqJEPPQnJsqEfnZ9Zn8hDGQGJJHLaXZtWMw3ddtMYc/9f+w2CEHIV
	TG+pB/G6mPiN0YAVl4IZpFZN+T4tXdFF8u6JDUe+eoFz/qLiQta2Swu4em5Q5OBqmfBdD2jj3i/
	gpkG0N5UEl/2XERz+c/E/hsCqMMeXfiYk/f9k+fjMz2
X-Received: by 2002:a05:6808:6f8f:b0:45c:881c:e0c0 with SMTP id 5614622812f47-4799ca846fbmr16445085b6e.47.1776979958903;
        Thu, 23 Apr 2026 14:32:38 -0700 (PDT)
Received: from [192.168.75.157] (162-232-235-235.lightspeed.livnmi.sbcglobal.net. [162.232.235.235])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-479a0169edfsm14002410b6e.9.2026.04.23.14.32.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 14:32:38 -0700 (PDT)
Message-ID: <4b02eb62822b3ca363188e48878fbeff636b05fa.camel@hammerspace.com>
Subject: Re: Why does Linux nfs not set EXCHGID4_FLAG_SUPP_FENCE_OPS in
 NFSv4.2 mode?
From: Trond Myklebust <trondmy@hammerspace.com>
To: Takeshi Nishimura <takeshi.nishimura.linux@gmail.com>, Linux NFS
 Mailing List <linux-nfs@vger.kernel.org>
Date: Thu, 23 Apr 2026 17:32:37 -0400
In-Reply-To: <CALWcw=HJ=3FxjLntfFrdjmFa-QKgs29uvna-m8mYRHTeHMJphA@mail.gmail.com>
References: 
	<CALWcw=F7tO_6S9xGUyyqZnc89FxhpKgtF7soZ+59vnSeYB2xMw@mail.gmail.com>
	 <CALWcw=HJ=3FxjLntfFrdjmFa-QKgs29uvna-m8mYRHTeHMJphA@mail.gmail.com>
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
	DMARC_POLICY_ALLOW(-0.50)[hammerspace.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[hammerspace.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21073-lists,linux-nfs=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[hammerspace.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[trondmy@hammerspace.com,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,hammerspace.com:email,hammerspace.com:dkim,hammerspace.com:mid,ietf.org:url]
X-Rspamd-Queue-Id: D8AAD457E82
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 2026-04-23 at 19:07 +0200, Takeshi Nishimura wrote:
> ?
>=20
> On Tue, Jan 7, 2025 at 4:41=E2=80=AFPM Takeshi Nishimura
> <takeshi.nishimura.linux@gmail.com> wrote:
> >=20
> > Why does Linux nfs not set EXCHGID4_FLAG_SUPP_FENCE_OPS in NFSv4.2
> > mode?
> >=20
> > From https://datatracker.ietf.org/doc/html/rfc7862#section-14.1.4
> > =C2=A0=C2=A0 A client SHOULD request the EXCHGID4_FLAG_SUPP_FENCE_OPS
> > capability
> > =C2=A0=C2=A0 when it sends an EXCHANGE_ID operation.=C2=A0 The server S=
HOULD set
> > this
> > =C2=A0=C2=A0 capability in the EXCHANGE_ID reply whether the client req=
uests
> > it or
> > =C2=A0=C2=A0 not.=C2=A0 It is the server's return that determines wheth=
er this
> > =C2=A0=C2=A0 capability is in effect.=C2=A0 When it is in effect, the f=
ollowing
> > will
> > =C2=A0=C2=A0 occur:
> >=20
> > Why is Linux not doing this?

   1. Minor versions are not allowed to introduce a feature and make it
      mandatory
   2. Why bother, since the server is going to set the flag whether or
      not the client requested it?


--=20
Trond Myklebust Linux NFS client maintainer, Hammerspace
trondmy@kernel.org, trond.myklebust@hammerspace.com

