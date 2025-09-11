Return-Path: <linux-nfs+bounces-14280-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08171B5306B
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Sep 2025 13:29:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A7A11883B6C
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Sep 2025 11:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E97DC317712;
	Thu, 11 Sep 2025 11:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b609dir5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D2B158874
	for <linux-nfs@vger.kernel.org>; Thu, 11 Sep 2025 11:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757590159; cv=none; b=tfC5Q7vFliDHT1QXRGTILeXn6ESVzmeNvKdu2zepzKrJeXoXF+7VMpxTBgz7g/6jcwoSrF9ydt0o+dh881bhqoczLCTB9mzfQd5WE2+gk6ICeBEH4SFE5ne5E8m/HFnWcVC6SfNZjywCDo9rgo9uumkZM+Z+/LgCPDE0S2QwwGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757590159; c=relaxed/simple;
	bh=UyYelvn5cHI48pfiQ+KMdw5CZW1xU+XHv5zoAOe+QUY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VelfCww5dMZA3vUbCwuwx4i14tGbNdDpHnCN0fwQGVjcJFGEb65njKap3ULm2xPyATh1wJ6F+STmcbnm5/Hxowgl88RIiw54DAdFeZi+XsBibso/pPZV2Au5w3HLiJk2nvXcoXhRTqhgysV4D6O0TdWlM/r2jdIiOP/z/M/xOVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b609dir5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757590155;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FsgNUkgFRWDjfVc9J41AHdACumz0XSlwUcnAF9QWYBY=;
	b=b609dir5DmyYZ+VlIx9LGVwEcnsR/bwGu5v9uXSgTIw9h04zoOvdOhgnQ9xhnBsseIpEhY
	1/c9dVqKzEfw2h5MZ4Tr7N3OUbC3yp8k5lSREA3X5btTRMbQVkbQzaePMvKyb50U7PE/tl
	AobHz2ORAR34O3/njY7bVX/NjFlg7bo=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-118-VoMF__X4NK-HOiOqNZrLMw-1; Thu, 11 Sep 2025 07:29:14 -0400
X-MC-Unique: VoMF__X4NK-HOiOqNZrLMw-1
X-Mimecast-MFC-AGG-ID: VoMF__X4NK-HOiOqNZrLMw_1757590154
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b5f6eeb20eso24923321cf.3
        for <linux-nfs@vger.kernel.org>; Thu, 11 Sep 2025 04:29:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757590153; x=1758194953;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FsgNUkgFRWDjfVc9J41AHdACumz0XSlwUcnAF9QWYBY=;
        b=ZRab5fNFsCIMLW1ejNYyS8W5EqsdRjQtCfUabxfB5imgv8EPcU+3mgYKwbMDTWuDw4
         bGV1XT4f3wGn4McshnQtmVwhrVgLeVuhHhsOjl6WHNJjAlGYMGGDuphWo5Zn+JTU1Cp0
         u2BCKL0JQrjt4hEe2Xa4i/BX2kxa4Sziqfd2ZNu1OkTsaOY3OiZbbPANzG7Cj0kRWIxT
         hVz0d/+tpz8QgNWHzcbh9ANYIat4t4EDmAm6mLgfauzUIS2LhzqycUa0ZBLVgoLmZGRE
         kJtZ22qg9Qk+sdRxYBIPTS3HHoxbyXB375ZbgdZxZ+leZIK0A6ZY0Ef7cL78rKtcXkzZ
         CDMw==
X-Forwarded-Encrypted: i=1; AJvYcCXDY/YQoMcuTp/Nkw2FABlWPk0pMVDfcvaaviU2//gg2bqcShDzYXOtS8AvRnCKaxTm2L5jc23g0B0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywn7Bx2MNaazIWevJPiWSnJz5AYXRfCz9LY5gH5AhAHbTNicIAN
	LD1aU4ErpXJ3DNxWnzDkj6sxatS4b8RjLFaDnZmpgQFW+uVurHo3auU4J2bjPbDcc9O8D/D2Mr0
	tUHDzUzS2bIpeO1sUzhi31mjAwx9nso6xqOxFy0zvMWSve9M3jnJhes5X5NEdnkBP3Zvajg==
X-Gm-Gg: ASbGncu4j07nCmfhSuX0uj4xUuAtQ9st/JYv+o6gdaeA085XqJxD/uQZn2DsyjcCNkf
	42xaDA06/uiYCG4/dTvwvPBcIsQ5IpF/UskwdSjyG6fVq7vgybaCtwyIipV0ORpnU5U/P8NT3n2
	lL2kifED0eLY3F0HYgIEMAmE2PY+ayR3kOXOM5Xb8Yw/4IQaK2XhIZGa/iW1yoLQu+dx6svRBRW
	pU3Fa5zvYv9JMU6zz0gml6nj5wL/GIUMwbFc1hw9q2sGlHF9MTm8TOQdCbXHjPGrR9cLhkuQS3Y
	c7yEVPPhmPZNNXjnqJoTRdKKg9078GiIFIQDax1wWgvgl83wDYhEfkSMiaJSB0hQhPrlG80kV/8
	A4GQjd1SbeQGm
X-Received: by 2002:ac8:59c8:0:b0:4b5:de78:dc0c with SMTP id d75a77b69052e-4b5f8446155mr228562751cf.39.1757590152745;
        Thu, 11 Sep 2025 04:29:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFYmH2W67tmWpccoH+p5bjPSRxa1bnUgfe9LmsSE8Nry84ap0v74aXnEURtp2RnIpj0w+RXzA==
X-Received: by 2002:ac8:59c8:0:b0:4b5:de78:dc0c with SMTP id d75a77b69052e-4b5f8446155mr228562421cf.39.1757590152216;
        Thu, 11 Sep 2025 04:29:12 -0700 (PDT)
Received: from ?IPV6:2603:6000:d605:db00:e99e:d1e3:b6a2:36ac? ([2603:6000:d605:db00:e99e:d1e3:b6a2:36ac])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-820c8ac44efsm88559385a.13.2025.09.11.04.29.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Sep 2025 04:29:11 -0700 (PDT)
Message-ID: <5522b8df-668d-4b55-9117-3c0b70a1dd2d@redhat.com>
Date: Thu, 11 Sep 2025 07:29:10 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [nfs-utils PATCH v2] rpc-statd.service: define dependency on both
 rpcbind.service and rpcbind.socket
To: Scott Mayhew <smayhew@redhat.com>
Cc: neil@brown.name, bcodding@redhat.com, yoyang@redhat.com,
 linux-nfs@vger.kernel.org
References: <20250909131752.1310595-1-smayhew@redhat.com>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <20250909131752.1310595-1-smayhew@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 9/9/25 9:17 AM, Scott Mayhew wrote:
> In 91da135f ("systemd unit files: fix up dependencies on rpcbind"),
> Neil laid out the rationale for how the nfs services should define their
> dependencies on rpcbind.  In a nutshell:
> 
> 1. Dependencies should only be defined using rpcbind.socket
> 2. Ordering for dependencies should only be defined usint "After="
> 3. nfs-server.service should use "Wants=rpcbind.socket", to allow
>     rpcbind.socket to be masked in NFSv4-only setups.
> 4. rpc-statd.service should use "Requires=rpcbind.socket", as rpc.statd
>     is useless if it can't register with rpcbind.
> 
> Then in https://bugzilla.redhat.com/show_bug.cgi?id=2100395, Ben noted
> that due to the way the dependencies are ordered, when 'systemctl stop
> rpcbind.socket' is run, systemd first sends SIGTERM to rpcbind, then
> SIGTERM to rpc.statd.  On SIGTERM, rpcbind tears down /var/run/rpcbind.sock.
> However, rpc-statd on SIGTERM attempts to unregister from rpcbind.  This
> results in a long delay:
> 
> [root@rawhide ~]# time systemctl restart rpcbind.socket
> 
> real	1m0.147s
> user	0m0.004s
> sys	0m0.003s
> 
> 8a835ceb ("rpc-statd.service: Stop rpcbind and rpc.stat in an exit race")
> fixed this by changing the dependency in rpc-statd.service to use
> "After=rpcbind.service", bending rule #1 from above.
> 
> Yongcheng recently noted that when runnnig the following test:
> 
> [root@rawhide ~]# for i in `seq 10`; do systemctl reset-failed; \
> 	systemctl stop rpcbind rpcbind.socket ; systemctl restart nfs-server ; \
> 	systemctl status rpc-statd; done
> 
> rpc-statd.service would often fail to start:
> 
> × rpc-statd.service - NFS status monitor for NFSv2/3 locking.
>       Loaded: loaded (/usr/lib/systemd/system/rpc-statd.service; enabled-runtime; preset: disabled)
>      Drop-In: /usr/lib/systemd/system/service.d
>               └─10-timeout-abort.conf
>       Active: failed (Result: exit-code) since Fri 2025-09-05 18:01:15 EDT; 229ms ago
>     Duration: 228ms
>   Invocation: bafb2bb00761439ebc348000704e8fbb
>         Docs: man:rpc.statd(8)
>      Process: 29937 ExecStart=/usr/sbin/rpc.statd (code=exited, status=1/FAILURE)
>     Mem peak: 1.5M
>          CPU: 7ms
> 
> Sep 05 18:01:15 rawhide.smayhew.test rpc.statd[29938]: Version 2.8.2 starting
> Sep 05 18:01:15 rawhide.smayhew.test rpc.statd[29938]: Flags: TI-RPC
> Sep 05 18:01:15 rawhide.smayhew.test rpc.statd[29938]: Failed to register (statd, 1, udp): svc_reg() err: RPC: Remote system error - Connection refused
> Sep 05 18:01:15 rawhide.smayhew.test rpc.statd[29938]: Failed to register (statd, 1, tcp): svc_reg() err: RPC: Success
> Sep 05 18:01:15 rawhide.smayhew.test rpc.statd[29938]: Failed to register (statd, 1, udp6): svc_reg() err: RPC: Success
> Sep 05 18:01:15 rawhide.smayhew.test rpc.statd[29938]: Failed to register (statd, 1, tcp6): svc_reg() err: RPC: Success
> Sep 05 18:01:15 rawhide.smayhew.test rpc.statd[29938]: failed to create RPC listeners, exiting
> Sep 05 18:01:15 rawhide.smayhew.test systemd[1]: rpc-statd.service: Control process exited, code=exited, status=1/FAILURE
> Sep 05 18:01:15 rawhide.smayhew.test systemd[1]: rpc-statd.service: Failed with result 'exit-code'.
> Sep 05 18:01:15 rawhide.smayhew.test systemd[1]: Failed to start rpc-statd.service - NFS status monitor for NFSv2/3 locking..
> 
> Define the dependency on both rpcbind.service and rpcbind.socket.  As
> Neil explains:
> 
> "After" declarations only have effect if the units are in the same
> transaction.  If the Unit is not being started or stopped, the After
> declaration has no effect.
> 
> So on startup, this will ensure rpcbind.socket is started before
> rpc-statd.service.  On shutdown in a transaction that stops both
> rpc-statd.service and rpcbind.service, rpcbind.service won't be
> stopped until after rpc-statd.service is stopped.
> 
> Signed-off-by: Scott Mayhew <smayhew@redhat.com>
Committed... (tag: nfs-utils-2-8-4-rc4)

steved.
> ---
>   systemd/rpc-statd.service | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/systemd/rpc-statd.service b/systemd/rpc-statd.service
> index 660ed861..96fd500d 100644
> --- a/systemd/rpc-statd.service
> +++ b/systemd/rpc-statd.service
> @@ -6,7 +6,7 @@ Conflicts=umount.target
>   Requires=nss-lookup.target rpcbind.socket
>   Wants=network-online.target
>   Wants=rpc-statd-notify.service
> -After=network-online.target nss-lookup.target rpcbind.service
> +After=network-online.target nss-lookup.target rpcbind.service rpcbind.socket
>   
>   PartOf=nfs-utils.service
>   IgnoreOnIsolate=yes


