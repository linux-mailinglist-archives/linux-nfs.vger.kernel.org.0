Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10A75B0324
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Sep 2019 19:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729681AbfIKRuY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 11 Sep 2019 13:50:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44806 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729622AbfIKRuX (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 11 Sep 2019 13:50:23 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 55167A37188;
        Wed, 11 Sep 2019 17:50:23 +0000 (UTC)
Received: from [172.16.176.1] (ovpn-64-2.rdu2.redhat.com [10.10.64.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4560A19C6A;
        Wed, 11 Sep 2019 17:50:22 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Chuck Lever" <chuck.lever@oracle.com>
Cc:     "Jason L Tibbitts III" <tibbs@math.uh.edu>,
        "Bruce Fields" <bfields@fieldses.org>,
        "Wolfgang Walter" <linux@stwm.de>,
        "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>,
        km@cm4all.com, linux-kernel@vger.kernel.org
Subject: Re: Regression in 5.1.20: Reading long directory fails
Date:   Wed, 11 Sep 2019 13:50:21 -0400
Message-ID: <FAA4DD3D-C58A-4628-8FD5-A7E2E203B75A@redhat.com>
In-Reply-To: <8D7EFCEB-4AE6-4963-B66F-4A8EEA5EA42A@redhat.com>
References: <ufak1bhyuew.fsf@epithumia.math.uh.edu>
 <4418877.15LTP4gqqJ@stwm.de> <ufapnkhqjwm.fsf@epithumia.math.uh.edu>
 <4198657.JbNDGbLXiX@h2o.as.studentenwerk.mhn.de>
 <ufad0ggrfrk.fsf@epithumia.math.uh.edu> <20190906144837.GD17204@fieldses.org>
 <ufapnkdw3s3.fsf@epithumia.math.uh.edu>
 <75F810C6-E99E-40C3-B5E1-34BA2CC42773@oracle.com>
 <DD6B77EE-3E25-4A65-9D0E-B06EEAD32B31@redhat.com>
 <0089DF80-3A1C-4F0B-A200-28FF7CFD0C65@oracle.com>
 <429B2B1F-FB55-46C5-8BC5-7644CE9A5894@redhat.com>
 <F1EC95D2-47A3-4390-8178-CAA8C045525B@oracle.com>
 <8D7EFCEB-4AE6-4963-B66F-4A8EEA5EA42A@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.68]); Wed, 11 Sep 2019 17:50:23 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 11 Sep 2019, at 13:40, Benjamin Coddington wrote:

> On 11 Sep 2019, at 13:29, Chuck Lever wrote:
>
>>> On Sep 11, 2019, at 1:26 PM, Benjamin Coddington 
>>> <bcodding@redhat.com> wrote:
>>>
>>>
>>> On 11 Sep 2019, at 12:39, Chuck Lever wrote:
>>>
>>>>> On Sep 11, 2019, at 12:25 PM, Benjamin Coddington 
>>>>> <bcodding@redhat.com> wrote:
>>>>>
>>>
>>>>> Instead, I think we want to make sure the mic falls squarely into 
>>>>> the tail
>>>>> every time.
>>>>
>>>> I'm not clear how you could do that. The length of the page data is 
>>>> not
>>>> known to the client before it parses the reply. Are you suggesting 
>>>> that
>>>> gss_unwrap should do it somehow?
>>>
>>> Is it too niave to always put the mic at the end of the tail?
>>
>> The size of the page content is variable.
>>
>> The only way the MIC will fall into the tail is if the page content 
>> is
>> exactly the largest expected size. When the page content is smaller 
>> than
>> that, the receive logic will place part or all of the MIC in ->pages.
>
> Ok, right.  But what I meant is that xdr_buf_read_netobj() should be 
> renamed
> and repurposed to be "move the mic from wherever it is to the end of
> xdr_buf's tail".
>
> But now I see what you mean, and I also see that it is already trying 
> to do
> that.. and we don't want to overlap the copy..
>
> So, really, we need the tail to be larger than twice the mic.. less 1. 
>  That
> means the fix is probably just increasing rslack for krb5i.

.. or we can keep the tighter tail space, and if we detect the mic 
straddles
the page and tail, we can move the mic into the tail with 2 copies, 
first
move the bit in the tail back, then move the bit in the pages.

Which is preferred, less allocation, or in the rare case this occurs, 
doing
copy twice?

Ben
