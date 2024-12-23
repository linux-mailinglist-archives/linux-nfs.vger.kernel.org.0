Return-Path: <linux-nfs+bounces-8755-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CA0C59FB7E3
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Dec 2024 00:23:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4AA567A1929
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Dec 2024 23:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EF4C1D86FF;
	Mon, 23 Dec 2024 23:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aXYtO8C7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF39E7462
	for <linux-nfs@vger.kernel.org>; Mon, 23 Dec 2024 23:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734996170; cv=none; b=NsU9ENcFgv8C3Xu8JTI8u8EcvH2VPmMGenT9IZKOgjL/mO/CLfAwJ7Cf4cYl4+upILBFxFmO//KpaHgdPIBvt9+ZTl4SOgsdZi6U5uA7w5DOOTsOFRQPlVYeN1+9jAGW4EID+U8ojcYr7XOrGqGavqVjVv/aaKc4wY6Q/JJeB14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734996170; c=relaxed/simple;
	bh=BsNZa2GChI1qK50AnHEc3jxxW7A1HXZShY9+zWe7J4w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t3NCGCVYUlr5jCsrLKfJks7w3UNXH3afy5/eneg78jVwPru5fGSqXX2RCcUHTQV+HvkDt8+YPrhlB/EeBQXXeLhbVbuHiTEEK3f41CGSSrcljyhZjg/h4sVgxj04vNoj+WEX5wls/wtcbf6YhO9H4mS0N8AkFWKFyLr5c8XXe/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aXYtO8C7; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5ceb03aadb1so6460037a12.0
        for <linux-nfs@vger.kernel.org>; Mon, 23 Dec 2024 15:22:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734996167; x=1735600967; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YAGQoUsiqge8/370FRo1ZsTsKmSkb/XFTywlMs/Spmw=;
        b=aXYtO8C7vSbYIYT/WgouWC8jRzhe0BI8iBMsKW3xciyYnrxr2A4n8UEzE9oB/sK5zB
         xZfHvbpkMUonQjiLULPFuumg0z7UqJKDozK0WITFPgLWhsOyDxGd0zBkL71u2C6JzMCM
         J0yTaEu1Bh/5pfExM21EZkPoS7Fs47g4BQHqlqRYXbQnqUGEns4ZTtlFgVMTgqYWcQMV
         cMQ0xfdzHjYimtXC6IHXDs2zJl7YkbiYeDKdvskRY3G4IiP8wGHwQNsV6jrqcvrs1pF6
         fL65wZzccyDo1pjieaNBOY6BCQIxaoUq8ltGgLwFthBM7W6cmxAoawAoOTDKDNFdjEaL
         73ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734996167; x=1735600967;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YAGQoUsiqge8/370FRo1ZsTsKmSkb/XFTywlMs/Spmw=;
        b=Gw5jGchWDF77ZB5TIhakzlGiMC5l+8Rlkgp4r6JbdzEB9ouCI9C7EiYQpy8XHF5XkL
         4zDKX01k3/jHy0OFRUllsMMQjXA8myky9Frab5dq960ZYGlvmTrnovxZqdNSpICO4WMg
         hR46Rp9U5cBsqIdcJxEUcs1Ud2q+YwGTmLTnLTeFHKeRhTlCuXdIsJskPjmpisjgWTwM
         TxieUu8ahBwl/cedOJ3Jrvw/zEnsJgjmbooHYavhzVO57AhD7P0XWAm+PPku+5F0bTOI
         jdoxgXipB5ERzEQy7WJuUT3D4fucUJxSXiC3Q0CDHhDESby42uJG4FKGb2ucFoR7IYmI
         74UA==
X-Forwarded-Encrypted: i=1; AJvYcCV87jytHP8j1sknYuCLstZU0zjsmnMIUGqHtLSFMkkqJxCObsW3kQpTQOvoz9PPVqd2rZOs2hxic/s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYXRqf6R9Mp2yWDIQuuHbDCOOv0q/9GX4uXcWXMK355F0dS0JH
	ojIxNeX0u1ftG+klXECs1k5SFhcCYZL4IMM5PoBoH23gnbZK0yYWYAQEmEPAquirNMsrG4BV6FH
	pc+JNyCTEwY9Wyind6XmdWJ4QZw==
X-Gm-Gg: ASbGncuw9L2j9/GZEdg6GJXUQITpjUychu+NoFDxOl24uy5mKd29cR1O/ZLe7GEj6kv
	jdjPXY1oCF+yOjmM5lH1Sy/IYVfLSKpZyfTd81+ES8QWVlG0EnedKWNuwNIhs4VgUkDB7Ng==
X-Google-Smtp-Source: AGHT+IFXd3IBZcIZ2uGSQ1CiOFDj7jTVsflS/ibYHz35SXBlShQ328DeE47sHO7VXYGZW8Skb7SIIgBV+re64U+56pk=
X-Received: by 2002:a05:6402:2805:b0:5d2:7199:ae5 with SMTP id
 4fb4d7f45d1cf-5d81dd63ca7mr12705898a12.5.1734996166890; Mon, 23 Dec 2024
 15:22:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241223180724.1804-4-cel@kernel.org>
In-Reply-To: <20241223180724.1804-4-cel@kernel.org>
From: Rick Macklem <rick.macklem@gmail.com>
Date: Mon, 23 Dec 2024 15:22:36 -0800
Message-ID: <CAM5tNy74=vqdSaciOKus0SeU4eBB+Vb-TzKO060t1RSdAQYGxQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Fix XDR encoding near page boundaries
To: cel@kernel.org
Cc: Neil Brown <neilb@suse.de>, Jeff Layton <jlayton@kernel.org>, 
	Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 23, 2024 at 10:07=E2=80=AFAM <cel@kernel.org> wrote:
>
> From: Chuck Lever <chuck.lever@oracle.com>
>
> Build out the patch series to address the longstanding bug pointed
> out by J David and Rick Macklem.
>
> At least during NFSv4 COMPOUND encoding, using
> write_bytes_to_xdr_buf() seems less brittle than saving a pointer
> into the XDR encoding buffer.
>
> I have one more patch to add (not yet included) that addresses the
> issue in the NFSv4 READ and READ_PLUS encoders.
It also looks like there is a similar situation in nfsd4_encode_fattr4().
It uses attrlen_p (only a 4byte xdr_reserve_space(), so safe for now.

You might just regret choosing to not wire down the "safe to use
xdr_reserve_space() for 4 bytes" semantic, but it is obviously up to you.

rick

>
> Changes since RFC:
> - Document the guarantees around pointer returned by xdr_reserve_space()
> - Use write_bytes_to_xdr_buf() instead
>
> Chuck Lever (2):
>   NFSD: Encode COMPOUND operation status on page boundaries
>   SUNRPC: Document validity guarantees of the pointer returned by
>     reserve_space
>
>  fs/nfsd/nfs4xdr.c | 20 ++++++++++----------
>  net/sunrpc/xdr.c  |  3 +++
>  2 files changed, 13 insertions(+), 10 deletions(-)
>
> --
> 2.47.0
>

