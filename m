Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7ED518D649
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Mar 2020 18:55:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbgCTRzG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Mar 2020 13:55:06 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:20070 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727026AbgCTRzG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Mar 2020 13:55:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584726904;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Z+qbHL4qqGMlx7ovfjHRJfQD+GpQE2yZC5ZEhlZmxu8=;
        b=My8MEXRgf3PlfPdSn/zhehXLbxXn7MA1LnuF+BZNOd8sGTKD7OFoHxfJZOapAjgiOE2xvu
        3LfD3nRJc1s7ydgdbu3bMZGtiHqctAP5fjTO20Ij6WVlF3Ow1tdwYppn1YzaDHXXzruOf7
        ePcl8GTtwPBFFyS9dwiqnJjE2JkSW8Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-269-kNEe7welNXSRlEwLdRg16Q-1; Fri, 20 Mar 2020 13:54:57 -0400
X-MC-Unique: kNEe7welNXSRlEwLdRg16Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A3AEE107B7F8;
        Fri, 20 Mar 2020 17:54:42 +0000 (UTC)
Received: from pick.fieldses.org (ovpn-116-243.rdu2.redhat.com [10.10.116.243])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 72DCA953A5;
        Fri, 20 Mar 2020 17:54:42 +0000 (UTC)
Received: by pick.fieldses.org (Postfix, from userid 2815)
        id 5DB73120231; Fri, 20 Mar 2020 13:54:41 -0400 (EDT)
Date:   Fri, 20 Mar 2020 13:54:41 -0400
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Frank van der Linden <fllinden@amazon.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 11/14] nfsd: add user xattr RPC XDR encoding/decoding
 logic
Message-ID: <20200320175441.GA22719@pick.fieldses.org>
References: <20200311195954.27117-1-fllinden@amazon.com>
 <20200311195954.27117-12-fllinden@amazon.com>
 <6955728A-CFCC-40FC-9E02-671255EDD45F@oracle.com>
 <20200320164737.GA19415@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
 <65ACAC76-DBBE-42D3-ACED-AB2290D0FC31@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65ACAC76-DBBE-42D3-ACED-AB2290D0FC31@oracle.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Mar 20, 2020 at 01:34:53PM -0400, Chuck Lever wrote:
> 
> 
> > On Mar 20, 2020, at 12:47 PM, Frank van der Linden <fllinden@amazon.com> wrote:
> > There definitely seem to be several copy functions in both the client
> > and server code that basically do the same, but in slightly different ways,
> > depending on whether they use an XDR buf or not, whether the pages are
> > mapped or not, etc. Seems like a good candidate for a cleanup, but I
> > considered it to be out of scope for these patches.
> 
> "out of scope" - probably so. Depending on Bruce's thinking, we can
> add this to the list of janitorial tasks.

The rewrite of the server xdr encoding was... oh jeez, six years ago
now, and I haven't really thought about it since.  I remember thinking
we should do the decode side as well someday, though, and thinking it
should be pretty doable.

--b.

