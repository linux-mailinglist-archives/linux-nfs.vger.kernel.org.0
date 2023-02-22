Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8C4E69F4D7
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Feb 2023 13:48:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231356AbjBVMsR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 22 Feb 2023 07:48:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjBVMsQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 22 Feb 2023 07:48:16 -0500
Received: from mailrelay.rz.uni-wuerzburg.de (wrz3035.rz.uni-wuerzburg.de [132.187.3.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F151F5D5
        for <linux-nfs@vger.kernel.org>; Wed, 22 Feb 2023 04:48:13 -0800 (PST)
Received: from virusscan-slb.rz.uni-wuerzburg.de (localhost [127.0.0.1])
        by mailrelay-slb.rz.uni-wuerzburg.de (Postfix) with ESMTP id 1DCFCF56B;
        Wed, 22 Feb 2023 13:48:12 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by virusscan-slb.rz.uni-wuerzburg.de (Postfix) with ESMTP id 1C859F565;
        Wed, 22 Feb 2023 13:48:12 +0100 (CET)
X-Virus-Scanned: amavisd-new at uni-wuerzburg.de
Received: from mailmaster.uni-wuerzburg.de ([127.0.0.1])
        by localhost (vmail001.slb.uni-wuerzburg.de [127.0.0.1]) (amavisd-new, port 10225)
        with ESMTP id Rb4IyB7sfsj8; Wed, 22 Feb 2023 13:48:12 +0100 (CET)
Received: from [132.187.207.113] (wma7113.mathematik.uni-wuerzburg.de [132.187.207.113])
        by mailmaster.uni-wuerzburg.de (Postfix) with ESMTPSA id CD7CCF540;
        Wed, 22 Feb 2023 13:48:11 +0100 (CET)
Message-ID: <550d9137-8d59-5be1-23be-34c6e1dff99a@mathematik.uni-wuerzburg.de>
Date:   Wed, 22 Feb 2023 13:48:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: Reoccurring 5 second delays during NFS calls
Content-Language: de-DE
To:     Jeff Layton <jlayton@kernel.org>,
        Benjamin Coddington <bcodding@redhat.com>
Cc:     linux-nfs@vger.kernel.org,
        Andreas Seeg <andreas.seeg@mathematik.uni-wuerzburg.de>
References: <59682160-a246-395a-9486-9bbf11686740@mathematik.uni-wuerzburg.de>
 <8a02c86882bc47c1c1387dba8c7d756237cb3f3f.camel@kernel.org>
 <3b6c9b8e-2795-74e8-aefa-d4f1ac007c3c@mathematik.uni-wuerzburg.de>
 <785052D6-E39F-40D3-8BA3-72D3940EDD84@redhat.com>
 <7c7de5f1-fb6a-e970-99a2-4880583d8f6d@mathematik.uni-wuerzburg.de>
 <1B586C15-908C-4B00-9739-9AD118F88BD4@redhat.com>
 <4f70c2f5-dfdb-c37c-8663-5f2a108e229e@mathematik.uni-wuerzburg.de>
 <5AB8B0FE-5D7E-4ED4-9537-979341C6371A@redhat.com>
 <90861fe9716ab35f52b136f533ac693eb3d86279.camel@kernel.org>
From:   =?UTF-8?Q?Florian_M=c3=b6ller?= 
        <fmoeller@mathematik.uni-wuerzburg.de>
In-Reply-To: <90861fe9716ab35f52b136f533ac693eb3d86279.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Am 22.02.23 um 13:22 schrieb Jeff Layton:
> On Wed, 2023-02-22 at 06:54 -0500, Benjamin Coddington wrote:
>> On 22 Feb 2023, at 3:19, Florian Möller wrote:
>>
>>> Am 21.02.23 um 19:58 schrieb Benjamin Coddington:
>>>> On 21 Feb 2023, at 11:52, Florian Möller wrote:
>>>>
>>>>> Hi Benjamin,
>>>>>
>>>>> here are the trace and a listing of the corresponding network packages. If the listing is not detailed enough, I can send you a full package dump tomorrow.
>>>>>
>>>>> The command I used was
>>>>>
>>>>> touch test.txt && sleep 2 && touch test.txt
>>>>>
>>>>> test.txt did not exist previously. So you have an example of a touch without and with delay.
>>>>
>>>> Thanks!  These are great - I can see from them that the client is indeed
>>>> waiting in the stateid update mechanism because the server has returned
>>>> NFS4ERR_STALE to the client's first CLOSE.
>>>>
>>>> That is unusual.  The server is signaling that the open file's stateid is old,
>>>> so I am interested to see if the first CLOSE is sent with the stateid's
>>>> sequence that was returned from the server.  I could probably see this if I
>>>> had the server-side tracepoint data.
>>>
>>> Hi Benjamin,
>>>
>>> the server-side tracepoints
>>>
>>> nfsd:nfsd_preprocess
>>> sunrpc:svc_process
>>>
>>> were enabled. It seems they did not produce any output.
>>>
>>> What I did now was:
>>> - enable all nfsd tracepoints,
>>> - enable all nfs4 tracepoints,
>>> - enable all sunrpc tracepoints.
>>>
>>> The command I used was
>>>
>>> touch somefile && sleep 2 && touch somefile.
>>>
>>> Then I unmounted the NFS share - this also causes a delay.
>>>
>>> I changed the security type to krb5 and captured trace and network output for a version 4.0 and a version 4.2 mount. The delay does not occur when using version 4.0.
>>
>>
>> In frame 9 of nfs-v4.2-krb5.pcap, the server responds to PUTFH with
>> NFS4ERR_STALE, so nothing to do with the open stateid sequencing.  I also
>> see:
>>
>> nfsd-1693    [000] .....  1951.353889: nfsd_exp_find_key: fsid=1::{0x0,0xe5fcf0,0xffffc900,0x811e87a3,0xffffffff,0xe5fd00} domain=gss/krb5i status=-2
>> nfsd-1693    [000] .....  1951.353889: nfsd_set_fh_dentry_badexport: xid=0xe1511810 fh_hash=0x3f9e713a status=-2
>> nfsd-1693    [000] .....  1951.353890: nfsd_compound_status: op=2/4 OP_PUTFH status=70
>>
> 
> This just means that the kernel called into the "cache" infrastructure
> to find an export entry, and there wasn't one.
> 
> 
> Looking back at the original email here, I'd say this is expected since
> the export wasn't set up for krb5i.
> 
> Output of exportfs -v:
> /export
> gss/krb5p(async,wdelay,hide,crossmnt,no_subtree_check,fsid=0,sec=sys,rw,secure,root_squash,no_all_squash)
> /export
> gss/krb5(async,wdelay,hide,crossmnt,no_subtree_check,fsid=0,sec=sys,rw,secure,root_squash,no_all_squash)

I changed the export definitions to

/export 
gss/krb5(async,wdelay,hide,crossmnt,no_subtree_check,fsid=0,sec=sys,rw,secure,root_squash,no_all_squash)
/export 
gss/krb5i(async,wdelay,hide,crossmnt,no_subtree_check,fsid=0,sec=sys,rw,secure,root_squash,no_all_squash)
/export 
gss/krb5p(async,wdelay,hide,crossmnt,no_subtree_check,fsid=0,sec=sys,rw,secure,root_squash,no_all_squash)

such that all three kerberos security types are exported. With this setup the 
delay is gone. Without the krb5i export the delay occurs again.
Mounting the NFS share with different kerberos security types does not change 
this behaviour - without the krb5i export there is a delay.

Best,
Florian



> 
> 
>>
>> .. so nfsd's exp_find_key() is having trouble and returns -ENOENT.  Does
>> this look familiar to anyone?
>>
>> I am not as familiar with how the server operates here, so my next step
>> would be to start inserting trace_printk's into the kernel source to figure
>> out what's going wrong in there.  However, we can also use the function
>> graph tracer to see where the kernel is going.  That would look like:
>>
>>   echo exp_find_key > /sys/kernel/tracing/set_graph_function
>>   echo 7 > /sys/kernel/debug/tracing/max_graph_depth
>>   echo function_graph > /sys/kernel/debug/tracing/current_tracer
>>> /sys/kernel/debug/tracing/trace
>>
>>   .. reproduce
>>
>>   cat /sys/kernel/debut/tracing/trace
>>
>> Hopefully someone with more knfsd/sunrpc experience recognizes this.. but it
>> makes a lot more sense now that krb5 is part of the problem.
>>
>> Ben
>>
> 

-- 
Dr. Florian Möller
Universität Würzburg
Institut für Mathematik
Emil-Fischer-Straße 30
97074 Würzburg, Germany
Tel. +49 931 3185596

