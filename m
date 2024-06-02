Return-Path: <linux-nfs+bounces-3521-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C7038D776E
	for <lists+linux-nfs@lfdr.de>; Sun,  2 Jun 2024 20:14:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76858B214F9
	for <lists+linux-nfs@lfdr.de>; Sun,  2 Jun 2024 18:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 676D75FB9B;
	Sun,  2 Jun 2024 18:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V1hLtQVY"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33091E4A2;
	Sun,  2 Jun 2024 18:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717352067; cv=none; b=E10bRN1T4/oYja9hBGbvY3lOqxHUfQ9YrAS3NHKUQksxqwH1M5qZvTb1C+ZOPR8ieodS0bQ+ujgTddWBotS6Xp/+gtNfitA3tuDath3w/Oc+AFCaVl5HhAYHdFF1+Kf7XiKhFClbHgiOkBA42O7zEJsp6aQ2LqiYF5iih7uOsVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717352067; c=relaxed/simple;
	bh=26sG+RU918sBqQRFJfokPMsp/SvAXE8uPUZvptRh7uQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cmczV1KKcptV4ohKUEXfUyv6EBm9fS1zwlTToNG3s3MqhzoidZCJpuFwdoiSBbHE0+kLpLZXX7zGRMiwZqp/zSISFwKjcAn2ShDXbNGOhFXZiv/JYaUGYDvtzfi+C22Qj+bcoQ7WDs6WMydf1jcOU2MBD+4SoUewwtk932h0B8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V1hLtQVY; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-57a526c6a2cso972654a12.2;
        Sun, 02 Jun 2024 11:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717352064; x=1717956864; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sausMNbxxB/bYCqNfIRzoTBOki/aEJDkCMlpWmWKvs4=;
        b=V1hLtQVYY0y/v5BoI4TKic9SQF6NmORrUcRFmqY1fKkXIaUDaL4MdLgyHJ6NB6fmUj
         7+GxJOcmc5BCGR+hAjiaNA0x2fjtljIyov7biayqJ6trj2EWD6k1szpfhvMRXnDgA+78
         eG3bGHUnAEAz60nNLlPuvQpbm2tbdnV+ZBCKTp+rwJCzqr7LYHXTmE3MI2P8bRNSPkS1
         sTKZKaCb4vZHq3QE69dQZQfakcj2RP/QtuFqzaWv5VZv7DijO8lpJzWqAvxkc7iN+hoQ
         6QB6OtiNsyjgh/8y8rxQP8KxAhArH7goGDqnkMlPQsdCEcjzL7bMEYdO20539JpWypYn
         IpDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717352064; x=1717956864;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sausMNbxxB/bYCqNfIRzoTBOki/aEJDkCMlpWmWKvs4=;
        b=ef37/MSLJXIXscDEK89aYr5X+IwUq6FRcN+scfBdj2Y4qvUyrHKvAgjPBzshwG21VN
         6BVs3KubRVMStp8qVObJmtsbeMZ4SldWm7kp/h8t2yB1b0UscJSM0usFvZMroId0JFC4
         miWIUkT4HoM5F9Wk6AotOL/ohmmTL5EiiiyABjZgPmrfNy/frtAlqWbFdvuBkaqz+ecf
         +OWA8nVM5eanEjkV3XSYfAwYSlHj3qBP0CCfEmH1AIuglxrIZdrJg2OePq15TMqu2wjl
         OVon9/o8fUW86JLqKcmbv2x+u640CNBqIOjvUJQT5wykY+dYh5y72FnPau3Y1QypDodK
         TC/g==
X-Forwarded-Encrypted: i=1; AJvYcCX4tiDOkbs9FjesNtfz6Dy06GAc4LUIEunGkkyzWjCfIHuRmkgyEeJlOuXu7QlJre2Ou4fg7sEtb6/jxPDoikz9gMIWOmFSquDdlw==
X-Gm-Message-State: AOJu0YyH2DJvMXt9pzY5t6GllBMi2bCiYwWkL7xpd8slBM1iaHOl7dJA
	UWQbm1wiT3PjecVs308dKsa8eBqBZgXbwMgXJIpBDbIbk5G8I2vE/xNE7vw0wEwSPcs0PpQ1PiA
	a1MLyv8BMP5UpG4VW1uPyWLihuIEXwQ==
X-Google-Smtp-Source: AGHT+IGuJPlbZFD0h1Yruj3TKDxkvHKRgqHxSRZ4vlfXmxHPGbNdFLrl06kHHhWXXIyywZL13Xrk1Z6yHtSu0aNmvcU=
X-Received: by 2002:a17:906:130e:b0:a62:2cae:c02 with SMTP id
 a640c23a62f3a-a6822049d08mr492433766b.61.1717352063862; Sun, 02 Jun 2024
 11:14:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240429152537.212958-6-cel@kernel.org> <efc4f895-3a45-4b44-a47d-532896526458@linux.dev>
 <90F6A893-5315-4E53-B54E-1CF8D7D4AC4D@oracle.com> <f49907ea-cedc-44b7-9ffc-30c265731f3e@linux.dev>
 <675A3584-6086-45D4-9B31-F7F572394144@oracle.com> <6d483d75-5866-4c4e-8d86-c89a2b27f5e7@linux.dev>
 <F2726F77-06F9-4DB4-B2A8-97F21B045A6F@oracle.com>
In-Reply-To: <F2726F77-06F9-4DB4-B2A8-97F21B045A6F@oracle.com>
From: Zhu Yanjun <zyjzyj2000@gmail.com>
Date: Sun, 2 Jun 2024 20:14:13 +0200
Message-ID: <CAD=hENdL3v6gMpU7SBdkLjcyuEhzCvTRxt3+N+8m6ybuVKGHwA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] NFS: Fix another 'check_flush_dependency' splat
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>, 
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, 
	"kdevops@lists.linux.dev" <kdevops@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 2, 2024 at 5:40=E2=80=AFPM Chuck Lever III <chuck.lever@oracle.=
com> wrote:
>
>
> > On Apr 30, 2024, at 10:45=E2=80=AFAM, Zhu Yanjun <zyjzyj2000@gmail.com>=
 wrote:
> >
> > On 30.04.24 16:13, Chuck Lever III wrote:
> >> It is possible to add rxe as a second option in kdevops,
> >> but siw has worked for our purposes so far, and the NFS
> >> test matrix is already enormous.
> >
> > Thanks. If rxe can be as a second option in kdevops, I will make tests =
with kdevops to check rxe work well or not in the future kernel version.
>
> As per our recent discussion, I have added rxe as a second
> software RDMA option in kdevops. Proof of concept:

Thanks a lot. I am very glad to know that rxe is treated as a second
software RDMA option in kdeops.
And I also checked the commit related with this feature. It is very
complicated and huge. I hope rxe can work well in kdeops.
So I can also use kdeops to verify rxe and rdma subsystems.  Thanks a
lot your efforts.

>
>   https://github.com/chucklever/kdevops/tree/add-rxe-support
>
> But basic rping testing is not working (with 6.10-rc1 kernels)
> in this set-up. It's missing something...

Just now I made tests with the latest rdma-core (rping is included in
rdma-core) and 6.10-rc1 kernels. rping can work well.

Normally rping works as a basic tool to verify if rxe works well or
not.  If rping can not work well, normally I will do the followings:
1. rping -s -a 127.0.0.1
    rping -c -a 127.0.0.1 -C 3 -d -v
    This will verify whether rxe is configured correctly or not.
2. ping -c 3 server_ip on client host.
    This will verify whether the client host can connect to the server
host or not.
3. rping -s -a server_ip
    rping -c -a server_ip -C 3 -d -v
    1) shutdown firewall
    2) tcpdump -ni xxxx to capture udp packets
Normally the above steps can find out the errors in rxe client/server.
Hope the above can help to find out the errors.

Zhu Yanjun

>
> --
> Chuck Lever
>
>

