Return-Path: <linux-nfs+bounces-5076-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B49C493D892
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jul 2024 20:51:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82E541C20A92
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jul 2024 18:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7574533997;
	Fri, 26 Jul 2024 18:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SA3Ah4An"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6363032A
	for <linux-nfs@vger.kernel.org>; Fri, 26 Jul 2024 18:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722019906; cv=none; b=EKs7Xhw972Y+13d9BLoTI3XTAJN2w5LWvTQ1V1g0N0crIgd9m2XSPxwrREjcy2RIWsvW5NLTL/OI+iA7Dx/xdQPYb+mrAoNKF3NkLKeAxtotRJo+fyp6lzVVPH0WyoGh2WVuRuvU4tiGkVMkczW/wRHKh7MG5wiG6jqskdpxYFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722019906; c=relaxed/simple;
	bh=+R4LW8H0FZSyiGJDjqwOqow/Z/mr6ChLLbJENbS0hPY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=X0jIFSgOuQS4YkFHQ6HIjeuhPK9mhFbYPcvhXAY7AH9AKNuLB4jvNsJF0kNSA1tYScQeMQSbqebz8OfUVkgr74iH3YHckOPli48b1fnwEnkosrf69qEjtN2/naT3Q/J/yyI4VJC+9PBYiOtb3Rllf1fndBBcm81QisAY0aaI5Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SA3Ah4An; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722019903;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Lb8aa87f4VxVEfZ3vhjTwxLWAG4eZ2G86iOoikH2Lxo=;
	b=SA3Ah4AnIQi9q3ta5Sq6SD3W3M5Hi3P9quZ68Cy9N/+O5tSCYWwpKqDjde5qKuOVzuIYrV
	mauwYGeCbIQxaXcbIcb4ythTgIM9pK/l5Qx1ZY9anfyNp1fhzlPA2BVTnWi3nhikW6YAaC
	Fjl1TvvPJwrB7c1lcnkLdkDnsp3z/88=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-_PP2GEhBOZyEyAqY9nA-Lw-1; Fri, 26 Jul 2024 14:51:42 -0400
X-MC-Unique: _PP2GEhBOZyEyAqY9nA-Lw-1
Received: by mail-yb1-f199.google.com with SMTP id 3f1490d57ef6-e05f7e320bdso389062276.3
        for <linux-nfs@vger.kernel.org>; Fri, 26 Jul 2024 11:51:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722019901; x=1722624701;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lb8aa87f4VxVEfZ3vhjTwxLWAG4eZ2G86iOoikH2Lxo=;
        b=NpvpE8Awo929ozFCf4CdK94x1hWwp0mulaPNx+X80mwtcSoSujAMgb9W28isiMGFjk
         oBjIeLjmfYo48cKN9VrDcgf8VA19YVWLOoF7d73yi+qMM20nhloCww126k3r106vI2/O
         GovFXPGBx5btKsqFZDXiST3P2GpWfqhFqnMEFkR+PAxWO0tphReUAK8srg+pCoVEZqzH
         JKa6bZw5SN9A9Y6RQxcNWVPdQeL3vBQ0THJm+vWl+1VGKMfod1FZ/kLjLTCGyYv2sq8f
         +QWhuQsfaIuoWf9r0kOBubAgPxigijLr/2XEucRjMxKO2frdnFdkeJOtHd0BWB1CCh1f
         t/xQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHbDXPfMJOfBBTpda4hBzybycLJWZu6KLiHaQUisc1mkXomTVpFRzJOdwTWN5TVDJrACFgPv92Deg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyL2oS6KPiWWkg4RVDPFP0Wppc4Mw1PhpvZ3cqRYmtPCs3nLVEz
	V31guHRWE2WvfcmkF7QIzOqRH7jw5ucXuH+4ltqHAzA6rPnRidmX5D9MFhaTXbjx/gpgS+MkoH9
	KWH1w1V1LENDGrTqbnZM4V22kHfRVnuDa21RU537eSRKHXikhQeNhQB7g7zCGeDqBkw==
X-Received: by 2002:a05:6902:1b8b:b0:e0b:4506:7599 with SMTP id 3f1490d57ef6-e0b45067979mr1574427276.5.1722019900881;
        Fri, 26 Jul 2024 11:51:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWOKxNnoMiZJCTc0JF9hJfc9PPNBIJzWsuCYgJD+NDLnO48FRn6yPm3ZQFZgJ+o4rC1MCuTQ==
X-Received: by 2002:a05:6902:1b8b:b0:e0b:4506:7599 with SMTP id 3f1490d57ef6-e0b45067979mr1574416276.5.1722019900535;
        Fri, 26 Jul 2024 11:51:40 -0700 (PDT)
Received: from [172.31.1.12] ([70.109.163.123])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a1d73ed346sm203619085a.68.2024.07.26.11.51.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jul 2024 11:51:40 -0700 (PDT)
Message-ID: <fcb42d49-14fe-4b13-b0b2-bf4fa8125d16@redhat.com>
Date: Fri, 26 Jul 2024 14:51:38 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Can rpc.mountd NOT be hardcoded to listen on 0.0.0.0?
To: =?UTF-8?Q?Niklas_Hamb=C3=BCchen?= <mail@nh2.me>, linux-nfs@vger.kernel.org
References: <dfcca43f-0dad-4188-b092-0176cfaab2c8@nh2.me>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <dfcca43f-0dad-4188-b092-0176cfaab2c8@nh2.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 7/25/24 11:32 PM, Niklas Hambüchen wrote:
> Hi,
> 
> I found that `rpc.mountd` is hardcoded to listen on NULL == INADDR_ANY == 0.0.0.0:
> 
> https://serverfault.com/questions/1110431/how-to-specify-a-specific-bind-address-for-nfs-kernel-server-on-debian-11-4/1163083#1163083
> 
> This makes it impossible to reduce the attack surface by e.g. restricting it to a VPN IP address.
> 
> Is there a technical reason for that (while other NFS daemons support `--host` flags and `host` config options), or is that just historical?
Just historical... Making NFS work over VPNs would be a
good thing... IMHO.

I've never been big on added flags, due to
support reasons... But I think this would
be a good idea... Patches are welcome :-)

Feel free to contact me, off list, to
help out with the patch.

steved.


