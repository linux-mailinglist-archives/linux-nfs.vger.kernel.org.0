Return-Path: <linux-nfs+bounces-8939-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 707A1A0385D
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Jan 2025 08:06:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98BB518863DD
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Jan 2025 07:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E31E18BBA8;
	Tue,  7 Jan 2025 07:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DtC0DUVa"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CDDD339A1
	for <linux-nfs@vger.kernel.org>; Tue,  7 Jan 2025 07:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736233557; cv=none; b=hdz6lK0CB1iERnYuBOomaWXkLWKH7NhiOh7E2ZMIsiDpKa9Kg2X/qnojMysnH37kY2m3+TjYM4jC4ztrF+lsy8Q5yIBZ2ACnuAoVRyqzANpZ3aJCqsdIw6Yt86ITT1MPaeMRgM1kXTOayq04+poU2JZWJhDc39Dfwvcg7BzZZ+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736233557; c=relaxed/simple;
	bh=TCbo1qExmwyeCE2EPYI/denwgmErH5FgAaJDEeeiKiY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=n7CFSIgRZRXINMEYeJ9A8c3+iR/ENtLxhfGQpdPU/uI/ZRn9UazcKJyTwaiwBPtzPQhhiaAQ5X3G5jFi7MOA5f78fwpFMPrkrY4LS2yZWNTy8cZQonX9eN3VeAscUcCISBYq2qdkaiAfvCbop+bvgQFizfXKZ2Vb3PqjYVVXeAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DtC0DUVa; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5d90a5581fcso8080457a12.1
        for <linux-nfs@vger.kernel.org>; Mon, 06 Jan 2025 23:05:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736233553; x=1736838353; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hG0v4LTNmmP5Qsivnedwl+ijPXyCoEi5d4NMdyiIGlM=;
        b=DtC0DUVaOmA9deWZgFkVKHLsH+NjWE/msrplGiuK2M4HsOtkCaal5IimAPw+XJiNAI
         ciH2FcfHmveBqWGihKTxSzW6B+JQheKVgjvOseghEsp05KK/pZ0g4sSUBB2DDUgJRw+t
         7SGxD2W6jD+sVTceIIPr31hLzyMePOe036vEkFKmQq9opGxlIA+AxvX74wmR/q2ghqFl
         kCRUS+iqrx2uAvOcmmQFNP1TMegLHvrPBjYm+4xkHdbNEBMypR/6IizYJK2uB6Yw8oiE
         pz35xdvprYbnB6zS+FsGgP31/pDnzC9Kp7G5wdSum1Zp526z22o6+JuLjqU2Mn6RZ1TI
         qQ0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736233553; x=1736838353;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hG0v4LTNmmP5Qsivnedwl+ijPXyCoEi5d4NMdyiIGlM=;
        b=f4rsOHPC8cuswtBAke7V2cwUVyD1qNFyT+vr2ds5b3SNK9/t0020QQ9MZCkbykEgIy
         DaAO68SFzaiJV9rEjwHmI1MgoxJ1J60/umanJvaB+CyrFEn8cJMfy1QDAL/jCSFZZzMj
         gFsjKUerTg17BMfn/1jR9E85B7TuhQpaPlTp+0AZpfNZv1qakhXwd7xKIRsB6RYzX/wg
         ixJe2vZB31maIdC/uiqwYRd48tZwtaowHPoqsbL2NbM6NSRRnr7hYe0JpRzRe+y6M5X6
         mXIh2TKQPLYL8e4kv9BUitsH2Fq0bAZyIJLtVNQkdpRYtdOf2kARwQbfhpt8UdzuQ1a4
         pyfw==
X-Gm-Message-State: AOJu0YycmpZ2nwYeI/iQllUf+YxcmsU947iF2XCS7k+cQee2gnviAus0
	vVLsI6oeGBjr03UOytVvsaA6kn7MTSca9KZLLTrh8d5jJ+bmRcS+/ayMNe9/8yHKYWQSfeKgOJ9
	s2vgPyyj87arnSHnFOmea0jONGuXWfLJQ
X-Gm-Gg: ASbGnct3A5zP5SiPKC8OqldF987E3ne9vnsaucXnMB8AW8t/97DuUX6hQeCAf0x4Da1
	TRKTYj8pI2VT6dc0nUMCHvN2XvY9cPVYTUrH8CB0=
X-Google-Smtp-Source: AGHT+IH0Zpi44cEDh+mEsIL0inx10x1hXwKGopN0JDX+iFtRJj6JYZ2GFTEg5g3rIj2yzZlYVvRNfCEcT5p5oFiQ3Vk=
X-Received: by 2002:a05:6402:40d1:b0:5d0:e63e:21c3 with SMTP id
 4fb4d7f45d1cf-5d81dd8af3bmr52809091a12.14.1736233552848; Mon, 06 Jan 2025
 23:05:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALWcw=Gg33HWRLCrj9QLXMPME=pnuZx_tE4+Pw8gwutQM4M=vw@mail.gmail.com>
In-Reply-To: <CALWcw=Gg33HWRLCrj9QLXMPME=pnuZx_tE4+Pw8gwutQM4M=vw@mail.gmail.com>
From: Cedric Blancher <cedric.blancher@gmail.com>
Date: Tue, 7 Jan 2025 08:04:00 +0100
Message-ID: <CALXu0Uc=oHNTWLR_T0rUyYxPBnGaLday3+0B5Gmd_F1Dm0d3KA@mail.gmail.com>
Subject: Re: Needed: ADB (WRITE_SAME) support in Linux nfsd
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 7 Jan 2025 at 00:56, Takeshi Nishimura
<takeshi.nishimura.linux@gmail.com> wrote:
>
> Dear list,
>
> how can we get ADB (WRITE_SAME) support in (Debian) Linux nfsd, and an
> ioct() in Linux nfsd client to use it?
>
> We have a set of custom "big data" applications which could greatly
> benefit from such an acceleration ABI, both for implementing "zero
> data" (fill blocks with 0 bytes), and fill blocks with identical data
> patterns, without sending the same pattern over and over again over
> the network wire.
> --

SMB3.0 implements support for writing one block to multiple locations
in a file and Win32 FSCTL_SET_ZERO_DATA, so this would be a good thing
for Linux to catch up with SMB

Ced
-- 
Cedric Blancher <cedric.blancher@gmail.com>
[https://plus.google.com/u/0/+CedricBlancher/]
Institute Pasteur

