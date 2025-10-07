Return-Path: <linux-nfs+bounces-15013-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E332FBC1673
	for <lists+linux-nfs@lfdr.de>; Tue, 07 Oct 2025 14:47:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BE94A4F5E4C
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Oct 2025 12:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B3032DC32A;
	Tue,  7 Oct 2025 12:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="QokZM0qJ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D7B2D9EC2
	for <linux-nfs@vger.kernel.org>; Tue,  7 Oct 2025 12:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759841245; cv=none; b=k29dRK3Su3aK+v59i8rrZmmAcr9VoKllTV5U5kL7RSQLDpcTDXgiTKuHns1nyNqSwE5RyyuDna9T0+tmlYJk16d+ZHe/EbVqZLzC/exVE80Gj4zL4B+h3fBOhNbQhuAkSq3u7ZO84jU+qsYucXXX2rTGfaTdFuw034cC61WJFiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759841245; c=relaxed/simple;
	bh=RQN/2lDlhzCHpCJtTDLlN1RlhI45f3qz73uJwycfNyE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=EQDvZ+qXwzKcLN/2Cjjccb54Zx6PxiIXeKQ6RY1asQagVWPklId54CfGQ8yBPLDOJWHWGHM7vfxfoEzMgvRYx+w9Fm5SiPGAv1GvH6AQnhf73QhsX0HZNRQ/Rmcmp0swjcY64iD7dX7uZrR7Si+tB9h+gK2toP45Q1fHb/NLlpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=QokZM0qJ; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-938de0df471so504532239f.2
        for <linux-nfs@vger.kernel.org>; Tue, 07 Oct 2025 05:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1759841242; x=1760446042; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CJuDLqWRo4Zntrd7FLhRCTIWZVZXh1mD+BCXSb25DVE=;
        b=QokZM0qJdV5QIxYrua/bpJ22oY2BnV9GPTZEEql/b5va0Gh3BNTQKKYGIREgbV1d/B
         oWHbaZCunLe5AfACdWoBEyXaOFa0kGEj+H8qKVzVinuTg0UKhMOsRNUlbEOiVmwLuCYs
         CPvoDpyfM69NZG+gkOI/1Kdiqh31iDopmAC40VYjY/D2bG1jUCFVKpgMakYSzMJQP8LZ
         cs75sNpUE8wnYZk9sUO50MgN6C71GNoxnYomQA08wxhBItUeDBENOF/g4jVCo4+SAjKe
         zXPb/E5HhRG73yC/NzhchCsPrXJb9rpFRXOLjbEWD+gm1KJjC4hQ47+CNciyEWYE2iKi
         Q4nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759841242; x=1760446042;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CJuDLqWRo4Zntrd7FLhRCTIWZVZXh1mD+BCXSb25DVE=;
        b=S/WeKGvIGHKN8D+jkaIdVL/DMlXfFkXTayz5bKYAM1Xk0kBaHOcbH+apV/LPW1SmqG
         wDEytqCtz9EZa5oVVt8fQZxesa6bMBXG5UB0ikVTCAD7FvPdeldMZ1m84yDZ/RcY3Rbm
         EMJIwTj3Tsd2NESGzjPhJwuN5MihmM1vOt3XnC1pqkAR7UTK3xqcMe7U6riK/Q0In5+o
         c82/Qnus9n9KcDz0Ov0PfwI4G4i0ViMDMmvIiUU1lXgBVhncqU2ZT3kfu/g+3MYTFb9E
         sGFH/n6BNykasovC6AFKrsBiUucSi0BpUwVEuU2S2qN2rqRLBtT67StPzYZSZznVpicf
         MFzA==
X-Forwarded-Encrypted: i=1; AJvYcCXVDDVAnJgpdCnazbhaThb9E1izLjWRXNR4RSlkgPdANmNzYvB3h/ZOHSNzr/YdSuuL+bFdBAE/X90=@vger.kernel.org
X-Gm-Message-State: AOJu0YysluZp8xFBM71c6vUOhVjKumI8xOFoIGZ5yjLnglebRi2LlTsg
	D/FA0q+vvFFCZb2hU3PPCTqbZxZGXrPjbfZrgxg7FSLC8PaQPju6seZpJ53g0+8LpeA=
X-Gm-Gg: ASbGncsN/LE7YMLd9FEwIUUGUOTQ98U2kiNdCemFwSLFYoHLOBNF71QF9XUYdmv1Lt2
	Z/1vZkt37hz8i7eU206s8GZ5QpWsFy8j4TL3ClkPzisK6c2GskA9Gqy/hEt/Xu/n4TDmyBnnr9d
	f6pVBrym1CvbvrdwSHnCRi0dGpFuEStruBBvkPk7nUuC5H+1ZMC1AAN5zvt+HvzcDhCdWeOR7AI
	KvwAlWxUIMOw5ubsc8B5PkGWlyKtaabdD7Q2uCOXcjHfliKKWLi+fixl1he4CgSYnXij+Sku1zZ
	bbVNlMGG6/Vcy+d6KHP3gEDy7gig1u0nPmecp7M6yvHVxuDSh/GL3247t/O/aQkpUJYNDyDT31E
	yuj1fvwsKUBl0L1F72Bb8vyMKesTG39eRAxY3UjsQzpc2ufxl93189GU=
X-Google-Smtp-Source: AGHT+IEhjV+rQNakagoyRfFs8Cw5QyuLbDFd/MmJxW09tmaws68gZlvukb/j2kPTZy0RgCpUbBD3iQ==
X-Received: by 2002:a05:6e02:1d89:b0:42e:38d1:7c61 with SMTP id e9e14a558f8ab-42e7ad8447dmr208356865ab.22.1759841242260;
        Tue, 07 Oct 2025 05:47:22 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-57b5ea3a5basm6128505173.23.2025.10.07.05.47.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Oct 2025 05:47:21 -0700 (PDT)
Message-ID: <a2cb114a-e31a-46d3-8c27-35149bed668f@kernel.dk>
Date: Tue, 7 Oct 2025 06:47:20 -0600
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [nfs?] [io-uring?] WARNING in nfsd_file_cache_init
To: syzbot <syzbot+a6f4d69b9b23404bbabf@syzkaller.appspotmail.com>,
 Dai.Ngo@oracle.com, chuck.lever@oracle.com, io-uring@vger.kernel.org,
 jlayton@kernel.org, linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org,
 neil@brown.name, okorniev@redhat.com, syzkaller-bugs@googlegroups.com,
 tom@talpey.com
References: <68e4a3d1.a00a0220.298cc0.0471.GAE@google.com>
From: Jens Axboe <axboe@kernel.dk>
Content-Language: en-US
In-Reply-To: <68e4a3d1.a00a0220.298cc0.0471.GAE@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Doesn't look like it's io_uring related:

#syz set subsystems: nfs

-- 
Jens Axboe

