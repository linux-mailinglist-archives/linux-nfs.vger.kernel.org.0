Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E79A5425EF
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Jun 2019 14:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728091AbfFLMeg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 12 Jun 2019 08:34:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49815 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726716AbfFLMeg (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 12 Jun 2019 08:34:36 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D178B307D935;
        Wed, 12 Jun 2019 12:34:33 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-116-232.phx2.redhat.com [10.3.116.232])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8EA6E7BE8F;
        Wed, 12 Jun 2019 12:34:28 +0000 (UTC)
Subject: Re: [PATCH 0/9] Multiple network connections for a single NFS mount.
To:     Trond Myklebust <trondmy@hammerspace.com>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "aglo@umich.edu" <aglo@umich.edu>,
        "Anna.Schumaker@netapp.com" <Anna.Schumaker@netapp.com>,
        "neilb@suse.com" <neilb@suse.com>
References: <155917564898.3988.6096672032831115016.stgit@noble.brown>
 <001DED71-0E0D-46B1-BA34-84E6ACCBB79F@oracle.com>
 <87muj3tuuk.fsf@notabene.neil.brown.name>
 <4316E30B-1BD7-4F0E-8375-03E9F85FFD2B@oracle.com>
 <87lfy9vsgf.fsf@notabene.neil.brown.name>
 <3B887552-91FB-493A-8FDF-411562811B36@oracle.com>
 <6693beb0989c83580235526e3d1b54fad0920d82.camel@hammerspace.com>
 <35A94418-7DE0-4656-90B4-5A0183BA371C@oracle.com>
 <266475174966dd473670d9fc9f6a6d6af3d87d44.camel@hammerspace.com>
 <217DDDDE-AA6D-47C8-AFC8-99548F29E1C2@oracle.com>
 <6a4ace315ee7f9c72e4866384fcb800707a4cbe4.camel@hammerspace.com>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <b3a9a877-a348-b680-6eb5-e10019ba46b7@RedHat.com>
Date:   Wed, 12 Jun 2019 08:34:28 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <6a4ace315ee7f9c72e4866384fcb800707a4cbe4.camel@hammerspace.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Wed, 12 Jun 2019 12:34:36 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 6/11/19 1:44 PM, Trond Myklebust wrote:
> On Tue, 2019-06-11 at 13:32 -0400, Chuck Lever wrote:
>>> On Jun 11, 2019, at 12:41 PM, Trond Myklebust <
>>> trondmy@hammerspace.com> wrote:
>>>
>>> On Tue, 2019-06-11 at 11:35 -0400, Chuck Lever wrote:
>>>>> On Jun 11, 2019, at 11:20 AM, Trond Myklebust <
>>>>> trondmy@hammerspace.com> wrote:
>>>>>
>>>>> On Tue, 2019-06-11 at 10:51 -0400, Chuck Lever wrote:
>>>>>
>>>>>> If maxconn is a hint, when does the client open additional
>>>>>> connections?
>>>>>
>>>>> As I've already stated, that functionality is not yet
>>>>> available.
>>>>> When
>>>>> it is, it will be under the control of a userspace daemon that
>>>>> can
>>>>> decide on a policy in accordance with a set of user specified
>>>>> requirements.
>>>>
>>>> Then why do we need a mount option at all?
>>>>
>>>
>>> For one thing, it allows people to play with this until we have a
>>> fully
>>> automated solution. The fact that people are actually pulling down
>>> these patches, forward porting them and trying them out would
>>> indicate
>>> that there is interest in doing so.
>>
>> Agreed that it demonstrates that folks are interested in having
>> multiple connections. I count myself among them.
>>
>>
>>> Secondly, if your policy is 'I just want n connections' because
>>> that
>>> fits your workload requirements (e.g. because said workload is both
>>> latency sensitive and bursty), then a daemon solution would be
>>> unnecessary, and may be error prone.
>>
>> Why wouldn't that be the default out-of-the-shrinkwrap configuration
>> that is installed by nfs-utils?
> 
> What is the point of forcing people to run a daemon if all they want to
> do is set up a fixed number of connections?
> 
>>
>>> A mount option is helpful in this case, because you can perform the
>>> setup through the normal fstab or autofs config file configuration
>>> route. It also make sense if you have a nfsroot setup.
>>
>> NFSROOT is the only usage scenario where I see a mount option being
>> a superior administrative interface. However I don't feel that
>> NFSROOT is going to host workloads that would need multiple
>> connections. KIS
>>
>>
>>> Finally, even if you do want to have a daemon manage your
>>> transport,
>>> configuration, you do want a mechanism to help it reach an
>>> equilibrium
>>> state quickly. Connections take time to bring up and tear down
>>> because
>>> performance measurements take time to build up sufficient
>>> statistical
>>> precision. Furthermore, doing so comes with a number of hidden
>>> costs,
>>> e.g.: chewing up privileged port numbers by putting them in a
>>> TIME_WAIT
>>> state. If you know that a given server is always subject to heavy
>>> traffic, then initialising the number of connections appropriately
>>> has
>>> value.
>>
>> Again, I don't see how this is not something a config file can do.
> 
> You can, but that means you have to keep said config file up to date
> with the contents of /etc/fstab etc. Pulverising configuration into
> little bits and pieces that are scattered around in different files is
> not a user friendly interface either.
> 
>> The stated intent of "nconnect" way back when was for
>> experimentation.
>> It works great for that!
>>
>> I don't see it as a desirable long-term administrative interface,
>> though. I'd rather not nail in a new mount option that we actually
>> plan to obsolete in favor of an automated mechanism. I'd rather see
>> us design the administrative interface with automation from the
>> start. That will have a lower long-term maintenance cost.
>>
>> Again, I'm not objecting to support for multiple connections. It's
>> just that adding a mount option doesn't feel like a friendly or
>> finished interface for actual users. A config file (or re-using
>> nfs.conf) seems to me like a better approach.
> 
> nfs.conf is great for defining global defaults.
> 
> It can do server specific configuration, but is not a popular solution
> for that. Most people are still putting that information in /etc/fstab
> so that it appears in one spot.
> 
What about nfsmount.conf? That seems like a more reasonable place
to define how mounts should work... 

steved.
