Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0481C0BF0
	for <lists+linux-nfs@lfdr.de>; Fri,  1 May 2020 04:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728008AbgEACFz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 30 Apr 2020 22:05:55 -0400
Received: from p3plsmtpa08-07.prod.phx3.secureserver.net ([173.201.193.108]:57304
        "EHLO p3plsmtpa08-07.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727889AbgEACFz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 30 Apr 2020 22:05:55 -0400
Received: from [192.168.0.78] ([24.218.182.144])
        by :SMTPAUTH: with ESMTPSA
        id UL3pjzX7B34inUL3qjnQMg; Thu, 30 Apr 2020 19:05:54 -0700
X-CMAE-Analysis: v=2.3 cv=UeEvt5aN c=1 sm=1 tr=0
 a=ugQcCzLIhEHbLaAUV45L0A==:117 a=ugQcCzLIhEHbLaAUV45L0A==:17
 a=IkcTkHD0fZMA:10 a=mJjC6ScEAAAA:8 a=e3r7bHJG3znUvQNh8RUA:9 a=QEXdDO2ut3YA:10
 a=ijnPKfduoCotzip5AuI1:22
X-SECURESERVER-ACCT: tom@talpey.com
Subject: Re: handling ERR_SERVERFAULT on RESTOREFH
To:     Olga Kornievskaia <aglo@umich.edu>,
        "J. Bruce Fields" <bfields@fieldses.org>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
References: <CAN-5tyE6JTeK7RFA7AkcO63p6iFE2v1+x2RFwRrTB1Jb1Yr76Q@mail.gmail.com>
 <98410608e028cb4b53024c7669e0fb70fea98214.camel@hammerspace.com>
 <CAN-5tyGDC9ittxr7d4wL_fKLQu9NLdZWwB19iEPsCn+Y0_sqVg@mail.gmail.com>
 <98a10c8775e4127419ac57630f839744bdf1063d.camel@hammerspace.com>
 <CAN-5tyGfCXVTz4dq3Qj2eXww8BNB_dT=0QwWteEGM93MZBJudw@mail.gmail.com>
 <b96e65b7aeb72e466d2a0170d4347652b6ab0ec5.camel@hammerspace.com>
 <8549f1fc955faedc35d810a4ad3e21904379a59a.camel@hammerspace.com>
 <CAN-5tyFRDg7W9pt57jTzoRgL8L=0_d7gCoRiAqWQR36iny33NQ@mail.gmail.com>
 <20200429154638.GB4799@fieldses.org>
 <CAN-5tyE7i3qxv7WyrAZkq2VCFrh1Kw4Q1eonG2Ep_YLFkMiJwQ@mail.gmail.com>
From:   Tom Talpey <tom@talpey.com>
Message-ID: <0e626cd6-deca-14e7-3b9a-3218c4962e63@talpey.com>
Date:   Thu, 30 Apr 2020 22:05:53 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAN-5tyE7i3qxv7WyrAZkq2VCFrh1Kw4Q1eonG2Ep_YLFkMiJwQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfHoY/L+S13o8UWK0RkW3tfG4qtdjVXaq40uA6LMi/8+efIlevMffz0Txv47ciGlCgH9NH0oFbbUel6OCGHrVLaWMtLCcj2S6ENOF0bNJXAgTjbqvImbU
 JdlGMbOpl4tfmFBQFh6SNZRuIPSyuhlLfn32c7J7aqFOjJBvifLzD+XR1x80gDdR3KtJk7qZsWWQkEC4+Oh/xgQQ8hQP4z0M8lz9HEXjNQU3XtUXMbe4wt1O
 3rRYXUBGjBbGbBq0mM+5jkQvT3RGfbV2dWm47Cf763I=
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 4/29/2020 12:22 PM, Olga Kornievskaia wrote:
> On Wed, Apr 29, 2020 at 11:46 AM J. Bruce Fields <bfields@fieldses.org> wrote:
>>
>> On Tue, Apr 28, 2020 at 10:12:29PM -0400, Olga Kornievskaia wrote:
>>> I also believe that client shouldn't be coded to a broken server. But
>>> in some of those cases, the client is not spec compliant, how is that
>>> a server bug? The case of SERVERFAULT of RESTOREFH I'm not sure what
>>> to make of it. I think it's more of a spec failure to address. It
>>> seems that server isn't allowed to fail after executing a
>>> non-idempotent operation but that's a hard requirement. I still think
>>> that client's best set of action is to ignore errors on RESTOREFH.
>>
>> Maybe.  But how is a server hitting SERVERFAULT on RESTOREFH, anyway?
>> That's pretty weird.
> 
> An example error is ENOMEM. A server is doing operations to lookup the
> filehandle (due to it being some other place) and needs to allocate
> memory. It's possible that resources are currently unavailable. Since
> RESTOREFH doesn't allow EDELAY, server can only return SERVERFAULT.

Why does the server need to do that? Surely it can best know how and
when to reschedule a memory allocation, instead of whining about its
temporary failure to the client.

> But as I mentioned before, even if EDELAY was allowed, client only
> resends the whole compound which is incorrect in case of
> non-idempotent operations.

Indeed, that's a protocol imperative, which the client should obey
by "cracking" the compound to determine what to retry.

Tom.

