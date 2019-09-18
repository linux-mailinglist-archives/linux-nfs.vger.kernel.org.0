Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE30FB61FD
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Sep 2019 13:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727569AbfIRLEH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 18 Sep 2019 07:04:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39568 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726077AbfIRLEG (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 18 Sep 2019 07:04:06 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0C73310F2E8B;
        Wed, 18 Sep 2019 11:04:06 +0000 (UTC)
Received: from [172.16.176.1] (ovpn-64-2.rdu2.redhat.com [10.10.64.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B34A35D6A5;
        Wed, 18 Sep 2019 11:04:05 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Leon Kyneur" <leonk@dug.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: troubleshooting LOCK FH and NFS4ERR_BAD_SEQID
Date:   Wed, 18 Sep 2019 07:04:05 -0400
Message-ID: <66D00B9D-16DC-4979-8400-457398DC4801@redhat.com>
In-Reply-To: <CAACwWuMbB=zTaXW-fQmUYHLvx=YgE=68M96=hq201pqn2wKxBw@mail.gmail.com>
References: <CAACwWuN6siyM9t+rCmzxYPCf777bvD_J1xQKwNb7ZzBdzvy42Q@mail.gmail.com>
 <8217416C-F3E5-4BEE-BD01-2BE19952425E@redhat.com>
 <CAACwWuMbB=zTaXW-fQmUYHLvx=YgE=68M96=hq201pqn2wKxBw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.66]); Wed, 18 Sep 2019 11:04:06 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 17 Sep 2019, at 22:20, Leon Kyneur wrote:

> On Tue, Sep 17, 2019 at 7:28 PM Benjamin Coddington 
> <bcodding@redhat.com> wrote:
>>
>> On 12 Sep 2019, at 4:27, Leon Kyneur wrote:
>>
>>> Hi
>>>
>>> I'm experiencing an issue on NFS 4.0 + 4.1 where we cannot call 
>>> fcntl
>>> locks on any file on the share. The problem goes away if the share 
>>> is
>>> umount && mount (mount -o remount does not resolve the issue)
>>>
>>> Client:
>>> EL 7.4 3.10.0-693.5.2.el7.x86_64 nfs-utils-1.3.0-0.48.el7_4.x86_64
>>>
>>> Server:
>>> EL 7.4 3.10.0-693.5.2.el7.x86_64  nfs-utils-1.3.0-0.48.el7_4.x86_64
>>>
>>> I can't figure this out but the client reports bad-sequence-id in
>>> dupicate in the logs:
>>> Sep 12 02:16:59 client kernel: NFS: v4 server returned a bad
>>> sequence-id error on an unconfirmed sequence ffff881c52286220!
>>> Sep 12 02:16:59 client kernel: NFS: v4 server returned a bad
>>> sequence-id error on an unconfirmed sequence ffff881c52286220!
>>> Sep 12 02:17:39 client kernel: NFS: v4 server returned a bad
>>> sequence-id error on an unconfirmed sequence ffff8810889cb020!
>>> Sep 12 02:17:39 client kernel: NFS: v4 server returned a bad
>>> sequence-id error on an unconfirmed sequence ffff8810889cb020!
>>> Sep 12 02:17:44 client kernel: NFS: v4 server returned a bad
>>> sequence-id error on an unconfirmed sequence ffff881b414b2620!
>>>
>>> wireshark capture shows only 1 BAD_SEQID reply from the server:
>>> $ tshark -r client_broken.pcap -z proto,colinfo,rpc.xid,rpc.xid -z
>>> proto,colinfo,nfs.seqid,nfs.seqid -R 'rpc.xid == 0x9990c61d'
>>> tshark: -R without -2 is deprecated. For single-pass filtering use 
>>> -Y.
>>> 141         93 172.27.30.129 -> 172.27.255.28 NFS 352 V4 Call LOCK 
>>> FH:
>>> 0x80589398 Offset: 0 Length: <End of File>  nfs.seqid == 0x0000004e
>>> nfs.seqid == 0x00000002  rpc.xid == 0x9990c61d
>>> 142         93 172.27.255.28 -> 172.27.30.129 NFS 124 V4 Reply (Call
>>> In 141) LOCK Status: NFS4ERR_BAD_SEQID  rpc.xid == 0x9990c61d
>>>
>>> system call I have identified as triggering it is:
>>> fcntl(3, F_SETLK, {type=F_RDLCK, whence=SEEK_SET, start=1073741824,
>>> len=1}) = -1 EIO (Input/output error)
>>
>> Can you simplify the trigger into something repeatable?  Can you 
>> determine
>> if the client or the server has lost track of the sequence?
>>
>
> I have tried, I wrote some code to perform the fcntl RDKLCK the same
> way and ran it accross
> thousands of machines without any success. I am quite sure this is a
> symptom of something
> not the cause.
>
> Is there a better way of tracking sequences other than monitoring the
> network traffic?

I think that's the best way, right now.  We do have tracepoints for
nfs4 open and close that show the sequence numbers on the client, but 
I'm
not sure about how to get that from the server side.  I don't think we 
have
seqid for locks in tracepoints.. I could be missing something.  Not only
that, but you might not get tracepoint output showing the sequence 
numbers
if you're in an error-handling path.

If you have a wire capture of the event, you should be able to go 
backwards
from the error and figure out what the sequence number on the state 
should
be for the operation that received BAD_SEQID by finding the last
sequence-mutating (OPEN,CLOSE,LOCK) operation for that stateid that did 
not
return an error.

Ben
