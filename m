Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E667671F69
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Jan 2023 15:23:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbjAROXE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 18 Jan 2023 09:23:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231287AbjAROW2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 18 Jan 2023 09:22:28 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D384875A1D
        for <linux-nfs@vger.kernel.org>; Wed, 18 Jan 2023 06:05:10 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id r9so11257178wrw.4
        for <linux-nfs@vger.kernel.org>; Wed, 18 Jan 2023 06:05:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arrikto-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kR0FeSmJkTHirMULb4z0zPufTieqUMiMZEiYNn7KurI=;
        b=lMwblsDQYpIdfnl2gzYDAVNLIUCKIYT6pzpVXuTnhjgFyrxtsX5XEUS55NgSU6BeqS
         H8BKp8jDN5AWy1yVg7A90Nlg6HzdBhq2C2e2OqpkJ4UWy5ewFHYv3ZaiWEeGoe5PQQ50
         0glXjuIQs5QoP5rOBfSNS2wCp0r2kKsNZrb6aZp4ICJNrM5KIjKDlFi/hjiT6M7pWmbd
         PuRm22PTQf3mlZ+ICbkqD0B7xpBfNLqo/A2vHiWuSXCkM+Pl0swwfJvR40zh18GBplcm
         cXFqpnEzkbAjRN7bAofF6R46+EWKSKDK57vm8kqCVgkkv4Yyd2/AcyRWv75SIbJS/hbB
         A4dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kR0FeSmJkTHirMULb4z0zPufTieqUMiMZEiYNn7KurI=;
        b=sKAJdnY1rZ/08zA2fhcScWk/JrlHf7AWX7dG/XTgqAi00o9LudGDxBcRPXa0QfQMsT
         9znKrGGZSgnXjVBdltBaKOg2qHaYtjjugVAk6AtPy/agBE2F/K6BrUX0bbH5sXgBeKzM
         YsZQeYJEQkS9sdcdOKX7ojcAOzKtxBnuVq7HV/l5JN+O7ztLH9J+j+5VixVbitFp9P3r
         AQmyIGlxKlWp5Ipd+Wo3l/qNH9dUQYJG1UlA0LhQFY9GVOnNWJPMj/04Q+aLJNcLI+yI
         iITNjadpzVFSurwjGEWoiW6ijpRMAXp9mjIGd21BkBeAMrDf9oq4aBpjUc4Kd6YGrW77
         1F7Q==
X-Gm-Message-State: AFqh2kpxFj9oVWD3G29eXchXWXq9Xi1I3FF1ATDcIZ7+H2eNrd2uHXM+
        1vOOj/g4of0C3fV4TqPzTCk2a0tu5DPOk51+
X-Google-Smtp-Source: AMrXdXtGnqJc5YAM1s1hAHnUdFIHU5zRDTwzzFw81EVxfmAnnChoKa8nt3lTJwlqGQAHhoUnIFgXkQ==
X-Received: by 2002:a5d:4b10:0:b0:26a:ec28:3856 with SMTP id v16-20020a5d4b10000000b0026aec283856mr6721900wrq.3.1674050709279;
        Wed, 18 Jan 2023 06:05:09 -0800 (PST)
Received: from [10.94.1.166] ([185.109.18.135])
        by smtp.gmail.com with ESMTPSA id s1-20020a5d4ec1000000b002882600e8a0sm31576823wrv.12.2023.01.18.06.05.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jan 2023 06:05:08 -0800 (PST)
Message-ID: <9f79ef7f-81c3-9e63-0ac7-467fc851f1f8@arrikto.com>
Date:   Wed, 18 Jan 2023 16:05:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] nfsd: Ensure knfsd shuts down when the "nfsd" pseudofs is
 unmounted
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     "trondmy@kernel.org" <trondmy@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <20210313210847.569041-1-trondmy@kernel.org>
 <936effe2-1268-42ab-886e-649b7c501828@arrikto.com>
 <DCF5C3D1-E4D0-4F40-81AA-38B74276B858@oracle.com>
Content-Language: en-US
From:   Nikos Tsironis <ntsironis@arrikto.com>
In-Reply-To: <DCF5C3D1-E4D0-4F40-81AA-38B74276B858@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 12/22/22 16:48, Chuck Lever III wrote:
> [ Cc: Bruce removed because that address no longer works ]
> 
>> On Dec 20, 2022, at 8:43 AM, Nikos Tsironis <ntsironis@arrikto.com> wrote:
>>
>> On 3/13/21 23:08, trondmy@kernel.org wrote:
>>> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>>> In order to ensure that knfsd threads don't linger once the nfsd
>>> pseudofs is unmounted (e.g. when the container is killed) we let
>>> nfsd_umount() shut down those threads and wait for them to exit.
>>> This also should ensure that we don't need to do a kernel mount of
>>> the pseudofs, since the thread lifetime is now limited by the
>>> lifetime of the filesystem.
>>> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
>>> ---
>>
>> Hello,
>>
>> This patch was merged in kernel v5.13, but the issue exists in older
>> kernels too.
>>
>> Is there a reason that the patch was never backported to older stable
>> kernels?
> 
> Hello Nikos-
> 
> A probable reason is there is no Fixes: or Cc: stable@vger tag in the
> merged commit, so it will not be cherry-picked by AUTOSEL. Another
> reason might be that the patch does not apply cleanly to LTS kernels.
> 
> You can make a request to stable@ for this patch to be backported, but
> I would prefer if you apply the patch and test it on each target kernel
> before making such a request. Or, you can pick which LTS kernel(s) are
> most relevant to you and ask for backport to only those.
> 
> A good test will have three parts:
> 
> - Make a positive confirmation the issue exists in that kernel
> 
> - Make sure the patch applies cleanly verbatim and causes no regression
> 
> - Make sure the patch fixes the issue in that kernel
> 
> It's a bit of (albeit mechanical) effort, and the Linux NFS community
> doesn't have the resources to manage it for all patches going into
> mainline to six different LTS kernels.
> 

Hello Chuck,

Thanks for the feedback, and sorry for the late reply.

I will backport the patch myself to LTS kernels 5.4 and 5.10, test it,
and send it to stable@ to request inclusion in these two kernels.

Nikos
