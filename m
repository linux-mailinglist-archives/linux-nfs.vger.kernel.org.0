Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7635F109025
	for <lists+linux-nfs@lfdr.de>; Mon, 25 Nov 2019 15:37:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728116AbfKYOh0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 25 Nov 2019 09:37:26 -0500
Received: from mail-wm1-f44.google.com ([209.85.128.44]:39372 "EHLO
        mail-wm1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728071AbfKYOh0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 25 Nov 2019 09:37:26 -0500
Received: by mail-wm1-f44.google.com with SMTP id t26so16232583wmi.4
        for <linux-nfs@vger.kernel.org>; Mon, 25 Nov 2019 06:37:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=o8j8qmswY65MvvAHPc8iiI0eR5C+f1hPXLCbRtnAKog=;
        b=r/k5FoBx89fp581k4MmXnv6qYKXOa23RluUoYxQUoUDAsVXsHCTEbbQ0m2dY/9Pi4q
         2cUM4UrGgGqs/58SFB2jFP8CbF2lBti30altu32Pa3WqlgEMEoPa8TVjSQZr1BRX3Au+
         MtwBRjxEUJQNJaAtml/YcfSnT8qg+5SQBMG/vJ41MRV0AdEOukZICBN1jLrrgetjHzD8
         +M2uQKvBKu/ffcDuJ5F6lN3W7ZYxaNyXtIXo8nxixrvHsLta70gMFW5QQmF8VSuYodTE
         4zhkletXTsrsD3PuCws5odJL2Nj+KQfxHa5k5hze6A0gdUYg24c6MXUHIil2JBYmJPmP
         fMdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=o8j8qmswY65MvvAHPc8iiI0eR5C+f1hPXLCbRtnAKog=;
        b=TqcJrY74PXBeTno6wCMEBwHVqFAAE94iUPdtLauVFXL2xye/XSuSs1F/09d3hElDoV
         jB1ccxOuflMzg4bmha1CCfQ0RFQRubQL31t4a7MEJNgooeo60Kvnhh+NcZwhQqAQR6PO
         NXOzA7t7L8aNe0IuJuwH6HUdAr+dhnYtbtEkQwtVYSoL63GPHHi2NcDw+OCaEg1G7hFG
         QXXgDiuaXrCX3MuoQjaaBafrQDyEYuo6BbGtSz+I6eILnMVXELNeuSZ3unPdp71QGdlz
         eY6+Mcvems5e91r0RmTT+F9E7dijKsdGBWFsYsW6yKucA8802k1obfEYjHUHCKpdG/L1
         ja2g==
X-Gm-Message-State: APjAAAUgRJfDkDAZxL1MWvIBwTKV+YJqc5Y/zyejnr3U3CjeNbUbecJJ
        89XPNGJz2bUkG02xePbYHNQimFS0
X-Google-Smtp-Source: APXvYqxq/JGrYSRMfCLcsGjd54y5MEOb3EkBozqtwGteSqPpY9X5epkYWQp/MFPmPv1TvoKuh74TMg==
X-Received: by 2002:a7b:cb86:: with SMTP id m6mr30753595wmi.124.1574692643577;
        Mon, 25 Nov 2019 06:37:23 -0800 (PST)
Received: from beria.zarb.org ([2a01:e34:ec77:3c10:aad3:63ff:1f26:ee9a])
        by smtp.gmail.com with ESMTPSA id m3sm10610623wrw.20.2019.11.25.06.37.22
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Nov 2019 06:37:22 -0800 (PST)
Subject: Re: [patch] fix compilation with -Werror=format on i586
To:     linux-nfs@vger.kernel.org
References: <d21f152d-1d9d-01c2-900e-39c67eb2cef3@gmail.com>
 <4b47a9cd-5bec-518c-2282-bb020f92708e@RedHat.com>
From:   Guillaume Rousse <guillomovitch@gmail.com>
Message-ID: <abab6377-7401-4f9c-40d5-d05627e56ebe@gmail.com>
Date:   Mon, 25 Nov 2019 15:37:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <4b47a9cd-5bec-518c-2282-bb020f92708e@RedHat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



Le 22/11/2019 à 16:54, Steve Dickson a écrit :
> Hello,
> 
> On 11/21/19 5:59 PM, Guillaume Rousse wrote:
> 
> A couple things... In the future please in line the patch
> instead of attaching it and please use the appropriate
> Signed-off-by: line
> 
> Half of your patch already existed due to commit a20dbec9
> 
> The rest of the patch I did Commit (tag: nfs-utils-2-4-3-rc2)
Sorry for those beginner errors, I'll try to do better next time.

Regards.
-- 
Guillaume
