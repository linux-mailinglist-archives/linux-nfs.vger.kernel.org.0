Return-Path: <linux-nfs+bounces-6718-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5EF598A7FE
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Sep 2024 16:59:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A23A91F23B00
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Sep 2024 14:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E35A1CFA9;
	Mon, 30 Sep 2024 14:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CJxi1lW1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20ED51917F1
	for <linux-nfs@vger.kernel.org>; Mon, 30 Sep 2024 14:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727708355; cv=none; b=KmtyQSxvEx6Oqy+gQWrIdRYDg3weBXpwX5cdzer83llm6teudlRoh+wbmt7A+Z0z7nSdnrCIknnV/IWehVo+xU3EB9xB6f+jFw3QvaBfh+V76CCLEyf7RPJCeMTIj+u5k9MyHLVYiQk7vfr8fvx5Q9As7q2lPFBG0ixZyMtKez8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727708355; c=relaxed/simple;
	bh=ZfQkGCjUln+EcAuKuxCpSwOfB5fOUpB5TIT974EeBWE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=pEqg7H03RO8uDS3b/nphvjoXAI9CM/NXznxaokUXPx/ENb9MeZHRJI13C9RsQzLkxTxEP6Msa+b+quyuBQMSzoULCG+SGecyjILYAxO7vjG6UQqk2Ub8zMx0SpshRuUoUq+cLta2etHU1lIxzKbAcZAufJBiQMi9TL9caQWUE4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CJxi1lW1; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2e0b9bca173so2423858a91.0
        for <linux-nfs@vger.kernel.org>; Mon, 30 Sep 2024 07:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727708353; x=1728313153; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vibjlxSrSbNlTZ4zAeOYjSz8ObC+ep3Qj3FWp7PSPMI=;
        b=CJxi1lW1pm0drNx5RmEL1MRtE34pyPzRPOQjVta5Irch0oYeZfuJRlXJ6PM8oPGHh/
         6lTUl3+2ltca3enLBIFJtHpqGxmOmpD2xNhNL2BKuaU6ZYWvpZbp2c+BAgYDMNeP0AFC
         juIOfMOj++Vus1hjTu5tBOUIq2v/9VSpiYE49IylNIesdjTzyTnQMC2EX3IiurWsm8Gm
         xkQoONP3CcTjaRLv+Mm57i77sHHjpW2drpXKkeGtr4TMDHNBIc92fUBbJx39lWDrjEGb
         CvwjaiKkClBrn/6YZODk4nxpDM8s1aGM2F/b+4mMR94w1Lt1YHQTIOSOVRi1AX56XvCi
         Q1EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727708353; x=1728313153;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vibjlxSrSbNlTZ4zAeOYjSz8ObC+ep3Qj3FWp7PSPMI=;
        b=YHo5aJLer2xuKeRjpJNNOK1v7eUfhYjFbkr/mhsJ4b2t5xXXLxvzeaG238k2XNKHbF
         3RN+SSFR+VSCDwrUuZktjL9hzlwAF7WjOMnvxNUiuonoSA965qE3o9Za0qFhV66zcWFF
         2x5KCznl/P65blavozYAowJ/bOT9MOc3/5Ce7tykhMMYVDleqB+PxqVOI83sjaBKvB9o
         JiW7kxdBwNr/kVEypouq3bud7ybuPmBCk6xhF/LFP2CIDEB9JdhEcnsdrJv4BYrQJecl
         9nmFq+W+CDVRUCcbiry3IzgaiLaoxty6YmsKF3W6IHrTTU+nnVUPPVWHV5Fae1IiAo9O
         F7xQ==
X-Gm-Message-State: AOJu0Yx7Ssm31Q+JVVOPZeapm0FtIpMKemdcNKTYnROzKNoocR2JcVjV
	VG6UXJnIDP7ZFWWT3zueXL6+6qviNNKWj5OSQuQtZ4i7csxNN4kaTZzIbT4gjY57qrtLJhqgyEP
	eqk/RCxLzs1q3OTJ7+5beRh1rQ29NkW89
X-Google-Smtp-Source: AGHT+IGMSWair+Rq+mDscF7NEizt0zAzN9c4RKjjyJXACsrwfTN1yUHaviESBwSU6CwUaLuSnuiQXv/90XmvZiZeSGg=
X-Received: by 2002:a17:90a:cb09:b0:2e0:8095:98d9 with SMTP id
 98e67ed59e1d1-2e0b89e2240mr13968351a91.11.1727708353041; Mon, 30 Sep 2024
 07:59:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAN0SSYyAf51Vdeg9yVGD7isZfT+PcvbC8RcUGzgkH9MUB1QjgQ@mail.gmail.com>
In-Reply-To: <CAN0SSYyAf51Vdeg9yVGD7isZfT+PcvbC8RcUGzgkH9MUB1QjgQ@mail.gmail.com>
From: Mark Liam Brown <brownmarkliam@gmail.com>
Date: Mon, 30 Sep 2024 16:58:00 +0200
Message-ID: <CAN0SSYxVUiiupuu-8DPq1tMRrOBuO49bwaLik0KmoQ3r2pqnxg@mail.gmail.com>
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

So far "::1/128", "::1/64", "::1" do not work, which makes me wonder
if there is a BUG in nfsd which prevents the use of ::1 at all.

Also, our IT department made it clear that the "total
underdocumenation" of IPv6 in exports(5) is "literally worth a CVE",
as many people use IPv6 masks which make exports world-wide
accessible.

Mark
--=20
IT Infrastructure Consultant
Windows, Linux

