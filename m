Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47A7E426C2
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Jun 2019 14:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438500AbfFLMzu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 12 Jun 2019 08:55:50 -0400
Received: from p3plsmtpa08-10.prod.phx3.secureserver.net ([173.201.193.111]:59859
        "EHLO p3plsmtpa08-10.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2438421AbfFLMzt (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 12 Jun 2019 08:55:49 -0400
Received: from [192.168.0.56] ([24.218.182.144])
        by :SMTPAUTH: with ESMTPSA
        id b2n6hpSMctiP8b2n6h03Cq; Wed, 12 Jun 2019 05:55:49 -0700
Subject: Re: [PATCH 0/9] Multiple network connections for a single NFS mount.
To:     NeilBrown <neilb@suse.com>, Olga Kornievskaia <aglo@umich.edu>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     Anna Schumaker <Anna.Schumaker@netapp.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <155917564898.3988.6096672032831115016.stgit@noble.brown>
 <001DED71-0E0D-46B1-BA34-84E6ACCBB79F@oracle.com>
 <87muj3tuuk.fsf@notabene.neil.brown.name>
 <4316E30B-1BD7-4F0E-8375-03E9F85FFD2B@oracle.com>
 <87lfy9vsgf.fsf@notabene.neil.brown.name>
 <3B887552-91FB-493A-8FDF-411562811B36@oracle.com>
 <CAN-5tyEdu7poNWrKtOyic6GgQcjAPZhB5BJeQ7JMSfmgMx8b+g@mail.gmail.com>
 <16D30334-67BE-4BD2-BE69-1453F738B259@oracle.com>
 <CAN-5tyHQz4kyGqAea3hTW0GKRBtkkB5UeE6THz-7uMmadJygyg@mail.gmail.com>
 <ac631f3c-af1a-6877-08b6-21ddf71edff2@talpey.com>
 <A74B7E29-CAC7-428B-8B29-606F4B174D1A@oracle.com>
 <CAN-5tyFP9qK9Tjv-FCeZJGMnhhnsZh0+VCguuRaDOG2kB9A-OQ@mail.gmail.com>
 <e33a22ef-b335-36e1-ea7f-2d2b5b2ed390@talpey.com>
 <87ftofwx3n.fsf@notabene.neil.brown.name>
From:   Tom Talpey <tom@talpey.com>
Message-ID: <307dbdb1-3cbe-0c7c-fa16-39cd4641dd98@talpey.com>
Date:   Wed, 12 Jun 2019 08:55:47 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <87ftofwx3n.fsf@notabene.neil.brown.name>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfGA/z4zA84FaL+Z/Ee/Amkad5xPGe3FzrwiXXamvLMq4+Sav2KQiwNMfXueHzyA7t6nNwNubld2Qt5G5ChDegO/9IVCTDJB5X8CJdfOrlgWiKyT2qlPI
 anfhp+ILgC/pR526QTg1P6uRPRrFS50W3hIttVY+Xb0mGvpn7zwCCJTVsAy1R8HG7nrBwOrZUwOf3LNoYwq69d85O0hKWLngcykw0ayDfD/bakIK3fiTilk7
 HoEv05gI+tFXEj4D/n1U3NSTrT00x45bgIQL5q31uS+YtA5F/LHvfh5LXzE0HfYhewrC+TncKjiA08IM2sOvRxFBoBTmrOF61YWRFICM3Lw=
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 6/11/2019 6:55 PM, NeilBrown wrote:
> On Tue, Jun 11 2019, Tom Talpey wrote:
> 
>> On 6/11/2019 5:10 PM, Olga Kornievskaia wrote:
> ...
>>>
>>> Solaris has it, Microsoft has it and linux has been deprived of it,
>>> let's join the party.
>>
>> Let me be clear about one thing - SMB3 has it because the protocol
>> is designed for it. Multichannel leverages SMB2 sessions to allow
>> retransmit on any active bound connection. NFSv4.1 (and later) have
>> a similar capability.
>>
>> NFSv2 and NFSv3, however, do not, and I've already stated my concerns
>> about pushing them too far. I agree with your sentiment, but for these
>> protocols, please bear in mind the risks.
> 
> NFSv2 and NFSv3 were designed to work with UDP.  That works a lot like
> one-connection-per-message.   I don't think there is any reason to think
> NFSv2,3 would have any problems with multiple connections.

Sorry, but are you saying NFS over UDP works? It does not. There
are 10- and 20-year old reports of this.

NFSv2 was designed in the 1980's. NFSv3 came to be in 1992. Do
you truly want to spend your time fixing 30 year old protocols?

Ok, I'll be quiet now. :-)

Tom.
