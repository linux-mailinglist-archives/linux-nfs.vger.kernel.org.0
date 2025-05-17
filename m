Return-Path: <linux-nfs+bounces-11787-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73BEEABA939
	for <lists+linux-nfs@lfdr.de>; Sat, 17 May 2025 11:49:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 011C9177D29
	for <lists+linux-nfs@lfdr.de>; Sat, 17 May 2025 09:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 904E920330;
	Sat, 17 May 2025 09:49:17 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B928176026
	for <linux-nfs@vger.kernel.org>; Sat, 17 May 2025 09:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747475357; cv=none; b=uRJODAD72/cFQd4mt0gyv4ZQETJ5CwZJSrfWXb/ijTFCwwOe3GSX9Aca6z7bnQtUMWuc00kVBhMz5YdagLEVfq6sm31/yWOC+ac1kOQ1RgK3NkzyxAsmVMpwUHXCAkU+iHU7dLuGll6wz9c7HYZj2pf13Yfbtn5u4WzmhDkXCTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747475357; c=relaxed/simple;
	bh=pR4Slo6cNrfWWeqvSrqJSDLyuRtRZaleQmiLjUtY/+Y=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=VljJ6LAPNbpR2MuLr2FF7EyK6O1W0iCT6YSS3Kuf7ZU1e7WfRAhct3CwEq+/HourQjPDUgylb6JNU13/EfAfwEcC88BkelD2I/Edzqs7qxkiHEdB3nWLu0DR0JqajxQpm1ApJ3ThOiqC4B22Ho481faH5PVUhSkZNhCWE1/zRTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3a3681aedf8so268311f8f.1
        for <linux-nfs@vger.kernel.org>; Sat, 17 May 2025 02:49:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747475354; x=1748080154;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :reply-to:cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=36Xd4XOZcOHfnKjklDanQeCKJX/jyEc+VxUUlIzlJiU=;
        b=K3izKp/qtJpR+XZMpLDHN37nE1YXTL+bH8WuoAWvqxM4mzIWFLSOF1aDuF1a5Aix7O
         LnFXIpvgIpdmJdrY9aMqN+cFxxlEOmk/WrHWEkgtcwf+yhOww4bnTd2cIAwi/EjwPKmb
         Ipd9f0IP8Dd+ezHQHdeLrewSxTktCHN2L0wzFKAyDK24GTn31Rr7CG5YBif5+7FJwGc9
         dfTi31O5J1Zui+kuDMo4QiCPROCua9pARqTGfhnK5wUbd3DCuyiItDwmJqXQ+MUGEgHR
         zHZma0beIMNV5rlUiOx5Hlpno6Ikj9gJrqbheYlpuhxYX06vmHu41+WHajbL9Wq9b4Nj
         jLsg==
X-Gm-Message-State: AOJu0YxItSDXRvhp/SKlZZw6JmotHLklIjnvJ+k8yrmOdRJL3sxfBvpf
	fSrIN3oQ3R3QLZzOHEtcGsDzyi00RzA6bO7m0rKQ4skJO7Xk5kBHqyQ6DvmZtA==
X-Gm-Gg: ASbGnctf5SxrtkCggWwrhs+JR4zHZHMl3kx0zqXliljcxCofqQB1+kC7MloTsUoRGP/
	UPl052RHV50rNuBWOElElGCfLM1FA2RfQVyJm3YTJulkWgNZDlrvRLModeCoFPoRqx3bGoRX2ES
	oPG6Kf/s4ibc7CpIAD7jcdgJ+Jfv7rXlvXFMnaWBHijWEG2Ee1gvr+sp509l2O3ZzfwMwj2WqRf
	83EJcQEQiBY2VPkrtuYJ25uJSoas5iE5bNN+InjBaoQFamtHQeZW0HEX9yKM38QXPv5g+A6ag8c
	WIZDDNPAz1ieROo95tZCnfx5/sFo4u6haV7Q9u2u+q0OWoWj2EyWKf2rujntUWsa1s0dPj9g4Vx
	lD2hZjeiqe/Iq2nyCs4A=
X-Google-Smtp-Source: AGHT+IH6yceEfrV2VpLWN2+R3QpoHb1PF8CCe2E+hgLD5B5OQlYiznuF4EgvC51DHw8btgM2xmqvcA==
X-Received: by 2002:a5d:64e9:0:b0:3a3:685b:118 with SMTP id ffacd0b85a97d-3a3685b0292mr838629f8f.24.1747475353501;
        Sat, 17 May 2025 02:49:13 -0700 (PDT)
Received: from [10.100.102.74] (89-138-68-29.bb.netvision.net.il. [89.138.68.29])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442fd583efasm62213895e9.29.2025.05.17.02.49.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 May 2025 02:49:13 -0700 (PDT)
Message-ID: <830cac81-6608-4c8a-be38-fa3e6630fed0@grimberg.me>
Date: Sat, 17 May 2025 12:49:12 +0300
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] NFSv4.2: fix setattr caching of
 TIME_[MODIFY|ACCESS]_SET when timestamps are delegated
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nfs@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>
Reply-To: sagi@grimberg.me
References: <20250511215436.457429-1-sagi@grimberg.me>
Content-Language: en-US
In-Reply-To: <20250511215436.457429-1-sagi@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hey,

Chuck, this does not introduce any new xfstests failures.

Jeff, forgot to add your "Reviewed-by" tag, care to add another one?

Trond, from your last comment my understanding is that you are
supportive of this, are you planning to take this patch?

On 12/05/2025 0:54, Sagi Grimberg wrote:
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
> Baseline: 0m44.407s
> Patched: 0m29.712s
>
> Which is more than 30% latency improvement.
>
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
> Changes from v1:
> - Moved attr->ia_valid assignments as well as inode->lock handling to
>    nfs_set_timestamps_to_ts helper
>
>   fs/nfs/inode.c    | 54 +++++++++++++++++++++++++++++++++++++++++------
>   fs/nfs/nfs4proc.c |  8 +++----
>   2 files changed, 52 insertions(+), 10 deletions(-)
>
> diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
> index 119e447758b9..295e2776053c 100644
> --- a/fs/nfs/inode.c
> +++ b/fs/nfs/inode.c
> @@ -633,6 +633,40 @@ nfs_fattr_fixup_delegated(struct inode *inode, struct nfs_fattr *fattr)
>   	}
>   }
>   
> +static void nfs_set_timestamps_to_ts(struct inode *inode, struct iattr *attr)
> +{
> +	unsigned int cache_flags = 0;
> +
> +	spin_lock(&inode->i_lock);
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
> +		attr->ia_valid &= ~(ATTR_MTIME|ATTR_MTIME_SET|
> +					ATTR_ATIME|ATTR_ATIME_SET);
> +
> +	}
> +	if (attr->ia_valid & ATTR_ATIME_SET) {
> +		inode_set_atime_to_ts(inode, attr->ia_atime);
> +		cache_flags |= NFS_INO_INVALID_ATIME;
> +		attr->ia_valid &= ~(ATTR_ATIME|ATTR_ATIME_SET);
> +	}
> +	NFS_I(inode)->cache_validity &= ~cache_flags;
> +	spin_unlock(&inode->i_lock);
> +}
> +
>   static void nfs_update_timestamps(struct inode *inode, unsigned int ia_valid)
>   {
>   	enum file_time_flags time_flags = 0;
> @@ -700,15 +734,23 @@ nfs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
>   	}
>   
>   	if (nfs_have_delegated_mtime(inode) && attr->ia_valid & ATTR_MTIME) {
> -		spin_lock(&inode->i_lock);
> -		nfs_update_timestamps(inode, attr->ia_valid);
> -		spin_unlock(&inode->i_lock);
> -		attr->ia_valid &= ~(ATTR_MTIME | ATTR_ATIME);
> +		if (attr->ia_valid & ATTR_MTIME_SET) {
> +			nfs_set_timestamps_to_ts(inode, attr);
> +		} else {
> +			spin_lock(&inode->i_lock);
> +			nfs_update_timestamps(inode, attr->ia_valid);
> +			spin_unlock(&inode->i_lock);
> +			attr->ia_valid &= ~(ATTR_MTIME|ATTR_ATIME);
> +		}
>   	} else if (nfs_have_delegated_atime(inode) &&
>   		   attr->ia_valid & ATTR_ATIME &&
>   		   !(attr->ia_valid & ATTR_MTIME)) {
> -		nfs_update_delegated_atime(inode);
> -		attr->ia_valid &= ~ATTR_ATIME;
> +		if (attr->ia_valid & ATTR_ATIME_SET) {
> +			nfs_set_timestamps_to_ts(inode, attr);
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


