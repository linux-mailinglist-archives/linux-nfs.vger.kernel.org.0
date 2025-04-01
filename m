Return-Path: <linux-nfs+bounces-10971-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52510A77A52
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Apr 2025 14:05:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59B4F1661B6
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Apr 2025 12:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADCC21EFFB2;
	Tue,  1 Apr 2025 12:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=puzzle-itc.de header.i=@puzzle-itc.de header.b="hg3P3GDu"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3834690
	for <linux-nfs@vger.kernel.org>; Tue,  1 Apr 2025 12:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743509133; cv=none; b=EfXqC268ACDk7ZbcswedOD3psdKw+eRKj9TrQeOFtPFhPAXfSqUB7qndRL3vbqHgA4DctnCkCNRSvG//Rp+Wd6jzPYY1VwKnc0UzHgJ/uxGcsIf/JRBHOw+NePfm0v3je7jyHvXi5jLq/JDPKamXpiF5YPtE2ofNT6qX67n7qMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743509133; c=relaxed/simple;
	bh=foR2673ynlw5mO5LAB6pNh0kpT1Cr51I5MCnMgd5cb4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=kcVQXg7xsGVQM4eDESY7NCDb55u/SURahdkxNCcnzHCD2CleMPoqh+AihbROzKFss0q5yjd3vlvzPdUw3Wrj9X9PdxGLKHdyj08+SDbHZhb9BhKkJNiDypOIEXWcuP9dxLFyVbmgpUl+l8xup7RlZamvNQU7d3BvruJsh/OwMGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=puzzle-itc.de; spf=pass smtp.mailfrom=puzzle-itc.de; dkim=pass (1024-bit key) header.d=puzzle-itc.de header.i=@puzzle-itc.de header.b=hg3P3GDu; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=puzzle-itc.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=puzzle-itc.de
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ac3fcf5ab0dso881694866b.3
        for <linux-nfs@vger.kernel.org>; Tue, 01 Apr 2025 05:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=puzzle-itc.de; s=google; t=1743509128; x=1744113928; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:organization
         :autocrypt:from:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=foR2673ynlw5mO5LAB6pNh0kpT1Cr51I5MCnMgd5cb4=;
        b=hg3P3GDuU6ZHFa7yXyA1Jfn1hwV1zc6SVRjlKYkSNAUWMQjmB30OV+OmRSLf/+bNQ1
         ICyey9cdwED8TrOdqMZ3LeYePQWTSTNjw2A3IBMSlBxfh7jIjrwGLNDXBWNn7hqCl1wi
         E7dnO6DinQ0NWjeleqx3EPbKGOEnBzA21Nfxg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743509128; x=1744113928;
        h=content-transfer-encoding:content-language:in-reply-to:organization
         :autocrypt:from:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=foR2673ynlw5mO5LAB6pNh0kpT1Cr51I5MCnMgd5cb4=;
        b=YLKVkr522TuYBfSSmw4B3vNFeap/6RxkNZE3ly+haVSymCY/srHjMP4SFVAnOoMh0U
         voH+2Sa1jybHK6LzazkE3Qd4Y0hv7JYoqOn2zsQ20EfS90SlpNNUbHZoHko8MxmfEfg5
         JJFUfrkf8+frtBXdroTdGi/TH5SzloyIBepFotjPH/chnFg2FOe5ryR3GADuFAlS3cNU
         NG402o9V+bVhe1bFbUbaEHWyY/W7K3ZIbhls/eBLPsWpnYHrRx2jRjkTqW4MylbWu7Tq
         kZWCHRsYmZATrxFQpiANpys7lnfYtdXqgCQ5leHExpWv0kNVA4LM5SsqonrMuLSm4pxH
         V1LQ==
X-Forwarded-Encrypted: i=1; AJvYcCX73K8rNedON4A6zCg5XXE78Uuol8SzwkgWuIm+NK4wT0hYjK9RfW9etihhFDLVXo8h6mop4ubvr3k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbwFMbMiTjK2nBfh+qTDvHjhB5Z5iSFQt3NarMMoqDAtjmr2K9
	3+CO71R+z4qqM0F4aXP6YMiXnWxgUV4TFkoQQkkoW5/I3wo5ala7VwPvSciHFNi/IrhCCamAvkg
	aL5lBDEcik4ojJ+q/ypgrlcfHkO0qDXaWhl6/80QHWqyruvnF/dC9SOug/wN+iJG3
X-Gm-Gg: ASbGncuSTsvGiai2/+RnLnU8eChuoHBKrEevZITZhgGUZwjdDbmhfRUL8va2TuzhlGl
	7baVEx15PGxF8t2Y3fXSGHP9b6/ApvKZ71CyKBIPBjA5HbIHKRCNjkn6bLsUhf1+tkxjYxoFukD
	mzY8Xh9vAR3AKAMu91kqXYxS2YaNea3Zwh00QFRFGpMB+dtsDof5mzA68E5HZbagXyvNym3ydu5
	FID7akjlwrTnwwYwovIzpJYiczRTeqsdvfsmJ24WMYQGmfNkJEwIeoQuxyaILe/T9cKDOv0Jke3
	AVmRcgKo7XBl0BlskBxngh6Bmdb6sGf7WkkiBZMS9So8GlfhKOqdFuKGXZXqrMJugf0GiCf95Sl
	48FemMEUinwA+YUBovA==
X-Google-Smtp-Source: AGHT+IFkMJ9P3RGZlrJt3oXnwvzY0MHGvlljxcEJKagwAwVBzDE/Byi/j8ybfot63/DLOtbrF3NGGQ==
X-Received: by 2002:a17:907:9482:b0:ac3:1b00:e17d with SMTP id a640c23a62f3a-ac738bae5f2mr1268480866b.54.1743509127906;
        Tue, 01 Apr 2025 05:05:27 -0700 (PDT)
Received: from ?IPV6:2a02:8070:8e81:94c0:9861:b823:e598:ab0? ([2a02:8070:8e81:94c0:9861:b823:e598:ab0])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac71922bb65sm758544066b.34.2025.04.01.05.05.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Apr 2025 05:05:27 -0700 (PDT)
Message-ID: <2c1a60a7-051f-4952-84fe-c3a4b6b0327e@puzzle-itc.de>
Date: Tue, 1 Apr 2025 14:05:26 +0200
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: non-stop kworker NFS/RPC write traffic even after unmount
To: Rik Theys <Rik.Theys@esat.kuleuven.be>,
 Linux Nfs <linux-nfs@vger.kernel.org>
References: <79767ded-466f-44a5-b15a-fde5af1b03c7@esat.kuleuven.be>
From: Daniel Kobras <kobras@puzzle-itc.de>
Autocrypt: addr=kobras@puzzle-itc.de; keydata=
 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
 p63U1j1sBdH4lyrWIu/HHjYDEL8+XTvqMCBEHuI=
Organization: Puzzle ITC Deutschland GmbH
In-Reply-To: <79767ded-466f-44a5-b15a-fde5af1b03c7@esat.kuleuven.be>
Content-Language: en-US
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable

Hi Rik!

Am 15.12.24 um 13:38 schrieb Rik Theys:
> Suddenly, a number of clients start to send an abnormal amount of NFS=20
> traffic to the server that saturates their link and never seems to stop.=
=20
> Running iotop on the clients shows kworker-{rpciod,nfsiod,xprtiod}=20
> processes generating the write traffic. On the server side, the system=20
> seems to process the traffic as the disks are processing the write=20
> requests.
>=20
> This behavior continues even after stopping all user processes on the=20
> clients and unmounting the NFS mount on the client. Is this normal? I=20
> was under the impression that once the NFS mount is unmounted no further=
=20
> traffic to the server should be visible?

I'm currently looking at an issue that resembles your description above=20
(excess traffic to the server for data that was already written and=20
committed), and part of the packet capture also looks roughly similar to=20
what you've sent in a followup. Before I dig any deeper: Did you manage=20
to pinpoint or resolve the problem in the meantime?

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


