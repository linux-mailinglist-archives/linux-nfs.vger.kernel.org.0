Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1CEFB0198
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Sep 2019 18:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729140AbfIKQZk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 11 Sep 2019 12:25:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56978 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728825AbfIKQZk (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 11 Sep 2019 12:25:40 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C289F30983DE;
        Wed, 11 Sep 2019 16:25:39 +0000 (UTC)
Received: from [172.16.176.1] (ovpn-64-2.rdu2.redhat.com [10.10.64.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5228860BEC;
        Wed, 11 Sep 2019 16:25:38 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Chuck Lever" <chuck.lever@oracle.com>
Cc:     "Jason L Tibbitts III" <tibbs@math.uh.edu>,
        "Bruce Fields" <bfields@fieldses.org>,
        "Wolfgang Walter" <linux@stwm.de>,
        "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>,
        km@cm4all.com, linux-kernel@vger.kernel.org
Subject: Re: Regression in 5.1.20: Reading long directory fails
Date:   Wed, 11 Sep 2019 12:25:37 -0400
Message-ID: <DD6B77EE-3E25-4A65-9D0E-B06EEAD32B31@redhat.com>
In-Reply-To: <75F810C6-E99E-40C3-B5E1-34BA2CC42773@oracle.com>
References: <ufak1bhyuew.fsf@epithumia.math.uh.edu>
 <4418877.15LTP4gqqJ@stwm.de> <ufapnkhqjwm.fsf@epithumia.math.uh.edu>
 <4198657.JbNDGbLXiX@h2o.as.studentenwerk.mhn.de>
 <ufad0ggrfrk.fsf@epithumia.math.uh.edu> <20190906144837.GD17204@fieldses.org>
 <ufapnkdw3s3.fsf@epithumia.math.uh.edu>
 <75F810C6-E99E-40C3-B5E1-34BA2CC42773@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Wed, 11 Sep 2019 16:25:39 +0000 (UTC)
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

Well, one thing is that I wonder about decode_readdir_maxsz including
decode_verifier_maxsz since it is part of READDIR4resok, and so should 
be
included in the page data.. but that really doesn't matter here, I think 
we
just end up with a larger head.  Moving the start of the tail two words
forward doesn't seem to fix things..

I think the mic's xdr_buf_subsegment is getting partially split between
leftover space in the pages and the tail, so the checks for the length 
of
the subbuf do not match the length of mic.  In that case, we usually 
just
have extra room in the tail to copy it over, but now that rslack is not 
so
slack, the only extra room (as determined in xdr_buf_read_netobj()) 
would be
extra space in the page data, which we can't use.

The problem is that xdr_buf_read_netobj() is using xdr_buf_subsegment() 
with
an offset in the response data to the mic, but xdr_buf_subsegement() 
decides
what to do based on offsets in the already set-up xdr_buf.  If the 
server's
response leaves a hole in the page_len less than the mic, then the mic
subsegment straddles the page and the tail.  Then we try to copy it to 
the
end of the tail, but now there's not enough room.

Instead, I think we want to make sure the mic falls squarely into the 
tail
every time.

xdr_buf_read_netobj() is only used for the mic, so it seems like we can
refactor it to just use the tail, or get rid of it altogether.  I'll see 
if
I can do that.

Read on, if you want some numbers to check my work..

Here's how to reproduce:
Init an xdr_buf of 176, so rq_rcvsize is:
  4  RPC_REPHDRSIZE
19  auth->au_rslack
21  .p_replen
-----
44<<2 = 176

Then xdr_inline_pages() with:
- offset 140:
     21  resp.hdr
      4  RPC_REPHDRSIZE
     11  auth->au_ralign
     -1  xdr pad fixup
     -----
     35<<2 = 140

- base of 88 (that's static entries for . and ..)
- len of 262056 (64 pages - base of 88)

This gives us the following xdr_buf:

struct xdr_buf {
     head->iov_len = 140,
     tail->iov_len = 32,
     page_len = 262056,
     buflen = 262232
}

Then, get a READDIR response of total length 232208:

56 bytes to GSS data
76 bytes to READDIR4resok
262044 bytes of READDIR4resok
32 bytes of mic

That puts the mic at offset 262176.

That all looks right, and the response is well-formed.

Things go badly in xdr_read_netobj() with offset 262176:

We return -ENOMEM when
obj->len (28) is > than buf->buflen (262232) - buf->len (262208)

Ben
