Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4D5B10021E
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Nov 2019 11:08:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726940AbfKRKIe convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-nfs@lfdr.de>); Mon, 18 Nov 2019 05:08:34 -0500
Received: from mail2.xel.nl ([82.94.246.102]:52906 "EHLO mail2.xel.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726776AbfKRKId (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 18 Nov 2019 05:08:33 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail2.xel.nl (Postfix) with ESMTP id C666DE1386;
        Mon, 18 Nov 2019 11:08:30 +0100 (CET)
X-Virus-Scanned: Scanned by Xel Media mail2
Received: from mail2.xel.nl ([127.0.0.1])
        by localhost (mail2.xel.nl [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Ef2OGfSe40YE; Mon, 18 Nov 2019 11:08:30 +0100 (CET)
Received: from [172.31.0.6] (unknown [82.94.246.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail2.xel.nl (Postfix) with ESMTPSA id 08C44E0382;
        Mon, 18 Nov 2019 11:08:30 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: Specific IP per mounted share from same server
From:   Samy Ascha <samy@ascha.org>
In-Reply-To: <CAN-5tyGvLHJ2SJ2M56Ob3WRbbiG2-T1QYabgYY0EzbNB4h5DBg@mail.gmail.com>
Date:   Mon, 18 Nov 2019 11:08:29 +0100
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        linux-nfs <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <426F1484-BFBB-47FF-A9B2-2DB9C656C5D1@ascha.org>
References: <5DBD272A-0D55-4D74-B201-431D04878B43@ascha.org>
 <CAN-5tyF7F4Mc8Z-bwg+Rq-ok50mchyF+X24oE8_MZzVy8LRCmw@mail.gmail.com>
 <20191108162927.GA31528@fieldses.org>
 <CAN-5tyGvLHJ2SJ2M56Ob3WRbbiG2-T1QYabgYY0EzbNB4h5DBg@mail.gmail.com>
To:     Olga Kornievskaia <aglo@umich.edu>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi,

Sorry for not answering back earlier.

Thank you for your answers. I understand now, why this is all happening as it is.

As I'm dealing with many clients, I also have plenty options to balance per client, instead of per share.

I, for now, with the current setups, won't be able to balance on NICs per client, but I have enough bandwidth and the NICs will still be useful in case of network failover scenario's.

Thanks again and have a good week!

Samy

> On 8 Nov 2019, at 18:06, Olga Kornievskaia <aglo@umich.edu> wrote:
> 
> On Fri, Nov 8, 2019 at 11:29 AM J. Bruce Fields <bfields@fieldses.org> wrote:
>> 
>> On Fri, Nov 08, 2019 at 11:09:10AM -0500, Olga Kornievskaia wrote:
>>> Are you going against a linux server? I don't think linux server has
>>> the functionality you are looking for. What you are really looking for
>>> I believe is session trunking and neither the linux client nor server
>>> fully support that (though we plan to add that functionality in the
>>> near future).  Bruce, correct me if I'm wrong but linux server doesn't
>>> support multi-home (multi-node?)
>> 
>> 
>> The server should have complete support for session and clientid
>> trunking and multi-homing.  But I think we're just using those words in
>> slightly different ways:
> 
> By the full support, I mean neither client not server support trunking
> discovery unless that sneaked in when I wasn't looking. That was the
> piece that I knew needed to be done for sure.
> 
> When you say it fully support trunking do you mean it when each nfsd
> node runs in its own container, right? Otherwise, I thought more code
> would be needed to support the case presented here. nfsd would need to
> have a notion of running something like a cluster node on a particular
> interface and distinguish between requests coming from different
> interface and act accordingly?
> 
>> 
>>> therefore, it has no ability to distinguish
>>> requests coming from different network interfaces and then present
>>> different server major/minor/scope values and also return different
>>> clientids in that case as well. So what happens now even though the
>>> client is establishing a new TCP connection via the 2nd network, the
>>> server returns back to the client same clientid and server identity as
>>> the 1st mount thus client will use an existing connection it already
>>> has.
>> 
>> So, this part is correct, it treats requests coming from different
>> addresses the same way.
>> 
>> Although you *can* actually make the server behave this way with
>> containers if you run nfsd in two different containers each using one of
>> the two network namespaces.
>> 
>> There are also things the client could do to distribute traffic across
>> the two IP addresses.  There's been some work on implementing that, but
>> I've lost track of where it stands at this point....
> 
> Client can and will do trunking in case of pNFS to the data servers if
> the server presents multiple IPs. Otherwise, we just have nconnect
> feature but that doesn't split traffic between different network
> paths.
> 
>> 
>> --b.

