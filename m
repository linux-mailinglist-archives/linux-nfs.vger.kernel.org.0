Return-Path: <linux-nfs+bounces-10200-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AEE2A3DAF2
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Feb 2025 14:11:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F405A3B979F
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Feb 2025 13:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E178B1F584A;
	Thu, 20 Feb 2025 13:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="C+R/Hau2"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720201F7916
	for <linux-nfs@vger.kernel.org>; Thu, 20 Feb 2025 13:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740056974; cv=none; b=NRAVUDXXOMoiqGM+m/ErjVF+f6KuD7YRLC8L6FfpQcTM1wBh+fOASxgYyD+dveL3HyC9UgVzzB0/WPjPiHq9KKdL5V/s+fXjDmYOXKXQ9FZjI0m8a9p3Z9lbTZDdYEHtFWIpcRLP8W7omNi5SEBb5jeje3+dc5749obhVoAbiaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740056974; c=relaxed/simple;
	bh=659Z5MgEmFp3Njkp+0t+ptDcYZt275fHIOylgA3dWnI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KJskdN4Mk7C7Dgk5uIyWSR7fGSHP1gGUXKUxkkrchE6JVYiGxPhyE6Sf7txkgpSZnBx44hJbYvhiBS6TFW2MGda7akjvKriuoguxQR/x8qBPQoDvIwS5oFEfMGqOSMAiitKxbP99PtlG/kp9sJw9hnPwT+yivSSoZDEbqBG278s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=C+R/Hau2; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5ded368fcd9so1341594a12.1
        for <linux-nfs@vger.kernel.org>; Thu, 20 Feb 2025 05:09:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1740056970; x=1740661770; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=659Z5MgEmFp3Njkp+0t+ptDcYZt275fHIOylgA3dWnI=;
        b=C+R/Hau2g+pBGqJmjAtbmtdL4dsKHvh6W7yvQnKEdbklRIwFMFGdYGhITZMoWdp/3v
         T1XbuvI1Ii71umHss37hwhdik1dlBn7Da8j4n0Rj9iiiHEIFgRwrrUAFPKDfimtm/Tiw
         EmtVGn5CMNJ8V68pMFv4F8tsCO2YOh1cSRKHUYXOnGP5Cm4cjKeDMkdgbBe5zkRej0QQ
         G+cB0eZxXc/RTvXLGu748Tflpv15LVix8Fik43Fsg+LowGVYwwUImusgeh5lPcVJqufh
         gnctRt3OjZWL5bgd5y4llre2YSRXbTUzNsRKm/cdRNjyuyljn9TMJYCrKw/UGh36wo2k
         a50A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740056970; x=1740661770;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=659Z5MgEmFp3Njkp+0t+ptDcYZt275fHIOylgA3dWnI=;
        b=qigyZVMVztPXIA6AywW+ZeS4k0lBf3vAh5S5wmeM3a634VUipcE/yfBdguRNJ3CwnR
         UQwhqSJQ4XkPmapVo37/6F1au0Qyu5PLkXaUo34ycli3VnLh87lDksnn7s7IQSLdqwgC
         nM6MjhlrrVDGVVu4tBYnTNIvT7eWt3ey7tkpdU64BGVAmccnINqOR33D34VCcLy61kQy
         5Rx3LIGaTC8J9Z9roDJctuvppMt8cy5WbxDMm81VeYPUB8U4hPSxwNgSbWf2r5NH4K5e
         RolrA4rawviA898Y1fWixvhSTTDIXmFvD8+duDQkcJE/ghHvHAyosOSdJ2MFMGOlqPUH
         zgkg==
X-Forwarded-Encrypted: i=1; AJvYcCUANbjVT0XPyVt7YJaQ56TXcOyAumlzt5Cr+FtRkFeLAke5uSHI7Csy8jv7/yEuyovogk+R6g449Zw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZnQCSmCdN4lB3FK75H7lMR8WA3cRj0voe4knS7JX/+QE1CSCp
	lVxcDzME5qCprg1IcWA/ZioSfVxnwGLm+43KseO7swaMCNcIqurOtcpQ3hv7B96r/zTxprv0T7A
	UW1Hwc0J/4k+Bq0efx33EP1SUh4ZFlClvjQwlcQ==
X-Gm-Gg: ASbGncuOcN/bvgFB++TL9zdSGJbhdtINDPBampytgfLoD34/DToXma0RsnnT+6igVBu
	JSdldJ1MLJ3Q3nDS14AHJuMZLmyfP2pPogSUkRa0P4tJNF/PwpAwwTPF1Qj8NjjRaoHuWc6/IqH
	XiGzSsR9csqxCjDrzIp3aezJDgqg==
X-Google-Smtp-Source: AGHT+IGPoX+5794U07EydT48UEKhGOyMUOF2FtzKyULbqoGRP0V32LcSKq9unFMC783mM102XE9wLcWd7UMwvlaZCoY=
X-Received: by 2002:a17:906:dc90:b0:ab7:86af:9e19 with SMTP id
 a640c23a62f3a-abbcd05a611mr799771966b.43.1740056969659; Thu, 20 Feb 2025
 05:09:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKPOu+_4mUwYgQtRTbXCmi+-k3PGvLysnPadkmHOyB7Gz0iSMA@mail.gmail.com>
 <20250210191118.3444416-1-max.kellermann@ionos.com> <3978045.1739537266@warthog.procyon.org.uk>
In-Reply-To: <3978045.1739537266@warthog.procyon.org.uk>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Thu, 20 Feb 2025 14:09:17 +0100
X-Gm-Features: AWEUYZmpP9P0Gfh3rezBjkEnKqpCWeO7xkkWonrM0Uq7UsX6pZI6C3FwpwtpoBk
Message-ID: <CAKPOu+8cD=HkoNYYknivDJnb6Pfxv+KF28SBUDEqha4NE5sxhg@mail.gmail.com>
Subject: Re: [PATCH] fs/netfs/read_collect: add to next->prev_donated
To: David Howells <dhowells@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: netfs@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 14, 2025 at 1:47=E2=80=AFPM David Howells <dhowells@redhat.com>=
 wrote:
> Signed-off-by: David Howells <dhowells@redhat.com>

Greg, you merged my other two netfs fixes into 6.13.3, but omitted
this one. Did you miss it, or was there another reason?

