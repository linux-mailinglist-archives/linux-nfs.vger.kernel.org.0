Return-Path: <linux-nfs+bounces-20469-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gALyAxi0xmmiNgUAu9opvQ
	(envelope-from <linux-nfs+bounces-20469-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Mar 2026 17:45:12 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B4C24347A8E
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Mar 2026 17:45:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 204B331DA8F5
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Mar 2026 16:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 428B434AAF9;
	Fri, 27 Mar 2026 16:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VyCR2T4J"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD1830F957
	for <linux-nfs@vger.kernel.org>; Fri, 27 Mar 2026 16:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774628851; cv=pass; b=qBmWOBLf/DfxBjxRJNQuGOeIDveQDjAxBEtRGFfm7TnjVO63SoH/W4Vu8s8OikPhTt3fYwnhtjITbK3ccxffdOlIUQPaOwa9V3j23KRJ1Tn04aSTfdjSCn614iDjzdDrp+mprAvHpp9tiWBkWLDyp1cZJCZnK/yzKovDqJX3lws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774628851; c=relaxed/simple;
	bh=0dEEWHnWsd2NeePgC9ykLBzxupLpx533aLyPFNZ/RQo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=eBGdo0Xi7jSOkId+BcOkcm3ZpDtsjghdMKYmc5YO1rjsTpYumw0rZ7kx3OAtLuc2LPaq279zXH4wUOFraVxTyR7F/LXVV6Rx2BUBT+aPAUhFXIU1Y0ArobnoJ90X6ssWViUc8E3HoPdWfnCeoRmeknDanRE47HIndsvQh+ksk8s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VyCR2T4J; arc=pass smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-66b2d49ffb0so1051074a12.3
        for <linux-nfs@vger.kernel.org>; Fri, 27 Mar 2026 09:27:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774628848; cv=none;
        d=google.com; s=arc-20240605;
        b=ZxTeQnUfWJHBqAG57Wacan7bOgiijAnfsLu2UabreS62yYeLOrMUD79gmLiJIKONzc
         unX/4fFsEAaMbZDY0EdyUlIgfi5x+wGkmld7vOVXHI1iiossIBQF8GJsaiSQFw6/1/qi
         OnlfIy1qen/pGHati9eCYr60+Op7bXdZ2MEijpSx7+4WgCBgw+ayzwb9kDJZ4WkISeR9
         C3cBw9OwLQvKAVjDyK1H9a6orkZYvunqAxMmLpIYoYsGRet2uoJQZCt+XDKAsPiYzYAb
         BTlWG0g2KVx3iMOAHe4iJMm57PL4NWu3FnP4xvicgg9/+kWDICXRROyKC86iuu4X/Vk7
         4qYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0dEEWHnWsd2NeePgC9ykLBzxupLpx533aLyPFNZ/RQo=;
        fh=ctn6QCyhgWuda2Kv/+hRd5hKIZFVBqcoznGhZxY2bTo=;
        b=iHsnXEmoOrdKQgErHeFZDwE9TeSpbILzdSFVti6oTtNBzxXJbfa7M45p3D5UCAIBM+
         A0x/8XoT1LBuxICcr40RS9GG8LF5ZtUesJ8zM+l38OCiBG2gI783divImWZ0KIX2UiVV
         2V1ePKSMCeqSqQrqGhJd6QcbFQbYqhFEq2IlkOFzLjA5tAbd3M+dJN19sedNQx7wiJB6
         gDSpGhs5VuSwdHo/7WMfySdVrd3JQGhxYnhBpBrjT87dS0rK5EEtZg1e0Cl7vP+jBSzL
         2obOnXRk9JhDaL+jRmNWyaXQhtHFR7BWuLPOGQi4AZf3KlpE+vksCUswZTZ3bH4Lm0aV
         o/ng==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774628848; x=1775233648; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0dEEWHnWsd2NeePgC9ykLBzxupLpx533aLyPFNZ/RQo=;
        b=VyCR2T4J/5diYc95ZVTHwhzy3DRFbym8En8fdvoOd2TH7qKwcoXmO/CqdEH9ih0T35
         +58oixOI+VyuswEBAP70n/I/SS+cMkBLg2KR3Vkoct03dqdLcYYlMWKaK248vYttGSVo
         Imw2DyckLlH55yFBisiT+5npbBEJNfwOKXIB5t3QevbC6RgX4r628B2GeX0dwCsn1UO0
         12VTjOGo4nnuhRDXrs4qlYHlPqMGnnfF87axYsa9TnqRizU8vT6p5jCB2do8Blp1wgFb
         otY2hQoL0r8ou05ilZaL6S3oMHbQt90Aua79+cSlur8cYacTIZdsXYY9Ynsxjt6Co9EC
         2d9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774628848; x=1775233648;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0dEEWHnWsd2NeePgC9ykLBzxupLpx533aLyPFNZ/RQo=;
        b=JEUKBkLR9t9o04IvjJR9Q7zOknHuBR8LqQ9rQhZzVnvm5KwlOc1cVfbzy2qekLarEB
         POlr2jY9XR7UHERZFlADk4S6CTrqBh2xF1gT8LRfaz9dTey93WPf+WgnBgMtTcBFdSWx
         /AJRFf4vIEWa8xJRbnKBE+0bUsWjKM9+UlOgbzl3w5XTRnqwRgCHfM3iGxdW7HOjIMtd
         UxBjsXhzAJ4k7mrCzObGZjdEdJF9pdkXFbmbCvpwTFrUpdT14U3ojLAZyryxG+24/az3
         bgb4R5k/dQQRa/G+vbvejg9FsGWGK2RNuyq/DUCr6xYfkxjH8gncmLcP58VgtdaU4l+B
         Q51g==
X-Gm-Message-State: AOJu0YwggfUy4pd0ArL6enl2rEOe/KY9JaTBROlsnGA9IH1q43RyHUVI
	/NXqBizPoGn4p0J5qLeOkhuPSfnP8IEhwdNZfy7BBZrWhIl2BUQdfT4LwP0gA8FzYFtf4WrSC/7
	fFOBzwh9EZWvIYNkH2WbPV9XRNIw/oEba29R1
X-Gm-Gg: ATEYQzwSIjIzaIMueYbBHnjOyHhZUVczea9dc+e6drONhYyIHIEowQyJ9z0OdxKLvge
	bzMWN1xqwujeos318gZc13+LdQUZfRIHwNcfrLfHGn95fmj1RmYGTn1kPX+17IKhnlFuVFvHtsm
	6wnl7LeRliVGA2kGjgGPi4/yW9VR3pIXEjTtFbz8M8Gt48mvbYmMYQx148MnuPOkXUGmxMYnpZr
	6N+pUEYMv08o7MchNa5HxbmzAUEwBIo5B4Rz6VwG0L8Eo8U2zRMYMbNkUCpFiJjhoiaimnVWRpE
	kbQERXukBG6788S+4d3zQrEybH5glP3J27z3yN0=
X-Received: by 2002:a05:6402:5385:b0:662:bd98:890a with SMTP id
 4fb4d7f45d1cf-66b28f7d930mr2047257a12.25.1774628847660; Fri, 27 Mar 2026
 09:27:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <33de50bc-5cca-4071-ad32-05a82da89c77@oracle.com> <CA+1jF5rbEzKyvzvq7ATzGhy0xthL8baRLV-zDCe7r=e2OVh3og@mail.gmail.com>
In-Reply-To: <CA+1jF5rbEzKyvzvq7ATzGhy0xthL8baRLV-zDCe7r=e2OVh3og@mail.gmail.com>
From: =?UTF-8?Q?Aur=C3=A9lien_Couderc?= <aurelien.couderc2002@gmail.com>
Date: Fri, 27 Mar 2026 17:26:51 +0100
X-Gm-Features: AQROBzAzEL4OVo-M5QQXnQ_yk9y2wHWwPKRUdWhEbCIF4c_MHpySt-P7CXdWNkI
Message-ID: <CA+1jF5pguuUukL+5im41x0OewGX+kTtjFNEF3VD0g7nCC47XhA@mail.gmail.com>
Subject: Re: pynfs-0.5 tagged and pushed
To: linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.60 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_MIXED_CHARSET(0.56)[subject];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20469-lists,linux-nfs=lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aureliencouderc2002@gmail.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid,oracle.com:email]
X-Rspamd-Queue-Id: B4C24347A8E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 27, 2026 at 3:47=E2=80=AFPM Aur=C3=A9lien Couderc
<aurelien.couderc2002@gmail.com> wrote:
>
> On Fri, Mar 27, 2026 at 3:57=E2=80=AFAM Calum Mackay <calum.mackay@oracle=
.com> wrote:
> >
> > I've applied most of the outstanding pynfs patches, and tagged and
> > pushed pynfs-0.5
> >
> > There were a couple of patches with which I'm having difficulties in
> > testing, and I've emailed the authors.
> >
> > If you have submitted a pynfs patch which doesn't appear below, and I'v=
e
> > not contacted you, apologies, and would you please let me know.
>
> @Chuck Lever wanted to contribute a test to set an ACL-on-file-create
> and ACL-on-dir-create.
> Was this never submitted?

Forgot to CC Chuck Lever

Aur=C3=A9lien
--=20
Aur=C3=A9lien Couderc <aurelien.couderc2002@gmail.com>
Big Data/Data mining expert, chess enthusiast

