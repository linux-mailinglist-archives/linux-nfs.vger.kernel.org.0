Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48B172A6B80
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Nov 2020 18:19:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731068AbgKDRTI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 4 Nov 2020 12:19:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:38820 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726969AbgKDRTI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 4 Nov 2020 12:19:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604510347;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=df2oz/ePqSi3umXPD40C0DyHZgA6UxXIkMnn1GF+38w=;
        b=U/Zeg0AzOM1lYj+A5ZkFoMhzFy0E+36i/1dmB3MKO8LJtTPCBNKkNQqiwWCvNM5iqp1Qsk
        uOQKS5eaEXJ6yRb6n73F9LTOEmAV+Le7uBDbJvOeNeHgLao9d7d9jXLtCr3r6cCmtnQHSq
        /jo3cAwbWUOzFh+W7P9JO34QZDWtyEY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-378-ccHoukzbNWGLHjugq6mJjw-1; Wed, 04 Nov 2020 12:19:05 -0500
X-MC-Unique: ccHoukzbNWGLHjugq6mJjw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 38F1A805EFD;
        Wed,  4 Nov 2020 17:19:04 +0000 (UTC)
Received: from [172.16.176.1] (ovpn-64-2.rdu2.redhat.com [10.10.64.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F25041A3D6;
        Wed,  4 Nov 2020 17:19:03 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Trond Myklebust" <trondmy@hammerspace.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2 00/16] Readdir enhancements
Date:   Wed, 04 Nov 2020 12:19:02 -0500
Message-ID: <5C64BA42-DB89-4427-A3E9-FD4ED3BB1CF0@redhat.com>
In-Reply-To: <50bf1f5c78d16d1018741febf822a00142a07b5b.camel@hammerspace.com>
References: <20201103153329.531942-1-trondmy@kernel.org>
 <FEA7C67B-4091-4797-B05E-D762F0D0B3A1@redhat.com>
 <50bf1f5c78d16d1018741febf822a00142a07b5b.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 4 Nov 2020, at 12:04, Trond Myklebust wrote:

> Hi Ben
>
> Thanks for the review and the testing!

Thank /you/ for the work!

> You're right that I had screwed up the page access marking in the
> previous patchsets. I believe this should be fixed in v3 by the
> conversion to use grab_cache_page(), which calls find_or_create_page()
> and should therefore do the right thing with the FGP_ACCESSED flag.
>
> I believe the reason why your patch above fails to fully correct the
> issue is because we always want to mark the page as accessed if we've
> scanned it.

Ah, that make sense.  I'll take the v3 for a ride tomorrow morning.

Ben

