Return-Path: <linux-nfs+bounces-10665-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 304B0A6805F
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Mar 2025 00:02:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13C377A8961
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Mar 2025 23:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18B321DFDB4;
	Tue, 18 Mar 2025 23:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TnKY73He"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F401C173F
	for <linux-nfs@vger.kernel.org>; Tue, 18 Mar 2025 23:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742338929; cv=none; b=iofTOg5HfxCmUS1WuHOl/U2qClx7kD/raIgETfDVzyt6Z/ZPd3Re9U7tVmIawO3/j/yRoV6bEv5vS6tLjCjaZSYllQ7klRM2AauJcbLHmlNdo9glrbarJKjkRPoZhVjz19TSbRLwnwGg60SGfof44n2NquBp1BcLAWzMByw5Avg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742338929; c=relaxed/simple;
	bh=W5RdqqleI8Jd20HY2tLLnHb7V2dw31eSEow9TovhzK4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jqDHE0tN9SX1PsULFwF7isUL2c+BcmquAJBmfQDpNoYb3rmd5E1joTxuY0XXHJeWwkI4Cq1lgU9ERCi33FvWxawYZHo7i/H5oLBM/D5kwxMwJGjgWSkZzMcu7UX9oNX5xe39J4V2QRtYgzpQVZPpMOeEdjztbeQkZ4f0TqzgoWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TnKY73He; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5dca468c5e4so10711011a12.1
        for <linux-nfs@vger.kernel.org>; Tue, 18 Mar 2025 16:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742338925; x=1742943725; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W5RdqqleI8Jd20HY2tLLnHb7V2dw31eSEow9TovhzK4=;
        b=TnKY73HeYQNoX8s4/ahZ/e5md9Tv1xfzNK6R/AkTm752N/AnZWuqVewYr0p0S4APXE
         Moa/pI81Xcp80zOBIaudWpqKkM2aKnLnZTNhrFlIh30t2Hi8QNXBWFXk0x8rU7LkrZoO
         H4LMtQvMJYaLjle9sT9qLjAmBkwlEk/Vp1fU45T4mr+1X9xPje7AFILa4XmWLkcYYRen
         quU93esUd7BSYbCqBNvvIpBqaf5eNcKcRaG38IAmtcSYUsXHxq7dCrzXOBD+6/iijLOa
         Lb1ixMMP4h2wEjOpwf6DEvNC8tqgCXfLte2jlWLBfw+CcZD7f2Uh21RZ+UhNcuWnv5HH
         uzEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742338925; x=1742943725;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W5RdqqleI8Jd20HY2tLLnHb7V2dw31eSEow9TovhzK4=;
        b=bsQKZLeqHC47VtNIul1H6HV5ELBkpZvIdglZBmHmiCZg4HID89+Jb4ItZvLpvT1bJu
         w1yBz+XLYhp4ItFX+1tyFQ3rFeL6uAlC7OtQR09+B12VtV39cdujLuWtli4jlrNB1IpV
         JvYoefgMB4DijtXaTM0bwOY+pgrSHYL83trxl6wKDz+ORD0+lsRworvcrswWWw9X8K/i
         b7RAk49MajNKaupVYnt60hZd67NgAIcIJeHkm2AGEKwAFKVhCDnPjw98qnL+/JYMoKgZ
         CUWFDaFmSf6mjm2lqGmz1abUnZBCeoxDDEz4sDWKtHTC/Xb/+ABvF8ogdqdMpBcOdJA9
         dkTA==
X-Forwarded-Encrypted: i=1; AJvYcCU6nYsMCEcC49qI5XuRfTVsamBcflJly0oxA/eaIqKsxIRToZ1DlzqaotkElnrr0fqY+u6iZFlA1wA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4dM/PaQqfIfvv6MtgAp+dWHtadFNfKSPBWspF5ldDMXsgPEdi
	LDEAWrJntiCiIAdTP0ZTdd7ADc7rCR7F3OCC+RtHgw9877Ddzj3JJpb1JNseV+3JrbZr9wWNTfG
	p5AIeLmyqhxNm81cp4S9zmO4sAQ==
X-Gm-Gg: ASbGncueh9xq6OOKCKnz+H1M4Or5a293s/z90dpV6U0eMi22/KNWgIAt/ILT7ClLIBb
	LSiZxXeVIHWD/KvOSozt4eX9etq0ka92pUgqKv7c+0AZ4gwYAT2j6eaGwtwahmXYx0eBcDIgJ8K
	c+M3porynBfDXyT6/aC0gK48hSuqrmqh/T5qiLbmXB0qGDU8I5F2n/dRkkp8E=
X-Google-Smtp-Source: AGHT+IE24T0VCOZdC2MrQxDvr33zFHmssXXIaQYb7fAQyzmbRYWU0K0HPu64kyJydxb8GqPwSwUj22f0d29jCg/C5mQ=
X-Received: by 2002:a05:6402:358b:b0:5e6:4ac8:c361 with SMTP id
 4fb4d7f45d1cf-5eb80f97cd5mr464105a12.28.1742338925331; Tue, 18 Mar 2025
 16:02:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALWcw=EeJ7rePwqv48mf8Se0B5tLE+Qu56pkS-fo0-X0R3DQ=Q@mail.gmail.com>
 <0ea71027-c0cb-436a-8dc7-6f261f0d9e0e@oracle.com> <89535c4a-7080-41cc-a0a3-1f66daa9287a@oracle.com>
 <CAM5tNy7FdNRC6i62jqyMs=A=03omztTk3YdgS=P3qJVersSFbg@mail.gmail.com> <e674d6ec96cc8598b079efd3b93612537f840a87.camel@hammerspace.com>
In-Reply-To: <e674d6ec96cc8598b079efd3b93612537f840a87.camel@hammerspace.com>
From: Rick Macklem <rick.macklem@gmail.com>
Date: Tue, 18 Mar 2025 16:01:51 -0700
X-Gm-Features: AQ5f1JqimfKdQa57eUn-v2zU0OcHKgYohN8xtA7XRYpskxldsSASSDNfCgIFQYc
Message-ID: <CAM5tNy7AGHk+-H2BQpzB0r8LtSy37XdWvpjcNxPmOuG+v5zBtA@mail.gmail.com>
Subject: Re: Supporting FALLOC_FL_WRITE_ZEROES in NFS4.2 with WRITE_SAME?
To: Trond Myklebust <trondmy@hammerspace.com>
Cc: "chuck.lever@oracle.com" <chuck.lever@oracle.com>, 
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>, 
	"takeshi.nishimura.linux@gmail.com" <takeshi.nishimura.linux@gmail.com>, 
	"anna.schumaker@oracle.com" <anna.schumaker@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 18, 2025 at 2:17=E2=80=AFPM Trond Myklebust <trondmy@hammerspac=
e.com> wrote:
>
> On Tue, 2025-03-18 at 14:03 -0700, Rick Macklem wrote:
> >
> > The problem I see is that WRITE_SAME isn't defined in a way where the
> > NFSv4 server can only implement zero'ng and fail the rest.
> > As such. I am thinking that a new operation for NFSv4.2 that does
> > writing
> > of zeros might be preferable to trying to (mis)use WROTE_SAME.
>
> Why wouldn't you just implement DEALLOCATE?
Not my area of expertise, but I believe some like to know that
zeros have overwritten the data instead of the data just being unallocated
(blocks still sitting around with the data in it).

rick

>
> --
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
>
>

