Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C747DACC79
	for <lists+linux-nfs@lfdr.de>; Sun,  8 Sep 2019 13:39:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728909AbfIHLjL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 8 Sep 2019 07:39:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35918 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728908AbfIHLjL (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sun, 8 Sep 2019 07:39:11 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4D2CA2F366C;
        Sun,  8 Sep 2019 11:39:10 +0000 (UTC)
Received: from [172.16.176.1] (ovpn-64-2.rdu2.redhat.com [10.10.64.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B74AB600C6;
        Sun,  8 Sep 2019 11:39:08 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Chuck Lever" <chuck.lever@oracle.com>
Cc:     "Jason L Tibbitts III" <tibbs@math.uh.edu>,
        "Bruce Fields" <bfields@fieldses.org>,
        "Wolfgang Walter" <linux@stwm.de>,
        "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>,
        km@cm4all.com, linux-kernel@vger.kernel.org
Subject: Re: Regression in 5.1.20: Reading long directory fails
Date:   Sun, 08 Sep 2019 07:39:08 -0400
Message-ID: <A862CFCD-76A2-4373-8F44-F156DB38E6A5@redhat.com>
In-Reply-To: <75F810C6-E99E-40C3-B5E1-34BA2CC42773@oracle.com>
References: <ufak1bhyuew.fsf@epithumia.math.uh.edu>
 <4418877.15LTP4gqqJ@stwm.de> <ufapnkhqjwm.fsf@epithumia.math.uh.edu>
 <4198657.JbNDGbLXiX@h2o.as.studentenwerk.mhn.de>
 <ufad0ggrfrk.fsf@epithumia.math.uh.edu> <20190906144837.GD17204@fieldses.org>
 <ufapnkdw3s3.fsf@epithumia.math.uh.edu>
 <75F810C6-E99E-40C3-B5E1-34BA2CC42773@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Sun, 08 Sep 2019 11:39:10 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 6 Sep 2019, at 16:50, Chuck Lever wrote:

>> On Sep 6, 2019, at 4:47 PM, Jason L Tibbitts III <tibbs@math.uh.edu> 
>> wrote:
>>
>>>>>>> "JBF" == J Bruce Fields <bfields@fieldses.org> writes:
>>
>> JBF> Those readdir changes were client-side, right?  Based on that 
>> I'd
>> JBF> been assuming a client bug, but maybe it'd be worth getting a 
>> full
>> JBF> packet capture of the readdir reply to make sure it's legit.
>>
>> I have been working with bcodding on IRC for the past couple of days 
>> on
>> this.  Fortunately I was able to come up with way to fill up a 
>> directory
>> in such a way that it will fail with certainty and as a bonus doesn't
>> include any user data so I can feel OK about sharing packet captures. 
>>  I
>> have a capture alongside a kernel trace of the problematic operation 
>> in
>> https://www.math.uh.edu/~tibbs/nfs/.  Not that I can particularly 
>> tell
>> anything useful from that, but bcodding says that it seems to point 
>> to
>> some issue in sunrpc.
>>
>> And because I can easily reproduce this and I was able to do a 
>> bisect:
>>
>> 2c94b8eca1a26cd46010d6e73a23da5f2e93a19d is the first bad commit
>> commit 2c94b8eca1a26cd46010d6e73a23da5f2e93a19d
>> Author: Chuck Lever <chuck.lever@oracle.com>
>> Date:   Mon Feb 11 11:25:41 2019 -0500
>>
>>    SUNRPC: Use au_rslack when computing reply buffer size
>>
>>    au_rslack is significantly smaller than (au_cslack << 2). Using
>>    that value results in smaller receive buffers. In some cases this
>>    eliminates an extra segment in Reply chunks (RPC/RDMA).
>>
>>    Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>>    Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
>>
>> :040000 040000 d4d1ce2fbe0035c5bd9df976b8c448df85dcb505 
>> 7011a792dfe72ff9cd70d66e45d353f3d7817e3e M      net
>>
>> But of course, I can't say whether this is the actual bad commit or
>> whether it just introduced a behavior change which alters the 
>> conditions
>> under which the problem appears.
>
> The first place I'd start looking is the XDR constants at the head of 
> fs/nfs/nfs4xdr.c
> having to do with READDIR.
>
> The report of behavior changes with the use of krb5p also makes this 
> commit plausible.

After sprinkling the printk's, we're coming up one word short in the 
receive
buffer.  I think we're not accounting for the xdr pad of buf->pages for 
NFS4
readdir -- but I need to check the RFCs.  Anyone know if v4 READDIR 
results
have to be aligned?

Also need to check just why krb5i is the only auth that cares..

Ben
