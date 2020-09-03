Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5576C25CE7B
	for <lists+linux-nfs@lfdr.de>; Fri,  4 Sep 2020 01:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbgICXsX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 3 Sep 2020 19:48:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbgICXsW (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 3 Sep 2020 19:48:22 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2880DC061244
        for <linux-nfs@vger.kernel.org>; Thu,  3 Sep 2020 16:48:22 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id n10so3400656qtv.3
        for <linux-nfs@vger.kernel.org>; Thu, 03 Sep 2020 16:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=lwfq6FpRJclrB1/WzyzhGXyWxqVY2r+obdBZ8s9OSrA=;
        b=UqEDZU+nV8uXVgJ5TSjf/S7LqNd+pjxKPMWrc1Z3iOGEOYHhsU0l0AYF1dM+pi11jU
         nMutSXg5nP+YKoaM+NVNP0lOF3Xw5Ecbfw/10iHnVmBkZGqsfNmDRfL53jPRayU0Z4bJ
         kX0RFJuV7Qo5krbN4QM1HZWphwT5rUzkr6Wj5dcAZYzsbB9MxaAn1qbzCqREnDUx3p4n
         9nk++rLD0RWvYquC8pKutd6psctL0QOUsGxBGxCJz9z/gZW2N1tIKnH94/h81Eu3tajD
         QSSSlRLgxXrSTySNiwscnD6LD+K8RNWjzmGTCPcxU3MMORxaj3o7K/7961GHSUAHKjZm
         jveA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=lwfq6FpRJclrB1/WzyzhGXyWxqVY2r+obdBZ8s9OSrA=;
        b=YlP3UX+bcrRsZhlvRRTHQQiDSMl1o3nk7uDgOMWa4YK5RNApAhGd5jGBpzWoLQl1be
         dgKSisOQfVQkJyqNy6EaMRV0C/3ioW8/ogHGYIl4/NsSln9UzQ/fovyecvWoHNxaYppj
         A/U8hMNacIegOGIzM5JY7t0mRodV77uFywSRukJgffTAPcJ9YVF/FzybNXnF32dqWi9g
         wI+DAT6AEKBEVGNKjmlAql1E0Ktsi1hIq7mXi4H0EzRnJ8aUgeuXVvt0J0LSeLjDiXSS
         HOk4rxOwzfvaW0xhxWnkPafwsbCpEXAgMKWrpA+ui7nNoTpNlovkK5foii8xfQLFqMkZ
         HD0w==
X-Gm-Message-State: AOAM530H/rns/iiZ32+a0AvMNSNB7tFHuRLzwsc17aiBjasfGLKXKhmM
        gCg7HOjZQi5DemKEBfUw8Adox7hPejc=
X-Google-Smtp-Source: ABdhPJyCuYgUuEdb0SNkTUQPrSNwFL+i0RdiMO0VXhjXv1MrHRYY7C0wivRw2iR7i3ak6cZlnDAmqA==
X-Received: by 2002:ac8:6b53:: with SMTP id x19mr6048113qts.296.1599176901379;
        Thu, 03 Sep 2020 16:48:21 -0700 (PDT)
Received: from anon-dhcp-152.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id z37sm3400241qtz.67.2020.09.03.16.48.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Sep 2020 16:48:20 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: [nfsv4] NFS over QUIC
From:   Chuck Lever <chucklever@gmail.com>
In-Reply-To: <20200903215242.GA4788@fieldses.org>
Date:   Thu, 3 Sep 2020 19:48:19 -0400
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>, nfsv4@ietf.org,
        stfrench@microsoft.com
Content-Transfer-Encoding: 7bit
Message-Id: <EFDBAD41-E0BE-4AEF-8E37-18A414CE8588@gmail.com>
References: <20200903215242.GA4788@fieldses.org>
To:     Bruce Fields <bfields@fieldses.org>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Bruce-

> On Sep 3, 2020, at 5:52 PM, J. Bruce Fields <bfields@fieldses.org> wrote:
> 
> I've been thinking about what might be required for NFS to run over
> QUIC.
> 
> Also cc'ing Steve French in case he's thought about this for CIFS/SMB.
> 
> I don't have real plans.  For Linux, I don't even know if there's a
> kernel QUIC implementation planned yet.
> 
> QUIC uses TLS so we'd probably steal some stuff from the NFS/TLS draft:
> 
> 	https://datatracker.ietf.org/doc/draft-cel-nfsv4-rpc-tls/

The link to the latest version of that document is

https://datatracker.ietf.org/doc/draft-ietf-nfsv4-rpc-tls/


> For example, section 4.3, which explains how to authenticate on top of
> an already-encrypted session, should also apply to QUIC.

Most of the document's content will be re-used for defining
RPC-over-QUIC, for example the ALPN defined in Section 8.2.
Lars Eggert, a chair of the QUIC WG, has been helping guide
the RPC-over-TLS effort with an eye towards using QUIC for
RPC when QUIC becomes more mature.

I thought the plan was to write a specification of RPC-over-
QUIC as a new RPC transport type with a netid and uaddr along
with a definition of the transport semantics (a la TI-RPC).
The document would need to explain record marking, peer
authentication, how to use multi-path and multi-stream support,
and so on.

Making NFS work on that transport should then be straightforward
enough that perhaps additional standards work wouldn't be
necessary.


> QUIC runs over UDP, so I think all that would be required to negotiate
> support would be to attempt a QUIC connection to port 2049.
> 
> The "Transport Layers" section in the NFS RFCs:
> 
> 	https://tools.ietf.org/html/rfc5661#section-2.9
> 
> requires transports support reliable and in-order transmission, forbids
> clients from retrying a request unless a connection is lost, and forbids
> servers from dropping a request without closing a connection.  I'm still
> vague on how those requirements interact with QUIC's connection
> management and 0-RTT reconnection.
> 
> https://www.ietf.org/id/draft-ietf-quic-applicability-07.txt looks
> useful, as a guide for applications running over QUIC.  It warns that
> connections can time out fairly quickly.  For timely callbacks over NFS
> sessions, that means we need the client to ping the server regularly.
> Sounds like that's what they do for HTTP/QUIC to make server push
> notifications work:
> 
> 	https://tools.ietf.org/html/draft-ietf-quic-http-09#section-5
> 
> 	HTTP clients are expected to use QUIC PING frames to keep
> 	connections open.  Servers SHOULD NOT use PING frames to keep a
> 	connection open.  A client SHOULD NOT use PING frames for this
> 	purpose unless there are responses outstanding for requests or
> 	server pushes.
> 
> QUIC allows multiple streams per connection--I wonder how we might use
> that.  RFC 5661 justifies the requirement for an ordered transport with:
> 
> 	Ordered delivery simplifies detection of transmit errors, and
> 	simplifies the sending of arbitrary sized requests and responses
> 	via the record marking protocol.
> 
> So as long as we don't try to split a single RPC among streams, I think
> we're OK.  Would a stream per session slot be reasonable?  I'm not sure
> what the cost of a stream is.
> 
> Do we need to add a new universal address type so the protocol can
> specify QUIC endpoints when necessary?  (For server-to-server-copy, pnfs
> file layouts, fs_locations, etc.)  All QUIC needs is an IP address and
> maybe a port, so maybe the existing UDP/TCP addresses are enough?

--
Chuck Lever
chucklever@gmail.com



