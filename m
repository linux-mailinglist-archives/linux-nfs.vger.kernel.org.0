Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C799A69F3BB
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Feb 2023 12:55:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbjBVLzT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 22 Feb 2023 06:55:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbjBVLzR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 22 Feb 2023 06:55:17 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BBDF3772B
        for <linux-nfs@vger.kernel.org>; Wed, 22 Feb 2023 03:54:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677066869;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bE7jNoZDiRfPREVbORqUJ28Tn1V1NQuJ7jP9TphftgA=;
        b=SYthrHRGmCZQpB3bZ8P2Wvj2GXHSk2jibHXSBC8vmN4mDsAEFO9wObFMCkDNMSHg/+zKnW
        cEsLYHJS1RZSyV49OxgWhEGBYnjtstDtOCl34tvuuP2DeHcdE75Vv9CZ8H9mg4zXJ3P4e9
        lmN+A0I0caup1li3x//SiGO3PGYn+cE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-547-poPfelntP-qS8MruvJjwOw-1; Wed, 22 Feb 2023 06:54:26 -0500
X-MC-Unique: poPfelntP-qS8MruvJjwOw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F2363101A52E;
        Wed, 22 Feb 2023 11:54:25 +0000 (UTC)
Received: from [172.16.176.1] (unknown [10.22.50.5])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3C96340CF8F0;
        Wed, 22 Feb 2023 11:54:25 +0000 (UTC)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     =?utf-8?q?Florian_M=C3=B6ller?= 
        <fmoeller@mathematik.uni-wuerzburg.de>
Cc:     Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
        Andreas Seeg <andreas.seeg@mathematik.uni-wuerzburg.de>
Subject: Re: Reoccurring 5 second delays during NFS calls
Date:   Wed, 22 Feb 2023 06:54:22 -0500
Message-ID: <5AB8B0FE-5D7E-4ED4-9537-979341C6371A@redhat.com>
In-Reply-To: <4f70c2f5-dfdb-c37c-8663-5f2a108e229e@mathematik.uni-wuerzburg.de>
References: <59682160-a246-395a-9486-9bbf11686740@mathematik.uni-wuerzburg.de>
 <8a02c86882bc47c1c1387dba8c7d756237cb3f3f.camel@kernel.org>
 <3b6c9b8e-2795-74e8-aefa-d4f1ac007c3c@mathematik.uni-wuerzburg.de>
 <785052D6-E39F-40D3-8BA3-72D3940EDD84@redhat.com>
 <7c7de5f1-fb6a-e970-99a2-4880583d8f6d@mathematik.uni-wuerzburg.de>
 <1B586C15-908C-4B00-9739-9AD118F88BD4@redhat.com>
 <4f70c2f5-dfdb-c37c-8663-5f2a108e229e@mathematik.uni-wuerzburg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 22 Feb 2023, at 3:19, Florian M=C3=B6ller wrote:

> Am 21.02.23 um 19:58 schrieb Benjamin Coddington:
>> On 21 Feb 2023, at 11:52, Florian M=C3=B6ller wrote:
>>
>>> Hi Benjamin,
>>>
>>> here are the trace and a listing of the corresponding network package=
s. If the listing is not detailed enough, I can send you a full package d=
ump tomorrow.
>>>
>>> The command I used was
>>>
>>> touch test.txt && sleep 2 && touch test.txt
>>>
>>> test.txt did not exist previously. So you have an example of a touch =
without and with delay.
>>
>> Thanks!  These are great - I can see from them that the client is inde=
ed
>> waiting in the stateid update mechanism because the server has returne=
d
>> NFS4ERR_STALE to the client's first CLOSE.
>>
>> That is unusual.  The server is signaling that the open file's stateid=
 is old,
>> so I am interested to see if the first CLOSE is sent with the stateid'=
s
>> sequence that was returned from the server.  I could probably see this=
 if I
>> had the server-side tracepoint data.
>
> Hi Benjamin,
>
> the server-side tracepoints
>
> nfsd:nfsd_preprocess
> sunrpc:svc_process
>
> were enabled. It seems they did not produce any output.
>
> What I did now was:
> - enable all nfsd tracepoints,
> - enable all nfs4 tracepoints,
> - enable all sunrpc tracepoints.
>
> The command I used was
>
> touch somefile && sleep 2 && touch somefile.
>
> Then I unmounted the NFS share - this also causes a delay.
>
> I changed the security type to krb5 and captured trace and network outp=
ut for a version 4.0 and a version 4.2 mount. The delay does not occur wh=
en using version 4.0.


In frame 9 of nfs-v4.2-krb5.pcap, the server responds to PUTFH with
NFS4ERR_STALE, so nothing to do with the open stateid sequencing.  I also=

see:

nfsd-1693    [000] .....  1951.353889: nfsd_exp_find_key: fsid=3D1::{0x0,=
0xe5fcf0,0xffffc900,0x811e87a3,0xffffffff,0xe5fd00} domain=3Dgss/krb5i st=
atus=3D-2
nfsd-1693    [000] .....  1951.353889: nfsd_set_fh_dentry_badexport: xid=3D=
0xe1511810 fh_hash=3D0x3f9e713a status=3D-2
nfsd-1693    [000] .....  1951.353890: nfsd_compound_status: op=3D2/4 OP_=
PUTFH status=3D70


=2E. so nfsd's exp_find_key() is having trouble and returns -ENOENT.  Doe=
s
this look familiar to anyone?

I am not as familiar with how the server operates here, so my next step
would be to start inserting trace_printk's into the kernel source to figu=
re
out what's going wrong in there.  However, we can also use the function
graph tracer to see where the kernel is going.  That would look like:

 echo exp_find_key > /sys/kernel/tracing/set_graph_function
 echo 7 > /sys/kernel/debug/tracing/max_graph_depth
 echo function_graph > /sys/kernel/debug/tracing/current_tracer
> /sys/kernel/debug/tracing/trace

 .. reproduce

 cat /sys/kernel/debut/tracing/trace

Hopefully someone with more knfsd/sunrpc experience recognizes this.. but=
 it
makes a lot more sense now that krb5 is part of the problem.

Ben

