Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA7CF2FFD83
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Jan 2021 08:38:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbhAVHiC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 22 Jan 2021 02:38:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726537AbhAVHh7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 22 Jan 2021 02:37:59 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7802CC06178C
        for <linux-nfs@vger.kernel.org>; Thu, 21 Jan 2021 23:37:12 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id t29so3146169pfg.11
        for <linux-nfs@vger.kernel.org>; Thu, 21 Jan 2021 23:37:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xnObBx7qCVcq4Xmng0HzOiOYW//hrsobDgYRbXW2qoA=;
        b=dfhsrZgi1qJDI2m/ilO0UZ7ihv26w0btzlf1zmTicpi6ZJPqGMSAzlb7G4wGiF0FW3
         Gijmj6YCtu3PwTEsxPDNKVLwzNJfoZ+kzsARJbaXfKhjIPk0hIdEI6k7+iABd3J0Ge6o
         E21BaI1DVfxYzhQmtffSyiTWTX0ggTKcY1OLoksddvORRrvfQMQGbsphmp1xU/IKzC+G
         sD/zie7QvCQK1vih68EwWOxT3P4AOnndd/VBNtbw7iZsbzo+OPZQFBdc76x6uF8HLA4t
         egiWvXKCvt0EJ4zf4Nru3997s4IFCMrrcBcXNTQ8OpxxqBRXA3kIBOHmAEsIKhM9WxEA
         fFbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xnObBx7qCVcq4Xmng0HzOiOYW//hrsobDgYRbXW2qoA=;
        b=ekAFF0ONd63zckGq2A6EFDC3NscYicrIUyCvPBoMXhPpXVMRs/ULJ1AbX2toCIpeWz
         zYfTVsW2Y4vfnuoz4fMU7Hvpw65VdnsZYGjU6MF88UJmcMamDg07uCb3xt/gJv4maQAB
         U1EF4+mPQOG8srQJ1qwbftiye7Q5vE/u7xIQaHzyn0QmlncLsmnf73DTFQjZsRJc77yu
         VRc5rcW9TZOiGIR1My8/HNJwRoVNj8MM1dqPYVxYjq3vJCTLPLPr2AUQO4OntD+M3ArM
         FInws+3DIDc/hQI0805nezG++vynNkcXgzr5LWE8Tc2oYz8XRxLATNfoOsBX9jDWO+xQ
         Rsyw==
X-Gm-Message-State: AOAM531FjGUWgCxqK2pIXlJ4Ucke6LegoY/aSXmv8ElNwxsVBhHAkcbC
        wJI9y0GvrseD2spNMBCXlbbTn6968JR9HfMY
X-Google-Smtp-Source: ABdhPJwPLaEjEPKwC34UrAC2gsulKg3s4j7+J97bZTNNIKaoZ/lJu48wNw2Iwm4BkDrJnbbca6y71A==
X-Received: by 2002:a63:1f18:: with SMTP id f24mr3506723pgf.133.1611301030526;
        Thu, 21 Jan 2021 23:37:10 -0800 (PST)
Received: from [10.8.0.116] ([196.245.9.36])
        by smtp.gmail.com with ESMTPSA id fh7sm7835085pjb.43.2021.01.21.23.37.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jan 2021 23:37:09 -0800 (PST)
Subject: Re: [PATCH 1/2] block: remove unnecessary argument from
 blk_execute_rq_nowait
To:     Christoph Hellwig <hch@infradead.org>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        target-devel@vger.kernel.org, linux-scsi@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-ide@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org
References: <20210121142905.13089-1-guoqing.jiang@cloud.ionos.com>
 <20210121142905.13089-2-guoqing.jiang@cloud.ionos.com>
 <20210121170257.GA4120717@infradead.org>
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <b87591b9-e598-6436-d41f-80cc56640549@cloud.ionos.com>
Date:   Fri, 22 Jan 2021 08:36:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210121170257.GA4120717@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 1/21/21 18:02, Christoph Hellwig wrote:
> On Thu, Jan 21, 2021 at 03:29:04PM +0100, Guoqing Jiang wrote:
>> The 'q' is not used since commit a1ce35fa4985 ("block: remove dead
>> elevator code"), also update the comment of the function.
> 
> And more importantly it never really was needed to start with given
> that we can triviall derive it from struct request.

Thanks Christoph, will add the above to header and send new version.

Guoqing
