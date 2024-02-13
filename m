Return-Path: <linux-nfs+bounces-1915-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B18BE853C3D
	for <lists+linux-nfs@lfdr.de>; Tue, 13 Feb 2024 21:28:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E42A284D4E
	for <lists+linux-nfs@lfdr.de>; Tue, 13 Feb 2024 20:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BD7260B99;
	Tue, 13 Feb 2024 20:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QL/DBQkz"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1A460B97
	for <linux-nfs@vger.kernel.org>; Tue, 13 Feb 2024 20:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707856131; cv=none; b=McNljewM9sLyEM8aHTN9oHx+kmoDRNI4l2bLa5i2Wf7FM+kYP8T6+1IC3GdW4PN7PgNnByweltbi/JFoWZtbELxZzabpzey9n3sNeBzR7gcSUcSWJo8APNq3ADpBKwt4fLpB9tThBzHhrMH7BGE30z+BfLq/5nc6R0VDwCOQjuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707856131; c=relaxed/simple;
	bh=bGBtMfvmqTwC9pxjQegBA8Ubqi98TRWx43wAQtyknzs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oYrOPbroTluPDTG+AnzggysM9v0tnMcZk0h+AtXRuZlrfLf5agiVhgaVQXhFqWTT1GNNs80t9KmonDEdEEXwbvTL/TfkQ9VlFtuv68bMtPaca67vp9AwUXwASNtGgGemx6g4rmOmrE71zEzd8wNchHwkzZNM85WqqBB4W7pxmn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QL/DBQkz; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5114b2b3b73so5532764e87.0
        for <linux-nfs@vger.kernel.org>; Tue, 13 Feb 2024 12:28:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707856128; x=1708460928; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oaN7rbgCUhy5pCqMWQxZl5X/ebF+b6dLEXIXIgcwu9I=;
        b=QL/DBQkz0J9kM32PEOJVzXvVubXqceL0Z5/PyM/J2QOSp0uXB82mgL7sGOBcLI8CIp
         Mm0nZcV8nT9EN9sy5T7GlWkf2fy5QCri9UzvALHkIFWaP5p2BFf5YxsAAQIod/WqOWyG
         y+U0/kA492E/i90DTggtqrjrSK4/Kq44Px6apYvOMI4bKAEXn9h1OZqTL8W+R1CF3lqU
         RXgUN6gjL3X98t/NkPlOf5Mf3nynFR+XHcUzsWuLyWCldnMVoC5NQ9RwYLjzB/LCylZ8
         5zF2NR2rjJDlqLRPVJs7WkIw2qxC1p7RJAO0Bd1a2w4gU57LJxDzbsWQFKNtbPZ2Flru
         XXvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707856128; x=1708460928;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oaN7rbgCUhy5pCqMWQxZl5X/ebF+b6dLEXIXIgcwu9I=;
        b=hz2NPSWNjx+A53uzRXb4Bst5M9rUqaPlheZPT6xRMnavRacSAGRt7XxM1WnrbuCQGf
         XfNQSs2GtdFYZfYsW1nNw9naO6OJgHHoXXjb8H990eTj2BEHD0j22W9HWF6bJh2k1KvA
         45IY3n7mM4Wxq2useOhYHS0bTX+CzOGi4Q+13UfmKTRImlhFQ+pLVVFcUFnbwvmPCmhA
         Qn2AkD94dVHrtndhAwCGter3Gc3ahXMUysq6TGcFUpc2pjSeqjg7kRkgO6PrmApktRWa
         ttb/B0wTq8z51NHUrfkgFIVMatT7jI74EsmdPELnION4rHgaKoarzXobO9sg5r6mQMrF
         XNwA==
X-Forwarded-Encrypted: i=1; AJvYcCXgWVCRq0B5XYFopBm/LebyNbnIAwsnQh5fXdWfxCsZTLaIwUCMzOOQmZyk3ljK6iXt1lQ4d727YdxR+eZWieL/vD1afRxTBFcD
X-Gm-Message-State: AOJu0YwFJpi48aHYmOp87SCCzYKDzp25bpmRvjuGAoAReohmOeBjRYsD
	p1tIWOWjpc5HNMpnMPV54Co8cqnQ2zX+v0YOdd+L1ij9gjxHZvGccMAdaLDZGrrmucOKA8ErIuC
	C/dV4iqiU4GpKXk9cNwjZ/+yh1T2KJR9ElTs=
X-Google-Smtp-Source: AGHT+IFFPxcb4MpbhdJO7EZXeyJ6Mphq4xHHQvS12Dwe6U1xJmrjzGsLuKDZk1Yv03ImJy5QLL+luS2D/YM7SPPl+kQ=
X-Received: by 2002:ac2:44b9:0:b0:511:87c0:a327 with SMTP id
 c25-20020ac244b9000000b0051187c0a327mr455856lfm.68.1707856127597; Tue, 13 Feb
 2024 12:28:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAvCNcBvWjt13mBGoNZf-BGwn18_R6KAeMmA7NZOTifORLEANg@mail.gmail.com>
 <CAAvCNcAkZFkLU-XtmJy30AT7ad_MvSzZTMEk86PiZXLdcMg4fA@mail.gmail.com>
 <b14648b0-a2f7-451a-a56b-6bb626c4ffa8@talpey.com> <14e1e8c8613c74d07cb0cefbcebbf79a3a57311e.camel@kernel.org>
In-Reply-To: <14e1e8c8613c74d07cb0cefbcebbf79a3a57311e.camel@kernel.org>
From: Dan Shelton <dan.f.shelton@gmail.com>
Date: Tue, 13 Feb 2024 21:28:00 +0100
Message-ID: <CAAvCNcAsow-QTPYLm0fUNX3K5X4Aci=aFi+hi4a0S8k19oa-KA@mail.gmail.com>
Subject: Re: Public NFSv4 handle?
To: Jeff Layton <jlayton@kernel.org>
Cc: Tom Talpey <tom@talpey.com>, Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 9 Feb 2024 at 16:32, Jeff Layton <jlayton@kernel.org> wrote:
>
> On Thu, 2024-02-08 at 21:37 -0500, Tom Talpey wrote:
> > On 2/8/2024 7:19 PM, Dan Shelton wrote:
> > > ?
> > >
> > > On Thu, 25 Jan 2024 at 02:48, Dan Shelton <dan.f.shelton@gmail.com> wrote:
> > > >
> > > > Hello!
> > > >
> > > > Do the Linux NFSv4 server and client support the NFS public handle?
> >
> > Are you referring the the old WebNFS stuff? That was a v2/v3 thing,
> > and, I believe, only ever supported by Solaris.
> >
>
> One more try! I think my MUA was having issues this morning.
>
> NFSv4.1 supports the PUTPUBFH op:
>
> https://www.rfc-editor.org/rfc/rfc8881.html#name-operation-23-putpubfh-set-p
>
> ...but this op is only for backward compatibility. The Linux server
> returns the rootfh (as it SHOULD).

No, I do not consider this "backward compatibility". The "public"
option is also intended for public servers, like package mirrors (e.g.
Debian), to have a better solution than http or ftp.

What does it take to implement a "public" export option?

Dan
-- 
Dan Shelton - Cluster Specialist Win/Lin/Bsd

