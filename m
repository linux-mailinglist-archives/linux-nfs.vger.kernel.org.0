Return-Path: <linux-nfs+bounces-8884-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14FC4A00111
	for <lists+linux-nfs@lfdr.de>; Thu,  2 Jan 2025 23:07:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41FF41883E0E
	for <lists+linux-nfs@lfdr.de>; Thu,  2 Jan 2025 22:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D0B1487E1;
	Thu,  2 Jan 2025 22:07:39 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19F11AD3F6
	for <linux-nfs@vger.kernel.org>; Thu,  2 Jan 2025 22:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735855659; cv=none; b=FUTbAC02PXbyGWXU8t7HnJx1U0HcTwcSanvO0aEh2eAYx/zwSw9GqrkYQ1d/WkY65n8hTvTMh9OxaNgwTOaKVQ0hgPANnlvzfpAx6X8ZuiOg0HVeuu+uHFsik/idwpzRz9R+/85qAKkYNgkYCIqnEfoniR26S0kIKMFVW9Zl0cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735855659; c=relaxed/simple;
	bh=wremUwwmZrgL8ALF121knvSAKKnvmS2hAfptP1wB5tw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=p8oQA4mwbV+/FHLQOe8Gzh4+jpv+nanDKfP2ZpCPS5P00WSyE0NCtVb69oj5uyWsKqQsG1boHG9ri2lzeYk7Viw70W+5TH7xxiX8pEbs9nmWb3YwBxTyrlet8ag1/mLzoqFm3NJaYjjOigS9/BAFLiGkcUoVdl3lz+iXYrkyEbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5d3f65844deso19395825a12.0
        for <linux-nfs@vger.kernel.org>; Thu, 02 Jan 2025 14:07:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735855656; x=1736460456;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wremUwwmZrgL8ALF121knvSAKKnvmS2hAfptP1wB5tw=;
        b=c/WvcBDsca4U8Kug2Zs+UTEgs6YCYcDOyjV3E+y5NeQkQl5cqbO+0o5qK9/tGcUWxt
         3g1MGLTw2DYB0aTNgILFKD1faucDojSFLMvL0OkpTWks5ZLdYXSigemxWmsBVzdd0A7X
         u3HEvpsSV9nGQpNOr1BSMNoCjCaonWyvjJLAKQMi44T/p4LOsqHOkQYdTwhXoXZ3VyTI
         Jnrm0mS+EZnKNA3eyNdb7oQJmI7Fw+s/5dNRxJGgGeQRwuadUPR70qQGvTxlDemNbvPS
         hsZYZxpp8d4mRinrGNraywhqusGF2HjXkQkWNGnrioWYkvLuklRsM5TWSaN052PB1sJX
         V7kg==
X-Forwarded-Encrypted: i=1; AJvYcCVsdNLua9u75f/219AbOu7kvniE2iiTSajj9RV4DxxkOe6T3oE2oNZQejnDYNBFSDbI37f6/jKvNJY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCaOEg+0IbK5C1foGz2UmY8si5BA0khEHUeH60n1KvzOakEqg1
	0dqoPH61HHc3psMBZ2w3aaOV5XpOhzNIgg7u0s8M6OcsXWXUHCfoakNFxA==
X-Gm-Gg: ASbGnctRZv+C7DcsEQ6sds9B4MiyN0OqrIdtC5mD0b/eBtmcsSzjjcDDhLlGi2ZoXOo
	bz03R6JRsfVWoEXj5pWyXIRg3/FEDHLDJ/rWkG2OPu6aiwWpFXrUj1n5JIe68Cntz3K6K35Ogjd
	cbq9bvyC7BkzPlPlZ1s4HfxbpvTc4aMBtOaavcuRjHSwV1LMnQI96I2TWygjcllpOp3SEqN89cI
	1+7yzbl/Zbaq84VZU8MpRsL4eeJyAykYHBnLJ/CpjpGR7V130GTr/v8j04T9b+f+iDG5AqlP8R3
	VZ+Zh/KMfX82OAC9aIrl23A=
X-Google-Smtp-Source: AGHT+IHQZiGpEZ7NvyZaI5CDiXMXOTWS+SE4FNVgJnHR2U6E4vT3kDfHIx6QkTAnAvBJ/tFbuoE47g==
X-Received: by 2002:a05:6402:3224:b0:5d4:34a5:e2f4 with SMTP id 4fb4d7f45d1cf-5d81de38bdfmr43347416a12.31.1735855655616;
        Thu, 02 Jan 2025 14:07:35 -0800 (PST)
Received: from [10.100.102.74] (CBL217-132-142-53.bb.netvision.net.il. [217.132.142.53])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d80701abdcsm18677801a12.74.2025.01.02.14.07.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jan 2025 14:07:35 -0800 (PST)
Message-ID: <3ee21c03-83a5-4ad8-a54f-5c076125e924@grimberg.me>
Date: Fri, 3 Jan 2025 00:07:31 +0200
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Write delegation stateid permission checks
To: Jeff Layton <jlayton@kernel.org>, Shaul Tamari
 <shaul.tamari@vastdata.com>, linux-nfs@vger.kernel.org
References: <CAFEWm5DTvUucAps=SamE5OVs0uYX5n4trFf5PBasBOFbEFWAfA@mail.gmail.com>
 <e52500f98a7153822a6165d26dcf66c3d352129b.camel@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <e52500f98a7153822a6165d26dcf66c3d352129b.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit




On 02/01/2025 15:41, Jeff Layton wrote:
> On Thu, 2025-01-02 at 11:08 +0200, Shaul Tamari wrote:
>> Hi,
>>
>> I have a question regarding NFS4.1 write delegation stateid permission checks.
>>
>> Is there a difference in how a server should check permissions for a
>> write delegation stateid that was given when the file was opened with:
>> 1. OPEN4_SHARE_ACCESS_BOTH
>> 2. OPEN4_SHARE_ACCESS_WRITE
>>
> (cc'ing Sagi since he was looking at this recently)

And completely dropped the ball on this :\

>
> A write delegation really should have been called a read-write
> delegation, because the server has to allow the client to do reads as
> well, if you hold one.

Assuming the access check passes.

>
> The Linux kernel nfs server doesn't currently give out delegations to
> OPEN4_SHARE_ACCESS_WRITE-only opens for this reason. You have to
> request BOTH in order to get one, because a permission check for write
> is not sufficient to allow you to read as well.
>
>
>> Should the server check permissions for read access as well when
>> OPEN4_SHARE_ACCESS_WRITE is requested and DELEGATION_WRITE is granted
>> ?
>>
> Possibly? When trying to grant a write delegation, the server should
> probably also do an opportunistic permission check for read as well,
> and only grant the delegation if that passes. If it fails, you could
> still allow the open and just not grant the delegation.

Yes, that is what Chuck suggested at the time.

>
> ISTR that Sagi may have tried this approach though and there was a
> problem with it?

Not a problem per se, IIRC the thread left off that we need to sort out
access reference accounting for nfsd_file for both reads and writes for
a single write deleg...

