Return-Path: <linux-nfs+bounces-16161-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C62CAC3E7B4
	for <lists+linux-nfs@lfdr.de>; Fri, 07 Nov 2025 06:04:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 800C04E03D7
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Nov 2025 05:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15D1F218EB1;
	Fri,  7 Nov 2025 05:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M+l5UOZ6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A451DA60D
	for <linux-nfs@vger.kernel.org>; Fri,  7 Nov 2025 05:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762491840; cv=none; b=pXr10/c0UtlCFCC33bp33j0T6Z9yrnyqNfUxdxRN14/yWJ/ZBmkKST1TK+5GV8inlKokNSb/CW8aPynX1sJjsNx7N65PEH4yfTQyaxeFUaOV+c8GoXGYuJCppMlMhW0KPsSleUKv/jZHuBEf/9zFvyOB5F3VXKD/lc5JCUWrvjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762491840; c=relaxed/simple;
	bh=KXvKD/doSOpPoI98Ez+SfgrGd5dr9v/6F4bTsofH0lo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=D6RYlXpgj3q8E42wa8BaKoQFcITL2jnU4/lF1PSIQbXxQQBgeHoRvAunAMr2U6WmHuoEknoP84vNRsJHEg67bwclbqhYShT7mBH+iGHvw7NQrZPUVB9tw5adgPc4lCLxluQUn8ILYrkrID8RAjGsP9CpjZ5njCb/DjM2qWoCcE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M+l5UOZ6; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b3d196b7eeeso50961966b.0
        for <linux-nfs@vger.kernel.org>; Thu, 06 Nov 2025 21:03:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762491836; x=1763096636; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KXvKD/doSOpPoI98Ez+SfgrGd5dr9v/6F4bTsofH0lo=;
        b=M+l5UOZ64WnhAjZk21wyip8a3bn+zitv8ru7zQ93fXKV8kLbsFzEX/aoBACw7i5+kT
         OPAAuwVm2HQEGyAMXIGvIDnNkuyfn6DTCEn0Yehv4+Odb+orvQpjrBirDfgZkqaqGV9j
         8/vfs+0ByO/E0U9DdiHqTeE+KsLilT4V1mPsnkE1CVRkrFXnlgIdPnVg/WoNfWv20qgj
         KBVVnbCbS14VIP1Y9UGpwEa/WF6D1TmQusUKPEqX5SJZdLfxhyvXA4ZeIDFjhrR4PFtr
         ghLRS//Z1/n8Khc+QczWtF1MU2V8Hck06ycT5kXINk2W99KGyPBPMXLtaDNTi2QHa89h
         iQaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762491836; x=1763096636;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KXvKD/doSOpPoI98Ez+SfgrGd5dr9v/6F4bTsofH0lo=;
        b=ErSUkH4l4BPJQpH+7SFT/36feqxKCyv4c2Pohs/n/aQfQ5Yo/IhmeV9Q/YWAueHk/w
         o02uL47ZmdIP25LmWId4VTzIVDXR6KEylJpFTrIMgMPtCrOQddI4Xyhse9HIs6u8Nfc1
         xKnnFIraRInH6NOnf0cMxwCv7aFLCML3VvObbym8kPrRKbqI69NEw+2eTzBsOqhXxdNG
         tMp+OXXQUpq+GF1kLklqTlp1Mtj6ZHA2gFRt3ktrmNhiywTV40BpMc1bckMh57SV1U40
         bkCQKt8uAwEpekCzeUGSZXHo7QMmDCH/G67wZPnWpGCDWvpQ4H8A+E/IAfKnyQpIW8kM
         0Kwg==
X-Gm-Message-State: AOJu0YyS3Emc0SFxpsanx4aN/kTYYBVaoQa4EFrXRxRI4qq6oJm8I+hk
	98Klqt+FFlV39DjuBXtoOdHJFs1MZmFYF505iMg+yRHRW4AaNteakZrAjAPPh5rsvH73DIrl8jA
	l74JAqPpObZFD+DychHnkor6IiJkveztqgQ==
X-Gm-Gg: ASbGncs1cKkMPjN7fozaD4vphLXJlsISM+gU23/O76QLLPMoQ7qP1apTdiQHUONe6EB
	er+orQ82I++IP27xJj3Sn2wNcFTHulUpkj5i2Axldy4+/8X0oz5oySXEqbSnwZrPuvkEwcQ2FKh
	uh6RVqYxGHnBMTZM7KlKwiYgrw/onwg9ramlsETZOhi1kTYQLXPUGqUQ8EI8a2ottL9661ObP6h
	51IOGVajf6n/vOweI160qfHLSTBXxFGv+1X782CRNPOn9hWr9DXXftXPm/orfhN64MhCQ==
X-Google-Smtp-Source: AGHT+IHtMDMQObKadvMvf9BDb7/UN2g7JNi3d3e/SC1NsHVXH2RZ3FpjVC5/NeCJVPsynLnORtdISJoKurRTBSJXKjg=
X-Received: by 2002:a17:907:fdca:b0:b72:67c2:6eb0 with SMTP id
 a640c23a62f3a-b72c0e0917emr160742166b.62.1762491836236; Thu, 06 Nov 2025
 21:03:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANT5p=rmuH59F9dpvrop0f+8XfVnK6fZHyqLhb10UsYfa6XJgw@mail.gmail.com>
In-Reply-To: <CANT5p=rmuH59F9dpvrop0f+8XfVnK6fZHyqLhb10UsYfa6XJgw@mail.gmail.com>
From: Shyam Prasad N <nspmangalore@gmail.com>
Date: Fri, 7 Nov 2025 10:33:44 +0530
X-Gm-Features: AWmQ_blMbLBVow6LMc1KJfG0K1Y14JXilkhC9mII3wnbQvlJBkGiUVjc0lck6_s
Message-ID: <CANT5p=od_-93SNQtvaid7yrW_XTqCN5_MJS=cYzgydrPkhtJ3g@mail.gmail.com>
Subject: Re: Requesting a client side feature to enable/disable serialization
 of open/close in NFSv4 clients
To: linux-nfs@vger.kernel.org, Bharath SM <bharathsm.hsk@gmail.com>, 
	Trond Myklebust <trondmy@kernel.org>, neilb@ownmail.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 4, 2025 at 11:18=E2=80=AFAM Shyam Prasad N <nspmangalore@gmail.=
com> wrote:
>
> Hi Trond,
>
> Several months ago, Neil from SUSE provided this workaround for their
> customer to allow the NFS clients to work around a bug on the server:
> https://code.opensuse.org/kernel/kernel-source/c/d543ea1660582777ca7f8a8f=
91afd048de09b7b6?branch=3D377837fd53dbd7a6c35cff41d5c42ab1224512b0
> However, I see that this change is not present in the mainline kernel.
>
> I would like to request this feature on the NFSv4.1 clients in the
> mainline kernel too, so that we can have this support in all distros
> in the future.
> This is a useful low-risk change that will provide a fallback in case
> of servers that don't implement this scenario properly.
> Let me know what you think.
>
> --
> Regards,
> Shyam

Looks like Neil's email ID has changed since. Updating the email ID.

Hi Neil,
Is there a specific reason why you did not submit this patch upstream?

--=20
Regards,
Shyam

