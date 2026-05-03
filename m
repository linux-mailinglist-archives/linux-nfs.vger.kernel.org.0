Return-Path: <linux-nfs+bounces-21366-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YGioNAr+9mkabAIAu9opvQ
	(envelope-from <linux-nfs+bounces-21366-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 03 May 2026 09:49:30 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CE424B4D3D
	for <lists+linux-nfs@lfdr.de>; Sun, 03 May 2026 09:49:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5EBA33003629
	for <lists+linux-nfs@lfdr.de>; Sun,  3 May 2026 07:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D698B3A901C;
	Sun,  3 May 2026 07:48:58 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3DC3A875C
	for <linux-nfs@vger.kernel.org>; Sun,  3 May 2026 07:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777794538; cv=none; b=OVcabl2Aocx7T6iae3E0Ucs4JdOeqxus3Y8mFzg045oNkYMoOScMK4pd5s7aN/npKZdW/iM8N9UWjptU2duiyHtTVZJMGv1hTwGIQCTKBA7p7D5ocoznbK5oNEEdiHPV+Ft8l94pPQlOE6Gax56nNLsr+SXo0Ff5GwehzQG3UeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777794538; c=relaxed/simple;
	bh=PLx9Zoa8UL5sjHZD5SjE0bRUhgl/4Oe21i0xKz+x7TU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K0HWWk83GKCy6lMHQkPmnlxMJ+6OT0gTOWCtcugh48eKFO4Oonutmta5I1IIX+mQUVAEBLqyvfRiygMY8SJBON0prj1MjpvPQRzSbnn4eiKL1+2Kr1G4lIsxuvPZkJLlcH+thcCD5pQnueVQprxKvpMhgIqzNSz+aZqLSTPbSaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-44a14580111so1713970f8f.0
        for <linux-nfs@vger.kernel.org>; Sun, 03 May 2026 00:48:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777794536; x=1778399336;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZPHUcGdbv7Ch7jGJFK5JqglmPmO4Ck3el5ikbMNjxkY=;
        b=TdnViq9aaX7dV2DNlXRD4Yx3P+7nPmwqRVgWxw3SZEYwkZjse9QjmRbZkZoj/s9eGp
         jowNss9ejKGJRyJ7a0RJbyLGqYHbzsGK1Ock8gFajyFdHshopKlMCJZDdDvp4QUbqCVg
         /4Qxjg+J1wd88eXMUmSTaQk5khFPPd4mBa+ZD4BvmxN9zzod9rISPaC/2zzW/lOcr+rK
         l9IzVR9U+/zHxQ0OR709ifWILQ6VqX1KgLUVzyT+gzoIWuC1qF/FlxU9tznwcTxmUd/F
         LvZwozPGYEOs2BXloYikeuCOllNK7kxbaxC2E0Hx0gvcHjx2m+2/caOEgnmekgZ3ZMrT
         SKcQ==
X-Forwarded-Encrypted: i=1; AFNElJ+yIzxYH4tijrIIv+ufirpd0E3Ca/CYv8GpvMlKEe5xG7jEiitcaA/SM9R/I+LgrapI+0Sft/oPBp0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyacceYAUArPJlMpq+p8ZWZrh6oVZ88YByUtwyLJOXN8vFGj2y9
	28fs8tmk41Ru6UhEeaS2fvk5RgxoV7xy8yZ1jnp6RgIun2stXiiGpqoL
X-Gm-Gg: AeBDieumdaTl/prtuVJsXQ2kiNg8jBP6RuC2r2WjmPDoKS5P9yP/k/6fc9Tvz5hrNrR
	RlTXFR4QmB62acaM7r0dtic0ZybFqJ7JGGbUfrqmn7fI0yi75gjWW9F7iybhul1BKg8A8FGaEo+
	7VMl2NJfcsEvD+nvDEVCmhp7w732Dm7TkIGx0tMcW0ZI0Cijdg4Fe6mSLThfdvLM/3iEjsXOie4
	sFFoYIBqPmIMZZrXKnKNU6yOXagEuvGyixiCOXohCvWEEkOIgLN3Afum/Uo9+aPrpYOzZr2q/7w
	rFwsvm0/TZl4m2qGOxAsxk3BCh/v2hdW1Y81j1BNBSBIesCv2cyOXn2yoiWAb4j0BXAAfALnPFN
	WxNbz5EC9mqpPaQ3DBhM7kQZGJgcxSiZDGiTNLs7MuX2LTrrf0SzgFH2Y1jtWoiSF8JDzTDZHlO
	r2G6Mnr72w/D2dRUEBB5ILzqRo+DxCcXr91ly3xklQy8Q4oTPULt/B1hD55CMupJ81R3DnS4ZfJ
	g==
X-Received: by 2002:a5d:5c89:0:b0:446:96b1:f53 with SMTP id ffacd0b85a97d-44bb5b4d38cmr8855673f8f.26.1777794535829;
        Sun, 03 May 2026 00:48:55 -0700 (PDT)
Received: from [10.50.5.21] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-44a8ea7cf5dsm17093705f8f.1.2026.05.03.00.48.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 May 2026 00:48:55 -0700 (PDT)
Message-ID: <e55cd958-6d86-4c6b-abc6-5be83fc53b0b@grimberg.me>
Date: Sun, 3 May 2026 10:48:54 +0300
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Breakage in ktls-utils with nfs keyring?
To: Chuck Lever <cel@kernel.org>, Scott Mayhew <smayhew@redhat.com>
Cc: Chuck Lever <chuck.lever@oracle.com>,
 Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
 kernel-tls-handshake@lists.linux.dev
References: <fd4aaf4e-b1b7-4ca2-bc93-955c31fab317@grimberg.me>
 <92a53963-1e4b-42eb-af81-6be9f63f9e43@app.fastmail.com>
 <afUKzeUYPhb97DX4@aion>
 <7c6516be-adb9-4d0d-ba7c-fa107fd4a865@app.fastmail.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <7c6516be-adb9-4d0d-ba7c-fa107fd4a865@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3CE424B4D3D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	SUBJECT_ENDS_QUESTION(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21366-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[grimberg.me];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sagi@grimberg.me,linux-nfs@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,grimberg.me:mid]



On 02/05/2026 6:08, Chuck Lever wrote:
>
> On Fri, May 1, 2026, at 4:19 PM, Scott Mayhew wrote:
>> On Thu, 30 Apr 2026, Chuck Lever wrote:
>>
>>> Cc'ing the ktls-utils development list.
>>>
>>> On Thu, Apr 30, 2026, at 9:32 AM, Sagi Grimberg wrote:
>>>> Hey Chuck,
>>>>
>>>> Upstream ktls-utils fails passing client certificate and private key
>>>> using the .nfs keyring.
>>>> Bisecting leads commit facd084e43fc ("tlshd: Client-side dual
>>>> certificate support").
>>>>
>>>> I manually apply this (probably wrong) change and keyring works:
>>>> --
>>>> diff --git a/src/tlshd/client.c b/src/tlshd/client.c
>>>> index 2664ffb..a946797 100644
>>>> --- a/src/tlshd/client.c
>>>> +++ b/src/tlshd/client.c
>>>> @@ -327,7 +327,7 @@ tlshd_x509_retrieve_key_cb(gnutls_session_t session,
>>>>           } else {
>>>>                   tlshd_log_debug("%s: Selecting x509.certificate from
>>>> conf file", __func__);
>>>>                   *pcert_length = tlshd_certs_len;
>>>> -               *pcert = tlshd_certs + tlshd_pq_certs_len;
>>>> +               *pcert = tlshd_certs;
>>>>                   *privkey = tlshd_privkey;
>>>>           }
>>>>           return 0;
>>>> --
>>>>
>>>> But, I have a feeling its not the correct change...
>>>
>>> Scott, can you triage this?
>> So when I added the dual certificate support, I didn't touch any of the
>> keyring code.  Frankly, I'm not entirely sure what is the right way to
>> set it up and the docs are pretty much nonexistent.  As far as I can
>> tell:
>>
>> - you need to load nfs.ko first so that the .nfs keyring gets created
>>    via nfs_init_keyring()
>> - you need to restart tlshd so that it links the .nfs keyring into its
>>    session keyring (I tried loading nfs.ko at boot via modules-load.d,
>>    but tlshd still reported an error saying it couldn't find the .nfs
>>    keyring)
>> - you need to convert the cert and key to DER format
>> - you need to add the cert and key to the .nfs keyring, e.g.
>>
>>    keyctl padd user "nfs_cert" %:.nfs < smayhew-rawhide.crt.der
>>    keyctl padd user "nfs_key" %:.nfs < smayhew-rawhide.key.der
>>
>> - then you mount w/ '-o xprtsec=mtls,cert_serial=...,privkey_serial=...'
>>
>> Is that somewhat accurate?

It is.

>>    Is there a better way to do it?

Have a script/automation SW.

>>   It seems
>> like a lot more work than just using the config file.

Well in some cases, storing credentials on a persistent file is not a 
viable option.
For nvme there is a userspace utility that helps with this to some extent.

> It is more work because keyring support for the NFS consumers is still
> aspirational/experimental.

Can you elaborate? I think people expect to be able to pass certs/keys to
tlshd the .nfs keyring. Also I expected it to work (as it used to).

>
> I've pushed your patch to a "fixes" branch for folks to try out. I'm not
> sure yet whether we want a 1.4.1 release with this fix, since keyring
> support for NFS is "not finished".

I understand that there are features that are not supported via the
keyring interface. But I think that users expect things that used to work to
continue working. My personal opinion is that releasing this fix is 
appropriate
given that this is a regression.

Is keyring support for NFS marked as "experimental" or "not finished" 
anywhere?
[I should register to kernel-tls-handshake mailing list]

