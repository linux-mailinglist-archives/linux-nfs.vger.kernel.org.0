Return-Path: <linux-nfs+bounces-7866-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D749C4383
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Nov 2024 18:25:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C538D1F210D0
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Nov 2024 17:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 296F81A76A3;
	Mon, 11 Nov 2024 17:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DunH7Wz0"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1F61A76BC
	for <linux-nfs@vger.kernel.org>; Mon, 11 Nov 2024 17:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731345914; cv=none; b=AzmJgbYakoY2K7icVOqRMK8S4aW4eBuBtzvSIYW4SAMFO6SaysyMeZsvKPaK57d379XUI6YDV2G+X4Iwhl3fVAxHWuxU3SbFALCkVcJwZWmqwnXUpDs8wgUJ8ChPkyMk84MehgoTRk00syRSpCj9bqaFlOFmpa9+rZ6wxbZw/+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731345914; c=relaxed/simple;
	bh=MvyBLyUrBFr9KZIWJy6rHPwfFXtnXYtlD99ZxSGlqeI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DPRb8m6B020iT9sIo5k9qmStUPnBIlpOfk/4wE2Lx0uyX9n6YKWiDDI7v0dkznkpgWBoEy6HTumLLQ4hPz6YeSrv4LpgesSihB76lB+GUc3/8h1BUwTiMSzKvQemi2xB13F+etBcxZzdilSqMLpcmehM0lxhmrAtF1fow6aPRUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DunH7Wz0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731345910;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v0m1MV7v2RPthl8zCo0BF/JqjsUU6M+rQvUNNI3V5D8=;
	b=DunH7Wz064jRO6ZxgWoDfKENbBce7TmaNusq2FR0FroPA0qoItrDNw7eZr5LZ65b3n9DPH
	WHWUBwMB2Q41JFDCamzOpYH9VfX7Z6jj7zTkGnu789f2DlM4WjB7PbrXw21w4RKYLG7Y+g
	a1Jcv/RfBUi09qc600jy9lxCHkRIjVI=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-259-z-bYt61pNWGpGtrBmJowbw-1; Mon, 11 Nov 2024 12:25:07 -0500
X-MC-Unique: z-bYt61pNWGpGtrBmJowbw-1
X-Mimecast-MFC-AGG-ID: z-bYt61pNWGpGtrBmJowbw
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-83ac3fe1cf4so527529239f.3
        for <linux-nfs@vger.kernel.org>; Mon, 11 Nov 2024 09:25:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731345906; x=1731950706;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v0m1MV7v2RPthl8zCo0BF/JqjsUU6M+rQvUNNI3V5D8=;
        b=m57raolsZjwfACQ8o1lBdTUP1hICKVFSvnGHvfO4VbMHzoDlckBOqu9uYBcsnQzN4F
         f+68TcCE9tHnLsAUE3M3TjaMUPznZSI8coMtyWe5oqiJODXytznEDOktc3e1nlBmUqnU
         AI8oHbPqWU6r421WVcp7Svel4CDktTOg662kFIElSGaP2FZzTj20mGJBs+NTmKveOr2P
         6vrjpEjfBc2FRSOzjeT6OecfzpnzCqdv9hYNzNikDqLj7sYozgx9+MEEvnEUbtEKHrSf
         gT/Zowf5G80NWTUUHU2tUxlx6l+zY1Mqr8QheWqosocu8Ek9uRl2tGxsgiX9XUQXZarL
         +f2g==
X-Forwarded-Encrypted: i=1; AJvYcCUz2RafeAMhCEXZcbdk4X4ut4JaovOThDgbRKyBmfeljR5bZSW6QagtFek9FppW6Jx4KXKk9c2QZ1c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtpHpV6c3qs30z3jOePKI/r1piJWmHObiSXmuHkdK0vcHUwYS+
	s1LjKnVboUmt79pNLyi9ajoslMtukD8jwJmZ29kAlT6CABKCSshwFscZhI58i0EOFPfoKoCvxdp
	XmJV7idaBbGVzHBaVX6qmgoOCzxO0zB9A/vlBgTw7veLnYhHI6IXVV174RA==
X-Received: by 2002:a05:6602:6b08:b0:82c:d768:aa4d with SMTP id ca18e2360f4ac-83e032fe257mr1261354439f.9.1731345906486;
        Mon, 11 Nov 2024 09:25:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFe9cHt11pfJT3Z1hNagkFmCC9eNLInOhGf2+gBrH0s/g3dPrA4HCj/3Hmg1bmZw+ngVzQ4Vg==
X-Received: by 2002:a05:6602:6b08:b0:82c:d768:aa4d with SMTP id ca18e2360f4ac-83e032fe257mr1261343539f.9.1731345905268;
        Mon, 11 Nov 2024 09:25:05 -0800 (PST)
Received: from ?IPV6:2603:6000:d605:db00:d7de:cb5e:42f:cca3? ([2603:6000:d605:db00:d7de:cb5e:42f:cca3])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4de787f39e5sm1405350173.130.2024.11.11.09.25.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2024 09:25:04 -0800 (PST)
Message-ID: <2fb5df95-327d-435a-93e0-db71519ae221@redhat.com>
Date: Mon, 11 Nov 2024 11:25:04 -0600
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] mount.nfs: retry NFSv3 mount after NFSv4 failure
 in auto negotiation
To: "Seiichi Ikarashi (Fujitsu)" <s.ikarashi@fujitsu.com>,
 'Scott Mayhew' <smayhew@redhat.com>
Cc: "'sorenson@redhat.com'" <sorenson@redhat.com>,
 "'linux-nfs@vger.kernel.org'" <linux-nfs@vger.kernel.org>
References: <OSZPR01MB77727651A22E3D89E72954DD88522@OSZPR01MB7772.jpnprd01.prod.outlook.com>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <OSZPR01MB77727651A22E3D89E72954DD88522@OSZPR01MB7772.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/4/24 11:43 PM, Seiichi Ikarashi (Fujitsu) wrote:
> The problem happens when a v3 mount fails with ETIMEDOUT after
> the v4 mount failed with EPROTONOSUPPORT, in mount auto negotiation.
> It immediately breaks from the "for" loop in nfsmount_fg()
> or nfsmount_child() due to EPROTONOSUPPORT, never doing the expected
> retries until timeout.
> 
> [auto negotiation case]:
> 
> It breaks immediately.
> 
> # time mount.nfs -v 192.168.200.59:/exp /mnt
> mount.nfs: timeout set for Wed Oct 23 14:21:58 2024
> mount.nfs: trying text-based options 'vers=4.2,addr=192.168.200.59,clientaddr=192.168.200.187'
> mount.nfs: mount(2): Protocol not supported
> mount.nfs: trying text-based options 'vers=4,minorversion=1,addr=192.168.200.59,clientaddr=192.168.200.187'
> mount.nfs: mount(2): Protocol not supported
> mount.nfs: trying text-based options 'vers=4,addr=192.168.200.59,clientaddr=192.168.200.187'
> mount.nfs: mount(2): Protocol not supported
> mount.nfs: trying text-based options 'addr=192.168.200.59'
> mount.nfs: prog 100003, trying vers=3, prot=6
> mount.nfs: trying 192.168.200.59 prog 100003 vers 3 prot TCP port 2049
> mount.nfs: prog 100005, trying vers=3, prot=17
> mount.nfs: trying 192.168.200.59 prog 100005 vers 3 prot UDP port 20048
> mount.nfs: portmap query retrying: RPC: Timed out
> mount.nfs: prog 100005, trying vers=3, prot=6
> mount.nfs: trying 192.168.200.59 prog 100005 vers 3 prot TCP port 20048
> mount.nfs: portmap query failed: RPC: Timed out
> mount.nfs: Protocol not supported for 192.168.200.59:/exp on /mnt
> 
> real    0m13.027s
> user    0m0.002s
> sys     0m0.005s
> #
> 
> [nfsvers=3 case]:
> 
> It retries until exceeding timeout as expected.
> 
> # time mount.nfs -v -o nfsvers=3 192.168.200.59:/exp /mnt
> mount.nfs: timeout set for Wed Oct 23 14:22:23 2024
> mount.nfs: trying text-based options 'nfsvers=3,addr=192.168.200.59'
> mount.nfs: prog 100003, trying vers=3, prot=6
> mount.nfs: trying 192.168.200.59 prog 100003 vers 3 prot TCP port 2049
> mount.nfs: prog 100005, trying vers=3, prot=17
> mount.nfs: trying 192.168.200.59 prog 100005 vers 3 prot UDP port 20048
> mount.nfs: portmap query retrying: RPC: Timed out
> mount.nfs: prog 100005, trying vers=3, prot=6
> mount.nfs: trying 192.168.200.59 prog 100005 vers 3 prot TCP port 20048
> mount.nfs: portmap query failed: RPC: Timed out
> (snip)
> mount.nfs: prog 100005, trying vers=3, prot=6
> mount.nfs: trying 192.168.200.59 prog 100005 vers 3 prot TCP port 20048
> mount.nfs: portmap query failed: RPC: Timed out
> mount.nfs: Connection timed out for 192.168.200.59:/exp on /mnt
> 
> real    2m10.152s
> user    0m0.007s
> sys     0m0.015s
> #
> 
> 
> Let's retry in auto negotiation case, too.
> 
> Signed-off-by: Seiichi Ikarashi <s.ikarashi@fujitsu.com>
Committed... (tag: nfs-utils-2-8-2-rc1)

steved.
> ---
>   utils/mount/stropts.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/utils/mount/stropts.c b/utils/mount/stropts.c
> index a92c420..103c41f 100644
> --- a/utils/mount/stropts.c
> +++ b/utils/mount/stropts.c
> @@ -981,7 +981,7 @@ fall_back:
>   	if ((result = nfs_try_mount_v3v2(mi, FALSE)))
>   		return result;
>   
> -	if (errno != EBUSY && errno != EACCES)
> +	if (errno != EBUSY && errno != EACCES && errno != ETIMEDOUT)
>   		errno = olderrno;
>   
>   	return result;


