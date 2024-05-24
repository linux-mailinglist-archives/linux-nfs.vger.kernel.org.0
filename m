Return-Path: <linux-nfs+bounces-3376-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 822658CE909
	for <lists+linux-nfs@lfdr.de>; Fri, 24 May 2024 19:09:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2177D1F21778
	for <lists+linux-nfs@lfdr.de>; Fri, 24 May 2024 17:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A82F3376EB;
	Fri, 24 May 2024 17:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PnRJH1jO"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0934E12EBD5
	for <linux-nfs@vger.kernel.org>; Fri, 24 May 2024 17:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716570561; cv=none; b=oAdNsOLrEhg8PHKAkGw+D3FwQ4BxZw71rRbOs86i5SEZpWpjuFIhDP3hPWxKUSEzIIzrC6kieO780kZgv/dMPGp3eLA2/5R8a59h8F9RdW5knG03I54ioq6XjGOg96HYVCEXeVbWJL5SHlBlowPbMWLvUovcAuma0d4Vhs1GTAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716570561; c=relaxed/simple;
	bh=qNIgV+zYuCw6AQg4t53gzr/BasCfHNnPNFYeg/DxxwE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R2gmIo0+DR1t2kKws14k7BMcR9CZ5IMaPghpPRrfigYg9Tg38gA6q0SmQlJoicSIpFZZmMI5hIXxng6zDP0xIG6I6sYrrm3ds/tT29c7O7umxKHKR6j4bxFb/BnIk7IThsC7QDT8a7OqPvKVamnRBQnl/JYCBqUQ41stC5q69vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PnRJH1jO; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2e95afec7e6so8743361fa.0
        for <linux-nfs@vger.kernel.org>; Fri, 24 May 2024 10:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716570558; x=1717175358; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1hNE1DUO9EWuL5FjLuf7/UTJBlZf8rRfdN2q01WBfOw=;
        b=PnRJH1jOYPj05BatbL5SKnjC5Q7CJwrdOeY1UkttNJ1G3JUgoQy5p6vAGun4/ih37I
         lLeAcyhDZitYvIGUXTiqVmCW7TH2da8VquQLD6nPvIaCRpd8J/+5HJaYf6OigmK/GlrI
         yozthzSvOSTegK0YbxQ/o8Vb6vaSi8F7Zz42ZYLZseBn0QPWOptQpCWU344t7ws6RqV2
         nUqXaiJjNvAH/kprNflZuL+b7ix88VMJLf4hJOgxi06pFSDxs6bJLumb+f3RvsTL50jR
         TT0r83/KamxcOm+vralpbSoHPLc8q0Vsv3444T+JiExVQpgFPKD98rMgbDzejszMl/V4
         +NYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716570558; x=1717175358;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1hNE1DUO9EWuL5FjLuf7/UTJBlZf8rRfdN2q01WBfOw=;
        b=ZAytRJ6M1D31IXVO4HNtG+tMFq2eSo6GHuFFmUwJSDitlY3UScS4zlLlL2qkUS0xYi
         L8z9bvXLmZ9yQNQWVxMVL/YNuaDMvtrJKGU/VR2apnKVRd5ss+4cLwxfOWjgOpOQqSbG
         tnLgh8GgRhbUp/0YRXBUyCQ3b25KsPw9yOM2BtbqPTg41byuvnKkLS7x0/rkiW2kYrf1
         RUqkNVYcUMFPI7beYyxZFpyVhDHVFuCGk94LTyQtgYgbU3W01Vm+zSxg6iX9mlzoHD6D
         AgWNPU9Ien6opcLF/h7a3yPVH/8WBvCQ3fev5nLFxJlX+kWbJAacUCSdnotzCYoanJnD
         f4tA==
X-Gm-Message-State: AOJu0YyVuxfF7tpocsOkmbeUBQypB6M4W/2VAyr1wOqDMVg6+huLFUBq
	3OBYpMCvRsBPXtQ3bwBLhqJp7AoTxpVVce/6ujSYudU+GvEDvBBUlsynPXOZOIXMFVriiAqpaRP
	r3yFAOZ9HlQG8O6hwgnQSy5vsF7uXQA==
X-Google-Smtp-Source: AGHT+IGW1RauJL9OZ+cPxDuGoiaxN+mzL4l/+lcantm3iNN/IQ3QxNXv5pz1t0jVRqm/czjAWifLOAlPtPqhTU6f6x8=
X-Received: by 2002:a2e:2205:0:b0:2e9:58d9:6d8 with SMTP id
 38308e7fff4ca-2e958d90769mr11029411fa.7.1716570557865; Fri, 24 May 2024
 10:09:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240523165436.g5xgo7aht7dtmvfb@quack3>
In-Reply-To: <20240523165436.g5xgo7aht7dtmvfb@quack3>
From: Dan Shelton <dan.f.shelton@gmail.com>
Date: Fri, 24 May 2024 19:08:51 +0200
Message-ID: <CAAvCNcB1hsS67Cy6sZP3Mf33VCKfFsg0Vc0pH2XJt0K6Po9ZQQ@mail.gmail.com>
Subject: Re: Bad NFS performance for fsync(2)
To: Jan Kara <jack@suse.cz>
Cc: linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>, 
	Jeff Layton <jlayton@kernel.org>, Trond Myklebust <trond.myklebust@hammerspace.com>, 
	Anna Schumaker <anna@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 23 May 2024 at 18:55, Jan Kara <jack@suse.cz> wrote:
>
> Hello!
>
> I've been debugging NFS performance regression with recent kernels. It
> seems to be at least partially related to the following behavior of NFS
> (which is there for a long time AFAICT). Suppose the following workload:
>
> fio --direct=0 --ioengine=sync --thread --directory=/test --invalidate=1 \
>   --group_reporting=1 --runtime=100 --fallocate=posix --ramp_time=10 \
>   --name=RandomWrites-async --new_group --rw=randwrite --size=32000m \
>   --numjobs=4 --bs=4k --fsync_on_close=1 --end_fsync=1 \
>   --filename_format='FioWorkloads.$jobnum'

Where do you get the fio command from?

Dan
-- 
Dan Shelton - Cluster Specialist Win/Lin/Bsd

