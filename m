Return-Path: <linux-nfs+bounces-5266-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 542DA94BFA1
	for <lists+linux-nfs@lfdr.de>; Thu,  8 Aug 2024 16:24:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93E07B288D6
	for <lists+linux-nfs@lfdr.de>; Thu,  8 Aug 2024 14:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEF6C18F2D6;
	Thu,  8 Aug 2024 14:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KTa1eG+v"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BAD818F2D2
	for <linux-nfs@vger.kernel.org>; Thu,  8 Aug 2024 14:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723126989; cv=none; b=EeCLwIeN/6ELAlI2RNhYvNQQ/DvoIBVKlf0u+I8HCR9ulEIhJ2aeA2rkYq6fUYEZrDfN0f5yPDl3YCvRUvSoUfa0sVKVBUj454qzNc0qc9wBzGZ/cyai3wg/MZxT+vlYqg+FcsYPnGWqnry+nQ49GGsOR74cEa1jOrEBSuQ4Jb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723126989; c=relaxed/simple;
	bh=46t6+h+KCXnf0rOEL6KQxMgdjLUN9sJoIMT9CoQ/lvE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lalEHhy0GyyYnRqAlDY1XyW5lmedS7wM4V9ciailgjMfbV1R7wWg3ujdYJTM5pWcWUUkeLIp2ywII0441BMgqfO/h/wBu39rBE7tyjsXNt+iNtpGSjVdgFp76LSZK12TfcfgCpoiRL/5J/rC8UqH28/2eFcVM8Fn+4XvqPmpThg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KTa1eG+v; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-451b7e1d157so5999111cf.3
        for <linux-nfs@vger.kernel.org>; Thu, 08 Aug 2024 07:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723126987; x=1723731787; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H6d9RnEGZjhv6lXe1TweVqzgDaDUsqpQIjmcbPxFo4c=;
        b=KTa1eG+vKrtGIbX5BINh5iH2rdH4OkBA+BwgDob/+XAZn240PAy7xtjuqBtOUo9TIp
         CrwLap3Z6EvvFSBUb7B7KKVlKymoO5BjVIsJyEIGm9t9NPjArDvJfcYRrSInbjBqzSmI
         mxUgvVotYerI3KRYLnARtC5XnVGHvwnejhQ9VNXGqEEm8W7vqNii/GQmDtotI9XRN8j+
         o+g3xvsZ+lHuCeFzL0L5JZS5ZmvdvLwpPPrOF6IPC7iS1OuzX24xO9md6UXkVPEpsiSr
         8yAfHhgVEFzsU/AUsVqbLY9OVwI2pCtSePC8vMNVYjjeOYBPmTHAs76sRjHlQHZf93sv
         3PMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723126987; x=1723731787;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H6d9RnEGZjhv6lXe1TweVqzgDaDUsqpQIjmcbPxFo4c=;
        b=JI237mIAh6cAULLPUV1Awh5NAJaCm8ZWcvjdVbmGC1hTDOPj2Bm+mIcF0tu3UEeD/u
         4X0DE8usJUTnG1cojW2ebbIw2Pp+pm2F6KxuPuby2Kj6WAaNjE2OuhDGa5d8NBmNFRbv
         JWg5qULzrJN5JbOMOTAR/ERFsbD1X2O7EQkOo4otO5Fj3rGpA0GZCLJrSaXbK/SxMNPL
         NWf7XUbg9jCAM/DIsmULrIcpvC87vshDrwCnAFgvaJurDASbP2YbCuhclwELrsDULipo
         OUMOFQpAujnGPHBlbzwKOPGRvhk2PEh9BIC6RrgJLi+yvvzhjq4XxBoiBDKl/+Mt8rTC
         jXAQ==
X-Gm-Message-State: AOJu0YwjSGhKxqK/MMY+x1JHZcM2DxdcayfErR62HXJgAiDGXpQC1p0f
	R3EUgx/CegirxO77Cu5qfb2vxiBswj03QLriWxpIFHh5rYIqvxaxzt5WGlSbQ1JWBpEk3fdyaVu
	sJtzPqDp4KRajiEWfnYMhpJvCzB8=
X-Google-Smtp-Source: AGHT+IEER+boocRs/NS7M822FtcaWPrj8sMSvRS4qoOIpUbIh5ZHiI0EpUv9+Gk6TdhO+KkNGIHwm1zksL4EPPoefgw=
X-Received: by 2002:a05:622a:5a88:b0:446:33dc:7e3f with SMTP id
 d75a77b69052e-451d42fc219mr30186881cf.58.1723126986770; Thu, 08 Aug 2024
 07:23:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c4f1d8bf-745b-4a98-9d38-2da4c355d691@gmail.com>
 <66be75a6-2d3f-4f5b-96da-327556170c4a@gmail.com> <e39131ce-1816-49e1-8319-820472892a38@gmail.com>
In-Reply-To: <e39131ce-1816-49e1-8319-820472892a38@gmail.com>
From: Anna Schumaker <schumaker.anna@gmail.com>
Date: Thu, 8 Aug 2024 10:22:50 -0400
Message-ID: <CAFX2JfmSE-_Vxw8NogUAzxDSZWY0nm1=DdyCgeUVAh-U7HNU3A@mail.gmail.com>
Subject: Re: NFS client to pNFS DS
To: marc eshel <eshel.marc@gmail.com>
Cc: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>, Trond Myklebust <trondmy@hammerspace.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Marc,

On Mon, Aug 5, 2024 at 5:51=E2=80=AFPM marc eshel <eshel.marc@gmail.com> wr=
ote:
>
> Hi Trond,
>
> Will the Linux NFS client try to us krb5i regardless of the MDS
> configuration?

My expectation is that the NFS client will use SECINFO_NO_NAME to find
the preferred security flavors of the server. If krb5i is first on the
list that the server returns then that's what the client will use.

>
> Is there any option to avoid it?

Yes, you can use the '-o sec=3D$FLAVOR' mount option to mount with other
security flavors. Valid flavors are 'none', 'sys', 'krb5', 'krb5i',
and 'krb5p'. I hope this helps!

Anna

>
> Thanks, Marc.
>
> ul 30 11:10:58 svl-marcrh-node-1 kernel: nfs4_fl_alloc_deviceid_node
> stripe count  1
> Jul 30 11:10:58 svl-marcrh-node-1 kernel: nfs4_fl_alloc_deviceid_node
> ds_num 1
> Jul 30 11:10:58 svl-marcrh-node-1 kernel: RPC:       Couldn't create
> auth handle (flavor 390004)
>
>

