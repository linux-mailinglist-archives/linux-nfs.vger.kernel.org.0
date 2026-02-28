Return-Path: <linux-nfs+bounces-19441-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sNPVKIIio2mC9wQAu9opvQ
	(envelope-from <linux-nfs+bounces-19441-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 28 Feb 2026 18:14:42 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CD841C4D4E
	for <lists+linux-nfs@lfdr.de>; Sat, 28 Feb 2026 18:14:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B29C1305E9E4
	for <lists+linux-nfs@lfdr.de>; Sat, 28 Feb 2026 17:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ECD826ED3F;
	Sat, 28 Feb 2026 17:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mwk87UPT";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="T8rXwG98"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976AF1DD9AC
	for <linux-nfs@vger.kernel.org>; Sat, 28 Feb 2026 17:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772298879; cv=none; b=WEf9u6TV181as6/eCkaTq3giOz8NYml09x5a570hRiCFMdEa/3KlT+St+HaF+KFyL4YGnNqnxpiv1k4co8mPvK4jYQP3QyAdFvMdpLlvu5M8t6C8ZwH1i2vMAYNmrKyRyHNntk93T0/QuY5IofZ4kMNEXK7UITDKsEl0EkRrjO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772298879; c=relaxed/simple;
	bh=nYu5xSuyuOz++lUYD5VPib8JROw+DntjluT5KwB4uFQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UXk2K4wEkxTY0PQoJzn7fxJQDLBDXYhVAWfTap565KjJL1haESiQKgFHesFZ5Fubc1jcmQxqj9ZgnGxtSkocoyb9VF784IQuC1hJOQCjy0eysj5UnvLxmsbCq7lFfLbe+Wtxfy7+5nl8L73bxlU+vbjnfHnLg9mVSmmmi3ta4Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Mwk87UPT; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=T8rXwG98; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772298877;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jfmR28dGclI5VgRd1GZdOJa7EynW8xMaRg6TCmG6NE4=;
	b=Mwk87UPTvOQaw1pbFK3DISfLuryzhxCA2NNS4b61/MSux7Zq1kV7F15ie58B2+9m4bQQMh
	XcGVGMQvrqSfoJZMgQd7pmQLItzWO8I6aZ6y1OieJGjXHEEUnY0MqPhUTPZ/YtCpkGkEMd
	OSrmo6DNWc8bdgdZQoleA5hwMB0JJgk=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-381-2z51hOjRO0Sj-2CE4vP5OA-1; Sat, 28 Feb 2026 12:14:34 -0500
X-MC-Unique: 2z51hOjRO0Sj-2CE4vP5OA-1
X-Mimecast-MFC-AGG-ID: 2z51hOjRO0Sj-2CE4vP5OA_1772298874
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-506bfff75edso398263691cf.3
        for <linux-nfs@vger.kernel.org>; Sat, 28 Feb 2026 09:14:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772298873; x=1772903673; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jfmR28dGclI5VgRd1GZdOJa7EynW8xMaRg6TCmG6NE4=;
        b=T8rXwG98jdxgRYqk0WgqSNsPh6TAsA55lBlUbVpc2PhUrQQDN+V8Jpd2oP7MErwiwp
         QpatpmgNffEJfTLC75N1Wy19bxl8RcWi3Im6/EJPEtkJCRh9AM/WZM2+ueTJS9FXHuWT
         odIM86a4z7DRhFcVO1jqdH9r2y4ZTU4I8qG/szx7hC2LZ9weONbrSDyrimdG2sLaXcsj
         Rr6WnyMOdpOaxS0breBMa/jw3hEsArrAiePKxuqNKu5Qsh6h8gByPDBtAGBp24RRtJSF
         9UuzOHPBMlCpvtM4rkmnm3Wa9bIPO+0RLm2MZ+4b8auAuPmardkuVONtK6+lsjkIYBUX
         r5Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772298873; x=1772903673;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jfmR28dGclI5VgRd1GZdOJa7EynW8xMaRg6TCmG6NE4=;
        b=g6Nb2oWJ8Cs6d7TFMpY2ooLUNHUFyKqRubQw1L+0kOiXQ5/TBuJKwkPZ/jPohuh2On
         /jt/xcfriC8N1W22p7z+pU1PVjtwGLSdrtVHMPT7a0QGSOoPlbIuHbmzD/X5wBZHtRyK
         fC1Oh03bJtDaSUKaXaUijMuI9PsGugwkNlttsRkoUC3a0ROjjt/OQAZWU1CBp+6WPQ6N
         Fh17LqPGJa7KO2OPo8gpgkSHTcSdvv+WzfnxPNYMJcXraQ1haFSTdV6YaCpURS3tmKvj
         9MnCN7d1a6G+yVf0+mAtBwOmUzG4G3SNGdqXdGEfKtp5IqefEyae/Q4y1tL8MKHRboP6
         Hc/w==
X-Forwarded-Encrypted: i=1; AJvYcCUNSWRm3J4WSe0Pm9a7n1n7XoB0ERxnv/rjpyVwWxTItO97lFUtEQM9oRQaJsACfIn0HAArZQ9334g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBYU/oIXOGzKzy22/sS2aLE7lMqIj6aWxtTmhQMhG45cx7t6gl
	iP8X8UhwyypLlaYurORJLfvbDfY+1u2uCPwk25cAXkfpcKXKanu92aFzCUBKPbod8CYsmMCjJp2
	hC0UcJQoPr6Av/S2USDYyU1BVaOOyul+7DmX5WBLc5QnHb7SRwKLgXx2z3GdLjSob4duH6w==
X-Gm-Gg: ATEYQzxhXmCCLSR6wJT3kIjc4I2etHwrOXplIR+mm0bayNjCCIX0gGKDvupDJzR5foo
	m9n8fS/Ve8E4xU2+I5URvzHNits22T5puYH9fHjSjV096tlmG7Rvj0MQYT2fzNdGP6BD/5kIw33
	UFrNFp3YGFfQ+W+TQxbuNCpQgjMe46uM9CdkHPH5K3BGWgtSG0WizTkNeXcIKe1cA+LiFIUq7sZ
	+nwXOd3Pq6wnNjZSynozJBGefxDLtW4Pe9AMGe6u1LytXmV/Q46F5XlQgZhoVL4fooWi2h7S0Zl
	Oub/3hgXMEA+x3io0sQenCXOamXGvOq/N1LB7UX6g6U5+RF6yGW4Z7oomlZGiqLYtcke1euVKI7
	RPVhB2D10S/PymXDJT9G3
X-Received: by 2002:a05:622a:144:b0:4ed:b363:2c2 with SMTP id d75a77b69052e-50752956623mr93896221cf.62.1772298873623;
        Sat, 28 Feb 2026 09:14:33 -0800 (PST)
X-Received: by 2002:a05:622a:144:b0:4ed:b363:2c2 with SMTP id d75a77b69052e-50752956623mr93895951cf.62.1772298873260;
        Sat, 28 Feb 2026 09:14:33 -0800 (PST)
Received: from [172.31.1.12] ([70.105.240.20])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-899c7374e07sm69737646d6.33.2026.02.28.09.14.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Feb 2026 09:14:32 -0800 (PST)
Message-ID: <3dbec7c8-5d24-4c64-bcd6-c617adfebd0a@redhat.com>
Date: Sat, 28 Feb 2026 12:14:24 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [nfs-utils PATCH RFC 0/4] Rework the handling of encryption types
 in rpc.gssd
To: Scott Mayhew <smayhew@redhat.com>
Cc: =carnil@debian.org, linux-nfs@vger.kernel.org
References: <20260213224012.2608126-1-smayhew@redhat.com>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <20260213224012.2608126-1-smayhew@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19441-lists,linux-nfs=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steved@redhat.com,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0CD841C4D4E
X-Rspamd-Action: no action



On 2/13/26 5:40 PM, Scott Mayhew wrote:
> These patches address the issue described in "nfs: ls input/output error
> ("NFS: readdir(/) returns -5") on krb5 NFSv4 client using SHA2"
> (https://bugs.debian.org/1120598).
> 
> The core issue is that when the krb5 library does a TGS request, it
> initially does so with referrals enabled, disregarding the enctypes list
> supplied by the requesting application.  It still checks the resulting
> ticket to ensure that it's using one of the requested enctypes, but it
> may not the highest priority enctype from our list.  See
> make_request_for_service(), step_referrals(), and wrong_enctype() in the
> krb5 code.
> 
> The problem arises if it does this when setting up the machine
> credential, but it doesn't do it when setting up a user's credential
> (which can happen in the case of constrained-delegation via gssproxy).
> 
> That can lead to the machine credential and the user credentials using
> different enctypes, leading to XDR decoding failures described in the
> above bug.
> 
> These patches aim to address that issue by making sure that the list we
> pass to limit_krb5_enctypes is in the same order as the default list
> in the krb5 library.
> 
> Scott Mayhew (4):
>    gssd: remove the limit-to-legacy-enctypes option
>    gssd: add enctypes_list_to_string()
>    gssd: get the permitted enctypes from the krb5 library on startup
>    gssd: add a helper to determine the set of encryption types to pass to
>      limit_krb5_enctypes()
> 
>   nfs.conf               |   1 -
>   systemd/nfs.conf.man   |   2 +-
>   utils/gssd/gssd.c      |  16 +--
>   utils/gssd/gssd.man    |  30 +---
>   utils/gssd/gssd_proc.c |  15 ++
>   utils/gssd/krb5_util.c | 311 +++++++++++++++++++++++++++++++++--------
>   utils/gssd/krb5_util.h |   5 +-
>   7 files changed, 284 insertions(+), 96 deletions(-)
> 
Committed... (tag: nfs-utils-2-8-6-rc3)

steved.


