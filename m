Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A01D64C27F3
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Feb 2022 10:18:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231698AbiBXJRM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 24 Feb 2022 04:17:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231421AbiBXJRL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 24 Feb 2022 04:17:11 -0500
Received: from eu-shark2.inbox.eu (eu-shark2.inbox.eu [195.216.236.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 201CC245BA
        for <linux-nfs@vger.kernel.org>; Thu, 24 Feb 2022 01:16:39 -0800 (PST)
Received: from eu-shark2.inbox.eu (localhost [127.0.0.1])
        by eu-shark2-out.inbox.eu (Postfix) with ESMTP id 302501E00529;
        Thu, 24 Feb 2022 11:16:37 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=inbox.eu; s=20140211;
        t=1645694197; bh=7UAr64T2zZtoffWM/Fknpu8Fst0Hb7CMRmfm7azspQg=;
        h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
         Content-Type:X-ESPOL:from:date:to:cc;
        b=aA3ZFZuvKu10oHUR+dAQv5JWiZC4F2ASS7bAe2PxEMHZVxdz3T7logrwdR80Z+8f7
         cSjAmi6U6GS4A0flrUlKwhvtXrvooM1FT06m2lSQ8kbBlMcydvVABz/hxhM7DTu+GC
         ri8w7mgQ76/ycIose0T/jDhpCO/i3U4FT4tUNxHw=
Received: from localhost (localhost [127.0.0.1])
        by eu-shark2-in.inbox.eu (Postfix) with ESMTP id 214341E00553;
        Thu, 24 Feb 2022 11:16:37 +0200 (EET)
Received: from eu-shark2.inbox.eu ([127.0.0.1])
        by localhost (eu-shark2.inbox.eu [127.0.0.1]) (spamfilter, port 35)
        with ESMTP id UiGB0HAz9zWj; Thu, 24 Feb 2022 11:16:36 +0200 (EET)
Received: from mail.inbox.eu (eu-pop1 [127.0.0.1])
        by eu-shark2-in.inbox.eu (Postfix) with ESMTP id 5869D1E00529;
        Thu, 24 Feb 2022 11:16:36 +0200 (EET)
References: <OS3PR01MB770539462BE3E7959DAF8B5789389@OS3PR01MB7705.jpnprd01.prod.outlook.com>
 <20220219113412.7ov4tbkisv4vnmo3@wittgenstein>
 <55aef6aa0e1825c1709051091c7bf849fccbda32.camel@hammerspace.com>
 <20220223084425.uq75dqfwymgfayus@wittgenstein>
 <be3b341c4f0cf177b78f55de70cdb3a15ed808f4.camel@hammerspace.com>
 <20220223160926.iidztq5nf3wssw4m@wittgenstein>
 <20220224085233.ojnqly7bbk2pnqzp@wittgenstein>
User-agent: mu4e 1.7.0; emacs 27.2
From:   Su Yue <l@damenly.su>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        "suy.fnst@fujitsu.com" <suy.fnst@fujitsu.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [bug?] nfs setgid inheritance
Date:   Thu, 24 Feb 2022 17:06:23 +0800
In-reply-to: <20220224085233.ojnqly7bbk2pnqzp@wittgenstein>
Message-ID: <bkywsjyr.fsf@damenly.su>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: OK
X-ESPOL: 6NpmlYxOGzysiV+lRWetdgtNzzYrL+Dh557a3RxZn2X7NSyaf0wMThG+nHAFM3H44X8X
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On Thu 24 Feb 2022 at 09:52, Christian Brauner=20
<brauner@kernel.org> wrote:

> On Wed, Feb 23, 2022 at 05:09:26PM +0100, Christian Brauner=20
> wrote:
>> On Wed, Feb 23, 2022 at 12:24:02PM +0000, Trond Myklebust=20
>> wrote:
>> > On Wed, 2022-02-23 at 09:44 +0100, Christian Brauner wrote:
>> > > On Sat, Feb 19, 2022 at 05:00:18PM +0000, Trond Myklebust=20
>> > > wrote:
>> > > > On Sat, 2022-02-19 at 12:34 +0100, Christian Brauner=20
>> > > > wrote:
>> > > > > On Sat, Feb 19, 2022 at 08:34:30AM +0000,
>> > > > > suy.fnst@fujitsu.com=C2=A0wrote:
>> > > > > > Hi NFS folks,
>> > > > > > =C2=A0 During our xfstests, we found generic/633 fails=20
>> > > > > > like:
>> > > > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> > > > > > FSTYP=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -- nfs
>> > > > > > PLATFORM=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -- Linux/x86_64 btrfs 5=
.17.0-rc4-custom=20
>> > > > > > #236 SMP
>> > > > > > PREEMPT Sat Feb 19 15:09:03 CST 2022
>> > > > > > MKFS_OPTIONS=C2=A0 -- 127.0.0.1:/nfsscratch
>> > > > > > MOUNT_OPTIONS -- -o vers=3D4 127.0.0.1:/nfsscratch=20
>> > > > > > /mnt/scratch
>> > > > > >
>> > > > > > generic/633 0s ... [failed, exit status 1]- output=20
>> > > > > > mismatch
>> > > > > > (see
>> > > > > > /root/xfstests-dev/results//generic/633.out.bad)
>> > > > > > =C2=A0=C2=A0=C2=A0 --- tests/generic/633.out=C2=A0=C2=A0 2021-=
05-23=20
>> > > > > > 14:03:08.879999997
>> > > > > > +0800
>> > > > > > =C2=A0=C2=A0=C2=A0 +++=20
>> > > > > > /root/xfstests-dev/results//generic/633.out.bad 2022-
>> > > > > > 02-19
>> > > > > > 16:31:28.660000013 +0800
>> > > > > > =C2=A0=C2=A0=C2=A0 @@ -1,2 +1,4 @@
>> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0 QA output created by 633
>> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0 Silence is golden
>> > > > > > =C2=A0=C2=A0=C2=A0 +idmapped-mounts.c: 7906: setgid_create - S=
uccess=20
>> > > > > > -
>> > > > > > failure:
>> > > > > > is_setgid
>> > > > > > =C2=A0=C2=A0=C2=A0 +idmapped-mounts.c: 13907: run_test - Succe=
ss -=20
>> > > > > > failure:
>> > > > > > create
>> > > > > > operations in directories with setgid bit set
>> > > > > > =C2=A0=C2=A0=C2=A0 ...
>> > > > > > =C2=A0=C2=A0=C2=A0 (Run 'diff -u=20
>> > > > > > /root/xfstests-dev/tests/generic/633.out
>> > > > > > /root/xfstests-dev/results//generic/633.out.bad'=C2=A0 to=20
>> > > > > > see the
>> > > > > > entire
>> > > > > > diff)
>> > > > > > Ran: generic/633
>> > > > > > Failures: generic/633
>> > > > > > Failed 1 of 1 tests
>> > > > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> > > > > >
>> > > > > > The failed test is about setgid inheritance.
>> > > > > > When=C2=A0 a file is created with S_ISGID in the directory=20
>> > > > > > with
>> > > > > > S_ISGID,
>> > > > > > NFS=C2=A0 doesn't strip the=C2=A0 setgid bit of the new create=
d=20
>> > > > > > file but
>> > > > > > others
>> > > > > > (ext4/xfs/btrfs) do.=C2=A0 They call inode_init_owner()=20
>> > > > > > which does
>> > > > > > the strip after new_inode().
>> > > > > > However, NFS has its own logical to handle inode=20
>> > > > > > capacities.
>> > > > > > As the test says the behavior can be filesystem type=20
>> > > > > > specific,
>> > > > > > I'd report to you NFS guys and ask whether it's a bug=20
>> > > > > > or not?
>> > > > >
>> > > > > Thanks for the report. I'm not sure why NFS would have=20
>> > > > > different
>> > > > > rules
>> > > > > for setgid inheritance. So I'm inclined to think that=20
>> > > > > this is
>> > > > > simply
>> > > > > a
>> > > > > bug similar to what we saw in xfs and ceph. But I'll=20
>> > > > > let the NFS
>> > > > > folks
>> > > > > determine that.
>> > > > >
>> > > > > XFS is only special in so far as it has a sysctl that=20
>> > > > > lets it
>> > > > > alter
>> > > > > sgid
>> > > > > inheritance behavior. And it only has that to allow for=20
>> > > > > legacy
>> > > > > irix
>> > > > > semantics iiuc.
>> > > >
>> > > > OK, so how do you expect this 'idmapped-mounts'=20
>> > > > functionality to
>> > > > work
>> > > > on NFS? I'm not asking about this bug in particular. I'm=20
>> > > > asking
>> > > > about
>> > > > what this is supposed to do in general.
>> > >
>> > > Just to clarify, the bug has nothing to do with idmapped=20
>> > > mounts. The
>> > > idmapped mount testsuite always had a vfs generic part.=20
>> > > That vfs
>> > > generic
>> > > part has been made available to all filesystems supporting=20
>> > > xfstests a
>> > > few weeks ago. (So far this setgid inheritance bug here has=20
>> > > been
>> > > present
>> > > in 3 filesystems.)
>> >
>> > The setgid stuff works just fine with regular use, when the=20
>> > server is
>> > able to determine when to clear the bit. It only breaks with=20
>> > this kind
>> > of test where the server is being lied to by the client's=20
>> > upper layers.
>>
>> I think you misunderstand: it is not possible to create=20
>> idmapped mounts
>> for a mounted NFS client. In order for a filesystem to support=20
>> idmapped
>> mounts it must set FS_ALLOW_IDMAP which currently only btrfs,=20
>> ext4, fat,
>> and xfs do. The failing test does not use idmapped mounts in=20
>> any way.
>
> Ok, I dug into this yesterday.
> If a new file or directory is created in a setgid directory then=20
> regular
> files and directories will inherit their group ID from the=20
> parent
> directory.
> But NFS makes any files created by the root user be owned nobody=20
> and
> nogroup. The test expects the newly created file and directory=20
> in the
> setgid directory to be owned gid 0 but since NFS squashes that=20
> to
> nogroup the test fails.
> If I add no_root_squash solely for the sake of the test to the=20
> exported
> directory the test passes.
>
No wonder! I hadn't noticed the behavior before and thought it's
a NFS bug.

> So similar to xfs irix mode this is filesystem specific=20
> behavior. I'll
> make sure to send a patch to xfstests and we'll skip the tests=20
> on nfs
> for now.
>
Thanks a lot! Being embarrassed for pushing my fix duty to you.
I should be more patience in digging deeper before report :-)

--
Su
> I'm appending a trimmed down version of the test if anyone wants=20
> to
> verify (see [1]).
>
> Thanks!
>
> [1]: (Requires libcap-dev to be installed. Compile with gcc=20
> <file> -o <binary> -lcap and run as root.)
>
> #define _GNU_SOURCE
> #include <dirent.h>
> #include <errno.h>
> #include <fcntl.h>
> #include <getopt.h>
> #include <grp.h>
> #include <limits.h>
> #include <linux/limits.h>
> #include <linux/types.h>
> #include <pthread.h>
> #include <pwd.h>
> #include <sched.h>
> #include <stdbool.h>
> #include <stdio.h>
> #include <stdlib.h>
> #include <sys/capability.h>
> #include <sys/eventfd.h>
> #include <sys/fsuid.h>
> #include <sys/mount.h>
> #include <sys/prctl.h>
> #include <sys/socket.h>
> #include <sys/stat.h>
> #include <sys/types.h>
> #include <sys/wait.h>
> #include <sys/xattr.h>
> #include <unistd.h>
>
> #define FILE1 "file1"
> #define DIR1 "dir1"
>
> #define log_stderr(format, ...)=20
> \
>         fprintf(stderr, "%s: %d: %s - %m - " format "\n",=20
>         __FILE__, __LINE__, __func__, \
>                 ##__VA_ARGS__)
>
> #define log_error_errno(__ret__, __errno__, format, ...)      \
>         ({                                                    \
>                 typeof(__ret__) __internal_ret__ =3D (__ret__); \
>                 errno =3D (__errno__);                          \
>                 log_stderr(format, ##__VA_ARGS__);            \
>                 __internal_ret__;                             \
>         })
>
> #define log_errno(__ret__, format, ...) log_error_errno(__ret__,=20
> errno, format, ##__VA_ARGS__)
>
> #define die_errno(__errno__, format, ...)          \
>         ({                                         \
>                 errno =3D (__errno__);               \
>                 log_stderr(format, ##__VA_ARGS__); \
>                 exit(EXIT_FAILURE);                \
>         })
>
> #define die(format, ...) die_errno(errno, format, ##__VA_ARGS__)
>
> #define syserror(format, ...)                           \
>         ({                                              \
>                 fprintf(stderr, "%m - " format "\n",=20
>                 ##__VA_ARGS__); \
>                 (-errno);                               \
>         })
>
> #define syserror_set(__ret__, format, ...)                    \
>         ({                                                    \
>                 typeof(__ret__) __internal_ret__ =3D (__ret__); \
>                 errno =3D labs(__ret__);                        \
>                 fprintf(stderr, "%m - " format "\n",=20
>                 ##__VA_ARGS__);       \
>                 __internal_ret__;                             \
>         })
>
> bool switch_ids(uid_t uid, gid_t gid)
> {
>         if (setgroups(0, NULL))
>                 return syserror_set(-1, "failure: setgroups");
>
>         if (setresgid(gid, gid, gid))
>                 return syserror_set(-1, "failure: setresgid");
>
>         if (setresuid(uid, uid, uid))
>                 return syserror_set(-1, "failure: setresuid");
>
>         return true;
> }
>
> /* is_setgid - check whether file or directory is S_ISGID */
> static bool is_setgid(int dfd, const char *path, int flags)
> {
>         int ret;
>         struct stat st;
>
>         ret =3D fstatat(dfd, path, &st, flags);
>         if (ret < 0)
>                 return false;
>
>         errno =3D 0; /* Don't report misleading errno. */
>         return (st.st_mode & S_ISGID);
> }
>
> /* __expected_uid_gid - check whether file is owned by the=20
> provided uid and gid */
> static bool __expected_uid_gid(int dfd, const char *path, int=20
> flags,
>                                uid_t expected_uid, gid_t=20
>                                expected_gid, bool log)
> {
>         int ret;
>         struct stat st;
>
>         ret =3D fstatat(dfd, path, &st, flags);
>         if (ret < 0)
>                 return log_errno(false, "failure: fstatat");
>
>         if (log && st.st_uid !=3D expected_uid)
>                 log_stderr("failure: uid(%d) !=3D=20
>                 expected_uid(%d)", st.st_uid, expected_uid);
>
>         if (log && st.st_gid !=3D expected_gid)
>                 log_stderr("failure: gid(%d) !=3D=20
>                 expected_gid(%d)", st.st_gid, expected_gid);
>
>         errno =3D 0; /* Don't report misleading errno. */
>         return st.st_uid =3D=3D expected_uid && st.st_gid =3D=3D=20
>         expected_gid;
> }
>
> static bool expected_uid_gid(int dfd, const char *path, int=20
> flags,
>                              uid_t expected_uid, gid_t=20
>                              expected_gid)
> {
>         return __expected_uid_gid(dfd, path, flags,
>                                   expected_uid, expected_gid,=20
>                                   true);
> }
>
> int wait_for_pid(pid_t pid)
> {
>         int status, ret;
>
> again:
>         ret =3D waitpid(pid, &status, 0);
>         if (ret =3D=3D -1) {
>                 if (errno =3D=3D EINTR)
>                         goto again;
>
>                 return -1;
>         }
>
>         if (!WIFEXITED(status))
>                 return -1;
>
>         return WEXITSTATUS(status);
> }
>
> static int caps_down(void)
> {
>         bool fret =3D false;
>         cap_t caps =3D NULL;
>         int ret =3D -1;
>
>         caps =3D cap_get_proc();
>         if (!caps)
>                 goto out;
>
>         ret =3D cap_clear_flag(caps, CAP_EFFECTIVE);
>         if (ret)
>                 goto out;
>
>         ret =3D cap_set_proc(caps);
>         if (ret)
>                 goto out;
>
>         fret =3D true;
>
> out:
>         cap_free(caps);
>         return fret;
> }
>
> int main(int argc, char *argv[])
> {
>         int file1_fd =3D -EBADF, t_dir1_fd =3D -EBADF;
>         pid_t pid;
>
> 	if (argc < 1)
> 		exit(1);
>
> 	t_dir1_fd =3D open(argv[1], O_CLOEXEC | O_DIRECTORY);
> 	if (t_dir1_fd < 0)
> 		die("open");
>
> 	if (fchmod(t_dir1_fd, S_IRUSR |
>                               S_IWUSR |
>                               S_IRGRP |
>                               S_IWGRP |
>                               S_IROTH |
>                               S_IWOTH |
>                               S_IXUSR |
>                               S_IXGRP |
>                               S_IXOTH |
>                               S_ISGID), 0) {
>                 die("failure: fchmod");
>         }
>
>         /* Verify that the setgid bit got raised. */
>         if (!is_setgid(t_dir1_fd, "", AT_EMPTY_PATH)) {
>                 die("failure: is_setgid");
>         }
>
> 	pid =3D fork();
>         if (pid < 0) {
> 		exit(1);
>         }
>
> #define UID 1000
> #define GID 0 /* Will fail on NFS without no_root_squash set. */
> 	if (pid =3D=3D 0) {
> 		if (!switch_ids(UID, 10000))
>                         die("failure: switch_ids");
>
> 		if (!caps_down())
> 			die("failure: caps_down");
>
> 		/* create regular file via open() */
>                 file1_fd =3D openat(t_dir1_fd, FILE1, O_CREAT |=20
>                 O_EXCL | O_CLOEXEC, S_IXGRP | S_ISGID);
>                 if (file1_fd < 0)
>                         die("failure: create");
>
>                 /* Neither in_group_p() nor=20
>                 capable_wrt_inode_uidgid() so setgid
>                  * bit needs to be stripped.
>                  */
>                 if (is_setgid(t_dir1_fd, FILE1, 0))
>                         die("failure: is_setgid");
>
>                 /* create directory */
>                 if (mkdirat(t_dir1_fd, DIR1, 0000))
>                         die("failure: create");
>
> 		/* Directories always inherit the setgid bit. */
> 		if (!is_setgid(t_dir1_fd, DIR1, 0))
> 			die("failure: is_setgid");
>
>                 /*
>                  * In setgid directories newly created files=20
>                  always inherit the
>                  * gid from the parent directory. Verify that=20
>                  the file is owned
>                  * by GID, not by gid 10000.
>                  */
>                 if (!expected_uid_gid(t_dir1_fd, FILE1, 0, UID,=20
>                 GID))
>                         die("failure: check ownership");
>
>                 /*
>                  * In setgid directories newly created=20
>                  directories always
>                  * inherit the gid from the parent directory.=20
>                  Verify that the
>                  * directory is owned by GID, not by gid 10000.
>                  */
>                 if (!expected_uid_gid(t_dir1_fd, DIR1, 0, UID,=20
>                 GID))
>                         die("failure: check ownership");
>
> 		exit(EXIT_SUCCESS);
> 	}
>
> 	  if (wait_for_pid(pid))
> 		  die("FAIL");
>
> 	exit(0);
> }
