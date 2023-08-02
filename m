Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E21B76D7AE
	for <lists+linux-nfs@lfdr.de>; Wed,  2 Aug 2023 21:26:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231426AbjHBT0C (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 2 Aug 2023 15:26:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbjHBT0B (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 2 Aug 2023 15:26:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E97EF1995
        for <linux-nfs@vger.kernel.org>; Wed,  2 Aug 2023 12:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691004317;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=z+NCAApqbNw2Pro3K3FkTCUJU1Tn5lJ6dVDlokitvGg=;
        b=ImczoTgfKcc4FokDUbiTPtU1lZFjt2s0+dl0M4TqAVbXnw+6B+kdT270fSHEVhCvY9aNyl
        goYDYJ+CiUbAfuCjeO3jK2M5qaompzdOFSRvA+X3iYPjEmjTRlv8gPtrcDSLKh02q6XHpA
        e3S4nDmoObG0ghhf/9hWrKmoJ5WA4z8=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-54-LPHvGBpGNSuSJJawTwDbYg-1; Wed, 02 Aug 2023 15:25:15 -0400
X-MC-Unique: LPHvGBpGNSuSJJawTwDbYg-1
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1bb29dc715bso1369745ad.1
        for <linux-nfs@vger.kernel.org>; Wed, 02 Aug 2023 12:25:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691004314; x=1691609114;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z+NCAApqbNw2Pro3K3FkTCUJU1Tn5lJ6dVDlokitvGg=;
        b=YhK6XP8flWGK0+Y9Cd8UMOe8YGp34kVffoczU6A/WIUbpRsgxi2zdqYVKjxS6vtU61
         P1QQFR3443ZpzI/5u+IVQfAeG5GlQOBliKhJxlT9+V7WxneF49QeLzQAXr7qkGjM0tqC
         xQ5rERdWPFyzrPbB4qWggeaCOX97ThNHUICqrzvc4/TntNaQxenn5QWs35LtBBTaDspw
         cnmtl89i1GNquhFBrIoBOWXXOW7/j/CXfo4fpIpOUUxx4Kbs19eOXa1eSmvpI4YeQo+D
         A8nWXfzkx6DNRc0VPtt/AMS5vovPUuFy2u8f5LWqNtjXwrroXxsxtjYSg8WIE6nU1VjY
         opxw==
X-Gm-Message-State: ABy/qLa16Wklnqnm0MWfMv+8Vgi/7p/s785VPFHX07WHS6TM6klxbhFj
        l5cFAurWvi6qZjTufp59lfunlpPfRW1jr5XvdiRyQ8kl8Yj6zCd5yJOmpJ5X2vDBh4DVAjiAZP7
        CGKOwW91gw2ZV7gfZlCv9
X-Received: by 2002:a17:902:e809:b0:1b8:7613:594d with SMTP id u9-20020a170902e80900b001b87613594dmr21942598plg.24.1691004314512;
        Wed, 02 Aug 2023 12:25:14 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHZiwFlmOJ2fvSoNElkqU2gYznUU3MA3Fp61RAewpOqQ2xV9KWv0TiIR6/ORMRQmdlwKTIt8Q==
X-Received: by 2002:a17:902:e809:b0:1b8:7613:594d with SMTP id u9-20020a170902e80900b001b87613594dmr21942576plg.24.1691004314186;
        Wed, 02 Aug 2023 12:25:14 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id b21-20020a170902d31500b001b552309aedsm12767209plc.192.2023.08.02.12.25.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 12:25:13 -0700 (PDT)
Date:   Thu, 3 Aug 2023 03:25:10 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2] nfs: test files written size as expected
Message-ID: <20230802192510.tecctatj3kqcw3e4@zlang-mailbox>
References: <20230802054646.2197854-1-zlang@kernel.org>
 <20230802163640.GY11352@frogsfrogsfrogs>
 <20230802172418.2ulrealxsj2cvnxo@zlang-mailbox>
 <20230802174326.GL11340@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230802174326.GL11340@frogsfrogsfrogs>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Aug 02, 2023 at 10:43:26AM -0700, Darrick J. Wong wrote:
> On Thu, Aug 03, 2023 at 01:24:18AM +0800, Zorro Lang wrote:
> > On Wed, Aug 02, 2023 at 09:36:40AM -0700, Darrick J. Wong wrote:
> > > On Wed, Aug 02, 2023 at 01:46:46PM +0800, Zorro Lang wrote:
> > > > Test nfs and its underlying fs, make sure file size as expected
> > > > after writting a file, and the speculative allocation space can
> > > > be shrunken.
> > > > 
> > > > Signed-off-by: Zorro Lang <zlang@kernel.org>
> > > > ---
> > > > 
> > > > Last year I sent a patch to fstests@, but it sometimes fails on the upstream
> > > > kernel that year:
> > > > 
> > > >   https://lore.kernel.org/fstests/Y3vTbHqT64gsQ573@magnolia/
> > > > 
> > > > And we didn't get a proper reason for that, so that patch was blocked. Now
> > > > I found this case test passed on current upstream linux [1] (after loop
> > > > running it a whole night). So I think it's time to rebase and re-send this
> > > > patch to get review.
> > > > 
> > > > Thanks,
> > > > Zorro
> > > > 
> > > > [1]
> > > > FSTYP         -- nfs
> > > > PLATFORM      -- Linux/x86_64 xxxx 6.5.0-rc4 #1 SMP PREEMPT_DYNAMIC Tue Aug  1 15:32:55 EDT 2023
> > > > MKFS_OPTIONS  -- xxxx.redhat.com:/mnt/xfstests/scratch/nfs-server
> > > > MOUNT_OPTIONS -- -o vers=4.2 -o context=system_u:object_r:root_t:s0 xxxx.redhat.com:/mnt/xfstests/scratch/nfs-server /mnt/xfstests/scratch/nfs-client
> > > > 
> > > > nfs/002 4s ...  4s
> > > > Ran: nfs/002
> > > > Passed all 1 tests
> > > > 
> > > >  tests/nfs/002     | 46 ++++++++++++++++++++++++++++++++++++++++++++++
> > > >  tests/nfs/002.out |  2 ++
> > > >  2 files changed, 48 insertions(+)
> > > >  create mode 100755 tests/nfs/002
> > > >  create mode 100644 tests/nfs/002.out
> > > > 
> > > > diff --git a/tests/nfs/002 b/tests/nfs/002
> > > > new file mode 100755
> > > > index 00000000..b4b6554c
> > > > --- /dev/null
> > > > +++ b/tests/nfs/002
> > > > @@ -0,0 +1,46 @@
> > > > +#! /bin/bash
> > > > +# SPDX-License-Identifier: GPL-2.0
> > > > +# Copyright (c) 2023 Red Hat, Inc.  All Rights Reserved.
> > > > +#
> > > > +# FS QA Test 002
> > > > +#
> > > > +# Make sure nfs gets expected file size after writting a big sized file. It's
> > > > +# not only testing nfs, test its underlying fs too. For example a known old bug
> > > > +# on xfs (underlying fs) caused nfs get larger file size (e.g. 16M) after
> > > > +# writting 10M data to a file. It's fixed by a series of patches around
> > > > +# 579b62faa5fb16 ("xfs: add background scanning to clear eofblocks inodes")
> > > 
> > > Er... has this been banging around in the trunk for 11 years? ;)
> > 
> > Yeah, that's an old enough test case :-D I tried to tidy our internal test cases,
> > felt this case can be in fstests.
> > 
> > > 
> > > > +#
> > > > +. ./common/preamble
> > > > +_begin_fstest auto quick rw
> > > > +
> > > > +# real QA test starts here
> > > > +_supported_fs nfs
> > > > +# Need a series of patches related with this patch
> > > > +_fixed_by_kernel_commit 579b62faa5fb16 \
> > > > +	"xfs: add background scanning to clear eofblocks inodes"
> > > > +_require_test
> > > > +
> > > > +localfile=$TEST_DIR/testfile.$seq
> > > > +rm -rf $localfile
> > > > +
> > > > +$XFS_IO_PROG -f -t -c "pwrite 0 10m" -c "fsync" $localfile >>$seqres.full 2>&1
> > > > +block_size=`stat -c '%B' $localfile`
> > > > +iblocks_expected=$((10 * 1024 * 1024 / $block_size))
> > > > +# Try several times for the speculative allocated file size can be shrunken
> > > > +res=1
> > > > +for ((i=0; i<10; i++));do
> > > > +	iblocks_real=`stat -c '%b' $localfile`
> > > > +	if [ "$iblocks_expected" = "$iblocks_real" ];then
> > > 
> > > What happens if real < expected?  Should there be some sort of bail out
> > > for unexpected things like that?
> > 
> > Hmm... I never thought that. I saw the real >= expected, is there any
> > chance to get real < expected?
> 
> <shrug> Suppose the NFS server is running on top of a filesystem that
> supports compression and i_blocks as returned by stat reflects that?
> 
> --D
> 
> > > 
> > > > +		res=0
> > > > +		break
> > > > +	fi
> > > > +	sleep 10
> > > > +done
> > > 
> > > Though I guess the runtime is capped at ~100s so maybe it doesn't
> > > matter practically.
> > 
> > Mostly the test done in several seconds in my testing:
> > 
> > FSTYP         -- nfs
> > PLATFORM      -- Linux/x86_64 hp-dl360g9-06 6.5.0-rc4 #1 SMP PREEMPT_DYNAMIC Tue Aug  1 15:32:55 EDT 2023
> > MKFS_OPTIONS  -- hp-dl360g9-06.rhts.eng.pek2.redhat.com:/mnt/xfstests/scratch/nfs-server
> > MOUNT_OPTIONS -- -o vers=4.2 -o context=system_u:object_r:root_t:s0 hp-dl360g9-06.rhts.eng.pek2.redhat.com:/mnt/xfstests/scratch/nfs-server /mnt/xfstests/scratch/nfs-client
> > 
> > nfs/002 5s ...  4s
> > Ran: nfs/002
> > Passed all 1 tests
> 
> Doesn't xfs remove the speculative preallocations every time a write fd
> is closed?
> 
> Yes, it does do that:
> https://lore.kernel.org/linux-xfs/155259894034.30230.7188877605950498518.stgit@magnolia/
> 
> IOWs, how is this test actually checking the behavior of background
> blockgc clearing out speculative preallocations?

OK, looks like this case is invalid. I'll keep it :)

Thanks,
Zorro

> 
> > > (What happens if xfs blockgc only runs every 5 minutes?)
> > 
> > How can can make that happen? If the 100s isn't enough, is there an upper
> > limit, or how to make an upper limit?
> 
> There's no way to tell over NFS...
> 
> --D
> 
> > 
> > Thanks,
> > Zorro
> > 
> > > 
> > > --D
> > > 
> > > > +if [ $res -ne 0 ];then
> > > > +	echo "Write $iblocks_expected blocks, but get $iblocks_real blocks"
> > > > +fi
> > > > +
> > > > +echo "Silence is golden"
> > > > +# success, all done
> > > > +status=0
> > > > +exit
> > > > diff --git a/tests/nfs/002.out b/tests/nfs/002.out
> > > > new file mode 100644
> > > > index 00000000..61705c7c
> > > > --- /dev/null
> > > > +++ b/tests/nfs/002.out
> > > > @@ -0,0 +1,2 @@
> > > > +QA output created by 002
> > > > +Silence is golden
> > > > -- 
> > > > 2.40.1
> > > > 
> > > 
> > 
> 

