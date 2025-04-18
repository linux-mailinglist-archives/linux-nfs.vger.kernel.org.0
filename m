Return-Path: <linux-nfs+bounces-11166-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AC55A937F4
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Apr 2025 15:31:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCCCA3A3D17
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Apr 2025 13:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65FE220767E;
	Fri, 18 Apr 2025 13:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=puzzle-itc.de header.i=@puzzle-itc.de header.b="UpuzPzoQ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0327E555
	for <linux-nfs@vger.kernel.org>; Fri, 18 Apr 2025 13:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744983102; cv=none; b=YHgUvihnAuffdT0G0odL56cs0ztlLKO7qKSQQclBSGxORQqQ9PTqoTjP9VhurdWHSzZUzRkePlXmgagjiAMZHA6E3S1UuE5Vzb+9U35kj0OQiB95PakciQ7XLaMmvfcSl+agY+4QlmILMHMN5zKio4WbiZb9aQ7iXcPzwRDuxMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744983102; c=relaxed/simple;
	bh=AP5PwDSYFb7+hIB9D33IqfUOg9Ca2km1piTCIhfLTPo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=rshHPYxksZ1BD2shL8/wvgVGZMv2RHP2TixnFSrdGMN+FrvNH27rNfDOiTSucu2atclvVwqvvkSP1ZvMiCQZSjt7BTxu8w16gmckTAzpOqi+Mck9P7+o9d7VBA9OnQIUrIkmRW9qhibSlS3L1sE8b1ZyK6TDiVHBKvDPL6NH+hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=puzzle-itc.de; spf=pass smtp.mailfrom=puzzle-itc.de; dkim=pass (1024-bit key) header.d=puzzle-itc.de header.i=@puzzle-itc.de header.b=UpuzPzoQ; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=puzzle-itc.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=puzzle-itc.de
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-abbb12bea54so286679566b.0
        for <linux-nfs@vger.kernel.org>; Fri, 18 Apr 2025 06:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=puzzle-itc.de; s=google; t=1744983097; x=1745587897; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:organization
         :autocrypt:from:cc:references:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=AP5PwDSYFb7+hIB9D33IqfUOg9Ca2km1piTCIhfLTPo=;
        b=UpuzPzoQyfc3Vm+ColmiGcLdUuIa7MDuP4169mZ4Ny9JuJxZMrScwX138aLvZZ6Gdv
         SK9TCjFB9rHa0R/vFP1fGdxmPd+EpXsgS9gng7YJpHGwccrjdpg9YhrGciwKwi1vAz3N
         goEIn/tpyHeckKvEtokr7nsoLQV+OEdRk+3ng=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744983097; x=1745587897;
        h=content-transfer-encoding:content-language:in-reply-to:organization
         :autocrypt:from:cc:references:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AP5PwDSYFb7+hIB9D33IqfUOg9Ca2km1piTCIhfLTPo=;
        b=HFAFvRGxkueWIt+G8SLIuZNjHzs9cbhbo1cZkGWATMgrl6VD0+hKC9loxdcNEosFmG
         2V+H3b4tWNbeYOhdsGoDBF9calBL/FmPlLnfYP6775SUOLqaf1fomvI0q0LwLBdjKrIp
         qvUrsEYf24Zin3uf37Pzk/9bMAtl4deRE3WtzCx1b/QlZ1/HSaup2pvFmgKv7nlXGgYR
         93hEBeZjVVw/Lb7/OoG9fnOyWAK32TaHlNYNI1GJMdarGND8Hi7ry39jsjkzr42Iat4e
         BDyc0qFaugC5B2Fr+TVuJTuN6fRPDCkft/cUEJI42MpvEpXCIwJqcgn7JLC4pjWxOcAa
         bu2Q==
X-Gm-Message-State: AOJu0YysY1xda0Yz1K0O7o+yotI+fB/RQmRvV2jn3h/nL/RUpek9EtH/
	Z9RszXYE4sVehnCUpi/xImlJ0KaXzji0ZzOQqzTAJzb/5Cp437SIxLfqgMmAgsK7ktRdQI6B2lH
	ApJUUUDd2KiRJDH/Ht1YR3sMQ+oQ1KkzzgVETHHS9034+9zN06gQ=
X-Gm-Gg: ASbGncviFHyOHYcAvFpMzbj4ekm75TpxS+2wgyjwOwdtWwg+06Ui0WtnL1dDOgr6BZz
	yvZVfsU3FqQZCZjhx7xkuHElgf+O3B07iCMSJE1YNQlUpyRz6jhPNEihfF3iezR2V29LrO+Hxqp
	Cv1o1NNiW9xAusrkWUBFvH8uCWHC0mHHeZ7q0fqUpvFJzzuG4dIFb2YJohY5lucsa4bkiGO+YK/
	XAJAiv5Ngsw9nz1qlb4PFKQ3czHKZtlnTUW7BJZGsgV4nFPAU37Br5s5rJUub+j52mkcFGqDkTY
	YNZZ6A4Cb3Roy+cMcvlQNyUCdhr1OLWaFgfGZHA8xwo6Zcg9+lCLHTZB5j6W4gVNGBccsJbwEpG
	lttTJV21DLLnVMbOd
X-Google-Smtp-Source: AGHT+IGtpZeE4SBVX24qs1cqLFswS4yY8neoFg4mdIVeZ2hR9qd2/dL4N9ocO2EvymZkGsksslQSWg==
X-Received: by 2002:a17:907:7d9f:b0:aca:cac8:1cf9 with SMTP id a640c23a62f3a-acb74b8ed72mr224395266b.33.1744983096564;
        Fri, 18 Apr 2025 06:31:36 -0700 (PDT)
Received: from ?IPV6:2a02:8070:8e81:94c0:9181:6ee9:7d7c:b44b? ([2a02:8070:8e81:94c0:9181:6ee9:7d7c:b44b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acb6ef47ea5sm120803666b.146.2025.04.18.06.31.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Apr 2025 06:31:36 -0700 (PDT)
Message-ID: <62cb66ff-b718-4369-a7f1-fd3bb01a7b16@puzzle-itc.de>
Date: Fri, 18 Apr 2025 15:31:35 +0200
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: non-stop kworker NFS/RPC write traffic even after unmount
To: Rik Theys <Rik.Theys@esat.kuleuven.be>
References: <79767ded-466f-44a5-b15a-fde5af1b03c7@esat.kuleuven.be>
 <2c1a60a7-051f-4952-84fe-c3a4b6b0327e@puzzle-itc.de>
 <42c84eb6-ede0-4e68-ae70-334365e2ae7f@esat.kuleuven.be>
Cc: Linux Nfs <linux-nfs@vger.kernel.org>
From: Daniel Kobras <kobras@puzzle-itc.de>
Autocrypt: addr=kobras@puzzle-itc.de; keydata=
 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
 p63U1j1sBdH4lyrWIu/HHjYDEL8+XTvqMCBEHuI=
Organization: Puzzle ITC Deutschland GmbH
In-Reply-To: <42c84eb6-ede0-4e68-ae70-334365e2ae7f@esat.kuleuven.be>
Content-Language: en-US
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable

Hi Rik!

Am 01.04.25 um 14:15 schrieb Rik Theys:
> On 4/1/25 2:05 PM, Daniel Kobras wrote:
>> Am 15.12.24 um 13:38 schrieb Rik Theys:
>>> Suddenly, a number of clients start to send an abnormal amount of NFS=
=20
>>> traffic to the server that saturates their link and never seems to=20
>>> stop. Running iotop on the clients shows kworker-=20
>>> {rpciod,nfsiod,xprtiod} processes generating the write traffic. On=20
>>> the server side, the system seems to process the traffic as the disks=
=20
>>> are processing the write requests.
>>>
>>> This behavior continues even after stopping all user processes on the=
=20
>>> clients and unmounting the NFS mount on the client. Is this normal? I=
=20
>>> was under the impression that once the NFS mount is unmounted no=20
>>> further traffic to the server should be visible?
>>
>> I'm currently looking at an issue that resembles your description=20
>> above (excess traffic to the server for data that was already written=20
>> and committed), and part of the packet capture also looks roughly=20
>> similar to what you've sent in a followup. Before I dig any deeper:=20
>> Did you manage to pinpoint or resolve the problem in the meantime?
>=20
> Our server is currently running the 6.12 LTS kernel and we haven't had=20
> this specific issue any more. But we were never able to reproduce it, so=
=20
> unfortunately I can't say for sure if it's fixed, or what fixed it :-/.

Thanks for the update! Indeed, in the meantime the affected environment=20
here stopped showing the reported behavior as well after a few days, and=20
I don't have a clear indication what might have been the fix, either.

When the issue still occurred, it could (once) be provoked by dd'ing 4GB=20
of /dev/zero to a test file on an NFSv4.2 mount. The network trace shows=20
that the file is completely written at wire speed. But after a five=20
second pause, the client then starts sending the same file again in=20
smaller chunks of a few hundred MB at five second intervals. So it=20
appears that the file's pages are background-flushed to storage again,=20
even though they've already been written out. On the NFS layer, none of=20
the passes look conspicuous to me: WRITE and COMMIT operations all get=20
NFS4_OK'ed by the server.

> Which kernel version(s) are your server and clients running?

The systems in the affected environment run Debian-packaged kernels. The=20
servers are on Debian's 6.1.0-32 which corresponds to upstream's=20
6.1.129. The issues was seen on clients running the same kernel version,=20
but also on older systems running Debian's 5.10.0-33, corresponding to=20
5.10.226 upstream. I've skimmed the list of patches that went into=20
either of these kernel versions, but nothing stood out as clearly related.

Kind regards,

Daniel
--=20
Daniel Kobras
Principal Architect
Puzzle ITC Deutschland
+49 7071 14316 0
www.puzzle-itc.de

--=20
Puzzle ITC Deutschland GmbH
Sitz der Gesellschaft: Eisenbahnstra=C3=9Fe 1, 72072=20
T=C3=BCbingen

Eingetragen am Amtsgericht Stuttgart HRB 765802
Gesch=C3=A4ftsf=C3=BChrer:=20
Lukas Kallies, Daniel Kobras, Mark Pr=C3=B6hl


