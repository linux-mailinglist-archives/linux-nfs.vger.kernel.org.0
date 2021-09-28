Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D30D41A6FE
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Sep 2021 07:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234094AbhI1FTU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 28 Sep 2021 01:19:20 -0400
Received: from virgo01.ee.ethz.ch ([129.132.2.226]:59152 "EHLO
        virgo01.ee.ethz.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233681AbhI1FTT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 28 Sep 2021 01:19:19 -0400
X-Greylist: delayed 356 seconds by postgrey-1.27 at vger.kernel.org; Tue, 28 Sep 2021 01:19:19 EDT
Received: from localhost (localhost [127.0.0.1])
        by virgo01.ee.ethz.ch (Postfix) with ESMTP id 4HJSKW2qg6zMl4h;
        Tue, 28 Sep 2021 07:11:43 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at virgo01.ee.ethz.ch
Received: from virgo01.ee.ethz.ch ([127.0.0.1])
        by localhost (virgo01.ee.ethz.ch [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 2XxBrQzb18-a; Tue, 28 Sep 2021 07:11:41 +0200 (CEST)
X-MtScore: NO score=0
Received: from email.ee.ethz.ch (webbi10.ee.ethz.ch [129.132.52.168])
        by virgo01.ee.ethz.ch (Postfix) with ESMTPSA;
        Tue, 28 Sep 2021 07:11:41 +0200 (CEST)
MIME-Version: 1.0
Date:   Tue, 28 Sep 2021 07:11:41 +0200
From:   Salvatore Bonaccorso <bonaccos@ee.ethz.ch>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Subject: Re: nfsd4_process_open2 failed to open newly-created file!
 status=10008 ; warning at fs/nfsd/nfs4proc.c for nfsd4_open
In-Reply-To: <20210927155338.GA30593@fieldses.org>
References: <20210927061025.GA20892@varda.ee.ethz.ch>
 <20210927155338.GA30593@fieldses.org>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <cd38d56c6824ac6776df838dfd66bccd@ee.ethz.ch>
X-Sender: bonaccos@ee.ethz.ch
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Bruce,

On 27.09.2021 17:53, J. Bruce Fields wrote:
> On Mon, Sep 27, 2021 at 08:10:31AM +0200, Salvatore Bonaccorso wrote:
>> We recently got the following traces on a NFS server, but I'm not sure
>> how to further debug this, any hints?
> 
> The server creates and opens a file in two steps, though it should
> really be a single atomic operation.
> 
> That means there's a small possibility somebody could intervene and do
> something like change the permissions:
> 
>> 
>> [5746893.904448] ------------[ cut here ]------------
>> [5746893.910050] nfsd4_process_open2 failed to open newly-created 
>> file! status=10008
> 
> 10008 is NFS4ERR_DELAY, so maybe somebody managed to get a delegation
> before we finished opening?
> 
> We should be able to prevent that....
> 
> In your setup are there processes quickly opening new files created by
> others?

This is very possible. The NFS server is used as a "scratch" place 
accessible from
compute cluster where people can have multiple jobs simultaneously 
running through
Slurm and accessing the data. So it is possible that user create new 
files from
one running instance and accessing it quickly from the other nodes.

I'm so far was unable to arificially trigger the issue but is there 
anything I
can try out to get more information useful for you?

Regards,
Salvatore
