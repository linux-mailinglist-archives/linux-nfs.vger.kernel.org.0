Return-Path: <linux-nfs+bounces-5016-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB29193A21E
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Jul 2024 15:58:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22AEC283E6E
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Jul 2024 13:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 080DE153810;
	Tue, 23 Jul 2024 13:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="q/p3klEl"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65B4153808
	for <linux-nfs@vger.kernel.org>; Tue, 23 Jul 2024 13:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721743117; cv=none; b=IaELfTLrLuQedMcsn6W3L4UnTwZY9w66jCPOoO4jxW3Tq+7D668OqY6kgPPpDdno3DowrytxHqskEFcp4FoiCsWmrI9qZZLTYUdbMiyAH6h0adS3/5jWkjQDFgkDC9EQ61L2PXIsN95Gj1NGU8w9abgU6swVES8AtKj1Ha5vlz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721743117; c=relaxed/simple;
	bh=Fejn2ohM1Wg5zp4n/r8tyH9iKRpedPEHPQ6riWQqEbI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oJx6Rl+f/1cpQoy07RupQGgOPQU+nR3hIu3kWDXxPxxNoeXpVkqCoBH03Cf8mCQr+nMb4Lk+0DHWDNIId0rTAvfBwR6Q1xZFosWFdTR3jdgu5GqpVflIjn5Wq2LGD2RVmhQyxgGDtGyc8kvPCat8FeLpw04kQPn8NBN+M6IIitQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=q/p3klEl; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3684c05f7afso683384f8f.2
        for <linux-nfs@vger.kernel.org>; Tue, 23 Jul 2024 06:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1721743114; x=1722347914; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mejxLsKJw9NfDFkwm6U9PaL0qoSJ+b1gvXRg/m+0XnQ=;
        b=q/p3klElpxRkTVpefr8LqJennMmnJljwxcNnKd4I7/nrOqwU8lg7HYlXht5dnAqUcZ
         xFrtEu7muAMRYJjItoKBnC2o960R6Bxbiyn+olDLOpgY9FY/maawN4MfmzuYe1B0bnAb
         wyfCReunMF+xuWjohTx6A3U6Ao382SC7WjV2gHJ+2se4GTeUxoD9wXNhUvvGJu55SAQ5
         O1y284yKx/rgOu/hzxRMjSYD9U3Kiw1Kdgt8Wsj12MI0iALt9fdJjoEpalLe7rkJkh6d
         NtUWS6BYjUxwgGZfisS2X5aR5pBmf+kh7IX2YQfU1RCxjQ7ATSEBC+kjLIxdsm23FULL
         YAtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721743114; x=1722347914;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mejxLsKJw9NfDFkwm6U9PaL0qoSJ+b1gvXRg/m+0XnQ=;
        b=OQWLMSE+Y6S6dtP+RHTHAIip6XHsB0YGGfaLSzoX3B23xM+dN9IYVn10uEkCkS6GRZ
         SOEuJ9R0TVt/OWkKi3BTWzPnirdSeqA5m1o1x5Gp5XiprDPszq/qbVHRe2fwyTeg6p0R
         QbPwYp04rYSA+R0JeNjZuskTdPTiJhi/18AQgRshlPb0Kb1uYHPtTFEb2EC22oTPg+3S
         HJWVwH+la2Pr6xVrCVjdvnHQoWJ8OFr3zei3iJi1pxrql8dzryvZzbXqcBDksjiTCFzC
         wbOfG9UQvWKmnAnp4vYAAH1Xvozqs5R1eUc41GEmnBdgEvGrVJiOuJDpXN7d00nnHpZ3
         tC+Q==
X-Gm-Message-State: AOJu0YxVe0YDJgoqEblr94Lx8/KXZLzy9llIq74imDGrIMg417ebSvZP
	7BiwnTeN6YBco1AmslMI6pHeAN6VDmgPSr3V+YKsDH/3q8gZLqEY62SBdulsGjSe+LBhhYmHtHZ
	foBPLMjx4w17JyY+ox6571jTi8xU3FA==
X-Google-Smtp-Source: AGHT+IEutF4JOBPd9wIw2wWjbZcc3MBU6d0wKCluN/qEUGf1h/5ZDjsY9okcL3805XXIBCJ1vMk+If3ZFS7CotLZTbE=
X-Received: by 2002:a2e:6d12:0:b0:2f0:1dfb:9b64 with SMTP id
 38308e7fff4ca-2f01dfb9be4mr13335121fa.7.1721743103675; Tue, 23 Jul 2024
 06:58:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKAoaQmG+FRhQquBJzFkr+BHFDCxxKky706Za2+nC9CNf8i10w@mail.gmail.com>
In-Reply-To: <CAKAoaQmG+FRhQquBJzFkr+BHFDCxxKky706Za2+nC9CNf8i10w@mail.gmail.com>
From: Olga Kornievskaia <aglo@umich.edu>
Date: Tue, 23 Jul 2024 09:58:11 -0400
Message-ID: <CAN-5tyG+t1Q=Tr0FtTzWhKE-=hLvWOarNn3_ArUt9VYuZ=aauQ@mail.gmail.com>
Subject: Re: New NFSv4.2 attribute |FATTR4_TMPFILE| (sort of opposite of
 |FATTR4_OFFLINE|) ?
To: gisburn@nrubsig.org
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>, ms-nfs41-client-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 23, 2024 at 9:17=E2=80=AFAM Roland Mainz <roland.mainz@nrubsig.=
org> wrote:
>
> Hi!
>
> ----
>
> [2nd attempt to send this email]
> The Win32 API has |FILE_ATTRIBUTE_TEMPORARY| (see
> https://learn.microsoft.com/en-us/windows/win32/api/fileapi/nf-fileapi-cr=
eatefilea)
> to optimise for short-lived/small temporary files - would it be useful
> to reflect that in the NFSv4.2 protocol via a |FATTR4_TMPFILE|
> attribute (sort of the opposite of |FATTR4_OFFLINE|, such a
> |FATTR4_TMPFILE| should be ignored by HSM, and flushing to stable
> storage should be relaxed/delayed as long as possible) ?

I think a more appropriate medium for this message is an IETF NFSv4
mailing list as FATTR4_TMPFILE is not a spec attribute.


>
> ----
>
> Bye,
> Roland
> --
>   __ .  . __
>  (o.\ \/ /.o) roland.mainz@nrubsig.org
>   \__\/\/__/  MPEG specialist, C&&JAVA&&Sun&&Unix programmer
>   /O /=3D=3D\ O\  TEL +49 641 3992797
>  (;O/ \/ \O;)
>

