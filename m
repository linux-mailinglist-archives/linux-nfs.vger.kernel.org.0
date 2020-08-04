Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5336B23BD9D
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Aug 2020 17:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725924AbgHDP4B (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 4 Aug 2020 11:56:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:56260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727997AbgHDPz6 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 4 Aug 2020 11:55:58 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 85CCF208A9;
        Tue,  4 Aug 2020 15:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596556558;
        bh=JwByKtuKkgVsE2mmR5XBVyd2OPKZ4OuZl1WgOiRQTiU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aZW+mdAjwooYJ2UI2kYt2aKqnAwDsTnnOunVMWwZtOOPFHh4tn9mnXdOEt42wxKFd
         oXbapRUUUkaOtH4rAmA+pEG/s4OjfF/ygX0ur8yLE7L5gCfYjFkxt+hQAJJXelVP/n
         ENwbGhzBEpnpUyaXDG9C6BQSvEN8+BrR1OMCTfpk=
Date:   Tue, 4 Aug 2020 18:55:54 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Timo Rothenpieler <timo@rothenpieler.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>
Subject: Re: NFS over RDMA issues on Linux 5.4
Message-ID: <20200804155554.GD4432@unreal>
References: <CE6C02CE-3EEB-4834-B499-376BC6020A17@oracle.com>
 <20200804093635.GA4432@unreal>
 <92a5a932-b843-eed3-555e-7557ccc1f308@rothenpieler.org>
 <20200804122557.GB4432@unreal>
 <DAF6EFDA-5863-4887-B495-0BE3CA714209@oracle.com>
 <d41ac40e-8974-0a44-2b9f-bede74619935@rothenpieler.org>
 <F6BDB1B6-6315-47C9-A589-F4A57E25B2C5@oracle.com>
 <20200804134642.GC4432@unreal>
 <45BA86D8-52A3-407E-83BE-27343C0182C5@oracle.com>
 <B82C41F6-1C23-44F5-B802-621F6B63E12F@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B82C41F6-1C23-44F5-B802-621F6B63E12F@oracle.com>
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Aug 04, 2020 at 11:34:05AM -0400, Chuck Lever wrote:
>
>
> > On Aug 4, 2020, at 9:53 AM, Chuck Lever <chuck.lever@oracle.com> wrote:
> >
> >
> >
> >> On Aug 4, 2020, at 9:46 AM, Leon Romanovsky <leon@kernel.org> wrote:
> >>
> >> On Tue, Aug 04, 2020 at 09:12:55AM -0400, Chuck Lever wrote:
> >>>
> >>>
> >>>> On Aug 4, 2020, at 9:08 AM, Timo Rothenpieler <timo@rothenpieler.org> wrote:
> >>>>
> >>>> On 04.08.2020 14:49, Chuck Lever wrote:
> >>>>> Timo, I tend to think this is not a configuration issue.
> >>>>> Do you know of a known working kernel?
> >>>>
> >>>> This is a brand new system, it's never been running with any kernel older than 5.4, and downgrading it to 4.19 or something else while in operation is unfortunately not easily possible. For a client it would definitely not be out of the question, but the main nfs server I cannot easily downgrade.
> >>>>
> >>>> Also keep in mind that the dmesg spam happens on both server and client simultaneously.
> >>>
> >>> Let's start with the client only, since restarting it seems to clear the problem.
> >>
> >> It is client because according to the server CQE errors, it is Remote_Invalid_Request_Error
> >> with "9.7.5.2.2 NAK CODES" from IBTA.
> >
> > Thanks! OK, then let's use ftrace.
> >
> > Timo, can you install trace-cmd on your client? Then:
> >
> > 1. # trace-cmd record -e rpcrdma -e sunrpc
> >
> > 2. Trigger the problem
> >
> > 3. Control-C the trace-cmd, and copy the trace.dat file to another system
> >
> > 4. reboot your client
> >
> > Then send me your trace.dat. You don't have to cc the mailing lists.
>
> I see a LOC_LEN_ERR on a Receive. Leon, doesn't that mean the server's
> Send was too large?

1.
We have local_length_error counter, it can help to run it on server and clients.
[leonro@vm ~]$ cat /sys/class/infiniband/ibp0s9/ports/1/hw_counters/resp_local_length_error
0

resp_local_length_error - "Number of times responder detected local length errors."
2.
LOC_LEN_ERR supports that is written in CQE error on the client.
This is what is written in our HW document:
 IB compliant completion with error syndrome
	0x1: Local_Length_Error
3.
From IBTA, 11.6.2 COMPLETION RETURN STATUS
Local Length Error - Generated for a Work Request posted to the local
Send Queue when the sum of the Data Segment lengths exceeds the message
length for the channel adapter port. Generated for a Work Request posted
to the local Receive Queue when the sum of the Data Segment lengths is
too small to receive a valid incoming message or the length of the incoming
message is greater than the maximum message size supported by the HCA port
that received the message.


So if "1" works :), we will be able to distinguish if client sends too
large WR or recieves too large.

Thanks

>
> Timo, what filesystem are you sharing on your NFS server? The thing that
> comes to mind is https://bugzilla.kernel.org/show_bug.cgi?id=198053
>
>
> --
> Chuck Lever
>
>
>
