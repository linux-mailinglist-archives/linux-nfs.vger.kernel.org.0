Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86F792D5EB4
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Dec 2020 15:55:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389767AbgLJOys (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 10 Dec 2020 09:54:48 -0500
Received: from smtp-o-1.desy.de ([131.169.56.154]:44992 "EHLO smtp-o-1.desy.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389857AbgLJOyp (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 10 Dec 2020 09:54:45 -0500
Received: from smtp-buf-1.desy.de (smtp-buf-1.desy.de [131.169.56.164])
        by smtp-o-1.desy.de (Postfix) with ESMTP id 4403BE07D9
        for <linux-nfs@vger.kernel.org>; Thu, 10 Dec 2020 15:54:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp-o-1.desy.de 4403BE07D9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=desy.de; s=default;
        t=1607612042; bh=hhbgovDo2xJedaRiHpshEyjwMv5zHzbAg6pvwHK1J3M=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=Rj6PjMQsRFxAATyNL08DRBKT4qpciqrbZHn9Ysmq6h0eBeF6pNJDdhHtjRnPTY0ZD
         NfhsgZT+N7lxVDvjtA3EJIPxMu5mjYxbNsCJAknN6o5QwLnekxgEMHe/NL6iBRStfz
         x4KCXwt0pLApmU0h1sASj+kpSlguLnIc6IIqW7mk=
Received: from smtp-m-1.desy.de (smtp-m-1.desy.de [IPv6:2001:638:700:1038::1:81])
        by smtp-buf-1.desy.de (Postfix) with ESMTP id 3E55C1201E1;
        Thu, 10 Dec 2020 15:54:02 +0100 (CET)
X-Virus-Scanned: amavisd-new at desy.de
Received: from z-mbx-2.desy.de (z-mbx-2.desy.de [131.169.55.140])
        by smtp-intra-3.desy.de (Postfix) with ESMTP id 14DFF80067;
        Thu, 10 Dec 2020 15:54:02 +0100 (CET)
Date:   Thu, 10 Dec 2020 15:54:02 +0100 (CET)
From:   "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
To:     trondmy <trondmy@hammerspace.com>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>,
        Anna Schumaker <anna.schumaker@netapp.com>
Message-ID: <882587239.3555211.1607612041998.JavaMail.zimbra@desy.de>
In-Reply-To: <e7c1fb7d7b658782a73616670f4c072db029ac53.camel@hammerspace.com>
References: <20201210105543.22489-1-tigran.mkrtchyan@desy.de> <e7c1fb7d7b658782a73616670f4c072db029ac53.camel@hammerspace.com>
Subject: Re: [PATCH] nfs41: update ff_layout_io_track_ds_error to accept rpc
 task
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.8.15_GA_3980 (ZimbraWebClient - FF83 (Mac)/8.8.15_GA_3980)
Thread-Topic: nfs41: update ff_layout_io_track_ds_error to accept rpc task
Thread-Index: AQHWzuMGU+9gXPTj5k+OuFz3grt7VanwZ6AA6QhLby4=
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



----- Original Message -----
> From: "trondmy" <trondmy@hammerspace.com>
> To: "Tigran Mkrtchyan" <tigran.mkrtchyan@desy.de>, "linux-nfs" <linux-nfs@vger.kernel.org>
> Cc: "Anna Schumaker" <anna.schumaker@netapp.com>
> Sent: Thursday, 10 December, 2020 15:42:38
> Subject: Re: [PATCH] nfs41: update ff_layout_io_track_ds_error to accept rpc task

> Hi Tigran,
> 
> On Thu, 2020-12-10 at 10:55 +0000, Tigran Mkrtchyan wrote:
>> When debugging READ_PLUS issues sent to DS I noticed that layoutstats
>> was reporting READ, though READ_PLUS was used.
>> 
>> The ff_layout_io_track_ds_error function takes the 'major' opnum as
>> an
>> argumentas well as the corresponding resulting error code.
>> 
>> By passing rpc task as an argument, the bogh values can be extracted
>> insideff_layout_io_track_ds_error and reduce a possibility of calling
>> with incorrect opnum.
> 
> I think we just want to disable READ_PLUS support in pNFS for the
> moment. We have no way of discovering and tracking whether or not the
> DS actually supports it, so let's leave it out for now.


No objections.

Tigran.

> 
> --
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
