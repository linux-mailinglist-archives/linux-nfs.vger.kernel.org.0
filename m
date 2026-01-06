Return-Path: <linux-nfs+bounces-17500-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7966DCF960E
	for <lists+linux-nfs@lfdr.de>; Tue, 06 Jan 2026 17:36:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8E1AA3001A04
	for <lists+linux-nfs@lfdr.de>; Tue,  6 Jan 2026 16:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D03C248F47;
	Tue,  6 Jan 2026 16:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mcgTLmuW"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB8F3203BC
	for <linux-nfs@vger.kernel.org>; Tue,  6 Jan 2026 16:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767716984; cv=none; b=dZvP9gd/zpS/TuEVJlmA04aXiwHpvk/oMBmkhxJWmuMCobhKl4Pfcd6+4mr3a+0LSTkuE6YjZAEJ48KjJbPBANz242Vn03cJq1+8PpUiSwZC4VsYXACgCWgAX2SHzeqXLLHq0D+t6Zn8AhIl0RJLOXe6uQZgwtM6ze/gZqOiHKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767716984; c=relaxed/simple;
	bh=LEScb5W/YBkL+EBesQ5iA5K5b+l3+dl9NDfqDjS4Pnc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=W/CoN/Fh73tEJKd0NKCL7bzLDrHVwKR0aWg0JUUYgA1l+cxzPfmeZlRc1PE7osuz+i/rXV6MoQ2caeTs3PR4zwMK39zZRmvKQV2rhwm5i3Z0zmiIierL1x37kGOE7rWihdXdP2K/yWW8m/5N8q6DQCHiaGLinu4ba5+rxxcUDks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mcgTLmuW; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6505d3adc3aso1702256a12.1
        for <linux-nfs@vger.kernel.org>; Tue, 06 Jan 2026 08:29:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767716981; x=1768321781; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LEScb5W/YBkL+EBesQ5iA5K5b+l3+dl9NDfqDjS4Pnc=;
        b=mcgTLmuWJLs9egaozzM21YmP5CVzclkpPg9iCh7F0TQ33W0MdLASVkhX8oGbu8yxdj
         eLH7vEviqb+Q+tvS6EFla7ksAmgNmZHARiepaTylbGOWbwnAAxBvsWkdsGpc3A9omvvO
         H6qUTsapXMl8/aKn3MBwXcOrih6/Wn8HV9QmcaIHc/k2LuvwE0m5b0/c4Jg6CHKYtzkI
         getnIGqlLVgAJPZJhKE3ejvFUb6yJ05WxZdupMJ1J/7z+RAup+JJEiQmgDErTY9/nuqE
         mH5+enX9T2sIKj+QP20BFk1MpkD6hyky+STO/iYOQq4yni/3Wv3ijfLadEAGwwim1+OB
         95yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767716981; x=1768321781;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LEScb5W/YBkL+EBesQ5iA5K5b+l3+dl9NDfqDjS4Pnc=;
        b=C6HlRFV6QrHh2Bu/2W+8xmlsa46jtoRiq8lGKqnItMcQY64txQ5P6oMZsQpp03cs77
         g3FEPMsezFcKe7qhY6jsBaOxI/Q/Zurgoh+QnnJJxOXIWKYIcbIbarZDMxZtZMZnZhgD
         uTge35cb3yz9m6KUmHrT1myL27+r1VL0REf8W/DA9nj5LuHax1vP0d44RCCTPGe5JC23
         Zfd9FCkW7P+Hp73l47SKQlE0ZNTEqeuJPavfPFyBgRupViV5vYVb2CPqxrK08mK12DOC
         pDiT+4Whw2jZpQVGta2/81ypV2YjOEWfROK7PpTa78u4speT1xFlDr5fhPIa7w1Z0M3v
         JLOg==
X-Gm-Message-State: AOJu0YyXcrnAifhkq9d5VOsaor5ZV7LcyUjSgclXY6Gv4ERYM3XaaAWB
	ZNBTQ+HcsWDwvg9lFIB3YCZ8dK8Y9ks5usnTZI6igbqoIXFoxIr3PMGrKO31lvexhEGbUBUCNWQ
	OzAIupJSluv0qnK59RBa6W49knqxU+eqZ+3U4
X-Gm-Gg: AY/fxX6oQzFB4C92cfzlPWixEz4iMfyeb7+VYJKOfCYRlZ/sIugMTSl2DmkGO9lPD6S
	UELA+xE55yCoPNPU4wYwxVbAUksI4WG2MwFOZ5+wnXm767sWakBmrYrdLgmLCj061l8Fe2S4ffE
	cb03ZepiRDLfP+cbnqHpN7KBYAKgqvrvtJRO8oMQDWcAHGM5m02rqQwbUJP8Njyg5rthvl77Uod
	0uyRtF5VTEeHYsPyKlOb4nT2IXXriWudKvocA1NEiDT7oBohAFaGOE0f1q/GlI7nfrUjRgESBj/
	H9E4RsFC+FAanS1ukF3m9pl6a1bb1BLKOAD0Yg==
X-Google-Smtp-Source: AGHT+IEJFvdiWK46/Y6E/ujqVIHBNK34Go52Nsy9cDIkIGrsmO/FNaCBCtNAbsmwl6pq9q+UPv6gbGsWh4Rp4cnbr7w=
X-Received: by 2002:a05:6402:254f:b0:649:815e:3f9b with SMTP id
 4fb4d7f45d1cf-6507921d7edmr3191695a12.3.1767716980571; Tue, 06 Jan 2026
 08:29:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAM5tNy4Waqfaqu7kgtnSNrdyR0jBSzJ76tMTbGJPq4HGbBKHiQ@mail.gmail.com>
In-Reply-To: <CAM5tNy4Waqfaqu7kgtnSNrdyR0jBSzJ76tMTbGJPq4HGbBKHiQ@mail.gmail.com>
From: =?UTF-8?Q?Aur=C3=A9lien_Couderc?= <aurelien.couderc2002@gmail.com>
Date: Tue, 6 Jan 2026 17:29:03 +0100
X-Gm-Features: AQt7F2rIyz77SUbS113whQU-QZXIYPK9b6f3btrLsusOeU9COaG5Z7sxBLRRqTg
Message-ID: <CA+1jF5rridUXjSjT4a5OTa4BsKQz6BFS_Ka-6FfEwY1E2y7_nA@mail.gmail.com>
Subject: Re: Limit on # of ACEs in a POSIX draft ACL
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 6, 2026 at 5:09=E2=80=AFPM Rick Macklem <rick.macklem@gmail.com=
> wrote:
>
> Hi,
>
> When I did the POSIX draft ACL patches, I mistakenly
> thought that NFS_MAX_ACL_ENTRIES was a generic
> limit that the code should follow.
> Chuck informed me that it is the limit for the NFS_ACL
> protocol.
>
> For the server side, the limit seems to be whatever the
> server file system can handle, which is detected
> later when a setting the ACL is done.
> For encoding, there is the generic limit, which is
> the maximum size an RPC messages can be (for NFSv4.2).
>
> For the client, the limit is more important, since it sets
> the number of pages to allocate for a large ACL which
> cannot be encoded inline.
>
> So, I think having a sanity limit is needed, at least for
> the client.
>
> If there is a sanity limit, I can see having the same
> one as the NFS_ACL protocol will avoid any possible
> future confusion where an ACL can be handled by
> NFSv4.2, but not NFSv3.
> (The counter argument is NFSv4.2 is the newer
> protocol and, maybe, shouldn't be limited by the
> NFSv3 related NFS_ACL protocol.)
>
> To be honest, NFS_MAX_ACL_ENTRIES is 1024,
> which is a pretty generous limit.

Nope, this is not a "pretty generous limit". Realistically, with big
organisations, you can easily have 300, 400, 500 ACL entries per file
or directory. Example usage are MEMOs, where you get access on a
need-to-know basis, and as as soon as you do not need access to that
memo your ACL entry on that file gets removed. Yes, you could use
group ACL entries for that, but that's not how humans in big
organisations think or work.

Aur=C3=A9lien
--=20
Aur=C3=A9lien Couderc <aurelien.couderc2002@gmail.com>
Big Data/Data mining expert, chess enthusiast

