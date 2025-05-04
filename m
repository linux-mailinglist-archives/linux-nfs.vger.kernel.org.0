Return-Path: <linux-nfs+bounces-11431-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 452EBAA845E
	for <lists+linux-nfs@lfdr.de>; Sun,  4 May 2025 08:46:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11536189A9F7
	for <lists+linux-nfs@lfdr.de>; Sun,  4 May 2025 06:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C11615AF6;
	Sun,  4 May 2025 06:46:00 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C49C29A5
	for <linux-nfs@vger.kernel.org>; Sun,  4 May 2025 06:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746341160; cv=none; b=t40ny/wC2nYBp6cARhz1Fx0mWKN+K70vYeMJMYuLxWV9Gz75o+vb2GfwgiXHiGbjuzjMjrp/WP8owAmhkn2bzOs1sWwigyVGcCLxfkCEVUzeH5Whn4HwbArGHLYAfAXD7cM6epjmHnrOOAhCkYFiiiX1aAvizMVw5mJae1xNMks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746341160; c=relaxed/simple;
	bh=/P0vbMOFgSpZpvUy42HS2+Mwf/dCQZxiNWdjkl54pnc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=g+Yb8GKozF/MzuWXJhkSAhlTQWfj6rBNDH29cRix3Q0wEglfdNcOZKlUZveyR5i8P8LtqdR1Gj2NS9QP1A6/xYCN+/w9GAS0TKySQLi3AzyEmBFz8H1PNnnn4NiMHBRFNg3n4gOX37wPzKhPEtfiYWPb2iEh4MZqOt7HsxavF+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43cf0d787eeso30959605e9.3
        for <linux-nfs@vger.kernel.org>; Sat, 03 May 2025 23:45:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746341156; x=1746945956;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :reply-to:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bpom/Yk8JI4We6nEUzvbsJ7ZOrWtFqelJVhrOzsSO18=;
        b=sq4A8Lnly0omYifi+SIaCMw2c5S0ndB1eaReAkP5C8ojwAxvbswzbgl+UmtuHjxuDY
         OKS8vd1iU+/JlhjzvAOKGlXIAspQueyGOgpuleBccGBczvHFRD3/cHZSw5IYf2HaqJ9e
         Dtn6npbVRRE6dqnDJpjfxmoTXj6QAidrfPicdRddjRomPAUKEp6Aw0hnaVlkWmFn5/aq
         wp++JzTx7lZRu7d5HyWtDDvykeWIDCADNY5vkAJLzEfrxRlhYS32zAzNsMvU5bSAXWS7
         cQmMdVqCuI5w7ljDPYlkkc8rraz5HthjOp4sjDzzsXWjyWfDll6x0Esaxal7fJx0XqCU
         VrAQ==
X-Gm-Message-State: AOJu0YyJGGjElSMmP6ofByNdWoeJulmbqvnvx1rQ92P5XImd45kAugZM
	fGgw2yBds374ALUHSH68UTCBQEEkBCVTmoRtBOyej+tqCrgt4zuQTFoBMQ==
X-Gm-Gg: ASbGncvMaxX1mdsQKYEP+fVD9vBA5rJvc4M80OqzDdkf6KpKkYJhc1yGjMfFVyd1IWF
	lmnsCEy1lo+3fHw7dmurB93Q1rJvx1IdyVihGgN6GKt2mczF2k2UMRs+/7I3smuueHb9KqLUGzP
	gK07QuEFBF/M6ueLSMTQZuH+Uy5NSHFgphmTfNaV/S1SwEksjhO56zHrc/Nt1ZMY2vgSgjstxw0
	p3TYaUiZJ9AeHYtzLT8C/4HDxMBuv2X2iJKzngiq+tje5Szbhm5na+KheDUH4Pvy4f9HA/zO94E
	GPut7Hd0kjqop+e6VVq61eW80tDFyEnZJhdUWe5rOu4DXYxXVBsMqt2kIl96ymcbPAklXA1U1dU
	y2mSZyg==
X-Google-Smtp-Source: AGHT+IEAa7WNq8HsuIYBgD7a9hS3DQLsg8VAMC2I+0RLkVAsq7pfXTiRk+y7Br8wJBAzjKI6A8Lmeg==
X-Received: by 2002:a05:600c:5111:b0:43c:fdbe:4398 with SMTP id 5b1f17b1804b1-441c99f3f17mr766135e9.6.1746341156034;
        Sat, 03 May 2025 23:45:56 -0700 (PDT)
Received: from [10.50.5.11] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441b89edfc2sm92451965e9.20.2025.05.03.23.45.55
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 May 2025 23:45:55 -0700 (PDT)
Message-ID: <56e7291c-7d69-4b2b-adc3-68f51385ea11@grimberg.me>
Date: Sun, 4 May 2025 09:45:54 +0300
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] NFSv4.2: fix setattr caching of TIME_[MODIFY|ACCESS]_SET
 when timestamps are delegated
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nfs@vger.kernel.org
Reply-To: sagi@grimberg.me, Trond Myklebust <trondmy@kernel.org>,
 Jeff Layton <jlayton@kernel.org>, Anna Schumaker <anna@kernel.org>
References: <20250425124919.1727838-1-sagi@grimberg.me>
Content-Language: en-US
In-Reply-To: <20250425124919.1727838-1-sagi@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 25/04/2025 15:49, Sagi Grimberg wrote:
> nfs_setattr will flush all pending writes before updating a file time
> attributes. However when the client holds delegated timestamps, it can
> update its timestamps locally as it is the authority for the file
> times attributes. The client will later set the file attributes by
> adding a setattr to the delegreturn compound updating the server time
> attributes.
>
> Fix nfs_setattr to avoid flushing pending writes when the file time
> attributes are delegated and the mtime/atime are set to a fixed
> timestamp (ATTR_[MODIFY|ACCESS]_SET. Also, when sending the setattr
> procedure over the wire, we need to clear the correct attribute bits
> from the bitmask.
>
> I was able to measure a noticable speedup when measuring untar performance.
> Test: $ time tar xzf ~/dir.tgz
> Baseline: 1m13.072s
> Patched: 0m49.038s
>
> Which is more than 30% latency improvement.

Jeff, Trond, Anna,

Any comments on this patch?

>
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
> Tested this on a vm in my laptop against chuck nfsd-testing which
> grants write delegs for write-only opens, plus another small modparam
> that also adds a space_limit to the delegation.
>
>   fs/nfs/inode.c    | 49 +++++++++++++++++++++++++++++++++++++++++++----
>   fs/nfs/nfs4proc.c |  8 ++++----
>   2 files changed, 49 insertions(+), 8 deletions(-)
>
> diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
> index 119e447758b9..6472b95bfd88 100644
> --- a/fs/nfs/inode.c
> +++ b/fs/nfs/inode.c
> @@ -633,6 +633,34 @@ nfs_fattr_fixup_delegated(struct inode *inode, struct nfs_fattr *fattr)
>   	}
>   }
>   
> +static void nfs_set_timestamps_to_ts(struct inode *inode, struct iattr *attr)
> +{
> +	unsigned int cache_flags = 0;
> +
> +	if (attr->ia_valid & ATTR_MTIME_SET) {
> +		struct timespec64 ctime = inode_get_ctime(inode);
> +		struct timespec64 mtime = inode_get_mtime(inode);
> +		struct timespec64 now;
> +		int updated = 0;
> +
> +		now = inode_set_ctime_current(inode);
> +		if (!timespec64_equal(&now, &ctime))
> +			updated |= S_CTIME;
> +
> +		inode_set_mtime_to_ts(inode, attr->ia_mtime);
> +		if (!timespec64_equal(&now, &mtime))
> +			updated |= S_MTIME;
> +
> +		inode_maybe_inc_iversion(inode, updated);
> +		cache_flags |= NFS_INO_INVALID_CTIME | NFS_INO_INVALID_MTIME;
> +	}
> +	if (attr->ia_valid & ATTR_ATIME_SET) {
> +		inode_set_atime_to_ts(inode, attr->ia_atime);
> +		cache_flags |= NFS_INO_INVALID_ATIME;
> +	}
> +	NFS_I(inode)->cache_validity &= ~cache_flags;
> +}
> +
>   static void nfs_update_timestamps(struct inode *inode, unsigned int ia_valid)
>   {
>   	enum file_time_flags time_flags = 0;
> @@ -701,14 +729,27 @@ nfs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
>   
>   	if (nfs_have_delegated_mtime(inode) && attr->ia_valid & ATTR_MTIME) {
>   		spin_lock(&inode->i_lock);
> -		nfs_update_timestamps(inode, attr->ia_valid);
> +		if (attr->ia_valid & ATTR_MTIME_SET) {
> +			nfs_set_timestamps_to_ts(inode, attr);
> +			attr->ia_valid &= ~(ATTR_MTIME|ATTR_MTIME_SET|
> +						ATTR_ATIME|ATTR_ATIME_SET);
> +		} else {
> +			nfs_update_timestamps(inode, attr->ia_valid);
> +			attr->ia_valid &= ~(ATTR_MTIME|ATTR_ATIME);
> +		}
>   		spin_unlock(&inode->i_lock);
> -		attr->ia_valid &= ~(ATTR_MTIME | ATTR_ATIME);
>   	} else if (nfs_have_delegated_atime(inode) &&
>   		   attr->ia_valid & ATTR_ATIME &&
>   		   !(attr->ia_valid & ATTR_MTIME)) {
> -		nfs_update_delegated_atime(inode);
> -		attr->ia_valid &= ~ATTR_ATIME;
> +		if (attr->ia_valid & ATTR_ATIME_SET) {
> +			spin_lock(&inode->i_lock);
> +			nfs_set_timestamps_to_ts(inode, attr);
> +			spin_unlock(&inode->i_lock);
> +			attr->ia_valid &= ~(ATTR_ATIME|ATTR_ATIME_SET);
> +		} else {
> +			nfs_update_delegated_atime(inode);
> +			attr->ia_valid &= ~ATTR_ATIME;
> +		}
>   	}
>   
>   	/* Optimization: if the end result is no change, don't RPC */
> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> index 970f28dbf253..c501a0d5da90 100644
> --- a/fs/nfs/nfs4proc.c
> +++ b/fs/nfs/nfs4proc.c
> @@ -325,14 +325,14 @@ static void nfs4_bitmap_copy_adjust(__u32 *dst, const __u32 *src,
>   
>   	if (nfs_have_delegated_mtime(inode)) {
>   		if (!(cache_validity & NFS_INO_INVALID_ATIME))
> -			dst[1] &= ~FATTR4_WORD1_TIME_ACCESS;
> +			dst[1] &= ~(FATTR4_WORD1_TIME_ACCESS|FATTR4_WORD1_TIME_ACCESS_SET);
>   		if (!(cache_validity & NFS_INO_INVALID_MTIME))
> -			dst[1] &= ~FATTR4_WORD1_TIME_MODIFY;
> +			dst[1] &= ~(FATTR4_WORD1_TIME_MODIFY|FATTR4_WORD1_TIME_MODIFY_SET);
>   		if (!(cache_validity & NFS_INO_INVALID_CTIME))
> -			dst[1] &= ~FATTR4_WORD1_TIME_METADATA;
> +			dst[1] &= ~(FATTR4_WORD1_TIME_METADATA|FATTR4_WORD1_TIME_MODIFY_SET);
>   	} else if (nfs_have_delegated_atime(inode)) {
>   		if (!(cache_validity & NFS_INO_INVALID_ATIME))
> -			dst[1] &= ~FATTR4_WORD1_TIME_ACCESS;
> +			dst[1] &= ~(FATTR4_WORD1_TIME_ACCESS|FATTR4_WORD1_TIME_ACCESS_SET);
>   	}
>   }
>   


