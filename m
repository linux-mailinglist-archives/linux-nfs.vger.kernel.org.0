Return-Path: <linux-nfs+bounces-969-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCDF582665D
	for <lists+linux-nfs@lfdr.de>; Sun,  7 Jan 2024 23:34:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E4A4281A89
	for <lists+linux-nfs@lfdr.de>; Sun,  7 Jan 2024 22:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C18E5125A5;
	Sun,  7 Jan 2024 22:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vfj67t1W"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34DDB125A8
	for <linux-nfs@vger.kernel.org>; Sun,  7 Jan 2024 22:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2cd1232a2c7so13168051fa.0
        for <linux-nfs@vger.kernel.org>; Sun, 07 Jan 2024 14:34:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704666848; x=1705271648; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Dm5gktl/mG3P4vhXeeFquJcskC9utTWUc0iNpc1FYZs=;
        b=Vfj67t1WR9tHAIDeGodD+3iqm3IeQ87gkhM+/Hyij6uOScc7P0jZYOk8JrlS9qRIYg
         53pYpyh+N3KG4+XOoFYD2juPMaLgDYFbAi+GrUi0l4QpodWSmNMnGXK4LmpvHWs7b216
         jMN6SxynsZlWoRfvNWy9BIwgfDHkF7LEjEd8RoBfub8dM4I81+2uIDcAvNdYgo63YrHc
         VEPz55fPlAQegpXOSZYr2wv+/X5Shl4uHNUIFjPOqYSnr1CxwmpgpLKl0Dpn2wdgLeEr
         Bf1V1gKLfnNWV1rs5pvniWWxcSX0vmjN/rH2nUa2On4xK0MNkFQlWq6vuow77jO/t6Am
         YbSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704666848; x=1705271648;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dm5gktl/mG3P4vhXeeFquJcskC9utTWUc0iNpc1FYZs=;
        b=IGHXtisYLzbkHS13i/SZHLX7ILD/T0fgGpVAUy2r/4aMYzXc+N9nRX7K/MDIcPlIgZ
         /5+Dbo80DsnOaBkmkFIFe2WzhlaszTN/sfdiKdGJZc1o4yj/zXtd9E9NqbbMcbV4QfVO
         IYjos8ynXbU5vhrYJk5Wg59nzdAdvuLGqyQlUC6/W8cvvK1B8NCUJH7gs0Yzsys0Qxur
         UcYC9Gf9LP52ZTFNWSKtJb/kD03eJ+GLmJGv4mXeue/Kvk4RrUYn64aX/QT8hMQRRop2
         qp+Yiy626XZJcgM8ekdl9zHWo6lYbIIbjjaEw3gOyZVufCUkA/oa0IXgnoub4hxpUi5Q
         KOtA==
X-Gm-Message-State: AOJu0YwiI1jiJZm+Y/icsO/gvovcfRq7vm42zuwFnT8TQLiM5T9l4EtO
	LveSjc/lnokB8nI6fx1nz2SAq/GKfp4M80Q7aMd1SbNh
X-Google-Smtp-Source: AGHT+IF2hpVaQrX8PHtrSPCJgdQs767wBXbXG7z9sMjZF1HHE4cN+OwJ5u9xUjRiTZaq17zEuZrGx5vx/Xf65B5ErPQ=
X-Received: by 2002:a2e:2f13:0:b0:2cc:9ec8:fc5a with SMTP id
 v19-20020a2e2f13000000b002cc9ec8fc5amr1009509ljv.39.1704666847810; Sun, 07
 Jan 2024 14:34:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALXu0UdFR7Xn51eKFUUi6a68wvDKc-RXz7F4LKyQgDptqfYbgw@mail.gmail.com>
In-Reply-To: <CALXu0UdFR7Xn51eKFUUi6a68wvDKc-RXz7F4LKyQgDptqfYbgw@mail.gmail.com>
From: Cedric Blancher <cedric.blancher@gmail.com>
Date: Sun, 7 Jan 2024 23:33:31 +0100
Message-ID: <CALXu0UfSJ0Qc3HOecf4pQ=VnEVqxRw6OGzNwhh9BUVYaHV7_oQ@mail.gmail.com>
Subject: nfs-utils&nfsd&autofs not supporting non-2049 TCP port numbers - Fwd:
 showmount -e with custom port number?
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Good evening!

Generic issue in all of nfs-utils: None of the utils properly support
NFSv4 with non.standard (TCP/2049) port numbers.

mount supports it for mounting, but does not show it for listing mounts
/proc/mounts does not show the port number either
showmount -e does not support a port number
autofs does not support non-2049 port numbers
nfsd referrals do not support setting non-2049 port numbers
...

Could you please make a concentrated effort and allow non-2049 port
numbers for NFSv4 mounts, in all of the lifecycle of a NFSv4 mount?
From nfsd, nfsd referrals, client mount/umount, autofs
mount/umount+LDAP spec

Ced

---------- Forwarded message ---------
From: Cedric Blancher <cedric.blancher@gmail.com>
Date: Sun, 7 Jan 2024 at 22:32
Subject: showmount -e with custom port number?
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>


Good evening!

How can I get showmount -e to use a non-2049 TCP port number to show
mounts on a NFSv4 server?

/sbin/showmount -e localhost@30000
clnt_create: RPC: Unknown host

Ced
--
Cedric Blancher <cedric.blancher@gmail.com>
[https://plus.google.com/u/0/+CedricBlancher/]
Institute Pasteur


-- 
Cedric Blancher <cedric.blancher@gmail.com>
[https://plus.google.com/u/0/+CedricBlancher/]
Institute Pasteur

