Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7366E1F1DD2
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Jun 2020 18:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730670AbgFHQwV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 8 Jun 2020 12:52:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730637AbgFHQwU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 8 Jun 2020 12:52:20 -0400
Received: from smtp-o-1.desy.de (smtp-o-1.desy.de [IPv6:2001:638:700:1038::1:9a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 488AFC08C5C2
        for <linux-nfs@vger.kernel.org>; Mon,  8 Jun 2020 09:52:18 -0700 (PDT)
Received: from smtp-buf-1.desy.de (smtp-buf-1.desy.de [131.169.56.164])
        by smtp-o-1.desy.de (Postfix) with ESMTP id 68F60E014E
        for <linux-nfs@vger.kernel.org>; Mon,  8 Jun 2020 18:52:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp-o-1.desy.de 68F60E014E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=desy.de; s=default;
        t=1591635135; bh=bS2Gnh5o/d+qbBQ3gyoMTki631fvQrSUObQaapm7kFI=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=MmmoHxQ1DJLb4y9skhdppx8ZuKB8lC+abC02r3ESOyuxInFjqiAZTARKKbfv/s+Uz
         m7D4MqrX1Ug3VIqk52bCgsWrg/5bIq58iAikzqLWOnrmnZ1MWHxuGXBR6ZVqiIC1OC
         qDncZfkPNXG/SXA5IhyqvizmmQt8ZnksbVvauSwM=
Received: from smtp-m-1.desy.de (smtp-m-1.desy.de [131.169.56.129])
        by smtp-buf-1.desy.de (Postfix) with ESMTP id 5B4111201D6;
        Mon,  8 Jun 2020 18:52:15 +0200 (CEST)
X-Virus-Scanned: amavisd-new at desy.de
Received: from z-mbx-2.desy.de (z-mbx-2.desy.de [131.169.55.140])
        by smtp-intra-3.desy.de (Postfix) with ESMTP id 2D73C80005;
        Mon,  8 Jun 2020 18:52:15 +0200 (CEST)
Date:   Mon, 8 Jun 2020 18:52:15 +0200 (CEST)
From:   "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
To:     Frank van der Linden <fllinden@amazon.com>
Cc:     Anna Schumaker <anna.schumaker@netapp.com>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Message-ID: <1285470887.979001.1591635135066.JavaMail.zimbra@desy.de>
In-Reply-To: <20200608164742.GA14076@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
References: <20200325231051.31652-1-fllinden@amazon.com> <20200326231602.GA29187@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com> <2042449942.8269597.1585295495366.JavaMail.zimbra@desy.de> <v2aze7-yqvuvfuc4i30-1xxisr-dr39sbpkxym7-2nbcltx37gs3ezoql-qoc5f45hvih45iurdv-lqtdu9ppbm6i-upakk-2awl3v-em4ktl4ip5gchvuicg-vgnve1-wbqe5p-fw96bj-ct2sjj-wlbpk7.1586002736523@email.android.com> <1684380491.969626.1591631520724.JavaMail.zimbra@desy.de> <CAFX2JfkeJ=rqLkt6ce2GsLqmEx2H738skH9GUwVtRPCEyTfo9Q@mail.gmail.com> <743392222.977980.1591634249190.JavaMail.zimbra@desy.de> <20200608164742.GA14076@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
Subject: Re: [PATCH v2 00/13] NFS client user xattr (RFC8276) support
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.8.15_GA_3901 (ZimbraWebClient - FF76 (Linux)/8.8.15_GA_3895)
Thread-Topic: NFS client user xattr (RFC8276) support
Thread-Index: UjzKzd1Qi4sXkxzo664OYab1J4olJA==
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


Hi Frank,

----- Original Message -----
> From: "Frank van der Linden" <fllinden@amazon.com>
> To: "Tigran Mkrtchyan" <tigran.mkrtchyan@desy.de>
> Cc: "Anna Schumaker" <anna.schumaker@netapp.com>, "linux-nfs" <linux-nfs@vger.kernel.org>, "Trond Myklebust"
> <trond.myklebust@hammerspace.com>
> Sent: Monday, June 8, 2020 6:47:42 PM
> Subject: Re: [PATCH v2 00/13] NFS client user xattr (RFC8276) support

> On Mon, Jun 08, 2020 at 06:37:29PM +0200, Mkrtchyan, Tigran wrote:
>> Thanks for clarification.
>> 
>> Tigran.
>> 
>> ----- Original Message -----
>> > From: "Anna Schumaker" <anna.schumaker@netapp.com>
>> > To: "Tigran Mkrtchyan" <tigran.mkrtchyan@desy.de>
>> > Cc: "linux-nfs" <linux-nfs@vger.kernel.org>, "Trond Myklebust"
>> > <trond.myklebust@hammerspace.com>, "Frank van der Linden"
>> > <fllinden@amazon.com>
>> > Sent: Monday, June 8, 2020 6:15:06 PM
>> > Subject: Re: [PATCH v2 00/13] NFS client user xattr (RFC8276) support
>> 
>> > Hi Tigran,
>> >
>> >
>> > On Mon, Jun 8, 2020 at 11:59 AM Mkrtchyan, Tigran
>> > <tigran.mkrtchyan@desy.de> wrote:
>> >>
>> >>
>> >> Dear maintainers,
>> >>
>> >> are those changes considered for 5.8?
>> >
>> > My understanding is that these patches will be targeting 5.9.
>> >
>> > Anna
> 
> Hi Tigran,
> 
> Since there is one remaining open issue on the server side changes that needs
> signoff from the general fs maintainers, I agreed with Bruce & Chuck to target
> 5.9, as the 5.8 merge window is currently already open, and all the activity
> is centered around it.
> 
> For the client side, there are no open issues that were flagged, so from my
> side it's all ready to go - except for me to post a v3 rebased to
> the latest tree, which is easy to do.
> 
> In other words, I think it's ok for the client side to go in to 5.8, but it
> probably makes more sense to have it go in to the same version as the server
> side, so that's what I proposed to Anna & Trond.


Makes sense.

Thanks,
   Tigran.

> 
> - Frank
