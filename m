Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A93D5164D52
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Feb 2020 19:07:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbgBSSHV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 19 Feb 2020 13:07:21 -0500
Received: from fieldses.org ([173.255.197.46]:43642 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726514AbgBSSHV (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 19 Feb 2020 13:07:21 -0500
Received: by fieldses.org (Postfix, from userid 2815)
        id 289DF1C97; Wed, 19 Feb 2020 13:07:20 -0500 (EST)
Date:   Wed, 19 Feb 2020 13:07:20 -0500
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     smayhew@redhat.com, paul@paul-moore.com, sds@tycho.nsa.gov,
        selinux@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: Test to trace NFS unlabeled bug
Message-ID: <20200219180720.GA23275@fieldses.org>
References: <db2a9d661ec9b53e01c029f98877a3556d8297bc.camel@btinternet.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db2a9d661ec9b53e01c029f98877a3556d8297bc.camel@btinternet.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Feb 19, 2020 at 06:03:02PM +0000, Richard Haines wrote:
> I've been building selinux-testsuite tests for various filesystems and
> have come across an unlabeled issue when testing. Stephen thinks that
> this is a bug sometimes seen with labeled NFS, where the top-level
> mounted directory shows up with unlabeled_t initially, then later gets
> refreshed to a valid context.
> 
> I've put together a test script, policy module and mount prog to
> facilitate debugging this issue. I've set out how I tested this on a
> Fedora 31 system below, if any problems let me know. 

Thanks!  Adding the nfs group to the cc.

I seem to recall a report of a similar bug in the Red Hat bugzilla, that
I spent a little time investigating and couldn't pin down.  I'll see if
I can dig that up.

--b.

> 
> The nfs.sh script:
> MOUNT=`stat --print %m .`
> TESTDIR=`pwd`
> systemctl start nfs-server
> exportfs -orw,no_root_squash,security_label localhost:$MOUNT
> mkdir -p /mnt/selinux-testsuite
> runcon -t test_nfs_unlabeled_bug ./mount -f nfs4 -s localhost:$TESTDIR
> -t /mnt/selinux-testsuite -o
> "nfsvers=4.2,proto=tcp,clientaddr=127.0.0.1,addr=127.0.0.1" -v
> umount /mnt/selinux-testsuite
> exportfs -u localhost:$MOUNT
> systemctl stop nfs-server
> 
> Install mount.c, unlabeled_bug.te and nfs.sh
> 
> Build mount prog:
> cc mount.c -o mount -Wall
> Then:
> chcon -t bin_t ./mount
> 
> Build policy module and install:
> make -f /usr/share/selinux/devel/Makefile unlabeled_bug.pp
> semodule -i unlabeled_bug.pp
> 
> Clean audit log:
> > /var/log/audit/audit.log
> 
> run ./nfs.sh
> 
> Check audit log:
> audit2allow -p /etc/selinux/targeted/policy/policy.31 <
> /var/log/audit/audit.log
> 
> Should see:
> #============= test_nfs_unlabeled_bug ==============
> allow test_nfs_unlabeled_bug unlabeled_t:dir search;
> 
> Once done:
> semodule -r unlabeled_bug

> /* cc mount.c -o mount -Wall */
> #include <stdio.h>
> #include <stdlib.h>
> #include <string.h>
> #include <unistd.h>
> #include <errno.h>
> #include <stdbool.h>
> #include <sys/mount.h>
> 
> static void print_usage(char *progname)
> {
> 	fprintf(stderr,
> 		"usage:  %s [-s src] -t tgt [-f fs_type] [-o options]\n"
> 		"Where:\n\t"
> 		"-s  Source path\n\t"
> 		"-t  Target path\n\t"
> 		"-f  Filesystem type\n\t"
> 		"-o  Options list (comma separated list)\n\t"
> 		"-v  Print information.\n", progname);
> 	exit(-1);
> }
> 
> int main(int argc, char *argv[])
> {
> 	int opt, result, save_err, flags = 0;
> 	char *src = NULL, *tgt = NULL, *fs_type = NULL, *opts = NULL;
> 	bool verbose = false;
> 
> 	while ((opt = getopt(argc, argv, "s:t:f:o:v")) != -1) {
> 		switch (opt) {
> 		case 's':
> 			src = optarg;
> 			break;
> 		case 't':
> 			tgt = optarg;
> 			break;
> 		case 'f':
> 			fs_type = optarg;
> 			break;
> 		case 'o':
> 			opts = optarg;
> 			break;
> 		case 'v':
> 			verbose = true;
> 			break;
> 		default:
> 			print_usage(argv[0]);
> 		}
> 	}
> 
> 	if (!tgt)
> 		print_usage(argv[0]);
> 
> 	if (verbose)
> 		printf("Mounting\n\tsrc: %s\n\ttgt: %s\n\tfs_type: %s flags: 0x%x\n\topts: %s\n",
> 		       src, tgt, fs_type, flags, opts);
> 
> 	result = mount(src, tgt, fs_type, flags, opts);
> 	save_err = errno;
> 	if (result < 0) {
> 		fprintf(stderr, "Failed mount(2): %s\n", strerror(errno));
> 		return save_err;
> 	}
> 
> 	return 0;
> }


> 
> policy_module(unlabeled_bug, 1.0)
> 
> require {
> 	role unconfined_r;
> 	type bin_t,user_devpts_t,nfs_t,kernel_t;
> 	class file { entrypoint execute read };
> 	class capability { sys_admin };
> 	class system { module_request };
> 	class chr_file { append getattr read write };
> 	class dir { search };
> 	class filesystem { mount };
> }
> 
> #============= test_nfs_unlabeled_bug ==============
> type test_nfs_unlabeled_bug;
> role unconfined_r types test_nfs_unlabeled_bug;
> files_type(test_nfs_unlabeled_bug)
> domain_type(test_nfs_unlabeled_bug)
> allow test_nfs_unlabeled_bug bin_t:file { entrypoint execute read };
> files_mounton_default(test_nfs_unlabeled_bug)
> allow test_nfs_unlabeled_bug bin_t:file map;
> allow test_nfs_unlabeled_bug default_t:dir mounton;
> allow test_nfs_unlabeled_bug self:capability sys_admin;
> allow test_nfs_unlabeled_bug kernel_t:system module_request;
> allow test_nfs_unlabeled_bug nfs_t:dir search;
> allow test_nfs_unlabeled_bug nfs_t:filesystem mount;
> allow test_nfs_unlabeled_bug user_devpts_t:chr_file { append getattr read write };
> 
> #allow test_nfs_unlabeled_bug unlabeled_t:dir search;
> 

