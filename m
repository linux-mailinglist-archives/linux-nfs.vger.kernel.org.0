Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DDBB1BE1DC
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Apr 2020 16:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbgD2O6M (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 29 Apr 2020 10:58:12 -0400
Received: from p3plsmtpa09-04.prod.phx3.secureserver.net ([173.201.193.233]:35387
        "EHLO p3plsmtpa09-04.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726456AbgD2O6L (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 29 Apr 2020 10:58:11 -0400
X-Greylist: delayed 439 seconds by postgrey-1.27 at vger.kernel.org; Wed, 29 Apr 2020 10:58:11 EDT
Received: from [192.168.0.78] ([24.218.182.144])
        by :SMTPAUTH: with ESMTPSA
        id To31jwfLa0ZQQTo32jTGt9; Wed, 29 Apr 2020 07:50:52 -0700
X-CMAE-Analysis: v=2.3 cv=AqWQI91P c=1 sm=1 tr=0
 a=ugQcCzLIhEHbLaAUV45L0A==:117 a=ugQcCzLIhEHbLaAUV45L0A==:17
 a=IkcTkHD0fZMA:10 a=SEtKQCMJAAAA:8 a=yoXgPP3dPFmGH1RIU_sA:9 a=QEXdDO2ut3YA:10
 a=kyTSok1ft720jgMXX5-3:22
X-SECURESERVER-ACCT: tom@talpey.com
Subject: Re: handling ERR_SERVERFAULT on RESTOREFH
To:     Olga Kornievskaia <aglo@umich.edu>,
        Trond Myklebust <trondmy@hammerspace.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
References: <CAN-5tyE6JTeK7RFA7AkcO63p6iFE2v1+x2RFwRrTB1Jb1Yr76Q@mail.gmail.com>
 <98410608e028cb4b53024c7669e0fb70fea98214.camel@hammerspace.com>
 <CAN-5tyGDC9ittxr7d4wL_fKLQu9NLdZWwB19iEPsCn+Y0_sqVg@mail.gmail.com>
 <98a10c8775e4127419ac57630f839744bdf1063d.camel@hammerspace.com>
 <CAN-5tyGfCXVTz4dq3Qj2eXww8BNB_dT=0QwWteEGM93MZBJudw@mail.gmail.com>
 <b96e65b7aeb72e466d2a0170d4347652b6ab0ec5.camel@hammerspace.com>
 <CAN-5tyFOrb0bNWYon9QTQqWdhv4LG+-zBVbBt2E1NE=rwsBScg@mail.gmail.com>
From:   Tom Talpey <tom@talpey.com>
Message-ID: <d4109a36-e313-3649-336c-85e11d13d796@talpey.com>
Date:   Wed, 29 Apr 2020 10:50:52 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAN-5tyFOrb0bNWYon9QTQqWdhv4LG+-zBVbBt2E1NE=rwsBScg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfH9LVolWMLiUw7/dSbaKSVDwg4+BqOYbwOkAv9o3N6vw0l0vFblV2PT3VWfuD8boVLeaSS4UodJQke9nQN+F9antE/w2/Y1NDEh8YSOrXVsKt2kH7BnH
 fNHEqHp0QJEQbre4/m5Yz/SB7z3IKPvTu7xxni44dLZBXy02aw9csBEDFUNJSpUdnjFvceFebtjsdJd+Y2m8nseKTpSqHmBKUaA7ALzlmMu1zZia98mJetNS
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 4/28/2020 10:06 PM, Olga Kornievskaia wrote:
> On Tue, Apr 28, 2020 at 7:42 PM Trond Myklebust <trondmy@hammerspace.com> wrote:
>>
>> On Tue, 2020-04-28 at 19:02 -0400, Olga Kornievskaia wrote:
>>> On Tue, Apr 28, 2020 at 5:32 PM Trond Myklebust <
>>> trondmy@hammerspace.com> wrote:
>>>> On Tue, 2020-04-28 at 16:40 -0400, Olga Kornievskaia wrote:
>>>>> On Tue, Apr 28, 2020 at 2:47 PM Trond Myklebust <
>>>>> trondmy@hammerspace.com> wrote:
>>>>>> Hi Olga,
>>>>>>
>>>>>> On Tue, 2020-04-28 at 14:14 -0400, Olga Kornievskaia wrote:
>>>>>>> Hi folk,
>>>>>>>
>>>>>>> Looking for guidance on what folks think. A client is sending
>>>>>>> a
>>>>>>> LINK
>>>>>>> operation to the server. This compound after the LINK has
>>>>>>> RESTOREFH
>>>>>>> and GETATTR. Server returns SERVER_FAULT to on RESTOREFH. But
>>>>>>> LINK is
>>>>>>> done successfully. Client still fails the system call with
>>>>>>> EIO.
>>>>>>> We
>>>>>>> have a hardline and "ln" saying hardlink failed.
>>>>>>>
>>>>>>> Should the client not fail the system call in this case? The
>>>>>>> fact
>>>>>>> that
>>>>>>> we couldn't get up-to-date attributes don't seem like the
>>>>>>> reason
>>>>>>> to
>>>>>>> fail the system call?
>>>>>>>
>>>>>>> Thank you.
>>>>>>
>>>>>> I don't really see this as worth fixing on the client. It is
>>>>>> very
>>>>>> clearly a server bug.
>>>>>
>>>>> Why is that a server bug? A server can legitimately have an issue
>>>>> trying to execute an operation (RESTOREFH) and legitimately
>>>>> returning
>>>>> an error.
>>>>
>>>> If it is happening consistently on the server, then it is a bug,
>>>> and it
>>>> gets reported by the client in the same way we always report
>>>> NFS4ERR_SERVERFAULT, by converting to an EREMOTEIO.
>>>
>>> Yes but the client doesn't retry so it can't assess if it's
>>> consistently happening or not. It can be a transient error (or
>>> ENOMEM)
>>> that's later resolved.
>>
>> If the server wants to signal a transient error, it should send
>> NFS4ERR_DELAY.
> 
> ERR_DELAY not an allowed error for the RESTOREFH. But let's say, the
> server does return it, then client is not following the spec because
> if it'll get this error, it will retry the whole compound (causing a
> different error of redoing a non-idempotent operation). The spec says
> client is responsible for handling partially completed compound. The
> client should only retry the failed operations in a compound, I don't
> see that client does that.
> 
>>>>> NFS client also ignores errors of the returning GETATTR after the
>>>>> RESTOREFH. So I'm not sure why we are then not ignoring errors
>>>>> (or
>>>>> some errors) of the RESTOREFH.
>>>>
>>>> We do need to check the value of RESTOREFH in order to figure out
>>>> if we
>>>> can continue reading the XDR buffer to decode the file attributes.
>>>> We
>>>> want to read those file attributes because we do expect the change
>>>> attribute, the ctime and the nlinks values to all change as a
>>>> result of
>>>> the operation.
>>>
>>> I have nothing against decoding the error and using it in a decision
>>> to keep decoding. But the client doesn't have to propagate the
>>> RESTOREFH error to the application?
>>>
>>> In all other non-idempotent operations that have other operations (ie
>>> GETATTR) following them, the client ignores the errors. Btw I just
>>> noticed that on OPEN compound, since we ignore decode error from the
>>> GETATTR, it would continue decoding LAYOUTGET...
>>>
>>> CREATE has problem if the following GETFH will return EDELAY. Client
>>> doesn't deal with retrying a part of the compound. It retries the
>>> whole compound. It leads to an error (since non-idempotent operation
>>> is retried). But I guess that's a 2nd issue (or a 3rd if we could the
>>> decoding layoutget)....
>>>
>>> All this is under the umbrella of how to handle errors on
>>> non-idempotent operations in a compound....
>>
>> There is no point in trying to handle errors that make no sense. If the
>> server has a bug, then let's expose it instead of trying to hide it in
>> the sofa cushions.
> 
> EDELAY on GETFH is a reasonable error for the server to return.

I don't disagree that this is a broken server behavior. But from the
protocol perspective, I want to make two observations.

1) The post-operation attributes are not atomic, therefore an attribute
failure does not imply the operation was unsuccessful.

2) The application did not necessarily request the attributes, this
was inserted by the client, right? So again, their success or failure
is not actually relevant to the application.

Tom.
