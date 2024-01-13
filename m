Return-Path: <linux-nfs+bounces-1068-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8BA382C8E7
	for <lists+linux-nfs@lfdr.de>; Sat, 13 Jan 2024 02:47:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 315131F240E0
	for <lists+linux-nfs@lfdr.de>; Sat, 13 Jan 2024 01:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0D6918EA9;
	Sat, 13 Jan 2024 01:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WbkM26om"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B59718EA8
	for <linux-nfs@vger.kernel.org>; Sat, 13 Jan 2024 01:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-50ea8fbf261so8162940e87.2
        for <linux-nfs@vger.kernel.org>; Fri, 12 Jan 2024 17:47:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705110470; x=1705715270; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=J0fXsJ/qozZ5kkp+MKoenG1fBDfXLwSPNMtbUedO8wQ=;
        b=WbkM26om4IDnQEster5H0j97LqVZmTW3LBChXBq4Y/ouQa0arjqbVs6KMMFSW2Q5Hz
         Cu5S7qQ2F8syajeGv83wUgd9BmGqPNrUECbnYo7BwaIW8Nz0ENGAm73Et/CRAePsOs2N
         ChYiOcHmp5pTW2J2BUEIwtYIIEbdhDnaCaXThTjwstJSxoXIMzEbrsxA0cDun8uUms8Y
         Ok4fEfB+CpB2sUq3+vxid98gNt4fvTbSAS/0MMwyvLJo+eXCT5BoCzK7LUTXLIQ6bZjf
         sIwfEb04T+cE1ng8B+fAUK0VJl03lJFRfiJrVHQ98sLA/BM5iGoQu1l80angeRfpn61H
         aMhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705110470; x=1705715270;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J0fXsJ/qozZ5kkp+MKoenG1fBDfXLwSPNMtbUedO8wQ=;
        b=KJ5F+tRds3Q4mzjTP4f/MGDkPX7heJ2IB34JJnCeixbVsrinwi3KuXBImHQbfhOR84
         5TBbabRi3hVQ90FlCGbbcr+P9R7TzC+IBjln8AUPd4rYCTx3762tGrH1WcN7lnCCRRbM
         K4TtPEeYqr5d9h1/Q7YGAcjMphuEDkG+fa2NGl+3VmLgy/655znR1HHdPm8LlLJKe1z1
         fNkMaHQAvMtLyBX7/migOBNAYFL+r3fYZFxaYZwg5X302VFMpbtX+Qw4H7q9aAgC6keU
         JnTMBWpZGU+yMsMNnnis2dPqjlt5aa7vlPYv2LXc+lcKZt2XAEH7q8wE4sUjRBUMyT4Y
         pf4w==
X-Gm-Message-State: AOJu0YwLT4t+cEq3FvelQJ6p0Oiv+K6FzwNMzKPzFClFGNmxxAIqnBnE
	3eazY8bkCdpiIA+dTHUOvzPdphOOzLi0OLF/p991/Hl7lEY=
X-Google-Smtp-Source: AGHT+IGnakJ82h2TQdtAM24w3pcIUGdJxeT40gornRD7VqD6Tk3F+8++EMTAKLAwp7onNNh2h/N01n/cp56nceUldKs=
X-Received: by 2002:a19:4f53:0:b0:50e:b3dc:3ea5 with SMTP id
 a19-20020a194f53000000b0050eb3dc3ea5mr996153lfk.66.1705110470353; Fri, 12 Jan
 2024 17:47:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAvCNcDtTNDRvUVjUy4BE7eBCgmkb6hfkq3P0jaGDC=OXg0=6g@mail.gmail.com>
 <89fba598b0b93cf97bf208e106001f74eadd1829.camel@kernel.org>
In-Reply-To: <89fba598b0b93cf97bf208e106001f74eadd1829.camel@kernel.org>
From: Dan Shelton <dan.f.shelton@gmail.com>
Date: Sat, 13 Jan 2024 02:47:23 +0100
Message-ID: <CAAvCNcBSW7ZH4LpSLLo+Bmh2kQ=w5sFrLJ-PKDDSBKwkS5fd5g@mail.gmail.com>
Subject: Re: Increasing NFSD_MAX_OPS_PER_COMPOUND to 96
To: Jeff Layton <jlayton@kernel.org>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sat, 13 Jan 2024 at 02:32, Jeff Layton <jlayton@kernel.org> wrote:
>
> On Sat, 2024-01-13 at 01:19 +0100, Dan Shelton wrote:
> > Hello!
> >
> > We've been experiencing significant nfsd performance problems with a
> > customer who has a deeply nested filesystem hierarchy, lots of
> > subdirs, some of them 60-80 dirs deep (!!), which leads to an
> > exponentially slowdown with nfsd accesses.
> >
> > Some of the issues have been addressed by implementing a better
> > directory walker via multiple dir fds and openat() (instead of just
> > cwd+open()), but the nfsd side still was a pretty dramatic issue,
> > until we bumped #define NFSD_MAX_OPS_PER_COMPOUND in
> > linux-6.7/fs/nfsd/nfsd.h from 50 to 96. After that the nfsd side
> > behaved MUCH more performant.
> >
>
> I guess your clients are trying to do a long pathwalk in a single
> COMPOUND?

Likely.

> Is this the windows client?

No, clients are Solaris 11, Linux and freeBSD

>
> At first glance, I don't see any real downside to increasing that value.
> Maybe we can bump it to 100 or so? What would probably be best is to
> propose a patch so we can discuss the change formally.

OK. How does this work?

Dan
-- 
Dan Shelton - Cluster Specialist Win/Lin/Bsd

