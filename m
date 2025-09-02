Return-Path: <linux-nfs+bounces-13986-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C864B40EBC
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Sep 2025 22:47:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83F285615C6
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Sep 2025 20:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 191CC2E7F1D;
	Tue,  2 Sep 2025 20:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PKl5jy57"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A512DECB4
	for <linux-nfs@vger.kernel.org>; Tue,  2 Sep 2025 20:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756845999; cv=none; b=ZG6MZ+hSWyF1kzrwku/CNjr/T/BLV5g7aKCF5YmPf1SHZ/d5rieoBLtSWPxv95XByfgea1iA6WDprzl1ss4tbcRq6dE+XwErrEae3c1CaZgoCpeOeO+oHF7e8p/OsZtXswc6F86iHzYbfmz45JvFfqWazfd9sGPintB1hN/2dI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756845999; c=relaxed/simple;
	bh=OhR35b7EL7boJMTg3Cwi69gv16+KmUKiIRyyy74Kn8M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mXt0WPwOKQncp9ccJviB4y0N3+OckBOOF2K9kMGYlPq3s4Zy5sXOgGlbMfzwEPxrM8RDCIW25WntfHyFC6MdSiI39LrKdTZFp+EBnqIn+gxT0rXkBS4Ajd2DkgA2Gf6V6GwmFOxNZu7MRm0PP/KOVu3qXnmXgQEjd2DgL4jpOow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PKl5jy57; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-723c971b63bso315596d6.1
        for <linux-nfs@vger.kernel.org>; Tue, 02 Sep 2025 13:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756845996; x=1757450796; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hIRMAQXzXrnjd83lIH5i6gNnDlI2tsS9k74/yCIeL7E=;
        b=PKl5jy57U2ZMTWEHp6sD6huNEhVBv8ehHILog1NFXBTNC8mvWhDszYm4aVBwsagiib
         B02INgUyqV3PSroYKsFDDMfm25yJwgSmoWLPOy+OrVaGRufqp0oJahjD/QF0VbBzV2ZI
         pI8cclppZKICbmnjxP9JyCWPe6AkD3fqs25PipY6IivaTGZVHEmKOs0kcvO+osOJDfHx
         x0epJPTsqnJWE82e+eogfhjGsZpD33hDq3DZ7Ix70K6hfIax4J4XSQoLoZ6Gh11TM1qB
         k4zEsDgVCH1KYVZMVuW2Vam9OSDliJ3artfDXtSh1jiENiDTBDWCAXQWcxMSoj6glir6
         M7ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756845996; x=1757450796;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hIRMAQXzXrnjd83lIH5i6gNnDlI2tsS9k74/yCIeL7E=;
        b=BNTBimnjaM4Oj4ecgEa+m2Q5zI1Nu4aDsDSgYrhWEkmkAonMPRcXAzbWtXTaOssz5K
         LbDVTG6BBWC7hmq+zaebLiMmJLNkVP4K0TwVT3tHZwqWA/hhRIBJJsoGTekkN/B9PXVQ
         JxMDXIj6Io4yB1n0lAhizbIrA/SxBYaKUubpw68XUAyxfojUC5Kb9E5QxmO9R4eiN3dc
         LT10kUdQPytihTNNz6ZnObJcs3IaQMvli9qWI3KmT5iMb7CpRhcJHPtzRtmDTi+e24jN
         JA4iXHqDUgtQt9mQAxcYakE0HlFVCftAGDofGyvDC4MJ/bCdCNUgQP87yWouuCQCmgxX
         4rLA==
X-Gm-Message-State: AOJu0Yw82FgH8dVcs/KLxNiG2FNNszmIxKmuG5r2+zYs00/xUlcCrdtF
	UEY828WI+Nto9A8qBjYeSU/hKmb2WQvMqjhuzXrcK1YMn7P8+dK4t3jB
X-Gm-Gg: ASbGnct4Ti6rG6fK9Tuh9UxN1Z6YhBo+4Ks++txcrzkZ22gQ18L0Dm+flkhgVu63TpY
	srThgXLu3cACuIFfUjVIyVSOIH4voPDHJRgXGKWOoR7Ri8Tp5VJEKIlhWk9MjFARiRHuCdTPPq9
	09j1ssislxKJjd2RzWIvzUofl1yzCX8nshci5cuZRKniAYAjJ6Wp4np/znyBuhkBjZop+IrXvyl
	7XiWzSAvxokzLdpwekoJe1oCHAF+9QvFCQzwGdFdxRLTLD1SE1A435P9J0RkJT/mr843BEP3b2T
	7AjV7ylIB57NdznwpV6X+k9TJHA2JYP7ICmfsygmNQPu4RBIOLklTNbVc4aBncdcV+fT+Pu8b24
	VJkohGVhoIdjJFe62NBY=
X-Google-Smtp-Source: AGHT+IGGBt6gEQxBv41os9h76XJNYE1PlHrAuljhbNiTjp0yhqiyc2LV1PexI3a2RhnPuEUfICFsOw==
X-Received: by 2002:a05:6214:c67:b0:714:87d7:4c8a with SMTP id 6a1803df08f44-71487d7580emr107728096d6.8.1756845996065;
        Tue, 02 Sep 2025 13:46:36 -0700 (PDT)
Received: from [10.1.16.8] ([104.222.93.83])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-720ac262a5asm18014156d6.2.2025.09.02.13.46.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 13:46:35 -0700 (PDT)
Message-ID: <851ebd04-8f9c-4a17-aa55-654c021f07a5@gmail.com>
Date: Tue, 2 Sep 2025 15:46:33 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xs_sock_recv_cmsg failing to call xs_sock_process_cmsg
To: Olga Kornievskaia <aglo@umich.edu>
Cc: linux-nfs@vger.kernel.org, smayhew@redhat.com, trondmy@hammerspace.com,
 okorniev@redhat.com
References: <966f4d30-16f6-4a11-8d6c-1d6102781e71@gmail.com>
 <CAN-5tyGHKCt0KhTt2jKNdx77H3RcgY-xPKwkL4udvciR99=rrw@mail.gmail.com>
Content-Language: en-US
From: Justin Worrell <jworrell@gmail.com>
In-Reply-To: <CAN-5tyGHKCt0KhTt2jKNdx77H3RcgY-xPKwkL4udvciR99=rrw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 9/2/25 11:21 AM, Olga Kornievskaia wrote:
> On Tue, Sep 2, 2025 at 8:27 AM Justin Worrell <jworrell@gmail.com> wrote:
>>
>> xs_sock_recv_cmsg was failing to call xs_sock_process_cmsg for any cmsg
>> type other than TLS_RECORD_TYPE_ALERT (TLS_RECORD_TYPE_DATA, and other
>> values not handled.) Based on my reading of the previous commit
>> (cc5d5908: sunrpc: fix client side handling of tls alerts), it looks
>> like only iov_iter_revert should be conditional on TLS_RECORD_TYPE_ALERT
>> (but that other cmsg types should still call xs_sock_process_cmsg). On
>> my machine, I was unable to connect (over mtls) to an NFS share hosted
>> on FreeBSD. With this patch applied, I am able to mount the share again.
> 
> Thanks for the catch Justin. Indeed, the client fails to return an
> error in case it receives anything other than TLS DATA or TLS ALERT.
> Could you tell what kind of TLS message the FreeBSD server is sending?
> Either a network trace or turning on tls_contentype tracepoint should
> show what type the client has been receiving.

Hi Olga,

Unfortunately, I don't know much (anything, really) about Kernel 
debugging or the SSL protocol. I do have root on both boxes and am happy 
to provide whatever information would help with better understanding the 
issue. Could you provide some guidance (even if just where to go to 
rtfm) to fetch the requested info? I don't imagine just a tcpdump of the 
ciphertext is sufficient. If providing this assistance is too spammy for 
the list, it is okay to reach out off-list.

>> ---
>> diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
>> --- a/net/sunrpc/xprtsock.c     (revision
>> b320789d6883cc00ac78ce83bccbfe7ed58afcf0)
>> +++ b/net/sunrpc/xprtsock.c     (date 1756813457481)
>> @@ -407,9 +407,9 @@
>>          iov_iter_kvec(&msg.msg_iter, ITER_DEST, &alert_kvec, 1,
>>                        alert_kvec.iov_len);
>>          ret = sock_recvmsg(sock, &msg, flags);
>> -       if (ret > 0 &&
>> -           tls_get_record_type(sock->sk, &u.cmsg) == TLS_RECORD_TYPE_ALERT) {
>> -               iov_iter_revert(&msg.msg_iter, ret);
>> +       if (ret > 0) {
>> +               if (tls_get_record_type(sock->sk, &u.cmsg) == TLS_RECORD_TYPE_ALERT)
>> +                       iov_iter_revert(&msg.msg_iter, ret);
>>                  ret = xs_sock_process_cmsg(sock, &msg, msg_flags, &u.cmsg,
>>                                             -EAGAIN);
>>          }
>>


