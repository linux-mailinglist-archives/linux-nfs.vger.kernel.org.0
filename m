Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09B887AE4A7
	for <lists+linux-nfs@lfdr.de>; Tue, 26 Sep 2023 06:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233467AbjIZElk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 26 Sep 2023 00:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232910AbjIZElk (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 26 Sep 2023 00:41:40 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54B1997
        for <linux-nfs@vger.kernel.org>; Mon, 25 Sep 2023 21:41:33 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-4053cb57f02so67293685e9.1
        for <linux-nfs@vger.kernel.org>; Mon, 25 Sep 2023 21:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695703291; x=1696308091; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NUW66ux3HZ+GNu0gE9JTYuwVym4ucCihRlEt8gugTjs=;
        b=B4QAqM/K+rVwWos+ASNRCskDAIsJVcUQh3WR4Ptnqnvopd2oQG+4SsnT6mqmQAHhQA
         XVDeuxX48tFkF3qWnkIYxfCKr4wehGi+mZg0OSFc1NUHA+0PpP3UjrLkvRaDz9lg3nVn
         8C/7PgShBPToC5mRlgXR7D/yku+Nixwn/Ew8TrcIzyQzViUZQORRuhtNCrDyzVbtWdSF
         bLfteikbK3O6AsaMd+MGesJDF05u19Yl7rzfP24Sw88E0IErzX/0hc5wyifyHFnwDCfB
         gzLzvH4BdGIsTIDHXuCK8PdEQQMgHA9TgmX8RReJu/Nj7ZNI9a+JMVAANGVLz9ubwIwX
         OucA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695703291; x=1696308091;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NUW66ux3HZ+GNu0gE9JTYuwVym4ucCihRlEt8gugTjs=;
        b=DUHM9uTTpAmXJyxLlAyP/wnpl14j7CHS8vObkKHzy5g46LsqWvfBb7MSBjaUCUYRbG
         IzkillKx2pHx4dloeTMY2zqWj1dy627i6pY+l4V7GzyjTqlzB7YbPRtYGTnYMVSKfsc7
         SzVu7T5IeXj3qux1EZlA96vBqtJV4hszkBJoc95QZFx6zfMm/KKSno+W3uR9OO7+JEuC
         YX/UvEMS6KflVebqv+Q+ZoFdq9MKcwaiwF17nqxLqpB+bw3SRJdsBfzLAD3iexgPphhT
         JlhpVqeALOLfx2SwGbiIX4FXGOGazy4mfMZy5Yqr6eXx373GIc2wY6WPNm9MoXbQffq+
         5oLg==
X-Gm-Message-State: AOJu0YzV+7j3g70pMDh7KRAd+h2Nxh2+eniCFJs/TsAGIIlggd89woDK
        UVuLnyclBJz0xGT6TaBxS3u93M1rF1r8Eg==
X-Google-Smtp-Source: AGHT+IGWATHVu4DPoeXWbL2ibUAyL8Vpvt7NwlhmoaVfyTsyd8VOjeQX6gX8dkz2uRpj2B9m1piV2A==
X-Received: by 2002:adf:cd81:0:b0:319:755c:3c1e with SMTP id q1-20020adfcd81000000b00319755c3c1emr7818566wrj.11.1695703291240;
        Mon, 25 Sep 2023 21:41:31 -0700 (PDT)
Received: from ?IPV6:2001:778:e27f:a23:36c4:e19f:3c1:8a8? ([2001:778:e27f:a23:36c4:e19f:3c1:8a8])
        by smtp.gmail.com with ESMTPSA id a3-20020a5d4d43000000b003177074f830sm13628167wru.59.2023.09.25.21.41.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Sep 2023 21:41:30 -0700 (PDT)
Message-ID: <8cb19861-7fd2-4d12-bd76-78bbb8fcee7c@gmail.com>
Date:   Tue, 26 Sep 2023 07:41:29 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Data corruption with 5.10.x client -> 6.5.x server
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <f1d0b234-e650-0f6e-0f5d-126b3d51d1eb@gmail.com>
 <6E4B8EB9-FA7E-4ABD-81AB-6FB0EF07EA46@oracle.com>
 <f90866e3-8c54-8a9c-c100-f5550c31b664@gmail.com>
 <9691788F-2B62-4EB5-8879-CEDABD1B9D4B@oracle.com>
 <78c81a97-4324-c2df-27c0-917436ddee07@gmail.com>
 <6908E735-6912-4AEC-8AD7-995F2F8A144A@oracle.com>
 <CA1D7203-72FB-4681-AD60-F1D80A57C154@oracle.com>
Content-Language: en-US, lt-LT
From:   =?UTF-8?Q?Mantas_Mikul=C4=97nas?= <grawity@gmail.com>
In-Reply-To: <CA1D7203-72FB-4681-AD60-F1D80A57C154@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 25/09/2023 22.22, Chuck Lever III wrote:
>> On Sep 24, 2023, at 2:24 PM, Chuck Lever III <chuck.lever@oracle.com> wrote:
>>
>>> On Sep 24, 2023, at 12:51 PM, Mantas Mikulėnas <grawity@gmail.com> wrote:
>>>
>>> Right, whereas on the server, the first file is filled with "Hello World (4092 bytes)" as I originally tried to narrow down the issue.
>>>
>>> Meanwhile, 6.4.x (Arch) clients don't seem to be having any problems with the same server, and with seemingly the same mount options.
>>>
>>> Thanks for looking into it!<nfs_krb5i_working_6.4client.pcap>
>> I found /a/ problem with the nfsd-fixes branch and krb5i, but
>> maybe not /your/ problem, and it's with a recent client. Scrounging
>> a v5.10-vintage client is a little more work, we'll see if that's
>> needed for confirming an eventual fix.
> The issue I reproduced appears to be unrelated.
>
> I'm wondering if I can get you to bisect the server kernel using
> your v5.10 client to test? good = v6.4, bad = v6.5 should do it.

Yeah, I will try to bisect but it'll probably take a day or two.

