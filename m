Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 721CA4C2707
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Feb 2022 10:01:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbiBXIxO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 24 Feb 2022 03:53:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbiBXIxO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 24 Feb 2022 03:53:14 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4ABC162020
        for <linux-nfs@vger.kernel.org>; Thu, 24 Feb 2022 00:52:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id E63C6CE1CEB
        for <linux-nfs@vger.kernel.org>; Thu, 24 Feb 2022 08:52:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFE79C340F0;
        Thu, 24 Feb 2022 08:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645692758;
        bh=GF1UbpmIqfL5uod5YAKCVHna/7N6KaWSUEtEnztFc3Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CXNJ1QrtGiyqIf9TDT2YfqhL7o/3Pd0hsCwlOzcOQgoQIilgv/or93p3+xf5KLOr0
         Mc9h4dKPn+Q+XLXgL3uiH4p0HlQ0Y1wAey/bjsQ0hMH4jz1SBc0lxBzhQ8GcswDg1g
         jI8oEdH7GA1Iv+eVnvzETnNUZi5fFToA3SLZstk0qeeAWx3bGIm2sTwI5iFJg2x1H0
         6UuEd09zhOejMKKcbGCclEJUxH89TPo0R4vxMxmUqprflAn8zGfcxOOY1NLcFsJqH+
         i387q80nh3vZbwKqTKaV7Nfj6ST13bsTIJDfRq2OGt4icyMXVYmjX42Xp5Hl4iIpyo
         5Cf/fCq/jAKwQ==
Date:   Thu, 24 Feb 2022 09:52:33 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "suy.fnst@fujitsu.com" <suy.fnst@fujitsu.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "l@damenly.su" <l@damenly.su>
Subject: Re: [bug?] nfs setgid inheritance
Message-ID: <20220224085233.ojnqly7bbk2pnqzp@wittgenstein>
References: <OS3PR01MB770539462BE3E7959DAF8B5789389@OS3PR01MB7705.jpnprd01.prod.outlook.com>
 <20220219113412.7ov4tbkisv4vnmo3@wittgenstein>
 <55aef6aa0e1825c1709051091c7bf849fccbda32.camel@hammerspace.com>
 <20220223084425.uq75dqfwymgfayus@wittgenstein>
 <be3b341c4f0cf177b78f55de70cdb3a15ed808f4.camel@hammerspace.com>
 <20220223160926.iidztq5nf3wssw4m@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220223160926.iidztq5nf3wssw4m@wittgenstein>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Feb 23, 2022 at 05:09:26PM +0100, Christian Brauner wrote:
> On Wed, Feb 23, 2022 at 12:24:02PM +0000, Trond Myklebust wrote:
> > On Wed, 2022-02-23 at 09:44 +0100, Christian Brauner wrote:
> > > On Sat, Feb 19, 2022 at 05:00:18PM +0000, Trond Myklebust wrote:
> > > > On Sat, 2022-02-19 at 12:34 +0100, Christian Brauner wrote:
> > > > > On Sat, Feb 19, 2022 at 08:34:30AM +0000,
> > > > > suy.fnst@fujitsu.com wrote:
> > > > > > Hi NFS folks,
> > > > > >   During our xfstests, we found generic/633 fails like:
> > > > > > ============================================
> > > > > > FSTYP         -- nfs
> > > > > > PLATFORM      -- Linux/x86_64 btrfs 5.17.0-rc4-custom #236 SMP
> > > > > > PREEMPT Sat Feb 19 15:09:03 CST 2022
> > > > > > MKFS_OPTIONS  -- 127.0.0.1:/nfsscratch
> > > > > > MOUNT_OPTIONS -- -o vers=4 127.0.0.1:/nfsscratch /mnt/scratch
> > > > > > 
> > > > > > generic/633 0s ... [failed, exit status 1]- output mismatch
> > > > > > (see
> > > > > > /root/xfstests-dev/results//generic/633.out.bad)
> > > > > >     --- tests/generic/633.out   2021-05-23 14:03:08.879999997
> > > > > > +0800
> > > > > >     +++ /root/xfstests-dev/results//generic/633.out.bad 2022-
> > > > > > 02-19
> > > > > > 16:31:28.660000013 +0800
> > > > > >     @@ -1,2 +1,4 @@
> > > > > >      QA output created by 633
> > > > > >      Silence is golden
> > > > > >     +idmapped-mounts.c: 7906: setgid_create - Success -
> > > > > > failure:
> > > > > > is_setgid
> > > > > >     +idmapped-mounts.c: 13907: run_test - Success - failure:
> > > > > > create
> > > > > > operations in directories with setgid bit set
> > > > > >     ...
> > > > > >     (Run 'diff -u /root/xfstests-dev/tests/generic/633.out
> > > > > > /root/xfstests-dev/results//generic/633.out.bad'  to see the
> > > > > > entire
> > > > > > diff)
> > > > > > Ran: generic/633
> > > > > > Failures: generic/633
> > > > > > Failed 1 of 1 tests
> > > > > > ============================================
> > > > > > 
> > > > > > The failed test is about setgid inheritance. 
> > > > > > When  a file is created with S_ISGID in the directory with
> > > > > > S_ISGID,
> > > > > > NFS  doesn't strip the  setgid bit of the new created file but
> > > > > > others
> > > > > > (ext4/xfs/btrfs) do.  They call inode_init_owner() which does
> > > > > > the strip after new_inode().
> > > > > > However, NFS has its own logical to handle inode capacities. 
> > > > > > As the test says the behavior can be filesystem type specific,
> > > > > > I'd report to you NFS guys and ask whether it's a bug or not?
> > > > > 
> > > > > Thanks for the report. I'm not sure why NFS would have different
> > > > > rules
> > > > > for setgid inheritance. So I'm inclined to think that this is
> > > > > simply
> > > > > a
> > > > > bug similar to what we saw in xfs and ceph. But I'll let the NFS
> > > > > folks
> > > > > determine that.
> > > > > 
> > > > > XFS is only special in so far as it has a sysctl that lets it
> > > > > alter
> > > > > sgid
> > > > > inheritance behavior. And it only has that to allow for legacy
> > > > > irix
> > > > > semantics iiuc.
> > > > 
> > > > OK, so how do you expect this 'idmapped-mounts' functionality to
> > > > work
> > > > on NFS? I'm not asking about this bug in particular. I'm asking
> > > > about
> > > > what this is supposed to do in general.
> > > 
> > > Just to clarify, the bug has nothing to do with idmapped mounts. The
> > > idmapped mount testsuite always had a vfs generic part. That vfs
> > > generic
> > > part has been made available to all filesystems supporting xfstests a
> > > few weeks ago. (So far this setgid inheritance bug here has been
> > > present
> > > in 3 filesystems.)
> > 
> > The setgid stuff works just fine with regular use, when the server is
> > able to determine when to clear the bit. It only breaks with this kind
> > of test where the server is being lied to by the client's upper layers.
> 
> I think you misunderstand: it is not possible to create idmapped mounts
> for a mounted NFS client. In order for a filesystem to support idmapped
> mounts it must set FS_ALLOW_IDMAP which currently only btrfs, ext4, fat,
> and xfs do. The failing test does not use idmapped mounts in any way.

Ok, I dug into this yesterday.
If a new file or directory is created in a setgid directory then regular
files and directories will inherit their group ID from the parent
directory.
But NFS makes any files created by the root user be owned nobody and
nogroup. The test expects the newly created file and directory in the
setgid directory to be owned gid 0 but since NFS squashes that to
nogroup the test fails.
If I add no_root_squash solely for the sake of the test to the exported
directory the test passes.

So similar to xfs irix mode this is filesystem specific behavior. I'll
make sure to send a patch to xfstests and we'll skip the tests on nfs
for now.

I'm appending a trimmed down version of the test if anyone wants to
verify (see [1]).

Thanks!

[1]: (Requires libcap-dev to be installed. Compile with gcc <file> -o <binary> -lcap and run as root.)

#define _GNU_SOURCE
#include <dirent.h>
#include <errno.h>
#include <fcntl.h>
#include <getopt.h>
#include <grp.h>
#include <limits.h>
#include <linux/limits.h>
#include <linux/types.h>
#include <pthread.h>
#include <pwd.h>
#include <sched.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/capability.h>
#include <sys/eventfd.h>
#include <sys/fsuid.h>
#include <sys/mount.h>
#include <sys/prctl.h>
#include <sys/socket.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <sys/xattr.h>
#include <unistd.h>

#define FILE1 "file1"
#define DIR1 "dir1"

#define log_stderr(format, ...)                                                         \
        fprintf(stderr, "%s: %d: %s - %m - " format "\n", __FILE__, __LINE__, __func__, \
                ##__VA_ARGS__)

#define log_error_errno(__ret__, __errno__, format, ...)      \
        ({                                                    \
                typeof(__ret__) __internal_ret__ = (__ret__); \
                errno = (__errno__);                          \
                log_stderr(format, ##__VA_ARGS__);            \
                __internal_ret__;                             \
        })

#define log_errno(__ret__, format, ...) log_error_errno(__ret__, errno, format, ##__VA_ARGS__)

#define die_errno(__errno__, format, ...)          \
        ({                                         \
                errno = (__errno__);               \
                log_stderr(format, ##__VA_ARGS__); \
                exit(EXIT_FAILURE);                \
        })

#define die(format, ...) die_errno(errno, format, ##__VA_ARGS__)

#define syserror(format, ...)                           \
        ({                                              \
                fprintf(stderr, "%m - " format "\n", ##__VA_ARGS__); \
                (-errno);                               \
        })

#define syserror_set(__ret__, format, ...)                    \
        ({                                                    \
                typeof(__ret__) __internal_ret__ = (__ret__); \
                errno = labs(__ret__);                        \
                fprintf(stderr, "%m - " format "\n", ##__VA_ARGS__);       \
                __internal_ret__;                             \
        })

bool switch_ids(uid_t uid, gid_t gid)
{
        if (setgroups(0, NULL))
                return syserror_set(-1, "failure: setgroups");

        if (setresgid(gid, gid, gid))
                return syserror_set(-1, "failure: setresgid");

        if (setresuid(uid, uid, uid))
                return syserror_set(-1, "failure: setresuid");

        return true;
}

/* is_setgid - check whether file or directory is S_ISGID */
static bool is_setgid(int dfd, const char *path, int flags)
{
        int ret;
        struct stat st;

        ret = fstatat(dfd, path, &st, flags);
        if (ret < 0)
                return false;

        errno = 0; /* Don't report misleading errno. */
        return (st.st_mode & S_ISGID);
}

/* __expected_uid_gid - check whether file is owned by the provided uid and gid */
static bool __expected_uid_gid(int dfd, const char *path, int flags,
                               uid_t expected_uid, gid_t expected_gid, bool log)
{
        int ret;
        struct stat st;

        ret = fstatat(dfd, path, &st, flags);
        if (ret < 0)
                return log_errno(false, "failure: fstatat");

        if (log && st.st_uid != expected_uid)
                log_stderr("failure: uid(%d) != expected_uid(%d)", st.st_uid, expected_uid);

        if (log && st.st_gid != expected_gid)
                log_stderr("failure: gid(%d) != expected_gid(%d)", st.st_gid, expected_gid);

        errno = 0; /* Don't report misleading errno. */
        return st.st_uid == expected_uid && st.st_gid == expected_gid;
}

static bool expected_uid_gid(int dfd, const char *path, int flags,
                             uid_t expected_uid, gid_t expected_gid)
{
        return __expected_uid_gid(dfd, path, flags,
                                  expected_uid, expected_gid, true);
}

int wait_for_pid(pid_t pid)
{
        int status, ret;

again:
        ret = waitpid(pid, &status, 0);
        if (ret == -1) {
                if (errno == EINTR)
                        goto again;

                return -1;
        }

        if (!WIFEXITED(status))
                return -1;

        return WEXITSTATUS(status);
}

static int caps_down(void)
{
        bool fret = false;
        cap_t caps = NULL;
        int ret = -1;

        caps = cap_get_proc();
        if (!caps)
                goto out;

        ret = cap_clear_flag(caps, CAP_EFFECTIVE);
        if (ret)
                goto out;

        ret = cap_set_proc(caps);
        if (ret)
                goto out;

        fret = true;

out:
        cap_free(caps);
        return fret;
}

int main(int argc, char *argv[])
{
        int file1_fd = -EBADF, t_dir1_fd = -EBADF;
        pid_t pid;

	if (argc < 1)
		exit(1);

	t_dir1_fd = open(argv[1], O_CLOEXEC | O_DIRECTORY);
	if (t_dir1_fd < 0)
		die("open");

	if (fchmod(t_dir1_fd, S_IRUSR |
                              S_IWUSR |
                              S_IRGRP |
                              S_IWGRP |
                              S_IROTH |
                              S_IWOTH |
                              S_IXUSR |
                              S_IXGRP |
                              S_IXOTH |
                              S_ISGID), 0) {
                die("failure: fchmod");
        }

        /* Verify that the setgid bit got raised. */
        if (!is_setgid(t_dir1_fd, "", AT_EMPTY_PATH)) {
                die("failure: is_setgid");
        }

	pid = fork();
        if (pid < 0) {
		exit(1);
        }

#define UID 1000
#define GID 0 /* Will fail on NFS without no_root_squash set. */
	if (pid == 0) {
		if (!switch_ids(UID, 10000))
                        die("failure: switch_ids");

		if (!caps_down())
			die("failure: caps_down");

		/* create regular file via open() */
                file1_fd = openat(t_dir1_fd, FILE1, O_CREAT | O_EXCL | O_CLOEXEC, S_IXGRP | S_ISGID);
                if (file1_fd < 0)
                        die("failure: create");

                /* Neither in_group_p() nor capable_wrt_inode_uidgid() so setgid
                 * bit needs to be stripped.
                 */
                if (is_setgid(t_dir1_fd, FILE1, 0))
                        die("failure: is_setgid");

                /* create directory */
                if (mkdirat(t_dir1_fd, DIR1, 0000))
                        die("failure: create");

		/* Directories always inherit the setgid bit. */
		if (!is_setgid(t_dir1_fd, DIR1, 0))
			die("failure: is_setgid");

                /*
                 * In setgid directories newly created files always inherit the
                 * gid from the parent directory. Verify that the file is owned
                 * by GID, not by gid 10000.
                 */
                if (!expected_uid_gid(t_dir1_fd, FILE1, 0, UID, GID))
                        die("failure: check ownership");

                /*
                 * In setgid directories newly created directories always
                 * inherit the gid from the parent directory. Verify that the
                 * directory is owned by GID, not by gid 10000.
                 */
                if (!expected_uid_gid(t_dir1_fd, DIR1, 0, UID, GID))
                        die("failure: check ownership");

		exit(EXIT_SUCCESS);
	}

	  if (wait_for_pid(pid))
		  die("FAIL");

	exit(0);
}
