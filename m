Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25B32210601
	for <lists+linux-nfs@lfdr.de>; Wed,  1 Jul 2020 10:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728538AbgGAITD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-nfs@lfdr.de>); Wed, 1 Jul 2020 04:19:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728416AbgGAITD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 1 Jul 2020 04:19:03 -0400
X-Greylist: delayed 308 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 01 Jul 2020 01:19:02 PDT
Received: from mail.lysator.liu.se (mail.lysator.liu.se [IPv6:2001:6b0:17:f0a0::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D10B1C061755
        for <linux-nfs@vger.kernel.org>; Wed,  1 Jul 2020 01:19:02 -0700 (PDT)
Received: from mail.lysator.liu.se (localhost [127.0.0.1])
        by mail.lysator.liu.se (Postfix) with ESMTP id DBE2D4005C
        for <linux-nfs@vger.kernel.org>; Wed,  1 Jul 2020 10:13:50 +0200 (CEST)
Received: by mail.lysator.liu.se (Postfix, from userid 1004)
        id C9E1340059; Wed,  1 Jul 2020 10:13:50 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
        bernadotte.lysator.liu.se
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=5.0 tests=ALL_TRUSTED,AWL
        autolearn=disabled version=3.4.2
X-Spam-Score: -1.0
Received: from [192.168.1.132] (h-201-140.A785.priv.bahnhof.se [98.128.201.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.lysator.liu.se (Postfix) with ESMTPSA id 0594E40014;
        Wed,  1 Jul 2020 10:13:49 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH v2] Strange segmentation violations of rpc.gssd in Debian
 Buster
From:   Peter Eriksson <pen@lysator.liu.se>
In-Reply-To: <94422f073b7e4b979931e6d8d3a0c044@tu-berlin.de>
Date:   Wed, 1 Jul 2020 10:13:49 +0200
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <53FF5C99-03FB-492D-9132-08775F29AB9A@lysator.liu.se>
References: <28a44712b25c4420909360bd813f8bfd@tu-berlin.de>
 <20200620170316.GH1514@fieldses.org>
 <5c45562c90404838944ee71a1d926c74@tu-berlin.de>
 <20200622223628.GC11051@fieldses.org>
 <406fe972135846dc8a23b60be59b0590@tu-berlin.de>
 <1527b158-3404-168c-8908-de4b8a709ccd@nazar.ca>
 <e9de5046e7734e728e64b386314a5d2e@tu-berlin.de>
 <c1c314fd-1855-cf04-3ec5-5f6eb35719a5@nazar.ca>
 <20200626194622.GB11850@fieldses.org>
 <3eb80b1f-e4d3-e87c-aacd-34dc28637948@nazar.ca>
 <20200626210243.GD11850@fieldses.org>
 <bebca60d-09e4-f118-c195-c6245e6496fb@nazar.ca>
 <6cf63c80f285495d8328c5c8b55fc9d6@tu-berlin.de>
 <41614030-a616-1ad0-280c-7e24342cd455@nazar.ca>
 <94422f073b7e4b979931e6d8d3a0c044@tu-berlin.de>
To:     "Kraus, Sebastian" <sebastian.kraus@tu-berlin.de>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


>>> I've found one other place that has insufficient locking but the race to hit it is fairly small. It's in the Kerberos machine principal cache when it refreshes the machine credentials. 
> These type of patches are always welcome. :-)
> In the recent past, some of our scientific staff exprienced strange problems with Kerberos authentication against our NFSv4 file servers. 
> Maybe, the outages were in connection with this type of race condition. But, I do not know for sure as the authentication errors did happen on a rather sporadic basis.

We (Linköping University in Sweden) have seen these problems before too. I sent a patch for rpc.gssd this spring that “fixed” this problem too (well, fixed the symptom and not the root cause so it wasn’t the right fix). Without that patch we typically had rpc.gssd crash on our multiuser client servers every other day. It was partly masked by Puppet detecting it down and restarting it but the users had strange errors that they reported and then when the support folks checked everything was running :-). It also crashed very often on a set of test machines that every minute would connect to our NFS servers in order to verify that they were running and giving good response times. Multiple NFS connections being set up and teared with concurrently many times easily forced this problem to happen after a day or two.


> A question far apart from this:
> How is it about the spread of NFSv4+Kerberos setups within academic community and commerical environments? 

We are using NFSv4+Kerberos. Most of our users are SMBv3 clients (Windows & Mac, 10x the Linux users) though but we have some 600 NFS clients (99.9% Linux (CentOS & Ubuntu mostly) based, servers are FreeBSD with ZFS). We used to be a big Sun/Solaris NFS shop previously so NFS comes “naturally” for us :-)

(Would have loved to use NFSv4+Kerberos on the MacOS clients but unfortunately MacOS panics when the Kerberos ticket expires and you have an active NFS share mounted which is a bit of a bummer :-)

(Using NFS v3 or lower and without Kerberos isn’t really an option - real ACLs and some sort of security is really needed)


Anyway - it’s good to see that the root cause for this bug has been found and fixed the right way :-)

- Peter

> Are there, up to your knowledge, any bigger on-premise or cloud setups out there?
> And are there any companies running dedicated NFSv4+Kerberos setups?
> 
> 
> Best and keep well and fit
> Sebastian
> 
> _________________
> Sebastian Kraus
> Team IT am Institut für Chemie
> Gebäude C, Straße des 17. Juni 115, Raum C7
> 
> Technische Universität Berlin
> Fakultät II
> Institut für Chemie
> Sekretariat C3
> Straße des 17. Juni 135
> 10623 Berlin
> 
> 
> Tel.: +49 30 314 22263
> Fax: +49 30 314 29309
> Email: sebastian.kraus@tu-berlin.de
> 
> ________________________________________
> From: Doug Nazar <nazard@nazar.ca>
> Sent: Monday, June 29, 2020 16:09
> To: Kraus, Sebastian
> Cc: linux-nfs@vger.kernel.org
> Subject: Re: [PATCH v2] Re: Strange segmentation violations of rpc.gssd in Debian Buster
> 
> On 2020-06-29 01:39, Kraus, Sebastian wrote:
>> Hi Doug,
>> thanks very much for your patch and efforts.
>> I manually backported the patch to nfs-utils 1.3.4-2.5 source in Debian Buster.
>> I am now testing the modified build on one of my NFSv4 file servers. Looks promising.
>> 
>> One additional question: Which nfs-utils branch are your working on - steved/nfs-utils.git ?
> 
> Yes, I'm working against upstream. I did check briefly that the code
> hadn't changed too much since 1.3.4 in that area.
> 
> I've found one other place that has insufficient locking but the race to
> hit it is fairly small. It's in the Kerberos machine principal cache
> when it refreshes the machine credentials. I have a patch for that, but
> it's pretty invasive due to some other changes I'm currently working on.
> Let me know if you hit it, and I can work on a simple version to backport.
> 
> Doug
> 

