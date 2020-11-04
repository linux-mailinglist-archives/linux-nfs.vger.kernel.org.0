Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E31672A6932
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Nov 2020 17:14:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbgKDQO5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 4 Nov 2020 11:14:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48675 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726539AbgKDQO5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 4 Nov 2020 11:14:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604506496;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cf25hf98POqPJnDrOhHfTYvgPInHT1y0bilet+tlHd8=;
        b=QSwN9AHMZN1muPzmxrL+GmJTH+xEiXPAPZfgyBIGONoCyjrpacT0eSfZTFYLw2Jb/lWr+O
        w7uOJzJAhvg18qFmOYxVG9SAqeVL8JVVAvp7upHWngTbY8XvTPKoaID5oLBr+ROY3j+rtv
        ik7IeoITRYBWQo0EIUToxBs0pPhe8Ls=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-442-3YUpsl1mPNOIVT-NuPCFtQ-1; Wed, 04 Nov 2020 11:14:54 -0500
X-MC-Unique: 3YUpsl1mPNOIVT-NuPCFtQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3E8E88049EA;
        Wed,  4 Nov 2020 16:14:53 +0000 (UTC)
Received: from [172.16.176.1] (ovpn-64-2.rdu2.redhat.com [10.10.64.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F2A315DA74;
        Wed,  4 Nov 2020 16:14:52 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     trondmy@kernel.org
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2 00/16] Readdir enhancements
Date:   Wed, 04 Nov 2020 11:14:51 -0500
Message-ID: <FEA7C67B-4091-4797-B05E-D762F0D0B3A1@redhat.com>
In-Reply-To: <20201103153329.531942-1-trondmy@kernel.org>
References: <20201103153329.531942-1-trondmy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Trond, these look great!

I'm doing some comparison testing before/after this set, and I'm getting
into some memory pressure on a client with 4G ram listing 1.5M dentries 
with
12 char filenames.

It looks like before this set, the readdir code was a bit more resilient 
in
the face of memory pressure, and I'm wondering if we've dropped a call 
to
mark_page_accessed().

* Ben adds:

@@ -460,7 +461,8 @@ static int nfs_readdir_search_array(struct 
nfs_readdir_descriptor *desc)
                 desc->last_cookie = array->last_cookie;
                 desc->current_index += array->size;
                 desc->page_index++;
-       }
+       } else
+               mark_page_accessed(desc->page);
         kunmap_atomic(array);
         return status;
  }

.. no, that's not any better.  I'm still getting evicted pages (or, at
least, low-indexed pages that don't have PageUptodate() set), which 
makes
it nearly impossible to finish listing this directory because we just 
keep
invalidating the mapping.

Any ideas?  I'll keep looking.

Ben

