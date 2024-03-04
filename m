Return-Path: <linux-nfs+bounces-2175-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5ECD8709C7
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Mar 2024 19:42:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7A541C20B3B
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Mar 2024 18:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1A3662143;
	Mon,  4 Mar 2024 18:42:33 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC051E484
	for <linux-nfs@vger.kernel.org>; Mon,  4 Mar 2024 18:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709577753; cv=none; b=Mr86w99TN/eZ00dMTjuXshliXVjJYGqAkDMD6FNm8WeLieGUthlKE+yFA+URj7SFZnQhnjsjkAj7SjK/a0Bh73hvcoPyyz6XYsedc+mcjfsvgoC/lMlYYm7OzMI1+9esknyvWOoTav9mEqP2gXIhQ4I84H5rEVag2IlUfv8X4Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709577753; c=relaxed/simple;
	bh=uviLCn9kAIAya+fglTcNqj7qhTPSYyhmrpjFl0/x3vs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=LDdM36bngPIEt72d6RFV2NRJ9MY8fm59KkG5QQjZv0WCRdXZtaFe9h68KC2nnmrWGPcvbeUFOI6z6oyzpxQ37vGvXy1wpPSChKPD9/rRMgY6eG72VlTORrBuIvaYsHd8IFTICqQbN6irp56UptKpzZQN2M9o+WfVC1oAs0YFmcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nrubsig.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nrubsig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-7c85c926387so24238339f.0
        for <linux-nfs@vger.kernel.org>; Mon, 04 Mar 2024 10:42:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709577751; x=1710182551;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HT/pP+T0NP6QlMe2SlXXHHjCe0FpP0SxLxRy1EOnNgQ=;
        b=mjM+bI1a6thAzbqDz0IrcionU3/zoCLvz3J5ljA1/ZpFIPUfp1oCZoZUFPmQGITdh3
         HM/zEBXmt2ssU+4OydGN1MlZlvqddMpi7UiXS6W7Ss8BeOHZutpet639U0Z+cf2ryxQd
         8qVKDCWFg5CrwTWkR1ORVy22RNLCYBEB9Krg1C/s3g51hq5YvKoJQOa5q0MmMQWs3jw0
         gjdVpnBV2/AOgRVVQFl5Q3xublrKq7qSX13T9v/m2xACZfi2IOwGwgi2923oE3VCZrvL
         tWJbnqkuiyf7IvZIxZfgiIQ2RArdLZm98ltO2D4xGRQxi/xjM8twKqewTVweUuzFBkgF
         yKrw==
X-Gm-Message-State: AOJu0YyZwPJPZM8xNRHf++CaA+2hv2klLGxPr+BYdbrCcs0249+NZ9cQ
	dI2F8EYrHUbOrzFfB3FHH1ZB5LTnOex87wNV2jaPdoyWYqDAQ8ABr59mA3tvH72r2eug3e5HwaT
	P0AyYNaAwpz33m04y3iYxUhcmsCPVZhOw
X-Google-Smtp-Source: AGHT+IG1vVWvmUhDHDPq1yHMgrQBi33QriX64BktUaeOYEEE7ypU13ro1SS8r9fHI46iDOQ58ymTQSfwOH0f4BQGV+Q=
X-Received: by 2002:a05:6e02:1527:b0:365:b00e:c3cc with SMTP id
 i7-20020a056e02152700b00365b00ec3ccmr333926ilu.2.1709577750964; Mon, 04 Mar
 2024 10:42:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240225235628.12473-1-neilb@suse.de> <20240225235628.12473-3-neilb@suse.de>
 <20240304183217.GB3408054@pevik>
In-Reply-To: <20240304183217.GB3408054@pevik>
From: Roland Mainz <roland.mainz@nrubsig.org>
Date: Mon, 4 Mar 2024 19:42:03 +0100
Message-ID: <CAKAoaQ=z6HMJKL+CMLbum31owuJ6Gp0oLdpPiFub52gD4zNzKw@mail.gmail.com>
Subject: Re: [PATCH 2/4] rpcbind: allow broadcast RPC to be disabled.
To: linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 4, 2024 at 7:32=E2=80=AFPM Petr Vorel <pvorel@suse.cz> wrote:
> > From: NeilBrown <neilb@suse.com>
> > Support for broadcast RPC involves binding a second privileged
> > port.  It is possible that rpcbind might choose a port that some
> > other service will need, and that can cause problems.
>
> > Having this port open increases the attack surface of rpcbind.  RPC
> > replies can be sent to it by any host, and they will only be rejected
> > once they have been parsed enough to determine that the xid doesn't
> > match.
>
> > Boardcast is not widely used.  It is not used at all for NFS.  For NIS
> > (previously yellow pages) it can be used to find a local NIS server,
> > though this can also be statically configured.
>
> > In cases where broadcast-RPC is not needed, it is best to disable the
> > port.  This patch adds a new "-b" option to disable broadcast RPC.
>
> If this feature is wanted, I would suggest "-B". "-b" is used in ping for
> broadcast, therefore this option looks like *enabling* broadcast instead =
of
> disabling.

I agree with Petr...
... could you please add the comment about NIS/YP in the manpage too ?
And what about NIS+ ?

----

Bye,
Roland
--=20
  __ .  . __
 (o.\ \/ /.o) roland.mainz@nrubsig.org
  \__\/\/__/  MPEG specialist, C&&JAVA&&Sun&&Unix programmer
  /O /=3D=3D\ O\  TEL +49 641 3992797
 (;O/ \/ \O;)

