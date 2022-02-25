Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B366C4C4F94
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Feb 2022 21:23:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235959AbiBYUY1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 25 Feb 2022 15:24:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235759AbiBYUY1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 25 Feb 2022 15:24:27 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7BDA32118EC
        for <linux-nfs@vger.kernel.org>; Fri, 25 Feb 2022 12:23:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645820632;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=efoR/dgzU1kxC4+EHfjxe13kh+xzJl8VZXkqKWfiGg8=;
        b=ETVBaqNYZGS0hBn8Z6pGNR8rBmar7WX28BJkU455BdNwOOmIYLkKdA0ynN7NMAhRfv3yLy
        i+YMLIb2cydBHK6JM+5mX0mj7b40/lViRWuVfuSpvPVn2iJzPVyEtqjMS7744EwuQ1CGNU
        9ZtaoCQJJGHsrpZxxofQUiKlNxzozG0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-663-dzz9yKjEPaCBMdwQG-s8UA-1; Fri, 25 Feb 2022 15:23:51 -0500
X-MC-Unique: dzz9yKjEPaCBMdwQG-s8UA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 40E0F1854E21;
        Fri, 25 Feb 2022 20:23:50 +0000 (UTC)
Received: from [172.16.176.1] (ovpn-64-2.rdu2.redhat.com [10.10.64.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CF3B984A08;
        Fri, 25 Feb 2022 20:23:49 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Trond Myklebust" <trondmy@hammerspace.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH v7 05/21] NFS: Store the change attribute in the directory
 page cache
Date:   Fri, 25 Feb 2022 15:23:48 -0500
Message-ID: <FDB38E78-8980-46CA-B936-F82C7C104071@redhat.com>
In-Reply-To: <6878D746-0A5E-4815-A520-5CE7CD98A1E2@redhat.com>
References: <20220223211305.296816-1-trondmy@kernel.org>
 <20220223211305.296816-2-trondmy@kernel.org>
 <20220223211305.296816-3-trondmy@kernel.org>
 <20220223211305.296816-4-trondmy@kernel.org>
 <20220223211305.296816-5-trondmy@kernel.org>
 <20220223211305.296816-6-trondmy@kernel.org>
 <0DBE97BF-3A88-49FD-B078-012B5EDA5849@redhat.com>
 <1ca16f7e7be9588d15525e3afa4f7a80eb66b12b.camel@hammerspace.com>
 <9506801a7b7b6330ce2807721da5e03d77cf5c78.camel@hammerspace.com>
 <640B2705-35C6-4E9E-89D2-CC3D0E10EC3A@redhat.com>
 <eb2a551096bb3537a9de7091d203e0cbff8dc6be.camel@hammerspace.com>
 <11744FC6-5EFB-427A-ADB4-D211BA1C74F4@redhat.com>
 <f9ca09baa9e41000ab6286a27de567ca306f6991.camel@hammerspace.com>
 <6878D746-0A5E-4815-A520-5CE7CD98A1E2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 25 Feb 2022, at 10:34, Benjamin Coddington wrote:
> Ok, so I'm reading that further proof is required, and I'm happy to do =

> the
> work.  Thanks for the replies here and elsewhere.

Here's an example of this problem on a tmpfs export using v8 of your
patchset with the fix to set the change_attr in
nfs_readdir_page_init_array().

I'm using tmpfs, because it reliably orders cookies in reverse order of
creation (or perhaps sorted by name).

The program drives both the client-side and server-side - so on this one
system, /exports/tmpfs is:
tmpfs /exports/tmpfs tmpfs rw,seclabel,relatime,size=3D102400k 0 0

and /mnt/localhost is:
localhost:/exports/tmpfs /mnt/localhost/tmpfs nfs4 =

rw,relatime,vers=3D4.1,rsize=3D1048576,wsize=3D1048576,namlen=3D255,hard,=
proto=3Dtcp,timeo=3D600,retrans=3D2,sec=3Dsys,clientaddr=3D127.0.0.1,loca=
l_lock=3Dnone,addr=3D127.0.0.1 =

0 0

The program creates 256 files on the server, walks through them once on =

the
client, deletes the last 127 on the server, drops the first page from =

the
pagecache, and walks through them again on the client.

The second listing produces 124 duplicate entries.

I just have to say again: this behavior is _new_ (but not new to me), =

and it
is absolutely going to crop up on our customer's systems that are =

walking
through millions of directory entries on loaded servers under memory
pressure.  The directory listings as a whole become very likely to be
nonsense at random times.  I realize they are not /supposed/ to be =

coherent,
but what we're getting here is going to be far far less coherent, and =

its
going to be a mess.

There are other scenarios that are worse when the cookies aren't =

ordered,
you can end up with EOF, or get into repeating patterns.

Please compare this with v3, and before this patchset, and tell me if =

I'm
not justified playing chicken little.

Here's what I do to run this:

mount -t tmpfs -osize=3D100M tmpfs /exports/tmpfs/
exportfs -ofsid=3D0 *:/exports
exportfs -ofsid=3D1 *:/exports/tmpfs
mount -t nfs -ov4.1,sec=3Dsys localhost:/exports /mnt/localhost
=2E/getdents2

Compare "Listing 1" with "Listing 2".

I would also do a "rm -f /export/tmpfs/*" between each run.

Thanks again for your time and work.

Ben

#define _GNU_SOURCE
#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>
#include <sched.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/syscall.h>
#include <string.h>

#define NFSDIR "/mnt/localhost/tmpfs"
#define LOCDIR "/exports/tmpfs"
#define BUF_SIZE 4096

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

     /* create files: */
     for (i =3D 0; i < 256; i++) {
         sprintf(buf, LOCDIR "/file_%03d", i);
         close(open(buf, O_CREAT, 666));
     }

	dir_fd =3D open(NFSDIR, O_RDONLY|O_NONBLOCK|O_DIRECTORY|O_CLOEXEC);
	if (dir_fd < 0) {
		perror("cannot open dir");
		return 1;
	}

	while (1) {
		nread =3D syscall(SYS_getdents, dir_fd, buf, BUF_SIZE);
		if (nread =3D=3D 0 || nread =3D=3D -1)
			break;
		for (bpos =3D 0; bpos < nread;) {
             d =3D (struct linux_dirent *) (buf + bpos);
             printf("%s\n", d->d_name);
             total++;
             bpos +=3D d->d_reclen;
         }
     }
     printf("Listing 1: %d total dirents\n", total);

     /* rewind */
     lseek(dir_fd, 0, SEEK_SET);

     /* drop the first page */
     posix_fadvise(dir_fd, 0, 4096, POSIX_FADV_DONTNEED);

     /* delete the last 127 files: */
     for (i =3D 127; i < 256; i++) {
         sprintf(buf, LOCDIR "/file_%03d", i);
         unlink(buf);
     }

     total =3D 0;
	while (1) {
		nread =3D syscall(SYS_getdents, dir_fd, buf, BUF_SIZE);
		if (nread =3D=3D 0 || nread =3D=3D -1)
			break;
		for (bpos =3D 0; bpos < nread;) {
             d =3D (struct linux_dirent *) (buf + bpos);
             printf("%s\n", d->d_name);
             total++;
             bpos +=3D d->d_reclen;
         }
     }
     printf("Listing 2: %d total dirents\n", total);

	close(dir_fd);
	return 0;
}

