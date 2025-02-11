Return-Path: <linux-nfs+bounces-10039-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E3AA30C14
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Feb 2025 13:54:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5E827A121E
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Feb 2025 12:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFE3920C47F;
	Tue, 11 Feb 2025 12:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U1zCfbgI"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D08B1F12E0
	for <linux-nfs@vger.kernel.org>; Tue, 11 Feb 2025 12:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739278490; cv=none; b=BanoA/hO/BAQY9xe4/4rsRiA/zUMO5cvfN1o0rj+u0yR7cIi3SWYXPHudOg+YV/QTX4cayNfPYkXjfX0POYQ7AB6BPbkmXXrZvMBh0OL2+c2jtX2c5pyRTZOqcjUUAtiuDeodrZRYKXkjRPPUBEPUWqQzNUkmubdaIsSNT86JtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739278490; c=relaxed/simple;
	bh=QzC0E2D2kJ2srk3rDlz2XUBTwXAqVdwWLdhPMBzybSA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=e+778sWeNfNNQ74rxoOKyjPh+rTAmO5KdOq91b8DAJvwUTKF0MakPXLkIgLP3t/P/YFBa98DOdzLiNn5vMggLlHv77i8y9toLfv443R+m3KVYrFP5T9XadrZ5Bt9zeYIho7vWB0tBuBz0yFdG4leeubLNKeqYpKqOZ/bGR33c5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U1zCfbgI; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ab7ca64da5dso313107766b.0
        for <linux-nfs@vger.kernel.org>; Tue, 11 Feb 2025 04:54:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739278487; x=1739883287; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QzC0E2D2kJ2srk3rDlz2XUBTwXAqVdwWLdhPMBzybSA=;
        b=U1zCfbgIp3XBYA1PiR8BsyGIP9CgnElBc+tXdwugNtaDtqDpxnbFrSlKrLogK97AYz
         1Z4Rw/4+w3UY2FLN4zJSfCFCdoBVu00iyWlyvGBYknbhRfF2sOfP/RHDqJXaT9s8z9YH
         0et4XlRwcgV8ecvaS0co5xrVqzHLf01UAW85ectNItw96TbB4UC6GQcviz1StuaJwMh6
         m/PZGk0Xv3Tri2vN5T7t/Uj7eDFe2uvjPyn0yDDqAHOG/DkSCjrAp/pcjIGP18E6rjEt
         yfp7KOF+RQqVh5XFB31EwK7MePmuQp/UFIcmjI3387ML2ij1c7Reh7Gz96bdaeekERnE
         LpAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739278487; x=1739883287;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QzC0E2D2kJ2srk3rDlz2XUBTwXAqVdwWLdhPMBzybSA=;
        b=HUTXz8CL9OkfMiNr/ILWfHp9g33/CVxOpszJr79EeylmaWSxfFjUJVhCi0T2x68S4N
         jmsZJ51hhbDghDuGHyL4arpMJe/zP7OPPcJ0LT+4IN/jFz0bLwdfqvKIvY5z9RdCBF7O
         +7LcTQx4BggOZVh3nlQjH5dtJJj/EK7HBblB/Fvistg9Ns9MLfCMhflxAX3OUPWK7hEr
         XlbulLikals4KhY5fXkUBqX8Ki19gykfv2WDDi8/4T4tkaCxLLh9FHZUVEfCnOfZegt0
         pZ6tKc4bxdAlDR7+TuGkdEqEqToq6e7b+hnDMh6btwYGK1wtTZ2TAB0AOjreudHtoSIk
         ALTA==
X-Gm-Message-State: AOJu0YwwSzMCwsU2uwXyWpnmszPvo2XnY9sL1WcXAO4UGiHglcWt7ePD
	QAmAnmTOC99T47TpBaKzT915JLmuw2Dc/aevF4DN38KwczCK6HNCFNDO0RsRbzsURi4SI/mDmj6
	CnOZRaDWaCKdpAksFRqzaiQk5sWrPJiNe
X-Gm-Gg: ASbGncsRscq77LLrF2jt+7SwNDejBwT2EVDmwxjpI3N2UDdD2rcfVk/9tYn27Did4vK
	6yWxCNrbgQUaiyaeRFTkXnQSPGKCtqNZ3kt+2l15As5987Tcm1HazZY/0KTwEnOy7fUzpSvuP
X-Google-Smtp-Source: AGHT+IHbaLnfuJsVLaemjS1Ar9Dt0rkFzwsKacLTUBnIcjBsqKdqRROuYchfTPLAJHYAoN9uB9Zr9oBB+0vtQvey8L0=
X-Received: by 2002:a17:907:388b:b0:ab7:9101:e480 with SMTP id
 a640c23a62f3a-ab7dafef650mr315212966b.11.1739278487136; Tue, 11 Feb 2025
 04:54:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Martin Wege <martin.l.wege@gmail.com>
Date: Tue, 11 Feb 2025 13:54:10 +0100
X-Gm-Features: AWEUYZkA93B65ut_sqIjj-yleKtVbYwvnLnp9EjrO1UpMsqKKRIHJs9WE9Lu6dg
Message-ID: <CANH4o6P5mXTR6dpKCKHHrF4jcAL=wWoy3AWK6vateUHphSPvqg@mail.gmail.com>
Subject: The (sorry?) state of pNFS documentation?! Abandonware?
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hello!

Is there any up to date documentation for pNFS server support in the
Linux 6.6 kernel?

For example: https://wiki.linux-nfs.org/wiki/index.php/PNFS_Development_Git_tree
says "THIS IS OUT OF DATE. The particular pnfs code described here is
no longer under development.", which sounds like pNFS support in Linux
is abandonware.

Thanks,
Martin

