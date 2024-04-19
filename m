Return-Path: <linux-nfs+bounces-2893-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B3038AAE38
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Apr 2024 14:13:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 552242828A3
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Apr 2024 12:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2C8684E1A;
	Fri, 19 Apr 2024 12:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QTajDd6d"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F17284A5A
	for <linux-nfs@vger.kernel.org>; Fri, 19 Apr 2024 12:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713528802; cv=none; b=N9BexzHnvs9SR5+aHoPYZ3a1EgnrdKhxWrLBhE5MY8Ef2Ix87l0exNWfQV0U2GceUI5FT/bReeRQIbDZ8QIU8jP4K4N0B5TJwnFMaxq0ZnTYKMi45frP/zcsBub+8blHgfcXugN/lOqwGA+Uvfyk295DzeLOSmSUp5Gm0T6a6NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713528802; c=relaxed/simple;
	bh=ZkfHhQtbOBCN949qaHnxZV06TGy1iTo2Uy1a24KYWEg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=eEhol2ZK6QsWwJkzCPqjUaLRd4CsU0kaDPMLSAk7C5hq3zTkeJo6uT8UmBuQ5c+je7QG2fJ2u1yfHbHbFviB98ZzJOApIsY+1t3jnsanaSZaMztb1naKznX7wxHtzA6lNRi/BEwHj+G7PmNHf5AZqf1VGEIcsSzoMBS3UWrd1ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QTajDd6d; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713528800;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=V8U/IuTUZBJuKu9EBQz1vuf2NBIsZQ08vL2DJgYtL2I=;
	b=QTajDd6dVW7NYNlCWGI9kNT1BfanDfWqtILURALtwjCxyHeMmeLy+pd6Fi5V8gUSzfkSxD
	JKcpiIqTiKBSREUqmMaWA7HkjzSa3Y3tWhvinmiiiGNmYfr9jrYZrLgbGhZpeWEqRwatRv
	naIQIS5pkjQS7rmoRbn4Ci6dWgutvFc=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-206-lJnflK6VPAqaL2EkNuREGw-1; Fri, 19 Apr 2024 08:13:19 -0400
X-MC-Unique: lJnflK6VPAqaL2EkNuREGw-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-78f008cb479so8370185a.3
        for <linux-nfs@vger.kernel.org>; Fri, 19 Apr 2024 05:13:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713528796; x=1714133596;
        h=content-transfer-encoding:content-language:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=V8U/IuTUZBJuKu9EBQz1vuf2NBIsZQ08vL2DJgYtL2I=;
        b=Ivd6Dv3kwYT8Q3kVnd6a7WbPrTeiIgWjSPj71NsMWAncpJpZguX29QTVFBqP4z9AHH
         OhlWTXIw747Me7k88D+qjvS9cDounCF3ac9iaXZeBhGe3zAAdZ5LBx3H7GRaiwXTsjeH
         L+0OWGYqapvb7o9TqbkMTKD7cMdj6uKCdsFg7njmjLxsD09n+mKSbgVWwbbjXvMXQXhN
         SYVQnCBParOYHLpD+WoOHXwP1NmM0cxT/WLamItQMWdmB4TCoDQmCEZkOraWsjvasiFC
         WPgelnWixx1P9HOQwSvN71JxtPfNaFBc1p4UcDXrirUwtpTa9B1gC+O8dUPNabqL/4dV
         S/EA==
X-Forwarded-Encrypted: i=1; AJvYcCXYpUjsq6Ify4aCus4mKlHWcj+c1L4DkahILyZTbeufJUputuOH/r0/haphhcpBL05IUL3jNFKftPEw7dpzB52aXU54QEIPEao3
X-Gm-Message-State: AOJu0YzlU4raq0m/Ye7W1p9nRgM256JP1b+hiLtwkd7FdGHTF+nH7sQE
	qrDA7P7jikuWy1SjW6AxKg7tucJNqBnq7HbMK4JVyoWRyDdQKCzKAJH91DmZesej/TNye0rYU5E
	h3dffrrAgDDhn5/30D+kVGdE7MoodPPVPNQ05tWBJX8LpXqxpN2LnLK3j/w==
X-Received: by 2002:a05:620a:7183:b0:78f:199c:ece8 with SMTP id vm3-20020a05620a718300b0078f199cece8mr1499177qkn.5.1713528796403;
        Fri, 19 Apr 2024 05:13:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGTvUkNL4QZ4Il5TaqT49iZIp29XKaHMpdENY6eMpgJWQ+8+3Y6Xo/1qNlzcqUc/3VR9X2c2w==
X-Received: by 2002:a05:620a:7183:b0:78f:199c:ece8 with SMTP id vm3-20020a05620a718300b0078f199cece8mr1499161qkn.5.1713528796052;
        Fri, 19 Apr 2024 05:13:16 -0700 (PDT)
Received: from [172.31.1.12] ([70.109.130.167])
        by smtp.gmail.com with ESMTPSA id y8-20020a05620a44c800b0078d54a6bb76sm1524346qkp.117.2024.04.19.05.13.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Apr 2024 05:13:15 -0700 (PDT)
Message-ID: <4b0adcfb-7cd9-4ebf-bc17-cee2b66e51a8@redhat.com>
Date: Fri, 19 Apr 2024 08:13:14 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Steve Dickson <steved@redhat.com>
Subject: Spring 2024 NFS bake-a-thon (reminder)
To: nfsv4@ietf.org, linux-nfs@vger.kernel.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

Just wanted send a quick reminder, that the Spring
bake-a-thon is starting next Monday.

The network is the same, tailscale VPN.

The registration section is on nfsv4bat.org [1]
It basically says the following:

To gain access to the network please register
at the Spring Registration Doc [2].

Here are the steps to access the network.

	* Download the tailscale bits
		* https://tailscale.com/download
	* Register with the BAT server
	    tailscale up --login-server https://headscale.nfsv4.dev

	* The registration will give an authentication link
	* Use that link to
		* Create an account on the BAT server
		* Authenticate your machine[s]
		
Once the tailscale interface is up, DNS will be able to find other machines
	* The command 'tailscale status' will show those machines
	
Once the network is up and running... and it is very easy to
get connected.

Server registration is at [3]

Client test results are at [4]

Our informal Talks @2 (EST) are at [5]

The network is up and running!

steved.

[1]  http://nfsv4bat.org/Events/2024/Apr/BAT/index.html

[2] 
https://docs.google.com/spreadsheets/d/197w3Estxhwg9emT0mjR2bB6MajMI2HPe6ro7CYI3xAw/edit#gid=0

[3] 
https://docs.google.com/spreadsheets/d/1-wmA_t4fp7X5WvshYPnB-0vHeMpoQMohim2Kb7Gx9z0/edit#gid=0

[4] 
https://docs.google.com/spreadsheets/d/1-wmA_t4fp7X5WvshYPnB-0vHeMpoQMohim2Kb7Gx9z0/edit#gid=1710898184

[5] 
https://docs.google.com/spreadsheets/d/1-wmA_t4fp7X5WvshYPnB-0vHeMpoQMohim2Kb7Gx9z0/edit#gid=1920779269


