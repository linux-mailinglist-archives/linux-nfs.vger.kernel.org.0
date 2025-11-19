Return-Path: <linux-nfs+bounces-16570-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id ABA49C70A3E
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Nov 2025 19:28:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 90C254E2869
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Nov 2025 18:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9A7630F552;
	Wed, 19 Nov 2025 18:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JorJjGbV";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="VWb4oB5/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4AED30BB94
	for <linux-nfs@vger.kernel.org>; Wed, 19 Nov 2025 18:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763576564; cv=none; b=BsK0ZBJIMBD5g3bX6NxygIePYgTGeMVIl7oGT0SBODXEbf5qYX5xTvJMQGQ0sv01wm98OlSEJKBR748Pn7NCakuygHlZGqvSvnR6tHqo4jaQocGJ8WXj/b5j3+oz8wCWyUAUNqR5XHHRpjPnj9UmeCB3UDhoz65eecpTmvwvDhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763576564; c=relaxed/simple;
	bh=B+5xjwDoONNfqsE7KEgR1rLzdqgEj6WKDO6iGU/BhWo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s98SFb/eSFi4KOTBNZ+sikN7Zmq0DVBThplWI5FQtY9mNOGNhff7XDghD6uA10yCGvVf1aDA7WkriHz+plBWPNVvJQgh0ue5zNp3KsofNbviIeThM3k9Y0y9ciZGKnTwmuKqoRk92Pd1rctNzORMGldPNKo6CL0FgJ1QTqRVo48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JorJjGbV; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=VWb4oB5/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763576555;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FO4KjGAbGPuvhBe9yeD5XsNnfu5YNrr6lV0HpFXJ+/A=;
	b=JorJjGbVskBBsr6xfm1tluPfQSSO/t5RMljZFC0vvsj07/zIOaKb0B6vBlFrExm9Wkvo4V
	qFOak/FbEuNQVcbCz/FhuYV8Z8MIKk6t/H/xyfqELhurxLjXxvxmFs7X84UKXjIz1bsRP1
	qsLL9RbZTgSI+7Tlh669PIhW1HEyKW8=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-Tj6xgTK4OCGWRLatavkKxA-1; Wed, 19 Nov 2025 13:22:33 -0500
X-MC-Unique: Tj6xgTK4OCGWRLatavkKxA-1
X-Mimecast-MFC-AGG-ID: Tj6xgTK4OCGWRLatavkKxA_1763576553
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4ed7591799eso1248551cf.0
        for <linux-nfs@vger.kernel.org>; Wed, 19 Nov 2025 10:22:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763576553; x=1764181353; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FO4KjGAbGPuvhBe9yeD5XsNnfu5YNrr6lV0HpFXJ+/A=;
        b=VWb4oB5/iX8pCb+RnLHko82CC245FGWViUPz2Gckm+/nEhI+DNZ/0ULtqWL7frWnhn
         IIG8byfUJHMbjUKq42WUM/B8LED+s80y0tlxAF8dfo9M9UkUnd8hmi49GSL3zJV9t7YE
         PW9oq/2dk10QnN7m/Gs3mWW30panGWkGHDm1ktJeAcdZxwM3M2RiZ0gi8CiU8djvubZs
         gYISWQV1Qep4k2TyAV1qnlBP2V0fZc+QZhOQR6MwSvHVtTK7MDQpCdO2Cuc7Iudhi+D3
         1DETvov04hTsn4fBiFiQCxMbzzyXTosybdv2oq5B26fDQKwoQdSxBCaSUEbYscxn/+gs
         56yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763576553; x=1764181353;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FO4KjGAbGPuvhBe9yeD5XsNnfu5YNrr6lV0HpFXJ+/A=;
        b=wund+AiNbhxnDFWTPMTeOexr/QyyhNGlCs+MyqPQ8WPdmmoB7N9FjoV6e20nuZbxUB
         wcWZrVlSwpHu6LFPmF1oqE2CsvVKJ3dh4fLvzMVVnhmJ8bN7WAufICSAfn3gl3X/JcYh
         vDdL7CRL9AfS8dQS5hgIlHT6g9iuWqLsXROo/OuZJ2a7M/UEF5DwAwxzzbKInQByv54V
         a1SNRElHfBVAlW2wgD5c6ccKlZ1+P0DrkUAji7AL5oD7HrPqOx8Uoe1sdwNOpp6EGOev
         UmskDZcljJW0HibhakXnSDWtZn7GUVHxzhPiHVBsqtnv5Mhar/wgQ/4azeeF2P519jS3
         xCCw==
X-Forwarded-Encrypted: i=1; AJvYcCWz6izizC8ey8NFLZjGOPXt8xHboumTsVFhtLSzbktol/zcat2LilPidVbmS33KAwa/4QzCCCUWH20=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk92pDflb3ebBXQaAIfM9UKw5JWB91RyX79bJQbTEFJkBVhLdR
	TIPIulqh6W/BE8hp/9wrD0Skrk6itqYh3FvG+NLq1g1GlGewoUZO8QxtTME3EpR6FISVFAKlViy
	xkaFqDOwqJUJM2u8uzz6xdSHvtS3ZFNo8YMBpUc7LM9MG3/SgOjI+22cJp9O2RQ==
X-Gm-Gg: ASbGnctRgI/Vea69xkwQnsSqfZ1pAYg3j/oNy1E22X8VjeS0sRbmbVeGmY4+mvXX7nH
	/ye+fQSCrRWQkvGBs5OOaQohAeajNsVeTjxxtZz1RVANGn1P2OEdCFlPWgRaX3gfGwaoeRSPmOG
	rHK6uuIcsraKegDPyLT+CpRdP4DMfaEexpjM16XPR7Utddng4LYcrK7Lx/eai5epGbJ9y6wYYrl
	+nHaNmfTIyegnWU6ZhuAz+mhvbouOG5H+5AYM+8TSMNjSOHdbH5QENxJvDo1EQYef/mEFH1ig+U
	lOkFM2wIGIPPLeCKInUwnmtySTfsleaDGel3BVmDSfHV+5jma/XyXbJClKxUNHF4Pz310TmN91t
	6xa299PD83A==
X-Received: by 2002:ac8:5f82:0:b0:4ee:1c57:5ce4 with SMTP id d75a77b69052e-4ee496cea06mr2774571cf.66.1763576552872;
        Wed, 19 Nov 2025 10:22:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHvt+1zeDh5Ofy7EK6Z/fTtrB9kwXRVzKc8aI9vjUgjAL/l6xdzzHqq11ZxJDhT1bUEFIDL5g==
X-Received: by 2002:ac8:5f82:0:b0:4ee:1c57:5ce4 with SMTP id d75a77b69052e-4ee496cea06mr2774281cf.66.1763576552487;
        Wed, 19 Nov 2025 10:22:32 -0800 (PST)
Received: from [172.31.1.12] ([70.105.249.237])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ee48e6c2c3sm1757061cf.28.2025.11.19.10.22.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Nov 2025 10:22:31 -0800 (PST)
Message-ID: <b846d03d-aa62-4671-8d44-4f3b14b53320@redhat.com>
Date: Wed, 19 Nov 2025 13:22:30 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nfs-utils: Do not drop privileges if running as non-root
 user
To: peter@bluetoad.com.au, linux-nfs@vger.kernel.org
Cc: Peter Schwenke <pschwenke@ddn.com>
References: <20251104043454.751100-1-peter@bluetoad.com.au>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <20251104043454.751100-1-peter@bluetoad.com.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/3/25 11:34 PM, peter@bluetoad.com.au wrote:
> From: Peter Schwenke <peter@bluetoad.com.au>
> 
> If sm-notify is not running root and is running
> as the owner of the state directory, it is not
> necessary to drop privileges.
> 
> The patch checks if the current user is the owner of the state
> directory.
> 
> In the case of a ha-callout, the ha-callout will, more than likely, be running
> as rpcuser - or similar.  That means the sm-notify program can not be called
> from the ha-callout.
> 
> nsm_drop_privileges() is also called by statd.  However, that will fail for
> a number of reasons such as not being able to create the PID file etc.  So,
> this patch should not cause any issues for statd.  statd will still need to be
> started as root.
> 
> Without this patch capabalities such as cap_setpcap, cap_setgid,
> cap_net_bind_service=ep need to be set.  Clearly, that is an ugly hack and
> best avoided.
> 
> Signed-off-by: Peter Schwenke <pschwenke@ddn.com>
> Signed-off-by: Peter Schwenke <peter@bluetoad.com.au>
Committed... (tag: nfs-utils-2-8-5-rc1)

steved.> ---
>   support/nsm/file.c        | 11 +++++++++++
>   utils/statd/sm-notify.man | 10 +++++++++-
>   2 files changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/support/nsm/file.c b/support/nsm/file.c
> index 5ec801c3..1e97b5b6 100644
> --- a/support/nsm/file.c
> +++ b/support/nsm/file.c
> @@ -394,6 +394,7 @@ _Bool
>   nsm_drop_privileges(const int pidfd)
>   {
>   	struct stat st;
> +	uid_t uid;
>   
>   	(void)umask(S_IRWXO);
>   
> @@ -408,6 +409,16 @@ nsm_drop_privileges(const int pidfd)
>   		return false;
>   	}
>   
> +	/*
> +	 * Check if we are running as non-root user and we are the owner of
> +	 * the monitor directory.  Then there is no reason to drop privileges
> +	 * and change groups etc.
> +	 */
> +	uid = getuid();
> +	if (uid != 0 && uid == st.st_uid) {
> +		return true;
> +	}
> +
>   	if (!prune_bounding_set())
>   		return false;
>   
> diff --git a/utils/statd/sm-notify.man b/utils/statd/sm-notify.man
> index addf5d3c..2e82c683 100644
> --- a/utils/statd/sm-notify.man
> +++ b/utils/statd/sm-notify.man
> @@ -275,7 +275,7 @@ section is
>   .SH SECURITY
>   The
>   .B sm-notify
> -command must be started as root to acquire privileges needed
> +command is, generally, started as root to acquire privileges needed
>   to access the state information database.
>   It drops root privileges
>   as soon as it starts up to reduce the risk of a privilege escalation attack.
> @@ -290,6 +290,14 @@ chooses, simply use
>   .BR chown (1)
>   to set the owner of
>   the state directory.
> +.PP
> +The
> +.B sm-notify
> +command can also be started by the user ID that owns the state directory.
> +That is useful for the situation when it is called from an rpc-stat
> +ha-callout program that is already running as the
> +non-privileged user.  The non-root user will not have the capabilities
> +to drop the root privileges as described above.
>   .SH ADDITIONAL NOTES
>   Lock recovery after a reboot is critical to maintaining data integrity
>   and preventing unnecessary application hangs.


