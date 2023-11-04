Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C7A77E0CB4
	for <lists+linux-nfs@lfdr.de>; Sat,  4 Nov 2023 01:37:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbjKDA12 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 3 Nov 2023 20:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjKDA12 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 3 Nov 2023 20:27:28 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31AC7D49;
        Fri,  3 Nov 2023 17:27:24 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6bb4abb8100so2492009b3a.2;
        Fri, 03 Nov 2023 17:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699057643; x=1699662443; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZSruXExCC7oyLfN8ZSYHDj8sJJzKMrm8E7odv0JQbpk=;
        b=gODxd8mllFY9MoSKZLaHzS2WzPAF6NAZXWh7QPMqJYFmewa4xIn2S93MvkPSK+Lbf9
         8Pt/twOL4q+V5ojhYyhbTe3/E/pUPw+4c1KHakMLMrrIofObWyVC/xJAMMC8kugTmmgw
         n9lWjnA2Z839fRF5lTIaqdeR3RkawSvZrBJ34XQa1Z3FJbPODENPLwipx3/PPcI3ylGs
         /sDVgKwsHKmRIKkc8yJvXXouOG6SH9BPZx0iGCglzJHXKAyRyTw7ELs0ao2yL5XjGVdA
         xhwfJZxPo7BR9nBlbYdb3AQze2zl2EpXTP0LE3MUt2ZKMELHbI/XF7A6Yfvxrnp30TBM
         iVbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699057643; x=1699662443;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZSruXExCC7oyLfN8ZSYHDj8sJJzKMrm8E7odv0JQbpk=;
        b=B9NcTku8iOkIP2GkSy2weQJkAoVjnb0ie9BBD5dVU3BTWbo1BNWD+Aq5O+jkvzUA8U
         hXhT4eETB6ekCSrkl5QbwtJ0AWyjgjN/aq3nQfJFaWKnW0ipVb3aKUENgZyil4wjIB+z
         /bxDIQUu8LRNABR+5B/demKB3b57mEI8k3XXdyT7SIoZDvq8+U79ncDeXoT3dE6rhnOD
         cn9Ul8lvE22iTEaVEwG8MxoGlqeExxtZpohYdubn3XPnzA49rxasGwIG3QC6ZQIk2+ym
         pASwyDH8A/iS9f4r0lLlD6hmsyNdQAcQmNez+sX9yHaVK3iqYG1RnzBOGvFiUjnNTjuV
         /F1g==
X-Gm-Message-State: AOJu0YyoZfj0fzIAyYXJAXVep8uyrW6eXycDxpA2WDTHn61QXOvmIjs7
        RthW/zeVHhj/RiX2enquKiY=
X-Google-Smtp-Source: AGHT+IFfm/C4eEi089pE7HOXJTu6LK5uaY2KHPfzzcBQCM008GsYRPPDZ9ry9IpfM7Ka0d7L3TLDfw==
X-Received: by 2002:a05:6a00:10d2:b0:693:3963:847a with SMTP id d18-20020a056a0010d200b006933963847amr22580602pfu.30.1699057643443;
        Fri, 03 Nov 2023 17:27:23 -0700 (PDT)
Received: from [192.168.0.106] ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id it10-20020a056a00458a00b0068ffd4eb66dsm1952259pfb.35.2023.11.03.17.27.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Nov 2023 17:27:22 -0700 (PDT)
Message-ID: <e93d5996-e9fc-4c28-ad33-5fd62fbac92d@gmail.com>
Date:   Sat, 4 Nov 2023 07:27:15 +0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: autofs mount/umount hangs with recent kernel?
To:     Charles Hedrick <hedrick@rutgers.edu>,
        Daire Byrne <daire@dneg.com>,
        Linux NFS <linux-nfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>
References: <CAPt2mGNPSi-+3WdeMsOjkJ2vOqZcRE2S6i=eqi+UA2RmzywAyg@mail.gmail.com>
 <ZUT_W8yoJ5wqSvLv@debian.me>
 <PH0PR14MB5493BD73D14C0002DE32DAE3AAA5A@PH0PR14MB5493.namprd14.prod.outlook.com>
Content-Language: en-US
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <PH0PR14MB5493BD73D14C0002DE32DAE3AAA5A@PH0PR14MB5493.namprd14.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 04/11/2023 03:07, Charles Hedrick wrote:
> We've seen behavior like that throughout the lifetime of 4.10 and 5.15 as well. It may be a different issue, though. For us it happens only with NFS 4.2. NFS 3 is fine. And once it happens, rebooting the client doesn't help. We have to reboot the NFS server. We're trying setting automount to never unmount, as an attempt to figure out whether the problem is actually caused by the unmounts and mounts.
> 
> I'd be happy to help diagnose if someone could tell me what data would be useful.
> 

Please don't top-post; reply inline with appropriate context instead.
And don't send HTML emails either, since mailing lists reject them.

First, you may want to test the mainline (currently at v6.6) on both
the server and the client. Then, please attach full system log
(most likely journalctl) to see if you have the same one as Daire
reported.

Thanks.

-- 
An old man doll... just what I always wanted! - Clara

