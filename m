Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEB316838FD
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Jan 2023 23:03:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbjAaWDM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 31 Jan 2023 17:03:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbjAaWDL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 31 Jan 2023 17:03:11 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB065470A8
        for <linux-nfs@vger.kernel.org>; Tue, 31 Jan 2023 14:02:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675202543;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NqYEE0jFJj7SvDA0lFMBcUqKqLGf1HHYHnxs0G12G+A=;
        b=aSVVUn2YgN6/cqaXZYLnLROSJFXkXdU4YieJVKhMpH6dQc60lkGmASGf0UsLqWGuTnBA/3
        gBogIQOhF/eXU1JtI50rZV5aIaG0/9aLl4uhVmdyJIWsom5P8bnZNaRvTEUZsYEePLCrFp
        BHV89DM65MI3TFoVM2iUFPFngPXkx1U=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-489-t-yB_gnYOAOOESmG3lnIqQ-1; Tue, 31 Jan 2023 17:02:21 -0500
X-MC-Unique: t-yB_gnYOAOOESmG3lnIqQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1399A85CCE6;
        Tue, 31 Jan 2023 22:02:21 +0000 (UTC)
Received: from [172.16.176.1] (unknown [10.22.50.5])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A3EB2492B05;
        Tue, 31 Jan 2023 22:02:20 +0000 (UTC)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: git regression failures with v6.2-rc NFS client
Date:   Tue, 31 Jan 2023 17:02:18 -0500
Message-ID: <D0404F55-2692-4DB6-8DD6-CAC004331AC1@redhat.com>
In-Reply-To: <9A4A5673-691D-47EC-BC44-C43BE7E50A48@oracle.com>
References: <9A4A5673-691D-47EC-BC44-C43BE7E50A48@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
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

On 31 Jan 2023, at 16:15, Chuck Lever III wrote:

> Hi-
>
> I upgraded my test client's kernel to v6.2-rc5 and now I get
> failures during the git regression suite on all NFS versions.
> I bisected to:
>
> 85aa8ddc3818 ("NFS: Trigger the "ls -l" readdir heuristic sooner")
>
> The failure looks like:
>
> not ok 6 - git am --skip succeeds despite D/F conflict
> #
> #               test_when_finished "git -C df_plus_edit_edit clean -f" =
&&
> #               test_when_finished "git -C df_plus_edit_edit reset --ha=
rd" &&
> #               (
> #                       cd df_plus_edit_edit &&
> #
> #                       git checkout f-edit^0 &&
> #                       git format-patch -1 d-edit &&
> #                       test_must_fail git am -3 0001*.patch &&
> #
> #                       git am --skip &&
> #                       test_path_is_missing .git/rebase-apply &&
> #                       git ls-files -u >conflicts &&
> #                       test_must_be_empty conflicts
> #               )
> #
> # failed 1 among 6 test(s)
> 1..6
> make[2]: *** [Makefile:60: t1015-read-index-unmerged.sh] Error 1
> make[2]: *** Waiting for unfinished jobs....
>
> The regression suite is run like this:
>
> RESULTS=3D some random directory under /tmp
> RELEASE=3D"git-2.37.1"
>
> rm -f ${RELEASE}.tar.gz
> curl --no-progress-meter -O https://mirrors.edge.kernel.org/pub/softwar=
e/scm/git/${RELEASE}.tar.gz
> /usr/bin/time tar zxf ${RELEASE}.tar.gz >> ${RESULTS}/git 2>&1
>
> cd ${RELEASE}
> make clean >> ${RESULTS}/git 2>&1
> /usr/bin/time make -j${THREADS} all doc >> ${RESULTS}/git 2>&1
>
> /usr/bin/time make -j${THREADS} test >> ${RESULTS}/git 2>&1
>
> On this client, THREADS=3D12. A single-thread run doesn't seem to
> trigger a problem. So unfortunately the specific data I have is
> going to be noisy.

I'll attempt to reproduce this and see what's up.  This is an export of
tmpfs?  If so, I suspect you might be running into tmpfs' unstable cookie=

problem when two processes race through nfs_do_filldir().. and if so, the=

cached listing of the directory on the client won't match a listing on th=
e
server.

Ben

