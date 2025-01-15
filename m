Return-Path: <linux-nfs+bounces-9239-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6E7EA12A1A
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Jan 2025 18:47:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2187C3A3335
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Jan 2025 17:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2F28155C96;
	Wed, 15 Jan 2025 17:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NWUM8bjD"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6D314A630
	for <linux-nfs@vger.kernel.org>; Wed, 15 Jan 2025 17:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736963257; cv=none; b=RjRinZbk66MQOV0Ok+329ap1juKcWi9uRaZ7AfnuCOUvEuYtSCTtsw0NKLPJuL/Jr9bE3h1NK6mgHkPFKR14B9T2WwTJCbtLqcagHn5CnWa13ep8n0m12PRFVUXJIYpD+p65h3dGM9Wym3SlsI4cucf7JUvF2jFcERhgr8WYvhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736963257; c=relaxed/simple;
	bh=Tpytb9EwrEWbxKDdx04/DG8L5exAe8suAYokDxjXYww=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IxdA1m/yWztxh9t5DReTnyl2ph3EgH8qqEbOVNXQDsUEMDm1XRQj96kOm/IzNtdYG7rHYxDXVnZC8Oj/ZC86VhW+amyecqw2KBe5APOKlLf5Z+MVLS/E4i7EudqrK7BgeBTatgY5IY0rha+RUTNOWRm60GK0ieI5GnAjckx8P2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NWUM8bjD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736963254;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nKv9oiS9lo5k+p61/ovhzjrU1Ct7Ipn4QWrguWRBUu4=;
	b=NWUM8bjDusmJkTH7W75zwa1cdjUX00CYv8I/qx3Np+ZM+vt2bxAEk8SmNDqxqmTMcIfRO+
	SZz3XJwUbHWgcc+NV4mQR8+3BvnPaD8s7FujkCrqKAmQQ/h9uJPmE9F5cHYjX/2Rr2Fp4y
	1Ex0AuR8EVOzD4iCq9ea+fkJKJQxako=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-251-aSNnNlPdNAW_ZLtC0b_woA-1; Wed, 15 Jan 2025 12:47:33 -0500
X-MC-Unique: aSNnNlPdNAW_ZLtC0b_woA-1
X-Mimecast-MFC-AGG-ID: aSNnNlPdNAW_ZLtC0b_woA
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-21650d4612eso4179685ad.2
        for <linux-nfs@vger.kernel.org>; Wed, 15 Jan 2025 09:47:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736963252; x=1737568052;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nKv9oiS9lo5k+p61/ovhzjrU1Ct7Ipn4QWrguWRBUu4=;
        b=h0rdFk/r1ptHOPiZnaDdllu/BpqT7znw/16dlBaDH3aSgmCPyqZ3q7/C8SRGm308uD
         q/d45OpLtEqgVwCzcwKi927RueRaRXeOtn9+Sa7upsI7NH4NEfNrs7veZglYe5xuRG2U
         ghDpMOLyIo1bLd3ZtSGxN0VydiqxB9mZmUuhpl7uMbj2t6BqBNIfZAa/nEGxlPoKlD5C
         tzwmd7bttXro17jXTDA3WWSJuzwbEw1LmVPIyYgtjRpE4HS7ZpRo/d6mSs02eA7yH5Pe
         6UnlE1cVUDFBz6xfB+PLRfs79q1mHtUr5n21Cpl+I37ZrpNQg+6Hxe8R/dC4Un0aNcJa
         RoQw==
X-Forwarded-Encrypted: i=1; AJvYcCUGaF791x8r/RKvlgpUSO0PE2f9jyyyZIF+ML7D6n59CpxGKzlH5qCMD3dNJP2AxLgIE6bx9ZW2+Ts=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2t55+96ux8Gkmxvwp/D8hrxrwoB1ZcJSEeFdxEBFRcChR6uH/
	aLm/4HsbKt5rdvIk3bA1iiO5PNUZ3f/xPrntVPCvL090TP8n/2s7rQZ/G0LOB+ynB22FOLZK8s/
	VLggoixw2Dtlw95whvIZ5AHyNZhkJVZZsvc9bTsdjTzQLb+NslZrmUtALvw==
X-Gm-Gg: ASbGncsZv8gg5U9J6NWvUsq4OQVesWDTjTwQEtTgfqIcWULsqUGXgELVhDSsydwKifQ
	HYFO3hkonNfIED+5onKzqQ/4FxXI31gsr/c3oWd8VhkX8CYHbCJf3DL8b7LoV4U8JKyHvfrouwB
	dpkLl0pUrDcpmab9a1xjBYaArbfupdWFz58HTQt4SVNvsnHdgLiz6NLjzeKzCEg/iymvz22t1XG
	rrSe/FqVPPiYo7Gyh0TS4z/EydZaZBXQdIinLZOPzQot8m5kl1dv6Zi
X-Received: by 2002:a17:902:d2d2:b0:216:2bd7:1c4a with SMTP id d9443c01a7336-21a83f88f24mr447200335ad.26.1736963252437;
        Wed, 15 Jan 2025 09:47:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFjswxwYuxcAtoxEcOLPlUBXrq3Syj3WjTJ60Rpno+F492VGyk/118HVL/Rl3V3arDEeIgwrQ==
X-Received: by 2002:a17:902:d2d2:b0:216:2bd7:1c4a with SMTP id d9443c01a7336-21a83f88f24mr447199925ad.26.1736963252084;
        Wed, 15 Jan 2025 09:47:32 -0800 (PST)
Received: from [172.31.1.150] ([70.109.132.27])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f72c2f673esm1637785a91.46.2025.01.15.09.47.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jan 2025 09:47:31 -0800 (PST)
Message-ID: <00fd29bc-205a-4c02-8c98-3c3876a2d0a7@redhat.com>
Date: Wed, 15 Jan 2025 12:47:29 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [nfs-utils PATCH] nfsdctl: debug logging fixups
To: Jeff Layton <jlayton@kernel.org>, Scott Mayhew <smayhew@redhat.com>
Cc: yoyang@redhat.com, linux-nfs@vger.kernel.org
References: <0068c0d811976aca15818b60192a96ca017893f8.camel@kernel.org>
 <20250115170051.8947-1-smayhew@redhat.com>
 <590522bf-77f6-4e31-a2fb-5613f68c87da@redhat.com>
 <d38c1f357704e0b1a5b1ec47d3a84d47f8976d80.camel@kernel.org>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <d38c1f357704e0b1a5b1ec47d3a84d47f8976d80.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/15/25 12:35 PM, Jeff Layton wrote:
> On Wed, 2025-01-15 at 12:32 -0500, Steve Dickson wrote:
>>
>> On 1/15/25 12:00 PM, Scott Mayhew wrote:
>>> Move read_nfsd_conf() out of autostart_func() and into main().  Remove
>>> hard-coded NFSD_FAMILY_NAME in the first error message in
>>> netlink_msg_alloc() and make the error messages in netlink_msg_alloc()
>>> more descriptive/unique.
>>>
>>> Signed-off-by: Scott Mayhew <smayhew@redhat.com>
>>> ---
>>> SteveD - this would go on top of Jeff's "nfsdctl: add support for new
>>> lockd configuration interface" patches.
>> Got it...
>>
>>>
>>>    utils/nfsdctl/nfsdctl.c | 8 ++++----
>>>    1 file changed, 4 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/utils/nfsdctl/nfsdctl.c b/utils/nfsdctl/nfsdctl.c
>>> index 003daba5..f81c78ae 100644
>>> --- a/utils/nfsdctl/nfsdctl.c
>>> +++ b/utils/nfsdctl/nfsdctl.c
>>> @@ -436,7 +436,7 @@ static struct nl_msg *netlink_msg_alloc(struct nl_sock *sock, const char *family
>>>    
>>>    	id = genl_ctrl_resolve(sock, family);
>>>    	if (id < 0) {
>>> -		xlog(L_ERROR, "%s not found", NFSD_FAMILY_NAME);
>>> +		xlog(L_ERROR, "failed to resolve %s generic netlink family", family);
>>>    		return NULL;
>>>    	}
>>>    
>>> @@ -447,7 +447,7 @@ static struct nl_msg *netlink_msg_alloc(struct nl_sock *sock, const char *family
>>>    	}
>>>    
>>>    	if (!genlmsg_put(msg, 0, 0, id, 0, 0, 0, 0)) {
>>> -		xlog(L_ERROR, "failed to allocate netlink message");
>>> +		xlog(L_ERROR, "failed to add generic netlink headers to netlink message");
>>>    		nlmsg_free(msg);
>>>    		return NULL;
>>>    	}
>>> @@ -1509,8 +1509,6 @@ static int autostart_func(struct nl_sock *sock, int argc, char ** argv)
>>>    		}
>>>    	}
>>>    
>>> -	read_nfsd_conf();
>>> -
>>>    	grace = conf_get_num("nfsd", "grace-time", 0);
>>>    	ret = lockd_configure(sock, grace);
>>>    	if (ret) {
>>> @@ -1728,6 +1726,8 @@ int main(int argc, char **argv)
>>>    	xlog_syslog(0);
>>>    	xlog_stderr(1);
>>>    
>>> +	read_nfsd_conf();
>>> +
>>>    	/* Parse the preliminary options */
>>>    	while ((opt = getopt_long(argc, argv, "+hdsV", pre_options, NULL)) != -1) {
>>>    		switch (opt) {
>> Ok... at this point we a prettier error message
>> $ nfsdctl nlm
>> nfsdctl: failed to resolve lockd generic netlink family
>>
>> But the point of this argument is:
>>
>> Get information about NLM (lockd) settings in the current net
>> namespace. This subcommand takes no arguments.
>>
>> How is that giving information from the running lockd?
>>
>> What am I missing??
>>
> 
> You're missing a kernel that has the required netlink interface. To
> test this properly, you'll need to patch your kernel, until that patch
> makes it upstream.
Okay... I figured it was something like that. But doesn't make sense to
wait until the patch is in upstream so the argument can be properly
tested? Why add an argument that will always fail?

steved.



