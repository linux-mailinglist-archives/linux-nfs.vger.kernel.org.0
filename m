Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E5446B2D47
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Mar 2023 19:59:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbjCIS7q (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 9 Mar 2023 13:59:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbjCIS7n (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 9 Mar 2023 13:59:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 001B57FD6F
        for <linux-nfs@vger.kernel.org>; Thu,  9 Mar 2023 10:58:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678388339;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=GU09v3W+Alt0ZnZMrP02EndybbzLMUMwOBIPy77F3Zg=;
        b=C0PoukSKDpNtnL40YE/DBaw3fgbWj+PRtadnALBOUo9e9zHY9l1T3YIKh/76D8vGNHCoXV
        nT+SJXeFoIHXZ/sUs/dLElkpYYr/dGinIyVlj+6KQcOnnn2cfSltoS3eczqvLIWEG+FBZY
        zXAetOY6oWv++vNMIL66Wi1tpi8n6F8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-149-MBmivV_FOB6FLl8hyEe61A-1; Thu, 09 Mar 2023 13:58:53 -0500
X-MC-Unique: MBmivV_FOB6FLl8hyEe61A-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4B66C3814594;
        Thu,  9 Mar 2023 18:58:53 +0000 (UTC)
Received: from dwysocha.rdu.csb (unknown [10.22.16.140])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1F075492B05;
        Thu,  9 Mar 2023 18:58:53 +0000 (UTC)
From:   Dave Wysochanski <dwysocha@redhat.com>
To:     Anna Schumaker <anna.schumaker@netapp.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Daire Byrne <daire.byrne@gmail.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 0/1] NFS: Fix read_bytes for buffered reads
Date:   Thu,  9 Mar 2023 13:58:51 -0500
Message-Id: <20230309185852.1151546-1-dwysocha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This patch fixes the read_bytes count for NFS buffered reads.
Simple reproducer follows.

Before this patch:
# mount 127.0.0.1:/ /mnt/nfs
# bash
# function dump_stats { cat /proc/$$/io; }
# trap dump_stats EXIT
# cat /mnt/nfs/file1.bin > /dev/null
# exit
exit
rchar: 3587436
wchar: 1054077
syscr: 544
syscw: 33
read_bytes: 0
write_bytes: 0
cancelled_write_bytes: 0


After this patch:
# mount 127.0.0.1:/ /mnt/nfs
# bash
# function dump_stats { cat /proc/$$/io; }
# trap dump_stats EXIT
# cat /mnt/nfs/file1.bin > /dev/null
# exit
exit
rchar: 3587278
wchar: 1054161
syscr: 544
syscw: 33
read_bytes: 1048576
write_bytes: 0
cancelled_write_bytes: 0


Dave Wysochanski (1):
  NFS: Fix /proc/PID/io read_bytes for buffered reads

 fs/nfs/read.c | 3 +++
 1 file changed, 3 insertions(+)

-- 
2.31.1

