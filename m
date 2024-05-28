Return-Path: <linux-nfs+bounces-3443-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B4C68D1CF0
	for <lists+linux-nfs@lfdr.de>; Tue, 28 May 2024 15:28:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B085284453
	for <lists+linux-nfs@lfdr.de>; Tue, 28 May 2024 13:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C8A516E87B;
	Tue, 28 May 2024 13:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="Wm1QN3Ry"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF50E16E896
	for <linux-nfs@vger.kernel.org>; Tue, 28 May 2024 13:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716902913; cv=none; b=U37zfcrXkqMayB6nG1GMeLqIOZPEw4JlPVXBo5CYu4Hil2zL2o5Q3uG2Wy7Di0Wz6hsxEhfG89iKAM0Qflpo5DLwsSgaLm5aP2mEMdpVMVK9Ixhfvh5AqecleGURWzZu2lPTHxbf6pDULOu+93rw/z1Y1y+tiLC9FC+ooucPLik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716902913; c=relaxed/simple;
	bh=PBBLOV4U2IFgFSKdFT4Y43aEoeT6Ow1hJwKRcZckZ7w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AI/v1+qhLXZSuHiL+dI3xBlo+TPMGpfWeWQuCgJBQvseSJR18q4TPkptYonDvjLavklzumeDqABLo/yYA8MpnD5vBlPXSqKPFLTaqhjaiTWsNhoFGt5MPtAFuq6d+TUVwBWp/fOsLiRZSa1KnzT4cdMT5jyUMqLQ1ebwX4yTLCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=Wm1QN3Ry; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a633ec1cecdso81604466b.2
        for <linux-nfs@vger.kernel.org>; Tue, 28 May 2024 06:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1716902910; x=1717507710; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PBBLOV4U2IFgFSKdFT4Y43aEoeT6Ow1hJwKRcZckZ7w=;
        b=Wm1QN3RyfSowp3OP685y93x0QSYnT927aLF6A0cd+Dr/PPr3kY9GeQaKnWyWwIqKEi
         kSOmSfvQGe/RlzTCV8BXz1hM78yQtJgcvRvsgU73ezbBBMY2GvU/lxelFVGj8Hm3F8R2
         WtI+cRhoXatHfGMVm6zMu6kO2ofAGu6bZ0Hos=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716902910; x=1717507710;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PBBLOV4U2IFgFSKdFT4Y43aEoeT6Ow1hJwKRcZckZ7w=;
        b=ZtGZ7/L8/+Ti2UDoXaipVbHxuyVPCK4Ke89hQP2zA4Wawo0PTtKNdPXuao42z9Z06D
         yQOe5OdtmDGzOMRaKTqHsw9jsLfkobaIEbbwYsujej2TmzEOBi9fMBESkJf0B8g3OFdk
         JKxr5fDm2HIir0ithjiUUKYCaSwlJEEpsAbxzqOGgIx4a1j/R8w6P5x9oBrLO4LJmmnf
         aIqQGU/5w+zm8HFoxmJl7+KtnNCnh6O2j8HRtYkioHSrOZ2jQkwzeUx/83cI09PqsJyW
         R/oInbrBUvAERKqkJqM/+Wpii3GfUgbLbgQTL9Uc4Um/ltJerWSLvkyTtpwgNLCQ+AuD
         r/Bw==
X-Forwarded-Encrypted: i=1; AJvYcCXvEk6HmjPNSdNV2dtcYG5dHeOtnQH/vQrB10E/W0RDeFNnBaXUyJUORWGWBj+iF4xE82zsLRnsniihxhl/JNNrOyc2Me/G4S0l
X-Gm-Message-State: AOJu0YwmOAOj5RLzTP1NssulNcY3E9BgPMMpBLP+zAf7bKQrMlSnEgxv
	FNhpw8Eslkx27d4N0OJAN5s6xEGc+EUYMEBDqz1GRpSXcKILOZEkk6B0iolRchIKHa9YyHqD4yG
	SgGOKB+Gxxpf1HMafL6GpR3PhMIL+U62IumtQSg==
X-Google-Smtp-Source: AGHT+IET1YleTWVR5AXg8CRN1Esbkyz90K8kriJOg4HbyfAsDwmoVK/cGg98h3bhg32ByJBXHFEIavMxNd8QwGr8f7g=
X-Received: by 2002:a17:906:788:b0:a59:adf8:a6e1 with SMTP id
 a640c23a62f3a-a62651144f1mr794014566b.47.1716902909983; Tue, 28 May 2024
 06:28:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZlMADupKkN0ITgG5@infradead.org> <20240526.184753-detached.length.shallow.contents-jWkMukeD7VAC@cyphar.com>
 <ZlRy7EBaV04F2UaI@infradead.org> <20240527133430.ifjo2kksoehtuwrn@quack3>
 <ZlSzotIrVPGrC6vt@infradead.org> <20240528-wachdienst-weitreichend-42f8121bf764@brauner>
 <ZlWVkJwwJ0-B-Zyl@infradead.org> <20240528-gesell-evakuieren-899c08cbfa06@brauner>
 <ZlW4IWMYxtwbeI7I@infradead.org> <20240528-gipfel-dilemma-948a590a36fd@brauner>
 <ZlXaj9Qv0bm9PAjX@infradead.org>
In-Reply-To: <ZlXaj9Qv0bm9PAjX@infradead.org>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 28 May 2024 15:28:18 +0200
Message-ID: <CAJfpegvznUGTYxxTzB5QQHWtNrCfSkWvGscacfZ67Gn+6XoD8w@mail.gmail.com>
Subject: Re: [PATCH RFC v2] fhandle: expose u64 mount id to name_to_handle_at(2)
To: Christoph Hellwig <hch@infradead.org>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Aleksa Sarai <cyphar@cyphar.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Chuck Lever <chuck.lever@oracle.com>, 
	Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
	Alexander Aring <alex.aring@gmail.com>, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 28 May 2024 at 15:24, Christoph Hellwig <hch@infradead.org> wrote:
>
> On Tue, May 28, 2024 at 02:04:16PM +0200, Christian Brauner wrote:
> > Can you please explain how opening an fd based on a handle returned from
> > name_to_handle_at() and not using a mount file descriptor for
> > open_by_handle_at() would work?
>
> Same as NFS file handles:
>
> name_to_handle_at returns a handle that includes a file system
> identifier.
>
> open_by_handle_at looks up the superblock based on that identifier.

The open file needs a specific mount, holding the superblock is not sufficient.

Thanks,
Miklos

