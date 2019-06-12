Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9948142616
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Jun 2019 14:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727762AbfFLMjh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 12 Jun 2019 08:39:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54844 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727047AbfFLMjh (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 12 Jun 2019 08:39:37 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 31A7880F7C;
        Wed, 12 Jun 2019 12:39:31 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-116-232.phx2.redhat.com [10.3.116.232])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A8457614C4;
        Wed, 12 Jun 2019 12:39:28 +0000 (UTC)
Subject: Re: [PATCH 0/9] Multiple network connections for a single NFS mount.
To:     NeilBrown <neilb@suse.com>, Chuck Lever <chuck.lever@oracle.com>,
        Olga Kornievskaia <aglo@umich.edu>
Cc:     Anna Schumaker <Anna.Schumaker@netapp.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <155917564898.3988.6096672032831115016.stgit@noble.brown>
 <001DED71-0E0D-46B1-BA34-84E6ACCBB79F@oracle.com>
 <87muj3tuuk.fsf@notabene.neil.brown.name>
 <4316E30B-1BD7-4F0E-8375-03E9F85FFD2B@oracle.com>
 <87lfy9vsgf.fsf@notabene.neil.brown.name>
 <3B887552-91FB-493A-8FDF-411562811B36@oracle.com>
 <CAN-5tyEdu7poNWrKtOyic6GgQcjAPZhB5BJeQ7JMSfmgMx8b+g@mail.gmail.com>
 <16D30334-67BE-4BD2-BE69-1453F738B259@oracle.com>
 <877e9rwuy5.fsf@notabene.neil.brown.name>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <e4b6f790-c87c-5839-2de5-67ec561cda3d@RedHat.com>
Date:   Wed, 12 Jun 2019 08:39:28 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <877e9rwuy5.fsf@notabene.neil.brown.name>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Wed, 12 Jun 2019 12:39:36 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 6/11/19 7:42 PM, NeilBrown wrote:
> On Tue, Jun 11 2019, Chuck Lever wrote:
> 
>>
>> Earlier in this thread, Neil proposed to make nconnect a hint. Sounds
>> like the long term plan is to allow "up to N" connections with some
>> mechanism to create new connections on-demand." maxconn fits that idea
>> better, though I'd prefer no new mount options... the point being that
>> eventually, this setting is likely to be an upper bound rather than a
>> fixed value.
> 
> When I suggested making at I hint, I considered and rejected the the
> idea of making it a maximum.  Maybe I should have been explicit about
> that.
> 
> I think it *is* important to be able to disable multiple connections,
> hence my suggestion that "nconnect=1", as a special case, could be a
> firm maximum.
> My intent was that if nconnect was not specified, or was given a larger
> number, then the implementation should be free to use however many
> connections it chose from time to time.  The number given would be just
> a hint - maybe an initial value.  Neither a maximum nor a minimum.
> Maybe we should add "nonconnect" (or similar) to enforce a single
> connection, rather than overloading "nconnect=1"
> 
> You have said elsewhere that you would prefer configuration in a config
> file rather than as a mount option.
> How do you imagine that configuration information getting into the
> kernel?
> Do we create /sys/fs/nfs/something?  or add to /proc/sys/sunrpc
> or /proc/net/rpc .... we have so many options !!
> There is even /sys/kernel/debug/sunrpc/rpc_clnt, but that is not
> a good place for configuration.
> 
> I suspect that you don't really have an opinion, you just don't like the
> mount option.  However I don't have that luxury.  I need to put the
> configuration somewhere.  As it is per-server configuration the only
> existing place that works at all is a mount option.
> While that might not be ideal, I do think it is most realistic.
> Mount options can be deprecated, and carrying support for a deprecated
> mount option is not expensive.
> 
> The option still can be placed in a per-server part of
> /etc/nfsmount.conf rather than /etc/fstab, if that is what a sysadmin
> wants to do.
+1 making it per-server is the way to go... IMHO... 

steved.

