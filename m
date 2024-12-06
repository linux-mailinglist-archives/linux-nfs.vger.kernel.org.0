Return-Path: <linux-nfs+bounces-8392-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CCBB9E75BA
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Dec 2024 17:20:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B599188A076
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Dec 2024 16:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C6220E024;
	Fri,  6 Dec 2024 16:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lMXHAqS/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41FBB20DD66
	for <linux-nfs@vger.kernel.org>; Fri,  6 Dec 2024 16:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733501793; cv=none; b=TL8810S1Hg0eQFo0xAIU+Y7G+JZ6fnil1RXO6B7WFDgVjsoLa4Gtc92a03eE8SX68it82wXkIW30coVRtzabN1Y3it4HdtEPxCBev865sWaW065F77aeMoxoi+toMUMAeLOR1oQOVT8pnW0nQfyEIdu2vVyQHtAFdVkYIemtjrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733501793; c=relaxed/simple;
	bh=Of2G71/bQ5GMKPoOH2dIfUlLFdAb5PCRLCx1lizA3BU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=VlHcq3mJAEs/gLQOXtk79LFJoKyigVxVsF+32N2/pl8Wamc7UA433soZqz1pQieVcCP2De9G8wPSUtOLttMckv2WOLuZBdv3/ZHcQkQfOGN5eHLzMa8V5EiH0Zpq7V1F1nc4F757d0hkC7MaABQlV/RzflBWdAKYYp2oR5Dix8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lMXHAqS/; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7fd1403fcbfso1713596a12.0
        for <linux-nfs@vger.kernel.org>; Fri, 06 Dec 2024 08:16:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733501791; x=1734106591; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Of2G71/bQ5GMKPoOH2dIfUlLFdAb5PCRLCx1lizA3BU=;
        b=lMXHAqS/8WnnxC9WPc0D3R+fctWaYAt7VDDwpULHSoyer4hzgfyyNQDwLLh4fqpt+b
         H07VDzGuVwBVG0VfiyE+pbbzMGS4LcKCETRoj5kYliWnw3HDxRIjBNR5J2wE9PBD5lau
         0iO8rLwFm8lB8jOKDlARv2TIMVJjp9bmBrDzMHwhiV1Uw94UkrFcR0evwCXIyC+BDBUV
         f2WdMIBOKOe6+p+5kC+kQKRSF9dCtjz42qdvFaMX6rEkc9EYCX869bN+obsnIccAp+I7
         MPXBDhKsQb5QecsDx4dQZqqJGYG6UcmvV73811kSmuHdejj8h5yszzmDenv97dCqpou0
         XsBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733501791; x=1734106591;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Of2G71/bQ5GMKPoOH2dIfUlLFdAb5PCRLCx1lizA3BU=;
        b=HkZA5QBls09q/6crO40hroz4bLRgGCqVcLErgAcMr/1ADVG1SkN/n1mA8C0x7HYJp1
         6jimwhZRFSSeMYES0+WCRGYq9xY2789OCbKQeV6sBj4pDsziJmKLDAFpq/+UQfonW3E4
         6awe2wki7hTVi3FL/qF3c1+wblXwf4NX5/S8xci+OzEL02WvRhfHGQTNX7ZDFR20bWfh
         elvYzugswCyyngx6T8laIBFjeFB4PGKMZAyi0S2zgROj1uXwP8FVJRU1SSurTHDYuaDl
         m8g9RSw1/sKDfFPY19DPtgDen8EiK9wbY26K4UEMShJzTtR3bvQmAEAgOuzZ4yvyWacn
         8yXA==
X-Gm-Message-State: AOJu0Yx+DaY/LoaZymAMy8miXlbB5E25grVgFRYp+82qgvygfDySP/4v
	NVYdI6X9CY3fbhc/wkFDxxKnocJP7LY3NcsqYYDvh9wKUqwZUMFJ3nViMjscXdY5bM03EJFop//
	Z8GFeNJCvg8m0cuk1rqtHGJ9ZBe5DSQ==
X-Gm-Gg: ASbGncsIam+azYmTZZHZajovNgJLp+YrCxcMn4cgx0hQX5EG+6Gk3MOWtHWLRf/y9o9
	rX9+/fbsdu2kpROmAb78uKWAsyHktTsc=
X-Google-Smtp-Source: AGHT+IGjFmsIGyM0vST2e5QU35YoMGWHSPrErAgCV/nK7KQncr8qL28b6sP/m/XXqhrPHwmhprx8GPwAa+qjxa3ZE6E=
X-Received: by 2002:a05:6a20:7284:b0:1db:ef68:e505 with SMTP id
 adf61e73a8af0-1e1870cb327mr4904838637.20.1733501791338; Fri, 06 Dec 2024
 08:16:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKAoaQmaf7d01vK4TfR+=8k4CVN-CX3ESPFh88EaxvcOAQDWtQ@mail.gmail.com>
 <fb7bf50a-29d3-4543-90e8-617fdd205f76@oracle.com>
In-Reply-To: <fb7bf50a-29d3-4543-90e8-617fdd205f76@oracle.com>
From: Mark Liam Brown <brownmarkliam@gmail.com>
Date: Fri, 6 Dec 2024 17:15:55 +0100
Message-ID: <CAN0SSYyzWqp2CMziwQ9dGQ8X4+cL42P78oLZDZDrxbPTK_racQ@mail.gmail.com>
Subject: nfs-utils library dependency littering - fork nfs-utils for Debian?
 Re: [patch] mount.nfs: Add support for nfs://-URLs ...
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 6, 2024 at 4:54=E2=80=AFPM Chuck Lever <chuck.lever@oracle.com>=
 wrote:
>
> Hi Roland, thanks for posting.
>
> Here are some initial review comments to get the ball rolling.
>
>
> On 12/6/24 5:54 AM, Roland Mainz wrote:
> > Hi!
> >
> > ----
> >
> > Below (and also available at https://nrubsig.kpaste.net/b37) is a
> > patch which adds support for nfs://-URLs in mount.nfs4, as alternative
> > to the traditional hostname:/path+-o port=3D<tcp-port> notation.
> >
> > * Main advantages are:
> > - Single-line notation with the familiar URL syntax, which includes
> > hostname, path *AND* TCP port number (last one is a common generator
> > of *PAIN* with ISPs) in ONE string
> > - Support for non-ASCII mount points, e.g. paths with CJKV (Chinese,
>
> s/mount points/export paths
>
> (When/if you need to repost, you should move this introductory text into
> a cover letter.)
>
>
> > Japanese, ...) characters, which is typically a big problem if you try
> > to transfer such mount point information across email/chat/clipboard
> > etc., which tends to mangle such characters to death (e.g.
> > transliteration, adding of ZWSP or just '?').
> > - URL parameters are supported, providing support for future extensions
>
> IMO, any support for URL parameters should be dropped from this
> patch and then added later when we know what the parameters look
> like. Generally, we avoid adding extra code until we have actual
> use cases. Keeps things simple and reduces technical debt and dead
> code.
>
>
> > * Notes:
> > - Similar support for nfs://-URLs exists in other NFSv4.*
> > implementations, including Illumos, Windows ms-nfs41-client,
> > sahlberg/libnfs, ...
>
> The key here is that this proposal is implementing a /standard/
> (RFC 2224).
>
>
> > - This is NOT about WebNFS, this is only to use an URL representation
> > to make the life of admins a LOT easier
> > - Only absolute paths are supported
>
> This is actually a critical part of this proposal, IMO.
>
> RFC 2224 specifies two types of NFS URL: one that specifies an
> absolute path, which is relative to the server's root FH, and
> one that specifies a relative path, which is relative to the
> server's PUB FH.
>
> You are adding support for only the absolute path style. This
> means the URL is converted to string mount options by mount.nfs
> and no code changes are needed in the kernel. There is no new
> requirement for support of PUBFH.
>
> I wonder how distributions will test the ability to mount
> percent-escaped path names, though. Maybe not upstream's problem.
>
>
> > - This feature will not be provided for NFSv3
>
> Why shouldn't mount.nfs also support using an NFS URL to mount an
> NFSv3-only server? Isn't this simply a matter of letting mount.nfs
> negotiate down to NFSv3 if needed?
>
>
> General comments:
>
> The white space below looks mangled. That needs to be fixed before
> this patch can be applied.
>
> IMO, man page updates are needed along with this code change.
>
> IMO, using a URL parser library might be better for us in the
> long run (eg, more secure) than adding our own little
> implementation. FedFS used liburiparser.

Yeah, another library dependency for Debian? First you try to invade
Debian with libxml2 via backdoor, and now you try to add liburlparser?
At that point I would suggest that Debian just forks nfs-utils and
yanks the whole libxml&liburlparser garbage out and replace it with a
simple line parser. Does the same job and doesn't litter Debian

Mark
--=20
IT Infrastructure Consultant
Windows, Linux

