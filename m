Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 724C83505BD
	for <lists+linux-nfs@lfdr.de>; Wed, 31 Mar 2021 19:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbhCaRuK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 31 Mar 2021 13:50:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:48126 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233900AbhCaRuF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 31 Mar 2021 13:50:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617213005;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=1kLRw3PLsW5h2WLyoKl9ALHfqtN3vklo6I6SGpMLWpo=;
        b=Wm/xxBnTB5xjJJ8Iiku2Ikxxx3DmMubhlKOANI9bAm7OMGbuMj5Jg7QgC6QTtgIw8c2HM7
        sf+lp9hEllA9GCo4zbMqeSSbpnPzSvCyFih0uGd8koWplYjYN9Jirt+bINkk9NNCYwqIuu
        aAkb54Dg2wMPQBsQvdrIG+MG7JhGlM0=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-62-1nFT-Y0eOES6oPpngc6uFw-1; Wed, 31 Mar 2021 13:50:03 -0400
X-MC-Unique: 1nFT-Y0eOES6oPpngc6uFw-1
Received: by mail-yb1-f199.google.com with SMTP id u128so3047359ybf.12
        for <linux-nfs@vger.kernel.org>; Wed, 31 Mar 2021 10:50:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=1kLRw3PLsW5h2WLyoKl9ALHfqtN3vklo6I6SGpMLWpo=;
        b=n+9UiWHAPl7OBOUoEdgnAbDDFeHcZj868PYsCYOY2b4ZGaNx7cfFDFODmGSkk+fVDQ
         0AR8VJ39Razdmn8I3iwPCI0At20+Vz2Jl133O4SzyJnj/uwGT9AJDjMm5KXCiSeQGVLc
         Qn7qLAo7gKPg9KxHmh46U9HPmsSDRMxIZZ8a8lva41s7ibcVGh9Pnrc42OLfXIprrgDO
         RjTQdyWgJlUloAbG1vc+61nu/6C9DCJnHvqNTKaN13d9gx5m8O4BOgzTvlMgML/kuJrZ
         s1ZGTJgKPpk2p4eYnauYaqKoWLPjs4NWUIXP8xO/Gr8ayO9CM/SJdrJXBWICqqhfc39A
         /eMw==
X-Gm-Message-State: AOAM533Kmeoe/vh5MT7m2KAyzVbakvNTin3ifgOp5DtoV7nnPFAZai/1
        Uarj+L5jt5C9/lZk6pXAzxyE0LUj/O9EZPMPjhWRQmQOs9r3yNA2WhJ6v47WbCywxyhgE2UmQwO
        7A9VmESoDmNDU2VDveuh1NZnb8Gf1rlvSjFX9
X-Received: by 2002:a25:d40f:: with SMTP id m15mr5841197ybf.30.1617213002496;
        Wed, 31 Mar 2021 10:50:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyNet8v/Z6XZGlCvX6wU20t/Gjjzzp/DyLUUT75mZgL9j8F20j4EuzDm7mU3r1Hmo/uhROuQpDBeV8ZzNw9ELU=
X-Received: by 2002:a25:d40f:: with SMTP id m15mr5841178ybf.30.1617213002245;
 Wed, 31 Mar 2021 10:50:02 -0700 (PDT)
MIME-Version: 1.0
From:   David Wysochanski <dwysocha@redhat.com>
Date:   Wed, 31 Mar 2021 13:49:26 -0400
Message-ID: <CALF+zOnCisFWTubWEHhTLpt6=CUb7n86YvrNX3nreCYS73_v_Q@mail.gmail.com>
Subject: RFC: Approaches to resolve netfs API interface to NFS multiple
 completions problem
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     David Howells <dhowells@redhat.com>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        Anna Schumaker <Anna.Schumaker@netapp.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Trond,

I've been working on getting NFS converted to dhowells new fscache and
netfs APIs and running into a problem with how NFS is designed and it
involves the NFS pagelist.c / pgio API.  I'd appreciate it if you
could review and give your thoughts on possible approaches.  I've
tried to outline some of the possibilities below.  I tried coding
option #3 and ran into some problems, and it has a serialization
limitation.  At this point I'm leaning towards option 2, so I'll
probably try that approach if you don't have time for review or have
strong thoughts on it.

Thanks.


Problem: The NFS pageio interface does not expose a max read length that
we can easily use inside netfs clamp_length() function.  As a result, when
issue_op() is called indicating a single netfs subrequest, this can be
split into
multiple NFS subrequests / RPCs inside guts of NFS pageio code.  Multiple
NFS subrequests requests leads to multiple completions, and the netfs
API expects a 1:1 mapping between issue_op() and
netfs_subreq_terminated() calls.

Details of the NFS pageio API (see include/linux/nfs_page.h and
fs/nfs/pagelist.c)
Details of the netfs API (see include/linux/netfs.h and fs/netfs/read_helper.c)

The NFS pageio API 3 main calls are as follows:
1. nfs_pageio_init(): initialize a pageio structure (R/W IO of N pages)
2. nfs_pageio_add_request(): called for each page to add to an IO
* Calls nfs_pageio_add_request_mirror -> __nfs_pageio_add_request
  * __nfs_pageio_add_request may call nfs_pageio_doio() which actually
    sends an RPC over the wire if page cannot be added to the request
    ("coalesced") due to various factors.  For more details, see
    nfs_pageio_do_add_request() and all underlying code it calls such
    as nfs_coalesce_size() and subsequent pgio->pg_ops->pg_test() calls
3. nfs_pageio_complete() - "complete" the pageio
* calls nfs_pageio_complete_mirror -> nfs_pageio_doio()

The NFS pageio API thus may generate multiple over the wire RPCs
and thus multiple completions even though at the high level only
one call to nfs_pageio_complete() is made.

Option 1: Just use NFS pageio API as is, and deal with possible multiple
completions.
- Inconsistent with netfs design intent
- Need to keep track of the RPC completion status, and for example,
if one completes with success and one an error, probably call
netfs_subreq_terminated() with the error.
- There's no way for the caller of the NFS pageio API to know how
many RPCs and thus completions may occur.  Thus, it's unclear how
one would distinguish between a READ that resulted in a single RPC
over the wire that completed as a short read, and a READ that
resulted in multiple RPCs that would each complete separately,
but would eventually complete

Option 2: Create a more complex 'clamp_length()' function for NFS,
taking into account all ways NFS / pNFS code can split a read.
+ Consistent with netfs design intent
+ Multiple "split" requests would be called in parallel (see loop
inside netfs_readahead, which repeatedly calls netfs_rreq_submit_slice)
- Looks impossible without refactoring of NFS pgio API.  We need
to prevent nfs_pageio_add_request() from calling nfs_pagio_doio(),
and return some indication coalesce failed.  In addition, it may
run into problems with fallback from DS to MDS for example (see
commit d9156f9f364897e93bdd98b4ad22138de18f7c24).

Option 3: Utilize NETFS_SREQ_SHORT_READ flag as needed.
+ Consistent with netfs design intent
- Multiple "split" requests would be serialized (see code
paths inside netfs_subreq_terminated that check for this flag).
- Looks impossible without some refactoring of NFS pgio API.
* Notes: Terminate NFS pageio page based loop at the first call
to nfs_pageio_doio().  When a READ completes, NFS calls
netfs_subreq_terminated() with NETFS_SREQ_SHORT_READ
and is prepared to have the rest of the subrequest be resubmitted.
Need to somehow fail early or avoid entirely subsequent calls to
nfs_pagio_doio() for the original request though, and handle
error status only from the first RPC.

Option 4: Add some final completion routine to be called near
bottom of nfs_pageio_complete() and would pass in at least
netfs_read_subrequest(), possibly nfs_pageio_descriptor.
+ Inconsistent with netfs design intent
- Would be a new NFS API or call on top of everything
- Need to handle the "multiple completion with different
status" problem (see #1).

