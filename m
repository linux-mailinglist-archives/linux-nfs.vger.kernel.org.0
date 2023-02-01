Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A13B7686806
	for <lists+linux-nfs@lfdr.de>; Wed,  1 Feb 2023 15:11:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231131AbjBAOLX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 1 Feb 2023 09:11:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjBAOLX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 1 Feb 2023 09:11:23 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A0025925D
        for <linux-nfs@vger.kernel.org>; Wed,  1 Feb 2023 06:10:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675260637;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/KApPw7TMUlKDalc3A2OFcWnmWXJTqmSZlULjYuDgfE=;
        b=Fzwg7NR2yJyTyuXe1cRB/3l03Bz/QyRQKilfmS8q+N/K8VMfk8VguYCuOwu5i/E9GT8ixE
        V+D4QPmMXDDRhKhLnXj8rJdCNU785zpQH9G59RDCJhN4PRTGAz7YKPPPkx8Ct/aDf7EcRw
        LZm+mPh5sYEKnSHiy5xtpiq4/xdUt5I=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-115-JoE9opv2MCydsk94vJ5gQQ-1; Wed, 01 Feb 2023 09:10:34 -0500
X-MC-Unique: JoE9opv2MCydsk94vJ5gQQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 07D0429AA388;
        Wed,  1 Feb 2023 14:10:34 +0000 (UTC)
Received: from [172.16.176.1] (unknown [10.22.50.5])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 902392026D4B;
        Wed,  1 Feb 2023 14:10:33 +0000 (UTC)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: git regression failures with v6.2-rc NFS client
Date:   Wed, 01 Feb 2023 09:10:31 -0500
Message-ID: <5FF4061F-108C-4555-A32D-DDBFA80EE4E7@redhat.com>
In-Reply-To: <D0404F55-2692-4DB6-8DD6-CAC004331AC1@redhat.com>
References: <9A4A5673-691D-47EC-BC44-C43BE7E50A48@oracle.com>
 <D0404F55-2692-4DB6-8DD6-CAC004331AC1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 31 Jan 2023, at 17:02, Benjamin Coddington wrote:

> On 31 Jan 2023, at 16:15, Chuck Lever III wrote:
>
>> Hi-
>>
>> I upgraded my test client's kernel to v6.2-rc5 and now I get
>> failures during the git regression suite on all NFS versions.
>> I bisected to:
>>
>> 85aa8ddc3818 ("NFS: Trigger the "ls -l" readdir heuristic sooner")
>>
>> The failure looks like:
>>
>> not ok 6 - git am --skip succeeds despite D/F conflict
>> #
>> #               test_when_finished "git -C df_plus_edit_edit clean -f"=
 &&
>> #               test_when_finished "git -C df_plus_edit_edit reset --h=
ard" &&
>> #               (
>> #                       cd df_plus_edit_edit &&
>> #
>> #                       git checkout f-edit^0 &&
>> #                       git format-patch -1 d-edit &&
>> #                       test_must_fail git am -3 0001*.patch &&
>> #
>> #                       git am --skip &&
>> #                       test_path_is_missing .git/rebase-apply &&
>> #                       git ls-files -u >conflicts &&
>> #                       test_must_be_empty conflicts
>> #               )
>> #
>> # failed 1 among 6 test(s)
>> 1..6
>> make[2]: *** [Makefile:60: t1015-read-index-unmerged.sh] Error 1
>> make[2]: *** Waiting for unfinished jobs....
>>
>> The regression suite is run like this:
>>
>> RESULTS=3D some random directory under /tmp
>> RELEASE=3D"git-2.37.1"
>>
>> rm -f ${RELEASE}.tar.gz
>> curl --no-progress-meter -O https://mirrors.edge.kernel.org/pub/softwa=
re/scm/git/${RELEASE}.tar.gz
>> /usr/bin/time tar zxf ${RELEASE}.tar.gz >> ${RESULTS}/git 2>&1
>>
>> cd ${RELEASE}
>> make clean >> ${RESULTS}/git 2>&1
>> /usr/bin/time make -j${THREADS} all doc >> ${RESULTS}/git 2>&1
>>
>> /usr/bin/time make -j${THREADS} test >> ${RESULTS}/git 2>&1
>>
>> On this client, THREADS=3D12. A single-thread run doesn't seem to
>> trigger a problem. So unfortunately the specific data I have is
>> going to be noisy.
>
> I'll attempt to reproduce this and see what's up.  This is an export of=

> tmpfs?  If so, I suspect you might be running into tmpfs' unstable cook=
ie
> problem when two processes race through nfs_do_filldir().. and if so, t=
he
> cached listing of the directory on the client won't match a listing on =
the
> server.

It doesn't reproduce on ext4, but I can see it on an export of tmpfs.

Unsurprisingly the pattern is getdents() returning 19 entries (17 for the=

first emit and "." and ".."), then unlinking those and the next getdents(=
)
returning 0.

Here's a reproducer which fails on tmpfs but works properly on exports of=

ext4 and xfs:

#define _GNU_SOURCE
#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>
#include <sched.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/syscall.h>
#include <string.h>

#define NFSDIR "/mnt/tmpfs/dirtest"
#define BUF_SIZE 4096
#define COUNT 18

int main(int argc, char **argv)
{
    int i, dir_fd, bpos, total =3D 0;
    size_t nread;
    struct linux_dirent {
        long           d_ino;
        off_t          d_off;
        unsigned short d_reclen;
        char           d_name[];
    };
    struct linux_dirent *d;
    char buf[BUF_SIZE];

    /* create files */
    for (i =3D 0; i < COUNT; i++) {
        sprintf(buf, NFSDIR "/file_%03d", i);
        close(open(buf, O_CREAT, 666));
	total++;
    }
    printf("created %d total dirents\n", total);

    dir_fd =3D open(NFSDIR, O_RDONLY|O_NONBLOCK|O_DIRECTORY|O_CLOEXEC);
    if (dir_fd < 0) {
        perror("cannot open dir");
        return 1;
    }

    /* drop the first page */
    posix_fadvise(dir_fd, 0, 4096, POSIX_FADV_DONTNEED);
    total =3D 0;

    while (1) {
        nread =3D syscall(SYS_getdents, dir_fd, buf, BUF_SIZE);
        if (nread =3D=3D 0 || nread =3D=3D -1)
            break;
        for (bpos =3D 0; bpos < nread;) {
            d =3D (struct linux_dirent *) (buf + bpos);

	    if (d->d_name[0] !=3D '.') {
		    printf("%s\n", d->d_name);
		    unlinkat(dir_fd, d->d_name, 0);
		    total++;
	    }
            bpos +=3D d->d_reclen;
        }
    }
    printf("found and deleted %d dirents\n", total);
    close(dir_fd);

    printf("rmdir returns %d\n", rmdir(NFSDIR));
    return 0;
}

The client is doing uncached_readdir looking for cookie 19, but tmpfs has=

re-ordered the last file into cookie 3 on the second READDIR.

I think this is a different case of the problems discussed about unstable=

readdir cookies on the last round of directory cache improvements, but si=
nce
we're now returning after 17 entries the problem is exposed on a director=
y
containing 18 files, rather than 128.

Working on a fix..

Ben

