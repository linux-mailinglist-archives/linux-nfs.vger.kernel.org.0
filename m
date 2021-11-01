Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E45CF44208B
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Nov 2021 20:10:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232543AbhKATNR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 1 Nov 2021 15:13:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:44505 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232544AbhKATNI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 1 Nov 2021 15:13:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635793834;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3Ud5QXWWSO8dqRH2e90V+orXK/BEbVSDBMLoHuE4+4Y=;
        b=gdU3fOMCFuuPK6NEtrTREmzvXXi/Sm/HGQJeSjciZLieXLY+2bpJrXxqq+mY6Y9M8kauoL
        8yoaO0QsNHuhqiJHBV318uV+Thf1lcPjRetFuuhf5MjTo2C2hQbu55m93pzT0JLSVslgvv
        juQw/mZsjHpp2PPpn2b1VgoNFU/D6GQ=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-98-a5mwB9WHPD2ZXU2ShnRVwA-1; Mon, 01 Nov 2021 15:10:33 -0400
X-MC-Unique: a5mwB9WHPD2ZXU2ShnRVwA-1
Received: by mail-qt1-f199.google.com with SMTP id g3-20020ac85803000000b002ac655f3b00so7318431qtg.20
        for <linux-nfs@vger.kernel.org>; Mon, 01 Nov 2021 12:10:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3Ud5QXWWSO8dqRH2e90V+orXK/BEbVSDBMLoHuE4+4Y=;
        b=Jy62jpWxmLFTzhFJxYcPsKFrdINzDs613/zDzKCZcsWFujOYrXCehPTVjzHlYM8Len
         4x1qrsJfmhJLfzc4xcu/O/PltaEwU3ntY1omEAwZpklxhGK7yiA1ytKcAvI15nVDRlEN
         VAsktxKIXsMmnAJa67RFlI386tZuRXOSqYs3kWvWWybX2HmUar1ccqn0uj0MXYE6QfrI
         GjrI7t1tzEdKvs/fqo6M3TC0CSNXY2jin/QYWjbwp9LVxMMfY95FNj1BwDnR97jMqvw7
         9eG6ramnBCFBdTM6WCmJRTz0iMGccqQdhNqObn/zrm3ARiWDpUucDVOhlMSKcqgGXW6q
         udVw==
X-Gm-Message-State: AOAM530mcR55l3SgztshfB0Wd+ih5WCcoQHJl/oFbyIgpju8l7clfvi4
        bJuQJKX3+/70Ol3uQeX+EUfzMyFVaoEBJZFKC+9UXk6ycHtKE6WaDpSH8Q5DpMi2FOeH3bTpIid
        Es/CH0o+AfdFMmc/PWwdM
X-Received: by 2002:a05:620a:29c3:: with SMTP id s3mr246508qkp.342.1635793832881;
        Mon, 01 Nov 2021 12:10:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyQ8EiMmDITlcWzaPPVPaJCYflaG8NNUabOa0l+CdFaqWL0d78BFGJJR1zvzhQFS0kfbfctBA==
X-Received: by 2002:a05:620a:29c3:: with SMTP id s3mr246485qkp.342.1635793832661;
        Mon, 01 Nov 2021 12:10:32 -0700 (PDT)
Received: from [172.31.1.6] ([70.105.245.20])
        by smtp.gmail.com with ESMTPSA id z5sm3208407qtw.71.2021.11.01.12.10.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Nov 2021 12:10:32 -0700 (PDT)
Message-ID: <79e55dad-7f34-3723-98b0-7c2ef7be9355@redhat.com>
Date:   Mon, 1 Nov 2021 15:10:31 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 0/1] Enable inter server to server copies on a export
Content-Language: en-US
To:     Bruce Fields <bfields@fieldses.org>,
        Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <20211028144851.644018-1-steved@redhat.com>
 <20211029134534.GA19967@fieldses.org>
 <3e928624-6a7a-8583-7ea4-4eef9c22488e@redhat.com>
 <20211029164058.GE19967@fieldses.org>
 <65b31c94-54aa-5035-546c-75eb0048ba96@redhat.com>
 <20211029191435.GI19967@fieldses.org>
 <ce34c1f2-a0ad-fcb0-99fa-a1ccea8abfd7@redhat.com>
 <20211101154046.GA12965@fieldses.org>
 <93DAB7C7-D0BB-48BA-9BFF-2821D88582EA@oracle.com>
 <20211101183916.GA14427@fieldses.org>
From:   Steve Dickson <steved@redhat.com>
In-Reply-To: <20211101183916.GA14427@fieldses.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 11/1/21 14:39, Bruce Fields wrote:
> On Mon, Nov 01, 2021 at 04:55:45PM +0000, Chuck Lever III wrote:
>>
>>> On Nov 1, 2021, at 11:40 AM, J. Bruce Fields <bfields@fieldses.org> wrote:
>>>
>>> On Mon, Nov 01, 2021 at 11:30:48AM -0400, Steve Dickson wrote:
>>>> Hey!
>>>>
>>>> On 10/29/21 15:14, J. Bruce Fields wrote:
>>>>> On Fri, Oct 29, 2021 at 01:30:36PM -0400, Steve Dickson wrote:
>>>>>> On 10/29/21 12:40, J. Bruce Fields wrote:
>>>>>>> Let's just stick with that for now, and leave it off by default until
>>>>>>> we're sure it's mature enough.  Let's not introduce new configuration to
>>>>>>> work around problems that we haven't really analyzed yet.
>>>>>> How is this going to find problems? At least with the export option
>>>>>> it is documented
>>>>>
>>>>> That sounds fixable.  We need documentation of module parameters anyway.
>>>> Yeah I just took I don't see any documentation of module
>>>> parameters anywhere for any of the modules. But by documentation
>>>> I meant having the feature in the exports(5) manpage.
>>>
>>> I think I'd probably create a new page for sysctls (this isn't the only
>>> one needing documentation), and make sure it's listed in the "SEE ALSO"
>>> section of the other man pages.
>>
>> Aren't sysctls documented under Documentation/ ?
> 
> Sorry, I meant "module parameter".  Anyway, yes, looks like both are
> listed in Documentation/admin-guide/kernel-parameters.txt.
> 
> Might be nice if these were in a man page too somewhere, but maybe
> that's not the most important thing these days.
> 
> --b.
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 91ba391f9b32..14bc3f0b0149 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -3243,6 +3243,19 @@
>   			driver. A non-zero value sets the minimum interval
>   			in seconds between layoutstats transmissions.
>   
> +	nfsd.inter_copy_offload_enable =
> +			[NFSv4.2] When set to 1, the server will support
> +			server-to-server copies for which this server is
> +			the destination of the copy.
> +
> +	nfsd.nfsd4_ssc_umount_timeout =
> +			[NFSv4.2] When used as the destination of a
> +			server-to-server copy, knfsd temporarily mounts
> +			the source server.  It caches the mount in case
> +			it will be needed again, and discards it if not
> +			used for the number of milliseconds specified by
> +			this parameter.
> +
>   	nfsd.nfs4_disable_idmapping=
>   			[NFSv4] When set to the default of '1', the NFSv4
>   			server will return only numeric uids and gids to
> @@ -3250,6 +3263,7 @@
>   			and gids from such clients.  This is intended to ease
>   			migration from NFSv2/v3.
>   
> +
>   	nmi_backtrace.backtrace_idle [KNL]
>   			Dump stacks even of idle CPUs in response to an
>   			NMI stack-backtrace request.
> 
Interesting... I don't see these in the Linus tree I'm looking at [1]
find Documentation/ -type f  | xargs grep -i inter_copy_offload_enable

steved

[1] git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git

