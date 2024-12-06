Return-Path: <linux-nfs+bounces-8388-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8CE99E72A2
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Dec 2024 16:11:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 797B62876C8
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Dec 2024 15:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7DBC207E17;
	Fri,  6 Dec 2024 15:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="b605QM/F"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33AA207E14
	for <linux-nfs@vger.kernel.org>; Fri,  6 Dec 2024 15:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733497872; cv=none; b=KsQYmVObogIzPqMsrlAkCI4+ZN7SaAvNS9mIsdcZ0RcGJ2jG/Ztl2axf1gzVXG+xbs8KpNu2Dy7OZt3k74HL7Jy3Isp84s33srcGnB5IkmMQm4Rv2njRIqFParNKfMwFEUgilf/XFtDsi2aBPgHPLfc5k6s9GiGEoH7T1RBmpmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733497872; c=relaxed/simple;
	bh=wCQuI8phZ1+TrN40J2JVMieza73zr1k2Fifr0E4NL/A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=s0ZlX/2rofokKs4RZ1T45hB97woDs1ZTQsm0Wq/2tP32hnNtB0PrXUZjrrxRetqzk2r0vm+J/aDGdB0lzHUogw5EGLsHhN2uzcSEMwZkZwEa590SYr6Uy5wncJY00Sw3r7FFaAohc3+x1+XVpKNn91IcqbEvlnRVJHUeo3AXbEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=b605QM/F; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2ffa8df8850so24946861fa.3
        for <linux-nfs@vger.kernel.org>; Fri, 06 Dec 2024 07:11:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1733497869; x=1734102669; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wCQuI8phZ1+TrN40J2JVMieza73zr1k2Fifr0E4NL/A=;
        b=b605QM/Flasv91RWv1zl6VI/nAG1/ypSIILlPn+6CXmPMXl80NfeCUgKEaBn23QxGV
         +oWj00BOZiN0FC35GMdD8/fqBWYwHo1/QyUzQ4gZOsnBY932aXBlNf+AqpCmMIffayQu
         QGzNsS60kIltDud7Y7Cvk0kkExzDjQRFneOExWy9kvIbPqoWXhwQIAF4KAUKpmfFCClA
         QTlKSmC+53qhAkE/yFDSTSRPqKVSXHtTn6pSPsuvewHLhG6BsMNNHjuBmkPH0nk1epnt
         AOjAH58M17I4w5wbbz15fnALaVSMWgJa/QRJCkpGC2Fx/XCTJq4Md1b035T5kcIdV0z+
         E/lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733497869; x=1734102669;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wCQuI8phZ1+TrN40J2JVMieza73zr1k2Fifr0E4NL/A=;
        b=GkZRQttxPxS/ksbMKkoh4RFNoq5+iv1bVG4RisAxErKBg/qTWLTjSk23obSitp1Utk
         cWyUlRteKBKBjLhQotQN6AVqUiwlrOKtdKrO05Xmjhqmq74OC3qmYPEuE+Kf2MVZIUOT
         Qnz7b/ZUlH/hshA9opmoDBLUALsEWoxHfXOkDeX3AeKFREd3mDWNkxuSkdu8W0DEOamR
         /Zg9t0rEZ9fKRHkeg1/UrTqfHwMNt7on3HM8KbS9+Rsyq/YPhzxmZx+RDOqFUsAGfFwx
         OaLL5pq2LgwrgzUklt+PAHxRyTVtNwtOxUeLAnQHKsfYu+aQsCDHrL02OekeFs7WAJc9
         3pSw==
X-Forwarded-Encrypted: i=1; AJvYcCXPm38xUSU3vCHeXhdEVZp/KhMp+zre/6+bjeLdC7n/10WtIBLm5ydeFjeup6SGc+JI41kqbNvebWQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVuD4Gn+QiAwgrZQ9kBzs5rz4WAq19uBSh0UJezDEL8aJhvr9I
	ryvuqtxHYC5uCDcjswcm22wQtaPaWokQQLza1AdcsZLaDTJigyn7zZSv1li5+kHFgEsq1HqCDS3
	0No0iJPNajA+yq5JiCSoR171t9JAdonkHmrqmFw==
X-Gm-Gg: ASbGnct+y9cQGP5VjrrMLLne/IyOny7XWzARA+DJXTRHqT/oP/ACQM2vsY3BNz9n0Ei
	qr9lrJrKpxjSdQd+IcjGxAuhjWeB1Zho0Dpm+Vxa/W8ZSfzIm9Ee/7qwrcZD2
X-Google-Smtp-Source: AGHT+IHZh7+eSZRrew9jvjXLeL7+e+dVGeI+ATK6u5Qf2A9dzVb3ztmytV9rXvATxrVvHBhLv+Y0gapnch4CBZ6EiOc=
X-Received: by 2002:a2e:bc23:0:b0:2fb:45cf:5eef with SMTP id
 38308e7fff4ca-3002f933d39mr19247661fa.30.1733497867875; Fri, 06 Dec 2024
 07:11:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKPOu+9DyMbKLhyJb7aMLDTb=Fh0T8Teb9sjuf_pze+XWT1VaQ@mail.gmail.com>
 <CAKPOu+_XVhgg7Gq=izU9QDFyaVpZTSyNWOWLi5N8S6wSYdbf3A@mail.gmail.com> <CAKPOu+8iNpKkduNqOg4kfbnOBren58xx5hQ78DAs5FjD+FysHA@mail.gmail.com>
In-Reply-To: <CAKPOu+8iNpKkduNqOg4kfbnOBren58xx5hQ78DAs5FjD+FysHA@mail.gmail.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Fri, 6 Dec 2024 16:10:57 +0100
Message-ID: <CAKPOu+9v=4qSuESQ5bc94qM=U6OEv3FXZ2gdr3z0MyD5YTRtEA@mail.gmail.com>
Subject: Re: Oops in netfs_rreq_unlock_folios_pgpriv2
To: David Howells <dhowells@redhat.com>, netfs@lists.linux.dev, linux-nfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 12, 2024 at 8:39=E2=80=AFAM Max Kellermann <max.kellermann@iono=
s.com> wrote:
> It has been two weeks since my crash bug report. Our servers are still
> crashing all the time, and instead of going back to 6.6, I have
> enabled `panic_on_oops` so the servers reboot automatically, hoping
> that you would come up with a fix for the netfs regression soon, but I
> cannot hold this up for much longer. Please help!

Nearly 6 weeks now. Currently on 6.11.10, and still many kernel
crashes every day with NFS.

