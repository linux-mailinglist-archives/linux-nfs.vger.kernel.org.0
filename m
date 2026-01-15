Return-Path: <linux-nfs+bounces-17895-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CF833D23044
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Jan 2026 09:09:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 497E930142D2
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Jan 2026 08:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1145D27B32C;
	Thu, 15 Jan 2026 08:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="NNN+u/HP"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D663932BF22
	for <linux-nfs@vger.kernel.org>; Thu, 15 Jan 2026 08:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768464558; cv=none; b=PUINy+6B5NEnwfslrq64gZacJOCewlA8pvcqRkW000crupfzYQrRrAOL4j9EYU7dEiJp2xKaD43vxMPOQ5IBWh/hoXEKz+dYuSMRCROEfErndQH2qPawDICT9Itq45NR+/9iGrb6Kwv3A/G8zDMnsPU4jhN+NrcUuBss82AIIH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768464558; c=relaxed/simple;
	bh=eqPHc11X326FTHhop0PlDqHJTlQDt7TQuLgRQ5Eri7o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FWVv1OnKhGPKqaeWBmORMBBAr/sHKzFG4FiJg3I3TFuNKltE99f1ZowZUX9uG8xCURtMGaNL/tkJn5hCHY3rZPCtpho+FcaJNXW8VfHsOXXWVd8f89p6A1IGADmYPcHI1vbShWTFYTuEXL+B9VBWnuERmbVWLMFl+gHHfwQMQ0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=NNN+u/HP; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-47d63594f7eso3728515e9.0
        for <linux-nfs@vger.kernel.org>; Thu, 15 Jan 2026 00:09:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768464555; x=1769069355; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KJcexZNg29HoCYlcVm4y0hxJoHkzoqD1Cd1/6EPA9nI=;
        b=NNN+u/HPO/RFmgSSv5r8K+7DrCLv8xLlB/VWaLfU3ow34kBCCTwp78HyR/F/og9FaV
         5QLOmBg8SYdxF6Bs8XDNqGro+XyvHY6XWw5VRredDv+PUwaiz1mltZU/Gq1PW3LZSiOw
         FIpdtXvn9VhW4NHz/NUWfvl1m2OuPD9+5rYcovJf8P5Hckf2noqJ857lETbzjHyYelSQ
         GXqB706Rb9Q2bMVo6eqS2zJK03zzzkDULdBvclRehHDO8O20hgartEvSwEPKq3KfF8p+
         hwBAdrKqkv+CTR5bM2s/FGLA0vDnwyn3I1N5x0qsOLMIF07ODcufsJOR8LrbjNfZJ7iB
         7Jrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768464555; x=1769069355;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KJcexZNg29HoCYlcVm4y0hxJoHkzoqD1Cd1/6EPA9nI=;
        b=nH2jJoUPgMXAOu2NORgvI82rDjERpQbRpKlyG+rsqA4fkudKSjBGQGb1ORPDn+yIzy
         PJoekaRj9ocjGbu40NP1yiUHDHNQqktKnf2NWWaPCUvIbtPQirk3UM/C6c+5Bbq54hWa
         AooEmse8ZEEH7HSOohajfFU7Fln9OBiFRhUanPg1d7pZ4gd5hVbHBZjDRq6a5WhqCIf/
         Tqv56rSTOnyhLVyQoyahUB5W0fO5v15sK3fiV4IxQfcMcUI1xRTEg1o96G9l30SfxrkK
         SghH74mQQfKOf2iAszffpdlArlU4ftcmojA0sKGojroYTG4G6J1lBHO7ZhVHB4h3E1nw
         icLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfu/nfpQL3ymu31sHIs1TyPGKttlOO1aYohjlN0mgutD68i00+1PM/U9DDSInj1aeT1A2uhcneiY0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVU+ZqLkVjbk/bwuOkia2hgmwHJSCjOMF7cqVagHRQ1AqOHgSR
	ECjqmeKzF0iRKl4YVQA+R6ddHpIhWT5UoUJcvCxqnoHW0cSRR9YamnVx+ekF9tMWufs=
X-Gm-Gg: AY/fxX57+AGv5qWEHV2FLsuVYYWF6xeifSsK3ztYYtBQj3DjNmW///R/zVWWPvrcgpb
	3TjwM0haWNqCP0pjuZ1gjH6xx0K5eaaP9ddEoCp6epSy73rehYFbmEHPOunACsBej4MKf1nOcU2
	cLLEUNQrfyOvIvbqapd18qX0fbBuZwkWaeTeOOWt5pTALP2u0dBgimbn/yq0GAAlTIBIxQ4ImxP
	TdLpmeAPs0DCT/faiGe2G1w/lVJiK07m9SGyBotbDUsUflRyuEBKzDS6tMqvMnMt0B6KzsEwpKm
	WWSUid5wF/Ixewkn87Z4NlJ6ZoAYtQlVmUM6K5eQCDRj3XPt5haL4ga2CUPVH3o/nTkpKVs391A
	8V7RqLcrO9+X9MbB9ub6jAtDpc84mWL5wK+5MIRhh060voqhCcGCosl1/15jeHObF80kgWFJ5AK
	xpu/aTcXQLUAdoOksQRR5fkU2Z7RHuROqLfVaOyu8=
X-Received: by 2002:a05:600c:4446:b0:477:76cb:4812 with SMTP id 5b1f17b1804b1-47ee47227cemr53240515e9.0.1768464554972;
        Thu, 15 Jan 2026 00:09:14 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35107c479basm1598283a91.11.2026.01.15.00.09.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jan 2026 00:09:14 -0800 (PST)
Message-ID: <461fc582-71ba-4238-9696-3d8bdd8a0207@suse.com>
Date: Thu, 15 Jan 2026 18:39:05 +1030
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] ovl: Use real disk UUID for origin file handles
To: Christoph Hellwig <hch@lst.de>
Cc: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
 Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
 NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>,
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
 Carlos Maiolino <cem@kernel.org>, Amir Goldstein <amir73il@gmail.com>,
 Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
 Miklos Szeredi <miklos@szeredi.hu>, Christian Brauner <brauner@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
 linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-btrfs@vger.kernel.org, linux-unionfs@vger.kernel.org,
 kernel-dev@igalia.com
References: <20260114-tonyk-get_disk_uuid-v1-0-e6a319e25d57@igalia.com>
 <20260114-tonyk-get_disk_uuid-v1-3-e6a319e25d57@igalia.com>
 <20260114062608.GB10805@lst.de>
 <5334ebc6-ceee-4262-b477-6b161c5ca704@igalia.com>
 <20260115062944.GA9590@lst.de>
 <633bb5f3-4582-416c-b8b9-fd1f3b3452ab@suse.com>
 <20260115072311.GA10352@lst.de>
Content-Language: en-US
From: Qu Wenruo <wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXVgBQkQ/lqxAAoJEMI9kfOh
 Jf6o+jIH/2KhFmyOw4XWAYbnnijuYqb/obGae8HhcJO2KIGcxbsinK+KQFTSZnkFxnbsQ+VY
 fvtWBHGt8WfHcNmfjdejmy9si2jyy8smQV2jiB60a8iqQXGmsrkuR+AM2V360oEbMF3gVvim
 2VSX2IiW9KERuhifjseNV1HLk0SHw5NnXiWh1THTqtvFFY+CwnLN2GqiMaSLF6gATW05/sEd
 V17MdI1z4+WSk7D57FlLjp50F3ow2WJtXwG8yG8d6S40dytZpH9iFuk12Sbg7lrtQxPPOIEU
 rpmZLfCNJJoZj603613w/M8EiZw6MohzikTWcFc55RLYJPBWQ+9puZtx1DopW2jOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXWBBQkQ/lrSAAoJEMI9kfOhJf6o
 cakH+QHwDszsoYvmrNq36MFGgvAHRjdlrHRBa4A1V1kzd4kOUokongcrOOgHY9yfglcvZqlJ
 qfa4l+1oxs1BvCi29psteQTtw+memmcGruKi+YHD7793zNCMtAtYidDmQ2pWaLfqSaryjlzR
 /3tBWMyvIeWZKURnZbBzWRREB7iWxEbZ014B3gICqZPDRwwitHpH8Om3eZr7ygZck6bBa4MU
 o1XgbZcspyCGqu1xF/bMAY2iCDcq6ULKQceuKkbeQ8qxvt9hVxJC2W3lHq8dlK1pkHPDg9wO
 JoAXek8MF37R8gpLoGWl41FIUb3hFiu3zhDDvslYM4BmzI18QgQTQnotJH8=
In-Reply-To: <20260115072311.GA10352@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2026/1/15 17:53, Christoph Hellwig 写道:
> On Thu, Jan 15, 2026 at 05:21:04PM +1030, Qu Wenruo wrote:
>> So that means let btrfs to convert the temp fsid into metadata uuid, which
>> I think is fine.
> 
> At least in XFS terms, that metadata uuid is the persistent, never
> changing uuid in the metadata headrs.
> 
>> But the problem is that will change the fsid of the new fs, which may or
>> may not be what's expected for the current temp fsid user (they really want
>> two btrfs with the same fsid).
> 
> Which is really dangerous and should not be used in normal operation.
> For XFS with support it with a nouuid option, mostly for historic
> reasons and to be able to change the uuid transactional using an
> ioctl.
> 
>> My initial idea for this problem is to let btrfs not generate a tempfsid
>> automatically, but put some special flag (e.g. SINGLE_DEV compat ro flag)
>> on those fses that want duplicated fsid.
>>
>> Then for those SINGLE_DEV fses, disable any multi-device related features,
>> and use their dev_t to distinguish different fses just like EXT4/XFS,
>> without bothering the current tempfsid hack, and just return the same fsid.
> 
> dev_t is not related to the uuid in any way for XFS, and while I'm not
> an expert there I'm pretty sure ext4 uses the same not dev related uuid
> generation.

My bad, by dev_t I mean bdev holder, which is a pointer to the super 
block of the mounted fs. (And btrfs just recently join this common usage)

> 
>> I'm wondering will that behavior (returning the same fsid) be acceptable
>> for overlayfs?
> 
> I still wonder what the use case is here.  Looking at André's original
> mail it states:
> 
> "However, btrfs mounts may have volatiles UUIDs. When mounting the exact same
> disk image with btrfs, a random UUID is assigned for the following disks each
> time they are mounted, stored at temp_fsid and used across the kernel as the
> disk UUID. `btrfs filesystem show` presents that. Calling statfs() however
> shows the original (and duplicated) UUID for all disks."
> 
> and this doesn't even talk about multiple mounts, but looking at
> device_list_add it seems to only set the temp_fsid flag when set
> same_fsid_diff_dev is set by find_fsid_by_device, which isn't documented
> well, but does indeed seem to be done transparently when two file systems
> with the same fsid are mounted.
> 
> So André, can you confirm this what you're worried about?  And btrfs
> developers, I think the main problem is indeed that btrfs simply allows
> mounting the same fsid twice.  Which is really fatal for anything using
> the fsid/uuid, such NFS exports, mount by fs uuid or any sb->s_uuid user.

Yeah, although it's possible to mount different devices with same fsid 
separately, I don't think it's really that a good idea either.

Thus I really prefer to have special flags for those "uncommon" use 
cases, other than the current automatically enabled tempfsid feature.

It's like introducing a lot of complexity for a corner case, and that's 
also affecting our common routines.


On the other hand, ext4 allows to mount two cloned fses, mostly thanks 
to the above bdev holder mechanism.


For regular stat() calls, we can still distinguish the two different 
fses with the same fsid, they have two different st_dev members.
But not sure how overlayfs would be able to distinguish such two fses.

> 
>> If so, I think it's time to revert the behavior before it's too late.
>> Currently the main usage of such duplicated fsids is for Steam deck to
>> maintain A/B partitions, I think they can accept a new compat_ro flag for
>> that.
> 
> What's an A/B partition?  And how are these safely used at the same time?
> 

For the original thread about A/B partition usage:

https://lore.kernel.org/linux-btrfs/20230504170708.787361-1-gpiccoli@igalia.com/

And

https://lore.kernel.org/linux-btrfs/c702fe27-8da9-505b-6e27-713edacf723a@igalia.com/

Thanks,
Qu

