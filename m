Return-Path: <linux-nfs+bounces-3997-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2777890DB08
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Jun 2024 19:51:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5308FB2105D
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Jun 2024 17:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8713974BED;
	Tue, 18 Jun 2024 17:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cKpvqJri"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52E31CAB3
	for <linux-nfs@vger.kernel.org>; Tue, 18 Jun 2024 17:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718733052; cv=none; b=SG/HlseW39c7IQytnc/cnmowug7CLk5ioSo5l8EzepW8ukvtLiKepogngLH8TMHlC30XvVCwzs3Y4SD5tB54rAQYLQrb1cdoYXqQLSvMsO6Y2QMn6rl9DAx8A8smleHjKLzdue4VIYbcDyc9Qom2fgvc0gubvIGaX3iAWPe50qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718733052; c=relaxed/simple;
	bh=AEzO4eXkBnw1GbIUTy0NWBrBbnbcZaIh7OxGLx7g8ec=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gXkbozs0Ut/hqECvjwcNEcL8xycbYiUxV5xB07mgb98lf8WlSrfEL7d6TqK2d/uqBxE/qP+oESBpFrTCt1umrlc+B5lJvdhnP4E5Zwd+V1a7sCzfzsUveI+wMgs1E51q4XnMuy6zVZOI8x2vIGlnV4e6qW/T5y6+tsDt+oPnSgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cKpvqJri; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-52c7fbad011so6646791e87.0
        for <linux-nfs@vger.kernel.org>; Tue, 18 Jun 2024 10:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718733049; x=1719337849; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=umHAucU4OrH4xAFlfOZegDLLveizHbQ/H9TckUNHAwA=;
        b=cKpvqJrisF738Iojd0gYBu4P09anfxbYR4hGgYeRGGWZC7xxP0UvXZDA56UDjSN8iZ
         SNLjxY/qb4IBAcqplIQemi3z0pUV1SP/8Dg6f3jJofi0Db4iKfsr2ri9yvzmIkJrRaaI
         sKuSz7/K3S315KekEXX1HgOHKN1oW2ijQJoxtdtl/Sqfa5bl6t/rjS9spsw4iiMyhXp8
         uAppirqMJLC9bNGVq1+w4ktJA0FgWcqpzcS5oJI3d8eDd8vwuNzMJHFrLdyt8AXHXZdl
         cFmknrwmnv6pZayvAVQlpLe49z6h1zrXZdxW6oy+xUsuoMusi/j6dAi3KNcH/lwVyiC+
         v48A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718733049; x=1719337849;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=umHAucU4OrH4xAFlfOZegDLLveizHbQ/H9TckUNHAwA=;
        b=Z01J4SbnTwLgvG6IiVPVkbTS0RuPzd7TklHJyFFiBsPX3jC6hYuY8/PQqHUfirrh7e
         jELgty9hG6bJguV//F5iooBZDtjcHR2ZpGCw748WPRL37aUE/Uhg5rEHMSWZsUoMQ6Hf
         gMxyfC0/1ZT/8LZi47I+okm7PHGMdUf22l9TeGIaj4x/qdw/NmzejZVxhYlBkWaA8MUr
         6k3v2OXdI+zdHObyqpQUlBeSrNtVZZZc7GOwQNnt2oAf/7NVDwDz2hBIl6JhRWf5GBSt
         wqelz6Ak0MzGyOXk/BZn1hqwUPbZPW49Uz/N8aqU91gfizLu0gsiph9YYWyXon719hMc
         teUg==
X-Gm-Message-State: AOJu0Ywdf3iE0IBTSBesc7rBNGuXw3eS3G4oxmZpHVE5/L1qEDmTuc97
	OBNvZyq+if3DtpSy4BoU1a7Elget6IWyvECneX4RUiLasvu4pxW+PavRQXyX81gQemqi5yybmEb
	kurdH+pF5rdgqANHt8HOrRyFp6cX5zw==
X-Google-Smtp-Source: AGHT+IFyNaa+GMxLz7T2NczpHAHfTAyqw5TaaCOk6eVr5h8LTh5Pxwsgisl4kL083gJHAtsWDjwh2PYW59YiS23wpyc=
X-Received: by 2002:a19:ca14:0:b0:52c:8a12:3d3b with SMTP id
 2adb3069b0e04-52ccaaa251fmr179004e87.56.1718733048708; Tue, 18 Jun 2024
 10:50:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAiJnjrKr65w-DttnyOc+srDweZnpb_LfXMvCCyP64KrzNO2oQ@mail.gmail.com>
 <CAN-5tyF3YHWJPdnqOs6_KhBQOU+QTvWj4YK1gGY6rO4rSHtV0Q@mail.gmail.com>
In-Reply-To: <CAN-5tyF3YHWJPdnqOs6_KhBQOU+QTvWj4YK1gGY6rO4rSHtV0Q@mail.gmail.com>
From: Anton Gavriliuk <antosha20xx@gmail.com>
Date: Tue, 18 Jun 2024 20:50:37 +0300
Message-ID: <CAAiJnjpfujsou1CKv652aeR8Bh4qddtz0B_c1d3VAROor=CY_Q@mail.gmail.com>
Subject: Re: NFS 4.2 multipath
To: Olga Kornievskaia <aglo@umich.edu>
Cc: linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ok.  Thank you.

Are there any plans to add nconnect for all available IPs ?

=D0=B2=D1=82, 18 =D0=B8=D1=8E=D0=BD. 2024=E2=80=AF=D0=B3. =D0=B2 19:43, Olg=
a Kornievskaia <aglo@umich.edu>:
>
> On Tue, Jun 18, 2024 at 6:56=E2=80=AFAM Anton Gavriliuk <antosha20xx@gmai=
l.com> wrote:
> >
> > Hi I have a NFS 4.2 server with 6x100 Gb/s ports.
> >
> > The NFS server connected via two switches to the ESXi host,  3 NFS
> > server ports per switch.
> >
> > Three VMs running with Oracle Linux 8.10 (kernel 4.18.0-553)
> >
> > On the VMs I mounted NFS share 6 times with 6 different ip addresses
> >
> > mount -o nconnect=3D16,max_connect=3D6,trunkdiscovery
> > 10.44.41.90:/exports/lv_prd6 /deep-storage2
> > mount -o nconnect=3D16,max_connect=3D6,trunkdiscovery
> > 10.44.41.91:/exports/lv_prd6 /deep-storage2
> > mount -o nconnect=3D16,max_connect=3D6,trunkdiscovery
> > 10.44.41.92:/exports/lv_prd6 /deep-storage2
> > mount -o nconnect=3D16,max_connect=3D6,trunkdiscovery
> > 10.44.41.93:/exports/lv_prd6 /deep-storage2
> > mount -o nconnect=3D16,max_connect=3D6,trunkdiscovery
> > 10.44.41.94:/exports/lv_prd6 /deep-storage2
> > mount -o nconnect=3D16,max_connect=3D6,trunkdiscovery
> > 10.44.41.95:/exports/lv_prd6 /deep-storage2
> >
> > During test I/O workload (8 fio jobs with different files per VM),
> > looking at two switches I see that single port shows much higher
> > bandwidth -
> >
> > 2 250 000 TX packets per second
> >
> > and rest of the traffic spreads across all other 5 ports evenly -
> >
> > 900 000 TX packets per second
> >
> > Please help determine why traffic doesn't spread evenly across all 6
> > ports, more like 5+1 ?
> >
> > Seems like nconnect=3D16 works only for the 1st of 6 ip addresses.
>
> Nconnect only applies to the 1st (main) connection. In your example
> there should be 16 connections established to 10.44.41.90 and then 5
> other trunked connections are going to be added to the group of the 16
> nconnect connections.  RPCs are going to be round robined over the
> 16+5 connections. 10.44.41.90 would see more traffic then the rest of
> IPs because it has more connections.

