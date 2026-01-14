Return-Path: <linux-nfs+bounces-17825-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 181AAD1BD9D
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Jan 2026 01:48:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F2D2C3025FA9
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Jan 2026 00:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 315F0209F43;
	Wed, 14 Jan 2026 00:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aegxhiyz"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085FD16DC28
	for <linux-nfs@vger.kernel.org>; Wed, 14 Jan 2026 00:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768351551; cv=none; b=gFthVOKjIf4gbajK5/VkLZROwYFQ1z+YY6cycl0YogQjLINMigfxYK1LXL8M5WlGwKlUrQ/BY/PkBm3lQ+VLTcQ4kZVuncf+OiqfPmmK+MkiUCKWPhUOHeku0w1xCSuKVqKeMzVraSEm8M7FOu3vJBOa8YU7OUujR3d44wHGGmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768351551; c=relaxed/simple;
	bh=4llGXYRvuSMJm3v6qdRICwJXYadi0GowtdAQN+mKeFI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WN7VW9khDVL8ZQw4Huzv2CLa6U/Q7Lx69wH2CszIT5ST5/rvjs8kdfZwy/pi3fRWJbGdYNLErTwHvohddNBQ9aAkjNqdjeLrNnL6+F5iVFM9K9XYcSBvB+xT+l0P5KBn5kvLVI26yTjlht8sbq7FX/OTGqdlLpsgXbMx9bwXH5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aegxhiyz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2A09C2BC9E
	for <linux-nfs@vger.kernel.org>; Wed, 14 Jan 2026 00:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768351550;
	bh=4llGXYRvuSMJm3v6qdRICwJXYadi0GowtdAQN+mKeFI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=aegxhiyzNDsTONo0BQ3CWreC650nnrmMEf+kLyPIxzf7XtLyn0B9bkwoHca3n/8m0
	 x6oHaRAQbt2WgYJ+KPD2XrxzaG2RQbMIDBWaLXAOqKcFPpVU4vjCNruncTpNXM6ycg
	 YxLZ9UTyVBiFbimqvoxzp0rqUCvY6WJ7dm9N/EnyAIZj6lxIKOaLqIciSN/PmbnHkP
	 HYMd3CsDq5LcYCa52f0dZd9aaDcnzZgRM9kXwIpjqPpr+UKCFQJ0po6HPSVSiAIFp6
	 UzAr3YZr1zSK798EEOWbEchNRSsUGPbzbpWHmMlmkDqYF0oN+ANy0UWhHsTvGAamKt
	 +AxiaedWBNaGw==
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b8010b8f078so1359073366b.0
        for <linux-nfs@vger.kernel.org>; Tue, 13 Jan 2026 16:45:50 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXjFE+4Y+kTBeosyVSqC7AUwXDCmb7gyeoGs4NwHf8rYmVztFiGYk5wcU0to5jKcvEahNmCVvtUHCg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ+hI6dHlHmtNnUFkayjzQdysI87/3fbtaLzZ4Qpq1I7krtIoY
	Me5EfbqjLuA59AZ6qfTXWcBgfeWZQBvcBAesgsm/isJkFTCIPknWMV0xEjb7oHD5IjPqGRQbi2Z
	6d0sNMqEcq3DPFDL1axHroGuPWFhnm+c=
X-Received: by 2002:a17:906:7312:b0:b87:117f:b6f9 with SMTP id
 a640c23a62f3a-b8760fd6d98mr60394266b.8.1768351549250; Tue, 13 Jan 2026
 16:45:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260112174629.3729358-1-cel@kernel.org> <20260112174629.3729358-4-cel@kernel.org>
In-Reply-To: <20260112174629.3729358-4-cel@kernel.org>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Wed, 14 Jan 2026 09:45:37 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-FM9gLObB6w_sBxuVgW_R7ScA3B8sWEFa3L8jmrRn59Q@mail.gmail.com>
X-Gm-Features: AZwV_QjY05oXsdF3FxB0uAW8CMAbF6w80qw4f0NOwkoEhPhTLUPjoENgYHnABeY
Message-ID: <CAKYAXd-FM9gLObB6w_sBxuVgW_R7ScA3B8sWEFa3L8jmrRn59Q@mail.gmail.com>
Subject: Re: [PATCH v3 03/16] exfat: Implement fileattr_get for case sensitivity
To: Chuck Lever <cel@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, hirofumi@mail.parknet.co.jp, 
	sj1557.seo@samsung.com, yuezhang.mo@sony.com, 
	almaz.alexandrovich@paragon-software.com, slava@dubeyko.com, 
	glaubitz@physik.fu-berlin.de, frank.li@vivo.com, tytso@mit.edu, 
	adilger.kernel@dilger.ca, cem@kernel.org, sfrench@samba.org, pc@manguebit.org, 
	ronniesahlberg@gmail.com, sprasad@microsoft.com, trondmy@kernel.org, 
	anna@kernel.org, jaegeuk@kernel.org, chao@kernel.org, hansg@kernel.org, 
	senozhatsky@chromium.org, Chuck Lever <chuck.lever@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 13, 2026 at 2:46=E2=80=AFAM Chuck Lever <cel@kernel.org> wrote:
>
> From: Chuck Lever <chuck.lever@oracle.com>
>
> Report exFAT's case sensitivity behavior via the file_kattr boolean
> fields. exFAT is always case-insensitive (using an upcase table for
> comparison) and always preserves case at rest.
>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Thanks!

