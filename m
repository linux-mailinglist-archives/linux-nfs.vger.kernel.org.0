Return-Path: <linux-nfs+bounces-17281-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EEEB5CD8334
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Dec 2025 06:39:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E26DB30562FA
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Dec 2025 05:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D2D2F5313;
	Tue, 23 Dec 2025 05:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m1L+FowU"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88A62F6927
	for <linux-nfs@vger.kernel.org>; Tue, 23 Dec 2025 05:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766468241; cv=none; b=uO/Kkv/VOfmbxQkXVLSV6l0Bdeec/oscfD+wnC5kjATHNijhOF3u54xN0nb6fMjIOayFktycmw5EkjaPpm6jik4dCEkh3F0xAD8hCIAAjAvpbZde1VYQiR1FlX6dSW4M12J5IeCPWE1EirWiC+JvnueCsrVMdW0Qi9kK8TOES10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766468241; c=relaxed/simple;
	bh=PhRs88mwlwkazk+ENj6MoiJDiZn71PTbJFD0EWthhgk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xb8DxNtfQCYK9La2Kr4uySkkditFYc2nLVFojK7c6y651YdVyuUs8C89ZYD5eTEj7Yegvs5wGVEJ6IHWbpWvbkSprLOkWTFpoYz4CZgxxWmwqFZFLx7GnQXfM3kojOHf8yPqBGrU7GsrPOcXuKE7IAiHStdef4rVQ6pnoacrlTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m1L+FowU; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2a0d67f1877so58344965ad.2
        for <linux-nfs@vger.kernel.org>; Mon, 22 Dec 2025 21:37:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766468238; x=1767073038; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A82QF1EkZtulULncIKG5BayS1YlCBJFC1tpTXCRjsWA=;
        b=m1L+FowUPIMlYK4jS0rqd66lJOxSEu9UNgALQ5BaPsZY0mYIff/6weYhiZEE+MrrkM
         9aobe9ahzY2NcVvdmuxqVWtMOkmapJ04qlH+b0btXifJRKnEEtPaUiqLsELDhj6jt70w
         EK7sGlcQ5d76EwzvypNKWSgDYHmPE+8BHcUbIBj4EI4NxbY3KKCwI4ZDp1KQgpy98Bs5
         C6GPDqRf9SXQuuaRHvzF4K3LE21rBYkM/shcj4phJZQDM3tLR9Z+daG+i6MPaX8M21Le
         aEgz9SUcfIi+tbtgXj18ewhgT+GqS2CX4Nhkk1K9SsmOF/RYGt1NhIV1GMZhSPb1cXVy
         zIHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766468238; x=1767073038;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A82QF1EkZtulULncIKG5BayS1YlCBJFC1tpTXCRjsWA=;
        b=o5lZv3c5RfeLpI5LwND1glDM2NyCh1kmNN8s30Ev9ofET090ffhinmY5w/eTf8cHZx
         3/FpabmbiFCX1570TZkoiafun829Xy8n4rAwq/WOFTHufarFriSisUTad9H5XyWWIV8G
         4eOjfokWGevB1cM6V/LnK+fhS7uGeD4X6nIpK4GpdQrXpNIkQ9k8XN0BHiGD3gwgs8Ya
         oY98fW1Tq8J1FUUeVCMZWSEKZz6/CibNlQ1qYIH3cIaGPC+b1qoAOgOCmaeT2skDpDGQ
         3EXgc/zeayHqhZM2YOtNwIYD6EzNIC3XEaDbUonWPQAETu27sv7dLohyLWk4J0KPvql7
         NpbQ==
X-Forwarded-Encrypted: i=1; AJvYcCWUfjfbdB6WlDT3/A8XNZUdHn8BgWrZScTquG6lzbdFZJDjJPx3fIKYiC+YcpRcrbW9wWNq3cgOZ3Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8AJ9PYCfJH/lsFKQ7C+7vRuK3lF15Fqe/RF6CLjq/uToYDRQO
	dTRbQ6SL2cMuhpBBoeZV0T3QeALAdNN8AI+a480hZbR+NENc8yl5NK9B
X-Gm-Gg: AY/fxX6E+8H11ZUDIj3vOe/GdRp7Mz6e3CpIPE4Mha9LxdfRrs4t3+UCnqB002g/TA3
	zIu41t40paBVj++5hbr1i92RcAOwDbUVwyGRgL3quX6ApEZ7+hTz/wmvH61/oNvQXa5uTyvk84Z
	XMax3mNVDoYHyDsi8DEM+evVH2Iaz8rtQPJGgKfxEeKt/KpVEMBS3lSyUZVTSv8r1cvUGlD2Bni
	MTl3rL7ydGHlReVKfRvBdeZte87aEwzMZvnUXVlOQQya6s7mQADoNYu8FbdN2wPFIKZXSwPF9lJ
	NqX7BVAaKBzkqs4WNXK7CBD1w5rehC1t8Y/S1jra+f9/VLPhPTsxjRMRcz+pchmvANPd8rynzoV
	XzGGLdGahjxvHJ2JhJYt+x4KftCEJRlvBFdJUKhqG9sJQQi3jhmYna7jAN2WfRu+41DiffYNoe3
	/CfJQq5/KGkuyG7GavkblKikrgJkWHuITzqkPfOipWFN2aJmbEwcoPr/ECR7SO3CGpBP3YvS6cm
	FA=
X-Google-Smtp-Source: AGHT+IFuAa1bEi9iXQ/fVsFOwY92P7NTqag0Itb/bLEcgCW/+Bj05+w6CIPRTwzaf559s5BnxudUFg==
X-Received: by 2002:a05:7022:1e01:b0:11a:5ee1:fd8a with SMTP id a92af1059eb24-121722ab372mr13830811c88.13.1766468237569;
        Mon, 22 Dec 2025 21:37:17 -0800 (PST)
Received: from ?IPV6:2600:8802:b00:9ce0:637f:5cdc:9df0:d9ab? ([2600:8802:b00:9ce0:637f:5cdc:9df0:d9ab])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121724cfd95sm52514131c88.1.2025.12.22.21.37.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Dec 2025 21:37:17 -0800 (PST)
Message-ID: <5789c903-d3f6-4c41-b342-8d29387688e5@gmail.com>
Date: Mon, 22 Dec 2025 21:37:16 -0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/11] fs: add a ->sync_lazytime method
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
 <20251223003756.409543-8-hch@lst.de>
Content-Language: en-US
From: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
In-Reply-To: <20251223003756.409543-8-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/22/25 16:37, Christoph Hellwig wrote:
> Allow the file system to explicitly implement lazytime syncing instead
> of pigging back on generic inode dirtying.  This allows to simplify
> the XFS implementation and prepares for non-blocking lazytime timestamp
> updates.
>
> Signed-off-by: Christoph Hellwig<hch@lst.de>
> Reviewed-by: Jeff Layton<jlayton@kernel.org>


Looks good.

Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>

-ck


