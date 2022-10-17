Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 632D96005F7
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Oct 2022 06:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbiJQEUc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 17 Oct 2022 00:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbiJQEUa (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 17 Oct 2022 00:20:30 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F7F949B76;
        Sun, 16 Oct 2022 21:20:29 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id p3-20020a17090a284300b0020a85fa3ffcso13103962pjf.2;
        Sun, 16 Oct 2022 21:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gTOwOA0XmX0CaamOlVKmNlRf9Mc4V2zE7CIUJkQl9HE=;
        b=kfsJ1j4npUBZD7/RMmHcxvOa+69Mp/VbxCtTBwUIOQ+iY6dGoEFB6N4JxA/7r7DRot
         fFYg7T8YBScYq6coK+Ydji793t1Wcq4KvWi7bYHcd2Yyv427UBZdmhCH/5Wevpo8Y+WK
         W6jjMrq3dUQFPxaNfu1SpAqflbzITxteOi9mDrihmrHDr8MObPwvBhdQqrNTMss3sOE5
         hEdvWHL6rtZB4hI619QonGDnD+Dlc7ec0w7Y7F5270t1iwCsiPVRIlqOUWf6CQUIkW1M
         exq8WYsYUHrM6tk3Ut30SYAVxVenAnJfoz0Rvz9lDwsAW+DZ06X3eeAmZLiIeidgXnOo
         q3bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gTOwOA0XmX0CaamOlVKmNlRf9Mc4V2zE7CIUJkQl9HE=;
        b=Vf1sR/aRMPjqNkMt6UmYNFOg6W74LY7t44Y1Xaev0Mjv3Yc/9FD62kdaWIDXQY8mJM
         HtrT7vNT47F452n2EX+jpMqxuqSyn2ziLzV4y3oC2VSg0hkipT12gg/tG6vRYgi2Bhu3
         RPO0gBM5WErI2EqRsqYnbsQuQLDbTdTlRhnOcUuDMsgMW3FfJQkTDW1d4BRf227JOkWn
         7ptQ4lefw7oSTMSFoBgBOVzbqfI+Us6OjZ/SjlwmZpp8HNGphIdFlZh50rXoczTvePGq
         2TNdzt1XQ2g8QFGBcbSLUcNnpGcp7VYSTd7+ERVvKnVgb+78r/ljEKv73L1Jcw9OBfAW
         NOZQ==
X-Gm-Message-State: ACrzQf0VVtcH1rdFFLH16YiZlJb0hp+lY69R41UiSReXz3ifZRa+Mk8j
        ZHFTPeOT2c1aA1NQZecTEQI=
X-Google-Smtp-Source: AMsMyM6BIsSq04fxAuB0rHbRG0Oi/5ITFNuJWFzVzhxYUI13F+kVnmFJX+i8J3tMlHsi/4pezIEaoA==
X-Received: by 2002:a17:903:240a:b0:183:6555:7a89 with SMTP id e10-20020a170903240a00b0018365557a89mr10240566plo.68.1665980429115;
        Sun, 16 Oct 2022 21:20:29 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-89.three.co.id. [180.214.233.89])
        by smtp.gmail.com with ESMTPSA id b3-20020a170902d50300b00174d9bbeda4sm5531616plg.197.2022.10.16.21.20.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Oct 2022 21:20:28 -0700 (PDT)
Message-ID: <9bf36e3a-f718-ec96-3759-e8f17fe025f3@gmail.com>
Date:   Mon, 17 Oct 2022 11:20:24 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: 6.1rc1: NFS memcpy warning on mount
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>
Cc:     Dave Jones <davej@codemonkey.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nfs@vger.kernel.org, linux-hardening@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Scott Mayhew <smayhew@redhat.com>,
        Anna Schumaker <anna@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <CAHk-=wj6y5fipM2A5kEuOO9qm5PBzUY=-m9viEahhtxT09KR_g@mail.gmail.com>
 <Y0zEzZwhOxTDcBTB@codemonkey.org.uk> <Y0zS/5WLi2q4Ua2U@debian.me>
 <202210162113.1A948FEAB@keescook>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <202210162113.1A948FEAB@keescook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 10/17/22 11:17, Kees Cook wrote:
> On Mon, Oct 17, 2022 at 10:58:55AM +0700, Bagas Sanjaya wrote:
>> On Sun, Oct 16, 2022 at 10:58:21PM -0400, Dave Jones wrote:
>>> Started getting this during mount on a 6.1rc1 kernel..
>>> not sure which mount it's complaining about, but they're all v3 tcp
>>> mounts on that machine.
>>>
>>> [   19.617475] memcpy: detected field-spanning write (size 28) of single field "request.sap" at fs/nfs/super.c:857 (size 18446744073709551615)
>> [...]
>> Hmm, the blamed line in the warning is introduced by 38465f5d1af932 ("NFS:
>> rename nfs_fs_context pointer arg in a few functions"). Cc: the commit
>> author. Also Cc: Kees for authoring the patch [1] that have fixed
>> similar warning.
> 
> The warning is from commit 54d9469bc515 ("fortify: Add run-time WARN
> for cross-field memcpy()")
> 
>> Also, does v6.0 have this warning? If so, you need to bisect in the range
>> of v6.0..v6.1-rc1.
> 
> No need for bisection -- this is almost certainly a false positive (as
> detailed in the above commit: we're working on purging all of these
> cases from the kernel).
> 
>> [1]: https://lore.kernel.org/lkml/20221011065243.583650-1-keescook@chromium.org/
> 
> Yeah, I have a v2 of this patch, which should also fix this request.sap
> issue. Sending shortly...
> 

OK, thanks!

-- 
An old man doll... just what I always wanted! - Clara

