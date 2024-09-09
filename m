Return-Path: <linux-nfs+bounces-6334-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E78970DBC
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Sep 2024 08:05:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28AF228280B
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Sep 2024 06:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F0C6101E2;
	Mon,  9 Sep 2024 06:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vastdata.com header.i=@vastdata.com header.b="FfD+3DTC"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569734C8D
	for <linux-nfs@vger.kernel.org>; Mon,  9 Sep 2024 06:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725861917; cv=none; b=fIglaqdsZ7CAp+KxL8jwLEYxcdwHk/MDkRVvIlkdrsCve7T6taETrzFdEndG2qmW/I+QUWKF8+VrEAZbrjFsZWT/KnIkFgmfi9R3mIFA40CfshnQDWRlW8Rwm8s3dFnD7Q1JiIdLEesp3QqTxwtJCoGurOqZ4wwNsqb9cfFYSXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725861917; c=relaxed/simple;
	bh=uWG3UQ6Yz+jGJTmFmZNvfWc6Odjx5yZo+vEUV6wuzJ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F8flBi8VxEam0quqidkgs7TM6pO8SoZEEE9YX/jKifcbYcrGoltUhRKhw1A1ybLajHuTaLManFtsxDxlMvzfSlQCUw5Fplu4poWK1rh8nVEiY84nkE2NYp8oKzo4HU9ap1xWz7H/XvqpIETtdpzFfKh7xBGZCS1XOA7I/1ymca4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vastdata.com; spf=pass smtp.mailfrom=vastdata.com; dkim=pass (2048-bit key) header.d=vastdata.com header.i=@vastdata.com header.b=FfD+3DTC; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vastdata.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vastdata.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a86e9db75b9so502289266b.1
        for <linux-nfs@vger.kernel.org>; Sun, 08 Sep 2024 23:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vastdata.com; s=google; t=1725861913; x=1726466713; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W4WNrtdbvXBoP/zdwr/qRDD0itLSIUcwjbrJN9ZpxJc=;
        b=FfD+3DTCcmuV+NMG9b2HDGmQUwuG31cfnJM/oP/ifbybi++HFdddrSeZwG4ubg8H2l
         YqFfgUJ0/y27On6MVfSacIE3QZs8VyE2lFQX/6Lna7YEWqI72jUz4ABNIRXAc/Z3GBvd
         cHhnnFtb3nWJmCjzDAC6hz0VkpclLyUqIxZ40QkBzRDtDDHXKRYdTfaI19CWUm9Jwwb4
         9b78G8fkswi3c1kWl+yQhfMzwU1NYncJAZFp9p2LX9uH7ECdemBT/bZU0y26TSkT4mis
         dmpTxaoMjqIVfh1jfUnjgokAVumXYQLZdtPOYHaNXx7jMxasYqVXTlID9RT3IxuG9cxL
         oIow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725861913; x=1726466713;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W4WNrtdbvXBoP/zdwr/qRDD0itLSIUcwjbrJN9ZpxJc=;
        b=OhcMagOyaSgTIzNfJCcgkWbiygcDHjm7CO7X6jaPiqb9EMvGzGOE8TdlKt5NF1KI7W
         ZcyjffiDyPMR2qDPUVgMDF4Wfr+G09eaPntxneGH0NZEjl9yILqvp7AqQlJHaIAP9K4A
         OUfGg09nWUKTG6LxPb2kG6VNSmXNUwhp1Lrjo4GLIJ+Q6Fe9XvWLIAwMxGDx1XS6bn3i
         sW6tjzmuDxf0lWQQbjpjimagSxCkSj6EHuyR7117j3Cz7lBhsrE+qYJboo8q9PkFSckJ
         QZZRzGwxi80BB9aYkvYXEhYkpK1Vbg+aBiNkdfaXeQsOhJ4XH2tk7RaB68y2AHpPV+Dg
         p4IQ==
X-Gm-Message-State: AOJu0YxUuCpOlqNfn5Z0ryQGU9AxeUZWUNwWRjo3CxBWZfYdn4WxjIiD
	PUnRiUr1tVPL1teFb9RGy0Ngf24YuFceTSBVjqtJTYn0yixm/WPzrUPHqbwqz7in6snAUlMdU96
	YsD0X21kvkhr76PJ9Q3Hn6FDCFfHZ/ijRMlqZjw==
X-Google-Smtp-Source: AGHT+IHzWOAKvmKopVMiK1br8VvWK6bpCSYuRpaDjNnypsUriCVRoBpKyJ0lj/7Xp1Z+ljBGfU/b0z8iBJlPzDITK3E=
X-Received: by 2002:a17:907:801:b0:a83:94bd:d913 with SMTP id
 a640c23a62f3a-a8a885c0116mr807901666b.10.1725861912573; Sun, 08 Sep 2024
 23:05:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAF3mN6VbfgBV-o5yiSRn=PHAMO1be7G5H5wYRSsasYJ0Pvwv9w@mail.gmail.com>
 <48295036a03cf9806eb5a42f890af2e43d9980a6.camel@hammerspace.com>
In-Reply-To: <48295036a03cf9806eb5a42f890af2e43d9980a6.camel@hammerspace.com>
From: Roi Azarzar <roi.azarzar@vastdata.com>
Date: Mon, 9 Sep 2024 09:05:01 +0300
Message-ID: <CAF3mN6WsrQioFW09MSxjgdGsG_VG87JhW=1Y5geErfEHWW+CZQ@mail.gmail.com>
Subject: Re: Suggested patch for fixing NFS_CAP_DELEGTIME capability
 indication in the client side
To: Trond Myklebust <trondmy@hammerspace.com>
Cc: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>, "jlayton@kernel.org" <jlayton@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Isn't the following clearer?
               if ((res.attr_bitmask[2] &
FATTR4_WORD2_TIME_DELEG_MODIFY) &&
(res.open_caps.oa_share_access_want[0] &
NFS4_SHARE_WANT_DELEG_TIMESTAMPS))
                      server->caps |=3D NFS_CAP_DELEGTIME;

What about TIME_DELEG_ACCESS? shouldn't we add it to the above
condition in the same manner ?


On Sun, Sep 8, 2024 at 7:55=E2=80=AFPM Trond Myklebust <trondmy@hammerspace=
.com> wrote:
>
> On Sun, 2024-09-08 at 17:34 +0300, Roi Azarzar wrote:
> > Hi,
> >
> > as discussed with @Jeff Layton sending a suggested patch that aims to
> > fix NFS_CAP_DELEGTIME capability indication in the client side by
> > setting it according to FATTR4_OPEN_ARGUMENTS response (and not
> > according to TIME_DELEG_MODIFY) support as draft-ietf-nfsv4-delstid-
> > 02
> >  suggested.
> >
>
> NACK. I agree that we should turn off NFS_CAP_DELEGTIME if the open
> arguments don't support it, but we should not turn it on unless the
> server has indicated that it supports the attribute.
>
> i.e. the correct change here is
>
> +               if (!(res.open_caps.oa_share_access_want[0] &
> +                     NFS4_SHARE_WANT_DELEG_TIMESTAMPS))
> +                       server->caps &=3D ~NFS_CAP_DELEGTIME;
>
> --
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
>
>

