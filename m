Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDD5736665A
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Apr 2021 09:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235285AbhDUHmy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 21 Apr 2021 03:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235209AbhDUHmx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 21 Apr 2021 03:42:53 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C74CBC06174A
        for <linux-nfs@vger.kernel.org>; Wed, 21 Apr 2021 00:42:19 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id m9so27509356wrx.3
        for <linux-nfs@vger.kernel.org>; Wed, 21 Apr 2021 00:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vastdata.com; s=google;
        h=subject:from:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=pBdqiJncyH2o39GVR3J9B5HtMf1HSUof92ISBfiwyio=;
        b=fxSf8koTvTXtrrxVOcIdEzNRIjt5Lze+ufz9bDjj7Z+NVAfVTCEPgDSMMm8s0MY8Xx
         ItZWqsC3/UGcp5sVNmder3KGO3BfCwmN0a146fNz2MUurZFtQqUOe2Yx4zumvgWGL3yy
         rkBotfD/ggLQX9NpHhbTszfIZqw3P9T2jKGpLPIoTXt5mpGvXFy7aalVAEK3nvt58BJP
         4nt1xXPubETMhblWpuTt7tL+kL8HFIFncXf7mwh9WLn8GDGJFAcEUaUcKzJGOLzLa4rt
         SDd9HYFT7zHt7UANS7gxzf5HmFrLteckgxBA8r05CQIE4ihz3QxdekjHbKr7Y3cjceBw
         EbMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=pBdqiJncyH2o39GVR3J9B5HtMf1HSUof92ISBfiwyio=;
        b=Xhr4yqm08rQmd3DO3ejeR83FEtjPPsbc99zdJPMIpt6bpT5aqMFpH+nium6SZHeztT
         mFnM54nBvmTuJR/WYglKC3p7Z0M8xvOEN0t1HZ4IespR4raN7LKLjov6GpwnQD67ro6d
         8cDa66N/jBux64u85YTA4ibJ/ujSVw3I8iAEpGsCpm0tPaWEWN45Suzip6Nte8bmI5YF
         K8MvV8IcSEUPTSA2sSTjVj1ej7DYDrTH8TEUo1a9Biv6LRTY2UPqeEwBIv56RZdZ7Mqo
         adm744+4muWJZlYAZN5t5PjBm4RzJ1U1jMyieCDKt3TX+iOI0dY7MhGSM21sFe33dupn
         415Q==
X-Gm-Message-State: AOAM531EYQhWxNrosfjeNxAwmeCBJRA+FZyRmqOCDF9V9oo2f3l+jact
        oRLbQP1oQqNoyV0Y/X9LTl0CAFnuto+RDQ==
X-Google-Smtp-Source: ABdhPJw10W/9+oP7vI3owP7Qa/d4bxL2g19RCcSUOgpNbJ6dScQsxEMdn5KsiLJ4+t4/qlXZpDKDyw==
X-Received: by 2002:a5d:524e:: with SMTP id k14mr24946317wrc.282.1618990938188;
        Wed, 21 Apr 2021 00:42:18 -0700 (PDT)
Received: from [192.168.0.102] (line103-230.adsl.actcom.co.il. [192.117.103.230])
        by smtp.gmail.com with ESMTPSA id g132sm1410830wmg.42.2021.04.21.00.42.17
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Apr 2021 00:42:17 -0700 (PDT)
Subject: Re: Linux NFS4.1 client's "server trunking" seems to do the opposite
 of what the name implies
From:   guy keren <guy@vastdata.com>
To:     linux-nfs@vger.kernel.org
References: <061a976c-2082-bb86-91ec-f0f97a73e1ac@vastdata.com>
Message-ID: <ee933f9d-21fd-9bc7-cdce-8da2d43b30a1@vastdata.com>
Date:   Wed, 21 Apr 2021 10:42:16 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <061a976c-2082-bb86-91ec-f0f97a73e1ac@vastdata.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

hi Olga, thanks for the response. more comments/questions below:

On 4/21/21 2:28 AM, Olga Kornievskaia wrote:
 > On Tue, Apr 20, 2021 at 4:59 PM guy keren <guy@vastdata.com> wrote:
 >> Hi,
 >>
 >> when attempting to make two NFS 4.1 mounts from a linux NFS client, to
 >> two IP addresses belonging to two different hosts in the same cluster
 >> (i.e. the server major id in the EXCHANGE_ID response is the same) - the
 >> linux NFS4.1 client discards the new TCP connection (to the 2nd IP) and
 >> instead decides to use the first client connection for both mounts. this
 >> seems to be handled in a hard-coded inside the function named
 >> "nfs41_discover_server_trunking", and leads to reduced performance,
 >> relative to using NFS3 (which will use two different TCP connections to
 >> the two different hosts in the storage cluster).
 >>
 >> i was under the impression that (client_id) trunking is supposed to
 >> allow to multiplex commands over multiple TCP connections - not to
 >> consolidate different workloads onto the same TCP connection.
 >>
 >> is there a way to avoid this behaviour, other then faking that the
 >> "server major id" is different on each node in the cluster? (this is
 >> what appears to be done by NetApp, for instance).
 > Hi Guy,
 >
 > Current implementation of the linux client does not support session
 > trunking to the MDS (nor does it support client id trunking). I'm
 > hoping session trunking support comes in the near future. Clientid
 > trunking might not be something that's supported unless we'll have a
 > clustered NFS server out there that can utilize that behaviour.

i see.

 > Btw you can do multipath NFS flows by using the combination of
 > nconnect and the newly proposed sysfs interface (still in review) that
 > can manipulate server endpoints.

the problem with nconnect is that although we will have multiple TCP 
connections, they will all utilize the same session, which limits the 
requests parallelism that can be achieved (since the slot table size is 
the limiting factor for the number of in-flight commands).

the same problem will also exist with session trunking - while when 
doing only client-id trunking (with a separate NFS4.1 session per TCP 
connection) - the number of in-flight commands can be increased linearly 
to the number of TCP connections.

is there any way to work around that?


p.s. is there anyone actively working on session trunking support, or is 
it just a "future roadmap item: with no concrete plans?

thanks,

--guy keren


Vast Data.
