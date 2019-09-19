Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BBDEFB7412
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Sep 2019 09:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388584AbfISH3o (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 19 Sep 2019 03:29:44 -0400
Received: from mail-wm1-f42.google.com ([209.85.128.42]:52771 "EHLO
        mail-wm1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388569AbfISH3o (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 19 Sep 2019 03:29:44 -0400
Received: by mail-wm1-f42.google.com with SMTP id x2so3065443wmj.2
        for <linux-nfs@vger.kernel.org>; Thu, 19 Sep 2019 00:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=o9h0H3zMuTjeSSkNTvkjhWYFv3e2Dj1eaXIiaQI12qc=;
        b=R7M7lQoKlomJ1cbK1Tt61bfn37aTnkBvzKa3Bj+keGCqhdDywiLlaVzpFgapnLPz4D
         WcDOPX5embPPYQAmXisHrw0hGz4vnKJMwcqEKzOcuS9TDlzYGwaYww0CIVwDeNjnttXg
         lIXMdVhnxKGTdkIjVjFHSzjI5QxBfHHx1KLT+A9Q3vC8UpyQPoil21FAVSChtaulIDLt
         PZUYXl47svSC0wDqKQGs1mGBya1MHdvdgzqYXANrEL6KdHUK/t6nCly8RJQEGTpR8Dy1
         W443C13DXJWt8s1enF8OGcjQJWNFSA4dMbO8Xf0pjfwUY+4a1IQLObG4t2l4REOF+8rp
         dyiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=o9h0H3zMuTjeSSkNTvkjhWYFv3e2Dj1eaXIiaQI12qc=;
        b=VE5fwsko+R/hblklqg3R1ZS18HV6VdRnMoVyvU6H5d6CuCpt3SvCvJS83ZRrHCJhAs
         73x+jGYbihbQIhw2X5y6cn7bJwgtxgPMcr/M81DNIv42YNCf4V+MhbR7F1GHfHjAylmf
         gCk3bTwGVrlVxZhBLstme7+TSEQgREBGWuDH6MLi5VfxAJuc7XIlrV0IkI/Kcd8CSKLc
         SW132dHxDX1o9xWZMYcHW3p0Ie+4Aw9gtiG/jj09Tg4NhXw4BYh9wBm6vdYOTkSMgpzA
         XQfQ0fRVtrnxhUg3NS52Gw6CXaKD6tuMClVBfNadnIGaunsxU25SKTqPtuP3Q6z3dzrw
         af0A==
X-Gm-Message-State: APjAAAVK/v2GDEoHE+7oK3LK50E5pvJGxXiR5RwbNX/feWHU09iQZTdO
        xR3+t6qo0Z/DC2bNX0raDhR71irt
X-Google-Smtp-Source: APXvYqxsNKIWB7EoW4csxCf7cn+S82aCxY6JceiB7llD0Vwo3cWKuC/kiCS4hc/Ijpv3wZtKnpD4OQ==
X-Received: by 2002:a05:600c:2290:: with SMTP id 16mr1406058wmf.161.1568878181575;
        Thu, 19 Sep 2019 00:29:41 -0700 (PDT)
Received: from [10.161.254.11] (srv1-dide.ioa.sch.gr. [81.186.20.0])
        by smtp.googlemail.com with ESMTPSA id y186sm9295426wmb.41.2019.09.19.00.29.40
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Sep 2019 00:29:41 -0700 (PDT)
To:     linux-nfs@vger.kernel.org
From:   Alkis Georgopoulos <alkisg@gmail.com>
Subject: rsize,wsize=1M causes severe lags in 10/100 Mbps, what sets those
 defaults?
Message-ID: <80353d78-e3d9-0ee2-64a4-cd2f22272fbe@gmail.com>
Date:   Thu, 19 Sep 2019 10:29:40 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi, in any recent distribution that I tried, the default NFS wsize/rsize 
was 1 MB.

On 10/100 Mbps networks, this causes severe lags, timeouts, and dmesg 
fills with messages like:

 > [  316.404250] nfs: server 192.168.1.112 not responding, still trying
 > [  316.759512] nfs: server 192.168.1.112 OK

Forcing wsize/rsize to 32K makes all the problems disappear and NFS 
access more snappy, without sacrificing any speed at least up to gigabit 
networks that I tested with.

I would like to request that the defaults be changed to 32K.
But I didn't find out where these defaults come from, where to file the 
issue and my test case / benchmarks to support it.

I've initially reported it at the klibc nfsmount program that I was 
using, but this is just using the NFS defaults, which are the ones that 
should be amended. So initial test case / benchmarks there:
https://lists.zytor.com/archives/klibc/2019-September/004234.html

Please Cc me as I'm not in the list.

Thank you,
Alkis Georgopoulos
