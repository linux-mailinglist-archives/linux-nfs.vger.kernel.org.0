Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF7012C407D
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Nov 2020 13:50:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729204AbgKYMr6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 25 Nov 2020 07:47:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729183AbgKYMr6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 25 Nov 2020 07:47:58 -0500
Received: from smtp-o-3.desy.de (smtp-o-3.desy.de [IPv6:2001:638:700:1038::1:9c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76F69C0613D4
        for <linux-nfs@vger.kernel.org>; Wed, 25 Nov 2020 04:47:57 -0800 (PST)
Received: from smtp-buf-3.desy.de (smtp-buf-3.desy.de [IPv6:2001:638:700:1038::1:a6])
        by smtp-o-3.desy.de (Postfix) with ESMTP id 31736605C8
        for <linux-nfs@vger.kernel.org>; Wed, 25 Nov 2020 13:47:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp-o-3.desy.de 31736605C8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=desy.de; s=default;
        t=1606308474; bh=lfIsgowr0v5WzyF1m4HFrYXGYkDm1N0htRPF5T4WvkY=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=MyNCfFQZ6daw7xRP28N3tfISFOdWmTqBgIRfLPtvLgNd9Fvn7WhSuzUTUBnGZwXQK
         EuascqELW3794gXy+mpV2KLrC0rpMqJREYyJjHcz7UbO3edrq0+QxdvmmFxtZj0urz
         REb4Zf6PinEgo7iZtOHC5eNfo4wPrATiC2R6pV1E=
Received: from smtp-m-3.desy.de (smtp-m-3.desy.de [131.169.56.131])
        by smtp-buf-3.desy.de (Postfix) with ESMTP id 2D225A05AC;
        Wed, 25 Nov 2020 13:47:54 +0100 (CET)
X-Virus-Scanned: amavisd-new at desy.de
Received: from z-mbx-2.desy.de (z-mbx-2.desy.de [131.169.55.140])
        by smtp-intra-3.desy.de (Postfix) with ESMTP id 0491180067;
        Wed, 25 Nov 2020 13:47:54 +0100 (CET)
Date:   Wed, 25 Nov 2020 13:47:53 +0100 (CET)
From:   "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
To:     trondmy <trondmy@hammerspace.com>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>, schumakeranna@gmail.com,
        linux-nfs <linux-nfs@vger.kernel.org>
Message-ID: <2007649768.3168809.1606308473907.JavaMail.zimbra@desy.de>
In-Reply-To: <245cbfff1a71061299d82afd216b355477919e59.camel@hammerspace.com>
References: <20201124135025.1097571-1-trondmy@kernel.org> <20201124161250.GA1091@fieldses.org> <20201124161809.GB1091@fieldses.org> <20201124202626.GA7173@fieldses.org> <245cbfff1a71061299d82afd216b355477919e59.camel@hammerspace.com>
Subject: Re: [PATCH v2 0/9] Fix various issues in the SUNRPC xdr code
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 8.8.15_GA_3959 (ZimbraWebClient - FF83 (Linux)/8.8.15_GA_3953)
Thread-Topic: Fix various issues in the SUNRPC xdr code
Thread-Index: AQHWwmjfwELMdH++00y7mVYsFk0+kqnXdH0AgAABfYCAAEVeAIAAReoA3bguR4g=
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Just in case I did a mistake during bisecting I had re-done it and got agai=
n

c567552612ece787b178e3b147b5854ad422a836
Author: Anna Schumaker <Anna.Schumaker@Netapp.com>
Date:   Wed May 28 13:41:22 2014 -0400

    NFS: Add READ_PLUS data segment support

But change doesn't looks like it can break getdeviceinfo.

Tigran.

----- Original Message -----
> From: "trondmy" <trondmy@hammerspace.com>
> To: "J. Bruce Fields" <bfields@fieldses.org>
> Cc: schumakeranna@gmail.com, "linux-nfs" <linux-nfs@vger.kernel.org>
> Sent: Wednesday, 25 November, 2020 01:36:42
> Subject: Re: [PATCH v2 0/9] Fix various issues in the SUNRPC xdr code

> On Tue, 2020-11-24 at 15:26 -0500, J. Bruce Fields wrote:
>> On Tue, Nov 24, 2020 at 11:18:09AM -0500, J. Bruce Fields wrote:
>> > On Tue, Nov 24, 2020 at 11:12:50AM -0500, bfields wrote:
>> > > On Tue, Nov 24, 2020 at 08:50:16AM -0500,
>> > > trondmy@kernel.org=C2=A0wrote:
>> > > > From: Trond Myklebust <trond.myklebust@hammerspace.com>
>> > > >=20
>> > > > When looking at the issues raised by Tigran's testing of the
>> > > > NFS client
>> > > > updates, I noticed a couple of things in the generic SUNRPC xdr
>> > > > code
>> > > > that want to be fixed. This patch series replaces an earlier
>> > > > series that
>> > > > attempted to just fix the XDR padding in the NFS code.
>> > > >=20
>> > > > This series fixes up a number of issues w.r.t. bounds checking
>> > > > in the
>> > > > xdr_stream code. It corrects the behaviour of xdr_read_pages()
>> > > > for the
>> > > > case where the XDR object size is larger than the buffer page
>> > > > array
>> > > > length and simplifies the code.
>> > >=20
>> > > I'm seeing this on the client with recent upstream + these
>> > > patches.
>> >=20
>> > Unfortunately that was in the middle of a series of tests, and I'm
>> > not
>> > sure exactly what triggered it--I'm guessing cthon special over
>> > krb5i.
>> > I'll let you know what else I can figure out.
>>=20
>> Yeah, reproduceable by running cthon -s over krb5i, and it first
>> shows
>> up with the last patch, "NFSv4.2: Fix up read_plus() page alignment".
>=20
> OK, thanks! I'll just drop that one then. I don't think it really
> suffices to fix READ_PLUS as it stands.
>=20
>=20
> --
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
