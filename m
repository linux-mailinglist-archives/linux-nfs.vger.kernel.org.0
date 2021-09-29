Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC20A41BDD8
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Sep 2021 06:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbhI2EIc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 29 Sep 2021 00:08:32 -0400
Received: from virgo01.ee.ethz.ch ([129.132.2.226]:51628 "EHLO
        virgo01.ee.ethz.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbhI2EIc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 29 Sep 2021 00:08:32 -0400
Received: from localhost (localhost [127.0.0.1])
        by virgo01.ee.ethz.ch (Postfix) with ESMTP id 4HK2rB3PRyzMlDD;
        Wed, 29 Sep 2021 06:06:50 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at virgo01.ee.ethz.ch
Received: from virgo01.ee.ethz.ch ([127.0.0.1])
        by localhost (virgo01.ee.ethz.ch [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id hHNdbGO_yCMP; Wed, 29 Sep 2021 06:06:48 +0200 (CEST)
X-MtScore: NO score=0
Received: from email.ee.ethz.ch (webbi10.ee.ethz.ch [129.132.52.168])
        by virgo01.ee.ethz.ch (Postfix) with ESMTPSA;
        Wed, 29 Sep 2021 06:06:47 +0200 (CEST)
MIME-Version: 1.0
Date:   Wed, 29 Sep 2021 06:06:47 +0200
From:   Salvatore Bonaccorso <bonaccos@ee.ethz.ch>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Subject: Re: nfsd4_process_open2 failed to open newly-created file!
 status=10008 ; warning at fs/nfsd/nfs4proc.c for nfsd4_open
In-Reply-To: <20210928193925.GH25415@fieldses.org>
References: <20210927061025.GA20892@varda.ee.ethz.ch>
 <20210927155338.GA30593@fieldses.org>
 <cd38d56c6824ac6776df838dfd66bccd@ee.ethz.ch>
 <20210928193925.GH25415@fieldses.org>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <84751bbb03137f6a578148c988eeb230@ee.ethz.ch>
X-Sender: bonaccos@ee.ethz.ch
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Bruce,

On 28.09.2021 21:39, J. Bruce Fields wrote:
> On Tue, Sep 28, 2021 at 07:11:41AM +0200, Salvatore Bonaccorso wrote:
>> Hi Bruce,
>> 
>> On 27.09.2021 17:53, J. Bruce Fields wrote:
>> >On Mon, Sep 27, 2021 at 08:10:31AM +0200, Salvatore Bonaccorso wrote:
>> >>We recently got the following traces on a NFS server, but I'm not sure
>> >>how to further debug this, any hints?
>> >
>> >The server creates and opens a file in two steps, though it should
>> >really be a single atomic operation.
>> >
>> >That means there's a small possibility somebody could intervene and do
>> >something like change the permissions:
>> >
>> >>
>> >>[5746893.904448] ------------[ cut here ]------------
>> >>[5746893.910050] nfsd4_process_open2 failed to open
>> >>newly-created file! status=10008
>> >
>> >10008 is NFS4ERR_DELAY, so maybe somebody managed to get a delegation
>> >before we finished opening?
>> >
>> >We should be able to prevent that....
>> >
>> >In your setup are there processes quickly opening new files created by
>> >others?
>> 
>> This is very possible. The NFS server is used as a "scratch" place
>> accessible from
>> compute cluster where people can have multiple jobs simultaneously
>> running through
>> Slurm and accessing the data. So it is possible that user create new
>> files from
>> one running instance and accessing it quickly from the other nodes.
>> 
>> I'm so far was unable to arificially trigger the issue but is there
>> anything I
>> can try out to get more information useful for you?
> 
> I think the problem's pretty obvious.  I'm not sure what the fix should
> be.

Hope you come up with the right solution! Thanks for looking into it,
much appreciated.

> You can work around it for now by turning off delegations (echo 0
>> /proc/sys/fs/leases_enable before starting nfsd).

Ack thank you.

Regards,
Salvatore
