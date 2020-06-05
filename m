Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B13961EF716
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Jun 2020 14:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726404AbgFEMNd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 5 Jun 2020 08:13:33 -0400
Received: from p3plsmtpa07-09.prod.phx3.secureserver.net ([173.201.192.238]:50472
        "EHLO p3plsmtpa07-09.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726054AbgFEMNd (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 5 Jun 2020 08:13:33 -0400
Received: from [192.168.0.78] ([24.218.182.144])
        by :SMTPAUTH: with ESMTPSA
        id hB6zjqRZbZQ3PhB70j6vOo; Fri, 05 Jun 2020 05:06:15 -0700
X-CMAE-Analysis: v=2.3 cv=L7RjvNb8 c=1 sm=1 tr=0
 a=ugQcCzLIhEHbLaAUV45L0A==:117 a=ugQcCzLIhEHbLaAUV45L0A==:17
 a=IkcTkHD0fZMA:10 a=MaduGeJzO1XSokWPyYwA:9 a=P73MxSf4DJ6CZ9bq:21
 a=1wd4hXGIlYM9ApGK:21 a=QEXdDO2ut3YA:10
X-SECURESERVER-ACCT: tom@talpey.com
Subject: Re: once again problems with interrupted slots
To:     Olga Kornievskaia <aglo@umich.edu>,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>
References: <CAN-5tyFCotATeYVR0J1B_UaxhXYBDhp21LbFEzZtLYmgN_i+hg@mail.gmail.com>
From:   Tom Talpey <tom@talpey.com>
Message-ID: <13bed646-39b7-197e-ff90-85f8af10d93c@talpey.com>
Date:   Fri, 5 Jun 2020 08:06:14 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <CAN-5tyFCotATeYVR0J1B_UaxhXYBDhp21LbFEzZtLYmgN_i+hg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfHt5cTD92nhwIex1okLssT+P2hRvfxnl64OkojOd5tTSBe9sbCVKOahl3H5xl5nQToK1+0v2OpvsIDNxrOpdKiZ8vPYrrY7ylMf6SJSvcJN5uE3nUmRK
 U8Jrv/Uh6uHlWg+YpmUsUkCT2GzE/JLxzhDVr69mA5hFI+kBcj+dGaN/AKT3v7v2I1HOvNsR0FRON6xdTsUG2fBFYiZx38xQQNShvM8xrxYABZtaRikmP++m
 mR6ldB4MvhfxBKbbfuRSkg==
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 6/4/2020 5:21 PM, Olga Kornievskaia wrote:
> Hi Trond,
> 
> There is a problem with interrupted slots (yet again).
> 
> We send an operation to the server and it gets interrupted by the a signal.
> 
> We used to send a sole SEQUENCE to remove the problem of having real
> operation get an out of the cache reply and failing. Now we are not
> doing it again (since 3453d5708 NFSv4.1: Avoid false retries when RPC
> calls are interrupted"). So the problem is
> 
> We bump the sequence on the next use of the slot, and get SEQ_MISORDERED.

Misordered? It sounds like the client isn't managing the sequence
number, or perhaps the server never saw the original request, and
is being overly strict.

> We decrement the number back to the interrupted operation. This gets
> us a reply out of the cache. We again fail with REMOTE EIO error.

Ew. The client *decrements* the sequence?

Tom.

> Going back to the commit's message. I don't see the logic that the
> server can't tell if this is a new call or the old one. We used to
> send a lone SEQUENCE as a way to protect reuse of slot by a normal
> operation. An interrupted slot couldn't have been another SEQUENCE. So
> I don't see how the server can't tell a difference between SEQUENCE
> and any other operations.
> 
> 
