Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C692042D9F
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Jun 2019 19:39:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726091AbfFLRjO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 12 Jun 2019 13:39:14 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:56814 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbfFLRjO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 12 Jun 2019 13:39:14 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5CHYHCB035867;
        Wed, 12 Jun 2019 17:39:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=qG486mRsynzmYZLaWOV2FUpF7/fhrlh6o5X89ilM7mY=;
 b=D+IQSkCjFwrODW0w7ODLn52VbBK522saUstPJkSL/2j2k64RN0aLQcbtgOTgCzkrU5zi
 Z8zToyDSn27Fs17Zj0ssUAQEsnRjB91B+jEnl0BwUWPvIYNBuSfu3192UaY3KG0M6gK2
 9Vk8lFQsXy6EsC8V8+EMs1FJumjw8kC8HbvFo0EezrgNWoT1mfsAyJtP2FgNUvCpA601
 2hFchSh+qJW4aUacWHt775g/GDiQG6RkJ4MvqToJdumawDhTPpoYTSvjn4qDEjrWxkt2
 hKi3kD8mTzIr5JtHirqVR5qaeYWtMyw4aKsf24KC0A6wloU8GvYbOskPsKlMH8sorUu/ 5g== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2t05nqvyq1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Jun 2019 17:39:01 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5CHaCW7068557;
        Wed, 12 Jun 2019 17:37:00 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2t0p9s09rs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Jun 2019 17:37:00 +0000
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5CHauaX004789;
        Wed, 12 Jun 2019 17:37:00 GMT
Received: from anon-dhcp-171.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 12 Jun 2019 10:36:56 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH 0/9] Multiple network connections for a single NFS mount.
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <877e9rwuy5.fsf@notabene.neil.brown.name>
Date:   Wed, 12 Jun 2019 13:36:54 -0400
Cc:     Olga Kornievskaia <aglo@umich.edu>,
        Anna Schumaker <Anna.Schumaker@netapp.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <FAC8BAC4-5219-4B04-891F-FB640A010857@oracle.com>
References: <155917564898.3988.6096672032831115016.stgit@noble.brown>
 <001DED71-0E0D-46B1-BA34-84E6ACCBB79F@oracle.com>
 <87muj3tuuk.fsf@notabene.neil.brown.name>
 <4316E30B-1BD7-4F0E-8375-03E9F85FFD2B@oracle.com>
 <87lfy9vsgf.fsf@notabene.neil.brown.name>
 <3B887552-91FB-493A-8FDF-411562811B36@oracle.com>
 <CAN-5tyEdu7poNWrKtOyic6GgQcjAPZhB5BJeQ7JMSfmgMx8b+g@mail.gmail.com>
 <16D30334-67BE-4BD2-BE69-1453F738B259@oracle.com>
 <877e9rwuy5.fsf@notabene.neil.brown.name>
To:     NeilBrown <neilb@suse.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9286 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906120119
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9286 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906120119
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Neil-

> On Jun 11, 2019, at 7:42 PM, NeilBrown <neilb@suse.com> wrote:
> 
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

So then I think, for the immediate future, you want to see nconnect=
specify the exact number of connections that will be opened. (later
it can be something the client chooses automatically). IIRC that's
what Trond's patches already do.

Actually I prefer that the default behavior be the current behavior,
where the client uses one connection per client-server pair. That
serves the majority of use cases well enough. Saying that default is
nconnect=1 is then intuitive to understand.

At some later point if we convince ourselves that a higher default
is safe (ie, does not result in performance regressions in some cases)
then raise the default to nconnect=2 or 3.

I'm not anxious to allow everyone to open an unlimited number of
connections just yet. That has all kinds of consequences for servers,
privileged port consumption, etc, etc. I'm not wont to hand an
unlimited capability to admins who are not NFS-savvy in the name of
experimentation. That will just make for more phone calls to our
support centers and possibly some annoyed storage administrators.
And it seems like something that can be abused pretty easily by
certain ne'er-do-wells.

Starting with a maximum of 3 or 4 is conservative yet exposes immediate
benefits. The default connection behavior remains the same. No surprises
when a stock Linux NFS client is upgraded to a kernel that supports
nconnect.

The maximum setting can be raised once we understand the corner cases,
the benefits, and the pitfalls.


> You have said elsewhere that you would prefer configuration in a config
> file rather than as a mount option.
> How do you imagine that configuration information getting into the
> kernel?

I'm assuming Trond's design, where the kernel RPC client upcalls to
a user space agent (a new daemon, or request-key).


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

It's not deprecation that worries me, it's having to change the
mount option; and the fact that we already believe it will have to
change makes it especially worrisome that we are picking the wrong
horse at the start.

NFS mount options will appear in automounter maps for a very long
time. They will be copied to other OSes. Deprecation is more
expensive than you might at first think.


> The option still can be placed in a per-server part of
> /etc/nfsmount.conf rather than /etc/fstab, if that is what a sysadmin
> wants to do.

I don't see that having a mount option /and/ a configuration file
addresses Trond's concern about config pulverization. It makes it
worse, in fact. But my fundamental problem is with a per-server
setting specified as a per-mount option. Using a config file is
just a possible way to address that problem.

For a moment, let's turn the mount option idea on its head. Another
alternative would be to make nconnect into a real per-mount setting
instead of a per-server setting.

So now each mount gets to choose the number of connections it is
permitted to use. Suppose we have three concurrent mounts:

   mount -o nconnect=3 server1:/export /mnt/one
   mount server2:/export /mnt/two
   mount -o nconnect=2 server3:/export /mnt/three

The client opens the maximum of the three nconnect values, which
is 3. Then:

Traffic to server2 may use only one of these connections. Traffic
to server3 may use no more than two of those connections. Traffic
to server1 may use all three of those connections.

Does that make more sense than a per-server setting? Is it feasible
to implement?


--
Chuck Lever



