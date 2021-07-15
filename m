Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B28B93C9F45
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Jul 2021 15:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237395AbhGONTR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 15 Jul 2021 09:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbhGONTR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 15 Jul 2021 09:19:17 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1C10C06175F
        for <linux-nfs@vger.kernel.org>; Thu, 15 Jul 2021 06:16:23 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id u5-20020a7bc0450000b02901480e40338bso5221333wmc.1
        for <linux-nfs@vger.kernel.org>; Thu, 15 Jul 2021 06:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vastdata.com; s=google;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=n/QVv5EHguKV3HiFl0I6Sgi4xVblvsbnJa+WY7X1GyA=;
        b=QRGjZ1oJaG3xhSrt+55VJYW6BS/adMtmn9fmyCfHXfSS7X7KJV4cQLiKrsFHIiudeL
         /qJ/oakT0lZxoh6brIV//uabEK0Rrz5kBJ2E/Sozg2cpXZ9FwqeQbID0f43QQl0sAYGa
         eKA52730OnTzgEXPTcjDM0SOu518skGur4DYS/tkYPFByXlXHzqIuCiQozdOXD6ocUbS
         atJFTWCogMblnFUl8m5ARUhsYwuQxzYfnUrrJ6LaZsHiUD5LxEMhUsiw9Q92u8zw9VNj
         fsADp5nVxSeESwCYrmyMz1cxIZKvTZsNpeVg+MfCm2nsh7+Oy+SeH77V4k4WZLFMWgbo
         ISMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=n/QVv5EHguKV3HiFl0I6Sgi4xVblvsbnJa+WY7X1GyA=;
        b=rf0sNDI6qLk/F9FRVWHFKDPDOAV2SFG41lViL2oqCNm5XKgf8ElC6LvLtUPeDhQ3QQ
         mTg7oVSsmhDgWBMfH7akdAV2oqHXl7xCTGptdTBN5nwLEIuNDkVZlQq8veBPiCJ++cSI
         JKwpTdNOdIUPbT9E5ZMQ1zuFVG62sg5PuPzyc7HxRMQ637KlF0Jk5WvuHjUGCpfpfYM1
         S8cWY7Uq4XT0nkGZePy7IY/WbluSWr/41kmNSg6m9Vz0UAY4P00pLoJ1v8a2sv2DfaD8
         acvfBLOU77TERh5qHcFBVgHe8wsSPv9BfdcMiCAEBZJNqoeXUCPXY59SUw7jEQ+tBEm1
         GqFA==
X-Gm-Message-State: AOAM530MlAuhbgZ+meGA0KYtaxkoB/HmAd3BjR2QZOUg05eASAY6vcwH
        rWHhuRYs1OSoZW2xT8CqKPfvvm8KzywMZ7T0
X-Google-Smtp-Source: ABdhPJxGWhPwPw47bfmeNaX7tJlCLwlMwqS7vYuPfhtH7Jj29o1BBUErkm7DJl0PRmsg6EcG27wgcg==
X-Received: by 2002:a05:600c:1546:: with SMTP id f6mr4529002wmg.164.1626354982094;
        Thu, 15 Jul 2021 06:16:22 -0700 (PDT)
Received: from [192.168.0.102] (line103-230.adsl.actcom.co.il. [192.117.103.230])
        by smtp.gmail.com with ESMTPSA id b16sm6695721wrw.46.2021.07.15.06.16.21
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jul 2021 06:16:21 -0700 (PDT)
To:     linux-nfs <linux-nfs@vger.kernel.org>
From:   guy keren <guy@vastdata.com>
Subject: nfs4.1 and nconnect - is this supported?
Message-ID: <9d726e22-8c47-41ac-727b-3a27a9919fc6@vastdata.com>
Date:   Thu, 15 Jul 2021 16:16:19 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


hi,

i wonder if the linux client's nfs nconnect feature was designed to 
support NFS4.1 (or higher) versions? according to our experimentation, 
the linux client seems to just alternate messages between the multiple 
RPC/TCP connections, and does not seem to adhere to the NFS 4.1 protocol 
requirement, that when using multiple connections, the client needs to 
use BIND_CONN_TO_SESSION when trying to user a 2nd connection with the 
same NFS4.1 session.

was this done on purpose? or is this configuration not supported by 
linux client's 'nconnect'? or am i missing something?

thanks,
--guy
