Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28789752AD2
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jul 2023 21:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232912AbjGMTSB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 13 Jul 2023 15:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232910AbjGMTSB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 13 Jul 2023 15:18:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F981FD8
        for <linux-nfs@vger.kernel.org>; Thu, 13 Jul 2023 12:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689275832;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+7TBVpMGjwD9DsMUWCZqrJZ4ffMsGc24Osuaf3WBSDU=;
        b=RmmCOGQuqkl1Tg4pyCkpdM8fKGyw9TWipGadtYPhTS14Qgl7eSoa1G2Cb69HDKo+48iWeZ
        xYbcTnZdZzDiz7mJ7L4Nq3x/3A/47JPpTo+NZP3YzGveiW4sVR8HEkZig8sYvr8ERm8NY+
        XJ8IFDGc9GbwT0w+1M4YRfvsh13N0Zo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-563-qCypdEwGPku8zkWzBEhnfQ-1; Thu, 13 Jul 2023 15:17:09 -0400
X-MC-Unique: qCypdEwGPku8zkWzBEhnfQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 108BF8564EF;
        Thu, 13 Jul 2023 19:17:09 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.50.6])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 474C0C478DF;
        Thu, 13 Jul 2023 19:17:08 +0000 (UTC)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     Kinglong Mee <kinglongmee@gmail.com>
Cc:     Anna Schumaker <anna@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>
Subject: Re: [PATCH] nfs: fix redundant readdir request after get eof
Date:   Thu, 13 Jul 2023 15:17:07 -0400
Message-ID: <5E28252D-6EA1-4DD9-A5B3-957E13589982@redhat.com>
In-Reply-To: <8d6d9329-f5f1-2f15-f578-e4f8010b9b02@gmail.com>
References: <8d6d9329-f5f1-2f15-f578-e4f8010b9b02@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 13 Jul 2023, at 10:52, Kinglong Mee wrote:

> When a directory contains 18 files (includes . and ..), nfs client sends
> a redundant readdir request after get eof.

This breaks the optimization in
85aa8ddc3818 NFS: Trigger the "ls -l" readdir heuristic sooner

The way to see that breakage happing is to "ls -l" a directory with more
than 16 dentries, and then when you do a 2nd "ls -l" you'll see that the NFS
client does a GETATTR for every single dentry instead of just the first 16
and then user READDIRPLUS for the rest.

I think what's going wrong with Kinglong's case is that when
array->folio_is_eof, we set desc->eof to the negation of desc->eob.  That
does the wrong thing for directories with 18 dentries.

Here's a way around it, but I hate how ugly it is just for this single case:


diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 8f3112e71a6a..ace454da9d4d 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -1107,14 +1107,20 @@ static void nfs_do_filldir(struct nfs_readdir_descriptor *desc,
                        desc->ctx->pos = desc->dir_cookie;
                else
                        desc->ctx->pos++;
+
                if (first_emit && i > NFS_READDIR_CACHE_MISS_THRESHOLD + 1) {
                        desc->eob = true;
-                       break;
+                       /* handle the case where there are NFS_READDIR_CACHE_MISS_THRESHOLD + 2
+                        * entries:  we also need to set desc->eof */
+                       if (array->folio_is_eof && i == array->size - 1)
+                               desc->eof = true;
+                       goto done;
                }
        }
        if (array->folio_is_eof)
                desc->eof = !desc->eob;

+done:
        kunmap_local(array);
        dfprintk(DIRCACHE, "NFS: nfs_do_filldir() filling ended @ cookie %llu\n",
                        (unsigned long long)desc->dir_cookie);

Ben

