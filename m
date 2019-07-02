Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB545CE50
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Jul 2019 13:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbfGBLXt convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-nfs@lfdr.de>); Tue, 2 Jul 2019 07:23:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47714 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726150AbfGBLXt (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 2 Jul 2019 07:23:49 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E3C3B59454;
        Tue,  2 Jul 2019 11:23:38 +0000 (UTC)
Received: from [10.10.66.2] (ovpn-66-2.rdu2.redhat.com [10.10.66.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9FFAD1001B00;
        Tue,  2 Jul 2019 11:23:33 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Eric Biggers" <ebiggers@kernel.org>
Cc:     syzbot <syzbot+7fe11b49c1cc30e3fce2@syzkaller.appspotmail.com>,
        anna.schumaker@netapp.com, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        trond.myklebust@hammerspace.com
Subject: Re: memory leak in nfs_get_client
Date:   Tue, 02 Jul 2019 07:23:32 -0400
Message-ID: <13A4AF36-1649-41C0-A789-DC35853D2FB1@redhat.com>
In-Reply-To: <20190702063140.GE3054@sol.localdomain>
References: <000000000000f8a345058b046657@google.com>
 <223AB0C9-D93E-4D3C-BBBB-4AF40D8EA436@redhat.com>
 <20190702063140.GE3054@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
Content-Transfer-Encoding: 8BIT
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Tue, 02 Jul 2019 11:23:49 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 2 Jul 2019, at 2:31, Eric Biggers wrote:

> On Tue, Jun 11, 2019 at 12:23:12PM -0400, Benjamin Coddington wrote:
>> Ugh.. Now that you can cancel the wait, you have to also handle if 
>> "new" was
>> allocated.  I think this needs:
>>
>> diff --git a/fs/nfs/client.c b/fs/nfs/client.c
>> index d7e4f0848e28..4d90f5bf0b0a 100644
>> --- a/fs/nfs/client.c
>> +++ b/fs/nfs/client.c
>> @@ -406,10 +406,10 @@ struct nfs_client *nfs_get_client(const struct
>> nfs_client_initdata *cl_init)
>>                 clp = nfs_match_client(cl_init);
>>                 if (clp) {
>>                         spin_unlock(&nn->nfs_client_lock);
>> -                       if (IS_ERR(clp))
>> -                               return clp;
>>                         if (new)
>>                                 new->rpc_ops->free_client(new);
>> +                       if (IS_ERR(clp))
>> +                               return clp;
>>                         return nfs_found_client(cl_init, clp);
>>                 }
>>                 if (new) {
>>
>> I'll patch/test and send it along.
>>
>> Ben
>
> Hi Ben, what happened to this patch?

I sent it along:

https://lore.kernel.org/linux-nfs/65b675cec79d140df64bc30def88b1def32bf87e.1560272160.git.bcodding@redhat.com/

I don't think it will go in 5.2.. it's not a huge problem.

Ben
