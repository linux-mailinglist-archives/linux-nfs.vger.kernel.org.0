Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56E524D3C20
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Mar 2022 22:36:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231923AbiCIVhA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 9 Mar 2022 16:37:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbiCIVhA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 9 Mar 2022 16:37:00 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9A3D0F9FB8
        for <linux-nfs@vger.kernel.org>; Wed,  9 Mar 2022 13:36:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646861759;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rEnljbPTk/nfkLUHHb4Tp5TXwtw0JWNQDCJlSdbbFTs=;
        b=coHjBFNyDX0JpsrXbgJ9zfpOpa9//7ZUIKvE8MU/wr7ZhWp2EgrUhRZMNThtWdrriKTc+a
        Wva2tfpgcgdCcediC1ogTZj40GKwMeCs9TmEWUD2JD7UEfmN87t2VW6IOT9qjmRFXP3pqX
        wbMGGhmwppdA+k4d3FcpQFYAPZLKiYM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-572-1tVeSyWcM_StZ0Q3DqNJxQ-1; Wed, 09 Mar 2022 16:35:56 -0500
X-MC-Unique: 1tVeSyWcM_StZ0Q3DqNJxQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 44FD9180A088;
        Wed,  9 Mar 2022 21:35:55 +0000 (UTC)
Received: from [172.16.176.1] (ovpn-64-2.rdu2.redhat.com [10.10.64.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D98CE4CEE1;
        Wed,  9 Mar 2022 21:35:54 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Chuck Lever III" <chuck.lever@oracle.com>
Cc:     trondmy@kernel.org,
        "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v9 03/27] NFS: Trace lookup revalidation failure
Date:   Wed, 09 Mar 2022 16:35:53 -0500
Message-ID: <FBED54D6-7C0F-4AE1-961E-78D3DDE00F6F@redhat.com>
In-Reply-To: <52214581-7C9A-425A-9B8E-082B7ACE23C1@oracle.com>
References: <20220227231227.9038-1-trondmy@kernel.org>
 <20220227231227.9038-2-trondmy@kernel.org>
 <20220227231227.9038-3-trondmy@kernel.org>
 <20220227231227.9038-4-trondmy@kernel.org>
 <638A1DDB-5424-4FFA-A5A5-D212519D3A37@redhat.com>
 <52214581-7C9A-425A-9B8E-082B7ACE23C1@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 9 Mar 2022, at 10:28, Chuck Lever III wrote:

>> On Mar 9, 2022, at 8:42 AM, Benjamin Coddington <bcodding@redhat.com> 
>> wrote:
>>
>> On 24 Feb 2022, at 21:09, Trond Myklebust wrote:
>>> On Thu, 2022-02-24 at 09:14 -0500, Benjamin Coddington wrote:
>>>> There's a path through nfs4_lookup_revalidate that will now only 
>>>> produce
>>>> this exit tracepoint.  Does it need the _enter tracepoint added?
>>>
>>> You're thinking about the nfs_lookup_revalidate_delegated() path? 
>>> The
>>> _enter() tracepoint doesn't provide any useful information that 
>>> isn't
>>> already provided by the _exit(), AFAICS.
>>
>> No, the path through nfs4_do_lookup_revalidate(), reval_dentry: jump. 
>>  But I
>> agree there's not much value in the _enter() tracepoint.  Maybe we 
>> can
>> remove it, and _exit more like _done.
>>
>> I am thinking about hearing back from folks about mis-matched 
>> _enter() and
>> _exit() results, but also realize this is nit-picking.
>
> I think the _enter / _exit trace points simply replaced
> dprintk call sites which did much the same reporting.
> Maybe we should consider replacing some of these because
> we can rely on function call tracing instead.
>
> But generally we like to see trace points that report
> exceptional events rather than "I made it to this point".
> The latter category of trace points are interesting
> while code is under development but often loses its
> value once the code is in the field.

Instead of "hearing back from folks" I should have said "I worry our QE 
team
is going to discover and possibly report as a bug". :P  Thanks for 
filling
in Chuck!

Ben

