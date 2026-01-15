Return-Path: <linux-nfs+bounces-17893-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BB2A8D22A90
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Jan 2026 07:53:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 29C5B307A82C
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Jan 2026 06:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 597033090E6;
	Thu, 15 Jan 2026 06:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WiSx3m/m"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6321F309EF9
	for <linux-nfs@vger.kernel.org>; Thu, 15 Jan 2026 06:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768459880; cv=none; b=jslPkOsPr6PY/P86Q9FIUMYj9Cq5S1emM7lNk/vo0i0pF2W3+R1zqjbYSQolntenlOvLIxfq+NGkdz+N5F5B5peI8Zp7w3FU8OZStQDPy0M1vU8MhIlk45XSzyFX14fg6GFCQUw6nnM3PuaSG6REvmZyjIsA+UrejjkaIjcE1XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768459880; c=relaxed/simple;
	bh=Ee1Csys1ksCd9NqlqLh/StQZJWBO6brt7Q3qWHJsC3w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C2Wbq1nCmE34Ptnft16x+Vk9Ubn3J4dOuYEssIZuka2ebpe1iTZSYU3Linh0LZ0Jp0N5hSpK/a3/+4s5+lFEn/XPVxm5T/Y1JApOAcsz/WTXBSI1glFCF2iCU0u3nQ0QUiRX94ckuKy9S/SgPsno03531afoI7q3sFLR/tqzdtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WiSx3m/m; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-47edd6111b4so5053955e9.1
        for <linux-nfs@vger.kernel.org>; Wed, 14 Jan 2026 22:51:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768459874; x=1769064674; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=T3FkarUmHOcpzKA+PRupkc1htRfHgGL+4ZRaiIQtBPU=;
        b=WiSx3m/mD9ZePTapn2ZmNDt9+1wftmUx1fC2sE7w8szdtuS7tdMqnshavec/6Bhrk0
         iW8n8706us5xJQQnt9jvhu5q+IKQnkqCJhKt2tdPh3qntMexPQIg6ZMKsbjbE8W+X/Z+
         TkOjVIMiCzvGeE38d2Mxm1IyEhNLdPla0MB1tvkGTpaSjaMcwoJ3yck9vXdvo6B6pqDN
         dJomkIma4tFpx4Cq6oez4JVaeqSWMNk3aVC3Jibcx28JtyiIW7sorigdhhNGN1zMTS9Y
         FUAIRWFxwyIeZMCr9Yv/Kg6jY17s5WKFurgf054rpyQuVZFLcKePKX7a+c/gZQC3siId
         934w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768459874; x=1769064674;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T3FkarUmHOcpzKA+PRupkc1htRfHgGL+4ZRaiIQtBPU=;
        b=eo+/I6MNE67Xb8stHokwq/qjq4BbiHedpRmZ+gr4OMaJeViKkeu+3v5cmefT7MAtRf
         dB5kBdBmReTMRmkmx+ap/VZyrFrTZPMSI1TkIJPOUUzNqQIxqbJa2G0XMG+4y8FrnktB
         XNoRfdZyHumEMLIUBaX5PxpN7JiGq4knXj8F17UboLAHdrkebfO4vuccpBUjs+Pw7REj
         nsuZnVcY2GtOG11ZVjD+wWLYKGDKWAsqoXaZqClBIfA6GwS5CYKzhDzfnsJ1j4fPVaCS
         ubAUrKQl6OTmrrdC4T+sqCFAL52p/CAgfEJ/3s5IaAIABJCOtC2ORHsIwVMrAjZ2YdCf
         GJbQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmqjjQatdj+9j3IZBdVNaW79zrXSxCOKVgwS7EatFYX6l7t1MWgxcH7cF2z043Dnwy43EUPz8+PS8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5rAgS8CI2tjHOx3gltRenHHfUKiwIG6xXlC0KItcdGvfpyWXH
	YvQCOuGgOu8Txb6ufhDeVDRV7xXx5wn3zm4NCruTcRE2zS/v+7VL0HSQkZDCUl81EkE=
X-Gm-Gg: AY/fxX6KAQ6JH9LmXQDmHixWivSTHy5257bvgTz18H5UXKKaGebVd1ok4VyXngrlQCq
	BsMIochNYf1JYAp+oUn42EZ3js5sT+DGOAHdYRIA7AlloX7tv/+j0mhZhHapkhdKfqf0GqY1yYD
	ABJSbIPtULdEx2yN3EcJiWjicj24eOPWwDfnA4k8iIGWz9TzFLt/i/P9qNOHia+co6KNKhJU1YA
	zalWGy/USHBbYu2v9JsWG+TeJvgCxGDggnk1SOjhVjT9EgZeAbE4XyZxfA4ujJ9+Q1BhyBjbqcQ
	75zca/boK4mYLckbBWNv7J2kz6B1KShjxK9lc2lYWMIYhu/2HKm1KKpEyK8LdFDfS8dHMcdbvw8
	ZHoj1webX6WCZaCF8HMQxo5Z9J9zxU75R9A+lwrMljo6rZyB2WoTKs5mTzOZJkdk5bEzlFezMts
	8T46FiWaO+ow7iewFMCSDxzwflTja8XeUY1y0/Dq8=
X-Received: by 2002:a05:600c:8715:b0:477:b0b9:3129 with SMTP id 5b1f17b1804b1-47ee47bbaaamr46123415e9.3.1768459873888;
        Wed, 14 Jan 2026 22:51:13 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81f8e653a83sm1457718b3a.36.2026.01.14.22.51.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jan 2026 22:51:13 -0800 (PST)
Message-ID: <633bb5f3-4582-416c-b8b9-fd1f3b3452ab@suse.com>
Date: Thu, 15 Jan 2026 17:21:04 +1030
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] ovl: Use real disk UUID for origin file handles
To: Christoph Hellwig <hch@lst.de>, =?UTF-8?Q?Andr=C3=A9_Almeida?=
 <andrealmeid@igalia.com>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
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
In-Reply-To: <20260115062944.GA9590@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2026/1/15 16:59, Christoph Hellwig 写道:
> On Wed, Jan 14, 2026 at 01:17:15PM -0300, André Almeida wrote:
>> Em 14/01/2026 03:26, Christoph Hellwig escreveu:
>>> On Wed, Jan 14, 2026 at 01:31:43AM -0300, André Almeida wrote:
>>>> Some filesystem, like btrfs, supports mounting cloned images, but assign
>>>> random UUIDs for them to avoid conflicts. This breaks overlayfs "index"
>>>> check, given that every time the same image is mounted, it get's
>>>> assigned a new UUID.
>>>
>>> ... and the fix is to not assign random uuid, but to assign a new uuid
>>> to the cloned image that is persisted.  That might need a new field
>>> to distintguish the stamped into the format uuid from the visible
>>> uuid like the xfs metauuid, but not hacks like this.
>>>
>>
>> How can I create this non random and persisting UUID? I was thinking of
>> doing some operation on top the original UUID, like a circular shift, some
>> sort of rearrangement of the original value that we can always reproduce.
>> Is this in the right direction do you think?
> 
> Just allocate an entirely new uuid?  That's what XFS did with the
> metadata uuid (persistent and stapted into all metadata headers) vs
> user visible uuid that can be changed.

So that means let btrfs to convert the temp fsid into metadata uuid, 
which I think is fine.

But the problem is that will change the fsid of the new fs, which may or 
may not be what's expected for the current temp fsid user (they really 
want two btrfs with the same fsid).


My initial idea for this problem is to let btrfs not generate a tempfsid 
automatically, but put some special flag (e.g. SINGLE_DEV compat ro 
flag) on those fses that want duplicated fsid.

Then for those SINGLE_DEV fses, disable any multi-device related 
features, and use their dev_t to distinguish different fses just like 
EXT4/XFS, without bothering the current tempfsid hack, and just return 
the same fsid.

Unfortunately that idea is not accepted and the current automatic new 
tempfsid solution is merged.

I'm wondering will that behavior (returning the same fsid) be acceptable 
for overlayfs?

If so, I think it's time to revert the behavior before it's too late.
Currently the main usage of such duplicated fsids is for Steam deck to 
maintain A/B partitions, I think they can accept a new compat_ro flag 
for that.

Thanks,
Qu

