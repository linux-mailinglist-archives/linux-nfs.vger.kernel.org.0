Return-Path: <linux-nfs+bounces-10654-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB114A67722
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Mar 2025 16:02:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0DC307A2150
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Mar 2025 15:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E6DA20E33E;
	Tue, 18 Mar 2025 15:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CPEimdSj"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CBD720D50E
	for <linux-nfs@vger.kernel.org>; Tue, 18 Mar 2025 15:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742310090; cv=none; b=hCWKZGrMVLD+SeMzO37LPsF5u+NUwe67HrCTETRH8vJE7beKg6grSYBCYIPfzmDBgLtKJLGyTTQHGL3fDyGNo/GdlFNQ0QeGIyxfYO9VmHJr5kryJW6HUq6HKQ38E5xzStHQSaOdRQ9tiuR6ihMFCFWrdh5v9UqTTe/DTWaIrFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742310090; c=relaxed/simple;
	bh=RKnIsJrtq28o5o47+G6LKwtmstsd5M5UPfIl5RMladI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=uDqh56SwnvMjX+MDrFY/hol92TeVHAKZZ0wzXfGcD9NwpUgZOKGlQHTLWmOOg7biDl0FVBRK8UdbrAfqpYawGiHpbXVn711bEI692OcOhw4erFpFH2ElXmn1F63G35ipzzJ3JUojMq4ciAx6dbWS9TZKh17BxIWlD/IO1NtqGug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CPEimdSj; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5e5cd420781so10932646a12.2
        for <linux-nfs@vger.kernel.org>; Tue, 18 Mar 2025 08:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742310086; x=1742914886; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RKnIsJrtq28o5o47+G6LKwtmstsd5M5UPfIl5RMladI=;
        b=CPEimdSjUJtDMIPeV6u4lAtVLMz2SzdhfGQcCGFFS6wZ6iinlRShwUfo8c78iVjWFL
         PXVskGGMsmhh9SrzlM+vM4ZVJODcyDYTehXIeWAntGENnjQPdLjCI8GHcq0867CPC/Zk
         /KhnbAXlvj95YzL8nt52yc86Bw1vq1vEI3ya+DUdoH2ItpFOtdPApdSTK7hUsetq32FT
         E0GqX5z+6KMpBG+wpLXrqODtBYMPooXFSdB0rUEBVjfgwZB+jmIuaLifaqju4rKyrF3B
         uZMoiWAugBK7L46QG5evItNv39SQJNVSgGaDXP4thqA/obqm6qcj66148BJpZ7+MJkAF
         36ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742310086; x=1742914886;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RKnIsJrtq28o5o47+G6LKwtmstsd5M5UPfIl5RMladI=;
        b=feqy+reBM1XPjusGc6nyuzTwuHOOG/LVESYU4GZNv8YIHYDkxGVhcQsGALqBumI78m
         zTpxjplZYF9k/ypVmmlls02V4zZlS44S/GaGmS6BLM/k1sb7Eu2InHY0owzMtTmp3N51
         b6KRJ5uljHqF4qmhgS30bfae0Gj4tkT0WuOPHDYGca7O+vihw7QUcPNUuWwKGI8ECS79
         bw/3tWIg11nrmPjusl453hZsnda14j2WgD+hS7xqVvZxjJ3obhYMpBbc2ETKT1AJ95lL
         +GrLFd+wWWikKRsoosthtwkJeyWIQtJ/mtfh8gXY+QXYxAnlEsBEhUt057GWxEguf2CF
         tkVQ==
X-Gm-Message-State: AOJu0YyKinsb6Xx3vp2yndEF4GDz1/vXT2rrM3uvpp3yI4D2xeBX6Xwz
	eh7npivgdMq3uSD+7g8vuwzl7cicOw+MMhXEtuJK7SlU0GkJ1Ap8J0aCRcHgYi8kui5wSyQxtzp
	gx0CrOveF+ugLGkFSMfLXtjnbNdnwZgq5
X-Gm-Gg: ASbGncsXafCeaR/GMVReCNWOJlWUUR4oMI4L+XzH0gzkZg4ewbWEKkZsXAnCpHzUhix
	WR+qhAGWA6eT3WLOMaPIlgIs2+chEk3kQh+xmO4+O+4WbkcyJGPPAh7IHDrZFZ4T8tNFBiPpbYw
	OZ89xJivsor3uB2Hk1yBb+n7erXQ==
X-Google-Smtp-Source: AGHT+IGRSXJjHUx32vHOtZgmWdrGGENhi270NbFSD8xjMIopXgstN/CctALVi1uokAkLe8CCScW5A5C3q5SGnloy7hY=
X-Received: by 2002:a05:6402:2554:b0:5eb:1dac:5a20 with SMTP id
 4fb4d7f45d1cf-5eb1dfabf84mr3358396a12.31.1742310083274; Tue, 18 Mar 2025
 08:01:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Takeshi Nishimura <takeshi.nishimura.linux@gmail.com>
Date: Tue, 18 Mar 2025 16:00:46 +0100
X-Gm-Features: AQ5f1JqEPJsh8jBOifCT35wuIV2cbVZjJiTY0WrRYqpxjUPw74q_rZpVGPCp6LI
Message-ID: <CALWcw=EeJ7rePwqv48mf8Se0B5tLE+Qu56pkS-fo0-X0R3DQ=Q@mail.gmail.com>
Subject: Supporting FALLOC_FL_WRITE_ZEROES in NFS4.2 with WRITE_SAME?
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Zhang Yi <yi.zhang@huawei.com> wrote in linux-fsdevel@vger.kernel.org:
> Add support for FALLOC_FL_WRITE_ZEROES. This first allocates blocks as
> unwritten, then issues a zero command outside of the running journal
> handle, and finally converts them to a written state.

Picking up where the NFS4.2 WRITE_SAME discussion stalled:
FALLOC_FL_WRITE_ZEROES is coming, and IMO the only way to implement
that for NFS is via WRITE_SAME.

How to proceed?
--=20
Internationalization&localization dev / =E5=A4=A7=E9=98=AA=E5=A4=A7=E5=AD=
=A6
Takeshi Nishimura <takeshi.nishimura.linux@gmail.com>

