Return-Path: <linux-nfs+bounces-2003-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 060BF858FB3
	for <lists+linux-nfs@lfdr.de>; Sat, 17 Feb 2024 14:38:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEA562829AC
	for <lists+linux-nfs@lfdr.de>; Sat, 17 Feb 2024 13:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 496257AE4B;
	Sat, 17 Feb 2024 13:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XnKg5qC7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B1E7A734
	for <linux-nfs@vger.kernel.org>; Sat, 17 Feb 2024 13:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708177105; cv=none; b=CDiQHSAAjsYgABpP2VxrVnAj5REl9nohHLH31MBQc/aB7/NHs24xADrQ6WFtZdtOD0UEXC2y3CH8/19U9VlDi1yPoGAJZGJFcY1/H4qWt4sGZnXTTqpvcwyMReEi6CYjB2K7nCIG5cYNlIy0maKNrKHyW2o02YceFWF339WQArA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708177105; c=relaxed/simple;
	bh=FU391EAsgODVF+qcQK+AR6RH8BocoKT6FMOj/B+fsKs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=jR4Lp2s8J7ANGQ0XQ8GHaTeQT6iBqBkKN7xahQrT7a7FzUiCvu9GLSUBYl3IUivwCBN9CI/k7BF/g96T9Crv4gugMCov2U7vtc9gx0fgqlu0LQUe7+W4GI5zYy0y1EqAg27foHClAWBxlaEU4Zj2k8ENqFabaCagI+eceEoQgYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XnKg5qC7; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6e2f12059f4so1405663a34.0
        for <linux-nfs@vger.kernel.org>; Sat, 17 Feb 2024 05:38:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708177102; x=1708781902; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FU391EAsgODVF+qcQK+AR6RH8BocoKT6FMOj/B+fsKs=;
        b=XnKg5qC7FH4f+VlvXKn8cSZgedjs9d4CNQzJQE5FqbDhZ6VxoHMUmfAm3RmW0rCWaj
         hT8tmPDe8VIn9hn4B1C5+eKA8EJq6g4voBoEYvlitRaaiTcp/9EV5VTtBfdkt+ooPSad
         dRb566+4VW0oSxdhrgvh9wPeWMQlHV4wbLel7ziN3VXd9HqH7DG0YILolWCSpcyQFxsD
         zHesnsYJbXgPohsXLRvCxIYuT8khHq5yT75/q9dI6aeEHAU9RoLhCwx9I6KSlWkGF6QV
         l2vc7PjzaFBzNplnrP/ISpD1j+C8/IH+5t4JOnYpMYEE/GuRWeLMZ8KscW89MBfSwJy7
         YmUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708177102; x=1708781902;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FU391EAsgODVF+qcQK+AR6RH8BocoKT6FMOj/B+fsKs=;
        b=kuaO1orLYwsXMPW27VNkjXnyIzUlAvR/2kYDqB6g0fHNseLcGiMco7cqiH9bO9IFSd
         hayF7Vb0YhsHySBlaO6Ex/0BW73Q+nRGXvTdwjDuhUfaIL63SwgVXj7TIpby41S8GHCX
         uMknIrRCz0KEQQk30wFHNcXDvWuYh57qNKWI5iYpiFgX3RpzEZVRX967NZ//5LSHoKBu
         LfLFYLaK1MoZyXe7Iu8FEC/FxUpkHzjp7yPT4DNrFHsTwyIP3bUUCt4ye/cIIMRP5h+D
         +qt+CTm0rcm0xiACMNCiFRJx1ZgUfzpq9PqzqGgVmk2rvihk41ft55RI+o/HCA1A129K
         z6BA==
X-Gm-Message-State: AOJu0YzQFXHGmlelGF+x7uBnbwfbrSQjVOY9vpuVsBlzTvHCJogV9/6o
	JFL2utHlgVCRV6AHgxBcyPa55SfBn8T0ZbRiRPSJ4lm4/7RQj5mPY5TvK/RQto9aPrAJb/ynMdr
	lg3rxABpNqI4cItyMApYSY2IYGQVnWyo9
X-Google-Smtp-Source: AGHT+IEm8+GzIfFrCaSwkNAntLp+AFIs9oxU5WkfuefB6nyGBprmJnfwcVNGMuxyfMaiJwpCejv9aMVZxlpyVcXHlzQ=
X-Received: by 2002:a05:6871:5213:b0:218:51a7:66bc with SMTP id
 ht19-20020a056871521300b0021851a766bcmr8221471oac.19.1708177102533; Sat, 17
 Feb 2024 05:38:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANH4o6P-jze6MB8yh3sWxhyHJWdj+JHK3vw58cYwQ0a7eVe_Vg@mail.gmail.com>
 <c397fb11a172be26111e1ad5cb17a92bceb065d3.camel@kernel.org>
In-Reply-To: <c397fb11a172be26111e1ad5cb17a92bceb065d3.camel@kernel.org>
From: Martin Wege <martin.l.wege@gmail.com>
Date: Sat, 17 Feb 2024 14:37:00 +0100
Message-ID: <CANH4o6O-Gcjc3eqiTd-KysZx-bpbzoh=CMTNixJ26cZQuRd=UQ@mail.gmail.com>
Subject: Re: SELinux-Support in Linux NFSv4.1 impl?
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 14, 2024 at 12:28=E2=80=AFPM Jeff Layton <jlayton@kernel.org> w=
rote:
>
> On Wed, 2024-02-14 at 10:46 +0100, Martin Wege wrote:
> > Hello,
> >
> > Does the Linux implementation server&client for NFSv4.1 support SELinux=
?
> >
> >
>
> Labeled NFS is a NFSv4.2 feature. The Linux client and server do support

Is there documentation on how to set this up? Will this work if the
root fs ('/') is NFSv4.2?

Thanks,
Martin

