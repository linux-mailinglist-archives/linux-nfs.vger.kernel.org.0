Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D591B7EAA
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Sep 2019 17:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388941AbfISP6N (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 19 Sep 2019 11:58:13 -0400
Received: from mail-wm1-f50.google.com ([209.85.128.50]:50685 "EHLO
        mail-wm1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388678AbfISP6N (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 19 Sep 2019 11:58:13 -0400
Received: by mail-wm1-f50.google.com with SMTP id 5so5243052wmg.0
        for <linux-nfs@vger.kernel.org>; Thu, 19 Sep 2019 08:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=G/yQGaWFflwzIYL3VFsL82DIXmpvWhog4+z/HObYJ5c=;
        b=NxF95xW+gfy2lINSJOlejzwXxfTAjNzp4hj5xkbg8C8oXgIDkkvKENP3OX/KBh3ANr
         nOkbbGyHVo53FCnpxWwycERVJWb07z4r8w6xWiUQ906NJr13298YLV6RNv42RrHVq5PD
         FNrM4/QLNJ2zteEFTHLTuu1YniC4wnsTg9gL+WePWXUGTN9GDkEA4uFvtYLxEWHBah+A
         TNb8+08z+AeC+NevZseJDBOedIHlJDMoAgTU84FIEbNaG+R6wQXaplpItj+kLCjl5RMq
         BPbqHhGZZfj1jLYbQ4CzB4Mvw+OOxIwTdsbDxcrWgOFy8uAMWXVb1RVGYGMwK0yHunAq
         GSAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=G/yQGaWFflwzIYL3VFsL82DIXmpvWhog4+z/HObYJ5c=;
        b=MP7NF5FgzRolEumTJ9JS4e5UCf0A8IWF4yNMbR0WQ4b41yd4ABi8ewulaY1QPt7KP3
         6OSnKTwT0GaKTaPsaD7HZZvTkTZKYIqZUDEwMBso44xDJKGqT3t4NSY6zgD6kuQ3KHna
         PmS9ywy9l4JPuU22BW7bTYFSQ9PasKCC4+dO+inm4j0lvye0JnM6LmECRTqbxeigUfJJ
         tuKZyHWZbxP1wEzIwuTUk1k7+/fHuezagvv14qf8oRhrc//zvVkCjTb9OiE9ToXZpHkT
         IMC22cBUR04gdOS1Ydem1sqwKfWvnSNQa6WUAHuSJGGAbeRltUhgz7N/3kMINZbUHAUl
         q8Rg==
X-Gm-Message-State: APjAAAU5N3vf2QjhJYgGh1nOvhqxw/ioligvOt23gAl0cwfB9H7Cml1D
        hR7sjO6PE5t1FxmG8u7St7INQ8MV
X-Google-Smtp-Source: APXvYqwpUzuUv6/r7ms7rQyolSwalob6W3196g/pEmX7WmIAjrTb+Tssi8wsmPU52WHGVQdLoThlFA==
X-Received: by 2002:a7b:c353:: with SMTP id l19mr3250445wmj.173.1568908691118;
        Thu, 19 Sep 2019 08:58:11 -0700 (PDT)
Received: from [10.161.254.11] (srv1-dide.ioa.sch.gr. [81.186.20.0])
        by smtp.googlemail.com with ESMTPSA id c8sm9153554wrr.49.2019.09.19.08.58.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Sep 2019 08:58:10 -0700 (PDT)
Subject: Re: rsize,wsize=1M causes severe lags in 10/100 Mbps
To:     linux-nfs@vger.kernel.org
Cc:     Trond Myklebust <trondmy@gmail.com>
References: <80353d78-e3d9-0ee2-64a4-cd2f22272fbe@gmail.com>
 <CAABAsM7XHjTC4311-XY04RSy_XJs+E+j+-3prYAarX_=k0259g@mail.gmail.com>
From:   Alkis Georgopoulos <alkisg@gmail.com>
Message-ID: <ee758eaf-c02d-f669-bc31-f30e6b17d92a@gmail.com>
Date:   Thu, 19 Sep 2019 18:58:09 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAABAsM7XHjTC4311-XY04RSy_XJs+E+j+-3prYAarX_=k0259g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 9/19/19 6:08 PM, Trond Myklebust wrote:
> The default client behaviour is just to go with whatever recommended
> value the server specifies. You can change that value yourself on the
> knfsd server by editing the pseudo-file in
> /proc/fs/nfsd/max_block_size.


Thank you, and I guess I can automate this, by running
`systemctl edit nfs-kernel-server`, and adding:
[Service]
ExecStartPre=sh -c 'echo 32768 > /proc/fs/nfsd/max_block_size'

But isn't it a problem that the defaults cause errors in dmesg and 
severe lags in 10/100 Mbps, and even make 1000 Mbps a lot less snappy 
than with 32K?

In any case thank you again.
Alkis Georgopoulos
