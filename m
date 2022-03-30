Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2F194EBED8
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Mar 2022 12:35:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245415AbiC3Kgt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 30 Mar 2022 06:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236836AbiC3Kgt (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 30 Mar 2022 06:36:49 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A46342BB0D
        for <linux-nfs@vger.kernel.org>; Wed, 30 Mar 2022 03:35:04 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 614A31F38C;
        Wed, 30 Mar 2022 10:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1648636503; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=MVY3xDbdYWFY+bu/thAheZFx3IvpncHOy7TCUkY6JyU=;
        b=1PJN3z4/PK/Sg7e+swm+TmY2dkzbnVtJn2Ju8ygzOSIB7+CZvoJkjFe7p2/4WqJgniWe4M
        Eo0MjCgsEX+6Y90a01CbCtljXv7dCJarOW9Nfc8MCYt+r5QcFgkLetxSw6+q9EfX+K5+x5
        y2ao7RKCmgImDRV4T+01F8V+W5lvWSQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1648636503;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=MVY3xDbdYWFY+bu/thAheZFx3IvpncHOy7TCUkY6JyU=;
        b=qbRP3Wy/ItjLJ2aiPcAPgXwFLgU+yxcq4jfyDGEMkfZ8i0mq7/NPlwr3rLGJusQqkUyR8K
        Enkc2A2/WMvtzXBg==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 520D0A3B89;
        Wed, 30 Mar 2022 10:35:03 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 9EBE5A0610; Wed, 30 Mar 2022 12:34:57 +0200 (CEST)
Date:   Wed, 30 Mar 2022 12:34:57 +0200
From:   Jan Kara <jack@suse.cz>
To:     Trond Myklebust <trondmy@gmail.com>
Cc:     "J. Bruce Fields" <bfields@redhat.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-nfs@vger.kernel.org, nfbrown@suse.com
Subject: Performance regression with random IO pattern from the client
Message-ID: <20220330103457.r4xrhy2d6nhtouzk@quack3.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hello,

during our performance testing we have noticed that commit b6669305d35a
("nfsd: Reduce the number of calls to nfsd_file_gc()") has introduced a
performance regression when a client does random buffered writes. The
workload on NFS client is fio running 4 processed doing random buffered writes to 4
different files and the files are large enough to hit dirty limits and
force writeback from the client. In particular the invocation is like:

fio --direct=0 --ioengine=sync --thread --directory=/mnt/mnt1 --invalidate=1 --group_reporting=1 --runtime=300 --fallocate=posix --ramp_time=10 --name=RandomReads-128000-4k-4 --new_group --rw=randwrite --size=4000m --numjobs=4 --bs=4k --filename_format=FioWorkloads.\$jobnum --end_fsync=1

The reason why commit b6669305d35a regresses performance is the
filemap_flush() call it adds into nfsd_file_put(). Before this commit
writeback on the server happened from nfsd_commit() code resulting in
rather long semisequential streams of 4k writes. After commit b6669305d35a
all the writeback happens from filemap_flush() calls resulting in much
longer average seek distance (IO from different files is more interleaved)
and about 16-20% regression in the achieved writeback throughput when the
backing store is rotational storage.

I think the filemap_flush() from nfsd_file_put() is indeed rather
aggressive and I think we'd be better off to just leave writeback to either
nfsd_commit() or standard dirty page cleaning happening on the system. I
assume the rationale for the filemap_flush() call was to make it more
likely the file can be evicted during the garbage collection run? Was there
any particular problem leading to addition of this call or was it just "it
seemed like a good idea" thing?

Thanks in advance for ideas.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
