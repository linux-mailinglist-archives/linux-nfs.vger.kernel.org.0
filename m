Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4093F25CCD2
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Sep 2020 23:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729312AbgICVwr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 3 Sep 2020 17:52:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729371AbgICVwq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 3 Sep 2020 17:52:46 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC6EDC061244
        for <linux-nfs@vger.kernel.org>; Thu,  3 Sep 2020 14:52:45 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 0543E1C25; Thu,  3 Sep 2020 17:52:43 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 0543E1C25
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1599169963;
        bh=zAqWKfUeoEES9zp0RnX2+mvHU+omspjePHNhk4XbnkY=;
        h=Date:To:Cc:Subject:From:From;
        b=Q3P1hmAVQoFD4b6Rs2iWMV2pePRtTiNsUyKtEus8aCEN6DlNrdQ33QgWWRGlHLEwo
         FmXR35ndu1FBYwokSJGvluUKIDmmXbUkI2DTit6Tpe9exV0k3uL1iVSd4rjdrZ4BEQ
         z/4mdK4WnH5KU5rwSTtfOe1OE8jyyDCfpLjscK0I=
Date:   Thu, 3 Sep 2020 17:52:42 -0400
To:     linux-nfs@vger.kernel.org, nfsv4@ietf.org
Cc:     stfrench@microsoft.com, Chuck Lever <chuck.lever@oracle.com>
Subject: NFS over QUIC
Message-ID: <20200903215242.GA4788@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

I've been thinking about what might be required for NFS to run over
QUIC.

Also cc'ing Steve French in case he's thought about this for CIFS/SMB.

I don't have real plans.  For Linux, I don't even know if there's a
kernel QUIC implementation planned yet.

QUIC uses TLS so we'd probably steal some stuff from the NFS/TLS draft:

	https://datatracker.ietf.org/doc/draft-cel-nfsv4-rpc-tls/

For example, section 4.3, which explains how to authenticate on top of
an already-encrypted session, should also apply to QUIC.

QUIC runs over UDP, so I think all that would be required to negotiate
support would be to attempt a QUIC connection to port 2049.

The "Transport Layers" section in the NFS RFCs:

	https://tools.ietf.org/html/rfc5661#section-2.9

requires transports support reliable and in-order transmission, forbids
clients from retrying a request unless a connection is lost, and forbids
servers from dropping a request without closing a connection.  I'm still
vague on how those requirements interact with QUIC's connection
management and 0-RTT reconnection.

https://www.ietf.org/id/draft-ietf-quic-applicability-07.txt looks
useful, as a guide for applications running over QUIC.  It warns that
connections can time out fairly quickly.  For timely callbacks over NFS
sessions, that means we need the client to ping the server regularly.
Sounds like that's what they do for HTTP/QUIC to make server push
notifications work:

	https://tools.ietf.org/html/draft-ietf-quic-http-09#section-5

	HTTP clients are expected to use QUIC PING frames to keep
	connections open.  Servers SHOULD NOT use PING frames to keep a
	connection open.  A client SHOULD NOT use PING frames for this
	purpose unless there are responses outstanding for requests or
	server pushes.

QUIC allows multiple streams per connection--I wonder how we might use
that.  RFC 5661 justifies the requirement for an ordered transport with:

	Ordered delivery simplifies detection of transmit errors, and
	simplifies the sending of arbitrary sized requests and responses
	via the record marking protocol.

So as long as we don't try to split a single RPC among streams, I think
we're OK.  Would a stream per session slot be reasonable?  I'm not sure
what the cost of a stream is.

Do we need to add a new universal address type so the protocol can
specify QUIC endpoints when necessary?  (For server-to-server-copy, pnfs
file layouts, fs_locations, etc.)  All QUIC needs is an IP address and
maybe a port, so maybe the existing UDP/TCP addresses are enough?

--b.
