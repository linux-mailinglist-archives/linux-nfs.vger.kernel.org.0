Return-Path: <linux-nfs+bounces-12362-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20588AD6A0C
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Jun 2025 10:13:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAB2E3ACC26
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Jun 2025 08:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD5B720B81E;
	Thu, 12 Jun 2025 08:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eWoaO/1n"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1532147EA
	for <linux-nfs@vger.kernel.org>; Thu, 12 Jun 2025 08:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749715989; cv=none; b=Zwlom9+ZruhIBYDlHB9Ti/EDQWfN6616B5hIZCsS7ezPzhX/mzKIEUGNC1Ru7JA4wQXidF52ZNFBUL7/8zNTCeaWywhi+gN2cOaNkwP2aYz7CvmU9oM9eWw4GiOc7hnDUyquZdxjQAjA1JLGiXJ3leAH+mR8dj4MLeAr3/G2M/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749715989; c=relaxed/simple;
	bh=6eDB6H3JPFgCq0QR1UkS+Vy0hi2aavexCAemSHWDQ8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F8NkwIrQazTmqAsujEhhj20RW9WMzF39VqzB8P1ivW5KqdawrXrFfJANx6SbFdjqqskutI2Qo95+J4frADPORqSTKbp4Dw2gS5z9nb0QpsX8F7E7lXVfy2iXELF9Z9yjl5cNxJFkwtZpyhBDmc0anI930X52GaOqp1gHMb9TxoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eWoaO/1n; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-54e7967cf67so581098e87.0
        for <linux-nfs@vger.kernel.org>; Thu, 12 Jun 2025 01:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749715986; x=1750320786; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ue1nOz1SV5eMUAdwkdywmofTM2Xv9iF8EKYemNFSAqE=;
        b=eWoaO/1nBFpeIXNbBY1AAnfB9yCIJHQWID79268+kH/yC+2Q3zuqBAO9jMpAXsYmk6
         NYFYiuxiMXqkRU7Njen1RwQrJxOVu6BuXgDlQPt5g/alfGEkOhCg8b0cnhgZ2ML+igXj
         BpjuDBdd3vo8UE2K0RdJ78cPzgGHaR8uLC5+lrhLakW3Zk81XFgNltOgDiDAGB5jthY5
         Vh9cqoaYe/u91rMTyTd5i9W6O4+hhb1oiw2RGYqeztQgibz3u5XkfAtXsu9f4D2y4P4v
         JeRzYJj3fDzm7GPIzG32qrJOhUzyRDI3cg0b+KdNC7no4q/mLPJ2QSpXXqEEYNZHtaSK
         HWcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749715986; x=1750320786;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ue1nOz1SV5eMUAdwkdywmofTM2Xv9iF8EKYemNFSAqE=;
        b=iv/5Ubc4Y9r/TKCJlcZUEGFI+X0ag70gYAUtgGjP8Us/coeUVx9ZZkWaa0yl2VjNYJ
         PJ3nznYBRvAjXgUJ3SoWvox+50VVN6CZ8IK4W0Zx6qC1ZaV6+jmeWWSVObmF2jIz5iWw
         ilkUYBHPGrG2MpChkBRvwt3+Zhdhdp8wgshsXBclxaByUPyHXyN8fkre68UwJXziqZJO
         09/IsZotaJnagB2QKPP4A39EZ3FzTGnZASEJz8KjqhZ6UYyZPcpmTGNQTyYdZC5tw5Hd
         ok+UwMdebXLJEgRzUKrZTn+KHiWgjtqAnEPPFc3osQ/dU5oUBaeQy8XitE80XM0Cbfrs
         c/5A==
X-Forwarded-Encrypted: i=1; AJvYcCV25W2M9WvAjEHiZEwmOGoubuzDazF1TcB+Wsi5ZN+eupvd0A02EooUAIuyMm4qrEoyvKIatcWiCCU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1CXO3AFvJ4uDBbEr5uj3BSwAdCSbpIPETDYCMWG6rgFPolVQb
	msxdgUFLEZIYCNRb4OSMeGhI+Iq9NroeN6XM8dIctIqleehXGHr7geo/XOVXIulJ
X-Gm-Gg: ASbGncu5tE83XNfvTGYOkhD5JfhPb5b8nxODMKXcP3gLCYhHMbbcSdLiZvCgB8Q0ZUw
	pMUyej2jxGsb0eNx5xzjvMPyY/907qhAxfijzXOBCL8m27schSrU846x3qzxfSMQrRfwKePf7Xm
	uogQMUMGjJKwpI9FddeTlWU2CAp3mPiWKEqDNdtj568+yOzb4zsTiCCse2qaovqnqmPRGXMJExO
	d15YZ3m3xbcSb+1wOzSZHiQSqKaN4iEcX1I799csDa5pfTrFYiARX3i8PucM7hUaFuTfnXpgXOk
	DNNSyIBY6INq4CbUCX+s2fV6VKOiTinPbAnd/v9r0+3wOOPiZy0gP5qd/SpKbIpxPO9LYpeWgbD
	j3TizjjYYXYO1Cg==
X-Google-Smtp-Source: AGHT+IGuzzS8xXdiqvrIfgqVxYZG5+HUHnT6ogD3REH6J3gaJLbHw0JgNkRemcLpQmhtFfPvp5xj5w==
X-Received: by 2002:a05:6512:ea9:b0:553:302b:85a7 with SMTP id 2adb3069b0e04-553a6b81a49mr493361e87.28.1749715985524;
        Thu, 12 Jun 2025 01:13:05 -0700 (PDT)
Received: from SC-WS-02452.corp.sbercloud.ru ([46.159.66.227])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-553ac1f7799sm29551e87.229.2025.06.12.01.13.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 01:13:05 -0700 (PDT)
Date: Thu, 12 Jun 2025 11:13:04 +0300
From: Sergey Bashirov <sergeybashirov@gmail.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, 
	"J . Bruce Fields" <bfields@fieldses.org>, Konstantin Evtushenko <koevtushenko@yandex.com>, 
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH] nfsd: Implement large extent array support in pNFS
Message-ID: <al4q4lk46e3lgsprbhbsyousqj2kudz7njsgzmktaz6lqy5rkh@l44cilww6j4k>
References: <20250604130809.52931-1-sergeybashirov@gmail.com>
 <aEBeJ2FoSmLvZlSc@infradead.org>
 <uegslxlqscbgc2hkktaavrc5fjoj5chlmfdxhltgv5idzazm3h@irvki3iijaw4>
 <aEfE-r2dkuDRUKsq@infradead.org>
 <75iqhi3to6gohuo2o4h3cewslcjzsfyrl7l7x2x3qyiaaecjci@uwoeqjubvqft>
 <aEkoTdJttLesPv6M@infradead.org>
 <tt5y3k7rnnrwwbejkkjubfat334syb2rrdm5rchdui3nwd5dmc@kc3l7wygg6rd>
 <aEp0t2i3KXAsqvv6@infradead.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aEp0t2i3KXAsqvv6@infradead.org>
User-Agent: NeoMutt/20231103

On Wed, Jun 11, 2025 at 11:33:27PM -0700, Christoph Hellwig wrote:
> On Wed, Jun 11, 2025 at 03:19:29PM +0300, Sergey Bashirov wrote:
> > > Normal operation should not cause that, what did you see there?
> >
> > I think, this is not an NFS implementation issue, but rather a question
> > of how to properly implement the client fencing. In a distributed
> > storage system, there is a delay between the time NFS server requests
> > a blocking of writes to a shared volume for a particular client and the
> > time that blocking takes effect. If we choose an optimistic approach and
> > assume that fencing is done by simply sending a request (without waiting
> > for actual processing by the underlying storage system), then we might
> > end up in the following situation.
>
> I guess this is using block layout and your own fencing?  Because
> with the SCSI layout we fence right from the kernel path before
> force returning the layout.  The fact that block layout can't do
> reliable fencing is the reason why I came up with the SCSI layout,
> that can.

Yes, you are right.

By the way, even with SCSI Persistent Reservations the fencing is not
entirely clean and simple. We tried a third party enterprise storage
system to test the scsi layout. But it seems that SCSI PR implementation
there is imperfect. We occasionally observed PR_KEYs being erroneously
revoked by the storage system. But the NFS part of this setup worked fine.

--
Sergey Bashirov

