Return-Path: <linux-nfs+bounces-17280-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4457DCD82E6
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Dec 2025 06:36:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A345C30198D2
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Dec 2025 05:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0FA82F49F0;
	Tue, 23 Dec 2025 05:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KAaAzbrs"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90CD2F39B9
	for <linux-nfs@vger.kernel.org>; Tue, 23 Dec 2025 05:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766468186; cv=none; b=aHT5bi5IDzZfqGa8ugFVc2tqiX4fZ8U6Q6hGmaRnUPX2I/V4nhxOEi5SR5Jw9tpwGnXRvoR7nkj9xZuPsGoOkVrMwr+QWH7Z+sImchmVnt7WVkSfIzy+PWFiQFPtG4Vy0AhytBWpLFibI7schWqKHi+Cu9bcW5bJcju4Nw/f6cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766468186; c=relaxed/simple;
	bh=VlgqwkzGyrE3K5mQqCM6bG2Y747dQIeSyi7etFJLJbQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b5J0O8oEZAhugHGpN9b+lr/1TLcO3InXvIT1u5kK7uqXdUMaLylABdDx6jxWjeP8QXkP7GScmus3/LzK1NZwX23ddOX50QRFByCxg09ma7r1HAjMornyDPqCG84xejI15t72iJU3OIGCeZ8Bt49K05j8iSnKAIi5kOLWGY87k7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KAaAzbrs; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-34c2f335681so3616547a91.1
        for <linux-nfs@vger.kernel.org>; Mon, 22 Dec 2025 21:36:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766468184; x=1767072984; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VlgqwkzGyrE3K5mQqCM6bG2Y747dQIeSyi7etFJLJbQ=;
        b=KAaAzbrsGMa/yJ+ZeX66ACX313azU6u48dvdzrBwSic4HN62sJmYDXTq+VchukDU1L
         8sG8trF29f9VOcpuO7lWFH+BtnrkVzkWLbshB/5Fh07Cpq7NqkxHa1xuesIgnE8tH8Qo
         c3+byqUdmpSNC/AP16Hdfch35yejCD2kiF38JOHoQK6gtdj4WyMVRlnjcQ++8plqDvIq
         NINaKHODJxbdRib8oUYW69eNX7+AvJttzXqe0FP4ujNyHKM+xMXIBDuh4kEtf5cTmD4y
         0aVURA8jPi1DS5UAj6B/qSuo7DCtY/esApe51d34XyvYMy48PHQzwV0SOMUwYx1DdqtY
         fU8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766468184; x=1767072984;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VlgqwkzGyrE3K5mQqCM6bG2Y747dQIeSyi7etFJLJbQ=;
        b=wy3zI6h9GP6IijallGUpx8F8r9DAI05NcxpxfnFZrX+nJGdYMUabgOUBT9p8KcMqYL
         Wcn95NfGt/S06UD/PL40s9tR7xogmwMmxWCkArtoulF5WfYnD95ItEKeoyEIZCfPWIDv
         QkaAoJXIxxew/dSt2hmCzJV9cOKN3TWGtmDIfMKG4L9T0cfgiizP4Clh5pqXzmXNTScw
         98DAN5MlR4RSj8dJocyQIrB6H/HDseiUosLOgV6Er9aJ93DWN8heorSPpy6FvChodhUQ
         MuNWEhk6Pcdqfq8ZSVdxcCOwNULcypq7aC9jyOyiywit+mutFyKhvjctlrQpKkk/HD+M
         mPIQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5nl3PrvZquazZ1/BUfl7zrouc/Qv0Chwkk1TbFf7l0GJT7O1cL9yCJ5ywHa/OT3IRGE27ygQY37k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYTW41t69p+Mkl0MU5FA+HYOqVE69zUm7h3nT/0JB+2HdHvmA7
	zQNeYw9mSpANEhuZg9fp/myGWe7YiM0n9dhFSFyH6JS/bSpNbrL5K8lU
X-Gm-Gg: AY/fxX4qHnhVSgysVC+4xJDjoIbRUgcF/Fu/4smmawsE0oYfRyQ4cxyO97fqURENOVu
	Bj4Kv6JmdBj3fYLOOENlHz9xN86Gbul8RNnrhdmGUuiQeFdECEABTwjfA9AWmqLOqRzIcqojZzX
	UzQ98Pu98VANF4iKKIsLZ+kaT9xL7m7l3J3USZKhExSHCXi4kTU2DTMNTyU44dJPVmCYzaydPyp
	2ZYoL0Bm3tlj4lgsu4dBvefaLS/c24DVn43l+xcPunxrsVj2s4hEUzADcwAGofnWdiDI0WEG/Le
	9aCl/REDYs8RSyjzNldyXYQTijL5CDJ4b7+9uPvFx9EUPRHt9Q8yQiz+WUUH0UA1QpIfmhU36IN
	uezijG58hEdkHC5RROK3pwkAyAaNw8kdbviLu13omakVWb9Pba+ajWp/YYCT20ARThpRL5LN7Hr
	+J8CFcUfIvnC2ZdYo07f69Tmfv+/2TlEGW0wbpSKAzrekkeTUvMuyXUHEy2ZxFVqV5
X-Google-Smtp-Source: AGHT+IFX/6+bwcWXg/4km6FqYdkuwnUGcop1hJcfw4hTgcVNu0v2yNrPtPf/mgK+hd5hIFUJyC/N+g==
X-Received: by 2002:a05:7022:3705:b0:119:e56b:91e9 with SMTP id a92af1059eb24-121722dff1cmr11158229c88.26.1766468183950;
        Mon, 22 Dec 2025 21:36:23 -0800 (PST)
Received: from ?IPV6:2600:8802:b00:9ce0:637f:5cdc:9df0:d9ab? ([2600:8802:b00:9ce0:637f:5cdc:9df0:d9ab])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1217243bbe3sm54039368c88.0.2025.12.22.21.36.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Dec 2025 21:36:23 -0800 (PST)
Message-ID: <4e5f6df4-b446-4ec0-a0d9-231756ee934c@gmail.com>
Date: Mon, 22 Dec 2025 21:36:22 -0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/11] fs: factor out a sync_lazytime helper
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
 <20251223003756.409543-7-hch@lst.de>
Content-Language: en-US
From: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
In-Reply-To: <20251223003756.409543-7-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/22/25 16:37, Christoph Hellwig wrote:
> Centralize how we synchronize a lazytime update into the actual on-disk
> timestamp into a single helper.
>
> Signed-off-by: Christoph Hellwig<hch@lst.de>
> Reviewed-by: Jan Kara<jack@suse.cz>
> Reviewed-by: Jeff Layton<jlayton@kernel.org>

Looks good.

Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>

-ck



