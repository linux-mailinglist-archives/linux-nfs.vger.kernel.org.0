Return-Path: <linux-nfs+bounces-14903-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A083ABB3464
	for <lists+linux-nfs@lfdr.de>; Thu, 02 Oct 2025 10:45:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEBAB542940
	for <lists+linux-nfs@lfdr.de>; Thu,  2 Oct 2025 08:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1873B2E0B5F;
	Thu,  2 Oct 2025 08:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jrgtw7Be"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA6F2F83AC
	for <linux-nfs@vger.kernel.org>; Thu,  2 Oct 2025 08:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759393571; cv=none; b=heIPC1wX+/ydrnvt3cY+SqbaqRd4mR7q50WWNRzYCUph9vXZLjzre7t3wxQvSJMdPoR5Z89Flw4MZcZHEsiZo1p0aIlRWLQDANBOHcPRexAsDJD2VdpAhhlbmVn8D9xTQuZ1sLeEpHFkqjWpI8GV4rZ4UA8hk72djUB0Yl8uqoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759393571; c=relaxed/simple;
	bh=T7kgcZjxtnlk74NBZ+bGpRlFIPd/zBehpPlFs5I+wwQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=CQZe8KNarD6UH1V4FRhJqYGuiMsdzX1fW0SLUWNgt4Pxpi1/xPVG6h9eGb0+QhmqjJVDe+PZfYnuZJFh64g5TtCUN+Idqon9qwmeDonieuXJuaEAa+ssVIHgHnt2Mp1T1fN5xUrNWpGeXURMKJ75vYg5TYhAvlD47JGd3unoMAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jrgtw7Be; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-62fc89cd68bso1287450a12.0
        for <linux-nfs@vger.kernel.org>; Thu, 02 Oct 2025 01:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759393567; x=1759998367; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T7kgcZjxtnlk74NBZ+bGpRlFIPd/zBehpPlFs5I+wwQ=;
        b=jrgtw7BefpiLqCWQjjiT7KiAr9/qnSgM79Ikz7L5WUQEjICpH1NFiFxVlw4Cf6VC2/
         0rkrhMvu1euTAYfOpa5NaNTyi4aZ45j5WPUN1jBEUSvcEXJV2mpk95ChO+ObP9WLqPDi
         JENouMrEen+05l3D/zE2S9nGgnhMRvmgndf3IDww1hvsQK4bXGSuJCAoXskPd6qlEoM2
         FCp3kVikq22krAJFuh6VDgERt+gHMAt5Px6DpZBOoBh55lY6ZP7pqGHi+oaw4wT+ILD5
         XZWyfctjmQRNfJzdmDIO8OM6RdeJj3TtzkGc0hSBItOPSCirCfIAHqNDlWshTfkL6ssq
         N9uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759393567; x=1759998367;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T7kgcZjxtnlk74NBZ+bGpRlFIPd/zBehpPlFs5I+wwQ=;
        b=GXaV6OziM7lh0gX9vnvP3jZv5Wz5wJd7WoHIBLw9BlNFWSCWQ0QqQ4wtiEdLV0nwlS
         46jYoze8GktBhR/hvyiHLsw7nUUjIgem5eMX1NUjcwSr1lL0FE3Awn/6Mex6nVOQy3EA
         mq0Df+tmy23Q2TTIJvl8Wtq/6SfTttiVQLjzqLanfOWXeHlwrPvV/HG5z1olQ4bfJUny
         g1v2Ac5GyayWwET0r/4eTgA86Gp0kDAZ7N2Nl79b3tXo+dZa4Xk7MULDR4SWm32JpqMQ
         puwkyFKOKzggq/vzYkWg8A1PQokCRhtzO3pz9bbTZDWj/yfpv5gQSNikRjb8Rm3yLeLQ
         g30w==
X-Gm-Message-State: AOJu0YwK7V93TeBKEAgj1xyjJDHEo3LwqlGU/pqX3Or1SQm9RctUOSis
	40WsCuz9OTp7xnHnqq4dp7ZAw3XNm36h201SRebu9Y6RTPdQ5W9a3cv5Ix1P924tUp2LB1rVvfq
	8ThhfB0ri8z0ftDjIRCyCJQ9uJR80lbo0Bw==
X-Gm-Gg: ASbGncujIKIfdGmqASetupoGzAkg2tWwMv87lds8cQo0dUXuaDF2/IY8SUKvEwdJM9J
	yQpBjm8RxRDbOO+BHBpM8H3Au13aX6dOf1RztfR5elOsyB2C9FxtqRwD5espoKwaANHOo3rCqdB
	CVUpuxJIfd9sYE6lshlCFUQaIYOaNFKPejNMu8sdbO4f/LVhRWbYCf/nGYWi0q1gb8mlGStMvRS
	b/zjG6REROJQhXw/WN43kNU+oypQKk=
X-Google-Smtp-Source: AGHT+IE8/LX/gv9wXjott91OHYV2+XgDg64SlLZjYbXiYxvT07NYvKopRcM/sw6LFFKE2T7FWqLjC7hsZjvd7+Gnfzw=
X-Received: by 2002:a05:6402:2744:b0:634:ab0a:254e with SMTP id
 4fb4d7f45d1cf-63678cb3f7emr7610245a12.24.1759393567298; Thu, 02 Oct 2025
 01:26:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1759357733-64526-1-git-send-email-dai.ngo@oracle.com> <80f31f25d97a2942f7b4e47729e8333af8913663.camel@kernel.org>
In-Reply-To: <80f31f25d97a2942f7b4e47729e8333af8913663.camel@kernel.org>
From: =?UTF-8?Q?Aur=C3=A9lien_Couderc?= <aurelien.couderc2002@gmail.com>
Date: Thu, 2 Oct 2025 10:25:31 +0200
X-Gm-Features: AS18NWB8mNoSoGsfmMZR1AZk9HdlT5zBiAT7vcTIMv35kbh2ZQGKtdYmmA9vQQo
Message-ID: <CA+1jF5qRPBAfBuh4dMNJV5rFZb=gO=rbQ4s_wMqeAYz5MKr01g@mail.gmail.com>
Subject: pahtconf() api to test for sparse file support? Re: [PATCH 1/1] DIO:
 add NFSv4.2 READ_PLUS support for nfstest_dio
To: linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 2, 2025 at 1:53=E2=80=AFAM Trond Myklebust <trondmy@kernel.org>=
 wrote:
>
> On Wed, 2025-10-01 at 15:28 -0700, Dai Ngo wrote:
> > From: Oracle Public Cloud User
> > <opc@dngo-nfstest-client.allregionaliads.osdevelopmeniad.oraclevcn.co
> > m>
> >
> > Check for nfs_version >=3D 4.2 and use READ_PLUS instead of READ.
>
> Hrmm... READ_PLUS is (like all NFSv4.2 features) optional to implement.

READ_PLUS is needed for sparse file support.

I am really starting to wonder whether there should be a pathconf()
api to check whether sparse files are supported, i.e. NFSv4.2 SEEK and
NFSv4.2 READ_PLUS are possible for a file.

Aur=C3=A9lien
--=20
Aur=C3=A9lien Couderc <aurelien.couderc2002@gmail.com>
Big Data/Data mining expert, chess enthusiast

