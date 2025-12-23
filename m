Return-Path: <linux-nfs+bounces-17279-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D43BCD82C5
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Dec 2025 06:36:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5D7703021792
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Dec 2025 05:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 847E22F6164;
	Tue, 23 Dec 2025 05:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ung45Q84"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562032F291A
	for <linux-nfs@vger.kernel.org>; Tue, 23 Dec 2025 05:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766468173; cv=none; b=s3cIbiKfc4IC9YOeNkF/Ag7+XkejRjaJPW7EwkF+HjPVjqmH/c101zmFFswzpY23ULizp/8jkLp8j0shuYoV21OTIsQtJOMc40ysIOwCQa8aNlkrmM16NqJPq7Dl9akGcL2hSrISbZMAi2ZrpW0ISD5YAwO56OfZwLb2Nlwsbpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766468173; c=relaxed/simple;
	bh=lW+UmIWRSVZ7zpivjjDN2RAk8y2uECMzZoBmWD3afKc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kUf4udel5OrlGEjC5P7uZi7JZGGg8OY5LE65ZOEswEtDBrYVyhRpLx9QMTrzlclBIpsK54iqah76Tsa2AhkgFlui0c5vcejDR93/FixKAWsTpAxQw32GCk3PpJ8UPKjU3gVVX9eLkZAF5K4itYQOvTV7Uf1ek2Udr/aJpfwwqqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ung45Q84; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2a0f3f74587so64984185ad.2
        for <linux-nfs@vger.kernel.org>; Mon, 22 Dec 2025 21:36:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766468169; x=1767072969; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lW+UmIWRSVZ7zpivjjDN2RAk8y2uECMzZoBmWD3afKc=;
        b=Ung45Q84NKJpgXUpj6V9c/ed39FtjE6rEaUqQWkJJFS7fjSzXwil3mKYAY6k0P8R9Z
         ddtgTfoZNL09/7vdeIMFC9JYApmDKSVclj15wMPBUSYzvYzI2V1K6y3+4OrBFi1YYL2i
         Ygo61aSI7PTM3LrIlLqoQR3YIwD47T+aDfeoHcsd1atowsBYoyrx6dnbVIVfEB/MalJF
         2NuWCA0r1bN8toEVguQoOSvqibnOTY8FjNDSkJ/sdULSEVFDzpcjyqioyPm4wEmXqrj1
         ilE8f7MJVCDOQnn9/KIYfxwD2zQKhMHjA+B/jiX/srEFwN0w8KKug3A4yAIpvlDCg4c+
         GzLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766468169; x=1767072969;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lW+UmIWRSVZ7zpivjjDN2RAk8y2uECMzZoBmWD3afKc=;
        b=hEz1yRJquApSvQ7pi76YkiNKsbEjzWpevzJ3TkvfZ9kpPlZT4OlyoD7L/X0+EiOGro
         zhY3WsM6+p9h4s69BcRsVW1r0AMOeU4S7kTtTNuYxtcQSwSOlHlGAsbkBO/i+taSbQAV
         Rwt2WXzTtp927wm/5X/49puc7piayw/DISRmI1klfN1zt5IB020JewzUuIXWpFIKJoo0
         DB5yWOPOeRyz7n4TcdcdfQr3vtNWhv/b4BJLaBey3JtwPh3XPs+4rlggjKuonP8+WtNV
         V3OjcWoHuYun5V4YZohBQZKm3k+u7IEKo6V0DG/8rLn5OqewtN/XMbNSdhzRp7/TlPc0
         AwIg==
X-Forwarded-Encrypted: i=1; AJvYcCWt/EoSm62t2z7TMfe5onJy/6Sx68CbF9t8sdwFNTMQeuVnxnlOCtZRQtEQGfS3e0aIq8brIrLodVQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXzBpMGUppAmipDZEzyT/Ap5TpltPewOq6HXccjdl6tWQQsTPj
	7614ShphkXUDA49hbzfSqKEvP5U8CnMpt13mvyxVbzySRZCLouZiligx
X-Gm-Gg: AY/fxX59HnXFShcgO7qzuZWIJgWC3KTPE04aqI9Vsp2EQZ+94dpNoIZ2l7V0jhuUrP/
	7w5AmKlUmdCUEtLzOKBaND8N1zV8Ti+uj8X9hrhkk1X++F2aUm1VoIygVZ0qs5vQDwg1lzwn27Z
	zgChEaB0d2pf8OgCw2qJq/U6wQW28R3Rp0ixP1djckUfcxHSS6tmADl6zqPwf8OQIuwexul1cLd
	NGguf/EqhDDO5zbz1VqSY6/rx3YwhKZ4ukdn9cFD07dTV/KUt5D3+ABuNxhuru52sFplmYw1P0q
	v5pwogSoqvSghN7Tv4hOJ4ozIV/o9KgXr6tGWBupEfOJMgUz8P+HhSLsEninRUSwSPspuHOaHq0
	OO3KGGaecz9rIzjx+Fd5b7AP6MW8cB8PQEPi3psMIGye3rRV130Spsb1mEU1iB2hMb6XfVUrVNJ
	/OC96jWnOXP5jWCnM0bWnv0pDGJrr8BGL0o8QCKsXEHLCxqlkTvWNKo5aJrhGaW+mz
X-Google-Smtp-Source: AGHT+IH379xsDZ0d7vjKdC6ERRiENfgRNsDKq+A1tK8cXdwsmB2ywvOol5d1N83fquxU7SkCjjJrLg==
X-Received: by 2002:a05:7022:3b8a:b0:11b:79f1:850 with SMTP id a92af1059eb24-121722b7f23mr14589383c88.14.1766468169469;
        Mon, 22 Dec 2025 21:36:09 -0800 (PST)
Received: from ?IPV6:2600:8802:b00:9ce0:637f:5cdc:9df0:d9ab? ([2600:8802:b00:9ce0:637f:5cdc:9df0:d9ab])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1217254ce49sm52556580c88.15.2025.12.22.21.36.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Dec 2025 21:36:09 -0800 (PST)
Message-ID: <e2d34cef-c0f4-4f27-91a0-439f85ed26b5@gmail.com>
Date: Mon, 22 Dec 2025 21:36:08 -0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/11] fs: return I_DIRTY_* and allow error returns from
 inode_update_timestamps
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
 <20251223003756.409543-6-hch@lst.de>
Content-Language: en-US
From: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
In-Reply-To: <20251223003756.409543-6-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/22/25 16:37, Christoph Hellwig wrote:
> Change the inode_update_timestamps calling convention, so that instead
> of returning the updated flags that are only needed to calculate the
> I_DIRTY_* flags, return the I_DIRTY_* flags diretly in an argument, and
> reserve the return value to return an error code, which will be needed to
> support non-blocking timestamp updates.
>
> Signed-off-by: Christoph Hellwig<hch@lst.de>

Looks good.

Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>

-ck



