Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0CDF4ED542
	for <lists+linux-nfs@lfdr.de>; Thu, 31 Mar 2022 10:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232520AbiCaIP1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 31 Mar 2022 04:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232253AbiCaIP1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 31 Mar 2022 04:15:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3FBB8DAFCC
        for <linux-nfs@vger.kernel.org>; Thu, 31 Mar 2022 01:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648714416;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XBSSjR/9FQIi28vZKv97ezZh1yar1AT2JnPj2c6QrxE=;
        b=hvH3lU3LV8VDnf4mx33dx54TnwaCrURrt0MO7zXFyBsa6DAhdlekOZmNx6DAMxLPkP7KEj
        brth1vwXCfYIVNaAIk84N43eYJs9itdRZuJMGEOPWJGrUDPosjSEIoo3twtEyP94YEfxfu
        Y8GUHXVEawNL/ef2d+V8OkiIOH2F46I=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-32-2bVHFnLgO9mOpHl4Sg9Y2w-1; Thu, 31 Mar 2022 04:13:30 -0400
X-MC-Unique: 2bVHFnLgO9mOpHl4Sg9Y2w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 15392899ECD;
        Thu, 31 Mar 2022 08:13:29 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 987B240D2821;
        Thu, 31 Mar 2022 08:13:25 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <164859751830.29473.5309689752169286816.stgit@noble.brown>
References: <164859751830.29473.5309689752169286816.stgit@noble.brown>
To:     NeilBrown <neilb@suse.de>
Cc:     dhowells@redhat.com, Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        linux-nfs@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/10] MM changes to improve swap-over-NFS support
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3096105.1648714405.1@warthog.procyon.org.uk>
Date:   Thu, 31 Mar 2022 09:13:25 +0100
Message-ID: <3096106.1648714405@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

NeilBrown <neilb@suse.de> wrote:

> Assorted improvements for swap-via-filesystem.
> 
> This is a resend of these patches, rebased on current HEAD.
> The only substantial changes is that swap_dirty_folio has replaced
> swap_set_page_dirty.
> 
> Currently swap-via-fs (SWP_FS_OPS) doesn't work for any filesystem.  It
> has previously worked for NFS but that broke a few releases back.
> This series changes to use a new ->swap_rw rather than ->readpage and
> ->direct_IO.  It also makes other improvements.
> 
> There is a companion series already in linux-next which fixes various
> issues with NFS.  Once both series land, a final patch is needed which
> changes NFS over to use ->swap_rw.

This seems to work by running sufficient copies of the attached program in
parallel to overwhelm the amount of ordinary RAM.

Tested-by: David Howells <dhowells@redhat.com>
---
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/mman.h>

int main()
{
	unsigned int pid = getpid(), iterations = 0;
	size_t i, j, size = 1024 * 1024 * 1024;
	char *p;
	bool mismatch;

	p = malloc(size);
	if (!p) {
		perror("malloc");
		exit(1);
	}

	srand(pid);
	for (i = 0; i < size; i += 4)
		*(unsigned int *)(p + i) = rand();
	
	do {
		for (j = 0; j < 16; j++) {
			for (i = 0; i < size; i += 4096)
				*(unsigned int *)(p + i) += 1;
			iterations++;
		}

		mismatch = false;
		srand(pid);
		for (i = 0; i < size; i += 4) {
			unsigned int r = rand();
			unsigned int v = *(unsigned int *)(p + i);

			if (i % 4096 == 0)
				v -= iterations;

			if (v != r) {
				fprintf(stderr, "mismatch %zx: %x != %x (diff %x)\n",
					i, v, r, v - r);
				mismatch = true;
			}
		}
	} while (!mismatch);

	exit(1);
}

