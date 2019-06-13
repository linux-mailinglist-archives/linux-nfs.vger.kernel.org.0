Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E44D644155
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jun 2019 18:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730097AbfFMQNh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 13 Jun 2019 12:13:37 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:41092 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728995AbfFMQNe (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 13 Jun 2019 12:13:34 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5DG3ghr093935;
        Thu, 13 Jun 2019 16:13:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=DUnw9gPxCAoRYSC5GPHNdx9QjSmJyGyqaES7eAdtyE0=;
 b=QJLtOtmuxZ4pAEVY52+F5zTe0v2fp8cTAYr5KKKPk2B2HsCWxVdoc6urjzycttw4WETP
 UX1gxP/K3GhZaVSu7KgkupXjXbt5wIPG1j+Kurqxbwl73Wr7adMnHT86szzX95cNZZq+
 fm69ze7IYqAR1m8vLhCiPerK6gxnkUYdwjI8EiDuXpH4MnxBXqEq4osA4JffMGbOBDRF
 gtWgFN8QxqF6CiI6Azv9bWT51D+nHTRoyLNDX3Stk77512p5O11+oYNyqtq8vPQ+mO98
 pD+/SEF4/V5gRFl0vWgWsyES9/1whakdVxSzI32sGMGfGMovbEgjnt7w6lrHlVcr0n3J 6Q== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2t04eu2pr4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Jun 2019 16:13:22 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5DGCERh163425;
        Thu, 13 Jun 2019 16:13:21 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2t0p9sg92c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Jun 2019 16:13:21 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5DGDG7c010282;
        Thu, 13 Jun 2019 16:13:19 GMT
Received: from anon-dhcp-171.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 13 Jun 2019 09:13:16 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH 0/9] Multiple network connections for a single NFS mount.
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <87tvcuv225.fsf@notabene.neil.brown.name>
Date:   Thu, 13 Jun 2019 12:13:14 -0400
Cc:     Olga Kornievskaia <aglo@umich.edu>,
        Anna Schumaker <Anna.Schumaker@netapp.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <DE7C0924-1AE3-467C-B836-75D4676751EF@oracle.com>
References: <155917564898.3988.6096672032831115016.stgit@noble.brown>
 <001DED71-0E0D-46B1-BA34-84E6ACCBB79F@oracle.com>
 <87muj3tuuk.fsf@notabene.neil.brown.name>
 <4316E30B-1BD7-4F0E-8375-03E9F85FFD2B@oracle.com>
 <87lfy9vsgf.fsf@notabene.neil.brown.name>
 <3B887552-91FB-493A-8FDF-411562811B36@oracle.com>
 <CAN-5tyEdu7poNWrKtOyic6GgQcjAPZhB5BJeQ7JMSfmgMx8b+g@mail.gmail.com>
 <16D30334-67BE-4BD2-BE69-1453F738B259@oracle.com>
 <877e9rwuy5.fsf@notabene.neil.brown.name>
 <FAC8BAC4-5219-4B04-891F-FB640A010857@oracle.com>
 <87tvcuv225.fsf@notabene.neil.brown.name>
To:     NeilBrown <neilb@suse.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9286 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906130119
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9286 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906130119
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jun 12, 2019, at 7:03 PM, NeilBrown <neilb@suse.com> wrote:
> 
> On Wed, Jun 12 2019, Chuck Lever wrote:
> 
>> Hi Neil-
>> 
>>> On Jun 11, 2019, at 7:42 PM, NeilBrown <neilb@suse.com> wrote:
>>> 
>>> On Tue, Jun 11 2019, Chuck Lever wrote:
>>> 
>>>> 
>>>> Earlier in this thread, Neil proposed to make nconnect a hint. Sounds
>>>> like the long term plan is to allow "up to N" connections with some
>>>> mechanism to create new connections on-demand." maxconn fits that idea
>>>> better, though I'd prefer no new mount options... the point being that
>>>> eventually, this setting is likely to be an upper bound rather than a
>>>> fixed value.
>>> 
>>> When I suggested making at I hint, I considered and rejected the the
>>> idea of making it a maximum.  Maybe I should have been explicit about
>>> that.
>>> 
>>> I think it *is* important to be able to disable multiple connections,
>>> hence my suggestion that "nconnect=1", as a special case, could be a
>>> firm maximum.
>>> My intent was that if nconnect was not specified, or was given a larger
>>> number, then the implementation should be free to use however many
>>> connections it chose from time to time.  The number given would be just
>>> a hint - maybe an initial value.  Neither a maximum nor a minimum.
>>> Maybe we should add "nonconnect" (or similar) to enforce a single
>>> connection, rather than overloading "nconnect=1"
>> 
>> So then I think, for the immediate future, you want to see nconnect=
>> specify the exact number of connections that will be opened. (later
>> it can be something the client chooses automatically). IIRC that's
>> what Trond's patches already do.
>> 
>> Actually I prefer that the default behavior be the current behavior,
>> where the client uses one connection per client-server pair. That
>> serves the majority of use cases well enough. Saying that default is
>> nconnect=1 is then intuitive to understand.
>> 
>> At some later point if we convince ourselves that a higher default
>> is safe (ie, does not result in performance regressions in some cases)
>> then raise the default to nconnect=2 or 3.
>> 
>> I'm not anxious to allow everyone to open an unlimited number of
>> connections just yet. That has all kinds of consequences for servers,
>> privileged port consumption, etc, etc. I'm not wont to hand an
>> unlimited capability to admins who are not NFS-savvy in the name of
>> experimentation. That will just make for more phone calls to our
>> support centers and possibly some annoyed storage administrators.
>> And it seems like something that can be abused pretty easily by
>> certain ne'er-do-wells.
> 
> I'm sorry, but this comes across to me as very paternalistic.
> It is not our place to stop people shooting themselves in the foot.
> It *is* our place to avoid security vulnerabilities, but not to prevent
> a self-inflicted denial of service.

It is our place to try to prevent an easily predictable DoS of an
NFS server. In fact, this is a security review question asked of
every new IETF protocol: how can the protocol or implementation
be abused to cause DoS attacks? It would be irresponsible to
ignore this issue.


> And no-one is suggesting unlimited (even Solaris limits clnt_max_conns to
> 2^31-1).  I'm suggesting 256.
> If you like, we can make the limit a module parameter so distros can
> easily tune it down.  But I'm strongly against imposing a hard limit of
> 4 or even 8.

There are many reasons an initial lower maximum is wise.

- O_DIRECT was designed to enable direct I/O for particular files
instead of a whole mount point (as Solaris does), in part because we
didn't want to overrun a server with FILE_SYNC WRITE requests. I'm
thinking of this precedent mainly when suggesting a lower limit.

- SMB uses a low maximum for good reasons.

- Solaris may be architected for a very high limit, but they never
test with or recommend larger than 8.

- Practically speaking we really do need to care about our support
centers. Adding tunables that will initiate more calls and e-mails
is an avoidable error with a real monetary cost.

- Linux NFS clients work in cloud environments. We have to focus on
being good neighbors. We are not providing much guidance (if any)
on how to determine a good value for this setting. Tenants will likely
just crank it up and leave it, which will be bad for shared
infrastructure.

- A mount option instead of a more obscure interface makes it very
easy to abuse.

- Anyone who is interested in testing a large value can rebuild
their kernel as needed because this is open source, after all.

- It is very easy to raise the maximum later. As I have said all
along, I'm not talking about a permanent cap, but one that allows us
to roll out the benefits gradually while minimizing risks.

- As filesystem architects, data integrity is our priority. Performance
is an important, but always secondary, goal.

- Can we add nconnect to the community Continuous Integration testing
rigs and regularly test with large values as well as the values that
are going to be used commonly?

Do any of these reasons smack of paternalism?


>> Starting with a maximum of 3 or 4 is conservative yet exposes immediate
>> benefits. The default connection behavior remains the same. No surprises
>> when a stock Linux NFS client is upgraded to a kernel that supports
>> nconnect.
>> 
>> The maximum setting can be raised once we understand the corner cases,
>> the benefits, and the pitfalls.
> 
> I'm quite certain that some customers will have much more performant
> hardware than any of us might have in the lab.  They will be the ones to
> reap the benefits and find the corner cases and pitfalls.  We need to let
> them.

IMO, merging multi-flow is good enough to do that. If they want to
experiment with it, they can make their own modifications, raise
the maximum, or whatever. I'm very happy to enable that kind of
experimentation and anxiously await their results.

We're supposed to optimize for the common case. The common case
here is nconnect=1, by far. Many users will never change this setting,
and most who do will need only 2 or 3 connections before they see no
more gain, I predict.


>>> You have said elsewhere that you would prefer configuration in a config
>>> file rather than as a mount option.
>>> How do you imagine that configuration information getting into the
>>> kernel?
>> 
>> I'm assuming Trond's design, where the kernel RPC client upcalls to
>> a user space agent (a new daemon, or request-key).
>> 
>> 
>>> Do we create /sys/fs/nfs/something?  or add to /proc/sys/sunrpc
>>> or /proc/net/rpc .... we have so many options !!
>>> There is even /sys/kernel/debug/sunrpc/rpc_clnt, but that is not
>>> a good place for configuration.
>>> 
>>> I suspect that you don't really have an opinion, you just don't like the
>>> mount option.  However I don't have that luxury.  I need to put the
>>> configuration somewhere.  As it is per-server configuration the only
>>> existing place that works at all is a mount option.
>>> While that might not be ideal, I do think it is most realistic.
>>> Mount options can be deprecated, and carrying support for a deprecated
>>> mount option is not expensive.
>> 
>> It's not deprecation that worries me, it's having to change the
>> mount option; and the fact that we already believe it will have to
>> change makes it especially worrisome that we are picking the wrong
>> horse at the start.
>> 
>> NFS mount options will appear in automounter maps for a very long
>> time. They will be copied to other OSes. Deprecation is more
>> expensive than you might at first think.
> 
> automounter maps are a good point .... if this functionality isn't
> supported as a mount option, how does someone who uses automounter maps
> roll it out?
> 
>> 
>> 
>>> The option still can be placed in a per-server part of
>>> /etc/nfsmount.conf rather than /etc/fstab, if that is what a sysadmin
>>> wants to do.
>> 
>> I don't see that having a mount option /and/ a configuration file
>> addresses Trond's concern about config pulverization. It makes it
>> worse, in fact. But my fundamental problem is with a per-server
>> setting specified as a per-mount option. Using a config file is
>> just a possible way to address that problem.
>> 
>> For a moment, let's turn the mount option idea on its head. Another
>> alternative would be to make nconnect into a real per-mount setting
>> instead of a per-server setting.
>> 
>> So now each mount gets to choose the number of connections it is
>> permitted to use. Suppose we have three concurrent mounts:
>> 
>>   mount -o nconnect=3 server1:/export /mnt/one
>>   mount server2:/export /mnt/two
>>   mount -o nconnect=2 server3:/export /mnt/three
>> 
>> The client opens the maximum of the three nconnect values, which
>> is 3. Then:
>> 
>> Traffic to server2 may use only one of these connections. Traffic
>> to server3 may use no more than two of those connections. Traffic
>> to server1 may use all three of those connections.
>> 
>> Does that make more sense than a per-server setting? Is it feasible
>> to implement?
> 
> If the servers are distinct, then the connections to them must be
> distinct, so no sharing happens here.
> 
> But I suspect you meant to have three mounts from the same server, each
> with different nconnect values.
> So 3 connections are created:
>  /mnt/one is allowed all of them
>  /mnt/two is allowed to use only one
>  /mnt/three is allowed to use only two

Yes, sorry for the confusion.


> Which one or two?  Can /mnt/two use any one as long as it only uses one
> at a time, or must it choose one up front and stick to that?
> Can /mnt/three arrange to use the two that /mnt/two isn't using?
> 
> I think the easiest, and possibly most obvious, would be that each used
> the "first" N connections.  So the third connection would only ever be
> used by /mnt/one.  Load-balancing would be interesting, but not
> impossible.  It might lead to /mnt/one preferentially using the third
> connection because it has exclusive access.
> 
> I don't think this complexity gains us anything.

A per-mount setting makes the administrative interface intuitive and
the resulting behavior and performance is predictable.

With nconnect as a per-server option, all mounts of that server get
the nconnect value of the first mount. If mount ordering isn't
fixed (say, automounted based on user workload) then performance
will vary.


> A different approach would be have the number of connections to each
> server be the maximum number that any mount requested.  Then all mounts
> use all connections.
> 
> So when /mnt/one is mounted, three connections are established, and they
> are all used by /mnt/two and /mnt/three.  But if /mnt/one is unmounted,
> then the third connection is closed (once it becomes idle) and /mnt/two
> and /mnt/three continue using just two connections.
> 
> Adding a new connection is probably quite easy.  Deleting a connection
> is probably a little less straight forward, but should be manageable.
> 
> How would you feel about that approach?

Performance/scalability still varies depending on the order of the
mount operations.

The Solaris mechanism sets a global nconnect value for all mounted
servers, connections are created on-demand, and requests are round-
robin'd over the open connections.

Perhaps that is not granular enough for us, but once that setting is
changed, performance and scalability is predictable.


--
Chuck Lever



