Return-Path: <linux-nfs+bounces-17671-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 895A7D0669A
	for <lists+linux-nfs@lfdr.de>; Thu, 08 Jan 2026 23:17:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 38809300D41A
	for <lists+linux-nfs@lfdr.de>; Thu,  8 Jan 2026 22:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 941CF19E7F7;
	Thu,  8 Jan 2026 22:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dneg.com header.i=@dneg.com header.b="UzLJ+vl/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1CA219EB
	for <linux-nfs@vger.kernel.org>; Thu,  8 Jan 2026 22:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767910624; cv=none; b=Q6arwEoQSKy0qieIClZrUneDYtcYjxkky7Uj5XLReESMLgZNiqqC9Qsfj+tUxjmy4pagY2BdT/JCvHBHRRs6yd94NZnR3mFTM/7iq7137IIeJJ6mowqhY6rbJR4/ugDT3QeV904run/0CrdYdrpYn9Ky6lgSe0lrS+iloxcp55M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767910624; c=relaxed/simple;
	bh=D5r6tAvO1s/D8zVta3UKr2jopuoPB4Bh3UIWazy5H5Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dzh0ZZNzop9SwXxkFi/etHGyYR/JzqiH65C9XauUPAYUyOgyuQAylfC3QNyB+JbGrmNEws3ulKr1G20cJCoVbsmsSvRQI24QQW+Dv3mooxHDctmTTe0vxJ44Y1FTCw108Qk++L5TCAM3Lo5GyBGjsczgtuDF9lXRKPhWhUXtCvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dneg.com; spf=pass smtp.mailfrom=dneg.com; dkim=pass (2048-bit key) header.d=dneg.com header.i=@dneg.com header.b=UzLJ+vl/; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dneg.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dneg.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-64dfb22c7e4so4175534a12.1
        for <linux-nfs@vger.kernel.org>; Thu, 08 Jan 2026 14:17:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dneg.com; s=google; t=1767910621; x=1768515421; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sTffpgMTspsgVSErmQhZ7AOvBCm4aXbt53XXekDy5IA=;
        b=UzLJ+vl/7dG4pzn0v11lztYuVcFVbSwNGc+lRG2CSSO3aQYQ+o62Lfi5LWlOLztSwZ
         8ouv7KucDpOwpuPNk7F1CwtjdNUdrSAo+EAumjFQxOROkfPGcEBGtwRKwa8DwKP3iHic
         WTZEWBQI7b68e/ComywrulaHfJjB0bgKdHhf6BftFomhRXlyf+RlZjxIVxdxwqw8Gspd
         m4LUV+nnbit1TZPVMQwoHXFrtiUZd+QcStZ1Knr1HqQp9/gC6zP9Y/XlFWn4J4xHm2/q
         rbNw8nTiOQiiMjskhIMS7SlV9LsqPORkg50ysMnnUTwyJ65p4OmCK0Xgg5zwPHQczXx1
         gatQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767910621; x=1768515421;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sTffpgMTspsgVSErmQhZ7AOvBCm4aXbt53XXekDy5IA=;
        b=lf7zdrbTQWpOo0AY8tac6NIpyb/fhwCxplWWsM+bXo5BOiBJzLjpA3NTgP55cwZJtr
         RsUzwbYWYb+2rIIj3jAMVikG9KQ7JygxOmeErGpc96pR2UneM0EASwgDZBlkUceQT2FW
         VeqEwWLt6nYngLAJNmDe6M+tiV/2bEi85POQTy4ECaAmbSg4Ye4Uv8zEvaUPMqwRAAda
         4i5RaVHCGawnyPmllh0fFZCeQ3V9n8WHOerlY+HxPbumWtwus9sDXo8DCjafeGJ3rFbg
         9j9NHiTec7NvZa0QlwEN5NGfViFAt2vpBgT1RTzZskJY6iY0DboS4GX/wwCnplM3Dpnb
         MXGw==
X-Gm-Message-State: AOJu0YxdDYMmllaR7st7FPlbEhtHCH2Jjl6YUKxt7Z9RddYi45xyYrXu
	o50y0LDb9q0ByoXZZk5QLWhPy0i73NuraYSESRC8Oz476bV67WQGWRAh/uGyXhAzJTrtoc7Ho/F
	x8easFT6kU8OQ9x+yc7FDCnhQmhrQldYv8Kx1AjgXitAKXISZdHe5C1E=
X-Gm-Gg: AY/fxX5HPedpsR2Z5dYkclb+ECmeUHdLRgd1nGsS3paSybn/6xMk4ILO0KqSdxkttv+
	q6ASaJ9TqGeknl6S+AC6K0Nlwd56CLo4A9BhNT3gm5iUHO7OFUh6L6CRtUKKbI7gWOw260oAejC
	Q/RpO0A/93pZt5M1M4nyf8asRzC89dn4ij5ao7CHTrv+X9dBKnAO3zCZIhc+TaEu6SpIS5dbGG6
	3VisS63uoimNZvNBGiE8V4eYkSvTIxXaXCXBAVoQjNTKG5cVR5YQ7zZG+nWn8NMYB8NIg==
X-Google-Smtp-Source: AGHT+IGt903qK6ZM+w3Qj5StmP/jizUP/qmAtpjcHHZZvbrFUc5I6Yxb5MveL20p0fFj3xoSwTV0CEQ7082UB3u9398=
X-Received: by 2002:a17:906:aa43:b0:b73:6695:cae6 with SMTP id
 a640c23a62f3a-b84298aad06mr861551266b.10.1767910621255; Thu, 08 Jan 2026
 14:17:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPt2mGPafo29KgjW9Rb17OhBDLnB-3fZn18zFQEhYk7Eitf6BA@mail.gmail.com>
 <f760b3a2-6e53-4143-9bb4-e56b030c6bba@app.fastmail.com> <CAPt2mGOy+ThM7tJDddrWRqFPq5Ljt1hhu==ydArdT7RYK82OBw@mail.gmail.com>
 <CAPt2mGO_gSfO4He7XeeENKuWD_+rbxa_z+hRJxNgQ8eC0XzZWw@mail.gmail.com>
 <89582fe2-2ee0-452a-9226-063f4b20ef5a@app.fastmail.com> <dcba5f89-7603-4abb-821f-f5322e964c40@app.fastmail.com>
In-Reply-To: <dcba5f89-7603-4abb-821f-f5322e964c40@app.fastmail.com>
From: Daire Byrne <daire@dneg.com>
Date: Thu, 8 Jan 2026 22:16:25 +0000
X-Gm-Features: AQt7F2oopf8mPgKBNrFxPa4NIHIEiP7KAVx_PCZNbo2Rt5tDi2QdSMCn86Qo0ek
Message-ID: <CAPt2mGNXuktDMYeh4dhs9Em6Jjb8k5pcRGaYEjmFgSszUz9wjQ@mail.gmail.com>
Subject: Re: refcount_t underflow (nfsd4_sequence_done?) with v6.18 re-export
To: Chuck Lever <cel@kernel.org>
Cc: linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 8 Jan 2026 at 21:33, Chuck Lever <cel@kernel.org> wrote:
>
>
> This fix:
>
>   cbfd91d22776 ("nfsd: never defer requests during idmap lookup")
>
> has the possibility of being highly relevant. It's in the nfsd-testing
> branch of:

Yea, that looks interesting.

I've applied (all) your recent ftrace debug suggestions so let's see
if I can capture anything useful first and then I will try again with
those patches to see if it makes any odds.

Thanks again for your guidance.

Daire

>   https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git
>
>
> --
> Chuck Lever

