Return-Path: <linux-nfs+bounces-1036-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C2282B15F
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jan 2024 16:08:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C7721F29179
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jan 2024 15:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A00A4F889;
	Thu, 11 Jan 2024 15:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iBjzJcRY"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56FB4CDF8
	for <linux-nfs@vger.kernel.org>; Thu, 11 Jan 2024 15:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-204ec50010eso2947992fac.3
        for <linux-nfs@vger.kernel.org>; Thu, 11 Jan 2024 07:07:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704985630; x=1705590430; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g8WhksAyCBa8d1kSoXwSP+167tJMgrySife7xxT/CAM=;
        b=iBjzJcRYgWL75fnznUed4VdVXqUkndaZGw/J3mHmlCVeOJ/oR4E9XTRcYqc2yHUiKG
         Fi65sIjCp/kMGXYbBI1ZaR7wkBEYOzwxBycnxMd5wE9ITG868j89RLUEe41CglzE0joX
         Bm3mbh4GBEC6hOxLzRJL0caAxoDb42NKVui+Hnvh+vCV4QnY1ubfmQLcVlIYGkdR4Zah
         5qjrUrX5mwEgaN/hrOIXYolUetzTfMqCAQbzlQOUxGYhtKXsqJ4wihm0qnPDzfsBO2Jh
         7Pwhk0NAevi0j/NJ3X0cZn+3+6byo4aMuLTZGPK3hBUubyyzuxL2UuhYLg73G7rHTn3t
         I73A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704985630; x=1705590430;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g8WhksAyCBa8d1kSoXwSP+167tJMgrySife7xxT/CAM=;
        b=vjd3hrgtNt7u3x0OErAqm+X22bT9HnZ3J2T+ermO3sGDPthe9RHV8lqLMIAP6/CY2F
         Xrh4GfuY3+c0Mcq4n5DXfVDXX58i1+BomM7Qjli8RvU39AEs3GO2FPohYT3fDJLFngMa
         tT89gkiJC1zWdu87872G3MyEDBLkZSNT5T88nL9BfvnVBAHqhC9MdRrQX6lrRXoQB7ke
         EGfifeQZ6UoruwObKyv8frClp0eATtiOHKbBFZN/0LZM+woQWQeyzCWbyXMLaQMdCWSu
         4oS3pePnNe3WxythKUYJxiXx3ETo7m2FuagiAtKMiQgREOqQo5CBHOLuIvufFdD/pR/s
         Y6Og==
X-Gm-Message-State: AOJu0YzqyotRHkxuYCJB81AySbxwp+WYqiycZIpJUPcj53CTtPxxEgn4
	PusELUQCTa+WbD6O8EPH4+iEUqr1kciiIKk+Bdd6fXgw
X-Google-Smtp-Source: AGHT+IHZbmaT7YGpKnzsWH/L8N5LXUtbvVg/MgBTxCtUTt4vyxko0XWqLdd97eq79Xn5237+du5rQaYv5fAqJL3AS6o=
X-Received: by 2002:a05:6871:8783:b0:204:9e3:184a with SMTP id
 td3-20020a056871878300b0020409e3184amr1421213oab.60.1704985630654; Thu, 11
 Jan 2024 07:07:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALXu0UdFR7Xn51eKFUUi6a68wvDKc-RXz7F4LKyQgDptqfYbgw@mail.gmail.com>
 <CALXu0UfSJ0Qc3HOecf4pQ=VnEVqxRw6OGzNwhh9BUVYaHV7_oQ@mail.gmail.com>
 <ZZwJLb7j65QXR1+K@tissot.1015granger.net> <CALXu0UdJanF-_=3TzgzUskwh1RGPjw+LeZ0Cht+yP1aQgr8v+w@mail.gmail.com>
 <B5750E41-D130-44CF-8446-EC71BB149E7D@oracle.com>
In-Reply-To: <B5750E41-D130-44CF-8446-EC71BB149E7D@oracle.com>
From: Martin Wege <martin.l.wege@gmail.com>
Date: Thu, 11 Jan 2024 16:06:59 +0100
Message-ID: <CANH4o6Mr0UxFboUZE8QurghWDQmqHmFf6nstgdsi5BXeV-Z7dw@mail.gmail.com>
Subject: Re: nfs-utils&nfsd&autofs not supporting non-2049 TCP port numbers -
 Fwd: showmount -e with custom port number?
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 10, 2024 at 4:11=E2=80=AFPM Chuck Lever III <chuck.lever@oracle=
.com> wrote:
>
>
>
> > On Jan 10, 2024, at 1:06=E2=80=AFAM, Cedric Blancher <cedric.blancher@g=
mail.com> wrote:
> >
> > On Mon, 8 Jan 2024 at 15:39, Chuck Lever <chuck.lever@oracle.com> wrote=
:
> > If you look at Solaris BUGSTER (remember, we were a big SUN customer
> > in the 1990/2000, so we had lots of bugs open for this mess), you'll
> > find lots of reasons why one single port for NFS is not feasible in
> > all scenarios.
>
> > Just some examples, but certainly not limited to:
> > - Fine-grained HSM, all on one host
> > - Fine-grained project/resource management, i.e. one nfs server per
> > project, all on one host
> > - Competing teams
> > - Hostile IT department (e.g. port 2049 blocked out of FEAR - not
> > reason, no further discussion/negotiation possible)
> > - NFSv4 tunneled via ssh
> > - NAT, e.g. private IPv4 address range inside, only one IPv4 address ou=
tside
> > - IPv4 address shortage
> > - Software test deployments in parallel to the production systems, on
> > the same machine
> > - ...
> >
> > In any of these scenarios you'll end up with NFSv4 certainly not using
> > TCP port 2049.
>
> In most of these cases, the use of alternate ports has been
> superceded in the past 20 years.

From a viewpoint of university hosting, HPC environments and pretty
much everything else I've seen, that statement is FAR from reality.
This even gets worse in Germany, Europe and Asia (not US of course,
you're hogging public IPv4 addresses), where we have IPv4 address
shortage, lots of NAT, and only a small amount of IPv6 (except Asia).
In all these scenarios you have NFSv4 connections all over the port
numbers, and not only 2049.

Also, reality is, storage virtualisation for NFSv4 on the outgoing
side is typically done on the port level, and not IP address level,
e.g. many servers behind NAT, and NAT then translates the accesses to
the NFSv4 server into a single IPv4 address with different ports
(because of address shortage). And because of convenience, the NFSv4
servers start with the same port number as used by NAT on the
outside...

Short: Non-2049 port number are the not a "corner case"

Thanks,
Martin

