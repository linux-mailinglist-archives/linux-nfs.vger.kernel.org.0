Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 794D74D3ABE
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Mar 2022 21:02:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235423AbiCIUDD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 9 Mar 2022 15:03:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238178AbiCIUC4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 9 Mar 2022 15:02:56 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8ABAD1024
        for <linux-nfs@vger.kernel.org>; Wed,  9 Mar 2022 12:01:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646856115;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yX/Lbi+4paAfWgjakdtcSN+RcxoVxtsw7YU19TinczA=;
        b=SC+5y2Vl3Az7mTXMDnBoZ2ZvmGkvO0LGLmHa2zVVtcwr+rhCxuvcQ1+KdAY2P3B/tvt8Zz
        z+y5nJxF2bfu4KCHbyOasSdzp0xwvdfyqvrKiIfxGW1fpfGt43+mxfPn7VTKILogw511IT
        /50Nmo2IHFkompSpQpSwnWofJNwe+3Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-578-p0sOlzq7NJm7MsTgVftiuQ-1; Wed, 09 Mar 2022 15:01:52 -0500
X-MC-Unique: p0sOlzq7NJm7MsTgVftiuQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2EB76100C61F;
        Wed,  9 Mar 2022 20:01:51 +0000 (UTC)
Received: from [172.16.176.1] (ovpn-64-2.rdu2.redhat.com [10.10.64.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E0B08196F2;
        Wed,  9 Mar 2022 20:01:50 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     trondmy@kernel.org
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH v9 23/27] NFS: Convert readdir page cache to use a cookie
 based index
Date:   Wed, 09 Mar 2022 15:01:49 -0500
Message-ID: <A2AAA831-0D58-4FFB-B76C-6D6AF39607EA@redhat.com>
In-Reply-To: <20220227231227.9038-24-trondmy@kernel.org>
References: <20220227231227.9038-1-trondmy@kernel.org>
 <20220227231227.9038-2-trondmy@kernel.org>
 <20220227231227.9038-3-trondmy@kernel.org>
 <20220227231227.9038-4-trondmy@kernel.org>
 <20220227231227.9038-5-trondmy@kernel.org>
 <20220227231227.9038-6-trondmy@kernel.org>
 <20220227231227.9038-7-trondmy@kernel.org>
 <20220227231227.9038-8-trondmy@kernel.org>
 <20220227231227.9038-9-trondmy@kernel.org>
 <20220227231227.9038-10-trondmy@kernel.org>
 <20220227231227.9038-11-trondmy@kernel.org>
 <20220227231227.9038-12-trondmy@kernel.org>
 <20220227231227.9038-13-trondmy@kernel.org>
 <20220227231227.9038-14-trondmy@kernel.org>
 <20220227231227.9038-15-trondmy@kernel.org>
 <20220227231227.9038-16-trondmy@kernel.org>
 <20220227231227.9038-17-trondmy@kernel.org>
 <20220227231227.9038-18-trondmy@kernel.org>
 <20220227231227.9038-19-trondmy@kernel.org>
 <20220227231227.9038-20-trondmy@kernel.org>
 <20220227231227.9038-21-trondmy@kernel.org>
 <20220227231227.9038-22-trondmy@kernel.org>
 <20220227231227.9038-23-trondmy@kernel.org>
 <20220227231227.9038-24-trondmy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 27 Feb 2022, at 18:12, trondmy@kernel.org wrote:

> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>
> Instead of using a linear index to address the pages, use the cookie of
> the first entry, since that is what we use to match the page anyway.
>
> This allows us to avoid re-reading the entire cache on a seekdir() type
> of operation. The latter is very common when re-exporting NFS, and is a
> major performance drain.
>
> The change does affect our duplicate cookie detection, since we can no
> longer rely on the page index as a linear offset for detecting whether
> we looped backwards. However since we no longer do a linear search
> through all the pages on each call to nfs_readdir(), this is less of a
> concern than it was previously.
> The other downside is that invalidate_mapping_pages() no longer can use
> the page index to avoid clearing pages that have been read. A subsequent
> patch will restore the functionality this provides to the 'ls -l'
> heuristic.

I didn't realize the approach was to also hash out the linearly-cached
entries.  I thought we'd do something like flag the context for hashed page
indexes after a seekdir event, and if there are collisions with the linear
entries, they'll get fixed up when found.

Doesn't that mean that with this approach seekdir() only hits the same pages
when the entry offset is page-aligned?  That's 1 in 127 odds.

It also means we're amplifying the pagecache's useage for slightly changing
directories - rather than re-using the same pages we're scattering our usage
across the index.  Eh, maybe not a big deal if we just expect the page
cache's LRU to do the work.

Ben

