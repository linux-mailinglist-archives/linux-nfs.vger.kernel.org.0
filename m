Return-Path: <linux-nfs+bounces-17283-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A8B7CD834C
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Dec 2025 06:41:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BF5FD3021E73
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Dec 2025 05:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 116B42F3C02;
	Tue, 23 Dec 2025 05:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AmuGU0S3"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06ABD234973
	for <linux-nfs@vger.kernel.org>; Tue, 23 Dec 2025 05:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766468350; cv=none; b=LlUfCbUuqY5TMuHeuyoFm12w66admgCHQ0929JDPbReM7q1xdIX2oArzjw9GxOtZMM6g6Dd4gSj7qqIYaZppAfN2JzN/IRDxJbBNEKzd1h7rWYldi6Y9Wqar1txO3Ep9xBxa3gZkNUbkMnVDt0hjjrpqT8L94Egsk+PdE4c51Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766468350; c=relaxed/simple;
	bh=4EYwI5dt6aXRXkl+FSZUrQuoyCBEuH9OaUQ78T0nqW0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UyXCFGsWDSXZvkz/M6tmmTCR956I4V627Z6kfFvtmHEbceX0K0bt8QcJsS6wLbTiXqcJoj970QaYSJhAQMWhdMHoKdVX44het/TQi2SA9Kzza5B30cImNCszZH3C0/64F8JirdjGy3+X8h49JDpZA0UQteNw2+iWdJ8sa3BLUt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AmuGU0S3; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2a0a33d0585so43699345ad.1
        for <linux-nfs@vger.kernel.org>; Mon, 22 Dec 2025 21:39:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766468347; x=1767073147; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V0Oa5NOGMRC1AJFdH7RGft89mUSkkZqf9Qovy9KVtFo=;
        b=AmuGU0S3tNTq4XtJ8CPVuHsrup5GslR4U1PsfZM5q7Es9j9PRoBOtcmrNZjZY9bYX2
         UKR+5USfuLaeedQBq8VdFeWlSpdtJwj9cUx0XSPWF6iw2+/Dx0Y5UVucH/qMMErYNCo2
         DmPMJSCgLNX8OFyioDFMPSDOCAjVz+YVUY/Iz/KUSFGJ2xhlgSyingmuGzIf1Ot4VcrN
         bRMe9e6HU5DXOTn41IlUPOezYioUBfH4sOmBJ/VJV2wbgRChwx/8WJgiqq1vVmt2UJG1
         sPq57LHY2hmsktX2yrFZnu8K5GlUfYr80BrqjJruZXf92pssdcqPz8wFkvEzjVdz2E5K
         tIhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766468347; x=1767073147;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V0Oa5NOGMRC1AJFdH7RGft89mUSkkZqf9Qovy9KVtFo=;
        b=JM9OxHH5h0S4u0kog8bSy+l5zvi4xJ7Rde5k1H0F2D5VX3HJQDTyT1Y7r6z4BzmnFb
         4lgFNnjBD+x4YVXs5gLj0iKCY3bOZRoMSqM/sl9jzzJyodSqiWFH5ihRPjXy1GCinUkF
         Y6MzmgELy9NDOVwkn4hEknCWQ8Y+nZ9fGVOWhuQl1epgRTlGYZM1IQr6ywhDN6k484LF
         Y8TWvTChmE+BAgVxPjTlwGA8cBVMbmPT0e0B3KsyGm1V8OaOwBnfgPKXP5+IRalbArG3
         Iq3gonEVWW8J3imxW4MOYYRi90awHLGywzuEQl8FV70iovO+QXM/4BKlB1tTE3rFwwcC
         SNZw==
X-Forwarded-Encrypted: i=1; AJvYcCW9lEblvHDYAexbVjNv4cTeHeQ2IeFtYXFXcduezqjTTVQ5p5ILmS3ra2CEXgtB9FT3LOgVPlweU9s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMMIk963Seop+Upy27ZhZpHAe2snrYIaa7WyCh0GSTz4MZTCEQ
	/Q39OR2v3xservInoD/x8KV8OFdG5/JCvkQR4pl4tbEELCYK+I+UD2WM
X-Gm-Gg: AY/fxX6LNgqt1pKL6ZSbSAo0k/oUx9H+X4yhmDIVaotnGwBR40RWOsmoG8lcOal5zYS
	8/eY1HFf/DFOqF3OniVIEiCcKXf6yyq15eqQGHGJVsZUwuO6g8GE3RwacUFlZERH5nUDQ/WqdpK
	CY9ZVCMjd3NsMLcCTj+tmHpslaVS7YDoe7/+1MKzW0RNE+sdZH0kAl9gfGKi8Bam7Tg7ZrbyzAl
	wf2KxCNKUDIsPZrX279FcD14m87ghaVD6q+xS3IVUUpgjWWgourtuqBAlivNNWvYQRrxUR5rre6
	f70wqnbFjTb/tj4zC/udYTnTAimrLOmozuEJhA5DYciX/3cA8T/rEMP5+WoHFpoQxUzW0HoCjmT
	sCTf5J3Vbmt0d8eobkukOlsTZpUN4XDV/GbXXBe2SB9Dt805nfEjV+rB2B3s3SD/S5QrhGEbDWi
	K24Sdv+okQ0knfNkzKkCf5k7NojugFVAYDAmnZkGPVjqmR3WxSasJetzBr4cx/xypZ
X-Google-Smtp-Source: AGHT+IFzlCLo+BvPmOwaQvXqt6LlTFpUSJebHNJribHXa7k68xn/ydFompByNLrYdKm0zAa3YWAnPw==
X-Received: by 2002:a05:7022:793:b0:11b:9386:8257 with SMTP id a92af1059eb24-12172302180mr11142291c88.44.1766468347292;
        Mon, 22 Dec 2025 21:39:07 -0800 (PST)
Received: from ?IPV6:2600:8802:b00:9ce0:637f:5cdc:9df0:d9ab? ([2600:8802:b00:9ce0:637f:5cdc:9df0:d9ab])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121724de268sm40285157c88.8.2025.12.22.21.39.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Dec 2025 21:39:06 -0800 (PST)
Message-ID: <bc999618-1f1a-4ae7-a81c-57062d57614d@gmail.com>
Date: Mon, 22 Dec 2025 21:39:05 -0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/11] xfs: enable non-blocking timestamp updates
To: Christoph Hellwig <hch@lst.de>, Christian Brauner <brauner@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, David Sterba <dsterba@suse.com>,
 Jan Kara <jack@suse.cz>, Mike Marshall <hubcap@omnibond.com>,
 Martin Brandenburg <martin@omnibond.com>, Carlos Maiolino <cem@kernel.org>,
 Stefan Roesch <shr@fb.com>, Jeff Layton <jlayton@kernel.org>,
 linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, gfs2@lists.linux.dev,
 io-uring@vger.kernel.org, devel@lists.orangefs.org,
 linux-unionfs@vger.kernel.org, linux-mtd@lists.infradead.org,
 linux-xfs@vger.kernel.org, linux-nfs@vger.kernel.org
References: <20251223003756.409543-1-hch@lst.de>
 <20251223003756.409543-12-hch@lst.de>
Content-Language: en-US
From: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
In-Reply-To: <20251223003756.409543-12-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/22/25 16:37, Christoph Hellwig wrote:
> The lazytime path using the generic helpers can never block in XFS
> because there is no ->dirty_inode method that could block.  Allow
> non-blocking timestamp updates for this case by replacing
> generic_update_time with the open coded version without the S_NOWAIT
> check.
>
> Fixes: 66fa3cedf16a ("fs: Add async write file modification handling.")
> Signed-off-by: Christoph Hellwig<hch@lst.de>
> Reviewed-by: Jeff Layton<jlayton@kernel.org>


Looks good.

Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>

-ck



