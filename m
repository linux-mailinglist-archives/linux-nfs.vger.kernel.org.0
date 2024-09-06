Return-Path: <linux-nfs+bounces-6298-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC7A896F273
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Sep 2024 13:11:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96B5B1F21850
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Sep 2024 11:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C1291C9ECA;
	Fri,  6 Sep 2024 11:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W9yhOzik"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA55158866
	for <linux-nfs@vger.kernel.org>; Fri,  6 Sep 2024 11:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725621093; cv=none; b=U1nTdqFpRCfNCXvTTpVxqmD6Gy0HpuSbiLaOex3BONZfod89Llfc2Ch4ErUXhM+T/w728juium25oxV9U5VR6F3v3N/8ObOsyJbrnZo7lCyhW6HZiRnMB1jdO4fcUONn8pxem92Equ/EpxGVtsQw3zceIHZXsEz4/cgMlLiCaxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725621093; c=relaxed/simple;
	bh=pInoFa14Ij+xPLl/iaXGZELYOAt0gwCe4UAmzMxdc/M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=EiVXagaC+FrswodzVEPvtdhhYRk3SfuKSZbV6rsfhW5H/tbXWyaBply1SH0LyXsyzsZi6mDVGmq1xW4hABKobMHNGZ6Aa11XRHG4De/O/dwkH8een38wQ7ekLu2WXV+S+Me28nAIh7ob1/gTx44fZB7U5HANfqumaSsSs3brgkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W9yhOzik; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-206b9455460so15640645ad.0
        for <linux-nfs@vger.kernel.org>; Fri, 06 Sep 2024 04:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725621092; x=1726225892; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j2CZjc2YJPsfZKY6jsM/gOlGyWHcElZB2mpDhdt0Os8=;
        b=W9yhOzik55DpoLbbutO0l+OBxVUgaKxa1vJBbUdDcNks5stWrK+QYl4yY6XrlMYnDN
         hzGCGUGl6fnR+xU27NiB60q2gGGZLUoZnzKRb8TmFyT791lgEMoTo4Zlka/s8O/tLqMf
         CcVCPoXfjpraX1ZUmQ70PsB3zvIN1siDYffYi+OZ6UiIgICWr/yMMkb6tZwtVrFt5a+U
         zIBmrYRxvjDxBvJGw2lgGB9GPrK53is8Il8rq/SLbJxNp+gMZDn7AAlN0HsR12QMgLz9
         msuMLPctDplYsTOKwbgZcCTZvgPraSd+slCDbCFJ/2r5fQYBnzUFgctXjl9Uh9Hqmj5n
         vM/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725621092; x=1726225892;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j2CZjc2YJPsfZKY6jsM/gOlGyWHcElZB2mpDhdt0Os8=;
        b=Otxcz5Nm4UlOPtXdrMkqlHF0PWF+T1p9uZSXBYdK3n+/tz27mfHOTEGTb3moxXFWj8
         E6eghJxuOTF5BjA/186hjtK+gGfjNJ9id3GSzjUKpCvz4mb7uhXuEODJk9cO5n9p06Uw
         zTI2Gf8awEwm4Tq9SwM8BwPCLbK47fJeY9mXh6Cv4BK1NVCHKPb7pC9nBvF9bzcNhQQq
         flraVTp1EjZtXJugpK+HL+Zqi+MyXhx+RO2FboxG+c3XkbNxa71RvPyQr7NzjcpYc5Qq
         ZopARGvbeIWpGZYLkVN17N4vbOe75Mtu8320feG16c1Ro/voZiB/ZY2qxK1aepo/f0Gl
         pt2w==
X-Gm-Message-State: AOJu0Ywd+gV8OeLyGUPdng9Z+i/r00aZ+ZzESum2cra4fGbt2wxwrpY/
	WbSEa94TKL25JPhpvgej8KX8W/iq1b73b6E/xKxqpYBJAKHXs0cEGoCxGFRYknrTpa3cBBU1Xhm
	QNxnsbB2pl2BrOfELVG3T+P4darepTQ==
X-Google-Smtp-Source: AGHT+IHb9NUycjZvgBJh6mxUsymZLYGEcSKfaDukodUWjJqQy0Eor7p8M+lDTJD3DmUf0EsjZvugfqq6aO2SsiAzSIM=
X-Received: by 2002:a17:902:f68a:b0:1fc:4acb:3670 with SMTP id
 d9443c01a7336-206ee9540d9mr28977045ad.12.1725621091596; Fri, 06 Sep 2024
 04:11:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAN0SSYyAf51Vdeg9yVGD7isZfT+PcvbC8RcUGzgkH9MUB1QjgQ@mail.gmail.com>
In-Reply-To: <CAN0SSYyAf51Vdeg9yVGD7isZfT+PcvbC8RcUGzgkH9MUB1QjgQ@mail.gmail.com>
From: Mark Liam Brown <brownmarkliam@gmail.com>
Date: Fri, 6 Sep 2024 13:10:55 +0200
Message-ID: <CAN0SSYwk0TtZGnYtEJW58xw4vu4gs0MtQLV2pYvgOHbu5xjajg@mail.gmail.com>
Subject: Re: IPV6 localhost (::1) in /etc/exports?
To: linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 3, 2024 at 1:16=E2=80=AFPM Mark Liam Brown <brownmarkliam@gmail=
.com> wrote:
>
> Greetings!
>
> How can I add IPV6 localhost to /etc/export, to access a nfs4 share
> via ssh? I tried, but in wireshark I get this error:
>     1 0.000000000          ::1 =E2=86=92 ::1          NFS 278 V4 Call loo=
kup
> LOOKUP test14
>    2 0.000076041          ::1 =E2=86=92 ::1          NFS 214 V4 Reply (Ca=
ll In
> 1) lookup PUTROOTFH | GETATTR Status: NFS4ERR_PERM
>
> for this entry in /etc/exports:
> /test14 ::1/64(rw,async,insecure,no_subtree_check,no_root_squash)
>
> The same mount attempt works if I replace the entry in /etc/exports with =
this:
> /test14 *(rw,async,insecure,no_subtree_check,no_root_squash)
>
> Mark

?

Mark
--=20
IT Infrastructure Consultant
Windows, Linux

